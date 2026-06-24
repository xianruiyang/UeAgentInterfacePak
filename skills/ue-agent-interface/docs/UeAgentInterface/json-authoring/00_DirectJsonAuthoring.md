# Direct JSON Authoring And Catalog Seed Chain

本页是 LLM 执行结构化 JSON 编辑的主入口。默认策略是：**直接编辑导出的 authoring JSON**，只在需要参数化批处理、批量生成、adapter 调试或重复变量过多时才写 Python 脚本辅助。Python 不能替代 JSON 意图本身。

本页只描述 UAI 结构化 JSON 内部链路；字段语义以本地 UAI 源码、adapter/profile、正式命令文档和实测 readback 为准，不使用 KB 或网络推断。

## 主链路

```text
确认资产和 profile
-> export/readback 当前 JSON
-> 如需新增节点/模块/组件/控件/输入来源，先 node_catalog_search
-> 可选 node_origin_resolve 查看资产或源码路径
-> 直接把 json_authoring 或 seed 写入 authoring JSON
-> 编辑普通 value/connection/layout/properties
-> validate/lint/adapter/apply
-> export/readback/compile/probe 验证
-> 可选从 JSON 指针 node_origin_resolve 反查来源
```

执行规则：

1. 先导出真实资产结构，再在 `authoring` 或 `minimal_authoring` 上改。
2. 新增候选必须来自 `node_catalog_search`，分类不明确时先 `node_catalog_categories`。
3. `node_catalog_search.items[].kind/name/full_name` 是查询、写 JSON、来源解析三者的统一身份。
4. 可以直接把 `items[].json_authoring` 整个对象放入它的 `profile_path` 目标位置；也可以只复制 `items[].json_authoring.seed`。
5. 新增时只写最小 authoring 结果：身份、必要 parent/context/selector、必要 `operation`，以及用户明确要改的值、连接、布局或属性。
6. 不要手写完整 readback 对象；真实 id、template、slot、pin、默认属性、generated/readback/diagnostics 字段由 apply 后的 UE/UAI 补齐。
7. 只写 `name` 不稳定；稳定写入必须带 `full_name`。
8. `node_origin_resolve` 只返回路径和解析状态；它用于理解候选或 JSON 中已有节点，不执行打开 IDE、聚焦内容浏览器或 UI 操作。
9. apply 成功后必须重新 export/readback；后续编辑以读回的新结构为依据继续。

## 统一身份字段

所有新教程和新 JSON authoring 主路径使用：

```json
{
  "kind": "material_expression",
  "name": "Multiply",
  "full_name": "/Script/Engine.MaterialExpressionMultiply"
}
```

字段含义：

| 字段 | 用途 | 是否稳定写入依据 |
| --- | --- | --- |
| `kind` | 说明候选类型和 adapter 路由。 | 是 |
| `name` | UE 右键/Palette 同源英文名称；供 LLM 阅读、搜索、生成默认本地 id。 | 否 |
| `full_name` | 当前 UE 对象、类、函数、属性或资产的稳定解析路径。 | 是 |

旧字段如 `script_asset_path`、`component_class`、`widget_class`、`node_class`、`function_name`、`module_script_path` 只作为 adapter 兼容、legacy readback 或迁移输入；新 authoring 不把它们作为主入口。

## Catalog Seed 形态

`node_catalog_search.items[].json_authoring` 是 authoring seed，不是 legacy patch：

```json
{
  "schema": "uai.catalog_authoring_seed.v1",
  "route": "material_authoring_profile",
  "target": "material.graph.nodes[]",
  "profile_path": "material_graph.nodes[]",
  "readback_after_apply": true,
  "seed": {
    "operation": "add",
    "kind": "material_expression",
    "name": "Multiply",
    "full_name": "/Script/Engine.MaterialExpressionMultiply",
    "properties": {}
  }
}
```

写法二选一：

```json
{
  "material_graph": {
    "nodes": [
      {
        "schema": "uai.catalog_authoring_seed.v1",
        "route": "material_authoring_profile",
        "target": "material.graph.nodes[]",
        "profile_path": "material_graph.nodes[]",
        "readback_after_apply": true,
        "seed": {
          "operation": "add",
          "kind": "material_expression",
          "name": "Multiply",
          "full_name": "/Script/Engine.MaterialExpressionMultiply",
          "properties": {}
        }
      }
    ]
  }
}
```

或只复制 `seed`：

```json
{
  "material_graph": {
    "nodes": [
      {
        "operation": "add",
        "kind": "material_expression",
        "name": "Multiply",
        "full_name": "/Script/Engine.MaterialExpressionMultiply",
        "properties": {}
      }
    ]
  }
}
```

这两种写法都不是要求 LLM 补全完整对象。seed 只表达“要新增什么”；放置位置、父级、连线、layout 或初始属性只有在当前意图需要时才额外写入。

## 直接写入支持面

| catalog / kind | 可直接用于 JSON 补全 | 写入位置 | 补全与限制 |
| --- | --- | --- | --- |
| `actor_component` | 是 | `components[]` | adapter 用 `name` 生成默认 `component_id`，用 `full_name` 补 `component_class/class`，默认相对 transform；属性需后续编辑。 |
| `umg_widget` | 是 | `widget_tree.widgets[]` | adapter 用 `name` 生成默认 `widget_id`，用 `full_name` 补 `widget_class`；挂载关系写 `parent_widget_id`，slot/layout 需按父容器补。 |
| `material_expression` | 是 | `material_graph.nodes[]` | 创建 expression 节点；连线、root input、属性需另写。 |
| `material_function_call` | 是 | `material_graph.nodes[]` | 创建 Material Function Call 节点并用 `full_name` 指向函数资产；连线和参数仍需另写。 |
| `niagara_dynamic_input` | 是，但只作为 input value | `stages[].modules[].inputs[].value` | adapter 把 `dynamic_input.full_name` 转到当前 folder apply 需要的 legacy script path；子 input/data interface 需要 readback 后继续编辑。 |
| `blueprint_call_function` | 条件支持 | `blueprint_graphs[].nodes[]` | 可生成函数调用节点；必须有正确图上下文，pin default、连线和对象上下文通常还需补。 |
| `blueprint_event` | 条件支持 | `blueprint_graphs[].nodes[]` | 可生成事件节点；事件唯一性、绑定上下文和图类型会影响 apply/compile。 |
| `blueprint_variable_node` | 条件支持 | `blueprint_graphs[].nodes[]` | 变量必须存在；通常需要 `access` 或明确 get/set 语义。 |
| `blueprint_node` | 条件支持 | `blueprint_graphs[].nodes[]` | 泛型 action 可能需要更多上下文；检查 `write_support/support_reason` 和 compile/readback。 |
| `niagara_module` | 仅匹配已有导出 module | `stages[].modules[]` | 当前 adapter 用 seed 匹配已有 stack module 并编辑 input；目标 stage 没有该 module 时返回 `selector_not_found`，不能当成已新增。 |
| `niagara_graph_function` | seed 存在，需按 Niagara Script graph 路径验证 | `niagara_script` graph JSON | C++ search 会给 seed；实际写入以 `niagara_script_export_folder/apply_folder` 的图 JSON 和 readback/compile 为准。 |

判断可写时，以每个 item 的 `write_support` 和 `support_reason` 为准。`json_authoring` 表示有推荐 authoring seed，不表示可以省略目标上下文、连线、layout、properties 或编译验证。

## 查询候选

新增结构前先查候选：

```json
{
  "catalog_type": "actor_component",
  "query": { "text": "Static Mesh" },
  "page": { "limit": 5 }
}
```

从 pin 拉线查询时必须传真实上下文：

```json
{
  "catalog_type": "blueprint_node",
  "query": { "text": "print string" },
  "context": {
    "asset_path": "/Game/Blueprints/BP_Door",
    "graph_name": "EventGraph",
    "node_guid": "source-node-guid",
    "pin_guid": "source-pin-guid"
  },
  "page": { "limit": 20 }
}
```

分类不明确时：

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "location" },
  "filters": { "library_only": true }
}
```

## 写入示例

### Actor Component

把 `node_catalog_search(catalog_type=actor_component)` 返回的 `json_authoring` 或 `seed` 放入：

```json
{
  "components": [
    {
      "operation": "upsert",
      "kind": "actor_component",
      "name": "Static Mesh",
      "full_name": "/Script/Engine.StaticMeshComponent"
    }
  ]
}
```

### UMG Widget

```json
{
  "widget_tree": {
    "widgets": [
      {
        "operation": "upsert",
        "kind": "umg_widget",
        "name": "Button",
        "full_name": "/Script/UMG.Button",
        "parent_widget_id": "RootCanvas"
      }
    ]
  }
}
```

### Material Node

```json
{
  "material_graph": {
    "nodes": [
      {
        "operation": "add",
        "kind": "material_expression",
        "name": "Multiply",
        "full_name": "/Script/Engine.MaterialExpressionMultiply",
        "properties": {}
      }
    ]
  }
}
```

### Niagara Dynamic Input

```json
{
  "input_name": "Module.Offset",
  "type_info": "vector3",
  "value": {
    "source": "dynamic_input",
    "dynamic_input": {
      "kind": "niagara_dynamic_input",
      "name": "Random Range Vector",
      "full_name": "/Niagara/Functions/Random/RandomRangeVector.RandomRangeVector",
      "inputs": [],
      "data_interfaces": []
    }
  }
}
```

## 来源解析

刚搜索完候选或在 JSON 中看到 `kind/name/full_name` 后，如需理解含义，调用：

```json
{
  "target": {
    "source": "name_reference",
    "kind": "blueprint_call_function",
    "name": "Print String",
    "full_name": "/Script/Engine.KismetSystemLibrary.PrintString"
  }
}
```

从 JSON 文件反查：

```json
{
  "target": {
    "source": "json_reference",
    "json_file": "D:/project/tmp/uai_params/authoring.json",
    "json_pointer": "/blueprint_graphs/0/nodes/3"
  }
}
```

资产返回 asset/package path；native function 尽量返回本机源码 `path + line`。解析失败说明身份不足或当前环境缺源码/资产，不代表 JSON 可以靠猜继续写。

## 失败边界

以下情况必须停止或修正 JSON：

- 只有 `name`，没有 `full_name`。
- `json_authoring.profile_path` 与实际放置位置不一致。
- `write_support` 或 `support_reason` 表示当前 item 不能按目标用途写入。
- Blueprint/Material 从 pin 拉线搜索时没有传真实 pin context。
- Niagara module 不存在却直接把 module seed 当作新增 stack module 成功。
- `node_origin_resolve` 无法解析，但仍继续凭记忆补路径。
- apply 成功但 export/readback 没有出现目标对象、目标连接或目标值。

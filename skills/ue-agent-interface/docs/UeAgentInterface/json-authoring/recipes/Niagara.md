# Niagara JSON Authoring Recipe

本页只写 Niagara 特有规则。通用 input/value 写法先读 `../02_CommonInputValue.md`。

## 主要编辑对象

Niagara authoring 覆盖：

- System / Emitter stage。
- Module 增删改。
- Module input 值。
- UI source dropdown。
- Dynamic input。
- Data Interface curve。
- Renderer。
- Event handler。
- Parameter 链。

## Module / Node 发现原则

Niagara JSON 里所有 module、dynamic input、node 和 input 名都必须来自当前 UE 会话读回，不得凭记忆、UI 显示名或网络教程拼写。

标准取证顺序：

1. 用 `node_catalog_search(catalog_type=niagara_module/niagara_dynamic_input/niagara_graph_node)` 查真实候选；分类不明确时先 `node_catalog_categories`。
2. 需要理解候选含义时，用同一组 `kind/name/full_name` 调 `node_origin_resolve`，只读取资产/package/source 路径。
3. 用 `niagara*_export_folder` 导出目标资产，读取当前 stage/module/input 结构。
4. 用 `niagara_emitter_list_stages`、`niagara_emitter_list_stage_modules`、`niagara_emitter_list_stage_nodes`、`niagara_emitter_list_module_inputs` 或对应 `niagara_system_*` 读取 live Stack 细节。
5. 直接编辑 authoring JSON；新增或切换 dynamic input 时使用 `node_catalog_search` 返回的 `json_authoring` 或 `seed.kind/name/full_name`。
6. apply 后重新 export，确认 UE 补全后的真实字段、active branch、renderer binding、compile log 和 stack issue。

查询 Stack module 候选：

```json
{
  "catalog_type": "niagara_module",
  "query": { "text": "Ribbon" },
  "filters": { "library_only": true, "source": ["niagara", "game", "plugins"] },
  "page": { "limit": 50 }
}
```

使用返回的 `kind/name/full_name/json_authoring/write_support/support_reason` 写 JSON；`name` 只能作为阅读和默认本地 id，稳定写入必须依赖 `full_name`。Niagara module seed 当前只用于匹配已有导出的 module 并编辑 input；若目标 stage 中不存在该 module，adapter 会返回 `selector_not_found`，不能把它当成新增 stack module 成功。

查询 Dynamic Input / Function 下拉候选：

```json
{
  "catalog_type": "niagara_dynamic_input",
  "query": { "text": "Random Range" },
  "filters": { "library_only": true },
  "page": { "limit": 100 }
}
```

把候选的 `json_authoring` 直接放入某个 module input 的 `value`，或复制 `seed.dynamic_input.kind/name/full_name`。需要理解脚本内部含义时，先 `node_origin_resolve` 看资产路径，再按需用 `niagara_script_export_folder` 只读导出该 script 的图结构；不要修改引擎内置 script 资产。

## Module input 普通改值

普通改值只改 input 的 `value`。

Float：

```json
{
  "input_name": "Spawn Rate",
  "type_info": "float",
  "value": {
    "source": "local_value",
    "literal": 120.0
  }
}
```

Vector：

```json
{
  "input_name": "Module.Offset",
  "type_info": "vector3",
  "value": {
    "source": "local_value",
    "components": { "X": 0, "Y": 0, "Z": 50 }
  }
}
```

Enum：

```json
{
  "input_name": "Randomness Mode",
  "type_info": "enum",
  "allowed_values": [
    { "value": "NewEnumerator0", "display_label": "Simulation Defaults" },
    { "value": "NewEnumerator2", "display_label": "Non-Deterministic" }
  ],
  "value": {
    "source": "local_value",
    "selected": "NewEnumerator2"
  }
}
```

## UI Source Dropdown

Niagara input 右侧下拉不是普通 enum，它改变 input 来源。JSON 用 `value.source` 表达。

支持写入：

| source | 写法 | 当前状态 |
| --- | --- | --- |
| `local_value` | 同普通 value，写 `literal/selected/components/curve`。 | supported |
| `default_value` | `{ "source": "default_value" }`。 | supported |
| `linked_input` | `{ "source": "linked_input", "linked_parameter": "Particles.Velocity" }`。 | supported |
| `dynamic_input` | 写 `dynamic_input.kind/name/full_name` 或直接放入 catalog `json_authoring`。 | supported with catalog identity |
| `make` | 同 dynamic input，候选应为 Make 类 Niagara function。 | supported with catalog identity |
| `expression` | 目前明确失败。 | unsupported |
| `scratch_dynamic_input` | 目前明确失败；先创建真实 script asset 后再作为 dynamic input 选择。 | unsupported |

Linked input：

```json
{
  "input_name": "Module.Offset",
  "type_info": "vector3",
  "value": {
    "source": "linked_input",
    "linked_parameter": "Particles.Velocity"
  }
}
```

Dynamic input：

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

不能只写 `Random Range Vector` 这个 UI 显示名。adapter 需要能从 `full_name` 解析到真实 Niagara script asset path；旧 `script_asset_path/node_name` 仅保留兼容输入和 readback 证据。

## Curve

Dynamic input curve 投影为：

```json
{
  "input_name": "ScaleSpawnCountCurve",
  "type_info": "float_curve",
  "value": {
    "source": "dynamic_input",
    "curve": {
      "schema": "ue_agent_interface.curve.v1",
      "keys": [
        { "time": 0.0, "value": 0.0 },
        { "time": 1.0, "value": 1.0 }
      ]
    }
  }
}
```

如果当前没有可写 curve target，导出应写：

```json
{
  "value": { "source": "dynamic_input", "curve": null },
  "edit_state": "curve_target_missing"
}
```

遇到 `curve_target_missing` 不要凭空写曲线，先切到真实 dynamic input 并重新导出。

## Branch 和 mode

Niagara 很多输入受 mode、enum、static switch 控制。读回值存在不代表运行时使用它。

流程：

1. 先设置控制项，例如 size mode、coordinate space、renderer mode。
2. apply 后重新 export。
3. 确认目标 input 不再是 `hidden_or_inactive_branch`。
4. 再写分支内值。
5. 最后读 Stack issue、compile log 和必要的 runtime probe。

## 验证

Niagara apply 后至少检查：

- adapter report。
- apply response warning/error。
- export/readback 的目标 input。
- `link_kind` / `linked_parameter_name`，如果用了 linked input。
- dynamic input 的 `full_name`、解析后的脚本路径和子 input/data interface。
- Stack issue 和 compile log。
- 视觉行为相关时做 preview advance、runtime probe 或 screenshot。

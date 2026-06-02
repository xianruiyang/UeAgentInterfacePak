# 指令详解：Node Graph

本分册描述跨资产的通用节点图排布入口。这里的“节点图”特指横向的 **节点 + 接口/Pin + 连线** 图；竖向层级图、栈式编辑器和 UI 设计器布局不纳入本算法。

## 指令列表

| 指令 | 作用 | 关键参数 | 返回 |
|---|---|---|---|
| `node_graph_list` | 枚举一个资产内可由通用节点图排布入口识别的图 | `asset_path`、可选 `adapter`、`include_nested_graphs`、`graph_selector` | `asset_path`、`object_path`、`asset_class`、`adapter`、`graphs[]`、`graph_count` |
| `node_graph_layout` | 对一个资产内指定或批量选中的节点连线图执行自动排布 | `asset_path`、可选 `adapter`、`graph_selector`、`layout_options`、`compile_after_layout`、`save_after_layout` | `asset_path`、`adapter`、`graphs[]` 或 `nodes[]`、`changed`、`saved`、`node_count`、`edge_count`、`moved_node_count` |

## 支持范围

`adapter=auto` 是默认模式。命令会根据资产类型选择 adapter：

- `k2_blueprint`：普通 Blueprint、Level Blueprint、Blueprint Function Library、Macro Library、Interface 中实际存在节点和连线的 K2 图。
- `umg_k2`：Widget Blueprint / UMG 内的 K2 逻辑图，包括 EventGraph、FunctionGraph、属性绑定函数图和回调逻辑图；不处理 Designer 控件布局和 Widget Animation 时间轴。
- `anim_blueprint`：AnimBlueprint 中的 EventGraph、AnimGraph、Transition Rule、State 内部 pose/data 节点图；State Machine 顶层状态图属于状态/转移图，默认标为 unsupported，不直接套横向 pin 图算法。
- `material_graph`：`UMaterial` 的 Material Expression 图，例如 `/Game/Materials/M_WaterSurface`。
- `material_function_graph`：`UMaterialFunctionInterface` 的表达式节点图。
- `generic_edgraph`：能从资产对象中枚举到 `UEdGraph` 子对象、且不是已知竖向/非 pin 图的其它节点连线资产。`ControlRigBlueprint` 的 `ControlRigGraph / RigVM` 编辑图虽然资产类继承自 `UBlueprint`，但图语义不是 K2，因此 `adapter=auto` 必须归入 `generic_edgraph`，再转换为同一套 Blueprint layout kernel 输入。该 adapter 仍必须提供真实节点尺寸和真实 pin 连接点；如果无法从 UE 图编辑器取得真实几何，则本次排布失败而不是回退估算。

明确不纳入：

- Behavior Tree、StateTree、EQS 这类竖向/层级/专用语义图。
- Niagara Stack、Emitter Stack、Renderer Stack 等栈式编辑结构。
- UMG Designer 控件布局、Widget Animation 时间轴、Curve、DataTable、Material Instance 参数面板。
- State Machine 顶层状态图，除非以后单独设计状态图算法。

## 图选择器

`graph_selector` 用来处理“一个资产内有多个图”的情况。支持精确指定单图、指定列表、按类型批量、或排布全部支持图。

### 精确指定单图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "single",
    "graph_path": "/Game/Blueprints/BP_AutoDoor.BP_AutoDoor:MyMacro"
  }
}
```

如果图名不重名，也可以使用：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "single",
    "graph_kind": "macro_graph",
    "graph_name": "MyMacro"
  }
}
```

稳定性优先级：`graph_path` 高于 `graph_name`。宏图、函数图或嵌套图可能重名时，应该先用 `node_graph_list` 读取返回的 `graph_path`，再调用 `node_graph_layout`。

### 指定多图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "list",
    "graph_names": ["EventGraph", "OpenDoor"],
    "graph_paths": []
  }
}
```

### 按图类型批量

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "by_kind",
    "graph_kinds": ["event_graph", "function_graph", "macro_graph"],
    "skip_empty_graphs": true
  }
}
```

K2 家族支持的 `graph_kinds`：

- `event_graph`
- `function_graph`
- `macro_graph`
- `delegate_graph`
- `nested_graph`

### 全部支持图

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "graph_selector": {
    "mode": "all_supported",
    "include_nested_graphs": false,
    "skip_empty_graphs": true
  }
}
```

`include_nested_graphs=false` 是更安全的默认倾向：普通函数、宏、事件图会被纳入；AnimBlueprint State Machine 顶层状态图、折叠图内部图等嵌套图只有显式请求时才枚举。

## 排布参数

`layout_options` 是通用排布参数容器：

```json
{
  "layout_options": {
    "horizontal_spacing": 360,
    "vertical_spacing": 96,
    "node_padding": 16,
    "origin_x": 0,
    "origin_y": 0,
    "insert_reroute_nodes": true,
    "replace_existing_reroute_nodes": true,
    "allow_remove_all_reroute_nodes": false
  }
}
```

所有支持的横向节点连线图都必须进入同一套 Blueprint layout kernel。adapter 的职责只允许是：

- 读取对应资产的节点、输入 pin、输出 pin 和连线，转换成 Blueprint layout kernel 的 `FNode/FEdge`。
- 计算并提供真实节点结构数据：节点实际宽高、每个输入 pin 相对节点左上角的真实连接点、每个输出 pin 相对节点左上角的真实连接点。该数据来自同一张 `UEdGraph` 构造出的临时离屏 `SGraphEditor` / `SGraphPanel` / `SGraphNode` / `SGraphPin` 和连接绘制策略等真实 Slate 值，不允许用标题长度、固定行高、固定 pin 间距或其它估算值替代，也不得为了测量去移动用户正在看的 live GraphEditor。
- Material / MaterialFunction 的真实几何必须来自 UE 自己的 `UMaterialGraph` / `UMaterialGraphNode`。特别是 Material Function，UE 会在编辑器中创建 transient preview material 和 duplicated function graph，adapter 不得自行创建另一张复制 graph；但可以把这张真实 `UEdGraph` 放入临时离屏 `SGraphEditor` 进行 Slate 测量，避免截图/几何采样污染真实编辑器窗口。
- MaterialFunction 打开 editor 前必须先快照原始 `UMaterialFunction` 的 expression collection 和 expression 数量；打开后用这个快照校验 preview graph 是否完整。若 transient preview graph 尚未同步完整表达式，adapter 必须先把快照 collection 同步到 editor preview material/function 并 rebuild；仍不完整时命令失败，不允许对只含输出节点等残缺 graph 执行布局。
- MaterialFunction 写回时不得把 transient preview material/function 的 `ExpressionCollection` 整体赋回原资产。preview graph 只用于读取真实节点尺寸、真实 pin 和临时可视 graph node；实际保存只允许按 `MaterialExpressionGuid` 将每个 preview `UMaterialGraphNode` 的新坐标同步回原始 `UMaterialFunction` 中对应 `UMaterialExpression::MaterialExpressionEditorX/Y`，避免把预览材质的临时表达式对象序列化进资产或把资产污染成空图。
- pin anchor 的 Y 坐标必须按 UE 图编辑器自身对齐语义读取：优先使用当前 `SGraphPin::GetNodeOffset().Y`，这和 UE `SGraphPanel::StraightenConnections()` 中的 `NodePosY + Pins.SrcPin->GetNodeOffset().Y` 保持一致。最小化或自动化测量路径下，pin widget 可能尚未 tick，导致 `GetNodeOffset().Y` 保持为 0；这种 0 缓存视为不可用，才允许用同一轮 Slate arranged node geometry 与 arranged pin geometry 计算相对节点的 pin 行中心作为 fallback。不得把旧 report 的 anchor 和当前节点位置混算。
- `node_graph_layout` 的报告会输出 `nodes[].input_pins/output_pins[].anchor_x/anchor_y/new_graph_x/new_graph_y` 和 `edges[].new_pin_y_residual`。验收 pin 对齐时必须看真实 pin graph 坐标 residual，而不是比较节点左上角坐标；材质函数输出节点带 preview 区域时，输出节点左上角通常会高于上游节点。
- `node_graph_layout` 的真实几何测量必须使用离屏 `SGraphEditor`，报告必须返回 `geometry_used_offscreen_graph_editor=true`。对 `generic_edgraph` / ControlRig 这类需要资产编辑器先完成节点类初始化的图，命令可以打开资产编辑器并返回 `opened_editor_for_geometry=true`，但测量仍只能在离屏 GraphEditor 上完成，不能用截图，也不能移动用户当前真实图面的 view。
- `node_graph_layout` 使用 shared Blueprint layout core 时，会同步输出 core 诊断字段。岛内跨多列显式连接命中 `island_internal_multi_column_bus_count`；同列岛内连接若直连曲线会碰撞本列其它节点，则命中 `island_internal_same_column_collision_bus_count`，并通过列右边界中途点引导。
- 在真实几何不完整时直接报错，返回 `geometry_source=incomplete_slate_real_pin_geometry`、`missing_pin_anchor_count` 等诊断字段；不得继续调用 layout kernel 生成看似成功的结果。
- 写回阶段必须由 adapter 把 core 输出转换回对应图类型。K2 家族按 kernel 输出写回 reroute 节点；Material / MaterialFunction 写回 `UEdGraphNode::NodePosX/Y` 与对应 `UMaterialExpression::MaterialExpressionEditorX/Y`，Material 图会在写回后调用 `UMaterialGraph::LinkMaterialExpressionsFromGraph()` 同步表达式位置，不重建表达式、不删除表达式、不实现第二套排布算法；ControlRig / RigVM 这类 `generic_edgraph` 必须通过 `URigVMController` 写回模型节点位置、折叠已有 reroute 并按 core reroute plan 重建 RigVM reroute 节点。若某 adapter 尚不支持 reroute 写回，而本次 core 产生了需要写回的中途点，命令必须失败并返回不支持原因，不能生成看似成功但实际残留旧中途点的结果。

Material / MaterialFunction adapter 不再用 `UMaterialExpression` 自行拼虚拟图，也不再创建虚拟 Material Output 节点。它们先解析到 UE 自己的 `UMaterialGraph` / `UMaterialGraphNode`，使用图中真实 root node、表达式节点、pin 和连线，再交给同一套 Blueprint layout kernel。

禁止在本入口为 Material、UMG、AnimBlueprint 或其它 EdGraph 另写 rank layout、树状 layout、随机/迭代修补 layout。需要支持新资产类型时，应只新增 adapter，把该资产转换为同一套 `FNode/FEdge` 后调用 Blueprint layout kernel。

## 示例

枚举 `M_WaterSurface`：

```json
{
  "asset_path": "/Game/Materials/M_WaterSurface"
}
```

排布 `M_WaterSurface`：

```json
{
  "asset_path": "/Game/Materials/M_WaterSurface",
  "adapter": "auto",
  "graph_selector": {
    "mode": "all_supported"
  },
  "layout_options": {
    "horizontal_spacing": 360,
    "vertical_spacing": 128
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

只排布 Blueprint 内某个宏图：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "adapter": "auto",
  "graph_selector": {
    "mode": "single",
    "graph_kind": "macro_graph",
    "graph_name": "MyMacro"
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

批量排布 Blueprint 中所有常规 K2 图：

```json
{
  "asset_path": "/Game/Blueprints/BP_AutoDoor",
  "adapter": "auto",
  "graph_selector": {
    "mode": "all_supported",
    "include_nested_graphs": false,
    "skip_empty_graphs": true
  },
  "compile_after_layout": true,
  "save_after_layout": true
}
```

## 兼容关系

`blueprint_layout_graph`、`blueprint_layout_all_graphs`、`anim_blueprint_layout_graph` 继续保留。`node_graph_layout` 对 K2 / UMG / AnimBlueprint 图会委托到现有 Blueprint layout kernel，不实现第二套 K2 排布算法。新脚本应优先使用 `node_graph_list` + `node_graph_layout`，旧脚本无需立刻迁移。

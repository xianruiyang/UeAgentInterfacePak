---
command: blueprint_layout_graph
category: blueprint
title: `blueprint_layout_graph`
summary: 自动排版指定 Blueprint 图节点
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_layout_graph`

## LLM Compact

- status: active.
- purpose: 自动排版指定 Blueprint 图节点
- key_inputs: `asset_path`, `allow_focused_geometry_capture`, `allow_geometry_view_capture`, `allow_remove_all_reroute_nodes`, `compile_after_layout`, `graph_name`, `horizontal_spacing`, `insert_reroute_nodes` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 普通排版必须读取真实 Slate 几何：命令会打开或复用目标 GraphEditor 来构造 `SGraphNode` / `SGraphPin` widget，并在固定 `geometry_measurement_zoom=1.0` 的临时采样视图下读取真实节点尺寸和真实 pin anchor，采集后立即恢复图面 view。节点尺寸优先使用 `SGraphNode::GetDesiredSize()` 的 Slate 缓存结果，`GraphEditor->GetBoundsForNode()` 只作为 UE 真实尺寸读回兜底。已连接 pin anchor 或节点真实尺寸不完整时命令直接失败，不再回退到估算 pin 行、估算节点宽高或只返回不写入的预览结果。
- note: 收集非 reroute 节点、可见输入/输出 pin、语义边，并把旧 reroute 链折叠成源 pin 到目标 pin 的语义边。
- note: 计算 SCC，选择 SCC 内稳定的反馈边标记为 `RankIgnoredFeedbackEdge`。这类边只用于打断 rank / 列分配意义上的环，不参与岛内 rank、列排序、输入链抽离和 crossing minimization，但仍参与弱连通成岛。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 普通排版必须读取真实 Slate 几何：命令会打开或复用目标 GraphEditor 来构造 `SGraphNode` / `SGraphPin` widget，并在固定 `geometry_measurement_zoom=1.0` 的临时采样视图下读取真实节点尺寸和真实 pin anchor，采集后立即恢复图面 view。节点尺寸优先使用 `SGraphNode::GetDesiredSize()` 的 Slate 缓存结果，`GraphEditor->GetBoundsForNode()` 只作为 UE 真实尺寸读回兜底。已连接 pin anchor 或节点真实尺寸不完整时命令直接失败，不再回退到估算 pin 行、估算节点宽高或只返回不写入的预览结果。
- 收集非 reroute 节点、可见输入/输出 pin、语义边，并把旧 reroute 链折叠成源 pin 到目标 pin 的语义边。
- 计算 SCC，选择 SCC 内稳定的反馈边标记为 `RankIgnoredFeedbackEdge`。这类边只用于打断 rank / 列分配意义上的环，不参与岛内 rank、列排序、输入链抽离和 crossing minimization，但仍参与弱连通成岛。
- 在排除 `RankIgnoredFeedbackEdge` 后，按同一 source pin 的剩余出边寻找真正 fanout，并把这些边标记为 `IslandCutFanoutEdge`。只有 `IslandCutFanoutEdge` 会从弱连通成岛中移除并提升为 island graph 边；一个节点如果只是“一个正常输出 + 一个回边”，不会被误判成 fanout。
- 用只移除 `IslandCutFanoutEdge` 的图做弱连通切岛；岛内 rank、列分配、列排序和双列锚定只看显式边，避免已经切掉的回边重新影响岛内框架。列排序的普通主 key 是相邻列节点顺序，真实 pin Y 顺序只在多个节点共享同一个相邻节点时作为 tie-break，避免同一目标输入口或同一源输出口上下顺序被排反。对于连接到同一个外部目标节点不同端口的分支，命令会先计算 downstream port-order demand set，并沿显式边向上游传播，使该端口顺序能影响多列排序；对于来自同一个外部源节点不同输出端口的分支，命令会计算 source port-order demand set，并沿显式边向下游传播。demand set 按 group 合并并保留多级上下文；排序时只比较两个节点共同拥有且 value 不同的 group，优先选择传播距离更近的共同 group。source demand 属于同一个源 group 时优先于相邻列 barycenter，即使一个节点有相邻列邻居、另一个节点只有跨列连接，也必须先保持源输出端口上下顺序，以避免已经反转的相邻列顺序继续污染后续列；不同源/目标 group 的 demand 不互相比大小。
- 每个岛内部按最宽列和双列锚定放置节点；列间距会预先纳入内部总线 lane 需求，但按 `min(output_access_offset_x + input_access_offset_x, branch_x_avoidance_distance * (1 + internal_bus_lane_count))` 计算紧凑局部 corridor，不再随总线数线性撑宽列。`branch_x_avoidance_distance` 来自真实相邻 pin 行距/可见 fallback，并带有半个输入输出访问距离的安全下限，避免列被压到直连穿节点但又放不下合法局部总线。附属输入链会先为目标列左侧 corridor 预留足够 X 宽度，再把链节点放在上一核心列和目标列之间；同 corridor 多条输入链只做局部 Y 平衡避让，不再把链节点整体向下推离目标行。
- 生成 `InternalBusGroup` / `BoundaryEntry` / `BoundaryBus` / `IslandPortCandidate`；单内部总线的 left 入口仍按左侧虚拟列处理，非最左列的 top/bottom 入口会同时生成正上/正下固定优先点和 top/bottom 连续区间候选，固定点优先但允许像多内部组外部总线一样按源端真实 X 与连接对齐缩短量选择更合适的边缘点；多内部总线继续使用 top/bottom 连续候选区间并生成 `BoundaryBus`。候选会同时保留两个点：`target_local` 是岛边界/总线接入候选点，只用于岛位置约束和入口选择；`actual_target_local` 是目标输入 pin 的真实局部坐标。任何 top/bottom 入口不能直接把 `X` 吸附到真实输入 pin，而要先由 `ComputeOutputXAlignedToInput()` 得到目标侧最大输出 X，并由 `ConnectionAlignmentShortenX >= 0` 验证。
- 岛间连接使用 `FrozenIslandCorridorSolver`：先建立 placement DAG 和 route-only 边，再用 ownership forest 为每个 target island 选择唯一 placement owner，枚举有限 endpoint candidate 并生成 placement proposal。proposal 以 `RequiredDeltaX` 为主成本、`VerticalResidual` 为次成本，长 left entry 不再因 side 固定优势把整图继续向右拉长；当 top/bottom 入口能显著减少 X 约束时，算法会选择上下入口并在 placement 中拉开 island。随后 island 放置不是只做 X 压缩或只做 Y 下推：它先用 ownership anchor 和加权中位数求 `PreferredY`，再对候选 Y 同时评估无横移解和宽岛右移解；只有右移能显著减少 `|Y - PreferredY|` 且综合代价更低时，才允许用少量 X 扩展换取更紧凑的 Y 距离。已提交 island 只允许整体坐标固定，不允许后续阶段修改岛内节点、输入链、内部总线或岛内 reroute ownership。同一个源 island 的多个输出接口连接到不同目标 island 时，endpoint 会记录 `SourcePortOrderKey=SourceLocal.Y`，placement 会构造源接口顺序约束；上方源接口对应的目标 island 必须排在下方源接口对应目标 island 上方。该约束在 constructive placement 顺序和下方目标的 `MinY` 下界中生效，不是 route 后处理；`source_port_order_violation_count` 用于诊断这条约束是否被破坏。
- 根据已提交的 endpoint candidate 和岛间总线拓扑 生成 `direct`、`local_bus`、`external_bus` 的 reroute 计划；每条路线在生成时就使用节点级 hard occupancy、输入链分段碰撞箱、route reservation 和连接对齐缩短量判断是否可行，不能靠后处理再修形状。岛间连接先按 `PlacementOwner` 关系决定是否有 direct 资格，再按真实 hard occupancy 和入口可达性决定 direct / local bus / external bus。只有 ownership edge 可以保持 direct；non-owner edge、route-only edge 和入口不可直接接回真实 pin 的连接天然进入总线层。所有岛间 direct 路线，包括 exec 白线和 data 彩线，只要会穿过非源/目标 hard occupancy，就会升级为局部或外部总线；不会再通过 hard occupancy X relaxation 把整个目标 island 向右推远。长距离线不靠长度阈值被动降级，而是通过 ownership 选择、X 最长路压缩、Y 分层和 non-owner 总线化从结构上避免。岛间 corridor 之外，所有尚未生成 reroute plan 的同岛 direct 连接也会在同一轮生成期做最终准入检查：若 direct 可见 spline 穿 hard occupancy，则生成 `local_bus`，避免同一 island 内部的连接横穿其它节点。非输入链连接若原始端点 AABB 穿过输入链分段碰撞箱，会生成 `input_chain_collision_guard` 局部守卫中途点，守卫点位于被撞输入链分段箱左边，Y 对齐目标真实接口。已有 direct/local/external route plan 不在该步骤二次增强；但所有已生成的 `reroute_plan` 在写回前必须再通过 segment admissibility gate：用真实源 pin、可见中途点、真实目标 pin 组成最终控制点链，若任意相邻段仍穿过非源/目标 hard occupancy，就用同一套 `BuildOrthogonalRoutePolyline` 重新生成完整多点 `local_bus` 候选，只接受逐段 `ConnectionAlignmentShortenX >= 0` 且 segment hard-hit 为 0 的路线。segment gate 若改写同源 fanout 的某条分支，必须在同一生成期内按 `AttachmentMergeGroup` 把组内源侧共享 trunk Y 和共享 trunk 前缀点重新归一化；归一化只接受所有 sibling route 都 hard-hit 为 0 且缩短量非负的共享 Y / 共享前缀，不允许把同一 `SourceParamId` 写成多条平行岛间主干。最终路线重新检查后，`route_through_island_count` 必须为 0 才算设计完成。同一 `SourceParamId` 的岛间 fanout 若有多条边升级为 bus，必须先合并为一个 inter-island bus 并共享同一条 trunk lane，再为各目标选择合法 branch X；不能按 edge 拆出多条平行岛间总线。trunk Y lane 和 branch X lane 都不是后处理：每个 `InterIslandBus` 会在生成期枚举 trunk Y、branch X 和以真实目标 pin 结束的完整可见 wire 控制点候选，X 投影冲突或 branch Y 投影冲突的 bus 作为冲突组一次性选择候选组合，优先满足 `hard_hit_count=0`、`BusTrunkLaneSpacing` 和 branch X lane spacing。后续生成的 direct-obstacle / input-chain guard 局部 bus 也必须把当前已确定的不同 `SourceParamId` 总线水平 trunk 和分支段转成 lane reservation，再在候选期优先换 Y/X lane；lane reservation 是规划期软约束，不是 hard occupancy，若完全避让 reservation 会导致无合法路线，则接受 hard-hit 为 0 且逐段缩短量非负的路线并输出 `direct_obstacle_route_soft_lane_conflict_accepted`，不能退回穿节点原曲线。`target_local/entry_abs` 只用于岛边界入口和 island placement 约束，不能作为最终硬占用检测终点；`entry_abs -> actual_target_abs` 这一段也必须作为 UE spline 可见线进入候选评分和穿岛检测。hard hit 计算按相邻控制点之间的 UE spline 采样，而不是只检测控制点直线段。初始单边 local bus / dogleg 候选和后续 InterIslandBus 候选都必须是有限集合：只从当前连接走廊内采集 hard rect 边界，并按与目标 trunk Y、源/目标接口 Y、目标侧 branch 上限和 corridor 中点的距离裁剪到固定上限；不能把 dogleg 组合做成无界四重枚举。源侧第一个中途点必须满足 `FirstKnot.X >= ComputeInputXAlignedToOutput(SourceRealX)`，目标侧最后一个中途点必须满足 `LastKnot.X <= ComputeOutputXAlignedToInput(ActualTargetRealX)`，任意两个相邻中途点也必须按前者输出、后者输入逐段满足 `ConnectionAlignmentShortenX >= 0`；目标侧完全对齐时返回值为 `0`，不再用经验偏移、直接 X 吸附或同 X 中途点制造 S 形回绕。branch point 优先使用满足非负缩短量、完整可见 polyline hard-hit 为 0 的最右合法 X，通常是 `ComputeOutputXAlignedToInput(TargetX)`；只有该点不可行时才在候选集合内向左搜索目标侧接入点、branch lane 或 hard-rect 避让点；从 trunk 接回目标接口需要改变 Y 时必须使用目标侧短 dogleg，不能从远离目标的分支点直接拉大斜线。跨 bus 竖向 branch 若 Y 投影重叠且当前/理想 branch X 过近，会在候选选择中分配不同 branch X lane：同一 `SourceParamId` 不参与 cross-bus lane；输出点到总线束的 Y 距离越小，branch point 越靠右；其它冲突 branch 只能选择候选集合中更靠左且保持非负 shorten 的 branch X。合法 X 区间重叠本身不构成 X lane 冲突；只有已选/理想 branch X 过近才进入同一 X 避让组，避免远端分支被近端分支牵连。所有 corridor route 的起点和终点都是真实图坐标；`reroute_plan[].points` 与 `reroute_plan[].knot_points` 都表示可见中途点控制点坐标，命令写回时再转换为 `K2Node_Knot` 左上角。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_focused_geometry_capture`：布尔/开关字段；默认值以本命令契约为准。
- `allow_geometry_view_capture`：布尔/开关字段；默认值以本命令契约为准。
- `allow_remove_all_reroute_nodes`：布尔/开关字段；默认值以本命令契约为准。
- `compile_after_layout`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `horizontal_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `insert_reroute_nodes`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layout_report_file`：文件路径字段；长 JSON/结果优先走文件。
- `node_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `origin_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `origin_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `replace_existing_reroute_nodes`：布尔/开关字段；默认值以本命令契约为准。
- `save_after_layout`：布尔/开关字段；默认值以本命令契约为准。
- `vertical_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

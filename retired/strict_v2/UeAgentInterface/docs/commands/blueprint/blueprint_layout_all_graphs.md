---
command: blueprint_layout_all_graphs
category: blueprint
title: `blueprint_layout_all_graphs`
summary: 自动排版一个 Blueprint 资产内的多个/全部图
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_layout_all_graphs`

## LLM Compact

- status: active.
- purpose: 自动排版一个 Blueprint 资产内的多个/全部图
- key_inputs: `asset_path`, `allow_focused_geometry_capture`, `allow_geometry_view_capture`, `allow_remove_all_reroute_nodes`, `compile_after_layout`, `graph_name`, `graph_names`, `graph_path` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 若传入 `graph_name` 或 `graph_path`，只排布该图。若传入 `graph_names` 或 `graphs`，按数组逐项解析；数组项可以是字符串，也可以是含 `graph_name` / `graph_path` / `name` 的对象。
- note: 若没有显式图选择器，默认排布 `UbergraphPages`、`FunctionGraphs`、`MacroGraphs`；`DelegateSignatureGraphs` 默认不排布，可用 `include_delegate_graphs=true` 打开。
- note: 每个目标图都通过现有 `blueprint_layout_graph` 路径执行，因此真实 Slate 几何、固定测量 zoom、输入输出对齐、岛内冻结、总线规划、写回 reroute 等契约完全一致。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 若传入 `graph_name` 或 `graph_path`，只排布该图。若传入 `graph_names` 或 `graphs`，按数组逐项解析；数组项可以是字符串，也可以是含 `graph_name` / `graph_path` / `name` 的对象。
- 若没有显式图选择器，默认排布 `UbergraphPages`、`FunctionGraphs`、`MacroGraphs`；`DelegateSignatureGraphs` 默认不排布，可用 `include_delegate_graphs=true` 打开。
- 每个目标图都通过现有 `blueprint_layout_graph` 路径执行，因此真实 Slate 几何、固定测量 zoom、输入输出对齐、岛内冻结、总线规划、写回 reroute 等契约完全一致。
- 批量层只负责图枚举、去重、空图跳过、逐图调用和汇总统计，不允许加入布局决策、后处理修线或节点名/pin 名特例。
- 新增规则必须优先写成算法模块内的泛用子算法和自测，不能在命令适配层对某个节点名、pin 名或截图个例做特例修补。
- 真实节点尺寸和真实 pin anchor 必须通过命令适配层的几何采集结构传入算法模块；采集过程只能使用固定测量 zoom，并必须用自测或 UAI 读回证明不会把临时采样缩放写成用户可见或持久化视图状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_focused_geometry_capture`：布尔/开关字段；默认值以本命令契约为准。
- `allow_geometry_view_capture`：布尔/开关字段；默认值以本命令契约为准。
- `allow_remove_all_reroute_nodes`：布尔/开关字段；默认值以本命令契约为准。
- `compile_after_layout`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `graph_names`：名称列表。
- `graph_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `graphs`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `horizontal_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_delegate_graphs`：布尔/开关字段；默认值以本命令契约为准。
- `include_function_graphs`：布尔/开关字段；默认值以本命令契约为准。
- `include_graph_result_details`：布尔/开关字段；默认值以本命令契约为准。
- `include_macro_graphs`：布尔/开关字段；默认值以本命令契约为准。
- `include_nested_graphs`：布尔/开关字段；默认值以本命令契约为准。
- `include_ubergraphs`：布尔/开关字段；默认值以本命令契约为准。
- `insert_reroute_nodes`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layout_report_file`：文件路径字段；长 JSON/结果优先走文件。
- `node_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `origin_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `origin_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `replace_existing_reroute_nodes`：布尔/开关字段；默认值以本命令契约为准。
- `save_after_layout`：布尔/开关字段；默认值以本命令契约为准。
- `skip_empty_graphs`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stop_on_error`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `vertical_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

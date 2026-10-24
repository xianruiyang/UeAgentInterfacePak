# 场景制作

场景制作同时包含空间布置和符合目标效果的渲染配置，通常在 Editor 状态下完成。
材质、灯光、曝光、后处理和观察视角都属于场景交付；不留到 PIE 中补齐。

## 制作与依赖

资产/候选查询按 [CLI](cli.md) 调用；当前地图的公共 workspace 按[公共 HJSON 流程](hjson-workspace.md)导出、直接编辑并导入。
需要的内容资产先完成可供场景引用的部分，再摆放实例；若资产仍需调整，只更新受影响的资产与实例。
Actor 的创建字段、transform 和属性形状以当前导出及候选合同为准，不套用其他资产的结构。
Level/Actor/Component 合同见项目 `Plugins/UeAgentInterface/docs/active/t26_level_world_domain.md`，
SDK 编辑示例见 `UeAgentInterfaceCMD/docs/active/t26_level_world_domain.md`。
地图根 target 的 `properties.hjson` 按原生类别导出 WorldSettings 属性（包括 GameMode）；按当前字段和类型修改，
仍通过同一 workspace 导入，未改字段保留。玩家入口按目标选择，不为已有可用入口另建 GameMode。
后续编辑留下 dirty 地图时，按[仅保存既有资源](hjson-workspace.md#仅保存既有资源)只保存该地图。

已有确定布局与参数可成批应用；需要空间或画面判断时再停下观察。不因切换对象就拆成独立交接。

连续白盒、平台、台阶、坡道或需要切口的体块可选用 [CubeGrid](cubegrid.md)，在一个可续编的网格内增删体积。
独立部件仍可用普通 Actor；按编辑意图选择，不要求每个场景都使用 CubeGrid。

## 形成目标画面

按用途设置材质、照明、曝光和后处理，不对所有场景强制固定曝光或套用同一渲染模板。
需要观察时使用 Editor 场景视口及适用的公开截图入口；构图同时考虑横纵画幅，
不把水平 FOV 当作垂直 FOV。亮度异常先区分曝光、光照和材质，比较时保持来源、视角和场景状态一致。
确认整体曝光问题后处理曝光，不先创建替代材质试错。
临时调整视口时保留 `viewport.state_read` 的完整 `payload`，恢复时原样交给 `state_restore`，不重建字段白名单。
视口选择、配置与有效状态的区别及支持的显示标志见 CMD `docs/active/t45_viewport_graph_control.md`；参数取当前 `describe`。

资产自身效果不清楚时回到[资产预览](asset-preview.md)；涉及玩家输入、碰撞交互或游戏运行逻辑时，
才进入[运行时 PIE](pie.md)。无需为静态场景制作额外建立运行时测试。
最终画面证据与已完成的读回按[验证与知识](verification-and-knowledge.md)复用，不机械追加检查。

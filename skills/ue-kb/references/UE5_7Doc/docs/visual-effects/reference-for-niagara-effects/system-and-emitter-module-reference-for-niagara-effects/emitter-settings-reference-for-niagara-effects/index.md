---
title: "发射器设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/emitter-settings-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "发射器设置"]
---

# 发射器设置

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 发射器设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/emitter-settings-reference-for-niagara-effects-in-unreal-engine

## 发射器属性项

![Emitter Properties](../../../../../assets/images/b4/b4b1ce5b30ee58d4675ecb3c0eea856daa670c2f949e095e2d04aa384359d6f4.png)

所有创建的发射器（即使为空）均默认含有 **发射器属性（Emitter Properties）** 项。发射器属性项包含以下基本参数。

| 参数 | 说明 |
| --- | --- |
| 发射器 |  |
| **本地空间（Local Space）** | 此设置用于切换发射器中粒子采用的相对坐标系：是相对于此发射器的本地空间还是全局空间。 |
| **确定性（Determinism）** | 此设置可将随机数生成器（RNG）切换为全局确定性或非确定性。任何采用发射器默认值的随机计算都将继承此设置。你仍可以将随机数单独设置成确定性或非确定性。在本例中，"确定性（deterministic）" 表示只要时间增量为非变量，RNG将返回相同发射器配置的结果。更改发射器的单个脚本将调整结果。 |
| **随机种子（Random Seed）** | 若已启用确定性设置，则此项为确定性随机数生成器基于发射器的种子。 |
| **模拟目标（Sim Target）** | 决定模拟在CPU或GPU上执行。 |
| **固定边界（Fixed Bounds）** | 决定是否可编辑固定边界。若启用，则拥有可调整的X、Y、Z设置的最小值和最大值。 |
| **内插生成（Interpolated Spawning）** | 若启用此设置，此发射器将利用内插参数值生成，且生成时会执行部分更新。这种生成方法将大幅增加开销，但高生成率、帧率不稳定、高移动速度的发射器生成时将更加顺畅。 |
| **需要固定ID（Requires Persistent ID）** | 若启用，将向发射的所有粒子指定固定ID。 |
| **Combine Event Spawn** | This setting allows event based spawning to be combined into a single spawn. |
| 可扩展性 |  |
| Scalability Settings 可扩展性总共有五类设置： **低（Low）**、 **中（Medium）**、 **高（High）**、 **史诗（Epic）** 和 **过场动画（Cinematic）**。在发射器中，你可以点击开启或关闭某个分类。每个分类还包含一个下拉菜单，其中列出了各种平台；每个平台都能以特定级别显示画面。除了开启或禁用分类，你还可以在分类中包括或排除特定平台。 主机和移动平台不会显示在分类中，除非你使用了对应的配置和设备描述文件。 |  |
| **设置（Setting）** | **可包含或排除的平台** |
| **低（Low）** | Windows Mac Linux Android |
| **中（Medium）** | Windows iOS Mac Linux Android |
| **高（High）** | Windows Mac Linux |
| **史诗（Epic）** | Windows TVOS Mac Linux |
| **过场动画（Cinematic）** | Windows Mac Linux |
| 资产选项 |  |
| Asset Options |  |
| **库可视性（Library Visibility）** | 该设置允许你调整此发射器是否暴露在库中，或者是否应该显式隐藏。 |
| **模板规格（Template Specification）** | 该发射器用于切换发射器是标准父发射器、模板，还是行文示例。 |
| **模板资产说明（Template Asset Description）** | 若将此发射器识别为模板资产，可点击右侧图标，查找 **内联文本（Inline Text）** 和 **参考文本（Referenced Text）** 的其他设置。 |
| **分类（Category）** | 你可以为 '添加新的发射器对话框' 添加类别，整理这个发射器。 |
|  |  |

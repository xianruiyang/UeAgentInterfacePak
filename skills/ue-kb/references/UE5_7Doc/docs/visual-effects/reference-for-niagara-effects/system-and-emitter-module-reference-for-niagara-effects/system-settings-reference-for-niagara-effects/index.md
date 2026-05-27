---
title: "系统设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/system-settings-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "系统设置"]
---

# 系统设置

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 系统设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/system-settings-reference-for-niagara-effects-in-unreal-engine

系统设置组包含 **用户参数（User Parameters）** 和 **系统属性（System Properties）**。

## 用户参数

用户参数只能在Niagara模拟之外进行设置，例如在蓝图逻辑或C++代码中进行设置。本节将显示已创建的用户参数。

## 系统属性项

默认情况下，所有创建的系统（即使为空系统）中均含有 **系统属性（System Properties）** 项。系统属性项包含以下基本参数。

| 参数 | 说明 |
| --- | --- |
| 调试 |  |
| **转储调试系统信息（Dump Debug System Info）** | 此复选框指示是否就每一帧都将系统的调试信息写入日志。这对跟踪真正异常的行为很有用，但同时也非常冗长。 |
| **转储调试发射器信息（Dump Debug Emitter Info）** | 此复选框指示是否就每一帧都将发射器的调试信息写入日志。这对跟踪真正异常的行为很有用，但同时也非常冗长。 |
| 系统 |  |
| **效果类型（Effect Type）** | 单击下拉列表以选择要应用于系统的效果类型。效果类型是为视觉效果类安排设置的有效方法。例如，你可能希望控制所有武器影响的可延展性设置，且此类设置可以存储在武器影响效果类型资产中。 |
| **可延展性覆盖（Scalability Overrides）** | 你可以在此处设置与不同平台上的性能有关的覆盖。 这些是在上述"效果类型"中指定的默认值的覆盖。 |
| **固定边界（Fixed Bounds）** | 此复选框可启用或禁用固定边界。如果启用了此设置，则你可以设置整个系统的最小和最大固定边界。此外，你还可以在发射器属性项中设置各发射器的固定边界。 |
| 性能 |  |
| **自动停用（Auto Deactivate）** | 此复选框可启用或禁用系统中发射器的自动停用。若启用，系统中的所有发射器均未生成粒子时，将无视粒子生命周期设置停用此系统。 |
| **最大池大小（Max Pool Size）** | 此值是此系统的最大组件数，其常驻在场景组件池中。 |
| 预热 |  |
| **预热时间（Warmup Time）** | 这是以秒为单位的系统预热时间。若未手动设置预热tick数，此值用于计算预热tick数设置。其向下舍入到最接近预热tick差量值的倍数。 由于它可能会导致卡顿，因而请谨慎使用。 |
| ***预热Tick计数（Warmup Tick Count）** | 这是预热期间所需处理的Tick次数。可手动设置该值，也可使用预热时间设置进行设置。 由于它可能会导致卡顿，因而请谨慎使用。 |
| **预热Tick差量（Warmup Tick Delta）** | 此为用于预热Tick的差量时间。 |
| 资产选项 |  |
| **向库公开（Expose to Library）** | 如果启用了此设置，则此系统将向库公开。这意味着，当你添加模块时，它将默认显示在菜单中。 |
| **为模板资产（Is Template Asset）** | 若启用此设置，其表示此系统为新系统向导中公开的模板。利用模板创建的资产不会从父发射器继承，因而此类资产启动时无继承关系。 |
| **模板资产描述（Template Asset Description）** | 此为新系统向导中系统或发射器旁显示的描述。 |
| 发射器 |  |
| **烘焙快速迭代（Bake Out Rapid Iteration）** | 此复选框可用于启用或禁用将快速迭代参数烘焙到正常编译中。进行此更改可以提高性能，但也会极大提升迭代资产的难度。 |

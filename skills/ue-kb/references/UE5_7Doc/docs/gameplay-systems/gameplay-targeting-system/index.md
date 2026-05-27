---
title: "Gameplay定位系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay定位系统"]
---

# Gameplay定位系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay定位系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-in-unreal-engine

# Gameplay定位系统

[Gameplay定位系统](index.md)是创建数据驱动的定位请求的方式。它在[Gameplay技能系统插件](../gameplay-ability-system/index.md)基础上扩展，但可以在该功能外部使用。

要在编辑器中启用定位系统，你可以找到 **编辑（Edit）** > **插件（Plugins）** > **Gameplay** > **Gameplay技能（Gameplay Abilities）** > **定位系统（Targeting System）** 。

设置定位系统插件。

### 数据和设计

定位系统使用 **定位预设（Targeting Preset）** 。此定位预设是一个数据资产，定义了一组 **定位任务（Targeting Tasks）** ，这些任务针对执行的定位请求自上而下运行。

TP_Knockback_Pistol 是由Actor类定位任务设置了 Trace 定位任务和 Filter 的定位预设。

定位预设有一个功能是，每个任务都支持内联属性编辑。你可以定义可复用的定位任务和预设，从而设置任务的行为，而不用为每个任务定义 `UAsset` 。

在以上两个图像中，追踪类型（Trace Types） 和 必需Actor类（Required Actor Classes） 不同。这在同一个定位预设中执行，而不必选取不同的定位任务。

##### 定位任务

[**定位任务（Targeting Task）**](gameplay-targeting-system-reference/index.md#%E5%AE%9A%E4%BD%8D%E4%BB%BB%E5%8A%A1)是用于执行所需操作的小单元操作。定位任务通常可以分三个类别来考虑，即[选择](gameplay-targeting-system-reference/index.md#%E9%80%89%E6%8B%A9)、[筛选](gameplay-targeting-system-reference/index.md#%E7%AD%9B%E9%80%89)和[排序](gameplay-targeting-system-reference/index.md#%E6%8E%92%E5%BA%8F)。

定位任务具有蓝图支持。根据你构造任务的方式，这可能很简单，比如设置[类默认属性](../../blueprints-visual-scripting/user-interface-reference-for-the-blueprints-vis-53faed96/blueprint-editor-defaults-tab/index.md)来处理[蓝图可调用事件](../../blueprints-visual-scripting/blueprints-technical-guide/exposing-gameplay-elements-to-blueprints-visual-74ff2735/index.md)。

示例：**Knockback Pistol Trace** 任务设置了两个可重载事件来计算追踪的源位置和方向。在此示例中，如果你查看蓝图代码，你会看到它获取Pawn并调用一个函数来获取摄像机位置和摄像机方向。

##### 即时定位请求

[即时定位请求](gameplay-targeting-system-reference/index.md#%E5%8D%B3%E6%97%B6%E5%AE%9A%E4%BD%8D%E4%BB%BB%E5%8A%A1%E6%95%B0%E6%8D%AE)通过调用 `UTargetingSubsystem::ExecuteTargetingRequest` 函数来执行。定位请求基于 `UTargetingPreset` 对象，且会被立即执行，因此会在完成前阻止游戏线程。

##### 异步定位请求

[异步定位请求](gameplay-targeting-system-reference/index.md#%E5%BC%82%E6%AD%A5%E5%AE%9A%E4%BD%8D%E4%BB%BB%E5%8A%A1%E6%95%B0%E6%8D%AE)通过调用 `UTargetingSubsystem::StartAsyncTargetingRequest` 函数来执行。定位请求基于 `UTargetingPreset` 对象，且会被立即执行，但是它不会在完成前阻止游戏线程。

当定位请求需要等待缓慢操作（例如，等待服务器对目标进行身份验证），或等待某个Gameplay事件发生才能完成定位时，这些请求很有用。

> [!NOTE]
> GameplayTargetingSystem插件中定义的所有定位任务将同时提供即时和异步定位请求的实现，但是，如果游戏不使用异步功能，不会强制游戏代码同时实现两者。

##### 异步操作 - 执行定位 / 执行筛选

**UAsyncAction_PerformTargeting** 提供了通用蓝图支持，以启动异步定位请求或筛选操作。

## 调试

有关调试控制台命令和说明的完整列表，请参阅[Gameplay定位调试](gameplay-targeting-system-debugging/index.md)文档。

## 开发人员参考

如需深入的工程参考指南，请参阅[Gameplay定位插件参考](gameplay-targeting-system-reference/index.md)文档。

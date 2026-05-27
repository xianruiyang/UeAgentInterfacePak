---
title: "Gameplay定位系统参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay定位系统", "Gameplay定位系统参考"]
---

# Gameplay定位系统参考

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay定位系统 / Gameplay定位系统参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-reference-in-unreal-engine

### Gameplay定位系统参考

#### 定位请求句柄

用户开始 **异步定位请求（Async Targeting Request）** 时，会创建一个 **句柄** 。该句柄用于与定位 **数据存储（Data stores）** 交互。数据存储是围绕通用数据结构体建立的模板化类，由系统和任务用于完成定位请求。

> [!NOTE]
> 创建定位句柄时，它不会隐式释放句柄。由创建者负责抓取异步任务数据或即时任务数据，并设置标记来指示系统应该在回调触发后释放它们的句柄，否则就由你（用户）负责在使用完之后释放句柄。

#### 定位子系统

**定位子系统（Targeting Subsystem）** 负责跟踪异步定位请求，以及充当即时定位请求的入口点。定位子系统包含了代码，可帮助显示关于活动定位请求的调试信息。

#### 定位数据存储

**定位数据存储（Targeting Data Store）** 是定义定位数据存储的模板化结构体。目标是让定位任务能够灵活地添加、删除和更新它们要使用的通用数据集。

这样游戏可以在未来扩充，方便编写全新任务或是从基本框架原型扩展的任务，从而实现所需定位目标。

> [!NOTE]
> 创建你自己的自定义数据存储需要 `#define` 库中提供的一些样板代码

定位系统有3个必需数据存储，其中1个需要用于异步定位请求。需要先设置这些数据存储，然后系统才能正确运行定位请求。

#### 定位任务

**定位任务（Targeting Tasks）** 构成定位预设。定位任务应该是 **定位序列（Targeting Sequence）** 的小型可复用部分。定位任务有用于定义行为的 `Init` 和 `Execute` 虚函数。

它们包含一个用于向屏幕绘制调试信息的虚函数。定位任务通常归为以下某个类别：

| 类别 | 说明 |
| --- | --- |
| `Selection` | 选择任务会从世界选择Actor，并将其放在目标列表中。插件提供的简单示例包括选择射线追踪命中的所有Actor，选择效果区域内的所有Actor，以及选择源Actor。 |
| `Sorting` | 排序任务会对目标列表重新排序。插件提供的简单示例是按与源Actor的距离排序。 |
| `Filter` | 筛选任务会将目标结果数据集缩减为匹配特定条件的目标。插件提供的简单示例是按Actor类排序。插件还为筛选任务提供了一个基本模板，其中带有ShouldFilterTarget虚函数。 |

插件提供的定位任务包括以下任务：

| 列 1 | 列 2 |
| --- | --- |
| `TargetingFilterTask_ActorClass` | 一个简单的筛选任务，用于删除与 `RequiredActorClassFilters` 列表中的类不匹配的Actor，或与 `IgnoredActorClassFilters` 列表中的类相匹配的Actor。 |
| `TargetingFilterTask_BasicFilterTemplate` | 筛选任务的模板，其中包含虚函数 `ShouldFilterTarget` ，如果某个目标应该被从列表中删除，则该函数会返回 `true` 。 |
| `TargetingFilterTask_SortByDistance` | 按目标与源Actor位置的距离对目标列表排序。将距离作为 `Score` 变量存储在 `TargetDefaultResultsData` 中。 |
| `TargetingSelectionTask_AOE` | 一个选择任务，用于抓取与以源Actor位置为中心的区域（带可选的偏移）碰撞的所有Actor。支持多个形状（盒体、圆柱体、球体、胶囊体），并使用源Actor上由组件标签指定的组件。 |
| `TargetingSelectionTask_SourceActor` | 一个选择任务，用于将源Actor添加到目标列表。 |
| `TargetingSelectionTask_Trace` | 一个选择任务，将所有被射线追踪或横扫命中的有Actor添加到第一个阻挡命中（或其端点）。 追踪从源Actor位置开始，并沿源Actor的正向矢量（如果它是Pawn，则为其控制旋转）的方向追踪，除非提供了显式方向。 |
| `TargetingTaskSet` | 定位请求用于查找并处理目标的一组任务。 |
| `TargetingDefaultResultData` | 一个简单的结构体，其中包含 `FHitResult` 和表示单个目标的 `score` 变量。 |
| `TargetingDefaultResultsSet` | 在框架级别中实现的任务使用的基础定位结果数据。提供可供任务添加、删除和排序以完成定位请求的数据数组（命中结果/分数）。 |
| `TargetingSourceContext` | 一个结构体，其中保存定位请求的上下文数据，包括源Actor、发起者和位置。 |
| `TargetingRequestData` | 一个结构体，其中保存与定位请求相关的数据和委托，包括请求是否完整，以及请求完成时的原生和蓝图回调。 |
| `TargetingAsyncTaskData` | 一个结构体，其中保存异步定位请求的簿记数据。 |
| `TargetingImmediateTaskData` | 一个结构体，其中保存即时定位请求的簿记数据。 |

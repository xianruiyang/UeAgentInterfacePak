# Task Graph Insights

---
title: "Task Graph Insights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/task-graph-insights-in-unreal-engine-5"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "Timing Insights", "Task Graph Insights"]
---

# Task Graph Insights

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / Timing Insights / Task Graph Insights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/task-graph-insights-in-unreal-engine-5

### 启用CPU任务追踪

按照以下步骤分析CPU任务：

1. 从命令行运行应用程序时，使用以下命令启用 **任务（Task）** 和 **CPU** 追踪通道：

   ```
            -trace=default,task		
   ```
2. 找到 **Unreal Insights会话浏览器（Unreal Insights Session Browser）**，并从Trace存储目录选择追踪，以在Unreal Insights中打开.trace文件。如果会话具有任务事件，Timing Insights视图中将提供以下功能。

a) 将鼠标悬停在 **时序事件（Timing Event）** 时，如果当前事件在任务内，则 **提示文本** 中会显示更多信息。

![undefined](../../../../../assets/images/52/52853ce094193b78afdc14973d449cd05260386f36607c6696239cc108b72278.png)

b) 从 **时序视图（Timing View）** 轨道找到 **其他（Other）** > **任务（Tasks）** 子菜单。你可以将其用于显示与任务图表相关的可视化。

![undefined](../../../../../assets/images/03/0329198be5a46737ffea6e1df1a4ebe1becf6f42a6e0438e95290e0f3298fd3c.png)

| 任务子菜单选项 | 说明 |
| --- | --- |
| **显示任务关键路径（Show Task Critical Path）** | 显示或隐藏表示包含当前路径的关键任务的关系。 |
| **显示任务过渡（Show Task Transitions）** | 显示或隐藏当前任务的阶段之间的过渡。 |
| **显示任务连接（Show Task Connections）** | 显示或隐藏以下选项之间的任务连接： 当前任务的先决条件完成时间和当前任务的开始时间。 当前任务的完成时间和当前任务的后续任务开始时间。 当前任务的嵌套任务添加时间及其开始时间。 |
| **显示先决条件过渡（Show Transitions of Prerequisites）** | 显示或隐藏当前任务的先决条件的阶段过渡。 |
| **显示后续任务过渡（Show Transitions of Subsequents）* | 显示或隐藏当前任务的后续任务的阶段过渡。 |
| **显示父级任务过渡（Show Tansitions of Parent Tasks）** | 显示或隐藏当前任务的父级任务的过渡。 |
| **显示嵌套任务过渡（Show Transitions of Nested Tasks）** | 显示或隐藏当前任务的嵌套任务的阶段过渡。 |
| **显示任务概览轨道（Show Task Overview Track）** | 在选择一个任务时显示或隐藏任务概览轨道。 |
| **在任务概览轨道上显示详细信息（Show Detailed Info on the Task Overview Track）** | 在任务概览轨道中显示当前任务的先决条件/嵌套任务/后续任务。 |

c) 右键点击 **时序视图（Timing View）** 面板中的任意位置，打开 **时序视图上下文菜单**。此菜单显示了可用于在 **任务（Task）** 图表上对轨道排序的新选项。

| 菜单选项 | 说明 |
| --- | --- |
| **顶部停靠（Top Docked）** | 将此轨道停靠到顶部。 |
| **可滚动（Scrollable）** | 将此轨道移至可滚动轨道的列表。 |
| **底部停靠（Bottom Docked）** | 将此轨道停靠到底部。 |

d) 当你找到任务（Tasks）时， **显示任务依赖性（Show Task Dependencies）** 菜单选项将显示在下拉菜单中，当选择时序事件时，如果有任务包含了所选的时序事件，

则会显示以下数据：

- 以箭头的形式标注的关系将绘制在时序视图上，以便显示任务的生命周期和阶段。这包括有关何时

  创建

  、

  启动

  、

  计划

  、

  开始

  、

  结束

  和

  完成

  。

![lifetime-stages-data](../../../../../assets/images/46/4631073fdfd55ab45ec33632c34214dc75fe907feab115d345854768106f353f.png)

- 系统将在当前任务与其

  先决条件

  、

  后续

  和

  嵌套

  任务之间绘制关系。

![task-relations-display](../../../../../assets/images/85/8568f9403faddfe399baf61a678c2cdbd592b89842000029e36aea4f6dfba9cf.png)

- 界面上将出现新的顶部停靠轨道，将任务的阶段显示为时序事件。

### 任务依赖性

激活其中一个或多个选项时，将为当前任务的 **先决条件**、**后续** 和 **嵌套** 任务绘制上一小节中提到的所有关系。

例如，你现在将看到显示描述每个已启用先决条件任务 **已创建（created）** 、**已启动（launched）** 、**已计划（scheduled）** 、**已开始（started）** 、**已结束（finished）** 和 **已完成（completed）** 阶段的关系，而不是从先决条件任务的 **完成时间（Completed Time）** 到当前任务的 **计划时间（Scheduled Time）** 的单一关系：

![undefined](../../../../../assets/images/49/496592921adce5b79458267f27896a8692afffd6a151832f95c9eb974cab036f.png)

> [!TIP]
> 在分析数据时，我们建议你尝试一次激活一个选项，因为关系数量很快就会变得庞大。

1. 当启用 **关键路径（Critical Path）** 选项时，系统将绘制显示当前任务关键路径的关系。关键路径定义为当前任务图表中执行时间最长的执行链。每个组件任务的执行时间定义为组件的完成时间和起始时间（FinishedTime - StartTime）之间的差值。

   > [!NOTE]
   > 此引擎功能是新功能，因此方案可能会随着未来的优化而更改。

   ![undefined](../../../../../assets/images/ff/ffd8d5fabbb400073997c8ed43bf14da6cb5b9063a9d5782e9480450bedc18a4.png)
2. 如果追踪具有任务数据，则 **任务（Tasks）次要选项卡** 将变为可见。要填充选项卡，请在时序视图上选择时间间隔。该选项卡将更新，显示所选间隔内的所有任务。该选项卡将显示包含的每个时间戳选项：已创建、已启动、已计划、已开始、已结束和已完成的时间戳。默认情况下，这些时间戳将显示为 **相对于前一个（Relative to previous）**，这意味着它们将相对于前一阶段，例如, "已计划" 是相对于 "已启动"。 双击表中的任务将绘制它的关系，就好像通过在时序视图中选择时序事件来选择它一样。

> 动图已省略：relations-of-timing-event


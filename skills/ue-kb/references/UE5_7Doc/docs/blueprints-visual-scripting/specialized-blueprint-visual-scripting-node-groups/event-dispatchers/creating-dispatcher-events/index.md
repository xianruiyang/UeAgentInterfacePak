---
title: "创建分发器事件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-dispatcher-events-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "事件分发器", "创建分发器事件"]
---

# 创建分发器事件

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 事件分发器 / 创建分发器事件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-dispatcher-events-in-unreal-engine

使用事件分发器的菜单上的 **事件（Event）** 选项将创建具有正确签名的自定义事件， 这样便可将其绑定到事件分发器。虽然事件节点与[自定义事件节点](../../events/custom-events/index.md)类似，没有连接到 **绑定（Bind）** 节点， 但在执行 **调用[EventDispatcherName]（Call [EventDispatcherName]）** 节点时，此事件绝不会被触发。

## 创建事件分发器事件节点

事件分发器 **事件（Event）** 节点通过将其右上角的红色方形引脚连接到 **绑定事件（Bind Event）** 节点上的红色方形 **事件（Event）** 输入引脚，从而连接到 **绑定事件（Bind Event）** 节点。因此， 如果某个特定事件分发器已经有一个 **绑定事件（Bind Event）** 节点，并且您希望为其创建事件节点：

1. 拖走 **事件（Event）** 输入引脚，然后释放，以显示上下文菜单。
2. 在上下文菜单中选择 **为分发器添加自定义事件（Add Custom Event for Dispatcher）**。
3. 事件节点将被创建并自动正确地连接到 **绑定事件（Bind Event）** 节点。为您的事件输入一个名称。

从事件分发器（Event Dispatcher）菜单或上下文菜单中选择 **分配（Assign）** 也将创建已经连接在一起的一个 **绑定事件（Bind Event）** 节点和一个相应的 **事件（Event）** 节点。

### 在蓝图类中

1. 在 **我的蓝图（My Blueprint）** 选项卡中拖走事件分发器的名称，并将其拖放到您正在使用的图表中。
2. 在显示的菜单中选择 **事件（Event）**。
3. 为您的事件输入一个名称。

### 在关卡蓝图中

您可以在关卡蓝图中设置一种特殊类型的事件分发器事件，在这种情况下，事件会自动绑定到事件分发器。这些事件的创建步骤 与默认事件（例如 **OnClicked** 或 **OnOverlap** 事件）相同。[关卡蓝图文档](../../types-of-blueprints/level-blueprint/index.md#addingevents)提供 此过程的演练。

> [!NOTE]
> 这些特定事件是唯一的，并会在游戏进程开始时自动绑定。因此，无论在何时执行，**取消所有绑定（Unbind All）** 节点都将取消这些事件的绑定。然而， 通过将它们的委托引脚连接到游戏进程中其他时候执行的 **绑定事件（Bind Event）** 节点，则可以重新绑定它们。

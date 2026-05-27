---
title: "调用事件分发器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/calling-event-dispatchers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "事件分发器", "调用事件分发器"]
---

# 调用事件分发器

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 事件分发器 / 调用事件分发器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/calling-event-dispatchers-in-unreal-engine

使用 **Call** 节点调用一个Event Dispatcher(事件分发器)，将会触发绑定到该事件分发器的所有事件。 对于每个事件分发器，您可以应用多个 **Call** 节点，且您既可以在蓝图类中调用事件分发器也可以在关卡蓝图中进行调用。

## 在蓝图类中进行调用

1. 在 **My Blueprint（我的蓝图）** 选卡下，从 Event Dispatcher(事件分发器)名称处开始拖拽鼠标并将其放置到您正处理的图表中。
2. 在出现的菜单中选择 **Call（调用）** 。

**另一种方法:**

1. **右击** 图表。
2. 在出现的关联菜单中展开 **Event Dispatcher（事件分发器）** 。
3. 选择 **Event Dispatcher（事件分发器）** 下的 **Call [事件分发器名称]** 。

## 在关卡蓝图中进行调用

1. 添加到关卡中您想为其调用事件分发器的[Actor的引用](../../types-of-blueprints/level-blueprint/index.md#%E5%BC%95%E7%94%A8actor)。
2. 从该引用节点的输出引脚开始拖拽鼠标，然后释放鼠标来显示关联菜单。
3. 在关联菜单中，导航到 **Event Dispatcher （事件分发器）> Call [事件分发器名称]** 。搜索 "Event Call" 将会快速地弹出正确的选项。

   **Call** 节点将会出现，且Actor引用已经连接到了 **Target** 引脚上。

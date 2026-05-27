---
title: "绑定和解除绑定事件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/binding-and-unbinding-events-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "事件分发器", "绑定和解除绑定事件"]
---

# 绑定和解除绑定事件

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 事件分发器 / 绑定和解除绑定事件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/binding-and-unbinding-events-in-unreal-engine

如果事件分发器未绑定任何事件，对其进行调用将没有任何效果。每个事件分发器均有一个与其相关的事件列表。使用 **Bind Event** 节点可以向此列表中添加事件，使用 **Unbind Event** 节点可以从此列表中移除事件。此外，通过 **Unbind All Events** 节点可以解除当前绑定到事件分发器上的所有事件。

**Bind Event** 节点可以执行多次，但每个事件只能绑定一次。此外，蓝图类和关卡蓝图中的事件都将添加到相同的事件列表中，因此 **Unbind All Events** 节点将解除蓝图类和关卡蓝图中的事件绑定。

- 在蓝图类中执行

  Unbind All Events

  节点后，将针对此类的所有实例来解除蓝图类和关卡蓝图中的事件绑定。
- 在关卡蓝图中执行

  Unbind All Events

  节点后，只会针对

  Target

  提供内容来解除蓝图类和关卡蓝图中的事件绑定。

## 创建Bind、Unbind及Unbind All节点

创建 **Bind Event**、**Unbind Event** 及 **Unbind All Events** 节点的过程非常相似。以下步骤只说明了 **Bind Event** 节点的创建方法，但只要在正确步骤处选择了正确的菜单项目，便也能轻松创建 **Unbind Event** 和 **Unbind All Events** 节点。

### 在蓝图类中创建

1. 在 **我的蓝图（My Blueprint）** 选项卡中，从事件分发器的命名处开始拖动鼠标，放置到正在处理的图表中。
2. 在出现的菜单中选择 **绑定（Bind）**。

**另一种方法：**

1. 在图表中 **点击右键**。
2. 在上下文菜单中搜索 **Bind Event to [EventDispatcherName]** 并选中它。

### 在关卡蓝图中创建

1. 为调用事件分发器的关卡中actor[添加一个引用](../../types-of-blueprints/level-blueprint/index.md#referencingactors)。
2. 从引用节点连出输出引脚，松开后显示快捷菜单。
3. 前往快捷菜单中的 **事件分发器 > 将事件绑定到[事件分发器名]**。搜索"绑定[事件名]"便能迅速呼出正确的条目。

   **Call** 节点将出现，actor引用已连接到 **Target** 引脚。

---
title: "放置节点"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/placing-nodes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图工作流程", "放置节点"]
---

# 放置节点

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图工作流程 / 放置节点

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/placing-nodes-in-unreal-engine

在本页中您将学习到如何在蓝图中的图表上放置节点。

## 拖放

第一种方法是 **拖放**，从 **MyBlueprint** 窗口将节点拖放到图表上。举例而言，在下图中可将 **PlayerHealth** 变量拖入几个变量中并放置在图表上，以便在脚本中使用。

**单击左键** 将一个变量拖进图表窗口后出现两个选项，**Get** 和 **Set**。选择 Get 将创建一个 **Getter** 节点，获取变量或变量值；而选择 Set 将创建一个 **Setter** 节点，对变量值进行设置。根据节点的类型，可能出现只有 Get 一个选项的情况。

在上图中，上方节点是 Getter，下方节点是 Setter。举例而言，Getter 可用作游戏元素的条件（如获取玩家体力值，确认数值是否高于特定范围，如否，判定玩家死亡）。借用相同例子从另一方面来说，Setter 可用于增加玩家的体力值：为玩家体力值变量设置数值。

同理可将创建好的 **函数** 和 **宏** 拖入图表。

- 如需了解详细内容，请参阅

  函数

  或

  宏

  。

按下图所示拖入一个 **Event Dispatcher** 后，一些特殊上下文操作将变为可用状态。

快捷菜单在拖入 Event Dispatcher 时出现，可从中选择需要执行的操作。

查看 [事件分发器](../../specialized-blueprint-visual-scripting-node-groups/event-dispatchers/index.md) 中的详细内容。

## 快捷菜单搜索

多数情况下，可在蓝图图表中 **单击右键** 访问 **快捷菜单** 放置节点。

从上图菜单中展开任意类目（或子类目），然后选择需要的节点添加至图表中。

窗口右上角有一个名为 **Context Sensitive** 的选项。它为默认开启，禁用此选项后将基于当前上下文自动筛选菜单中显示的选项。

如下图所示，**Context Sensitive** 选项开启时 **单击右键** 并搜索 **Animation**，便会出现筛选列表。

然而，如取消勾选 **Context Sensitive** 并搜索 **Animation**，便会出现所有与 animation 相关的内容。

图表中 **单击右键** 呼出快捷菜单，也可拖动现有节点访问快捷菜单。

在上图中有一个 **Character Movement** 组件引用，拖动其输出引脚可添加连接上下文的节点。如下例所示，这些节点和被拖动的节点为相关。

在上图中，搜索 **Set Max Walk**，然后从菜单中选择 **Set Max Walk Speed** 对角色的最高步行速度进行设置。

## 快捷键

也可使用 **快捷键** 替代（和使用）节点，提升工作效率。

查看 [蓝图编辑器速查表](../../specialized-blueprint-visual-scripting-node-groups/blueprint-editor-cheat-sheet/index.md) 中的详细内容。

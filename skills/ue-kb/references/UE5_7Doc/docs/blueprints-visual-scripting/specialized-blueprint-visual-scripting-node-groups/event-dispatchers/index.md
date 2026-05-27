---
title: "事件分发器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/event-dispatchers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "事件分发器"]
---

# 事件分发器

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 事件分发器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/event-dispatchers-in-unreal-engine

> [!NOTE]
> [Blueprint Actor通信](../../../gameplay-systems/gameplay-framework/actors/actor-communication/index.md)页面中的[事件分发器](index.md)示例用蓝图和C++两种语言进行了演示。可被视为蓝图脚本的补充帮助工具。

通过将一个或多个事件绑定到 **事件分发器（Event Dispatcher）**，您可以在调用事件分发器时触发所有这些事件。这些事件可以绑定到蓝图类中，但事件分发器也允许在关卡蓝图中触发事件。

## 创建事件分发器

事件分发器在蓝图编辑器的[蓝图编辑器"我的蓝图"面板](../../user-interface-reference-for-the-bl-73593f79/user-interface-components/my-blueprint-panel-in-the-blueprints-visual-scr-706fb8aa/index.md)选项卡中创建。

若要创建新的事件分发器，请执行以下操作：

1. 在 **我的蓝图（My Blueprint）** 面板中，单击事件分发器类别上的 按钮：.
2. 在名称字段中输入事件分发器的名称，该字段显示在 **我的蓝图（My Blueprint）** 选项卡中列表的末尾。

### 设置属性

通过在 **我的蓝图（My Blueprint）** 面板中选择事件分发器，您可在 **细节（Details）** 面板中编辑其属性。您可以为事件分发器设置提示文本和类别，并可添加输入。

向事件分发器添加输入允许向绑定到事件分发器的每个事件发送变量。这不仅允许蓝图类中的数据流， 还允许蓝图类与关卡蓝图之间的数据流。

向事件分发程序添加输入的过程类似于向函数、自定义事件和宏添加输入和输出的工作流程。如果您希望使用与另一个事件相同的输入，可以使用 **从…复制签名（Copy Signature from）** 下拉菜单来指示事件。 若要将您自己的输入添加到事件分发器，请执行以下操作：

1. 单击 **细节（Details）** 窗格的 **输入（Inputs）** 部分中的 **新建（New）**。
2. 为新输入命名并使用下拉菜单设置其类型。在本例中，有一个名为 **MyStringParam** 的字符串输入参数。
3. 您还可以设置一个默认值，并通过展开参数的条目来指示是否通过参考传递参数。

   > [!NOTE]
   > 若要更改此参数在节点边缘上的引脚位置，请在展开的 **细节（Details）** 窗格条目中使用向上和向下箭头。

## 使用事件分发器

创建了事件分发器后，您就可以添加事件节点，绑定节点和取消绑定与之链接的节点。虽然您可以双击 **我的蓝图（My Blueprint）** 选项卡中的事件分发器条目以打开事件分发器的图表， 但是图表处于锁定状态，因此您无法直接修改事件分发器。绑定法、取消绑定法和指定法都使您能够将事件添加到事件分发器的事件列表中， 而调用法将激活存储在事件列表中的所有事件。

事件、绑定和解除绑定节点都可以添加到蓝图类和关卡蓝图中。除了事件节点，各个节点都有一个 **目标（Target）** 输入引脚：

- 在蓝图类中，此引脚自动设置为

  自身（Self）

  。这意味着事件列表针对该类发生了更改，因此该类的每个实例都会产生变化。
- 在关卡蓝图中，此引脚必须关联到对关卡中该类的一个实例的引用。这意味着，事件列表将仅针对该类的特定实例进行更改。

  关卡蓝图文档

  说明了如何创建您可能需要的任何

  Actor

  参考。

- [绑定和解除绑定事件](binding-and-unbinding-events/index.md) - 将事件添加到事件分发器事件列表（以及从中移除事件）。

- [调用事件分发器](calling-event-dispatchers/index.md) - 调用事件分发器来执行事件列表中当前绑定的所有事件。

- [创建分发器事件](creating-dispatcher-events/index.md) - 创建可以绑定并添加到事件分发器的事件列表中的事件。

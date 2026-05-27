# Set and Get an Actor Reference

---
title: "Set and Get an Actor Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-and-get-an-actor-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图工作流程", "Set and Get an Actor Reference"]
---

# Set and Get an Actor Reference

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图工作流程 / Set and Get an Actor Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-and-get-an-actor-reference-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

在面向对象编程中，变量有两种关键类型：

- **基础类型**，例如整数、文本字符、浮点数和布尔值。
- **对象**，例如 Actor 和 Actor 组件。

获取和设置它们的值时，这两类变量的行为不同。

创建基础类型变量时，会创建该基础类型的新实例，并自动将其值初始化为 0（或该基础类型的等价值）。例如，如果创建一个名为 MyInt 的 Integer 类型变量，该变量会立即以值 0 存在，并且可以开始对它执行数学运算。在变量面板中创建的每个新整数类型变量，都会立即创建一个具有独立值的全新整数； **设置** 它的值会改变该整数的值。

创建对象类型变量时，并不会创建该对象的新实例。相反，该变量会作为指向对象的 **引用** 。可以把该变量理解为一个占位符，它 *可以* 指向任何符合其定义的对象，从而在代码中提供一个快捷入口，便于快速访问该对象。为对象变量设置或赋值时，不会替换或改变之前的对象，而是改变引用指向哪个对象；之前的对象会继续存在，直到被显式删除。要实例化新对象，必须 *构造* 一个对象；要访问它，必须将其分配给某个引用。

本指南以传送器为例，演示与对象引用交互的这些方式。完成以下教程后，你将能够：

- 创建对象引用，并为其分配对象。
- 使用对象引用访问对象函数，并在对象上运行代码。
- 在细节面板中分配对象引用。
- 重新分配对象引用。

## 所需设置

本教程使用具有以下设置的新项目：

- 第三人称模板。
- 仅蓝图。

## 创建引用另一个 Actor 的 Actor

为了演示对象引用如何工作，你将创建一个引用另外两个 Actor 的 Actor：

- A **传送位置**，作为 Actor 被传送到的位置。
- A **目标 Actor**，作为被传送的 Actor。

要设置带有这些引用的 Actor：

1. 创建新的 **蓝图类**，使用 **TriggerBox** 作为父类。将其命名为 **BP_TeleporterActor**.
2. 打开 BP_TeleporterActor 的蓝图并点击 **EventGraph** 标签页。
3. 点击 **+** 按钮，位置在 **变量**面板中，以添加新变量。将其命名为 **TargetActor** 并设置它的 **类型**to **Actor**.
4. 创建另一个 Actor 变量，命名为 **TeleportLocation**。这是目标 Actor 将被传送到的位置。
5. 点击 **眼睛图标** ，用于 **TeleportLocation** ，确保它在细节面板中可见。

![The variables panel in BP_TeleporterActor shows an actor-type variable called TargetActor and another actor-type variable called TeleportLocation. TeleportLocation is marked "public" with an open eye icon](../../../../assets/images/d1/d16c6a1e76876b7cfe495a62514a7f4e5f19854ddf5c542ae9494f4b13ac22ff.png)

这些变量都是可以引用 World 中 Actor 的占位符。它们目前都尚未真正指向 Actor，但可以用它们创建传送器要执行的逻辑。

## 在蓝图中获取 Actor 引用并将其传送到其他位置

现在已经设置好 Actor 变量，接下来创建处理传送的逻辑。为此，需要执行 Get 操作以获取 Actor 引用。

1. 在 BP_TeleporterActor 中，点击并拖拽 **TargetActor** 到事件图表中。在出现的下拉菜单中，点击 **Get TargetActor**。这会创建一个 **Get** 节点。

![The user clicks and drags TargetActor into the EventGraph, then chooses "Get TargetActor" to place a Get node.](../../../../assets/images/31/31092dc288b381b72917347f71d87c00cb646c13d6b3b8794d6d309bb642a7d1.png)

可以从 Get 节点的引脚点击并拖拽，以访问该 Actor 的函数。

1. 从 Get Target Actor 节点点击并拖拽，然后在出现的搜索框中找到 **Set Actor Location** 并点击它以创建新的 Set Actor Location 节点。勾选 **Teleport** 复选框。
2. 连接 **Event ActorBeginOverlap** 到 Set Actor Location 节点。
3. Click and drag **TeleportLocation** 到事件图表中并创建一个 **Get** 节点。
4. 从 **Get TeleportLocation** 在事件图表中点击并拖拽，然后创建新的 **Get Actor Location** 节点。
5. 将 Get Actor Location 节点连接到 **New Location** 引脚，该引脚属于 Set Actor Location 节点。

如果尝试运行这段代码，它会失败并抛出错误，因为 TargetActor 和 TeleportLocation 引用目前都是空的。换言之，它们还没有指向任何对象，只是占位符。接下来的章节会展示如何设置这些值。

## 在蓝图中设置 Actor 引用

接下来，使用 Set 操作，将 Target Actor 设置为进入触发盒的任意 Actor。

1. Click and drag **TargetActor** 从变量面板拖入事件图表。这次创建一个 **Set TargetActor** 节点。
2. 将 Set TargetActor 节点连接在以下两者之间： **Event ActorBeginOverlap** and **Set Actor Location**.
3. 点击并拖拽 **Other Actor** 变量，从 ActorBeginOverlap 连接到输入引脚： **Set TargetActor**.

![The user creates a Set Target Actor node and connects it to the Actor Begin Overlap event.](../../../../assets/images/34/342148a2034bb09563aff71369bb006aba36f9cc82269da0eda8fdffb657e51f.jpg)

这会将 TargetActor 设置为指向进入触发盒的任意 Actor。可以把它理解为记录最后进入传送器的对象。最终图表应如下所示：

![The final graph for this Blueprint.](../../../../assets/images/41/413e88f17eb5ac73ff24f4b39ec2cf7e7609f2db35665b305f99176b8e77ddc8.jpg)

## 在细节面板中设置 Actor 引用

最后，设置要将 Actor 传送到的位置。

1. 点击并拖拽一个 **BP_TeleporterActor** 实例到 World 中。将其重命名为 **Teleporter1**.
2. 点击并拖拽一个空 **Actor**实例到 World 中。将其重命名为 **TeleportLocation1**.
3. 点击 Teleporter1。在 **细节面板**中，点击以下项的下拉菜单： **传送位置**，然后将其设置为 **TeleportLocation1**。也可以使用 **吸管** 从 World 中直接选择它。
4. 移动 Teleporter1，使触发盒完全位于地面上方。在细节面板中找到 **Actor Hidden in Game** setting, then disable it. This will make it possible for you to see the teleporter when you run your game, then walk directly into the trigger box for your teleporter.

如果创建多个传送器，每个传送器都可以设置不同的 Teleport Location，因为这些引用会按每个传送器实例分别跟踪。

## 测试传送器

现在已经为传送器中的对象引用分配了 Actor，它已经可以工作。点击 **Play** 按钮在编辑器中运行游戏，然后直接跑进 Teleporter1 的触发盒。

![The user steps into the teleporter and it transports their character to TeleportLocation1](../../../../assets/images/93/930f1877bc1a1c0dd284bcf8cb8f11194ffb73e3cfa75bb4354bea2fba6e31cb.png)

发生的过程如下：

1. Teleporter1 在 BeginOverlap 事件中获取你的角色，然后将其分配给 TargetActor。
2. 随后它获取 TargetActor 的引用，并将其位置设置为 TeleportLocation1 的位置。TeleportLocation1 的引用是在 Teleporter1 的细节面板中分配的，因此无需在代码中设置该引用。
3. 如果另一个 Actor 进入 Teleporter1 的触发盒，它会将 TargetActor 改为该 Actor，并同样将其传送到 TeleportLocation1。


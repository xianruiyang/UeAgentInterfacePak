---
title: "创建控件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-widgets-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "构建用户界面", "显示你的UI", "创建控件"]
---

# 创建控件

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 构建用户界面 / 显示你的UI / 创建控件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-widgets-in-unreal-engine

创建 **控件蓝图** 并设计好布局之后，若要令其显示在游戏内，需要在另一个蓝图中（例如 **关卡蓝图** 或 **角色蓝图**）使用 **Create Widget** 和 **Add to Viewport** 节点调用它。

在上述示例中，**Create Widget** 节点调用 **类（Class）** 部分下指定的控件蓝图，**返回值（Return Value）** 为生成的结果（**拥有玩家（Owning Player）** 为 **玩家控制器（Player Controller）**，被应用于默认播放器控制器中的空白结果。）**Add to Viewport** 函数用于在屏幕上绘制控件蓝图。这里我们指定Main Menu变量（该变量包含所创建的控件）为添加的目标。

此外，返回值被分配给一个名"Main Menu"的变量，稍后可以由此变量访问控件蓝图，而无需重新创建控件，必要时还可以利用此变量来移除控件。

> [!NOTE]
> 使用 **Remove from Parent** 节点并指定目标控件蓝图，可将控件从显示中移除。

## 设置输入模式和显示光标

有些情况下您可能想要玩家与 UI 进行交互，有些情况下您则想要他们完全忽视掉 UI。有一些节点可以用来决定玩家与 UI 交互的方式，这些节点都是 **设置输入模式** 类型，如下所示。

- 上图左边的

  Set Input Mode Game and UI

  节点，顾名思义，使玩家可以通过输入来操纵游戏和 UI（例如，控制屏幕上的角色的同时可以点击任意的按钮或 UI 元素）。
- 上图中间的

  Set Input Mode Game Only

  节点仅针对游戏启用输入，忽视 UI 元素（完美适用于非交互性 UI 元素，如体力、点数或时间显示）。
- 上图右边的

  Set Input Mode UIOnly

  是用于极端情况的节点，在您只想允许 UI 导航并且不允许游戏输入的情况下使用。这将完全禁用掉所有的游戏控制，UI 将成为所有输入的对象，请谨慎使用该节点。

为了配合上述的节点，您可能想要 **启用/禁用** **鼠标光标** 的显示。为此，可以使用 **Set Show Mouse Cursor** 节点。将 **Get Player Controller** 节点拖离，然后使用 **Set Show Mouse Cursor** 节点并将其设置为 True 或 False 以显示或隐藏鼠标光标。

上图中 **I** 用于切换鼠标光标的显示/隐藏。

## 向控件添加控件

可以通过创建父-子关系将控件添加到其他控件中，其中第二个控件嵌套在第一个控件下。为此，只需将子控件附加到父控件。无需使用 **Add to Viewport** 函数。

上面的示例显示了如何使用 **添加子控件** 功能将一个名为"start_Button"的 **滚动框** 控件附加到名为"Main Menu"的新控件。

> [!NOTE]
> **Add Child** 节点用于在面板中将一个控件变为另一个控件的子/父控件，而 **Add to Viewport** 则将控件像新窗口一样添加到根窗口中。若要移除子控件，需要获取父控件并调用 **RemoveChild**。

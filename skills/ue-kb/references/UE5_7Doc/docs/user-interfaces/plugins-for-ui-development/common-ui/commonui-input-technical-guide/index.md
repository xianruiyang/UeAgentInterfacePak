---
title: "输入技术指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/commonui-input-technical-guide-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "UI开发插件", "Common UI", "输入技术指南"]
---

# 输入技术指南

> 路径：虚幻引擎5.7文档 / 创建用户界面 / UI开发插件 / Common UI / 输入技术指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/commonui-input-technical-guide-for-unreal-engine

**CommonUI** 的输入系统可管理跨平台输入支持，尤其是对于复杂或多层的菜单。本指南详细介绍了CommonUI的输入系统的运作方式，包括：

- 使用 **合成光标** 处理浏览。
- 捕获视口中的输入。
- 输入路由器如何确定哪些控件接收输入。
- 单独的控件如何影响和响应输入路由过程。
- 改变控件响应输入路由的方式。

> [!NOTE]
> 要为你的项目设置输入路由支持，请参阅[CommonUI快速入门指南](../common-ui-quickstart-guide/index.md)中的说明。

## 使用合成光标的游戏手柄浏览

在CommonUI中，多项游戏手柄交互由不可见的合成光标驱动。这意味着，如果你将UI设置为使用鼠标，要让CommonUI表现出正确的行为，你只需让不可见光标位于正确的位置，并像鼠标一样点击即可。此设置简化了跨平台输入流，使其全部通过一个输入路径传输。

此小节详细介绍了合成光标和基本输入的运作方式。它在开篇介绍了合成光标如何在基于 **虚幻运动图形（****UMG）** 和 **Slate** 的通用输入流中注册点击的基础知识。接着它具体介绍了CommonUI的实现方案和它有何差异。

### 使用合成光标/游戏手柄点击

此小节演示了合成光标的工作方式。它使用游戏手柄上的" **接受（Accept）** "或" **默认点击（Default Click）** 操作的输入流来举例说明。

![演示CommonUI如何处理点击的图表](../../../../../assets/images/b4/b48fd7afe9de7c7f010f21b3be059e3350e5cf168ea41d2a0ca9c81da36c78d0.jpg)

通常，虚拟接受键应该映射到 `EKeys::Virtual_Accept` 。在内部，输入流从派生自 `GenericApplication` 的特定于平台的应用程序开始。例如，Windows使用 `FWindowsApplication` 。

此输入由 `FSlateApplication` 使用 `FSlateApplication::ProcessKeyDownEvent` 处理。该方法使用能实现 `IInputProcessor` 接口的输入处理器来处理常规输入，也许还能 **应对** 意外输入。顺利应对意外输入之后，就不再需要常规处理。`FCommonAnalogCursor` 与父类 `FAnalogCursor` 一样，是 `IInputProcessor` 。_它会尝试在 `FCommonAnalogCursor::HandleKeyDownEvent` 中处理按键按下输入。

FCommonAnalogCursor不处理当前控件上 **绑定操作（Bound Actions）** 未捕获的游戏手柄标准"接受（Accept）"操作的输入。而是将输入转发到 `FAnalogCursor::HandleKeyDownEvent` 。`FAnalogCursor` 接着会创建合成鼠标点击事件，供 `FSlateApplication` 处理。

此时，此鼠标事件会经历与普通点击类似的输入处理过程，并触发最终点击。

> [!TIP]
> 要调查普通点击输入输入流，请向 `SButton:OnMouseButtonDown` 添加断点。

#### 合成光标点击故障排除

如果CommonUI的合成光标点击的行为不符合预期，问题来源很可能是 `FPointerEvent` 的某个进程。

下面是你可能遇到的一些问题：

- FPointerEvent未处理正确用户的输入。
- 合成光标未靠近预期位置。
- 在 `FSlateApplication::ProcessMouseButtonDownEvent` 中处理点击时，具有捕获的另一个控件在影响 `FWidgetPath` 。这可能基于输入配置的 `MouseCaptureMode` 发生。
- `FWidgetPath` 是基于使用 `FSlateApplication::LocateWindowUnderMouse` 的位置自然生成的。

> [!NOTE]
> `FWidgetPath` 包含输入可能路由到的控件的列表。

### 合成光标和游戏手柄如何浏览和聚焦

纯粹就浏览而言，CommonUI的行为与UMG的基础实现并无区别。为了方便起见，此小节详细介绍了此过程。

正如之前的小节一样，输入从特定于平台的应用程序开始。此小节使用箭头键或模拟移动来举例说明。输入路由系统会将此UI浏览输入路由到UI中的控件。

> [!NOTE]
> 在此示例中，浏览发生时，假定该控件不是专门用来处理此特定浏览输入的。

![演示CommonUI如何处理浏览焦点的图表](../../../../../assets/images/1c/1c10bff481d2257ad1b3410117dd5fbd8e66261185246ca42516c5113e852758.png)

浏览输入发生时，输入由默认 `SWidget::OnKeyDown` 或 `SWidget::OnAnalogValueChanged` 方法处理。但是，这些默认方法并不会直接更改控件焦点。而是会发生以下情况：

1. 这个浏览方法会使用 `FSlateApplication::GetNavigationDirectionFromKey` 或 `FSlateApplication::GetNavigationDirectionFromAnalog` 将输入转换为浏览方向。它在运行此转换时会考虑控件的浏览配置。
2. 浏览方向会捕获并包含在 `FReply::Handled` 回复中，后者通过 `FReply::SetNavigation` 发送。

   > [!TIP]
   > `FReply` 可以携带大量上下文信息。如需了解详情，请参阅下面的"输入路由"小节中关于[FReply](#%E6%9B%B4%E6%94%B9%E6%8E%A7%E4%BB%B6%E5%A6%82%E4%BD%95%E5%93%8D%E5%BA%94%E8%BE%93%E5%85%A5)的信息。
3. Slate开始使用 `FSlateApplication::ProcessReply` 处理 `FReply` ，这会导致浏览发生。如果浏览事件并未严格定义方向，则 `_FSlateApplication::AttemptNavigation` _会尝试查找要浏览到的正确控件。
4. 如果可能， `FSlateApplication::ExecuteNavigation` 会浏览到目标控件。
5. 如果目标控件有效，将会在该控件上调用 `FSlateApplication::SetUserFocus` 。无论目标控件是直接指定的还是事先发现的，都是如此。
6. Slate焦点浏览发生后， `FCommonAnalogCursor::Tick` 会在下一次更新期间自动 **将合成光标移动到聚焦的控件上并居中** 。

这样就可以在你使用游戏手柄时使用悬停效果。

### 自定义CommonUI中的合成光标行为

你可以在CommonUI中提供你自己的模拟光标或合成光标。这样做的原因可能有多种。例如，如果你要尝试用键盘浏览，而且其功能类似于游戏手柄，即使没有使用游戏手柄时，你也可以使 `FCommonAnalogCursor::Tick` 对齐控件中心。你也可以使合成鼠标可见，也许在焦点更改的空档实现某种逻辑。

要创建自定义光标：

1. 从 `UCommonUIActionRouterBase` 派生
2. 覆盖 `UCommonUIActionRouterBase::MakeAnalogCursor` 以返回你的自定义模拟光标类。

`UCommonUIActionRouterBase::ShouldCreateSubsystem` 被你自己的操作路由器类覆盖之后，不会创建自身的实例。

> [!NOTE]
> 请注意， **输入处理器会在所有输入上运行** 。这包括虚幻编辑器的输入。你可以使用 `FCommonAnalogCursor::IsGameViewportInFocusPathWithoutCapture` 帮助区分你的应用程序和它外部的事项。

## CommonUI输入路由

下面简要概括了输入路由过程：

1. CommonUI会将可激活控件整理为处理浏览的节点树。停用的控件不会添加到节点列表中，因此绝不会考虑用于输入路由。
2. CommonGameViewportClient会捕获输入，然后查找层级中最顶层的绘制节点。
3. 该节点将检查是否可以使用某个可用的输入处理程序处理输入。如果其所有输入处理程序都不匹配玩家的输入，它可以将输入转发到其最顶层的子节点并重复此步骤。

此过程会递归重复，直至检查了所有节点。下方小节更详细地介绍了这些步骤以及此系统的组件。

### 输入路由执行流

如有关[使用合成光标点击](#%E4%BD%BF%E7%94%A8%E5%90%88%E6%88%90%E5%85%89%E6%A0%87%E7%82%B9%E5%87%BB)小节中所述，在输入路由发生之前，优先由输入处理器处理输入事件。如果输入事件未由输入处理器处理，它会经历CommonUI的输入路由流。

#### 点击事件过程

特定于平台的应用程序触发FSlateApplication::ProcessKeyDownEvent时，输入开始。

![演示如何路由键输入的图表](../../../../../assets/images/22/225032f68e6891a4385493527896e4491f95ef1ea6f35ce5a9f7afd55313e0ba.png)

Slate应用程序接着基于当前焦点路径将输入事件转发到控件。在游戏中，此输入事件通常是 `SViewport::OnKeyDown` ，后者接着将按键按下转发到实现了当前视口接口的任意类。转发按键按下通常会触发 `FSceneViewport::OnKeyDown` 。

最后，场景视口会将输入转发到当前游戏视口客户端的InputKey方法。在CommonUI的情况中，这是 `UCommonGameViewportClient::InputKey` 。因此，游戏视口类必须设置为 **CommonViewportClient** ，CommonUI才能正确运行。

> [!NOTE]
> 请参阅[CommonUI快速入门指南](../common-ui-quickstart-guide/index.md)，详细了解如何设置视口客户端类。

#### 操作路由器过程

输入转发到游戏视口客户端时，CommonUI对输入路由的特定实现将开始。`UCommonGameViewportClient::InputKey` 会让 **操作路由器（Action Router）** 有机会处理 `UCommonGameViewportClient::HandleRerouteInput` 中的输入。如果成功，它将调用UCommonUIActionRouterBase::ProcessInput。

如果输入未处理，当通用游戏视口客户端调用 `Super::InputKey` 时，游戏会尝试通过常规方法处理输入。

![演示操作路由器过程的图表](../../../../../assets/images/df/df6ced16e8e78a407c928e5f2d1745a8cc687838ebbd01fe3bf57ab4008e93ee.jpg)

> [!NOTE]
> 可激活控件使用 `FActivatableRootNode` 抽象化为树中的节点。节点基于UI的控件树中的可激活控件层级，以层级排列。父节点充当 **根节点** ，而其子项被视为 **子节点** 或 **叶节点** 。请参阅[CommonUI概述](../overview-of-advanced-multiplatform-user-interfa-69a3403c/index.md)，了解更多信息。

**操作路由器（Action Router）** 在可激活控件树中维持当前活动的根节点。`UCommonUIActionRouterBase::ProcessInput` 会让根节点通过调用 `FActivatableTreeNode::ProcessNormalInput` 来尝试处理输入。这会以递归方式让所有子节点尝试处理输入。

`FActivatableTreeNode` 是 `FActionRouterBindingCollection` ，它维护节点的可激活控件上所有操作绑定的列表。如果当前节点中的所有子节点未能处理输入，当前节点会调用 `FActionRouterBindingCollection::ProcessNormalInput` 。作为绑定集合，当前节点会检查控件的所有操作绑定。如果有操作绑定匹配对应键，将执行相关行为，并且输入被视为已处理。

## 修改输入路由系统

下面是你应该用于更改输入路由系统的主要方法：

- 从 `UCommonGameViewportClient` 派生新的视口类，并覆盖所有输入处理方法。然后，在项目设置中，将游戏视口设置为你的派生类。
- 从 `UCommonUIActionRouterBase` 派生新类，并覆盖所有虚拟函数。例如，你可以覆盖自定义[输入配置](https://dev.epicgames.com/documentation/404)设置的 `UCommonUIActionRouterBase::ApplyUIInputConfig` 。

> [!TIP]
> `UCommonUIActionRouterBase::ShouldCreateSubsystem` 被你自己的操作路由器类覆盖之后，不会创建基础操作路由器的实例。

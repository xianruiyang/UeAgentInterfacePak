# Input Fundamentals

---
title: "Input Fundamentals"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/input-fundamentals-for-commonui-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "UI开发插件", "Common UI", "Input Fundamentals"]
---

# Input Fundamentals

> 路径：虚幻引擎5.7文档 / 创建用户界面 / UI开发插件 / Common UI / Input Fundamentals

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/input-fundamentals-for-commonui-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

[CommonUI](../index.md) 是 [Slate/UMG](../../../umg-editor-reference/index.md) 框架的扩展。CommonUI 实现了一种输入路由方法，但它仍依赖 Slate 现有输入系统的底层逻辑。

本指南的每个小节都包含一些提示或方法，可用于修改 CommonUI 各部分与基础 Slate/UMG 输入系统的交互方式。

## 使用 Input Config 更改应用的 UI 输入处理

有时你可能希望根据当前处于活动状态的 widget 改变应用处理输入的方式。例如，当社交侧边栏或暂停菜单打开时，可能希望阻止玩家在游戏世界中移动。要处理这种情况， **CommonUI**支持可选的 **Input Config** 用于 **Activatable Widget**.

> [!TIP]
> 应用中并不强制使用 Input Config；无论是否使用它们，都可以利用 CommonUI 的其它功能。

### 在 Widget 中使用 Input Config

Input Config 由 `FUIInputConfig` 结构体表示，该结构体位于 `UIActionBindingHandle.h`。每个 Input Config 会跟踪多种输入方式的状态，包括鼠标捕获选项、移动与视角轴处理，以及 CommonUI 使用的整体输入模式。

激活 Activatable Widget 时，它会使用 `UCommonActivatableWidget::GetDesiredInputConfig` 获取 Input Config。该函数默认返回 null Input Config，但可以用任意所需逻辑重写。每当该函数返回 null Input Config 时，CommonUI 都会回退到上一次使用的有效 Input Config。

默认情况下，如果没有任何 Activatable Widget 指定 Input Config，CommonUI 会应用默认 Input Config 作为回退。不过，可以使用 `UCommonInputSettings` 类中的 `bEnableDefaultInputConfig` 变量禁用此行为。

当 widget 停用时，CommonUI 会恢复之前使用的 Input Config，以避免当前 widget 没有合适 Input Config 选项支持而卡住。可以在 `FActivatableTreeRoot::ApplyLeafmostNodeConfig` 函数中找到此实现逻辑。

> [!WARNING]
> 如果停用 UI 中的所有 widget，CommonUI 会默认使用最后一个被停用 widget 的 Input Config。如果存在需要停用 UI 中每个 widget 的用例，请确保最后停用的 widget 会重新应用合理的输入处理状态，以避免软锁。

### 推荐用法

如果使用 Input Config，**应避免在 UI 中使用标准输入配置方法。** 虚函数 `UCommonUIActionRouterBase::ApplyInputConfig` 的默认实现会在设置过程中调用以下标准 UE 配置方法：

- `APlayerController::SetIgnoreMoveInput`
- `UGameViewportClient::SetMouseCaptureMode`
- `UGameViewportClient::SetHideCursorDuringCapture`

因此，将 CommonUI 的 Input Config 与对这些函数的其它调用混用，可能导致它们相互覆盖，从而让输入状态管理变得混乱。

> [!TIP]
> 为简化 Input Config 管理，可以创建一个默认实现，根据 widget 中的枚举值分配常用 Input Config。相关示例请参阅 [Lyra 示例项目](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md)。对于每个 widget 只需要少量固定、非动态 Input Config 的应用，这提供了一个实用实现。

### 输入处理状态参考

`FUIInputConfig` 会跟踪一组输入状态。在 `UCommonActivatableWidget::GetDesiredInputConfig` 中设置 Input Config 后，应已经拥有一套完整配置，用于描述 widget 获得焦点时输入应如何工作。这些状态通过以下变量跟踪：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `InputMode` | Enum / `ECommonInputMode` | 设置 CommonUI 的内部输入模式。 |
| `MouseCaptureMode` | Enum / `EMouseCaptureMode` | 设置 CommonUI 的鼠标捕获模式。 |
| `bHideCursorDuringViewportCapture` | Bool | 如果为 true，视口会在鼠标捕获期间隐藏鼠标光标。 |
| `bIgnoreMoveInput` | Bool | 如果为 true，player controller 会忽略移动输入。 |
| `bIgnoreLookInput` | Bool | 如果为 true，player controller 会忽略视角输入。 |

下表总结了可用于配置 InputMode（`ECommonInputMode`）的模式：

| 输入模式 | 说明 |
| --- | --- |
| Menu | 仅 UI 接收输入。 |
| Game | 仅游戏接收输入。 |
| All | UI 和游戏都会接收输入。 |

下表总结了可用于配置 MouseCaptureMode（`EMouseCaptureMode`）的模式：

| 鼠标捕获模式 | 说明 |
| --- | --- |
| No Capture | 完全不捕获鼠标。 |
| CapturePermanently | 点击视口时永久捕获鼠标，并消费触发捕获的初始鼠标按下事件，使其不会被玩家输入处理。 |
| CapturePermanently_IncludingInitialMouseDown | 与 CapturePermanently 类似，但玩家输入会处理触发捕获的鼠标按下事件。 |
| CaptureDuringMouseDown | 鼠标按钮按下时捕获鼠标，鼠标按钮抬起时释放。 |
| CaptureDuringRightMouseDown | 仅在鼠标右键按下时捕获，不会因其它鼠标按钮捕获。 |

## 使用 FReply 更改 Widget 响应输入的方式

`FReply` 会跟踪输入事件的 handled/unhandled 状态。Slate 中的大多数输入处理器会返回 `FReply::Handled` 或 `FReply::Unhandled`。

- `FReply::Handled` 表示输入通常**不应继续转发**给其它 widget 或输入系统。
- `FReply::Unhandled` 表示即使输入以某种方式被使用，它也**仍应继续转发**给其它 widget 或输入系统进行额外处理。

以下是一些常用 `SWidget` 输入事件：

- `FReply OnKeyUp(const FGeometry& MyGeometry, const FKeyEvent& InKeyEvent);`
- `FReply OnAnalogValueChanged(const FGeometry& MyGeometry, const FAnalogInputEvent& InAnalogInputEvent);`
- `FReply OnMouseMove(const FGeometry& MyGeometry, const FPointerEvent& MouseEvent);`
- `void OnMouseEnter(const FGeometry& MyGeometry, const FPointerEvent& MouseEvent);`

这些函数中有许多（但不是全部）会返回 `FReply`。这些 reply 可以在 Blueprint 中设置或重写，因此如果需要阻止或允许处理某类输入，可以尝试返回特定 `FReply` 来获得所需结果。不过，多数情况下默认 `FReply` 结果对于设计良好的 widget 或 widget 集合已经足够。处理自定义 `FReply` 更多是在 Slate 中处理 widget 时才需要关注的问题。

![Chart illustrating the flow of FReply Input Routing.](../../../../../assets/images/4f/4f9cc3192fb08e445ae7421ac1834e5d8709da1737304a9049ac328363207ced.jpg)

图表展示 FReply 输入路由流程。输入从平台自身输入事件开始，然后转发到 Slate Application。Slate Application 随后将其发送到 widget，widget 使用 FReply 判断该输入是 Handled 还是 Unhandled。此过程会重复，直到输入被 Handled，或所有 widget 都已检查完。

### FReply 设置

`FReply` 会跟踪输入事件的 handled/unhandled 状态，但也可以在 `FReply` 中跟踪额外数据，例如以下成员：

| 参数 | 说明 |
| --- | --- |
| **CaptureMouse** | 请求系统将所有鼠标事件转发给特定 widget。 |
| **ClearUserFocus** | 请求系统清除用户焦点。 |
| **ReleaseMouseCapture** | 请求系统释放鼠标捕获。 |
| **SetUserFocus** | 请求系统将用户焦点设置到提供的 widget。 |
| **SetNavigation** | 请求系统尝试导航到指定目标。 |

> [!TIP]
> 上面的列表并不完整，只是用于展示你可能会看到哪些类型的方法。完整列表请参阅 [官方 C++ API](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/SlateCore/Input/FReply?application_version=5.5) for `FReply` for a complete listing.

其中一些事件，例如 `FReply::CaptureMouse` 和 `FReply::SetUserFocus`，会接收额外参数，包括目标 widget。

熟悉 UMG 或 Slate 的人可能会觉得这些方法很眼熟。不过，它们位于 `FReply` 命名空间中，这意味着可以修改 Slate 处理 `FReply` 时发生的行为。在 `FReply` 中调用这些方法，可能产生稍有不同的行为，且不容易通过在 `FReply` 外部调用等效方法复制。

### 什么时候应设置 FReply？

举例说明何时使用 `FReply`：假设需要在按键时设置或清除 widget 焦点。通常，你可能会尝试在按键处理器中直接调用 `FSlateApplication` 上的相关函数来改变 widget 焦点。

这种方法并非在所有场景下都有效，尤其是在使用 Input Routing 时，因为你试图在 **当前 widget 仍在处理输入时**更改或清除焦点。此输入流程可能导致非预期行为。

因此，建议让 Slate 完整处理输入，然后使用输入事件 reply 或 `FReply` 处理这类更改。

> [!NOTE]
> 最初，`FReply` API 中控制或公开的状态只应使用 `FReply` 设置。后来发现这过于受限，因此此工作流更多是推荐准则。不过我们强烈建议采用它，因为这是首选工作流。

## 自定义 UI 中的导航

本节提供在 CommonUI 中自定义导航的指南和选项。

### Navigation Config（导航配置）

> [!NOTE]
> Navigation config 与 CommonUI 没有直接关系，但理解它们有助于理解输入处理。

无论是否启用 CommonUI，Slate 都支持方向导航。使用 **Navigation Config（导航配置）** 或 `FNavigationConfig` 可以确定哪些按键映射到方向：

- Left（左）
- Right（右）
- Up（上）
- Down（下）
- Next（下一个）
- Previous（上一个）

> [!NOTE]
> Slate 使用方向导航并不需要手动导航配置。

要设置 Navigation Config，请调用 `FSlateApplication::SetNavigationConfig`。通常会使用派生自 `FNavigationConfig` 的自定义 navigation config 调用此函数。例如，如果希望用户使用 WASD 键与 UI 交互，这里会是理想起点。

> [!TIP]
> 也可以通过调用 `FSlateUser::SetUserNavigationConfig` 按用户设置 navigation config。

### 手动控制导航

要手动设置导航事件发生时的行为，请在 UMG 中选择一个 widget，然后找到 **Navigation** 部分，该部分位于 **Details 面板**。此部分包含每个方向的选项。

![Example of manually setting navigation events in the Details Panel.](../../../../../assets/images/b2/b241f9356ec18b85ba3029822a960033ce4b311c5d33e6ed5eb92432feeea76d.png)

下表详细说明这些选项：

| 导航控制选项 | 说明 |
| --- | --- |
| **Escape** | 允许移动沿该方向继续，并自动寻找下一个可导航 widget。 |
| **Explicit** | 移动到特定 widget。 |
| **Wrap** | 在此容器内环绕移动；如果导航尝试会离开容器，则从相反侧循环回来。 |
| **Stop** | 停止该方向上的移动。 |
| **Custom** | 由用户代码处理的自定义导航。 |
| **CustomBoundary** | 如果命中边界，则由用户代码处理自定义导航。 |

例如，下面是一个适合使用 **Explicit** 的用例：

![Example of buttons offset in such a way that automatic navigation might not be intuitive.](../../../../../assets/images/6b/6b3b3ee0592766bf25c2322b6a8daaae72dfcf440845d78c07cee3d1f7bc75a4.jpg)

在此示例中，上方和下方按钮与左侧获得焦点的按钮没有垂直重叠。由于没有重叠，如果向右导航，Unreal 会聚焦到最右侧、距离最远的按钮。如果希望向右导航到上方按钮，可以通过 Navigation 设置来配置。

![Example of Right navigation set to Explicit in the Details panel](../../../../../assets/images/1b/1b0e0a1add49870c0c5efd9361dc6d11261cc8da634d5229c69e5c5b00438913.png)

通过将 Explicit 导航设置到 **TopButton** widget，每当用户按下 Right 时，就会改为聚焦该 widget。

> [!NOTE]
> 要将 widget 设置为 Explicit 导航目标，必须手动命名它。这可以确保导航行为长期可维护。

## Activatable Widget 与 Action Binding

本节说明如何自定义 UI 中 Activatable Widget 与已绑定 Input Action 的行为。

### 激活时为 Activatable Widget 设置焦点

每当激活 Activatable Widget 时，它都会调用 `UCommonActivatableWidget::GetDesiredFocusTarget` 函数，以选择 CommonUI 应将用户输入焦点放在哪个 widget 上。

> [!WARNING]
> 如果没有实现自定义版本的 `GetDesiredFocusTarget`，CommonUI 可能难以在 widget 激活和停用时知道应聚焦哪里。因此，**强烈建议始终在 Activatable Widget 中实现此函数。**

In the [Lyra 示例项目](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md)中，每个 Activatable Widget 类都有一个自定义 Enum 类型，用于确定获取所需焦点目标的方法。对于大多数使用固定、非动态方法确定默认焦点的菜单，建议采用类似实现。

### 更改触发 Input Action 的触发时机

为 action binding 创建 `FBindUIActionArgs` 时，将 `FBindUIActionArgs::KeyEvent` 设置为应触发事件的 action 类型，例如 `IE_Released`。

## CommonUI 控制台变量参考

可以使用下表中的控制台变量配置 CommonUI 的功能方式并获取调试信息：

| CVar | 说明 |
| --- | --- |
| CommonUI.bDumpInputTypeChangeCallstack | 如果为 true，当输入类型变化时，CommonUI 会转储调用栈。这对于调试输入类型看似快速变化的问题很有用。 |
| CommonInput.ShowKeys | 切换是否显示当前输入设备的按键。 |
| CommonInput.EnableGamepadPlatformCursor | 切换在 gamepad 输入期间是否启用光标。 |
| UseTransparentButtonStyleAsDefault | 如果为 true，**CommonButtonBase** 中 `SButton` 的默认 **Button Style** 会被设置为 **NoBorder**，该样式具有透明背景且没有 padding。 |
| Mobile.EnableUITextScaling | 启用移动端 UI 文本缩放。 |
| ActionBar.IgnoreOptOut | 如果为 true，**Bound Action Bar** 会显示绑定，无论这些绑定是否已配置。 |
| CommonUI.AlwaysShowCursor | 如果为 true，无论当前 Input Config 如何，CommonUI 都会始终显示鼠标光标。 |
| CommonUI.VideoPlayer.PreviewStepSize | CommonVideoPlayer 的时间步长。 |


# 在仅 UI 模式下处理输入：虚幻引擎开发人员综合指南

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/KPr1/handling-input-in-ui-only-mode-a-comprehensive-guide-for-unreal-engine-developers

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4701 字符。

## 摘要

本文介绍了如何使用自定义输入处理器在虚幻引擎中捕获用户输入，即使是在“仅 UI”模式下也是如此。它强调了开发游戏日志系统（GLS）插件时面临的挑战，特别是由于输入限制而覆盖层未显示在主菜单中。本文提供了一种拦截所有输入事件的解决方案，无论输入模式如何，并演示了该方法如何确保覆盖适用于所有设备类型。

## 中文整理

### 即使在仅 UI 模式下如何捕获用户输入

在开发**游戏日志系统 (GLS)** [插件](https://fab.com/s/43bbed079742) 期间，我们遇到了一个具有挑战性的问题。该插件的主要功能之一是将日志显示为游戏顶部的叠加层。此覆盖必须在所有平台（**桌面、移动设备、控制台**等）上打开并正常运行，无论控制器的输入模式设置如何（例如，仅游戏、仅 UI 或游戏和 UI）。

### 问题

发布插件后，我们开始收到用户的错误报告，指出叠加层不会显示在**主菜单屏幕**中，尽管它在其他地方运行良好。经过调查，我们发现许多主菜单将输入模式设置为“仅 UI”。此模式完全禁用 PlayerController 的输入处理，这意味着任何按键或控制器输入都将停止注册。由于我们的插件允许用户配置自己的输入映射（例如组合键或触摸手势）来打开覆盖层，因此我们不能依赖预定义的映射。我们需要一种方法来捕获**所有按键和屏幕触摸**，即使 PlayerController 没有处理它们。

### 目标

我们必须开发一个能够： 1. 捕获所有按键和触摸手势的系统，无论输入模式如何。 2. 支持多种设备和输入类型（键盘、游戏手柄、触摸）。 3. 与自定义用户定义的输入映射无缝协作。

### 解决方案

在探索了虚幻引擎的输入处理系统后，我们找到了完美的工具：**输入处理器**。 IInputProcessor 接口允许您绕过 PlayerController 直接从 Slate 应用程序拦截输入事件。这使得即使在仅 UI 模式下也可以处理按键和手势。

### 以前是如何运作的

最初，我们依靠通过 PlayerController 和输入操作进行的标准输入绑定。代码如下：

```cpp
void UGLSOverlaySubsystem::BindInput()
{
    // Example of a standard action binding
    PlayerController->InputComponent->BindAction("OpenOverlay", IE_Pressed, this, &UGLSOverlaySubsystem::ToggleOverlay);
}
```

此方法仅适用于仅游戏或游戏和 UI 模式。当输入模式切换到仅 UI 时，绑定停止工作。

### 现在如何运作

为了解决这个问题，我们创建了一个实现 IInputProcessor 接口的自定义类。该处理器直接拦截来自应用程序的所有输入事件。我们是这样实现的：

### 创建输入处理器：

```cpp
class FGLSInputProcessor : public IInputProcessor
{
public:
    virtual const TCHAR* GetDebugName() const override
    {
        return TEXT("FGLSInputProcessor");
    }

    virtual bool HandleKeyDownEvent(FSlateApplication& SlateApp, const FKeyEvent& InKeyEvent) override
    {
```

HandleKeyDownEvent 和 HandleMouseButtonDownEvent 方法允许我们处理按键和触摸手势。 IsOverlayToggleKey 和 IsOverlayGesture 的逻辑取决于插件设置中配置的用户定义的输入映射。收到事件后，您可以从输入处理器内触发委托并在游戏对象中捕获它。

### 注册输入处理器：

我们在子系统初始化期间注册了自定义处理器：

```cpp
void UGLSOverlaySubsystem::Initialize(FSubsystemCollectionBase& Collection)
{
    Super::Initialize(Collection);
    FSlateApplication::Get().RegisterInputPreProcessor(MakeShared<FGLSInputProcessor>());
}
```

通过向 Slate 应用程序注册处理器，我们确保它可以拦截所有输入事件，无论输入模式如何。

### 结果

通过此实现，叠加层现在可以在所有输入模式下完美运行，包括仅 UI。它还支持所有平台和输入类型，为用户提供充分的灵活性来配置他们喜欢的按键或手势。您可以在[我们的文档](https://dev.epicgames.com/community/learning/tutorials/m36v/unreal-engine-fab-game-logs-system-gls-real-time-log-management-for-shipping-builds-on-mobile-and-console-platforms)中查看结果并了解有关该插件的更多信息。

![教程图片](assets/handling-input-in-ui-only-mode-a-comprehensive-guide-for-unreal-engine-developers/image-01.jpg)

### 结论

事实证明，使用输入处理器是解决我们问题的一种优雅且有效的解决方案。如果您正在开发的系统需要独立于输入模式处理用户输入，我们强烈建议您探索这种方法。

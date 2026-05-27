# Console Slate Debugger

---
title: "Console Slate Debugger"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/console-slate-debugger-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "测试和调试", "Console Slate Debugger"]
---

# Console Slate Debugger

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 测试和调试 / Console Slate Debugger

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/console-slate-debugger-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

在开发应用程序用户界面（UI）时，UI 开发者有时需要调试 Slate，此时 **Console Slate Debugger** 可以提供帮助。Console Slate Debugger 会接入 [FSlateDebugging](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/SlateCore/Debugging/FSlateDebugging?application_version=5.5) 中的可用系统，以打印 Slate 内部数据。此外，当 UI 焦点发生变化（或尝试变化）时，开发者需要知道哪个系统正在处理这些焦点更新。

> 图片已省略：Console Slate Debugger

Console Slate Debugger

Console Slate Debugger 的扩展包括以下内容：

- GlobalInvalidation，可帮助识别导致高开销帧的 Widget。
- 一个绘制选项，用于显示给定帧中被绘制的 Widget。
- 一个额外的路由选项，用于查看系统如何选择某个 Widget 作为事件处理器。
- 额外的筛选器和事件控制台命令。

> [!TIP]
> 本页截图来自 Lyra Sample Game 项目。要在 Lyra 中测试 SlateDebugger 命令，请使用命令 `Slate.EnableGlobalInvalidation 1` 启用 [Global Invalidation](../../optimizing-user-interfaces/invalidation-in-slate-and-umg/index.md)，因为它默认未激活。

## SlateDebugger

在 PIE 模式运行项目时，按波浪号（~）键打开 PIE Console，并输入 `SlateDebugger`.

> [!NOTE]
> SlateDebugger 日志通常写入 `[ProjectName].txt` 日志文件，位置在 `[ProjectName]/Saved/Logs`.

### 事件命令

Slate Debugger 提供许多不同命令，可用于定位特定信息，例如启用或禁用特定日志、筛选事件等。如果需要更多信息，CaptureStack 还可以提供触发事件的调用栈。

| SlateDebugger.Event | 命令说明 |
| --- | --- |
| **Start** | 的别名： `SlateDebugger.Event.Start` ，用于启动 Slate Console Debugger。 |
| **Stop** | 的别名： `SlateDebugger.Event.Stop` ，用于停止 Slate Console Debugger。 |
| **SetInputFilter** | 启用或禁用特定输入筛选器。 |
| **SetFocusFilter** | 启用或禁用特定焦点筛选器。 |
| **LogWarning** | 记录警告事件。 |
| **LogInputEvent** | 记录输入事件。 |
| **LogFocusEvent** | 记录焦点事件。 |
| **LogExecuteNavigationEvent** | 记录执行导航事件。 |
| **LogCaptureStateChangeEvent** | 记录光标状态变化事件。 |
| **LogCursorChangeEvent** | 记录光标变化事件。 |
| **LogAttemptNavigationEvent** | 记录尝试导航事件。 |
| **InputRoutingModeEnabled** | 启用后，输出输入事件采用的路由。 |
| **EnableAllInputFilters** | 启用所有输入筛选器。 |
| **DisableAllInputFilters** | 禁用所有输入筛选器。 |
| **EnableAllFocusFilters** | 启用所有焦点筛选器。 |
| **DisableAllFocusFilters** | 禁用所有焦点筛选器。 |
| **CaptureStack** | 启用后，在发生事件时捕获调用栈。 |

### 失效命令

这些命令允许使用 Invalidate 命令显示屏幕上已失效的 Widget。每个失效 Widget 会根据失效类型以不同颜色高亮。

![SlateDebugger.Invalidate displays the state of each widget during the invalidation process.](../../../../assets/images/20/2079130d86141f3a1818b1f23d8993004a55df453908b31e704552484d21a43f.png)

SlateDebugger.Invalidate 会显示失效过程中每个 Widget 的状态。

| SlateDebugger.Invalidate | 命令说明 |
| --- | --- |
| **Enable** | 根据当前状态，启动 Invalidation Widget 调试工具并在 Widget 失效时显示，或停止 Invalidation Widget 调试工具。 |
| **Start** | 启动 Invalidation Widget 调试工具，并在 Widget 失效时显示。 |
| **Stop** | 停止 Invalidation Widget 调试工具。 |
| **SetInvalidateRootReasonFilter** | 启用 Invalidate Widget Reason 筛选器。用法为 `SetInvalidateRootReasonFinder [None][ChildOrder][Root][ScreenPosition][Any]`. |
| **SetInvalidateWidgetReasonFilter** | 启用 Invalidate Root Reason 筛选器。用法为 `SetInvalidateWidgetReasonFinder [None][ChildOrder][Root][ScreenPosition][Any][None][Layout][Paint][Volatility][ChildOrder][RenderTransform][Visibility][Any]`. |
| **ToggleLegend** | 显示颜色图例。 |
| **ToggleLogInvalidateWidget** | 将失效 Widget 记录到控制台。 |
| **ToggleWidgetNameList** | 显示失效 Widget 的名称。 |

### 绘制命令

此命令用于高亮每帧被绘制的 Widget。这有助于识别即使未发生变化仍然被绘制的 Widget。注意，volatile Widget 每帧都会绘制。

> 图片已省略：SlateDebugger.Paint displays which widgets are re-drawing on the screen.

SlateDebugger.Paint 会显示屏幕上哪些 Widget 正在重新绘制。

| SlateDebugger.Paint | 命令说明 |
| --- | --- |
| **Enable** | 根据当前状态，启动 Paint Widget 调试工具并在 Widget 绘制时显示，或停止 Paint Widget 调试工具。 |
| **Start** | 启动 Paint Widget 调试工具，并在 Widget 绘制时显示。 |
| **Stop** | 停止 Paint Widget 调试工具。 |
| **LogOnce** | 记录上次更新期间绘制过一次的 Widget。 |
| **LogWarningIfWidgetIsPaintedMoreThanOnce** | 如果某个 Widget 在同一帧中绘制超过一次，则记录警告。 |
| **MaxNumberOfWidgetDisplayedInList** | 显示以下命令激活时可显示的最大 Widget 数量： `DisplayWidgetNameList` 处于激活状态。 |
| **ToggleWidgetNameList** | 显示已绘制 Widget 的名称。 |

### 更新命令

此命令用于高亮更新频率超过必要程度的 Widget。由于 Widget Update 可以被覆盖或在蓝图中执行，如果 Widget 代码设计不当，它是性能问题的常见来源。

![SlateDebugger.Update displays which widgets are updating with color coded information. This image is set to filter for only Repaint events, which use yellow.](../../../../assets/images/c6/c6a5bd766403ca2ec54bc2cd4e8de40698e4762f885b8028e817d4c5e5dd556f.png)

SlateDebugger.Update 会以颜色编码信息显示哪些 Widget 正在更新。此图像设置为仅筛选 Repaint 事件，Repaint 使用黄色。

| SlateDebugger.Update | 命令说明 |
| --- | --- |
| **Enable** | 根据当前状态，启动 Update Widget 调试工具并在 Widget 更新时显示，或停止 Update Widget 调试工具。 |
| **Start** | 启动 Update Widget 调试工具，并在 Widget 更新时显示。 |
| **Stop** | 停止 Update Widget 调试工具。 |
| **SetInvalidationRootIdFilter** | 仅显示属于失效根的 Widget。 |
| **SetWidgetUpdateFlagsFilter** | 如果某个 Widget 在同一帧中绘制超过一次，则记录警告。启用或禁用特定 Widget 更新标志筛选器。用法为 `SetWidgetUpdateFlagsFilter [None][Tick][ActiveTimer][Repaint][VolatilePaint][Any]`. |
| **ToggleLegend** | 显示颜色图例。 |
| **ToggleUpdateFromPaint** | 显示没有更新标志，但仍作为其他 Widget 的副作用被更新的 Widget。 |
| **ToggleWidgetNameList** | 显示 Update Widget 的名称。 |


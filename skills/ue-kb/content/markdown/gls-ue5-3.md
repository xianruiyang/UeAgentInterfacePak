# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答（续 3）

# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答（续 3）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/lpbK/unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5
- 原始文件：unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5.origin.md
- 分段：第 3/5 段

因为 GLS_LOG 依赖于 UObject 上下文来附加元数据（类、对象、函数、网络角色、PIE 实例等）。如果该类没有 UObject 基础，则 GLS_LOG 无法捕获此上下文。在非 UObject 类（结构、帮助器、静态实用程序）中，只需使用： - UE_LOG - 或通过手动作为上下文传入的 UObject 调用 GLS_LOG_CONTEXT。或者通过手动作为上下文传入的 UObject 调用 GLS_LOG_CONTEXT。

### 如何使用 GLS_LOG_CONTEXT，它与 GLS_LOG 有什么不同？

GLS_LOG_CONTEXT 允许您手动传递应充当日志上下文的 UObject： 区别： - GLS_LOG 尝试自动捕获上下文（从此）。 GLS_LOG 尝试自动捕获上下文（从此）。 - GLS_LOG_CONTEXT 在自动上下文不可用时使用 - 例如，在静态函数或辅助类中。当自动上下文不可用时，例如在静态函数或辅助类中，使用 GLS_LOG_CONTEXT。即使您位于 UObject 方法之外，它也允许您将日志附加到正确的对象。

### GLS_LOGFMT 是如何工作的，它与 UE_LOGFMT 有何不同？

GLS_LOGFMT 的工作方式与 UE_LOGFMT 相同 - 它通过 fmt::format 使用 {0} {1} {2} 样式格式。主要区别在于 GLS_LOGFMT 还收集完整的 GLS 上下文，而 UE_LOGFMT 则不会。使用 GLS_LOGFMT，您可以获得： - 像 UE_LOGFMT 一样的格式化，像 UE_LOGFMT 一样的格式化， - 加上按类、对象、函数、标签、网络角色、PIE 实例等过滤，加上按类、对象、函数、标签、网络角色、PIE 实例等过滤， - 加上 GLS 覆盖层中的可见性（包括运输）。加上 GLS 叠加层中的可见性（包括运输）。所以 GLS_LOGFMT = UE_LOGFMT + 高级 GLS 上下文。

### GLS_LOG_STRING 如何工作？何时应该使用它来代替 GLS_LOG？

当您已有 FString（或运行时生成的字符串）并且不想使用 TEXT() 格式时，请使用 GLS_LOG_STRING。示例： FString Msg = FString::Printf(TEXT("值：%d"), Count); GLS_LOG_STRING(LogTemp, 显示, 消息);在以下情况下使用它而不是 GLS_LOG： - 您的日志文本作为 FString 动态生成，您的日志文本作为 FString 动态生成， - 您不想将字符串转换回 TEXT() 格式，您不想将字符串转换回 TEXT() 格式， - 或者您需要记录原始 FString 数据（例如，JSON、长文本、组合字符串）。或者您需要记录原始 FString 数据（例如 JSON、长文本、组合字符串）。它的行为与 GLS_LOG 相同，包括完整的 GLS 上下文支持。

### 如何添加自定义标签并通过它们过滤日志？

您可以在 C++ 和蓝图中附加自己的标签。 GLS_LOG_TAGS( LogTemp, Display, TArray<FString>{ TEXT("AI"), TEXT("BossFight") }, TEXT("Boss 开始追玩家") );在蓝图中： - 使用 PrintStringToGLSWithTags 使用 PrintStringToGLSWithTags - 传递一个数组，如 ["AI", "BossFight"]。传递一个数组，如 ["AI", "BossFight"]。所有这些标签都显示在 GLS 叠加层的标签面板中，您可以在其中： - 单击标签以仅显示带有该标签的日志，单击标签以仅显示带有该标签的日志， - 将标签与其他过滤器（类、对象、函数等）组合。将标签与其他过滤器（类、对象、函数等）结合起来。

### 蓝图记录

### 如何将 PrintStringToGLS 和 PrintStringToGLSWithTags 与手动日志颜色结合使用？

两个蓝图节点都允许您覆盖日志颜色，以便消息以您选择的颜色准确地显示在 GLS 叠加层中。使用 PrintStringToGLS 或 PrintStringToGLSWithTags → 将文本颜色引脚设置为您想要的任何 LinearColor。所选颜色为： - 保存在蓝图中，保存在蓝图中， - 在游戏中应用，在游戏中应用， - 在 GLS 覆盖层内显示完全相同，在 GLS 覆盖层内显示完全相同， - 并在覆盖层的颜色图例中显示。并显示在叠加层的颜色图例中。使用标签：颜色覆盖独立于基于详细程度的颜色自动选择工作，因此您选择的颜色始终获胜。

### 过滤器、选项卡、搜索

### 我应该如何以及何时使用命名选项卡，它们的设置在会话之间是否保留？

当您使用不同的系统（AI、UI、多人游戏、库存等）并希望每个系统都有单独的日志视图时，命名选项卡是完美的选择。您可以： - 创建多个选项卡，创建多个选项卡， - 重命名它们（例如，AI 调试、复制、UI 错误），重命名它们（例如，AI 调试、复制、UI 错误）， - 设置单独的过滤器（类别、对象、标签、PIE 实例、网络角色、详细程度等）。设置单独的过滤器（类别、对象、标签、PIE 实例、网络角色、详细程度等）。每个选项卡都会记住： - 选定的过滤器，选定的过滤器， - 隐藏类别，隐藏类别， - UI 布局（哪些面板打开）， UI 布局（哪些面板打开）， - 过滤器模式（AND/OR），过滤器模式（AND/OR）， - 滚动位置。滚动位置。是的 - 所有选项卡设置都保留...

### 为什么类/对象/标签过滤器在重新启动 PIE/游戏后会重置？

### AND/OR 过滤逻辑如何工作，何时应启用 bStrictFilterMode？

### 当类别太多时，如何快速找到自己需要的类别？

### 哪些设置会影响过滤性能？

### 为什么GLS感觉很慢或者日志很多打开时间很长？

### 颜色、UI、复制、保存

### 如何为我的日志设置自定义颜色？

### 复制或保存日志时“尊重 UI 格式”设置如何工作？

### 复制或保存日志时“尊重 UI 格式”设置如何工作？

### 我可以将日志保存到自定义格式的文件中吗？

### 如何启用会话日志文件，GLS 将文件保存在哪里？

### 我可以将之前保存的日志文件加载回 GLS 吗？

### 平台（移动、VR、PS、XBOX）

### 如何在移动设备上打开 GLS，如果手势不起作用怎么办？

### 如何在 VR/AR 中使用 GLS，以及为什么叠加层显示不正确？

### 叠加行为和输入控制

### 如何阻止在特定关卡或某些游戏模式下打开 GLS？

### 打开/关闭 GLS 叠加层时，何时应更改输入模式行为？

### 我可以禁用覆盖但保持启用日志收集吗？

### 高级功能和集成

### GLS 是否支持通过 WebSocket 或 HTTP 发送日志？

### 我可以创建自定义日志处理程序以将 GLS 日志发送到外部服务器吗？

### 为什么要禁用自动函数/类标签，它如何影响性能？

### 更新，支持

### 如何正确更新 GLS 以避免编译错误或冲突？

### 我如何知道 Fab 上何时有新的 GLS 更新？

### 在哪里可以阅读 GLS 变更日志？

### 我如何联系支持人员或获得集成帮助？


# 在序列器中设置帧值时的差异：显示帧速率与刻度分辨率帧速率

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/kjjO/unreal-engine-discrepancy-when-setting-frame-values-in-sequencer-display-frame-rate-vs-tick-resolution-frame-rate

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2559 字符。

## 摘要

文章由 Austin C 撰写。在 4.20 Sequencer 中，重构了其时间表示形式，使其基于整数而不是浮点数。更多详细信息可以在此文档页面上找到。因此，Sequencer 维护了两个 f...

## 中文整理

### 概览

*由 [Austin C.] 撰写的文章(https://dev.epicgames.com/community/profile/L4b2/PiranhaSauce)* 在 4.20 中，Sequencer 将其时间表示重构为基于整数而不是浮点数。更多详细信息可以[在此文档页面上](https://docs.unrealengine.com/en-US/AnimatingObjects/Sequencer/Workflow/TimeRefactorNotes/index.html)找到。因此，Sequencer 为序列维护两个帧速率，以区分用于概念化序列的 FPS 和用于评估和对子帧上的内容进行关键帧处理的更细粒度的速率，分别是显示速率和刻度分辨率。显示速率允许使用熟悉的 FPS 数字进行创作和编辑，该数字对应于典型的媒体帧速率，并且在将序列渲染到磁盘时也使用。刻度分辨率允许在不使用浮点的情况下进行精细的子帧键控，从而保持帧和子帧的准确性。帧编号 (FFrameNumber) 基于 Tick Resolution 存储在序列数据中。当通过时间线编辑器编辑这些值时，我们使用详细信息自定义自动转换为刻度分辨率（请参阅 FFrameNumberDetailsCustomization）。这意味着在 UI 中设置帧值采用熟悉的 FPS 值，并自动正确存储它们。帧编号可能会在帧偏移（例如镜头部分的起始帧偏移）或帧范围的上下文中遇到，并且可以通过我们的脚本 API 使用这些值。在大多数情况下，我们提供处理这些转换的设置器，但有时您可以直接访问这些值，在这种情况下您将在“刻度分辨率”中工作，因为详细信息自定义仅适用于编辑器 UI。如果您看到的结果似乎因很大因素而偏离，则可能是通过在“显示速率”帧值而不是“刻度分辨率”值中设置值来使用错误的帧速率。您可以使用以下公式转换为刻度分辨率值： 帧值 * ( 序列的刻度分辨率 / 序列的显示速率 ) UMovieSceneSequenceExtensions 中有用于获取显示速率和刻度分辨率的函数，这些函数在蓝图和 Python 中可用。如果您有兴趣，可以查看我们内部使用 FrameRate.h 中的 ConvertFrameTime 进行的全帧转换


---
title: "Trace开发者指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developer-guide-to-tracing-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "追踪", "Trace开发者指南"]
---

# Trace开发者指南

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / 追踪 / Trace开发者指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developer-guide-to-tracing-in-unreal-engine

Skill Family: Foundation

**Trace** 是一种结构化的日志记录框架，用于追踪运行进程中的仪表测量事件。该框架能够生成自我描述、轻松使用、易于分享的高频率追踪事件流。模块 **Tracelog** 和 **TraceAnalysis** 是构成框架的重要模块。

Unreal Insights的主要部件有 **追踪事件（Trace events）** 、用于记录和保存应用程序中Trace的 **虚幻Trace服务器（Unreal Trace Server）** 以及用于分析和可视化数据的Unreal Insights。

![insights-major-components-diagram](../../../../../assets/images/20/20c4950d36230982fd8475f321864e1a9c54ddf50fc619739a6eda3062ce4521.png)

储存的Trace会话简明易懂并且可以反向兼容。它们被保存在.utrace文件中，自动生成的附加数据储存在Trace文件旁边的.ucache文件中。

Trace数据以数据包的形式传递，即所谓的 **传输（Transport）** 。每个数据包都有一个内部识别符，表明事件来源的线程和规模大小。数据包采用LZ4压缩，除非规模过小导致压缩缺乏效益。

## 在应用程序中追踪事件

虚幻引擎有一系列预定义的事件类型。这些类型涵盖常见分析信息，例如性能定时器和内存分配。事件由 `Core/ProfilingDebugging` 文件夹中的宏或接口公开。

我们强烈推荐你在实现自己的自定义事件类型之前使用这些API。使用内置事件类型时，内置分析器和可视化会让你受益良多。

### 定时器

最常见的分析任务是测量应用程序的性能。在 `Core/ProfilingDebugging/CpuProfilingTrace.h` 文件中，你可以找到发射定时器事件的功能。我们推荐你使用宏系列 `TRACE_CPUPROFILER_EVENT_SCOPE_*` ，它提供了一种方法来轻松测量应用程序在某个范围内花费的时间：

```
		{			TRACE_CPUPROFILER_EVENT_SCOPE_STR("Fancy work");			// do fancy work…		}
```

此代码将生成"Fancy work"定时器，定时器将显示在[Timing Insights](../../timing-insights/index.md)时间轴中该示例使用静态字符串。支持动态字符串，但相较于静态字符串，会带来额外的性能和内存开销。

> [!NOTE]
> 许多内置的宏包括 `TRACE_CPUPROFILER_EVENT_SCOPE`，例如 `SCOPE_CYCLE_COUNTER`、`QUICK_SCOPE_CYCLE_COUNTER` 和 `SCOPED_NAMED_EVENT`（如果设置了 `-statnamedevents`）。

### 计数器

`Core/ProfilingDebugging/CountersTrace.h` 文件包含用于声明和追踪具名值的通用接口。你可以使用该接口随时间追踪这些值。该接口支持整数、浮点和内存值，包括常见运算（集合、递增、递减）。

例如：

```
		TRACE_DECLARE_INT_COUNTER(AlienBytes, TEXT("Alien Bytes Written"));		TRACE_DECLARE_INT_COUNTER(AlienHits, TEXT("Alien Hit Count")); 		void SomeFunc(uint32 WriteSize)		{			TRACE_COUNTER_INCREMENT(AlienHits);			TRACE_COUNTER_ADD(AlienBytes, WriteSize);		} 
```

此代码将生成两个计数器（`AlienHits` 和 `AlienBytes`），计数器将显示在[Timing Insight](../../timing-insights/index.md)的 **计数器（Counters）** 选项卡中。

### 内存

**内存追踪** 实现为 **GMalloc** 的包装器，涵盖了常用分配。此外，虚拟分配器在相关平台上运作。但是，如果你实现自己的自定义分配器，你可以使用 `Core/ProfilingDebugging/MemoryTrace.h` 文件中的函数为它们添加工具。

内存追踪会利用LLM[testing-and-optimizing-your-content\unreal-insights\memory-insights]标记系统，并使用LLM_SCOPE事件来实现代码，该事件有助于分配追踪对标签进行追踪。我们推荐直接使用这些宏，因为LLM和内存追踪都可以利用这些宏。但是，在特定情况下，`Core/ProfilingDebugging/TagTrace.h` 文件中包含了仅为内存追踪添加自定义工具的宏。

### 杂项工具

在 `Core/ProfilingDebugging/MiscTrace.h` 文件中，你可以找到在分析时提供上下文帮助的一组工具宏。例如，**帧标记** 和 **书签** 。书签有助于一目了然地识别应用程序中的主要更改。你可以使用 `TRACE_BOOKMARK` 宏添加自己的书签。

例如：

```
	int32 OpenInventory( … )	{		TRACE_BOOKMARK(TEXT("Inventory.Open"));	} 
```

在使用Unreal Insights时，书签会显示在时间轴中，为你提供此更改的直观展示，并显示在日志视图中，以方便搜索。书签旨在用于很少发生的游戏状态更改。如果你需要更高的频率，事件定时器或计数器是更好的选择。

## 创建自定义事件

如果内置事件不足以满足你的需要，你可以实现自己的 **自定义事件** 。自定义事件为你提供了一种方法来定义自己的自定义负载，但你需要实现分析器来处理事件并提取数据。

### 定义事件

Trace会话由事件流组成。**事件（Events）** 在应用程序中以统计数据呈现，包括 **日志名称（logger name）** 、 **事件名称（event name）** 、 **事件标记（event flags）** 以及以下域：

```
		UE_TRACE_EVENT_BEGIN(LoggerName, EventName[, Flags]) 	UE_TRACE_EVENT_FIELD(Type, FieldName) 	... 		UE_TRACE_EVENT_END()
```

`EventName` 和 `FieldName` 参数用于定义事件和事件包括的字段。事件由"日志（logger）"分类，这个概念有助于在分析Trace流时将事件整理进命名空间并且简化订阅。可选的Flags标记参数能够更改事件的追踪方式。

参考下表：

| **事件标记** | **描述** |
| --- | --- |
| NoSync | 默认情况下，事件会和其它线程中追踪的事件同步。带有 `NoSync` 标记的事件会跳过同步；它们规模更小，追踪速度更快，但在分析过程中无法与其它线程协调。 |
| Important | 将事件标记为Important。请参阅下面的[重要事件](#%E9%87%8D%E8%A6%81%E4%BA%8B%E4%BB%B6)小节，详细了解普通事件和重要事件。重要事件还需要NoSync标记，因为它们和普通事件一起带外处理。 |

**字段（Fields）** 经过命名，并且明确区分类别（强类型）。字段类型包括标准整数或浮点基元（uint8、uint32、浮点等），以及数组和字符串。

| **字段类型** | **描述** | **示例** |
| --- | --- | --- |
| `uint8`, `uint16`, `uint32`, `uint64` | 常见整数类型。 | << FieldName(-10) |
| `float`, `double` | 常见浮点类型。 | << FieldName(1.0f) |
| `UE::Trace::Widestring` | 宽字符串。 | << FieldName(Ptr, NumChars) |
| `UE::Trace::Ansistring` | ANSI字符串。 | << FieldName(Ptr, NumChars) |
| `Type[]` | `数组` | << FieldName(Ptr, Num) |

> [!NOTE]
> - 排除null终止符的字符数。

字段直接写入事件流，不支持将嵌套结构/事件作为字段，但是为了引用之前的事件，通常可以嵌入一个独有的ID字段并且在分析时解算。

事件通常会在一个 `.cpp` 文件中全局定义。如果你需要追踪多个平移单元的事件，则可以使用 `UE_TRACE_EVENT_BEGIN_[EXTERN|DEFINE]` 对。

#### 数组

你可以将Trace事件定义为无明确大小的数组，从而添加可变长度字段。

```
		UE_TRACE_EVENT_BEGIN(BoniLogger, BerkEvent)		UE_TRACE_EVENT_FIELD(int32[], DruttField)		UE_TRACE_EVENT_END() 
```

如果字段中未设置数据，数组类字段不会在事件负荷中产生存储成本。数组数据位于追踪流的主事件数据之后，会在分析时重新结合。追踪数组字段只需要一个数组数据指针，以及一个表示数组元素数量的整数。

例如：

```
	UE_TRACE_LOG(BoniLogger, BerkEvent, UpstairsChannel) 	<< BerkEvent.DruttField(IntPtr, IntNum); 
```

#### 附件

Trace最初不支持可变长度字段，因此以不透明二进制文件对象的形式引进了附件，系统会将其附加在事件之后。我们建议使用数组类字段而非附件，因为它们具有结构性，并可在分析时反映出来。

附件支持会使每个记录的事件都产生成本，而数组类自动则没有这一问题。在未来，附件可能会成为选择性使用的工具，从而优化这一开销。

### 字符串

追踪事件在通过 `UE_TRACE_EVENT_FIELD()` 声明事件字段时，可使用Trace::AnsiString或Trace::WideString类型来支持字符串类字段。

```
		UE_TRACE_EVENT_BEGIN(MyLogger, MyEvent) 			UE_TRACE_EVENT_FIELD(Trace::AnsiString, MyFieldA)			UE_TRACE_EVENT_FIELD(Trace::WideString, MyFieldW) 		UE_TRACE_EVENT_END() 
```

字符串类字段的编写方式和基元类字段基本一致，只是增加了几个部分；ASCII类字段会将宽字符串自动删节为7位字符，并可以提供可选字符串长度（如果已知晓字符串长度，则有助于提升性能）。

```
		UE_TRACE_LOG(MyLogger, MyEvent) 			<< MyFieldA(AnAnsiBuffer, [, ExplicitStringLen])			<< MyFieldW(WideName) 
```

#### 普通事件

在 `UE_TRACE_LOG` 站点追踪事件时，系统会将标头和事件的字段值写入当前线程的本地缓冲区，即 **线程本地存储**（**TLS**）。TLS缓冲区有较小的固定大小，并链接到一起，构成列表。Trace的工作线程会遍历缓冲区列表，发送已提交（并因此完全可见）的事件数据。使用TLS的优势在于，可避免追踪线程之间的冲突。 各个线程之间的操作顺序对于事件类型很重要，在分析追踪数据时必须重建，例如其中可以复用内存地址的内存追踪事件。 如果事件需要同步，Trace会在每个事件前添加24位的原子递增序列号。事件默认同步，但是开发者可以在设置事件时使用NoSync标记以关闭这一功能。这样可以避免产生相关的性能开销，但也无法在分析期间与其它线程协调。

#### 重要事件

追踪可以在运行的任何时间点开始或停止，但是一些事件对于分析至关重要而且可能在整个进程中只发射一次。比如描述处理器频率或者为计时器指定人类可读的名称之类的事件。为了能够在每次新连接时发射这些事件，Trace可以将这些事件标为重要事件。

重要事件储存在一个特殊的缓冲区，并且在整个进程中一直保留，这意味着开发者在使用这个功能时应该考虑内存成本。

### 通道

Trace中的 **通道（Channel）** 可帮助你自主限制事件流，还能聚焦用户需要观察的最相关的数据，从而提高CPU和内存使用效率。使用以下语法可以定义通道：

```
	UE_TRACE_CHANNEL(ItvChannel); 
```

更具体的用例可使用 `EXTERN/DEFINE` 对。在默认情况下，通道处于禁用状态，必须进行明确的操作来开启。具体启用方式参考[Trace](../index.md)。

通道能够在日志宏中结合使用，在多个通道中控制事件的追踪。如果 **Itv** 和 **Bbc** 通道同时启用，则UE_TRACE_LOG(..., ItvChannel|BbcChannel)只会发射一个事件。

> [!NOTE]
> 通道使用OR运算符来创建合成屏蔽，与使用不同标记构建位掩码类似。

### 追踪事件

你可以使用 `UE_TRACE_LOG` 宏来在运行时记录事件：

UE_TRACE_LOG(RainbowLogger, ZippyEvent, ItvChannel)

```
	<< ZippyEvent.Field0(Value0) 	<< ZippyEvent.Field1(BundleValue) 	<< ZippyEvent.Field2(Data, Num); 	<< ZippyEvent.Field3(String[, Num]);
```

如果启用了 **ItvChannel** 通道，就会在Trace流中添加 'RainbowLogger.ZippyEvent' 事件。

并不是所有字段都需要写入，但是追踪事件时无法进行增量或运行长度压缩。即使无数据写入，也会显示所有定义的字段。字段之间没有填充，追踪事件基本类似于 `#pragma pack(1)` 中声明的结构。我们建议开发者们慎重考虑，以便充分利用此类功能。

虽然UE_TRACE_LOG表示单个时间点，但有时也适合用于表示 **时间范围** 。`UE_TRACE_LOG_SCOPE` 允许事件作为起始点和结束点发射。请参阅[重要事件](#%E9%87%8D%E8%A6%81%E4%BA%8B%E4%BB%B6)，详细了解用法。范围允许你确定其他哪些事件在范围内发生，但不提供时间戳。如果你需要使用时间与其他事件关联，可以使用 `UE_TRACE_LOG_SCOPE_T` 。

该系统大量使用宏来隐藏许多样板，这样当关闭Trace时，定义和日志站点会编译为空白，而无需开发人员在整个代码中使用 `#if` 和 `#endif` 对。

#### 重要事件

追踪重要事件有一些额外的要求。由于这些事件存储在各个线程之间共享的缓存中，日志记录宏需要提前知道会耗用多少变量内存。例如，考虑以下事件：

```
		UE_TRACE_EVENT_BEGIN(BoniLogger, BarkEvent, Important|NoSync) 			UE_TRACE_EVENT_FIELD(WideString, WoofString) 			UE_TRACE_EVENT_FIELD(int64[], DratField) 		UE_TRACE_EVENT_END() 
```

该事件将受到追踪，如下所示：

```
		void Func(const TCHAR* Woof, const TArray<int64>& Drat)		{			const uint32 WoofLen = FCString::Len(Woof); 			const uint32 WoofSize = WoofLen * sizeof(TCHAR); 			const uint32 DratSize = Drat.Num() * sizeof(int64); 			UE_TRACE_LOG(BoniLogger, BarkEvent, BoniChannel, WoofSize + DratSize) 			 << BarkEvent.WoofString(Woof, WoofLen) 			 << BarkEvent.DratField(Drat.GetData(), Drat.Num());		} 
```

请注意，变量数据的总大小会传递到日志宏的省略号参数。

## 分析自定义事件

你已经定义了新事件、启用了相关通道并添加了至少一个日志站点，现在可以使用和分析这些事件并发布它们。我们将使用 **分析器***_和 **提供器*** _模式完成此操作。 分析器从每个事件提取数据，并将其馈送到对应的提供器，后者将数据提供给UI或其他输出。

分析器派生自 **IAnalyzer** 接口，并实现两种主要方法：

- **OnAnalysisBegin** ，用于订阅事件。
- **OnEvent** ，用于接收这些订阅。

提供器派生自 **IProvider** 接口。不强制使用哪种方法去实现它们，但请确保对提供器中数据的访问是线程安全的，因为分析器线程和UI线程对提供器的访问未同步。

分析器和提供器需要添加到分析器会话才能接收事件。常见模式是在构造时向提供器和分析器馈送指针：

```
	FRainbowProvider* RainbowProvider = new FRainbowProvider(Session); 	Session.AddProvider(TEXT("RainbowProvider"), RainbowProvider); 	Session.AddAnalyzer(new FRainbowAnalyzer(Session, RainbowProvider)); 
```

### 分析器

分析器使用日志和事件名称来订阅事件。订阅接口使用用户定义的序号"路径ID（route ID）"将每个事件类型关联。

```
		void FRainbowAnalyzer::OnAnalysisBegin(const FOnAnalysisContext& Context) 		{			auto& Builder = Context.InterfaceBuilder; 			Builder.RouteEvent(RouteId_Zippy, "RainbowLogger", "ZippyEvent");		} 
```

当分析遇到分析器订阅的事件时，分析器的OnEvent方法便会按照登记好的路径ID调用。事件上下文场景包括各个 **字段** 、 **线程** 和 **计时信息** 数据的提取方法。该API反映出了Trace流的自我描述性质；Trace流的解译不依赖二进制或运行时代码。

```
		bool FRainbowAnalyzer::OnEvent(uint16 RouteId, EStyle Style, const FOnEventContext& Context)		{			switch(RouteId)			{				case RouteId_Zippy:				{					uint32 Field0 = Context.EventData.GetValue<uint32>("Field0"); 					FStringView Field3; 					Context.EventData.GetString("Field3", Field3); 					TArrayReader<int64>& Field4 = EventData.GetArray<int64>("Field4"); 					RainbowProvider->AddZippy(Field0, Field3, Field4);				}				break;		} 
```

## 线程ID

尽管有系统ID，但主线程ID与系统线程ID并不相同。这样一来，就不需要进行特殊处理来防止操作系统复用线程ID。因此，你可能遇到系统ID在不同线程之间复用的情况，但来自Trace的ID应该唯一。

### Unreal Insights插件

通常，Unreal Insights中的组件会使用并可视化提供器中的数据。如果你实现了自定义提供器，你可能需要实现自定义可视化。**SlateInsights** 和 **RenderGraphInsights** 是随引擎发布并用作参考的两个示例插件。

## 拓展延伸

Trace和Unreal Insights旨在为高级用户实现灵活、可扩展的用途。除了使用Unreal Insights应用程序和实现插件之外，你还可以通过不同的方式使用组件。

### 编写自定义分析器

如果你想通过不同的方式输出数据，从而生成报告或提供类似需求，你可以实现独立程序并使用自定义分析器提取你感兴趣的事件，并以你需要的格式输出数据。 `\Engine\Source\Developer\TraceInsights\Private\Insights\StoreService\StoreBrowser.cpp` 文件中的 `FStoreBrowser::UpdateMetadata()` 方法提供了一个示例。 在此方法中，我们创建了一个分析上下文。我们添加了分析器FDiagnosticsSessionAnalyzer，它会查找一个特定事件类型（"Session/Session2"）。系统在读取追踪时，会跳过其他所有事件，一旦找到会话事件，就不会再有进一步的处理。该信息用于在会话浏览器中显示追踪的元数据。

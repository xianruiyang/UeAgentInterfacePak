---
title: "统计数据系统概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-stats-system-overview"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "统计数据系统概述"]
---

# 统计数据系统概述

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 统计数据系统概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-stats-system-overview

**统计数据系统** 可以收集和显示性能数据，从而用来优化游戏。

> [!NOTE]
> 要获取关于统计命令的帮助，请在控制台中输入 `stat`，或参阅 `PrintStatsHelpToOutputDevice();` 方法。

## 类型

统计数据系统支持下列类型：

| 统计数据类型 | 说明 |
| --- | --- |
| **循环计数器** | 一种泛型循环计数器，用于统计数据对象生命周期中的循环次数。 |
| **浮点/Dword计数器** | 一种每帧都会清空的计数器。 |
| **浮点/Dword累加器** | 一种不会每帧清空的计数器，作为可重置的持久统计数据。 |
| **内存** | 一种特殊类型的计数器，针对内存跟踪进行优化。 |

## 分组统计数据

每个统计数据必须归入组中，通常对应显示指定的统计数据组。例如，**stat statsystem** 将显示统计数据相关数据。

要定义统计数据组，请使用下列方法之一：

| 方法 | 说明 |
| --- | --- |
| `DECLARE_STATS_GROUP(GroupDesc, GroupId, GroupCat)` | 声明默认启用的统计数据组。 |
| `DECLARE_STATS_GROUP_VERBOSE(GroupDesc, GroupId, GroupCat)` | 声明默认禁用的统计数据组。 |
| `DECLARE_STATS_GROUP_MAYBE_COMPILED_OUT(GroupDesc, GroupId, GroupCat)` | 声明默认禁用的统计数据组，编译器可将该组剥离。 |

其中：

- GroupDesc

  是该组的文本描述。
- GroupId

  是该组的

  独有

  标识
- GroupCat

  保留供将来使用
- CompileIn

  如设为true，编译器则可能将其剥离出来

> [!NOTE]
> 根据作用域，可在源文件或标头文件中完成分组。

### 示例用法

```
	DECLARE_STATS_GROUP(TEXT("Threading"), STATGROUP_Threading, STATCAT_Advanced);	DECLARE_STATS_GROUP_VERBOSE(TEXT("Linker Load"), STATGROUP_LinkerLoad, STATCAT_Advanced); 
```

## 声明和定义统计数据

现在可声明和定义统计数据，但在此之前请注意，统计数据可用在：

- 仅一个cpp文件
- 函数作用域
- 模块作用域
- 整个项目

### 用于单个文件

如作用域是单个文件，必须根据统计数据类型使用下列一种方法：

| 方法 | 说明 |
| --- | --- |
| `DECLARE_CYCLE_STAT(CounterName, StatId, GroupId)` | 声明循环计数器统计数据。 |
| `DECLARE_SCOPE_CYCLE_COUNTER(CounterName, StatId, GroupId)` | 声明循环计数器统计数据，同时使用它。此外，它仅限于一个函数作用域。 |
| `QUICK_SCOPE_CYCLE_COUNTER(StatId)` | 声明循环计数器统计数据，它将属于名为"Quick"的统计数据组。 |
| `RETURN_QUICK_DECLARE_CYCLE_STAT(StatId, GroupId)` | 返回循环计数器，有时由几个专门的类使用。 |
| `DECLARE_FLOAT_COUNTER_STAT(CounterName, StatId, GroupId)` | 声明浮点计数器，基于双倍类型（8字节）。 |
| `DECLARE_DWORD_COUNTER_STAT(CounterName, StatId, GroupId)` | 声明dword计数器，基于qword类型（8字节）。 |
| `DECLARE_FLOAT_ACCUMULATOR_STAT(CounterName, StatId, GroupId)` | 声明浮点累加器。 |
| `DECLARE_DWORD_ACCUMULATOR_STAT(CounterName, StatId, GroupId)` | 声明dword累加器。 |
| `DECLARE_MEMORY_STAT(CounterName, StatId, GroupId)` | 声明与dword累加器相同的内存计数器，但将使用内存特定单位显示。 |
| `DECLARE_MEMORY_STAT_POOL(CounterName, StatId, GroupId, Pool)` | 声明带有池的内存计数器。 |

### 用于多个文件

如想拥有可供整个项目（或范围较广的文件）访问的统计数据，需使用其外部版本。 这些方法与先前提到的方法相同，但名称末尾带有 `_EXTERN`：

`DECLARE_CYCLE_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_FLOAT_COUNTER_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_DWORD_COUNTER_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_FLOAT_ACCUMULATOR_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_DWORD_ACCUMULATOR_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_MEMORY_STAT_EXTERN(CounterName, StatId, GroupId, API)` `DECLARE_MEMORY_STAT_POOL_EXTERN(CounterName, StatId, GroupId, Pool, API)`

然后在源文件中，需使用下列项定义这些统计数据，这些项定义的以 `_EXTERN` 声明的统计数据：

其中：

- CounterName

  是统计数据的文本描述
- StatId

  是统计数据的

  独有

  标识
- GroupId

  是统计数据所属的组的标识， GroupId

  来自

  DECLARE_STATS_GROUP*`
- Pool

  是平台专属的内存池
- API

  是模块的

  *_API

  ，如该统计数据仅使用在该模块中，其可为空

## 示例

## 带有池的自定义内存统计数据

首先需添加新池到 `enum EMemoryCounterRegion`，它可以是全局的，也可以是平台专属的：

```
	enum EMemoryCounterRegion	{		MCR_Invalid,		// 非内存		MCR_Physical,		// 主系统内存		MCR_GPU,			// GPU内存（显卡）		MCR_GPUSystem,		// GPU直接访问的系统内存		MCR_TexturePool,	// 预设置大小的纹理池		MCR_MAX	}; 
```

下面是允许在任何地方使用池的示例（见 `CORE_API`）。

> [!NOTE]
> 池名称必须以 `MCR_` 开头。

### 标头文件范例

```
	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Physical Memory Pool [Physical]"), MCR_Physical, STATGROUP_Memory, FPlatformMemory::MCR_Physical, CORE_API);	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("GPU Memory Pool [GPU]"), MCR_GPU,STATGROUP_Memory, FPlatformMemory::MCR_GPU, CORE_API);	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Texture Memory Pool [Texture]"), MCR_TexturePool, STATGROUP_Memory, FPlatformMemory::MCR_TexturePool,CORE_API); 
```

### 源文件范例

```
	DEFINE_STAT(MCR_Physical);	DEFINE_STAT(MCR_GPU);	DEFINE_STAT(MCR_TexturePool); 	// 这是一个池，因此需要初始化——通常在F*PlatformMemory::Init()之中。	SET_MEMORY_STAT(MCR_Physical, PhysicalPoolLimit);	SET_MEMORY_STAT(MCR_GPU, GPUPoolLimit);	SET_MEMORY_STAT(MCR_TexturePool, TexturePoolLimit); 	// 拥有池之后，即可为其设置内存统计数据。 	// 以下内容可在任意处访问。	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Index buffer memory"), STAT_IndexBufferMemory, STATGROUP_RHI, FPlatformMemory::MCR_GPU, RHI_API);	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Vertex buffer memory"), STAT_VertexBufferMemory, STATGROUP_RHI, FPlatformMemory::MCR_GPU, RHI_API);	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Structured buffer memory"), STAT_StructuredBufferMemory,STATGROUP_RHI, FPlatformMemory::MCR_GPU, RHI_API);	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Pixel buffer memory"), STAT_PixelBufferMemory, STATGROUP_RHI, FPlatformMemory::MCR_GPU, RHI_API); 	// 以下内容只能在其被定义的模块中访问。	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Pool Memory Size"), STAT_TexturePoolSize, STATGROUP_Streaming, FPlatformMemory::MCR_TexturePool, );	DECLARE_MEMORY_STAT_POOL_EXTERN(TEXT("Pool Memory Used"), STAT_TexturePoolAllocatedSize, STATGROUP_Streaming, FPlatformMemory::MCR_TexturePool, ); 	// 最后，我们需要更新内存统计数据。 	// 以特定的值增加内存统计数据。	INC_MEMORY_STAT_BY(STAT_PixelBufferMemory,NumBytes);	// 以特定的值减少内存统计数据。	DEC_MEMORY_STAT_BY(STAT_PixelBufferMemory,NumBytes);	// 以特定的值设置内存统计数据。	SET_MEMORY_STAT(STAT_PixelBufferMemory,NumBytes); 
```

## 不带池的常规内存统计数据

```
	DECLARE_MEMORY_STAT(TEXT("Total Physical"), STAT_TotalPhysical, STATGROUP_MemoryPlatform);	DECLARE_MEMORY_STAT(TEXT("Total Virtual"), STAT_TotalVirtual, STATGROUP_MemoryPlatform);	DECLARE_MEMORY_STAT(TEXT("Page Size"), STAT_PageSize, STATGROUP_MemoryPlatform);	DECLARE_MEMORY_STAT(TEXT("Total Physical GB"), STAT_TotalPhysicalGB, STATGROUP_MemoryPlatform); 
```

或者，如果愿意，可在标头文件中 `DECLARE_MEMORY_STAT_EXTERN`，然后在源文件中 `DEFINE_STAT`。

> [!NOTE]
> 更新内存统计数据的方式与带有池的版本相同。

## 使用循环计数器的性能数据

首先需添加循环计数器：

```
	DECLARE_CYCLE_STAT(TEXT("Broadcast"), STAT_StatsBroadcast, STATGROUP_StatSystem);	DECLARE_CYCLE_STAT(TEXT("Condense"), STAT_StatsCondense, STATGROUP_StatSystem); 
```

或在标头文件中 `DECLARE_CYCLE_STAT_EXTERN`，然后在源文件中 `DEFINE_STAT`。

现在可抓取性能数据：

```
	Stats::Broadcast()	{		SCOPE_CYCLE_COUNTER(STAT_StatsBroadcast);		// ...		// 一串代码		// ...	} 
```

有时候不想每次调用函数时都抓取统计数据，可以使用条件循环计数器——这不是很常见，但可能很有用：

```
	Stats::Broadcast(bool bSomeCondition)	{ 		CONDITIONAL_SCOPE_CYCLE_COUNTER(STAT_StatsBroadcast,bSomeCondition);		// ...		// 一串代码		// ...	} 
```

如要从一个函数抓取性能数据，可使用下列构造：

```
	Stats::Broadcast(bool bSomeCondition)	{		DECLARE_SCOPE_CYCLE_COUNTER(TEXT("Broadcast"), STAT_StatsBroadcast, STATGROUP_StatSystem);		// ...		// 一串代码		// ...	} 
```

也可进行下列操作：

```
	Stats::Broadcast(bool bSomeCondition)	{		QUICK_SCOPE_CYCLE_COUNTER(TEXT("Stats::Broadcast"));		// ...		// 一串代码		// ...	} 
```

> [!NOTE]
> 这主要用于临时统计数据。

以上提到的所有循环计数器均用于生成层级，因此可获取关于性能数据的详细信息。但也可选择设置平循环计数器：

```
	Stats::Broadcast(bool bSomeCondition)	{		const uint32 BroadcastBeginTime = FPlatformTime::Cycles();		// ...		// 一串代码		// ...		const uint32 BroadcastEndTime = FPlatformTime::Cycles();		SET_CYCLE_COUNTER(STAT_StatsBroadcast, BroadcastEndTime-BroadcastBeginTime);	} 
```

## 使用GetStatId的性能数据

有几种在虚幻引擎中实现的任务使用不同的方法来获取性能数据。它们实现方法 `GetStatId()`，如没有 `GetStatId()`，代码将无法编译。

请参见以下示例：

```
	class FParallelAnimationCompletionTask	{		// ...		// 一串代码		// ...		FORCEINLINE TStatId GetStatId() const		{			RETURN_QUICK_DECLARE_CYCLE_STAT(FParallelAnimationCompletionTask, STATGROUP_TaskGraphTasks);		}		// ...		// 一串代码		// ...	}; 
```

## 记录性能数据

如只想记录性能数据，我们提供有下列功能：

### 方法

下列方法会捕获时间（以秒为单位传递），并将增量时间添加到传入的变量：

`SCOPE_SECONDS_COUNTER(double& Seconds)`

#### 代码范例

```
	Stats::Broadcast()	{		double ThisTime = 0;		{	       SCOPE_SECONDS_COUNTER(ThisTime);	  		// ...			// 一串代码			// ...		}		UE_LOG(LogTemp, Log, TEXT("Stats::Broadcast %.2f"), ThisTime);	} 
```

### 工具类和方法

| 类 | 说明 |
| --- | --- |
| `FScopeLogTime` | 记录时间（以秒为单位传递）的工具类，将累加统计数据添加到传入的变量，并在析构函数中将性能数据打印到日志。 |
| 方法 | 说明 |
| `SCOPE_LOG_TIME(Name, CumulativePtr)` | 使用提供的名称打印性能数据并收集累加统计数据。 |
| `SCOPE_LOG_TIME_IN_SECONDS(Name, CumulativePtr)` | 与SCOPE_LOG_TIME功能相同，但以秒为单位打印。 |
| `SCOPE_LOG_TIME_FUNC()` | 它使用函数名称打印性能数据，而且不能嵌套。 |
| `SCOPE_LOG_TIME_FUNC_WITH_GLOBAL(CumulativePtr)` | 与SCOPE_LOG_TIME_FUNC功能相同，但它收集累加统计数据。 |

#### 代码范例

```
	double GMyBroadcastTime = 0.0;	Stats::Broadcast()	{		SCOPE_LOG_TIME("Stats::Broadcast", &GMyBroadcastTime);		SCOPE_LOG_TIME_IN_SECONDS("Stats::Broadcast (sec)", &GMyBroadcastTime);		// ...		// 一串代码		// ...	} 	Stats::Condense()	{		SCOPE_LOG_TIME_FUNC(); // 命名应为"Stats::Condense()"，在不同编辑器中可能有所不同		SCOPE_LOG_TIME_FUNC_WITH_GLOBAL(&GMyBroadcastTime);		// ...		// 一串代码		// ...	} 
```

## 使用浮点或DWORD计数器的泛型数据

需要做的首件事通常是添加计数器，如下所示：

```
	DECLARE_FLOAT_COUNTER_STAT_EXTERN(STAT_FloatCounter,StatId,STATGROUP_TestGroup, CORE_API);	DECLARE_DWORD_COUNTER_STAT_EXTERN(STAT_DwordCounter,StatId,STATGROUP_TestGroup, CORE_API);	DECLARE_FLOAT_ACCUMULATOR_STAT_EXTERN(STAT_FloatAccumulator,StatId,STATGROUP_TestGroup, CORE_API);	DECLARE_DWORD_ACCUMULATOR_STAT_EXTERN(STAT_DwordAccumulator,StatId,STATGROUP_TestGroup, CORE_API); 
```

之后，更新和管理计数器可使用下列方法：

### 用于更新计数器的方法

| 方法 | 说明 |
| --- | --- |
| `INC_DWORD_STAT(StatId)` | 使dword统计数据加1。 |
| `DEC_DWORD_STAT(StatId)` | 使dword统计数据减1。 |
| `INC_DWORD_STAT_BY(StatId, Amount)` | 使dword统计数据增加指定值。 |
| `DEC_DWORD_STAT_BY(StatId, Amount)` | 使dword统计数据减少指定值。 |
| `SET_DWORD_STAT(StatId, Value)` | 将dword统计数据设为指定值。 |
| `INC_FLOAT_STAT_BY(StatId, Amount)` | 使浮点统计数据增加指定值。 |
| `DEC_FLOAT_STAT_BY(StatId, Amount)` | 使浮点统计数据减少指定值。 |
| `SET_FLOAT_STAT(StatId, Value)` | 将浮点统计数据设为指定值。 |

### 用于管理计数器的助手方法

| 方法 | 说明 |
| --- | --- |
| `GET_STATID(StatId)` | 返回统计数据的 `TStatId` 的实例。 此为高级方法。 |
| `GET_STATDESCRIPTION(StatId)` | 返回统计数据的描述。 |

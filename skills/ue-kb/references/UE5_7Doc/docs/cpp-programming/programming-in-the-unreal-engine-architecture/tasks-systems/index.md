---
title: "任务系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/tasks-systems-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "任务系统"]
---

# 任务系统

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 任务系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/tasks-systems-in-unreal-engine

**任务系统（Tasks System）** 是一种作业管理器，提供了异步执行Gameplay代码的能力。它支持构建和运行依赖任务的定向无环图。它是对 **虚幻引擎** 中使用的作业管理器 **TaskGraph** 的改进。任务系统和TaskGraph使用相同的后端（调度程序和工作线程）。

主要功能包括：

- [启动](#%E5%90%AF%E5%8A%A8)任务，方法是提供需要异步执行的可调用对象。
- [等待](#waitingfortaskcompletion)任务完成和/或检索任务执行结果。
- 指定任务[先决条件](#prerequisites)，即开始执行该任务之前必须完成的其他任务。
- 从任务内部启动[嵌套任务](#nestedtasks)。父任务只有其所有嵌套任务都完成后才算完成。
- 构建任务链，也称为[管线](#pipes)。
- 使用[任务事件](#taskevents)执行任务之间的同步和信令。

> [!NOTE]
> 为简便起见，所有代码示例都假定使用名称空间 `UE::Tasks`。

## 启动

要 **启动** 任务，你需要提供任务的调试名称和可调用的对象"任务主体"。例如：

```
		Launch(		        UE_SOURCE_LOCATION,		        []{ UE_LOG(LogTemp, Log, TEXT("Hello Tasks!")); }		      ); 
```

上述代码启动将异步执行给定函数的任务。第一个参数是任务的调试名称（最好唯一）。其目的是帮助调试任务并辅助查找启动该任务的代码。

`UE_SOURCE_LOCATION` 是生成字符串的宏，字符串格式为源文件的文件名加上使用它的行。此示例显示了一个"即发即弃"任务，这意味着你在任务启动之后不用管它发生了什么，因为它最终会执行。

你常常需要等待任务完成或检索其执行结果。这可以使用Launch调用返回的Task对象来执行：

```
		FTask Task = Launch(UE_SOURCE_LOCATION, []{});
```

任务执行可以返回结果。`FTask` 是 `TTask<void>` 的别名，后者是泛型 `TTask<ResultType>` 的特殊版本。`ResultType` 应当匹配任务主体返回的结果的类型：

```
		TTask<bool> Task = Launch(UE_SOURCE_LOCATION, []{ return true; }); 
```

任务会异步执行，并有可能与启动线程并发执行，所以其执行顺序是未定义的。不过我们仍可以指定任务优先级来影响任务执行顺序。任务优先级包括"high"、"normal"（默认值）、"background high"、"background normal"和"background low"。 优先级更高的任务先执行，优先级更低的任务后执行。

```
		Launch(UE_SOURCE_LOCATION, []{}, ETaskPriority::High); 
```

我们通常使用lambda函数作为任务主体，不过你也可以使用任意可调用对象。

```
		void Func() {}		Launch(UE_SOURCE_LOCATION, &Func); 		struct FFunctor		{			void operator()() {}		};		Launch(UE_SOURCE_LOCATION, FFunctor{}); 
```

### 技术细节

`FTask` 是实际任务的句柄，类似于一种智能指针。它将使用引用计数来管理其生命周期。启动任务即开始其生命周期，并分配所需的资源。要释放持有的引用，你可以使用以下代码"重置"任务句柄：

```
		FTask Task = Launch(UE_SOURCE_LOCATION, []{}); 		Task = {}; // 释放引用 
```

释放任务句柄不会立即导致任务销毁。系统持有其自己的引用，用于执行任务。此引用将在任务完成后释放。

请参阅[启动](#%E5%90%AF%E5%8A%A8)，了解更多信息。

## 等待任务完成

你可能常常需要知道任务是否已完成，等待其完成，或检索其执行结果。

| 任务命令 | 实现方法 |
| --- | --- |
| 检查任务是否已完成 | 示例： `bool bCompleted = Task.IsCompleted();` |
|  | bool bCompleted = Task.IsCompleted(); |
|  |  |
| 等待任务完成 | 示例： `Task.Wait();` |
| 等待任务完成且有超时 | 示例： `bool bTaskCompleted = Task.Wait(FTimespan::FromMillisecond(100));` |
|  | bool bTaskCompleted = Task.Wait(FTimespan::FromMillisecond(100)); |
|  |  |
| 等待所有任务完成 | 示例： `TArray<FTask> Tasks = …; Wait(Tasks);` |
|  | TArray<FTask> Tasks = …; |
|  | Wait(Tasks); |
|  |  |
| 检索任务执行结果。调用将被阻止，直至任务完成且其结果准备好。 | 示例： `TTask<int> Task = Launch (UE_SOURCE_LOCATION, []{ return 42; }); int Result = Task.GetResult();` |
|  | TTask<int> Task = Launch |
|  | (UE_SOURCE_LOCATION, []{ return 42; }); |
|  | int Result = Task.GetResult(); |
|  |  |

> [!NOTE]
> 应尽可能避免等待，因为这会限制可扩展性。我们推荐你改为定义任务之间的依赖性并设计基于任务的异步API，以构建任务图表。请参阅[Wait](../tasks-system-references/index.md#wait) 和 [`GetResult()`](../tasks-system-references/index.md#getresult)，了解更多信息。

## 忙等待和超额订阅

忙等待在UE5.5中已被废弃。

在之前的版本中，忙等待是一种在等待某些时间完成的同时执行其他任务的方法。不幸的是，从一开始该功能就备受争议，因为其常常会给开发人员带来诸多麻烦。

- 即使没有可用的任务，它也会空转，从而浪费宝贵的CPU资源和电池寿命。
- 它会导致频繁的锁死，因为它是选择一些不相关的任务来运行，而这些任务本身可能与当前等待的任务存在依赖关系，从而在同一个调用栈上形成了循环依赖，这种依赖关系无法得到解决。
- 需要特别小心地排除那些长时间运行的任务以免被忙待任务抢占，否则就会导致卡顿、卡壳甚至长时间无响应的情况发生，因为只有在底层任务完成之后，才有可能恢复等待任务的状态（即便等待的任务本身所等待的操作已经完成）。
- 它容易出现栈溢出的情况，因为忙等待任务可能会陷入自身也进行忙等待的循环之中。

在5.5中，忙等待已被 **超额订阅（oversubscription）** 取代。这种机制会在等待时唤醒其他线程。这解决了无规律的锁死和延迟问题，代价是额外的线程会导致内存占用略微上升。

为了尽可能减少抢占现象，一旦超额分配时段结束且这些额外线程所运行的任务完成，就会立即将这些线程挂起。

![An image showing the relationship between oversubscription events and standby threads in Unreal Insights.](../../../../assets/images/4a/4a29325d4d3d2b152ad08034c953de7793bbd11264d9faeb89bbc50eddf32abb.png)

大多数等待函数都已被纳入了超额订阅的范畴，因此程序员无需采取任何特殊措施就能从这一新机制中受益。

额外的线程名为 **备用线程（standby threads）**，它们会在Unreal Insights中与等待线程的超额订阅范围一同显示出来。

## 先决条件

任务之间可以产生依赖性。如果任务A只能在任务B完成后执行，则任务B称为任务A的 **先决条件**，任务A称为任务B的 **后继** 。这样就可以构建任务的定向无环图。

使用任务依赖性的主要优势是不会阻止工作线程。此外，利用依赖性，你可以强制实施任务执行顺序，而这在正常情况下是不能保证的。下面的代码构建了简单的先决条件到后继依赖性：

```
		FTask Prerequisite = Launch(UE_SOURCE_LOCATION, []{});		FTask Subsequent = Launch(UE_SOURCE_LOCATION, []{}, Prerequisite); 
```

在下面的代码示例中，[`Prerequisites()`](../tasks-system-references/index.md)是辅助函数：

![任务图流程示例](../../../../assets/images/28/2876c28d76f6ffc7e71b176e9695cd53b99e2735a3c50f48b2d19c31c4785ebe.png)

```
		FTask A = Launch(UE_SOURCE_LOCATION, []{});		FTask B = Launch(UE_SOURCE_LOCATION, []{}, A);		FTask C = Launch(UE_SOURCE_LOCATION, []{}, A);		FTask D = Launch(UE_SOURCE_LOCATION, []{}, Prerequisites(B, C)); 
```

请参阅[启动](#%E5%90%AF%E5%8A%A8)，了解更多信息。

## 嵌套任务

**嵌套任务** 类似于先决条件，但先决条件是执行依赖性，而嵌套任务则是完成依赖性。假设任务A在执行期间启动了任务B，任务A仅当其自己的执行完成且任务B完成之后才算完成。当系统公开一个基于任务的异步接口时，这是一种常见的模式，但任务B是实现的一部分，因此泄露此任务是不利的。

最简单的实现如下所示：

```
		FTask TaskA = Launch(UE_SOURCE_LOCATION,		[]		{		FTask TaskB = Launch(UE_SOURCE_LOCATION, [] {});		TaskB.Wait();		}		); 
```

这是完成任务的基本实现，但效率低下，因为执行任务A的工作线程被阻止，需要等待任务B完成，因此它不会用于执行其他任务。

解决方案是使用嵌套任务。在我们的示例中，任务A是父任务，任务B是嵌套任务，因为后者的执行应嵌套在任务A的执行中：

```
		FTask TaskA = Launch(UE_SOURCE_LOCATION,		[]		   {		        FTask TaskB = Launch(UE_SOURCE_LOCATION, [] {});		        AddNested(TaskB);		   }		);		TaskA.Wait(); // 仅当 `TaskA` 和 `TaskB` 都完成时才返回 
```

AddNested会将给定任务作为嵌套任务添加到当前线程正在执行的任务。它将表明是否未从任务内部调用。

请参阅[`AddNested()`](../tasks-system-references/index.md#addnested)，了解更多信息。

## 管线

**管线** 是一个接一个（非并发）执行的任务链。设想一下，从多个线程访问共享资源。同步访问的经典方法是，通过锁定互斥锁来"锁定"资源。这种方法常常会因为线程被阻止而带来重大的性能损失，尤其是在争用资源的情况下。

对于复杂的资源，有利的做法是提供异步接口，允许发起异步操作来处理资源，并能够检查操作是否完成（或订阅完成通知）。

实现异步接口常常并不简单。管线旨在简化这项工作。目的是针对每个共享资源使用一个管线。对共享资源的所有访问都在管线启动的任务内部执行。例如：

```
		class FThreadSafeResource		{		public:			TTask<bool> Access()			{				return Pipe.Launch(TEXT("Access()"), [this] { return ThreadUnsafeResource.Access(); });			} 			FTask Mutate()			{				return Pipe.Launch(TEXT("Mutate()"), [this] { ThreadUnsafeResource.Mutate(); });			}		private:			FPipe Pipe{ TEXT("FThreadSafeResource pipe")};			FThreadUnsafeResource ThreadUnsafeResource;		}; 		FThreadSafeResource ThreadSafeResource;		// 从多个线程并发访问相同的实例		bool bRes = ThreadSafeResource.Access().GetResult();		FTask Task = ThreadSafeResource.Mutate(); 
```

`FThreadSafeResource` 提供了基于任务的公共线程安全型异步接口。它封装了线程不安全的资源。实现很简单，由样板代码组成。对线程不安全资源的访问在管线化任务内部发生。

因为这些管线化任务是按顺序执行的，所以不需要进行额外的同步。管线是轻量级对象，因此它们不存储其任务的集合。即使使用成千上万的管线，性能也可能不会显著下降。

要将任务管线化，它需要由管线启动：

```
		FPipe Pipe{ UE_SOURCE_LOCATION };		FTask TaskA = Pipe.Launch(UE_SOURCE_LOCATION, []{});		FTask TaskB = Pipe.Launch(UE_SOURCE_LOCATION, []{}); 
```

TaskA和TaskB不会并发执行，所以不需要彼此同步来访问共享资源。虽然大部分时间执行顺序可预测，但并不能保证任务的启动顺序。

管线化任务可提供其他任务具有的功能，例如，可以产生依赖性以及遵循行为顺序。 首先会解决依赖性，然后将任务管线化。这意味着，带有待处理依赖性的任务不会阻止管线执行，并且依赖性可以改变管线化任务的执行顺序。

你可以将管线视为 **绿色线程**。这些绿色线程由工作线程执行，并可以"跳过线程"。例如，在之前的示例中，TaskA和TaskB可以由不同的线程执行。

- Pipe API是线程安全的。
- Pipe对象不可复制，且不可移动。
- 一个任务无法在多个管线中启动。

请参阅[FPipe](../tasks-system-references/index.md)，了解更多信息。

## 任务事件

任务事件是一种特殊的任务类型，没有任务主体，不能做执行工作。重大区别在于，任务事件最初不会启动（发信令），而需要显式触发。任务事件很适合用作同步和信令图元。它们类似于一次性FEvent。它们可以用作其他任务的先决条件或后继。

下表提供了一些示例来解释任务事件的作用。

| 任务事件示例 | 实现方法 |
| --- | --- |
| 启动任务，但暂停其执行，直至显式释放。 | 示例： `FTaskEvent Event{ UE_SOURCE_LOCATION }; FTask Task = Launch(UE_SOURCE_LOCATION, []{}, Event); Event.Trigger();` 该事件用作了任务的先决条件。最初，事件处于无信号状态，因此它尚未完成，这意味着任务有待处理依赖性，只有解决该依赖性之后才会调度并执行该任务。 任务事件通过触发来切换为有信号状态。 |
|  | FTaskEvent Event{ UE_SOURCE_LOCATION }; |
|  | FTask Task = Launch(UE_SOURCE_LOCATION, []{}, Event); |
|  | Event.Trigger(); |
| 将任务事件用作连接器任务。 | 示例： `FTask TaskA = Launch(UE_SOURCE_LOCATION, []{}); FTask TaskB = Launch(UE_SOURCE_LOCATION, []{}); FTaskEvent Joiner{ UE_SOURCE_LOCATION }; Joiner.AddPrerequisites(Prerequisites(TaskA, TaskB)); Joiner.Trigger(); ... Joiner.Wait();` Joiner依赖于TaskA和TaskB。等待它意味着等待其所有依赖性而不是逐个等待它们。 `Prerequisites()` 是辅助函数。 |
|  | FTask TaskA = Launch(UE_SOURCE_LOCATION, []{}); |
|  | FTask TaskB = Launch(UE_SOURCE_LOCATION, []{}); |
|  | FTaskEvent Joiner{ UE_SOURCE_LOCATION }; |
|  | Joiner.AddPrerequisites(Prerequisites(TaskA, TaskB)); |
|  | Joiner.Trigger(); |
|  | ... |
|  | Joiner.Wait(); |
|  |  |
| 中途停止任务执行并等待某个事件发生。 | 示例： `FTaskEvent Event{ UE_SOURCE_LOCATION }; FTask Task = Launch(UE_SOURCE_LOCATION, [&Event] { ... Event.Wait(); ... }); ... Event.Trigger();` 一般来说，出于性能和可扩展性原因，在任务中途等待并不是最佳做法。如果你遇到这种情况，考虑尽可能使用先决条件重新设计。 |
|  | FTaskEvent Event{ UE_SOURCE_LOCATION }; |
|  | FTask Task = Launch(UE_SOURCE_LOCATION, |
|  | [&Event] |
|  | { |
|  | ... |
|  | Event.Wait(); |
|  | ... |
|  | }); |
|  | ... |
|  | Event.Trigger(); |
|  |  |
| 执行任务，但不自动将其标记为完成。相反，它会在方便的时候显式将其"完成" | 示例： `FTaskEvent Event{ UE_SOURCE_LOCATION }; FTask Task = Launch(UE_SOURCE_LOCATION, [&Event] { AddNested(Event); }); ... Event.Trigger();` |
|  | FTaskEvent Event{ UE_SOURCE_LOCATION }; |
|  | FTask Task = Launch(UE_SOURCE_LOCATION, |
|  | [&Event] |
|  | { |
|  | AddNested(Event); |
|  | }); |
|  | ... |
|  | Event.Trigger(); |
|  |  |

另请参阅：[FTaskEvent](../tasks-system-references/index.md#ftaskevent)

## 调试和分析

每个任务、任务事件或管线都有用户提供的调试名称。这样就可以在调试器中运行时期间识别它们。Visual Studio原生查看器可用于检查其内部状态。

**Unreal Insights** 添加了任务追踪通道，支持可视化任务及其生命周期事件。例如在任务启动、调度、执行和完成时。

请参阅[Unreal Insights文档](../../../testing-and-optimizing-content/unreal-insights/index.md)，了解详情。

> [!NOTE]
> 调试和分析是比较活跃的开发领域，未来将进一步改进。

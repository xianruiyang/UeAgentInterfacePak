---
title: "任务系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/tasks-system-references-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "任务系统"]
---

# 任务系统

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 任务系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/tasks-system-references-in-unreal-engine

任务系统（Tasks System）位于 `UE::Tasks` 命名空间中。要使用任务系统，你需要添加 `Tasks/Task.h` 头文件。你可以参考 `Tests/Tasks/TasksTest.cpp` 类，了解用法。 下表介绍了任务系统的一些关键函数。

| 引用 | 说明 |
| --- | --- |
| `TTask<ResultType>()` | 某个任务的句柄。它使用引用计数器来管理任务的生命周期。 任务在启动时创建。 释放最后一个用户持有的引用不一定会释放该任务，因为系统仍可能持有用于执行该任务的内部引用。 FTask是不返回结果的任务（TTask）的别名； |
| `TTask<ResultType>::IsValid()` | 函数： `bool TTask<ResultType>::IsValid() const;` 在任务句柄引用一个任务时返回true。默认构造的任务句柄为"空"，因此"无效"。任务在启动时构造。例如： `FTask Task; check(!Task.IsValid()); Task = Launch(UE_SOURCE_LOCATION, [] {}); check(Task.IsValid()); Task = {}; // 重置任务对象 check(!Task.IsValid());` |
|  | bool TTask<ResultType>::IsValid() const; |
|  |  |
|  | FTask Task; |
|  |  |
|  | check(!Task.IsValid()); |
|  |  |
|  | Task = Launch(UE_SOURCE_LOCATION, [] {}); |
|  |  |
|  | check(Task.IsValid()); |
|  |  |
|  | Task = {}; // 重置任务对象 |
|  |  |
|  | check(!Task.IsValid()); |
| `Task<ResultType>::Launch` | 启动任务进行异步执行。在下面的代码示例中，Launch用于一个任务，并返回其句柄： `template<typename TaskBodyType> TTask<TInvokeResult_T<TaskBodyType>> Launch( const TCHAR* DebugName, TaskBodyType&& TaskBody, LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Normal );` 先决条件是，必须先完成该任务所依赖的其他任务，然后再执行该任务。所有先决条件都完成后，该任务会自动安排执行。 `template<typename TaskBodyType, typename PrerequisitesCollectionType> TTask<TInvokeResult_T<TaskBodyType>> TTask<ResultType>::Launch( const TCHAR* DebugName, TaskBodyType&& TaskBody, PrerequisitesCollectionType&& Prerequisites, LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Normal );` **参数**： DebugName - （建议作为）任务的唯一ID，用于在调试器和分析器中识别任务。你可以使用UE_SOURCE_LOCATION宏，它将生成使用它的源位置的字符串[文件名]:[行号]。 TaskBody - 将异步执行的可调用对象，例如，lambda、函数指针或带有operator()的类； Prerequisites - TTask的可迭代集合。其结果类型不需要匹配任务的结果类型。 Priority - 影响执行任务的顺序的任务优先级。 **示例**： `FTask Prerequisite1 = Launch(UE_SOURCE_LOCATION, []{}); FTask Prerequisite2 = Launch(UE_SOURCE_LOCATION, []{}, ETaskPriority::High); FTask DependentTask = Launch(UE_SOURCE_LOCATION, []{}, Prerequisites(Prerequisite1, Prerequisite2)); TTask<bool> BoolTask = Launch(UE_SOURCE_LOCATION, []{ return true; });` `template<typename... TaskTypes> TPrerequisites<TaskTypes...> Prerequisites(TaskTypes&... Tasks);` 是辅助函数，用于将可变数量的先决条件传递给 `Launch()` 和 `FTaskEvent::AddPrerequisites()`。如需更多示例，你可以观察以下任务：`IsCompleted()`、`Wait()`、`GetResult()`。 |
|  | template<typename TaskBodyType> |
|  |  |
|  | TTask<TInvokeResult_T<TaskBodyType>> Launch( |
|  | const TCHAR* DebugName, |
|  | TaskBodyType&& TaskBody, |
|  | LowLevelTasks::ETaskPriority Priority = |
|  | LowLevelTasks::ETaskPriority::Normal |
|  | ); |
|  |  |
|  | template<typename TaskBodyType, typename PrerequisitesCollectionType> |
|  | TTask<TInvokeResult_T<TaskBodyType>> TTask<ResultType>::Launch( |
|  | const TCHAR* DebugName, |
|  | TaskBodyType&& TaskBody, |
|  | PrerequisitesCollectionType&& Prerequisites, |
|  | LowLevelTasks::ETaskPriority Priority = |
|  | LowLevelTasks::ETaskPriority::Normal |
|  | ); |
|  |  |
|  | FTask Prerequisite1 = Launch(UE_SOURCE_LOCATION, []{}); |
|  |  |
|  | FTask Prerequisite2 = Launch(UE_SOURCE_LOCATION, []{}, ETaskPriority::High); |
|  |  |
|  | FTask DependentTask = Launch(UE_SOURCE_LOCATION, []{}, Prerequisites(Prerequisite1, Prerequisite2)); |
|  |  |
|  | TTask<bool> BoolTask = Launch(UE_SOURCE_LOCATION, []{ return true; }); |
| `TTask<ResultType>::IsCompleted` | 如果任务已完成或无效，则返回true。 `bool TTask<ResultType>::IsCompleted() const;` **如果** 某个任务完成执行并且其所有嵌套任务都完成，则该任务完成。 **示例：** `FTask Task; check(Task.IsCompleted()); Task = Launch(UE_SOURCE_LOCATION, []{}); Task.Wait(); check(Task.IsCompleted());` 如需更多示例，你可以观察以下任务：`Launch()` 、 `Wait()` 和 `GetResult()` 。 |
|  | bool TTask<ResultType>::IsCompleted() const; |
|  |  |
|  | FTask Task; |
|  |  |
|  | check(Task.IsCompleted()); |
|  |  |
|  | Task = Launch(UE_SOURCE_LOCATION, []{}); |
|  |  |
|  | Task.Wait(); |
|  |  |
|  | check(Task.IsCompleted()); |
|  |  |
| `TTask<ResultType>::Wait` | 阻塞当前线程，直至任务完成或等待发生超时。超时后返回false。等待时间可能超过指定的超时值。如果 `Wait()` 返回true，则任务完成。如果任务无效，则立即返回true： `bool TTask<ResultType>::Wait(FTimespan Timeout); template<typename TaskCollectionType> bool Wait(const TaskCollectionType& Tasks, FTimespan InTimeout);` **示例**： `FTask Task; Task.Wait(); // 立即返回 Task = Launch(UE_SOURCE_LOCATION, []{}); Task.Wait(FTimespan::FromMillisecond(3)); // 阻塞，直至任务完成或等待发生超时 FTask AnotherTask = Launch(UE_SOURCE_LOCATION, []{}); TArray<FTask> Tasks{ Task, AnotherTask }; Wait(Tasks); // 阻塞，直至所有任务完成` 如果任务执行尚未启动（它被先决条件阻塞，或者尚未由工作线程拾取），等待时将"收回"该任务并在本地（内联）执行。由于任务执行尚未启动，当工作线程执行该任务时，需要阻塞等待线程。由等待线程执行任务并不是缓慢的过程，而可以更快，并且不占用工作线程。 任务收回将遵循任务依赖性，即所谓的"深度任务收回"。如果任务执行被先决条件阻塞，任务收回将尝试以递归方式收回并执行其先决条件，从而取消阻塞该任务。 如果任务收回因任何原因而失败（任务执行已经启动），将回退为阻塞等待。 **示例**： `FTask Task1 = Launch(UE_SOURCE_LOCATION, []{}); FTask Task2 = Launch(UE_SOURCE_LOCATION, []{}); FTask Task3 = Launch(UE_SOURCE_LOCATION, []{}, Task2); Task3.Wait();` 上面的示例启动了三个任务，其中 `Task2` 是 `Task3` 的先决条件。等待 `Task3` 完成可能会收回 `Task3` 和/或其先决条件 `Task2` 并内联执行它们，但这不适用于 `Task1` 。 |
|  | bool TTask<ResultType>::Wait(FTimespan Timeout); |
|  | template<typename TaskCollectionType> |
|  |  |
|  | bool Wait(const TaskCollectionType& Tasks, FTimespan InTimeout); |
|  |  |
|  | FTask Task; |
|  | Task.Wait(); // 立即返回 |
|  | Task = Launch(UE_SOURCE_LOCATION, []{}); |
|  | Task.Wait(FTimespan::FromMillisecond(3)); // 阻塞，直至任务完成或等待发生超时 |
|  |  |
|  | FTask AnotherTask = Launch(UE_SOURCE_LOCATION, []{}); |
|  | TArray<FTask> Tasks{ Task, AnotherTask }; |
|  | Wait(Tasks); // 阻塞，直至所有任务完成 |
|  |  |
|  | FTask Task1 = Launch(UE_SOURCE_LOCATION, []{}); |
|  | FTask Task2 = Launch(UE_SOURCE_LOCATION, []{}); |
|  | FTask Task3 = Launch(UE_SOURCE_LOCATION, []{}, Task2); |
|  | Task3.Wait(); |
|  |  |
| `TTask<ResultType>::BusyWait` (**已废弃**) | **在UE5.5中，忙等待已被废弃。** 详情及替代方案建议，请参阅[任务系统](../tasks-systems/index.md)一文中的BusyWait一节。 忙等待某个任务是指在等待该任务完成的同时执行其他无关任务。这可以提高系统吞吐量，但应谨慎使用。忙等待可能花费比阻塞等待更长的时间，并可能影响延迟敏感的任务链。 在下面的函数中，该任务将执行其他已准备好执行的任务，直至所等待的任务完成。接下来，该任务在BusyWait返回后完成。 `void TTask<ResultType>::BusyWait();` 在下面的代码示例中，我们执行其他已准备好执行的任务，直至所等待的任务完成或等待发生超时。接下来，我们在超时后返回false。等待时间可能超过指定的超时值。如果BusyWait返回true，则任务完成。 `bool TTask<ResultType>::BusyWait(FTimespan Timeout); template<typename TaskCollectionType> bool BusyWait(const TaskCollectionType& Tasks, FTimespan InTimeout = FTimespan::MaxValue())` 在执行无关任务之前，忙等待首先会尝试收回所等待的任务。 `FTask Task; Task.BusyWait(); // 立即返回 Task = Launch(UE_SOURCE_LOCATION, []{}); Task.BusyWait(); // 阻塞，直至该任务完成，可以在阻塞时执行其他任务 FTask AnotherTask = Launch(UE_SOURCE_LOCATION, []{}); TArray<FTask> Tasks{ Task, AnotherTask }; BusyWait(Tasks, FTimespan::FromMilliseconds(1)); // 阻塞，直至所有任务完成或等待发生超时，可以在阻塞时执行其他任务` |
|  | void TTask<ResultType>::BusyWait(); |
|  |  |
|  | bool TTask<ResultType>::BusyWait(FTimespan Timeout); |
|  |  |
|  | template<typename TaskCollectionType> |
|  | bool BusyWait(const TaskCollectionType& Tasks, |
|  | FTimespan InTimeout = FTimespan::MaxValue()) |
|  |  |
|  |  |
|  | FTask Task; |
|  | Task.BusyWait(); // 立即返回 |
|  |  |
|  | Task = Launch(UE_SOURCE_LOCATION, []{}); |
|  | Task.BusyWait(); // 阻塞，直至该任务完成，可以在阻塞时执行其他任务 |
|  |  |
|  | FTask AnotherTask = Launch(UE_SOURCE_LOCATION, []{}); |
|  | TArray<FTask> Tasks{ Task, AnotherTask }; |
|  | BusyWait(Tasks, FTimespan::FromMilliseconds(1)); |
|  | // 阻塞，直至所有任务完成或等待发生超时，可以在阻塞时执行其他任务 |
|  |  |
| `TTask<ResultType>::GetResult` | 返回该任务因其执行所返回的对象的引用（任务主体执行返回的值）。 `ResultType& TTask<ResultType>::GetResult();` 这仅对于带有非void ResultType的任务存在。 如果任务完成，调用会立即返回。否则，它会阻塞，直至任务完成。 销毁任务对象时，即释放对任务对象的最后一个引用时，也会销毁结果对象。 如果任务无效，调用会进行断言。 **示例**： `TTask<bool> BoolTask = Launch(UE_SOURCE_LOCATION, []{ return true; }); bool bResult = BoolTask.GetResult(); TTask<int32> IntTask; // IntTask.GetResult(); - 断言，任务无效，因为它未启动` |
|  | TTask<bool> BoolTask = Launch(UE_SOURCE_LOCATION, []{ return true; }); |
|  | bool bResult = BoolTask.GetResult(); |
|  |  |
|  | TTask<int32> IntTask; |
|  | // IntTask.GetResult(); - 断言，任务无效，因为它未启动 |
|  |  |
| `AddNested()` | 将给定任务注册为"当前"任务（父任务）的"嵌套"任务。**当前任务** 是当前线程所执行的任务。 **父任务** 在所有嵌套任务都完成之后才完成。 断言是否没有从另一个任务内部调用。 `template<typename TaskType> void AddNested(const TaskType& Nested);` **示例**： `FTask ParentTask = Launch(TEXT("Parent Task"), [] { FTask NestedTask = Launch(TEXT("Nested Task"), []{}); AddNested(NestedTask); } );` |
|  | template<typename TaskType> |
|  | void AddNested(const TaskType& Nested); |
|  | FTask ParentTask = Launch(TEXT("Parent Task"), |
|  | [] |
|  | { |
|  | FTask NestedTask = Launch(TEXT("Nested Task"), []{}); |
|  | AddNested(NestedTask); |
|  | } |
|  | ); |
|  |  |

## FTaskEvent

FTaskEvent会将其API的一部分与 `TTask<ResultType>` 共享。例如，`IsValid()` 、 `IsCompleted()` 等待和忙等待API是相同的。本小节仅介绍了特定于FTaskEvent的API。

| 引用任务事件 | 说明 |
| --- | --- |
| `FTaskEvent构造函数` |  |
| `FTaskEvent::AddPrerequisites` | 将其他任务（或任务事件）添加为先决条件。只能在触发任务事件之前调用。仅当所有先决条件都完成并且任务事件已触发时，它才为"已完成"（"信令"）。 `template<typename PrerequisitesType> void FTaskEvent::AddPrerequisites(const PrerequisitesType& Prerequisites);` **示例**： `FTaskEvent TaskEvent{ TEXT("TaskEvent") }; TArray<FTask> Prereqs { Launch(TEXT("Task A"), [] {}), Launch(TEXT("Task B"), [] {}) }; TaskEvent.AddPrerequisites(Prereqs); FTask TaskC = Launch(TEXT("Task C"), [] {}); FTask TaskD = Launch(TEXT("Task D"), [] {}); TaskEvent.AddPrerequisites(Prerequisites(TaskC, TaskD)); TaskEvent.Trigger();` |
|  | template<typename PrerequisitesType> |
|  | void FTaskEvent::AddPrerequisites(const PrerequisitesType& Prerequisites); |
|  |  |
|  | FTaskEvent TaskEvent{ TEXT("TaskEvent") }; |
|  |  |
|  | TArray<FTask> Prereqs |
|  | { |
|  | Launch(TEXT("Task A"), [] {}), |
|  | Launch(TEXT("Task B"), [] {}) |
|  | }; |
|  | TaskEvent.AddPrerequisites(Prereqs); |
|  |  |
|  | FTask TaskC = Launch(TEXT("Task C"), [] {}); |
|  | FTask TaskD = Launch(TEXT("Task D"), [] {}); |
|  | TaskEvent.AddPrerequisites(Prerequisites(TaskC, TaskD)); |
|  |  |
|  | TaskEvent.Trigger(); |
|  |  |
| `FTaskEvent::Trigger` | 任务事件在触发之前是未完成（"非信令"）。触发任务事件并不一定会使其成为信令，仅当其所有先决条件都完成并且任务事件已触发时，它才为已完成。 每个任务事件都必须触发。否则，其析构函数将断言任务事件未完成。 `void FTaskEvent::Trigger();` |

## FPipe

管道是不可复制、不可移动的轻量级对象。管道的构造不会分配动态内存，并且不会执行昂贵的处理。

| 引用名称 | 说明 |
| --- | --- |
| `FPipe构造函数` | 使用给定调试名称构造管道对象。调试名称用于调试之用，以识别管道对象。 `FPipe::FPipe(const TCHAR* DebugName);` 管道是不可复制、不可移动的轻量级对象。管道的构造不会分配动态内存，并且不会执行昂贵的处理 |
|  | FPipe::FPipe(const TCHAR* DebugName); |
|  |  |
| `FPipe析构函数` | 检查管道是否有未完成的任务。管道在销毁时不能有未完成的任务。 |
| `HasWork()` | 检查管道是否有未完成的任务。管道在销毁时不能有未完成的任务。 `bool FPipe::HasWork() const;` |
|  | bool FPipe::HasWork() const; |
|  |  |
| `WaitUntilEmpty()` | 该调用将阻塞，直至管道的所有任务都完成。 `void FPipe::WaitUntilEmpty();` 请参考函数 `HasWork()`，获取额外示例。 |
|  | void FPipe::WaitUntilEmpty(); |
|  |  |
| `Launch()` | 在管道中启动一个任务。相同管道中启动的任务不会并发执行（一个接一个），但可以由不同的工作线程执行。 `template<typename TaskBodyType> TTask<TInvokeResult_T<TaskBodyType>> FPipe::Launch( const TCHAR* InDebugName, TaskBodyType&& TaskBody, LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Default ); template<typename TaskBodyType, typename PrerequisitesCollectionType> TTask<TInvokeResult_T<TaskBodyType>> FPipe::Launch( const TCHAR* InDebugName, TaskBodyType&& TaskBody, PrerequisitesCollectionType&& Prerequisites, LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Default );` |
|  | template<typename TaskBodyType> |
|  | TTask<TInvokeResult_T<TaskBodyType>> FPipe::Launch( |
|  | const TCHAR* InDebugName, |
|  | TaskBodyType&& TaskBody, |
|  | LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Default |
|  | ); |
|  |  |
|  | template<typename TaskBodyType, typename PrerequisitesCollectionType> |
|  | TTask<TInvokeResult_T<TaskBodyType>> FPipe::Launch( |
|  | const TCHAR* InDebugName, |
|  | TaskBodyType&& TaskBody, |
|  | PrerequisitesCollectionType&& Prerequisites, |
|  | LowLevelTasks::ETaskPriority Priority = LowLevelTasks::ETaskPriority::Default |
|  | ); |
| `IsInContext()` | 如果从属于该管道的任务内部调用，则返回true。可以用于检查访问受管道保护的共享资源是否安全，例如，当代码没有作用域被管道化的任务所执行时。 `bool FPipe::IsInContext() const;` |

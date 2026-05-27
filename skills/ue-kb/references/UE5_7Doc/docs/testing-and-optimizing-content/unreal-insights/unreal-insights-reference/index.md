---
title: "Unreal Insights参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-insights-reference-in-unreal-engine-5"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "Unreal Insights参考"]
---

# Unreal Insights参考

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / Unreal Insights参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-insights-reference-in-unreal-engine-5

## Trace通道

Trace可以发出大量的数据，通道可以在追踪时提供对数据速率的控制。每个事件都与一个或多个通道绑定，如果所需的通道没有启用，那么其中的事件不会被发射至Trace流中。

通道预设可以将许多通道分组并且提供基于场景的进入点。用户可以使用添加至[Trace.ChannelPresets]类别中的配置文件定义自己的预设。

下表展示可用的Trace通道以及每个通道的 **文件路径（File Path）**、 **受支持平台（Supported Platforms）** 以及 **备注（Notes）**。

> [!NOTE]
> 名称中的复数被自动忽略，单数和复数名称完全相同。

| 通道 | 备注 | 受支持平台 | 文件路径 |
| --- | --- | --- | --- |
| **动画（Animation）** | 动画Insights(GameplayInsights/RewindDebugger)插件。 |  | `Runtime\\Engine\\Private\\Animation\\AnimTrace.cpp` |
| **资产加载时间（AssetLoadTime）** | 命名CPU计时器，用于 `UObject::Serialize`。还可以切换为蓝图名称。需要CPU通道和 `-statnamedevents`。 | 全平台。 | `Runtime\\Core\\Private\\Serialization\\LoadTimeTrace.cpp` `Runtime\\CoreUObject\\Private\\UObject\\LinkerLoad.cpp` |
| **资产元数据（Asset Metadata）** | 用于内存分配的元数据，包括资产名称和类名称。需要元数据通道。由MemAlloc通道使用。 | Win64 XB1/XSX PS4/PS5 Switch Linux | `Engine\\Source\\Runtime\\Core\\Public\\ProfilingDebugging\\MetadataTrace.h` |
| **书签（BookMark）** | 低频率标记，用于标记重要过渡，可以帮助用户快速了解概况。 包括关卡加载或引擎启动阶段。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\MiscTrace.cpp` |
| **调用堆栈（Callstack）** | 调用堆栈信息。用于关联调用堆栈和分配。 需要启用模块（Module）通道进行符号解析。 | Win64 XBox PS4/PS5 Switch | `Runtime\\Core\\Private\\ProfilingDebugging\\CallstackTrace.cpp` |
| **Concert** | Concert插件。 |  | `Plugins\\Developer\\Concert\\ConcertMain\\Source\\ConcertTransport\\Private\\ConcertLogGlobal.cpp` |
| **场景切换（ContextSwitch）** | 追踪场景切换事件。在Windows系统中，游戏和编辑器运行时应该为"以管理员身份运行。" | Win64 XBox PS4/PS5 | `Runtime\\Core\\Private\\ProfilingDebugging\\PlatformEvents.cpp` |
| **烘焙（Cook）** | 显示烘焙特定的命名CPU计时器。需要"CPU"通道。它会添加"CookByTheBook"CPU计时事件和"SaveCookedPackage"CPU计时事件（连同元数据） |  | `Editor\\UnrealEd\\Private\\Cooker\\CookProfiling.h/.cpp` |
| **计数器（Counter）** | 通用计数器，用于追踪数值（浮点、整型）变化。计数器Trace API。同样也会启用CSV Profiler Trace。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\CountersTrace.cpp` |
| **CPU** | 有名称的CPU计时器。 可以使用`-statnamedevents` 命令行参数添加更多计时器。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\CpuProfilerTrace.cpp` |
| **文件（File）** | 文件I/O跟踪通道（打开、重新打开、读取、写入、关闭事件）。 | Win64 Mac, XBox PS4. | `Runtime\\Core\\Private\\ProfilingDebugging\\PlatformFileTrace.cpp` |
| **帧（Frame）** | 游戏和渲染帧。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\MiscTrace.cpp` |
| **GPU** | 命名GPU计时器。基于GpuProfiler数据。 |  | `Runtime\\RHI\\Private\\GpuProfilerTrace.cpp` |
| **关卡快照（LevelSnapshots）** | 关卡快照插件。 |  | `Plugins\\VirtualProduction\\LevelSnapshots\\Source\\LevelSnapshots\\Private\\LevelSnapshotsLog.cpp` |
| **加载时间（LoadTime）** | 资产加载Insights跟踪通道。包体加载时间（特定追踪事件）+ 特定于包体加载的命名CPU计时器。需要"CPU"通道。同时添加 "LoadPackageInternal" CPU计时事件（连同元数据）。参阅SCOPED_LOADTIMER和SCOPED_CUSTOM_LOADTIMER宏的使用方式。 |  | `Runtime\\Core\\Public\\ProfilingDebugging\\LoadTimeTracker.h Runtime\\Core\\Private\\Serialization\\LoadTimeTrace.cpp` |
| **日志（Log）** | 日志信息。 |  | `Runtime\\Core\\Private\\Logging\\LogTrace.cpp` |
| **内存分配（MemAlloc）** | 内存分配。使用模块和调用堆栈。 | Win64 XBox PS4/PS5 Switch | `Runtime\\Core\\Private\\ProfilingDebugging\\MemoryTrace.cpp` |
| **内存（Memory）** | 包含所有分配事件、调用堆栈和标签。这相当于 `-trace=memalloc,callstack,memtag`。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\MemoryTrace.cpp` |
| **Memory_Light** | 包含所有分配事件和标签。这相当于 `-trace=memalloc,memtag`。 |  | `Runtime\\Core\\Private\\ProfilingDebugging\\MemoryTrace.cpp` |
| **内存标签（MemTag）** | 内存标签统计数据。定期追踪各个标签的内存使用快照。依赖LLM子系统进行追踪。默认包含"-llm"。Init()之后可用。 |  | `Runtime\\Core\\Private\\HAL\\LowLevelMemTracker.cpp` |
| **消息（Messaging）** | UDP通信插件。 |  | `Plugins\\Messaging\\UdpMessaging\\Source\\UdpMessaging\\Private\\UdpMessagingTracing.cpp` |
| **元数据（Metadata）** | 支持通用元数据范围。 | 全平台。 | `Engine\\Source\\Runtime\\Core\\Public\\ProfilingDebugging\\MetadataTrace.h` |
| **模块（Module）** | 模块加载信息。 | Win64 XBox PS4/PS5 Switch | `Runtime\\Core\\Private\\ProfilingDebugging\\ModuleDiagnostics.cpp` |
| **网络（Net）** | 网络追踪通道。需要-NetTrace=1（用于启用"帧（Frame）"通道。 |  | `Runtime\\Net\\Core\\Private\\Net\\Core\\Trace\\Reporters\\NetTraceReporter.cpp` |
| **网络预测（NetworkPrediction）** | 网络预测Insights插件。 |  | `Plugins\\Runtime\\NetworkPrediction\\Source\\NetworkPrediction\\Private\\NetworkPredictionTrace.cpp` |
| **Niagara** | Niagara插件。 |  | `Plugins\\FX\\Niagara\\Source\\Niagara\\Private\\NiagaraTrace.cpp` |
| **对象（Object）** | GameplayInsights/RewindDebugger插件。 UObject类、世界、实例和事件。 |  | `Runtime\\Engine\\Private\\ObjectTrace.cpp` |
| **物体属性（ObjectProperties）** | GameplayInsights/RewindDebugger插件。 |  | `Plugins\\Animation\\GameplayInsights\\Source\\GameplayInsights\\Private\\ObjectPropertyTrace.cpp` |
| **物理（Physics）** | Chaos视觉效果调试器。 |  | `Runtime\\Experimental\\Chaos\\Private\\ChaosVisualDebugger\\ChaosVisualDebuggerTrace.cpp` |
| **姿势搜索（PoseSearch）** | PoseSearch插件。 |  | `Plugins\\Experimental\\Animation\\PoseSearch\\Source\\Runtime\\Private\\Trace\\PoseSearchTraceLogger.cpp` |
| **RDG** | RDG Insights插件。 |  | `Runtime\\RenderCore\\Private\\RenderGraphTrace.cpp` |
| **区域（Regions）** | 持续较长的计时事件。 | 全平台。 | `Runtime\\Core\\Public\\ProfilingDebugging\\MiscTrace.h` |
| **渲染命令（RenderCommands）** | 用于在渲染线程上执行的命令的CPU/GPU命名计时器。 |  | `Runtime\\RenderCore\\Private\\RenderingThread.cpp` |
| **RHI命令（RHICommands）** | 用于RHI命令的CPU/GPU命名计时器。 |  | `Runtime\\RHI\\Private\\RHICommandList.cpp` |
| **保存时间（SaveTime）** | 特定于包体保存的命名CPU计时器。需要"CPU"通道。 添加名字带有"UPackage_Save_"前缀的CPU计时器。更多细节参考SCOPED_SAVETIMER宏的使用方式。 |  | `Runtime\\CoreUObject\\Private\\UObject\\SavePackage\\SavePackageUtilities.h / .cpp` |
| **截屏（Screenshot）** | 捕获截屏，使用Trace.Screenshot控制台命令或 `TRACE_SCREENSHOT()` API触发。 | 全平台。 | `Runtime\\Core\\Public\\ProfilingDebugging\\MiscTrace.h` |
| **Slate** | Slate Insights插件。 |  | `Runtime\\SlateCore\\Private\\Trace\\SlateTrace.cpp` |
| **统计数据（Stats）** | 统计计数器。基于统计系统。 |  | `Runtime\\Core\\Private\\Stats\\StatsTrace.cpp` |
| **任务（Task）** | 任务图表跟踪通道。 |  | `Runtime\\Core\\Private\\Async\\TaskTrace.cpp` |
| **追踪源过滤（TraceSourceFilters）** | 追踪源过滤插件。 |  | `Plugins\\Developer\\TraceSourceFiltering\\Source\\SourceFilteringTrace\\Private\\SourceFilterTrace.cpp` |
| **可视化日志（VisualLogger）** | 可视化日志开始将数据记录到文件中。 |  | `Runtime\\Engine\\Private\\VisualLogger\\VisualLoggerTraceDevice.cpp` |

一些插件或运行时代码会自动启用或禁用通道，如下表所示：

| 插件 | 通道描述 |
| --- | --- |
| 游戏Insights/回溯调试器（Gameplay Insights / Rewind Debugger） | 当编辑器内播放（Play in Editor（PIE））启动时切换开关 **物体（Object）** 通道，并且在开始记录时切换开关 **物体属性（ObjectProperties）**、 **动画（Animation）** 和 **帧（Frame)** 通道。 |
| 追踪源过滤（TraceSourceFiltering） | 当插件启动时，**追踪源过滤（TraceSourceFilters）** 通道会打开。 |
| 网络预测（NetworkPrediction） | 当插件启动时，**网络预测（NetworkPrediction）** 通道会打开。 |
| 姿势搜索（PoseSearch） | 当插件启动时，**姿势搜索（PoseSearch）** 通道会打开。 |
| 可视化日志（VisualLogger） | 进行记录时，**可视化日志（Visual Logger）** 通道会打开。 |
| -NetTrace=1 | 从命令行启用时，**网络（Net）** 和 **帧（Frame）** 通道会打开。 |

## 控制运行时

### 宏

为了将 **虚幻引擎** 的众多功能最大化，你可以使用宏和命令行来自定义项目输出。除此之外，鼠标和键盘输入快捷键可以帮助用户更高效地使用Insights窗口。 参考下表来基于你想要看到的数据判断要调整哪一个宏：

| 宏名称 | 默认状态 | 源文件 | 区域描述 |
| --- | --- | --- | --- |
| `UE_TRACE_ENABLED` | 开启 | `Engine/Source/Runtime/TraceLog/Public/Trace/Config.h` | 整个系统的中央控制。 |
| `UE_TASK_TRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/Async/TaskTrace.h` | 控制任务图表（Task Graph）事件的追踪。 `-trace=default,task` |
| `LOGTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/Logging/LogTrace.h` | 控制是否将日志消息报告至虚幻引擎。 `-trace=log` |
| `MISCTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/ProfilingDebugging/MiscTrace.h` | 控制书签、帧、线程和线程组的追踪。 `-trace=bookmark,frame` |
| `CPUPROFILERTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/ProfilingDebugging/CpuProfilerTrace.h` | 控制CPU计时器和计时事件。 `-trace=cpu` |
| `LOADTIMEPROFILERTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/CoreUObject/Public/Serialization/LoadTimeTrace.h` | 控制加载资产相关事件的追踪。 `-trace=loadtime` |
| `STATSTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/Stats/StatsTrace.h` | 控制统计数据计数的追踪。 `-trace=stats` |
| `PLATFORMFILETRACE_ENABLED` | 开启 | 只在Windows、Mac和PS4平台上默认启用。 `Engine/Source/Runtime/Core/Public/ProfilingDebugging/PlatformFileTrace.h` | 控制文件活动的追踪，比如打开、关闭、读取和写入文件。 -trace=file |
| `PLATFORM_SUPPORTS_PLATFORM_EVENTS` | 开启 | `Engine/Source/Runtime/Core/Private/ProfilingDebugging/PlatformEvents.h` | 在支持平台事件（场景切换事件）的平台上启用。 `-trace=ContextSwitch` |
| `GPUPROFILERTRACE_ENABLED` | 开启 | `Engine/Source/Runtime/RHI/Public/GpuProfilerTrace.h` | 控制GPU计时器和计时事件。 `-trace=gpu` |
| `UE_NET_TRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Net/Core/Public/Net/Core/Trace/NetTrace.h` `Engine/Source/Runtime/Net/Core/Public/Net/Core/Trace/Config.h` | 控制网络包体内容的追踪。 `-trace=net` |
| `UE_MEMORY_TAGS_TRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/ProfilingDebugging/TagTrace.h` | 启用标签scope的追踪。禁用后，追踪到的内存分配不会被关联标签。 `-trace=memtag` |
| `UE_CALLSTACK_TRACE_ENABLED` | 开启 | `Engine/Source/Runtime/Core/Public/ProfilingDebugging/CallstackTrace.h` | 启用追踪调用堆栈。禁用后，追踪到的内存分配不会包含调用堆栈。 `-trace=callstack` |

### 命令行选项

当与宏一起使用时，以下命令行选项可启用追踪数据：

| 名行选项 | 说明 |
| --- | --- |
| `-trace` `-trace=<channel1>` | 通过将事件归类到命名的组中，来管理生成的追踪数据的多少。 比如， `-trace=cpu,frame,bookmark` 启用 CPU 分析事件、帧标注和书签。 用于启用的通道的追踪数据会被缓存在"保持开启（Always on）"缓冲中。 |
| `-tracehost=<ip>` | 将一个追踪发送至指定的IP地址，默认发送至一个本地的主机地址。 更多 `-tracehost` 的相关信息，请参阅[Unreal Insights](../trace/index.md)。 |
| `-tracefile, -tracefile =<filename>` | 运行 "WriteTo" 文件追踪控制命令。这将会运行追踪默认命令。 |
| `-tracefiletrunc` |  |
| `-tracetailmb= N` | N指定尾部追踪缓冲区大小，以MiB为单位。尾部追踪缓冲区的默认大小为4MiB。 |
| `-notraceserver` | 如果指定，游戏或者编辑器不i会启动本地追踪服务器。 |
| `-statnamedevents` | 记录统计命名事件的追踪数据。通过 `GCycleStatsShouldEmitNamedEvents = 1;` 启用，或通过调用 "Stat NamedEvents" 控制台命令启用。 |
| `-verbosenamedevents` | 记录冗长命名事件的追踪数据。通过 `GCycleStatsShouldEmitVerboseNamedEvents = 1;` 启用，或通过调用 "Stat VerboseNamedEvents" 控制台命令启用。冗长循环状态示例："CPU Stall - [...]", "Other TaskGraph Stalls", "FQueuedThread::Run.WaitForWork"。 |

### 控制台命令

| 命令 | 描述 |
| --- | --- |
| `Trace.Send <Host> [ChannelSet]` | 开始追踪至一个追踪存储器。是追踪存储器的IP地址或者主机名。[ChannelSet]是可选的要启用的通道/预设的逗号分隔列表。 |
| `Trace.SnapshotSend <Host> <Port>` | 将当前内存内追踪缓冲区的快照发送至追踪存储器。 |
| `Trace.File [<File>] [ChannelSet]` | 开始将事件追踪至一个文件。如果不指定文件路径，默认的utrace文件保存路径为 `YourProject/Saved/Profiling`。如果不指定文件名，utrace文件名会基于当前时间戳自动生成。支持Late Connect。 用例： `trace.file [ChannelSet]` 文件的路径为 `YourProject}/Saved/Profiling/`。文件名 `*.utrace. Filename` 自动生成。 `trace.file MyFile.utrace [ChannelSet]` 的路径为 `YourProject/Saved/Profiling/MyFile.utrace`。 `trace.file C:/Path/ [ChannelSet]` 是绝对的文件路径，文件名自动生成。 `trace.file Path/ [ChannelSet]` 是 `YourProject/Saved/Profiling/` 的相对路径，文件名自动生成。 |
| `Trace.Start[ChannelSet]` | 保持默认启用的通道。 |
| `Trace.Stop` | 停止追踪分析事件。 |
| `Trace.Enable[ChannelSet]` | 启用一组通道。 |
| `Trace.Disable[ChannelSet]` | 停用一组通道。如果不指定通道组，所有通道都会禁用。 |
| `Trace.Pause` | 暂停所有正在传输事件的追踪通道。 |
| `Trace.Resume` | 继续先前暂停的追踪（重新启动暂停的通道）。 |
| `Trace.Status` | 在控制台显示追踪状态。 |

## 控制Unreal Insights

### 命令行选项

| 命令行选项 | 用法 | 说明 |
| --- | --- | --- |
| `-OpenTraceId` | `-OpenTraceId=id` | 强制Unreal Insights开始分析 "查看器模式（Viewer mode）" 中指定的ID。 |
| `-OpenTraceFile` | `-OpenTraceFile=file.utrace` | 强制Unreal Insights开始分析 "查看器模式（Viewer mode）" 中指定的文件。 |
| `-Store` | `-Store=<ip>:port` | 连接浏览器与指定追踪存储器。 `-StoreHost=address` 和 `-StorePort=port` 也可以使用。 |
| `-TraceAutoStart` | `-TraceAutoStart=[0\|1]` | 如果Unreal Insights正在运行，则在启动时自动开始追踪到本地追踪服务器；或者通过控制台命令来启动追踪。默认开启。 |
| `-NoTraceThreading` | `-NoTraceThreading` | 禁用追踪工作器线程。 |

## 键盘输入快捷键

> [!WARNING]
> 所有输入和控制参考都是有限的并且可能改变。

### 计时Insights窗口（Timing Insights）

以下鼠标和键盘命令可以帮助你更高效地使用计时Insights：

#### 帧面板（Frames Panel）

| 输入快捷键 | 功能 |
| --- | --- |
| **左键点击** | 选择一帧 计时视图会将选中的帧居中。 |
| **右键点击** | 打开菜单 |
| **左/右键拖动** | 水平缩放 |
| **鼠标滚轮** | 水平缩放 |
| **Shift + 鼠标滚轮** | 垂直缩放 |

#### 计时面板（Timing Panel）

| 输入快捷键 | 功能 |
| --- | --- |
| **左/右键拖动** | 水平或垂直拖动 |
| **Ctrl + 左/右键拖动** | 水平拖动 |
| **Shift + 左/右键拖动** | 垂直拖动 |
| *鼠标滚轮** | 缩放 |
| **Ctrl + 鼠标滚轮** | 水平滚动 |
| **Shift + 鼠标滚轮** | 垂直滚动 |
| **右键点击** | 打开快捷菜单 可以用于图表轨道（Graph track）的选项。 |
| **左键点击时间事件** | 选择时间事件 |
| **左键点击空白** | 清楚选择 |
| **Ctrl + 左键双击** | 选择选中计时事件的时间区间 回车键也是相同的功能。 |
| **时间尺（Time Ruler）上左/右键拖动** | 选择时间区域 在计时器（Timer）和计数器（Counter）视图中，聚合状态会自动更新。 |
| **Ctrl+F** | 开关快速查找菜单。 |
| **F** | 框定上一个选择，然后会在框定时间区间和计时事件之间切换 上一个选择可以是时间区间也可以是计时事件。 |
| **G** | 切换图表轨道（Graph track）可视度，显示游戏和渲染帧，包括计数（Counter Series）的占位符。 |
| **Y** | 切换GPU计时轨道（GPU Timing track）可视度 |
| **U** | 切换CPU计时轨道（CPU Timing track）可视度 |
| **I** | 切换I/O概况和活动轨道（Activity track）可视度 |
| **O** | 切换I/O活动轨道（I/O Activity track）内文件活动的背景事件的可视度 |
| **L** | 切换资产加载轨道（Asset Loading track）可视度 |
| **C** | 在正常和紧凑模式中切换，改变时间事件的显示方式。 |
| **V** | 自动隐藏空白时间轴。 空白时间轴中没有计时事件。 |
| **X** | 选择下一个事件深度限制：单线（Single Lane）、4线、无限。 |
| **B** | 切换书签的可见性 书签默认显示。 |
| **M** | 切换时间标记（Time markers）的可见性（全部追踪日志而不只是书签） 时间标记默认不显示。 |
| **-/+ | 缩放 |
| **Ctrl + 方向箭头** | 水平和垂直移动视角 |
| **方向键** | 选择其前一个或者下一个子母时间事件 |
| **回车键** | 选择当前所选计时事件的时间区间 Ctrl + 左键双击也是同样的功能。 |

### 网络Insights窗口

以下鼠标和键盘命令可以帮助你更高效地使用网络Insights：

| 输入快捷键 | 功能 |
| --- | --- |
| **左键点击包体** | 选择对应的包体 |
| **Shift + 左键点击不同的包体** | 选择一个区间的包体 |
| **Ctrl + A** | 选择所有包体 |
| **左右方向键** | 选择上一个/下一个包体 |
| **Shift + 左右方向键** | 左右延申选择（多个包体） |
| **Ctrl + shift + 左右方向键** | 左右收缩选择（多个包体） |
| **双击事件** | 选中全部含有包体内容视图中事件的包体，同时遮住所有其它事件 |

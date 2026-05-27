---
title: "舞台监视器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/stage-monitor-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "与媒体组件通信", "舞台监视器"]
---

# 舞台监视器

> 路径：虚幻引擎5.7文档 / 使用媒体 / 与媒体组件通信 / 舞台监视器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/stage-monitor-with-unreal-engine

在实时环境中操作舞台时，多台运行 **虚幻引擎** (UE)实例的机器协同工作，彼此依赖。操作人员可以使用一些实例在LED墙上进行渲染，某些实例可用于在编辑器中修改场景，其他实例可以用于复合。利用舞台监视器，你可以收到所有这些UE实例中的不同事件的报告，能够解决设置中的任何问题。

![undefined](../../../../assets/images/70/706019eb3813ce799232c6e3a4ca334bccbb3fc45a6df63f9d42bfaa213d0bc3.png)

Click image to expand.

在此预览结束时，你将熟悉如何使用舞台监视器以及如何为项目添加自定义事件。

## 需要的插件

将以下插件添加到你的项目，以开始使用舞台监视器。

| **插件名称** | **用途** |
| --- | --- |
| **舞台监控（Stage Monitoring）** | 必需 - 主要插件，用于启用数据提供程序和舞台监控逻辑。 |
| **虚拟制作工具（Virtual Production Utilities）** | 必需 - 通过StageMonitoring插件启用，能够使用VirtualProduction角色的功能。 |
| **Switchboard** | 可选 - 加速启动运行舞台的UE的多个实例。它还可以用于配置分配给每个实例的角色。 |

按照下面的步骤为你的项目启用插件：

1. 从主菜单栏中选择 **编辑（Edit）**> **插件（Plugins）**。
2. 在 **插件（Plugins）** 窗口中，找到 **舞台监视器（Stage monitor）** 插件并选中 **启用（Enable）**。

   ![undefined](../../../../assets/images/9a/9a587d96d9b592a5473d5affae4695f3944da84403b5143467c21caed1240166.jpg)

   Click image to expand.
3. 看到提示后，选择 **是（Yes）**。
4. 点击 **立即重启（Restart Now）** 以关闭编辑器并在激活新插件的情况下重启。
5. 重复执行上述流程以启用 **虚拟制作工具（Virtual Production Utilities）** 和 **Switchboard** 插件。

> [!NOTE]
> 这些插件可能已默认启用，具体取决于你所使用的UE版本。最好在插件（Plugins）菜单中再次检查并确认它们已启用。

## 设置时间码

虚幻引擎的每个实例都会生成自己的时间码。当多个机器彼此通信时，事件如果未同步，那么在舞台监视器中可能以混乱的顺序显示。为了有效监控UE实例，请在要监控的所有实例上启用时间码，并使用相同的时间码提供程序。如需更多有关在多台机器上同步时间码的信息，请参见[时间码和同步锁相](../../integrating-media/professional-video-io/timecode-and-genlock/index.md)。

## 分配机器角色

在操作舞台时，每个机器都可以扮演不同的角色，例如渲染器、编辑器和复合器。可以在命令行参数中为UE的实例分配角色，或者在Switchboard中根据实例的职能使用不同的逻辑来分配角色。舞台监视器使用这些角色来确定实例可以生成哪些事件以及是否应该监控该实例。

### 在Switchboard中分配角色

Switchboard将在每个实例的项目文件夹的 `\Config\Tags\VPRoles.ini` 中查找文件 `VPRoles.ini`。下例中向 `VPRoles.ini` 文件添加了角色Render（渲染器）、Editor（编辑器）和Compositor（复合器）：

```
[/Script/GameplayTags.GameplayTagsList]GameplayTagList=(Tag="Render", DevComment="")GameplayTagList=(Tag="Editor", DevComment="")GameplayTagList=(Tag="Compositor", DevComment="")
```

在Switchboard中，你可以在设置中调整每个实例的角色。

![undefined](../../../../assets/images/dc/dc31fb180351b7f4cd9613f1879958382c82444ed3538d689163f643c6599f86.png)

Click image to expand.

### 在命令行中分配角色

你可以通过命令行参数为每个实例分配一个角色。启动UE实例时，添加参数 `: -VPRole=RoleName`，其中 `RoleName` 是要分配给机器的角色，例如Editor（编辑器）。

## 打开舞台监视器

除非使用了角色过滤，否则舞台监视器数据提供程序默认启动。。所有实例都启动之后，它们将查找舞台监视器，发现后就会开始发送事件。监控其他实例的实例会定期广播消息，以发现数据提供程序。发现监视器后，数据提供程序将开始发出发射的任何事件。启动舞台监视器以确认它按照预期的顺序发送和接收信息。

按照下面的步骤启动舞台监视器：

1. 点击 **窗口（Window）** 选项卡，然后点击 **虚拟制片（Virtual Production）** > **舞台监视器（Stage monitor）**。
2. 使用 **监视器状态（Monitor Status）** 切换开关来激活舞台监视器。
3. 激活之后，你应该能够在上方的菜单中查看连接的实例。

   ![undefined](../../../../assets/images/c1/c1f7647e478fd72a8507555eea3807a84e19b2790cc2b548d0c44eb9eb04a48b.png)

   Click image to expand.
4. 此外，一旦激活你就能够看到稳定的舞台事件流不停填充下面的窗口。

   ![undefined](../../../../assets/images/c8/c81387e68a91b0132131bfe53b7199b48d53e02efcf304c21225ef0090c6d5ac.png)

   Click image to expand.

## 使用舞台监视器

一旦信息开始流入舞台监视器，就有大量的内容要处理。以下是一些要查找的项，以及一些可以帮助你管理事件日志的提示。

### 临界状态

[镜头试拍录制器](../../../animating-characters-and-objects/cinematics-and-movie-making/cinematic-workflow-guides-and-examples/record-gameplay/index.md)使用事件类型"临界状态"来指定何时录制场景。录制时，任何事件都可能影响结果。这意味着当镜头试拍开始时，舞台会进入临界状态，当停止镜头试拍时，舞台退出临界状态。由于临界状态是一个事件类型，因此可以为任何场景设置你自己的临界状态。

要查看舞台监视器，请按照下面的步骤，使用TakeRecorder进入临界状态。

1. 启动 **舞台监视器（Stage Monitor）**，然后确认UE的所有实例都已连接并且可以正确报告事件。
2. 通过转到 **窗口（Window）** > **过场动画（Cinematics）** > **镜头试拍录制器（Take Recorder）**，启动 **镜头试拍录制器（Take Recorder）**。
3. 在 **镜头试拍录制器（Take Recorder）** 中，点击 **开始镜头试拍（Start Take）** 按钮。
4. 在短暂的停顿后，你会注意到舞台监视器状态指示器从绿色（未运行）变成红色（在运行），表示舞台监视器现在处于临界状态。
5. 请注意，在临界状态下，事件日志中的事件将突出显示。
6. 点击 **镜头试拍录制器（Take Recorder）** 中的 **停止镜头试拍（Stop Take）** 按钮即可停止镜头试拍。

下面的视频展示了实际操作流程。

### 过滤

一段时间后，消息日志会变多，在其中查找特定内容会变得更难。使用过滤菜单可以轻松筛选出你感兴趣的消息类型，你要分离出的数据提供程序，以及仅查看在舞台运行时发生的事件。

1. 通过选择 **窗口（Window）** > **虚拟制片（Virtual Production）** > **舞台监视器（Stage Monitor）**，启动 **舞台监视器（Stage Monitor）**。
2. 在 **事件日志（Event Log）** 下，展开 **过滤器（Filters）** 下拉菜单。
3. 选择 **消息类型（Message Type）** 以按特定消息类型进行过滤。
4. 选择 **提供程序（Provider）** 以按 **事件提供程序（Event Provider）** 过滤事件。
5. 启用并选择 **角色（Role）** 选项，以根据角色进行过滤。
6. 启用并选择 **临界状态源（Critical State Source）** 选项，以根据临界状态源进行过滤。
7. 启用并选择 **角色（Role）** 选项，以根据角色进行过滤。

### 导出/导入

会话完成后，可以将所有事件和提供程序导出到JSON文件。随后可以在外部查看这些日志，或直接在UE中查看。

1. 通过选择 **窗口（Window）** > **虚拟制片（Virtual Production）** > **舞台监视器（Stage Monitor）**，启动 **舞台监视器（Stage Monitor）**。
2. 注意舞台监视器（Stage Monitor）左上角附近的五个按钮。
3. 点击 **磁盘图标（disk icon）** 可导出当前日志。点击该按钮之后，系统将询问要将日志保存到哪里。
4. 点击左侧的 **橙色圆点（orange dot）** 可以进入查看模式。
5. 进入查看模式之后，可以看到 **当前会话（CurrentSession）** 旁边的名称更改为你正在查看的文件。
6. 在查看模式下，点击 **文件夹图标（folder icon）** 可以加载先前记录的日志并查看。

> [!NOTE]
> 打开文件之后，可以使用相同的过滤器来分离出特定事件。

## 舞台监视器事件类型

一些舞台监视器事件类型是使用UE基础版本触发的。通过添加对"StageDataCore"模块的依赖，以及继承事件的FStageProviderEventMessage，可以通过C++添加新的类型。此外，你可以将FStageProviderPeriodicMessage扩展到适用于重复消息。下表列出了常见事件，其文件位置以及用途。

| **事件名称** | **文件位置** | **说明** |
| --- | --- | --- |
| **临界状态提供程序消息（Critical State Provider Message）** | `StageMessages.h` | 在进入或退出临界状态时发送。 |
| **舞台提供程序发现响应消息（Stage Provider Discovery Response Message）** | `StageMessages.h` | 监视器和提供程序之间的发现协议的一部分。 |
| **舞台提供程序关闭消息（Stage Provider Close Message）** | `StageMessages.h` | 在提供程序关闭时发送。 |
| **帧性能提供程序消息（Frame Performance Provider Message）** | `StageMonitorUtils.h` | 定期发送以刷新提供程序的帧数据。 |
| **卡顿检测消息（Hitch Detection Message）** | `FramePerformanceProvider.h` | 当帧花费的时间超过最大允许时间时发送。 |
| **同步锁相状态事件（Genlock State Event）** | `GenlockWatchdog.h` | 当CustomTimeStep是同步锁相的步长并且其舞台更改时发送。 |
| **同步锁相卡顿事件（Genlock Hitch Event）** | `GenlockWatchdog.h` | 当CustomTimeStep是同步锁相的步长并且同步锁相信号（一个帧）丢失时发送。 |
| **时间码提供程序状态事件（Timecode Provider State Event）** | `TimecodeProviderWatchdog.h` | 当TimecodeProvider的状态更改时发送。 |
| **计时数据监控信道连接状态事件（Timed Data Monitor Channel ConnectionState Event）** | `TimecodeProviderWatchdog.h` | 需要TimedDataMonitor插件。当信道连接状态更改时发送。 |
| **计时数据监控信道评估事件（Timed Data Monitor Channel Evaluation Event）** | `TimedDataMonitorSubsystem.h` | 需要TimedDataMonitor插件。当信道评估状态更改时发送。 |

### 添加事件类型

按照下面的步骤添加自定义舞台监视器事件类型。

1. 在编辑器的主菜单中，选择文件（File） > 打开Visual Studio（Open Visual Studio）。如果未看到此选项，请选择新建C++类...（New C++ Class...）
2. 在Visual Studio的解决方案浏览器中查找.Build.cs文件中定义的，要在其中发射舞台事件的模块。将 `StageDataCore` 附加到PublicDependencyModuleNames范围：

   ```
        PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "StageDataCore" });
   ```
3. 在C++标头文件中，定义你的舞台事件数据结构，并从FStageProviderEventMessage或FStageProviderPeriodicMessage继承。在以下标头文件MyStageEvents.h中，FMyStageEvent从FStageProviderEventMessage继承且数据预期是int32：

   ```
                #include "StageMessages.h"		             #include "MyStageEvents.generated.h"		             USTRUCT ()             struct FMyStageEvent : public FStageProviderEventMessage             {             GENERATED_BODY ()		             public:             FMyStageEvent () = default;             FMyStageEvent (int32 InMyVariable) : MyVariable (InMyVariable)             {}		             public:             int32 MyVariable = 0;             }
   ```
4. 在你的代码中，无论要在何时发射事件，都可以将事件作为模板参数来调用IStageDataProvider::SendMessage<>()。例如，使用以下代码发射上面创建的事件：

   ```
                int32 DataToSend = 3;             IStageDataProvider::SendMessage<FMyStageEvent>(EStageMessageFlags::Reliable, DataToSend);
   ```

> [!NOTE]
> 由于UE使用UDP发送消息，消息可能丢失或丢弃，导致永远都不会收到。使用标记 `EStageMessageFlags::Reliable` 确保舞台监视器将收到消息。

如果你要发送定期消息，可以使用 `EStageMessageFlags::None` 而非Reliable（可靠）标记。

## 舞台监视器设置

你可以直接在工具中或在项目的项目设置（Project Settings）下找到舞台监视器的设置。

1. 要从虚幻编辑器访问舞台监视器设置，请转到 **编辑（Edit）** > **项目设置（Project Settings）**，然后搜索 **舞台（Stage）**。
2. 要从工具内部访问舞台监视器设置，请转到 **窗口（Window）** > **虚拟制片（Virtual Production）** > ****舞台监视器（Stage Monitor）**，启动 **舞台监视器（Stage Monitor）** 来开始。
3. 打开工具之后，点击 **cogs（@@@）** 按钮。

下面是对最重要设置及其目的的回顾。

### 一般设置

| **设置名称** | **说明** |
| --- | --- |
| **使用会话ID（Use Session ID）** | 你可以使用会话ID区分在同一网络中运行的两个舞台。然后可以在命令行中使用-StageSessionId=将该会话ID传递至每个实例。 |
| **超时间隔（Timeout Interval）** | 提供程序将监视控器视为断开连接所需的时间以及监视器将提供程序视为断开连接所需的时间。 |

## 监视器设置

| **设置名称** | **说明** |
| --- | --- |
| **支持的角色（Supported Roles）** | 用于过滤监控逻辑，以仅在实例具有特定角色时使用。例如，当你自动启动监控，但不希望它用于渲染节点时，此设置很有用。 |
| **自动开始（Auto Start）** | 默认情况下，监控逻辑不会自动启动。你可以在监视器面板中启动，但如果你希望在启动实例时启动它，可以选中该设置。如果不使用角色过滤，这意味着将监控所有实例，在使用多个实例时会显著增加网络流量。 |

### 提供程序设置

| **设置名称** | **说明** |
| --- | --- |
| **支持的角色（Supported Roles）** | 仅当实例具有该列表中的角色时启用数据提供程序逻辑。 |
| **消息类型角色排除（Message Type Role Exclusion）** | 默认情况下，任何数据提供程序都会发射任何被触发的事件。这可能会导致监控日志拥塞凌乱，尤其是在启用卡顿检测的情况下。例如，在使用编辑器时，当用户进入菜单时肯定会触发某些卡顿。要过滤此类事件，可以使用此设置为给定的事件类型分配特定的角色，以过滤哪些类型的实例可以触发该事件。 |
| **更新间隔（Update Interval）** | UE定期从所有数据提供程序发送此消息。它包含与帧计时有关的信息，并用作心跳。它可以让你在监视器面板中快速了解所有提供程序及其运行状况。该设置控制UE发送这些消息的速率。 |
| **启用卡顿检测（Enable Hitch Detection）** | 启用基本卡顿检测逻辑。这将使用数据统计线程，以从视口中获取消息，包括渲染节点。为避免此情况，需要使用-ExecCmds="DisableAllScreenMessages"来启动。 |
| **最小帧率（Minimum Frame Rate）** | 在渲染时或游戏线程花费的时间超过帧率间隔时，将会触发卡顿事件。 |

### 导出设置

| **设置名称** | **说明** |
| --- | --- |
| **仅保留最后一个时间段消息（Keep Only Last Period Message）** | 在导出到JSON时，仅导出所有时间段类型事件的最后一个消息。此设置用于减少文件大小。 |
| **排除消息类型（Exclude Message Types）** | 在导出到JSON时，添加你希望排除的消息类型。 |

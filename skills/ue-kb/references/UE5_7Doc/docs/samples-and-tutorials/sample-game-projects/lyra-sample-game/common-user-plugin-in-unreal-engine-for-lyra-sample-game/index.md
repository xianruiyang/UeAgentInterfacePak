---
title: "通用用户插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/common-user-plugin-in-unreal-engine-for-lyra-sample-game"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "通用用户插件"]
---

# 通用用户插件

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / 通用用户插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/common-user-plugin-in-unreal-engine-for-lyra-sample-game

# 通用用户插件

**通用用户（Common User）** 插件提供了C++、蓝图脚本和[在线子系统](../../../../gameplay-systems/online-subsystems-and-services/online-subsystem/index.md)（ **OSS** ）或其他在线后端之间的通用接口。它作为Lyra Starter Game的一部分发行，是可以在所有项目中使用的独立插件。

## 设计理念

OSS设计为一种通用接口，用于访问特定于平台的功能，例如登录、身份验证和多玩家会话。它提供了一种标准接口，可从通用虚幻引擎代码中调用，以执行各种操作。由于它是一种通用、灵活的库，因此并不直接支持典型Gameplay会话的高级流程。通用用户是可选插件，它提供辅助函数，帮助支持入场画面、游戏控制器处理和托管多玩家游戏等功能。

通用用户的功能使用可从C++或蓝图调用的[引擎子系统](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/programming-subsystems/index.md)进行公开。Lyra Starter Game提供了关于如何使用这些功能并将其集成到游戏中的示例。通用用户适用于现有OSS以及其他系统，比如试验性 **在线服务接口（Online Services Interface）** 。由于它采用游戏插件的形式，因此你可以修改它或创建子类，以用于专有的在线系统。通用用户将更新以支持许多与游戏相关的在线功能，例如排行榜和成就。它目前支持在多个平台上发布商用多玩家游戏所需的核心操作（登录、身份验证和会话）。

## 安装插件

要将插件安装到你的游戏中，请执行以下操作：

1. 从我们的 **虚幻引擎Github** 或虚幻引擎启动程序上的学习（Learn）选项卡获取Lyra Starter Game的内容和源代码。

   > [!WARNING]
   > 通用用户未设计为用于只包含蓝图的项目。

   > [!NOTE]
   > 如果你可访问引擎的公开版本中未包含的平台，你将需要使用包含这些平台的示例版本。
2. 在你的系统上找到 `c:Lyra/Plugins` 文件夹，然后将CommonUser文件夹复制到你的游戏项目的文件夹中。
3. 在编辑器中，找到工具栏，并点击 **编辑（Edit）> 插件（Plugins）** ，然后从插件浏览器搜索 **Common User** 插件并启用。

   ![common-user-plugin-setup](../../../../../assets/images/71/718ce6b654958aa137c24fcf928c54a6076fbbc24de847043cc4262049464f52.jpg)

   > [!TIP]
   > 你将需要启用项目所需的所有特定于平台的在线服务插件。
4. 重新编译你的项目以启用子系统。
5. 查看 `c:Lyra/Config` 和 `c:Lyra/Platforms/PlatformName/Config` 文件夹中的 `.ini` 文件，然后复制你想用于自己的.ini文件的所有值。

   > [!TIP]
   > Lyra配置文件中的设置和注释可用作一般指南来设置你自己的项目配置设置，并且编辑器内的 **项目设置（Project Settings）** 可用于提交其中一些更改。请参阅[Lyra可扩展性和设备描述](../scalability-and-device-profiles-in-lyra-sample-game/index.md)，了解更多信息。
6. 蓝图现在将可访问通用用户子系统。要启用对C++的支持，你需要将CommonUser添加到ModuleName.Build.cs文件的PrivateDependencyModuleNames部分。

   > [!NOTE]
   > 请参阅[虚幻引擎模块](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/unreal-engine-modules/index.md)，查阅更多文档。

## 使用在线服务插件

默认情况下，通用用户插件使用现有的[在线子系统](../../../../gameplay-systems/online-subsystems-and-services/online-subsystem/index.md)插件。

> [!NOTE]
> 在线子系统插件正在被在线服务插件（OSSv2）积极取代，在异步命令和错误处理方面做出改进。

[在线服务](../../../../gameplay-systems/online-subsystems-and-services/online-services/index.md)插件是一项测试中的功能，因此通用用户插件的初始版本在默认情况下不会使用它。要交换插件以使用新接口，你可以修改 `CommonUser.Build.cs`，将 `bUseOnlineSubsystemV1` 布尔值更改为false，然后找到游戏的 `Config/DefaultEngine.ini` 配置文件，并添加以下行。

```
[/Script/Engine.OnlineEngineInterface]bUseOnlineServicesV2=true
```

这将启用使用新接口时所需的版本依赖项。要使用[在线服务EOS](../../../../gameplay-systems/online-subsystems-and-services/online-services/online-services-eos-plugins/index.md)，你需要在包含 `[OnlineSubsystemEOS]` 小节的配置文件中禁用在线子系统EOS。

例如，在 `Lyra/Config/Custom/EOS/DefaultEngine.ini` 文件中，你应该将bEnabled布尔值设置为 `false`。

```
[OnlineSubsystemEOS]bEnabled=false
```

对于设计为兼容引擎的未来版本的游戏，推荐使用测试版的在线服务插件。如果你要开发自定义在线后端或计划将EOS用作主要后端，则可以启用在线服务支持。

## Lyra和通用用户

Lyra将在C++和蓝图中与通用用户插件交互。下面举了一些例子来说明Lyra将如何使用此插件提供的系统：

- CommonGame C++插件包括 **CommonGameInstance** （ `UCommonGameInstance` ）等类。特定于游戏的GameInstance子类可以从CommonGameInstance类继承，以集成CommonUser和CommonUI插件的功能。 你可以使用该类中的代码作为例子，了解如何将你的项目与不同的UI系统集成。
- **LyraFrontEndStateComponent** （ `ULyraFrontendStateComponent` ）直接从源代码访问CommonUser子系统。在显示主菜单（ **W_LyraFrontEnd** ）之前，系统会使用CommonUI显示特定于平台的按"开始"（Press Start）**画面（**W_LyraStartup** ），而此类就是这个逻辑的一部分。
- **W_LyraStartup** 等多个控件直接访问CommonUserSubsystem并使用函数或异步节点来处理用户操作。
- **LyraUserFacingExperienceDefinition** （ `ULyraUserFacingExperienceDefinition` ）类描述了如何使用多玩家FPS的标准菜单选项启动游戏会话。它由 **W_HostSessionScreen** 等控件用于创建会话描述，以传递到CommonSessionSubsystem中来托管或加入游戏会话。

Lyra Starter Game旨在作为[Epic在线服务](../../../../gameplay-systems/online-subsystems-and-services/online-subsystem/online-subsystem-eos-plugin/index.md)（EOS）子系统的正常运作例子。默认情况下，Lyra使用Null子系统，仅在编辑器中或局域网上支持多玩家。要启用对EOS的支持，你可以在创建打包版本时使用LyraGameEOS目标，或将以下选项添加到你的命令行：

```
-customconfig=EOS
```

这将从你的 `c:Lyra/Config/Custom/EOS` 目录加载特定于EOS的配置文件。这些配置文件应该修改为使用特定于你的项目的EOS标识符。

# 插件子系统

## 通用用户子系统

**通用用户子系统** (`UCommonUserSubsystem`) 旨在处理用户登录、身份验证和权限检查操作。 需要执行这些操作，才能使用与玩家配置文件绑定的游戏存档等功能。在能够联网的游戏中，第一步是用户登录，因为需要先执行这个步骤，其他在线功能才能运行。 通用用户子系统处理[身份](https://dev.epicgames.com/documentation/404)等OSS接口的初始化工作，并提供对其他子系统或Gameplay代码的访问权限。此子系统定义了用于描述单独用户状态的枚举和结构。 在下表中，你可以看到整个系统中使用的重要类型：

| 系统类型名称 | 说明 |
| --- | --- |
| ECommonUserOnlineContext | 一种枚举，用于识别应将哪一个更低级别的在线系统用于操作。蓝图和高级C++代码通常会使用合并了来自多个来源的信息的默认上下文（游戏）。 主机等平台有自己的身份验证层上，平台上下文可用于显式访问它。然后，服务上下文可用于显式访问EOS等基于平台层运作的服务，以提供跨平台运行等功能。 |
| UCommonUserInfo | 一种对象，用于存储系统所管理的每个单独用户的状态。每个用户都有自己的唯一网络ID，用于在PlayerState等类中识别该用户。在单玩家游戏中，只能有一个用户信息（User Info），但在本地多玩家游戏中，可以有多个用户信息对象（User Info Object）对应于某个特定于平台的用户（或不支持多个本地用户的平台上的某个访客）。 |
| ECommonUserInitializationState | 描述用户的总体登录/初始化状态。随着用户经历下面的"用户初始化流"小节中所描述的登录步骤，此状态会相应修改。 |
| ECommonUserPrivilege | 一种枚举，用于描述用户可在Gameplay会话中执行的不同功能和操作。 |
| ECommonUserAvailability | 描述权限或其他功能的一般可用性级别。例如，如果用户已对其账户进行身份验证，但互联网连接当前离线，则权限CanPlayOnline的可用性会设置为CurrentlyUnavailable。 |

### 用户初始化流

用户登录和验证身份是一个很复杂的过程，涉及到多个步骤，而且因平台而异，需要几秒钟才能完成执行。下面是用户初始化流中涉及的步骤顺序：

1. 要想玩游戏，就需要验证身份，确定此人为用户。在PC和移动设备等平台上，这在游戏启动之前进行，并且用户的身份会从启动程序流程发送。主机等平台支持多个本地用户登录，所以必须使用入场画面（按"开始"）来识别玩家想要用于玩游戏的物理控制器。
2. 用户需要使用平台界面登录并进行身份验证。在一些情况下，这对于首个识别的用户会自动发生，而在其他情况下，需要显示特定于平台的画面，以将物理控制器显式映射到平台用户。
3. 需要查询该用户的权限，以确定是否允许该用户玩游戏。这些权限包括特定于平台的检查，确定软件许可证是否有效，或者账户是否被禁用。
4. 达到初始化状态LoggedInLocalOnly。用户能够在本地玩游戏，并且在进行与配置文件相关的操作时，比如保存游戏，将完全不受限制。但是，该用户可能无法在线玩游戏或使用其他网络权限。要完成在线初始化，需要执行额外的步骤。
5. 用户可能需要再次登录并进行身份验证，可能要使用不同的在线服务。
6. 需要专门查询该用户的一组不同的权限，才能在线玩游戏。这可能包括检查有效订阅和年龄限制。
7. 通过第二组权限检查后，该用户已完全初始化，可在线玩游戏（LoggedInOnline），并能够创建或加入多玩家会话。
8. 在流程中的任意步骤，用户都可能会被平台强制注销。这可能需要重启游戏，因为保存游戏等配置文件操作不再可用。在许多情况下，这将需要重启整个初始化流。

通用用户子系统的主要目标是为你提供一个功能，以允许各个游戏忽略此流程中涉及的复杂细节。

### 请求用户初始化

通用用户子系统中构建了一个状态机，用于在初始化流程中跟踪用户位于哪个步骤。启动此流程的方法有很多种。

| 用户初始化方法 | 说明 |
| --- | --- |
| 为本地运行初始化 为在线运行登录（Initialize for Local Play Login for Online Play） | 这些蓝图节点可以放在控件或其他蓝图的事件图表中，为特定本地玩家和物理控制器请求仅限本地的登录或在线登录。 这是最简单的设置，将在初始化成功或失败时激活完整的执行引脚。 |
| OnUserInitializeComplete | 一种委托，可从蓝图或C++绑定，并在每次有用户完成初始化时激活。 |
| TryToInitializeUser | 一种函数，用于启动更高级的初始化流程，该流程最终将执行OnUserInitializeComplete委托。 |
| 监听登录键输入（Listen for Login Key Input） | 一种函数，用于创建初始入场画面（按"开始"）或允许在本地多玩家中添加控制器。这是通过注册临时输入处理程序来实现的，该处理程序监听特定控制器按钮或键盘键，然后使用正确的参数调用TryToInitializeUser。 |
| LoginLocalUser | 一种函数，可从C++调用，以手动管理初始化。 |

这些函数在Lyra菜单控件（**W_LyraStartup**）和C++中用于在多用户平台上显示显式入场画面，或尝试使user_0在PC和移动设备平台上的controller_0上自动登录。 这是通过调用ShouldWaitForStartInput函数来完成的，但是，如果你要创建单玩家游戏，可能需要始终显示入场画面。在线运行的显式登录在 **W_ExperieceSelectionScreen** 等可以启动在线会话的控件中请求。

> [!NOTE]
> 此在线登录没有控制器参数，因为用户应该已经完成本地初始化。

### 其他操作

通用用户子系统提供了其他有用的函数，可用于查询或更改特定用户的信息。你可以查看使用通用用户子系统的蓝图函数，或阅览CommonUserSubsystem.h文件以了解详情。

| 通用用户子系统函数 | 说明 |
| --- | --- |
| OnHandleSystemMessage | 一种委托，绑定该委托可以显示与在线函数相关的错误消息。Lyra中的UCommonGameInstance类将显示简单的错误弹框，而SendSystemMessage可用于从Gameplay代码触发此UI。 |
| OnUserPrivilegeChanged | 一种委托，绑定该委托可以处理用户的任意权限更改。这用于为失去网络连接等情况提供游戏级别的处理。 |
| GetUserInfoForLocalPlayerIndex GetUserInfoForPlatformUserIndex GetUserInfoForUniqueNetId | 查询用户相关信息的主要方法。它们将返回CommonUserInfo对象，可在其中查询其网络ID、显示昵称和权限。 |
| GetOnlineIdentity GetOnlineSubsystem | 一种较低级别的包装器函数，可由Gameplay代码或其他子系统用于访问缓存的接口数据。这些函数特定于所使用的在线接口。 |

## 通用会话子系统

**通用会话子系统** （ **UCommonSessionSubsystem** ）旨在提供简单的接口来访问在线功能，包括创建、搜索和加入在线Gameplay会话。OSS[会话接口](../../../../gameplay-systems/online-subsystems-and-services/online-subsystem/online-subsystem-session-interface/index.md)为可以与平台的原生匹配接口和EOS等跨平台系统交互的操作提供了独立于平台的包装器。 根据游戏和平台，多玩家会话可以由专用服务器或也在玩该游戏的玩家物理托管。玩家托管的（监听）服务器在必须使用某种形式的点对点（P2P）NAT遍历（如EOS）来访问的主机或用户自有PC上运行。 所有多玩家Gameplay会话的目标是，将游戏的两个实例连接在一起，这样它们可以使用[虚幻引擎联网](../../../../gameplay-systems/networking-and-multiplayer/basics-of-network-multiplayer/networking-overview/index.md)系统的所有功能。但是，在连接这两个实例之前，需要创建并查询中间结构（即大厅或会话，具体视情况而定）。

### 请求会话初始化

有多种方法可用于使用通用会话子系统初始化会话，但下表列出了提供的基本选项：

| 初始化方法 | 说明 |
| --- | --- |
| HostSession | 可通过主机请求调用，该请求描述了将加载的特定Gameplay模式和贴图。这可用于创建不使用在线后端注册的单玩家会话，这样你的UI就不需要了解它们之间的差异。创建会话之后，指定的贴图将加载，Gameplay将开始。 |
| FindSessions | 可以调用该方法以请求在线系统提供一系列与搜索请求匹配的可加入会话。它接受一个Request（ `UCommonSession_SearchSessionRequest` ）和一个SearchingPlayer（ `APlayerController` ）参数，用于查找能够满足所提供参数的公开匹配游戏。 搜索完成时，将调用该Request对象上实现的OnSearchFinished委托，并且可以使用搜索结果对象（填写在请求对象上）加入会话。 |
| JoinSession | 接受搜索结果对象，并尝试连接和加入该多玩家会话。如果成功，游戏将连接到该对等或专用服务器，并尝试以网络客户端身份加入游戏。 |
| QuickPlaySession | 开始流程以查找匹配主机参数的所有现有公开会话，并在可能的情况下加入这些会话。此方法合并了其他三个初始化函数，并使用主机请求来调用。如果无法加入会话，则将启动新会话。 CommonSessionSubsystem提供了基本实现，但游戏可以根据需要在特定于游戏的子类中覆盖与快速游戏相关的函数。 |

Lyra与多个控件蓝图中的通用会话子系统交互：

| 控件蓝图 | 说明 |
| --- | --- |
| W_ExperienceSelectionScreen | 处理快速游戏以及选择托管或搜索会话。 |
| W_SessionBrowserScreen | 处理搜索和加入现有会话。 |
| W_HostSessionScreen | 允许指定托管规则和创建新的本地或多玩家会话。 |

这些控件依赖位于 `c:Lyra/Source/LyraGame/GameModes` 目录中的LyraUserFacingExperienceDefinition类中的资产。此类定义了可以在游戏中使用的特定贴图和Gameplay模式的类型。Lyra源代码还包括一些检查，用于确保在玩家离开游戏或登录失败时能够在内存中恰当地清理会话。

CommonSession子系统和Lyra可用于搜索和创建使用EOS[大厅接口](https://dev.epicgames.com/docs/services/en-US/GameServices/Lobbies/index.html)的P2P托管会话（如上所述启用支持的情况下）。它适用于使用[Null子系统](https://dev.epicgames.com/documentation/404)在[编辑器中测试多玩家](../../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/play-in-editor-multiplayer-options/index.md)时创建的本地会话。 要对插件的初始版本中的其他在线后端启用完全支持，你可能需要更改传递给FOnlineSessionSearch等内部会话对象的某些选项。

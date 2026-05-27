---
title: "在线子系统EOS插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-eos-plugin-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线子系统", "在线子系统EOS插件"]
---

# 在线子系统EOS插件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线子系统 / 在线子系统EOS插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-eos-plugin-in-unreal-engine

> [!NOTE]
> 谷歌已通知开发者WebRTC版本（早于M102）存在漏洞。 如需了解其影响、解决方法和更新，请参阅[此处](https://eoshelp.epicgames.com/s/news/eos-news-article-MCVDBTZSVM7VAJHF4ZGJVXZM52I4?language=en_US)。

**Epic在线服务（Epic Online Services，EOS）**是一套与引擎无关的系统，提供了一系列跨平台在线功能，包括：

- 以玩家为中心的功能，例如：

  - 成就
  - 排行榜
- 商业功能，例如：

  - 游戏内购买
- 社交功能，例如：

  - 语音通信
  - 好友列表

你可以通过在线子系统Epic在线服务（OSS EOS）插件在虚幻引擎项目中使用EOS。 **在线子系统Epic在线服务（Epic Online Services）**插件可帮助你与游戏中的Epic在线服务交互，而不必编写用来直接与EOS SDK交互的代码。 要使用此功能，你必须在**EOS开发者门户（EOS Developer Portal）**注册并配置你的产品，然后启用并配置一些插件来通过OSS接口公开EOS功能。

> [!NOTE]
> 如需详细了解Epic在线服务，包括有关注册和配置产品的信息，请参阅[Epic在线服务开发者文档](https://dev.epicgames.com/docs/services/index.html)。

## EOS插件概述

OSS EOS插件以**在线子系统（Online Subsystem，OSS）**插件为基础而编译。 [在线子系统插件](../index.md)是一款通用插件，提供了访问各种在线服务的公共接口。 OSS EOS插件实现了通过Epic在线服务提供的特定功能，并将与EOS SDK的通信集成到插件中，从而扩展了OSS插件。 本页面介绍了OSS EOS插件的以下功能：

- [产品注册](index.md)
- [启用插件](index.md)
- [配置](index.md)
- [登录](index.md#login)
- [支持的接口](index.md)

你也可以选择使用**OSS EOS Plus**插件扩展OSS EOS插件。 EOS Plus表示"EOS + 基础平台"，将EOS与另一个平台（例如Steam、主机平台等）相结合。 将EOS与另一个平台相结合提供了更多功能，例如自动会话镜像。 你可以在使用或不使用[Epic账号服务（EAS）](https://dev.epicgames.com/docs/epic-account-services)的情况下使用EOS Plus。

### 何时使用EOS Plus

如果你在Epic Games商城发行游戏，则需要使用OSS EOS插件；此外，无需使用EOS Plus。 如果你在另一个平台上发行游戏，请使用OSS EOS Plus插件以及OSS EOS插件。 本指南可能存在例外情况。 继续阅读本页面，确定适合你的项目的最佳插件组合。

> [!NOTE]
> Online Subsystem EOS Plus是一种临时解决方案，用于在EOS SDK中不存在某些平台镜像功能时实现特定的平台镜像功能。 随着EOS SDK原生支持的推出，EOS Plus功能将被替换。 EOS Plus是一项测试功能，只覆盖有限的功能范围。

### 如何使用OSS EOS

[Epic开发者社区](https://dev.epicgames.com/community/unreal-engine)上的[OSS EOS插件课程](https://dev.epicgames.com/community/learning/courses/1px/unreal-engine-the-eos-online-subsystem-oss-plugin/Lnjn/unreal-engine-introduction)可指导你完成在虚幻引擎项目中使用OSS EOS的过程。

## 设置

### 使用Epic在线服务注册产品

[Epic开发者资源文档](https://dev.epicgames.com/docs)为你提供了Epic游戏商城（EGS）、Epic在线服务、儿童网络服务（KWS）及相关工具的资源。 要利用OSS EOS插件，你必须首先使用Epic在线服务注册产品。 要使用EOS注册产品，请找到[Epic开发者门户](https://dev.epicgames.com/portal/)并执行[入门](https://dev.epicgames.com/docs/services/GameServices/QuickStart/index.html)步骤。 要特别指出的是，本指南概括了[入门步骤的第1步](https://dev.epicgames.com/docs/epic-online-services/eos-get-started/services-quick-start#step-1---set-up-an-epic-games-account-and-organization)中的产品注册过程。 稍后需要使用注册产品时提供的信息在虚幻引擎中配置OSS EOS插件。

虚幻引擎是使用EOS SDK的副本发行的，所以如果你想使用虚幻引擎随附的EOS SDK版本，不需要单独下载EOS SDK。 要使用不同版本的EOS SDK，请按照[入门步骤的第2步](https://dev.epicgames.com/docs/epic-online-services/eos-get-started/services-quick-start#step-2---download-the-eos-sdk)中的说明操作，下载所需的EOS SDK版本。 下载所需版本的EOS SDK后，按照我们的[升级EOS SDK](../../epic-online-services/upgrading-the-eos-sdk/index.md)文档上的说明操作，详细了解如何升级虚幻引擎使用的EOS SDK。

> [!TIP]
> 如果你要升级EOS SDK，推荐查阅[EOS SDK版本说明](https://dev.epicgames.com/docs/epic-online-services/release-notes)，了解升级所需的必要更新。

### 启用OSS EOS插件

要在项目中使用EOS，你必须在虚幻引擎中启用OSS EOS插件。 要启用OSS EOS插件，请执行以下步骤：

1. 找到**编辑（Edit）> 插件（Plugins）**。 这会打开**插件浏览器**，你可以在其中搜索要启用的插件。
2. 在**插件浏览器**中，找到并启用**在线子系统EOS（Online Subsystem EOS）**插件。

在线子系统EOS实现了Epic在线服务的在线子系统插件。 当你启用OSS EOS插件时，会默认启用以下额外的插件：

- **EOS Plus**

  - 将EOS与另一个平台相结合。
- **EOS共享（EOS Shared）**

  - 负责初始化和关闭EOS SDK。
  - 默认作为OSS EOS的依赖项启用。
- **EOS语音聊天（EOS Voice Chat）**

  - 通过EOS支持语音聊天。

启用所需插件后，你需要配置它们以在项目中使用。 以下某些配置步骤需要与产品相关的设置，或者需要向EOS注册产品之后接收的标识符。 这些内容在你的[Epic开发者门户](https://dev.epicgames.com/portal/)中可以取得。

### 配置OSS EOS插件

要继续，请确保你已经执行以下操作：

1. [使用Epic在线服务注册产品](index.md)。
2. [启用OSS EOS插件](index.md)。

要配置OSS EOS插件，请执行以下步骤：

1. 转到工具栏，点击**编辑（Edit）> 项目设置（Project Settings）**。
2. 找到**插件（Plugins）> 在线子系统EOS（Online Subsystem EOS）**。

![在线子系统EOS插件](../../../../../assets/images/ed/ed138599e64738591093c26b0a6266d861b21e64622f316b1ad025231410637b.jpg)

编辑OSS EOS插件

*点击查看大图。*

#### EOS设置

这些设置与EOS的特定于平台的配置有关。 如需更多信息，请参阅[EOS API参考](https://dev.epicgames.com/docs/services/API/index.html)页面中关于[EOS_Platform_Options](https://dev.epicgames.com/docs/en-US/api-ref/structs/eos-platform-options)数据结构的部分。 下表介绍了每个EOS设置：

| 设置 | 说明 |
| --- | --- |
| 缓存目录 | 用于存储临时EOS数据的目录。 Windows上的默认位置是`C:/Users/<USERNAME>/Documents/CacheDir`。 |
| 默认构件名称 | 如果没有通过命令行参数传递构件，会使用此构件名称。 如果你不通过命令行传递构件名称，请确保这与下面定义的**构件名称（Artifact Name）**匹配。 |
| 更新函数预算（以毫秒为单位） | 此设置使[EOS_Platform_Tick](https://dev.epicgames.com/docs/en-US/api-ref/functions/eos-platform-tick)返回，从而防止EOS操作卡住游戏。 如需更多信息，请参阅关于[EOS_Platform_Create](https://dev.epicgames.com/docs/en-US/api-ref/functions/eos-platform-create)的Epic在线服务文档。 |
| 启用覆层 | 用于启用或禁用覆层。 一些覆层可能特定于平台，例如电子商务覆层，它仅对于Epic Games商城上的作品发行有效。 |
| 启用社交覆层 | 社交覆层显示有关好友、成就和额外身份验证步骤的信息。 你可以单独禁用此覆层，而将其他覆层保持启用。 如果关闭了**启用覆层（Enable Overlay）**，此设置将不起作用。 |
| 启用编辑器覆层 | 用于在虚幻编辑器中时启用或禁用覆层。 |
| 游戏存储标签 | 在作品数据存储中查询多个文件时使用。 如需更多信息，请参阅关于在[作品储存接口](https://dev.epicgames.com/docs/game-services/title-storage)中[按标签查询多个文件](https://dev.epicgames.com/docs/game-services/title-storage#querying-multiple-files-by-tag)的Epic在线服务文档。 |
| 作品存储读取块长度 | 设置在[EOS_TitleStorage_OnReadFileDataCallback](https://dev.epicgames.com/docs/en-US/api-ref/callbacks/eos-title-storage-on-read-file-data-callback)的单个回调中可读取的最大数据量（字节）。 如需更多信息，请参阅关于在[作品存储接口](https://dev.epicgames.com/docs/game-services/title-storage)中[访问文件](https://dev.epicgames.com/docs/game-services/title-storage#accessing-files)的Epic在线服务文档。 |
| 构件 | Epic Games商城支持将多个构件用于单个产品。 例如，你的产品可以将单独的内部构件用于开发、测试以及客户使用的发布版本。 此数组包含每个具名构件的设置。 数组中必须有至少一个构件，并且**默认构件名称（Default Artifact Name）**的值必须匹配某个数组元素的名称。 请参阅下文的[构件设置](index.md)小节，详细了解这些设置。 |

##### 构件设置

构件设置包括你在EOS开发人员门户中注册的产品的设置。 你在此处配置的设置应该匹配你在EOS开发人员门户中注册的产品的设置。 你可以在EOS开发者门户上找到[产品的设置](https://dev.epicgames.com/portal/epic-games/products/your_product/settings)。

要编辑**构件设置（Artifact Settings）**，请执行以下步骤：

1. 点击**EOS设置（EOS Settings）**分段中**构件（Artifacts）**旁的**添加元素（Add Element）**按钮。 这会在**EOS设置的构件**数组中创建一个新元素。
2. 要自定义这个新构件的设置，请点击新创建的数组元素旁边的箭头。 如果这是数组中的第一个元素，其名称为**Index[0]**。

下表说明了可用的构件设置：

| 设置 | 说明 |
| --- | --- |
| 构件名称 | 如果你要在Epic游戏商城启动，则名称应该匹配你在[开发者门户](https://dev.epicgames.com/portal)的商城设置中所设的构件ID。 如果你不在Epic Games商城启动，这可以是任意字符串。 它还应该匹配通过`-epicapp`命令行参数或默认构件名称所传递的构件名称。 |
| 客户端ID | 产品的客户端ID。 此ID开头的3个字符是`xyz`。 |
| 客户端密钥 | 用于验证你的**客户端ID（Client ID）**的客户端密钥。 |
| 产品ID（Product ID） | EOS SDK使用此ID识别你的产品。 |
| 沙盒ID | 构件属于带有此ID值的沙盒。如果你不在Epic Games商城发布，你的产品只有一个沙盒。 如果你要使用多个沙盒，你可以使用重复的`ArtifactName`（`-epicapp`命令行参数），但不同的`SandboxId`（`-epicsandboxid`命令行参数）添加多行。 |
| 部署ID | 你要作为目标的部署ID。 每个构件的部署ID是不同的。 例如，你有`MyGameStaging`和 `MyGameRelease`构件，则它们将拥有各自的部署ID。 默认情况下，每个沙盒有一个部署。 |
| 客户端加密密钥 | 64字节的十六进制字符串，用于加密上传到EOS服务的数据。 不同于其他设置，EOS不管理此加密密钥，该密钥不会存储在你的产品设置中。 密钥对于你的游戏是唯一的，Epic Games并不知道密钥，以便保护用户的数据隐私。 它用于加密玩家和作品数据存储的数据。如果你*不*使用玩家或作品数据存储，可以使用以下值作为默认加密密钥（64个1）：`1111111111111111111111111111111111111111111111111111111111111111`。 如果你*要*使用玩家或作品数据存储，请自行选择不同于此默认密钥的密钥并保密。 |

#### EOS Plus设置

要使用此插件，请首先在开发者门户中为你想支持的每个[平台](https://dev.epicgames.com/docs/services/Platforms/index.html)注册并配置[你的产品](https://dev.epicgames.com/portal/epic-games/products/your_product)。 特定于平台的EOS SDK版本包含关于使用每个版本支持的平台的功能的详细说明。

在使用EOS Plus插件之前，你必须配置EOS Plus登录设置和跨平台游戏设置。

##### EOS Plus登录设置

下表说明了EOS Plus登录设置：

| 设置 | 说明 |
| --- | --- |
| 将Epic账号用于EOS登录（需要账号关联） | 如果启用此选项，OSS EOS插件使用特定于平台的身份验证令牌自动将用户登录到其Epic账号。 |
| 使用EOS Connect API创建和关联产品用户ID（PUID），并使用EOS游戏服务 | 如果启用此选项，使用EOS Connect API关联账号进行跨平台游戏。 |

##### 跨平台游戏设置

下表说明了跨平台游戏设置：

| 设置 | 说明 |
| --- | --- |
| 将统计数据镜像到EOS | 如果启用此选项，EOS Plus会将所有[统计数据](https://dev.epicgames.com/docs/services/API/Interfaces/Stats/index.html)信息的副本发送给OSS EOS插件。 |
| 将成就镜像到EOS | 如果启用此选项，EOS Plus会将所有[成就](https://dev.epicgames.com/docs/services/API/Interfaces/Achievements/index.html)数据的副本发送给OSS EOS插件。 |
| 使用跨平台游戏会话 | 需要此设置才能玩跨平台网络游戏。 它还会使EOS[会话界面](https://dev.epicgames.com/docs/services/API/Interfaces/Sessions/index.html)成为主会话界面。 |
| 将在线状态镜像到EAS | 此选项将决定EOS Plus插件是否也会将[在线状态](https://dev.epicgames.com/docs/services/API/Interfaces/Presence/index.html)数据发送给OSS EOS插件。 在线状态数据仅在使用Epic账号服务时可用。 |

#### EOS插件的引擎配置

在开发人员门户上设置了你的产品并配置了插件之后，你就需要配置一些设置。 你可以在引擎配置层级中配置这些插件，例如`DefaultEngine.ini`。

##### OSS EOS配置设置

请在项目的`DefaultEngine.ini`文件中添加以下配置设置：

1. 检查是否在项目中启用了在线子系统EOS插件。

   C++

   ```
   [OnlineSubsystemEOS]         bEnabled=true
   ```
2. 将EOS设置为项目的在线服务的默认平台。

   C++

   ```
   [OnlineSubsystem]         DefaultPlatformService=EOS
   ```
3. 指定网络驱动程序。

   C++

   ```
   [/Script/Engine.Engine]         !NetDriverDefinitions=ClearArray         +NetDriverDefinitions=(DefName="GameNetDriver",DriverClassName="/Script/SocketSubsystemEOS.NetDriverEOSBase",DriverClassNameFallback="/Script/OnlineSubsystemUtils.IpNetDriver")         +NetDriverDefinitions=(DefName="DemoNetDriver",DriverClassName="/Script/Engine.DemoNetDriver",DriverClassNameFallback="/Script/Engine.DemoNetDriver")
   ```
4. 将EOS的点对点套接字功能用于玩家托管的比赛。 此设置是可选的。

   C++

   ```
   [/Script/SocketSubsystemEOS.NetDriverEOSBase]         bIsUsingP2PSockets=true
   ```

下面是上面介绍的针对OSS EOS的所有配置设置：

C++

```
[OnlineSubsystemEOS]
	bEnabled=true

	[OnlineSubsystem]
	DefaultPlatformService=EOS

	[/Script/Engine.Engine]
	!NetDriverDefinitions=ClearArray
	+NetDriverDefinitions=(DefName="GameNetDriver",DriverClassName="/Script/SocketSubsystemEOS.NetDriverEOSBase",DriverClassNameFallback="/Script/OnlineSubsystemUtils.IpNetDriver")
	+NetDriverDefinitions=(DefName="DemoNetDriver",DriverClassName="/Script/Engine.DemoNetDriver",DriverClassNameFallback="/Script/Engine.DemoNetDriver")
```

###### 从Epic Games启动器启动作品

如果你要从Epic Games启动器启动作品，需要在Epic Games商城（EGS）启动的所有Epic应用和Epic沙盒对的引擎配置文件层级中添加配置条目。 确保项目设置或引擎配置中的**默认构件名称（Default Artifact Name）**和**构件名称（Artifact Name）**匹配Epic在线服务开发者门户中的构件名称。

在EGS上发售作品时，将忽略默认构件名称。 EGS会始终改为传递它所使用的`-epicapp`命令行参数。 在不传递`-epicapp`的其他商城上发售时，默认构件名称会很实用。

##### EOS Plus配置设置

如果你想配置项目以在EOS和其他在线平台之间实现跨平台游戏，请将以下配置设置添加到项目的`DefaultEngine.ini`文件中：

1. 检查是否在项目中启用了在线子系统EOS Plus插件。

   - 前面说过，EOS Plus插件让你可以将EOS与其他的在线服务一起使用。

     C++

     ```
     [OnlineSubsystemEOSPlus]          bEnabled=true
     ```
2. 将你的默认平台在线服务更改为EOS Plus。

   - 这会向引擎表明，你要将EOS与其他的平台服务一起使用。 此外，添加你想使用的额外原生平台在线服务。 在本例中，它设置为Steam，但可以是任何在线服务，包括主机在线服务。

     C++

     ```
     [OnlineSubsystem]          DefaultPlatformService=EOSPlus          ; Add your additional platform online services below          NativePlatformService=Steam
     ```
3. 说明哪些网络ID类型与默认OSS兼容。

   - 这只需要在EOS/EOS Plus是默认OSS时设置。

     C++

     ```
     [/Script/OnlineSubsystemUtils.OnlineEngineInterfaceImpl]          +CompatibleUniqueNetIdTypes=EOS          +CompatibleUniqueNetIdTypes=EOSPlus
     ```
4. 支持EOS与EOS Plus客户端之间的通信。

   - 例如，考虑这样一种情况：有一个EOS Plus玩家使用了另一个在线平台（例如Steam）登录，托管着一个EOS会话，然后一个EOS（非EOS Plus）客户端加入了前者的EOS会话。 纯EOS客户端需要此映射，以便EOS Plus网络ID能够正确路由到EOS，并反序列化为EOS网络ID。 此`MappedUniqueNetIdTypes`配置将被添加到与上一步所述配置相同的配置分段中。

     C++

     ```
     [/Script/OnlineSubsystemUtils.OnlineEngineInterfaceImpl]         MappedUniqueNetIdTypes=(("EOSPlus","EOS"))
     ```

下面是上面介绍的针对EOS Plus的所有配置设置：

C++

```
[OnlineSubsystemEOSPlus]
	bEnabled=true

	[OnlineSubsystem]
	DefaultPlatformService=EOSPlus
	NativePlatformService=Steam

	[/Script/OnlineSubsystemUtils.OnlineEngineInterfaceImpl]
	+CompatibleUniqueNetIdTypes=EOS
	+CompatibleUniqueNetIdTypes=EOSPlus
```

## OSS EOS如何查找构件

要在启动时选择为OSS EOS使用特定构建，你可以通过虚幻引擎命令行指定一系列设置，用于查找引擎配置中指定的构建，或默认的特定构建。 从虚幻引擎5.5开始，无论命令行中传递的沙盒ID和部署ID（通过`-epicsandboxid`和`-epicdeploymentid`参数传递）是什么，它们都会始终被使用。 之前，这些值只被用于在构件配置数组中查找匹配的条目。 无论在配置数组中找到什么构件条目，始终使用命令行沙盒和部署ID。

此行为可大致分为以下步骤：

1. 按照优先级降序，将`ArtifactName`定义为以下项目的值：

   - `-EOSArtifactNameOverride=<...>`
   - `-EpicApp=<...>`
   - 引擎所配置的`DefaultArtifactName`
2. 按照优先级降序，将`SandboxId`定义为以下项目的值：

   - `-EpicSandboxIdOverride=<...>`
   - `-EpicSandboxId=<...>`
   - 未指定
3. 按照优先级降序，将`DeploymentId`定义为以下项目的值：

   - `-EpicDeploymentIdOverride=<...>`
   - `-EpicDeploymentId=<...>`
   - 未指定
4. 如果已指定了`SandboxId`和`DeploymentId`，则搜索匹配全部`ArtifactName`、`SandboxId`和`DeploymentId`的构件。
5. 如果第4步失败或无法运行，但已指定了`SandboxId`，则搜索匹配`ArtifactName`和`SandboxId`的构件。
6. 如果第5步失败或无法运行，则搜索匹配`ArtifactName`的构件。
7. 如果第6步失败，则搜索`ArtifactName`为空的构件。
8. 如果第7步失败，则报告错误，未查找到构件。
9. 找到构件后：

   - 按照优先级降序，为`SandboxId`使用以下值：

     - 如已指定，则使用第2步中的值。
     - 使用第4-7步中查找到的构件条目的值。
   - 按照优先级降序，为`DeploymentId`使用以下值：

     - 如已指定，则使用第3步中的值。
     - 使用第4-7步中查找到的构件条目的值。

你可以在配置构件数组中为特定的`ArtifactName`、`SandboxId`和`DeploymentId`组合提供特定的构件条目。 如果你希望为每种组合使用不同的`ClientId`和/或`EncryptionKey`，这会非常有用。 另一方面，如果你想要设置一个始终使用的`ClientId`，那么你可以在配置构件数组中提供一个`ArtifactName`为空的构件条目。 这会强制上述行为始终使用构件名称为空的构件。

## 登录

有两种方法可在在线身份接口中开始登录过程：

- **自动登录（Auto Login）**：需要你传递本地用户编号。
- **登录（Login）**：需要你使用`FOnlineAccountCredentials`对象。

下一个小节介绍了如何在OSS EOS中使用自动登录或登录来使用户登录。

### 使用OSS EOS登录

除了提供有效的本地用户编号之外，此登录方法还需要你传递`FOnlineAccountCredentials`对象。 此类有三个字段：

- 类型
- ID
- 令牌

#### 登录方法

这三个字段表示OSS EOS应该使用哪种身份验证方法，具体取决于其值。 以下小节提供了示例，说明如何设置可用的每种不同类型的身份验证：

- 账号门户
- 开发人员
- 交换代码

##### 账号门户

- Type：`AccountPortal`
- ID：
- Token：

账号门户是最通用的登录方法，因为它不需要**EOS开发者身份验证工具（Dev Auth Tool）**，也不需要让你的应用程序从Epic Games启动器打开。

利用此方法，如果你使用的是EOS SDK版本1.15或更高版本，发起登录调用时将显示游戏覆层UI。 如果未启用游戏覆层，将打开浏览器窗口。 用户需要在系统提示时输入Epic账号信息。 如果用户已经登录Epic Games，用户必须接受相关产品的访问范围。

由于凭证由用户在游戏覆层UI或浏览器中提供，你不需要提供ID或令牌。

##### 开发人员

- Type：`开发者`
- ID：`localhost:<PORT>`

  - `PORT`是开发者身份验证工具中指定的端口
- Token：`<CREDENTIALS_NAME>`

  - `CREDENTIALS_NAME`在开发者身份验证工具中指定

"开发人员"是桌面平台上使用OSS EOS开发的推荐方法。 此方法需要运行Dev Auth工具。 请参阅Epic在线服务站点上的以下文档，详细了解[开发者身份验证工具](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/DeveloperAuthenticationTool/index.html)。

设置开发者身份验证工具后，记住你使用的端口和凭证名称，因为你需要用它们来填写`FOnlineAccountCredentials`对象的`ID`和`Token`字段，如上所述。 此登录方法会在发起登录调用时打开，并且系统会要求用户输入Epic Games账号信息。 如果用户已经登录Epic Games，用户必须接受相关产品的访问范围。 此步骤仅在用户首次登录时执行。

##### 交换代码

- Type：`ExchangeCode`
- ID：
- Token：`<EXCHANGE_CODE>`

  - `<EXCHANGE_CODE>`由Epic Games启动器提供

你应该仅在你的应用程序从Epic Games启动器启动时才使用"交换代码"方法，因为它需要启动器提供的交换代码。 此方法不需要运行Dev Auth工具，你应该对游戏的发布版本使用此方法。

由于Epic Games启动器会提供交换代码令牌，你不需要提供ID或令牌。

#### 登录成功

如果上述任一方法成功完成，登录过程会注册所有必要的EOS通知服务（登录状态、好友、在线状态更新和身份验证刷新）并触发以下注册的委托来结束：

- `OnLoginComplete`：各种参数，包括登录是否成功，以及新通过身份验证的用户的`UniqueNetId`。
- `OnLoginStatusChanged`：各种参数，对应之前和当前的登录状态以及新通过身份验证的用户`的UniqueNetId`。

### 使用OSS EOS自动登录

要对在线子系统EOS使用自动登录，你必须在启动时将额外的命令行参数传递到游戏的可执行文件。 这些参数对应于原本传递给登录方法的`FOnlineAccountCredentials`对象中的三个字段。

上面登录中的参数对应如下所示的命令行参数：

| FOnlineAccountCredentials变量 | 命令行参数 |
| --- | --- |
| `Type` | `AUTH_TYPE` |
| `Id` | `AUTH_LOGIN` |
| `Token` | `AUTH_PASSWORD` |

#### 登录方法

此小节包含所有三种登录方法所需的参数的示例，如上一小节所述。

##### 账号门户

C++

```
-AUTH_TYPE="accountportal"
```

##### 开发人员

C++

```
-AUTH_TYPE="developer" -AUTH_LOGIN="localhost:<PORT>" -AUTH_PASSWORD="<NAME_IN_DEV_AUTH_TOOL>"
```

此命令中的参数如下：

- `<PORT>`是你在开发者身份验证工具中配置的端口。
- `<NAME_IN_DEV_AUTH_TOOL>`是你在Dev Auth Tool中选择的凭证名称。

##### 交换代码

C++

```
-AUTH_TYPE="exchangecode" -AUTH_PASSWORD="<EXCHANGE_CODE_FROM_LAUNCHER>"
```

此命令中的参数如下：

- `<EXCHANGE_CODE_FROM_LAUNCHER>`是Epic Games启动器中的交换代码。

### 使用外部账号凭证的登录流程

此小节介绍使用外部账号的OSS EOS登录流程。 你必须启用EOS Plus才能使用外部账号登录。

如果Epic账号服务和连接接口`（EOS_Connect`）均已启用，将使用非EOS平台（例如Steam）的外部账号凭证调用`EOS_Auth_Login`。 如果此登录失败并返回用户无效的错误（`EOS_InvalidUser`），将调用`EOS_Auth_LinkAccount`。 此调用会提示用户通过Web浏览器或用户界面覆层登录Epic Games账号。 此登录将用户的Epic Games账号关联到外部非EOS账号。

> [!NOTE]
> 请参阅下文的[已知问题](index.md)，详细了解账号的关联过程。

如果未启用Epic账号服务，但启用了连接接口，将使用外部账号凭证调用`EOS_Connect_Login`。

身份验证接口`（EOS_Auth）`和连接接口都需要身份提供商配置。 要使用你预期的外部平台，请将其添加到EOS项目开发人员门户中的身份提供程序列表。 如果你在身份提供程序中正确配置了你的平台，EOS身份验证应该会成功完成并解锁所有EOS游戏功能的访问权限。 如需更多信息，请参阅关于[身份提供商管理](https://dev.epicgames.com/docs/dev-portal/identity-provider-management)的Epic开发者资源文档。

> [!NOTE]
> 必须启用EOS Plus，才能使用外部账号登录。

#### 使用Epic账号服务

如果启用此设置，登录过程会像同时启用了"使用跨平台用户ID"那样继续。 外部身份验证令牌会被添加到登录方法所需的一组凭证中，而EOS会尝试调用`EOS_Auth_Login`方法来验证身份。

## 接口

此小节提供了有关在线子系统EOS插件中实现的接口的更多信息。 如需详细了解其中每个接口，请参阅在线子系统文档。 OSS EOS插件支持以下EOS SDK接口：

### 支持的接口

| OSS EOS接口 | EOS SDK接口 | 说明 |
| --- | --- | --- |
| [成就](../online-subsystem-achievements-interface/index.md) | [成就](https://dev.epicgames.com/docs/game-services/achievements) | 解锁并检查用户成就的状态。 |
| [商城](../online-subsystem-store-interface/index.md)、[购买](../online-subsystem-purchase-interface/index.md) | [Ecom](https://dev.epicgames.com/docs/epic-games-store/services/ecom/ecom-overview) | 购买物品并验证这些物品的所有权。 |
| [外部UI](../online-subsystem-external-ui-interface/index.md) | [UI](https://dev.epicgames.com/docs/epic-account-services/eosui-interface) | 显示用户界面覆层。 |
| [身份](../online-subsystem-identity-interface/index.md) | [身份验证](https://dev.epicgames.com/docs/epic-account-services/auth/auth-interface) | 验证用户账号，包括登录和注销。 |
| [排行榜](../online-subsystem-leaderboard-interface/index.md) | [排行榜](https://dev.epicgames.com/docs/game-services/leaderboards) | 创建和检索排行榜。 |
| [在线状态](../online-subsystem-presence-interface/index.md) | [在线状态](https://dev.epicgames.com/docs/epic-account-services/eos-presence-interface) | 向好友告知当前活动。 |
| [会话](../online-subsystem-session-interface/index.md) | [会话](https://dev.epicgames.com/docs/game-services/sessions) | 管理基于会话的匹配。 |
| [好友](../online-subsystem-friends-interface/index.md) | [好友](https://dev.epicgames.com/docs/epic-account-services/eos-friends-interface) | 在好友列表中添加或删除玩家。 检索好友列表。 |
| 统计数据 | [统计数据](https://dev.epicgames.com/docs/game-services/eos-stats-interface) | 获取和查询用户统计数据。 |
| 作品文件 | [作品存储](https://dev.epicgames.com/docs/game-services/title-storage) | 从云端下载加密的作品数据。 |
| [用户云](../online-subsystem-user-interface/index.md) | [用户信息](https://dev.epicgames.com/docs/epic-account-services/eos-user-info-interface) | 访问用户显示信息。 |

#### 会话

##### Bucket ID

在OSS EOS会话中，`BucketId`是特定于游戏的顶层筛选信息，用于搜索会话。 如需详细了解会话`BucketId`，请参阅关于[会话](https://dev.epicgames.com/docs/game-services/sessions)的EOS文档。

`BucketId`可以使用添加到`FOnlineSessionSettings::Settings`的自定义特性设置为你的项目需要的内容。 为此，将以下内容添加到你的项目代码：

C++

```
SessionSettings.Settings.Add(OSSEOS_BUCKET_ID_ATTRIBUTE_KEY, FOnlineSessionSetting(FString(TEXT("BUCKET_ID_PLACEHOLDER")), EOnlineDataAdvertisementType::ViaOnlineService));
```

其中：

- `BUCKET_ID_PLACEHOLDER`是你要使用的Bucket ID。

此自定义`BucketId`也需要以类似的方式被添加到会话搜索参数中。

#### 统计数据

##### 统计数据名称

OSS EOS会将所有统计数据名称转换为大写，然后再将其传递给EOS。 在EOS开发人员门户中配置你的项目时，务必将统计数据名称配置为大写名称，确保兼容OSS EOS。

## 已知问题

### 账号关联

目前，登录过程中的账号关联仅在Steam平台中可用，尝试登录其他平台会导致日志中显示以下身份验证错误：

C++

```
LogEOSSDK: Warning: LogEOS: Error response received from backend. ServiceName=[OAuth], OperationName=[TokenGrant], Url=[<Redacted>], HttpStatus=[400], ErrorCode=[errors.com.epicgames.account.oauth.authorization_pending], NumericErrorCode=[1012], ErrorMessage=[The authorization server request is still pending as the end user has yet to visit and enter the verification code.], CorrId=[...]
```

在未来的版本中，此功能将在其他平台可用。 同时，你也可以通过Epic Games[账号设置](https://www.epicgames.com/account/connections)"连接（Connections）"分段中的"账号（Accounts）"选项卡手动完成账号关联。

关联过程中使用的Epic账号需要接受应用程序访问范围（如[使用OSS EOS登录](index.md)小节所述），否则日志中还将显示如下错误：

C++

```
LogEOSSDK: Warning: LogEOS: Error response received from backend. ServiceName=[OAuth], OperationName=[TokenGrant], Url=[<Redacted>], HttpStatus=[400], ErrorCode=[errors.com.epicgames.oauth.scope_consent_required], NumericErrorCode=[58005], ErrorMessage=[The user has not consented to required scopes.], CorrId=[...]
```

关联账号后，会接受访问范围，并且如果EOS身份验证配置正确无误，登录将成功完成，应用程序也能够使用EAS的所有其他功能。

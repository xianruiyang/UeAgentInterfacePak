# 派生数据缓存(DDC)

---
title: "派生数据缓存(DDC)"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-derived-data-cache-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "派生数据缓存(DDC)"]
---

# 派生数据缓存(DDC)

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 派生数据缓存(DDC)

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-derived-data-cache-in-unreal-engine

许多 **虚幻引擎 (UE)** 资产都需要额外的 **派生数据** 才能使用。

比如，假设你在UE渲染材质之前创建了一个包含着色器的[材质](../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)。在这种情况下，必须为运行虚幻编辑器的平台编译着色器。

由于派生数据很大，并且UE可能需要在开发过程中重新生成它。因此UE不会将其检入源代码控制，而是保留在 **派生数据缓存（DDC）** 中。

本文档涵盖：

- DDC架构方式概述。
- UE支持的DDC类型。
- 关于如何配置、使用、分发DDC的说明。
- 以下项目的常见问题：

  - DDC常规用途。
  - 从文件系统切换到虚幻Zen存储(ZenServer)。

## DDC的架构方式

根据项目和系统的配置，一个层级中可以存在多个DDC缓存（按照从快到慢的顺序）。在评估派生数据时，你的系统将执行以下操作来确定访问速度：

1. 当某个资产需要派生数据时，你的系统将首先检查最快的缓存，然后检查次快的缓存，依此类推，直至找到数据为止。
2. 找到数据后，你的系统会将其复制到最快的本地缓存中，以便下次更快地访问。
3. 如果系统并未找到数据，则将为该资产生成新的派生数据，然后将其异步复制到缓存，供你和你的团队将来使用。

存储在DDC中的内容允许使用后即丢弃，因为UE可以随时使用保存在 `.uasset` 文件中的数据重新生成该内容。通过将这些派生格式存储在外部，我们可以轻松地添加或更改UE使用的格式，而无需修改源资产文件。

## DDC类型

UE有多种存储类型可供DDC使用，你可以将每种存储类型用于不同的DDC位置。下方列出了持久存储类型：

- Zen存储服务器（默认）

  - 读写功能。
  - 适用于本地磁盘和LAN使用。
  - 将数据存储在本地计算机或私有局域网络上托管的

    Zen存储服务器

    服务器，以处理磁盘持久性。这是一种未使用身份验证的服务，应该仅对本地连接或可信网络/VPN使用。虚幻编辑器通过HTTP向服务器发出异步请求。服务器管理所有未使用数据的清理和垃圾回收工作。更多详情请参阅

    作为共享DDC的Zen存储服务器

    。
- PAK

  - 只读。
  - 适用于本地磁盘和LAN使用。
  - 将数据存储为磁盘上的单个存档文件，通常使用

    .ddp

    扩展名命名。UE期望存档为只读。一个独立于虚幻编辑器的周期性进程将写入存档的内容。
- S3

  - 只读。
  - 适合云使用。
  - 将数据存储为从云托管的

    简单存储服务(S3)

    桶获取的单个存档文件。一个独立于虚幻编辑器的周期性进程将写入存档的内容。

> [!NOTE]
> 不再推荐用户使用S3 DDC存储类型，而应迁移到虚幻云DDC客户端。

- 虚幻云DDC客户端

  - 读写功能。
  - 适合云使用。
  - 数据存储在

    虚幻云DDC服务器

    上，它处理数据如何在云存储（例如AWS、Azure或其他云存储）中持久存在，以及如何在不同区域之间复制。如果结合使用身份验证服务和适当的安全策略，你可以在公共互联网上部署此使用了身份验证的服务。未使用数据的清理和垃圾回收由服务器处理，而非虚幻编辑器。
- 文件系统

  - 读写功能。
  - 适用于本地磁盘和LAN使用。
  - 将数据存储为根文件夹中的多个文件，无论是在本地计算机上，还是在私有局域网络上共享的文件中。虚幻编辑器将直接处理文件的读写和删除操作，包括未使用数据的清理或垃圾回收。

UE 5.3及更早版本默认使用 **文件系统DDC作为本地DDC（Filesystem DDC as a Local DDC）** 来表示项目的派生数据。例如，你会在UE安装目录下的 `DerivedDataCache` 文件夹中找到你的本地DDC。

UE 5.4及更高版本默认使用 **虚幻Zen存储DDC作为本地DDC** ，并使用默认存储位置 `AppSettingsDir/Zen/Data`。旧版文件系统类型本地DDC被设置为仅限删除模式，并配置为在8天的清理期后删除数据。但你的项目也可以设置为使用 **DDC Pak** 或 **共享DDC** 。

### DDC Pak

如果你从Epic游戏商城下载UE，则该UE将附带DDC Pak(`.ddp`)。DDC Pak包含所有引擎内容的派生数据，因此你无需编译着色器和其他使用派生数据的引擎资产就可以开始工作。出于相同原因，一些示例也会提供DDC Pak。

你可以：

- 在

  <YourEngineDir>/DerivedDataCache/Compressed.ddp

  找到引擎的DDC Pak
- 在

  <YourProjectDir>/DerivedDataCache/Compressed.ddp

  找到项目的DDC Pak

### 共享DDC

共享DDC是网络驱动器或映射驱动器。比如，共享驱动器可以是： `\epicgames.net\root\DDC-Global-GameTitle`

对于身处同一地点（比如集中办公室或公司总部）的团队，我们强烈建议他们设置共享DDC。共享DDC最常见的安排是在网络驱动器上使用文件系统类型的DDC存储，这是所有团队成员和构建计算机均可读取/写入的网络驱动器。这可以抵消整个团队因为创建所需DDC数据而产生的成本。例如，当美术师编辑着色器时，DDC数据将直接写入DDC共享。

#### 本地Zen存储服务器

作为在共享网络驱动器上使用文件系统类型DDC的替代方案，你可以在本地网络上的计算机上托管虚幻[Zen存储服务器](../zen-storage-server/index.md)实例，并将其作为共享DDC。

如果你将其托管在Windows计算机上，你可以使用以下命令行将服务器作为Windows服务安装：

命令行

```
	zenserver.exe –install
```

`zenserver` 进程也可使用 `–config [path_to_config_file]` 参数接受配置文件。配置文件可控制的行为如下：

- 默认数据目录。
- 垃圾回收参数。
- 网络配置。

更多详情，请参阅[作为共享DDC的Zen存储服务器](../zen-storage-server/set-up-zen-storage-server-as-shared-ddc/index.md)。

### 云DDC

如果你的团队成员不全在同一个地点，你可以为团队设置云DDC，这个措施非常有用，可以供他们在本地网络或VPN之外共享DDC数据。

使用云DDC，你可以在编写完单个DDC数据块时将其添加到存档中。这与PAK或S3 DDC形成了鲜明的对比，后两者会创建并发布固定的只读存档，其中以特定的时间间隔包含了通常需要的数据。

你可以按照[此处](https://github.com/EpicGames/UnrealEngine/blob/ue5-main/Engine/Source/Programs/UnrealCloudDDC/README.md)的EpicGames GitHub仓库中的说明设置云DDC服务。如果你需要访问仓库，请遵循[GitHub上的UE](https://www.unrealengine.com/zh-CN/ue-on-github)页面上的说明。

## 如何使用共享DDC

你的共享DDC应该可以被特定地点的所有用户访问。这样，不论何时，仅有一人需要为资产构建派生数据格式，之后派生数据将自动供所有其他用户使用。

用户的系统在处理资产时偶尔会出现卡顿，但结果会存储在DDC中并与其他用户共享。即使在小团队中，以这种方式共享资产处理工作也可以为整个团队省去大部分处理时间。

> [!WARNING]
> 不建议在互联网复制整个DDC、备份DDC或从远程备份还原DDC，因为传输存储在DDC中的数据量将比在本地从头生成数据花费更长的时间。如果你有大型项目，并希望分发预构建DDC数据，你应该生成DDC Pak。

### 如何设置共享DDC

安装的UE已将 `BaseEngine.ini` 设置好，隐藏虚幻编辑器可以使用文件系统类型的共享DDC。

启用共享DDC的方式共有三种，下文按照推荐程度高低列出了推荐方式：

1. 在项目的

   DefaultEngine.ini

   中添加一个重载项，以将路径设置为对团队有效的位置。例如：

DefaultEngine.ini

```
[DerivedDataBackendGraph] Shared=(Type=FileSystem, ReadOnly=false, Clean=false, Flush=false, DeleteUnused=true, UnusedFileAge=10, FoldersToClean=10, MaxFileChecksPerSec=1, ConsiderSlowAt=70, PromptIfMissing=false, Path=\YourCompanyServer\DDC, EnvPathOverride=UE-SharedDataCachePath, EditorOverrideSetting=SharedDerivedDataCache)
```

1. 创建一个环境变量，将其映射到要使用的文件夹的文件路径：

   - Windows

     ：

     UE-SharedDataCachePath=[path to folder]
   - Mac/Linux

     ：

     UE_SharedDataCahcePath=[path to folder]
2. 打开编辑器偏好设置，前往 **通用（General） > 全局（Global） > 派生数据缓存（Derived Data Cache）** ，然后设置 **全局共享DDC路径（Global Shared DDC Path）** 。

### 如何禁用共享DDC

远程工作的开发者可能会遇到性能不佳的情况，这是因为DDC数据的访问和生成之间有延迟。

要临时禁用共享DDC，有以下两种方法：

- 对于文件系统或虚幻Zen存储DDC，在 `DefaultEngine.ini` 中使用 `DeactivateAt` 配置参数来设置一个阈值（单位为毫秒），到达该阈值时，DDC存储层将因性能不佳而禁用自身。
- 在命令行上传递 `-ddc=noshared` 。
- 将环境变量设置为本地硬盘驱动器：

  - Windows：

    UE-SharedDataCachePath=None
  - Mac/Linux：

    UE_SharedDataCachePath=None

## 如何使用云DDC

如果你的团队成员位于不同地点，云DDC可以确保你高效分享你的DDC。

要使用云DDC，你需要在云服务提供商上设置服务。如需了解更多相关信息，请参阅[云DDC设置指南](how-to-set-up-a-cloud-type-derived-data-cache/index.md)。一旦此服务就绪，即可按下述方式配置DDC客户端。

### 如何设置云DDC

安装的UE已将 `BaseEngine.ini` 设置好，因此虚幻编辑器可以使用云DDC。

你可以在项目的 `DefaultEngine.ini` 中添加重载项，从而启用云DDC：

DefaultEngine.ini

```
[StorageServers]Cloud=(Host="https://cloud-ddc.example.com", Namespace="myproject.sddc", OAuthProviderIdentifier=MyOrg-MyService, OAuthProvider="https://domain.oauthprovider.com/oauthuripath", OAuthClientId="ClientIdString")
```

此重载项包括：

- 有效主机的路径。
- 命名空间。
- 你团队的身份验证信息。

如需详细了解如何为你的身份提供商设置交互式登录，请参见[Oidc令牌页面](creating-oidc-tokens/index.md)。

### 非交互式登录云DDC以执行自动化作业

作为身份验证流程的一部分，云DDC通常涉及一个周期性交互式登录步骤。

对于构建农场或其他地方的自动化作业，你可以使用传递给虚幻编辑器进程的令牌绕过交互式登录。你的身份验证服务（静态或周期性）可以生成此令牌。

令牌必须具有足够长的有效期窗口，以包含运行时间最长的自动化作业。令牌应是密令，根据构建系统日志编写，并且只保存在执行自动化作业的计算机的内存中，而非磁盘上。

一旦你有这样的令牌，你可以通过名为 `UE-CloudDataCacheAccessToken` 的已配置环境变量将其传递到虚幻编辑器。

### 如何为云DDC构建派生数据

导入资产的用户就是构建派生数据的用户，因为他们最可能在UE中使用和测试该资产。

但是，新资产有时可能需要处理。这种情况会根据需要自动发生，在快速硬件上运行时不会造成太大影响，虽然偶尔可能会出现卡顿。

你可以随时填充你的DDC，只需在你的UE安装文件夹下运行以下命令：

命令行

```
Engine\Binaries\Win64\UnrealEditor.exe ProjectName -run=DerivedDataCache -fill
```

> [!TIP]
> 为确保DDC始终处于就绪状态，Epic Games每晚都执行此操作，但这并不是必须的，因为一般的自动缓存功能就够用了。

## 如何打包和分发DDC

烘焙是首选的游戏打包方法，因为烘焙后的构建不需要或使用DDC。但若是有需要，也可以打包分发DDC。

要打包DDC，请执行以下操作：

1. 从UE安装的

   Engine/Binaries/Win64

   目录运行

   UnrealEditor.exe

   ，传递以下参数： UnrealEditor.exe ProjectName -run=DerivedDataCache -fill -DDC=CreatePak
2. 这将在

   Project\DerivedDataCache

   目录中创建

   DDC.ddp

   文件。
3. UE将自动检测和使用

   .ddp

   文件。

## 如何配置你的DDC

你可以在以下 `.ini` 文件中的 `[DerivedDataBackendGraph]` 分段下配置DDC设置：

- 项目设置：

  <YourProjectDirectory>/Config/DefaultEngine.ini
- 引擎默认设置：

  <YourUEDirectory>/Config/BaseEngine.ini

虚幻Zen存储类型和虚幻云类型的DDC可以使用 `ServerID` 参数引用存储在 `.ini` 文件的 `[StorageServers]` 分段中的共享服务器配置。这样我们就能够一次性指定一组参数（如主机名和命名空间），而非使用多个DDC图段。

如需详细了解各个DDC配置选项，请参见[BaseEngine.ini](https://github.com/EpicGames/UnrealEngine/blob/release/Engine/Config/BaseEngine.ini)的 `[DerivedDataBackendGraph]` 分段下的注解。

如需详细了解UE中的配置文件，请参见[配置文件] (programming-and-scripting\unreal-architecture\configuration-files)。

## 常见问题解答(FAQ)

### 一般问题

#### 问：我是否可以有多项DDC设置？

可以！只需在 `DefaultEngine.ini` 中创建新的 `[YourDDCSettings]` 条目，然后使用 `-ddc=YourDDCSettings` 运行虚幻编辑器。

在Epic，我们这样做有以下三个原因：

1. 面向想要使用自己的DDC而不是全局DDC的办公室团队。
2. 在创建DDC Pak时，我们使用其中一个选项控制

   .pak

   文件中的内容，例如

   [CreateInstalledEnginePak]

   。
3. 面向因网速较慢或未启用VPN，而不想使用共享DDC的在家办公人员。

默认情况下， `BaseEngine.ini` 包含多个DDC条目，当中包括 `NoShared` ，该条目用于上面提到的在家办公人员（`-ddc=NoShared`）。

#### 问：我的磁盘空间不足，我是否可以将本地DDC移到其他位置？

可以！你可以在项目的编辑器偏好设置中调整这个选项。此外，你还可以将环境变量 `UE-LocalDataCachePath` 设置为你选择的路径。例如：`UE-LocalDataCachePath=D:\DDC` 。

1. 在命令提示中，键入

   setx UE-LocalDataCachePath D:\DDC

   。
2. 重启虚幻编辑器，以及任何启动虚幻编辑器的应用程序，例如Epic启动程序、UGS或Visual Studio。

当主驱动器上的空间不足，或者你在多个分支工作并希望确保数据不重复时，可以使用此方法。

#### 问：如果我的网速很慢，是否可以关闭共享DDC？

可以！有三种方法：

- （首选，自动）打开你的

  DefaultEngine.ini

  并将参数

  DeactivateAt=40

  添加到你的共享DDC配置。如果访问共享DDC的延迟大于40毫秒，则共享DDC会停用自身。你也可以根据自身使用情况，将值40改为更适合的其他值。这适用于文件系统类型或虚幻Zen商店类型的共享DDC。
- 将DDC的环境变量设置为

  None

  即可禁用该DDC。在这种情况下，你将设置

  UE-SharedDataCachePath=None

  。
- 使用

  -ddc=noshared

  启动虚幻编辑器。

#### 问：我是否可以更改共享DDC路径？

可以！你可以通过设置上述的 `UE-SharedDataCachePath` 更改该路径。

但切不可将 `UE-SharedDataCachePath` 设置为本地路径。这样做的话，你的计算机上将同时具有本地缓存和共享缓存，占了两倍磁盘空间，却没有任何益处！

> [!NOTE]
> 如果使用虚幻Zen存储类型DDC，你可以使用 `UE-ZenSharedDataCacheHost=hostname` 环境变量（或Mac上的 `UE_ZenSharedDataCacheHost=hostname` 环境变量）更改主机（不是路径）。

#### 问：如何诊断DDC问题？

如果你认为虚幻编辑器没有正确读取DDC数据，请在日志文件中搜索 `LogDerivedDataCache` 。

日志文件

```
LogDerivedDataCache: Display: Max Cache Size: 512 MBLogDerivedDataCache: FDerivedDataBackendGraph:  Pak pak cache file ../../../EngineTest/DerivedDataCache/DDC.ddp **not** found, will **not** **use** a pak cache.LogDerivedDataCache: Unable to find inner node Pak **for** hierarchical cache Hierarchy.LogDerivedDataCache: FDerivedDataBackendGraph:  EnginePak pak cache file ../../../Engine/DerivedDataCache/DDC.ddp **not** found, will **not** **use** a pak cache.LogDerivedDataCache: Unable to find inner node EnginePak **for** hierarchical cache Hierarchy.LogDerivedDataCache: Found environment variable UE-LocalDataCachePath=D:\DDCLogDerivedDataCache: Using Local data cache path D:\DDC: WritableLogDerivedDataCache: Using Shared data cache path \\epicgames.net\root\DDC-Global-UE: Writable
```

本例中，你可以看到：

- 没有项目或引擎Pak缓存。此构件是从Perforce编译的，符合预期。
- 本地数据缓存路径可以写入，并映射到了

  D:\DDC

  。
- 在使用Epic的可写入共享缓存。

> [!TIP]
> 你也可以运行 `-logcmds="LogDerivedDataCache Verbose"`，来打开冗余日志记录 。

#### 问：如何创建DDC Pak？

要创建项目的特定DDC，请运行： `UnrealEditor.exe ProjectName -run=DerivedDataCache -fill -DDC=CreatePak`

此命令将为项目中的所有内容创建DDC。或者，你可以在运行自动化时提供 `-DDC=CreatePak` ，甚至是用户会话，以便生成更有针对性的内容集。

要创建引擎DDC，请运行： `UnrealEditor.exe -run=DerivedDataCache -fill -DDC=CreatePak`

### 从文件系统本地DDC迁移到为虚幻Zen存储本地DDC

#### 问：什么是虚幻Zen存储(ZenServer)？

虚幻Zen存储，也称ZenServer，是Epic制作的一个程序，可管理虚幻编辑器之外的多种数据。我们用它管理本地DDC数据。

它会随虚幻编辑器自动打开和关闭，但你可以进行配置，让它在关闭状态下也能保持运行。

#### 问：若从本地DDC迁移到虚幻Zen存储本地DDC，会出现什么情况？

本地DDC将改用虚幻Zen存储管理你计算机上的缓存数据，而非只是数个文件夹的文件。这适用于Windows、Mac和Linux环境。

#### 问：这是否会占用我计算机上的磁盘空间？

会，我们设计了这项更改，以保留本地DDC文件的旧文件夹，并用它们向新的虚幻Zen存储本地DDC馈送内容。这可能会导致出现重复数据，但旧的本地DDC文件夹将在八天后删除未使用的数据。

#### 问：我是否必需在虚幻编辑器中更改DDC配置设置？

不必，虚幻Zen存储使用现有配置设置，配置DDC的相关指南没有变更。

#### 问：虚幻Zen存储会将本地DDC数据存储到哪里？

如果在你的UE工作空间根目录之外设置有本地DDC配置路径，并满足以下条件之一，则虚幻Zen存储将遵循你现有配置：

- 在虚幻编辑器DDC设置中设置了一个全局本地DDC路径。
- 通过环境变量重载了本地DDC路径。
- 通过命令行参数重载了本地DDC路径。

如果是这种情况，虚幻Zen存储会将其数据存放在指定路径的Zen子文件夹下。

如果不是这种情况，虚幻Zen存储会使用与之前所用的文件系统DDC不同的默认路径。Windows上的默认路径是：`C:\ProgramData\Epic\Zen\Data\` 。

> [!NOTE]
> 当用户的系统驱动器比其他驱动器快时，我们默认使用系统驱动器来支持常见用例。如果你想要使用其他位置，可以使用上述配置选项之一指定替代路径。

#### 问：运行虚幻Zen存储是否会妨碍我使用任何工具进行同步？

不会，你的工具会同步ZenServer可执行文件，但它不是从其已同步位置运行的。该可执行文件在执行之前会被复制到安装位置，即Windows上的 `C:\ProgramData\Epic\Zen\Install\` 。

当有新版ZenServer同步到你的工作空间时，虚幻编辑器会自动检测到，并会在启动它之前将新的可执行文件复制到安装位置。

> [!NOTE]
> 我们设计的ZenServer可向后兼容，所以如果你有多个工作空并且使用不同版本的ZenServer，虚幻编辑器将仅使用其中的最新版本。


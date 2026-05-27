---
title: "Android文件服务器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/android-file-server-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "Android调试", "Android文件服务器"]
---

# Android文件服务器

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / Android调试 / Android文件服务器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/android-file-server-for-unreal-engine

**Android文件服务器（Android File Server，简称AFS）** 是 **虚幻引擎（UE）** 的插件，用于在你打包 **开发、调试** 或 **测试** 项目（也可以是 **发布项目** ，[参阅下文](#%E5%9C%A8%E5%8F%91%E5%B8%83%E7%89%88%E6%9C%AC%E4%B8%AD%E4%BD%BF%E7%94%A8afs)）版本时将文件服务器嵌入你的Android应用程序。只要文件服务器在运行，你就可以使用 **UnrealAndroidFileTool** 来管理、推送和查看文件。在包含AFS的版本中，虚幻引擎会将其用于部署快速启动。AFS和UnrealAndroidFileTool一起构成了使用 **Android调试桥（Android Debug Bridge，简称ADB）** 之外的替代选择，可提供针对虚幻引擎的工作流程量身定制的许多相同功能。

AFS并不使用设备的SD卡外部存储来处理快速启动，而是使用项目包沙盒存储。这样一来，你就可以使用文件操作，而不需要存储权限或限定了范围的访问权限，因为在你开发项目和部署版本的过程中，不断重新启用这些权限会很麻烦。AFS还可以通过WiFi连接和/或USB连接运作，以更快进行部署。

## 配置和设置

本分段说明了如何配置AFS的打包和连接。你可以在 **项目设置（Project Settings）** > **插件（Plugins）** > **AndroidFileServer** 中找到这些设置。本分段列出了可供配置的每个参数。

![AFS项目设置菜单](../../../../../assets/images/97/973bc9db1a1eea7ed8fd1aa243f36baecd42850512c42692bf86b8a4d1e90978.jpg)

### 打包设置

**打包（Packaging）** 分段包含的设置用于配置哪种类型的版本将包含AFS，以及文件服务器将拥有哪些功能。AFS会默认启用，并且非发布版本将自动在你的项目中嵌入文件服务器，除非将其禁用。AFS在默认情况下未包含在发布版本中，但有设置可将其启用。

| **参数** | **说明** |
| --- | --- |
| **使用AndroidFileServer（Use AndroidFileServer）** | 如果启用该参数，你的项目将为打包的版本和快速启动版本包含嵌入的文件服务器。如果禁用该参数，你的项目中将不会使用AFS，并且虚幻引擎将回退为使用ADB。 |
| **允许网络连接（Allow Network Connection）** | 如果启用该参数，AFS将允许WiFi连接和通过USB连接。请参阅[连接设置](#%E8%BF%9E%E6%8E%A5%E8%AE%BE%E7%BD%AE)，了解更多详情。 |
| **安全令牌（Security Token）** | 一种唯一的字符串，可用于保护AFS的安全，防止没有该令牌的人远程启动。请参阅"使用安全令牌"，了解更多详情。 |
| **包含在发布中（Include in Shipping）** | 如果启用该参数，AFS将包含在发布版本中。请参阅"在发布版本中使用AFS"，了解更多详情。 |
| **在发布中允许外部启动（Allow External Start in Shipping）** | 与包含在发布中（Include in Shipping）配对使用时，该参数允许外部请求通过UnrealAndroidFileTool启动文件服务器或用于快速启动。 |
| **编译AFSProject（Compile AFSProject）** | 如果启用该参数，虚幻引擎会在打包你的项目时将AFS编译为单独的APK。请参阅"编译AFSProject"，了解更多信息。 |

#### 在发布版本中使用AFS

发布版本通常不包含AFS，但你可以启用 **包含在发布中（Include in Shipping）** 和 **在发布中允许外部启动（Allow External Start in Shipping）** 来添加AFS。如果你只启用包含在发布中（Include in Shipping），你仍可以使用AFS，但它不会用于快速启动，并且你需要从应用程序内部手动启动和停止它。

#### 启动和停止AFS

使用非发布版本时，或为发布版本启用外部启动时，将注册一个接收器来允许远程启动和停止文件服务器。你可以使用[UnrealAndroidFileTool](#unrealandroidfiletool)连接到设备的文件服务器并管理文件。否则，在启用AFS的情况下，你需要从你的虚幻引擎应用程序内部手动启动文件服务器。请参阅[使用蓝图手动启动和停止AFS](#%E4%BD%BF%E7%94%A8%E8%93%9D%E5%9B%BE%E6%89%8B%E5%8A%A8%E5%90%AF%E5%8A%A8%E5%92%8C%E5%81%9C%E6%AD%A2afs)，了解更多信息。

#### 使用安全令牌

如果你填写了 **安全令牌（Security Token）** 字段，文件服务器将要求来自UnrealAndroidFileTool的所有传入连接请求提供匹配的安全令牌。请参阅UnrealAndroidFileTool参考，了解更多信息。

> [!WARNING]
> 安全令牌仅提供基本安全性，不会以任何方式加密。你可以使用[Android文件服务器蓝图库](#%E4%BD%BF%E7%94%A8%E8%93%9D%E5%9B%BE%E6%89%8B%E5%8A%A8%E5%90%AF%E5%8A%A8%E5%92%8C%E5%81%9C%E6%AD%A2afs)，在发布版本中自行提供更强大的安全性。使用安全令牌时，务必不要将令牌提供给组织外部的人。

#### 编译AFSProject并手动安装AFS

如果启用了 **编译AFSProject（Compile AFSProject）** ，将打包一个包含文件服务器的独立APK，它会匹配你的项目的配置和密钥签名。 你可以将此APK安装到设备，以使用 `adb install -r` 选项管理新文件或现有文件。 之后，你可以使用相同的选项重新安装你的实际APK，而不会影响内部或外部数据文件。如果你需要在没有内置服务器的发布版本上管理文件，这尤其有用。

> [!NOTE]
> 无论是否启用编译AFSProject（Compile AFSProject），发布版本都会编译AFSProject。

### 部署设置（日志记录和压缩）

**部署（Deployment）** 分段中的设置用于控制文件服务器在你的日志中报告哪些信息。

| **参数** | **说明** |
| --- | --- |
| **使用压缩（测试版）（Use Compression (Beta)）** | 将压缩应用于文件服务器上的数据文件。在UE 5.0中，目前这对传输时间的影响很小。 |
| **记录文件（Log Files）** | 显示推送到设备的文件列表。 |
| **报告统计数据（Report Stats）** | 显示推送到设备的文件数量以及通过你的连接推送的字节数的列表。 |

启用日志输出设置时，虚幻引擎会在快速启动期间将有关AFS的安装过程的信息记录到 **控制台（Console）** 窗口中。

#### 同时启用USB和网络时的日志记录

如果同时启用USB和网络，AFS日志将显示一个前缀，表示文件是通过哪种类型的连接发送的。

| **前缀** | **说明** |
| --- | --- |
| 1> | 文件是通过USB发送的。 |
| 2> | 文件是通过Wifi发送的。 |

例如，以下行表示了地图文件是通过USB发送的。

```
	1> TestGameEntry.umap 
```

如果你同时使用USB和WiFi，当一个连接繁忙时，另一个连接将接管。

```
	1> TestGameEntry.umap	2> TestTexture.uasset	2> TestMaterial.uasset	1> TestPawn.uasset 
```

### 连接设置

**连接（Connection）** 分段包含一些选项，用于配置AFS将使用哪种类型的连接来将你的计算机连接到设备。

| **参数** | **说明** |
| --- | --- |
| **连接类型（Connection Type）** | 确定是使用USB、WiFi还是同时使用两者来连接文件服务器。 |
| **使用手动IP地址（Use Manual IP Address）** | 如果启用该参数，快速启动将使用手动IP地址（Manual IP Address）字段中提供的IP处的Android设备。否则，它将尝试通过USB（如果已连接）发现IP地址。 |
| **手动IP地址（Manual IP Address）** | 进行快速启动时你想连接到的Android设备的IP地址。该设备必须连接到你的本地WiFi网络。 |

#### 连接类型

**连接类型（Connection Type）** 下拉菜单可供选择要使用哪种类型的连接来推送文件。

| **连接类型** | **说明** |
| --- | --- |
| **USB** | 通过USB连接将文件推送到Android设备。 |
| **WiFi网络（WiFi Network）** | 通过WiFi连接将文件推送到你的计算机所在相同WiFi局域网上的Android设备。这需要启用 **允许网络连接（Allow Network Connection）** 设置。 |
| **USB和网络组合（USB and Network Combined）** | 同时使用USB连接和WiFi连接来推送文件。当一个连接因传输一个或一批文件而受到占用时，另一个连接会接管队列中的下一个文件。这样文件传输会更快。这会集成到部署过程中。 |

> [!NOTE]
> 除非你覆盖端口，否则AFS的默认端口是57099。

#### 使用手动IP地址

如果你启用 **使用手动IP地址（Use Manual IP Address）** 设置，并提供你的Android设备的IP地址，当你部署版本时，AFS将连接到该设备，而不是一般设备管理器工作流程中的默认设备。该设备仍必须连接到你的计算机所在的相同WiFi网络。

## 使用蓝图手动启动和停止AFS

你可以使用Android文件服务器蓝图库从你的UE应用程序内部手动启动、停止文件服务器并检查其状态。

![Start File Server、Stop File Server和Is File Server Running节点](../../../../../assets/images/eb/eb5d85c5dc659622932e417affd03ffa7017c2d902c3acdd0478a6204e5e9ada.jpg)

| **节点** | **说明** |
| --- | --- |
| **Start File Server** | 使用连接的指定端口启动文件服务器。你可以选择在使用该节点启动服务器时允许USB还是网络连接。返回值是布尔值，表明服务器是否已成功启动。 |
| **Stop File Server** | 如果文件服务器正在运行，则将其关闭。你可以选择仅关闭特定连接类型。返回值是布尔值，表明服务器是否已成功关闭。 |
| **Is File Server Running** | 通过 `EAFSActiveType` 返回文件服务器的当前状态。如果它处于不活动状态，这将返回 `None` (0)，如果它处于活动状态，则将返回以下某项： 1.仅USB 1.仅网络 1.USB和网络组合 公开了枚举值的Is File Server Running节点 |

AFS可以使用专为你的项目生成的唯一令牌提供基本安全性，相较于使用默认广播接收器，这些蓝图节点则适合创建更安全的方法来启动和停止AFS。

## UnrealAndroidFileTool

UnrealAndroidFileTool是一种命令行工具，可以连接到你的设备上部署的文件服务器来手动管理文件。该工具位于引擎的安装目录中的 `Engine/Binaries/DotNET/Android/UnrealAndroidFileTool` 下。该目录包含Linux、MacOS和Windows版本的可执行文件的文件夹。

![包含UnrealAndroidFileTool可执行文件的目录](../../../../../assets/images/9b/9bdde945648504b6a3bc7b710e9114e95410f90a6c3d3af2263bb82b99fa58e4.png)

> [!NOTE]
> 如果你需要所有三个操作系统的UnrealAndroidFileTool可执行文件版本，请打开 **项目设置（Project Settings）** > **平台（Platforms）** > **Android**，然后为所有平台启用 **生成安装文件（Generate Install Files）**。如果未启用该设置，虚幻引擎将仅提供与打包的目标目录中的编辑器主机类型匹配的可执行文件。
>
> ![undefined](../../../../../assets/images/ef/ef13828006172a1b219dff1eb6a85fdca46c6364f9e9db0622aa58264db3a3ed.png)

当你通过命令行运行该可执行文件时，它将显示包含其所有可用函数的菜单。你可以在命令行中附加其中任一命令来运行可执行文件。

![显示可用选项的AFS命令行](../../../../../assets/images/82/82901d61847789c4c3edb5612414016553f2c2087f169a78a0c6f9adaeff7cb9.png)

### 命令参考

UnrealAndroidFileTool的命令包含一组 **参数**，向该工具指明要与什么建立连接，其后将跟随要发送到文件服务器的 **命令**。例如，以下内容将在带有特定序列号的设备上运行shell命令，并查看特定项目的文件：

```
	UnrealAndroidFileTool.exe -s AB187923123CD123 -p com.OrganizationName.ProjectName shell 
```

#### 设置路径格式

AFS中的路径使用命令行路径的一般规范，但也支持导航文件层级的几个快捷键

| **文本** | **说明** |
| --- | --- |
| `^^` | 引用你使用 `cd` 命令设置的当前基本目录。请参阅[查询和导航命令](#%E6%9F%A5%E8%AF%A2%E5%92%8C%E5%AF%BC%E8%88%AA%E5%91%BD%E4%BB%A4)，了解更多信息。 |
| `^-n` | 上移指定数量的目录，其中 `n` 是所需数量。例如，使用 `^-3` 将上移三个目录。这样更容易处理相对路径，而不必使用 `/..` 的多个实例 |
| `^[key]` | 在文件路径开头使用，充当快捷键或查询给定键，其中 `[key]` 将替换为键的文本。例如，`^ext/` 是外部包目录，`^commandfile` 是 `UECommandLine.txt` 文件的快捷键。请参阅下表，了解有用快捷键的列表。 |

下面是使用 `^[key]` 的一些常见快捷键。你不一定要使用这些快捷键，但快捷键比较方便。

| **快捷键** | **说明** |
| --- | --- |
| **目录的快捷键** |  |
| `^ext/` | 外部存储目录。 |
| `^int/` | 内部存储目录。 |
| `^storage/` | 外部存储目录（需要READ_EXTERNAL_STORAGE和/或WRITE_EXTERNAL_STORAGE权限）。 |
| `^obb/` | obb目录。 |
| `^unreal/` | UnrealGame目录。 |
| `^project/` | UnrealGame/[project]目录。 |
| `^engine/` | UnrealGame/Engine目录。 |
| `^game/` | UnrealGame/[project]/[project]目录。 |
| `^saved/` | Saved目录。 |
| `^logs/` | Logs目录。 |
| **具体文件的快捷键** |  |
| `^commandfile` | `UECommandLine.txt` 文件。 |
| `^logfile` | 项目日志文件。 |
| `^mainobb` | 主 `.obb` 文件路径。 |
| `^patchobb` | 补丁 `.obb` 文件路径。 |
| **非文件路径查询** |  |
| `^packagename` | 项目的包名。 |
| `^version` | 包版本代码。 |
| `^ip` | 设备在网络上的IP地址。 |

#### 参数

以下参数可以放在文件服务器命令之前，为具体目标设备和项目配置你的连接。

| **命令** | **说明** |
| --- | --- |
| `-s [设备序列号]` | 将命令发送到带有给定序列号的设备。 |
| `-ip [IP地址]` | 连接到带有给定IP地址的设备。 |
| `-t [端口]` | 覆盖用于连接到设备的端口。如未另行指定，默认端口将为 `57099` 。 |
| `-p [包名]` | 你想连接到的应用程序的反向域包名。例如：`com.OrganizationName.ProjectName` 。包名区分大小写，必须完全匹配你的项目设置中给定的字符串。 |
| `-k [security token]` | 提供连接到文件服务器所需的安全令牌，如[使用安全令牌](#%E4%BD%BF%E7%94%A8%E5%AE%89%E5%85%A8%E4%BB%A4%E7%89%8C)下所述。 |

#### 设备管理命令

下表提供了命令参考，你可以使用这些命令获取可用设备和已识别包的信息，或用于停止远程服务器。

| **命令** | **说明** |
| --- | --- |
| `help [command]` | 如果你将help命令与带有参数的其他命令的名称一起使用，UnrealAndroidFileTool将提供有关该命令及其格式设置方式的更多信息。 |
| `devices` | 显示你可以访问的已连接设备的列表。带有 `@` 前缀的设备是授权设备。使用 `-s` 提供序列号时，请勿包含 `@` 。 |
| `packages` | 显示启用了AFS接收器的包的列表。 |
| `stop-all [-w]` | 将停止请求发送到带有接收器的所有包。如果你添加 `-w`，UnrealAndroidFileTool将等待所有侦听绑定终止，然后你才能再次与之交互。 |
| `terminate` | 停止指定的远程服务器。 |

> [!NOTE]
> 与文件服务器交互的所有命令，例如 `push` 、`pull` 或 `shell` ，都会隐式请求该服务器启动，因此没有用于启动服务器的命令。

#### 交互模式命令

你可以使用以下命令进入和退出 **交互模式**。交互模式的运作机制类似于ADB，打开与设备的连接，让你能够发送多个命令，而不必为每个命令运行UnrealAndroidFileTool.exe。UnrealAndroidFileTool将保持交互模式，直至你退出为止。

| **命令** | **说明** |
| --- | --- |
| `shell` | 进入交互模式。 |
| `quit` 或 `exit` | 退出交互模式。 |

#### 查询和导航命令

以下命令可获取有关你的设备上的目录和文件的信息，或在交互模式期间为你的基本目录提供导航。

| **命令** | **说明** |
| --- | --- |
| `query [key]` | 显示带有特定键的所有变量。 |
| `getprop [key]` | 获取与给定键关联的属性。 |
| `cd [path]` | 设置基本目录。然后你可以使用 `^^` 引用此目录，而不是手动打字。 |
| `pwd` | 显示当前基本目录。 |
| `direxists [path]` | 输出所提供路径处的目录是否存在。 |
| `ls [-l,-s,-R,-f] [path]` | 显示所提供路径处的目录的内容。列出的说明符指定了要输出什么信息： `-l` ：列出权限。 `-s` ：列出大小。 `-R` ：列出递归目录树。 `-f` ：扁平地列出。 |

#### 文件管理

以下命令将与你设备上的文件交互或修改这些文件。

| **命令** | **说明** |
| --- | --- |
| `mkdir [path]` | 在给定路径创建目录。 |
| `rmdir [path]` | 删除给定路径的目录。 |
| `fileexists [file]` | 输出指定的文件是否存在。 |
| `rm [file]` | 删除指定的文件。 |
| `cp [source] [destination]` | 将 `[source]` 文件复制到设备上的给定 `[destination]` 目录。 |
| `mv [source] [destination]` | 将 `[source]` 文件移至你的移动设备上的给定 `[destination]` 目录。 |
| `pull [source] [destination]` | 将你的移动设备中的[source]文件复制到你的PC上的给定 `[destination]` 目录。 |
| `push [-c] [source] [destination]` | 将你的PC上的 `[source]` 文件复制到你的移动设备上的给定 `[destination]` 目录。如果你添加 `-c` 参数，UnrealAndroidFileTool将压缩数据。 |
| `cat [file]` | 将设备中的文件内容写入输出日志。 |
| `deploy [-c] [file]` | 使用部署源/目标对读取文本文件。如果你添加 `-c` 参数，UnrealAndroidFileTool将压缩文件。 |

#### 命令行文件命令

以下命令将与你远程设备上的项目的 `UECommandLine.txt` 文件交互或修改此文件。

| **命令** | **说明** |
| --- | --- |
| `command [data]` | 将数据写入 `UECommandLine.txt` 文件。如果你不提供数据，它将显示该文件的内容。 |
| `addcommand [data]` | 将数据附加到 `UECommandLine.txt` 文件。 |
| `delcommand [data]` | 从 `UECommandLine.txt` 文件删除数据。 |

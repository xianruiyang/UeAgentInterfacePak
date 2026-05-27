---
title: "为你的组织配置Turnkey"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-turnkey-for-your-organization-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻Turnkey", "为你的组织配置Turnkey"]
---

# 为你的组织配置Turnkey

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻Turnkey / 为你的组织配置Turnkey

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-turnkey-for-your-organization-in-unreal-engine

平台所有者（Platform Owner）会根据情况将SDK分发到组织。虽然你仍然需要从提供方那里获得SDK，但可以将其存放到组织的共用目录中。**Turnkey** 可以访问这些文件，将SDK下载和安装到用户的设备上。

你可以用三种不同的方式来托管Turnkey的SDK文件。

- 存放在组织的Perforce仓库中。
- 存放在用户的本地机器中。
- 存放在Google Drive中。

Turnkey然后使用一组关联的XML文件来确定格个平台需要哪些SDK。系统会首先读取 **虚幻引擎** 安装目录下的 `Engine/Build/Turnkey` 目录中的 `TurnkeyManifest.xml` 文件和 `TurnkeyStudioSettings.xml` 文件。

![Turnkey清单位置](../../../../assets/images/d5/d5eab51c29558e66e0c3464b13433e925be0baf6a6d26cc568ef8a9e4772b097.png)

`TurnkeyManifest.xml` 写明了哪些SDK可用，或者指向了其他包含所需信息的清单文件； `TurnkeyStudioSettings.xml` 提供Studio的全局信息，例如访问Google Drive或签名证书时所需的凭证。`TurnkeyManifest.xml` 和 `TurnkeyStudioSettings.xml` 可以链接到一起，指向本地或远程目录中的其他 `.xml` 文件。

理想情况下，你的组织会把 `TurnkeyManifest.xml` 连同版本控制系统中的虚幻引擎源文件一起分发给所有用户。这个基础清单不能修改，但可以指向其他与各平台SDK文件一起保存的清单。通过此方法，你可以随意编辑和更新这些清单，而不会更改任何虚幻引擎源文件。

## 清单文件概览

Turnkey清单包含以下信息：

- 包含整个清单的 `TurnkeyManifest` 标签

  - `AdditionalManifests` 标签

    - 指向你要和当前清单包含在一起的任何其他清单的

      Manifest

      条目。
  - 包含可用SDK相关信息的 `FileSource` 条目，包括：

    - `Platform`
    - `Type`
    - `Version`
    - `Name`
    - `Source`

例如，下面是支持Win64和Mac的有效TurnkeyManifest的示例：

```
	<?xml version="1.0" encoding="utf-8" ?>	<TurnkeyManifest>		<AdditionalManifests>			<Manifest>$(ThisManifestDir)/MyStudio_TurnkeyManifest.xml</Manifest>			<Manifest>$(UE_STUDIO_TURNKEY_LOCATION)</Manifest>		</AdditionalManifests> 		<FileSource>			<Platform>Mac</Platform>			<Type>Full</Type>			<Version>$(ExpVersion)</Version>			<Name>MacOS SDK v$(ExpVersion)</Name>			<Source>fileexpansion:googledrive:/SdkInstallers/Mac/$[ExpVersion]/Installer.zip</Source>		</FileSource> 		<FileSource>			<Platform>Win64</Platform>			<Type>Full</Type>			<Version>1.00</Version>			<Name>Win64 SDK V1.00</Name>			<Source>googledrive:/SdkInstallers/Win64/1.00/Installer.zip</Source>		</FileSource> 	</TurnkeyManifest> 
```

## 提供其他清单

`AdditionalManifests` 包含一些指向其他XML文件的 `Manifest` 条目，Turnkey扫描文件时会一同扫描这些XML文件。`Engine/Build/Turnkey` 目录中的 `TurnkeyManifest.xml` 始终是此流程的起点。你可以根据需要任意链接清单，并用任何方式组织它们。

此列表中的 `Manifest` 条目遵循的格式设置规则与源文件的文件参考的规则相同。因此，其他清单可以位于源文件所在的任意位置，包括远程仓库或Google Drive文件夹。如需如何对目录字符串进行格式化的更多信息，请参见[格式设置规则](#%E5%AD%97%E7%AC%A6%E4%B8%B2%E6%A0%BC%E5%BC%8F%E8%AE%BE%E7%BD%AE%E5%8F%82%E8%80%83)。

## FileSource条目

FileSource条目会列出可供你的组织使用的特定SDK，或者分组的SDK条目，具体取决于你如何填充。下面介绍FileSource条目中每个参数的规则。

### 平台

SDK支持的平台的名称。Turnkey使用此信息自动确定给定平台的相应版本控制规则。

平台名称必须与虚幻引擎的内置平台名称匹配。例如，应该使用"Win64"而非"Windows"，使用"IOS"而非"iPhone"。

### 类型

类型（Type）字段描述你要列出完整的SDK安装还是更加简易的SDK，例如flash工具包。有效的SDK类型如下：

| 类型 | 说明 |
| --- | --- |
| **Full** | 完整安装SDK，开发人员一般选择此项。 |
| **AutoSDK** | 虚幻引擎会根据需要来配置SDK安装。当AutoSDK和完整SDK都存在时，Turnkey首选AutoSDK。 |
| **Flash** | 简易版安装，适合需要快速开发的人员。 |

> [!TIP]
> 有关AutoSDK的更多信息，请参阅虚幻引擎[AutoSDK参考](../../../sharing-and-releasing-projects/tools-for-general-platform-support/using-the-autosdk-system/index.md)。

### 版本

版本（Version）字段包含SDK的版本编号。每个平台都有不同的预期版本格式，因此务必准确列出此信息。

你可以使用捕获变量（例如 `$[ExpVersion]`）在[源](#%E6%BA%90)部分中捕获版本编号，然后在此部分中列出 `$(ExpVersion)` 来作为替代变量。如需更多详细信息，请参见[文件扩展和捕获变量](#%E6%96%87%E4%BB%B6%E6%89%A9%E5%B1%95%E5%92%8C%E6%8D%95%E8%8E%B7%E5%8F%98%E9%87%8F)部分。

当Turnkey扫描SDK时，版本号还会转换成整数。Turnkey针对每个平台使用不同的规则，并且如果Full和Flash SDK使用不同的版本设置格式，也应该将这个因素考虑在内。在Turnkey比较SDK的多个有效版本时，将在列出的版本中优先采用最高的转换后整数值。

> [!TIP]
> 如需了解每个平台预期的版本号格式设置，请检查[Turnkey命令行](../using-the-turnkey-commandline/index.md)中的Help命令。

### 名称

名称（Name）字段包含SDK的可辨识名称。它纯粹供显示用，你想设置成什么都可以。

名称（Name）字段可以接受替代变量（与你在FileSource其他位置使用的捕获变量对应）。例如，如果使用 `$[ExpVersion]` 来表示版本号，那么名称字段可以使用 `$(ExpVersion)` 来替代捕获变量发现的数值。如需捕获变量和替代变量相关的信息，请参阅[文件扩展和捕获变量](#%E6%96%87%E4%BB%B6%E6%89%A9%E5%B1%95%E5%92%8C%E6%8D%95%E8%8E%B7%E5%8F%98%E9%87%8F)部分。

### 源

源（Source）字段包含描述SDK位置的字符串。此字符串分为两部分：一组前缀，用于告知Turnkey如何读取文件路径，另一部分则是文件路径自身。

例如，以下是用于在本地文件系统中查找Win64 SDK（使用 `file:` 前缀）并预期找到名为 `Install.zip` 的7zip文件的源条目：

```
	<Source>file:X:\SdkInstallers\Win64\1.10\Install.zip</Source> 
```

你可以使用 `fileexpansion:` 前缀让 **捕获变量（capture variables）** 使用文件提供程序中的数据在多个SDK中迭代。例如，以下路径将是使用[版本](#%E7%89%88%E6%9C%AC)字段中指定的版本号的源条目：

```
	<Source>fileexpansion:file:X:\SdkInstallers\Win64\$[ExpVersion]\Install.zip</Source> 
```

该路径不是仅查找一个特定的文件路径，而是查找与此格式匹配的每个文件路径。

源（Source）参数还可以使用可选的 `CopyOverride` 说明符在使用Perforce仓库时限制Turnkey展开的目录。如需了解使用此说明符的FileSource块，请参阅下面的[示例](#%E7%A4%BA%E4%BE%8B)。

如需可以和源字符串搭配使用的前缀和捕获变量，请参阅下面的[格式设置参考](#%E5%AD%97%E7%AC%A6%E4%B8%B2%E6%A0%BC%E5%BC%8F%E8%AE%BE%E7%BD%AE%E5%8F%82%E8%80%83)。

### 其他参数

虽然上述参数是最常用的，但也存在其他在特殊情况下使用的参数。

#### AllowedFlashDeviceTypes

`AllowedFlashDeviceTypes` 数值仅适用于类型为Flash的SDK。这些字符串的数值仅对特定平台有意义。可供使用的数值可以在Turnkey命令行的Help部分中找到，显示在给定平台的信息下面。当Turnkey收到设备信息之后，将会提供设备类型（Device Type）和安装的软件版本。然后，它使用这些信息来确定软件是否为最新并选择要从中进行安装的Flash FileSource。

### 示例

以下是用于在Perforce仓库中查找AutoSDK文件的FileSource条目示例。此示例查找 `Setup.bat` 和 `Setup.sh` 文件，以根据SDK版本、平台扩展成一个FileSource，然后使用 `CopyOverride` 限制Turnkey进行递归式扩展，除非用户显式选择这些SDK中的一个。这可以防止Turnkey在过多的Perforce文件上进行不必要的扩展。此行为特定于Perforce，因为它仅针对文件运行，而不针对目录。

```
	<FileSource>	<Platform>listexpansion:ExpPlatform=$(AutoSDKPlatforms)</Platform>	<Version>$(ExpVersion)</Version>	<Name>$(ExpPlatform) AutoSdk version $(ExpVersion)</Name>	<Type>AutoSdk</Type>	<Source CopyOverride="perforce://depot/CarefullyRedist/Host$(HOST_PLATFORM_NAME)/$(ExpPlatform)/$(Version)/...">	fileexpansion:perforce://depot/CarefullyRedist/Host$(HOST_PLATFORM_NAME)/$(ExpPlatform)/$[ExpVersion]/Setup.*	</Source>	</FileSource> 
```

## 字符串格式设置参考

Turnkey清单中的字符串使用多个前缀来确定如何读取给定的文件路径。根据你使用的前缀，文件路径可以包含自定义变量，这些自定义变量在读取时展开为附加信息。这让你可以指定文件路径的预期格式，而不是显式列出特定文件的文件路径，并且Turnkey将发现与该格式匹配的所有文件。

### 副本提供方

**副本提供方（Copy provider）** 前缀将确定Turnkey在解析后面跟随的文件路径时应该查找哪种类型的位置。Turnkey可识别三种类型的位置，而且可以从这些位置类型的前缀预料到会出现哪种文件路径，这是有规律可循的。

| 前缀 | 说明 | 示例文件路径 |
| --- | --- | --- |
| `file:` | Turnkey将在本地文件系统中查找SDK安装程序。 此前缀需要标准文件路径，包括文件所在的驱动器。可以包括共享的网络驱动器。 MacOS需要添加 `smb:` 前缀才能安装SMB共享。 | `file:X:\\SdkInstallers\\$[ExpPlatform]\\$[ExpVersion].Install.zip` `file:smb:X:\\SdkInstallers\\$[ExpPlatform\\$[ExpVersion].Install.zip` |
| `perforce:` | Turnkey将连接到Perforce流送来查找SDK安装程序。 此前缀需要标准的Perforce文件规范，必须始终包含具体的文件组件，并需要添加文件扩展名。此外，在首次使用时可能还会提示你提供客户端规范，以便查找Perforce客户端的位置。 | `perforce:\\\\depot\\SdkInstallers\\$[ExpPlatform]\\$[ExpVersion].Install.zip` |
| `googledrive:` | Turnkey将连接到Google Drive来查找SDK安装程序。 文件路径中的第一个组成部分表示要查找的共享驱动器的名称，而路径的所有后续组成部分都是该驱动器上组文件夹的名称。 | `googledrive:/SdkInstallers/$[ExpPlatform]/$[ExpVersion].Install.zip` |

使用本地文件时要求进行最低限度的额外设置，因为你可以使用直接位于用户机器上的SDK安装程序。但是，此设置要求最大限度的额外维护，因为每个用户都必须维护与SDK安装程序所在的文件夹相一致的本地文件夹。你可以使用共享的网络驱动器而不是用户机器上的本地驱动器，但具体取决于共享驱动器的速度，因为使用网络驱动器的速度可能会很缓慢。

使用Google Drive要求进行最大限度的额外设置，因为必须设置账号才能使用Google Drive API，并且需要为用户提供OAuth 2.0凭证及其引擎文件。但是，一旦设置之后，此设置就可以为组织的管理员提供相对简单的维护点。如需更多信息，请参阅[为Unreal Turnkey设置Google Drive](../setting-up-google-drive-for-turnkey/index.md)指南。

使用Perforce流送可以为这两种方法提供一个均衡的解决方案，因为它可以为组织创建一个集中位置来保留SDK文件，但要求你的组织设置Perforce流送并为用户提供凭证才能进行访问。

> [!NOTE]
> 如果需要为Turnkey的其他源代码管理选项添加支持，可以通过更改引擎源代码来添加新的副本提供方类型。如需查看示例，请参见 `GoogleCopyProvider`, `PerforceCopyProvider` 和 `NullCopyProvider`。

### 文件扩展和捕获变量

`Fileexpansion:` 前缀为Turnkey提供了一种方法来搜索与常规格式匹配的路径，而非特定SDK的路径。这减少了对你不需要下载的SDK的服务器调用数量，并且可以追踪大量的SDK而不需要分别编写其条目。例如，你可以将一个新安装程序上传到服务器，并且只要其目录结构符合FileSource条目中列出的预期格式，文件扩展就可以发现它，并且不需要修改清单。

在使用 `fileexpansion:` 前缀时，必须在它后面跟随副本提供方前缀，例如 `file:` 或 `googledrive:`，因为文件扩展取决于副本提供方中的信息。

在将 `fileexpansion:` 添加到你的路径之后，即可使用 **捕获变量（capture variables）** 替换路径的组成部分。这些变量使用 `$[xyz]` 格式，其中的xyz将替换为你定义的任意字符串。当Turnkey读取清单时，将会使用用户和文件提供程序中的信息来扩展路径。

作为示例，如果你使用以下源字符串：

```
	fileexpansion:file:X:\Installers\$[ExpPlatform]\$[ExpVersion]\Install.bat 
```

Turnkey将会把 `$[ExpPlatform] 和 $[ExpVersion]` 捕获变量转换为通配符数值（即 `*` 字符）。然后，Turnkey将会把这些路径传递到 `fileexpansion:` 前缀后面使用的副本提供方，在此示例中为本地文件系统。提供程序随后通过其可用的文件和文件夹进行迭代，并返回与提供的格式匹配的结果列表，以及为每个捕获变量捕获的数据。

```
	X:\Installers\Win64\1.00\Install.bat [ $(ExpPlatform) = Win64, $(ExpVersion=1.00)]	X:\Installers\Win64\2.00\Install.bat [ $(ExpPlatform) = Win64, $(ExpVersion=2.00)]	X:\Installers\Android\10.1a\Install.bat [ $(ExpPlatform) = Android, $(ExpVersion=10.1a)] 
```

Turnkey用C#为这些条目中的每一个创建FileSource对象，然后SDK安装程序在下载源时将会发现这些对象。文件路径中通过捕获变量扩展的部分将转换成 `$(xyz)` 样式的 **替换变量（replacement variables）**，可以让FileSource对象在其他字段中引用。例如，如果在源路径中使用 `$[ExpVersion]`，还可以在版本（Version）字段中使用 `$(ExpVersion)`。

捕获变量可以表示文件路径的任意部分，包括文件名、目录甚至是名称的组成部分。

```
	fileexpansion:file:X:\Installers\$[ExpPlatform]\Installer_$[ExpVersion].zip 
```

例如，上面的条目预期安装程序存在于其平台的文件夹中，并且预期安装程序包含在名称类似于 `Installer_1.00.zip` 或 `Installer_2.00.zip` 的 `.zip` 文件中。

### 列表扩展

`Listexpansion:` 前缀使用可能的数值的列表来定义变量，该变量不需要查询服务器。在使用 `listexpansion` 定义变量时，可以在FileSource中的其他条目中使用它。

例如，以下文本在平台下定义 `listexpansion`，然后在 `Name` 下引用该列表。

```
	<Platform>	listexpansion:ExpPlatform=Windows,Android,IOS	</Platform>	<Name>$(ExpPlatform) Installer</Name> 
```

当Turnkey读取该信息时，它将为Windows、Android和iOS创建单独的FileSource对象，并针对每个平台相应地替换 `$(ExpPlatform)`。此功能不需要Turnkey查询服务器，因为它使用 `listexpansion` 提供的列表。如果根据列表扩展生成了带有SDK的平台列表，这就有可能让Turnkey的初始设置更加快速。

此外，还可以使用XML变量来存储列表项目，而不是直接列出它们。

```
	<SavedSetting hostplatform="Win64"> 		<Variable>AllowedPlatforms</Variable> 		<Value>Windows,Android</Value> 	</SavedSetting> 	... 	<Platform>listexpansion:ExpPlatform=$(AllowedPlatforms)</Platform> 
```

### 内置变量

Turnkey支持使用多种内置变量来定义文件路径和用户定义的捕获和替代变量。

| 变量 | 说明 |
| --- | --- |
| `$(ThisManifestDir)` | 扩展到当前正在处理的 `TurnkeyManifest.xml` 文件的目录。这包括清单当前所在位置的提供程序前缀，因此如果在Perforce目录中发现了它，它将自动包含 `perforce:` 前缀，不需要由你进行定义。 只要每个目录相对于清单的位置保持不变，此变量就能让系统重新查找整个目录结构。 |
| `$(EngineDir)` | 虚幻引擎安装的根文件夹。如果使用签入到源代码管理的文件，那么这是很有用的参考点。 |
| `$(HOST_PLATFORM_NAME)` | 主机平台的名称。通常为Win64、Mac或Linux。 |
| `$(UE_STUDIO_TURNKEY_LOCATION)` | 可以设置为整个Studio的Turnkey目录位置的环境变量。 |

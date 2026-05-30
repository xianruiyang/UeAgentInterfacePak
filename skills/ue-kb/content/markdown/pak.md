# 入门：在运行时加载内容和 Pak 文件

# 入门：在运行时加载内容和 Pak 文件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/D7nL/unreal-engine-primer-loading-content-and-pak-files-at-runtime

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 12527 字符。

## 摘要

入门：在运行时加载内容 本文档旨在概述运行时加载内容/资产的各个方面。它特别关注熟制内容和原生虚幻资产。特…

## 中文整理

### 概览

入门：在运行时加载内容 本文档旨在概述运行时加载内容/资产的各个方面。它特别关注熟制内容和原生虚幻资产。这不包括如何通过 datasmith 运行时功能导入其他类型的资产，例如 USD 场景或 CAD 数据。

### 加载 Pak 文件

### 自动装载

引擎将在启动时从以下位置挂载可用的 pak 文件： - /Content/Paks/ - Engine/Content/Paks/ - Saved/Content/Paks/ 通过常规打包过程创建的 Pak 文件将包含一个名为 AssetRegistry.bin 的清单文件，该文件向 AssetRegistry 通知 pak 文件中的资产，从而无需手动扫描内容。

### 手动装载

Pak 文件可以在运行时通过 C++ API 按需加载。有两个选项： - 广播 [FCoreDelegates::MountPak](https://docs.unrealengine.com/4.26/en-US/API/Runtime/Core/Misc/FCoreDelegates/MountPak/) 委托 这是一个高级 API，不需要指向 FPlatformFilePak 实现的指针。相反，该实现侦听该委托的广播并启动挂载调用作为响应。 - 直接调用[FPlatformFilePak.Mount](https://docs.unrealengine.com/4.27/en-US/API/Runtime/PakFile/FPakPlatformFile/Mount/)。这是用于启动 pak 挂载的直接 pak 文件 PlatformFile API。

### 控制台命令

注意：控制台命令在发布版本中不可用。请参阅[IPlatformFilePak.cpp中的FPakExec](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/PakFile/Private/IPlatformFilePak.cpp#L6766)了解实现。 - Mount [] 挂载 pak 文件，可以选择将挂载点作为第二个参数 - Unmount 卸载 pak 文件。 - PakList 列出当前安装的 pak 文件。

### 文件优先级

Pak 在内部存储在根据优先级排序的列表中，优先级首先由 pak 文件的优先级值确定，然后根据安装顺序（较新的优先）确定。文件请求将从具有最高排序顺序的 pak 中返回匹配的文件。根据 pak 文件位置和名称，可以对 pak 文件应用附加优先级。例如，指定为补丁的 Pak 文件在启动时加载时其优先级将增加 1000。这可确保修补的文件接收更高的排序顺序，实际上覆盖其他包中的相同文件。补丁包可以通过其文件名中的 _P 后缀来识别。除了基于 pak 文件位置和名称给出的隐式优先级之外，手动安装请求还接受优先级参数。请参阅[FPakPlatformFile::GetPakOrderFromPakFilePath](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/PakFile/Private/IPlatformFilePak.cpp#L7526)和 [FPakPlatformFile::Mount](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/PakFile/Private/IPlatformFilePak.cpp#L7239)。

### Pak 文件中的挂载点：

pak 文件中存储的所有文件都使用相对于正在执行的应用程序的二进制文件的路径。这意味着此级别尚不存在虚拟路径（如 /Game/）。每个 pak 文件都有一个挂载点，指定它包含的所有文件最初存储的位置，例如在项目的内容文件夹中。可以将其视为将 pak 文件中的文件提取到打包的游戏文件夹中的特定目录中。挂载点也会显示在日志中，相关消息如下所示：

```cpp
LogShaderLibrary: Display: ShaderCodeLibraryPakFileMountedCallback: PakFile '../../../UE_4_27/Content/Paks/pakchunk0-WindowsNoEditor.pak' (chunk index 0, root '../../../') mounted

LogShaderLibrary: Display: ShaderCodeLibraryPakFileMountedCallback: pending pak file info (ChunkID:0 Root:../../../ File:../../../UE_4_27/Content/Paks/pakchunk0-WindowsNoEditor.pak)
```

以下是 pak 文件的示例（输出来自 UnrealPak.exe -List）：

```cpp
LogPakFile: Display: Mount point ../../../

...

LogPakFile: Display: "Engine/Plugins/Tests/EditorTests/EditorTests.uplugin" offset: 28508892, size: 496 bytes, sha1: 87D598071C6B751B93866E831E91ECE50798A088, compression: None.

LogPakFile: Display: "Engine/Plugins/Tests/ScreenshotTools/ScreenshotTools.uplugin" offset: 28509441, size: 504 bytes, sha1: 55CDCB06BED437F1EB2A2554A841997D24B5FC25, compression: None.

LogPakFile: Display: "Engine/Plugins/VirtualProduction/Takes/Takes.uplugin" offset: 28510208, size: 1195 bytes, sha1: 713B557C2204E111153B9BFC917CAEC24BAA18B0, compression: None.
```

该文件包含引擎内容、游戏内容、配置文件、引擎插件文件等，每个文件都映射到打包应用程序的文件结构中。然后使用虚幻文件系统中的挂载点将这些文件夹分类到游戏内引用中，例如 /Game/...

### UFS（虚幻文件系统）中的挂载点/根路径：

Unreal 使用虚拟文件系统来引用任何资产或对象，称为 Unreal 文件系统。资产引用不指定磁盘上的绝对路径，而是引用根路径，其作用类似于某些资产所属的虚拟文件夹。挂载点从磁盘上的某个路径映射到用于访问游戏中所有资源和引用的虚拟路径。用于创建挂载点的路径始终相对于实际的游戏可执行文件，通常位于 <ProjectName>/Binaries/<PlatformName>/（对于打包项目）。因此挂载点 ../../../ 通常应该是您项目的文件夹。用户应该注意，它们采用打包项目的文件夹结构，因此项目内容将位于 <ProjectName>/Content/ 而不是 Content/ 中。引擎将设置几个默认挂载点： - /Game/ 映射到项目的内容文件夹 (../../../<ProjectName>/Content/) - /Engine/ 映射到引擎的内容文件夹 (../../../Engine/Content/) 一些临时/只读挂载点： - /Script/ 用于类 - /Temp/ - /Config/ 每个插件一个挂载路径： - /PluginName/ 用于每个插件内容文件夹，例如插件/插件名称/内容/

### 控制台命令

要调试挂载点或在运行时添加/删除它们，您可以使用以下控制台命令 - PackageName.DumpMountPoints 写出所有现有挂载点 - PackageName.RegisterMountPoint <RootPath> <ContentPath> 注册 LongPackagePath 挂载点 - PackageName.UnregisterMountPoint <RootPath> <ContentPath> 删除 LongPackagePath 挂载点

### 插件加载行为：

在引擎启动时，*FPluginManager* 将尝试发现并加载所有启用的插件。这是通过搜索任何可用的 .upluginmanifest 文件并（如果未找到）手动搜索 .uplugin 文件来完成的。加载插件时，其内容目录将被添加为根路径 /PluginName/。注意：插件内容包可能包含序列化的 AssetRegistry，但只有在游戏启动时加载插件时才会使用它。当插件的 pak 文件在运行时下载并安装时它将不起作用，在这种情况下，新插件的根路径必须由开发人员手动添加。

### DLC

构建 DLC 时，常规工作流程是打包游戏的命名/版本版本（例如“1.0”），然后稍后向项目添加其他插件。新插件可以打包为 DLC 插件并添加到已打包的游戏中以供用户使用。如果引擎发现该插件是 DLC 插件，它应该遵循常规的插件安装逻辑，而当您仅从代码中安装 pak 文件时，您可能需要手动指定安装点。注意：在 PC 上，构建 DLC 时可能需要包命令的附加标志，以便引擎正确识别它：-DLCPakPluginFile。此标志将在 pak 文件中包含一个名为 PluginName.upluginmanifest 的文件，并允许引擎检测 DLC Pak 文件是否包含属于先前未知插件的内容。与 AssetRegistry.bin 一样，这需要 pak 文件在引擎启动时可用。

### 资产注册行为：

AssetRegistry 只知道烹饪时存在的资产。它在启动期间从存储在 pak 文件中的 AssetRegistry (AssetRegistry.bin) 的序列化版本加载此缓存信息。 Unreal 将在启动期间加载许多 AssetRegistry.bin 文件，例如每个插件的 AssetRegistry 在启动时加载（如果存在）。此外，AssetRegistry 还会侦听 [FPackageName::OnContentPathMounted](https://docs.unrealengine.com/4.26/en-US/API/Runtime/CoreUObject/Misc/FPackageName/OnContentPathMounted/) 委托，因此当安装新的挂载点时，资产注册表将开始异步搜索新目录中的任何资产并将其添加到内部数据库中。这将是异步的，并且资产可能无法立即可用。 [IAssetRegistry::ScanPathsSynchronous](https://docs.unrealengine.com/4.27/en-US/API/Runtime/AssetRegistry/AssetRegistry/IAssetRegistry/ScanPathsSynchronous/) 可用于强制立即更新资源缓存，并在同一帧中通过资源注册表提供新资源。

### 在运行时加载外部资源的限制

Unreal 中的低级文件 API (*IPlatformFile*) 存在限制，无法从打包游戏中加载松散的 .uasset/.umap 和其他 Unreal 资源文件。

### FPlatformFilePak：

这是打包游戏中使用的默认文件系统访问器。默认情况下，它将加载已挂载的 pak 文件中的任何文件，如果找不到文件，则回退到常规文件系统访问。对于访问任何 pak 文件之外的文件，还有额外的安全检查。 *FPakPlatformFile::ExcludedNonPakExtensions* 指定 pak 文件之外的禁止文件名列表。如果用户从源代码编译引擎，则可以通过将预处理器定义 EXCLUDE_NONPAK_UE_EXTENSIONS 设置为 0 来覆盖这一点。这可以在游戏的 *.Target.cs 文件中完成，如下所示： GlobalDefinitions.Add("EXCLUDE_NONPAK_UE_EXTENSIONS=0");使用 pak 文件时，4.27 中的默认[禁止文件扩展名](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/PakFile/Private/IPlatformFilePak.cpp#L7015)： - uasset - umap - ubulk - uexp - uptnl - ushaderbytecode

### FSandboxPlatform文件：

当使用煮熟的内容启动游戏但没有 pak 文件时，将使用此选项。当从 Visual Studio 启动非编辑器构建而不首先打包游戏并且需要熟化内容可用（Windows 的熟化内容必须至少执行一次）时，通常会发生这种情况。烘焙内容的默认文件夹是 Saved/Cooked/WindowsNoEditor/。沙盒模式需要 -sandbox= 参数以及已烘焙内容的完整路径，并且仅适用于桌面平台上的客户端和游戏构建。 4.27 中的默认[禁止文件扩展名](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/SandboxFile/Private/IPlatformFileSandboxWrapper.cpp#L69) 在以烘焙内容启动但没有时.pak 文件（沙盒模式）：在运行时加载附加游戏内容的推荐解决方案是使用如上所述的 pak 文件。

### 动态内容加载的现有解决方案

引擎中有多个实现已经提供了在运行时获取和加载内容包的逻辑。详细介绍它们超出了本文档的范围，但此处提到它们仅供参考，并且如果可能的话，应优先于完整的自定义解决方案。 [ChunkDownloader](https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/Patching/ChunkDownloader/) 提供了一种使用内置分块系统创建单个内容 pak 文件的解决方案，并集成了从服务器下载可用 pak 文件列表、下载这些文件的用户定义子集并按需安装它们的逻辑。它可以作为构建自定义逻辑的一个很好的示例，也可以按原样用于许多更简单的用例。此外，许多平台提供了自己的分块安装系统实现，请参阅[GenericPlatformChunkInstall.h 中的 IPlatformChunkInstall](https://github.com/EpicGames/UnrealEngine/blob/4.27/Engine/Source/Runtime/Core/Public/GenericPlatform/GenericPlatformChunkInstall.h#L118) 了解 API 概述。 **在[知识库](https://forums.unrealengine.com/docs)获取更多答案**


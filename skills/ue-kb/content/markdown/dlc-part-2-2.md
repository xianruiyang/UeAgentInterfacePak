# 在虚幻引擎中创建与平台无关的 DLC (Part 2/2)

# 在虚幻引擎中创建与平台无关的 DLC (Part 2/2)

Source file: `creating-platform-agnostic-dlcs-in-unreal-engine.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 打包游戏中的插件检测

由于 DLC 是游戏最初打包时不存在的插件，因此默认情况下不会加载它们。打包游戏的 pak 文件包含一个 <*ProjectName*>.upluginmanifest 文件，其中包含所有已知插件的硬编码列表，而新的松散插件（<*ProjectName*>/Mods 文件夹内的插件除外）将不会被加载。但是，FPluginManager 将扫描磁盘上或 pak 文件内的其他 *.upluginmanifest 文件。如果 Pak 文件包含插件清单，则需要在启动时加载（在 PluginManager 加载之前）。如果通过清单检测到新插件，它将像任何内置插件一样被发现和处理。要自动启用并加载插件，需要在项目文件中启用插件或设置为 **EnabledByDefault**。通过项目文件启用它不会产生任何效果，因为打包 DLC 后不会更新/包含打包的项目文件。
### 封装根路径挂载

为了使插件内的任何资源都可访问，容器中资源的路径需要映射到包根路径（通常为 /<*DLCName*>/ ）。如果插件的 CanContainContent 设置为 true 并启用，这将在 FPluginManager::ConfigureEnabledPlugins 中发生。
### 包装装载

pak 文件的挂载也会在 FPluginManager::ConfigureEnabledPlugins 期间发生，其中 PluginManager 将加载插件的 <*ProjectName*>/Plugins/<*PluginName*>/Content/Paks/ 文件夹中找到的任何 pak 文件。
### 调试插件/DLC加载

要验证打包游戏是否加载了插件，请运行游戏 -LogCmds="LogPluginManager Verbose,LogPakFile Verbose" 并在日志中搜索 DLC 名称或术语 upluginmanifest 。 PluginManager 应该记录它是否找到了pluginmanifest 并加载了任何其他插件。以下是 UE5.5 中日志的摘录，其中包含与 DLC 加载相关的日志语句：

```
LogPluginManager: Mounting Project plugin DLC1
LogIoDispatcher: Display: Reading toc: ../../../DLCTest/Plugins/DLC1/Content/Paks/Windows/DLC1DLCTest-Windows.utoc
LogIoDispatcher: Display: Toc loaded : ../../../DLCTest/Plugins/DLC1/Content/Paks/Windows/DLC1DLCTest-Windows.utoc, Id=8561a3e5934ad865, Order=0, EntryCount=199, SignatureHash=0000000000000000000000000000000000000000
LogIoDispatcher: Display: Mounting container '../../../DLCTest/Plugins/DLC1/Content/Paks/Windows/DLC1DLCTest-Windows.utoc' in location slot 1
LogPakFile: Display: Mounted IoStore container "../../../DLCTest/Plugins/DLC1/Content/Paks/Windows/DLC1DLCTest-Windows.utoc"
LogPakFile: Display: Mounted Pak file '../../../DLCTest/Plugins/DLC1/Content/Paks/Windows/DLC1DLCTest-Windows.pak', mount point: '../../../'
LogConfig: Branch 'DLC1' had been unloaded. Reloading on-demand took 0.29ms
[2025.04.30-16.24.13:795][  0]LogShaderLibrary: Display: Using IoDispatcher for shader code library DLC1. Total 32 unique shaders.
[2025.04.30-16.24.13:795][  0]LogShaderLibrary: Display: Cooked Context: Using Shared Shader Library DLC1
[2025.04.30-16.24.13:795][  0]LogShaderLibrary: Display: Logical shader library 'DLC1' has been created as a monolithic library
```
### 调试控制台命令

还有一些额外的控制台命令可用于检查游戏的状态：描述 - PakList |这将列出所有已安装的 pak 文件。检查 DLC pak 文件是否在其中 - PackageName.DumpMountPoints | DLC 内的所有资产均位于 /*<DLCName>* 包根目录下。如果插件被检测到并正确加载，则应该为 DLC 创建相应的安装点。 - AssetRegistry.GetByPath /<*DLCName*> |有多种 AssetRegistry.* 命令可用于验证 AssetRegistry 是否了解 DLC 资产。 / 这列出了 AssetRegistry 已知的所有 DLC 资产，允许验证 DLC 内的 AssetRegistry.bin 是否已正确加载。
### 调试器中的断点

此外，游戏可以使用 **-waitforattach** 运行，以附加调试器并在启动过程中检查断点。断点的好位置是：FPakPlatformFile::Mount 以检查 pak 加载。 FPluginManager::ConfigureEnabledPlugins 检查是否检测到并启用插件。以下是 UE 5.5 中 **PluginManager.cpp** 行 **1759** 中的用于条件断点的代码片段。寻找：

```cpp
if (Plugin->IsEnabledByDefault(bAllowEnginePluginsEnabledByDefault) && !ConfiguredPluginNames.Contains(PluginName))
```

并设置断点，条件如下：

```cpp
wcscmp((wchar_t*)PluginName.Data.AllocatorInstance.Data,L"DLCName") == 0
```

这只会对名为“DLCName”的插件造成破坏，并且当ConfigureEnabledPlugins() 迭代插件列表时，可以在其他地方使用类似的模式。这允许轻松调试，而无需逐步加载一长串不相关的插件。
### 已知问题/陷阱：
### DLC 插件需要设置为默认启用

DLC 插件需要将**EnabledByDefault **选项设置为 true。一种简单的方法就是禁用插件并打包基本版本并禁用 DLC。但是，这将在 **打包的 **游戏内的 <*ProjectName*>.uproject 文件中创建一个条目，该条目将禁用该插件。如果稍后将 DLC 添加到游戏中，它将被检测到但不会加载，因为 uproject 文件已手动禁用该插件。这可以通过指定打包游戏的 EnabledPlugins=<*DLCName*> 启动参数来覆盖，但需要用户手动干预。
### 打包的 DLC 缺少插件清单：

此问题已在 5.6 版中修复，并且仅适用于早期的引擎版本。分阶段输出缺少 <*ProjectName*>/Plugins/DLCName.upluginmanifest 文件。那...
### 使用“-DLCPakPluginFile”打包会产生不正确的文件夹结构：

DLC Cook 使用此选项生成的默认 *<ProjectName>*/Plugins/*<DLCName>*/Content/Paks/*<PlatformName>*/ 目录结构不会触发自动 pak 加载，并且永远不会发现其他插件清单。 **要正确加载 DLC 容器文件，需要将其放入常规内容文件夹 ( <ProjectName>/Content/Paks/*<PlatformName>*/ )，引擎会自动将其安装在其中...
### DLC 不支持高级封装选项
### 常问问题：
### 如何为平台 X 设置 DLC？
### 如何将 DLC 包含或合并到游戏中？
## 相关链接

- [Primer: Loading Content and Pak files at runtime](https://forums.unrealengine.com/t/knowledge-base-primer-loading-content-and-pak-files-at-runtime/536669)


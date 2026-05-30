# 在虚幻引擎中创建与平台无关的 DLC (Part 1/2)

# 在虚幻引擎中创建与平台无关的 DLC (Part 1/2)

Source file: `creating-platform-agnostic-dlcs-in-unreal-engine.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/44nr/creating-platform-agnostic-dlcs-in-unreal-engine
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 18851 字符。
## 摘要

本文介绍了在虚幻引擎中创建与平台无关的 DLC 的过程
## 中文整理
### 什么是 DLC？

在虚幻引擎中，DLC 是添加到已发布游戏中的 **插件**。 DLC 被打包成一组单独的文件，只需将 DLC 文件复制到游戏文件夹中即可将其添加到打包的游戏中。虚幻引擎中的 DLC 可以包含**内容（资产）**和**蓝图**，但**不包含 C++ 代码**。代码需要成为基础游戏的一部分或作为 DLC 中的蓝图提供。 Unreal 的 DLC 实现中不包含权利概念，因为这需要特定于平台的集成。引擎将始终加载启动期间发现的任何 DLC。本指南仅具体描述了 Unreal 中与平台无关的流程，并未涉及如何在任何特定平台上管理 DLC。本文档分为两部分，第一部分解释了创建、打包和安装 DLC 到打包游戏中所需的所有步骤。第二部分讨论过程细节、调试技巧和问答。
### 命名法

在本文档中，我们使用 <*DLCName*> 或 <*ProjectName*> 样式的占位符来保持与任何特定项目/插件名称的不可知性。任何出现的这些内容都应替换为项目或插件/DLC 的名称，包括尖括号 (<>)。
### 第 1 部分：创建、打包和安装 DLC 插件
### 设置 DLC 插件

Unreal 中的 DLC 只是一个常规的纯内容插件，可以通过编辑器创建。首先在编辑器中创建插件并设置正确的默认值： 1. 从编辑 > 插件菜单中打开插件设置。 2. 单击“添加”创建新插件：

![教程图片](assets/creating-platform-agnostic-dlcs-in-unreal-engine/image-01.jpg)

3. 选择“仅内容”并填写插件的名称和元数据：

![教程图片](assets/creating-platform-agnostic-dlcs-in-unreal-engine/image-02.jpg)

4. 选择“创建插件” 5. 编辑 Plugins/*<PluginName>*/*<PluginName>*.uplugin 中的 .uplugin 文件，确保插件默认启用，否则运行时将无法加载。通过设置 "EnabledByDefault": "true" 来执行此操作

```
{
	"FileVersion": 3,
	"Version": 1,
	"VersionName": "1.0",
	"FriendlyName": "DLC1",
	"Description": "",
	"Category": "Other",
	"CreatedBy": "",
	"CreatedByURL": "",
	"DocsURL": "",
```

新插件现在将显示在内容浏览器中，并且可以在其内容根中创建内容。

![教程图片](assets/creating-platform-agnostic-dlcs-in-unreal-engine/image-03.jpg)

这就是在编辑器中准备 DLC 所需的全部内容。 DLC 的所有内容现在都应存储在内容浏览器的 **<*DLCName*> Content** 文件夹内。最好确保没有游戏内容使用任何对 DLC 内容的硬引用，否则在没有 DLC 的情况下烹饪游戏将会失败。
### 打包 DLC

创建 DLC 的所有内容后，即可将其打包。打包 DLC 分两个单独的步骤完成。 DLC 包需要首先创建“基础版本”，因此第一步始终是创建游戏的常规包，并使用附加标志来创建版本。发布版本将创建一个包含元数据和内容包的额外文件夹，以便它们可用于以后的补丁或 DLC。一旦基础版本可用，就可以通过 *UnrealAutomationTool* 中的 **BuildCookRun** 命令创建 DLC，就像常规构建或基础版本一样。 BuildCookRun 的以下参数与基础版本和 DLC 相关： - 命令 |描述--createreleaseversion=X |创建新的基础版本并将版本元数据输出到 *Releases/* 文件夹。发布版本不需要是数字，它可以是任何字符串，例如“发布-1.0”。 --basedonreleaseversion=x | | --basedonreleaseversion=x |必须与 *-DLCName* 一起指定此 DLC 所基于的基础版本。 - -DLC名称= |指定要打包为 DLC 的插件的名称。在 DLC 模式下，BuildCookRun 将仅烹饪/打包 DLC 内容，而不是基础内容。 - *高级：* -DLCPakPluginFile |指定标识 DLC 插件的文件（.uplugin 和 .upluginmanifest）是否应打包在容器 (pak) 文件内或作为松散文件打包。这会影响运行时检测 DLC 的方式。
### 创建基础版本

首先打包您的游戏并创建版本： 1. 如果 DLC 插件已经是您项目的一部分，请确保从您的 Plugins/ 文件夹中删除它。 2. 通过使用 -createreleaseversion=1.0 参数执行 **BuildCookRun** 来打包您的项目。您可以为一款游戏创建多个版本。如果您创建的版本基于另一个版本，您还应该添加 -basedonreleaseversion=X 参数，以使引擎了解先前的版本。 3. 这将在您的项目文件夹中创建一个目录 Releases\1.0\Windows，其中包含此版本的元数据。创建补丁和 DLC 需要此文件夹中的文件。打包基础版本时，必须从游戏中删除任何 DLC 插件！存在但被禁用的插件将无法工作，因为它会阻止在运行时加载 DLC！以下是为游戏创建基础版本的完整 **BuildCookRun ** 命令的示例：

```
D:\Path\to\UE\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -project=D:\Path\to\Project\Project.uproject -build -cook -stage -package -pak -createreleaseversion=1.0 -archive -archivedirectory=D:\Path\to\Project\Packages\BaseRelease\
```
### 基础版本元数据

在 Releases/<ReleaseVersion>/<Platform>/ 目录中，您将找到打包版本时创建的元数据。创建补丁或 DLC 时将使用这些文件来找出哪些资产属于基础版本，因此引擎可以确保仅包含在 DLC 或补丁的初始版本之后添加的文件。该文件夹包含以下文件： 1. AssetRegistry.bin：打包的 AssetRegistry 的副本。 2. <ProjectName>-<Platform>.pak/ucas/utoc：基础版本中容器文件的副本 3. 元数据文件夹，包含： 1. DevelopmentAssetRegistry.bin：基础版本的 AssetRegistry 编辑器版本的副本
### 打包 DLC 本身

打包 DLC 需要在您的项目中存在基本版本元数据，并且需要存在并启用 DLC 插件 1. 确保您的 DLC 插件已启用并且位于您的 Plugins/ 文件夹中。 2. 使用以下附加参数将项目打包到 **BuildCookRun**： 2. -basedonreleaseversion=1.0 -DLCName=DLC1 3. 打包 DLC 的输出文件夹由 -archivedirectory 参数指定。 4. **在 5.6 之前的引擎版本中：** 将文件 <*DLCName*>.upluginmanifest 从项目 Intermediate\Staging\<*PlatformName*> 文件夹复制到 DLC <*ProjectName*>/Plugins/ 文件夹中。以下是用于构建 DLC 的完整 **BuildCookRun ** 命令的示例：

```
D:\Path\to\UE\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -project=D:\Path\to\Project\Project.uproject -build -cook -stage -package -pak -DLCName=DLC1 -DLCPakPluginFile -basedonreleaseversion=1.0 -archive -archivedirectory=D:\Path\to\Project\Packages\BaseRelease\
```
### DLC 的文件结构

在存档目录中为成功打包的 DLC 创建的文件结构如下所示：

```
Manifest_UFSFiles_<Platform>.txt
Manifest_NonUFSFiles_<Platform>.txt
<ProjectName>/Plugins/<DLCName>.upluginmanifest
<ProjectName>/Plugins/<DLCName>/<DLCName>.uplugin
<PlatformName>/<ProjectName>/Plugins/<DLCName>/Content/Paks/<PlatformName>/<DLCName><ProjectName>-<Platform>.pak
<PlatformName>/<ProjectName>/Plugins/<DLCName>/Content/Paks/<PlatformName>/<DLCName><ProjectName>-<Platform>.utoc
<PlatformName>/<ProjectName>/Plugins/<DLCName>/Content/Paks/<PlatformName>/<DLCName><ProjectName>-<Platform>.ucas
```

- Manifest_[Non]UFSFiles_<Platform>.txt - 这些清单文件包含容器内部 (UFS) 和容器外部 (NonUFS) 的打包文件列表。 - *<PlatformName>***/*<ProjectName>*/Plugins/*<DLCName>*/Content/Paks/*<PlatformName>*/*<DLCName>**<DLCTest>*-*<Platform>*.pak/utoc/ucas - 包含 DLC 资源的实际容器文件。以下是名为 DLCTest 的项目中名为 DLC1 的 DLC 的 Windows 版本示例： - Windows\DLCTest\Plugins\DLC1\Content\Paks\Windows\DLC1DLCTest-Windows.pak - <ProjectName>/Plugins/<DLCName>.upluginmanifest - **upluginmanifest** 是 PluginManager 用于检测 DLC 的重要文件。打包的游戏仅在插件清单中声明或位于 Mods/ 目录内时才会加载新插件。当前版本的 Unreal（5.6 之前）不会暂存 <*DLCName*>.upluginmanifest 文件。需要手动复制到打包的DLC文件夹中。该文件应存在于 Intermediate\Staging\Win64 的暂存文件夹中，并且可以手动复制以使 <*ProjectName*>/Plugins/<*DLCName*> 中的 DLC 的默认文件夹结构正常工作。
### 向打包游戏添加 DLC

DLC 构建的文件结构可以按原样复制到打包的游戏中（如果已按上述方式添加了 .upluginmanifest 文件）。
### 在运行时加载 DLC 资源

没有专门了解 DLC 资产的内置功能。 [AssetRegistry](https://dev.epicgames.com/documentation/en-us/unreal-engine/asset-registry-in-unreal-engine) 是在运行时查找资产并将其过滤到相关资产的好方法。检测新 DLC 资产的常见做法是从特定基类中搜索资产（例如，获取从 **MyWeaponBase** 派生的所有资产），或者通过在 DLC 中包含一些元数据资产（通常是 DataAsset）来列出新 DLC 内容和有关 DLC 的附加信息。
### 第 2 部分：背景信息
### 其他资源

- [入门：在运行时加载内容和 Pak 文件](https://forums.unrealengine.com/t/knowledge-base-primer-loading-content-and-pak-files-at-runtime/536669)
### 通过项目启动器打包（已弃用）

[项目启动器](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-the-project-launcher-in-unreal-engine) 可用于创建两个配置文件，用于创建基础版本和 DLC 本身。此方法已被弃用，因为项目启动器将来将被新工具取代。创建自定义启动配置文件并选择 **Cook by the Book** 时，有一个名为 **Release / DLC / Patching Settings** 的部分，其中包含用于将上述 UAT 参数添加到 BuildCookRun 命令的文本字段和复选框。基本发行配置文件需要选中 **Create a release version of the game for distribution** 并填写 **要创建的新发行版本的名称** 字段。DLC 配置文件需要填写 **这是基于的发行版本**，输入 **DLC 的名称构建**并检查构建 DLC 选项。

![教程图片](assets/creating-platform-agnostic-dlcs-in-unreal-engine/image-04.jpg)
### 使用 -DLCPakPluginFile 打包

DLC 的打包过程还可以使用名为 -DLCPakPluginFile 的附加 **BuildCookRun ** 参数来运行，该参数会更改 DLC 的打包方式。如果使用此选项，*.upluginmanifest 和 *.uplugin 文件将位于 pak 文件内，而不是其他 DLC 文件旁边的常规文件。这样做的优点是 DLC 仅包含容器文件，并且插件加载不需要创建的文件夹结构。将插件文件移入 pak 的含义是，现在需要提前加载 DLC 的 pak 文件，以便 PluginManager 可以在 pak 文件中找到 <*DLCName*>.upluginmanifest。这意味着容器文件需要放置在常规游戏内容旁边，而不是放置在插件特定目录内。要正确加载此类 DLC，容器文件 (pak/utoc/ucas) 需要放置在 <*ProjectName*>/Content/Paks/ 内，而不是放置在 <*ProjectName*>/Plugins/... 文件夹内。
### 游戏如何在启动时加载/检测 DLC？

要使 DLC/插件的内容在运行时可用，需要执行 3 个步骤。


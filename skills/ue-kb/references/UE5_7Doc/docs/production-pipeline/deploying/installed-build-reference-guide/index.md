---
title: "使用安装构建版本"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/installed-build-reference-guide-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "使用安装构建版本"]
---

# 使用安装构建版本

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / 使用安装构建版本

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/installed-build-reference-guide-for-unreal-engine

开发者一直在寻找能够高效交付适用于各种硬件配置文件和操作系统的构建解决方案的方法。 **安装构建版本** 是一个全功能引擎构建版本，你可以快速重新分发它，以为团队启动和运行引擎。从技术角度来看，安装构建版本包含适用于虚幻编辑器的预编译二进制文件和适用于开发中的每个目标平台和发布配置的静态库。

安装构建版本过程自动处理生成虚幻引擎的安装构建版本所需的构建版本包和工具。总的来说，生成安装构建版本是设置默认目标平台，使用其工具和编辑器编译UE，运行测试，以及将UE4的安装构建版本部署到目标平台的过程。

> [!NOTE]
> 除生成你自己的构建版本之外，你还可以从我们的启动程序下载UE，具体参见[下载虚幻引擎源代码](../../../get-started/install/downloading-source-code/index.md)。

## 制作安装构建版本

你可以使用[BuildGraph](../../using-the-unreal-engine-build-pipeline/unreal-automation-tool/buildgraph/index.md)脚本编写系统创建安装构建版本，安装构建脚本与你的已下载源代码位于 `[UERoot]/Engine/Build/InstalledBuild.xml` 文件夹中。

**要创建安装构建版本，请执行以下操作：**

1. 在你的系统中打开 **命令提示符（Command Prompt）** ；
2. 输入命令行，通过调用 **AutomationTool** 运行安装构建版本脚本。命令行如下所示（将 `[PLATFORM]` 替换为 `Win64` 或 `Mac` ，具体视你的系统而定）：

   ```
       C:\EpicSource\UE_5.5\UnrealEngine-5.5\Engine\Build\BatchFiles\RunUAT.bat BuildGraph -target="Make Installed Build [PLATFORM]" -script="Engine/Build/InstalledEngineBuild.xml" -clean 
   ```

   了解此命令行的组成部分：

   - C:\EpicSource\UE_5.5\UnrealEngine-5.5\

     - 已下载源代码的位置（在你的PC上可能不一样）。
   - Engine\Build\BatchFiles\RunUAT.bat

     - 虚幻自动化工具命令文件的位置，即你用于构建命令的文件。
   - -target="Make Installed Build [PLATFORM]"

     - 你想要构建引擎的目标平台（将

     [PLATFORM]

     替换为

     Win64

     、

     Linux

     、

     Mac

     ）。
   - -script=Engine/Build/InstalledEngineBuild.xml

     - 包含安装流程选项的文件的位置。
   - 此外，你还可以调整其他

     安装构建版本脚本选项

     。

   > [!NOTE]
   > 如果你使用其他[安装构建版本脚本选项](#%E5%AE%89%E8%A3%85%E6%9E%84%E5%BB%BA%E7%89%88%E6%9C%AC%E8%84%9A%E6%9C%AC%E9%80%89%E9%A1%B9)，你的代码将如下所示（具体视你调整的设置而定）：
   >
   > ```
   >         C:\EpicSource\UE_5.5\UnrealEngine-5.5\Engine\Build\BatchFiles\RunUAT.bat BuildGraph -target="Make Installed Build [PLATFORM]" -script="Engine/Build/InstalledEngineBuild.xml" -set:WithWin64=true -set:WithMac=true -set:WithTVOS=false -set:WithLinux=false -set:WithHTML5=true 
   > ```
3. 默认情况下，你的安装构建版本应位于虚幻引擎目录的 `LocalBuilds/Engine/` 文件夹中。如果你指定了其他发布目录，则找到该目录即可。

## 安装构建版本脚本选项

`InstalledEngineBuild.xml` 脚本将创建安装构建版本，其中会启用所有默认选项和平台。但你可以使用一组指定的选项来配置构建版本。这些选项可提供更多控制，如确定包含哪些平台，以及在哪里发布构建版本。

通过将 `-listonly` 选项传递到脚本，你可以查看自定义构建流程的可用选项列表（以及默认构建的节点列表）。

可用选项如下表所列。

| 选项 | 默认 | 说明 |
| --- | --- | --- |
| `-set:HostPlatformOnly=[true/false]` | false | 一个让安装构建版本仅用于你的主机平台的辅助选项，这样你不用单独禁用每个平台。 |
| `-set:WithWin64=[true/false]` | true | 包含Win64目标平台。 |
| `-set:WithWin32=[true/false]` | true | 包含Win32目标平台。 |
| `-set:WithMac=[true/false]` | true | 包含Mac目标平台。 |
| `-set:WithAndroid=[true/false]` | true | 包含Android目标平台。 |
| `-set:WithIOS=[true/false]` | true | 包括iOS目标平台。 要启用该选项，需要将Mac设置为允许远程构建。 |
| `-set:WithTVOS=[true/false]` | true | 包括tvOS目标平台。 要启用该选项，需要将Mac设置为允许远程构建。 |
| `-set:WithLinux=[true/false]` | true | 包含Linux目标平台。 |
| `-set:WithLinuxArm64[true/false]` | true | 包含Linux Arm64目标平台。 |
| `-set:WithPS4=[true/false]` | false | 包括PS4目标平台。 需要具有PS4 SDK才能启用该选项。 |
| `-set:WithPS5=[true/false]` | false | 包含PS5目标平台。 启用此选项需要PS5 SDK。 |
| `-set:WithSwitch=[true/false]` | false | 包含Switch目标平台。 启用此选项需要SwitchSDK。 |
| `-set:WithXboxOneGDK=[true/false]` | false | 包含旧版WithXboxOneGDK目标。 启用此选项需要Xbox One SDK。 |
| `-set:WithGDK=[true/false]` | false | 包含GDK目标平台。 启用此选项需要GDK。 |
| `-set:WithXB1=[true/false]` | false | 包含XB1目标平台。 启用此选项需要XB1 XDK。 |
| `-set:WithWinGDK=[true/false]` | false | 包含WinGDK目标平台。 启用此选项需要WinGDK。 |
| `-set:WithXSX=[true/false]` | false | 包含XSX目标平台。 |
| `-set:WithDDC=[true/false]` | true | 为引擎内容和模板构建独立衍生数据缓存。 为引擎和模板内容构建独立[衍生数据缓存（DDC）](../../using-derived-data-cache/index.md)可能是构建过程中最耗时的部分。如不需要独立DDC，可通过在命令行后添加 `-set:WithDDC=false` 来跳过该步骤。 |
| `-set:HostPlatformDDCOnly=[true/false]` | true | 是否仅对主机平台包含DDC。 |
| `-set:WithClient=[true/false]` | false | 包含预编译客户端目标。 |
| `-set:WithServer=[true/false]` | false | 包含预编译服务器目标。 |
| `-set:WithFullDebugInfo=[true/false]` | false | 生成二进制编辑器和打包应用构建的完整调试信息。 |
| `-set:SignExecutables=[true/false]` | false | 作为构建流程的一部分，当你必须设置计算机对可执行文件签名时，对生成的可执行文件签名。 |
| `-set:AnalyticsTypeOverride=[ID]` | 无默认值 | 要发送分析事件的标识符。 |
| ` -set:EmbedSrcSrvInfotrue/false` | false | 是否向Windows游戏应用添加源索引，以便可以将应用添加到符号服务器。 |
| `-set:AllowParallelExecutor=[true/false]` | false | 编译时允许使用UAT的ParallelExecutor。 |
| `-set:GameConfigurations=[Configurations]` | Shipping;Development;DebugGame | 指定打包应用的配置。 |
| `-set:SignWindowsExecutablesInParallel=[true/false]` | false | 对可执行文件进行并行签名，仅限Windows。 |
| `-set:ExtraCompileArgs` | 无默认值 | 传递给在非基于Mac的平台上运行的编译器的额外参数。用于启用类似UBA的功能。 |
| `-set:Extra arguments to pass to compiles run on Mac platforms` | 无默认值 | 传递给在基于Mac的平台上运行的编译器的额外参数。用于启用类似UBA的功能。 |
| `-set:ExtraDDCArgs` | 无默认值 | 传递给DDC生成器的额外参数。用于启用类似UBA的功能。 |

### 包括额外文件

RuntimeDependencies（针对每个模块，在 `build.cs` 文件中设置）自动对照并确定要在安装构建版本中包括哪些文件。但是，无法通过这种方式包括某些必需文件，因此需要在 `[UERoot]/Engine/Build/InstalledEngineFilters.xml` 中定义它们。 `InstalledEngineFilters` XML 文件也会列出应从该构建版本中排除的文件模式，确定需要剥离或签名的文件类型以及要为哪些项目构建DDC。如果需要在安装构建版本中包括额外文件，可以首先考虑 `InstalledEngineFilters` XML 文件。

## 注册安装构建版本

UE具有"外部"项目和"非外部"项目的概念。外部项目是存储在非引擎目录树中的项目，非外部项目是存储在引擎根的子目录中的项目（通过 `UEGames.uprojectdirs` 扩展名引用）。

`.uproject` 文件中的"EngineAssociation"字段可标识哪个编辑器版本可打开项目。对于非外部项目，它为空白，因为"非外部"暗示在（已知的）相对位置中存在编辑器（在项目目录层级的高处）。对于使用由启动程序安装的引擎构建版本的外部项目，该字段中会包含正式版本号（例如"5.5"），启动程序可基于其已安装的应用程序列表查找相应的编辑器二进制文件（假定已安装）。对于使用通过启动程序以外的其他方式分发的引擎构建版本的外部项目，可以使用引擎构建版本随机唯一辨识符，通过可全局访问的数据元库（具体来说，Windows上的注册表或Mac上的库文件夹中的文件）查找安装目录。如果找不到已安装编辑器构建版本的关联，将提示用户选择版本，然后，将使用所选择的版本更新 `.uproject` 文件。

向团队分发安装构建版本时，请确保每个人的构建版本辨识符都相同。这将阻止编辑器提示用户选择版本，然后使用本地生成的唯一辨识符更新 `.uproject` 文件。可按照以下方法设置自定义辨识符：

- 在 **Windows** 中，向将你的辨识符用作其项的 `HKEY_CURRENT_USER\SOFTWARE\Epic Games\UnrealEngine\Builds` 添加注册表项，并将引擎路径作为其值。例如，项可以是 `MyCustom419` ，值可以是 `D:\CustomUE` 。
- 在 **Mac** 中，打开 `/Users/MyName/Library/Application Support/Epic/UnrealEngine/Install.ini` ，然后向将你的辨识符用作项的 `[Installations]` 部分添加条目，并将引擎路径作为值。例如：

  ```
          [Installations]        MyCustom419 = /Users/MyName/CustomUE		
  ```

## 选择该部署方法

如果你极少需要更改引擎，而且在寻找能够快速高效交付适用于各种硬件配置文件和操作系统的构建解决方案的方法，可以部署UE的安装构建版本，或者从我们的启动程序下载引擎。

但请注意，如果你不是在寻找可安装在C:\Program Files下的UE只读分发，那么该方法并不适合你，主要原因在于它是为了创建独立、只读的引擎内容、源代码和第三方库而设计的。虽然我们通过Epic Games启动程序免费提供安装的引擎构建版本，但是我们内部的游戏团队并不使用该方法。另外，我们将其视作独立的部署产品。

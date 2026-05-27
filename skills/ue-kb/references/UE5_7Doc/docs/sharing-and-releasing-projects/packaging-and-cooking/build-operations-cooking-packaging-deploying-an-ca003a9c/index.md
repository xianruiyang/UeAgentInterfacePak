---
title: "构建操作：烘焙、打包、部署、运行"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/build-operations-cooking-packaging-deploying-and-running-projects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "游戏的打包（Packaging）和烘焙（Cooking）", "构建操作：烘焙、打包、部署、运行"]
---

# 构建操作：烘焙、打包、部署、运行

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 游戏的打包（Packaging）和烘焙（Cooking） / 构建操作：烘焙、打包、部署、运行

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/build-operations-cooking-packaging-deploying-and-running-projects-in-unreal-engine

在打包过程中使用的[自动化工具](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-automation-tool/index.md)（有时简称 **UAT** ，全称为 **Unreal Automation Tool（虚幻自动化工具）** ）用于通过一组实用脚本来操控 **虚幻引擎（UE）** 项目。对于打包过程，自动化工具使用特定命令 **BuildCookRun** 。此命令可以针对平台烘焙内容，将其打包成平台的原生格式进行发布、部署到设备并自动运行项目（如果适用）。但打包项目并非只能直接使用UAT。你也可以使用UE **工具栏（Toolbar）** 的 **平台（Platforms）** 按钮从可用平台中选择，或使用命令行为平台烘焙和打包内容。

以下是打包管线的不同阶段，也是UAT中 **BuildCookRun** 命令的组成部分：

- 构建：

  此阶段会为所选平台编译可执行文件。
- 烘焙：

  此阶段会在特殊模式下执行UE，以此烘焙内容。
- 暂存：

  此阶段会将可执行文件和内容复制到暂存区域，即开发目录之外的一个独立目录。
- 打包：

  此阶段会将项目打包成平台的原生发布格式。
- 部署：

  此阶段会将版本部署到目标设备。
- 运行：

  此阶段会在目标平台上启动已打包的项目。

> [!TIP]
> 如需查看预定义任务的列表，请阅读[BuildGraph脚本任务](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-automation-tool/buildgraph/buildgraph-script-anatomy/buildgraph-script-tasks-reference/index.md)参考页面。

## 打包方法

你可以采用多种方式将内容部署到目标平台，以便测试、调试或准备发布，因此你可以多种方式测试你的程序包：

- 你可以使用

  UE工具栏

  快速测试部分当前已加载的

  关卡

  ，以便测试和调试。
- 你可以使用

  项目启动程序

  来使用默认配置文件或创建自定义配置文件，对项目的最新版本执行分析或调试等操作。
- 你可以将已打包的游戏部署到平台，如主机或移动设备。

参阅以下小节，详细了解这些打包方法，以及如何将其用于打包你的游戏。

### UE工具栏

使用UE **工具栏（Toolbar）** 的 **平台（Platforms）** 按钮选择你打包的项目所面向的平台。使用此选项打包项目时，它会将打包的项目保存到你选择的文件夹，但不会将其部署到设备。

在 **平台（Platforms）** 下的下拉菜单中，你可以执行以下操作：

- 在你需要的可用设备上构建并启动项目。点击后，启动进程会自动烘焙必要的内容、编译代码并在选定平台上启动。该版本使你能够快速测试正在积极开发的功能，不必在每次要测试时都编译并运行整个项目。
- 选择目标平台并为其调整 **编译配置（Build Configuration）** （ **开发（Development）** 、 **发行（Shipping）** 等）。

  > [!WARNING]
  > UE 5.4.0中存在一个已知问题，即如果你尝试用"使用项目设置（Use Project Setting）"选项打包项目，它会使用编辑器启动时 *项目设置（Project Settings）**>**打包（Packaging）** 中设定好的配置，即使你后来更改过它。为了解决此问题，请重启编辑器，以确保新的编译配置生效，或者从平台（Platform）菜单选择一个二进制文件配置，而不是使用项目设置。此问题在UE 5.4.1中已得到解决。
- 访问 **项目启动程序（Project Launcher）** 、 **设备管理器（Device Manager）** 、 **打包设置（Packaging Settings）** 和 **支持的平台（Supported Platforms）** 。

> [!NOTE]
> 若未看到想要部署到的平台，或者该平台在此菜单中显示为灰色，可以检查以下方面：
>
> - 请确保已为该平台安装了正确的SDK（如果需要），并且当前使用的引擎版本支持该SDK。通常，可以在平台的
>
>   UEBuild.cs
>
>   文件中检查此项，该文件位于
>
>   Engine/Source/Programmings/UnrealBuiltTools/Platforms
>
>   中。例如，如果你需要查看哪个SDK支持Android，可以查看
>
>   UEBuildAndroid.cs
>
>   文件。
> - 请确保安装了所有Visual Studio扩展或必要文件。
> - 部分平台（例如，主机）要求使用外部工具来连接设备。请确保外部工具可正常工作，并检测到了设备。
> - 使用引擎中的
>
>   设备管理器（Device Manager）
>
>   酌情"认领"设备，确保它只能用于你的本地计算机。

### 项目启动程序

[项目启动程序](../preparing-unreal-engine-projects-for-release/index.md)可让你从单个位置甚至从单个启动配置文件向不同的平台部署。要打开项目启动程序，请点击 **平台（Platforms）> 项目启动程序（Project Launcher）** 。

部署过的每个平台都会有自己的默认启动配置文件（在主窗口中列出）。你还可以选择创建自定义配置文件，这样就可以利用许多高级设置按特定方式构建项目。其中包括能够应用命令行参数、测试可下载内容（DLC）和修补版本等等。

> [!NOTE]
> 如需更多信息，请参阅[项目启动程序](../using-the-project-launcher/index.md)参考页面。

#### 自定义启动配置文件

在项目启动程序中，你可以创建可在所有平台或仅在你指定的平台上使用的 **自定义启动配置文件（Custom Launch Profile）** 。你可以在配置文件中设置如何使用可用构建操作来烘焙、打包、部署内容，从而以特定方式构建你的内容。

要添加你自己的自定义启动配置文件（Custom Launch Profile），请点击窗口右侧的 **添加（Add）** 按钮。

点击后，自定义启动配置文件将立即打开。请务必为其指定 **名称（Name）** 和 **说明（Description）** ，以便日后快速辨认。

### 命令行

[自动化工具](../../../testing-and-optimizing-content/automation-test-framework/index.md)让你能够使用命令行来烘焙和打包游戏，由于所有构建操作都由UAT执行，如果提供有效的参数，可以使用 **RunUAT.bat** 文件直接在命令行上运行它。

> [!NOTE]
> RunUAT文件可以在 `Engine/Build/BatchFiles` 中找到。Windows操作系统请使用 **RunUAT.bat** 文件，而Mac/Linux操作系统使用 **RunUAT.sh** 文件。

可以在 **UnrealEditor.exe** 或 **UnrealEditor-cmd.exe** 文件后使用以下命令行参数来执行基本烘焙：

```
	UnrealEditor.exe [GameName or .uproject] -run=cook -targetplatform=[Platform] -cookonthefly -map=[Map Name]
```

必须通过 **-run=cook** 指定commandlet，并且必须指定烘焙所面向的平台。它将为指定的平台生成烘焙的数据，并将其保存到以下位置：

```
	[UnrealEditor Project]/Saved/Sandboxes/Cooked-[Platform] 
```

手动编写命令行参数可能相当复杂，而且更有可能产生意外错误。因此，建议使用[自定义启动配置文件](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%90%AF%E5%8A%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)为你的构建准确地生成命令行。在用于烘焙和构建项目时，在自定义启动配置文件中输入的参数都将在 **输出日志（Output Log）** 窗口中自动生成并显示命令行。从 **BuildCookRun** 起的文本都可以作为命令行参数使用 **RunUAT.bat** 直接传递。

下例是从项目启动程序生成的输出，以及需要手动编写才能用于 **RunUAT.bat** 的等效命令行：

- **项目启动程序日志窗口**

  ```
            Automation.ParseCommandLine: Parsing Command Line: -ScriptsForProject=MyProject.uproject BuildCookRun -project=MyProject.uproject -clientconfig=Development		
  ```
- **手动编写**

  ```
            [UnrealEngineRoot]/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -project=MyProject.uproject -clientconfig=Development		
  ```

> [!NOTE]
> 如需更多信息，请参阅[内容烘焙](../cooking-content/index.md)页面。

## 内容烘焙

在UE中，内容以平台支持的特定格式存储（纹理数据为PNG，音频为WAV）。但此内容的格式可能不适用于你的开发目标平台。**烘焙** 过程会将UE使用的 **资产** 转换成可在内部部署到的平台上读取的资产。在某些情况下，烘焙的内容会被转换为只能由该平台读取的专有格式（比如主机专有格式）。

可以使用[命令行](#%E5%91%BD%E4%BB%A4%E8%A1%8C)或使用[项目启动程序](#%E9%A1%B9%E7%9B%AE%E5%90%AF%E5%8A%A8%E7%A8%8B%E5%BA%8F)及其UE界面为不同平台烘焙内容。对于部分平台，必须先烘焙所有内容，然后才能在设备上正常使用内容。你可能需要确认你的开发目标平台是否属于这种情况。

为你的项目烘焙内容的方法有两种：**按常规（By the book）** 和 **即时（On the fly）** 。

### 按常规烘焙

**按常规烘焙（CBTB）** 会提前执行整个烘焙过程，让此版本可以一次性部署所有已烘焙的资产，而不是在运行关卡时按需部署（如果你使用的是烘焙服务器）。若开发人员不对单个资产进行迭代，或希望游戏全速运行而无需等待服务器提供必要的已烘焙内容，则此选项非常有用。通常，性能测试和可玩性测试需要使用此方法。

执行按常规烘焙时，此版本无需额外的设置。使用项目启动程序[创建自定义启动配置文件](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%90%AF%E5%8A%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)，并在 **烘焙（Cook）** 分段中，使用下拉选项选择 **按常规（By the book）** 。

如果你要添加游戏特有的命令行，可以展开 **高级设置（Advanced Settings）** ，然后将参数添加到 **额外烘焙器选项（Additional Cooker Options）** 。

例如：

```
	-nomcp
```

> [!NOTE]
> 如需有关此烘焙方法及其可用设置的更多信息，请参阅[项目启动程序](../using-the-project-launcher/index.md#%E6%8C%89%E5%B8%B8%E8%A7%84)参考页面。

### 即时烘焙

当你选择 **即时烘焙内容（COTF）** 时，系统会将内容烘焙推迟到游戏部署到平台之后。这种情况下只会安装可执行文件和一些其他基本文件，并使用与 **烘焙服务器** 之间的网络通信在需要内容时按需发出请求。若开发人员经常更改内容，或者只探究游戏的一些片段，COTF可以加快迭代速度。

要进行即时烘焙，你首先需要在拥有完整项目的计算机上启动烘焙服务器。该计算机可以是你的本地计算机，也可以是执行烘焙的远程服务器。运行烘焙服务器的方法是，对 **UnrealEditor-cmd.exe** 使用以下参数，在命令行模式下启动UE：

```
		UnrealEditor-cmd.exe [FullAbsolutePathToProject.uproject]-run=cook -targetplatform=Windows -cookonthefly 
```

在开发人员的本地计算机上，从项目启动程序访问[自定义启动配置文件](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%90%AF%E5%8A%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)，并在 **部署（Deploy）** 分段中将方法设置为 **文件服务器（File Server）** 。你也可以选择使用 **默认部署平台（Default Deploy Platform）** 来选择单个平台，或使用切换键来启用要构建和部署到的多个平台。

为使可执行文件知晓从何处加载内容，需要使其知道运行烘焙服务器的机器的IP地址。为此，你需要在客户端的命令行上传递以下命令行参数（其中x.x.x.x表示主机的IP地址）：

```
	-filehostip=123.456.78.90 
```

该参数可在你的自定义启动配置文件中 **启动（Launch）** 分段下的 **其他命令行参数（Additional Command Line Parameters）** 文本框中指定。如果不指定IP地址，此版本将从现有本地文件加载，而不会尝试连接到烘焙服务器。

> [!NOTE]
> 如需有关此烘焙方法及其可用设置的更多信息，请参阅[项目启动程序](../using-the-project-launcher/index.md#%E5%8D%B3%E6%97%B6)参考页面。

## 部署构建

要从项目启动程序部署构建，你必须拥有已烘焙并打包的项目。有几种方法可以将此类型的构建部署到平台。在你的[自定义启动配置文件](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%90%AF%E5%8A%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6) **部署（Deploy）** 分段下，设置你希望用于部署此版本的方式。

- 文件服务器（File Server）

  将在运行时根据设备需要烘焙和部署内容。
- 复制到设备（Copy to Device）

  会将整个已烘焙构建复制到设备。
- 不部署（Do Not Deploy）

  在烘焙和打包完成后不会将此版本部署到设备。
- 复制仓库（Copy Repository）

  将从指定的文件位置复制构建以部署到设备。

> [!NOTE]
> 如需有关这些部署方法及其可用设置的更多信息，请参阅[项目启动程序](../using-the-project-launcher/index.md#%E9%83%A8%E7%BD%B2)参考页面。

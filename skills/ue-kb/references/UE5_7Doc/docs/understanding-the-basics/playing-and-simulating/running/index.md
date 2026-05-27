---
title: "运行虚幻引擎"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/running-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "运行和模拟", "运行虚幻引擎"]
---

# 运行虚幻引擎

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 运行和模拟 / 运行虚幻引擎

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/running-unreal-engine

选择操作系统：

Windows

macOS

Linux

![RunningUnrealEngineHeroImage_01.png](../../../../assets/images/4c/4c8d69c82197f0f3d7ec2ac2dbd99ba942610defa7a253075f445e1f211d86ee.jpg)

本文所述方法只针对使用 **开发（Development）** 模式构建的项目。假如你采用了其他构建模式，请视情况将指令替换成 `UEEditor-_.exe` 或 `UE-_.exe`。有关二进制版本的命名规范，请参阅[编译虚幻引擎](../../../get-started/install/downloading-source-code/building-unreal-engine-from-source/index.md)。

![RunningUnrealEngineHeroImage_01.png](../../../../assets/images/4c/4c8d69c82197f0f3d7ec2ac2dbd99ba942610defa7a253075f445e1f211d86ee.jpg)

本文所述方法只针对使用 **开发（Development）** 模式构建的项目。假如你采用了其他构建模式，请视情况将指令替换成 `UE5Editor-_.app` 或 `UE5-_.app`。有关二进制版本的命名规范，请参阅[编译虚幻引擎](../../../get-started/install/downloading-source-code/building-unreal-engine-from-source/index.md)。

## 运行编辑器

如需运行编辑器，需要将项目名称作为参数传递给可执行文件。

> [!NOTE]
> 你可以添加 `-debug` 参数，让可执行文件强制加载项目模块的调试版本，该版本包含所有调试符号。由于主可执行文件固定使用 **开发** 配置进行编译，因此即便你在Xcode中将配置设为 **调试**，你仍需传递debug参数。当然，你必须首先用调试配置编译模块，以便可执行文件进行加载。

如需运行编辑器，需要将项目名称作为参数传递给可执行文件。

> [!NOTE]
> 你可以添加 `-debug` 参数，让可执行文件强制加载项目模块的调试版本，该版本包含所有调试符号。由于主可执行文件固定使用 **开发** 配置进行编译，因此即便你在Visual Studio中将配置设为 **调试**，你仍需传递debug参数。当然，你必须首先用调试配置编译模块，以便可执行文件进行加载。

### 通过命令行运行编辑器

1. 打开命令行窗口，导航至 `[LauncherInstall]/[VersionNumber]/Engine/Binaries/Mac` 目录。
2. 运行 `UEEditor.app`，并传递项目路径：

   ```
           open UEEditor.app --args "[ProjectPath]/[ProjectName].uproject"		
   ```

1. 打开命令行窗口，导航至 `[LauncherInstall][VersionNumber]\Engine\Binaries\Win64` 目录。
2. 运行 `UEEditor.exe`，并传递项目路径：

   ```
           UEEditor.exe "[ProjectPath][ProjectName].uproject"		
   ```

### 通过可执行文件运行编辑器

1. 导航至 `[LauncherInstall][VersionNumber]\Engine\Binaries\Win64` 目录。
2. 右键单击 `UEEditor.exe` 可执行文件并选择 **创建快捷方式**。
3. 将快捷方式重命名为例如 **MyProject - Editor.exe** 这类命名，以表明该快捷方式运行MyProject游戏编辑器。
4. 右键单击新建快捷方式并选择 **属性**。
5. 在 **目标（Target）** 属性末尾添加作为参数运行的游戏名称：

   ```
           [LauncherInstall][VersionNumber]\Engine\Binaries\Win64\UEEditor.exe "[ProjectPath][ProjectName].uproject"		
   ```
6. 按下 **OK** 保存更改。
7. **双击** 快捷方式以启动编辑器。

须[使用命令提示符](#%E4%BD%BF%E7%94%A8%E5%91%BD%E4%BB%A4%E8%A1%8C%E8%BF%90%E8%A1%8C%E7%BC%96%E8%BE%91%E5%99%A8)运行编辑器才能直接或 [不使用参数](#runningtheeditorwithnoarguments_stand-alone_)加载指定项目，以访问项目浏览器。

### 不使用参数(Stand-alone)运行编辑器

假如你未设置编辑器在启动时打开最近的项目，以无参模式运行编辑器可执行文件会直接打开项目浏览器。在此可 [新建项目](../../working-with-projects-and-templates/creating-a-new-project/index.md)、[打开现有项目](../../working-with-projects-and-templates/creating-a-new-project/index.md) ，或者打开[内容范例和和示例游戏](../../../samples-and-tutorials/index.md)。

## 运行未烘焙游戏

在虚幻编辑器中加载项目后，便可使用 **运行方式（Play In）** 菜单在未烘焙游戏（Uncooked Game）模式下[测试gameplay](../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#%E6%A8%A1%E5%BC%8F)。要在未烘焙游戏自带窗口中运行游戏，请使用关卡编辑器工具栏中的[在下拉菜单中运行](../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#%E5%B7%A5%E5%85%B7%E6%A0%8F)以选择[新窗口位于（New Window At）> 玩家默认起始模式（Default Player Start Mode）](../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#%E6%A8%A1%E5%BC%8F)。

![undefined](../../../../assets/images/c9/c92a5f4709583aa36801b522a977550bf4e99a933de93ab706cb5c8f8f18e768.png)

*点击查看大图：*

使用以下任一方法来运行未烘焙过的游戏都会产生相同的行为。

### 使用命令行运行未烘焙游戏

使用命令行运行时，必须将要运行的项目名称及 `-game` 作为参数传递。

1. 使用命令行，导航至 `[LauncherInstall][VersionNumber]\Engine\Binaries\Win64` 目录。
2. 运行 **UEEditor.exe**，并向其传递要运行的项目路径及 `-game` 参数。

   ```
           UEEditor.exe "[ProjectPath][ProjectName].uproject" -game		
   ```

1. 使用命令行，导航至 `[LauncherInstall][VersionNumber]/Engine/Binaries/Mac` 目录。
2. 运行 **UEEditor.app**，并向其传递要运行的项目路径及 `-game` 参数

   ```
           open UEEditor.app --args "[ProjectPath]/[ProjectName].uproject" -game		
   ```

### 通过可执行文件运行未烘焙游戏

通过可执行文件运行时，你必须在快捷方式的 **目标（Target）** 属性中，指定要运行的项目路径，并传递 `-game` 作为参数。

1. 导航至 `[LauncherInstall][VersionNumber]\Engine\Binaries\Win64` 目录。
2. **右键单击** **UEEditor.exe** 可执行文件并选择 **创建快捷方式**。
3. 重命名快捷方式以表明反映其将运行的游戏，即 **MyProject.exe**。
4. **右键单击** 新建快捷方式，选择 **属性** 以显示快捷方式的属性。
5. 在 **目标** 属性末尾添加要作为参数运行的项目完整路径，并指定要作为游戏运行的 `-game` 参数：

   ```
           [LauncherInstall][VersionNumber]\Engine\Binaries\Win64\UEEditor.exe "[ProjectPath][ProjectName].uproject" -game		
   ```
6. 按下 **OK** 保存更改。
7. **双击** 快捷方式运行游戏。

须[使用命令行](#%E4%BD%BF%E7%94%A8%E5%91%BD%E4%BB%A4%E8%A1%8C%E8%BF%90%E8%A1%8C%E7%BC%96%E8%BE%91%E5%99%A8)运行编辑器才能直接加载指定项目。

## 运行烘焙游戏

欲了解打包和运行烘焙游戏版本的相关方法，参见[打包项目](https://dev.epicgames.com/documentation/404)

## 实用游戏命令

运行游戏时，有众多 **主机命令** 可用于游戏控制台中 。按 **~（波浪符）** 或 **Tab** 键可打开控制台。下方列出了部分实用命令。

- `EXIT/QUIT`
- `DISCONNECT`
- `OPEN [MapURL]`
- `TRAVEL [MapURL]`
- `VIEWMODE [Mode]`

## 加载地图

运行引擎或编辑器时，可以指定要加载的地图，或者指定加载新地图。这样你就能直接打开要测试的地图，避免了许多麻烦。

### 启动时加载地图

引擎每次运行时都会尝试打开一张默认地图。你可以在 `DefaultEngine.ini` 配置文件中指定该地图，此文件位于游戏项目的"Config"文件夹中。默认情况下，你可以通过 ini. 文件 `[URL]` 部分中的 **地图** 属性来设置要运行的地图。例如，Vehicle Game的 `DefaultEngine.ini` 文件进行下列设置：

```
	GameDefaultMap=/Game/Maps/MyMap 
```

此设置将确保 `MyMap.umap`（位于 `(UE4Directory)/(YourProjectName)/Content/Maps`）在启动时自动加载，除非其被覆盖。通常，你可以将指定要加载的地图或主菜单地图作为默认加载地图。

要覆盖默认地图，可将地图命名（无需文件扩展名）作为命令行参数传入。在上文中提到过，你必须在命令行中指定项目名称。你还可以指定地图名称，以强制引擎加载其他地图。例如，以下命令行能让引擎加载 `ExampleMap` 地图：

```
	open UEEditor.app --args "[ProjectPath]/[ProjectName].uproject" ExampleMap -game 
```

要覆盖默认地图，可将地图命名（无需文件扩展名）作为命令行参数传入。在上文中提到过，你必须在命令行中指定项目名称。你还可以指定地图名称，以强制引擎加载其他地图。例如，以下命令行能让引擎加载 `ExampleMap` 地图：

```
	UEEditor.exe "[ProjectPath][ProjectName].uproject" ExampleMap -game 
```

上述方法对于编辑器运行也适用。编辑器打开时，你可以指定要加载的地图名称，以便加载此地图，而非默认或空白地图。如需运行编辑器并加载 `ExampleMap` 地图，可使用以下命令行：

`UE4Editor.exe "[ProjectPath][ProjectName].uproject" ExampleMap -game`

`open UEEditor.app --args "[ProjectPath]/[ProjectName].uproject" ExampleMap`

> [!TIP]
> 地图名称也可以是完整的地图URL，其中可包含GameMode等额外设置。设置能以键值对的形式添加在地图名称后面，以"?"分割。例如：

```
	DM-Deck?Game=CaptureTheFlag 
```

### 加载新地图

若要在游戏进程中加载新地图，以便开发测试或在游戏期间切换地图，可在控制台输入 `OPEN` 或 `TRAVEL` 命令，后跟要加载的地图命名（无需文件扩展名）。

> [!NOTE]
> 关于 `OPEN` 命令和 `TRAVEL` 命令的区别，参见上文[实用游戏命令](#usefulin-gamecommands)章节。

下列命令都可以在运行时打开DM-Deck地图，区别在于使用相同设置还是重置设置：

```
	open DM-Deck 
```

或

```
	travel DM-Deck
```

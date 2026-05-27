---
title: "在多个启动程序中安装引擎"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/multiple-launcher-unreal-engine-installs"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "在多个启动程序中安装引擎"]
---

# 在多个启动程序中安装引擎

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 在多个启动程序中安装引擎

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/multiple-launcher-unreal-engine-installs

在多台计算机上安装 **Epic Games启动程序** 和 **虚幻引擎** 既耗时又难以维护，对于需要在学校、办公室或网吧环境中管理数十台甚至数百台计算机的IT人员和开发人员来说尤为如此。为了帮助这些用户，我们更新了启动程序的功能，以便应用程序（例如UE）在设置和更新时更加方便。下文介绍了如何在多台计算机上安装启动程序，以便轻松地设置和维护应用程序。

阅读完本文后，你将了解如何启用 **启动程序PCB模式（Launcher PCB Mode）**，如果需要，你还将了解如何在启用PCB模式功能后设置 **Windows注册表安装路径覆盖（Windows Registry Install Path Override）**。

> [!NOTE]
> 目前，只有Windows操作系统上支持这些功能。

## 启动程序PCB模式

在Windows上，启动程序通常将Manifest文件、动态文件和临时文件存储在系统的 **ProgramData** 文件夹中（例如，`%programdata%\\Epic` 或 `C:\ProgramData\Epic`）。通常，如果办公室、学校或网吧管理员在服务器上安装了启动程序和虚幻引擎，而没有将程序数据镜像到客户端，他们就会遇到安装问题，包括客户端无法找到游戏安装文件以及应用程序的重新安装。

有时，系统管理员需要运行一系列复杂的步骤来将程序数据文件夹镜像到客户端的计算机上。为了简化他们的工作流程，启动程序现在支持 **PCB模式（PCB Mode）**。启用PCB模式后，启动程序将程序数据文件夹存储在其安装文件夹中。例如，网吧所有者将能够在服务器机器上设置启动程序，这样服务器的安装文件夹将被复制到它的客户端。对于安装文件夹中的所有程序数据文件，不需要执行额外的工作。

> [!NOTE]
> 如果你以前从未安装过UE，请花些时间阅读我们的初始安装指南，其中介绍了[安装虚幻引擎](https://dev.epicgames.com/documentation/404)的基础知识。

### 启用启动程序PCB模式

执行以下步骤来启用启动程序的PCB模式：

1. 在进入下一步之前，至少在一台计算机（可以是服务器）上安装启动程序。稍后，我们将把这台计算机称为"原始计算机"。
2. 在进入下一步之前，请确保启动程序已关闭。
3. 要启用 **启动程序PCB模式（Launcher PCB Mode）**，请将 **Epic** 文件夹移动（或复制）到启动程序的安装目录中。为了便于说明，我们将Epic文件夹从 `C:\ProgramData\Epic` 移动到 `C:\Program Files (x86)\Epic Games\Launcher` 中。

![Relocatinf Epic Folder](../../../../assets/images/c5/c59a1f945bf1d9f845c38dccf38c5eb644ec2a6408c39e31b5b2b3b89e526384.png)

> [!NOTE]
> PCB模式试图简化用户从启动程序安装多个引擎的工作流。阅读"启动程序PCB模式"部分，了解关于这一新的启动程序模式的更多信息。

1. 使用启动程序，将选择的引擎安装到新的计算机中。
2. 最后，将启动程序和引擎的安装目录复制到新的计算机。

> [!NOTE]
> 如果新计算机的引擎安装路径与原始计算机的安装路径不同，或者新计算机具有不同的驱动器盘符，则需要在启用启动程序PCB模式（Launcher PCB Mode）后添加 **注册表安装路径覆盖（Registry Install Path Override）**。

### 禁用启动程序PCB模式

要禁用此模式，请关闭启动程序，并将 **Epic** 文件夹从启动程序的安装目录移回 **ProgramData** 目录，确保在移动后重新启动启动程序。

> [!TIP]
> 我们建议你移动 **Epic** 文件夹而不是删除它，因为如果你从启动程序安装目录中删除该文件夹，你可能会丢失Manifest文件（无法修改的二进制文件），而它们将用于告诉启动程序你的游戏或应用程序安装在何处。

## Windows注册表安装路径覆盖

启动程序将游戏和应用程序安装位置信息存储在Manifest文件中，而Manifest文件存在于系统的 **ProgramData** 文件夹中。此时，如果你将已安装的游戏或应用程序移动到新位置，启动程序将无法发现移动后的安装文件。这可能会导致问题，特别是对于那些将启动程序和游戏（或应用程序）安装文件移动到驱动器盘符或目录结构不同于原始安装机器的机器的用户。在将启动程序或其安装文件移动（或复制）到新机器的过程中，如果遇到问题，你可能需要指定一个注册表安装路径覆盖，来指向被复制或移动的游戏或应用程序文件夹。

> [!NOTE]
> 通常，注册表安装路径覆盖会与PCB模式一起使用。

在Windows注册表中，会为每个游戏（或应用程序）指定不同的安装路径（InstallLocation）覆盖，以下注册表位置都可以添加 **InstallLocation** 覆盖：

- HKEY_LOCAL_MACHINE\SOFTWARE\Epic Games\EpicGamesLauncher\Overrides
- HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Epic Games\EpicGamesLauncher\Overrides
- HKEY_CURRENT_USER\SOFTWARE\Epic Games\EpicGamesLauncher\Overrides
- HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\Epic Games\EpicGamesLauncher\Overrides

> [!NOTE]
> 下一部分将用到Windows 10中的[注册表](https://docs.microsoft.com/en-us/windows/desktop/sysinfo/registry)编辑器。

### 添加注册表安装路径覆盖

执行以下步骤来添加注册表安装路径覆盖:

1. 在任务栏的搜索栏中，键入 `regedit`。
2. 选择 **regedit运行命令（regedit Run command）**，打开 **注册表编辑器（Registry Editor）**。

   > [!NOTE]
   > 你将使用 **注册表编辑器（Registry Editor）** 来添加InstallLocation覆盖子键（Subkey），该子键可以添加到"注册表安装路径覆盖"部分中列出的任意一个注册表位置。为了便于说明，我们将该子键添加到以下键中：
   >
   > `HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Epic Games\EpicGamesLauncher\Overrides`
3. 导航到以下注册表位置：`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Epic Games\EpicGamesLauncher`，同时确保选择 **EpicGamesLauncher** 键。
4. 如需为 **EpicGamesLauncher** 键创建一个新的子键，请选择 **编辑（Edit）** 菜单，将鼠标悬停在 **新建（New）** 选项上，然后选择 **Key** 命令。
5. 将新子键命名为 `Overrides`。
6. 现在，重复前面的两个步骤，为Overrides创建一个新的子键，将其命名为 `UE_(Engine Version)`。

   > [!TIP]
   > 注册表路径的格式必须包含UE的强制文件夹名，你可以在启动程序的 **安装对话框（Install Dialog）** 中找到该文件夹名。如下图所示，本例的强制文件夹名为 `UE_5.0`：
   >
   > ![LauncherInstallDialog](../../../../assets/images/6f/6f7ea51f4a09fa87096ecc69fc552fef788cccf2730af399a8e1b0064d2b064a.png)
7. 选择 **编辑（Edit）** 菜单，将鼠标悬停在 **新建（New）** 选项上，然后选择 **字符串值（String Value）** 命令。
8. 将新的字符串值命名为 `InstallLocation`。
9. 最后，为 **InstallLocation** 定义数据值，匹配UE的强制文件夹名。在本例中，我们将使用 `C:\Epic Games\UE_5.0`。

   ![(Install Location Override](../../../../assets/images/d3/d3635ed0f90f57a396123f69e5fe931378a53ca2867aee8ddde4ea43c99e5316.png)

   > [!NOTE]
   > 启动程序仅在启动时读取注册表值一次，因此，如果更新了注册表，你需要重新启动启动程序，以便它能够发现更改。

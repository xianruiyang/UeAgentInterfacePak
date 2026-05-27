---
title: "离线安装程序"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/offline-installer-of-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "离线安装程序"]
---

# 离线安装程序

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 离线安装程序

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/offline-installer-of-unreal-engine

独立的离线安装程序为你的组织定制虚幻引擎（UE）安装提供了途径。本文档将指导你使用离线安装程序，包括如何通过命令行进行静默安装，以及如何更新安装程序及其组件。

> [!NOTE]
> 独立安装程序不包含Epic Games启动程序。后者可以让你快速访问Fab，并提供许多实用的项目管理功能。

## 必要设置

要按照本指南操作，你必须在满足或超出[硬件和软件规格](../../../production-pipeline/deploying/container-deployments-and-images-for-unreal-editor-and/hardware-and-software-requirements-for-containe-f83f20cb/index.md)的计算机上下载离线安装程序。

> [!NOTE]
> 只有购买了虚幻席位，或被批准授予访问权限的组织管理员才能在开发者门户上获取离线安装程序。

一旦你的组织获得了UE离线安装程序的访问权限，组织所有者或管理员需按以下步骤操作：

1. 前往

   https://dev.epicgames.com/portal

   ，使用其Epic Games账号登录。
2. 如果同时隶属多个组织，请选择正确的组织。
3. 在左侧的导航菜单中，点击

   Epic工具（Epic Tools）

   ，然后选择

   虚幻引擎（Unreal Engine） > 下载（Downloads）

   。
4. 在

   类型（Type）

   下拉菜单中选择

   虚幻引擎离线安装程序（Unreal Engine Offline Installer）

   。
5. 下载所需的UE离线安装程序版本。

下载好离线安装程序后，就可以使用以下任一方法安装UE：

- 手动安装

  - 直接在需要安装引擎的计算机上运行安装程序。
- 静默安装

  - 使用命令行进行静默安装。

## Windows安装

### 手动安装

直接运行 `UnrealEngineInstaller.msi`，使用安装向导进行手动安装。

使用安装向导配置安装的方法如下：

1. 从下载的

   .zip

   中提取出

   UnrealEngineInstaller.msi

   。
2. 运行

   UnrealEngineInstaller.msi

   ，启动安装向导。
3. 使用安装向导定制安装。

### 静默安装

静默安装对于在组织内的大量设备上部署大量许可证非常有用。

静默安装的方法是用命令行运行 `UnrealEngineInstaller.msi`，并通过额外的参数来定制安装。

静默安装的基本命令如下：

```
msiexec /i path/to/your/UnrealEngineInstaller.msi /qn /l+ "PathToYour/Logname.log" /norestart
```

其中 `/qn` 参数对静默安装是必不可少的，而 `/l+` 参数及其之后的路径输出安装日志。

> [!TIP]
> 使用带 `/?` 参数的 `msiexec` 命令可显示帮助菜单，其中包含 `.msi` 文件可使用的标准参数列表。

#### 虚幻引擎特有的.msi参数

在进行静默安装时，你可以在安装向导中使用以下参数配置一切可用的选项：

| 参数 | 默认值 | 说明 |
| --- | --- | --- |
| `INSTALLLOCATION=[path]` | `"C:\\Program Files\\Epic Games\\[UE Version]\\"` | 你安装UE的位置。 |
| `INSTALL_CREATE_SHORTCUT=[0/1]` | 1 (true) | 如为true，则创建桌面快捷方式。 |
| `ENGINE_STARTER_CHECKED=[0/1]` | 1 (true) | 如为true，则安装初学者内容包。 |
| `ENGINE_TEMPLATES_CHECKED=[0/1]` | 1 (true) | 如为true，则安装项目模板和功能包。 |
| `ENGINE_SOURCE_CHECKED=[0/1]` | 1 (true) | 如为true，则安装UE C++源代码。 |
| `ENGINE_SYMBOLS_CHECKED=[0/1]` | 1 (true) | 如为true，则包含用于调试的引擎符号。 |
| `ENGINE_IOS_CHECKED=[0/1]` | 1 (true) | 如为true，则包含iOS平台支持。 |
| `ENGINE_TVOS_CHECKED=[0/1]` | 1 (true) | 如为true，则包含tvOS平台支持。需要iOS平台支持。 |
| `ENGINE_ANDROID_CHECKED=[0/1]` | 1 (true) | 如为true，则包含Android平台支持。 |
| `ENGINE_LUMIN_CHECKED=[0/1]` | 1 (true) | 如为true，则包含Magic Leap平台支持。需要Android平台支持。 |
| `ENGINE_HOLOLENS_CHECKED=[0/1]` | 1 (true) | 如为true，则包含Hololens平台支持。 |
| `ENGINE_LINUX_CHECKED=[0/1]` | 1 (true) | 如为true，则包含Linux平台支持。 |

例如，如果你希望静默安装使用自定义的安装路径，并细胞配置一些安装设置，你的命令可能会变成下面这样：

```
msiexec /i path/to/your/UnrealEngineInstaller.msi /qn /l+  "PathToYour/Logname.log" /norestart INSTALLLOCATION="C:\Epic Games\[UE Version]" ENGINE_IOS_CHECKED=0 ENGINE_ANDROID_CHECKED=0 ENGINE_LUMIN_CHECKED=0 ENGINE_TVOS_CHECKED=0 INSTALL_CREATE_SHORTCUT=0
```

上面的命令修改了一些默认设置，使得安装程序：

- 将UE安装到

  C:\Epic Games\[UE Version]

  。
- 不包含iOS、Android、tvOS和MagicLeap支持。
- 不创建桌面快捷方式。

> [!NOTE]
> 创建C++项目不一定需要 `ENGINE_SOURCE_CHECKED=1`。但这样你就只能编辑项目的C++代码，不能编译UE的。

### 运行虚幻编辑器

如果你在安装时包含了桌面快捷方式，就可以从桌面运行UE。

否则，就需按以下步骤运行：

1. 找到你的UE安装目录，其默认为

   C:\Program Files\Epic Games\[UE Version]

   .
2. 在目录中找到

   Engine\Binaries\Win64

   。
3. 运行

   UnrealEditor.exe

   。

如果你安装了源代码，请在安装目录下 `Engine\Build\BatchFiles\` 文件夹中运行 `GenerateProjectFiles.bat`，以生成Visual Studio解决方案及配套的项目文件。

### 如何更新UE

如果你在同一版本下调整UE的安装，可以使用修改过的配置重新运行安装程序。如果你在初始安装时省略了平台支持，但现在希望添加，这会非常有用。

如果想要更新UE，请下载并运行新版本的安装程序。如果运行的是在线修正更新（如5.3到5.3.1），可以将其安装到上一个版本的目录中。如果你运行的是大更新（如5.3到5.4），你需要将新版本安装到别的目录中并迁移项目。

迁移项目的步骤为：

1. 备份项目。
2. 右键点击

   .uproject

   文件并选择

   切换虚幻引擎版本（Switch Unreal Engine Version）

   。

## MacOS安装

### 手动安装

直接运行 `FullInstall_OnMac.pkg`，使用安装向导进行手动安装。

使用安装向导配置安装的方法如下：

1. 下载

   FullInstall_OnMac.pkg

   文件包。
2. 双击

   FullInstall_OnMac.pkg

   ，运行安装向导。
3. 使用安装向导安装UE，除符号外，其他一切内容都将被安装。

> [!NOTE]
> 如果在安装时遇到问题，可以打开 `/var/log/install.log` 查看安装日志。

### Silent Installation

静默安装对于在组织内的大量设备上部署大量许可证非常有用。

在Mac上进行静默安装的方法如下：

1. 下载

   FullInstall_OnMac.pkg

   文件包。
2. 在终端中运行

   sudo installer -pkg ~/Downloads/FullInstall_OnMac.pkg -target /

   。
3. 在终端中运行

   sudo chown -R $USER /Users/Shared/Epic\ Games/UE*_SI

   。

> [!NOTE]
> 如果在安装时遇到问题，可以打开 `/var/log/install.log` 查看安装日志。

### 运行虚幻编辑器

安装完成后，你可以从以下任一位置启动虚幻编辑器：

- 启动程序包
- 安装文件夹（

  /Users/Shared/Epic Games/UE_[version]_SI/Engine/Binaries/Mac/UnrealEditor.app

  ）
- 按住Command+空格键，打开Spotlight搜索框，搜索UnrealEditor

### 如何更新UE

使用 `.pkg` 安装程序更新虚幻引擎的步骤与新版本的安装步骤一致。

你可以保留或移除之前的版本。要移除旧版本，请按以下步骤操作：

- 将旧版本拖入垃圾桶。
- 在终端中使用命令

  rm -Rf /Users/Shared/Epic\ Games/UE*_SI

  。

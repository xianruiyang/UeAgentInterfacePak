---
title: "Android开发参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/android-development-basics-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持", "Android开发指南", "Android开发参考"]
---

# Android开发参考

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持 / Android开发指南 / Android开发参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/android-development-basics-for-unreal-engine

## 概述

Android开发参考页面包含了对各种软件组件和系统设置的高层次解释，你需要确保用鱼开发 **虚幻引擎**(UE)Android项目的计算机上已经安装和设置好了。

### Android开发要求

关于当前版本的虚幻引擎所需的SDK组件和兼容硬件的信息，请参考[Android开发要求](https://dev.epicgames.com/documentation/404)页面。

## 环境变量

除非你已从虚幻引擎提供的安装程序中安装了CodeWorks for Android 1R7u1，否则你需要验证一些环境变量是否设置正确。

> [!NOTE]
> 在你完成了安装后（通过在系统控制面板中设置环境变量或安装CodeWorks for Android 1R7u1），你将需要重新启动编辑器和Launcher应用程序。 这是由于Windows应用程序用不同方式存储环境变量，然后将旧版本传递给他们启动的应用程序。
>
> 如果你继续看到关于Android SDK没有被正确安装的信息，建议你重新启动你的电脑。

想要设置一个环境变量：

- 右键点击你的

  电脑

  图标，在你的键盘上同时按下

  Windows-Break

  键。
- 选择左边的

  高级系统设置（Advanced system settings）

  。 点击

  环境变量...
- 对于每个变量（见下文）： 寻找已经在至少一个列表中被设置（系统或用户）的环境变量（来自下文）。

  - 如果没有找到，则在系统部分点击下一个

    新建...（New...）

    。
  - 输入名称和值
  - 点击

    确定（OK）

    。
- 点击

  确定（OK）

  来关闭

  环境变量

  窗口。

下面是我们所使用变量，以及它们指向的地方：

**ANDROID_HOME**

- 将此设置为你安装Android SDK的目录，如果你安装了ADT，则设置为

  sdk

  目录。
- 它必须包含一个名为

  platform-tools

  的目录。

**JAVA_HOME**

- 将此设置为JDK的安装位置。它可能有

  jdk1. 8.0_121

  之类的名称。
- 它必须包含一个名为

  bin

  的目录，其中有

  javac.exe

  。

**AGDE_JAVA_HOME**

- 将此设置为使用

  AGDE

  所需的JDK安装。
- 它必须包含一个名为

  bin

  的目录，其中有

  javac.exe

  。

**ANT_HOME**

- 将此设置为你解压Ant的位置。
- 它必须包含一个名为

  bin

  的目录，其中有

  ant.bat

  。

**NDKROOT**

- 将此设置为你解压NDK的位置。它可能有一个

  android-ndk-r11c

  之类的名称。 它必须有一个名为

  ndk-build.cmd

  的文件。

除非你已安装了CodeWorks for Android 1R7u1，否则你需要验证一些环境变量是否设置正确。

> [!NOTE]
> 在你完成了安装后（通过编辑你的.bash_profile文件或安装CodeWorks for Android 1R7u1），你将需要重新启动编辑器和Launcher应用程序。

想要设置一个环境变量，你需要编辑主目录中的 **.bash_profile** 文件。 该文件在Finder中是隐藏的，所以你需要使用终端（Terminal）来打开它进行编辑。 如果你不熟悉Unix终端命令，请参照以下步骤：

1. 在/Applications/Utilities中打开 **终端应用（Terminal app）
2. 如果不存在文件，则输入

   touch .bash_profile

   进行创建。
3. 输入

   .bash_profile

   ，在文本编辑器中打开该文件。
4. 将以下几行复制到文件中（将路径替换为指向你安装SDK和工具的地方）并保存：

   - export ANDROID_HOME="/Users/epicgames/Devel/NVPACK/android-sdk-macosx"
   - export NDKROOT="/Users/epicgames/Devel/NVPACK/android-ndk-r12b"
   - export ANT_HOME="/Users/epicgames/Devel/NVPACK/apache-ant-1.8.2"

下面是我们所使用变量名称以及它们指向的地方：

- ANDROID_HOME

  - 将此设置为你安装Android SDK的目录，如果你安装了ADT，则设置为 SDK 目录。
  - 它必须包含一个名为 platform-tools 的目录。
- ANT_HOME

  - 将此设置为你解压Ant的位置。
  - 它必须包含一个名为 bin 的目录，其中有名为ANT的文件。
- NDKROOT

  - 将此设置为你解压NDK的位置并寻找类似于与

    android-ndk-r12b

    的东西。 它必须有一个名为

    ndk-build

    的文件。

## Android技巧和窍门

如果你没有在 **启动** 菜单中看到你的设备，你可以试一试这些操作：

- 在等待数秒后再次查看，因为对连接设备的后台扫描可能需要一小段时间。
- 检查你的USB调试连接是否正常。
- 打开命令提示符(同时按下

  Windows+R

  ，然后运行

  cmd.exe

  )

  - 输入以下命令：

    adb devices
  - 如果你没有看到列出任何设备，则你的USB驱动没有正确安装。如何安装驱动取决于你的Android设备的型号。在网上搜索你的设备型号和 "USB驱动程序"，然后安装驱动程序。
  - 此外，你需要确保你的设备启用了开发者模式，并打开了USB调试功能。参阅

    Android开发者使用硬件设备指南

    获取更多信息(特别是第2和第3项)。
  - 之后，确保

    adb devices

    命令有效；没有这个命令，引擎将无法对你的Android设备做任何改变。

如果你的设备显示在启动菜单中，但在部署到设备时被卡住了，这很可能是因为设备没有被授权电脑与之对话。如果你点击程序栏中的 **显示日志（Show Log）** 行， 你可以看到，它最后一行表明正在调用 `adb uninstall`。

- 如上所述，使用

  cmd.exe

  来运行

  adb devices

  命令。
- 如果设备被列出但显示未授权，这表明你需要让设备询问是否要授权电脑。
- 你可能需要拔掉插头并重新连接你的设备，使其在列表中显示出来。
- 建议你勾选

  总是允许（Always allow）

  的复选框。

如果你没有在启动菜单中看到你的设备，你可以试一试这些操作：

- 在等待数秒后再次查看，因为对连接设备的后台扫描可能需要一小段时间。
- 检查你的USB调试连接是否正常。
- 打开终端应用，然后尝试以下方法。

  - 在终端输入以下命令：

    adb devices

    。
  - 如果你没有看到列出任何设备，则你的USB驱动没有正确安装。如何安装驱动取决于你的Android设备的型号。在网上搜索你的设备型号和

    USB驱动程序

    ，然后安装所需的驱动程序。
  - 此外，你需要确保你的设备启用了开发者模式，并打开了USB调试功能。参阅

    Android开发者使用硬件设备

    指南获取更多信息(特别是第2和第3项)。
  - 之后，确保

    adb devices

    命令有效；没有这个命令，引擎将无法对你的Android设备做任何改变。

如果你的设备显示**在启动菜单中，但在部署到设备时被卡住了，这很可能是因为该设备没有被授权与你的Mac互动。 如果你点击程序栏中的**显示日志（Show Log）** 行并看到最后一行显示正在调用 `adb uninstall`,请进行以下尝试。

- 打开终端应用程序，运行

  adb devices

  命令。

  设备被列出但显示未授权，这表明你需要让设备询问是否要授权Mac。

  建议你勾选

  始终允许

  复选框，始终允许你的Mac与该设备对话。

### Android纹理格式

并非所有的Android设备都是相同的。具体来说，有4种不同的渲染硬件。它们各自支持不同格式的压缩纹理。

| 格式 | 说明 |
| --- | --- |
| **ETC1** | 所有基于安卓的设备都支持，但不能压缩alpha纹理 (它们未经压缩就被存储). 如果需要alpha获得更好的压缩，建议使用一个RGB和一个单独的alpha纹理。 |
| **ETC2** | 所有OpenGL 3.x类设备都支持，并支持alpha压缩。 |
| **ATC** | 由高通Adreno GPU支持，并支持alpha压缩。 |
| **DXT** | 由英伟达Tegra GPU支持，并支持alpha压缩。 |
| **PVRTC** | 由PowerVR GPU支持，并支持alpha压缩。 |
| **ASTC** | 最新的纹理压缩格式，允许通过指定块的大小更好地控制质量，并支持alpha压缩。目前在一些设备上可用，并将在Vulkan Level 1中被要求。 |
|  |  |

当你为Android部署或打包你的游戏时，数据将被转换为Android设备可用的格式（我们称这个过程为 "烘焙"）。因为不同的设备支持不同的压缩格式， 你可以选择想要烘焙的格式。在 **启动（Launch）** 或 **打包（Package）** 子菜单， 你可以看到 **Android**，后面列出的是可能的格式。

第一个（**Android**）实际上采用了所有的格式，并把它们放到已烘焙的包裹中。这将需要更长的时间，并且会产生更大的包裹，但通过在运行时选择最好的格式， 可以保证最小的内存使用量。这在任何设备中都会生效( **Android (ETC1)** 也同样)。

> [!NOTE]
> 虚幻引擎4.8以后的版本现在将支持在Tegra K1设备上使用 **ES31** 和 **AEP** 渲染。 请注意，由于目前支持ES31和AEP渲染的设备数量有限，已经完成的性能和兼容性测试非常少。 如果你正在开发一个旨在使用这些设备之一的项目，强烈建议你进行广泛的性能和兼容性测试，以确保该设备以你预期的方式交付你的项目。

### 选择一种格式

你应该为你的设备选择一个最佳的格式。如果你明确你的设备中GPU的类型，可以查看上方的表格，选择一种格式。但是,如果你并不知道你的GPU类型，那么你可以选择 **Android** 或者 **Android (ETC1)**。当你在运行游戏时，如果同时用四根手指点击屏幕，会弹出一个对话。这个对话框通常用来输入一个控制台命令（如 `stat fps`），但它也会显示你的设备所支持的格式。在你得到了这个清单后，你就可以根据它，在部署/打包时选择一个理想的类型。如果你选择了一个你的设备不支持的格式，它将无法加载。

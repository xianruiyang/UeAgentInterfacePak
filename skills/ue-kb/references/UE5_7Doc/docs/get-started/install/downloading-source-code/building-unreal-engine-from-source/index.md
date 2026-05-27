---
title: "从源代码构建虚幻引擎"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/building-unreal-engine-from-source"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "从GitHub下载虚幻引擎源代码", "从源代码构建虚幻引擎"]
---

# 从源代码构建虚幻引擎

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 从GitHub下载虚幻引擎源代码 / 从源代码构建虚幻引擎

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/building-unreal-engine-from-source

选择操作系统：

Windows

macOS

Linux

## 从源代码构建虚幻引擎

阅读，确保已安装好 **Microsoft Visual Studio**，然后再从源代码构建 **虚幻引擎（UE）**。此外，根据系统配置，可能需要10-40分钟来编译引擎。

1. 在[下载并调整UE源代码](../index.md#downloadingthesourcecode)的根目录中，运行 `GenerateProjectFiles.bat` 来设置项目文件。

   > [!WARNING]
   > 所有项目文件都是中间文件（`[UERoot]\Engine\Intermediate\ProjectFiles`）。每次同步新构建时都必须生成项目文件，以确保它们是最新文件。如果你删除了`Intermediate`文件夹，必须使用 `GenerateProjectFiles` 批处理文件来重新生成项目文件。
2. 双击 `UE5.sln` 将项目加载到Visual Studio。
3. 将解决方案配置设置为 **开发编辑器（Development Editor）**。
4. 将解决方案平台设置为 **Win64**。
5. 右键单击UE目标并选择 **构建（Build）**。

阅读 , 确保安装了 **XCode** ，然后再从源代码构建 **虚幻引擎（UE）**。此外，根据系统配置，可能需要10-40分钟来编译引擎。

1. 在根目录中，运行 `GenerateProjectFiles.command` 来设置项目文件。
2. 双击 `UE4.xcodeproj`， 将项目加载到XCode。
3. 要设置构建目标，从标题栏中的 **My Mac** 下选择 **UnrealEditor - Mac**。
4. 要构建项目，选择 **产品（Product）>构建（Build）**。

**虚幻引擎（UE）** 的开发和支持团队目前使用最新版 **Ubuntu**；因此，我们可能无法提供对其他Linux分发版的支持（包括其他版本的Ubuntu）。此外，请阅读，确保系统包含至少100GB磁盘空间，然后 再执行以下步骤。

1. 在根目录中，从终端运行 `Setup.sh` 以设置生成项目文件所需的文件。
2. 现在，从终端运行 `GenerateProjectFiles.sh` 以生成项目文件。
3. 要构建项目，从终端运行 **make**。

根据系统配置，编译引擎可能需要花费十分钟到超过一个小时不等的时间。 如果要缩短从源代码编译引擎花费的时间，我们建议你在内存至少为8GB且处理器至少为8核（包括超线程）的机器上编译源代码。

## 运行编辑器

1. 右键点击 **UE5** 目标并选择 **设置为启动项目（Set as StartUp Project）** 以设置启动项目。
2. 右键点击 **UE5** 项目，选择 **Debug > 启动新实例（Start New Instance）** 以启动编辑器。

   > [!TIP]
   > 或者，你可以按键盘上的 **F5键** 来启动编辑器的新实例。
3. 恭喜！你已经从源代码编译并启动了引擎。

1. 选择 **产品（Product）>运行（Run）** 以启动编辑器。
2. 恭喜！你已经从源代码编译并启动了引擎。

1. 在终端中输入`cd Engine/Binaries/Linux/`来导航到编辑器的二进制路径。
2. 运行 **UnrealEditor** 来启动编辑器。
3. 恭喜！你已经通过编译源代码启动了引擎。

## 开始虚幻引擎之旅

要了解如何使用虚幻引擎，请参阅[理解基础知识](../../../../understanding-the-basics/index.md)文档！

如果希望快速上手使用虚幻引擎，请参阅以下教程：

- 编程快速入门
- 关卡设计师快速入门

> [!NOTE]
> UE的编辑器内帮助功能能够回答你的一些问题。

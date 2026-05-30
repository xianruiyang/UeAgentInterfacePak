# 使用最新的 Xcode 在 MacOS 上从头开始编译 4.27 项目

# 使用最新的 Xcode 在 MacOS 上从头开始编译 4.27 项目

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/K6wY/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 7586 字符。

## 摘要

我长达数周的旅程浓缩为我（第一次使用 Mac 用户）如何使打包项目在 AppleSilicon（Rosetta 和本机）上运行的几行代码。

## 中文整理

### Intel-x64架构：

我将从如何构建 Intel-x64 开始，因为这个要容易一些。为此，您可以从 Epic Games Launcher 下载 4.27 的正式版本并创建新项目。您的构建将立即失败（可能）是因为代码签名，因为未生成 info.plist。如果您像我一样，您不知道这意味着什么，因为在 Windows 上不需要这样的东西。好吧，欢迎来到苹果环境。几天来我都没有在任何地方找到简单的解决方案。我购买了（现在不需要）苹果开发者许可证，但仍然一无所获。因此，关闭所有与引擎相关的内容并在 xcode 中打开该项目。如果您是第一次看到 xcode 界面*握手*。事实证明，您需要做的就是启用该文件的自动生成，并且只需确保选择此处所示的所有内容即可。

![教程图片](assets/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode/image-01.jpg)

然后在**构建设置**中找到**打包**并将生成 info.plist 文件更改为**是**。

![教程图片](assets/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode/image-02.jpg)

这应该可以消除代码签名错误。此后，因为有人在某个地方创建了一个变量，分配给它并且没有在任何地方使用结果，编译器将生成警告，并且因为 Epic 是对警告零容忍的公司 - 默认编译器行为是将每个警告视为错误。要解决此问题，您需要向构建系统添加编译器标志，以免针对这些情况生成警告。因此，将这些行添加到 Editor 和 Project .Target.cs 文件中。

**构建系统标志编辑**

```cpp
if (Target.Platform == UnrealTargetPlatform.Mac)
        {
	        bOverrideBuildEnvironment = true;
	        AdditionalCompilerArguments = "-Wno-unused-but-set-variable";
        }
```

![教程图片](assets/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode/image-03.jpg)

现在应该可以正常编译了，您就可以开始了。您可以从顶部面板打开 **产品** 菜单，然后选择 **构建。** 您可以通过单击此图标并选择要查看日志的作业来查看构建输出。

![教程图片](assets/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode/image-04.jpg)

构建后再次打开“产品”菜单并选择“运行”。现在编辑器应该打开，您应该能够像在 Windows 上一样执行所有操作。 （编辑器首选项不在“编辑”菜单下，而是在“虚幻编辑器”->“首选项”下）。在项目设置 -> 平台 -> Mac 中，您可以选择要打包的架构 - Intel、Both、Apple Silicon。如果你可以为 Apple Silicon 构建，你可以尝试一下，但我没有那么幸运。另外，由于某种奇怪的原因，我实际上无法从编辑器中烹饪或打包。我的工作因“为项目设置参数”引用而被挂起，此后什么也没有发生。奇怪的是，手动运行这些确切的命令效果很好。这正是我所做的。刚刚从输出日志中复制了参数。在 Engine/Build/BatchFiles 目录中打开终端并调用“./RunUAT.sh”。它奏效了。因此，您可以根据您的项目设置使用编辑器生成参数，然后手动使用它们。我仍然不确定为什么它只能这样工作，但我很高兴有一种方法，而且我听说 mac 上的编辑器没有得到很好的支持，所以这可能就是一个例子。 （在新项目中我没有发生这种情况，但我使用的一个插件导致了这种情况，所以如果您也发生这种情况，请尝试手动方式:)）这就是英特尔架构的情况。因为我非常高兴，我在难以形容的时间之后走到了这一步（真的，有时我每天坐 13-16 个小时，没有停顿。回想起来，我总是想放弃，但总有我还没有尝试过的下一件事，所以呃），我显然想在没有 Rosetta 的 M1 上运行这个本机（你可以通过打开 **Activity Monitor ** 和选定的 **CPU** 选项卡来检查你正在运行的内容，如果 **Kind** 说 **Apple** 你正在本机运行，如果显示 **Intel** 该应用程序正在通过 **Rosetta** 进行模拟）。

![教程图片](assets/unreal-engine-compiling-4-27-project-on-macos-from-scratch-using-newest-xcode/image-05.jpg)

### Apple Silicon -arm64 架构

由于我的 EGL (Epic Games Launcher) 构建的虚幻引擎无法解决此问题（根据我正在尝试的内容，我遇到了许多不同的错误，但主要是“Launch.cs 某些预编译清单的内容”。*结果是要解决此问题，您需要从源代码构建引擎。事实证明它也不是开箱即用的编译。事实证明 4.27 分支将使您的应用程序在一段时间后挂起。事实证明 4.27 以上分支似乎工作（需要进一步测试）。*因此，您必须首先将引擎的 4.27+ 分支克隆到您的文件夹中（因为我相信你们都不想真正下载整个 git 历史记录，解决此问题的最佳方法是调用 **git clone https://github.com/EpicGames/UnrealEngine.git --branch 4.27-plus --single-branch --depth=1** 这将仅复制单个分支（4.27+）** **并且没有这个分支的历史记录（深度参数）。下载后，它几乎是官方指南内容（运行 **Setup.command **，然后运行 **GenerateProjectFiles.command**）。这一切都需要一段时间（愚蠢的我尝试先使用 4.27 分支执行此操作，以便我可以再次执行此操作）。因此，生成 Xcode 项目时，您需要执行与生成 info.plist 文件相同的操作。大约 30 分钟后，如果要处理的最后一个 .cpp 文件会抛出错误，那么更糟糕的是，它实际上不是错误，只是被视为错误的警告。更糟糕的是，修复需要完全重新编译所有内容（稍后您可以通过写这篇文章来感谢我节省的时间，如果在阅读过程中您突然想到您没有时间阅读所有内容，那么您绝对应该找到一些内容：D）。更糟糕的是，向 Target.cs 文件添加任何内容根本没有帮助，因为（我不知道为什么：D）它由于某种原因不被视为项目中的 Target.cs 文件（我可以理解，因为我们必须构建正在构建项目的工具，但为什么它们在那里？......神秘）。我不想再花 2 天来弄清楚这一点，所以我专注于手头的问题，该问题是由于比较不同的两个函数指针而生成的警告。 “类型” - **是**我在C++中编程了9年，我不知道指向成员函数的指针比指向任何其他函数的指针**大**所以我一生（不，我不是9岁）“指针大小由32/64位体系结构决定”是完全错误的**，***部分。*无论如何，似乎没有标志可以仅关闭此警告** **所以我们将让编译器关闭此警告的生成。停止将警告视为错误** **（我完全支持[this](https://embeddedartistry.com/blog/2017/05/22/werror-is-not-your-friend/)）。为此，我们需要更改位于 **Engine/Source/Programs/UnrealBuildTool/Platform/Mac** 中的 **MacToolChain.cs**。使用任何文本编辑器打开它并搜索“**-Werror**”。 （我相信如果您在此处更改此内容，则使用此版本的引擎构建的所有项目都不需要编辑 Target.cs 文件，但我还没有尝试过），所以只需将其注释掉即可。

```cpp
Result += " -Wall -Werror";
```

```cpp
Result += " -Wall";// -Werror";
```

保存文件即可。步骤与 Intel arch 完全相同（至少对我来说）。 （希望）成功构建后，转到项目文件夹，右键单击 .uproject 文件，选择 **切换虚幻引擎版本** 并选择自定义版本。重新生成项目文件，编译项目，在编辑器中，您现在应该能够选择 **Apple Silicon** 作为目标架构并打包您的项目。如果您确实在本机运行，请不要忘记仔细检查**活动监视器**。祝你好运！


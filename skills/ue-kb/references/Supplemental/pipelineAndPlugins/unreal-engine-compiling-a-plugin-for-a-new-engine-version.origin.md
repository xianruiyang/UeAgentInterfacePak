# 为新引擎版本编译插件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/0RG4/unreal-engine-compiling-a-plugin-for-a-new-engine-version

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1543 字符。

## 摘要

了解如何在不打开引擎源版本的情况下为新的源引擎版本编译插件。

## 中文整理

### 概览

嘿，有时您会发现一个插件与您的引擎版本不相关。有时您会运行自定义构建。通常，除非您有关联的版本，否则市场不会让您下载。最糟糕的情况是，您尝试使用自定义源代码构建来编译它，它会触发完全重建，这可能需要几个小时（尤其是在我的慢动作 PC 上）。您可以使用的一种技巧是直接使用虚幻构建工具。这比你想象的要容易。我们首先打开命令提示符（或适用于 Linux/Mac）。我们导航到引擎源构建中的以下文件夹（在本例中，我的驱动器是 U:，我的引擎位于名为 UnrealEngine\427 的文件夹中）

### cd U:\UnrealEngine\427\Engine\Build\BatchFiles

从那里我们可以访问 RunUAT.bat 文件。我们将向其传递原始插件的位置，并为其提供一个文件夹来输出新编译的插件。整个命令是这样的（用你自己的插件和文件夹替换 PATH\TO\PLUGIN\ ，不要忘记将plugin-name.uplugin添加到原始路径）。我们添加一个 TargetPlatforms 参数，以防我们想要限制它的编译结果。

### RunUAT.bat BuildPlugin -plugin="PATH\TO\PLUGIN\MyPlugin.uplugin" -package="MY\NEW\PATH" -TargetPlatforms=Win64

然后执行并稍等片刻。如果有依赖项，它可能会编译一些引擎，但它不应该接近完整的构建。瞧，这是一个为您最新的引擎版本构建的新插件。享受！


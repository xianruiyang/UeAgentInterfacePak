# 加速编译着色器

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/7B09/unreal-engine-speed-up-compiling-shaders

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2519 字符。

## 摘要

在本教程中，我们将介绍如何加快虚幻引擎中编译着色器的速度。该方法适用于包括UE4在内的所有虚幻引擎版本。

## 中文整理

### 概览

我会尽量保持简短，以节省您的时间。

您需要按照重要性顺序执行两件主要事情： - 将 CPU 中的着色器编译器优先级设置为“正常”/“较高”。

当虚幻引擎“编译着色器”时......

它创建多个子进程“ShaderCompiler.exe”来处理编译着色器的任务。

每当着色器编译时，您都可以在任务管理器中看到这一点。

默认情况下，虚幻引擎以“低于正常”优先级启动这些进程。

基本上是告诉 CPU 不要对它们设置过多的优先级。

您可以通过将它们设置为“正常”或“高”来加快它们的速度。

我推荐“正常”。

最好的方法是更改​​引擎使用的配置文件，这样您只需执行一次即可忘记它。

在后续启动中，它将正确启动它们。

请阅读此处的操作方法：https://store.algosyntax.com/tutorials/unreal-engine/ue5-how-to-speed-up-compiling-shaders/ 在 CPU 中将着色器编译器优先级设置为正常/较高。

当虚幻引擎“编译着色器”时......

它创建多个子进程“ShaderCompiler.exe”来处理编译着色器的任务。

每当着色器编译时，您都可以在任务管理器中看到这一点。

默认情况下，虚幻引擎以“低于正常”优先级启动这些进程。

基本上是告诉 CPU 不要对它们设置过多的优先级。

您可以通过将它们设置为“正常”或“高”来加快它们的速度。

我推荐“正常”。

最好的方法是更改​​引擎使用的配置文件，这样您只需执行一次即可忘记它。

在后续启动中，它将正确启动它们。

请阅读此处的操作方法：https://store.algosyntax.com/tutorials/unreal-engine/ue5-how-to-speed-up-compiling-shaders/ - 将防病毒软件中的 UnrealEngine.exe 和 ShaderCompiler.exe 列入白名单。

One of the things that trigger antivirus alarms is any new program that hogs the CPU.

Shader Compilation is an intense process and sometimes your antivirus will try to scan it while it's running.

这会减慢这个过程。

您也可以在上面的链接中阅读相关内容。

Whitelist UnrealEngine.exe and ShaderCompiler.exe in your antivirus.

One of the things that trigger antivirus alarms is any new program that hogs the CPU.

Shader Compilation is an intense process and sometimes your antivirus will try to scan it while it's running.

这会减慢这个过程。

您也可以在上面的链接中阅读相关内容。

- 加速UE5着色器编译完整教程 - 材质 - 树叶 - 环境艺术 - 阴影 - 后期处理 - 虚拟制作 - 动画 - 关卡设计

## 相关链接

- [https://store.algosyntax.com/tutorials/unreal-engine/ue5-how-to-speed-up-compiling-shaders/](https://store.algosyntax.com/tutorials/unreal-engine/ue5-how-to-speed-up-compiling-shaders/)
- [Speed Up UE5 Shader Compilation Full Tutorial](https://store.algosyntax.com/tutorials/unreal-engine/ue5-how-to-speed-up-compiling-shaders)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/7B09/unreal-engine-speed-up-compiling-shaders#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)


# 使用虚幻引擎设置渲染农场的概述（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/xY9O/overview-of-setting-up-a-render-farm-with-unreal-engine
- 原始文件：overview-of-setting-up-a-render-farm-with-unreal-engine.origin.md
- 分段：第 2/3 段

要在 Python 中实现您自己的执行器，您需要在 YOUR_PROJECT/Content/Python 文件夹中创建两个 Python 脚本。一个文件名为 RemoteRenderSubmitter.py，另一个文件名为 init_unreal.py。在 init_unreal.py 中导入您的其他自定义 Python 模块（“导入 RemoteRenderSubmitter”） - 这是必需的，以便 Python 环境扫描您的自定义 Python 模块并检测我们接下来要实现的 Unreal 类。在 RemoteRenderSubmitter.py 中，您需要创建一个继承自 unreal.MoviePipelineExecutor 的 UObject。

### RemoteRenderSubmitter.py

import unreal @unreal.uclass() class MyCustomRemoteRenderSubmitter(unreal.MoviePipelineExecutorBase): # MoviePipelineExecutor 实现必须重写它。

@unreal.ufunction(override=True) defexecute(self, pipeline_queue): unreal.log("Execute!") 创建这些文件后，重新启动编辑器（检查输出日志中的错误以确保解析自定义模块时没有 Python 错误），您应该能够从项目设置的下拉列表中进行选择，并且在用户界面中单击渲染（远程）后，输出日志应输出“执行！”。

对于脚本的进一步迭代，您将需要重新启动编辑器，因为 Unreal 实际上正在解析您的 Python 脚本并根据 Unreal 理解的函数和属性重写它（这只是因为我们正在制作 uclass 实现，常规 Python 脚本没有此限制）。

从此提交者脚本中，您现在可以选择如何将数据提交到渲染场软件。

某些管理软件具有可用于创建作业的 HTTP API，而其他管理软件则使用命令行工具来生成作业。

从虚幻的角度来看，您需要决定如何分配队列中的工作。

典型的离线渲染包通常会获取作业中需要渲染的每一帧，并为每个帧创建一个“任务”。

由于虚幻引擎的实时性（更多内容见下文），我们目前建议的最小工作单元是每台机器一个镜头，因此您可以拍摄每个镜头并将其转换为渲染场管理软件的单独任务，然后在远程端再次将每个任务解释为完整镜头。

我们通常建议获取影片渲染队列中的每个作业并从中创建一个渲染农场作业，然后为每个镜头创建一个任务。

由于用户可以在用户界面中更改其设置，因此我们通常采用用户提供的队列并将其拆分为每个作业一个队列（通过复制队列并删除其他作业），然后将此队列序列化为临时文本文件（请参阅 UMoviePipelineEditorBlueprintLibrary::SaveQueueToManifestFile）。

该文本文件将包含有关作业的信息（例如要使用的级别和级别顺序），以及捕获他们在用户界面中所做的任何更改，即使他们没有重新保存队列文件。

通过将其保存为文本，可以将其附加到 HTTP 请求，或将路径作为命令行提交工具的一部分传递给它，等等。

现在，您已经创建了对渲染场的提交 - 它知道您要使用什么地图、关卡序列和设置进行渲染，但它不知道如何处理这些内容。

为了解决这个问题，您需要第二个插件，特定于您的渲染农场管理软件，它可以在远程计算机上启动虚幻引擎并告诉它要执行哪一部分工作。

不过，在启动虚幻引擎之前，您需要考虑这台机器将如何获取作业的正确内容。

许多传统的离线软件包通过网络共享加载项目，但这不是虚幻中推荐/经过良好测试的代码路径。

由于虚幻引擎的实时特性，典型的工作流程期望内容位于本地 SSD 上（特别是在使用 Nanite 和虚拟纹理等在给定渲染会话中不断输入和输出内容的东西时）。

在我们的内部实现中，我们通过 Perforce 将项目同步到本地磁盘，然后在必要时编译项目（因为我们不断同时迭代内容和引擎更改）。

如果您使用 Epic Games Launcher 中的二进制文件，您可能可以跳过编译项目，但您仍然需要提出一些解决方案，将项目的最新副本同步到本地计算机。

将最新版本的引擎/项目同步到计算机后，您现在需要启动虚幻引擎来执行实际的渲染工作。

具体取决于您在第一步中如何分解工作，以及您的第三步是什么样子，因此没有具体的答案。

一个简单的解决方案是为每个任务启动一次引擎 - 启动引擎，渲染特定镜头，关闭引擎。

这对于简单的项目来说效果很好，但是随着您的项目变得越来越大，最好启动一次引擎并只处理给定的所有任务，直到没有更多任务，特别是如果您的项目需要很长时间才能加载。

更先进的解决方案是启动引擎一次，然后与渲染管理软件来回通信，以查看下一步应该执行什么任务，并重新加载地图并设置每个任务，直到作业完成。

具体细节将再次取决于渲染场管理软件，因此没有给出直接的示例。

关于从命令行启动虚幻引擎的一些提示： - 使用 UnrealEngine-Cmd.exe 而不是 UnrealEngine.exe - 这将在同一进程中启动虚幻引擎（而不是启动新进程），这对于渲染场管理软件通常是必不可少的。

使用 UnrealEngine-Cmd.exe 而不是 UnrealEngine.exe - 这将在同一进程中启动虚幻引擎（而不是启动新进程），这对于渲染场管理软件通常是必不可少的。

- 添加以下命令行参数：“-log -unattend -stdout -allowstdoutlogverbosity” -unattended 表示不显示弹出对话框（并且崩溃会立即关闭引擎，而不是显示崩溃报告器对话框，这会使进程看起来仍处于打开状态）。

需要 -stdout 和 -allowstdoutlogverbosity 才能将完整的输出日志输出放入 stdout 管道（渲染场软件使用它来读取软件的持续输出）。

添加以下命令行参数：“-log -unattend -stdout -allowstdoutlogverbosity” - -unattended 表示不显示弹出对话框（崩溃时立即关闭引擎，而不是显示崩溃报告器对话框，这会使进程看起来仍处于打开状态）。

-无人值守意味着不显示弹出对话框（并且崩溃会立即关闭引擎而不是显示崩溃......

### 通过命令行启动编辑器并运行影片渲染

### CustomRenderBootstrap.py

### MyCustomEditorRenderExecutor.py

### 实时考虑

## 相关链接

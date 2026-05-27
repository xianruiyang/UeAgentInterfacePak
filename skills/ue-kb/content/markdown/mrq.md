# 使用命令行渲染操作MRQ

---
title: "使用命令行渲染操作MRQ"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-command-line-rendering-with-move-render-queue-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "使用命令行渲染操作MRQ"]
---

# 使用命令行渲染操作MRQ

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 使用命令行渲染操作MRQ

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-command-line-rendering-with-move-render-queue-in-unreal-engine

> [!WARNING]
> 如果你项目中的C++代码引用了 `MoviePipelineMasterConfig.h`，你必须将其替换为 `MovePipelinePrimaryConfig.h`。

在 **虚幻引擎（Unreal Engine）** 中使用[影片渲染队列（MRQ）](https://dev.epicgames.com/documentation/404)渲染[Sequencer](../../index.md)项目时，你可以搭配使用MRQ资产配置、简化的[命令行渲染](../cinematic-render-settings-and-formats/index.md)参数，以及Python执行器来自定义你的渲染工作流程。

传统离线渲染农场通常可以在单台计算机上处理单个帧，与之不同的是，在虚幻引擎中，最小的可分发工作单元是镜头切换（Camera Cut），或者说关卡序列镜头（Level Sequence Shot）。这是因为，虚幻引擎的实时渲染特性决定了它在渲染画面时需要依赖前一帧的信息，而这类信息无法在多台计算机间共享。

相较于[旧版的渲染电影功能](../../cinematic-workflow-guides-and-examples/rendering-out-cinematic-movies/index.md)，电影渲染队列（MRQ）配置文件可能很复杂。MRQ不再采用旧版系统中的命令行参数机制；在新系统中，它通过命令行调用渲染。原本支持的命令行参数已减少到只剩几个基本参数；不过，虚幻引擎支持使用Python自定义你的渲染过程。这意味着，你可以更好地控制命令行渲染的执行方式，相较于旧版渲染电影系统更灵活。

大致来说，你可以运行以下三种模式：

1. 指定单个关卡序列和配置资产。
2. 指定要渲染的整个队列（Queue）。
3. 使用自定义Python执行器完全控制渲染。

以下文档介绍了支持的三种参数模式，以及你可以通过MRQ在项目渲染中使用和自定义的自定义Python执行器。

## 关卡序列参数

`-LevelSequence` 参数可用于指定要使用MRQ渲染的特定关卡序列的路径。如果你使用此路线，还必须指定 `-MoviePipelineConfig` 参数，它指向 **UMoviePipelinePrimaryConfig** 预设资产，这样会将恰当的设置分配给要用于渲染的资产。

此方法是通过命令行启动MRQ渲染的最基本用法。你的命令行可能类似于以下内容，其中 `subwaySequencer_P` 是要加载的地图， `SubwaySequencerMASTER` 是关卡序列资产， `SmallTestPreset` 是 **UMoviePipelinePrimaryConfig** 预设资产：

```
 UnrealEditor-Cmd.exe "E:\SubwaySequencer\SubwaySequencer.uproject" subwaySequencer_P -game -LevelSequence="/Game/Sequencer/SubwaySequencerMASTER.SubwaySequencerMASTER" -MoviePipelineConfig="/Game/Cinematics/MoviePipeline/Presets/SmallTestPreset.SmallTestPreset" -windowed -resx=1280 -resy=720 -log -notexturestreaming 
```

此示例方法仅支持在单张地图中渲染单个作业，并将渲染该关卡序列包含的所有镜头。

## 电影管线配置参数

以关卡序列参数为基础，接下来要指定 `-MoviePipelineConfig` 参数，该参数作为 **UMoviePipelineQueue** 资产（通过MRQ UI保存）的路径而不是 **主配置（Primary Config）** 和关卡序列资产的路径运行。这将自动在队列中相应条目指定的贴图上使用队列中存储的每个作业的配置处理队列中的每个作业。对于此参数，你的命令行可能如下：

```
 UnrealEditor-Cmd.exe "E:\SubwaySequencer\SubwaySequencer.uproject" subwaySequencer_P -game -MoviePipelineConfig="/Game/Cinematics/MoviePipeline/Presets/BigTestQueue.BigTestQueue" -windowed -resx=1280 -resy=720 -log -notexturestreaming 
```

## 使用Python的自定义管线功能

你还可以使用Python中的自定义执行器构建你自己的管线功能，这可用于从命令行读取参数，配置或创建MRQ作业，等等。为此，你必须使用 `-MoviePipelineLocalExecutorClass=/Script/MovieRenderPipelineCore.MoviePipelinePythonHostExecutor` ，然后通过 `- ExecutorPythonClass=...` 指定Python执行器类。

运行自定义Python执行器时，你的命令行可能类似于以下内容：

```
 UnrealEditor-Cmd.exe "E:\SubwaySequencer\SubwaySequencer.uproject" subwaySequencer_P -game -MoviePipelineLocalExecutorClass=/Script/MovieRenderPipelineCore.MoviePipelinePythonHostExecutor -ExecutorPythonClass=/Engine/PythonTypes.MoviePipelineExampleRuntimeExecutor -windowed -resx=1280 -resy=720 -log -notexturestreaming 
```

若使用此命令行，引擎将启动，然后为你创建基于Python的执行器（在本例中为 `MoviePipelineExampleRuntimeExecutor` ）的实例。创建你的执行器后，你可以读取命令行参数，运行MRQ作业，与外部服务器通信以确定作业信息，等等。

如果你希望自行构建基于Python的执行器，你需要创建从 `unreal.MoviePipelinePythonHostExecutor` 继承的基于Python的UClass，然后你需要覆盖 `execute_delayed` 函数。你需要在 `/Content/Python` 文件夹中创建用于导入自定义模块的"init_unreal.py"类。虚幻引擎需要此 `init_unreal.py` 文件，才能解析你的Python文件并将其重写为引擎支持的UClass，接着可以在命令行上指定后者。请查看示例脚本，了解关于具体操作示例。

> [!NOTE]
> 你可以在 `\Plugins\MovieScene\MovieRenderPipeline\Content\Python\MoviePipelineExampleRuntimeExecutor.py` 中查看示例Python执行器，其中显示了如何从命令行读取、发起 **HTTP** 请求并尝试本地套接字连接。此示例的确切参数稍多于上面描述的情况，因此在尝试进行测试时，请阅读示例文件顶部的信息。


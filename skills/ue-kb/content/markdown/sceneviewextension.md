# 使用SceneViewExtension扩展渲染系统

# 使用SceneViewExtension扩展渲染系统

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/0ql6/unreal-engine-using-sceneviewextension-to-extend-the-rendering-system
- 原始文件：unreal-engine-using-sceneviewextension-to-extend-the-rendering-system.origin.md
- 分段：第 1/2 段

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/0ql6/unreal-engine-using-sceneviewextension-to-extend-the-rendering-system

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 6693 字符。

## 摘要

使用 SceneViewExtension 扩展渲染系统 由 Jon C 撰写的文章。我们经常收到关于如何引入新的指导的请求...

## 中文整理

### 概览

文章作者：Jon C.

我们经常收到关于如何将新渲染通道引入引擎的指导请求，特别是如何在不直接修改引擎代码的情况下实现这一目标。

我们不断考虑如何改进渲染系统的模块化，以允许通过项目和插件注入通道和其他代码。

将代码注入帧中某些执行点的一种方法是利用 SceneViewExtension 系统。

要了解该扩展的概述，我们建议首先阅读 SceneViewExtension.h 中的文档，其中解释了该扩展以及如何实例化它，以及一些其他功能。

本文的目的是通过突出显示特定用例来更深入地探讨如何开始。

我们已经在一些 Epic 创建的引擎插件中拥有一些用例。

如果您在引擎中搜索“FSceneViewExtensionBase”的用法，您应该能够找到一些现有的示例。

例如，FColorCorrectRegionsSceneViewExtension，它是颜色校正区域插件的一部分：如果您首先查找文本“FColorCorrectRegionsSceneViewExtension”的实例，您应该能够找到在初始化 UColorCorrectRegionsSubsystem 插件模块期间注册的扩展：此调用将使用 GEngine 的已知视图扩展的内部列表注册新创建的扩展。

这意味着，在整个框架的某些点，可以引用这些注册的视图扩展，然后在这些特定的时间调用它们的重写函数。

例如，在 ColorCorrectRegions 扩展中，FColorCorrectRegionsSceneViewExtension::PrePostProcessPass_RenderThread 已覆盖父 PrePostProcessPass_RenderThread 调用。

在引擎函数 FDeferredShadingSceneRenderer::Render 中，以下代码在执行“AddPostProcessingPasses”之前执行，这意味着此时正在帧中调用新扩展的 PrePostProcessPass_RenderThread 函数。

同样，您可以查找 SceneViewExtension.h 中声明的其他潜在函数及其执行点，以从此扩展中查看引擎的一些其他可访问区域（例如

SetupViewPoint 在帧的早期执行，在 ULocalPlayer::GetViewPoint 中）。

通过上述所有设置，这意味着您现在可以根据需要设计自己的插件的 PrePostProcessPass_RenderThread。

我们将在这里继续使用 ColorCorrectRegions 实现作为示例。

您可能已经注意到 PrePostProcessPass_RenderThread 的完整声明是： 其中三个输入变量是自定义代码的基本构建块。

快速概述： - “const FSceneView& View”可以访问玩家相机的信息和 ViewUniformBuffer 资源（除其他外）。

例如，在 ColorCorrectRegions 代码中，通过将 FSceneView View 对象转换为 FViewInfo 对象并检索视图矩形，从 FSceneView View 对象中检索主视图矩形：“const FSceneView& View”可以访问玩家相机的信息和 ViewUniformBuffer 资源（除其他外）。

例如，在 ColorCorrectRegions 代码中，通过将 FSceneView View 对象转换为 FViewInfo 对象并检索视图矩形，从 FSceneView View 对象中检索主视图矩形：“const FPostProcessingInputs& Inputs”包含对 SceneTextures 的访问（例如

FSceneTextureUniformParameters 中包含的 GBuffer 纹理已全部由之前的帧通道解析（基本通道、光照等均已在此时执行）。

对于 ColorCorrectRegions，专门提取场景颜色纹理，以便在到达后处理通道之前将其用作此新通道中的渲染目标：“FRDGBuilder& GraphBuilder”是渲染依赖关系图的一部分，其中多个渲染通道按顺序排队然后执行。

它是从 FDeferredShadingSceneRenderer::Render 传入的，其中有许多其他渲染通道（例如

所有后处理通道）都被添加到 GraphBuilder 的长队列中。

即

PrePostProcessPass_RenderThread 现在能够在 FDeferredShadingSceneRenderer::Render 管道中的“AddPostProcessingPasses”之前将自己的绘制通道设置到 GraphBuilder 的排队系统中。

如果您查看 FColorCorrectRegionsSceneViewExtension::PrePostProcessPass_RenderThread 中的代码，您应该能够看到 ColorCorrectRegion 的自定义材质着色器执行的所有设置。

创建自己的着色器的指导超出了本文的范围，但引擎中的一些更简单的示例是给定的 FColorCorrectRegionMaterialVS+PS 着色器、FGenerateMipsCS 和 ShadersInPlugins 教程。

然后，PrePostProcessPass_RenderThread 使用 GraphBuilder 的“AddPass”函数以及所需的所有依赖项将绘制通道物理添加到代码中：值得一提的是，并非所有 SceneViewExtension 函数都可以访问提供给 PrePostProcessPass_RenderThread 的相同输入。

例如，在 PostRenderBasePass_RenderThread 中，它在基本通道之后但在光照通道之前等执行，在 FDeferredShadingSceneRenderer::RenderBasePass 的末尾，您可以看到： 这表明 ViewExtension 函数不接收 GraphBuilder 本身，而是接收当前的 RHI 命令列表，因此可以直接从 RHI 层将其他功能添加到命令列表，而不是设置新的 GraphBuilder 通道，或者您可以创建一个新的 GraphBuilder 并在在返回全局 GraphBuilder 之前结束新函数。

这是一个微妙的区别，但在设计任何新的自定义渲染功能时，需要牢记框架中的执行位置。

通常还有其他方法来检索类似数据。

PostRenderBasePass_RenderThread 缺少 FPostProcessingInputs 参数，因此从表面上看，似乎不提供对 SceneTextures 的访问。

但是，在这种情况下，您也可以使用调用“const FSceneTextures& SceneTextures = FSceneTextures::Get(GraphBuilder);”检索场景纹理。

目前我们仅限于引擎中给出的示例，但该系统有很大的灵活性。

如果您无法找到方法来检索代码所需的资源，或者需要有关从哪里开始自定义抽奖通行证的任何进一步建议，请通过 UDN 与我们联系，我们将尽力帮助您走上正确的道路。

在知识库中获取更多答案！

- 虚幻引擎


# 立体渲染中的屏幕空间效果

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/8yBB/unreal-engine-screen-space-effects-in-stereo-rendering

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2424 字符。

## 摘要

立体渲染中的屏幕空间效果 本文由 Joe Conley 撰写 虚幻引擎历史上一直是延迟渲染器。这意味着...

## 中文整理

### 概览

本文由 Joe Conley 撰写 虚幻引擎历史上一直是延迟渲染器。

这意味着它具有有关场景的各种信息，包括存储在缓冲区中的深度和照明信息，这些信息一直存在到帧结束，并且可用于在屏幕空间中执行一些有趣的效果。

不完整列表包括： - 屏幕空间环境光遮挡 屏幕空间环境光遮挡 - 屏幕空间反射 屏幕空间反射 - 色差 色差 - 屏幕空间全局照明 屏幕空间全局照明 这些效果在双眼同时观看二维屏幕时产生非常好的效果。

然而，在立体渲染中，我们需要计算这些效果两次，每只眼睛的每个视图一次。

由于头戴式显示屏的额外视图和更高分辨率，这不仅会变慢，而且不能保证根据一只眼睛的位置计算出的屏幕空间效果和根据另一只眼睛的位置计算出的相同屏幕空间效果在一起观看时看起来是正确的，而且它们通常不会。

由于在一般情况下，当每只眼睛一起观看单独的图像时，没有已知的解决方案如何使这些效果看起来正确（或者在许多情况下甚至舒适地观看），因此立体渲染不支持屏幕空间效果，并且 Epic 不会定期测试这些立体效果。

由于这些原因，我们通常不建议在生产中使用它们。

虚幻引擎还有一个前向着色渲染器（适用于桌面、控制台和一些高端移动设备），通常与立体渲染配合使用。

这确实支持延迟渲染的许多相同功能，但它确实有一些已知的限制，特别是对 GBuffer 的访问不可用于正向渲染器中的纹理采样，并且仅适用于延迟渲染器，因此不支持屏幕空间技术（在立体或非立体渲染中）。

在支持立体渲染的移动平台上，一般使用移动前向渲染器。

该渲染器在支持低功耗硬件方面有其独特的限制，并且通常也不支持屏幕空间技术，因为在这些系统通常使用的平铺 GPU 架构上，后处理通常非常昂贵。

在知识库中获取更多答案！

- 虚幻引擎

## 相关链接

- [Screen Space Ambient Occlusion](https://docs.unrealengine.com/5.1/post-process-effects-in-unreal-engine/#ambientocclusion)
- [Screen Space Reflections](https://docs.unrealengine.com/5.1/post-process-effects-in-unreal-engine/#screenspacereflections)
- [Chromatic Abberation](https://docs.unrealengine.com/5.1/post-process-effects-in-unreal-engine/#chromaticaberration)
- [Screen Space Global Illumination](https://docs.unrealengine.com/5.1/screen-space-global-illumination-in-unreal-engine)
- [Forward Shading Renderer](https://docs.unrealengine.com/4.26/TestingAndOptimization/PerformanceAndProfiling/ForwardRenderer/)
- [support a lot of the same features](https://docs.unrealengine.com/5.1/forward-shading-renderer-in-unreal-engine/#supportedfeatures)
- [known limitations](https://docs.unrealengine.com/5.1/forward-shading-renderer-in-unreal-engine/#knownissues&commonquestions)
- [unique limitations](https://docs.unrealengine.com/5.1/rendering-features-for-mobile-games-in-unreal-engine/)
- [Knowledge Base!](https://forums.unrealengine.com/docs)


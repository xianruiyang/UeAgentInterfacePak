---
title: "纹理流送配置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-configuration-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "纹理流送", "纹理流送配置"]
---

# 纹理流送配置

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 纹理流送 / 纹理流送配置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-configuration-in-unreal-engine

在检查构建的纹理流送的准确性之后，您可能需要调整纹理流送的行为和优先级。 下面的参数可以通过配置文件进行调整，而其中的大多数参数也可以在运行时从控制台窗口进行更新。

| 命令 | 说明 |
| --- | --- |
| `r.TextureStreaming` | 此命令用于启用或禁用纹理流送器。当纹理流送器被禁用后，所有纹理mip都将被完全加载到内存中，即使在纹理从来没有被用于渲染的情况下也是如此。如果需要，您可以在运行时切换此选项。 |
| `r.Streaming.PoolSize` | 引擎中纹理可用的池大小(MB)。这个池包含UI纹理、NeverStream纹理、立方体贴图和流送纹理。在某些平台上，这个池还可以保存非纹理资源，例如GPU粒子缓冲区和顶点缓冲区。设置为0时，池的大小将不受限制。 |
| `r.Streaming.UseFixedPoolSize` | 当使用非零值时，可以在运行时更改纹理池大小。 |
| `r.Streaming.FramesForFullUpdate` | 纹理流送器的每次完整更新之间的帧数。每次更新都会重新计算每个纹理所需的分辨率，并生成mip加载或卸载请求。较高的值会降低纹理流送器CPU使用率，而较低的值会提高其反应能力。 |
| `r.Streaming.UseNewMetrics` | 仅用于兼容性。当设置为假时，纹理流送器将按照4.12版本继续进行处理。 |
| `r.Streaming.MaxTempMemoryAllowed` | 允许用于更新纹理的临时内存量(MB)。此内存量既应大到足以避免无法满足纹理流送，同时又应小到足以防止浪费（未使用的）内存。 |
| `r.Streaming.HLODStrategy` | 此命令控制层级LOD纹理的加载策略： 0 : 允许流送所有mip 1 : 仅流送最后一个mip。始终加载其他mip。 2 : 不流送任何mip。始终加载所有mip。 |
| `r.Streaming.HiddenPrimitiveScale` | 当参考纹理的组件不可见（即其边界框被遮挡）时，此命令控制应用于"所需"分辨率的比例。这只会在它被最大可用分辨率限制之前影响分辨率，以避免已受限的纹理降级。换句话说，它只影响对视口具有适当分辨率的纹理。 |
| `r.Streaming.MaxEffectiveScreenSize` | 当非零时，此命令将限制流送器在计算"所需"纹理分辨率时所考虑的屏幕大小。这将防止高分辨率需要更大的流送池。 |
| `r.Streaming.Boost` | 它是影响"所需"纹理分辨率的全局提升。 |
| `r.Streaming.MipBias` | 它是一个全局mip偏差，用于防止流送器为每个纹理加载最大的mip。它用于容纳一个低流送池。这也会影响流送器尝试为任何视口加载哪些mip，正如使用小型的"r.Streaming.Boost"或限制性的"r.Streaming.MaxEffectiveScreenSize"时一样。 这种偏差的应用方式有几种例外情况： 地形纹理：偏差无影响。 层级LOD纹理：偏差不限制最大分辨率。 光照图和阴影贴图：偏差仅限制最大分辨率。 |
| `r.Streaming.UsePerTextureBias` | 此命令通过限制全局mip偏差对最大允许mip而不是任何视口中的"所需"mip的影响，从而限制全局mip偏差的影响。然后，它会仅将其应用于纹理，以适应流送池。根据预算计算，每个纹理都有自己的mip偏差，范围从0到"MipBias"不等。 |
| `r.Streaming.DropMips` | 这是一个调试选项，用于防止将mip保留在内存中（即便流送池允许如此）： 0 : 不丢掉任何mip。 1 : 丢掉缓存的mip。 2 : 丢掉缓存和隐藏的mip。 这样做的目的是获取所需mip计算的精度，因为显示的分辨率可能会受到先前加载请求或隐藏原语的影响。 |
| `r.Streaming.FullyLoadUsedTextures` | 此命令将把所有使用的纹理流送至它们的最大可用分辨率，并将这些纹理保留在内存中（只要应用程序已打开）。这应当用作完全禁用纹理流送（这种方法将加载从未使用过的纹理，并因此需要更多的内存使用）的替代方法。 |
| `r.Streaming.UseAllMips` | 是否移除来自纹理组设置和动画设置的所有分辨率限制。此命令应仅在展示艺术或制作宣传材料时使用。 |
| `r.Streaming.AnalysisIndex` | 此命令在[材质纹理坐标比例精度查看模式](../building-texture-streaming-data/index.md)中使用，用于调查单独纹理的精度。 |
| `r.Streaming.CheckBuildStatus` | 如果启用，引擎将检查是否需要重建纹理流送，在模拟时或在编辑器中运行（Play in Editor）(PIE)模式下时显示警告。 |
| `r.Streaming.DefragDynamicBounds` | 如果启用，未使用的动态边界将从更新循环中删除。 |
| `r.Streaming.LimitPoolSizeToVRAM` | 如果启用，纹理池大小将被限制为可用的GPU内存。 |
| `r.Streaming.MinMipForSplitRequest` | 如果非0，当非可见mip也必须加载时，此命令允许纹理流送器首先从纹理加载可见mip。此命令通过使可见mip优先于强制加载的mip或可能会变成可见的隐藏mip来改进视觉质量。 |
| `r.Streaming.NumStaticComponentsProcessedPerFrame` | 如果非0，此命令将设置在关卡可见之前引擎在每帧中将递增加载的组件数量。这适用于移动性设置为静态的组件。默认值设置为50。 |
| `r.Streaming.ScaleTexturesByGlobalMyBias` | 流送纹理的"所需"分辨率是否根据全局mip偏差按比例缩小。 |
| `r.Streaming.UseMaterialData` | 材质纹理是否缩放和坐标是否用于纹理流送。 |

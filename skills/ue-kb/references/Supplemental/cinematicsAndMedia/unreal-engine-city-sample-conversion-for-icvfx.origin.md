# ICVFX 的城市示例转换

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/3KxV/unreal-engine-city-sample-conversion-for-icvfx

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4760 字符。

## 摘要

本文档概述了我们在尝试转换 CitySample 项目以与 ICVFX 卷一起使用时发现的一些发现。 nDisplay 目前不支持 World Partition，所以这个练习的最初目标......

## 中文整理

### 概览

本文档概述了我们在尝试转换 CitySample 项目以与 ICVFX 卷一起使用时发现的一些发现。

nDisplay 目前不支持 World Partition，因此本次练习的最初目标是将 World Partition 级别转换为非 World Partition 级别。

**此测试仅关注“小”城市样本级别。** [https://www.unrealengine.com/marketplace/en-US/product/city-sample](https://www.unrealengine.com/marketplace/en-US/product/city-sample) - 资产必须复制/粘贴到新的非世界分区级别。

- 可用 RAM 可能是此方法的限制因素。

- 使用关卡实例将数据传输到因 CitySample 内容而崩溃的非世界分区关卡。

- 如果关卡实例不崩溃，那么这可能是实现关卡转换的另一种方法。

- 需要重新生成层次细节级别 (HLOD)。

- WP HLOD 不再与非世界分区级别兼容。

- WP 中的 HLOD 与加载和卸载的 WP 单元相关。

随着 WP 系统不再使用，我们需要像在 UE4 中一样重新创建 HLOD。

- 可能不需要 HLOD，具体取决于卷的放置位置。

- 大型建筑物可能会自然地遮挡背景网格。

- 分析和 HLOD 测试应根据具体情况进行。

- 从内容浏览器中的 WP HLOD 设置资源复制低 HLOD 设置。

此过程可能需要一天的大部分时间才能完成，因此最好在一夜之间完成此操作。

- 可以使用中或高设置，但需要更长的时间。

- 简化网格和合并网格选项不适用于城市样本网格。

- 添加了新的“近似演员”算法来处理城市样本资产。

- 目前，近似演员 HLOD 存在错误。

- 可以在需要时手动创建代理网格（未测试）。

- 可以手动生成每个集群（未测试）。

- 大量人工智能人群和流量： - 不确定。

- 不建议在 LED 墙上使用 Mass AI 系统。

- 每次模拟开始时，代理都会从不同的位置开始。

这可以被播种，但初始生成后的模拟是不确定的。

- 每次都会产生不同的网格。

- 应使用在 Sequencer 中播放的预动画角色和汽车。

- [https://www.youtube.com/watch?v=p6AzdCFAbTQ](https://www.youtube.com/watch?v=p6AzdCFAbTQ) - 有 3 个后期处理卷。

- 禁用所有两个，一次只使用 1 个。

- 墙壁上可以禁用一些屏幕空间效果。

- 可以禁用自动曝光。

- 晕影可以被禁用。

- TSR 问题 - 尝试以下 CVAR 来减少 TSR 闪烁问题： - 默认情况下 r.TSR.ShadingRejection.Flickering.Period 3 → 8-10 可减少闪烁。

- 示例项目版本可能与目标引擎版本不同，并导致冲突或可能无法编译。

- 使用与您的引擎版本匹配的相同项目版本以避免冲突。

- 场景中有一个 BP_NightMode，其中有一些对场景中演员的引用。

不使用 WorldPartion 时，这些引用可能会中断。

- 如果您想使用夜间模式，则必须手动重新连接引用。

- 如果不需要夜间模式，您可以删除此蓝图。

- 场景未针对 ICVFX 进行优化。

- 通过冻结的外部截锥体，我们确实使用我们的硬件在 LED 墙上实现了 24+ FPS。

- 流明是最重要的 GPU 功能。

- 阴影是第二重要的 GPU 功能。

- 用于优化性能的 Lumen CVAR： - r.Lumen.ScreenProbeGather.DownsampleFactor=32 → 质量越低 - r.Lumen.ScreenProbeGather.RadianceCache.ProbeResolution=16 → 32 质量越高 - 用于测试的附加 Lumed CVRS： - r.Lumen.TranslucencyVolume.GridPixelSize=64 → 质量越低 - r.LumenScene.Radiosity=0 → 1质量较高 - r.Lumen.TraceMeshSDFs.Allow=0 → 1 质量较高 - r.Lumen.ScreenProbeGather.RadianceCache.NumProbesToTraceBudget=300 → 更多质量较高 - r.Lumen.ScreenProbeGather.ScreenSpaceBentNormal=0 → 1 质量较高 - r.Lumen.ScreenProbeGather.TracingOctahedronResolution=8 → 16 是更高的质量 - r.Lumen.ScreenProbeGather.StochasticInterpolation=1 → 0 是更高的质量 - r.Lumen.ScreenProbeGather.FullResolutionJitterWidth=1 → 0.5 是更高的质量 - r.Lumen.TranslucencyVolume.TraceFromVolume=0 → 1 是更高的质量 - r.Lumen.TranslucencyVolume.TracingOctahedronResolution=3 → 4 是更高的质量 - r.Lumen.TranslucencyVolume.RadianceCache.ProbeResolution=8 → 16 质量较高 - r.Lumen.TranslucencyVolume.RadianceCache.NumProbesToTraceBudget=200 → 质量越高 - r.LumenScene.SurfaceCache.CardCaptureRefreshFraction=0 → .125 质量较高


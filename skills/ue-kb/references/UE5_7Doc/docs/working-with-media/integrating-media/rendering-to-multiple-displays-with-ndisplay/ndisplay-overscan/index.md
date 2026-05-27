---
title: "nDisplay过扫描"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-overscan-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay过扫描"]
---

# nDisplay过扫描

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay过扫描

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-overscan-in-unreal-engine

在使用nDisplay进行群集渲染并启用后期效果时，（过扫描有助于）在多个渲染节点上实现像素级别的完美渲染连续性。通过在各个方向（可配置）上实现过扫描（过扫描），然后用曝光量裁剪掉额外的渲染像素，用户可以找出最适合他们项目的（视觉精度-性能）比。

现在，你可以在大多数nDisplay项目中启用高品质视觉效果，例如泛光、AO或动态模糊，但需要一些性能开销（可配置），且影响程度保持在较小范围内。

## 局限性

- 应保持禁用自动曝光，因为过扫描不能解决这个问题。
- 后期效果的范围不超过设定的过扫描百分比时，该技术效果最好。百分比可以是任意值。它旨在减少或尽量减少视觉差异。
- 该实现适用所有项目策略。

## 支持的渲染特性

| 特性 | nDisplay兼容性 | 解决方案 | 注* | 视觉影响 | 累加缓存区 | ICVFX兼容性 |
| --- | --- | --- | --- | --- | --- | --- |
| Rendering / Post Effects |  |  |  |  |  |  |
| [Bloom](../../../../designing-visuals-rendering-and-graphics/post-process-effects/bloom/index.md) | 是* | 过扫描 |  | 高 | 否 | 是 |
| [镜头炫光](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md) | 否 | 避免 |  | 高 | 否 | 是 |
| [自动曝光（眼部适应）](../../../../designing-visuals-rendering-and-graphics/post-process-effects/auto-exposure/index.md) | 否 | 避免 | 将分离逻辑类型。 | 高 | 是 | 是 |
| [Motion Blur](../../../../samples-and-tutorials/content-examples-sample-project/index.md) | 是* | 过扫描 |  | 中 | 否 | 是，但无法很好地用于过场动画。 |
| [Depth of Field (DoF)](../../../../designing-visuals-rendering-and-graphics/post-process-effects/depth-of-field/index.md) | 否t Tested | 避免 |  |  |  |  |
| [屏幕空间环境光遮蔽（SSAO）](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md#ambientocclusion) | 是* | 过扫描 | Keep radius small | 中 | 否 | 是 |
| [时序抗锯齿（TAA）](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md) | 是* | 过扫描 |  | 低 | 是 | 是 |
| [屏幕空间反射（SSR）](../../../../building-virtual-worlds/lighting-the-environment/reflections-environment/screen-space-reflections/index.md) | 否 | 避免 |  | 高 | 是 | 是 |
| [屏幕空间全局光照（SSGI）](../../../../building-virtual-worlds/lighting-the-environment/global-illumination/screen-space-global-illumination/index.md) | 否 | 避免 |  | 高 | 是 | 是 |
| [暗角效果](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md) | 是* | N/A |  | 中 | 否 | 是 |
| [场景边缘效果（色差）](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md) | 是* | 避免 | 保持小半径 | 低 | 否 | 是 |
| [光追（降噪器）](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md#evaluatingdenoiserquality) | 否 |  |  | 低 | 否 | 应该能工作，但噪点是非确定性的。 |
| Rendering / Other |  |  |  |  |  |  |
| [平面反射](../../../../building-virtual-worlds/lighting-the-environment/reflections-environment/planar-reflections/index.md) | 是* | N/A | 用户可以自定义FOV设置。 | 高 | 否 | 是 |
| [天空大气](../../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/sky-atmosphere-component/index.md) | 是 | N/A | 固定 | 高 | 否 | 是 |
| [基于材质（着色器）时间的动画](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-expressions-reference/constant-material-expressions/index.md#time) | 是 |  |  |  | 有时 |  |
| [阴影](../../../../building-virtual-worlds/lighting-the-environment/shadowing/index.md) | 是 |  |  |  | 否 |  |
| [裁剪](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/visibility-and-occlusion-culling/index.md) | 是 |  |  |  | 否 |  |
| [UMG - 2D](../../../../user-interfaces/umg-editor-reference/index.md) | 否 |  |  |  | 否 |  |
| Gameplay |  |  |  |  |  |  |
| [Sequencer](../../real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md) | 是 | N/A | N/A | 高 | 否 | 是 |
| [蓝图](../../../../blueprints-visual-scripting/index.md) | 是/否 | 避免"随机" | 可以使用种子随机。此外，蓝图重新构建时，会产生 BeginPlay 无法运行的问题。 | 高 | 有时 | 是 |
| [物理（Chaos解算器）IK刚体布料](../../../../gameplay-systems/physics/cloth-simulation/clothing-tool/index.md) | 是 | 是 |  | 高 | 否 | 是 |
| [Cascade / Niagara粒子系统](../../../../visual-effects/index.md) | 是 | N/A | 对于发射器来说，决定性设置必须被设置为ON。 | 高 | 有时 | 是 |
| Media / Playback |  |  |  |  |  |  |
| [视频/图像序列](../../media-framework/index.md) | N/A | N/A | 视频引擎目前无法实现帧精确。 | 高 | 否 |  |
| [视频I/O、BM、Aja](../../professional-video-io/index.md) | N/A | N/A | N/A | 高 | 否 |  |
| [NDI/SMPTE 2110](../../media-framework/media-framework-overview/index.md#streammediasource) | N/A | N/A | 需要测试帧准确性。 | 高 | 否 |  |

* 该特性只能在限制范围内运作。例如，泛光只能在小/中程度的泛光辐射下使用，无法用于大型泛光——因为这在性能-品质比例方面没有太大意义。关于各个特性的进一步说明，请参考注释。

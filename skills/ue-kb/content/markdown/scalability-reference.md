# Scalability Reference

---
title: "Scalability Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/scalability-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "可扩展性", "Scalability Reference"]
---

# Scalability Reference

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 可扩展性 / Scalability Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/scalability-reference-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Scalability 设置可用于调整各种功能的质量，从而让游戏在不同平台和硬件上保持最佳性能。

## Scalability 设置

可以在编辑器中通过 Viewport 的 **Performance and Scalability** 菜单访问 Scalability 设置。 **Viewport Scalability**设置包含指向 `BaseScalability.ini` 文件中最常用设置的快捷入口，而 **Material Quality Level** 会设置全局材质质量设置。

![Viewport Performance and Scalability menu and Scalability Groups window](../../../../../assets/images/f3/f379c4b5d84893b32c5050a986f0a379d18105f46ab7309b4ef219f51aa52a63.jpg)

## 分辨率缩放

Unreal Engine 可以以较低分辨率渲染场景，再将图像放大到目标分辨率。由于 2D 用户界面通常性能成本较低，并且更容易受到低分辨率影响，Unreal Engine 不会将此技术应用到 UI。上采样 pass 会有少量成本，但通常值得。

![AA resolution scale comparison](../../../../../assets/images/da/daf6824c9108c611ee7710600771174b9ab2875b8596ad5a7ee5c58c4f13263d.jpg)

左：50% 无 AA；中：50% 有 AA；右：100%（无分辨率缩放）有 AA。

> [!NOTE]
> 较柔和的输入图像有助于上采样步骤。这意味着该 Scalability 选项会受益于另一个 Scalability 选项：抗锯齿质量。

可以通过 **r.ScreenPercentage** 控制台变量访问此设置。它接受 10-100 的值，-1 也等同于 100%。

## 视距

可以基于对象到观察者的距离剔除对象。默认情况下，所有对象都不会按距离剔除（desired max draw distance 为 0）。在设计者指定值之上，还有一个全局 Scalability 设置，它像乘数一样工作（**r.ViewDistanceScale**）。下面可以看到一些草对象（desired max draw distance 为 1000）：

![View distance examples](../../../../../assets/images/6c/6ce804da2120627c661dcccf005cd64f42681ba1f5beff9068728e680ada27eb.jpg)

左：r.ViewDistanceScale 0.4；中：r.ViewDistanceScale 0.7；右：r.ViewDistanceScale 1.0（默认）。

## 抗锯齿

![AA settings examples](../../../../../assets/images/26/266bbb552517552853c259689adad076594a15d64229ef571b29f764c288faa3.png)

从左到右：r.PostProcessAAQuality 0 到 6。前三个对应 Scalability Groups > AA (TSR) 设置中的 Low、Medium、High、Epic。

使用 **r.PostProcessAAQuality** 控制台命令调整抗锯齿质量等级，会影响正在使用的任何抗锯齿方法（FXAA 或 Temporal AA）。

- 对于任一抗锯齿方法，使用值 0 会 **r.PostProcessAAQuality** 禁用该效果。
- 对于 FXAA，可以在上图看到值 2、4、6 的效果；锯齿边缘平滑效果会逐渐提升。
- 高于 6 的值没有效果。

对于 Temporal AA，效果收敛速度和质量之间存在取舍；使用的值越高：

- *r.PostProcessAAQuality*Temporal AA 使用 2 时收敛较快，但该效果导致的抖动会更明显。
- *r.PostProcessAAQuality*4 收敛较慢，但不会抖动。

## 后期处理 - sg.PostProcessQuality

![Post process quality settings examples](../../../../../assets/images/43/432b4c3f299c3707b2a47640a4cda7fb8bf395a592ac5acd24aa09b76c1a76a5.jpg)

sg.PostProcessQuality 从左侧的 0 设置到右侧的 3。

The **Scalability Groups > Post Processing** 选项会根据以下文件中的设置调整后期处理效果质量： `BaseScalability.ini` 文件位于以下文件夹： `[UE_InstallPath]/Engine/Config`. The **Low** 设置等同于 *sg.PostProcessQuality* 0 and **Epic** 等同于 *sg.PostProcessQuality* 3.

| sg.PostProcessQuality 0 | sg.PostProcessQuality 1 |
| --- | --- |
| 配置 `r.MotionBlurQuality=0 r.BlurGBuffer=0 r.AmbientOcclusionLevels=0 r.AmbientOcclusionRadiusScale=1.7 r.DepthOfFieldQuality=0` | 配置 `r.MotionBlurQuality=3 r.BlurGBuffer=0 r.AmbientOcclusionLevels=1 r.AmbientOcclusionRadiusScale=1.7 r.DepthOfFieldQuality=1` |
| sg.PostProcessQuality 2 | sg.PostProcessQuality 3 |
| 配置 `r.MotionBlurQuality=3 r.BlurGBuffer=-1 r.AmbientOcclusionLevels=2 r.AmbientOcclusionRadiusScale=1.5 r.DepthOfFieldQuality=2` | 配置 `r.MotionBlurQuality=4 r.BlurGBuffer=-1 r.AmbientOcclusionLevels=3 r.AmbientOcclusionRadiusScale=1.0 r.DepthOfFieldQuality=2` |

## 阴影 - sg.ShadowQuality

![Shadow Quality settings examples](../../../../../assets/images/97/9736ac712841cb4350f24da7052bc7422a080ec791768198ea5a814f29b86288.png)

sg.ShadowQuality 从左侧的 0 设置到右侧的 3。

The **Scalability Groups > Shadows** 选项会根据以下文件中的设置调整动态阴影质量： `BaseScalability.ini` 文件位于以下文件夹： `[UE_InstallPath]/Engine/Config`. The **Low**设置等同于 *sg.ShadowQuality* 0 and **Epic**等同于 *sg.ShadowQuality* 3.

| sg.ShadowQuality 0 | sg.ShadowQuality 1 |
| --- | --- |
| 配置 `r.LightFunctionQuality=0 r.ShadowQuality=0 r.Shadow.CSM.MaxCascades=1 r.Shadow.MaxResolution=512 r.Shadow.RadiusThreshold=0.06` | 配置 `r.LightFunctionQuality=1 r.ShadowQuality=2 r.Shadow.CSM.MaxCascades=1 r.Shadow.MaxResolution=1024 r.Shadow.RadiusThreshold=0.05` |
| sg.ShadowQuality 2 | sg.ShadowQuality 3 |
| 配置 `r.LightFunctionQuality=1 r.ShadowQuality=5 r.Shadow.CSM.MaxCascades=2 r.Shadow.MaxResolution=1024 r.Shadow.RadiusThreshold=0.04` | 配置 `r.LightFunctionQuality=1 r.ShadowQuality=5 r.Shadow.CSM.MaxCascades=4 r.Shadow.MaxResolution=1024 r.Shadow.RadiusThreshold=0.03` |

## 纹理 - sg.TextureQuality

现代渲染引擎需要大量 GPU 内存（纹理、网格体、GBuffer、深度缓冲、阴影贴图）。其中一些内存使用成本会随屏幕分辨率缩放（例如 GBuffer），另一些则随特定质量设置变化（例如阴影贴图）。另一个主要内存使用成本来自所用纹理（通常会被压缩并流送）。

可以让流送系统以更激进的方式管理（更小池大小、剔除未使用纹理），或在 mip 级别计算中保留更少或更多细节。这会影响图像质量、纹理流送瑕疵的可见程度，以及游戏运行流畅度（更新需要昂贵的内存传输）。结果会因介质不同而变化（例如更快或更慢的硬盘/SSD）。从 DVD 或 Blu-Ray 流送会增加更多延迟，应避免。

纹理质量也会影响纹理过滤模式（**r.MaxAnisotropy**）。限制各向异性采样数量可减少纹理带宽，但不会节省纹理内存。

| sg.TextureQuality 0 | sg.TextureQuality 1 |
| --- | --- |
| 配置 `r.Streaming.MipBias=2.5 r.MaxAnisotropy=0 r.Streaming.PoolSize=200` | 配置 `r.Streaming.MipBias=1 r.MaxAnisotropy=2 r.Streaming.PoolSize=400` |
|  | r.Streaming.MipBias=2.5 |
|  |  |
|  | r.MaxAnisotropy=0 |
|  |  |
|  | r.Streaming.PoolSize=200 |
|  | r.Streaming.MipBias=1 |
|  |  |
|  | r.MaxAnisotropy=2 |
|  |  |
|  | r.Streaming.PoolSize=400 |
| sg.TextureQuality 2 | sg.TextureQuality 3 |
| 配置 `r.Streaming.MipBias=0 r.MaxAnisotropy=4 r.Streaming.PoolSize=700` | 配置 `r.Streaming.MipBias=0 r.MaxAnisotropy=8 r.Streaming.PoolSize=1000` |
|  | r.Streaming.MipBias=0 |
|  |  |
|  | r.MaxAnisotropy=4 |
|  |  |
|  | r.Streaming.PoolSize=700 |
|  | r.Streaming.MipBias=0 |
|  |  |
|  | r.MaxAnisotropy=8 |
|  |  |
|  | r.Streaming.PoolSize=1000 |

> [!NOTE]
> 该功能效果高度取决于游戏和硬件。如果纹理数量不多，以至于加载和使用全分辨率 mip map 也不会用完 Unreal Engine 分配给纹理的内存池，那么除了 Anisotropy 设置变化外，实际上不会看到高低设置之间的差异。

## 特效 - sg.EffectsQuality

The **Scalability Groups > Effects** 选项会根据以下文件中的设置调整多种不同类型特效的质量： `BaseScalability.ini` 文件位于以下文件夹： `[UE_InstallPath]/Engine/Config`. The **Low**设置等同于 *sg.EffectsQuality* 0 and **Epic**等同于 *sg.EffectsQuality* 3.

| sg.EffectsQuality 0 | sg.EffectsQuality 1 |
| --- | --- |
| 配置 `r.TranslucencyLightingVolumeDim=24 r.RefractionQuality=0 r.SSR=0 r.SceneColorFormat=3 r.DetailMode=0` | 配置 `r.TranslucencyLightingVolumeDim=32 r.RefractionQuality=0 r.SSR=0 r.SceneColorFormat=3 r.DetailMode=1` |
| sg.EffectsQuality 2 | sg.EffectsQuality 3 |
| 配置 `r.TranslucencyLightingVolumeDim=48 r.RefractionQuality=2 r.SSR=0 r.SceneColorFormat=3 r.DetailMode=1` | 配置 `r.TranslucencyLightingVolumeDim=64 r.RefractionQuality=2 r.SSR.Quality=1 r.SceneColorFormat=4 r.DetailMode=2` |

## Detail Mode

每个已放置 Actor 都在 Rendering 分类中具有 Detail Mode 属性。该设置定义 Actor 渲染所需的最低细节等级。

![Actor Detail Mode property in the Rendering section.](../../../../../assets/images/3c/3c101aaa9eb7a155e04dcc91301ea27946de6dc3b6db7b268fdd2037e9c8984b.png)

可以从控制台更改 Scalability 模式：

配置

```
r.DetailMode 1
```

CVar 值按如下方式映射到 Detail Mode 属性设置：

- *r.DetailMode* 0 = Low
- *r.DetailMode* 1 = Medium
- *r.DetailMode* 2 = High

![Detail Mode settings examples](../../../../../assets/images/ce/cedae85a55e656fcc4cce518678a7a567c1b2b8f199f9830d6eddbd78a25fb44.jpg)

可以很容易地用它禁用贴花、细节对象、灯光或单个粒子效果。请确保只对不影响 Gameplay 的对象使用它，否则会在网络 Gameplay、存档或一致性方面遇到问题。

## Material Quality Level

> 图片已省略：Material Quality Level in the Viewport Performance and Scalability menu.

材质可以使用 **Quality Switch** Material Expression 节点来禁用某些成本高但对最终外观影响较小的材质部分。要查看效果，需要切换到 **Low Quality** 模式。

> 图片已省略：Blueprint Node layout for Material Quality

将 **Material Quality Level** 设置为 Low 或 High，会决定该材质求值哪些表达式（low 或 high 引脚）。如果没有输入，默认引脚会填充 high、low 或两者。该材质在设置为 high 时包含两个成本较高的 Perlin 噪声操作：

> [!NOTE]
> 此示例用于演示 **Material Switch Node**。 **Noise** 节点成本较高，因此适合作为此示例，但应谨慎使用，因为有更便宜的方式创建这种效果。

> 图片已省略：Material Quality Level settings example

左：Material Quality Level 设为 low；右：Material Quality Level 设为 high。

> 图片已省略：Material Quality Level shader cost

左：Material Quality Level 设为 low；右：Material Quality Level 设为 high。Shader Complexity 模式显示高质量材质比其他着色器成本更高，绿色越深表示着色器成本越高。

> [!NOTE]
> 使用质量切换会导致编译更多着色器（着色器排列）。

该功能不适用于距离 LOD，因为不能同时拥有两个质量等级。该功能可用于减少：

- 着色器计算（例如禁用 fuzz 层）。

  - 使用 **Shader Complexity** 模式（**Alt+8** 在编辑器中）和指令计数来验证优化。
- 纹理查找（无细节凹凸贴图）。
- 内存带宽（例如使用更少纹理）。

  - 需要在实际硬件上进行性能分析来验证。

大多数材质编辑器输出只影响像素着色器。World Position Offset 和所有细分输出会影响其他着色器类型。像素着色器只有在占据屏幕大面积区域时成本才高（例如天空盒），而其他着色器只有在对象未被剔除时才重要（位于视图内，未隐藏在不透明对象后）。

## Skeletal Mesh LOD Bias

> 图片已省略：Skeletal mesh LOD bias

Skeletal Mesh 可以拥有静态 LOD 模型。使用控制台变量 **r.SkeletalMeshLODBias**，可以全局偏移 LOD 等级。根据第一或第二级 LOD 的质量，将此选项放入 Scalability 设置可能很有用。这里可以看到距离相关 LOD 之上的 Scalability 设置。

## 草和植被 Scalability

The **Scalability Groups > Foliage** 选项会根据以下文件中的设置调整同一时间渲染多少植被网格体： `BaseScalability.ini` 文件位于以下文件夹： `[UE_InstallPath]/Engine/Config`. The **Low**设置等同于 *FoliageQuality* 0 and **Epic**等同于 *FoliageQuality* 3.

> [!NOTE]
> 要让 Foliage Static Mesh 与 Scalability 设置一起工作，必须启用 Enable Density Scaling 选项。 有关如何设置的更多信息，请阅读[Foliage Mode](../../../../building-virtual-worlds/open-world-tools/foliage-mode/index.md) 文档。

| FoliageQuality 0 | FoliageQuality 1 |
| --- | --- |
| 配置 `[FoliageQuality@0] foliage.DensityScale=0 grass.DensityScale=0` | 配置 `[FoliageQuality@1] foliage.DensityScale=0.4 grass.DensityScale=0.4` |
|  | [FoliageQuality@0] |
|  |  |
|  | foliage.DensityScale=0 |
|  |  |
|  | grass.DensityScale=0 |
|  | [FoliageQuality@1] |
|  |  |
|  | foliage.DensityScale=0.4 |
|  |  |
|  | grass.DensityScale=0.4 |
| FoliageQuality 2 | FoliageQuality 3 |
| 配置 `[FoliageQuality@2] foliage.DensityScale=0.8 grass.DensityScale=0.8` | 配置 `[FoliageQuality@3] foliage.DensityScale=1.0 grass.DensityScale=1.0` |
|  | [FoliageQuality@2] |
|  |  |
|  | foliage.DensityScale=0.8 |
|  |  |
|  | grass.DensityScale=0.8 |
|  | [FoliageQuality@3] |
|  |  |
|  | foliage.DensityScale=1.0 |
|  |  |
|  | grass.DensityScale=1.0 |

## 自定义 Scalability 设置

可以自定义 Unreal Engine 项目中使用的任意 Scalability 设置。在以下示例中，我们会通过以下方式添加并更改 Foliage 的 Scalability 设置：

- 前往项目的 Config 文件夹并创建新的 `.ini` 文件，命名为 `DefaultScalability.ini`.

  > 图片已省略：Create a new ini file
- 打开新创建的 `DefaultScalability.ini` 文件，并添加以下代码行。

  配置

  ```
  [FoliageQuality@0]
  foliage.DensityScale=.25
  grass.DensityScale=.25

  [FoliageQuality@1]
  foliage.DensityScale=0.50
  grass.DensityScale=0.50

  [FoliageQuality@2]
  foliage.DensityScale=0.75
  ```
- 保存文件。现在，当 **Foliage** 的 Scalability 设置发生变化时，生成的 Foliage 和 Landscape Grass Static Mesh 数量会根据所选设置减少或增加。


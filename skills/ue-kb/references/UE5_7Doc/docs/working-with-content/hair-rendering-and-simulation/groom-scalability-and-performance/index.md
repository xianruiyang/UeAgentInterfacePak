---
title: "Groom的可伸缩性和性能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/groom-scalability-and-performance-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟", "Groom的可伸缩性和性能"]
---

# Groom的可伸缩性和性能

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟 / Groom的可伸缩性和性能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/groom-scalability-and-performance-with-unreal-engine

本页面包含Groom可用的可伸缩性和性能选项信息。

## 几何体可伸缩性

发束几何体能提供自然的毛发动态和外观，但需要分配性能预算，且并非所有平台都支持。如果无法使用发束几何体，Groom还可以使用Groom发片（用发片生成器插件导入或生成）和Groom网格体。你可以将给定的细节级别（LOD）设置为既使用发束几何体，又使用发片/网格体几何体，从而根据平台支持和可伸缩性设置，从容地在不同几何体之间切换。

如需详细了解Groom支持的平台，请参阅[Groom平台支持](../groom-platform-support/index.md)页面。

如需详细了解Groom发片的生成，请参阅[毛发发片生成器](../hair-card-generator-for-grooms/index.md)页面。

## 发束管线概述

下文是对Groom发束渲染管线的概述。这些内容有助于你根据项目的预算和用例调整发束的性能。

渲染管线分解为以下几个阶段：

- 模拟（Simulation）：

  导线的运动是根据场景环境和Groom组件运动来模拟的。
- 插值（Interpolation）：

  导线的运动会转移到渲染发束。如果Groom绑定到骨骼网格体，则转移到已应用的表面蒙皮。
- 体素化（Voxelization）：

  毛发曲线被体素化以生成密度体积。该体积用于计算光照阶段的阴影和毛发透射率。对于使用深度阴影的光源，在此阶段会生成专用的"深度"阴影贴图。
- 主可视性（Primary Visibility）：

  毛发曲线会针对当前摄像机视口进行光栅化，并分配毛发样本以供搭配光照使用。
- 光照（Lighting）：

  所有毛发样本在被照亮时都使用体素或深度阴影数据来附带阴影和透射。
- 合成（Composition）：

  所有毛发样本重新组合并将最终的毛发像素合成到场景颜色缓冲区中。

## 发束资产

场景的性能受被渲染的Groom数量影响。Groom的复杂程度（如内含的 **曲线** 和 **点** 数量）对整体性能有很大影响。Groom的曲线越多，模拟、插值、体素化和主可视性渲染通道的开销就越高。

- 你可以在Groom编辑器的发束（Strands）面板下减少

  曲线/点

  的数量（或重新导入）。
- 自动LOD偏差（Auto LOD bias）

  有助于更快地减少曲线的数量，因为这能减少Groom在屏幕上所占的像素。

## 插值

Groom存在以下情况就会运行插值步骤：

- 启用了

  模拟（Simulation）

  。
- 所附Groom带有

  蒙皮（Skinned）

  绑定。
- 启用了

  径向偏差函数（RBF） / 全局插值（Global Interpolation）

  。

如果Groom绑定被设为 **刚性（Rigid）** （且不存在模拟或RBF），则不会运行插值，且曲线只会通过其依附的骨骼/骨骼网格体进行线性变换。这样可以节省部分开销。

默认情况下，为了投射"最新"的阴影，由非可见Groom投射的阴影将被更新并被体素化。可以借助 `r.HairStrands.Shadow.CastShadowWhenNonVisible` 禁用这些非可见Groom的插值和体素化，从而节省一些插值开销。

> [!TIP]
> 如果几乎察觉不到Groom的阴影，则使用控制台命令 `r.HairStrands.Shadow.CastShadowWhenNonVisible` 可能是一个明智的选择。

## 阴影投射

默认情况下，Groom投射的所有阴影均由Groom的体素化产生。这是因为毛发的体素另有他用，例如Lumen遮蔽和环境光遮蔽，而这种方法能够方便地避免为每个有阴影的光源重新绘制毛发几何体。

阴影的质量和以下几个参数相关：

- 体素大小（Voxel Size）：

  定义单个体素所能达到的最小世界尺寸。视距相同时，体素大小越大，阴影的外观就越粗糙，但体素化和光照的开销越低。使用控制台命令

  r.HairStrands.Voxelization.VoxelSizeInPixel

  即可对其进行设置。默认值为0.3。
- 体素的像素大小（Voxel Size in Pixel）：

  以像素为单位定义体素的有效大小。这意味着Groom离摄像机越远，实际的体素就越大。可以降低体素化和照明的开销。使用控制台命令

  r.HairStrands.Voxelization.VoxelSizeInPixel

  即可对其进行控制。此参数默认启用。

在计算阴影或透射率时，需要遍历体素结构，从而估算遮蔽/透射率的值。具体做法是对体素 **分步** 进行光线行进。增大每一步之间的间距可以提高速度，减小间距则以提高质量

步进越大，遍历的速度越快，但结果越粗糙，因为得到的Mip也会越粗糙。调整步进缩放会在一定限度内影响光照开销，但会降低阴影和毛发透射质量。具体由控制台命令 `r.HairStrands.Voxelization.RayMarching.SteppingScale` 进行控制。光照集成的不同部分（如阴影、环境、光照、传输等）都有不同的变体。

使用虚拟阴影贴图时，可用 `r.Shadow.Virtual.SMRT.SamplesPerRayHair` 增加逐像素的取样数，从而优化阴影边缘的噪点。默认值为每个像素1个样本（1 SSP）。

如果某个Groom投射的阴影对大部分光源而言无必要，那么你可以在资产或实例上禁用该Groom的体素化。然后，你可以选择让重要的光源投射 **深度不透明阴影（Deep Opacity Shadow）** ，从而创建与透射率计算兼容的逐光源阴影贴图。

## 光栅化

在光栅化的过程中，你可以配置控制台命令 `r.Shadow.Virtual.SMRT.SamplesPerRayHair` 来平衡性能与质量。

- 使用

  多重取样抗锯齿（Multi-Sample Anti-Aliasing）

  （MSAA）技术时（默认），亚像素取样数取值范围为1至8（默认设为4）。
- 你可以选择使用 **逐像素链接列表（Per-Pixel Linked List）** （PPLL）技术来增加亚像素的数量（最多32个），从而获得更精细的透明效果。该技术会为存储一长串的逐像素的取样数数据。

  > [!WARNING]
  > 此选项开销非常大，应该仅用于线性媒体和预计算的过场动画。

## 环境光照

针对环境光照，可通过两种技术让毛发取得质量和速度的权衡：

- 快速单样本环境光求值（

  r.HairStrands.SkyLighting.IntegrationType 2

  ）。得到的质量因环境光照的平滑程度而异。
- 使用多重取样的高质量双向散射分布函数（BSDF）集成。能以更高的性能开销带来更高的质量（

  r.HairStrands.SkyLighting.IntegrationType 1

  ）。取样数量可通过

  r.HairStrands.SkyLighting.SampleCount

  进行控制，从而权衡噪点的数量。

使用 `r.HairStands.SkyLighting.ScreenTraceOcclusion` 可启用小范围的遮蔽，以衡量细节遮蔽。例如对睫毛进行特写。

> [!TIP]
> 通常情况下，毛发投射的环境光遮蔽都非常柔和且难以察觉，但开销极大。你可以使用 `r.HairStrands.SkyAO 0` 关闭这种环境光遮蔽

## 光线追踪

默认禁用毛发发束的光线追踪几何体。你可以按资产和实例逐个选择是否启用。光线追踪Groom的几何体会耗费大量内存。如果Groom带有动画（蒙皮的或模拟的），则其更新成本也不容忽视。光线追踪几何体应在需要时使用，并且应在最需要精确投射阴影的小型Groom部分使用。例如，让强烈的定向光源投射出纤细的睫毛阴影。

使用 `r.HairStrands.Raytracing 0` 即可禁用光线追踪几何体。

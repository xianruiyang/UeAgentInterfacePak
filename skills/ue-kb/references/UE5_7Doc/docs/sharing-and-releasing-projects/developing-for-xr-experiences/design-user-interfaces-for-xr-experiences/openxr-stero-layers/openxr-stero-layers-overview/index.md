---
title: "OpenXR立体图层概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/openxr-stero-layers-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "为XR体验设计UI", "OpenXR立体图层", "OpenXR立体图层概述"]
---

# OpenXR立体图层概述

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 为XR体验设计UI / OpenXR立体图层 / OpenXR立体图层概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/openxr-stero-layers-overview-in-unreal-engine

OpenXR立体图层允许你在一个单独通道中将纹理投射到头戴式显示设备（HMD）的屏幕上，从而避免纹理受到不该有的效果（例如后期处理特效、抗锯齿等）。这在设计UI内容时十分有效。

> [!NOTE]
> OpenXR立体图层内容会渲染到HMD显示设备上，但这些内容不会出现在桌面电脑的 **VR预览（VR Preview）** 窗口中。

本文介绍了OpenXR的OpenXR立体图层功能。如需了解如何将立体图层功能添加到你的OpenXR应用中，请参阅[OpenXR立体图层快速入门](../openxr-stereo-layers-quick-start/index.md)。

## 立体图层类型

你可以设置立体图层内容参照哪个空间坐标系进行平移和旋转。包含以下模式：

- **面部锁定（Face-Locked）** ：立体图层内容保持在屏幕中的固定位置，无论你如何移动或旋转头戴设备。
- **追踪器锁定（Tracker-Locked）** ：相对于玩家周围的真实世界的追踪空间。
- **世界锁定（World-Locked）** ：相对于立体图层内容绑定的组件。

> [!NOTE]
> 目前不支持通过 `vr.StereoLayers.bMixLayerPriorities` 控制台变量来混合面部锁定（Face-Locked）、世界锁定（World-Locked）和追踪器锁定（Tracker-Locked）图层的优先级。

## 图层形状

你可以调整图层的形状。目前，OpenXR立体图层仅支持 **四边形（Quad）**。

## 图层绘制顺序

立体图层独立于虚拟场景，它会根据每个图层的 **优先级（Priority）** 进行绘制。绘制顺序由以下因素决定：

- 高优先级图层先于低优先级图层渲染。
- 无论优先级如何，面部锁定图层都先于世界锁定或追踪器锁定图层渲染。
- 当图层优先级相同时，这些图层将以不定顺序渲染。如果你希望它们按顺序渲染，请为它们指定不同优先级。

## 立体图层优先级

立体图层提供了一些设置，允许你修改其渲染方式。下表介绍了这些设置以及它们的作用。

| **设置名称** | **说明** |
| --- | --- |
| **动态纹理（Live Texture）** | 如果立体图层纹理需要每帧（场景捕捉、视频等）自我更新，为True。 |
| **支持深度（Supports Depth）** | 如果立体图层需要支持与场景几何体的深度相交（如果平台提供），为True。OpenXR当前不支持此选项。 |
| **无Alpha通道（No Alpha Channel）** | 如果纹理不应该使用自己的alpha通道（将替换为1.0），为True。 |
| **纹理（Texture）** | 立体图层上显示的纹理（如果平台支持立体纹理，并且提供多个纹理，此为右眼）。 |
| **四边形保留纹理比率（Quad Preserve Texture Ratio）** | 如果四边形应根据设置的纹理尺寸在内部设置其Y值，为True。 |
| **立体图层类型（Stereo Layer Type）** | 指定将四边形渲染到屏幕的方式和位置。 |
| **立体图层形状（Stereo Layer Shape）** | 指定图层的形状。OpenXR仅支持 **四边形（Quad）** 图层形状。 |
| **优先级（Priority）** | 所有立体图层的渲染优先级；较高优先级先于较低优先级渲染。 |
| **左纹理（Left Texture）** | 如果平台支持立体纹理，则纹理显示在左眼的立体图层上。 |
| **四边形尺寸（Quad Size）** | 渲染的立体层四边形的尺寸。 |
| **UVRect** | 映射到四边形面的UV坐标。 |
| **圆柱体半径（Cylinder Radius）** | 渲染的立体层圆柱体的径向尺寸。 |
| **圆柱体覆层弧（Cylinder Overlay Arc）** | 立体图层圆柱体的弧角。 |
| **圆柱体高度（Cylinder Height）** | 立体图层圆柱体的高度。 |

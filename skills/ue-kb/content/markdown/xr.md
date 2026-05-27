# XR性能功能

---
title: "XR性能功能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/xr-performance-features-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR性能和分析", "XR性能功能"]
---

# XR性能功能

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR性能和分析 / XR性能功能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/xr-performance-features-in-unreal-engine

因为XR的渲染要求极高，所以虚幻引擎（UE）引入了专用于XR的多种性能优化和新渲染模式。 以下文档将介绍这些功能以及如何在UE XR项目中使用这些功能。

## 可变速率着色和固定注视点渲染

**可变速率着色（Variable Rate Shading，VRS）**是较新的GPU才支持的功能，它提供多种方法来调整一个或多个渲染目标中像素的着色速率。 任何设置中的默认着色率都是1:1，也就是说1次像素着色器调用应用于屏幕上的1个目标像素。 如果采用VRS，则可以指定其他着色率，具体包括1x2、2x1、2x2、2x4、4x2和4x4。 举例来说，对于2x2着色率，单次像素着色器调用会处理一组2x2像素（4个像素），而对于4x4，单次像素着色器调用会处理4x4的像素组（16个像素）。

可以基于每个材质应用着色率，也可以通过着色率图像附件（通过Tier 2 VRS）应用着色率。

**固定注视点渲染（Fixed Foveated Rendering）**技术可以利用VR头戴设备中基于图像的VRS功能来调整目标的着色率，从而降低视图边缘的着色率。 因为光学失真，GPU在接近图像边缘的位置会丢失越来越多的像素细节，所以通过应用距离图像中心越远着色率越低的VRS图像，可以提高性能，而可以感知的图像质量退化却很小。

固定注视点使用通过计算着色器生成的附件：

两侧的中心（黑色）区域对应每个立体视图的中心；越暗的区域着色率越高，黑色是全着色率（1x1，每像素调用一次像素着色器），在x和y轴上都是深红色为半速率（2x2，每4个像素调用1次像素着色器），略浅的红色为四分之一速率（4x4，每16个像素调用1次像素着色器）。

对基础通道和透明通道应用VRS附件后，其初步结果显示很有潜力。 目前这仍处于概念验证阶段，它可以应用于除基础通道和透明通道以外的其他地方。

### 项目设置

如需访问VRS设置，请从主菜单转至**编辑（Edit） > 项目设置（Project Settings）**。 然后打开**项目设置（Project Settings）**窗口，转到**引擎（Engine）> 渲染（Rendering） > VR**。

### 控制台变量

你可以使用以下控制台变量：

| 变量 | 说明 |
| --- | --- |
| r.vrs.Enable | 跨引擎启用或禁用VRS（基于材质的VRS和任何基于图像的活动VRS）。 |
| r.VRS.EnableImage | 仅启用或禁用基于图像的VRS。 如果已启用和支持每材质VRS，它仍将起作用。 |
| vr.VRS.HMDFixedFoveationLevel | HMD 固定注视点渲染质量和性能设置。 |
| vr.VRS.HMDFixedFoveationDynamic | 启用或禁用是否应根据GPU使用情况调整固定注视点级别。 |

### 已知限制

- 仅适用于支持DirectX 12和VRS Tier 2的Windows设备、支持Vulkan和VK_KHR_fragment_shading_rate扩展的Windows设备以及Oculus Quest。
- 不兼容NVIDIA的DLSS。
- 目前不支持眼球追踪注视点渲染。

## 实例化立体

实例化立体渲染（Instanced Stereo Rendering）减轻了XR在UE中的性能影响。 要启用此功能，请找到**项目设置（Project Settings） > 引擎（Engine）> 渲染（Rendering）> 实例化立体（Instanced Stereo）**选项，然后勾选**实例化立体（Instanced Stereo）**选项。

![VR设置中启用的实例化立体选项](../../../../../assets/images/f9/f927437c5d676ae2c6a872731c699ba274f909e64fa9bcce0ab136a82c773cbd.jpg)

点击查看大图。

启用**实例化立体（Instanced Stereo）**渲染后，需要重新启动引擎并重新编译着色器。 基础通道和Early-Z通道适用于静态网格体、骨骼网格体、Sprite粒子和启用了该功能的网格体粒子（串行和并行渲染路径）。 **实例化立体（Instanced Stereo）**目前可在PC（DirectX）和PS4上运行，在最初的4.11版本之后支持其他平台。 下面的视频展示VR中的标准立体渲染与VR中的实例化立体渲染。

## 移动设备的多视图支持

某些（受支持的）移动设备现在可以支持VR多视图。 移动多视图类似于可用于桌面PC的实例化立体渲染，通过在移动设备的CPU上为立体渲染提供优化路径来执行工作。 要启用此功能，需要执行以下操作：

1. 找到主工具栏，转到**编辑（Edit）** > **项目设置（Projects Settings）**即可打开编辑器的项目设置。
2. 然后转到**引擎（Engine）** > **渲染（Rendering）** > **VR**，找到**移动多视图（Mobile Multi-View）**选项。
3. 启用移动多视图（Mobile Multi-View）选项，然后重新启动虚幻引擎使更改生效。

   ![启用VR设置中的移动多视图选项](../../../../../assets/images/97/97c166eb00805983e672defeb67bfb427d131b2f4f99d06289eec2583a5d2a29.jpg)

> [!WARNING]
> - 移动多视图功能仅支持基于Mali的新型GPU。
> - 如果你打包了此项目但没有兼容的GPU，则此功能会在运行时被禁用。

## 前向渲染

By default, Unreal Engine uses a Deferred Renderer as it provides the most versatility and grants access to more rendering features. However, there are some trade-offs in using the Deferred Renderer that might not be right for all VR experiences. **Forward Rendering** provides a faster baseline, with faster rendering passes, which may lead to better performance on VR platforms. Not only is Forward Rendering faster, it also provides better anti-aliasing options than the Deferred Renderer, which may lead to better visuals.

> [!NOTE]
> 如需详细了解此功能，请参阅[XR最佳实践](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/forward-shading-renderer/index.md)。

## 性能分析

要追踪对VR来说性能成本过高的资产，需要在项目的整个生命周期内尽可能多地分析项目在CPU和GPU上的操作。

- **GPU分析（GPU Profiling）** — 要激活GPU分析器，在运行项目时同时按**Ctrl + Shift + ,（逗号键）**即可。 按下这些键后，会出现一个新窗口，外观类似于下图所示。

  ![GPU查看器](../../../../../assets/images/5c/5cdcac945016d5d27749d2388b7d7581507e9a0f9d9767e6b2f95698ac34355f.jpg)
- **GPU分析器（CPU Profiler）** — 分析项目在CPU上的操作比针对GPU的分析更复杂。 要了解有关如何执行分析的更多信息，请参阅性能分析器文档。

## 后期处理设置

因为XR的渲染要求极高，许多默认启用的高级后期处理功能应该被禁用，否则项目 性能可能受到影响。 要在项目中完成此操作，需要执行以下操作。

1. 如果关卡中还没有后期处理（PP）体积，请添加它。 1. 选择后期处理体积，并在**后期处理体积（Post Process Volume）**分段中启用**无限范围（无边界）（Infinite Extent (Unbound)）**选项，以便将后期处理体积中的设置应用于整个关卡。

![启用后期处理体积的无限范围选项(enable-unbound-post-process-volume.png)

1. 展开**后期处理体积（Post Process Volume）**的**设置（Settings）**，然后检查所有分段并禁用所有活动的后期处理设置，方法是启用对应属性，点击相应设置，将值从默认值（通常为1.0）设置为**0**，从而禁用该功能。

![启用镜头光晕强度且将其设为0](../../../../../assets/images/71/718209b965bbc1aaa575120dd18e196ec774e06746f6e030a4100332d21340e4.jpg)

> [!NOTE]
> 执行此操作时，无需点击每个分段并将所有属性设置为0。 而应该首先禁用真正起重要影响的功能，如镜头光斑（Lens Flares）、屏幕空间反射（Screen Space Reflections）、临时抗锯齿（Temporal AA）、SSAO、泛光（Bloom）以及其他任何可能对性能有影响的功能。


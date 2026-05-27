---
title: "设计视觉、渲染和图形效果"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/designing-visuals-rendering-and-graphics-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果"]
---

# 设计视觉、渲染和图形效果

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/designing-visuals-rendering-and-graphics-with-unreal-engine

虚幻引擎的渲染系统是其拥有业界领先画质以及卓越的交互式实时体验的关键所在。在本文中，你将见识到可用于设计、开发项目的各种功能、概念及工具；通过它们，你可以开发出拥有影视级品质的作品，也可以为次世代主机和移动平台打造拥有无与伦比真实度的作品。

下列主题能帮助你设置并管理纹理及材质，然后应用到模型表面上，它们还有助于你了解一些概念性的光照技巧，帮助你[搭建虚拟场景世界](../building-virtual-worlds/lighting-the-environment/index.md)，创建令人惊艳的视觉效果，对性能进行优化和调试，以及更多内容。

## 虚幻引擎5中的全新渲染功能和工具

%building-virtual-worlds/lighting-and-shadows/global-illumination/lumen:Topic%


- [Lumen技术细节](../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/lumen-technical-details/index.md)

- [GPU转储文件查看器工具](optimizing-and-debugging-projects-for-realtime-rendering/gpudump-viewer-tool/index.md) - 这个多平台命令可以将中间RDG纹理和缓冲转储至磁盘中，用以调查并调试渲染问题。

- [渲染依赖图](graphics-programming/render-dependency-graph/index.md) - 一种即时模式API，可将要编译和执行的渲染命令记录到图数据结构中。

%designing-visuals-rendering-and-graphics/rendering-optimization/nanite:Topic% %building-virtual-worlds/lighting-and-shadows/shadows/virtual-shadow-maps:Topic% %designing-visuals-rendering-and-graphics/materials/substrate-materials:Topic% %building-virtual-worlds/lighting-and-shadows/ray-tracing-and-path-tracing/path-tracer:Topic%

## 美术设置及工具


- [纹理](textures/index.md)

- [材质](unreal-engine-materials/index.md) - 使用着色器控制世界中表面的外观。

- [基于物理的材质](unreal-engine-materials/physically-based-materials/index.md) - 基于物理的材质主要输入及其最佳使用方法的概述。

- [UV编辑器](../working-with-content/modeling-and-geometry-scripting/uv-editor/index.md) - UV编辑器界面和工具概述。

## 光照概念和功能


- [为场景设置光照](../building-virtual-worlds/lighting-the-environment/index.md)

- [全局光照](../building-virtual-worlds/lighting-the-environment/global-illumination/index.md) - 介绍可供选择的全局光照选项。

- [Lumen技术细节](../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/lumen-technical-details/index.md) - 深入介绍通过软件或硬件光线追踪使用Lumen全局光照以及反射功能的技术细节。

- [异类体积](../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/heterogeneous-volumes/index.md) - 使用异类体积组件渲染从稀疏体积纹理取样的体积域材质。

- [稀疏体积纹理](../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/sparse-volume-textures/index.md) - 该资产将存储烘焙的模拟数据来表示体积介质，例如烟雾、火焰和水。

- [硬件光线追踪和路径追踪功能](../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/index.md) - 探索使用光线追踪光照功能设置并使用实时硬件光线追踪和路径追踪渲染场景的话题。

- [直接光照](../building-virtual-worlds/lighting-the-environment/features-and-properties-of-lights/index.md) - 关于光源支持的各种属性和特性的概述。

- [光源类型及其可移动性](../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/index.md) - 可供选择的可用光源类型及其移动性设置如何影响场景中的光照。

- [网格体距离场](../building-virtual-worlds/lighting-the-environment/mesh-distance-fields/index.md) - 概述网格体距离场以及你在开发游戏可以用到的相关功能。

- [反射环境](../building-virtual-worlds/lighting-the-environment/reflections-environment/index.md) - 捕捉并显示局部光泽反射的系统。

- [阴影](../building-virtual-worlds/lighting-the-environment/shadowing/index.md) - 介绍可用的阴影方法以及它们提供的属性。

%building-virtual-worlds/lighting-and-shadows/global-illumination/lumen:Topic% %building-virtual-worlds/lighting-and-shadows/shadows/virtual-shadow-maps:Topic% %building-virtual-worlds/lighting-and-shadows/environmental-lighting:Topic%

## 常用渲染功能


- [渲染组件](general-features-of-rendering/rendering-components/index.md)

- [骨骼网格体渲染路径](general-features-of-rendering/skeletal-mesh-rendering-paths/index.md) - 关于骨骼网格体可用渲染路径的简要概述。

- [如何将影片渲染队列用于高质量渲染](../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/rendering-high-quality-frames-with-movie-render-queue/index.md) - 关于虚幻引擎影片渲染队列功能的配置指南，旨在帮助你便获取高质量过场动画（特别适用于启用光线追踪的情况下）。

- [创建并使用 LOD](../working-with-content/static-meshes/creating-and-using-lods/index.md) - 如何创建并使用 LOD。

- [理解虚幻引擎中的光照贴图](../working-with-content/static-meshes/understanding-lightmapping/index.md) - 关于为静态网格体设置光照贴图UV的技巧和指南。

- [生成光照贴图UV](../working-with-content/static-meshes/understanding-lightmapping/generating-lightmap-uvs/index.md) - 介绍如何在虚幻引擎中生成你自己的光照贴图UV。

%building-virtual-worlds/landscape-outdoor-terrain/landscape-material-layer-blending:Topic%

## 视觉和系统工具


- [后期处理效果](post-process-effects/index.md)

- [创建视觉效果](../visual-effects/index.md) - 虚幻引擎的Niagara视觉效果系统可用于创建和实时预览粒子效果。

- [XR最佳实践](optimizing-and-debugging-projects-for-realtime-rendering/forward-shading-renderer/index.md) - 关于创建与优化XR项目的最佳实践

- [正交摄像机](../gameplay-systems/gameplay-framework/cameras/orthographic-camera/index.md) - 介绍摄像机的正交投影设置。

## 性能和调试


- [优化和调试实时渲染项目](optimizing-and-debugging-projects-for-realtime-rendering/index.md)

- [抗锯齿和上采样](optimizing-and-debugging-projects-for-realtime-rendering/anti-aliasing-and-upscaling/index.md) - 虚幻引擎中提供的抗锯齿选项的简要概述。

- [时间超级分辨率](optimizing-and-debugging-projects-for-realtime-rendering/anti-aliasing-and-upscaling/temporal-super-resolution/index.md) - 虚幻引擎中提供的抗锯齿选项的简要概述。

- [虚拟纹理](optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/index.md) - 介绍虚幻引擎中虚拟纹理的使用方法。

- [可视性和遮挡剔除](optimizing-and-debugging-projects-for-realtime-rendering/visibility-and-occlusion-culling/index.md) - 介绍了虚幻引擎中的可视性与遮挡剔除方法。

- [GPU转储文件查看器工具](optimizing-and-debugging-projects-for-realtime-rendering/gpudump-viewer-tool/index.md) - 这个多平台命令可以将中间RDG纹理和缓冲转储至磁盘中，用以调查并调试渲染问题。

- [纹理流送](optimizing-and-debugging-projects-for-realtime-rendering/texture-streaming/index.md) - 用于在运行时在内存中加载和卸载纹理的系统。

- [渲染资源查看器](optimizing-and-debugging-projects-for-realtime-rendering/render-resource-viewer/index.md) - 一个帮助识别分配给GPU内存的资源及其资产的工具。

%designing-visuals-rendering-and-graphics/rendering-optimization/nanite:Topic% %designing-visuals-rendering-and-graphics/rendering-optimization/render-doc:Topic%

## 移动渲染和可视化


- [移动端渲染功能](../mobile-development/rendering-features-for-mobile-games/index.md)

- [移动预览器](../mobile-development/development-tools-for-mobile-applications/using-the-mobile-previewer/index.md) - 基于所选的移动端平台，在虚幻引擎编辑器中预览游戏。

## 可视化工具

%building-virtual-worlds/lighting-and-shadows/ray-tracing-and-path-tracing/path-tracer:Topic%


- [HDRI背景可视化工具](../building-virtual-worlds/lighting-the-environment/lighting-tools-and-plugins/hdri-backdrop-visualization-tool/index.md)

- [太阳和天空Actor](../building-virtual-worlds/lighting-the-environment/lighting-tools-and-plugins/sun-and-sky-actor/index.md) - 一个可以提供日夜时间系统的工具，并且可以根据地点、日期和时间精确地调整时间。

- [地理位置准确的太阳定位工具](../building-virtual-worlds/lighting-the-environment/lighting-tools-and-plugins/geographically-accurate-sun-positioning-tool/index.md) - 让你可以根据纬度、经度、日期和时间精细控制太阳地理位置的工具。

## 第三方工具


- [第三方渲染工具和插件](third-party-rendering-tools-and-plugins/index.md)

## 图形编程

- [异步计算](graphics-programming/asynccompute/index.md) - 异步计算（AsyncCompute） 是一种硬件功能，用于交错不同GPU任务并提高工作效率。

- [FShaderCache](graphics-programming/fshadercache/index.md) - FShaderCache 提供的机制可减少游戏中着色器的卡顿。

- [网格体绘制管道](graphics-programming/mesh-drawing-pipeline/index.md) - 介绍如何添加自定义网格体通道以及虚幻引擎网格体绘制的性能特定。

- [图形编程介绍](graphics-programming/graphics-programming-overview/index.md) - 介绍图形程序员如何使用渲染系统和编写着色器。

- [并行渲染介绍](graphics-programming/parallel-rendering-overview/index.md) - 介绍并行渲染

- [渲染依赖图](graphics-programming/render-dependency-graph/index.md) - 一种即时模式API，可将要编译和执行的渲染命令记录到图数据结构中。

- [着色器开发](graphics-programming/shader-development/index.md) - 面向编写着色器的图形程序员的信息。

- [插件中的Shader](graphics-programming/shaders-in-plugins/index.md) - 在插件中创建和使用Shader。

- [插件中的 Shader](graphics-programming/overview-of-shaders-in-plugins/index.md) - 介绍如何在插件中编写 Shader

- [新建全局着色器并作为插件](graphics-programming/creating-a-new-global-shader-as-a-plugin/index.md) - 通过插件来新建和设置全局着色器。

- [线程渲染](graphics-programming/threaded-rendering/index.md) - 针对图形程序员的线程渲染器使用信息。


- [大型世界坐标渲染介绍。](../gameplay-systems/large-world-coordinates/large-world-coordinates-rendering/index.md)

## 人工智能/机器学习


- [神经网络引擎](../gameplay-systems/artificial-intelligence/neural-network-engine/index.md)

---
title: "为场景设置光照"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/lighting-the-environment-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照"]
---

# 为场景设置光照

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/lighting-the-environment-in-unreal-engine

在搭建虚拟世界时，设计光照的方式将会是重要的一环。这意味着你既要考虑如何用一些小型光源为小型的封闭场景打光，也要考虑如何用单盏大型光源为大型场景打光。虚幻引擎提供了各种工具和光照选项，能满足你的项目的各种需求。

本文主题介绍了各种可用的光照功能和工具，同时还包含了在虚幻引擎中对场景进行光照的学习路径介绍。

## 全新UE5光照功能

%building-virtual-worlds/lighting-and-shadows/global-illumination/lumen:Topic%


- [Lumen技术细节](global-illumination/lumen-global-illumination-and-reflections/lumen-technical-details/index.md)

%building-virtual-worlds/lighting-and-shadows/shadows/virtual-shadow-maps:Topic%

## 光照基本知识


- [光源类型及其可移动性](light-types-and-their-mobility/index.md)

- [直接光照](features-and-properties-of-lights/index.md) - 关于光源支持的各种属性和特性的概述。

- [设计视觉、渲染和图形效果](../../designing-visuals-rendering-and-graphics/index.md) - 介绍渲染相关的子系统，包括光照阴影、材质纹理、视觉特效以及后期处理。

## 光照功能和工具

%building-virtual-worlds/lighting-and-shadows/environmental-lighting:Topic%


- [全局光照](global-illumination/index.md)

- [网格体距离场](mesh-distance-fields/index.md) - 概述网格体距离场以及你在开发游戏可以用到的相关功能。

- [硬件光线追踪和路径追踪功能](ray-tracing-and-path-tracing-features/index.md) - 探索使用光线追踪光照功能设置并使用实时硬件光线追踪和路径追踪渲染场景的话题。

- [阴影](shadowing/index.md) - 介绍可用的阴影方法以及它们提供的属性。

- [反射环境](reflections-environment/index.md) - 捕捉并显示局部光泽反射的系统。

%building-virtual-worlds/lighting-and-shadows/global-illumination/lumen:Topic% %building-virtual-worlds/lighting-and-shadows/shadows/virtual-shadow-maps:Topic%

## 光照工具和插件

%building-virtual-worlds/lighting-and-shadows/lighting-tools-plugins:Topic%


- [接触阴影](shadowing/contact-shadows/index.md)

- [胶囊体阴影](shadowing/capsule-shadows/index.md) - 使用物理胶囊体来实现骨骼网格体的动态软阴影。

## 综合


- [后期处理效果](../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)

- [在材质中使用透明度](../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-materials-tutorials/using-transparency-in-unreal-engine-materials/index.md) - 本页面说明了如何在你的材质中使用透明度。

- [使用凹凸贴图偏移](../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-materials-tutorials/using-bump-offset/index.md) - 有关在材质中使用凹凸贴图偏移（Bump Offset）节点的指南。

- [IES光源描述文件](features-and-properties-of-lights/using-ies-light-profiles/index.md) - 介绍如何设置光源使用IES纹理。

- [HDRI背景可视化工具](lighting-tools-and-plugins/hdri-backdrop-visualization-tool/index.md) - 一个蓝图工具，通过使用带有实时光照和阴影的HDR图像投影，快速设置你的产品可视化效果。

%building-virtual-worlds/lighting-and-shadows/environmental-lighting/volumetric-fog:Topic% %building-virtual-worlds/lighting-and-shadows/features-of-lights/light-shafts:Topic%

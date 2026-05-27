---
title: "图形编程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/graphics-programming-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "图形编程"]
---

# 图形编程

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 图形编程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/graphics-programming-for-unreal-engine

引擎中的渲染器模块管理并渲染场景，而场景拥有和每个世界场景相关的可渲染信息。它包括所有绘制规则和着色器的定义。

RHI 模块是渲染 API 的接口，是图形编程的另一个关键组件。[图形编程介绍](graphics-programming-overview/index.md)包含许多可研究的键类、设置和变量，以下子页面包含详细的渲染要点。

- [异步计算](asynccompute/index.md) - 异步计算（AsyncCompute） 是一种硬件功能，用于交错不同GPU任务并提高工作效率。

- [FShaderCache](fshadercache/index.md) - FShaderCache 提供的机制可减少游戏中着色器的卡顿。

- [网格体绘制管道](mesh-drawing-pipeline/index.md) - 介绍如何添加自定义网格体通道以及虚幻引擎网格体绘制的性能特定。

- [图形编程介绍](graphics-programming-overview/index.md) - 介绍图形程序员如何使用渲染系统和编写着色器。

- [并行渲染介绍](parallel-rendering-overview/index.md) - 介绍并行渲染

- [渲染依赖图](render-dependency-graph/index.md) - 一种即时模式API，可将要编译和执行的渲染命令记录到图数据结构中。

- [着色器开发](shader-development/index.md) - 面向编写着色器的图形程序员的信息。

- [插件中的Shader](shaders-in-plugins/index.md) - 在插件中创建和使用Shader。

- [插件中的 Shader](overview-of-shaders-in-plugins/index.md) - 介绍如何在插件中编写 Shader

- [新建全局着色器并作为插件](creating-a-new-global-shader-as-a-plugin/index.md) - 通过插件来新建和设置全局着色器。

- [线程渲染](threaded-rendering/index.md) - 针对图形程序员的线程渲染器使用信息。

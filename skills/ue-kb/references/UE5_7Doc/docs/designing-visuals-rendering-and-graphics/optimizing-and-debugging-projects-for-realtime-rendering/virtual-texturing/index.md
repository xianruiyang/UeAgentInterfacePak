---
title: "虚拟纹理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/virtual-texturing-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "虚拟纹理"]
---

# 虚拟纹理

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 虚拟纹理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/virtual-texturing-in-unreal-engine

利用项目对 **虚拟纹理** 的支持，可在运行时以更低内存占用率和更高一致性创建和使用大尺寸纹理。

## 虚拟纹理方法

虚幻引擎4(UE4)支持两种虚拟纹理方法：**运行时虚拟纹理** (RVT) 和 **流送虚拟纹理** (SVT)。

| 运行时虚拟纹理 | 流送虚拟纹理 |
| --- | --- |
| 支持超高纹理分辨率。 按需将纹素数据缓存于内存中。 运行时由GPU生成的纹素数据。 非常适用于可按需渲染的纹理数据，如过程纹理或合成分层材质。 | 支持超高纹理分辨率。 按需将纹素数据缓存于内存中。 在硬盘中烘焙和加载纹素数据。 非常适用于生成时间较长的纹理数据，如光照贴图或美术师创建的大型细节纹理。 |

### 运行时虚拟纹理

利用 **运行时虚拟纹理** 可有效渲染过程生成或分层的复杂材质，使运行时虚拟纹理适用于渲染复杂的地形材质。其能改善地形样条、网格体和材质贴花，及一般地形与对象混合的渲染性能和工作流程。

> [!NOTE]
> 欲了解更多详情，参见[运行时虚拟纹理](runtime-virtual-texturing/index.md)。

### 流送虚拟纹理

**流送虚拟纹理** 可降低使用超大尺寸纹理时的纹理内存开销，包括支持虚拟纹理光照贴图和UDIM（U维度）。与现有的基于mip纹理流送相比，流送虚拟纹理是一种从硬盘流送纹理的替代方法。

> [!NOTE]
> 欲了解更多详情，参见[流送虚拟纹理](streaming-virtual-texturing/index.md)。

#### 虚拟纹理光照贴图

支持虚拟纹理光照贴图可提高光照贴图烘焙的流送性能和质量。

在 **项目设置（Project Settings）** 中的 **引擎（Engine）** > **渲染（Rendering）** 下，设置 **启用虚拟纹理光照贴图（Enable virtual texture lightmaps）**，以启用对光照贴图的虚拟纹理支持。

启用以下控制台变量，控制项目中虚拟纹理光照贴图的使用方式：

| 控制台变量 | 说明 |
| --- | --- |
| `r.IncludeNonVirtualTexturedLightmaps` | 控制是否生成/保存非VT光照贴图。包含非VT光照贴图会限制图谱大小，从而失去VT光照贴图部分优势。 |
| `r.VT.EnableLossyCompressLightmaps` | 启用虚拟纹理光照贴图的有损压缩。与常规颜色纹理相比，有损压缩的光照贴图纹理质量较低。 |

## 虚拟纹理主题


- [虚拟纹理内存池](virtual-texture-memory-pools/index.md)

- [虚拟纹理参考](../../optimizing-and-debugging-projects-for-realtim-ea5cf1b9/virtual-texturing/virtual-texturing-settings-and-properties/index.md) - 包含虚拟纹理中涉及的项目设置、控制台命令和Actor设置的相关参考信息。

- [运行时虚拟纹理快速入门](../../optimizing-and-debugging-ea5cf1b9/virtual-texturing/runtime-virtual-texturing/runtimevirtual-texturing-quick-start/index.md) - 介绍如何设置地形材质并使用运行时虚拟纹理。

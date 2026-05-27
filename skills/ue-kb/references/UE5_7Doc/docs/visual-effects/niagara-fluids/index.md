---
title: "虚幻引擎中的Niagara流体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/niagara-fluids-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "虚幻引擎中的Niagara流体"]
---

# 虚幻引擎中的Niagara流体

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / 虚幻引擎中的Niagara流体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/niagara-fluids-in-unreal-engine

**Niagara流体** 为虚幻引擎带来了实时流体特效。启用Niagara流体插件后，你将获得可以制作火焰和烟雾等特效的流体模板。尽情使用专为游戏优化的2D模板，或者为电影设计的3D模板。

流体模拟比简单的基于粒子的方法更加自然真实。这些流体构建在Niagara架构上。进阶用户不需要自行编写代码、插件或者数据接口便可以修改。

## Niagara流体入门

入门Niagara流体，可以先阅读[流体模拟概览](../../gameplay-systems/physics/fluid-simulation/fluid-simulation-in-unreal-engine---overview/index.md) 文档。然后根据[Niagara流体快速指南](niagara-fluids-quick-start-guide/index.md) 学习如果在你的项目中加入模板。


- [流体模拟概述](../../gameplay-systems/physics/fluid-simulation/fluid-simulation-in-unreal-engine---overview/index.md)

- [Niagara流体快速入门指南](niagara-fluids-quick-start-guide/index.md) - 关于使用Niagara流体插件创建实时流体模拟的快速入门指南。

## 延伸阅读

Niagara流体基于现有的Niagara框架而构建。流体模拟需要大量的算力。你可以先创建一个流体发射器，将结果烘焙至一个Flipbook，然后便可以在任何材质上使用这些流体。具体操作方法参考[Niagara Flipbook烘焙器快速指南](../getting-started-in-niagara-effects/niagara-flipbook-baker-quick-start-guide/index.md)。

流体场景需要大量的图形运算，可能导致GPU崩溃。若出现这种情况，可以参考以下的解决方案。


- [Niagara图像序列视图烘焙器快速入门指南](../getting-started-in-niagara-effects/niagara-flipbook-baker-quick-start-guide/index.md)

- [如何修复GPU驱动程序崩溃](../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/dealing-with-a-gpu-crash-when-using/index.md) - 了解如何在Windows中编辑注册表项来修复GPU驱动程序崩溃。

## 参考指南

了解Niagara流体模板中各个可调试的参数，参阅[Niagara流体参考指南](niagara-fluids-reference/index.md)。


- [Niagara流体参考指南](niagara-fluids-reference/index.md)

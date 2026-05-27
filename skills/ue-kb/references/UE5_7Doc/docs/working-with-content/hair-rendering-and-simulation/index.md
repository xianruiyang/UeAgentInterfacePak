---
title: "毛发渲染与模拟"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hair-rendering-and-simulation-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟"]
---

# 毛发渲染与模拟

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hair-rendering-and-simulation-in-unreal-engine

虚幻引擎的毛发造型（Groom）渲染与模拟系统利用基于发束的工作流来渲染每束毛发，让毛发在移动时准确地遵循物理原则。它可以让美术师实时模拟并渲染出成百上千（甚至更多）照片级逼真的毛发。在过去，在实时项目中常见的毛发都使用基于发片的技术，或其他近似方法创建。虚幻引擎中的Groom系统同样可以管理并使用这些方法。

![Example of Groom using Strands and Cards](../../../assets/images/be/be82fdaac0baa7f56c06c82a30bc4a283dca05742020ec019f76d735e511d913.jpg)

展示了发束（左）和发片（右）的MetaHuman Groom角色示例。

## 入门指南


- [毛发渲染和模拟快速入门](hair-simulation-and-rendering-quick-start-guide/index.md)

- [设置项目以使用Groom](setting-up-a-project-for-grooms/index.md) - 设置项目以导入和渲染Groom资产。

- [Groom平台支持](groom-platform-support/index.md) - 各平台支持的Groom功能汇总

- [导入Groom](importing-grooms-into/index.md) - 了解如何将Groom导入到你的项目中以及Groom导入器的设置。

- [Groom组件和资产](groom-components-and-assets/index.md) - 使用和渲染Groom的资产和组件。

- [Groom资产编辑器](groom-asset-editor-user-guide/index.md) - 关于如何管理属性以及编辑毛发资产的用户参考指南。

- [发片生成器](hair-card-generator-for-grooms/index.md) - 介绍如何使用发片生成器创建发片Groom。

## 其他主题


- [Groom发束](groom-strands/index.md)

- [为Groom设置绑定](setting-up-bindings-for-grooms/index.md) - 了解如何将Groom组件绑定到骨骼网格体。

- [Groom插值](groom-interpolation/index.md) - 定义Groom的曲线应如何基于蒙皮网格体和物理模拟移动。

- [对Groom启用物理模拟](enabling-physics-simulation-on-grooms/index.md) - 了解如何对Groom启用和配置物理。

- [为Groom设置细节级别](setting-up-level-of-detail-for-grooms/index.md) - 了解如何为你的Groom设置并管理细节级别组。

- [为Groom设置发片和网格体](setting-up-cards-and-meshes-for-grooms/index.md) - 为Groom设置发片和网格体，并指定细节级别。

- [Groom材质](groom-materials/index.md) - 管理Groom的材质。

- [生成Groom纹理](generating-groom-textures/index.md) - 关于使用Groom资产创建毛发毛囊遮罩纹理和发束纹理的参考指南。

- [设置Groom变形器图表](setting-up-a-groom-deformer-graph/index.md) - 使用变形器图表来定义具有网格体变形的Groom行为。

- [Groom缓存](using-groom-caches-with-hair/index.md) - 介绍如何将导入的Groom缓存用于Groom。

- [Groom的可伸缩性和性能](groom-scalability-and-performance/index.md) - 了解如何使用Groom的可伸缩性选项，并为项目优化这些选项。

- [调试Groom](debugging-grooms/index.md) - Groom调试方法概述。

- [Alembic for Grooms规范](using-alembic-for-grooms/index.md) - 介绍如何将Grooms导出为Alembic文件，以便在虚幻引擎中使用。

- [XGen Groom创建指南](xgen-guidelines-for-hair-creation/index.md) - 介绍如何将Groom导出为Alembic文件并在虚幻引擎中使用

## 其他资源

- MetaHuman Creator

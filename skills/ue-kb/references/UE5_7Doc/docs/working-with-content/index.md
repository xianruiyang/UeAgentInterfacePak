---
title: "管理内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/working-with-content-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容"]
---

# 管理内容

> 路径：虚幻引擎5.7文档 / 管理内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/working-with-content-in-unreal-engine

并不是所有的游戏内容都是在编辑器中创建的。大部分的美术素材都应该在外部的工具中制作，比如 3ds Max，Maya，Photoshop，ZBrush 等。下表中罗列了一些典型的应该在编辑器内部制作的素材，以及哪些应该在外部工具中创建。

| 资产创建的位置 |  |
| --- | --- |
| 由虚幻编辑器中创建 | 由外部应用程序中创建 |
| 游戏关卡 材质 粒子系统 过场动画序列 蓝图脚本 给人工智能用的导航网格（AI Navigation Meshes） 预计算光照信息（Light Maps） 场景（光卡）光照 | 静态网格物体（Static Meshes） 骨架网格物体（Skeletal Meshes） 骨架动画（Skeletal Animation） 材质（Textures） 声音（WAVs） IES 灯光信息 Nvidia APEX 文件（APB 及 APX） |

## 开始

- [美术师快速入门](artist-quick-start/index.md) - 了解作为内容创建者如何开始使用虚幻引擎5。

## 内容指南

- [骨骼网格体](skeletal-mesh-assets/index.md) - 在虚幻引擎中使用骨骼网格体资产创建角色。

- [Alembic文件导入器](alembic-file-importer/index.md) - 介绍Alembic文件导入过程以及导入选项。

- [FBX内容管线](fbx-content-pipeline/index.md) - 有关将FBX内容导入通道用于网格体、动画、材质和纹理的信息。

- [毛发渲染与模拟](hair-rendering-and-simulation/index.md) - 关于在虚幻引擎中渲染、模拟、创建和编辑毛发造型的信息。

- [交换框架](interchange-framework/index.md) - 有关使用交换框架导入和导出内容的信息

- [静态网格体](static-meshes/index.md) - 关于在虚幻引擎中导入和操作静态网格体的信息。

- [Mutable骨骼网格体生成](mutable-skeletal-mesh-generation/index.md) - 介绍Mutable，它是一个用于在运行时生成动态骨骼网格体、材质和纹理的工具集。

- [GL传输格式（glTF）](the-gl-transmission-format-gltf/index.md) - 使用glTF文件格式导入和导出虚幻引擎内容

- [通用场景描述（USD）](universal-scene-description-usd/index.md) - 使用虚幻引擎通用场景描述（USD）导入和编辑内容

- [LiDAR点云插件](lidar-point-cloud-plugin/index.md) - 使用LiDAR点云插件，将LiDAR点云导入虚幻引擎

- [建模和几何体脚本编写](modeling-and-geometry-scripting/index.md) - 引擎内的建模工具。

- [使用场景变体](working-with-scene-variants/index.md) - 变体管理器可协助不同场景代表间的切换。

- [SpeedTree](using-speedtree/index.md) - 在虚幻引擎 4 中使用 SpeedTree 的着陆页面。

- [本地化](localizing-content/index.md) - 关于如何为不同地区本地化项目内容的信息。

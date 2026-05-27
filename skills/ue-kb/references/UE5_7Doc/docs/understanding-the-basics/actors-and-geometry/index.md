---
title: "Actor和几何体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/actors-and-geometry-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体"]
---

# Actor和几何体

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/actors-and-geometry-in-unreal-engine

**Actor** 是可以放置在关卡中的任意对象，如摄像机、静态网格体或玩家出生点。Actor支持3D变换，如平移、旋转和缩放。你可以通过gameplay代码（C++或蓝图）来创建和销毁Actor。

在C++中，`AActor` 是所有Actor的基类。

要创建关卡，你可以将Actor放置到关卡（地图）中，然后移动和缩放它们以创建环境，并添加脚本，使其行为符合你的需求。本分段的文档将介绍使用Actor的基本技巧，如放置、选择和变换Actor。它们还将介绍一些最常用的Actor类型。

## 使用Actors


- [放置Actor](placing-actors/index.md)

- [选择Actor](selecting-actors/index.md) - 概述用于在关卡编辑器视口中选择Actor的方法。

- [变换Actor](transforming-actors/index.md) - 如何调整关卡中Actor的位置、旋转和缩放。

- [Actor对齐](actor-snapping/index.md) - 介绍虚幻引擎中的Actor对齐。

- [Actor移动性](actor-mobility/index.md) - 该设置可控制Actor在Gameplay期间是否能够以某种方式移动或变化。

- [Actor分组](grouping-actors/index.md) - 如何在虚幻引擎中创建和处理Actor组。

- [合并Actor](merging-actors/index.md) - 如何在虚幻引擎中将两个或更多静态网格体Actor合并为单个Actor。

## 常用Actor类型

> [!NOTE]
> 本列表并未涵盖虚幻引擎中所有的可用Actor类型。有些插件和项目模板会添加其特有的Actor，而某些Actor也并非在所有项目中可用。

- [物理体积Actor](unreal-engine-actors-reference/physics-volume-actor/index.md) - 介绍虚幻引擎中物理体积的属性。

- [玩家出生点](unreal-engine-actors-reference/player-start-actor/index.md) - 玩家出生点使用指南。

- [静态网格体Actor](unreal-engine-actors-reference/static-mesh-actors/index.md) - 将静态网格体Actor放在关卡中，创建你的游戏世界。

- [骨骼网格体Actor](unreal-engine-actors-reference/skeletal-mesh-actors/index.md) - 使用骨骼网格体Actor创建玩家头像并填充你的游戏世界。

- [几何体笔刷Actor](unreal-engine-actors-reference/geometry-brush-actors/index.md) - 使用BSP笔刷在虚幻引擎中创建关卡几何体的指南。

- [摄像机Actor](unreal-engine-actors-reference/camera-actors/index.md) - 了解虚幻引擎中摄像机的运用

- [音频体积Actor](unreal-engine-actors-reference/audio-volume-actor/index.md) - 音频体积参数详情

- [触发器体积Actor](unreal-engine-actors-reference/trigger-volume-actors/index.md) - 可用于激活并触发关卡事件的Actor。

- [体积Actor](unreal-engine-actors-reference/volume-actors/index.md) - 虚幻引擎中不同类型体积Actor的参考。

- [伤害施加体积Actor](unreal-engine-actors-reference/pain-causing-volume-actor/index.md) - Pain-Causing Volume reference details

- [贴花Actor](unreal-engine-actors-reference/decal-actors/index.md) - 介绍如何使用延迟贴花Actor。

- [3D文本Actor](unreal-engine-actors-reference/3d-text-actor/index.md) - 介绍如何在虚幻引擎中放置3D文本并用它创建动态图形。

- [目标点Actor](unreal-engine-actors-reference/target-point-actors/index.md) - 目标点 Actor 的创建和使用指南。

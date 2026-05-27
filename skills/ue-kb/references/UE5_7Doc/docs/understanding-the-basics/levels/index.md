---
title: "关卡"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/levels-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "关卡"]
---

# 关卡

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 关卡

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/levels-in-unreal-engine

**关卡（Level）** 是游戏的"世界"的全部或一部分。关卡包含玩家可以看到并与之交互的所有内容，例如环境、可用对象、其他角色，等等。在电子游戏中，常常有多个关卡，彼此之间有划分明确的过渡（例如，在你打败一个关卡中的终极boss之后，你就会继续到下一个关卡）。对于虚幻引擎中进行的其他类型的交互式体验，你可以使用不同的关卡在不同种类的展柜或环境之间过渡。

虚幻引擎将每个关卡保存为单独的 `.umap` 文件，这就是为什么你有时会看到关卡被称为 **贴图（Maps）** 。

下面是组合起来创建关卡至少所需的元素列表：

- 一个

  .umap

  文件，即关卡本身。可将其视为保存其他所有内容的容器。
- 一个由

  静态网格体Actor（Static Mesh Actors）

  组成的环境。这些可以是树木、岩石、墙壁或其他环境Fixture。某些场景还使用其他类型的Actor，例如地形Actor或者水体Actor。
- 一个由

  骨骼网格体Actor（Skeletal Mesh Actor）

  表示的玩家角色。
- 一个或多个不同类型的

  光源（lights）

  。
- 环境声音和音效（例如，脚步声）。

复杂的关卡可能包含其他功能，如粒子效果、视效后期处理、关卡流送，等等。

> [!TIP]
> 如果你想看看高级虚幻项目是什么样子的，请查看Fab上的[Stack O Bot](https://www.fab.com/listings/b4dfff49-0e7d-4c4b-a6c5-8a0315831c9c)示例游戏。

下面的页面可以详细教你如何在虚幻引擎5中创建和处理关卡资产。

- [使用关卡](working-with-levels/index.md) - 如何创建、保存和打开关卡资产。

- [管理多个关卡](managing-multiple-levels/index.md) - 使用关卡窗口管理持久关卡和子关卡

- [World Settings](world-settings/index.md) - The World Settings panel is where you set and override Level-specific settings.

- [更改默认关卡](changing-the-default-level-of-an-unreal-engine-project/index.md) - 介绍如何设置项目的默认游戏关卡。

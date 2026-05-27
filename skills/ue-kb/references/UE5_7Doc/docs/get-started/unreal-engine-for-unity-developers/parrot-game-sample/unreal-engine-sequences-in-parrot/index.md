---
title: "Parrot中的序列"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-sequences-in-parrot"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "Parrot游戏示例", "Parrot中的序列"]
---

# Parrot中的序列

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / Parrot游戏示例 / Parrot中的序列

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-sequences-in-parrot

Sequencer是虚幻引擎用来制作过场动画序列的工具。 Parrot使用Sequencer在关卡中创建移动的障碍物，比如鲨鱼。 如需详细了解如何在虚幻引擎中使用Sequencer，请参阅[过场动画和Sequencer](../../../../animating-characters-and-objects/cinematics-and-movie-making/index.md)。

## 鲨鱼障碍物

Parrot的**主菜单**关卡使用了关卡序列来创建一条游动的鲨鱼。 打开 `Content/Maps/MainMenu/SwimmingShark` 即可查看这些基本序列的设置方式。

在Sequencer中打开序列后，你就可以查看轨道的设置方式。 关卡中的鲨鱼Actor下方存在一条路径轨道，它使鲨鱼围绕关卡中放置的样条线Actor而游动。 此外，关卡中还存在一条事件轨道，用于触发事件来操纵鲨鱼的动画器，使其切换动画。

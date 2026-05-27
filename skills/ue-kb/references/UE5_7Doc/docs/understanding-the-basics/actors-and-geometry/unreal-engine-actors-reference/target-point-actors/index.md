---
title: "目标点Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/target-point-actors-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "目标点Actor"]
---

# 目标点Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 目标点Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/target-point-actors-in-unreal-engine

在为游戏创建场景时，有时你需要在其中放置和生成各种物体，以便玩家与之互动。**目标点 Actor（Target Point Actor）** 的作用正在于此，在世界场景中设定一个一般点，作为物体生成的点。如你对其他 3D 软件（如 3Ds Max 或 Maya）有所了解，便会发现目标点 Actor 与这些软件中的虚拟 Actor 十分相似。

## 放置目标点 Actor

可在 **All Classes（所有类）** 类目下的 **Modes（模式）** 面板中找到目标点 Actor。它的添加方法极其简单，在 **Modes（模式）** 面板中选定，然后拖入场景即可。

## 使用目标点

目标点 Actor 在虚幻引擎 4 中的用途十分广泛。下面是它的部分用途：

- 设定动画序列中摄像机对准的目标。
- 设定 AI 路径点。
- 设定 VFX（视觉特效）生成点。
- 设定可拾取道具（如回复品和物品）生成点。
- 设定世界场景中道具所在点/应放置点的视觉提示。

下述蓝图示例介绍了如何使用目标点 Actor 来指定生成点的位置。

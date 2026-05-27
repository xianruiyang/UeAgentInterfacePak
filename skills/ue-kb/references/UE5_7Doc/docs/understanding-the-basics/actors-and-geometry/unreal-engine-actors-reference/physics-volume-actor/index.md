---
title: "物理体积Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physics-volume-actor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "物理体积Actor"]
---

# 物理体积Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 物理体积Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physics-volume-actor-in-unreal-engine

物理体积提供了一些属性，可以在 **细节（Details）** 面板中调整，如下所示：

| 属性 | 描述 |
| --- | --- |
| **末速度（Terminal Velocity）** | 决定了Pawn（应用CharacterMovement）下落时的速度。 |
| **优先级（Priority）** | 决定当PhysicsVolume重叠时哪个体积占主导地位。 |
| **流体摩擦（Fluid Friction）** | 决定了应用CharacterMovement的Pawn在穿过体积移动时，该体积所应用的摩擦力大小。 该值越高，就感觉越难穿过体积。 |
| **水体积（Water Volume）** | 决定体积是否包流体，比如水。 |
| **接触时的物理影响（Physics on Contact）** | 决定了Actor接触体积时是否会受到该体积的影响（默认情况下，Actor必须在体积内部才会受到影响）。 |

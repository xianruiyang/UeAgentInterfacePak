---
title: "伤害施加体积Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pain-causing-volume-actor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "伤害施加体积Actor"]
---

# 伤害施加体积Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 伤害施加体积Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pain-causing-volume-actor-in-unreal-engine

对象除了可以承受物理体积的属性影响，还能受到伤害施加体积的影响，具体属性如下：

| 属性 | 说明 |
| --- | --- |
| **施加伤害（Pain Causing）** | 体积当前是否施加伤害。 |
| **每秒钟伤害量（Damage Per Sec）** | 启用"施加伤害"时，体积对进入其内部的Actor每秒钟施加的伤害量。 |
| **伤害类型（Damage Type）** | 决定了给该Actor施加的伤害类型。 |
| **伤害时间间隔（Pain Interval）** | 当启用"施加伤害"时，应用伤害的时间间隔量，以秒为单位。 |
| **进入时伤害（Entry Pain）** | 如果启用了 **施加伤害（Pain Causing）**，此属性决定了是否在进入体积时立即施加伤害。它是基于 **伤害时间间隔（Pain Interval）** 所施加的伤害之外的伤害。 |

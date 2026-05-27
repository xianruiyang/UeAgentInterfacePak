---
title: "碰撞设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/collision-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "碰撞设置"]
---

# 碰撞设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 碰撞设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/collision-settings-in-the-unreal-engine-project-settings

## 碰撞

你最多可以有18个自定义通道，包括对象通道和追踪通道。

| **分段** | **说明** |
| --- | --- |
| **对象通道（Object Channels）** | 这是项目的对象类型列表。 如果你删除游戏正在使用的对象类型，使用该类型的所有对象都将恢复为 `WorldStatic` 。 |
| **追踪通道（Trace Channels）** | 这是项目的追踪通道列表。 如果你删除游戏正在使用的追踪通道，该追踪的行为将处于未定义状态。 |
| **预设（Preset）** | 你可以修改项目的任意配置文件。 如果你修改配置文件，可能会改变碰撞行为。在更改使用中的碰撞配置文件时需要谨慎。 |

---
title: "IK Rig"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-ik-rig"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "IK Rig"]
---

# IK Rig

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / IK Rig

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-ik-rig

**IK Rig** 系统提供了交互式创建 **解算器** 的方法，用于为你的骨骼网格体执行姿势编辑。然后，生成的IK Rig资产可以嵌入到任何动画系统中，例如动画蓝图，以便动态修改基于姿势的解算器参数。

此外，**IK重定向** 系统可以用于在不同比例的角色之间传输动画，无论是运行时还是离线创建新动画序列。

此页面包含文档链接，涵盖虚幻引擎的 **IK Rig** 和 **重定向** 工具，以及它们工作流程的实际示例。

## IK Rig

**IK Rig** 是你在使用IK Rig系统时将使用的主要资产。这些页面介绍了它的用法和主要功能。


- [IK Rig编辑器](ik-rig/index.md)

- [解算器](ik-rig/ik-rig-solvers/index.md) - 用解算器创建不同IK Rig设置。

- [使用Python处理IK Rig](ik-rig/using-python-to-create-and-edit-ik-rigs/index.md) - 使用Python脚本创建和编辑IK Rig以自动执行工作流程。

## 重定向

IK Rig还可以用作平台，在不同骨架之间快速重定向动画。本页描述了使用 **IK Rig** 和 **IK 重定向器** 的重定向过程。

%animating-characters-and-objects/SkeletalMeshAnimation/AssetsFeatures/IKRig/IKRetargeting:Topic%

## 动画蓝图创作

IK Rig可以在 **[动画蓝图](../../animation-blueprints/index.md)** 中使用，程序性调整动画以便更好地对齐。本页面介绍了在 **动画蓝图（Animation Blueprints）** 中使用 **IK Rig** 的功能。


- [动画蓝图中的IK Rig](ik-rig-in-animation-blueprints/index.md)

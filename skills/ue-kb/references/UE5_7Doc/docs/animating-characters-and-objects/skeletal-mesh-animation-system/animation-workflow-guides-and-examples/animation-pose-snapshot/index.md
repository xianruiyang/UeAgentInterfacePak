---
title: "动画姿势快照"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-pose-snapshot-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "动画姿势快照"]
---

# 动画姿势快照

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 动画姿势快照

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-pose-snapshot-in-unreal-engine

设置骨架网格体的动画时，有时需要应用物理并让物理控制网格体（如角色进入布娃娃状态）。 应用物理后，借助 **动画姿势快照（Animation Pose Snapshot）** 功能，你可以在[蓝图](../../../../blueprints-visual-scripting/index.md) 中采集骨架网格体动作（保存所有骨骼变换数据）。 然后你可以在[动画蓝图](../../animation-blueprints/index.md) 中获得获取该信息，并使用保存的动作作为混合源（如下方的视频范例所示）。

在上方的视频中，用户按下键时角色便进入布娃娃状态。用户使用 [角色蓝图](../../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-class-assets/index.md) 中的 **Pose Snapshot** 节点保存骨架网格体的动作。 用户按下另一个键时，角色从该快照混入并播放一个"起身"[动画蒙太奇](../../animation-assets-and-features/animation-montage/index.md)，然后继续常规运动状态。 这样用户便能将角色的最终动作视为物理结果，并从该动作顺畅地混入角色起身的动画。

## 保存姿势快照

为类在运行时在 **角色蓝图** 中保存骨架网格体的动作，你需要获取骨架网格体组件和其 **动画实例**。 设置妥当后，即可调用 **Save Pose Snapshot** 节点并输入所需的 **快照名称**。 你可以在 **快照名称（Snapshot Name）** 字段中手动输入名称，或创建一个变量保存命名。

> [!WARNING]
> 你提供的 **快照名称（Snapshot Name）** 必须是你在 **动画蓝图** 中尝试获取姿势快照（Pose Snapshot）时所用的名称。 此外，当你在调用 Save Pose Snapshot 时，快照会在当前LOD级别下截取。例如，如果你在LOD1级别下获取快照，然后再LOD0级别下使用，那么所有未出现在LOD1中的骨骼都将使用网格体的引用姿势。

## 获取姿势快照

获取姿势快照的方法是：在 **动画蓝图** 的 **AnimGraph** 中点击右键并添加 **Pose Snapshot** 节点，然后输入 **快照命名**。

下图是角色从布娃娃动作起身的使用情况范例。

上图中，我们拥有一个名为 **Default** 的 [状态机](../../animation-blueprints/state-machines/index.md) 驱动角色运动，并使用 **MySlot** 节点（调用时播放角色起身动画）中的 AnimMontage。 我们使用 [Blend Poses by bool](../../animation-blueprints/animation-blueprint-nodes/animation-blueprint-blend-nodes/index.md#blendposesbybool) 节点决定角色是否已停止移动，如为 **True** 则切换至姿势快照。 如为 **False**，则从姿势快照混入槽中的 AnimMontage，然后通过普通的默认状态机继续。

## Snapshot Pose 函数

使用姿势快照功能的另一种方法是在蓝图中调用 **Snapshot Pose** 函数将快照保存到 **Pose Snapshot** 变量。

使用 Snapshot Pose 时，如上所示需要提供一个变量以便保存快照。

在 AnimGraph 中添加 **Pose Snapshot** 节点后，在 **细节** 面板中将 **模式（Mode）** 设为 **Snapshot Pin** 并勾选 **(As pin) Snapshot** 选项。

这将在节点上（可将所需的快照变量传入此节点）公开一个 Pose Snapshot 输入引脚。

## 其他资源

此功能在以下视频教程中也有讲述：

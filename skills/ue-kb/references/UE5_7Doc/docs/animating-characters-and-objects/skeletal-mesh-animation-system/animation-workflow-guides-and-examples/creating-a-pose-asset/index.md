---
title: "创建姿势资产"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-a-pose-asset-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "创建姿势资产"]
---

# 创建姿势资产

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 创建姿势资产

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-a-pose-asset-in-unreal-engine

虽然您有时能够从动画序列抽取单帧动画，但您得自己设置混合。 通过使用 **姿势资产** 改变了这一行为，实施此类资产是为了支持可由FACS（面部行为编码系统）或视位曲线驱动姿势的面部动画。 但是，您可以使用该系统，通过混合多个姿势来驱动和创建新动画。姿势资产还支持骨骼变换以及混合空间，因此是极为灵活的资产。

本操作指南将为您介绍创建 **姿势资产** 的过程。

## 步骤

1. 要从单一动画创建一系列姿势资产，从内容浏览器中，右键单击 **动画序列（Animation Sequence）**，并根据它创建 **姿势资产（Pose Asset）**：
2. 创建姿势资产后，默认情况下会自动生成名称。您可以重命名每个姿势，也可以从剪贴板粘贴。
3. 然后，在 **面部姿势（FacePose）** 面板中更改权重值即可看到每个姿势的效果。

## 结果

现在，您有了新的 **姿势资产** 可以在动画中使用。

要进行预览，确保 **预览姿势资产（Preview Pose Asset）** 设置为您的 **姿势资产**，然后向需要该 **姿势资产** 数据的动画添加 **变量曲线（Variable Curve）**。

然后，您可以向该变量曲线添加关键帧以驱动姿势权重的值，从而影响动画。

对于在运行时工作的用户，您还需要在[动画蓝图](../../animation-blueprints/index.md)中包含**姿势资产**。

还需要注意的是，可以在 **动画编辑器** 中创建 **姿势资产** 。您可以使用 **创建资产（Create Asset）**>**创建姿势资产（Create PoseAsset）**>**从当前姿势（From Current Pose）** 或 **动画（Animation）** 选项：

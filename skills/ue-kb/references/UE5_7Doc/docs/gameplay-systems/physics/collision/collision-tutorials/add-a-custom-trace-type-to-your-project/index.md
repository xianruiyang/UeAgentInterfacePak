---
title: "给项目添加自定义追踪类型"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/add-a-custom-trace-type-to-your-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "碰撞", "碰撞使用教程", "给项目添加自定义追踪类型"]
---

# 给项目添加自定义追踪类型

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 碰撞 / 碰撞使用教程 / 给项目添加自定义追踪类型

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/add-a-custom-trace-type-to-your-project-in-unreal-engine

你经常会发现两个默认的 **追踪响应** 通道（"可视性（Visibility）"和"摄像机（Camera）"）无法满足需求，例如，你可能需要一种特殊激光，它需要能够穿过你无法透视或无法让摄像机穿过的特殊不透明对象。遇到此类情况时，你可以按照以下步骤添加自己的自定义 **追踪响应** 通道。

## 步骤

1. 打开项目设置：**"编辑（Edit）"菜单** -> **项目设置（Project Settings）**。
2. 在 **引擎（Engine）** 下，选择 **碰撞（Collision）**：
3. 单击 **新建追踪通道...（New Trace Channel...）** 按钮。为新建的 **追踪通道（Trace Channel）** 命名，并设置其 **默认响应（Default Response）**。点击 **接受（Accept）** 按钮。

   > [!NOTE]
   > **默认响应** 可以是 **阻挡（Block）**、**重叠（Overlap）** 或 **忽略（Ignore）**。根据你的用例，你应该谨慎选择，以避免额外的Actor碰撞设置工作。
4. 要让新追踪通道在所有组件或节点上显示，必须关闭并重新打开 **蓝图编辑器** 中任何已打开的 **蓝图**。

## 结果

你现在拥有新的追踪通道，可在编辑器中的任意位置使用。必须将你希望能够使用新通道追踪的所有Actor或组件设置为阻止新通道。

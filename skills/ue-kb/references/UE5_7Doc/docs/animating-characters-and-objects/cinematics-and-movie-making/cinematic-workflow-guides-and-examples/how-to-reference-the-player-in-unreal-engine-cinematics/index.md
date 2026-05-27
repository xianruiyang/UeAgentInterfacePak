---
title: "在Sequencer中引用玩家"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-reference-the-player-in-unreal-engine-cinematics"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "过场动画流程指南和示例", "在Sequencer中引用玩家"]
---

# 在Sequencer中引用玩家

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 过场动画流程指南和示例 / 在Sequencer中引用玩家

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-reference-the-player-in-unreal-engine-cinematics

在Sequencer中创建过场动画内容时，你可能会不清楚要怎样像你在场景中[添加其他对象或Actor](../../unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-actor-tracks/index.md)那样添加玩家角色并对其制作动画。本文档介绍了推荐的工作流程，用于将玩家角色作为代理引用，然后在运行时将其绑定到实际玩家。

#### 先决条件

- 你的项目中有可控制的玩家角色。就本文档而言，

  第三人称模板

  用作示例。
- 你熟悉如何

  在Sequencer中制作骨骼网格体的动画

  。
- 你熟悉

  蓝图

  的用法。

## 引用代理玩家

虽然PlayerStart Actor是玩家的生成点，但这个Actor在Sequencer中没什么用或不合适，因为它不包含所生成的玩家网格体或对象。

因此，你应该改为创建要用于制作动画的代理（替代）Actor。一种做法是创建玩家 **角色蓝图（Character Blueprint）** 的[可生成](https://dev.epicgames.com/documentation/404)引用。为此，在 **内容浏览器（Content Browser）** 中找到角色蓝图资产并将其拖入Sequencer中。

> 动图已省略：db3878d0d10d0803022b1ed812034df6056ee037e0e7639e70f15096fd9a8434

这会基于序列中的玩家角色蓝图创建可生成的Actor。它是仅限Sequencer的临时角色，不会使用代理引用污染你的关卡，这很有用。

现在你可以在过场动画序列中的此代理角色上制作动画并创建内容。

> 动图已省略：ce9aba4c61dc5457f6c83a5b159b37d2ed1e30f9042e0312da3a409825b05a79

## 将代理重新绑定到实际玩家

内容准备就绪后，在序列播放之前，代理角色必须替换为实际玩家。

### 创建玩家标签

为了更轻松地查找要替换的代理角色，请将[标签](../../unreal-engine-sequencer-movie-tool-overview/cinematic-tags-and-groups/index.md)分配到角色轨道。为此，请右键点击轨道，选择 **标签（Tags）** ，然后在 **添加标签（Add Tag）** 菜单中输入标签名称，并按 **Enter** 键。这会在角色轨道上创建标签。

### 蓝图设置

接下来，在 **关卡工具栏（Level Toolbar）** 中点击 **关卡蓝图（Level Blueprint）** 并选择 **打开关卡蓝图（Open Level Blueprint）** 以打开关卡蓝图。

在关卡中选择 **关卡序列Actor（Level Sequence Actor）** ，然后右键点击 **事件图表（Event Graph）** 并选择 **创建关卡序列的引用（Create a Reference to Level Sequence）** ，从而在蓝图中引用你的序列。

创建以下逻辑：

1. 创建

   Get Player Pawn

   节点，它会在运行时期间获取当前实际玩家。这是替换你的代理角色的Actor。
2. 拖移关卡序列引用并创建 **Set Binding by Tag** 节点，这用于按标签名称更改轨道上的对象或Actor的绑定。在此节点上，执行以下操作：

   - 将你的

     关卡序列（Level Sequence）

     引用连接到

     目标（Target）

     。
   - 将

     绑定标签（Binding Tag）

     设置为你之前在代理角色轨道上创建的标签名称。
   - 将

     Get Player Pawn

     连接到

     Actors

     。
   - 确保

     允许从资产绑定（Allow Bindings from Asset）

     已

     禁用

     。如果

     启用

     ，代理Actor会保留，不会被覆盖，导致玩家Pawn和代理Actor都绑定到该轨道。
3. 绑定后，

   播放（Play）

   序列。

## 结果

执行此逻辑时，你应该会看到玩家在过场动画序列中正确地运行动画。

> 动图已省略：0c76a61b3fe25f99b58d4aa3e731e7a3c5ee917c57900bf3cb999696d574af45

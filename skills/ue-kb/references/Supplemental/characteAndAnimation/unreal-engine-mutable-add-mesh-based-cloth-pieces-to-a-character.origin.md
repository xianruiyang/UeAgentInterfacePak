# 可变：为角色添加基于网格的布料

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2872 字符。

## 摘要

教程展示了如何使用 Mutable 插件向角色添加基于网格的布料。

## 中文整理

### 概览

返回可变教程

### 概述

在本教程中，我们将了解如何向角色添加基于网格的布料。在其中我们将创建一个带有可切换衣服的简单角色。稍后我们将通过删除看不见的部分来优化网格。我们建议在开始本教程之前阅读简单可自定义对象教程。这些示例生成的可自定义对象可以在 Content/Tutorials/MeshBasedCloth 的可变示例中找到。

### 所需资产

对于这个例子，我们需要一个身体和一些衣服。 - SK_BaseBody 骨骼网格体作为身体： SK_BaseBody 骨骼网格体作为身体： - SK_Boots、SK_Jacket_B 和 SK_Pants 骨骼网格体作为衣服： SK_Boots、SK_Jacket_B 和 SK_Pants 骨骼网格体作为衣服： - 它们的默认材质： 它们的默认材质：




### 身体和夹克

- 创建一个新的可自定义对象资产。创建一个新的可自定义对象资源。 - 使用主体资源创建新的组件、网格体截面和骨架网格体节点。由于 SK_BaseBody 的头部和主体分为两个部分，因此您需要创建两个网格部分节点。使用主体资源创建新的组件、网格体截面和骨架网格体节点。由于 SK_BaseBody 的头部和主体分为两个部分，因此您需要创建两个网格部分节点。 - 创建一个新的对象组节点。它的类型必须是切换。创建一个新的对象组节点。它的类型必须是切换。 - 添加一个新的子对象节点并为其命名。它的名称将是生成的切换参数的名称。添加一个新的子对象节点并为其命名。它的名称将是生成的切换参数的名称。 - 添加一个夹克，创建一个新的组件和网格截面节点。这次创建一个“添加到网格组件”节点而不是“组件”节点。将其命名为与步骤 #2 中创建的组件节点相同的名称。添加一个夹克，创建一个新的组件和网格截面节点。这次创建一个“添加到网格组件”节点而不是“组件”节点。将其命名为与步骤 #2 中创建的组件节点相同的名称。 - 编译并检查是否出现了新的 Jacket Toggle 参数。在接下来的部分中，我们将解决裁剪问题。编译并检查是否出现了新的 Jacket Toggle 参数。在接下来的部分中，我们将解决裁剪问题。







### 裤子和靴子

- 添加裤子作为新的切换参数。像以前一样，创建一个新的组件、网格部分并添加到网格组件节点。添加裤子作为新的切换参数。像以前一样，创建一个新的组件、网格部分并添加到网格组件节点。 - 最后添加靴子作为第三个切换参数。最后添加靴子作为第三个切换参数。


### 剪裁问题

您会注意到，最终结果存在裁剪问题。此外，这种网格并不是最佳的，因为当穿着衣服时，大部分身体几何形状是不可见的。我们将在删除看不见的网格部件教程中了解如何删除它。 - 性格 - 可变 - 定制

## 相关链接

- [Mutable Sample](https://www.fab.com/listings/209e82f6-ad40-4253-b565-d2f65b12efe7)
- [Overview](https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character#overview)
- [Required Assets](https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character#requiredassets)
- [Body and Jacket](https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character#bodyandjacket)
- [Trousers and Boots](https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character#trousersandboots)
- [Clipping Issues](https://dev.epicgames.com/community/learning/tutorials/W4WD/unreal-engine-mutable-add-mesh-based-cloth-pieces-to-a-character#clippingissues)

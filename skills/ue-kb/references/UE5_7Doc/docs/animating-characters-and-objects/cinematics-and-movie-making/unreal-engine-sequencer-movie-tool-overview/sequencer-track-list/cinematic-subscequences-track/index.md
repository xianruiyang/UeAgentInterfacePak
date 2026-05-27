---
title: "子序列轨道"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematic-subscequences-track-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "轨道", "子序列轨道"]
---

# 子序列轨道

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / 轨道 / 子序列轨道

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematic-subscequences-track-in-unreal-engine

在制作大型过场动画时，可能需要多名美术师同时处理一个序列，甚至同时拍摄。Subsequence轨道（Subscenes Track）可实现这种类型的工作流程，因为它允许将其他序列资产包含在同一序列中。Subsequence也可用于整理你的场景，可将重复的轨道和内容划分为各个分项的Subsequence。

本文档概述了如何创建并使用Subsequence轨道。

#### 先决条件

- 你已了解

  Sequencer

  及其

  界面

  。

## 创建

要创建Subsequence轨道，请在Sequencer中点击 **添加（+）轨道（Add (+) Track）** 按钮，并选择 **Subsequence轨道** 。

![创建子序列轨道](../../../../../../assets/images/f2/f2ac0bd279e182bc50312bb2e41da334c0f3d9f4272aa802e87479f47d2f0769.png)

此处，点击 **添加（+）序列（Add (+) Sequence）** 并从菜单中选择序列，或者将关卡序列从 **[内容浏览器](../../../../../understanding-the-basics/content-browser/index.md)** 拖到Subsequence轨道上，即可添加序列。

![添加子序列](../../../../../../assets/images/1c/1cbfa998a1cfd880cca6cc637ff5935945b7d8fbd587baa96496663e6bbe8141.png)

添加后，Subsequence分段将显示其相应关卡序列的名称以及其中包含的轨道数。

![子序列信息](../../../../../../assets/images/02/024072e2235907875d8f79ccdc6a050b2a4d25542e8ce7bd514722d2300dba14.png)

## 在Subsequence中处理工作

将Subsequence添加到序列后，可以双击其分段来打开它。当你以这种方式打开Subsequence时，它将显示在父序列的上下文中。这意味着，即使当前的Sequencer视图仅显示Subsequence，它也会继续对来自父级的轨道求值，提供完整的场景上下文。

> 动图已省略：子序列上下文

从父序列上下文查看Subsequence时，将显示基本子序列和剪辑后Subsequence的开始时间和结束时间。在此示例中，你可以看到在父序列中剪辑了 **开始（Start）** 和 **结束（End）** 时间的Subsequence，以及该信息在Subsequence中的显示方式。

![子序列剪辑视图](../../../../../../assets/images/60/60cfd10d3a7e9909347566967f0ac4e8a6b087eb5d71e4ab748acb19cf22719f.png)

1.已剪辑的区域。此为将从父序列播放的区域。 2.完整的可播放序列区域。该区域已剪辑，不会完整播放。

反过来，你也可以在Subsequence中剪辑 **开始（Start）** 和 **结束（End）** 时间，并从父序列中观察已剪辑的区域。

![子序列剪辑视图](../../../../../../assets/images/33/33c087865fc63c77fda2389e1013183c2107363ba2ebfe47096186c772df1962.png)

> [!NOTE]
> 从Sequencer的[**播放菜单**](../../sequencer-editor/sequencer-cinematic-toolbar/index.md#%E6%92%AD%E6%94%BE%E9%80%89%E9%A1%B9)切换 **求值孤立的子序列（Evaluate Sub Sequences In Isolation）** ，可以启用或禁用此上下文视图。

在处理Subsequence时，你可以像处理其他序列一样添加轨道、关键帧和其他内容，并且可以在父序列中的内容旁边预览效果。因此，Subsequence不仅可用于限制文件冲突，还可用于划分不同Subsequence中的Sequencer内容。

![子序列光源](../../../../../../assets/images/1d/1dd1bf8c0eb7e0bac5c9c600014df49e897066590d621e09c98c4f927a501717.jpg)

> [!NOTE]
> 与 **[镜头（Shots）](../../sequences-shots-and-takes/index.md#%E9%95%9C%E5%A4%B4)** 不同，在Sequencer中堆叠的多个Subsequence不会重写底部的Subsequence。所有Subsequence将在同时播放时进行求值。

### 协作

由于Subsequence会影响与主序列不同的关卡序列，因此多个美术师可以同时处理单个过场动画，而不会发生文件冲突。在此示例中，你可以看到两个不同的Subsequence用于容纳来自 **视觉效果（Visual Effects）** 和 **光照（Lighting)** 分项的内容。

![Sequencer美术师协作](../../../../../../assets/images/3a/3ab8b839e184729363bef2144dad4499dd25d1a025cbe7a9e70974a0df04c9ab.png)

### 层级偏差

鉴于根关卡序列、镜头和子序列系统的性质，可能在一些情况下，镜头和根关卡序列引用了同一个Actor，从而导致冲突。 **层级偏差（Hierarchical Bias）** 可用于裁定该Actor的哪个引用应优先于其他源进行求值。右键单击 **镜头（Shots）** 或[子序列（Subsequences）](index.md)，找到 **属性（Properties）** 菜单，然后查找 **层级偏差（Hierarchical Bias）**，即可找到此属性。

![在镜头属性菜单中设置层级偏差值](../../../../../../assets/images/ef/ef923c719d006376909beb2d07e22d11e27597257f0b2b2cbdadb36f414e0ac2.png)

增大某个源上的偏差数字将导致该源"胜出"，减小该数字将导致该源"输掉"，各个源的偏差值相等将导致所有源一起求值并混合（如果可能）。

顶级（根）序列上的层级偏差的默认值是 **0**，而对于子序列，则为 **100**。 这将导致镜头源优先于根关卡序列源。偏差还会针对添加的每个子序列层复合，因此，如果某个镜头序列包含子项子序列，其总偏差将为 **200**（100 + 100），导致默认情况下级别最深的影响"胜出"。

此效果如下图所示，其中：

1. 根序列，默认偏差为0，累积偏差为 **0**。
2. 第一个子序列，默认偏差为100，累积偏差为 **100**。
3. 第二个子序列，默认偏差为100，累积偏差为 **200**。

#### 偏差示例

以下示例演示了如何利用序列中的层级偏差值。

**光源Actor（Light Actor）** 放置在关卡中，并由三个不同的序列引用：

- 根关卡序列（Root Level Sequence）

  将引用此光源，其颜色在关键帧中设置为

  红色

  。

> 图片已省略：根关卡序列偏差0红色光源

- 根关卡序列中有一个

  镜头（Shot）

  ，其颜色在关键帧中设置为

  绿色

  。

> 图片已省略：镜头序列偏差100绿色光源

- 镜头中有一个

  Sub Sequence（子序列）

  ，其颜色在关键帧中设置为

  蓝色

  。

> 图片已省略：子序列偏差100累积偏差200蓝色光源

默认情况下，**子序列（Sub Sequnce）** 和 **蓝色** 光源优先，因为其累积偏差最大。下面列出了每个序列的偏差值，以供参考：

- 根关卡序列 = **0**
- 第一个子序列 = **100**
- 第二个子序列 = **200** (**100** + **100**)

> 图片已省略：根关卡序列设为红色关键帧，但由于偏差而显示为蓝色

如果右键单击子序列分段并将其层级偏差降低为 **-50**，这将导致 **镜头（Shot）** 和 **绿色** 光源优先。这是因为，子序列的累积偏差现在小于其父项，导致绿色光源的偏差最大。

此时，每个序列的偏差值将为：

- 根序列 = **0**
- 第一个子序列 = **100**
- 第二个子序列 = **50** (**100** - **50**)

> 图片已省略：负偏差减少了资产影响

将所有偏差值设置为 **0** 会导致所有序列一起求值，并且结果将混合。在本示例中，红色、绿色和蓝色光源颜色值将组合在一起，变为 **白色**。

此时，每个序列的偏差值将为：

- 根序列 = **0**
- 第一个子序列 = **0**
- 第二个子序列 = **0** (**0** + **0**)

> 图片已省略：将所有偏差设置为零会均匀混合镜头

## 分段编辑

每个Subsequence分段的功能类似于大多数 **[分段](../../creating-animation-keyframes/index.md#%E5%88%86%E6%AE%B5)**，这意味着可以移动、剪辑或编辑分段。

> 动图已省略：编辑剪辑子序列

为了将你的Subsequence彼此区分开来，点击轨道标题上的颜色栏，你可以更改轨道中所有分段上显示的颜色。这将打开 **取色器（Color Picker）** ，你可以从中选择该轨道的新颜色。

> 动图已省略：子序列颜色

### 循环

将分段拉长至超过其默认时间后，它会以线性方式扩展序列的播放范围。如果你是想循环序列，请右键点击分段，然后启用 **属性（Properties） > 可以循环（Can Loop）**。

> 动图已省略：loop subsequence

## 属性

右键点击Subsequence分段，找到 **属性（Properties）** 菜单，将显示以下属性：

> 图片已省略：子序列属性

| 名称 | 说明 |
| --- | --- |
| **时间速率（Time Scale）** | 控制Subsequence的播放速率。值为1时，播放速度正常，值越大，播放速度越快，值越小，播放速度越慢。 |
| **层级偏差（Hierarchical Bias）** | 控制Subsequence的[**层级偏差**](#%E5%B1%82%E7%BA%A7%E5%81%8F%E5%B7%AE)。如果数字更大，此Subsequence就会在引用相同Actor时优先于其他源。 |
| **子序列（Sub Sequence）** | 此Subsequence播放的序列资产。 |
| **网络掩码（Network Mask）** | 托管此Subsequence的网络域。可以设置为 **客户端（Client）** 、 **服务器（Server）** 或 **两者（Both）** 。根据你的序列的内容进行相应的设置至关重要。例如，如果Subsequence仅包含音频，则通常应将其设置为仅限 **客户端（Client）** ，因为音频不会在服务器上播放。 |

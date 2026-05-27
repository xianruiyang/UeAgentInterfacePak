---
title: "骨架编辑器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/skeleton-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画编辑器", "骨架编辑器"]
---

# 骨架编辑器

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画编辑器 / 骨架编辑器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/skeleton-editor-in-unreal-engine

虚幻引擎中，[骨架资产](../../animation-assets-and-features/skeletons/index.md) 是一切使用 **骨架网格体（Skeletal Meshes）** 制作动画的基础。你可以使用可视化的 **骨架编辑模式（Skeleton Editor Mode）** 里的各种工具来对 **骨架资产（Skeleton Assets）** 进行修改。

在这个编辑器中，你可以调整单个骨架或骨架结构，对接[骨架网格体插槽（Skeletal Mesh Sockets）](../../animation-assets-and-features/skeletons/skeletal-mesh-sockets/index.md)，预览与骨架相关的任何 **动画曲线（Animation Curves）** 和 **动画通知（Animation Notifies）**。在该编辑器中，你还可以使用 **重定向管理器（Retargeting Manager）** 来管理与当前骨架资产相关联的网格体。

下图为骨架编辑器窗口中的工具和面板：

![骨架编辑器窗口](../../../../../assets/images/05/054d81c76dfc593e957794ff94666ce62bcd7d0102dc4b62333ad49965eb958d.png)

1. [工具栏（Toolbar）](#%E5%B7%A5%E5%85%B7%E6%A0%8F)
2. [骨架树/重定向源（Skeleton Tree / Retarget Sources）](#%E9%AA%A8%E6%9E%B6%E6%A0%91/%E9%87%8D%E5%AE%9A%E5%90%91%E6%BA%90)
3. [视口（Viewport）](#%E8%A7%86%E5%8F%A3)
4. [场景预览设置/细节（Preview Scene Settings / Details）](#%E5%9C%BA%E6%99%AF%E9%A2%84%E8%A7%88%E8%AE%BE%E7%BD%AE/%E7%BB%86%E8%8A%82)
5. [动画曲线/动画通知（Anim Curves / Animation Notifies）](#%E5%8A%A8%E7%94%BB%E6%9B%B2%E7%BA%BF/%E5%8A%A8%E7%94%BB%E9%80%9A%E7%9F%A5)

## 工具栏

骨架网格体编辑器中的工具栏与虚幻引擎中的大部分工具栏相似。更多有关动画编辑器中函数的信息，参阅[动画编辑器概览-工具栏](../index.md#toolbar) for more information. 以下是骨架网格体编辑器中特有的功能。

![骨架编辑器工具栏](../../../../../assets/images/ed/ed4d5270ce9dabc887c98de832776c161f787fceb740aac39054b83100280004.png)

| 名称 | 图标 | 描述 |
| --- | --- | --- |
| **动画通知（Anim Notifies）** | 动画通知图标按钮 | 打开[动画通知](#%E5%8A%A8%E7%94%BB%E9%80%9A%E7%9F%A5) 面板，管理与骨架相关联的动画。 |
| **重定向源（Retarget Sources）** | 重定向源图标按钮 | 打开[重定向源](#%E9%87%8D%E5%AE%9A%E5%90%91%E6%BA%90) 面板，管理重定向源和骨架资产的设置。 |
| **导入网格体（Import Mesh）** | 导入网格体图标按钮 | 为该骨架导入一个新的网格体。 |
| **制作静态网格体（Make Static Mesh）** | 制作静态网格体图标按钮 | 用当前预览的姿势制作一个新的静态网格体。 |

## 骨架树/重定向源

这个面板默认显示骨架树选项卡。在工具栏中点击重定向源之后，[重定向源](#%E9%87%8D%E5%AE%9A%E5%90%91%E6%BA%90)选项卡也会显示。

### 骨架树

骨架树选项卡显示当前骨架资产的 **骨架层级（Skeletal Hierarchy）**，你可以在此创建和编辑[骨架插槽](../../animation-assets-and-features/skeletons/skeletal-mesh-sockets/index.md)并编写[动画重定向](#%E9%87%8D%E5%AE%9A%E5%90%91%E6%BA%90)相关的设置。

![骨架树窗口](../../../../../assets/images/92/9227d2a3191c624f847d18cb69bd0cc054ca5f34c6b406025975055c343d0bb5.png)

1. 使用绿色的 **加号** (**+**) 按钮，可以向你的骨架添加资产和配置。以下是这个加号（+）按钮可以创建的资产。

   | 名称 | 描述 |
   | --- | --- |
   | **插槽（Socket）** | 插槽偏移于骨架，可以用它将游戏物体对接到骨架上。 |
   | **虚拟骨架（Virtual Bone）** | 虚拟骨架是骨架的子级但是受限于另外的骨架。 |
   | **添加时间混合配置（Add Time Blend Profile）** | 时间混合配置以骨架为单位，是在过渡当中用来微调骨架权重的一组比例，与过渡混合的时间相关联。 |
   | **添加权重混合配置（Add Weight Blend Profile）** | 权重混合配置以骨架为单位，是在过渡当中用来微调骨架权重的一组比例，与过渡混合的权重相关联。 |
   | **添加混合遮罩（Add Blend Mask）** | 混合遮罩在多层姿势中判定主要的骨架。（分层混合节点和姿势查看会使用到这种遮罩。） |
2. **齿轮** 图标位于搜索栏的右侧，包括调整骨架预览和骨架树动作的设置和滤镜开关。以下是每个属性的详情和功能。

   | 设置 | 描述 |
   | --- | --- |
   | **混合配置（Blend Profiles）** | 选择你要用于当前骨架资产来预览和编辑的混合配置。基础骨架资产的配置会成列出现在骨架树选项卡中，用滑块的形式显示每块骨架的权重。混合配置标题下方的清空（Clear）选项可以清空当前的混合配置。 混合配置窗口 |
   | **添加时间混合配置（Add Time Blend Profile）** | 为当前骨架添加一个时间混合配置文件。 |
   | **添加权重混合配置（Add Weight Blend Profile）** | 为当前骨架添加一个权重混合配置文件。 |
   | **添加混合遮罩（Add Blend Mask）** | 为当前骨架添加一个混合遮罩。 |
   | **显示重定向选项（Show Retargeting Options）** | 这里可以在骨架树上新建一个列，显示每块骨架的 **骨架位移重定向（Bone Translation Retargeting）** 模式。包括以下选项： **动画（Animation）**: 显示相关动画中的位移数据。 **骨架（Skeleton）**: 显示相关骨架中的位移数据。 **缩放动画（Animation Scaled）**: 显示相关动画中的位移数据，但是按照当前骨架的比例进行缩放。 **相对动画（Animation Relative）**: 像叠加动画一样使用相对动画的位移。 **方向和缩放**: 调整方向和大小，形成一致的位移。 |
   | **折叠层级滤镜（Filtering Flattens Hierarchy）** | 判定搜索树上物体时显示上级层级还是将其折叠的可视化滤镜。 |
   | **隐藏母层级滤镜（Hide Parents When Filtering）** | 判定显示母级物体时将其变灰还是完全隐藏的可视化滤镜。 |
   | **显示全部骨架（Show all Bones）** | 显示当前骨架中的全部骨架。 |
   | **显示网格体骨架（Show Mesh Bones）** | 显示当前网格体中的全部骨架。 |
   | **显示LOD骨架（Show LOD Bones）** | 显示当前LOD中的全部骨架。 |
   | **显示带权重的骨架（Show Weighted Bones）** | 显示所有带有加权顶点的骨架。 |
   | **隐藏骨架（Hide Bones）** | 隐藏所有骨架，但是仍然显示插槽和其他相关联的资产。 |
   | **显示激活的插槽（Show Active Sockets）** | 显示网格体和骨架插槽，隐藏带有自定义网格体插槽的骨架插槽。 |
   | **显示网格体插槽（Show Mesh Sockets）** | 只显示网格体中的插槽。 |
   | **显示骨架插槽（Show Skeleton Sockets）** | 只显示骨架中的插槽。 |
   | **显示所有插槽（Show All Sockets）** | 显示所有骨架和网格体中的插槽。 |
   | **隐藏插槽（Hide Sockets）** | 隐藏所有插槽。 |

### 骨架操作

**骨架操作（Bone Manipulation）** 工具对于调整过骨架位置后的动画预览非常有用。你可以使用骨架操作模式预览其他资产与骨架直接的交互，也可以使用Timeline Record分配修改过的骨架位置来创建新的动画。

在骨架树窗口中选择要操作的骨架便可以使用骨架操作模式。视口中可以看到选中的骨架带有一个 **操作器（Mnipulator）** ，可以使用 **变换（Transform）** （**W**）、**旋转（Rotation）**（**E**）以及 **缩放（Scale）** （**R**）。

![骨架操作窗口](../../../../../assets/images/a0/a077f9bc67bf23ea76ebbc3c8d8c6fc4c0b842488916713a59f8ab5a24958212.jpg)

> [!NOTE]
> 操作完一块骨架之后，操作结果也会体现在你选中的不同动画资产上，因此你也可以预览不同动画所受到的影响。当你关闭再重新打开动画编辑器，任何修改过的骨架都会返回至它们原始的位置、旋转方向和大小。

### 重定向源

工具栏中的 **重定向源（Retarget Sources）** 工具会打开储存和管理重定向源的一个面板。重定向源使用[动画重定向（Animation Retargeting）](../../animation-assets-and-features/skeletons/animation-retargeting/index.md)的方式将动画导入至有着不同比例的其他角色上。

![重定向源窗口面板](../../../../../assets/images/76/76aa3f8742499e219a0e8d6eed7e85049b0296735a0ef00e201bdd90a860eb69.png)

## 视口

[视口](../../../../building-virtual-worlds/level-editor/editor-viewports/index.md) 窗口用于预览选中的骨架网格体并且提供你资产的相关信息。

![视口窗口](../../../../../assets/images/1e/1e85fd0b2212f10a1441a6394230215cb142a4aca5f3b469203a8d25a1f7ff58.jpg)

更多关于视口中围绕动画制作的独特功能，参阅[动画编辑器概览](../index.md) 页面。

## 场景预览设置/细节

该面板有两个选项卡，**场景预览设置（Preview Scene Settings）** 和 **细节（Details）**。

### 场景预览设置

这部分包括了[场景预览](../index.md#previewscenesettings) 选项卡，用于控制包括选中动画，使用的骨架网格体，视口光照，后期处理设置在内的预览设置。

![场景预览设置](../../../../../assets/images/fb/fb12b14bb649d147cc8f89d1dd34560e744d1dcffb58d4709eb6cf6782098e16.png)

### 细节

与主编辑器类似，细节面板用于编辑包括骨架在内的元素的各种属性。

![细节窗口面板](../../../../../assets/images/a3/a323960045ee98f0b8264dddda04997a5fd7236a6cca898a5e81cae1770f2aca.png)

点击骨架树中的一个插槽，细节面板便会显示插槽功能的各种选项。

> 图片已省略：插槽细节窗口面板

以下是骨架插槽的独特属性。

| 名称 | 描述 |
| --- | --- |
| **总是强制运行动画（Force Always Animate）** | 启用时，当前插槽以及其关联的各层骨架总是会进行动画运算，即使是在其结构经过针对当前LOD优化的情况下也一样。 |
| **插槽名称（Socket Name）** | 展示选中插槽的名称。 |
| **骨架名称（Bone Name）** | 显示当前插槽所对应的骨架的名称。 |

## 动画曲线/动画通知

这部分默认显示动画曲线。在工具栏中选中动画通知之后，对应的选项卡也会在这里出现。

### 动画曲线

**动画曲线（Anim Curves）** 面板可以用于创建并管理 **变形目标（Morph Target）** 以及选中骨架的 **属性（Attribute）** 和 **材质（Material）** 的曲线。

> 图片已省略：动画曲线窗口面板

你可以点击 **全部曲线（All Curves）** 来切换只显示已激活的曲线，然后可以通过变形目标、属性、材质旁的选项框切换显示不同曲线。

更多动画曲线和 **曲线编辑器（Curve Editor）** 的相关信息，请参阅[动画曲线](../../animation-assets-and-features/animation-sequences/animation-curves/index.md)。

### 动画通知

**动画通知（Animation Notifications）** (简写成 **动通（AnimNotifies）** 或者 **通知**) 帮助动画程序员将事件编排在 **动画序列（Animation Sequence）** 中特定的点上。动画通知通常用于给动画增添其他效果，比如行走时的脚步声。

> 图片已省略：动画通知窗口面板

在这里你可以创建并管理与当前骨架资产相关联的动画通知。

更多关于动画通知和工作流的示例，请参阅[动画通知](../../animation-assets-and-features/animation-sequences/animation-notifies/index.md)。

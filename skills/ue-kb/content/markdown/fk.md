# FK控制绑定

---
title: "FK控制绑定"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fk-control-rig-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "控制绑定", "使用控制绑定实现动画效果", "FK控制绑定"]
---

# FK控制绑定

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 控制绑定 / 使用控制绑定实现动画效果 / FK控制绑定

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fk-control-rig-in-unreal-engine

**FK控制绑定** 是一种程序化生成的控制绑定，可以被添加到 **Sequencer** 中的任意 **骨架网格体（Skeletal Mesh）** 中（无论该Actor是否拥有控制绑定资产）。这些绑定可对骨骼进行叠加式的更改，而无需创建完整的控制绑定资产。此外，你可以将任意动画序列烘焙到FK控制绑定，以实现覆盖性质的调整。

本文介绍了如何在[Sequencer](../../../cinematics-and-movie-making/index.md)中创建和使用FK控制绑定。

#### 先决条件

- 你已将骨架网格体角色添加到Sequencer。有关如何执行此操作的信息，请参阅[将动画应用到角色](../../../cinematics-and-movie-making/how-to-make-movies/how-to-add-cinematic-animation-to-a-character/index.md)页面。
- 你已熟悉Sequencer中的[关键帧](../../../cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md)。

## 创建和概述

创建FK控制绑定时，首先假定你已将骨架网格体添加到Sequencer，然后请点击角色的轨道上的 **添加(+)轨道（Add (+) Track）** ，然后选择 **控制绑定（Control Rig） > FK控制绑定（FK Control Rig）** 。

![创建控制绑定](../../../../../assets/images/f2/f2873ffff6372221018d2bcc0daeaa035afee91b643562d3a4b32a90660b94d8.png)

现在你可以看到FK控制绑定了，并且骨骼会显示在关卡视口中的骨架网格体上。

![fk控制绑定Sequencer轨道](../../../../../assets/images/6b/6bca7b595dd856c7c44acfcb10e74e5b26068f438476fa72bf2932010b1cd90a.png)

展开FK控制绑定轨道后，会显示骨骼的列表。你可以在此处选择骨骼（视口中会同时选中它们），也可以直接在视口中选择骨骼，这样还会选择该轨道。一旦选择骨骼后，你可以像处理Sequencer中的其他对象那样，对该骨骼进行操控和[设为关键帧](../../../cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md)。

> 动图已省略：fk控制绑定选择骨骼

## 用途

在Sequencer中创建FK控制绑定后，在gujia 网格体上创建动画时，你可以对各个骨骼单独制作动画。根据角色复杂度或动画的范围，有时可能更适合使用FK控制绑定，而不是在虚幻引擎之外的软件中额外创建一个动画。

例如，骨骼很少的骨架网格体可以使用FK控制绑定轻松制作出动画。选择你想制作动画的骨骼，并按 **S**（如果你的焦点在视口中）或 **回车键（Enter）**（如果你的当前焦点在Sequencer中）将其设为关键帧。

> 动图已省略：关键帧fk控制绑定

### 叠加FK

FK控制绑定还可以累加方式应用于Sequencer中的动画序列。如果你想对动画执行叠加式的编辑而不是将其覆盖，这就很有用。

要使FK控制绑定成为累加的，请右键点击 **FK控制绑定轨道（FK Control Rig track）** ，然后选择 **累加（Additive）** 。

> 动图已省略：累加fk控制绑定

现在你可以编辑骨骼和将骨骼设为关键帧，并将这些更改以累加方式应用于基础动画。

> 动图已省略：累加fk控制绑定

### 烘焙到FK控制绑定

你还可以将动画从Sequencer烘焙到FK控制绑定。如果你需要执行覆盖性调整（例如修复动画弹出内容或不合格曲线），这会很有用，无需在虚幻引擎外部执行相同的修复并重新导入。

为此，请右键点击Sequencer中的 **骨架网格体轨道（Skeletal Mesh track）** ，然后选择 **使用FK控制绑定编辑（Edit With FK Control Rig）** 。这会打开烘焙对话框窗口，你可以在其中指定以下选项：

![烘焙到fk控制绑定](../../../../../assets/images/d8/d8f73df82faf26ab28cc62b35c6acb919030940425a8fc270cc2a59e51f80bfd.png)

| 名称 | 说明 |
| --- | --- |
| **导出变换（Export Transforms）** | 将变换数据烘焙到FK功能按钮。 |
| **导出曲线（Export Curves）** | 将 **AnimCurve** 数据烘焙到FK功能按钮。 |
| **在世界空间中录制（Record in World Space）** | 在绝对世界空间坐标中烘焙。 |
| **对所有骨架网格体组件求值（Evaluate All Skeletal Mesh Components）** | 在烘焙时对所有骨架网格体组件求值。通常，如果你将蓝图用于其他骨架网格体组件，你可能想启用此项。 |
| **预热帧（Warm Up Frames）** | 在烘焙过程开始前要求值的帧数。如果有后期处理动画蓝图效果，这会很有用，因为这种效果需要更多的时间才能在求值前确定下来。 |
| **开始前的延迟（Delay Before Start）** | 在烘焙过程开始前要延迟的显示速度帧数。如果你需要在求值前反复运行后期处理动画蓝图效果，这会很有用。 |
| **减少关键帧（Reduce Keys）** | 启用此项以在烘焙过程发生后运行[简化](../../../cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/animation-curve-editor/index.md#%E7%AE%80%E5%8C%96)过程，这会基于公差数量删除冗余的关键帧。 |
| **容差（Tolerance）** | **容差（Tolerance）** 值越高，允许滤波曲线偏离原始值的程度就越高，在启用 **减少关键帧（Reduce Keys）** 的情况下，这会导致更多关键帧被删除。 |

按 **创建（Create）** 会完成烘焙操作，这会根据烘焙的动画使用关键帧创建FK控制绑定轨道。

> 动图已省略：烘焙到fk控制绑定

使用FK控制绑定编辑动画后，你还可以烘焙回动画序列，方法是右键点击 **骨架网格体轨道（Skeletal Mesh track）** ，然后选择 **烘焙动画序列（Bake Animation Sequence）** 或 **创建链接的动画序列（Create Linked Animation Sequence）** 。

![将fk控制绑定烘焙到动画](../../../../../assets/images/fc/fc81ac2a8b213f6647a930326da394e58e19754e0762f5e39f64f7882f03356d.png)

### 筛选骨骼列表

根据骨架网格体，FK控制绑定显示的骨骼列表有时可能非常大，并且可能包含你的动画用不到的骨骼。要解决该问题，你可以筛选所显示的骨骼列表，使其仅显示与你的工作流程相关的骨骼。

要筛选骨骼，请右键点击 **FK控制绑定轨道（FK Control Rig track）** ，然后点击 **选择要制作动画的骨骼或曲线（Select Bones Or Curves To Animate）** 。这会打开一个窗口，你可以在其中手动允许或禁止各个骨骼显示。

![fk控制绑定骨骼筛选器](../../../../../assets/images/29/294e2425d4c33ade5d8b788fcaffc678dba3f5fe4d83aac576e37b404a7a7751.png)

被筛选掉的骨骼会将从FK控制绑定轨道中被移除，并在视口中被隐藏，这样就可以更轻松地只处理你需要的骨骼。指定要筛选的骨骼后，点击 **确定（OK）** 应用筛选器。

![fk控制绑定骨骼筛选器](../../../../../assets/images/86/86049aebbecdc5d47caddd53bb1a11f0181e156ac12cd2dc4221396faef2e6a0.png)


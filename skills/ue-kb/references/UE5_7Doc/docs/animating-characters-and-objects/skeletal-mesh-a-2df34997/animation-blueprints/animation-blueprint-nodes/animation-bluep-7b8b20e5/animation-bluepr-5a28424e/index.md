---
title: "RigidBody"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-rigid-body-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "骨骼控制", "RigidBody"]
---

# RigidBody

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / 骨骼控制 / RigidBody

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-rigid-body-in-unreal-engine

通过 **RigidBody** [动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md)节点，你可以使用角色的[物理资产](../../../../../../gameplay-systems/physics/physics-asset-editor/index.md)对角色的辅助对象执行轻量级物理运动模拟。本文档将概述RigidBody节点，借助工作流程示例来介绍如何开始使用刚体节点。

![rigidbody节点动画蓝图节点](../../../../../../../assets/images/32/32356c8ab4c34a84eb782066058bff82e074f5d92d48bb173db892aff324a578.jpg)

#### 先决条件

* 你的项目包含[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)角色，带有[动画序列](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/animation-sequences/index.md)或[蒙太奇](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/animation-montage/index.md)。

## 概述

RigidBody节点的功能类似于[Anim Dynamics](../../../../../skeletal-mesh-an-2df34997/animation-blueprints/animation-blueprint-nodes/animation-bluep-7b8b20e5/animation-bluep-ec3334f1/index.md)节点，但提供了功能更为丰富的物理模拟解决方案，让你能够集成角色的物理资产，更好地控制模拟。将RigidBody节点与物理资产结合使用，你还可以模拟与角色其余部分以及关卡中其他对象的碰撞。

RigidBody节点的典型用途是，模拟角色的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)上的辅助结构的运动，例如从角色的主体悬挂或延伸出来的马尾辫、链子或其他骨骼，这些结构需要与[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)其余部分和关卡进行碰撞交互。RigidBody节点可用于实时模拟这些结构的动态和反应运动，比起真实物理模拟等性能要求较高的技术，这个过程更高效。

| 复制骨骼演示已禁用 | 复制骨骼演示已禁用 |
| --- | --- |
| RigidBody已禁用 | RigidBody 已启用 |

## 设置

示例将演示如何在角色的[动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md)中设置和实现RigidBody节点，使用物理资产模拟角色的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)上辅助结构的动态和反应运动。

### 创建物理资产

要开始使用RigidBody节点，你必须首先为角色设置物理资产。完整的设置指南可在[创建新的物理资产](../../../../../../gameplay-systems/physics/physics-asset-editor/physics-asset-editor-tutorial-directory/creating-a-new-physics-asset/index.md)文档中找到。

> [!NOTE]
> 如果角色已有关联的物理资产，你可以选择创建专用的物理资产，隔离出你要使用RigidBody节点模拟运动和碰撞的辅助结构。将专用的物理资产用于RigidBody节点可能是更优的方法，因为你可在模拟期间更好地控制结构的行为。

![内容浏览器中的物理资产](../../../../../../../assets/images/61/618a35706177ab2154103d2d54e057be1021d58eeef1bb773940f05420f500e9.jpg)

如果角色没有物理资产，或者你选择为RigidBody节点创建专用的物理资产，你可以为角色创建新的物理资产，方法是在 **内容浏览器（Content Browser）** 中 **右键点击** 角色的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)资产，选择 **创建（Create）> 物理资产（Physics Asset）> 创建（Create）** 。

![在内容浏览器中右键点击骨骼网格体，创建新的物理资产](../../../../../../../assets/images/8a/8a72d4485991d353d2f0048f4b2daecc4ad9098c43f8e57adba731c13a3636b3.png)

在 **新物理资产（New Physics Asset）** 窗口中，选择 **创建资产（Create Asset）** ，为角色创建新的物理资产。

有关创建物理资产的更多信息，请参阅[创建新的物理资产](../../../../../../gameplay-systems/physics/physics-asset-editor/physics-asset-editor-tutorial-directory/creating-a-new-physics-asset/index.md)指南。

### 编辑物理资产

在[物理资产编辑器](../../../../../../gameplay-systems/physics/physics-asset-editor/index.md)中打开角色的物理资产，确保角色的物理资产有[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)适合你想用于RigidBody节点的结构。在示例中，我们已经为角色的头部软管以及头部软管将与之交互的对象（例如角色的头部、背部、手臂和武器）生成了物理形体。

![物理资产物理形体表示碰撞和组件](../../../../../../../assets/images/26/26e106ffd0d58b1aea8fe8c89d1c40794f6efe3b766b220b6fbc6d385f570fea.jpg)

使用默认设置时，将在所有[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)上禁用碰撞。在 **骨架树（Skeleton Tree）** 中 **右键点击** 并选择 **碰撞（Collision）> 全部启用碰撞（Enable Collision All）** ，在组成你想模拟物理运动的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)部分的形体上启用碰撞。

![全部启用碰撞](../../../../../../../assets/images/ef/ef5d8c1fdcd8b946d8c11dfe58ac4f9091088cb58a9342839c36fe682f387450.png)

选中组成你想模拟物理和碰撞的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)部分的所有形体后，在 **细节（Details）** 面板中将其 **物理模式（Physics Mode）** 设置为 **模拟（Simulated）** 。

![为软管选择物理类型](../../../../../../../assets/images/e6/e680ee71b17408774fdf437e3ba3dc0ceaa42c4970ce73ec2d17c364a6a99e6d.jpg)

选择剩余物理形体，并将其 **物理模式（Physics Mode）** 设置为 **运动（Kinematic）** 。

![将剩余物理形体设置为运动](../../../../../../../assets/images/a6/a6bcb34c190461ab46913a8a7cfdcf1bc3025de8864b67a9ef0b5cdf0ac8f032.png)

你可以使用[物理资产编辑器](../../../../../../gameplay-systems/physics/physics-asset-editor/index.md) **工具栏（Toolbar）** 中的 **模拟（Simulate）** 按钮测试物理资产的基本功能。

> 动图已省略：模拟演示

在此阶段常出现模拟对象抖动或颤动的现象，若要修复此问题，可以在每个物理形体上启用并缩小 **质量（Mass (kg)）** 属性。首先将最靠近父结构的形体设置为最重的物理形体，并将链中每个后续形体的质量减半。

在示例中，第一个头部软管物理形体设置为 **2kg** 的质量，第二个头部软管物理形体设置为 **1kg** 的质量。

![物理形体的质量（kg）属性](../../../../../../../assets/images/54/54055bce403533eb701155cf7efbd3004295c26a601cdddc0670ea504c8f32b5.jpg)

**物理形体的质量（kg）属性**

最后，在你要模拟运动和碰撞的所有形体上，为 **线性阻尼（Linear Damping）** 和 **角阻尼（Angular Damping）** 属性设置值。值越高，运动越少，从而抑制模拟形体的摆动和颤动。在示例中，我们为每个属性设置了值 **5.0** ，要想实现理想的效果，为每个唯一实现微调该值至关重要。

> 图片已省略：阻尼设置

### 动画蓝图

你现在可以使用物理资产，将RigidBody节点添加到AnimGraph中角色的动画蓝图。

RigidBody节点在 **组件空间（Component Space）** 中运行，因此需要进行[空间转换](../../../../../skeletal-mesh-animation-system/animation-blueprints/animation-blueprint-nodes/animation-blueprint-component-space-022a8e09/index.md)，以在角色的动画蓝图中实现该节点。

默认情况下，RigidBody节点将利用与角色关联的物理资产。如果使用了辅助物理资产，你可以在 **细节（Details）** 面板中Rigidbody节点的 **覆盖物理资产（Override Physics Asset）** 属性中定义特定资产。

> 图片已省略：在rigidbody节点的细节面板中覆盖物理资产属性

### 调整和微调

若要进行更多调整，可以使用RigidBody节点属性中的约束 **组件线性加速度缩放（Component Linear Acc Scale）** 、 **组件线性速度缩放（Component Linear Vel Scale）** 、 **组件应用线性加速度限制（Component Applied Linear Acc Clamp）** 和 **模拟空间设置（Sim Space Settings）** 属性，也可以调整物理资产中[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)的位置，更紧密地契合骨架的关节。

> 图片已省略：缩放设置

你还可以在物理资产中的每个物理形体上调整 **质心（Center of Mass）** 属性，更紧密地契合最接近的骨骼关节，进一步减少颤动和多余的运动。

> 动图已省略：调整物理形体

### 效果

下面你可以看到工作流程示例中演示的RigidBody节点简单实现的最终效果。

> 动图已省略：rigidbody节点的示例演示

## 基础骨骼模拟参考

通过将 **模拟空间（Simulation Space）** 设置为 **基础骨骼空间（Base Bone Space）** 并在RigidBody节点的细节（Details）面板中定义 **基础骨骼（Base Bone）** ，任意关节都可以用作模拟的参考点。

> [!NOTE]
> 移动整个[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)并单独修改 **基础骨骼（Base Bone）** 对速度没有影响。因此，将 **基础骨骼空间（Base Bone Space）** 用作 **模拟空间（Simulation Space）** 时，角色运动不会影响模拟。

## 重置动态效果

RigidBody节点还支持 **Reset Dynamics** 蓝图节点，你可以在动画蓝图的 **EventGraph** 中使用它。要使用该函数节点，请从蓝图中的[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)获取动画实例，然后使用函数调用Reset Dynamics节点重置模拟。

> 图片已省略：reset dynamics节点动画蓝图事件图表

该函数节点尤其适合用于重置模拟，避免在传送角色等情况下可能发生的视觉效果问题和行为问题。

## 属性参考

> 图片已省略：rigid body节点细节面板

你可以在此处参考RigidBody节点的 **设置（Settings）** 属性列表。

| 属性 | 说明 |
| --- | --- |
| **覆盖物理资产（Override Physics Asset）** | 选择要使用的物理资产。如果为空，请使用[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)的默认物理资产。 |
| **覆盖世界场景重力（Override World Gravity）** | 启用该属性后，会覆盖世界重力，可在 **X** 、 **Y** 和 **Z** 轴上设置值。 |
| **外力（External Forces）** | 在世界空间中施加均匀的外力。这样就可以轻松模拟运动惯性，同时仍在组件空间中模拟。默认情况下，此属性显示为 **AnimGraph** 中节点上的引脚。 |
| **组件线性加速度缩放（Component Linear Acc Scale）** | 使用非世界空间模拟时，此属性会控制将组件的多少世界空间加速度传递给局部空间模拟。 |
| **组件线性速度缩放（Component Linear Vel Scale）** | 使用非世界空间模拟时，此属性会根据组件的世界空间速度对局部空间模拟中的[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)施加阻力。 |
| **组件应用线性加速度限制（Component Applied Linear Acc Clamp）** | 使用非世界空间模拟时，此为从 **组件线性加速度缩放（Component Linear Acc Scale）** 属性派生的对加速度的整体限制，用于确保它不会太大。 |
| **缓存边界比例（Cached Bounds Scale）** | 缓存边界的比例（相对于实际边界）。提高此值可以提高性能，但重叠可能无法正常运行。（值为1.0时，实际上会禁用缓存边界）。 |
| **基础骨骼参考（Base Bone Ref）** | **模拟空间（Simulation Space）** 设置为 **基础骨骼（Base Bone）** 时，从角色的[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)选择一个骨骼作为模拟的参考点。 |
| **重叠信道（Overlap Channel）** | 用于查找与之碰撞的静态几何体的通道。选项包括： **世界静态（World Static）** **世界动态（World Dynamic）** **Pawn** **可视性摄像机（Visibility Camera）** **物理形体（Physics Body）** **载具（Vehicle）** **可破坏（Destructible）** |
| **模拟空间** | 用于模拟[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)的空间。这会影响速度的生成方式。选项包括： **组件空间（Component Space）** ：在组件空间中模拟。移动整个[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)对速度没有影响。 **世界空间（World Space）** ：在世界空间中模拟。移动[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)将产生速度变化。 **基础骨骼空间（Base Bone Space）** ：在所选 **基础骨骼（Base Bone）** 的骨骼空间中模拟。移动整个[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)并单独修改 **基础骨骼（Base Bone）** 对速度没有影响。 |
| **强制禁用受约束形体之间的碰撞（Force Disable Collision Between Constrained Bodies）** | 是否允许某个约束所连接的两个[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)之间发生碰撞。 |
| **传输骨骼速度（Transfer Bone Velocities）** | 模拟开始时，从输入姿势传输之前的骨骼速度，以便无缝过渡到模拟。 |
| **开始时冻结传入姿势（Freeze Incoming Pose on Start）** | 模拟开始时，冻结传入姿势。在我们需要模拟接管的情况下，这很适合布娃娃。这可防止模拟骨骼播放动画。 |
| **将线性平移限制限定到参考姿势（Clamp Linear Translation Limit to Ref Pose）** | 校正锁定了所有轴的形体上的线性撕裂。这仅在所有轴线性平移均锁定时才适用。 |
| **世界空间最小缩放（World Space Minimum Scale）** | 对于世界空间模拟，如果组件的3D缩放的量级小于世界空间最小缩放，不要更新此模式。 |
| **求值休息时间（Evaluation Rest Time）** | 如果由于为整体使用了较低的LOD或组件不可见，在此时间（秒）内没有对节点求值，则在下一次求值时将模拟放置到默认姿势。设置为0时禁用基于时间的休息。 |

### 模拟空间设置

RigidBody节点的模拟空间设置可控制从模拟的空间传递到模拟的运动。这允许模拟将世界空间运动的一部分传递到[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)，从而允许 **骨骼空间（Bone-Space）** 和 **组件空间（Component-Space）** 模拟以可控的方式对世界空间移动做出反应。

> [!WARNING]
> 此系统是 **组件线性加速度缩放（Component Liner Acc Scale）** 、 **组件线性速度缩放（Component Linear Vel Scale）** 和 **组件应用线性加速度限制（Component Applied Linear Acc Clamp）** 提供的功能超集。对于大部分情况，你不应同时启用两个系统。

你可以在此处参考RigidBody节点的模拟空间设置属性列表。

| 属性 | 说明 |
| --- | --- |
| **主阿尔法（Master Alpha）** | 模拟空间移动效果的全局乘数。但应在[0, 1]范围内。如果主阿尔法设置为0，系统将遭到禁用，模拟将完全在本地完成，例如，世界空间Actor移动和旋转不会影响此模拟。主阿尔法设置为1时，模拟实际上用作世界空间模拟，但可将限制应用于其他参数。 |
| **速度缩放Z（Velocity Scale Z）** | 具有速度和加速度的Z组件传递到模拟的乘数。通常在0.0到1.0的范围内，以降低模拟上的跳跃和蹲伏的效果，但如果你需要让此运动更夸张，值可以大于1.0。 |
| **最大线性速度（Max Linear Velocity）** | 对传递到模拟的有效世界空间速度的限制。单位是厘米/秒。默认值实际上意味着"无限制"。通常不需要更改此设置，但如果你在物理资产中有形体的线性阻力设置为非零值，你就需要降低此设置，以限制模拟中[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)的阻力效果。在此情况下，预期的值会略小于对象的通常速度，对角色而言，常常为几百。 |
| **最大角速度（Max Angular Velocity）** | 对传递到模拟的有效世界空间角速度的限制。单位是弧度/秒，因此大约6.0的值相当于每秒旋转一次。默认值实际上意味着"无限制"。当Actor原地旋转时，你需要降低此设置（和最大角加速度），以限制形体冲出的程度。如果你的角色可以快速地旋转，这尤其有用，在此情况下，你很可能需要值在10左右或更低。 |
| **最大线性加速度（Max Linear Acceleration）** | 对传递到模拟的有效世界空间加速度的限制。单位是厘米/秒/秒。默认值实际上意味着"无限制"。此属性用于在突然改变线性速度时防止模拟的[物理形体](../../../../../../gameplay-systems/physics/physics-bodies/index.md)冲出。如果你的角色可以快速从静止状态变为奔跑，例如在FPS中，这就很有用。角色的常见值可能是几百。 |
| **最大角加速度（Max Angular Acceleration）** | 对传递到模拟的有效世界空间角加速度的限制。单位是弧度/秒/秒。默认值实际上意味着"无限制"。此设置的效果类似于最大角速度，只不过它与旋转速度突然变化时形体的冲出有关。角色的典型限制可能为100左右。 |
| **外部线性阻力V（External Linear Drag V）** | 除了物理资产中对每个形体指定的线性阻力之外，还有额外的线性阻力应用于每个形体。与外部线性速度结合使用时，此设置可用于增加临时的风吹效果，而不必在物理资产中的所有形体上调整线性阻力。因此，每个形体都会应用等于(- 外部线性阻力v * 外部线性速度)的一股力量，再加上其他所有力量。此向量位于模拟本地空间中。 |
| **外部线性速度（External Linear Velocity）** | 额外的速度会添加到组件速度，因此，即使是在静止状态下，模拟也会表现为Actor在快速移动。向量位于世界空间中。单位是厘米/秒。可以用于外部风效果。典型的值类似于对象或效果的速度，对于角色/风通常在1000左右或更低。 |
| **外部角速度（External Angular Velocity）** | 添加到组件角速度的额外角速度。这可以用于使模拟表现为Actor在旋转，即使实际并未旋转。例如，随着摄像机围绕讲台上的角色旋转，将物理状态应用于该角色，以模拟讲台本身的旋转。向量位于世界空间中。单位是弧度/秒。 |

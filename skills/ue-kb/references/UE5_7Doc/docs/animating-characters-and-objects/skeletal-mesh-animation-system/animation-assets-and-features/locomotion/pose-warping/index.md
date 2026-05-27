---
title: "姿势扭曲"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pose-warping-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "移动", "姿势扭曲"]
---

# 姿势扭曲

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / 移动 / 姿势扭曲

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pose-warping-in-unreal-engine

姿势扭曲让你动态调整角色的动画姿势以契合胶囊体移动。本文档将介绍姿势扭曲功能，并演示角色的动画蓝图中的姿势扭曲实现。

#### 先决条件

- 启用

  动画扭曲（Animation Warping）

  插件。如需详细了解

  插件

  及其安装方法，请参阅

  使用插件

  。

![动画扭曲插件](../../../../../../assets/images/46/463b2ccc699efbb705b48e92842620ea8c3774b537de6a818287bb9a066c0008.png)

- **姿势扭曲** 使用了[动画蓝图](../../../animation-blueprints/index.md)工作流程，所以你需要理解此功能。
- 此外，启用[根骨骼运动](../root-motion/index.md)的动画、实现的[IK Rig](../../../animation-blueprints/animation-blueprint-nodes/fabrik-animation-blueprint/index.md)和由根骨骼运动驱动的方向变量必须在项目中你想创建Gameplay示例的地方可访问。

## 姿势扭曲概述

动画蓝图节点的姿势扭曲集通过扭曲对[动画序列姿势](../../animation-pose-assets/index.md)执行动态调整，以在游戏世界中创建更连贯的动画互动。

姿势扭曲可以分解为三个[节点](../../../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/nodes/index.md)。其中每个节点执行特定用途的扭曲实现来调整动画，以独特方式匹配根骨骼运动。

> 动图已省略：姿势扭曲演示

1. [方向扭曲](#%E6%96%B9%E5%90%91%E6%89%AD%E6%9B%B2)
2. [步幅扭曲](#%E6%AD%A5%E5%B9%85%E6%89%AD%E6%9B%B2)
3. [斜面扭曲](#%E6%96%9C%E9%9D%A2%E6%89%AD%E6%9B%B2)

每个节点的属性中有许多参数可以通过 **手动评估（Manual Evaluation）** 模式来定义，进而控制这些扭曲的生成。其中还有 **图表评估（Graph Evaluation）** 模式，可以自动定义这些参数。

### 通用细节

下方介绍了Pose Warping节点属性及其作用。

![animation warping节点细节](../../../../../../assets/images/1e/1e7c3cf229a1e618c5e0a14644b8cfc6d16205d6036dabb1abb598934416c1d1.png)

| 名称 | 说明 |
| --- | --- |
| **模式（Mode）** | 选择Pose Warping节点将从哪个模式中继承值，该值将用于扭曲动画的姿势。 **手动（Manual）** ：动画扭曲评估从用户定义的参数继承。由于依赖更新变量时缺乏过渡平滑度，这最好用于静态或脚本化情况。 **图表（Graph）** ：动画扭曲评估从动态定义、图表驱动的参数继承。一些节点属性将更改，现在需要启用根骨骼运动的动画序列。 |
| **IK足部根骨骼（IK Foot Root Bone）** | 定义骨架的IK足部根骨骼。 |

## Pose Warping节点

下方介绍了各个Pose Warping节点的独特属性及其函数。

### 方向扭曲

Orientation Warping节点会将方向性补偿扭曲应用于运行中的动画。使用此节点，你可以隔离并扭曲动画姿势的腿部IK骨骼，以契合根骨骼运动的动态更新移动方向。该姿势还将沿指定轴扭转脊柱骨骼，以维持面向角度。

此功能可用于填充动画序列中的覆盖缺口，减少手动创建间隙动画或创建过多混合空间过渡的必要性。

![orientation warping节点](../../../../../../assets/images/4f/4f4079e45ea2a610e682e114adeeff2ae0a04d8822f53daf2b070337459ba6d0.png)

下方介绍了方向扭曲属性及其作用。

| 属性 | 说明 |
| --- | --- |
| **方向角度（Orientation Angle）** | 仅当 **评估模式（Evaluation Mode）** 属性设置为 **手动（Manual）** 时可用。定义你想扭曲移动组件姿势的方向程度。该值将随 **旋转轴（Rotation Axis）** 属性下指定的轴发生变化。 |
| **移动角度（Locomotion Angle）** | 仅当 **评估模式（Evaluation Mode）** 设置为 **图表（Graph）** 时可用。定义你想扭曲移动组件姿势的方向程度。移动角度（Locomotion Angle）旨在使用图表驱动的值，非常适合动态变化的值。 这将用于以下公式来计算方向角度：[Orientation = RotationBetween(RootMotionDirection, LocomotionDirection)]。 |
| **位置角度增量阈值（Location Angle Delta Threshold）** | 指定角度阈值以防止角色错误地过度旋转。默认情况下，该属性设置为90度，将值设为0可将其禁用。 |
| **脊柱骨骼（Spine Bones）** | 定义使扭曲整体逐渐减弱的脊柱骨骼，以提供看起来更加无缝的旋转。 使用 **添加 (+)（Add (+)）** 按钮可添加更多定义。索引0是层级排名最高且旋转程度最小的骨骼，每个递增一个索引即为下一个嵌套脊柱骨骼，旋转的影响逐步增加。 |
| **IK足部骨骼（IK Foot Bones）** | 添加并定义骨架中存在的 **IK足部骨骼（IK Foot Bones）** 的索引实例。 |
| **旋转轴（Rotation Axis）** | 定义方向扭曲应当在哪个轴上发生。对于大部分情况，方向扭曲应当在 **Z** 轴上发生，导致身体扭转。 |
| **分布式骨骼方向Alpha（Distributed Bone Orientation Alpha）** | 指定多大程度的旋转通过脊柱骨骼在角色身体中分布。该值偏向于上半身，值为1表明总体旋转发生在索引为0的脊柱骨骼处，值为0表明旋转发生在最高索引的脊柱骨骼处。 |
| **旋转插值速度（Rotation Interp Speed）** | 指定插值或混合速度（以阿尔法/秒为单位），以便达到最终扭曲的旋转角度。值越低，表明插值速度越低，因此移动变化与动画扭曲之间的过渡越缓慢。值越高，则过渡越快，但平滑度越低。值为0将导致瞬时旋转。 |

### 步幅扭曲

Stride Warping是动态调整角色的动画步幅来匹配胶囊体移动速度的一种姿势扭曲节点。通过定义运动速度和相关骨骼，Stride Warping节点能够修改足部位置之间的间距，创建动态调整的步幅长度来匹配运动速度。这减少了手动调整移动速度来匹配动画播放的必要性，并减少了在不同移动速度的不同动画序列之间过渡时对混合空间的依赖程度。

![stride warping节点](../../../../../../assets/images/25/25b1d1be25d39d5486f3ba4cc518dd1c6c8e61720e343c4157c90070348dc296.png)

下方介绍了步幅扭曲属性及其应用。

| 属性 | 说明 |
| --- | --- |
| **步幅方向（Stride Direction）** | 仅当 **评估模式（Evaluation Mode）** 设置为 **手动（Manual）** 时可用。定义步幅将朝向的运动方向。 |
| **步幅比例（Stride Scale）** | 当 **评估模式（Evaluation Mode）** 设置为 **手动（Manual）** 时，缩放应用于足部定义的扭曲数量，以便微调步幅。值为1时将提供默认扭曲比例，值为0.5时会将有效腿部步幅减半，值为2时会将有效腿部步幅加倍。 以下公式将用于计算步幅比例：[StrideScale = (LocomotionSpeed / RootMotionSpeed)]。 |
| **移动速度（Locomotion Speed）** | 当 **评估模式（Evaluation Mode）** 设置为 **图表（Graph）** 时，指定应用于角色的当前运动速度。此参数依赖于图表驱动的评估（Graph Driven Evaluation）模式，旨在连贯地处理动态更新的数据，例如根骨骼运动或胶囊体速度。要实现最佳结果，声明的速度应当随动画图表的增量时间发生变化。 |
| **最小移动速度阈值（Min Locomotion Speed Threshold）** | 应用步幅扭曲功能的效果所需最小移动速度值的定义阈值。 |
| **骨盆骨骼（Pelvis Bone）** | 定义骨架的 **骨盆骨骼**。 |
| **足部定义（Foot Definitions）** | 在此参数中，可以创建索引并用于定义执行扭曲所需的IK和FK足部和大腿骨骼。骨架中存在的每个移动腿部需要一个带有必要定义的索引。 |
| **步幅比例修饰符（Stride Scale Modifier）** | 你可以使用此参数添加固定和插值参考，以修改最终步幅比例结果。这些限制可以通过切换 **固定结果（Clamp Result）** 或 **插值结果（Interp Result）** 子属性来激活。 固定范围可以通过指定允许缩放发生的最小值和最大值来修改。值1是基础比例，0.5是减半的比例，2是加倍的比例。 你可以定义插值速度来控制应用插值的运动速度范围。**插值速度递增（Interp Speed Increasing）** 定义了以递增运动速度值应用插值的阈值。发过来，**插值速度递减（Interp Speed Decreasing）** 定义了在运动速度递减时应用插值的阈值。 |

下方介绍了Stride Warping节点的参数中用于微调步幅扭曲应用的 **高级** 属性。

| 名称 | 说明 |
| --- | --- |
| **地板法线方向（Floor Normal Direction）** | 该值在内部会转换为扭曲之前的对应组件空间表示。 模式：对应向量值的空间。 **组件空间向量（Component Space Vector）** **Actor空间向量（Actor Space Vector）** **世界空间向量（World Space Vector）** **IK足部根骨骼局部空间向量（IKFoot Root Local Space Vector）** **值（Value）** ：指定相对于模式定义的空间的向量。 |
| **重力方向（Gravity Direction）** | 该值在内部会转换为扭曲之前的对应组件空间表示。 声明此属性会将对应 **向量值** 转换到的空间，而此向量值将应用重力的模拟方向性牵拉。不同模式的声明空间如下所示： **组件空间向量（Component Space Vector）** **Actor空间向量（Actor Space Vector）** **世界空间向量（World Space Vector）** **IK足部根骨骼局部空间向量（IKFoot Root Local Space Vector）** |
| **骨盆IK足部解算器（Pelvis IK Foot Solver）** | 该解算器用于控制在腿部伸展期间骨盆朝IK/FK足部定义下拉的幅度。 **骨盆调整插值（Pelvis Adjustment Interp）**：指定在骨盆调整期间应用的弹簧插值参数。由刚度约束（Stiffness Constraint）属性和阻尼比（Damping Ratio）属性定义。 **骨盆调整插值Alpha（Pelvis Adjustment Interp Alpha）**：指定原始和最终调整的骨盆位置之间的alpha。这用于保留一定程度的原始骨盆运动。 **骨盆调整最大距离（Pelvis Adjustment Max Distance）**：指定骨盆相对于其原始位置可以调整的最大变化范围。 **骨盆调整容错（Pelvis Adjustment Error Tolerance）**：指定如果骨盆调整距离对于每次迭代按低于或等于该值的值递增，则解算将停止。值更低时，视觉质量会略微提高，而性能会降低，但可能需要指定更高的PelvisAdjustmentMaxIter。 **骨盆调整最大迭代次数（Pelvis Adjustment Max Iter）**：指定要为骨盆调整解算器运行的最大迭代次数。迭代次数更高时，将保证PelvisAdjustmentErrorTolerance收敛更近，而性能会降低。 |
| **使用地板法线确定步幅方向（Orient Stride Direction Using Floor Normal）** | 按地板法线确定指定的（**手动（Manual）**）或计算的（**图表（Graph）**）步幅方向。 |
| **使用FK大腿旋转补偿IK（Compensate IK Using FK Thigh Rotation）** | 包括沿IK/FK足部定义对FK大腿骨骼的扭曲调整。这用于帮助保留原始整体腿部形状。 |
| **使用FK限制来固定IK（Clamp IK Using FK Limits）** | 固定IK足部扭曲以防止相对于整体FK腿部过度伸展。 |

### 斜面扭曲

斜面扭曲用于辅助扭曲足部位置匹配地板法线，让斜坡和楼梯上的移动动画的更平滑地过渡。

![slope warping节点](../../../../../../assets/images/80/80d590f1f392c210c420024330a08207fdd3d286d1d12d2c7f2526f27c82dec3.png)

> [!WARNING]
> 该节点仍在开发中，请勿在项目中使用其功能，但我们鼓励在测试环境中实现。

下面是与Slope Warping节点关联的属性的列表。

| 名称 | 说明 |
| --- | --- |
| **骨盆骨骼（Pelvis Bone）** | 定义骨架的 **骨盆骨骼**。 |
| **足部定义（Feet Definitions）** | 在该参数中，可以创建并使用索引来定义必要的IK和FK足部骨骼、与定义的足部关联的 **骨骼数量（Number of Bones）** 以及以虚幻单位计的 **足部大小（Foot Size）** 值。这些定义将确定该节点将用于执行斜面扭曲的骨骼。对于骨架中存在的每个移动腿部，你需要一个带有必要定义的索引。 |
| **骨盆偏移插值器（Pelvis Offset Interpolator）** | 指定在骨盆调整期间应用的骨盆骨骼偏移插值参数。由 **刚度约束（Stiffness Constraint）** 属性和 **阻尼比（Damping Ratio）** 属性定义。 |
| **重力方向（Gravity Dir）** | 定义扭曲所影响的骨骼元素中重力牵拉的 **方向**。 |
| **自定义地板偏移（Custom Floor Offset）** | 定义要将哪个轴用于执行相对于骨架的自定义地板偏移。 |
| **地板法线插值器（Floor Normal Interpolator）** | 指定在骨盆调整期间应用的地板法线插值参数。由 **刚度约束（Stiffness Constraint）** 属性和 **阻尼比（Damping Ratio）** 属性定义。 |
| **地板偏移插值器（Floor Offset Interpolator）** | 指定在骨盆调整期间应用的地板偏移插值参数。由 **刚度约束（Stiffness Constraint）** 属性和 **阻尼比（Damping Ratio）** 属性定义。 |
| **最大步阶高度（Max Step Height）** | 定义斜面扭曲的步阶之间可能的高度调整最大值，以虚幻单位计。 |
| **将网格体保留在胶囊体内部（Keep Mesh Inside Of Capsule）** | 启用此项后，会阻止扭曲将 **网格体** 推到 **胶囊体** 外部。 |
| **下拉骨盆（Pull Pelvis Down）** | 启用骨盆下拉以适应新的足部位置。 |
| **使用自定义地板偏移（Use Custom Floor Offset）** | 切换自定义地板偏移的使用。 |

## 姿势扭曲工作流程

下面的工作流程演示了角色的动画蓝图中Orientation Warp节点的基本实现，用于向移动动画添加扭曲。

首先，在角色的动画蓝图的AnimGraph中，调用对启用根骨骼运动的动画序列的引用。对于本演示，动画可以简单到只是单个方向性移动动画，也可以复杂到是全系列的带过渡的基本方向移动。本演示中使用的移动状态机仅包含一个向前慢跑动画。

使用这单个动画以及Orientation Warping节点，可以实现完整180度的下半身动画，从而在保留上半身面向角度的同时适应模拟输入控制。

### 添加必要的AnimBP节点

本演示使用一个简单的状态机，带有一个空闲动画和启用根骨骼运动的单个向前慢跑动画之间的过渡。

![动画状态机](../../../../../../assets/images/a8/a8d442e7b9584b092355595ace13e697b47d3997a32ece32aa4a4cbb6f9ce659.png)

拖移 **状态机** 的 **输出引脚（Output Pin）** ，创建 **Local To Component** [空间转换节点](../../../animation-blueprints/animation-blueprint-nodes/animation-blueprint-component-space-022a8e09/index.md)。你需要该节点来将构成动画序列的动画姿势转换为组件空间。

![添加local to component过渡节点](../../../../../../assets/images/b8/b86461e35f69cc2e55899d44fdf392e0ee5553da05b9295ee88e488c53719a0c.png)

从该 **Local To Component** 空间转换节点，拖移 **输出引脚（Output Pin）** 以创建 **Orientation Warping** 节点。

![添加orientation warping节点](../../../../../../assets/images/e4/e47c51ea292bf9179fd576fe6a250489a92fb95b7ee530f614f6b2d924b526c3.png)

在Orientation Warping节点之后，你需要一个下游Leg IK节点，将对骨架的IK骨骼所做的扭曲传达到FK骨骼。

> 图片已省略：添加leg ik节点

将 **Leg IK** 节点连接到 **Result** 节点，Local to Component转换将自动创建 **Component To Local** 空间转换节点来结束。

> 图片已省略：leg ik到最终输出姿势

所有必要节点就位后，编译将返回与Orientation Warping节点相关的错误。在编译器结果面板中，列出的方向错误请求了脊柱和IK骨骼定义。这些骨骼可以在细节面板中的方向扭曲（Orientation Wrapping）属性中定义，见下一小节的说明。

> 图片已省略：方向扭曲错误

### 定义必要参数

在AnimGraph视口中点击Orientation Warping节点将打开细节（Details）面板。在设置（Settings）标题下，你可以分配骨架的IK足部根骨骼和各个IK足部的实例。此外，你还需要点击 **添加 (+)（Add (+)）** 并为该节点指定至少一个脊柱骨骼来置换扭转，以便保留角色的面向角度。一个骨骼将充当整个下半身的枢轴点。添加更多脊柱变量会使扭曲沿全体脊柱骨骼逐渐减弱，这样看起来更自然。

> 图片已省略：定义方向扭曲骨骼

> [!NOTE]
> 最好填充模型的骨架中存在的相等数量的脊柱骨骼。

现在必须定义方向扭曲角度。你可以设定大量参数来手动定义该角度，也可以使用动态值（例如根骨骼运动角度驱动的方向性变量）来自动提供该角度。

在 **Orientation Warping** 节点的 **细节（Details）** 面板中，将 **评估模式（Evaluation Mode）** 更改为 **图表（Graph）** 。评估模式（Evaluation Mode）为图表（Graph）时，方向角度（Orientation Angle）引脚这个手动静态值会更改为移动角度（Locomotion Angle）引脚，后者可以使用图表驱动的值来连接。对于本示例，我们将使用胶囊体移动方向驱动的方向（Direction）变量。

> 图片已省略：在orientation warping节点中将评估模式设置为图表

调用 **方向（Direction）** 变量并将变量节点的 **输出引脚（Output Pin）** 连接到 **移动角度输入引脚（Locomotion Angle Input Pin）** 。

> 图片已省略：调用方向变量并连接到orientation warping节点

最后，你需要在IK Rig属性中有其FK骨骼对应物的IK骨骼的定义，以混合发生的扭曲。

在 **IK Rig细节（IK Rig Details）** 面板中，使用 **添加 (+)（Add (+)）** 为模型中存在的每个腿部创建 **腿部定义（Leg Definition）** 数组。在数组中定义IKFoot骨骼和FKFoot骨骼。

> 图片已省略：定义ik rig节点骨骼

> [!NOTE]
> 腿部定义（Leg Definition）数组中的 **肢体中的骨骼数量（Num Bones In Limb）** 属性说明了腿部结构中与每个足部关联的骨骼数量。该值不包括足部骨骼本身，必须考虑到构成应该扭曲的剩余结构的每一个骨骼。对于本示例的情况，从足部向上，有一个腓骨和大腿骨骼，然后到达骨盆骨骼。由于骨盆不是腿部结构的一部分，我们声明了2个骨骼来与已定义的足部骨骼关联。这是典型的结构，但你的骨骼网格体可能有所不同。

### 结果

编译、保存和运行关卡将演示Orientation Warping节点的效果。仅使用单个动画序列、一个向前慢跑动画，即可生成完整180度的移动覆盖。此外，通过定义脊柱骨骼，还会保留面向角度，这样角色会保持面向移动方向。

| 姿势扭曲之前 | 姿势扭曲之后 |
| --- | --- |
| 方向扭曲关闭 | 方向扭曲打开 |
| 在上述演示中，应用于角色的输入不会通过胶囊体对网格体执行位置和方向移动。由于现有动画覆盖存在局限性，输入对动画播放不起作用。动画直接沿单个方向循环。 | 上述工作流程完成后，将实时执行扭曲，由角色的输入驱动。注意脊柱中发生的扭转，让腿部动画的方向跟随输入驱动的移动方向（**红色箭头**），同时保留根骨骼运动驱动的面向方向（**蓝色箭头**）。 |

下面是本页用于实现Orientation Warping节点的动画蓝图逻辑大图。

> 图片已省略：蓝图最终效果

## 调试

下方介绍了调试属性，这些属性用于辅助纠正在实现Orientation Warping或Stride Warping节点时遇到的问题。

### 方向扭曲

下方介绍了Orientation Warping节点的调试属性及其作用。

| 名称 | 说明 |
| --- | --- |
| **调试绘制比例（Debug Draw Scale）** | 均匀地缩放直观绘制的调试导线。 |
| **启用调试绘制（Enable Debug Draw）** | 如果启用此项，运行期间将在视口中绘制来自角色的一组彩色箭头来表示相关向量。 **红色箭头**：输入方向。 **蓝色箭头**：根骨骼运动。 **绿色箭头**：模拟方向，这是混合向量，由输入和显示的操作确定。此混合的速度可以使用细节（Details）面板中的 **旋转插值速度（Rotation Interp Speed）** 属性来调整。 |

### 步幅扭曲

下面是调试属性列表，可帮助你成功实现Stride Warping节点。

| 名称 | 说明 |
| --- | --- |
| **调试绘制比例（Debug Draw Scale）** | 均匀地缩放直观绘制的调试导线。 |
| **启用调试绘制（Enable Debug Draw）** | 运行期间在视口中显示来自角色的胶囊体中心的红色箭头来表示移动速度向量。输入力越大，绘制的箭头就越长，输入力越小，则箭头越短。 |
| **调试绘制IK足部原点（Debug Draw IKFoot Origin）** | 启用此项后，定义的IK足部将通过红色球体显示。 |
| **调试绘制IK足部调整（Debug Draw IKFoot Adjustment）** | 如果启用此项，将绘制来自IK足部中心的蓝色向量箭头，以清晰地显示所做的调整。 |
| **调试绘制骨盆调整（Debug Draw Pelvis Adjustment）** | 启用此项后，将在视口中绘制向量，指示正在进行的骨盆骨骼调整。 |
| **调试绘制大腿调整（Debug Draw Thigh Adjustment）** | 切换绘制的向量，以直观显示正在对定义的大腿骨骼进行的调整。 |
| **调试绘制IK足部最终（Debug Draw IKFoot Final）** | 在发生完整扭曲后，该属性可用于绘制IK足部骨骼最终位置的视觉呈现。 |

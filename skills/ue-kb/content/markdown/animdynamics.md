# AnimDynamics

---
title: "AnimDynamics"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-animdynamics-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "骨骼控制", "AnimDynamics"]
---

# AnimDynamics

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / 骨骼控制 / AnimDynamics

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-animdynamics-in-unreal-engine

AnimDynamics[动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md)节点是一种轻量级的物理模拟解决方案。你可以用它在运行时对角色的部分[骨架网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)应用基于物理的附属动画。与使用角色[物理资产](../../../../../../gameplay-systems/physics/physics-asset-editor/index.md)的[RigidBody](../../../../../skeletal-mesh-a-2df34997/animation-blueprints/animation-blueprint-nodes/animation-bluep-7b8b20e5/animation-bluepr-5a28424e/index.md)节点不同，AnimDynamics节点可以模拟自己的物理刚体，以提升项目性能。

![anim dynamics骨骼控制动画蓝图节点](../../../../../../../assets/images/e8/e8d9cb15e84c871fcb9b4dec3491bc980c503357a1e090aaf1172de6f92ee02d.jpg)

借助AnimDynamics节点，你可以将物理模拟效果用于角色的不分骨架网格体上，如项链、手镯、导线或任何与角色一起运动的物品。

在这个例子中，AnimDynamics节点被用于动态控制角色的天线运动，使其宰动画播放时响应角色头部动画。

| anim dynamics animation blueprint bot demo disabled | anim dynamics animation blueprint node bot demo enabled |
| --- | --- |
| AnimDynamics已禁用 | AnimDynamics已启用 |

## 概述

AnimDynamics节点是一种运行时在AnimGraph中运行的低开销物理解算器。为了实现低开销，AnimDynamics节点采用了一些值得留意的近似解算方法：

- 使用模拟的 **盒体** 而非角色的骨骼或物理刚体来计算各节的惯性。
- **不** 计算碰撞。相反，使用 **约束** 来限制移动。

AnimDynamics节点支持 **线性** 约束、**角** 约束和 **平面** 约束，以便模拟基于物理的的运动。**线性（Linear）** 和 **角（Angular）** 约束可以受 **弹簧** 的驱动，提供更有弹性的感觉，而 **平面（Planar）** 约束可用于创建对象不会穿过的平面。你可以切换各个约束，并在AnimDynamics节点的 **细节** 面板调整它们的相关属性。

![anim dynamics骨骼控制动画蓝图节点约束设置](../../../../../../../assets/images/24/243eb1b7347dbf62b0effebf3d1edfba1f1fb5c60f3f7632d0b6a47d5454f5a5.png)

## 单体模拟

借助AnimDynamics节点，你可以将物理模拟运动施加在角色身上使用骨骼作为参考点的任意对象上。在下面的示例中，使用AnimDyamics节点向一个会随着角色运动而摆动的鼓添加了动态运动。

| anim dynamics animation blueprint node drum demo disabled | anim dynamics animation blueprint node drum demo enabled |
| --- | --- |
| AnimDynamics已禁用 | AnimDynamics已启用 |

将鼓的骨骼设置为 **边界骨骼（Bound Bone）** 后，你可以定义使用 **盒体约束（Box Constraints）** 属性定义边界盒体，从而控制由物理驱动的运动。**局部关节偏移（Local Joint Offset）** 是一个源自 **边界骨骼（Bound Bone）** 的偏移量，用于确定约束的参考点。

> [!NOTE]
> 使用 **盒体约束（Box Constraints）** 和 **局部关节偏移（Local Joint Offset）** 属性的默认值，你可能无法看到任何运动。这是因为约束会放置对象上出现任何运动。缩小边界盒体的尺寸，你就能看到运动了。

在本例中，启用了AnimDynamics的 **调试（Debug）** 属性。你可以使用这些调试绘制来可视化 **边界盒体（Bounding Box）** 和 **局部关节偏移（Local Joint Offset）** 属性对网格体的影响。

> 动图已省略：anim dynamics animation blueprint node debug draw enabled

在本例中，设置了 **旋转约束（Rotation Constraints）** ，使鼓只能沿着设定的轴，在指定的范围内移动。沿 **Y** 轴应用的旋转约束由绿色角度覆层表示，对于防止网格体自我叠加非常有用。

![anim dynamincs animation blueprint node constraints example](../../../../../../../assets/images/32/320e72d0d257f95f77bec75b96a47ff5dd33b5c7fa4a7be737cee77346d51ac4.jpg)

有关使用AnimDynamics节点创建单个刚体物理的更多信息，请参阅[创建动态动画](../../../../../skeletal-mesh-animation-system/animation-workflow-guides-and-examples/creating-dynamic-animations/index.md)工作流程指南。

### 外部力量

你还可以在物理模拟运动上施加 **外部力（External Forces）**，对被模拟的对象进行加权，或者施加更多惯性来获得更大的反馈运动。默认情况下，你可以使用AnimGraph中的引脚来施加 **外部力（External Force）** 向量。

![anim dynamics external forces input pin property animation blueprint node](../../../../../../../assets/images/7a/7a02d676dbe0806b5fc972ecc902f49542b5e07586d2230bd4254696399096f9.jpg)

有关通过AnimDynamics节点使用 **外部力** 创建物理模拟的更多信息，请参阅[创建动态动画](../../../../../skeletal-mesh-animation-system/animation-workflow-guides-and-examples/creating-dynamic-animations/index.md)工作流程指南。

## 链条

你可以在AnimDynamics节点的 **细节** 面板中启用 **链条（Chain）** 属性，模拟链条状对象的运动和碰撞。

> 动图已省略：anim dynamics animation blueprint node chain demo

> [!NOTE]
> 相比于单体模拟，链条模拟需要的资源更多。因为在链条模拟中，链接约束现在需要解算，这需要更多迭代才能正确收敛。迭代次数也可以使用 **细节** 面板中的 **每次更新结算器迭代次数（Num Solver Iterations Pre Update）** 和 **更新后结算器迭代次数（Num Solver Iterations Post Update）** 属性按节点配置。

通过启用 **链（Chain）** 属性，并选择 **边界骨骼（Bound Bone）** 和 **链端（Chain End）** ，AnimDynamics将使用两者之间的骨骼生成链。**除了** **边界骨骼（Bound Bone）** 之外，链中的每块骨骼都将在其周围生成一个约束盒体，以模拟与链中其他骨骼的运动和碰撞。这些约束盒体需要手动调整才能实现良好的效果。

![anim dynamics animation blueprint chain settings details panel](../../../../../../../assets/images/ab/ab44b2e989c73e8f8cc8222fb3979704b51f4afc05dc8c3b7bbb0634ce27b464.png)

> [!WARNING]
> 重叠约束可能导致效果不理想，如骨骼乱舞和运动不受控。如果你遇到这类情况，请确保链约束未重叠。

## 碰撞模拟

你可以使用 **平面（Planer）** 和 **球体（Spherical）** 限制，使用AnimDyanmic节点模拟的物理结构来启用简单的碰撞模拟。

### 平面限制

借助平面限制，你可以设置物理模拟结构无法穿越的平面边界。你可以用这类平面约束来防止模拟的机构与角色[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)的其他部分或地面重叠。

![anim dynamics planer consrtaints demo](../../../../../../../assets/images/87/871be88236b5024337af356a08f1a112490384c1524f10ccabdcfc1736f2e00d.jpg)

在AnmDynamic的 **细节** 面板中，你可以通过 **使用平面限制（Use Planer Limits）** 属性启用平面限制。然后使用 **添加(+)** 创建 **索引**，以设置单独的平面限制来控制模拟结构的行为。借助每个索引，你可以将 **驱动骨骼（Driving Bone）** 设置为平面限制位置的参考点。然后，你可以使用 **平面变换（Plane Transform）** 属性设置平面限制的 **位置（Location）** 、 **旋转（Rotation）** 和 **缩放（Scale）** 属性，来建立模拟结构无法跨越的平面边界。

例如，将平面限制添加到角色的 **根骨骼** ，可以创建对象无法跨越的、代表地面的边界。

![anim dynamics planer constraint settings for floor boundary](../../../../../../../assets/images/c9/c9dc73f24aa4671ba93527c7dc1e4a80215702aaf0379d2e81f059909b888f71.png)

### 球体限制

借助球体限制，你可以创建球体边界来包围AnimDynamics物理模拟结构上的点，充当简单的碰撞预防。

![anim dynamics sphere constraints demo](../../../../../../../assets/images/74/74eb5d0233b95ca7482f6427d73ea5b895538b2aa328681d80acddb52fdfbdea.jpg)

在AnimDynamics的 **细节** 面板中，启用 **使用球体限制（Use Spherical Limits）** 属性后，你可以使用 **添加 (+)** 创建 **索引**，在其中设置球体限制。对于每个索引，你可以设置 **驱动骨骼（Driving Bone）** 充当球体位置的参考点，并通过 **球体局部偏移（Sphere Local Offset）** 属性 **偏移** 它在 **X** 、 **Y** 和 **Z** 轴上的位置。你还可以设置球体 **限制半径（Limit Radius）** ，确定球体大小，设置 **限制类型（Limit Type）**，并确定球体如何与[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)交互。

> 图片已省略：anim dynamics sphere constraints tail settings demo

将球体上的 **限制类型（Limit Type）** 设置为 **外部（Outer）** ，你可以使用球体限制，通过不允许物体穿过球体，防止结构碰撞。你还可以使用球体限制，通过将 **限制类型（Limit Type）** 设置为 **内部（Inner）** 来控制结构。

## 属性参考

> 图片已省略：anim dynamics animation blueprint node details panel

此处你可以参考AnimDynamics属性及其作用说明的列表。

| 属性 | 说明 |
| --- | --- |
| **实时预览（Preview Live）** | 启用后，将在视口中的网格体上绘制实时物理对象的预览。 |
| **显示线性限制（Show Linear Limits）** | 启用后，将在视口中的网格体上绘制 **线性限制（Linear Limits）** （棱柱形）预览。 |
| **显示角限制（Show Angular Limits）** | 启用后，将在视口中的网格体上绘制 **角限制（Angular Limit）** 范围的预览。 |
| **显示平面限制（Show Planer Limit）** | 启用后，将在视口中的网格体上绘制 **平面限制（Planer Limit）** 信息（实际平面、平面法线）的预览。 |
| **显示球体限制（Show Spherical Limit）** | 启用后，将在视口中的网格体上绘制 **球体限制（Spherical Limits）** 的预览。 |
| **显示碰撞球体（Show Collision Spheres）** | 如果启用了 **平面限制（Planer Limits）** 并且 **碰撞模式（Collision Mode）** 设置为 **自定义球体（Custom Sphere）** 、 **内部球体（Inner Sphere）** 或 **外部球体（Outer Sphere）** ，将在视口中的网格体上绘制代表碰撞球体的预览球体。 |
| **重设模拟（Reset Simulation）** | 重置此节点的模拟。 |
| **模拟空间** | 用于运行模拟的空间。可用选项如下所示： **组件（Component）** ：模拟原点将使用[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)组件的位置和方向计算。 **Actor** ： 模拟原点将使用包含[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)组件的[actor](../../../../../../understanding-the-basics/actors-and-geometry/index.md)的位置和方向来计算。 **世界（World）** ： 模拟原点将使用世界原点计算。 不建议使用带有传送角色的 **世界（World）** 模拟模式。 **相对根（Root Relative）** ： 将使用[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)的根骨骼的位置和方向计算模拟原点。 **相对骨骼（Bone Relative）** ： 将使用 **相对空间骨骼（Relative Space Bone）** 属性中指定骨骼的位置和方向计算模拟原点。 |
| **相对空间骨骼（Relative Space Bone）** | 当 **模拟空间（Simulation Space）** 设置为 **相对骨骼（Bone Relative）** 时，模拟会将角色[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)中选定的骨骼用作原点参考。 |
| **链（Chain）** | 启用后，节点将使用解算器模拟连接链。 |
| **边界骨骼（Bound Bone）** | 从角色[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)选择要附加物理主体的骨骼。如果启用 **链（Chain）** 属性，所选骨骼将成为定义链的顶部骨骼（首骨骼）。 |
| **链端（Chain End）** | 启用 **链（Chain）** 属性后，从角色[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)选择的骨骼将成为定义链的底部或端。禁用 **链（Chain）** 属性时，忽略此属性。 |
| **盒体范围（Box Extents）** | 设置盒体在 **X** 、 **Y** 和 **Z** 上的范围，用于物理模拟。**模拟空间（Simulation Space）** 上下文中的坐标，与 **局部关节偏移（Local Joint Offset）** 位置相关。 |
| **局部关节偏移（Local Joint Offset）** | 设置 **盒体范围（Box Extent）** 从最近关节到 **边界骨骼（Bounding Bone）** 的位置偏移。 |
| **角弹性约束** | 设置在启用 **角弹性（Angular Spring）** 属性时使用的弹性常量。值越高，弹性越强。 要查看效果，必须已定义 **角目标轴（Angular Target Axis）** 和 **角目标（Angular Target）** 属性。 |
| **使用重力覆盖（Use Gravity Override）** | 启用后，将使用 **重力覆盖（Gravity Override）** 属性值代替 **重力缩放（Gravity Scale）** 进行模拟。 |
| **重力覆盖（Gravity Override）** | 当启用 **使用重力覆盖（Use Gravity Override）** 时，设置向量值覆盖 **重力缩放（Gravity Scale）** 。 |
| **模拟空间中的重力覆盖（Gravity Override in Sim Space）** | 启用后，在模拟空间中定义 **重力覆盖（Gravity Override）** 。禁用后，在世界空间中定义重力覆盖（Gravity Override）。 |
| **重力缩放（Gravity Scale）** | 设置模拟中重力使用的比例。值为1是完全重力重量，而值大于1会增加重力产生的力。 |
| **线性弹性（Linear Spring）** | 启用后，主体会尝试将 **线性弹性约束（Linear Spring Constraint）** 属性值用作比例弹回其初始位置。 |
| **角弹性（Angular Spring）** | 启用后，主体会尝试将 **角弹性约束（Angular Spring Constraint）** 属性值用作比例，将自身与指定的角目标对齐。 |
| **线性弹性约束（Linear Spring Constraint）** | 设置计算线性弹性时要使用的弹性常量。值越高，弹性越强。 |
| **更新后数字解算器迭代** | 设置传递的关于 **线性（Linear）** 和 **角（Angular）** 限制的更新数量，可在细节（Details）面板的 **约束（Constraint）** 属性分段找到。**更新后（Post Update）** 表示设定的在解算器获取主体位置之后发生的更新传递数。 建议设置值应为设置的 **更新前解算器迭代数（Number Solver Iterations Pre Update）** 属性的四分之一左右。 |
| **进行求值（Do Eval）** | 启用后，节点将执行骨骼变换求值。你可以禁用此属性，以直观地看到默认动画状态，快速将物理模拟与默认动画状态进行比较。 |
| **更新前数字解算迭代** | 设置传递的关于 **线性（Linear）** 和 **角（Angular）** 限制的更新数量，可在细节（Details）面板的 **约束（Constraint）** 属性分段找到。**更新前（Pre Update）** 表示设定的在解算器获取主体位置之后发生的更新传递数。 建议设置的值应该是设置的 **NumSolverIterationsPostUpdate** 属性值的四倍左右。 |
| **线性阻尼覆盖** | 设置要在启用 **覆盖线性阻尼（Override Linear Damping）** 属性时使用的值。 默认值为0.7。值低于0.7不会产生影响。 |
| **角阻尼覆盖** | 设置要在启用 **覆盖角阻尼（Override Linear Damping）** 属性时使用的值。 默认值为0.7。值低于0.7不会产生影响。 |
| **角偏差覆盖** | 设置要在启用 **覆盖角偏差（Override Linear Bias）** 属性时使用的值。 角偏差会减少链力的扭转，并默认为保持链条稳定性的值。模拟时，单体角力可能会在网格体的位置出现延迟。如果遇到此问题，你可以将 **角偏差覆盖（Angular Bias Override）** 的值向1.0f调整，直到问题解决。 |
| **进行更新（Do Update）** | 启用后，节点将执行物理模拟更新。禁用时将显示基础动画姿势。此属性有助于切换节点的效果。 |
| **覆盖线性阻尼（Override Linear Damping）** | 启用后，**线性阻尼覆盖（Linear Damping Override）** 值将用于应用线性阻尼。 |
| **覆盖角偏差** | 启用后，**角偏差覆盖（Angular Bias Override）** 值将用于为该节点中的主体应用角偏差。 角偏差会减少链力的扭转，并默认为保持链条稳定性的值。使用单体系统时，有时角力看起来像在网格体的运动中延迟，如果是这种情况，请启用 **覆盖角偏差（Override Angular Bias）** ，并将 **角偏差覆盖（Angular Bias Override）** 值向1.0f调整，直到问题解决。 |
| **覆盖角阻尼（Override Angular Damping）** | 启用后，**角阻尼覆盖（Angular Damping Override）** 值将用于应用角阻尼。 |
| **组件线性加速度缩放（Component Linear Acc Scale）** | 使用非世界空间模拟时，此属性会控制将多少组件的世界空间加速度传递给局部空间模拟。可在 **X** 、 **Y** 和 **Z** 轴上使用向量值。 |
| **组件线性速度缩放（Component Linear Vel Scale）** | 当使用非世界空间模拟时，这将根据组件的世界空间速度对局部空间模拟中的主体施加阻力。可在 **X** 、 **Y** 和 **Z** 轴上使用向量值。 |
| **组件应用线性加速度限制（Component Applied Linear Acc Clamp）** | 使用非世界空间模拟时，此为从 **组件线性加速度缩放（Component Linear Acc Scale）** 和 **组件线性速度缩放（Component Linear Vel Scale）** 属性派生的对加速度的整体限制。 |
| **线性XLimit类型（Linear XLimit Type）** | 选择 **限制（Limit）** 可限制线性X轴运动。选择 **自由（Free）** 可禁用所有限制。 |
| **线性YLimit类型（Linear YLimit Type）** | 选择 **限制（Limit）** 可限制线性Y轴运动。选择 **自由（Free）** 可禁用所有限制。 |
| **线性ZLimit类型（Linear ZLimit Type）** | 选择 **限制（Limit）** 可限制线性Z轴运动。选择 **自由（Free）** 可禁用所有限制。 |
| **线性轴最小值（Linear Axes Min）** | 设置最小值，以允许沿 **X** 、 **Y** 和 **Z** 轴作线性移动。 要锁定特定轴上的线性运动，请在 **线性轴最小值（Linear Axes Min）** 和 **线性轴最大值（Linear Axis Max）** 属性中将所需轴上的值设置为0。 |
| **线性轴最大值（Linear Axes Max）** | 设置最大值以沿 **X** 、 **Y** 和 **Z** 轴作线性移动。 要锁定特定轴上的线性运动，请在 **线性轴最小值（Linear Axes Min）** 和 **线性轴最大值（Linear Axis Max）** 属性中将所需轴上的值设置为0。 |
| **角约束类型（Angular Constraint Types）** | 选择约束角运动时要使用的方法。**角（Angular）** 将根据 **角限制最小值（Angular Limits Min）** 、 **角限制最大值（Angular Limits Max）** 、 **角目标轴（Angular Target Axis）** 和 **角目标（Angular Target）** 属性中设置的参数限制运动。**椎体（Cone）** 将限制椎体内的运动，其原点从 **边界骨骼（Bound Bone）** 的关节向量化，角度在 **椎体角度（Cone Angle）** 属性中设置。 |
| **扭转轴（Twist Axis）** | 选择在约束角运动时将沿 **X** 、 **Y** 和 **Z** 中的哪个轴进行扭转。 |
| **椎体角度（Cone Angle）** | 设置当 **角约束类型（Angular Constraint Types）** 设置为 **椎体（Cone）** 时要使用的椎角。 |
| **角度限制最小值（Angular Limits Min）** | 设置 **X** **Y** 和 **Z** 每个轴上的最小角度限制，以在 **角约束类型（Angular Constraint Types）** 设置为角度时使用。 |
| **角度限制最大值（Angular Limits Max）** | 设置 **X** **Y** 和 **Z** 每个轴上的最大角度限制，以在 **角约束类型（Angular Constraint Types）** 设置为角度时使用。 |
| **角目标轴** | 设置 **X** 、 **Y** 和 **Z** 轴，角度将用于与 **角目标（Angular Target）** 对齐。通常，这是指向 **边界骨骼（Bound Bone）** 的轴。 这受角弹性约束（Angular Spring Constraints）的影响。 |
| **角目标** | 设置对齐 **角弹性约束（Angular Spring Constraint）** 的轴。考虑对齐时，值为0将禁用轴，值为1将禁用轴。 属性值通常设置为指向骨骼。例如，该属性可能设置为（1.0, 0.0, 0.0），但你可以选择其他值，以将弹簧对齐到不同方向。 |
| **外部力量（External Forces）** | 设置后，可以将外力施加于世界空间中指定的模拟中的所有主体。默认情况下，此属性显示为AnimGraph中节点上的引脚。另请参阅本页中的[外部力量分段](#%E5%A4%96%E9%83%A8%E5%8A%9B%E9%87%8F)。 |
| **碰撞类型** | 设置在启用 **平面限制（Planer Limits）** 时使用的分辨率方法。选项包括： **CoM（质心）** ：仅限制穿过平面的质心。 **自定义球体（Custom Sphere）** ：使用指定的球体半径与平面碰撞。 **内部球体（Inner Sphere）** ：使用完全匹配主体范围的最大球体与平面碰撞。 **外部球体（Outer Sphere）** ：使用完全包含主体范围的最小球体与平面碰撞。 |
| **球体碰撞半径（Sphere Collision Radius）** | 当 **碰撞类型（Collision Type）** 设置为 **自定义球体（Custom Sphere）** 时，设置半径以计算球体。 |
| **使用球体限制（Use Spherical Limits）** | 启用后，将对球体限制进行求值。 |
| **球体限制** | 启用 **使用球体限制（Use Spherical Limits）** 后，你可以向数组添加球体限制。添加元素后，它的属性包括： **驱动骨骼（Driving Bone）** ：附加球体的骨骼。 **球体局部偏移（Sphere Local Offset）** ：球体的局部偏移，如果没有设置驱动骨骼，则在节点空间中，否则在骨骼空间中。 **限制半径（Limit Radius）** ：设置球体的半径。 **限制类型（Limit Type）** ：是否将主体锁定在球体内（**内部**）或外（**外部**）。 |
| **使用平面限制（Use Planer Limits）** | 启用后，将对平面限制求值。 |
| **平面限制** | 启用 **使用平面限制（Use Planer Limits）** 后，你可以向数组添加平面限制。添加元素后，它的属性包括： **驱动骨骼（Driving Bone）** ：当使用驱动骨骼时，平面变换将相对于骨骼变换。 **平面变换（Planer Transform）** ：设置平面的变换。如果没有指定 **驱动骨骼（Driving Bone）** ，则它位于组件空间中，如果存在驱动骨骼，则位于骨骼空间中。设置平面 **位置（location）** 、 **旋转（rotation）** 和 **缩放（scale）** 属性的 **X** 、 **Y** 和 **Z** 值。 |
| **启用风（Enable Wind）** | 启用后，此模拟中将考虑风对主体的影响。 |
| **风级（Wind Scale）** | 设置级以在解算器中应用计算的风速。 |


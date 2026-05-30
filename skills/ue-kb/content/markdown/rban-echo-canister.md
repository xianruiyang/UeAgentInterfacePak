# RBAN Echo Canister 教程

# RBAN Echo Canister 教程

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Jd0J/unreal-engine-rban-echo-canister-tutorial

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5627 字符。

## 摘要

本基础教程将演示如何使用 RBAN（刚体动画节点）为 Echo 的皮带罐创建简单的铰链接头和碰撞设置。

## 中文整理

### 概览

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-01.jpg)

### 工作流程注意事项

使用物理资产和 RBAN 时有一个好处的工作流程是将碰撞设置分解为更小、更精细的物理资产。这样做的好处是： 现有的 Echo 资源（位于内容示例中）刚体资源使用此方法，这使得编辑、调试和故障排除变得更加容易。在设置角色及其刚性碰撞时应该考虑这一点。

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-02.jpg)

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-03.jpg)

### 罐式 RBAN 启动

我们将演示如何使用这种独立的PhysicsAsset方法来设置Echo Canister RBAN。因为，我们将手动构建这些碰撞体，首先“**显示所有骨骼**”，以便我们可以看到 Echo 的关节。确保从“角色下拉”菜单中也选择了**骨骼 - 所有层次结构**，以更好地可视化骨骼层次结构。

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-04.jpg)

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-05.jpg)

罐式装置设置基于两个关节，一个“主”关节和一个“旋转”关节。我们将首先添加运动学“home”关节碰撞对象。

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-06.jpg)

选择关节并右键单击它以 **添加形状 – 添加胶囊**

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-07.jpg)

创建一个胶囊。我们将使用它作为静态几何体来铰接旋转罐对象。我们需要调整大小并设置一些参数。

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-08.jpg)

注意：Chaos RBAN 中的冲突数量没有限制。但是，如果您想知道实际的计算结果：胶囊通常被认为是最好的碰撞几何体。由于该运动对象在视觉上对我们的需求并不重要，因此我们可以在视觉上缩小其体积，以更好地集中于我们将对其进行约束的罐体对象的运动。使用“视口”或“详细信息”面板中的交互式操纵器将“半径”和“长度”值缩放为 0.5 或类似值，这样就不会在视觉上损害我们接下来要创建的容器的视图。

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-09.jpg)

![教程图片](assets/unreal-engine-rban-echo-canister-tutorial/image-10.jpg)

确保在详细信息面板中打开“质量”并将其设置为 100 之类的大值。还要确保该胶囊设置为“运动学”。现在我们将创建实际的罐体来表示其体积。右键单击第二个“旋转”关节并创建另一个胶囊（**添加形状 - 添加胶囊**）我们需要缩小该胶囊以大致代表罐的大小。使用代表罐的胶囊的交互式操纵器或详细信息面板属性。对于这个胶囊，我们需要将物理类型设置为模拟，同时打开并将质量设置为 100 的值，为角度阻尼添加 30 的值，以帮助减慢罐体的一些运动。

### 约束条件

为了创建铰链，我们需要在模拟胶囊和运动胶囊之间添加约束。在骨架树中，单击齿轮按钮打开下拉菜单并选择 **显示约束**。您还可以选择 **隐藏所有骨骼** 以减少骨架树中的混乱。注意：我们将在本练习中演示一种约束方法。有关两种约束方法，请参阅 **Echo Ponytail RBAN 教程**。右键单击运动学（父级）**R_Canister_A_Joint1_Jnt** 并下拉至 **约束**，然后选择 **R_Canister_A_Joint2_Jnt**（模拟）子关节。创建两个胶囊之间的约束。如果我们现在模拟，罐子会掉落并旋转到 Echo 的体内。再次单击模拟按钮退出模拟模式。选择约束并将详细信息面板中的角度限制设置为 **锁定**（对于 **Swing 1 运动**），以及 **Limited**（对于 **Swing 2** 和 **扭转运动**）。确保 Swing 2 Limit 和 Twist Limit 值均设置为 20。 **CTRL** 和 **ALT** 键可用于在编辑器中调整关节的静止角度偏移（每个颜色相似的角度 - 红色、蓝色、绿色之间的差异）。现在按“模拟”。

### 碰撞

我们已经很好地设置了铰链，但我们仍然需要添加碰撞体，以帮助将动画添加到 Echo 角色时可能出现的剪辑。显示骨骼树中的骨骼。为此，我们只需要三个身体：**骨盆**、**腿（thigh_r）**、**手臂（lowerarm_r）**，没有理由做更多。这隔离了为物理资源计算的碰撞，并使设置变得高效，正如练习开始时提到的那样。将这三个实体设置为运动学。调整这些碰撞体的大小和方向，以大致匹配 Echo 的身体体积。将物理资源保存为 PA_Echo_Canister，或者您可以在下一步中参考的名称。

### 刚体节点

最后一步是将刚体节点添加到动画图表中。从内容浏览器中选择 Echo 的动画蓝图或创建一个新的并打开。切换到动画图表部分。在动画图表中右键单击并输入rigid，即可从菜单中轻松选择“RigidBody Skeletal Control Node”（刚体骨骼控制节点）。创建刚体节点。将其连接到动画图表中的输出姿势。单击图表中的 RigidBody 节点，然后在详细信息面板中将您创建并命名为 PA_Echo_Canister 的物理资源添加到覆盖物理资源插槽中。以下是一些可根据需要进行调整的细节。将 Z 轴中的“世界重力”设置为 -980，将所有值的“分量线性加速比例”设置为 0.4，将所有值的“分量线性速度比例”设置为 0.2。还将所有值的 **Component Applied Linear Acc Clamp** 设置为 4000。将模拟空间更改为 **Base Bone Space。** 注意：有关这些参数的更多信息，请参阅刚性模拟参数。最后，从 Echo 的动画文件夹中抓取一些动画来测试运动。您应该有一个带有铰链约束的 RBAN 容器，如下所示。


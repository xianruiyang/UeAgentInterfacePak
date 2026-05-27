---
title: "物理设置设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physics-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "物理设置设置"]
---

# 物理设置设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 物理设置设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physics-settings-in-the-unreal-engine-project-settings

## 物理

### 复制

这是复制模拟物理（刚体）的错误收集数据。

| **分段** | **说明** |
| --- | --- |
| **Ping外插值（Ping Extrapolation）** | 0到1之间的值，表示在多大程度使用基于速度和ping的校正。 |
| **Ping限制（Ping Limit）** | 就外插值而言，ping将限制为该值。 |
| **每个线性差异的误差（Error Per Linear Difference）** | 每厘米的误差。 |
| **每个角度差异的误差（Error Per Angular Difference）** | 每度的误差。 |
| **最大恢复状态误差（Max Restored State Error）** | 要让状态被视为"解决"所允许的最大误差。 |
| **最大线性硬对齐距离（Max Linear Hard Snap Distance）** | 最大线性硬对齐距离。 该值表示将用于推断刚体位置的最大欧式线性距离。距离超过该值时，刚体将"硬对齐"到正确位置。 |
| **位置插值（Position Lerp）** | 多大程度直接插值（线性插值）到正确位置。 该值通常应该非常低，甚至可能为0。 如果值更高，会提高精度以及抖动度。 |
| **角度插值（Angle Lerp）** | 多大程度直接插值到正确角度。 |
| **线性速度系数（Linear Velocity Coefficient）** | 这是微分方程中的系数"k"：`dx/dt = k (x_target(t) - x(t))` ，用于更新复制步骤中的速度。 |
| **角速度系数（Angular Velocity Coefficient）** | 这是 `LinearVelocityCoefficient` 的角度模拟。 |
| **误差累积秒数（Error Accumulation Seconds）** | 在硬对齐之前保持为启发式不可解决状态的秒数。 |
| **误差累积距离平方（Error Accumulation Distance Sq）** | 如果形体在前一帧中向解决状态移动的程度小于此数量的平方根，则误差可能向硬对齐累积。 |
| **误差累积相似度（Error Accumulation Similarity）** | 如果投影到当前误差的之前误差大于该值（表示状态之间的"相似度"），则误差可能向硬对齐累积。 |

### 模拟

| **分段** | **说明** |
| --- | --- |
| **默认自由度（Default Degrees of Freedom）** | 适合用于约束世界中的所有对象，例如，在你使用3D环境制作2D游戏时。 你可以选择以下选项： **完全3D（Full 3D）** **YZ平面（YZ Plane）** **XZ平面（XZ Plane）** **XY平面（XY Plane）** |
| **禁用CCD（Disable CCD）** | 如果启用，将忽略CCD（持续碰撞检测）。 这是从不使用CCD时的优化，可提高性能。 |
| **重置后模拟动画物理（Simulate Anim Physics After Reset）** | 定义是否在重置动画物理节点的更新函数中模拟这些节点。 |
| **启用2DPhysics（Enable 2DPhysics）** | 定义是否可以使用2D物理（Box2d）。 |
| **反弹阈值速度（Bounce Threshold Velocity）** | 使对象反弹所需的最低相对速度。 模拟稳定性的典型值大约为 `0.2 * gravity` 。 |
| **摩擦合并模式（Friction Combine Mode）** | 控制如何计算多个材质的摩擦。 你可以选择以下选项： **平均值（Average）** **最小值（Min）** **乘（Multiply）** **最大值（Max）** |
| **恢复合并模式（Restitution Combine Mode）** | 恢复合并方式，控制如何计算多个材质的恢复。 你可以选择以下选项： **平均值（Average）** **最小值（Min）** **乘（Multiply）** **最大值（Max）** |
| **最大角速度（Max Angular Velocity）** | 模拟对象可以实现的最大角速度。 |
| **最大穿透速度（Max Depenetration Velocity）** | 可用于穿透模拟物理对象的最大速度。 这是Chaos物理系统在检测到碰撞时将校正对象穿透（重叠）的最大速度：如果检测到碰撞并且有重叠，Chaos会将碰撞对象的位置校正到它与之碰撞的对象之外。 值为0表示没有设置最大值。 大型穿透可能导致不稳定，因为需要施加很大的力才能正确穿透对象。将 **最大穿透速度（Maximum Depenetration Velocity）** 设置为非0值时，速度绝不会超过该数字，这样会更稳定，但代价是对象仍在穿透。 |
| **接触偏移乘数（Contact Offset Multiplier）** | 创建物理形状时，我们将其边界体积的最小值乘以此乘数。 数字越大，接触点就越早生成，这样会更稳定，但性能会下降。 |
| **最小接触偏移（Min Contact Offset）** | 最小接触偏移。 |
| **最大接触偏移（Max Contact Offset）** | 最大接触偏移。 |
| **在专用服务器上模拟骨骼网格体（Simulate Skeletal Mesh on Dedicated Server）** | 如果启用，则在专用服务器上模拟此组件的物理。 在使用专用服务器模拟物理并进行复制时，应如此设置。 |
| **默认形状复杂度（Default Shape Complexity）** | 确定默认物理形状复杂度。 你可以选择以下选项： **项目默认值（Project Default）** **简单和复杂（Simple And Complex）** **将简单碰撞形状用作复杂形状（Use Simple Collision As Complex）** **将复杂碰撞形状用作简单形状（Use Complex Collision As Simple）** |
| **启用形状共享（Enable Shape Sharing）** | 启用静态刚性Actor的同步和异步场景之间的形状共享。 |
| **启用PCM（Enable PCM）** | 启用持久接触流形。 这将生成更少的接触点，但准确性更高。 降低堆叠稳定性，但有助于节能。 |
| **启用稳定性（Enable Stabilization）** | 为缓慢移动的形体启用接触稳定性。 这有助于提高堆叠稳定性。 |
| **警告缺失锁定（Warn Missing Locks）** | 定义是否在错误使用物理锁定时发出警告。 不推荐将此项关闭，只有非常高级的用户才应考虑关闭。 |

### 优化

| **分段** | **说明** |
| --- | --- |
| **抑制脸部重新映射表（Suppress Face Remap Table）** | 如果启用，不会生成内部PhysX脸部到UE脸部映射。 这是内存优化，仅当你不依赖场景查询返回的脸部索引时可用。 |
| **支持击中结果中的UV（Support UV from Hit Results）** | 如果启用，则存储额外信息以允许FindCollisionUV使用FindCollisionUV工具从线路追踪击中结果派生UV。 |
| **禁用活动Actor（Disable Active Actors）** | 如果启用，PhysX将不会使用模拟期间移动过的形体更新虚幻引擎。 仅当你没有PhysX模拟，或者要通过轮询PhysX手动更新虚幻数据时，才应使用此项。 |
| **禁用运动学静态对（Disable Kinematic Static Pairs）** | 定义是否禁用KS对生成。 启用此项将使动态和静态之间的切换对于Actor更慢，但会提早拒绝这些对，加速接触生成。 |
| **禁用运动学运态对（Disable Kinematic Kinematic Pairs）** | 定义是否禁用运动学运态对生成。 启用此项将加速接触生成，但在使用APEX破坏时必须启用。 |

### 帧率

| **分段** | **说明** |
| --- | --- |
| **动画物理最短增量时间（Anim Physics Min Delta Time）** | 最短增量时间，低于该时间时不会模拟动画动态和刚体节点。 |
| **最短物理增量时间（Min Physics Delta Time）** | 如果增量时间低于该值，物理模拟将不会运行。 |
| **最长物理增量时间（Max Physics Delta Time）** | 这是模拟可以执行的最大时间步进。 如果这小于引擎的更新，物理将人为缓慢地移动，以便提高稳定性。 |
| **分步（Substepping）** | 定义是否对物理模拟分步。 此功能仍为试验性。特定功能可能无法正确运行。 |
| **异步分步（Substepping Async）** | 定义是否对异步物理模拟进行分步。 此功能仍为试验性。特定功能可能无法正确运行。 |
| **异步更新物理（Tick Physics Async）** | 定义是否在异步线程上更新物理模拟。 此功能仍为试验性。特定功能可能无法正确运行。 |
| **异步固定时间步进大小（Async Fixed Time Step Size）** | 如果使用异步，则为更新的时间步进大小。 此功能仍为试验性。特定功能可能无法正确运行。 |
| **最长子步进增量时间（Max Substep Delta Time）** | 单个模拟子步进的最长增量时间（以秒为单位）。 |
| **最大子步进数（Max Substeps）** | 物理模拟的子步进的最大数量。 |
| **同步场景平滑因子（Sync Scene Smoothing Factor）** | 同步场景的物理增量时间平滑因子。 |
| **初始平均帧率（Initial Average Frame Rate）** | 物理增量时间初始平均值。 |

### Chaos物理系统

| **分段** | **说明** |
| --- | --- |
| **击中事件的最小增量速度（Min Delta Velocity for Hit Events）** | 要使Chaos发送击中事件，碰撞对象上所需的最小速度增量。 |
| **默认线程模型（Default Threading Model）** | 要用于模块初始化的默认线程模型。 可以在运行时使用 `p.Chaos.ThreadingModel` 切换。 你可以选择以下选项： **任务图表（Task Graph）** **单个线程（Single Thread）** |
| **专用线程更新模式（Dedicated Thread Tick Mode）** | 使用专用线程运行时的帧率/时间步进更新模式。 你可以选择以下选项： **固定（Fixed）** **可变（Variable）** **可变限制（Variable Capped）** **带目标的可变限制（Variable Capped with Target）** |
| **专用线程缓冲模式（Dedicated Thread Buffer Mode）** | 使用专用线程运行时要使用的缓冲模式。 你可以选择以下选项： **两倍（Double）** **三倍（Triple）** |
| **迭代数（Iterations）** | 约束解算器步骤期间要运行的迭代次数。 |
| **碰撞对迭代数（Collisions Pair Iterations）** | 在解算器迭代期间，虚幻引擎会依次解算每个约束。 对于每个约束，我们会将解算步骤连续运行 `CollisionPairIterations` 次。 |
| **推出迭代数（Push Out Iterations）** | 约束修复步骤期间要运行的迭代次数。 这将应用解算后校正，可解决主解算器迭代期间留下的错误。 |
| **碰撞推出对迭代数（Collision Push Out Pair Iterations）** | 在推出迭代期间，虚幻引擎会依次推出每个约束。 对于每个约束，我们会将推出步骤连续运行CollisionPairIterations次。 |
| **碰撞边缘部分（Collision Margin Fraction）** | 碰撞边缘，作为一些盒体和凸包形状使用的大小的一部分，以改进碰撞检测结果。 支持边缘的形状的核心几何体按边缘缩减大小，然后在碰撞检测期间会将边缘添加回来。 最终结果是相同大小，但带圆角的形状。 |
| **碰撞边缘最大值（Collision Margin Max）** | 将从盒体和凸包形状减去的碰撞边缘的上限。 请参阅 `CollisionMarginFraction` 。 |
| **碰撞剔除距离（Collision Cull Distance）** | 在碰撞检测期间，如果两个形状至少有这么远，虚幻引擎不会在碰撞检测步骤期间计算其最接近的功能。 |
| **碰撞最大推出速度（Collision Max Push Out Velocity）** | 两个形体在开始帧相互穿透时可以从彼此提取的最大速度。 发生此情况的可能原因是，它们以彼此叠加的方式生成，或者解算器未能完全解决最后一帧的碰撞。 值为零时，表示"没有限制"。 非零值可用于在形体开始深度穿透时防止爆炸式行为。 使用此方法的替代方案是增加速度迭代次数，这样做成本更高，但可确保形体在单个帧中穿透（缩减/删除其穿透）而不发生爆炸式行为。 |
| **关节对迭代数（Joint Pair Iterations）** | 约束解算器步骤期间要对每个约束运行的迭代次数。 |
| **关节推出对迭代数（Joint Push Out Pair Iterations）** | 每个关节的约束修复步骤期间要运行的迭代次数。 这将应用解算后校正，可解决主解算器迭代期间留下的错误。 |
| **群集连接因子（Cluster Connection Factor）** | 群集连接因子。 |
| **群集并集连接类型（Cluster Union Connection Type）** | 群集并集连接类型。 你可以选择以下选项： **点隐式（Point Implicit）** **德洛内三角剖分（Delaunay Triangulation）** **最低跨越子集德洛内三角剖分（Minimal Spanning Subset Delaunay Triangulation）** **使用最低德洛内增强的点隐式（Point Implicit Augmented with Minimal Delaunay）** **无（None）** |
| **生成碰撞数据（Generate Collision Data）** | 定义是否生成碰撞数据。 |
| **碰撞筛选器启用（Collision Filter Enabled）** | 定义是否启用碰撞筛选器。 |
| **最小质量阈值（Min Mass Threshold）** | 结果的最小质量阈值（与粒子1质量和粒子2质量中的最小值比较）。 |
| **最小速度阈值（Min Speed Threshold）** | 结果的最小速度阈值（与粒子1速度和粒子2速度中的最小值比较）。 |
| **最小脉冲阈值（Min Impulse Threshold）** | 结果的最小脉冲阈值。 |
| **生成破碎数据（Generate Break Data）** | 定义是否生成破碎数据。 |
| **破碎筛选器启用（Breaking Filter Enabled）** | 定义是否应启用破碎筛选器。 |
| **最小质量阈值（Min Mass Threshold）** | 结果的最小质量阈值（与粒子1质量和粒子2质量中的最小值比较）。 |
| **最小速度阈值（Min Speed Threshold）** | 结果的最小速度阈值（与粒子1速度和粒子2速度中的最小值比较）。 |
| **最小体积阈值（Min Volume Threshold）** | 最小体积。 |
| **生成拖尾数据（Generate Trailing Data）** | 定义是否生成拖尾数据。 |
| **拖尾筛选器启用（Trailing Filter Enabled）** | 定义是否应启用拖尾筛选器。 |
| **生成接触图（Generate Contact Graph）** | 定义是否生成接触图。 |

### 常量

| **分段** | **说明** |
| --- | --- |
| **默认重力（Default Gravity Z）** | 默认重力。 |
| **默认终端速度（Default Terminal Velocity）** | 物理体积的默认终端速度。 |
| **默认流体摩擦（Default Fluid Friction）** | 物理体积的默认流体摩擦。 |
| **模拟暂存内存大小（Simulate Scratch Memory Size）** | 要为PhysX simulate()保留的内存数量，这是每个pxscene的设置，并将向上舍入为下一个16K边界。 |
| **布偶聚合阈值（Ragdoll Aggregate Threshold）** | 布偶形体的阈值，高于该值时，它们将先添加到聚合体，然后再添加到场景。 |
| **三角形网格体三角形最小面积阈值（Triangle Mesh Triangle Min Area Threshold）** | 三角形网格体（BSP）中面积小于或等于该值的三角形将从物理碰撞数据中删除。 设置为小于0时，该选项将禁用。 |

### 物理表面

| **分段** | **说明** |
| --- | --- |
| **物理表面（Physical Surface）** | 你的项目最多可以有62个自定义物理表面类型。 命名每种类型后，它们将显示为物理材质中的表面类型。 |

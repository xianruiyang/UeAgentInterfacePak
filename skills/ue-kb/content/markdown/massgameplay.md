# MassGameplay概览

---
title: "MassGameplay概览"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-mass-gameplay-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "MassEntity", "MassGameplay概览"]
---

# MassGameplay概览

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / MassEntity / MassGameplay概览

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-mass-gameplay-in-unreal-engine

## 概览

**Mass Entity** 是虚幻引擎中的一个用于面向数据运算的框架。该框架被分为多个插件，各自负责该系统中的特定功能。

**Mass Gameplay** 插件直接派生自Mass Entity插件，其包含用于世界内表示、生成、细节层级（LOD）机制、复制和 **状态树（StateTree）** 的功能。

该文档将会介绍MassGameplay插件中可用的子系统。通过阅读[MassEntity概览](../overview-of-mass-entity/index.md)可以详细了解MassEntity。

## 子系统

### Mass Representation

**Mass Representation** 子系统负责管理Mass Entity的各种视觉表现部分。

对于每个显示LOD数值，子系统都会选择以下四种显示类型之一：

- 高分辨率Actor
- 低分辨率Actor
- 实例化静态网格体 (ISM)
- 不显示

ISM是显示Actor成本最低的一种方法，并且Actor还可以移动并且使用顶点动画。要详细了解如何为ISM Actor制作动画，你可以从虚幻引擎商城下载[城市示例](https://www.fab.com/listings/4898e707-7855-404b-af0e-a505ee690e68)。

> [!NOTE]
> MassGameplay的实例化静态网格体动画目前仍然是实验阶段，不保证在全部使用场景下都可用。

子系统会处理每个显示类型之间的过渡，它直接处理MassActorSpawner子系统和MassLOD子系统。而且，子系统可以自动回收并收集生成的Actor。

### Mass Spawner

**Mass Spawner** 子系统基于MassSpawner和程序化调用来生成并管理Entity。该子系统拥有一个 **Mass Entity模板注册表** 实例，用于保管可用的Entity模板的相关信息。

要开始使用这个子系统，要创建一个MassSpawner Actor并将其放入关卡中。你可以通过添加 **Mass Entity定义资产（Mass Entity Definition Asset）** 来指定要生成Actor的类型，添加 **Mass Entity分布实例生成器（Mass Entity Distribution Instance Generator）** 可用指定生成Actor的位置。

![undefined](../../../../../assets/images/c6/c687ebadbf992e7d070a580d9140f407a5606684d5bf1ddfb23040586dec6686.jpg)

### Mass LOD

**Mass LOD** 子系统计算每个Mass Entity需要的细节层级（LOD）。

该系统会输出四种LOD数值：高、中、低和关。对于每个LOD等级，你可以配置其对应的显示距离以及Entity的最大数量。

由三个系统会使用该子系统：

- Mass (Representation/Visualization) LOD
- MassSimulationLOD
- MassReplicationLOD

MassLOD 也可以计算一个LOD权重浮点值，范围在0.0f (高) 到3.0f (关) 之间。

#### Mass (Representation/Visualization) LOD

**Mass (Representation/Visualization) LOD** 专门设计来处理视觉LOD。它不仅根据距离计算LOD，还会判断物体是否可视。你也可以提供不同的距离来确定物体是否位于摄像机的视锥中。

该系统会根据物体是根据距离剔除、根据摄像机视锥剔除还是根据可视性剔除将其分为不同块。以下图表展示了不同的组：

![Entities are culled based on distance and camera frustum](../../../../../assets/images/8d/8db2babe867f890a90caa152e3de715d3013c0fcd96bb5c573d3c7d03daafda1.jpg)

#### Mass Simulation LOD

**Mass Simulation LOD** 用于加载平衡所有的Entity计算。该系统会将有着同样LOD的物体归为一组，这样方便在检索中进行筛选。它还提供了用变量为全部计算更新频率的选项。

#### Mass Replication LOD

**Mass LOD Replication** 使用LOD框架来了解每个Entity的复制相关性。与Mass (Representation/Visualization) LOD和Mass Simulation LOD不同，该系统为针对每个连接的客户端（查看者）计算一个LOD。该系统可以帮助优化网络带宽。

### Mass Replication (Experimental)

**Mass Replication** 子系统以客户端-服务器的形式在网络上复制Entity。它从服务器到客户端进行单项复制。

该子系统处理相关性，并通过Mass Replication LOD系统更新Entity的频率，从而限制带宽使用。

Mass Replication在虚幻引擎5.1中属于试验性功能。该系统需要C++实现才能复制自定义数值。

### Mass StateTree

**Mass StateTree** 子系统用于将状态树系统整合到Mass Entity。通过它可用为每个Entity配置状态树，并且根据其它Mass系统传来的信息更新每个Entity的状态树。

状态树逻辑仅用于为Entity配置或者设置数据，从而使正确的Processor针对特定的行为运行。

### Mass Signals

**Mass Signal** 子系统用于发送命名的信号，从而告诉Entity它有任务需要执行。该子系统目前在Mass StateTree中使用，用于将其唤醒使其处理任务。

信号类似于一个没有负载的事件，发送至Entity。由于Mass框架大部分重点在拉取模式，该子系统在需要频繁更新物体的时候非常有用。

### Mass Movement

**Mass Movement** 子系统为Mass个体定义了一个简单的移动模型。Fragment和Processor设置好，使得其它Trait可用直接修改速度或者力。这些数值会组合成一个最终的移动数值供Mass个体使用。

举例而言，让个体移动时，系统会设置初始的力，然后避障可以让它在移动时避免碰撞物体。

### Mass SmartObject

**Mass SmartObject** 子系统用于将SmartObject系统与Mass Entity整合。它会提供所需的Trait、Fragment，和Processor来执行SmartObject检索并在MassEntity显示的个体上执行简单的行为。


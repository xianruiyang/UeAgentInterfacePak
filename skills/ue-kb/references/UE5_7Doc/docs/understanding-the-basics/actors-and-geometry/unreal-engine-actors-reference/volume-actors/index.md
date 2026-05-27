---
title: "体积Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/volume-actors-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "体积Actor"]
---

# 体积Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 体积Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/volume-actors-in-unreal-engine

**体积（Volumes）** 是一种三维 **Actor** ，用于调整在关卡中指定区域的行为和特征。

体积是辅助型Actor，通常用于检测特定Actor类型是否进入了指定区域，并触发效果作为响应。体积有时自带一些效果（通过代码或蓝图提供）。

你可以使用体积实现诸如以下效果和行为：

- 对体积内的玩家或其他Actor造成伤害。
- 作为碰撞表面，阻止特定Actor进入体积。
- 当Actor进入体积时，对环境做出某种改变（例如，打开门）。
- 更改关卡中的照明或可视性。

## 放置体积

将体积放入关卡的方式与放置其他Actor的方式相同：

1. 在 **主工具栏（Main Toolbar）** 中，点击 **创建（Create）** 按钮。

   ![主工具栏中的创建按钮](../../../../../assets/images/5c/5c3978b68a36ca31576eddc72e49f984405c7766500edda0ac5f217fe8a07e5e.png)
2. 选择 **体积（Volumes）** 类别，然后将你要放置的体积拖动到关卡视口（Level Viewport）。

有关更多信息，请参阅[放置Actor](../../placing-actors/index.md)。

将体积放入关卡后，你可以调整其大小或位置。有关更多信息，请参阅[变换Actor](../../transforming-actors/index.md)。

## 体积的视觉表示

将体积在放入关卡时，没有默认视觉表示。换言之，体积Actor在运行时（游戏运行之时）将完全不可见。如果你想让玩家知道体积在那里，必须给它添加视觉表示。

例如， **施加伤害体积（Pain-Causing Volume）** 会对体积内的东西造成伤害。你可以用它来标记你想让玩家避开的区域，比如毒物、熔岩或其他环境危害。

如果你将施加伤害体积（Pain-Causing Volume）放入关卡，但没有为其添加视觉表示，玩家在运行时不会看到它：

|  |  |
| --- | --- |
| 编辑器内 | 游戏内/PIE |

在这种情况下，玩家将不知道需要避开体积，也不明白为何他们进入体积时会受到伤害。

你应该给予玩家提示，说明施加伤害体积（Pain Causing Volume）的存在：

|  |  |
| --- | --- |
| 编辑器内 | 游戏内/PIE |

在上述示例中，火焰粒子效果提供了该区域为何危险的视觉说明，而施加伤害体积（Pain Causing Volume）则能配合游戏逻辑以及燃烧效果，让玩家在接近火焰时降低生命值。

> [!TIP]
> 你可以将施加伤害体积（Pain Causing Volume）和火焰粒子效果合并到单个Actor中，以便轻松移动和复制。

## 虚幻引擎中的体积类型

本小节将介绍虚幻引擎中常用的一些体积类型。请注意，这个列表并不详尽。如需详细了解专门的体积，请参阅相应领域的文档。

### 碰撞和重叠类体积

#### 阻挡体积

你可以在静态网格体上使用 **阻挡体积（Blocking Volumes）** 替代碰撞表面，比如建筑物墙壁。这可以增强场景的可预测性，因为物理对象不会与地面和墙壁上的凸起细节相互作用。它还能降低物理模拟开销，提高性能。

有关更多信息，请参阅[碰撞](../../../../gameplay-systems/physics/collision/index.md)文档。

#### 摄像机阻挡体积

**摄像机阻挡体积（Camera Blocking Volumes）** 采用了预置的碰撞设置，可阻挡[摄像机](../camera-actors/index.md)，并忽略所有其他内容。它们用于定义不可见边界，可以将摄像机限制在合理范围内。

例如，在第三人称游戏中，游玩区域的墙壁上可能有多叶藤蔓等装饰物。在这种情况下，你可以贴着墙壁放置一个很薄的摄像机阻挡体积（Camera Blocking Volume），确保摄像机不会撞进藤蔓或伸到叶片后面，使它流畅运动，确保游戏画面不会被干扰。

#### 销毁Z体积

**销毁Z体积（Kill Z Volume）** 旨在防止某些游戏的对象越界，例如，避免在平台游戏中从悬崖上跌落或掉进深坑，或者在科幻场景中不穿宇航服就离开飞船。

销毁Z体积（Kill Z Volume）会在有Actor进入时调用 `FellOutOfWorld` 函数。默认情况下，Actor将经历一个快速清理程序，然后自毁。你也可以根据游戏需求，为你的Actor类型覆盖此行为。例如，如果钥匙或其他物品掉进了熔岩坑，而玩家要必须收集到它才能继续游戏，那么你的游戏不妨将该物品传送回玩家可以到达的区域，而不是将其销毁，或者至少通知玩家该物品遗失并重新加载上一个存档点，而非任由游戏停留在无法获胜的状态。

#### 施加伤害体积

如上所述， **施加伤害体积（Pain-Causing Volume）** 具有一组可配置属性，可以用来指定：

- 造成的伤害类型和程度
- 多久会对体积内的东西施加一次伤害
- 是否会造成初始伤害

在体积的 **细节（Details）** 面板中配置这些属性。

#### 物理体积

如果你要配置能够影响角色和其他物理对象的物理设置，请使用 **物理体积（Physics Volumes）** 。

物理体积的一个常见用途是创建玩家需要游过的水环境。物理体积的效果可见，若配以适当的视觉表示，可便于玩家理解。

角色移动组件（Character Movement Component）类将使用当前字段来调整其所属 `Character` 在环境中的移动方式。如果你的游戏采用了自定义物理，请从 `APhysicsVolume` 派生你自己的子类。

#### 触发器体积

**触发器体积（Trigger Volumes）** 可以在玩家或其他对象进入或离开它时引发事件。你可以在[关卡蓝图](../../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/level-blueprint/index.md)中使用它们，无需额外蓝图即可测试事件和Gameplay场景或功能。

例如，你可以将触发器体积放入关卡，然后在你的关卡蓝图中为体积创建重叠事件，以此播放声音、开门或开始放映过场动画。

> [!NOTE]
> 记得检查碰撞设置，以确保触发器使用重叠碰撞响应设置对预期Actor做出反应。

### 图形和音频体积

#### 音频体积

**音频体积（Audio Volumes）** 将为其覆盖的区域添加声音。你可以使用两种音频体积：

- 音频体积（旧版方法）
- [音频Gameplay体积](../../../../working-with-audio/audio-volume-actor/index.md)

#### 剔除距离体积

**剔除距离体积（Cull Distance Volumes）** 会根据对象距摄像机的距离和对象大小来剔除对象（即不绘制到屏幕上）。这有助于优化场景，在对象小到可视为不重要时不予绘制。大小按边界框的最长边计算，所选剔除距离根据最接近该大小的距离计算。

有关更多信息，请参阅()[designing-visuals-rendering-and-graphics\rendering-optimization\visibility-culling\CullDistanceVolume]。

#### 分层LOD体积

**分层LOD体积（Hierarchical LOD Volumes）** 被[分层细节级别（HLOD）](../../../../building-virtual-worlds/hierarchical-level-of-detail/index.md)系统用于将Actor归入单个HLOD群集。在生成群集时，虚幻引擎将覆盖常规生成过程，转而遵循手动放置的体积。

#### Lightmass体积

许多地图的网格体外延到编辑器中网格的边缘，但需要高质量照明的实际可玩区域则小得多。Lightmass根据关卡的规模发射光子，因此这些背景网格体将显著增加需要发射的光子数，并且照明构建时间也将增加。

**Lightmass重要体积（Lightmass Importance Volume）** 控制Lightmass发射光子的区域，让你可以将光子仅集中在需要详细间接照明的区域。重要体积之外的区域仅获得间接照明的一次质量较低的反射。

**Lightmass角色间接细节体积（Lightmass Character Indirect Detail Volume）** 与Lightmass重要体积类似，它会在玩家高度（相对于地面）以及在整个体积中生成间接光线样本。此类体积的一个用处就是放置在电梯井中，确保沿电梯井的所有间接光照都正确，而非只有底部的间接光照正确。

有关更多信息，请参阅[Lightmass基础知识](../../../../building-virtual-worlds/lighting-the-environment/global-illumination/lightmass-basics/index.md)。

#### 网格体合并剔除体积

**网格体合并剔除体积（Mesh Merge Culling Volumes）** 标记它们包含的网格体对象，以便这些对象合并成单个网格体。这可以提高性能，因为可以将受控区域内一系列小网格体作为一个网格体一并剔除，或可使HLOD生成以更适宜的方式减少几何体。

有关更多信息，请参阅[合并Actor](../../merging-actors/index.md)

#### 后期处理体积

**后期处理体积（Post Process Volume）** 可以覆盖应用于体积内摄像机的后期处理设置。你可以使用它在关卡的不同区域实现不同种类的视觉效果。例如，你可能希望室内和室外区域具有不同的景深（DoF），或者根据局部天气效果（如雾）具有不同程度的泛光。

有关更多信息和可使用效果的列表，请参阅[后期处理效果](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)。

#### 预计算可视性体积

**预计算可视性体积（Precomputed Visibility Volume）** 主要用于性能优化。这些体积会存储Actor的可视性，以了解它们在世界中的位置。应仅将这些体积放在玩家可以到达的区域。

有关更多信息，请参阅[后期处理效果](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)。

#### 预计算可视性覆盖体积

如果预计算可视性体积的自动生成结果不理想，你可以使用 **预计算可视性覆盖体积（Precomputed Visibility Override Volume）** 手动覆盖Actor的可视性，以了解它们在世界中的位置。这些体积也用于性能优化，而且应仅放置在玩家可以到达的区域。

有关更多信息，请参阅[可视性和遮挡剔除](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/visibility-and-occlusion-culling/index.md)。

### 关卡和AI体积

#### 关卡流送体积

**关卡流送体积** 用于辅助[关卡流送](../../../../building-virtual-worlds/level-streaming/index.md)流程。它们允许你简单封装关卡，并控制其何时在内存中加载或卸载（在玩家进入或离开体积时）。

#### 寻路网格体边界体积

寻路网格体可计算整个关卡区域的寻路路径。**寻路网格体边界体积（Nav Mesh Bounds Volume）** 用于控制在关卡中构建寻路网格体的位置。

在该体积中，会在所有角度适合行走的表面上构建寻路网格体。你可以根据生成所需寻路网格体的需要，重叠任意数量的此类体积。

要使用寻路网格体边界体积，请创建一个或多个体积，将关卡的可寻路区域围住。寻路网格体将自动构建。

> [!TIP]
> 你可以随时在视口中按 **P** 键，使寻路网格体可见。

[内容示例](../../../../samples-and-tutorials/content-examples-sample-project/index.md)示例项目演示了如何在关卡中实现寻路网格体。

---
title: "场景查询测试Pawn"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/environment-query-testing-pawn-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "场景查询系统", "场景查询测试Pawn"]
---

# 场景查询测试Pawn

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 场景查询系统 / 场景查询测试Pawn

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/environment-query-testing-pawn-in-unreal-engine

除了[AI调试](../../ai-debugging/index.md)工具，场景查询系统还有一种特殊类型的 **Pawn** 类，称作 **场景查询系统测试Pawn**（**EQSTestingPawn**），可以通过它来查看场景查询的实际执行情况。场景查询的确切构造将决定所创建内容的大小和形状，但系统会始终用带颜色的球体来表示它。球体的色度如果是在绿色到红色的范围内，表示场景查询运行的各种测试有一定匹配程度。蓝色球体表示失败或返回false的布尔类型测试，例如追踪测试。

## 使用EQS测试Pawn

在[启用EQS](../environment-query-system-user-guide/index.md#%E5%90%AF%E7%94%A8eqs)并创建[EQS查询](../environment-query-system-user-guide/index.md#%E5%88%9B%E5%BB%BAeqs%E6%9F%A5%E8%AF%A2)后，可以在编辑器中使用EQS测试Pawn测试数据。

1. 在 **内容浏览器** 中，创建 **EQSTestingPawn** 类的新 **蓝图**，并给它指定任意名称。

   ![Create a new Blueprint of the EQSTestingPawn class and give it any name in the Content Browser](../../../../../assets/images/a3/a38a50bc4eb668b794f86e607498b3a0c40310d1627048c3e78cbc0dc94bc83d.png)
2. 将 **EQSTestingPawn** 放置在关卡中，然后在 **细节（Details）** 面板中指定要测试的 **EQS查询模板**。

   ![undefined](../../../../../assets/images/b2/b2e57a6a591ae92eec5e1cfa07ad8fadab68be5268a2dfd8c255231320f189b2.jpg)

   单击查看全图。

> [!WARNING]
> 由于场景查询系统仍处于实验性阶段，EQSTestingPawn可能给处理器造成极大负担，对其活跃查询模板进行修改可能会导致系统的超长时间挂起。在对场景查询进行编辑时，最好明确查询模板属性。

根据查询内容，在关卡中选择EQSTestingPawn时关卡会显示调试球体，表示基于条件的匹配值。下面我们使用EQSTestingPawn来测试一个查询，它会在关卡中生成能看到玩家角色的一个最佳位置。当四处移动EQSTestingPawn时，球体的颜色和数值都会更新，以表示根据玩家和EQSTestingPawn的位置得出的新最佳匹配。

## 结果求值

使用EQSTestingPawn对测试的结果求值时，带颜色的球体和数值会表明位于给定未知的项目（Item）的匹配程度。

- 蓝色球体

  ：这些球体表示在该项目（Item）上的测试失败，因此项目（Item）的权重会被完全取消，并从结果中剔除。通常在数值被过滤掉时就会发生这种情况，例如使用

  距离

  测试过滤掉所有超过（或不足）某一距离的项目（Item）。如果不希望将某个数值完全剔除，可以使用计分部分的

  锁定（Clamp）

  选项。下面有一个查询，我们运行它来查找看到玩家的视线。我们已经使用

  可视性（Visibility）

  剔除AI无法看到的项目（Item）（以蓝色球体表示）。

![Blue Spheres](../../../../../assets/images/7e/7ebac1d884fdc7a241dfebc0e8429faa625858cd5f8030987fe5be054cc34ab4.jpg)

- 绿色到红色的球体

  ：球体的颜色范围如果在绿色到红色之间，表示项目（Item）作为指定测试的最佳匹配的理想程度。绿色比红色理想，而显示的数字是项目（Item）的加权分数。如果只预览一个调试步骤，那么此值就是所选测试的最终值。下面我们使用一个查询来找到离玩家最远的点，不考虑可视性。

![Green To Red Spheres](../../../../../assets/images/3d/3d9ab5eb7eb836387c7a9fc491e29815318a3d97655174d779170b4deb435484.jpg)

## EQS测试Pawn属性

在关卡中选择EQSTestingPawn后，**细节（Details）** 面板中会提供下列属性。

| 属性 | 描述 |
| --- | --- |
| **查询模板（Query Template）** | EQSTestingPawn应该使用的场景查询。 |
| **查询配置（Query Config）** | 便于将指定的值传递到场景查询中，快速调节其设置。 |
| **每步时间限制（Time Limit Per Step）** | 如果此数值设置为任何大于0.0的值，将使EQSTestingPawn在此属性设置为该值时停止计算步骤。有助于缓解在使用EQSTestingPawn时对场景查询进行调整的影响。 注意：这不会缩短计算 **生成器** 所用的时间，例如使用 **密度** 紧密的大型 **简单网格** 时 |
| **步进以调试绘图（Step to Debug Draw）** | 显示一个调试步骤。可能与在场景查询中出现的步骤顺序不一致。 |
| **突出显示模式（Highlight Mode）** | 确定是应该按同一大小显示球体，还是突出显示最佳的 `5%` 或 `25%` 的球体（其他球体的大小将缩减）。 |
| **绘制标签（Draw Labels）** | 允许在视口中的调试球体上绘制权重或失败原因。 |
| **绘制失败项目（Item）（Draw Failed Items）** | 允许剔除所有失败的测试，例如追踪未能找到其目标时。 |
| **仅在完成移动时重新运行查询（Re Run Query Only on Finished Move）** | 仅在停止移动EQSTestingPawn时在视口中更新调试可视化。除非使用速度极快的场景查询，否认建议将此设置保持启用。 |
| **应该在游戏中可见（Should be Visible in Game）** | 使EQSTestingPawn及其调试可视化在运行游戏时可见。 |
| **在游戏时Tick（Tick During Game）** | 使EQSTestingPawn及其调试可视化在运行游戏时tick。 |
| **查询模式（Querying Mode）** | 当调试视图显示时更改。 **单个结果（Single Result）**：仅显示 **步进以调试绘图（Step to Debug Draw）** 属性中列出的项目（Item）的结果。 **所有匹配结果（All Matching）**：显示整个场景查询经过过滤和加权的最终分数结果。 |
| **导航代理属性（Nav Agent Properites）** | 确定Pawn如何导航的属性。 **导航代理半径（Nav Agent Radius）**：用于导航/寻路的胶囊体的半径。 **导航代理高度（Nav Agent Height）**：用于导航/寻路的胶囊体的总高度。 **导航代理步高（Nav Agent Step Height）**：要使用的步高，如果设为-1则使用NavData配置设置的默认值。 **导航行走搜索高度比例（Nav Walking Search Height Scale）**：在导航行走时搜索要投射的寻路网格体时应用于边界高度的比例因子。 **首选导航数据（Preferred Nav Data）**：此属性指定希望测试Pawn用于执行测试的导航数据类类型。 **可蹲伏（Can Crouch）**：如果为true，则Pawn可以蹲伏。 **可跳跃（Can Jump）**：如果为true，则Pawn可以跳跃。 **可行走（Can Walk）**：如果为true，则Pawn可以行走或在地面上移动。 **可游泳（Can Swim）**：如果为true，则Pawn可以游泳或移动通过流体体积。 **可飞行（Can Fly）**：如果为true，则Pawn可以飞行。 |

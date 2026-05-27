# PCG_BiomeGenerator 使用指南：分步设置与参数

- 来源: https://dev.epicgames.com/community/learning/tutorials/nK0x/unreal-engine-epic-for-indies-using-the-pcg_biomegenerator-step-by-step-setup-and-parameter-guide


![Using the PCG_BiomeGenerator: Step-by-Step Setup and Parameter Guide](assets/images/pcg-biome-generator-setup-parameters-01.jpg)


## 介绍

本章遵循第 1 部分概述的系统架构，重点介绍 PCG_BiomeGenerator 的实际设置和引擎内工作流程。

它涵盖了插件要求、蓝图放置、数据资产配置和参数定义，为将程序化生物群落生成集成到生产场景中提供了完整、可重现的指南。

BiomeSplineGenerator 蓝图是此工作流程的核心工具。其主要流程结合了样条曲线驱动的布局系统和作为模块化预设的数据资产。每个数据资产定义了生成行为、密度和变换参数，从而能够跨多个生物群落或地形类型进行灵活配置。

开始之前，请确保您的虚幻引擎项目中已启用以下程序化内容生成插件：

程序化内容生成框架（PCG）

程序化内容生成框架（PCG）外部数据互操作性

程序化内容生成框架 (PCG) 几何脚本互操作

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-02.jpg)


## 工作流管线


## 蓝图设置

将蓝图拖入关卡中。首先，将 BiomeSplineGenerator 蓝图直接放置到场景中。该蓝图是程序生成系统的基础，它将定义用于生成生物群系的样条路径。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-03.jpg)

在蓝图的“详细信息”面板中复制并分配数据资产。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-04.jpg)

双击数据资产将其打开。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-05.jpg)

如有必要，将蓝图样条线延伸到地图上，以覆盖资产将要生成的区域。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-06.jpg)

在数据资产中，为该组分配一个 ID。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-07.jpg)

对所有需要 ID 的参数组重复此 ID。每个组包含六个 ID 插槽： Main

When selecting a mesh 选择网格时

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-08.jpg)

SlopeInfo 坡度信息

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-09.jpg)


## 高度信息


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-10.jpg)


## 变换信息


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-11.jpg)

LandscapeInfo 景观信息

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-12.jpg)


## 选择要生成的网格


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-13.jpg)

设置地图上生成的角色参数。以下详细说明了每个参数的用途。

## BP_BiomeSplineGenerator 函数

BiomeSplineGenerator 的所有可用函数和参数都存储在一个数据资产中，并通过该数据资产进行控制。数据资产中的每个参数都包含一个工具提示，用于解释其用途。

## 调试

使用此部分可视化设置过程中的生物群落行为。调试立方体可帮助您快速确认边界、密度和生成逻辑。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-14.jpg)


## 通用

启用此参数后，蓝图可以读取地形材质的图层名称。将某个图层加入列表后，蓝图只会在该选定图层上执行。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-15.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-16.jpg)


## 地形图层

这里添加的图层必须使用地形图层中定义的精确名称。

## 图层过渡

用它在地形材质图层之间创建平滑的生物群落过渡，减少生硬边界。它控制资源在材质不同图层之间的过渡方式。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-17.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-18.jpg)


## 衰减


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-19.jpg)


## 可生成数组


## 投射到网格

保留所有功能；启用后，Actor 会生成在静态网格上，而不是生成在地形上。注意：所有参数都位于同一个统一图中并相互连接。因此，如果目标是在静态网格上生成 Actor，必须禁用 Use Landscape Data。

启用 Use Landscape Data 时，图会读取地形材质图层，并只在指定图层上生成 Actor。静态网格通常使用不同材质，因此如果保持该选项启用，Actor 将不会在静态网格上生成。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-20.jpg)


## 地形/网格投射

在网格上生成 Actor 时，可以选择如何处理地形上的 Actor：Exclude 表示只在网格上生成，忽略地形 Actor。

Include：同时在网格和地形上生成。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-21.jpg)


## Actor 标签过滤器

控制蓝图是否与带有特定 Actor Tag 的网格交互。选项包括：NoTagFilter 表示在所有网格上生成，不进行标签过滤。

IncludeTagged：只在带有指定标签的网格上生成。

ExcludeTagged：阻止在带有指定标签的网格上生成。

默认情况下，没有标签的网格也可以使用。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-22.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-23.jpg)


## Actor 标签列表

使用标签控制生物群落与哪些网格交互。这有助于定位特定几何体或排除某些对象。可添加多个标签，并按需用逗号分隔。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-24.jpg)

使用基于标签的过滤时，如果 Actor 需要同时生成在网格和地形上，地形也必须分配 Actor Tag。

## 距离剔除

用它移除远处实例，并优化大型环境中的性能。它会根据网格与相机的距离执行反生成。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-25.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-26.jpg)

剔除距离只能在图中编辑。要调整它，请进入 `/All/Game/PCG/Deliver/BiomesGeneratorOnDataAssets/Graphs/BiomeSpline/Subgraphs`，打开 `PCG_AssignMeshesNearCull` 子图。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-27.jpg)

选择图中的最后一个 StaticMeshSpawner 节点。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-28.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-29.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-30.jpg)

在该节点参数中设置所需的 InstanceStartCullDistance 和 InstanceEndCullDistance。

## 网格

此部分定义用于填充生物群落的资源，以及它们的密度、间距和碰撞行为。该选项卡存储资源数据；由于它是数组，可以添加多个网格。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-31.jpg)

ID

指定此资源组的工作标识符。该 ID 必须与组内所有对应 ID 字段保持一致。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-32.jpg)

Mesh 网

指定将作为此生物群系组一部分生成的网格。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-33.jpg)

Weight 重量

当此数组中存在多个网格时，此值会调整它们之间的生成比例。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-34.jpg)

Density 密度

控制角色的生成密度以及在生物群落中出现的实例数量，从而塑造环境的饱满或稀疏感。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-35.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-36.jpg)

MeshBoundsScale 网格边界缩放

每个角色都有碰撞边界，以确保它不会与其他角色发生碰撞。此参数允许在所有三个轴上缩放这些边界。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-37.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-38.jpg)

Looseness 松弛

控制生成的 Actor 之间的间距，增加或减少它们之间的距离。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-39.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-40.jpg)

NoOverlaps 无重叠

启用此选项可防止角色相交，前提是角色的边界已沿网格边缘正确定义。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-41.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-42.jpg)

UseNoise 使用噪声

允许使用噪声掩码来影响生成。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-43.jpg)


## 噪声模式

指定噪声算法：Perlin 或 Caustics。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-44.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-45.jpg)


## 噪声变换

允许在 X 和 Y 轴上缩放噪声遮罩。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-46.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-47.jpg)


## 噪声迭代

提高噪声细节级别，尤其是遮罩边界附近的细节。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-46.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-48.jpg)


## 噪声边缘裁切

控制噪声遮罩的裁切方式，可让图案从外边缘或朝中心方向被裁切。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-49.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-50.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-51.jpg)

InvertNoise 反噪声

反转噪声掩码值。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-52.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-53.jpg)


## 扩散网格

允许网格围绕组的主网格呈放射状生成。由于组中的每个网格都被视为此行为的父网格，因此建议在使用此参数之前降低网格密度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-54.jpg)


## 环绕网格

选择将在父网格周围生成的网格。 Seed 种子

选择用于随机化参数的种子。确保每个组使用不同的种子。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-55.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-56.jpg)


## 坡度信息

根据表面坡度控制角色生成的参数。 ID

请为此资产组输入一个临时名称。该名称必须与该组中所有其他槽位使用的 ID 一致。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-57.jpg)

MaxSlopeAngle 最大坡度角

定义角色生成允许的最大坡度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-58.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-59.jpg)

SlopeStrength 边坡强度

调整坡度对截止边界的影响程度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-60.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-61.jpg)

NearSlopeDensity 近坡密度

控制角色在坡度过渡区域附近的生成密度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-62.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-63.jpg)

NearSlopeScale 近坡度尺度

控制放置在坡度过渡区域附近的演员的大小。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-64.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-65.jpg)


## 高度信息

使用世界空间高度值定义生成规则，从而实现基于高度的 Actor 剔除。 ID

请为此资产组输入一个临时名称。该名称必须与该组中所有其他槽位使用的 ID 一致。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-66.jpg)

UseHeightInfo 使用高度信息

启用或禁用基于高度的 Actor 移除。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-67.jpg)

MinimumHeight / MaximumHeight

最低高度/最高高度

定义角色可以生成的垂直范围。屏幕截图中的球体有助于可视化世界空间高度值。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-68.jpg)

FadeOffTop / FadeOffBottom

顶部淡出/底部淡出

设置基于高度的渐变的上限和下限。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-69.jpg)

FadeOffDensity 淡出密度

控制角色沿着渐变淡出时生成的密度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-70.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-71.jpg)

ScaleFadeOffTop / ScaleFadeOffBottom

控制构成淡出边界上下边缘的演员的尺度。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-72.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-73.jpg)


## 变换信息

控制生成角色的变换设置和位置随机化。为了更清晰地查看偏移量，您还可以使用“噪声”参数。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-74.jpg)

Align to Normal 对齐到正常位置

将网格与表面法线对齐，以实现更自然的放置。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-75.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-76.jpg)

OffsetMin / OffsetMax 最小偏移量/最大偏移量

调整网格沿 X 轴和 Y 轴的最小和最大位置偏移量。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-77.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-78.jpg)

RotationMin / RotationMax

最小旋转角度/最大旋转角度

控制应用于每个角色的随机旋转范围。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-79.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-80.jpg)

ScaleMin / ScaleMax 最小缩放比例 / 最大缩放比例

定义随机化每个角色大小的范围。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-81.jpg)

UseUniformScale 使用统一尺度

对三个轴均匀应用缩放，以实现统一的尺寸变化。

## 地形设置

控制角色如何与地形表面交互的信息设置。 ID

请输入此资产组的工作 ID 名称。它必须与该组内所有其他相关槽位中使用的 ID 一致。
- `RemovePCG`

如果需要移除特定景观图层上的此角色组，请启用此选项。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-82.jpg)

ErasePCGPaintLayer 擦除 PCGPaint 层

指定要移除此角色组的景观图层名称。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-83.jpg)

UsePathCut 使用路径切割

启用此选项后，样条线工具将从该组中移除 Actor。用于基于路径移除 Actor 的蓝图位于以下路径：

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-84.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-85.jpg)

- `/All/Game/PCG/Deliver/Spline`
- ``/All/Game/PCG/Deliver/Spline``

`BP_PathCut` 是一个样条 Actor，用于移除路径上方和下方的 PCG 对象。为了获得准确结果，样条应大致沿地形或网格所在平面放置。

BP_PathCut 是一个样条曲线 Actor，用于移除路径上方和下方的 PCG 对象。为了获得精确的结果，样条曲线应大致沿地形或网格的平面放置。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-86.jpg)

BP_PCG_Disable BP_PCG_禁用

表示用于禁用或排除其边界内的 PCG 对象的闭合样条曲线。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-87.jpg)

PathCutRestart 路径重启

刷新某些参数。如果路径切割未正确更新，请启用或禁用此功能。 PathSize 路径大小

调整切口区域的大小。您可以使受影响的区域比样条曲线的实际边界更宽或更窄。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-88.jpg)


![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-89.jpg)

DebugColor 调试颜色

设置用于可视化的调试立方体的颜色。

![PCG_BiomeGenerator 使用指南：分步设置与参数 figure](assets/images/pcg-biome-generator-setup-parameters-90.jpg)


## 结论

第二部分将 PCG_BiomeGenerator 从概念转化为实际应用，展示了每个蓝图、数据资产和参数如何共同构建一个完全模块化的生物群系系统。通过统一设置 ID、配置网格、坡度、高度和变换规则，并理解地形和样条曲线工具如何与生成器交互，您现在拥有了精确控制程序行为的完整基础。有了这个架构，您可以自信地扩展生物群系预设、改进生成逻辑，并使系统适应各种地形和生产需求。下一章将在此工作流程的基础上，探讨高级行为、优化策略和调试技巧，帮助您将生物群系完善到可用于生产的程度。 Happy Creating! 🌟

创作愉快！ 🌟

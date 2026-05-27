# 《Stack O Bot》示例游戏

---
title: "《Stack O Bot》示例游戏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/stack-o-bot-sample-game-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "《Stack O Bot》示例游戏"]
---

# 《Stack O Bot》示例游戏

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / 《Stack O Bot》示例游戏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/stack-o-bot-sample-game-in-unreal-engine

**《Stack O Bot》**是一个游戏项目示例，可用于学习和探索如何使用虚幻引擎开发游戏。 该项目展示了多种引擎功能，包括**程序化内容生成（PCG）**、**蓝图**及**关卡实例**。 项目中还包含关于设计选择和实现方法的游戏开发解说，并提供带注释的蓝图和材质。

在《Stack O Bot》中，玩家以第三人称视角操控机器人角色，需完成一系列平台挑战和基于物理的谜题。 该项目可在多种设备上运行，包括手机和高端PC，并且可通过键盘/鼠标、手柄或触摸屏输入操控。

本文将介绍如何打开《Stack O Bot》示例项目，概述项目的主要特点，并提供相关文档链接，供大家深入学习。

## 打开《Stack O Bot》示例项目

> [!NOTE]
> 本文所述的《Stack O Bot》示例使用虚幻引擎5.6构建。 若想体验旧版《Stack O Bot》示例，请下载适用于5.6之前引擎版本的项目。

请按下列步骤打开《Stack O Bot》示例项目：

1. 在Fab中找到[《Stack O Bot》](https://www.google.com/url?q=https://www.fab.com/listings/b4dfff49-0e7d-4c4b-a6c5-8a0315831c9c&sa=D&source=docs&ust=1754928300614820&usg=AOvVaw35YA7pgZS5sx8t8KVs9sEp)示例，点击**添加到我的库（Add to My Library）**。

   1. 或者，你也可以在虚幻引擎的[Fab插件](../../../understanding-the-basics/assets-and-content-packs/fab-window/index.md)中搜索该示例项目。
2. 前往**《Stack O Bot》**并点击**创建项目（Create Project）**。
3. 在**Epic Games启动器**中选择**虚幻引擎（Unreal Engine）**>**库（Library）**>**Fab库（Fab Library）**。
4. 为你的项目输入名称和位置。
5. 选择虚幻引擎**5.6**版本。
6. 点击**创建（Create）**。 即可打开项目。

关于访问示例内容及虚幻引擎的Fab插件，详见[示例与教学](../../index.md)

### 推荐的系统规格

《Stack O Bot》支持多种设备，包括手机和PC。 内容适配不同细节等级，完全兼容移动设备。

以下是PC端推荐的系统规格：

- Windows 10 64位版本1909修订版.1350或更高，或者版本2004和20H2修订版.789或更高。

  - Windows 11与虚幻引擎5兼容，且符合推荐的规格要求。
- Intel或AMD四核处理器，2.5 GHz或更快
- 32 GB的系统RAM
- 8GB的VRAM
- DirectX 11或12兼容显卡

## 《Stack O Bot》项目导航

打开Stack O Bot项目后，默认情况下会在[关卡编辑器](../../../building-virtual-worlds/level-editor/index.md)中打开**Lvl_Empty**地图。该地图提供了使用该示例项目所需的一些屏幕信息。

示例项目的大部分内容都位于`/Content/StackOBot/`文件夹。 主游戏地图**Lvl_StackOBot**位于`/Content/StackOBot/Maps`文件夹。

点击**主工具栏**中的**运行**图标即可试玩游戏。

游戏从主菜单开始，该菜单位于**Lvl_MainMenu**地图中。 点击**PLAY**进入主游戏地图**Lvl_StackOBot**。

> 图片已省略：《Stack O Bot》主菜单

主游戏地图包含气泡图标，当玩家靠近时会触发开发者解说。 该注释解释了开发人员在制作Stack O Bot时的一些实现细节和设计决策。

> 图片已省略：《Stack O Bot》中的起泡图标

开发者解说气泡的内容位于`/Content/DevCom`文件夹。

### 《Stack O Bot》游戏控制

玩家可通过键盘/鼠标、手柄或触屏控制玩《Stack O Bot》。

| 操作 | 键盘和鼠标 | 控制器（Controller） | 触控（见下图） |
| --- | --- | --- | --- |
| 移动 | W、A、S、D | 左摇杆 | 1 |
| 察看 | 鼠标 | 右摇杆 | 2 |
| 跳跃 | 空格键（按） | 正面底部按钮（按） | 3（按） |
| 喷气背包 | 空格键（长按） | 正面底部按钮（长按） | 3（长按） |
| 抓取 | E | 右扳机 | 5 |
| 暂停 | Esc退出键或左Shift键 | 开始按钮 | 6 |

> 图片已省略：《Stack O Bot》的触摸控制

《Stack O Bot》的触摸控制

## 《Stack O Bot》中的功能

此分段介绍了Stack O Bot示例项目中使用的功能，以及相关资产在项目文件夹中的位置。

### 关卡介绍

《Stack O Bot》以关卡介绍开场，该介绍由使用[Sequencer](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md)构建的关卡序列实现。 该序列通过三台过场动画摄像机和一个摄像机剪切轨道，在关卡中移动并展示游戏地图的各个元素。

关卡序列（**SQ_Lvl1_fly**）位于`/Content/StackOBot/Maps`文件夹。

### 自定义第三人称角色

《Stack O Bot》项目包含一个第三人称角色，该角色可移动、跳跃并与NPC及物体互动。 角色蓝图**BP_Bot**集成了[动画图表](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/graphing-in-animation-blueprints/index.md)、[控制绑定](../../../animating-characters-and-objects/control-rig/index.md)以及可自定义的[材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)。

动画图表用于创建站立、奔跑、跳跃等不同状态的角色动画。 控制绑定用于制作上下文动画，例如将角色的脚放在不同的表面上，在按压按钮时将手引导到按钮位置等。 自定义材质包含一系列参数，可设置不同的颜色组合，调整角色的面部表情。

**BP_Bot**蓝图位于`/Content/StackOBot/Blueprints/Character`文件夹，角色动画与材质位于`/Content/StackOBot/Characters/Bot`文件夹。

### 程序化内容生成（PCG）

《Stack O Bot》的地图使用[程序化内容生成（PCG）](../../../building-virtual-worlds/procedural-content-generation/procedural-content-generation-overview/index.md)系统创建。 PCG可用于制作许多资产，包括漂浮岛屿、植被、平台、六边形穹顶、围栏和金币生成器等等。

平台通过设置尺寸，使用现有图块创建，并遵循相应的规则，以确保视觉一致性。 穹顶遍布整个地图，但你可以设置没有穹顶的关卡入口和出口。

围栏使用PCG系统创建，该系统会对**PCG_BP_FenceSpline**样条线进行采样，然后根据相应规则生成围栏的不同部分，比如柱子和端盖。 地图中的金币生成器也是用PCG创建的，可以沿样条线生成金币。

PCG内容位于`/Content/StackOBot/Blueprints/PCG`文件夹。

### 智能无UV材质

《Stack O Bot》项目使用智能无UV材质，为地图中所有带混凝土、金属或涂漆表面的网格体提供了高质量纹理，例如漂浮平台、金属圆柱体以及生态穹顶结构的金属部件。 开发团队没有为网格体的各个部分创建[UV通道](../../../working-with-content/static-meshes/using-uv-channels-with-static-meshes/index.md)，而是通过[建模工具](../../../working-with-content/modeling-and-geometry-scripting/modeling-tools/index.md)，为每个网格体添加了[顶点颜色](../../../working-with-content/modeling-and-geometry-scripting/modeling-tools/paint-vertex-colors-tool/index.md)信息。 智能材质利用顶点颜色为每个网格体确定纹理位置。

### HLOD生成

《Stack O Bot》中的地图规模庞大，包含大量需要渲染的资产，为了提升游戏运行时的性能表现，项目采用了虚幻引擎的[分层细节级别（HLOD）](../../../building-virtual-worlds/hierarchical-level-of-detail/index.md)系统。

### StateTree NPC行为

《Stack O Bot》包含可与玩家角色互动的非玩家角色（NPC）。 NPC可在地图的部分区域四处走动，在玩家靠近时追击玩家，与玩家碰撞时将玩家击退，玩家可通过跳起踩头消灭NPC。 NPC行为通过[StateTree](../../../gameplay-systems/artificial-intelligence/statetree/overview-of-state-tree/index.md)控制，StateTree定义了每个NPC可能处于的不同状态（如空闲、行走或死亡），以及每种状态对应的行为。

NPC的StateTree位于`/Content/StackOBot/AI/STree_Bug`文件夹。

### 模块化关卡实例

《Stack O Bot》使用[关卡实例](../../../building-virtual-worlds/world-partition/level-instancing/index.md)创建可重复利用的模块化关卡片段。 例如，包含浮岛变体的关卡实例可用于构建游戏地图，无需为每个新区域创建独特的内容。

每个关卡实例可作为独立的地图运行，也可添加到[世界分区](../../../building-virtual-worlds/world-partition/index.md)地图中。 放在另一个地图中时，每个实例都有变换属性，可以旋转和定位。

你可以通过细节面板，将对象添加到标记**仅主世界（Main World Only）**的实例中。 只有在实例作为独立的地图运行时，才会显示这些对象，若将地图用作世界分区地图中的关卡实例，则不会显示这些对象。 对于不想在世界分区地图中使用的光源、玩家出生点等其他对象，可以勾选**仅主世界（Main World Only）**复选框，这些对象可以在测试和调试关卡实例（作为独立地图运行）时使用。

关卡实例位于`/Content/StackOBot/Maps/LevelInstances`文件夹。 关卡实例使用的标记为仅主世界（Main World Only）的对象，保存在`Main World`文件夹中。

### 基于物理的交互

《Stack O Bot》使用虚幻引擎的[物理](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/physics-in-unreal-engine)系统实现物理对象、交互与破坏效果。

玩家角色可使用物理抓柄抓取物理对象，例如可堆叠的箱子。 弹跳板和风扇等物体使用物理命令分将玩家抛向空中。 漂浮平台和桥梁采用物理约束配置。 可破坏对象（例如屋顶和重生平台）使用预先破裂、由Chaos主场触发的[几何体集合](../../../gameplay-systems/physics/chaos-destruction/chaos-destruction-key-concepts/geometry-collections-user-guide/index.md)构建。

物理对象位于`/Content/StackOBot/Blueprints/PhysicsElements`文件夹。

### 动态摄像机

《Stack O Bot》使用自定义[玩家摄像机管理器](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/cameras-in-unreal-engine#playercameramanager)（**BP_CamManager**）创建了三种不同的摄像机类型：

- 跟在玩家身后的第三人称摄像机
- 固定式第三人称视角，旨在以过场动画角度展示游戏地图中的各种元素
- 横版卷轴实现，旨在复刻经典2D平台游戏风格

主地图的大部分区域都采用跟随玩家的第三人称摄像机。 当玩家站在特定移动平台上时，摄像机会切换至固定式第三人称视角。 摄像机在地图中的某个区域会切换至横版卷轴视角。

摄像机管理器通过蓝图Actor（**BP_GameCamVolume**）、管理器内部逻辑和接口（**BPI_CamManager**）实现三种摄像机类型的切换，该接口负责在管理器和蓝图Actor之间通信。

摄像机管理器和游戏摄像机体积蓝图位于`/Content/StackOBot/Blueprints/Camera`文件夹。

### Gameplay交互

《Stack O Bot》提供一个交互处理器[组件](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/unreal-engine-terminology#component:~:text=of%20that%20class.-,Component,-A%20Component%20is)，可与玩家角色交互的所有Actor均包含该组件， 适用于按钮、压力板等对象。

可抓取对象（如板条箱）具有**GRAB** Actor标签，**BP_Bot**中的**Grab_Check**函数负责检测该标签。 被抓取对象通过**Grab_Update**函数更新。

交互处理器组件位于`/Content/StackOBot/Blueprints/GameElements`文件夹。 抓取逻辑保存在**BP_Bot**蓝图中，该蓝图位于`/Content/StackOBot/Blueprints/Character`文件夹。

### 对象追踪

《Stack O Bot》使用[游戏模式（Game Mode）](../../../gameplay-systems/gameplay-framework/game-mode-and-game-state/index.md)实现目标系统。 你可以在交互处理器蓝图组件中，使用**IsObjective**布尔值标记可交互的Actor。 当玩家与标记的Actor交互时，将更新目标。

目标在游戏的[用户界面（UI）](../../../gameplay-systems/gameplay-framework/user-interfaces-and-huds/index.md)追踪。 交互处理器会将对象状态发送到UI，并根据需要更新UI。

目标还会通过**BP_Portal** Actor在地图中直观显示，每个目标都有一个光源。 目标完成时，点亮对应的光源。 完成所有目标并点亮所有光源后，激活传送门，启用触发碰撞。 这一激活机制允许玩家通过进入传送门完成当前地图。 交互处理器组件负责管理光源和传送门的逻辑。

交互处理器组件（**BPC_InteractionHandler**）和传送门蓝图（**BP_Portal**）位于`/Content/StackOBot/Blueprints/GameElements`文件夹。 用户界面资产（**HUD_InGame**）位于`/Content/StackOBot/Blueprints/Framework`文件夹。


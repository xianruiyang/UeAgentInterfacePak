---
title: "游戏动画示例项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/game-animation-sample-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "游戏动画示例项目"]
---

# 游戏动画示例项目

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / 游戏动画示例项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/game-animation-sample-project-in-unreal-engine

**游戏动画示例项目** 是一个你可以用来观察和了解虚幻引擎中的现代高保真动画系统的项目。该系统采用一套由[运动匹配](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/motion-matching/index.md)等动画功能驱动的动作捕捉动画，为人类角色的穿梭系统提供高品质响应式动画系统。系统功能涵盖常见的动画需求，例如移动、攀岩和跳跃。该项目分为几个障碍训练场，你可以化身为几个内置的角色在其中导航。

此外，动画示例项目还可以扩展，允许你导入自己的角色，查看动画系统如何与不同的角色配合使用，甚至可以将动画资产和系统迁移到你自己的项目中以供使用和编译。

> 动图已省略：ImageAltText

> [!TIP]
> 游戏动画示例项目会随着引擎和功能的持续开发而更新，因此建议你继续关注后续发布的更新。

### 安装项目

要安装该项目，请从[Fab](https://www.fab.com/)下载[游戏动画示例项目](https://www.fab.com/listings/880e319a-a59e-4ed2-b268-b32dac7fa016)。

![ImageAltText](../../../../assets/images/32/32fea7d4a0f826f149e613e040453cc546429ee385413e4f549bd1f9cd9b597d.jpg)

要打开项目，请在 **虚幻引擎启动程序（Unreal Engine Launcher）** 的 **库（Library）** 面板的 **保管库（Vault）** 分段中找到该项目，然后选择 **创建项目（Create Project）** 按钮。

创建并打开项目后，你可以使用 **在编辑器中运行** （ **PIE** ）功能按钮来运行该项目。

## 自述文件

踩踏 `DefualtLevel` 中的 **自述文件（Read Me）** 按钮，可以查看项目的介绍对话框。

![ImageAltText](../../../../assets/images/61/61e5dd33f40e609487af0427b0fd8794f31e783c0eefddf33e5e31ca3576d012.jpg)

下方是自述文件的文本记录。

| 自述文件 |
| --- |
| 该项目的目标是全面展示各种Gameplay动画功能和资产，供用户使用、解构和学习。目前主要关注动画功能而不是Gameplay系统，因此你在该项目中找到的Gameplay功能（例如穿梭系统）都会很简单，仅作为示例来介绍动画系统如何与Gameplay系统交互。 首个版本以我们的新运动匹配工具集为中心，展示了如何设置基本的第三人称角色移动，以及将运动匹配用于胶囊体驱动运动模型的最佳实践。我们还演示了如何使用运动匹配来为Gameplay动作选择剪辑片段和进入帧。我们还极其依赖选择器，这是一项最近添加的功能，可以帮助我们控制运动匹配，因为它能根据Gameplay上下文筛选从哪个数据库中进行选择。 随着每个主要引擎版本的发布，该项目将持续更新和改进。你可以将其视为一个正在实施的项目，随着时间的推移，项目将不断完善，提供更多的动画、更多的功能，并为多种游戏类型探索更多的创意。这仅仅是开始，敬请继续关注，该项目提供丰富多彩的内容，希望你能在探索的过程中享受到乐趣！ |

### 玩家控制键

踩踏 `DefaultLevel` 中的查看控制按钮（View Controls），可以查看玩家控制键列表。

![ImageAltText](../../../../assets/images/81/814044a25df65ff922dc3d97225f85bcaf66b0e62d838261b3b7948ae721a501.jpg)

下方是键鼠和游戏手柄输入的玩家控制键列表。ImageAltText

| 键盘 | 控制器 | 操作 |
| --- | --- | --- |
| **W** 、 **A** 、 **S** 和 **D** | **左模拟摇杆** | 移动玩家角色。 |
| **鼠标** （ **X** 和 **Y** ） | **右模拟摇杆** | 旋转摄像机。 |
| **左CTRL** | **右肩按钮** | 切换玩家的跑步和行走状态。 |
| **空格** | **正面底部按钮** | 使角色跳跃并越过障碍训练场中的壁架和拱顶。 |
| **鼠标中键** | **右模拟摇杆按钮** | 在自由旋转和平移之间切换角色的旋转模式。 |
| **鼠标右键** | **左侧扳机** | 聚焦摄像机，类似于动作游戏中的瞄准功能。 |
| **数字键** |  | 当使用 `CPB_Sandbox_MetaHuman_Bodies` 玩家角色时，你可以使用 **1** 至 **9** 键将MetaHuman网格体替换为不同的MetaHuman体型，并使用 **0** 键将网格体切换为男性或女性体型。 alt text |

### 游戏动画控件

**游戏动画控件（Game Animation Widget）** 是一个充满实用工具和属性的面板，可以用来与动画示例项目进行交互。在PIE期间控制视口中的角色并踩踏 `DefaultLevel` 中的游戏动画控件按钮，可以打开游戏动画控件。

![ImageAltText](../../../../assets/images/ba/ba7e31f4148df720499f11a3dd1203fb7ef46aef909a8242477b243a8bb9ddda.jpg)

打开游戏动画控件后，可以访问以下属性和设置：

![ImageAltText](../../../../assets/images/84/849974e2e9c68449c4a3b80a16c54763348a02f78339bfefaadb5848518fbb39.jpg)

| 属性 | 说明 |
| --- | --- |
| **实用按钮（Helpful Buttons）** （ **仅限PIE（PIE Only** ） | 当游戏在编辑器中运行（PIE）时，以下选项可用于更改项目属性。 |
| **最大FPS（Max FPS）** | 你可以在此处设置渲染项目的最大帧数。你还可以使用 **显示FPS（Show FPS）** 按钮在PIE期间切换视口中的帧数。选择其中一个FPS选项，游戏会将渲染帧率限制在特定值，以便你可以观察动画在不同项目帧率下的情况。此外，你还可以使用右侧的属性字段设置自定义帧率。 |
| **时标（Timescale）** | 你可以在此处设置项目的时标，默认选项 `1` 将以预期速度运行项目。选择更小的选项时，项目速度将放缓，观察动画会更容易，而选择更大的值时，项目速度将加快，你可以观察在更快的Gameplay期间动画系统的执行情况。 |
| **声音（Sound）** | 你可以在此处使用右侧的属性字段设置项目的音量，或者使用 **静音（Mute）** 按钮完全将音频静音。 |
| **静态摄像机（Still Cam）** | 此处你可以在PIE期间启用简单的调试摄像机模式。你可以切换以下按钮，获得不同的效果： **启用（Enabled）** ：启用后，摄像机的位置将锁定。你可以将此模式与其他两个属性结合使用，以进行调试。禁用此属性会使摄像机恢复到默认视角。 **跟随（Follow）** ：当静态摄像机也处于 **启用（Enabled）** 状态时，允许静态摄像机跟随玩家角色（但不随控制器旋转）。 **旋转（Rotate）** ：当静态摄像机也处于 **启用（Enabled）** 状态时，允许静态摄像机旋转来跟踪玩家位置。 |
| **绘制（Draw）** | 你可以在此处切换以下玩家角色组件在视口的调试绘制： **碰撞（Collision）**：玩家角色的碰撞边界。 **骨骼（Bones）**：玩家角色的[骨架资产](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)。 **移动（Movement）**：玩家角色的移动模型。 **轨迹（Trajectory）**：玩家角色的运动轨迹组件，由运动匹配系统查询。 **运动匹配（MM）查询（Motion Matching (MM) Query）** ：玩家角色轨迹组件中正在接受运动匹配系统查询的时刻。 |
| **动画节点（Anim Nodes）** | 在下面的属性集中，你可以将不同的叠加组件切换到基础运动匹配系统，以观察每个附加功能如何增强动画系统的质量和覆盖范围。每个功能都有一个按钮用于启用或禁用该功能，以及调试渲染视图，以便更好地观察该功能如何改变运行时使用的最终姿势。 |
| 根骨骼偏移（Root Offset） | 你可以在此处切换 **ABP_SandboxCharacter** 动画蓝图中的实验性 **Offset Root Bone** 节点。此节点用于修复动画播放期间胶囊体的网格体偏差。启用该节点时，如果角色停止移动，系统会将网格体的位置混合回胶囊体中心。你可以切换此属性来测试其效果，并启用调试绘图，以观察Gameplay期间网格体与胶囊体的偏差。 |
| **方向扭曲（Orientation Warping）** | 方向扭曲是一种动画功能，可以扭曲角色移动以实现特定的目标和对齐。方向扭曲可以帮助实现项目所需的动画覆盖范围，以填补没有动画数据的空白。你可以使用此属性来切换Orientation Warping节点是否激活，以便比较其效果。你还可以启用调试（Debug）选项，以便在运行时直观渲染方向扭曲对角色的影响。 如需详细了解方向扭曲，请参阅[方向扭曲](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/locomotion/pose-warping/index.md#%E6%96%B9%E5%90%91%E6%89%AD%E6%9B%B2)文档。 |
| **腿部IK（Leg IK）** | 逆向运动学（IK）是创建骨骼链的方法，可以对角色环境做出更自然的反应。当角色站在不平坦的表面上时，腿部IK系统可以创建更自然的姿势。你可以使用此属性来切换ABP_SandboxCharacter动画蓝图中的Leg IK节点是否在运行时激活。你还可以使用调试（Debug）选项查看在属性启用时Leg IK节点的效果。 |
| **运动匹配数据库LOD（Motion Matching Database LOD）** | 你可以在此处设置姿势搜索数据库资产的 **细节级别**（**LOD**），运动匹配系统将从中选择动画。使用 **运动匹配数据库细节级别（Motion Matching Database LOD）** 属性，你可以观察在使用具有更密集或更稀疏动画数据的姿势搜索数据库时，动画数据如何缩放。 |
| **角色覆盖（Character Override）** | 你可以在此处覆盖玩家角色的蓝图，以观察不同角色在使用相同的动画数据集和逻辑时的表现。 选择不同的角色会覆盖项目的游戏模式Pawn类。 |
| **控制器（Controller）** | 你可以在此处观察运行时向游戏馈送的输入的调试渲染。当你向游戏馈送输入时，控制器会更新代表该输入的高亮显示按钮。 |

> [!NOTE]
> 首次打开自述文件（Read Me）、查看控制键（View Controls）或游戏动画控件（Game Animation Widget）后，你可以在 **菜单栏** 中找到 **工具（Tools）** > **编辑器工具控件（Editor Utility Widgets）** ，并选择要打开的窗口，来重新打开这些窗口。
>
> ![ImageAltText](../../../../assets/images/01/01eb6cbf7d945cc861b5e1d24f385a707d75a55b7b4bd637cf02b62b9cdc825a.png)

### 运行项目

该项目包含一个关卡（`DefaultLevel`），其中包含一系列可以通过跳跃、攀爬和掉落进行交互的障碍物。首次打开项目时会打开 `DefaultLevel`。要开始与项目交互以观察动画系统的运行，请使用虚幻编辑器工具栏PIE分段中的运行（Play）按钮。

![ImageAltText](../../../../assets/images/14/143583298e050a97ceb00952b8eb01fa19d981cd3851a0b9dc6cea043b193c38.jpg)

该项目包含几个原型样式的墙壁、壁架和平台，你可以使用键盘和鼠标或游戏手柄输入在期间导航。

> [!TIP]
> 尝试与每个尺寸不同的障碍物进行交互，查看动态动画播放如何随互动情况而缩放。

关卡中的地上有一些按钮。这些按钮具有不同的效果，让角色踩踏按钮可以激活效果。

#### 关卡颜色模式

第一组在玩家出生点附近。这三个按钮会改变关卡的外观。

![ImageAltText](../../../../assets/images/45/45bb14e0d85749b86ee48e7795b01be13465b70c41dbb094b229d424e2386c83.jpg)

#### 项目信息和设置

下一组按钮将打开项目信息和属性设置。

> 图片已省略：ImageAltText

此外还有一系列"前往目的地（To Destination）"按钮，可以将玩家传送到障碍训练场的特定区域。

> 图片已省略：ImageAltText

## 导入你自己的角色

你可以将动画示例项目用作起始点，在你自己的项目中构建类似系统。你可以在动画示例项目中导入自己的角色，按照以下步骤观察系统如何使用骨骼网格体执行操作。

#### 先决条件

- 你已将骨骼网格体角色导入到游戏动画示例项目中。如需详细了解如何导入骨骼网格体角色，请参阅[FBX内容管线](../../../working-with-content/fbx-content-pipeline/index.md)文档。
- 你已经为导入的角色创建并设置 **IK Rig** 资产。如需详细了解如何创建IK Rig资产，请参阅[IK Rig](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/ik-rig/index.md)文档。

### 实现你的角色

导入角色并设置IK Rig资产后，你可以创建 **IK Rig重定向器（IK Rig Retarget）** 资产，将 **UEFN_Mannequin** 骨骼网格体角色重定向到你的骨骼网格体角色。如需详细了解如何创建IK重定向器资产，请参阅

以UEFN_Mannequin作为源，角色作为目标，设置好IK重定向器资产后，在内容浏览器中找到 **内容（Content）** > **蓝图（Blueprints）** > **重定向的角色（Retargeted Characters）** ，然后打开 **ABP_GenericRetarget** 动画蓝图资产。

> 图片已省略：ImageAltText

在我的蓝图（My Blueprint）面板中选择 **IKRetargeter_Map** 变量，并展开 **默认值（Default Value）** 数组。使用（**+**） **添加（Add）** 向数组添加新元素，并在新元素属性字段中，选择你的IK重定向器资产。然后，在数组元素的 **名称（Name）** 字段中，输入以下内容：`RTG_UEFN_to_{your asset’s name}`

> 图片已省略：ImageAltText

然后，在内容浏览器中找到 **内容（Content）** > **蓝图（Blueprints）** ，右键点击资产并选择 **创建子蓝图类（Create Child Blueprint Class）** 选项，创建 **CBP_Sandbox_Character** 角色蓝图的新子蓝图。将资产重命名为 **CBP_Sandbox_{你的角色名称}** 。

> 图片已省略：ImageAltText

在 **组件（Component）** 面板中选择 **网格体（角色网格体）（Mesh (CharacterMesh)）** 组件，并在 **细节（Details）** 面板中禁用 **可见（Visible）** 属性。

> 图片已省略：ImageAltText

然后，在仍然选中网格体组件的情况下，使用（**+**） **添加（Add）** 创建新的骨骼网格体组件以作为子组件。你可以用角色名称来命名该子网格体组件。

> 图片已省略：ImageAltText

选择新的子网格体组件，并将 **细节（Details）** 面板中的 **骨骼网格体资产（Skeletal Mesh Asset）** 属性设置为角色的骨骼网格体。

> 图片已省略：ImageAltText

> [!NOTE]
> 你可能需要使用变换工具调整角色在视口中的位置。

选择新的子网格体组件，然后使用下拉菜单将动画蓝图设置为ABP_SandboxCharacter。

> 图片已省略：ImageAltText

然后，找到组件标签（Component Tag）属性，并使用（**+**） **添加（Add）** 添加新的数组元素。然后，使用元素字段输入以下内容：`RTG_UEFN_to_{your asset’s name}`

> 图片已省略：ImageAltText

### 将你的角色添加到游戏动画控件

在游戏动画示例项目中设置好要使用的角色后，你可以将角色蓝图实例添加到游戏动画控件中，以便运行时在项目中选择和播放你的角色。首先，在 **内容浏览器（Content Browser）** 中找到 **内容（Content）** > **控件（Widgets）** ，然后打开 **游戏动画控件（Game Animation Widget）** 资产。

> 图片已省略：ImageAltText

在控件编辑器（Widget Editor）的设计器（Designer）面板中，**复制** 并 **粘贴** 其中一个角色图标，添加新按钮。

> 图片已省略：ImageAltText

然后，在视口中选择新图标，并打开其 **细节（Details）** 面板。在 **对象（Object）** 属性中，使用下拉菜单选择角色的蓝图。

> 图片已省略：ImageAltText

现在，在编辑器中运行项目时，就可以在游戏动画控件中访问此按钮了。

### 导入MetaHuman

MetaHuman角色需要你执行一些额外的步骤，才能实现精准的高品质结果。如需详细了解如何将自定义MetaHuman角色导入到动画示例项目中，请参阅以下文档：

%samples-and-tutorials/engine-feature-examples/game-animation-sample/metahuman-game-animation-sample:topic%

## 导入动画

动画示例项目包含一套健壮的移动和攀爬动画资产，可供你在自己的项目中使用。你可以在以下位置找到动画序列资产： `Content/Characters/UEFN_Mannequin/Animations` ，选择所需的资产，然后在右键快捷菜单中选择迁移（Migrate）选项，导出资产。选择迁移后，系统将提示你选择项目并选择保存位置。

> 图片已省略：ImageAltText

如需详细了解如何在虚幻引擎项目之间迁移资产，请参阅[迁移资产](../../../understanding-the-basics/assets-and-content-packs/migrating-assets/index.md)文档。

> [!NOTE]
> 你还可以使用 **导出（Export）** 选项，将动画序列资产保存到计算机中虚幻引擎项目之外的位置。

## 动画蓝图

在 **内容浏览器（Content Browser）** 中找到 **内容（Content）** > **蓝图（Blueprints）** > **ABP_SandboxCharacter** ，可以访问用于驱动玩家角色动画系统的主动画蓝图。该蓝图用于驱动所有可选角色网格体，双击资产可将其打开。

### AnimGraph

AnimGraph是运行时控制玩家角色姿势的主要图表。该图表包含Motion Matching节点，以及用于驱动角色动画的补充动画节点。如需详细了解如何使用AnimGraph，请参阅[AnimGraph](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/graphing-in-animation-blueprints/index.md)文档，如需详细了解调试和观察工具，请参阅[动画调试](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-debugging-and-optimization/index.md)文档。

> 图片已省略：ImageAltText

#### 运动匹配

动画示例项目中包含的动画系统基于运动匹配而构建，该动画系统可查询系统，在本例中为角色的运动模型，以便从动画资产数据库中选择动画姿势，从而根据角色的给定位置和动量选择最佳姿势。运动匹配系统使用角色动画蓝图中的Motion Matching节点在运行时选择姿势。

> 图片已省略：ImageAltText

Motion Matching节点使用AnimNode函数执行必要的逻辑来进行选择。你可以打开AnimNode函数图表，方法是选择节点，然后使用细节面板中或节点上On Update字段中标记为 `Update_MotionMatching` 的更新函数旁边的放大镜按钮。

> 图片已省略：ImageAltText

在更新函数中，你可以观察到首先如何使用Evaluate Chooser节点来选择激活的姿势搜索数据库资产，Motion Matching节点将通过该资产选择动画姿势。这是为了限制节点必须搜索的数据，以便控制节点可以选择的结果，并提高系统性能。

> [!NOTE]
> 你可以访问选择器表（Chooser Table）资产，方法是选择Evaluate chooser节点，然后双击选择器表（Chooser Table）属性中的指定资产，或者在内容浏览器中找到以下位置 `Content/Characters/UEFN_Mannequin/Animations/MotionMatchingData/CHT_PoseSearchDatabases`

做出选择后，节点还会运行Update_MotionMatchingPostSelection函数，将选定的姿势搜索数据库资产设置为CurrentDatabase中的激活数据库。

> [!NOTE]
> 你可以前往以下位置访问内容浏览器中的姿势搜索数据库：
>
> `Content/Characters/UEFN_Mannequin/Animations/MotionMatchingData/Databases`

该节点还使用浮点变量输入来设置混合时间，混合时间用于在前一个姿势和所选动画姿势之间进行过渡。

#### Pose History节点

Pose History节点是第二个与运动匹配相关的AnimGraph节点，对于运动匹配发挥作用至关重要。该节点包含对轨迹的引用，或者可以选择性地生成轨迹本身（用于将动画数据与其匹配）和先前姿势数据的缓存（供运动匹配查询使用）。

> 图片已省略：ImageAltText

你可以在该节点中设置姿势的收集频率、先前姿势的可存储数量、我们要从中取样的骨骼列表。

如需详细了解Motion Matching和Pose History节点，请参阅以下文档：


- [运动匹配](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/motion-matching/index.md)

#### AnimGraph说明

下方是动画蓝图AnimGraph中包含的说明内容。

| 节点 | 说明 |
| --- | --- |
| **Motion Matching节点** | Motion Matching节点： 这是运动匹配的主要节点。该节点采用姿势搜索数据库（采用姿势搜索模式），并采用来自Pose History节点的轨迹查询来根据查询选择帧。 此设置具有一些值得注意的额外功能。混合时间（Blend Time）属性绑定了函数，使我们能够根据状态和Gameplay条件动态改变混合时间。 除此之外，我们还有2个应用于节点的"动画节点函数"。此节点更新时，每帧都会调用Update_MotionMatching，而在运动匹配做出选择后，每帧都会调用Update_MotionMatching_PostSelection。 Update_MotionMatching将评估选择器并输出姿势搜索数据库数组，这些数组会被馈送到节点中。这样我们就可以将数据分成多个数据库，并使用选择器来过滤运动匹配可以从哪些数据库中进行选择。 Update_MotionMatching_PostSelection允许我们根据运动匹配的选择执行其他逻辑。目前，我们仅缓存选定的数据库，以便从中获取标签（用于做出其他选择），但将来我们计划使此函数能够根据选定动画更新混合时间或混合配置文件。 双击Motion Matching节点可以打开混合堆栈图表（Blend Stack Graph），这是应用于每个动画的内部图表，我们将在其中处理方向扭曲和转向。 |
| **BlendSpace节点** | Simple Additive Lean： 此节点根据角色的横向加速度使角色向左和向右倾斜。这适用于所有移动动画。一旦将弧线添加到数据库，就需要对此进行调整，以免角色过度倾斜。 |
| **Simple Aim Offset** | Simple Aim Offset： 当摄像机和角色在"Enable_AO"函数中设置的阈值内对齐时，此设置会使角色看向摄像机方向。使用Dead Blending（一种更好的惯性化类型，支持混合曲线），以便每次混入时都可以重置瞄准偏移而不会弹出，从而确保混合始终平滑。否则，在混出时混入偏移会导致混合问题。 |
| **Default Slot节点** | Default Slot节点： 穿梭剪辑片段将通过此节点注入到图表中。 |
| **Offset Root Bone节点** | Offset Root Bone（实验性！）： 当胶囊体运动和动画数据不匹配时，此节点会动态地将偏移应用于根骨骼，以使网格体更加稳定。 对于平移，在移动过程中，根骨骼可以在固定半径内偏离胶囊体，这在起点和枢轴点时最为明显。停止时，偏移将"释放"（混出），以便角色在空闲时停留在胶囊体中心。 对于旋转，根骨骼可以独立于胶囊体旋转，这样旋转完全由根骨骼运动控制，根骨骼运动在Motion Matching节点内转向，以始终与目标对齐。这使得执行更复杂的旋转动画变得更加容易，比如原地转身、起点转身和枢轴点转身。 将在未来版本中修复的已知问题： -平移偏移没有碰撞检查，因此可以嵌入几何体。 -播放剪辑片段时，我们会释放偏移，但是剪辑片段中的"释放"+运动扭曲可能会导致不必要的动作。 -目前偏移插值方式采取的是硬编码。 |
| **Leg IK节点** | Simple Leg IK Process： 该节点会将脚固定到IK脚骨骼位置，通常通过姿势扭曲节点进行扭曲。当在腿部使用混合配置文件时，这也可以改善混合。 |
| **Pose History节点** | Pose History节点： 这是运动匹配所需的第二个主要节点。该节点包含我们用来查询数据的轨迹（在本例中，我们通过生成轨迹函数注入轨迹）。该节点还包含我们对查询进行采样的频率设置，以及我们想要从中采样的骨骼列表。 |

### 动画蓝图事件图表

`ABP_SandboxCharacter` 蓝图使用事件图表来执行逻辑，例如设置AnimGraph用于生成动画姿势输出的变量。

> 图片已省略：ImageAltText

### 动画蓝图函数

下方是玩家角色动画蓝图中包含的函数列表：

| 函数 | 说明 |
| --- | --- |
| `SetReferences` | 此函数将缓存对CBP_SandboxCharacter蓝图和角色移动组件的引用，以供在动画蓝图中使用。此函数还使我们能够使用线程安全属性访问（Thread Safe Property Access）调用。 |
| `UpdateEssentialValues` | 此函数将缓存项目动画系统中使用的必要变量和Gameplay数据，例如角色的变换、移动速度和方向，以及对Gameplay状态进行分类的标签。 |
| `GenerateTrajectory` | 此函数将生成角色的运动轨迹，这是运动匹配系统查询的主要组件，以匹配动画姿势选择。 |
| `UpdateStates` | 此函数将缓存角色所处的所有重要的Gameplay相关状态，并保存最后一帧的值，以便我们能够确定该值何时发生变化。为方便起见，函数将值保存到易于阅读的枚举中，主要用于运动匹配选择器，以筛选运动匹配数据库，只选择当前Gameplay状态中的动作。 |
| `IsMoving` | 此函数可通过查看角色的当前和未来速度（由轨迹生成决定）来设置运动状态枚举，以确定角色是否正在尝试移动、将来会移动或尝试停止、或者将来停止。 |
| `IsStarting` | 此函数可通过检查未来速度是否大于当前速度来确定角色是否开始移动。如果当前数据库资产是枢轴点数据库，则此函数会将IsStarting变量设置为false。这可以防止运动匹配系统中断枢轴点，因为枢轴点的后半部分与起点非常相似。 |
| `IsPivoting` | 此函数将检查检查方向的变化是否大于设定阈值，以确定角色的未来轨迹是否与角色当前轨迹移动的方向有很大不同，从而确认角色是否正在绕轴旋转。旋转模式具有不同的阈值，因为虽然45度绕轴旋转在平移过程中运行良好，但对于定向运动而言未必如此。 |
| `ShouldTurnInPlace` | 此函数可检查根骨骼旋转是否与角色的胶囊体旋转不同，从而确定角色是否在原地转身。在此示例项目中，如果旋转大于50度并且角色当前正在瞄准，则角色应原地转身。我们还允许在角色刚停下来时播放原地转身动画，以实现"甩枪瞄准"行为。 瞄准状态下的原地转身行为仍在开发中。需要对转向或根骨骼偏移节点应用额外的限制，防止角色动作滞后太多。 |
| `JustLandedLight` | 如果角色刚着陆且着陆速度小于重着陆速度阈值，则播放轻着陆动画。 |
| `JustLandedHeavy` | 如果角色刚着陆并且着陆速度大于重着陆速度阈值，则播放重着陆动画。 |
| `JustTraversed` | 此函数用于在混合回移动时选择穿梭动画尾端。例如，如果MovingTraversal动画曲线值大于1，并且默认插槽未激活（混出时插槽不会被激活），则角色必须从移动穿梭动作中混出，因此此函数将返回true，从而允许运动匹配系统选择传送动画的末端以实现更平滑的混合。 |
| `ShouldSpinTransition` | 如果根骨骼旋转和角色的胶囊体旋转有很大差异，此函数将允许播放旋转过渡动画。旋转过渡是一种移动动画，使角色在沿固定世界方向移动时旋转，在切换旋转模式时很有用。 例如，如果角色使用定向运动（Orient to Movement）模式朝摄像机跑去，然后切换到平移，这将要求角色非常快速地旋转180度。旋转过渡动画是此Gameplay场景的理想过渡。目前，我们正在使用重构起点来代替旋转过渡。 |
| `Get_OffsetRootRotationMode` | 此函数用于确定偏移根骨骼旋转模式。该模式使用两个枚举进行控制，枚举根据我们当前是否在默认插槽中播放剪辑片段来设置。如果在默认插槽中设置了剪辑片段，则不需要维持旋转偏移。 释放枚举（Release Enum）本质上是混出偏移，之后它将被锁定到胶囊体旋转，就像没有根骨骼偏移节点一样。 累加枚举（Accumulate Enum）意味着根骨骼将反向旋转对胶囊体旋转的更改，使其看起来独立于胶囊体旋转，从而允许根骨骼运动和转向完全控制其旋转。 |
| `Get_OffsetRootTranslationMode` | 此函数用于确定偏移根骨骼平移（Offset Root Translation）模式。该模式由三个枚举控制，这些枚举是根据一些角色状态设置的。如果我们当前正在默认插槽中播放剪辑片段，如果我们在空中，或者我们没有移动，那就不需要保持平移偏移。 释放枚举（Release Enum）本质上是混出偏移，之后它将被锁定到胶囊体位置，就像没有根骨骼偏移节点一样。 插值枚举意味着允许根骨骼根据根骨骼运动稍微偏离胶囊体位置，但总是会尝试内插回中心。当动画数据和胶囊体运动不完全匹配时，例如在起点、枢轴点和其他复杂运动期间，这很有帮助。 |
| `Get_OffsetRootTranslationHalfLife` | 此函数将控制Root Offset节点可以内插根骨骼平移的速度。当停止时，我们希望非常快速地进行内插，以便总是在胶囊体的中心停止，但是在移动时，我们允许进行略微平滑一些的插值。 |
| `Enable_AO` | 如果角色处于平移模式，并且当前在设定阈值内与摄像机对齐，则此函数会启用瞄准偏移，但在默认插槽中播放剪辑片段时则不会启用。 |
| `Get_AOValue` | 此函数会计算角色根骨骼和摄像机控制旋转之间的旋转差异。差异会被输出至瞄准偏移混合空间。 |
| `CalculateRelativeAccelerationAmount` | 此函数会计算角色的相对加速度量。此值代表相对于Actor旋转的当前加速度或减速度量。该值会被规格化到-1到1的范围，因此-1等于最大制动减速度，1等于角色移动组件的最大加速度。 |
| `GetLeanAmount` | 此函数将利用角色的相对加速度量（通过CalculateRelativeAcceleractionAmount函数计算得出）并根据当前速度缩放其值，以通过叠加倾斜混合空间确定角色应倾斜的角度有多大。 |
| `Update_MotionMatching` | 每当Motion Matching节点更新时，都会调用此动画节点函数。此函数会对选择器资产求值，该资产根据当前Gameplay上下文返回姿势搜索数据库资产的数组。这使我们能够执行更高级别的过滤，让我们更好地控制运动匹配系统能够选择什么动画。 例如，我们在在角色行走时（通过玩家的输入控制）只会在行走数据库中进行搜索，防止运动匹配在角色试图行走时选择跑步。 |
| `Update_MotionMatching_PostSelection` | Motion Matching节点选择动画后，将调用此函数。在这种情况下，我们将缓存所选动画所在的数据库，以便获取EventGraph中的标签（出于线程安全考虑）。如需详细了解系统如何缓存此数据，请参阅CurrentDatabaseTags函数。 将来，我们计划使用此函数根据所选动画控制更多内容，例如混合时间和混合配置文件。 |
| `Get_MMBlendTime` | 此函数用于根据当前和之前的状态改变Motion Matching节点的混合时间。将来，我们计划实现从所选数据库中更直接地设置混合时间。 |
| `Get_MMInterruptMode` | 此函数将确定Motion Matching是在可选数据库发生变化时强制混入新数据库，还是等到发现比当前播放动画开销更低的匹配后再混入，从而控制Motion Matching节点的中断模式。默认情况下，我们不会中断，但是每当核心状态发生变化时，我们知道要开始播放新动画，此时系统就会强制中断。如果角色已开始移动，这可以防止运动匹配系统停留在闲置动画播放中，或者如果角色要停止，则可防止停留在循环动画中，这可以基于连续姿势偏差（Continuing Pose Bias）调整进行。本质上，这使得Motion Matching能够对核心状态的变化做出响应。 |
| `Enable Steering` | 此函数将检查角色是在移动还是在空中，从而确定角色是否可以转向。这可以防止闲置动画发生转向，从而避免造成滑动。 |
| `GetDesiredFacing` | 此函数将计算转向Blendspace节点旋转的目标。此目标是使用预测轨迹的未来朝向计算得出。这使得转向节点可以朝未来方向旋转，而不是始终朝当前Actor的旋转方向转向，后者可能会导致其落后太多。 |

## 角色蓝图

角色蓝图是控制玩家角色其余逻辑和函数的主要蓝图。

> 图片已省略：ImageAltText

角色蓝图包含控制角色移动和Gameplay动作的逻辑，以及将有关角色所处游戏状态的宝贵数据（例如角色跳跃、着陆或执行穿梭动作时）传递给动画蓝图，以进行姿势搜索数据库选择。

> 图片已省略：ImageAltText

如需详细了解如何使用虚幻引擎的 **增强输入（Enhanced Input）** 系统设置输入，请参阅[增强输入](../../../gameplay-systems/input/enhanced-input/index.md)文档。

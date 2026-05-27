---
title: "渲染组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/rendering-components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "渲染的通用功能", "渲染组件"]
---

# 渲染组件

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 渲染的通用功能 / 渲染组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/rendering-components-in-unreal-engine

## 大气雾组件

**大气雾组件（AtmosphericFogComponents）** 用于创建雾效，如场景中的云或大气雾。该组件有多项设置，可影响雾在关卡中的生成方式。

下面通过示例介绍了 **衰减高度（Decay Height）** 设置（用于控制雾的密度衰减高度，例如，较低的值可以让雾变浓，较高的值会让雾变稀，产生更少的散布）。有关详细信息，请参见 **[大气雾用户指南](../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/index.md)** 页面。

| Atmo0.5_4.png | Atmo0.35_4.png |
| --- | --- |
| 密度衰减高度为0.5 (8 km) | 密度衰减高度为0.35 (2.744 km) |
| Atmo1.0_4.png | Atmo1.0_1.png |
| 密度衰减高度为1.0 (64 km)，最大散射为4 | 密度衰减高度为1.0 (64 km)，最大散射为1 |

## 指数高度雾组件

**指数高度雾组件（ExponentialHeightFogComponent）** 也用于创建雾效果，但其密度与雾的高度相关。

指数高度雾在地图中较低的地方产生密度较大的雾，在较高的地方产生密度较小的雾。雾会进行平滑过渡，因此随着你增加高度，不会看到明显的切换效果。指数级高度雾还提供了两种雾颜色，一种颜色用于面向主定向光源的半球体（如果不存在光源，则径直向上），另一种颜色用于相反方向的半球体。

请参见**[指数级高度雾用户指南](../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/exponential-height-fog/index.md)** 了解更多详情及可调整的设置。

## 广告牌组件

**广告牌组件（BillboardComponent）** 是一种2D纹理，始终朝向摄像机，其功能与 **箭头组件（ArrowComponent）** 类似，可用于某种放置方法且能够轻松选取。例如，在下面的雾气薄片中，唯一添加的组件就是 **BillboardComponent**（实际的雾气效果是一个通过脚本动态创建的材质）。

在场景中，你可以通过选择 **BillboardComponent** 图标（一个可以指定的贴图）来控制雾气薄片。

有关如何创建此雾效的示例，请参见 **[雾气薄片和光束](../../../samples-and-tutorials/index.md)** 文档。

## 材质广告牌组件

**材质广告牌组件（MaterialBillboardComponent）** 是一种2D材质，始终朝向摄像机。这类组件可用于表现 2D 草丛或树叶。我们并未使用静态网格体来表现草丛甚至单片草叶，而是用一个带有材质的 **材质广告牌组件** ；这样就无需使用3D模型了，因为广告牌会始终朝向玩家，从而模拟草的三维效果。

## 自定义网格体组件

**自定义网格体组件（CustomMeshComponent）** 能让你指定自定义三角形网格几何体。

## 姿态网格体组件

**姿态网格体组件（PoseableMeshComponent）** 允许你通过 **蓝图** 来控制骨骼变换。

## 贴花组件

**贴花组件（DecalComponent）** 是一种可被渲染到网格体表面上的材质（类似于模型的"保险杠标贴"）。贴花组件可用于任何目的，例如墙上的弹孔，车辆的胎印，地上的血迹等（参见下文示例）。

你可以参考以下页面，了解贴花组件详情。

- 参见

  贴花Actor用户指南

  。
- 参见

  1.1 - 基本贴花

  。
- 参见

  贴花内容范例

  。

## 实例化静态网格体组件

**实例化静态网格体组件（InstancedStaticMeshComponent）** 可以高效渲染同一静态网格体的多个实例。 这类组件尤其适用于程序化创建的场景或房间，因为你不必在场景中放置成百上千个 **静态网格体Actor**，而是只需放置一个 **实例化静态网格体**，就能添加该静态网格体（如地板或墙）的多个实例，性能开销也大大降低。

请在我们的 Wiki 页面上参阅 [**Procedural Room Generation**](https://wiki.unrealengine.com/Videos/Player?series=PLZlv_N0_O1ga0aV9jVqJgog0VWz1cLL5f&video=mI7eYXMJ5eI) 教程，了解 **实例化静态网格体** 组件以及程序化生成随机房间的示例。

## 粒子系统组件

**粒子系统组件（ParticleSystemComponent）** 可以让你添加一个粒子发射器作为其他对象的子对象。**粒子系统组件** 用多种作用，例如，添加爆炸效果或燃烧效果。添加这类组件后，你可以借助脚本访问和设置粒子的效果参数（例如打开或关闭效果）。

例如，下图的安保摄像头添加了一个 **粒子系统组件** 用于产生火花效果。

通过脚本，我们可以指定在默认情况下关闭火花效果，并在摄像头被击中时将其激活。

请参见 [**Cascade粒子系统**](../../../visual-effects/index.md)了解详细信息。

## 后期处理组件

**后期处理组件（PostProcessComponets）** 可以为 **蓝图** 启用后处理控制。它通过 `UShapeComponent` 这个父类来提供体积数据（如可用）。这类组件可以变换场景的色调（前提是场景应用了后处理设置）。例如，假设你定义了一个默认的后处理设置并将其用于游戏，那么在玩家受到伤害（或丧命）时，你可以通过脚本将 **Scene Color Tint** 的设置改为黑色/白色色调。

有关详细信息，请参见 [**后期处理内容示例**](../../../samples-and-tutorials/content-examples-sample-project/index.md)或 [**后期处理效果**](../../post-process-effects/index.md)文档。

## 场景捕获2D组件

**场景捕获2D组件（SceneCapture2DComponent）** 用于从单一平面捕获场景"快照"，并将其发送给渲染目标。它的参数包括：控制 **视场**，指定 **渲染目标** 纹理等等。它的用途包括创建镜子、模拟监视器画面（参见 [**监控摄像机切换按钮**](../../../samples-and-tutorials/index.md)。）

在上面的示例中，我们创建了一个带有 **场景捕获2D组件（SceneCapture2DComponent）** 的 **蓝图** 并指定了一张 **渲染目标** 纹理，它随后被用作 **材质** 指定给场景中的几何体。有关详细信息，请参见 [**场景捕获2D的内容示例**](../../../samples-and-tutorials/content-examples-sample-project/index.md)。

## 场景捕获立方体组件

**场景捕获立方体组件（SceneCaptureCubeComponent）** 可以用 6 个平面捕获场景的"快照"，并将其发送给渲染目标。

在多数情况下，**场景捕获2D组件（SceneCapture2DComponent）** 就能满足大部分场景捕获需求，但在需要对场景进行 3D 捕获时，你可以使用这个组件。但要注意，它会产生很大的性能消耗，只应在绝对必要时使用。请参见 [**反射**](../../../samples-and-tutorials/index.md) 了解场景中反射的不同创建方法。

## 样条线网格体组件

**样条线网格体组件（SplineMeshComponents）** 可用于拉伸和弯曲静态网格体。使用 **样条线网格体组件** 时，你必须提供位置向量，并提供样条曲线起点和终点的切线。在下面的示例中，蓝图包含一个样条线网格体组件，以及一根受到组件影响的 **静态网格体** 管道。

当你指定方位向量以及组件的切线时，你可以使用脚本将它们设置为变量并改为公用（public），以便其可以在编辑器视区中编辑（如下面所示）。

在上述示例中，我们可以单独移动 **Start Transform** 和 **End Transform** 而无需移动整个 Actor，从而随意拉伸或旋转它。该示例及其相关设置可以在 [**蓝图样条内容示例**](../../../samples-and-tutorials/content-examples-sample-project/index.md) 内容示例图中找到。

## 文本渲染组件

**文本渲染组件（TextRenderComponent）** 可以用指定的字体渲染场景中的文本。其中包含与常用字体有关的属性，如缩放比例（Scale）、对齐（Alignment）、颜色（Color） 等。你可以使用该组件提示玩家场景中存在一个可交互对象。

例如，假设你的场景中有一把椅子，玩家在靠近时按一个按键就能坐下。你可以添加一个包含提示文本的 **文本渲染组件** 来执行就坐命令（此时关闭可见性），同时添加一个 **盒体组件（BoxComponent）** 用作触发器，用于在玩家进入时将文本的可见性设为 true（如下所示）。

在玩家进入触发器范围时，游戏将显示 **文本渲染组件** 文本以提示玩家如何坐下。

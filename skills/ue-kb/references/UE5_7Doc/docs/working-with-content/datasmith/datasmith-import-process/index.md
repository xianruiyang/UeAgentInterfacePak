---
title: "Datasmith导入流程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/datasmith-import-process-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith导入流程"]
---

# Datasmith导入流程

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith导入流程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/datasmith-import-process-in-unreal-engine

以下各部分提供了Datasmith在场景转换期间处理的特定问题的详细信息。理解这些问题有助于您理解Datasmith产生的结果以及在虚幻编辑器中处理内容。

## 单位和比例

在虚幻引擎中，所有距离始终用厘米测量。但是，其他3D设计应用程序通常提供计量单位选项。如果您在源应用程序中使用其他计量单位，Datasmith会自动调整场景比例，以使几何结构在虚幻引擎中与真实世界大小完全一致，并且在3D空间中位于正确的位置。您不必更改您在源应用程序中的工作方式。

例如，如果您在源应用程序中使用英寸作为计量单位，在原始场景中长10个单位的物体导入到虚幻引擎中后会变为25.4个场景单位。

|  |  |
| --- | --- |
|  |  |
| 源应用 | 导出后 |

> [!NOTE]
> 当场景层级包含具有不均匀缩放和自定义枢轴变换（在单独对象的层级上补偿校正）的父项时，因为坐标系转换非常复杂，可能会导致虚幻引擎中的结果与初始场景不匹配。若遇到此问题，解决办法是返回原始场景并简化场景层级中的变换。

## 名称和标签

Datasmith检测到源应用程序中的几何结构的相关命名信息，并将该信息尽可能重复用于它所创建的资源和Actor。每个不同的应用程序或文件格式的确切流程会有稍许不同，虚幻引擎中的结果可能与源应用程序稍有不同，但最终目标是使您能够在导入后找到和管理内容。

对于静态网格体，您会看到内容浏览器中的资源名称、磁盘上的资源文件名和关卡中的Actor名称通常不同。

- **内容浏览器标签 -** Datasmith根据它在源文件中找到的命名信息（如果有）在内容浏览器中为每个静态网格体资源生成标签。 某些受支持的应用程序和文件格式允许存在多个同名对象。如果您的场景中是这种情况，您会发现内容浏览器中有多个资源以相同的标签结尾。
- **文件名 -** 但是，磁盘上每个资源的文件名需要唯一。因此，Datasmith使用从源应用程序中抽取的唯一标识符来命名每个资源文件。
- **Actor名称 -** Datasmith每次将Actor放入关卡时，都尝试为该Actor指定与源文件中对应对象（如果有）完全相同的名称。 如果找不到唯一名称，则重用内容浏览器中的相同标签来命名Actor。如果关卡中已经存在另一个具有该名称的Actor，则Datasmith会通过递增数字后缀让Actor名称变得唯一。

例如，在下图中，您会看到源场景中的所有名称原样导入虚幻中，只不过多个对象具有相同的名称。

| 源文件中的层级 | 虚幻中的层级 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/25a53ff9-2c0b-4f8b-9b4e-e36ddbf187fc/datasmith-naming-before.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/8ac22225-db42-44ee-95fa-4e1d30876af9/datasmith-naming-after.png) |

> [!NOTE]
> 请注意，您在内容浏览器中看到的静态网格体资源的 *标签* 与Datasmith为这些资源在磁盘上生成的文件 *名称* 是有区别的。在编辑器中工作时，在大多数情况下这一点应该都是十分明确的。但是，如果您想要使用蓝图或Python脚本来处理资源或Datasmith场景，需要了解这个区别。

## 三角形朝向

为了在运行时达到可能的最佳性能，虚幻会剔除它不希望被看到的任何三角形。这可以避免花费任何GPU循环来渲染这些三角形。尤其是引擎假设所有对象都有一定的厚度。没有朝向摄像机的任何三角形都被假设为在对象的背面，在对象正面时会将它们隐藏。这叫做 *背面剔除*，这是在3D渲染中广泛使用的一种优化方法。

但是，某些设计应用程序不会对表面的正面和背面进行相同的区分，无论您从哪一侧查看都会渲染这些表面。在设计工具中工作时，可能并不会总是知道指定表面的朝向。这可能会引起表面法线，这是垂直于表面的方向，指向内侧，或者远离您需要查看表面的方向。或者，这可能会导致创建完全没有厚度的平面单壁几何结构。

导入场景后，在虚幻引擎中，这可能会导致在从特定角度查看时看不到场景的某些部分。甚至看起来就像模型的这些部分没有导入；但是，原因很可能是表面法线只是指向远离您查看场景的摄像机的方向。如果您围绕着模型旋转，可能会发现这些表面突然出现。

例如，在以下场景（左侧）中，天花板和管道端点似乎缺失，即使已经正确导入了几何结构。为材质启用 **双面（Two Sided）** 选项会让表面出现（请参阅下文了解详细信息）。

![单面](../../../../assets/images/0e/0e112c0fb7ff880d286bd28e2e7aaaad86b6e3d58a704ae13aac8b90ed57c0ea.jpg)

![双面](../../../../assets/images/c6/c69853068b824f3b392152e63aea9c029ee577c167fbf923bd5d2889c4dd9723.jpg)

单面

双面

这种情况最好在源应用程序中进行处理。请记住以下建议：

- 我们强烈建议每当需要从所有面查看有厚度的所有对象时都对这些对象建模，并确保法线朝外。
- 如果您知道对象只需要从一面查看，可以在源应用程序中翻转表面法线并重新导入场景来修复缺失的网格体。这会使表面保留一面，至少调转表面的朝向，这样在虚幻引擎中从您需要的方向查看时能够正确显示。
- Rhino、3ds Max、Cinema 4D和SketchUp等建模应用程序拥有视口模式，便于更轻松地查找背向三角形。详情请参阅建模工具的文档。

但是，如果想要在虚幻编辑器中修复问题，而不回到源场景，还可以考虑以下选项：

- 您可以在静态网格体编辑器中调转三角形的朝向，这样它们可以朝向其他方向。请参阅[建模模式介绍](../../modeling-and-geometry-scripting/getting-started-with-modeling-mode/modeling-mode/index.md)。 但是，如果这些三角形从另一面可见，则同一个问题仍然存在。对于只能从内部看到的天花板等对象，这可能是一种很好的解决方案，但对于两面都能看到的内部墙壁则不然。 需要记住的是，如果您在源场景中修改几何结构的这个部分，然后重新导入Datasmith场景资源，会失去您在静态网格体编辑器中所做的更改。因此如果因为某个原因必须返回并修改几何结构，确保同时返回SketchUp并修复朝向。
- 您可以在材质编辑器中将材质设为两面。这样无论从哪一侧查看表面，引擎都会渲染表面。尽管起初听起来像是一个很好的解决方案，但在与 **静态** 或 **静止** 照明一起使用时往往会产生视觉瑕疵，因为表面的两侧都会在光照贴图纹理中使用相同的空间。 如果材质是材质实例，在材质编辑器的 **细节（Details）** 面板中查找 **常规（General）>材质属性覆盖（Material Property Overrides）>双面（Two Sided）**。

  否则，在材质编辑器的 **细节（Details）** 面板中查找 **材质（Material）>双面（Two Sided）**：
- 如果问题不在于表面可视性本身，而在于穿过对象的光线——如天花板没有正确阻挡来自头顶的直接光线——您可以配置静态网格体Actor，让它从两面投射阴影。 在 **细节（Details）** 面板中寻找 **照明（Lighting）>阴影双面（Shadow Two Sided）** 设置。

  ![Shadow Two Sided](../../../../assets/images/e9/e984f1cab713e314cecfdd6441bf393e63b065e1ba57d93f7abc0beda28c2355.png)

  点击查看大图。

虚幻引擎提供了多种方法来照亮场景。提供最佳运行时性能，通常也能最流畅、最逼真地传播间接照明的方法是 *烘焙* 照明。要在虚幻引擎中使用这种方法，可以将场景中的光源 **移动性（Mobility）** 设置指定为 **静态（Static）** 或 **静止（Stationary）**，然后使用虚幻编辑器中名为[Lightmass](../../../building-virtual-worlds/lighting-the-environment/global-illumination/lightmass-basics/index.md)的工具来为场景构建照明。这样会计算从静态和静止光源照射到场景中每个对象的光线，并将它存储在一种特殊类型的纹理中，叫做 *光照贴图*。运行时，该照明信息从每个对象的光照贴图纹理应用于其表面。

为了使该系统工作，静态网格体中的每个顶点都需要映射到光照贴图纹理2D空间中的唯一坐标。该映射叫做UV集或UV通道。此外，该2D坐标空间的布局应使网格体中的任意两个三角形在2D纹理空间中都不会彼此重叠。如果网格体中的两个三角形映射2D纹理的相同区域，则Lightmass无法存储每个三角形的独特光源和阴影图案。这会导致运行时出现奇怪的光照瑕疵。

为确保所有静态网格体都准备好接收静态照明，Datasmith会对它导入的每个静态网格体自动调用虚幻编辑器的自动UV展开系统。该过程会向每个静态网格体添加两个新的UV集：

- 一个是三角形的简单展开，让网格体在2D空间中形成平面表示。这会将网格体分解成多个较小的"岛屿"，每个表示网格体表面的一个连接部分。
- 然后第一个光照贴图中的岛屿会重新安排和重调大小，以使其形成避免任何重叠的布局，尽量减少浪费岛屿周围的空间。这是您为关卡构建照明时将用于对象光照贴图的最终布局。

然后，Datasmith会自动设置静态网格体资源以使用第二个生成的UV来存储和应用光照贴图。

> [!NOTE]
> 如果您使用3ds Max，并且您已设置想要用于光照贴图的UV通道，请参阅[将Datasmith与3ds Max一起使用](../datasmith-software-interop-guides/3ds-max/index.md)。

## 碰撞和物理

默认情况下，Datasmith不会为它创建的静态网格体资源设置任何物理。您可以在导入后在虚幻编辑器中为静态网格体设置物理；有关详细信息，请参阅[设置与静态网格体的碰撞](../../static-meshes/setting-up-collisions-with-static-meshes/index.md)或[在蓝图和Python中设置与静态网格体的碰撞](../../../production-pipeline/scripting-and-automating-the-unreal-editor/unreal-editor-scripting-tutorials/setting-up-collisions-with-static-meshes-in-blu-428d6644/index.md)。

如果您要使用3ds Max，可以在3ds Max中对自己的定制几何结构建模，并让Datasmith导入程序自动将该几何结构分配到它创建的静态网格体资源。有关详细信息，请参阅[将Datasmith与3ds Max结合使用](../datasmith-software-interop-guides/3ds-max/index.md#%E8%87%AA%E5%AE%9A%E4%B9%89%E7%A2%B0%E6%92%9E%E5%BD%A2%E6%80%81)。

## 光源

Datasmith以支持的文件格式导入光源，并自动将光源转换为虚幻引擎支持的最合适光源类型，通常为[点光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/point-lights/index.md)、[聚光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/spot-lights/index.md)、[矩形光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/rectangular-area-lights/index.md)或[定向光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/directional-lights/index.md)。

### 区域、平面和体积光源

3ds Max和Cinema 4D等应用程序支持从2D形状或3D体积发出的光线。此类光源在虚幻引擎中没有完全对应的相似物。此类光源包括mental ray区域光源、V-Ray和Corona平面光源、圆盘光源、圆顶光源和球面光源等。当Datasmith导入其中一个区域光源时，它使用自定义编写的特殊蓝图类 **DatasmithAreaLightMesh** 来模拟光源的行为。

![区域光源关闭](../../../../assets/images/cb/cb62fe77b855ac97417b2c82cf3bed5726b4c478ec0d2d20ebb856a57ddb975c.jpg)

![区域光源开启](../../../../assets/images/8e/8e8e2702d3afe150ef1ced7b75f6ff9a585fbe8e2663e8e2a1b7ff4a874011ef.jpg)

区域光源关闭

区域光源开启

此蓝图本质上是将自动生成的自发光表面与自动生成的矩形光源、点光源或聚光源配对：

- 自发光表面的作用是表现光源在关卡3D空间中、以及其他表面反射光中的可见物理范围。
- 矩形光源、点光源或聚光源的作用是将实际光线发射到场景中。

可控制自发光的形状、大小、颜色和强度，以及光源Actor的属性。在 **关卡视口** 或 **世界大纲视图** 中选择 **DatasmithAreaLightMesh** Actor，并使用 **细节（Details）** 面板 **光源（Light）** 类目中的设置。例如：

![DatasmithAreaLightMesh settings](../../../../assets/images/19/19827c2eee579281329a439b59beff28c3c6f8e6f741bc7d8a2ba19cff26a76e.jpg)

点击查看大图。

> [!NOTE]
> 颜色（Color）**和**强度（Intensity）** 等设置会同时影响自发光和光源Actor。

使用这种设置时，光源在场景中可见，并会照亮周围的物体。然而，不同于源应用程序中执行的离线渲染，若 **DatasmithAreaLightMesh** 用聚光源或点光源，则DatasmithAreaLightMesh向关卡发出的实际光线将单点投射，而非整面投射。

> [!NOTE]
> 无论使用Lightmass烘焙照明还是动态照明，当前自发光表面都不会将任何光线投射到场景中。只有点光源或聚光源组件才能真正照亮关卡中的周边物体。

## 材质

如Datasmith概述所述，Datasmith导入流程在虚幻引擎项目中创建新的材质资源来表示它在导入场景中识别到的每一组不同的几何结构表面属性。虽然场景变换目标是以可能的最佳保真度继承表面属性，您可能需要在导入后调整这些材质。您可以双击任何材质资源进行编辑。

您可以在 **材质** 文件夹中找到的大部分材质资源都是材质实例。这意味着当您编辑材质实例时，会看到按其父项或"主"材质确定的预先设置的设置列表。例如，下图显示了针对从SketchUp导入的模型创建的材质实例：

![undefined](../../../../assets/images/e6/e652b2f4a58cb24bb81b5d6b0f47abc2727759062df68fe83ac0d77ba3a70e24.jpg)

点击查看全图

有关何谓材质实例以及如何使用材质实例的更多信息，请参阅[实例化材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/instanced-materials/index.md)和[创建和使用材质实例](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/instanced-materials/creating-and-using-material-instances/index.md)。

每种材质实例还有一个父材质：这是一种不同类别的材质资源，包含类似于蓝图的节点图表。该图表确定虚幻引擎需要渲染应用了父材质或其任何材质实例的表面时，对GPU执行的实际操作。构造父材质图表的方法还控制其材质实例中公开的设置，以及这些设置的使用方式。

根据源应用程序，Datasmith按照以下原则为材质实例分配不同的父材质：

- 在大多数情况下，Datasmith为每种材质实例分配一个预先存在的父材质，这个父材质作为Datasmith插件的一部分包含在其中。通常，由这些父材质公开的预定义设置非常类似于源应用程序中提供的材质编写设置。

  您可以自由编辑Datasmith在您的项目中创建的每个材质实例中的这些公开设置。Datasmith提供的每个不同的父材质都提供一组不同的属性：

  - Datasmith_Color -

    该父材质用于纯色和纹理表面，主要在导入CAD模型时使用。请参阅下文的

    Datasmith颜色材质

    。
  - SketchUpMaster -

    该父材质用于从SketchUp导入的所有表面。请参阅

    SketchUp Pro

    。
  - RevitMaster -

    该父材质用于从Revit导入的所有表面。请参阅

    Revit

    。
- 如果要从3ds Max或Rhino导入内容，可能会发现Datasmith也会在项目中的 `Materials/Master` 文件夹中创建新的父材质。3ds Max提供比大多数其他源应用程序更丰富的材质编写工作流程，在概念上类似于虚幻引擎材质图表。因此，Datasmith通常能够创建非常接近于您在3ds Max中的自定义材质的新主材质，而不是必须重用拥有预设置图表和预设置公开设置列表的预设置父材质。 在这种情况下，Datasmith通常仍会为这些自定义父材质创建材质实例。然后它将这些材质实例应用于静态网格体资源和场景中的静态网格体Actor。在大多数情况下，修改材质实例的属性应该足以让您良好地控制渲染结果。 对于某些类型的3ds Max材质，Datasmith可以跳过创建材质实例这一步骤。在该情况下，它只会将新的父材质分配给静态网格体资源和Actor。

如果想要变更材质实例用于确定如何根据这些属性对表面着色的实际材质图表，需要复制父材质并修改副本中的属性。有关该流程的详细信息，请参阅[修改Datasmith主材质](../datasmith-tutorials/modifying-a-datasmith-master-material/index.md)。

如果不使用Datasmith创建的材质，则可以使用另外一个选项，即彻底将Datasmith创建的材质替换为另一个基于物理的材质。这可能是您在虚幻编辑器中自行创建的材质，也可以是来自第三方的材质。

### Datasmith颜色材质

许多计算机辅助设计（CAD）应用程序使用简单的表面颜色来对几何结构着色。Datasmith通常会将这些表面作为 **Datasmith_Color** 材质导入到虚幻中：

![Datasmith Color Material Instance](../../../../assets/images/0d/0d8374ef4f0ccc5c054dfb2e22c6647e9e07dfff5ab1b75d3327c60f664581ab.jpg)

点击查看全图

- 该材质的颜色通常会预设以与源场景的颜色完全匹配。 当您在虚幻引擎中使用这些材质时，特别注意颜色的亮度值。设计工具有时允许非常明亮的表面颜色——甚至包括纯白色——大自然中通常找不到这种颜色。您可能需要大幅降低这些值以便照明看起来更逼真。
- Datasmith通常能够遵从源材质的不透明度。如果源场景中的表面颜色设置为半透明，例如玻璃面板，Datasmith将其不透明度引入到颜色（Color）设置的 **Alpha** 通道。 如果想要使用Alpha通道让之前不透明的材质在虚幻编辑器中变为半透明，则还必须更改材质的混合模式。在 **常规（General）** 部分中，展开 **材质属性覆盖（Material Property Overrides）** 组中，选中 **混合模式（Blend Mode）** 选项，并将其值设置为 **半透明（Translucent）**。
- Datasmith_Color父材质还允许您使用三种不同类别的纹理贴图：漫反射贴图，提供表面的基本颜色（覆盖颜色设置）；法线贴图，提供良好的表面细节；透明贴图，允许同一个表面的不同部分拥有不同的不透明度值。 Datasmith可以使用这些纹理贴图设置，前提是它可以从源应用程序中导出这些类型的纹理贴图。如果您的Datasmith_Color实例拥有平面颜色，而您想要使用这类纹理贴图，以便增加表面的真实度，可能需要激活这些设置并为它们分配纹理资源。 当您启用其中一个贴图设置时，系统会在纹理参数值（Texture Parameter Values）下面为您提供一个新的设置，供您设置想要使用的纹理：

  但是，您最好从头创建自己的材质，这样可以利用其他基于物理的虚幻引擎渲染器属性，这些属性并没有被Datasmith_Color父材质公开，例如粗糙度和金属感属性。请参阅[基于物理的材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/physically-based-materials/index.md)。

## 动画

如果源场景包含具有动画3D变换的对象——平移、旋转和/或缩放值随着时间而更改的对象——Datasmith可以将这些动画导入到虚幻引擎项目中。它创建一个新的关卡序列，其中包含场景中每个动画对象的轨迹，将该关卡序列保存到Datasmith场景资源旁边的 **动画** 文件夹。您可以使用该关卡序列在虚幻编辑器中或在虚幻引擎中在运行时播放动画。

例如，在该3ds Max场景中，将该汽车库门部分动画化，使其会沿着一个样条移动，同时将摄像机动画化以绕着对象旋转。

导入后，您可以双击 **内容浏览器** 中的关卡序列资源以在Sequencer UI中将它打开，并播放动画。

例如，在该视频中，关卡视口（Level Viewport）设置为显示在Datasmith场景中的摄像机的视图，因此动画化结果看起来与3ds Max中的原始视图一样。

关于该工作流程有一些重要的注意事项：。

- Datasmith不会导入任何动画曲线。相反，对于原始源动画中的每一帧，它都会为包含对象当前变换的每个动画对象烘焙一个关键帧。
- Datasmith不处理子对象、网格体变形、对象属性或骨架绑定动画上的动画。它仅处理会更改场景对象在3D空间中的总体平移、旋转或缩放的动画。

有关关卡序列以及如何在Sequencer UI中工作的更多信息，请参阅[Sequencer编辑器](../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)文档。

> [!NOTE]
> 导入动画目前仅支持从3ds Max、Cinema 4D、VRED、Deltagen和glTF文件导入的场景。 （欲了解如何在导出的Datasmith文件中包含3ds Max场景中的动画，请参阅[从3ds Max导出Datasmith文件](../datasmith-software-interop-guides/3ds-max/exporting-datasmith-files-from-3ds-max-to/index.md)。）

### 渲染摄像机动画

若源场景含带动画的摄像机，Datasmith创建的关卡序列将包含虚幻引擎关卡中对应CineCameraActor的轨迹。此轨迹所含的关键帧存储着该摄像机在3D空间中移动和旋转时的3D变换。若在 **世界大纲视图** 中选择该CineCameraActor，并在虚幻编辑器中播放关卡序列，将在关卡视口中看到摄像机的预览窗口播放着从摄像机视角拍摄的动画。

但若要从动画摄像机的视角将关卡序列渲染为磁盘上的电影文件或图像序列，则首先需要向关卡序列添加一个 **摄像机切换（Camera Cut）** 轨迹，并将带动画的摄像机添加到该轨迹。

1. 双击关卡序列将其在序列UI中打开。
2. 点击 **+轨迹（+ Track）** 按钮，然后从菜单选择 **摄像机切换轨迹（Camera Cut Track）**。
3. 点击新 **摄像机切换（Camera Cuts）** 轨迹上的 **+摄像机（+ Camera）** 按钮，选择要使用的摄像机视角。若要使用已在关卡序列中添加动画的摄像机，可从 **现有绑定（Existing Binding）** 列表选择。

   > [!TIP]
   > 若关卡序列包含许多动画轨迹，可能难以在 **现有绑定（Existing Binding）** 列表中找到所需摄像机。若如此，可从 **新绑定（New Binding）** 列表中选择所需摄像机，或从 **世界大纲视图** 将CineCameraActor拖至Sequencer UI中的新 **摄像机切换** 轨迹中。
4. 在摄像机切换轨迹中，该CineCameraActor表示为时间轴上的一个块。必要时，拖动此块的左右边界可调整动画的开头与结尾。
5. 下次渲染关卡序列时，将在摄像机切换轨迹中从摄像机视角渲染每一帧。

> [!TIP]
> 可向摄像机切换轨迹添加多个不同的CineCameraActor，实现在不同时间自动来回切换渲染。

> [!NOTE]
> 详情另请参阅[使用摄像机切换](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-camera-cut-track/index.md)和[渲染过场动画电影](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/take-recorder/index.md)。

### 在多个关卡中使用动画

每个关卡序列包含对单个特定关卡中的Actor的引用。当您使用Datasmith导入包含动画的场景时，关卡序列将包含对该关卡中您导入场景时打开的动画Actor的引用。

如果您稍后将同一个Datasmith场景资源放入其他关卡，关卡序列无法在该新关卡中找到相同的Actor。轨迹名称在Sequencer中显示为红色，在新关卡打开的情况下播放序列不会有任何效果。有一些选项可以修复这个问题：

- 您可以更新关卡序列以指向新关卡中的Actor副本。

  打开新关卡，单击Sequencer工具栏中的常规设置（General Settings）图标，从菜单中选择 **修复Actor引用（Fix Actor References）**。

  > 图片已省略：Fix Actor References

  点击查看全图

  Actor轨迹应该恢复为常规颜色。然后，将更改保存到关卡序列。

  > [!NOTE]
  > 由于关卡序列现在引用新关卡，它现在不适用于原始关卡。它一次只能用于一个关卡。
- 您可以复制内容浏览器中的关卡序列资源，然后再按上述修复其Actor引用。这样，您就有了一个在导入内容的原始关卡中可用的关卡序列，也有一个在新关卡中可用的关卡序列。

  > [!NOTE]
  > 如果重新导入Datasmith场景资源，那么对源场景中的动画所做的更改只会更新到原始关卡序列中。您可能需要重新创建副本并再次修复其Actor引用。
- 如果需要相同的导入关卡序列动画能够在多个关卡中工作，考虑使用 *子关卡*。您可以将Datasmith场景导入到空关卡，然后将该关卡作为子关卡添加到需要播放动画的每个关卡内部。有关具体有哪些子关卡以及如何使用它们的更多信息，请参阅[管理多个关卡](../../../understanding-the-basics/levels/managing-multiple-levels/index.md)。

### 动画时间和帧精度

由于播放会对动画帧率与虚幻引擎每秒渲染帧数之间的不一致进行调整，所以播放包含许多轨迹和关键帧的复杂动画时，可能会发生卡顿和"跳帧"现象。为避免此问题，尽量使播放流畅，Datasmith会固定在创建的关卡序列上启用 **在运行时锁定为显示率（Lock to Display Rate at Runtime）** 属性。

此设置位于 **Sequencer** 的UI中：

> 图片已省略：Lock to Display Rate at Runtime

点击查看大图。

这将提高动画的流畅性。但要注意，此设置会将引擎的最大帧率限制为动画的帧率。若要引擎使用更大帧率，则此法不适用。例如，若动画片段在源应用程序中以每秒24或30帧的速率创建，而该片段需要在VR中以每秒90帧的速率播放，那么将引擎帧率限制为动画帧率则并非良策。此类情况下，需要在关卡序列资源上禁用此选项。

## 图层

如果您的源应用程序让您能够将内容组织为多个图层，或类似的内容，Datasmith会在虚幻编辑器中保留该组织形式。您可以使用 **图层（Layers）** 窗口（**窗口（Window）>图层（Layers）**）来显示和隐藏图层，或者快速找到并选择一个图层中的所有对象。

> 图片已省略：Layers imported by Datasmith

点击查看全图

但是，虚幻编辑器不支持 *嵌套* 图层。如果源场景使用嵌套图层，Datasmith自动将图层的层级展平为一个列表。

有关如何在虚幻编辑器中使用图层的更多信息，请参阅[层级面板](../../../building-virtual-worlds/level-editor/layers-panel/index.md)。

## 元数据

对于某些类型的源文件格式，Datasmith会导入场景中您在源应用程序中设置的几何结构对象的元数据。您可以在虚幻编辑器中使用蓝图和Python脚本访问该元数据。有关该系统的详细信息，请参阅[使用Datasmith元数据](../using-datasmith-metadata/index.md)。

### 技术应用程序特定的元数据

某些第三方应用程序和文件格式提供对场景对象的相关技术元数据值的访问，如它们的唯一ID、对象类或其他应用程序特定数据。Datasmith将该类技术数据导入到它分配给静态网格体组件的组件标记，该组件表示关卡中每个对象的几何结构。

要访问该技术元数据：

1. 选择想要在 **关卡视口（Level Viewport）** 或在 **世界大纲视图（World Outliner）** 中查看其组件标记的Actor。

   > 图片已省略：Select an Actor

   点击查看全图。
2. 在 **细节（Details）** 面板中，选择分配给Actor的静态网格体组件。
3. 在 **细节（Details）** 面板中滚动以找到 **标记（Tags）>组件标记（ Component Tags）** 列表。

   例如，上图显示了从3ds Max导入的对象。其组件标记包含3ds Max中原始对应对象的类和超类、对象的句柄ID和其他特定于3ds Max对象表示方式的信息。

> [!TIP]
> 这类技术信息通常特定于创建该对象的源应用程序。因此，与上一部分所述的Datasmith元数据区分开来。相比之下，Datasmith元数据通常表示关于各个场景对象的"真实世界"信息，例如BIM数据、构造属性、成本，或制造商等；或者表示在生产流程中有特殊含义的用户自定义属性。

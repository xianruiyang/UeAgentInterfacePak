---
title: "Paper 2D Sprite编辑器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper-2d-sprite-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D Sprites", "Paper 2D Sprite编辑器"]
---

# Paper 2D Sprite编辑器

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D Sprites / Paper 2D Sprite编辑器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper-2d-sprite-editor-in-unreal-engine

将 **Sprite** 添加到你的项目后，你可以调整或修改Sprite的大小、[碰撞](../paper-2d-sprite-collision/index.md)或渲染行为。使用 **虚幻引擎** 的 **Sprite编辑器（Sprite Editor）** ，你可以调整角色、对象和[图块](../../paper-2d-tile-sets-and-tile-maps/index.md)Sprite。

要打开Sprite编辑器，请在 **内容浏览器（Content Browser）** 中 **双击** 一个Sprite，或选择多个Sprite， **右键点击** 并在 **快捷菜单（Context Menu）** 中选择 **编辑（Edit）** 来打开多个Sprite。

你可以在此处参考Sprite编辑器的概览图片，其中高亮显示了工具和面板。

![sprite编辑器概览](../../../../../assets/images/a6/a632fcd05a106784e58862ab46d5ef7b91bc26351d88de9ea6c9e4caa6295944.png)

1: [工具栏](#%E5%B7%A5%E5%85%B7%E6%A0%8F)

2: [编辑器模式](#sprite%E7%BC%96%E8%BE%91%E5%99%A8%E6%A8%A1%E5%BC%8F)

3: [Sprite列表](#sprite%E5%88%97%E8%A1%A8)

## 工具栏

你可以在此处参考特有的 **工具栏** 工具，并在Sprite编辑器中处理Sprite时使用它们。

| 工具 | 图标 | 说明 |
| --- | --- | --- |
| **屏幕文本（Scr Tex）** | 屏幕文本开关按钮 | 当你在Sprite编辑器的 **视图（View）** 模式中工作时，可以用它来开关Sprite视口，将当前Sprite在其源Sprite表的上下文中显示。当前Sprite将以高亮显示，而Sprite表中的剩余Sprite将更暗一些。 |
| **其他Sprite（Other Sprites）** | 其他Sprite按钮 | 当你在Sprite编辑器的 **编辑源区域（Edit Source Region）** 模式中工作时，可以用它来开关包含Sprite表中其他Sprite的边界框。 |
| **Sprite名称（Sprite Names）** | sprite名称按钮开关 | 当你在Sprite编辑器的 **编辑源区域（Edit Source Region）** 模式中工作时，可以用它来开关要在视口中覆盖到Sprite上的Sprite名称。 |
| **提取Sprite（Extract Sprites）** | 提取sprite按钮 | 当你在Sprite编辑器的 **编辑源区域（Edit Source Region）** 模式中工作时，可以用它打开“提取Sprite（Extract Sprites）”窗口，从当前Sprite的源Sprite表重新提取Sprite。 |
| **添加盒体（Add Box）** | 添加盒体碰撞按钮 | 当你在Sprite编辑器的 **编辑碰撞（Edit Collision）** 或 **编辑RenderGeom（Edit RenderGeom）** 模式中工作时，可以用它添加 **盒体** 碰撞或渲染边界形状。 |
| **添加多边形（Add Polygon）** | 添加多边形碰撞按钮 | 当你在Sprite编辑器的 **编辑碰撞（Edit Collision）** 或 **编辑RenderGeom（Edit RenderGeom）** 模式中工作时，可以用它添加 **自定义多边形** 碰撞或渲染边界形状。选择 **添加多边形（Add Polygon）** 工具后，你可以在视口中点击，为自定义形状创建新的顶点。Sprite编辑器会自动将新顶点与现有顶点连接。 |
| **添加圆周（Add Circle）** | 添加圆周碰撞按钮 | 当你在Sprite编辑器的 **编辑碰撞（Edit Collision）** 模式中工作时，可以用它来添加 **圆周** 碰撞形状。 |
| **对齐到像素网格（Snap to pixel grid）** | 对齐到像素网格按钮 | 你可以用它将所有碰撞或渲染边界形状顶点对齐到Sprite的像素网格。这有助于真正对齐Sprite以及碰撞和渲染边界形状。 |

## Sprite编辑器模式

Sprite编辑器提供了四种模式，可用于在虚幻引擎中修改和编辑Sprite。

### 视图模式

使用Sprite编辑器的 **视图（View）** 模式，你可以修改Sprite的属性，例如其 **材质（Materials）** 和 **枢轴点模式（Pivot Mode）** 。

![sprite视图模式按钮](../../../../../assets/images/67/67895c755a337fdfa8cadac9813f44b5e6783aa7306055f251ba1cce33392357.png)

#### Sprite编辑器属性参考

你可以在此处参考Sprite编辑器属性及其功能的说明：

> [!NOTE]
> 一些属性只能在特定的编辑器模式中访问。在编辑器和属性说明中都已注明了这些模式限制。如需模式特有属性的说明，请参阅相关的Sprite编辑器模式章节。

![查看sprite编辑器细节](../../../../../assets/images/30/30b3dbeeda5bd1724ccae41be49c90a09ec48dbcceb317d448a1f35f5ebe0d7c.png)

| 属性 | 说明 |
| --- | --- |
| **源UV（Source UV）** | 源纹理或Sprite表中的位置，以像素为单位。 |
| **源尺寸（Source Dimension）** | 源纹理或Sprite表中的尺寸，以像素为单位。 |
| **源纹理（Source Texture）** | 引用源纹理或Sprite表资产。 |
| **其他纹理（Additional Textures）** | 设置占据数字插槽的其他源纹理。这些纹理可以在Gameplay期间使用[蓝图](../../../../blueprints-visual-scripting/index.md)引用和应用。 |
| **默认材质（Default Material）** | 分配在渲染Sprite时要使用的 **默认材质（Default Material）** 。此材质是未分配其他材质时使用的默认材质。 如需详细了解Sprite材质，请参阅[Sprite材质](../paper-2d-sprite-material/index.md)文档。 |
| **每个单位的像素数（Pixels per unit）** | 设置关卡中Sprite的缩放。默认情况下，此属性设置为1，这会相应设置Sprite的大小，使得Sprite的一个像素的大小为 **1** 个 **虚幻单位** （ **厘米** ）乘 **1** 个 **虚幻单位** 。 |
| **枢轴点模式（Pivot Mode）** | 设置Sprite可以围绕它旋转的点。你可以使用控件在Sprite编辑器的视图模式的视口中设置枢轴点。你还可以使用下拉菜单选择预设位置来设置枢轴点。 选择 **自定义（Custom）** 选项后，你可以使用 **X** 和 **Y** 值手动设置 **自定义枢轴点（Custom Pivot Point）** 。 |
| **修剪之前源图像中的原点（Origin in Source Image Before Trimming）** | 引用图集之前源图像中Sprite的原点。 |
| **修剪之前的源图像尺寸（Source Image Dimension Before Trimming）** | 引用修剪之前源图像的尺寸，即 **高度（Height）** （ **X** ）和 **宽度（Width）** （ **Y** ）。 |
| **在源图像中修剪（Trimmed in Source Image）** | 启用后，源文件将使用 **修剪之前源图像中的原点（Origin in Source Image Before Trimming）** 和 **修剪之前的源图像尺寸（Source Image Dimension Before Trimming）** 属性对Sprite进行图集。 |
| **在源图像中旋转（Rotated in Source Image）** | 启用后，源文件将交换 **X** 和 **Y** 尺寸，实际上将Sprite表和所有提取的Sprite **沿逆时针方向** 旋转 **90** 度。 |
| **源纹理尺寸（Source Texture Dimension）** | 引用修剪之后源图像的尺寸，即 **高度（Height）** （ **X** ）和 **宽度（Width）** （ **Y** ）。 |
| **将枢轴点对齐到像素网格（Snap Pivot to Pixel Grid）** | 启用后，Sprite的 **枢轴点** 将对齐到Sprite的像素网格。你可以禁用此属性，设置更精确的枢轴点。 |
| **插槽（Sockets）** | 你可以用它向Sprite **添加（Add）** （ **+** ） **Sprite插槽（Sprite Sockets）** 。Sprite插槽用于将其他对象附加到Sprite的特定位置。创建Sprite插槽后，你可以定义其 **本地变换** 和 **名称** 。然后你就可以在[蓝图](../../../../blueprints-visual-scripting/index.md)中引用和使用Sprite插槽。 |

### 编辑源区域模式

使用Sprite编辑器的 **源区域（Source Region）** 模式，你可以编辑从Sprite表或源文件提取的Sprite。

![编辑源区域按钮sprite编辑器](../../../../../assets/images/27/27dbbd2594e648eb9bcbb86c6968391ec00474ebe8c1f8cd345c67358a2f786a.png)

通过 **点击** 和 **拖动** Sprite的源区域（表示为 **白色盒体** ）的边缘，你可以修改已从Sprite表提取的Sprite的边界。

### 编辑碰撞模式

你可以使用Sprite编辑器的 **编辑碰撞（Edit Collision）** 模式编辑Sprite的碰撞边界。

![编辑碰撞按钮sprite编辑器](../../../../../assets/images/fa/fa9d7f67c5d025f25abfcb38228cd3b7d6bc0e7c212c29a037491b24c63a0236.png)

你可以在此处参考Sprite编辑器的 **编辑碰撞（Edit Collision）** 模式特有的属性及其功能的说明：

| 属性 | 说明 |
| --- | --- |
| **Sprite碰撞域（Sprite Collision Domain）** | 设置Sprite应该使用的碰撞类型。选择 **无（None）** 时，Sprite不会与物理对象产生碰撞，也不会影响其他物理对象。选择 **使用3D物理（Use 3D Physics）** 选项后，Sprite将与对象碰撞，并且其他对象也可以与Sprite碰撞。 **使用3D物理（Use 3D Physics）** 设置将为Sprite编辑器的碰撞设置填充许多属性，你可以用它们微调碰撞属性，适应项目的需要。 |
| **碰撞几何体类型（Collision Geometry Type）** | 你可以在此处设置Sprite周围的碰撞几何体类型，共有以下几种选项： **源边界框（Source Bounding Box）** ：使用Sprite的简单边界框，设置为提取网格的尺寸。 **紧密边界框（Tight Bounding Box）** ：使用紧密贴合Sprite尺寸的碰撞盒体，不包括透明层或背景。 **收缩封装（Shrink Wrapped）** ：使用将贴合Sprite边缘的碰撞盒体，从而切割出Sprite。 |
| **碰撞厚度（Collision Thickness）** | 当 **Sprite碰撞域（Sprite Collision Domain）** 被设置为 **使用3D物理（Use 3D Physics）** 时，此属性设置Sprite的碰撞几何体的挤压厚度。其默认值为 `10`。增加该值会增加挤压的厚度，减小该值会减小厚度。 |
| **碰撞预设（Collision Presets）** | 你可以从碰撞设置预设列表中选择，或选择 **自定义（Custom）** 选项以访问一系列属性。你可以选择以下碰撞设置预设： Sprite有以下表现 **无碰撞（No Collision）** ：禁用与Sprite的碰撞交互。 **全部阻止（Block All）** ：Sprite将充当默认阻止所有Actor的 **WorldStatic** 对象。所有新的自定义通道都将使用其本身的默认响应。 **全部重叠（OverlapAll）** ：Sprite将充当默认与所有Actor重叠的 **WorldStatic** 对象。所有新的自定义通道都将使用其本身的默认响应。 **BlockAllDynamic** ：Sprite将充当默认阻止所有Actor的 **WorldDynamic** 对象。所有新的自定义通道都将使用其本身的默认响应。 **OverlapAllDynamic** ：Sprite将充当默认与所有Actor重叠的 **WorldDynamic** 对象。所有新的自定义通道都将使用其本身的默认响应。 **IgnoreOnlyPawn** ：Sprite将充当默认忽略 **Pawn** 和 **载具（Vehicle）** 对象的 **WorldDynamic** 对象。所有新的自定义通道将被设置为默认值。 **Pawn** ：Sprite将充当 **Pawn对象**，可被当做任意可操作角色或AI的胶囊体使用。 **旁观者（Spectator）** ：Sprite将充当忽略除 **WorldStatic** 对象之外的所有其他Actor的 **Pawn对象** 。 **角色网格体（Character Mesh）** ：Sprite将充当用于 **角色网格体（Character Mesh）** 对象的同等 **Pawn** 对象。所有其他通道将被设置为默认值。 **PhysicsActor** ：Sprite将充当 **模拟（Simulating）** Actor。 **可破坏物（Destructible）** ：Sprite将充当 **可破坏物（Destructible）** Actor。 **InvisibleWall** ：Sprite 将充当不可见的 **WorldStatic** 对象。 **InvisableWallDynamic** ：Sprite 将充当不可见的 **WorldDynamic** 对象。 **触发器（Trigger）** ：Sprite 将充当被用于触发器的 **WorldDynamic** 对象。所有其他通道将被设置为默认值。 **布娃娃（Ragdoll）** ：Sprite将充当 **模拟骨骼网格体组件（Simulating Skeletal Mesh Component）** 。所有其他通道将被设置为默认值。 **载具（Vehicle）** ：Sprite将充当阻止Vehicle、WorldStatic和WorldDynamic的 **载具（Vehicle）** 对象。所有其他通道将被设置为默认值。 **UI** ：Sprite将充当默认与所有Actor重叠的 **WorldStatic** 对象。所有新的自定义通道都将使用其本身的默认响应。 如果选择 **自定义（Custom）** ，可使用额外选项微调Sprite的碰撞属性。[详见上文](#%E7%A2%B0%E6%92%9E%E9%A2%84%E8%AE%BE%E8%87%AA%E5%AE%9A%E4%B9%89%E9%80%89%E9%A1%B9)。 |
| **渲染形状（Render Shapes）** | 你可以在此处向Sprite添加碰撞形状作为动态碰撞边界。你可以根据需要 **添加（Add (+)）** 任意数量的碰撞形状，每个碰撞形状可以使用其属性进行修改。以下属性可按碰撞盒体调整。 **形状类型（Shape Type）** ： |
| **碰撞形状（Collision Shapes）** | 你可以在此处向Sprite添加碰撞形状作为动态碰撞边界。你可以使用工具栏按钮（ **添加盒体（Add Box）** 、 **添加多边形（Add Polygon）** 和 **添加圆周（Add Circle）** ）添加其他碰撞形状。每个碰撞形状将显示为数组，并可以使用其属性进行修改。 以下属性可按碰撞形状调整。 **形状类型（Shape Type）** ：引用碰撞形状的形状类型。 **顶点（Vertices）** ：设置碰撞形状的顶点的 **X** 和 **Y** 位置。 **盒体大小（Box Size）** ：设置形状的 **X** 和 **Y** 尺寸的比例。只有在处理 **盒体（Box）** 或 **圆周（Circle）** 碰撞形状时才可编辑此选项。 **旋转（Rotation）** ：设置碰撞形状的旋转，以度数为单位。 **负缠绕（Negative Winding）** ：启用后，无论顶点顺序如何，碰撞形状的缠绕（即应用顶点位置的顺序）将反转。只有在处理 **多边形（Polygon）** 碰撞形状时才可编辑此选项。 |

#### 碰撞预设自定义选项

| 属性 | 说明 |
| --- | --- |
| **碰撞启用（Collision Enabled）** | 启用后可选择要使用的碰撞方法。你可以从以下选项中进行选择： **无碰撞（No Collision）** ：不会在物理引擎中创建任何表示。不能用于空间查询（光线投射、横扫或重叠）或模拟（刚体、约束）。可能达到最佳性能（尤其是对于移动中的对象）。 **仅查询（无物理碰撞）（Query Only (No Physics Collision)）** ：仅用于空间查询（光线投射、扫描和重叠）。不能用于模拟（刚体、约束）。适用于角色移动和不需要物理模拟的物体。可将数据保持在模拟树之外，获得性能增益。 **仅物理（无查询碰撞）（Physics Only（No Query Collision））** ：仅用于物理模拟（刚体和约束）。不能用于空间查询（光线投射、扫描和重叠）。用于角色上不需要按骨骼检测的摇晃不稳的部分。可将数据保持在查询树之外，获得性能增益。 **启用碰撞（查询和物理）（Collision Enabled（Query and Physics））** ：可以用于空间查询（光线投射、扫描、重叠）和模拟（刚体、约束）。 |
| **对象类型（Object Type）** | 设置Sprite将占据的层。你可以从以下选项中选择： **WorldStatic** **WorldDynamic** **Pawn** **PhysicsBody** **载具（Vehicle）** **可破坏物（Destructible）** |
| **碰撞响应（Collision Responses）** | 切换Sprite针对其碰撞属性和表示属性的特定方面将如何表现，以及它在播放期间的外观。你可以将每个属性切换到 **忽略（Ignored）** 以忽略该属性；切换到 **重叠（Overlap）** ，以允许该属性与Sprite重叠；或是切换到 **阻止（Block）** ，以阻止该属性与Sprite互动。你可以使用以下属性切换其中某个行为： **可视性（Visibility）** ：切换Sprite在运行时期间是否可见。 **摄像机（Camera）** ：切换Sprite是否与 **摄像机（Camera）** Actor碰撞。 **WorldStatic** ：切换Sprite是否与关卡中的 **WorldStatic** 对象碰撞。 **WorldDynamic** ：切换Sprite是否与关卡中的 **WordDynamic** 对象碰撞。 **Pawn** ：切换Sprite是否与关卡中的 **Pawn** 对象碰撞。 **WorldDynamic** ：切换Sprite是否与关卡中的 **WordDynamic** 对象碰撞。 **PhysicsBody** ：切换Sprite是否与关卡中的 **PhysicsBody** 对象碰撞。 **载具（Vehicle）** ：切换Sprite是否与关卡中的 **载具（Vehicle）** 对象碰撞。 **可破坏物（Descructible）** ：切换Sprite是否与关卡中的 **可破坏物（Descructible）** 对象碰撞。 |

### Edit RenderGeom模式

使用Sprite编辑器的 **Edit RenderGeom** 模式，你可以编辑Sprite渲染边界，以校正过度绘制。

![编辑渲染几何体geom按钮sprite编辑器](../../../../../assets/images/08/08e44081d5c574dec63e952af85344204d87d05da490eb201797ff890768e19b.png)

你可以在此处参考Sprite编辑器的 **Edit RenderGeom** 模式特有的属性及其功能的说明：

| 属性 | 说明 |
| --- | --- |
| **渲染几何体类型（Render Geometry Type）** | 选择你想用于在项目中渲染Sprite的渲染几何体类型。你可以从以下选项中选择： **源边界框（Source Bounding Box）** ：此选项将使用与源图像相同尺寸的盒体。如果Sprite是从Sprite表提取的，此渲染几何体会使用相同尺寸的盒体作为提取Sprite的方法。 **紧密边界框（Tight Bounding Box）** ：在Sprite周围使用紧密贴合的边界框，不包括透明区域。 **收缩封装（Shrink Wrapped）** ：创建一个自定义渲染几何体，使用 **避免顶点合并（Avoid Vertex Merging）** 、 **Alpha阈值（Alpha Threshold）** 、 **细节数量（Detail Amount）** 和 **简化Epsilon（Simplify Epsilon）** 属性值贴合Sprite的形状。 **完全自定义（Fully Custom）** ：设置自定义 **X** 和 **Y** 几何体尺寸以渲染Sprite。 **切块（Diced）** ：使用比 **收缩封装（Shrink Wrapped）** 方法更少的顶点，将单个的大正方形渲染几何体拆分为多个较小的正方形，以包括Sprite，同时包含更少的透明背景。 |
| **X轴每个细分的像素数（Pixels Per Subdivision X）** | 允许你在 **X轴** 上设置单个细分的大小（以像素为单位）（使用切块模式时）。 |
| **Y轴每个细分的像素数（Pixels Per Subdivision Y）** | 允许你在 **Y轴** 中设置单个细分的大小（以像素为单位）（使用切块模式时）。 |
| **避免顶点合并（Avoid Vertex Merging）** | 启用后可以避免顶点合并，以便保留额外的顶点。 这是试验性的属性，因此项目不应该依赖其功能。 |
| **Alpha阈值（Alpha Threshold）** | 设置一个值以充当 Alpha（或透明）颜色值的 **忽略阈值**。默认情况下，它被设置为 **0.0** ，意味着只会忽略100%透明的值，你可以增大此属性以忽略透明度更低的Alpha值，值为 **1.0** 时将忽略所有颜色值。 |
| **细节数量（Detail Amount）** | 收缩封装时要考虑的细节数量。0 = 低细节，1 = 高细节。 |

## Sprite列表

你可以使用 **Sprite列表（Sprite List）** 面板访问来自同一个 **源文件（Source File）** 或 **Sprite表（Sprite Sheet）** 的其他Sprite。

**双击** Sprite列表面板中的Sprite，可以在Sprite编辑器中打开另一个Sprite。

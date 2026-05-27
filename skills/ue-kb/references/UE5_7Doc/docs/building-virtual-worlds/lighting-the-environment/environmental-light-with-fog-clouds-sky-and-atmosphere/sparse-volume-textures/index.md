---
title: "稀疏体积纹理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sparse-volume-textures-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "雾、云、天空和大气的环境光源", "稀疏体积纹理"]
---

# 稀疏体积纹理

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 雾、云、天空和大气的环境光源 / 稀疏体积纹理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sparse-volume-textures-in-unreal-engine

**稀疏体积纹理** （SVT）是将纹素（体素）存储在3D数据结构中的一种纹理。你可以使用三维UV坐标对SVT的数据建立索引，类似于3D纹理和体积纹理。不同于标准（密集）体积纹理，SVT仅在包含"感兴趣"数据的体积区域（存在体素数据的地方）上耗费内存，使大得多的体积，或是具有相同范围的体积，消耗的内存比标准（密集）体积纹理更少。

## 稀疏体积纹理的类型

你可以使用静态或动画体积表示稀疏体积纹理。静态SVT是单个体积，而动画SVT是可以播放的体积（或帧）序列，类似于图像序列视图动画。

> 动图已省略：静态和动画SVT的示例。

左：静态单体积SVT；右：动画SVT。

> [!NOTE]
> 这些SVT使用异类体积Actor渲染。如需详细了解用法信息，请参阅[异类体积](../heterogeneous-volumes/index.md)。

## 稀疏体积纹理的构成

稀疏体积纹理由多个纹理构成。其中包括 **页表（Page Table）** 纹理，它可以被间接传递到构成体积的 **物理图块数据（Physical Tile Data）** 纹理中。这些图块数据纹理会存储体积的纹理数据，并且最多可以使用两个纹理来存储体积的数据和属性，即属性A和属性B。

属性A和属性B各自使用RGBA纹理通道来存储数据，为你提供最多8个数据存储通道。数据通过纹理查找来检索——它为页表进行一次查找，为每个物理图块数据进行一次查找，共进行2-3次查找，具体取决于SVT。这意味着，SVT让两个物理图块数据纹理共享一次页表查找，页表与图块数据纹理并非一一对应关系。

SVT的两个图块数据纹理（属性A和属性B）可以有不同的像素格式，即16位、32位和8位unorm。当你不使用某个属性列表中的某个RGBA纹理通道时，会尝试使用通道较少的像素格式。如果你不使用通道，纹理不会耗费内存。

| 纹理格式 | 纹理 | 虚幻引擎表示 |
| --- | --- | --- |
| **页表（Page Table）** | 页表 | 页表UE表示 |
| **物理3D图块** | 物理3D图块 | 物理3D图块UE表示 |

## 稀疏体积纹理的查看方式

稀疏体积纹理的查看方法如下：

- 体积域材质

  - 异类体积Actor
  - 体积雾
  - 体积云
- 稀疏体积纹理查看器

## 异类体积Actor和组件

异类体积是可放置的Actor，通过在体积域材质中整合稀疏体积纹理材质节点来利用SVT。此Actor类型使用其材质中的逻辑设置渲染SVT及其属性。异类体积Actor还可以播放和循环动画SVT，而无需额外设置。

异类体积渲染在一定程度上受到实时体积的延迟渲染功能限制。但是，[路径追踪器](../../ray-tracing-and-path-tracing-features/path-tracer/index.md)提供了对渲染体积的更完整支持，例如准确模拟散射、阴影和全局光照。

> 动图已省略：使用异类体积渲染的SVT爆炸

使用异类体积Actor渲染的SVT材质的示例。

关于用法和设置的更多信息和详情，请参阅[异类体积](../heterogeneous-volumes/index.md)。

### 体积雾

将SVT的体积域材质应用到网格体时，SVT支持[体积雾](../volumetric-fog/index.md)，这是一种指数高度雾功能。SVT的细节数量可以高于体积雾的分辨率，因此此方法的结果与你在异类体积上看到的效果可能会有所不同

![渲染为体积雾的SVT。](../../../../../assets/images/4b/4be5f2682b0af64c5ce8fe87e7b4769d6af3feb590d51adee422f5b80ae411e5.jpg)

左：显示SVT的异类体积Actor；右：应用到网格体并使用体积雾渲染的SVT材质。

要使用SVT材质设置体积雾，请参阅此页面的[在体积雾上查看稀疏体积纹理](#%E5%9C%A8%E4%BD%93%E7%A7%AF%E9%9B%BE%E4%B8%8A%E6%9F%A5%E7%9C%8B%E7%A8%80%E7%96%8F%E4%BD%93%E7%A7%AF%E7%BA%B9%E7%90%86)小节。

### 体积云

将SVT的体积域材质应用到异类体积Actor时，它自动支持[体积云](../volumetric-cloud-component/index.md)。

![使用异类体积Actor渲染的SVT云示例](../../../../../assets/images/c3/c36e0efbd54f584bb4c03343655703099bc5a96c0d0f2a4788ba4c70e314069c.jpg)

### 稀疏体积纹理查看器

> [!NOTE]
> 稀疏体积纹理查看器作为预览器时最有用，但没有针对其余使用场景进行过优化，其查看效果可能不够理想。因此，最好的做法是创建一个能够恰当显示SVT的材质，并将其应用到[异类体积](../heterogeneous-volumes/index.md)，或使用[稀疏体积纹理的查看方式](#%E7%A8%80%E7%96%8F%E4%BD%93%E7%A7%AF%E7%BA%B9%E7%90%86%E7%9A%84%E6%9F%A5%E7%9C%8B%E6%96%B9%E5%BC%8F)小节下提到的某个方法。

**稀疏体积纹理查看器（Sparse Volume Texture Viewer）** 可用于直接预览SVT，而无需设置材质。你可以使用查看器预览SVT的单独属性纹理通道并播放动画（如有）。所以查看器非常适合用于快速调试SVT资产，而无需进行任何设置。

要使用SVT查看器，请执行以下步骤：

1. 将

   稀疏体积纹理查看器（Sparse Volume Texture Viewer）

   从

   放置Actor（Place Actors）

   面板拖放到场景中。
2. 在

   细节（Details）

   面板中，将SVT资产分配给

   稀疏体积纹理预览（Sparse Volume Texture Preview）

   分配插槽。

SVT就会出现在查看器中。

![SVT预览器](../../../../../assets/images/f1/f15ebacb9994c878963c58f8e9e3038a07271d25e56b45225a2818f7ab051ab8.jpg)

> [!TIP]
> 通过调整 **消光（Extinction）** 属性的值，设置体积吸收光线的程度，即可调整体积的可见程度。

对于有多个帧的SVT，勾选 **播放（Playing）** 和 **循环（Looping）** 复选框可循环播放SVT的帧。**帧率（Frame Rate）** 属性可指定它每秒应该播放多少帧（fps）。预览器默认设置为24fps。如果不勾选"制作动画"属性，你可以使用 **帧（Frame）** 属性值在SVT的各帧中来回切换。

> 动图已省略：显示静态和动画SVT的SVT预览器。

左：不带动画的SVT预览；右：循环播放动画帧的SVT预览。

SVT查看器一次只显示一个纹理通道。这适用于检查SVT资产的单个通道，体积纹理中存储的数据将决定其效果的好坏。导入的速度数据会显示为密度，并将返回意外结果。

你可以使用 **预览属性（Preview Attribute）** 选择框选择想要预览的属性通道。默认会使用第一个通道 **属性A红色（AttributesA Red）** 。

稀疏体积纹理查看器有以下属性：

![SVT预览器设置](../../../../../assets/images/0f/0f315a824f47d1c3ed9d0474aefa7cf35deea101f053908107d94ebdb843d8d7.jpg)

| 属性 | 说明 |
| --- | --- |
| 资产预览 |  |
| **稀疏体积纹理预览（Sparse Volume Texture Preview）** | 要用于预览器的SVT资产。 |
| **阻止流送请求（Blocking Streaming Requests）** | 告知SVT流送管理器在发出所有流送请求后立即阻止（等待）它们。关于有效使用此属性的更多信息，请参阅[流送性能说明](#%E6%B5%81%E9%80%81%E6%80%A7%E8%83%BD%E8%AF%B4%E6%98%8E)小节。 |
| **应用按帧变形（Apply Per Frame Transforms）** | 应用附加到给定稀疏体积纹理帧的变形。该变形是相对于稀疏体积纹理查看器组件的变形而言的。 |
| **质心枢轴（Pivot at Centroid）** | 将枢轴移动到体积的中心。请注意，变形时枢轴位于原点，原点通常位于体积的某个内角，具体位置取决于变形方式。强制将枢轴点移动到体积中心可能破坏变形。 |
| **体素大小（Voxel Size）** | 统一应用到所有体素的缩放比例。该方法可以快速缩放整个体积，便于调试缩放相关的问题。 |
| **预览属性（Preview Attribute）** | 选择所预览的属性。即使单个SVT中包含多个属性，一次也只能预览一个属性。 如果属性A或属性B的Alpha通道被设置为 ，在查看器中预览时，你可能会看到黑色的斑驳视觉效果。这是因为，GPU通常对不存在的纹理通道返回0，但Alpha通道除外，这种情况默认返回1。将其设置为通常不会产生问题，因为该通道本质上是未定义的。 |
| **Mip级别（Mip Level）** | 设置查看SVT的mip级别。 |
| **消光（Extinction）** | 设置体积的不透明程度。消光是吸收（光线击中粒子并被吸收）和散射（光线击中粒子并散射/反弹到无法到达摄像机的各个方向）的总和。值越高，外观越不透明。 |
| 动画 |  |
| **帧（Frame）** | 输入值或拖动滑块以推移动画SVT的帧。在禁用 **播放（Playing）** 时，可编辑此属性。 |
| **帧率（Frame Rate）** | 指定此SVT动画的播放帧率。例如，24、30、48、60。在启用 **播放（Playing）** 时，可编辑此属性。 |
| **播放（Playing）** | 切换预览器是否要在SVT资产有多个帧时循环播放这些帧。 |
| **循环（Looping）** | 在启用 **播放（Playing）** 时循环播放动画。 |
| **反向播放（Reverse Playback）** | 在启用 **播放（Playing）** 时向后播放动画SVT的帧。 |

## 使用稀疏体积纹理

你可以从[VDB（即体素数据库）](https://en.wikipedia.org/wiki/OpenVDB#What_does_VDB_stand_for)文件导入稀疏体积纹理。此格式广泛用于存储稀疏体积数据。VDB数据在被导入虚幻引擎中时会转换为稀疏体积表示。

VDB文件包含所谓的"网格"，这是体积的另一种说法。这些网格可以有不同类型的组件，例如密度、速度和温度。SVT支持导入以下类型的网格：Float（float、float2、float3、float4）、Double（double、double2、double3、double4）和Half（half、half2、half3、half4）。由此生成的SVT分辨率是所有导入的网格的尺寸的并集。

> [!NOTE]
> 虽然虚幻引擎支持导入所有类型的VDB，但SVT目前不支持double格式。数据会在导入时转换为8/16/32位。

每个网格也可以有自己的变形。VDB格式支持多种变形类型，包括透视/平截头体转换。虚幻引擎目前支持缩放、旋转和平移变形。各帧中的变形可以各不相同，因此导入的SVT可以在其动画时间轴上缩放/选择/平移。

> [!NOTE]
> 虽然各帧中的变形可以各不相同，但单个给定帧中的所有网格使用的变形应该是一致的。

### 导入VDB文件

你可以执行以下某个操作以导入VDB文件：

- 将VDB直接拖放到内容浏览器中。
- 使用内容浏览器中的

  导入（Import）

  按钮。

VDB有自己的导入窗口，用于导入静态和动画VDB文件。

> [!NOTE]
> 在导入动画VDB文件时，若其名称除编号帧之外其他部分都相同，你可以从动画序列导入任一文件，导入器会将其识别为属于VDB序列。如果你选中动画VDB序列中的所有文件并同时全部导入，每个文件都会创建其自己的序列，从而创建多个完全相同的动画SVT。

| VDB导入选项静态 | VDB导入选项动画 |
| --- | --- |
| SVT导入选项：静态单帧VDB | SVT导入选项：动画VDB序列 |

导入选项包括以下信息和设置：

| 属性 | 说明 |
| --- | --- |
| **导入静态/动画（Import Static / Animated）** | 显示所导入的VDB的类型，即静态或动画。 |
| **当前资产（Current Asset）** | 所导入的VDB的文件路径。 |
| **导入序列（Import Sequence）** | 将多个按顺序标记的VDB文件导入为单个动画稀疏体积纹理序列。 若导入的源文件属于按顺序编号的序列VDB文件（file0.vdb、file1.vdb、file2.vdb，以此类推），则会创建动画SVT。导入器会自动检测文件是否为序列的一部分，并勾选 **导入序列（Import Sequence）** 复选框。 |
| **属性A（Attributes A）** | 允许用户将源网格中的单独通道分配给生成的SVT的（RGBA）通道。每个属性表示页表纹理读取的图块数据纹理。此属性旁边的格式下拉菜单用于选择每个图块数据纹理应该使用的格式类型，例如16位float、32位float和8位unorm。8位unorm用于位于0到1区间内的数据或属性。 |
| **属性B（Attributes B）** | 显示源文件中存在的网格，并允许用户将源网格中的单独通道分配给生成的SVT的（RGBA）通道。每个属性表示页表纹理读取的图块数据纹理。此属性旁边的格式下拉菜单用于选择每个图块数据纹理应该使用的格式类型，例如16位float、32位float和8位unorm。8位unorm用于位于0到1区间内的数据或属性。 |
| **源文件网格信息（Source File Grid Info）** | 显示关于要导入的VDB文件网络的信息，例如指定的索引、类型和尺寸。 |

> [!NOTE]
> 导入和创建SVT所需的时间取决于源VDB文件的尺寸和帧数。

导入过程中会创建 **稀疏体积纹理（Sparse Volume Texture）** 资产。打开文件会显示相关信息，例如其体积的分辨率、Mip级别数量、帧数，等等。

![稀疏体积纹理资产编辑器](../../../../../assets/images/b1/b151b05241680bf770fa78b75e3c75df570765842050f16f7ea15f63dfd19460.png)

> [!NOTE]
> 更改采样器寻址/平铺方法可能需要一些时间，因为它必须重新生成运行时SVT数据。

### 在材质中使用稀疏体积纹理

材质可以使用 **Sparse Volume Texture Object** 和 **Sparse Volume Texture Sample** 节点对稀疏体积纹理进行采样。

![SVT材质节点](../../../../../assets/images/bc/bc0253ab307a8990e31fc5700db215e8ed7a4611c852d8d733f763f630029385.jpg)

你可以将SVT用于[异类体积](../heterogeneous-volumes/index.md)和[体积云](../volumetric-cloud-component/index.md)。它们的材质设置方法类似，即将材质域设置为 **体积（Volume）** 并将其混合模式设置为 **累加（Additive）** 。

**Sparse Volume Texture Sample** 节点接受一些UV坐标（必须为三维），并从属性A和属性B输出引脚检索生成的数据（其类型均为float4）。你可以将SVT用作材质图表中的参数，并可以在任何类型的材质中对其采样。但是，它们最适合用于将材质域设置为体积的材质，例如异类体积、体积雾和体积云材质。

下面是对SVT进行采样的体积材质的示例。它基于世界空间位置计算3D UV坐标——此逻辑并不是SVT特有的，且是可选的。如果UV输入引脚未被分配，将使用下图所示的相同逻辑自动计算UV。SVT的材质节点有两个Float4输出（属性A和属性B），但此示例中只使用了第一个通道，因为它包含所使用的SVT的密度。

![undefined](../../../../../assets/images/f7/f76c4f3aabbb05e5d1c38dba3adefe66db4c608a9cf065cc6c9b289b71440c26.jpg)

该示例是你在对材质中的稀疏体积纹理进行采样时所能使用的最简单的设置。

#### 稀疏体积纹理UV坐标

稀疏体积纹理使用三维UV坐标采样。标准2D纹理一样，UV空间在所有三个维度（XYZ）中从0延伸到1。UV空间沿体积分辨率属性延伸，你可以在打开SVT资产时检查该属性。

UV空间被定义为单独帧的边界框的并集。因此，在设置材质逻辑时不需要考虑边界框的大小，因为不同帧上使用的相同UV坐标将在同一个世界空间体素中建立索引。

此外，你还可以使用 **Texture Property** 节点查询纹理大小和纹素大小，其方法与2D纹理相同。你还可以通过蓝图查询SVT的体积。

#### 稀疏体积纹理节点Mip值

与其他纹理样本节点类似，Sparse Volume Textures Sample节点支持Mip值。

![Sparve Volume Texture Node Mip Values Settings](../../../../../assets/images/6c/6c80381d38b80a2b5e82ed8a32a2a69de4d5a16f2acc911cdfe0741c081e1449.jpg)

#### 引擎源稀疏体积材质示例

虚幻引擎内有已经设置好的空示例SVT材质，你可以对其应用SVT资产。你可以在内容浏览器的 **引擎（Engine）> 引擎材质（Engine Materials）** 下找到它，其名为 **SparseVolumeMaterial** 。复制此材质并创建其实例。

打开材质实例后，重载 **SparseVolumeTexture** 参数，并将你自己导入的SVT资产应用到分配插槽。

### 在异类体积上查看SVT

要将SVT用于异类体积，请执行以下步骤：

1. 将

   异类体积（Heterogeneous Volume）

   Actor添加到场景。
2. 在

   细节（Details）

   面板中，找到

   材质（Materials）

   分段。
3. 将基于SVT的材质分配给

   元素0（Element 0）

   插槽。

如需关于使用异类体积及其属性的更多信息，请参阅[异类体积](../heterogeneous-volumes/index.md)。

### 在体积雾上查看稀疏体积纹理

要将SVT用于体积雾，请执行以下步骤：

1. 将

   指数高度雾（Exponential Height Fog）

   添加到你的场景。
2. 在

   细节（Details）

   面板中，启用

   体积雾（Volumetric Fog）

   。
3. 将SVT材质应用到网格体。

   > [!NOTE]
   > 如果你需要网格体，可以使用 **放置Actor（Place Actors）** 面板的 **形状（Shape）** 类别下的 **立方体（Cube）** 形状。

由于SVT的细节数量可以高于体积雾分辨率，你可能需要放大网格体才能获得更好的效果。此外，你还可能需要使用以下控制台变量提高体积雾的分辨率：

- r.VolumetricFog.GridPixelSize 4

  （默认值为8）
- r.VolumetricFog.GridSizeZ 256

  （默认值为128）

### 播放动画稀疏体积纹理

播放动画SVT需要将[材质实例动态](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/instanced-materials/unreal-engine-material-instance-editor-ui/index.md)（MID）和蓝图。SVT动画使用其材质中的 **Sparse Volume Texture Parameter** 节点驱动。这样就可以每次更新时换出SVT参数，因为动画SVT的每个帧本身都是一个静态SVT。

在设置逻辑，为SVT制作动画时，有两个部分要考虑：

- 事件BeginPlay构造了动画稀疏体积纹理控制器，这是具有播放动画SVT的功能的类。为了实现这一点，它可以从分配的SVT中提取帧。提取出的帧还实现了SVT着色器接口，并且本身可以被绑定到SVT材质参数。需要一个MID，以便更新SVT参数。
- 事件更新需要调用控制器变量的更新，它获取当前帧并将其应用到材质实例动态中的Sparse Volume Texture Parameter节点。

> [!NOTE]
> 下面的示例演示了如何设置SVT材质并将其应用到网格体，以及如何使用体积雾渲染它。这只是一个工作流程示例。如果你想使用体积云或其他需要使用动画SVT的用例，则需要将MID分配给用于渲染材质的Actor或组件。例如，对于云材质，你需要更新体积云组件的云材质。
>
> 异类体积是一个例外，因为其组件已经实现了所有这些逻辑，你只需要使用SVT参数创建材质，并将动画SVT分配给它。异类体积组件会在后台自动创建MID，以便更新SVT参数。

要设置用于体积雾的材质实例动态构造蓝图逻辑，请执行以下步骤：

1. 在你的SVT材质中，使用图表中的

   Sparse Volume Texture Sample Parameter

   节点。
2. 创建一个

   Actor蓝图（Actor Blueprint）

   。
3. 在

   组件（Components）

   面板中，点击

   添加（+）

   按钮，并从列表选择

   立方体（Cube）

   网格体。
4. 在

   事件图表（Event Graph）

   中，从

   Event BeginPlay

   节点拖出引脚，并添加

   Construct Object from Class

   节点。
5. 在

   Construct Object from Class

   节点上，将类设置为

   动画稀疏体积纹理控制器（Animated Sparse Volume Texture Controller）

   。
6. 在

   Construct Object from Class

   节点上，右键点击

   返回值（Return Value）

   并选择

   提升到变量（Promote to Variable）

   。
7. 在

   我的蓝图（My Blueprint）

   面板的

   组件（Components）

   下，将

   NewVar

   重命名为“Controller”。
8. 从

   Set Controller

   节点拖出引脚，并添加

   Set Sparse Volume Texture

   节点。
9. 将

   Set Controller

   节点的输出引脚连接到

   Set Sparse Volume Texture

   节点的

   目标（Target）

   输入。
10. 在

    Set Sparse Volume Texture

    节点上，右键点击

    稀疏体积纹理（Sparse Volume Texture）

    引脚并选择

    提升到变量（Promote to Variable）

    。
11. 在 **我的蓝图（My Blueprint）** 面板的 **组件（Components）** 下，点击 **稀疏体积纹理（Sparse Volume Texture）** 变量。在 **细节（Details）** 面板的 **默认值（Default Value）** 下，设置 **稀疏体积纹理（Sparse Volume Texture）** 。

    > [!WARNING]
    > 若将 **稀疏体积纹理（Sparse Volume Texture）** 插槽留空，会导致SVT材质无法更新及播放动画。
12. 从 **Set Sparse Volume Texture** 节点拖出引脚，并添加 **Play** 节点。

    > [!NOTE]
    > Play节点会导致控制器在你每次调用控制器的Update()时更新内部定时器。此定时器定义了在提取当前帧时哪个帧会被视为"当前"。还有可以控制SVT的播放的Pause和Stop节点。
13. 在

    Set Controller

    节点上，拖出控制器的输出引脚，并将其连接到

    Play

    节点上的

    目标（Target）

    引脚。
14. 从

    Play

    节点拖出引脚，并添加

    Create Dynamic Material Instance

    节点。
15. 在

    Create Dynamic Material Instance

    节点上，将

    父节点（Parent）

    下拉菜单设置为你的

    SVT材质（SVT Material）

    。
16. 在

    Create Dynamic Material Instance

    节点上，右键点击

    返回值（Return Value）

    引脚并选择

    提升到变量（Promote to Variable）

    。
17. 在

    我的蓝图（My Blueprint）

    面板的

    组件（Components）

    下，将

    NewVar

    重命名为“MID”。
18. 拖出

    Set MID

    节点的返回值引脚，并添加

    Set Material (Cube)

    节点。

此部分蓝图逻辑当如下图所示：

> 图片已省略：undefined

点击查看大图。

要设置蓝图逻辑以播放SVT的每个帧，请执行以下步骤：

1. 在

   我的蓝图（My Blueprint）

   面板的

   组件（Components）

   下，将

   控制器（Controller）

   变量拖入图表中，并选择

   获取控制器（Get Controller）

   。
2. 从

   Controller

   节点拖出引脚，并添加

   Update

   节点。
3. 将

   事件更新（Event Tick）

   执行引脚连接到

   更新（Update）

   。
4. 将

   事件更新增量秒数（Event Tick Delta Seconds）

   引脚连接到

   Update

   节点的

   增量时间（Delta Time）

   引脚。
5. 从

   Update

   节点拖出引脚，并添加

   Get Current Frame

   节点。
6. 从

   Controller

   节点拖出引脚，并将其连接到

   Get Current Frame

   节点上的

   目标（Target）

   引脚。
7. 在

   我的蓝图（My Blueprint）

   面板的

   组件（Components）

   下，将

   MID

   变量拖入图表中，并选择

   获取MID（Get MID）

   。
8. 从

   Get MID

   节点拖出引脚，并添加

   Set Sparse Volume Texture Parameter Value

   节点。
9. 拖出

   Get Current Frame

   节点的

   返回值（Return Value）

   引脚，并将其连接到

   Set Sparse Volume Texture Parameter Value

   节点的

   值（Value）

   引脚。
10. 在

    Set Sparse Volume Texture Parameter Value

    上，将

    参数名称（Parameter Name）

    设置为你的SVT材质中的

    稀疏体积纹理示例参数（Sparse Volume Texture Sample Parameter）

    的名称。

此部分蓝图逻辑当如下图所示：

> 图片已省略：undefined

点击查看大图。

当你 **模拟（Simulate）** 或 **在编辑器中运行（Play-in-Editor (PIE)）** 时，SVT应该循环播放其动画。

> 动图已省略：稀疏体积纹理动画体积雾示例

用于体积雾的动画SVT。

> [!TIP]
> 要获得较好的效果，你可能需要做以下调整：
>
> - 在蓝图中，在使用体积雾时调整网格体的大小，获得更好的体积分辨率。上面的示例将立方体网格体放大到了原始大小的20倍。
> - 在SVT材质中，将更高的乘法值用于最后一次乘法，然后再插入消光输入。上面的示例使用了7.5而不是原始值2.5。

除了上面的示例所展示的操作之外，你还可以执行以下操作：

- 使用控制器上提供的其他函数直接设置帧索引或当前时间。
- 通过调整控制器的帧率属性来配置播放速度。默认值为24fps。
- 除了仅获取当前帧外，你还可以使用

  Get Current Frames For Interpolation

  函数返回两个最近的帧以及一个内插在它们之间的、0到1之间的值。你可以利用此方法创建两个SVT参数、一个用于Lerp Alpha的标量参数，然后使用材质图表中的插值节点。

#### 将动画稀疏体积纹理用于Sequencer

使用在之前的小节中创建的动画SVT蓝图，你可以将其扩展，并使用Sequencer控制其播放。你将创建一个被设置为"公开到过场动画"的新变量，并替换部分事件更新逻辑。此工作流程类似于[使用Sequencer控制骨骼网格体动画蓝图](../../../../animating-characters-and-objects/cinematics-and-movie-making/cinematic-workflow-guides-and-examples/control-animation-blueprint-parameters-from-sequencer/index.md)的方式。

要扩展动画SVT蓝图并使用Sequencer控制其播放，请执行以下操作：

1. 打开你的动画SVT蓝图。
2. 在"我的蓝图"面板的"组件"下，将控制器变量拖放到图表中，并从列表选择Get Controller。
3. 从Get Controller节点拖出引脚，并添加Get Duration节点。
4. 将Event Tick节点的执行引脚连接到Get Duration节点。
5. 从Get Duration节点并使用Sequencer控制其播放，并添加Set Time节点（在"动画稀疏体积纹理控制器"类别下）。
6. 将Get Controller节点连接到Set Time节点的目标引脚。
7. 拖出GetDuration节点的返回值引脚，并添加Multiply节点。
8. 拖出Multiply的输出引脚，并将其连接到Set Time节点的时间输入引脚。
9. 右键点击图表并添加Fraction节点。
10. 右键点击Fraction节点的A输入引脚并选择"提升到变量（Promote to Variable）"。将变量命名为"Animation Alpha"。
11. 从Set Time节点拖出引脚，并添加Get Current Frame节点。
12. 从Controller节点拖出引脚，并将其连接到Get Current Frame节点上的目标引脚。
13. 在"我的蓝图"面板的"组件"下，将MID变量拖入图表中，并选择Get MID。
14. 从Get MID节点拖出引脚，并添加Set Sparse Volume Texture Parameter Value节点。
15. 拖出Get Current Frame节点的返回值引脚，并将其连接到Set Sparse Texture Parameter Value节点的值引脚。
16. 在Set Sparse Volume Texture Parameter Value节点上，将参数名称设置为你的SVT材质中使用的稀疏体积纹理示例参数的名称。
17. 在"我的蓝图"面板的"组件"下，选择AnimationAlpha变量。在细节面板中，勾选"公开到过场动画（Expose to Cinematics）"复选框。
18. 编译并保存。

对于事件更新路径，你的动画SVT蓝图逻辑应该如下所示：

> 图片已省略：undefined

点击查看大图。

设置好此逻辑后，当你为**动画SVT蓝图（Animated SVT Blueprint）** 添加一个 **轨道（Track）** 到Sequencer后，点击轨道旁边的 **添加（+）** 图标时，就能在列表中看到你的 **AnimationAlpha** 变量了。

> 图片已省略：SVT Sequencer

添加后，你的变量可以在Sequencer面板中被为关键帧。

> 图片已省略：SVT动画

## 流送性能说明

- 动画SVT的实时播放

  - 动画SVT的实时播放在很大程度上依赖体积数据的分辨率和稀疏度。如果数据流送花费的时间过长，渲染将回退到更粗糙的Mip级别，造成保真度显著下降。你可以通过几种方式解决此问题：
  - 导入VDB时使用更小的像素格式，这进而可以提高流送性能。（对于实时用例二来，32位通常太高。）
  - 降低动画帧率。
  - 使用更低分辨率的Mip级别。
  - 如果使用此方法，需要在动画SVT控制器或异类体积组件设置上设置Mip级别。若在Sparse Volume Texture Sample节点上设置MipLevel输入引脚，系统会尝试以给定的Mip级别采样（前提是它已流送进来），但这无法驱动流送本身。

    适合用于调整流送性能的控制台变量
  - r.SparseVolumeTexture.Streaming.NumPrefetchFrames

    是在流送系统上请求给定帧时要预取的帧数。默认值为3帧，因为这在大部分情况下的效果良好，但该值到底应该是多少可能要取决于SVT本身。将该值设置得太高可能会使流送系统无法及时处理请求，设置得太低则可能导致帧不能在需要渲染时完全流送进来。
  - r.SparseVolumeTexture.Streaming.PrefetchMipLevelBias

    会对预取帧的Mip级别应用偏移。预取在递增的Mip级别（分辨率更低）上完成。此偏移可以用于更改预取帧的Mip级别。负值会导致以更高分辨率的Mip级别预取帧，而正值会导以更低分辨率的Mip级别预取帧。
  - r.SparseVolumeTexture.Streaming.PrintMemoryStats

    会打印注册到流送系统注册的所有SVT的内存信息。流送性能通常会在SVT帧大于30-50兆字节（MB）时开始下降。尝试使用默认的24帧率播放时，性能在很大程度上依赖所使用的平台和PC。流送性能还取决于目前流送的SVT的数量。
- 阻塞播放

  - 在特定用例（离线制片）中，你可能不希望以上述方式做出牺牲。为了保证在你渲染当前帧时所有Mip都已流送进来，流送器支持阻塞请求。通过阻塞请求，加载给定帧的IO请求会被视为问题，并立即等待直至其完成。阻塞请求很可能会影响帧率并导致在使用当前游戏时间驱动动画播放时"跳过"帧。但在使用Sequencer渲染帧时，跳帧问题会消失，因为Sequencer会指定要渲染的SVT帧，哪怕在渲染上一帧和当前帧之间经过了5分钟的实时时间。这不适用于SVT查看器，因为它主要是用来调试SVT资产的。
- 随机Mip过滤

  - 提供与虚拟纹理（Virtual Textures）类似的优化，对两个最接近的mip级别进行随机采样。这可以有效地将纹理样本减少一半，以提升性能。以下方场景为例，它包含5个 "Aerial Explosion" 实例，每个流送2GB/s IO带宽。如果没有带宽限制，并且不根据投影的屏幕空间大小进行缩放，这个场景大约需要25GB/s带宽。

  > 动图已省略：4a0de62edda3b27488e9fdd65d6ac55ab48341fd161b03127266e899e4b9429c

## 局限性

- 页表纹理的大小限制为2千兆字节（GB），最大虚拟SVT分辨率在X和Y轴上不得超过32K单位。Z轴则会被限制为16k单位。

  - 例如，你可以创建32k x 100 x 100单位的体积、100 x 32k x 100单位的体积或100 x 100 x 16k单位的体积。在此示例中，100是足够低的值，应该会使页表低于2GB限制。
- 动画SVT的实时播放性能在很大程度上依赖体积数据的分辨率和稀疏度。如果数据流送花费太长时间，渲染将回退到更粗糙的Mip级别，造成保真度显著下降。你可以降低动画帧率或使用更低分辨率的Mip级别来解决此问题。还可以在导入VDB文件时选择更小的像素格式来提高流送性能。
- 支持的平台：

  - 目前支持带使用着色器模型5（SM5）和着色器模型6（SM6）的DX11、DX12的Windows。
  - VDB导入目前仅适用于Windows编辑器版本。烘焙的版本在能够实现流送和渲染SVT所需的性能的所有平台上支持SVT。
  - SVT不适用于移动渲染器。

## 其他资源

- 本页面中的示例中使用的VDB文件来自使用EmberGen创建的JangaFX免费VDB集。
- 你可以在

  此处

  下载其免费示例。

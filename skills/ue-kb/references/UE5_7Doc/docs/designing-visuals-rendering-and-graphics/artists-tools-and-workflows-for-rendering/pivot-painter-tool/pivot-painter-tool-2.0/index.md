---
title: "枢轴点绘制器工具2.0"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pivot-painter-tool-2.0-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "渲染相关的美术工具和流程", "枢轴点绘制工具", "枢轴点绘制器工具2.0"]
---

# 枢轴点绘制器工具2.0

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 渲染相关的美术工具和流程 / 枢轴点绘制工具 / 枢轴点绘制器工具2.0

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pivot-painter-tool-2.0-in-unreal-engine

**枢轴点绘制器2.0** MAXScript将枢轴点和旋转信息存储在模型的纹理中。这些纹理随后即可在Unreal的着色器系统内引用，以创建交互效果。

示例视频中显示的动作由顶点着色器按步骤实时生成。枢轴点绘制器材质函数为模型的每个树叶和树枝生成动作继承信息。每个元素都使用单个枢轴点、方向矢量、边界大小和继承动作进行动画处理。其效果流畅且真实。

随着[枢轴点绘制器2的材质函数](../pivot-painter-tool-1.0/index.md)的加入，创建这些类型的材质已变得更加简单。示例内容[如内容示例中给出的内容](../../../../samples-and-tutorials/content-examples-sample-project/index.md)展示了如何生成诸如以上所示的动画，因此也大有帮助。现在，检索子对象枢轴点已经十分简单，只需在3D Studio Max中使用枢轴点绘制器脚本处理网格体，导入文件，然后使用可用的枢轴点绘制器函数创建材质。示例植物动作材质函数支持深达4层的层级和30,000个模型元素。

以这种方式创建动作有其优势。使用此技术处理的模型比标准静态网格体（Static Mesh）仅仅多使用一个UV信道，但其动画在成本上却远远低于骨架动画，因为它们都是实时计算的。在图形方面，顶点着色器指令计数通常不会像像素指令计数那么容易出现性能问题，因为模型上顶点的数通常明显少于该模型所绘制像素的数量。

> [!NOTE]
> 如需深入了解本页面所示的一些示例，你可以从Epic Games启动器（Epic Games Launcher）下载 [内容示例](../../../../samples-and-tutorials/content-examples-sample-project/index.md) 项目，并打开 **PivotPainter2** 地图。

## 枢轴点绘制器2.0的新功能

随着枢轴点绘制器2.0的推出，你会发现MAXScript已经有了一些改进和变化。虽然一些选项已经删除（例如层级格式刷（Hierarchy Painter））或重命名（例如按对象格式化（Per Object Painter）更名为顶点Alpha格式刷（Vertex Alpha Painter）），但这对整个工作流程而言却是一种改进，简化了创建这些类型具体资源的过程。这一切都是为了扩展枢轴点绘制器2的功能而服务，以获得比之前更好的效果，最终在你开发自己的内容时为你提供最丰富的选项。请阅读下文，了解已添加的其他改进。

### 工作流程改进

装置预处理步骤现在可通过Autodesk 3DS Max的标准 **链接（Link）** 工具完成。只需将树木建模为单独的逻辑元素，例如树叶和树枝。确保将它们枢轴点在位置和方向上都很理想（X轴沿对象长度向下），然后将它们连接在一起，如同传统装置中的一个整体。

最终，这让制作复杂植物变得更加简单。你可以设置、复制然后放置一个树枝。重新父子化的树枝也将保留其子项的层级排列。

将树木设置并建模后，只需选择树木中以及和渲染选项（Render Options Section）分段下的任意元素，并按下 **处理所选对象层级（Process The Selected Object Hierarchy）** 按钮。脚本将自动遍历所选元素的层级以查找其根，然后返回关系链以收集和处理其所有子项，最后使用从可用的渲染选项（Render Option）中选择的任意数据渲染纹理。

此方法同时支持单个元素和链接元素。对于既有草地又有树的模型，则可一次性选择每片树叶，然后从树中选择一个元素，再按下 处理所选对象层级（Process Selected Object Hierarchy） 按钮。

### 纹理坐标控制

现在，你可以控制要写入哪一个UV集，这使你能够将此系统与其他系统（例如[顶点动画工具](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/vertex-animation-tool/index.md)相结合。另外，在枢轴点绘制器2.0中选择的首选项标注在最终输出纹理名称中，用作有效的提醒。

以下是自动命名约定：

```
	[网格体名称]_rgb_[当前纹理RGB选择]_a_[Alpha选择]_[UV通道]
```

示例最终输出看上去与此类似。

```
	ExampleMesh_rgb_PivotPos_a_ParentIndex_UV_2
```

### 扩展性

由于处理和渲染代码已彻底抽象化，日后只需执行极少量的工作即可添加新渲染选项。

### 新渲染选项

作为MAXScript改进的一部分，场景背后使用了一种新位移算法，该算法将整数存储为浮点数据。由此使层级深度得以扩展，并将最大对象计数从3,000增加至30,000，而这对呈现复杂植物而言至关重要。

此特定树资源包含14,431个子模型。

- 16位RGB：

  - 枢轴点位置（Pivot Point Location）
  - 原点位置（Origin Positon）
  - 原点范围（Origin Extents）
- 8位RGB：

  - 对象基础向量（Object Basis Vectors）（一次一个矢量）
- 16位Alpha：

  - 父级索引（Parent Index）（整数存储为浮点数）
  - 从根开始的步数（Number of Steps From Root）
  - 各元素的随机0-1值（Random 0-1 Value Per Element）
  - 边界框直径（Bounding Box Diameter）
  - 选择顺序（Selection Order）（整数存储为浮点数）
  - 规格化0-1层级位置（Normalized 0-1 Hierarchy Position）
  - 对象从枢轴点位置开始在X、Y、Z轴方向上的边界长度（Object X,Y, Z Bound Lengths From Pivot Location）
  - 父级索引（Parent Index）（浮点数 - 最多2048个）
- 8位Alpha：

  - 层级中的规格化0-1位置（Normalized 0-1 Position in the Hierarchy）
  - 各元素的随机0-1值（Random 0-1 Value Per Element）
  - 对象在X、Y、Z轴方向上的边界长度（Object X,Y, Z Bounds Length）（最大为2048）

### 重新创建边界框

使用 3dx Max 时，模型的边界框会随着其子对象几何图形在建模过程中移位而扩展。该对象的边界框在此过程中不再朝向网格体或与网格体对齐。当你改变网格体的枢轴点变形时，上述现象便会发生。为了消解这种现象，**重新创建边界框（Recreate Bounding Boxes）**分段将使用与网格体枢轴点正确对齐并朝向该网格体枢轴点的边界框替换所选网格体的边界框，这对于脚本的其他数据收集功能（顶点Alpha格式刷和边界信息（Vertex Alpha Painter and Bound Information）非常有用。

在左侧，模型的枢轴点变形已发生改变，但边界框并未正确对齐或定向。使用重新创建边界框（Recreate Bounding Boxes）分段下的 处理所选对象（Process Selected Objects） 按钮后，最右侧模型的边界框已正确对齐和定向。

### 合并所选模型的法线

合并所选模型的法线（Merge Selected Model's Normal）功能可以在多个模型上均衡法线，其中开放边缘顶点恰好位于彼此之上。此选项将解决将单个模型分解为多个部分以专门与枢轴点绘制器一起使用时出现的法线接缝问题。

| 列 1 | 列 2 |
| --- | --- |
|  | BeforeAfterBeforeAfter |
| 按下合并网格体法线（Merge Mesh Normal）按钮以调节任何相交开放面的法线。 | 合并法线前，法线与每一个面对齐。合并之后，法线更紧密地对齐，从而使边缘更自然地融合在一起。 |

## 3ds Max版本和脚本信息

此工具目前已在 **3ds Max 2015** 和 **2016** 上经过测试。但它尚未专门在其他版本的3ds Max上进行测试，因此请注意，使用这些版本的3ds Max时可能会遇到问题。

若要安装MAXScript，只需将其从 **[UE5Directory]/Engine/Extras/3dsMaxScripts/PivotPainter2.ms** 拖放至3ds Max视口，脚本随后将自动启动。

> [!TIP]
> 如果你发现自己经常使用此脚本，则可将其添加至其中一个工具栏或四边形菜单内。如果你不熟悉如何执行此操作，*Autodesk* 网站列出了[非常详细的操作步骤](http://knowledge.autodesk.com/support/3ds-max/learn-explore/caas/CloudHelp/cloudhelp/2015/ENU/3DSMax/files/GUID-A2CF8BAA-7B52-40A8-8C40-803B1AB5FC05-htm.html)，它将为你说明操作过程。

### 3ds Max单位设置

开始使用此工具前，你需要首先确保，3ds Max使用的度量单位已经过设置以正确匹配并与Unreal Engine 使用的度量单位。这样你就可以确保该工具从3ds Max 导出的数据将Unreal Engine中以同样的方式运行。因为Unreal Engine使用厘米作为默认的度量单位，所以你需要确保3ds Max也使用厘米作为度量单位。若要在3ds Max中更改此设置，请执行以下操作：

1. 打开3ds Max，从主工具栏（Main Toolbar）选择

   自定义（Customize）

   >

   单位设置（Unit Setup）

   。
2. 然后单击 **系统单位设置（System Unit Setup）** 按钮和 **系统单位比例（System Unit Scale）** 分段。使用下拉菜单，将设置从 **英寸（inches）** 更改为 **厘米（centimeters）**。然后按下 **确定（OK）** 按钮。 1.最后，将 **显示单位比例（Display Unit Scale）** 更改为 **通用单位（Generic Units）**，然后按下 **确定（OK）** 按钮。

## 导入资源

导入资源时，你应注意以下几项，以获得最佳效果。按照以下所示的 **静态网格体（Static Meshes）** 和 **纹理** 设置进行操作。

### 静态网格体

在 **导入选项(Import Option)** 窗口中，确保取消勾选 **骨架网格体（Skeletal Mesh）**，并启用 **组合网格体（Combined Mesh）**。

| 列 1 | 列 2 |
| --- | --- |
| 静态网格体导入选项（Static Mesh Import Option） |  |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/131f6594-b6d7-42e6-bf1b-c19709b35b77/importoptions.png) 点击查看全图 | **骨架网格体（Skeletal Mesh）：** 已取消勾选 **组合网格体（Combine Mesh）：**已启用 |
| [可选]静态网格构建设置（Static Mesh Build Setting） |  |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/8ef9085c-b0bb-4e63-96ad-84f09afc2883/smbuildsettings.png) 点击查看全图 | 如果已为项目启用了网格体距离场（Mesh Distance Field），你可能需要从静态网格体编辑器构建设置（Static Mesh Editor Build Setting）中启用 **按照双面条件生成距离场（Generate Distance Field as if Two-Sided）**。视具体内容而定，你可能根本不需要启用距离场。在这种情况下，你应将 **距离场分辨率比例（Distance Field Resolution Scale）** 设置为0，或者从 **关卡详细信息（Level Detail）** 面板中取消勾选 **影响距离场照明（Affect Distance Field Lighting）** 选项。 对于某些内容，如果你发现树叶正偏离其位置，则可能需要启用 **全精度 UV（Full Precision UV）**。 |

> [!NOTE]
> 建议你在每次更新时执行"完全"重新导入（覆盖之前的模型），而非使用 **重新导入（Reimport）** 选项。这是预防任何材质问题的最安全方法。

### 纹理

导入使用枢轴点绘制器2.0创建的已生成纹理后，请确保打开纹理资源（Texture Asset）并设置以下各项：

| 列 1 | 列 2 |
| --- | --- |
| 8 位BMP纹理设置（Texture Setting） |  |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b0ac5f1f-ba9c-49f1-bd7f-6f55e365c187/texture8bitsettings.png) 点击查看全图 | **Mip 通用设置（Mip Gen Setting）:**NoMipMaps **压缩设置（Compression Setting）：**VectorDisplacementMap(RGBA8) **sRGB：**已取消勾选 **筛选器（Filter）：**最近 |
| 16位EXR纹理设置（Texture Setting） |  |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b65e41ec-c0e6-4f06-8ea9-e877cd6d8633/texture16bitsettings.png) 点击查看全图 | **Mip 通用设置（Mip Gen Setting）:**NoMipMaps **压缩设置（Compression Setting）：**HDR (RGB, no sRGB) **sRGB：**已取消勾选 **筛选器（Filter）：**最近 |

## 编写着色器

从枢轴点绘制器渲染的所有纹理为我们提供了许多工具来创建树木的子对象（树枝和树叶）的简单数学表达式。有了这些信息，我们便可以开始近似计算每个子资源对风吹源的反应，从而能够创建非常详细的元素层级来产生自然运动。

> [!NOTE]
> 如果你希望编写自己的着色器，则必须知道某些数据类型需要解压缩。这些解压缩函数使用以下命名约定：
>
> ```
> 	ms_PivotPainter2_*
> ```
>
> 如果符合你的需要，就目前而言，PivotPainter2FolaigeShader材质函数（Material Function）本身可以作为有用的材质（Material）运行，或者也可用作你自有版本植物着色器的基架。有关可用于枢轴点绘制器的材质函数（Material Function），请访问枢轴点绘制器材质函数参考页面。

### 枢轴点绘制器2植物着色器

现在，在材质（Material）内实现枢轴点绘制器2.0动画已经非常简单，而且大量的后端工作已经为你设置完毕！你只需将 **PivotPainter2FoliageShader** 输入到材质（Material）代码中，然后建立与材质属性输入引脚（Material Attributes Input Pin）的最终连接即可。另外，你还需要确保在材质详细信息（Material Detail）面板中禁用 **切线空间法线（Tangent Space Normals）**。

> [!NOTE]
> 此材质函数（Material Function）假设你已使用枢轴点绘制器的默认UV和纹理设置处理资源。

创建材质实例（Material Instance）后，你将可以访问可用的风吹设置（Wind Setting），它们能够让你控制子对象层级。为了使用这些设置，你首先需要为你希望对其施加影响的关卡启用 **风吹设置（Wind Setting）**。

启用风吹设置（Wind Setting）后，该层级深度的可用选项将可见并可编辑。

现在，你便可以访问 **共享风吹设置（Shared Wind Setting）**，它们允许你从枢轴点绘制器分配已渲染的纹理。

| 列 1 | 列 2 |
| --- | --- |
|  | **定位和索引纹理（Position and Index Texture）：**将已渲染的枢轴定位纹理（Pivot Positional Texture）分配至此槽。 **X轴矢量和X轴范围纹理（X-Vector and X-Extent Texture）：**将已渲染的X轴矢量和X轴范围纹理（X-Vector and X-Extent Texture）分配至此槽。 |

分配正确的纹理后，你现在可以打开 **风吹设置（Wind Setting）** 群组，并启用所需的功能。每个风吹设置（Wind Setting）群组都控制着处于某一特定层级深度的网格体。在树木这一示例中，风吹设置1（Wind Setting 1）控制树干，下一群组控制树枝，以此类推。

### 风湍流和阵风

此设置应当可以使你制作出美妙的植物动画。如果它们不是为你的喜好而量身定制的，你可以创建新的风吹湍流和阵风幅值纹理。为此，请使用矢量的RGB值以抵消风吹矢量，然后使用alpha控制风力。着色器中对两个信道集都进行了单独采样。

使用纹理控制矢量偏移和风力以产生变化。

### 优化

在尝试优化效果时，懂得材质的工作原理将对你大有帮助。PivotPainter2FoliageShader材质函数（Material Function）已采用通用方式进行设计。它执行相同的风吹反应代码4次。每次使用其他设置集时，它便会在更深一步的一个层级关卡上执行。你可以打开PivotPainter2FoliageShader材质函数（Material Function）来了解其工作原理。

如果你打开了PivotPainter2FolaigeShader材质函数（Material Function），在创建材质实例（Material Instance）时，你将找到公开的风吹层级深度（Wind Hierarchy Depth）的着色器功能网络。

现在，你可以使用以下分段了解能够使用的优化技术。

#### 材质实例

启用所有着色器功能后，你可以制作出相当昂贵的材质。禁用无需进行动画处理的风吹设置群组（Wind Setting Group）（或树木的层级关卡）可优化着色器。例如，你只需启用风吹设置4（Wind Setting 4）即可自行对该模型的树叶进行动画处理。按照层级深度对风吹反应设置进行分组意味着应以相同方式对模型的元素进行分组。所有树叶应距离根对象"X"步远。行为相似的所有树枝也应要归入一组。因此，建议你为树木之类的资源设置"父"或"主"材质实例（Material Instance），这样便可在其中轻松拥有多个层级。

将基本材质（Base Material）实例化，以构建用于在单个位置定义所有风吹设置的"主"材质实例（Material Instance）。然后，使用其他材质实例（Material Instance）定义层级的像素着色器组件，如树干、树枝和树叶的基本颜色纹理。这样，你还可以禁用和优化该层级深度不需要的任何属性。

例如，树叶材质实例（Leaf Material Instance）需要模拟树干、两个树枝集和及树叶本身的效果，以便其可以随着树木的其他部分一起正确运动。另一方面，树干只需模拟树干动画，这意味着你可以禁用树叶和树枝的其他层级，因为它们并非必需项。

#### 弯曲法线

另一项应考虑的优化（尤其是当你编写自己的着色器或计划编辑此着色器时）则是我们用来弯曲法线的方法。当用户选择更新着色器中的法线时，**PivotPainter2FoliageShader** 材质函数（Material Function）会对表面法线执行实际旋转。使用自定义UV和 **BlendAngleCorrectedNormals** 材质函数（Material Function）能够以更低的成本完成此操作（但有穿帮的风险）。

### 补充使用示例

使用位置信息和层级深度，你可以创建自己的程序化增长或建筑动画，如下所示。你亦可参阅内容示例地图（Content Example Map）**PivotPainter2** 以了解关于如何设置这些类型示例的示例。

| 列 1 | 列 2 |
| --- | --- |
|  |  |

这些示例可在Epic Games Launcher中的 **学习（Learn）** 选项卡所提供的 **内容示例（Content Example）** 项目中找到。打开 **PivotPainter2.umap** 以深入了解上述示例和其他示例。

## 故障排除

如果模型看上去动画效果不佳，请尝试以下解决方案：

- 重新导入资源。
- 检查模型和纹理设置。
- 确保材质（Material）已禁用

  切线空间法线（Tangent Space Normal）

  。
- 3ds Max中非均匀缩放的网格体将返回错误的变形数值并导致糟糕的结果。如果情况似乎如此，请尝试"重置XForm（Reset XForm）"操作。通过子对象非均匀缩放网格体始终比在对象级别非均匀缩放网格体更安全。我们建议你在开始复制、父子化和放置模型元素前，先执行此操作。
- 有些网格体出现扭曲是因优化在着色器内执行所致。为了正确计算风吹对树枝的影响，我们需要先计算风吹对每个树叶枢轴点及其矢量的影响，然后再执行每一次网格体旋转。由于每次旋转和偏移操作的成本都很昂贵，因此我们在每一个元素的局部空间内对该元素执行网格体旋转（然后再考虑其他旋转）。旋转产生的网格体偏移随后将添加到其他变形中。结果虽然在准确率上有所下降，但成本明显更低。有时候，准确率降低会导致植物比例根据偏移量的组合而稍有改变。所以如果出现上述情况，请尝试以下操作：

  - 降低风吹模拟的强度。
  - 对更少的层级关卡进行动画处理。
  - 旋转网格体，以降低同时发生的频率。

# Electric Dreams中的程序化内容生成

---
title: "Electric Dreams中的程序化内容生成"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-in-electric-dreams"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "Electric Dreams场景", "Electric Dreams中的程序化内容生成"]
---

# Electric Dreams中的程序化内容生成

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / Electric Dreams场景 / Electric Dreams中的程序化内容生成

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-in-electric-dreams

**Electric Dreams场景** 是一个结合了传统流程和程序化流程的场景，它直接在虚幻引擎中搭建，并采用了 **程序化内容生成** 框架。本文将以"Electric Dreams"场景为舞台，探讨什么是PCG框架，并介绍示例中的一些重要概念，包括：

- 工具
- 自定义节点和子图表

要进一步了解虚幻引擎中的PCG框架，请参阅我们的[程序化内容生成框架](../../../../building-virtual-worlds/procedural-content-generation/index.md)文档。

## 工具

本小节将介绍Electric Dreams场景中的PCG制作工具。

### Level to PCG Asset Utility

#### 说明

**Level to PCG Asset Utility** 可将选定关卡内的所有静态网格体、层级实例化静态网格体（HISM）和实例化静态网格（ISM）导出到[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产。其数据将存储为[PCG点数据](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E7%82%B9%E6%95%B0%E6%8D%AE)。特别强调，这些数据是所有已导出视觉效果的点云，并以[特性](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E7%89%B9%E6%80%A7)的形式存储了它们的变换、网格体和材质软对象路径、Actor标签和Actor场景层级信息。

得到的[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产可以作为实例化节点添加到[PCG图表](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E5%9B%BE%E8%A1%A8)中。然后，所有程序化规则(PCG图表)都可以处理该[PCG点数据](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E7%82%B9%E6%95%B0%E6%8D%AE)，以对其执行增强和/或生成操作。

#### 设置

蓝图资产工具随PCG插件一同发布，可在启用 **显示插件内容（Show Plugin Content）** 后使用。

Level to PCG资产工具的路径为：`/PCG/Utilities/PCGUtility_LevelToPCG` 。

Electric Dreams中所有[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)及其源关卡的路径为：`/PCG/Assets/PCGAssemblies` 。

#### 使用方法

要使用Level to PCG资产工具，请遵循以下步骤：

1. 在

   内容浏览器（Content Browser）

   中选择一个关卡。
2. 点击右键，选择 **Scripted Asset Action > Level To PCG Settings** 。

   ![Level to PCG Asset Utility](../../../../../assets/images/ae/ae6fb2802006d4fdf16a04506d6ef245376c3dbfe181295d59d2f058bff17a62.png)

   点击查看大图。

   > [!NOTE]
   > 如果选择的关卡属于[已分区的世界](../../../../building-virtual-worlds/world-partition/index.md)或[OFPA](../../../../building-virtual-worlds/one-file-per-actor/index.md)，你首先需要在编辑器中打开它并加载其内容。对于非OFPA关卡，你无需在编辑器中打开它，可以直接通过内容浏览器完成操作。
3. 上述步骤会在选中的关卡文件旁边创建一个

   PCG设置

   资产，并以关卡名称加"_PCG"后缀的形式命名。如果已经存在具有此名称的

   PCG设置

   资产，将更新现有资产，而不是新建资产。
4. 从

   内容浏览器

   中，直接将

   PCG设置

   文件拖放入

   PCG图表

   ，作为

   Instanced

   节点。
5. 在 **PCG 图表** 中，将资产节点的 **点（Points）** 输出连接到 **Copy Points** 节点的源输入，并将点集指定为要向其复制源点的目标点集。

   > [!TIP]
   > 在Copy Points节点中，将"Attribute Inheritance"设置为"仅来源（Source Only）"，以尽可能地加快处理速度。
6. 将 **Copy Points** 的输出连接到一个 **Static Mesh Spawner** 节点，将其 **网格体选择器类型（Mesh Selector Type）** 设置为"PCGMeshSelectorByAttribute"， **特性名称（Attribute Name）** 设置为"网格体（Mesh）"。

   ![Material Overrides](../../../../../assets/images/d1/d152dfd666b7c6b006590965fbafcdd3036440cafc40ff2bdc97a6aa81a508d0.jpg)

   点击查看大图。

   > [!NOTE]
   > 如果在导出的视觉效果上使用了材质覆盖，可以将"材质（Material）"作为Index0的值，以激活By Attribute Material Overrides。

你还可以使用导出的 **Actor Tag** 特性，通过 [PCG图表](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E5%9B%BE%E8%A1%A8) 中的 **Point Filter** 节点过滤点。*标签过滤* 的用例包括：

- NoCol

  ：根据它们的碰撞需求过滤点，并相应地生成它们。
- Clutter

  ：添加随机噪点和参数化密度，以增强Assembly。
- Helper

  ：过滤在规则中具有特定用途但不应该生成的点。

### Actor Tagger编辑器工具控件

![Actor Tagger Editor Utility Widget](../../../../../assets/images/9d/9d2a7c381773caa9e400ab3ee9fbd6c17db88d3c6bb5b0e7b0779b245d008df8.png)

#### 说明

**Actor Tagger Editor Utility Widget** 将帮助你在关卡中的资产上编写Actor标签。该工具控件可以为要导出到[PCG设置](#pcg%E8%AE%BE%E7%BD%AE)资产的关卡加快标记工作流程。

虽然虚幻引擎拥有一个合格的工作流程可用于添加、编辑、删除资产上的Actor标签，但是它目前并不适合大规模编辑。这方面的一个例子是，当你要为几个选中的Actor应用不同的Actor标签时，这会导致Actor标签在 **细节（Details）** 面板中出现混淆。

创建Actor Tagger编辑器工具控件的目的之一，就是缓解当前编辑器Actor标签表现出来的这种问题，同时它还提供了一个本地化的操作控制板，使用户能够在3D视口中专注于标签的编写。

#### 设置

Actor Tagger编辑器工具控件的内容文件路径为： `/Game/PCG/Utilities/ActorTagger/EUW_ActorTagger`

#### 使用方法

要运行Actor Tagger，请执行以下步骤：

1. 在

   内容浏览器

   中选择一个

   Actor Tagger

   。
2. 右键点击该

   Actor Tagger

   并选择

   Run Editor Utility Widget

   。

#### 功能

##### Select Tag

选择已加载关卡内所有在 **Select Tag** 字段中输入了标签的 Actor。其结果将替换当前在大纲视图中选择的项目。

##### Remove Tag

搜索当前选中的所有Actor，寻找在 **Remove Tag** 字段中输入的标签。如果某个Actor上存在该标签，该标签将被移除。

##### Add Tag

将在 **Add Tag** 字段中输入的标签添加到所有当前选中的Actor上。如果选中的Actor已具有该标签，则不会二次添加。

##### Hide

隐藏当前选中的所有Actor。如果当前没有选择Actor，之前隐藏的所有Actor都将变得可见。

##### Unlit / Lit

切换视口光照模式的状态（光照和无光照）。

##### 工具部分

###### Output Level Tags

将存在于已加载关卡中的所有唯一标签打印到输出日志中。这样可以快速全面地了解已加载关卡中的所有Actor标签。

![Level Tags in the Output Log](../../../../../assets/images/63/632e1c00ee66b2c0df3be8a8bb7f49d71303af740f6e4bfb9534459670820c44.png)

###### Make Tags Unique

该函数会在当前加载的关卡中遍历所有Actor，将各Actor的所有重复标签减少至单个标签条目。

###### 参考关卡

该函数用于加载或卸载一个指定的参考关卡。这或许可以将光照和参考对象包含进来，以帮助构造将作为[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产导出的关卡。

![Default Reference Level](../../../../../assets/images/82/8241493c32597a07d170d370b103131688b38250d2c4ceaef88b5e71c1a7e3c3.jpg)

运行编辑器工具控件时，会分配一个默认的参考关卡。默认参考关卡可以在这里找到：`/Game/PCG/Utilities/ActorTagger/ActorTagger_ReferenceLevel` 。

更改在控件构造脚本中指定的关卡，可以自定义该默认参考关卡。

![Change Default Reference Level](../../../../../assets/images/55/550acca2a81dd7010c618229e92986398b998d6e974acccf5241061c8f7c9d68.jpg)

点击查看大图。

###### Set Reference Level

该函数允许你指定自己的参考关卡，用于加载和卸载。要指定自己的参考关卡，请在 **内容浏览器** 中选择一个非世界分区关卡，然后点击此按钮。控件不会保存指定的参考关卡，每次运行控件时都需要重新指定。

## 自定义节点和子图表

本小节介绍了在Electric Dreams场景[PCG图表](#pcg%E5%9B%BE%E8%A1%A8)中，为特定用途而创建的PCG自定义节点和子图表。

### Copy Points With Hierarchy和Apply Hierarchy

![Copy Points Hero Image](../../../../../assets/images/f2/f2d2246fc441b655553ae437d8217c6bcc10681cfb4757549fbf92ea789ee76c.jpg)

#### 说明

**SG_CopyPointsWithHierarchy** 和 **ApplyHierarchy** 节点需要与通过Level to PCG资产工具创建的[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产结合使用。

你可以使用这些节点操纵点的层级，类似于在关卡中操纵Actor的层级。点可以继承父点的变换。例如，使用这个功能，代表树干的点在随机旋转和缩放时，如果代表树分支的子点也在变换，首先会沿用其父点的变换，同时，还会基于父点的变换，增加自身的变换（旋转或缩放）。

你可以使用Point Filter运算符移除点，它们的子点将被自动移除。这有助于为复杂的点设置添加随机变化。

#### 设置

SG_CopyPointsWithHierarchy和ApplyHierarchy节点位于Electric Dreams场景示例项目的 **节点控制板** 中。你也可以通过图表区域的 **PCG编辑器** 上下文菜单访问它们。

SG_CopyPointsWithHierarchy 子图表的内容文件路径为：`/Game/PCG/Assets/PCGCustomNodes/SG_CopyPointsWithHierarchy` 。

ApplyHierarchy自定义节点的内容文件路径为：`/Game/PCG/Assets/PCGCustomNodes/ApplyHierarchy` 。

以下[PCG图表](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E5%9B%BE%E8%A1%A8)使用了这些节点：

- /Game/PCG/Graphs/Ditch/PCGDemo_DitchBP
- /Game/PCG/Graphs/Ground/PCGDemo_GroundBP
- /Game/PCG/Assets/BP_PCG_LargeAssembly
- /Game/Levels/PCG/Breakdown_Levels/ElectricDreams_PCGSplineExample

#### 使用方法

![Hierarchy nodes in a PCG Graph](../../../../../assets/images/53/5336c8e8ff790223a9e7793a73cf1296498da955436c81c3968624b69756fd76.jpg)

PCG图表中层级节点的常见用法。（点击查看大图。）

[PCG图表](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E5%9B%BE%E8%A1%A8)中层级节点的常见用法一般如下：

1. 由

   Level to PCG资产工具

   将关卡转换为包含PCG点的

   PCG设置

   资产，其相关联的场景层级信息将存储为metadata

   特性

   。
2. SG_CopyPointsWithHierarchy

   子图表使用目标点变换在多个位置复制

   PCG设置

   资产，这与

   Copy Points

   节点的作用类似，但它还通过维护和偏移层级特性值，使父级信息对于原始资产点的每个副本来说都是唯一的。
3. Point Filter

   节点，根据特性选择点。
4. Transform Points

   节点与

   ApplyToAttributes

   选项，对被选中点的相对变换特性执行变换操作。
5. Merge

   节点，重新组合同一数据流中同一层级的所有点。
6. ApplyHierarchy

   节点，将相对变换特性与父级变换相结合，应用到点上。

##### PCG设置节点生成的层级特性

> 图片已省略：Hierarchy attributes of FallenTree PCG Settings asset

FallenTree 的PCG设置资产的层级图。（点击查看大图。）

将关卡Actor导出到[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产时，源关卡中的Actor层级信息会使用 *元数据特性* 与每个PCG点保持关联。这些元数据特性是：

| **元数据特性** | **类型** | **说明** |
| --- | --- | --- |
| **ActorIndex** | int | 该点的唯一标识符。 |
| **ParentActorIndex** | int | 该点的父点的唯一标识符。 |
| **HierarchyDepth** | int | 该点在父级层级中的深度。换言之，就是一个点在它自己和根点之间有多少个父点。 |
| **RelativeTransform** | transform | 在[PCG设置](#pcg%E8%AE%BE%E7%BD%AE)资产的来源关卡中，该点与父点之间的偏移变换。 |

虚拟点表示具有以下元数据特性的层级根点：

- ActorIndex

  ：0
- ParentActorIndex

  ：-1
- HierarchyDepth

  ：0
- RelativeTransform

  ：单位变换

所有在源关卡层级中未指定父级的点都会以这个根点为父点，以避免处理孤立点或根点的特殊情况。

##### 由SG_CopyPointsWithHierarchy变换的层级特性

> 图片已省略：Indicies produced by SG_CopyPointsWithHierarchy

为每个PCG资产副本生成的Actor和父Actor索引，这些PCG资产由SG_CopyPointsWithHierarchy生成。注意有6个不同的根点ActorIndex值。（点击查看大图。）

> 图片已省略：Copy Points with Hierarchy subgraph

SG_CopyPointsWithHierarchy子图表。（点击查看大图。）

要处理层级的索引值，需要自定义一个Copy Points节点。它的作用是：当一个点寻找其父点时，该点和它解析的父点都属于由Copy Points节点生成的相同点副本或一组点。

这个自定义的Copy Points节点以子图表的形式实现，其中包含：

- 一个普通的Copy Points节点。
- 一个PostCopyPoints-OffsetIndices蓝图节点，负责为每个副本指定一组唯一的ID，这些ID根据原始索引、副本编号和唯一的任务ID计算得出。
- 两个Create Attributes节点，用于将IgnoreParentRotation和IgnoreParentScale两个布尔值特性初始化为"false"。

##### 层级中的点操作

一旦将点复制到SG_CopyPointsWithHierarchy目标点所指定的位置，就可以使用 **Point Filter**，按照[PCG设置](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E8%AE%BE%E7%BD%AE)资产中的特性，对点进行过滤：

> 图片已省略：Filter points with the Clutter Attribute

PCGDemo_Ditch中的点过滤，使用了Clutter特性来随机移除层级中的点。

> 图片已省略：Filter points with the Rotation Z Attribute

PCGDemo_Ditch中的点过滤，使用RotZ特性来随机旋转层级中的点。

在上面两张图中，按标签选中的点经过过滤或旋转，重新与未被 **Point Filter** 选中的点合并。这个 **Merge** 操作很重要，因为这可确保所有点（无论是否经过变换）都保留在相同的数据流中，而且稍后在应用最终点变换时，可以一并处理。

> 图片已省略：Relative Transform Attribute

点击查看大图。

当在层级中使用Transform Points节点时，必须注意不能将变换直接应用至点的Transform特性，而是要应用至RelativeTransform特性。为此，请将 **Apply To Attribute** 选项中的 **Attribute Name** 指定为"RelativeTransform"。如果你想部分继承父点的变换，可以选择将 **IgnoreParentRotation** 和/或 **IgnoreParentScale** 特性设置为"true"。

> 图片已省略：Apply Hierarchy

最终，**ApplyHierarchy** 节点会在 **Static Mesh Spawner** 节点生成网格体之前被立即使用。ApplyHierarchy节点的作用是：

- 以升序方式遍历所有现有的层次级别（根据层级深度点特性解析）。

  - 根据它的父变换和它的RelativeTransform特性值计算出最终的点变换。
  - 移除其父点已被丢弃的点。

### Flat Area Detector

> 图片已省略：Flat Area Detector Hero

#### 说明

**Flat Area Detector** 子图表用于确定表面是否足够平坦，以放置给定大小的点，并避免资产错位的情况（如资产部分悬浮在地面上）。Flat Area Detector 通过在每个源点周围的4个不同位置对表面进行取样，从而实现对水平表面或倾斜表面的处理。在4个采样位置中，如有任何一个不与由输入点位置和方向定义的平面相交，输入点将被丢弃。在上面的图片中，这些平面显示为蓝色矩形。此外，在4个采样位置中，如有任何一个的表面方向偏离输入点的方向，输入点也将被丢弃。

该子图表在以下图表中使用：

- PCGDemo_Ground

  - 在该图表中，Flat Area Detector 用于在粗糙的岩石网格体表面上放置三叶草地块。
  - 该图表的内容文件路径为：

    /Game/PCG/Graphs/Ground/PCGDemo_Ground

    。
- PCGDemo_Forest

  - 在该图表中，Flat Area Detector 用于在地形上放置庞大、平坦的石质地块和地标岩石Assembly。
  - 该图表的内容文件路径为：

    /Game/PCG/Graphs/Forest/PCGDemo_Forest

    。

> 图片已省略：平坦的石质地块部分漂浮在地形上。

> 图片已省略：漂浮的平坦石质地块被消除。

平坦的石质地块部分漂浮在地形上。

漂浮的平坦石质地块被消除。

#### 设置

Flat Area Detector 子图表的内容文件路径为：`/Game/PCG/Graphs/Forest/DiscardPointsInBumpyAreas` 。

#### 使用方法

要将Flat Area Detector 作为[PCG图表](../electric-dreams-procedural-content-generation-glossary/index.md#pcg%E5%9B%BE%E8%A1%A8)中的节点使用，请在 **内容浏览器** 中将此图表拖放至 **PCG图表** 编辑器：

> 图片已省略：Flat Area Detector

点击查看大图。

##### 节点引脚说明

**DiscardPointsInBumpyAreas** 节点的引脚和说明如下所示：

| **引脚** | **类型** | **说明** |
| --- | --- | --- |
| **In** | 点 | 针对ProjectionTarget表面测试的输入点。 |
| **InNoProjection** | 点 | (可选项) 此引脚是一种优化措施，如果输入点已经在表面上，可以用它代替In引脚来输入。 |
| **ProjectionTarget** | 表面 | 把这个引脚连接到你需要评估平整度的表面上。它可以是一个Get Landscape Data或World Ray Hit节点生产的表面。 |
| **SampleDistance** | 特性集 - Double | 这个引脚需要一个浮点或双精度浮点的属性输入，比如由创建属性节点提供的属性。 这个引脚控制每个用于探测表面的源点和采样点之间的距离。 从视觉上来讲，这些点由上图中蓝色线框的X-Y延伸部分表示。 |
| **HeightThreshold** | 特性集 - Double | 这个引脚需要一个浮点或双精度浮点的属性输入，比如由创建属性节点提供的属性。 与蓝色线框表面的距离大于这个值的采样点会被认定为偏离平面，随后被用来弃用输入点。 平面外的点显示为上图中的红色方框。 |
| **NormalThreshold** | 特性集 - Double | 这个引脚需要一个浮点或双精度浮点的属性输入，比如由创建属性节点提供的属性。 这个引脚控制在放弃输入点之前，采样点的上行矢量能与输入点的上行向量相差多少。 这个值必须是负数。它越接近于零，被弃用的点数就越多。 |
| **Out** | 点 | 通过HeightThreshold和NormalThreshold测试后剩余点的集合。 |

#### 子图表介绍

> 图片已省略：Discard Points Graph

点击查看大图。

本小节介绍了Flat Area Detector 子图表的工作方式。

##### 创建取样点

> 图片已省略：Create Sample Points

Attribute Math和Transform Points节点按照下方描述创建四个取样点：

- 取样点放置在各个输入点周围的2D方框中。
- 该方框的尺寸由取样距离特性决定。
- 各个取样点的边界由高度阈值特性决定。

##### 构建平面

> 图片已省略：Build Planes

扁平化的点在上方图片中用蓝色线框表示，它们使用Attribute Math操作，基于Sample Distance特性构建的。

##### 将取样点投影到平面

> 图片已省略：Project Points to Surface

四个取样点会在考虑到位置和方向的情况下，投影到表面。这些投影点与蓝色线框之间的差值随后会计算出来。这个差值节点会输出平面外的点。

> [!TIP]
> 启用这三个节点的调试状态后，将显示蓝色线框、绿色的四个采样点以及与蓝色平面（即蓝色线框）不相交的采样点，如上图所示，用红色表示。

##### 估算取样点朝向的差异

> 图片已省略：Normal Variance Test

点击查看大图。

接下来，将估算取样点方向的差异。一个点从输入点中创建出来，它将按照法线阈值沿其上行向量进行负向平移。在下方的图片中，这显示为一个实心的蓝色平面。该点与扁平化的取样点之间的相交会被计算出来，与表面法线向量对齐。在下方的图片中，这显示为蓝色线框。

> 图片已省略：法线阈值 = -300

> 图片已省略：法线阈值 = -10

法线阈值 = -300

法线阈值 = -10

左侧图像表示法线阈值为-300，沿其上行向量向下推动蓝色实心平面。右侧图像表示法线阈值为-10。使用这个值，相交现在会输出一个显示为红色三向轴的点。这演示了如何基于取样点方向的差异，使用法线阈值控制相交的输出。

> [!NOTE]
> 平行的取样点/平面只与法线阈值为0的蓝色实心点相交。

##### 最终点过滤

> 图片已省略：Final Point Filtering

点击查看大图。

最后，从这两个测试中得到的点将展开，用来提供与输入点的差异，从而对它们进行过滤。这样，留下的点都将符合DiscardPointsInBumpyAreas节点输入引脚中提供的参数。

### Look At

> 图片已省略：Look At Hero

#### 说明

**LookAt** 节点可根据作为vector3特性提供的目标，重新指定点的方向。该特性可通过特性的数学运算和距离节点创建。

在Electric Dreams场景中，该节点用于：

- 在地面规则中，对照大型Assembly样条线重新调整点的方向，以实现理想的河床视觉效果。
- 在雾卡和森林图表中，朝区域中心旋转雾卡的点。

#### 设置

LookAt自定义节点的内容文件路径为：`/Game/PCG/Assets/PCGCustomNodes/LookAt` 。

#### 使用方法

LookAt节点会遍历单个点的数据输入，并期望接收一个vector3特性，作为每个点要看向的目标坐标。

> 图片已省略：Rotate Fog Cards with Look At

点击查看大图。

要使用LookAt节点，请执行以下步骤：

1. 创建点数据。
2. 使用设置为

   From Source Param

   的

   AddAttribute

   ，向点数据添加新的

   LookAt

   特性。
3. 使用以下任意选项覆盖

   特性

   ：

   - 向量类型的

     Create Attribute

     节点以及你看向的坐标。
   - 由一个可被公开以进行自定义的蓝图vector3变量提供的

     Get Actor Property

     。
   - 在

     Graph Settings

     中创建一个PCG vector3图表参数，并在图表中获取参数名称，该参数名称将在每个图表实例中公开，供每个PCG组件编辑。
4. 设置

   LookAt

   节点的设置：

   - 将

     LookAt

     Target

     设置为要使用的特性名称。
   - 2D LookAt

     设置将忽略Z分量。
   - Forward X

     会在

     LookAt

     中使用X轴而非Y轴。


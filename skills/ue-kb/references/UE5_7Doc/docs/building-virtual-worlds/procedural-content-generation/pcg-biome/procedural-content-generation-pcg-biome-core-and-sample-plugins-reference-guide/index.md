---
title: "PCG群系参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine"
breadcrumbs: ["PCG群系参考"]
---

# PCG群系参考

> 路径：PCG群系参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine

PCG群系核心和示例插件是关于如何将[PCG框架](../../procedural-content-generation-overview/index.md)用于属性集表、反馈循环、递归子图表和[运行时分层生成](https://dev.epicgames.com/documentation/404)等功能的示例。

## 参考

### 核心图表概述

![PCG Biome Reference](../../../../../assets/images/5d/5d125a5d5beb977a7906c923a60ec11687e6d3a6ac271c130c805a7ba3ac526f.jpg)

BiomeCore图表相当于群系创建工具的大脑，所有处理都使用PCG框架执行。

主处理步骤按顺序如下所示：

1. 群系缓存从所有群系Actor和可选的群系纹理投射计算。
2. 发生器图表由世界中的群系资产引用，由群系缓存处理和绑定，针对使用的每个发生器生成唯一的根点数据。
3. 对生产的根点数据应用群系。根资产表是通过世界中所有群系的所有资产编译的。基于群系、发生器类型、子类型和加权将根资产表属性分配给每个点。
4. 在此步骤，会在每个发生器根点数据集之间执行基于优先级的对比。发生器优先级属性确定操作顺序，并可以选择性地绕过。
5. 使用由群系核心Actor的根点筛选器全局参数提供的PCG图表来应用筛选器。模板群系资产类有按资产条目控制筛选行为的选项，并可以根据需要扩展。
6. 使用每个资产的变换图表和子资产引用，将递归变换应用到每个资产。通过此资产引用层级，可以为每个根点创建子点数据并使用最大深度全局参数对其进行限制。
7. 生成静态网格体和Actor。包括对属性重载、程序集和碰撞预设的支持。
8. 将数据输出到群系核心运行时，可以在全局参数中启用。导出被标记为用于运行时生成的所有资产。也可以选择性地对网格体进行离线取样，以极低的开销向群系核心运行时提供点。

### 一般概念

#### 群系缓存

> 图片已省略：PCG Biome Reference

**群系缓存（Biome Cache）** 是用于在世界中空间化存储群系定义数据的PCG点的网格。

- 与群系体积、群系样条线和群系纹理关联的群系定义颜色会被投射并存储到此3D网格中，以识别世界空间中的每个群系。
- 由于群系缓存是3D结构，因此支持垂直度（例如使群系彼此堆叠，或实现地下洞穴），但2D仍然可以实现，方法是提供类高大的柱状点。
- 缓存分辨率由群系核心PCG组件的 **群系缓存单元格大小（Biome Cache Cell Size）** 矢量参数控制。
- 缓存中的每个点一次只能存储一个群系颜色值。
- 在将群系颜色存储到群系缓存中时，会触发 **群系优先级安排（Biome prioritization）**。
- 缓存从群系核心Actor边界初始化，如找到地形，它使用其表面从网格删除单元格作为优化。

  * 体积和样条线可以在没有地形的世界中定义群系，在这种情况下，发生器应该使用世界光线击中查询来对几何体取样。

  * 如果存在地形，可以选择将群系纹理投射到缓存。
- 使用发生器图表中的表面取样器生成点时，群系缓存会被用作 **边界形状**，以避免在群系不使用发生器的世界部分中对地形或其他表面取样。
- 最后，系统会先使用缓存解析群系，然后再将根资产表中的群系资产匹配到发生器图表生成的点。

#### 根资产表

![PCG Biome Reference](../../../../../assets/images/a1/a112d2976ee2a013ddc31f522ed8a0cc5cb629ac3f608a8814a28dc6218d0bd1.png)

**根资产（Root Assets）** 在资产层级的顶层。它们由分配给群系设置、体积或样条线的数据资产提供，包含发生器、网格体、变换、边界、渲染和碰撞选项等属性。

这些资产属性存储在名为 **根资产表（Root Asset Table）** 的PCG属性集表中。表中的每个条目使用其唯一的 **AssetID** 属性进行识别。

发生器图表生成的点被分配了将群系缓存中的群系之后，会获得对应于根资产表中条目的AssetID属性。

此根资产表设置可避免直接将资产中的所有属性分配给每个生成的点，简化并优化了点属性布局。点分配到AssetID之后，这是它唯一需要保存的属性。其他属性可在需要时从根资产表轻松访问。

#### 发生器

![PCG Biome Reference](../../../../../assets/images/b7/b7c2d1bbc0545ba116580515475dc542eeaeebbe632ac6d5f1e939e558f7f9c5.jpg)

![PCG Biome Reference](../../../../../assets/images/71/71625abc0919f71b2abda5e5d944a1b3780e725eaf64ab131fe0764d371dabb4.jpg)

发生器是根点提供程序，对于系统的正常工作不可或缺。

**群系发生器数据资产** 需要提供：**发生器类型（Generator Type）** （作为唯一名称标识符）、**发生器图表（Generator Graphs）**（由群系核心运行以输出群系资产将被分配到的点）和 **发射器优先级（Generator Priority）**。

**发生器图表（Generator Graphs）** 是独立的PCG图表，用于满足各种自定义逻辑的各类需要，它们只需要提供点。发生器图表的PCG图表实例完全受支持，应被用于通过图表参数轻松自定义，而不必为每个相似情况编译新的自定义图表。推荐从下面的 **BiomeGenerator_Template** 图表开始：`/Script/PCG.PCGGraph'/PCGBiomeCore/BiomeGenerators/Graphs/BiomeGenerator_Template.BiomeGenerator_Template'`

**发生器优先级（Generator Priority）** 可用于分层。它影响基于优先级的对比，从而对多个发生器的分层进行排序。数值越低，优先级越高。生成的点数据之间的优先级对比是在资产被分配给每个点之后执行的，这样就可以在这些对比操作期间访问网格体边界。要选择性地在BiomeGenerator资产中绕过优先级对比，可启用GeneratorAllowOverlap选项。

每个 **群系资产（Biome Assets）** 条目都有一个对发生器的引用。要定义将哪个资产分配到哪个点，此链接必不可少。群系资产还可以被映射到发生器子类型，这将在高级设置分段中介绍。

示例：

- 在共享同一个源图表的情况下，通过使用不同的图表实例参数值对地形取样来生成树木和岩石的点。岩石发生器的优先级0，树木的优先级为1。此时，当树木的边界与岩石重叠时，将自动删除树。
- 通过使用世界光线击中查询对几何体表面取样，在静态网格体上的扁平区域中生成用于生成POI程序集的点。
- 在湖泊或江河样条线边界附近生成点，并将其重新投射到地形上。
- 为匹配群系的Niagara系统或声音体积创建点。

#### 群系和资产映射

群系是利用群系定义和群系资产创建而成的。同时需要这两种数据资产，群系才能存在于世界中，并且需要群系发生器将资产分配到根点上。

群系定义和资产之间的映射在群系核心执行中发生。对于世界中的BiomeVolumes、样条线或设置Actor中的每个唯一群系定义，将在处理期间收集所有共享同一个群系定义的Actor所引用的所有群系资产的列表，并将其关联到特定群系。

根资产表由所有群系资产及其所属群系编译而成，然后可以被正确地筛选并映射到群系中生成的点。

一些上下文示例如下：

- 使用唯一群系定义和多个资产的单个群系体积会产生此体积的唯一群系。
- 若多个群系体积和样条线共享同一个群系定义，但使用不同资产列表，则会产生拥有单个公共资产列表的单个群系。
- 使用唯一群系定义、拥有相同群系定义的多个资产和多个体积或样条线的群系设置Actor：群系设置类将提供单一全局配置源，这意味着，你可以使用单个设置Actor编译你的群系，仅将其群系定义的引用添加到其他群系体积或样条线。使用可选的群系纹理投射时，每个群系纹理颜色需要一个群系设置Actor。

在BiomeSampleLevel中，使用一个ConiferousForest `BP_PCGBiomeSetup` Actor全局定义ConiferousForest群系（蓝色）。关卡中的 `BP_PCGBiomeVolume` 将引用同一个群系定义，而使用的BiomeMap纹理（可选）中会有相当大一部分使用完全相同的群系颜色。在两种情况下，BiomeSetup都包含资产列表，两个输入都会生成ConiferousForest群系。

![PCG Biome Reference](../../../../../assets/images/2e/2ee5728a5fb8939885befecbd54590b9d46c677fc8903ad240507f56d96de01e.jpg)

![PCG Biome Reference](../../../../../assets/images/04/041f053fb318f3f9bb6b77ccf994abe66926e3e96faafeea4a6033769e4b211e.jpg)

> 图片已省略：PCG Biome Reference

为项目创建预配置的群系设置、体积和样条线的子蓝图类是可行的，而且我们推荐这样做。这样就可以在同一个世界或多个世界中快速轻松复用群系，并轻松全局调整内容。

#### 基于优先级的对比

发生器需单独处理，其输出（根点）可以使用发生器资产中设置的发生器优先级值进行分层。分层在BiomeCoreDifferenceByPriority反馈循环中处理每个点数据时发生。按重要性从高（最小的发生器优先级值）到低（最大的发生器优先级值）排序。

![PCG Biome Reference](../../../../../assets/images/e2/e25b063770669726b697d9458ee3c366010d1108670ad8780c28086a6febaed5.jpg)

![PCG Biome Reference](../../../../../assets/images/99/99fd44c17975cc97368fbc28a6968470bf723cf7d1961e51c4e8c7cec5beeff7.jpg)

在反馈循环图表中，将在当前迭代的传入数据与之前循环迭代中的剩余点之间按顺序应用二元对比。在循环完成时，所有点都不会重叠，除非发生器的优先级值相同或启用了GeneratorAllowOverlap选项。输入点边界会匹配其分配到的资产网格体/程序集边界，并可以在资产选项中被重载，以便进行更好的控制。

> 图片已省略：PCG Biome Reference

更高发生器优先级的岩石（红色）之间的分层会删除重叠的树。

> 图片已省略：PCG Biome Reference

使用GeneratorAllowOverlap选项绕过了分层，产生重叠的岩石和树。

#### 筛选

除了使用基于优先级的对比进行分层之外，还可以根据可完全自定义的计算图表或纹理投射列表来筛选根点和子点。默认情况下，群系核心Actor会配置高度、密度和水距离筛选器。群系资产筛选器选项为其中每个默认筛选器公开了范围。

密度筛选器基于发生器设置的密度，在点的 `$Density` 属性上变换或筛选图表，这意味着可以使用写入 `$Density` 的任何计算。高度筛选器使用点的 `$Position.z` 属性，而水距离筛选器使用位于或低于所定义水位的点与剩余点之间的距离。

群系核心中的根点和子点的筛选步骤使用动态图表功能，它允许将所执行的图表参数化在这种情况下使用动态子图数组以获得更大的灵活性。如需了解如何定义筛选器数组、创建筛选器图表并自定义筛选器选项结构，请参阅[筛选器](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#%E7%AD%9B%E9%80%89%E5%99%A8)。

群系示例设置了额外的纹理投射筛选器和自定义筛选器选项。它提供的两个纹理，即水流（Flow）和日照（Sun Exposure），都是2D纹理数组，它们逐图块投射，然后根据每个资产中设置的、其各自的最小/最大值筛选。

> 图片已省略：PCG Biome Reference

水流贴图投射的调试显示。

> 图片已省略：PCG Biome Reference

通过水流贴图投射筛选0到0.33的资产时。

> 图片已省略：PCG Biome Reference

通过水流贴图投射筛选0.66到1的资产时。

#### 递归和变换

> 图片已省略：PCG Biome Reference

调用自身的 BiomeCore_ChildTransformLoop 子图表的截图。

在群系核心中，根资产可以有子资产。**子资产** 的资产类型与父资产相同，其自身也可以有子资产，从而构成资产层级。与根资产不同，子资产不是使用 **发生器图表** 生成的。它们使用其父点作为输入，并使用变换图表生成最终的点。

所有层级级别的所有资产（包括根资产）都支持变换图表执行以改变其输入点。

变换图表是分配给资产的简单PCG图表，它们从其父资产获取点数据作为输入，这可以从根资产的发生器图表获取，也可以从父资产的变换图表输出获取。

从其输入点开始，它们可以执行PCG框架提供的所有操作，例如复制、拷贝点、取样和投射点。这在放置子资产时尤其有用。

使用UE 5.4中PCG的新 **递归子图表** 功能，可以执行层级中所有子资产的放置。该过程如下所述。

对于任何一组给定的点，按资产：

- 对一组点运行变换图表，以复制和/或改变其位置（子资产放置模式）
- 应用比例/边界
- 应用自修剪（可选）
- 分配网格体/材质/网格体属性覆盖/程序集/Actor属性，用于最终资产生成
- 输出用于生成的点
- 从当前资产解析潜在的子资产
- **将生成的点和子资产馈送到同一个子图表**。这是执行递归的地方，该过程将无限运行，直至找不到子资产、输入/父点，或达到BiomeCore PCG图表的 **最大子资产深度（Max Child Asset Depth）** 属性为止。

为了控制递归生成的性能，我们设置了限制，以控制允许发射子点的父点数量。此限制由群系核心图表的 **子输入点比率乘数（Child Input Points Rate Multiplier）** 属性控制。

请务必注意，资产可以在相同递归级别发射多个子资产。同一个父资产的子资产分布使用其权重属性加权。

#### 生成

点获得其最终变换和网格体/Actor/程序集属性后，即可用于Actor和网格体生成步骤。

生成步骤相对简单，由可以非独占使用的以下3种方法构成：

1. 在生成 **Actor** 时，将使用SoftClassPath点属性（用于指示要生成的Actor类），为每个点生成Actor。
2. 对于 **静态网格体（Static Meshes）**，使用网格体SoftObjectPath属性指定要由每个点使用ISM组件生成的网格体。它还支持属性重载列表，以对每个点应用各种StaticMesh组件属性：

   - bUseDefaultCollision
   - bCastShadow
   - bCastHiddenShadow
   - DetailMode
   - InstanceStartCullDistance和InstanceEndCullDistance
   - WorldPositionOffsetDisableDistance
   - bIncludeInHLOD
   - bVisible
   - bAffectDistanceFieldLighting
3. **程序集实例化器（Assembly Instancer）** 生成路径用于生成程序集或PCG数据资产（预生成的PCG点云，带有要生成为单个资产的网格体属性）。这需要额外的 **复制点（Copy Points）** 步骤，以将PCG数据资产点云复制到其最终位置，然后再通过普通静态网格体生成器输出。使用此程序集生成路径时，尚不支持静态网格体属性重载。

#### 输出到群系核心运行时

**输出到运行时生成** 是一个可选步骤，它将输出群系核心图表中的数据，由BiomeCoreRuntime图表用于摄像机周围的精细资产的运行时生成。

> 图片已省略：PCG Biome Reference

此功能展示了PCG的 **图表到图表** 通信功能，具体如下所述：

- 图表中的PCG数据通过Output节点传递，以序列化到BiomeCore PCG组件中。
- 其他图表可以使用 **Get PCG Component Data** 节点访问此数据。
- 在BiomeCoreRuntime的情况下，当BiomeCoreRuntime执行时，来自BiomeCore图标/组件的数据会在运行时被访问。
- 一个图表可以使用多个已命名的引脚同时导出和序列化多个数据集。使用 **Get PCG Component Data** 节点访问不同图表中的数据时，必须提供预期引脚数组，且引脚名称需匹配提供数据的图表的输出引脚名称。

> 图片已省略：PCG群系参考

使用多个引脚从BiomeCore导出的数据。

> 图片已省略：PCG群系参考

以及BiomeCoreRuntime中对应的 Get PCG Component Data 节点。

BiomeCoreRuntime主要功能包括：

- 通过运行时取样，在地形上生成点
- 在BiomeCore生成的网格体上生成点
- 将BiomeCore点用作影响来吸引或排斥运行时生成的点

为了支持这些功能，BiomeCore每次运行时会使用 **BiomeCore_PrepareRuntimeData** 子图表预计算4个单独的点数据集：

- BiomePoint是BiomeCache中的点，在该点处，群系缓存会使用最终资产点位置和群系颜色更新，来解释群系混合抖动过程。BiomeCoreRuntime使用缓存解析群系信息并决定要生成哪个资产。
- InfluencePoint是BiomeCore中充当影响的点，使用BiomeAsset的RuntimeOptions分段下的 **InfluenceType** 属性。
- 实例点用作接收运行时细节的网格体的目标位置。
- 网格体点使用网格体取样器过程在局部空间中生成，该过程使用BiomeAsset的RuntimeOptions分段下的 **ExportPoints** 属性。

> 图片已省略：PCG Biome Reference

群系混合之前的BiomeCache。

> 图片已省略：PCG Biome Reference

群系混合之后的BiomeCache。

使用此数据的精细资产的运行时生成在[BiomeCore运行时](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#biomecore%E8%BF%90%E8%A1%8C%E6%97%B6)小节中介绍。

如需详细了解PCG框架的运行时分层生成功能，请参阅[运行时分层生成](https://dev.epicgames.com/documentation/404)。

#### 注入的数据

"群系核心中注入的数据"这个术语定义了在不同的关键步骤中发送到系统以增加手动、半手动和更多美术控制的外部数据。注入的数据主要有4种类型：**排除项（Exclusions）** 、 **类型（Typed）** 、 **特定（Specific）** 、 **自定义群系（Custom Biome）** 数据。所有注入的数据输入都包含在BiomeCore PCG图表中的蓝色注释框中。所有注入的数据类型都有预制蓝图类，并可以扩展。

> 图片已省略：PCG Biome Reference

##### 排除项

体积、图元或样条线中的二元排除项，用于删除与这些排除项数据重叠的生成的点。非常适合用于隔离一个区域进行手动放置，例如POI、建筑物，或用于特定美术/Gameplay需要。

排除项针对体积、图元和闭合样条线使用标记有"BiomeExclusion"的组件，或在开放样条线的情况下使用标记有"BiomePath"的组件，搜索带有标签"PCG_BiomeExclusion"的Actor。

示例：

在下图中，预配置的BP_PCGBiomeExclusionVolume和Spline被添加到右下象限，产生空白空间。黄色的开放样条线路径基于其控制点比例属性，沿样条线体积删除树木。

> 图片已省略：PCG Biome Reference

##### 类型群系数据

在将群系和资产应用倒点之前，与发生器并行注入管线中的点。

这些注入的点来自手动放置的类型群系数据Actor（带有发生器类型属性的蓝图类、PCG组件和PCG图表），输出标记有引用的发生器的点。由于这些注入的点的表现与发生器中的点相同，分配给该发生器的资产在群系资产列表中是必需的。在多个群系/资产中使用共享发生器引用时，要在类型点输出上生成的所选资产将根据Actor放置到的群系而异。

示例：

使用树木作为其发生器类型的类型群系Actor。树在此位置生成，所选资产基于群系定义和群系资产。产生的生成网格体/Actor将根据群系自动发生变化。

在群系示例关卡中，如果类型群系数据引用了Shared_Trees发生器，它可以自动在沙漠群系中生成一株仙人掌，在阔叶林群系中生成一棵落叶树，或在针叶植物群系中生成一棵云杉。

> 图片已省略：PCG群系参考

沙漠群系中的仙人掌

> 图片已省略：PCG群系参考

阔叶林群系中的落叶树

> 图片已省略：PCG群系参考

针叶植物群系中的云杉

##### 特定群系数据

在应用群系和资产之后，递归变换和生成之前，与其他点一起注入管线的点。它们使用特定群系数据Actor（带有Asset变量的蓝图类、PCG组件和PCG图表）上设置的资产定义，输出标记有它们表示的特定资产的点。

使用特定群系数据Actor的优势是通过使用特定逻辑的PCG图表进行精确控制，确定哪些资产应该生成并受益于数据资产结构、变换图表、筛选、从优化的ISM中的群系核心生成并潜在发送到运行时群系核心。

示例：

特定Actor是使用BirchTree01资产设置的。确切的BirchTree01网格体和递归子资产将在此点上生成，无论它放置在任何群系中的任何地方。

群系示例关卡有两个示例，一个是生成单个树木资产的特定Actor，还有一个是农田发生器Actor。后者有其自己的、使用样条线和投射的自定义PCG图表逻辑，其自己的一组资产引用被分配给输出点，然后由群系核心来变换、筛选和生成。它是单独的工具，其输出由核心系统收集和处理。

> 图片已省略：PCG Biome Reference

##### 自定义群系数据

自定义群系数据是独立的，有其自己的独立自定义逻辑和输出。其点数据输出在管线就快结束的时候注入，然后生成并输出到群系核心运行时。由于它是完全自定义且独立的，它可以像生成网格体那样自行生成构件，同时将数据输出到群系核心以受益于全局生成。它还可以为与群系核心不相关的其他任何图表输出数据。将其输出传递到群系核心以生成其点时，点必须有用于生成的属性，主要是"网格体"软对象路径。

示例：

- 自定义洞穴工具通过PCG图表逻辑、蓝图和一组变量编译。洞穴Actor必须保存其自己的触发器盒体、Gameplay Actor和生成器，同时所有网格体都可以由群系核心生成。
- 包含手动创建的小木屋的关卡实例Actor是群系和自定义数据的排除项数据，因为它根据一组要由群系核心生成的网格体和Actor生成周围环境。

## 输入

### 群系Actor和设置

群系Actor由群系核心中可用的蓝图类构成，用于设置世界中的群系。这包括群系体积/样条线和群系设置Actor。

蓝图类可在下面找到：

`/Script/Engine.Blueprint'/PCGBiomeCore/Blueprints/BP_PCGBiomeVolume.BP_PCGBiomeVolume'` `/Script/Engine.Blueprint'/PCGBiomeCore/Blueprints/BP_PCGBiomeSpline.BP_PCGBiomeSpline'` `/Script/Engine.Blueprint'/PCGBiomeCore/Blueprints/BP_PCGBiomeSetup.BP_PCGBiomeSetup'`

#### 群系体积和样条线

对于群系核心，最简单的入门方法是使用群系体积和样条线Actor。设置之后，它们可以缩放或改变形状（样条线）、复制、在整个世界中实例化并被导出为子蓝图类，以在多个世界中复用，同时有单个源类可使用。

> 图片已省略：PCG群系参考

属性：

1. **Actor变换和组件**：支持Actor变换（位置、旋转、缩放）。样条线形状可以自定义，并可以在世界中直接添加新的控制点，样条线必须保持为闭合样条线。对于体积，可以修改"BiomeVolume"盒体碰撞组件。
2. **定义**：对群系定义数据资产的引用，用于通过颜色、名称和优先级识别此Actor表示的群系。必须将群系定义分配给每个群系体积/样条线。
3. **资产数组**：对群系资产的引用，这是要在此群系内处理和生成的资产的列表。由于此属性是数组，可以添加多个群系资产以方便使用和分类，或用于在不同群系中共享相同资产。如果世界中存在共享相同定义的另一个群系体积、样条线或设置，而且其资产数组已经配置，则不需要复制相同列表。
4. **运行时资产（Runtime Assets）**：对将在群系核心运行时生成中用于此群系的群系资产数据资产的引用。这些是可选的，仅在使用群系核心运行时的时候需要。
5. **ZExtents**：定义在使用群系样条线Actor时群系的高度。非常大的值意味着，此群系在整个BiomeCore体积高度中应用于2D，而较小的值则需要针对表面调整样条线。

#### 群系设置

群系设置Actor用于全局定义世界中的群系。它很适合被视为群系设置（定义+资产）的源，并且在处理可选的BiomeMap纹理投射时是必需的。它们还可以被导出为子蓝图类，并在其他世界中复用，作为单一事实来源，并更轻松地设置世界。

> 图片已省略：PCG群系参考

属性：

1. **定义** ：对群系定义数据资产的引用，用于通过颜色、名称和优先级识别此Actor表示的群系。必须将群系定义分配给每个群系设置。
2. **资产数组** ：对群系资产数据资产的引用，这是要在此群系内处理和生成的资产的列表。由于此属性是数组，可以添加多个群系资产以方便使用和分类，或用于在不同群系中共享相同资产。由于群系设置可以被视为全局的群系体积，因此样条线在与引用相同群系定义的群系设置Actor配对时不需要资产。
3. **运行时资产（Runtime Assets）** ：对将在群系核心运行时生成中用于此群系的群系资产数据资产的引用。这些是可选的，仅在使用群系核心运行时的时候需要。

### 群系定义

群系定义模板是从 **BiomeDefinitionTemplate** 继承的 **PrimaryDataAsset** 类。

BiomeDefinitionTemplate及其对应结构的示例可在下面找到：

`/Script/Engine.Blueprint'/PCGBiomeCore/BiomeDefinitions/Setup/BiomeDefinitionTemplate.BiomeDefinitionTemplate'` `/Script/Engine.UserDefinedStruct'/PCGBiomeCore/BiomeDefinitions/Setup/BiomeDefinition.BiomeDefinition'`

必须在每个群系体积/样条线/设置Actor中引用群系定义资产，以定义它们表示哪个群系。

基本BiomeDefinition结构属性：

> 图片已省略：PCG群系参考

- **BiomeName**：用于在调试和检查群系核心时识别群系。对生成没有实际影响。
- **BiomeColor**：用于识别群系并将生成的点匹配到根资产表中的资产条目的唯一颜色（RGB）。群系必须有唯一的颜色。
- **BiomePriority**：重叠群系插入群系缓存时，特定于群系的优先级。值越低，优先级越高。

### 群系资产和结构

BiomeAsset模板是从BiomeAssetBaseTemplate继承的 **PrimaryDataAsset** 类。要兼容BiomeCore， **BiomeAssetBaseTemplate** 的子类必须提供名为 **BiomeAssets** 的 **结构数组**。

BiomeAssetBaseTemplate及其对应结构的示例可在下面找到：

`/Script/Engine.Blueprint'/PCGBiomeCore/BiomeAssets/Setup/BiomeAssetTemplate.BiomeAssetTemplate'` `/Script/Engine.UserDefinedStruct'/PCGBiomeCore/BiomeAssets/Setup/BiomeAsset.BiomeAsset'`

`/Script/Engine.Blueprint'/PCGBiomeCore/Runtime/BiomeRuntimeAssetTemplate.BiomeRuntimeAssetTemplate'` `/Script/Engine.UserDefinedStruct'/PCGBiomeCore/Runtime/BiomeRuntimeAsset.BiomeRuntimeAsset'`

`(BiomeSample Plugin)` `/Script/Engine.Blueprint'/PCGBiomeSample/BiomeAssets/Setup/BiomeSample_BiomeAssetTemplate.BiomeSample_BiomeAssetTemplate'` `/Script/Engine.UserDefinedStruct'/PCGBiomeSample/BiomeAssets/Setup/BiomeSample_BiomeAsset.BiomeSample_BiomeAsset'`

BiomeAsset结构通常有多个用于将属性分类的子结构。可以基于项目需要轻松创建不同类型的BiomeAsset模板，共享一个或多个子结构。

基本BiomeAsset结构属性：

> 图片已省略：PCG群系参考

- **已启用（Enabled）**：用于禁用资产，而不将其从资产数组中删除。
- **权重（Weight）**：共享公共发生器图表的资产被分配给生成的点时，Weight属性用于影响资产被选中的概率。
- **发生器（Generator）**：对BiomeGenerator资产的引用，用于提供负责生成PCG点的PCG图表。
- **GeneratorSubType**：可选，这是一张用逗号分隔的列表，列出了用于选择要使用的发生器输出的发生器子类型。
- **TransformGraph**：可选，对一个PCG图表的引用，该图表在生成资产之前使用发生器中的点并变换它们。
- **网格体（Mesh）**：对静态网格体资产的引用。
- **程序集（Assembly）**：对PCG数据资产的引用。
- **Actor** ：对Actor类的引用。
- **ChildAssets**：要生成为此资产的子资产的BiomeAsset的数组。ChildAssets使用其变换图表生成其相对于父资产的位置。
- **DebugOptions**：BiomeAsset_DebugOptions子结构。

  - **隔离（Isolate）**：为true时，仅生成隔离的资产。
  - **ShowBounds**：绘制与资产关联的点的线框边界。
- **AssetOptions**：BiomeAsset_AssetOptions子结构

  - **OverlapWithChildren**：为false时，点边界将被用作差异，以删除与当前资产重叠的子资产。
  - **ForceAssetScale**：将比例属性应用于点，无论变换图表应用的比例是多少。如果希望由变换图表控制比例，则使其保持false。
  - **ExtentsMultiplier**：默认情况下，点边界通过资产的网格体/Actor/程序集的构成边界计算。此属性充当计算的边界的乘数，将影响与其他发生器/子资产和自修剪操作中的点对比的结果。当树冠边界相较于树干太大时，适合用于树木资产。
  - **平移/旋转/缩放（Translation/Rotation/Scale）**：应用于Actor/静态网格体/程序集的偏移，用于补偿枢轴点位置，适合不同大小/方向的资产共享同一个发生器的情况。
  - **OrientUpward**：渐进式混合从发生器到Z轴朝上的资产方向。（即，基于表面样本的发生器的地形法线）
  - **SelfPrune**：对生成的点应用自修剪操作，使用应用了Extents乘数因子的资产计算边界，以清理重叠的点。
  - **SelfPruningExtentsMultiplier**：专门应用于自修剪的点范围的额外乘数。允许控制自修剪期间使用的边界，而不影响使用资产边界的其他操作。
- **MeshOptions**：BiomeAsset_MeshOptions子结构

  - **材质（Material）**：可选，作为重载应用于静态网格体材质的单个材质。
  - **AllowCollision**：为true时，资产将使用静态网格体中的碰撞预设。为false时，将使用NoCollision预设。
  - **可见（Visible）**：转换为静态网格体组件的名称类似的属性。
  - **CastShadow**：转换为静态网格体组件的名称类似的属性。
  - **CastHiddenShadow**：转换为静态网格体组件的名称类似的属性。
  - **AffectDistanceFieldLighting**：转换为静态网格体组件的名称类似的属性。
  - **DetailMode**：转换为静态网格体组件的名称类似的属性。（0到3 = 低到Epic）
  - **StartCullDistance/EndCullDistance**：转换为静态网格体组件的名称类似的属性。
  - **WorldPositionOffsetDisableDistance**：转换为静态网格体组件的名称类似的属性。
  - **IncludeInHLOD**：转换为静态网格体组件的名称类似的属性。
- **AssemblyOptions**：BiomeAsset_AssemblyOptions子结构

  - AllowCollision

    ：为true时，资产将使用程序集/PCG数据资产静态网格体中的碰撞预设。为false时，将使用NoCollision预设。
- **FilterOptions**：BiomeAsset_FilterOptions子结构。

  - **DensityMin/Max**：密度值超出此范围的点将被废弃。
  - **HeightMin/Max**：Position.Z值超出此范围的点将被废弃。
  - **WaterDistanceMin/Max**：BiomeFilter_WaterDistance_Level_Inst中配置的水位以下的点被视为水下，使用Distance节点用算水上的点到水下最近点的3D距离。WaterDistanceMin/Max范围中的点将保留。
- **RuntimeOptions**：BiomeAsset_RunTimeOptions子结构。

  - **ExportPoints**：启用资产的静态网格体的取样，并导出世界空间中的资产位置，以在运行时生成点，获得覆盖静态网格体的额外细节。
  - **MeshSamplingRadius**：控制网格体取样器生成的点的数量
  - **NormalOffset**：用于基于法线方向删除网格体取样器生成的点。
  - **ScaleMultiplier**：用于缩放网格体取样器生成的点
  - **ZMin/ZMax**：控制网格体取样器生成的点的最小和最大高度范围。
  - **InfluenceType**：控制资产是添加还是删除周围由运行时生成的细节。
  - **InfluenceRadius**：资产点周围的半径，其中应用了InfluenceType

### 发生器

群系发生器模板是继承自 **BiomeGeneratorTemplate** 的 **PrimaryDataAsset** 类。

BiomeGeneratorTemplate及其对应结构的示例可在下面找到：

`/Script/Engine.Blueprint'/PCGBiomeCore/BiomeGenerators/Setup/BiomeGeneratorTemplate.BiomeGeneratorTemplate'` `/Script/Engine.UserDefinedStruct'/PCGBiomeCore/BiomeGenerators/Setup/BiomeGenerator.BiomeGenerator'`

必须在每个群系资产条目中引用群系发生器资产，才能定义它们所属的根点数据。子资产不需要发生器引用，除非它们同时被用作根资产和子资产。

基本BiomeGenerator结构属性：

> 图片已省略：PCG群系参考

- **GeneratorType**：用于识别发生器的唯一名称。所有发生器必须有唯一的名称，并可以在多个群系的多个资产中复用。
- **GeneratorPriority* ：通过基于优先级的对比反馈循环对点数据分层时使用的优先级。值越低，优先级越高。有相同值的发生器在重叠时不会相互影响。
- **GeneratorAllowOverlap**：启用后，会完全绕过通过基于优先级的对比进行的分层过程。发生器生成的所有点在此过程中将保留，不会影响其他发生器点数据。
- **GeneratorGraph**：必需的PCG图表或PCG图表实例引用，将执行它以生成根点。
- **GeneratorSpatialNoiseSettings**：通过PCG图表从空间噪点PCG节点导出的对SpatialNoiseSettings资产的可选引用。存在时，此空间噪点设置将控制资产的加权分布，而不是使用随机点种子。

### 变换

变换图表获取发生器中的点或父变换的点作为输入，在生成步骤之前改变它们。

这些图表对于根资产是可选的，但在大部分情况下对于子资产是必需的，因为没有变换图表，子资产将在与父资产相同的位置生成。推荐使用图表实例参数化并控制每个资产的变换图表的行为，但直接使用图表也可以。

BiomeCore提供了几个简单的变换图表，最有意思的示例是 **BasicSecondaries** 和 **DuplicatePattern** 。

`/Script/PCG.PCGGraph'/PCGBiomeCore/Transforms/BasicSecondaries.BasicSecondaries'` `/Script/PCG.PCGGraph'/PCGBiomeCore/Transforms/DuplicatePattern.DuplicatePattern'`

**BasicSecondaries** 在每个输入点周围创建几个点，并将其投射到地形上。

该过程的工作方式如下：

1. 获取输入点。
2. 使用CreatePointsGrid节点编译点的2D网格。
3. 删除网格的角点，使其更圆。
4. 使用CopyPoints将网格复制到每个输入点。
5. 随机删除50%的已复制点。
6. 将随机变换应用于点。
7. 基于点与每个网格中心的距离来缩放点。
8. 将结果投射到地形上。

> 图片已省略：PCG Biome Reference

BasicSecondaries变换图表

> 图片已省略：PCG Biome Reference

应用于2次子资产生成的BasicSecondaries变换图表（红色/绿色）

**DuplicatePattern** 使用Duplicate Point节点实现旋转星形状：

1. 重置输入点旋转。
2. 复制输入点9次，将每个副本绕Z轴旋转36度。
3. 将9个副本各自复制10次，对于每个副本，绕Z轴旋转10度，沿局部X轴平移，并将点缩减80%。
4. 投射到地形。

> 图片已省略：PCG Biome Reference

DuplicatePattern变换图表

> 图片已省略：PCG Biome Reference

应用于2次子资产生成的DuplicatePattern变换图表（红色/绿色）

> 图片已省略：PCG Biome Reference

应用于第1次子资产生成的DuplicatePattern变换图表（红色），应用于第2次生成的DuplicatePattern变换图表（绿色）

### 筛选器

根点和子点可以从BiomeCore_Filters PCG图表或其实例中的可自定义筛选器列表中筛选。筛选器数组中的每个筛选器条目都有FilterGraph、FilterAttribute、FilterRangeMinAttribute和FilterRangeMaxAttribute。每个FilterGraph在BiomeCore执行期间通过反馈循环按它们在筛选器列表中显示的顺序处理。

要处理的筛选器图表在BiomeCore图表参数（ **根点筛选器（Root Points Filters）** 和 **子点筛选器（Child Points Filters）** ）中全局设置。默认情况下，群系核心设置为使用BiomeCore_Filters_Inst，它按高度（Height）、密度（Density）和水距离（WaterDistance）筛选。

BiomeCore图表参数根点和子点筛选器引用：

> 图片已省略：PCG群系参考

每个条目的BiomeCore_Filters_Inst列表和属性：

> 图片已省略：PCG Biome Reference

BiomeCore筛选器图表可以位于下面的位置：

`/Script/PCG.PCGGraph'/PCGBiomeCore/Core/BiomeCore_Filters.BiomeCore_Filters'` `/Script/PCG.PCGGraphInstance'/PCGBiomeCore/Core/BiomeCore_Filters_Inst.BiomeCore_Filters_Inst'`

BiomeSample筛选器扩展为展示如何自定义列表并包括纹理投射筛选器，文件可以位于下面的位置：

`/Script/PCG.PCGGraphInstance'/PCGBiomeSample/Setup/BiomeSample_Filters_Inst.BiomeSample_Filters_Inst'` `/Script/PCG.PCGGraphInstance'/PCGBiomeSample/Filters/BiomeFilter_Flow_Projection.BiomeFilter_Flow_Projection'` `/Script/PCG.PCGGraphInstance'/PCGBiomeSample/Filters/BiomeFilter_SunExposure_Projection.BiomeFilter_SunExposure_Projection'`

动态反馈循环通过对筛选器数组中的FilterGraph集进行迭代，处理所有传入的根点和子点数据。当前迭代后剩余的点将变成下一次迭代的输入，基于资产筛选器选项渐进式剔除点。

> 图片已省略：PCG Biome Reference

处理步骤：

1. 要为当前循环迭代处理的传入点数据。第一次迭代从所有点开始，然后后续每次迭代接收上一次迭代后剩余的点，直至处理完所有筛选器为止。
2. 筛选器数组条目中的动态FilterGraph集。预期它将在所有点上处理并写入设置的FilterAttribute。在筛选简单的点属性（例如 $密度或 $位置），但筛选器图表也可以根据需要重载这些属性（例如，对传入点 $密度应用空间噪点作为乘法）时，此图表是可选的。
3. 使用每个资产筛选器选项中设置的FilterRangeMinAttribute到FilterRangeMaxAttribute值范围内的FilterAttribute筛选点。
4. 将筛选之后剩余的所有点输出到反馈点输出引脚。这些将是下一次迭代要处理的传入点，或完成所有迭代后筛选过程的最终输出。

## 高级设置

### 群系核心图表参数

BiomeCore PCG组件上公开为图表参数重载的全局参数概述：

> 图片已省略：PCG群系参考

#### 群系混合范围

将抖动应用于发生器生成的点，然后再为其分配群系缓存中的群系颜色。这是应用于所有生成的点的全局抖动值。

> 图片已省略：PCG Biome Reference

群系混合范围值0

> 图片已省略：PCG Biome Reference

群系混合范围值2500

#### 调试显示群系缓存

显示群系缓存的视觉表示，包括群系颜色和缓存单元格大小。

> 图片已省略：PCG Biome Reference

#### 群系缓存单元格大小

配置缓存分辨率。

- 值以厘米为单位。
- 较大的Z值可用于生成2D缓存。
- 较小的单元格大小值将产生更多单元格和更精确的群系定义，代价是性能会更低。

> 图片已省略：PCG Biome Reference

缓存单元格大小值3200, 3200, 1024000

> 图片已省略：PCG Biome Reference

缓存单元格大小值3200, 3200, 3200

> 图片已省略：PCG Biome Reference

缓存单元格大小值800, 800, 1600

#### 最大子资产深度

控制在生成子资产时要达到的最大递归级别。

- 值为0时将完全禁用子资产生成。
- 对高级别群系位置迭代，或为不同平台生成优化内容时，可用作性能与细节级别之间的权衡。
- 子资产可以引用自身，潜在创建无限递归。最大子资产深度参数可防止发生此情况。
- 详见[递归和变换](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#%E9%80%92%E5%BD%92%E5%92%8C%E5%8F%98%E6%8D%A2)小节。

> 图片已省略：PCG Biome Reference

最大子资产深度值为0

> 图片已省略：PCG Biome Reference

最大子资产深度值为1

> 图片已省略：PCG Biome Reference

最大子资产深度值为2

#### 子输入点比率乘数

限制允许发射子资产的点的数量。

> 图片已省略：PCG Biome Reference

子输入点比率乘数值为1

> 图片已省略：PCG Biome Reference

子输入点比率乘数值为10

> 图片已省略：PCG Biome Reference

子输入点比率乘数值为100

#### 运行时生成的输出数据

允许将BiomeCore图表输出数据序列化到BiomeCore PCG组件，供BiomeCoreRuntime PCG图表使用。默认禁用以提高性能，在群系示例中启用可展示BiomeCore运行时。

- 还将允许BiomeCoreRuntime使用的资产网格体的取样。
- 请参阅[生成和输出到BiomeCore运行时](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#%E7%94%9F%E6%88%90)小节。

#### 绕过全局筛选器

跳过全局点筛选步骤。请参阅此文档的[筛选](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#%E7%AD%9B%E9%80%89)小节。

### 群系纹理投射

在世界中布局群系时，可以选择使用群系纹理，而且它可以与群系体积或样条线共存。由于此方法对于世界中的BiomeCore Actor是全局的，需要将群系纹理投射实例图表分配给BiomeCore。对于纹理中的每种颜色，世界中的群系Actor必须提供使用相同颜色的群系定义。

> 图片已省略：PCG群系参考

群系示例关卡展示了此方法。BiomeSample_BiomeTextureProj_Inst已设置为通过不同的平铺和UV坐标选项支持纹理和2D纹理数组投射。

> [!NOTE]
> 群系核心目前需要一个地形，群系缓存初始化才能生成可以接收群系纹理数据的缓存点。

文件位于下面的位置：

通用纹理投射源图表： `/Script/PCG.PCGGraph'/PCGBiomeCore/Core/BiomeCore_ProjectTexture.BiomeCore_ProjectTexture'`

BiomeSample实例： `/Script/PCG.PCGGraphInstance'/PCGBiomeSample/Setup/BiomeSample_BiomeTextureProj_Inst.BiomeSample_BiomeTextureProj_Inst'`

> 图片已省略：PCG Biome Reference

BiomeSample图表实例属性。

设置后，左侧的纹理被投射到群系缓存点上，将群系定义绑定到纹理颜色。

> 图片已省略：PCG群系参考

> 图片已省略：PCG群系参考

> 图片已省略：PCG群系参考

### 发生器子类型

发生器有唯一的GeneratorType，将资产映射到每个群系生成的点。发生器图表可以选择性地输出多个点数据，即发生器子类型。

子类型由多种通途，可以极大减少创建丰富而复杂的群系所需的发生器图表数量。不同资产的点之间的高级交互最好由发生器子类型处理，因为BiomeCore管线不允许在该过程中访问其他发生器中的点。不同发生器的点数据之间的唯一交互发生在基于优先级的对比分层期间。

用例示例：

> 图片已省略：PCG Biome Reference

> 图片已省略：PCG Biome Reference

- 在地形上生成树木的点，并基于地形层权重创建子类型，如上图所示。这样地形绘制层可以在使用单个发生器时影响群系结果，因为它能基于绘制分布资产来增加总体视觉复杂度，同时维持简单的输入和更少的处理。
- 根据斜面角度，将单个发生器中要由不同程序集或网格体使用的点分开。
- 复制发生器中的点，以应用特定变换来生成Actor，例如Niagara系统、声音、贴花甚至是Gameplay物品。

为了帮助在发生器图表中创建发生器子类型，BiomeCore中提供了一个预制PCG子图表，用于基于属性筛选数据并生成两个单独的输出。此子图表还可以在循环中链接或使用，创建两个以上的单独子类型。

预制PCG子图表位于下面的位置：

`/Script/PCG.PCGGraph'/PCGBiomeCore/BiomeGenerators/Graphs/BiomeGenerator_SubGeneratorSetup.BiomeGenerator_SubGeneratorSetup'`

在下图中，地形表面使用其层权重取样，然后使用子图表为每个层（陆地、山峰、海岸）创建子类型。

> 图片已省略：PCG Biome Reference

发生器图表开始输出子类型后，必须使用GeneratorSubType属性指定应该将资产分配到哪个或哪些发生器子类型。可以使用逗号分隔的列表一次性将一个资产分配到多个子类型。

对于上面显示的地形绘制示例，群系示例中的阔叶林资产基于每个地形绘制层分配有不同的子类型。云杉树在海岸和山峰层上生成，而其他所有资产则在海岸和陆地上生成，这样云杉树就仅在使用单个发生器绘制山峰层的地方出现。

> 图片已省略：PCG群系参考

### 分区和分层生成

BiomeCore PCG组件在默认情况下不分区，但BiomeCore图表是围绕分区编译的。

- 可以在BiomeCore PCG组件上打开 **分区（Is Partitioned）** 选项来启用分区。默认情况下，将根据PCG世界Actor的分区网格大小设置，按256x256米的区块对生成进行分区。
- 还可以启用高级 **分层生成** ，方法是同时启用PCG组件上的 **分区（Is Partitioned）** 和BiomeCore PCG图表设置中的 **使用分层生成（Use Hierarchical Generation）** 选项。在该模式中，群系缓存和根资产表在未绑定关卡中生成（对整个世界生成一次），其余生成使用图表中多个点处的Grid Size节点按256x256米的区块分区。

> 图片已省略：PCG群系参考

> 图片已省略：PCG群系参考

用于启用图表分区和分层生成的选项。

> 图片已省略：PCG Biome Reference

若在检查树状图中选择BP_PCGBiomeCore PCG组件，会高亮显示在未绑定关卡中执行的节点。

在编辑器中，启用分区或运行时分层生成会增加完全重新生成所需的时间，但部分更新群系会更快，例如在操控世界中的群系体积或群系样条线时。

将BiomeCore用于使用WorldPartition关卡制作游戏时，也推荐对PCG组件分区，以在运行时启用PCG分区Actor的流送。

## BiomeCore运行时

> 图片已省略：PCG Biome Reference

BiomeCoreRuntime调试显示：群系缓存中由BiomeCoreRuntime使用的点，以及显示其群系颜色的输出点。

### 概述

BiomeCore运行时是单独的PCG组件和图表，用于摄像机周围的精细资产的运行时生成。它使用BiomeCore预生成的数据，并利用运行时分层生成以在运行时生成大量PCG点。

#### 启用运行时生成

要在编辑器中预览运行时生成，启用PCGWorldActor的 **将编辑器视口视为生成源（Treat Editor Viewport as Generation Source）** 选项：

> 图片已省略：PCG群系参考

这样做将在摄像机周围生成点并生成资产。请注意，在PIE会话或烘焙构建中，玩家位置会被自动用作运行时生成源。

#### 运行时资产

由运行时生成使用的资产是简化类型的群系资产，被分配给BiomeActor，例如设置、样条线和体积。目前每个BiomeActor仅支持一个运行时资产，包含加权资产的数组。

> 图片已省略：PCG群系参考

分配给MountainForest群系设置Actor的MountainForest RuntimeAsset。

> 图片已省略：PCG Biome Reference

MountainForest RuntimeAsset属性。

#### 运行时分层生成设置

运行时分层生成使用以下设置启用：

在BiomeCore运行时组件中：将 **生成触发器（Generation Trigger）** 设置为 `在运行时生成（Generate At Runtime）`，将 **分区（Is Partitioned）** 属性设置为 `True` 。

> 图片已省略：PCG群系参考

在BiomeCoreRuntime图表设置中：将**使用分层生成（Use Hierarchical Generation）** 属性设置为 `true`，将 **分层生成默认网格大小（Higen Default Grid Size）** 设置为 `未绑定（Unbounded）`，这意味着放在Grid Size节点之前的任何节点都将在未绑定网格关卡仅执行一次。

> 图片已省略：PCG群系参考

同样在图表设置中，用于控制生成距离的半径参数由网格大小定义。对于网格大小400，该参数目前设置为1600厘米。增加此值将在更远的地方生成细节，并增加要处理的运行时分区Actor数量。

> 图片已省略：PCG群系参考

BiomeCoreRuntime的分层生成在两个关卡运行：

- **未绑定关卡**，适用于需要对整个关卡发生一次的操作。
- **400厘米网格大小关卡** 中运行时分区Actor的网格，适用于需要在摄像机周围频繁更新的操作。

### 图表参数

> 图片已省略：PCG群系参考

以下两个属性公开为图表参数：

- 群系混合范围：BiomeCore运行时支持运行时资产的基本混合。混合距离由此参数控制。
- 显示点：用于显示BiomeCore运行时生成的点，以及群系缓存中使用其单独的群系颜色着色的点。

> 图片已省略：PCG Biome Reference

将DisplayPoints选项打开：显示使用其关联的群系着色的点。群系混合在红色和蓝色群系之间可见。

### 图表概述

本文档的[输出到群系核心运行时](https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-reference-guide-in-unreal-engine-2#%E8%BE%93%E5%87%BA%E5%88%B0%E7%BE%A4%E7%B3%BB%E6%A0%B8%E5%BF%83%E8%BF%90%E8%A1%8C%E6%97%B6)小节中介绍了由BiomeCore导出并由BiomeCore运行时作为输入使用的数据。

#### 输入

- 网格体点通过对BiomeCore资产网格体取样来生成。
- 实例点是在世界中放置网格体点的目标位置。
- InfluencePoint是BiomeCore中的点，充当局部影响，以增加或减小地形上生成的点的数量。
- BiomePoint是BiomeCache中的点，表示群系在世界中的位置。

#### 世界中取样的网格体点位置

> 图片已省略：PCG Biome Reference

在 **BiomeCore运行时CopyPoints循环子图表（BiomeCore Runtime CopyPoints Loop subgraph）** 中，网格体点在世界中的对应位置（由实例点表示）复制。此过程在 **400厘米网格大小关卡** 中的分区Actor网格中执行。

> 图片已省略：PCG Biome Reference

红色线框立方体表示400厘米分区Actor，大轴小工具表示目标实例点，小灰点是在每个实例点位置复制的取样的网格体点。

#### 地形表面取样器和BiomeAssets影响

> 图片已省略：PCG Biome Reference

表面取样器在每个400厘米分区Actor中的地形表面上运行。空间噪点作为密度应用于结果，影响点根据其InfluenceType值在最终密度中增减。

> 图片已省略：PCG Biome Reference

云杉树影响（RemoveGrass）

> 图片已省略：PCG Biome Reference

仙人掌树影响（AddGrass）

> 图片已省略：PCG Biome Reference

最终密度值

> 图片已省略：PCG Biome Reference

最终效果

#### 计算群系权重和混合

> 图片已省略：PCG Biome Reference

对于每个400厘米分区Actor，群系缓存中的点在群系混合范围指定的范围内收集。缓存点使用其颜色属性分区，每个单独的群系颜色的点数量用于计算分区Actor的每个群系的相对权重。

群系颜色根据计算的相对权重值分布到每个分区Actor中生成的点。

例如，如果在第一步期间，分区Actor周围收集到的群系点表示3个群系，比例为每个群系各33%，则分区Actor生成的最终点将采用该比例，因此群系A、群系B、群系C各自分配到33%的点。

> 图片已省略：PCG Biome Reference

使用显示点图表属性：群系混合范围值400厘米

> 图片已省略：PCG Biome Reference

使用显示点图表属性：群系混合范围值800厘米

> 图片已省略：PCG Biome Reference

使用显示点图表属性：群系混合范围值1600厘米

> 图片已省略：PCG Biome Reference

使用显示点图表属性：群系混合范围值3200厘米

#### 解析群系资产

> 图片已省略：PCG Biome Reference

类似于群系核心主图表中执行的操作，通过关卡的群系Actor中找到的运行时资产编译资产属性表。该表包含资产权重、网格体路径、材质路径、比例和群系颜色。图表的此部分在未绑定网格关卡中生成，意味着它仅执行一次，而不是针对每个分区Actor执行，并且其输出可用于所有更小的网格关卡。

> 图片已省略：PCG Biome Reference

未绑定网格关卡的资产表输出检查，由BiomeCoreRuntime组件处理。

最后，使用点和资产颜色值，资产属性会在最终网格体生成步骤之前使用Match And Set Attributes节点添加到点。

> 图片已省略：PCG群系参考

> 图片已省略：PCG Biome Reference

BiomeCore运行时的输出。

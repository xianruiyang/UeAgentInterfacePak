---
title: "地形材质"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/landscape-materials-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "地形户外地貌", "地形材质"]
---

# 地形材质

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 地形户外地貌 / 地形材质

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/landscape-materials-in-unreal-engine

虚幻引擎（UE）提供了多个特定于地形的[材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)节点，可帮助优化地形纹理。 你可以将这些节点和虚幻引擎中的其他材质一起使用。

> [!NOTE]
> 你可以在[材质编辑器](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-editor-user-guide/index.md)中像创建和修改其他材质那样创建和修改地形材质。

## 图层权重和排序

地形材质就如同多个图层的混合体，绘制的混合权重决定了每一层的影响力。

材质图表决定如何解读权重的解读以实现混合效果。 混合方法决定了最终效果中地形对这些权重的使用方式。

可用的混合模式有二：权重混合和Alpha混合。 你可以结合这些方法以创建不同的效果，例如在草地和泥土层上实现积雪。

| 混合模式 | 说明 |
| --- | --- |
| **权重混合（Weight Blending）** | 为材质的所有图层分别分配一个介于`0`和`1.0`之间的值，表示相应的百分比值。 地形绘制工具会确保权重混合图层的权重值总和不超过`1.0`。 删除多余的值，并适当缩小其他图层，从而使总数恒定为100%。当某一层的绘制权重为100%时，所有其他层的权重值都会变为0%。 这意味着如果你使用[绘制（Paint）](../editing-landscapes/landscape-paint-mode/index.md)工具删除值为100%的图层，则该图层不会被替换，因为所有其他图层的值都是0%。 这会使图层看起来好像没有发生改变。 |
| **Alpha混合（Alpha Blending）** | 为每一图层分配一个介于0到100%之间的Alpha百分比值。 如果材质图表被设为有序混合，则此方法会遵循图层的应用顺序。Alpha层独立于其他加权图层而存在，因此当Alpha图层权重增加时，其他现存图层的权重会减小。 |

## 特定于地形的材质节点

在[材质编辑器](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-editor-user-guide/index.md)中，有几个特定的节点可搭配地形系统使用。 要找到这些节点，请右键点击并搜索上下文敏感菜单，或在**控制板（Palette）**菜单中进行搜索。

![材质编辑器上下文菜单](../../../../assets/images/cc/cca52bfb5551a132b26c98a643e27ac18ee619167705a5c217c17a0122b61135.jpg)

点击查看大图。

### Landscape Layer Blend节点

**Landscape Layer Blend**节点将混合多个逐层数值，例如纹理样本或材质。 图层的混合权重越高，对混合结果的影响就越大。

要添加新图层，请点击加号（**+**）图标。

![图层混合数组元素](../../../../assets/images/de/de5393f6979712db961d1efaee41152bd6ffb53ff361b7cbe055b73ec5465c9e.png)

点击查看大图。

将图层添加到节点中后，LandscapeLayerBlend节点会显示图层的名称。 此节点的输入如下：

![地形图层混合模式](../../../../assets/images/6d/6dda95afbc586fef2a132016032e94c5c82d0e40b1b67974db292740ae622016.jpg)

点击查看大图。

| 编号 | 属性 | 说明 |
| --- | --- | --- |
| **1** | **图层（Layers）** | 列出数组中包含的图层。 点击加号图标 () 即可添加新图层。 |
| **2** | **更多图层（Additional Layers）** | 显示被折叠的额外图层。 |
| **3** | **图层名称（Layer Name）** | 显示图层的唯一名称。 **图层名称**对应在地形工具窗口的[绘制模式](../editing-landscapes/landscape-paint-mode/index.md)中使用的图层名称。 |
| **4** | **混合类型（Blend Type）** | 定义此图层使用的混合模式。 选项如下：**LB Alpha混合（LB Alpha Blend）**、**LB高度混合（LB Height Blend）**或**LB权重混合（LB Weight Blend）**。如需更多信息，请参阅[地形图层混合类型](index.md#landscape-layer-blend-types)。 |
| **5** | **预览权重（Preview Weight）** | 显示在材质编辑器中预览混合时要使用的权重值。 |
| **6** | **常量图层输入（Const Layer Input）** | 定义在不想使用纹理时要使用的RGB值。 适用于图层的调试。 |
| **7** | **常量高度输入（Const Height Input）** | 定义在不想使用纹理时要使用的高度值。 |

**Landscape Layer Blend**节点所用的输入和输出如下：

![Layer Blend节点](../../../../assets/images/1b/1ba9afb5a74abac6e1b138a8b1c85833bb6eaa6f4e69c4212ca80312c3ca3204.jpg)

点击查看大图。

| 编号 | 项目 | 说明 |
| --- | --- | --- |
| **1** | **图层*图层名称***（Layer Layer Name） | 显示图层的唯一名称。 此输入仅在你为**细节（Details）**面板添加并命名图层后才可用。 |
| **2** | **高度*图层名称***（Height Layer Name） | 定义混合被命名图层所用的高度图。 此输入尽在**混合类型（Blend Type）**属性为**LB高度混合（LB Height Blend）**的图层上可见。 |
| **3** | **输出（Output）** | 输出混合后的结果。 |

> [!NOTE]
> 所有图层的名称必须唯一。 建议使用能够表明图层内容的描述性名称来命名图层。

### Landscape Layer Coords节点

**Landscape Layer Coords**节点将生成UV坐标，用于将地形材质映射到地形。

![Landscape Layer Coords节点](../../../../assets/images/35/350b70fdb653dc9cbf234e2772c39415747a110abdeb4e670b2d21c2e2032a86.jpg)

点击查看大图。

此节点具有以下选项：

| 编号 | 属性 | 说明 |
| --- | --- | --- |
| 1 | **映射类型（Mapping Type）** | 指定将材质或网络映射到地形时要使用的方向。 它包含以下选项：**TCMT Auto**：使用地形顶点坐标，范围为[0, OverallLandscapeResolution]**TCMT XY**：使用对象空间XY映射。 等同于TCMT Auto。**TCMT XZ**：使用对象空间XZ映射。 推荐用于侧面投影的纹理。**TCMT YZ**：使用对象空间YZ映射。 推荐用于侧面投影的纹理。 |
| 2 | **自定义UV类型（Custom UVType）** | 输出UV坐标以根据类型将材质映射到地形。 它包含以下选项：**LCCT None**：不使用自定义UV。**LCCT Custom UV0**：使用通道0中的自定义UV。**LCCT Custom UV1**：使用通道1中的自定义UV。**LCCT Custom UV2**：使用通道2中的自定义UV。**LCCT Weight Map UV**：使用原始权重图UV。 |
| 3 | **映射缩放（Mapping Scale）** | 将等分缩放应用于UV坐标。 |
| 4 | **映射旋转（Mapping Rotation）** | 将旋转（以度为单位）应用于UV坐标。 |
| 5 | **映射平移[U]（Mapping Pan [U]）** | 将[U]方向的偏移应用于UV坐标。 |
| 6 | **映射平移[V]（Mapping Pan [V]）** | 将[V]方向的偏移应用于UV坐标。 |
| 7 | **无标记输出（Unlabeled Output）** | 输出UV坐标以根据给定属性值将材质映射到地形。 |

### Landscape Layer Switch节点

你可以使用**Landscape Layer Switch**节点，在特定图层对地形的某个区域无作用时排除某些材质运算。 这样你就可以在图层的权重为零时删除不必要的计算，从而优化材质。

![Landscape Layer Switch节点](../../../../assets/images/24/241521ca5c3e924010fdbfd26325625c71b16aec1ffee00826c5abe21e521f30.jpg)

点击查看大图。

此节点具有以下选项：

| 编号 | 属性 | 说明 |
| --- | --- | --- |
| 1 | **参数名称（Parameter Name）** | 显示参数的唯一名称。 |
| 2 | **已使用预览（Preview Used）** | 如果选中，则使用预览。 |
| 3 | **已使用层（Layer Used）** | 如果当前地形区域使用了特定层，则表示应使用的材质网络。 |
| 4 | **未使用层（Layer Not Used）** | 如果当前地形区域未使用特定层，则表示应使用的材质网络。 |
| 5 | **输出（Output）** | 使用**已使用层（Layer Used）**输入或**未使用层（Layer Not Used）**输入，具体取决于该层是否对特定的地形区域有所贡献。 |

### Landscape Layer Weight节点

你可以使用**Landscape Layer Weight**节点访问图层权重，并在材质图表中实现你自己的混合解决方法。 输出会返回（基础 + 图层 * 图层权重）。 你可以将多个Landscape Layer Weight节点串联在一起，从而得到权重和，凭其在指定图层之间进行混合。

你可以将基础（Base）值设为0，将图层（Layer）值设置为`1.0`，从而直接访问未经修改的图层权重值。

![Landscape Layer Weight节点](../../../../assets/images/54/54d3156f9fc780c0b81872c0e77125ff5e38468221b8239abb36c4ad489fea0e.jpg)

点击查看大图。

此节点具有以下选项：

| 编号 | 属性 | 说明 |
| --- | --- | --- |
| 1 | **参数名称（Parameter Name）** | 显示要读取权重的图层的名称。 |
| 2 | **预览权重（Preview Weight）** | 定义要在材质编辑器中进行预览时所用的权重。 |
| 3 | **常量基础（Const Base）** | 定义在基础未被连接时，要使用的指定RGB常量值。 |
| 4 | **基础（Base）** | 要与此图层混合的节点网络。 这包括之前图层的值和所有其他的底层数据。 这会提供与绘制图层权重相乘后的图层数值。 |
| 5 | **图层（Layer）** | 指定图层的值。 输入值会与图层权重相乘，然后与基础相加，最终得出输出值。 |
| 6 | **输出（Output）** | 根据输入的图层权重，输出**基础（Base）**和**图层（Layer）**输入之间的混合结果。 |

### Landscape Visibility Mask节点

**Landscape Visibility Mask**节点将输出地形可视性的值。

![Landscape Visibility Mask节点](../../../../assets/images/0c/0c54003e69403e0637eac2b691c1f388ba2a600facb3f02b42bf9c348c24effe.jpg)

点击查看大图。

此节点具有以下选项：

| 编号 | 属性 | 说明 |
| --- | --- | --- |
| 1 | **输出（Output）** | 输出可视性遮罩的值。 地形透明时，数值为`0.0`；地形可见时，数值为`1.0`。 |

> 图片已省略：图层可见性遮罩不透明遮罩

点击查看大图。

> [!TIP]
> 你可以创建单独的地形洞材质。 地形材质和地形洞材质可以使用相同的材质，但请注意，使用不透明遮罩的材质的性能开销更高。

## 地形图层混合类型

Landscape **Layer Blend**节点有三种混合模式。 每种**图层混合**类型用于实现不同的结果。

| 混合类型 | 功能 |
| --- | --- |
| **LB权重混合（LB Weight Blend）** | 在所有LB权重混合图层之间实现加权混合。 此类型不依赖顺序。 |
| **LB Alpha混合（LB Alpha Blend）** | 在LB权重混合图层和LB高度混合图层之外，再实现一个Alpha混合覆层。 所有LB Alpha混合图层均按照其在列表中出现的顺序应用。 例如，在岩石和草上绘制积雪会遮挡岩石和草，擦除积雪会露出其下的岩石和草。 |
| **LB高度混合（LB Height Blend）** | 此模式与LB权重混合相同，但还会根据高度图在层之间的过渡中增加细节。 例如，你可以在图层过渡点处岩石之间的缝隙中显示泥土，而不是仅仅在岩石与泥土之间平滑混合。 |

**LB高度混合**的示例如下：

> 图片已省略：LB高度混合

图层过渡点岩石之间的缝隙中会出现泥土，从而在图层交界处形成平滑的过渡。

## 地形图层混合技术信息

地形图层节点与[Static Switch Parameter](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-expressions-reference/material-parameter-expressions/index.md#static-switch-parameter)节点类似。 它能切换使用材质的不同分支。 地形的每个组件都通过主地形材质创建了自身的**材质实例常量**，而各常量仅会被应用于对应的组件。

如果某个地形组件不使用特定的图层，则连接到该图层的节点子树会被废弃。 这降低了复杂性，使得应用于地形的材质能够包含任意数量的纹理取样，只要其数量未超出着色器模型所设定的限制即可。

使用这种方法，你可以创建一个主地形材质来包含所需的全部纹理或材质，同时确保最终效果符合硬件所允许的参数范围。

> [!NOTE]
> 材质表达式的所有网络都可以连接到**图层（Layer）**输入，以取代简单的**纹理取样（Texture Samples）**。 这使得执行更复杂的效果成为可能，例如根据图层的观看距离从细节纹理过渡到更大的宏观纹理。

## 图层混合问题

当你对多个地形图层使用LB高度混合模式时，你可能会在地形的不同图层交汇的地方发现黑斑。 LB高度混合的工作原理是，使用指定的高度值管理图层的混合因子或权重。 如果一个区域上绘制了多个图层，且图层混合模式均为LB高度混合，那么在某些区域中绘制的所有图层的高度值都可能同时为0，从而让所有图层的所需混合因子都变为`0`。

由于不存在特定的顺序，因此你可能会在所有层都无贡献的区域发现黑斑。 你甚至可能在混合法线贴图时发现更多的黑斑，因为这种混合会导致法线值为（0,0,0），即无效值，同时该值还会导致各种光照问题。 如果出现这种情况，请用权重不为零的材质绘制该区域。

在左图中，所有图层均使用LB高度混合，这导致某些区域呈现黑色。 而在右图中，红色的图层"1"被改为使用LB Alpha混合。

> 图片已省略：LB高度混合的问题

点击查看大图。

下面是**Landscape Layer Blend**节点的属性示例，所有图层都被混合在一起。 **土壤（Soil）**层的混合模式为LB Alpha混合，而其他层的混合模式为LB高度混合。 这是为了防止发生之前提到的问题。

> 图片已省略：Layer Blend属性

点击查看大图。

要删除某个图层，请点击该图层元素编号右侧的下拉菜单箭头，然后选择**删除（Delete）**。

> 图片已省略：删除图层

点击查看大图。

## 移动端地形材质

只要Texture Sampler节点的数量足够多，你就可以使用任意数量的地形图层。 地形图层通过[Feature Level Switch材质节点](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-expressions-reference/utility-material-expressions/index.md)进行分配，从而让单个PC或主机地形材质同时具备移动端版本。 下图展示了移动端设备使用*《Fortnite》*大逃杀地形的情况。

> 图片已省略：移动端地形特征关卡

> [!NOTE]
> 虽然你可以使用任意数量的节点，但我们建议只使用三个。

## 使用图层混合

将多个纹理和材质网络混合为可绘制的地形图层，是为地形地貌制作纹理的基础。 其方法有二：

1. 使用多个**Landscape Layer Weight**节点。
2. 最多使用两个**Landscape Layer Blend**节点。

### Landscape Layer Weight节点

**LandscapeLayerWeight**节点的设置方法如下：

1. 转到**材质编辑器**，添加一个**LandscapeLayerWeight**节点。

   > 图片已省略：地形图层权重基础

   点击查看大图。
2. 转到**细节（Details）**面板，将**参数名称（Parameter Name）**更改为图层的描述性名称，例如"Rock"。

   > 图片已省略：图层名称

   点击查看大图。

   > [!NOTE]
   > 所有图层的名称必须唯一。 建议使用能够表明图层内容的描述性名称来命名图层。
3. 添加更多**Landscape Layer Weight**节点，直至你希望材质拥有的每个图层都有一个节点。 本示例使用了两个**LandscapeLayerWeight**节点。
4. 添加你的**纹理取样（Texture Samples）**或材质网络表达式并将其连接到**Landscape Layer Weight**节点。
5. 添加**LandscapeLayerCoords**节点并设置UV标题。 将其与**Texture Sample**节点相连。
6. 将每个**Layer**节点的输出引脚连接到下一图层节点的**基础（Base）**引脚，同时确保不连接第一图层节点的**基础（Base）**引脚。
7. 将最后一个**Layer**节点的输出引脚连接到材质的**Base**节点的**基础颜色（Base Color）**输入。

这时你应该获得了与下图类似的结果：

> 图片已省略：Landscape Layer节点

点击查看大图。

> [!NOTE]
> 你可以更改**LandscapeLayerWeight**节点的**预览权重（Preview Weight）**属性，从而预览不同权重对材质的影响。

### Landscape Layer Blend节点

如果不想使用**LandscapeLayerWeight**节点手动将图层混合在一起，你可以使用**LandscapeLayerBlend**节点自动将多个图层混合在一起，此时将使用Alpha混合，或者使用基于高度偏移的Alpha混合。 基于高度的偏移允许图层基于高度图的输入与其他图层混合。

1. 转到**材质编辑器**，添加一个**LandscapeLayerBlend**节点。
2. 转到**细节（Details）**面板，点击**图层（Layers）**旁边的加号图标()以添加图层。

   > 图片已省略：图层混合数组元素

   点击查看大图。
3. 展开该图层以查看其属性。
4. 将**图层名称（Layer Name）**更改为该图层的描述性名称，例如"Snow"。

   > 图片已省略：图层名称

   点击查看大图。
5. 决定是让图层进行Alpha混合还是高度混合，并设置对应的**混合类型**。
6. 为地形材质添加所需数量的其他图层。 重命名这些图层，并为其设置适当的**混合类型**。
7. 将LandscapeLayerBlend节点的输出连接到材质的Base节点的**基础颜色（Base Color）**输入。
8. 添加Texture Sample节点，将其主输出连接到**LandscapeLayerBlend**节点的**图层（Layer）**输入。 你也可以创建更复杂的材质网络，并将其连接到Landscape Layer Blend的**图层（Layer）**输入。 针对所有高度混合图层，将纹理取样的Alpha输出连接到LandscapeLayerBlend节点的**高度（Height）**输入。

完成后，地形材质网络应该与下图类似：

> 图片已省略：Landscape Blend节点

点击查看大图。

> [!NOTE]
> 更改**LandscapeLayerBlend**节点的**预览权重（Preview Weight）**属性即可预览不同权重对材质的影响。

## 创建地形洞材质

你可以使用地形洞材质遮罩地形上特定位置的可视性和碰撞，从而在地形中创建隧道和洞穴之类的孔洞。

1. 打开材质编辑器，转到**细节（Details）**面板，将**混合模式（Blend Mode）**设置为**遮罩（Masked）**。

   > 图片已省略：图层可见性遮罩不透明遮罩

   点击查看大图。
2. 将**LandscapeVisibilityMask**节点添加到材质图表，并将其输出连接到**不透明遮罩（Opacity Mask）**输入。

   > 图片已省略：Landscape Visibility Mask节点

   点击查看大图。
3. 材质编译完成后，将其分配给地形。 此操作可在**细节（Details）**面板的**地形洞材质（Landscape Hole Material）**分段完成。

   > 图片已省略：地形洞材质

   点击查看大图。
4. 设置剩余的地形材质。 完成后，应得到类似下图的效果。

   > 图片已省略：材质中的地形可见性遮罩设置

   点击查看大图。

现在你应该可以遮罩和取消遮罩地貌的可视性，如以下视频所示。

> [!NOTE]
> 如需了解如何使用绘画工具创建地形洞，请参阅[使用不透明遮罩创建洞](../editing-landscapes/landscape-sculpt-mode/index.md)。

## 为地形分配材质

创建地形材质后，将该材质分配给关卡中的地形Actor。

1. 转到**内容浏览器**，找到要使用的地形材质。
2. 在视口或**世界大纲视图（World Outliner）**中选择地形。
3. 转到地形的**细节（Details）**面板，找到**地形材质（Landscape Material）**选项，点击分配箭头()以分配所选的材质。

   > 图片已省略：被分配的材质

   点击查看大图。

### 为地形分配地形洞材质

你可以分配不同的材质来充当**地形洞材质**，即带有特定的不透明设置的材质。

> [!NOTE]
> 如需了解洞材质的一般信息，请参阅"地形洞材质"小节。 如需了解不透明遮罩，请参阅[使用不透明遮罩创建洞](../editing-landscapes/landscape-sculpt-mode/index.md)。

1. 转到**内容浏览器**，找到并选择要使用的地形洞材质
2. 在视口或**世界大纲视图（World Outliner）**中选择地形。
3. 请前往**细节（Details） > 地形（Landscape） > 地形洞材质（Landscape Hole Material）**。 要分配选定的材质，请选择箭头()。

   > 图片已省略：地形洞材质

   点击查看大图。

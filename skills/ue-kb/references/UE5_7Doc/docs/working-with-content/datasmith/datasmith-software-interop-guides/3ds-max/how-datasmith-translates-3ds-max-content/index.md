---
title: "Datasmith如何转换3ds Max内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-datasmith-translates-3ds-max-content-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "3ds Max", "Datasmith如何转换3ds Max内容"]
---

# Datasmith如何转换3ds Max内容

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / 3ds Max / Datasmith如何转换3ds Max内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-datasmith-translates-3ds-max-content-for-unreal-engine

**Datasmith** 将场景从 **Autodesk 3ds Max** 转换到 **虚幻编辑器（Unreal Editor）** 时，会遵循[Datasmith概述](../../../datasmith-plugins-overview/index.md)和[Datasmith导入过程](../../../datasmith-import-process/index.md)中概括的过程，但会增加某种特定于3ds Max的特殊转换行为。

阅读本页面，更好地理解Datasmith导出器如何转换你的场景，以及如何处理虚幻编辑器中的结果。

## 几何体

本小节介绍了Datasmith如何将3ds Max场景中的几何对象转换为虚幻引擎项目中的 **静态网格体资产（Static Mesh Assets）** 和 **Actors** 。

### 网格体和曲面细分

在大部分情况下，Datasmith使用每个3ds Max对象的渲染网格体为虚幻引擎中的对应静态网格体资产创建几何体。虚幻引擎中的资产通常拥有你在3ds Max渲染中所见的完全相同的三角形。

对于3ds Max实体对象（请参阅3ds Max文档中的[实体对象类别](https://help.autodesk.com/view/3DSMAX/2023/CHS/?guid=GUID-ABED9F9A-1CBD-4FBE-9893-4E12F03617F5），Datasmith将基于3ds Max视口网格体而不是渲染网格体来创建静态网格体资产的几何体。

你可以控制3ds Max在视口中用于渲染的曲面细分的粒度：

- 在

  视口显示设置（Viewport Display Settings）

  卷展栏中，将

  网格体质量预设（Mesh Quality Presets）

  设置为

  粗糙（Coarse）

  、

  中等（Medium）

  或

  精细（Fine）

  。

Datasmith将遵循你为场景中每个实体对象设置的曲面细分级别。

如需详细了解网格体质量预设设置，请参阅3ds Max文档中的["视口显示设置"卷展栏](https://knowledge.autodesk.com/zh-hans/support/3ds-max/learn-explore/caas/CloudHelp/cloudhelp/2023/CHS/3DSMax-Data-Exchange/files/GUID-045AD5C8-8F2F-48E3-8060-8371DA83DCAC-htm.html)。

### 实例

Datasmith在你的3ds Max场景中检测到同一个主对象的多个实例后，会创建该对象的一个静态网格体资产，并将该静态网格体的多个实例放入虚幻引擎中的 **关卡（Level）** 中。

我们推荐将3ds Max中的实例用于重复场景中的元素，例如门窗或椅子。实例通常更适合虚幻引擎项目的运行时内存要求和性能。实例还有助于你减少静态网格体数量，以便管理内容。

如需详细了解实例，请参阅3ds Max文档中的[创建副本、实例和参考](https://knowledge.autodesk.com/zh-hans/support/3ds-max/getting-started/caas/CloudHelp/cloudhelp/2022/CHS/3DSMax-Basics/files/GUID-9F0E9AC3-FAE6-46A6-83F3-591084220B12-htm.html)。

### 枢轴点

在3ds Max中，即使场景中的每个对象都是同一个主对象的实例，你可以为此等对象设置自定义枢轴点。在虚幻引擎中，相同几何体的所有实例需要使用同一个枢轴点。

如果3ds Max场景中的对象实例有自定义枢轴点，Datasmith会尝试复制自定义枢轴点。Datasmith如何转换枢轴点取决于3ds Max中的所有实例是否都使用同一个枢轴点。

> [!NOTE]
> Datasmith不支持在3ds Max中导入有不同枢轴点且有非均匀比例的实例。如果你有这样的实例，请在导出之前对其使用[重置变换（变换）实用程序](http://help.autodesk.com/view/3DSMAX/2018/CHS/?guid=GUID-B98414B9-4F28-45F4-A1F4-9DA994548ED9)。

#### 转换单个共享枢轴点

如果3ds Max中的所有实例拥有同一个自定义枢轴点，Datasmith会将其设置为它所创建的静态网格体资产的枢轴点位置。当你在虚幻引擎关卡中旋转Datasmith为此对象创建的静态网格体Actor时，它会按预期围绕该自定义枢轴点的位置旋转。

#### 转换多个自定义枢轴点

如果一个或多个实例使用不同于其他实例的枢轴点位置，Datasmith会执行以下操作：

- 设置它在虚幻引擎中创建的静态网格体资产，以使用3ds Max对象的默认枢轴点位置。
- 当它将资产放入虚幻引擎关卡中时，Datasmith会在该实例的自定义枢轴点的位置创建新的空白父Actor，而不是创建静态网格体Actor。
- 最后，Datasmith为父Actor提供符合以下条件的

  静态网格体组件（Static Mesh Component）

  ：

  - 引用静态网格体资产。
  - 具有与父Actor之间的转换偏移，使其位于3D场景中所需的位置。
  - 在其名称中附加了

    _pivot

    后缀。

当你在虚幻引擎关卡中移动、旋转和缩放父Actor时，模型的行为会符合你的预期。需要注意的是，模型是父Actor的组件，而不是静态网格体Actor本身。

#### 自定义枢轴点示例

例如，在下图中，右侧的茶壶使用默认枢轴点，而左侧的茶壶在其盖子顶端有自定义枢轴点。

![undefined](../../../../../../assets/images/ed/edd6185c66c6c594964b03e2a2fa95f011499a8d3e1c05fded1872235eb99be0.jpg)

点击查看大图。

Datasmith将场景导入虚幻引擎中时，会在右侧的茶壶上创建静态网格体Actor。对于左侧的茶壶，它会执行以下操作：

- 在3D世界中该枢轴点的位置创建名为

  Teapot002

  的新Actor。
- 为

  Teapot002

  Actor提供名为

  Teapot002_2

  的静态网格体组件，它将引用该茶壶的静态网格体资产。
- 将

  Teapot002_2

  从父Actor

  Teapot002

  偏移刚好合适的数量，以便相对于场景中的其他几何体正确摆放它。

![undefined](../../../../../../assets/images/a5/a539711d92943a4639c6d3e5e695baea8d8a2b8e6f7cc8500dfbc291dbd13c0d.png)

点击查看大图。

### UV通道

Datasmith会确保它导入虚幻引擎的每个静态网格体都有一组UV，可供 **Lightmass** 用于将静态光照构建到光照贴图纹理中（请参阅[全局光照](../../../../../building-virtual-worlds/lighting-the-environment/global-illumination/index.md)）。当你同步3ds Max场景或导入Datasmith文件时，虚幻引擎会自动创建该UV通道。每个静态网格体资产将新通道用于烘焙光照贴图。

你还可以在3ds Max中创建自定义光照贴图UV，并改用这些UV。在这种情况下，请务必了解Datasmith如何将UV从3ds Max导入虚幻引擎中，以及你可以如何覆盖该行为。

- 下一小节介绍了Datasmith如何从3ds Max导入UV。
- 下方

  使用自定义光照贴图UV

  小节介绍了如何覆盖Datasmith的默认导入行为。

#### Datasmith如何导入UV通道

虚幻引擎支持每个静态网格体最多八个UV通道。Datasmith使用其中两个来生成光照贴图UV。这意味着，Datasmith可以为它从3ds Max导入的每个对象最多保留六个预先存在的UV通道。在3ds Max中，一个对象最多可以有99个UV通道，并且你不必按顺序设置通道索引。Datasmith会导出索引最低的六个通道。

Datasmith导入UV通道时，会执行以下操作：

- 重置UV通道索引以从0开始
- 将3ds Max中的最低索引映射到虚幻引擎中的最低索引，次最低索引映射到次最低索引，以此类推。
- 为自动生成的光照贴图创建两个额外的通道

例如，Datasmith导入了一个3ds Max对象，这个对象有五个通道，但通道的索引并非完全按顺序排列，下表显示了这种情况下如何对UV通道重新编制索引。请注意：

- 除了通道0-4之外，Datasmith还为光照贴图添加了通道5和6。
- 虽然一些3ds Max UV索引之间有很大空缺，但Datasmith仍将每个索引重新映射到虚幻引擎中的最低可用插槽。

| 3DS Max UV通道 | 虚幻引擎UV通道 | 说明 |
| --- | --- | --- |
| 1 | 0 |  |
| 2 | 1 |  |
| 3 | 2 |  |
| 10 | 3 |  |
| 99 | 4 |  |
|  | 5 | 在导入期间生成，以创建Datasmith场景中包含的几何体的自动解包。它是UV通道6使用的光照贴图UV生成的基础。 |
|  | 6 | 基于UV通道5生成，以基于用于静态网格体光照贴图分辨率值的Datasmith导入选项打包UV图表。 |

#### 使用自定义光照贴图UV

如果你想让导入的静态网格体使用你在3ds Max中创建的预先存在的UV通道，你有两个选项。

- **选项1** ：从3ds Max导出场景之前，应用Datasmith属性修改器，以指定你想让虚幻引擎用于光照贴图的UV通道的索引。 有关详细信息，请参阅[逐对象转换设置](../datasmith-per-object-conversion-settings-for-ex-d57c1b40/index.md)。
- **选项2** ：将场景导入虚幻编辑器之后，你可以更改你想让虚幻引擎用于光照贴图的UV通道的索引。

  1. 在内容浏览器中，双击你想更改其光照贴图UV索引的静态网格体资产。将打开静态网格体编辑器。
  2. 在细节面板中，找到

     通用设置（General Settings）> 高级（Advanced）

     ，并将

     光照贴图坐标索引（Light Map Coordinate Index）

     设置为你想使用的UV通道。

你也可以在Python中更改光照贴图UV索引。调用以下函数：

`static_mesh.set_editor_property("light_map_coordinate_index", index)`

### 自定义碰撞形状

要改进虚幻引擎中物理模拟的行为和性能，你可以为3ds Max中的对象建模自定义几何体，并将其用作虚幻引擎中对应静态网格体的碰撞网格体。这样做是为了使自定义几何体尽可能密切地匹配原始场景对象的体积，但尽量减少它包含的三角形。

- 下方

  使用自定义碰撞形状的注意事项

  小节介绍了你在使用自定义碰撞形状时需要考虑的事项。
- 下方

  设置自定义碰撞形状

  小节介绍了如何设置自定义碰撞形状。

#### 使用自定义碰撞形状的注意事项

##### 形状类型

当你使用自定义碰撞形状时，你设置为碰撞网格体的对象可以是任意完全封闭的凸包3D形状。例如，盒体。下图展示了哪些类型的形状可接受，哪些不可接受。

![凸包和非凸包示例](../../../../../../assets/images/ca/ca3a32b0f83224673fe6f0096df6cb6e044076f10a899574acd2a9b66a539a4b.jpg)

##### 枢轴点位置

此外还要确保自定义几何体的枢轴点在与原始对象枢轴点相同的相对于体积的位置。例如，在下图中，右侧椅子和左侧简化表示的枢轴点都在其体积的底部中心。

![自定义碰撞体积上的枢轴点](../../../../../../assets/images/07/0732077c71ed664e64362a9348c3490e3ecd50d700143eff2c5d792457f7981a.png)

如果你不将碰撞几何体的枢轴点保持在相对于整体体积的同一个地方，物理世界中对象的表示就不会与对象的可见范围保持一致。这可能导致碰撞在意料之外的地方发生。

#### 设置自定义碰撞形状

要在3ds Max中设置自定义碰撞形状，以便Datasmith将其导入虚幻引擎中，请使用Datasmith属性修改器。在3ds Max中，将修改器分配给场景中的一个或多个对象，然后使用它指定你想让虚幻引擎用作碰撞网格体的对象。有关详细信息，请参阅[逐对象转换设置](../datasmith-per-object-conversion-settings-for-ex-d57c1b40/index.md)中的 *设置自定义碰撞体积（Set a Custom Collision Volume）* 。

#### 验证虚幻引擎中的自定义碰撞形状

要验证Datasmith是否正确导入了自定义碰撞形状，请在 **关卡视口（Level Viewport）** 中开启碰撞渲染。

- 从视口覆层菜单，选择

  显示（Show）> 碰撞（Collision）

  。

虚幻引擎将在你的场景对象之上渲染自定义碰撞体积。下图显示了将盒体对象用作自定义碰撞体积的球体。

![undefined](../../../../../../assets/images/6b/6bbd17505b61468dcce6c5b158ed0cb618983386c0ad5f6b2d02003b9fb612a1.jpg)

点击查看大图。

### 顶点颜色

当你将顶点颜色与3ds Max对象关联时，Datasmith会在虚幻引擎中创建对应静态网格体资产时保留这些颜色。

> [!NOTE]
> Datasmith不会转换来自其他3ds Max网格体通道的数据，例如 **顶点Alpha（Vertex Alpha）** 、**贴图通道颜色（Map Channel Color）** 或 **软选择颜色（Soft Selection Color）** 。

在虚幻编辑器中创建自定义 **材质（Material）** 时，你可以在材质图表中包含 **Constants> Vertex Color** 节点，从而使用这些顶点颜色。

例如，下图显示了3ds Max中设置为显示其顶点颜色的对象，以及虚幻引擎中一个简单的自定义材质，它会检索顶点颜色，并直接将其传递到 **基础颜色（Base Color）** 输出。

![undefined](../../../../../../assets/images/ab/ab742a4b1a953ffc7082bf7d0f17f0fec7adee723e6aa50779bf931e7f35e82b.jpg)

3ds Max中显示的顶点颜色。点击查看大图。

![undefined](../../../../../../assets/images/38/388d576a4ce13df232bb7d6c7361b37f1b8cda3b486586e1e90853818b84c95d.jpg)

虚幻引擎中显示的顶点颜色。点击查看大图。

#### 验证导入的顶点颜色

你可以在虚幻引擎中直观地显示顶点颜色，确保Datasmith正确转换了颜色。

- 在

  内容浏览器（Content Browser）

  中，双击

  静态网格体资产（Static Mesh Asset）

  ，在

  静态网格体编辑器（Static Mesh Editor）

  中打开它。
- 从

  视口（Viewport）

  工具栏，选择

  显示（Show）> 顶点颜色（Vert Colors）

  。

#### 导入的顶点颜色的其他用法

除了为表面提供可见颜色之外，，自定义 **材质图表（Material Graph）** 中的顶点颜色还有其他用途。你还可以将其组合并与其他表面属性混合。

或者，你可以使用顶点颜色将自定义数据值与源对象的几何体关联，并将这些值传递到虚幻编辑器中的自定义材质，提升视觉效果。

例如，你可以使用顶点颜色向树的树枝和和树叶分配权重，使用这些权重调制你在顶点着色器中应用的风动画效果。

### 细节级别

Datasmith并不导入你在3ds Max中设置的自定义 **细节级别（Levels of Detail）** 。你可以自动在虚幻编辑器中生成新的细节级别。有关详细信息，请参阅[自动LOD生成](../../../../static-meshes/static-mesh-automatic-lod-generation/index.md)或[在蓝图或Python中创建细节级别](../../../../../production-pipeline/scripting-and-automating-the-unreal-editor/unreal-editor-scripting-tutorials/creating-levels-of-detail-in-blueprints-and-python/index.md)。

### Forest Pack和RailClone对象

[iToo Software](https://www.itoosoft.com/)的[Forest Pack](https://www.itoosoft.com/forestpack)和[RailClone](https://www.itoosoft.com/railclone)是3ds Max的插件，用于分散或流程性放置大量几何对象，帮助你填充场景。

#### Datasmith如何转换ForestPack和Railclone对象

当你使用Datasmith在虚幻引擎中导入或同步包含Forest Pack或RailClone对象的3ds Max场景时，Datasmith会在虚幻引擎关卡中创建单个Actor，并根据3ds Max中对象的名称命名。

在Actor中，Datasmith为对象处理的每种几何体创建以下内容：

- 分级实例化静态网格体（HISM）组件。
- 项目内容中的静态网格体资产。

接着，Datasmith将设置每个几何体类型的HISM组件，以引用其静态网格体资产。

在每个HISM组件中，Datasmith将为3ds Max场景中可见的每个实例添加一个静态网格体资产实例，并匹配3ds Max中每个实例的位置和旋转。

此导入过程会生成与原始3ds Max场景在视觉和结构上密切匹配的虚幻引擎关卡，也就是说，在场景层级中，一个Forest Pack或RailClone对象在内部管理所有实例。

![3ds Max中的Forest Pack](../../../../../../assets/images/b2/b270715cc77a10f60de9fa0f3bb22a0261a80f71d8e4e5cff08c0f7bbc205e39.jpg)

3ds Max中的Forest Pack

虚幻引擎

> [!NOTE]
> HISM组件也是虚幻引擎的 **植被（Foliage）** 系统中使用的技术。这可以高效渲染同一个静态网格体的多个实例。虚幻引擎渲染器可批量处理同一个HISM组件管理的所有实例，并针对分配给静态网格体资产的每个材质进行单次绘制调用。通过使用HISM，渲染器可以处理更多实例，而不影响GPU性能或帧率。

#### 将Forest Pack和RailClone对象替换为简化几何体

你可能想使用Forest Pack或RailClone来管理带有复杂几何体的对象，例如树，在虚幻引擎中，你需要将这些对象替换为更简单的几何体，以实现更高效的实时运行。

> 图片已省略：datasmith-max-forestpack-bbox.png

要将Forest Pack或RailClone对象替换为简化几何体：

1. 将

   Datasmith属性修改器（Datasmith Attributes Modifier）

   应用于3ds Max中的Forest Pack或RailClone对象，并将其设置为仅导出几何体的边界框。如需说明，请参阅

   逐对象转换设置

   的

   仅导出边界框（Bounding Box Only）

   分段。
2. 同步或导入3ds Max场景。
3. 要将虚幻引擎关卡中的所有实例更新为使用新的静态网格体，请编辑HISM组件，并在

   细节（Details）

   面板中更改

   静态网格体（Static Mesh）

   设置。

### 外部参照场景

外部参照场景是外部参照的场景，它们显示在当前文件中，但从其他MAX文件临时加载。有关更多信息，请参阅3ds Max文档中的[外部参照场景](https://knowledge.autodesk.com/zh-hans/support/3ds-max/getting-started/caas/CloudHelp/cloudhelp/2023/CHS/3DSMax-Manage-Scenes/files/GUID-5DB41A62-D7A5-4D54-AC83-5D03C9F7DB11-htm.html)。如果你的场景参照一个或多个外部参照场景，Datasmith会默认导出它们。

要防止Datasmith导出外部参照场景：

从3ds Max条带的 **Datasmith** 选项卡，转至 **设置（Settings）** 面板，并禁用 **导出外部参照场景（Export XRef Scenes）** 。

## 光照和渲染环境

3ds Max提供的光照和渲染功能比Datasmith所支持的其他许多第三方应用程序详细和复杂得多。本小节介绍了Datasmith如何尝试将3ds Max光照和渲染数据导入虚幻引擎中。

### 光源

Datasmith转换了各种3ds Max光源类型，包括标准、光度学、V-Ray和Corona光源。对于每种光源，Datasmith将以下光源信息导入虚幻引擎中：

- 3D空间中的位置、方向、形状和大小。
- 光源类型（例如，点光源或聚光光源）。
- 强度、单位、灯颜色、温度和滤波器颜色。
- 渲染形状可视性。
- IES光源配置文件。

> 图片已省略：3ds Max

3ds Max

虚幻引擎

带有IES配置文件和开氏温度刻度的点光源。中间：带有IES配置文件和光源强度刻度的点光源。底部：带有滤波器颜色的聚光光源。

Datasmith会尽可能近似表示你在3ds Max中设置的光照，但你在将场景导入虚幻引擎之后，可能必须调整关卡的光照，使结果的外观符合预期，并优化运行时的光照性能。通常，你需要通过调整后期处理曝光值来调整关卡的光照。

使用Datasmith时，3ds Max与虚幻引擎之间的几项显著差异：

- 虚幻引擎当前不支持光源实例。对于3ds Max场景中的每个实例化光源，Datasmith在你的虚幻引擎关卡中创建了单独的 **光源Actor（Light Actor）** 。

  > [!TIP]
  > 虽然光源在虚幻引擎中没有实例化，但你仍可以同时编辑所有光源，方法是将其选中，并在细节面板中更改其属性。
- 3ds Max中的标准光源没有单位，可以使用虚幻引擎不支持的自定义衰减参数。
- 不支持一些V-Ray形状，例如垂直圆柱体、球状体和自定义网格体光源。
- 面光源使用特殊蓝图类处理。有关详细信息，请参阅

  Datasmith导入过程

  。

### 曝光

Datasmith会保留3ds Max光源的强度，但强度不足以确保场景很好地渲染。虚幻引擎渲染器需要上下文来解译光源强度，以便可以确定场景的亮度：即场景在最终渲染时应显示为多亮或多暗。

部分上下文来自摄像机或视图的曝光——这是一组物理特征，用于管控最终图像应该对场景中光源强度有多敏感。

Datasmith还会转换来自3ds Max的多个曝光值。

详情请参阅以下各个部分：

- 物理摄像机曝光设置
- 全局曝光设置
- 自动曝光

#### 物理摄像机曝光设置

如果你的3ds Max场景包含物理摄像机，Datasmith会保留其曝光和白平衡设置，并将其转移到虚幻引擎关卡中的对应过场动画摄像机Actor。

对于每个摄像机，Datasmith会在虚幻引擎中设定以下设置，匹配3ds Max中的对等项。

- 白平衡（WhiteBalance） > 色温（Temp）
- 快门速度（Shutter Speed）
- ISO
- 光圈（F值）（Aperture (f-stop)）

它还将 **曝光（Exposure）> 计量模式（Metering Mode）** 设置为 **手动（Manual）** ，从而禁用自动曝光。

当你通过摄像机查看关卡时，会看到与3ds Max中的渲染结果密切匹配的光照水平。

> 图片已省略：3ds Max物理摄像机

> 图片已省略：虚幻引擎过场动画摄像机Actor

3ds Max物理摄像机

虚幻引擎过场动画摄像机Actor

如需详细了解过场动画摄像机Actor设置，请参阅[过场动画摄像机Actor](../../../../../animating-characters-and-objects/cinematics-and-movie-making/movie-and-cinematic-cameras/cinematic-cameras/index.md)。

#### 全局曝光设置

如果你在3ds Max中的 **曝光控制（Exposure Control）** 设置使用 **物理摄像机曝光控制（Physical Camera Exposure Control）** 或 **VRay曝光控制（VRay Exposure Control）** ，Datasmith会在Datasmith场景中创建 **后期处理体积（Post Process Volume）** ，将这些全局曝光设置应用于整个虚幻引擎关卡。

> [!TIP]
> 在3ds Max中，曝光设置位于"环境和效果（Environment and Effects）"对话框中。从主菜单，选择 **渲染（Rendering）> 曝光控制（Exposure Control...）**

Datasmith在虚幻引擎中为后期处理体积设定以下设置，匹配3ds Max中的对等项。

- 白平衡（WhiteBalance） > 色温（Temp）
- 快门速度（Shutter Speed）
- ISO
- 光圈（F值）（Aperture (f-stop)）

它还将 **曝光（Exposure）> 计量模式（Metering Mode）** 设置为 **手动（Manual）** ，从而禁用自动曝光。

当你在虚幻编辑器视口中使用默认视角查看关卡时，会看到与3ds Max中的渲染结果密切匹配的光源强度。

> 图片已省略：3ds Max视角摄像机|中的全局曝光

> 图片已省略：虚幻引擎中的|后期处理体积曝光

3ds Max视角摄像机|中的全局曝光

虚幻引擎中的|后期处理体积曝光

#### 全局曝光设置与物理摄像机设置

在3ds Max中，全局白平衡和曝光设置不必匹配分配给物理摄像机的设置。如果是这种情况，并且你从视角摄像机的视角渲染场景，渲染器会使用你的全局曝光设置，而不是分配给特定物理摄像机的设置。

虚幻引擎中也是如此。当你在关卡视口中通过默认摄像机查看场景时，虚幻引擎会使用项目的全局曝光设置，或来自活动后期处理体积的曝光设置。当你通过过场动画摄像机Actor查看场景时，虚幻引擎会使用该摄像机的曝光设置。

#### 自动曝光

虚幻引擎有内置的自动曝光系统。它会监控到达摄像机的光照量，并自动调整曝光，以便最终图像按合理亮度水平显示。

自动曝光系统默认开启。如需详细了解虚幻引擎中的自动曝光，请参阅[自动曝光](../../../../../designing-visuals-rendering-and-graphics/post-process-effects/auto-exposure/index.md)。

### 摄像机

对于3ds Max场景中的每个摄像机，Datasmith会在虚幻引擎中按照3D空间中的相同位置和旋转创建过场动画摄像机Actor，并尽可能保留摄像机的聚焦属性。理想情况下，若在虚幻引擎中通过摄像机查看关卡，会尽可能贴近在3ds Max中查看从对应摄像机渲染的场景。

如果3ds Max中的摄像机有目标，Datasmith会设置过场动画摄像机Actor，在虚幻引擎中追踪对应Actor。当你在虚幻引擎关卡中四处移动目标Actor时，过场动画摄像机Actor会自动旋转，追踪目标Actor。

如需详细了解Datasmith如何转换物理摄像机的曝光设置，请参阅[物理摄像机曝光设置](#%E7%89%A9%E7%90%86%E6%91%84%E5%83%8F%E6%9C%BA%E6%9B%9D%E5%85%89%E8%AE%BE%E7%BD%AE)。

### 材质

Datasmith将3ds Max场景导入虚幻引擎时，它会在项目的 **Materials / Master** 文件夹中创建一个或多个父材质资产。对于每个父材质，它会尝试创建一个材质图表，使用虚幻引擎的基于物理的渲染器，生成等同于你在3ds Max中渲染场景时所见内容的结果。

Datasmith会将3ds Max场景中的每个材质导入为父材质的新实例。并非每个材质实例都有自己的父材质。如果两个不同的材质实例可以共享同一个材质图表，Datasmith会尝试为两个实例使用同一个父材质。

Datasmith通常可以很好地转换带有单个着色模型和相对简单的图表的3ds Max材质。例如，下图中的材质。

> 图片已省略：3ds Max中的简单材质

即使对于简单材质，父材质资产的图表常常看起来与"3ds Max中的对应材质不同。Datasmith在不同着色模型之间转换时，会尽可能保留视觉效果，即使这意味着向图表添加连接或常量。

#### 着色模型转换局限性

3ds Max支持材质使用其他多个着色模型，例如V-Ray、Corona、Mental Ray等。每个着色模型是单独的软件，带有独特的功能，这些功能不一定彼此一致。Datasmith可以将一些功能转换为虚幻引擎中的类似功能，但可能无法处理一些更复杂或特殊用途的功能。

例如，一些材质使用复杂的图表，将多个输出着色器混合在一起，Datasmith可能很难甚至无法在虚幻引擎中重现这些材质。你需要在导入场景后额外调整或替换。下图中的图表就是一个很好的例子。

> 图片已省略：3ds Max中的复杂材质

### 流程性纹理

如果你的3ds Max场景使用流程性纹理，Datasmith会将其导出为烘焙纹理，在它创建的虚幻引擎材质中使用。Datasmith会将这些烘焙纹理保存为.tga文件。如需详细了解Datasmith如何创建材质，请参阅[材质](#%E6%9D%90%E8%B4%A8)。

场景中纹理的数量和大小都会影响从3ds Max导出和导入到虚幻引擎中所需的时间。你可以限制烘焙和流程性纹理的分辨率，提高导入和导出性能。这尤其适合带有复杂材质的大型场景。

> [!NOTE]
> 该设置不会影响栅格纹理的大小，例如TIFF或JPEG文件。

要指定烘焙流程性纹理的导出分辨率，请执行以下操作：

- 从3ds Max条带的

  Datasmith

  选项卡，转至

  设置（Settings）

  选项卡，并将

  限制纹理分辨率（Limit Texture Resolution）

  设置为所需值。

值将指定目标分辨率的像素数量，范围从4K（4096个像素）到16M（16个兆像素）。

例如，如果你将分辨率限制设置为4K，Datasmith会将纹理限制为包含4096个像素的分辨率，无论是64x64、128x32像素还是其他一些宽度/高度值。

## Metadata

在 **对象属性（Object Properties）** 窗口的 **用户定义（User Defined）** 标签中，将你的元数据添加给3ds Max对象。

> 图片已省略：Metadata in 3ds Max User Defined Properties

请按以下操作，在3ds Max中为某个网格体打开面板：

1. 在大纲视图或视口中选中该网格体。
2. 点击右键，在上下文菜单中选择

   属性（Properties）

   或

   对象属性（Object Properties）

   ，或在主菜单中选择

   编辑（Edit） > 属性（Properties）

   。
3. 在面板中输入metadata，格式按照 `键 = 值` 对的形式，如上所示。

   > [!NOTE]
   > **一定要在等号（=）的两边留一个空格**。否则，Datasmith将无法识别你的metadata，无法按照预期导入。

> [!TIP]
> 你还能设置基于用户定义的属性，方法是[使用MAXScript](https://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_AF1F51D4_449B_4C4D_9F58_85DB145BC0B9_htm)。

> [!TIP]
> 如果你的模型最初是在Revit中创建的，然后被导入3ds Max，那么用户定义的属性应该已经被3ds Max导入器预设为模型的BIM信息。

## 转换说明和警告

你可以在以下情况下获取有关Datasmith转换过程的信息：

- 在3ds Max中，导出或同步场景后。
- 在虚幻引擎中，同步或导入场景后。

### 3ds Max中的说明和警告

Datasmith导出3ds Max 场景后，会在消息窗口中列出该过程期间遇到的统计数据、说明、问题、警告或错误（请参阅[Datasmith消息窗口](../the-datasmith-3ds-max-ui-for-exporting-to/index.md#datasmith%E6%B6%88%E6%81%AF%E7%AA%97%E5%8F%A3)）。

> [!NOTE]
> 如果你使用Direct Link同步3ds Max和虚幻引擎，Datasmith默认不输出统计数据。要启用Direct Link同步和自动同步的导出统计数据，请在MaxScript控制台窗口中输入以下命令：
>
> `Datasmith_SetExportOption_StatSync true`

消息会通知你场景中可能无法完全如预期转换到虚幻引擎的元素。例如：

- 源场景的问题，例如缺失图像。你可能需要在3ds Max中修复这些问题，然后重新导出。
- 3ds Max场景中Datasmith或虚幻引擎不支持的事项。
- Datasmith以意外方式转换的事项。

### 虚幻引擎中的说明和警告

将Datasmith场景导入到虚幻编辑器后，你可以在 **输出日志（Output Log）** （从主菜单选择 **窗口（Window）> 输出日志（Output Log）** ）中找到可能需要清理的转换问题的相关信息。

> [!TIP]
> 首先，尝试筛选输出日志，仅显示警告。从输出日志工具栏，禁用 **筛选器（Filters）> 消息（Messages）** 和 **筛选器（Filters）> 错误（Errors）** 。

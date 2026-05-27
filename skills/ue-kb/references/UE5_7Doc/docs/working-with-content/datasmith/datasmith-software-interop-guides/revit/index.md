---
title: "Revit"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-revit-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Revit"]
---

# Revit

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Revit

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-revit-in-unreal-engine

本页面介绍了Datasmith如何将场景从Autodesk Revit导入到虚幻编辑器中。导入过程遵循[Datasmith概述](../../datasmith-plugins-overview/index.md)和[关于Datasmith导入流程](../../datasmith-import-process/index.md)中所述的基本流程，但增加了一些只与Revit相关的特殊行为。如果你计划用Datasmith将场景从Revit导入到虚幻编辑器中，阅读此页面可以帮助你了解如何转译场景，以及如何在虚幻编辑器中处理结果。

![Revit](../../../../../assets/images/99/995b41af8f1dc0d9b164204d3be248bf9705a6f10326ff146386335b7f475111.jpg)

Revit

虚幻引擎

## Revit工作流程

Datasmith使用适用于Revit的导出插件工作流程。这意味着，要使用Datasmith将Revit内容导入虚幻引擎，你需要执行以下操作：

1. 安装适用于Revit的插件。请参阅下面的 **安装说明** 小节。
2. 将你的Revit内容导出到 `*.udatasmith` 文件。请参阅[从Revit导出Datasmith内容](exporting-datasmith-content-from-revit-to/index.md)。你也可以[使用Dynamo](batch-exporting-revit-views-with-dynamo-to-a-da-d8345c72/index.md)批量导出Revit视图。
3. 如果尚未启用插件，请为你的项目启用 **导入器（Importers）> Datasmith导入器插件（Datasmith Importer Plugin）** 。
4. 使用虚幻编辑器工具栏中的 **Datasmith** 导入器导入你的 `.udatasmith` 文件。请参阅[将Datasmith内容导入到虚幻引擎中](../../datasmith-tutorials/importing-datasmith-content-into/index.md)。

## 安装说明

你必须先从[Datasmith导出插件](https://www.unrealengine.com/zh-CN/datasmith/plugins)页面下载并安装 **Revit的Datasmith导出器** 插件，才能导出Revit内容。

要查看该插件支持的Revit版本，请参阅。

> [!TIP]
> 我们鼓励你将Datasmith导出程序插件的下载链接分享给更多人，包括组织内和组织外的人。请注意，你无权自行分发Datasmith导出程序插件。

在你安装Revit的Datasmith导出器插件之前，请确保：

- Revit未运行。
- 你下载的导出器插件安装程序与你计划使用的虚幻引擎版本匹配。
- 你卸载了Revit的Datasmith导出器插件的所有先前版本。

在你下载安装程序后，双击将其打开，然后按照屏幕上的说明操作。

> [!NOTE]
> 安装导出器插件后启动Revit时，你可能会看到以下警告："无法验证此加载项的发布者。你想怎么做？"（The publisher of this add-in could not be verified. What do you want to do?）点击 **始终加载（Always Load）** 以确认你希望Datasmith导出器插件在你每次启动Revit时都可用。

如果你需要卸载Revit的Datasmith导出器插件，可以像卸载所有其他Windows应用程序那样，从 **控制面板** 卸载。

## 控制导出的内容

要使用Datasmith导出器插件导出场景，Revit中务必有已选定并激活的3D视图。该3D视图的可视性设置将定义Revit文件中的哪些元素会包括在导出的 `.udatasmith` 文件中。

你可以使用Revit文件中已有的3D视图。但要完全控制你引入虚幻引擎的对象，我们建议你在Revit中建立一个新的3D视图，并将该视图设置为仅显示实时展示中需要的对象。

Revit提供了许多工具和技术来控制对象在3D视图内的可视性。例如：

- 你可以使用 **图形（Graphics）> 可视性/图形覆盖（Visibility/Graphics Overrides）** 来控制关卡中不同对象和对象类别的可视性。

  ![Revit Visibility/Graphics Overrides](../../../../../assets/images/a6/a6ba87fff61d7d5e543cc9c01e1f90e70ec6e696965c53200cf41874b2343305.png)
- 你可以使用[剖面框](https://help.autodesk.com/view/RVT/2019/CHS/?guid=GUID-C9EA51CB-3214-4BD8-AD55-3BEB1CCD15B6)来剖切你导出的几何体。只有剖面框内的对象才会导出到虚幻引擎。请注意，当一个对象穿过剖面框的边界（如下图中的墙壁、地板和家具）时，其几何体会被截断。在虚幻引擎内，表示导出对象的静态网格体资产仅包含位于剖面框内部的几何体。

  ![Section Box results in Revit and Unreal Engine](../../../../../assets/images/c6/c66ba4afdbb288a54330562f5a17ca3433297515111cb476340d60b5bf90aa42.jpg)
- 将遵守Revit中的

  临时隐藏和隔离（Temporary Hide and Isolate）

  设置。
- 仅导出当前3D视图中可见的几何对象。非几何对象会被忽略。

> [!NOTE]
> Datasmith导出器会遵守你对哪些对象显示、哪些对象隐藏的选择，但不会考虑控制3D视图在Revit视口中绘制方式的其他设置。例如，它不会考虑为3D视图设置的 **图形（Graphics）> 图形显示选项（Graphic Display Options）**（现实与着色模型显示、投射阴影等）或 **摄像机（Camera）> 渲染设置（Rendering Settings）** （草图与高质量设置、照明方案等）。

如需有关在Revit 3D视图中控制可视性的更多信息，另请参阅Revit帮助中的[项目视图中的可见性和图形显示](https://help.autodesk.com/view/RVT/2019/CHS/?guid=GUID-A2FC119B-51D7-4C2E-84ED-CD51983EC532)。

## 几何体

一般而言，你可以在Revit场景中单独选择的每个元素在虚幻中都转译为单独的静态网格体资产。某些元素（如栏杆）由更小部件组成时，可能会进一步分解为更小的静态网格体。

在所有情况下，每个静态网格体资产的几何体都设置为与你导出文件时Revit对象的尺寸一致。参数设置和约束不会转移到虚幻引擎中。因此，举例来说，如果你在虚幻编辑器中上下移动地板，墙壁的高度不会像在Revit中那样拉伸或收缩以匹配新位置。

### 实例化

如果两个对象属于相同族系，且如果其拥有完全相同的参数值，则两个对象都将在Datasmith场景中呈现为同一静态网格体资源的实例。

### 曲面细分

Datasmith依赖Revit的内置曲面细分服务从场景几何体创建三角形网格体。在大多数情况下，这会产生足够的几何体供在虚幻引擎中使用。但如果你发现这些表面在项目中会带来问题，可以尝试使用虚幻编辑器提供的工具简化这些网格体，比如[代理几何体工具](../../../static-meshes/proxy-geometry-tool/index.md)。

你也可以通过 **Datasmith导出设置（Datasmith Export Settings）** 面板手动指定Revit创建的网格体的曲面细分级别。这些级别由[Revit API](https://www.revitapidocs.com/2019/d98987f3-27a6-1893-3b7d-fc28e8ed5322.htm)定义。

![Datasmith导出设置中的曲面细分级别设置](../../../../../assets/images/7d/7d7478fd275028e8a1f591e8d3119dae5e99f31b6e9a2dedb6ac90cb934a6f95.png)

级别8（Level 8）是默认的曲面细分级别。此级别会生成与Revit FBX导出器相同的网格体分辨率：

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/5415269a-ad33-45d2-abfd-a0fc0653b0a3/tessellation-level-2.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6d942cc4-7838-4bfb-aa3d-fef8d541d436/tessellation-level-8.png) |
| 级别2 | 级别8 |

### 链接模型

如果你的Revit场景包含[链接模型](https://help.autodesk.com/view/RVT/2019/CHS/?guid=GUID-0FBC74D9-C739-4ED3-962E-20DC4526A678)，即对其他Revit文件的引用，Datasmith会尝试使用Revit文件中保存的路径在你的计算机上查找链接的文件。Datasmith包括它能够在Datasmith场景中找到的所有链接文件的数据，同时Datasmith场景也是它在虚幻引擎中创建的。

## 材质和纹理

Datasmith将针对Revit场景中每种不同类型的表面在虚幻引擎项目中新建材质资产，并放入Datasmith场景资产旁的 `Materials` 文件夹中。这些材质的目标是遵守设置表面在Revit中查看的方式，同时公开一组与你在Revit中惯用的属性非常相似的属性。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/e4056ed7-bb2a-4d50-bef0-693b12755615/revit-material-definition.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/2d80f4e8-e8be-4ad9-a76b-24394c0882a9/unreal-material-definition.png) |
| Revit | 虚幻 |

Datasmith目前支持将漫反射贴图和颜色、透明度、镂空和凹凸设置从Revit转译到其生成的虚幻引擎材质中。

要在虚幻编辑器中修改材质，请执行以下操作：

1. 在

   内容浏览器（Content Browser）

   中双击材质。或在你的关卡中选择一个使用你要修改的材质的Actor，然后在细节面板中双击该材质。
2. 如上图所示，材质编辑器将打开，你可以在细节面板顶部的

   参数组（Parameter Groups）

   分段中修改这些参数。还可以修改虚幻渲染器公开的其他内置参数。
3. 要覆盖属性的默认值，请先勾选其名称左侧的框，在材质中激活该属性。然后，设置你希望该属性使用的数值。

> [!TIP]
> 所有这些资产都是材质实例，其父项是内置于Datasmith插件中的 **RevitMaster** 材质。你可以打开该父材质，查看材质实例中公开的各个属性在材质图表中的相互联系。

### 纹理和UV封装

Datasmith会将你在Revit材质中使用的纹理导入到资产中，并将其放入Datasmith场景资产旁边的 `Textures` 文件夹中。

每种使用纹理资产的材质都为Revit纹理编辑器提供类似的设置，以控制对使用材质的3D对象曲面应用纹理贴图的方式。

![纹理贴图和UV设置](../../../../../assets/images/c0/c0cc713aaddf95c562d962ea24d852eeb444469f06963eaf2c5bd7cbea1f6e58.jpg)

1. Revit中的

   位置（Position）> 偏移（Offset）

   数值由每个贴图类型的

   UVOffsetX

   和

   UVOffsetY

   设置建模。
2. Revit中的

   位置（Position）> 旋转（Rotation）

   数值由每个贴图类型的

   UVWAngle

   设置建模。
3. Revit中的

   比例（Scale）

   数值基于现实世界尺寸，将在虚幻引擎材质中转换为比例乘数。增加这些比例数值的绝对值时，对象上的纹理会缩小。

> [!NOTE]
> Datasmith不转换棋盘格、噪点、图块等程序性纹理。

## 构建Datasmith场景层级

Datasmith导出器插件会在Datasmith场景中创建父子Actor层级，旨在体现Revit中你的场景的整体组织形式。其目的是按照你在Revit中惯用的概念来组织虚幻引擎关卡中的Actor，以便你更轻松地查找和操纵对象。

此场景层级根据以下规则构建：

- Revit中的每个 **关卡（Level）** ——地面、关卡1、关卡等，在Datasmith场景层级中都使用单独的Actor来体现。
- 在每个关卡内，Revit中可以 **承载** 其他场景元素的对象将成为其所承载对象的父项。
- 在表示Revit关卡和宿主的父Actor下，你可以找到代表每个几何对象的静态网格体Actor。

  例如，名为关卡1（Level 1）的Actor包含一个代表每面墙壁的Actor。而这些Actor中的每一个又由另一个父Actor表示，后者具有的子项对应于墙壁承载的每个几何对象，即每扇门、窗或墙壁剖面。

  ![虚幻编辑器中的场景层级示例](../../../../../assets/images/36/36d345b5e223b5598c5b4eba57c3b8446451386cfc5f17607ef0e380bd8ded10.png)
- 对于大多数"复合"Revit对象，如幕墙或栏杆，场景层级仅包含一个表示复合对象的Actor。该Actor包含组成复合元素的每个子对象的静态网格体组件。

  例如，Revit中的幕墙通常以单个Actor的形式出现在虚幻引擎中。对于组成幕墙的每个竖框和每个面板，该Actor都有一个单独的静态网格体组件与之对应。

## 光源

Datasmith可将光源从Revit场景导入到虚幻引擎中，并保留你为光源强度设置的物理单位。

## 摄像机

当你从Revit导入3D视图时，Datasmith会在虚幻编辑器关卡中创建单一 **CineCameraActor** 。其将以相似的视野取代此摄相机在Revit 3D视图中的摄相机位置和朝向。如果你在关卡视口或 **世界大纲视图** 中选择此CineCameraActor，你看到的视点预览应与你导出 `.udatasmith` 文件时Revit 3D视图的裁剪区域高度匹配。

> [!NOTE]
> Datasmith不会处理Revit中提供的某些摄像机概念，其中包括正交投影模式和透视视角校正（如倾斜、移位和裁剪区域）。

为获得最佳效果，请执行以下操作：

1. 将你的3D视图的

   摄像机（Camera）> 投影模式（Projection Mode）

   设置为

   透视视角（Perspective）

   。
2. 在Revit中设置你的3D视图的裁剪区域，以聚焦于你希望摄影机在虚幻引擎中拥有的视图。
3. 确保Revit中你的摄像机的目标点位于裁剪区域的中心。在其他平面视图和立面视图中显示摄像机即可验证这一点。 如果透视视角发生移位，虚幻引擎中的结果则不会如预期般显示。

例如，下方3D视图的透视视角摄像机裁剪区域居中，因此转译效果好：

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/1b10a550-9f5a-443c-8be8-3793b8c3cd3c/revit-camera-3d-crop-good.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/1272c865-9dbc-46cc-b6fc-94faae4bc16f/revit-camera-plan-good.png) |

但以下3D视图的裁剪区域为手动调整，令透视视角区域的一个边缘不均匀地向目标点移位。这会造成转译效果不好。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/d817499d-24e3-440b-be6f-6b927ec4d774/revit-camera-3d-crop-shifted.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/af364abf-0486-42b0-9f82-993914f55bd3/revit-camera-plan-shifted.png) |

## 类别

包含场景中至少一个对象的每个Revit类别将以单独层的形式转移到虚幻编辑器中。

![Revit层](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/dea8f719-1b61-4c08-9b5b-3d177a5d0047/revit_layers.png "")

你可以在虚幻编辑器中使用这些层来显示和隐藏类别，或者检查和选择指定给它们的对象。

请注意，Revit SDK提供给导出器的信息并会固定将每个场景对象关联到某个类别。未在Revit中指定类别的对象不会指定给虚幻编辑器中的层。

## 元数据

当你在Revit视图中选择元素时， **属性（Properties）** 控制板会显示指定给该元素的所有实例属性的列表。你可以随意更改这些数值，以及添加自己的自定义属性。

![Revit Properties palette](../../../../../assets/images/e0/e0419ca045b1ac46fc5295fd90c5873feff510872dd151213dab1f06eb7d5b28.png)

如需有关设置和使用这些属性的详细信息，请参阅[Revit帮助](https://help.autodesk.com/view/RVT/2019/CHS/?guid=GUID-A764EA7A-FE26-469B-857C-F3A70812FC34)。

当你使用Datasmith将Revit场景导入到虚幻编辑器中时，Datasmith会以元数据形式将每个Revit元素的所有实例属性指定给它在虚幻引擎关卡中为该元素创建的静态网格体Actor。此元数据还包括对象的Revit类型的非空类型属性。

由于Datasmith元数据始终是键值对的扁平列表，因此不包括属性控制板中的类别标题（如上图中的 **约束（Constraints）** 、 **结构（Structural）** 、 **尺寸（Dimensions）** 和 **身份数据（Identity Data）**） 。只有实际属性的名称和数值会保留。

一些其他技术性更强的内部信息将附加到使用组件标签的每个Actor。你可能会发现此信息有助于识别Actor，使用蓝图或Python脚本来自动化虚幻编辑器中的数据准备时尤为如此。例如：

- Revit.Instance.Depth. -

  Revit场景层级中对象族系实例或族系符号的深度。
- Revit.Instance.Id. -

  Revit文档中对象族系实例或族系符号的ID。
- Revit.Host.Id. -

  对象的族系实例被添加宿主后，此值将在Revit文档中给定族系实例宿主的ID。

![保存在组件标签中的元数据](../../../../../assets/images/39/39fd38de51d40bbb7fedb81589154a95c6660b18d2f791bf5ac1ebb036b7ba66.png)

在Revit内Datasmith工具栏的 **设置（Settings）** 菜单中，你可以筛选需要通过 `.udatasmith` 文件或Direct Link导出的元数据量。这有助于你减少需要导出的数据量，从而优化导出性能和导出的Datasmith场景的大小。

> 图片已省略：元数据导出设置

元数据导出设置。

使用 **添加组（Add Group）** 和 **移除选定项（Remove Selected）** 按钮来添加或删除你想要随Datasmith场景附带导出的元数据。

注意以下情况：

- 元数据类别由Revit定义，无法更改。
- 此筛选器对常规导出（以 `.udatasmith` 文件形式导出）和Direct Link设置均有影响。
- 你在导出筛选器中添加的类别列表会保存在Revit文件内。
- 如果此列表完全空白，则会导出 **所有** 元数据。

## RPC对象

Datasmith可将Revit场景中的丰富逼真内容（RPC）对象引入虚幻引擎。对于你的Revit场景中每种类型的RPC对象，Datasmith会将Revit中可见的几何体导入新的静态网格体资产。对于你已放入Revit场景的每种RPC对象类型，Datasmith会在虚幻引擎关卡中创建新的静态网格体Actor，且其位置和朝向与3D空间中相同。

> 图片已省略：世界大纲视图中的RPC Actor

查找已指定 **Revit.RPC** 组件标签的Actor即可在你的虚幻引擎关卡中找到这些RPC对象：

> 图片已省略：RPC Actor的组件标签

若想要用一种更适合3D实时可视化的自动化方式来替代Revit中使用的占位符随从对象，这将非常有用。

## 测量点和基点

若Revit场景包含[基点或测量点](https://help.autodesk.com/view/RVT/2019/CHS/?guid=GUID-68611F67-ED48-4659-9C3B-59C5024CE5F2)，Datasmith会将这些点导入虚幻引擎关卡，同时利用不包含可见几何体的普通Actor加以表示。它会在这些Actor上记录Datasmith元数据中测量点和基点的相关数据：

| 列 1 | 列 2 |
| --- | --- |
| 基点元数据 | 测量点元数据 |
| 基点 | 测量点 |

导出Datasmith场景时，模型的朝向将取决于项目基点（项目/平面北）。要使导出的Revit模型的朝向与测量点（正北）一致，项目基点需要与测量点具有相同的旋转角度。

另请参阅上文的[元数据](#%E5%85%83%E6%95%B0%E6%8D%AE)和[使用Datasmith元数据](../../using-datasmith-metadata/index.md)。

> [!NOTE]
> 本页面上使用的所有场景和模型由[Turbosquid](https://www.turbosquid.com/zh_cn/)友情提供。

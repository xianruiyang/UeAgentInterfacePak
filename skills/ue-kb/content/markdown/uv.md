# 将UV通道用于静态网格体

---
title: "将UV通道用于静态网格体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-uv-channels-with-static-meshes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "静态网格体", "将UV通道用于静态网格体"]
---

# 将UV通道用于静态网格体

> 路径：虚幻引擎5.7文档 / 管理内容 / 静态网格体 / 将UV通道用于静态网格体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-uv-channels-with-static-meshes-in-unreal-engine

UV通道是静态网格体中的一组数据，用于将网格体的顶点数据映射到2D空间中（2D坐标系）。这些映射定义了网格体渲染时，2D纹理贴图如何"包裹"到3D几何体上。

通常，你在建模软件中创建和管理UV映射。建模软件也是你创建静态网格体的地方。不过，编辑器内置了几种处理模型UV通道的方法，详见下文概述。

UV通道在引擎中主要有两个用途：

- **材质中的纹理坐标：** 当你创建材质来对纹理贴图取样并将其应用于静态网格体的表面时，可以使用Texture Coordinate（简称 **Texcoord** ）节点指定UV通道。该材质会使用所选UV通道中包含的2D坐标和3D顶点位置之间的映射，确定应该将纹理的哪些区域用于3D模型中的哪些三角形。

  例如，这个简单平面静态网格体中的UV通道0（如下图右上角所示）用了最简单的办法将网格体的两个三角形（A和B）映射到纹理空间。当你使用此UV通道（由 **TexCoord** 节点的 **坐标索引（Coordinate Index）** 属性设置）时，材质会将纹理的完整宽度和高度应用于平面。

  ![Texture Mapping](../../../../assets/images/dd/ddd0b3b80f9c8d6f6004d22db5897c0055d98fb9a8636e66765dfd840f1ef24a.jpg)

  点击查看大图。

  另一方面，下图显示了UV通道1，它会旋转并倾斜三角形与UV纹理空间之间的映射。当相同的图像纹理应用于静态网格体时，它会改变纹理的哪些部分应用于静态网格体的哪些部分。

  ![Texture Mapping](../../../../assets/images/8c/8c26f592b80ceecd9c501ad3108cc092265edd1533ee7f8edd0db89294812a0b.jpg)

  点击查看大图。

  UV映射中的三角形可能重叠。重叠仅仅意味着纹理的同一个部分应用于3D静态网格体几何体的多个部分。

  "UV通道"中的U指的是纹理的水平轴，V指的是垂直轴。纹理坐标通常保持在0到1之间，其中(0,0)表示纹理的左下角，(1,1)表示右上角。但并非总是如此。默认情况下，当U或V值超过1或小于0时，材质将"封装"到纹理的另一端。例如，V值1.25通常会处理为0.25。但是，你可以选择改为在材质中将这些值限制为最小值0到最大值1之间。
- **光照贴图：** UV通道也用于存储和应用光照贴图。光照贴图是一种特殊的纹理，用于存储静态网格体的预先计算的光照信息。如果你在关卡中将光源的"移动性（Mobility）"设置为"静止（Stationary）"或"静态（Static）"，你为关卡构建光照时，Lightmass工具会将间接光照（和用于静态光源的直接光照）保存到光照贴图纹理，使用UV通道来确定静态网格体的3D几何体与2D纹理空间之间的映射。

  用于光照贴图的UV通道必须遵守一些特殊的规则。由于对象的每个部分通常会接收到不同程度的光照，网格体中任意两个三角形都不会在2D纹理空间中重叠。每个三角形必须覆盖它在纹理中的相应区域。此外，所有UV坐标值必须介于0到1之间。光照贴图纹理无法使用与普通纹理映射相同的方式进行"封装"。 由于这些原因，光照贴图UV通常是根据更简单的UV映射来生成或 *打包*。

  例如，此支柱的纹理映射UV通道会将四个边中每个边的几何体映射到纹理的相同重叠区域。当你使用此UV通道将纹理应用于几何体时，每个边会使用纹理的相同部分。

  ![Texture Mapping Pillar](../../../../assets/images/cf/cf12c9b6bf709cd1f6cd7f38254b2b1d8cee74a9498ab29ed5c4f7d42f246a62.jpg)

  点击查看大图。

  但是，在对象的光照贴图UV中，每个边需要覆盖它在2D空间中的对应唯一区域：

  ![Texture Mapping Pillar Packed.png](../../../../assets/images/b6/b6c1e7ea8c62c79195f63fc66fb9d2b54da1f349f2064f8ca6d6b9e3141ddfb9.jpg)

  点击查看大图。

  有关光照贴图UV及其生成方法的更多信息，请参阅[理解虚幻引擎中的光照贴图](../understanding-lightmapping/index.md)和[生成光照贴图UV](../understanding-lightmapping/generating-lightmap-uvs/index.md)。

引擎中的每个静态网格体最多可以有7个不同的UV通道，因此你可以为不同的材质（或为单种材质中的不同纹理取样节点）设置封装纹理的多种不同方式。

## 静态网格体编辑器中的UV通道

在静态网格体编辑器UI中，你可以列出、可视化和删除UV通道。

### 列出UV通道

当你在静态网格体编辑器中打开静态网格体资产时，可以使用工具栏中的 **UV** 按钮列出当前静态网格体正在使用的所有UV通道。

![List UV Channels](../../../../assets/images/d3/d3cec9f6e5463504b90d6908b55b91f4859fddcfb5c94eacf723eaf871359e0e.jpg)

点击查看大图。

### 可视化UV通道

选择列表中的UV通道以将网格体的三角形到2D纹理空间的映射可视化为视口中的覆层：

![Visualize UV Channels](../../../../assets/images/6c/6c3f3014bbf5830f27c18d03435a6b1c82d9b648eec6c18bf9f9e747d50df5a7.jpg)

点击查看大图。

选择列表顶部的 **无（None）** 以隐藏UV覆层。

### 删除UV通道

选中列表中的某个通道时，可以将其删除。每个UV通道将每个顶点的纹理坐标存储为静态网格体的一部分，这样你可以删除不使用的映射来节省一些运行时内存。

![Remove selected UV channel](../../../../assets/images/fe/fed8b51c0a157941025391824a7d735b151f8f704c6432bbb74add64c1bdc903.jpg)

点击查看大图。

![Remove selected UV channel](../../../../assets/images/81/819b4f641a245d17ac5bcc8819542a5c18ed63463351cbb607698d9183503cfc.png)

点击查看大图。

位于列表中已删除通道后面的其他所有UV通道会上移一个位置，填补已删除的通道留下的空白。

> 图片已省略：Remove selected UV channel

点击查看大图。

> [!NOTE]
> 如果静态网格体资产设置为生成光照贴图UV，并且所选UV通道已经被用作光照贴图UV的源或目标通道，则不能删除该UV通道。停用 **构建设置（Build Settings）> 生成光照贴图UV（Generate Lightmap UVs）** 选项，或将 **构建设置（Build Settings）> 源光照贴图索引（Source Lightmap Index）** 和 **构建设置（Build Settings）> 目标光照贴图索引（Destination Lightmap Index）** 设置更改为指向不同的UV通道。

### 创建UV映射

当材质将纹理用作其通道的元数据（例如，其基础颜色、法线贴图、粗糙度，等等）时，它通常使用模型的UV映射来确定这些纹理的哪些部分封装几何体的哪些部分。因此，如果一个模型没有UV映射，或者其UV映射的布局欠佳，你通常会在尝试使用带纹理的材质时遇到明显的问题。例如，如果UV映射有许多 *接缝*（网格体几何体上相邻的三角形在UV映射中不相邻的地方），纹理将在接缝处显示可见的关节。或者，如果UV映射将UV空间的区域不均匀地分配到网格体的三角形，使得网格体上的大三角形映射到纹理的小区域或反之，纹理就会在网格体的不同部分表现为拉伸或失真。

为获得最佳的艺术效果，务必尝试在专用建模工具中为你的3D对象创建UV映射。但是，有时行不通。例如，当你将某些类型的CAD建模应用程序中的数据导入到虚幻引擎时，可能无法在源应用程序中创建高质量UV映射。对于这些情况，你可以在虚幻编辑器中创建UV映射。

虚幻编辑器提供了两种方法来为静态网格体创建UV映射：

- 选项1：解包网格体几何体
- 选项2：将网格体投影到2D空间

> [!NOTE]
> **项目设置：** 为了使用下面概括的任一UV通道生成方法，你必须为虚幻引擎项目安装 **UV编辑器（UV Editor）** 插件。

> 图片已省略：UV Editor and Static Mesh Editor Modeling Mode Plugins

点击查看大图。

#### 选项1：解包网格体几何体

在此方法中，组成静态网格体几何体的三角形会自动展开并展平。三角形的表面区域会自动调整，以保留相邻三角形的相邻性，相邻表面之间的角度超出你设置的阈值的地方会引入接缝。

要将静态网格体解包为新的UV映射，请执行以下操作：

1. 选择你想解包的静态网格体，并执行以下任一操作：

   - 在 **内容浏览器（Content Browser）** 中右键点击你的静态网格体，并从上下文菜单选择 **解包UV（Unwrap UV）** 。

     > 图片已省略：Unwrap UV in the Content Browser

     点击查看大图。
   - 在静态网格体编辑器中打开你想生成的静态网格体。然后，从静态网格体编辑器的工具栏选择 **UV > 解包UV（Unwrap Uvs）** 。

     > 图片已省略：Unwrap UV in the Static Mesh Editor

     点击查看大图。

     > [!TIP]
     > 如果你看不到其中任何一个菜单选项，请确保你为项目启用了 **多边形编辑（Polygon Editing）** 插件。
2. 设置参数以控制解包的结果：

   > 图片已省略：Unwrap UV settings

   点击查看大图。

   | 设置 | 说明 |
   | --- | --- |
   | **通道选择（Channel Selection）** | 确定解包过程如何选择要将新的UV映射保存到哪个通道。 **自动光照贴图设置（Automatic Lightmap Setup）** ：将解包的UV映射保存到为此静态网格体设置为光照贴图UV的源的通道，然后根据新的UV映射生成新的光照贴图UV。 **首个空通道（First Empty Channel）** ：将解包的UV映射保存到静态网格体中的首个空UV通道。 **指定通道（Specify Channel）** ：选择此选项可在 **UV通道（UVChannel）** 设置中指定通道索引。 |
   | **UV通道（UVChannel）** | 当 **通道选择（Channel Selection）** 设置为 **指定通道（Specify Channel）** 时，使用此设置可确定解包的UV保存到的UV通道的索引。 |
   | **角度阈值（Angle Threshold）** | 确定两个相邻面之间允许的最大角度，以使这两个面在解包后保持连接。该值越高，UV"孤岛"的数量就越少，就会有更多三角形与相邻三角形保持连接，并减少可能导致纹理映射中发生破裂的接缝数量。但是，这还可能在封装的纹理中引入更多失真，因为三角形可能需要在2D空间中更激进地调整大小，以便与相邻三角形保持连接。 |
3. 点击 **继续（Proceed）** 。

#### 选项2：将网格体几何体投影到UV通道

你可以使用投影体积（平面、盒体或球体）将静态网格体的3D几何体投影到2D纹理空间。在此方法中，静态网格体的每个面向外投影到投影体积的面，然后投影体积会解包为2D纹理空间。

> [!NOTE]
> 该功能目前仅处理3D网格体到2D的投影，而不能处理全功能建模和纹理工具中包含的完整投影编辑功能。

1. 在静态网格体编辑器中打开你想生成的静态网格体。

   例如，在 **内容浏览器（Content Browser）** 中双击静态网格体资产。
2. 在静态网格体编辑器的工具栏中，选择 **UV > 生成UV（Generate Uvs）** 。

   > [!TIP]
   > 如果你看不到此菜单选项，请确保你为项目启用了 **多边形编辑（Polygon Editing）** 插件。
3. 你会看到显示 **生成UV（Generate UV）** 面板，它提供了一组功能按钮来帮助你控制UV投影的结果。

   > 图片已省略：Generate UV panel Projection Settings

   点击查看大图。

   你还会看到视口中静态网格体周围显示一个绿色的体积，其中带有标准虚幻编辑器操控器小工具。

   > [!TIP]
   > 如果该体积和操控器起初不显示，请切换 **生成UV（Generate UV）** 面板底部的 **显示小工具（Show Gizmo）** 按钮。
4. 在 **投影类型（Projection Type）** 设置中，选择最适合静态网格体尺寸的体积。
5. 调整体积的大小、位置和旋转，以匹配静态网格体的范围。

   为此，你可以在视口中或 **生成UV（Generate UV）** 面板中的文本字段中使用操控器。你还可以使用 **适应（Fit）** 按钮，让体积自动适应静态网格体几何体的范围，为后面的操作打好基础。
6. 在 **目标通道（Target Channel）** 设置中，设置你想将投影的UV映射保存到的通道的索引。

   > [!TIP]
   > 大部分材质从通道0获取纹理坐标。如果你要生成UV映射来改善纹理在静态网格体几何体周围映射的方式，通常需要在此字段中设置 `0` 。
7. 点击 **应用（Apply）** 以生成UV映射并将其保存到静态网格体中的目标通道。

下表说明了 **生成UV（Generate UV）** 面板中的所有设置：

| 设置 | 说明 |
| --- | --- |
| **投影类型（Projection Type）** | 静态网格体几何体投影到的体积。 |
| **大小（Size）** | 投影体积的尺寸。 |
| **位置（Position）** | 投影体积相对于静态网格体的枢轴点的位置。 |
| **旋转（Rotation）** | 投影体积相对于静态网格体的枢轴点的旋转。 |
| **UV平铺比例（V Tiling Scale）** | UV空间中投影的比例。使用更大的值时，纹理空间中的投影会更大，这会导致在封装网格体表面时纹理细节显得更小。 |
| **UV偏移（UV Offset）** | 控制2D纹理空间中投影的位置。在X轴使用更小的值时，投影会在UV映射中左移；使用更大的值时，投影会右移。在Y轴使用更小的值时，投影会在UV映射中上移；使用更大的值时，投影会下移。 |
| **目标通道（Target Channel）** | 投影将保存到的UV通道的索引。这不能是静态网格体编辑器用于存储生成的光照贴图UV的那个通道。如果目标通道已经包含数据，编辑器将要求确认后再继续。 |
| **显示小工具（Show Gizmo）** | 在视口中切换渲染投影体积和操控器小工具。 |
| **应用（Apply）** | 根据上述设置生成UV投影，并将结果保存到 **目标通道（Target Channel）** 。 |
| **适应（Fit）** | 使投影体积的大小包围静态网格体的完整几何体。 |

## 编辑器脚本编写中的UV通道

对于你在虚幻编辑器中运行的蓝图和Python脚本，你还可以在其中使用UV通道。静态网格体编辑器中能做的操作，这里也能做，此外，你还可以添加新通道并生成新UV映射。

> [!NOTE]
> **先决条件：** 如果尚未安装"编辑器脚本编写工具（Editor Scripting Utilities）"插件，你需要安装该插件。有关详细信息，请参阅[对编辑器编写脚本和自动执行](../../../production-pipeline/scripting-and-automating-the-unreal-editor/index.md)。

选择实现方法：

Blueprints

Python

你将在 **编辑器脚本编写（Editor Scripting）> 静态网格体（Static Mesh）** 类别下找到管理UV通道所需的节点。

> [!NOTE]
> 要使用这些节点，你的蓝图类必须从只能在编辑器中使用的类派生，例如 **PlacedEditorUtilityBase** 类。有关详细信息，请参阅[使用蓝图对编辑器编写脚本](../../../production-pipeline/scripting-and-automating-the-unreal-editor/scripting-the-unreal-editor-using-blueprints/index.md)。

所有这些函数都用于静态网格体资产，你通常需要调用 **Editor Scripting> Asset Library> Load Asset** 节点来加载该资产。

修改UV通道会修改资产。假如你需要保留所做的更改，此后你还需要使用 **Editor Scripting> Asset Library> Save Asset** 或 **Save Loaded Asset** 之类的节点。请参阅以下示例。

### 列出UV通道

你可以使用 **Get Num UV Channels** 节点了解给定静态网格体资产中目前存在多少个UV通道。

例如：

> 图片已省略：Get the number of UV channels

点击查看大图。

### 删除UV通道

每个UV通道将每个顶点的纹理坐标存储为静态网格体的一部分，这样你可以删除不使用的映射来节省一些运行时内存。

要删除UV通道，请调用 **Remove UV Channel** 节点。为其传递静态网格体资产以及你想删除的UV通道的索引。

例如：

> 图片已省略：Remove a UV Channel

点击查看大图。

列表中指定索引后面已经存在的其他所有UV通道会上移一个位置，填补所删除条目留下的空白。

> [!NOTE]
> 如果静态网格体资产设置为生成光照贴图UV，并且所选UV通道已经被用作光照贴图UV的源或目标通道，则不能删除该UV通道。停用 **构建设置（Build Settings）> 生成光照贴图UV（Generate Lightmap UVs）** 选项，或将 **构建设置（Build Settings）> 源光照贴图索引（Source Lightmap Index）** 和 **构建设置（Build Settings）> 目标光照贴图索引（Destination Lightmap Index）** 设置更改为指向不同的UV通道。

### 添加新的UV通道

你可以调用以下任一节点，将新的UV通道添加到静态网格体资产：

- Add UV Channel

  - 在现有通道列表末尾添加新的通道。
- Insert UV Channel

  - 在你指定的索引处添加新的通道，将列表中的其他每个UV通道下移一个数字。请注意，UV通道的数组不能是稀疏的：你只能在列表中另一个现有通道旁边的位置插入新通道。例如，如果列表中有三个UV通道（索引0、1和2），你可以添加索引为3的新通道，但不能添加索引为4的新通道。

> 图片已省略：Add and insert a UV Channel

点击查看大图。

新的映射为空。你需要以某种方式填充它，然后才能使用，具体方法可以是投影网格体几何体（见下文），也可以是将其用作目标来生成光照贴图。

### 将网格体几何体解包到UV通道

你可以让静态网格体编辑器自动展开并展平组成静态网格体几何体的三角形，从而创建新的UV映射。三角形的表面区域会自动调整，以保留相邻三角形的相邻性，相邻表面之间的角度超出你设置的阈值的地方会引入接缝。

> [!NOTE]
> **项目设置：** 为了使用下面概括的UV通道生成方法，你必须为虚幻引擎项目安装 **多边形编辑（Polygon Editing）** 插件。

使用 **Generate Unwrapped UVs** 节点。你需要为此节点提供以下内容：

- 对你想修改的静态网格体资产的引用。
- 你想将解包的UV保存到的UV通道的索引。如果此通道尚不存在，解包过程将创建它。
- 要使两个相邻面在解包后保持连接，这两个面之间允许的最大角度。该值越高，UV"孤岛"的数量就越少，就会有更多三角形与相邻三角形保持连接，并减少可能导致纹理映射中发生破裂的接缝数量。但是，这还可能在封装的纹理中引入更多失真，因为三角形可能需要在2D空间中更激进地调整大小，以便与相邻三角形保持连接。

例如：

> 图片已省略：Unwrap a Static Mesh into a UV Mapping

点击查看大图。

### 将网格体几何体投影到UV通道

你可以将静态网格体中的三角形投影到2D平面或简单的3D体积，创建新的UV映射。

> [!NOTE]
> 下面所述每个节点会将它所创建的UV映射保存到你指定的UV通道。此UV通道必须已存在；如果不存在，函数不会创建它。

#### 平面投影

使用 **Generate Planar UV Channel** 节点将静态网格体几何体投影到平面。如果静态网格体只有一侧需要封装纹理，请使用这种投影。

例如：

> 图片已省略：Make a planar projection

点击查看大图。

#### 圆柱形投影

使用 **Generate Cylindrical UV Channel** 节点将静态网格体几何体投影到圆柱形的侧面、顶部和底部。

例如：

> 图片已省略：Make a cylindrical projection

点击查看大图。

#### 盒体投影

使用 **Generate Box UV Channel** 节点将静态网格体几何体投影到立方体的各个面。

例如，以下脚本将创建大小与静态网格体大致相等的盒体，然后将静态网格体的几何体投影到该盒体的侧面，创建新的UV映射：

> 图片已省略：Make a box projection

点击查看大图。

你会在 `unreal.EditorStaticMeshLibrary` 类中发现LOD管理函数。

所有这些函数用于静态网格体资产，你通常需要调用 `unreal.EditorAssetLibrary.load_asset` 之类的函数来加载该资产。

修改UV通道会修改资产。假如你需要保留所做的更改，此后你还需要使用 `unreal.EditorAssetLibrary.save_asset` 或 `unreal.EditorAssetLibrary.save_loaded_asset` 之类的函数。

### 列出UV通道

你可以使用 `unreal.EditorStaticMeshLibrary.get_num_uv_channels` 函数了解给定静态网格体资产中目前存在多少个UV通道。

例如：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 获取资产中保存的UV通道数量。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	print("Number of UV channels: " + str(num_uv_channels)) 
```

### 删除UV通道

每个UV通道将每个顶点的纹理坐标存储为静态网格体的一部分，这样你可以删除不使用的映射来节省一些运行时内存。

要删除UV通道，请调用 `unreal.EditorStaticMeshLibrary.remove_uv_channel` 函数。为其传递静态网格体资产以及你想删除的UV通道的索引。

例如：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 获取资产中保存的UV通道数量。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	# 删除列表中的最后一个通道。	channel_to_remove = num_uv_channels - 1	unreal.EditorStaticMeshLibrary.remove_uv_channel(asset_name, channel_to_remove)	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```

列表中指定索引后面已经存在的其他所有UV通道会上移一个位置，填补所删除条目留下的空白。

> [!NOTE]
> 如果静态网格体资产设置为生成光照贴图UV，并且所选UV通道已经被用作光照贴图UV的源或目标通道，则不能删除该UV通道。停用 ****构建设置（Build Settings）>******生成光照贴图UV（Generate Lightmap UVs）** 选项，或将 **构建设置（Build Settings）>****源（Source）****光照贴图索引（Lightmap Index）** 和 **构建设置（Build Settings）>****目标光照贴图索引（Destination Lightmap Index）** 设置更改为指向不同的UV通道。

### 添加新的UV通道

你可以调用以下任一函数，将新的UV通道添加到静态网格体资产：

- unreal.EditorStaticMeshLibrary.add_uv_channel

  - 在现有通道列表末尾添加新的通道。
- unreal.EditorStaticMeshLibrary.insert_uv_channel

  - 在你指定的索引处添加新的通道，将列表中的其他每个UV通道下移一个数字。请注意，UV通道的数组不能是稀疏的：你只能在列表中另一个现有通道旁边的位置插入新通道。例如，如果列表中有三个UV通道（索引0、1和2），你可以添加索引为3的新通道，但不能添加索引为4的新通道。

例如：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 获取资产中保存的UV通道数量。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	print("Number of UV channels before: " + str(num_uv_channels))	# 将一个通道添加到列表末尾。	unreal.EditorStaticMeshLibrary.add_uv_channel(asset_name)	# 在列表开头添加一个通道。	unreal.EditorStaticMeshLibrary.insert_uv_channel(asset_name, 0)	# 获取资产中保存的UV通道的新数量。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	print("Number of UV channels after: " + str(num_uv_channels))	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```

新的映射为空。你需要以某种方式填充它，然后才能使用，具体方法可以是投影网格体几何体（见下文），也可以是将其用作目标来生成光照贴图。

### 将网格体几何体解包到UV通道

你可以让静态网格体编辑器自动展开并展平组成静态网格体几何体的三角形，从而创建新的UV映射。三角形的表面区域会自动调整，以保留相邻三角形的相邻性，相邻表面之间的角度超出你设置的阈值的地方会引入接缝。

> [!NOTE]
> **项目设置：** 为了使用下面概括的UV通道生成方法，你必须为虚幻引擎项目安装 **多边形编辑（Polygon Editing）** 插件。

使用 `unreal.UVGenerationFlattenMapping.generate_flatten_mapping_u_vs()` 函数。为其传递以下内容：

- 对你想修改的静态网格体资产的引用。
- 你想将解包的UV保存到的UV通道的索引。如果此通道尚不存在，解包过程将创建它。
- 要使两个相邻面在解包后保持连接，这两个面之间允许的最大角度（以度为单位）。该值越高，UV"孤岛"的数量就越少，就会有更多三角形与相邻三角形保持连接，并减少可能导致纹理映射中发生破裂的接缝数量。但是，这还可能在封装的纹理中引入更多失真，因为三角形可能需要在2D空间中更激进地调整大小，以便与相邻三角形保持连接。

例如：

```
	import unreal	asset_name = '/Game/Meshes/StaticMesh'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 指定要保存到的UV通道。	channel_index = 2	# 设置角度阈值	angle_threshold = 55	# 将网格体解包为UV通道	unreal.UVGenerationFlattenMapping.generate_flatten_mapping_u_vs(loaded_asset, channel_index, angle_threshold)	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```

### 将网格体几何体投影到UV通道

你可以将静态网格体中的三角形投影到2D平面或简单的3D体积，创建新的UV映射。

这目前仅在虚幻编辑器脚本编写API中公开，而不在静态网格体编辑器的UI中公开。但是，如果你已经熟悉网格体投影的视觉工具，例如3ds Max中的工具，API所需的过程和设置会更容易理解。请参阅3ds Max帮助中的[UVW贴图修饰符](http://help.autodesk.com/view/3DSMAX/2019/ENU/?guid=GUID-78327298-4741-470C-848D-4C3618B18FCA)，了解背景信息。

> [!NOTE]
> 下面所述每个函数会将它所创建的UV映射保存到你指定的UV通道。此UV通道必须已存在；如果不存在，函数不会创建它。

#### 平面投影

使用 `unreal.EditorStaticMeshLibrary.generate_planar_uv_channel` 函数将静态网格体几何体投影到平面。如果静态网格体只有一侧需要封装纹理，请使用这种投影。

例如：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 指定要投影的LOD。	lod_index = 0	# 为我们的投影添加新的UV通道。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	unreal.EditorStaticMeshLibrary.add_uv_channel(asset_name)	channel_index = num_uv_channels	# 设置投影平面或"小工具"。	bbox = loaded_asset.get_bounding_box()	gizmo_pos = ((bbox.min + bbox.max) * 0.5)   # 找到对象的边界框的中心。	# 设置旋转角度（以度为单位）。	pitch = 0   # 围绕X轴	yaw = 0     # 围绕Y轴	roll = 0    # 围绕Z轴	gizmo_orientation = unreal.Rotator(pitch, yaw, roll)	# 增加或减少值以使投影变得更大或更小。	tiling = unreal.Vector2D(1, 1)	# 将静态网格体几何体投影到UV通道。	unreal.EditorStaticMeshLibrary.generate_planar_uv_channel(loaded_asset, lod_index, channel_index, gizmo_pos, gizmo_orientation, tiling)	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```

#### 圆柱形投影

使用 `unreal.EditorStaticMeshLibrary.generate_cylindrical_uv_channel` 函数，将静态网格体几何体投影到圆柱形的侧面、顶部和底部。

例如：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 指定要投影的LOD。	lod_index = 0	# 为我们的投影添加新的UV通道。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	unreal.EditorStaticMeshLibrary.add_uv_channel(asset_name)	channel_index = num_uv_channels	# 设置投影圆柱形或"小工具"。	bbox = loaded_asset.get_bounding_box()	gizmo_pos = ((bbox.min + bbox.max) * 0.5)   # 找到对象的边界框的中心。	# 设置旋转角度（以度为单位）。	pitch = 0   # 围绕X轴	yaw = 0     # 围绕Y轴	roll = 0    # 围绕Z轴	gizmo_orientation = unreal.Rotator(pitch, yaw, roll)	# 增加或减少值以使投影变得更大或更小。	tiling = unreal.Vector2D(1, 1)	# 将静态网格体几何体投影到UV通道。	unreal.EditorStaticMeshLibrary.generate_cylindrical_uv_channel(teapot, lod_index, channel_index, gizmo_pos, gizmo_orientation, tiling)	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```

#### 盒体投影

使用 `unreal.EditorStaticMeshLibrary.generate_box_uv_channel` 函数将静态网格体几何体投影到立方体的各个面。

例如，以下脚本将创建大小与静态网格体大致相等的盒体，然后将静态网格体的几何体投影到该盒体的侧面，创建新的UV映射：

```
	import unreal	asset_name = '/Game/Path/MyStaticMeshAsset'	# 加载静态网格体资产。	loaded_asset = unreal.EditorAssetLibrary.load_asset(asset_name)	# 指定要投影的LOD。	lod_index = 0	# 为我们的投影添加新的UV通道。	num_uv_channels = unreal.EditorStaticMeshLibrary.get_num_uv_channels(asset_name)	unreal.EditorStaticMeshLibrary.add_uv_channel(asset_name)	channel_index = num_uv_channels	# 设置投影体积或"小工具"。	bbox = loaded_asset.get_bounding_box()	gizmo_pos = ((bbox.min + bbox.max) * 0.5)   # 找到对象的边界框的中心。	# 设置旋转角度（以度为单位）。	pitch = 0   # 围绕X轴	yaw = 0     # 围绕Y轴	roll = 0    # 围绕Z轴	gizmo_orientation = unreal.Rotator(pitch, yaw, roll)	# 获取盒体的大小。	gizmo_size = bbox.max - bbox.min	# 将静态网格体几何体投影到UV通道。	unreal.EditorStaticMeshLibrary.generate_box_uv_channel(box, channel_index, lod_index, gizmo_pos, gizmo_orientation, gizmo_size)	# 保存修改的资产。	unreal.EditorAssetLibrary.save_asset(asset_name) 
```


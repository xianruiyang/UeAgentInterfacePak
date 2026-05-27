# Visual Dataprep操作参考

---
title: "Visual Dataprep操作参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dataprep-operation-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Dataprep导入自定义", "Visual Dataprep操作参考"]
---

# Visual Dataprep操作参考

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Dataprep导入自定义 / Visual Dataprep操作参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dataprep-operation-reference-in-unreal-engine

本页介绍可在Visual Dataprep系统中修改资产和场景元素的各个 **操作（Operations）** 块。

每种类型的 **操作块（Operations block）** 都封装了虚幻编辑器可对3D数据执行的一种特定修改。Visual Dataprep系统在Dataprep图表中执行各项作业时，会对所有匹配 **Select By** 块所设定条件的资产或Actor执行该项作业中已定义的各个操作。更多背景信息请参见[Dataprep概览](../dataprep-overview/index.md)。

## On Actor

**On Actor** 操作仅应用于与相关步骤所设的 **Select By** 条件匹配的Actor。这表示仅可看到Dataprep预览UI右侧 **大纲视图预览（Outliner Preview）** 面板中列示的项目。若 **Select By** 条件匹配其他场景元素，比如Dataprep预览UI左侧 **内容浏览器预览（Content Browser Preview）** 面板中列示的纹理、材质和静态网格体资产，则 **On Actor** 操作对这些元素无效。

### 添加标签

此操作会将你指定的标签数组添加给所有些符合此步骤中 **选择依据（Select By）** 条件的Actor或组件。

![Add Tags](../../../../../assets/images/ea/ea3dc1fd760145f7f18b507945f641516d36b2b609e7c0e086e03083ecf7c2cd.png)

点击查看大图

> [!TIP]
> 完成该块后，在 **大纲视图预览（Outliner Preview）** 中选择Actor，在 **细节（Details）** 面板中查找，可找到标签列表。在 **Actor** 类别下，展开高级选项，然后查找 **标签（Tags）** 设置。
>
> ![Actor Tags after addition](../../../../../assets/images/25/25ecb7a6b1cb5bd10d4ea1bed253534db40ace2f041e96ecc071703abd19e49b.png)
>
> 点击查看大图

### 添加到层

此操作将所有符合这一步骤设置的 **Select By** 条件的静态网格体Actor添加到你指定的层中。

![Add To Layer](../../../../../assets/images/cb/cb1b239443a538f5528372af79cf40ae779c984aa5b2f21190c50d977bbdf3e6.png)

点击查看大图

### 紧凑场景图

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体Actor，若该Actor在场景中无任何视觉效果，或其在场景层级中的所有后代在场景中都无任何视觉效果，则此操作会删除该Actor。效果是汰除场景层级中的不必要元素，而不影响场景中的视觉对象。

![Compact Scene Graph](../../../../../assets/images/c1/c1ffc6d6f547c017c4fb19df4d295bbc543f1eee74be7d157a74bd0dc3e842d1.png)

点击查看大图

### 创建代理网格体

此操作会收集所有符合此步骤所设 **Select By** 条件的静态网格体Actor和组件，并使用[代理几何体工具](../../../static-meshes/proxy-geometry-tool/index.md)将几何体合并到新网格体中。

![Create Proxy Mesh](../../../../../assets/images/ff/ff07ba7fa21b7d8b224ba96173e32a49782d926fa785d7917ff2f2017f49424b.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **新Actor标签（New Actor Label）** | 指定根据合并几何体创建的新Actor的名称。 |
| **质量（Quality）** | 已生成的代理模型的几何体质量水平。值越小，详细程度越低，但渲染效率会变高。值越大，详细程度越高，越贴近原始几何体，但渲染效率会降低。 |

### 合并

此操作会找出所有符合 **Select By** 条件的静态网格体Actor和组件并获取它们的几何体，然后将这些几何体合并到一个新的网格体中。

![Merge](../../../../../assets/images/a9/a9cfd0dadad0e9a734ef0accbe44daa422cd8ac54a86804cc92494d16710eb9c.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **新Actor标签（New Actor Label）** | 指定根据合并几何体创建的新Actor的名称。 |
| **以零为枢轴点（Pivot Point at Zero）** | 若要合并网格体，以将其枢轴点设为世界原点，可启用此设置。若禁用，枢轴将位于第一个合并的组件上。 |

### 随机偏移变换

此操作会对所有符合此步骤中设置的 **选择依据（Select By）** 条件的Actor的3D位置、旋转或缩放应用随机偏移效果。若场景中存在一些临时放置的元素，则可使用此操作将这些元素分散开来，或为元素设定不同的大小和旋转度。

举例而言，室外建筑场景可能包含一些临时放置的对象，用于表示树木或灌木丛等建筑配景对象。在Dataprep图表中，你可能需要将全部这类临时对象替换为已经导入到项目中的其他自定义3D资产。但这样可能生成一排外观完全相同的树木，会显得不够真实。通过对树木的位置、旋转度和缩放应用随机偏移，可快速创建更多样化和逼真的结果，而无需手动调整对象。

![Random Offset Transform](../../../../../assets/images/d0/d0f57e480df218a8af74f1328368cef29aca8116ae6cdc6ebf040dcc7a5585c3.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **变换类型（Transform Type）** | 每个 **随机偏移变换（Random Offset Transform）** 块只能将偏移应用于下述其中一种属性： **位置（Location）**，用于调整对象在3D空间中的位置。 **旋转（Rotation）**，用于调整对象的朝向。 **缩放（Scale）**，用于调整对象的大小。 |
| **参考系（Reference Frame）** | 确定使用哪个参考系解释 **最小值（Min）** 和 **最大值（Max）** 设置中的轴： **全局（Global）** 使用世界空间来解释 **最小值（Min）** 和 **最大值（Max）**，偏移效果相对的是全局空间中的3D轴。 **相对（Relative）** 使用局部空间来解释 **最小值（Min）** 和 **最大值（Max）**，偏移效果相对的是对象自身的枢轴点。 |
| **最小值（Min）** 和 **最大值（Max）** | 沿3D空间的三个轴分别设置随机偏移范围。针对此块处理的每个Actor，其将生成一个处于 **最小值（Min）** 和 **最大值（Max）** 之间的随机数字。 |

### 设置网格体

对于所有符合此 **Select By** 条件的静态网格体Actor或组件，此操作会将该Actor或组件引用的静态网格体资产更改为你在设置中指定的其他静态网格体资产。

![Set Mesh](../../../../../assets/images/b5/b527c0166df06d57a49bf4e6ed256d78c75e8f4ffb74cf4f5d2ec0a22e02067f.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **静态网格体（Static Mesh）** | 要让Actor实例化的静态网格体资产，用以替代现有静态网格体。可以使用Dataprep编辑器的 **内容浏览器预览（Content Browser Preview）** 面板中的任何静态网格体替代，也可以使用项目中现存的任何静态网格体资产。 |

> [!NOTE]
> 此操作对尚未引用静态网格体资产的Actor无效。例如，若场景层级中有一个不含静态网格体的空Actor，则将无法使用此操作向该Actor添加新静态网格体。

### 设置元数据

此操作会找到所有符合此步骤中的 **选择依据（Select By）** 条件的Actor和组件，然后为其Datasmith元数据添加一个键值对数组。

> 图片已省略：Set Metadata

点击查看大图

> [!TIP]
> 执行完该块后，你可以在 **世界大纲视图预览（World Outliner Preview）** 中选中Actor或组件，然后在 **资产用户数据（Asset User Data）** 类别的 **细节（Details）** 面板中找到元数据列表。
>
> 欲知更多信息，请参见[使用Datasmith元数据](../../using-datasmith-metadata/index.md)。

### 设置移动性

对于每个与此步骤所设的 **Select By** 条件匹配的Actor或组件，此操作会设置该Actor的 **移动性（Mobility）** 的值。

> [!TIP]
> **移动性（Mobility）** 设置对光源Actor的影响与对静态网格体Actor的影响略有不同。欲了解详细解释，参见[Actor移动性](../../../../understanding-the-basics/actors-and-geometry/actor-mobility/index.md)。

> 图片已省略：Set Mobility

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **移动性类型（Mobility Type）** | 要为Actor的 **移动性（Mobility）** 设置的值。 |

> [!TIP]
> 在 **详细信息（Details）** 面板中找到 **移动性（Mobility）** 设置：
>
> > 图片已省略：Actor Mobility
>
> 点击查看大图

### 在位置处生成Actor

针对每个符合此步骤所设的 **选择依据（Select By）** 条件的Actor，此操作会在相同的3D坐标处生成新Actor。新生成的Actor是你在 **选定资产（Selected Asset）** 设置中指定的资产的实例。

> 图片已省略：Spawn Actors at Location

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **选定资产（Selected Asset）** | 要生成新实例的项目中的资产。 |

## On Asset

**On Asset** 操作仅应用于那些符合你在相关步骤中所设置的 **选择依据（Select By）** 条件的资产。这表示仅可看到Dataprep预览UI左侧的 **内容浏览器预览（Content Browser Preview）** 面板中列出的项目。若 **选择依据（Select By）** 条件匹配其他场景元素，比如Dataprep预览UI右侧的 **大纲视图预览（Outliner Preview）** 面板中列出的Actor，则 **On Asset** 操作对这些元素无效。

### 输出到文件夹

此操作会找到所有符合你在此步骤中所设的 **选择依据（Select By）** 条件的资产，然后将其移动到拥有指定名称的子文件夹中。提交Dataprep图表的结果后，你可以使用此块来自定义导入资产在项目内容浏览器中的组织方式。

> [!NOTE]
> 执行Dataprep图表时，**输出到文件夹（Output to Folder）** 块的结果不会显示在Dataprep编辑器的 **内容浏览器预览（Content Browser Preview）** 面板中。提交Dataprep图表后，仅能在项目的 **内容浏览器（Content Browser）** 中看到结果。

> 图片已省略：Output to Folder

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **文件夹名称（Folder Name）** | 提交Dataprep图表时，要放置所选资产的子文件夹的名称。 |

你可在Dataprep图表中使用任意数量的 **输出到文件夹（Output to Folder）** 块。若不同的块使用了相同的 **文件夹名称（Folder Name）** 设置，则由这些块处理的资产会被收集到同一个文件夹中。这样就能将不同操作中由不同过滤器产生的资产重定向到内容浏览器（Content Browser）中的同一文件夹中。通过将多个 **输出到文件夹（Output to Folder）** 块与不同的过滤器配对使用，你就能按照你的想法，在 **内容浏览器（Content Browser）** 中以任意方式组织资产。

举例而言，在这个例子中，在Dataprep编辑器右上角的设置面板中，设置的主文件夹为 **/Content/Motorbike**。此图表中的第一个操作将获取三角形少于1000个的所有静态网格体资产，并将其移动到名为 **LowPoly** 的子文件夹中。第二个操作将获取三角形多于1000个的所有其他静态网格体，并将其移至名为 **HighPoly** 的子文件夹中。最后两个操作将获取所有材质和所有材质实例，并将其移动到名为 **表面（Surfaces）** 的子文件夹中。

> 图片已省略：Output to Folder example graph

点击查看大图

提交Dataprep图表后，内容浏览器（Content Browser）将出现以下目录结构：

> 图片已省略：Output to Folder example result

点击查看大图

那些在Datasmith默认导入过程中创建的 **几何体（Geometries）** 和 **材质（Materials）** 子文件夹仍会被创建，但在这种情况下，这些子文件夹将是空的。所有资产均已重新分配到新的 **HighPoly**、**LowPoly** 和 **Surfaces** 子文件夹中。

### 替换资产引用

此块将识别传入对象列表中的 *第一个* 资产。然后，尝试将输入列表中 *其他* 资产的所有引用替换为第一个资产的引用。

举例而言，假设输入列表中的第一个对象是名为 **椅子** 的静态网格体资产。该块将浏览输入列表中的所有其他对象，以查找其他静态网格体资产，例如 **桌子**、**长凳** 和 **梳妆台**。然后，将在导入场景中找到的所有 **桌子**、**长凳** 和 **梳妆台** 引用替换为 **椅子** 引用，*并* 完全删除 **桌子**、**长凳** 和 **梳妆台** 资产。

> 图片已省略：Replace Asset References

点击查看大图

### 设置最大纹理尺寸

默认情况下，Datasmith会将导入纹理的尺寸缩放为2的幂。此方法设置的数值会限制纹理在游戏中的最大尺寸，但不会影响纹理导入时的尺寸。

**最大纹理尺寸（Max Texture Size）** 的效果类似任何其他纹理上的 **最大纹理尺寸（Max Texture Size）**，它会将你输入的数值近似为2的幂。

> 图片已省略：Set Max Texture Size

点击查看大图

## On Mesh

**On Mesh** 操作仅应用于静态网格体资产。

- 若

  Select By

  条件与

  内容浏览器预览（Content Browser Preview）

  面板中

  几何体（Geometries）

  文件夹下列示的任何静态网格体资产匹配，此操作将应用于这些资产。
- 若

  Select By

  条件与

  大纲视图预览（Outliner Preview）

  中任何引用静态网格体资产的Actor匹配，此操作还将应用于这些静态网格体资产。
- 若

  Select By

  条件与任何其他类型的场景元素匹配，比如Actor、纹理或材质，则

  On Mesh

  操作对这些元素无效。

### 烘焙变换

对于与你为此步骤设置的 **Select By** 条件匹配的每个静态网格体Actor，此操作可通过将静态网格体Actor的变换直接烘焙到其引用的网格体来创建新网格体，并用此新网格体替换静态网格体Actor。此操作提供几个选项：

> 图片已省略：Bake Transform

点击查看大图

| 设置（Setting） | 说明（Description） |
| --- | --- |
| **烘焙旋转（Bake Rotation）** | 将当前旋转作为操作的一部分烘焙。默认启用。 |
| **烘焙缩放（Bake Scale）** | 确定操作如何处理烘焙缩放，并包括以下选项： **烘焙全部缩放（Bake Full Scale）**：烘焙所有缩放信息，以便网格体在所有轴上的缩放为1 **烘焙非均匀缩放（Bake Non Uniform Scale）**：烘焙非均匀缩放信息，以便网格体具有均匀缩放。 **不烘焙缩放（Do Not Bake Scale）**：不会作为操作的一部分烘焙缩放。 |
| **重定位中心点（Recenter Pivot）** | 转译新网格体的几何形状，以便将静态网格体Actor平移放在中心位置。 |

### 翻转面

此操作会找到所有符合此步骤中 **选择依据（Select By）** 条件的静态网格体，并翻转网格体中所有三角形的朝向。

> 图片已省略：Flip Faces

点击查看大图

> [!NOTE]
> 该块有助于翻转在源应用程序中创建的网格体的朝向。这些应用程序在后向三角形可视性的规定上通常有所不同。但请注意，该操作并不具有选择性： *所有* 三角形的朝向都将翻转。如果静态网格体中的三角形在朝向上有些不一致，有些可见，有些不可见，则你可能还需做一些其他更改，例如在静态网格体编辑器中手动翻转面，或使用已启用 **双面（Two Sided）** 选项的材质。

### 生成展开的UV

对于任何与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作将网格体几何体展开成2D UV贴图并将该贴图保存到静态网格体资产的指定UV通道中。

> 图片已省略：Generate Unwrapped UVs

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **通道选择（Channel Selection）** | 确定生成的UV贴图保存到哪个UV通道。**第一个空通道（First Empty Channel）** 将展开的UV保存在第一个空UV通道。**指定通道（Specify Channel）** 将展开的UV保存在 **UV通道（UV Channel）** 设置所标识的通道内。 |
| **UV通道（UV Channel）** | **通道选择（Channel Selection）** 设为 **指定通道（Specify Channel）** 时，使用此设置确定展开的UV保存到的UV通道的索引。 |
| **角度阈值（Angle Threshold）** | 确定两个相邻面在展开之后仍保持连接时的最大角度。增大此值会减少单独UV"岛状区"的数量，使更多相邻三角形保持连接，并减少会导致纹理贴图断开的接缝数量。但由于三角形可能需要在2D空间中更积极地调整大小，以保持与相邻三角形的连接，因此这也会导致展开的纹理更加失真。 |

### 重新网格化

对于每个与你为此步骤所设的 **选择依据（Select By）** 条件匹配的静态网格体，此操作使用各向同性重新网格化，以便达到与你指定的目标值匹配的三角形数。此操作提供几个选项：

> 图片已省略：Remesh

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **目标三角形数量（Target Triangle Count）** | 指定新网格体的目标三角形数量。 |
| **平滑率（Smoothing Rate）** | 在重新网格化过程中应用指定数量的顶点平滑。范围为0至1。 |
| **丢弃属性（Discard Attributes）** | 如果设置为True，则丢弃现有的UV和法线。 |
| **重新网格化类型（Remesh Type）** | 确定重新网格化过程中应用多少通道： **标准（Standard）**：在整个网格体上应用一个通道，然后仅重新网格化已更改边缘。 **完整通道（Full Pass）**：在整个网格体上应用多个完整通道。这将启用重新网格化迭代选项，你可以指定工具制作的增量通道数量。 **法线流（Normal Flow）**：在整个网格体上应用一个通道，然后仅重新网格化已更改边缘。使用法线流将三角形与原始输入网格体对齐。 |
| **网格体边界（Mesh Boundary）** | 确定如何保留开放网格体的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |
| **组边界（Group Boundary）** | 确定如何保留多边形组的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |
| **材质边界（Material Boundary）** | 确定如何保留材质区域的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |

### 设置凸包碰撞

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作将静态网格体的碰撞替换为由多个体积或 *凸包* 组成的新凸包分解。

> 图片已省略：Set Convex Collision

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **凸包数量（Hull Count）** | 要创建的凸包体积的最大数量。 |
| **凸包最大顶点数（Max Hull Verts）** | 任何已生成的凸包顶点最大数量。 |
| **凸包精确度（Hull Precision）** | 生成碰撞体积时要使用的体素数量。 |

### 设置LOD组

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作将该静态网格体的现有LOD替换为指定组的设置所设的新LOD。

> [!NOTE]
> 这些LOD组与在静态网格体编辑器UI中启用自动LOD生成时可设置的LOD组相同。详情请查件[设置自动LOD生成](../../../static-meshes/static-mesh-automatic-lod-generation/index.md#%E4%BD%BF%E7%94%A8lod%E7%BB%84)。

> 图片已省略：Set LOD Group

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **LOGGroupName** | LOD组的名称，该组定义此静态网格体要使用的设置。 |

### 设置LOD

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作将该静态网格体的现有LOD替换为指定降低设置所设的新LOD。

> [!NOTE]
> 这些降低设置与在静态网格体编辑器UI中启用自动LOD生成时可设置的降低设置相同。详情参见[设置自动LOD生成](../../../static-meshes/static-mesh-automatic-lod-generation/index.md#%E6%89%8B%E5%8A%A8%E5%88%9B%E5%BB%BAlod)。

> 图片已省略：Set LODs

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **自动调整屏幕大小（Auto Screen Size）** | 启用后，自动计算LOD切换时的屏幕大小。 |
| **降低设置（Reduction Settings）** | 一组降低设置，定义要创建的详细层级的数量，以及每个详细层级应包含的三角形百分比。 |

### 设置简单碰撞

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作将该静态网格体的现有碰撞替换为指定形状的简单碰撞体积。

> 图片已省略：Set Simple Collision

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **形状类型（Shape Type）** | 定义静态网格体要设置的碰撞体积的形状。 |

### 设置静态光照

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作设置各个选项，以控制静态网格体与烘焙照明的交互方式。

> 图片已省略：Setup Static Lighting

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **启用光照贴图UV生成（Enable Lightmap UV Generation）** | 启用后，操作生成静态网格体的光照贴图UV。 |
| **分辨率理想比率（Resolution Ideal Ratio）** | 静态网格几何体比例与用于静态网格体的光照贴图分辨率之间的比率。此值越低，光照贴图分辨率越高；这会提高烘焙照明的质量，但会增加内存需求。 |

### 简化网格体

对于每个与此步骤所设的 **选择依据（Select By）** 条件匹配的静态网格体，此操作将静态网格体简化为其原始三角形数量的设定百分比。此操作提供几个选项：

| 设置（Setting） | 说明（Description） |
| --- | --- |
| **目标百分比（Target Percentage）** | 原始三角形数的目标百分比 |
| **丢弃属性（Discard Attributes）** | 如果设置为True，则丢弃现有的UV和法线。 |
| **网格体边界（Mesh Boundary）** | 确定如何保留开放网格体的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |
| **组边界（Group Boundary）** | 确定如何保留多边形组的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |
| **材质边界（Material Boundary）** | 确定如何保留材质区域的边界边缘： **固定（Fixed）**：不会分离或折叠边界边缘。 **调整（Refine）**：根据需要分离和/或折叠边界边缘。 **自由（Free）**：边界边缘是分离的，但不会折叠。 |

### 焊接边缘

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体，此操作在指定的公差范围内结合顶点对。如果启用了 **仅当唯一（If Only Unique）**，则此操作仅合并成对的等效边缘。

> 图片已省略：Weld Edges

点击查看大图

### 设置碰撞复杂度

对于所有符合此 **Select By** 条件的静态网格体，该方法会将网格体的碰撞复杂度设置为你指定的数值。

> 图片已省略：Set Collision Complexity

点击查看大图

你可以从以下四个选项中选择：

- 项目默认值，由项目设置定义
- 简单和复杂（Simple and Complex）
- 使用简单碰撞作为复杂（Use Simple Collision as Complex）
- 使用复杂碰撞作为简单（Use Complex Collision as Simple）

### 平面剪切

> [!NOTE]
> 该方法要求你启用 **Dataprep几何体运算（Dataprep Geometry Operations）** 插件。

对于所有符合 **Select By** 条件的静态网格体，该方法都会裁剪或移除它的一些几何体，比如执行盒体化操作。

涉及实例化几何体时，可能会出现两种情况：

- 如果裁剪了全部几何体，则不会实例化。
- 如果裁剪了部分几何体，会为切割网格体此前的实例单独生成一个Actor。

> 图片已省略：Plane Cut

点击查看大图

此运算可以使用本地和世界坐标系：

- 对于静态网格体来说，此运算会在本地参考坐标系中裁剪。
- 对于静态网格体Actor来说，此运算会在世界坐标系中裁剪。

例如，考虑以下场景：

| 设置 | 描述 |
| --- | --- |
| **平面原点（Plane Origin）** | 定义要切割的平面的原点，采用本地坐标（静态网格体）或世界坐标系（静态网格体Actor）。 |
| **平面朝向（Plane Orientation）** | 以欧拉角定义平面旋转，用度数表示。默认要切割的平面是XY平面。 |
| **保留的边（Side(s) To Keep）** | 选择要保持切割平面的哪一面。正面、反面、或两面都保留。 |
| **两边间距（Spacing Between Halves）** | 如果你选择保留两边，此选项定义了两边的间距。 |
| **填补空隙（Fill Holes）** | 启用该选项后可以生成几何体来填充切割部分。 |
| **导出切割内容（Export Separated）** | 启用该选项后可以将切割的网格体保存为单独资产。 |

## On Object

**On Object** 操作应用于与 **Select By** 条件匹配的所有类型的场景元素。

### 删除对象

此操作删除所有与此步骤所设的 **Select By** 条件匹配的对象。

> 图片已省略：Delete Objects

点击查看大图

### 删除未使用的资产

此操作删除所有与此步骤所设的 **Select By** 条件匹配的资产，以及所有未被其他资产或Actor引用的资产。

> 图片已省略：Delete Unused Assets

点击查看大图

### 设置材质

对于所有符合此 **Select By** 条件的静态网格体、静态网格体Actor或组件，此操作将所有现有材质替换为指定材质。

> 图片已省略：Set Material

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **材质（Material）** | 要用作所有现有材质替代品的材质。 |

### 替代材质

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体或静态网格体Actor，此操作将所有匹配条件的材质替换为指定替代材质。

> 图片已省略：Substitute Material

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **材质搜索（Material Search）** | 要替换的材质的名称或部分名称。 |
| **字符串匹配（String Match）** | 定义要在 **Material Search** 字符串上执行的匹配类型。这些选项的作用与 **Select By** 块中使用字符串过滤器相同。详情参见[Visual Dataprep选择参考](../dataprep-selection-reference/index.md#selectbystring)。 |
| **材质替代（Material Substitute）** | 要作用代替品的材质，用于替代满足上述条件的材质。 |

### 按表格替代材质

对于每个与此步骤所设的 **Select By** 条件匹配的静态网格体、静态网格体Actor或组件，此操作会根据数据表资产中提供的替代品表替换材质。

> 图片已省略：Substitute Material By Table

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **材质数据表（Material Data Table）** | 确定材质及其替代材质的数据表资产。 |

**材质数据表（Material Data Table）** 设置中提供的数据表必须使用 **MaterialSubstitutionDataTable** 的行结构。此行格式需要在创建数据表资产时在 **选择行结构（Pick Row Structure）** 对话框中设置。例如：

> 图片已省略：Select the MaterialSubstitutionDataTable Row Structure

点击查看大图

在此行结构下，数据表中的每一行都会定义一种材质替换操作，会在每一个静态网格体Actor或资产上执行。

- 行中的第一个值，

  行名称（Row Name）

  ，表示替代品名称。可自由设置此值。
- 第二个值，

  搜索字符串（Search String）

  ，是要在此操作中被替换的材质的名称或部分名称。
- 第三个值，

  字符串匹配（String Match）

  ，表示要在静态网格体资产和Actor中的材质与在该行第二个值中设置的搜索字符串之间比较的字符串类型。凡

  Substitute Material

  操作接受的值均可使用：

  Exact Match

  、

  Contains

  或

  Matches Wildcard

  。这些选项的作用与

  Select By

  块中使用字符串过滤器相同。详情参见

  Visual Dataprep选择参考

  。
- 第四个值，**材质替代品（Material Replacement）**，是材质资产替代品的全名，用于替换所有与搜索字符串匹配的材质。

  > [!TIP]
  > 在 **内容浏览器** 中右键单击材质，从上下文菜单中选择 **复制引用（Copy Reference）**，即可获取此值。

例如：

> 图片已省略：Material substitution table

点击查看大图


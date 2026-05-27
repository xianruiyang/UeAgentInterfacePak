---
title: "从Maya向虚幻引擎导入内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/importing-content-into-unreal-engine-from-maya"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "面向Maya用户的虚幻引擎", "面向Maya用户的虚幻编辑器和功能概述", "从Maya向虚幻引擎导入内容"]
---

# 从Maya向虚幻引擎导入内容

> 路径：虚幻引擎5.7文档 / 入门指南 / 面向Maya用户的虚幻引擎 / 面向Maya用户的虚幻编辑器和功能概述 / 从Maya向虚幻引擎导入内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/importing-content-into-unreal-engine-from-maya

导入虚幻引擎支持的纹理、网格体、动画等内容，是一个相当直观的过程。 但为确保工作流程顺畅且资产针对虚幻引擎等实时引擎进行优化，你需要了解一些关键细节和最佳实践。

将内容导入虚幻引擎的方法有多种：

- 直接将资产**拖放**到内容浏览器文件夹中。
- 使用内容浏览器的**导入**按钮。

  ![虚幻编辑器的内容浏览器导入](../../../../../assets/images/80/8032fe0f68b3386c32dc44a9d0779e9afa6d609260c44d1796fe7c03be4aa969.jpg)
- 使用右键点击上下文菜单并选择**导入到当前文件夹（Import to Current Folder）**选项。

  ![虚幻编辑器的导入到当前文件夹](../../../../../assets/images/1d/1d5745c9dbc9ac03369a727715e37605926416c24782d11416ba7f70ac51b0ae.jpg)

当导入支持的内容时，会弹出**导入内容（Import Content）**对话框。 使用此对话框，为导入的内容类型应用一般设置或特定设置。

![虚幻编辑器的导入内容对话框](../../../../../assets/images/ee/eedfb274478c8ecfb07bc9c66cc4b73873add237e5c7e89acd045232acea983d.png)

导入内容对话框

如需详细了解向虚幻引擎导入内容的常规工作流程，请参阅[直接导入资产](../../../../understanding-the-basics/assets-and-content-packs/importing-assets-directly-into/index.md)。

## 为虚幻引擎准备内容

在准备将内容导入到虚幻引擎中时，需要留意引擎处理内容的方式。 同时，还需根据内容导出的来源进行一些考量。

对于刚开始将内容工作流程与虚幻引擎集成的Maya用户，需要注意以下事项：

- 几何体清理惯例
- 缩放和单位
- 枢轴点与场景原点
- 纹理准备
- FBX导出设置
- 命名规范

请浏览以下小节内容，了解虚幻引擎如何处理导入的内容及其相关注意事项：

### 虚幻引擎支持的文件格式

虚幻引擎支持广泛的文件格式，能够满足项目中大多数内容的导入需求。 以下是不同类型文件及用途的常见格式：

> [!NOTE]
> 部分文件类型需要在虚幻引擎中启用对应的导入器。 例如，大型协作场景使用通用场景描述（USD），毛发Groom使用Alembic文件。
>
> 这些文件类型的导入器可在主菜单的**编辑（Edit）**菜单下的**插件（Plugins）**浏览器中启用。

| 文件类型 | 文件扩展名 | 推荐用法 |
| --- | --- | --- |
| 几何体 - 静态网格体 |  |  |
| **FBX** | `.fbx` | 几何体、动画和骨骼网格体的推荐格式。 |
| **OBJ** | `.obj` | 最适合静态几何体，但不支持动画。 |
| **通用场景描述（USD）** | `.usd` | 适用于大型复杂场景及团队协作。 需要启用**USD导入器**插件。 如需详细了解如何使用，请参阅[通用场景描述](../../../../working-with-content/universal-scene-description-usd/index.md)。 |
| 几何体 - 蒙皮网格体、骨架和动画 |  |  |
| **FBX** | `.fbx` | 几何体、动画和骨骼网格体的推荐格式。 |
| **OBJ** | `.obj` | 最适合静态几何体，但不支持动画。 |
| **Alembic** | `.abc` | 适用于复杂动画缓存、毛发、布料或顶点动画。 需要启用**Alembic Groom导入器**插件。 如需更多信息，请参阅[Alembic文件导入器](../../../../working-with-content/alembic-file-importer/index.md)。 |
| **通用场景描述（USD）** | `.usd` | 适用于大型复杂场景及团队协作。 需要启用**USD导入器**插件。 如需详细了解如何使用，请参阅[通用场景描述](../../../../working-with-content/universal-scene-description-usd/index.md)。 |
| 图像 - 纹理、立方体贴图和光源配置文件 |  |  |
| **PNG** | `.png` | 此格式为无损格式，可保留透明度，且支持高压缩率。 适用于纹理表面，并且通过在RGB通道中存储不同灰度图像数据实现通道打包。 |
| **Targa** | `.tga` | 此格式为无损格式，可保留透明度，同时避免PNG可能存在的潜在问题。 此格式为未压缩格式，因此也可以加快加载和编辑速度。 |
| **JPG** | `.jpg`和`.jpeg` | 此格式为可高度压缩的有损格式。 因此，创建源资产时不应使用此格式。 |
| **Photoshop** | `.psd` | 此格式为无损未压缩格式，可保留源文件的图层和数据。 |
| **立方体贴图** | `.dds` | 这些文件为压缩或未压缩格式，包含多种布局的2D图像、3D体积纹理和立方体贴图。 它们最常用于天空盒和远景背景。 |
| **HDR图像** | `.exr` | 此格式为高动态范围（HDR）图像格式，相比PNG和JPG等其他格式，可保留更丰富的颜色数据和亮度变化。 因此，此格式非常适合天空球体和天空光源配合使用。 |
| **照明工程学会光源配置文件** | `.ies` | 它们是预定义的光源配置文件，使用在真实世界测量的数据来描述光源的分布。 如需详细了解如何使用，请参阅[IES光源配置文件](../../../../building-virtual-worlds/lighting-the-environment/features-and-properties-of-lights/using-ies-light-profiles/index.md)。 |

### Maya文件导出一般注意事项

下方列出了在Maya中设置文件以便后续导入到虚幻引擎中时的一般注意事项。

| 虚幻引擎的坐标系、缩放和度量单位 |
| --- |
| 虚幻引擎默认以厘米为度量单位。虚幻引擎的坐标系为左手坐标系，采用Z轴向上X轴为红色，向前。Y轴为绿色，向右。Z轴为蓝色，向上。如需详细了解虚幻引擎坐标系，请参阅[坐标系和空间](https://dev.epicgames.com/documentation/unreal-engine/coordinate-system-and-spaces-in-unreal-engine?application_version=5.7)。 |
| 虚幻引擎的材质、纹理和UV |
| **材质**Maya的材质必须使用虚幻引擎的材质系统重新编译。你可以在导出文件时包含纹理等媒体资产（这些资产可选择性导入），并且可以创建基础材质以应用于几何体，同时将漫反射贴图、法线贴图等映射至虚幻引擎中的对应资产。**纹理**在虚幻引擎中，建议单独创建并导入纹理资源。对于源文件，选择无损格式以确保开发过程中的质量不受损失。 例如，在选择PNG、TGA或JPG作为纹理输出格式或开发资源时，需注意以下区别。对于纹理压缩，需注意引擎会自动处理压缩过程。 但你可以使用纹理资产编辑器为单个纹理自定义压缩设置。对于Alpha通道，需要考虑在虚幻引擎中如何处理材质的透明度，以及选择何种图像类型。 例如，在某些情况下，TGA对Alpha通道的处理可能优于PNG。考虑磁盘空间与内存占用的关系。 就性能而言，磁盘空间的重要性低于内存（VRAM）占用。 引擎会对纹理进行压缩以优化内存使用。**UV**确保几何体的所有UV布局经过合理规划，以完美适配纹理和材质的应用。 例如，模块化几何体可能高度依赖平铺纹理和材质，可通过重叠UV的方式，用较低的分辨率纹理实现更高的纹素密度。 对于角色或特殊几何体等，建议对大多数部分使用独立且无重叠的UV。如果项目使用预计算光照（"烘焙"光照），几何体的UV必须完全不重叠，否则网格体上会出现可见的瑕疵。 如需详细了解光照贴图及其UV布局，请参阅[了解虚幻引擎中的光照映射](../../../../working-with-content/static-meshes/understanding-lightmapping/index.md)。虚拟纹理功能支持UDIM工作流程。 如需详细了解引擎中的UDIM支持，请参阅[虚拟纹理](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/streaming-virtual-texturing/index.md)。 |
| 蒙皮网格体、骨架和动画 |
| **蒙皮网格体**确保骨骼和关节已正确蒙皮且命名清晰。 虚幻引擎会导入骨架结构用于动画制作。需保证骨架清洁，仅有一个根关节，且关节无缩放值。**动画**动画可单独导出，或捆绑在同一个FBX文件中。导出混合形状（变形目标）时，需勾选"变形模型（Deformed Models）"以包含变形数据。虚幻引擎使用根骨骼运动，如有需要，请确保绑定和动画支持该功能。 |
| 通用项 |
| **导出清理惯例**从Maya导出时，将对象的枢轴点居中至世界原点(0,0,0)。 虚幻引擎在导入时会将此位置作为网格体的枢轴点位置。 如果几何体与世界原点偏移，会导致枢轴点与其几何体产生偏移。 这会导致在虚幻引擎中处理资产时难度增加。冻结变换并删除历史记录。确保网格体、关节和材质遵循正确的命名规范。移除未使用的节点或隐藏的对象。**细节级别（LOD）**你可以在Maya中手动设置几何体的LOD，但虚幻引擎为静态网格体和骨骼网格体提供了自动生成工具供你使用。**Nanite**Nanite支持高多边形网格体，无需进行削减处理。 它同时支持静态网格体和骨骼网格体。如需详细了解Nanite与网格体配合使用的更多信息，请参阅[Nanite虚拟几何体](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/nanite/nanite-virtualized-geometry/index.md)。 |

### Maya静态网格体导出注意事项

在Maya中将静态网格体导出为FBX格式时，在导出对话框中设置以下选项：

- 仅几何体（Geometry Only）
- 平滑组（Smoothing Groups）：已启用
- 切线和副法线（Tangents and Binormals）：已启用（Tangents and Binormals: Enabled）
- 三角剖分（Triangualate）：已启用
- 动画（Animation）：已禁用
- 嵌入媒体（Embed Media）：可选

将静态网格体作为FBX导入到虚幻引擎中时，在导入对话框中设置以下选项：

- [可选]生成光照贴图UV（Generate Lightmap UVs）：已选中

  - 如果使用烘焙的预计算光照则为理想选项。
- 导入材质（Import Materials）：已选中
- 应用碰撞（Apply Collision）

如需详细了解将静态网格体导入到虚幻引擎中，请参阅以下文档：

- [使用FBX方法导入静态网格体](../../../../working-with-content/fbx-content-pipeline/fbx-static-mesh-pipeline/importing-static-meshes-using-fbx/index.md)
- [导入静态网格体](../../../../working-with-content/static-meshes/importing-static-meshes/index.md)
- [FBX材质管线](../../../../working-with-content/fbx-content-pipeline/fbx-material-pipeline/index.md)

### Maya蒙皮网格体导出一般注意事项

在Maya中将骨骼网格体导出为FBX格式时，在导出对话框中设置以下选项：

- 导出时包含以下内容：

  - 几何体
  - 动画
  - 骨架定义
- 平滑组（Smoothing Groups）：已启用
- 切线和副法线（Tangents and Binormals）：已启用（Tangents and Binormals: Enabled）
- 三角剖分（Triangualate）：已启用
- 动画（Animation）：已启用
- 嵌入媒体（Embed Media）：可选
- 变形模型（Deformed Models）：已启用

  - 皮肤（Skins）：已启用
  - 混合形状（Blend Shapes）：已启用

将骨骼网格体作为FBX导入虚幻引擎时，在导入对话框中设置以下选项：

- 先导入不含动画的骨架FBX。

  - 启用导入网格体（Import Mesh）
  - 启用导入骨架（Import Skeleton）
- 单独导入动画，并在提示时选择其骨架。
- 导入变形目标（混合形状）。
- 选中"导入材质（ Import materials）"以在FBX导入项中包含媒体时创建基础材质。

如需详细了解如何将骨骼网格体导入到虚幻引擎中，请参阅以下文档：

- [骨骼网格体概述](../../../../working-with-content/skeletal-mesh-assets/index.md)
- [使用FBX方法导入骨骼网格体](../../../../working-with-content/fbx-content-pipeline/fbx-skeletal-mesh-pipeline/importing-skeletal-meshes-using-fbx/index.md)
- [FBX材质管线](../../../../working-with-content/fbx-content-pipeline/fbx-material-pipeline/index.md)
- [Alembic文件导入器](../../../../working-with-content/alembic-file-importer/index.md)
- [导入Groom](../../../../working-with-content/hair-rendering-and-simulation/importing-grooms-into/index.md)

## 下一页

- [面向Maya用户的虚幻引擎材质和纹理的使用](../using-materials-and-textures-in-unreal-engine-f-edc44cea/index.md) - 面向Maya用户的虚幻引擎材质系统和纹理概述。

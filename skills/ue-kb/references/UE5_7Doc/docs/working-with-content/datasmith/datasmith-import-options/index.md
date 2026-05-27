---
title: "Datasmith导入选项"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/datasmith-import-options-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith导入选项"]
---

# Datasmith导入选项

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith导入选项

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/datasmith-import-options-in-unreal-engine

本页介绍使用Datasmith从受支持的设计应用程序或数据文件格式导入文件，或从原始源重新导入Datasmith场景资源时可以配置的选项。

所有文件格式都提供了第一部分所述的 **常用导入选项（Common Import Options）**。然后，根据要导入的文件类型，你可能有特定于该格式的其他选项。详情请参阅以下各个部分。

## 常用Datasmith导入选项

当使用Datasmith导入任何类型的文件时，可以设置以下选项。

![Common Datasmith import options](../../../../assets/images/ba/ba82e82cf6b4b9f5ae2c5b400ce1e8f6f9c8b27f1fcd72c0157c6206e9aa8a2b.jpg)

| 属性 | 说明 |
| --- | --- |
| **几何体（Geometry）** | 指定Datasmith是否应该从源文件导入几何体并将其转换为项目中的静态网格体资源。 |
| **材质和纹理（Materials & Textures）** | 指定Datasmith是否应该从源文件导入材质和纹理，并将它们转换为项目中的材质和纹理资源。 |
| **光源（Lights）** | 指定Datasmith是否应该在由Datasmith场景维护的场景层级中包含来自源文件的光源，并在关卡中创建光源Actor来表示它们。 |
| **摄像机（Cameras）** | 指定Datasmith是否应该在由Datasmith场景维护的场景层级中包含来自源文件的摄像机，并在关卡中创建过场动画摄像机Actor来表示它们。 |
| **动画（Animations）** | 指定Datasmith是否应该将源场景中的对象动画导入到可以用于在虚幻引擎中播放动画的关卡序列中。 |
| 静态网格体选项 |  |
| **最小光照贴图分辨率（Min Lightmap Resolution）** | 为Datasmith生成的静态网格体资源设置最小光照贴图分辨率。该值用于确定在虚幻引擎4中生成光照贴图UV时打包的UV图表之间的填充量。良好的值通常是最大光照贴图分辨率的一半。 |
| **最大光照贴图分辨率（Max Lightmap Resolution）** | 为Datasmith生成的静态网格体资源设置光照贴图分辨率。当你在关卡中使用预计算照明（静态和固定光源）时，这些光照贴图用于存储每个实例的照明信息。 导入时不要把该值设置得太高。为你的项目将其设置到一个良好的基线水平，然后为需要更高分辨率的各个静态网格体资源增大该值，以便在构建光照时实现良好的效果。 |
| **生成光照贴图UV（Generate Lightmap UVs）** | 确定Datasmith是否应为导入的每个静态网格体资源生成光照贴图UV。此选项默认为启用，通常推荐使用，以确保能对通过Datasmith导入的所有几何体使用烘焙照明。 但是，导入时自动生成光照贴图也有缺点。导入过程需要花费时间。它在静态网格体上创建额外UV通道，因而内存会稍微变大。最后无法直接控制生成的光照贴图。 若存在以下任意情况，可禁用光照贴图生成来节约时间和内存： 已在源应用程序中创建适合光照贴图烘焙的UV贴图。 打算仅利用动态照明或光线追踪在虚幻中照亮场景。 打算在导入后用虚幻编辑器中内置的工具生成自己的光照贴图。 另参见[使用UV通道](../../static-meshes/using-uv-channels-with-static-meshes/index.md)和[理解虚幻引擎中的光照贴图](../../static-meshes/understanding-lightmapping/index.md)。 |

> [!NOTE]
> 当你重新导入一个Datasmith场景时，**包括（Include）** 部分下的复选框仅指示是否应该使用源文件中新的和修改过的内容更新每种类型的资源或Actor。如果取消选中其中一项，则不会从项目中删除该类型的现有资源或Actor。

## CAD导入选项

使用 **Datasmith** 导入器导入CAD文件（即在 **CAD** 导入器的页面中列出的所有文件）时，可以设置以下附加选项。

如果源文件包含由曲线定义的任何曲面，Datasmith将这些曲面细分成三角形网格体。这些参数控制曲面细分流程。它们控制生成的网格体与原始表面的贴合程度，因此也控制网格体的复杂性。对于所有设置，较小的值会增加三角形的数量，而较大的值会减少三角形的数量。

![CAD的几何体和曲面细分选项](../../../../assets/images/33/33300d145fcd0dd61757227c961439540d14684b9f36016037d46be080f85eab.jpg)

| 属性 | 说明 |
| --- | --- |
| 几何体和曲面细分选项 |  |
| **Geometry** | 只有当你导入Rhino文件时，该选项才会显示。它用于确定Datasmith是使用本分段中的参数将表面曲面细分成三角形网格体，还是复用由Rhino生成的并保存在Rhino文件中的三角形网格体。详情请参阅 [Rhino](../datasmith-software-interop-guides/rhino/index.md)。 |
| **弦公差（Chord Tolerance）** | 设置生成三角形中的任意点与原始曲面之间的最大距离。 |
| **最大边长（Max Edge Length）** | 设置生成三角形中任意边的最大长度。 |
| **法线公差（Normal Tolerance）** | 设置从一个表面生成的任何相邻三角形之间的最大角度。 |
| **拼接技术（Stitching Technique）** | 确定导入过程是否应该尝试合并那些看似相连但实际上作为独立对象建模的表面。 |

> [!NOTE]
> 有关这些曲面细分参数以及它们如何影响生成的静态网格体几何体的深入说明，请参阅[使用Datasmith和CAD文件格式](../datasmith-file-format-interop-guides/importing-cad-files-into-unreal-engine-using-datasmith/index.md)。

## GLTF导入选项

当你使用Datasmith GLTF导入器导入 *.glTF* 文件（[GL传输格式](https://www.khronos.org/gltf/)）时，你可以设置以下附加选项：

![glTF导入选项](../../../../assets/images/04/04ce646dbda43870879060b219d9a76a6b4047dbd269e9e038839a0fd65bedd8.png)

| 属性 | 说明 |
| --- | --- |
| **光照贴图（Lightmaps）** |  |
| **生成光照贴图UV（Generate Lightmap UVs）** | 为了在虚幻引擎中使用静态或固定照明，你的模型需要有其中没有三角形重叠的光照贴图UV。 启用该选项使Datasmith导入器自动为其创建的静态网格体资源生成这些光照贴图UV。 为了使其生效，你的模型需要至少有一个非空UV集可以着手。如果模型根本没有任何UV集，导入器将为静态网格体资源创建一个空白UV集，但是该空白UV集将不能用于将纹理或光照贴图应用到静态网格体。 如果你已经为源应用程序中的对象创建了有效的、非重叠的光照贴图，则可以不选中该选项，让Datasmith导入器跳过创建新的光照贴图UV。在这种情况下，你的静态网格体资源将使用索引最高的UV集作为其光照贴图UV。 有关更多背景信息，请参阅[使用UV通道](../../static-meshes/using-uv-channels-with-static-meshes/index.md)。 |
| **资源导入（Asset Importing）** |  |
| **导入均匀缩放（Import Uniform Scale）** | 确定导入器用于转换线性距离的比例因子。 默认值100从米（在glTF规范中指定）转换为厘米（在虚幻引擎中使用）。如果源场景使用的测量单位与米不同，请将该值调整为每单位厘米数。 |

## VRED导入选项

当你使用Datasmith **VRED** 导入器导入从VRED导出的 *.fbx* 文件时，你可以设置以下附加选项：

![VRED导入选项](../../../../assets/images/70/7017c13c9af91dcf3471aa009a46e72fada5c7c54c9efb06f4be20a5d4bbc26b.jpg)

| 属性 | 说明 |
| --- | --- |
| **处理（Processing）** |  |
| **合并节点（Merge Nodes）** | 将不用于动画、变体或其他功能的静态网格体节点的子树组合到单个静态网格体节点中。 这可以通过减少场景层级的深度和复杂性，使虚幻引擎场景管理变得更容易。但是，如果你需要手动清理导入的静态网格体，或者场景包含许多相同几何体的实例，则不推荐使用该选项。 |
| **优化复制的节点（Optimize Duplicated Nodes）** | 通过重用整个相同的子树，减少场景层级中的节点总数。 |
| **资源导入（Asset Importing）** |  |
| **导入FBX动画（Import FBX animations）** | 启用该选项可将VRED场景中的动画导入到虚幻引擎中，并使它们可用于项目中的蓝图脚本。 |
| **导入变体文件（Import variants file）** | 启用该选项可将VRED场景中的变体和变体集导入到虚幻引擎中，并使它们可用于项目中的蓝图脚本。 |
| **变体文件路径（Variants file path）** | 指定 *.var* 文件的路径，该文件包含有关VRED场景中变体的数据。默认情况下，该属性被设置为与你在导入的 *.fbx* 文件匹配的路径和文件名。如果需要从不同位置导入 *.var* 文件，只需要手动设置该路径。 |
| **导入光源文件（Import lights file）** | 如果禁用该选项，但在通用Datasmith属性中保留启用 **导入（Import）> 光源（Lights）** 设置，Datasmith在虚幻引擎中创建的光源将只包含存储在 *.fbx* 文件中的信息。 如果启用该选项，Datasmith将从 *.lights* 文件导入关于VRED场景中光源的额外信息，该文件是在导出场景时创建的。这为你的光源带来了FBX不支持的额外属性，比如IES光源描述文件，通常会带来更好的视觉效果，更接近你在VRED中的照明。 |
| **光源文件路径（Light file path）** | 指定 *.lights* 文件的路径，该文件包含有关VRED场景中变体的数据。默认情况下，该属性被设置为与你正在导入的 *.fbx* 文件相匹配的路径和文件名。如果需要从不同位置导入 *.lights* 文件，只需要手动设置该路径。 |
| **纹理文件夹（Textures folder）** | 指定Datasmith的文件夹路径，以搜索 *.fbx* 中引用的纹理文件。 |
| **调试（Debug）** |  |
| **中间序列化（Intermediate Serialization）** | 启用该选项可将从 *.fbx* 文件中读取的场景数据存储为中间格式。如果你需要频繁导入同一场景，并且FBX导入器是瓶颈，则该设置可能很有用。 |
| **给材质着色（Colorize materials）** | 启用该选项可以使用随机着色的简单材质，而不是导入材质参数，如DiffuseColor或纹理。 |
| **光照贴图（Lightmaps）** |  |
| **生成光照贴图UV（Generate Lightmap UVs）** | 为了在虚幻引擎中使用静态或固定照明，你的模型需要有其中没有三角形重叠的光照贴图UV。 启用该选项使Datasmith导入器自动为其创建的静态网格体资源生成这些光照贴图UV。 为了使其生效，你的模型需要至少有一个非空UV集可以着手。如果模型根本没有任何UV集，导入器将为静态网格体资源创建一个空白UV集，但是该空白UV集将不能用于将纹理或光照贴图应用到静态网格体。 如果你已经为源应用程序中的对象创建了有效的、非重叠的光照贴图，则可以不选中该选项，让Datasmith导入器跳过创建新的光照贴图UV。在这种情况下，你的静态网格体资源将使用索引最高的UV集作为其光照贴图UV。 有关更多背景信息，请参阅[使用UV通道](../../static-meshes/using-uv-channels-with-static-meshes/index.md)。 |

## Deltagen导入选项

当你使用Datasmith **Deltagen** 导入器导入从Deltagen导出的 *.fbx* 文件时，你可以设置以下附加选项：

![Deltagen导入选项](../../../../assets/images/0d/0d0ed5c9fbaf7840de10c1bd9ebb8d563555371c606b11b0d201ba7666a92c7e.jpg)

| 属性 | 说明 |
| --- | --- |
| **处理（Processing）** |  |
| **合并节点（Merge Nodes）** | 将不用于动画、变体或其他功能的静态网格体节点的子树组合到单个静态网格体节点中。 这可以通过减少场景层级的深度和复杂性，使虚幻引擎场景管理变得更容易。但是，如果你需要手动清理导入的静态网格体，或者场景包含许多相同几何体的实例，则不推荐使用该选项。 |
| **优化复制的节点（Optimize Duplicated Nodes）** | 通过重用整个相同的子树，减少场景层级中的节点总数。 |
| **移除不可见节点（Remove Invisble Nodes）** | 启用该设置可避免导入Deltagen场景中隐藏的任何几何体。 |
| **简化节点层级（Simplify Node Hierarchy）** | 启用该设置可使Datasmith场景层级变平。 |
| **资源导入（Asset Importing）** |  |
| **导入VAR（Import VAR）** | 启用该选项可将Deltagen场景中的变体导入到虚幻引擎中，并使它们可用于项目中的蓝图脚本。 |
| **导入POS（Import POS）** | 启用该选项可将状态数据从Deltagen场景导入到虚幻引擎中。 |
| **导入TML（Import TML）** | 启用该选项可将Deltagen场景中的动画数据导入到虚幻引擎中，并使它们可用于项目中的蓝图脚本。 |
| **纹理目录（Textures Dir）** | 指定Datasmith的文件夹路径，以搜索 *.fbx* 中引用的纹理文件。 |
| **调试（Debug）** |  |
| **中间序列化（Intermediate Serialization）** | 启用该选项可将从 *.fbx* 文件中读取的场景数据存储为中间格式。如果你需要频繁导入同一场景，并且FBX导入器是瓶颈，则该设置可能很有用。 |
| **给材质着色（Colorize materials）** | 启用该选项可以使用随机着色的简单材质，而不是导入材质参数，如DiffuseColor或纹理。 |
| **光照贴图（Lightmaps）** |  |
| **生成光照贴图UV（Generate Lightmap UVs）** | 为了在虚幻引擎中使用静态或固定照明，你的模型需要有其中没有三角形重叠的光照贴图UV。 启用该选项使Datasmith导入器自动为其创建的静态网格体资源生成这些光照贴图UV。 为了使其生效，你的模型需要至少有一个非空UV集可以着手。如果模型根本没有任何UV集，导入器将为静态网格体资源创建一个空白UV集，但是该空白UV集将不能用于将纹理或光照贴图应用到静态网格体。 如果你已经为源应用程序中的对象创建了有效的、非重叠的光照贴图，则可以不选中该选项，让Datasmith导入器跳过创建新的光照贴图UV。在这种情况下，你的静态网格体资源将使用索引最高的UV集作为其光照贴图UV。 有关更多背景信息，请参阅[使用UV通道](../../static-meshes/using-uv-channels-with-static-meshes/index.md)。 |

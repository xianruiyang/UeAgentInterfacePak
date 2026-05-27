---
title: "合并Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/merging-actors-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "合并Actor"]
---

# 合并Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / 合并Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/merging-actors-in-unreal-engine

在 **虚幻引擎** 中，可通过 **Actor合并** 操作将两个或更多 **静态网格体Actor** 结合为新的单个Actor。这样可以减少绘制调用，有助于项目优化。

## Actor合并工作流

要将两个或更多静态网格体Actor并入关卡，请按照以下步骤操作：

1. 在 **关卡视口（Level Viewport）** 或 **世界大纲视图（World Outliner）** 中，选择要合并的静态网格体Actor。
2. 在顶部菜单栏中，选择 **Actor >合并Actor（Merge Actors）。**
3. 选择要执行的合并类型：**合并（Merge）**、**简化（Simplify）**、**批量（Batch）**、或 **近似（Approximate）**。有关更多信息，请参阅"合并类型"小节。

   > [!NOTE]
   > 所选选项将使用默认或最后配置的设置自动执行合并。要配置合并选项，请在顶部菜单栏中，选择 **Actor > 合并Actor（Merge Actors） > 合并Actor设置（Merge Actor Settings）。**
4. 命名新的Actor，选择创建它的文件夹，随后点击 **保存（Save）**。

## 合并类型

虚幻引擎提供多种合并静态网格体Actor的类型，可根据合并对象进行选择：

1. 合并（Merge）
2. 简化（Simplify）
3. 批量（Batch）
4. 近似（Approximate）

以下是关于这些选项的介绍。

### 合并

在默认情况下，该方式会合并全部选中的静态网格体Actor，为每个材质创建一个网格体分段。可以指定要使用的 **LOD** 级别。

绘制调用数量等于 **材质** 数量。这种方式保留UV。

您也可以选择合并全部材质，这将为整个网格体烘焙单一材质。其结果是单一分段和单一绘制调用，但 **不** 保留UV。将针对每一分段进行遮挡剔除。

### 简化

该合并方式将全部选中的静态网格体Actor合并成一个单一网格体，它被称为 **代理网格体（Proxy Mesh）**。它使用选定每个网格体的最少细节LOD，并根据设置简化网格体形状。顶点数量也会减少。

其结果是单一绘制调用。它为整个网格体烘焙单一材质，且 **不** 保留UV。将针对整个网格体进行遮挡剔除。

有关更多信息，请参阅[代理几何体概述](../../../working-with-content/static-meshes/proxy-geometry-tool/proxy-geometry-tool-overview/index.md)页面。

### 批量

该方式将基于相同的静态网格体组件创建实例化静态网格体组件。它保留UV，且不影响遮挡剔除。

### 近似

这是 **虚幻引擎5** 的新功能，与"简化（Simplify）"合并方式相似。两者区别在于"近似（Approximate）"可以处理更复杂的源网格体（例如Nanite网格体），而"简化（Simplify）"在简化或纹理烘焙步骤中都会失败。

## 合并设置

在 **合并Actor设置（Merge Actor Settings）** 面板中，可对单个合并设置进行配置。要打开该面板，请在顶部菜单栏中，选择 **Actor >合并Actor（Merge Actors）>合并Actor设置（Merge Actor Settings）**。

### 合并

使用该合并方式时，可配置下列选项。

#### 网格体设置

**网格体设置（Mesh Settings）** 分段中的属性会作用于将被合并的静态网格体。

| **选项** | **描述** |
| --- | --- |
| **枢轴点为零（Pivot Point at Zero）** | 如果启用，合并后Actor的枢轴点将被设置于关卡原点（0,0,0）。 如果禁用，合并后Actor的枢轴点将是被选中合并的首个静态网格体Actor的枢轴点。 |
| **合并物理数据（Merge Physics Data）** | 将全部碰撞图元合并成为单一物理对象。 |
| **将顶点数据烘焙至网格体（Bake Vertex Data to Mesh）** | 将顶点数据（包括顶点颜色及法线）烘焙至合并后的静态网格体Actor。 |
| **输出UV（Output UV）** | 包含多个UV通道的数组。如果源网格体包含针对指定通道的有效UV，可选择是否将该UV通道输出至合并后的静态网格体Actor。 |
| **LOD选择类型（LOD Selection Type）** | 控制哪些LOD被添加到合并对象中。可以选择下列选项之一： **使用全部LOD级别（Use all LOD levels）**：使用全部可用的LOD级别。 **使用特定LOD级别（Use specific LOD level）**：仅显示选中的LOD级别。 **计算正确LOD级别（Calculate correct LOD level）**：为给定屏幕尺寸计算最优LOD级别。 **始终使用最低细节级别的LOD（最高LOD指数）（Always use the lowest-detail LOD (the highest LOD index)）**：使用可用的最低细节级别LOD。 |
| **包括替代物（Include Imposters）** | 如果启用，合并将包括作为源静态网格体部分的替代物LOD。 |
| **允许距离场（Allow Distance Field）** | 如果启用，将为该网格体计算距离场。如果合并后的网格体仅在远处进行渲染，可通过禁用该选项来节省内存。 |
| **生成光照贴图UV（Generate Lightmap UVs）** | 利用现有UV岛状区，为合并后的静态网格体Actor创建新的光照贴图UV布局。这一新的布局将被置于目标光照贴图UV通道。 |
| **生成启用了Nanite的网格体（Generate Nanite Enabled Mesh）** | 如果启用，将生成启用了Nanite的网格体。 |
| **目标光照贴图分辨率（Target Light Map Resolution）** | 指定新光照贴图UV的分辨率，其控制布局内各岛状区之间计算得出的距离。分辨率越高，岛状区之间空间越小。 |
| **已计算光照贴图分辨率（Computed Light Map Resolution）** | 如果启用，光照贴图分辨率将通过对源静态网格体的光照贴图分辨率进行加总来计算。 |

#### 材质设置

**材质设置（Material Settings）** 分段中包含可影响待合并的静态网格体纹理和材质的属性。

> [!NOTE]
> 如果 **网格体设置（Mesh Settings）** 分段中的 **LOD选择类型（LODSelection Type）** 被设为 **使用全部LOD级别（Use all LOD levels）**，则不能为多个静态网格体合并材质。

| **选项** | **描述** |
| --- | --- |
| **合并材质（Merge Materials）** | 如果启用，全部被合并资产的材质将组合到一个单一材质中，具有新的UV布局。 下列子设置仅在"合并材质（Merge Materials）"启用后生效。 |
| **纹理尺寸（Texture Size）** | 为最终合并的材质纹理设置水平（X）和垂直（Y）像素尺寸，或设置分辨率。 |
| **纹理尺寸类型（Texture Sizing Type）** |  |
| **法线贴图（Normal Map）** | 如果启用，则为合并后的Actor生成法线贴图。 |
| **切线贴图（Tangent Map）** | 如果启用，则为合并后的Actor生成切线贴图。 |
| **金属感贴图（Metallic Map）** | 如果启用，则为合并后的Actor生成金属感贴图。启用此选项时，**金属感常量（Metallic Constant）** 属性无效。 |
| **金属感常量（Metallic Constant）** | 为合并后的Actor材质的金属感属性设置常量。只能在未选中 **金属感贴图（Metallic Map）** 选项时启用。 |
| **粗糙度贴图（Roughness Map）** | 如果启用，则为合并后的Actor生成粗糙度贴图。启用此选项时，**粗糙度常量（Roughness Constant）** 属性无效。 |
| **粗糙度常量（Roughness Constant）** | 为合并后的Actor材质的粗糙度属性设置常量。只能在未选中 **粗糙度贴图（Roughness Map）** 选项时启用。 |
| **各向异性贴图（Anisotropy Map）** | 如果启用，则为合并后的Actor生成各向异性贴图。各向异性是一种材质属性，令其外观根据观察方向不同产生改变。启用此选项时，**各向异性常量（Anisotropy Constant）** 属性无效。 |
| **各向异性常量（Anisotropy Constant）** | 为合并后的Actor材质的各向异性属性设置常量。只能在未选中 **各向异性贴图（Anisotropy Map）** 选项时启用。 |
| **高光度贴图（Specular Map）** | 如果启用，则为合并后的Actor生成高光度贴图。启用此选项时，**高光度常量（Specular Constant）** 属性无效。 |
| **高光度常量（Specular Constant）** | 为合并后的Actor材质的高光度属性设置常量。只能在未选中 **高光度贴图（Specular Map）** 选项时启用。 |
| **自发光贴图（Emissive Map）** | 如果启用，则为合并后的Actor生成自发光贴图。 |
| **不透明度贴图（Opacity Map）** | 如果启用，则为合并后的Actor生成不透明度贴图。启用此选项时，**不透明度常量（Opacity Constant）** 属性无效。 必须同时将 **混合模式（Blend Mode）** 设置为 **半透明（Translucent）**，以使不透明度在生成的实例中正常工作。 |
| **不透明度常量（Opacity Constant）** | 为合并后的Actor材质的不透明度属性设置常量。只能在未选中 **不透明度贴图（Opacity Map）** 选项时启用。 |
| **不透明蒙版贴图（Opacity Mask Map）** | 如果启用，则为合并后的Actor生成不透明蒙版。启用此选项时，**不透明蒙版常量（Opacity Mask Constant）** 属性无效。 必须同时将 **混合模式（Blend Mode）** 设置为 **遮罩（Masked）**，以使不透明度在生成的实例中正常工作。 |
| **不透明蒙版常量（Opacity Mask Constant）** | 为合并后的Actor材质的不透明蒙版属性设置常量。只能在未选中 **不透明蒙版贴图（Opacity Mask Map）** 选项时启用。 |
| **环境光遮蔽贴图（Ambient Occlusion Map）** | 如果启用，则为合并后的Actor生成环境光遮蔽贴图。启用此选项时，**环境光遮蔽常量（Ambient Occlusion Constant）** 属性无效。 |
| **环境光遮蔽常量（Ambient Occlusion Constant）** | 为合并后的Actor材质的环境光遮蔽属性设置常量。只能在未选中 **环境光遮蔽贴图（Ambient Occlusion Map）** 选项时启用。 |
| **切线纹理尺寸（Tangent Texture Size）** | 为最终合并的Actor的切线纹理设置水平（X）和垂直（Y）像素尺寸，或设置分辨率。当 **纹理尺寸类型（Texture Sizing Type）** 被设置为 **每个属性使用手动重写的纹理尺寸（Use per property manually overridden texture sizes）** 时启用。 |
| **各向异性纹理尺寸（Anisotropy Texture Size）** | 为最终合并的Actor的各向异性纹理设置水平（X）和垂直（Y）像素尺寸，或设置分辨率。当 **纹理尺寸类型（Texture Sizing Type）** 被设置为 **每个属性使用手动重写的纹理尺寸（Use per property manually overridden texture sizes）** 时启用。 |
| **混合模式（Blend Mode）** | 设置材质颜色与背景颜色的混合方式。可从下列选项中选择： **不透明（Opaque）**：定义光既不能通过也不能穿透的表面。 **遮罩（Masked）**：定义合并后的材质是否将使用遮罩（即根据遮罩纹理，让不同的区域可见或不可见）。 **半透明（Translucent）**：用不透明度值来定义材质的可视性。 **叠加型（Additive）**：获取材质的像素，并将其与背景的像素相加。 **调制（Modulate）**：将材质的值与背景的像素相乘。 **AlphaComposite（预乘Alpha）**：与已经有预乘Alpha的纹理一起使用。 **AlphaHoldout**：通过处理材质Alpha并在其后面的对象上创建孔洞，创造出切割效果。 |
| **允许双面材质（Allow Two Sided Material）** | 如果启用，生成材质将为双面。 |
| **边距大小（Gutter Size）** | 以烘焙材质的原始纹理分辨率设置UV岛之间的空间（以像素为单位）。该空间有助于防止各岛屿之间的颜色重叠。否则，当渲染中发生纹理的下采样时，网格体上可能出现瑕疵。缩小的纹理大小被称为mipmap。 |
| **创建合并材质（Create Merged Material）** | 如果启用，则从要合并的Actor的所有材质中创建一个平面材质，以及一组新的UV。默认情况下，该材质不会应用于任何分段。 |
| **使用顶点数据烘焙材质（Use Vertex Data for Baking Material）** | 如果启用，则使用顶点颜色等顶点数据烘焙材质。如果有材质以某种方式受顶点颜色控制，那么这个功能将很有用。 |
| **使用纹理分箱（Use Texture Binning）** | 在打包最终图集纹理时，根据其重要性计算不同的输出纹理尺寸。 |
| **重用网格体光照贴图UV（Reuse Mesh Lightmap UVs）** | 如果启用，在烘焙材质时尝试重复使用源静态网格体的光照贴图UV。如果禁用，则生成一组新的光照贴图UV。 |
| **合并等效材质（Merge Equivalent Materials）** | 如果启用，将尝试合并被认为是等效的材质。 如果输出颜色由世界位置或Actor位置决定，启用该选项会导致合并后的静态网格体出现瑕疵。 |

#### 地形剔除

如果启用 **地形剔除（Landscape Culling）** 选项，虚拟引擎将在合并Actor时使用现存地形几何体剔除完全遮挡的三角形。

例如，有一个树网格体，其栽种方式使其最底下的三角形完全在地形表面以下，那么在合并后，那些被遮挡的三角形将被移除。

### 简化

使用 **简化（Simplify）** 合并方式时，可配置下列选项。

#### 代理设置

| **选项** | **描述** |
| --- | --- |
| **屏幕尺寸（Screen Size）** | 合并后静态网格体的屏幕尺寸，以像素为单位。 |
| **计算正确LOD模型（Calculate Correct LODModel）** | 如果启用，根据源网格体和过渡尺寸计算正确的LOD模型。 |
| **覆盖空间采样距离（Override Spatial Sampling Distance）** | 在转换多个静态网格体进行代理LOD合并时，覆盖空间采样距离。 高采样率的大型几何体会非常占用内存。 |
| **材质设置（Material Settings）** | 可配置与本页"合并"小节内所描述的相同的材质设置。 |
| **合并距离（Merge Distance）** | 设置网格体合并的距离。例如，这可以填补远处几何体中的门窗等间隙。 |
| **未解析的几何体颜色（Unresolved Geometry Color）** | 设置分配给无法与源几何体关联的LOD几何体的颜色（例如，比合并距离更远且被填充的门窗）。可以设置红色、绿色和蓝色（RGB）值，以及控制透明度的Alpha（A）值。 |
| **传输距离覆盖（Transfer Distance Override）** | 覆盖虚幻引擎发现简化几何体的纹理值的搜索距离。该选项在"合并距离（Merge Distance）"选项设置了大于零的手动值时很有用，它可以在凹角处生成新的几何体。 |
| **硬边角度（Hard Edge Angle）** | 设置合并的静态网格体面与面之间引入硬边的角度。 该选项会增加顶点数，并可能引入额外的UV接缝。只推荐在不使用法线贴图的情况下使用。 |
| **法线计算方式（Normal Calculation Method）** | 选择用于控制简化几何体法线计算的方法。可从下列选项中选择： **角度加权（Angle Weighted）**：使用一个顶点三角形的角度来加权该三角形的法线对该顶点法线的贡献程度。 **区域加权（Area Weighted）**：使用三角形区域来加权三角形的法线对其顶点法线的贡献程度。 **平均加权（Equal Weighted）**：平均每个共享顶点的三角形的法线。 如需有关法线计算的更多信息，请参阅[法线计算方式](../../../working-with-content/static-meshes/proxy-geometry-tool/normal-calculation-methods-with-the-proxy-geometry-tool/index.md)页面。 |
| **光照贴图分辨率（Light Map Resolution）** | 设置光照贴图的分辨率。 |
| **计算光照贴图分辨率（Compute Light Map Resolution）** | 如果启用，光照贴图分辨率将以用于合并的每个网格体的尺寸总和计算。 |
| **启用体积剔除（Enable Volume Culling）** | 如果启用，剔除体积可排除几何体。 |
| **允许邻接（Allow Adjacency）** | 如果启用，允许邻接缓冲区在合并静态网格体中进行曲面细分。 |
| **允许距离场（Allow Distance Field）** | 如果启用，将为该网格体计算距离场。如果网格体仅在远处渲染，禁用该选项可节省内存。 |
| **重用网格体光照贴图UV（Reuse Mesh Lightmap UVs）** | 如果启用，在烘焙材质时尝试重复使用源静态网格体的光照贴图UV。如果禁用，则生成一组新的光照贴图UV。 |
| **组合相同的网格体进行烘焙（Group Identical Meshes for Baking）** | 如果启用，则仅烘焙相同的网格体或网格体实例一次。这将使烘焙的纹理质量更高，并大幅减少烘焙时间。 这可能会导致与源网格体视觉效果的差异，对使用世界位置或每个实例数据的材质来说尤其如此。 |
| **创建碰撞（Create Collision）** | 如果启用，则为合并的静态网格体生成碰撞。 |
| **允许顶点颜色（Allow Vertex Colors）** | 如果启用，合并的静态网格体中将保存顶点颜色。 |
| **生成光照贴图UV（Generate Lightmap UVs）** | 利用现有UV岛状区，为合并后的静态网格体Actor创建新的光照贴图UV布局。这一新的布局将被置于目标光照贴图UV通道。 |
| **生成启用了Nanite的网格体（Generate Nanite Enabled Mesh）** | 如果启用，将生成启用了Nanite的网格体。 |

### 批量

使用 **批量（Batch）** 合并方式时，可配置下列选项。

| **选项** | **描述** |
| --- | --- |
| **要使用的Actor类（Actor Class to Use）** | 选择要用于实例化静态网格体的类。 |
| **实例替换阈值（Instance Replacement Threshold）** | 设置静态网格体在被替换为实例化版本之前所需的静态网格体实例的最小数量。 |
| **跳过有顶点颜色的网格体（Skip Meshes with Vertex Colors）** | 如果启用，使用顶点颜色的静态网格体中将不被实例化。这可以防止数据丢失，因为实例化的静态网格体不支持每个实例的顶点颜色。 |
| **使用HLOD体积域（Use HLOD Volumes）** | 如果启用，实例化的静态网格体将根据它们与HLOD体积域的交集进行拆分。 |
| **选择实例化组件类型（Select the type of Instanced Component）** | 选择要用于实例化静态网格体的实例化组件类型。 |

### 近似

使用 **近似（Approximate）** 合并方式时，可配置下列选项。

#### 网格体生成设置

| **形状设置（Shape Settings）** | **描述** |
| --- | --- |
| **输出类型（Output Type）** | 网格体近似处理的输出类型。 **网格体和材质（Mesh and Materials）**：生成网格体及其材质。 **仅网格体形状（Mesh Shape Only）**：跳过材质烘焙步骤，仅生成网格体。 |
| **近似精度（Approximation Accuracy）** | 近似精度以米为单位，它将确定（例如）体素分辨率。 |
| **尝试自动加厚（Attempt Auto Thickening）** | 如果启用，将尝试自动加厚薄型部件或平板。 |
| **目标最小厚度乘数（Target Min Thickness Multiplier）** | 应用于"近似精度（Approximation Accuracy）"的乘数，用于自动加厚。 |
| **忽略微型部件（Ignore Tiny Parts）** | 如果启用，微型部件将从网格体合并中排除，这将提高性能。 |
| **微型部件尺寸乘数（Tiny Part Size Multiplier）** | 应用于"近似精度（Approximation Accuracy）"的乘数，用于通过最大包围盒体尺寸确定微型部件阈值。 |
| **基部封顶（Base Capping）** | 可选择关闭开放网格体的底部。可选项包括： **无基部封顶（No Base Capping）** **凸包多边形（Convex Polygon）**：在网格体基部添加一个朝下的多边形。 **凸包实体（Convex Solid）**：在网格体基部添加一个朝下的多边形，并将其加厚成为封闭实体。 这些选项会对生成的网格体产生非常不同的影响，这取决于其他输入对象是否是封闭网格体，以及"卷绕"阈值。例如，一个没有封顶的大型山体扫描应该使用多边形而不是实体，但如果有许多自定义网格体部件，开放网格体会带来明显问题，因而使用实体可能更可靠。 |
| **填充间隙（Fill Gaps）** | 如果启用，拓扑结构将被扩展/收缩，以填充对象之间的小间隙。 |
| **间隙填充距离（Gap Filling Distance）** | 扩展/收缩以填充间隙的距离，以米为单位。 |
| **限制体素尺寸（Clamp Voxel Dimension）** | 沿主要方向允许的最大体素数。这是对 **近似精度（Approximation Accuracy）** 的一项限制。 |
| **卷绕阈值（Winding Threshold）** | 卷绕阈值控制开放网格体边界的洞的填充。数值越小，填充越多、越圆。 |

#### 输出网格体过滤和简化设置

| **选项** | **描述** |
| --- | --- |
| **遮挡方式（Occlusion Method）** | 可应用的隐藏几何体移除类型： **无遮挡过滤（No Occlusion Filtering）** **基于可视性的过滤（Visibility Based Filtering）** |
| **从底部遮挡（Occlude from Bottom）** | 如果启用，则 `OcclusionMethod` 计算会被配置为尝试将朝下的"底部"几何体视为被遮挡。 |
| **简化方式（Simplify Method）** | 网格体简化标准： **几何公差（Geometric Tolerance）**：将简化约束在与输入网格体的最大几何偏差内。该最大值由下面的 **几何偏差（Geometric Deviation）** 选项提供。 **固定三角形数量（Fixed Triangle Count）**：简化将力求达到目标三角形数量，该数量由下面的 **目标三角形数量（Target Tri Count）** 选项提供。 **每区三角形数（Triangles Per Area）**：简化将力求达到每平方米内三角形的特定数量，该数量由下面的 **每平米三角形数量（Triangles per M）** 选项提供。 |
| **几何偏差（Geometric Deviation）** | 允许的几何偏差，以米为单位，在"简化方式（Simplify Method）"被设置为"几何公差（Geometric Tolerance）"时使用。 |
| **目标三角形数量（Target Tri Count）** | 网格体简化的目标三角形数量，当"简化方式（Simplify Method）"被设置为"固定三角形数量（Fixed Triangle Count）"时使用。 |
| **每平米三角形数（Triangles Per M）** | 每平方米三角形的大致数量，当"简化方式（Simplify Method）"被设置为"每区三角形数（Triangles Per Area）"时使用。 |
| **地面裁剪（Ground Clipping）** | 如果需要，配置最终网格体应如何用地平面裁剪。选项包括： **无地面裁剪（No Ground Clipping）**：不执行地面裁剪。 **用Z平面丢弃（Discard With ZPlane）**：丢弃所有顶点都低于裁剪平面的三角形。 **用Z平面剪切（Cut With ZPlane）**：执行网格体剪切，消除裁剪平面下方的网格体部分。 **用Z平面剪切和填充（Cut And Fill With ZPlane）**：和上面的"用Z平面剪切（Cut With ZPlane）"选项一样，同时在执行剪切处插入新的三角形，以关闭被剪切的网格体。 对上述全部选项而言，裁剪平面的高度（Z）由 **地面裁剪Z高度（Ground Clipping ZHeight）** 选项提供。 |
| **地面裁剪Z高度（Ground Clipping ZHeight）** | 当 **地面裁剪（Ground Clipping）** 启用时，地面裁剪平面的Z高度。 |

#### 网格体法线和切线设置

| **法线设置（Normals Settings）** | **描述** |
| --- | --- |
| **估算硬法线（Estimate Hard Normals）** | 如果启用，将使用法线角度估算硬法线。 |
| **硬法线角度（Hard Normal Angle）** | 用于检测硬法线的法线角度。 |

#### 网格体UV生成设置

| **UV设置（UV Settings）** | **描述** |
| --- | --- |
| **UV生成方式（UV Generation Method）** | 网格体UV生成方式： **偏好UVAtlas（Prefer UVAtlas）**：使用微软的开源[UVAtlas](https://github.com/microsoft/UVAtlas)库。 **偏好XAtlas（Prefer XAtlas）**：使用[XAtlas](https://github.com/jpcy/xatlas)开源网格体参数化/UV解包库。 **偏好PatchBuilder（Prefer PatchBuilder）**：使用虚幻引擎自带的UV生成算法。 |
| **初始补丁数量（Initial Patch Count）** | 在计算岛状区合并之前，网格体将被分割成的初始补丁数量。仅与PatchBuilder的UV生成方式相关。 |
| **曲率对齐（Curvature Alignment）** | 控制初始补丁与网格体中折痕的对齐。仅与PatchBuilder的UV生成方式相关。 |
| **合并阈值（Merging Threshold）** | 岛状区合并的畸变/拉伸阈值。较大的值会增加允许的UV拉伸。仅与PatchBuilder的UV生成方式相关。 |
| **最大角度偏差（Max Angle Deviation）** | 如果UV岛状区的平均面法线偏差多于该值，则它们将不会被合并。仅与PatchBuilder的UV生成方式相关。 |

#### 输出静态网格体设置

| **网格体设置（Mesh Settings）** | **描述** |
| --- | --- |
| **生成启用了Nanite的网格体（Generate Nanite Enabled Mesh）** | 是否生成启用了Nanite的网格体。 |
| **支持光线追踪（Support Ray Tracing）** | 该网格体是否支持光线追踪。如果生成的网格体仅在远处进行渲染，禁用该选项可节省内存。 |
| **允许距离场（Allow Distance Field）** | 是否允许为该网格体计算距离场。如果生成的网格体仅在远处进行渲染，可通过禁用该选项来节省内存。 |
| **Nanite代理三角形百分比（Nanite Proxy Triangle Percent）** | 从Nanite网格体生成粗略代理网格体时，要减少到多少三角形百分比。 |

#### 材质烘焙设置

| **材质设置（Material Settings）** | **描述** |
| --- | --- |
| **多重采样抗锯齿（Multi Sampling AA）** | 如果该属性大于1，在每个方向上按此数量对输出烘焙纹理进行多重采样（例如，4 == 16x超级采样）。 |
| **渲染捕获分辨率（Render Capture Resolution）** | 如果该属性为零，使用材质设置（Material Settings）分辨率，否则覆盖渲染捕获分辨率。 |
| **材质设置（Material Settings）** | 可配置与本页"合并"小节内所描述的相同的材质设置。 |
| **捕获视野（Capture Field Of View）** | 执行渲染捕获时使用的视野角度。 |
| **近平面距离（Near Plane Dist）** | 执行渲染捕获时使用的近平面距离。 |

#### 调试输出设置

| **调试设置（Debug Settings）** | **描述** |
| --- | --- |
| **打印调试信息（Print Debug Messages）** | 如果启用，打印调试信息。 |
| **发出完整调试网格体（Emit Full Debug Mesh）** | 如果启用，编写用于网格体生成的完整网格体三角形集（扁平化、非实例化）。 该资产可能非常大。 |

### 替换源Actor

如果启用 **替换源Actor（Replace Source Actors）** 选项，在视口中选中的Actor会被移除，并替换为新合并的Actor。这不会从内容浏览器或项目文件夹中删除源Actor资产。

该选项对于本页描述的所有合并方法通用。

---
title: "交换导入参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/interchange-import-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "交换框架", "交换开发指南", "交换导入参考"]
---

# 交换导入参考

> 路径：虚幻引擎5.7文档 / 管理内容 / 交换框架 / 交换开发指南 / 交换导入参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/interchange-import-reference-in-unreal-engine

当你将某个文件类型受支持的文件导入虚幻引擎中时， **交换管线配置（Interchange Pipeline Configuration）** 窗口会打开。

![Interchange Pipeline Configuration Window](../../../../../assets/images/23/237b866e50aac7a1eccd429461c3ccb323918997b1e1ff2b1daac174a668f883.png)

交换管线配置窗口

窗口中显示的选项取决于两个因素：

- 导入文件的文件格式。
- 你选择用于处理导入内容的交换管线堆栈。

> [!NOTE]
> 关于使用交换执行的导入过程的更多信息，请参阅[使用交换导入资产](../../importing-assets-using-interchange/index.md)。

## 常见

| **选项** | **说明** |
| --- | --- |
| **使用资产的源名称（Use Source Name for Asset）** | 满足以下条件时，仿照源名称命名导入的资产： 此选项已被设置为true。 **资产名称（Asset Name）** 字段为空白。 只有一个源。 只有一个资产。 |
| **资产名称（Asset Name）** | 满足以下条件时，使用此字符串命名导入的资产： 只有一个源。 只有一个资产。 |
| **偏移平移（Offset Translation）** | 对指定X、Y、Z方向上的网格体和动画应用平移偏移。 |
| **偏移旋转（Offset Rotation）** | 对指定X（翻滚角）、Y（俯仰角）、Z（偏航角）方向上的网格体和动画应用旋转偏移。 |
| **偏移均匀缩放（Offset Uniform Scale）** | 对网格体和动画应用均匀缩放偏移。 |

## 常见网格体

| **选项** | **说明** |
| --- | --- |
| **强制所有网格体作为类型（Force All Mesh as Type）** | 将导入的网格体转换为指定类型。 下拉菜单包含以下选项： **无（None）** （默认） [静态网格体](../../../static-meshes/index.md) [骨骼网格体](../../../skeletal-mesh-assets/index.md) |
| **导入LOD（Import Lods）** | 使用源中找到的已导入网格体导入LOD。需要你在所选管线中将 **烘焙网格体（Bake Meshes）** 选项设置为true。该选项默认为true并隐藏。 |
| **顶点颜色导入选项（Vertex Color Import Option）** | 指定在导入时如何处理顶点颜色。 下拉菜单包含以下选项： **替换（Replace）** ：使用导入的源中的顶点颜色。 **忽略（Ignore）** ：忽略导入的源中的顶点颜色。如果重新导入，会保留现有网格体顶点颜色。 **重载（Override）** ：使用指定颜色重载所有顶点颜色。 |
| **顶点重载颜色（Vertex Override Color）** | 定义当 **顶点颜色导入选项（Vertex Color Import Option）** 被设置为 **重载（Override）** 时使用的顶点颜色。 |
| **编译（Build）** | 定义在导入过程期间如何处理法线、切线和UV。 此菜单包含以下选项： **重新计算法线（Recompute Normals）** ：忽略并重新计算导入的网格体的法线。 **重新计算切线（Recompute Tangents）** ：忽略并重新计算导入的网格体的切线。 **使用MikkTSpace（Use MikkTSpace）** ：使用MikkTSpace标准重新计算切线。 **计算加权法线（Compute Weighted Normals）** ：使用三角形的表面积和内角角度之间的比率计算法线。 **使用高精度切线基础（Use High Precision Tangent Basis）** ：使用16位精度或8位精度存储切线。 **使用全精度UV（Use Full Precision UVs）** ：使用浮点精度存储UV。 **使用向后兼容的F16Trunc UV（Use Backwards Compatible F16Trunc UVs）** ：强制使用向后兼容的F16转换来截断旧版网格体。 **删除退化（Remove Degenerates）** ：从导入的网格体删除退化三角形。 |

## 常见骨骼网格体和动画

| **选项** | **说明** |
| --- | --- |
| **仅导入动画（Import Only Animations）** | 仅导入动画。需要有效的已定义骨架。 |
| **骨架（Skeleton）** | 定义要用于导入的动画的骨架。将此项留空会创建新骨架。对于 **仅导入动画（Import Only Animations）** 而言，此项必填。 |
| **导入骨骼层级中的网格体（Import Meshes in Bone Hierarchy）** | 导入骨骼层级中嵌套的网格体，而不是将其转换为骨骼。 |
| **使用T0A引用姿势（Use T0As Ref Pose）** | 使用导入的动画的帧0作为引用姿势。 |

## 静态网格体

| **选项** | **说明** |
| --- | --- |
| **将使用变形目标的静态网格体转换为骨骼网格体（Convert Statics with Morph Targets to Skeletals）** | 将使用变形目标的静态网格体转换为骨骼网格体。 |
| **导入静态网格体（Import Static Meshes）** | 导入源中找到的静态网格体资产。 |
| **组合静态网格体（Combine Static Meshes）** | 将导入的静态网格体组合为单个静态网格体。 |
| **LOD组（Lod Groups）** | 定义要将导入的静态网格体分配到哪个[LOD组](../../../static-meshes/creating-and-using-lods/index.md)。 下拉菜单包含以下选项： **装饰（Deco）** **植被（Foliage）** **高细节（High Detail）** **大道具（Large Prop）** **关卡架构（Level Architecture）** **无（None）** **小道具（Small Prop）** **全景（Vista）** |
| **碰撞（Collision）** | 定义在导入期间如何处理自定义碰撞网格体。 此菜单包含以下选项： **导入碰撞（Import Collision）** ：导入自定义碰撞。如果不存在自定义碰撞，将创建一个。 **根据网格体名称导入碰撞（Import Collision According to Mesh Name）** ：将带有特定前缀的网格体导入为碰撞网格体。支持以下前缀： **UBX_** ：盒体碰撞 **UCP_** ：胶囊体碰撞 **USP_** ：球体碰撞 **UCX_** ：凸包碰撞 **每个UCX一个凸包外壳（One Convex Hull Per UCX）** ：将凸包碰撞导入为单个外壳。如果为false，虚幻引擎会分解碰撞并为每个片段创建一个外壳。 |
| **编译（Build）** | 定义在导入过程期间如何处理[Nanite](https://dev.epicgames.com/documentation/404)、光照贴图和[距离场(building-virtual-worlds/lighting-and-shadows/mesh-distance-fields)。 此菜单包含以下选项： **构建Nanite（Build Nanite）** ：在运行时为导入的网格体开启/关闭[Nanite](https://dev.epicgames.com/documentation/404)渲染。 **构建反向索引缓冲区（Build Reverse Index Buffer）** ：为导入的静态网格体构建反向索引缓冲区。 **生成光照贴图UV（Generate Lightmap UVs）** ：为导入的静态网格体生成光照贴图UV。 **双面距离场生成（Two-Sided Distance Field Generation）** ： 生成距离场，同时将每个三角形视为正面。这可防止由于打开了网格体而废弃距离场，但会降低距离场环境光遮蔽质量。 **启用物理材质遮罩（Enable Physical Material Mask）** ：为导入的网格体开启/关闭物理材质遮罩。 **最低光照贴图分辨率（Min Lightmap Resolution）** ：为Lightmass生成的烘焙光源和阴影纹理定义默认纹理分辨率。更多信息请参阅[了解虚幻引擎中的光照贴图](../../../static-meshes/understanding-lightmapping/index.md)。 **源光照贴图索引（Source Lightmap Index）** ：定义在生成光照贴图时要使用的源UV通道。 **目标光照贴图索引（Destination Lightmap Index）** ：定义新生成的光照贴图存储到的UV通道索引。 **构建比例（Build Scale）** ：定义在构建导入的网格体时应用的局部比例。 **距离场分辨率比例（Distance Field Resolution Scale）** ：为导入的网格体定义应用于[距离场](../../../../building-virtual-worlds/lighting-the-environment/mesh-distance-fields/index.md)体积纹理的比例值。默认值是1.0，即假定网格体在世界中没有缩放。 **距离场替代网格体（Distance Field Replacement Mesh）** ：定义在使用[距离场](../../../../building-virtual-worlds/lighting-the-environment/mesh-distance-fields/index.md)计算环境光遮蔽和投影时要使用的静态网格体。若未定义，将使用导入的网格体的LOD 0。 **最大Lumen网格体发片数量（Max Lumen Mesh Cards）** ：定义为该网格体生成的Lumen网格体发片的最大数量。 |

## 骨骼网格体

| **选项** | **说明** |
| --- | --- |
| **导入骨骼网格体（Import Skeletal Meshes）** | 导入源中找到的骨骼网格体资产。 |
| **导入内容类型（Import Content Type）** | 定义骨骼网格体资产的导入过程是部分还是全部。 下拉菜单包含以下选项： **几何体和蒙皮权重（Geometry and Skinning Weights）** ：导入所有骨骼网格体内容。 **仅几何体（Geometry Only）** ：仅导入骨骼网格体几何体。 **仅蒙皮权重（Skinning Weights Only）** ：仅导入骨骼网格体蒙皮权重。 |
| **组合骨骼网格体（Combine Skeletal Meshes）** | 将导入的骨骼网格体组合为单个骨骼网格体。这仍会为每个骨骼根关节创建一个单独的骨骼网格体。 |
| **导入变形目标（Import Morph Targets）** | 导入源中找到的变形目标。 |
| **更新骨架引用姿势（Update Skeleton Reference Pose）** | 在导入时更新骨架的引用姿势。 |
| **创建物理资产（Create Physics Asset）** | 如果源没有物理资产，创建一个新的物理资产。 |
| **物理资产（Physics Asset）** | 定义在 **创建物理资产（Create Physics Asset）** 为false时使用的物理资产。 |
| **编译（Build）** | 定义在导入过程期间如何处理蒙皮权重、动画阈值和变形目标。 此菜单包含以下选项： **使用高精度蒙皮权重（Use High Precision Skin Weights）** ：将16位精度而不是8位用于蒙皮权重。 **阈值位置（Threshold Position）** ：定义在确定两个顶点位置是否相等时要使用的距离阈值。 **阈值切线法线（Threshold Tangent Normal）** ：定义在确定两条法线、切线或副法线是否相等时要使用的距离阈值。 **阈值UV（Threshold UV）** ：定义在确定两个UV是否相等时要使用的距离阈值。 **变形阈值位置（Morph Threshold Position）** ：定义在计算变形目标更改的情况下确定顶点位置是否相等时要使用的距离阈值。 **骨骼影响限制（Bone Influence Limit）** ：定义导入的网格体中每个顶点可以使用的骨骼影响的最大数量。如果设置得比项目设置中的值更高，这将不起作用。如果设置为0，导入内容将使用项目设置中设置的 **默认骨骼影响限制（Default Bone Influence Limit）** 的值。 |

## 动画

| **选项** | **说明** |
| --- | --- |
| **导入动画（Import Animations）** | 导入源中找到的所有动画。 |
| **导入骨骼轨道（Import Bone Tracks）** | 导入源中找到的所有骨骼变换轨道。 |
| **动画长度（Animation Length）** | 定义要导入的动画时间范围。 下拉菜单包含以下选项： **源时间轴（Source Timeline）** ：基于源中找到的时间轴定义来导入帧范围。 **动画时间（Animation Time）** ：导入包含动画的帧范围。 **设置范围（Set Range）** ：导入 **帧导入范围（Frame Import Range）** 定义的帧范围。 |
| **帧导入范围（Frame Import Range）** | 定义在为 **动画长度（Animation Length）** 选择 **设置范围（Set Range）** 时要使用的帧范围。 |
| **使用30Hz烘焙骨骼动画（Use 30Hz to Bake Bone Animation）** | 以30帧/秒对所有动画曲线取样。 |
| **自定义骨骼动画取样率（Custom Bone Animation Sample Rate）** | 按指定速率对源中的所有[FBX动画数据](../../../fbx-content-pipeline/fbx-animation-pipeline/index.md)取样。如果设置为0，则自动查找最佳速率。 |
| **对齐到最近帧边界（Snap to Closest Frame Boundary）** | 使用指定 **动画取样率（Animation Sample Rate）** 将动画对齐到最近帧边界。 |
| **将属性导入为曲线或动画属性（Import Attributes as Curves or Animation Attribute）** | 导入节点属性作为动画曲线或动画属性。 |
| **将曲线元数据添加到骨架（Add Curve Metadata to Skeleton）** | 自动将曲线元数据添加到动画的骨架。如果为false，曲线元数据会被添加到变形目标的骨架，但不会为一般动画曲线创建元数据。 |
| **设置材质曲线类型（Set Material Curve Type）** | 为所有存在的自定义属性设置材质曲线类型。 |
| **材质曲线后缀（Material Curve Suffixes）** | 使用此数组中定义的后缀为自定义属性设置材质曲线类型。在 **设置材质曲线类型（Set Material Curve Type）** 为true时不适用。 |
| **删除冗余关键帧（Remove Redundant Keys）** | 将自定义动画属性作为曲线导入时，从这些属性删除冗余关键帧。 |
| **不导入只有0值的曲线（Do not import curves with only 0 values）** | 导入时跳过值为0的动画曲线或变形目标曲线。 |
| **删除现有动画属性（Delete existing Animation Attributes）** | 在重新导入时删除之前导入为动画属性的属性。 |
| **删除现有动画曲线（Delete Existing Animation Curves）** | 在重新导入时删除之前导入为动画曲线的属性。 |
| **删除现有变形目标曲线（Delete Existing Morph Target Curves）** | 在重新导入时删除之前的变形目标曲线。 |

## 材质

| **选项** | **说明** |
| --- | --- |
| **导入材质（Import Materials）** | 导入源中找到的所有材质资产。 |
| **材质导入（Material Import）** | 定义在导入材质资产时创建的内容。 下拉菜单包含以下选项： **导入为材质（Import as Material）** ：将源中的材质资产导入为单独的材质。 **导入为材质实例（Import as Material Instance）** ：将源中的材质资产导入为材质实例。 |
| **父材质（Parent Material）** | 定义在将材质导入为材质实例时要使用的父材质。如果你选择"无（None）"，导入过程中将自动选择一个。 虚幻引擎从以下着色器模型中选择： **Lambert和Phong** ： `PhongSurfaceMaterial` **无光照** ： `UnlitMaterial` **金属感/粗糙度PBR** ： `ClearCoatMaterial_MR` `PBRSurfaceMaterial_MR` `SheenMaterial_MR` `ThinTranslucentMaterial_MR` **高光度/光泽度PBR** ： `PBRSurfaceMaterial_SG` `ClearCoatMaterial_SG` `SheenMaterial_SG` `SubsurfaceMaterial_SG` `ThinTranslucentMaterial_SG` 这些材质位于 `/Interchange/Materials` 文件夹中。 |

## 纹理

| **选项** | **说明** |
| --- | --- |
| **导入纹理（Import Textures）** | 导入源中找到的所有纹理资产。 |
| **检测法线贴图纹理（Detect Normal Map Texture）** | 检查导入的纹理是否为法线贴图。如果是，会自动调整 **SRG** 、 **压缩设置（Compression Settings）** 和 **LOD组（LOD Group）** 设置。 |
| **翻转法线贴图绿色通道（Flip Normal Map Green Channel）** | 反转导入的法线贴图上的绿色通道。 |
| **导入UDIM（Import UDIMs）** | 检测纹理是否使用UDIM模式，并根据需要将其导入为UDIM。 |
| **要导入为经度纬度立方体贴图的文件扩展名（File Extensions to Import as Long Lat Cubemap）** | 定义哪些文件类型需要被导入为经度纬度立方体贴图。 |
| **高级（Advanced）** | 定义在导入过程中如何处理压缩和纹理大小。 此菜单包含以下选项： **偏好压缩源数据（Prefer Compressed Source Data）** ：让平移器尽可能提供压缩后的源数据。这会生成更小的资产文件，但一些运算可能会变慢。 **允许非2的幂（Allow Non Power of Two）** ：定义是否导入分辨率非2的幂的纹理。 |

## 使用"导入关卡中"导入

你还可以使用 **文件（File）> 导入关卡中（Import Into Level）** 选项导入资产。

![Interchange Import Into Level Window](../../../../../assets/images/46/460ed171c46a26c4ccb089f422623ebf8f1afa8d805b657a10cde8556e5c9541.png)

交换导入关卡中窗口

"导入关卡中"适用于以下文件格式：

- FBX
- glTF
- GLB
- MaterialX

使用此方法导入时一些选项不可用。以下选项可用：

### 常见

- 偏移平移
- 偏移旋转
- 偏移均匀比例

### 常见网格体

- 导入LOD
- 顶点颜色导入选项
- 顶点颜色重载
- 构建

  - 重新计算切线
  - 使用MikkTSpace
  - 计算加权法线
  - 使用高精度切线基础
  - 使全精度UV
  - 使用向后兼容的F16Trunc UV
  - 删除退化

### 常见骨骼网格体和动画

- 导入骨骼层级中的网格体
- 使用T0A引用姿势

### 静态网格体

- 将使用变形目标的静态网格体转换为骨骼网格体
- 导入静态网格体
- LOD组
- 碰撞

  - 导入碰撞
  - 根据网格体名称导入碰撞
  - 每个UCX一个凸包外壳
- 构建

  - 构建Nanite
  - 构建反向索引缓冲区
  - 生成光照贴图UV
  - 双面距离场生成
  - 启用物理材质遮罩
  - 最低光照贴图分辨率
  - 源光照贴图索引
  - 目标光照贴图索引
  - 构建比例
  - 距离场分辨率比例
  - 距离场替代网格体
  - 最大Lumen网格体发片数量

### 骨骼网格体

- 导入骨骼网格体
- 导入内容类型
- 导入变形目标
- 更新骨架引用姿势
- 创建物理资产
- 构建

  - 使用高精度蒙皮权重
  - 阈值位置
  - 阈值切线法线
  - 阈值UV
  - 变形阈值位置
  - 骨骼影响限制

### 动画

- 导入动画
- 导入骨骼轨道
- 动画长度
- 帧导入范围
- 使用30Hz烘焙骨骼动画
- 自定义骨骼动画取样率
- 对齐到最近帧边界
- 将属性导入为曲线或动画属性
- 将曲线元数据添加到骨架
- 设置材质曲线类型
- 材质曲线后缀
- 删除冗余
- 不导入只有0值的曲线
- 删除现有动画属性
- 删除现有动画曲线
- 删除现有变形目标曲线

### 材质

- 父材质

### 纹理

- 导入纹理
- 检测法线贴图纹理
- 翻转法线贴图绿色通道
- 导入UDIM
- 要导入为经度纬度立方体贴图的文件扩展名
- 高级

  - 偏好压缩后的源数据
  - 允许非2的幂

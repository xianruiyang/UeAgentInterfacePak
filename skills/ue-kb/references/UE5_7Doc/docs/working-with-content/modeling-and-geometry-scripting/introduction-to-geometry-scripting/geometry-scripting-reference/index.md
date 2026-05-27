---
title: "几何体脚本参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/geometry-scripting-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "几何体脚本编写简介", "几何体脚本参考"]
---

# 几何体脚本参考

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 几何体脚本编写简介 / 几何体脚本参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/geometry-scripting-reference-in-unreal-engine

几何体脚本库（Geometry Scripting Library）包含非常广泛的功能，从低级别的网格体构造和查询（例如逐三角形构建网格体或计算其顶点数量），到高级别运算，如网格体布尔运算和相交测试，不一而足。

如需详细了解如何使用几何体脚本库，请参阅[几何体脚本用户指南](../geometry-scripting-users-guide/index.md)。

> [!NOTE]
> 大部分函数在编辑器中以及在运行时可用。 但是，一些函数仅在编辑器中可用，下面的表中已注明。

如需详细了解各类函数，请参阅[蓝图](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/BlueprintAPI/GeometryScript)和[Python](https://docs.unrealengine.com/en-US/PythonAPI/)API。

## 资产和组件读写

这些函数用于读写动态网格体实例，例如读写现有或新的资产或组件。

| 节点名称 | 说明 |
| --- | --- |
| **Copy Mesh From Static Mesh** | 从静态网格体资产提取动态网格体资产。 |
| **Copy Mesh To Static Mesh** | 使用从动态网格体资产转换的新几何体更新静态网格体资产。 |
| **Copy Mesh From Component** | 从世界或本地空间中受支持的组件类型提取动态网格体Actor。 |
| **Create New Volume From Mesh** | 从动态网格体Actor创建新的体积Actor，例如阻挡体积。此节点仅适用于编辑器。 |
| **Create New Static Mesh Asset From Mesh** | 从动态网格体Actor创建新的静态网格体资产。此节点仅适用于编辑器。 |
| **Set Static Mesh Collision From Mesh** | 基于输入网格体为静态网格体资产生成简单碰撞形状。 |
| **Set Dynamic Mesh Collision From Mesh** | 基于输入网格体为动态网格体组件生成简单碰撞形状。 |
| **Copy Collision Meshes From Object** | 从源对象提取碰撞几何体，并随目标动态网格体中存储的网格体一起复制它。对于简单碰撞，源对象可以是静态网格体资产或任意图元组件。对于复杂碰撞，源对象可以是静态网格体资产、静态网格体组件或动态网格体组件。 |
| **Reset Dynamic Mesh Collision** | 从动态网格体组件清除简单碰撞。 |
| **Copy Mesh From Skeletal Mesh** | 将骨骼网格体复制到目标动态网格体。 |
| **Copy Mesh To Skeletal Mesh** | 将给定动态网格体复制到骨骼网格体。 |
| **Create New Skeletal Mesh Asset From Mesh** | 从目标网格体创建新的骨骼网格体资产。此节点仅适用于编辑器。 |
| **Check Static Mesh Has Available LOD** | 检查静态网格体资产是否拥有可用的RequestedLOD。 也就是给定的LODType和LODIndex的Copy Mesh From Static Mesh操作能否成功。 |
| **Get Num Static Mesh LODs Of Type** | 确定一个静态网格体资产内的请求LODType的可用LOD数量。 |
| **Determine Mesh Occlusion** | 确定从外部查看时，场景中那些网格体会完全被其他网格体隐藏。 |
| **Get LOD Material List From Skeletal Mesh** | 从骨骼网格体资产的指定LOD中提取材质列表及相应的材质索引。 |
| **Get Material List From Static Mesh** | 从静态网格体资产中获取资产材质。 |
| **Get Material List From Skeletal Mesh** | 从骨骼网格体资产中获取资产材质。 |
| **Convert Material Map To Material List** | 将材质贴图转换成材质列表和插槽名称列表。 列表会保留空（Null）材质，且列表中的元素数量与贴图保持一致。 |
| **Convert Material List To Material Map** | 将材质列表和插槽名称列表转换为材质贴图，其格式由CreateNewSkeletalMeshAssetFromMesh决定。 |
| **Copy Morph Target To Skeletal Mesh** | 将一个动态网格体变形目标添加到骨骼网格体资产。 |
| **Copy Skin Weight Profile To Skeletal Mesh** | 将一个动态网格体蒙皮权重配置添加到骨骼网格体资产。 |

## 图元生成

这些函数用于生成图元网格体并附加到输入动态网格体

| 节点名称 | 说明 |
| --- | --- |
| **Append Box** | 将3D盒体附加到指定的动态网格体。 |
| **Append Sphere Lat Long** | 将使用纬度/经度拓扑进行三角剖分的3D球体附加到动态网格体。 |
| **Append Sphere Box** | 将使用盒体拓扑进行三角剖分的3D球体附加到动态网格体。 |
| **Append Capsule** | 将3D胶囊体附加到动态网格体。 |
| **Append Cylinder** | 将3D圆柱体（带可选的端盖）附加到动态网格体。 |
| **Append Cone** | 将3D椎体附加到动态网格体。 |
| **Append Torus** | 将3D圆环面或部分圆环面附加到动态网格体。 |
| **Append Rectangle XY** | 将平面矩形附加到动态网格体。 |
| **Append Round Rectangle XY** | 将带圆角的平面矩形（RoundRect）附加到动态网格体。 |
| **Append Disc** | 将平面圆盘形附加到动态网格体。 |
| **Append Triangulated Polygon** | 将平面2D多边形的[德劳内三角剖分](https://en.wikipedia.org/wiki/Delaunay_triangulation)附加到动态网格体。 |
| **Append Revolve Polygon** | 将2D多边形的旋转表面（完全旋转或可选限制的部分旋转）附加到动态网格体。 |
| **Append Spiral Revolve Polygon** | 沿螺旋路径旋转2D多边形，就像用于创建垂直螺旋的那种路径。 |
| **Append Revolve Path** | 旋转开放式2D路径，带可选的顶部和底部端盖。 |
| **Append Simple Extrude Polygon** | 使用所选动态网格体沿垂直路径挤压2D多边形。 |
| **Append Simple Swept Polygon** | 使用所选动态网格体沿任意3D路径扫描2D多边形。 |
| **Append Linear Stairs** | 使用所选动态网格体附加线性楼梯。 |
| **Append Curved Stairs** | 使用所选动态网格体附加环形楼梯。 |
| **Append Mesh Transformed** | 将每次变换应用于附加网格体，然后将其几何体添加到目标网格体。 |
| **Append Sweep Polygon** | 沿扫描路径扫描并旋转2D多边形，创建附加到提供的网格体的3D网格体。 |
| **Append Voronoi Diagram 2D** | 从提供的Voronoi站点生成三角剖分的Voronoi单元格，识别带有多边形组的每一项，并附加到提供的网格体。 |
| **Append Sweep Polyline** | 沿指定为一组FTransform的扫描路径扫描给定的2D多线段顶点。 如果2D顶点为(U,V)，则在FTransform的坐标空间中，X指向路径方向，Y向右(U)，Z向上(V)。 |
| **Append Bounding Box** | 使用取自输入盒体的维度和原点，将3D盒体添加到目标网格体。 |
| **Append Delaunay Triangulation 2D** | 生成提供的顶点的德洛内三角剖分，并将其附加到目标网格体。 |
| **Append Polygon List Triangulation** | 生成提供的多边形列表的德洛内三角剖分，并将其附加到目标网格体。 |
| **Append Triangulated Polygon 3D** | 将一个三角剖分多边形（在3D中指定顶点的多边形）附加到目标网格体。 使用基于耳切法的三角剖分方法。 输出的顶点将始终与输入顶点1:1对应。 多边形端点不会重复。 |
| **Append Simple Collision Shapes** | 将简单碰撞形状附加到目标网格体，使用三角剖分选项（Triangulation Option）指定的方法进行三角剖分。 |
| **Append Sphere Covering** | 将球体覆盖范围（Sphere Covering）中的球体附加到目标网格体。 |
| **Append Box With Collision** | 将一个3D盒体附加到目标网格体并创建匹配的简单碰撞。 |
| **Append Bounding Box With Collision** | 将一个3D盒体附加到目标网格体，其尺寸和原点取自输入盒体。 同时创建相匹配的简单碰撞。 |
| **Append Sphere Lat Long With Collision** | 将一个使用经度/纬度拓扑进行三角剖分的3D球体附加到目标网格体。 同时创建相匹配的简单碰撞。 |
| **Append Sphere Box With Collision** | 将一个使用盒状拓扑进行三角剖分的3D球体附加到目标网格体。 同时创建相匹配的简单碰撞。 |
| **Append Capsule With Collision** | 将一个3D胶囊体附加到目标网格体。 同时创建相匹配的简单碰撞。 |
| **Create Constrained Edges Loop** | 应与Append Delaunay Triangulation 2D配合使用。 通过连续的顶点创建环形边缘。 例如，环(3,0) 构成了边缘(2,0), (0,1)和(1,2)。 |
| **Create Constrained Edges Chain** | 应与Append Delaunay Triangulation 2D配合使用。 通过连续的顶点创建链式边缘。 例如，链(3,0) 构成了边缘(0,1)和(1,2)。 |

## 变换和变形

这些函数用于操控动态网格体的 **顶点位置（Vertex Positions）** 。 它们不会改变网格体拓扑或连接。

| 节点名称 | 说明 |
| --- | --- |
| **Translate Mesh** | 将平移应用于网格体的顶点。 |
| **Scale Mesh** | 将缩放变换应用于网格体的顶点。 |
| **Transform Mesh** | 将任意FTransform应用于网格体的顶点。 |
| **Apply Bend Warp To Mesh** | 围绕变换定义的轴应用弯曲扭曲。 |
| **Apply Twist Warp To Mesh** | 围绕变换定义的轴应用扭转扭曲。 |
| **Apply Flare Warp To Mesh** | 应用迸发/膨胀扭曲。 |
| **Apply Math Warp To Mesh** | 应用各种基于简单数学函数的扭曲，目前为带有任意方向的1D或2D正弦波。 |
| **Apply Perlin Noise To Mesh** | 将3D Perlin噪点置换应用于整个网格体或可选的选择所定义的网格体区域。 |
| **Apply Iterative Smoothing To Mesh** | 将多次网格体平滑迭代应用于整个网格体或可选的选择所定义的子集 |
| **Apply Displace From Texture Map** | 基于Texture2D和UV信道将置换应用于动态网格体。 |
| **Rotate Mesh** | 相对于指定原点旋转网格体。 |
| **Translate Pivot To Location** | 设置网格体的枢轴点位置。 由于网格体对象的枢轴点始终是位于(0,0,0)的点，因此该函数只是将网格体平移-PivotLocation。 |
| **Make Transform From Z Axis** | 根据`bTangentIsX`参数在给定位置创建一个变换，以ZAxis向量作为变换的Z轴，且X轴或Y轴朝向切线向量。 |
| **Make Transform From Axes** | 根据`bTangentISX`参数在给定位置创建一个变换，以ZAxis向量作为变换的Z轴，且X轴或Y轴面向切线向量。 |
| **Get Transform Axis Vector** | 获取变换的X、Y和Z轴方向的向量。 |
| **Get Transform Axis Ray** | 获取变换位置处与变换的X、Y和Z轴方向对齐的光线。 |
| **Get Transform Axis Plane** | 获取变换位置处的平面；该平面的法线与变换的X、Y和Z轴方向对齐。 |

## 复合和分解

这些函数用于将网格体组合在一起或分割开。

| 节点名称 | 说明 |
| --- | --- |
| **Copy Mesh To Mesh** | 在不同动态网格体之间复制网格体。 |
| **Get Sub Mesh From Mesh** | 在不同动态网格体之间复制三角形列表。 |
| **Split Mesh By Components** | 将网格体分成多个部分，每个连接的组件对应一个部分，从动态网格体池绘制。 |
| **Split Mesh By Material IDs** | 将网格体分成多个部分，每个材质ID对应一个部分，从动态网格体池绘制。 |
| **Append Mesh** | 将几何体从一个网格体附加到另一个网格体，带可选的变换。 |
| **Append Mesh Repeated** | 基于应重复的次数将几何体从一个网格体附加到另一个网格体，每次累积变换。 该运算很适合用于创建图案。 |
| **Split Mesh By Vertex Overlap** | 为目标网格体中每个顶点相连或顶点重叠的部分创建新的网格体。 |
| **Sort Meshes By Volume** | 按体积对网格体进行排序。对于具有开放边界的网格体，体积是根据平均顶点位置计算的。 |
| **Sort Meshes By Area** | 按表面面积对网格体进行排序。 |
| **Sort Meshes By Bounds Volume** | 按轴对齐的边界框体积对网格体进行排序。 |
| **Sort Meshes By Custom Values** | 根据第二个数组中的值对网格进行排序，该数组的长度必须与网格体数组的长度相同。例如，如果值数组为 [3, 2, 1]，且按升序排列，则网格体数组将会反转。 |

## 网格体建模

这些函数提供标准高级别建模运算，但通常会调用建模模式中类似名称的工具会调用的低级别网格体处理代码。

| 节点名称 | 说明 |
| --- | --- |
| **Apply Mesh Boolean** | 基于第二个网格体将布尔值运算（例如，并集、交集和差集）应用于动态网格体。 |
| **Apply Mesh Plane Cut** | 将平面切割应用于网格体，可选择填充创建的所有孔洞。 |
| **Apply Mesh Plane Slice** | 将网格体切成两半，带可选的孔洞填充。 |
| **Apply Mesh Mirror** | 在整个平面中镜像网格体，带可选的三角形切割和结合。 |
| **Apply Mesh Offset** | 将网格体的顶点移至偏移表面。 |
| **Apply Mesh Shell** | 将网格体的三角形副本移至偏移表面，并将其拼接到原始三角形。 例如，用于创建加厚外壳。 |
| **Apply Mesh Extrude** | 沿恒定方向挤压网格体的三角形。 例如，从开放式三角剖分的多边形创建固体。 |
| **Apply Mesh Solidify** | 将网格体替换为体素化、网格化的近似对象（VoxWrap运算）。 |
| **Apply Mesh Morphology** | 将网格体替换为基于SDF的偏移网格体近似对象。 |
| **Apply Mesh Self Union** | 对象对自身执行布尔并集运算，计算修复自相交和删除浮动几何体等操作。 |
| **Apply Mesh PolyGroup Bevel** | 将网格体斜边运算应用于所有多边形组边缘。 |
| **Apply Mesh Disconnect Faces Along Edges** | 沿选择区域的边缘断开目标网格体中的三角形。 断开后，输入选择区域仍能辨识出相同的几何体元素。 |
| **Apply Mesh Bevel Edge Selection** | 将网格体斜边运算应用于目标网格体中使用斜边选项设置的部分。 |
| **Apply Mesh Iso Curves** | 沿曲线插入边缘，其中插值的每个顶点的值与给定的iso值匹配。 |

## 网格体选择

这些函数将向不同的工具识别网格体的区域，以便它们可以在局部操作。 多个函数可以在整个网格体或选择所定义的子集上工作。 选择类型包括：三角形、顶点和多边形组。

| 节点名称 | 说明 |
| --- | --- |
| **Invert Mesh Selection** | 反转目标网格体上的选择。 |
| **Create Select All Mesh Selection** | 创建给定选择类型的选择，其中包含目标网格体的所有元素。 |
| **Convert Mesh Selection** | 将网格体选择转换为另一种类型。默认情况下，顶点会映射到[单环](index.md#glossary)附近区域中的三角形，而三角形会映射到所有包含的顶点。 |
| **Combine Mesh Selections** | 将两个网格体选择合并为一个新的网格体选择。 选择A和选择B，这两个输入必须为相同的类型。 |
| **Convert Index Array To Mesh Selection** | 从索引数组创建网格体选择。 |
| **Convert Index Set To Mesh Selection** | 从索引集创建网格体选择。 |
| **Convert Mesh Selection To Index Array** | 将网格体选择转换为索引数组。 |
| **Convert Index List To Mesh Selection** | 从索引列表创建网格体选择。 对于索引列表类型不匹配选择类型的情况，将使用`bAllowPartialInclusion=true`的"转换网格体选择（Convert Mesh Selection）"进行转换。 |
| **Convert Mesh Selection To Index List** | 将网格体选择转换为索引列表。 |
| **Select Mesh Elements In Box** | 通过查找盒体中包含的所有元素，为目标网格体创建选择类型的新网格体选择。 |
| **Select Mesh Elements In Box With BVH** | 找到盒体中包含的所有元素，为目标网格体创建选择类型的新网格体选择。 类似于**Select Mesh Elements In Box**，但采用BVH，使其运行速度更快。 |
| **Select Mesh Elements In Sphere** | 通过查找球体中包含的所有元素，为目标网格体创建选择类型的新网格体选择。 |
| **Select Mesh Elements With Plane** | 通过查找平面一侧的所有元素，尤其是平面的表面法线指向的一侧，为目标网格体创建选择类型的新网格体选择。 |
| **Select Mesh Elements By Normal Angle** | 若法线向量与给定法线之间的距离在角偏差阈值之内，则通过查找所有此等法线向量的所有元素，为目标网格体创建选择类型的新网格体选择。对于三角形和多边形组选择，会使用三角形面片法线；对于顶点选择，会使用逐个顶点的平均法线。 |
| **Select Mesh Elements Inside Mesh** | 通过查找第二个选择网格体中的所有元素，为目标网格体创建选择类型的新网格体选择。 |
| **Expand Mesh Selection To Connected** | 将目标网格体上的选择扩展到连接的区域，并返回新选择。 |
| **Get Mesh Selection Bounding Box** | 获取网格体选择的3D边界框。 |
| **Get Mesh Selection Boundary Loops** | 计算网格体选择边界的顶点循环集。 针对每个循环都会返回3D多线段和顶点索引列表。对于顶点选择，此函数将返回顶点选择的单环附近区域的边界循环。 |
| **Get Mesh Selection Info** | 查询有关网格体选择的信息。 |
| **Debug Print Mesh Selection** | 将有关网格体选择的信息打印到输出日志。 |
| **Expand Contract Mesh Selection** | 将目标网格体上的选择增长到或收缩到连接的相邻值。*对于顶点选择，Expand会将顶点包括在所选顶点的单环中，Contract会删除有未选择的单环相邻值的所有顶点。*针对三角形选择，添加或删除连接到所选三角形的三角形。 * 对于多边形组选择，添加或删除连接到所选多边形组的多边形组。 |
| **Get Mesh Unique Selection Info** | 查询网格体选择的信息，获取被选中的唯一元素的数量。 |
| **Select Mesh Elements By Material ID** | 创建选择类型的选择，其中包含所有引用具有给定材质ID的三角形的网格体元素。 |
| **Select Mesh Elements By Polygroup** | 创建选择类型的选择，其中包含所有引用具有给定多边形层中给定多边形组ID的三角形的网格体元素 |
| **Select Mesh Sharp Edges** | 为目标网格体创建新选择，其中包含所有锐角边，这些边的相邻三角形法线角度差值至少为MinAngleDeg。 |
| **Select Mesh Boundary Edges** | 目标网格体创建新选择，其中包含所有网格体边界边缘。 |
| **Select Selection Boundary Edges** | 目标网格体创建新边界选择，其中包含另一个选择的边界边缘。 |
| SelectMeshSplitNormalEdges | 为目标网格体创建网格体法线拓扑中所有边缘接缝的新选择。 也就是说，边缘处的法线可能会有所不同。 |
| SelectMeshUVSeamEdges | 为目标网格体创建UV接缝边缘的新网格体选择。 |
| 选择网格体多边形组边界边缘 | 为目标网格体创建多边形组边界边缘的新网格体选择。 |

## 按选择修改网格体

用于从给定选择编辑几何体的函数。

### 变换网格体

| 节点名称 | 说明 |
| --- | --- |
| **Transform Mesh Selection** | 将给定变换应用于网格体的所选部分。 |
| **Translate Mesh Selection** | 将给定平移应用于网格体的所选部分。 |
| **Rotate Mesh Selection** | 相对于指定原点旋转网格体的所选部分。 |
| **Scale Mesh Selection** | 将给定缩放应用于网格体的所选部分。 |
| **Inverse Transform Mesh** | 将提供的变换的反转应用到目标网格体。 |
| **Inverse Transform Mesh Selection** | 将给定变换的反转应用于目标网格体的选择所标识的顶点。 |

### 材质和多边形组

| 节点名称 | 说明 |
| --- | --- |
| **Set Material ID For Mesh Selection** | 在给定选择的所有三角形上设置新的材质ID。 |
| **Set PolyGroup For Mesh Selection** | 对于给定的组层，在给定选择的所有三角形上设置新的多边形组。 |

### 网格体建模

| 节点名称 | 说明 |
| --- | --- |
| **Apply Mesh Disconnect Faces** | 选择识别目标网格体后，将目标网格体的三角形断开连接。 |
| **Apply Mesh Duplicate Faces** | 选择输入识别目标网格体后，复制目标网格体的三角形。 |
| **Apply Mesh Linear Extrude Faces** | 选择识别目标网格体后，将线性挤压应用于目标网格体的三角形。 |
| **Apply Mesh Offset Faces** | 选择识别的目标网格体后，将偏移应用于目标网格体的面，如果选择为空，则应用于所有面。 |
| **Apply Mesh Inset Outset Faces** | 选择识别目标网格体后，将内嵌或外嵌应用于目标网格体的面，如果选择为空，则应用于所有面。 |
| **Apply Mesh Bevel Selection** | 将网格体斜边运算应用于目标网格体中使用斜边选项设置的部分。 |

## 细分

这些函数将各种网格体细分策略应用于动态网格体资产。

| 节点名称 | 说明 |
| --- | --- |
| **Apply PolyGroup Catmull Clark SubD** | 将Catmull Clark细分应用于网格体的多边形组拓扑（丢弃输入三角剖分）。此节点仅适用于编辑器。 |
| **Apply Triangle Loop SubD** | 将循环细分应用于输入网格体。此节点仅适用于编辑器。 |
| **Apply Selective Tessellation** | 使用指示的模式类型，对指定网格体选择进行曲面细分。 |
| **Apply PN Tessellation** | 将点-法线曲面细分应用于输入网格体。 |
| **Apply Uniform Tessellation** | 将均匀曲面细分应用于输入网格体。 |

## 简化

这些函数使用各种策略来简化网格体。

| 节点名称 | 说明 |
| --- | --- |
| **Apply Simplify To Triangle Count** | 简化网格体，直至达到目标三角形计数。 |
| **Apply Simplify To Vertex Count** | 简化网格体，直至达到目标顶点计数。 |
| **Apply Simplify To Tolerance** | 将网格体简化至目标几何公差。 例如，进一步的简化会导致与输入网格体的偏差大于公差。 |
| **Apply Simplify To Planar** | 简化网格体中三角形超过必要数量的平面区域。这不会改变网格体的3D形状。 |
| **Apply Simplify To PolyGroup Topology** | 将网格体简化至多边形组拓扑。 例如，网格体多边形组的高级别面。 另一个例子是在默认盒体球体上，简化至多边形组拓扑会生成盒体。 |
| 将编辑器简化应用于三角形数量 | 使用UE编辑器的标准网格体简化器来简化网格体，直到达到目标三角形数量。 仅限编辑器。 |
| 将编辑器简化应用于顶点数量 | 使用UE编辑器的标准网格体简化器来简化网格体，直到达到目标三角形数量。 仅限编辑器。 |

## 方框

这些辅助函数用于计算盒体对象的基本数学函数。

| 节点 | 说明 |
| --- | --- |
| **Make Box From Center Size** | 从中心点以及X、Y和Z尺寸创建盒体。 |
| **Make Box From Center Extents** | 从中心点以及X、Y和Z[范围](index.md#glossary)创建盒体。 范围是半尺寸。 |
| **Get Box Center Size** | 获取盒体的中心点以及X、Y和Z尺寸。 |
| **Get Box Corner** | 获取盒体某个角的位置。 角的索引编号从0到7，使用某种排序，其中：0是最小角1/2/3是距离最小角的+Z/+Y/+X7是最大角4/5/6是距离最大角的-Z/-Y/-X |
| **Get Box Face Center** | 获取盒体某个面的中心位置。 面的索引编号为从0到5的值，使用排序，其中：0和1是MinZ和MaxZ面2和3是MinY和MaxY面4和5是MinX和MaxX面 |
| **Get Box Volume Area** | 获取盒体的体积和表面积。 |
| **Get Expanded Box** | 通过将"扩展依据（Expand By）"参数添加到"最小值（Min）"和"最大值（Max）"来扩展输入盒体。 如果任何"扩展依据（Expand By）"参数大于盒体尺寸的一半，则会将尺寸限制到中心点。 |
| **Get Transformed Box** | 将输入变换应用于输入盒体的角，并返回包含这些点的新盒体。 |
| **Test Box Box Intersection** | 测试盒体1和盒体2是否相交。 |
| **Find Box Box Intersection** | 查找由盒体1和盒体2相交形成的盒体。 |
| **Get Box Box Distance** | 计算盒体1和盒体2之间的最短距离。 |
| **Test Point Inside Box** | 测试一个点是否在盒体内；如果是，则返回true，否则返回false。 |
| **Find Closest Point On Box** | 查找盒体面上最接近输入点的点。 如果该点在盒体内，则返回该点。 |
| **Get Box Point Distance** | 计算盒体和点之间的最短距离。 |
| **Test Box Sphere Intersection** | 检查盒体是否与由"球体中心（Sphere Center）"和"球体半径（Sphere Radius）"定义的球体相交。 |

## 法线

这些函数重新计算网格体的法线。

| 节点名称 | 说明 |
| --- | --- |
| **Flip Normals** | 反转每个面的方向来翻转网格体法线。 |
| **Set Per Vertex Normals** | 将网格体法线设置为每个顶点的法线。 例如，所有顶点都没有分割法线。 |
| **Set Mesh To Facet Normals** | 将网格体法线设置为每个面/三角形的法线。 例如，沿网格体每个边缘的分割法线。 |
| **Compute Split Normals** | 基于角度公差和/或诸如多边形组拓扑之类的其他因素，计算网格体的分割法线。 |
| **Recompute Normals** | 重新计算现有网格体法线。 保留现有分割法线。 例如，在网格体变形之后使用。 |
| **Compute Tangents** | 重新计算网格体的切线（各种方法）。 |
| **Set Mesh Per Vertex Normals** | 将目标网格体法线覆层中的所有法线设置为指定的每个顶点法线。 |
| **Get Mesh Has Tangents** | 检查目标网格体是否启用了"切线属性层（Tangents Attribute Layer）"。 |
| **Discard Tangents** | 从目标网格体删除任何现有的切线属性层。 |
| **Compute Tangents** | 使用指定的方法重新计算目标网格体的切线。 |
| **Set Mesh Per Vertex Tangents** | 将目标网格体切线覆层中的所有切线设置为指定的每个顶点切线。 |
| **Get Mesh Per Vertex Tangents** | 计算插值的位置，`A * Vertex1 + B * Vertex2 + C * Vertex3`，其中(A,B,C) = 重心坐标，顶点位置取自目标网格体的指定TriangleID。 |
| **Update Vertex Normal** | 更新目标网格体VertexD处的法线和切线。 |
| **Recompute Normals For Mesh Selection** | 使用给定计算选项在给定选择的所有三角形/顶点上重新计算目标网格体的法线。 此方法将保留所有现有硬边缘，即，每条共享三角形-顶点法线通过对引用该共享三角形-顶点法线的三角形的面部法线取平均值来重新计算。 |
| **Set Split Normals Along Selected Edges** | 设置或移除选择中所有边缘的分离法线（又称尖锐法线）。 |
| **Flip Triangle Selection Normals** | 反转给定目标网格体选择中的三角形的法线向量。 对于边缘或顶点选择，接触选定边缘或顶点的三角形的法线将被翻转。 |

## 清理和修复

这些函数用于修复网格体中的问题，或应用其他标准修复。

| 节点名称 | 说明 |
| --- | --- |
| **Compact Mesh** | 压缩网格体的顶点和三角形，以删除顶点ID或三角形ID列表中的所有"孔洞"（请参阅"低级别网格体查询"小节中的讨论）。 |
| **Discard Mesh Attributes** | 从动态网格体删除属性集，例如所有UV、法线、材质ID、顶点颜色和扩展多边形组层。 请注意，这可能会导致许多函数无法正常运行。 |
| **Auto Repair Normals** | 该函数尝试自动调整网格体法线的方向，使其保持一致，例如修复翻转的法线。 |
| **Weld Mesh Edges** | 在可能的情况下，将网格体的所有开放式边界边缘结合在一起，以便删除"裂缝"。 |
| **Fill All Mesh Holes** | 尝试填充网格体的所有开放式边界循环（例如几何体表面中的孔洞）。 |
| **Remove Small Components** | 删除网格体中体积、面积或三角形计数低于阈值的连接组件。 |
| **Remove Hidden Triangles** | 删除网格体中按照"可见"和"外部"的各种定义从外部视图不可见的所有三角形。 |
| **Resolve Mesh TJunctions** | 尝试解决目标网格体中的T形连接。 |
| **Split Mesh Bowties** | 拆分目标网格体中的顶点，否则这些顶点会生成领结，其中仅单个顶点连接网格体的各个区域。 |
| **Repair Mesh Degenerate Geometry** | 删除小三角形或合并三角形，直到所有边缘大于指定最小长度为止，从而修改目标网格体。 |
| **Remove Unused Vertices** | 删除未被任何三角形使用的顶点。不会更新剩余顶点的ID。 使用紧凑网格体（Compact Mesh）来完成该操作。 |
| **Snap Mesh Open Boundaries** | 如果在容差距离范围内找到开放边界，则将开放边缘上的顶点对齐到最近的兼容开放边界。 |

## 低级别网格体查询

这些函数提供有关网格体元素的低级别信息。 在此上下文中，**VertexID**和**TriangleID**是整型。

> [!NOTE]
> 在动态网格体中，删除顶点/三角形之后，VertexID或TriangleID范围中可能存在空缺，一些运算（如简化）可能返回存在空缺的网格体。 ID范围中的空缺是使用 **Compact Mesh** 函数清理的。

| 节点名称 | 说明 |
| --- | --- |
| **Get Vertex Count** | 获取网格体中的顶点数量。 |
| **Get Num Vertex IDs** | 获取网格体中的顶点ID数量，如果网格体不密集，这可能大于顶点计数。 例如，在删除顶点之后。 |
| **Is Valid Vertex ID** | 如果顶点ID引用的是有效顶点，则返回true。 |
| **Get All Vertex IDs** | 返回网格体中所有顶点ID的索引列表。 |
| **Get Vertex Position** | 按顶点ID获取网格体顶点的3D位置。 |
| **Get All Vertex Positions** | 返回所有网格体顶点位置的向量列表。 此列表可能很长。 |
| **Get Triangle Count** | 返回网格体中的三角形数量。 请注意，这是直接作用于动态网格体的函数。 |
| **Get Num Triangle IDs** | 获取网格体中三角形ID的数量。 如果网格体不密集，即使在删除三角形之后，这也可能大于三角形计数。 |
| **Is Valid Triangle ID** | 如果三角形ID引用的是有效三角形，则返回true。 |
| **Get All Triangle IDs** | 返回网格体中所有三角形ID的索引列表。 |
| **Get Triangle Indices** | 返回三角形的三顶点索引组。 |
| **Get All Triangle Indices** | 返回网格体中所有三角形三索引组的三角形列表。 |
| **Get Triangle Positions** | 返回三角形的三个角位置。 |
| **Get Triangle Face Normal** | 返回三角形的面/面片法线。 |
| **Get Triangle UVs** | 返回三角形的三个角UV。 |
| **Get Triangle Material ID** | 返回三角形的当前材质ID。 |
| **Get All Triangle Material IDs** | 返回所有三角形材质ID的索引列表。 |
| **Get Triangle PolyGroup ID** | 返回给定多边形组层中三角形的当前多边形组ID。 |
| **Get Has Vertex ID Gaps** | 如果顶点ID列表中有空缺，则返回true。 例如，"Get Number of Vertex IDs"大于"Get Vertex Count"。 |
| **Get Has Triangle ID Gaps** | 如果三角形ID列表中有空缺，使得"Get Num Triangle IDs"大于"Get Triangle Count"，则返回true。 |
| **Get Is Dense Mesh** | 如果网格体密集，则返回true。 例如，顶点ID或三角形ID中没有空缺。 |
| **Get Mesh Has Attribute Set** | 如果网格体启用了特性集来存储UV、法线、材质ID和顶点颜色， 则返回true。 通常默认启用。 |
| **Get Interpolated Triangle Position** | 计算插值的位置`A * Vertex1 + B * Vertex2 + C * Vertex3`，其中(A,B,C) = 重心坐标，顶点位置取自目标网格体的指定TriangleID。 |
| **Compute Triangle Barycentric Coords** | 计算点相对于目标网格体的指定TriangleID的重心坐标(A,B,C)。 |
| **Get Interpolated Triangle UV** | 计算插值的UV，`A * UV1 + B * UV2 + C * UV3`，其中(A,B,C) = 重心坐标，UV位置取自目标网格体的指定UV通道中的指定TriangleID。 |
| **Get Triangle Normals** | 对于目标网格体的指定TriangleID，获取三角形每个顶点处的法线和切线向量。 这些法线和切线将取自法线和切线覆层。 |
| **Get Interpolated Triangle Normal** | 计算插值的法线`A * Normal1 + B * Normal2 + C * Normal3`，其中(A,B,C) = 重心坐标，法线取自目标网格体的法线层中的指定TriangleID。 |
| **Get Triangle Normal Tangents** | 对于目标网格体的指定TriangleID，获取三角形每个顶点处的法线和切线向量。 这些法线和切线将取自法线和切线覆层。 |
| **Get Interpolated Triangle Normal Tangents** | 对于目标网格体的法线和切线属性中的指定TriangleID，计算插值的法线和切线。 |
| **Get Has Vertex Colors** | 如果目标网格体启用了"顶点颜色（Vertex Colors）"属性，则返回true。 |
| **Get Triangle Vertex Colors** | 对于目标网格体的指定TriangleID，获取三角形每个顶点处的顶点颜色。 这些颜色将取自顶点颜色属性。 |
| **Get Interpolated Triangle Vertex Color** | 计算插值的顶点颜色`A * Color1 + B * Color2 + C * Color3`，其中(A,B,C) = 重心坐标，颜色取自目标网格体的顶点颜色层中的指定TriangleID。 |
| **Get All Vertex Positions At Edges** | 返回给定索引列表中每条边的顶点位置。 |
| **Get Mesh UV Area** | 获取给定UV通道中三角形在UV空间中的面积。 |
| **Get All UV Seam Edges** | 返回给定UV通道中属于UV接缝边缘的所有边缘元素。 |
| **Get Num UV Islands** | 返回给定UV通道中UV岛状区的数量。 |

## 低级别网格体编译

这些函数用于逐个三角形构造网格体，以及执行其他低级别网格体编辑运算。

> [!WARNING]
> 若网格体元素有成千上万个三角形，那么在涉及到循环的情况中使用这些函数，可能会在蓝图或Python脚本编写中运行相当缓慢。

| 节点名称 | 说明 |
| --- | --- |
| **Set Vertex Position** | 设置网格体顶点的3D位置。 |
| **Add Vertex To Mesh** | 将新顶点添加到网格体并返回新的顶点ID。 |
| **Add Vertices To Mesh** | 将顶点列表添加到网格体。 |
| **Delete Vertex From Mesh** | 从网格体删除顶点。 |
| **Delete Vertices From Mesh** | 从网格体删除顶点列表。 |
| **Add Triangle To Mesh** | 将一个三角形（3元素顶点ID元组）添加到网格体。 |
| **Add Triangles To Mesh** | 将三角形列表添加到网格体。 |
| **Delete Triangle From Mesh** | 从网格体删除一个三角形。 |
| **Delete Triangles From Mesh** | 从网格体删除三角形列表。 |
| **Delete Triangles In PolyGroup** | 从网格体删除特定多边形组层中有特定多边形组的所有三角形。 |
| **Append Buffers To Mesh** | 将一组顶点/三角形添加到网格体，带有法线、UV等属性。 类似于流程性网格体（Proc Mesh）组件中的创建网格体（Create Mesh）分段。 |
| **Set Mesh Triangle Normals** | 设置网格体三角形的法线。 |
| **Set Mesh Triangle UVs** | 设置网格体三角形的UV。 |
| **Set Triangle Material ID** | 设置网格体三角形的材质ID。 |
| **Set All Mesh Vertex Positions** | 将目标网格体中的所有顶点位置设置为指定位置。 |
| **Append Mesh With Materials** | 对附加网格体引用附加变换，再将其几何体添加到目标几何体。 同时合并目标网格体和附加网格体的材质列表，并更新输出几何体材质，使其引用合并后的列表。 |
| **Append Mesh Transformed With Materials** | 将附加变换中的每一个变换应用到附加网格体，然后将其网格体添加到目标几何体。 同时合并目标网格体和附加网格体的材质列表，并更新输出几何体材质，使其引用合并后的列表。 |
| **Append Mesh Repeated With Materials** | 对附加网格体反复应用附加变换，每应用一次就将几何体添加到目标几何体。 同时合并目标网格体和附加网格体的材质列表，并更新输出几何体材质，使其引用合并后的列表。 |
| **Merge Mesh Vertex Pair** | 尝试合并两个顶点，并报告它们是否合并。某些合并可能会被阻止，因为它们会在网格体中创建不受支持的非流形边缘。 |
| **Merge Mesh Vertices In Selections** | 尝试将一个选择中的顶点与第二个选择中距离阈值内的最近顶点合并在一起。合并可能会被阻止，因为它们会在网格体中创建不受支持的非流形边缘。 |

## 低级别列表管理

这些函数覆盖了以下各项的列表管理：索引列表、标量列表、向量列表、UV列表和颜色列表。

| 节点名称 | 说明 |
| --- | --- |
| **Get Index List Length** | 返回索引列表中的项目数量。 |
| **Get Index List Last Index** | 返回索引列表中最后一个项目的索引。 |
| **Get Index List Item** | 返回索引列表中指定位置存储的项目。 |
| **Set Index List Item** | 更新索引列表中指定位置存储的项目的值。 |
| **Convert Index List To Array** | 将索引列表转换为整数数组。 |
| **Convert Array To Index List** | 将整数数组转换为索引列表。 |
| **Duplicate Index List** | 将索引列表的内容到复制列表中。 |
| **Clear Index List** | 将索引列表中的所有项目重置为清空值。 |
| **Get Scalar List Length** | 返回标量列表中的项目数量。 |
| **Get Scalar List Last Index** | 返回标量列表中最后一个项目的索引。 |
| **Get Scalar List Item** | 返回标量列表中指定位置存储的标量（double）。 |
| **Set Scalar List Item** | 更新标量列表中指定位置存储的标量的值。 |
| **Convert Scalar List To Array** | 将标量列表转换为double数组。 |
| **Convert Array To Scalar List** | 将double数组转换为标量列表。 |
| **Duplicate Scalar List** | 将标量列表的内容复制到复制列表中。 |
| **Clear Scalar List** | 将标量列表中的所有项目重置为清空值。 |
| **Get Vector List Length** | 返回向量列表中的项目数量。 |
| **Get Vector List Last Index** | 返回向量列表中最后一个项目的索引。 |
| **Get Vector List Item** | 返回向量列表中指定位置存储的FVector。 |
| **Set Vector List Item** | 更新向量列表中指定位置存储的FVector的值。 |
| **Convert Vector List To Array** | 将向量列表转换为FVector数组。 |
| **Convert Array To Vector List** | 将FVector数组转换为向量列表。 |
| **Duplicate Vector List** | 将向量列表的内容复制到复制向量列表中。 |
| **Clear Vector List** | 将向量列表中的所有项目重置为清空值。 |
| **Get UV List Length** | 返回UV列表中的项目数量。 |
| **Get UV List Last Index** | 返回UV列表中最后一个项目的索引。 |
| **Get UV List Item** | 返回保存在指定位置处UV列表中的[FVector2D](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Math/FVector2D?application_version=5.5)。 |
| **Set UV List Item** | 更新UV列表中指定位置存储的FVector2D的值。 |
| **Convert UV List To Array** | 将UV列表转换为FVector2D数组。 |
| **Convert Array To UV List** | 将FVector2D数组转换为UV列表。 |
| **Duplicate UV List** | 将UV列表的内容复制到复制列表中。 |
| **Get Color List Length** | 返回颜色列表中的项目数量。 |
| **Get Color List Last Index** | 返回颜色列表中最后一个项目的索引。 |
| **Get Color List Item** | 返回指定位置的颜色列表中存储的[FLinearColor](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Math/FLinearColor?application_version=5.5)。 |
| **Set Color List Item** | 更新颜色列表中指定位置存储的FLinearColor的值。 |
| **Convert Color List To Array** | 将颜色列表转换为FLinearColor数组。 |
| **Convert Array To Color List** | 将FLinearColor数组转换为颜色列表。 |
| **Extract Color List Channel** | 创建对应于颜色列表的0、1或2通道的标量列表。 |
| **Extract Color List Channels** | 通过颜色列表创建向量列表。 颜色列表的通道通过X通道索引、Y通道索引和Z通道索引映射到向量组件。 |

## 低级别数学运算

以组件方式对向量列表和标量列表进行运算的函数。 采用向量点等多个列表的函数需要这些列表包含相同数量的元素。

| 节点名称 | 说明 |
| --- | --- |
| **Vector Length** | 计算向量列表A中每个向量的长度，并在标量列表中返回值。 |
| **Vector Dot** | 计算向量列表A和向量列表B中每对向量之间的点积，并在新标量列表中返回值。 |
| **Vector Cross** | 计算向量列表A和向量列表B中每对向量之间的交叉积，并在新向量列表中返回值。 |
| **Vector Normalize In Place** | 规格化向量列表中的每个向量，并将值存储在向量列表中。 如果某个向量是退化的，请将法线设置为Set On Failure向量。 |
| **Vector Blend** | 为向量列表A和向量列表B中每对向量计算`ConstantA * A + ConstantB * B`，并在新向量列表中返回值。默认情况下，此(constants = 1)会添加两个向量。 设置`ConstantB = -1`以从A减去B。你还可以设置`ConstantB = 1 - ConstantA`，从而使用该函数进行线性插值。 |
| **Vector Blend In Place** | 为向量列表A和向量列表B中每对向量计算`ConstantA * A + ConstantB * B`，并将值存储在向量列表B中。默认情况下，此(constants = 1)会添加两个向量。 设置`ConstantB = -1`以从A减去B。你还可以设置`ConstantB = 1 - ConstantA`，从而使用该函数进行线性插值。 |
| **Scalar Vector Multiply** | 为两个输入列表中的每个标量/向量对计算`Scalar Multiplier * Scalar * Vector`，并在新向量列表中返回值。 |
| **Scalar Vector Multiply In Place** | 为两个输入列表中的每个标量/向量对计算`Scalar Multiplier * Scalar * Vector`，并将值存储在输入向量列表中。 |
| **Constant Vector Multiply** | 为向量列表中的每个元素计算`Constant * Vector`，并在新列表中返回值。 |
| **Constant Vector Multiply In Place** | 为向量列表中的每个元素计算`Constant * Vector`，并将值存储在向量列表中。 |
| **Vector To Scalar** | 计算`ConstantX * Vector.X + ConstantY * Vector.Y + ConstantZ * Vector.Z`，将向量列表中的每个向量转换为标量，并在新标量列表中返回值。你可以使用它从向量提取X、Y和Z值，或执行其他组件方式的数学运算。 |
| **Scalar Invert** | 为标量列表中的每个元素计算`Numerator / Scalar`，并在新标量列表中返回值。如果Abs(Scalar) < Epsilon，设置为Set On Failure值。 |
| **Scalar Invert In Place** | 为标量列表中的每个元素计算`Numerator / Scalar`，并将值存储在输入标量列表中。如果Abs(Scalar) < Epsilon，设置为Set On Failure值。 |
| **Scalar Blend** | 为标量列表A和标量列表B中每对值计算`ConstantA * A + ConstantB * B`，并在新标量列表中返回值。默认情况下，此(constants = 1)仅添加两个值。 设置`ConstantB = -1`以从A减去B。你还可以设置`ConstantB = 1 - ConstantA`，从而使用该函数进行线性插值。 |
| **Scalar Blend In Place** | 为标量列表A和标量列表B中每对值计算`ConstantA * A + ConstantB * B`，并在标量列表B中返回。默认情况下，此(constants = 1)仅添加两个值。 设置`ConstantB = -1`以从A减去B。还可以设置`ConstantB = (1 - ConstantA)`，用于进行线性插值。 |
| **Scalar Multiply** | 为标量列表A和标量列表B中每对值计算`Scalar Multiplier * A * B`，并在新标量列表中返回值。 |
| **Scalar Multiply In Place** | 为标量列表A和标量列表B中每对值计算`Scalar Multiplier * A * B`，并在标量列表B中返回值。 |
| **Constant Scalar Multiply** | 为标量列表中的每个值计算`Constant * Scalar`，并在新标量列表中返回值。 |
| **Constant Scalar Multiply In Place** | 为标量列表A和标量列表B中每对值计算`Scalar Multiplier A * B`，并在当前标量列表中返回值。 |
| **Transform In Place** | 变换向量列表中中的每个向量，并存储在向量列表中。 |
| **Vector Inverse Transform In Place** | 逆向变换向量列表中中的每个向量，并存储在向量列表中。 |
| **Vector Plane Project In Place** | 将向量列表中的每个向量投影到给定平面，并存储在向量列表中。 |

## 网格体采样

这些函数计算点并沿网格体表面放置点。

| 节点 | 说明 |
| --- | --- |
| **Compute Point Sampling** | 根据提供的取样选项计算位于目标网格体表面上的一组样本点。 样本大致均匀分布，并且相对于提供的选项不重叠。 |
| **Compute NonUniform Point Sampling** | 根据提供的取样选项和非均匀选项计算位于目标网格体表面上的一组样本点。 |
| **Compute Vertex Weighted Point Sampling** | 根据提供的取样选项和非均匀选项计算位于目标网格体表面上的一组样本点。 |
| **Compute Render Capture Cameras For Box** | 计算一组渲染捕获摄像机来捕获给定盒体内的场景。 |
| **Compute Render Capture Point Sampling** | 计算给定Actor的可见表面上的定向采样点。 样本使用给定虚拟摄像机的渲染捕获来计算。 |
| **Compute Uniform Random Point Sampling** | 在网格体表面上计算“均匀随机”（而非“均匀间距”）点采样。 |

## 全新网格体塑造层！

这些函数管理存储在网格体上的其他顶点偏移。 可以按照预先设定的权重将它们混合在一起。

| 节点 | 说明 |
| --- | --- |
| **Set Active Sculpt Layer** | 如果可能，将请求的Layer Index设为当前激活的塑造层。 |
| **Set Sculpt Layer Weight** | 将Layer Index处的层权重设为请求的权重。 |
| **Set Sculpt Layer Weights Array** | 设置多个层的权重以匹配给定的权重数组。注意：如果权重数组长度大于层数，则只设置现有层的权重。 不会添加或移除层。 |
| **Get Sculpt Layer Weights Array** | 获取网格体上所有塑造层的权重。 |
| **Get Num Sculpt Layers** | 获取网格体上激活的塑造层数。 |
| **Get Active Sculpt Layer** | 获取网格体上当前激活的塑造层，如果网格体没有塑造层，则返回-1。 |
| **Discard Sculpt Layers** | 丢弃所有塑造层数据，保持当前顶点位置不变。 |
| **Merge Sculpt Layers** | 将一系列塑造层合并在一起。 可能会更改活动的塑造层。 |

## 光线

这些辅助函数用于创建和查询光线。 光线是一条可用于确定对象相交的线。 这些对于在蓝图中构建交互式用户界面特别有用。

| 节点 | 说明 |
| --- | --- |
| **Make Ray From Points** | 从两个点创建一条光线，将原点置于A处，方向设置为规格化(B-A)。 |
| **Make Ray From Point Direction** | 从原点和方向创建光线，可选择使用非规格化方向。 |
| **Get Transformed Ray** | 将给定变换应用于给定光线，或选择性地反转变换（Transform Inverse），并返回变换的新光线。 |
| **Get Ray Point** | 在沿光线的给定距离处获取一个点（`Origin + Distance * Direction`）。 |
| **Get Ray Start End** | 沿光线获取两个点。 |
| **Get Ray Parameter** | 将给定点投影到沿光线的最近点上，并返回该点的光线参数和距离。 |
| **Get Ray Point Distance** | 获取从给定点到光线上最近点的距离。 |
| **Get Ray Closest Point** | 获取光线上离给定点最近的点。 |
| **Get Ray Sphere Intersection** | 检查光线是否与由"球体中心（Sphere Center）"和"球体半径（Sphere Radius）"定义的球体相交。 此函数返回两个相交距离（光线参数）。 如果光线掠过球体，则两个距离将相同。 如果未命中，这两个距离将是MAX_FLOAT。 使用"获取光线点（Get Ray Point）"函数将距离转换为光线和球体上的点。 |
| **Get Ray Box Intersection** | 检查光线是否与由"球体中心（Sphere Center）"和"球体半径（Sphere Radius）"定义的球体相交。 |
| **Get Ray Plane Intersection** | 查找光线与平面相交。 |
| **Get Ray Line Closest Point** | 计算3D光线和线上的一对最近点。 这条线由原点和方向定义，但在两个方向上无限延伸。 |
| **Get Ray Segment Closest Point** | 计算3D光线和线段上的一对最近点。 线段由其两个端点定义。 |

## 点集

适用于点集的函数。

| 节点 | 说明 |
| --- | --- |
| **KMeans Cluster To IDs** | 使用K-Means聚类算法将给定的点聚集到目标数量的簇中，并返回一个数组，其中包含每个点的簇索引。 |
| **KMeans Cluster To Arrays** | 使用K-Means聚类算法将给定的点聚集到目标数量的簇中，并将这些簇作为点索引列表的数组返回。 |
| **Downsample Points** | 查找指定大小的给定点的子集。 你可以选择为下采样点指定优先级权重和/或要求均匀间距。 |
| **Transforms To Points** | 创建输入变形的位置数组。 |
| **Offset Transforms** | 使用偏移量，令所有变形的位置朝给定方向偏移，这可以对变形的本地空间使用，也可以在全局空间中使用。 例如，这可以沿着表面法线的方向偏移网格体表面样本。 |
| **Flatten Points** | 将一个点数组从3D转换为2D，方法是将其转换到给定的ReferenceFrame中，并提取X、Y坐标。 请注意，为了将点数组换到参考框架中，我们需要应用ReferenceFrame的逆变换。 |
| **Unflatten Points** | 将一个点数组从2D转换为3D，方法是将其从给定的ReferenceFrame中转出，并将给定高度用于非平面轴（默认为Z轴）。 |
| **Make Bounding Box From Points** | 创建一个坐标轴对齐的边界框，框入给定的点，可选择性地地在每一面上额外扩展一定量。 |
| **Get Points From Index List** | 创建一个数组，包含由索引列表指定的AllPoints的子集。 |

## 材质

这些函数用于操控网格体的材质ID。 材质ID是每个三角形的整数，并不直接关联到特定材质。 在与静态网格体之间转换时，每个材质ID都关联一个**网格体分段（Mesh Section）**。

| 节点名称 | 说明 |
| --- | --- |
| **Get Has Material IDs** | 如果网格体提供/启用了材质ID，则返回true。 |
| **Enable Material IDs** | 启用网格体上的材质ID，初始化为0。 |
| **Clear Material IDs** | 将网格体上的所有材质ID重置为0。 |
| **Get Max Material ID** | 返回网格体上当前设置的最大材质ID。 |
| **Remap Material IDs** | 对于带有匹配给定值的材质ID的所有三角形，将材质ID设置为新值。 |
| **Set All Triangle Material IDs** | 将网格体中的所有三角形的材质ID设置为输入索引列表中的值。 |
| **Set PolyGroup Material ID** | 将网格体中有指定多边形组ID（在给定多边形组层中）的所有三角形的材质ID设置为指定材质ID。 |
| **Remap To New Material IDs By Material** | 基于源/当前材质列表，以及一个新的材质列表，将目标网格体的材质ID重新映射到一组新的材质ID上。 对于每个三角形，当前材质会被确定为FromMaterialList[MaterialID]，然后在ToMaterialList中找到此材质的第一个索引，并将其用作新MaterialID。 如果材质无法在ToMaterialList中找到，将打印一条警告，且不会修改MaterialID，除非该MaterialID的值>=0。 在这种情况下，系统会为其分配一个MissingMaterialID。 |
| **Remap And Combine Materials** | 重映射材质ID，使其与所需材质列表保持一致。 目标网格体的材质ID将被重映射，以引用合并后的材质列表，该列表始终以所需材质开头。 |

## 碰撞

用于创建、编辑和操作碰撞形状的函数。

| 节点名称 | 说明 |
| --- | --- |
| **Static Mesh Has Customized Collision** | 如果静态网格体拥有自定义碰撞，则返回true。 如果没有可用的编辑器数据，则返回false。 |
| **Get Simple Collision From Component** | 从图元组件获取简单碰撞。 |
| **Set Simple Collision Of Dynamic Mesh Component** | 在动态网格体组件上设置简单碰撞。 |
| **Get Simple Collision From Static Mesh** | 从静态网格体获取简单碰撞。 |
| **Set Simple Collision Of Static Mesh** | 在静态网格体上设置简单碰撞。 |
| **Get Simple Collision Shape Count** | 计算简单碰撞形状的数量。 |
| **Transform Simple Collision Shapes** | 变换简单碰撞形状。 |
| **Combine Simple Collision** | 将简单碰撞形状从附加碰撞（Append Collision）添加到待更新碰撞（Collision To Update）。 |
| **Simplify Convex Hulls** | 简化给定简单碰撞表示中的所有凸包。 更新传入的简单碰撞。 |
| **Approximate Convex Hulls With Simpler Collision Shapes** | 尝试近似表示给定简单碰撞表示中的凸包。 更新传入的简单碰撞。 无法精确近似表示的凸包（以ApproximateOptions中的公差设定为准）将被保留。 |
| **Merge Simple Collision Shapes** | 尝试合并碰撞形状，以创建整体形状较少的表示。 |
| **Compute Negative Space** | 计算输入网格体表面的负空间，该负空间在合并简单碰撞形状时应得到保护。 |
| **Sphere Covering To Array Of Spheres** | 在给球体覆盖范围（Sphere Covering）内球体的数组。 |
| **Array Of Spheres To Sphere Covering** | 返回一个球体覆盖范围（Sphere Covering），其中包含给定球体数组内的球体。 |
| **Set Static Mesh Custom Complex Collision** | 将静态网格体设置为自定义碰撞，供另一个静态网格体使用。注意：只在有可用的仅编辑器数据时生效。 |
| **Reset Simple Collision** | 清理简单碰撞形状。 |
| **Generate Collision From Mesh** | 为输入的动态网格体形状生成简单碰撞形状。 |
| **Combine Simple Collision Array** | 将简单碰撞数组碰撞形状并入一个简单碰撞。 |
| **Compute Navigable Convex Decomposition** | 计算输入网格体表面的'可寻路'凸包分解。 该凸包分解适用于给定尺寸及更大尺寸的角色。 |

## 遏制

以下函数用于近似带凸包外壳的网格体。

| 节点名称 | 说明 |
| --- | --- |
| **Compute Mesh Convex Hull** | 计算给定目标网格体的凸包外壳。 如提供（可选的）选择，则计算局部网格体的凸包外壳，并将结果放入壳网格体中。 |
| **Compute Mesh Swept Hull** | 根据由投影框架定义的给定3D平面，计算给定目标网格的扫掠壳，并将结果存入壳网格体中。 扫掠壳是对网格体顶点投影到该平面上的二维凸包壳进行线性扫掠的结果（扫掠部分恰好包含沿平面法线方向延伸的网格体）。 |
| **Compute Mesh Convex Decomposition** | 计算给目标网格体的凸包分解。 假定请求了多个外壳，将返回尝试近似表示网格体的多个外壳。如启用了简化设置，则不能保证外壳将整个网格体包含在内。 |

## 顶点值

你可以使用这些函数获取和操控顶点中存储的网格体值，包括**顶点颜色（Vertex Colors）**

> [!NOTE]
> 法线等多个值可以存储在给定顶点中，但这些方法仅返回一个值。

| 节点名称 | 说明 |
| --- | --- |
| **Set Mesh Constant Vertex Color** | 将所有顶点颜色设置为特定颜色。 |
| **Set Mesh Per Vertex Colors** | 使用颜色列表设置每个顶点的颜色。 |
| **Get Mesh Per Vertex Colors** | 获取目标网格体中每个网格体顶点的单顶点颜色的列表，派生自顶点颜色的[覆层](index.md#glossary)。 |
| **Set Mesh Selection Vertex Color** | 将目标网格体的顶点颜色覆层（通过选择识别）中的颜色设置为常量值。对于顶点选择，该顶点每个现有的顶点颜色覆层元素将更新。对于三角形或多边形组选择，已标识三角形中的所有覆层元素都将更新。 |
| **Convert Mesh Vertex Colors SRGB To Linear** | 在所有顶点颜色上应用SRGB到线性的颜色变换。 |
| **Convert Mesh Vertex Colors Linear To SRGB** | 在所有顶点颜色上应用线性到SRGB的颜色变换。 |
| **Get Mesh Per Vertex Normals** | 获取目标网格体中每个网格体顶点的单法线向量的列表，从法线覆层派生。 |
| **Get Mesh Per Vertex UVs** | 获取目标网格体中每个网格体顶点的单顶点UV的列表，从指定UV覆层派生。 |
| **Blur Mesh Vertex Colors** | 模糊网格体的颜色属性。 如果网格体没有颜色属性，函数返回未加改动的网格体。 |
| **Transfer Vertex Colors From Mesh** | 将顶点颜色从源网格体传输到目标网格体。假定网格体已对齐。 否则，使用Transform Mesh几何体脚本函数进行对齐。 |

## 纹理取样和创建

用于读取和创建纹理数据的函数。

| 节点名称 | 说明 |
| --- | --- |
| **Sample Texture 2D At UV Positions** | 对UV位置列表中的给定纹理贴图取样，并在颜色列表输出中返回每个位置的颜色。 |
| **Create New Texture 2D Asset** | 从临时[UTexture2D](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UTexture2D?application_version=5.5)创建序列化的纹理2D资产。 |
| **Sample Texture Render Target 2D At UV Positions** | 对UV位置列表中的给定纹理贴图取样，并在颜色列表输出中返回每个位置的颜色。 此函数在取样之前获取GPU数据，因此，根据具体应用程序，函数可能效率低下且速度缓慢。 |

## 烘焙

这些函数将源网格体和目标网格体之间的数据烘焙到纹理或顶点颜色数据。 你可以烘焙各种网格体数据，例如法线、曲率、环境光遮蔽、不透明度贴图和次表面颜色贴图。 你还可以指定要应用的滤波类型。

| 节点名称 | 说明 |
| --- | --- |
| **Bake Texture** | 根据源网格体中取样的数据，为目标网格体创建纹理。 |
| **Bake Vertex** | 使用给定源网格体的烘焙属性的结果，填充目标网格体中的顶点颜色。 |
| **Bake Texture From Render Captures** | 从渲染捕获中烘焙目标网格体的纹理。 |
| **Make Bake Type UV Shell** | 为UV外壳生成烘焙选项。 |
| **Bake Signed Distance To Volume Texture** | 将距离场写入给定的现有体积纹理。 |
| **Make Bake Type Height** | 为高度数据生成烘焙选项。 |

## UV

你可以使用这些函数操控网格体的[UV](https://dev.epicgames.com/documentation/assets/working-with-content/modeling-and-geometry-scripting/modeling-tools/uvs-category)。

| 节点名称 | 说明 |
| --- | --- |
| **Get Num UV Channels** | 获取网格体上的UV[通道](index.md#glossary)数量。 |
| **Set Num UV Channels** | 设置网格体上的UV层数量。 |
| **Get UV Set Bounding Box** | 获取UV通道内所有UV的2D边界框。 |
| **Copy UV Channel** | 将目标UV通道替换为源UV通道的值。 |
| **Translate Mesh UVs** | 将2D平移应用于UVSet索引中的所有UV，或者如果你提供了选择，则应用于UV子集。 |
| **Scale Mesh UVs** | 将2D缩放应用于UVSet索引中的所有UV，或者如果你提供了选择，则应用于UV子集。 |
| **Rotate Mesh UVs** | 将2D旋转应用于UVSet索引中的所有UV，或者如果你提供了选择，则应用于UV子集。 |
| **Recompute Mesh UVs** | 基于不同类型的定义明确的UV岛状区，例如现有UV岛状区、多边形组或选择输入，重新计算网格体的UV。 |
| **Repack Mesh UVs** | 将现有UV岛状区打包到标准UV空间中。 |
| **Set Mesh UVs From Planar Projection** | 使用平面投影，为整个网格体或你通过选择输入所定义的子集设置UV。 |
| **Set Mesh UVs From Box Projection** | 使用盒体投影，为整个网格体或你通过选择输入所定义的子集设置UV。 |
| **Set Mesh UVs From Cylinder Projection** | 使用圆柱体投影，为整个网格体或你通过选择输入所定义的子集设置UV。 |
| **Auto Generate Patch Builder Mesh UVs** | 使用PatchBuilder方法计算新UV，并可选择打包。 |
| **Auto Generate X Atlas Mesh UVs** | 使用XAtlas计算新UV，并可选择打包。 |
| **Get Mesh UVSize Info** | 计算有关网格体（包括可选的网格体选择）UV通道的尺寸和面积的信息。 |
| **Get Mesh Per Vertex UVs** | 获取目标网格体中每个网格体顶点的单顶点UV的列表，从指定UV覆层派生。 |
| **Copy Mesh UV Channel To Mesh** | 将Copy From Mesh中的给定UVSet索引中的2D UV复制到Copy To UV Mesh中的3D顶点位置。 多边形组ID和材质ID保留在UV网格体中。 |
| **Copy Mesh To Mesh UV Channel** | 将"从UV网格体复制（Copy From UVMesh）"的3D顶点位置和三角形传输到通过"复制到网格体（Copy To Mesh）"的"目标UV集索引（To UV Channel Index）"识别的给定UV通道。 3D位置(X,Y,Z)将复制为UV位置(X,Y)。 |
| **Compute Mesh Local UV Param** | 围绕给定中心点/三角形在目标网格体顶点上计算本地UV参数化。 此方法使用离散指数贴图参数化，这会基于测地线距离和角度在本地将网格体展开。 中心点的UV值将是(0,0)，计算的顶点UV将使得 ` Length(UV) == 测地线距离` 。 |
| **Add UV Element To Mesh** | 将新的UV元素添加到网格体的指定UV通道，并返回新的UV元素ID。 |
| **Set Mesh Triangle UV Element IDs** | 在指定UV通道中为给定三角形设置UV元素ID，即UV三角形索引。 此函数不会创建新UV。 只有当生成的拓扑有效时，才能对UV三角形进行设置。 也就是说，不同的基础网格体顶点不能共享元素，因此它们必须要么未被其他任何三角形使用，要么已经与其他UV三角形中的相同网格顶点相关联。 如果有任何条件不满足，bIsValidTriangle将返回false。 |
| **Get Mesh Triangle UV Element IDs** | 返回指定UV通道中与三角形的三个顶点相关联的UV元素ID。 如果三角形不存在于网格体中，或没有在指定UV通道中为三角形设置过UV，bHaveValidUVs将返回false。 |
| **Get Mesh UV Element Position** | 返回指定UV通道中给定UV元素ID的UV位置。 如果UV通道或元素ID不存在，bIsValidElementID将返回false。 |
| **Set Mesh UV Element Position** | 在给定UV通道中设置指定ElementID的UV位置。 如果UV通道或元素ID不存在，bIsValidElementID将返回false。 |
| **Set UV Seams Along Selected Edges** | 将选择转换成边缘选择，并设置或移除所选边缘上的UV接缝。 |
| **Apply Texel Density UV Scaling** | 重新缩放网格体UV通道中的UV，以匹配由传入的选项所描述的指定纹素密度。 支持通过非空选择对UV子集进行处理。 |
| **Layout Mesh UVs** | 根据重排包选项，将指定UV通道中的现有UV岛状区重排到标准UV空间中。 |
| **Transfer Mesh UVs By Projection** | 通过沿请求的方向投影，将UV从一个网格体复制到另一个网格体。这不会传输UV接缝，它会为目标网格体选择中的每个顶点分配一个UV坐标。 |
| **Intersects UV Box 2D** | 测试两个Box2D边界是否相交，并可选择支持在封装的空间中工作。 |

## 多边形组

用于操控网格体的多边形组的函数。 多边形组是逐个三角形的整数，隐式定义建模工具和一些几何体脚本操作中三角形的区域和区块。 但是，多边形组层最终是逐个三角形的数字，并且你可以将其用于其他任意用途。 如需详细了解多边形组，请参阅[了解多边形组](https://dev.epicgames.com/documentation/assets/working-with-content/modeling-and-geometry-scripting/modeling-mode/understanding-polygroups)。

| 节点名称 | 说明 |
| --- | --- |
| **Get Has PolyGroups** | 如果网格体有标准多边形组层，则返回true。 |
| **Enable PolyGroups** | 启用网格体上的标准多边形组层。 |
| **Get Num Extended PolyGroup Layers** | 返回扩展多边形组层的数量。扩展多边形组层尚未受到所有运算或建模工具的完全支持。 |
| **Set Num Extended PolyGroup Layers** | 设置网格体上扩展多边形组层的数量。 |
| **Clear PolyGroups** | 将三角形多边形组分配重置为给定多边形组层的常量值。 |
| **Copy PolyGroups Layer** | 在不同层之间复制多边形组。 |
| **Convert UV Islands To PolyGroups** | 为网格体的每个断开连接的UV岛状区创建并分配新多边形组。 |
| **Convert Components To PolyGroups** | 为网格体的每个断开连接的组件创建并分配新多边形组。 |
| **Compute PolyGroups From Angle Threshold** | 基于边缘皱褶/开度角分隔网格体来设置多边形组。 |
| **Compute PolyGroups From Polygon Detection** | 识别多边形并分配多边形组ID。 |
| **Add Named Polygroup Layer** | 使用给定名称添加扩展的多边形组层。 如果网格体上已经存在具有该名称的层，则将返回该现有层并且不会添加新层。 |
| **按名称****查找扩展多边形组** | 按其名称查找扩展多边形组层。 如果有多个同名层，则返回第一个该等层。 |
| **Get PolyGroup Bounding Box** | 计算多边形组的边界。 |
| **GetPoly Group UV Bounding Box** | 计算多边形组的UV边界。 |
| **Get PolyGroup UV Centroid** | 计算多边形组的UV质心。 |

## 骨骼权重

这些函数将计算和操控骨骼权重，也称为皮肤权重。 骨骼权重将确定骨骼的变换对一组顶点的影响。 你还可以获取有关动态网格体中存储的骨架的信息。 在你通过**Copy Mesh From Skeletal Mesh**节点转换为动态网格体后，此信息会与骨骼网格体骨架一一对应。

| 节点 | 说明 |
| --- | --- |
| **Mesh Has Bone Weights** | 检查目标网格体是否具有每个顶点的骨骼权重属性集。 |
| **Mesh Create Bone Weights** | 在目标网格体上创建新的骨骼权重属性（如果尚不存在）。 如果其存在，且`bReplaceExistingProfile`作为true传递，则该特性将被移除并重新添加，以进行重设。 |
| **Get Max Bone Weight Index** | 确定网格体上存在的最大骨骼权重指数。 |
| **Get Vertex Bone Weights** | 返回目标网格体给定顶点处的骨骼权重的数组。 |
| **Get Largest Vertex Bone Weight** | 返回目标网格体给定顶点处的最大骨骼权重。 |
| **Set Vertex Bone Weights** | 设置目标网格体给定顶点处的骨骼权重。 |
| **Set All Vertex Bone Weights** | 将目标网格体的所有顶点设置为给定的骨骼权重。 |
| **Compute Smooth Bone Weights** | 计算给定网格体与提供的骨架的平滑皮肤绑定。 |
| **Transfer Bone Weights From Mesh** | 将骨骼权重从源网格体传输到目标网格体。 假定网格体已对齐。 否则，使用Transform Mesh几何体脚本函数进行对齐。 |
| **Copy Bones From Mesh** | 将骨骼属性（骨架）从源网格体复制到目标网格体。 |
| **Discard Bones From Mesh** | 废弃目标网格体中的骨骼属性（骨架）。 |
| **Get Bone Index** | 获取给定名称的骨骼的索引。 |
| **Get Root Bone Name** | 获取根骨骼的名称。 |
| **Get Bone Children** | 获取有关骨骼子项的信息。 |
| **Get All Bones Info** | 获取表示骨架的骨骼数组。 每个条目包含有关相应骨骼的信息。 |
| **Get Bone Info** | 获取给定名称的骨骼的索引。 |
| **Mesh Copy Bone Weights** | 从源配置中将所有骨骼权重复制到同一个网格体上的目标配置中，替换所有原有权重。 |
| **Blend Bone Weights** | 使用0-1之间（包括0和1）的Alpha值混合两个骨骼权重。 |
| **Prune Bone Weights** | 将给定骨骼从给定配置中的所有骨骼权重分配中移除。 |

## 网格体几何查询

这些函数用于对网格体进行高级别几何查询。

| 节点名称 | 说明 |
| --- | --- |
| **Get Mesh Bounding Box** | 计算网格体顶点的边界框。 |
| **Get Mesh Volume Area** | 计算网格体的体积和面积。 |
| **Get Is Closed Mesh** | 如果网格体是封闭的，例如没有拓扑边界边缘，则返回true。 |
| **Get Num Open Border Loops** | 返回开放边界循环的数量，例如网格体中的"孔洞"数量。 |
| **Get Num Open Border Edges** | 返回网格体中拓扑边界边缘的数量。 |
| **Get Num Connected Components** | 返回网格体中单独的连接组件数量，例如通过共同边缘连接的"三角形区块"。 |
| **Compute Mesh Convex Hull** | 计算给定网格体的凸包外壳，或你通过选择输入定义的网格体部分，并在单独的网格体中返回。 |
| **Compute Mesh Swept Hull** | 计算输入网格体的2D扫描外壳，并在单独的网格体中返回。 |
| **Compute Mesh Convex Decomposition** | 计算给定目标网格体的凸包外壳分解。 假定请求了多个外壳，将返回尝试近似表示网格体的多个外壳。 不能保证整个网格体会包含在外壳中。 |
| **Get Mesh Volume Area Center** | 计算网格体的体积、面积和质心。 |

## 网格体测地线

这些函数可计算网格体表面上的最短给定路径。

| 节点 | 说明 |
| --- | --- |
| **Get Shortest Vertex Path** | 计算一个顶点列表，表示约束为沿规定开始顶点和结束顶点之间的网格体三角形边缘行进的最短路径。 如果开始点和结束点在网格体的单独连接组件中，这可能会失败。 |
| **Get Shortest Surface Path** | 计算一个多边形路径，表示提供的网格体上两个规定点之间的最短网格体表面路径。如果开始点和结束点在网格体的单独连接组件中，这可能会失败。重心坐标格式为(a,b,c)，其中每个条目为正数，并且`a + b + c = 1`。如果提供的坐标无效，将使用值(1/3, 1/3, 1/3)。 |
| **Create Surface Path** | 计算一个多边形路径，表示一条"直"的表面路径，从网格体上的规定点开始，沿指示方向继续，直至到达请求的路径长度或遇到网格体边界，以先到者为准。重心坐标格式为(a,b,c)，其中每个条目为正数，并且`a + b + c = 1`。如果提供的坐标无效，将使用值(1/3, 1/3, 1/3)。此外，如果方向向量接近于零，将使用向上向量。 |

## 网格体池

用于调用和释放计算网格体池的函数。

| 节点名称 | 说明 |
| --- | --- |
| **Get Global Mesh Pool** | 访问全局计算网格体池（在首次访问时创建）。 |
| **Discard Global Mesh Pool** | 完全清理或摧毁当前全局网格体池，允许对其及其中所有网格体进行垃圾回收。 |
| **Request And Release Compute Mesh** | 请求计算网格体的宏，可通过With Mesh执行引脚使用，并在After Release执行引脚前自动将其释放。 |
| **Request And Release Compute Mesh From Global Pool** | 使用全局计算网格体池请求并释放计算网格体的宏。 |

## 简单多边形

简单2D多边形是没有孔洞的闭合多边形。 你可以使用这些函数调用和操控简单多边形。

| 节点 | 说明 |
| --- | --- |
| **Get Polygon Vertex Count** | 返回简单多边形中的顶点数量。 |
| **Get Polygon Vertex** | 返回简单多边形的指定顶点。 顶点索引将循环，即，-1表示多边形中的最后一个顶点。 如果多边形没有顶点，则返回零向量。 |
| **Set Polygon Vertex** | 设置简单多边形的指定顶点。 顶点索引将循环，即，-1表示多边形中的最后一个顶点。 如果多边形没有顶点，则不执行任何操作。 |
| **Add Polygon Vertex** | 设置简单多边形的指定顶点。 返回添加的顶点的索引。 |
| **Get Polygon Tangent** | 返回简单多边形的顶点切线。 顶点索引将循环，即，-1表示多边形中的最后一个顶点的切线。 如果多边形没有顶点，则返回零向量。 |
| **Get Polygon Arc Length** | 返回简单多边形的弧长。 |
| **Get Polygon Area** | 返回简单多边形所围的面积。 |
| **Get Polygon Bounds** | 返回简单多边形的边界框。 |
| **Convert Spline To Polygon** | 根据给定的取样选项，将`USplineComponent`中的位置 取样到简单多边形中。 |
| **Simple Polygon To Array Of Vector** | 返回带有多边形顶点位置的3D向量数组，其中Z坐标设置为0。 |
| **Simple Polygon To Array Of Vector2D** | 返回带有多边形顶点位置的2D向量数组。 |
| **Array Of Vector To Simple Polygon** | 返回根据3D位置向量数组创建的多边形，忽略Z坐标。 |
| **Array Of Vector2D To Simple Polygon** | 返回根据2D位置向量数组创建的多边形。 |

## 多边形列表

多边形列表包括一般多边形的列表，这些多边形可能有孔洞。 你可以使用这些函数调用和编辑多边形列表中的多边形。

| 节点 | 说明 |
| --- | --- |
| **Get Polygon Vertex Count** | 如果孔洞索引为-1，或在指定内孔洞中，返回多边形的外形状中的顶点数量。 对于无效多边形或孔洞索引，返回0。 |
| **Get Polygon Vertex** | 返回多边形的指定顶点，在孔洞索引为-1时为外多边形，否则为指定内孔洞。对于无效多边形或孔洞索引，或者如果多边形为空，顶点为零向量。 顶点索引将循环。 |
| **Get Polygon Count** | 返回多边形列表中的多边形数量。 |
| **Get Polygon Hole Count** | 返回多边形中的孔洞数量。 对于无效的多边形索引，返回0。 |
| **Get Polygon Vertices** | 返回多边形的顶点，孔洞索引为-1时为外多边形，否则为指定内孔洞。 对于无效的多边形或孔洞索引，输出顶点为空。 |
| **Get Polygon Area** | 返回多边形所围的面积。 对于无效的多边形索引，返回0。 |
| **Get Polygon Bounds** | 返回多边形的边界框。 对于无效的多边形索引，返回空的无效框。 |
| **Get Simple Polygon** | 返回多边形列表中的指定简单多边形，孔洞索引为-1时为外多边形，否则为指定内孔洞。 对于无效的多边形或孔洞索引，多边形为空。 |
| **Get Polygon List Area** | 返回多边形所围的面积。 |
| **Get Polygon List Bounds** | 返回多边形的边界框。 |
| **Create Polygon List From Single Polygon** | 创建单个多边形的多边形列表，带有可选的孔洞。 |
| **Add Polygon To List** | 将多边形添加到多边形列表，带有可选的孔洞。 返回添加的多边形的索引。 |
| **Create Polygon List From Simple Polygons** | 根据简单多边形的数组创建多边形列表。 |
| **Append Polygon List** | 添加"要附加到多边形列表的多边形"中的多边形。 |
| **Polygons Union** | 计算多边形列表中的所有多边形的并集。 还要解决每个多边形中的自相交。 |
| **Polygons Difference** | 计算多边形列表与要减去的多边形的差集。 |
| **Polygons Intersection** | 计算多边形列表与要相交的多边形的交集。 |
| **Polygons Exclusive Or** | 计算多边形列表与要异或的多边形的异或集。 |
| **Polygons Offset** | 将单个偏移应用于闭合多边形列表。 |
| **Polygons Offsets** | 将两个偏移按顺序应用于闭合多边形列表。 |
| **Polygons Morphology Open** | 将形态学开运算符应用于闭合多边形列表，首先按-Offset偏移，然后按+Offset偏移。 如果Offset为负数，这会转而按闭运算执行。 |
| **Polygons Morphology Close** | 将形态学关运算符应用于闭合多边形列表，首先按+Offset偏移，然后按-Offset偏移。 如果Offset为负数，这会转而按开运算执行。 |
| **Create Polygons From Path Offset** | 将偏移应用于单个开放2D路径，生成闭合多边形作为结果。 |

## 多边形路径

这些函数将执行多路径操控。 多路径是通过顶点排序定义的路径。

| 节点名称 | 说明 |
| --- | --- |
| **Get Poly Path Num Vertices** | 返回多路径中的顶点数量。 |
| **Get Poly Path Last Index** | 返回多路径中最后一个顶点的索引。 |
| **Get Poly Path Vertex** | 返回指定顶点的3D位置。 |
| **Get Poly Path Tangent** | 返回多路径中指定顶点索引处的本地切线向量。 |
| **Get Poly Path Arc Length** | 返回多路径的长度。 |
| **Get Nearest Vertex Index** | 返回3D中最接近指定点的多路径顶点的索引。 |
| **Flatten To 2D On Axis** | 废弃给定轴并使用其他两个坐标作为新的X、Y坐标，从而创建路径的2D展平副本。 |
| **Convert Spline To Poly Path** | 基于给定取样选项，从[USplineComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/USplineComponent?application_version=5.5)取样位置到多边形路径。 |
| **Convert Poly Path To Array** | 使用多路径顶点位置填充3D向量数组。 |
| **Convert Array To Poly Path** | 根据3D位置向量数组创建多路径。 |
| **Convert Poly Path To Array Of Vector 2D** | 使用投影到XY平面的多路径顶点位置创建2D向量数组。 |
| **Convert Array Of Vector 2D To Poly Path** | 根据2D位置向量数组创建多边形路径。 对应多路径顶点的Z坐标将为零。 |
| **Create Circle Path 3D** | 在XY平面上的原点附近创建闭合圆周，然后通过变换输入重新定位。 |
| **Create Circle Path 2D** | 在XY平面上的给定中心附近创建闭合圆周。对于闭合路径，结束顶点不是开始顶点的重复内容。 |
| **Create Arc Path 3D** | 在XY平面上的原点附近创建开放弧形，然后通过变换输入重新定位。 |
| **Create Arc Path 2D** | 在XY平面上的给定中心附近创建开放弧形。 |

## 网格体比较

这些函数用于比较两个网格体。 使用这些节点时不会修改任一网格体。

| 节点名称 | 说明 |
| --- | --- |
| **Is Same Mesh As** | 如果两个输入网格体按照输入选项定义的比较条件等同，则返回true。 |
| **Measure Distances Between Meshes** | 测量两个网格体之间的最小/最大和平均最近点距离。 |
| **Is Intersecting Mesh** | 如果两个输入网格体（带可选的变换）在几何上相交，则返回true。 |

## BVH和空间查询

这些函数将为网格体创建和查询包围体层级（BVH）对象。

| 节点名称 | 说明 |
| --- | --- |
| **Build BVH For Mesh** | 为网格体编译一个可以由**Is BVH Valid For Mesh**、**Rebuild BVH for Mesh**、**Find Nearest Point On Mesh**、**Find Nearest Ray Intersection With Mesh**和**Is Point Inside Mesh**节点使用的BVH对象。 该函数将返回几何体脚本动态网格体BVH结构体。 |
| **Is BVH Valid For Mesh** | 检查BVH对象是否仍可以用于网格体，如果网格体已更改，通常会返回false。 |
| **Rebuild BVH For Mesh** | 为网格体就地重新构建BVH对象，相较于构建新的BVH，这可以减少内存分配。 |
| **Find Nearest Point On Mesh** | 查找网格体/BVH上到给定3D点的最近点。 |
| **Find Nearest Ray Intersection With Mesh** | 查找3D光线与网格体/BVH的最近相交。 |
| **Is Point Inside Mesh** | 使用Fast Winding Number查询来测试某个点是否在网格体/BVH内。 |

## 工具

这些辅助函数很适合几何体脚本网格体处理和流程性生成器。

| 节点名称 | 说明 |
| --- | --- |
| **Create Dynamic Mesh Pool** | 创建新的动态网格体池对象。 |
| **Create Unique New Asset Path Name** | 根据给定基础路径和基础资产名称，创建新的唯一资产名称，这很适合**Create New Static Mesh Asset From Mesh**等函数。此节点仅适用于编辑器。 |
| **Get Mesh Info String** | 返回包含网格体统计数据和其他信息的调试字符串。 |
| **Sample Spline To Transforms** | 根据给定取样选项，将[USplineComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/USplineComponent?application_version=5.5)取样到[FTransforms](https://docs.unrealengine.com/en-US/API/Runtime/Core/Math/FTransform/)列表。 |

## 术语

| 术语 | 定义 |
| --- | --- |
| **Overlay** | 一种数据结构，表示应用于网格体的顶点数据的类型。这些类型包括：顶点颜色、法线、切线和UV。指定类型的多个值可以存储在单个顶点中。 在这种情况下，根据类型，会发生以下某个情况：使用最后一个值，对这些值取平均值，或使用任意值。 |
| **One-ring** | 所选顶点的相邻顶点，通过边缘连接。[单环三角形](https://dev.epicgames.com/community/api/documentation/image/c3203eea-c3f9-40c6-8ad6-6c26f2471110?resizing_type=fit)*顶点M的单环。* |
| **UV Set** | 包含网格体的UV坐标，也被称为[UV通道](../../../static-meshes/using-uv-channels-with-static-meshes/index.md)。 你也可以使用多个UV通道表示不同的[UV贴图](https://dev.epicgames.com/documentation/assets/working-with-content/modeling-and-geometry-scripting/modeling-tools/uvs-category#UVMap)。 |
| **Extents** | 盒体的半尺寸（沿三个轴测量）。 用于确定从中心点延伸多少。中心点C和范围E将生成一个盒体，该盒体最近的左下角位于`C - E`处，最远的右上角位于`C + E`处。 |

**h PolyGroup Boundary Edges**

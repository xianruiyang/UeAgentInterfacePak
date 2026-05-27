---
title: "将虚幻引擎内容导出为glTF格式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-unreal-engine-content-to-gltf"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "GL传输格式（glTF）", "将虚幻引擎内容导出为glTF格式"]
---

# 将虚幻引擎内容导出为glTF格式

> 路径：虚幻引擎5.7文档 / 管理内容 / GL传输格式（glTF） / 将虚幻引擎内容导出为glTF格式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-unreal-engine-content-to-gltf

使用 **glTF导出器** 将单个 **资产** 或当前 **关卡** 导出为下列格式之一：

| 格式 | 说明 |
| --- | --- |
| JSON `.gltf` | 包含以下元素，在你指定的目录中单独保存： **全场景说明：** 保存为JSON格式化、人工可读的UTF-8文本文件，扩展名为 `.gltf` 。 **纹理文件：** 保存到你指定的格式， `.png` 、 `.jpeg` ，等等。 **二进制数据文件：** 保存的单独文件，文件扩展名为 `.bin` 。 |
| Binary `.glb` | 将全场景说明、所有二进制数据和所有纹理合并为单个完全独立的二进制文件。 |

本页面说明如何从虚幻编辑器UI导出glTF文件。你还可以使用蓝图、Python脚本编写或C++从编辑器导出glTF文件。也可以在不使用编辑器的情况下进行运行时导出，但会受到一些限制。欲知详情，请参阅[编写glTF导出脚本](../scripting-gltf-exports/index.md)。

## 可以导出的内容

你可以将以下类型的资产导出为glTF文件：

- 静态网格体
- 骨骼网格体
- 动画序列
- 关卡
- 关卡序列
- 材质
- 关卡变体集

如需了解有关glTF导出器如何处理这些资产类型的更多信息，请参阅[glTF导出器如何处理虚幻引擎内容](../how-the-gltf-exporter-handles-unreal-engine-content/index.md)。

## 导出资产

如需将资产导出为glTF，请执行以下操作：

1. 在

   内容浏览器（Content Browser）

   中，右键点击你想导出的资产。
2. 在右键菜单中选择

   资产操作（Asset Actions）> 导出…（Export...）

   。界面上将打开文件保存对话框。
3. 在文件保存对话框中，为导出的文件选择名称和位置。确保将"另存为类型（Save as type）"设置为

   .gltf

   或

   .glb

   ，并点击

   保存（Save）

   。界面上将打开

   glTF导出选项（glTF Export Options）

   对话框。
4. 根据需要设置导出选项。如需了解更多信息，请参阅

   glTF导出选项参考

   。
5. 点击

   保存（Save）

   。

## 导出当前关卡

如需将当前关卡中的所有Actor导出为glTF，请执行以下操作：

1. 执行以下操作之一：

   - 在主菜单中选择 **文件（File）> 导出所有…（Export All…）** 。

     或
   - 在 **内容浏览器（Content Browser）** 中，右键点击关卡资产，然后从右键点击菜单中选择 **资产操作（Asset Actions）> 导出…（Export...）**

   界面上将打开文件保存对话框。
2. 在文件保存对话框中，为导出的文件选择名称和位置。确保将

   另存为类型（Save as type）

   设置为

   .gltf

   或

   .glb

   ，并点击

   保存（Save）

   。界面上将打开

   glTF导出选项（glTF Export Options）

   对话框。
3. 根据需要设置导出选项。如需了解更多信息，请参阅

   glTF导出选项参考

   。
4. 点击

   保存（Save）

   。

## 导出当前关卡的一部分

如需将当前关卡中选中的Actor导出为glTF，请执行以下操作：

1. 选择当前关卡中的一个或多个Actor。
2. 在主菜单中选择

   文件（File）> 导出所选项…（Export Selected...）

   。界面上将打开文件保存对话框。
3. 在文件保存对话框中，为导出的文件选择名称和位置。确保将

   另存为类型（Save as type）

   设置为

   .gltf

   或

   .glb

   ，并点击

   保存（Save）

   。界面上将打开

   glTF导出选项（glTF Export Options）

   对话框。
4. 根据需要设置导出选项。如需了解更多信息，请参阅

   glTF导出选项参考

   。
5. 点击

   保存（Save）

   。

## glTF导出选项参考

glTF导出选项（glTF Export Options）对话框包含以下选项：

- 通用选项
- 材质选项
- 网格体选项
- 动画选项
- 纹理选项
- 场景选项
- 变体集选项

### 通用选项

| 选项 | 说明 |
| --- | --- |
| **导出统一比例（Export Uniform Scale）** | 调整导出的资产比例，以补偿单位上的差异。默认值为 **0.01** ，即从虚幻引擎的默认单位厘米转换为glTF的默认单位米。 |
| **导出预览网格体（Export Preview Mesh）** | 启用后，glTF导出器将导出独立动画或材质资产的预览网格体。 |
| **跳过近默认值（Skip Near Default Values）** | 启用后，glTF导出器不导出与在glTF规范或glTF扩展的规范中指定的默认值近乎相等的基于浮点的JSON属性。这可以减少导出的JSON数据的大小。系统将跳过的属性视为已精确设置为其默认值。 |

### 材质选项

| 选项 | 说明 |
| --- | --- |
| **导出代理材质（Export Proxy Materials）** | 启用后，glTF导出器将检查每个导出的材质是否在其用户数据中定义了glTF代理材质。若是，导出器将导出代理材质，而不是转换原始材质。此设置不影响你直接（即你对其他材质所采用的引用方式）引用的glTF代理材质。如需了解更多信息，请参阅[glTF代理材质](../gltf-proxy-materials/index.md)。 |
| **导出无光照材质（Export Unlit Materials）** | 启用后，将正确导出使用无光照着色模型的材质。glTF导出器使用[KHR_materials_unlit](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_materials_unlit)扩展导出无光照材质。如需了解更多信息，请参阅[着色模型支持](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E7%9D%80%E8%89%B2%E6%A8%A1%E5%9E%8B%E6%94%AF%E6%8C%81)。 |
| **导出透明涂层材质（Export Clear Coat Materials）** | 启用后，将正确导出使用透明涂层着色模型的材质。 glTF导出器使用[KHR_materials_clearcoat](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_materials_clearcoat)扩展来导出透明涂层材质。 某些glTF查看器不支持KHR_materials_clearcoat。 如需了解更多信息，请参阅[着色模型支持](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E7%9D%80%E8%89%B2%E6%A8%A1%E5%9E%8B%E6%94%AF%E6%8C%81)。 |
| **烘焙材质输入（Bake Material Inputs）** | 指定是否将材质烘焙到纹理中，如是，如何烘焙。 **已禁用（Disabled）** ：从不使用材质烘焙，而仅依赖材质表达式匹配。 **简单（Simple）** ：如果材质输入需要烘焙，则仅使用简单平面作为网格体数据。 **使用网格体数据（Use Mesh Data）** ：如果材质输入使用特定于网格体的数据，比如顶点颜色、世界位置、向量变换节点，此设置会在材质烘焙过程中以及生成的纹理中包含该数据。若材质没有使用特定于网格体的数据，导出器将使用简单平面。 导出器仅会将烘焙用于复杂的材质输入。对于简单纹理或常量表达式，它会使用材质表达式匹配。 如需了解更多信息，请参阅[材质烘焙](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99)。 |
| **默认材质烘焙大小（Default Material Bake Size）** | 启用 **烘焙材质输入（Bake Material Inputs）** 后，此设置将指定包含材质输入的烘焙纹理的默认大小。 你以使用特定于材质和特定于输入的烘焙设置覆盖此默认设置。如需更多信息，请参阅以下小节： [配置特定输入的全局材质烘焙设置](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E8%BE%93%E5%85%A5%E7%9A%84%E5%85%A8%E5%B1%80%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E8%AE%BE%E7%BD%AE)。 [配置特定于资产的材质烘焙选项](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E4%BA%8E%E8%B5%84%E4%BA%A7%E7%9A%84%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E9%80%89%E9%A1%B9)。 |
| **默认材质烘焙筛选器（Default Material Bake Filter）** | 启用 **烘焙材质输入（Bake Material Inputs）** 后，此设置将指定默认筛选模式，用于对烘焙纹理取样。 你以使用特定于材质和特定于输入的烘焙设置覆盖此默认设置。如需更多信息，请参阅以下小节： [配置特定输入的全局材质烘焙设置](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E8%BE%93%E5%85%A5%E7%9A%84%E5%85%A8%E5%B1%80%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E8%AE%BE%E7%BD%AE)。 [配置特定于资产的材质烘焙选项](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E4%BA%8E%E8%B5%84%E4%BA%A7%E7%9A%84%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E9%80%89%E9%A1%B9)。 |
| **默认材质烘焙平铺（Default Material Bake Tiling）** | 启用烘焙材质输入后，此设置将指定默认寻址模式，用于对烘焙纹理取样。 你以使用特定于材质和特定于输入的烘焙设置覆盖此默认设置。如需更多信息，请参阅以下小节： [配置特定输入的全局材质烘焙设置](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E8%BE%93%E5%85%A5%E7%9A%84%E5%85%A8%E5%B1%80%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E8%AE%BE%E7%BD%AE)。 [配置特定于资产的材质烘焙选项](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E4%BA%8E%E8%B5%84%E4%BA%A7%E7%9A%84%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E9%80%89%E9%A1%B9)。 |
| **默认输入烘焙设置（Default Input Bake Setting）** | 覆盖通用默认值的输入特有默认烘焙设置。如需了解更多信息，请参阅[配置特定输入的全局材质烘焙设置](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%85%8D%E7%BD%AE%E7%89%B9%E5%AE%9A%E8%BE%93%E5%85%A5%E7%9A%84%E5%85%A8%E5%B1%80%E6%9D%90%E8%B4%A8%E7%83%98%E7%84%99%E8%AE%BE%E7%BD%AE)。 |

### 网格体选项

| 选项 | 说明 |
| --- | --- |
| **默认细节级别（Default Level Of Detail）** | 用于导出网格体的默认LOD级别。你可以使用组件或资产设置覆盖此设置。例如，最小或强制LOD级别。如需了解如何控制glTF导出器使用哪个LOD设置的更多信息，请参阅[细节级别（LOD）](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E7%BB%86%E8%8A%82%E7%BA%A7%E5%88%AB_lod_)。 |
| **导出顶点颜色（Export Vertex Colors）** | 指定是否导出顶点颜色。 如果你在材质选项（Material Options）中将 **烘焙材质输入（Bake Material Inputs）** 设置为 **使用网格体数据（Use Mesh Data）** ，导出器将自动为所有需要顶点颜色的材质烘焙这些颜色。 glTF格式始终使用顶点颜色作为基础颜色乘数，这通常会产生不理想的结果。我们建议在大多数情况下禁用此选项。 |
| **导出顶点皮肤权重（Export Vertex Skin Weights）** | 指定是否导出动画序列所需的骨骼网格体的顶点骨骼权重和顶点索引。 |
| **使用网格体量化（Use Mesh Quantization）** | 启用后，glTF导出器将对顶点切线和法线使用量化。此设置使用[KHR_mesh_quantization](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_mesh_quantization)扩展，这可能会导致某些glTF查看器无法加载网格体。如需了解有关网格体量化的更多信息，请参阅[高质量光照和反射的网格体量化](../how-the-gltf-exporter-handles-unreal-engine-content/index.md#%E9%AB%98%E8%B4%A8%E9%87%8F%E5%85%89%E7%85%A7%E5%92%8C%E5%8F%8D%E5%B0%84%E7%9A%84%E7%BD%91%E6%A0%BC%E4%BD%93%E9%87%8F%E5%8C%96)和[KHR_mesh_quantization文档](https://github.com/KhronosGroup/glTF/blob/main/extensions/2.0/Khronos/KHR_mesh_quantization/README.md#overview)。 |

### 动画选项

| 选项 | 说明 |
| --- | --- |
| **导出关卡序列（Export Level Sequences）** | 指定glTF导出器是否导出关卡序列。它只支持变换轨道。导出的关卡序列按关卡序列资产的 **序列显示速率（Sequence Display Rate）** （每秒帧数设置）播放。 |
| **导出动画序列（Export Animation Sequences）** | 指定glTF导出器是否导出骨骼网格体组件使用的单个动画资产。 如果你启用此设置，还必须在[网格体选项](#%E7%BD%91%E6%A0%BC%E4%BD%93%E9%80%89%E9%A1%B9)中启用 **导出顶点皮肤权重（Export Vertex Skin Weights）** 。 |

### 纹理选项

| 选项 | 说明 |
| --- | --- |
| **纹理图像格式（Texture Image Format）** | 指定导出的纹理将使用的图像文件格式。 **无（None）** ：导出器不导出纹理。 **PNG** ：导出器始终将纹理导出为 `.png` 文件。 **JPEG（若没有alpha）（JPEG (if no alpha)）** ：导出器会将没有Alpha通道的纹理作为 `.jpeg` 文件导出。如果纹理有Alpha通道，则导出器改为将其作为 `.png` 文件导出。 |
| **纹理图像质量（Texture Image Quality）** | 指定以有损图像格式导出的纹理的压缩级别。 你可以设置介于 **1** （最小压缩）和 **100** （最大压缩）之间的数值。 设置值 **0** 可使用该格式的默认压缩级别。对于 `.jpeg` 文件， **0** 相当于默认值 **85** 。 |
| **导出纹理变换（Export Texture Transforms）** | 启用后，glTF导出器将在 **Texture Coordinate** 表达式节点中导出UV平铺和取消镜像设置，用于简单的材质输入表达式。此设置导出器使用[KHR_texture_transform](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_texture_transform)扩展。 |
| **调整法线贴图（Adjust Normalmaps）** | 启用后，glTF导出器会翻转法线贴图中绿色通道的方向，以符合glTF规范。 |

### 场景选项

| 选项 | 说明 |
| --- | --- |
| **导出游戏内隐藏项（Export Hidden In Game）** | 指定是否导出在游戏中设置为隐藏的Actor和组件。 |
| **导出光源（Export Lights）** | 指定是否导出定向光源、点光源和聚光光源组件。此设置使用[KHR_lights_punctual](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_lights_punctual)扩展。 |
| **导出摄像机（Export Cameras）** | 指定是否导出摄像机组件。 |

### 变体集选项

| 选项 | 说明 |
| --- | --- |
| **导出材质变体（Export Material Variants）** | 指定是否以及如何导出能更改静态或骨骼网格体组件上的材质属性的材质变体。 **无（None）** **简单（Simple）** **使用网格体数据（Use Mesh Data）** |

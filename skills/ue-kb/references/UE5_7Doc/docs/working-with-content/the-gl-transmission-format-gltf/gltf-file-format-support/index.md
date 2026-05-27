---
title: "虚幻引擎中的glTF支持"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gltf-file-format-support-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "GL传输格式（glTF）", "虚幻引擎中的glTF支持"]
---

# 虚幻引擎中的glTF支持

> 路径：虚幻引擎5.7文档 / 管理内容 / GL传输格式（glTF） / 虚幻引擎中的glTF支持

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gltf-file-format-support-in-unreal-engine

**GL传输格式（glTF™）** 是一种可扩展的开放标准文件格式，由Khronos Group开发和维护。它设计用于创建可快速加载并完全表示场景的紧凑文件。glTF格式用于在广泛的应用程序之间共享丰富的3D内容，包括虚幻引擎、Twinmotion和Sketchfab，这些应用程序可以导入和导出glTF内容。

## 支持的glTF规范

虚幻引擎glTF导出器支持glTF 2.0规范。在本文档中，"glTF"专指glTF 2.0。

glTF 2.0独立于运行时的程度比之前版本更高。它仅依赖成熟的基于物理的渲染（PBR）工作流程。glTF软件生态系统中的大部分仅支持glTF 2.0。

## glTF文件格式

你可以导入和导出以下glTF格式：

| 格式 | 说明 |
| --- | --- |
| JSON `.gltf` | 包含以下元素，在你指定的目录中单独保存： **全场景说明：** 保存为JSON格式化、人工可读的UTF-8文本文件，扩展名为 `.gltf` 。 **纹理文件：** 保存到你指定的格式， `.png` 、 `.jpeg` ，等等。 **二进制数据文件：** 保存的单独文件，文件扩展名为 `.bin` 。 |
| Binary `.glb` | 将全场景说明、所有二进制数据和所有纹理合并为单个完全独立的二进制文件。 |

## glTF扩展

像glTF这样的格式，无法默认支持每种游戏引擎的每种功能。相反，你可以使用支持特定功能的扩展来扩展glTF基础模型（请参阅glTF GitHub存储库中的[关于glTF扩展](https://github.com/KhronosGroup/glTF/blob/main/extensions/README.md#about-gltf-extensions)了解详情）。

每个glTF扩展有唯一的名称。利用这些名称，应用程序可以识别glTF文件需要的所有扩展，无论应用程序是否支持所有这些扩展。

每个扩展名称的前缀表示扩展受支持的程度：

| 前缀 | 支持 | 说明 |
| --- | --- | --- |
| KHR | 经Khronos批准 | 受到广泛支持。KHR前缀保留，用于经Kronos批准的扩展名。 |
| EXT | 多供应商 | 受多个供应商（公司或应用程序）支持。 |
| 各种 | 供应商 | 主要受一个供应商（公司或应用程序）支持。使用特定于供应商的注册前缀，例如 `ADOBE` 或 `MSFT` 。其他公司或应用程序可能支持这些扩展，但不能保证。 |

### 扩展限制

并非所有应用程序都实现了每个glTF扩展。如果某个应用程序不支持某个扩展，它可能能够加载和显示glTF文件中不使用该扩展的部分。但是，如果glTF文件显式需要该扩展，应用程序将无法加载该文件。

### 虚幻引擎glTF导出器支持的扩展

为了支持虚幻引擎的许多功能，glTF导出器实现了以下扩展。你可以使用glTF导出选项中的各种设置将其中任意扩展打开和关闭。详情请查看[glTF导出选项参考说明](../exporting-unreal-engine-content-to-gltf/index.md#gltfexportoptionsreference)

#### Khronos扩展

| 扩展 | 支持 |
| --- | --- |
| [**KHR_lights_punctual**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_lights_punctual) | 点光源、聚光源和定向光源 |
| [**KHR_materials_unlit**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_materials_unlit) | 使用无光照着色模型的材质 |
| [**KHR_materials_clearcoat**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_materials_clearcoat) | 使用透明涂层着色模型的材质 |
| [**KHR_materials_variants**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_materials_variants) | 每个资产多个紧凑材质变体 |
| [**KHR_mesh_quantization**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_mesh_quantization) | 降低顶点数据的大小和精度 |
| [**KHR_texture_transform**](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_texture_transform) | 平铺和镜像纹理坐标 |

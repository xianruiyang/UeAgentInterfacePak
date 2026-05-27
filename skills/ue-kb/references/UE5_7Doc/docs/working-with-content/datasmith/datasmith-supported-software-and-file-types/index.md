---
title: "Datasmith支持的软件和文件类型"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/datasmith-supported-software-and-file-types"
breadcrumbs: ["Datasmith支持的软件和文件类型"]
---

# Datasmith支持的软件和文件类型

> 路径：Datasmith支持的软件和文件类型

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/datasmith-supported-software-and-file-types

下文列出了Datasmith当前支持的软件应用和文件格式。

对于下面列出的每一种类型的软件或文件格式，**状态**列使用下列图标来表示其完成度：

| 图标 | 含义 |
| --- | --- |
| [可供制作](https://dev.epicgames.com/community/api/documentation/image/418b1e98-0256-42d0-9b7b-a54b58adf4c7?resizing_type=fit) | 可供制作。 |
| [测试或实验性功能](https://dev.epicgames.com/community/api/documentation/image/7a555374-62e7-4822-bbf3-0654dd291d42?resizing_type=fit) | 测试或实验性功能，与客户共享用于测试和反馈。 期待改变，我们可以根据自己的判断废弃功能。 |

对于每一种类型的软件或文件格式，**工作流程类型（Workflow Type）**表明如何从设计软件中打包信息：

- **直接导出（Direct）**意味着虚幻引擎中的Datasmith导入插件会直接读取应用程序的文件格式。
- **导出（Export）**意味着在Datasmith将内容导入虚幻引擎之前，你需要使用已经内置到应用程序中的功能， 将应用程序中的内容导出为特定的文件格式。
- **导出插件（Export Plugin）**意味着你需要在应用程序中安装一个新插件，以便将设计数据导出为Datasmith导入虚幻引擎的格式。

**导入插件（Importer Plugin）**列指明了你需要在虚幻引擎项目中启用哪种Datasmith导入插件，才能导入对应的文件类型。 如需详细了解这一过程，请参阅[将Datasmith内容导入到虚幻引擎中](../datasmith-tutorials/importing-datasmith-content-into/index.md)

> [!TIP]
> 你可以在[Datasmith导出插件](https://www.unrealengine.com/en-US/datasmith/plugins)页面下载所有Datasmith导出器插件。

## 支持的应用程序

| 应用程序 | 支持程度 | 版本 | 工作流程类型 | 导入插件 |
| --- | --- | --- | --- | --- |
| **3D ACIS** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/c2765908-8508-40e4-ad6e-e164748ef066?resizing_type=fit) | 最高2023 | 直接 | **CAD** |
| **3DEXCITE DELTAGEN** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/969f9c89-931a-42ac-b26f-cf4d41500a53?resizing_type=fit) | 2017-2024 | 导出（仅FBX） | **FBX** |
| **ArcGIS CityEngine** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/181b5550-c918-4000-a6dd-d97b5f41e7f6?resizing_type=fit) | -- | 导出插件 | **Datasmith** |
| **Autodesk 3ds Max** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/62acea3d-ddf3-4940-9e1d-6795bb417769?resizing_type=fit) | 2016-2026 | 导出插件 | **Datasmith** |
| **Autodesk Alias** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/182d49fc-2a3c-4c08-a02a-b582f8d8aba9?resizing_type=fit) | 最高2025 | 直接 | **CAD** |
| **Autodesk AutoCAD** | [测试或实验性功能](https://dev.epicgames.com/community/api/documentation/image/8122aa9a-b0bf-4ec4-a8af-58f565946c4c?resizing_type=fit) | -- | 直接 | **CAD** |
| **Autodesk Inventor** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/c09fc79a-be37-4dcd-84c2-10c1719d0bee?resizing_type=fit) | 最高2025 | 直接 | **CAD** |
| **Autodesk Revit** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/4465097c-41f7-4cd6-bbc6-b7096879df5f?resizing_type=fit) | 2016.3–2023* | 导出插件 | **Datasmith** |
| **Autodesk Navisworks** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/578e30dc-9251-443e-969a-792905bd6b2e?resizing_type=fit) | 2019-2026 | 导出插件 | **Datasmith** |
| **Autodesk VRED** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/a01f55e8-e6b9-4597-a1b9-8251e9a76534?resizing_type=fit) | VRED Professional 2018–2026 | 导出插件 | **FBX** |
| **Dassault Systèmes CATIA V5** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/26394136-0c13-43c0-855c-c1921b5b7a62?resizing_type=fit) | 最高V5_6 R2024 | 直接 | **CAD** |
| **Dassault Systèmes SOLIDWORKS** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/bab76dc1-ded7-4400-9d31-7cba58735b13?resizing_type=fit) | 最高2025 | 导出插件 | **CAD** |
| **Dassault Systèmes SOLIDWORKS** | [测试或实验性功能](https://dev.epicgames.com/community/api/documentation/image/99493f93-d241-4b6e-8848-7b7c537a515a?resizing_type=fit) | 2020-2025 | 直接 | **Datasmith** |
| **Graphisoft Archicad** | [测试或实验性功能](https://dev.epicgames.com/community/api/documentation/image/6d8ef902-17aa-4e59-8165-2db74610bb06?resizing_type=fit) | 23-28 | 导出插件 | **Datasmith** |
| **Maxon Cinema 4D** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/d266625b-f321-4953-a83c-f96556def1fd?resizing_type=fit) | -- | 直接 | **C4D** |
| **McNeel Rhinoceros** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/6c4aeee2-7923-4327-a7c3-34c4caf828aa?resizing_type=fit) | 最高8 | 导出插件 | **Datasmith** |
| **McNeel Rhinoceros** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/cbe3daba-bcb7-486e-b00e-a5cb9b90e37d?resizing_type=fit) | 最高8 | 直接（`.3dm`文件） | **Datasmith** |
| **PTC Creo (Pro/ENGINEER)** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/a742203a-8836-46cb-84e4-af43db99e38d?resizing_type=fit) | Pro/Engineer 19.0至Creo 11.0 | 直接 | **CAD** |
| **Siemens NX** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/d6bdf5b4-5d12-479a-b444-c369461b9759?resizing_type=fit) | V11–V18、NX–NX12、NX1847–NX2412 | 直接 | **CAD** |
| **Trimble SketchUp Pro** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/dc93b9f1-0d95-4b10-a1c9-62032fe34f35?resizing_type=fit) | 2019-2025 | 导出插件、DirectLink | **Datasmith** |

> [!NOTE]
> * 从虚幻引擎5.3开始，Revit导出插件的新版本将由Autodesk管理，并直接在Revit 2024+中提供。 UE仍然支持此插件，你可以在下载页面获取旧版本插件。

## 支持的文件格式和标准

| 文件格式或标准名称 | 支持程度 | 版本 | 工作流程类型 | 导入插件 |
| --- | --- | --- | --- | --- |
| **3DXML** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/9da83a0a-aec4-40fc-aef4-88cf63b4be50?resizing_type=fit) | 最高V5-6 R2024 | 直接 | **CAD** |
| **工业基础类标准（IFC）** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/3e97114b-e0f2-4d3d-8fee-7d011300f040?resizing_type=fit) | IFC2x Editions 2-4, 4x3（测试版） | 直接 | **CAD** |
| **初始图形交换规范（IGES）** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/61c11735-0075-440c-9e2e-12ec2fb11b33?resizing_type=fit) | 5.1、5.2、5.3 | 直接 | **CAD** |
| **JT Open** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/2fc795d7-7d1d-475c-af6c-f91d37eedc26?resizing_type=fit) | 最高10.9 | 直接 | **CAD** |
| **Parasolid (x_t)** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/0b7a8d61-4dab-498a-9dd4-54e096dbfb9e?resizing_type=fit) | 最高37.1 | 直接 | **CAD** |
| **Siemens PLM XML** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/f670a85f-33d3-46b1-bec6-937df2ac3a9d?resizing_type=fit) | 7.0.3和更高版本（兼容TeamCenter 11或更高版本） | 直接 | **CAD** |
| **STEP** | [可供制作](https://dev.epicgames.com/community/api/documentation/image/aa0009cb-ad9f-49a5-90a3-77fa85d46b9c?resizing_type=fit) | AP203、AP214、AP242 Ed2和Ed3 | 直接 | **CAD** |

### MacOS导出插件

大多数**导出插件**以及虚幻编辑器中的所有Datasmith导入器，目前都只能在微软的Windows平台上使用。 从虚幻引擎4.27开始，我们还支持在macOS上从以下应用中导出内容：

| 应用程序 | 支持版本 |
| --- | --- |
| Trimble SketchUp Pro | 2019-2025 |
| Graphisoft Archicad | 23-28 |
| McNeel Rhinoceros | 6、7、8 |

## 虚幻引擎直接导出支持的格式

虚幻引擎为导入和导出FBX文件提供内置支持。

这些基于FBX的工作流程经过优化，以支持游戏需求，而游戏需求往往侧重于处理单个对象。 相比之下，Datasmith带来了整个场景，可能包含数千个对象，每个对象都有来自广泛来源的材质、枢轴、比例、层级和元数据。 但是，如果FBX导入管道适合你的需要，你应该可以随意使用它。 例如，你可以使用它来导入额外的场景布置，你将使用这些场景布置来在虚幻关卡中增强Datasmith内容。

欲了解详情，请参阅[FBX内容管线](../../fbx-content-pipeline/index.md)。

## 向后兼容性

我们可能会不时地需要更改Datasmith文件格式和导入器插件的行为，以添加新的功能。 因此我们不保证所有版本的虚幻引擎与所有版本的Datasmith导出插件之间的向后兼容性。 尽管旧版导出插件生成的`.udatasmith`文件可能可以导入新版虚幻引擎，但我们不建议这么做。

始终使用与虚幻引擎版本和导出文件需要使用的Datasmith插件版本相匹配的导出插件版本。 为了最大限度地利用Datasmith，并确保你从最新补丁和功能中获益，我们建议始终使用最新版本的导出插件和虚幻引擎。

---
title: "Datasmith支持的平台"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/datasmith-supported-platforms"
breadcrumbs: ["Datasmith支持的平台"]
---

# Datasmith支持的平台

> 路径：Datasmith支持的平台

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/datasmith-supported-platforms

本页面介绍当你通过Epic Games启动器下载虚幻引擎时，以及当你根据其源代码分发自行编译该引擎时，Datasmith的哪些功能可在哪些不同的平台上使用。

## 平台支持的文件格式

不同的Datasmith导入器内部使用的一些组件仅在选定的虚幻引擎平台上工作。

| 源格式 | 64位Windows | Mac OS X | Linux |
| --- | --- | --- | --- |
| **.udatasmith文件** | [支持](https://dev.epicgames.com/community/api/documentation/image/7814be8c-1378-45ce-b01a-4683f048c806?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/3794b9f1-93a1-43e0-8a43-e542a2121f19?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/dad9971a-340b-4051-bddf-d4576c08385b?resizing_type=fit) |
| **CAD文件格式** | [支持](https://dev.epicgames.com/community/api/documentation/image/1291a14b-a8ea-4052-a54f-07f899f1e611?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/78390979-5d2e-4d74-93d7-d702217bf4a0?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/931a979e-b09f-4072-a736-d72494f43f40?resizing_type=fit) |
| **Alias .wire** | [支持](https://dev.epicgames.com/community/api/documentation/image/23ca8085-648e-4fe6-a5ff-69d17db8a6d7?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/b3b212dd-b582-496d-ba7f-c8f1c460fbdd?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/4d85ad45-5897-4ddd-b31d-76d3862793c6?resizing_type=fit) |
| **Rhino** | [支持](https://dev.epicgames.com/community/api/documentation/image/ddc7cf5d-3415-491e-b0eb-98c2ae490dca?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/1fe1d2bc-8899-44e4-bf08-6ca59b6918f9?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/d041c421-be9f-44a9-9977-1f20a2eb686e?resizing_type=fit) |
| **Cinema 4D** | [支持](https://dev.epicgames.com/community/api/documentation/image/fcbf82fb-076c-457b-ad8b-1a1af148473e?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/8fa73cf9-1547-4d34-a156-0c43d6b2e246?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/664055e1-d4f4-4ea3-bdb2-43997b928abe?resizing_type=fit) |
| **AxF** | [支持](https://dev.epicgames.com/community/api/documentation/image/1f8914de-163d-48b2-b8fb-7123931613d5?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/a8d6515a-9818-418d-b58f-ce405a4dc18e?resizing_type=fit) | [不支持](https://dev.epicgames.com/community/api/documentation/image/5708cc43-fe86-484c-a67b-6c6954e0f030?resizing_type=fit) |
| **MDL** | [支持](https://dev.epicgames.com/community/api/documentation/image/4628f862-0047-477e-aa60-742d151afdb8?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/6931c510-35cc-4e5b-bc29-b06dfc294776?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/8db62eea-eb3e-44a3-90cc-41159615099e?resizing_type=fit) |
| **Deltagen和VRED** | [支持](https://dev.epicgames.com/community/api/documentation/image/ac87d539-dd90-485f-89af-041ae8b7fa4b?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/1635ba39-8c46-49e7-a330-1f2c2afb598e?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/793738e0-f2fe-4548-b01e-cc079fe5c701?resizing_type=fit) |

## 根据源代码重新编译虚幻引擎

Datasmith导入器内部使用的一些组件不能作为虚幻引擎源代码的一部分进行再分发。 因此，你无法借助对这些组件所提供功能的支持自行重新编译虚幻引擎。

当你根据虚幻引擎的源代码分发自行对其进行重新编译时，Datasmith导入插件支持以下格式：

| 源格式 | 可否重新编译？ |
| --- | --- |
| **.udatasmith文件** | [支持](https://dev.epicgames.com/community/api/documentation/image/790246e6-db29-4d25-8277-037d0d992158?resizing_type=fit) |
| **CAD文件格式** | [不支持](https://dev.epicgames.com/community/api/documentation/image/1eb0437d-b20b-4a9a-9556-c203d7b00b41?resizing_type=fit) |
| **Alias .wire** | [不支持](https://dev.epicgames.com/community/api/documentation/image/06aae770-50df-4c7d-9d00-e1ce7a07f5ed?resizing_type=fit) |
| **Rhino** | [不支持](https://dev.epicgames.com/community/api/documentation/image/58b1d9ed-d9ca-4a9f-9d0e-f09e36571e48?resizing_type=fit) |
| **Cinema 4D** | [不支持](https://dev.epicgames.com/community/api/documentation/image/ad3658c7-07be-4e4e-a547-d4eab85ae10f?resizing_type=fit) |
| **AxF** | [不支持](https://dev.epicgames.com/community/api/documentation/image/2435a80e-1886-4695-be64-c70b0ee2e9f8?resizing_type=fit) |
| **MDL** | [不支持](https://dev.epicgames.com/community/api/documentation/image/63e3860c-bee0-4c40-92ce-f233ac5e2525?resizing_type=fit) |
| **Deltagen和VRED** | [支持](https://dev.epicgames.com/community/api/documentation/image/d69e5dab-8e84-4e05-a2b8-a990ad8b5976?resizing_type=fit) |

> [!NOTE]
> 如果你从第三方下载并安装所需的软件开发工具包，则可以使用上面列出的一些不受支持的功能编译虚幻引擎。

> [!NOTE]
> UE现在默认支持gITF。

## Datasmith导出插件

[Datasmith导出插件](https://www.unrealengine.com/en-US/datasmith/plugins)下载页面上的Datasmith导出器插件预编译版本支持以下平台：

| 源应用程序 | 64位Windows | Mac OS X |
| --- | --- | --- |
| **SketchUp Pro** | [支持](https://dev.epicgames.com/community/api/documentation/image/e13b1809-6bce-4440-aba0-41ae03080987?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/faf9d1f1-beb5-4db3-828b-146bd986e63b?resizing_type=fit) |
| **3ds Max** | [支持](https://dev.epicgames.com/community/api/documentation/image/bcc086ba-44ce-4a99-bb91-b6927bf12c5c?resizing_type=fit) | 不适用* |
| **Revit** | [支持](https://dev.epicgames.com/community/api/documentation/image/7bfff7f0-6646-4d27-a3e7-3983ead0f8f1?resizing_type=fit) | 不适用* |
| **Navisworks** | [支持](https://dev.epicgames.com/community/api/documentation/image/1508a4da-e596-401c-8149-6daf1b6bfb1f?resizing_type=fit) | 不适用* |
| **Rhino** | [支持](https://dev.epicgames.com/community/api/documentation/image/5e459dcb-3a95-48cc-ab02-1c966ddd777a?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/efcdde39-b80d-42da-8953-089c94b48946?resizing_type=fit) |
| **Archicad** | [支持](https://dev.epicgames.com/community/api/documentation/image/f5f47176-7981-451a-a600-04b65aacba23?resizing_type=fit) | [支持](https://dev.epicgames.com/community/api/documentation/image/db36269a-9b7a-40bf-b4c8-3b283968ece7?resizing_type=fit) |
| **Solidworks** | [支持](https://dev.epicgames.com/community/api/documentation/image/a4d7abb0-6c43-49aa-a049-31358f0f70d6?resizing_type=fit) | 不适用* |

> [!NOTE]
> * 在macOS上不可用。

> [!NOTE]
> ** 从虚幻引擎5.3开始，Revit导出插件的新版本将由Autodesk管理，并直接在Revit 2024+中提供。 UE仍然支持此插件，你可以在下载页面获取旧版本插件。

当你根据虚幻引擎的源代码分发自行重新编译虚幻引擎时，可以重新编译Windows版Datasmith导出器插件。 但是，你需要从[Trimble](https://extensions.sketchup.com/en/developer_center/sketchup_sdk)或[Autodesk](https://www.autodesk.com/developer-network/overview)下载并安装源应用程序的SDK。

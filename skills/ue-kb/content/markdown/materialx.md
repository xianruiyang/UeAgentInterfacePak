# 交换MaterialX参考

---
title: "交换MaterialX参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/interchange-materialx-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "交换框架", "交换开发指南", "交换MaterialX参考"]
---

# 交换MaterialX参考

> 路径：虚幻引擎5.7文档 / 管理内容 / 交换框架 / 交换开发指南 / 交换MaterialX参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/interchange-materialx-reference-in-unreal-engine

**MaterialX** 格式是工业光魔（Industrial Light & Magic）在2012年开发的开源交换方法。这种方法不挑软件，可用于描述模式、纹理、着色器网络及其几何分配。**虚幻引擎（UE）** 使用以下标准支持[交换框架](../../index.md)中的MaterialX：

- Autodesk开发的标准表面着色（Standard Surface Shading）模型：
- 使用皮克斯开发的通用场景描述（USD）预览表面着色模型的

  USD

  工作流程。
- Adobe和Autodesk指定的OpenPBR着色模型。

> [!TIP]
> 在默认情况下，OpenPBR材质使用标准表明着色器。使用[Substrate材质](https://dev.epicgames.com/documentation/404)可以带来更好的材质保真度，因为它支持不透明和半透明材质。该功能目前属于实验性功能。

## 导入MaterialX文件

要将MaterialX文件导入虚幻引擎中，请使用标准[交换](../../importing-assets-using-interchange/index.md)导入流程。

![Importing a MaterialX File](../../../../../assets/images/0e/0e6d742a4c0c3d2d841a4a88c0a6158590deca771f7d80780bebc276ef8807bd.png)

将MaterialX文件导入关卡。

交换导入过程会导入图像数据并自动创建相应数量的材质。

## 编辑MaterialX导入设置

若要自定义MaterialX导入设置，你可以：

- 随时在虚幻引擎的

  项目设置（Project Settings）

  编辑器中操作。
- 在交换管线配置窗口中导入时操作。

如需详细了解如何使用交换管线配置窗口自定义设置，请参阅[交换导入参考](../interchange-import-reference/index.md)。

MaterialX导入设置位于 **项目设置（Project Settings）> 交换MaterialX（Interchange MaterialX）** 中：

![MaterialX Project Settings](../../../../../assets/images/23/23310cc22249722a253c00dd39fc2dbf266c2fcfacd12d3b7acb8f2422be0bc2.png)

MaterialX项目设置

| **选项** | **说明** |
| --- | --- |
| **标准表面（Standard Surface）** | 定义在解译Autodesk的标准表面着色器的数据时要使用的材质函数。 |
| **标准表面透射（Standard Surface Transmission）** | 定义在解译透明度的标准表面数据时要使用的材质函数。 |
| **表面无光照（Surface Unlit）** | 定义在解译无光照表面的标准表面数据时要使用的材质函数。 |
| **USD预览表面（USD Preview Surface）** | 定义在解译USD的表面着色器的数据时要使用的材质函数。 |
| **OpenPBR表面（OpenPBR Surface）** | 定义在解译OpenPBR表面着色器的数据时要使用的材质函数。 |
| **OpenPBR表面投射（OpenPBR Surface Transmission）** | 定义在解译透明度的OpenPBR表面数据时要使用的材质函数。 |

导入过程使用以下材质函数将MaterialX定义解译为虚幻着色器节点：

- MX_StandardSurface
- MX_TransmissionSurface
- MX_SurfaceUnlit
- MX_USDPreviewSurface
- MX_Surface
- MX_OpenPBR_Opaque
- MX_OpenPBR_Translucent
- MX_Substrate-StandardSurface-Opaque
- MX_Substrate-StandardSurface-Translucent
- MX_Substrate_OpenPBR_Opaque
- MX_Substrate_OpenPBR_Translucent

当导入的数据使用不受支持的着色器模型时，虚幻会尝试生成一个使用MX_Surface和其他受支持材质函数的着色器图表。

> [!NOTE]
> 这些材质位于以下虚幻引擎目录中：
>
> - Engine/Plugins/InterchangeFrameworkContent/Functions
> - Engine/Plugins/InterchangeFrameworkContent/Substrate
> - Engine/Content/Functions/Substrate

> [!WARNING]
> 不推荐编辑默认引擎材质函数。如果你需要自定义这些函数，请遵循以下步骤：
>
> 1. 创建你想编辑的材质函数的副本，并将此新函数移入项目的
>
>    Content
>
>    文件夹中。
> 2. 更改材质函数并保存。
> 3. 在
>
>    项目设置（Project Settings）> 交换MaterialX（Interchange MaterialX）
>
>    中选择新材质函数。


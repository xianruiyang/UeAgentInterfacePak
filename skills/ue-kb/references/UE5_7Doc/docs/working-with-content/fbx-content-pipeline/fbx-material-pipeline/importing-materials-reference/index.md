---
title: "材质导入参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/importing-materials-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "FBX内容管线", "FBX材质管道", "材质导入参考"]
---

# 材质导入参考

> 路径：虚幻引擎5.7文档 / 管理内容 / FBX内容管线 / FBX材质管道 / 材质导入参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/importing-materials-reference-in-unreal-engine

此参考指南中使用的参考图片来自 **3DS Max** 和 **Maya**。此参考指南只介绍3DS Max和Maya，但实际上您也可以使用其他3D建模程序。

> [!WARNING]
> 虚幻引擎FBX导入管线使用 **FBX 2020.2**。在导出时使用其他版本可能会导致不兼容。

选择3D美术工具

Autodesk Maya

Autodesk 3ds Max

## 支持的材质

虚幻引擎的FBX流程支持以下材质：

*表面* 各向异性 *Blinn* Lambert *Phong* Phone E

*标准* 多/子对象

> [!WARNING]
> 虚幻引擎的FBX流程只支持基础材质。不常见的贴图（纹理）类型将不会被导入。

## 材质命名

虚幻引擎对材质的命名与其来源的应用程序相关。

就Maya而言，虚幻编辑器中的材质名由Maya中应用到网格体的着色引擎命名转换而来。

![mat_name_maya.jpg](../../../../../assets/images/6f/6f2b410d9b3ccfac6d51eedb0664f4e286cda9258e8eb05cc3f311eeb13b7aee.jpg)

就3dsMax而言，虚幻编辑器中的材质名由3dsMax中应用到网格体的材质命名直接转换而来。

![mat_name_max.jpg](../../../../../assets/images/07/072783b14f6f8ef398f718c72e58fc8f1a5af95d077f1e0cebf3978bf91935a7.jpg)

## 材质排序

如需要对材质进行排序，可使用 ***_skin##** 命名规则指定导入材质的排序。

例如，对材质进行相应的命名即可形成排序：

- M_ExampleMesh_skin00
- M_ExampleMesh_skin01

## 导入带多个材质的网格体

虚幻引擎的FBX流程可导入带多个材质的网格体。

就网格体上使用多种材质而言，Maya非常简单明了。您只需选择想要对其应用材质的网格体表面，然后应用材质即可。

![mat_mult_maya.jpg](../../../../../assets/images/5b/5b89fec7e59d2221c40c81d386ae7d868effb7dc92d7c83a0866880011bcad3e.jpg)

![mat_mult_maya_result.jpg](../../../../../assets/images/d7/d725391c6c8f0be154cc49f3298403994aa639c30dfff98cc5ff011d842fbe99.jpg)

针对Maya中应用于网格体的每个材质，都将在虚幻编辑器中创建一个材质，导入的网格体对于其中每种材质都有对应的材质插槽。应用于网格体后，材质仅影响网格体的对应多边形，就像Maya中一样。

在3dsMax中，多个材质通过使用 **Multi/Sub-Object** 材质进行处理。网格体的每个面有一个_Material ID_，Multi/Sub-Object材质中的每个Standard材质应用于对应的_Material ID_。

![mat_multi_max.jpg](../../../../../assets/images/a1/a196df8710c4c7cff04e320a90404ef9c5f5f1a20422fc7ba8034859dce1b835.jpg)

![mat_multi_max_result.jpg](../../../../../assets/images/69/696a1e26115b5682529e66ca5e234cab1efecfd2632f9cb680aaa939f168935e.jpg)

针对Multi/Sub-Object材质中的每个Standard材质，都将在虚幻编辑器中创建一个材质，导入的网格体对于其中每种材质都有对应的材质插槽。应用于网格体后，材质仅影响网格体的对应多边形，就像3dsMax中一样。

## 导入纹理

如材质的纹理在3D程序中被指定为漫反射或法线贴图，只要 **导入纹理** 设置已启用，这些纹理都将被导入虚幻引擎。

# FBX内容管线

---
title: "FBX内容管线"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fbx-content-pipeline"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "FBX内容管线"]
---

# FBX内容管线

> 路径：虚幻引擎5.7文档 / 管理内容 / FBX内容管线

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fbx-content-pipeline

虚幻引擎支持以多种文件格式将内容导入项目。

FBX是一种灵活的文件格式，归Autodesk所有，可以提供数字内容创建（DCC）应用程序之间的互操作性。某些应用程序（例如Autodesk Motionbuilder）本身支持该格式。而Autodesk Maya、Autodesk 3ds Max和Blender等其他软件使用FBX插件支持该格式。

与其他导入方法相比，虚幻FBX导入通道的优点是：

- 对静态网格体、骨骼网格体、动画和变形目标使用单一文件格式。
- 在一次导入操作中导入多个LOD和Morph/Blendshape。
- 导入材质和纹理资产，并自动将它们应用到静态网格体。

> [!WARNING]
> 虚幻引擎FBX导入通道使用 **FBX 2020.2** 。在导出期间使用不同的版本可能会导致不兼容。

- [FBX动画流程](fbx-animation-pipeline/index.md) - 使用FBX内容通道设置、导出和导入骨架网格体的动画。

- [FBX资源元数据管线](fbx-asset-metadata-pipeline/index.md) - 描述如何通过FBX将定制的用户自定义属性导入虚幻引擎，以及如何使用蓝图和Python在虚幻编辑器中使用它们。

- [FBX导入选项参考](fbx-import-options-reference/index.md) - FBX导入选项对话框中可用选项的说明。

- [FBX材质管道](fbx-material-pipeline/index.md) - 有关使用FBX内容管道传输基本材质和纹理与网格体的指南。

- [FBX变换目标管线](fbx-morph-target-pipeline/index.md) - 使用FBX内容通道为骨架网格体创建和导入变换目标。

- [FBX场景导入](fbx-scene-import/index.md) - 使用Import Into Level（导入至关卡）将完整FBX场景导入虚幻引擎4。

- [骨架网格体管道](fbx-skeletal-mesh-pipeline/index.md) - 使用FBX内容通道设置、导出和导入骨架网格体。

- [FBX静态网格体管线](fbx-static-mesh-pipeline/index.md) - 使用FBX内容流程设置、导出和导入静态网格体。

- [FBX 导入错误](fbx-import-errors/index.md)


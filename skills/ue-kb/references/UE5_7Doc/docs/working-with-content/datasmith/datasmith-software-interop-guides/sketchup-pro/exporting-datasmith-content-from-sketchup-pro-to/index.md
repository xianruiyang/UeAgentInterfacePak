---
title: "从SketchUp Pro导出Datasmith内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-sketchup-pro-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "SketchUp Pro", "从SketchUp Pro导出Datasmith内容"]
---

# 从SketchUp Pro导出Datasmith内容

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / SketchUp Pro / 从SketchUp Pro导出Datasmith内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-sketchup-pro-to-unreal-engine

安装好SketchUp Datasmith导出器插件之后，导出场景时，就会出现一个新的文件类型—— *.UDATASMITH*。

为SketchUp安装完Datasmith插件后，会出现一个新的工具栏。

安装好SketchUp Datasmith导出器插件之后，保存或导出场景时，就会出现一个新的文件类型—— **Unreal Datasmith** （`.udatasmith`）。

请在SketchUp中执行以下步骤来使用该新文件类型导出场景。

1. 在SketchUp的 **文件（File）** 菜单中，选择 **导出（Export） > 3D模型（3D Model）**。
2. 在 **导出模型（Export Model）** 窗口中，从 **保存类型（Save as type）** 下拉列表中选择 **Unreal Datasmith**。
3. 浏览至要保存新文件的位置，设置其文件名，然后单击 **导出（Export）**。

### 最终结果

现在你可以尝试将新的 *.udatasmith* 文件导入到虚幻编辑器中。请参阅[将Datasmith内容导入到虚幻引擎中](../../../datasmith-tutorials/importing-datasmith-content-into/index.md)。

> [!NOTE]
> 除了新的 `.udatasmith` 文件以外，你还将看到名称与.udatasmith文件相同，但后缀为 `_Assets` 的文件夹。如果将 `.udatasmith` 文件移到新位置，请确保也将该文件夹移到相同的位置。

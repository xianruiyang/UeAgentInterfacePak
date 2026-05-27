# 从Revit导出Datasmith内容

---
title: "从Revit导出Datasmith内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-revit-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Revit", "从Revit导出Datasmith内容"]
---

# 从Revit导出Datasmith内容

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Revit / 从Revit导出Datasmith内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-revit-to-unreal-engine

安装Revit的Datasmith Exporter插件后，**插件（Add-Ins）** 条带中便有可用的新选项，用于将选定的3D视图导出到一个 *.udatasmith* 文件。

![Datasmith ribbon in Revit](../../../../../../assets/images/31/31504ef1890c6ce6b34d75f1dd6396974933d9921a1d6ceb2bb45565a1535e3e.png)

在Revit中执行以下步骤，导出场景使用此文件类型。

1. 在 **项目浏览器** 中选择需要导出的3D视图。

   ![Select a 3D View](../../../../../../assets/images/77/7741336cb12385d7c650c4cfcf374d28cd7fa30876bbc880124c421ddd98decf.png)

   Datasmith Exporter插件使用为当前3D视图定义的可视性设置来确定场景的哪些部分需要导出。欲知详情，请参见[Revit](../index.md)。
2. 打开 **Datasmith** 条带，然后点击 **导出3D视图（Export 3D View）**。

   ![Export 3D View button on the Datasmith toolbar](../../../../../../assets/images/71/7180ab0f921fcd5dec087e46ea7c5fa429d3980c4e4686d351bc6880d50058a2.png)
3. 在 **将3D视图导出到Unreal Datasmith（Export 3D View to Unreal Datasmith）** 窗口中，浏览到要保存 .udatasmith 文件的位置，然后使用 **文件名框** 来为新文件命名。

   ![Set the location and file name](../../../../../../assets/images/0f/0f54f92211ee07309bc474feceff21f97277da47ae29438929b76e5abe4338fb.png)
4. 点击 **保存**。

### 最终结果

现在便已准备好将新的 *.udatasmith* 文件导入到虚幻编辑器中。请参阅[将Datasmith内容导入到虚幻引擎中](../../../datasmith-tutorials/importing-datasmith-content-into/index.md)和部分。

> [!NOTE]
> 新的 *.udatasmith* 文件拥有一个命名相同的文件夹，但带有后缀 *_Assets*。如果将 *.udatasmith* 文件移动到一个新位置，则必须将此文件夹移动到相同位置。


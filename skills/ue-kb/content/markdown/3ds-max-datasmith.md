# 从3ds Max导出Datasmith文件

---
title: "从3ds Max导出Datasmith文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-files-from-3ds-max-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "3ds Max", "从3ds Max导出Datasmith文件"]
---

# 从3ds Max导出Datasmith文件

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / 3ds Max / 从3ds Max导出Datasmith文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-files-from-3ds-max-to-unreal-engine

你可以将 **3ds Max** 内容导出为 `.udatasmith` 文件并将其导入到 **虚幻引擎** 中。你可以导出完整场景，或特定内容。在这两种情况下， **Datasmith** 都只会导出在3ds Max中可见的对象。

> [!NOTE]
> 要将 `.udatasmith` 文件导入虚幻引擎，你的喜欢引擎项目必须启用了Datasmith导入器插件。如果没有启用该插件，你将无法在虚幻引擎中看到Datasmith选项。更多详情请参阅[启用Datasmith导入器插件](../index.md#%E5%90%AF%E7%94%A8datasmith%E5%AF%BC%E5%85%A5%E5%99%A8%E6%8F%92%E4%BB%B6)。

## 导出.udatasmith文件

你可以在3ds Max条带的Datasmith选项卡中进行以下操作：

1. 根据需要配置导出设置（详见下文中的

   导出设置

   一节。）
2. 如果你打算导出特定选项，请选择要导出的对象。如果你打算导出整个场景，请跳过此步骤。
3. 完成以下任一操作： a. 要导出完整场景，请点击

   导出（Export）

   。 a. 要导出当前选项，请点击

   导出选择项（Export Selected）

   。
4. 在

   导出Datasmith文件（Export Datasmith File）

   对话框中，选择导出文件的名称和位置。确保将

   另存为类型（Save as type）

   设置为

   Datasmith (*

   .udatasmith

   )

   并点击保存。

## 导出设置

所有的3ds Max导出设置都位于3ds Max条带的Datasmith选项卡中，包括文件导出（File Export）面板和设置（Settings）面板。

### 文件导出面板设置

展开文件导出面板将显示以下设置：

| 选项 | 说明 |
| --- | --- |
| 导出（Export） | 将3ds Max场景导出到 `.udatasmith` 文件。此类文件可以被导入虚幻引擎，或基于虚幻引擎的应用程序（如Twinmotion），或是虚幻引擎运行时应用程序。Datasmith自会导出可见的对象。 |
| 导出所选项（Export Selected） | 将3ds Max场景中当前被选中的对象导出到 `.udatasmith` 文件。此类文件可以被导入虚幻引擎，或基于虚幻引擎的应用程序（如Twinmotion），或是虚幻引擎运行时应用程序。Datasmith自会导出可见的对象。 |
| 动画变换（Animated Transforms） | 指定Datasmith如何处理带有3D变形动画的物体。 **仅当前帧（Current Frame Only）**：Datasmith会导出当前帧场景中的物体，不带有任何动画数据。 **活跃时间片段（Active Time Segment）**：Datasmith会导出物体3D变形动画在3ds Max时间轴活跃片段中的部分。 Datasmith导入器会将动画数据转换为[关卡序列](../../../../../animating-characters-and-objects/cinematics-and-movie-making/cinematic-workflow-guides-and-examples/creating-level-sequences-with-dynamic-transforms/index.md)，可以用于在虚幻引擎中播放。 |

### 设置面板设置

| 选项 | 说明 |
| --- | --- |
| 限制纹理分辨率（Limit Texture Resolution） | Datasmith将程序性纹理烘焙成图片用于导入虚幻引擎时，该设置用于指定烘焙图像中的最大像素数量。数值范围为4K（4096像素）到16M（16兆像素）。 比如，如果你将该数值设为4K，Datasmith会限制纹理像素，使其仅包含4096个像素。（64x64、128x32px等等）。 该设置不会影响栅格纹理的大小，比如指定为凹凸贴图的TIFF或者JPEG文件，以及漫反射贴图等等。 |
| 导出XRef场景（Export XRef Scenes） | 指定导出的 `.udatasmith` 文件中是否包含XRef场景。 XRef场景是你当前文件中外部引用的场景，但是从其它MAX文件临时加载。 要了解详情，请参考3ds Max文档的[XRef场景](https://knowledge.autodesk.com/support/3ds-max/getting-started/caas/CloudHelp/cloudhelp/2023/ENU/3DSMax-Manage-Scenes/files/GUID-5DB41A62-D7A5-4D54-AC83-5D03C9F7DB11-htm.html?us_oa=akn-us&us_si=9d8783af-02e1-4f82-be05-9f5d61f67e42&us_st=xref%20scene)。 |


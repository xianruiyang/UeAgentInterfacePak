# Datasmith 3ds Max UI

---
title: "Datasmith 3ds Max UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/the-datasmith-3ds-max-ui-for-exporting-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "3ds Max", "Datasmith 3ds Max UI"]
---

# Datasmith 3ds Max UI

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / 3ds Max / Datasmith 3ds Max UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/the-datasmith-3ds-max-ui-for-exporting-to-unreal-engine

## 3ds Max功能区

安装好Datasmith 3ds Max导出器插件之后，它会在3ds Max 功能区（参考3ds Max文档中的[使用功能区](https://knowledge.autodesk.com/support/3ds-max/getting-started/caas/CloudHelp/cloudhelp/2021/ENU/3DSMax-Basics/files/GUID-F2C0C6D6-968E-40F1-9474-5A7FC44FBC06-htm.html)）。中新增一个Datasmith选项卡。你可以在功能区中使用3ds Max的全部Datasmith工具和设置。

![Datasmith tab of the 3ds Max ribbon](../../../../../../assets/images/4a/4a2bb984f796792437c47e5f7e82bb3d49475d50d12220cdf58782cfebebbd75.png)

3ds Max功能区的Datasmith选项卡

1. Direct Link面板
2. 文件导出面板
3. 设置面板
4. 工具面板

### Direct面板

| 选项 | 说明 |
| --- | --- |
| 同步（Synchronize） | 将3ds Max场景或者选中的内容推送到本地Direct Link缓存目录。 虚幻引擎和其它目的地应用都会监视该缓存，并在检测到变动时更新导入到场景。 你可以修改Direct Link缓存目录的位置。要了解详情，请参考[修改Direct Link缓存目录](../using-direct-link-to-synchronize-3ds-max-and/index.md#changethedirectlinkcachedirectory)。 |
| 切换自动同步（Toggle Auto Sync） | 启用时，Datasmith会在你进行修改时自动将3ds Max场景推送到Direct Link缓存。 虚幻引擎在检测到缓存发生更改时便会重新进行导入。 |
| 连接（Connections） | 打开[Datasmith Direct Link连接状态窗口](#thedatasmithdirectlinkconnectionstatuswindow)。 |

### 文件导出面板

| 选项 | 说明 |
| --- | --- |
| 导出（Export） | 将3ds Max场景导出到 `.udatasmith` 文件。此类文件可以被导入虚幻引擎，或基于虚幻引擎的应用程序（如Twinmotion），或是虚幻引擎运行时应用程序。Datasmith自会导出可见的对象。 |
| 导出所选项（Export Selected） | 将3ds Max场景中当前被选中的对象导出到 `.udatasmith` 文件。此类文件可以被导入虚幻引擎，或基于虚幻引擎的应用程序（如Twinmotion），或是虚幻引擎运行时应用程序。Datasmith自会导出可见的对象。 |
| 动画变换（Animated Transforms） | 指定Datasmith如何处理带有3D变形动画的物体。 **仅当前帧（Current Frame Only）**：Datasmith会导出当前帧场景中的物体，不带有任何动画数据。 **活跃时间片段（Active Time Segment）**：Datasmith会导出物体3D变形动画在3ds Max时间轴活跃片段中的部分。 Datasmith导入器会将动画数据转换为[关卡序列](../../../../../animating-characters-and-objects/cinematics-and-movie-making/cinematic-workflow-guides-and-examples/creating-level-sequences-with-dynamic-transforms/index.md)，可以用于在虚幻引擎中播放。 |

### 设置面板

| 选项 | 说明 |
| --- | --- |
| 限制纹理分辨率（Limit Texture Resolution） | Datasmith将程序性纹理烘焙成图片用于导入虚幻引擎时，该设置用于指定烘焙图像中的最大像素数量。数值范围为4K（4096像素）到16M（16兆像素）。 比如，如果你将该数值设为4K，Datasmith会限制纹理像素，使其仅包含4096个像素。（64x64、128x32px等等）。 该设置不会影响栅格纹理的大小，比如指定为凹凸贴图的TIFF或者JPEG文件，以及漫反射贴图等等。 |
| 导出XRef场景（Export XRef Scenes） | 指定导出的 `.udatasmith` 文件中是否包含XRef场景。 XRef场景是你当前文件中外部引用的场景，但是从其它MAX文件临时加载。 要了解详情，请参考3ds Max文档的[XRef场景](https://knowledge.autodesk.com/support/3ds-max/getting-started/caas/CloudHelp/cloudhelp/2023/ENU/3DSMax-Manage-Scenes/files/GUID-5DB41A62-D7A5-4D54-AC83-5D03C9F7DB11-htm.html?us_oa=akn-us&us_si=9d8783af-02e1-4f82-be05-9f5d61f67e42&us_st=xref%20scene)。 |

### 工具面板

| 选项 | 说明 |
| --- | --- |
| 消息（Messages） | 打开[Datasmith消息窗口](#thedatasmithmessageswindow). |
| 添加Datasmith属性修改器（Add Datasmith Attributes Modifier） | 将一个Datasmith属性修改器应用到当前选中的物体。 Datasmith属性修改器中的选项可以用于自定义Datasmith导出特定物体的方式。要了解更多详情，请参考[每个物体的转换设置](../datasmith-per-object-conversion-settings-for-ex-d57c1b40/index.md)。 |

## Datasmith Direct Link连接状态窗口

Datasmith Direct Link连接状态窗口显示当前3ds Max实例与虚幻引擎或者其它基于虚幻引擎的应用（比如Twinmotion）之间的连接状态列表。

> [!TIP]
> 将鼠标悬停在列表上的项目中，可以显示当前连接的更多信息。

连接状态窗口还包含设置Direct Link缓存目录的相关选项。更多详情请参考[修改Direct Link缓存目录](../using-direct-link-to-synchronize-3ds-max-and/index.md#changethedirectlinkcachedirectory)。

![The Datasmith Direct Link Connection Status window](../../../../../../assets/images/95/95ad3af82f330233eb268c2f7a9db47f033004331b963bc6c7caaa66338172b6.jpg)

3ds Max中Datasmith Direct Link连接状态窗口

## Datasmith消息窗口

Datasmith消息窗口提供3ds Max导出到虚幻引擎的相关信息。当你导出场景或者选中内容时，消息窗口会显示一些导出相关的统计数据，并且报告内容中的任何问题。通常情况下，这些通知会对导出器无法正确转换，或者在虚幻引擎中显示有差异的内容发出警告。

![The Datasmith Messages window](../../../../../../assets/images/e9/e998983d5534c20cc84e036bf42c404bcea125dc7de849c5a823d39394ccb286.jpg)

3ds Max中的Datasmith消息窗口

### 为Direct Link启用统计数据

默认情况下，Datasmith消息窗口仅在导出 `.udatasmith` 文件时显示导出统计数据。要为Direct Link同步和自动同步启用统计数据，在MaxScript控制台窗口中输入以下指令：

`Datasmith_SetExportOption_StatSync true`


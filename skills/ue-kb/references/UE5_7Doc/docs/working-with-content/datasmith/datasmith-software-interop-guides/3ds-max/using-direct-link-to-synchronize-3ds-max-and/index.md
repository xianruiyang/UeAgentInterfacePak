---
title: "使用Direct Link同步3ds Max与虚幻"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-direct-link-to-synchronize-3ds-max-and-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "3ds Max", "使用Direct Link同步3ds Max与虚幻"]
---

# 使用Direct Link同步3ds Max与虚幻

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / 3ds Max / 使用Direct Link同步3ds Max与虚幻

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-direct-link-to-synchronize-3ds-max-and-unreal-engine

用于3ds Max的Datasmith导出插件支持Datasmith Direct Link（请参阅[使用Datasmith Direct Link](../../../datasmith-tutorials/using-datasmith-direct-link/index.md)）。Direct Link通过将3ds Max场景导出到本地缓存来运作。将3ds Max连接到虚幻引擎或连接到Twinmotion之类其他连接的应用程序，它会从缓存导入场景。

> [!NOTE]
> 要将3ds Max场景与虚幻引擎同步，你的虚幻引擎项目必须启用Datasmith导入器插件。如果你不启用该插件，在虚幻引擎中就看不到Datasmith选项。有关更多信息，请参阅"启用Datasmith导入器插件"。

要将3ds Max场景与虚幻引擎同步，请执行以下操作：

- 更新Direct Link缓存（请参阅

  更新Direct Link缓存

  ）。
- 使用Direct Link将3ds Max场景导入虚幻引擎中（请参阅

  使用Direct Link导入3ds Max场景

  ）。

> [!WARNING]
> 如果在更新缓存之前执行Direct Link导入，虚幻引擎将显示错误消息，因为缓存中没有可导入的内容。

## 更新Direct Link缓存

从3ds Max条带，使用Datasmith选项卡的Direct Link面板中的同步选项。

- **同步（Synchronize）** ：向Direct Link缓存执行一次性推送。虚幻引擎或其他连接的应用程序通过Direct Link连接到3ds Max时，它会导入缓存。

  如果你想控制虚幻引擎何时显示对3ds Max场景的更改，可使用此命令。
- **切换自动同步（Toggle Auto Sync）** ：启用后，Datasmith会在你每次做出更改时将3ds Max场景推送到Direct Link缓存。虚幻引擎和其他连接的应用程序会自动重新导入缓存。

  如果你希望虚幻引擎在你每次对3ds Max场景做出更改时更新，可使用此命令。

## 使用Direct Link导入3ds Max场景

1. 在3ds Max中，打开你想导入虚幻引擎中的场景，并

   更新Direct Link缓存

   。
2. 在虚幻引擎的主工具栏中，打开"创建（Create）"菜单并选择 **Datasmith > Direct Link导入（Direct Link Import）** 。 Direct Link导入 将打开"Direct Link可用源（Direct Link Available Sources）"对话框。

   > [!NOTE]
   > 如果你打开了多个3ds Max实例，每个实例将在"Direct Link可用源（Direct Link Available Sources）"对话框中显示为单独的源。
3. 选择你想导入虚幻引擎中的3ds Max源，然后点击"选择（Select）"。将打开文件对话框。
4. 选择项目中用于存储导入的内容的位置，然后点击"确定（OK）"。界面上将打开"Datasmith导入选项（Datasmith Import Options）"对话框。

   > [!TIP]
   > 要为你的Datasmith内容创建新的顶级文件夹，请右键点击文件对话框中的空白区域。要创建现有文件夹的子文件夹，请右键点击该文件夹。
5. 根据需要设置导入选项，然后点击"导入（Import）"。如需详细了解Datasmith导入选项，请参阅

   将Datasmith内容导入虚幻引擎中

   。

## 更改Direct Link缓存目录

当你使用Direct Link将3ds Max连接到虚幻引擎时，Datasmith将使用缓存目录临时存储你的Datasmith场景的内容。例如，收发的 `.udatasmith` 场景、网格体、纹理，等等。

你可以从[连接状态窗口](../the-datasmith-3ds-max-ui-for-exporting-to/index.md#datasmithdirectlink%E8%BF%9E%E6%8E%A5%E8%BF%9E%E6%8E%A5%E7%8A%B6%E6%80%81%E7%AA%97%E5%8F%A3)更改缓存目录：

1. 从3ds Max条带中

   Datasmith

   选项卡的

   Direct Link

   面板，选择

   连接（Connections）

   。界面上将打开

   连接状态（Connection Status）

   窗口。
2. 点击"更多选项"按钮（

   ⋮

   ），显示"缓存目录（Cache Directory）"设置。
3. 点击省略号按钮（

   ...

   ），打开文件对话框。
4. 找到你想使用的目录，然后点击

   选择文件夹（Select Folder）

   。

下次你打开或创建3ds Max文件并将其与虚幻引擎同步时，缓存位置会更新。

要将缓存重置为默认目录，请点击 **重置（Reset）** 。

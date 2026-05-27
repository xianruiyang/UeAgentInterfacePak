---
title: "导入glTF文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/importing-gltf-files-into-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "GL传输格式（glTF）", "导入glTF文件"]
---

# 导入glTF文件

> 路径：虚幻引擎5.7文档 / 管理内容 / GL传输格式（glTF） / 导入glTF文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/importing-gltf-files-into-unreal-engine

你可以像导入其他类型的内容一样，将 **glTF** 内容导入到虚幻引擎中。你可以导入整个场景或特定资产。

你可以导入以下glTF格式：

| 格式 | 说明 |
| --- | --- |
| JSON `.gltf` | 包含以下元素，在你指定的目录中单独保存： **全场景说明：** 保存为JSON格式化、人工可读的UTF-8文本文件，扩展名为 `.gltf` 。 **纹理文件：** 保存到你指定的格式， `.png` 、 `.jpeg` ，等等。 **二进制数据文件：** 保存的单独文件，文件扩展名为 `.bin` 。 |
| Binary `.glb` | 将全场景说明、所有二进制数据和所有纹理合并为单个完全独立的二进制文件。 |

## 从glTF文件导入单独的资产

你可以像导入其他资产一样，将glTF资产导入到虚幻引擎中。

1. 在

   内容浏览器（Content Browser）

   中，执行以下某项操作：

   - 在

     +添加（Add）

     菜单中，使用

     导入到（Import to）

     命令。如需详细说明，请参阅

     从内容浏览器导入

     。
   - 将glTF资产拖放到内容浏览器中。如需详细说明，请参阅

     使用拖放导入

     。 你使用的任意工作流程都将打开

     交换管线配置（导入内容）（The Interchange Pipeline Configuration (Import Content)）

     对话框。
2. 根据需要设置导入选项，然后点击

   导入（Import）

   。

## 将glTF场景导入到虚幻引擎关卡中

你可以遵照导入FBX等其他场景格式的相同导入工作流程，将完整glTF场景导入到虚幻引擎中。

1. 从主菜单，选择

   文件（File）> 导入到关卡中（Import Into Level）

   。
2. 选择包含你想导入的场景的 `.gtlf` 或 `.glb` 文件，然后点击"打开（Open）"。

   这将打开 **选择用于导入场景内容的位置（Choose location for importing scene content）** 对话框。
3. 选择你的虚幻引擎项目中的目标文件夹，然后点击"确定"。

   将打开 **交换管线配置（导入内容）（Interchange Pipeline Configuration (Import Content)）** 对话框。
4. 根据需要设置导入选项，然后点击

   导入（Import）

   。

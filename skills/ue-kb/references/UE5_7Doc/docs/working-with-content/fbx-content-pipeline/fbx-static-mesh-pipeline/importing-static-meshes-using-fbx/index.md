---
title: "使用FBX方法导入静态网格体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/importing-static-meshes-using-fbx-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "FBX内容管线", "FBX静态网格体管线", "使用FBX方法导入静态网格体"]
---

# 使用FBX方法导入静态网格体

> 路径：虚幻引擎5.7文档 / 管理内容 / FBX内容管线 / FBX静态网格体管线 / 使用FBX方法导入静态网格体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/importing-static-meshes-using-fbx-in-unreal-engine

选择操作系统：

Windows

macOS

Linux

可从外部 3D 建模程序（如 **3DS Max**、**Maya** 或 **Blender**）将静态网格体导入到虚幻引擎。我们在此使用 3DS Max 和 Maya 进行演示，实际上您可将 **静态网格体** 从任何带保存功能的 3D 建模程序中导入虚幻引擎。

> [!NOTE]
> 在开始之前，请确保你有可供使用的3D建模应用程序。

## 目标

此指南的要点是为您展示如何从外部 3D 建模程序导入静态网格体。

## 目的

完成此指南的阅读后，您将了解：

- 如何将静态网格体从外部 3D 建模程序导入虚幻编辑器。
- 如何验证静态网格体已正常导入。

> [!WARNING]
> 虚幻引擎FBX导入管线使用 **FBX 2020.2**。在导出时使用其他版本可能会导致不兼容。

选择3D美术工具

Autodesk Maya

Autodesk 3ds Max

## 从外部 3D 建模程序导入静态网格体

1. 在视口中选中要导出的网格体和关节。

   ![meshAndJointsSel.png](../../../../../assets/images/41/4174d71925bcb788f2acc0ff48cc2b541ee575959a230f1d697b38d635813c40.jpg)
2. 在 *文件（File）* 菜单中选择 *导出选中项（Export Selection）*（或者如果你不管选中项是什么，都想导出场景中的所有资源，那就选择 *导出所有（Export All）*）。

   ![maya_export_2.jpg](../../../../../assets/images/59/598962e4ac48cda15aec8cdae35ed486f6e0c09af45e8760e32280125ee33be9.jpg)
3. 选择用于导入网格物体的FBX文件的位置和名称，并在 **FBX导出（FBX Export）** 对话框中设置适当的选项，然后单击maya_export_button.jpg按钮，创建包含网格体的FBX文件。

   ![maya_export_3.jpg](../../../../../assets/images/c6/c67b9e48b39f93d5c38f1d436c566a202ed6c401ea5e862d4eec6ce2e60c4d59.jpg)

1. 在视口中选中要导出的网格体和骨骼。

   ![max_export_1.png](../../../../../assets/images/02/02ef8fe6e606dc9c0a949eac86d03c1dfd54c11ace20934b50f7725554ed620f.jpg)
2. 在 *文件（File）* 菜单中选择 *导出选中项（Export Selected）*（或者如果你不管选中项是什么，都想导出场景中的所有资源，那就选择 *导出所有（Export All）*）。

   ![max_export_2.jpg](../../../../../assets/images/86/863bb6f9e849b1d8fe6acee051240a15537a604c51d8d6a3079405e51893256b.jpg)
3. 选择用于导入网格体的FBX文件的位置和名称，并单击max_save_button.jpg按钮。

   ![max_export_3.jpg](../../../../../assets/images/f8/f8b8bd7b9e4b88607d85dbd323d065ddd5f4ffa5f051fccc9465e1041382c834.jpg)
4. 在 **FBX导出（FBX Export）** 对话框中设置适当的选项，然后单击max_ok_button.jpg按钮，创建包含网格体的FBX文件。

   ![max_export_4.jpg](../../../../../assets/images/53/53ebca532dd8c305acc984192c652ecd5a760c37c6b607cf9431887ede43174c.jpg)

## 验证导入的静态网格体

双击导入的网格体在 **静态网格体编辑器** 中进行查看。

![Verify Static Mesh](../../../../../assets/images/a5/a54e77048aca94dd2d250f60b115454bf39a22535182eede3f2ed4e874b7f367.jpg)

点击查看大图。

> 图片已省略：Verify Static Mesh

点击查看大图。

*在 **静态网格体编辑器** 中查看导入的网格体，验证资源是否导入正常。*

这便是该指南的全部内容，您已从中学习到：

✓ 如何将静态网格体从外部 3D 建模程序导入虚幻编辑器。 ✓ 如何验证静态网格体已正常导入。

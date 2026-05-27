# 使用FBX方法导入静态网格体LOD

---
title: "使用FBX方法导入静态网格体LOD"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/importing-static-mesh-lods-using-fbx-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "FBX内容管线", "FBX静态网格体管线", "使用FBX方法导入静态网格体LOD"]
---

# 使用FBX方法导入静态网格体LOD

> 路径：虚幻引擎5.7文档 / 管理内容 / FBX内容管线 / FBX静态网格体管线 / 使用FBX方法导入静态网格体LOD

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/importing-static-mesh-lods-using-fbx-in-unreal-engine

可从外部 3D 建模程序（如 **3DS Max**、**Maya** 或 **Blender**）将静态网格体细节级别（LOD）导入到 **虚幻引擎** 。我们在此使用 3DS Max 和 Maya 进行演示，实际上您可将静态网格体 LOD 从任何带保存功能的 3D 建模程序中导入虚幻引擎。

### 先决条件

- 拥有一种3D建模应用程序的访问权限。
- 拥有创建了LOD的模型。

### 目的

完成此指南的阅读后，您将了解：

- 如何从外部 3D 建模程序设置静态网格体 LOD。
- 如何从外部 3D 建模程序导出静态网格体 LOD。
- 如何将静态网格体 LOD 从外部 3D 建模程序导入虚幻编辑器。

> [!WARNING]
> 虚幻引擎FBX导入管线使用 **FBX 2020.2**。在导出时使用其他版本可能会导致不兼容。

选择3D美术工具

Autodesk Maya

Autodesk 3ds Max

## 设置静态网格体 LOD

1. 按照从基础LOD到最后一个LOD的顺序，选择所有网格体。选择顺序非常重要，这可以确保以正确的复杂度顺序添加LOD。然后在 *编辑（Edit* 菜单下选择 *细节级别（Level of Detail）* > 群组（Group）命令。

![Maya LOD Export Select](../../../../../assets/images/32/32cec02856e91b93137d484a89b569f300dc211443bf779b4cd31d1b244cd8ab.png)

点击查看大图

1. 现在，所有网格体都被划入了LOD群组下。

![Maya LOD Group in Outliner](../../../../../assets/images/ca/ca2c6d2ee6f61c3158453c9e29ff5c40f634bf260d73485b67d01badff36cb66.png)

点击查看大图

1. 选择所有LOD网格体（顺序不重要），然后选择 *群组（Group）* 菜单下的 *群组（Group）* 命令。

![3ds Max Group LODs](../../../../../assets/images/13/130090c0d5f13d311b8f93fc59326e6713e7c8cc467a1eb1120748fa336ebe91.png)

点击查看大图

1. 在打开的对话框中输入新群组名称，然后点击3ds LOD Ok Button按钮创建群组。

![3ds Max Group Name](../../../../../assets/images/e9/e9d78ad7080d8292c74d4e6b7fc9015f2c361df4dd0633572da25a919f742a00.jpg)

点击查看大图

1. 点击3ds Max Utility Button按钮，浏览 *工具（Utilities）* 面板，然后选择 *细节级别（Level of Detail）* 工具。**注意**：你可能需要点击max_utility_more_button.jpg并在列表中选择它。

![3ds Level of Detail Utility](../../../../../assets/images/89/89a1241c509bed2e5562dc6ff1444abde4431b356b273b4b88404a4094ddd49f.png)

点击查看大图

1. 选中群组后，点击max_lod_create_button.jpg按钮新建LOD集，并将所选群组中的网格体添加到该集。系统会根据网格体的复杂度对其自动排序。

![3ds Max LOD List](../../../../../assets/images/d8/d8819a8fbccf0d4eef2215bcb7ea58776d189e5bb9fd603a30f0e678235409e5.png)

点击查看大图

## 导出静态网格体 LOD

1. 在Maya中选择LOD群组以及所有碰撞几何体。

   ![Maya LOD Export Select](../../../../../assets/images/16/16023c8180b207ec088f0650346c3e74b6f64b367ecfd7b6f28780f8a54990bd.png)

   点击查看大图。
2. 前往文件菜单并选择导出选择（Export Selection）。

   ![Maya Export Selection](../../../../../assets/images/d8/d88c84851a72c412a344adc0012ac305a8e302eee321217b61991e37da889fad.png)

   点击查看大图
3. 选择网格体的保存路径。确认为其命名，选择FBX作为文件格式，并在FBX导出器属性中启用导出动画。要想导出LOD，就必须启用导出动画。

   > 图片已省略：[Maya Save Export

   点击查看大图

   1. 在3ds Max中选择包含LOD集和所有碰撞几何体的网格体群组。

      > 图片已省略：Maya LOD Export Select

      点击查看大图
   2. 前往文件菜单，选择 *导出（Export）* > *导出选择（Export Selected）*。

      > 图片已省略：3ds Max Export Selection

      点击查看大图
   3. 选择网格体的保存路径。确认为其命名，选择FBX作为文件格式，然后保存。

      > 图片已省略：[3ds Max Save Export

      点击查看大图
   4. 在FBX导出窗口中，启用"动画（Animation）"属性下的"动画"选项。要导出LOD必须启用此项。

      > 图片已省略：3ds Max Enable Animation on Export

      点击查看大图

      ## 导入静态网格体 LOD

      导入静态网格体LOD的方法不止一种。其中之一是使用 *内容浏览器*（如下图所示）。另一种方法是使用 *静态网格体编辑器* 中的 *细节* 面板。如需了解如何用静态网格体编辑器导入LOD，请参阅[C创建与使用LOD](../../../static-meshes/creating-and-using-lods/index.md)一文。

      1. 在 **内容浏览器** 中点击 **Import** 按钮。

         > 图片已省略：Import Button

         点击查看大图。
      2. 找到并选择需要导入的 FBX 文件。

         > 图片已省略：Import Dialog Box

         点击查看大图。
      3. 点击 **打开（Open）** 开始导入网格体文件到项目。
      4. 在 **FBX导入选项（FBX Import Options）** 对话框中，选择合适的设置，确保 **网格体（Mesh）** > **高级（Advanced）** 下的 **导入LOD（Import LODs）** 选项已启用。

         > 图片已省略：Import FBX Option

         点击查看大图。

      在FBX导入器中，有两个导入按钮供我们使用。第一个是"导入（Import）"按钮，允许将当前选定的FBX文件按照指定设置导入。第二个是"全部导入（Import All）"，允许将当前选中的所有FBX文件按照指定设置导入。

      > [!NOTE]
      > 有关FBX导入器设置的更多信息，请参阅[FBX导入选项参考](../../fbx-import-options-reference/index.md)一文。

      1. 点击 **Import** 或 **Import All** 将网格体导入项目。

         > 图片已省略：Import FBX Dialog Box

         点击查看大图。

         > [!NOTE]
         > 导入 LOD 时，导入网格体的命名将遵循默认 [命名规则](../../fbx-import-options-reference/index.md#namingconventions)。在 [FBX 导入对话](../../fbx-import-options-reference/index.md) 文档中可查阅全部设置的更多信息。
      2. 导入的网格体以及其应用的纹理和材质将显示在 **内容浏览器** 中。

         > 图片已省略：Imported Static Mesh

         点击查看大图。
      3. 双击静态网格体打开 **静态网格体编辑器**。在 **静态网格体编辑器** 中查看导入的网格体时，使用 **Auto LOD** 下拉菜单循环选择网格体 LOD。

      这便是该指南的全部内容，您已从中学习到：

      ✓ 如何从外部 3D 建模程序设置静态网格体 LOD。 ✓ 如何从外部 3D 建模程序导出静态网格体 LOD。 ✓ 如何将静态网格体 LOD 从外部 3D 建模程序导入虚幻编辑器。


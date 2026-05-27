---
title: "Paper 2D Flipbooks"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper-2d-flipbooks-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D Flipbooks"]
---

# Paper 2D Flipbooks

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D Flipbooks

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper-2d-flipbooks-in-unreal-engine

![The best way to think of Paper 2D Flipbooks is in the form of hand-drawn animation](../../../../assets/images/a9/a98f3ee3a4fad266b58ad5f5aebf22bb37e92a23dc82a125c842a53ec0a408de.png)

理解 **Paper 2D Flipbooks** （简称 **Flipbooks**）的最佳方式是把它看做一种手绘动画的表现形式。原理是一系列有细微不同之处的图片快速"翻过"，从而产生动画的效果。在虚幻引擎中，Flipbooks由一系列关键帧组成，每帧均包含一个需要展示的[Sprite](../paper-2d-sprites/index.md) 和展示时长（以帧数为单位）。 **每秒帧率** 选项将决定帧的播放速度，确定每秒中存在多少动画"节奏"；可在 **细节** 面板中编辑关键帧，或使用 **Flipbook编辑器** 下方的 **时间轴** 进行编辑。

## 创建一个Flipbook

可通过多种方法进行Flipbook的创建。可创建一个需自行填入sprite的空白Flipbook或基于一系列选中的sprite自动生成一个Flipbook。

> [!NOTE]
> 可导入一个JSON格式化sprite表单描述，它将导入相关纹理并为描述的帧创建sprite和一个Flipbook。查看 [Paper 2D 导入选项](../import-sprites/index.md) 中的详细内容。

### 空白Flipbooks

可通过下列方法创建一个空白 Flipbook。

**打开内容浏览器**：

1. 点击 **新建** 按钮，然后在 *动画* 的快捷菜单下选择 **纸质 Flipbook** 选项。

   ![In the context menu under Animation select the Paper Flipbook option](../../../../assets/images/e6/e620bbfa9d1c6fee4b07d34ea0db78b1c4648ea1d435a0371bd8877725ecb56a.jpg)

   > [!NOTE]
   > 除点击 **新建** 外，也可在 **内容抽屉** 中 **单击右键** 打开快捷菜单。
2. 弹出输入新Flipbook名称的提示。

   ![New Flipbook](../../../../assets/images/c1/c1f445a4ade2d3b371e7a3a91505ce4b082874f9fcf6622cad7626a75cb92d1c.png)
3. 选定名字之后，Flipbook资产便已成功创建。

   ![Your Flipbook asset has been created](../../../../assets/images/aa/aadcece7f9d0b410cc13253b62c77f7478df5600f10ab530578be85436e0e39f.png)

   左下角的星号提醒资源尚未保存，保存成功后将自动消失。

### 自动生成Flipbooks

以下是创建自动生成 Flipbook 的步骤。

**打开内容抽屉**：

1. 在 **内容抽屉**.中找到并选择需要被加入Flipbook的每个sprite。

   ![Locate and select each of the sprites you would like to include in the Flipbook in the Content Drawer](../../../../assets/images/d0/d0310a66e4a915843c91dffbe605b8c36a26efe9fe27a3ac8560f01c9b214ebe.jpg)
2. 在任意sprite上 **单击右键**，然后从快捷菜单选择 **创建Flipbook** 选项。

   ![Select the Create Flipbook option from the context menu](../../../../assets/images/5c/5c0afecf82394a8c1b8631ab07c13dd891e34f128f9a376ac7a6868b4e03e56d.jpg)
3. 弹出输入新Flipbook名称的提示。

   ![You will then be prompted to enter a name for your new Flipbook](../../../../assets/images/8c/8c4f8961c5700b9e06e889fb005027d1cb697ed6bbaa883775b254ffae5462e1.png)
4. 选定名字之后，Flipbook资产便成功创建。

   ![Your Flipbook asset has been created](../../../../assets/images/ea/ea2b0c24a13af1e4f2c899b221a1e19eeb9bd632876ed6b48c9bb03d92fbda90.jpg)

   在 **内容抽屉**.中将鼠标悬停在Flipbook上即可预览Flipbook动画。

> [!WARNING]
> 自动生成Flipbook时，用于sprite的命名规则 **十分重要**，因为sprite将以字母顺序添加至Flipbook。在以上示例中每个sprite皆被命名，**Idle_x** 中的X就是序列的播放顺序。

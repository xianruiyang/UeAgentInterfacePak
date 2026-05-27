---
title: "Actor编辑器上下文"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/actor-editor-context-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "Actor编辑器上下文"]
---

# Actor编辑器上下文

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / Actor编辑器上下文

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/actor-editor-context-in-unreal-engine

**Actor编辑器上下文（Actor Editor Context）** 是一种编辑器功能，可用于将[关卡](../../understanding-the-basics/levels/index.md)、[数据层](../world-partition/world-partition---data-layers/index.md)、[关卡实例](../world-partition/level-instancing/index.md), or [大纲视图Actor文件夹](../level-editor/outliner/index.md)设置为 **当前编辑器上下文**。设置为当前上下文时，你添加到视口的所有Actor都会分配到当前上下文。 若分配当前Actor编辑器上下文，将在添加大量Actor时自动将它们分配到指定上下文，这有助于让你的世界保持井然有序，例如将一个环境中的所有树保持在树大纲视图文件夹中，并将其分配到树数据层。

![The Actor Editor Context set to the Trees Data Layer and Trees Actor Folder](../../../assets/images/7a/7aad7810ba6c74419c703399bb996d165fb09ead54c2a6be85cc09c376aa60e6.jpg)

设置到树数据层和树Actor文件夹的Actor编辑器上下文。点击查看大图。

视口右下角的一个控件可显示当前处于活动状态的关卡、关卡实例、数据层或Actor文件夹。

## 设置当前上下文

### 当前关卡

在不使用[世界分区](../world-partition/index.md)的世界中，知道你在哪个关卡中工作是子关卡工作流程不可或缺的一环。使用"关卡（Levels）"窗口将子关卡添加到你的关卡之后，Actor编辑器上下文将显示当前关卡：

![Level window showing the Persistent Level with one sublevel named SubLevel](../../../assets/images/c2/c2b61ed45ccd08da7c7d04ffdd0d466e6aadf8f7a9662138a7cadcf8819fe1a4.png)

显示带有一个名为SubLevel的子关卡的持久关卡的关卡窗口。点击查看大图。

![Actor Editor Context showing SubLevel as the current level.](../../../assets/images/e8/e8795896229dd3fd9a21946fca2acdd62215f55dc2612223d982f86a2b876b0e.jpg)

将SubLevel显示为当前关卡的Actor编辑器上下文。点击查看大图。

使用Actor编辑器上下文控件中的下拉菜单，你可以指定当前关卡。你添加到视口的所有Actor都会分配到该关卡。

![Click the dropdown to change the current Level](../../../assets/images/57/57a9471e8c0c27dc86fe508abd7a021d1797aa94cb1d8df7f025b14259a22c15.png)

点击下拉菜单更改当前关卡。

### 当前关卡实例

关卡实例化是基于关卡的工作流程，用于创建预制 **关卡实例（Level Instances）** ，你可以多次将其放入你的世界。编辑关卡实例时，虚幻引擎会创建新的空上下文，并且Actor编辑器上下文会显示当前关卡实例：

![Actor Editor Context showing the current open Level Instance](../../../assets/images/21/21133985b06623ebe9154a72080fd8c31c44555e10b999d0766f836c64a90855.jpg)

显示当前打开的关卡实例的Actor编辑器上下文。点击查看大图。

你添加到视口的所有Actor都会分配到当前打开的关卡实例。将更改提交到关卡实例时，编辑器会将你返回到之前的Actor编辑器上下文。

### 当前数据层

数据层会在编辑器中以及在运行时控制Actor的加载和卸载。不同于关卡，Actor可以分配到多个数据层。 要设置一个或多个当前数据层：

1.根据需要选择 **窗口（Window）> 世界分区（World Partition）> 数据层大纲视图（Data Layer Outliner）** ，打开 **数据层大纲视图（Data Layer Outliner）** 。 1.右键点击你想设为当前值的数据层，并选择 **设为当前数据层（Make Current Data Layer (s)）** 。

![Data Layer Outliner showing the Trees Data Layer set to current](../../../assets/images/6c/6cb23bdd7a1355f5cbb6e0504c6cab06280f1115653b3ab2d5ae5e6a584b4005.png)

显示设为当前值的树数据层的数据层大纲视图。

这样会将所选数据层添加到当前上下文。其名称和分配的调试颜色现在显示在Actor编辑器上下文控件中。

![Actor Editor Context widget showing Trees as the current Data Layer](../../../assets/images/c9/c9de11c0b2a068f74a1fe2305e1f5b0fbb1110a6e9a1b26d50bd953af7cc46ab.jpg)

Actor编辑器上下文控件将树显示为当前数据层。点击查看大图。

你添加到视口的所有Actor都会分配到当前数据层。要清除当前数据层上下文，请右键点击数据层大纲视图，然后选择 **清除当前数据层（Clear Current Data Layer(s)）** ，或点击Actor编辑器上下文控件的该分段中的 **X** 按钮。

![Clear the current Data Layer by clicking the X button in the Actor Editor Context widget](../../../assets/images/16/16ffe0ff04c69e28113b9aae4eda1293a12c026855eecb98b78b404eb20a1bdd.png)

点击Actor编辑器上下文控件中的X按钮以清除当前数据层。

### 当前Actor文件夹

与数据层的操作相似，你还可以在大纲视图中分配当前Actor文件夹。 要设置当前Actor文件夹：

1. 根据需要，选择

   窗口（Window）> 大纲视图（Outliner）

   ，然后选择四个大纲视图实例之一，以打开

   大纲视图（Outliner）

   。
2. 右键点击你想设为当前值的文件夹，然后从上下文菜单选择

   设为当前文件夹（Make Current Folder）

   。

> 图片已省略：Outliner showing Trees as the current Actor Folder

将树显示为当前Actor文件夹的大纲视图。

这样会将所选文件夹添加到当前上下文。其名称现在显示在Actor编辑器上下文控件中。

> 图片已省略：Actor Editor Context widget showing Trees as the current Actor Folder

将树显示为当前Actor文件夹的Actor编辑器上下文控件。点击查看大图。

你添加到视口的所有Actor都会分配到当前Actor文件夹。要清除此上下文，请右键点击大纲视图，然后选择 **清除当前文件夹（Clear Current Folder）** ，或点击Actor编辑器上下文控件的该分段中的 **X** 按钮。

> 图片已省略：undefined

点击Actor编辑器上下文控件中的X按钮，即可清除当前Actor文件夹。

## 在视口中切换Actor编辑器上下文

Actor编辑器上下文控件默认启用。要将其禁用，请执行以下步骤：

1. 点击视口左上角的 **视口选项（Viewport Options）** 按钮，然后选择 **高级设置（Advanced Settings）** 。这将打开 **编辑器偏好设置（Editor Preferences）** 窗口。

   > 图片已省略：点击

   点击"视口选项"按钮并选择底部的"高级设置"。
2. 找到 **关卡编辑器 - 视口（Level Editor - Viewports）** 设置的 **外观体验（Look and Feel）** 分段，取消勾选 **显示Actor编辑器上下文（Show Actor Editor Context）** 复选框。

   "关卡编辑器 - 视口"设置。点击查看大图。

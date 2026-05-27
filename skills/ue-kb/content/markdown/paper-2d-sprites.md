# Paper 2D Sprites

---
title: "Paper 2D Sprites"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-import-and-use-paper-2d-sprites-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D Sprites"]
---

# Paper 2D Sprites

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D Sprites

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-import-and-use-paper-2d-sprites-in-unreal-engine

**Paper 2D** 中的 **Sprite** 本质上是一种映射了纹理和相关材质的平面网格体，可以在场景中渲染，并且完全在虚幻引擎中创建。简单而言，它可以在虚幻引擎中迅速绘制 2D 图像。

在虚幻引擎中，你可以使用 **Sprite 编辑器** 对 Sprite 进行编辑。该编辑器拥有以下四种模式：**查看** 模式，用于预览 Sprite 和常用统计数据。**编辑源区域（Edit Source Region）** 模式，用于编辑原始纹理的哪些区域会构成 sprite。**编辑碰撞** 用于显示和编辑 sprite 的碰撞体、**编辑渲染几何体** 用于显示和编辑 sprite的渲染几何体。

准备完一组 Sprite 资产之后，你便可以开始创建 **Flipbook**。Flipbook 会按照顺序播放你添加的的 Sprite，从而实现动画效果。详情请参见[Flipbook](../paper-2d-flipbooks/index.md)。

## 创建 Sprite

和其他资产一样，Sprite 需要在 **内容浏览器** 中创建。既可以作为空白资产从头创建，也可以从其他现有资产中生成，或使用导入数据进行创建。

### 空白 Sprite 资产

**创建全新空白 Sprite 资产的步骤：**

1. 在 **内容浏览器** 中点击 **新建** 按钮，然后在 *Paper2D* 下选择 **Sprite**。

   > [!TIP]
   > 在 **内容浏览器** 中 **单击右键** 可以呼出相同的快捷菜单。
2. 为新 Sprite 资产命名。
3. 此时 Sprite 已被创建但尚未保存（左下角有星号提醒）。

   点击 **全部保存** 键保存 Sprite。
4. **双击** 新建的 Sprite 资产，将其在 **Sprite 编辑器** 中打开。
5. 在 **细节** 面板中，可利用 **源纹理** 属性为 Sprite 资产指定一个纹理。

> [!NOTE]
> 关于如何在 **Sprite 编辑器** 中处理 Sprite，请查阅 [Sprite 编辑器引用](index.md) 文档。

### 从纹理生成单一 Sprite

**从现有纹理资产中创建一个 sprite：**

1. 在 **内容编辑器** 中 **右键单击** 纹理资产，然后在 *Sprite 操作* 下选择 **创建 Sprite**。
2. 为新 Sprite 资产命名。

### 从 Sprite 表单纹理生成一系列的 Sprite

**从 Sprite 表单纹理生成一系列 Sprite 的步骤：**

1. 在 **内容浏览器** 中 **右键单击** Sprite 表单纹理，然后在 *Sprite 操作* 下选择 **提取 Sprite**。
2. 个体 Sprite 将自动被提取并添加到 **内容浏览器** 中。

### 通过 JSON 文件导入

**Paper 2D** 自带一个 JSON 格式化 sprite 表单描述的导入器。这些表单描述可从 **Adobe Flash CS6** 或 **Texture Packer** 等工具中导出。它可导入任意引用纹理并为每个 sprite 创建 sprite 资产。该导入器还会将所有 sprite 认定为一个动画的帧。因此除个体 sprite 外还将同时默认创建一个 Flipbook。如不需要 Flipbook，可直接删除。

> [!NOTE]
> 如需导入选项的更多内容，请查阅 [Paper 2D 导入选项](../import-sprites/index.md)。

## 创建 Sprite 材质

**Paper 2D** 插件含一套取样一种纹理并通过顶点颜色实现多样化的基础材质，还可通过点亮与不点亮的变化形成不透明、遮罩和半透明纹理。Sprite 和 Flipbook 上的默认材质为不点亮遮罩。

### 创建自定义 Sprite 材质

可通过复制现有材质或在 **内容浏览器** 中创建新材质这两种方式创建自定义 Sprite 材质。当 Sprite 被渲染时，Sprite 资产中定义的纹理将被输入材质中名为 **SpriteTexture** 的纹理参数中。可通过放置 **材质编辑器** 中的 **SpriteTextureSampler** 节点自动完成此操作。Sprite 范例会将其色彩作为顶点颜色进行传输，其可在材质中任意使用，而非仅作着色之用。


---
title: "使用UMG字体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-fonts-with-umg-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "文本格式设置、本地化和字体", "Fonts", "使用UMG字体"]
---

# 使用UMG字体

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 文本格式设置、本地化和字体 / Fonts / 使用UMG字体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-fonts-with-umg-in-unreal-engine

在此指南中，您将学习到如何用控件蓝图编辑器设置 **文本** 控件的自建字体资源。

## 步骤

执行以下步骤来学习如何调整自定义字体并通过控件蓝图编辑器的UMG UI设计工具来使用字体。

> [!NOTE]
> 在此指南中，我们使用的是 **Blank Template**，未加入 **Starter Content**。选择默认 **Target Hardware** 和 **Project Settings**。

1. 创建一个新的[控件蓝图](../../../basics-of-user-interface-development/building-your-ui/widget-blueprints-in-umg/index.md)。在 **内容浏览器（Content Browser）** 中点击 **添加（Add）**，然后选择 **用户界面（User Interface） > 控件蓝图（Widget Blueprint）**。
2. **双击** 创建好的 **控件蓝图（Widget Blueprint）** 来将其在 **控件蓝图编辑器（Widget Blueprint Editor）** 中打开。
3. 在 **调色板（Pallete）** 面板中找到 **画板面板（Canvas Panel）** 控件并将其拖入 **可视化设计工具（Visual Designer）** 窗口中。
4. 在 **调色板（Pallete）** 面板中找到 **文本（Text）** 控件并将其拖入 **可视化设计工具（Visual Designer）** 窗口的 **画板面板（Canvas Panel）**。
5. 点击创建好的 **文本（Text）** 控件来访问它的 **细节（Details）** 面板。在 **细节（Details）** 面板中，在 **外观（Appearance）** 下找到 **字体（Font）** 选项。在这里可以调整字体类型、风格（常规、粗体、斜体等）、大小以及间距等等。
6. **虚幻引擎（Unreal Engine）** 默认使用 **Roboto** 字体。点击 **字体类型（Font Family）** 旁的下拉菜单即可选择创建的自定义字体资源。

   > [!NOTE]
   > 也可在此菜单中选择创建一个自定义字体并指定新资源的保存位置（默认为空，需要填入）。
7. 点击 **风格（TypeFace）** 旁的下拉菜单来为选中的字体资产选用风格。
8. 你可以在 **大小（Size）** 旁边的输入框指定字体大小。
9. 另外，还可以在 **字母间距（Letter Spacing）** 旁的输入框来指定字母之间的距离。

> [!NOTE]
> 当前版本中 UMG 只支持 **运行时** 缓存字体资源。此外，如果你已使用老方法指定字体，基于文件的现有字体设置不会丢失，但之后需要创建字体资产以便以UMG使用自定义字体。

## 最终结果

你已经了解了通过控件蓝图编辑器调整文本控件的 **字体** 资产的基础。另外，你可以通过[颜色、材质和外框属性](../font-materials-and-outlines/index.md)来设置更多的字体风格。

---
title: "将骨骼网格体转换为静态网格体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/skeletal-mesh-to-static-mesh-conversion-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "骨骼网格体", "将骨骼网格体转换为静态网格体"]
---

# 将骨骼网格体转换为静态网格体

> 路径：虚幻引擎5.7文档 / 管理内容 / 骨骼网格体 / 将骨骼网格体转换为静态网格体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/skeletal-mesh-to-static-mesh-conversion-in-unreal-engine

在创建启动画面、屏幕截图或其他游戏内静态版本的角色时，一种很有用的做法是将特定姿势的[骨骼网格体](../index.md)资产无损转换为[静态网格体](../../static-meshes/index.md)以保持其位置并降低静止对象的渲染成本。

以下文档将提供一个示例工作流程，说明如何在虚幻引擎中设定 **骨骼网格体** 资产的姿势并将该资产转换为 **静态网格体** 资产。

#### 先决条件

- 你的项目包含一个

  骨骼网格体

  角色。

## 设定骨骼网格体的姿势

要开始在虚幻引擎中设定角色的姿势，请在[骨骼网格体编辑器（Skeletal Mesh Editor）](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/skeletal-mesh-editor/index.md)中打开骨骼网格体资产。

要显示骨骼网格体的骨骼，为了操控其位置，请在 **视口（Viewport）** 面板中导航到 **角色（Character）** > **骨骼（Bones）**，然后切换 **所有层级（All Hierarchy）** 选项。

单击选择要调整的骨骼，然后使用 **移动（Move）**、**旋转（Rotate）** 和 **缩放（Scale）** 工具来操控角色的姿势。

> 动图已省略：b62e2c2188607c391378bece25f0fd7426e3b4b8fc7bd67237598e54731a93bc

## 保存骨骼网格体姿势

将角色的姿势操控到所需位置后，可以使用骨骼网格体编辑器 **工具栏** 中的 **创建静态网格体（Make Static Mesh）** 按钮将该姿势另存为静态网格体资产。

指定新的静态网格体资产的 **名称（Name）**，并选择一个位置来保存该资产，然后选择 **保存（Save）**。

现在可以在项目中使用转换后的静态网格体。

> 动图已省略：ab3f1b5c531d03eb521f38539712be44fe8ca43424c9af5820fae8200cdbfbee

将骨骼网格体转换为静态网格体后，为了安全地将网格体重新定位到其参考姿势，可以使用骨骼网格体编辑器 **工具栏** 中的 **重新导入基础网格体（Reimport Base Mesh）** 按钮重新导入骨骼网格体的 `.fbx` 源文件，或使用 **Ctrl** + **Z** 手动还原所做的操控编辑。

> [!WARNING]
> 如果不还原骨骼操控编辑，骨骼网格体的动画序列将无法正常播放。

还可以使用骨骼网格体编辑器工具栏中的"创建资产（Create Asset）"按钮将特定姿势的骨骼网格体另存为[动画序列](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/animation-sequences/index.md)和[姿势资产](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/animation-pose-assets/index.md)，以便用于其他更动态的用例。

如需详细了解如何使用保存的骨骼网格体姿势，请参阅以下文档：


- [动画姿势资产](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/animation-pose-assets/index.md)

## 转换多个骨骼网格体和静态网格体

还可以将一组已放置在关卡中的静态网格体或骨骼网格体对象转换为单个静态网格体资产，以便将多个角色摆放在一起，或将角色与其他对象（如背景或武器）组合在一起。 在关卡中放置和定位对象后，可以多选要转换为静态网格体的每个对象，然后在 **菜单栏** 中导航到 **Actor** > **将Actor转换为静态网格体（Convert Actors to Static Mesh）**。

指定新的静态网格体资产的 **名称（Name）**，并选择一个位置来保存该资产，然后选择 **保存（Save）**。 现在可以在项目中使用转换后的静态网格体。

> 动图已省略：a405a0a99f892fb87642109b559661bab11edf6647859417044c8e16785df27c

还可以 **在编辑器中运行**（Play In Editor，简称 **PIE**）期间将多组游戏对象转换为单个静态网格体，以及在编辑器中的其他模拟模式下进行此操作，例如使用[倒回调试器（Rewind Debugger）](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-debugging-and-optimization/animation-rewind-debugger/index.md)录制Gameplay片段以保存更多动态Gameplay快照。

> 动图已省略：9ea6490e05a9bad54fbb8f1ed2721e29693f7c08df1221b1171716a9d1ebcd6c

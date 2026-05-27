---
title: "蓝图编辑器宏库UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-macro-libraries-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面介绍", "蓝图编辑器宏库UI"]
---

# 蓝图编辑器宏库UI

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面介绍 / 蓝图编辑器宏库UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-macro-libraries-in-unreal-engine

**蓝图宏库（Blueprint Macro Library）** 是一个容器，它包含一组 **宏** 或自包含的图表，这些图表可以 作为节点放置在其他蓝图中。它们可以节省时间，因为它们可以存储常用的节点序列， 包括执行和数据传输所需的输入和输出。

宏在引用它们的所有图表之间共享，但是它们会自动扩展到图表中， 就像它们在编译期间是一个折叠节点那样。这意味着蓝图宏库不需要编译。但是， 对宏的更改仅反映在重新编译包含这些图表的蓝图时 引用该宏的图表中。

如需了解宏库的更多内容和使用方法，请查阅 []programming-and-scripting/blueprints-visual-scripting/UserGuide/Types/MacroLibrary) 文档。

## 界面

和蓝图界面相同，打开宏库的蓝图编辑器后可看到一个不带图表的简化UI：

| 默认可见UI组件 | 窗口菜单中可选 |
| --- | --- |
| [菜单](../../../user-interface-reference-for-the-blueprints-73593f79/user-interface-components/menu-for-the-blueprints-visual-scripting-editor/index.md) [工具栏](../../../user-interface-reference-for-the-blueprint-73593f79/user-interface-components/toolbar-in-the-blueprints-visual-scripting-editor/index.md) [我的蓝图](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/my-blueprint-panel-in-the-blueprints-visual-scr-706fb8aa/index.md) [细节](../../../user-interface-reference-for-the-blue-73593f79/user-interface-components/details-panel-in-the-blueprints-visual-scriting-editor/index.md) [图表编辑器](../../user-interface-components/graph-editor-for-the-blueprints-visual-scripting-editor/index.md) | [调试](../../../user-interface-reference-for-the-bluep-73593f79/user-interface-components/debug-panel-in-the-blueprints-visual-scripting-editor/index.md) [搜索运算结果](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/find-result-panel-in-the-blueprints-visual-scri-5f9f8e6c/index.md) [面板](../../../user-interface-reference-for-the-blueprints-73593f79/user-interface-components/palette-in-the-bleprints-visual-scripting-editor/index.md) |

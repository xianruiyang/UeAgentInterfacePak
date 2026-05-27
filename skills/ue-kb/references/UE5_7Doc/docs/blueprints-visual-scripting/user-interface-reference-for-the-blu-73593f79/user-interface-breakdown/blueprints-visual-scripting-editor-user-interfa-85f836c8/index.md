---
title: "蓝图编辑器中的关卡蓝图UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-level-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面介绍", "蓝图编辑器中的关卡蓝图UI"]
---

# 蓝图编辑器中的关卡蓝图UI

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面介绍 / 蓝图编辑器中的关卡蓝图UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-level-blueprints-in-unreal-engine

**关卡蓝图（Level Blueprint）** 是一种专业类型的 **蓝图（Blueprint）**，用作关卡范围的全局事件图。 在默认情况下，项目中的每个关卡都创建了自己的关卡蓝图，您可以在虚幻编辑器中编辑这些关卡蓝图， 但是不能通过编辑器接口创建新的关卡蓝图。

与整个级别相关的事件，或关卡内Actor的特定实例， 用于以函数调用或流控制操作的形式触发操作序列。 熟悉虚幻引擎3的人应该非常熟悉这个概念， 因为它与Kismet在虚幻引擎3中的工作原理非常相似。

关卡蓝图还提供了关卡流送和[Sequencer](../../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)的控制机制， 以及将事件绑定到关卡内的Actor的控制机制。

## 接口

在编辑关卡蓝图时，蓝图编辑器包含以下部分:

| 默认可视UI组件 | 窗口菜单中可用的组件 |
| --- | --- |
| [菜单](../../../user-interface-reference-for-the-blueprints-73593f79/user-interface-components/menu-for-the-blueprints-visual-scripting-editor/index.md) [工具栏](../../../user-interface-reference-for-the-blueprint-73593f79/user-interface-components/toolbar-in-the-blueprints-visual-scripting-editor/index.md) [我的蓝图](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/my-blueprint-panel-in-the-blueprints-visual-scr-706fb8aa/index.md) [细节](../../../user-interface-reference-for-the-blue-73593f79/user-interface-components/details-panel-in-the-blueprints-visual-scriting-editor/index.md) [图表编辑器](../../user-interface-components/graph-editor-for-the-blueprints-visual-scripting-editor/index.md) | [编译器运算结果](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/compiler-results-in-the-blueprints-visual-scrip-4bf40b3b/index.md) [调试](../../../user-interface-reference-for-the-bluep-73593f79/user-interface-components/debug-panel-in-the-blueprints-visual-scripting-editor/index.md) [搜索运算结果](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/find-result-panel-in-the-blueprints-visual-scri-5f9f8e6c/index.md) [面板](../../../user-interface-reference-for-the-blueprints-73593f79/user-interface-components/palette-in-the-bleprints-visual-scripting-editor/index.md) [视口](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/components-mode-viewport-in-the-blueprints-visu-2a55f70f/index.md) |

---
title: "蓝图编辑器蓝图接口UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-blueprint-interfaces-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面介绍", "蓝图编辑器蓝图接口UI"]
---

# 蓝图编辑器蓝图接口UI

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面介绍 / 蓝图编辑器蓝图接口UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprints-visual-scripting-editor-user-interface-for-blueprint-interfaces-in-unreal-engine

**蓝图接口（Blueprint Interface）** 是一个或多个函数的集合 - 只有名称，没有实施 - 可以添加到其他蓝图中。任何添加了该接口的蓝图都保证拥有这些函数。接口的函数 可以在添加它的每个蓝图中提供功能。在本质上，这类似于一般编程中的接口概念， 它允许多个不同类型的对象通过一个公共接口 共享和被访问。简单地说，蓝图接口允许不同的蓝图相互共享和发送数据。

内容创建者可以通过编辑器以与其他蓝图类似的方式创建蓝图接口， 但它们仍有一定的局限性，原因在于以下操作不可执行：

- 添加新变量
- 编辑图表
- 添加组件

## 蓝图接口编辑器UI

首次打开[蓝图接口](../../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-interface/index.md)时，该UI看起来极其简单，只包含以下部分：

| 默认可见的UI组件 | "窗口"（Window）菜单中可用的选项 |
| --- | --- |
| [菜单](../../../user-interface-reference-for-the-blueprints-73593f79/user-interface-components/menu-for-the-blueprints-visual-scripting-editor/index.md) [工具栏](../../../user-interface-reference-for-the-blueprint-73593f79/user-interface-components/toolbar-in-the-blueprints-visual-scripting-editor/index.md) [我的蓝图（My Blueprint）](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/my-blueprint-panel-in-the-blueprints-visual-scr-706fb8aa/index.md) [细节（Details）](../../../user-interface-reference-for-the-blue-73593f79/user-interface-components/details-panel-in-the-blueprints-visual-scriting-editor/index.md) [图表编辑器（Graph Editor）](../../user-interface-components/graph-editor-for-the-blueprints-visual-scripting-editor/index.md) | [调试（Debug）](../../../user-interface-reference-for-the-bluep-73593f79/user-interface-components/debug-panel-in-the-blueprints-visual-scripting-editor/index.md) [编译结果（Compiler Results）](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/compiler-results-in-the-blueprints-visual-scrip-4bf40b3b/index.md) [查找结果（Find Results）](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/find-result-panel-in-the-blueprints-visual-scri-5f9f8e6c/index.md) |

## 使用说明

需要注意的是，此时的图表视图与蓝图编辑器中通常提供的图表编辑器稍有不同。您可能会注意到，它显示为灰色，并且不能浏览，也不能在其中添加任何节点。这是因为它更多的是一种可视化工具，而不是编辑图表的方法。需要记住的是，接口本身不包含任何功能，因此此时无需创建实际能够运行的网络。可以将该视图视为输入和输出效果的预览。

有关创建和使用蓝图接口的更多信息，请参阅[蓝图接口](../../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-interface/index.md)。

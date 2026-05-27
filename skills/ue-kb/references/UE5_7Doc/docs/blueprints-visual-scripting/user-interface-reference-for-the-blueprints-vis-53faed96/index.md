---
title: "蓝图编辑器参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/user-interface-reference-for-the-blueprints-visual-scripting-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考"]
---

# 蓝图编辑器参考

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/user-interface-reference-for-the-blueprints-visual-scripting-editor-in-unreal-engine

蓝图可视化脚本是虚幻引擎中一个用途广泛的系统。蓝图可以控制关卡中的事件，为游戏 Actor 添加基于脚本的行为，并在高度真实的游戏角色系统中控制复杂动画。在处理不同类型的需求时，蓝图脚本的出现位置和提供的工具会有所不同。这意味着在虚幻引擎中，蓝图编辑器可能会在不同场合和不同时机出现。不过，无论在何种情况下使用，蓝图编辑器都是一种能帮助你创建、编辑强大可视化脚本并控制游戏各种元素的工具。

蓝图编辑器是一种基于节点的图表编辑器。它是创建和编辑可视化脚本节点网络的主要工具，通常简称为蓝图。蓝图编辑器的设计对上下文（context）十分敏感，可在需要时单独访问对象的功能，在需要执行非常规操作时进行灵活处理。

关于蓝图编辑器有以下几个关键点：

- 它包含数个工具和面板工具，用于创建变量、函数、数组等。
- 它内置多种调试和分析工具，用于在网络中迅速除错并改进数据流。
- 在虚幻引擎中，取决于正在编辑的蓝图网络类型，蓝图编辑器将出现多种不同的独特形态。

在深入了解蓝图编辑器之前，应先对蓝图本身有良好理解。如需了解详细内容，请查阅 [蓝图入门](../introduction-to-blueprints-visual-scripting/index.md) 和 [蓝图总览](../introduction-to-blueprints-visual-scripting/overview-of-blueprints-visual-scripting/index.md).

## 界面详解

蓝图编辑器的位置和可用工具将随当前编辑的蓝图类型出现细微变化。该文档将助你确定是否需要查看蓝图编辑器特殊形态的 UI 详解，或只需要看到可用功能的顺序列表。

> [!NOTE]
> 如你未接触过蓝图编辑，或不确定正在使用的是何种蓝图，建议查阅 [蓝图类型](../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/index.md)进行了解。


- [蓝图编辑器中的关卡蓝图UI](../user-interface-reference-for-the-blu-73593f79/user-interface-breakdown/blueprints-visual-scripting-editor-user-interfa-85f836c8/index.md)

- [蓝图编辑器中的蓝图类UI](../user-interface-reference-for-the-blue-73593f79/user-interface-breakdown/blueprints-visual-scripting-user-interface-for-871cf78a/index.md) - 当蓝图编辑器处理类蓝图时所包含的UI元素的详细介绍。

- [蓝图编辑器蓝图接口UI](../user-interface-reference-for-the-blu-73593f79/user-interface-breakdown/blueprints-visual-scripting-editor-user-interfa-03449a50/index.md) - 对使用蓝图接口时看到的蓝图编辑器UI元素的分解介绍。

- [蓝图编辑器宏库UI](../user-interface-reference-for-the-blu-73593f79/user-interface-breakdown/blueprints-visual-scripting-editor-user-interfa-1601e902/index.md) - 使用蓝图宏库时蓝图编辑器的UI元素解析。

- [动画蓝图编辑器](../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-blueprints/animation-blueprint-editor/index.md) - 动画蓝图编辑器及其界面概览

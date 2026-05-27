---
title: "蓝图编辑器调试面板"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/debug-panel-in-the-blueprints-visual-scripting-editor-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面组件", "蓝图编辑器调试面板"]
---

# 蓝图编辑器调试面板

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面组件 / 蓝图编辑器调试面板

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/debug-panel-in-the-blueprints-visual-scripting-editor-for-unreal-engine

**调试** 面板提供了目前可以用于调试蓝图的一系列调试工具，比如 Breakpoints（断点）及 Watch Values(查看值)。当处于Play In Editor（在编辑器中运行）时，它还允许您访问Execution Trace（执行追踪），向你展示了在给定蓝图中发生的每个节点的执行情况。

关于调试蓝图的更多信息，请参照[蓝图调试器](../../../blueprint-debugger/index.md)。

## 界面

调试面板的界面根据您是在编辑器中运行游戏还是在编辑器中模拟游戏的不同而有所变化。

**当没有处于运行或模拟过程中时:**

当没有运行游戏时，调试面板列出了您的当前蓝图中的所有查看值和断点。

**当处于运行或模拟过程中时:**

当处于蓝图运行或模拟过程中时，调试面板显示了调试信息及Execution Trace(执行追踪)，Execution Trace显示了执行每个节点所花费的时间。

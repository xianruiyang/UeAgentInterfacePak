---
title: "Gameplay Targeting System Debugging"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-debugging-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay定位系统", "Gameplay Targeting System Debugging"]
---

# Gameplay Targeting System Debugging

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay定位系统 / Gameplay Targeting System Debugging

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-targeting-system-debugging-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## Debugging and Troubleshooting

You can enable debugging from the Editor by pressing the tilde (~) key. See the table below for a complete list of Console Commands.

> [!NOTE]
> Currently debug visualizations only run on targeting requests on the client.

| Console Command | 说明 |
| --- | --- |
| `ts.debug.EnableTargetingDebugging false/true` | Toggles whether the targeting system is actively in debugging mode. |
| `ts.debug.PrintTargetingDebugToLog false/true` | Toggles whether to print the targeting debug text to the log. |
| `ts.debug.TotalDebugRecentRequestsTracked #` | Sets the total number of targeting requests that will be tracked upon starting. The default amount is 5. |
| `ts.debug.ClearTrackedTargetRequests` | Clears all tracked targeting handles when in debug mode. |
| `ShowDebug TargetingSystem` | Brings up the visualization of the targeting tasks when `ts.debug.EnableTargetingDebugging` is enabled. |

## Developer Reference

For an in-depth Engineering reference guide, see the [Gameplay Targeting Plugin Reference](../gameplay-targeting-system-reference/index.md) documentation.

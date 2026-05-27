---
title: "网络调试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/network-debugging-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络调试"]
---

# 网络调试

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络调试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/network-debugging-for-unreal-engine

在 **虚幻引擎（UE）** 中创建多人游戏或网络项目时，在调试、分析和测试项目的过程中会遇到一些独特的挑战。这些挑战包括：

- 调试项目的多个实例
- 考虑网络通信带来的普遍不可靠性和不稳定性
- 检查 **客户端** 与 **服务器** 上存在的不同功能。

> [!NOTE]
> UE多人游戏基于客户端-服务器模型。这意味着将有单个服务器对[GameState](../../gameplay-framework/game-mode-and-game-state/index.md)具有权威性，而连接的客户端需要非常相似。有关其他文档，请参阅[[客户端-服务器模型](../network-programming-tutorials-and-examples/setting-up-dedicated-servers/index.md)。

虚幻引擎将提供用于调试网络应用程序的专用工具和工作流程。下面的指南将展示这些工具的用法，以及解决常见网络问题的技巧和最佳实践。

## 索引

- [日志](logging-for-networked-games/index.md) - 关于网络游戏日志记录的概述。

- [测试和调试网络游戏](testing-and-debugging-networked-games/index.md) - 在虚幻引擎中测试和调试网络游戏。

- [使用网络模拟](using-network-emulation/index.md) - 关于在虚幻引擎中使用网络模拟的概述。

- [控制台命令](console-commands-for-network-debugging/index.md) - 指定网络设置并在运行时获取有用的调试信息。

- [测试多人游戏](testing-multiplayer/index.md) - 设置虚幻编辑器以测试多人游戏。

- [网络分析器](using-the-network-profiler/index.md) - 分析在运行时捕获的网络流量和性能信息。

- [性能与带宽注意事项](performance-and-bandwidth-tips/index.md) - 关于 Actor 复制过程中的性能和带宽优化提示

---
title: "联网和多人游戏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/networking-and-multiplayer-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏"]
---

# 联网和多人游戏

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/networking-and-multiplayer-in-unreal-engine

现代多人游戏体验需要在世界范围内的大量客户端间同步庞大数据。对于向用户提供引人入胜的体验而言，发送数据的类型和方式至关重要，因为其会极大影响项目的执行和质感。在虚幻引擎中，在客户端与服务器间同步数据和调用程序的过程被称为 **复制（Replication）** 。复制系统同时提供了较高层次的抽象物以及低层次的自定义，以便在创建针对多个并发用户的项目时更加方便地处理可能遇到的情况。

## 简介

- [网络概述](basics-of-network-multiplayer/networking-overview/index.md) - 学习虚幻引擎网络的知识，包括基础概念和可用的复制系统。

- [多人游戏编程快速入门指南](basics-of-network-multiplayer/multiplayer-programming-quick-start/index.md) - 用C++创建简单的多人游戏。

## 管理会话

- [多人游戏中的关卡切换](managing-multiplayer-sessions/travelling-in-multiplayer/index.md) - 关于多人游戏中关卡切换方式的概述。

## 网络多人游戏编程

- [Actor网络休眠](programming-network-multiplayer-games/actor-network-dormancy/index.md) - 有效使用休眠，优化多人游戏。

- [复制Actor属性](programming-network-multiplayer-games/replicate-actor-properties/index.md) - 属性复制、条件复制、自定义条件和对象引用。

- [Actor组件复制](programming-network-multiplayer-games/replicating-actor-components/index.md) - 了解如何复制Actor拥有的组件。

- [复制子对象](programming-network-multiplayer-games/replicating-uobjects/index.md) - 了解如何复制从UObject派生的类及其包含的复制属性。

- [在线信标](programming-network-multiplayer-games/using-online-beacons/index.md) - 服务器和客户端之间的轻量级交互机制。

## Iris复制系统

- [Iris简介](iris-replication-system/introduction-to-iris/index.md) - 了解Iris的设计和组件以及如何将你的项目配置为使用Iris。

- [Migrate to Iris](iris-replication-system/migrate-to-iris/index.md) - Learn what has changed between the existing replication systems and Iris.

- [Iris组件](iris-replication-system/components-of-iris/index.md) - 了解Iris复制系统中的主要组件及其用法。

- [Iris术语表](iris-replication-system/glossary-of-iris-terms/index.md) - Iris的术语表页面。

## 复制图表


- [Replication Graph](replication-graph/index.md)

## 重播系统


- [重播系统](using-the-replay-system/index.md)

## 部署多人游戏

- [使用Steam Sockets](deploying-multiplayer-games/using-steam-sockets/index.md) - 如何为虚幻项目启用Steam网络协议层。

## 调试和优化

- [日志](network-debugging/logging-for-networked-games/index.md) - 关于网络游戏日志记录的概述。

- [测试和调试网络游戏](network-debugging/testing-and-debugging-networked-games/index.md) - 在虚幻引擎中测试和调试网络游戏。

- [使用网络模拟](network-debugging/using-network-emulation/index.md) - 关于在虚幻引擎中使用网络模拟的概述。

- [控制台命令](network-debugging/console-commands-for-network-debugging/index.md) - 指定网络设置并在运行时获取有用的调试信息。

- [测试多人游戏](network-debugging/testing-multiplayer/index.md) - 设置虚幻编辑器以测试多人游戏。

- [网络分析器](network-debugging/using-the-network-profiler/index.md) - 分析在运行时捕获的网络流量和性能信息。

- [性能与带宽注意事项](network-debugging/performance-and-bandwidth-tips/index.md) - 关于 Actor 复制过程中的性能和带宽优化提示


- [Oodle网络](../../testing-and-optimizing-content/using-oodle/oodle-network/index.md)

## 教程和示例

- [设置专用服务器](network-programming-tutorials-and-examples/setting-up-dedicated-servers/index.md) - 为你的项目设置和运行专用服务器。

---
title: "AI组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ai-components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "AI组件"]
---

# AI组件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / AI组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ai-components-in-unreal-engine

AI组件允许 Pawn 感知周围环境中的数据，例如噪声来源位置、或 Pawn 能够看到某个对象。

## AI 感知组件

在 **AIPerceptionSystem** 中，**AIPerceptionComponent** 相当于刺激源的监听器，用于收集已注册的刺激信号。当组件获得新的刺激信号（批量）时，将会调用 **UpdatePerception**。

## Pawn噪声发生器组件

**PawnNoiseEmitterComponent** 追踪 **SensingComponents** 使用的噪声事件数据来监听Pawn。该组件主要存在于 Pawn 或其控制器上。它在网络客户端上不进行任何操作。

## Pawn感应组件

Pawn的感应组件（Sensing Component）用于封装Actor的感知（例如视觉和听觉）设置及功能，以便Actor在游戏世界中观察/监听Pawn。其在网络客户端上不进行任何操作。

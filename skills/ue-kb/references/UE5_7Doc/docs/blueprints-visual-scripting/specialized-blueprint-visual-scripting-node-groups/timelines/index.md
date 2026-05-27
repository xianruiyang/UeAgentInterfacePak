---
title: "时间轴"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/timelines-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "时间轴"]
---

# 时间轴

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 时间轴

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/timelines-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

## 概览（C++）

**UTimelineComponent**包含一系列的**事件**、**浮点数**、**向量**或**颜色**以及和各项所关联的**关键帧**。 以上项目均继承自[UActorComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UActorComponent?application_version=5.5)

> [!NOTE]
> 如需了解更多文档，请参阅关于[Actor组件](../../../gameplay-systems/gameplay-framework/components/index.md)的概述

时间轴可以实现从事件中播放基于时间的动画，这些事件可以沿着时间轴在关键帧处触发。 可以使用时间轴来处理简单的非动画任务，例如开门、更改光源或对场景中的Actor执行其他以时间为中心的操纵。 这种方式与[关卡序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md)相似，因为它们都提供要在时间轴上的关键帧之间内插的值，例如浮点、向量和颜色。

## 输入和输出

UTimelineComponents具有可以在原生代码中扩展的可靠方法，详情请参阅[UTimelineComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UTimelineComponent?application_version=5.5)API参考文档。 如果要查看有关如何在引擎中使用时间轴组件的示例，请点击下方的时间轴示例链接之一。

ExampleTimeline.h

C++

```
/** Start playback of timeline */
	UFUNCTION(BlueprintCallable, Category="Components|Timeline")
	ENGINE_API void Play();

	/** Start playback of timeline from the start */
	UFUNCTION(BlueprintCallable, Category="Components|Timeline")
	ENGINE_API void PlayFromStart();

	/** Start playback of timeline in reverse */
	UFUNCTION(BlueprintCallable, Category="Components|Timeline")
```

## 时间轴示例

- [关键帧和曲线](keys-and-curves/index.md) - 文本档概述如何在蓝图中使用时间轴编辑器内的关键帧和曲线。
- [实现灯光闪烁](fading-lights/index.md) - 本文是一篇关于时间轴的示例。在这里示例中，我们将实现一盏可随时间闪烁并改变颜色的灯光。
- [开门](opening-doors/index.md) - 一个关于时间轴（Timeline）的案例。介绍了如何用时间轴以及蓝图和C++来实现玩家靠近门后，门会自动打开的效果。

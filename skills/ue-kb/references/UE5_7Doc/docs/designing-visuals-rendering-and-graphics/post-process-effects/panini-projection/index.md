---
title: "Panini 投影"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/panini-projection-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "后期处理效果", "Panini 投影"]
---

# Panini 投影

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 后期处理效果 / Panini 投影

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/panini-projection-in-unreal-engine

## 配置

虚幻引擎默认使用透视投影。 然而，此投影模型结合宽视野使用时将出现几何失真。 在此例中的球体上非常明显，视野为 120。

因此，虚幻引擎提供了一个可选的后期处理通道，使用Panini投影修复此问题。 该后期处理的概念是使用Panini投影（而非透视投影）替代所处位置上的渲染像素。 设置所需要的唯一操作是设 `r.LensDistortion.Panini.D > 0` 。 此后期处理效果在Upscaling通道中完成。 这意味着，如果`r.ScreenPercentage != 100`或 `r.LensDistortion.Panini.D > 0` 。 如需进一步了解此参数，请直接参考本页面最下方的原始研究文章。

`r.LensDistortion.Panini.D > 0`直接强调效果。 然而其并非唯一的参数，`r.LensDistortion.Panini.S`会和纸张的硬压缩进行插值。 如果部分球体在角落中仍然显示为遮暗，也可对参数进行调整。 然而，`r.LensDistortion.Panini.S < 0`时，角落中将开始显示未渲染的黑色像素。

要更深刻地理解此效果的原理，你也可以修改`r.LensDistortion.ScreenFit`。 需要注意的一点是，部分透视投影像素处于末端，不会显示在屏幕上下方的区域中。

## 直线

Panini投影将对线条进行多重保证。 首先，垂直线条将保证对任意`r.LensDistortion.Panini.D`和`r.LensDistortion.Panini.S`都保持笔直。 其次，穿过屏幕中央的线条将保证对任意`r.LensDistortion.Panini.D`都保持笔直，但`r.LensDistortion.Panini.S = 0`。 该数学特性非常适用于**第一人称射击游戏**，因为武器的Panini投影朝向屏幕中央，保证直线向中央前进。

## 中央模糊

该后期处理效果的一个问题是：随着 `r.LensDistortion.Panini.D` 的增加，屏幕中央会出现模糊现象。 Panini投影已特别应用到高端通道中，通过锐化滤波修复此现象。 然而，它可能很快便无法修复此问题。 因此需要增加`r.ScreenPercentage`帮助修复该问题，但绘制的像素数量将增加，渲染性能开销也将增加。 可以考虑平衡性更好的方案： `r.LensDistortion.Panini.D` 在无法达到较高屏幕比例的硬件上选择较低的r.Upscale.Panini.D值，只借助高级通道的锐化过滤器来达到此效果。

Panini投影的另一种使用方法是通过材质函数输出一个世界位置偏移，将其插入材质的世界位置偏移输入引脚。 《虚幻竞技场》中便使用了这种方法，并未通过渲染不同视野中的武器修复透视投影失真。 可在《虚幻竞技场》的Github资源库中进行查看。

## 参考

- [原始文章网站](http://tksharpless.net/vedutismo/Pannini/)。
- [原始文章链接](http://tksharpless.net/vedutismo/Pannini/panini.pdf)。

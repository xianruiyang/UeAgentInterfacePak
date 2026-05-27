---
title: "OpenColorIO颜色管理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/color-management-with-opencolorio-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "颜色管理", "OpenColorIO颜色管理"]
---

# OpenColorIO颜色管理

> 路径：虚幻引擎5.7文档 / 使用媒体 / 颜色管理 / OpenColorIO颜色管理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/color-management-with-opencolorio-in-unreal-engine

> [!NOTE]
> 虚幻引擎5支持OCIO v2。如需详细了解OCIO v2中包含的功能，请参阅[OCIO文档](https://opencolorio.readthedocs.io/en/latest/upgrading_v2/how_to.html)。

[OpenColorIO](http://opencolorio.org/)（ **OCIO** ）是一个主要用于电影和虚拟制片的颜色管理系统。OCIO旨在保证在整个电影制作管线中，所捕获的视频在颜色上保持一致。此管线包括初始摄像机捕捉、需要处理所捕捉媒体的所有合成应用程序，以及最终渲染。

**虚幻引擎** （UE）提供支持，可使用OCIO以多种方式转换线性媒体的颜色：

- 当你在项目中使用所捕捉的剪辑片段或实时内容等媒体源时，你可以应用颜色转换，使这些媒体源与你在UE中的计算机生成元素相匹配。
- 你可以使用OCIO将颜色转换应用于你的视口和"在编辑器中播放（PIE）"窗口。这意味着，你在编辑器中的参考帧将与所选颜色空间保持一致。
- 你可以将另一种颜色转换重新应用到你从[Composure](https://dev.epicgames.com/documentation/404)输出的合成内容。这有助于你的CG元素和实时帧更加有效地融合，同时如实保留原始镜头的颜色。
- 你可以使用显示和视图，通过相同的OCIO配置将颜色转换应用于多个物理或虚拟显示设备。
- 你可以将颜色空间转换应用于显示器和LED墙上的[nDisplay](../../integrating-media/rendering-to-multiple-displays-with-ndisplay/index.md)渲染。
- 当你通过[影片渲染队列](https://dev.epicgames.com/documentation/404)导出视频时，你可以对输出视频或图像序列应用颜色空间转换。

引擎中的所有OCIO功能都依赖 **OpenColorIO配置资产** ，你可以使用它来管理你要使用的颜色配置文件。

OpenColorIO配置资产将引用OCIO配置（ `.ocio` ）文件，其中包含有关多个颜色配置文件的详细规范，以及如何在它们之间进行转换。UE目前支持OCIO v2。有关OCIO配置文件的更多详细信息，请参阅[OpenColorIO v2文档](https://opencolorio.readthedocs.io/en/latest/index.html)。

此页面包含有关创建OpenColorIO配置资产和在引擎中应用颜色转换的文档链接。

## 快速入门

此页面将指导你创建OpenColorIO配置资产。


- [OpenColorIO快速入门](opencolorio-quick-start/index.md)

## 在视口中转换颜色

编辑器支持通过 **视口视图模式（Viewport View Modes）** 将OCIO颜色转换应用于关卡视口，并通过蓝图应用于"在编辑器中播放"模式。此页面将介绍如何将颜色转换应用于关卡视口和"在编辑器中播放"模式。


- [在视口和PIE模式中转换颜色](apply-color-conversion-to-the-level-viewport-an-97a382c0/index.md)

## 在蓝图中转换颜色

此页面将介绍如何使用 **蓝图（Blueprints）** 应用颜色转换。


- [在蓝图中转换颜色](converting-colors-in-unreal-engine-blueprints/index.md)

## 在nDisplay中转换颜色

[nDisplay](../../integrating-media/rendering-to-multiple-displays-with-ndisplay/index.md)支持将OCIO颜色转换应用于整个群集、内部视锥体或单个群集节点的nDisplay渲染。这对于管理特定显示器的颜色空间非常有用。此页面将介绍如何将OCIO与nDisplay结合使用。


- [nDisplay中的颜色管理](../../integrating-media/rendering-to-multiple-displays-with-ndisplay/color-management-in-ndisplay/index.md)

## 在影片渲染队列中转换颜色

[影片渲染队列](https://dev.epicgames.com/documentation/404)支持将OCIO颜色转换应用于媒体导出。此页将介绍如何在影片渲染队列中设置颜色转换。


- [图像设置](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/cinematic-render-settings-and-formats/cinematic-rendering-image-bb951eea/index.md)

## 在Composure中转换颜色

[Composure](https://dev.epicgames.com/documentation/404)支持将OCIO颜色转换应用于输入和输出媒体。此页面将介绍如何将颜色转换应用到Composure。


- [在Composure中使用OpenColorIO转换颜色](../../integrating-media/real-time-compositing-with-composure/converting-colors-in-composure-with-opencolorio/index.md)

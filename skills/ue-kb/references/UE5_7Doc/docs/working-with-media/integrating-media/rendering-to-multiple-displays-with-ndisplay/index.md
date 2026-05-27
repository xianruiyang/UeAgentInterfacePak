---
title: "使用nDisplay在多显示屏上进行渲染"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/rendering-to-multiple-displays-with-ndisplay-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染"]
---

# 使用nDisplay在多显示屏上进行渲染

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/rendering-to-multiple-displays-with-ndisplay-in-unreal-engine

互动式内容不仅限于显示在一个屏幕上，或者像VR头显这样的双屏设备上。越来越多的视觉化系统想要通过多个同步显示屏实时渲染内容，更高效地让观众沉浸在游戏世界中。这些系统可能由多个相邻的物理显示屏组成，如[Powerwall](https://en.wikipedia.org/wiki/Powerwall)显示屏；或者可能使用多个投影仪将3D环境投影到穹顶、倾斜幕墙、曲面屏等物理表面，如[Cave](https://en.wikipedia.org/wiki/Cave_automatic_virtual_environment)虚拟环境。

虚幻引擎通过一个名为 **nDisplay** 的系统为这些使用场景提供支持。该系统可以解决将3D内容同时渲染到多个显示屏的一些最重要的挑战：

- 它有助于完成在网络中的不同计算机上部署和启动多个项目实例的过程，并且这些计算机各自可以渲染到一个或多个显示设备。
- 它根据显示硬件的空间布局，管理每一帧下每个屏幕的视锥体所涉及的所有计算工作。
- 它确保各个屏幕上显示的内容保持"完全"同步，将确定性内容分发到所有引擎实例。
- 它提供无源和有源立体声渲染。
- 它可以受VR跟踪系统输入的驱动，这样显示屏中的视点就可以准确地实时跟随移动观众的视点。
- 它足够灵活，可以支持任意相对方向的任意数量的屏幕，并可以在任意数量的项目中轻松复用。

> [!TIP]
> 如需进一步了解有关nDisplay的背景信息，更深入地了解它所支持的实际应用和显示系统以及该技术的未来前景，请在这里[下载白皮书](https://www.unrealengine.com/en-US/tech-blog/explore-ndisplay-technology-limitless-scaling-of-real-time-content)。

> [!TIP]
> nDisplay是[Childish Gambino备受赞誉的2018 Pharo演出](https://www.unrealengine.com/en-US/spotlights/childish-gambino-mesmerizes-fans-with-real-time-animation)的视觉效果的重要组成部分。请参阅下面的项目聚光灯视频！

### 入门

- [nDisplay概述](ndisplay-overview/index.md) - 介绍在nDisplay渲染网络中多台计算机协同工作的方法。

- [nDisplay快速入门](ndisplay-quick-start/index.md) - 介绍nDisplay的首次设置和运行方法。

- [Unreal Stage应用程序](unreal-stage-app/index.md) - 一个旨在将平板电脑用作无线控制面板，用于在物理空间中操作特定虚幻引擎功能的应用程序。

- [为nDisplay创建次级UV](creating-secondary-uvs-for-ndisplay/index.md) - 本指南将介绍如何为nDisplay投影网格体创建二级UV信道，从而让摄像机内视效编辑器充分利用其所有功能。

- [nDisplay配置文件参考](ndisplay-configuration-file-reference/index.md) - nDisplay配置文件中所有可用设置的参考指南。

- [nDisplay快速启动本地工具](ndisplay-quick-launch-local-tool/index.md) - 如何设置并使用nDisplay Launch插件用于本地nDisplay项目渲染。

### 指南

- [为现有项目添加nDisplay](adding-ndisplay-to-an-existing-project/index.md) - 介绍设置供nDisplay使用的现有项目的方法。

### 参考

- [更改nDisplay通信端口](changing-ndisplay-communication-ports/index.md) - 介绍每台计算机上nDisplay用于与群集中其他计算机通信的不同通信端口。

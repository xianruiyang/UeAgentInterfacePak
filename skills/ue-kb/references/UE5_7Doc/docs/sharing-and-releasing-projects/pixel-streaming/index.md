---
title: "像素流送"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pixel-streaming-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "像素流送"]
---

# 像素流送

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 像素流送

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pixel-streaming-in-unreal-engine

虚幻引擎（UE）中的像素流送的工作原理类似于使用在线流送服务流送视频，只是用户可以通过流送界面于与应用程序互动。UE的像素流送系统可以在一台台式个人电脑或云服务器上运行打包的UE应用程序，同时还能运行少量网络服务。用户可以使用台式机或移动设备的网页浏览器连接到通过像素流送的应用程序前端。

连接后，用户可以从远程UE应用程序流送渲染的帧和音频，并通过前端与其交互。它支持以下类型的输入：

- 键盘
- 鼠标
- 触屏输入
- 为玩家的网页创建的自定义HTML5用户界面

由于前端是嵌入网页的，用户无需安装或下载任何外的软件以支持像素流送。

本分段中的页面将提供使用UE自行部署和管理像素流送应用程序的指南和参考。

## 入门

- [像素流送概述](starter-guides-for-pixel-streaming/overview-of-pixel-streaming/index.md) - 简要介绍构成像素流送系统的组件及组件的协作方式。

- [虚幻引擎中的像素流送入门](starter-guides-for-pixel-streaming/getting-started-with-pixel-streaming/index.md) - 启动并运行将虚幻引擎应用程序从一台计算机流送到同一网络上其他计算机和移动设备的过程。

## 指南

- [创建主机和网络连接指南](development-guides-for-pixel-streaming/hosting-and-networking-guide-for-pixel-streaming/index.md) - 高级网络配置和创建像素流送系统的其他注意事项。

- [编辑器中的像素流送](development-guides-for-pixel-streaming/pixel-streaming-in-editor/index.md) - 编辑器流送是一项试验性的功能，利用像素流送的强大能力，让用户能够流送并与虚幻引擎编辑器远程交互。此外，现在推出了一个新工具栏，专门用于编辑器中的像素流送功能。

- [流送优化指南](development-guides-for-pixel-streaming/stream-tuning-guide/index.md) - 介绍在像素流送中如何实现不同的质量、延迟和弹性，并且用示例说明有时优化图像质量、延迟或者弹性其中之一比平衡流送更重要。

- [与像素流送系统交互](development-guides-for-pixel-streaming/interacting-with-the-pixel-streaming-system/index.md) - 在运行时虚幻引擎应用程序可与像素流送系统交互的方式。

- [试验性的像素流送功能](development-guides-for-pixel-streaming/experimental-pixel-streaming-features/index.md) - 像素流送中令人激动的新功能，仍在开发之中，但可以运行！

- [像素流送2概述](development-guides-for-pixel-streaming/pixel-streaming-2-overview/index.md) - 了解关于次世代像素流送的信息。

## 参考

- [像素流参考](unreal-engine-pixel-streaming-reference/index.md) - 介绍像素流系统组件支持的浏览器、联网端口和配置选项。

## 像素流送基础硬件

- [像素流送基础设施](pixel-streaming-web-interface/pixel-streaming-infrastructure/index.md) - 现在像素流送服务器和Web前端在GitHub上进行外部托管，由信令服务器、配对器和SFU组成。这常常称为

- [自定义播放器网页](pixel-streaming-web-interface/customizing-the-player-web-page/index.md) - 如何自定义播放流送视频和音频的网页，以及如何在页面与UE5应用程序之间交换事件。

## 示例内容

%samples-and-tutorials/engine-feature-examples/pixel-streaming-showcase:topic%

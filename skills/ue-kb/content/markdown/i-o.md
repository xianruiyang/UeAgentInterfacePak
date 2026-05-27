# 专业视频I/O

---
title: "专业视频I/O"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/professional-video-io-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "专业视频I/O"]
---

# 专业视频I/O

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 专业视频I/O

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/professional-video-io-in-unreal-engine

![01-page-image_ue5.png](../../../../assets/images/0b/0b0437dfbe8e02111cbc501cecedfde267116e266a8acfdde3a111f6d6ead3e8.jpg)

增强现实体验将传统2D视频与实时3D环境相结合，电影和广播媒体对这种体验的需求正日益旺盛。本节页面说明您可以如何使虚幻引擎充当视频制作管道的无缝部分工作：

- 在虚幻引擎中实时播放专业级别的视频和音频，动态合成到虚拟3D场景中。
- 将各种效果直接应用于虚幻引擎中的导入视频，如色度抠像、镜头不失真、色彩校正等。
- 将虚幻引擎与您输入视频的时间码和帧率同步，以消除计时问题。
- 将视频源从虚幻编辑器或从运行的游戏项目返回到Studio的视频管道。

## 新手入门

- [AJA视频输入/输出快速入门](aja-video-io-quick-start/index.md) - 从支持的AJA媒体卡获取视频放入到虚幻引擎，并将捕获的视频输出从虚幻引擎发送到AJA卡上的端口的详细指南。

- [Blackmagic Video输入/输出快速入门](blackmagic-video-io-quick-start/index.md) - 从支持的Blackmagic媒体卡获取视频放入到虚幻引擎，并将捕获的视频输出从虚幻引擎发送到Blackmagic卡端口上的详细指南。

## 指南

- [时间码和同步锁定](timecode-and-genlock/index.md) - 说明如何使虚幻引擎采用来自AJA视频输入的时间码，以及如何锁定引擎的帧率以匹配源视频。

- [支持多种媒体配置](supporting-multiple-media-configurations/index.md) - 媒体配置文件将输入、输出、时间码和集中同步设置收集到一个地方，以便进行配置。代理帮助路由输入和输出。

## 参考

- [AJA媒体框架参考](aja-media-reference/index.md) - 介绍AJA媒体框架组件公开的选项和设置。

- [Blackmagic媒体框架参考指南](blackmagic-media-reference/index.md) - 介绍Blackmagic Design媒体框架组件公开的选项和设置。

## 示例项目


- [虚拟工作室](../../../samples-and-tutorials/engine-feature-examples/virtual-studio-sample-project/index.md)


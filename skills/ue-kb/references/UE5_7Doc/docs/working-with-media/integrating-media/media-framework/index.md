---
title: "媒体框架"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/media-framework-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架"]
---

# 媒体框架

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/media-framework-in-unreal-engine

UE中现有一个 **启动影片播放器（Startup Movie Player）** 系统，它只能用于引擎加载时播放启动影片。其无法用于播放游戏中的影片，它无法作为UI元素的一部分来播放影片，或在关卡中的一个静态网格体上播放影片（如一台正在播放电影的电视机）。 因此 **媒体框架** 便应运而生，它不仅能执行上述的两个例子，还提供了更多总体媒体播放功能（下有详述）。 它将在未来的版本中替代已废弃的"启动影片播放器"框架。

虚幻引擎中的媒体框架为：

- 与引擎和Slate无关
- 支持本地化音频及视频
- 可在内容浏览器、材质编辑器以及声音系统中使用
- 可与蓝图和UMG UI设计器共用
- 支持流媒体
- 可在媒体上执行快进、倒退、播放、暂停和移动操作
- 支持可插拔播放器

如上所述，媒体框架自身与引擎和Slate无关，意味着其可在任意应用中使用（而非只能在游戏引擎或编辑器中使用）。框架上有多个层，为其他子系统（如 **引擎**、**蓝图**、**Slate** 和 **UMG UI 设计器**）提供媒体播放功能。 这将覆盖多数使用实例，如游戏中的纹理和UI、编辑器中的视频教程，以及商城视频。

此页面包含数个链接，可跳转至媒体框架其他文档。建议查看"总览"页面，了解媒体框架功能详解，以及媒体框架的详细使用说明指南和快速入门页面。

## 必备知识

- [Electra媒体播放器](electra-media-player/index.md)

- [媒体编辑器参考文档](media-editor-reference/index.md)

- [媒体框架概述](media-framework-overview/index.md)

- [Media Framework快速入门指南](media-framework-quick-start/index.md)

- [媒体框架教程](media-framework-unreal-engine-tutorials/index.md)

- [媒体框架技术参考](media-framework-technical-reference/index.md)

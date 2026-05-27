---
title: "硬件光线追踪和路径追踪功能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-and-path-tracing-features-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "硬件光线追踪和路径追踪功能"]
---

# 硬件光线追踪和路径追踪功能

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 硬件光线追踪和路径追踪功能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-and-path-tracing-features-in-unreal-engine

长期以来，影视和可视化领域一直在使用光线追踪技术来渲染逼真的图像，但这种渲染方式通常需要高性能的计算机，而且需要逐图（或逐帧）渲染，非常耗时。如果是建筑可视化内容，通常需要渲染数小时。对于电影和电视，渲染高质量的图像序列可能需要数小时甚至数天。

虚幻引擎使用自身的光线追踪代码库，其实时和离线渲染路径都共享这套代码库。在渲染实时场景时，例如交互式体验或游戏，实时光追路径更加合适。相比而言，离线路径使用内置的路径追踪器生成无损的场景渲染画面。它与[影片渲染队列](https://dev.epicgames.com/documentation/404)无缝协作，输出质量最高的帧渲染。

浏览以下主题，了解有关这些路径的更多信息，以及如何在自己的项目中加以使用。

## 虚幻引擎中的光线追踪

虚幻引擎中的光线追踪支持两种模式：

- 混合

  光线追踪器

  ，将光线追踪功能与用于实时渲染的传统光栅技术相结合。
- 路径追踪器

  ，用于生成高质量、无损的渲染结果。

## 系统要求

计算机必须满足以下系统要求，才能使用虚幻引擎的光线追踪和路径追踪功能：

| 系统要求 |  |
| --- | --- |
| **操作系统** | [Windows 10 RS5（版本1809）或更高版本](https://support.microsoft.com/en-us/help/4028685/windows-10-get-the-update) 在Windows搜索栏中输入 **winver**，确认你的Windows版本。 Linux和Windows上的Vulkan Desktop 关于需要的操作系统构建的详情，请参阅[硬件和软件规格](https://dev.epicgames.com/documentation/404)。 |
| **GPU** | NVIDIA RTX和一些GTX系列显卡，支持DXR，使用最新的设备驱动程序。 有关更多信息，请参阅[此处](https://www.nvidia.com/en-us/geforce/news/geforce-gtx-dxr-ray-tracing-available-now)的NVIDIA网站。 |
| **虚幻引擎版本** | 5.0及以上 |
| **虚幻引擎渲染路径** | 延迟路径 |

## 概述


- [硬件光线追踪](hardware-ray-tracing/index.md)

%building-virtual-worlds/lighting-and-shadows/ray-tracing-and-path-tracing/path-tracer:Topic%

## 指南

%building-virtual-worlds/lighting-and-shadows/ray-tracing-and-path-tracing/ray-tracing-performance-guide:Topic%


- [硬件光线追踪的建议和技巧](hardware-ray-tracing-tips-and-tricks/index.md)

- [如何将影片渲染队列用于高质量渲染](rendering-high-quality-frames-with-movie-render-queue/index.md) - 关于虚幻引擎影片渲染队列功能的配置指南，旨在帮助你便获取高质量过场动画（特别适用于启用光线追踪的情况下）。

## 参考


- [硬件光线追踪和路径追踪器功能属性](ray-tracing-and-path-tracer-features-properties/index.md)

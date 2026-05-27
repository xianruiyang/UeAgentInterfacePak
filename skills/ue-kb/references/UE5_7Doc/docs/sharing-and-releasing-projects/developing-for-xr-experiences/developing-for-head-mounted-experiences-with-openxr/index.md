---
title: "使用OpenXR进行头戴式体验开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-head-mounted-experiences-with-openxr-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "使用OpenXR进行头戴式体验开发"]
---

# 使用OpenXR进行头戴式体验开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 使用OpenXR进行头戴式体验开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-head-mounted-experiences-with-openxr-in-unreal-engine

[OpenXR](https://www.khronos.org/openxr)是一种免版税的开放标准，可提供对XR平台和设备的高性能访问。Epic Games是OpenXR工作组的创始成员之一，组内成员还有Khronos Group和其他行业合作伙伴。这个由多个公司组成的组织致力于使用跨平台的标准来解决XR分段问题。

你可以利用OpenXR在虚幻引擎中营造沉浸式体验，该体验可以在所有支持OpenXR API的系统上实现。目前，虚幻引擎中的OpenXR仅支持头戴式设备。要为手持设备开发XR项目，请参阅[手持增强现实体验开发](../developing-for-handheld-augmented-reality-experiences/index.md)。

![openxr徽标](../../../../assets/images/58/582d90f7190010c62239af658ccabbf3bd8c7b1aed8f724cd21ef7e4f55890b7.jpg)

OpenXR和OpenXR徽标是Khronos Group Inc.的商标。

此页面包含有关OpenXR支持的设备以及如何在虚幻引擎中使用OpenXR开发头戴式设备体验的文档链接。

## OpenXR运行时

每个平台都有OpenXR运行时，它是该平台的OpenXR API的实现。本页面介绍了所有支持的OpenXR运行时以及如何设置你的项目从而加以使用。


- [OpenXR运行时](../getting-started-with-xr-development/openxr-prerequisites/index.md)

### 插件优先级

你的虚幻引擎项目在发行时可以启用以下插件：OpenXR、Oculus、SteamVR和Windows Mixed Reality。当你启动应用程序时，程序会按照插件优先级以从高到低的顺序检查插件列表。选择列表中的第一个插件，应用程序可以连接到它的运行时。

以下是虚幻引擎中当前插件优先级顺序，从高到低排列：

- Oculus
- OpenXR
- Windows Mixed Reality
- SteamVR

## 在虚幻引擎中扩展OpenXR

虚幻引擎中的OpenXR插件支持扩展插件，无论引擎是什么版本，你都可以向OpenXR添加功能。OpenXR扩展插件已经包含在引擎版本中。

虚幻引擎中当前可用于扩展OpenXR插件的插件包括：

- OpenXRHandTracking
- OpenXREyeTracker
- XRVisualization
- OpenXRMsftHandInteraction
- HP Motion Controller
- OpenXRViveTracker
- XRScribe

你还可以从[Fab](https://www.fab.com/)安装扩展插件，也可以自行制作插件。

## 支持的平台

虚幻引擎5支持Windows和Android上的OpenXR设备。 对于通过[OpenXR厂商扩展](https://registry.khronos.org/OpenXR/specs/1.0/extprocess.html)提供的设备特定功能，由设备厂商负责开发和支持。你可以在Fab中找到XR设备的厂商插件。

### 使用原生OpenXR插件的内部验证设备

- Meta Quest 2/3（PC和Android）
- HTC Vive
- Valve Index

### 外部验证设备

> [!NOTE]
> Epic不保证或提供对使用以下平台的设备特定功能的支持。

- Meta Quest
- Windows Mixed Reality
- Varjo
- Pico
- Magic Leap

---
title: "XR开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-xr-experiences-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发"]
---

# XR开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-xr-experiences-in-unreal-engine

XR是指以下体验的集合：

- 增强现实：

  通过手持或可穿戴设备在用户的现实世界视野中叠加感官信息。
- 虚拟现实：

  通过可穿戴设备用虚拟环境替换用户的视野。
- 混合现实：

  增强现实和虚拟现实的融合体验。

虚幻引擎既支持面向XR平台的开发，也支持在内容创建管线中使用XR设备。以下小节包含有关如何在项目中使用XR设备的文档链接。

## 使用OpenXR进行头戴式XR体验开发

[OpenXR](https://www.khronos.org/openxr/)是一种免税的开放标准，可以实现对XR平台和设备的高效利用。你可以利用OpenXR在虚幻引擎中营造沉浸式体验，该体验可以在所有支持OpenXR API的系统上实现。目前，虚幻引擎中的OpenXR仅支持头戴式设备。

本小节将介绍OpenXR在虚幻引擎中的工作原理。


- [使用OpenXR进行头戴式体验开发](developing-for-head-mounted-experiences-with-openxr/index.md)

## 进行手持增强现实体验开发

手持式AR体验与头戴式XR体验存在根本性的区别。本小节将介绍手持AR的入门知识，以及如何使用这些平台中包含的独特功能。


- [为手持式设备开发增强现实体验](developing-for-handheld-augmented-reality-experiences/index.md)

## XR入门指南

本小节将介绍在虚幻引擎中创建XR应用程序的基础知识。


- [XR开发入门](getting-started-with-xr-development/index.md)

## 打造交互式XR体验

XR有许多不同类型的输入，例如手部跟踪、运动控制器和眼部跟踪。本小节将介绍如何在虚幻引擎中向XR应用程序添加输入。


- [制作交互式XR体验](making-interactive-xr-experiences/index.md)

## 为XR体验创建UI

对于XR体验，用户界面（UI）必须是3D的，以便你可以在虚拟环境中与其交互。本小节将指导你了解如何在虚幻引擎中为XR应用程序创建UI。


- [为XR体验设计UI](design-user-interfaces-for-xr-experiences/index.md)

## XR中的共享体验

本小节将介绍如何创建可跨多个XR设备共享的内容。


- [共享XR体验](sharing-xr-experiences/index.md)

## 虚幻引擎中支持的XR平台

本文提供了有关虚幻引擎支持的XR平台和设备以及如何设置的信息。

%sharing-and-releasing-projects/xr-development/supported-xr-platforms:topic%

## 性能和使用XR进行分析

本小节将指导你了解如何分析你的XR应用程序，以及在你需要提高性能时应考虑的事项。


- [XR性能和分析](xr-performance-and-profiling/index.md)

## 使用XR创建内容

虚幻引擎还支持在你的内容创建管线中使用XR，例如在虚拟现实中构建环境，以及将跟踪数据从设备流送到引擎中进行动画处理。这些页面将介绍如何将你的XR设备与虚幻引擎结合使用，而不仅仅是在设备上进行开发。


- [LiveLinkXR](../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/livelinkxr/index.md)

- [Live Link VRPN](../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/live-link-vrpn/index.md) - 使用Live Link VRPN插件，添加来自VR外围设备的跟踪和输入数据

- [使用iOS设备录制面部动画](../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-workflow-guides-and-examples/recording-face-animation-on-ios-device/index.md) - 使用Live Link Face、ARKit和Live Link捕捉面部动画并将其应用于虚幻引擎中的角色。

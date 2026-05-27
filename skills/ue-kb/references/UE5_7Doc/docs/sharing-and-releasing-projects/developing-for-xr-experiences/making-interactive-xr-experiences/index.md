---
title: "制作交互式XR体验"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/making-interactive-xr-experiences-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "制作交互式XR体验"]
---

# 制作交互式XR体验

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 制作交互式XR体验

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/making-interactive-xr-experiences-in-unreal-engine

XR项目通常有许多种输入机制，例如手部追踪、手柄，以及眼部追踪。点击本文中的相关文档链接，了解如何为XR项目添加这类输入机制。

## OpenXR中为头戴式设备准备的输入机制

OpenXR运行时使用交互配置文件来支持各种硬件控制器，并且能够为连接的控制器提供按键/操作绑定。本文将解释输入机制的概念以及虚幻引擎中的OpenXR控制器映射模拟。

## 运动控制器

运动控制器（Motion Controller）表示参与XR设备输入机制的控制器（即手柄）或手。你可以通过运动控制器组件（Motion Controller Component）访问运动控制器，该组件通常连接到项目的Pawn。动作控制器组件继承自场景组件，场景组件支持基于位置的行为，并根据硬件追踪数据移动它所关联的Pawn。此组件会渲染运动控制器，并将控制器暴露给Pawn定义的用户交互。

这些页面将介绍如何在项目中设置运动控制器。

- [使用运动控制器](using-motion-controllers/index.md) - 展示如何使用运动控制器拾取和放置物体。

- [运动控制器组件设置](motion-controller-component-setup/index.md) - 有关如何为VR互动设置运动控制器的信息。

## 手部追踪

目前，有两个平台支持在虚幻引擎中实现手部追踪：HoloLens 2和Oculus Quest。以下小节将介绍了在其支持的各大平台上使用手部追踪的入门知识。

### Oculus Quest

Oculus Quest上的手部追踪可通过 **Oculus VR** 插件实现。目前，还无法在OpenXR项目中使用手部追踪。Oculus Quest上用于手部追踪的API通过Oculus的自定义组件提供。有关显示用户手部，并将其用作输入的更多细节，请参阅Oculus的[手部追踪文档](https://developer.oculus.com/documentation/unreal/unreal-hand-tracking/)。

## 培训教程

观看这些培训教程，学习如何为XR项目添加输入功能。

## 后续步骤

在XR项目中实现输入功能后，请按照这些指南，将更多的功能添加到项目中，并提高其性能。


- [为XR体验设计UI](../design-user-interfaces-for-xr-experiences/index.md)

- [共享XR体验](../sharing-xr-experiences/index.md) - 使用虚幻引擎为多个用户打造沉浸式体验

- [XR性能和分析](../xr-performance-and-profiling/index.md) - 在虚幻引擎中分析虚拟现实项目的工具和方法

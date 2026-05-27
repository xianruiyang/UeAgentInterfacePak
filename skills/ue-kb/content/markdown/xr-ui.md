# 为XR体验设计UI

---
title: "为XR体验设计UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/design-user-interfaces-for-xr-experiences-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "为XR体验设计UI"]
---

# 为XR体验设计UI

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 为XR体验设计UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/design-user-interfaces-for-xr-experiences-in-unreal-engine

你可以将用户界面（UI）添加到混合现实（XR）项目中，以便呈现信息，创建可交互对象。本文列出了在虚幻引擎中为XR应用创建UI的文档链接。

## 3D控件和交互

在XR项目中，UI必须是3D的，以便你可以在虚拟场景中与之交互。下述页面将引导你了解如何在虚幻引擎中创建可交互的3D控件。

## 在头显上显示内容

你可以用Pawn的摄像机组件，在头戴式显示设备（HMD）上添加内容。你可以创建HUD，添加需要跟随玩家的内容。本页面将引导你将项目附加到你的HMD。


- [在HMD中添加显示内容](attaching-items-to-the-hmd/index.md)

## 在头戴式XR体验中显示游戏区域

用户可以在他们的XR设备上定义游戏区域的大小。本文介绍了如何在你的项目中显示用户的游戏区域边界。


- [游戏区域边界可视化](visualizing-play-area-bounds/index.md)

## 头戴式体验的立体图层

你可以通过单独的渲染通道，将纹理发送给头戴式显示器（HMD）。这些纹理可以在不经过后期处理的情况下直接显示。

这些页面介绍了不同类型的立体图层（stereo layer），以及如何在你的项目中使用。


- [OpenXR立体图层](openxr-stero-layers/index.md)

## 头戴式体验的加载屏幕

对于基于HMD的应用来说，你可以将纹理用作加载界面，作为关卡间的过渡效果。本页面介绍如何为项目添加加载界面。


- [OpenXR加载界面](openxr-loading-screens/index.md)

## 后续步骤

为XR项目添加UI界面后，你可以按照下述指南，添加更多功能，改善项目的性能。


- [制作交互式XR体验](../making-interactive-xr-experiences/index.md)

- [共享XR体验](../sharing-xr-experiences/index.md) - 使用虚幻引擎为多个用户打造沉浸式体验

- [XR性能和分析](../xr-performance-and-profiling/index.md) - 在虚幻引擎中分析虚拟现实项目的工具和方法


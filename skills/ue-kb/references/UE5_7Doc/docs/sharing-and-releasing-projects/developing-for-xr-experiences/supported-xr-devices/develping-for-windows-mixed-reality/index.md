---
title: "Windows混合现实开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/develping-for-windows-mixed-reality-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Windows混合现实开发"]
---

# Windows混合现实开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Windows混合现实开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/develping-for-windows-mixed-reality-in-unreal-engine

[Windows混合现实（Windows Mixed Reality）](https://www.microsoft.com/en-us/mixed-reality/windows-mixed-reality)是由[Microsoft](https://www.microsoft.com/)提供的[头戴式虚拟现实](../../developing-for-head-mounted-experiences-with-openxr/index.md)平台，受到OpenXR和虚幻引擎的支持。本文介绍了虚幻引擎如何支持Windows Mixed Reality，以及如何设置环境以使用Windows Mixed Reality进行开发。如需了解虚幻引擎支持哪些设备，请参阅[支持的XR设备](../index.md)获取完整列表。

如需为Windows混合现实VR设备开发虚幻引擎项目，你需要使用 **OpenXR** 插件和 **[Microsoft OpenXR](https://www.fab.com/listings/8c00dec5-60fa-4b23-b861-98ee885419ce)** 插件。

如需了解更多详细信息，请参阅下文中的[使用OpenXR API进行开发](#%E4%BD%BF%E7%94%A8openxrapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)和[使用Windows Mixed Reality API进行开发](#%E4%BD%BF%E7%94%A8windows%E6%B7%B7%E5%90%88%E7%8E%B0%E5%AE%9Eapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)小节。

## 使用OpenXR API进行开发

如需使用OpenXR在虚幻引擎中针对Windows混合现实VR设备进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅Microsoft的

  安装检查列表

  。
- 适用于Windows混合现实的OpenXR Runtime

  。
- 已在项目中启用

  OpenXR

  插件。
- 已经从

  Fab

  安装了

  Microsoft OpenXR

  插件并已启用。

完成使用OpenXR进行开发的所有必要设置之后，你就可以使用OpenXR API针对Windows混合现实VR设备和支持OpenXR API的设备进行开发了。如需获得更多详细信息，请参阅[使用OpenXR进行头戴式体验开发](../../developing-for-head-mounted-experiences-with-openxr/index.md)。

## 使用Windows混合现实API进行开发

如需使用Windows Mixed Reality API在虚幻引擎中针对Windows混合现实VR设备进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅Microsoft的

  安装检查列表
- 已在项目中启用

  Windows混合现实

  插件。

完成使用Windows混合现实插件进行开发的所有必要设置之后，你就可以使用Windows混合现实API为Windows混合现实VR设备打造出色的体验了。

## 开发入门

在使用OpenXR或Windows混合现实插件设置项目之后，即可按照以下指示开始针对XR进行开发。


- [XR开发入门](../../getting-started-with-xr-development/index.md)

- [制作交互式XR体验](../../making-interactive-xr-experiences/index.md) - 为你的虚幻引擎AR和VR项目添加用户输入功能

- [为XR体验设计UI](../../design-user-interfaces-for-xr-experiences/index.md) - 在虚幻引擎中为XR体验设计用户界面

- [XR性能和分析](../../xr-performance-and-profiling/index.md) - 在虚幻引擎中分析虚拟现实项目的工具和方法

## 性能分析

以下内容将介绍如何分析XR应用程序，以及在需要提高性能时应该考虑的事项。

- 虚幻引擎中的XR性能和分析
- 在虚幻引擎中测试和优化内容
- 关于

  使用Unreal Insights进行分析

  的Microsoft文档

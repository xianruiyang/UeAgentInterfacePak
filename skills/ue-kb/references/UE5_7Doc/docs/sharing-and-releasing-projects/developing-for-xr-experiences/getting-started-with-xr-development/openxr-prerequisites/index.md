---
title: "OpenXR运行时"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/openxr-prerequisites-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR开发入门", "OpenXR运行时"]
---

# OpenXR运行时

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR开发入门 / OpenXR运行时

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/openxr-prerequisites-in-unreal-engine

OpenXR运行时

要在虚幻引擎（UE）中开发OpenXR项目，你必须根据开发时针对的平台和硬件安装OpenXR运行时。以下各节介绍如何安装正确的OpenXR运行时以及每个平台需要哪些插件。

> [!WARNING]
> 目前，UE中某些特定于平台的插件与OpenXR插件不兼容。在你的虚幻项目中使用OpenXR插件时，确保禁用Oculus、SteamVR和Windows Mixed Reality插件。

## Windows Mixed Reality

完成以下项目，以开始在虚幻编辑器中使用你安装了OpenXR的Windows Mixed Reality设备：

- 完成Microsoft的

  OpenXR入门指南

  文档中的步骤，在你的计算机上为

  Windows Mixed Reality

  安装

  OpenXR

  运行时。
- 在你的虚幻项目中启用

  OpenXR

  插件。
- 可选：安装

  Microsoft OpenXR插件

## Oculus

完成以下项目，以开始在虚幻编辑器中使用你安装了OpenXR的Oculus设备：

- 完成

  Oculus先决条件

  中的步骤，以设置你的计算机和设备。
- 在你的虚幻项目中启用

  OpenXR

  插件。

## SteamVR

完成以下项目，以开始在虚幻编辑器中使用你安装了OpenXR的SteamVR设备：

- 完成

  SteamVR先决条件

  中的步骤，以设置你的计算机和设备。
- 在你的虚幻项目中启用

  OpenXR

  插件。

## OpenXR运行时环境变量

如果你的计算机上有多个OpenXR运行时，则需要设置一个环境变量，以便虚幻引擎可以找到正确的OpenXR运行时。

虽然每个兼容OpenXR的运行时都 *应该* 支持任何OpenXR设备，但为了获得最佳效果，请安装官方运行时（SteamVR for Vive/Index、Oculus Quest应用，等等）。你可以手动安装，但我们使用并推荐使用[OpenXR Explorer](https://github.com/maluoi/openxr-explorer)。使用它可以在各个OpenXR运行时之间轻松切换，显示运行时支持的一系列扩展，点击[OpenXR规范](https://registry.khronos.org/OpenXR/specs/1.0/pdf/xrspec.pdf)相关部分的直接链接即可检查常用属性和枚举。

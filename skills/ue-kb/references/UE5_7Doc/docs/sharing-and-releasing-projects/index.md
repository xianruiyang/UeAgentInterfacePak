---
title: "分享和发布项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sharing-and-releasing-projects-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目"]
---

# 分享和发布项目

> 路径：虚幻引擎5.7文档 / 分享和发布项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sharing-and-releasing-projects-for-unreal-engine

本文介绍了如何在虚幻引擎支持的平台上打包和发布，并罗列了相关的所有指南。尽管所有平台的打包流程基本通用，但是各个平台仍会有一些特定要求、特有功能，以及专门的调试和优化技巧。

## Deployment

- [构建操作：烘焙、打包、部署、运行](packaging-and-cooking/build-operations-cooking-packaging-deploying-an-ca003a9c/index.md) - 虚幻引擎项目可用的构建操作（烘焙、打包、运行、部署）概述。

- [内容烘焙](packaging-and-cooking/cooking-content/index.md) - 针对游戏中使用的资源生成特定于平台的内容。

- [在设备上启动项目](packaging-and-cooking/launching-unreal-engine-projects-on-devices/index.md) - 通过一键点击将你的游戏部署到像iOS和Android这样的设备上，以进行测试。

- [发布项目](packaging-and-cooking/preparing-unreal-engine-projects-for-release/index.md) - 创建包含已烘焙内容的发布版项目以供发行。

- [在编辑器中使用已烘焙内容](packaging-and-cooking/working-with-cooked-content-in-the/index.md) - 关于在编辑器中使用已烘焙内容的概述。

- [项目启动程序](packaging-and-cooking/using-the-project-launcher/index.md) - 用于部署项目的项目启动程序参考。

- [Unreal Frontend](packaging-and-cooking/using-the-unreal-frontend-tool/index.md) - 用于管理应用程序和部署到主机的工具

## 平台通用支持工具

- [AutoSDK参考](tools-for-general-platform-support/using-the-autosdk-system/index.md) - 用户可以借助AutoSDK系统来分发目标平台SDK，同时根据需要对其进行虚幻引擎配置。

- [Device Manager](tools-for-general-platform-support/connecting-to-and-managing-devices/index.md)

- [设置设备描述](tools-for-general-platform-support/setting-up-device-profiles/index.md) - 设置指定平台配置的设备描述

- [低延迟框架同步](tools-for-general-platform-support/low-latency-frame-syncing/index.md) - 改变线程同步方式以大幅降低输入延迟。

- [电视安全区调试](tools-for-general-platform-support/setting-up-tv-safe-zone-debugging/index.md) - 避免 UI 元素过于靠近电视屏幕边缘

## 通用移动开发

- [移动端开发工具](../mobile-development/development-tools-for-mobile-applications/index.md) - 了解虚幻引擎为移动设备准备的项目构建和调试工具。

- [移动端渲染功能](../mobile-development/rendering-features-for-mobile-games/index.md) - 了解虚幻引擎移动端渲染路径以及其对于图形功能的支持。

- [应用内购买和广告](../mobile-development/in-app-purchases-and-ads-in-unreal-engine-projects/index.md) - 实现常见的移动端服务，例如成就、通知和应用内购。

- [移动端调试和优化](../mobile-development/debugging-and-optimization-for-mobile/index.md) - 关于优化移动端内容的工具和最佳实践。

## iOS、iPadOS和tvOS

- [虚幻引擎中iOS和tvOS相关的入门指南](../mobile-development/ios-ipados-and-tvos-support/getting-started-and-setup-guides-for-ios-and-tvos/index.md) - 了解创建iOS和tvOS应用所需的基础知识。

- [在Windows上开发iOS项目](../mobile-development/ios-ipados-and-tvos-support/working-on-ios-projects-using-a-windows-machine/index.md) - 介绍在Windows设备上进行开发时，简化iOS工作流程的指南。

- [iOS和tvOS开发指南](../mobile-development/ios-ipados-and-tvos-support/developing-on-ios-tvos-and-ipados/index.md) - 使用iOS、tvOS和iPadOS的功能和服务开发项目。

- [打包和发布](../mobile-development/ios-ipados-and-tvos-support/packaging-and-publishing-android-projects/index.md) - 为iOS、tvOS和iPadOS项目创建版本

## Android

- [虚幻引擎Android项目入门指南](../mobile-development/android-support/getting-started-and-setup-for-android-projects/index.md) - 介绍如何设置虚幻编辑器、开发环境和你的Android设备，以便在虚幻引擎中开发项目。

- [Android开发指南](../mobile-development/android-support/developing-guides-for-android/index.md) - 开发安卓项目以及在虚幻引擎中使用安卓相关功能的参考资料

- [打包和发布](../mobile-development/android-support/packaging-and-publishing-android-projects/index.md) - 安卓平台内容发布指南

- [Android调试](../mobile-development/debugging-and-optimization-for-mobile/debugging-for-android-devices/index.md) - 介绍如何使用Visual Studio、Android Studio和虚幻引擎的调试工具在设备上调试Android应用程序。

- [虚幻引擎Android优化指南](../mobile-development/debugging-and-optimization-for-mobile/optimization-guides-for-android/index.md) - 关于优化Android项目性能的最佳实践。

## XR开发（AR和VR）

- [使用OpenXR进行头戴式体验开发](developing-for-xr-experiences/developing-for-head-mounted-experiences-with-openxr/index.md) - 在虚幻引擎中使用OpenXR为头戴式AR和VR设备开发内容。

- [为手持式设备开发增强现实体验](developing-for-xr-experiences/developing-for-handheld-augmented-reality-experiences/index.md) - 在虚幻引擎中为手持式AR设备开发体验

- [XR开发入门](developing-for-xr-experiences/getting-started-with-xr-development/index.md) - 使用虚幻引擎设置你的项目，并为AR和VR设备应用最佳实践。

- [制作交互式XR体验](developing-for-xr-experiences/making-interactive-xr-experiences/index.md) - 为你的虚幻引擎AR和VR项目添加用户输入功能

- [为XR体验设计UI](developing-for-xr-experiences/design-user-interfaces-for-xr-experiences/index.md) - 在虚幻引擎中为XR体验设计用户界面

- [共享XR体验](developing-for-xr-experiences/sharing-xr-experiences/index.md) - 使用虚幻引擎为多个用户打造沉浸式体验

- [支持的XR设备](developing-for-xr-experiences/supported-xr-devices/index.md) - 设置你的增强现实和虚拟现实设备，以用虚幻引擎为其开发内容。

### Microsoft Windows和Xbox主机平台

![GDK](../../assets/images/b9/b96d4ec5b544be911826fec2cfd5c29c78afb1f59f39c936e5ce5db31340593b.jpg)

- 在UDN上查看GDK
- 从虚幻引擎论坛下载

### Nintendo Switch

![Nintendo Switch](../../assets/images/2b/2ba334b05e3a91539bc7205c49ea0ef18b9c380ee872dc5b38adeec79651d2e6.jpg)

- 在UDN上查看Nintendo Switch内容
- 从虚幻引擎论坛下载

## 云部署


- [像素流送](pixel-streaming/index.md)

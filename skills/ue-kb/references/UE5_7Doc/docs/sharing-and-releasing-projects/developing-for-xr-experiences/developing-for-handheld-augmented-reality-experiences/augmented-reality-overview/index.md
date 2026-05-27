---
title: "增强现实概览"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/augmented-reality-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "为手持式设备开发增强现实体验", "增强现实概览"]
---

# 增强现实概览

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 为手持式设备开发增强现实体验 / 增强现实概览

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/augmented-reality-overview-in-unreal-engine

增强现实（AR）是一种将计算机生成的图像覆盖到用户看到的真实场景上的技术，可以提供一种复合视图。

虚幻引擎AR框架提供了一个丰富而统一的框架，以便使用虚幻引擎为iOS和Android手持式平台构建增强现实应用程序。该统一框架为两个平台提供了单一的开发路径，允许开发人员使用单个代码路径为两个平台构建增强现实应用程序。**手持式AR** 蓝图模板提供了一个完整的示例项目，演示虚幻引擎中提供的增强现实功能。

增强现实技术提供了一种用户体验，即将2D或3D元素添加到设备摄像机的实时取景中，使这些元素看起来像是存在于现实世界中。

## 支持iOS和Android版本

统一的AR框架包括对基本AR功能的支持，如对齐、测量亮度、定位、会话状态、追踪结果和追踪。

然而，Android和iOS的增强现实故事正在不断演变。从虚幻引擎4.23开始，我们现在支持最新版ARCore中提供的部分高级功能。

**ARCore 1.7**

- 增强面部
- 增强图像
- 云锚
- 垂直平面检测

**ARKit 3.0**

- 2D图像检测
- 3D对象检测
- 面部追踪
- 持续经验
- 分享经验
- 人物遮挡*
- 动作捕捉（2D、3D、LiveLink）*

* 虚幻引擎4.23.1对此功能提供测试版支持。

> [!TIP]
> Epic Games开发人员 **Joe Graf** 写了几篇内容丰富的博文，讨论了UE4中的ARKit功能。
>
> - UE4 4.20中的2D图像检测
> - UE4 4.20中的ARKit2.0支持
> - UE4 4.20中的AR环境探测器

## 增强现实API

统一的AR框架允许使用虚幻引擎为iOS和Android手持式平台构建增强现实应用程序。该统一AR框架提供了一个新的C++和蓝图函数库，允许开发人员使用单个代码路径为两个平台构建增强现实应用程序。这些新函数也使增强现实技术的使用更加轻松。 如需了解更多细节，可以参阅[虚幻引擎API参考](http://api.unrealengine.com/INT/API/)。

> [!TIP]
> **手持式AR** 蓝图模板提供了一个完整的示例项目，演示虚幻引擎中提供的新的增强现实功能。要探索此项目和新的增强现实功能，可以通过以下方式开始：打开 **内容浏览器（Content Browser）**，导航至 **Content\HandheldARBP\Blueprints\UI**，然后在 **蓝图编辑器（Blueprint Editor）** 中打开 **BP_DebugMenu** 资源。

## 支持的手持式平台

目前我们支持iOS和Android平台。请通读以下页面，了解各个平台上支持的设备类型。

- Apple的iOS设备兼容性参考
- ARCore支持设备概览

值得一提的是，就虚幻引擎来说，其对手持式iOS和Android设备的支持并不新鲜，所以如果您已经在使用虚幻引擎和iOS或Android设备，那么您只需要再进行少量的配置就可以在虚幻引擎中使用增强现实了。

### iOS

有关详细的iOS增强现实先决条件信息，请参阅[ARKit先决条件](../../supported-xr-devices/developing-for-arkit/arkit-prerequisites/index.md)主题。此外，虚幻引擎和iOS设备的基本配置详见虚幻引擎文档的[iOs和tvOS](https://dev.epicgames.com/documentation/404)部分。

### Android

有关详细的Android增强现实先决条件信息，请参阅[使用ARCore的先决条件](../../supported-xr-devices/developing-for-arcore/arcore-prerequisites/index.md)主题。虚幻引擎和Android设备的基本配置详见虚幻引擎文档的[Android快速入门](../../../../mobile-development/android-support/getting-started-and-setup-for-android-projects/setting-up-unreal-engine-projects-for-android-d-db209844/index.md) 部分。

## 虚幻AR初体验

现在已完成有关使用虚幻引擎和增强现实技术基本信息的了解，现在就可以浏览[手持类AR项目模板快速入门](../handheld-ar-template-quickstart/index.md)教程，开启您的体验之旅了。

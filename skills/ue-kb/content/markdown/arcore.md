# ARCore开发

---
title: "ARCore开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-arcore-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "ARCore开发"]
---

# ARCore开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / ARCore开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-arcore-in-unreal-engine

[ARCore](https://developers.google.com/ar)是由[Google](https://www.google.com/)提供的[手持增强现实](../../developing-for-handheld-augmented-reality-experiences/index.md)平台，受到虚幻引擎的支持。本文介绍了虚幻引擎如何支持ARCore，以及你该如何设置环境以使用ARCore进行开发。如需了解虚幻引擎支持哪些设备以及支持哪些版本的SDK，请参阅[支持的XR设备](../index.md)获取完整列表。

## 使用ARCore API进行开发

如需在虚幻引擎中针对ARCore进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅

  Android开发要求

  。
- 已安装Android版Codeworks。
- 已安装Android 26或更高版本。
- 手持Android设备受支持、已配置并且已连接。
- 已在项目中启用

  Google ARCore

  插件。

完成使用ARCore进行开发的所有必要设置之后，你就可以使用ARCore独有的功能为Android设备进行开发了。如需了解虚幻引擎支持哪些功能，请参阅[手持式AR设备功能](../../developing-for-handheld-augmented-reality-experiences/index.md#%E6%89%8B%E6%8C%81%E5%BC%8Far%E8%AE%BE%E5%A4%87%E5%8A%9F%E8%83%BD)。

## 开发入门

在使用Google ARCore插件设置项目之后，即可按照以下指示开始为ARCore设备进行开发。

- [手持类AR项目模板快速入门](../../developing-for-handheld-augmented-reality-experiences/handheld-ar-template-quickstart/index.md) - 本指南介绍了如何使用手持类AR模板来创建项目，并在移动设备上测试你的项目

- [手持类AR模板技术参考](../../developing-for-handheld-augmented-reality-experiences/handheld-ar-template-technical-reference/index.md) - 介绍了手持类AR模板的关键功能及实现方法


- [ARPin](../../sharing-xr-experiences/arpin/index.md)

## 分析

以下内容将介绍如何分析XR应用程序，以及在需要提高性能时应该考虑的事项。

- 虚幻引擎中的XR性能和分析
- 在虚幻引擎中测试和优化内容
- 在Visual Studio中使用AGDE调试Android项目


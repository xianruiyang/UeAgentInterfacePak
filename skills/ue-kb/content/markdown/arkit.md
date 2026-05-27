# ARKit开发

---
title: "ARKit开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-arkit-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "ARKit开发"]
---

# ARKit开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / ARKit开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-arkit-in-unreal-engine

[ARKit](https://developer.apple.com/augmented-reality/)是由[Apple](https://www.apple.com/)提供的[手持增强现实](../../developing-for-handheld-augmented-reality-experiences/index.md)平台，受到虚幻引擎的支持。本文介绍了虚幻引擎对ARKit的支持程度，以及如何设置环境，以便使用ARKit进行开发。如需了解虚幻引擎支持哪些设备，以及支持哪些版本的SDK，请参阅[支持的XR设备](../index.md)获取完整列表。

## 使用ARKit API进行开发

如需在虚幻引擎中针对ARKit进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅

  iOS开发要求

  。
- 已安装Xcode 12或更高版本。
- 已安装iOS 14或更高版本
- 手持iOS设备受支持、已配置并且已连接，搭载A12 Bionic或更高级别的芯片。
- 已在项目中启用

  Apple ARKit

  插件。

完成使用ARKit进行开发的所有必要设置之后，你就可以使用ARKit独有的功能为iOS设备进行开发了。如需了解虚幻引擎支持哪些功能，请参阅[手持式AR设备功能](../../developing-for-handheld-augmented-reality-experiences/index.md#%E6%89%8B%E6%8C%81%E5%BC%8Far%E8%AE%BE%E5%A4%87%E5%8A%9F%E8%83%BD)。

## 开发入门

在使用Apple ARKit插件设置项目之后，即可按照以下指示开始为ARKit设备进行开发。

- [手持类AR项目模板快速入门](../../developing-for-handheld-augmented-reality-experiences/handheld-ar-template-quickstart/index.md) - 本指南介绍了如何使用手持类AR模板来创建项目，并在移动设备上测试你的项目

- [手持类AR模板技术参考](../../developing-for-handheld-augmented-reality-experiences/handheld-ar-template-technical-reference/index.md) - 介绍了手持类AR模板的关键功能及实现方法


- [ARPin](../../sharing-xr-experiences/arpin/index.md)

## 分析

以下内容将介绍如何分析XR应用程序，以及在需要提高性能时应该考虑的事项。

- 虚幻引擎中的XR性能和分析
- 在虚幻引擎中测试和优化内容
- 调试iOS和tvOS项目

## 已知限制

以下是ARKit功能的已知限制：

- 图像检测功能的候选图像必须具有唯一且易识别的名称。如果多个候选图像具有相同的易识别名称，则系统仅会识别第一个具有易识别名称的图像。


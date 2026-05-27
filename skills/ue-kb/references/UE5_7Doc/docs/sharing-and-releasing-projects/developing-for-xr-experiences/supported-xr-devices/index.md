---
title: "支持的XR设备"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/supported-xr-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备"]
---

# 支持的XR设备

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/supported-xr-devices-in-unreal-engine

虚幻引擎支持对多种[XR](../index.md)设备进行开发和内容创建。 本文列出了虚幻引擎支持的XR平台和设备的相关文档。

## 支持的XR设备

以下XR设备已经完成测试和验证，能够使用虚幻引擎。

| 设备 | 平台类型 | 设备类型 | 支持的SDK版本 | 支持状态 | 说明 |
| --- | --- | --- | --- | --- | --- |
| AR设备 |  |  |  |  |  |
| [**运行Android 7.0 (Nougat)和更高版本的Android设备**](https://developers.google.com/ar/devices) | 移动端 | 手持式 | ARCore 1.37 | 支持，关于所支持功能的更多详细信息，请参阅[手持式AR功能](../developing-for-handheld-augmented-reality-experiences/index.md)。 | 如需了解如何针对此设备进行开发，请参阅[针对手持增强现实体验进行开发](../developing-for-handheld-augmented-reality-experiences/index.md)， |
| [**运行iOS 11.0和更高版本的iOS设备**](https://developer.apple.com/documentation/arkit) | 移动端 | 手持式 | ARKit 4.0 | 支持，关于所支持功能的更多详细信息，请参阅[手持式AR功能](../developing-for-handheld-augmented-reality-experiences/index.md)。 | 如需了解如何针对此设备进行开发，请参阅[针对手持增强现实体验进行开发](../developing-for-handheld-augmented-reality-experiences/index.md)， |
| VR设备 |  |  |  |  |  |
| **HTC Vive** | 台式机 | 头戴式 | 不适用 | 最低限度的支持 | 如需了解如何针对此设备进行开发，请参阅[使用OpenXR开发头戴式体验](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **HTC Vive Pro** | 台式机 | 头戴式 | 不适用 | 支持 | 如需了解如何针对此设备进行开发，请参阅[使用OpenXR开发头戴式体验](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **Meta Quest 3** | 台式机 | 头戴式 | Quest SDK Android API Level 29 | 支持 | 如需了解如何针对此设备进行开发，请参阅[针对Oculus进行开发](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **Meta Quest 2** | 移动端 | 头戴式 | Quest SDK Android API Level 29 | 支持 | 如需了解如何针对此设备进行开发，请参阅[针对Oculus进行开发](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **Meta Quest 2 / 3 with Link** | 台式机 | 头戴式 | 不适用 | 支持 | 如需了解如何针对此设备进行开发，请参阅[针对Oculus进行开发](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **PSVR** | 主机 | 头戴式 | 不适用 | 支持 | 如需了解如何针对此设备进行开发，请咨询Epic专业支持或论坛。 |
| **PSVR2** | 主机 | 头戴式 | 不适用 | 支持 | 如需了解如何针对此设备进行开发，请咨询Epic专业支持或论坛。 |
| **Valve Index** | 台式机 | 头戴式 | 不适用 | 支持 | 如需了解如何针对此设备进行开发，请参阅[使用OpenXR开发头戴式体验](../developing-for-head-mounted-experiences-with-openxr/index.md)。 |
| **Apple Vision Pro** | 移动端 | 头戴式 | visionOS 1.1 | 支持 | 如需了解如何针对此设备进行开发，请参阅[Apple Vision Pro快速入门指南](https://dev.epicgames.com/community/learning/tutorials/1JWr/unreal-engine-apple-vision-pro-quick-start-guide)。 |

## 支持的XR平台

以下各小节将介绍与虚幻引擎中支持的XR平台有关的信息。

如需了解如何使用OpenXR进行开发，请参阅使用[OpenXR开发头戴式体验](../developing-for-head-mounted-experiences-with-openxr/index.md)。

### ARCore

[ARCore](https://developers.google.com/ar)是一个[手持式增强现实](../developing-for-handheld-augmented-reality-experiences/index.md)平台，由[Google](https://www.google.com/)提供，受虚幻引擎支持。 本文介绍了虚幻引擎如何支持ARCore，以及你该如何设置环境以使用ARCore进行开发。

- [ARCore开发](developing-for-arcore/index.md) - 如何在虚幻引擎中针对支持ARCore的设备进行开发

### ARKit

[ARKit](https://developer.apple.com/augmented-reality/)是一个[手持式增强现实](../developing-for-handheld-augmented-reality-experiences/index.md)平台，由[Apple](https://www.apple.com/)提供，受虚幻引擎支持。 本文介绍了虚幻引擎对ARKit的支持程度，以及如何设置环境，以便使用ARKit进行开发。

- [ARKit开发](developing-for-arkit/index.md) - 如何在虚幻引擎中针对支持ARKit的设备进行开发

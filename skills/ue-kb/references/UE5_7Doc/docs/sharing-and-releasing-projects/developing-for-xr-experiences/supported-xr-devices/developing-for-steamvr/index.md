---
title: "SteamVR开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-steamvr-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "SteamVR开发"]
---

# SteamVR开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / SteamVR开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-steamvr-in-unreal-engine

> [!WARNING]
> 虚幻引擎5.1已经停用SteamVR插件。请改用OpenXR插件。

[SteamVR](https://www.steamvr.com/)是由[Valve](https://www.valvesoftware.com/)提供的[头戴式虚拟现实](../../developing-for-head-mounted-experiences-with-openxr/index.md)平台，受到OpenXR和虚幻引擎的支持。本文介绍了虚幻引擎如何支持SteamVR，以及如何设置环境以使用SteamVR进行开发。

SteamVR支持Vive、Oculus和Windows混合现实头戴设备。如需了解虚幻引擎支持哪些XR设备，请参阅[支持的XR设备](../index.md)获取完整列表。

目前，你可以使用 OpenXR 插件或 SteamVR 插件针对SteamVR进行开发:

- 在使用OpenXR插件进行开发时，你的应用程序可以在支持OpenXR API的设备上运行。
- 在使用SteamVR插件进行开发时，你的应用程序只能在SteamVR支持的设备上运行。部分虚幻引擎功能，例如

  Live Link XR

  需要具有SteamVR插件才能使用。

如需了解更多详细信息，请参阅下文中的[使用OpenXR API进行开发](#%E4%BD%BF%E7%94%A8openxrapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)和[使用SteamVR API进行开发](#%E4%BD%BF%E7%94%A8steamvrapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)小节。

## 使用OpenXR API进行开发

如需使用OpenXR在虚幻引擎中对SteamVR进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅设备的系统和硬件要求。
- SteamVR 1.5.17或更高版本
- 适用于SteamVR的OpenXR Runtime
- 已在项目中启用

  OpenXR

  插件

完成使用OpenXR进行开发的所有必要设置之后，你就可以使用OpenXR API针对SteamVR和支持OpenXR API的设备进行开发了。如需获得更多详细信息，请参阅[使用OpenXR进行头戴式体验开发](../../developing-for-head-mounted-experiences-with-openxr/index.md)。

## 使用SteamVR API进行开发

如需使用SteamVR插件进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅设备的系统和硬件要求。
- SteamVR 1.5.17或更高版本
- 已在项目中启用

  SteamVR

  插件

在准备好使用SteamVR插件进行开发之后，你就可以使用SteamVR API功能为支持SteamVR的设备进行开发了。

## 开发入门

在使用OpenXR或SteamVR插件设置项目之后，即可按照以下指示开始针对XR进行开发。


- [XR开发入门](../../getting-started-with-xr-development/index.md)

- [制作交互式XR体验](../../making-interactive-xr-experiences/index.md) - 为你的虚幻引擎AR和VR项目添加用户输入功能

- [为XR体验设计UI](../../design-user-interfaces-for-xr-experiences/index.md) - 在虚幻引擎中为XR体验设计用户界面

- [XR性能和分析](../../xr-performance-and-profiling/index.md) - 在虚幻引擎中分析虚拟现实项目的工具和方法

## 故障排除和分析

以下内容将介绍如何分析XR应用程序，以及在需要提高性能时应该考虑的事项。

- 虚幻引擎中的XR性能和分析
- 在虚幻引擎中测试和优化内容
- SteamVR帧计时

如果遇到头戴设备的相关问题，请访问[SteamVR支持中心](https://support.steampowered.com/kb_article.php?ref=8566-SDZC-9326)或[HTC Vive支持中心](https://www.vive.com/us/support/)获得有关故障排除方面的帮助。

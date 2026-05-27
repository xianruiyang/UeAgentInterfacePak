---
title: "Oculus开发"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/developing-for-oculus-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发"]
---

# Oculus开发

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/developing-for-oculus-in-unreal-engine

> [!WARNING]
> 虚幻引擎5.1已经停用OculusVR插件。请改用OpenXR插件。

[Oculus](https://www.oculus.com/)是由[Meta](https://about.facebook.com/meta/)提供的[头戴式虚拟现实](../../developing-for-head-mounted-experiences-with-openxr/index.md)平台，受到虚幻引擎的支持。本文介绍了虚幻引擎如何支持Oculus，以及你该如何设置环境以使用Oculus进行开发。如需了解虚幻引擎支持哪些Oculus设备，请参阅[支持的XR设备](../index.md)获取完整列表。

目前，你可以使用 **OpenXR** 插件或 **Oculus VR** 插件针对Oculus设备进行开发:

- 在使用OpenXR插件进行开发时，你的应用程序可以在支持OpenXR API的设备上运行。
- 在使用Oculus VR插件进行开发时，你的应用程序可以使用Oculus独有但目前未包含在 **Oculus OpenXR** 扩展插件中的功能。

如需了解更多详细信息，请参阅下文中的[使用OpenXR API进行开发](#%E4%BD%BF%E7%94%A8openxrapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)和[使用Oculus API进行开发](#%E4%BD%BF%E7%94%A8oculusapi%E8%BF%9B%E8%A1%8C%E5%BC%80%E5%8F%91)小节。

## 使用OpenXR API进行开发

如需使用OpenXR在虚幻引擎中针对Oculus进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅[Oculus的系统和硬件要求](https://developer.oculus.com/documentation/mobilesdk/latest/concepts/mobile-reqs#mobile-reqs)
- [Oculus应用](https://www.oculus.com/setup/)
- Oculus Runtime v33.0或更高版本
- [适用于Oculus的OpenXR Runtime](../../getting-started-with-xr-development/openxr-prerequisites/index.md)
- 已在项目中启用 **OpenXR** 插件
- （仅限Oculus Quest）已在项目中启用 **Oculus OpenXR** 插件

完成使用OpenXR进行开发的所有必要设置之后，你就可以使用OpenXR API针对Oculus设备和支持OpenXR API的设备进行开发了。如需获得更多详细信息，请参阅[使用OpenXR进行头戴式体验开发](../../developing-for-head-mounted-experiences-with-openxr/index.md)。

## 使用Oculus API进行开发

如需使用Oculus的专用API在虚幻引擎中针对Oculus进行开发，必须设置以下内容：

- 已更新硬件和软件。请参阅[Oculus的系统和硬件要求](https://developer.oculus.com/documentation/mobilesdk/latest/concepts/mobile-reqs#mobile-reqs)
- [Oculus应用](https://www.oculus.com/setup/)
- Oculus Runtime v33.0或更高版本
- 已在项目中启用 **Oculus VR** 插件

完成使用Oculus VR插件进行开发的所有必要设置之后，你就可以使用OpenXR API中尚未提供的Oculus独有功能了。以下功能目前只能通过Oculus VR插件提供给Oculus设备：

- [使用Oculus Quest进行手部追踪](../../making-interactive-xr-experiences/index.md#oculusquest)
- [固定注视点渲染](../../xr-performance-and-profiling/xr-performance-features/index.md#%E5%8F%AF%E5%8F%98%E9%80%9F%E7%8E%87%E7%9D%80%E8%89%B2%E5%92%8C%E5%9B%BA%E5%AE%9A%E6%B3%A8%E8%A7%86%E7%82%B9%E6%B8%B2%E6%9F%93)

## 开发入门

在使用 **OpenXR** 或 **Oculus VR** 插件设置项目之后，即可按照以下指示开始为Oculus设备进行开发。


- [XR开发入门](../../getting-started-with-xr-development/index.md)


- [制作交互式XR体验](../../making-interactive-xr-experiences/index.md)


- [为XR体验设计UI](../../design-user-interfaces-for-xr-experiences/index.md)


- [XR性能和分析](../../xr-performance-and-profiling/index.md)

## Oculus上的自动实例化

**绘制调用** 是用于绘制对象的RHI命令。**自动实例化** 是一种将多个绘制调用自动组合成单个实例化绘制调用的功能。**实例化绘制调用** 可供图形API为具有不同属性的类似对象绘制多个实例。这些属性可以是与网格体渲染相关的任何属性：位置、方向、颜色等等。本页面提供在Oculus Quest上进行自动实例化有关的更多详细信息。


- [Oculus上的自动实例化](auto-instancing-on-oculus/index.md)

## 故障排除和分析

以下内容将介绍如何分析XR应用程序，以及在需要提高性能时应该考虑的事项。

- [虚幻引擎中的XR性能和分析](../../xr-performance-and-profiling/index.md)
- [在虚幻引擎中测试和优化内容](../../../../testing-and-optimizing-content/index.md)
- 关于[优化工具](https://developer.oculus.com/documentation/unreal/ts-book-tools)的Oculus页面

如果遇到Oculus头戴设备的相关问题，请访问[Oculus支持中心](https://support.oculus.com/)获得有关故障排除方面的帮助。

# UE5.1 中弃用特定于供应商的 XR 插件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/3K4V/unreal-engine-deprecation-of-vendor-specific-xr-plugins-in-ue5-1

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2679 字符。

## 摘要

UE5.1 中弃用特定于供应商的 XR 插件 本文由 Joe Conley 撰写 长期以来，Epic 为每个头戴式显示器供应商创建了定制插件。你可以在代码中看到很多这样的例子，......

## 中文整理

### 概览

*本文由 [Joe Conley](https://dev.epicgames.com/community/profile/zZeJ/Joe_Conley) 撰写* 长期以来，Epic 为每个头戴式显示器供应商创建了定制插件。你可以在代码中看到很多这样的例子，从 OculusVR 到 SteamVR，再到 Microsoft Mixed Reality 等。这个过程涉及到每个供应商以略有不同的方式解决相同的问题（立体渲染、帧节奏、镜头失真等），并且供应商对于如何解决特定问题并不总是做出相同的决定，因此有许多单独的插件需要单独维护，并且不同供应商的相同功能的实现质量水平也不同。由于这种方法无法大规模继续实施，Epic 和业内其他主要供应商与 Khronos 组建了 OpenXR 联盟。结果是 [OpenXR 规范](https://registry.khronos.org/OpenXR/specs/1.0/html/xrspec.html)，它定义了应用程序（在本例中为虚幻引擎）如何与 XR 设备通信的 API。它定义了最佳实践，并确保供应商和应用程序以合理、标准的方式做事，以便应用程序可以为 OpenXR 实现一次，并且它应该可以跨不同供应商的所有 OpenXR 运行时运行。一段时间以来，OpenXR 一直是 Epic 头戴式显示器相关开发的主要焦点，在 5.1 中，我们将弃用定制的 OculusVR 和 SteamVR 插件，转而使用 OpenXR（在早期版本中，Windows 混合现实插件已被弃用，取而代之的是 OpenXR）。可能存在一些特定于供应商的功能，这些功能可能不在核心 OpenXR 规范的当前版本中，但这些功能可能会作为供应商在其运行时实现的 OpenXR 规范的供应商扩展提供，并且供应商还可能会发布与我们的虚幻引擎 OpenXR 插件结合使用的插件来支持该功能。随着功能的成熟并在多个供应商中变得通用，它们可能会被添加到核心 OpenXR 规范中，并且虚幻引擎将根据需要添加支持。某些功能可能需要供应商提供的自定义插件来代替我们的 OpenXR 插件，甚至需要对虚幻引擎进行修改，但对第三方插件和引擎修改的支持必须由提供它们的供应商提供。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

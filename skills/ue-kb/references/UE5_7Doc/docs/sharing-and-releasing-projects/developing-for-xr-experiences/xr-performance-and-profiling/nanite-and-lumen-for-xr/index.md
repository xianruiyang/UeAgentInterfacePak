---
title: "XR的Nanite和Lumen"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/nanite-and-lumen-for-xr-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR性能和分析", "XR的Nanite和Lumen"]
---

# XR的Nanite和Lumen

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR性能和分析 / XR的Nanite和Lumen

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/nanite-and-lumen-for-xr-in-unreal-engine

> [!NOTE]
> XR上的Nanite和Lumen被视为试验性的功能，不受官方支持。

## 要求

- 仅在具有延迟渲染器和DX12的PC上受到支持。
- 在移动XR硬件上不受支持。

## 注意事项

XR设备和平台附带特殊注意事项和限制。自虚幻引擎5.1起，[Nanite](https://dev.epicgames.com/documentation/404)和[Lumen](../../../../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/index.md)在两个视图（XR头戴设备的每个显示器）中渲染，因此即使使用顶级硬件，你也可能难以达到目标帧率。

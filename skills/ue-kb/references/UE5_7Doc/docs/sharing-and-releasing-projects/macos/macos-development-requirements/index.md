---
title: "MacOS开发要求"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/macos-development-requirements-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "MacOS", "MacOS开发要求"]
---

# MacOS开发要求

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / MacOS / MacOS开发要求

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/macos-development-requirements-for-unreal-engine

本文介绍了在MacOS上开发虚幻引擎（UE）项目所需的软件开发工具包（SDK）要求。

## 推荐硬件

|  |  |
| --- | --- |
| **推荐操作系统** | 最新版macOS Sonoma 14 |
| **推荐处理器** | Apple Silicon M3 |
| **最低处理器** | M1或M2（具体取决于渲染功能需求） |
| **推荐内存** | 32 GB或更高 |
| **最低内存** | 16 GB RAM |
| **显卡** | 兼容Metal 1.2的显卡 |

## 最低软件要求

运行引擎或编辑器的最低要求如下。

| 运行引擎 |  |
| --- | --- |
| **最低操作系统** | Sonoma 14.0 |

程序员使用该引擎开发的要求如下。

| 使用引擎开发 |  |
| --- | --- |
| **推荐Xcode版本** | 15.4或更高版本 |
| **最低Xcode版本** | Xcode 15.2 |

> [!TIP]
> 虽然macOS开发首选Xcode，但虚幻引擎还支持VS Code和Rider。

## UE5渲染功能要求

| UE5功能 | 系统要求 |
| --- | --- |
| **Lumen全局光照和软件光线追踪反射** | 配备英特尔和AMD GPU和/或Apple Silicon M1+的苹果电脑。如需了解详情，请参阅[Lumen技术细节](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/global-illumination/lumen/TechOverview)。 |
| **支持硬件光线追踪和MegaLights的Lumen全局光照和反射** | 目前尚不支持。如需了解详情，请参阅[Lumen技术细节](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/global-illumination/lumen/TechOverview)。 |
| **Nanite虚拟几何体和虚拟阴影贴图** | Apple Silicon M2+（beta支持）。如需了解详情，请参阅[Nanite虚拟几何体](https://dev.epicgames.com/documentation/assets/designing-visuals-rendering-and-graphics/rendering-optimization/nanite)。 |
| **时间超级分辨率** | 配备英特尔和AMD GPU和/或Apple Silicon M1+的苹果电脑。如需了解详情，请参阅[时间超级分辨率](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/anti-aliasing-and-upscaling/temporal-super-resolution/index.md)。需要注意一些运行时间成本。 如需了解详情，请参阅我们的技术博客上的[抗锯齿性能](https://www.unrealengine.com/en-US/tech-blog/unreal-engine-5-2-brings-native-support-for-apple-silicon-and-other-developments-for-macos)。 |

## 版本历史记录

| UE版本 | 最低macOS版本 | 推荐macOS版本 | 最低Xcode版本 | 推荐Xcode版本 | 说明 |
| --- | --- | --- | --- | --- | --- |
| 5.6 | Sonoma 14.0 | 最新的macOS 14 Sonoma | Xcode 15.2 | 15.4或更高版本 |  |
| 5.5 | Ventura 13.5 | 最新版macOS 13 Ventura | Xcode 15.2 | 15.4或更高版本 |  |
| 5.4 | macOS 13 Ventura | 最新版macOS 13 Ventura | Xcode 14.1 | 最新版Xcode 14 |  |
| 5.2 - 5.3 | macOS 12.5 Monterey | 最新版macOS 13 Ventura | Xcode 14.1 | 最新版Xcode 14 | 虚幻编辑器及通用二进制文件通过Epic Games启动程序分发到macOS上。 通用二进制文件需要使用代码插件才能被视为与macOS兼容。MacOS要求现已更新，以与iOS要求保持一致。 |
| 5.1 | macOS 12 Monterey | 最新版macOS 13 Ventura | Xcode 13.4.1 | 最新版Xcode 14 | 对于macOS目标，编辑器和项目构建都已实现对Apple Silicon的原生支持。 编辑器对Apple Silicon的支持还在实验阶段。 某些第三方SDK和插件尚未包含ARM64切片，可能存在兼容问题。 |
| 5.0 | macOS Catalina 10.15.7 | 最新版macOS Monterey | Xcode 12.4 | 最新版Xcode 13 | 初步添加了macOS目标对Apple Silicon的原生支持。 某些SDK尚不包含ARM64切片（例如 Steam，Vivox）。 |

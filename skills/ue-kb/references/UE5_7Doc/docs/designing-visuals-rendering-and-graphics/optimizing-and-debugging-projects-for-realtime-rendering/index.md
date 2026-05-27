---
title: "优化和调试实时渲染项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/optimizing-and-debugging-projects-for-realtime-rendering-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目"]
---

# 优化和调试实时渲染项目

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/optimizing-and-debugging-projects-for-realtime-rendering-in-unreal-engine

优化项目并非始终是个易事。获取最佳性能也并非易事，有些时候，毫秒之差就会产生巨大的影响。

## 开始优化项目

你可以从多个地方入手优化项目，从而改善性能。首先可以改进内容创作工作流、进行性能分析捕捉，了解用于渲染各帧所用的时间，以及使用编辑器内置工具。

虚幻引擎已经去繁从简，帮助你优化项目性能，不必再进行任何设置。然而，这并不代表你不能调整内置系统，从而更好地满足项目需求。

以下指南可帮助你确认常见的性能问题，了解如何发现问题。你还可以了解编辑器中可用于优化和改进性能的部分工具。


- [实时渲染优化指南](guidelines-for-optimizing-rendering-for-real-time/index.md)

## 渲染管线优化

部分优化选择会直接影响到虚幻引擎所用的渲染管线。它们可以改善项目的整体性能，或者更合适你希望开发的特定平台。

例如，虚幻引擎的延迟路径（默认）和前向渲染器提供了多种渲染路径。对于VR和移动平台，前向渲染器可以改进性能，但并不支持引擎的全部渲染功能。

在其他情况下，渲染管线能够以更低的分辨率进行渲染并随后上推，而非直接以原始分辨率渲染，从而优化性能，同时维持了和原始分辨率相同的视觉保真度。


- [XR最佳实践](forward-shading-renderer/index.md)

- [屏幕百分比与时序上采样](screen-percentage-with-temporal-upscale/index.md) - 介绍了屏幕百分比和时序上采样。

- [动态分辨率](dynamic-resolution/index.md) - 介绍如何动态调整屏幕分辨率来提升性能。

## 配置文件和扩展性优化

你可以通过控制台命令和配置文件设置属性，根据开发应用的平台或体验，相应地扩展项目。

控制台命令可用于调用与设置特定属性。它们可以在配置文件和扩展性设置中使用，提升项目开发或最终发布产品的渲染图片质量，同时优化性能。配置文件会存储可调用的扩展性设置，自动在项目中设置它们，并且可以针对特定平台。

例如，配置文件可以设置有多个扩展性选项，使用户能够从中选择，让应用在低端硬件上更流畅地运行。配置文件也可以存储专为特定平台设计的预设，使在该平台上运行的应用得到最佳的优化。


- [配置文件](../../cpp-programming/programming-in-the-unreal-engine-architecture/configuration-files/index.md)

- [命令行参数](../../cpp-programming/programming-in-the-unreal-engine-architecture/command-line-arguments/index.md) - 可以传递到引擎可执行文件以自定义引擎在启动时的运行方式的参数。

- [抗锯齿和上采样](anti-aliasing-and-upscaling/index.md) - 虚幻引擎中提供的抗锯齿选项的简要概述。

- [硬件光线追踪的建议和技巧](../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/hardware-ray-tracing-tips-and-tricks/index.md) - 介绍了使用硬件光线追踪开发项目时有助于项目开发的一系列技巧。

- [伸缩性和开发人员](scalability/scalability-and-the-developer/index.md) - 概述了伸缩性选项以及内容开发者、测试者、程序员和项目经理需要考虑的内容。

- [Stat命令](../../testing-and-optimizing-content/stat-commands/index.md) - 专门针对显示游戏统计的控制台命令。

%building-virtual-worlds/lighting-and-shadows/ray-tracing-and-path-tracing/ray-tracing-performance-guide:Topic% %designing-visuals-rendering-and-graphics/rendering-optimization/scalability/ScalabilityReference:Topic%

## 资产优化

项目中的资产优化从开发项目时选择的工作流程开始。有时这意味着你需要使用最适合虚幻引擎工具的方式创建资产。而在其他情况下，内置编辑器工具就能替你代劳。

例如，人工为每个对象创建的细节等级（LOD）网格体是个费时费力的过程。虚幻引擎提供了自动工具，能够为你的网格体生成LOD。你甚至可以配置人工生成LOD的属性，或者让工具自动执行任务。

以下内置工具和系统可以帮助你在项目开发中改善性能。

%designing-visuals-rendering-and-graphics/rendering-optimization/nanite:Topic%


- [可视性和遮挡剔除](visibility-and-occlusion-culling/index.md)

- [纹理流送](texture-streaming/index.md) - 用于在运行时在内存中加载和卸载纹理的系统。

- [虚拟纹理](virtual-texturing/index.md) - 介绍虚幻引擎中虚拟纹理的使用方法。

- [分层细节级别（HLOD）](../../building-virtual-worlds/hierarchical-level-of-detail/index.md) - 关于虚幻引擎中HLOD系统的信息

- [创建并使用 LOD](../../working-with-content/static-meshes/creating-and-using-lods/index.md) - 如何创建并使用 LOD。

- [根据平台设置LOD](../../working-with-content/static-meshes/setting-up-per-platform-lods/index.md) - 讲解如何根据平台设置LOD。

- [为静态网格体自动生成LOD](../../working-with-content/static-meshes/static-mesh-automatic-lod-generation/index.md) - 如何在UE5中使用自动LOD生成系统。

- [代理几何工具](../../working-with-content/static-meshes/proxy-geometry-tool/index.md) - 代理几何工具集是一种提高您的虚幻引擎4(UE4)项目性能，同时保持您项目的视觉质量不受影响的工具。

## 调试和性能分析工具

虚幻引擎提供了自己的调试和性能分析工具，并为一些外部应用提供了插件。这些工具适合用于辨识与甄别能够提升性能的区域。

例如，使用关卡编辑器的可视化模式，就能在屏幕中通过视觉效果，确认当前渲染的材质开销。CPU和GPU性能分析工具可以捕捉单独一帧，解析渲染该帧所需的毫秒时间。凭借这类信息，你就能理解单独一阵中渲染最久的部分。调查高开销的行列项目，才能够进一步优化这些元素。

以下工具能帮助你调试项目元素并分析性能，以寻找优化性能的机会。

%designing-visuals-rendering-and-graphics/rendering-optimization/render-doc:Topic%


- [Unreal Insights](../../testing-and-optimizing-content/unreal-insights/index.md)

- [GPU转储文件查看器工具](gpudump-viewer-tool/index.md) - 这个多平台命令可以将中间RDG纹理和缓冲转储至磁盘中，用以调查并调试渲染问题。

- [渲染资源查看器](render-resource-viewer/index.md) - 一个帮助识别分配给GPU内存的资源及其资产的工具。

- [图元调试器](primitive-debugger/index.md) - 这是一项仅适用于运行时的工具，可以查看游戏客户端中渲染的图元相关的信息。

## 其他话题


- [如何修复GPU驱动程序崩溃](dealing-with-a-gpu-crash-when-using/index.md)

---
title: "IMG媒体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/img-media-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "IMG媒体"]
---

# IMG媒体

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / IMG媒体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/img-media-settings-in-the-unreal-engine-project-settings

## IMG媒体

### 通用

| **设置** | **说明** |
| --- | --- |
| **默认帧率（Default Frame Rate）** | 图像序列或媒体源中未指定时要使用的默认帧率（默认值 = 1/24）。 你可以从以下选项中选择： **12 fps（动画）** **15 fps** **24 fps（电影）** **25 fps (PAL/25)** **30 fps** **48 fps** **50 fps (PAL/50)** **60 fps** **100 fps** **120 fps** **23.976 fps (NTSC/24)** **29.97 fps (NTSC/30)** **59.94 fps (NTSC/60)** **自定义（Custom）** |

### 缓存

| **设置** | **说明** |
| --- | --- |
| **后面缓存百分比（Cache Behind Percentage** | 要用于播放头后面的帧的缓存百分比（默认值 = 25%）。 |
| **缓存大小GB（Cache Size GB）** | 预读缓存的最大大小（以GB为单位；默认值 = 1 GB）。 |
| **缓存线程（Cache Threads）** | 要使用的图像缓存线程的最大数量（0 = 核心数量，默认值 = 8）。 |
| **全局缓存大小GB（Global Cache Size GB）** | 全局预读缓存的最大大小（以GB为单位；默认值 = 1 GB）。 必须大于或等于 `CacheSizeGB` 。 |
| **使用全局缓存（Use Global Cache）** | 启用后，将使用全局缓存。 |
| **缓存线程堆栈大小KB（Cache Thread Stack Size KB）** | 每个缓存线程的堆栈大小（以KB为单位；默认值 = 128）。 |

### EXR

| **设置** | **说明** |
| --- | --- |
| **Exr解码器线程（Exr Decoder Threads）** | 解码EXR图像时要使用的工作线程数量（0 = 自动）。 |

### 代理

| **设置** | **说明** |
| --- | --- |
| **默认代理（Default Proxy）** | 默认媒体源代理URL的名称（默认值 = `proxy` ）。 图像序列媒体源可能包含多个媒体源URL。额外的URL称为媒体源代理，通常用于切换到更低分辨率的媒体内容，以在开发和测试期间提高性能。 每个代理URL都有关联的名称，例如 `proxy` 、 `lowres` 或其他用户定义的标签。媒体源负责解译该值并将其映射到媒体源URL。例如，若媒体源由未压缩图像序列构成，则可能将代理名称用作包含代理内容（例如，低分辨率版本的图像序列）的子目录的名称。 若 `UseDefaultProxy` 设置启用默认代理，媒体播放器将首先尝试找到通过 `DefaultProxy` 标签识别的代理内容。如果没有此类代理内容可用，将回退到媒体源的默认URL。 请参阅此页面上的 **使用默认代理（Use Default Proxy）** 。 |
| **使用默认代理（Use Default Proxy）** | 定义是否启用图像序列代理（默认值 = false）。 图像序列媒体源可能包含多个媒体源URL。额外的URL称为媒体源代理，通常用于切换到更低分辨率的媒体内容，以在开发和测试期间提高性能。 每个代理URL都有关联的名称，例如 `proxy` 、 `lowres` 或其他用户定义的标签。媒体源负责解译该值并将其映射到媒体源URL。例如，若媒体源由未压缩图像序列构成，则可能将代理名称用作包含代理内容（例如，低分辨率版本的图像序列）的子目录的名称。 若 `UseDefaultProxy` 设置启用默认代理，媒体播放器将首先尝试找到通过 `DefaultProxy` 标签识别的代理内容。如果没有此类代理内容可用，将回退到媒体源的默认URL。 请参阅此页面上的 **默认代理（Default Proxy）** 。 |

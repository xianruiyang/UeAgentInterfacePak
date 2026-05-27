---
title: "WMF媒体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/wmf-media-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "WMF媒体"]
---

# WMF媒体

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / WMF媒体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/wmf-media-settings-in-the-unreal-engine-project-settings

## WMF媒体

### 媒体

| **设置** | **说明** |
| --- | --- |
| **允许非标准编码解码器（Allow Non Standard Codecs）** | 定义是否允许加载使用非标准编码解码器的媒体（默认值 = off）。 默认情况下，播放器将尝试检测操作系统并未现成支持的音频和视频编码解码器，但可能需要用户安装其他编码解码器包。 启用此选项以跳过此检查并允许使用非标准编码解码器。 |
| **低延迟（Low Latency）** | 在Windows媒体管线中启用低延迟处理（默认值 = off）。 启用此设置后，会使用尽可能最低的延迟生成媒体数据。 对于特定实时应用程序，这可能受欢迎，但它可能对音频和视频质量造成负面影响。 此设置仅在Windows 8或更新版本上受到支持。 |
| **硬件加速视频解码（试验性）（Hardware Accelerated Video Decoding (Experimental)）** | 尽可能使用硬件加速视频加速（GPU），否则回退到软件实现（CPU）。仅限Windows和DX11。 |

### 调试

| **设置** | **说明** |
| --- | --- |
| **原生音频输出（Native Audio Out）** | 通过操作系统的原生混音器播放音轨（默认值 = off）。 |

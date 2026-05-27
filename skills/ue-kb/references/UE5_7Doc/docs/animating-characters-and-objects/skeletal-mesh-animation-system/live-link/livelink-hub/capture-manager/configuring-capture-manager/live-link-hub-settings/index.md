---
title: "Live Link Hub设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/live-link-hub-settings"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "LiveLink Hub", "捕获管理器", "配置捕获管理器", "Live Link Hub设置"]
---

# Live Link Hub设置

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / LiveLink Hub / 捕获管理器 / 配置捕获管理器 / Live Link Hub设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/live-link-hub-settings

## 常规设置

你可以通过**设置（Settings）**菜单在**Live Link Hub**中访问**捕获管理器**的设置项。

|  |  |
| --- | --- |
| [Live Link Hub设置](https://dev.epicgames.com/community/api/documentation/image/8199c099-853c-41b1-97dd-023a40edec94?resizing_type=fit) | [插件捕获管理器](https://dev.epicgames.com/community/api/documentation/image/90e83a7a-f144-4e7a-a4ca-d2290afd378c?resizing_type=fit) |

- **默认工作目录（Default Working Directory）**：指定在摄取过程中存储转换数据的位置（可以是临时位置）。
- **是否清理工作目录（Should Clean Working Directory）**：摄取完成后（无论成功与否），是否应从**工作目录**中删除下载和转换的文件。
- **下载目录（Download Directory）**：从远程设备（如Live Link Face设备）所下载的数据的存储位置。
- **启用第三方编码器（Enable Third Party Encoder）**：如果启用，则使用第三方编码/解码器（[FFmpeg](https://ffmpeg.org/)）转换数据，并提供额外的设置项。
- **并行作业（Parallel Jobs）**：摄取时并行处理的任务数。

你可以使用命名标记自动填充**工作目录**和**下载目录**的部分位置。

## 第三方编码器支持

在摄取过程中，可以使用外部第三方媒体编码器或解码器（[FFmpeg](https://ffmpeg.org/)）转换数据。 如果使用Windows媒体基础（Windows Media Foundation）的默认工作流程不支持你希望使用的数据格式，那么这种做法就很适合。

要配置第三方编码器或解码器，请执行以下步骤：

1. 下载并安装来自于[ffmpeg.org](http://ffmpeg.org/)的FFmpeg。
2. 确保在设置中启用了**启用第三方编码器（Enable Third Party Encoder）**。 这将让某些额外选项变得可用。
3. 按需提供额外设置：

   - **第三方编码器（Third Party Encoder）**：指向ffmpeg可执行文件的完整路径。
   - **自定义视频命令参数（Custom Video Command Arguments）**：在使用视频数据执行第三方编码器时使用。
   - **自定义音频命令参数（Custom Audio Command Arguments）**：在使用音频数据执行第三方编码器时使用。

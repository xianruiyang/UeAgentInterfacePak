---
title: "Media Asset Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/media-asset-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "Media Asset Reference"]
---

# Media Asset Reference

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / Media Asset Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/media-asset-reference-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

本文提供多种基础媒体资产设置的参考。对于采集卡，请改为参阅 [专业视频 I/O](../../professional-video-io/index.md) 文档。

## 播放器覆盖

许多 Media Source 资产都提供 Player Override 设置，可用于控制播放该资产时使用哪个播放器。每个平台都有自己的选项，可以通过下拉菜单分别设置。在所有情况下，Automatic 选项表示播放时使用 UE 默认播放器。请参阅 [Electra Protron Player](../electra-media-player/electra-protron-player/index.md) 文档，了解设置默认播放器的更多信息。

> [!NOTE]
> 采集卡播放器（AJA 和 Blackmagic）仅在已安装对应采集卡硬件并启用插件时可用。同样，NDI 仅在启用对应插件时可用。

| 平台 | 选项 |
| --- | --- |
| **Android** | AutomaticAndroid Media (AndroidMedia)Electra Player (ElectraPlayer) |
| **iOS** | AutomaticApple AV Foundation (AvfMedia)Electra Player (ElectraPlayer) |
| **Linux** | AutomaticBlackmagic Device Interface (BlackmagicMedia)Electra Player (ElectraPlayer)Image Sequence (ImgMedia)NDI (NDIMedia)WebM Media (WebMMedia) |
| **Mac** | AutomaticApple AV Foundation (AvfMedia)Electra Player (ElectraPlayer)ElectraProtron mp4 playback (ElectraProtron)Image Sequence (ImgMedia)NDI (NDIMedia)WebM Media (WebMMedia) |
| **tvOS** | AutomaticElectra Player (ElectraPlayer) |
| **VisionOS** | Automatic |
| **Windows** | AutomaticAJA Device Interface (AJAMedia)Blackmagic Device Interface (BlackmagicMedia)Electra Player (ElectraPlayer)ElectraProtron mp4 playback (ElectraProtron)Image Sequence (ImgMedia)NDI (NDIMedia)WebM Media (WebMMedia)Windows Media Foundation (WmfPlayer) |

## 播放器详情

Media Player 资产的设置会控制媒体播放的基础行为。Media Source 资产拥有包含相同设置的 Player Details 面板，Media Player 在播放这些 Media Source 资产时会使用这些设置。关于 Media Player 设置的更多信息，请参阅 [媒体编辑器参考](../media-editor-reference/index.md)

## 文件媒体源

使用 [播放器详情](index.md#media-player) 面板。关于使用 File Media Source 的分步说明，请参阅 [播放视频文件](../media-framework-unreal-engine-tutorials/play-a-video-file/index.md) 教程。

| 设置 | 说明 |
| --- | --- |
| **文件路径** | 媒体文件的路径。如果媒体文件不在 `…/Content/Movies` 目录中，则该媒体文件不会包含在打包项目内，并会显示警告图标。 |
| **预缓存文件** | 启用后，会在可能的情况下将整个媒体文件加载到内存中用于播放。 |
| **播放器覆盖** | 请参阅 [播放器覆盖](index.md#player-overrides) 上文。 |

## 文件媒体输出

| 设置 | 说明 |
| --- | --- |
| **格式** | 选项包括：EXR (default)BMPJPGPNG |
| **压缩质量** | 取决于格式。对于 EXR，可为 0（默认）或 1（未压缩）。对于其他格式，可为 0 到 100 之间的值。 |
| **覆盖文件** | 启用后，如果图像已存在则覆盖该图像。 |
| **异步** | 启用后，图像会异步保存。禁用后，游戏线程会被阻塞，直到保存完成。 |
| **文件路径** | 定义图像输出的保存位置。 |
| ****基础**文件名** | 图像的基础文件名。帧编号会追加到该名称后。 |
| **期望****尺寸** | 启用后，可以指定图像输出的 X 和 Y 尺寸。禁用后，会使用默认后备缓冲区尺寸。 |
| **期望像素格式** | 启用后，指定像素格式。 选项包括：8 位 RGBA浮点 RGBA禁用后，会使用默认后备缓冲区像素格式。 |
| **反转 Alpha** | 启用后，会对支持 Alpha 的格式反转 Alpha。 |
| **纹理缓冲区数量** | 用于将纹理从 GPU 传输到系统内存的纹理数量。较小的数值可能阻塞 GPU。较大的数值可能导致延迟。 仅适用于使用 GPU 的采集。 |

## 图像媒体源

使用 [播放器详情](index.md#media-player) 面板。关于使用 Img Media Source 的分步说明，请参阅 [播放图像序列](../media-framework-unreal-engine-tutorials/play-an-image-sequence/index.md) 教程。

| 设置 | 说明 |
| --- | --- |
| **播放器覆盖** | 请参阅 [播放器覆盖](index.md#player-overrides) 上文。 |
| **填充序列间隙** | 启用后，序列中的任何间隙都会以空白帧填充。 |
| **序列路径** | 图像序列的路径。如果图像序列不在 `…/Content/Movies` 目录中，则该图像序列不会包含在打包项目内，并会显示警告图标。 |
| **帧率覆盖** | 覆盖图像序列中存储的默认帧率。默认不覆盖。选项包括：12 fps (animation)15 fps24 fps (film)25 fps (PAL/25)30 fps48 fps50 fps (PAL/50)60 fps100 fps120 fps240 fps23.976 fps (NTSC/24)29.97 fps (NTSC/30)59.94 fps (NTSC/60)自定义 |
| **代理覆盖** | 提供代理目录的名称。默认不使用代理。 |
| **编码覆盖** | 覆盖图像序列的源编码。选项包括：无（默认）LinearsRGB |
| **色彩空间覆盖** | 覆盖图像序列的色彩空间。选项包括：sRGB/Rec 709Rec 2020ACES AP0ACES AP1 / ACEScgP3DCIP3D65RED Wide GamutSony S-Gamut3Sony S-Gamut3 CineAlexa Wide GamutCanon Cinema GamutGoPro Protune NativePanasonic V-Gamut自定义 |
| **红/绿/蓝/白色度坐标** | 定义色度的四个独立字段。每个 Color Space Override 选项都会为这些字段提供特定值。当源白点与工作色彩空间白点不同，且 Color Space Override 设置为 Custom 时，可以编辑这些值。 |
| **色彩适应方法** | 当源白点与工作色彩空间白点不同时，确定要应用的色彩适应方法。是否可修改取决于 Color Space Override 的值。选项包括：NoneBradfordCAT02 |
| **起始时间码** | 指定与序列起点关联的时间码。 |

> [!NOTE]
> 关于 Color Space Overrides 的更多信息，请参阅 [工作色彩空间](../../../managing-color/working-color-space/index.md) 文档。

## 媒体播放列表

关于使用 Media Playlist 的分步说明，请参阅 [使用媒体播放列表](../media-framework-unreal-engine-tutorials/using-media-playlists/index.md) 教程。

| 设置 | 说明 |
| --- | --- |
| **播放列表（数组）** | Playlist 数组中的每个元素都是从 Content Browser 中选择的独立媒体源。可以直接从播放列表创建新的媒体资产，然后根据媒体资产类型填充媒体。[Media Playlist](https://dev.epicgames.com/community/api/documentation/image/2939e846-3cfa-4288-8f6d-7d253b5c5cb2?resizing_type=fit) |

## 平台媒体源

使用 [播放器详情](index.md#media-player) 面板。关于使用 Platform Media Source 的分步说明，请参阅 [播放平台特定媒体](../media-framework-unreal-engine-tutorials/playing-platform-specific-media/index.md) 教程。

| 设置 | 说明 |
| --- | --- |
| **播放器覆盖** | 请参阅 [播放器覆盖](index.md#player-overrides) 上文。 |

## 流媒体源

使用 [播放器详情](index.md#media-player) 面板。关于使用 Stream Media Source 的分步说明，请参阅 [播放视频流](../media-framework-unreal-engine-tutorials/play-a-video-stream/index.md) 教程。

| 设置 | 说明 |
| --- | --- |
| **播放器覆盖** | 请参阅 [播放器覆盖](index.md#player-overrides) 上文。 |
| **流 URL** | 定义发送媒体流的 URL。 |

# NDI Media Reference

---
title: "NDI Media Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndi-media-reference"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "专业视频I/O", "NDI Media Reference"]
---

# NDI Media Reference

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 专业视频I/O / NDI Media Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndi-media-reference

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

本页说明 NDI Media Framework 资产上暴露的选项和设置。使用 NDI Media Source 和 Media Output 资产需要启用 NDI Media 插件，并且还需要一个 NDI 源。更多信息请参阅 [NDI 文档](https://ndi.video/) 。

## NDI Media Source

创建的每个 NDI Media Source 资产都会暴露以下 Configuration 下拉菜单设置和 Details 面板设置。

### NDI Media Source 的 Configuration 下拉设置

此处描述的设置可在 NDI Media Source 的 Details 面板顶部的 Configuration 下拉菜单中访问。默认情况下，只有 Device 可配置，其他所有设置都由 NDI 流自动确定。

> [!WARNING]
> 不要禁用 **Auto**复选框，因为显示的这些设置原本用于采集卡；对 NDI 而言，它们只是无功能的类默认值，不代表实际流设置。

![NDI Configuration dropdown menu](../../../../../assets/images/e6/e677cb2bd849f12bfb118d0fcf5b763ef110f05e70aa1759208ba0f1afaaf81d.jpg)

| 设置 | 说明 |
| --- | --- |
| **Device** | 设置此 Media Source 用于将视频引入 Unreal Engine 的 NDI 虚拟设备。如果计算机上有多个可用 NDI 流，可以在此选择要使用的流。 |

### NDI Media Source 的 Details 面板设置

Details 面板中位于 **NDI > Configuration** 下的设置始终为灰色，因为它们通过 Configuration 下拉菜单设置。对于 NDI，只会使用设备名称。其他设置显示默认值，但对 NDI 无功能。

> [!NOTE]
> Media Source 的 Details 面板设置由 NDI 和所有采集卡共享，因此部分设置无功能。请仔细确认哪些设置适用于你的 NDI 配置。

![NDI Media Source asset Detail panel](../../../../../assets/images/20/20c12470362b55a3dbff380511b9c0aa25b3350881a0327e4fc0d48c4d2e3779.png)

| 设置 | 说明 |
| --- | --- |
| NDI |  |
| **配置** | 提供对 Configuration 下拉菜单的访问，并显示设置摘要。 |
| Configuration - Media Connection |  |
| **Device** | 显示此 Media Source 将用于把媒体内容引入 Unreal Engine 的 NDI 源。包含 Device Name 和 Device Identifier 子字段。只读。 |
| **Protocol** | 对 NDI 无功能 |
| **Transport Type** | 对 NDI 无功能 |
| **Quad Transport Type** | 对 NDI 无功能 |
| **Port Identifier** | 对 NDI 无功能 |
| Configuration - Media Mode |  |
| **Frame Rate** | 对 NDI 无功能 |
| **Resolution** | 对 NDI 无功能 |
| **Standard** | 对 NDI 无功能 |
| **Device Mode Identifier** | 对 NDI 无功能 |
| **Bandwidth** | 决定连接到 NDI 源时使用的带宽模式。选项包括：Metadata OnlyAudio OnlyLowestHighest（默认） |
| **Sync Timecode to Source** | 启用后，时间码会同步到源时间码。禁用后，时间码会同步到 UE 的时间码。 |
| Video |  |
| **Capture Video** | 决定 Unreal Engine 是否从 NDI 源采集视频。 |
| **Deinterlacer** | 可以选择如何处理传入的隔行扫描流。选项包括：NoneBlend DeinterlacerBob Deinterlacer（默认）Discard Deinterlacer |
| **Interlace Field Order** | 隔行字段应被复制的顺序。选项包括： Top Field FirstBottom Field First |
| **Override Source Encoding** | 启用此字段以覆盖源编码。可从下拉菜单中选择覆盖编码。 |
| **Override Source Color Space** | 启用此字段以覆盖源色彩空间。可从下拉菜单中选择覆盖色彩空间。 |
| Video - Color Conversion Settings |  |
| **Configuration Source** | 使用此属性定义 OCIO 配置。请参阅 [OCIO 文档](../../../managing-color/color-management-with-opencolorio/index.md) 。 |
| **Transform Source** | 使用此属性定义 OCIO 变换源。请参阅 [OCIO 文档](../../../managing-color/color-management-with-opencolorio/index.md) 。 |
| **Transform Destination** | 使用此属性定义 OCIO 变换目标。请参阅 [OCIO 文档](../../../managing-color/color-management-with-opencolorio/index.md) 。 |
| Video - Advanced |  |
| **Max Num Video Frame Buffer** | 设置 Unreal Engine 在任意时刻存储在内存中的视频数据最大帧数。如果输入视频跳帧或卡顿，可以尝试提高此值。 |
| Audio |  |
| **Capture Audio** | 决定 Unreal Engine 是否从 NDI 源采集音频。 |
| Audio - Advanced |  |
| **Max Num Audio Frame Buffer** | 设置 Unreal Engine 在任意时刻存储在内存中的音频数据最大帧数。如果输入视频跳帧或卡顿，可以尝试提高此值。 |
| Ancillary |  |
| **Capture Ancillary** | 决定 Unreal Engine 是否采集随视频信号附带的辅助元数据。 |
| Ancillary - Advanced |  |
| **Max Num Ancillary Frame Buffer** | 设置 Unreal Engine 在任意时刻存储在内存中的辅助数据最大帧数。如果输入视频跳帧或卡顿，可以尝试提高此值。 |
| Synchronization |  |
| **Time Synchronization** | 启用后，会基于引擎时间码同步媒体。这是 Timecode Sample Evaluation Type 和 Frame Delay 设置的前提条件。 |
| **Frame Delay** | 该设置取决于是否启用时间同步。它用于根据引擎时间码查找正确帧，并基于播放器/媒体源帧率计算。 例如：如果 Player 位于第 2 帧，并将 Frame Delay 设为 1 Frame，即使第 2 帧也可用，Media Player 仍会在屏幕上显示较旧的第 1 帧（2 - Frame Delay = 1）。 |
| **Time Delay** | 未使用时间同步时会使用此设置；与 Frame Delay 类似，引擎选择要显示的帧时会考虑它。 |
| Synchronization - Advanced |  |
| **Just in Time Rendering** | 启用此选项会将媒体源像素处理推迟到当前帧管线中尽可能晚的位置，从而为外部源像素到达并在播放设备当前帧中渲染留出更多时间。 |
| **Framelock** | 此选项对 NDI 源无功能。 |
| Debug |  |
| **Sample Evaluation Type** | Latest：尽快显示接收到的样本。它不使用任何基于时间的同步技术，而是显示最新可用帧。Platform Time：显示的样本基于平台时间同步。Timecode：基于时间码同步。需要在 Media Profile 或 Project Settings 中设置时间码提供器。 |
| **Log Drop Frame** | 启用后，每当 Unreal Engine 在输入馈送中检测到丢帧时，都会向输出日志打印一条消息。 |
| **Burn Frame Timecode** | 启用后，引擎会将每帧的时间码嵌入采集的视频中。可以用它检查输入每帧的时间码是否与你期望的值匹配。请参阅 [Timecode Texel Encoding](../timecode-and-genlock/index.md#timecode-texel-encoding) . |

## NDI Media Output

创建的每个 NDI Media Output 资产都会暴露以下 Details 面板设置。

### NDI Media Output 的 Details 面板设置

> [!NOTE]
> Media Source 的 Details 面板设置由 NDI 和所有采集卡共享，因此某些设置无功能。请仔细确认哪些设置适用于你的 NDI 源。

![NDI Media Output asset Details panel](../../../../../assets/images/5d/5db31511c745714f110ea7dc2d4208f4465cbb08d1829bbcef64f2a1aa7080af.jpg)

| 设置 | 说明 |
| --- | --- |
| Media |  |
| **Source Name** | 描述输出流名称，用于将其与当前机器上的其他输出流区分开。 |
| **Group Name** | 定义此源所属的组。如果留空，该源不分组，并默认显示在 NDI Access Manager 和 NDI Bridge 的 Public 组中。 |
| **Output Type** | 决定输出类型。选项包括：FillFill and Key |
| **Invert Key Output** | 启用后，保存图像时反转 key 输出。 |
| **Desired Size X/Y** | 启用后，可指定输出 NDI 流的 X 和 Y 尺寸。 |
| **Desired Pixel Format** | 启用后，可指定要使用的像素格式，而不是默认后备缓冲。 |
| **Frame Rate** | 定义通过 NDI 发送视频时所需的每秒帧率。 |
| Audio |  |
| **Output Audio** | 启用后，会在输出中随视频信号一起发送引擎音频。 |
| **Audio Buffer Size** | 决定保存已渲染音频样本的缓冲区大小。更大的缓冲区会产生更稳定的输出，但会引入更多延迟。 |
| **Num Output Audio Channels** | 决定输出到 NDI 源的音频通道数量。必须大于引擎中使用的音频通道数。 |
| **Audio Sample Rate** | 发送到 NDI 源的每秒音频样本数。该值必须匹配引擎音频采样率。 |
| **Send Audio Only if Receivers Connected** | 启用后，如果没有连接的接收端，音频不会被转换和发送。禁用后，无论是否存在连接的接收端，音频都会被转换并发送。 |
| Synchronization |  |
| **Wait for Sync Event** | 启用后，会将渲染线程锁定到 NDI 帧率。该设置与 AJA、Blackmagic 等采集卡中名称相似的设置行为差异很大，请勿混淆。 |
| Output - Advanced |  |
| **Number of Texture Buffers** | 设置用于将每帧图像从 GPU 传输到主线程内存的缓冲区数量。较低值更容易因等待每次传输完成而在 GPU 侧造成瓶颈；较高值更可能增加延迟。 |


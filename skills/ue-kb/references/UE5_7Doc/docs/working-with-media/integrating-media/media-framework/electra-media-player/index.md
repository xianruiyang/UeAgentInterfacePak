---
title: "Electra媒体播放器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/electra-media-player-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "Electra媒体播放器"]
---

# Electra媒体播放器

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / Electra媒体播放器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/electra-media-player-in-unreal-engine

![在虚幻引擎中使用Electra媒体播放器进行媒体流送](../../../../../assets/images/5d/5dc4c875a3173ab2c34e33d25d1121fdc3009c66d92be59e2f148158861437f6.jpg)

**Electra媒体播放器（Electra Player）** 是虚幻引擎的媒体播放器插件，使用[HTTP实时流送(HLS)](https://developer.apple.com/streaming/)格式进行实时流送和视频点播(VOD)流送。利用此插件，可以通过源的链接，将实时表演和媒体流送到你的虚幻项目中。除了流送，Electra还支持 `.mp4` 渐进式下载和本地播放 `.mp4` 文件。

以下平台支持Electra：

- Windows 7或更高版本
- macOS
- iOS 13.0或更高版本
- Android Lollipop (5.1)或更高版本
- Playstation 4
- Playstation 5
- Xbox One/S/X
- Xbox Series X
- Nintendo Switch

可播放的最大视频分辨率和帧率取决于平台。如需各平台的规格，请参见相关平台文档。

如需学习如何使用Electra媒体播放器来流送项目中的视频，请参见[播放视频流送](../media-framework-unreal-engine-tutorials/play-a-video-stream/index.md)。

## 支持的媒体格式

Electra是虚幻引擎中的流媒体播放器，支持HLS格式的媒体流送。如需更多详细信息，请参见[HTTP实时流送](#httplivestreaming)。

Electra媒体播放器还支持播放单个多路复用 `.mp4` (ISO/IEC 14496-12)文件，只要文件满足以下规格即可：

- 最多包含一个视频轨道。
- 仅包含视频和音频轨道。
- 格式为

  faststart

  ，将文件的元数据 （

  moov atom

  ）存储在（

  mdat

  ）的前面。
- 仅通过

  file://

  URI方案访问。

> [!NOTE]
> 此外还支持公用媒体应用格式(CMAF)，因为它是 `.mp4` 的专业化版本。

如需受支持文件格式的完整列表，请参见[媒体框架技术参考](../media-framework-technical-reference/index.md)。

### 支持的编解码器

Electra媒体播放器仅支持使用以下编解码器编码的媒体文件和流送：

| **媒体类型（Media Type）** | **编解码器（Codec）** |
| --- | --- |
| 视频编解码器 | H.264 / AVC (ISO/IEC 14496-10) |
| 音频编解码器 | AAC (ISO/IEC 14496-3) |

## HTTP实时流送

Electra媒体播放器通过支持HLS (RFC-8216)，在虚幻项目中提供流送功能。通过HLS，服务器将媒体文件分割成片段并创建索引文件。此索引文件包含媒体片段的列表以及位置，客户端读取并使用它们格式化媒体播放请求。。

HLS还支持不同比特率的媒体文件的变体流送，以便客户端最大限度减少播放中的停滞。变体流送是在另一个名为[主播放列表](https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming/creating_a_master_playlist)的索引文件中定义的。如需HLS架构的更多详细信息，请参见Apple的[HLS文档](https://developer.apple.com/documentation/http_live_streaming)。

### 变体流送限制

HLS允许变体流送使用不同的片段时长以及不同的数量的片段，而不需要专门的方法来标识匹配的片段。为了减少客户端开销，Electra媒体播放器需要对所有视频变体执行完全相同的片段划分。对于VOD演示，Electra媒体播放器随后会根据变体播放列表中片段的绝对索引来切换变体。

> [!TIP]
> 实时流送演示的处理方式有所不同，因为播放列表在持续变化，并包含一些媒体片段的滚动窗口。除了对媒体进行完全相同的片段划分，还使用EXT-X-PROGRAM-DATE-TIME标签来标识匹配的片段。

为了获得最佳性能，Electra媒体播放器对播放列表和媒体片段具有以下限制：

- 变体流必须格式化为ISO/IEC-14496-12或CMAF片段（Variant streams must be formatted as ISO/IEC-14496-12 or CMAF segments）：

  不支持ISO/IEC-13818-1标准的MPEG2传输流片段。
- **变体流中的对应片段必须在每个片段索引上具有相同的时长（Corresponding segments in variant streams must have the same duration at each segment index）：**视频不需要进行相同的分段。对于每个变体流 *A* 和 *B*，片段 *n* 的片段时长 *dur* 相同：

  `dur(segment A(n)) == dur(segment B(n))`

  进行片段划分时，不同的流类型不需要具有完全相同的时长。音频可以使用与视频片段不同的片段时长。
- 音频流不切换（Audio streams do not switch）：

  主播放列表中只能指定一个音频流。
- 变体播放列表中的片段时长不能舍入到最近的整数（Segment duration cannot be rounded to the nearest integer in the variant playlists）：

  音频和视频将采用不同的分段方式，因为单独的视频图像和音频采样块大小不同。Electra媒体播放器通过定位开始时间与视频片段的开始时间最匹配的音频片段来同步音频和视频，并且会放弃任何早于视频开始时间的音频采样。如果变体播放列表中未精确指定片段时长，那么小误差将会累积并最终导致选错要播放的音频片段，致使音频与视频不同步。
- **主播放列表中需要具有音频组（Audio groups are required in a master playlist）：**由于容器格式需要单一元素流，因此必须在主播放列表中指定音频组。以下是主播放列表中音频组媒体标签的示例。

  `#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group_audio",NAME="audio_0",DEFAULT=YES,URI="manifest_0.m3u8"`

  `#EXT-X-STREAM-INF:BANDWIDTH=8905600,RESOLUTION=1920x1080,CODECS="avc1.42c028,mp4a.40.2",AUDIO="group_audio"`
- EXT-X-STREAM-INF

  标签中必须具有

  CODECS

  和

  RESOLUTION

  属性（

  CODECS

  and

  RESOLUTION

  properties are required in

  EXT-X-STREAM-INF

  tags）：

  这些属性在RFC-8216中是可选的，但对于Electra媒体播放器是必需的。
- 在

  EXT-X-STREAM-INF

  标签中使用

  FRAME-RATE

  属性（Use the

  FRAME-RATE

  property in

  EXT-X-STREAM-INF

  tags）：

  强烈建议在Electra媒体播放器中使用

  FRAME-RATE

  来进行媒体播放，因为它有助于标识和筛选平台上由于解码超过每秒30帧而无法播放的流。
- 不支持除必需的音频组以外的演奏组（Rendition groups other than the required audio group are not supported）：

  演奏组用于备用内容，例如不同的观看角度。Electra媒体播放器仅支持一个演奏组，即视频变体播放列表引用的音频组。
- 视频片段必须将即时解码器刷新(IDR)帧作为第一帧（Video segments must have an Instantaneous Decoder Refresh (IDR) frame as the first frame）：

  播放仅在视频流中存在IDR帧的情况下开始。这相当于隐式要求使用

  EXT-X-INDEPENDENT-SEGMENTS

  标签，该标签不需要设置，但强烈建议设置一下。
- 不支持帧准确搜索：（Frame accurate seeking is not supported:）

  将定位最靠近指定播放开始时间的IDR帧，播放将从此处开始。
- 采用HLS格式的流仅支持AES-128加密（Only AES-128 encryption is supported for streams with the HLS format）：

  不支持SAMPLE-AES。

> [!NOTE]
> 媒体流可以包含没有视频演示的音频轨道。此外还可以仅流送没有音频的视频。

### 不支持的HLS标签

Electra在主播放列表和变体播放列表中将忽略以下标签。这些标签存在于文件中并不会引起错误，除非需要使用它们来进行正确的播放。

- EXT-X-DISCONTINUITY
- EXT-X-DISCONTINUITY-SEQUENCE
- EXT-X-DATERANGE
- EXT-X-I-FRAMES-ONLY
- EXT-X-I-FRAME-STREAM-INF
- EXT-X-SESSION-DATA
- EXT-X-SESSION-KEY

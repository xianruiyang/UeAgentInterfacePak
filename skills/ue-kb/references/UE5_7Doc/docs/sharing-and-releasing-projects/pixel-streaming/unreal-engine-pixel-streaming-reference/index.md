---
title: "像素流参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-pixel-streaming-reference"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "像素流送", "像素流参考"]
---

# 像素流参考

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 像素流送 / 像素流参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-pixel-streaming-reference

本文将介绍像素流系统各个部分公开的选项、设置和命令行参数。

> [!NOTE]
> 下文提到的许多设置和参数在新的Pixel Streaming 2插件中已被修改或移除。请参阅[Pixel Streaming 2概览](../development-guides-for-pixel-streaming/pixel-streaming-2-overview/index.md)文档以了解详情。

## 支持的图形硬件

要运行带有像素流插件的虚幻引擎应用程序，计算机必须具有以下类型的图形硬件之一：

- 支持硬件加速视频编码（NVENC）的NVIDIA GPU硬件。请参阅NVIDIA的[支持设备对照表](https://developer.nvidia.com/nvidia-video-codec-sdk#NVENC%E5%8A%9F%E8%83%BD)。
- 支持[高级媒体框架（AMF）](https://gpuopen.com/gaming-product/advanced-media-framework/)的AMD GPU硬件。
- 支持使用VideoToolbox框架的Macintosh硬件。

> [!TIP]
> 如果你在尝试使用像素流插件时，收到错误消息 **找不到兼容的GPU，或无法加载各自的编码器库（No compatible GPU found, or failed to load their respective encoder libraries）** ，很可能你的GPU不支持NVENC或AMF。

## 支持的操作系统

像素流插件支持Windows、Linux和Mac平台。不支持OSX。

但是，像素流插件以及随附的信令和Web服务器仅在Windows 10、Ubuntu 18.04/20.04和MacOS Ventura 13.5.1上进行了测试。尚未在其他操作系统上测试，包括Windows 7或8。

## 支持的客户端浏览器

像素流播放适用于支持WebRTC协议的现代浏览器。例如，它经过了测试，已知可在以下浏览器的最新版本中运行，无需额外配置：

- Google Chrome（台式机和移动设备）
- Microsoft Edge（台式机）
- Mozilla Firefox（台式机和移动设备）
- Apple Safari（台式机和移动设备）

Microsoft Edge和Opera等其他浏览器可能需要附加组件或插件，并且可能在某些系统上运行不了。

## 支持的编码器

| 编码器 | 加速 | 1080p/4K的编码速度 | 优点 | 低比特率的质量 | 每个对等端的CPU/GPU使用情况。 |
| --- | --- | --- | --- | --- | --- |
| H.264 | GPU（Nvidia、AMD或Apple M系列处理器） | 约8.97msms/约24.17ms | 快速编码/解码速度。在硬件层面广受许多设备的支持。 | 斑驳 | 每个对等端一个GPU编码会话，直至达到GPU的编码会话上限。 |
| VP8 | CPU | 约10.5/约25ms | 在较低比特率生成更好的图像质量。 | 一般 | CPU性能随对等端数量而线性缩放。 |
| VP9 | CPU | 约15ms/约50ms | 相较于其他编码器，在最低比特率有最高的图像质量。 | 良好 | CPU性能随对等端数量而线性缩放。 |
| AV1 | GPU（NVIDIA Ada Lovelace或更新型号） | 约8.98ms/约15.8ms | 相比其他编码器，在最低比特率下拥有最高的图像质量。 | 最佳 | G每个对等端一个GPU编码会话，直至达到GPU的编码会话上限。 |

> [!NOTE]
> 对于1080p流媒体，随着比特率提高到20mbps以上，所有编码器的质量都将类似。此处列出的编码速度是估算值，取自RTX 3060和AMD 3900X。但AV1例外，它是在NVIDIA RTX 6000 Ada上测试的。 如果你的编码硬件支持，我们推荐使用AV1编码解码器，因为它可以在更低的比特率下生成更高质量的视频。

## 默认网络端口

像素流系统的组件使用下面指定的默认端口通信。你需要确保在运行每个组件的主机上打开这些端口。

| 组件 | 端口 |
| --- | --- |
| `信令服务器主机` | **80** - 用于来自客户端的所有HTTP请求。 要更改此值，请为信令服务器设置 **--httpPort** 参数。 **443** - 用于当信令服务器在HTTPS模式下运行时来自客户端的所有HTTPS请求。 要更改此值，请为信令服务器设置 **--httpsPort** 参数。 **8888** - 用于来自虚幻引擎应用程序的所有传入连接请求。 要更改此值，请为信令服务器设置 **--streamerPort** 参数， **同时** 为UE4应用程序设置 **--PixelStreamingPort** 参数。 |
| `配对器服务器主机` | **90** - 用于来自客户端的所有HTTP请求。 要更改此值，请为配对器服务器（使用 **--httpPort** 参数。 **9999** - 用于信令服务器发送的所有消息。 要更改此值，请为配对器服务器设置 **--matchmakerPort** 参数，**同时** 为信令服务器设置 **--matchmakerPort** 参数。 |
| `SFU端口` | **8889** - 打开信令服务器和SFU之间的连接。 |

## 像素流控制台命令和启动参数

本小节中含有对使用像素流的应用程序非常实用的控制台命令和启动参数。

### 所需的启动参数

启动使用像素流的虚幻引擎应用程序时，必须指定以下启动参数：

| 命令行参数 | 说明 |
| --- | --- |
| `-PixelStreamingIP=<value>` 或 `<domain>` | 指定运行信令和Web服务器的计算机的IP地址或域名。 |
| `-PixelStreamingPort=<value>` | 指定信令和Web服务器侦听来自虚幻引擎应用程序的传入通信的端口。信令和Web服务器使用默认值 `8888` 。 |
| `-PixelStreamingURL=<value>` | 仅当 `-PixelStreamingIP` 和 `-PixelStreamingPort` 不存在时才需要。如果使用了该参数，则同时替换 `-PixelStreamingIP` 和 `-PixelStreamingPort` 。 其中也必须包括WebSocket协议。例如：`ws://127.0.0.1:8888` 或 `wss://127.0.0.1:8888` 。 |

标准的像素流应用程序启动如下：

```
MyPixelStreamingApplication.exe -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8888
```

或：

```
MyPixelStreamingApplication.exe -PixelStreamingURL="ws://127.0.0.1:8888"
```

### 虚幻引擎启动参数

以下参数并非专用于像素流。但是，这些参数可能会适用于许多像素流应用程序，尤其是在云部署中。

| 命令行参数 | 说明 |
| --- | --- |
| `-RenderOffscreen` | 自动运行虚幻引擎应用程序，在本地计算机上完全没有可见的渲染。该应用程序不会显示窗口，也不会全屏渲染。 你可以将此参数与-ForceRes结合使用，以便阻止虚幻引擎根据主显示器的分辨率自动调整分辨率。 如果省略此参数，虚幻引擎应用程序窗口将正常渲染。如果此应用程序窗口最小化，像素流视频和输入捕获将停止工作。因此，我们建议始终包含此参数，除非你需要在运行时在同一台计算机上本地查看虚幻引擎应用程序的渲染输出。 |
| `-ForceRes` | 当与-ResX和-ResY结合使用时，这将强制虚幻引擎达到指定的分辨率。这在通常没有显示分辨率的云部署中很有用。 |
| `-ResX=<value>` | 设置虚幻引擎应用程序启动时分辨率的宽度分量。 |
| `-ResY=<value>` | 设置虚幻引擎应用程序启动时分辨率的高度分量。 |
| `-AudioMixer` | 强制虚幻引擎将软件混合用于音频，如果没有音频设备，这可能是必需操作…… |
| `-Unattended` | 在遇到错误时抑制生成对话框。这在屏幕外或容器中运行虚幻引擎时很有用，因为在这些场景中消息框可能会无限期挂起。 |
| `-StdOut` 和 `-FullStdOutLogOutput` | 这两个标记的组合会产生最大的日志输出，这在SSH终端中调试或查看实时日志时非常有用。 |

## 可选的控制台命令启动参数

你可以在运行时将以下设置指定为控制台变量，或在启动时指定为程序参数。

未指定这些设置时，系统将为使用的每种设置提供默认值。大多数用户不需要更改这些设置。事实上，这些值中有许多值由WebRTC内部控制，覆盖它们可能会导致性能下降。

### 像素流插件配置

更改以下设置将配置像素流插件。

| 控制台变量 | 命令行参数 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `PixelStreaming.HUDStats` | `-PixelStreamingHudStats` | `false` | 是否在游戏内HUD上显示像素流统计数据。 |
| `PixelStreaming.DisableLatencyTester` | `-PixelStreamingDisableLatencyTester` | `false` | 将能够通过像素流插件管线的延迟测试的触发功能禁用。 |
| `PixelStreaming.KeyFilter` | `-PixelStreamingKeyFilter=<values>` | `""` | 一系列要从流客户端忽略的按键，各个按键用逗号分隔。例如，"W,A,S,D"可用于过滤掉默认移动键。 |
| `PixelStreaming.UseMediaCapture` | `-PixelStreamingUseMediaCapture` | `false` | 使用MediaIOFramework的媒体捕获，而不是像素流送内部的后备缓冲区源来捕获帧。这在某些情况下可以作为首选项。 |
| N/A | `-AllowPixelStreamingCommands` | `false` | 用户是否应该能够通过 `emitConsoleCommand` javascript发送控制台命令。 |
| N/A | `-PixelStreamingHideCursor` | `false` | 是否隐藏UE应用程序光标。 |

### 编码器配置

更改以下设置将配置像素流插件使用的底层视频编码器。

| 控制台变量 | 命令行参数 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `PixelStreaming.Encoder.Codec` | `-PixelStreamingEncoderCodec=<value>` | `H264` | 用于像素流送的指定编码器。支持的编码器包括："H264"、"AV1"、"VP8"、"VP9" |
| `PixelStreaming.Encoder.TargetBitrate` | `-PixelStreamingEncoderTargetBitrate=<value>` | `-1` | 目标比特率（bps）。设置此项会忽略WebRTC想要的比特率（不推荐）。设置为-1时禁用。 |
| `PixelStreaming.Encoder.MaxBitrateVBR` | `-PixelStreamingEncoderMaxBitrate=<value>` | `20000000` | 最大比特率（bps）。 在带有NVENC的CBR速率控制模式下不起作用。 |
| `PixelStreaming.Encoder.DumpDebugFrames` | `-PixelStreamingDebugDumpFrame=<value>` | `false` | 将帧从编码器转储到磁盘上的文件，以便进行调试。 |
| `PixelStreaming.Encoder.MinQuality` | `-PixelStreamingEncoderMinQuality=<value>` | `-1` | 0-100，值越高，质量越高，但比特率越高。 |
| `PixelStreaming.Encoder.MaxQuality` | `-PixelStreamingEncoderMaxQuality=<value>` | `-1` | 0-100，值越高，质量越高，但比特率越高。 |
| `PixelStreaming.Encoder.RateControl` | `-PixelStreamingEncoderRateControl=<value>` | `"CBR"` | PixelStreaming视频编码器RateControl模式。支持的模式有"ConstQP"、"VBR"、"CBR"。注意：CBR是我们唯一推荐的模式。 |
| `PixelStreaming.Encoder.EnableFillerData` | `-PixelStreamingEnableFillerData=<value>` | `false` | 通过填充垃圾数据来维持恒定的比特率。注意：CBR和MinQP = -1时不需要。 |
| `PixelStreaming.Encoder.Multipass` | `-PixelStreamingEncoderMultipass=<value>` | `"FULL"` | 编码器每帧要传递多少次。更多细节，请参阅NVENC文档。支持的模式有 `"DISABLED"`、`"QUARTER"`、`"FULL"` |
| `PixelStreaming.Encoder.MaxSessions` | `-PixelStreamingEncoderMaxSessions` | `-1` | 设置像素流送并发硬件编码器会话的最大数量。（-1意味着无数量限制）。 |
| `PixelStreaming.Encoder.H264Profile` | `-PixelStreamingH264Profile=<value>` | `"BASELINE"` | 编码器使用的H264配置文件。支持的模式有 `"AUTO"` 、 `"BASELINE"` 、 `"MAIN"` 、 `"HIGH"` 、 `"HIGH444"` 、 `STEREO` 、 `SVC_TEMPORAL_SCALABILITY` 、 `PROGRESSIVE_HIGH` 、 `CONSTRAINED_HIGH` 。 基线（Baseline）是唯一保证能受到支持的配置文件，前提是接收方的设备支持WebRTC。 |

### WebRTC配置

更改以下设置将配置像素流插件内部使用的WebRTC库。

| 控制台变量 | 命令行参数 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `N/A` | `-LogCmds="LogPixelStreamingWebRTC <LogLevel>"` | `Log` | 指定WebRTC的日志级别。对于调试WebRTC非常实用。一些有帮助的Log级别包括：Log、Verbose、VeryVerbose |
| `PixelStreaming.WebRTC.DegradationPreference` | `-PixelStreamingWebRTCDegradationPreference=<value>` | `"MAINTAIN_FRAMERATE"` | 降级偏好是WebRTC的策略，即在更改编码器比特率/QP不足时，破坏性地调整比特率（更改分辨率/丢帧）。 |
| `PixelStreaming.WebRTC.MaxFps` | `-PixelStreamingWebRTCMaxFps=<value>` | `60` | 最大FPS WebRTC将尝试捕获/编码/传输。 |
| `PixelStreaming.WebRTC.StartBitrate` | `-PixelStreamingWebRTCStartBitrate=<value>` | `10000000` | WebRTC将尝试开始流送的起始比特率（bps）。 值必须介于最小和最大比特率之间。 |
| `PixelStreaming.WebRTC.MinBitrate` | `-PixelStreamingWebRTCMinBitrate=<value>` | `100000` | 最小比特率（bps），WebRTC的请求不会低于该值。 注意不要将此值设置得太高，否则WebRTC会丢帧。 |
| `PixelStreaming.WebRTC.MaxBitrate` | `-PixelStreamingWebRTCMaxBitrate=<value>` | `100000000` | 最大比特率（bps），WebRTC的请求不会超出该值。 注意，不要将此值设置得太高，因为本地（理想）网络实际上会尝试达到此值。 |
| `PixelStreaming.WebRTC.DisableReceiveAudio` | `-PixelStreamingWebRTCDisableReceiveAudio` | `false` | 禁用从浏览器接收音频到UE。 如果不需要音频，在某些情况下可以改善延迟。 |
| `PixelStreaming.WebRTC.DisableTransmitAudio` | `-PixelStreamingWebRTCDisableTransmitAudio` | `false` | 禁止将UE音频传输到浏览器。 如果不需要音频，在某些情况下可以改善延迟。 |
| `PixelStreaming.WebRTC.DisableAudioSync` | `-PixelStreamingWebRTCDisableAudioSync` | `true` | 在WebRTC中禁用音频和视频轨道的同步。 如果不需要同步，这会改善延迟。 |
| `PixelStreaming.WebRTC.MinPort` | `-PixelStreamingWebRTCMinPort` | `49152` | 设置WebRTC端口分配器的最小可用媒体端口数量。 |
| `PixelStreaming.WebRTC.MaxPort` | `-PixelStreamingWebRTCMaxPort` | `65535` | 设置WebRTC端口分配器的最大可用媒体端口数量。 |
| `PixelStreaming.WebRTC.PortAllocator.Flags` | `-PixelStreamingWebRTCPortAllocatorFlags` | `""` | 设置WebRTC端口分配器的标记。标记用逗号分隔。支持的值有：DISABLE_UDP, DISABLE_STUN, DISABLE_RELAY, DISABLE_TCP, ENABLE_IPV6, ENABLE_SHARED_SOCKET, ENABLE_STUN_RETRANSMIT_ATTRIBUTE, DISABLE_ADAPTER_ENUMERATION, DISABLE_DEFAULT_LOCAL_CANDIDATE, DISABLE_UDP_RELAY, ENABLE_IPV6_ON_WIFI, ENABLE_ANY_ADDRESS_PORTS, DISABLE_LINK_LOCAL_NETWORKS |
| `PixelStreaming.WebRTC.DisableFrameDropper` | `-PixelStreamingWebRTCDisableFrameDropper` | `false` | 禁用WebRTC内部的帧丢弃机制，如果在诸如LAN流送这类场景中出现帧丢失的情况，该机制很有用。 |
| `PixelStreaming.WebRTC.VideoPacing.MaxDelay` | `-PixelStreamingWebRTCVideoPacingMaxDelay` | `-1.0` | 启用WebRTC视频速率控制试验，并设置最大延迟（毫秒）参数（值小于零的将被丢弃）。 |
| `PixelStreaming.WebRTC.VideoPacing.Factor` | `-PixelStreamingWebRTCVideoPacingFactor` | `-1.0` | 启用WebRTC视频速率控制试验，并设置视频速率调整因子参数。值越大，在较大比特率下就越宽松。 |
| `PixelStreaming.WebRTC.FieldTrials` | `-PixelStreamingWebRTCFieldTrials` | `""` | 设置WebRTC试验字符串。格式："TRIAL1/VALUE1/TRIAL2/VALUE2/"。 |
| `PixelStreaming.DecoupleFramerate` | `-PixelStreamingDecoupleFramerate` | `""` | 启用解耦（Decoupled）模式，允许WebRTC和应用程序FPS以不同帧率流送。像素流送会试图以固定帧率流送。如果你的应用程序无法以目标帧率流送，它会发送重复的帧。 |

## 信令服务器配置参数

有两种参数设置方法：

- 在命令行上，当你通过运行

  start_with_stun.bat

  启动信令和Web服务器时。在这种情况下，在每个参数名称前加上

  --

  （两个连接号），然后在它后面加上空格，后面是你要设置的值。例如：

  --player_port 81

  。
- 在配置文件中。默认情况下，信令和Web服务器（

  cirrus.js

  ）会在同一文件夹中查找名为

  config.json

  的文件。在这种情况下，将每个参数和你要为其设置的值设置为文件中定义的JSON对象中的键值对。如果你已经至少启动过一次信令和Web服务器，请参阅

  此处

  的参数。

> [!NOTE]
> 关于信令服务器的完整参数列表，请参阅[此处](https://github.com/EpicGamesExt/PixelStreamingInfrastructure/tree/master/SignallingWebServer)的像素流送基础设施中的相关页面。

## 匹配器服务器命令行参数

当你通过运行 `run.bat` 文件启动匹配器服务器，或通过运行 `node.exe matchmaker.js` 启动它时，请在命令行上提供这些参数。

| 参数 | 说明 |
| --- | --- |
| `--httpPort <value>` | 设置匹配器侦听来自客户端的HTTP连接的端口号。 默认值为 `90`。 |
| `--matchmakerPort <value>` | 设置匹配器侦听来自Cirrus信令服务器的传入消息的端口号。 默认值为 `9999`。 |

## SFU服务器参数

| 参数 | 说明 |
| --- | --- |
| `--PublicIP=<value>` | 你的SFU服务器将使用的公共IP地址。 |

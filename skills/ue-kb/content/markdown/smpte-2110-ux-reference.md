# SMPTE 2110 UX Reference

---
title: "SMPTE 2110 UX Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/smpte-2110-ux-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "将SMPTE 2110用于nDisplay", "SMPTE 2110 UX Reference"]
---

# SMPTE 2110 UX Reference

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / 将SMPTE 2110用于nDisplay / SMPTE 2110 UX Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/smpte-2110-ux-reference-in-unreal-engine

本页提供在 Unreal Engine 中结合 NVIDIA Rivermax 使用 SMPTE 2110 的 UX 指南。

## 设置

### Project Settings

可以在项目的 **Project Settings**下配置以下设置： **Plugins - NVIDIA Rivermax**.

![image alt text](../../../../../../assets/images/ac/ac18de9d53bd5340e43d5f525e3766d2f4a670099ab7691d164755ca5a87d7e4.png)

NVIDIA Rivermax 插件的设置。

| **设置** | **说明** |
| --- | --- |
| **Time Source** | 该设置控制 Rivermax 库的时钟源（计时参考）。 **PTP：** 在 Windows 上使用 BlueField-2 卡时，可以将 Rivermax 的时钟配置为 PTP，由 NIC 上的 DPU 处理。 **System：** 使用时，Rivermax 会将系统时间用作其时钟。 **Engine：** 使用时，Rivermax 会使用 Unreal Engine’s time returned by `FPlatformTime::Seconds`. |
| **PTP Interface Address** | 仅用于 PTP Time Source。这是 PTP 来源的接口地址。 |

### 资产

以下部分说明 NVIDIA Rivermax 的资产类型，可在 Content Browser 中创建和访问这些资产。

#### Rivermax Media Source

![Rivermax Media Source settings.](../../../../../../assets/images/d8/d8960913437f325b1572a188bcdb245682af69cafe70990bfc9fd7ab524dd9c5.png)

Rivermax Media Source 设置。

使用 Rivermax Media Source 设置来配置想要在 Unreal Engine 中接收的流。以下是各设置说明：

| **设置** | **说明** |
| --- | --- |
| **Player** |  |
| **Player Mode** | 消费传入视频样本的播放器会将其用作运行模式。当前有两个选项： **Latest（默认）**：在此模式下，当与播放器关联的 MediaTexture 被渲染时，会选择并渲染最新可用样本。 **Framelock**: 渲染纹理时，播放器会查找特定帧。 Each 2110 接收到的视频样本都有时间戳，我们会将其转换为帧号。 选择要渲染的样本时，播放器会查找帧号与引擎’s frame number. If it’s 不存在，则会等待并预期该样本会被接收。 这适用于不同 UE 实例之间进行帧锁定的 UE 到 UE 场景，例如 nDisplay 设置。 |
| **Use Zero Latency** | 该选项仅在播放器处于 framelock 模式时适用。 如果设为 true，播放器查找帧号时会查找具有引擎当前帧号的样本。 如果设为 false，它会查找前一帧（-1) ）相对于引擎的帧号。’s. Media I/O now 支持“just in time”采集和接收媒体的机制，因此在 UE 到 UE 传输视频时可以实现零帧延迟。 下图展示其工作方式： Zero Latency flowchart 如果共享 inner frustum 时未勾选 Zero Latency，则 nDisplay 配置 Actor 属性中的 **Global Media Settings: Latency** 应设为 1。这样会缓冲 outer frustum 和相关投影矩阵，使 inner 能扭曲到正确位置，并让 outer 帧号与 inner 帧号匹配： Latency setting |
| **选项** |  |
| **Resolution** | **如果启用**，输入的分辨率会与传入视频流进行比较。如果不匹配，将记录错误。 **如果未启用**，媒体会使用 RTP 头检测分辨率，并自动适配传入流。 |
| **Frame Rate** | 视频流的帧率。 |
| **Pixel Format** | 视频流的像素格式。Unreal Engine 支持 2110-20 标准所支持格式中的一个子集。 Supported pixel formats |
| **Interface Address** | 这是要使用的网络接口 IP 地址。 也就是视频流进入的位置。 支持通配符（`*` and `?`），以便系统可在接口 IP 不同的机器之间复用配置。 |
| **Stream Address** | 这是读取流的 IP 地址。它通常是发送端广播到的多播地址。 |
| **Port** | 流发送到的端口号。 |
| **Video** |  |
| **Is sRGB Input** | 如果为 true，会对 RGB 样本应用 sRGB 到 Linear 的转换。 |
| **Advanced** |  |
| **Use GPU Direct** | 启用且受支持时，样本内存会直接从网卡内存进入 GPU 内存，绕过系统内存。目前由于接收多个流时存在性能问题，该功能已使用 CVar 全局禁用。 |

> [!NOTE]
> 位于 **Synchronization** 分类中的设置当前未使用。

#### Rivermax Media Output

![Rivermax Media Output settings.](../../../../../../assets/images/c2/c28a893d3d6ad34b1477fc9f9f54de162b94cf0538ef953dec20843f423ae0ed.png)

Rivermax Media Output 设置。

| **设置** | **说明** |
| --- | --- |
| **Output** |  |
| **Alignment Mode** | 控制输出帧调度的时序。选项包括： **Alignment Point：** 在此模式下，会使用 Rivermax 时间根据 ST2059 调度输出帧时序（“alignment”点）。每帧都会被调度到这些 alignment point 上发送。 **Frame Creation：** 在此模式下，调度器会在帧创建后开始调度该帧。 随后按指定帧间隔激活并发送下一帧。 如果没有可用帧，它会等待下一帧并立即发送。 这对 nDisplay 中的 ICVFX 流很有用，可在向其他节点发送 Inner Frustum 渲染时降低延迟。 |
| **Do Continuous Output** | 仅当 **Alignment Mode** 使用 **Alignment Point** 方法时支持。使用该选项可在每个 alignment point 上持续输出一帧，即使没有可发送帧。在这种情况下会重复上一帧。如果禁用此选项，并且某个 alignment point 上没有可用帧，则会跳过该点，调度器会在下一个 alignment point 再次尝试。 |
| **Frame Locking Mode** | 仅当 **Alignment Mode** 使用 **Alignment Point** method. 选项控制捕获帧时会发生什么： **Free Run：** 如果 presentation queue 中没有空间，则丢弃该帧。 **Block on Reservation：** 如果 presentation queue 中没有空间，RHI 线程会阻塞，直到队列中有空间。如果引擎运行速度快于配置的输出流（例如 60fps 对 24fps），引擎会锁定到 presentation 帧率。 |
| **Presentation Queue Size** | 待发送帧队列的大小。数值越大，帧发送和帧渲染之间的延迟越高。默认使用双缓冲，但可以增大此值以容忍更大的卡顿。 |
| **Do Frame Counter Timestamping** | 仅当 **Alignment Mode** 使用 **Frame Creation** 方法时适用。它会转换创建帧时生成的引擎帧号，并将其用作该样本的时间戳。在 UE 到 UE 设置中，可与 RivermaxMediaSource 的 Framelock 播放器模式配合使用，主要用于 nDisplay。 |
| **Advanced** |  |
| **Number of Texture Buffers** | 基础 MediaCapture 设置，用于控制 MediaCapture 预分配的纹理。 |
| **设置** |  |
| **Resolution** | 如果 **启用**, 捕获的纹理大小会按所需输出分辨率验证。 If it doesn’t match, it will error out. If **禁用**，输出流分辨率会根据传入捕获纹理自动配置。 |
| **Frame Rate** | 视频流的帧率。 |
| **Pixel Format** | 视频流的像素格式。Unreal Engine 支持 2110-20 标准所支持格式中的一个子集。 Supported pixel formats |
| **Interface Address** | 这是要使用的网络接口 IP 地址。 也就是视频流来源位置。 支持通配符（`*` and `?`），以便系统可在接口 IP 不同的机器之间复用配置。 |
| **Stream Address** | 这是流发送到的 IP 地址。它通常是流要广播到的多播地址。要真正区分多播组，应让地址不同，而不仅是端口不同。 |
| **Port** | 流发送使用的端口号。 |
| **Video** |  |
| **Use GPUDirect** | 启用且受支持时，样本内存会直接从 GPU 内存进入网卡内存，绕过系统内存。 |

#### Rivermax Custom Timestep

可以从 MediaProfile 或项目设置配置引擎的自定义 timestep，现在也可以使用 Rivermax。

![Rivermax Custom Timestep settings.](../../../../../../assets/images/8c/8c66245f4e97dfb7999c5232904736bd5ae3bd120b264ea82ce718ac034b85fe.png)

Rivermax Custom Timestep 设置。

使用 Alignment Point 方法时，自定义 timestep 会使用与 Rivermax 输出相同的 alignment 方法。这意味着可以按特定帧率对引擎进行 genlock，并基于 ST2059 alignment point 公式对齐。

自定义 timestep 需要 PTP 时钟，因为它使用 Rivermax 项目设置中配置的 Time Source 设置，并与其他设备可能使用的标准 genlock 信号对齐。


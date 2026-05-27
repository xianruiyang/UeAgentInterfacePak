---
title: "AJA媒体框架参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/aja-media-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "专业视频I/O", "AJA媒体框架参考"]
---

# AJA媒体框架参考

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 专业视频I/O / AJA媒体框架参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/aja-media-reference-for-unreal-engine

本文介绍了AJA媒体框架对象公开的选项和设置。

## 受支持的AJA视频采集卡和软件

AJA媒体源和AJA媒体输出已使用以下视频采集卡进行测试（所用AJA桌面软件版本为 **15.2版本** 或之后的版本）：

- **Corvid 88**
- **Corvid 44 12G**
- **Corvid 44 12G BNC**
- **Corvid 44**
- **Corvid 44 BNC**
- **KONA 4** （支持4K位文件，不支持UFC位文件）
- **KONA 5** （同时支持 `KONA 5（4K）` 和 `KONA 5（8K）` 位文件）
- **KONA HDMI**
- **Io 4K Plus**

其他设备和SDK版本有可能会按预期工作，也可能无法正常工作。

## AJA媒体源

你创建的每个AJA媒体源资产都会公开以下配置下拉菜单设置和细节面板设置。

### AJA媒体源配置下拉菜单设置

本节中所介绍的设置可以通过AJA媒体源细节面板顶部的配置（Configuration）下拉菜单访问。

![AJA Media Source Configuration dropdown menu](../../../../../assets/images/ce/ce58d97480d78c884ee22647abd2488a7589ddafaad62d35a603a374c07f2aa4.png)

| **设置** | **说明** |
| --- | --- |
| **设备（Device）** | 设置此媒体源将用于将视频导入虚幻引擎的AJA设备。如果你的计算机上连接着多个卡或设备，你可以在这里选择一个使用。 |
| **源（Source）** | 设置此媒体源将用于将视频导入虚幻引擎的指定设备上的端口或SDI连接。注意，只支持单链路连接。 |
| **分辨率（Resolution）** | 设置传入视频源的分辨率。注意，这必须与实际的视频源完全匹配。 |
| **标准（Standard）** | 设置传入的视频源是逐行还是隔行的。注意，这必须与实际的视频源完全匹配。 |
| **帧率（Frame Rate）** | 设置传入内容中每秒的视频帧数。注意，这必须与实际的视频源完全匹配。 |

### AJA媒体源细节面板设置

细节面板中位于 **AJA** > **配置（Configuration）** 下的设置始终都是灰色的，因为它们要通过配置（Configuration）下拉菜单设置。这些设置的值作为引用显示。根据具体的媒体源资产，某些引用字段可能不适用。

> [!NOTE]
> 媒体源细节面板的设置是所有采集卡共享的，因此某些设置可能无法生效。请仔细确认哪些设置适用于你的AJA采集卡。

![AJA Media Source Details panel](../../../../../assets/images/cd/cdecff868f7ec298146edd64e522727177c8948b73a50c0991d6ca83aac7f01e.png)

| **设置** | **说明** |
| --- | --- |
| **AJA** |  |
| **配置（Configuration）** | 提供对配置（Configuration）下拉菜单的访问，并显示设置摘要。 |
| **配置 - 媒体连接（Configuration - Media Connection）** |  |
| **设备（Device）** | 显示将被此媒体源用于将视频流送到虚幻引擎的AJA设备。子字段包括 **设备名称（Device Name）** 及 **设备标识符（Device Identifier）**。只读。 |
| **协议（Protocol）** | 显示通信协议。只读。 |
| **传输类型（Transport Type）** | 显示传输类型。只读。 |
| **四元传输类型（Quad Transport Type）** | 显示四元传输类型（如适用）。只读。 |
| **端口标识符（Port Identifier）** | 显示端口。只读。 |
| **配置 - 媒体模式（Configuration - Media Mode）** |  |
| **帧率（Frame Rate）** | 显示传入的媒体源每秒的视频帧数量。请注意，此数值必须与实际视频源完全一致。只读。 |
| **分辨率（Resolution）** | 显示传入的媒体源的分辨率。请注意，此数值必须与实际视频源完全一致。只读。 |
| **标准（Standard）** | 显示传入的媒体源是逐行还是隔行显示。只读。 |
| **设备模式标识符（Device Mode Identifier）** | 显示AJA设备的模式标识符。只读。 |
| **时间码格式（Timecode Format）** | 指定伴随视频信号的时间码类型。 |
| **使用自动循环捕捉（Capture with Auto Circulating）** | 同时采集视频、音频和辅助数据。这可能会降低传输性能，但它保证每个帧的所有数据将一起同步。 如果你遇到延迟问题，可以尝试禁用此选项。 |
| **辅助（Ancillary）** |  |
| **捕捉辅助（Capture Ancillary）** | 确定虚幻引擎是否采集伴随视频信号的辅助元数据（metadata）。 |
| **辅助- 高级（Ancillary - Advanced）** |  |
| **最大帧数辅助框架缓存（Max Num Ancillary Frame Buffer）** | 设置虚幻引擎在任何给定时间将存储在内存中的辅助数据的最大帧数。如果输入视频跳帧或卡顿，你可以尝试提高这个值。 |
| **音频（Audio）** |  |
| **采集音频（Capture Audio）** | 确定虚幻引擎是否从媒体端口采集音频。 |
| **音频通道（Audio Channel）** | 指定包含你希望虚幻引擎采集的信号的音频通道。 |
| **音频 - 高级（Audio - Advanced）** |  |
| **最大帧数音频框架缓存（Max Num Audio Frame Buffer）** | 设置虚幻引擎在任何给定时间将存储在内存中的音频数据的最大帧数。如果输入视频跳帧或卡顿，你可以尝试提高这个值。 |
| **视频（Video）** |  |
| **采集视频（Capture Video）** | 确定虚幻引擎是否从媒体端口采集视频。 |
| **颜色格式（Color Format）** | 确定构成输入视频中各个像素的颜色通道的顺序，以及每个通道中的比特数。 |
| **解交错器（Deinterlacer）** | 选择如何处理传入的交错流送内容。可用的选项有： 无（默认） 混合解交错器 Bob解交错器 Discard解交错器 |
| **交错场顺序（Interlace Field Order）** | 交错场的复制顺序。选项有：先顶部交错场（Top Field First）和先底部交错场场（Bottom Field First）。 |
| **重载源编码（Override Source Encoding）** | 启用此字段可重载源编码。从下拉菜单选择重载编码。 |
| **重载源色彩空间（Override Source Color Space）** | 启用此字段可重载源色彩空间。从下拉菜单选择重载色彩空间。 |
| **视频 - 色彩转换设置（Video - Color Conversion Settings）** |  |
| **配置源（Configuration Source）** | 使用此属性可定义OCIO配置。详见[OCIO文档](../../../managing-color/color-management-with-opencolorio/index.md)。 |
| **变换源（Transform Source）** | 使用此属性可定义OCIO变换源。详见[OCIO文档](../../../managing-color/color-management-with-opencolorio/index.md)。 |
| **变换目标（Transform Destination）** | 使用此属性可定义OCIO变换目标。详见[OCIO文档](../../../managing-color/color-management-with-opencolorio/index.md)。 |
| **视频 - 高级（Video - Advanced）** |  |
| **最大帧数视频框架缓存（Max Num Video Frame Buffer）** | 设置虚幻引擎在任何给定时间将存储在内存中的视频数据的最大帧数。如果输入视频跳帧或卡顿，你可以尝试提高这个值。 |
| **调试（Debug）** |  |
| **记录丢帧（Log Drop Frame）** | 启用后，每当虚幻引擎检测到输入内容中的帧丢失时，它就在输出日志上记录一条消息。 |
| **烧入帧时间码（Burn Frame Timecode）** | 启用后，引擎会将每一帧的时间码嵌入采集到的视频。你可以用它检查输入的每一帧的时间码是否符合你的预期。详见[时间码纹素编码](../timecode-and-genlock/index.md#timecodetexelencoding)。 |
| **同步（Synchronization）** |  |
| **时间同步（Time Synchronization）** | 决定用户是否希望根据引擎时间同步媒体。这是时间码样本求值类型（Timecode Sample Evaluation Type）和帧延迟（Frame Delay）设置的先决条件。 |
| **帧延迟（Frame Delay）** | 此设置取决于是否启用了时间同步。它用于根据引擎的时间码找到正确的帧，并基于播放器/媒体源的帧率进行计算。例如，如果播放器处于第2帧，而你将帧延迟值设置为1帧，那么媒体播放器将在屏幕上显示较旧的帧（第2帧 - 帧延迟 = 1），尽管第2帧也是可用的。 |
| **时间延迟（Time Delay）** | 当你未使用时间同步设置时，会使用此设置。与帧延迟类似，在引擎选择要显示的帧时也会将此设置考虑在内。 |
| **同步 - 高级（Synchronization - Advanced）** |  |
| **仅及时渲染（Just in Time Rendering）** | 启用此选项会将媒体源像素的处理推迟到当前帧管线中的最后可能位置，这样就能为来自外部源的像素提供更多时间，并使其能够被渲染到播放设备上渲染到当前帧。 |
| **帧锁定（Framelock）** | 此选项对AJA源不适用，即使启用也会被忽略。 |
| **样本求值类型（Sample Evaluation Type）** | 确定虚幻引擎是只输出填充图像，还是同时输出填充图像和关键图像。 当你将此设置为 **仅填充（Fill Only）** 时，仅将填充图像输出到下面的 **源（Source）** 集合。 当你将此设置为 **填充和关键（Fill and Key）** 时，填充图像将输出到 **源（Source）**，关键图像将输出到 **关键源（Key Source）**。 |

## AJA媒体输出设置

你创建的每个AJA媒体输出对象都公开以下配置（Configuration）下拉菜单设置和细节面板设置。

### AJA媒体输出配置下拉菜单设置

本节中所介绍的设置可以通过AJA媒体输出细节面板顶部的配置（Configuration）下拉菜单访问。

![AJA Media Output Configuration dropdown menu](../../../../../assets/images/ba/ba3a3ff84bfefecbdf4340a845e3de107627af50499dd459b487d77065fd43c7.png)

| 设置 | 说明 |
| --- | --- |
| **输出类型（Output Type）** | 确定虚幻引擎是只输出填充图像，还是同时输出填充图像和关键图像。 当你将此设置为 **仅填充（Fill Only）** 时，仅将填充图像输出到下面的 **源（Source）** 集合。 当你将此设置为 **填充和关键（Fill and Key）** 时，填充图像将输出到 **源（Source）**，关键图像将输出到 **关键源（Key Source）**。 |
| **设备（Device）** | 设置此媒体源将其视频源发送到的AJA设备。如果你的计算机上连接着多个卡或设备，你可以在这里选择一个使用 |
| **目标（Destination）** | 设置此媒体源将发送视频到的指定 **设备（Device）** 上的端口或SDI连接。 |
| **分辨率（Resolution）** | 选择如何处理传入的交错流送内容。可用的选项有： 无（默认） 混合解交错器 Bob解交错器 Discard解交错器 |
| **标准（Standard）** | 设置此媒体输出生成的输出内容是逐行还是隔行的。 |
| **帧率（Frame Rate）** | 设置此媒体输出生成的视频源中的每秒帧数。 |
| **关键帧源（Key Source）** | 设置从虚幻引擎接收关键帧图像的端口。此选项只有在 **输出类型（Output Type）** 被设置为 **填充和关键帧（Fill and Key）** 时才可用。 |
| **引用（Reference）** | 配置AJA采集卡上的内部时钟的计时源。采集卡使用这个来决定什么时候应该发送视频输出的每一帧。 **空转（Free Run）-** 使用采集卡的内部时钟。 **外部（External）-** 将采集卡的内部时钟与从外部源到达采集卡的引用引脚的集中同步信号同步。 **输入（Input）-** 与你在下面的 **同步源（Sync Source）** 设置中指定的输入端口的视频信号同步。 |

### AJA媒体输出细节面板设置

细节面板中位于 **AJA** > **配置（Configuration）** 下的设置始终都是灰色的，因为它们要通过配置（Configuration）下拉菜单设置。这些设置的值作为引用显示。根据具体的媒体源资产，某些引用字段可能不适用。

> [!NOTE]
> 媒体源细节面板的设置是所有采集卡共享的，因此某些设置可能无法生效。请仔细确认哪些设置适用于你的AJA采集卡。

![AJA Media Output Details panel](../../../../../assets/images/0b/0bd8465c19f25fbcd7369af58c922198935a1eaf54e0c590877662c8c972d198.png)

| 设置 | 说明 |
| --- | --- |
| **AJA** |  |
| **配置（Configuration）** | 提供对配置（Configuration）下拉菜单的访问，并显示设置摘要。 |
| **媒体配置（Media Configuration）** | 显示 **配置（Configuration）** 下拉菜单中所选择的配置设置的摘要。 |
| **配置 - 媒体连接（Configuration - Media Connection）** |  |
| **设备（Device）** | 显示将被此媒体输出用于将视频流送到虚幻引擎的AJA设备。子字段包括 **设备名称（Device Name）** 及 **设备标识符（Device Identifier）**。只读。 |
| **协议（Protocol）** | 显示通信协议。只读。 |
| **传输类型（Transport Type）** | 显示传输类型。只读。 |
| **四元传输类型（Quad Transport Type）** | 显示四元传输类型（如适用）。只读。 |
| **端口标识符（Port Identifier）** | 显示端口。只读。 |
| **配置 - 媒体模式（Configuration - Media Mode）** |  |
| **帧率（Frame Rate）** | 显示此媒体输出产生的媒体源每秒的帧数。只读。 |
| **分辨率（Resolution）** | 显示此媒体输出产生的媒体源的分辨率。只读。 |
| **标准（Standard）** | 显示显示此媒体输出产生的媒体源是逐行还是隔行显示。只读。 |
| **设备模式标识符（Device Mode Identifier）** | 显示AJA设备的模式标识符。只读。 |
| **输出类型（Output Type）** | 显示输出类型。只读。 |
| **关键帧端口标识符（Key Port Identifier）** | 显示将被引擎用于输出关键帧信号的采集卡物理端口。只读。 |
| **输出引用（Output Reference）** | 显示AJA采集卡内部时钟定时的来源。只读。 |
| **输出端口标识符（Output Port Identifier）** | 显示被引擎用于输出视频信号的物理端口。只读。 |
| **输出（Output）** |  |
| **使用音频循环输出（Output with Auto Circulating）** | 启用后，虚幻引擎会在将其输出帧发送到AJA卡之前缓冲它们。这可能会提高视频信号的平滑度，代价是略有一些延迟。 禁用此选项可最小化延迟，但输出信号可能会有中断。 |
| **时间码格式（Timecode Format）** | 确定虚幻引擎是否应该在输出内容中嵌入时间码，以及应该使用哪种时间码格式。 |
| **像素格式（Pixel Format）** | 确定构成各个像素的颜色通道的顺序，以及每个通道中的比特数。 如果你想输出alpha，请将 **输出类型（Output Type）** 设置为 **填充和关键（Fill and Key）**，并使用 **关键源（Key Source）** 将alpha发送到AJA卡上的输出端口。 |
| **输出音频（Output Audio）** | 启用此项后，可在输出时将引擎的音频与视频信号一起发送。 |
| **音频缓冲区大小（Audio Buffer Size）** | 在将样本发送至网络之前需要缓冲的样本数量。 |
| **输出音频通道数（Num Output Audio Channels）** | 确定采集卡上要输出的音频通道数量。此值必须大于引擎中使用的音频通道数量。 |
| **音频采样率（Audio Sample Rate）** | 每秒发送到网络的音频样本数量。此值必须与引擎的音频采样率一致。 |
| **在音频线程上输出音频（Output Audio on Audio Thread）** | （实验性功能 - 只在PingPong模式下生效）启用后，将使用音频线程（而非采集线程）将音频发送到采集卡。 |
| **输出 - HDR（Output - HDR）** |  |
| **EOTF** | 决定引擎在将数字信号转换为亮度时所使用的数学函数。 |
| **Gamut** | 决定输出可以显示的色彩范围。 |
| **输出 -高级（Output - Advanced）** |  |
| **以3GLevel B输出（Output in 3GLevel B）** | 启用后可配置采集卡，以将输出视频信号转换为使用Level B，而非Level A。 |
| **翻转关键帧输出（Invert Key Output）** | 在进行关键帧（Key）和填充（Fill）输出时，此选项可控制是否翻转关键帧信号中的值。当关键帧收到的视频中的Alpha是反的，而你需要在将其发送出去之前纠正这一点时，此选项非常有用。 |
| **AJA缓冲区数（Number of AJA Buffers）** | 设置用于将各个帧图像从主线程内存传输到AJA卡的缓冲区数量。 值越小，越可能导致丢帧，因为它要等待每次传输完成；数值越大，则越可能增加延迟。 |
| **隔行区域时间码需匹配（Interlaced Fields Timecode Need to Match）** | 在生成隔行视频源时，此设置确定是否需要匹配单个隔行帧中两个字段的时间码值。 |
| **将隔行显示输出为逐行显示（Output Interlace as Progressive）** | 在生成隔行显示的输出时，启用此项可以将隔行显示的帧当做逐行信号发送。（实验性/调试用） |
| **使用多线程调度（Use Multithreaded Scheduling）** | 启用后，可以在不同的线程上从捕获卡的缓冲区中写出视频帧，这在以4K/8K的分辨率输出时有助于提升性能。 |
| **纹理缓冲区数（Number of Texture Buffers）** | 设置用于将各个帧图像从GPU传输到主线程内存的缓冲区数量。 值越小，越可能在GPU端造成瓶颈，因为它要等待每次传输完成；数值越大，则越可能增加延迟。 |
| **等待同步事件（Wait for Sync Event）** | 如果禁用此选项，并且你还没有将虚幻引擎集中同步到输入信号，则引擎将以它能够管理的最快帧率运行，并将生成的所有帧提供给AJA卡。每当卡准备输出一个新帧时，它都会选择由引擎生成的帧。 启用此选项后，在AJA卡准备接受新帧之前，虚幻引擎不会生成任何新的输出帧。其效果类似于集中同步，但它不是将虚幻引擎的帧率锁定为输入信号，而是将引擎的帧率锁定为AJA卡的输出计时。 当你还没有可以将虚幻引擎的帧率锁定到的输入信号，但你希望确保引擎为输出视频源中的每一帧只生成一个输出帧时，这个选项非常有用。 如果你已经使用自定义时间步将虚幻引擎集中同步到输入内容，则不要启用此选项。 |
| **调试（Debug）** |  |
| **记录丢帧（Log Drop Frame）** | 启用后，每当虚幻引擎检测到输入源中的帧丢失时，它就在输出日志上记录一条消息。 |
| **烧入帧时间码（Burn Frame Timecode）** | 启用后，引擎会将每一帧的时间码嵌入输出信号。详见[时间码纹素编码](../timecode-and-genlock/index.md#timecodetexelencoding)。 |

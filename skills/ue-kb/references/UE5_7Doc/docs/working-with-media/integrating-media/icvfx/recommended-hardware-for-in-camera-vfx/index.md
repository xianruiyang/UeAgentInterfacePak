---
title: "ICVFX推荐硬件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/recommended-hardware-for-in-camera-vfx-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "ICVFX", "ICVFX推荐硬件"]
---

# ICVFX推荐硬件

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / ICVFX / ICVFX推荐硬件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/recommended-hardware-for-in-camera-vfx-in-unreal-engine

采用虚幻引擎拍摄镜头内视效时，你需要让多台电脑相互通信，还需控制LED摄影棚中的显示内容。本文将介绍适合镜头内视效使用的硬件配置。

![undefined](../../../../../assets/images/21/21242952357e5818ed7f05fe889f07191f20c7c3d14fef9623c43df90f8b4c01.jpg)

带有三个渲染节点的硬件布局示例。点击查看大图。

> [!NOTE]
> 大多数LED处理器都可以通过外部的同步锁定源或显卡传入的视频信号来接收同步。请检查你当前使用的LED处理器有哪些可用的接收方案。在硬件图表中，LED处理器通过外部同步锁定源来获得同步。

### 推荐的设备硬件

| 列 1 | 列 2 |
| --- | --- |
| 工作站 | 选择工作站时，请务必为内存、硬盘和图形硬件准备好充足的空间和电源。如果你想利用多GUP（从虚幻引擎4.26开始提供），请确保你的工作站有足够的空间并且可以支持[NVLink](https://www.nvidia.com/en-us/design-visualization/nvlink-bridges/)。 |
| CPU | 一般来说，CPU的时钟速度比CPU的核心数量更重要。当核心数量超过八个之后，如果继续增加核心数量，好处将主要体现在代码和着色器的编译时间上。建议你一开始选择至少3千兆赫（GHz）的时钟速度。一些常用于镜头内视效方案的CPU包括[英特尔Xeon](https://www.intel.com/content/www/us/en/products/processors/xeon.html)和[英特尔酷睿i9处理器](https://www.intel.com/content/www/us/en/products/processors/core/i9-processors.html)，以及[AMD Ryzen 9 3950X](https://www.amd.com/en/products/cpu/amd-ryzen-9-3950x)和[AMD线程撕裂者](https://www.amd.com/en/products/ryzen-threadripper)。 |
| 内存 | 在大多数镜头内视效案例中，我们推荐使用64GB的DDR-4内存。假如你在拍摄中需要用到大型文件，你可能还需要增加内存。 |
| GPU | **美术师工作站**： 对于需要使用[光线追踪](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)和其他虚幻引擎高级渲染功能的美术师来说，推荐使用专业级的NVIDIA RTX系列显卡： [NVIDIA RTX A6000](https://www.nvidia.com/en-us/design-visualization/rtx-a6000) [NVIDIA RTX A5000](https://www.nvidia.com/en-us/design-visualization/rtx-a5000) [NVIDIA Quadro RTX 8000](https://www.nvidia.com/en-us/design-visualization/quadro/rtx-8000) [NVIDIA Quadro RTX 6000](https://www.nvidia.com/en-us/design-visualization/quadro/rtx-6000) 渲染要求相对较低的美术师可以使用消费级NVIDIA RTX显卡： [NVIDIA GeForce RTX 3080Ti](https://www.nvidia.com/en-us/geforce/graphics-cards/30-series/rtx-3080-3080ti/) [NVIDIA GeForce RTX 3090](https://www.nvidia.com/en-us/geforce/graphics-cards/30-series/rtx-3090/) **渲染节点**： 你需要使用[NVIDIA Quadro Sync](https://www.nvidia.com/en-us/design-visualization/solutions/quadro-sync/)来同步单个LED摄影棚中不同显示屏上的内容。每个渲染节点设备都需要在显卡之外额外加装这张视频卡。你可以阅读NVIDIA的[Quadro Sync II用户指南](https://images.nvidia.com/content/quadro/product-literature/user-guides/Quadro-Sync-II-User-Guide.pdf)了解详情。 对于使用单显卡或双显卡的渲染节点，我们推荐使用如下NVIDIA RTX显卡： [NVIDIA RTX A6000](https://www.nvidia.com/en-us/design-visualization/rtx-a6000) [NVIDIA Quadro RTX 8000](https://www.nvidia.com/en-us/design-visualization/quadro/rtx-8000) [NVIDIA Quadro RTX 6000](https://www.nvidia.com/en-us/design-visualization/quadro/rtx-6000) 如需了解NVIDIA Quadro Sync兼容的完整显卡列表，请参阅NVIDIA的[Quadro Sync](https://www.nvidia.com/en-us/design-visualization/solutions/quadro-sync/)主页。 如果你计划利用 nDisplay 的多GPU支持功能，所有显卡必须都支持[NVLINK](https://www.nvidia.com/en-gb/design-visualization/nvlink-bridges/)。 我们通常建议使用英伟达的最新驱动程序。特别是，当某台工作站使用多个GPU时，请确保使用 **R512.59或更高版本**。 你可以在[NVIDIA的驱动程序下载页面](https://www.nvidia.com/Download/index.aspx)查找推荐用于虚拟制片的驱动程序。选择你的显卡类型和操作系统，将 **下载类型** 设置为 **制片分支/工作室（Production Branch / Studio）**，找到推荐的驱动程序。 |
| 显卡 | 如果你计划使用实时绿幕合成，则需要SDI视频卡来处理摄像机输入、合成输出和时间码同步。推荐你使用[AJA Kona 5](https://www.aja.com/products/kona-5)和[BlackMagic DeckLink](https://www.blackmagicdesign.com/products/decklink/techspecs/W-DLK-25)]等SDI视频卡来进行实时合成。 |
| 存储 | 由于你的项目数据会本地化到每台计算机上，因此你需要实现高速的本地存储才能获得最佳性能。建议你使用[M.2固态硬盘](https://en.wikipedia.org/wiki/M.2)(SSD)，例如[三星970 Pro](https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/970pro/)，作为电脑引导盘之外的第二块数据驱动盘。 |
| 存储网卡（Storage Network Card） | 建议使用10千兆的以太网（GbE）网络接口控制器（NIC），以此保证操作系统和渲染计算机之间的高速数据传输。 |

### 其他推荐硬件

| 列 1 | 列 2 |
| --- | --- |
| 网络交换机 | 大多数10 GbE Layer 2或Layer 3类型的网络交换机，例如[Netkit智能交换机](https://www.netgear.com/business/products/switches/smart/XS716T.aspx#tab-techspecs)，都应足以满足此方案。 |
| 同步信号发生器 | 同步信号发生器有有线和无线两种方案，很多情况下，镜头内视效片场会同时使用两者。例如，你可以让有线信号盒向无线信号盒发送信号。在上文的硬件图表中，橙色线表示同步发生器和摄像机之间的无线连接。 下面列出了推荐使用的同步信号发生器： 有线方案： [Blackmagic Design Mini Converter 同步信号发生器](https://www.blackmagicdesign.com/products/miniconverters/techspecs/W-CONM-15) [AJA GEN10 HD/SD/AES 同步信号发生器](https://www.aja.com/products/gen10) [ESE HD-488E/SD HD/SD-SDI Timecode Reader/Generator/Inserter](https://www.bhphotovideo.com/c/product/1201898-REG/ese_hd_488e_sd_hd_sd_sdi_time.html) [Evertz 5601MSC Master Sync and Clock Generator](https://evertz.com/products/5601MSC) [Courtyard CY460 Master Synce Generator](http://www.courtyard.co.uk/cy460-master-spg-test-pattern-time-reference-generator/) 无线方案： [Ambient Master Lockit for Master Sync](https://ambient.de/en/product/master-lockit/) [Ambient Lockit for Remote Sync](https://ambient.de/en/product/lockit/) |
| 显示适配器 | 了解适合NVIDIA GeForce和Quadro显卡使用的NVIDIA[标准显示适配器列表](https://nvidia.custhelp.com/app/answers/detail/a_id/4449/~/nvidia-recommended-display-adapters)。 如需了解如何将Display Port 1.4连到LED处理器的HDMI 2.0，请参阅[Club-3D CAC 1080](https://www.club-3d.com/detail/2442/displayportt_1.4_to_hdmit_2.0b_hdr_active_adapter)。 了解在LED处理器上将Display Port 1.2转接到HDMI 2.0的信息，请参阅[Lightware MX2系列](https://lightware.com/products/matrices-switchers)。 对于长度更长、未经压缩的HDMI连接，比如将显卡连接到显示端口，请使用光纤扩展器。如果是未压缩的HDMI2.0 4K信号，建议使用[Lightware光纤扩展器](https://lightware.com/hdmi20-opt)。 |
| 视频分配放大器（VDA） | 对于镜头内视效布局，VDA通常用于将同步锁定信号分发到渲染节点、摄影机跟踪系统、实时合成设备（有时还包括摄像机本身）的多个通道中。在上图中，你可以看到来自同步锁定的线路通过分配放大器分配到设置中的各种其他设备上。 以下是推荐的VDA： [Shinybow Composite DAs](https://www.shinybowusa.com/shop/index.php?cPath=37_45) [Kramer](https://www.kramerav.com/us/products/distribution_amplifiers/sdi-distribution-amplifiers) [VAC](https://vac-brick.com/product-category/video-distribution-amplifier/) |

---
title: "硬件和软件规格"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-specifications-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "硬件和软件规格"]
---

# 硬件和软件规格

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 硬件和软件规格

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-specifications-for-unreal-engine

操作系统

Windows

从下拉菜单中选择一个选项以查看与之相关的内容

本页介绍虚幻引擎（UE5）的硬件和软件要求。

## 推荐硬件

|  |  |
| --- | --- |
| **操作系统** | Windows 10 64位版本1909版本.1350及以上版本，或版本2004和20H2修订版.789及以上版本。Windows 11与UE5兼容，且符合推荐规格要求。 |
| **处理器** | Intel或AMD四核处理器，2.5 GHz或更快 |
| **内存** | 32 GB内存 |
| **显存** | 8 GB或更高 |
| **显卡** | 配备最新驱动程序的DirectX11或12兼容显卡。 |

> [!TIP]
> 虽然某些功能的最低要求是DirectX 11，但我们建议大多数游戏使用DirectX 12。
>
> DirectX11更适合旧电脑，尤其是集成显卡的笔记本电脑。 DirectX12 提供了更高的帧率、多核处理支持以及并行和异步计算。

> [!NOTE]
> 要充分利用虚幻引擎5的渲染功能（如Nanite和Lumen），请参阅本页的"UE5渲染功能要求"小节。

## 最低软件要求

运行引擎或编辑器的最低要求如下。

| 运行引擎 |  |
| --- | --- |
| **操作系统** | Windows 10版本1703 (Creators Update) |
| **DirectX Runtime** | [DirectX End-User Runtimes（2010年6月）](https://www.microsoft.com/zh-cn/download/details.aspx?id=8109) |

程序员使用该引擎开发的要求如下。

| 使用引擎开发 |  |
| --- | --- |
| **'运行引擎'的所有要求项（自动安装）** |  |
| **Visual Studio版本** | Visual Studio 2022 |
| iOS应用程序开发 |  |
| **iTunes版本** | [iTunes 12或更高](http://www.apple.com/itunes) |

> [!TIP]
> 尽管推荐在Windows系统上使用Visual Studio进行开发，但虚幻引擎也支持VS Code和Rider编辑器。

## 必备条件软件安装程序

虚幻引擎自带安装程序，用于安装运行编辑器和引擎所需的一切内容，例如**Microsoft Visual C++ 2015-2022可再发行程序包**。

通过Epic Games启动器安装虚幻引擎时，启动器会自动安装这些必备条件。 但是，如果你从源代码编译虚幻引擎，或必须为计算机准备所有虚幻引擎必备条件以用于特定用途，那么你可能需要自行运行安装程序。 例如，设置全新计算机以充当[Swarm Agent](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/unreal-swarm-in-unreal-engine)。

你可以在虚幻引擎安装位置的`Engine/Extras/Redist/en-us`文件夹中找到安装程序。

> [!NOTE]
> 虚幻引擎5删除了对32位平台的支持。

如果你使用Perforce获取虚幻引擎源代码，你可以在Perforce仓库的`Engine/Extras/Redist/en-us`文件夹中找到二进制文件。

如需详细了解Visual Studio，请参阅 [设置Visual Studio](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-studio-development-environmen-6a24252b/index.md)。

## 显卡驱动程序

目前我们建议使用各显卡制造商推出的最新稳定版本：

- [点击这里下载NVIDIA驱动程序](http://www.nvidia.com/Download/index.aspx)
- [点击这里下载AMD驱动程序](http://support.amd.com/us/gpudownload/Pages/index.aspx)
- [点击这里下载Intel驱动程序](https://www.intel.com/content/www/us/en/products/docs/arc-discrete-graphics/software/drivers.html)

## 性能说明

以下系统规格代表Epic Games的一台典型设备（Lenovo P620 Content Creation Workstation标准版）。 它能够为使用UE5开发游戏的人员提供较合理的指导。

- 操作系统：Windows 11
- 电源：1400W电源
- 内存：256 GB DDR5-4800MHz（RDIMM，ECC）
- 处理器：AMD Ryzen™ Threadripper™ PRO 7985WX处理器（3.20 GHz至5.10 GHz）
- 操作系统硬盘：2 TB SSD M.2 2280 PCIe Gen4 Performance TLC Opal
- 数据硬盘：4 TB SSD M.2 2280 PCIe Gen4 Performance TLC Opal
- 显卡：NVIDIA RTX™ 4080 16GB GDDR6
- 网卡：AMD RZ616
- TPM兼容

> [!NOTE]
> 如果无法获取Xoreax Incredibuild（开发工具包），建议使用具有12到16个核心的计算机进行编译。

## UE5渲染功能要求

虚幻引擎某些渲染功能的系统要求和最低要求有所不同。

| UE5功能 | 系统要求 |
| --- | --- |
| **Lumen全局光照、Lumen反射和MegaLights** | Windows 10构建1909.1350以及支持DirectX 12的更高版本。项目设置中必须启用**SM6**。以下显卡之一：AMD RX-6000系列或更高版本。Intel® Arc™ A系列显卡或更高版本。NVIDIA RTX-2000系列或更高版本。Lumen硬件光线追踪现在需要在项目设置中设置SM6。如需了解详情，请参阅[Lumen技术细节](../../../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/lumen-technical-details/index.md)。 |
| **Nanite虚拟几何体和虚拟阴影贴图** | 支持Windows 10构建1909.1350及更高版本的所有版本，以及支持[DirectX 12 Agility SDK](https://devblogs.microsoft.com/directx/gettingstarted-dx12agility)的Windows 11。Windows 10版本2004和20H2 — 修订版号应大于或等于.789。DirectX 12（带着色器模型6.6 Atomics），或Vulkan（VK_KHR_shader_atomic_int64）。 项目设置中必须启用**SM6**。 （在新项目中默认开启。） Windows 10版本1909 — 修订版号应大于或等于.1350。最新显卡驱动程序。如需了解详情，请参阅[Nanite虚拟几何体](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/nanite/nanite-virtualized-geometry/index.md)和[虚拟阴影贴图](../../../building-virtual-worlds/lighting-the-environment/shadowing/virtual-shadow-maps/index.md)。 |
| **时间超级分辨率** | 可在任何支持Shader Model 5的显卡上运行，但每个着色器8UAV的数量限制会影响性能。 时间超分辨率着色器在支持Shader Model 6的D3D12上编译时启用了16位类型。如需了解详情，请参阅[时间超级分辨率](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/anti-aliasing-and-upscaling/temporal-super-resolution/index.md)。 |

---
title: "设置SMPTE 2110"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-smpte-2110-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "将SMPTE 2110用于nDisplay", "设置SMPTE 2110"]
---

# 设置SMPTE 2110

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / 将SMPTE 2110用于nDisplay / 设置SMPTE 2110

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-smpte-2110-in-unreal-engine

### 在虚幻引擎中设置SMPTE 2110

本页包含使用NVIDIA Rivermax在虚幻引擎中设置和部署SMPTE 2110所需的全部信息。 本指南适用于需要高带宽SMPTE 2110功能的用户，包括广播和电影行业。

## 先决条件

以下是使用NVidia Rivermax集成SMPTE 2110所需的硬件和许可要求：

### 硬件

Rivermax是由NVIDIA开发的SDK，可与Mellanox Connect-X 网卡配合使用。

> [!WARNING]
> 虽然存在其他2110解决方案，但虚幻引擎5.4的SMPTE 2110功能（截至本文发布时）明确要求使用NVIDIA Rivermax。

#### 支持的网卡

驱动LED墙需要Bluefield来保证PTP（精确时间协议）精度。 下表介绍了虚幻引擎当前支持的网卡（NIC）：

| 网卡（NIC） | 信息 |
| --- | --- |
| Connect-X 6 BlueField-2 | 我们推荐这一系列受支持的NIC，因其在Windows系统上具备PTP（精确时间协议）精度。 如果要驱动LED墙，则需要PTP。 |
| Connect-X 6 | 该系列NIC虽受支持，但存在局限性，因其在Windows系统中不具备PTP（精确时间协议）精度。 |
| Connect-X 5 | 该系列NIC虽受Rivermax SDK支持，但我们不建议在新安装中采用。 |

如需详细了解，请访问[NVIDIA网站](https://developer.nvidia.com/networking/rivermax-getting-started)（需要拥有NVIDIA账户才能访问该网站）。

GPUDirect功能仅限于4000系列及以上的专业GPU，且需要采用[安培（Ampere）架构](https://www.nvidia.com/zh-cn/data-center/ampere-architecture/)或未来架构世代（例如RTX 6000 Ada、RTX 5000 Ada、RTX 4500 Ada或RTX 4000 Ada）。 如需获取支持GPUDirect的GPU完整列表，请访问[NVIDIA网站](https://developer.nvidia.com/gpudirectforvideo)。

此外，你需要一块支持可调整大小栏选项的主板，这可能需要更新BIOS固件。

### 软件

要在虚幻引擎中使用Rivermax，建议你遵循[NVIDIA Rivermax网站](https://developer.nvidia.com/networking/rivermax)上的部署指南《Windows DPU部署指南》（2.51版）。

> [!WARNING]
> 自2025年8月起，Bluefield-2卡将逐步被淘汰，并且很快就会达到使用寿命的极限。
>
> Bluefield 3卡可与Rivermax 1.41.11和1.60.6版本配合使用（从虚幻引擎5.5和5.6开始）。 但是，它们需要不同版本的DPU部署脚本，并且新固件会使用 Bluefield Bootstream (BFB) 文件与DPU脚本一起自动安装。

#### Bluefield 2

| 虚幻引擎版本 | Rivermax SDK版本 | WinOF-2版本 | DPU版本 | 固件版本 |
| --- | --- | --- | --- | --- |
| 5.3 | 1.20.10 | 3.10.52010 | 2.21 | 24.35.1012 |
| 5.4 | 1.41.11 | 24.1.50000 | 2.51 | 24.40.1000 |
| 5.5 | 1.41.11 | 24.1.50000 | 2.51 | 24.40.1000 |
| 5.6 | 1.60.6 | 24.10.50010 | 2.51 | 24.43.1014 |

#### Bluefield 3

| 虚幻引擎版本 | Rivermax SDK版本 | WinOF-2版本 | DPU脚本版本 |
| --- | --- | --- | --- |
| 5.5 | 1.41.11 | 25.4.50020 | 3.0.0 |
| 5.6 | 1.60.6 | 25.4.50020 | 3.0.0 |

#### Rivermax SDK安装路径

Rivermax SDK的默认安装路径为"C:\Program Files\Mellanox\Rivermax\lib"。

在虚幻引擎**5.4**及更高版本中，除使用默认路径外，你还可以使用环境变量`$RIVERMAX_PATH`指定Rivermax SDK的安装路径。

从虚幻引擎**5.6**开始，必须为所使用的Rivermax SDK版本指定显式路径。

| 虚幻引擎版本 | 支持的Rivermax版本 | 环境变量 |
| --- | --- | --- |
| 虚幻引擎5.4 | 1.41.11 | RIVERMAX_PATH |
| 虚幻引擎5.5 | 1.41.11 | RIVERMAX_PATH |
| 虚幻引擎5.6。 | 1.60.6 | RIVERMAX_PATH_1_60_6 |

### 许可证

搭配使用NVIDIA Rivermax SDK和虚幻引擎时，需要许可证。 [请联系NVIDIA](https://developer.download.nvidia.com/networking/nvidia-rivermax-license-generation-procedure.pdf?t=eyJscyI6ImdzZW8iLCJsc2QiOiJodHRwczovL3d3dy5nb29nbGUuY29tLyJ9)获取许可证。

默认情况下，系统会在Rivermax DLL所在目录中查找许可证。 你可以使用环境变量`$RIVERMAX_LICENSE_PATH`指定其他位置来查找许可证（如网络驱动器）。

## 部署步骤

设置Rivermax部署时，请参阅随DPU提供的NVIDIA官方文档以及Rivermax SDK文档。

### 可选：GPUDirect设置

配置GPUDirect时，请确保GPU和DPU（Mellanox网卡）位于同一个根复合体上。 如果两者不在同一个根复合体上，SMPTE 2110数据包可能会丢失，尤其是在处理多输入流时。

1. 在BIOS中启用可调整大小栏选项。
2. 为实现最佳性能，应将网卡与GPU置于同一个根复合体上。
3. 验证BAR1可用内存。

   - 使用*Nvidia控制面板（Nvidia Control Panel）- 系统（System）*信息验证是否已启用该功能。
4. 创建将CUDA和Rivermax结合使用的新环境变量。

   - `RIVERMAX_ENABLE_CUDA`
   - 将其值设置为1。
5. 在初始化过程中，如果系统检测到兼容的GPUDirect设备，将初始化支持该功能的库。 如果未检测到，则回退至系统内存路径。

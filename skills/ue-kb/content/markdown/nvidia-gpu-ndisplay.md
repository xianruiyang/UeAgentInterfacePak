# 基于NVIDIA GPU的nDisplay同步方案

---
title: "基于NVIDIA GPU的nDisplay同步方案"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-synchronization-with-nvidia-gpus-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay中的同步机制", "基于NVIDIA GPU的nDisplay同步方案"]
---

# 基于NVIDIA GPU的nDisplay同步方案

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay中的同步机制 / 基于NVIDIA GPU的nDisplay同步方案

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-synchronization-with-nvidia-gpus-in-unreal-engine

为了避免LED屏幕之间出现画面撕裂现象，同时避免摄像机在各个LED屏幕上拍到不一致的内容，你必须确保nDisplay群集节点（即电脑）实现同步。本文将介绍如何基于NVIDIA GPU实现nDisplay的同步功能。有关在nDisplay同步的更多详情，请参阅[nDisplay中的同步](../index.md)。

目前，要实现nDisplay节点之间的正确同步，可能还需要你进行一些调试工作。我们建议你在开始虚拟制片前，先花时间准备nDisplay节点的同步工作。

## 先决条件

你必须拥有以下设置，才能完成后续步骤。

- 每个nDisplay节点需要有一块NVIDIA Quadro Sync II显卡提供支持。
- （仅针对mGPU设置）NVIDIA SLI或[NVLINK](https://www.nvidia.com/en-gb/design-visualization/nvlink-bridges/)。
- [兼容的Quadro GPU](https://www.nvidia.com/en-gb/design-visualization/solutions/quadro-sync/)。每个nDisplay节点采用的显卡设备必须拥有相同的规格。
- Cat-5或Cat-6 RJ45线缆。
- 三电平或双电平同步发生器。
- BNC电缆。
- 每个nDisplay节点必须采用相同规格的Windows电脑。
- 如果你的Quadro显卡只有DisplayPort输出端口，而LED处理器只有HDMI输入端，那么你必须转换信号。转换信号的一种方法是使用[适配器](https://nvidia.custhelp.com/app/answers/detail/a_id/4449/~/nvidia-recommended-display-adapters)。

请参阅[摄像机内视觉特效处理推荐硬件](../../../icvfx/recommended-hardware-for-in-camera-vfx/index.md)，获取有关硬件的建议。

## 步骤1 - NVIDIA驱动程序

安装最新版NVIDIA驱动程序，即版本R512.59或更高版本。

你可以在[NVIDIA的下载驱动程序页面](https://www.nvidia.com/Download/index.aspx)上找到推荐的虚拟制片驱动程序。选择你的卡类型和操作系统，并将 **下载类型（Download Type）** 设置为 **制作分支/工作室（Production Branch/Studio）** ，找到推荐的驱动程序。

## 步骤2 - 机器配置

使用[菊花链连接](../index.md#%E6%98%BE%E7%A4%BA%E5%90%8C%E6%AD%A5%E6%8F%AD%E7%A7%98)配置系统，确保使用 **同步锁定（genlock）** 和 **帧锁定（framelock）**：

- 外部同步源通过BNC电缆进入主同步卡，用于同步锁定
- RJ45电缆以菊花链形式连接其余nDisplay节点中的其余同步卡，实现帧锁定。
- 配置NVIDIA控制面板以进行同步。具体来说，确保将 **垂直同步**（vsync）全局设置设置为 **使用3D应用程序设置（Use the 3D application setting）** 。有关这些步骤的更多细节，请参阅NVIDIA的[Quadro Sync II用户指南](https://images.nvidia.com/content/quadro/product-literature/user-guides/Quadro-Sync-II-User-Guide.pdf)

配置完成后，除非机器崩溃或锁定到Windows登录界面，否则NVIDIA同步应保持原位。我们建议使用NVIDIA控制面板设置来监控Quadro Sync II显卡上的同步LED指示灯，以便确保在整个制片过程中保持同步。

以这样的方式连接此设置的电缆，以便你可以轻松地以NVIDIA同步菊花链的相反顺序重新启动nDisplay节点。有关这些步骤的更多细节，请参阅NVIDIA的[Quadro Sync II用户指南](https://images.nvidia.com/content/quadro/product-literature/user-guides/Quadro-Sync-II-User-Guide.pdf)。

## 步骤3 - NVIDIA Mosaic

nDisplay应该只输出到主显示器，如果需要多个视频输出，请使用NVIDIA Mosaic将它们配置为一个大型桌面。

每台显示器都必须连尚并共享相同的分辨率、刷新率和颜色管理：

1. 打开[NVIDIA控制面板](https://www.microsoft.com/p/nvidia-control-panel/9nf8h0h7wmlt)。
2. 找到 **管理3D设置（Manage 3D settings）**：

   1. 将 **全局预设（Global Presets）** 设置为 **工作站应用程序 - 动态流送（Workstation App - Dynamic Streaming）** 。
   2. 在 **设置（Settings）** 下，将 **电源管理模式（Power management mode）** 设置为 **首选最高性能（Prefer maximum performance）** 。
3. （仅使用SLI的mGPU）找到 **SLI和PhysX配置（SLI and PhysX Configuration）**，然后选择 **最大化3D性能（Maximize 3D performance）** 。
4. 找到 **查看系统拓扑（View system topology）** ，然后点击 **EDID** ，以便在使用的任意输出端口上导出并加载EDID，从而确保显示信息锁定并且不会再次查询。

你也可以通过矩阵或切换器等外部硬件设备管理EDID。有关EDID及其含义的更多信息，请参阅[EDID分段](#%E6%AD%A5%E9%AA%A46-edid)。

1. 找到 **设置Mosaic（Set up Mosaic）** ，并选择 **创建新配置（Create new Configuration）** ，打开 **NVIDIA Mosaic设置（NVIDIA Mosaic set up）** 窗口。
2. 在NVIDIA Mosaic设置窗口的 **选择拓扑（Select topology）** 选项卡上，选择 **最大GPU拓扑（Maximum GPU Topology）** 。
3. 在 **选择显示器（Select displays）** 选项卡上，匹配你拥有的每个显示器的分辨率，并设置Mosaic的整体刷新率。
4. 在 **排列显示器（Arrange Displays）** 选项卡上，将显示器的位置与你有的位置匹配，然后点击 **应用（Apply）** 。

有关这些步骤的更多细节，请参阅[NVIDIA Mosaic技术用户指南](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/quadro-product-literature/NVMosaic-UG.pdf)。

## 步骤4 - NVIDIA驱动程序实用工具

下载NVIDIA的[配置驱动程序实用工具](https://www.nvidia.com/en-us/drivers/driver-utility/)，并通过Windows命令提示符以管理员身份运行该应用程序，以便在NVIDIA驱动程序上设置专用配置。

启动可执行文件后，输入 **11** 并在键盘上按 **Enter**，以便启用 **prePresentWait** 设置，并在不影响同步的情况下提高性能。

通过启用选项8 **为Direct x启用SwapGroupPresentIndicator（Enable the SwapGroupPresentIndicator for Direct x）** ，你可以验证它是否在正确的模式下运行。这将启用左下方区域的HUD，当使用NVIDIA同步策略运行nDisplay时，该HUD将显示prePresentWait已启用，以及交换组是否已加入且未挂起。

## 配置5 - 为NVIDIA同步配置的nDisplay

为了让nDisplay锁定NVIDIA sync的同步，它必须作为全屏前台窗口应用运行（如果分辨率与桌面完全匹配，窗口也应该运行），因为演示模式需要独立翻转。这意味着在nDisplay实例运行时，其他应用程序窗口不能位于其前面。

请按照以下步骤为NVIDIA同步设置nDisplay节点：

1. 在 **nDisplay配置编辑器（nDisplay Config Editor）** 中，打开你的 **nDisplay配置资产（nDisplay Configuration Asset）** 。
2. 在 **群集（Cluster）** 面板中，选择 **群集（Cluster）**，打开其 **细节（Details）** 面板。
3. 在细节（Details）面板的 **渲染同步策略（Render Sync Policy）** 下，将 **类型（Type）** 设置为 **Nvidia (2)** 。

   ![渲染同步策略类型设置为NVIDIA(2)](../../../../../../assets/images/6c/6c2a57cc3dd40045a602368885cd8e6d4c1fe3ebf89627843407f3e579f41a38.png)
4. 对于集群中的每个节点，启用 **全屏（Fullscreen）** 或将 **窗口（Window）** 尺寸设置为完整的桌面分辨率。有关如何设置尺寸的信息，请参阅[窗口分辨率示例](#%E7%AA%97%E5%8F%A3%E5%88%86%E8%BE%A8%E7%8E%87%E7%A4%BA%E4%BE%8B)。
5. 如果NVIDIA控制面板（NVIDIA Control Panel）已打开，请关闭它。
6. 关闭所有虚拟桌面。TeamViewer和Zoom等应用程序将使用这些虚拟桌面。
7. 禁用桌面通知和弹出窗口，例如来自Epic Games启动程序的桌面通知。
8. 将Windows桌面分辨率缩放设置为100%。
9. 使用[Switchboard](../../../../communicating-with-media-components-from/switchboard/index.md)中的 **修复ExeFlags（Fix ExeFlags）** 在每个节点上禁用虚幻引擎的全屏优化。右键点击 **虚幻引擎可执行文件（Unreal Engine executable）>属性（Properties）>兼容性（Compatibility）>禁用全屏优化（Disable Fullscreen Optimizations）** 也可以执行此操作。
10. 如果在与Switchboard相同的PC上启动nDisplay，请在Switchboard设置的nDisplay分段中启用 **启动前最小化（Minimize Before Launch）** 。

### 窗口分辨率示例

节点的窗口应该覆盖整个桌面分辨率，但 **视口** 只需覆盖LED所需的分辨率。此示例展示了如何设置节点的窗口分辨率和视口分辨率。

LED墙的方形2k分段正在从超高清桌面分辨率渲染，未使用的空间将保持黑色：

- 窗口分辨率设置为3840 x 2160
- 视口分辨率设置为2048 x 2048

在nDisplay配置编辑器中，这将设置为：

- 节点的 **窗口（Window）** 参数：**X** 是0像素，**Y** 是0像素，**W** 是3840像素，**H** 是2160像素。
- 视口的 **区域（Region）** 参数：**X** 为0像素，**Y** 为0像素，**W** 为2048像素，**H** 为2048像素。

![窗口参数设置为宽度3840像素和高度2160像素](../../../../../../assets/images/a9/a9cd2f167722aa13c8f9df0d13302075e0341e7e3771c5a4b9d87cba347e13cc.png)

![区域参数设置为宽度2048像素和高度2048像素](../../../../../../assets/images/23/23f6bc20d3773151ae67752b9d5e00b39212d209c2f49657c052144702eac57b.png)

## 步骤6 - EDID

延伸显示能力识别数据（EDID）是由[视频电子标准协会](https://www.vesa.org/)（VESA）定义的显示设备标准格式。EDID包含有关视频源显示设备的元数据。

你在NVIDIA控制面板中完成所有设置后，导出当前EDID然后从文件中加载它会很有用，可以确保显示信息锁定并且在显示信号丢失时不会再次查询。你也可以通过矩阵或切换器等外部硬件设备管理EDID。有关这些步骤的更多细节，请参阅[管理窗口的Display EDID](https://nvidia.custhelp.com/app/answers/detail/a_id/3569/~/managing-a-display-edid-on-windows)。

使用渲染同步策略2时，错误配置的EDID会使nDisplay的性能减半。为避免这种情况，你有两种选择：

- 确保你有EDID，它允许以你希望拍摄的频率选择PC分辨率，并标记为 **（原生）** 。
- 根据标准3840 x 2160 60hz PC分辨率创建自定义分辨率，然后将其设置为适当的频率。

![NVIDIA控制面板更改分辨率](../../../../../../assets/images/2a/2aae35901bdc90ba3875cf6f0b58648adac6034d92d4cb87b34565c03e0ae688.jpg)

## 步骤7 - 验证同步和故障排除

有关如何验证你是否在nDisplay中获得成功同步的信息，请参阅[同步测试](../index.md#%E5%90%8C%E6%AD%A5%E6%B5%8B%E8%AF%95)。

注意Switchboard，因为它显示了nDisplay节点的NVIDIA驱动程序和同步状态。为了成功同步，Switchboard中的 **PresentMode** 列应该指示每个节点都处于 **硬件组成：独立翻转（Hardware Composed: Independent Flip）** 中。如果某个节点报告 **组成：翻转（Composed: Flip）**，则检查该节点上的nDisplay前面是否没有任何内容（包括Windows任务栏或Switchboard监听器）。

如果你仍然无法成功同步，则你可能需要交换nDisplay集群节点中的GPU和Quadro Sync卡，或者考虑是否存在硬件故障。


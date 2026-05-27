---
title: "nDisplay中的同步机制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/synchronization-in-ndisplay-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay中的同步机制"]
---

# nDisplay中的同步机制

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay中的同步机制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/synchronization-in-ndisplay-in-unreal-engine

每当需要在大型显示器上同时显示实时内容的多个区域时，*同步* 就显得至关重要。渲染/显示生态系统中的所有系统都必须严格计算时间（以秒为单位），以便给人无缝显示的错觉。

多显示设置通常要求在软件和硬件层面实现同步功能。使用相同的模拟时间信息，不仅生成内容要在所有PC上同时准备就绪，而且还需要在正确的时间进行显示内容的交换（将当前图像换成显卡缓冲区中的下一张图像），以免显示中出现类似撕裂的瑕疵效果。

对于VR和其他类型的双屏显示器，由于存在两幅画面（每只眼睛对应一副画面）并且二者必须完美协调，因此同步问题会成倍增加。

## 确定性

有两种管理同步的方法：

- 确定性：

  设置每个服务器（PC、渲染节点）的方式为：在给定特定输入集的情况下，输出始终可预测，这意味着服务器与系统中其他机器同步仅需准确的时间和每台独立机器的输入/输出信息。
- 非确定性：

  为了确保同步，系统强制复制场景中所有actor或对象的变换矩阵和其他相关特征，并在整个系统中复制它们。

两种方法各有优缺点。确定性系统的主要优势在于项目的简单性，并且不会对每个对象进行每帧的变换数据共享，从而节省数据带宽。缺点在于，如果一个系统出现偏离，随着时间的推移，这种偏离将产生未知问题。渲染均匀性可能会受到严重影响，从而导致视觉效果不连续和出现瑕疵。

## 硬件同步和同步锁定（Genlock）

尽管 *nDisplay主PC* 会确保从游戏进程的角度（例如，渲染哪个帧），将时间信息告知所有 *群集（节点）PC*，但仍需要专用的硬件同步卡和兼容的专业显卡，以便在物理显示设备上以完全相同的时间同步渲染帧的显示。

例如，在广播应用中，通常要同步许多设备，例如摄像机、监视器和其他显示器，以便它们都可以在同一时间精准地切换和采集下一帧。在这个行业中，*发生器锁定信号（genlock）* 被广泛采用。

通常，设置涉及硬件发生器（硬件发生器将时钟发送到需要同步的硬件）。至于用于实时渲染的PC，专业显卡（例如NVIDIA Quadro系列显卡）与NVIDIA Quadro Sync Ii卡都支持该技术，它们能锁定接收到的时间信号或脉冲。

![undefined](../../../../../assets/images/a6/a6bbac4e2bfb316ae4a1d9c84acca3c209872618bd9fa15f37c590650e04883c.jpg)

系统拓扑

![undefined](../../../../../assets/images/69/690c4bca016c10ad682dc5eb5fedef3f36b4c717e959c88f520b15537de3063b.jpg)

主节点（内部时钟发生器）

![undefined](../../../../../assets/images/0a/0a063b5ccccba3f576436d35b300155bac6904819fa29f1a518ac1c9fa4b88bf.jpg)

群集节点（从主节点GPU接收时钟）

> [!TIP]
> 在使用Quadro Sync时：
>
> - 优先使用"生产分支/工作室"类型的驱动程序，因为它们往往比"新功能分支"类型的驱动程序更稳定。
> - 利用"下降沿"触发同步脉冲，因为它们在检测正确信号速率方面往往比"上升沿"更可靠。

## 显示同步详解

- **仅帧锁（Framelock only）：** 该方法在多个GPU之间使用菊花链技术，通常被NVIDIA称为 *帧锁定/交换同步（FrameLock/SwapSync）*。此处没有使用Genlock。主nDisplay PC上的GPU会从输出显示或与之连接的处理器获得主时钟，然后传递给作为渲染节点的PC的GPU。所有PC都在树形拓扑结构内相互连接，其中主PC是根节点。该方法允许借助NVIDIA API使用NVIDIA交换组/屏障。

  这种方法不适合虚拟制片，因为它与空间内的其他使用设备相互独立工作，所有设备都与外部主时钟同步。
- **仅Genlock：** 采用这种方案时，所有群集PC都从相同的来源获取它们自己的主时钟信号（genlock）。换句话说，所有PC都有自己的BNC连线，并且所有连线都连接到同一台主时钟生成器。

  此方法允许VSync同步；不过，NVIDIA屏障将无法通过NVIDIA API获得。技术上说，所有集群PC都与接受的时钟保持帧锁定。然后这种方法还未被证明拥有100%的可靠性，因为还无法在应用层面上对帧的呈现实现精确控制。

  > [!NOTE]
  > 此方法是我们之前用的方法，也是为何我们必须实现一种"高级"同步策略，从而降低出现无法同步/卡顿的几率。
- **Genlock + 帧锁定：此方法最适合虚拟制片。** 所有舞台设备都连接到一台主时钟，包括主nDisplay PC的GPU。群集内的同步，是通过主PC和渲染节点PC之间的菊花链连接实现的。

  此方法允许使用NVIDIA API，因此可以利用NVIDIA屏障，从而使UE能够在应用层面上控制帧的呈现。这种是最可靠的同步显示方法，同时还提供了外部时钟(Genlock)。

## 菊花链和直接Genlock

*菊花链* 是直接Genlock以外的另一种信号锁定技术，该技术将主时钟发送到单个PC或设备（此处为主PC）。然后使用单独的电缆将信号传播到所有其他硬件。尽管以前使用nDisplay的经验表明，直接Genlock（每台PC直接从主源接收时钟）比菊花链更简单、更有效，但是基于菊花链的新硬件方法为实现更可靠、更具成本效益的信号锁定解决方案带来了希望。此解决方案被称为 *NVIDIA交换同步/锁定*。

## NVIDIA Mosaic和AMD EyeFinity

NVIDIA的 *Mosaic模式* 和AMD的 *EyeFinity* 是类似的GPU技术，它们在一个显卡中组合并同步多个输出，因此从操作系统或软件角度来看，是一种独特的显示手段。该虚拟显示本质上是多个物理显示器的聚合，这些物理显示器充当一个同步显示器，也可以使用基础的帧锁或Genlock技术与来自不同系统的其他显示器同步。

使用内部时钟锁定多个显示器的过程称为 *帧锁定*。*Genlock* 是指使用外部时钟替而代之的情况。在Genlock的情况下，外部时钟用于所有设备，包括显示设备、摄像机和跟踪传感器。

假设GPU用的是Quadro Sync II或Firepro S400显卡的GPU，并且连接正确，Mosaic和EyeFinity技术都允许单个显卡的多个输出具有完全相同的时钟，并且从操作系统角度来看，它们被视为一个大型显示画布。你可以在每台PC上创建一个或多个Mosaic或Eyefinity组，但不能跨PC创建——每台PC必须有自己的Mosaic或Eyefinity组。

如果要用菊花链技术同步由多PC或GPU驱动的显示器，必须要有一个GPU充当主时钟发生器，并使用Nvidia Quadro Sync II或AMD Firepro S400等同步卡将其时钟共享给同其他GPU（同一台PC上或不同PC上的GPU）。

有关更多信息，请参阅[适用于多个显示器的Mosaic技术|NVIDIA](https://www.nvidia.com/en-gb/design-visualization/solutions/nvidia-mosaic-technology/)和[多显示器Eyefinity技术](https://www.amd.com/en/technologies/eyefinity)。

> [!NOTE]
> Although it is possible to have a MOSAIC virtual display spawn across multiple GPUs within one PC, currently, it would be slow to have an application window over that canvas. (Future work may possibly enable this.) Today, this approach would not be recommended for virtual production or in-camera VFX.

## 显示同步的其他方面

游戏线程和渲染线程始终通过所谓的"线程屏障"同步。"线程屏障"是以下两项内容的核心功能。屏障无法禁用。你可以将它们看作时间刻度上的许多点，有助于主节点同步处理从节点，从而在多台装有虚幻引擎的PC上提供统一的内容体验。

| 功能 | 描述 |
| --- | --- |
| **软件/模拟（你应看到的内容）** | 同步所有软件相关事务的过程。其涉及使虚幻引擎及其内容正确同步：功能确定性、增量时间同步、输入复制、自定义变换、线程屏障、群集事件、游戏逻辑等。 |
| **硬件/操作系统（查看内容的方式）** | 使用一个共享时钟（内部同步或Genlock信号）同步硬件设备（例如GPU、显示设备和 *DWM* （桌面窗口管理器））的过程。其涉及如何让一个操作系统和硬件同步显示你想要的内容，而不出现撕裂。这需要NVIDIA Quadro显卡、Sync Ii卡以及Genlock发生器。如果未启用，则至少会出现一帧硬件延迟。 |

## 同步策略

渲染同步策略将定义如何同步渲染输出。此参数可以在[nDisplay 3D配置编辑器](../ndisplay-3d-config-editor/index.md)的群集细节面板中进行设置。

下表介绍了 **渲染同步策略（Render Sync Policy）** 的可用选项。

| 选项 | 说明 |
| --- | --- |
| 无（None，Sync Policy 0） | 这表示VSync=0。在RenderThreadBarrier不与VBlank同步之后，所有节点显示其帧。这样可以获得最大的FPS，但可能出现类似撕裂效果的瑕疵。 |
| 以太网（Ethernet，Sync Policy 1） | 在RenderThreadBarrier与VBlank同步之后，所有节点均显示其帧画面。输出显示器不会出现撕裂。请注意，显示画面仍可能因为DWM和运行时或驱动程序设置的原因出现撕裂。 |
| NVIDIA （Sync Policy 2） | 基于菊花链连接的NVIDIA硬件帧锁（NVIDIA SwapLock API）。你可以使用NVIDIA部分中的参数来调整与帧锁有关的一些特定硬件设置。 同步组：用于帧锁的同步组。默认值为1。 同步屏障：用于帧锁的同步屏障。默认值为1。 |
| 自定义 | 配置nDisplay中还不存在的任何自定义同步策略。需要提供策略ID和任意数量的键值参数。 |

之前，我们针对特定情况开发了一种被称为 *高级同步* 的同步机制，其中给定nDisplay PC上的帧渲染会在VBlank之后进行，并在屏幕上造成撕裂效果。这种软件机制试图预测这些事件，强制所有PC跳过并在下一个VBlank上渲染。此机制并非100%完美，并在启用后可能产生不好的性能影响。

最近，我们为同步（Sync Policy 2）实现了Nvidia API，这是一种硬件支持型问题解决方案。

时间服务器上的帧锁连接：1) 时间服务器 2) 客户端。

1) 同步源 2) 服务器 3) 客户端

## 让同步开始工作

为了在虚拟制片环境下实现可靠的同步，你必须使用一种结合Genlock和Framelock的技术。简而言之，你把同步信号输入到主控的nDisplay PC上，然后使用菊花链硬件方案把传入的同步信号分配给所有其余的集群PC，这样它们就被正确地帧锁定（framelock）。这意味着需要在配置文件中正确定义一个NVIDIA渲染同步策略。

### 工作流程

1. 使用带有常规RJ45连接器的常规以太网电缆在群集GPU同步板中设置菊花链连接。
2. 启用MOSAIC并通过NVIDIA控制面板配置同步（设置主节点，然后设置同步从节点）。
3. 使用以下步骤启用DirectX Swapgroup PrePresentWait：

   1. 下载

      nVidia配置驱动程序工具

      .
   2. 以管理员身份运行

      ConfigureDriver.exe

      。
   3. 输入"11"并按下

      回车键

      。
4. 在nDisplay3D配置编辑器中，将群集的

   渲染同步策略

   设置为

   NVIDIA

   。
5. 可选：

   对于复杂系统，可以在群集设置中自定义NVIDIA交换组和同步屏障。

默认情况下，使用同步组1和同步屏障1。

NVIDIA渲染同步策略（NVIDIA Render Sync Policy）的群集设置可在群集节点上启用NVIDIA交换组。

### 其他信息

不允许使用0。0值被内部用于分离/离开组/屏障。仅支持自然数。对于带有一个GPU和一个同步板的简单系统，你将获得单个同步组1号和单个同步屏障1号。此为默认使用值。

## 同步测试

测试缩放显示器的同步可能很麻烦，因为由许多问题都可能导致引起不同步，包括：

- 时间戳错误导致模拟了错误的帧（软件问题）。
- 显示设备时间关闭（显示或硬件问题）。

为了测试同步效果，我们使用了一个简单的测试项目，在该项目中，会有一个对象在整个显示表面上快速移动。假如系统能够正确同步，对象在穿越边界时就能维持原有的形状。否则，显示器的衔接处会显示画面撕裂瑕疵。

假如系统正确同步，对象从屏幕1移动到屏幕2时会保留原有形状。

## 其他信息的链接

- [NVIDIA QUADRO G-SYNC II](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/quadro-product-literature/Quadro_GSync_install_guide_v4.pdf)
- [第30章，配置帧锁和Genlock](https://download.nvidia.com/XFree86/Linux-x86_64/304.137/README/framelock.html)
- [QUADRO SYNC II](https://images.nvidia.com/content/quadro/product-literature/user-guides/Quadro-Sync-II-User-Guide.pdf)
- [NVIDIA推荐显示适配器](https://nvidia.custhelp.com/app/answers/detail/a_id/4449/~/nvidia-recommended-display-adapters)

---
title: "nDisplay概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-overview-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay概述"]
---

# nDisplay概述

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-overview-for-unreal-engine

在所有的nDisplay系统中，都有一台 *主* 计算机和数量不定的附加计算机（称为二级节点）。

- 网络中的每台计算机都会运行一个或多个虚幻项目实例（以 -game 或者打包格式运行）。
- 每个虚幻项目实例都对应一台或多台显示设备上的渲染画面。这里的显示设备包括：屏幕、LED屏幕，或投影仪。
- 这些显示设备的视口拥有同一个视点。通过让每块屏幕的渲染视角与屏幕的实际位置保持一定的对应关系，我们可以为观众营造仿佛身处虚拟世界中的错觉。
- 主节点会通过虚拟现实外围网络（VRPN，通过Live Link连接）来接受空间跟踪器和控制器的输入信号，并将这些输入信号复制给网络中的其他计算机。

![nDisplay network overview](../../../../../assets/images/35/3541daca413577e5c81c2b153518b75b29da873f642903586632cd844da4b5c9.png)

上图显示了一种可能的nDisplay网络结构。与所有nDisplay网络相同，其中的一台电脑充当主节点。此主节点会接受VRPN服务器的系统输入信号（VRPN服务器中继来自空间跟踪设备和其他控制器设备的信号）。网络中还包含一些其他电脑（二级节点，也会运行许虚幻项目）。每个二级节点都负责渲染一台或多台显示设备。

|  |  |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/f7a0f174-dd4b-4261-ab58-a13bfe5e0e22/ndisplay-oneinstance-onedevice.png) | **每台显示设备对应一台电脑和一个应用程序实例** 这是nDisplay中最常见的设置方法。每当你需要新增一台物理显示设备，你都需要新增一台电脑来为该设备渲染内容。在这台计算机上，你只运行一个虚幻引擎项目实例。这种情况下，这个项目实例通常只渲染一个视口（即一个3D场景画面）。 |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/7328bf6d-da1d-4084-8df9-ffe5b48a2804/ndisplay-oneinstance-multipledevices.png) | **一台电脑和一个项目实例对应多台显示设备。** 在这种方案下，每台电脑只运行一个项目实例，但需要将3D场景渲染成多个视口。借助输出映射工具，这些视口会被映射到一幅完整2D画幅的不同区域上——这个2D画幅又称为应用程序窗口。 我们推荐使用显卡厂商的多屏显示技术来实现屏幕的拼接效果——例如[NVIDIA Mosaic](https://www.nvidia.com/en-gb/design-visualization/solutions/nvidia-mosaic-technology/)或[AMD Eyefinity](https://www.amd.com/en/technologies/eyefinity)技术。这有助于虚幻引擎在屏幕上渲染内容时，整体上拥有更好的同步效果和性能表现。你可以使用nDisplay输出映射工具在整个画幅上映射你的所有视口。 为了提升性能表现，你还可以多添加一张显卡来渲染每个视口。当所有像素都复制完毕并且在GPU（面向显示器）上可用时，它们就会在应用程序窗口中合成，并被发送到GPU输出。关于使用多显卡的更多细节，请参考[多GPU支持](#%E5%A4%9Agpu%E6%94%AF%E6%8C%81)。 |

## nDisplay组件

nDisplay会在默认的虚幻系统架构中添加以下组件：

- 一个虚幻引擎内部插件，用于让网络中所有应用实例实现信息同步和沟通，确保所有实例同时渲染相同的帧画面，确保所有显示设备以正确视角渲染场景，等等。
- 一个共享配置资产，包含 nDisplay 需要的所有设置参数，以便在正确的计算机上启动正确数量的实例。确保每个实例都能在游戏 3D 场景中渲染正确的视点，从而在所有屏幕或投影设备上产生无缝的渲染效果。请参阅

  nDisplay 3D 配置编辑器

  了解更多信息。

## 工作流程

你需要告诉nDisplay你希望在网络中使用的不同计算机、这些计算机将渲染到的屏幕或投影器的大小和分辨率、这些屏幕在3D空间中的空间关系以及其他设置。为了实现这些操作，你可以创建一个配置资产，在一系列设置中表现所有这些信息。

通常情况下，在设置配置资产之后，只有在网络拓扑发生更改时才需要修改它：例如，当你需要更改要渲染到的计算机时，或者在真实世界中更改屏幕和显示器的物理安排时。

用于设置nDisplay群集的通用工作流：

1. 在虚幻编辑器中创建一个新的nDisplay配置资产。
2. 在nDisplay 3D配置编辑器中配置你的nDisplay配置资产:

   1. 组件：将你的显示器、摄像机和变换添加到根组件。
   2. 群集：创建你的群集PC配置的表示，分配视口和GPU ID。此操作基本上是添加PC和视口。
   3. 输出映射：将视口有效地映射到UE应用程序窗口。分配投影策略和绑定视口到显示、屏幕或网格体组件。
3. 将nDisplay配置资产拖到关卡视口中，以便从群集视角创建nDisplay根Actor并预览项目内容。
4. 使用

   Switchboard

   ，将你的项目启动到你的物理nDisplay设置上。

要在你的计算机上开始使用示例nDisplay配置，请按照[nDisplay快速入门](../ndisplay-quick-start/index.md)中的步骤进行操作。

> [!NOTE]
> nDisplay Root Actor 不需要在启动 nDisplay 集群的级别中。如果项目启用了 nDisplay 插件，您可以指定 Switchboard 中 nDisplay 配置资产（`.uasset` 或 `.ndisplay` 文件）的位置，或者指定 nDisplay 配置文件（`.cfg` 或 `.ndisplay`）作为一个命令行参数。这个方法在-game和Packaged模式下工作。
>
> 如果配置资产在你的项目中已经作为Actor存在，当你使用Switchboard或命令行参数从外部指定一个资产时，它将被忽略。

## 故障转移

所有nDisplay网络——无论是永久性的还是临时部署的——都会面临一些故障风险。故障起因可能是硬件、软件或网络问题。故障转移是指系统如何在不终止整个集群的情况下减轻故障风险并从节点故障中恢复。

目前，nDisplay中的故障转移只解决了渲染节点的网络可发现故障。换句话说，当一个渲染节点变得没有反应时，无论是因为崩溃还是因为失去了网络连接，它都会在指定的超时时间后从集群中删除。

### 启用故障转移

如需启用nDisplay故障转移支持，请在[nDisplay 3D配置编辑器](../ndisplay-3d-config-editor/index.md)中打开集群的细节面板，将故障转移策略设置为失败时"放弃S节点（Drop S-node）"。

![启用故障转移策略](../../../../../assets/images/68/68f662e83126a184b8682c2d497a285f0650f34636795e5dd644c53f111ae710.png)

激活后，如果渲染节点超过指定的超时值，就会从集群中删除。故障转移相关的超时值可以在集群的网络设置中找到。有关网络设置的详细信息，请参考[更改nDisplay通信端口](../changing-ndisplay-communication-ports/index.md)。

![Network Settings for Cluster](../../../../../assets/images/cd/cd483860bfe95d45b402b8d5dabd09a468599519149b9afcd0d75c25891124a8.png)

如果某个节点没有及时响应，并且屏障超时，这些节点会被视为发生故障，并在故障转移策略激活时从集群中删除。

## 多GPU支持

nDisplay支持使用多个GPU (mGPU)进行视口渲染，因此你可以指定一个GPU设备来渲染特定的视口，然后将该帧复制到另一个GPU进行显示。例如，在虚拟制作和摄像机内视觉特效场景中，可以在第二个GPU上渲染整个内部视锥，从而提升性能和硬件利用率。

在具有NVLink的NVIDIA GPU上，你可以绕过CPU并将内存直接从GPU转移到GPU。没有NVLink，内存转移仍采用点对点(P2P)模式，但必须经过基于PCIe的CPU，因此转移速度可能会变慢。

要在nDisplay设置中启用mGPU：

1. 在nDisplay 3D配置编辑器中打开你的nDisplay配置资产。
2. 在组件（Components）面板中，选择配置资产以打开细节（Details）面板，然后将配置（Configuration） > 渲染帧设置（Render Frame Settings） > 多GPU模式（Multi GPU Mode）设置为启用（Enabled）。
3. 如果是视口渲染： 在nDisplay 3D配置编辑器中，选择视口，在其细节（Details）面板中将GPUIndex字段设置为你的GPU的索引。

   ![GPU Index parameter in a viewport's details panel](../../../../../assets/images/24/2425a37dc38e79d39a7d4d6f09d08ab653fa71125eb8ea4b6975fd7c58ba6fe5.jpg)

   如果是内部视锥渲染： 在nDisplay 3D配置编辑器中，选择ICVFX摄像机，在其细节（Details）面板中将GPUIndex字段设置为你的GPU的索引。

   ![GPU index setting in an ICVFX camera's details panel](../../../../../assets/images/e4/e45a6249ab5a0d129d3ecaadaacdd5540c83e79cea4122099055b5b0778f0865.jpg)

   > [!TIP]
   > 通常情况下，你的计算机上安装和启用的第一个GPU称为0，而其他GPU则按照递增顺序编号为1、2……、n。你可以在计算机的设置中找到操作系统提供的GPU设备编号。例如在Windows系统中，你可以在任务管理器（Task Manager）中找到GPU设备编号：
   >
   > 1. 打开任务管理器（Task Manager）。
   > 2. 切换到性能（Performance）选项卡。
   > 3. 窗口的左侧将显示你的计算机中的全部GPU及其设备编号。
   >
   >    ![Task manager window only showing one GPU, with the name GPU 0](../../../../../assets/images/96/96023c170f6e2f661f5025c17bd6081d1c416fa1d5fe4db55f6f759c12c7d13b.jpg)
4. 在nDisplay节点的[Switchboard](../../../communicating-with-media-components-from/switchboard/index.md)设置中，将 *GPU数量（Number of GPUs）* 设置为nDisplay节点中GPU的实际数量。

   ![Switchboard settings number of GPUs set to 2](../../../../../assets/images/bc/bcb84daba461f4d5036bb139f7fc65d80a73e8828fcc5f9c88a752376d71d25e.png)

## 运行时的摄像机控制

在虚拟3D空间中，nDisplay将内部维护配置文件中设置的场景对象的层级。例如，此场景层级通常定义 *摄像机* 位置，以及3D空间 *画面* 矩形集的位置，此类位置在虚拟场景中代表真实显示画面或投射表面。相对于虚拟空间中固定位于原点（0,0,0）的单个 *根* 位置来定义此类nDisplay场景对象的位置。

在运行启用了nDisplay的项目时，此虚拟空间的根基于关卡中附加到摄像机的 **DisplayClusterRoot** 组件的位置和旋转。nDisplay每帧均会将此根组件的位置和旋转用作配置文件中设置的场景节点的层级起始点。

nDisplay在启动时会默认创建DisplayClusterRoot组件，并将其附加到默认摄像机。从而产生整个nDisplay簇中的所有设备和投影仪，将以活跃摄像机的视角自动渲染场景的效果。

## 蓝图API

可在游戏运行时逻辑中，使用游戏的蓝图API控制nDisplay系统的行为。

要获取此类API中公开的函数：

1. 对于群集管理、查询输入设备、nDisplay渲染等多数相关的nDisplay蓝图函数，在蓝图中新建

   N Display > DisplayCluster Module API

   节点。
2. 从节点的 **Out API** 引脚拖动，然后在 **显示群集** 类别下查看：

   ![Display cluster blueprint API](../../../../../assets/images/24/2405decd72248a8ce6286805a7369e04938f5443f728a3bde8a60b5d54278b33.jpg)

## 扩展nDisplay

nDisplay原生提供诸多功能，用于控制跨多个计算机和输出设备的实时同步渲染。由于存在大量投射系统和显示表面，可能需要扩展nDisplay渲染系统来支持您自己选择的技术。若熟悉C++编程，并了解nDisplay在典型用例中的工作方式，则可在nDisplay的可扩展渲染API上进行打造，从而扩展nDisplay来支持其他显示和校准技术。

nDisplay API将渲染通道分解为数个主要概念：

- DisplayClusterRenderingDevice

  ，本质上是本地

  IStereoRendering

  接口的扩展。
- DisplayClusterPostProcess

  ，一组六个回调，用于对特定视口应用后期处理效果。
- DisplayClusterProjectionPolicy

  ，负责自定义投射方法，如支持可扩展显示、VIOSO、DomeProjection，或MPCDI，以便渲染至曲面或任意平面上，或执行简单平面投射。
- DisplayClusterRenderSyncPolicy

  ，用于各种同步方法，如

  nvSwapLock

  、vSync或24hz显示的自定义跳帧同步。

创建上述自有专业化元素之后，即可自定义nDisplay系统生成的图像，以适应使用的任何投射或显示技术，同时仍可享受nDisplay群集系统的所有关键优势，无需修改发布的虚幻引擎源代码。

欲知如何设置这些元素实现的工作模型，参阅 `PicpProjection` 和 `PicpMPCDI` 模块的源代码。可在虚幻引擎源代码（ `Engine/Plugins/Runtime/nDisplay/Source` 下）中找到这些模块。

> [!TIP]
> 你可以为nDisplay集群提供自定义键值对。你可以在配置资产的细节面板中的自定义参数字段中添加任意数量的参数和数值。然后，你可以在运行时，通过nDisplay蓝图或C++ API来获取这些配置值。
>
> 要添加自定义参数：
>
> 1. 在
>
>    3D配置编辑器
>
>    中，选择组件面板中的
>
>    Self
>
>    ，打开其
>
>    细节
>
>    面板。
> 2. 在 **细节** 面板中，展开 **配置** 分段，在 **自定义参数** 字段中添加元素。
>
>    > 图片已省略：Adding Custom Parameters to your nDisplay cluster

## 支持的操作系统

### Windows

在Windows 10、8.1、8和7上，nDisplay的所有工具及功能都有效。

### Linux

nDisplay及其工具生态链现在包含对Linux的初级支持。这将使在各种Linux发行版下运行UE的用户受益，特别是那些在集群设置环境下进行培训和模拟的用户。

#### Linux相关的已知限制

- 由于现有显卡驱动支持的原因，自定义同步策略会有一些局限性。
- 某些依赖其他供应商的投影策略将必须被验证。
- 某些渲染功能（例如光线追踪）目前还不支持。

---
title: "nDisplay配置文件参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-configuration-file-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay配置文件参考"]
---

# nDisplay配置文件参考

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay配置文件参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-configuration-file-reference-for-unreal-engine

> [!NOTE]
> 从虚幻引擎4.27开始，你可以继续将.cfg和.ndisplay配置文件导入到项目的 **内容浏览器** 中，它们将转换成新的.uasset格式。
>
> 你可以导出 `.ndisplay` 配置文件并使用它启动群集。`.ndisplay` 文件不会具有跟踪功能以及其它只能在 **nDisplay配置资产** 中配置的功能。
>
> 我们建议使用[nDisplay 3D配置编辑器](../ndisplay-3d-config-editor/index.md)来配置你的nDisplay群集。

你可以在单个配置文件中定义nDisplay系统的大部分方面。该文件的内容包含组成网络的所有计算机、想要虚幻引擎在每台计算机上渲染的窗口和视口的特性、每个视口应渲染的虚拟世界的各个部分、希望接受的输入设备类型等等信息。

本页面介绍nDisplay配置文件中所有可用的设置项。

> [!TIP]
> 想要初步了解并创建自己的nDisplay配置文件，最佳方法是查看nDisplay插件所提供的示例配置文件。如果你已使用nDisplay模板创建了自己的项目，可以在项目文件夹的 `Content/ExampleConfigs` 目录中找到这些文件。如果尚未创建项目，可以在虚幻引擎安装文件夹的 `Templates/TP_nDisplayBP/Content/ExampleConfigs` 目录中找到这些文件。

nDisplay配置文件的结构直接关联到用于渲染可视化内容的不同组件类型。

- 你配置的每种不同组件类型在该配置文件中都有对应的行，并由你指定的字符串ID识别。当某个配置分段需要引用另一个配置分段时，可以使用这些字符串ID。
- 你在此文件中配置的许多组件在虚拟3D空间中都有既定位置（很多时候还包括旋转）。每个对象的位置和旋转都相对于该对象的 *父项*。默认情况下，所有对象的父项都是虚拟空间原点：3D世界空间中被视为虚拟空间起点的任意点。还可以在3D空间中配置特定的命名转换，称为scene_nodes（场景节点），它可以作为一个或多个组件的父项。这种方法有助于简化屏幕、摄像机和其他组件的空间布局。 要了解如何使用scene_nodes构建3D转换的层级（这些转换都始于虚拟空间中的同一个点），请参阅下文[配置文件场景结构示例](#configurationfilescenestructureexample)一节。
- 除非另有说明，所有引用虚拟3D空间或真实物理空间中测量值的参数，所使用的单位都应为"米"和"度"。包括屏幕、场景节点、摄像机等。
- 所有引用屏幕空间中测量值的参数都应使用"像素"为单位。包括窗口和视口。

## 群集节点配置

对于将在nDisplay网络中使用的虚幻引擎应用的各个不同实例，都需要定义一个 **cluster_node** （群集节点）配置。每个cluster_node配置都必须包含一个对 **[窗口](#windowconfigurations)** 配置段的引用，窗口配置段定义了主应用程序窗口的属性。

Cluster_node 配置还定义了将运行该应用程序实例的计算机的主机名和IP地址。你可以为每个cluster_node配置设置不同的物理计算机，也可以在同一台主机上运行多个cluster_node配置。

### 示例配置：

此示例配置一个主节点（每个网络配置一个）：

```
	[cluster_node] id=node_front addr=192.168.0.1 window=wnd_LT sound=true port_cs=41001 port_ss=41002 master=true 
```

此示例配置一个非主群集节点：

```
	[cluster_node] id=node_left addr=192.168.0.2 window=wnd_large sound=false 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此群集节点配置的唯一名称。 |
| **addr** | 必需 |  | 将运行此虚幻引擎实例的计算机的IP地址。该地址必须是IPv4地址。不支持IPv6。 |
| **窗口（window）** | 必需 |  | **[窗口](#windowconfigurations)** 配置的名称，该配置为该虚幻引擎应用程序实例定义主窗口的大小和位置。 |
| **声音（sound）** | 可选 | `false` | 定义该虚幻引擎实例是否播放声音。可选项；默认值为"false"。 |
| **port_cs** | 可选 | `14001` | 主节点用于与群集中的其他节点通信以实现群集同步的端口。**port_ss** 用于交换同步；**port_ce** 用于群集事件。可选；默认值为 `14001`、`14002` 和 `14003`。 |
| **port_ss** | 可选 | `14002` | 主节点用于与群集中的其他节点通信以实现交换同步的端口。 |
| **port_ce** | 可选 | `14003` | 主节点用于与群集中的其他节点通信以实现群集事件的端口。 |
| **master** | 可选 | `false` | 定义该虚幻引擎实例是否为群集中的主节点。只能有一个 **cluster_node** 分段可以将此参数值设为 `true`。 |
| **gpu** | 可选 |  | 定义该虚幻引擎实例进行渲染时应使用的GPU索引号。 使用这种方式设置GPU实例，效果与使用 `r.GraphicsAdapter` 控制台变量相同。 |

## 窗口配置

每个 **窗口（window）** 配置为一个虚幻引擎应用程序实例的主窗口定义了一组属性值。当nDisplay启动应用程序时，可以使用这些值来设置窗口的初始大小和位置，以及该窗口是否应该全屏显示等。

还可使用一个或多个 **[视口](#viewportconfigurations)** 配置，用于指定主应用程序窗口中的特定区域（nDisplay将在其中显示场景的渲染画面）。

### 示例配置：

此示例配置包含单个视口的应用程序窗口：

```
	[window] id=wnd_one fullscreen=false WinX=0 WinY=0 ResX=640 ResY=480 viewports=vp_LT 
```

此示例配置包含四个分离视口的应用程序窗口：

```
	[window] id=wnd_four fullscreen=false WinX=0 WinY=0 ResX=640 ResY=480 viewports="vp_LT,vp_RB,vp_LB,vp_RT" 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此窗口配置的唯一名称。 |
| **全屏（fullscreen）** | 可选 | `false` | 此窗口是否应在全屏模式下运行。如果将此值设为 `false`，则必须提供 **WinX**、**WinY**、**ResX** 和 **RexY** 设置，如下所述。 |
| **WinX** | 可选 | `0` | 指定桌面应用程序窗口左上角的X轴方向位置，单位为屏幕空间像素，值为到屏幕左边缘的距离。 |
| **WinY** | 可选 | `0` | 指定桌面应用程序窗口左上角的Y轴方向位置，单位为屏幕空间像素，值为到屏幕顶部边缘的距离。 |
| **ResX** | 必需 | `0` | 指定应用程序窗口的水平大小，以屏幕空间的像素为单位。当 **全屏（fullscreen）** 设为 `false` 时，必需配置此项。当 **全屏（fullscreen）** 设为 `true` 时，将忽略此此参数值。 |
| **ResY** | 必需 | `0` | 指定应用程序窗口的垂直大小，以屏幕空间的像素为单位。当 **全屏（fullscreen）** 设为 `false` 时。当 **全屏（fullscreen）** 设为 `true` 时，将忽略此此参数值。 |
| **视口（viewports）** | 必需 |  | 引用一个或多个[视口](#viewportconfigurations)**配置段，这些段定义了nDisplay会用渲染的场景视图填充的主应用程序窗口区域。 如果指定了多个视口，必须以逗号分隔**视口（viewport）**配置段名称列表，并将整个值用引号括起来。请参阅上文**示例配置**部分下的 `wnd_four` 示例。此列表的顺序不影响视口的视觉顺序或位置。视口在父窗口中的位置在**视口（viewport）** 命名配置中定义。 确保使用的视口定义不超出窗口大小。 |
| **后期处理（postprocess）** | 可选 |  | 指定一个或多个 **[后期处理](#postprocessconfigurations)** 配置部分的ID，这些配置定义了在nDisplay将最终生成的输出图像渲染至窗口前，要应用的后期处理操作。可选；仅在需要先转换最终图像再渲染时使用此参数。若有多个后期处理配置，nDisplay将按顺序转换。 |

## 视口配置

上述各个 **窗口（window）** 配置都引用了一个或多个 **视口（viewport）** 配置，每个视口配置都会定义游戏窗口的一个矩形区域，nDisplay会在其中填充已渲染的视图场景。

视口通常从应用程序窗口的左上角开始，设定其宽度和高度以便填充父窗口。但是在某些情况下，你可能需要在视口的父应用程序窗口内对视口进行偏移。例如，如果需要设置两个部分重叠的投影仪，或者需要一个应用程序窗口在不同位置容纳多个分离的视口，则可能想要进行此类偏移。

nDisplay支持 **多GPU (mGPU)** 视口渲染，因此你可以指定一个GPU设备渲染特定视口，并将帧复制到另一个GPU进行显示。例如，在虚拟制片和摄像机内的VFX场景中，可以在第二个GPU上整体渲染内部视锥，从而改善性能和硬件使用率。在带有[NVLink](https://www.nvidia.com/en-us/design-visualization/nvlink-bridges/)的NVIDIA GPU上，可以绕过CPU并将内存内容直接从GPU传输到GPU。若无NVLink，虽然内存传输仍将是点对点（P2P）方式，但可能会变慢，因为必须在PCIe上通过CPU进行操作。

> [!NOTE]
> 当你通过nDisplay启动器或交换台启动nDisplay以使用mGPU特性时，将MaxGPUCount=2添加到自定义命令行参数。

### 示例配置：

```
	[viewport] id=vp_LT X=0 Y=0 width=300 height=220 projection=proj_simple_LT 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此视口配置的唯一名称。 |
| **X** | 可选 | `0` | 视口左上角的X轴坐标，单位为屏幕空间像素，值为到主应用程序窗口左边缘的距离。注意，此值相对于应用程序窗口的左上角，而不是屏幕自身的左上角。 |
| **Y** | 可选 | `0` | 视口左上角的Y轴坐标，单位为屏幕空间像素，值为到主应用程序窗口顶部边缘的距离。注意，此值相对于应用程序窗口的左上角，而不是屏幕自身的左上角。 |
| **宽度（width）** | 必需 | `0` | 渲染帧的宽度，以像素为单位。此值不应该大于游戏窗口的大小，游戏窗口大小是由任何使用此视口的 **窗口（window）** 配置中的 **大小（size）** 参数设置的。 |
| **高度（height）** | 必需 | `0` | 渲染帧的高度，以像素为单位。此值不应该大于游戏窗口的大小，游戏窗口大小是由任何使用此视口的 **窗口（window）** 配置中的 **大小（size）** 参数设置的。 |
| **投影（projection）** | 必需 |  | **[投影](#projectionconfigurations)** 配置的名称，其定义了应绘制到此视口的虚拟世界渲染视图。 |
| **摄像机（camera）** | 可选 |  | 要强制此视口显示的 **[摄像机](#cameraconfigurations)** 配置部分。视口默认从nDisplay当前所用 **摄像机** 部分的位置渲染场景。但可使用此参数覆盖默认nDisplay摄像机，并强制此视口从另一 **摄像机** 部分中配置的视角渲染场景。 |
| **buffer_ratio** | 可选 | `1.0` | 值为 `0` 到 `1` 之间，用于缩放nDisplay渲染此视口时所用渲染目标纹理的尺寸。减小此值可有效降低nDisplay生成图像的分辨率。最终图像质量会因此下降，但渲染速度更快。 |
| **rtt** | 可选 | `false` | 该视口是否渲染至纹理。 |
| **gpu_node** | 可选 | 0 | 分配GPU设备，用于渲染视口并将帧复制到仅用于显示的GPU。默认GPU是第一个安装到计算机上的GPU。 |
| **allow_gpu_transfer** | 可选 | 1 | 启用此选项后，每个视口都将被传输到所有GPU。禁用此选项会阻止复制视口到其他GPU。 |
| **share** | 可选 |  | 启用该选项后，nDisplay会对视口使用纹理共享，发送纹理并从其他应用接收纹理。请参阅[纹理共享](../../texture-share/index.md)了解详情。 |

> [!TIP]
> 计算机上第一个安装并启用的GPU通常被编号为 **0**，其他GPU的编号依次递增为 **1**、**2**...、**n**。可以在电脑设置中找到你的操作系统提供的GPU设备编号。例如，在Windows上，可以在 **任务管理器** 中找到你的GPU设备编号：
>
> 1. 打开
>
>    任务管理器（Task Manager）
>
>    。
> 2. 切换到
>
>    性能（Performance）
>
>    选项卡。
> 3. 窗口左侧显示机器中现有的所有GPU及其设备编号。
>
> ![Windows上任务管理器中的GPU编号](../../../../../assets/images/bb/bb9e99b67347fe2a85974ab3853f77c1e8e766288eb03f44e3dbe778261ba149.png)
>
> 在只有一个GPU的计算机上，该GPU在任务管理器中显示为 GPU 0。

## 投影配置

上述所有 **视口** 配置中都会引用 **投影** 配置，投影配置负责定义需要在视口中绘制的渲染图像。

通常使用 `simple`（简单） 投影类型，利用此nDisplay配置文件中其他地方的 **屏幕** 配置部分所定义的视锥，从当前摄像机位置渲染虚拟世界。

其他投影类型，如 `mpcdi`、`easyblend`、`vioso` 和 `domeprojection`，使用其他方法定义视口的渲染内容，并可以在把图像渲染到矩形视口之前，引入其他校正或应用其他渲染技术。比如，投影有可能通过挤压、拉伸或扭曲图像等方式，使其以更自然的方式显示在某个曲面上。

### 示例配置：

下例为最简单用例，它将屏幕配置定义的视锥 `scr_LT` 直接路由到视口，而不扭曲或修改渲染图像。

```
	[projection] id=proj_simple_LT type=simple screen=scr_LT 
```

下例展示如何使用 `easyblend` 投影类型渲染至可扩展显示配置文件中定义的表面。

```
	[projection] id=proj_easyblend_1 type="easyblend" file="D:\eb_data\ScalableData.pol_1" origin=easyblend_origin_1 scale=0.1 
```

下例展示如何使用 `mpcdi` 投影类型渲染至MPCDI配置文件中定义的表面。

```
	[projection] id=proj_mpcdi_LT type="mpcdi" file="D:\rot90_flat.mpcdi" buffer="Mosaic" region="Monitor_R" origin=mpcdi_origin 
```

下例展示如何通过指定 `.png` 文件所定义的alpha混合贴图，使用 `mpcdi` 投影类型渲染至指定 `.pfm` 几何体文件定义的曲面。

```
	[projection] id=proj_mpcdi_LT type="mpcdi" pfm="D:\geom_displayLeft1.pfm" alpha="D:\Left1blend.png" alpha_gamma=2 origin=mpcdi_origin 
```

下例展示如何使用 `vioso` 投影类型渲染至使用原生VIOSO文件所定义的表面。

```
	[projection] id=proj_vioso_1 type="vioso" file="D:\left.vwf" origin=vioso_origin base="[1000 0 0 0] [0 1000 0 0] [0 0 1000 0] [0 0 1000 1]" 
```

下例展示如何使用 `domeprojection` 类型渲染至 `.xml` 校准文件中的DomeProjection所定义的表面。

```
	[projection] id=proj_domeprojection_1 type=domeprojection file="D:\config.xml" origin=domeprojection_origin channel=0 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此投影配置的唯一名称。 |
| **类型（type）** | 必需 |  | 定义nDisplay如何生成其在视口中绘制渲染图像的投影类型。此参数接受以下值： `simple`：将 **屏幕** 配置部分定义的虚拟世界上的视锥渲染至视口。 `easyblend`：将使用[可扩展显示技术](http://www.scalabledisplay.com/)中的工具校准虚拟世界视图渲染至视口。 `mpcdi`：将使用[MPCDI](https://vesa.org/vesa-standards/)校准的虚拟世界视图渲染至视口。 `vioso`：将使用[VIOSO](https://vioso.com/)中的工具校准的虚拟世界视图渲染至视口。 `domeprojection`：将使用[DomeProjection](https://www.domeprojection.com/)中的工具校准的虚拟世界视图渲染至视口。 |

`type=simple` 还接受以下额外参数的投影：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **屏幕（screen）** | 必需 |  | 定义3D空间视锥的 **[屏幕](#screenconfigurations)** 配置的名称，虚幻引擎应用程序应将该视锥渲染至此视口中。 |

`type=easyblend` 的投影还接受以下额外参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **文件（file）** | 必需 |  | 可扩展显示校准文件（*.ol* 或 *.pol* 扩展名）的路径和文件名，该文件定义此视口将被投射到的表面。 |
| **原点（origin）** | 可选 |  | 定义投影起始点的 **scene_node** 配置部分的ID。此参数将可扩展显示校准文件中定义的参考框架映射至虚幻引擎关卡中的虚拟空间。 |
| **比例（scale）** | 可选 | `1.0` | 用于投影的比例因子。此值取决于用于校准EasyBlend的单位。如果用米，保留此值为 `1.0`。如果是分米，设为 `0.1`。如果是厘米，设为 `0.01`。如果是英寸，设为 `0.0254`。 |

`Type=mpcdi` 或 `type=picp_mpcdi` 的投影还接受以下额外参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **原点（origin）** | 可选 |  | 定义投影起始点的 **scene_node** 配置部分的ID。此参数将MPCDI校准文件（或 `.pfm` 几何体文件）中定义的参考框架映射至虚幻引擎关卡中的虚拟空间。 |
| 选项1：使用MPCDI文件 |  |  |  |
| **文件（file）** | 必需 |  | `.mpcdi` 文件的路径和文件名，该文件定义此视口将被投射到的表面的几何结构。 |
| **缓冲区（buffer）** | 必需 |  | `.mpcdi` 文件中缓冲区的ID，该文件定义此视口的投影区域。 |
| **区域（region）** | 必需 |  | 上面参数所设的，要渲染至的缓冲区内的区域ID。 |
| 选项2：使用显式数据 |  |  |  |
| **pfm** | 必需 |  | 指定包含投影几何体的 `pfm` 文件。 |
| **比例（scale）** | 可选 | `1.0` | 用于几何体的比例因子。 |
| **ue4space** | 可选 | `false` | 指示 `.pfm` 文件中的几何体是否已经由虚幻引擎坐标系所表示。 |
| **alpha** | 可选 |  | `.png` 文件的路径和文件名，用作alpha混合贴图，定义了投影强度。可选参数。 |
| **alpha_gamma** | 可选 |  | 若使用 `alpha` 设置，可使用 `alpha_gamma` 设置提供alpha gamma的乘数。可选参数。 |
| **beta** | 可选 |  | 若使用 `alpha` 设置，还可使用 `beta` 设置提供 `.png` 文件的路径和文件名，作为beta混合贴图。此参数定义了黑色关卡调整。可选参数。 |

> [!NOTE]
> nDisplay当前仅支持MPCDI **1.0** 版，以及 **2D** 和 **A3D**（或 **高级3D**）配置文件类型。

`type=vioso` 的投影还接受以下额外参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| 文件（file） | 必需 |  | VIOSO校准文件（`.vwf` 扩展名）的路径和文件名，该文件定义此视口将被投射到的表面。 |
| 原点（origin） | 可选 |  | 定义投影起始点的 **scene_node** 配置部分的ID。它将在VIOSO校准文件中定义的参考框架映射至虚幻引擎关卡中的虚拟空间。 |
| 基（base） | 可选 |  | 自定义基矩阵，用于将校准空间转换为UE坐标系。 |

`type=domeprojection` 的投影还接受以下额外参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| 文件（file） | 必需 |  | DomeProjection校准文件（`.xml` 扩展名）的路径和文件名，该文件定义此视口将被投射到的表面。 |
| 通道（channel） | 必需 | 0 | 校准文件中映射的输出。每个显示屏一个通道。 |
| 原点（origin） | 可选 |  | 定义投影起始点的 **scene_node** 配置部分的ID。它将在DomeProjection校准文件中定义的参考框架映射至虚幻引擎关卡中的虚拟空间。 |

`type=manual` 时的投影还接受以下参数，用以定义nDisplay的视图旋转和应渲染视锥。可使用矩阵或角度来配置视锥。

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **rot** | 可选 | `0,0,0` | 视图旋转。表示为pitch、yaw和roll值。例如，`rot="P=0,Y=0,R=0"`。 |
| 选项1：使用矩阵（单视场） |  |  |  |
| **矩阵（matrix）** | 必需 |  | 若使用单视场渲染，用此4x4矩阵定义视锥。 |
| 选项2：使用矩阵（立体） |  |  |  |
| **matrix_left** 和 **matrix_right** | 必需 |  | 若使用立体渲染，用此4x4矩阵对定义左右眼的视锥。例如，`matrix_left="[0.5 0 0 0] [0 0.999999 0 0] [1 0 0 1] [0 0 1 0]" matrix_right="[0.500001 0 0 0] [0 1 0 0] [-1 0 0 1] [0 0 1 0]"`。 |
| 使用角度 |  |  |  |
| 选项3：使用视锥（单视场） |  |  |  |
| **视锥（frustum）** | 必需 |  | 若使用单视场渲染，用此属性定义视锥左侧、右侧、顶部和底部的角度。例如，`frustum="l=0 r=15 t=10 b=-10"`。值是以相对于视图矢量的角度来设置的。 |
| 选项3：使用视锥（立体） |  |  |  |
| **matrix_left** 和 **matrix_right** | 必需 |  | 若使用立体渲染，用这两个属性定义左右眼视锥左侧、右侧、顶部和底部的角度。例如，`frustum_left="l=-15 r=0 t=10 b=-10" frustum_right="left=0 right=15 top=10 bottom=-10"`。值是以相对于视图矢量的角度来设置的。 |

`type=camera` 的投影不接受任何其他附加参数。你可以使用蓝图或C++ API在运行时为投影策略设置摄像机。

`type=mesh` 和 `type=picp_mesh` 的投影不接受任何其他附加参数。你可以使用蓝图或C++ API在运行时为投影策略设置静态网格体组件。

## 屏幕配置

每个使用 `simple` 投影类型的不同输出显示都使用一个在3D虚拟空间中有既定大小和位置的矩形所定义的锥体从当前摄像机位置渲染场景。这些矩型都由 **屏幕（screen）** 配置定义。通常，这些投影屏幕在虚拟空间中的尺寸通常与你将用于显示渲染结果的物理屏幕相同。

屏幕的枢轴点始终在其中心点。

### 示例配置：

此定义描述了一个3米乘3米的屏幕，直接在其父项之前。因为屏幕的枢轴点位于由大小参数定义的矩形的中心点，所以我们在Z轴上添加了1.5米的偏移量，以便将屏幕向上移动一半高度。

```
	[screen] id=screen_front loc="X=1.5.Y=0,Z=1.5" rot="P=0,Y=0,R=0" size="X=3,Y=3" parent=screens 
```

要在查看器的左侧定义一个屏幕，我们将其向左侧移动（Y轴上的负值），并使其围绕其局部Y轴旋转（yaw）。

```
	[screen] id=screen_left loc="X=0,y=-1.5,Z=1.5" rot="P=0,Y=-90,R=0" size="X=3,Y=3" parent=screens 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此屏幕配置的唯一名称。 |
| **loc** | 可选 | `0,0,0` | 此屏幕的中心在虚拟空间中相对于其父项的位置。 |
| **rot** | 可选 | `0,0,0` | 屏幕朝向相对于其父项的pitch（P）、yaw（Y）和roll（R）角度，以度数表示。 |
| **大小（size）** | 必需 | `0,0` | 屏幕矩型沿其局部X和Y轴的总大小，单位为米。 |
| **父项（parent）** | 可选 |  | 一个 **[scene_node](#scenenodeconfigurations)** 配置的名称，此配置将作为此对象的父项。此参数可选。如果指定了父项，在 **loc** 和 **rot** 参数中设定的值将为相对于该父项位置的相对值。如果忽略父项，在 **loc** 和 **rot** 参数中设定的值将相对于虚拟根。 |
| **tracker_id** | 可选 |  | 一个 **[输入](#inputconfigurations)** 配置的名称，此配置定义想要随着时间驱动屏幕位置的虚拟设备。可选参数。如果忽略此参数，屏幕的位置在虚拟空间中将是静态的。 |
| **tracker_ch** | 可选 |  | 当你提供 **tracker_id** 时，此参数指定nDisplay将从中读取追踪数据的设备的通道。 |

## 后期处理配置

**后期处理** 配置定义虚幻引擎实例为 **窗口** 生成的图像在渲染前如何进行后期处理。nDisplay目前支持两种后期处理操作：`OutputRemap` 和 `TextureShare`.

通过 `OutputRemap`，你可以控制nDisplay生成的2D图像映射到应用程序窗口2D区域的方式。例如，你可以对部分输出图像进行平移、旋转和缩放，使它们出现在应用程序窗口的不同区域。为此，你需要提供一个.obj文件。该文件需要包含一个设置了UV映射的平面几何体。nDisplay将使用为平面设置的UV映射来确定如何将输出图像映射到应用程序窗口的每个部分。

通过 `TextureShare`，你可以从另一个应用程序接收纹理，并在指定的视口中显示它。为此，你需要定义一个后处理，其中要用到Texture Share项的名称以及将显示纹理的视口。

### 示例配置：

下面的示例展示了如何在两个.obj文件中使用OutputRemap后处理类型：

```
	[window] id=somewindow ... postprocess="pp_1, pp_2"	[postprocess] id=pp_1 type="OutputRemap" file="remap_1.obj"	[postprocess] id=pp_2 type="OutputRemap" file="remap_2.obj" 
```

以下示例展示了如何使用TextureShare将渲染后的帧从 **vp_1** 视口共享给外部应用程序，从第三方源接收纹理，并在 **vp_ext** 视口中显示它。

```
	[window] id=somewindow viewports="vp_1" fullscreen="false" … postprocess="pp_sharenode_ext"	[viewport] id=vp_1 ... projection="proj_screen_1" share=true	[viewport] id=vp_ext ... projection=""		[postprocess] id=pp_sharednode_ext type="TextureShare" destination="vp_ext" source="thirdpartyapp_viewport_rendering"
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此后期处理配置的唯一名称。 |
| **类型（type）** | 必需 |  | 要执行的后处理类型。目前支持以下两种类型： `OutputRemap` `TextureShare` |
| OutputRemap配置 |  |  |  |
| **文件（file）** | 必需 |  | `.obj` 文件的路径和文件名。此文件包含将已渲染图像绘制到应用程序窗口前用于重新映射它的UV贴图。 |
| 纹理共享（TextureShare）配置 |  |  |  |
| **目标对象（destination）** | 必需 |  | 目标视口的名称，用于接收来自 `应用程序` 的纹理。 |
| **源（source）** | 必需 |  | 发送纹理给nDisplay的应用的名称。 |

## 摄像机配置

nDisplay群集中的所有实例从虚拟世界中的相同位置渲染场景。这些可能的视点都由 **摄像机（camera）** 配置行定义。

你可以在运行时在这些视点之间切换。每个摄像机视点也可以由追踪设备驱动。

### 示例配置：

```
	[camera] id=camera_static loc="X=0.Y=0,Z=1.7" tracker_id=VRPNTracking tracker_ch=0 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此摄像机配置的唯一名称。 |
| **loc** | 可选 | `0,0,0` | 此摄像机在虚拟空间中相对于其父项的位置。 |
| **rot** | 可选 | `0,0,0` | 此摄像机在虚拟空间中相对于其父项的旋转。 |
| **父项（parent）** | 可选 |  | 一个 **[scene_node](#scenenodeconfigurations)** 配置的名称，此配置将作为此对象的父项。此参数可选。如果指定了父项，在loc参数中设定的值将为相对于该父项的位置。如果忽略父项，在loc参数中设定的值将相对于虚拟根。 |
| **eye_swap** | 可选 | `false` | 在立体模式下渲染时，通过此属性确定是否交换为左右眼生成的图像。 |
| **eye_dist** | 可选 | `0.064` | 在立体模式下渲染时，此属性确定瞳孔间距离，用于偏移为左右眼生成的图像，单位为米。 |
| **force_offset** | 可选 | `0` | 在单视场模式下渲染时，此属性用于将此摄像机偏移到左眼或右眼位置（按上述 **eye_dist** 属性的定义），从而模拟立体渲染。值为 `-1` 强制摄像机从左眼位置渲染，值为 `0` 从摄像机默认位置渲染（无效果），值为 `1` 强制摄像机从右眼位置渲染。 |
| **tracker_id** | 可选 |  | 一个 **[输入](#inputconfigurations)** 配置的名称，此配置定义你希望随着时间驱动摄像机位置的虚拟设备。可选参数。如果忽略此参数，摄像机的位置在虚拟空间中将是静态的。 |
| **tracker_ch** | 可选 | `-1` | 当你提供 **tracker_id** 时，此参数指定nDisplay将从中读取追踪数据的设备的通道。 |

## 场景节点配置

可以在你的配置文件中定义场景节点的层级，每个节点都代表着3D空间中的一个变换。配置文件中设置的任何在3D空间中有位置和旋转属性的对象，例如摄像机或投影屏幕，都可以将这些 *scene_node* 配置之一作为其父项。此配置可以帮助定义可视化系统的所有不同组件之间的空间关系。

类似于摄像机，场景节点也可以由虚拟追踪设备驱动。

### 示例配置：

以下数行定义了两个节点的层级，其中子节点位于其父节点之前，有2米的偏移量。

```
	[scene_node] id=vr_space_root loc="X=0.Y=0,Z=0" rot="P=0,Y=0,R=0"	[scene_node] id=walls_front_group loc="X=2.Y=0,Z=0" rot="P=0,Y=0,R=0" parent= vr_space_root 
```

以下数行展示了一个配置为由虚拟追踪设备驱动的场景节点：

```
	[scene_node] id=cave_wand loc="X=0, Y=0,Z=1" tracker_id=CaveTracking tracker_ch=1 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此场景节点配置的唯一名称。 |
| **loc** | 可选 | `0,0,0` | 此场景节点在虚拟空间中相对于其父项的位置。 |
| **rot** | 可选 |  | 场景节点朝向相对于其父项的pitch（P）、yaw（Y）和roll（R）角度，以度数表示。 |
| **父项（parent）** | 可选 |  | 另一个 **[scene_node](#scenenodeconfigurations)** 配置的名称，该配置将作为此场景节点的父项。此参数可选。如果指定了父项，在 **loc** 和 **rot** 参数中设定的值将为相对于该父项位置的相对值。如果忽略父项，在 **loc** 和 **rot** 参数中设定的值将相对于虚拟根。 |
| **tracker_id** | 可选 |  | 一个 **[输入](#inputconfigurations)** 配置的名称，此配置定义想要随着时间驱动场景节点位置的虚拟设备。可选参数。如果忽略此参数，场景节点在虚拟空间中的位置和旋转相对于其父项将是静态的。 |
| **tracker_ch** | 可选 | `-1` | 当你提供 **tracker_id** 时，此参数指定nDisplay将从中读取追踪数据的设备的通道。 |

## 输入配置

可以为每个需要向nDisplay系统提供输入的设备定义一个 **输入（input）** 段。例如，可以选择让每个 **[摄像机](#cameraconfigurations)** 和每个 **[scene_node](#scenenodeconfigurations)** 都由一个在 **输入（input）** 段中设置的虚拟追踪设备驱动，并在 **摄像机（camera）** 或 **scene_node** 的配置中引用此设备。或者，你可能想要设置追踪器、控制器和键盘来发送通用输入事件到虚幻引擎输入系统，或将其事件和输入值绑定到通用nDisplay蓝图节点，以便在项目的游戏脚本中进行响应。

你还可以使用 **[input_setup](#inputsetupconfigurations)** 部分来控制来自这些输入设备的特定通道、按钮或键以何种方式绑定到虚幻引擎中的特定类型的输入事件和值上。

> [!NOTE]
> 有关nDisplay输入的用法概述，请参阅[Live Link VRPN](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/live-link-vrpn/index.md)。

### 示例配置：

此配置将nDisplay设置为从VRPN位置追踪设备获取输入。这种设备通常安装在摄像机或观察者的头部，或由观察者手持。你可以通过在 **[摄像机](#cameraconfigurations)** 或 **[scene_node](#scenenodeconfigurations)** 配置中引用此 **输入** 配置，从而让追踪器自动驱动摄像机或场景节点的位置。或者可以在项目的蓝图代码中获取此追踪器的值。

```
	[input] id=CaveTracking type=tracker addr=Tracker0@192.168.0.1 loc="X=-1.5,Y=0,Z=3.4" rot="P-0,Y=0,R=0" front=X right=Y up=-Z 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 此输入设备配置的唯一名称。 |
| **类型（type）** | 必需 |  | 此VRPN输入设备的类型： 对于追踪设备，类型为 `追踪器（tracker）`。 对于产生轴数据的设备，类型为 `模拟（analog）`。 对于产生布尔按钮数据的设备，类型为 `按钮（button）`。 对于标准计算机键盘，类型为 `键盘（keyboard）`。 |
| **addr** | 必需 |  | 处理该特定设备的VRPN服务器的地址。此参数值必须符合以下格式： `DEVICENAME@SERVER_ADDRESS:SERVER_PORT` 其中： `DEVICENAME` 是此设备的VRPN名称。 `SERVER_ADDRESS` 是VRPN服务器的IPv4地址。 `:SERVER_PORT` 是VRPN服务器用于侦听传入连接的端口。 这是可选设置。如果不提供端口，nDisplay默认使用端口 `3883`。 |

`type=tracker` 的设备还接受以下额外参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **loc rot** | 可选 | `0,0,0` `0,0,0` | 类似于其他配置部分，**loc** 和 **rot** 参数指定该输入设备在本地空间中的位置和旋转偏移量。但是，对于输入设备，通常使用这些偏移量来调整追踪设备在虚拟空间中的根位置，以匹配你期望其在场景节点层级中的位置。 |
| **前/右/上（front right up）** | 必需 |  | 这些参数将虚幻引擎中追踪器的每个局部轴（前、右、上）与追踪器坐标系中的对应轴匹配。虚幻引擎使用Z轴向上的右手坐标系。如果你的追踪器使用不同的坐标系统，可以使用这些参数将追踪器的坐标系映射到虚幻引擎的坐标系。 例如，以下代码行将追踪器的Y轴映射到虚幻引擎的前（X）轴；将追踪器的X轴映射到虚幻引擎中的右（Y）轴，将追踪器的负Z轴映射到虚幻引擎中的上（Z）轴： `front=Y right=X up=-Z` |

`type=analog` 和 `type=button` 的设备不接受任何其他附加参数。

## 输入设置配置

每个 **input_setup** 配置部分为指定的 **[输入](#inputconfigurations)** 设备提供额外的配置参数，通常用于将该设备的通道或键绑定到一个通用的nDisplay蓝图输入节点。

### 示例配置：

此配置设置带ID控制器的输入设备，这样，在按下用于在通道0上生成事件的按钮时，在蓝图中将会从 **输入（Input）>**N显示事件（N Display Events）> **nDisplay按钮0（nDisplay Button 0）** 节点生成一个事件。

```
	[input_setup] id=controller ch=0 bind="nDisplay Button 0" 
```

此配置与上述配置类似，不同之处是它将一个模拟输入值（通常是控制器的轴）绑定到一个nDisplay模拟值。你可以在蓝图中使用 **输入（Input）> N显示事件（N Display Events）> nDisplay模拟0（nDisplay Analog 0）** 节点检测该控制器轴何时被使用，或使用 **输入（Input）> N显示值（N Display Values）> nDisplay模拟0（nDisplay Analog 0）** 来获取当前帧的输入值。

```
	[input_setup] id=test_axes ch=0 bind="nDisplay Analog 0" 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **id** | 必需 |  | 引用 **input_setup** 分段配置的 **[输入](#inputconfigurations)** 配置的ID。 注意，不同于nDisplay配置文件中的大部分其他分段，此 **id** 值不为包含它的 **input_setup** 分段提供ID，而是引用文件其他地方定义的 **输入（input）** 分段的ID。 |
| **ch** | 必需 |  | 确定指定输入设备的通道，该输入设备将绑定到在 **绑定（bind）** 设置中设定的事件。 |
| **键（key）** | 可选 |  | 类似于 **ch**，但仅用于 `type=keyboard` 的输入设备。 |
| **绑定（bind）** | 必需 |  | 确定在虚幻引擎中上述指定通道或按键绑定到的事件。此属性的值可以是你在 **输入（Input）** 类中看到的任何蓝图节点的名称，如 **F1**、**nDisplay F1**、**nDisplay按钮0（nDisplay Button 0）**、**Gamepad Left Thumbstick X-Axis（@@@）**、**Gamepad Face Button Top（@@@）**，等等。 如果名称包含空格，必须用双引号将整个值括起来。 |

## 一般配置

**一般（general）** 配置行包含控制nDisplay群集整体操作的参数。

### 示例配置：

```
	[general] swap_sync_policy=1 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **swap_sync_policy** | 可选 | `0` | 确定输出如何在网络上同步。 0：无同步(VSync=0)。 1：软件交换同步(VSync=1)。 2：NVIDIA交换锁定（仅适用于使用DirectX11和DirectX12进行渲染的NVIDIA卡）。 |
| **ue4_input_sync_policy** | 可选 | `1` | 确定如何通过nDisplay网络复制UE4的本地输入。 0：本地UE4输入仅由主节点处理。不会复制到其他群集节点。 1：主节点接收到的所有本地输入也将复制到所有其他群集节点。 |

## NVIDIA配置

如果在 **[一般](#generalconfiguration)** 配置部分中将 `swap_sync_policy` 的值设为 `2`，可以使用 **NVIDIA** 部分中的参数调整一些与帧锁定相关的特定硬件设置。

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **sync_group** | 可选 | `1` | 用于帧锁定的同步组。 |
| **sync_barrier** | 可选 | `1` | 用于帧锁定的同步屏障。 |

## 网络配置

**网络（network）** 配置分段提供了一些设置，用于控制超时以及与nDisplay群集节点之间的网络通信相关的其他设置。

nDisplay配置文件中只能有零个或一个 **网络（network）** 分段。

### 示例配置：

```
	[network] cln_conn_tries_amount=10 cln_conn_retry_delay=1000 game_start_timeout=30000 barrier_wait_timeout=5000 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **cln_conn_tries_amount** | 可选 | `10` | 当一个非主群集节点启动时，此设置决定该节点在关闭前尝试连接到主节点PC的次数。 |
| **cln_conn_retry_delay** | 可选 | `1000` | 当一个非主群集节点启动时，此设置决定该节点每次连续尝试连接到其主节点PC之间的时间间隔，单位为毫秒。 |
| **game_start_timeout** | 可选 | `30000` | 设置一个时间间隔（以毫秒为单位），让主节点上的虚幻引擎应用程序在开始游戏循环的第一帧并开始渲染到主窗口之前等待所有群集节点准备就绪。此设置让所有群集节点都有机会在渲染开始之前连接到主PC。在此等待期间，主窗口将显示为黑色。如果等到此时间间隔结束时，所有群集节点都未能成功连接到主节点PC，则群集中的所有实例将关闭。 如果群集需要很长时间进行初始化，则可能需要调高此值。 |
| **barrier_wait_timeout** | 可选 | `5000` | 设置游戏和渲染线程的屏障超时，单位为毫秒。该值未群集节点之间同步游戏和渲染线程的屏障超时时间。该参数将在每一帧中使用数次。换言之，该参数用于在运行时检测任何节点变得不可访问的情况。一旦发生这种情况，群集状态将被确定为无效状态，所有节点将自己关闭。 |

**cln_conn_tries_amount** 和 **cln_conn_retry_delay** 设置共同用于确定群集节点在启动时尝试连接到主节点的最大时长。例如，假设将 **cln_conn_tries_amount** 设置为10，**cln_conn_retry_delay** 设置为1000毫秒。启动时，每个节点都将尝试连接到主节点PC。如果连接失败，则等待1000毫秒并重试。如果重新尝试也失败了，再等1000毫秒。连续十次失败后，该群集节点自动退出。一旦集群节点连接到主节点PC，计数就会停止。

## 信息配置

**信息（info）** 配置行包含此配置文件的可选信息：具体是指已知与此配置文件兼容的nDisplay和虚幻引擎的最新版本。

### 示例配置：

```
	[info] version=22 
```

### 参数：

| 参数 | 是否必需 | 默认 | 说明 |
| --- | --- | --- | --- |
| **版本（version）** | 必需 |  | 与此配置文件兼容的最低版本的虚幻引擎。 此数字应该被理解为 `4 点几` 的版本。例如，值为22表示该文件与nDisplay和虚幻引擎的4.22版本兼容。 请勿手动设置此值。**nDisplay启动器（nDisplay Launcher）** 将会自动设置它。如果你使用的配置文件没有设置版本号，或文件中的版本不受当前虚幻引擎版本支持，**nDisplay启动器（nDisplay Launcher）** 将自动尝试更新你的配置文件，以与最新版本兼容。如果更新成功，则将更新后的配置保存到新文件，并将此值更新到最新版本。 |

## 自定义配置参数

你可以包含一个 **自定义（custom）** 配置分段来为你的nDisplay群集节点提供自己的自定义键值对。可以在 `[群集]` 行中包括所需的任意数量的参数和值。然后在运行时，可以从nDisplay蓝图或C++ API中获取这些配置值。

### 示例配置：

```
	[custom] stringParameter=myValue numberParameter=2 
```

## 配置文件场景结构示例

举一个具体的例子，打开 *wall_flat_3x2.cfg* 示例文件，该文件位于虚幻引擎安装文件夹中的 `Templates/TP_nDisplayBP/Content/ExampleConfigs` 目录下。该文件定义了六个投影屏幕，每个屏幕都将由独立的物理计算机渲染。

该文件还定义了几个scene_node，这些节点共同构建了以下层级：

![nDisplay示例场景层级](../../../../../assets/images/bc/bc1ac27282142e99dabf37b92b76b2a98f89bca62202862efa36dffea001738d.png)

节点在此层级中的相对位置和旋转决定了摄像机和六个屏幕在虚拟空间中的布局，本示例中，这六个投影屏幕并排排列，距离摄像机1米远。

![nDisplay example layout](../../../../../assets/images/a3/a3c636bfa63e8c1770b188f5b6bf9666759fd718fe485e3db18a8b5923e4b5ad.png)

> [!NOTE]
> 请注意，该配置意味着每一对相邻的投影屏幕之间留有较小空间，以便将显示渲染场景的显示器边框考虑在内。

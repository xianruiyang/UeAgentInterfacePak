# NFOR时空降噪器

---
title: "NFOR时空降噪器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/nfor-denoiser-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "神经网络引擎", "NFOR时空降噪器"]
---

# NFOR时空降噪器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 神经网络引擎 / NFOR时空降噪器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/nfor-denoiser-in-unreal-engine

**NFOR降噪器** 是针对虚幻引擎[路径追踪器](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/path-tracer/index.md)的时空降噪引擎，旨在为离线路径追踪渲染提供高时间稳定性。此降噪器能创建流畅的摄像机动画，并通过GPU加速，根据周围的时间和空间斑块对每个像素进行降噪。该算法的灵感来自于论文[用于蒙特卡洛渲染降噪的非线性加权一阶回归](https://cs.dartmouth.edu/~wjarosz/publications/bitterli16nonlinearly.html)。我们利用带宽选择和散射对反射率解调辐射进行降噪处理，以保留更多细节。

NFOR降噪器非常适合搭配[影片渲染队列](https://dev.epicgames.com/documentation/404)（MRQ）进行渲染，以产出高质量的输出，但并不适用于改善极低的取样数或快速移动的物体。

> 动图已省略：1fbf09ff1c137ed8ff21710ed805a6f61617e4283e629193753913a637a6a778

## 设置NFOR降噪器

NFOR降噪器是虚幻引擎的插件，插件名为 **NFORDenoise** 。默认情况下，所有项目都启用该插件，但如果未启用，你可以在 **插件（Plugins）** 浏览器中将其启用。

### 路径追踪器要求

使用路径追踪器前，你首先必须在项目设置中启用 **支持硬件光线追踪（Support Hardware Ray Tracing）** 。

关于使用虚幻引擎路径追踪器的硬件要求，请参阅[光线追踪和路径追踪功能](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/index.md)文档的"系统要求"一节。

### 设置影片渲染图表

[影片渲染图表](https://dev.epicgames.com/documentation/404)原生支持NFOR降噪。要使用该时间降噪器，对 **Path Traced Renderer** 通道节点的部分设置进行修改即可。

选择 **Path Traced Renderer** 节点后修改 **细节（Details）** 面板的如下设置项即可：

- 找到降噪器类别，勾选 **降噪器类型（Denoiser Type）** 并将其设为 **时间（Temporal）** 。这就可以启用时间降噪器NFOR

  > [!NOTE]
  > NFOR是默认的时间降噪器，通过控制台命令 `r.PathTracing.TemporalDenoiser.Name NFOR` 进行设置。如果在下拉菜单中将降噪器类型设置为 **空间（Spatial）** ，则默认降噪器将变为英特尔的开放式图像降噪（OIDN）插件的神经网络引擎（NNE）版本。你也可以使用控制台命令 `r.PathTracing.Denoiser.Name NNEDenoiser` 来对其进行设置。
- 根据渲染需要调整 **帧数（Frame Count）** 。当与NFOR降噪一起使用时，这个数字指的是要将当前帧两端（过去和未来）的多少帧用于降噪。你可以将帧的值设为0到3之间。

  > [!NOTE]
  > 此设置仅在降噪类型为 **时间（Temporal）** 时适用。当设置为 **0** 时，NFOR将以 **空间（Spatial）** 类型运行。

查看日志输出可验证时间降噪器是否在运行。日志中显示的内容应该如下：

… LogNFORDenoise: Frame 322: Denoised NumOfHistory = 5 …

如果日志不显示这些内容，请确认你是否勾选了 **启用降噪器（Enable Denoiser）** 方框。该选项会重载后期处理体积（Post Process Volume）设置中的降噪器设置。

> [!TIP]
> 如果使用了太多的时间子样本，建议启用 **引用动态模糊（Reference Motion Blur）** 。否则，每个时间子样本都会触发降噪，从而增加不必要的帧降噪时间。此提示同样适用于影片渲染队列。

### 设置影片渲染队列

要搭配影片渲染队列使用NFOR降噪，你需要设置以下内容：

1. 将控制台变量

   r.PathTracing.SpatialDenoiser.Type

   设为

   1

   以使用时间降噪器。
2. 按需将控制台变量

   r.NFOR.FrameCount

   设置为0至3之间的值。该数值表示要将当前帧两端（过去和未来）的多少帧用于降噪。默认值为2帧。
3. 找到路径追踪（Path Tracing）类别，勾选 **后期处理体积（Post Process Volume）** 下的 **降噪器（Denoiser）** 复选框。

> [!NOTE]
> 使用影片渲染队列时，由于需要未来帧，每个镜头结束时都存在带噪点的初始帧和缺失帧。影片渲染图表路径则不存在此问题。

### NFOR杂项参数

更多可用的NFOR降噪参数如下：

- 辐射过滤（Radiance Filtering）：

  - r.NFOR.NonLocalMean.Radiance.PatchDistance

    将设置在为辐射降噪时非局部均值算法的搜索距离。搜索斑块的宽度和高度等于斑块距离乘以2再+ 1。值越大，越能提高降噪的平滑度，但会以二次方增加渲染时间。默认值为9。
  - r.NFOR.NonLocalMean.Radiance.PatchSize

    将设置非局部均值算法的大小，其中斑块的宽度和高度等于斑块大小乘以2再+ 1。默认值为3。数值越大，平滑度越高。
- 功能过滤（Feature Filtering）：

  - r.NFOR.NonLocalMean.Feature.PatchDistance

    （默认值为5）控制功能缓冲区和alpha通道的降噪强度。
  - r.NFOR.NonLocalMean.Feature.PatchSize

    （默认值为3）
- 预分割反射率率以保留细节：

  - 将

    r.NFORPredivideAlbedo.Offset

    设为

    0.1

    。对辐射度进行解调前，会为反射率添加此偏移量，以避免除以零引起的问题。这有助于在画面中保留更多的高频细节。当场景噪点过于严重时，值越大，越能提高降噪平滑度。默认值为0.1。
- NFOR帧数（NFOR Frame Count）：

  - 将

    r.NFOR.FrameCount

    设为

    2

    ，从而在使用影片渲染队列进行离线渲染时，默认以5帧作为历史记录。这5帧包括前后的各2帧，以及当前的1帧。编辑器中，针对之前单帧的降噪，帧数值将始终为0。目前你可以使用0到3之间的值。

  > [!WARNING]
  > 不得为影片渲染图表修改此参数。Path Traced Renderer节点会修改此值，使其与影片渲染图表的内部状态保持一致，以输出正确的帧渲染。

## 限制

- 降噪器无法去除萤火虫
- 降噪器需要较大的取样数量。


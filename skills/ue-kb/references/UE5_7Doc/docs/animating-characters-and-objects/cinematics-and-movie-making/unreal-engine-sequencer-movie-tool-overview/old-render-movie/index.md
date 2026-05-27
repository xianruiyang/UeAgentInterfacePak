---
title: "渲染电影设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/old-render-movie-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "渲染电影设置"]
---

# 渲染电影设置

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / 渲染电影设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/old-render-movie-in-unreal-engine

借助Sequencer，你可以视频或图像格式渲染过场动画。 你可以将场景渲染为可与他人共享的AVI视频格式，或者以BMP、EXR、JPG或PNG文件格式渲染图像。 你也可以执行"自定义渲染通道（Custom Render Passes）"来渲染"底色（Base Color）"、场景深度（Scene Depth）、"次表面颜色（Subsurface Color）"等。

渲染过场动画时，你可以使用多项**渲染影片设置（Render Movie Settings）**来定义内容的渲染方式。 本页面介绍如何访问"渲染电影设置（Render Movie Settings）"以及在此过程中可供你使用的选项。

## 渲染影片选项

要访问**渲染影片设置（Render Movie Settings）**并渲染过场动画，首先在序列中点击**渲染影片（Render Movie）**选项。

这将为你打开**渲染影片设置（Render Movie Settings）**窗口，你可以在此窗口中定义过场动画的渲染方式。

点击**捕获影片（Capture Movie）**按钮即可按照你所需的**图像输出格式（Image Output Format）**开启渲染过程。

你会在编辑器的右下角看到**正在捕获（Capturing）**状态消息。随着内容的渲染，**影片渲染 - 预览（Movie Render - Preview）**也会在整块内容上推移。 渲染完成后，你会在编辑器右下角看到**捕获完成（Capture Finished）**状态消息。 点击此状态消息中的**打开捕获文件夹（Open Capture Folder）**选项，即可打开你为渲染保存位置所设的文件位置。

> [!NOTE]
> 如需了解渲染影片的逐步示例，请参阅[渲染影片](../../cinematic-workflow-guides-and-examples/rendering-out-cinematic-movies/index.md)。

## 捕获设置

**捕获设置（Capture Settings）**分段是你定义"图像输出格式（Image Output Format）"、"音频输出格式（Audio Output Format）"、"帧率（Frame Rate）"、"分辨率（Resolution）"以及是否应用"烧入（Burn In）"的地方。

| 属性 | 说明 |
| --- | --- |
| **图像输出格式（Image Output Format）** | 用于图像数据的采集协议类型。 |
| **音频输出格式（Audio Output Format）** | 用于音频数据的采集协议类型。 |
| **帧率（Frame Rate）** | 执行采集的帧率。 |
| **分辨率（Resolution）** | 执行采集的分辨率。 |
| **使用烧入（Use Burn In）** | 是否向捕获应用[烧入（Burn In）](../../cinematic-workflow-guides-and-examples/applying-burn-ins-to-your-movie/index.md)内容（例如，场景数据、时间码和镜头试拍编号等）。 |
| **启用纹理流送（Enable Texture Streaming）** | 采集时是否应启用纹理流送（Texture Streaming）。关闭纹理流送（Texture Streaming）可能会导致使用的内存剧增，但是也将降低采集的视频中出现模糊纹理的概率。 |

### 音频输出格式

> [!WARNING]
> 由于依赖试验性的"混音器（Audio Mixer）"功能，在渲染过程中导出音频这一功能目前为试验性功能。

**音频输出格式（Audio Output Format）**会使用试验性的音频捕获实现方案，从Master Submix中捕获最终输出。 这要求使用新的"混音器（Audio Mixer）"（通过命令行参数`-audiomixer`启动），且要求序列能够被实时播放（禁用渲染时）。 如果序列求值卡顿，音频将变得不同步，因为实时的时间流逝（平台时间）要多于序列本身。

> [!NOTE]
> 选择使用此试验性的音频烘焙功能渲染过场动画时，将执行单独的通道，专门用于采集音频。 采集音频时，预览窗口中不会显示视频。

## 视频设置

选择渲染视频序列时，可用的**视频设置（Video Settings）**属性如下。

| 属性 | 说明 |
| --- | --- |
| **使用压缩（Use Compression）** | 渲染未压缩的视频还是应用压缩以缩小文件大小。 |
| **压缩质量（Compression Quality）** | 要应用的压缩级别，介于1（质量最差，压缩比最大）和100（质量最好，压缩比最小）之间。 |
| **视频编码解码器（Video Codec）** | 使你能够指定渲染过场动画时使用的特定视频编码解码器。 |

## 复合图选项

**图像输出格式（Image Output Format）**为**自定义渲染通道（Custom Render Passes）**时，可用选项如下。

| 属性 | 说明 |
| --- | --- |
| **包含渲染通道（Include Render Passes）** | 要包含在采集中的渲染通道列表。 将此字段保留为空将导出所有可用通道。 |
| **以HDR格式捕获帧（Capture Frames in HDR）** | 是否以HDR纹理格式（*.exr格式）采集帧。 |
| **HDR压缩质量（HDRCompression Quality）** | 启用**以HDR格式捕获帧（Capture Frames in HDR）**时，HDR帧的压缩质量。0代表不压缩，1代表默认压缩（可能会很慢）。 |
| **捕获色域（Capture Gamut）** | 存储HDR捕获数据且启用**以HDR格式捕获帧（Capture Frames in HDR）**时使用的颜色色域。色域取决于**HDR压缩质量（HDRCompression Quality）**的启用情况。 |
| **后期处理材质（Post Processing Material）** | 是否为渲染应用自定义[后期处理材质](../../../../designing-visuals-rendering-and-graphics/post-process-effects/post-process-materials/index.md)。 |
| **禁用屏幕百分比（Disable Screen Percentage）** | 是否在渲染过程中禁用[屏幕百分比](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/screen-percentage-with-temporal-upscale/index.md)。 |

### 包含渲染通道

渲染"自定义渲染通道（Custom Render Passes）"时，你可以渲染所有可用通道或者选择要渲染的通道。

你可以为渲染添加多个通道，每个通道都将在菜单中显示。

点击**减号**即可移除之前添加的通道。

## 图像设置

当**图像输出格式（Image Output Format）**的渲染格式为**图像序列（Image Sequence）**时，**图像设置（Image Settings）**将变得可用。

**图像序列（EXR）**

| 属性 | 说明 |
| --- | --- |
| **压缩（Compressed）** | 写出压缩还是未压缩的EXR。 |
| **捕获色域（Capture Gamut）** | 存储HDR采集的数据时使用的颜色色域。 |

**图像序列**（**JPG**或**PNG**）

| 属性 | 说明 |
| --- | --- |
| **压缩质量（Compression Quality）** | 要应用给图像的压缩级别，介于1（质量最差，压缩比最大）和100（质量最好，压缩比最小）之间。 |

## 常规设置

无论渲染输出的类型为何，以下选项都可用，具体位于**通用（General）**分段下。

| 属性 | 说明 |
| --- | --- |
| **输出目录（Output Directory）** | 将采集的文件输出至其中的目录。 |
| **文件名格式（Filename Format）** | 用于采集的文件的文件名的格式。 将自动添加扩展名。 所有格式为{token}的令牌将会被相应的数值替换。 |
| **游戏模式重载（Game Mode Override）** | 要覆盖地图的默认游戏模式的"可选游戏模式（Optional Game Mode）"。 如果游戏的常规模式显示你不希望采集的UI元素或者加载屏幕，这个属性非常有用。 |
| **覆盖现有（Overwrite Existing）** | 是否覆盖现有文件。 |
| **使用相对帧号（Use Relative Frame Numbers）** | 输出文件中的帧号是否应相对于零，而非原始动画内容中的实际帧号。 |
| **零填充帧号（Zero Pad Frame Numbers）** | 在文件名上要用零填充帧号的位数（如果为4，则填充在文件名前的为0000）。 |
| **使用单独进程（Use Separate Process）** | 是否在单独进程中采集电影，如是，将打开一个单独的编辑器版本来处理采集。 |
| **捕获开始时关闭编辑器（Close Editor when Capture Starts）** | 启用时，编辑器将在采集开始时关闭。要使用此选项，必须启用**使用单独进程（Use Separate Process）**。 |
| **额外命令行参数（Additional Command Line Arguments）** | 采集时传递给外部进程的附加命令行参数。要使用此选项，必须启用**使用单独进程（Use Separate Process）**。 |
| **继承的命令行参数（Inherited Command Line Arguments）** | 从此进程继承的命令行参数。要使用此选项，必须启用**使用单独进程（Use Separate Process）**。 |

### 文件名格式令牌

你可以为**文件名格式（Filename Format）**选项添加下列令牌来处理文件的命名规范：

| 令牌 | 说明 |
| --- | --- |
| **{fps}** | 采集的帧率。 |
| **{frame}** | 当前帧号（只与图像序列相关）。 |
| **{width}** | 采集的帧的宽度。 |
| **{height}** | 采集的帧的高度。 |
| **{world}** | 当前世界场景的名称。 |
| **{quality}** | 图像压缩质量设置。 |
| **{material}** | 材质/渲染通道。 |
| **{shot}** | 播放的关卡序列资产镜头的名称。 |
| **{camera}** | 当前摄像机的名称。 |

## 序列设置

**序列（Sequence）**分段为渲染过程提供以下选项。

| 属性 | 说明 |
| --- | --- |
| **写入编辑决策列表（Write Edit Decision List）** | 如果序列包含镜头，是否写入编辑决策列表（EDL）。如需更多信息，请参阅[导入和导出编辑决策列表](../../cinematic-workflow-guides-and-examples/import-and-export-edl/index.md)页面。 |
| **写入Final Cut Pro XML（Write Final Cut Pro XML）** | 如果序列包含镜头，是否写入Final Cut Pro XML文件（XML）。 |
| **处理帧（Handle Frames）** | 要为每个镜头包含的"帧余量（Frame Handles）"。 这些额外帧填充每个镜头，由EDL（或XML）文件插入和抠去，此类文件可在外部视频编辑软件包中用来调整镜头之间的切换。 |

## 过场动画设置

可使用下列设置来定义采集时过场动画的播放方式。

| 属性 | 说明 |
| --- | --- |
| **过场动画引擎可伸缩性（Cinematic Engine Scalability）** | 是否启用"过场动画引擎可延展性"设置。 |
| **过场动画模式（Cinematic Mode）** | 采集时是否启用"过场动画模式（Cinematic Mode）"。 |
| **允许移动（Allow Movement）** | 采集时是否允许播放器移动。要求启用**过场动画模式（Cinematic Mode）**。 |
| **允许旋转（Allow Turning）** | 采集时是否允许播放器旋转。要求启用**过场动画模式（Cinematic Mode）**。 |
| **显示播放器（Show Player）** | 采集时是否显示本地播放器。要求启用**过场动画模式（Cinematic Mode）**。 |
| **显示HUD（Show HUD）** | 采集时是否显示游戏内HUD。 此设置不适用基于UMG的HUD元素，且会引用基于HUD类的蓝图。要求启用**过场动画模式（Cinematic Mode）**。 |

## 动画设置

下列选项定义了捕获时使用的**动画（Animation）**设置：

| 属性 | 说明 |
| --- | --- |
| **使用自定义开始帧（Use Custom Start Frame）** | 启用时，"起始帧（Start Frame）"设置将覆盖默认起始帧号。 |
| **开始帧（Start Frame）** | 时间字段，格式为时间码、帧和秒。启用**使用自定义开始帧（Use Custom Start Frame）**时，使用此值。 |
| **使用自定义结束帧（Use Custom End Frame）** | 启用时，"结束帧（End Frame）"设置将覆盖默认结束帧号。 |
| **结束帧（End Frame）** | 时间字段，格式为时间码、帧和秒。启用**使用自定义结束帧（Use Custom End Frame）**时，使用此值。 |
| **预热帧数（Warm Up Frame Count）** | 在序列的"起始帧（Start Frame）"前播放以"预热"动画的额外帧数。 如果动画中包含粒子或其他早于采集"起始帧（Start Frame）"生成到场景中的运行时效果，此属性非常有用。 |
| **预热前延迟（Delay Before Warm Up）** | 开始播放预热帧前等待的秒数（实时）。这有助于使后期处理效果在采集动画前稳定下来。 |
| **镜头预热前延迟（Delay Before Shot Warm Up）** | 在镜头边界处等待的秒数（实时）。这有助于使后期处理效果在采集动画前稳定下来。 |

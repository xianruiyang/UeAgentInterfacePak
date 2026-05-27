---
title: "导出格式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematic-rendering-export-formats-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "渲染设置与格式", "导出格式"]
---

# 导出格式

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 渲染设置与格式 / 导出格式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematic-rendering-export-formats-in-unreal-engine

**影片渲染队列（Movie Render Queue）** 支持使用各种输出格式渲染到图像或影片，并且能够同时输出不同的格式。

#### 先决条件

- 你已完成

  页面中"影片渲染队列"一节的先决条件步骤。

你可以在影片渲染队列的 **设置（Settings）** 窗口中选择要渲染的格式，方法是点击 **+ 设置（+ Setting）** 下拉菜单，然后从 **导出（Export）** 类别选择格式。 渲染导出格式

你可以像对其他设置那样启用和禁用输出格式，方法是点击文本旁边的启用按钮。你还可以将其选中以编辑属性（如果可用）。

以下输出格式可用：

| 名称 | 说明 |
| --- | --- |
| [**命令行编码器（Command Line Encoder）**](#%E5%91%BD%E4%BB%A4%E8%A1%8C%E7%BC%96%E7%A0%81%E5%99%A8) | 命令行编码器可用于从第三方软件（如FFmpeg）创建你自己的输出格式。此设置需要在你的"项目设置"中启用编码器可执行文件和设置。 |
| [**Final Cut Pro XML**](#finalcutproxml) | Final Cut Pro XML格式将输出XML文件，该文件可由Final Cut Pro和支持此格式的其他视频编辑软件读取。这在发行版本中不受支持。 |
| **.bmp序列[8位]（.bmp Sequence [8bit]）** | 将影片输出为.bmp图像序列。像素值范围为[0-1]，这意味着不会保留HDR值。这会应用sRGB编码曲线。 |
| [**EXR序列（EXR Sequence）**](#exr%E5%BA%8F%E5%88%97) | 将影片输出为.exr图像序列。HDR值会保留，但若启用色调曲线（Tone Curve），则线性值将调整到大约[0-1]的范围，仅最亮的高光超过1。禁用色调曲线（Tone Curve）会写入[0-100]范围或更大范围的线性值，具体取决于光源和其他明亮物体的强度。没有sRGB编码曲线应用于.exr目标。 |
| **.jpg序列[8位]（.jpg Sequence [8bit]）** | 将影片输出为.jpg图像序列。应用sRGB编码曲线。 |
| **.png序列[8位]（.png Sequence [8bit]）** | 将影片输出为.png图像序列。应用sRGB编码曲线。启用"在后期处理中启用Alpha通道支持（Enable Alpha Channel Support in Post Processing）"项目设置，即可支持透明度。 |
| [**WAV音频（WAV Audio）**](#wav%E9%9F%B3%E9%A2%91) | 输出.wav音频文件以及你选择的其他输出格式。 |
| [**Apple ProRes视频编码解码器（Apple ProRes Video Codecs）**](#appleprores%E8%A7%86%E9%A2%91%E7%BC%96%E7%A0%81%E8%A7%A3%E7%A0%81%E5%99%A8) | 使用Apple的高质量有损视频压缩编码解码器Apple ProRes输出.mov文件。这需要启用Apple ProRes Media插件。 |
| [**Avid DNx视频编码解码器（Avid DNx Video Codecs）**](#aviddnx%E8%A7%86%E9%A2%91%E7%BC%96%E7%A0%81%E8%A7%A3%E7%A0%81%E5%99%A8) | 使用高清有损视频编码解码器Avid DNx输出影片文件。这需要启用Avid DNxHR/DNxMXF Media插件。 |
| **预流送录制器（Prestreaming Recorder）** | 预流送录制器用于使用 **虚拟纹理（Virtual Textures）** 或 **Nanite** 为过场动画创建渲染缓存。 |

## 命令行编码器

命令行编码器可用于从第三方软件（如FFmpeg）创建你自己的输出格式。要使用命令行编码器，你必须找到 **影片管线CLI编码器（Movie Pipeline CLI Encoder）** 项目设置，以设置特定属性和设置。

如果你使用命令行编码器，必须同时使用一种图像序列导出格式，以便能够从这些图像创建影片帧。如果要包含音频，你还必须包含 **.wav音频（.wav Audio）** 导出。

![命令行编码器导出](../../../../../../assets/images/cb/cb16abae27e69249d057080c1bd465b304eb6e12ce5ae34ffeb7a803810a7a7a.png)

### 导出细节

选择命令行编码器将公开以下细节：

![命令行编码器属性](../../../../../../assets/images/44/44910b30ec44c2332b0eb7f91d539b1fd259b2394c0b2114609b7db6b7e86723.png)

| 细节名称 | 说明 |
| --- | --- |
| **文件名格式覆盖（File Name Format Override）** | 针对命令行编码器输出的影片，覆盖 **输出（Output）** 设置中的 **文件名格式（File Name Format）**。如果你要将图像序列渲染到单独的镜头文件夹，你可以使用此项生成单个主影片文件，而不是单独的镜头影片文件。 |
| **质量（Quality）** | 使用哪种编码质量设置。这些可以在 **影片管线CLI编码器（Movie Pipeline CLI Encoder）** 项目设置中定义。 |
| **额外命令行参数（Additional Command Line Args）** | 要为此作业传递到编码器的额外命令行参数。 |
| **删除源文件（Delete Source Files）** | 如果启用此项，将在完成影片编码后删除源图像序列文件。这将导致仅导出影片，而不导出源图像。 |
| **渲染取消时跳过编码（Skip Encode on Render Canceled）** | 如果启用此项，在提前取消渲染时，编码器将不会尝试对所渲染的帧编码。 |
| **写入每帧时长（Write Each Frame Duration）** | 将每帧时长写入生成的纹理文件中。一些CLI编码软件上的一些输入类型需要该值。 |

### 项目设置

你需要设置特定项目设置，才能使用命令行编码器。

点击 **编辑（Edit）> 项目设置（Project Settings）** 以打开项目设置窗口，然后找到 **插件（Plugins）** 类别中的 **影片管线CLI编码器（Movie Pipeline CLI Encoder）**。

![命令行编码器项目设置](../../../../../../assets/images/3f/3fc9067e930d34652c432c76e3d228d2b722ee11af3d61405625afb020b022ac.png)

| 细节名称 | 说明 |
| --- | --- |
| **可执行文件路径（Executable Path）** | 编码器可执行文件的路径，包括可执行文件名。 可以为直接路径，例如 `‪D:\\ffmpeg\\bin\\ffmpeg.exe`。 如果你在 **Windows环境变量（Windows Environment Variables）** 中指定了编码器的路径，也可以仅指定编码器可执行文件。 |
| **编码解码器帮助文本（Codec Help Text）** | 你的项目的文本，用于粘贴到虚幻的控制台窗口，为你的编码器生成有效音频和视频编码解码器列表。需要在命令查询可执行文件时首先设置 **可执行文件路径（Executable Path）**。 |
| **视频编码解码器（Video Codec）** | 在这里指定视频编码解码器。如果使用FFmpeg，可以在虚幻的 **输出日志（Output Log）** 窗口中执行 **MovieRenderPipeline.DumpCLIEncoderCodecs**，查看编码解码器列表。 |
| **音频编码解码器（Audio Codec）** | 在这里指定音频编码解码器。如果使用FFmpeg，可以在虚幻的 **输出日志（Output Log）** 窗口中执行 **MovieRenderPipeline.DumpCLIEncoderCodecs**，查看编码解码器列表。如果命令行中指定了-acodec {AudioCodec}，则必须指定音频编码解码器。 |
| **输出文件扩展名（Output File Extension）** | 输出文件的扩展名，不应包含点号，如 **mp4**、**mkv** 或 **webm**。某些编码解码器支持不同的容器，你应该确保将正确的容器用于你的编码解码器。 |
| **命令行格式（Command Line Format）** | 在构建要启动的最终命令行参数时要使用的格式字符串。使用 `{tokens}` 插入你的项目设置或命令行编码器中的参数。 `{AdditionalLocalArgs}`：在这里插入命令行编码器细节中的"额外命令行参数（Additional Command Line Args）"属性中的参数。 `{VideoInputs}`：在这里插入"视频输入字符串格式（Video Input String Format）"项目设置中的参数。 `{AudioInputs}`：在这里插入"音频输入字符串格式（Audio Input String Format）"项目设置中的参数。 `{AudioCodec}`：在这里插入"音频编码解码器（Audio Codec）"项目设置中的参数。 `{VideoCodec}`：在这里插入"视频编码解码器（Video Codec）"项目设置中的参数。 `{Quality}`：在这里插入命令行编码器细节中"质量（Quality）** 属性中的参数，该属性由"编码设置（Encode Settings）"项目设置定义。 `{OutputPath}`：在这里插入影片渲染队列的输出细节中"输出目录（Output Directory）"属性中的参数。 |
| **视频输入字符串格式（Video Input String Format）** | 在构建视频输入参数时要使用的格式字符串。使用 `{tokens}` 插入你的图像序列中的参数。 `{InputFile}`：当你的渲染正在发生时，将创建临时文本文件，逐项列出序列中渲染的每个帧。此标记将引用该文件，以便查找相应的帧来生成视频。默认情况下，此文本文件会在编码完成后自动删除。你可以从"调试选项（Debug Options）"设置启用"写入所有示例（Write All Samples）"属性，以保留此文本文件。 `{FrameRate}`：关卡序列中的帧率，或者在从作业输出启用了"使用自定义帧率（Use Custom Frame Rate）"时，为输出帧率。 |
| **音频输入字符串格式（Audio Input String Format）** | 在构建音频输入参数时要使用的格式字符串。使用 `{tokens}` 插入你的.wav文件输出中的参数。 `{InputFile}`：当你的渲染正在发生时，将创建临时文本文件，逐项列出创建的音频。此标记将引用该文件，以便查找要添加到视频的音频。你可以从"调试选项（Debug Options）"设置启用"写入所有示例（Write All Samples）"属性，以保存此文本文件。 |
| **编码设置低（Encode Settings Low）** | 在命令行编码器细节中的 **质量（Quality）** 属性中指定 **低（Low）** 时要使用的编码参数。 |
| **编码设置中（Encode Settings Med）** | 在命令行编码器细节中的 **质量（Quality）** 属性中指定 **中（Med）** 时要使用的编码参数。 |
| **编码设置高（Encode Settings High）** | 在命令行编码器细节中的 **质量（Quality）** 属性中指定 **高（High）** 时要使用的编码参数。 |
| **编码设置史诗（Encode Settings Epic）** | 在命令行编码器细节中的 **质量（Quality）** 属性中指定 **史诗（Epic）** 时要使用的编码参数。 |

> [!NOTE]
> 你可能需要根据使用的编码解码器选择不同的"编码设置（Encode Settings）"。对于你可能用于FFmpeg的最常见编码解码器，默认值被视为典型设置。命令行编码器仅支持单程编码。你可以参阅 **[FFmpeg编码解码器文档（FFmpeg Codec Documentation）](https://ffmpeg.org/ffmpeg-codecs.html)** ，了解有关编码解码器及其编码设置的更多信息。

### 示例设置

下面显示的示例说明了要设置编码器以将ffmpeg用于开放格式VP9编码解码器时，你可以使用哪些细节和项目设置。

这里你可以看到，**命令行编码器（Command Line Encoder）** 随 **.jpg序列（.jpg Sequence）** 和 **.wav音频（.wav Audio）** 一起导出。

![命令行编码器导出](../../../../../../assets/images/ce/ceb6d7dddb5ed089247e33867ebbdf48f6fde598228a548fc2addc79fe652115.png)

在"项目设置（Project Settings）"中，高亮显示的属性是为了支持编码解码器而从默认值变更的唯一属性。如果你不导出.wav音频通道，则不需要指定音频编码解码器。

![命令行编码器项目设置](../../../../../../assets/images/cd/cde60ad055c7574ddd0b090fe20e673cd59344bc7310f442165eff880f862096.png)

- 视频编码解码器：

  libvpx-vp9
- 音频编码解码器：

  libvorbis
- 输出文件扩展名：

  mkv
- 编码设置低：

  -crf 28 -b:v 0
- 编码设置中：

  -crf 23 -b:v 0
- 编码设置高：

  -crf 20 -b:v 0
- 编码设置史诗：

  -crf 16 -b:v 0

## EXR序列

虚幻支持.exr图像序列作为影片渲染队列的输出格式。这些图像序列与各种视觉效果包兼容，包括Nuke、Tweak RV、IfranView和带ProEXR插件的Adobe Premiere。

![EXR导出细节](../../../../../../assets/images/59/594f92188e84b12d6a422f6f3a2f5cf45ccc189ef68682e9b09de78aa5632cf6.png)

EXR输出目前支持以下压缩设置：

| EXR | 说明 |
| --- | --- |
| **无（None）** | 不对.exr序列的渲染输出应用压缩。 |
| **PIZ** | 一种无损压缩格式，可提供优质的颗粒状图像。 |
| **ZIP** | 一种无损压缩格式，可提供优质的低噪点图像。 |

虚幻还支持使用 **多层（Multilayer）**.exr输出。如果启用多个不同的 ，其中每一个都将嵌入到你的.exr序列中，并且全都可在外部视觉效果编辑程序中访问。

并非所有软件都支持多层.exr文件。在此类情况下，它们仅在你加载.exr时才显示默认RGBA通道。如果你使用的程序不支持多层.exr，你可以取消选中 **多层（Multilayer）** 设置，将每个层写出为单独的.exr文件。

## Apple ProRes视频编码解码器

Apple ProRes是Apple的高质量有损视频压缩格式，用于后期制作和视觉效果，支持高达8k的视频。

必须启用插件才能使用。在虚幻引擎菜单中前往 **编辑（Edit）> 插件（Plugins）**，在 **媒体播放器（Media Players）** 分段中找到 **Apple ProRes Media**，然后将其启用。稍后你需要重启编辑器。 Apple ProRes插件

**Apple ProRes[10-12位]（Apple ProRes [10-12bit]）** 现在将在 **设置（Settings）** 菜单中提供。选择此输出格式时，你的渲染将使用多个编码解码器的其中一个输出视频文件，每个编码解码器提供不同的压缩级别和质量。视频容器将为 **.mov**。

![渲染Apple ProRes细节](../../../../../../assets/images/a6/a61f11e8f8741c82162f048735a491ef1b1effcd4034d8a5e5eb2f748639ad26.png)

点击 **编码解码器（Codec）** 下拉菜单，为输出视频文件选择所需的编码解码器。以下编解码器可用：

| 编码解码器 | 像素深度 | 1080p和30 fps的估算比特率 | 说明 |
| --- | --- | --- | --- |
| **Apple ProRes 422 Proxy** | 10位 | 45 mbps | 最高压缩率。适用于需要低数据率但全分辨率的视频的离线工作流程。 |
| **Apple ProRes 422 LT** | 10位 | 100 mbps | Apple ProRes 422的更高压缩率版本，文件大小约缩减30%。适用于存储和数据速率有限的环境。 |
| **Apple ProRes 422** | 10位 | 150 mbps | 全宽4:2:2视频源的高质量压缩。适用于多流实时编辑。 |
| **Apple ProRes 422 HQ** | 10位 | 220 mbps | Apple ProRes 422的更高比特率版本。提供与ProRes 4444相同的质量水平，但适用于4:2:2视频源。 |
| **Apple ProRes 4444** | 12 bit | 330 mbps | 4:4:4:4图像源的高质量压缩格式。提供超高质量的图像，并支持alpha通道。输出文件很大。 |
| **Apple ProRes 4444 XQ** | 12位 | 500 mbps | 最高质量的存储，并支持alpha通道。对于RGB通道，精度为12位，对于alpha通道，精度为16位。输出文件极大。 |

有关每个编码解码器的更多信息，请参阅 **[Apple关于Apple ProRes的文档](https://support.apple.com/en-us/HT202410)**。

**丢帧时间码（Drop Frame Timecode）** 设置将时间码轨道设置为使用丢帧格式。此设置仅在序列的帧率为29.97时才适用。

如果启用 **覆盖最大编码线程（Override Maximum Encoding Threads）**，你可以将 **编码线程最大数量（Max Number of Encoding Threads）** 设置为手动数量。这将设置允许编解码器在视频文件编码过程中使用的最大CPU线程数。使用更多线程可加快编码速度，但会导致更高的CPU使用率。

> [!NOTE]
> Apple ProRes不会导出音频。添加 **.wav音频（.wav Audio）** 导出设置，以随你的视频输出单独的.wav文件，这样你可以在后期制片中加以组合。

## Avid DNx视频编码解码器

Avid DNxHR和DNxMXF是Avid的高清有损视频编解码器，适用于后期制作，支持高达8k的视频。

必须启用插件才能使用。在虚幻引擎菜单中前往 **编辑（Edit）> 插件（Plugins）**，在 **媒体播放器（Media Players）** 分段中找到 **Avid DNxHR/DNxMXF Media 插件（Avid DNxHR/DNxMXF Media Plugin）**，然后将其启用。稍后你需要重启编辑器。

![Avid DNx插件](../../../../../../assets/images/e0/e0c0a58bddbe806724126b9076916085c7ce01c4f33ad8b85272e23bb867e015.png)

**Avid DNx[8位]（Avid DNx [8bit]）** 现在将作为输出设置提供。当你选择此设置时，它会使用Avid的DNx编码解码器将你的影片输出为视频文件。视频容器将为 **.mxf**。

> 图片已省略：渲染Avid DNx细节

启用 **使用压缩（Use Compression）** 会输出有损的压缩文件，而禁用此设置将输出无损的未压缩文件。你可以更改 **编码线程数（Number of Encoding Threads）**，以控制编解码器用于编码的CPU线程数量。线程数量越多，文件编码时间越短，但CPU使用率也会更高。

请参阅 **[Avid关于DNx视频编码解码器的文档](https://www.avid.com/products/avid-high-resolution-workflows)**，了解关于此编码解码器及其规格的更多信息。

> [!NOTE]
> Avid DNx不会导出音频。添加 **.wav音频（.wav Audio）** 导出设置，以随你的视频输出单独的.wav文件，这样你可以在后期制片中加以组合。无论是什么编解码器，目前Avid DNx仅支持8位精度。

## Final Cut Pro XML

Final Cut Pro XML格式将输出XML文件，该文件可由Final Cut Pro和支持此格式的其他视频编辑器读取。你也需要像操作命令行编码器的那样，随此导出格式指定一个伴随的图像序列或视频文件输出。

> 图片已省略：渲染XML细节

使用 **文件名格式覆盖（File Name Format Override）** 字段，可为输出文件的名称指定一个 **{token}**。这些标记将基于你的 **输出（Output）** 设置中的标记。

**数据源（Data Source）** 下拉菜单将指定用于编译Final Cut Pro XML文件的方法，该方法转而又决定了文件中内嵌的数据以及数据的编写格式。

| 数据源 | 说明 |
| --- | --- |
| **输出元数据（Output Metadata）** | 基于实际写入磁盘的文件构建XML文件，而不是基于原始关卡序列数据。这将支持时间膨胀轨道（将导致镜头的帧数多于/少于Sequencer中的实际镜头分段），而不支持以后重新导回到Sequencer。 |
| **序列数据（Sequence Data）** | 直接用序列数据构建XML文件。主要用于重新导入。 |

> [!NOTE]
> 仅支持Final Cut XML作为虚幻编辑器的输出格式。它不可用于发行版本，因为它依赖于仅限编辑器的功能。

## WAV音频

无需其他渲染通道就可以导出序列的.wav音频。这可使你输出影片的音频，并在后期制作中将其与你的图像序列结合起来。

> 图片已省略：导出wav音频细节

使用 **文件名格式覆盖（File Name Format Override）** 字段可覆盖所导出.wav文件的 **输出（Output）** 设置中的 **文件名格式（File Name Format）**。

> [!NOTE]
> WAV音频输出格式仅是试验性的，不可用于产品。因为影片渲染器在预热帧的镜头之间运行引擎，所以不受Sequencer控制的音频在镜头之间会产生缺口。此外，在镜头之间，Sequencer中的音频剪辑可能有轻微的音频失真。

## 自定义输入格式

你可以自己创建格式，方法是实现 **UMoviePipelineOutputBase** 类。它会为每个输出帧提供一个回调，包含帧中渲染的所有渲染通道（例如烧录、UI控件和最终图像）。通过在项目代码中实现该类，它会自动显示在设置菜单中供使用。你需要针对 MovieRenderPipelineCore 模块进行链接。

如果你想确保该输出格式添加到所有新建的任务中，你可以调整影片渲染通道项目设置中的 **默认任务设置类（Default Job Setting Classes）**。

## 预流送录制器

只有在启用了 **过场动画预流送（Cinematic Prestreaming）** [插件](../../../../../understanding-the-basics/foundational-knowledge-in/working-with-plugins/index.md)后，你才能使用预流送录制器选项。它可以使用[虚拟纹理](../../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/index.md)和[Nanite](https://dev.epicgames.com/documentation/404)为过场动画创建渲染缓存。

由于虚拟纹理和Nanite流送其数据的方式，你必须首先使用 **预流送录制器（Prestreaming Recorder）** 渲染，构建缓存以供过场动画预流送系统解译。此缓存会自动保存并在所渲染的序列中被引用。有了该缓存，Sequencer将使用此数据向虚拟纹理和Nanite系统提前告知一个帧需要哪些内容，这样在渲染该帧时，GPU上就已经有所需数据。如果没有该缓存，Nanite和虚拟纹理在显示和达到目标质量之间会有延迟，可能导致过场动画中的纹理和几何体的分辨率或质量降低。

> [!NOTE]
> 构建预流送缓存并不仅仅适用于MRQ渲染。过场动画预流送轨道及其数据缓存还可以向流送告知实时序列中的虚拟纹理。这需要你的实时过场动画大体上是确定性的，因为缓存仅包含那时渲染的内容的数据。当缓存没有数据可用时，这些系统中常见的常规运行时延迟将重新出现。

预流送录制器包含以下属性：

| 数据源 | 说明 |
| --- | --- |
| **包目录（Package Directory）** | 用于保存过场动画预流送数据缓存的目录（与项目根文件夹相关）。它必须以 `/Game/` 开头，并且还可以使用普通[格式字符串](../cinematic-rendering-image-bb951eea/index.md#%E6%A0%BC%E5%BC%8F%E5%AD%97%E7%AC%A6%E4%B8%B2%E4%BF%A1%E6%81%AF)。 |
| **虚拟纹理（Virtual Textures）** | 允许捕获虚拟纹理页面请求。禁用此项将无法收集虚拟纹理信息来构建过场动画预流送缓存。 |
| **Nanite** | 允许捕获Nanite请求。禁用此项将无法收集Nanite信息来构建过场动画预流送缓存。 |
| **修改目标序列（Modify Target Sequence）** | 允许过场动画预流送录制器在渲染完成后将缓存播放数据自动添加到关卡序列。 |
| **禁用提前渲染功能（Disable Advance Render Features）** | 启用后，将禁用多个渲染功能，例如光照、后期处理、反射。禁用这些可能会加快渲染速度，但会导致实际输出的渲染图像非常粗糙、无法使用。 启用此项会很有用，因为预流送录制器的主要用途就是构建 **过场动画预流送缓存** ，而不是渲染。 |

> [!NOTE]
> Nanite和虚拟纹理都依赖屏幕分辨率，这意味着你必须使用预流送录制器根据目标分辨率来渲染过场动画，才能生成准确的缓存数据。如果你的内容大幅更改，例如变换对象、编辑材质或其他更改，那么就需要重新渲染。

你还可以添加[VT待处理Mip（调试）](https://dev.epicgames.com/documentation/404)渲染通道，将更多帧导出到输出目录。这些帧可被用于调试虚拟纹理Mip信息。

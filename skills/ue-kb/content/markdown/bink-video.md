# 虚幻引擎中的Bink Video

---
title: "虚幻引擎中的Bink Video"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/bink-video-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "虚幻引擎中的Bink Video"]
---

# 虚幻引擎中的Bink Video

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 虚幻引擎中的Bink Video

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/bink-video-for-unreal-engine

虚幻引擎4.27+中内置 **Bink Media** 插件。所有虚幻引擎平台都受到支持（包括NDA平台）。

## 安装

1. 在编辑器中选择 **编辑（Edit）> 插件（Plugins）**，搜索 **Bink**，然后启用插件。按需重新启动虚幻引擎。

   ![The Bink Media plugin](../../../../assets/images/d5/d5cafd9ce4f545928333d16e77c9618ec8afb1a99f95a6b75c005d322e6c15f8.jpg)

   点击查看大图
2. 将Bink视频文件复制到虚幻引擎项目目录中的 **Contents/Movies** 目录。

   > [!NOTE]
   > 你可以使用 `Engine/Binaries/ThirdParty/Bink` 目录（Bink2ForUnreal.exe）中的 **虚幻引擎的Bink 2编码器** 创建Bink文件。 双击可执行文件，然后选择要转换的视频文件，然后点击 **Bink it！**，然后点击 **Bink**。对于大多数用例，自动设置将运行正常。
   >
   > ![虚幻的Bink 2编码器](../../../../assets/images/3d/3dc9fb9516b5d2d24145e72fee9c1b41d125aed671553e511b1ef8c1e6eee0a1.png)
3. 双击项目的 `.uproject` 文件，界面上会出现警告对话框，询问你是否因为缺少插件而要重新构建项目。确认执行重新构建，虚幻引擎重新启动并加载项目。
4. 现在你可以播放Content/Movies目录中的Bink文件。

## 虚幻引擎Bink的视频类型

虚幻引擎有两种不同类型的视频：全屏开场视频和游戏内非开场视频。每种类型的使用方式略有不同，如下所述。

### 全屏开场视频设置

首先，你需要禁用所有其他视频播放器插件。否则，所有已启用的MPEG-4播放器都会尝试播放Bink视频文件，但会失败且无提示。

为此，前往 **编辑（Edit）> 插件（Plugins）**：

![Disable other movie players](../../../../assets/images/33/33e6008b0d332a365580d2e3f0dfa14d2d45bda650a2bfb05e74db869d854901.jpg)

点击查看大图

禁用除Bink Media插件之外的所有视频播放器插件。

其次，你需要配置一些视频，在启动时播放。

前往 **编辑（Edit）> 项目设置（Project Settings）**

![Project Settings for startup movies](../../../../assets/images/00/0023b09cf135ee62b2622e2cd5d26865f17639759f700a597c45aee7be416286.png)

点击查看大图

点击 **开场视频（Startup Movies）** 旁边的 **+** 按钮，然后展开列表显示视频。你可以按顺序播放多段视频。然后，点击 **...** 按钮选择要播放的文件。

前往 **编辑（Edit）> 项目设置（Project Settings）> Bink动画（Bink Movies）** 查看Bink特有的选项。

![Bink specific options](../../../../assets/images/33/335169c418d823b90ac86ab251ec1f5684146b9d0bcd71041e17f5ca95d849bf.png)

点击查看大图

以下是一些Bink专用选项：

1. **Bink缓冲模式：** 控制你是要从磁盘流送一部分视频，在播放前预加载整段视频，还是在整段视频加载后才开始流送。
2. **Bink音轨：** 决定了你要如何播放声音。选项有多个：

   1. **SndNone：** 不在此Bink中播放声音。
   2. **Snd Simple：** 默认值。此选项会尝试根据Bink文件的文件名找出你想要的内容。

      - 如果文件名以 `_51` 结尾，则使用 **Snd 51** 选项。
      - 如果文件名以 `_51L` 结尾，则使用 **Snd 51语言覆盖（Snd 51 Language Override）** 选项。
      - 如果文件名以 `_71` 结尾，则使用 **Snd 71** 选项。
      - 如果文件名以 `_71L` 结尾，则使用 **Snd 71语言覆盖（Snd 71 Language Override）** 选项。

      否则，它会播放由 **音轨起始（Sound Track Start）** 值指定的Bink轨道（默认是轨道0）
   3. **Snd语言覆盖**：此选项将播放两个轨道。

      - 轨道0中的音频，通常是背景音乐/效果。
      - **音轨起始（Sound Track Start）** 值指定的轨道，通常是语言轨道。
   4. **Snd 51**：此选项将从 **音轨偏移（Sound Track Offset）** 值（默认为0）指定的轨道开始播放六个单声道轨道到系统中。因此，如果你已经完全本地化四种语言的5.1轨道，你将混合二十四个Bink轨道，并使用 **音轨偏移（Sound Track Offset）** 设置来指定要播放的正确音轨范围。
   5. **Snd 51语言覆盖**：此选项将从偏移量0开始播放六个单声道背景/效果轨道，然后由 **音轨起始（Sound Track Start）** 值指定的一个单声道轨道作为语言轨道进入中央声道。因此，对于此处的四种语言，你将有十个音轨、5.1 背景音乐/效果轨道以及四个不同的中心语言轨道。
   6. **Snd 71**：此选项将从 **音轨偏移（Sound Track Offset）** 值（默认为0）指定的轨道开始播放八个单声道轨道到系统中。因此，如果你已经完全本地化四种语言的7.1轨道，你将混合二十八个Bink轨道，并使用 **音轨偏移（Sound Track Offset）** 设置来指定要播放的正确音轨范围。
   7. **Snd 71语言覆盖：** 此选项将从偏移量0开始播放八个单声道背景/效果轨道，然后由 **音轨起始（Sound Track Start）** 值指定的一个单声道轨道作为语言轨道进入中央声道。因此，对于此处的四种语言，你将有十二个音轨、7.1 背景音乐/效果轨道以及四个不同的中心语言轨道。
3. **Bink音轨起始：** 一段Bink视频可以包含多个不同的音轨。你可以使用此选项指定要播放的音轨。
4. **Bink目的地左上/右下** 可指定视频要渲染到的矩形。例如，你可以使用它来强制使用上下黑边。

# 游戏内（非开场）视频设置

你还可以在游戏关卡本身期间渲染视频。你可以直接渲染到纹理，然后在游戏中使用该纹理，你也可以直接渲染到屏幕。Bink在所有图形之后UI之前渲染，因此你可以在视频画面上绘制字幕。

为此，请右键点击 **内容浏览器（Content Browser）**，然后在 **杂项（Miscellaneous）** 分段下添加新的 **Bink Media播放器（Bink Media Player）**。

![创建新的Bink Media播放器](../../../../assets/images/bc/bc84751d87cfff969479e2ec2ef744495a7ced6601ce9a4107c795ebea9a3524.jpg)

![A Bink Media Player](../../../../assets/images/19/19dcdbf8f3ecf6e5499039a6784bb4d88cdbfb7b1ea853a5699dc769016e5a2d.jpg)

点击查看大图

Bink的专用配置选项是：

1. **Bink缓冲模式** 可控制你是要从磁盘流送一部分视频，在播放前预加载整段视频，还是在整段视频加载完前不停止流送。
2. **Bink音轨** 决定了你要如何播放声音。从简单的立体声到7.1环绕声，选择多种多样。
3. **Bink音轨起始** 一段Bink视频可以包含多个不同的音轨。你可以使用此选项指定要播放的音轨。
4. **Bink绘制风格** 你可以用来覆盖渲染到纹理的默认UE5功能，而不是绕过UE4渲染直接渲染到屏幕。
5. **Bink目的地左上/右下** 可指定视频要渲染到的矩形。例如，你可以使用它来强制使用上下黑边。
6. **Bink图层深度（Bink Layer Depth）** 允许你同时渲染多个视频，并设置深度，控制视频的绘制顺序。

> [!NOTE]
> Bink视频文件(`*.bk2`)应该放在(ProjectName)/Content/Movies文件夹中，其中(ProjectName)是项目名称。这样可确保在所有配置中正确地将视频复制到最终的构建中。

右键点击 **内容浏览器（Content Browser）** 中的 **BinkMediaPlayer**，然后选择 **创建媒体纹理（Create Media Texture）**，从播放器生成纹理。然后，你可以右键点击 **内容浏览器（Content Browser）** 中的 `BinkMediaPlayer_Tex` 纹理，并选择 **创建材质（Create Material）**，以便使用此纹理创建默认材质。你可以像在虚幻引擎中使用任何其他材质或纹理一样使用此材质和纹理。

## 虚幻中Bink的其他说明

### 多线程解码

虚幻引擎的Bink Media插件本身支持多线程解码。它在解压期间最多可以使用四个线程，具体取决于运行时CPU计数。

默认情况下，虚幻引擎的Bink 2编码器使用四个视频切片，以便获得最佳多线程性能。

### 搜索

你可以直接调用Bink插件函数 `BinkPluginGoto`，从而设置新的播放位置。通常，你会需要跳转到关键帧，否则就要一路解压所有中间帧（Bink插件会在后台为你执行此操作）。你可以使用 `ms_per_process` 参数控制CPU Bink每帧花费多少时间寻找新帧。通常每帧使用30毫秒左右时，搜索会相对较快。

### 视频深度（绘制期间排序）

如果你使用非开场视频选项绘制大量视频覆层，你可以使用 **深度（Depth）** 选项控制覆层的绘制顺序。无论虚幻引擎处理视频的顺序如何，都能让你的视频正确堆叠。

对于渲染目标，**深度（Depth）** 可控制将视频绘制到渲染目标中的顺序，但渲染目标通常由虚幻引擎绘制到场景中。

### 字幕

支持基于[Subrip](https://en.wikipedia.org/wiki/SubRip) .srt 文件格式的字幕。

如需使用srt文件，请将其与 **Bink 2 Video bk2** 文件放在同一目录下。用以下格式命名该文件："`<name of Bink2 video file>_<language<.srt`."。该文件应包含所需语言的字幕。

例如，如果你有一个 "**Movies/example.bk2**" 文件，你需要准备一个 "**Movies/example_en.srt**" 文件在旁边，其中包含英语字幕。

### 立体视频

Bink的运行速度足以处理3D视频。为此，请使用渲染目标路径，然后绘制到屏幕对齐的四边形。对于每只眼睛，调整四边形，以便用四边形的上半部分或视频的下半部分填充屏幕。

### Bink插件API

Bink插件API也有许多其他功能按钮。当你需要自定义功能按钮（例如搜索、暂停等）时，你可以调用 `binkplugin.h` 中的函数。


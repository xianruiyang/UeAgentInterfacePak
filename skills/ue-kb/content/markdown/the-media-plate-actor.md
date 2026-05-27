# The Media Plate Actor

---
title: "The Media Plate Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/the-media-plate-actor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "The Media Plate Actor"]
---

# The Media Plate Actor

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / The Media Plate Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/the-media-plate-actor-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Unreal Engine 的 **Media Plate** 是一个预构建 actor，可以添加到场景中，用于播放视频、图像序列，以及指向 Media framework 所支持资产的任意 URL。Media Plate actor 是在场景中播放 Media Source 的最简单方式。可以使用 Media Plate 显示与虚拟摄像机同步的视频背景，因此它在影视或广播的虚拟制片中很有价值。它也适合添加游戏内电视、屏幕或广告牌等需要动态播放不同媒体内容的对象。

![The Media Plate Actor shown streaming media in the Viewport](../../../../assets/images/3c/3cc31881faf5b1889c8b8fd057b731b8c7719c9de71b5821b77d248a03d86bc2.jpg)

Media Plate Actor 支持：

- 简化的视频导入流程
- 针对 tiled EXR 图像序列的优化 streaming，可配合内置 [Sphere 和 Plane mesh](index.md#geometry)。需要 DX12 或更高版本。
- Media Playlist
- 拖放 asset 和 Actor
- Sequencer 集成
- 视锥体剔除
- 无缝循环

## 创建 Media Plate Actor

创建 Media Plate Actor 有多种方式。

可以选择：

- 将媒体文件（视频文件或序列中的图像）直接拖入 Viewport。
- 拖动 [media source asset](index.md) 从 Content Drawer 到 Viewport。
- 使用 [Place Actors 菜单](../../../understanding-the-basics/actors-and-geometry/placing-actors/index.md)

## 导入 Media Source

Media Plate 支持多种 Media Source asset，包括视频文件、图像序列，以及 AJA Media Source、Black Magic Media Source、Rivermax Media Source 等捕获卡 Media Source。根据使用的媒体类型不同，在 Unreal Editor 中导入它们并标记相关资产引用路径的方式也不同。

这些方式的共同点是都会立即创建 Media Plate Actor，之后可使用 [Media Plate Controls](index.md).

### 导入视频文件

要导入视频文件：

1. 打开 **Content Drawer**.
2. 将视频文件拖入 **Content Drawer** 并放下。
3. 将文件从 **Content Drawer** 拖入 **Viewport**。这会创建 Media Plate actor。

![Drag a video file into the Content Drawer](../../../../assets/images/72/726bda338db20b302663541d2a9e71a1a50db897d97650862f5fbdfefdc04f59.jpg)

### 导入媒体序列

要导入媒体序列：

1. 在 **Content Drawer**中创建 **Img Media Source**.
2. 在 **Sequence** > **Sequence Path**中指定包含图像的文件夹路径。
3. 可选：在 **Advanced** > **Frame Rate Override**中设置图像序列帧率。如果这里未指定任何内容，Media Plate Actor 会使用全局设置下的默认帧率。
4. 拖动 **Img Media Source** 从 **Content Drawer** 拖入 **Viewport**。这会创建 Media Plate actor。

### 导入捕获卡 Media Source

要导入捕获卡 media source，包括 AJA、Blackmagic 和 Rivermax：

1. 打开 **Content Drawer**.
2. 创建并配置新的捕获卡 Media Source asset。
3. 将捕获卡 Media Source asset 从 Content Drawer 拖入 **Viewport**。这会创建 Media Plate actor。

> [!NOTE]
> 使用捕获卡 Media Source asset 需要先安装并配置捕获卡。有关使用捕获卡的更多信息，请参阅[Professional Video I/O](../professional-video-io/index.md) （用于 AJA 和 Blackmagic）以及 [Using SMPTE 2110 with nDisplay](../rendering-to-multiple-displays-with-ndisplay/using-smpte-2110-with-ndisplay/index.md) （用于 Rivermax）文档。

## 使用现有 Media Plate Actor 播放媒体文件

如果已经创建了 Media Plate Actor，可以直接从 **Details** 面板引用要播放的媒体文件。可通过三种方式完成：

### 播放外部媒体文件

如果要在 Media Plate actor 上直接播放外部媒体文件，而不将其导入 Content Browser（避免项目被参考媒体弄乱，或视频文件过大无法嵌入 UE 项目），请按以下步骤操作：

1. 选择 **Media Plate actor** in the **Viewport**.
2. 在 **Details** 面板中转到 **Media**> **Playlist**.
3. 点击 **File。**
4. 点击 **省略号（…）** 选择媒体文件并设置文件路径。

![Media Plate external file](../../../../assets/images/55/559c8d64ad035a36dbcf7e8f6a95956280418a7c03f50178dac50cf87cdc5544.jpg)

> [!NOTE]
> 可以在以下位置配置用于播放外部媒体文件的 media player： **Project Settings > Electra Protron Factory**。当未定义首选 player（外部文件）时，可以选择 Protron 作为首选 player。这也会让 File Media Source 的自动 schema 优先选择 Protron，而不是 Electra 或 WMF player。
>
> ![Electra Protron Factory plugin settings](../../../../assets/images/80/80a3fbe56e9095fd44726a2db7fb3e6e23985d64caeb5b14ed6c3633fba9c0d0.jpg)

### 播放 File Media Source Asset

要在现有 Media Plate actor 上播放 Content Browser 中的 File Media Source asset，请按以下步骤操作：

1. 选择 **Media Plate actor** in the **Viewport**.
2. 在 **Details** 面板中转到 **Media**> **Playlist**.
3. 点击 **Asset。**
4. 查找并选择 **File Media Source asset** ，该资产位于 Content Browser。

![Media Plate File Media Source asset](../../../../assets/images/ee/eeba4669fc19335b8791a7ce9e0503b05a07aad71bb6ce7b196be3135632ee5f.jpg)

### 播放 Media Playlist

要在现有 Media Plate actor 上使用 Content Browser 中的 Media Playlist asset 播放多个媒体文件，请按以下步骤操作：

1. 选择 **Media Plate actor** in the **Viewport**.
2. 在 **Details** 面板中转到 **Media**> **Playlist**.
3. 点击 **Playlist。**
4. 查找并选择 **Media Playlist asset** ，该资产位于 Content Browser。

![Media Plate Playlist](../../../../assets/images/d5/d5b8b466bb896af5dbd32921a22801abe6f8a3b73e0d3af6686aa15e9c90e470.jpg)

## Media Plate 设置

在 Media Plate Actor 设置中，可以调整视频或图像序列的外观和播放。不需要创建 Media Texture 或 Media Player。

Media Plate 具有以下设置

### Transform

在 **Transform 部分**中，可以调整 Media Plate Actor 的位置、缩放和朝向。要了解这些设置的更多信息，请参阅 [Transforming Actors/Unreal Engine（Actor 变换）](../../../understanding-the-basics/actors-and-geometry/transforming-actors/index.md).

### Control

| Property | 说明 |
| --- | --- |
| Play on Open | 打开时自动开始播放视频或图像。 |
| Auto Play | 进入 game mode 时自动打开视频或图像序列。 |
| Enable Audio | 如果存在音轨，此设置会为当前 video decode engine 启用音频。 |
| Start time | 可使用此项设置自定义开始时间。这样，使用同一源视频的不同 Media Plate Actor 可以在不同时间开始。随后可在关卡中的多个实例中使用同一个可循环 clip，并让每个实例看起来不同。 |
| Play Only when Visible | 对 Media Plate Actor 应用 frustum culling，使 Actor 位于视锥体外时，整个视频解码和 streaming 都会停止。这通常适用于 nDisplay 等 clustered rendering 的大型装置，尤其是在使用多个大型且资源开销高的 Media Plate 时。 |
| Loop | 视频到达最后一帧时自动循环。 |

### Geometry

在这里可选择使用 **Plane**, **Sphere**或 **Custom** mesh。选择其中一种后，被引用的 mesh 会自动出现，并且该 mesh 类型的相关设置会变为可配置。

> [!TIP]
> 如果使用 tiled EXR 图像序列，并且图形能力为 DX12 或更高，建议选择 **Plane** 或 **Sphere** mesh。这两个预构建 mesh 都使用 Media Plate Actor 的优化 streaming，因此只会 stream 摄像机可见的 tile。Custom mesh 会 stream 所有 tile，而不管它们对摄像机是否可见。如果要将媒体转换为 EXR 格式，可以使用 [Process EXR tool](convert-media-into-the-exr-format-with-the-proc-37b051d3/index.md).

### Playlist

添加视频或图像序列时，Unreal Editor 会自动创建 **Media Playlist** 来保存视频 asset 引用，该引用可在 Media Playlist 部分看到。该部分还会显示初始 Media Source 和 Media Path 的引用。

该部分还包含可点击的图标，可用于 **Restart（重新开始）**, **Rewind（倒回）**, **Play（播放）**, **Pause（暂停）**, **Fast Forward（快进）**, **Open（打开）**和 **Close（关闭）** playlist。

该 **Open Media Plate** 按钮可打开一个 media plate 窗口，其中包含面向前方的平面 mesh，并显示更深入的媒体信息。在此窗口中，也可以使用 **Previous** and **Next** 图标访问 playlist 中的其它媒体。

### Media Details

该 **Media Details** 部分包含媒体的分辨率、帧率、大小、方法、格式、combined level of detail bias，以及 mip 和 tile 数量等信息。

### Media Texture

| Property | 说明 |
| --- | --- |
| Enable RealTime Mips | 如果为 true，Media Texture 会为每个视频帧生成 Mip Map chain。启用后，Media Plate Quad 中可见的视频帧会更平滑，并且没有 aliasing artifact。mip 数量会自动计算，不需要指定值。 |

### Materials

该 **Materials** 部分允许选择另一个 Material 来覆盖现有默认 Media Plate Material。默认材质是 translucent 且 non-lit 的 Material，会在 emissive channel 中渲染像素。此 Material 随 **Media Plate Plugin** 内容目录一起提供。

要为 Media Plate Actor 选择其它材质：

1. 选择 Media Plate Actor。
2. 在 **Details** 面板中点击 **Rendering** 过滤器以显示 **Materials** 部分。
3. 在 **Materials** 部分中点击 **Select Media Plate Material** 下拉菜单并选择新材质。

![A screenshot of the Details panel. The Select Media Plate Material dropdown is highlighted.](../../../../assets/images/41/41f8ba504a65bc20c2f618134b965cef383c88ee3b84f537a941bce96b5b2bb1.png)

> [!NOTE]
> Media Plate Actor 会查找一个特殊 **Texture** 参数，名为 **MediaTexture**。该参数必须存在于所选 Material 中，以便绑定并访问从 video decoder 接收到的像素。 **MediaTexture**.

Media Plate 附带以下默认材质：

对于 2D plate：

| Material 名称 | 说明 |
| --- | --- |
| M_MediaPlate | 为 translucent。这是默认选择。如果不使用 translucent material，可能会遇到 TSR ghosting artifact。 |
| M_MediaPlateCC | 颜色校正材质。 |

对于天空：

| Material 名称 | 说明 |
| --- | --- |
| M_Sky | Opaque，并启用 `IsSky` boolean enabled. |
| M_SkyCC | 用于天空的颜色校正材质。 |

**Holdout Composite 复选框**

可以启用 Media Plate actor 的 **Holdout Composite** 功能（用于绕过 TSR 和 Tonemap），该复选框位于 Rendering > Material 设置中。

![Media Plate actor Holdout Composite feature](../../../../assets/images/48/48c8c6ba08bc33d756c8ae127f2055827c842b087bd9163885fb3c51899aad99.png)

### EXR Tile 和 Map

| Property | 说明 |
| --- | --- |
| Visible Mips Tiles Calculations | 默认情况下，此设置会匹配所选 static mesh。如果要使用 Plane 或 Sphere，但不希望 Media Plate 只 stream 摄像机可见的像素，可以将其设置为 **None**。这对调试可能有用，但不建议在生产中使用。 |
| Mip Map Bias | 偏移请求的 mipmap level 以调整性能。有时即使 EXR sequence 已拆分为 tile 和 mip，PC 也会因带宽不足而无法播放某个 EXR sequence。 为了降低输入/输出（IO）带宽，可以向任一方向偏移 Media Plate Actor，以加载分辨率更低的 higher mip。估算的 Mip Map level 默认与 renderer 匹配，因此取决于 Field Of View（FOV）和分辨率。 |
| Enable Mip Map Upscaling | 如果为 true，此选项会强制放大在 **Upscale Mip Level** 设置中选定的 Mip Map level。通常，Media Plate 只会在 viewport 中加载所需质量的 mip 和 tile。 在某些情况下，例如 reflection 和 skylight，可能需要为摄像机不可直接见、但仍会影响光照和反射的 EXR texture 区域加载 viewport 外的低质量 tile。 |
| Upscale Mip Level | 由 **Enable Mip Map Upscaling** 设置启用的 Mip Map level。例如，如果此属性设置为 3，则 Mip Map level 为 3 或更高的 texture 会完整读入 texture。 Mip Map level 为 2 或更低的 texture 会使用 Mip Map level 3 的 texture，但会放大到实际 Mip Map level 对应 texture 的尺寸。录制时，摄像机可见区域包含正确质量的 mip，而摄像机不可直接见的所有内容包含已放大的低质量 mip。 |

当 **Visible Tiles & Mips Logic** 设置为 **Sphere**时，该部分会包含另一个 property：

| Property | 说明 |
| --- | --- |
| Adaptive Pole Mip Upscale | 降低 sphere 极点处质量以减少负载。 仅当使用 spherical mesh 时可用. 使用 spherical mesh 时，tile 会聚集在 sphere 极点附近. 如果使用大型 `.exr` file (16k）文件时，系统需要加载更多 tile. 使用此选项后，系统会决定是否加载 higher level mip（更低质量）来减少负载. |

### Cache

| Property | 说明 |
| --- | --- |
| Override | 降低 sphere 极点处质量以减少负载。 仅当使用 spherical mesh 时可用. 使用 spherical mesh 时，tile 会聚集在 sphere 极点附近. 如果使用大型 `.exr` file (16k）文件时，系统需要加载更多 tile. 使用此选项后，系统会决定是否加载 higher level mip（更低质量）来减少负载. |
| Look Ahead | 向前预读缓存的时间，单位为秒。为了获得足够缓存，建议 2-4 帧。在 24fps 下，2 帧应为 0.084 秒。此设置默认值为 0.2s。缓存帧越多，摄像机移动时需要失效并重新加载的帧就越多。 |

### Advanced Settings

| Property | 说明 |
| --- | --- |
| Audio Component | 包含所用 audio component 的详细信息。 |
| Static Mesh Component | 包含所用 mesh component 的高级细节和 property。 |
| Other > Letterboxes | 包含所用 letterbox 的详细信息。 |

## Overlay Materials 技术

为了缓解播放时出现的 temporal artifact 和 anti-aliasing artifact，Overlay Materials 允许 Media Plate Actor 在自己的 compositing pass 中渲染视频帧。Actor 会无 jitter 地渲染到 motion blur 之后的 translucency render target，并在 Temporal Super Resolution（TSR）之后合成回 scene color。可以使用以下变量将 overlay material 设置为正确的最终分辨率（upscale 后）： **r.Translucency.SeparateResolution.Basis**.

> [!NOTE]
> 由于 Overlay Materials 技术使用 translucency render target，因此它只对没有 translucency 的视频有效。

要应用 Overlay Materials，请执行以下步骤：

1. [创建 Media Plate Actor](index.md) 到关卡中。
2. 在 Level Editor 中右键点击 Media Plate Actor，然后点击 **Apply Overlay Composite Materials**。这会替换 Base Material，添加 Overlay Material，并启用 translucency 变量。

> 图片已省略：Apply Overlay Composite Materials and Reset Default Materials

> [!TIP]
> 要从 Media Plate Actor 移除 Overlay Composite Material，可以点击 Reset Default Materials。

## Sequencer 集成

**Sequencer** 集成对于精确控制视频或图像序列 clip 的开始、结束或循环时间很重要。也可以用它确保所有 clip 都 frame-locked 到精确的 Sequencer 时间，从而结合整体关卡动画和逻辑精细控制 sequence。

要将 Media Plate Actor 添加到 Sequencer：

- 拖动 **Actor** 从 **World Outliner** 拖放到 **Sequencer Track**.

> 图片已省略：Drop the Actor into the Sequencer track

> [!NOTE]
> 为了在 Sequencer 中正确同步，必须在 Media Plate Controls 中禁用音频（general settings > 取消勾选 Enable Audio），或者在任何手动创建且使用 Electra Media Player 的 Blueprint 中禁用音频。

### 在 clip 之间交叉淡化

使用 Sequencer，可对两个 Media Track 应用 crossfade：

1. [将 Media Plate Material 设置为](index.md#materials) 为 **M_MediaPlateCrossFade**.
2. 在 **Details** 面板中，在 **Materials**下点击 **Create Dynamic Material**。这需要 Virtual Production Utilities 插件。
3. 要打开 Sequencer，请在主菜单栏中转到 **Window** > **Cinematics** > **Sequencer**。如果 Sequencer 为空，需要 [创建 level sequence](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md).
4. 从 **Outliner** 面板点击并拖动 **Media Plate Actor** 拖入 **Sequencer** 面板以创建 **Media Track**. a. In the popup window, click **Yes** 以禁用 autoplay。
5. 重复第 4 步创建第二个 Media Track。

创建两个 Media Track 后，可以通过合并 track 自动创建 crossfade，也可以在独立 track 上手动创建 crossfade。

#### 自动创建 Crossfade

1. 将新创建的 track 拖入第一个 track。
2. 拖动一个 track，使其与另一个重叠。Sequencer 会自动计算 crossfade 值。

   > 图片已省略：A screenshot of Sequencer, showing a track A being dragged to overlap a track B.

#### 手动创建 Crossfade

1. 按下 **Ctrl** 键以显示 track 上的箭头。
2. 右键点击并拖动箭头，为第一个 track 定义 ease-in 和 ease-out curve。

   > 图片已省略：A screenshot of Sequencer, highlighting the arrows on the first of two tracks that can be used to define curves.
3. 对第二个 track 重复第 2 步。

   > 图片已省略：A screenshot of Sequencer, highlighting the arrows on the second track.

## 注意事项和限制

使用 Media Plate Actor 时，请注意以下事项和限制：

- **Media Player**：只有 Electra 和 IMGMedia Player 支持同步。默认情况下，引擎会选择找到的第一个 player。为保证同步播放，可以在以下位置选择 Electra，手动强制将其作为 player： **FileMediaSource** > **Player Overrides** > **Windows** > **Electra player（ElectraPlayer）**.
- **Genlock**：如果使用 nDisplay cluster 设置，并希望优化图像播放的帧精度，可以使用名为 [Genlocked Fixed Rate](index.md).
- 实时 skylight 和 reflection：如果希望使用 viewport 外的 mip 和 tile 为实时 skylight 与 reflection 做贡献，必须使用 [anchor link upscalehigherlevelmip] console variable。

### Genlocked Fixed Rate

要实现 Genlocked Fixed Rate timestep，请执行以下步骤：

1. 在 **Content Browser**下点击 **Add（+）** > **Media** 并创建新的 **Media Profile**.
2. 在 **Media Sources** > **Index [0]**选择 **File Media Source**.
3. 勾选 **Override Project Settings**.
4. 点击 **Genlock** > **CustomTimeStep** > **Genlocked Fixed Rate**.
5. 取消勾选 **Should Block**.

   > 图片已省略：Genlock settings
6. 保存 Media Profile，但不要在编辑器机器上加载它。此 Media Profile 仅用于 nDisplay node。
7. 创建 Media Profile 后，需要将其部署到 nDisplay node。在 **Switchboard** 设置菜单中点击 **Media Profile** 下拉菜单，然后选择 media profile。

   1. 也可以使用每个 node 设置中的 **Media Profile** 下拉菜单为单个 node 设置 Media Profile。

## 有用的控制台变量

- **ImgMedia.FieldOfViewMultiplier：** (`ImgMedia.FieldOfViewMultiplier=1`)

  由于 Media Plate 只加载当前视图可见的 tile，在某些情况下，快速平移镜头可能导致边缘附近临时缺失 tile。此 console variable 可增加视图边缘周围加载的 tile 数量。
- **ImgMedia.MipMapLevelPadding：** (`ImgMedia.MipMapLevelPadding=0`)

  如果 mipmap 估算与 renderer 的匹配精度不足，此值会填充到计算出的最小和最大 mipmap level 上。这会增加加载的 tile 数量，但可在特殊条件下帮助消除 artifact。
- **Concert.EnableLoopingOnPlayer：** (`Concert.EnableLoopingOnPlayer=1`) (Default)

  默认情况下，当 Sequencer player 启用 looping 时，Multi-User Sequence Manager 会确保媒体播放循环。在 5.1 之前，Multi-user 不会在 nDisplay sequence player 上启用 looping，循环由 Sequencer 重置 playhead 来处理。这允许 playhead 与 ICVFX 墙上的内容保持同步。如果希望 editor 与 nDisplay cluster 之间的 playhead 同步，请将此值设置为 0。
- **r.EXRReaderGPU.UpscaleHigherLevelMip：** (`r.EXRReaderGPU.UpscaleHigherLevelMip=-1`)

  通常，Media Plate 只会在 viewport 中加载所需质量的 mip 和 tile。但在某些情况下，例如 reflection 和 skylight，可能希望为 EXR texture 中未填充任何数据的区域加载 viewport 外的低质量 tile，以便它们参与光照和反射。

  例如，如果将此 console variable 设置为 mip level 3，则 mip level 3 会被完整读取、加载并 upscale 到 mip 0、1、2。包含 3 及高于 3 的 mip level（4、5、6 等）会完整读入 texture。录制时，摄像机可见区域包含正确质量的 mip，而 active view 不可直接见的所有内容包含较低质量 mip。

## 调试

可使用以下 Stat command 调试 Media Plate Actor：

- **Stat Media**：显示当前正在播放的 Media 信息。
- **ImgMedia.MipMapDebug 1**: 在 game mode 中将可见 tile 和 mip 调试信息打印到屏幕. 仅可用于 `.exr` media format.
- **Log LogImgMedia Verbose**：启用 ImgMedia 专用 verbose log data。


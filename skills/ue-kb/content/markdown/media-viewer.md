# Media Viewer

---
title: "Media Viewer"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/media-viewer-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "Media Viewer"]
---

# Media Viewer

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / Media Viewer

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/media-viewer-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## 简介

在 Unreal Engine（UE）中制作动画时，可能需要将动画与已有参考素材对齐。因此，在使用 **Media Viewer**时，可以将媒体（图像、媒体纹理、视频文件、实时视口纹理）停靠到执行动画工作的 Viewport 旁边。两个 A/B bank 可以横向或纵向排列，用于比较两组图像，并可使用缩放和平移控制进一步对齐内容。

Media Viewer 插件提供以下工作流和易用性改进：

- 引用并查看 **媒体纹理** 来自 **Sequencer**或来自 **Content Browser**.
- 引用 **实时 Viewport 纹理**.
- 引用并查看 **图像/文件媒体源** 来自 Content Browser 或 Windows Explorer。
- 使用标准 **播放**控制媒体（Play、Stop、Pause、Scan）。
- **平移**和 **缩放**控制，包括使用 ALT + RMB 的增强缩放控制。
- **书签**并使用热键快速调出 A/B 资产 bank 配置。
- 该 **锁定**按钮会在双 Player 模式下镜像播放控制和时间线。

## 入门

要使用新的 Media Viewer，需要启用以下插件：

**Media Viewer（主 BETA 插件）**

![Media Viewer plugin](../../../../assets/images/30/306834fe65ede655a061bbe84edfca5cc103efc3b16051400326b6bfe8b8d4bc.jpg)

可选但推荐：

- **Electra Player**：使用 Protron Player，以获得更高效的播放和拖动预览。
- **Electra 的 D3D12 硬件加速视频解码插件**：用于获得最佳播放和拖动预览性能。默认禁用，需要设置 cvar，见下文。
- **Electra 的 Apple Pro Res 解码器**：MacOS 上推荐的视频格式和容器。

> [!NOTE]
> 对于 H.264/5 视频文件，D3D12 硬件加速视频解码可提供最好的播放和拖动预览性能。要启用它，需要设置以下 cvar：
>
> - `ElectraDecoders.bDoNotUseD3D12Video` set to `FALSE`
> - `ElectraDecoders.bDisableD3D12Video` set to `FALSE`

> [!WARNING]
> 由于 GPU 兼容性问题，硬件视频解码较脆弱并默认禁用。它可能导致编辑器崩溃，请谨慎使用。即使它能在某台 PC 上正常工作，也不要假设它能在其他硬件上正常工作。

### Media Viewer 窗口

可以在主 **Media Viewer** 菜单中找到 **Window**。

![Media Viewer in the Window menu](../../../../assets/images/c4/c49be7fc406475244210fd5f3cceaa36d8ce5582f71b9f3d410f6218b77a3166.jpg)

#### Media Viewer 用户界面

可以将 Media Viewer 窗口停靠在 UE Editor 主界面的任意位置。其控件和 widget 被设计为尽量减少占用空间。

在默认 Media Viewer 布局中，可以看到以下内容：

- [Library 标签页](index.md#library) 位于左侧。
- [Toolbar](index.md#toolbar-controls) 控件和 widget 位于顶部。
- [拖放区域](index.md#adding-media-assets) 位于中间，用于 Content Browser 项目。

#### 多个标签页

主 Media Viewer 支持创建多个标签页，并可将其停靠在 Editor UI 的任意位置。

#### 打开上一个 Session 的提示

如果之前使用过 Media Viewer，可以通过以下提示恢复上一个 session，或重新开始。

### Library

Media Viewer 的 Library 标签页包含以下类别：

- **Pinned**：用户定义的区域，可存储图像或视频参考。
- **Snapshots**：引用快照的区域。快照会保存到 Content Browser。
- **History**：之前打开或拖放过的所有项目列表。
- **Editor Viewports**：显示所有可用 Editor Viewport Texture 的列表。
- **Media Tracks**：显示 Sequencer 中当前可用或已打开的媒体轨道列表。
- **Media Textures**：显示已分配且处于活动状态的 Media Texture 列表。这包括 Sequencer Media Track 中使用的 Media Texture 资产。

在 Library 中，可以通过将图像、媒体纹理或视口纹理拖放到 A/B drop zone，或使用 **添加 A/B bank** 按钮，将它们添加到 A 或 B bank。

也可以将项目从 **History**区域拖放到 **Pinned**区域。

### 添加媒体资产

主要可以通过 A/B media bank 的 drop zone 与 Media Viewer 交互，如下所示：

- 将媒体资产从 Content Browser 拖放到 Media Viewer 窗口中，drop zone 会随即出现。
- drop zone 会引导你选择单视图或并排视图配置：

### Toolbar 控制

可以使用窗口顶部的 toolbar 控制来操作 Media Viewer 中的资产。

#### 单视图与并排视图

可以在单视图或并排视图配置下使用 Media Viewer。

- 在 **单视图** 模式下，一次只能显示并控制一个媒体资产。
- 在 **并排视图** 模式下，可以同时查看两个媒体资产，并使用中间滑块比较它们。可以在两种并排配置之间选择：

  - **Vertical**：使用中间的垂直滑块比较内容。
  - **Horizontal**：使用中间的水平滑块比较内容。

在并排视图配置中，第一个媒体资产会覆盖整个 Media Viewer 表面区域显示。第二个媒体资产会渲染并覆盖在上方，可通过不透明度控制调整。

#### 平移、缩放和旋转控制

Media Viewer 的 **平移**, **缩放**以及 **旋转**控制始终处于活动状态。

- 按住鼠标左键进行 **平移**.
- 使用 ALT + RMB 或滚轮旋转进行 **缩放**.
- 旋转角度设置会暴露在 A/B bank 的 details panel 中。也可以使用数字小键盘 “4” 和 “6” 键来 **旋转**.

![Media Viewer zoom value in the toolbar](../../../../assets/images/da/dac46c87ed276b8c64f6d4cca1974ad01941f3277471ef2420ce098cae5144dd.png)

此外，还可以在 Toolbar 中查看并设置当前缩放值。

![A/B media bank swap, lock, and reset controls](../../../../assets/images/a1/a177a36904d16eac461f707645969c96db01b088095133f10dca6465360a114c.png)

- 该 **A/B media bank 交换** 控制用于交换 A 和 B media bank，包括它们当前的平移和缩放控制。
- 默认情况下， **锁定**控制会应用到 A 和 B 两个 media bank 的平移和缩放控制。 可以禁用 lock 选项，使每个 bank 使用独立控制。
- 该 **重置**控制会重置 A 和 B 两个 bank 的所有平移和缩放控制。

#### 不透明度与比较控制

在并排视图配置中工作时，可以使用 **不透明度控制** 调整 media bank B 覆盖渲染在 media bank A 上方时的不透明或半透明程度。

![Media Viewer opacity and compare controls](../../../../assets/images/4e/4e779e665bdc7f044d248e76134ee8e69504793f42f8f3ec5e1c9705936db379.jpg)

### 其他控制和设置

可以在 **Details Panel** 菜单下找到一些额外和高级控制，如下图所示：

可以分别调整 A 和 B bank 媒体资产的设置。可以查看并设置：

- **Material**

  - **Render Target**: 可以使用此下拉菜单选择媒体资产.
  - **Real Time**：启用此复选框以进行实时更新。
- **Media**

  - **Offset (X, Y, Z)**: 此控制设置媒体的默认位置. 工作时可以使用 Pan 控制更改它.
  - **Rotation (X, Y, Z)**
  - **Scale (X, Y, Z)**: 此控制设置媒体的默认缩放级别. 工作时可以使用 Zoom 控制更改它.
  - **Tint**: 此控制会给叠加层应用颜色.
- **Panel**

  - **Background Color**：使用颜色选择器设置该值。
  - **Background Texture**：选择纹理资产作为背景。可选。

### 上下文菜单

在主 Media Viewer UI 的任意位置右键单击，会打开包含额外选项的上下文菜单：

![Media Viewer context menu](../../../../assets/images/83/835f37435ac4337666eb52b51c90fae344247f6834be9b291bcd3ad156f5254e.jpg)

- **Reset Transform**：重置当前应用到图像的变换。
- **Copy Transform**：从当前选中图像复制内存中的变换数据。
- **Pin Image**：将当前图像添加到 Library 标签页的 Pinned 类别。
- **Show Overlays**：切换图像上方各种叠加数据的显示。
- **Sync Transforms**：应用到任一图像的所有变换都会应用到两个图像。
- **Resets All Transforms**：重置两个 image bank 的所有变换。
- **Swap A and B**：交换 A 和 B 图像。
- **Open Bookmark**：加载选中的书签。
- **Save Bookmark**：将当前状态保存为书签。

### 视频播放和控制

Media Viewer 内置视频控制和播放能力，可用于查看视频资产。

将 File Media Source 拖放到 A 或 B media bank 时，底部会显示以下播放控制。控件会在几秒后消失，将鼠标移到其上即可重新显示：

**播放头控制** 类似 Sequencer 控制，并提供相似功能：

- 正向或反向播放。

  - 反向播放仅适用于某些编解码器，例如 Apple Pro Res。
- 向前或向后步进一帧。
- 跳到开头或结尾。
- 使用拖动条。

**其他信息** 会显示在 UI 中：

- 左上区域显示分辨率和 Player 信息。
- 控件左侧显示当前帧/总帧数。
- 控件右侧显示当前时间/长度。

> [!NOTE]
> 播放和拖动预览性能受多种因素影响，包括：
>
> - 源媒体类型。
>
>   - 例如，Apple Pro Res 文件或图像序列会比 H.264/5 对应文件有更好的拖动预览效果。
> - FileMediaSource UAsset 中选择的 Player。
>
>   - 例如，Protron Player 针对本地播放优化，因此播放和拖动预览更快。使用 Electra 或 WMF player 可能得到不同结果。
> - 硬件解码相关的特定 cvar（仅适用于 H.264/5 编解码器）。
>
>   - `ElectraDecoders.bDoNotUseD3D12Video` and `ElectraDecoders.bDisableD3D12Video` set to `FALSE`.

### A/B 同步播放

启用锁定图标后，Media Viewer 可锁定 A 和 B 两个 bank 的播放控制。它会为 A 和 B 内容 bank 镜像播放、暂停、倒带等播放控制。拖动条也会被镜像，因此可以使用任一 scrubber 精确同步拖动两个片段。

### 外部视频播放

为避免参考媒体让现有项目变得杂乱，也可以使用 Media Viewer 播放未位于 Content Browser 中、也未导入 Content Browser 的外部视频文件。在此工作流配置中，会使用首选 Player 解码请求的文件。可以在以下位置配置： **Project Settings > Electra Protron Factory** 如果未定义 Player，可以在这里选择 Protron 作为首选 Player。

以下示例展示将 Apple Pro Res .mov 文件拖放到 Media Viewer。

![Adding a .mov file to the Media Viewer](../../../../assets/images/a8/a8eceee62f10c5273b5183a9890f9e4a597868822fcced14758944fc775b13f8.jpg)

### Sequencer 驱动的播放

Sequencer 驱动的视频播放是标准 Media Viewer 工作流，可提供帧精度，并与动画对齐。按照以下说明设置该工作流。

#### 向 Sequencer 添加 Media Track

- 首先在 Sequencer 中添加 **Media Track** 。
- 分配你的 **Image**or **File Media Source** 参考资产。

#### 设置 Media Texture

- 接下来，在 Media Track 上选择 **Media Texture**。Media Viewer 会自动使用此纹理。

#### 在 Media Viewer 中可视化 Media Texture

- 在 Sequencer 的 Media Track 上选择 Media Texture 后，它会出现在 Media Viewer 中。

  - 也可以从 Content Browser 拖放该资产。

#### 使用 Sequencer 进行播放控制

- 选择资产后，可以使用 Sequencer 播放控制同时调整动画和参考媒体，使其正确对齐。

### 设置视频以实现快速播放或拖动预览

为获得最佳视频播放和拖动预览性能，请执行以下操作：

- 启用 Electra Player 插件。
- 使用适合拖动预览的视频容器，例如 Apple Pro Res。
- 打开视频文件的 File Media Source，并将 **Electra Protron** 设置为 Player。

  1. 也可以设置 **Electra Factory 项目设置** 来选择 Protron Player。

### Content Browser 上下文菜单

可以通过 Content Browser 上下文菜单选项，使用 Media Viewer 打开并查看视频资产。

选择 **Open in Media Viewer**后，编辑器会打开 Media Viewer，并立即开始播放 File Media Source 资产。


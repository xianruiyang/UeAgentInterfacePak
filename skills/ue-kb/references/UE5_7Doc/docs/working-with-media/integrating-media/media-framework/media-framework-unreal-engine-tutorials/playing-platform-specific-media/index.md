---
title: "在平台上播放媒体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/playing-platform-specific-media-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "媒体框架教程", "在平台上播放媒体"]
---

# 在平台上播放媒体

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / 媒体框架教程 / 在平台上播放媒体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/playing-platform-specific-media-in-unreal-engine

如果您在处理多平台项目，可能在某些情况下，需要播放特定于平台的媒体。 例如，您可能想要在PlayStation 4（PS4）上游戏时播放一段特定的影片，而在Xbox One上播放另一段影片。 或者，可能使用同类型的媒体，但由于性能原因而采用了不同的编码方式，您想要在不同的平台上播放不同的格式。

通过 **平台媒体源（Platform Media Source）** 资源，您可以确定根据运行平台应播放哪个媒体源资源。 在打开/播放平台媒体源（Platform Media Source）时，它将检查您当前所在的平台，并自动播放指定的媒体源。

在本操作指南中，我们将创建平台媒体源（Platform Media Source），并针对Android和Windows平台指定两个不同的媒体源。

## 步骤

> [!NOTE]
> 在本操作指南中，我们使用启用了 **初学者内容包** 的 **蓝图第三人称模板（Blueprint Third Person Template）** 项目。 我们还将使用两个样本视频，您可以右键单击该[平台视频](https://dev.epicgames.com/documentation/404)链接进行下载，然后将内容解压到您的电脑上。

1. 在 **内容浏览器** 中，展开 **源（Sources）** 面板，并添加名为 **电影（Movies）** 的新文件夹，然后在该文件夹上单击右键并选择 **在资源管理器中显示（Show in Explorer）**。
2. 将样本示例或所需媒体文件拖到项目的 **Content/Movies** 文件夹。

   > [!WARNING]
   > 如果您想要打包并部署包含任意媒体文件的项目，需要将它们放置在项目的 **Content/Movies** 文件夹中。
3. 在 **内容浏览器** 中，在项目的 **Content/Movies** 文件夹下，单击右键并在 **媒体（Media）** 下选择 **文件媒体源（File Media Source）**，将其命名为 **Android_Movie**。

   这里我们创建 **平台媒体源（Platform Media Source）** 资源能够指向的媒体源资源，并在Android设备上运行时加以使用。
4. 再创建一个 **文件媒体源（File Media Source）** 资源，并命名为 **Windows_Movie**。
5. 打开 **Android_Movie** 媒体源，然后对于 **文件路径（File Path）**，使用 **Gideon_720x480**（或者您所需的视频），并选择 **打开（Open）**。

   对于Android影片，我们使用 **.3GP** 视频文件，这类文件更适合于在Android设备上播放，而Windows影片则为 **.MP4** 文件。
6. 打开 **Windows_Movie** 媒体源，将 **文件路径（File Path）** 指向 **Infiltrator Demo**（或者您所需的视频），并选择 **打开（Open）**。
7. 右键单击 **Content/Movies** 文件夹，然后在 **媒体（Media）** 下面，选择 **平台媒体源（Platform Media Source）**，并命名为 **Platform_Source**。

   现在，我们已经有了多个媒体源资源，我们可以通过 **平台媒体源（Platform Media Source）** 资源定义要在哪个平台上播放哪个媒体源。
8. 打开 **Platform_Source**，在 **Android** 下面选择 **Android_Movie**，在 **Windows** 下面选择 **Windows_Movie**。

   在我们的示例中，我们使用两个不同的视频。但是，您可以使用具有不同编码或不同格式的同一个视频以便用于不同的设备。 您还可以使用不同的媒体源类型，例如，在Windows上，您可以选择使用[媒体流](../play-a-video-stream/index.md)从网站拉取内容，代替使用磁盘上的文件。
9. 在 **Content/Movies** 文件夹中单击右键，然后在 **媒体（Media）** 下面选择 **媒体播放器（Media Player）**。

   我们仍需要使用 **媒体播放器（Media Player）** 来打开和播放 **平台媒体源（Platform Media Source）** 资源。
10. 在 **创建媒体播放器（Create Media Player）** 窗口中，启用 **视频输出媒体纹理资源（Video output Media Texture asset）** 选项，然后单击 **确定（OK）** 并调用资源 **媒体播放器（Media Player）**。

    这样会自动创建与这个媒体播放器关联的 **媒体纹理（Media Texture）**，然后我们可以在[材质](../../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)中加以使用。 我们可以使用这个材质，并将其应用于关卡中的网格体来播放我们的内容。
11. 在 **媒体播放器（Media Player）** 资源内部，双击 **媒体库（Media Library）** 窗口中的 **Platform_Media** 资源。

    双击 **Platform_Source** 资源将开始播放仅指定到 **Windows** 的平台媒体源（因为我们是在Windows平台上运行）。 通过蓝图或C++，我们可以打开 **Android_Movie** 媒体源进行播放，但是，当打开Platform_Source时，仅播放指定到Windows的媒体源。 此外，**打开时播放（Play on Open）** 选项默认是启用的，从而允许媒体播放器开始播放所打开的媒体源。
12. 在主编辑器窗口中，从 **模式（Modes）** 面板中的 **基本（Basic）** 下面，将 **平面（Plane）** 拖到关卡，根据需要调整大小，然后将 **MediaPlayer_Video** 纹理拖到它上面。

    通过将 **媒体纹理（Media Texture）** 资源拖到关卡中的静态网格体上，会创建并应用材质，材质将播放我们的媒体。

    > [!NOTE]
    > 假如你需要在使用 **Electra媒体播放器** 时使用纹理取样或纹理对象，请将 **取样器类型（Sampler Type）** 设置为 **颜色（Color）**。
13. 选中 **平面（Plane）**，在 **细节（Details）** 面板中，添加 **媒体声音（Media Sound）** 组件，并将 **媒体播放器（Media Player）** 选项设置为使用您的 **MediaPlayer** 资源。
14. 从主工具栏，单击 **蓝图（Blueprints）** 选项，然后选择 **打开关卡蓝图（Open Level Blueprint）**。
15. 在 **我的蓝图（My Blueprint）** 面板中，创建一个 **媒体播放器对象引用（Media Player Object Reference）** 类型的变量并命名为 **媒体播放器（MediaPlayer）**，然后将您的 **媒体播放器（MediaPlayer）** 指定为要使用的 **媒体播放器**。

    这样会创建对您的媒体播放器资源的引用，然后您可以在蓝图中使用并对其调用操作。

    > [!NOTE]
    > 为了设置变量的 **默认值（Default Value）**，需要先单击 **编译（Compile）** 来编译蓝图。
16. 按住 **Ctrl** 键并将 **媒体播放器（MediaPlayer）** 变量拖到图形上，单击右键并添加 **1** 键盘事件，然后连接到指向 **Platform_Source** 的 **打开源（Open Source）** 节点。

    这里我们告诉媒体播放器打开指定的 **平台媒体源（Platform Media Source）** 资源，这个资源设置为根据所运行的平台打开其他媒体源资源。
17. 关闭 **关卡蓝图（Level Blueprint）**，然后单击 **播放（Play）** 按钮来在编辑器中播放。

## 最终结果

在编辑器中播放时，按 **1** 键将在平台媒体源中打开Windows定义的媒体源。

如果要将该项目部署到Android设备，则将播放指定到Android的媒体源资源。

# AJA视频输入/输出快速入门

---
title: "AJA视频输入/输出快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/aja-video-io-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "专业视频I/O", "AJA视频输入/输出快速入门"]
---

# AJA视频输入/输出快速入门

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 专业视频I/O / AJA视频输入/输出快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/aja-video-io-quick-start-for-unreal-engine

在这个快速入门指南中，我们将介绍如何设置一个虚幻引擎项目来使用AJA Video Systems中的专业视频卡。在本指南的最后：

- 你将在你的虚幻引擎项目内播放来自你的AJA卡的视频输入。
- 你将能够从编辑器和运行时应用程序捕获摄像机视点，并将它们发送到AJA卡上的SDI端口。
- 当你想进行设置以对视频输入进行更高级的调整时（比如校正镜头变形和应用色度抠像效果），你知道该怎么做。

> [!TIP]
> 有关展示下述许多元素付诸实践的工作示例，请参阅Epic Games启动器的学习（Learn）选项卡所提供的 **[虚拟工作室](../../../../samples-and-tutorials/engine-feature-examples/virtual-studio-sample-project/index.md)** 展示。

> [!NOTE]
> **先决条件：**
>
> - 确保你拥有AJA Video Systems支持的显卡硬件，并安装了必要的驱动程序和软件。详情请参阅
>
>   AJA媒体引用
>
>   页面。
> - 确保你的显卡正常工作，并且你有一些视频输入传递到该卡的至少一个SDI端口。
> - 打开要与视频源集成的虚幻引擎项目。此页面显示了
>
>   第三人称
>
>   蓝图模板中的步骤，但是相同的步骤在任何项目中都同样适用。
>
> 本指南中使用的AJA媒体组件构建在[媒体框架](../../media-framework/index.md)之上，我们将使用[蓝图](../../../../blueprints-visual-scripting/index.md)在运行时编写视频捕获过程的脚本。建议你对这些主题有一定的了解，但这不是必需的。

## 1 - 设置项目

在你从AJA卡获取视频输入，放入到虚幻引擎关卡中，并通过AJA卡的某个SDI端口发送来自虚幻引擎的输出之前，你需要做一些基本设置来为项目启用AJA媒体播放器插件。

> [!TIP]
> 如果你的虚幻引擎项目使用了 **影视与实况活动** 分类下的模板，可能已经启用了必要的插件。如果没有，请按以下步骤启用它们。

### 步骤

1. 在虚幻编辑器中打开你想要使用AJA视频输入/输出的项目。
2. 在主菜单中选择 **编辑（Edit）> 插件（Plugins）**。
3. 在 **插件（Plugins）** 窗口的 **媒体播放器（Media Players）** 分类中找到 **AJA媒体播放器（AJA Media Player）** 插件。勾选 **启用（Enabled）** 复选框。

   ![Enable the AJA Media Player Plugin](../../../../../assets/images/c9/c998c9df3b08a985a1f8ac3353b3703ddce2a8e8bb890dd4710161f4b4b1068a.jpg)

   点击查看大图。
4. 在 **媒体播放器（Media Players）** 类别下找到 **媒体框架工具（Media Framework Utilities）** 插件。选中其 **启用（Enabled）** 复选框（如果尚未选中）。

   ![Enable the Media Framework Utilities Plugin](../../../../../assets/images/d9/d9075c66db30e8f6f3e2ccaa5c2e1e4bd3640d23dfc6aac39bbe8a5048a339bf.jpg)

   点击查看大图。
5. 单击 **立即重启（Restart Now）** 重新启动虚幻编辑器并重新打开项目。

   ![Restart Now](../../../../../assets/images/29/29c08fa2aaac3b00827d942a0e769349bb69ad33403bbc0ff288e1a383e77780.jpg)

   点击查看大图。

### 最终结果

你的项目现在已经准备好接受来自AJA卡的视频，并将渲染的输出发送到该卡。在接下来的章节中，我们将准备好并开始播放视频。

## 2 - 在虚幻引擎中渲染视频输入

在这个过程中，我们将使来自AJA卡的视频输入在虚幻编辑器的当前关卡中可见。此过程会用到媒体束，这是一种资源，它将媒体框架中涉及的几种不同类型的资源打包在一起，并提供对一些高级特性的控制，如镜头变形、色度抠像、颜色校正等。

### 步骤

1. 在你的 **内容浏览器（Content Browser）** 中，展开 **源（Sources）** 面板(1)。右键单击并从上下文菜单(2)中选择 **新建文件夹（New Folder）**。

   新文件夹 将你的新文件夹重命名为 **AJA**。
2. 打开你的新文件夹，右键单击 **内容浏览器（Content Browser）** 并选择 **媒体（Media）> 媒体束（Media Bundle）**。

   ![新媒体束](../../../../../assets/images/6e/6e53153c846c57b31a44d8a0bbe324e1cf8751de124437e1d151a44c2c496291.jpg)
3. 将在内容浏览器中自动选择新资源的名称，因此可以为其提供描述性名称：

   ![为媒体束命名](../../../../../assets/images/74/74c9c7e9e5e2cf7540ea070efda95acd4f824231dd0f2a9fbba7e5255caa8e28.jpg)

   键入一个新名称，例如 **AjaMediaBundle**，然后按 **Enter**。媒体框架资源的新文件夹将自动创建在媒体束旁边，使用后缀 **_InnerAssets** 命名。
4. 单击 **内容浏览器（Content Browser）** 中的 **保存所有（Save All）** 按钮保存新资源。

   ![保存所有资产](../../../../../assets/images/66/6627e3a44e11de191c11ca076988a35c17dd521bf23e903111dbef6477c8066b.jpg)
5. 双击新媒体束以编辑其属性。媒体束能够播放来自引擎支持的任何媒体源的视频，因此你需要告诉它你想从AJA卡获取视频。

   在 **媒体源（Media Source）** 属性中，从下拉列表中选择 **Aja媒体源（Aja Media Source）**：

   ![Set the AJA Media Source](../../../../../assets/images/bb/bb19e74abed02e97be8f174fe9c94e03f45bc87164c30297b66bfd3934c776cb.png)

   点击查看大图。
6. 一旦确定你希望媒体束处理的媒体源类型，你就可以设置该类型的源提供的任何配置属性。

   你可以让虚幻引擎自动匹配输入视频信号的格式和帧率。要启用自动匹配检测，请点击 **配置（Configuration）** 下拉菜单，启用 **自动（Auto）**，然后点击 **应用（Apply）**。这样，引擎就能在临时丢失信号时自动无缝处理修改和重启。

   ![Aja Media Source Configuration](../../../../../assets/images/42/4244775e3c23481557bb075bf406c81300c1beda9e0b340d3a5eef370430e169.jpg)

   点击查看大图。

   根据所安装的设备，你看到的选项可能有所不同。有关你可以为AJA媒体源设置的所有属性的详细信息，请参阅[AJA媒体引用](../aja-media-reference/index.md)页面。
7. 如果想对传入的视频应用任何补偿以解决镜头失真的问题，你可以在 **镜头参数（Lens Parameters）** 部分设置镜头的物理属性。

   > 图片已省略：Lens undistortion parameters

   点击查看大图。

   这些 **镜头参数（Lens Parameters）** 只是设置了镜头的物理属性。稍后编辑媒体束使用的材质实例时，你将实际激活镜头补偿。 设置完媒体束的属性后，保存媒体束，并返回到内容浏览器中的 **AJA** 文件夹。
8. 将你的 **AjaMediaBundle** 资源从内容浏览器拖到关卡视口中。

   > 图片已省略：Drag and drop the Media Bundle

   点击查看大图。

   你将看到一个新的平面出现，显示当前在为你的媒体束配置的端口上播放的视频。使用视口（Viewport）工具栏中的变形工具来移动、旋转和调整它的大小。 如果你的媒体束没有自动开始播放，选择它，然后单击 **详细信息（Details）** 面板中的 **媒体束（Media Bundle）> 请求播放媒体（Request Play Media）** 按钮。

   > 图片已省略：请求播放媒体
9. 现在，我们将了解如何将抠像和合成效果应用到视频流。 回到媒体束编辑器中，单击工具栏中的 **打开材质编辑器（Open Material Editor）** 按钮，编辑这个媒体束用于将其传入视频源绘制到关卡中对象上的材质实例。

   > 图片已省略：打开材质编辑器

   > [!TIP]
   > 此材质实例保存在 **AjaMediaBundle_InnerAssets** 文件夹中，该文件夹是用你的媒体束自动创建的。
   >
   > > 图片已省略：Material Instance
   >
   > 点击查看大图。
10. 在材质实例编辑器中，你将看到为供你配置抠像、剪辑和颜色校正以及激活你在媒体束中设置的镜头失真校正而公开的许多属性。

    > 图片已省略：Material Instance Editor

    点击查看大图。

    当你在材质实例编辑器中调整设置时，你可以看到你的更改对在主关卡视口中播放的视频源的影响。

    > [!TIP]
    > 你可能会发现在材质实例编辑器的预览面板中查看所做更改的效果更为方便。为此，临时启用 **IsValid** 设置，并将其值设置为"1.0"。
    >
    > > 图片已省略：IsValid
    >
    > 单击视口工具栏左上角的箭头，并在菜单中启用 **实时（Realtime）** 选项。
    >
    > > 图片已省略：实时视口
    >
    > 通过将预览网格体更改为平面或立方体，你将能够更容易地判断更改的效果。使用视口底部的控件：
    >
    > > 图片已省略：预览网格体
    >
    > 完成后，将 **IsValid** 设置返回到它的前一个值。
11. 更改完材质实例属性后，单击工具栏中的 **保存（Save）** 按钮。

### 最终结果

此时，你应该正在虚幻引擎关卡内的SDI端口上播放视频，并且应该了解如何设置更高级的功能，如镜头变形和色度抠像。

如果你已经熟悉媒体框架，那么另一种将视频引入你的关卡的方法是在你的项目中创建一个新的 **AjaMediaSource** 资源，并使用你在上述过程中在媒体束中设置的相同源属性对其进行设置。然后，创建你自己的 **MediaPlayer** 和 **MediaTexture** 资源，以便在你的关卡上处理该源的播放。详情请参阅[媒体框架](../../media-framework/index.md)文档。但是，我们建议使用上述媒体束，以在易用性和专业高质视频特性之间取得最佳平衡。

## 3 - 从虚幻编辑器输出采集

在此过程中，你将设置一个AJA媒体输出对象，并使用虚幻编辑器中的 **媒体采集（Media Captures）** 面板将关卡中所选摄像机的视图输出到你的AJA卡。

### 步骤

1. 在内容浏览器中右键单击，选择 **媒体（Media）> Aja媒体输出（Aja Media Output）**。

   > 图片已省略：New AJA Media Output

   点击查看大图。

   将你的新资源命名为 **AjaMediaOutput**。
2. 双击你的新资源打开它进行编辑。就像创建Aja媒体源一样，你必须设置 **配置（Configuration）** 属性来控制虚幻引擎发送到AJA卡的视频源属性。单击箭头以打开子菜单，选择与你的视频设置匹配的选项，然后单击子菜单中的 **应用（Apply）**。

   > 图片已省略：Aja Media Output Configuration

   点击查看大图。

   有关你可以在AJA媒体输出中设置的所有属性的详细信息，请参阅[AJA媒体引用](../aja-media-reference/index.md)页面。完成后，保存并关闭你的媒体输出。
3. 现在我们将在关卡中放置两个摄像机，为我们将发送到AJA卡的输出提供视点。在 **放置Actor（Place Actors）** 面板中，打开 **过场动画（Cinematic）** 选项卡，并将 **过场动画摄像机Actor（Cine Camera Actor）** 的两个实例拖放到视口中。

   > 图片已省略：拖放过场动画摄像机Actor

   将摄像机放置在关卡中你想要的位置，这样它们就能显示场景上的不同视点。

   > [!TIP]
   > **导航** 摄像机是一种完全按照你想要的方式来设置摄像机视点的快速而简便的方法。请参阅[在视口中导航Actor](https://dev.epicgames.com/documentation/unreal-engine/using-editor-viewports-in-unreal-engine)。
4. 从主菜单选择 **窗口（Window）> 虚拟制片（Virtual Production） > 媒体采集（Media Capture）**。你将使用 **媒体采集（Media Capture）** 窗口来控制编辑器何时向你的AJA端口发送输出，以及它在关卡中应该使用什么摄像机。

   > 图片已省略：媒体采集窗口
5. 在 **媒体视口采集（Media Viewport Capture）** 区域下，找到 **视口采集（Viewport Captures）** 控件。单击 **Add（+）** 按钮将新的采集添加到此列表。

   > 图片已省略：添加视口采集
6. 展开新条目。首先，我们将添加想要从中进行采集的摄像机。在 **锁定的摄像机Actor（Locked Camera Actors）** 控件中，单击 **Add（+）** 按钮添加新条目。

   > 图片已省略：添加摄像机Actor

   然后，使用下拉列表选择你放置在关卡中的摄像机之一。

   > 图片已省略：选择摄像机Actor

   重复相同的步骤将另一个摄像机添加到列表中。
7. 现在，设置要采集这些摄像机的输出。将 **媒体输出（Media Output）** 控件设置为指向你在上面创建的新AJA媒体输出资源。为此，你可以在下拉列表中选择它，或者从内容浏览器中拖动AJA媒体输出资源并将其放入此槽中。

   > 图片已省略：Set the AJA Media Output
8. 在窗口顶部，单击 **采集（Capture）** 按钮。

   > 图片已省略：开始采集

   你将在窗口底部看到一个新框架，该框架显示要发送到AJA卡的输出的预览。如果你已经将这个端口连接到另一个下游设备，你应该会开始看到输出。

   > 图片已省略：激活媒体采集
9. 为此视口采集而添加到锁定的摄像机Actor（Locked Camera Actors）列表中的各个摄像机由视频预览上方的相应按钮表示。单击这些按钮在两个视图之间来回切换采集。

   > 图片已省略：Switch Cameras

   点击查看大图。

### 最终结果

现在你已经设置虚幻编辑器，以将你关卡中的摄像机输出流送到AJA卡上的端口。接下来，我们将看到如何在正在运行的虚幻引擎项目中使用蓝图脚本执行相同的操作。

## 4 - 在运行时输出采集

你在上一部分中使用的 **媒体采集（Media Capture）** 窗口是一种向AJA卡发送采集的实用且简单的方法。然而，它仅可在虚幻编辑器中使用。要在将项目作为独立应用程序运行时执行相同的操作，需要使用媒体输出提供的蓝图API。在这个过程中，我们将在关卡蓝图中设置一个简单的切换开关，在玩家按下键盘上的某个键时，该开关会启动或停止采集。

> [!TIP]
> Epic Games启动器的 **示例（Samples）** 选项卡所提供的 **[Virtual Studio](../../../../samples-and-tutorials/engine-feature-examples/virtual-studio-sample-project/index.md)** 演示项目包含一个UMG界面控件，演示了如何通过屏幕用户界面来控制采集过程。

### 步骤

1. 从虚幻编辑器中的主工具栏中，选择 **蓝图（Blueprints）> 打开关卡蓝图（Open Level Blueprint）**。

   > 图片已省略：打开关卡蓝图
2. 我们需要从你创建的AJA媒体输出资源开始，你将在该资源中标识要输出到的端口。在 **我的蓝图（My Blueprint）** 面板的 **变量（Variables）** 列表中，单击 **Add（+）** 按钮添加新变量。

   > 图片已省略：新变量
3. 在 **详细信息（Details）** 面板中，将 **变量名（Variable Name）** 设置为 **AjaMediaOutput**，并使用 **变量类型（Variable Type）** 下拉列表使其成为 **Aja媒体输出对象引用（Aja Media Output Object Reference）**。

   > 图片已省略：Aja媒体输出对象引用
4. 启用 **可编辑实例（Instance Editable）** 设置(1)，并编译蓝图。然后，在 **默认值（Default Value）** 部分中，将变量设置为指向你在内容浏览器(2)中创建的AJA媒体输出资源。

   > 图片已省略：设置默认值
5. 按 **Ctrl**，将 **AjaMediaOutput** 从 **我的蓝图（My Blueprint）** 面板中的变量列表拖放到 **事件图表（Event Graph）** 中。

   > 图片已省略：按Control并拖放AjaMediaOutput
6. 单击并从 **AjaMediaOutput** 变量节点的输出端口拖动，选择 **媒体（Media）> 输出（Output）> 创建媒体采集（Create Media Capture）**。

   > 图片已省略：创建媒体赛季

   将你的节点连接到 **事件BeginPlay（Event BeginPlay）** 节点，如下所示：

   > 图片已省略：时间开始播放

   这将从Aja媒体输出创建一个新的媒体采集对象。媒体采集提供了两个主要的蓝图函数，我们将使用它们来控制采集：**采集活动场景视口（Capture Active Scene Viewport）** 和 **停止采集（Stop Capture）**。
7. 首先，我们将把新媒体采集对象保存到它自己的变量中，这样我们就可以在其他地方再次访问它。单击并从 **创建媒体采集（Create Media Capture）** 节点的输出端口拖动，选择 **提升到变量（Promote to Variable）**。

   > 图片已省略：提升变量

   在 **我的蓝图（My Blueprint）** 面板的变量列表中将新变量重命名为 **MediaCapture**。

   > [!TIP]
   > 务必在这里将媒体采集保存为变量。如果不这样做，虚幻引擎的垃圾回收器可能会在你用完它之前自动销毁它。
8. 按 **Ctrl** 并将 **MediaCapture** 变量拖动到 **事件图表（Event Graph）** 中。

   > 图片已省略：按Control并拖放MediaCapture
9. 从 **MediaCapture** 变量节点的输出端口点击拖动，选择 **媒体（Media）> 输出（Output）> 采集活动场景视口（Capture Active Scene Viewport）**。再做一次，选择 **媒体（Media）> 输出（Output）> 停止采集（Stop Capture）**。

   > 图片已省略：开始和停止采集
10. 右键单击 **事件图表（Event Graph）**，选择 **输入（Input）> 键盘事件（Keyboard Events）> P**。单击并拖动 **P** 节点的 **已按下（Pressed）** 输出，选择 **流程控制（Flow Control）> FlipFlop**。

    > 图片已省略：FlipFlop
11. 将 **FlipFlop** 节点的 **A** 输出连接到 **采集活动场景视口（Capture Active Scene Viewport）** 节点的输入事件，将 **FlipFlop** 节点的 **B** 输出连接到 **停止采集（Stop Capture）** 节点的输入事件，如下图所示：

    > 图片已省略：连接节点
12. 编译并保存蓝图，并尝试运行你的项目。单击主工具栏运行（Play）按钮旁边的箭头，选择 **新建编辑器窗口（在编辑器中运行）（New Editor Window (PIE)）** 或 **独立窗口运行（Standalone Game）** 选项。

    > 图片已省略：启动项目

    > [!NOTE]
    > 只有当你在 **新建编辑器窗口（在编辑器中运行）（New Editor Window (PIE)）** 或 **独立窗口运行（Standalone Game）** 中运行项目时，来自编辑器的视频采集才会工作。它不能在默认的 **选中的视口（Selected Viewport）** 模式或 **模拟（Simulate）** 模式下工作。 此外，项目的视口分辨率（即虚幻引擎生成的每个帧的渲染图像大小）必须与活动媒体配置文件中的输出分辨率集匹配，使它是输出视频源的正确大小。

    项目启动后，你应该能够按键盘上的 **P** 按钮来切换将输出从引擎发送到AJA卡。

### 最终结果

至此，你应该对如何使用Aja媒体源、媒体束和媒体采集系统有了基本的了解，并且应该了解所有这些元素如何协力工作，以在虚幻引擎中输入和输出专业视频。

## 自学

现在你已经了解了使用AJA卡交换视频输入和输出的新项目的基本知识，你可以继续自学：

- 在你的媒体束创建的材质实例中探索引擎内抠像解决方案。尝试将一些绿屏视频传递到卡的输入端口，并使用材质实例中的抠像控件来移除背景。
- 浏览

  Virtual Studio

  展示，看看它为这个基本设置添加了什么，比如它的屏幕上的UI，此UI可以在运行时切换摄像机和控制视频采集。


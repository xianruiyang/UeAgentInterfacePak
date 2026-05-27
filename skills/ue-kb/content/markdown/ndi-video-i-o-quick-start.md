# NDI Video I/O Quick Start

---
title: "NDI Video I/O Quick Start"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndi-video-io-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "专业视频I/O", "NDI Video I/O Quick Start"]
---

# NDI Video I/O Quick Start

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 专业视频I/O / NDI Video I/O Quick Start

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndi-video-io-quick-start-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

在本快速入门指南中，我们会逐步介绍如何设置 Unreal Engine 项目，使其通过 NDI 处理视频输入和输出。完成本指南后：

- 来自 NDI 源的视频输入会在 Unreal Engine 项目内播放。
- 你将能够从编辑器和运行时应用捕获摄像机视角，并通过 NDI 将其作为流发送出去。

> [!TIP]
> 如需查看将下述许多元素付诸实践的可运行示例，请参阅[Virtual Studio](https://dev.epicgames.com/documentation/en-us/unreal-engine/virtual-studio-sample-project-in-unreal-engine) 展示项目，该项目可在 Epic Games Launcher 的 Samples 标签页中获得。

> [!NOTE]
> **前提条件**:
>
> - 请确保已从 NDI 网站下载并安装 NDI Tools。
> - 请确保已设置 NDI 源，并且它正在推送某个视频流。NDI Test Patterns 是很好的起点。
> - 打开要与视频流集成的 Unreal Engine 项目。本页在启用了蓝图的空项目中演示步骤，但相同步骤也适用于任何项目。

本指南使用的 NDI Media 组件构建在 [Media Framework](../../media-framework/index.md)之上，并且你将使用 [Blueprint](../../../../blueprints-visual-scripting/index.md) 在运行时编写视频捕获流程脚本。建议具备这些主题的基础知识，但不是必需条件。

## 1 - 设置项目

在将 NDI 源的视频输入到 Unreal Engine 关卡，并使用 NDI 从 Unreal Engine 输出流之前，需要进行一些基本设置，在项目中启用 NDI Media Player 插件。

### 步骤

1. 在 Unreal Editor 中打开要与 NDI 一起使用的项目。
2. 从主菜单中选择 **Edit > Plugins**.
3. 在 Plugins 窗口中，在 Media Players 类别下找到 NDI Media Player 插件。勾选它的 Enabled 复选框。

   ![NDI plugin](../../../../../assets/images/9a/9a51380197f0bd1de070cb2264c80ace8399f35c558b3357954e7ff9fd1ed9b3.jpg)
4. 在 Media Players 类别下找到 Media Framework Utilities 插件。如果尚未勾选，请勾选它的 Enabled 复选框。

   ![Media Framework Utilities plugin](../../../../../assets/images/77/772600fe753ddc1c4761e42f31386c9b1bbc58e7911069c61057bf0653000f05.jpg)
5. 点击 **Restart Now** 重启 Unreal Editor 并重新打开项目。

   ![Restart Unreal Engine](../../../../../assets/images/ba/ba887be6140d5c3eb814570aecffc7410cebcb48e44397123f4632f740e0edeb.jpg)

### 结果

项目现在已经可以接收来自 NDI 源的视频，并使用 NDI 流式传输渲染输出。在接下来的部分中，你会完成设置并开始输入/输出视频。

## 2 - 在 Unreal Engine 中渲染视频输入

在此流程中，你会让来自 NDI 源的视频输入显示在 Unreal Editor 当前关卡中。此流程使用 [Media Plate](../../the-media-plate-actor/index.md) Actor，这是一种显示视频输入的直接方式，会自动设置在多数情况下可用的标准设置。

### 步骤

1. 打开 **Content Drawer**，并选择 **Content**文件夹。右键单击，并选择 **New Folder** 。将新文件夹命名为 **NDI**.

   ![New NDI folder](../../../../../assets/images/9f/9f494a18ea5ee7957ff05be40b8906cbc22e104849694ffe71ecbed7d0d35416.jpg)
2. 打开新文件夹，然后右键单击并选择 **Media > NDI Media Source**.

   ![New NDI Media Source](../../../../../assets/images/f8/f8dcaf00957bb10aec5e21d8fde8f23346455d5e66470db9745a0c90c65e90a4.png)
3. UE 会自动命名新资产，因此将其重命名为更具描述性的名称，例如 **NDI_Quick_Start_Source**.

   ![Rename NDI Media Source](../../../../../assets/images/8b/8bd78ae43481f75b3da7239647fef0f032e1d3e313c23774aec37cf9e73e3271.jpg)
4. 点击 **Save All** 按钮保存新资产，该按钮位于 **Content Drawer**，也可以按 Ctrl+S。

   ![Save all](../../../../../assets/images/85/856170e2e5bed89c54891625ecfe9036255d297f7f7e1ed75a969b7451ba9acd.jpg)
5. 双击 **NDI Media Source** 资产，在 **Media Editor**中打开它。如果本地只运行一个 NDI 源，它会在 **Configuration**下拉菜单中被自动检测为默认媒体源。不过，NDI 测试图案还不会显示在播放窗口中。

   ![NDI Media Source open in Unreal Editor](../../../../../assets/images/4f/4f173816362de38d49355944c1e06213a2e5a5a026f378df444ac432766fa370.jpg)
6. 点击 **打开**（位于 Toolbar）以显示来自 NDI 源的媒体。现在可以在播放窗口中看到所选 NDI 测试图案。对于本快速入门，其他设置保持默认即可。完成后保存并关闭 Media Source。

   > [!TIP]
   > 有关 NDI Media Source 设置的更多信息，请参阅 [NDI Media Reference](../ndi-media-reference/index.md).

   > 图片已省略：Open the NDI test pattern source
7. 返回 **Content Drawer**，然后将 **NDI Media Source** 资产拖入关卡。这会自动创建一个 **Media Plate** Actor，并将其连接到 NDI Media Source。

   > 图片已省略：Drag NDI Media Source
8. 最初，Media Plate Actor 不会显示 NDI 测试图案。选择 **Media Plate** Actor，该 Actor 位于 **World Outliner** 面板，然后点击 **Open Media Plate** ，该按钮位于 **Details**面板，用编辑器打开 Media Plate Actor。

   > 图片已省略：Media Plate actor before opening media
9. 在编辑器中点击 **打开**，该按钮位于 **Toolbar**。NDI 测试图案现在会显示在播放窗口中。

   > 图片已省略：NDI test pattern in Media Plate actor in the Unreal Editor
10. 返回 Viewport，此时 Media Plate Actor 会在关卡中显示 NDI 媒体。

    > 图片已省略：NDI test pattern on Media Plate actor in UE level

### 结果

此时，来自 NDI 源的媒体应已在 Unreal Engine 关卡中的 Media Plate Actor 上显示。如果想修改 Media Plate Actor 的显示设置，请参阅 [Media Plate](../../the-media-plate-actor/index.md) 文档以获取更多信息。

## 3 - 从 Unreal Editor 输出捕获

在此流程中，你将设置 NDI Media Output 对象，并使用 **Media Captures** 面板（位于 Unreal Editor 中），将关卡中所选摄像机的视图输出到外部 NDI 播放应用，例如 NDI Studio Monitor。

### 步骤

1. 在 **Content Drawer**中右键单击，并选择 **Media > NDI Media Output**.

   > 图片已省略：Create NDI Media Output
2. UE 会自动命名新资产，因此将其重命名为更具描述性的名称，例如 **NDI_Quick_Start_Output**.

   > 图片已省略：Rename NDI Media Output
3. 双击新 Asset 打开并进行编辑。Source Name 有一个由 UE 定义的默认名称，因此将其改为更具体的名称，例如 **NDI Quick Start**。此名称是在 NDI 工具中标识该源的方式。对于本快速入门，其他设置保持默认即可。完成后保存并关闭 Media Output。

   > [!TIP]
   > 有关 NDI Media Output 设置的更多信息，请参阅 [NDI Media Reference](../ndi-media-reference/index.md).

   > 图片已省略：Change NDI Source Name
4. 现在在关卡中放置两个摄像机，为将发送到外部 NDI 播放应用的输出创建视角。在 Place Actors 面板中打开 Cinematic 标签页，并将两个 Cine Camera Actor 实例拖入 Viewport。

   > 图片已省略：Place Cine Camera actors

   将摄像机放在关卡中所需位置，使它们显示场景中的不同视角。

   > [!TIP]
   > 驾驶摄像机是一种快速简单的方式，可精确设置所需视角。请参阅 [使用编辑器视口](https://dev.epicgames.com/documentation/unreal-engine/using-editor-viewports-in-unreal-engine?application_version=5.7) 获取更多信息。
5. 从主菜单中选择 **Window > Virtual Production > Media Capture**。你将使用 **Media Capture**窗口控制编辑器何时向外部 NDI 应用发送输出，以及应使用关卡中的哪台摄像机。

   > 图片已省略：Media Capture window
6. 在 **Media Viewport Capture** 区域下，找到 **Viewport Captures** 控件。点击 **Add (+)** 按钮，向列表添加新的捕获。

   > 图片已省略：Add a Viewport Capture
7. 展开新条目。首先添加要从中捕获的摄像机。在 **Cameras** 数组中点击 **Add (+)** 按钮添加新条目。

   > 图片已省略：Add a Camera to the array

   然后使用下拉列表选择刚才放置在关卡中的其中一台摄像机。

   > 图片已省略：Add a Camera actor to the array

   重复相同步骤，将另一台摄像机添加到列表。
8. 接下来，设置这些摄像机要捕获到的输出。将 **Media Output** 控件指向上文创建的新 NDI Media Output Asset。可以在下拉列表中选择它，也可以从 Content Drawer 拖动 NDI Media Output Asset 并放入此插槽。

   > 图片已省略：Select the Media Output
9. 在窗口顶部点击 Capture 按钮。

   > 图片已省略：Capture Media button

   窗口底部会出现一个新帧，用于预览正在发送到外部 NDI 输出的内容。如果外部 NDI 源已连接到另一个播放应用或设备，应能开始看到传来的输出。

   > 图片已省略：Camera Viewport Capture
10. 为此视口捕获添加到 Cameras 数组列表的每台摄像机，都会由视频预览上方的对应按钮表示。点击这些按钮即可在两个视图之间来回切换捕获。

    > 图片已省略：Swap viewport captures

### 结果

现在已经设置 Unreal Editor，将关卡中摄像机的输出流式传输到外部 NDI 播放应用。接下来，你将了解如何在运行中的 Unreal Engine 项目中使用蓝图脚本完成相同操作。

> 图片已省略：UE output playing in the NDI Studio Monitor app

## 4 - 运行时输出捕获

该 **Media Capture** 窗口（上一节中使用）是一种实用而简单的方式，可将捕获发送到外部 NDI 播放应用。不过，它只在 Unreal Editor 内工作。要在项目作为独立应用运行时完成相同操作，需要使用 Media Output 提供的 Blueprint API。在此流程中，我们会在关卡蓝图中设置一个简单的切换开关，让玩家按下键盘按键时开始和停止捕获。

> [!TIP]
> 该 [Virtual Studio](../../../../samples-and-tutorials/engine-feature-examples/virtual-studio-sample-project/index.md) 展示项目（位于 Epic Games Launcher 的 **Samples** 标签页）包含一个 UMG 界面 widget，演示如何从屏幕 UI 控制捕获。

### 步骤

1. 从 Unreal Editor 主工具栏中选择 **Blueprints > Open Level Blueprint**.

   > 图片已省略：Open Level Blueprint
2. 从已创建的 NDI Media Output Asset 开始。在 **Variables** 列表中，该列表位于 **My Blueprint** 面板，点击 **Add (+)** 按钮添加新变量。

   > 图片已省略：Create a new variable
3. In the **Details** 面板中，将 **Variable Name** 设置为 **NDI_Media_Output**，并使用 **Variable Type** 下拉列表将其设为 **NDI Media Output Object Reference**.

   > 图片已省略：NDI Media Output Object Reference variable
4. 启用 **Instance Editable** 设置（1），并编译 Blueprint。然后在 **Default Value** 部分中，将变量设置为指向在 Content Drawer 中创建的 NDI Media Output 资产（2）。

   > 图片已省略：Edit the variable settings
5. 按住 **Ctrl**，并将 **NDI_Media_Output** 从 **Variables** 列表中，该列表位于 **My Blueprint** 面板拖入 **Event Graph**.

   > 图片已省略：Drag variable on to the Event Graph
6. 从 **NDI_Media_Output** 变量节点的输出端口点击并拖出，选择 **Media > Output > Create Media Capture**.

   > 图片已省略：Create Media Capture node

   将节点连接到 **Event BeginPlay** 节点，如下所示：

   > 图片已省略：Connect the Event BeginPlay node

   这会从 NDI Media Output 创建新的 Media Capture 对象。Media Capture 提供两个主要 Blueprint 函数，用于控制捕获： **Capture Active Scene Viewport** 和 **Stop Capture**。
7. 首先，将新的 Media Capture 对象保存到它自己的变量中，以便在其他位置再次访问它。从 **Create Media Capture** 节点的输出端口点击并拖出，选择 **Promote to Variable**.

   > 图片已省略：Promote to variable

   将新变量重命名为 **Media_Capture** ，该变量位于 My Blueprint 面板的 Variables 列表中。

   > 图片已省略：Rename the variable

   > [!TIP]
   > 这里必须将 Media Capture 保存到变量中。如果不这样做，Unreal Engine 的垃圾回收器可能会在你使用完它之前自动销毁它。
8. 按住 **Ctrl**并将 **Media_Capture** 变量拖入 **Event Graph**.

   > 图片已省略：Drag Media_Capture variable into the Event Graph
9. 从 **Media_Capture** 变量节点的输出端口点击并拖出，选择 **Media > Output > Capture Active Scene Viewport**。再次执行相同操作，并选择 **Media > Output > Stop Capture**.

   > 图片已省略：Create Media Output control options
10. 在 **Event Graph** and choose **Input > Keyboard Events > P**. Click and drag from the **Pressed** 输出端口拖出，该端口位于 **P** 节点，然后选择 **Flow Control > Flip Flop**.

    > 图片已省略：Create Keyboard Input P and Flip Flop nodes
11. 将 **A** 输出端口拖出，该端口位于 **Flip Flop** 节点连接到 **Capture Active Scene Viewport** 节点，并将 **Flip Flop** 节点的 **B** 输出连接到 **Stop Capture** 节点，如下所示：

    > 图片已省略：Connect the Flip Flop node to the Media Output nodes
12. 编译并保存 Blueprint，然后尝试运行项目。点击主 Toolbar 中 Play 按钮旁的箭头，并选择 **New Editor Window (PIE)** 或 **Standalone Game** 选项。

    > 图片已省略：Select Play mode

    > [!NOTE]
    > 只有在 New Editor Window (PIE) 或 Standalone Game 中运行项目时，编辑器视频捕获才会工作。它不会在默认 Selected Viewport 模式或 Simulate 模式下工作。此外，项目的视口分辨率（即 Unreal Engine 每帧生成的渲染图像尺寸）必须匹配活动 Media Profile 中设置的输出分辨率，才能得到正确尺寸的输出视频源。

    项目启动后，应能按键盘上的 P 键切换是否将引擎输出发送到外部 NDI 应用。

### 结果

此时，你应该已基本了解如何使用 NDI Media Source 资产、NDI Media Output 资产和 Media Capture 系统，也应该理解这些元素如何协同工作，通过 NDI 和 Unreal Engine 发送和接收视频。

## 自主练习

现在你已经了解如何让新项目通过 NDI 工具交换视频输入和输出的基础知识，可以继续自行学习：

- 探索 [Virtual Studio](../../../../samples-and-tutorials/engine-feature-examples/virtual-studio-sample-project/index.md) 展示项目，了解它在此基础设置上添加了哪些内容，例如用于在运行时切换摄像机并控制视频捕获的屏幕 UI。


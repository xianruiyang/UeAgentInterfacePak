# Twinmotion 到虚幻引擎 5.1/5.2 的虚拟相机工作流程

# Twinmotion 到虚幻引擎 5.1/5.2 的虚拟相机工作流程

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/K8nX/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 8826 字符。

## 摘要

本教程介绍如何将 Twinmotion 场景导出到虚幻引擎 5.1 或 5.2 中，以便使用虚幻引擎虚拟摄像机。当通过模拟真实电影摄影机的虚拟摄影机评估您的 Twinmotion 设计时，这可能非常有用。

## 中文整理

### Twinmotion 到虚幻引擎 5.1/5.2 的虚拟相机工作流程

对于本教程，您需要在开始之前下载并安装以下内容： - [Unreal Engine 5.1 / 5.2*](https://unrealengine.com/en-US/download) - [Twinmotion 2023.1](https://twinmotion.com/license) *本教程是使用 Unreal Engine 5.1 编写的，但也适用于 Unreal Engine 5.2。如果使用 UE 5.2，则只需假设 5.1 始终为 5.2。这些是我用于测试此工作流程的 Twinmotion 场景的屏幕截图

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-01.jpg)

### 为 Twinmotion ICVFX 或 VCam 创建 UE 5.1 项目

1. 首先，从虚幻引擎市场下载“[Datasmith Twinmotion Importer Plugin](https://www.unrealengine.com/marketplace/en-US/product/21cab2d84a794b7bab359eb1ba5d3e74)”5.1版本。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-02.jpg)

2. 成功下载后，如果您通过网络浏览器使用 Marketplace 网站，请单击 **在启动器中打开**。如果您从 Epic Games 启动器获取了该插件，则可以跳过此步骤。 3. 在 Vault 下找到 Datasmith Twinmotion Importer Plugin，然后单击 **安装到引擎**。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-03.jpg)

4. 从插槽中选择 UE 5.1，将插件添加到下拉菜单。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-04.jpg)

5. 安装完成后，从 UE Marketplace 下载 [Datasmith Twinmotion Content for Unreal Engine](https://www.unrealengine.com/marketplace/en-US/product/datasmith-twinmotion-content-for-unreal-engine) 5.1 版本。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-05.jpg)

6. 成功下载后，如果您通过网络浏览器使用 Marketplace 网站，请单击 **在启动器中打开**。如果您从 Epic Games 启动器获取了插件，则可以跳过此步骤。 7. 单击**安装到引擎**，然后从插槽添加插件到下拉菜单中选择 UE 5.1。这将需要相当长的时间，因为它有 31.9 GB 的数据。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-06.jpg)

8. 在 UE 5.1 中，使用 InCameraVFX 模板创建一个新项目。指定这个新项目的位置和项目名称。启用光线追踪。然后单击**创建**按钮。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-07.jpg)

这将使用新项目启动虚幻引擎 5.1 编辑器的实例。这可能需要一些时间，因为 UE 需要编译着色器等。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-08.jpg)

UE 打开后，您可能会在编辑器的右侧看到一些弹出窗口。没关系。这些是此类项目需要安装的依赖项。

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-09.jpg)

![教程图片](assets/twinmotion-to-unreal-engine-5-1-5-2-for-virtual-camera-workflows/image-10.jpg)

9. 现在让我们启用一些我们需要的插件。转到设置 -> 插件。可以从主编辑菜单或屏幕右上角访问它。 10. 插件窗口打开后，启用以下插件： 1. Datasmith Importer 2. Dataprep Editor 3. Sun Position Calculator 4. Datasmith Twinmotion Importer 5. Twinmotion Content 11. 单击 **立即重新启动。**

### 笔记：

如果您之前安装了旧版本的 Twinmotion Content for Unreal Engine 插件，则必须将其删除。该插件的更新版本称为 Datasmith Twinmotion Content for Unreal Engine。您不能同时安装这两个插件。仅使用最新版本并卸载以前的版本。您可以通过打开 Epic Games 启动器来检查 UE 5.1 版本中安装了哪些插件。您将在“库”选项卡中找到已安装的虚幻引擎版本的列表。在 Unreal Engine 5.1 版本下方，单击 **Installed Plugins** 以查看您是否安装了旧版 Twinmotion Content for Unreal Engine 插件。如果是这样，请将其删除。

### 如何在虚幻引擎中导入 Twinmotion 文件

基于 Datasmith 的工作流程与[导入 *.udatasmith 文件](https://docs.unrealengine.com/5.1/en-US/importing-datasmith-content-into-unreal-engine/) 相同。

### 从 Twinmotion 导出 Datasmith 文件：

Datasmith 文件可以从“文件”菜单导出。导出过程需要一些时间才能完成，在此过程中应出现以下窗口：

### 在虚幻引擎中导入 Datasmith 文件：

1. 在虚幻引擎中导入 Datasmith 文件之前，创建一个新的基本关卡。 2. 然后，您可以将Datasmith文件导入到UE中。 1. 单击顶部菜单栏中的获取内容按钮（带有十字的立方体），然后选择 Datasmith -> 文件导入。 b.选择您从 Twinmotion 导出的 .udatasmith 文件。选择导入 Datasmith 内容的位置。例如，我刚刚创建了一个名为 TM 的文件夹。您可以保留默认设置，因为以后可以根据需要进行调整。这是导入 Datasmith 文件后的文件夹示例。您将看到它创建了一个名为 Twinmotion 项目名称的新文件夹，在该文件夹中，您将看到一个 Datasmith 场景和一些必需的文件夹。

### 创建和使用虚拟相机

Unreal Engine 5.1 文档 [虚拟摄像机 Actor 快速入门指南](https://docs.unrealengine.com/5.1/en-US/using-virtual-cameras-in-unreal-engine/) 提供了在场景中使用 VCam Actor 的分步说明。在本指南结束时，您将能够： - 将 VCam Actor 放置在场景中 - 通过 Live Link 连接您的 iOS 设备 - 使用 Virtual Camera Actor 的内置界面更改相机的参数 - 录制视频剪辑

### 其他有用信息

### Take Recorder多用户同步插件

在多用户编辑会话中进行录音时，*Take Recorder 多用户同步插件* 是一个有用的补充。

### 编辑器设置

在开始之前，您必须在项目中启用适当的插件。 1. 要打开插件菜单，请单击 **设置 > 插件。** 2. 搜索 *VirtualCamera*、*Take Recorder、Take Recorder 多用户同步和 Live Link* 插件并启用它们。 3. 如果出现提示，请重新启动编辑器。

### 首先启用VCam组件。

另一件需要记住的重要事情是，在将 Live Link VCAM iOS 应用程序与虚幻引擎会话连接之前，您必须始终启用 VCam 组件。即使您在 iPad 中拥有正确的工作站 IP 地址，如果您的 VCam 组件未启用，您也会收到“**错误 **无法连接：无法连接到服务器”。

### 获取你的电脑IP

您的计算机上很可能有多个 IPv4 地址，因此请确保使用属于 WiFi 连接一部分的地址。您的 iPad 必须与虚幻引擎工作站连接到同一网络才能成功通信。例如，我的计算机通过以太网线连接到家里的 WiFi 路由器。另外，我的电脑有很多以太网适配器。 1. 打开命令提示符。 2. 键入：ipconfig 3. 查看所有 IPv4 地址并选择您知道通过以太网电缆连接到 WiFi 的以太网适配器。如果您不使用硬连线连接，您的适配器将被称为“无线 LAN 适配器 WiFi”。 4. 如果您不知道，您可以测试所有可用的 IPv4 地址，直到成功将 VCam 应用程序与虚幻引擎项目连接起来。例如，下面列出了两个 IPv4 地址； 192.168.4.45 是正确的。在 [Live Link VCam iOS 应用程序](https://apps.apple.com/us/app/live-link-vcam/id1547309663) 上输入相同的 IP 地址。如果我使用其他 IPv4 地址，我只会收到“**错误**无法连接：无法连接到服务器”，您可以单击“确定”并尝试其他 IPv4 地址，直到可以连接。 UE 5.1 VCam 即插即用。只需加载插件，[添加 VCam Actor，并启用 VCam 组件](https://docs.unrealengine.com/5.1/en-US/using-virtual-cameras-in-unreal-engine/#2-addingavirtualcameraactor)，您就可以在场景中操作虚拟相机了。当您在 3D 空间中移动 iOS 设备时，虚幻编辑器的视图会发生变化以反映您的移动。此外，您现在可以在 iOS 设备上使用 VCam 界面，其中包含许多用于管理场景中虚拟摄像机的外观和行为的控件。这是通过虚拟相机看到的虚幻引擎中的 Twinmotion 项目的屏幕截图。

### 笔记

VCam 组件自动创建实时链接源。

### 像素流

UE 5.1 VCam 可以使用基于 WebRTC 的像素流，这在延迟和性能方面提供了显着的改进。虚幻编辑器必须以 24+ fps 运行才能流畅使用 VCam。 Live Link VCAM 应用程序有两种连接类型选项： - 像素流 - 远程会话 - 流式传输到 Live Link VCAM 应用程序是通过使用 jpeg-turbo 进行编码的 JPEG 流处理的。

### 最终结果

### 双动：

### UE5.1：

### iPad 中的 UE5.1 VCam 视图：

### 重新导入并使用新文件重新导入

Datasmith 可以重新导入数据并刷新设计更新。请参阅 [Datasmith 重新导入工作流程](https://docs.unrealengine.com/5.1/en-US/datasmith-reimport-workflow-in-unreal-engine/)。

### 数据准备工作流程：

由于我们使用的是 Datasmith 文件，工作流程现在与 [Dataprep](https://docs.unrealengine.com/5.1/en-US/dataprep-overview-in-unreal-engine/) 完全兼容：

## 相关链接

- [Unreal Engine 5.1 / 5.2*](https://unrealengine.com/en-US/download)
- [Twinmotion 2023.1](https://twinmotion.com/license)



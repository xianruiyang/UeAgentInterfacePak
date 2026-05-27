---
title: "Oculus Rift快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/oculus-rift-quick-start-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发", "Oculus Rift快速入门"]
---

# Oculus Rift快速入门

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发 / Oculus Rift快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/oculus-rift-quick-start-in-unreal-engine

### 目标

Oculus快速入门将带领您了解如何设置您的计算机和Oculus Rift，以便与虚幻引擎4（UE4）一起使用。

### 目的

- 为Oculus Rift头戴式显示器（HMD）下载并安装所需软件，以配合您的开发PC使用。
- 创建一个新的UE项目，专门针对Oculus Rift虚拟现实（VR）的开发。
- 设置必要的项目设置，以便您的项目可以与Oculus Rift VR HMD一起使用。

## 1 - Oculus Rift初始设置

在下面部分，我们将介绍您需要安装的软件，以便您的Oculus Rift可以与虚幻引擎一起使用。

> [!NOTE]
> 在安装Oculus runtimes期间，您需要连接互联网30到60分钟。

1. 访问[Oculus设置页面](https://www.oculus.com/setup/)，并单击页面中心的 **开始下载（Start Download）** 按钮下载Oculus runtimes。
2. **Oculus安装（Oculus Setup）** 可执行文件下载完成后，双击它开始安装过程。 Oculus_Rift_Exe_00.png

   > [!NOTE]
   > 在安装过程中，将要求您安装来自 **Oculus VR, LLC** 的设备软件。当显示此内容时，按 **安装（Install）** 按钮继续安装。

### 最终结果

当Oculus Rift软件安装完成后，打开Oculus程序，然后转到 **设备（Devices）** 选项卡。如果一切设置正确，设备（Devices）选项卡应该类似下图： 牋Oculus_Rift_DevicesTab_00.png

## 2 - 测试Rift和UE

在下面部分，我们将介绍如何设置一个新的虚幻引擎（UE）项目来与Oculus Rift一起使用。

1. 创建一个新的空白 **蓝图（Blueprint）** 项目，并将硬件设置为 **移动设备/平板电脑（Mobile / Tablet）**，显卡设置为 **可缩放的3D或2D（Scalable 3D or 2D）** 和 **不含初学者内容（No Starter Content）**。
2. 启动UE4之后，转到 **主菜单（Main Menu）** 并将 **运行（Play）** 选项从默认的 **选中的视口（Selected Viewport）** 更改为 **虚拟现实预览（VR Preview）**，按下虚拟现实预览（VR Preview）以启动关卡。 Rift_VR_Preview_00.png

### 最终结果

当虚拟现实预览（VR Preview）启动时，戴上您的HMD，您现在应该看到显示的基本关卡。您应该还能够朝任何方向旋转您的头部，如下方视频中所示。

## 3 - 看你的了！

下面有一些额外的资源，它们可以为在虚幻引擎中开发VR项目提供有用的信息。

### 文档

- 虚拟现实开发

  - [VR速查表](../../../getting-started-with-xr-development/xr-best-practices/index.md)
  - [Oculus Rift最佳实践](../../../getting-started-with-xr-development/xr-best-practices/index.md)
- Oculus文档

  - [用户指南](https://support.oculus.com/857827607684748/)
  - [开发者指南](https://developer.oculus.com/documentation/unreal/latest/concepts/unreal-engine/)

### 可尝试内容

|  |  |
| --- | --- |
| CouchKnights | Showdown |
|  |  |
| VR模式 |  |

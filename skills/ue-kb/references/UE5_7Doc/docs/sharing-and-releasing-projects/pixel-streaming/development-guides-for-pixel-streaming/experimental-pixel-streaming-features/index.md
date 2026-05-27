---
title: "试验性的像素流送功能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/experimental-pixel-streaming-features"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "像素流送", "像素流送开发指南", "试验性的像素流送功能"]
---

# 试验性的像素流送功能

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 像素流送 / 像素流送开发指南 / 试验性的像素流送功能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/experimental-pixel-streaming-features

下面的功能是令人激动的新工具，已在像素流送中实现。虽然这些功能供了新的可能性，但要注意，功能不稳定，应谨慎使用。 不建议基于这些功能构建你的产品的关键组件，因为这些功能在后续版本的虚幻引擎中可能会更改或删除。

## VCam

VCam是一个新功能，允许你将VCam组件附加到场景中的Actor，并将关卡视口的视频内容流送到输出提供程序。

在此阶段，VCam主要用于虚拟制片用例。它可以与Live Link VCam iOS应用程序配对，并用于ARKit追踪。这很适合在虚幻引擎中导航虚拟摄像机，由像素流送处理触摸事件，并将关卡视口作为实时视频内容流送回iOS设备。如需详细了解Live Link VCam，请前往下面的站点：[iOS Live Link VCam](https://apps.apple.com/au/app/live-link-vcam/id1547309663)

### 如何使用VCam

1. 确保你启用了虚拟摄像机插件
2. 添加位于"虚拟制片"下的VCam Actor。
3. 添加Actor后，你会看到如下所示的VCam视图：
4. 添加Actor后，它将开始流送。你可以通过像素流送工具栏开始和停止流送。
5. 开始后，打开本地浏览器并转至127.0.0.1以查看流送的显示内容，或打开Live Link iOS应用程序并浏览到你的计算机的IP地址，然后点击"连接"。

> [!NOTE]
> 如果你想通过浏览器与流交互，请在浏览器中打开控制面板，并将"控制方案（Control Scheme）"更改为"悬停（Hovering）"。

## 使用麦克风

利用像素流送，你现在可以允许通过Web浏览器使用WebRTC音频在引擎中播放特定对等端/播放器麦克风。

### 设置"在项目中使用麦克风"

使你的项目麦克风兼容极其简单，仅需要向你的项目添加一项内容。

1. 启用像素流送插件。
2. 在场景中的Actor上，添加 `PixelStreamingAudio` 组件。你可以将其设置保留为默认值。

> [!NOTE]
> 每个音频组件会将其自身与特定像素流送播放器/对等端关联（使用像素流送播放器ID）

### 在流中使用麦克风

1. 使用 `PixelStreamingAudio` 组件设置你的项目之后，按照像素流送的正常情况（使用像素流送启动参数打包或独立）运行你的应用程序，并启动你的信令服务器。
2. 通过Web浏览器连接到你的信令服务器。
3. 打开前端设置面板并将 `Use Mic` 设置为 `true` 。点击底部的 **重启（Restart）** 以重新连接。
4. 你的浏览器可能会请求使用麦克风的权限，请务必允许访问。
5. 向麦克风说话，你应该会听到你的声音通过流播放！

> [!NOTE]
> 云流送需要设置HTTPS，详见下文VR指南中创建HPPTS证书的步骤。此外，火狐浏览器需要HTTPS才能在本地和云部署中成功进行麦克风采集。

## 虚拟现实中的像素流送

虚拟现实（VR）像素流送是一种新功能，向用户提供了使用像素流送连接到兼容VR的应用程序的途径。这样用户可以使用自己的头戴设备享受VR体验，而不用运行本地应用程序。

### 设置项目

就本示例而言，我们将使用虚拟现实模板项目。

1. 使用虚拟现实模板创建新项目。
2. 启用像素流送插件并禁用OpenXR插件。重启编辑器。
3. 在内容浏览器（Content Browser）中，搜索"Asset_Guideline"并删除"B_AssetGuideline_VRTemplate"。系统提示时，点击 **强制删除（Force Delete）** 。
4. 现在，在内容浏览器中搜索"VRPawn"。双击打开VRPawn，然后编译蓝图。如果正常工作，它应该会成功编译。保存并关闭此蓝图。
5. 打开 **编辑器偏好设置（Editor Preferences）> 关卡编辑器（Level Editor） > 播放（Play）** 并添加 `-PixelStreamingURL=ws://127.0.0.1:8888 -PixelStreamingEnableHMD -ResY=1080`。

> [!NOTE]
> 你只需指定垂直分辨率即可，因为水平分辨率会自动调整以适应设备的纵横比。请根据你的性能与质量比值来设定最佳分辨率。

### 创建必需证书

你需要HTTPS证书才能将VR用于像素流送。这是因为，WebXR的标准要求该API仅可用于通过安全连接（HTTPS）加载的站点。对于制片用途，你将需要使用安全的来源，以支持WebXR。你可以在此处找到有关这些要求的额外信息：[https://developer.oculus.com/documentation/web/port-vr-xr/#https-is-required](https://developer.oculus.com/documentation/web/port-vr-xr/#https-is-required)。

就本示例而言，我们将通过Gitbash设置基本证书。如果你之前没有安装Gitbash，请前往此处的页面，了解Gitbash的安装步骤：[https://www.atlassian.com/git/tutorials/git-bash](https://www.atlassian.com/git/tutorials/git-bash)。

1. 在 `SignallingWebServer` 目录中创建 `certificates` 文件夹，如下所示：
2. 在 `certificates` 目录中右键点击，然后打开Gitbash。输入 `openssl req -x509 -newkey rsa:4096 -keyout client-key.pem -out client-cert.pem -sha256 -nodes` 。
3. 按Enter键多次，直到命令完成。当certificates文件夹中创建了2个 `.pem` 文件时，命令即完成。
4. 打开位于 `SignallingWebServer` 文件夹中的 `config.json` 文件，将 `https` 值设置为 `true` 。如果缺失`config.json`，请运行一次信令服务器。

你现在应该可以开始运行并测试你的VR应用程序！

> [!NOTE]
> 上面创建的证书仅用于测试用途。如需完整云部署，你将需要整理恰当的证书。

### 加入VR流

就本示例而言，我们将使用Meta Quest 2。

1. 启动位于 `\SignallingWebServer\platform_scripts\cmd` 中的 `start_with_stun.bat` 脚本
2. 返回编辑器，独立运行应用程序。因为你在之前步骤中添加了启动参数，所以它应该在完全启动之后连接到信令服务器。
3. 现在使用你的VR头戴设备，打开Web浏览器并输入你的计算机的IP地址。你将看到"连接不安全（Connection not secure）"页面，打开"高级（Advanced）"选项卡并点击"继续到IP（Proceed to IP）"
4. 你应该会在浏览器窗口中看到应用程序流送到两个视图。点击左侧的XR按钮以切换到VR。
5. 大功告成！现在你应该位于你的像素流送的VR项目中！

## 像素流送播放器

像素流送播放器可以让你在虚幻引擎项目的3D空间中的显示屏上显示的活跃像素流送。有了它，你就可以将云托管的内容作为媒体源，本地应用程序中播放。

> [!WARNING]
> 像素流送播放器是一项实验性功能，其API目前还在开发中。截至5.4版本，像素流送播放器兼容TH264、VPX和AV1解码器。

> [!NOTE]
> 像素流送播放器的设置在Pixel Streaming 2插件中有所变化。更多详情请参阅[Pixel Streaming 2概览](../pixel-streaming-2-overview/index.md)。

### 设置像素流送播放器

1. 启用像素流送（Pixel Streaming）和像素流送播放器（Pixel Streaming Player）插件。
2. 新建一个 **蓝图** 类（Actor）。保存并根据自身需要为其命名。
3. 打开新建的蓝图类，添加两个组件， **PixelStreamingSignalling** 和**PixelStreamingPeer**。
4. 将 **PixelStreamingSignalling** 组件拖入事件图表。从此节点拖出引线，并创建 **Connect** 节点。将 **BeginPlay** 连接到新节点的输入，并在URL值中输入"ws://127.0.0.1:80"。将端口添加到URL字段非常重要，因为像素流送播放器可能无法自动连接到正确的端口。Windows使用80端口，而Linux使用8080端口。
5. 选择PixelStreamingSignalling组件并通过 **细节** 窗口添加：**On Connected**、**On Config**、**On Offer**和**On Ice Candidate** 事件。通过PixelStreamingPeer节点添加 **On Ice Candidate** 事件。
6. 从 **On Connected** 拖出引线，创建 **Get Streamer ID List** 节点。再从此节点的输出拖出引线，并创建 **Subscribe** 节点。确保将 **Pixel Streaming Signalling** 连接到 **Signalling Component** 和 **Target** 的输入，如下图所示。从 **Streamer List** 的输出拖出引线，创建 **Get (a ref)** 节点并将其连接到 **Streamer ID** 的输入。
7. 从 **On Config (PixelStreamingSignalling)** 节点拖出引线并创建 **Set Config (Pixel Streaming Peer)**。确保将 **Set Config** 和 **On Config** 的配置值相连。
8. 从 **On Offer (PixelStreamingSignalling)** 拖出引线并创建 **Create Answer**。确保 **Offer** 和 **Create Answer** 的提供值相连。从 **Create Answer** 的输出引脚拖出引线，创建 **Send Answer** 节点。将 **Create Answer**的 **Return Value** 连接到 **Send Answer** 的答案值。
9. 从 **On Ice Candidate (PixelStreamingSignalling)** 拖出引线，创建 **Receive Ice Candidate** 并连接备选值。
10. 从 **On Ice Candidate (PixelStreamingPeer)** 拖出引线，创建 **Send Ice Candidate** 节点并连接备选值。
11. 如果上述步骤都操作正确，你的最终蓝图应如下所示：
12. 在左侧的 **组件（Components）** 窗口中选择 **PixelStreamingPeer** 组件。在 **细节** 窗口的 **属性（Properties）** 类别下，可以看到 **像素流送视频接收器（Pixel Streaming Video Sink）**。点击下拉菜单，选择 **像素流送纹理（Pixel Streaming Media Texture）**。根据自身需要为其命名并保存。
13. 将蓝图Actor拖入场景。创建一个简单的平面对象，调整其大小和形状，直至其成为适合的显示屏。
14. 将保存的像素流送媒体纹理直接从 **内容浏览器** 拖到场景中的平面上。这将自动创建一个材质，并将其应用到对象上。
15. 运行场景。此时就可以看到场景中的平面开始显示你的外部像素流送。

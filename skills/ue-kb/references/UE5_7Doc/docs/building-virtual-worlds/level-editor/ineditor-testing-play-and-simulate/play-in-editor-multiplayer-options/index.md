---
title: "在编辑器中运行多玩家选项"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/play-in-editor-multiplayer-options-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡编辑器", "在编辑器中进行测试(运行&模拟)", "在编辑器中运行多玩家选项"]
---

# 在编辑器中运行多玩家选项

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡编辑器 / 在编辑器中进行测试(运行&模拟) / 在编辑器中运行多玩家选项

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/play-in-editor-multiplayer-options-in-unreal-engine

**在编辑器中运行（PIE）** 预览模式支持使用多个世界进行测试，以便你可以测试联网运行。编辑器在已加载的虚幻引擎实例中生成多个世界，这可以缩短迭代时间，并便于你调试每个世界的蓝图。

## 设置联网测试

在 **关卡编辑器工具栏** 或 **蓝图编辑器工具栏** 中的 **运行位置（Play In）** 下拉菜单中，你可以设置在开始在编辑器中运行（Play In Editor）会话时要创建多少个客户端世界。此外，你还可以指定是否运行专用的服务器。

![Networking Settings](../../../../../assets/images/18/188e9e1ac81d8bf0661e1024c45f1138152e369680229199c51988635d323e0c.jpg)

点击查看大图。

**玩家数量（Number of Players）** 字段用于指定你要测试的玩家总数。

接下来，选择要使用的 **网络模式（NetMode）** ：

| **选项** | **说明** |
| --- | --- |
| **单机运行（Play Standalone）** | 创建单机游戏。此选项不会创建专用服务器。可通过启用 **bLaunchSeparateServer** 创建服务器。 |
| **作为监听服务器运行（Play as Listen Server）** | 创建同时充当服务器和客户端的会话。可以根据客户端的数量添加额外实例。 |
| **作为客户端运行（Play as Client）** | 创建充当客户端的会话。在后台启动的专用服务器。 |

如果 **玩家数量（Number of Players）** 字段设置为1，并且 **网络模式（NetMode）** 设置为 **单机运行（Play Standalone）** ，则你的在编辑器中运行（Play In Editor）会话将测试单机、非联网Gameplay。

如果网络模式（NetMode）设置为 **作为客户端运行（Play as Client）** ，则会启动一个专用服务器世界，但没有专用服务器的显示或本地玩家。使用专用服务器意味着你的所有客户端均不作为监听服务器运行。你可以使用专用服务器查找仅限于专用服务器的漏洞，比如依赖于本地玩家的代码。对于功能依赖于服务器和客户端的蓝图，基本的测试配置是将 **玩家数量（Number of Players）** 设置为1，并选择 **作为客户端运行（Play as Client）** 。这样只会创建一个用于测试运行的窗口，但其具备已连接到专用服务器的客户端的完整功能。

设置这些选项后，请选择你首选的在编辑器中运行（Play In Editor）模式，以开始测试Gameplay。如果你有多个客户端世界，并且为在编辑器中运行（Play In Editor）会话选择视口（Viewport）显示选项，则视口中显示一个客户端世界，所有其他客户端世界都将显示在新窗口中。以下图像显示的是使用4个玩家和专用服务器进行的测试。

![Networked Play With Four Players](../../../../../assets/images/96/96eb90aa4f303d416b685646a0490ff10d00b00996d3b11a76cc52b7eb7a419a.jpg)

## 高级设置

客户端世界数量以及是否使用专用服务器也可以在[关卡编辑器——运行位置设置](../play-in-editor-settings/index.md)窗口中设置。在此处，你还可以指定要发送给预览会话的命令行选项。

| **设置** | **说明** |
| --- | --- |
| **启动独立服务器（Launch Separate Server）** | 启动一个单独的服务器，即便网络模式不需要它。你可以利用此设置，通过让离线游戏连接服务器来测试从离线到服务器的工作流程。 |
| **运行网络模式（Play Net Mode）** | 设置在编辑器中运行（Play In Editor）会话使用的网络模式： **单机运行（Play Standalone）** ：启动单击游戏。此模式不会创建专用服务器，也不会自动连接到专用服务器。 **作为监听服务器运行（Play as Listen Server）** ：让编辑器能够同时充当服务器和客户端。可以根据客户端的数量打开额外客户端。 **作为客户端运行（Play as Client）** ：让编辑器能够充当客户端。在后台生成一个专用服务器以便连接用。 |
| **在一个进程下运行（Run Under One Process）** | 在虚幻引擎的单个实例下生成多玩家窗口。这样加载速度会快很多，但不能代表玩家的运行时环境，该环境中每个游戏实例都在其自己的进程中运行。 |
| **默认显示服务器调试绘图（Show Server Debug Drawing by Default）** | 在编辑器中运行（Play In Editor）期间从专用服务器绘制调试渲染。 |
| **服务器调试绘图着色强度（Server Debug Drawing Tint Strength）** | 控制调试绘图颜色向选定着色颜色的偏差。 |
| **服务器调试绘图颜色着色（Server Debug Drawing Color Tint）** | 选择服务器调试绘图的着色颜色。 |
| **启用网络模拟（Enable Network Emulation）** | 在启动游戏时应用所选的网络模拟设置，用于测试你的游戏如何处理网络问题： **模拟目标（Emulation Target）** ：将模拟设置应用于仅服务器（Server Only）、仅客户端（Clients Only）或所有人（Everyone）。 **网络模拟配置文件（Network Emulation Profile）** ：对输入流量和外发流量应用预设。选项包括平均（Average）、不良（Bad）或自定义（Custom）。 **输入流量（Incoming traffic）** ：对所有输入的数据包应用会增加延迟和数据包丢失的设置。可以增加最小和最大延迟，以及数据包丢失的百分比大小。 **外发流量（Outgoing traffic）** ：对所有外发的数据包应用会增加延迟和数据包丢失的设置。可以增加最小和最大延迟，以及数据包丢失的百分比大小。 |
| **客户端（Client）** | 启动游戏时应用所选的客户端设置： **运行客户端数量（Play Number of Clients）** ：打开多个客户端窗口。第一个窗口将使用在编辑器中运行（Play In Editor）模式选项，其余窗口将使用"在一个进程下运行（Run Under One Process）"设置。 **将游戏手柄传送至第二个窗口（Route Gampad to Second Window）** ：在多玩家会话期间传送游戏手柄的输入。如未勾选，则第一个游戏手柄绑定第一个多玩家窗口，第二个绑定第二个窗口，依此类推。如勾选，则将游戏手柄传送至第二个多玩家窗口，第一个窗口则由键盘和鼠标控制。 **为每个玩家创建音频设备（Create Audio Device for Every Player）** ：控制创建多少个音频设备。如勾选，将为每个玩家创建一个单独的音频设备。这能为每个玩家的视角呈现准确的音效，但代价是CPU开销变大。如未勾选，则只为前两个玩家创建单独的音频设备。 **客户端固定FPS（Client Fixed FPS）** ：将各个客户端的帧率设置为列表中的元素。包括监听服务器。 |
| **服务器（Server）** | 启动游戏时应用所选的服务器设置： **服务器端口（Server Port）** ：用于游戏联网的UDP端口号。 **服务器地图名称覆盖（Server Map Name Override）** ：覆盖服务器启动的地图。目前只有 **PIE_StandaloneWithServer** 网络模式使用。 **其他服务器游戏选项（Additonal Server Game Options）** ：添加其他作为URL参数传递给服务器的参数。 **其他服务器启动参数（Additonal Server Launch Parameters）** ：添加其他作为参数传递给服务器的参数。 **服务器固定FPS（Server Fixed FPS）** ：将服务器设置为以指定帧率运行。不影响监听服务器。 **多玩家视口大小（按像素计）（Multiplayer Viewport Size (in pixels)）** ：以指定的宽度和高度生成额外的客户端。适合当你需要多个客户端但只想与一个窗口交互时使用。 |

## 调试蓝图

在多世界场景中运行时， **蓝图编辑器（Blueprint Editor）** 会提供一个额外的下拉菜单，用于选择要调试的世界：

![Debugging Network Play Blueprints](../../../../../assets/images/3e/3e1d5a8a6f4c0548007a7289f88bf7eb8d518c5afe11206dc4450b89d0941b71.png)

世界列表中选定的世界会对Actor列表中的Actor进行过滤。例如，如果选择了 **全部世界（All Worlds）** ，你将在另一个下拉列表中看到每个世界中的Actor。如果只选择了其中一个世界，你只能看到该世界实例中的Actor。

这也会影响断点。例如，如果将调试世界设置为客户端1（Client 1），则断点只会在客户端1（Client 1）世界中的Actor上触发。

> [!TIP]
> 在窗口标题上可以看到预览窗口的客户端数量。例如，在以上联网运行图像中，有一个标题为 **LyraStarterGame预览[网络模式客户端1]（LyraStarterGame Preview [NetMode Client 1]）** 的窗口。

如果选择 **全部世界（All Worlds）** ，则任意世界都可以触发断点。

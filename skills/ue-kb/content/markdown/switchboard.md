# Switchboard设置参考

---
title: "Switchboard设置参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/switchboard-settings-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "与媒体组件通信", "Switchboard概述", "Switchboard设置参考"]
---

# Switchboard设置参考

> 路径：虚幻引擎5.7文档 / 使用媒体 / 与媒体组件通信 / Switchboard概述 / Switchboard设置参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/switchboard-settings-reference-for-unreal-engine

本文介绍了Switchboard中哪些设置可以调整。

## Switchboard插件设置

要访问Switchboard插件设置中，请在虚幻引擎主菜单中选择 **编辑（Edit）> 项目设置（Project Settings）> 插件（Plugins）> Switchboard**。

![Switchboard插件设置](../../../../../assets/images/6b/6bf813edd47a41d1431caa0eb2244faf6aec02a2e4465e2516d2f67eaf8949a5.png)

可以在插件设置中设置OSC监听器。Switchboard需要通过OSC监听器才能使用镜头试拍录制器。如需了解更多详细信息，请参考[通过Switchboard进行录制](../index.md#takerecordingwithswitchboard)。 可以配置Switchboard的启动方式，并为Switchboard插件安装编辑器偏好设置中需要的任何依赖项。下表介绍了可以在编辑器偏好设置中设置的参数。

![Switchboard编辑器偏好设置](../../../../../assets/images/42/4279a979e8088624fcd94e606bb17104cc91b4e62ce1f410e83bcdeae34bad05.png)

| **参数** | **说明** |
| --- | --- |
| **Switchboard** |  |
| 虚拟环境路径 | Switchboard的默认Python版本是Python 3.7.7。要使用Python的其他版本，请更改此字段以指向你机器上的Python编译器。 |
| **Switchboard监听器（Switchboard Listener）** |  |
| Listener命令行参数（Listener Commandline Arguments） | SwitchboardListener需要使用以下参数： `-ip` ：设置Switchboard监听器所监听的IP地址。 `-port` ：设置Switchboard监听器所监听的端口。 |
| 登录时启动Switchboard监听器 | 启用后，在本地机器上每次登录到计算机时都会启动Switchboard监听器。 |

## Switchboard设置

在所有设备插件中通用的设置位于 **设置（Settings）** 面板的常规部分，包括在初始项目设置期间添加的值。在添加设备后，这些设备的设置将附加到设置面板，一个选项卡将会出现在左边，以便于根据设备类型来选择条件进行筛选。

![Switchboard设置面板](../../../../../assets/images/1e/1ec19d621c0b6069b4099d4e20ad1d85bb8937df3fafa5f43bf2259c826cf195.png)

一些常规设置在设备的设置中是重复的，因此可以根据需要在每个设备中重载这些值。如果重载了特定设备中的设置，将会显示不同的背景颜色。只要覆盖位置正确，更改全局设置就不会导致设备中的此设置发生更改。

![重载后的Switchboard设置](../../../../../assets/images/e3/e35c8dc7a446dd1e8e346bca2f3c03b043fff7d75fd2dfa0ca4a3cb29bb93416.png)

下面几个小节介绍了可以在 **设置（Settings）** 面板中修改的所有设置。

### 一般设置

| **参数** | **说明** |
| --- | --- |
| 配置路径（Config Path） | 用于存储Switchboard配置文件的路径。这些文件中包含所有Switchboard状态。 |
| IP地址（IP Address） | 运行Switchboard和内部OSC服务器的机器的IP地址。如果运行Switchboard的计算机上有多个网络控制器，请在此处更改地址。 |
| 传输路径（Transport Path） | 目前未在Switchboard中使用。 |
| 监听器可执行文件名称（Listener Executable Name） | 用于启动switchboard监听器应用程序的程序名称 |

### 项目设置

| **参数** | **说明** |
| --- | --- |
| 项目名称（Project Name） | Switchboard项目的名称。将用作存储设置和设备的文件名的基础。 |
| UProject | UE项目文件的本地路径 |
| 引擎目录（Engine Directory） | 虚幻引擎目录的本地路径。 |
| 构建引擎（Build Engine） | 用于在Switchboard中启用从源编译引擎的标记。 |
| 贴图路径（Map Path） | 从 **Content** 文件夹到贴图的相对路径，将显示在Switchboard中的 **关卡（Level）** 下拉菜单中。 |
| 贴图过滤器（Map Filter） | 用于限制哪些贴图出现在"关卡"下拉菜单中的文件过滤器。 |
| **OSC** |  |
| OSC服务器端口（OSC Server Port） | Switchboard中要监听的OSC服务器的端口。 |
| OSC客户端端口（OSC Client Port） | 虚幻编辑器中指定的OSC客户端的端口。 |
| **源功能按钮（Source Control）** |  |
| 工作区名称（Workspace Name） | 映射至库项目路径的Perforce工作区的名称。 |
| Perforce项目路径（Perforce Project Path） | UProject中指定的虚幻项目的存储路径。仅需要指定包含Uproject文件的库文件夹。 |
| Perforce引擎路径（Perforce Engine Path） | 只有在你计划根据来源（而不仅仅是项目）构建引擎时，才需要P4引擎路径设置。如需了解更多详细信息，请参考[同步和构建](../index.md#syncingandbuilding)。 |

### 多用户服务器设置

| **参数** | **说明** |
| --- | --- |
| 服务器名称（Server Name） | 附加到项目名称的名称，用于创建完整的服务器名称。 |
| 命令行参数（Command Line Args） | 传递到多用户服务器可执行文件的可选参数。 |
| 单播端点（Unicast Endpoint） | 启动时为多用户指定的单播端点。这是服务器为连接监听的端口，与项目设置中的 **UDP消息（UDP Messaging）** 设置相对应。默认值为 **0.0.0.0:9030** 。 |
| 多播端点（Multicast Endpoint） | 这是多用户应该订阅的多播组。所有参与同一多用户会话的虚幻节点都应该具有相同的多播端点。高级配置中可以修改此变量。 |
| 多用户可执行文件名称（Multiuser Executable Name） | 用于启动多用户服务器会话的程序名称。 |
| 自动启动（Auto Launch） | 启用此选项以在首次启动虚幻或nDisplay设备时启动多用户服务器。服务器始终在与Switchboard所在的同一设备上运行。 |
| 清空历史记录（Clean History） | 将参数 `-ConcertClean` 传递到服务器，以便在启动时清空服务器会话的工作目录。 |
| 自动构建（Auto Build） | 如果当引擎文件夹中的来源发生变化时应该重新构建多用户服务器，则启用此选项。 |
| 自动端点（Auto Endpoint） | 如果在启动虚幻编辑器或nDisplay节点时应该分配多用户服务器的静态端点，则启用此选项。 这等于在项目设置中将静态端点添加到多用户服务器单播端点。 |
| 虚幻多用户服务器自动联接（Unreal Multi-user Server Auto Join） | 启用此选项将会使每个虚幻或nDisplay设备自动联接多用户服务器。 |

### 虚幻设备设置

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| 缓冲区大小（Buffer Size） | 连接到SwitchboardListener的套接字客户端的内部缓冲区大小。 |
| 命令行参数（Command Line Arguments） | 启动时传递至虚幻的可选命令行参数。 |
| ExecCmds | 设置要在启动时作为命令行参数传递至虚幻的 `-ExecCmds` （控制台命令。） |
| DPCVars | 以逗号分隔列表形式传送设备描述控制台变量。 |
| Listener端口（Listener Port） | Listener要侦听的端口号。默认端口为2980。 |
| 角色文件名（Roles Filename） | 包含[虚拟制片端点](../index.md#virtualproductionroles)的.ini文件的文件名。 |
| 舞台会话ID（Stage Session ID） | 用于对舞台监视器提供程序和监视器进行分组的ID。具有不同会话ID的实例在[舞台监视器](../../stage-monitor/index.md)中彼此不可见。 |
| 虚幻编辑器文件名（Unreal Editor filename） | 虚幻编辑器可执行文件的文件名。 |
| GPU数量（Number of GPUs） | 当设备上有多个GPU时使用的GPU数量。 |
| 进程优先级 | 重载进程的优先级。 |
| 跳过程序包恢复 | 在启动时自动放弃自动保存的程序包，跳过恢复提示。在多用户场景中非常有用，因为不需要从自动保存的文件中进行恢复。 |
| 单播端点 | 节点的单播端点。通常情况下，应该是默认的分配值。Switchboard将使用Switchboard分配的IP地址名称和:0。 |
| 额外静态端点（Extra Static Endpoints） | 要在虚幻编辑器启动时设置的额外静态端点。此选项对应项目设置中 **UDP消息（UDP Messaging）** 的静态端点设置。 |
| 多播端点 | 重载多播端点。 |
| 日志下载目录（Log Download Dir） | 用于从远程设备收集日志和Unreal Insights追踪文件的目的地文件夹。默认情况下，此路径在文件夹 **/Saved/Logs/Switchboard** 的项目目录中。 |
| 将编辑器可见性反映到游戏（Reflect Editor Visibility to Game） | 启用此选项将会把object的编辑器可见性状态反映到多用户会话中相应的 `-game` 可见性，例如"在游戏中隐藏（Hidden in Game）"。在nDisplay配置中，通常需要为操作员工作站启用此选项，以便于让关卡可见性的更改正确地反映 `-game` 实例。 |
| Rsync Server Port | 为Switchboard应用程序上运行的重新同步服务器分配的端口。重新同步服务器用于将更大的数据从连接的节点传输到主Switchboard实例。 |
| 监听器超时（Listener Timeout） | Switchboard监听器进程的超时时长。如果Switchboard监听器在给定的超时时长中未检测到主Switchboard应用程序中的消息，那么与Switchboard应用程序的链接将会终止。 |

对于每个虚幻实例：

| **参数** | **说明** |
| --- | --- |
| IP地址（IP address） | SwitchboardListener侦听的远程地址。 |
| 角色（Roles） | 可以在下拉菜单中从提供的角色.ini文件中选择[虚拟制片角色](../index.md#virtualproductionroles)。 |
| 从构建中排除（Exclude from build） | 启用后，此节点上应该不会发生引擎构建。 |
| 是录制设备（Is Recording Device） | 覆盖以确定此设备是否用于录制。 |
| 命令行参数（Command Line Arguments） | 覆盖以获得可选命令行参数。 |
| ExecCmds | 覆盖以获得虚幻的exec命令。 |
| DPCVars | 设备描述控制台变量的重载。 |
| GPU数量（Number of GPUs） | 覆盖以获得要使用的GPU计数。 |
| 进程优先级 | 此实例优先级的重载。 |
| 跳过程序包恢复 | 重载是否在启动时自动放弃自动保存的程序包。 |
| 单播端点 | 重载单播端点。 |
| 额外静态端点 | 重载额外静态端点。 |
| 引擎目录（Engine Directory） | 覆盖以获得引擎的本地路径。 |
| 工作区名称 | 重载Perforce工作区名称。 |
| uProject路径（uProject Path） | 覆盖以获得uProject文件的本地路径。 |

### KiPro设备设置

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| IP地址（IP address） | KiPro Web服务器的地址。 |
| 停止后自动播放（Auto Play After Stop） | 启用此选项可以在录制结束时自动播放。 |

### Live Link Face

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| IP地址（IP address） | 目前未在Switchboard中使用。 |

### 动力设备设置

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| 动力命令端口（Motive Command Port） | 用于动力设备的通信端口。 |
| IP地址（IP address） | 分配给动力设备的IP地址 |

### nDisplay设备设置

| **参数** | **说明** |
| --- | --- |
| nDisplay配置文件（nDisplay Config File） | 支持.cfg和JSON格式。 |
| 使用所有可用内核（Use All Available Cores） | 启用此选项以使用所有内核。 |
| 纹理流送（Texture Streaming） | 切换纹理流送。 |
| 渲染API（Render API） | 选项为DirectX11或DirectX12。 |
| 渲染模式（Render Mode） | 允许选择nDisplay渲染模式。 |
| 渲染同步政策（Render Sync Policy） | 如需了解详细信息，请参考[Render Sync Policies](../../../integrating-media/rendering-to-multiple-displays-with-ndisplay/synchronization-in-ndisplay/index.md#rendersyncpolicies)。 |
| nDisplay可执行文件的文件名（nDisplay Executable Filename） | 为项目设置可执行文件的名称。这对于封装的构建非常有用。 |
| 额外命令行参数（Extra Cmd Line Args） | 启动时传递至nDisplay的可选命令行参数。 |
| ExecCmds | 设置要在启动时作为命令行参数传递至虚幻的 `-ExecCmds` （控制台命令。） |
| DPCVars | 以逗号分隔列表形式传送设备描述控制台变量。 |
| 无人看管（Unattended） | 启用此选项即表明这是无人看管的应用程序并且应该抑制所有对话框窗口。 |
| GPU数量（Number of GPUs） | 当设备上有多个GPU时使用的GPU数量。 |
| 进程优先级 | 重载进程的优先级。 |
| 启动前最小化（Minimize Before Launch） | 如果主机计算机上的所有窗口在启动nDisplay节点之前最小化，则启用此选项。 |
| 日志记录（Logging） | 可以按照设备进行控制的自定义日志记录。 |
| 单播端点 | 节点的单播端点。通常情况下，应该是默认的分配值。Switchboard将使用Switchboard分配的IP地址名称和:0。 |
| 额外静态端点 | 要在启动nDisplay渲染器时设置的额外静态端点。此选项对应项目设置中 **UDP消息（UDP Messaging）** 的静态端点设置。 |
| 禁用保证（Disable Ensures） | 在运行的实例中禁用保证条件。保证条件仍然会记录，但不会导致实例终止。 |
| 禁用所有屏幕消息（Disable All Screen Messages） | 如果应该禁用屏幕消息，则启用此选项。 |
| Listener端口（Listener Port） | Listener要侦听的端口号。默认端口为2980。 |
| 角色（Roles） | 可以在下拉菜单中从提供的角色.ini文件中选择[虚拟制片角色](../index.md#virtualproductionroles)。 |
| 舞台会话ID（Stage Session ID） | 用于对舞台监视器提供程序和监视器进行分组的ID。具有不同会话ID的实例在[舞台监视器](../../stage-monitor/index.md)中彼此不可见。 |

对于每个nDisplay节点：

| **参数** | **说明** |
| --- | --- |
| IP地址（IP address） | SwitchboardListener侦听的远程地址。 |
| 角色（Roles） | 可以在下拉菜单中从提供的角色.ini文件中选择[虚拟制片角色](../index.md#virtualproductionroles)。 |
| 从构建中排除（Exclude from build） | 重载是否在引擎构建过程中排除此节点。 |
| UE命令行（UE Command Line） | 用于在此节点上启动nDisplay渲染器的完整命令。 |
| 额外命令行参数（Extra Cmd Line Args） | 覆盖以获得可选的命令行参数。 |
| ExecCmds | 覆盖以获得nDisplay的exec命令 |
| DPCVars | 设备描述控制台变量的重载。 |
| GPU数量（Number of GPUs） | 覆盖以获得要使用的GPU计数。 |
| 进程优先级 | 此实例优先级的重载。 |
| 单播端点 | 重载单播端点。 |
| 额外静态端点 | 重载额外静态端点。 |
| 引擎目录（Engine Directory） | 覆盖以获得引擎的本地路径。 |
| 工作区名称 | 重载Perforce工作区名称。 |
| uProject路径（uProject Path） | 覆盖以获得uProject文件的本地路径。 |

### Shogun设备设置

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| IP地址（IP Address） | 运行Shogun的设备的地址。 |
| 保存路径（Save Path） | Shogun的捕获文件夹的路径。 |

### SoundDevices设备设置

| **参数** | **说明** |
| --- | --- |
| 是录制设备（Is Recording Device） | 如果该设备类型即将用于录制序列，则启用此选项。 |
| IP地址（IP Address） | SoundDevices Web服务器的地址。 |


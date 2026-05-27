# Device Manager

---
title: "Device Manager"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/connecting-to-and-managing-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "常用平台支持", "Device Manager"]
---

# Device Manager

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 常用平台支持 / Device Manager

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/connecting-to-and-managing-devices-in-unreal-engine

该 **设备管理器** 窗口可以直接从 Unreal Editor 连接并控制远程设备，包括其他 PC、智能手机和游戏主机。连接到设备管理器中的设备后，可以使用 **平台菜单** 或 **Unreal Automation Tool（UAT）**的命令行界面，在该设备上部署并启动打包构建。本文提供设备管理器窗口及其功能参考，包括：

- 在设备管理器的设备列表中添加和移除设备。
- 连接到远程设备以及从远程设备断开连接。
- 通过开机和关机远程控制设备。

## 打开设备管理器

要访问设备管理器，请点击 Unreal Editor 中的 **平台** 下拉菜单，然后点击 **设备管理器**.

![Accessing the Device Manager through the Platforms dropdown.](../../../../assets/images/56/56084be64b348685cb4051c0f98b372a52c4cb64d09f7ecf101786c0101cbb39.jpg)

设备管理器会显示可用于启动项目的设备列表。

## 设备管理器用户界面

![The user interface of the Device Manager.](../../../../assets/images/75/7555ce0d9518049d9821ddb44ca9292ba812fd4cb803208ca066c24ff345d3aa.jpg)

| **索引** | **UI 元素** | **说明** |
| --- | --- | --- |
| 1 | 设备管理 | 用于申领和释放设备的控件。 |
| 2 | 设备连接 | 连接到设备列表中选中的设备，或与其断开连接。 |
| 3 | 设备控制 | 远程开启、关闭或重启设备列表中选中的设备。 |
| 4 | 筛选器和搜索栏 | 在设备列表中搜索设备。 |
| 5 | 设备列表 | 可预留、连接和远程控制的设备列表。 |
| 6 | 正在运行的进程 | 设备列表中所选设备上的正在运行进程列表。 |
| 7 | 设备详情 | 所选设备的信息，包括平台信息、设备 ID、状态和可用 UE 功能。 |

## 浏览设备列表

该 **设备列表** 会显示与你的计算机连接到同一本地局域网（LAN）的所有设备。如果已为 Android 设备设置 WiFi 调试，并且它们位于你的无线 LAN 中，也会显示在这里。也可以连接到 LAN 外部的设备，但需要设备具有稳定 IP 地址才能找到它。请参阅下方“向设备管理器添加设备”。

![The device list in the device manager.](../../../../assets/images/5c/5c95a0bcbfbcbc0c100b6559ce21ba3e16e47d499615cd318f2a028ea503b646.png)

在列表中点击设备即可选中它。随后可以使用设备管理器工具查看其信息，或远程控制该设备。

### 上下文菜单

右键单击设备列表中的任意条目，可查看包含交互选项的上下文菜单。

![The context menu, which appears when you right-click in the device manager.](../../../../assets/images/c2/c23b30dbac86544a47039429346c2bcebee42c1db034b82294a4a7aa0cd50051.jpg)

可用选项与设备管理器中的其他控件对应，如下所示：

| **选项** | **说明** |
| --- | --- |
| 申领 | 申领该设备供自己使用。 |
| 释放 | 将设备释放回设备池。 |
| 共享 | 与其他用户共享设备。 |
| 移除 | 从设备管理器中移除该设备。 |
| 连接 | 打开到目标设备的直接连接。 |
| 断开连接 | 关闭与目标设备的连接。 |
| 开机 | 远程开启目标设备。 |
| 关机 | 远程关闭目标设备。 |
| 强制关机 | 强制关闭目标设备上的所有运行中应用程序，然后关闭设备。 |
| 重启 | 远程重启目标设备。 |

这些选项的更详细说明请参阅下方章节。

### 申领和释放设备

![The claim/release devices buttons in the toolbar.](../../../../assets/images/e0/e078e49a48ca1356fd227d4467e7290108b687c419feced721d5bc8b10fcb964.png)

最初可能无法与设备列表中的某些设备交互。点击 **申领** 按钮申领设备供自己使用。这会预留该设备，使网络中的其他人无法使用它，从而避免用户之间的冲突。

Click the **释放** 按钮，在设备使用完毕后将其释放回网络中的设备池。

如果希望设备可供一组用户使用，请点击 **共享**，或点击设备列表中的 Share 复选框。可以随时切换开关。

Click the **移除**按钮从设备列表中移除设备。要再次添加它，请参阅下方“向设备管理器添加设备”章节。

## 向设备管理器添加设备

要向设备管理器添加设备，请按以下步骤操作：

1. Click the **添加未列出的设备** 下拉菜单。

   ![The Add Unlisted Device dropdown is located at the bottom of the Device List.](../../../../assets/images/ce/ceb0bac4f61bdb75bcd1008b5d52ac94b31bfb79f24d9e7777e8892f145c9997.jpg)
2. Click the **选择平台** 下拉菜单，并点击要添加设备所属的平台。
3. 填写 **设备标识符** ，填入设备的适当唯一标识符。根据平台不同，它可以是主机名、IP 地址、MAC 地址或其他平台特定唯一标识符。设备管理器接受大多数平台的稳定 IP 地址。
4. Fill in **显示名称** ，填入设备名称。该字段会显示在设备列表的 Device 列下，也会显示在 Unreal Editor UI 的其他位置。
5. 填写设备标识符和显示名称后，点击 **Add** 以将设备添加到列表。

   ![The Add Unlisted Device dropdown unfolded, with an entry for a device entered into its fields.](../../../../assets/images/a8/a834442bef4a6c20cd7a2506ad1531aa62e0f23bec5e53ca5eb7cf0e96defa4f.png)

## 连接和断开设备

![The Connect and Disconnect buttons in the toolbar.](../../../../assets/images/36/361d47596a2772dbccf0422e9198232ace7dbb8d92b3a5c37f45b7f665973d19.png)

申领设备后，在选中该设备的情况下点击 **连接** 按钮，以在开发机器和该设备之间打开连接。设备列表中的状态会更新为 Connected，此时可以远程控制该设备，并使用它启动项目的打包构建。

要与设备断开连接，请点击 **断开连接** 按钮。该设备会在设备列表中变灰。

## 查看设备详情

在设备列表中选择设备时， **设备详情** 面板会显示以下系统信息：

| **值** | **说明** |
| --- | --- |
| 名称 | 显示设备的显示名称。如果未提供名称，默认情况下通常显示设备自身分配的唯一标识符。 |
| 平台 | 显示设备运行的平台，例如 Windows、MacOS、Linux、Android 或 iOS。 |
| 设备 ID | 显示设备的完整设备 ID。 |
| 默认设备 | 显示该设备是否为部署构建的默认设备。这通常是你的本地开发机器。 |
| 状态 | 显示设备当前状态，例如当前已连接、未连接或已释放。 |
| 功能列表 | 显示所选设备上兼容的 UE 功能列表。 |

### 功能兼容性列表

功能列表会显示已知功能及其是否与所选设备兼容。兼容功能以亮灰色文本显示，并在 Available 列中列出 **是** 。不兼容功能以深灰色显示，并在 Available 列中列出 **No** under the Available column.

> 图片已省略：The Device Details panel in the Device Manager, including the feature compatibility list at the bottom.

此列表并不包含 Unreal Engine 所有功能的完整清单。对于未列出的功能，可能需要自行研究和测试，以完全确定兼容性。

## 远程控制设备

可以通过电源控件、上下文菜单或正在运行的进程面板控制设备。

### 开启和关闭设备

> 图片已省略：The Power On and Off buttons in the toolbar.

Click the **开机** 按钮，在所选设备尚未运行时开启它。

Click the **关机** 按钮，关闭正在运行的所选设备。

点击 **重启** 以重启所选设备。

如果需要强制关闭设备，请右键单击该设备并点击 **强制关机**。这会强制关闭所有运行中进程，然后关闭设备。

### 控制设备进程

该 **正在运行的进程** 面板提供所选设备上当前正在运行的进程列表。

> 图片已省略：The Running Processes panel in the Device Manager.

该表中的列如下：

| **列** | **说明** |
| --- | --- |
| 进程名称 | 正在运行的进程或可执行文件名称。 |
| PID | 作为所列进程 ID 的唯一数字。 |
| 用户 | 负责运行该进程的用户名称。通常是已登录该设备的用户。 |
| 线程 | 列出该进程正在使用的 CPU 处理线程数量。 |
| 父 PID | 该进程所属父进程的 PID。父进程负责创建该进程。 |

可以通过勾选窗口左下角的 **显示进程树** 复选框来显示更多进程。父进程随后会有一个可点击的折叠项，用于显示其子进程。

> 图片已省略：The Running Processes panel with the Process Tree enabled. One of the processes is unfolded, showing its child processes.

要关闭进程，请在进程列表中点击它，然后点击 **终止进程**.

> 图片已省略：The Terminate Process button in the Running Processes panel.


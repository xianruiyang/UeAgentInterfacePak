---
title: "会话浏览器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-insights-session-browser-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "会话浏览器"]
---

# 会话浏览器

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / 会话浏览器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-insights-session-browser-for-unreal-engine

启动Unreal Insights时，它打开到 **会话浏览器（Session Browser）** 窗口，你可以在其中选择要查看的Trace会话。本页面提供了会话浏览器窗口的参考，介绍了如何使用它加载Trace并连接到实时Trace会话。

> [!TIP]
> 关于Unreal Insights的工作流程的完整概述，请参阅[Unreal Insights概述](../index.md)。

## 连接选项卡

**连接选项卡（Connection Tab）** 提供了用于使用Trace服务器连接到运行中的游戏或编辑器的界面。它包含多个可更改你的连接设置的选项。

![Unreal Insights连接选项卡](../../../../assets/images/98/98ff68f5833f9929ec637cd1bbc7c14fa11bad65626e8d4f679ad5d3e2701dcb.jpg)

| **参数** | **说明** |
| --- | --- |
| Trace录制器IP地址（Trace Recorder IP Address） | Trace服务器的IP地址。 |
| 运行中实例IP地址初始通道（Running Instance IP Address Initial Channels） | 与Trace服务器连接以开始追踪数据的项目（运行中实例）的IP地址。 |
| 初始通道（Initial Channels） | 该字段用于指定在Trace连接开始分析数据时要启用的Trace通道的列表。 |

要连接到Trace录制器，请填写以上每个字段，然后点击 **连接（Connect）** 。对应于新连接的新实时会话将显示在Trace会话列表中，标记有 **LIVE** 字样。除了本地Trace数据之外，Trace存储中现在还提供了远程Trace数据。

如需了解Trace服务器，请参阅[Trace](testing-and-optimizing-your-content/unreal-insights/trace-in-unreal-engine]文档。

> [!NOTE]
> 通过使用运行Unreal Insights跟踪服务器的设备来连接运行游戏或编辑器的设备，需要确保两台设备的连接细节高度匹配。这意味着，如果它们都是通过有线方式连接的，那么它们需要处于同一个局域网中。如果运行游戏的设备是移动设备，那么它必须通过5G Wi-Fi连接（如果在家办公）或者使用安全的内部Wi-Fi网络（在办公室工作）进行连接，而不是使用权限较低的访客Wi-Fi访问权限。

## Trace存储选项卡

**Trace Store 选项卡** 提供了可供你查看的Trace会话文件的列表。这包括你的本地计算机上的文件，以及远程Trace录制器服务器上可用的文件。每个会话包含关于你的应用程序的性能和资源使用的录制数据。

![标记有与下表对应的数字的会话浏览器UI功能。](../../../../assets/images/75/754e80e58d8b488f67c73e6153809f787187256b8af8db3ec631f7803d72e308.png)

| **元素** | **名称** | **说明** |
| --- | --- | --- |
| 1 | 管理存储设置 | 点击下拉菜单显示Trace存储目录(4)和额外目录(5)。 |
| 2 | 存储主机 | 你的Trace服务器的IP地址。默认情况下，这被设置为127.0.0.1，意味着它使用本地Trace服务器。如果你有远程Trace服务器，可以提供其IP地址以在其中查找Trace数据。如果你成功连接，图标显示为绿色勾号，否则为警告图标。额外Trace服务器信息（版本和端口）将在你高亮显示此字段时显示在提示文本中。 |
| 3 | 目录 | Trace服务器存储新Trace的目录。 |
| 4 | Trace存储目录 | Trace存储目录(3)的备用显示。此选项通常隐藏。点击折页标签可显示。 |
| 5 | 额外目录 | Unreal Trace服务在其中监控Trace文件的其他目录。Trace存储目录和外部监控的目录中的Trace文件都显示在Trace存储选项卡的会话列表中的统一列表中。此选项通常隐藏。点击折页标签可显示。 |
| 6 | 名称/命令行切换开关 | 使用名称筛选器时，在名称和命令行筛选之间切换。 |
| 7 | 名称筛选器 | 根据你切换的模式，按名称或命令行筛选Trace会话(6)。虽然Trace会话名称使用数字字符串表示，但你可以使用此筛选器缩小你想查看的会话范围。 |
| 8 | 筛选器栏 | Trace会话列表(9)中的列的筛选器。详情请参阅下面的筛选器小节。 |
| 9 | Trace会话列表 | 在你选择的目录中可供分析的Trace会话的列表(3 / 4)。你可以同时选择多个trace文件。 |
| 10 | 自动启动分析切换开关 | 启用或禁用实时Trace会话的自动启动分析。此设置在会话之间持久存在。 |
| 11 | 自动启动筛选器 | 将自动启动限制为仅在特定情况下发生。你可以筛选 **平台** 或 **应用名称** 。 |
| 12 | 自动连接（仅限Windows） | 启用后，UE应用程序会在Unreal Insights运行时，自动连接到本地Trace服务器并开始追踪。 |
| 13 | 打开Trace按钮 | 点击"打开Trace（Open Trace）"按钮，为你在Trace会话列表(9)中选择的会话打开Unreal Insights。 |
| 14 | 打开Trace下拉菜单 | "打开Trace（Open Trace）"按钮旁边的下拉菜单显示打开Trace的其他方法。请参阅下面关于"打开Trace"下拉菜单的小节，了解更多详情。 |

### 筛选器

筛选器栏包含下拉菜单，其中列出了对应于Trace会话列表中的各个列的筛选器。点击每个下拉菜单，可以切换你想筛选的值。可用的筛选器类型如下：

| **筛选器** | **说明** |
| --- | --- |
| **平台（Platform）** | 按你想分析的构建的目标平台筛选。例如，Win64、Mac或Linux。 |
| **应用名称（App Name）** | 按你想分析的应用程序的名称筛选。这与Trace会话名称不同，后者是单独会话的标识符，与它们所属的应用无关。 |
| **配置（Config）** | 按构建配置筛选。例如，你可以按调试、开发或发布类型构建配置筛选。 |
| **目标（Target）** | 按构建目标筛选。例如，你可以按编辑器、游戏、客户端或服务器构建目标筛选。 |
| **分支（Branch）** | 按你的应用程序绑定到的版本控制系统中的分支筛选。 |
| **大小（Size）** | 基于Trace文件的大小筛选。 |
| **状态（Status）** | 基于会话是离线还是实时状态进行筛选。 |

### 加载Trace进行分析

你可以使用以下选项加载Trace进行分析：

- 双击Unreal Insights浏览器中显示的任何Trace会话。
- 选择Trace会话并点击

  打开Trace（Open Trace）

  。
- 如果你使用的是Windows系统，可以将

  .utrace

  文件从资源管理拖放到Unreal Insights窗口上，开始分析Trace文件。
- 使用

  打开Trace（Open Trace）

  下拉菜单，在其他位置搜索

  .utrace

  文件。

当你打开Trace会话时，Unreal Insights会打开[Timing Insights](../timing-insights/index.md)，其中提供了Insights的主要分析工具。

### 打开Trace下拉菜单

"打开Trace（Open Trace）"按钮旁边的下拉菜单将显示打开Trace的详细选项。

| **选项** | **说明** |
| --- | --- |
| **杂项（Misc）** |  |
| 打开文件（Open File） | 打开文件浏览器以手动选择Trace文件。 |
| 导入表格（Import Table） | 将CSV或TSV导入表视图中。 |
| 对比表格（Diff Tables...） | 在对比模式中打开两个表。 |
| **最近创建的Trace（Top Most Recently Created Traces）** |  |
| Trace条目（Trace Entries） | 在列表中显示最近创建的Trace，以便你可以快速访问。 |
| **服务器（Server）** |  |
| Unreal Trace服务器（Unreal Trace Server） | 显示本地Trace服务器的子菜单。请参阅下面的Unreal Trace服务器小节。 |
| **调试选项（Debug Options）** |  |
| 启用会话自动化测试（Enable Session Automation Testing） | 为从此窗口打开的会话激活自动测试系统。 |
| 启用调试工具（Enable Debug Tools） | 为从此窗口打开的会话启用调试工具。 |
| 星舰测试套件（Starship Test Suite） | 打开星舰UX测试套件，其中包含各种UI元素的预览。 |

#### Unreal Trace服务器折页

![Unreal Trace服务器折页](../../../../assets/images/93/937aa0fef37267d63c4e84cc124fc34da703580f08d5b70627f65db158ddecdd.jpg)

"打开Trace（Open Trace）"下拉菜单中的Unreal Trace服务器选项显示带有Trace服务器实例的信息和功能按钮的子菜单。可用的选项如下：

| **选项** | **说明** |
| --- | --- |
| **赞助模式（Sponsored Mode）** | 启用后，服务器仅在使用它的本地进程仍在运行时才运行。 |
| **启动（Start）** | 启动尚未运行的本地Trace服务器。 |
| **停止（Stop）** | 停止已在运行的本地Trace服务器。 |

除了这些选项之外，此子菜单还显示：

- 版本号。
- 服务器的录制器端口。
- 服务器的存储端口。

### 实时连接

实时状态意味着Trace会话当前正在录制。如果实时Trace会话连接到Unreal Trace服务器，它也会出现在Trace存储列表中。实时会话的状态列中会显示 **LIVE** 字样，并在你分析它们时实时更新，但是在其他方面与预录制会话相同。

该工具可以同时监控多个会话，它会自动将所有会话的数据录制为数据流。要实时分析这些会话，请从列表中加载它们，就像你加载预录制会话一样。

![显示LIVE会话的Trace Store选项卡](../../../../assets/images/07/07e7fb172f1b0c7a0a2e47c16f270fe99a47e649011d13b086f9eb69cd96fcbb.png)

### 快捷菜单

在Trace存储列表中右键点击条目时，快捷菜单会显示你可以对使用该Trace的操作。

| **选项** | **说明** |
| --- | --- |
| 复制Trace ID（Copy Trace ID） | 将Trace会话文件的Trace ID复制到剪贴板。 |
| 复制完整路径（Copy Full Path） | 复制存储Trace会话文件的文件路径。 |
| 打开所在文件夹（Open Containing Folder） | 打开包含Trace会话文件的文件夹。 |
| 重命名（Rename） | 为Trace文件输入新名称。在使用远程追踪服务器时，重命名功能将被禁用。 |
| 删除（Delete） | 删除所选Trace文件。如果你选择多个Trace，你可以使用此选项将其全部删除。在使用远程追踪服务器时，删除功能将被禁用。 |

## 键盘快捷键

| **快捷键** | **描述** |
| --- | --- |
| **Delete** | 删除选定的追踪会话。 |
| **F2** | 重命名选定的追踪会话。 |
| **F5** | 重命名追踪会话列表。 |

---
title: "网络分析器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-network-profiler-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络调试", "网络分析器"]
---

# 网络分析器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络调试 / 网络分析器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-network-profiler-in-unreal-engine

**网络分析器（Network Profiler）** 是一个独立工具，用于显示 **虚幻引擎（UE）** 在游戏运行时记录的网络流量和性能信息。由于可查看各个Actor、远程过程调用（RPC）和属性在总带宽中的占比，此工具很适合识别多人游戏中使用异常高带宽的情况。

## 记录分析会话

在使用网络分析器之前，必须先记录一些数据以供其分析。为此，需要使用启用了统计数据跟踪的引擎版本。通常，这意味着需要使用调试版本，而对于非调试配置，则需要使用编辑器版本。更具体而言，引擎应该是用非零值的 `STATS` 宏进行编译的。

> [!NOTE]
> 有关统计信息跟踪的更多信息，请参阅[统计数据命令](../../../../testing-and-optimizing-content/stat-commands/index.md)文档。

### 使用命令行参数

可传递 `networkprofiler=true` 命令行参数在引擎启动后便立即进行记录。

### 使用控制台命令

还可在运行时使用以下控制台命令来控制是否要记录网络分析器数据：

- netprofile

  ：切换记录的打开和关闭
- netprofile enable

  ：如果尚未记录，则开始记录
- netprofile disable

  ：如果当前正在记录，则停止记录

### 文件保存位置

在分析会话期间记录的数据文件保存为 `<PROJECT_DIRECTORY>/Saved/Profiling/<PROJECT_NAME>-<TIMESTAMP>.nprof`。如果在同一目录中看到一个名为 `NetworkProfiling.tmp` 的文件，这只是引擎在收集数据时使用的临时文件。当前分析会话停止后，便会根据上述命名格式重命名此文件，然后即可在独立网络分析器工具中将其打开。

## 服务器和客户端注意事项

服务器和客户端的分析数据均可记录。但是，请注意，由于只有服务器会复制Actor及其属性，因此在查看客户端上记录的分析数据时，只能看到从该客户端发送的RPC的详细数据。

## 查看分析会话

网络分析器是一个独立的应用程序，位于 `<UNREAL_ENGINE_ROOT>/Engine/Binaries/DotNET/NetworkProfiler.exe`。在窗口顶部，单击 **打开文件（Open File）** 按钮选择 `*.nprof` 文件，即可查看其中包含的数据。

### 用户界面

默认情况下会选中 **图表、过滤器、细节（Chart, Filters, Details）** 选项卡。本小节概要介绍网络分析器的用户界面。

![undefined](../../../../../assets/images/e2/e21fc183a462a94cf2336fba8a8d3a4e62acfc08b5fb5acc7771f66ca4588fda.png)

1. 视图选项卡

   - 图表、过滤器、细节（Chart, Filters, Details）
   - 所有Actor（All Actors）
   - 所有属性（All Properties）

     ）
   - 所有RPC（All RPCs）
   - 所有对象（All Objects）
2. 图表
3. 统计数据列表
4. 细节

   - 摘要
   - Actor
   - 令牌细节
5. 应用过滤器（Apply Filters）

#### 视图选项卡

使用 **视图选项卡** 可选择要查看的信息。

##### 图表、过滤器、细节

这是最详细的视图。在此视图模式中可以：

- 查看

  图表
- 使用

  统计数据列表

  来优化分析
- 深入查看

  细节
- 应用过滤器（Apply Filters）

##### 所有Actor

**所有Actor（All Actors）** 视图模式显示此会话中分析的所有Actor的相关信息。此选项卡具有与[所有属性（All Properties）](#%E6%89%80%E6%9C%89%E5%B1%9E%E6%80%A7)、[所有RPC（All RPCs）](#%E6%89%80%E6%9C%89rpc)和[所有对象（All Objects）](#%E6%89%80%E6%9C%89%E5%AF%B9%E8%B1%A1)选项卡类似的功能和显示信息。这些选项卡中的每一个都会显示整个分析会话的相应复制数据的摘要。请注意，这些选项卡中显示的数据不受 **图表、过滤器、细节（Chart, Filters, Details）** 选项卡上的图表中选择的当前帧或时间范围所影响。

这些选项卡分别显示Actor、属性、RPC或对象的列表。**总大小（Total Size）** 和 **平均大小（Average Size）** 列显示特定项目所需的带宽量，**计数（Count）** 列显示在分析会话期间复制特定项目的次数。此处的信息包括：

| 标题名称 | 描述 |
| --- | --- |
| Actor类（Actor Class） | 此行的Actor类的名称。 |
| 平均时间（Average Time） | 发送复制的信息的平均时间（以 `ms` 为单位）。 |
| 时间（Time） | 发送复制的信息所用的总时间（以 `ms` 为单位）。 |
| 平均大小（Average Size） | 复制的信息的平均大小（以 `Bits` 为单位）。 |
| 平均大小（Average Size） | 复制的信息的平均大小（以 `Bytes` 为单位）。 |
| 计数（Count） | 此Actor的信息被复制的次数。 |
| 总大小（Total Size） | 复制的信息的总大小（以 `KBytes` 为单位）。 |

> [!TIP]
> 通过单击列标题，可在按列进行升序或降序排序之间进行切换。

##### 所有属性

**所有属性（All Properties）** 视图模式显示此会话中分析的所有属性的相关信息。此表中的列标题与[所有Actor（All Actors）](#%E6%89%80%E6%9C%89actor)分段相同，只不过 **Actor类（Actor Class）** 标题替换为 **属性（Property）** 标题，表示指定行的属性名称。

##### 所有RPC

**所有RPC（All RPCs）** 视图模式显示此会话中分析的所有RPC的相关信息。此表中的列标题与[所有Actor（All Actors）](#%E6%89%80%E6%9C%89actor)分段相同，只不过 **Actor类（Actor Class）** 标题替换为 **RPC** 标题，表示指定行的RPC名称。

##### 所有对象

**所有对象（All Objects）** 视图模式显示此会话中分析的所有对象的相关信息。此处的信息包括：

| 标题名称 | 描述 |
| --- | --- |
| 对象类（Object Class） | 此行的对象类的名称。 |
| 比较次数（# Comparisons） | 进行比较的次数。 |
| 复制次数（# Replications） | 进行复制的次数。 |
| 比较时间（Comparison Time） | 进行比较所用的时间（以 `ms` 为单位）。 |
| 每次比较的平均时间（Average Time Per Compare） | 进行比较所用的平均时间（以 `ms` 为单位）。 |

此视图模式还包括一个单独的属性表。此处的信息包括：

| 标题名称 | 描述 |
| --- | --- |
| 属性 | 此行的属性的名称。 |
| 比较次数（# Comparisons） | 进行比较的次数。 |
| 更改次数（# Times Changed） | 更改属性值的次数。 |
| 复制次数（# Replications） | 进行复制的次数。 |

#### 图表

这是主图表视图。与其他分析应用程序中的图表类似，此视图显示一段时间内启用的统计数据的图表。可单击特定帧以使用与该帧关联的数据来填充其他视图，或者单击并拖动图表以放大该区域并查看该时间范围的汇总数据。

> [!NOTE]
> 图表视图和以下所有选项仅在[图表、过滤器、细节](#%E5%9B%BE%E8%A1%A8%E3%80%81%E8%BF%87%E6%BB%A4%E5%99%A8%E3%80%81%E7%BB%86%E8%8A%82)视图模式下可用。

#### 统计数据列表

这是网络分析器跟踪的所有统计数据的列表。切换特定复选框将在图表中显示或隐藏相应的统计数据。对于大多数统计数据，可选择显示原始计数、每秒计数、字节数或每秒字节数。

#### 细节

细节选项卡显示更深入的网络分析信息。

##### 摘要

这是在图表中选择的时间范围内的数据摘要。此处显示原始总计信息以及每秒信息。请注意，"传出带宽（Outgoing bandwidth）"将大于"游戏套接字发送大小（Game socket send size）"，因为"传出带宽（Outgoing bandwidth）"还包括IP和UDP标头大小的近似值。

##### Actor

在图表中选择单个帧时，此视图将显示在该帧期间复制的Actor类型的列表，按复制它们所用的CPU时间进行排序。如果某个Actor具有关联的复制属性，则展开这个Actor的树状图将显示每个属性。对于Actor，第一列数字是该Actor的CPU复制时间（以毫秒为单位）， 第二列是用于表示集合中该Actor的字节数，第三列是在当前帧期间复制的给定类型的Actor数量。对于属性行，第一列是用于该属性的字节数，第二列是为该Actor复制的具有给定名称的属性数量。

##### 令牌细节

此视图对当前选定帧上发送的数据进行细分。可查看已发送的Actor、属性和远程函数，以及各自占用的字节数。请注意，复制的Actor和RPC都包含在集合中，因此 `SendBunchSize` 分段中的值包括发送RPC和复制Actor的字节数。最终，`SocketSend` 条目将准确反映引擎发送到传出套接字的字节数。另外请注意，此处不包括标准UDP数据包开销。

#### 应用过滤器

可输入Actor、属性和RPC的过滤器，然后单击 **应用过滤器（Apply Filters）** 按钮，图表便会更新，仅显示含有过滤器字段中输入文本的Actor、属性和RPC的相关数据。应用过滤器后，在图表中选择某个帧或帧范围还将相应地过滤摘要和帧细节视图中的数据。

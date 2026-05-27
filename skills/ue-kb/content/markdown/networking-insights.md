# Networking Insights

---
title: "Networking Insights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/networking-insights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "Networking Insights"]
---

# Networking Insights

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / Networking Insights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/networking-insights-in-unreal-engine

Unreal Insights包含用于优化、分析和调试网络流量的 **Networking Insights** 。用户可以利用以下功能记录追踪信息，以显示网络行为：

- 游戏实例（Game Instance）功能按钮，用于在记录网络会话期间显示可见机器
- 连接模式（Connection Mode）功能按钮，用于显示传出或传入的数据
- 数据包概览（Packet Overview）面板，用于显示游戏期间传输或接收的数据包时间轴（和大小）
- 数据包内容（Packet Content）面板，用于显示数据包内容，例如重复的对象、属性和远程函数调用
- 网络统计数据（Net Stats）面板，用于显示选定数据包的追踪事件，包括数据包总大小、大小上限、以及排除式或包含式数据包平均大小。

## 设置

继续前，请确保你已安装[Unreal Insights](https://dev.epicgames.com/documentation/404)。

## 使用Networking Insights

要分析数据，请先使用以下命令行启动你的项目实例。

```
	-NetTrace=[VerbosityLevel] -trace=net 
```

`VerbosityLevel` 应设为大于零的值。举例而言，若游戏实例以 `-NetTrace=1` 开头，Unreal Insights将打开会话来收集和报告网络追踪数据，以用于分析。

> [!NOTE]
> 编辑器运行追踪数据自身的数据存储，意味着需要指定tracehost，在编辑器中运行时收集网络追踪数据。使用以下代码指定tracehost：`-NetTrace=1 -tracehost=localhost -trace=net`

## Networking Insights窗口

可在Networking Insights窗口中找到网络会话数据。

> [!NOTE]
> 有关Unreal Insights的其他指令、技巧和信息，请参阅[参考](../unreal-insights-reference/index.md)文档。

Networking Insights窗口包含连接选项面板（1）、数据包面板（2）、网络统计数据面板（3）和连接选择面板（4）。

### 数据包概览面板

数据包概览面板显示条形图表，显示各接收或传输数据包的大小（以比特为单位）。它适用于识别需要进一步研究的大型数据包。左键点击条，选择数据包。

> [!WARNING]
> 各数据包报告的大小为压缩前大小，因此网络上的实际数据可能小于报告显示数据。

将鼠标悬停在数据包上可显示信息：

- 数据包索引
- 序列编号
- 内容大小（比特）
- 总大小（字节），含未使用的比特
- 发送或接收数据包的时间的时间戳
- 数据包的当前状态（已交付或未交付）
- 接收数据包时的连接状态
- 发送或接收数据包的时间的引擎帧号

选择多个包的方法：点击选择初始包，按住Shift键并点击其他数据包，其中拖放数据包显示为红色。

### 数据包内容面板

数据包内容面板显示当前所选数据包的实际内容。数据包内容显示为层级事件图表，从左侧零位开始。它是研究各数据包的数据内容到属性级别的主要工具。

显示数据包中包含的数据束的数据包内容面板。这包括有关复制的对象和属性的信息。

第一级显示数据包中包含的束。各束均以其所属通道命名。若报告束在报告时已设置调试名称，则使用 `debugname` 而非 `channelname` 提供额外情境（若有）。

第二级通常显示束中包含的复制对象。若事件已分配NetId（NetGUID），还会显示此ID。将鼠标悬停在事件上可显示全部事件信息。事件层级的再下一层显示复制属性（包括写入位数）。

事件层级再往下的事件将显示复制的属性，包括写入了多少位。

将鼠标悬停在事件上将显示事件的所有信息。

> [!TIP]
> 该面板拥有查找数据包或查找属特定NetId的功能按钮。

你可以使用键盘在数据包内容面板和数据包概述面板中导航。按上下方向键将在关卡之间移动。按左右方向键将在同一关卡上的事件之间移动。如果你按住CTRL或CMD键并按左或右方向键，你将在数据包之间移动。

### 连接下拉列表

数据包概览面板顶部有可选择显示数据的功能按钮。

![connection-drop-down-list](../../../../assets/images/6c/6c5086121599be1c3bdc20fce4a8bfc0f40ad87ad8586fe9c6129531df7888a0.png)

位于数据包概述面板顶部的连接下拉列表。该示例显示了服务器游戏实例中玩家0的连接，并选择了传入数据。

数据包内容面板中有下列下拉列表：

| 下拉列表 | 说明 |
| --- | --- |
| **游戏实例（Game Instance）** | 显示录制会话期间观察到的每个唯一NetDriver创建的游戏实例。例如，使用PIE时服务器和每个客户端都有各自的实例。 |
| **连接（Connection）** | 此下拉列表选择特定连接，显示所选游戏实例会话期间观察到的每个连接。 |
| **连接模式（Connection Mode）** | 此下拉列表控制是否显示输入的传出数据。 |

### 网络统计数据面板

网络统计数据面板将列出数据包概览面板中所选数据包范围的所有追踪事件。

![显示多个关卡的数据的网络统计数据面板特写](../../../../assets/images/c2/c23452c2639d5c93bb9e3ecbc126adf047a1896ab2cccfe37cf04fb9307acb1d.jpg)

网络统计数据面板按级别对事件分组

除基于所选范围聚合数据外，还可根据任何活动列中的值按升序或降序排列此列表。右键点击列表任意位置即可更改排序，或激活/停用列。 有以下各列：

- 类型
- Level
- 实例计数
- 总包含大小（比特）
- 最大包含大小（比特）
- 总独占大小
- 最大独占大小

要按名称筛选事件，使用"搜索网络事件或组（search net events or groups）"字段。可根据这些事件类型分组：

| 组名 | 说明 |
| --- | --- |
| Level | 为每个Level创建一个组。 |
| Flat | 创建一个组。包含所有网络事件。 |
| Name | 为一个字符创建一个组。 |

由于不同级别会出现相同名称，因此按级别分组有助于用户更好地理解数据。下表介绍此类级别：

| 级别 | 说明 |
| --- | --- |
| **0** | 通常为通道信息，显示使用该通道名称的所有束。 |
| **1** | 复制对象（Actor），此级别的多数事件都显示序列化对象。 |
| **2** | 报告来自属性复制或RPC的事件。 |
| **3** | 序列化属性时报告事件。 |
| **4** | 序列化属性、数组内容等时报告其他事件。 |

> [!NOTE]
> 网络统计数据面板有 **!0** 开关，可筛除选定范围内没有数据的事件类型。

## 数据范例

> [!NOTE]
> 欲了解网络数据包内容追踪宏的内容，请参见[Unreal Insights参考](../unreal-insights-reference/index.md)。

我们提供以下范例，以便大家更好地了解Networking Insights显示的数据：

### 复制对象

![新Actor的初始复制](../../../../assets/images/e8/e84c58bb6081c9bd6fb3656b029f7507f2226f2d953b7d6f005e715c82e4853b.jpg)

它初始复制新Actor——ReplicationGraphDebugActor，NetGUID 10。

在包含新Actor的束前存在NetGUID束，其包含新Actor中的所有导出引用（包括NetGUID）。

### RPC

![名为ClientAckGoodMove的RPC的示例，它是角色的移动系统的一部分](../../../../assets/images/cc/cc62d562ccd5381bd33660739399793b95eaf47358d34e8a15decf9e7bbbdf34.jpg)

它是RPC指定的ClientAckGoodMove，针对NetGUID为14的PlayerPawn_C。

> [!NOTE]
> GUID必须经过映射。

### 拆分束

传输拆分束报告行为生成事件数据和第一部分——在收到拆分束时，先报告各部分，收到所有部分后再报告事件及最后一部分。

![传出束的示例。](../../../../assets/images/dc/dce50e2a10d048b9ad457e1550e84cfef85e2c61848017044673d10e4d115a0f.jpg)

它是拆分的传出束。注意束中事件大于束本身。

接下来的几个数据包外观如下：

![为拆分束提供其余数据的数据包的示例。](../../../../assets/images/0c/0cf8023987f0a223cc6db5390702a3b94d4cb2605f6825d111d14a3aa76bb933.jpg)

> [!NOTE]
> 传入拆分束显示相反模式，此处报告事件和最后部分束。

### 子对象

![以相同束作为其所有者的子对象的示例](../../../../assets/images/9b/9b53af21777ebe2d64851362b6df7b4b9b948ded370e1333dc60f146fa60a2bc.jpg)

它是子对象范例——注意BotPawn_C后的第二个Actor拥有相同束。


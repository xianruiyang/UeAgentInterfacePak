---
title: "日志"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/logging-for-networked-games-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络调试", "日志"]
---

# 日志

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络调试 / 日志

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/logging-for-networked-games-in-unreal-engine

## 网络游戏的日志记录

**客户端**和**服务器**日志对于识别和调试网络问题非常重要。 虽然许多网络日志属于**LogNet**类别，但我们建议检查与特定系统更密切相关的日志类别，以便更深入地了解问题。

这些类别默认情况下未启用，并且具有不同的冗长度，你可能需要调整，从而获取有关你正在经历的行为的信息。 下面的列表提供了一些推荐的类别：

| 类别 | 说明 |
| --- | --- |
| **LogNetTraffic** | 当此日志变量设置为VeryVerbose时，记录所有网络流量。 |
| **LogNetPackageMap** | 记录关于如何发送、接收和确认NetGUID的信息。 |
| **LogNetVersion** **LogNetFastTArray** **LogNetDormancy** **LogRep** **LogRepTraffic** | 记录关于FRepLayout和FObjectReplicator使用的属性复制和RepNotify函数的信息。 |
| **LogRepProperties** | 记录关于发送和接收复制属性的信息。 |
| **PacketHandlerLog** | 记录关于数据包处理程序及其组件的信息。 这些组件有自己的子类别。 例如LogDTLSHandler、OodleNetworkHandlerComponentLog和LogHandshake。 |
| **LogDemo** | 记录关于录制和播放的信息。 每个回放流送器都有相关的日志类别：LogLocalFileReplay、LogSaveGameReplay、LogNullReplay和LogMemoryReplay。 |

你可以启用这些类别并调整其冗长度，方法是传入命令行参数：

### 命令行参数

传入`LogCmds`命令行参数：

C++

```
-LogCmds="<LOG_CATEGORY> <LOG_VERBOSITY>"
```

例如，将`LogNetTraffic`设为`VeryVerbose`：

C++

```
-LogCmds="LogNetTraffic VeryVerbose"
```

### 控制台命令

使用`Log`控制台命令：

C++

```
Log <LOG_CATEGORY> <LOG_VERBOSITY>
```

例如，将`LogNetTraffic`设为`Verbose`：

C++

```
Log LogNetTraffic Verbose
```

### 引擎配置

在项目的`DefaultEngine.ini.`中设置如下：

C++

```
[Core.Log]<LOG_CATEGORY1>=<LOG_VERBOSITY1><LOG_CATEGORY2>=<LOG_VERBOSITY2>...
```

例如，将不同类型的内容设置为不同日志等级：

C++

```
[Core.Log]LogNetPackageMap=LogLogNetTraffic=VerboseLogRep=VeryVerbose
```

## 帮助性报错

读取日志时，以下列表可用于确定发生的错误类型。

|  |  |
| --- | --- |
| **UEngine::BroadcastNetworkFailure** | 当网络驱动程序遇到一些重大错误时打印。 日志行将包括失败类型、错误字符串和关于出现错误的网络驱动程序的描述。 你可以在EngineBaseTypes.h的ENetworkFailure枚举中查看可能的网络故障列表和简要说明。 |
| **UNetConnection::Close** | 关于正在关闭的连接的描述。 |
| **UActorChannel::Close** | LogNetTraffic类别将包括通道索引、该通道的Actor及其关闭原因。 检查有关这些行的日志有助于提供有关连接或Actor通道关闭原因的一些指示。 |

命令行参数`-LogTrace=<PARTIAL_LOG_LINE>`会根据部分日志消息字符串执行堆栈追踪。 例如`-LogTrace=UNetConnection::Close`会在每次`UNetConnection::Close`被打印到日志时生成堆栈追踪。 命令行参数`-DumpRPCs`会提供转储RPC及其参数的功能，这对于跟踪正在发送的RPC及其参数很有用。

> [!NOTE]
> LogTrace和DumpRPCs都需要启用**NetcodeUnitTest**。

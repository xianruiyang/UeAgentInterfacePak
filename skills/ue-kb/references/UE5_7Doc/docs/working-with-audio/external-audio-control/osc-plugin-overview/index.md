---
title: "OSC插件概览"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/osc-plugin-overview-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "外部音频控制", "OSC插件概览"]
---

# OSC插件概览

> 路径：虚幻引擎5.7文档 / 处理音频 / 外部音频控制 / OSC插件概览

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/osc-plugin-overview-for-unreal-engine

**开放音效控制**（**OSC**）是众多音频行业领域常用开放协议。其主要用于客户端之间的网络泛型音频数据，但也可用于非音频数据。

OSC插件提供直观、类型安全的蓝图库，开发者可利用其快速迭代 **虚幻引擎** 中的网络音频（及潜在的其他域）数据。启用该插件后，通过 **C++** 或 **蓝图** 中的简单API发送和接收OSC事件。其支持发送和接收消息和包，或者两者的组合。

> [!NOTE]
> 必须启用 **OSC** 插件才能使用此功能。前往 **编辑（Edit）> 插件（Plugins）> 输入设备（Input Devices）**，然后选中 **OSC（开发音效控制）** 选项进行启用。

## 根类型

### OSC服务器

**OSC服务器（OSC Server）**（`UOSCServer`）充当消息的聆听终端，此类消息将被发送至虚幻引擎的本地实例。其支持组播回路，同时解析OSC消息和包。同时还允许服务器明确声明将聆听的IP地址（允许列表）。

用户可绑定事件以接收使用给定地址模式的所有OSC地址中的消息（参见下方 *将事件绑定到地址模式*），聆听所有消息（参见下方 *将事件绑定到所有消息*），或聆听所有包（与下方 *将事件绑定到所有消息* 类似，但需解包接收的包）。

### OSC客户端

**OSC客户端（OSC Client）**（`UOSCClient`）提供发送OSC消息和包的方式。

### FOSC地址

**OSC地址（OSC Address）**（`FOSCAddress`）是可为有效或无效模式的类型化路径。作为有效路径，可将其作为消息数据包的一部分创建、发送和接收。

其包含一组容器排列以及形式为 `/Container1/Container2/Method` 的方法，可作为路径或模式查询其有效性，同时还可与字符串相互转换，并使用蓝图调用进行操作。其还可根据另一OSC地址进行过滤，将该地址绑定到事件 `BindEventToOnOSCAddressPatternMatchesPath` 时同样为模式。

### OSC包/消息

**OSC消息**（`FOSCMessage`）和 **OSC包**（`FOSCBundle`）均为OSC客户端中接收的或通过OSC服务器发送的数据包类型。

OSC消息包含地址，该地址也是有效路径且具有支持的OSC协议类型的负载。

OSC包包含一组数据包，数据包包含其他OSC包或OSC消息或者两者皆有。

## 资产类

OSC插件无需资产类。它需要的所有类型都是暂时性的，需通过蓝图创建、管理和销毁。

## 蓝图API

### OSC服务器

| 列 1 | 列 2 |
| --- | --- |
| **OnOsc(Bundle/Message)Received** | 接收OSC包/消息时所调用的事件。 |
| **SetAllowlistClientsEnabled** | 设为true时，服务器将仅处理允许列表客户端中接收的消息。 |
| **(UnbindEvent/UnbindAllEvents/BindEventTo/Get)OnOSCAddressPattern(s)** | OSCAddressPattern匹配时，取消绑定、绑定、移除或获取事件以调度。 |
| **(Add/Remove/Clear/Get)AllowlistedClient(s)** | 将允许列表中的客户端IP地址集作为字符串（IPv4）进行添加、删除、清除或获取。 |

### OSC客户端

| 列 1 | 列 2 |
| --- | --- |
| **(Get/Set)SendIPAddress** | 获取OSC客户端的IP地址和端口。 |
| **SendOSC(Bundle/Message)** | 向特定地址发送OSC包/消息。 |

### OSC包/消息

| 列 1 | 列 2 |
| --- | --- |
| **Add(Bundle/Message)ToBundle** | 向包添加提供的包/消息。 |
| **Get(Bundles/Messages)FromBundle** | 返回包中找到的包/消息。 |
| **(Add/Get) OSC Message (Strings/String at Index, Integer/Integer at Index, and so on)** | 将POD类型添加到OSCMessage，或获取OSCMessage中的POD类型。（可在[此处](http://opensoundcontrol.org/spec-1_0)找到支持类型列表。） |
| **Clear OSC (Message/Bundle)** | 清除消息/包的负载。 |

## 资源/范例

OSC实现基于OSC 1.0协议，可在[OpenSoundControl网站](https://opensoundcontrol.stanford.edu/spec-1_0.html)上找到该协议。

> [!TIP]
> 点击下方每张图片上的 **复制节点图表（Copy Node Graph）** 按钮，并将文本粘贴到蓝图图表即可查看示例。

### 发送OSC消息

### 将事件绑定到所有消息

### 将事件绑定到所有地址模式

## 蓝图API

| 列 1 | 列 2 |
| --- | --- |
| **在索引处获取来自包的OSC消息（Get OSC Message From Bundle At Index）** | 返回在排序索引包中找到的消息。 |
| **将OSC地址（作为字符串）添加到OSC消息（Add OSC Address (As String) to OSC Message）** | 将地址（打包为字符串）值添加到OSCMessage的末尾 |
| **在索引处获取OSC消息地址（Get OSC Message Address At Index）** | 若值在界内，且OSC类型匹配 `String`，则将Value设为OSCMessage中所提供索引的地址。（其 *不会* 返回消息的地址；而是将字符串打包在消息中并强制转换为OSC地址。）若在索引处找到该字符串，且该字符串是有效的OSC地址路径，则返回。 |
| **获取OSC消息地址（Get OSC Message Addresses）** | 按照从OSCMessage接收的顺序返回所有有效地址路径的字符串。（其 *不* 包括消息的地址，只包括有效地址路径消息中打包的字符串。） |
| **在OSC地址处查找对象（Find Object at OSC Address）** | 以路径形式查找拥有给定OSC地址的对象，其中容器对应路径文件夹，而地址方法对应对象名称。 仅支持父对象。 |
| **将对象路径转换为OSC地址（Convert Object Path to OSC Address）** | 将对象路径转换为OSC地址，将文件夹转换为地址容器，并将对象名称转换为地址方法。仅支持父对象。请参见[UObjectBaseUtility::GetPathName](https://docs.unrealengine.com/en-US/API/Runtime/CoreUObject/UObject/UObjectBaseUtility/GetPathName/1/index.html)和[UObjectBaseUtility::GetFullName](https://docs.unrealengine.com/en-US/API/Runtime/CoreUObject/UObject/UObjectBaseUtility/GetFullName/1/index.html)。 |
| **将对象路径（字符串）转换为OSC地址（Convert Object Path (String) to OSC Address）** | 将对象路径字符串转换为OSC地址，将文件夹转换为地址容器，并将对象名称转换为地址方法。仅支持父对象。请参见[UObjectBaseUtility::GetPathName](https://docs.unrealengine.com/en-US/API/Runtime/CoreUObject/UObject/UObjectBaseUtility/GetPathName/1/index.html)和[UObjectBaseUtility::GetFullName](https://docs.unrealengine.com/en-US/API/Runtime/CoreUObject/UObject/UObjectBaseUtility/GetFullName/1/index.html)。 |
| **将OSC地址转换为对象路径（Convert OSC Address to Object Path）** | 将OSC地址转换为对象路径。 |
| **从OSC地址中移除容器（Remove Containers from OSC Address）** | 在索引处从容器排序数组中移除容器，直到符合容器数量要求为止。 |

> [!NOTE]
> 除了上面列出的新蓝图API调用之外，所有索引getter现在均返回 `Succeeded` 布尔值，指明所提供索引处的键入值是否属于给定类型，以及该值是否已按客户端的预期解析。

## 控制台变量

| 列 1 | 列 2 |
| --- | --- |
| `osc.clients` | 将当前初始化的OSC客户端对象的诊断信息打印到输出日志。 |
| `osc.client.connect` | 按照提供的对象名称连接（或重新连接）OSC混合客户端。欲知可用客户端及其各自名称的列表，请参见 `osc.clients`。 |
|  | `Id` （重新）连接的客户端对象ID |
|  | `地址（Address）` （重新）连接的IP地址（默认：LocalHost） |
|  | `端口（Port）` （重新）连接的端口（默认：8094） |
| `osc.client.connectById` | 使用提供的对象ID连接（或重新连接）OSC混合客户端。欲知可用客户端及其各自ID的列表，请参见 `osc.clients`。 |
|  | `Id` （重新）连接的客户端对象ID。 |
|  | `地址（Address）` （重新）连接的IP地址（默认：LocalHost） |
|  | `端口（Port）` （重新）连接的端口（默认：8094） |
| `osc.servers` | 将当前初始化的OSC服务器对象的诊断信息打印到输出日志。 |
| `osc.server.connect` | 使用提供的对象名称连接（或重新连接）OSC混合客户端。欲知可用客户端及其各自名称的列表，请参见 `osc.clients`。 |
|  | `名称（Name）` （重新）连接的服务器对象ID |
|  | `地址（Address）` （重新）连接的IP地址（默认：LocalHost） |
|  | `端口（Port）` （重新）连接的端口（默认：8095） |
| `osc.server.connectById` | 使用提供的对象ID连接（或重新连接）OSC混合客户端。欲知可用客户端及其各自ID的列表，请参见 `osc.clients`。 |
|  | `Id` （重新）连接的客户端对象ID |
|  | `地址（Address）` （重新）连接的IP地址（默认：LocalHost） |
|  | `端口（Port）` （重新）连接的端口（默认：8095） |

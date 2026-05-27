---
title: "EOS语音聊天插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/voice-chat-with-epic-online-services"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "语音聊天接口", "EOS语音聊天插件"]
---

# EOS语音聊天插件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 语音聊天接口 / EOS语音聊天插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/voice-chat-with-epic-online-services

通过 **EOS语音聊天（EOS Voice Chat）** 插件，开发人员可以利用 **Epic在线服务（Epic Online Services）** (EOS)语音接口为其产品添加语音通信功能，包括使用引擎的 **在线子系统（Online Subsystem）** (OSS)中的IVoiceChat和IVoiceChatUser接口。此外，之前使用VivoxVoiceChat的开发人员可以轻松迁移到EOS后端。

## 设置

EOS语音聊天插件实现了IVoiceChat和IVoiceChatUser接口。首先，从编辑器的 **编辑（Edit）** 菜单打开 **插件浏览器（Plugin Browser）** ，然后查找并启用该插件。

在你的项目中启用该插件后，你可以通过 **大厅（Lobbies）** 或 **受信任服务器（Trusted Server）** 方法将其集成。这些方法并不互斥；你可以混合使用，获得每种方法的好处和功能。

> [!NOTE]
> 尽管两种方法都基于EOS的工作方式，但你不需要直接使用EOS SDK来编程。但是，如果你想更好地理解其工作原理，可以阅读[EOS语音接口](https://dev.epicgames.com/docs/services/zh-Hans/GameServices/Voice/index.html?sessionInvalidated=true)文档。阅读时，请注意，IVoiceChat **通道（Channels）** 等效于EOS**房间（Rooms）** ，并且这两个术语应视为可互换。

## 与EOS语音接口集成

"大厅"和"受信任服务器"这两种主要的集成方法提供了不同的功能。我们建议你考虑哪种方法更适合你的项目，或者考虑是否混合方法的效果最佳。利用"大厅"方法，系统将通过EOS自动加入语音聊天，而无需 `IVoiceChatUser::JoinChannel` 功能，并且你将从EOS收到一个IVoiceChatUser实例。"受信任服务器"方法要求你使用来自受信任服务器的凭证调用 `IVoiceChatUser::JoinChannel` 函数，不过好处是，你可以选择要加入或离开哪些通道。此方法还允许你控制你的IVoiceChat和IVoiceChatUser实例，而不是要求你使用EOS提供的实例。如果你想要OnlineSubsystemEOS插件自动管理大厅语音通道，同时你通过IVoiceChat和IVoiceChatUser接口手动管理受信任服务器通道，则可以混合使用这两种集成方法。若开发人员采取混合集成方法，则还可以利用用户已通过"受信任服务器"方法加入的通道，复用"大厅"方法中的IVoiceChatUser实例。

首先，你将需要在[EOS开发人员门户](https://dev.epicgames.com/docs/services/en-US/DevPortal/index.html)上配置你的应用程序。如果你使用的是"大厅"集成方法，还需要在项目中启用 **OnlineSubsystemEOS** 插件。

### 使用"大厅"方法

"大厅"方法会利用EOS来处理加入通道时所涉及的大部分工作。这意味着，使用此集成方法并不需要实现通常的IVoiceChat流程来初始化、连接、登录和加入通道，因为EOS将为你执行相应操作。

对你的项目设置OnlineSubsystemEOS后，您将能够加入并托管EOS大厅会话。执行以下步骤，启用对应语音通道的自动加入：

1. 找到EOS开发人员描绘，然后配置你的应用程序，在其中启用语音支持。
2. 在创建大厅会话时，将 `FOnlineSessionSettings::bUseLobbiesVoiceChatIfAvailable` 设置为 `true` 。
3. 调用 `FOnlineSubsystemEOS::GetVoiceChatUserInterface` 以获得与给定本地用户关联的IVoiceChatUser接口实例。

用户登录EOS后，你可以使用 `GetVoiceChatUserInterface` 函数获得IVoiceChatUser接口的实例。尽管你不需要管理通道，但你可以使用此实例与系统的其他方面交互，如用户的选定输入和输出设备，或其玩家屏蔽列表。使用此接口实例注册事件通知回调。只要用户保持登录状态，OnlineSubsystemEOS插件将自动加入和离开用户加入或离开的任意大厅的关联语音通道。与此同时，EOSVoiceChat将广播 `OnVoiceChatChannelJoined` 和 `OnVoiceChatChannelExited` 委托作为响应。

OnlineSubsystemEOS插件将使用有关大厅会话的信息自动更新EOS语音聊天插件，这些信息包括有关创建、销毁、加入和离开大厅会话的通知。EOS语音聊天插件将广播 `OnVoiceChatChannelJoined` 和 `OnVoiceChatChannelExited` 委托以响应这些事件。

### 使用受信任服务器方法

对于偏好手动通道管理的情况，你将需要使用"受信任服务器"集成方法。例如，你使用的聚会系统不是在EOS大厅上构建的，那么你将需要此方法为你的聚会创建通道。"受信任服务器"方法提供了对用户的通道连接的更大控制权，但它要求用户从受信任服务器检索登录凭证才能加入通道。

#### 受信任服务器引擎配置

> [!NOTE]
> 如果你要复用"大厅"集成中的IVoiceChatUser接口实例，就可以跳过此分段。

如果你不使用"大厅"集成，或者想使用单独的IVoiceChatUser接口实例，就需要将以下分段添加到你的 `Engine.ini` 文件，并填充你的产品信息：

```
	[EOSVoiceChat]	ProductId=	SandboxId=	DeploymentId=	ClientId=	ClientSecret= 
```

使用你的产品的相应值填写每行。你可以在EOS开发人员门户上打开你的产品，找到这些值。EOSVoiceChat会使用这些值创建EOS[平台接口](https://dev.epicgames.com/docs/services/en-US/Interfaces/Platform/index.html)实例。

#### 代码流程

如果你要使用受信任服务器集成方法，请遵守[语音聊天接口](../index.md)文档中所述的相同[代码流程](../index.md#%E4%BB%A3%E7%A0%81%E6%B5%81%E7%A8%8B)。如果你的项目使用这两种集成方法，并且你要将OSS EOS中的一个或多个IVoiceChatUser实例复用于受信任服务器通道，那么这些要求不适用；"大厅"集成会自动处理IVoiceChat流程的大部分工作（包括实例生命周期管理），并提供登录的IVoiceChatUser实例。

##### 加入通道

> [!TIP]
> 尽管你的代码不需要与EOS SDK交互，但加入通道的过程最终会经过EOS语音接口。如果你想要更好地理解该系统，我们推荐阅读EOS文档站点上的相应[文档](https://dev.epicgames.com/docs/services/en-US/Interfaces/Voice/index.html#voiceflowwithatrustedserver)。

加入通道将需要客户端基本URL和来自你的受信任服务器的参与者令牌。填写 `FEOSVoiceChatChannelCredentials` 结构体并将其序列化为类似于下面示例的JSON，以将此信息提供给EOS语音聊天：

```
	// 创建FEOSVoiceChatChannelCredentials数据结构。	FEOSVoiceChatChannelCredentials ChannelCredentials;	// 从受信任服务器设置客户端基本URL；这将因会话而异。	// URL应当形如"wss://example-of-url-us-east-1.rtcp.on.epicgames.com"。	ChannelCredentials.ClientBaseUrl = ClientBaseUrlFromTrustedServer	// 从受信任服务器设置参与者令牌。	ChannelCredentials.ParticipantToken = ParticipantTokenFromTrustedServer; 	// 调用带有FEOSVoiceChatChannelCredentials数据结构的JoinChannel。	VoiceChatUser->JoinChannel(ChannelName, ChannelCredentials.ToJson(), ...); 
```

### 混合使用"大厅"和"受信任服务器"方法

"大厅"和"受信任服务器"集成方法彼此完全兼容。如果你想获得这两种方法的优势，可以复用"大厅"方法中的IVoiceChatUser接口来加入、离开你的受信任服务器通道并与之交互，也可以创建单独的接口实例。

## 测试和调试

### 控制台命令

| 命令 | 说明 |
| --- | --- |
| `eosvoicechat list` | 列出所有EOSVoiceChat实例及其实例ID、调试名称（有助于辨别这些实例）和创建的用户接口数量。 |
| `eosvoicechat info instanceid=<instanceid>` | 将实例的当前状态和所有关联的用户接口转储到日志中。 |
| `eosvoicechat initialize instanceid=<instanceid>` | 初始化此实例。 |
| `eosvoicechat uninitialize instanceid=<instanceid>` | 取消初始化此实例。 |
| `eosvoicechat connect instanceid=<instanceid>` | "连接"此实例。这在EOS语音聊天上应该总是会成功，因为EOS语音会处理每个通道的连接。 |
| `eosvoicechat disconnect instanceid=<instanceid>` | 将此实例断开连接。 |
| `eosvoicechat createuser instanceid=<instanceid>` | 创建新的IVoiceChatUser接口。 |
| `eosvoicechat releaseuser instanceid=<instanceid>` | 释放使用 `createuser` 创建的IVoiceChatUser接口。 |
| `eosvoicechat createsingleuser instanceid=<instanceid>` | 这是适用于非分屏游戏的方便方法。你可以创建单个用户接口，避免在需要它的命令中传递 `UserIndex=<UserIndex>` 。 |
| `eosvoicechat input setvolume instanceid=<instanceid> userindex=<userindex> volume=<volume>` | 设置输入设备的音量。 采用 `0.0` 到 `2.0` 之间的浮点值，其中： `0.0` 是完全消音。 `1.0` 是不改变音量。 `2.0` 是音量翻倍。 |
| `eosvoicechat input mute instanceid=<instanceid> userindex=<userindex>` | 将输入设备静音。 |
| `eosvoicechat input unmute instanceid=<instanceid> userindex=<userindex>` | 将输入设备取消静音。 |
| `eosvoicechat input listdevices instanceid=<instanceid> userindex=<userindex>` | 列出可用的输入设备。 |
| `eosvoicechat input setdevice instanceid=<instanceid> userindex=<userindex> deviceid=<deviceid>` | 选择特定输入设备。你可以通过 `listdevices` 命令获取有效 `deviceid` 值的列表。 |
| `eosvoicechat input setdefaultdevice instanceid=<instanceid> userindex=<userindex>` | 恢复为使用默认输入设备。 |
| `eosvoicechat output setvolume instanceid=<instanceid> userindex=<userindex> volume=<volume>` | 设置输出设备的音量。 采用 `0.0` 到 `2.0` 之间的浮点值，其中： `0.0` 是完全消音。 `1.0` 是不改变音量。 `2.0` 是音量翻倍。 |
| `eosvoicechat output mute instanceid=<instanceid> userindex=<userindex>` | 将输出设备静音。 |
| `eosvoicechat output unmute instanceid=<instanceid> userindex=<userindex>` | 将输出设备取消静音。 |
| `eosvoicechat output listdevices instanceid=<instanceid> userindex=<userindex>` | 列出可用的输出设备。 |
| `eosvoicechat output setdevice instanceid=<instanceid> userindex=<userindex> deviceid=<deviceid>` | 选择特定输出设备。你可以通过 `listdevices` 命令获取有效 `deviceid` 值的列表。 |
| `eosvoicechat output setdefaultdevice instanceid=<instanceid> userindex=<userindex>` | 恢复为使用默认输出设备。 |
| `eosvoicechat login instanceid=<instanceid> userindex=<userindex> playername=<playername>` | 使用户登录此接口。`playername` 参数是用户的字符串化EOS产品ID。 |
| `eosvoicechat logout instanceid=<instanceid> userindex=<userindex>` | 使用户从此用户接口注销。 |
| `eosvoicechat channel join instanceid=<instanceid> userindex=<userindex> channelname=<channelname> channeltype=<channeltype>` | 加入指定通道。此命令不会向受信任服务器查询客户端基本URL或参与者令牌；它将使用配置文件中的 `InsecureClientBaseUrl` ，以及生成的参与者令牌。请参阅 `FEOSVoiceChatUser::InsecureGetJoinToken` 。`channeltype` 参数是可选的。有一个名为"echo"的反馈通道，对于单用户测试很有用。 |
| `eosvoicechat channel leave instanceid=<instanceid> userindex=<userindex> channelname=<channelname>` | 离开指定通道。 |
| `eosvoicechat channel transmit instanceid=<instanceid> userindex=<userindex> channelname=<channelname>` | 仅传输到特定的指定通道。 |
| `eosvoicechat channel transmitall instanceid=<instanceid> userindex=<userindex>` | 传输到所有通道。 |
| `eosvoicechat channel transmitnone instanceid=<instanceid> userindex=<userindex>` | 不传输到任何通道。 |
| `eosvoicechat player mute instanceid=<instanceid> userindex=<userindex> playername=<playername>` | 将指定远程玩家禁言。尽管你听不到该玩家的声音，该玩家仍可以听到你的声音。要同时停止向其发送输入，请参阅屏蔽命令。 |
| `eosvoicechat player unmute instanceid=<instanceid> userindex=<userindex> playername=<playername>` | 将指定远程玩家取消禁言。 |
| `eosvoicechat player block instanceid=<instanceid> userindex=<userindex> playername=<playername>` | 屏蔽指定远程玩家，使你和该玩家互相听不见。 |
| `eosvoicechat player unblock instanceid=<instanceid> userindex=<userindex> playername=<playername>` | 取消屏蔽指定远程玩家。 |
| `eosvoicechat player setvolume instanceid=<instanceid> userindex=<userindex> playername=<playername> volume=<volume>` | 设置指定远程玩家的音量。 采用 `0.0` 到 `2.0` 之间的浮点值，其中： `0.0` 是完全消音。 `1.0` 是不改变音量。 `2.0` 是音量翻倍。 |

### 日志输出

`LogEOSVoiceChat` 日志类别包含来自EOSVoiceChat插件本身的所有日志输出（包括上述控制台命令），而 `LogEOSSDK` 日志类别包含来自底层EOS SDK的日志输出。更改 `LogEOSSDK` 日志类别的冗长度级别还将更新EOS SDK [日志记录接口](https://dev.epicgames.com/docs/services/en-US/Interfaces/Logging/index.html)上的日志冗长度级别设置，因此这两者始终是同步的。

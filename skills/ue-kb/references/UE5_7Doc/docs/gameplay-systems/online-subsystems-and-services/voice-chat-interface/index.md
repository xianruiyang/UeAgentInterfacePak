---
title: "语音聊天接口"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/voice-chat-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "语音聊天接口"]
---

# 语音聊天接口

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 语音聊天接口

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/voice-chat-interface-in-unreal-engine

玩家之间的语音通信是一种常见功能，可用于快速轻松地与其他人通信。但是，语音聊天的特定实现在不同在线服务和平台之间有所不同。通过 **语音聊天接口** ，你可以轻松在各种不同服务上操作语音通信，而不必为每个服务编写自定义代码，包括 **Epic在线服务**（EOS）、Vivox和现代游戏主机。语音聊天接口提供了与平台无关的API，可支持将语音聊天集成到你的产品中所需的所有功能：加入语音通道、选择输入和输出设备、将其他用户禁言或屏蔽，以及传输和接收音频数据。

> [!NOTE]
> 如果你计划将EOS用作语音通信提供程序，请阅读[EOS语音聊天插件](voice-chat-with-epic-online-services/index.md)文档，了解有关配置操作的具体信息，以将其用于你的产品。

## 用户管理

语音聊天接口可为每个用户实例化一个 **语音聊天用户接口** ，从而识别各个用户。利用这种分离方法，系统能够支持多个本地用户，以及在系统范围与每个用户的行为和设置之间做出区分。

### 创建和销毁

由于语音通信在用户之间发生，你必须使用 `CreateUser` 函数创建至少一个本地 **语音聊天用户** 。如果你使用的服务或平台支持在同一个系统上有多个用户，你可以多次调用 `CreateUser` ，每次调用将返回一个新的 `IVoiceChatUser` 接口。你的语音聊天用户接口实例会执行特定于单个用户的所有语音聊天互动。请务必在每个语音聊天用户接口不再需要时对其调用 `ReleaseUser` 。请参阅以下参考子小节，了解更多特定详情。

#### 代码流程参考

要创建你自己的IVoiceChat和IVoiceChatUser实例，请遵循此生命周期。首先创建和初始化单个IVoiceChat实例，并将其用于为每个本地用户（或玩家）创建一个IVoiceChatUser实例。用户可以利用该IVoiceChatUser实例自由地手动进入和离开所有可信服务器通道，并且可以与其他用户通信。当你准备好结束语音通信时，通常是在应用程序关闭期间，请取消初始化你创建的全部实例。此流程涉及以下函数，它们必须按顺序调用：

| 函数 | 用途 |
| --- | --- |
| `IVoiceChat::Initialize` | 初始化IVoiceChat实例。你必须对你创建的所有实例调用此函数，然后才能使用该实例。 |
| `IVoiceChat::Connect` | 连接到预配置的语音服务器。 |
| `IVoiceChat::CreateUser` | 创建IVoiceChatUser接口实例。打算加入通道的每个本地用户都需要其自己的实例才能登录。与此流程中的其他函数不同，你可以随时调用 `CreateUser` 。 |
| `IVoiceChatUser::Login` | 将本地用户登录到语音聊天服务器。`PlayerName` 参数是用户的EOS产品ID，使用 `EOS_ProductUserId_ToString` API进行了字符串化，并使用UTF8_TO_TCHAR或类似方法转换为了FString。相关EOS产品ID不需要通过EOSVoiceChat使用的平台实例的连接接口实际登录，只需要是有效的EOS产品ID即可。必需的身份验证由可信服务器以通道加入凭证的形式提供，这些凭证接着会传递到 `IVoiceChatUser::JoinChannel` 。 |
| `IVoiceChatUser::JoinChannel` | 登录到服务器后加入通道。用户一次可以加入多个通道，并且可以在离开后重新加入通道；每个通道将从此刻开始继续单独遵循该流程。此过程需要凭证；请参阅下面有关[加入通道](#%E5%8A%A0%E5%85%A5%E9%80%9A%E9%81%93])的小节，了解有关获取凭证的信息。 |
| `IVoiceChatUser::LeaveChannel` | （可选）导致本地用户离开之前使用 `JoinChannel` 加入的通道。 |
| `IVoiceChatUser::Logout` | （可选）将本地用户从语音聊天服务器注销。这样做还会导致该用户离开所有通道。注销后，你可以调用 `Login` 以重新登录，而无需创建新的接口实例。 |
| `IVoiceChat::Disconnect` | （可选）从语音服务器断开连接。这样还将实际注销并离开用户已加入的全部通道。 |
| `IVoiceChat::Uninitialize` | 关闭IVoiceChat接口实例。调用此函数还会离开用户已加入的全部通道，注销，并从语音聊天服务器断开连接。此函数通常在应用程序关闭期间调用。 |

### 配置用户设置

语音聊天服务可能有一些设置可以逐个用户进行配置。特定设置和可接受的值因服务而异，但语音聊天接口使用 `SetSetting` 和 `GetSetting` 函数封装了此功能。这两个函数都将 `FString` 用作键和值类型。

### 屏蔽和禁言

将 `BlockPlayers` 和 `UnblockPlayers` 用于玩家姓名列表可分别将列表上的所有玩家屏蔽或取消屏蔽。如果你想将玩家禁言或取消禁言，请使用 `SetPlayerMuted` 。你可以使用 `IsPlayerMuted` 检查以了解特定玩家是否被禁言。

### 管理音频设备

管理用户的音频输入和输出设备很简单。如果你想让用户可以选择要使用的设备，你可以查询用户系统上的设备，或者选择不同于默认值的输入或输出设备。你还可以调整设备的音量，包括静音选项。

#### 识别和选择识别

使用 `GetInputDeviceInfo` 和 `GetOutputDeviceInfo` 可分别识别当前输入和输出设备。你还可以调用 `GetDefaultInputDeviceInfo` 和 `GetDefaultOutputDeviceInfo` 以获取默认设备的身份，或者调用 `GetAvailableInputDeviceInfos` 和 `GetAvailableOutputDeviceInfos` 以获取所有可用设备的列表。当你知道要使用的设备之后，调用 `SetInputDeviceId` 或 `SetOutputDeviceId` 以选择它。

#### 更改音量和静音

你可以使用 `SetAudioInputVolume` 和 `SetAudioOutputVolume` 调整你的设备的音量，或者使用 `GetAudioInputVolume` 和 `GetAudioOutputVolume` 检查当前值。同样，`SetAudioInputDeviceMuted` 和 `SetAudioOutputDeviceMuted` 可以将你的设备静音（或取消静音），而 `GetAudioInputDeviceMuted` 和 `GetAudioOutputDeviceMuted` 则报告你的设备当前是否被静音。

## 与其他用户通信

要在用户之间进行语音通信，就要求他们全都登录，并且语音聊天接口本身连接到语音聊天服务器。

### 加入和离开

与其他用户通信时，涉及到三层连接。语音聊天接口必须连接到语音通信服务器，语音聊天用户接口必须登录，最后，语音聊天用户接口必须与其他用户加入一个通道。

首先对你的语音聊天用户调用 `Login`，接着是语音聊天接口 `Connect` 函数，然后等待你的 `FOnVoiceChatConnectCompleteDelegate` 回调函数确认你已成功连接。你还可以随时调用 `IsConnected` 来检查连接的状态。如果你当前未连接，`IsConnected`会告知你此时你是否在尝试连接。

连接后，你可以使用 `GetChannels` 查询服务器的通道，并使用 `JoinChannel` 和 `LeaveChannel` 函数参与不同的群聊。

结束聊天后，调用 `Disconnect` 以从服务器断开连接。这将从服务器断开语音聊天接口的连接，这样所有本地用户都将无法通信。如果你只想将特定用户注销，请对该用户的语音聊天用户接口调用 `Logout` 函数。关闭之前，你应该断开连接并将每个用户注销。

> [!NOTE]
> 影响整个本地系统的函数（例如连接到服务器或从中断开连接）会对语音聊天接口进行操作。仅与一个本地玩家相关的操作（例如加入或离开通道，或与音频硬件互动）是语音聊天用户接口的一部分。

### 传输

系统会通过用户已加入的通道将该用户的音频输入传输到其他用户。你可以使用 `TransmitToAllChannels` 设置用户以传输到该用户当前所在的所有通道，或使用 `TransmitToSpecificChannel` 传输到特定通道。使用 `TransmitToNoChannels` 可停止所有通道传输。

---
title: "Friends Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-friends-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线子系统", "Friends Interface"]
---

# Friends Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线子系统 / Friends Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-friends-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

与好友一起游戏并在线结识新玩家，是许多在线服务的重要部分。 **Friends 接口** 包含用于管理用户社交联系人列表的功能，包括添加、移除和屏蔽其他用户。

## 管理好友

好友列表存储在在线服务服务器上，并且会在会话期间发生变化，例如好友被添加或移除、加入或离开游戏和会话、登录或退出服务。因此，管理这些列表需要向服务器查询最新信息，然后缓存这些信息并在游戏中使用。

### 获取好友列表

处理用户好友列表的第一步通常是调用 `ReadFriendsList`，它会获取属于指定本地用户的命名好友列表的最新版本。有效列表名称可在 [EFriendsList](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineSubsystem/Interfaces/EFriendsLists__Type?application_version=5.5) 枚举类型中找到，并可通过提供的 `ToString`函数转换为字符串。由于它会查询远程机器， `ReadFriendsList` 是异步的，并会在完成时调用类型为 `FOnReadFriendsListComplete` 的委托。

> [!NOTE]
> 成功时，此调用会缓存列表，以便之后检查，而无需反复查询远程机器，也不需要开发者编写自己的缓存代码。它还会更新列表中用户的 [presence](../online-subsystem-presence-interface/index.md) 状态数据。 `FOnReadFriendsListComplete` 返回的数据只包含 `ReadFriendsList` 操作成功或失败的信息。

### 检查好友列表

成功调用 `ReadFriendsList` 获取并缓存列表后，开发者可以使用 `GetFriendsList` 获取该列表本身的副本，或使用 `GetFriend` 从列表中获取单个好友。此外，可以将已知用户的 `FUniqueNetId` 传递给 `IsFriend` 函数，以检查指定列表中是否包含该用户。

> [!NOTE]
> 好友列表随时可能发生变化，变化可能来自游戏内事件，例如遇到新玩家，也可能来自游戏外事件，例如用户从另一个系统修改账号。应考虑调用 `ReadFriendsList` 以保持缓存列表为最新状态。

## 邀请好友

该 `SendInvite` 函数会向另一位用户发送邀请，该用户由其 `FUniqueNetId`。接受邀请后，在线服务会将该用户添加到指定列表。类型为 `FOnSendInviteComplete` 的委托会在此操作完成时调用，但这只表示邀请已发送（或发送失败），不表示预期接收者已经收到或回应。某些在线服务可能有用于发送邀请的自定义用户界面，当调用 `SendInvite` 时，这些界面可能会自动打开。

> [!NOTE]
> 所有 `SendInvite` 调用最终都会触发 `FOnSendInviteComplete` 委托。这包括外部 UI 打开后用户取消的情况。

### 接受或拒绝邀请

当来自其他用户的邀请到达时，会调用类型为 `FOnInviteReceivedDelegate` 的委托，其中包含发送者和接收者的 `FUniqueNetId` 。受邀用户随后可以调用 `AcceptInvite` 或 `RejectInvite` 进行回应，并指定新好友应出现在哪个列表中。 `AcceptInvite` 使用类型为 `FOnAcceptInviteComplete` 的委托传达操作结果，而 `RejectInvite` 使用 `FOnRejectInviteComplete` 委托。

### 删除好友列表

可以通过异步 `DeleteFriendsList` 函数。完成时，会调用类型为 `FOnDeleteFriendsListComplete` 的委托。

### 删除好友

要从本地用户所属列表中移除好友，请调用 `DeleteFriend` 函数。操作完成后，会调用类型为 `FOnDeleteFriendComplete` 的委托。在某些在线服务中，一个好友可能存在于多个列表；如果是这种情况，该函数只会从指定列表中移除该好友。

## 处理在线遇到的玩家

在线服务通常会单独保存用户最近遇到的玩家列表，例如在公共游戏会话中遇到、但尚未添加为好友或屏蔽的玩家。与好友列表一样，最近遇到的玩家列表通过查询在线服务并缓存列表来处理。

### 获取最近遇到的玩家列表

该 `QueryRecentPlayers` 会向在线服务发起异步调用，并在完成时调用类型为 `FOnQueryRecentPlayersComplete` 的委托。如果成功，Friends 接口会在本地缓存该列表。

### 检查最近遇到的玩家

一旦成功调用 `QueryRecentPlayers` 获取了最近遇到的玩家列表， `GetRecentPlayers` 函数会返回缓存数组。数组中的各个元素包含用户数据，以及用于说明该玩家最后在线时间的函数。

## 管理屏蔽列表

许多在线服务允许用户阻止特定其他用户通过该服务联系自己或与自己一起游戏。Friends 接口可以获取并缓存被屏蔽用户列表，也可以使用在线服务的屏蔽和取消屏蔽功能。

### 列出当前被屏蔽用户

要获取被屏蔽用户列表，请调用 `QueryBlockedPlayers` 函数。该函数是异步的，并会在完成时调用类型为 `FOnQueryBlockedPlayersComplete` 的委托。此外，对被屏蔽用户列表所做的任何更改都会通过 `FOnBlockListChange` 委托。

### 屏蔽和取消屏蔽用户

该 `BlockPlayer` 和 `UnblockPlayer` 函数会向在线服务发起异步调用，请求由 `FUniqueNetId`标识的特定玩家被本地玩家屏蔽或取消屏蔽。当这些操作完成时，会通过类型为 `FOnBlockedPlayerComplete` 和 `FOnUnblockedPlayerComplete`的委托返回成功或失败信息。

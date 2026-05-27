---
title: "Social Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/social-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Social Interface"]
---

# Social Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Social Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/social-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services Social 接口** 管理用户之间的关系，包括：

- 获取并查看玩家的好友列表。
- 发送好友邀请。
- 接受或拒绝好友邀请。
- 查看已屏蔽玩家列表。
- 屏蔽其他玩家。

## API 概述

### 函数

下表概述 Social 接口提供的函数：

| 函数 | 说明 |
| --- | --- |
| **查看** |  |
| [QueryFriends](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/QueryFriends?application_version=5.5) | 查询玩家好友列表。 |
| [GetFriends](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/GetFriends?application_version=5.5) | 获取由以下函数缓存的好友列表： `QueryFriends`. |
| **邀请** |  |
| [SendFriendInvite](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/SendFriendInvite?application_version=5.5) | 发送好友邀请。 |
| [AcceptFriendInvite](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/AcceptFriendInvite?application_version=5.5) | 接受好友邀请。 |
| [RejectFriendInvite](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/RejectFriendInvite?application_version=5.5) | 拒绝好友邀请。 |
| **屏蔽** |  |
| [QueryBlockedUsers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/QueryBlockedUsers?application_version=5.5) | 查询已屏蔽用户列表。 |
| [GetBlockedUsers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/GetBlockedUsers?application_version=5.5) | 获取由以下函数缓存的已屏蔽用户列表： `QueryBlockedUsers`. |
| [BlockUser](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/BlockUser?application_version=5.5) | 屏蔽指定用户。 |
| **事件监听** |  |
| [OnRelationshipUpdated](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISocial/OnRelationshipUpdated?application_version=5.5) | 好友列表更新时触发的事件。 |

### 主要结构体

Social 接口主要通过 [FFriend](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FFriend?application_version=5.5) 结构体，以及用于传递参数和返回值的函数专用结构体来传达其功能。

#### FFriend

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `FriendId` | `FAccountId` | 该好友的账号 ID。 |
| `DisplayName` | `FString` | 显示该好友名称。 |
| `Nickname` | `FString` | 该好友的本地昵称。可用性请查阅所用平台在线服务文档。 |
| `Relationship` | `ERelationship` | 与该好友的关系。 |

### 枚举类

该 [ERelationship](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__ERelationship?application_version=5.5) 枚举类保存本地用户与由 `FFriend` 结构体表示的在线用户之间的关系状态。

#### ERelationship

| 值 | 说明 |
| --- | --- |
| `好友` | 好友 |
| `NotFriend` | 不是好友 |
| `InviteSent` | 已向用户发送邀请。 |
| `InviteReceived` | 已收到来自用户的邀请。 |
| `Blocked` | 本地用户已屏蔽该用户。 |

## 流程

### 查看好友

游戏启动后，玩家会查看哪些好友在线。为此， `QueryFriends` 会通过 Social 接口缓存玩家好友列表，然后 `GetFriends` 获取先前缓存的好友列表用于读取。玩家现在可以查看好友列表，并决定是否邀请好友加入大厅并一起进入游戏会话。

### 邀请好友

与好友和其他在线玩家游玩后，玩家遇到了几名喜欢一起玩的其他玩家。玩家决定向其中两名在线玩家发送好友邀请。 `SendFriendInvite` 每次调用都会向提供的单个玩家发送好友邀请。其中一名在线玩家看到邀请并拒绝。游戏调用 `RejectFriendInvite` 来拒绝玩家的邀请。

与此同时，第二名在线玩家接受了邀请。调用 `AcceptFriendInvite` 会接受玩家邀请。好友接受会为发送邀请的玩家和接受邀请的在线玩家触发 `OnRelationshipUpdated` 事件。

### 屏蔽用户

与新好友游玩时，玩家遇到了另一名在线玩家。这次玩家决定以后不再与该在线玩家互动，于是屏蔽该玩家。玩家可以通过查询已屏蔽列表查看自己屏蔽过的在线玩家。 `QueryBlockedUsers` 会在接口中缓存信息，随后调用 `GetBlockedUsers` 获取已屏蔽玩家列表。如果目标在线玩家未出现在此列表中，则调用 `BlockUser` 会将该在线玩家添加到玩家的已屏蔽列表。

> [!NOTE]
> 根据平台不同，Invite 和 Block API 可能会弹出平台对话框来执行相关操作。更多信息请查阅特定平台文档。

## 从 Online Subsystem 转换代码

Online Services Social 接口负责此前由 [Online Subsystem](../../../online-subsystem/index.md) [Friends Interface](../../../online-subsystem/online-subsystem-friends-interface/index.md).

## 更多信息

### 头文件

如有需要，请直接查阅 `Social.h` 头文件以获取更多信息。Social 接口头文件 `Social.h` 位于目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

关于如何获取 UE 源代码，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 Online Services Overview 页面的 [函数](../../overview-of-online-services/index.md#functions) 章节，了解函数参数和返回类型，包括如何传递参数以及如何处理函数返回结果。

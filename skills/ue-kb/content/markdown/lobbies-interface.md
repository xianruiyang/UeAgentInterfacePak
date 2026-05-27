# Lobbies Interface

---
title: "Lobbies Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/lobbies-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Lobbies Interface"]
---

# Lobbies Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Lobbies Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/lobbies-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Online Services Lobbies Interface** 提供用于创建和管理 lobby 的 API。 **lobby** 是客户端应用上下文中的一组玩家，所有玩家都具有某些共享状态。这可能表示他们都在同一场在线比赛中游玩，也可能都在等待同一场比赛开始。lobby 及其成员都有用于共享此状态的 attribute。lobby attribute 或任一成员 attribute 的变化，会被所有已加入的 lobby 成员实时看到。

lobby leader 可以更改 lobby attribute，每个成员（包括 leader）都可以随时更改自己的 attribute。 **lobby schema** 会定义这些 attribute 及其类型和值约束，随后用于创建 lobby。lobby schema 在应用配置文件中定义，并在应用启动时验证。创建 lobby 不要求定义所有 attribute，但如果定义了未通过 schema 验证的 attribute，则 lobby 创建会失败。

Lobbies 的常见用途是在进入比赛前将玩家分组到一起。单个 lobby 的生命周期内可以进行多场游戏比赛。下面是一个 lobby 生命周期示例：

- 一名玩家使用所需隐私设置和 attribute 创建新 lobby。该玩家会被指定为 lobby leader。
- 其它玩家通过公共搜索、邀请或 social presence 找到并加入 lobby。
- 玩家通过 attribute update 在 lobby 内共享 attribute。
- 当 lobby 选择进行一场比赛时，lobby leader 会将 match session ID 记录为 lobby attribute。
- 其它 lobby 成员看到此 session ID 后加入同一个 game session。
- 在多场游戏比赛的生命周期中，玩家可以加入或离开该 lobby。

## API 概述

### 函数

下表概要说明 Lobbies Interface 提供的函数：

| 函数 | 说明 |
| --- | --- |
| **操作** |  |
| [CreateLobby](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/CreateLobby?application_version=5.5) | 创建并加入新 lobby。 |
| [FindLobbies](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/FindLobbies?application_version=5.5) | 搜索符合给定参数的 lobby。 |
| [RestoreLobbies](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/RestoreLobbies?application_version=5.5) | 尝试重新加入之前加入过的 lobby。 |
| [JoinLobby](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/JoinLobby?application_version=5.5) | 使用给定 lobby ID 加入 lobby。 |
| [LeaveLobby](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/LeaveLobby?application_version=5.5) | 离开已加入的 lobby。 |
| [InviteLobbyMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/InviteLobbyMember?application_version=5.5) | 邀请玩家加入 lobby。 |
| [DeclineLobbyInvitation](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/DeclineLobbyInvitation?application_version=5.5) | 拒绝加入 lobby 的邀请。 |
| [KickLobbyMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/KickLobbyMember?application_version=5.5) | 将某个成员从目标 lobby 踢出。 |
| [PromoteLobbyMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/PromoteLobbyMember?application_version=5.5) | 将另一名 lobby member 提升为 leader。调用 `PromoteLobbyMember` 的本地玩家必须是当前 lobby leader，才能提升其它成员。 |
| **变更操作** |  |
| [ModifyLobbySchema](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/ModifyLobbySchema?application_version=5.5) | 更改应用到 lobby 和成员 attribute 的 schema。只有 lobby leader 可以更改 schema。新 schema 中不存在的现有 attribute 会被清除。 |
| [ModifyLobbyJoinPolicy](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/ModifyLobbyJoinPolicy?application_version=5.5) | 更改应用到 lobby 的 join policy。只有 lobby leader 可以更改 join policy。 |
| [ModifyLobbyAttributes](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/ModifyLobbyAttributes?application_version=5.5) | 更改应用到 lobby 的 attribute。只有 lobby leader 可以更改 lobby attribute。更新成功前，attribute 会根据 lobby schema 验证。 |
| [ModifyLobbyMemberAttributes](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/ModifyLobbyMemberAttributes?application_version=5.5) | 更改应用到 lobby member 的 attribute。lobby member 只能更改自己的 attribute。更新成功前，attribute 会根据 lobby schema 验证。 |
| **访问器** |  |
| [GetJoinedLobbies](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/GetJoinedLobbies?application_version=5.5) | 获取目标本地玩家已加入的 lobby 列表。 |
| [GetReceivedInvitations](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/GetReceivedInvitations?application_version=5.5) | 获取目标本地玩家收到的邀请列表。 |
| **事件监听** |  |
| [OnLobbyJoined](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyJoined?application_version=5.5) | 玩家加入 lobby 时触发的事件。 |
| [OnLobbyLeft](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyLeft?application_version=5.5) | 所有本地成员离开 lobby 时触发的事件。 |
| [OnLobbyMemberJoined](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyMemberJoined?application_version=5.5) | lobby member 加入时触发的事件，可能由本地玩家创建/加入 lobby 导致，也可能由远程玩家加入导致。 |
| [OnLobbyMemberLeft](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyMemberLeft?application_version=5.5) | lobby member 离开已加入的 lobby 时触发的事件。 |
| [OnLobbyLeaderChanged（leader 变化）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyLeaderChanged?application_version=5.5) | lobby leadership 发生变化时触发的事件。 |
| [OnLobbySchemaChanged（schema 变化）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbySchemaChanged?application_version=5.5) | lobby attribute schema 发生变化时触发的事件。 |
| [OnLobbyAttributesChanged（lobby attribute 变化）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyAttributesChanged?application_version=5.5) | lobby attribute 发生变化时触发的事件。 |
| [OnLobbyMemberAttributesChanged（成员 attribute 变化）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyMemberAtt-?application_version=5.5) | lobby member 的 attribute 发生变化时触发的事件。 |
| [OnLobbyInvitationAdded（收到邀请）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyInvitationAdded?application_version=5.5) | lobby member 收到邀请时触发的事件。 |
| [OnLobbyInvitationRemoved（邀请移除）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnLobbyInvitationRemoved?application_version=5.5) | lobby member 处理邀请或邀请过期时触发的事件。 |
| [OnUILobbyJoinRequested](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILobbies/OnUILobbyJoinRequested?application_version=5.5) | 玩家通过外部机制请求加入 lobby 时触发的事件。 |

### 枚举类

Lobbies Interface 通过两个枚举类表示 Lobby Join Policy 和 Lobby Member Leave Reason： [ELobbyJoinPolicy（lobby 加入策略）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__ELobbyJoinPolicy?application_version=5.5) and [ELobbyMemberLeaveReason（lobby member 离开原因）](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__ELobbyMemberLeaveRea-?application_version=5.5).

#### ELobbyJoinPolicy（lobby 加入策略）

| 枚举值 | 说明 |
| --- | --- |
| `PublicAdvertised` | 用户可以通过基于 attribute 匹配、lobby ID 或邀请的搜索找到 lobby。 |
| `PublicNotAdvertised` | 用户可以通过 lobby ID 或邀请加入 lobby。 |
| `InvitationOnly` | 用户只能通过邀请加入 lobby。 |

#### ELobbyMemberLeaveReason（lobby member 离开原因）

| 枚举值 | 说明 |
| --- | --- |
| `Left` | lobby member 选择离开 lobby。 |
| `Kicked` | lobby member 被 lobby owner 踢出 lobby。 |
| `Disconnected` | lobby member 意外离开。 |
| `Closed` | lobby 被 online services 销毁，所有成员均已离开。 |

### 主要结构体

Lobby Interface 功能主要通过两个结构体传递： [FLobbyMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FLobbyMember?application_version=5.5) and [FLobby](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreOnline/Online/FLobby?application_version=5.5)，此外还有用于传递参数和返回值的函数专用结构体。

#### FLobbyMember

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AccountId` | `FAccountId` | 此 lobby member 的 Account ID。 |
| `PlatfromAccountId` | `FAccountId` | 此 lobby member 的 platform account ID。 |
| `PlatfromDisplayName` | `FString` | 此 lobby member 的 platform display name。 |
| `Attributes` | `TMap<FSchemaAttributeId, FSchemaVariant>` | 配置中定义的此 lobby member 的 attribute。 |
| `bIsLocalMember` | `bool` | 此 lobby member 是否为此客户端上的本地玩家。 (Default value is `false`.) |

#### FLobby

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `LobbyId` | `FLobbyId` | 此 lobby 的 ID。 |
| `OwnerAccountId` | `FAccountId` | 当前拥有此 lobby 的 lobby member 的 Account ID。 |
| `LocalName` | `FName` | 此 lobby 的本地名称。 |
| `SchemaId` | `FSchemaId` | 应用到此 lobby 的 schema ID。 |
| `MaxMembers` | `int32` | 任意时刻可存在于此 lobby 中的最大成员数量。 |
| `JoinPolicy` | `ELobbyJoinPolicy` | 此 lobby 的 join policy 设置。 |
| `Attributes` | `TMap<FSchemaAttributeId, FSchemaVariant>` | 配置中定义的此 lobby attribute。 |
| `Members` | `TMap<FAccountId, TSharedRef<const FLobbyMember>>` | lobby member 字典，其中 key 为 account ID，value 为对应 lobby member 结构体指针。 |

## 配置

Lobbies 使用 schema system 定义 lobby 的结构和属性，以及 lobby member attribute。 游戏可以声明多个单独的 schema definition，以支持多种不同类型的 lobby。 所有 lobby schema 都必须派生自 `LobbyBase` schema.

The `LobbyBase` schema 包含玩家可用于搜索 lobby 的所有 attribute。 此继承结构意味着 Lobbies interface 知道应将哪个游戏提供的 schema 应用到搜索结果。 `SchemaCompatibilityId` 是 `LobbyBase` 中的特殊 attribute，用于确保两个客户端之间的 schema 兼容。

游戏必须为 schema definition 中存在的每个 schema attribute 声明 definition。 Schema 定义在项目配置文件（`*.ini`）文件中。 这些 definition 包含 attribute 的类型、最大大小和可见性，以及该 attribute 是否可用作搜索参数等附加行为。

通常，schema 包含用于容纳 attribute definition 的 category。 Lobbies interface schema 有两个 category： `Lobby` and `LobbyMember`. 这些 category 分别包含应用到 lobby object 和 lobby member object 的 attribute definition。

### 示例

以下是 Lobbies interface 的配置示例：

C++

DefaultEngine.ini

```
[OnlineServices.Lobbies]
+SchemaDescriptors=(Id="GameLobby", ParentId="LobbyBase")

!SchemaCategoryAttributeDescriptors=ClearArray
+SchemaCategoryAttributeDescriptors=(SchemaId="LobbyBase", CategoryId="Lobby", AttributeIds=("SchemaCompatibilityId", "ExampleSearchableLobbyAttribute"))
+SchemaCategoryAttributeDescriptors=(SchemaId="LobbyBase", CategoryId="LobbyMember")

+SchemaCategoryAttributeDescriptors=(SchemaId="GameLobby", CategoryId="Lobby", AttributeIds=("GameMode", "GameSessionId", "MapName", "MatchTimeout"))
+SchemaCategoryAttributeDescriptors=(SchemaId="GameLobby", CategoryId="LobbyMember", AttributeIds=("Appearance"))
```

## 流程

### 创建

玩家发起 lobby 创建，lobby 创建后该玩家会被指定为 lobby leader。创建玩家决定初始 lobby 设置。这些设置可以包括：

- Visibility（可见性）
- Join Policy（加入策略）
- Schema ID
- Lobby Attributes（lobby 属性）
- Lobby Member Attributes（lobby member 属性）

其它玩家在搜索 lobby 时可以看到 public attribute。lobby leader 拥有额外权限，详见本页 [Leader Actions](index.md#leader-actions) 部分。所有 lobby member（包括 leader）都可以更改个人 attribute 或邀请玩家加入 lobby。这些操作汇总在 [Member Actions](index.md#member-actions) 部分。

lobby 创建成功后，创建玩家会收到 `OnLobbyJoined` 事件，随后收到 `OnLobbyMemberJoined` ，因为他们现在是指定的 lobby leader。 只要该玩家仍被指定为 lobby leader，就会在玩家加入和离开 lobby 时收到额外 `OnLobbyMemberJoined` and `OnLobbyMemberLeft` 事件。

### 查找

要加入 lobby，玩家首先需要知道 lobby ID。玩家可以通过以下方式找到 ID：

- 搜索
- 邀请

搜索和邀请都会向客户端应用提供 lobby data 快照。快照中的 attribute 在玩家加入 lobby 之前不会更新。

#### 搜索

Lobby search 允许玩家指定 attribute，以查找符合所需配置的 lobby。玩家可以按以下方式搜索 lobby：

- Attribute filter
- Target player（目标玩家）
- Specific lobby ID（指定 lobby ID）

#### 邀请

根据 lobby 隐私设置，lobby member 可以邀请其它玩家加入 lobby。 发送邀请后，目标玩家会收到 `OnLobbyInvitationAdded` 事件，通知其有待处理邀请。 The `OnLobbyInvitationRemoved` 事件会在邀请被处理或过期时触发。

#### Social Presence

某些 online service 实现允许玩家通过社交用户界面加入好友的 lobby，例如 [Online Services Presence Interface](../presence-interface/index.md). 当玩家选择以这种方式加入时， `OnUILobbyJoinRequested` 事件会触发应用，以表示玩家想要加入 lobby。

### 加入

玩家知道想加入的 lobby ID 后，调用 `JoinLobby` 即可开始添加本地玩家的流程。 本地玩家必须提供初始 `LobbyMember` attribute，这些 attribute 会在加入 lobby 时与其它现有 lobby member 共享。

成功加入 lobby 后，玩家会收到 `OnLobbyJoined` event. lobby 的每个现有成员都会收到 `OnLobbyMemberJoined` 事件，通知他们有新玩家加入。 玩家留在此 lobby 期间，会在其它玩家加入或离开 lobby 时收到额外 `OnLobbyMemberJoined` and `OnLobbyMemberLeft` 事件。

### 离开

当玩家不再希望留在 lobby 中时， `LeaveLobby` 会使用提供的 lobby ID 将玩家从 lobby 中移除，并停止通知。 玩家离开 lobby 后，lobby 中所有其它玩家都会收到 `OnLobbyMemberLeft` 通知，告知他们有玩家离开 lobby。 这些通知之后会向已离开 lobby 的玩家发送 `OnLobbyLeft` 事件。

### 恢复

`RestoreLobbies` 会恢复调用玩家之前加入过的所有 lobby。 游戏通常会在应用启动时执行此操作，使本地玩家重新加入应用上次退出时所在的 lobby。

## Leader Actions

lobby leader 拥有额外的专属权限，可用于维护 lobby。

### 提升成员

lobby leader 可以调用以下函数将另一名 lobby member 提升为 leader： `PromoteLobbyMember`. 此操作会触发 `OnLobbyLeaderChanged` 事件并发送给所有 lobby member。 之前的 leader 会变为普通 lobby member。

### 踢出成员

lobby leader 可以调用以下函数将目标成员从 lobby 中移除： `KickLobbyMember`. 此操作会触发 `OnLobbyLeft` 事件给被踢出的 lobby member，并触发 `OnLobbyMemberLeft` 事件给所有其它 lobby member。

### 更新 Lobby Attribute

lobby leader 可以更改 lobby object 的 attribute。 这通过调用以下函数处理： `ModifyLobbyAttributes`. 当 lobby attribute 变化时，所有 lobby member 都会收到 `OnLobbyAttributesChanged` 事件，通知其 attribute 已变化。

### 更改 Lobby Join Policy

lobby 的 join policy 会影响 lobby 是否出现在搜索结果中、是否仅限邀请加入，或是否可以通过 social presence 加入。 lobby leader 可以调用以下函数更改此设置： `ModifyLobbyJoinPolicy`.

## Member Actions

lobby member 仅限执行两种操作：更新自己的 attribute，以及邀请其它成员加入 lobby。

### 更改成员 Attribute

lobby member 可以调用以下函数更改自己的 attribute： `ModifyLobbyMemberAttributes`. An `OnLobbyMemberAttributesChanged` 事件会通知其它 lobby member 此变化。

### 邀请玩家加入 Lobby

如果当前 lobby join policy 允许邀请，lobby member 可以调用以下函数邀请其它玩家： `InviteLobbyMember`. 邀请目标会收到 `OnLobbyInvitationAdded` 事件，通知其存在待处理邀请。 受邀玩家可以调用以下函数选择加入 lobby： `JoinLobby` 或使用以下函数拒绝邀请： `DeclineLobbyInvitation`.

## 从 Online Subsystem 转换代码

Lobbies 是 Online Services 的新接口，在 **Online Subsystem**.

## 更多信息

### 头文件

可根据需要直接查阅 `Lobbies.h` 头文件以获取更多信息。 Lobbies Interface 头文件 `Lobbies.h` 位于以下目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

有关如何获取 UE 源码的说明，请参阅文档： [下载虚幻引擎源码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 Online Services Overview 页面的 [函数](../../overview-of-online-services/index.md#functions) 部分，了解函数参数和返回类型，包括如何传递参数，以及函数返回时如何处理结果。


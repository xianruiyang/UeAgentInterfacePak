---
title: "Online Services Presence Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/presence-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Online Services Presence Interface"]
---

# Online Services Presence Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Online Services Presence Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/presence-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

登录在线服务后，你可能希望查找好友以及在线遇到的其他用户的信息。例如，在许多在线服务中，可以查看其他用户是否在线、当前正在玩什么游戏、是否可加入比赛等。 **Online Services Presence 接口** 涵盖在线服务中与平台特定用户状态有关的全部功能，包括查询和更新用户 presence，以及监听变更。

本文提供 API 概述、代码示例，以及从 [Online Subsystem Presence 接口](../../../online-subsystem/online-subsystem-presence-interface/index.md).

## API 概述

### 函数

下表概述 Presence 接口包含的函数。

| 函数 | 说明 |
| --- | --- |
| **查询** |  |
| [QueryPresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/QueryPresence?application_version=5.5) | 获取具有所提供 `TargetAccountId`. |
| [BatchQueryPresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/BatchQueryPresence?application_version=5.5) | 获取所提供列表中每个用户的 presence，列表类型为 `TargetAccountIds`. |
| **获取** |  |
| [GetCachedPresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/GetCachedPresence?application_version=5.5) | 获取具有所提供 `TargetAccountId` 并缓存在接口中的用户 presence。 |
| **更新** |  |
| [UpdatePresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/UpdatePresence?application_version=5.5) | 更新用户的 presence。 |
| [PartialUpdatePresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/PartialUpdatePresence?application_version=5.5) | 仅使用指定的 presence 设置更新用户的 presence。 |
| **事件监听** |  |
| [OnPresenceUpdated](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IPresence/OnPresenceUpdated?application_version=5.5) | 当用户 presence 更新时会触发事件。 |

### 枚举类

Presence 接口定义了三个枚举类，分别表示用户状态（[EUserPresenceStatus](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__EUserPresenceStatus?application_version=5.5)）、可加入性（[EUserPresenceJoinability](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__EUserPresenceJoinabi-?application_version=5.5)）和游戏状态（[EUserPresenceGameStatus](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__EUserPresenceGameSta-?application_version=5.5)）。这些枚举类表示 `FUserPresence` 结构体中的三个主要成员。更多信息请参阅 [主要结构体](index.md) 章节，该章节位于本页。

#### EUserPresenceStatus

| 枚举值 | 说明 |
| --- | --- |
| `Offline` | 用户离线。 |
| `Online` | 用户在线。 |
| `Away` | 用户离开。 |
| `ExtendedAway` | 用户已离开至少两小时（可能取决于平台）。 |
| `DoNotDisturb` | 用户不想被打扰。 |
| `Unknown` | 默认用户 presence 状态。 |

#### EUserPresenceJoinability

| 枚举值 | 说明 |
| --- | --- |
| `Public` | 任何人都可以发现并加入此会话。 |
| `FriendsOnly` | 尝试加入的人必须是某个大厅成员的好友。 |
| `InviteOnly` | 尝试加入的人必须先获得邀请。 |
| `Private` | 用户当前不接受邀请。 |
| `Unknown` | 默认用户 presence 可加入状态。 |

#### EUserPresenceGameStatus

| 枚举值 | 说明 |
| --- | --- |
| `PlayingThisGame` | 用户正在玩与你相同的游戏。 |
| `PlayingOtherGame` | 用户正在玩与你不同的游戏。 |
| `Unknown` | 默认用户 presence 游戏状态。 |

### 主要结构体

#### FUserPresence

该 [FUserPresence](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FUserPresence?application_version=5.5) 结构体是 Presence 接口中的主要对象，包含与用户 presence 有关的所有必要信息。

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AccountId` | `FAccountId` | 该 presence 所属的用户。 |
| `Status` | `EUserPresenceStatus` | 用户 presence 状态。（默认值为 `EUserPresenceStatus::Unknown`.) |
| `Joinability` | `EUserPresenceJoinability` | 用户会话状态。（默认值为 `EUserPresenceJoinability::Unknown`.) |
| `GameStatus` | `EUserPresenceGameStatus` | 用户游戏状态。（默认值为 `EUserPresenceGameStatus::Unknown`.) |
| `StatusString` | `FString` | 用户 presence 状态的字符串表示。 |
| `RichPresenceString` | `FString` | 当前游戏状态的游戏定义表示。 |
| `Properties` | `FPresenceProperties` | 会话键。 |

> [!NOTE]
> 类型 `FPresenceProperties` 是以下类型的 typedef： `TMap<FString, FPresenceVariant>` 其中 `FPresenceVariant` 是一个 `FString`.

## 示例

下面提供一个示例，演示 `UpdatePresence`, `QueryPresence`和 `GetPresence`. `UserA` 如何使用默认平台服务更新其 presence，然后 `UserB` 查询 `UserA` 更新后的 presence。如果查询成功返回，则 `UserB` 获取 `UserA`.

### 代码

C++

UserAPresence.cpp

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::IPresencePtr PresenceInterface = OnlineServices->GetPresenceInterface();

TSharedRef<UE::Online::FUserPresence> Presence = MakeShared<UE::Online::FUserPresence>();
Presence->AccountId = UserA;
Presence->Status = UE::Online::EUserPresenceStatus::Online;
Presence->Joinability = UE::Online::EUserPresenceJoinability::Public;
Presence->RichPresenceString = TEXT("Exploring the Great Citadel");
Presence->Properties.Add(TEXT("advanced_class"), TEXT("advanced_class_assassin"));
```

C++

UserBPresence.cpp

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::IPresencePtr PresenceInterface = OnlineServices->GetPresenceInterface();

PresenceInterface->QueryPresence({UserA})
.OnComplete([](const UE::Online::TOnlineResult<UE::Online::FQueryPresence> Result)
{
	if(Result.IsOk())
	{
		// we succeeded - now use GetPresence to actually view the presence object
```

### 演练

1. 两个用户都通过调用以下内容获取默认在线服务： `GetServices` 且不指定任何参数，并访问 Presence 接口：

   C++

   UserAPresence.cpp and UserBPresence.cpp

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices(); UE::Online::IPresencePtr PresenceInterface = OnlineServices->GetPresenceInterface();
   ```
2. `UserA` 初始化一个 `FUserPresence` 结构体，命名为 `Presence`。注意，这里使用了前面提到的 Presence 接口提供的两个枚举： `EUserPresenceStatus` and `EUserPresenceJoinability`.

   C++

   UserAPresence.cpp

   ```
   TSharedRef<UE::Online::FUserPresence> Presence = MakeShared<UE::Online::FUserPresence>(); Presence->AccountId = UserA; Presence->Status = UE::Online::EUserPresenceStatus::Online; Presence->Joinability = UE::Online::EUserPresenceJoinability::Public; Presence->RichPresenceString = TEXT("Exploring the Great Citadel"); Presence->Properties.Add(TEXT("advanced_class"), TEXT("advanced_class_assassin"));
   ```
3. `UserA` 初始化一个 `FUpdatePresence::Params` 结构体，命名为 `Params` 以及将传递给 `UpdatePresence`:

   C++

   UserAPresence.cpp

   ```
   UE::Online::FUpdatePresence::Params Params; Params.LocalAccountId = AccountId; Params.Presence = Presence;
   ```
4. `UserA` 调用 `UpdatePresence` ，并使用 `OnComplete` 回调处理结果：

   C++

   UserAPresence.cpp

   ```
   PresenceInterface->UpdatePresence(MoveTemp(Params))
    .OnComplete([](const UE::Online::TOnlineResult<UE::Online::FUpdatePresence> Result)
    {
        if(Result.IsOk())
        {
            // we succeeded - UserB is now clear to query presence
        }
        else
        {
            // we failed - check the error state in Result.GetErrorValue();
   ```
5. `UserB` 查询 `UserA`。在这些查询的 `OnComplete` 回调中， `UserB` 首先检查以确保 `QueryPresence` 返回“Ok”状态。如果是，则 `UserB` 可以安全地获取 `UserA` 的 presence，并处理 `GetPresence` 的结果或错误：

   C++

   UserBPresence.cpp

   ```
   PresenceInterface->QueryPresence({UserA})
    .OnComplete([](const UE::Online::TOnlineResult<UE::Online::FQueryPresence> Result)
    {
        if(Result.IsOk())
        {
            // we succeeded - now use GetPresence to actually view the presence object

            UE::Online::TOnlineResult<UE::Online::FGetPresence> GetPresenceResult = PresenceInterface->GetPresence({UserB});
            if(GetPresenceResult.IsOk())
            {
   ```

如果所有函数调用均无错误返回， `UserB` 现在会看到 `UserA` and `UserB` 的更新状态，并可以基于此状态做出决策。例如， `UserB` 可以访问 `GetPresenceResult` 以查看 `UserA` 是否在线，以及其可加入状态是否为 public。设置此状态后， `UserB` 可以决定加入 `UserA` 并一起“Explore the Great Citadel”。

## 从 Online Subsystem 转换代码

该 [Online Services](../../index.md) 插件是 [Online Subsystem](../../../online-subsystem/index.md) 插件的更新版本，并会在可预见的未来与其并存。Online Services Presence 接口的 API 功能与 Online Subsystem Presence 接口的 API 功能大致一一对应。需要注意的事项包括：

- `SetPresence` 已重命名为 `UpdatePresence` ，以更好表示该函数的异步性。
- `UpdatePresence` and `QueryPresence` 不再重载。
- 建议改用其重命名后的函数 `PartialUpdatePresence` and `BatchQueryPresence` 。

  - 的重载已分别重命名为 `UpdatePresence` and `QueryPresence` 。 `PartialUpdatePresence` and `BatchQueryPresence`。
- `QueryPresence` 添加了 `bListenToChanges` 参数。

  - 这会将特定用户添加到 `OnPresenceUpdated` 事件。
  - 该参数默认设置为 true。

## 更多信息

### 头文件

可按需直接查看 `Presence.h` 头文件以获取更多信息。Presence 接口头文件 `Presence.h` 位于以下目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

关于如何获取 UE 源代码的说明，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 [函数](../../overview-of-online-services/index.md#functions) 章节，该章节位于 Online Services Overview 页面，其中解释了函数参数和返回类型，包括如何传递参数以及函数返回时如何处理结果。

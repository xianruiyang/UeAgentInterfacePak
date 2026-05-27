---
title: "Sessions Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sessions-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Sessions Interface"]
---

# Sessions Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Sessions Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sessions-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services Session Interface** 负责在线游戏会话的创建、销毁和管理。 **session** 表示游戏中的一场在线比赛，可运行在玩家机器或专用服务器上。Session 可以使用以下加入策略：

- **仅限邀请**：收到邀请的玩家可以加入该 session。
- **仅限好友**：任意 session 成员的好友可以加入该 session。
- **公开**：任何人都可以查找并加入该 session。

可以使用一组充当筛选条件的属性来定义公开 session，让玩家搜索特定游戏模式或地图。

## API 概述

下表概括说明 Sessions Interface 中包含的函数。

| 函数 | 说明 |
| --- | --- |
| **获取 Session** |  |
| [GetAllSessions](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetAllSessions?application_version=5.5) | 检索用户参与的所有 session 引用数组。 |
| [GetSessionByName](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetSessionByName?application_version=5.5) | 检索具有给定名称的 session 引用。 |
| [GetSessionById](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetSessionById?application_version=5.5) | 检索具有给定 ID handle 的 session 引用。 |
| **Presence** |  |
| [GetPresenceSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetPresenceSession?application_version=5.5) | 检索当前设置为用户 presence session 的 session 引用。 |
| [IsPresenceSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/IsPresenceSession?application_version=5.5) | 判断给定 ID 的 session 是否已设置为用户的 presence session。 |
| [SetPresenceSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/SetPresenceSession?application_version=5.5) | 将给定 ID 的 session 设置为用户的 presence session。 |
| [ClearPresenceSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/ClearPresenceSession?application_version=5.5) | 清除用户的 presence session。 |
| **Session 管理** |  |
| [CreateSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/CreateSession?application_version=5.5) | 使用给定参数创建新 session。 |
| [UpdateSessionSettings](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/UpdateSessionSettings?application_version=5.5) | 更新由给定名称标识的 session 设置。 |
| [LeaveSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/LeaveSession?application_version=5.5) | 离开由给定名称标识的 session，并可选择销毁它。 |
| [FindSessions](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/FindSessions?application_version=5.5) | 向 session 服务查询匹配给定参数的 session。 |
| [JoinSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/JoinSession?application_version=5.5) | 加入给定 session ID 对应的 session。 |
| [StartMatchmaking](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/StartMatchmaking?application_version=5.5) | 启动匹配流程。该流程会搜索并加入匹配给定搜索筛选条件的 session；如果找不到这样的 session，则使用给定参数创建一个 session。 |
| [AddSessionMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/AddSessionMember?application_version=5.5) | 将该用户作为新的 session 成员添加到给定名称标识的 session。 |
| [RemoveSessionMember](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/RemoveSessionMember?application_version=5.5) | 从给定名称标识的 session 中移除该用户。 |
| **邀请** |  |
| [SendSessionInvite](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/SendSessionInvite?application_version=5.5) | 向所有给定用户发送邀请，让他们加入由给定名称标识的 session。 |
| [GetSessionInviteById](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetSessionInviteById?application_version=5.5) | 获取由给定邀请 ID 标识的 session 邀请引用。 |
| [GetAllSessionInvites](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/GetAllSessionInvites?application_version=5.5) | 获取该用户已收到的所有 session 邀请引用数组。 |
| [RejectSessionInvite](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/RejectSessionInvite?application_version=5.5) | 拒绝由给定邀请 ID 标识的 session 邀请。 |
| **事件监听** | 事件会因以下情况触发： |
| [OnSessionJoined](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/OnSessionJoined?application_version=5.5) | 加入 session。 |
| [OnSessionLeft](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/OnSessionLeft?application_version=5.5) | 离开或销毁 session。 |
| [OnSessionUpdated](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/OnSessionUpdated?application_version=5.5) | 更新 session 设置，或收到 session 更新事件。 |
| [OnSessionInviteReceived](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/OnSessionInviteReceived?application_version=5.5) | 收到 session 邀请。 |
| [OnUISessionJoinRequested](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ISessions/OnUISessionJoinRequested?application_version=5.5) | 接受 session 邀请，或通过平台 UI 加入 session。 |

## 流程

### Session 生命周期

- 使用所需设置创建新 session。
- 在 session 生命周期中的任意时间，都可以更新 session，以反映它所代表的在线比赛属性变化。这些变化可以包括：

  - 修改 session 在搜索中如何显示，或是否显示的相关参数。
  - 游戏进行后限制新玩家加入 session。
- 发现该 session 的玩家可以加入它。
- 新玩家可以使用加入 session 后获得的信息，连接到 session 主机或专用服务器。

  - 连接后，玩家需要注册到 session。此流程会在未来版本中由引擎自动处理。
- 游玩游戏。
- 游戏结束后，玩家可以离开 session；如果该玩家是所有者或主机，也可以销毁 session。
- 从主机或服务器断开后，还需要从 session 中注销一个或多个玩家。此流程会在未来版本中由引擎自动处理。

#### 创建

session 生命周期的第一步，是使用所需参数创建 session。 这些参数中有些会在 session 整个生命周期内保持不变 (like `bIsLANSession` and `bAllowSanctionedPlayers` from the `CreateSession` function) 另一些则可以随时更新 (例如函数提供的选项 `SessionSettings`).

每个用户最多只能将一个 session 设置为 **Presence Session**. 这意味着它会出现在用户的 Presence 信息中，并通过 Presence Interface 暴露给好友和关注者。 如果用户是多个 session 的成员，可以通过以下函数更改哪个 session 显示为 presence session： `SetPresenceSession` (此功能可能并非所有平台实现都可用).

#### 发现

用户可以通过几种不同方式发现新的 session：

##### 搜索

`FindSessions` 允许用户定义搜索参数，例如匹配目标 session 自定义设置的标签，或用于查找好友所在 session 的特定用户 ID. 这会返回 session ID 列表，每个 ID 表示缓存的 session 信息, 用户可以用以下函数搜索并访问这些信息： `GetSessionById`.

##### 邀请

用户可以接收其他用户发送的 session 邀请。 收到邀请后，用户可以通过以下函数访问邀请来查看该 session 的信息： `GetSessionInviteById`. 之后，用户决定是否使用邀请信息提供的 session ID 加入该 session.

##### Presence

特定平台 UI 可能会向用户显示好友已加入的 session 信息。

#### 加入

一旦用户通过搜索、邀请或 presence 获得 session 信息, 就可以调用以下函数尝试加入它： `JoinSession`. 也可以选择是否使用以下函数将这个新 session 设置为自己的 presence session： `SetPresenceSession`.

##### 匹配

加入 session 的另一种方式是调用 `StartMatchmaking`. 该函数相当于结合了 `CreateSession` and `FindSessions`. `StartMatchmaking` 会查找匹配预定义搜索筛选条件的 session 如果没有找到，则使用给定信息创建一个 session。

加入 session 后，可以调用 `IOnlineServices::GetResolvedConnectString`, 它会返回加入比赛所需的平台特定连接信息。 随后可以将该函数取得的字符串传给 `APlayerController::ClientTravel` 或 `UWorld::ServerTravel`，将玩家送入比赛。 如果 travel 成功，玩家会被添加到 session，并调用 `AddSessionMember` 会被调用，以将玩家注册到 session。

##### 邀请他人

通过创建或加入方式进入 session 后, 可以使用以下函数将 session 信息发送给其他玩家： `SendSessionInvite`. 这是让好友聚到同一场在线比赛中的好方法. 玩家收到邀请后，可以使用以下函数访问邀请信息： `GetAllSessionInvites` 访问给定用户的所有邀请，或使用 `GetSessionInviteById` 获取特定邀请的信息。 也可以调用以下函数拒绝 session 邀请： `RejectSessionInvite` 并传入相应邀请 ID 作为参数.

#### 更新

可以在 session 生命周期中的任意时间调用以下函数更新 session 设置： `UpdateSessionSettings`. 这些设置包括但不限于：

- session 中的最大玩家数量
- session 的加入策略：

  - 仅限邀请
  - 仅限好友
  - 公开
- 限制新玩家访问
- 添加、修改或移除自定义设置和用户定义参数

#### 离开与销毁

You can leave a session by calling `LeaveSession`. session 所有者可以将附加参数 `bDestroySession` to `true` 从而在离开时将该 session 从后端服务移除。 这也会强制 session 中的所有其他成员离开。

## 示例

可以通过 OnlineServices 实例引用访问 Sessions Interface，并从这里使用 Sessions Interface 的功能。下面提供几个示例，展示如何访问 Sessions Interface 并执行同步和异步操作。

### 按名称获取 Session

C++

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::ISessionsPtr SessionsInterface = OnlineServices->GetSessionsInterface();
UE::Online::FGetSessionByName::Params Params;
Params.SessionName = FName(TEXT("MySession"));

UE::Online::TOnlineResult<UE::Online::FGetSessionByName> Result = SessionsInterface->GetSessionByName(MoveTemp(Params));
if(Result.IsOk())
{
	TSharedRef<const UE::Online::ISession> Session = Result.GetOkValue().Session;
	// now we can read information from the session
```

#### 步骤说明

1. 调用以下函数使用默认在线服务： `GetServices` 不指定参数:

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
   ```
2. 访问默认在线服务的 Sessions interface：

   C++

   ```
   UE::Online::ISessionsPtr SessionsInterface = OnlineServices->GetSessionsInterface();
   ```
3. 初始化 `FGetSessionByName` 结构体，并填入调用 `GetSessionByName` 所需的参数：

   C++

   ```
   UE::Online::FGetSessionByName::Params Params;     Params.SessionName = FName(TEXT("MySession"));
   ```
4. 调用 `GetSessionByName`，传入上一步的参数并保存结果：

   C++

   ```
   UE::Online::TOnlineResult<UE::Online::FGetSessionByName> Result = SessionsInterface->GetSessionByName(MoveTemp(Params));
   ```
5. 处理对以下函数调用的结果： `GetSessionByName` 在确认函数调用未抛出错误且结果可访问后进行处理:

   C++

   ```
   if(Result.IsOk())     {         TSharedRef<const UE::Online::ISession> Session = Result.GetOkValue().Session;         // now we can read information from the session     }
   ```

### 更新 Session 设置

C++

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::ISessionsPtr SessionsInterface = OnlineServices->GetSessionsInterface();

UE::Online::FUpdateSessionSettings::Params Params;
Params.LocalAccountId = AccountId;
Params.SessionName = FName(TEXT("MySession"));
Params.Mutations.bAllowNewMembers = false;

SessionsInterface->UpdateSessionSettings(MoveTemp(Params))
.OnComplete([this](const UE::Online::TOnlineResult<UE::Online::FUpdateSessionSettings>& Result)
```

#### 步骤说明

1. 调用以下函数使用默认在线服务： `GetServices` 不指定参数 并访问默认在线服务的 Sessions interface:

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();     UE::Online::ISessionsPtr SessionsInterface = OnlineServices->GetSessionsInterface();
   ```
2. 使用必要参数初始化结构体，以调用 `UpdateSessionSettings`:

   C++

   ```
   UE::Online::FUpdateSessionSettings::Params Params;     Params.LocalAccountId = AccountId;     Params.SessionName = FName(TEXT("MySession"));     Params.Mutations.bAllowNewMembers = false;
   ```
3. 处理 `UpdateSessionSettings.OnComplete` 回调：如果返回错误，则处理错误或查询到的状态；如果返回正常，则用 lambda 函数处理结果：

   C++

   ```
   SessionsInterface->UpdateSessionSettings(MoveTemp(Params))
        .OnComplete([this](const UE::Online::TOnlineResult<UE::Online::FUpdateSessionSettings>& Result)
        {
            if(Result.IsError())
            {
                const UE::Online::FOnlineError OnlineError = Result.GetErrorValue();
                // update was not successful, process OnlineError
                return;
            }
            // update was successful
   ```

## 从 Online Subsystem 转换代码

Online Services Sessions Interface 负责 [Online Subsystem Sessions Interface](../../../online-subsystem/online-subsystem-session-interface/index.md).

## 更多信息

### 头文件

根据需要直接查阅 `Sessions.h` 头文件以获取更多信息。Sessions Interface 头文件 `Sessions.h` 位于以下目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

有关如何获取 UE 源代码，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 [函数](../../overview-of-online-services/index.md#functions) 部分（位于 Online Services Overview 页面），了解函数参数和返回类型，包括如何传递参数以及函数返回时如何处理结果。

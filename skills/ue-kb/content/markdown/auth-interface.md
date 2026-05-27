# Auth Interface

---
title: "Auth Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/auth-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Auth Interface"]
---

# Auth Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Auth Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/auth-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services Auth Interface** 提供 API，用于通过在线服务认证并验证本地用户。认证本地用户会返回账户 ID，项目可使用该 ID 与许多其他在线服务功能交互。

## API 概述

### 函数

下表概述 Auth Interface 中包含的函数。

| 函数 | 说明 |
| --- | --- |
| [Login](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/Login?application_version=5.5) | 认证本地用户。 |
| [Logout](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/Logout?application_version=5.5) | 结束本地用户的认证会话。 |
| [ModifyAccountAttributes](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/ModifyAccountAttributes?application_version=5.5) | 修改与已认证账户关联的属性。 |
| [QueryExternalServerAuthTicket](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/QueryExternalServerAuthTicket?application_version=5.5) | 查询一个票据，用于代表已登录用户发起服务器到服务器调用。票据预期为一次性使用；当重复发起需要票据的调用时，用户必须再次调用 API 获取新票据。 |
| [QueryExternalAuthToken](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/QueryExternalAuthToken?application_version=5.5) | 检索一个令牌，用于将该服务账户与另一种服务类型的服务账户关联。 |
| [QueryVerifiedAuthTicket](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/QueryVerifiedAuthTicket?application_version=5.5) | 检索一个票据，用于在远程客户端上创建已验证的认证会话。 |
| [CancelVerifiedAuthTicket](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/CancelVerifiedAuthTicket?application_version=5.5) | 取消与已验证认证会话关联的票据，并清理与该票据关联的所有资源。 |
| **Session** |  |
| [BeginVerifiedAuthSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/BeginVerifiedAuthSession?application_version=5.5) | 为远程用户启动已验证认证会话。 |
| [EndVerifiedAuthSession](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/EndVerifiedAuthSession?application_version=5.5) | 清理远程已验证认证会话及所有关联资源。 |
| **获取用户** |  |
| [GetLocalOnlineUserByOnlineAccountId](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/GetLocalOnlineUs-?application_version=5.5) | 使用 Online Account ID 检索已登录用户账户。 |
| [GetLocalOnlineUserByPlatformUserId](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/GetLocalOnlineUs-_1?application_version=5.5) | 使用 Platform User ID 检索已登录用户账户。 |
| [GetAllLocalOnlineUsers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/GetAllLocalOnlineUsers?application_version=5.5) | 检索所有已登录用户账户。 |
| **事件监听** |  |
| [OnLoginStatusChanged](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/OnLoginStatusChanged?application_version=5.5) | 用户登录状态变化时触发的事件。 |
| [OnPendingAuthExpiration](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/OnPendingAuthExpiration?application_version=5.5) | 认证令牌即将过期时触发的事件。 |
| [OnAccountAttributesChanged](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/OnAccountAttributesChanged?application_version=5.5) | 与已认证账户关联的附加属性发生变化时触发的事件。 |
| **辅助** |  |
| [IsLoggedIn](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAuth/IsLoggedIn?application_version=5.5) | 查询本地用户的登录状态。 |

### 枚举类

Auth Interface 定义了三个枚举类，分别表示用户登录状态（[ELoginStatus](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__ELoginStatus?application_version=5.5)）、认证票据受众（[ERemoteAuthTicketAudience](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__ERemoteAuthTicketAud-?application_version=5.5)）以及认证令牌方法（[EExternalAuthTokenMethod](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__EExternalAuthTokenMe-?application_version=5.5)).

#### ELoginStatus

| 枚举值 | 说明 |
| --- | --- |
| `NotLoggedIn` | 玩家未登录，或选择了本地配置文件。 |
| `UsingLocalProfile` | 玩家正在使用本地配置文件，但未登录。 |
| `LoggedInReducedFunctionality` | 玩家已登录，但在线服务功能可能受限。 |
| `LoggedIn` | 玩家已登录，并由平台特定认证服务验证。 |

#### ERemoteAuthTicketAudience

| 枚举值 | 说明 |
| --- | --- |
| `Peer` | 生成适用于对等验证的票据。 |
| `DedicatedServer` | 生成适用于专用服务器验证的票据。 |

#### EExternalAuthTokenMethod

| 枚举值 | 说明 |
| --- | --- |
| `Primary` | 使用 Auth Interface 提供的主要方法获取外部认证令牌。 |
| `Secondary` | 使用 Auth Interface 提供的次要方法获取外部认证令牌。 |

### 主要结构体

与用户及其登录信息关联的主要结构体是 [FAccountInfo](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FAccountInfo?application_version=5.5) 结构体：

#### FAccountInfo

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AccountId` | `FAccountId` | 该用户的账户 ID。它表示用户的在线平台账户。 |
| `PlatformUserId` | `FPlatformUserId` | 与该在线用户关联的平台用户 ID。 |
| `LoginStatus` | `ELoginStatus` | 该当前用户的登录状态。 |
| `Attributes` | `TMap<FSchemaAttributeId, FSchemaVariant>` | 附加账户属性。 |

## 流程

### Login

`Login` 会使用所选在线服务认证本地用户。 Upon success, `Login` returns an `FAccountInfo` struct. The `FAccountInfo` struct contains an `FAccountId`, ，这是使用 Auth Interface 中许多其他函数所必需的。 成功登录也会将用户的 `LoginStatus` to `ELoginStatus::LoggedIn`. 用户登录账户后，该状态未来可能会变为 `ELoginStatus::UsingLocalProfile` or `ELoginStatus::LoggedInReducedFunctionality` ，具体取决于其他条件。

> [!NOTE]
> 如果有多个本地用户需要登录，每个用户都必须单独登录。此外，平台服务可能不要求显式登录。在这些服务上，应用启动时用户会被隐式登录。更多信息请参阅具体平台服务文档。

### 使用外部服务器认证

游戏经常会有提供游戏特定功能的自定义 Web 服务。 这些服务需要在提供访问前验证调用者身份。 `QueryExternalServerAuthTicket` 会检索一个一次性票据，用于在外部服务器上认证用户。

#### 将已认证用户与另一个在线服务关联

许多游戏需要使用多个在线服务。 常见情况包括将平台服务与另一个扩展其功能的服务配对。 `QueryExternalAuthToken` 会返回一个适合与另一个在线服务认证的令牌，以避免要求用户为辅助服务提供单独登录凭据。

在大多数平台上，该令牌是 OpenID 令牌，可提供用户身份保证。 随后会通过设置 `CredentialsType` to `ExternalAuth` 并将令牌作为 `CredentialsToken`.

#### 使用 P2P 或专用服务器验证用户身份

用户连接到游戏服务器或对等网络时，需要证明其身份，并允许跟踪认证会话。 在客户端侧， `QueryVerifiedAuthTicket` 会检索一个一次性票据，发送给游戏服务器以证明用户身份。 `CancelVerifiedAuthTicket` 会在游戏服务器上的游玩会话结束后取消该票据。

> [!WARNING]
> 由于调用 `QueryVerifiedAuthTicket` 获得的票据是一次性票据， `QueryVerifiedAuthTicket` 必须在用户每次开始新的已验证认证会话时调用。 同样逻辑也适用于 `CancelVerifiedAuthTicket`. `CancelVerifiedAuthTicket` 必须针对用户创建的每个票据调用。

游戏服务器会调用 `BeginVerifiedAuthSession` 并在客户端连接时传入客户端提供的票据。 成功完成后，会为与该票据关联的用户开始一个已验证认证会话。 `EndVerifiedAuthSession` 会在游戏结束后清理关联资源。

用户客户端连接到远程游戏服务器的流程可总结为：

- 客户端通过调用以下函数获取会话认证票据： `QueryVerifiedAuthTicket`.
- 客户端将会话认证票据、票据 ID 和账户 ID 发送给服务器。
- 服务器接收该信息，并通过调用以下函数开始已验证认证会话： `BeginVerifiedAuthSession`.
- 会话结束时，客户端使用以下函数取消认证票据： `CancelVerifiedAuthTicket` ，服务器使用以下函数结束认证会话： `EndVerifiedAuthSession`.

在对等网络模型中，上述流程不同。每个用户客户端都会为其连接到的每个远程客户端创建新的认证票据。随后，使用游戏服务器认证的步骤会应用于每个远程对等端：

- 每个新的远程对等端调用 `QueryVerifiedAuthTicket` 并检索一次性票据，用于与其他所有现有对等端认证。
- 每个现有对等端调用 `BeginVerifiedAuthSession` 为新的远程对等端开始已验证认证会话。

> [!NOTE]
> 并非所有接口实现都支持对等网络。更多信息请参阅平台服务文档。

### 修改账户属性

游戏代码可在 `FAccountInfo` 结构体中按需通过调用以下函数存储额外自定义属性： `ModifyAccountAttributes`.

> [!NOTE]
> 修改后的属性会保留在用户数据中，直到调用 `Logout` 。 认证会话结束后，这些属性不会继续保留。 `Logout` 会销毁用户的 `FAccountInfo` 结构体，其中包含这些属性。

### Logout

`Logout` 会结束本地用户当前认证会话，并清理关联资源和结构体。

## 示例

### 使用平台服务登录

C++

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
	UE::Online::IAuthPtr AuthInterface = OnlineServices->GetAuthInterface();

	UE::Online::FAuthLogin::Params Params;
	Params.PlatformUserId = PlatformUserId;
	Params.CredentialsType = LoginCredentialsType::ExchangeCode;
	Params.CredentialsToken = TEXT("1234567890"); // Exchange code from command-line

	AuthInterface->Login(MoveTemp(Params)).OnComplete([](const UE::Online::TOnlineResult<UE::Online::FAuthLogin>& Result)
	{
```

#### 演练

1. 通过调用 `GetServices` 且不传入参数，检索默认在线服务，然后访问 Auth Interface：

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();         UE::Online::IAuthPtr AuthInterface = OnlineServices->GetAuthInterface();
   ```
2. 实例化登录用户所需的参数：

   C++

   ```
   UE::Online::FAuthLogin::Params Params;         Params.PlatformUserId = PlatformUserId;         Params.CredentialsType = LoginCredentialsType::ExchangeCode;         Params.CredentialsToken = TEXT("1234567890"); // Exchange code from command-line
   ```
3. 处理 `Login.OnComplete` 回调；登录成功时注册账户信息，或处理生成的错误：

   C++

   ```
   AuthInterface->Login(MoveTemp(Params)).OnComplete([](const UE::Online::TOnlineResult<UE::Online::FAuthLogin>& Result)
            {
                if(Result.IsOk())
                {
                    const TSharedRef<UE::Online::FAccountInfo> AccountInfo = Result.GetOkValue().AccountInfo;
                    // Account Info object is now accessible
                }
                else
                {
                    FOnlineError Error = Result.GetErrorValue();
   ```

## 从 Online Subsystem 转换代码

Online Services Auth Interface 负责原先由以下接口拥有的所有代码： [Online Subsystem Identity Interface](../../../online-subsystem/online-subsystem-identity-interface/index.md).

## 更多信息

### 头文件

可直接查阅 `Auth.h` 头文件以按需获取更多信息。 Auth Interface 头文件 `Auth.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

有关如何获取 UE 源代码的说明，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数与返回类型

请参阅 Online Services Overview 页面的 Functions 部分，了解函数参数和返回类型的说明，包括如何传递参数以及如何处理函数返回的结果。


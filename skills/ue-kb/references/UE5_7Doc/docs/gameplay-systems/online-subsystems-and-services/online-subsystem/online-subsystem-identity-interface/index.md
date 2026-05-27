---
title: "Identity Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-identity-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线子系统", "Identity Interface"]
---

# Identity Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线子系统 / Identity Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-identity-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

连接到游戏会话并通过互联网与其他玩家交互，通常需要登录第三方在线服务上的注册账户。 这些服务可以由社交媒体网站、硬件平台所有者或游戏服务运营。 在 Unreal Engine（UE）中， **Identity Interface** 负责处理与这些服务相关的账户交互，提供用户认证并获取访问令牌的能力。

## 认证函数

### Login

该 `Login` 函数接收本地玩家的账户凭据（`FOnlineAccountCredentials`) ）并尝试登录在线服务。 要自动生成账户凭据，或从命令行参数生成账户凭据，可以改为调用 `AutoLogin` 函数。 在线服务响应后，无论登录尝试成功还是失败， `FOnLoginCompleteDelegate` 都会被调用。 In addition, the `FOnLoginStatusChangedDelegate` 会在特定本地玩家的登录状态发生变化时被调用。

> [!NOTE]
> 每个本地用户都会分别登录。 对于支持本地多人游戏的项目，这一点尤其重要，因为玩家需要使用各自的账户名参与在线竞争、获得排行榜分数、邀请好友并解锁成就。

> [!TIP]
> 如果调用 `Login` 失败， [ExternalUI 接口](../online-subsystem-external-ui-interface/index.md) 可以提供帮助，让用户有机会通过在线服务内置的用户界面手动登录。 并非所有在线平台都会使用 `FOnlineAccountCredentials` 作为认证流程的一部分；在某些情况下，内置用户界面可能是唯一受支持的登录方式。

### 注销

要让用户退出在线服务，请使用 `Logout` function. 该操作完成后， `FOnLogoutCompleteDelegate` 都会被调用。 In addition, the `FOnLoginStatusChangedDelegate` 会在特定本地玩家的登录状态发生变化时被调用。

### 检查当前登录状态

本地玩家可能已在线登录，可能只登录了本地配置文件（但未在线），也可能完全未登录。 要查找玩家当前状态，请使用 `GetLoginStatus` function. 由于登录状态根据最近一次与在线服务通信的结果确定，因此没有需要绑定的委托。 不过，如果你正在等待特定状态变化，例如玩家登录，并且不想定期轮询此函数，可以绑定 `FOnLoginStatusChangedDelegate` 来处理。

> [!NOTE]
> 在某些系统上，用户可以将物理输入设备重新分配给不同玩家，这会改变他们在 Unreal Engine 内的本地玩家索引值。 这样可能会切换已登录用户的本地用户索引值，但并不会实际改变任何用户的登录状态。 The `OnControllerPairingChanged` 委托会在这种情况下被调用，并提供控制器索引以及相关用户的 `FUniqueNetId` 值。

## 玩家标识与信息

### 在身份系统之间转换

在 Unreal Engine 的网络环境中，成功登录后会自动为本地玩家关联一个不透明的 `FUniqueNetId` 值会在成功登录后自动与本地玩家关联。 除了在 Unreal Engine 网络代码中使用之外，它也作为各在线服务专有身份数据类型的抽象。

> [!TIP]
> 如果需要复制某个用户的 `FUniqueNetId`, [FUniqueNetIdRepl](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/FUniqueNetIdRepl?application_version=5.5) 提供 `ToString` 方法，可将 `FUniqueNetId` 转换为可安全复制的字符串，之后可通过 `CreateUniquePlayerId`.

Identity Interface 提供了一些函数，可在这些不同系统和身份类型之间建立桥接。 可以获取玩家的 `FUniqueNetId` ：调用 `CreateUniquePlayerId` 并传入该玩家的服务专属身份，或通过 `GetUniquePlayerId`, ，并传入玩家的本地用户索引。 Using the player's `FUniqueNetId`后，可以调用 `GetPlatformUserIdFromUniqueNetId` 获取玩家的服务专属身份（类型为 `FPlatformUserId`), 但多数情况下并不需要这样做。 所有这些函数都使用本地可用信息，因此不涉及委托或回调。

> [!NOTE]
> 该 `GetSponsorUniquePlayerId` 会返回发起邀请玩家的 `FUniqueNetId`，但该函数只针对 Xbox Live 服务实现。

### 用户账户信息

抽象类 `FOnlineUser`, 表示与任意在线子系统相关的用户账户基础信息，并作为访问本地或远程用户公开可见信息的通用接口。 该类的扩展 `FUserOnlineAccount`提供对本地已登录用户所有可用信息的访问。

在某些情况下，在线系统的 `FOnlineUser` 子类可以扩展，以适配特定在线服务的需求。 基类支持返回用户的 `FUniqueNetId`、真实姓名与显示名称（取决于所使用的在线服务），以及可能与该用户关联的任何字符串属性；不过这些属性的存储必须由子类实现。

该 `FUserOnlineAccount` 类同样是抽象类，但它建立了一个框架，用于设置用户属性并存储本地已登录用户的元数据，包括服务专属访问令牌或其他数据。 某些子系统会使用这些令牌访问功能；你也可以用它们发起 RESTful 调用，或与你自己的后端服务协同工作。

### 检索本地已知账户

许多在线服务会记录曾从本机登录或在本机创建的用户账户。 对于支持此行为的服务，函数 `GetAllUserAccounts` 会被实现为返回一个数组，列出所有这些已知账户。 这些账户会以 `FUserOnlineAccount` 数据形式返回。 要检查特定玩家是否位于列表中， `GetUserAccount` 可以被调用，用于将玩家的 `FUniqueNetId` 映射到一个已知的 `FUserOnlineAccount`，前提是列表中存在对应项。

### 玩家显示名称

某些在线服务允许用户输入不同于账户登录名的“显示名称”或“昵称”。 在游戏聊天、记分板、角色标签或类似面向用户的显示内容中，这类名称通常比账户名更适合展示。 Using a player's `FOnlineUser`, call `GetDisplayName` 即可从本地缓存的用户账户数据中检索该玩家的显示名称或昵称。

### 用户权限

在线服务可以作为网关，授予或拒绝访问某些在线功能，其中最典型的是与其他服务用户在线游戏的能力。 The `GetUserPrivilege` 函数会报告用户是否拥有特定权限（定义于 [EUserPrivileges](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineSubsystem/Interfaces/EUserPrivileges__Type?application_version=5.5)). 该函数需要联系在线服务，并会通过 `FOnGetUserPrivilegeCompleteDelegate`响应用户请求，返回类型为 [EPrivilegeResults](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineSubsystem/Interfaces/IOnlineIdentity/EPrivilegeResults?application_version=5.5).

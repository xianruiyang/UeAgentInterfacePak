---
title: "Online Services Overview"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-online-services-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "Online Services Overview"]
---

# Online Services Overview

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / Online Services Overview

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-online-services-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services** 插件及其接口提供通用方式，用于访问 Playstation Network、Xbox Live、Epic、Steam 等各种在线服务功能。Online Services 插件的设计确保开发者在开发面向多个平台发布、或支持多个在线服务的游戏时，只需要为每个受支持服务调整配置。

## 设计理念

Online Services 插件被组织成模块化、服务特定的 **接口** ，用于对受支持功能分组。接口及其支持功能组列表请参阅本页的 [接口](index.md#interfaces) 表格。

Online Services 插件设计为处理与各种服务的异步通信。 由于网络连接速度波动、服务器延迟和未知后端服务耗时，与这些系统交互所需时间不可预测。 为解决这些问题，Online Services Interface 会返回 `TOnlineAsyncOpHandle` 用于所有远程操作，并保证 `OnComplete` 事件回调会被调用到该 handle。

每个支持相应功能组的在线服务都会提供接口。 特定在线服务不支持的具体函数会返回 `Errors::NotImplemented` 来自 `OnComplete` 回调。 此功能确保开发者可以对所有在线服务使用相同代码。

### 事件回调与监听

该 `OnComplete` 回调提供以下功能：

- 请求完成时响应请求。
- 可以查询正在进行的请求。
- 使用单一代码路径。

最后一点很重要，因为它消除了开发者为捕获不同成功或失败条件而编写自定义代码的需求。

#### 回调格式

根据开发者为 `OnComplete` 回调（Online Services 的事件回调）或事件监听传入参数的方式，会自动构造适当委托。 根据 `this` 的类型，会调用不同的委托创建函数；以下示例使用 `QueryStats` 函数，来自 Stats Interface：

C++

```
Stats->QueryStats(MoveTemp(Params)).OnComplete(this, &MyClass::OnQueryStatsComplete);
```

Or in this example using `OnStatsUpdated`:

C++

```
Stats->OnStatsUpdated().Add(this, &MyClass::OnStatsUpdated);
```

在任一示例中，行为如下：

- 如果它是 UObject，则底层委托的 `CreateUObject` 会被调用。
- 如果它派生自 `TSharedFromThis`, `CreateThreadSafeSP` or `CreateSP` （如果它是非线程安全共享指针）会被调用。
- In any other case, `CreateRaw` 会被调用。

通常会使用最安全的委托创建函数调用。

## 接口

Online Services 插件包含以下接口。

| 接口 | 功能组说明 |
| --- | --- |
| [Achievements](../online-services-interfaces/achievements-interface/index.md) | 列出游戏中的所有成就、解锁成就，并检查自己以及其他用户已解锁的成就。 |
| [Auth](../online-services-interfaces/auth-interface/index.md) | 通过在线服务认证并验证本地用户。 |
| [Commerce](../online-services-interfaces/commerce-interface/index.md) | 检索可用于游戏内购买的分类和具体商品。 |
| [Connectivity](../online-services-interfaces/connectivity-interface/index.md) | 获取在线服务连接状态，或接收连接状态通知。 |
| [ExternalUI](../online-services-interfaces/external-ui-interface/index.md) | 打开特定硬件平台或在线服务的内置用户界面。在某些情况下，服务只会通过此接口授予对特定核心功能的访问。 |
| [Leaderboard](../online-services-interfaces/leaderboards-interface/index.md) | 访问在线排行榜，包括登记自己的分数，以及查看好友列表或全球其他玩家的排行榜分数。 |
| [Lobbies](../online-services-interfaces/lobbies-interface/index.md) | 创建和加入大厅，与好友一起游玩。 |
| [Presence](../online-services-interfaces/presence-interface/index.md) | 设置用户在线状态和可加入性向其他用户显示的方式。状态包括“Online”、“Offline”、“Away”等。 |
| [Privileges](../online-services-interfaces/privileges-interface/index.md) | 查询用户权限，例如年龄限制、通信限制、跨平台游玩设置等。 |
| [Session](../online-services-interfaces/sessions-interface/index.md) | 创建、销毁和管理在线游戏会话，包括搜索会话和匹配系统。 |
| [Social](../online-services-interfaces/social-interface/index.md) | 将用户添加到好友列表、屏蔽用户、取消屏蔽用户，并列出最近在线遇到的玩家。 |
| [Stats](../online-services-interfaces/stats-interface/index.md) | 将统计数据上传到后端，以完成统计查询、成就进度、排行榜排名等相应功能。 |
| [Title File](../online-services-interfaces/title-file-interface/index.md) | 允许游戏读取未随发行版本打包、但已上传到后端服务并在运行时下载到当前游戏的文件。 |
| [User File](../online-services-interfaces/user-file-interface/index.md) | 与用户文件存储交互。 |
| [User Info](../online-services-interfaces/user-info-interface/index.md) | 收集关于用户的元数据。 |

## 函数

每个接口都包含多种同步和异步函数。下面简要介绍如何向函数传递参数，以及函数返回时如何处理结果。有关具体接口函数的更详细信息，请参阅 [Online Services Interface](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface?application_version=5.5) 模块，位置在 [Unreal Engine C++ API Reference](../../../../unreal-engine-c-api-reference/index.md).

### 参数

Online Services Interface 函数的参数使用 `Params` 成员创建，该成员属于每个函数关联的结构体。 随后使用 `MoveTemp`, （UE 中等价于 `std::move`, ）或通过 {}-分隔列表将这些参数传递给相关函数。

### 返回类型

Online Services Interface 中定义的函数有三种不同返回类型：

- [TOnlineResult](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/TOnlineResult?application_version=5.5)
- [TOnlineAsyncOpHandle](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/TOnlineAsyncOpHandle?application_version=5.5)
- [TOnlineEvent](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/TOnlineEvent?application_version=5.5)

#### TOnlineResult

同步函数返回 `TOnlineResult<T>` 其中 `T` 是相关函数关联的结构体。 要判断返回是否成功，需要调用 `IsOk` or `IsError`. 二者都会返回布尔值，表示结果是否可访问，或是否产生错误。 最后，如果 `IsOk` 返回 true，则 `T::Result` 可以通过调用访问 `GetOkValue`. 类似地，如果 `IsError` 返回 true，则 `FOnlineError` 可以通过调用访问 `GetErrorValue`.

#### TOnlineAsyncOpHandle

需要异步通信的函数会返回 `TOnlineAsyncOpHandle<T>`. 添加 `OnComplete` 回调到该 handle，会监听此 handle 状态的任何最终变化 — 无论是成功完成、失败、超时或其他情况。 回调的 `TOnlineResult<T>` 参数会包含成功结果数据或 `FOnlineError` ，用于描述函数失败原因。 该回调接受 unique function，因此如果使用 lambda 函数，unique pointer 和重型数据类型可以移动到 lambda 捕获作用域中。

#### TOnlineEvent

用于事件监听的函数会返回 `TOnlineEvent<T>`. 类似于 `TOnlineAsyncOpHandle`, 可以使用 `Add` function. `Add` 随后会以如下签名触发该回调： `T` 只要检测到匹配条件的事件。 可以向同一事件添加多个回调。 调用 Add 会返回 `FOnlineEventDelegateHandle` — 如果该 handle 被销毁，此委托回调会被解除绑定，因此请确保在监听该事件的系统生命周期内保持它存活，并正确销毁/call `Unbind` ，或在关联系统销毁时对该 handle 调用。

## 使用 Online Services 或 Online Subsystem

**Unreal Engine（UE）** 现在提供两个访问在线服务的框架：Online Services 和 **Online Subsystem**。继续阅读以判断哪个适合你的项目。

### Online Services

Online Services 插件尚未在发行游戏中测试。截至 UE 5.1，Online Services 插件是 API 完整版本，供开发者使用，目标是在未来引擎版本中用于发行。对于面向自有后端，或计划在发布前将多个 UE 5.1 之后升级合入项目的开发者，也建议使用 Online Services。

### Online Subsystem

请使用 [Online Subsystem](../../online-subsystem/index.md) 用于近期要发行的任何游戏，或当不计划将 UE 5.1 之后的引擎升级合入项目时使用。

## 配置

Online Services 插件的基础模块是 `OnlineServices`. 该模块会定义并向 UE 注册服务特定模块。 所有在线服务访问都会通过该模块。 `OnlineServices` 会尝试加载在 `DefaultEngine.ini` 中指定的默认在线服务模块。 将以下代码添加到 `DefaultEngine.ini` 文件，以启用在线服务并指定默认在线服务：

C++

```
[OnlineServices]DefaultServices=<DEFAULT_PLATFORM_IDENTIFIER>
```

`DEFAULT_PLATFORM_IDENTIFIER` 是一个变量，必须用以下受支持平台标识符之一替换：

- Null
- Epic
- Xbox
- PSN
- Nintendo
- Steam
- Google
- GooglePlay
- Apple
- AppleGameKit
- Samsung
- Oculus
- Tencent

该 `DefaultServices` 在 `DefaultEngine.ini` 中指定的值可通过以下函数获取： [UE::Online::GetServices](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__GetServices?application_version=5.5) 不指定参数时：

C++

```
TSharedPtr<IOnlineServices> GetServices(EOnlineServices OnlineServices = EOnlineServices::Default, FName InstanceName = NAME_None);
```

调用 `UE::Online::GetServices` 请求时，会按需加载其他在线服务。 无效标识符或模块加载失败会返回 `null`.

## 使用接口

各种 Online Services Interface 的头文件位于引擎目录：

C++

```
UNREAL_ENGINE_ROOT/Engine/Plugins/Online/OnlineServices/Source/OnlineServicesInterface/Public/Online
```

建议查阅该目录中的头文件，以了解 Online Services 及其各接口的更多信息。

每个 Online Services Interface 文档页都包含代码示例或示例流程，帮助你开始使用 Online Services 插件。

### 使用控制台命令运行接口

也可以使用控制台命令运行 Online Services Interface。请参阅 [Online Services Console Commands](../debugging-online-services-plugin/online-services-console-commands/index.md) 文档，了解使用 Online Services 插件控制台命令及其语法的更多信息。

- [控制台命令](../../../networking-and-multiplayer/network-debugging/console-commands-for-network-debugging/index.md) - 在运行时指定网络设置并获取有价值的调试信息。

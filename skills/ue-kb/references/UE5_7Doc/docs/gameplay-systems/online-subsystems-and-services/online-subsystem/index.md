---
title: "在线子系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线子系统"]
---

# 在线子系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线子系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/online-subsystem-in-unreal-engine

**在线子系统（Online Subsystem）** 及其接口提供一种可访问Steam、Xbox Live、Facebook等在线服务功能的常用方法。开发一款在多平台上发行或支持多在线服务的游戏时，在线子系统可确保开发者唯一需要做的变更就是对所有支持的服务进行配置调整。

## 设计理念

在线子系统的基本设计目的是处理与不同在线服务之间的异步通信。由于本地电脑无法得知网络连接速度、服务器延迟和后端服务运行时间，因此无法预测与此类系统交互所需时间。为了处理该问题，在线子系统对所有远程操作均进行[委托](../../../cpp-programming/delegates-and-lambda-functions/index.md)，并确保使用支持的异步功能时调用此类委托。除可在请求完成时进行响应和查询正在运行的请求外。委托还提供单一代码路径以跟踪，因此开发人员无需编写自定义代码来采集不同的成功或失败条件。

服务指定的模块化接口会将支持的功能分组在一起。例如，好友接口处理与好友列表的相关内容，而成就接口处理成就的排列、检查和授予等。在支持功能组的在线服务上，都存在相应功能组的接口，但不受服务支持的特定函数只会返回 `false`。利用此设计，开发人员可为所有在线服务编写相同代码。

在高阶层面上，更复杂的操作将使用[在线异步任务管理器](https://api.unrealengine.com/INT/API/Plugins/OnlineSubsystem/FOnlineAsyncTaskManager/index.html)来支持顺序任务，或者在不同线程上运行的任务。异步任务可以描述自身的依赖性，从而在连续运行顺序任务的同时，使无关任务能够平行且独立运行。在线子系统中的所有接口都以这种方式安排任务，以保持运算的一致性。

## 基本结构和用途

基本模块 `OnlineSubsystem` 定义服务指定的模块，并在引擎中进行注册。在初始化期间，在线子系统将尝试加载"Engine.ini"文件中指定的默认在线服务模块。对在线服务的所有访问都将通过此模块。

```
	[OnlineSubsystem]	DefaultPlatformService=<Default Platform Identifier>
```

若成功，未指定参数时，将通过静态存取器使用默认在线子系统。

```
	static IOnlineSubsystem* Get(const FName& SubsystemName = NAME_None)
```

若调用此函数需请求其他服务，将按需进行加载。若标识符无效或加载模块失败，将适宜地返回 `null`。

## 接口

在线子系统中包含以下接口。

> [!NOTE]
> 部分接口只针对某些在线服务，取决于每个服务所支持的功能。

| 接口 | 功能组描述 |
| --- | --- |
| [成就](online-subsystem-achievements-interface/index.md) | 列出游戏中的所有成就，解锁成就，并查看自己和其他用户已解锁的成就。 |
| [外部UI](online-subsystem-external-ui-interface/index.md) | 打开特定硬件平台或在线服务的内置用户接口。在某些情况下，仅可通过此接口获取部分核心功能的访问权。 |
| [好友](https://dev.epicgames.com/documentation/404) | 好友和好友列表的相关内容，例如在好友列表中添加用户、阻止和解除阻止用户，以及列出最近遇到的在线玩家。 |
| [排行榜](online-subsystem-leaderboard-interface/index.md) | 访问在线排行榜，包括登记自己的得分（或时间），以及在排行榜中查看好友列表或世界其他玩家的得分。 |
| [在线用户](online-subsystem-user-interface/index.md) | 收集关于用户的元数据。 |
| [状态](online-subsystem-presence-interface/index.md) | 设置用户在线状态的显示方式，例如"在线"、"离开"、"游戏中"等。 |
| [购买](online-subsystem-purchase-interface/index.md) | 进行游戏内购和查看购买历史。 |
| [会话](online-subsystem-session-interface/index.md) | 创建、撤销和管理在线游戏会话。还包括搜索会话和配对系统。 |
| [商店](https://dev.epicgames.com/documentation/404) | 检索游戏内购可用的条目和特定价格。 |
| [用户云](https://dev.epicgames.com/documentation/404) | 提供每个用户云文件存储的接口。 |
| [语音聊天(EOS)](../voice-chat-interface/index.md) | 使用Epic在线服务作为语音聊天提供者。 |

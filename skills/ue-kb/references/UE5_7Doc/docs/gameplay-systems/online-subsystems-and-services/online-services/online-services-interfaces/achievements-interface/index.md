---
title: "Online Services Achievements Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/achievements-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Online Services Achievements Interface"]
---

# Online Services Achievements Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Online Services Achievements Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/achievements-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

一个 **成就** 是游戏环境之外授予的目标或奖杯，会因完成游戏内任务而解锁或奖励。成就提供了一种激励、挑战和奖励玩家的方式。可以使用它们来：

- 引导玩家游玩游戏
- 提高游戏可重玩价值
- 支持玩家之间的竞争

该 **Online Services Achievements Interface** 提供工具，用于读取成就定义，以及读取和更新玩家的成就状态。Achievements Interface 不负责创建、删除或修改成就。每个在线服务都有自己的后端系统来管理这些成就方面。

可以根据接口配置设置以下机制来解锁成就：

- **平台服务管理**：关联统计数据达到预定义阈值时，平台服务会自动解锁成就。
- **游戏管理（自动）**：关联统计数据达到预定义阈值时，游戏会自动解锁成就。更多信息请参阅 [配置自动游戏管理成就](index.md) 部分。
- **游戏管理（手动）**: 游戏会根据自身逻辑和 `UnlockAchievements` 函数手动解锁成就。

> [!NOTE]
> 这三个选项的可用性取决于所使用的在线服务实现/平台。更多信息请查阅对应在线服务实现的文档。

## API 概述

### 函数

下表概述 Achievements Interface 提供的函数：

| 函数 | 定义 |
| --- | --- |
| [QueryAchievementDefinitions](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/QueryAchievement-?application_version=5.5) | 查询此游戏的所有成就定义。 |
| [GetAchievementIds](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementIds?application_version=5.5) | 检索由以下函数缓存的成就 ID： `QueryAchievementDefinitions`. |
| [GetAchievementDefinition](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementDefinition?application_version=5.5) | 使用所提供的成就 ID，检索由以下函数缓存的成就定义： `QueryAchievementDefinitions`. |
| [QueryAchievementStates](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/QueryAchievementStates?application_version=5.5) | 查询所提供玩家的所有成就状态。 |
| [GetAchievementState](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementState?application_version=5.5) | 按 ID 检索所提供玩家的某个成就状态。 |
| [UnlockAchievements](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/UnlockAchievements?application_version=5.5) | 手动解锁所提供的成就。 |
| [DisplayAchievementUI](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/DisplayAchievementUI?application_version=5.5) | 为所提供成就启动平台 UI。 |
| [OnAchievementStateUpdated](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/OnAchievementSta-?application_version=5.5) | 玩家成就状态变化时触发的事件。 |

### 主要结构体

Achievements Interface 主要通过三个结构体传递其功能： [FAchievementDefinition](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FAchievementDefinition?application_version=5.5), [FAchievementStatDefinition](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FAchievementStatDefinition?application_version=5.5)，以及 [FAchievementState](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FAchievementState?application_version=5.5)；此外还有用于传递参数和返回值的函数专属结构体。

#### FAchievementDefinition

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AchievementId` | `FString` | 唯一成就 ID。 |
| `UnlockedDisplayName` | `FText` | 该成就解锁后使用的本地化显示名称。 |
| `UnlockedDescription` | `FText` | 该成就解锁后使用的本地化说明。 |
| `LockedDisplayName` | `FText` | 该成就锁定时使用的本地化显示名称。 |
| `LockedDescription` | `FText` | 该成就锁定时使用的本地化说明。 |
| `FlavorText` | `FText` | 本地化风味文本。 |
| `UnlockedIconUrl` | `FString` | 该成就解锁后使用的图标 URL。 |
| `LockedIconUrl` | `FString` | 该成就锁定时使用的图标 URL。 |
| `bIsHidden` | `bool` | 该成就是否在解锁前隐藏。 |
| `StatDefinitions` | `TArray<FAchievementStatDefinition>` | 与该成就相关的统计数据。 |

#### FAchievementStatDefinition

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `StatId` | `FString` | 统计数据的唯一 ID。 |
| `UnlockThreshold` | `uint32` | 用户关联统计数据必须达到的阈值，达到后成就会自动解锁。 |

#### FAchievementState

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AchievementId` | `FString` | 此状态关联的成就。 |
| `Progress` | `float` | 解锁该成就的进度，以 0.0 到 1.0 之间的百分比表示。任何小于 1.0 的值都表示成就仍锁定；1.0 表示成就已解锁。 |
| `UnlockTime` | `FDateTime` | 如果已解锁，则为该成就解锁的时间。 |

## 配置自动游戏管理成就

当成就由平台服务管理，或由游戏管理且手动解锁时，Achievements Interface 不需要引擎配置。如果成就进度由游戏管理，并且希望一个或多个统计数据达到预定义阈值时自动解锁成就，则必须配置引擎。

对于自动解锁、由游戏管理的成就，Achievements Interface 会与 [Stats Interface](../stats-interface/index.md)协同工作。必须为该机制配置引擎，以便为成就设置解锁规则，并基于 Stats Interface 配置中定义的统计数据建立条件。

### 通用语法

C++

DefaultEngine.ini

```
[OnlineServices.Achievements]	bIsTitleManaged=true	!UnlockRules=ClearRules	+UnlockRules=(AchievementId=<AchievementId1>, Conditions=((StatName=<StatName>, UnlockThreshold="<Type>:<Value>"), ...))	+UnlockRules=(AchievementId=<AchievementId2>, Conditions=((StatName=<StatName>, UnlockThreshold="<Type>:<Value>"), ...))	...
```

> [!NOTE]
> 要让自动解锁、由游戏管理的成就根据统计数据变化更新，必须将 `bIsTitleManaged` 标志设为 `true`. 该标志会配置客户端监听 Online Services Stats Interface 的 `FStatsUpdated` 事件，并在统计数据变化时自动更新成就状态。 The `bIsTitleManaged` flag's default value is `false`. 如果不将该标志设为 `true`, 成就将不会根据成就定义中配置的统计数据变化自动更新，位置在 `DefaultEngine.ini`.

列表 `Conditions` 位于 `UnlockRules` 中，包含单独的条件对。 成就可以依赖一个或多个与以下内容配对的统计数据： `UnlockThreshold`. 只有关联 `Conditions` 列表中的每个统计数据都达到或超过预定义阈值后，成就才会解锁。

#### 解锁规则

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `AchievementId` | `String` | 此解锁规则关联的成就 ID。 |
| `Conditions` | `List` | 该成就解锁所需条件列表。 |

#### 条件

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `StatName` | `String` | 与该成就解锁阈值关联的统计数据名称。 |
| `UnlockThreshold` | 冒号分隔的 `Type:Value` 对 | 形式为以下内容的对： `<Type>:<Value>` 其中 `Type` 是该统计数据的类型， `Value` 是满足该条件并解锁此成就所需的阈值。 |

### 配置示例

下面是一个 Achievements Interface 示例配置，其中包含两个不同成就。 第一个成就依赖一个名为 `Total_Distance` 的单一统计数据，它记录玩家移动的总距离（米）。 第二个成就依赖三个不同统计数据解锁： `Distance_Run`, `Distance_Swim`, and `Distance_Cycle`, 均以米为单位。

C++

DefaultEngine.ini

```
[OnlineServices.Stats]
	!StatDefinitions=ClearDefinitions
	+StatDefinitions=(Name=Total_Distance, Id=0, ModifyMethod=Sum)
	+StatDefinitions=(Name=Distance_Run, Id=1, ModifyMethod=Sum)
	+StatDefinitions=(Name=Distance_Swim, Id=2, ModifyMethod=Sum)
	+StatDefinitions=(Name=Distance_Cycle, Id=3, ModifyMethod=Sum)

	[OnlineServices.Achievements]
	bIsTitleManaged=true
	!UnlockRules=ClearRules
```

## 读取

Achievements Interface 的用途是读取成就定义和状态。下面概述读取定义与状态所需步骤。对于代码示例，使用任意 Online Services Interface 查询和获取信息的流程，都与 [Stats Interface](../stats-interface/index.md) 文档中查询和获取统计数据的示例非常相似。

### 成就定义

Achievements Interface 可按以下步骤读取平台服务上配置的任意成就定义：

1. [QueryAchievementDefinitions](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/QueryAchievement-?application_version=5.5) 使用成就定义填充本地接口缓存。
2. [GetAchievementIds](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementIds?application_version=5.5) 检索第 1 步缓存成就的 ID 列表。
3. [GetAchievementDefinition](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementDefinition?application_version=5.5) 获取第 2 步中每个 ID 关联的完整定义。

该 [FAchievementDefintion](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FAchievementDefinition?application_version=5.5) 结构体表示成就定义。对于平台服务管理的成就，该定义包含与成就关联的统计数据及其解锁阈值；超过阈值后，成就会自动解锁。

### 成就状态

按照 [成就定义](index.md) 部分后，使用 `QueryAchievementStates` and `GetAchievementState` 读取玩家成就状态：

1. [QueryAchievementStates](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/QueryAchievementStates?application_version=5.5) 使用成就状态信息填充本地接口缓存。
2. [GetAchievementState](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IAchievements/GetAchievementState?application_version=5.5) 如果成就仍锁定，则检索当前解锁进度；如果成就已解锁，则检索解锁时间。

对于游戏管理的成就，进度是二元值：0.0（锁定）或 1.0（解锁）。对于带有基于统计数据解锁规则的平台服务管理成就，进度可能会准确反映当前成就进度，以 0.0 到 1.0 之间的百分比表示。

## 更多信息

### 头文件

可直接查阅 `Achievements.h` 头文件以按需获取更多信息。 Achievements Interface 头文件 `Achievements.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

有关如何获取 UE 源代码的说明，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数与返回类型

请参阅 Online Services Overview 页面的 [函数](../../overview-of-online-services/index.md#functions) 部分，了解函数参数和返回类型的说明，包括如何传递参数以及如何处理函数返回的结果。

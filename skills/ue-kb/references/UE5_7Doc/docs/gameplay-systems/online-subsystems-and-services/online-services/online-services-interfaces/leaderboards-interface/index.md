---
title: "Leaderboards Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/leaderboards-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Leaderboards Interface"]
---

# Leaderboards Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Leaderboards Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/leaderboards-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

一个 **排行榜** 是按游戏内统计数据对玩家进行排名的列表。排行榜会鼓励玩家与好友以及全球玩家竞争，争取游戏中的最高分。游戏可以包含多个会授予分数的模式，每个模式都可以拥有自己的一个或多个排行榜。

排行榜可以按以下方式对条目排序：

- **升序**：较低分数排名高于较高分数。

  - Fortnite 胜场排行榜按降序组织，因为胜场越多越理想。
- **降序**：较高分数排名高于较低分数。

  - 竞速游戏中的单圈时间排行榜按升序组织，因为单圈时间越短越理想。

该 **Online Services Leaderboards Interface** 为开发者提供了在游戏内显示和更新排行榜的工具。排行榜数据可能非常庞大，因为游戏支持的每个排行榜都可能为玩过游戏的每个用户账户保存一个条目。因此，Leaderboards Interface 会分块检索数据。实现该接口的游戏可以使用下方 [函数](index.md#functions) 部分以及更详细的 [读取排行榜条目](index.md) 部分所述的不同方式，请求排行榜数据块。

## API 概述

### 函数

下表概述 Leaderboards Interface 提供的函数：

| 函数 | 说明 |
| --- | --- |
| [ReadEntriesForUsers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILeaderboards/ReadEntriesForUsers?application_version=5.5) | 读取特定用户的排行榜条目。 |
| [ReadEntriesAroundRank](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILeaderboards/ReadEntriesAroundRank?application_version=5.5) | 读取指定排名索引附近的排行榜条目。 |
| [ReadEntriesAroundUser](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ILeaderboards/ReadEntriesAroundUser?application_version=5.5) | 读取指定用户附近的排行榜条目。 |

### 主要结构体

Leaderboards Interface 的功能主要通过 [FLeaderboardEntry](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/FLeaderboardEntry?application_version=5.5) 结构体传递：

| 成员 | 类型 | 说明 |
| --- | --- | --- |
| `AccountId` | `FAccountId` | 该排行榜条目的账户 ID。 |
| `Rank` | `int32` | 该账户在此排行榜中的排名。 |
| `Score` | `int64` | 该账户在此排行榜中的分数。 |

## 配置

要使用统计数据更新排行榜分数，必须在引擎配置文件中配置 Leaderboards Interface，例如 `DefaultEngine.ini`. Leaderboards Interface 会与 [Stats Interface](../stats-interface/index.md) 协同工作，以跟踪用于排行榜排名的统计数据。

### 通用语法

C++

DefaultEngine.ini

```
[OnlineServices.Leaderboards]bIsTitleManaged=true!LeaderboardDefinitions=ClearDefinitions+LeaderboardDefinitions=(Name=<StatName0>, Id=<Id0>, UpdateMethod=[KeepBest | Force], OrderMethod=[Ascending | Descending])+LeaderboardDefinitions=(Name=<StatName1>, Id=<Id1>, UpdateMethod=[KeepBest | Force], OrderMethod=[Ascending | Descending])...
```

> [!NOTE]
> 为了让排行榜根据统计数据变化进行更新，必须将 `bIsTitleManaged` 标志设为 `true`. 该标志会配置客户端监听 Online Services Stats Interface 的 `FStatsUpdated` 事件，并在统计数据变化时自动更新排行榜。 The `bIsTitleManaged` flag's default value is `false`. 如果不将该标志设为 `true`, 排行榜将不会根据配置于排行榜定义中的统计数据变化自动更新，位置在 `DefaultEngine.ini`.

以下 [排行榜定义](index.md) 表说明如何向引擎配置文件添加排行榜定义。

#### 排行榜定义

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `Name` | `String` | 决定排名的统计数据名称。它必须与 Stats Interface 中配置的统计数据名称相同。 |
| `Id` | `int` | 与该排行榜关联的 ID 编号。它与 Stats Interface 中的统计数据 ID 无关。 |
| `UpdateMethod` | `KeepBest` or `Force` | 用于更新该排行榜条目的方法。 `KeepBest` 保留该统计数据已经达到的最佳值。 `Force` 将排行榜条目更新为最新统计值，不论这会如何改变玩家排名。 |
| `OrderMethod` | `Ascending` or `Descending` | 决定统计值较低还是较高时排名更好。 `Ascending` 表示统计值越低排名越高。 `Descending` 表示统计值越高排名越高。 |

### 配置示例

假设你有一个简单游戏，包含一个名为“Total Game Points”的排行榜，并且该排行榜由 Stats Interface 中配置的同名统计数据跟踪：

C++

DefaultEngine.ini

```
[OnlineServices.Stats]!StatDefinitions=ClearDefinitions+StatDefinitions=(Name=Total_Game_Points, Id=0, ModifyMethod=Sum) [OnlineServices.Leaderboards]bIsTitleManaged=true!LeaderboardDefinitions=ClearDefinitions+LeaderboardDefinitions=(Name=Total_Game_Points, Id=0, UpdateMethod=KeepBest, OrderMethod=Descending)
```

在该配置中，排行榜会：

- 保留 `Total_Game_Points` 统计数据中每位玩家的最佳分数，并且
- 按降序组织，因为总分越高越理想。

## 读取排行榜条目

使用 Leaderboards Interface 读取排行榜条目有三种不同方式。可以按以下方式读取：

- [针对特定用户](index.md)
- [围绕特定排名](index.md)
- [围绕给定用户](index.md)

下面使用 [配置示例](index.md) 中配置的“Total Game Points”排行榜，展示每种方法会检索哪些内容。

### 针对特定用户

使用 `ReadEntriesForUsers` 函数检索特定用户的排行榜条目。 该函数接收一个用户 ID 列表，对应你想查询排名的各个用户。

#### 示例

假设你有如下名为“Total Game Points”的排行榜，并调用 `ReadEntriesForUsers` ，传入以下参数：

C++

```
UE::Online::FReadEntriesForUsers::Params Params;Params.LocalAccountId = "LLV54WB-3C678QQ";Params.AccountIds = {"9P8H4GQ-HNO5GA4", "3CN9H8E-VNO3G3C", "OHB8RA2-OHSEBSE"};Params.BoardName = TEXT("Total Game Points");
```

如果调用成功返回，可以在返回的 `TOnlineResult`:

| Total Game Points |  |  |  |
| --- | --- | --- | --- |
| **账户 ID** | **排名** | **分数** | **已检索？** |
| 3CN9H8E-VNO3G3C | 1 | 1,901 | Y |
| LLV54WB-3C678QQ | 2 | 151 |  |
| OHB8RA2-OHSEBSE | 3 | 17 | Y |
| 9P8H4GQ-HNO5GA4 | 4 | 3 | Y |
| 9HQGQER-ILASDFH | 5 | 1 |  |

### 围绕特定排名

使用 `ReadEntriesAroundRank` 函数检索特定排行榜排名附近的条目。 This function takes in:

- 要开始读取排行榜条目的排名，以及
- 要读取的条目数量上限。

#### 示例

假设你有如下名为 Total Game Points 的排行榜，并调用 `ReadEntriesAroundRank` ，传入以下参数：

C++

```
UE::Online::FReadEntriesAroundRank::Params Params;Params.LocalAccountId = "LLV54WB-3C678QQ";Params.Rank = 2;Params.Limit = 2;Params.BoardName = TEXT("Total Game Points");
```

如果调用成功返回，可以在返回的 `TOnlineResult`:

| Total Game Points |  |  |  |
| --- | --- | --- | --- |
| **账户 ID** | **排名** | **分数** | **已检索？** |
| 3CN9H8E-VNO3G3C | 1 | 1,901 |  |
| LLV54WB-3C678QQ | 2 | 151 |  |
| OHB8RA2-OHSEBSE | 3 | 17 | Y |
| 9P8H4GQ-HNO5GA4 | 4 | 3 | Y |
| 9HQGQER-ILASDFH | 5 | 1 |  |

> [!NOTE]
> 从编程角度看，排行榜顶部条目的排名是 0, not 1. 因此，要检索第三名条目， `ReadEntriesAroundRank` needs to be called with `Params.Rank = 2`.

### 围绕给定用户

使用 `ReadEntriesAroundUser` 函数检索特定用户附近的排行榜条目。 This function takes in:

- 作为读取中心的用户，
- 表示从何处开始读取条目的偏移量，以及
- 要读取的条目总数上限。

> [!NOTE]
> 偏移量可以超过上限。在这种情况下，所提供的用户不会出现在返回的排行榜条目数组中。这在将排行榜条目分页显示时很有用。

#### 示例

假设你有如下名为 Total Game Points 的排行榜，并调用 `ReadEntriesAroundUser` ，传入以下参数：

C++

```
UE::Online::FReadEntriesAroundUser::Params Params;Params.LocalAccountId = "LLV54WB-3C678QQ";Params.Offset = -1;Params.Limit = 3;Params.BoardName = TEXT("Total Game Points");
```

如果调用成功返回，可以在返回的 `TOnlineResult`:

| Total Game Points |  |  |  |
| --- | --- | --- | --- |
| **账户 ID** | **排名** | **分数** | **已检索？** |
| 3CN9H8E-VNO3G3C | 1 | 1,901 | Y |
| LLV54WB-3C678QQ | 2 | 151 | Y |
| OHB8RA2-OHSEBSE | 3 | 17 | Y |
| 9P8H4GQ-HNO5GA4 | 4 | 3 |  |
| 9HQGQER-ILASDFH | 5 | 1 |  |

## 更多信息

### 头文件

可直接查阅 `Leaderboards.h` 头文件以按需获取更多信息。 Leaderboards Interface 头文件 `Leaderboards.h` is located in the directory:

C++

```
UNREAL_ENGINE_ROOT\Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

有关如何获取 UE 源代码的说明，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数与返回类型

请参阅 Online Services Overview 页面的 [函数](../../overview-of-online-services/index.md#functions) 部分，了解函数参数和返回类型的说明，包括如何传递参数以及如何处理函数返回的结果。

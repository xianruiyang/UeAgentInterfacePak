# Stats Interface

---
title: "Stats Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/stats-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Stats Interface"]
---

# Stats Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Stats Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/stats-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services Stats 接口** 用于向在线服务上传统计和数据，并完成统计查询。依赖用户 Gameplay 统计数据的其他接口也会使用 Stats 接口功能，例如 Online Services 的 Achievements 和 Leaderboards 接口。

## API 概述

下表概述 Stats 接口包含的函数。

| 函数 | 说明 |
| --- | --- |
| **更新** |  |
| [UpdateStats](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IStats/UpdateStats?application_version=5.5) | 将统计数据上传到平台。 |
| **查询** |  |
| [QueryStats](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IStats/QueryStats?application_version=5.5) | 查询某个用户的统计数据，并将结果缓存在接口中。 |
| [BatchQueryStats](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IStats/BatchQueryStats?application_version=5.5) | 查询一组用户的统计数据，并将结果缓存在接口中。 |
| **获取** |  |
| [GetCachedStats](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IStats/GetCachedStats?application_version=5.5) | 获取调用 QueryStats 或 BatchQueryStats 后存储的缓存用户统计数据。 |
| **事件监听** |  |
| [OnStatsUpdated](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IStats/OnStatsUpdated?application_version=5.5) | 当用户统计数据发生变化时，会触发一个事件。 |

## 配置

可以将 Stats 接口与对应的平台后端或 `StatsNull` 实现配合使用。要使用 Stats 接口，必须先在 `DefaultEngine.ini` 文件中配置 Stats 接口：

C++

DefaultEngine.ini

```
[OnlineServices.Stats]+StatDefinitions=(Name=<STAT_NAME>, Id=<ID_NUMBER>, ModifyMethod=<METHOD>, DefaultValue="<TYPE>:<DEFAULT_VALUE>")
```

**统计定义** 包含以下字段：

- `Name`：统计项名称。

  - 这是通过 `UpdateStats` 和 `QueryStats` 分别更新和查询统计数据时使用的名称。
- `Id`：统计项 ID。

  - 这是平台门户中配置的对应统计项 ID。
- `ModifyMethod`：规定统计项如何更新的方法。

  - 对于非`StatsNull` 实现，Modify Method 在平台门户中配置。
  - 使用 Title Managed achievements 时，所有实现中的 Achievements 接口都会使用 Modify Method，判断成就是否满足规定的解锁规则。
- `DefaultValue`：统计项的类型和默认值。

  - 它规定统计项的初始值。

要使用统计数据解锁成就并更新排行榜，必须在 Achievements 和 Leaderboards 配置段中指定对应统计项，文件为 `DefaultEngine.ini`.

### 配置示例

下面是 Online Services Stats 接口的配置示例：

C++

DefaultEngine.ini

```
[OnlineServices.Stats]+StatDefinitions=(Name=Stat_Use_Largest, Id=0, ModifyMethod=Largest, DefaultValue="Int64:0")+StatDefinitions=(Name=Stat_Use_Smallest, Id=1, ModifyMethod=Smallest, DefaultValue="Int64:999")+StatDefinitions=(Name=Stat_Use_Set, Id=2, ModifyMethod=Set, DefaultValue="Int64:0")+StatDefinitions=(Name=Stat_Use_Sum, Id=3, ModifyMethod=Sum, DefaultValue="Int64:0")+StatDefinitions=(Name=Stat_Type_Bool, Id=4, ModifyMethod=Set, DefaultValue="Bool:True")+StatDefinitions=(Name=Stat_Type_Double, Id=5, ModifyMethod=Smallest, DefaultValue="Double:9999.999")
```

## 示例

本节包含多种代码示例，指导你如何：

- [查询统计数据](index.md)
- [获取缓存统计数据](index.md)
- [监听事件](index.md)
- [执行控制台命令](index.md)

### 查询统计数据

C++

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::IStatsPtr Stats = OnlineServices->GetStatsInterface();

UE::Online::FQueryStats::Params Params;
Params.LocalAccountId = LocalAccountId;
Params.TargetAccountId = TargetAccountId;
Params.StatNames = {"StatA", "StatB"};

// See Note below Walkthrough for more information about this OnComplete call
Stats->QueryStats(MoveTemp(Params)).OnComplete([](const UE::Online::TOnlineResult<FQueryStats>& Result)
```

#### 演练

1. 通过调用以下内容使用默认在线服务： `GetServices` 且不指定任何参数：

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
   ```
2. 访问默认在线服务的 Stats 接口：

   C++

   ```
   UE::Online::IStatsPtr Stats = OnlineServices->GetStatsInterface();
   ```
3. 实例化查询以下内容所需的参数： `StatNames` ，目标为 `TargetAccountId`:

   C++

   ```
   UE::Online::FQueryStats::Params Params;     Params.LocalAccountId = LocalAccountId;     Params.TargetAccountId = TargetAccountId;     Params.StatNames = {"StatA", "StatB"};
   ```
4. 处理 `QueryStats.OnComplete` 回调，处理错误或查询到的统计数据：

   C++

   ```
   Stats->QueryStats(MoveTemp(Params)).OnComplete([](const UE::Online::TOnlineResult<FQueryStats>& Result)
        {
            if (Result.IsError())
            {
                const UE::Online::FOnlineError OnlineError = Result.GetErrorValue();
                // Process OnlineError
                return;
            }
            const UE::Online::FQueryStats::Result QueriedStats = Result.GetOkValue();
            // Process QueriedStats
   ```

> [!NOTE]
> 绑定到成员函数时，应始终优先使用 UObject 派生类，或继承自 `TSharedFromThis` 的类，并使用
>
> C++
>
> ```
> .OnComplete(this, &MyClass::OnQueryStatsComplete)
> ```
>
> 这会自动选择 `CreateUObject`, `CreateThreadSafeSP`或 `CreateSP`，并使用最安全的委托创建调用。更多信息请参阅 [回调格式](https://dev.epicgames.com/documentation/assets/programming-and-scripting/online/online-services/overview#CallbackFormat) 章节，该章节位于 Online Services Overview 页面。

### 获取缓存统计数据

C++

```
UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();
UE::Online::IStatsPtr Stats = OnlineServices->GetStatsInterface();

UE::Online::TOnlineResult<FGetCachedStats> CachedStats = Stats->GetCachedStats({});
if (CachedStats.IsError())
{
	UE::Online::FOnlineError OnlineError = CachedStats.GetErrorValue();
	// Process OnlineError
	return;
}
```

#### 演练

1. 通过调用以下内容使用默认在线服务： `GetServices` 且不指定任何参数，然后访问 Stats 接口：

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();     UE::Online::IStatsPtr Stats = OnlineServices->GetStatsInterface();
   ```
2. 通过 Stats 接口使用以下内容获取缓存统计数据： `Stats->GetCachedStats`:

   C++

   ```
   UE::Online::TOnlineResult<UE::Online::FGetCachedStats> CachedStats = Stats->GetCachedStats({});
   ```
3. 处理 `CachedStats` 处理错误或缓存统计数据：

   C++

   ```
   if (CachedStats.IsError())     {         UE::Online::FOnlineError OnlineError = CachedStats.GetErrorValue();         // Process OnlineError         return;		     }     UE::Online::FGetCachedStats::Result& CachedStatsData = CachedStats.GetOkValue();     // Process CachedStatsData
   ```

### 监听事件

事件监听的处理方式不同于同步和异步函数。需要创建一个 `FOnlineEventDelegateHandle` 来处理以下事件的结果： `OnStatsUpdated` 事件，然后 `Unbind` 必须在关闭代码中调用，以确保正确销毁。

#### 演练

1. 在类中为 Stats 接口声明事件句柄。

   C++

   ```
   UE::Online::FOnlineEventDelegateHandle StatEventHandle;
   ```
2. 在初始化代码中初始化默认在线服务，访问 Stats 接口，并在事件发生时处理统计数据。

   C++

   ```
   UE::Online::IOnlineServicesPtr OnlineServices = UE::Online::GetServices();     UE::Online::IStatsPtr Stats = OnlineServices->GetStatsInterface();     StatEventHandle = Stats->OnStatsUpdated().Add([](const UE::Online::FStatsUpdated& StatsUpdated)     {         // custom logic inside this lambda     });
   ```
3. 确保在关闭代码中解绑事件处理器。

   C++

   ```
   StatEventHandle.Unbind();
   ```

### 执行控制台命令

关于使用控制台命令运行异步接口的通用命令行语法，请参阅 [Online Services 概述](../../overview-of-online-services/index.md) 文档。

#### 示例

要运行 `QueryStats` 函数，请执行以下控制台命令：

C++

```
OnlineServices Index=0 Stats QueryStats 0 0 ["StatA", "StatB"]
```

此命令会调用 `QueryStats` ，使用默认在线服务和第 0 个本地用户访问 Stats 接口。具体来说，上述命令会向默认在线服务查询该用户的 `StatA` 和 `StatB` 。

## 重置统计数据

在开发和测试期间， `ResetStats` 函数会重置当前 title 提供的所有玩家统计数据。尽管不同在线服务的策略不同，但不应期望该函数在测试环境之外可用。请务必移除任何使用 `ResetStats` 的代码，不要让其进入 shipping 构建；或使用编译期逻辑像这样屏蔽代码：

C++

```
#if !UE_BUILD_SHIPPING// Code block with call to ResetStats#endif
```

## 更多信息

### 头文件

可按需直接查看 `Stats.h` 头文件以获得更多信息。Stats 接口头文件 `Stats.h` 位于以下目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

关于如何获取 UE 源代码的说明，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 [函数](../../overview-of-online-services/index.md#functions) 章节，该章节位于 Online Services Overview 页面，其中解释了函数参数和返回类型，包括如何传递参数以及函数返回时如何处理结果。


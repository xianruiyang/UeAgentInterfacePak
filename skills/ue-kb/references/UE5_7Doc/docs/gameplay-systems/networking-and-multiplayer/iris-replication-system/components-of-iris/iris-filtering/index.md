---
title: "筛选"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/iris-filtering-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "Iris复制系统", "Iris组件", "筛选"]
---

# 筛选

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / Iris复制系统 / Iris组件 / 筛选

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/iris-filtering-in-unreal-engine

**Iris筛选系统（Iris Filtering System）** 将确定哪些对象应该被复制到哪些连接。对于游戏中的某些Actor或对象，你可能只想将其复制到特定连接。为了节省时间和带宽，筛选系统会筛选一个Actor或对象可以被复制哪些连接。筛选系统支持四种不同的筛选类型：

- 所有者

  ：对象将被复制到与其所有者相同的连接。
- 连接

  ：对象将被复制到允许的指定连接，不会被复制到不允许的指定连接。
- 群组

  ：对象将被复制到与其群组中其他所有对象相同的连接。
- 动态

  ：对象将基于自定义的动态筛选来复制。

## 所有者

`bOnlyRelevantToOwner` 标记被设置为 `true` 的Actor会自动启用所有者筛选。你还可以为Actor之外的独立对象启用所有者筛选。

### 为对象设置所有者筛选器

要为Actor之外的对象启用所有者筛选，请执行以下步骤：

1. 包含必要的Iris文件以便访问所需的Iris功能。

   ```
            #if UE_WITH_IRIS         #include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"         #include "Iris/ReplicationSystem/ReplicationSystem.h"         #include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"         #include "Net/Iris/ReplicationSystem/Filtering/NetObjectFilter.h"         #endif UE_WITH_IRIS
   ```
2. 在Gameplay代码中为你复制的对象检索复制系统以及复制桥。

   ```
            // 你想要控制筛选的Actor         AActor* RepActorPtr;		         UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);         UActorReplicationBridge* ReplicationBridge = UE::Net::FReplicationSystemUtil::GetActorReplicationBridge(RepActorPtr);
   ```
3. 检索复制的对象的 `FNetRefHandle`。Iris会使用此标识符在复制系统中找到你的对象。

   ```
            UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPtr);
   ```
4. 为你复制的对象设置所有者筛选器。

   ```
            ReplicationSystem->SetFilter(RepActorNetHandle, UE::Net::ToOwnerFilterHandle);
   ```

> [!TIP]
> 你应该在分配对象的所有者之后，立即分配所有者过滤器。

### 清除所有筛选器

要清除复制的对象上的所有筛选器，请先执行[为对象设置所有者筛选器](#%E4%B8%BA%E5%AF%B9%E8%B1%A1%E8%AE%BE%E7%BD%AE%E6%89%80%E6%9C%89%E8%80%85%E7%AD%9B%E9%80%89%E5%99%A8)中的第1步和第2步，然后将筛选器设置为使用以下特殊筛选器句柄：

```
	#if UE_WITH_IRIS	#include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"	#include "Net/Iris/ReplicationSystem/Filtering/NetObjectFilter.h"	#endif UE_WITH_IRIS 	UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);	UActorReplicationBridge* ReplicationBridge = UE::Net::FReplicationSystemUtil::GetActorReplicationBridge(RepActorPtr); 	UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPtr); 	// 将筛选器设置为使用特殊的无效句柄	ReplicationSystem->SetFilter(RepActorNetRefHandle, UE::Net::InvalidNetObjectFilterHandle);
```

## 连接

你可以通过指定连接ID来设置对象要复制到的连接。我们建议在以下情况下使用此选项：

- 所述对象的允许连接是静态的，并且……
- 如果连接ID出于某种原因发生更改，只会影响到少数几个对象。

如果可能会影响到大量对象，请考虑改用群组筛选。利用连接筛选，你可以向对象添加允许或不允许的连接。

### 设置连接筛选器

要添加允许的连接，请执行以下操作：

1. 为允许对象复制到的所有连接设置位
2. 使用最大数量的允许连接初始化连接，然后再设置连接筛选器。

   ```
            #if UE_WITH_IRIS         #include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"         #include "Iris/ReplicationSystem/ReplicationSystem.h"         #include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"         #include "Net/Iris/ReplicationSystem/Filtering/NetObjectFilter.h"         #endif UE_WITH_IRIS		         UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);         UActorReplicationBridge* ReplicationBridge = UE::Net::FReplicationSystemUtil::GetActorReplicationBridge(RepActorPtr);		         UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPtr);		         int32 MaxConnections = 100;		         TBitArray<> Connections;         Connections.Init(false, MaxConnections);		         // PlayerControllerPtr是你想要允许复制的连接的玩家控制器         uint32 ConnectionId = PlayerControllerPtr->GetNetConnection()->GetConnectionId();         Connections.Insert(true, ConnectionId);		         ReplicationSystem->SetConnectionFilter(RepActorNetRefHandle, Connections, UE::Net::ENetFilterStatus::Allow);
   ```

类似逻辑也适用于添加不允许的连接，但不能使用 `ENetFilterStatus::Allow` ，而是使用 `ENetFilterStatus::Disallow` 值。在此情况下，提供的连接将是不允许对象复制到的连接。

### 清除连接筛选器

对象的连接筛选器的清除方式不同于所有者筛选器。要清除对象的连接筛选器，请设置不允许的连接筛选器，但不能将提供的连接指定为不允许：

```
	#if UE_WITH_IRIS	#include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"	#include "Net/Iris/ReplicationSystem/Filtering/NetObjectFilter.h"	#endif UE_WITH_IRIS 	UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);	UActorReplicationBridge* ReplicationBridge = UE::Net::FReplicationSystemUtil::GetActorReplicationBridge(RepActorPtr); 	UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPtr); 	TBitArray<> NoConnections; 	ReplicationSystem->SetConnectionFilter(ObjectNetHandle, NoConnections, UE::Net::ENetFilterStatus::Disallow);
```

## 群组

Iris包括一个API，用于创建群组并管理这些群组包含的对象。你还可以将群组用作筛选机制。这可用于灵活地更改一组对象可以被复制到哪些连接，而不需要手动跟踪哪些对象属于哪些群组。示例用例包括基于以下条件筛选：

- 团队
- 小组
- 流送关卡

一个对象可以属于多个群组。你必须将群组添加到筛选系统，系统才会考虑将其用于复制。添加之后，你可以修改允许群组的哪些连接成员复制。你可以针对以下情况将群组设置为允许或不允许：

- 复制到单个连接
- 复制到一组连接
- 复制到所有连接

### 创建群组

要创建筛选器群组，请调用 `CreateGroup` 函数，它将返回唯一的群组句柄：

```
	#if UE_WITH_IRIS	#include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#endif UE_WITH_IRIS 	UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);	UE::Net::FNetObjectGroupHandle GroupHandle = ReplicationSystem->CreateGroup();
```

### 添加群组筛选器

你必须将群组筛选器添加到筛选系统，然后才能设置筛选器状态并添加对象：

```
	#if UE_WITH_IRIS	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#endif UE_WITH_IRIS 	// 添加有效的FNetObjectGroupHandle	ReplicationSystem->AddGroupFilter(GroupHandle);
```

### 设置群组筛选

创建群组并将群组筛选器添加到复制系统之后，你可以设置群组筛选。在此示例中，允许属于带有句柄 `GroupHandle` 的群组的对象仅复制到带有ID `SpecialConnectionId` 的连接：

```
	#if UE_WITH_IRIS	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#include "Net/Iris/ReplicationSystem/Filtering/NetObjectFilter.h"	#endif UE_WITH_IRIS 	// 使用有效的FNetObjectGroupHandle和UNetConnection以及uint32连接id	ReplicationSystem->SetGroupFilterStatus(GroupHandle, SpecialConnectionId, UE::Net::ENetFilterStatus::Allow);
```

### 将对象添加到群组

你现在可以将所需对象添加到群组：

```
	#if UE_WITH_IRIS	#include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"	#include "Iris/ReplicationSystem/ReplicationSystem.h"	#endif UE_WITH_IRIS 	UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPtr); 	// 使用有效的FNetObjectGroupHandle和FNetHandle	ReplicationSystem->AddToGroup(GroupHandle, RepActorNetRefHandle);
```

## 动态

Iris的筛选系统还可以使用从 `UNetObjectFilter` 派生的类实现自定义的动态筛选。动态筛选器可以基于自定义逻辑禁止对象复制。动态筛选器在连接和群组筛选器之后应用。这意味着，动态筛选器不能为已经被连接或群组筛选器筛选掉的对象启用复制。一个对象一次只能设置一个动态筛选器。

动态筛选器始终会在对象上运行，而连接和群组筛选仅在系统被告知更改时运行。这是因为动态筛选器可以按任意方式实现，因此系统无法知道动态筛选器是否需要运行。在一些情况下，动态筛选器可提供最佳的解决方案。如果你经常修改群组，例如在群组之间移动Actor，或更改群组可以复制到哪些连接，则动态筛选器可以提供最佳的解决方案。

> [!WARNING]
> 为对象设置动态筛选器只能作为最后的手段。相比于连接和群组筛选器，这会显著增加CPU开销。

UE在目录 `..\Engine\Source\Runtime\Experimental\Iris\Core\Public\Iris\ReplicationSystem\Filtering\` 中提供了一些动态筛选器：

- UFilterOutNetObjectFilter

  ：不允许复制添加进来的任何对象。
- UNetObjectConnectionFilter

  ：支持按连接筛选依赖对象的轮询前筛选器。
- UNetObjectGridFilter

  ：将游戏世界划分为多个单元，仅复制玩家视野附近的单元中的对象。

要使用自定义的动态筛选器，你必须实现 `UNetObjectFilter` 接口，并且它必须使用筛选器定义配置才能在运行时使用。

### 创建动态筛选器

要使用自定义的动态筛选器，请实现 `UNetObjectFilter` 接口，并配置其筛选器定义，以在运行时使用筛选器。你必须从中继承自定义筛选器的基类位于以下文件路径：

- ..\Engine\Source\Runtime\Experimental\Iris\Core\Public\Iris\ReplicationSystem\Filtering\NetObjectFilter.h

以下位置提供了自定义的动态筛选器的极简可用示例：

- ..\Engine\Source\Runtime\Experimental\Iris\Core\Public\Iris\ReplicationSystem\Filtering\NopNetObjectFilter.h

### 动态筛选器配置

下面是引擎配置使用自定义动态筛选器的语法：

```
	[/Script/IrisCore.NetObjectFilterDefinitions]	+NetObjectFilterDefintions=(FilterName=<FILTER_NAME>, ClassName=/Script/<PROJECT_NAME>.<FILTER_NAME>, ConfigClassName=/Script/<PROJECT_NAME>.<FILTER_NAME>Config)
```

例如，名为 `MyProject` 的项目中名为 `MyCustomFilter` 的自定义动态筛选器在引擎配置层级（例如你的项目的 `DefaultEngine.ini` 文件）中按如下所示配置：

```
	[/Script/IrisCore.NetObjectFilterDefinitions]	+NetObjectFilterDefintions=(FilterName=MyCustomFilter, ClassName=/Script/MyProject.MyCustomFilter, ConfigClassName=/Script/MyProject.MyCustomFilterConfig)
```

向Iris注册筛选器后，你可以在引擎配置文件（例如你的项目的 `DefaultEngine.ini` 文件）中按如下所示配置筛选器：

```
	[/Script/MyProject.MyCustomFilterConfig]	MyCustomFilterVar=100
```

### 将对象分配给动态筛选器

要将动态筛选器分配给复制的对象，使用以下内容：

```
	const UE::Net::FNetObjectFilterHandle FilterHandle = ReplicationSystem->GetFilterHandle(FName("<FILTER_NAME>"));	if (FilterHandle != UE::Net::InvalidNetObjectFilterHandle)	{		const bool bSuccess = ReplicationSystem->SetFilter(ObjectNetHandle, FilterHandle);	}
```

### 删除动态筛选器

动态筛选器的删除方式与所有者筛选器相同。要删除筛选器，请参阅此页面的[清除所有筛选器](#%E6%B8%85%E9%99%A4%E6%89%80%E6%9C%89%E7%AD%9B%E9%80%89%E5%99%A8)小节。

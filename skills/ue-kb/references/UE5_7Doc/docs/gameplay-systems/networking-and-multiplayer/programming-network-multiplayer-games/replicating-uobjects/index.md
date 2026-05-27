---
title: "复制子对象"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/replicating-uobjects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "复制子对象"]
---

# 复制子对象

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / 复制子对象

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/replicating-uobjects-in-unreal-engine

**虚幻引擎（UE）** 中的 **复制子对象（Replicated Subobjects）** 可用于复制从UObject派生的类及其包含的复制属性。之前用于复制组件和子对象的系统使用了虚拟函数 `AActor::ReplicateSubobjects`。利用新系统，Actor现在有方法将子对象注册到所属 **Actor** 或 **Actor组件（Actor Component）** 上的列表，并由Actor通道自动处理这些注册子对象的复制工作。

我们将在下文中解释这两个系统。首先，我们详细介绍使用 `ReplicateSubobjects` 函数的两个例子。然后，我们介绍新的 **注册子对象列表（Registered Subobjects List）** ，并详细介绍一些代码示例，概述其用法。最后，我们会探讨其他主题，例如[复杂复制条件](#%E5%A4%8D%E6%9D%82%E5%A4%8D%E5%88%B6%E6%9D%A1%E4%BB%B6)和维护[客户端上的注册子对象列表](#%E5%AE%A2%E6%88%B7%E7%AB%AF%E5%AD%90%E5%AF%B9%E8%B1%A1%E5%88%97%E8%A1%A8)。

## 复制子对象概述

之前用于复制组件和子对象的系统依赖虚拟函数 `AActor::ReplicateSubobjects`。对于有复制子对象的Actor，需要将该函数覆盖掉，Actor必须对其每个复制组件或子对象手动调用 `ReplicateSubobject` 和 `ReplicateSubobjects`。考虑以下例子：

### 代码示例

```
	class AMyActor : public AActor	{		UPROPERTY(Replicated)		UMySubObjectClass* MySubObject;	} 	class UMySubObjectClass : public UObject	{		UPROPERTY(Replicated)		int32 Counter = 0;	} 	void AMyActor::CreateMyClass()	{		MySubObject = NewObject<UMySubObjectClass>();		MySubObject->Counter = 10;	} 	void AMyActor::ReplicateSubobjects(...)	{		Super::ReplicateSubobjects(...);		Channel->ReplicateSubobject(MySubObject); // 这里变为子对象	} 
```

#### 操作说明

在上方代码示例中，Actor使 `MySubObject` 的内容成为了 `ReplicateSubobjects` 函数中的子对象。在该阶段，指针可进行net引用。然后，`Counter` 变量会在每次复制Actor时复制到客户端。如果我们没有通过 `Channel->ReplicateSubobject(MySubObject)` 使 `MySubObject` 成为子对象，`MySubObject` 变量在客户端上始终会是 `null`。

### 代码示例

```
	class UMyDerivedSubObjectClass : public UMySubObjectClass	{		UProperty(Replicated)		float Timer;	} 	void AMyActor::CreateMyDerivedClass()	{		MySubObject = NewObject<UMyDerivedSubObjectClass>();		MySubObject->Counter = 100;		Cast<UMyDerivedSubObjectClass>(MySubObject)->Timer = 60;	} 
```

#### 操作说明

假设 `CreateMyDerivedClass()` 在 `CreateMyClass()` 之后调用。新指针在下次调用 `ReplicateSubObjects` 时变为复制子对象。在客户端，`MySubObject` 变量发生更改，现在类型是 `UMyDerivedSubObjectClass`，其 `Timer` 和 `Counter` 变量都复制到客户端。

## 注册子对象列表概述

Actor现在有方法将子对象注册到所属Actor或Actor组件上的列表，并由Actor通道自动处理这些注册子对象的复制工作。注册子对象列表允许在注册子对象时为其指定 `ELifetimeCondition`。该过程可更好地控制何时将子对象复制到何处，而无需用户在 `ReplicateSubobjects` 中实现此逻辑。此外，Actor也无需实现虚拟函数 `AActor::ReplicateSubobjects` 并手动复制单独的子对象。

## 使用注册子对象列表

以下代码示例概述了如何启用注册子对象列表。

#### 代码示例

```
	AMyActor::AMyActor()	{		bReplicateUsingRegisteredSubObjectList = true;	} 	void AMyActor::CleanupSubobject()	{		if (MySubobject)		{			RemoveReplicatedSubobject(MySubObject);		}	} 	void AMyActor::CreateMyClass()	{		CleanupSubobject(); 		MySubObject= NewObject<UMySubObjectClass>();		MySubObject->Counter = 10;		AddReplicatedSubObject(MySubObject);	} 	void AMyActor::CreateMyDerivedClass()	{		CleanupSubobject(); 		MySubObject = NewObject<UMyDerivedSubObjectClass>();		AddReplicatedSubObject(MySubObject);	} 	void AMyActor::ReplicateSubobjects(...)	{		//已废弃，不再调用	} 
```

##### 操作说明

1. 为你的Actor类设置属性 `bReplicateUsingRegisteredSubObjectList = true` 。

   ```
            AMyActor::AMyActor()         {             bReplicateUsingRegisteredSubObjectList = true;         }		
   ```
2. 在 `ReadyForReplication`、`BeginPlay` 中或在创建新的子对象时调用 `AddReplicatedSubObject` 。在Actor组件类中使用复制子对象时要记住几点。在Actor组件类中，`ReadyForReplication` 在 `InitComponent` 和 `BeginPlay` 之间调用。这里注册组件后，该组件就可以在组件的 `BeginPlay` 中及早调用远程程序调用（RPC）。
3. 每当你修改或删除子对象时，请调用 `RemoveReplicatedSubObject` 。

   ```
            void AMyActor::CleanupSubObject()         {             if (MySubObject)             {                 RemoveReplicatedSubObject(MySubObject)             }         }		
   ```

   > [!WARNING]
   > 这最后一步非常重要。除非删除引用，否则列表仍包含指向已更改或标记为破坏的子对象的原始指针。因此，这会在对象被垃圾回收之后导致崩溃。

> [!TIP]
> 转换现有代码时，可以设置 `net.SubObjects.CompareWithLegacy` 控制台变量（CVar），从而在运行时比较新列表与旧方法。这会在检测到差异时触发ensure语句。

## 复制Actor组件

使用此系统的 **复制Actor组件（Replicated Actor Components）** 的处理方式与上面相同，因为它们也是复制子对象。要为Actor组件设置复制条件，所属Actor类必须实现 `AllowActorComponentToReplicate` 并返回特定组件所需的 `ELifetimeCondition` 。可以调用 `SetReplicatedComponentNetCondition` ，在 `BeginPlay` 之后直接更改组件的条件。

> [!WARNING]
> 确保 `AllowActorComponentToReplicate` 返回新条件；否则，如果对Actor调用了 `UpdateAllReplicatedComponents` ，将重置该条件。

### 将复制子对象用于Actor组件

#### 代码示例

```
	ELifetimeCondition AMyWeaponClass::AllowActorComponentToReplicate(const UActorComponent* ComponentToReplicate) const	{		// 不要在对象在地面时复制一些组件。		if (!bIsInInventory)		{			if (IsA<UDamageComponent>(ComponentToReplicate))			{				return COND_Never;			}		}		Super::AllowActorComponentToReplicate(ComponentToReplicate);	} 	void AMyWeaponClass::OnPickup()	{		// 现在将组件复制到全部		SetReplicatedComponentNetCondition(UDamageComponent, COND_None);		bIsInInventory = true;	} 
```

##### 操作说明

在上面的例子中，所属Actor类是 `AMyWeaponClass` 。我们需要根据武器当前是否在Actor的物品栏中，来设置 `UActorComponent ComponentToReplicate` 的复制条件。为完成该操作，所属Actor类 `AMyWeaponClass` 实现了 `AllowComponentToReplicate` 。

武器在地面时，它不在Actor的物品栏中。因此，我们不希望复制的组件会带来伤害。这种情况下返回的 `ELifetimeCondition` 是 `COND_Never` ，它会指定永不复制这些组件。我们想更改伤害组件的条件时，例如武器被捡起时，会直接调用 `SetReplicatedComponentCondition` ，将复制条件设置为 `COND_None` ，这表示始终会复制组件。

有关 `ELifetimeCondition` 支持的条件列表的更多信息，请参阅[条件属性复制](https://dev.epicgames.com/documentation/404)。

### Actor组件子对象列表

Actor组件还可以有自己的复制子对象列表。它们使用与Actor相同的API来注册和注销其子对象。Actor组件中的子对象还可以有复制条件。

所属组件必须在检查其复制子对象的条件之前复制到连接。例如，如果子对象有 `COND_OwnerOnly` 条件，当它注册到使用 `COND_SkipOwner` 条件的组件时，绝不会复制该子对象。

## 复杂复制条件

复制子对象系统支持为子对象创建自定义复制条件。这通过 `NetConditionGroupManager` 和 `COND_NetGroup` 来完成。子对象和玩家控制器可以同时属于多个组。在这种情况下，主体在属于客户端的至少一个组时会复制到客户端。

### 实现和使用复制组

1. 使用

   COND_NetGroup

   条件注册子对象。
2. 创建将表示复制条件的FName。

   ```
            FName NetGroupAlpha(TEXT("NetGroup_Alpha"))		
   ```
3. 将所需子对象添加到复制组。

   ```
            FNetConditionGroupManager::RegisterSubObjectInGroup(MyAlphaSubObject, NetGroupAlpha)		
   ```
4. 在相同组中添加我们想将子对象复制到的客户端。这通过使用客户端的 `PlayerController` 来完成。

   ```
            PlayerControllerAlphaOwner->IncludeInNetConditionGroup(NetGroupAlpha)		
   ```

现在，每当所属Actor复制到该连接时，`PlayerControllerAlphaOwner` 的客户端都会收到该特殊子对象。

## 客户端子对象列表

虽然服务器必须维护复制子对象列表，但客户端上的Actor和组件还应该在本地维护其子对象列表。如果项目在客户端上录制重播，这样做尤其重要。在这种情况下，在将Actor录制到重播中时，客户端上的Actor会临时交换到本地权威角色。因此，无论本地NetRole是什么，录制重播的Actor都应该在客户端上维护其子对象列表。

如果相关子对象是复制属性，可以将RepNotify函数用于该属性，更轻松地管理客户端上的子对象列表。客户端可以使用RepNotify来识别子对象何时发生更改，这样可以删除旧的子对象指针并添加新指针。

虽然从服务器上的列表删除子对象并不会导致将该对象的复制属性发送到客户端，但子对象的指针仍可进行net引用，直至UObject本身被标记为垃圾为止。服务器检测到UObject无效之后，就会在下一次反射更新时通知客户端在本地删除子对象。

> [!WARNING]
> 复制子对象列表系统不支持 `UActorChannel::KeyNeedsToReplicate()`。我们推荐为子对象的复制属性改用推送模型复制。将推送模型复制用于新系统应该至少与使用RepKeys一样高效。

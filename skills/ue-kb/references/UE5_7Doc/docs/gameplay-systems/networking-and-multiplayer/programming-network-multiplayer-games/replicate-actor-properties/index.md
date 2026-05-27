---
title: "复制Actor属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/replicate-actor-properties-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "复制Actor属性"]
---

# 复制Actor属性

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / 复制Actor属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/replicate-actor-properties-in-unreal-engine

在多人游戏中，你的虚幻引擎类中可能有需要复制的属性。虚幻引擎Actor使用 `Replicated` 和 `ReplicatedUsing` 元数据说明符维护所有[属性](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties)的列表。在多人Gameplay中，当属性被带有 `Replicated` 或 `ReplicatedUsing` 元数据说明符标记时，服务器会在复制的属性每次更改其值时向每个连接的客户端发送更新。每个客户端会将更新的值应用到其本地版本的Actor。

本页面包括以下操作的相关信息：

- 复制Actor属性
- 添加复制条件
- 自定义条件复制
- 复制对象引用

## 复制Actor属性

一般来说，复制Actor属性的途径主要有两个：

- Replicated
- ReplicatedUsing

这些是虚幻引擎的反射系统使用的两个属性元数据说明符。`Replicated` 属性为属性复制提供了指定特定条件的选项，将属性复制限制在特定连接上。你也可以设置自定义复制条件，为属性复制定义自己的逻辑。`ReplicatedUsing` 属性需要你提供RepNotify函数，当相关属性被复制时，客户端就会调用该函数。

你还可以使用 `NotReplicated` 说明符指定 *不* 复制的属性。此说明符可能一开始看起来没什么用，但在将要复制的结构体中某个属性设置为不复制时非常有用。

### 添加Replicated属性

假设你有一个从 `AActor` 派生的类，名为 `ADerivedActor` ，此类有一个你需要复制的属性 `Health` 。要使用 `Replicated` 说明符复制Actor属性，请执行以下步骤：

1. 在你的 `DerivedActor.h` 文件中，将 `Replicated` 元数据说明符添加到你的 `Health` 属性：

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     // 要复制的属性     UPROPERTY(Replicated)     uint32 Health;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP); };
   ```
2. 确保将 `ADerivedActor` 设置为在派生的Actor的构造函数中复制：

   DerivedActor.cpp

   ```
    #include "DerivedActor.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }
   ```
3. 重载 `GetLifetimeReplicatedProps` 函数并添加宏调用，以在派生的Actor实例的生命周期内复制 `Health` 属性：

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     // 要复制的属性     UPROPERTY(Replicated)     uint32 Health;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP);      // 重载复制属性函数     virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override; };
   ```

   DerivedActor.cpp

   ```
    #include "DerivedActor.h" #include "Net/UnrealNetwork.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }  void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const {     // 调用Super     Super::GetLifetimeReplicatedProps(OutLifetimeProps);      // 添加要为派生的类复制的属性     DOREPLIFETIME(ADerivedActor, Health); }
   ```

### 添加Replicated Using属性

如上所示，你可以使用 `UPROPERTY` 宏中的 `Replicated` 说明符复制Actor属性。你可以使用 `ReplicatedUsing` 说明符在每次复制变量时执行特定操作。要在每次复制你的属性时执行操作，你可以使用 `ReplicatedUsing` 说明符和相关联的RepNotify。**RepNotify** 是复制带 `ReplicatedUsing` 说明符的属性时对客户端调用的 `OnRep_` 函数。

假设你有一个从 `AActor` 派生的类，名为 `ADerivedActor` ，此类有一个你需要复制的属性 `Health` 。要将属性指定为 `ReplicatedUsing` 属性，请执行以下步骤：

1. 在你的 `DerivedActor.h` 文件中，将 `ReplicatedUsing` 元数据说明符添加到你的 `Health` 属性。在此元数据中，你必须指定在此属性复制时调用的函数的名称。此RepNotify函数名称的格式是 `OnRep_` 后跟你选定的函数名称。

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     // 要使用RepNotify复制的属性     UPROPERTY(ReplicatedUsing=OnRep_HealthUpdate)     uint32 Health;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP); };
   ```
2. 确保将 `ADerivedActor` 设置为在派生的Actor的构造函数中复制：

   DerivedActor.cpp

   ```
    #include "DerivedActor.h" #include "Net/UnrealNetwork.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }
   ```
3. 重载 `GetLifetimeReplicatedProps` 函数并添加宏调用，以在派生的Actor实例的生命周期内复制 `Health` 属性：

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     // 要使用RepNotify复制的属性     UPROPERTY(ReplicatedUsing=OnRep_HealthUpdate)     uint32 Health;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP);      // 重载复制属性函数     virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override; };
   ```

   DerivedActor.cpp

   ```
    #include "DerivedActor.h" #include "Net/UnrealNetwork.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }  void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const {     // 调用Super     Super::GetLifetimeReplicatedProps(OutLifetimeProps);      // 添加要为派生的类复制的属性     DOREPLIFETIME(ADerivedActor, Health); }
   ```
4. 实现属性的关联RepNotify：

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     // 要使用RepNotify复制的属性     UPROPERTY(ReplicatedUsing=OnRep_HealthUpdate)     uint32 Health;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP);      // 重载复制属性函数     virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;      // Health的关联RepNotify     UFUNCTION()     void OnRep_HealthUpdate(); };
   ```

   DerivedActor.cpp

   ```
    #include "DerivedActor.h" #include "Net/UnrealNetwork.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }  void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const {     // 调用Super     Super::GetLifetimeReplicatedProps(OutLifetimeProps);      // 添加要为派生的类复制的属性     DOREPLIFETIME(ADerivedActor, Health); }  void ADerivedActor::OnRep_HealthUpdate() {     UE_LOG(LogTemp, Log, TEXT("OnRep_HealthUpdate"))      // 添加自定义OnRep逻辑 }
   ```

#### RepNotify中参数的用法

虚幻引擎的复制系统支持在属性的RepNotify中传递类型与复制的属性相同的参数。如果你在RepNotify中传递参数，复制系统会自动将复制属性的上一个值传递到RepNotify调用中。要将上一个复制的属性值传递到 `Health` 示例的 `OnRep_` 函数，请使用以下代码：

DerivedActor.h

```
	#pragma once  	#include "DerivedActor.generated.h" 	UCLASS()	class ADerivedActor : public AActor	{	GENERATED_BODY() 	public: 		// 使用OnRep_Value复制的属性		UPROPERTY(ReplicatedUsing=OnRep_Value)		int32 HealthValue1; 		// 使用OnRep_ConstRef复制的属性		UPROPERTY(ReplicatedUsing=OnRep_ConstRef)		int32 HealthValue2; 		// 使用OnRep_NoParam复制的属性		UPROPERTY(ReplicatedUsing=OnRep_NoParam)		int32 HealthValue3; 		// 要传递最后一个值的副本的签名		UFUNCTION()		void OnRep_Value(int32 LastHealthValue); 		// 要传递常量引用的签名		UFUNCTION()		void OnRep_ConstRef(const int32& LastHealthValue); 		// 不传递参数的签名		UFUNCTION()		void OnRep_NoParam(); 		// 派生的Actor构造函数		ADerivedActor(const class FPostConstructInitializeProperties & PCIP);		};
```

DerivedActor.cpp

```
	#include "DerivedActor.h"	#include "Net/UnrealNetwork.h" 	ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP)	{	bReplicates = true;	} 	void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const	{		// 调用Super		Super::GetLifetimeReplicatedProps(OutLifetimeProps); 		// 添加要为派生的类复制的属性		DOREPLIFETIME(ADerivedActor, HealthValue1);		DOREPLIFETIME(ADerivedActor, HealthValue2);		DOREPLIFETIME(ADerivedActor, HealthValue3);	} 	void ADerivedActor::OnRep_Value(int32 LastHealthValue)	{		UE_LOG(LogTemp, Log, TEXT("OnRep_Value with value. Last value: %d"), LastHealthValue)		// 添加自定义OnRep逻辑	} 	void ADerivedActor::OnRep_ConstRef(const int32& LastHealthValue)	{		UE_LOG(LogTemp, Log, TEXT("OnRep_ConstRef with const ref. Last value: %d"), *LastHealthValue)		// 添加自定义OnRep逻辑		} 	void ADerivedActor::OnRep_NoParam()	{		UE_LOG(LogTemp, Log, TEXT("OnRep_NoParam with no parameter."))		// 添加自定义OnRep逻辑		}
```

#### C++和蓝图中RepNotify的差异

RepNotifies在蓝图中的工作方式与在C++中不同。在蓝图中，复制的属性上的 `Set` 节点会自动调用该属性的RepNotify函数（如果在蓝图中定义了该函数）。一般来说，按引用接受属性的蓝图宏和函数不调用RepNotify，即使它们修改了值也是如此。

### 添加Not Replicated属性

如之前所述， `NotReplicated` 说明符可被用于标记要复制的结构体中不需复制的属性。以下代码片段展示了如何在要复制的结构体中不复制某个属性。

DerivedActor.h

```
	#pragma once  	#include "DerivedActor.generated.h" 	USTRUCT()	struct FMyStruct	{	GENERATED_BODY() 	UPROPERTY()	int32 ReplicatedProperty; 		// 不复制，尽管复制了它所在的结构体		UPROPERTY(NotReplicated)		int32 NotReplicatedProperty;	}; 	UCLASS()	class ADerivedActor : public AActor	{		GENERATED_BODY() 	public:		UPROPERTY(Replicated)		FMyStruct ReplicatedStruct; 		// 派生的Actor构造函数		ADerivedActor(const class FPostConstructInitializeProperties & PCIP);	};
```

DerivedActor.cpp

```
	#include "DerivedActor.h"	#include "Net/UnrealNetwork.h" 	ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP)	{		bReplicates = true;	} 	void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const	{		Super::GetLifetimeReplicatedProps(OutLifetimeProps); 		DOREPLIFETIME(ADerivedActor, ReplicatedStruct);	}
```

## 条件复制

一旦为复制注册了属性，就不能将其注销。被设置需要复制的属性会在对象的生命周期内复制。复制系统嵌入了尽可能多的信息，以便系统可以跨连接中共享同一个属性集的工作，从而节省计算时间。

要更精细地控制属性的复制方式，你可以使用复制条件。默认情况下，每个复制的属性仅在它发生更改时复制。未发生更改的属性不会复制，因此不会占用宝贵的带宽。

### 添加复制条件

要更好地控制属性的复制方式，你可以添加二级复制条件。要将复制条件添加到复制的属性，请使用 `DOREPLIFETIME_CONDITION` 宏：

DerviedActor.cpp

```
	#include "DerivedActor.h"	#include "Net/UnrealNetwork.h" 	void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const	{		// 调用Super		Super::GetLifetimeReplicatedProps(OutLifetimeProps); 		// 添加带条件的属性复制		DOREPLIFETIME_CONDITION(ADerivedActor, Health, COND_OwnerOnly);	}
```

请注意，此示例使用 `DOREPLIFETIME_CONDITION` 宏而不是 `DOREPLIFETIME` 宏，因为复制的属性有条件。

> [!TIP]
> 复制条件适用于使用 `Replicated` 和 `ReplicatedUsing` 说明符复制的属性。

### 添加RepNotify条件

RepNotify在 `Replicated` 属性上额外添加了一个自定义层。你可以使用RepNotify条件指定时在每次复制该属性时调用其关联的RepNotify，还是仅在该属性更改时调用其关联的RepNotify。要添加RepNotify条件，请使用 `DOREPLIFETIME_CONDITION_NOTIFY` 宏：

DerivedActor.cpp

```
	#include "DerivedActor.h"	#include "Net/UnrealNetwork.h" 	void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const	{		//调用Super	Super::GetLifetimeReplicatedProps(OutLifetimeProps); 		// 添加带条件的属性复制		/** 	此项用于总是执行RepNotify		*	在每次复制属性时在客户端上调用关联的OnRep		*/		DOREPLIFETIME_CONDITION_NOTIFY(ADerivedActor, Health, REPNOTIFY_Always); 		/** 	此项用于仅在属性更改时执行RepNotify		*	仅在属性更改时在客户端上调用关联的OnRep		*/		DOREPLIFETIME_CONDITION_NOTIFY(ADerivedActor, Health, REPNOTIFY_OnChanged);	}
```

请注意，此示例使用 `DOREPLIFETIME_CONDITION_NOTIFY` 宏而不是 `DOREPLIFETIME` 宏，因为复制的属性有条件。

> [!TIP]
> 如果你想更好地控制属性的复制方式，请使用相应的 `DOREPLIFETIME_WITH_PARAMS` 宏指定 `FDoRepLifetimeParams` 结构体。请记住，控制越多也意味着开销越大，请用最少的信息实现所需最大程度的控制。

### 复制条件引用

下表为属性复制条件列表：

| **条件** | **说明** |
| --- | --- |
| `COND_None` | 没有条件，一旦更改即复制。 |
| `COND_InitialOnly` | 仅尝试在初始系列上复制。 |
| `COND_OwnerOnly` | 仅复制到Actor的所有者。 |
| `COND_SkipOwner` | 复制到除Actor的所有者之外的每个连接。 |
| `COND_SimulatedOnly` | 复制到模拟的Actor。 |
| `COND_AutonomousOnly` | 仅复制到自主Actor。 |
| `COND_SimulatedOrPhysics` | 复制到模拟的或 `bRepPhysics` Actor。 |
| `COND_InitialOrOwner` | 在初始系列上复制，或复制到Actor的所有者。 |
| `COND_Custom` | 没有特定条件，但能够打开或关闭。请参阅[自定义属性复制](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%B1%9E%E6%80%A7%E5%A4%8D%E5%88%B6)了解更多信息。 |
| `COND_ReplayOrOwner` | 仅复制到重播连接或Actor的所有者。 |
| `COND_ReplayOnly` | 仅复制到重播连接。 |
| `COND_SimulatedOnlyNoReplay` | 仅复制到模拟的Actor，但不复制到重播连接。 |
| `COND_SimulatedOrPhysicsNoReplay` | 复制到模拟的或 `bRepPhysics` Actor，但不复制到重播连接。 |
| `COND_SkipReplay` | 不复制到重播连接。 |
| `COND_Dynamic` | 在运行时重载条件。默认为总是复制，除非你将其重载为新条件。 |
| `COND_Never` | 从不复制。 |

### 自定义属性复制

要更精细地控制Actor属性何时复制，你可以将 `COND_Custom` 复制条件与 `DOREPLIFETIME_ACTIVE_OVERRIDE` 宏一起使用。此宏可帮助你创建自定义条件来规定属性何时复制。此复制按Actor规定，而不是按连接规定。因此，在自定义条件中使用可能因连接而异的状态是不安全的。

#### 添加自定义复制条件

要使用自定义条件重载属性复制，请执行以下步骤：

1. 执行[添加Replicated属性](#%E6%B7%BB%E5%8A%A0replicated%E5%B1%9E%E6%80%A7)小节中的前两个步骤。
2. 重载 `GetLifetimeReplicatedProps` 函数并添加宏调用以使用 `COND_Custom` 复制条件在派生的Actor实例的生命周期内复制 `Health` 属性：

   DerivedActor.h

   ```
    #pragma once   #include "DerivedActor.generated.h"  UCLASS() class ADerivedActor : public AActor {     GENERATED_BODY()  public:     UPROPERTY(Replicated)     int32 Health;      virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;      // 派生的Actor构造函数     ADerivedActor(const class FPostConstructInitializeProperties & PCIP); };
   ```

   DerivedActor.cpp

   ```
    #include "DerivedActor.h" #include "Net/UnrealNetwork.h"  ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP) {     bReplicates = true; }  void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const {     // 调用Super     Super::GetLifetimeReplicatedProps(OutLifetimeProps);      // 添加要为派生的类复制的属性     DOREPLIFETIME_CONDITION(ADerivedActor, Health, COND_Custom); }
   ```
3. 定义为自定义复制条件重载提供布尔表达式的属性或函数：

   DerivedActor.h

   ```
        #pragma once       #include "DerivedActor.generated.h"      UCLASS()     class ADerivedActor : public AActor     {         GENERATED_BODY()      public:          UPROPERTY(Replicated)         int32 Health;          virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;		         // 派生的Actor构造函数         ADerivedActor(const class FPostConstructInitializeProperties & PCIP);          // 自定义复制条件重载函数         bool IsInvincible();     };
   ```

   DerivedActor.cpp

   ```
        #include "DerivedActor.h"     #include "Net/UnrealNetwork.h"      ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP)     {         bReplicates = true;     }      void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const     {         // 调用Super     Super::GetLifetimeReplicatedProps(OutLifetimeProps);          // 添加要为派生的类复制的属性         DOREPLIFETIME_CONDITION(ADerivedActor, Health, COND_Custom);     }      bool IsInvincible()     {         bool bIsInvincible = false;          // 用于确定无敌的自定义逻辑...          return bIsInvincible;     }
   ```
4. 在你的派生类的 `PreReplication` 函数中注册自定义复制条件重载：

   DerivedActor.h

   ```
        #pragma once       #include "DerivedActor.generated.h"      UCLASS()     class ADerivedActor : public AActor     {         GENERATED_BODY()      public:         UPROPERTY(Replicated)         int32 Health;          virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;          // 派生的Actor构造函数         ADerivedActor(const class FPostConstructInitializeProperties & PCIP);          virtual void PreReplication(IRepChangedPropertyTracker& ChangedPropertyTracker) override;          // 自定义复制条件重载函数         bool IsInvincible();     };
   ```

   DerivedActor.cpp

   ```
        #include "DerivedActor.h"     #include "Net/UnrealNetwork.h"      ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP)     {         bReplicates = true;     }      void ADerivedActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const     {         // 调用Super         Super::GetLifetimeReplicatedProps(OutLifetimeProps);          // 添加要为派生的类复制的属性         DOREPLIFETIME_CONDITION(ADerivedActor, Health, COND_Custom);     }      /**	在其中注册自定义条件的函数。     */     void ADerivedActor::PreReplication(IRepChangedPropertyTracker& ChangedPropertyTracker)     {         // 调用Super         Super::PreReplication(ChangedPropertyTracker);          /** 使用自定义属性复制条件         *	在本例中，为函数IsInvincible()         *	如果Actor是无敌的，则不复制Health         */         DOREPLIFETIME_ACTIVE_OVERRIDE(ADerivedActor, Health, !IsInvincible());     }      bool IsInvincible()     {         bool bIsInvincible = false;          // 用于确定无敌的自定义逻辑...          return bIsInvincible;     }
   ```

现在，只要 `IsInvincible` 返回false， `Health` 就会复制。

自定义复制条件不仅可以执行预定义复制条件所能执行的所有操作，还能执行更多操作，那为什么不一直使用自定义条件呢？

- 速度（Speed）

  ：自定义复制条件会小号更多资源和更多时间。
- 连接（Connection）

  ：自定义复制条件不能根据连接而更改。

#### 自定义属性复制宏

有几个自定义属性复制宏存在一些值得注意的差异。所有这些宏都使用函数 `FNetPropertyConditionManager::SetPropertyActiveOverride` 。这些宏全部用给定宏参数构建 `FRepPropertyDescriptor` 结构体。宏之间的差异是何时构建描述符结构体以及它是否适用于复制的数组。下表说明了这些宏之间的差异：

| **宏** | **编译时或运行时** | **适用于数组** |
| --- | --- | --- |
| `DOREPLIFETIME_ACTIVE_OVERRIDE` | 运行时 | 是 |
| `DOREPLIFETIME_ACTIVE_OVERRIDE_FAST` | 编译时 | 否 |
| `DOREPLIFETIME_ACTIVE_OVERRIDE_FAST_STATIC_ARRAY` | 编译时 | 是 |

> [!TIP]
> `_FAST` 宏版本在编译时构建复制属性描述符结构体。这可节省CPU周期，因为复制系统不需要搜索提供的 `UPROPERTY` ，然后在运行时构建结构体。

## 复制对象引用

对象引用的复制由虚幻引擎的复制系统自动处理。如果你有复制的 `UObject` 属性，对该对象的引用会作为权威服务器分配的 `FNetworkGUID` 通过网络连接发送。服务器接着会向所有连接的客户端通知此分配。

#### 添加复制的对象引用

要复制对象引用，请将 `UObject` 属性标记为需复制：

DerivedActor.h

```
	#pragma once  	#include "DerivedActor.generated.h" 	UCLASS()	class ADerivedActor : public AActor	{		GENERATED_BODY() 	public:		UPROPERTY(Replicated)		AActor* Owner; 		// 派生的Actor构造函数		ADerivedActor(const class FPostConstructInitializeProperties & PCIP);	};
```

Owner属性是对此属性引用的Actor的复制引用。

#### 网络对象引用指南

要通过网络合法引用对象，它必须支持联网。要检查对象是否支持联网，请调用 `UObject::IsSupportedForNetworking` 。

以下对象可以通过网络连接复制对它们的引用：

- 复制的Actor
- 稳定命名的非复制的Actor
- 复制的组件
- 稳定命名的非复制的Actor组件
- 加载的包中的非Actor、非组件的UObject

#### 稳定命名的对象

**稳定命名的对象（Stably Named Objects）** 是在服务器和客户端上都存在且在这两个地方同名的对象。如果Actor是直接从包加载的，而不是在Gameplay期间生成的，它们就是稳定命名的。

Actor组件在以下情况下是稳定命名的：

- 直接从包加载
- 使用简单构造脚本添加
- 通过

  UActorComponent::SetNetAddressable

  手动标记。

  - 仅当你确信你会手动命名Actor组件，以便它在服务器和客户端上同名时才使用此项。在

    AActor

    C++构造函数中添加的组件就是一个很好的例子。

## 属性复制引用

下表借号了虚幻引擎中可用的属性复制宏，以及：

- 调用宏的函数。
- 关联的

  FRepPropertyDescriptor

  是在编译时还是运行时构造。
- 宏是否适用于数组。

| **宏** | **说明** | **在何处调用宏** | **编译时或运行时** | **适用于数组** |
| --- | --- | --- | --- | --- |
| `DOREPLIFETIME` | 复制不带条件或自定义条件的属性。 | `GetLifetimeReplicatedProps` | 运行时 | 是 |
| `DOREPLIFETIME_WITH_PARAMS` | 复制带控制其复制方式的 `FDoRepLifetimeParams` 结构体的属性。 | `GetLifetimeReplicatedProps` | 运行时 | 是 |
| `DOREPLIFETIME_WITH_PARAMS_FAST` | 复制带控制其复制方式的 `FDoRepLifetimeParams` 结构体的属性。 | `GetLifetimeReplicatedProps` | 编译时 | 否 |
| `DOREPLIFETIME_WITH_PARAMS_FAST_STATIC_ARRAY` | 复制带控制其复制方式的 `FDoRepLifetimeParams` 结构体的属性。 | `GetLifetimeReplicatedProps` | 编译时 | 是 |
| `DOREPLIFETIME_CONDITION` | 复制带 `ELifetimeCondition` 的属性。 | `GetLifetimeReplicatedProps` | 运行时 | 是 |
| `DOREPLIFETIME_CONDITION_NOTIFY` | 复制带 `ELifetimeRepNotifyCondition` 的属性。 | `GetLifetimeReplicatedProps` | 运行时 | 是 |
| `DOREPLIFETIME_ACTIVE_OVERRIDE` | 复制带自定义条件的属性。必须伴随对 `DOREPLIFETIME_CONDITION(<CLASS>, <PROPERTY>, COND_Custom)` 的调用。 | `PreReplication` | 运行时 | 是 |
| `DOREPLIFETIME_ACTIVE_OVERRIDE_FAST` | 复制带自定义条件的属性。必须伴随对 `DOREPLIFETIME_CONDITION(<CLASS>, <PROPERTY>, COND_Custom)` 的调用。 | `PreReplication` | 编译时 | 否 |
| `DOREPLIFETIME_ACTIVE_OVERRIDE_FAST_STATIC_ARRAY` | 复制带自定义条件的属性。必须伴随对 `DOREPLIFETIME_CONDITION(<CLASS>, <PROPERTY>, COND_Custom)` 的调用。 | `PreReplication` | 编译时 | 是 |

> [!TIP]
> 你可以在 `Engine/Source/Runtime/Engine/Public/Net/UnrealNetwork.h` 中找到这些宏的定义。

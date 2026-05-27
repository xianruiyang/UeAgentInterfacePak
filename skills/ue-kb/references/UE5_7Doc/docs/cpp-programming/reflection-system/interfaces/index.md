---
title: "Unreal Interfaces"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/interfaces-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统", "Unreal Interfaces"]
---

# Unreal Interfaces

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统 / Unreal Interfaces

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/interfaces-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

当类继承自 **Unreal Interface** 类时，该接口会确保新类实现一组通用函数。当某些功能需要由大型复杂但彼此不相似的类共享时，这很有用。

例如，假设游戏中有一个系统：玩家角色进入触发体积时，会根据情况激活陷阱、警告敌人或给玩家加分。 可以使用一个 `ReactToTrigger` 函数在陷阱、敌人或得分奖励上实现它。 即使所有这些可激活对象都实现了 `ReactToTrigger` 函数，它们在其他方面也可能非常不同。 For example:

- Traps derive from `AActor`.
- Enemies derive from `APawn` or `ACharacter`.
- Point-awards derive from `UDataAsset`.

这些类需要共享功能，但除了基础 `UObject`. 在这种情况下，Unreal Interface 可以强制所有这些对象实现必要函数。

## 在 C++ 中声明接口

在 C++ 中声明接口类似于声明普通 Unreal 类。不过，有几个主要区别：

- 接口类使用 `UINTERFACE` 宏，而不是 `UCLASS` macro.
- 接口类继承自 `UInterface` 而不是 `UObject`.

> [!NOTE]
> The `UINTERFACE` 类并不是实际接口，而是一个为空的类，用于向反射系统提供可见性。

### C++ Class Wizard

要从 Unreal Editor 创建新的 Unreal Interface 类，请按照 [C++ Class Wizard](../../setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md) 文档中的步骤操作，并使用以下信息：

- **Class：** Unreal Interface

### C++ 接口声明示例

The following is an example of a C++ interface declaration named `ReactToTriggerInterface`:

C++

ReactToTriggerInterface.h

```
#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "ReactToTriggerInterface.generated.h"

/*
This class does not need to be modified.
Empty class for reflection system visibility.
Uses the UINTERFACE macro.
```

如该示例所示，实际接口与空类同名，但 `U`-前缀会替换为 `I`. The `U`-前缀类不需要构造函数或任何其他函数。 The `I`-前缀类包含所有接口函数，并且是希望实现该接口的类要继承的类。

> [!NOTE]
> The `Blueprintable` 如果希望蓝图实现此接口，则需要该 specifier。

## 接口 Specifier

使用接口 specifier 将类暴露给 [Unreal Reflection System](../index.md)。下表包含相关接口 specifier：

| 接口 Specifier | 说明 |
| --- | --- |
| `Blueprintable` | 暴露此接口，使其可以 [由蓝图实现](../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-interface/implementing-blueprint-interfaces/index.md). 接口不能’t 暴露给蓝图，如果它们包含除 `BlueprintImplementableEvent` and `BlueprintNativeEvent` 函数以外的内容。 使用 `NotBlueprintable` or `meta=(CannotImplementInterfaceInBlueprint)` 指定接口不能安全地在蓝图中实现。 |
| `BlueprintType` | 将该类暴露为可在蓝图中用于变量的类型。 |
| `DependsOn=(ClassName1, ClassName2, ...)` | 构建系统会在编译此类之前，先编译该 specifier 列出的所有类。 `ClassName` 必须指定同一个（或之前）包中的类。 可以使用单个 `DependsOn` 行并用逗号分隔多个依赖类，也可以使用单独的 `DependsOn` 行为每个类分别指定。 |
| `MinimalAPI` | 只导出该类的类型信息供其他模块使用。可以转换到该类，但不能调用该类函数（内联方法除外）。这通过避免为不需要其他模块访问全部函数的类导出所有内容来改善编译时间。 |

## 在 C++ 中实现接口

要在新类中使用接口：

- 包含接口头文件。
- 继承你的 `I`-前缀接口类。

以下是本页开头提到的陷阱示例：

C++

Trap.h

```
#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "ReactToTriggerInterface.h"
#include "Trap.generated.h"

UCLASS(Blueprintable, Category="MyGame")
class ATrap : public AActor, public IReactToTriggerInterface
{
	GENERATED_BODY()
```

## 声明接口函数

可以使用多种方法在接口中声明函数，每种方法可在不同上下文中实现或调用。 所有这些函数都必须声明在接口的 `I`-前缀类中，并且必须为 public，才能对外部类可见。

### 仅 C++ 接口函数

You can declare a virtual C++ function in your interface’s header file, with no `UFUNCTION` specifiers. 这些函数必须为 virtual，以便在实现接口的类中重写。

#### 接口类

以下是在 `ReactToTriggerInterface` 类中的示例：

C++

ReactToTriggerInterface.h

```
#pragma once

#include "ReactToTriggerInterface.generated.h"

/*
Empty class for reflection system visibility.
Uses the UINTERFACE macro.
Inherits from UInterface.
*/
UINTERFACE(MinimalAPI, Blueprintable)
```

可以在头文件本身或接口的’s `.cpp` file.

C++

ReactToTriggerInterface.cpp

```
#include "ReactToTriggerInterface.h" bool IReactToTriggerInterface::ReactToTrigger(){	return false;}
```

#### 派生类

在派生类中实现接口时，可以创建并实现特定于该类的 override。 以下示例展示 `ATrap` Actor 实现 `IReactToTriggerInterface`:

C++

Trap.h

```
#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "ReactToTriggerInterface.h"
#include "Trap.generated.h"

UCLASS(Blueprintable, Category="MyGame")
class ATrap : public AActor, public IReactToTriggerInterface
{
	GENERATED_BODY()
```

C++

Trap.cpp

```
#include "Trap.h" bool ATrap::ReactToTrigger(){	return false;}
```

以这种方式声明的 C++ 接口函数对蓝图不可见，不能用于 Blueprintable 接口。

### 蓝图可调用接口函数

要让接口函数可由蓝图调用，必须执行以下操作：

- Specify a `UFUNCTION` macro in the function’s declaration with the `BlueprintCallable` specifier.
- 使用 either the `BlueprintImplementableEvent` or `BlueprintNativeEvent` specifiers.

> [!NOTE]
> 蓝图可调用接口函数不能是 virtual。

带有 `BlueprintCallable` specifier 的函数可以在 C++ 或蓝图中通过实现该接口的对象引用调用。

> [!TIP]
> 如果蓝图可调用函数没有返回值，Unreal Engine 会将该函数视为蓝图中的事件。

#### Blueprint Implementable Event

带有 `BlueprintImplementableEvent` specifier 不能在 C++, 中重写，但可以在实现或继承该接口的任意蓝图类中重写。 The following is an example of a C++ interface declaration for a `BlueprintImplementableEvent`:

C++

ReactToTriggerInterface.h

```
#pragma once

#include "ReactToTriggerInterface.generated.h"

/*
Empty class for reflection system visibility.
Uses the UINTERFACE macro.
Inherits from UInterface.
*/
UINTERFACE(MinimalAPI, Blueprintable)
```

#### Blueprint Native Event

带有 `BlueprintNativeEvent` specifier 可以在 C++ or Blueprint. The following is an example of a C++ interface declaration for a `BlueprintNativeEvent`:

C++

ReactToTriggerInterface.h

```
#pragma once

#include "ReactToTriggerInterface.generated.h"

/*
Empty class for reflection system visibility.
Uses the UINTERFACE macro.
Inherits from UInterface.
*/
UINTERFACE(MinimalAPI, Blueprintable)
```

##### 在 C++ 中重写 Blueprint Native Event

要实现 `BlueprintNativeEvent` in C++, 请创建一个与 `BlueprintNativeEvent` 同名并额外追加 `_Implementation` 后缀的函数。 以下是来自 `ATrap` example:

C++

Trap.h

```
#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "ReactToTriggerInterface.h"
#include "Trap.generated.h"

UCLASS(Blueprintable, Category="MyGame")
class ATrap : public AActor, public IReactToTriggerInterface
{
	GENERATED_BODY()
```

C++

Trap.cpp

```
#include "Trap.h"

bool ATrap::ReactToTrigger()
{
	return false;
}

// Blueprint Native Event override implementation
bool ATrap::ReactToTrigger_Implementation() 
{
```

##### 在蓝图中重写 Blueprint Native Event

The `BlueprintNativeEvent` specifier 也允许在蓝图中重写实现。 要实现 `BlueprintNativeEvent` 于蓝图中，请参阅 [实现蓝图接口](../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-interface/implementing-blueprint-interfaces/index.md) 文档以了解更多信息。

#### 从 C++ 调用蓝图事件

要安全调用 `BlueprintImplementableEvent` or `BlueprintNativeEvent` ，目标是 `Blueprintable` 接口，来自 C++, 必须使用特殊的静态 `Execute_` 函数包装器。 以下示例调用适用于在 C++ 或蓝图中实现的接口：

C++

```
// OriginalObject is an object that implements the IReactToTriggerInterfacebool bReacted = IReactToTriggerInterface::Execute_ReactToTrigger(OriginalObject);
```

## 接口函数类型

接口函数有三种不同类型：

- Base
- Implementation
- Execute

下表说明每种类型的用途：

| 类型 | 定义位置 | 用途 | 用于... |
| --- | --- | --- | --- |
| Base 函数 | Base interface 类实现时可用。 (`MyInterface.h`) | 可在子类中实现的函数定义。 | 仅当接口和实现都只在 C++ 中定义时使用。 |
| Implementation 包装器 | C++ Class that implements interface. (`MyInterfaceActor.h`, `MyInterfaceActor.cpp`) | 在 C++ 中实现接口功能。 | 只调用 C++ 实现，不调用任何蓝图重写。 |
| Execute 包装器 | 由 Unreal Engine’s 反射系统自动创建。 (`MyInterface.generated.h`, `MyInterface.gen.cpp`) | 促进 C++ 和蓝图中定义的实现之间通信。 | 调用函数实现，包括 C++ 和蓝图重写。 |

考虑以下示例：

- `MyFunction` is a `BlueprintNativeEvent` interface function defined in `MyInterface.h`.
- `MyInterfaceActor` implements `MyInterface`.
- `MyFunction_Implementation` is defined in `MyInterfaceActor.cpp`.
- A variety of C++ 以及从以下类型继承的蓝图生成 Actor： `MyInterfaceActor`.

To safely call `MyFunction` ，目标是所有蓝图和 C++ 对象，这些对象继承自 `MyInterfaceActor`, 可以执行以下操作：

C++

```
TArray<AActor*> OutActors;UGameplayStatics::GetAllActorsOfClass(GetWorld(), AMyInterfaceActor::StaticClass(), OutActors); // OutActors contains all BP and C++ actors that are or inherit from AMyInterfaceActorfor (AActor* CurrentActor : OutActors){	// Each CurrentActor calls its own MyFunction implementation	UE_LOG(LogTemp, Log, TEXT("%s : %s"), *CurrentActor->GetName(), *IMyInterface::Execute_MyFunction(Cast<AMyInterfaceActor>(CurrentActor)));}
```

## 判断类是否实现接口

为了同时兼容实现接口的 C++ 和蓝图类，请使用以下任一函数判断类是否实现接口：

C++

```
bool bIsImplemented; /* bIsImplemented is true if OriginalObject implements UReactToTriggerInterface */bIsImplemented = OriginalObject->GetClass()->ImplementsInterface(UReactToTriggerInterface::StaticClass()); /* bIsImplemented is true if OriginalObject implements UReactToTriggerInterface */bIsImplemented = OriginalObject->Implements<UReactToTriggerInterface>(); /* ReactingObject is non-null if OriginalObject implements UReactToTriggerInterface in C++ */IReactToTriggerInterface* ReactingObject = Cast<IReactToTriggerInterface>(OriginalObject);
```

模板化 `Cast<>` 方法仅在接口由 C++ 类实现时可用。 蓝图中实现的接口不存在于对象的 C++ 版本中，因此 `Cast<>` 会返回 null。 `TScriptInterface<>` can also be used in C++ 代码中安全复制接口指针以及实现该接口的 `UObject` 。

## 转换到其他 Unreal 类型

Unreal Engine 的类型转换系统支持在适当情况下从一个接口转换到另一个接口，或从接口转换到 Unreal 类型。以下示例展示可用于转换接口的一些方法：

C++

```
/* ReactingObject is non-null if the interface is implemented */IReactToTriggerInterface* ReactingObject = Cast<IReactToTriggerInterface>(OriginalObject); /* DifferentInterface is non-null if ReactingObject is non-null and it implements ISomeOtherInterface */ISomeOtherInterface* DifferentInterface = Cast<ISomeOtherInterface>(ReactingObject); /* ReactingActor is non-null if ReactingObject is non-null and OriginalObject is an AActor or AActor-derived class */AActor* ReactingActor = Cast<AActor>(ReactingObject);
```

## 安全存储对象和接口指针

要存储对实现特定接口对象的引用，可以使用 `TScriptInterface`. 如果有实现接口的对象，可以初始化 `TScriptInterface` 如下：

C++

```
UMyObject* MyObjectPtr;TScriptInterface<IMyInterface> MyScriptInterface; if (MyObjectPtr->Implements<UMyInterface>()){	MyScriptInterface = TScriptInterface<IMyInterface>(MyObjectPtr);} // MyScriptInterface holds a reference to MyObjectPtr and MyInterfacePtr
```

要检索指向原始对象的指针，请使用 `GetObject`:

C++

```
UMyObject* MyRetrievedObjectPtr = MyScriptInterface.GetObject();
```

要检索原始对象实现的接口指针，请使用 `GetInterface`:

C++

```
IMyInterface* MyRetrievedInterfacePtr = MyScriptInterface.GetInterface();
```

有关 `TScriptInterface`, see [TScriptInterface](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/TScriptInterface?application_version=5.5) 以及链接的 [FScriptInterface](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/FScriptInterface?application_version=5.5) API 页面。

## 蓝图可实现接口

如果希望蓝图实现此接口，必须使用 `Blueprintable` metadata specifier。 除静态函数外，每个接口函数都必须是 `BlueprintNativeEvent` or a `BlueprintImplementableEvent`. 当蓝图实现声明于 C++, 的接口时，它的工作方式类似蓝图接口资产。 这意味着该蓝图类实例实际上不会包含 C++ 版本的接口，因此不能与 `Cast<>`. From C++, 只有 `Execute_` 静态包装函数能正常工作。

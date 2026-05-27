---
title: "委托"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/delegates-and-lambda-functions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "委托"]
---

# 委托

> 路径：虚幻引擎5.7文档 / 用C++编程 / 委托

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/delegates-and-lambda-functions-in-unreal-engine

**委托** 是一种泛型但类型安全的方式，可在C++对象上调用成员函数。可使用委托动态绑定到任意对象的成员函数，之后在该对象上调用函数，即使调用程序不知对象类型也可进行操作。复制委托对象很安全。你也可以利用值传递委托，但这样操作需要在堆上分配内存，因此通常并不推荐。请尽量通过引用传递委托。虚幻引擎共支持三种类型的委托：

- 单点委托
- 组播委托
- 动态(UObject, serializable)

## 声明委托

如需声明委托，请使用下文所述的宏。请根据与委托相绑定的函数（或多个函数）的函数签名来选择宏。每个宏都为新的委托类型名称、函数返回类型（如果不是 `void` 函数）及其参数提供了参数。当前，支持以下使用任意组合的委托签名：

- 返回一个值的函数。
- 声明为

  常

  函数。
- 最多4个"载荷"变量。
- 最多8个函数参数。

使用此表格查找要用于声明委托的生命宏。

| 函数签名 | 声明宏 |
| --- | --- |
| `void Function()` | `DECLARE_DELEGATE(DelegateName)` |
| `void Function(Param1)` | `DECLARE_DELEGATE_OneParam(DelegateName, Param1Type)` |
| `void Function(Param1, Param2)` | `DECLARE_DELEGATE_TwoParams(DelegateName, Param1Type, Param2Type)` |
| `void Function(Param1, Param2, ...)` | `DECLARE_DELEGATE_<Num>Params(DelegateName, Param1Type, Param2Type, ...)` |
| `<RetValType> Function()` | `DECLARE_DELEGATE_RetVal(RetValType, DelegateName)` |
| `<RetValType> Function(Param1)` | `DECLARE_DELEGATE_RetVal_OneParam(RetValType, DelegateName, Param1Type)` |
| `<RetValType> Function(Param1, Param2)` | `DECLARE_DELEGATE_RetVal_TwoParams(RetValType, DelegateName, Param1Type, Param2Type)` |
| `<RetValType> Function(Param1, Param2, ...)` | `DECLARE_DELEGATE_RetVal_<Num>Params(RetValType, DelegateName, Param1Type, Param2Type, ...)` |

> [!NOTE]
> 委托函数支持与[UFunctions](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine)相同的[说明符](https://dev.epicgames.com/documentation/404)，但使用 `UDELEGATE` 宏而不是 `UFUNCTION`。例如，以下代码将 `BlueprintAuthorityOnly` 说明符添加到 `FInstigatedAnyDamageSignature` 委托中
>
> ```
> 	UDELEGATE(BlueprintAuthorityOnly)	DECLARE_DYNAMIC_MULTICAST_DELEGATE_FourParams(FInstigatedAnyDamageSignature, float, Damage, const UDamageType*, DamageType, AActor*, DamagedActor, AActor*, DamageCauser);
> ```

关于组播委托、动态委托和封装委托，上述宏的变体如下：

- DECLARE_MULTICAST_DELEGATE...
- DECLARE_DYNAMIC_DELEGATE...
- DECLARE_DYNAMIC_MULTICAST_DELEGATE...
- DECLARE_DYNAMIC_DELEGATE...
- DECLARE_DYNAMIC_MULTICAST_DELEGATE...

委托签名声明可存在于全局范围内、命名空间内、甚至类声明内。此类声明可能不在于函数体内。

请参见[动态委托](dynamic-delegates/index.md) 和[多播委托](multicast-delegates/index.md)了解有关声明此类类型委托的更多信息。

## 绑定委托

委托系统理解某些类型的对象，使用此类对象时将启用附加功能。将委托绑定到UObject或共享指针类的成员， 委托系统可保留对该对象的弱引用，因此对象在委托下方被销毁时，可通过调用 `IsBound()` 或 ` ExecuteIfBound()` 函数进行处理。注意各类受支持对象的特殊绑定语法。

| 函数 | 描述 |
| --- | --- |
| `Bind` | 绑定到现有委托对象。 |
| `BindStatic` | 绑定原始C++指针全局函数委托。 |
| `BindRaw` | 绑定原始C++指针委托。由于原始指针不使用任何类型的引用，因此在删除目标对象后调用`Execute` 或 `ExecuteIfBound` 会不安全。 |
| `BindLambda` | 绑定一个函子。这通常用于拉姆达函数。 |
| `BindSP` | 绑定基于指针的共享成员函数委托。共享指针委托会保留对对象的弱引用。可使用 `ExecuteIfBound()` 进行调用。 |
| `BindUObject` | 绑定 `UObject` 的成员函数委托。`UObject` 委托会保留对你的对象 `UObject` 的弱引用。可使用 `ExecuteIfBound()` 进行调用。 |
| `UnBind` | 取消绑定此委托。 |

请参见 `DelegateSignatureImpl.inl`（位于`..\Engine\Source\Runtime\Core\Public\Templates\`），了解此类函数的变体、参数和实现。

### 载荷数据

绑定到委托时，可同时传递载荷数据。其为调用时被直接传到绑定函数的任意变量。此操作十分有用， 利用其可在绑定时将参数存储在委托内。所有委托类型（除"动态"外）均自动支持载荷变量。 此范例将两个自定义变量（一个布尔，一个int32）传递到委托。之后调用该委托时， 此类参数将被传到绑定函数。须始终接受委托类型参数后的额外变量参数。

```
	MyDelegate.BindRaw( &MyFunction, true, 20 );
```

## 执行委托

通过调用委托的 `Execute()` 函数执行绑定到委托的函数。执行前须检查委托是否已绑定。 此操作是为了使代码更安全，因为有时委托可能含有未初始化且被后续访问的返回值和输出参数。 执行未绑定的委托在某些情况下确实可能导致内存混乱。可调用 `IsBound()` 检查是否可安全执行委托。 同时，对于无返回值的委托，可调用 `ExecuteIfBound()`，但需注意输出参数可能未初始化。

| 执行函数 | 描述 |
| --- | --- |
| `Execute` | 不检查其绑定情况即执行一个委托 |
| `ExecuteIfBound` | 检查一个委托是否已绑定，如是，则调用Execute |
| `IsBound` | 检查一个委托是否已绑定，经常出现在包含 `Execute` 调用的代码前 |

参见[多播委托](multicast-delegates/index.md)，了解执行多投射委托的相关细节。

## 用法示例

假设类拥有可在任何地方随意调用的方法：

```
	class FLogWriter	{		void WriteToLog(FString);	};
```

要调用WriteToLog函数，需创建该函数签名的委托类型。为此，首先需使用以下宏声明委托。例如， 以下是一个简单的委托类型：

```
	DECLARE_DELEGATE_OneParam(FStringDelegate, FString);
```

此将创建名为 `FStringDelegate` 的委托类型，该类型使用 `FString` 类型的单个参数。

此为在类中使用此 `FStringDelegate` 的方法范例：

```
	class FMyClass	{		FStringDelegate WriteToLogDelegate;	};
```

利用此操作，类可保有指向任意类中的方法的指针。该类唯一真正了解的信息就是，此委托是其的函数签名。

如要分配委托，现在只需创建委托类的实例，将拥有该方法的类作为模板参数传递。 同时还需传递对象的实例和方法的实际函数地址。因此，现在需创建 `FLogWriter` 类的实例， 然后创建该对象实例 `WriteToLog` 方法的委托：

```
	TSharedRef<FLogWriter> LogWriter(new FLogWriter()); 	WriteToLogDelegate.BindSP(LogWriter, &FLogWriter::WriteToLog);
```

此操作可将委托动态绑定到类的方法！很简单，对吧？

注意：绑定到的对象由共享指针拥有，因此 `BindSP` 的SP部分代表共享指针。此外， 还有不同对象类型的版本，例如BindRaw()和BindUObject()。

FMyClass现在可调用 `WriteToLog` 方法，甚至无需了解 `FLogWriter` 类的任何信息！要调用委托，只需使用 `Execute()` 方法：

```
	WriteToLogDelegate.Execute(TEXT("Delegates are great!"));
```

如将函数绑定到网络前调用Execute()，将触发断言：多数情况下，建议进行以下操作：

```
	WriteToLogDelegate.ExecuteIfBound(TEXT("Only executes if a function was bound!"));
```

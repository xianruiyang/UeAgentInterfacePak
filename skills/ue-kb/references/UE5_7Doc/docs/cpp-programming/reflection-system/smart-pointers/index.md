---
title: "虚幻智能指针库"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/smart-pointers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统", "虚幻智能指针库"]
---

# 虚幻智能指针库

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统 / 虚幻智能指针库

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/smart-pointers-in-unreal-engine

**虚幻智能指针库** 为C++11智能指针的自定义实现，旨在减轻内存分配和追踪的负担。该实现包括行业标准 **共享指针**、**弱指针** 和 **唯一指针**。其还可添加 **共享引用**，此类引用的行为与不可为空的共享指针相同。虚幻Objects使用更适合游戏代码的单独内存追踪系统，因此这些类无法与 `UObject` 系统同时使用。

## 智能指针类型

智能指针可影响其包含或引用对象的寿命。不同智能指针对对象有不同的限制和影响。下表可用于协助决定各类型智能指针的适用情况：

| 智能指针类型 | 适用情形 |
| --- | --- |
| **[共享指针](shared-pointers/index.md)**（`TSharedPtr`） | 共享指针拥有其引用的对象，无限防止该对象被删除，并在无共享指针或共享引用（见下文）引用其时，最终处理其的删除。共享指针可为空白，意味其不引用任何对象。任何非空共享指针都可对其引用的对象生成共享引用。 |
| **[共享引用](shared-references/index.md)**（`TSharedRef`） | 共享引用的行为与共享指针类似，即其拥有自身引用的对象。对于空对象而言，其存在不同；共享引用须固定引用非空对象。共享指针无此类限制，因此共享引用可固定转换为共享指针，且该共享指针固定引用有效对象。要确认引用的对象是非空，或者要表明共享对象所有权时，请使用共享引用。 |
| **[弱指针](weak-pointers/index.md)**（TWeakPtr`TSharedPtr`） | 弱指针类与共享指针类似，但不拥有其引用的对象，因此不影响其生命周期。此属性中断引用循环，因此十分有用，但也意味弱指针可在无预警的情况下随时变为空。因此，弱指针可生成指向其引用对象的共享指针，确保程序员能对该对象进行安全临时访问。 |
| **唯一指针**（`TUniquePtr`） | 唯一指针仅会显式拥有其引用的对象。仅有一个唯一指针指向给定资源，因此唯一指针可转移所有权，但无法共享。复制唯一指针的任何尝试都将导致编译错误。唯一指针超出范围时，其将自动删除其所引用的对象。 |

> [!WARNING]
> 对唯一指针引用的对象进行共享指针或共享引用的操作十分危险。即使其他智能指针继续引用该对象，此操作不会取消唯一指针自身被销毁时删除该对象的行为。同样，不应为共享指针或共享引用引用的对象创建唯一指针。

|

## 智能指针

| 优点 | 描述 |
| --- | --- |
| **防止内存泄漏** | 共享引用不存在时，智能指针（弱指针除外）会自动删除对象。 |
| **弱引用** | 弱指针会中断引用循环并阻止悬挂指针。 |
| **可选择的线程安全**） | 虚幻智能指针库包括线程安全代码，可跨线程管理引用计数。如无需线程安全，可用其换取更好性能。 |
| **运行时安全** | 共享引用从不为空，可固定随时取消引用。 |
| **授予意图** | 可轻松区分对象所有者和观察者。 |
| **内存** | 智能指针在64位下仅为C++指针大小的两倍（加上共享的16字节引用控制器）。唯一指针除外，其与C++指针大小相同。 |

## 助手类和函数

虚幻智能指针库提供多个助手类和函数，以便使用智能指针时更加容易、直观。

| 助手 | 描述 |
| --- | --- |
| **类** |  |
| `TSharedFromThis` | 在添加 `AsShared` 或 `SharedThis` 函数的 `TSharedFromThis` 中衍生类。利用此类函数可获取对象的 `TSharedRef`。 |
| **函数** |  |
| `MakeShared` 和 `MakeShareable` | 在常规C++指针中创建共享指针。`MakeShared` 会在单个内存块中分配新的对象实例和引用控制器，但要求对象提交公共构造函数。`MakeShareable` 的效率较低，但即使对象的构造函数为私有，其仍可运行。利用此操作可拥有非自己创建的对象，并在删除对象时支持自定义行为。 |
| `StaticCastSharedRef` 和 `StaticCastSharedPtr` | 静态投射效用函数，通常用于向下投射到衍生类型。 |
| `ConstCastSharedRef` 和 `ConstCastSharedPtr` | 将 `const` 智能引用或智能指针分别转换为 `mutable` 智能引用或智能指针。 |

## 智能指针实现细节

在功能和效率方面，虚幻智能指针库中的智能指针具有一些共同特征。

### 速度

要使用智能指针时，始终考虑性能。智能指针非常适合某些高级系统、资源管理或工具编程。但部分智能指针类型比原始C++指针更慢，这种开销使得其在低级引擎代码（如渲染）中用处不大。

智能指针的部分一般性能优势包括：

- 所有运算均为常量时间。
- 取消引用多数智能指针的速度和原始C++指针的相同（在发布版本中）。
- 复制智能指针永不会分配内存。
- 线程安全智能指针是无锁的。

智能指针的性能缺陷包括：

- 创建和复制智能指针比创建和复制原始C++指针需要更多开销。
- 保持引用计数增加基本运算的周期。
- 部分智能指针占用的内存比原始的C++更多。
- 引用控制器有两个堆分配。使用 `MakeShared` 代替 `MakeShareable` 可避免二次分配，并可提高性能。

### 侵入性访问器

共享指针是非侵入性的，意味对象不知道其是否为智能指针拥有。此通常是可以接受的，但在某些情况下，可能要将对象作为共享引用或共享指针进行访问。为此，使用对象的类作为模板参数，在 `TSharedFromThis` 衍生对象的类。`TSharedFromThis` 提供两个函数：`AsShared` 和 `SharedThis`，可将对象转换为共享引用（并从共享引用转换为共享指针）。使用固定返回共享引用的类factory时，或需将对象传到需要共享引用或共享指针的系统时，此操作十分有用。`AsShared` 会将类返回为最初作为模板参数传到 `TSharedFromThis` 的类型返回，其可能是调用对象的父类型，而 `SharedThis` 将直接从该类型衍生类型，并返回引用该类型对象的智能指针。以下范例代码中演示这两种函数：

```
	class FRegistryObject;	class FMyBaseClass: public TSharedFromThis<FMyBaseClass>	{		virtual void RegisterAsBaseClass(FRegistryObject* RegistryObject)		{			// 访问对"this"的共享引用。			// 直接继承自< TSharedFromThis >，因此AsShared()和SharedThis(this)会返回相同的类型。			TSharedRef<FMyBaseClass> ThisAsSharedRef = AsShared();			// RegistryObject需要 TSharedRef<FMyBaseClass>，或TSharedPtr<FMyBaseClass>。TSharedRef可被隐式转换为TSharedPtr.			RegistryObject->Register(ThisAsSharedRef);		}	};	class FMyDerivedClass : public FMyBaseClass	{		virtual void Register(FRegistryObject* RegistryObject) override		{			// 并非直接继承自TSharedFromThis<>，因此AsShared()和SharedThis(this)不会返回相同类型。			// 在本例中，AsShared()会返回在TSharedFromThis<> - TSharedRef<FMyBaseClass>中初始指定的类型。			// 在本例中，SharedThis(this)会返回具备"this"类型的TSharedRef - TSharedRef<FMyDerivedClass>。			// SharedThis()函数仅在与 'this'指针相同的范围内可用。			TSharedRef<FMyDerivedClass> AsSharedRef = SharedThis(this);			// FMyDerivedClass是FMyBaseClass的一种类型，因此RegistryObject将接受TSharedRef<FMyDerivedClass>。			RegistryObject->Register(ThisAsSharedRef);		}	};	class FRegistryObject	{		// 此函数将接受到FMyBaseClass或其子类的TSharedRef或TSharedPtr。		void Register(TSharedRef<FMyBaseClass>);	}; 
```

不要在构造函数中调用 `AsShared` 或 `Shared`，共享引用此时并未初始化，将导致崩溃或断言。

### 投射

可通过虚幻智能指针库包含的多个支持函数投射共享指针(和共享引用)。Up-casting是隐式的，与C++指针相同。可使用 `ConstCastSharedPtr` 函数进行常量投射，使用 `StaticCastSharedPtr` 进行静态投射（通常是向下投射到衍生类指针）。无run-type类型的信息（RTTI），因此不支持动态转换；应使用静态投射，如以下代码所示：

```
	// 假设通过其他方式验证了FDragDropOperation实际为FAssetDragDropOp。	TSharedPtr<FDragDropOperation> Operation = DragDropEvent.GetOperation();	//现在可使用StaticCastSharedPtr进行投射。	TSharedPtr<FAssetDragDropOp> DragDropOp = StaticCastSharedPtr<FAssetDragDropOp>(Operation); 
```

### 线程安全

通常仅在单线程上访问智能指针的操作才是安全的。如需访问多线程，请使用智能指针类的线程安全版本：

- `TSharedPtr<T, ESPMode::ThreadSafe>`
- `TSharedRef<T, ESPMode::ThreadSafe>`
- `TWeakPtr<T, ESPMode::ThreadSafe>`
- `TSharedFromThis<T, ESPMode::ThreadSafe>`

由于原子引用计数，此类线程安全版本比默认版本稍慢，但其行为与常规C++指针一致：

- 读取和复制固定为线程安全。
- 写入和重置须同步后才安全。

> [!TIP]
> 如了解多线程永不访问指针，可通过避免使用线程安全版本获得更好性能。

## 提示和限制

- 避免将数据作为 `TSharedRef` 或 `TSharedPtr` 参数传到函数，此操作将因取消引用和引用计数而产生开销。相反，建议将引用对象作为 `const &` 进行传递。
- 可将共享指针向前声明为不完整类型。
- 共享指针与虚幻对象(`UObject` 及其衍生类)不兼容。引擎具有 `UObject` 管理的单独内存管理系统（[对象处理](../objects/unreal-object-handling/index.md)文档），两个系统未互相重叠。

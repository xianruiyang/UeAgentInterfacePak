---
title: "共享引用"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/shared-references-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统", "虚幻智能指针库", "共享引用"]
---

# 共享引用

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统 / 虚幻智能指针库 / 共享引用

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/shared-references-in-unreal-engine

**共享引用** 是一类强大且不可为空的 **智能指针**，其被用于引擎的 `Uobject` 系统外的数据对象。此意味无法重置共享引用、向其指定空对象，或创建空白引用。因此共享引用固定包含有效对象，甚至未拥有 `IsValid` 方法。在共享引用和 **[共享指针](../shared-pointers/index.md)** 间选择时，除非需要空白或可为空的对象，否则共享引用为优先选项。如需可能空白或可为空的引用，则应使用共享指针。

> [!NOTE]
> 与标准的C++引用不同，可在创建后将共享引用重新指定到另一对象。

## 声明和初始化

共享引用不可为空，因此初始化需要数据对象。在无有效对象的情况下尝试创建的共享引用将不会编译，并尝试将共享引用初始化为空指针变量。

```
	//创建新节点的共享引用	TSharedRef<FMyObjectType> NewReference = MakeShared<FMyObjectType>(); 
```

在无有效对象的情况下尝试创建的共享引用将不会编译：

```
	//以下两者均不会编译：	TSharedRef<FMyObjectType> UnassignedReference;	TSharedRef<FMyObjectType> NullAssignedReference = nullptr;	//以下会编译，但如NullObject实际为空则断言。	TSharedRef<FMyObjectType> NullAssignedReference = NullObject; 
```

## 共享指针和共享引用间的转换

共享指针和共享引用间的转换十分常见。共享引用会隐式转换为共享指针，并为新共享指针引用有效对象提供额外保证。使用普通语法处理转换：

```
	TSharedPtr<FMyObjectType> MySharedPointer = MySharedReference; 
```

如共享指针引用非空对象，即可使用 `共享指针` 函数 `ToSharedRef`，在共享指针中创建共享引用。尝试在空共享指针中创建共享引用，将导致程序断言。

```
	//在取消引用前，确保共享指针为有效，避免潜在断言。	If (MySharedPointer.IsValid())	{		MySharedReference = MySharedPointer.ToSharedRef();	} 
```

## 比较

可测试共享引用彼此是否相等。在此情况下，相等表示引用相同对象。

```
	TSharedRef<FMyObjectType> ReferenceA, ReferenceB;	if (ReferenceA == ReferenceB)	{		// ...	}
```

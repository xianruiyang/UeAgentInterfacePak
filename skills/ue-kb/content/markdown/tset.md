# TSet

---
title: "TSet"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-containers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎中的容器", "TSet"]
---

# TSet

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎中的容器 / TSet

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-containers-in-unreal-engine

`TSet`类似于`TMap`和`TMultiMap`，但有一个重要区别：`TSet`是通过对元素求值的可覆盖函数，使用数据值本身作为键，而不是将数据值与独立的键相关联。 `TSet`可以非常快速地添加、查找和删除元素（恒定时间）。 默认情况下，`TSet`不支持重复的键，但使用模板参数可激活此行为。

## TSet

`TSet`是一种快速容器类，用于在排序不重要的情况下存储唯一元素。 在大多数情况下，只需要一种参数——元素类型。 但是，`TSet`可配置各种模板参数来改变其行为，使其更全面。 除了可指定从`DefaultKeyFuncs`的派生结构体来提供散列功能，还可允许集合中的多个键拥有相同的值。 它和其它容器类一样，可设置自定义内存分配器来存储数据。

和`TArray`一样，`TSet`是同质容器。换而言之，其所有元素均完全为相同类型。 `TSet`也是值类型，支持常规复制、赋值和析构函数操作，以及其元素较强的所有权。`TSet`被销毁时，其元素也将被销毁。 键类型也必须是值类型。

`TSet`使用散列，即如果给出了`KeyFuncs`模板参数，该参数会告知集合如何从某个元素确定键，如何比较两个键是否相等，如何对键进行散列，以及是否允许重复键。 它们默认只返回对键的引用，使用`operator==`对比相等性，使用非成员函数`GetTypeHash`进行散列。 默认情况下，集合中不允许有重复的键。 如果你的键类型支持这些函数，则可以将其用作集合键，无需提供自定义`KeyFuncs`。 要写入自定义`KeyFuncs`，可扩展`DefaultKeyFuncs`结构体。

最后，`TSet`可通过任选分配器控制内存分配行为。 标准虚幻引擎4（UE4）分配器（如`FHeapAllocator`和`TInlineAllocator`）不能用作`TSet`的分配器。 实际上，`TSet`使用集合分配器，该分配器可定义集合中使用的散列桶数量以及用于存储元素的标准UE4分配器。 请参见`TSetAllocator`了解更多信息。

与`TArray`不同的是，内存中`TMap`元素的相对排序既不可靠也不稳定，对这些元素进行迭代很可能会使它们返回的顺序和它们添加的顺序有所不同。 这些元素也不太可能在内存中连续排列。 集合中的后台数据结构是稀疏数组，即在数组中有空位。 从集合中移除元素时，稀疏数组中会出现空位。 将新的元素添加到阵列可填补这些空位。 但是，即便`TSet`不会打乱元素来填补空位，指向集元素的指针仍然可能失效，因为如果存储器被填满，又添加了新的元素，整个存储可能会重新分配。

> [!WARNING]
> TSet（如许多虚幻引擎容器）假设元素类型是简单可重定位的，意味着元素可以通过直接复制原始字节安全地从内存中的一个位置移动到另一个位置。

## 创建和填充集合

`TSet`的创建方法如下：

C++

```
TSet<FString> FruitSet;
```

这会创建一个空白`TSet`，用于存储`FString`数据。 `TSet`会直接使用`operator==`比较元素，使用`GetTypeHash`对其进行散列，然后使用标准的堆分配器。 此时尚未分配内存。

填充集合的标准方法是使用`Add`函数并提供键（元素）：

C++

```
FruitSet.Add(TEXT("Banana"));	FruitSet.Add(TEXT("Grapefruit"));	FruitSet.Add(TEXT("Pineapple"));	// FruitSet == [ "Banana", "Grapefruit", "Pineapple" ]
```

> [!NOTE]
> 此处的元素按插入顺序排列，但不保证这些元素在内存中实际保留此排序。 如果是新集合，可能会保留插入排序，但插入和删除的次数越多，新元素不出现在末尾的可能性越大。

由于此集合使用了默认分配器，可以确保键是唯一的。 如果尝试添加重复键，会发生以下情况：

C++

```
FruitSet.Add(TEXT("Pear"));	FruitSet.Add(TEXT("Banana"));	// FruitSet == [ "Banana", "Grapefruit", "Pineapple", "Pear" ]	// Note: Only one banana entry.
```

该集合现在包含4个元素。 "Pear"将数量从3增至4，但新的"Banana"没有改变集合中的元素数量，因为它替代了旧的"Banana"条目。

和`TArray`一样，还可使用`Emplace`代替`Add`，避免插入集合时创建临时文件：

C++

```
FruitSet.Emplace(TEXT("Orange"));	// FruitSet == [ "Banana", "Grapefruit", "Pineapple", "Pear", "Orange" ]
```

此处，参数直接传递给键类型的构造函数。 这可以避免为该值创建临时`FString`。 与`TArray`不同的是，只能使用单一参数构造函数将元素放到集合中。

也可使用`Append`函数进行合并来插入另一个集合中的所有元素：

C++

```
TSet<FString> FruitSet2;	FruitSet2.Emplace(TEXT("Kiwi"));	FruitSet2.Emplace(TEXT("Melon"));	FruitSet2.Emplace(TEXT("Mango"));	FruitSet2.Emplace(TEXT("Orange"));	FruitSet.Append(FruitSet2);	// FruitSet == [ "Banana", "Grapefruit", "Pineapple", "Pear", "Orange", "Kiwi", "Melon", "Mango" ]
```

在上述示例中，生成的集合和使用`Add`或`Emplace`进行单个添加是相同的。 源集合中的重复键将会替代目标集合中相应的键。

### 编辑UPROPERTY TSet

如果用`UPROPERTY`宏和一个可编辑的关键词（`EditAnywhere`、`EditDefaultsOnly`或`EditInstanceOnly`）标记`TSet`，则可[在虚幻编辑器中添加和编辑元素](../../../building-virtual-worlds/level-editor/level-editor-details-panel/index.md)。

C++

```
UPROPERTY(Category = SetExample, EditAnywhere)	TSet<FString> FruitSet;
```

## 迭代

`TSet`的迭代类似于`TArray`。 可使用C++的设置范围功能：

C++

```
for (auto& Elem : FruitSet)
	{
		FPlatformMisc::LocalPrint(
			*FString::Printf(
				TEXT(" \"%s\"\n"),
				*Elem
			)
		);
	}
	// Output:
```

也可以用`CreateIterator`和`CreateConstIterator`函数来创建迭代器。 `CreateIterator`返回拥有读写访问权限的迭代器，而`CreateConstIterator`返回拥有只读访问权限的迭代器。 无论哪种情况，均可用这些迭代器的`Key`和`Value`来检查元素。 通过迭代器复制示例中的"fruit"集合产生如下结果：

C++

```
for (auto It = FruitSet.CreateConstIterator(); It; ++It)	{		FPlatformMisc::LocalPrint(			*FString::Printf(				TEXT("(%s)\n"),				*It			)		);	}
```

## 查询

调用`Num`函数可查询集合中保存的元素数量：

C++

```
int32 Count = FruitSet.Num();	// Count == 8
```

要确定集合是否包含特定元素，可按如下所示调用`Contains`函数：

C++

```
bool bHasBanana = FruitSet.Contains(TEXT("Banana"));	bool bHasLemon = FruitSet.Contains(TEXT("Lemon"));	// bHasBanana == true	// bHasLemon == false
```

使用`FSetElementId`结构体可查找集合中某个键的索引。 然后，就可使用该索引与`operator[]`查找元素。 在非常量集合上调用`operator[]`将返回非常量引用，而在常量集合上调用将返回常量引用。

C++

```
FSetElementId BananaIndex = FruitSet.Index(TEXT("Banana"));
	// BananaIndex is a value between 0 and (FruitSet.Num() - 1)
	FPlatformMisc::LocalPrint(
		*FString::Printf(
			TEXT(" \"%s\"\n"),
			*FruitSet[BananaIndex]
		)
	);
	// Prints "Banana"
```

如果不确定集合中是否包含某个键，可使用`Contains`函数和`operator[]`进行检查。 但这并非理想的方法，因为同一键需要进行两次查找才能获取成功。 使用`Find`函数查找一次即可完成这些行为。 如果集合中包含该键，`Find`将返回指向元素数值的指针。如果映射不包含该键，则返回null。 对常量集合调用`Find`，返回的指针也将为常量。

C++

```
FString* PtrBanana = FruitSet.Find(TEXT("Banana"));	FString* PtrLemon = FruitSet.Find(TEXT("Lemon"));	// *PtrBanana == "Banana"	//  PtrLemon == nullptr
```

`Array`函数会返回一个`TArray`，其中填充了`TSet`中每个元素的一份副本。 被传递的数组在填入前会被清空，因此元素的生成数量将始终等于集合中的元素数量：

C++

```
TArray<FString> FruitArray = FruitSet.Array();	// FruitArray == [ "Banana","Grapefruit","Pineapple","Pear","Orange","Kiwi","Melon","Mango" ] (order may vary)
```

## 移除

通过`Remove`函数可按索引移除元素，但仅建议在通过元素迭代时使用：Remove函数会返回已删除元素的数量。 如果给定的键未包含在集合中，则会返回0。 如果`TSet`支持重复的键，`Remove`将移除所有匹配元素。

C++

```
FruitSet.Remove(0);	// FruitSet == [ "Grapefruit","Pineapple","Pear","Orange","Kiwi","Melon","Mango" ]
```

> [!NOTE]
> 移除元素将在数据结构（在Visual Studio的观察窗口中可视化集合时可看到）中留下空位，但为保证清晰度，此处省略。

C++

```
int32 RemovedAmountPineapple = FruitSet.Remove(TEXT("Pineapple"));	// RemovedAmountPineapple == 1	// FruitSet == [ "Grapefruit","Pear","Orange","Kiwi","Melon","Mango" ]	FString RemovedAmountLemon = FruitSet.Remove(TEXT("Lemon"));	// RemovedAmountLemon == 0
```

最后，使用`Empty`或`Reset`函数可将集合中的所有元素移除。

C++

```
TSet<FString> FruitSetCopy = FruitSet;	// FruitSetCopy == [ "Grapefruit","Pear","Orange","Kiwi","Melon","Mango" ] 	FruitSetCopy.Empty();	// FruitSetCopy == []
```

> [!NOTE]
> `Empty`和`Reset`相似，但`Empty`可采用参数指示集合中保留的Slack量，而`Reset`则是尽可能多地留出Slack量。

## 排序

`TSet`可以排序。 排序后，迭代集合会以排序的顺序显示元素，但下次修改集合时，排序可能会发生变化。 由于排序不稳定，可能按任何顺序显示集合中支持重复键的等效元素。

`Sort`函数使用指定排序顺序的二进制谓词，如下所示：

C++

```
FruitSet.Sort([](const FString& A, const FString& B) {		return A > B; // sort by reverse-alphabetical order	});	// FruitSet == [ "Pear", "Orange", "Melon", "Mango", "Kiwi", "Grapefruit" ] (order is temporarily guaranteed) 	FruitSet.Sort([](const FString& A, const FString& B) {		return A.Len() < B.Len(); // sort strings by length, shortest to longest	});	// FruitSet == [ "Pear", "Kiwi", "Melon", "Mango", "Orange", "Grapefruit" ] (order is temporarily guaranteed)
```

## 运算符

和`TArray`一样，`TSet`是常规数值类型，可使用标准复制构造函数或赋值运算符进行复制。 由于集合严格拥有其元素，复制集合的操作是深层的，因此新集合将拥有其自身的元素副本：

C++

```
TSet<int32, FString> NewSet = FruitSet;	NewSet.Add(TEXT("Apple"));	NewSet.Remove(TEXT("Pear"));	// FruitSet == [ "Pear", "Kiwi", "Melon", "Mango", "Orange", "Grapefruit" ]	// NewSet == [ "Kiwi", "Melon", "Mango", "Orange", "Grapefruit", "Apple" ]
```

## Slack

Slack是不包含元素的已分配内存。 调用`Reserve`可分配内存，无需添加元素；通过非零Slack参数调用`Reset`或`Empty`可移除元素，无需将其使用的内存取消分配。 Slack优化了将新元素添加到集合的过程，因为可以使用预先分配的内存，而不必分配新内存。 它在移除元素时也十分实用，因为系统不需要将内存取消分配。 在清空希望用相同或更少的元素立即重新填充的集合时，此方法尤其有效。

> [!NOTE]
> `TSet`不像`TArray`中的`Max`函数那样可检查预分配元素的数量。

以下代码可在不取消任何内存的情况下移除集合中的所有元素，从而产生slack：

C++

```
FruitSet.Reset();	// FruitSet == [ <invalid>, <invalid>, <invalid>, <invalid>, <invalid>, <invalid> ]
```

使用`Reserve`函数可直接创建Slack，例如在添加元素之前预分配内存。

C++

```
FruitSet.Reserve(10);	for (int32 i = 0; i < 10; ++i)	{		FruitSet.Add(FString::Printf(TEXT("Fruit%d"), i));	}	// FruitSet == [ "Fruit9", "Fruit8", "Fruit7" ... "Fruit2", "Fruit1", "Fruit0" ]
```

> [!NOTE]
> 预分配Slack已经导致新元素按相反顺序添加。 与数组不同，集合不试图维持元素顺序，处理集合的代码不应期望元素顺序稳定或可预测。

要从`TSet`移除所有Slack，请使用`Compact`和`Shrink`函数。 `Shrink`会从容器末尾移除所有Slack，但会在中间或开头留下任何空元素。

C++

```
// Remove every other element from the set.	for (int32 i = 0; i < 10; i += 2)	{		FruitSet.Remove(FSetElementId::FromInteger(i));	}	// FruitSet == ["Fruit8", <invalid>, "Fruit6", <invalid>, "Fruit4", <invalid>, "Fruit2", <invalid>, "Fruit0", <invalid> ] 	FruitSet.Shrink();	// FruitSet == ["Fruit8", <invalid>, "Fruit6", <invalid>, "Fruit4", <invalid>, "Fruit2", <invalid>, "Fruit0" ]
```

在上述代码中，`Shrink`只删除了一个无效元素，因为末端只有一个空元素。 要移除所有Slack，首先应调用`Compact`或`CompactStable`函数，将空白空间组合在一起，为调用`Shrink`做好准备。 顾名思义，`CompactStable`可在合并空元素时保持元素的排序。

C++

```
FruitSet.CompactStable();	// FruitSet == ["Fruit8", "Fruit6", "Fruit4", "Fruit2", "Fruit0", <invalid>, <invalid>, <invalid>, <invalid> ]	FruitSet.Shrink();	// FruitSet == ["Fruit8", "Fruit6", "Fruit4", "Fruit2", "Fruit0" ]
```

## DefaultKeyFuncs

只要类型具有`operator==`和非成员`GetTypeHash`重载，就可为TSet所用，因为此类型既是元素又是键。 然而，不便于重载这些函数时可将类型作为键使用。 在这些情况下，可对`DefaultKeyFuncs`进行自定义。 为键类型创建`KeyFuncs`，必须定义两个typedef和三个静态函数，如下所示：

- `KeyInitType`—— 用于传递键的类型。 通常抽取自ElementType模板参数。
- `ElementInitType`—— 用于传递元素的类型。 同样通常抽取自ElementType模板参数，因此与KeyInitType相同。
- `KeyInitType GetSetKey(ElementInitType Element)`——返回元素的键。 在集合中，通常是元素本身。
- `bool Matches(KeyInitType A, KeyInitType B)`——如果`A`和`B`等价则返回`true`，否则返回`false`。
- `uint32 GetKeyHash(KeyInitType Key)`——返回`Key`的散列值。

`KeyInitType`和`ElementInitType`是键/元素类型普通传递惯例的typedef。 它们通常为浅显类型的一个值和非浅显类型的一个常量引用。 请注意，集合的元素类型也是键类型，因此`DefaultKeyFuncs`仅使用一种模板参数`ElementType`定义两者。

`TSet`假定在`DefaultKeyFuncs`中使用`Matches`进行对比结果为相等的两个项也将在`KeyFuncs`的`GetKeyHash`中返回相同的值。

> [!WARNING]
> 切勿在更改现有元素时改变来自这两个函数中任一个的结果，因为这会使集合的内部散列失效。 使用`DefaultKeyFuncs`的默认实现时，此规则也适用于`operator==`和`GetKeyHash`的重载。

## 杂项

`CountBytes`和`GetAllocatedSize`函数用于估计内部数组的当前内存使用情况。 `CountBytes`接受`Farchive`参数，而`GetAllocatedSize`则不会。 这些函数常用于统计报告。

`Dump`函数接受`FOutputDevice`并写出关于集合内容的实现信息。 还有一个名为`DumpHashElements`的函数，可列出来自所有散列条目的所有元素。 这些函数常用于调试。


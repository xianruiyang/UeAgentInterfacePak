# TMap

---
title: "TMap"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/map-containers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎中的容器", "TMap"]
---

# TMap

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎中的容器 / TMap

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/map-containers-in-unreal-engine

继[TArray](https://dev.epicgames.com/documentation/assets/programming-and-scripting/programming-language-implementation/containers-in-unreal-engine/TArrays)之后，**虚幻引擎**中最常用的容器是[TMap](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMap?application_version=5.5)。 **TMap**与[TSet](../set-containers/index.md)类似，它们的结构均基于对键进行散列运算。 但与[TSet](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TSet?application_version=5.5)不同的是，此容器将数据存储为键值对（`TPair<KeyType, ValueType>`），只将键用于存储和获取。

## 虚幻引擎中的映射类型

虚幻引擎中提供了两种类型的映射：

- [TMap](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMap?application_version=5.5)
- [TMultiMap](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMultiMap?application_version=5.5)

### TMap概述

- 在 `TMap` 中，键值对被视为映射的元素类型，相当于每一对都是个体对象。 在本文中，元素就意味着键值对，而各个组件就被称作元素的键或元素的值。
- 元素类型实际上是`TPair<KeyType, ElementType>`，但很少需要直接引用TPair类型。
- TMap键是唯一的。
- 和 `TArray` 一样，`TMap` 也是同质容器，就是说它所有元素的类型都应完全相同。
- TMap` 也是值类型，支持通常的复制、赋值和析构函数运算，以及它的元素的强所有权。在映射被销毁时，它的元素都会被销毁。 键和值也必须为值类型。
- TMap是散列容器，这意味着键类型必须支持[GetTypeHash](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/GenericPlatform/GetTypeHash?application_version=5.5)函数，并提供`operator==`来比较各个键是否等值。稍后将详细介绍散列。

> [!WARNING]
> TMap和TMultimap（如许多虚幻引擎容器）假设元素类型是简单可重定位的，意味着元素可以通过直接复制原始字节安全地从内存中的一个位置移动到另一个位置。

### TMultiMap概述

- 支持存储多个相同的键。
- 当向TMap添加与现有键值对匹配的新键值对时，新键值对将替换旧键值对。
- 在TMultiMap中，容器会同时存储新键值对和旧键值对。

`TMap` 也可使用任选分配器来控制内存分配行为。 但不同于TArray，这些是集合分配器，而不是[FHeapAllocator](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/FHeapAllocator?application_version=5.5)和[TInlineAllocator](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/TraceLog/TInlineAllocator?application_version=5.5)之类的标准虚幻分配器。 **集合分配器**（[TSetAllocator类](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TSetAllocator?application_version=5.5)）定义映射应使用的散列桶数量，以及应使用哪个标准虚幻分配器来存储散列和元素。

`KeyFuncs`是最后一个TMap模板参数，该参数告知映射如何从元素类型获取键，如何比较两个键是否相等，以及如何对键进行散列计算。 这些参数有默认值，它们只会返回对键的引用，使用`operator==`确定相等性，并调用非成员[GetTypeHash](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/GenericPlatform/GetTypeHash?application_version=5.5)函数进行散列计算。 如果你的键类型支持这些函数，可使用它作为映射键，不需要提供自定义`KeyFuncs`。

与 `TArray` 不同的是，内存中 `TMap` 元素的相对排序既不可靠也不稳定，对这些元素进行迭代很可能会使它们返回的顺序和它们添加的顺序有所不同。 这些元素也不太可能在内存中连续排列。

映射的支持数据结构是稀疏数组，这种数组可有效支持元素之间的空位。 当元素从映射中被移除时，稀疏数组中就会出现空位。 将新的元素添加到数组可填补这些空位。 但是，即便 `TMap` 不会打乱元素来填补空位，指向映射元素的指针仍然可能失效，因为如果存储器被填满，又添加了新的元素，整个存储可能会重新分配。

## 创建和填充映射

**TMap**的创建方法如下：

C++

```
TMap<int32, FString> FruitMap;
```

`FruitMap`现在是一个字符串的空TMap，该字符串由整数键标识。 我们既没有指定分配器，也没有指定`KeyFuncs`，所以映射将执行标准的堆分配，使用`operator==`对键进行对比（`int32`类型），并使用[GetTypeHash](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/GenericPlatform/GetTypeHash?application_version=5.5)进行散列运算。 此时尚未分配内存。

### 添加

填充映射的标准方法是调用带一个键和值的[Add](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Add?application_version=5.5)函数：

C++

```
FruitMap.Add(5, TEXT("Banana"));FruitMap.Add(2, TEXT("Grapefruit"));FruitMap.Add(7, TEXT("Pineapple"));// FruitMap == [// 	{ Key: 5, Value: "Banana"     },// 	{ Key: 2, Value: "Grapefruit" },// 	{ Key: 7, Value: "Pineapple"  }// ]
```

> [!NOTE]
> 此处的元素按插入顺序排列，但不保证这些元素在内存中实际保留此排序。 如果是新的映射，可能会保留插入排序，但插入和删除的次数越多，新元素不出现在末尾的可能性就越大。

这不是`TMultiMap`，所以各个键都必定是唯一。 如果尝试添加重复键，会发生以下情况：

C++

```
FruitMap.Add(2, TEXT("Pear"));// FruitMap == [// 	{ Key: 5, Value: "Banana"    },// 	{ Key: 2, Value: "Pear"      },// 	{ Key: 7, Value: "Pineapple" }// ]
```

映射仍然包含3个元素，但之前键值为2的"Grapefruit"已被"Pear"替代。

[Add](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Add?application_version=5.5)函数可接受不带值的键。 调用此重载后的`Add`时，值将被默认构建：

C++

```
FruitMap.Add(4);// FruitMap == [// 	{ Key: 5, Value: "Banana"    },// 	{ Key: 2, Value: "Pear"      },// 	{ Key: 7, Value: "Pineapple" },// 	{ Key: 4, Value: ""          }// ]
```

### Emplace

和TArray一样，还可使用[Emplace](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Emplace?application_version=5.5)代替`Add`，防止插入映射时创建临时文件：

C++

```
FruitMap.Emplace(3, TEXT("Orange"));// FruitMap == [// 	{ Key: 5, Value: "Banana"    },// 	{ Key: 2, Value: "Pear"      },// 	{ Key: 7, Value: "Pineapple" },// 	{ Key: 4, Value: ""          },// 	{ Key: 3, Value: "Orange"    }// ]
```

此处直接将键和值传递给了各自的构造函数。 这对`int32`键实际上没有影响，但避免了为该值创建临时`FString`。 与 `TArray` 不同的是，只能通过单一参数构造函数将元素安放到映射中。

### 附加（Append）

你可以使用[Append](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMap/Append?application_version=5.5)函数合并两个映射，该函数将参数映射中的所有元素移动到调用对象映射中：

C++

```
TMap<int32, FString> FruitMap2;
FruitMap2.Emplace(4, TEXT("Kiwi"));
FruitMap2.Emplace(9, TEXT("Melon"));
FruitMap2.Emplace(5, TEXT("Mango"));
FruitMap.Append(FruitMap2);
// FruitMap == [
// 	{ Key: 5, Value: "Mango"     },
// 	{ Key: 2, Value: "Pear"      },
// 	{ Key: 7, Value: "Pineapple" },
// 	{ Key: 4, Value: "Kiwi"      },
```

在上面的示例中，生成的映射和使用`Add`或`Emplace`逐个添加`FruitMap2`的元素相同，在该过程完成时会清空`FruitMap2`。 这意味着如果`FruitMap2`中任何元素的键与`FruitMap`中原有元素的键相同，就会取代该元素。

如果用[UPROPERTY](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties?application_version=5.7)宏和一个可编辑的关键词（`EditAnywhere`、`EditDefaultsOnly`或`EditInstanceOnly`）标记TMap，即可[在编辑器中添加和编辑元素](../../../building-virtual-worlds/level-editor/level-editor-details-panel/index.md)。

C++

```
UPROPERTY(EditAnywhere, Category = MapsAndSets)TMap<int32, FString> FruitMap;
```

## 迭代

`TMaps` 的迭代类似于 `TArrays`。 可使用C++的设置范围功能，注意元素类型是 `TPair`：

C++

```
for (auto& Elem : FruitMap)
{
	FPlatformMisc::LocalPrint(
		*FString::Printf(
			TEXT("(%d, \"%s\")\n"),
			Elem.Key,
			*Elem.Value
		)
	);
}
```

也可以用[CreateIterator](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/CreateIterator?application_version=5.5)和[CreateConstIterators](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/CreateConstIterator?application_version=5.5)函数来创建迭代器。

| 功能 | 说明 |
| --- | --- |
| `CreateIterator` | 返回拥有读写访问权限的迭代器。 |
| `CreateConstIterator` | 返回拥有只读访问权限的迭代器。 |

无论哪种情况，均可用这些迭代器的`Key`和`Value`来检查元素。 使用迭代器显示`FruitMap`范例映射将产生如下结果：

C++

```
for (auto It = FruitMap.CreateConstIterator(); It; ++It){	FPlatformMisc::LocalPrint(		*FString::Printf(			TEXT("(%d, \"%s\")\n"),			It.Key(),   // same as It->Key			*It.Value() // same as *It->Value		)	);}
```

## 获取值

如果你知道映射包含某个键，你可以使用`operator[]`查找相应的值，使用键作为索引。 使用非const映射进行此操作会返回非const引用，而const映射会返回const引用。

> [!WARNING]
> 你应该始终在使用`operator[]`之前检查映射是否包含该键。 如果映射不包含该键，它将断言。

C++

```
FString Val7 = FruitMap[7];// Val7 == "Pineapple"FString Val8 = FruitMap[8];// Assert!
```

## 查询

调用[Num](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Num?application_version=5.5)函数即可查询映射中保存的元素数量：

C++

```
int32 Count = FruitMap.Num();// Count == 6
```

要确定映射是否包含特定键，可按下方所示调用`Contains`函数：

C++

```
bool bHas7 = FruitMap.Contains(7);bool bHas8 = FruitMap.Contains(8);// bHas7 == true// bHas8 == false
```

如果不确定映射中是否包含某个键，可使用[Contains](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Contains?application_version=5.5)函数和`operator[]`进行检查。 但这并非理想的方法，因为同一键需要进行两次查找才能获取成功。

使用[Find](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Find?application_version=5.5)函数查找一次即可完成这些行为。 如果映射包含该键，`Find`将返回指向元素数值的指针。如果映射不包含该键，则返回null。 在常量映射上调用`Find`，返回的指针也将为常量。

C++

```
FString* Ptr7 = FruitMap.Find(7);FString* Ptr8 = FruitMap.Find(8);// *Ptr7 == "Pineapple"//  Ptr8 == nullptr
```

或为了确保查询的结果有效，可使用[FindOrAdd](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/FindOrAdd?application_version=5.5)或[FindRef](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/FindRef?application_version=5.5)。

| 功能 | 说明 |
| --- | --- |
| `FindOrAdd` | 将返回对与给定键关联的值的引用。 如果映射中不存在该键，`FindOrAdd`将返回新创建的元素（使用给定键和默认构建值），该元素也会被添加到映射。`FindOrAdd`仅适用于非const映射。 |
| `FindRef` | 不要被名称迷惑，`FindRef` 会返回与给定键关联的值副本；若映射中未找到给定键，则返回默认构建值。 `FindRef`不会创建新元素，因此既可用于常量映射，也可用于非常量映射。 |

即使在映射中找不到键，`FindOrAdd`和`FindRef`也会成功运行，因此无需执行常规的安全规程（如提前检查`Contains`或对返回值进行空白检查）就可安全地调用。

C++

```
FString& Ref7 = FruitMap.FindOrAdd(7);
// Ref7     == "Pineapple"
// FruitMap == [
// 	{ Key: 5, Value: "Mango"     },
// 	{ Key: 2, Value: "Pear"      },
// 	{ Key: 7, Value: "Pineapple" },
// 	{ Key: 4, Value: "Kiwi"      },
// 	{ Key: 3, Value: "Orange"    },
// 	{ Key: 9, Value: "Melon"     }
// ]
```

> [!NOTE]
> 和示例中初始化`Ref8`时一样，`FindOrAdd`可向映射添加新条目，因此之前获得的指针（来自Find）或引用（来自FindOrAdd）可能会无效。 如果映射的后端存储需要扩展以容纳新元素，会执行分配内存和移动现有数据的添加操作，从而导致这一结果。 以上示例中，在调用`FindOrAdd(8)`之后，`Ref7`可能会紧随`Ref8`失效。

[FindKey](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/FindKey?application_version=5.5)函数执行逆向查找，这意味着提供的值与键匹配，并返回指向与所提供值配对的第一个键的指针。 搜索映射中不存在的值将返回空键。

C++

```
const int32* KeyMangoPtr   = FruitMap.FindKey(TEXT("Mango"));const int32* KeyKumquatPtr = FruitMap.FindKey(TEXT("Kumquat"));// *KeyMangoPtr   == 5//  KeyKumquatPtr == nullptr
```

> [!NOTE]
> 按值查找比按键查找慢（线性时间）。 这是因为映射是根据键而不是值进行哈希。 此外，如果映射有多个具有相同值的键，`FindKey`可返回其中任一键。

[GenerateKeyArray](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/GenerateKeyArray?application_version=5.5)和[GenerateValueArray](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/GenerateValueArray?application_version=5.5)分别使用所有键和值的副本来填充[TArray](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/TraceLog/TArray?application_version=5.5)。 在这两种情况下，都会在填充前清空所传递的数组，因此产生的元素数量始终等于映射中的元素数量。

C++

```
TArray<int32>   FruitKeys;TArray<FString> FruitValues;FruitKeys.Add(999);FruitKeys.Add(123);FruitMap.GenerateKeyArray  (FruitKeys);FruitMap.GenerateValueArray(FruitValues);// FruitKeys   == [ 5,2,7,4,3,9,8 ]// FruitValues == [ "Mango","Pear","Pineapple","Kiwi","Orange",//                  "Melon","" ]
```

## 删除（Remove）

从映射中移除元素的方法是使用[Remove](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Remove?application_version=5.5)函数并提供要移除元素的键。 返回值是被移除元素的数量。如果映射不包含与键匹配的元素，则返回值可为零。

C++

```
FruitMap.Remove(8);// FruitMap == [// 	{ Key: 5, Value: "Mango"     },// 	{ Key: 2, Value: "Pear"      },// 	{ Key: 7, Value: "Pineapple" },// 	{ Key: 4, Value: "Kiwi"      },// 	{ Key: 3, Value: "Orange"    },// 	{ Key: 9, Value: "Melon"     }// ]
```

> [!NOTE]
> 移除元素将在数据结构（在Visual Studio的观察窗口中可视化映射时可看到）中留下空位，但为保证清晰度，此处省略。

`FindAndRemoveChecked`函数可用于从映射移除元素并返回其值。 名称的"已检查"部分表示若键不存在，映射将调用 `check`。

C++

```
FString Removed7 = FruitMap.FindAndRemoveChecked(7);
// Removed7 == "Pineapple"
// FruitMap == [
// 	{ Key: 5, Value: "Mango"  },
// 	{ Key: 2, Value: "Pear"   },
// 	{ Key: 4, Value: "Kiwi"   },
// 	{ Key: 3, Value: "Orange" },
// 	{ Key: 9, Value: "Melon"  }
// ]
```

[RemoveAndCopyValue](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMap/RemoveAndCopyValue?application_version=5.5)函数的作用与`Remove`相似，不同点是会将已移除元素的值复制到引用参数。 如果映射中不存在指定的键，则输出参数将保持不变，函数将返回`false`。

C++

```
FString Removed;
bool bFound2 = FruitMap.RemoveAndCopyValue(2, Removed);
// bFound2  == true
// Removed  == "Pear"
// FruitMap == [
// 	{ Key: 5, Value: "Mango"  },
// 	{ Key: 4, Value: "Kiwi"   },
// 	{ Key: 3, Value: "Orange" },
// 	{ Key: 9, Value: "Melon"  }
// ]
```

最后，使用[Empty](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Empty?application_version=5.5)或[Reset](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Reset?application_version=5.5)函数可将映射中的所有元素移除。

C++

```
TMap<int32, FString> FruitMapCopy = FruitMap;// FruitMapCopy == [// 	{ Key: 5, Value: "Mango"  },// 	{ Key: 4, Value: "Kiwi"   },// 	{ Key: 3, Value: "Orange" },// 	{ Key: 9, Value: "Melon"  }// ] FruitMapCopy.Empty();		// You can also use Reset() here.// FruitMapCopy == []
```

> [!NOTE]
> `Empty`和Reset相似，但Empty可采用参数指示映射中保留的Slack量，而`Reset`则是尽可能多地留出Slack量。

## 排序

`TMap` 可以进行排序。 排序后，迭代映射会以排序的顺序显示元素，但下次修改映射时，排序可能会发生变化。 排序是不稳定的，因此等值元素在`MultiMap`中可能以任何顺序出现。

使用[KeySort](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TSortableMapBase/KeySort?application_version=5.5)或[ValueSort](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TSortableMapBase/ValueSort?application_version=5.5)函数可分别按键和值进行排序。 两个函数均使用二元谓词来进行排序：

C++

```
FruitMap.KeySort([](int32 A, int32 B) {
	return A > B; // sort keys in reverse
});
// FruitMap == [
// 	{ Key: 9, Value: "Melon"  },
// 	{ Key: 5, Value: "Mango"  },
// 	{ Key: 4, Value: "Kiwi"   },
// 	{ Key: 3, Value: "Orange" }
// ]
```

## 运算符

和TArray一样，TMap是常规数值类型，可使用标准复制构造函数或赋值运算符进行复制。 由于映射严格拥有其元素，复制映射的操作是深层的，因此新映射将拥有其自身的元素副本：

C++

```
TMap<int32, FString> NewMap = FruitMap;
NewMap[5] = "Apple";
NewMap.Remove(3);
// FruitMap == [
// 	{ Key: 4, Value: "Kiwi"   },
// 	{ Key: 5, Value: "Mango"  },
// 	{ Key: 9, Value: "Melon"  },
// 	{ Key: 3, Value: "Orange" }
// ]
// NewMap == [
```

TMap支持移动语义，使用`MoveTemp`函数可调用这些语义。 在移动后，源映射必定为空：

C++

```
FruitMap = MoveTemp(NewMap);// FruitMap == [// 	{ Key: 4, Value: "Kiwi"  },// 	{ Key: 5, Value: "Apple" },// 	{ Key: 9, Value: "Melon" }// ]// NewMap == []
```

## Slack

Slack是不包含元素的已分配内存。 调用[Reserve](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Reserve?application_version=5.5)可分配内存，无需添加元素；通过非零Slack参数调用[Reset](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Reset?application_version=5.5)或[Empty](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Empty?application_version=5.5)可移除元素，无需将其使用的内存取消分配。 Slack优化了将新元素添加到映射的过程，因为可以使用预先分配的内存，而不必分配新内存。 它在移除元素时也十分实用，因为系统不需要将内存取消分配。 在清空希望用相同或更少的元素立即重新填充的映射时，此方法尤其有效。

> [!NOTE]
> TMap不像TArray中的`Max`函数那样可以检查预分配元素的数量。

在下列代码中，`Reserve`函数预先分配映射，最多可包含10个元素。

C++

```
FruitMap.Reserve(10);
for (int32 i = 0; i < 10; ++i)
{
	FruitMap.Add(i, FString::Printf(TEXT("Fruit%d"), i));
}
// FruitMap == [
// 	{ Key: 9, Value: "Fruit9" },
// 	{ Key: 8, Value: "Fruit8" },
// 	...
// 	{ Key: 1, Value: "Fruit1" },
```

要从TMap移除所有Slack，请使用`Compact`和[Shrink](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Shrink?application_version=5.5)函数。 `Shrink`会从容器末尾移除所有Slack，但会在中间或开头留下任何空元素。

C++

```
for (int32 i = 0; i < 10; i += 2)
{
	FruitMap.Remove(i);
}
// FruitMap == [
// 	{ Key: 9, Value: "Fruit9" },
// 	<invalid>,
// 	{ Key: 7, Value: "Fruit7" },
// 	<invalid>,
// 	{ Key: 5, Value: "Fruit5" },
```

在上述代码中，`Shrink`只删除了一个无效元素，因为末端只有一个空元素。 要移除所有Slack，首先应调用[Compact](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Compact?application_version=5.5)函数，将空白空间组合在一起，为调用`Shrink`做好准备。

C++

```
FruitMap.Compact();
// FruitMap == [
// 	{ Key: 9, Value: "Fruit9" },
// 	{ Key: 7, Value: "Fruit7" },
// 	{ Key: 5, Value: "Fruit5" },
// 	{ Key: 3, Value: "Fruit3" },
// 	{ Key: 1, Value: "Fruit1" },
// 	<invalid>,
// 	<invalid>,
// 	<invalid>,
```

## KeyFuncs

只要类型具有`operator==`和非成员[GetTypeHash](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/GenericPlatform/GetTypeHash?application_version=5.5)重载，就可用作TMap的键类型，不需要任何更改。 但是，您可能需要将类型用作键，而不重载这些函数。 在这些情况下，可对[KeyFuncs](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/DefaultKeyFuncs?application_version=5.5)进行自定义。 为键类型创建 `KeyFuncs`，必须定义两个typedef和三个静态函数，如下所示：

| 类型定义 | 说明 |
| --- | --- |
| `KeyInitType` | 用于传递键的类型。 |
| `ElementInitType` | 用于传递元素的类型。 |

| 功能 | 说明 |
| --- | --- |
| `KeyInitType GetSetKey(ElementInitType Element)` | 返回元素的键。 |
| `bool Matches(KeyInitType A, KeyInitType B)` | 如果`A`和`B`等价则返回`true`，否则返回`false`。 |
| `uint32 GetKeyHash(KeyInitType Key)` | 返回`Key`的散列值。 |

`KeyInitType`和`ElementInitType`是键类型和值类型的常规传递约定的typedef。 它们通常为浅显类型的一个值和非浅显类型的一个常量引用。 请记住，映射的元素类型是`TPair`。

自定义 `KeyFuncs` 的示例可能如下所示：

MyCustomKeyFuncs.cpp

C++

```
struct FMyStruct
{
	// String which identifies our key
	FString UniqueID;

	// Some state which doesn't affect struct identity
	float SomeFloat;

	explicit FMyStruct(float InFloat)
		: UniqueID (FGuid::NewGuid().ToString())
```

`FMyStruct`具有唯一标识符，以及一些与身份无关的其他数据。 `GetTypeHash`和`operator==`不适用于此，因为`operator==`为实现通用目的不应忽略任何类型的数据，但同时又需要如此才能与`GetTypeHash`的行为保持一致，后者只关注*UniqueID*字段。

以下步骤有助于为`FMyStruct`创建自定义`KeyFuncs`：

1. 首先，继承`BaseKeyFuncs`，因为它可以帮助定义某些类型，包括`KeyInitType`和`ElementInitType`。

   - `BaseKeyFuncs`使用两个模板参数：

     1. 映射的元素类型。

        - 和所有映射一样，元素类型是`TPair`，使用`FMyStruct`作为其`KeyType`，`TMyStructMapKeyFuncs`的模板参数作为其`ValueType`。 将备用`KeyFuncs`用作模板，可为每个映射指定`ValueType`，因此每次要在`FMyStruct`上创建键控TMap时不必定义新的`KeyFuncs`。
     2. 我们键的类型。

        - 第二个`BaseKeyFuncs`参数是键类型，不要与元素存储的键区（TPair的`KeyType`）混淆。 因为此映射应使用`UniqueID`（来自`FMyStruct`）作为键，所以此处使用`FString`。
2. 定义三个必需的`KeyFuncs`静态函数。

   - 第一个是[GetSetKey](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/DefaultKeyFuncs/GetSetKey?application_version=5.5)，该函数返回给定元素类型的键。 由于元素类型是`TPair`，而键是`UniqueID`，所以该函数可直接返回`UniqueID`。
   - 第二个静态函数是[Matches](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/DefaultKeyFuncs/Matches?application_version=5.5)，该函数接受两个元素的键（由`GetSetKey`获取），然后比较它们是否相等。 在`FString`中，标准的等效测试（`operator==`）不区分大小写；要替换为区分大小写的搜索，请用相应的大小写对比选项使用`Compare()`函数。
   - 最后，`GetKeyHash`静态函数接受提取的键并返回其散列值。 由于`Matches`函数区分大小写，`GetKeyHash`也必须区分大小写。 区分大小写的[FCrc](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Misc/FCrc?application_version=5.5)函数将计算键字符串的散列值。
3. 现在结构已满足 `TMap` 要求的行为，可创建它的实例。

   C++

   ```
   TMap<
            FMyStruct,
            int32,
            FDefaultSetAllocator,
            TMyStructMapKeyFuncs<int32>
        > MyMapToInt32;

        // Add some elements
        MyMapToInt32.Add(FMyStruct(3.14f), 5);
        MyMapToInt32.Add(FMyStruct(1.23f), 2);
   ```

   > [!NOTE]
   > 本例指定了默认的集合分配器。 因为`KeyFuncs`参数处于最后，所以这个`TMap`类型需要该参数。

> [!NOTE]
> 在自行设置KeyFuncs时，要注意`TMap`假设两个项目使用[Matches](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/DefaultKeyFuncs/Matches?application_version=5.5)比较的结果相等，则它们会从`GetKeyHash`返回相同的值。 此外，如果对现有映射元素的键进行的修改将会改变来自这两个函数中任一个的结果，那么系统会将这种修改视作未定义的行为，因为这会使映射的内部散列失效。 这些规则也适用于使用默认`KeyFuncs`时`operator==`和`GetKeyHash`的重载。

## 杂项

`CountBytes`和`GetAllocatedSize`函数用于估计内部数组的当前内存使用情况。 `CountBytes`接受`Farchive`参数，而`GetAllocatedSize`则不会。 这些函数常用于统计报告。

[Dump](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMapBase/Dump?application_version=5.5)函数接受`FOutputDevice`，并写出关于映射内容的实现信息。 此函数常用于调试。


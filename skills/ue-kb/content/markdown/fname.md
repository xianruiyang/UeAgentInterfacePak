# FName

---
title: "FName"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fname-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "字符串处理", "FName"]
---

# FName

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 字符串处理 / FName

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fname-in-unreal-engine

FName是一种用于高效字符串处理的轻量级类型。具体而言，虚幻引擎会维护一个全局的唯一字符串表，而FName存储着一个实例编号以及指向给定字符串的索引引用，以便快速查找和访问。

此外，FName子系统使用哈希表格提供快速的字符串到FName转换。

FNames在表示对象名称、标识符和其他常被用于比较的字符串时尤其有用。当你在 **内容浏览器** 中命名了一个新资产、在动态材质实例（Dynamic Material Instance）中修改了一个参数、或访问了骨架网格体中的某个骨骼时，会使用 **FNames**。

FNames不区分大小写、不可变，且无法被操作。

## 创建 FNames

```
	FName TestHUDName = FName(TEXT("ThisIsMyTestFName"));
```

## 转换

FNames 只能被转换为 FStrings 和 FText，只能从 FStrings 进行转换。

### 从 FName

| 从 | 到 | 范例 |
| --- | --- | --- |
| FName | FString | `TestHUDString = TestHUDName.ToString();` |
| FName | FText | `TestHUDText = FText::FromName(TestHUDName);` FName -> FText 在一些情况下有效，但需注意——FNames内容不会从FText的"自动本地化"中受益。 |

### 到 FName

| 从 | 到 | 范例 |
| --- | --- | --- |
| FString | FName | `TestHUDName = FName(*TestHUDString);` FString -> FName不可靠。因为FName不区分大小写，所以转换存在损耗。 |
| FText | FName | FText不能直接转换成FName。它需要先转换成FString，然后再转成FName。 FText -> FString -> FName不可靠。因为FName不区分大小写，所以转换存在损耗 |

> [!NOTE]
> 执行这些转换时，需注意它们可能包含对创建中的 `FName` 类型无效的字符。 `NameTypes.h` 文件中的 `INVALID_NAME_CHARACTERS` 宏定义 FNames 中无效的字符； `FName` 中的数个函数（如 `IsValidObjectName()`）将对 FNames 在特定使用情况下的有效性进行检查。

## 对比

== 运算符用于对比两个 FNames，返回 true 或 false。它并不执行字符串的对比，而是对比索引中的数值，可极大地节约 CPU 开销。

**FName::Compare** 还可用于对比两个 FNames。如小于 Other 将返回小雨 0；如等于 Other 将返回 0；如大于 Other 将返回大于 0。

```
	CompareFloat = TestFName.Compare(OtherFName); 
```

## 使用 FName

FName 的使用简单直接。例如您需要从 Actor 的骨骼网格体组件中选择名为"pelvis（骨盆）"的骨骼。以下的 C++ 代码展示了即时构建的 FName 的使用，它将同时被传递到 **GetBoneRotation()**。

```
	FRotator rotPelvis = Mesh->MeshGetInstance(this))->GetBoneRotation(FName(TEXT("pelvis"))); 
```

此代码将创建一个传递到 `GetBoneRotation()` 的 FName，将返回相应骨骼的 FRotator。 包加载时骨骼命名将被加载到 FName 表格中，因此 FName 的构建函数可在散列表中找到骨骼的命名，不需要进行分配。

## 搜索名称表

如需确定 FName 是否在名称表中（但不希望进行自动添加），可在 FName 构建函数中补充一个不同的搜索类型：

```
	if( FName(TEXT("pelvis"), FNAME_Find) != NAME_None )	{		// Do something	}
```

如名称不在名称表中，FName 的索引将被设为 `NAME_None`。注意：将不对指针进行 null 检查，因为使用的是普通字符串。


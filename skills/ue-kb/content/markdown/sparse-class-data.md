# Sparse Class Data

---
title: "Sparse Class Data"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sparse-class-data-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "开发设置", "编程工具", "Sparse Class Data"]
---

# Sparse Class Data

> 路径：虚幻引擎5.7文档 / 用C++编程 / 开发设置 / 编程工具 / Sparse Class Data

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sparse-class-data-in-unreal-engine

**Sparse Class Data** 系统消除了常用 **Actor** 类型的冗余数据，从而节约了内存。开发游戏时，[蓝图公开属性](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties)为设计者提供了Actor行为迭代的好方法。但在发行游戏时，若许多属性的值在不同Actor实例中保持不变或者在游戏进程中保持不变，则此类属性实际上可能是常量。使用Sparse Class Data，可将此类属性转移到单个共享结构体实例中，仅在内存中保留一份属性副本，同时保留设计者在蓝图图表中访问其值并在类默认值中进行编辑的能力。要确定属性是否是Sparse Class Data的良好候选，请使用以下三方面的测试。若属性满足下列条件，则为良好候选：

1. Actor类成员且拥有许多游戏内实例，这意味着冗余副本占用了大量内存。
2. 在放置的Actor实例中保持不变。换言之，由于Actor实例不会覆盖或更改其基值，因此属性无需 `EditInstanceOnly` 或 `EditAnywhere` UProperty说明符。
3. 在C++代码中未进行修改。任何直接访问变量的C++代码都必须替换为对访问函数的调用。

> [!NOTE]
> 实现Sparse Class Data功能需要本地(C++)代码。任何蓝图声明的变量都必须移至C++代码，才有资格执行此过程。

## 实现示例

决定为某个类使用Sparse Class Data后，就必须标识候选属性。任何标记为 `EditAnywhere`、`EditInstanceOnly` 或 `BlueprintReadWrite` 的属性都不是Sparse Class Data的候选。同样，在本地 C++代码中发生了更改的任何属性都没有资格参与Sparse Class Data系统。这是因为属性在不同Actor实例上可能有不同的值，可通过在关卡编辑器中对每个实例进行编辑，也可通过蓝图脚本编写或本地代码在游戏过程中更改单个Actor实例上的值。以下示例类包含多个属性，其中一些是Sparse Class Data的候选：

```
	// 此类中的所有属性都可以在编辑器中更改，但基于每个类而不是每个实例。	UCLASS(BlueprintType)	class AMyActor : public AActor	{		GENERATED_UCLASS_BODY() 	public:		// 此属性可在编辑器中进改，但仅基于每个类。		// 蓝图图表无法访问或更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY(EditDefaultsOnly)		float MyFloatProperty; 		// 此属性无法在编辑器中进行更改。		// 蓝图图表可访问但无法更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY(BlueprintReadOnly)		int32 MyIntProperty; 		// 此属性可在编辑器中基于每个类进行更改。		// 蓝图图表可访问但无法更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)		FName MyNameProperty; 		// 此属性可在放置的MyActor实例上进行编辑。		// 它不是Sparse Class Data的潜在候选。		UPROPERTY(EditAnywhere)		FVector MyVectorProperty; 		// 此属性可在蓝图图表中进行更改。		// 它不是Sparse Class Data的潜在候选。		UPROPERTY(BlueprintReadWrite)		FVector2D MyVector2DProperty;	}; 
```

识别候选变量后，创建包含它们的结构体，并用 `BlueprintType` [UStruct说明符](https://dev.epicgames.com/documentation/404) 标记此结构体。此结构体中的每个属性都必须包括 `EditDefaultsOnly` 说明符。

```
	USTRUCT(BlueprintType)	struct FMySparseClassData	{		GENERATED_BODY() 		FMySparseClassData()		: MyFloatProperty(0.f)		, MyIntProperty(0)		, MyNameProperty(NAME_None)		{ } 		// 可在编辑器中设置此属性的默认值。		// 蓝图图表无法访问此属性。		UPROPERTY(EditDefaultsOnly)		float MyFloatProperty; 		// 将在 C++ 代码中设置此属性的值。		// 可在蓝图图表中访问（但无法更改）。		UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)		int32 MyIntProperty; 		// 可在编辑器中设置此属性的默认值。		// 可在蓝图图表中访问（但无法更改）。		// "GetByRef"意味着蓝图图表访问常量引用而非副本。		UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, meta=(GetByRef))		FName MyNameProperty;	}; 
```

> [!NOTE]
> 除非在Sparse Class Data结构体中指定属性类别，否则将接收默认名称。若是 `FMySparseClassData`，在编辑器中将显示为"My Sparse Class Data"。

原始类需要进行一些修改才能使用此结构体。此过程需要进行三项特定的更改：

- 告知类将此结构体用作Sparse Class Data类型。
- 在要移至新结构体的属性周围添加 `#if WITH_EDITORONLY_DATA` 预编译程序指令块，并在原始类用 `_DEPRECATED` 后缀标记。此外，删除所有UProperty说明符并将属性设置为 `private` 访问。不要更改代码的其他部分来使用 `_DEPRECATED` 名称；这些行将替换为对Sparse Class Data结构体的访问调用。
- 在编辑器编译(`#if WITH_EDITOR`)中，覆盖 `MoveDataToSparseClassDataStruct` 函数。此函数将执行从原始类到Sparse Class Data结构体的一次性复制来保存现有数据值。

进行上述更改后，类应如下所示：

```
	UCLASS(BlueprintType, SparseClassDataTypes = MySparseClassData)	class AMyActor : public AActor	{		GENERATED_BODY() 	#if WITH_EDITOR	public:		// ~ 此函数将现有数据传输到FMySparseClassData。		virtual void MoveDataToSparseClassDataStruct() const override;	#endif // WITH_EDITOR 	#if WITH_EDITORONLY_DATA		//~ 此类属性正在移至FMySparseClassData结构体：	private:		// 此属性可在编辑器中进改，但仅基于每个类。		// 蓝图图表无法访问或更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY()		float MyFloatProperty_DEPRECATED; 		// 此属性无法在编辑器中进行更改。		// 蓝图图表可访问但无法更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY()		int32 MyIntProperty_DEPRECATED; 		// 此属性可在编辑器中基于每个类进行更改。		// 蓝图图表可访问但无法更改此属性。		// 它是Sparse Class Data的潜在候选。		UPROPERTY()		FName MyNameProperty_DEPRECATED;	#endif // WITH_EDITORONLY_DATA 		//~ 剩余属性可基于每个实例进行更改，		//~ 因此在Sparse Class Data实现中不会涉及。	public:		// 此属性可在放置的MyActor实例上进行编辑。		// 它不是Sparse Class Data的潜在候选。		UPROPERTY(EditAnywhere)		FVector MyVectorProperty; 		// 此属性可在蓝图图表中进行更改。		// 它不是Sparse Class Data的潜在候选。		UPROPERTY(BlueprintReadWrite)		FVector2D MyVector2DProperty;	}; 
```

以下函数复制所有共享属性的现有值：

```
	#if WITH_EDITOR	void AMyActor::MoveDataToSparseClassDataStruct() const	{		// 若已保存稀疏数据，确保不会覆盖此数据		UBlueprintGeneratedClass* BPClass = Cast<UBlueprintGeneratedClass>(GetClass());		if (BPClass == nullptr || BPClass->bIsSparseClassDataSerializable == true)		{			return;		} 		Super::MoveDataToSparseClassDataStruct(); 		#if WITH_EDITORONLY_DATA		// 虚幻标头工具(UHT)将自动创建GetMySparseClassData。		FMySparseClassData* SparseClassData = GetMySparseClassData(); 		// 修改这些行以包括所有Sparse Class Data属性。		SparseClassData->MyFloatProperty = MyFloatProperty_DEPRECATED;		SparseClassData->MyIntProperty = MyIntProperty_DEPRECATED;		SparseClassData->MyNameProperty = MyNameProperty_DEPRECATED;		#endif // WITH_EDITORONLY_DATA	}	#endif // WITH_EDITOR
```

> [!NOTE]
> 您可能需要包括 `Engine/BlueprintGeneratedClass.h` 以编译上述函数。

此时，Sparse Class Data已就绪。在编辑器中编辑或访问受影响属性的用户不会注意到任何行为上的差异，同时发布编译过程中占用的内存会减小。若此类属性被引用在C++代码中，则用对获取函数的调用来替换对变量的任何访问尝试。例如，使用代码访问 `MyFloatProperty` 变量的位置现在应调用 `GetMyFloatProperty`。UHT将自动生成此函数。若您有重大获取函数且需要保留它的行为，`NoGetter` UProperty元数据说明符将指示UHT不要生成自身的获取函数。对于希望通过常量引用而非通过值来访问的变量，请使用 `GetByRef` UProperty元数据说明符。


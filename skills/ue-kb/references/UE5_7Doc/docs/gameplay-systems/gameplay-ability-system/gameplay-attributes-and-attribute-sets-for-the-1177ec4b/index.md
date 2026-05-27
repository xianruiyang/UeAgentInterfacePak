---
title: "Gameplay属性和属性集"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-attributes-and-attribute-sets-for-the-gameplay-ability-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay技能系统", "Gameplay属性和属性集"]
---

# Gameplay属性和属性集

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay技能系统 / Gameplay属性和属性集

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-attributes-and-attribute-sets-for-the-gameplay-ability-system-in-unreal-engine

**游戏技能系统（Gameplay Ability System）** 使用 **游戏属性（Gameplay Attributes）**（`FGameplayAttribute`）来保存、计算和修改与游戏相关的浮点值。这些值可以描述其拥有者的任何特征，比如角色的剩余生命值，车辆的最高速度，或者物品在损坏前可以使用的次数。游戏技能系统中的角色将他们的游戏属性存储在一个 **属性集（Attribute Set）** 中，该属性集有助于管理游戏属性与系统其他部分之间的交互，并将自己注册到角色的技能系统组件中。这些交互包括对数值范围的限定、临时数值变更、对永久改变基础值的事件做出反应等。

## 游戏属性

游戏属性会保持一个当前值和基础值，"当前"值是大多数计算和逻辑会使用的值，并且会受到当前活跃的[游戏效果](../gameplay-effects-for-the-gameplay-ability-system/index.md)的影响，而"基础"值则倾向在较长时间内保持固定。 举个例子，"跳跃高度"游戏玩法属性的基础值可能是100.0，但如果该角色有一个主动的[游戏玩法效果]，显示角色累了，只能跳到正常高度的70%，那么当前值就是70.0。如果该角色发生永久性改变，变得更善于跳跃，这可能是通过等级提升系统实现的，那么基础值可能会增加到110.0，而只要[游戏玩法效果]还在，当前值就会被计算为77.0。

要创建游戏属性，你必须首先新建一个属性集（Attribute Set）。然后你就可以将游戏属性添加到属性集中。

> [!NOTE]
> 在某些情况下，游戏属性可以在没有属性集的情况下存在。这通常表明，某个游戏属性被保存在一个 **技能系统组件（Ability System Component）** 上，而这个组件没有一个包含适当类型游戏属性的属性集。这种方法并不推荐，因为游戏属性除了作为浮点值保存外，不会与游戏技能系统的任何部分交互。

## 属性集

### 定义和设置

首先，设置一个带有一个或多个游戏玩法属性的属性集，然后将其注册到你的技能系统组件中。

1. 扩展基本属性集类`UAttributeSet`，并将游戏玩法属性添加为`FGameplayAttributeData` UProperties，以下是一个简单的单个游戏玩法属性的属性集：

   ```
        UCLASS()     class MYPROJECT_API UMyAttributeSet : public UAttributeSet     {         GENERATED_BODY()		         public:         /** Sample "Health" Attribute, publicly accessible */         UPROPERTY(EditAnywhere, BlueprintReadOnly)         FGameplayAttributeData Health;     };
   ```
2. 将属性集存储在Actor上，并将使其对虚幻引擎开放。使用`const`关键字来确保代码不能直接修改属性集，将其添加到你的Actor的类定义中：

   ```
        /** Sample Attribute Set. */     UPROPERTY()     const UMyAttributeSet* AttributeSet;
   ```
3. 把属性集注册到相应的技能系统组件中。这会在实例化属性集时自动进行，你可以在Actor的构造函数中进行，也可以在`BeginPlay`时进行，但前提是Actor的`GetAbilitySystemComponent`函数在实例化时返回一个有效的技能系统组件。你也可以编辑Actor的蓝图，并将属性集类添加到技能系统组件的默认起始数据中。第三种方法是指示技能系统组件实例化属性集，然后属性集会自动注册，以下就是一个案例：

   ```
        // 获取相应的技能系统组件。它可能在另一个Actor上，所以使用GetAbilitySystemComponent并检查结果是否有效。     AbilitySystemComponent* ASC = GetAbilitySystemComponent();     // 确保AbilitySystemComponent有效。如果失败是不可接受的，用check()语句替换这个if()条件。     if (IsValid(ASC))     {         // 从我们的技能系统组件中获取UMYAttributeSet。如有需要，技能系统组件将创建并注册一个UMYAttributeSet。         AttributeSet = ASC->GetSet<UMyAttributeSet>();		         // 我们现在有了一个指向新的UMyAttributeSet的指向器，以后可以使用该指向器。如果它有初始化函数，这里是调用它的好地方。     }
   ```

> [!NOTE]
> 一个技能系统组件可以有多个属性集，但每个属性集必须与所有其它属性集的类不同。

最后，应用游戏玩法效果来修改技能系统组件没有的游戏玩法属性，这样做会使技能系统组件为自己创建一个匹配的游戏玩法属性。然而，这个方法并不会创建一个属性集，也不会将游戏玩法属性添加到任何现有的属性集中。

1. 这是一个可选的步骤，添加一些基本的辅助函数来与游戏玩法属性交互。最好是将游戏玩法属性本身做成受保护或私有的，而将与之交互的函数公开。游戏技能系统有一组宏可以设置一些默认函数。

| 宏（带参数）｜生成函数的签名｜行为/用途｜

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| `GAMEPLAYATTRIBUTE_PROPERTY_GETTER(UMyAttributeSet, Health)` | `static FGameplayAttribute GetHealth()` | 静态函数从虚幻引擎的反射系统中返回`FGameplayAttribute`结构 |
| `GAMEPLAYATTRIBUTE_VALUE_GETTER(Health)` | `float GetHealth() const` | 返回"生命值"游戏玩法属性的当前值 |
| `GAMEPLAYATTRIBUTE_VALUE_SETTER(Health)` | `void SetHealth(float NewVal)` | 将"生命值"游戏玩法属性的值设置为`NewVal` |
| `GAMEPLAYATTRIBUTE_VALUE_INITTER(Health)` | `void InitHealth(float NewVal)` | 将"生命值"游戏玩法属性的值初始化为`NewVal` |

添加完这些之后，你的属性集类定义应该是如下所示：

```
	UCLASS()	class MYPROJECT_API UMyAttributeSet : public UAttributeSet	{		GENERATED_BODY() 		protected:		/** Sample "Health" Attribute */		UPROPERTY(EditAnywhere, BlueprintReadOnly)		FGameplayAttributeData Health; 		//~ ... Other Gameplay Attributes here ... 		public:		//~ Helper functions for "Health" attributes		GAMEPLAYATTRIBUTE_PROPERTY_GETTER(UMyAttributeSet, Health);		GAMEPLAYATTRIBUTE_VALUE_GETTER(Health);		GAMEPLAYATTRIBUTE_VALUE_SETTER(Health);		GAMEPLAYATTRIBUTE_VALUE_INITTER(Health); 		//~ ... Helper functions for other Gameplay Attributes here ...	};
```

虽然你可以不使用辅助函数，但它们是最佳做法。

这就建立了有单一游戏玩法属性的基本属性集。你还需要执行代码来控制游戏玩法属性的行为，你需要充分理解这些代码与这些值如何相互作用，以及它们在你的项目或你正在开发的特定Actor类中的含义。你可以通过控制对游戏玩法属性本身的访问，或者通过指导游戏玩法效果在技能集层面的工作方式来建立这个功能。

### 初始化

如果你选择不通过调用有硬编码值的初始化函数来初始化你的属性集和游戏玩法属性，你可以使用一个[数据表](../../data-driven-gameplay-elements/index.md#datatables)来初始化，使用名为"AttributeMetaData"的游戏玩法技能系统行类。你可以从外部文件导入数据，或者在编辑器中手动填充数据表。

创建数据表资产时，选择"AttributeMetaData"作为行类。

#### 导入数据表

开发者通常会从.csv文件中导入数据表，如下所示：

```
	---,BaseValue,MinValue,MaxValue,DerivedAttributeInfo,bCanStack	MyAttributeSet.Health,"100.000000","0.000000","150.000000","","False"
```

将.csv文件导入为数据表资产时，请选择"AttributeMetaData"行类型。

你可以添加额外的行来支持有多个游戏玩法属性的属性集。在上图所示的文件中，`UMyAttributeSet`中的"生命值"游戏玩法属性（反射系统中去掉前缀"U"）将以100的值初始化。它没有衍生信息，也不堆叠。

> [!NOTE]
> 虽然有MinValue(0.0)栏和MaxValue(150.0)栏，但游戏玩法属性和属性集并不具有内置的限制行为；这些栏中的值不会产生任何影响。

#### 手动填充数据表

如果你喜欢在虚幻编辑器中编辑数值，而不是在外部电子表格或文本编辑程序中编辑数值，你可以创建表格，然后像其它蓝图资产一样打开它来编辑数值。使用窗口顶部的"添加"按键为每个游戏玩法属性添加一行。请记住，命名惯例是"AttributeSetName.AttributeName"，也就是"属性集名称.属性名称"，而且是区分大小写的。

> [!NOTE]
> "最小值"和"最大值"栏不会在默认的游戏玩法技能系统插件中执行，这些值不会有任何影响。

### 控制游戏玩法属性访问

控制对游戏玩法属性的直接访问是一个很好的方法，这可以确保它们的值总是在你对它们设置的范围内。这是通过技能集来实现的，而不是通过扩展`FGameplayAttributeData`来实现的；`FGameplayAttributeData`仅存储Gameplay属性数据和提供对游戏玩法属性数据的访问。

为了限制"生命值"游戏玩法属性的值，使其永远不会小于零，你可以编写自己的getter和setter函数。删除`GAMEPLAYATTRIBUTE_VALUE_GETTER`和`GAMEPLAYATTRIBUTE_VALUE_SETTER`宏，用函数标头代替它们：

```
	GAMEPLAYATTRIBUTE_PROPERTY_GETTER(UMyAttributeSet, Health);	float GetHealth() const;	void SetHealth(float NewVal);	GAMEPLAYATTRIBUTE_VALUE_INITTER(Health);
```

在你的属性集的源文件中定义这些函数：

```
	float UMyAttributeSet::GetHealth() const	{		// 返回生命值的当前值，但不能返回一个小于零的值。		// 这是在考虑了所有影响生命值的修改器之后的值。		return FMath::Max(Health.GetCurrentValue(), 0.0f);	} 	void UMyAttributeSet::SetHealth(float NewVal)	{		// 不接受小于零的值。		NewVal = FMath::Max(NewVal, 0.0f); 		// 确保我们有技能系统组件实例，应该总是有这样的实例。		UAbilitySystemComponent* ASC = GetOwningAbilitySystemComponent();		if (ensure(ASC))		{			// 用适当的函数设置基础值（不是当前值）。			// 这可以确保我们应用的任何修改器仍能正常工作。			ASC->SetNumericAttributeBase(GetHealthAttribute(), NewVal);		}	} 	AbilitySystemComponent->GetGameplayAttributeValueChangeDelegate(AttributeSet->GetHealthAttribute()).AddUObject(this, &AGASAbilityDemoCharacter::OnHealthChangedInternal);
```

### 与游戏效果互动

对游戏玩法属性的值进行控制的常见方法是处理与之相关的[游戏玩法效果]。

1. 首先在属性集的类定义中覆盖`PostGameplayEffectExecute`函数，该函数应该是公共访问级别的。

   ```
        void PostGameplayEffectExecute(const struct FGameplayEffectModCallbackData& Data) override;
   ```
2. 在属性集的源文件中编写函数主体，务必要调用父类的执行。

   ```
        void UMyAttributeSet::PostGameplayEffectExecute(const struct FGameplayEffectModCallbackData& Data)     {         // 记得要调用父类的执行。         Super::PostGameplayEffectExecute(Data);		         // 通过使用属性获取器来查看这个调用是否会影响生命值。         if (Data.EvaluatedData.Attribute == GetHealthAttribute())         {             // 这个游戏玩法效果是改变生命值。应用它，但要先限制数值。             // 在这种情况下，生命值的基础值不可是负值。             SetHealth(FMath::Max(GetHealth(), 0.0f));         }     }
   ```

## 复制

对于多人游戏项目，你可以通过属性集复制游戏玩法属性，其方式类似于复制其它属性的方式。

1. 首先在属性集标头的属性定义中加入`ReplicatedUsing`[Specifier](../../../cpp-programming/containers/class-specifiers/index.md)，这将设置一个回调函数，有助于在远程系统上进行预测。

   ```
        protected:     /** Sample "Health" Attribute */     UPROPERTY(EditAnywhere, BlueprintReadOnly, ReplicatedUsing = OnRep_Health)     FGameplayAttributeData Health;
   ```
2. 声明你的复制回调函数：

   ```
        /** 当新的生命值达到网络时被调用 */     UFUNCTION()     virtual void OnRep_Health(const FGameplayAttributeData& OldHealth);
   ```
3. 在属性集的源文件中，定义你复制的回调函数。函数的主体可以用游戏玩法技能系统定义的一个宏来表示。

   ```
        void UMyAttributeSet::OnRep_Health(const FGameplayAttributeData& OldHealth)     {         // 使用默认的游戏玩法属性系统更新通知行为。         GAMEPLAYATTRIBUTE_REPNOTIFY(UMyAttributeSet, Health, OldHealth);     }
   ```
4. 如果这是你的属性集中的首个复制的属性，你要对公共的`GetLifetimeReplicatedProps`函数设置一个覆盖。

   ```
        /** Marks the properties we wish to replicate */     virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;
   ```
5. 将游戏玩法属性添加到属性集源文件中的`GetLifetimeReplicatedProps`函数中，如下所示：

   ```
        void UMyAttributeSet::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const     {         // 调用父函数。         Super::GetLifetimeReplicatedProps(OutLifetimeProps);		         // 为生命值添加复制功能。         DOREPLIFETIME_CONDITION_NOTIFY(UMyAttributeSet, Health, COND_None, REPNOTIFY_Always);     }
   ```

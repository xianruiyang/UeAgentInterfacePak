---
title: "游戏性类"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-classes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "游戏性架构", "游戏性类"]
---

# 游戏性类

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 游戏性架构 / 游戏性类

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-classes-in-unreal-engine

虚幻引擎中每个游戏性类都由一个类头文件（`.h`）和一个类源文件（`.cpp`）构成。类头包含类和类成员（如变量和函数）的声明，而在类源文件中通过 *实现* 属于类的函数来定义类的功能。

虚幻引擎中的类拥有一个标准化的命名方案，通过首字母或前缀即可立即明了其为哪种类。游戏性类的前缀有：

| 前缀 | 含义 |
| --- | --- |
| `A` | 从 *可生成的* 游戏性对象的基础类进行延伸。它们是 Actor，可直接生成到世界场景中。 |
| `U` | 从所有游戏性对象的基础类进行延伸。它们无法被实例到世界场景中，必须从属于 Actor。总体而言，它们是与 [组件](../../gameplay-framework/components/index.md)相似的对象。 |

## 添加类

[C++类向导](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md)将设置新类所需要的头文件和源文件，并随之更新游戏模块。头文件和源文件自动包含类声明和类构造函数，以及虚幻引擎专有代码 - 例如 `UCLASS()` 宏。

## 类头

虚幻引擎中的游戏性类通常拥有单独且唯一的类头文件。通常这些文件的命名与其中定义的类相匹配，减去 `A` 或 `U` 前缀，并使用 `.h` 文件扩展名。因此，`AActor` 类的类头文件命名为 `Actor.h`。虽然 Epic 代码遵循这些规则，但当前引擎中类名称和源文件名之间不存在正式关系。

游戏性类的类头文件使用标准 C++ 语法，并结合专门的宏，以简化类、变量和函数的声明过程。

在每个游戏性类头文件的顶端，需要包含生成的头文件（自动创建）。因此在 `ClassName.h` 的顶端必须出现以下行：

```
	#include "ClassName.generated.h" 
```

### 类声明

类声明定义类的名称、其继承的类，以及其继承的函数和变量。类声明还将定义通过 [类说明符](#%E7%B1%BB%E8%AF%B4%E6%98%8E%E7%AC%A6) 和元数据要求的其他引擎和编辑器特定行为。

类声明的语法如下所示：

```
	UCLASS([specifier, specifier, ...], [meta(key=value, key=value, ...)])	class ClassName : public ParentName	{		GENERATED_BODY()	} 
```

声明包含一个类的标准 C++ 类声明。在标准声明之上，描述符（如类说明符和元数据）将被传递到 `UCLASS` 宏。它们用于创建被声明类的 `UClass`，它可被看作引擎对类的专有表达。此外，`GENERATED_BODY()` 宏必须被放置在类体的最前方。

#### 类说明符

声明类时，可以为声明添加 **类说明符**，以控制类相对于引擎和编辑器的各个方面的行为。

| 类说明符 | 效果 |
| --- | --- |
| `Abstract` | **Abstract** 说明符会将类声明为"抽象基类"，阻止用户向关卡中添加此类的Actor。对于单独存在时没有意义的类，此说明符非常有用。例如，`ATriggerBase`基类是抽象类，而`ATriggerBox`子类不是抽象类，可以放置在关卡中。 |
| `AdvancedClassDisplay` | **AdvancedClassDisplay** 说明符强制类的所有属性仅在显示这些属性的["细节面板（Details Panel）"](../../../building-virtual-worlds/level-editor/level-editor-details-panel/index.md)的"高级（Advanced）"部分中显示。要覆盖单个属性上的此说明符，在该属性上使用`SimpleDisplay`说明符。 |
| `AutoCollapseCategories=(Category1, Category2, ...)` | `AutoCollapseCategories`说明符使父类上的 **AutoExpandCategories** 说明符的列出类别的效果无效。 |
| `AutoExpandCategories=(Category1, Category2, ...)` | 为此类的对象指定应自动在虚幻编辑器属性窗口中展开的一个或多个类别。要自动展开未使用类别声明的变量，请使用声明变量的类的名称。 |
| `Blueprintable` | 将此类公开为用于创建蓝图的可接受基类。默认为`NotBlueprintable`，除非继承时就并非如此。此说明符由子类继承。 |
| `BlueprintType` | 将此类公开为可用于蓝图中的变量的类型。 |
| `ClassGroup=GroupName` | 指示在虚幻编辑器的Actor浏览器中启用 **组视图（Group View）** 时，**Actor浏览器** 应在指定的 `GroupName` 中包含此类及此类的所有子类。 |
| `CollapseCategories` | 指示此类的属性不应划分到虚幻编辑器属性窗口的类别中。此说明符会传播到子类，可由`DontCollapseCategories`说明符覆盖。 |
| `Config=ConfigName` | 指示此类可在配置文件（`.ini`）中存储数据。如果存在任何使用`config`或`globalconfig`说明符声明的类属性，此说明符将使这些属性存储在指定的配置文件中。此说明符会传播到所有子类并且无法使此说明符无效，但是子类可通过重新声明`config`说明符并提供不同的`ConfigName`来更改配置文件。常见的`ConfigName`值是"Engine"、"Editor"、"Input"和"Game"。 |
| `Const` | 此类中的所有属性和函数都是`const`并且导出为`const`。此说明符由子类继承。 |
| `ConversionRoot` | 根转换，将子类限制为仅可沿层级向上转换为第一个根类的子类。 |
| `CustomConstructor` | 阻止构造函数声明自动生成。 |
| `DefaultToInstanced` | 此类的所有实例都被认为是"实例化的"。实例化的类（组件）将在构造时被复制。此说明符由子类继承。 |
| `DependsOn=(ClassName1, ClassName2, ...)` | 列出的所有类将先于此类被编译。提供的类名必须指示同一个或前一个包中的类。可以使用单个`DependsOn`行（以逗号分隔）来标识多个依赖类，或者可以通过为每个类使用单独的`DependsOn`行来指定多个依赖类。当某个类使用在另一个类中声明的结构体或枚举时，这非常重要，因为编译器仅知道它已编译了类中的哪些部分。 |
| `Deprecated` | 此类已弃用，序列化时将不保存此类的对象。此说明符由子类继承。 |
| `DontAutoCollapseCategories=(Category, Category, ...)` | 使列出的类别的继承自父类的`AutoCollapseCategories`说明符无效。 |
| `DontCollapseCategories` | 使继承自基类的`CollapseCatogories`说明符无效。 |
| `EditInlineNew` | 指示可以从虚幻编辑器"属性（Property）"窗口创建此类的对象，而非从现有资源引用。默认行为是仅可通过"属性（Property）"窗口指定对现有对象的引用。此说明符会传播到所有子类；子类可通过 `NotEditInlineNew` 说明符覆盖它。 |
| `HideCategories=(Category1, Category2, ...)` | 列出一个或多个应该对用户完全隐藏的分类。要隐藏未使用类别声明的属性，请使用声明变量的类的名称。此说明符会传播到子类。 |
| `HideDropdown` | 阻止此类在属性窗口组合框中显示。 |
| `HideFunctions=(Category1, Category2, ...)` | 让指定分类中的所有函数都对用户完全隐藏。 |
| `HideFunctions=FunctionName` | 将提到的函数对用户完全隐藏。 |
| `Intrinsic` | 指示此类直接在C++中声明，无 **Unreal Header Tool** 生成的样板。请勿在新类上使用此说明符。 |
| `MinimalAPI` | 导致仅导出此类的类型信息，以供其他模块使用。可以以此类为目标进行强制转换，但此类的函数无法被调用（除了使用内联方法）。这可以缩短编译时间，因为没有针对无需从其他模块访问其所有函数的类导出一切。 |
| `NoExport` | 指示此类的声明不应包含在由标头生成器自动生成的C++头文件中。必须在单独的头文件中手动定义该C++类声明。仅对本地类有效。请勿对新类使用此说明符。 |
| `NonTransient` | 使继承自基类的`Transient`说明符无效。 |
| `NotBlueprintable` | 指定此类不是可用于创建蓝图的可接受基类。此为默认说明符，将由子类继承。 |
| `NotPlaceable` | 使继承自基类的`Placeable`说明符无效。指示不可以在编辑器中将此类的对象放置到关卡、UI场景或蓝图中。 |
| `PerObjectConfig` | 此类的配置信息将按对象存储，在`.ini`文件中，每个对象都有一个分段，根据对象命名，格式为`[ObjectName ClassName]`。此说明符会传播到子类。 |
| `Placeable` | 指示可在编辑器中创建此类，而且可将此类放置到关卡、UI场景或蓝图（取决于类类型）中。此标志会传播到所有子类；子类可使用`NotPlaceable`说明符覆盖此标志。 |
| `ShowCategories=(Category1, Category2, ...)` | 使列出的类别的继承自基类的`HideCategories`说明符无效。 |
| `ShowFunctions=(Category1, Category2, ...)` | 在属性查看器中显示列出的类别中的所有函数。 |
| `ShowFunctions=FunctionName` | 在属性查看器中显示指定的函数。 |
| `Transient` | 从不将属于此类的对象保存到磁盘。当与播放器或窗口等本质上不持久的特定种类的原生类配合使用时，它非常有用。此说明符会传播到子类，但是可由`NonTransient`说明符覆盖。 |
| `Within=OuterClassName` | 此类的对象无法在`OuterClassName`对象的实例之外存在。这意味着，要创建此类的对象，需要提供`OuterClassName`的一个实例作为其`Outer`对象。 |

## 元数据说明符

声明类、接口、结构体、列举、列举值、函数，或属性时，可添加 **元数据说明符** 来控制其与引擎和编辑器各方面的相处方式。每一种类型的数据结构或成员都有自己的元数据说明符列表。

> [!WARNING]
> Metadata只存在于编辑器中。请不要编写能够访问到Metadata的游戏逻辑。

类可以使用以下元标签说明符：

| 类元标签 | 效果 |
| --- | --- |
| `BlueprintSpawnableComponent` | 如其存在，组件类可由蓝图生成。 |
| `BlueprintThreadSafe` | 只在蓝图函数库上有效。此说明符将把此类中的函数在动画蓝图中的非游戏线程上标记为可调用。 |
| `ChildCannotTick` | 用于Actor和组件类。如果本地类无法tick，那么基于此Actor或组件的蓝图生成类则无法tick，即使 `bCanBlueprintsTickByDefault` 为true也同样如此。 |
| `ChildCanTick` | 用于Actor和组件类。如果本地类无法tick，那么可以覆盖基于此Actor或组件的蓝图生成类的 `bCanEverTick` 标签，即使 `bCanBlueprintsTickByDefault` 为false也同样如此。 |
| `DeprecatedNode` | 用于行为树节点，说明类已废弃，编译时将显示一条警告。 |
| `DeprecationMessage="Message Text"` | 如果类已废弃，尝试编译使用此类的蓝图时，其将被添加到标准废弃警告。 |
| `DisplayName="Blueprint Node Name"` | 此节点在蓝图中的命名将被此处提供的值所取代，而非代码生成的命名。 |
| `DontUseGenericSpawnObject` | 不使用蓝图中的Generic Create Object节点来生成类的一个对象。此说明符只有在用于既非Actor又非ActorComponent的BluprintType类时才有意义。 |
| `ExposedAsyncProxy` | 在 **Async Task** 节点中公开此类的一个代理对象。 |
| `IgnoreCategoryKeywordsInSubclasses` | 用于让一个类的首个子类忽略所有继承的 `ShowCategories` 和 `HideCategories` 说明符。 |
| `IsBlueprintBase="true/false"` | 说明此类是否为创建蓝图的一个可接受基类，与 `UCLASS` 说明符、`Blueprintable` 或 `NotBlueprintable` 相似。 |
| `KismetHideOverrides="Event1, Event2, .."` | 不允许被覆盖的蓝图事件的列表。 |
| `ProhibitedInterfaces="Interface1, Interface2, .."` | 列出与类不兼容的接口。 |
| `RestrictedToClasses="Class1, Class2, .."` | 由蓝图函数库类使用，用于限制列表中命名类的用法。 |
| `ShortToolTip="Short tooltip"` | 完整提示文本过长时使用的简短提示文本，例如父类选取器对话。 |
| `ShowWorldContextPin` | 说明放置在此类拥有的图表中的蓝图节点必须显式其World情景引脚（即使其通常状态下为隐藏也同样如此），因为此类的对象无法被用作World情景。 |
| `UsesHierarchy` | 说明类使用层级数据。用于实例化"细节"面板中的层级编辑功能。 |
| `ToolTip="Hand-written tooltip"` | 覆盖从代码注释自动生成的提示文本。 |
| `ScriptName="DisplayName"` | 在将此类、属性或函数导出到脚本语言时使用的名称。可以包含以启用的名称作为以分号分隔的额外条目。 |

## 类实现

所有的游戏性类必须使用 `GENERATED_BODY` 宏进行正常实现。该执行在定义类和其所有变量和函数的类头（.h）文件中完成。最佳方法是使类源和头文件的命名与实现的类相匹配，减去 `A` 或 `U` 前缀。因此，`AActor` 类的源文件命名为 `Actor.cpp`，其头文件命名为 `Actor.h`。对编辑器中"Add C++ Class"菜单选项创建的类而言，此操作将自动进行。

源文件（.cpp）必须囊括包含 C++ 类声明的头文件（.h），C++ 类声明通常为自动生成，但也可手动生成（如有必要）。例如，`AActor` 类的 C++ 声明在 `EngineClasses.h` 头文件中自动生成。这意味着 `Actor.cpp` 文件必须包括 `EngineClasses.h` 文件或轮流包含的另一个文件。总体而言只包含游戏项目的头文件，其中包含了游戏项目中游戏性类的标头。以 `AActor` 和 `EngineClasses.h` 为例，其中包含了 `EnginePrivate.h` 标头，此标头则包含了 `Engine.h` - **Engine** 项目的头文件 - 而该头文件又包含 `EngineClasses.h` 头文件。

```
	#include "EnginePrivate.h" 
```

如在类函数实现中引用其他类（包含一个该文件未将类函数包括在内），则可能还需要包含额外的文件。

### 类构造函数

`UObjects` 使用 **Constructors** 设置属性和其他变量的默认值，并执行其他必要的初值设定。类构造函数通常放置在类实现文件中，如 `AActor::AActor` 构造函数位于 `Actor.cpp` 中。

> [!NOTE]
> 部分构造函数可能以每个模块为基础放置在一个特殊的"constructors"文件中。例如 `AActor::AActor` 构造函数可能存在于 `EngineConstructors.cpp` 中。这是自动转换过程的结果，从之前 `DEFAULTS` 块的使用到构造函数的使用。它们将随时间被移至其相应的类源文件。

也可以将构造函数内联放置在类头文件中。然而，如果构造函数在类头文件中，UClass 必须结合 `CustomConstructor` 说明符进行声明，因为这阻止了自动代码生成器在标头中创建构造函数声明。

#### 构造函数格式

UObject 构建函数最基本的形式如下所示：

```
	UMyObject::UMyObject()	{		// 在此处初始化 Class Default Object 属性。	} 
```

该构造函数初始化类默认对象（CDO），CDO 是类的新实例所基于的原版。此外还有一个次要构造函数，支持一个特殊的属性调整结构：

```
	UMyObject::UMyObject(const FObjectInitializer& ObjectInitializer)	:Super(ObjectInitializer)	{		// 在此处初始化 CDO 属性。	} 
```

虽然以上构造函数实际上并不执行任何初始化，但引擎已将所有字段初始化为零、NULL，或其默认构造函数实现的任意值。然而，写入构建函数的任意初始化代码将被应用至 CDO，因此将被复制到引擎中正确创建的对象新实例上，正如 `CreateNewObject` 或 `SpawnActor`。

被传入构造函数的 `FObjectInitializer` 参数除被标记为常数外，还可通过嵌入可变函数进行配置，以覆写属性和子对象。被创建的 `UObject` 将 受到这些变更的影响，这可用于变更注册属性或组件的数值。

```
	AUDKEmitterPool::AUDKEmitterPool(const FObjectInitializer& ObjectInitializer)	:Super(ObjectInitializer.DoNotCreateDefaultSubobject(TEXT("SomeComponent")).DoNotCreateDefaultSubobject(TEXT("SomeOtherComponent")))	{		// 在此处初始化 CDO 属性。	} 
```

在上例中，超类将在其构建函数中创建名为"SomeComponent"和"SomeOtherComponent"的子对象，但由于 FObjectInitializer 的原因，该操作将不会执行。在下例中，`SomeProperty` 在 CDO 中将默认为 26，因此在 AUTDemoHUD 的每个新实例中均为如此。

```
	AUTDemoHUD::AUTDemoHUD()	{		// 在此处初始化 CDO 属性。		SomeProperty = 26;	} 
```

#### 构建函数静态属性和助手

为更负责的数据类型设置数值（尤其是类引用、命名和资源引用）时，需要在构造函数中定义并实例化一个 **ConstructorStatics** 结构体，以保存所需的诸多属性数值。`ConstructorStatics` 结构体在构造函数首次运行时才会被创建。在随后的运行上它只会复制一个指针，使其处理速度极快。`ConstructorStatics` 被创建时，数值将被指定到结构体成员，以便稍后在构建函数上指定数值到实际属性时进行访问。

**ContructorHelpers** 是 `ObjectBase.h` 中定义的特殊命名空间。`ObjectBase.h` 包含用于执行构建函数特定常规操作的助手模板。例如为资源或类寻找引用、以及创建并寻找组件的助手模板。

##### 资源引用

理想状态下，类中的资源引用并不存在。硬编码资源引用很脆弱，优选方法是使用蓝图配置资源属性。然而，仍然完全支持硬编码引用。不需要在每次构造对象时搜索资源，因此这些搜索只执行一次。一个静态结构体可确保只执行一次资源搜索：

`ConstructorHelpers::FObjectFinder` 通过 `StaticLoadObject` 为特定的 `UObject` 寻找引用。它常用于引用存储在内容包中的资源。如未找到对象， 则报告失败。

```
	ATimelineTestActor::ATimelineTestActor()	{		// 进行一次性初始化的结构		struct FConstructorStatics		{			ConstructorHelpers::FObjectFinder<UStaticMesh> Object0;			FConstructorStatics()			:Object0(TEXT("StaticMesh'/Game/UT3/Pickups/Pickups/Health_Large/Mesh/S_Pickups_Base_Health_Large.S_Pickups_Base_Health_Large'"))			{			}		};		static FConstructorStatics ConstructorStatics; 		// 属性初始化 		StaticMesh = ConstructorStatics.Object0.Object;	} 
```

##### 类引用

`ConstructorHelpers::FClassFinder` 为特定的 `UClass` 寻找引用。如类未找到，则报告失败。

```
	APylon::APylon(const class FObjectInitializer& ObjectInitializer)	:Super(ObjectInitializer)	{		// 进行一次性初始化的结构		static FClassFinder<UNavigationMeshBase> ClassFinder(TEXT("class'Engine.NavigationMeshBase'"));		if (ClassFinder.Succeeded())		{			NavMeshClass = ClassFinder.Class;		}		else		{			NavMeshClass = nullptr;		}	} 
```

在许多情况下，可只使用 `USomeClass::StaticClass()`，绕开复杂的全部 ClassFinder。例如，在多数情况下均可使用以下方法：

```
	NavMeshClass = UNavigationMeshBase::StaticClass(); 
```

对跨模块的引用而言，使用 ClassFinder 法较好。

##### 组件和子对象

在构造函数中还可创建组件子对象并将其附着到 actor 的层级。生成一个 actor 时，将从 CDO 复制其组件。为确保组件固定被创建、被销毁和被正确地垃圾回收，构建函数中创建的每个组件的指针应被存储在拥有类的一个 UPROPERTY 中。

```
	UCLASS()	class AWindPointSource : public AActor	{		GENERATED_BODY()		public: 		UPROPERTY()		UWindPointSourceComponent* WindPointSource; 		UPROPERTY()		UDrawSphereComponent* DisplaySphere;	}; 	AWindPointSource::AWindPointSource()	{		// 创建一个新组件并对其命名。		WindPointSource = CreateDefaultSubobject<UWindPointSourceComponent>(TEXT("WindPointSourceComponent0")); 		// 将新组件设为该 actor 的根组件，如已存在一个根组件，则将其附着到根上。		if (RootComponent == nullptr)		{			RootComponent = WindPointSource;		}		else		{			WindPointSource->AttachTo(RootComponent);		} 		// 再创建一个组件。将其附着到刚才创建的第一个组件上。		DisplaySphere = CreateDefaultSubobject<UDrawSphereComponent>(TEXT("DrawSphereComponent0"));		DisplaySphere->AttachTo(RootComponent); 		// 在新组件上设置一些属性。		DisplaySphere->ShapeColor.R = 173;		DisplaySphere->ShapeColor.G = 239;		DisplaySphere->ShapeColor.B = 231;		DisplaySphere->ShapeColor.A = 255;		DisplaySphere->AlwaysLoadOnClient = false;		DisplaySphere->AlwaysLoadOnServer = false;		DisplaySphere->bAbsoluteScale = true;	} 通常没有必要对属于父类的组件进行修改。然而，在任何 `USceneComponent`（包括根组件）上调用 `GetAttachParent`、`GetParentComponents`、`GetNumChildrenComponents`、`GetChildrenComponents` 和 `GetChildComponent` 即可获得当前所有附着组件（包括父类创建的组件）的列表。
```

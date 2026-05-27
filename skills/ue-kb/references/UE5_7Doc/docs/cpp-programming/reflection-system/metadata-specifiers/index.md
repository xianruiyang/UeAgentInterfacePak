---
title: "元数据说明符"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/metadata-specifiers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统", "元数据说明符"]
---

# 元数据说明符

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统 / 元数据说明符

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/metadata-specifiers-in-unreal-engine

声明类、接口、结构体、列举、列举值、函数，或属性时，可添加 **元数据说明符** 来控制其与引擎和编辑器各方面的相处方式。每一种类型的数据结构或成员都有自己的元数据说明符列表。

> [!WARNING]
> Metadata只存在于编辑器中。请不要编写能够访问到Metadata的游戏逻辑。

要添加元数据说明符，需使用单词 `meta`，后接说明符列表。如有必要，可以将它们的值添加到 `UCLASS`、`UENUM`、`UINTERFACE`、`USTRUCT`、`UFUNCTION` 或 `UPROPERTY` 宏，如下所示：

```
{UCLASS/UENUM/UINTERFACE/USTRUCT/UFUNCTION/UPROPERTY}(SpecifierX, meta=(MetaTag1="Value1", MetaTag2, ..), SpecifierY)
```

要添加元数据说明符到列举值，可将 `UMETA` 标签添加到值本身。如果存在用于分隔的逗号，则要添加到逗号之前，如下所示：

```
UENUM()enum class EMyEnum : uint8{	// DefaultValue Tooltip	DefaultValue = 0 UMETA(MetaTag1="Value1", MetaTag2, ..), 	// ValueWithoutMetaSpecifiers Tooltip	ValueWithoutMetaSpecifiers, 	// ValueWithMetaSpecifiers Tooltip	ValueWithMetaSpecifiers UMETA((MetaTag1="Value1", MetaTag2, ..), 	// FinalValue Tooltip	FinalValue (MetaTag1="Value1", MetaTag2, ..)};
```

## 类元数据说明符

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

## 列举元数据说明符

列举可使用下列元数据说明符：

| 列举元标签 | 效果 |
| --- | --- |
| `位标记（Bitflags）` | 表示整数UPROPERTY变量（使用"位掩码"元数据说明符设置）可将此列举用作标记。 |
| `实验性（Experimental）` | 将此类型标记为试验性和不支持。 |
| `ToolTip="Hand-written tooltip"` | 覆盖在代码注释中自动生成的提示文本。 |

列举中的各值含有元数据说明符。此类元数据说明符与其他元数据说明符稍有不同，其使用顶层关键字 `UMETA`，且在修改的值之后（而非之前）进行指定。

| **列举值UMeta标签** | **效果** |
| --- | --- |
| `DisplayName="Enumerated Value Name"` | 此处提供的文本将使用该值命名，而非代码生成的命名。 |
| `Hidden` | 在编辑器中不显示该值。 |
| `ToolTip="Hand-written tooltip."` | 覆盖在代码注释中自动生成的提示文本。 |

## 接口元数据说明符

接口可以使用以下元标签说明符：

确保蓝图事件只允许在可实现的接口中出现。只允许内部函数 确保如果接口包含非蓝图定义的蓝图可调用函数，则必须在本地实现

| 接口元标签 | 效果 |
| --- | --- |
| `CannotImplementInterfaceInBlueprint` | 除了仅限内部的函数，此接口可能不包含[`BlueprintImplementableEvent` 或 `BlueprintNativeEvent`](https://dev.epicgames.com/documentation/404)函数。如果其包含蓝图可调用函数（但不是在蓝图中定义），函数必须在原生代码中实现。 |

## 结构体元数据说明符

结构体可以使用以下元标签说明符：

| 结构体元标签 | 效果 |
| --- | --- |
| `HasNativeBreak="Module.Class.Function"` | 说明此结构体拥有一个自定义Break Struct节点。必须提供模块、类和函数命名。 |
| `HasNativeMake="Module.Class.Function"` | 说明此结构体拥有一个自定义Break Struct节点。必须提供模块、类和函数命名。 |
| `HiddenByDefault` | Make Struct和Break Struct节点中的引脚默认为隐藏状态。 |
| `ShortToolTip="Short tooltip"` | 完整提示文本过长时使用的简短提示文本，例如父类选取器对话。 |
| `ToolTip="Hand-written tooltip` | 覆盖从代码注释自动生成的提示文本。 |

## 函数元数据说明符

| 函数元标签 | 效果 |
| --- | --- |
| `AdvancedDisplay="Parameter1, Parameter2, .."` | 以逗号分隔的参数列表将显示为高级引脚（需要UI扩展）。 |
| `AdvancedDisplay=N` | 用一个数字替代 `N` ，第N之后的所有参数将显示为高级引脚（需要UI扩展）。举例而言：'AdvancedDisplay=2' 将把前两个之外的所有参数标记为高级。 |
| `ArrayParm="Parameter1, Parameter2, .."` | 说明 `BlueprintCallable` 函数应使用一个Call Array Function节点，且列出的参数应被视为通配符数组属性。 |
| `ArrayTypeDependentParams="Parameter"` | 使用 `ArrayParm` 时，此说明符将指定一个参数，其将确定 `ArrayParm` 列表中所有参数的类型。 |
| `AutoCreateRefTerm="Parameter1, Parameter2, .."` | 如列出参数（由引用传递）的引脚未连接，其将拥有一个自动创建的默认项。这是蓝图的一个便利功能，经常在数组引脚上使用。 |
| `BlueprintAutocast` | 仅能由来自蓝图函数库的静态 `BlueprintPure` 函数使用。Cast节点将根据返回类型和函数首个参数的类型来自动添加。 |
| `BlueprintInternalUseOnly` | 此函数是一个内部实现细节，用于实现另一个函数或节点。其从未直接在蓝图图表中公开。 |
| `BlueprintProtected` | 此函数只能在蓝图中的拥有对象上调用。其无法在另一个实例上调用。 |
| `CallableWithoutWorldContext` | 用于拥有一个 `WorldContext` 引脚的 `BlueprintCallable` 函数，说明函数可被调用，即使其类不实现 `GetWorld` 函数也同样如此。 |
| `CommutativeAssociativeBinaryOperator` | 说明 `BlueprintCallable` 函数应使用Commutative Associative Binary节点。此节点缺少引脚命名，但拥有一个创建额外输入引脚的 **添加引脚（Add Pin）** 按钮。 |
| `CompactNodeTitle="Name"` | 说明 `BlueprintCallable` 函数应在压缩显示模式中显示，并提供在该模式中显示的命名。 |
| `CustomStructureParam="Parameter1, Parameter2, ..")` | 列出的参数都会被视为通配符。此说明符需要 `UFUNCTION`-level specifier、`CustomThunk`，而它们又需要用户提供自定义的 `exec` 函数。在此函数中，可对参数类型进行检查，可基于这些参数类型执行合适的函数调用。永不应调用基础 `UFUNCTION`，出现错误时应进行断言或记录。 要声明自定义 `exec` 函数，使用语法 `DECLARE_FUNCTION(execMyFunctionName)`，`MyFunctionName` 为原函数命名。 |
| `DefaultToSelf` | 用于 `BlueprintCallable` 函数，说明对象属性的命名默认值应为节点的自我情境。 |
| `DeprecatedFunction` | 蓝图对此函数进行引用时将引起编译警告，告知用户函数已废弃。可使用 `DeprecationMessage` 元数据说明符添加到废弃警告消息（如提供说明如何替代已废弃的函数）。 |
| `DeprecationMessage`="Message Text" | 如果函数已废弃，尝试编译使用此函数的蓝图时，其将被添加到标准废弃警告。 |
| `DeterminesOutputType="Parameter"` | 函数的返回类型将根据连接到命名参数引脚的输入动态更改。该参数应该是一个模板类型，比如 `TSubClassOf<X>` 或 `TSoftObjectPtr<X>`，其中函数的原始返回类型是 `X*` 或带有 `X*` 作为值类型的容器，比如 `TArray<X*>`。 |
| `DevelopmentOnly` | 被标记为 `DevelopmentOnly` 的函数只会在Development模式中运行。这适用于调试输出之类的功能（但其不应存在于发布产品中）。 |
| `DisplayName="Blueprint Node Name"` | 此节点在蓝图中的命名将被此处提供的值所取代，而非代码生成的命名。 |
| `ExpandEnumAsExecs="Parameter"` | 用于 `BlueprintCallable` 函数，说明应为参数使用的 `列举` 中的每个条目创建一个输入执行引脚。命名参数必须是引擎通过 `UENUM` 标签识别的一个列举类型。 |
| `ForceAsFunction` | 将没有来自事件的返回值的 `BlueprintImplementableEvent` 更改为函数。 |
| `HidePin="Parameter"` | 用于 `BlueprintCallable` 函数，说明参数引脚应从用户视图中隐藏。注意：使用此方式每个函数只能隐藏一个参数引脚。 |
| `HideSelfPin` | 隐藏用于指出函数调用所处对象的self引脚。self引脚在与调用蓝图的类兼容的 `BlueprintPure` 函数上为自动隐藏状态。这通常与 `DefaultToSelf` 说明符共用。 |
| `InternalUseParam="Parameter"` | 与 `HidePin` 相似，这将在用户视图中隐藏命名参数的引脚，只能用于一个函数的一个参数。 |
| `KeyWords="Set Of Keywords"` | 指定在搜索此函数时可使用的一套关键词，例如合适放置节点在蓝图图表中调用函数。 |
| `Latent` | 说明一个延迟操作。延迟操作拥有类型为 `FLatentActionInfo` 的一个参数，此参数由 `LatentInfo` 说明符命名。 |
| `LatentInfo="Parameter"` | 用于延迟 `BlueprintCallable` 函数，说明哪个参数是LatentInfo参数。 |
| `MaterialParameterCollectionFunction` | 用于 `BlueprintCallable` 函数，说明应使用材质覆盖节点。 |
| `NativeBreakFunc` | 用于 `BlueprintCallable` 函数，说明函数应以标准Break Struct节点的方式进行显示。 |
| `NotBlueprintThreadSafe` | 只在蓝图函数库中有效。此函数将被视为拥有类的整体 `BlueprintThreadSafe` 元数据的一个例外。 |
| `ShortToolTip="Short tooltip"` | 完整提示文本过长时使用的简短提示文本，例如父类选取器对话。 |
| `ToolTip="Hand-written tooltip` | 覆盖从代码注释自动生成的提示文本。 |
| `UnsafeDuringActorConstruction` | 在Actor构造时调用此函数并非安全操作。 |
| `WorldContext="Parameter"` | 由 `BlueprintCallable` 函数使用，说明哪个参数决定运算正在发生的World。 |
| `ScriptName="DisplayName"` | 在将此类、属性或函数导出到脚本语言时使用的名称。可以包含以启用的名称作为以分号分隔的额外条目。 |

## 属性元数据说明符

| 属性元标签 | 效果 |
| --- | --- |
| `AllowAbstract="true/false"` | 用于 `Subclass` 和 `SoftClass` 属性。说明抽象类属性是否应显示在类选取器中。 |
| `AllowedClasses="Class1, Class2, .."` | 用于 `FSoftObjectPath` 属性。逗号分隔的列表，表明要显示在资源选取器中的资源类类型。 |
| `AllowPreserveRatio` | 用于 `Fvector` 属性。在细节面板中显示此属性时将添加一个比率锁。 |
| `ArrayClamp="ArrayProperty"` | 用于整数属性。将可在UI中输入的有效值锁定在0和命名数组属性的长度之间。 |
| `AssetBundles` | 用于 `SoftObjectPtr` 或 `SoftObjectPath` 属性。主数据资源中使用的束列表命名，指定此引用属于哪个束的一部分。 |
| `BlueprintBaseOnly` | 用于 `Subclass` 和 `SoftClass` 属性。说明蓝图类是否应显示在类选取器中。 |
| `BlueprintCompilerGeneratedDefaults` | 属性默认项由蓝图编译器生成，`CopyPropertiesForUnrelatedObjects` 在编译后调用时将不会被复制。 |
| `ClampMin="N"` | 用于浮点和整数属性。指定可在属性中输入的最小值 `N`。 |
| `ClampMax="N"` | 用于浮点和整数属性。指定可在属性中输入的最大值 `N`。 |
| `ConfigHierarchyEditable` | 此属性被序列化为一个配置（`.ini`）文件，可在配置层级中的任意处进行设置。 |
| `ContentDir` | 由 `FDirectoryPath` 属性使用。说明将使用 `Content` 文件夹中的Slate风格目录选取器来选取路径。 |
| `DisplayAfter="PropertyName"` | 在蓝图编辑器中，名为 `PropertyName` 的属性后即刻显示此属性。前提是两个属性属于同一类别，则忽略其在源代码中的顺序进行显示。如多个属性有相同的 `DisplayAfter` 值和相同的 `DisplayPriority` 值，将在指定属性之后，按照自身在标头文件中声明的顺序显示。 |
| `DisplayName="Property Name"` | 此属性显示的命名，不显示代码生成的命名。 |
| `DisplayPriority="N"` | 如两个属性有相同的 `DisplayAfter` 值，或属于同一类别且无 `DisplayAfter` 元标签，则此属性将决定其顺序。最高优先级值为1，表示 `DisplayPriority` 值为1的属性将在 `DisplayProirity` 值为2的属性之上显示。如多个属性有相同的 `DisplayAfter` 值，其将按照在标头文件中声明的顺序显示。 |
| `DisplayThumbnail="true"` | 说明属性是一个资源类型，其应显示选中资源的缩略图。 |
| `EditCondition="BooleanPropertyName"` | 对一个布尔属性进行命名，此属性用于说明此属性的编辑是否被禁用。将"!"放置在属性命名前可颠倒测试。 EditCondition元标签不再不再局限于单个布尔属性。现在它使用一个功能完备的表达式解析器进行求值，这意味着你可以包含完整的C++表达式。 |
| `EditFixedOrder` | 使排列的元素无法通过拖拽来重新排序。EditCondition元标签不再仅限于单个布尔属性。它现在由完全成熟的算式解析器计算，意味着可以包含一个完整的C++表达式。 |
| `ExactClass="true"` | 结合 `AllowedClasses` 用于 `FSoftObjectPath` 属性。说明是否只能使用 `AllowedClasses` 中指定的准确类，或子类是否同样有效。 |
| `ExposeFunctionCategories="Category1, Category2, .."` | 在蓝图编辑器中编译一个函数列表时，指定其函数应被公开的类目的列表。 |
| `ExposeOnSpawn="true"` | 指定此属性是否应在此类类型的一个Spawn Actor节点上公开。 |
| `FilePathFilter="FileType"` | 由 `FFilePath` 属性使用。说明在文件选取器中显示的路径过滤器。常规值包括"uasset"和"umap"，但这些并非唯一可能的值。 |
| `GetByRef` | 使该属性的"Get"蓝图节点返回对属性的常量引用，而不是其值的副本。只对稀疏类数据生效，只能在不存在 `NoGetter` 时使用。 |
| `HideAlphaChannel` | 用于 `Fcolor` 和 `FLinearColor` 属性。说明详细显示属性控件时 `Alpha` 属性应为隐藏状态。 |
| `HideViewOptions` | 用于 `Subclass` 和 `SoftClass` 属性。隐藏在类选取器中修改显示选项的功能。 |
| `InlineEditConditionToggle` | 表示出布尔属性只内联显示为其他属性中的一个编辑条件切换，不应显示在其自身的行上。 |
| `LongPackageName` | 由 `FDirectoryPath` 属性使用。将路径转换为一个长的包命名。 |
| `MakeEditWidget` | 用于变换或旋转体属性，或变换/旋转体的排列。说明属性应在视口中公开为一个可移动控件。 |
| `NoGetter` | 防止蓝图为该属性生成一个"get"节点。只对稀疏类数据生效。 |
| `ScriptName="DisplayName"` | 在将此类、属性或函数导出到脚本语言时使用的名称。可以包含以启用的名称作为以分号分隔的额外条目。 |

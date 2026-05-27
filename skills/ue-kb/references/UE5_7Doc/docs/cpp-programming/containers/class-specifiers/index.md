---
title: "类说明符"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/class-specifiers"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎中的容器", "类说明符"]
---

# 类说明符

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎中的容器 / 类说明符

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/class-specifiers

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

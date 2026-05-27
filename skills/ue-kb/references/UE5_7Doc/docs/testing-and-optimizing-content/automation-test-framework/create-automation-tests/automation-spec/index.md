---
title: "自动化规范"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/automation-spec-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Create Automation Tests", "自动化规范"]
---

# 自动化规范

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Create Automation Tests / 自动化规范

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/automation-spec-in-unreal-engine

我们在现有的自动化测试框架中添加了一种新的自动化测试类型。这种新类型称为 **规范**。"规范"是一个术语，用于按照[行为驱动设计(BDD)](https://en.wikipedia.org/wiki/Behavior-driven_development)方法构建的测试。这是Web开发测试中使用的一个非常常见的方法，我们将其应用到我们的C++框架。

编写规范的原因有几个，其中包括：

- 它们是自文档化的
- 它们流畅且通常不自我重复的

  > [!NOTE]
  > DRY（不自我重复）
- 编写线程测试代码或潜在测试代码要容易得多
- 它们隔离期望（测试）
- 它们几乎可以用于所有类型的测试（功能测试、集成测试和单元测试）

## 如何设置规范

有两种方法来定义规范的标头，这两种方法都非常类似于我们定义测试类型的现有方法。

最简单的方法是使用 `DEFINE_SPEC` 宏，它采用的参数与所有其余测试定义宏所用的参数完全相同。

```
	DEFINE_SPEC(MyCustomSpec, "MyGame.MyCustomSpec", EAutomationTestFlags::ProductFilter | EAutomationTestFlags::ApplicationContextMask)	void MyCustomSpec::Define()	{	    //@todo 在此处写下我的期望	} 
```

唯一的替代方案是使用 `BEGIN_DEFINE_SPEC` 和 `END_DEFINE_SPEC` 宏。这些宏允许您将自己的成员定义为测试的一部分。在下一节中您将看到，有一个值包含与该指针相关的内容。

```
	BEGIN_DEFINE_SPEC(MyCustomSpec, "MyGame.MyCustomSpec", EAutomationTestFlags::ProductFilter | EAutomationTestFlags::ApplicationContextMask)		TSharedPtr<FMyAwesomeClass> AwesomeClass;	END_DEFINE_SPEC(MyCustomSpec)	void MyCustomSpec::Define()	{		//@todo 在此处写下我的期望	} 
```

唯一的其他提示是，您需要为规范类的 `Define()` 成员编写实现，而不是像为其他测试类型编写一样为 `RunTests()` 成员编写实现。

规范应该在文件中进行定义，文件扩展名为`.spec.cpp`，且名称不能含有"Test"一词。例如，`FItemCatalogService` 类可能包含文件 `ItemCatalogService.h`、`ItemCatalogService.cpp` 和 `ItemCatalogService.spec.cpp`。

> [!NOTE]
> 这是建议性指导，而不是技术限制。

## 如何定义您的期望

BDD的一个重要部分是，您是要测试公共API的期望，而不是测试特定实现。这样，您的测试就不会那么脆弱，从而更容易维护，如果突然出现相同API的多个不同实现，测试更有可能正常运行。

在规范中，使用两个不同的主要函数 `Describe()` 和 `It()` 来定义期望。

### Describe

`Describe()` 用于确定复杂期望的范围，以便它们更具可读性且更不会自我重复。使用 `Describe()` 使您的代码更加不会自我重复，这是基于它与其他支持函数（如 `BeforeEach()` 和 `AfterEach()`）之间的交互，具体如下：

```
	void Describe(const FString& Description, TFunction<void()> DoWork) 
```

`Describe()` 获取一个字符串，该字符串描述其中预期的范围，并获取一个lambda，该lambda定义这些预期。

可将 `Describe()` 放到另一个 `Describe()` 中来级联 `Describe()`。

请记住，`Describe()` 不是一个测试，不会在实际测试运行期间执行。当第一次在规范中定义期望（或测试）时，它们只执行一次。

### It

`It()` 是定义规范的实际期望的一小段代码。您可以从根 `Define()` 方法或从任意一个 `Describe()` lambda中调用 `It()`。理想情况下，应该使用 `It()` 来断言期望，但也可以使用它来为测试场景进行最终的几个设置。

> [!TIP]
> 通常，最好的做法是用"should"一词作为 `It()` 调用描述字符串的开头，表示"它应该"。

### 定义基本期望

这里有一个例子，它把所有这些结合起来定义一个非常简单的期望：

```
	BEGIN_DEFINE_SPEC(MyCustomSpec, "MyGame.MyCustomClass", EAutomationTestFlags::ProductFilter | EAutomationTestFlags::ApplicationContextMask)		TSharedPtr<FMyCustomClass> CustomClass;	END_DEFINE_SPEC(MyCustomSpec)	void MyCustomSpec::Define()	{		Describe("Execute()", [this]()		{			It("should return true when successful", [this]()			{				TestTrue("Execute", CustomClass->Execute());			}); 			It("should return false when unsuccessful", [this]()			{				TestFalse("Execute", CustomClass->Execute());			});		});	} 
```

正如您所见，这会导致测试自文档化，如果程序员花时间正确地描述期望，而没有将不同的期望组合在一起，这种情况更容易出现。将所有 `Describe()` 和 `It()` 调用组合在一起应构成可读性很强的语句，例如：

```
	如果成功，Execute()应返回true	如果失败，Execute()应返回false 
```

下面是一个更为复杂的示例，展示了自动化测试UI中成熟规范当前的状态：

本例中，`Driver`、`Element` 和 `Click` 均为 `Describe()` 调用，并由 `It()` 调用定义各种"should..."消息。

其中，每个 `It()` 调用都成为要执行的单独测试，因此，如果某个调用失败，而其他调用成功，则可以孤立执行。这样，因为调试测试变得更加轻松，所以维护测试也会更加简单。另外，由于测试会自文档化并孤立地执行，所以，当一个测试失败时，操作人员阅读测试报告会对发生的问题有更明确的了解——而不仅仅是知道一个名为[核心](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core)的大桶出现了故障。这意味着，问题会更快地传达给相关人员，调查问题所需的时间也会更短。

最后，单击上述任一测试都将直接转到定义它的 `It()` 语句。

### 规范期望如何转化为测试

以下是详细说明；不过，了解规范测试类型的底层行为，可以更容易了解以下一些复杂的特性。

规范测试类型仅在需要时才会执行一次 `Define()` 根函数。执行此函数时，会收集每个非 `Describe` lambda。`Define()` 完成后，会返回查看它收集的所有lambda或代码块，并为每个 `It()` 生成一组潜在命令。

因此，所有 `BeforeEach()`、`It()` 和 `AfterEach()` lambda代码块都放到一个执行链中，用于执行单个测试。当要求运行一个特定测试时，规范测试类型将对此特定测试的所有命令进行排队以便执行。在这种情况下，只有上一个块发出信号表示它已经执行完毕，下一个块才会继续执行。

### 其他特性

规范测试类型提供了几种其他特性，以便于编写复杂测试。特别是，它通常消除了直接使用自动化测试框架的潜在命令系统的需要，该系统虽强大却很麻烦。

下面是规范测试类型支持的特性列表，这些特性可以帮助处理更复杂的场景：

- BeforeEach和AfterEach
- AsyncExecution
- 潜在完成
- 参数化测试
- 重新定义
- 禁用测试

#### BeforeEach和AfterEach

`BeforeEach()` 和 `AfterEach()` 是核心函数，用于编写最琐碎的规范之外的任何其他内容。使用 `BeforeEach()`，您可以在运行随后的 `It()` 代码之前运行此代码。`AfterEach()` 同理，但会在运行 `It()` 代码之后运行此代码。

> [!NOTE]
> 请记住，每个"测试"只由一个It()调用组成。

例如：

```
	BEGIN_DEFINE_SPEC(AutomationSpec, "System.Automation.Spec", EAutomationTestFlags::SmokeFilter | EAutomationTestFlags::ApplicationContextMask)		FString RunOrder;	END_DEFINE_SPEC(AutomationSpec)	void AutomationSpec::Define()	{		Describe("A spec using BeforeEach and AfterEach", [this]()		{			BeforeEach([this]()			{				RunOrder = TEXT("A");			}); 			It("will run code before each spec in the Describe and after each spec in the Describe", [this]()			{				TestEqual("RunOrder", RunOrder, TEXT("A"));			}); 			AfterEach([this]()			{				RunOrder += TEXT("Z");				TestEqual("RunOrder", RunOrder, TEXT("AZ"));			});		});	} 
```

在我们的示例中，先定义 `BeforeEach()`，然后定义 `It()`，最后定义 `AfterEach()`，因此代码块是从上到下执行的。虽然这不是硬性要求，但我们建议您保持这一调用逻辑顺序。您可以打乱上述三个调用的顺序，最后始终会生成相同的测试。

在上面的示例中还会在 `AfterEach()` 中检查期望，这是极为异常的现象，也是测试规范测试类型本身的负面效应。同样，除了用于清理之外，我们不建议使用 `AfterEach()`。

您还可以执行多个 `BeforeEach()` 和 `AfterEach()` 调用，它们将按照定义它们的顺序被调用。正如第一个 `BeforeEach()` 调用会在第二个 `BeforeEach()` 调用之前执行，`AfterEach()` 的行为也非常类似——第一个调用在后续调用之前执行。

```
	BeforeEach([this]()	{		RunOrder = TEXT("A");	}); 	BeforeEach([this]()	{		RunOrder += TEXT("B");	}); 	It("will run code before each spec in the Describe and after each spec in the Describe", [this]()	{		TestEqual("RunOrder", RunOrder, TEXT("AB"));	}); 	AfterEach([this]()	{		RunOrder += TEXT("Y");		TestEqual("RunOrder", RunOrder, TEXT("ABY"));	}); 	AfterEach([this]()	{		RunOrder += TEXT("Z");		TestEqual("RunOrder", RunOrder, TEXT("ABYZ"));	}); 
```

此外，`BeforeEach()` 和 `AfterEach()` 受调用它们的 `Describe()` 作用域的影响。两者都只对处于相同调用作用域内的 `It()` 调用执行。

下面是一个复杂的示例，虽然调用顺序不当，但都得出正确的结果。

```
	BEGIN_DEFINE_SPEC(AutomationSpec, "System.Automation.Spec", EAutomationTestFlags::SmokeFilter | EAutomationTestFlags::ApplicationContextMask)		FString RunOrder;	END_DEFINE_SPEC(AutomationSpec)	void AutomationSpec::Define()	{		Describe("A spec using BeforeEach and AfterEach", [this]()		{			BeforeEach([this]()			{				RunOrder = TEXT("A");			}); 			AfterEach([this]()			{				RunOrder += TEXT("Z"); 				// 会导致				// TestEqual("RunOrder", RunOrder, TEXT("ABCYZ")); 	// 或这个，基于正在执行的It()				// TestEqual("RunOrder", RunOrder, TEXT("ABCDXYZ"));			}); 			BeforeEach([this]()			{				RunOrder += TEXT("B");			}); 			Describe("while nested inside another Describe", [this]()			{				AfterEach([this]()				{					RunOrder += TEXT("Y");				}); 	It("will run all BeforeEach blocks and all AfterEach blocks", [this]()				{					TestEqual("RunOrder", RunOrder, TEXT("ABC"));				}); 				BeforeEach([this]()				{					RunOrder += TEXT("C");				}); 				Describe("while nested inside yet another Describe", [this]()				{					It("will run all BeforeEach blocks and all AfterEach blocks", [this]()					{						TestEqual("RunOrder", RunOrder, TEXT("ABCD"));					}); 					AfterEach([this]()					{						RunOrder += TEXT("X");					}); 					BeforeEach([this]()					{						RunOrder += TEXT("D");					});				});			});		});	} 
```

#### AsyncExecution

利用规范测试类型，您还可轻松定义单个代码块的执行方式。只需将适当的 `EAsyncExecution` 类型传递到重载版本的 `BeforeEach()`、`It()` 和/或 `AfterEach()` 中即可。

例如：

```
	BeforeEach(EAsyncExecution::TaskGraph, [this]()	{	// 设置一些内容	)); 	It("should do something awesome", EAsyncExecution::ThreadPool, [this]()	{		// 执行一些内容	}); 	AfterEach(EAsyncExecution::Thread, [this]()	{		// 销毁一些内容	)); 
```

上述各个代码块都将以不同的方式执行，但采用有保障的执行顺序。`BeforeEach()` 块将作为任务在 `TaskGraph` 中运行，`It()` 将在线程池中的一个开放线程上运行，而 `AfterEach()` 将启动自己的专用线程，仅为运行一个代码块。

当必须模拟线程敏感型场景时，例如使用[自动化驱动程序](../automation-driver/index.md)，这些选项非常方便。

`AsyncExecution` 特性可与 `潜在完成（Latent Completion）` 特性组合起来。

#### 潜在完成

有时候，您需要编写测试来执行一个需要多个帧的操作，例如在执行查询时。在这些场景中，您可以使用重载的 `LatentBeforeEach()`、`LatentIt()` 和 `LatentAfterEach()` 成员。其中，每个成员都与非潜在变体完全相同，只是它们的lambda使用一个名为 `Done` 的简单委托。

使用潜在变体时，规范测试类型将不会继续执行测试序列中的下一个代码块，直到主动运行的潜在代码块调用Done委托。

```
	LatentIt("should return available items", [this](const FDoneDelegate& Done)	{		BackendService->QueryItems(this, &FMyCustomSpec::HandleQueryItemComplete, Done);	}); 	void FMyCustomSpec::HandleQueryItemsComplete(const TArray<FItem>& Items, FDoneDelegate Done)	{		TestEqual("Items.Num() == 5", Items.Num(), 5);	Done.Execute();	} 
```

正如您在示例中看到的，您可以将 `Done` 委托作为有效荷载传递给其他回调函数，使其可被潜在代码访问。因此，当执行上面的测试时，它将不会继续为 `It()` 执行任何 `AfterEach()` 代码块，直至执行 `Done` 委托为止（即使 `It()` 代码块已经完成执行）。

`潜在完成` 特性可与 `AsyncExecution` 特性组合起来。

#### 参数化测试

有时候，您需要以数据驱动的方式创建测试。而有时，这意味着从文件中读取输入并根据这些输入生成测试。其他情况下，理想的方式可能就是减少代码重复。无论哪种方式，规范测试类型都允许以一种非常自然的方式进行参数化测试。

```
	Describe("Basic Math", [this]()	{		for (int32 Index = 0; Index < 5; Index++)		{			It(FString::Printf(TEXT("should resolve %d + %d = %d"), Index, 2, Index + 2), [this, Index]()			{				TestEqual(FString::Printf(TEXT("%d + %d = %d"), Index, 2, Index + 2), Index + 2, Index + 2);			});		}	}); 
```

正如您在上面的示例中所看到的，创建参数化测试所需要做的就是动态调用其他规范函数，这些函数将参数化数据作为lambda有效荷载的一部分传递，同时生成唯一的描述。

在某些情况下，使用参数化测试可能会导致测试膨胀。作为单个测试的一部分，简单地从输入执行所有场景可能比较合理。您应该考虑输入的数量和生成的最终测试。以参数化的方式创建数据驱动测试的主要好处是，每个测试都可以单独运行，从而更容易重现。

#### Redefine

使用参数化测试时，有时可以在运行时方便地更改驱动输入的外部文件，并自动刷新测试。`Redefine()` 是规范测试类型的成员，当调用该函数时，将重新执行 `Define()` 流程。这将导致重新采集和整理测试的所有代码块。

执行上述操作最方便的方法是创建一小段代码，以侦听输入文件的更改，并根据需要在测试上调用 `Redefine()`。

#### 禁用测试

规范测试类型的每个 `Describe()`、`BeforeEach()`、`It()` 和 `AfterEach()` 成员都有一个变体，该变体以"x"为开头。例如，`xDescribe()`、`xBeforeEach()`、`xIt()` 和 `xAfterEach()`。这些变体是禁用代码块或 `Describe()` 的一种更为简单的方法。如果使用了一个 `xDescribe()`，则 `xDescribe()` 中的所有代码也都将被禁用。

这比注释掉需要迭代的期望要容易。

### 成熟示例

您可以在 `Engine/Plugins/Tests/AutomationDriverTests/Source/AutomationDriverTests/Private/AutomationDriver.spec.cpp` 中找到成熟的规范测试类型示例。这个规范目前包含120多个期望，并且在某个时候利用了大多数高级特性。

我们的启动程序团队还拥有规范框架的多种成熟用途，其中最成熟的用途之一是围绕 `BuildPatchServices` 编写的规范。

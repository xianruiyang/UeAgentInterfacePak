---
title: "自动化驱动程序"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/automation-driver-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Create Automation Tests", "自动化驱动程序"]
---

# 自动化驱动程序

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Create Automation Tests / 自动化驱动程序

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/automation-driver-in-unreal-engine

**自动化驱动程序（Automation Driver）** 是 **虚幻引擎** 的一个功能。利用该功能，程序员能够使用流畅的语法通过应用程序模拟用户输入。自动化驱动程序在特性集上与其他用于浏览器输入模拟的外部库非常相似，主要用于编写模拟用户行为的功能测试，就像其他这些库一样。

## 它能做什么？

自动化驱动程序模拟输入，这意味着它可以模拟光标移动、单击、按下、键入、滚动、拖放等等操作。这个自动化驱动程序的初始版本支持完整的传统桌面输入套件，基本上包括所有与键盘和鼠标相关的输入。未来，我们可能会将其扩展到包括触摸手势、控制器输入，甚至运动检测。

自动化驱动程序擅长以一种流畅的、可读性强、易于维护且相对不脆弱的方式模拟该输入。最重要的是，因为自动化驱动程序模拟平台层的输入，所以它的公共API不依赖于Slate，而且只需做少量工作，就可以扩展到使用场景Actor或者更多。

> [!NOTE]
> 另外，此特性还与平台无关，所以它可以在任何平台上使用，只要它能够模拟该平台的主要输入类型。

## 它如何工作？

在[核心](https://docs.unrealengine.com/en-US/API/Runtime/Core/index.html)中，几乎所有外部输入都要经过一组接口。自动化驱动程序创建这些接口的shim实现，利用一些基本的依赖性注入，它可以用其"传递"变体替换真正的实现。然后，这些"传递"变体就有机会委托哪些平台输入传递给应用程序，哪些不传递给应用程序，以及完全伪造自己的输入——这就是自动化驱动程序的工作方式。

## 如何使用它？

自动化驱动程序默认为禁用。您可以调用模块API上的 `Enable()` 函数来激活它。您可以调用 `Disable()` 函数来禁用它。

```
	IAutomationDriverModule::Get().Enable(); 	//@todo 此处模拟用户行为 	IAutomationDriverModule::Get().Disable(); 
```

一旦激活，自动化驱动程序即开始拦截应用程序接收的几乎所有平台输入。此时您可以创建自己的驱动程序实例。

```
	FAutomationDriverPtr Driver = IAutomationDriverModule::Get().CreateDriver(); 
```

一旦有了自己的驱动程序实例，便可开始模拟输入。下面是一个简单示例，演示如何模拟注册表单的输入：

```
	FDriverElementRef SignUpForm = Driver->FindElement(By::Id("Form"));	FDriverElementRef SubmitBtn = Driver->FindElement(By::Path("#Form//Submit")); 	FDriverSequenceRef Sequence = Driver->CreateSequence();	Sequence->Actions()		.Focus(SignUpForm)		.Type(TEXT("FirstName\tLastName\tFirstName.LastName@example.com"))		.Click(SubmitBtn);	Sequence->Perform(); 
```

### 使用API

有两个主要API与自动化驱动程序交互——一个同步API和一个异步API。同步API是最容易编写代码的，但您不能在GameThread上运行该代码。这是因为同步API进行拦截并等待输入模拟完成后才会继续。虽然输入模拟仍然作为潜在逻辑排队在GameThread上运行，但是拦截同步驱动程序API确保永远不会通过创建死锁来处理模拟输入——要避免这样做。

本文中的所有示例都将使用同步API，假设没有在GameThread上执行此逻辑。

> [!NOTE]
> 如果您发现这是一个具有挑战性的概念，那么您应该阅读有关新的[自动化规范](https://dev.epicgames.com/documentation/404)测试类型的内容。

### 查找元素

要生成任何有用的输入，第一步是确定要交互的应用程序的关键部分。自动化驱动程序利用定位器来实现这一点，而且还有一些顺畅的方法来使用一些现有的定位器，这些定位器能够发现基于Slate的元素。

#### By::Id()

要实现这一点，基于Id定位元素是最理想的方法。它要求程序员用显式的自动化驱动程序元数据Id来标记控件，因此中断的可能性要小得多。

标记控件很简单，可以像下面这样做：

```
	SNew(STextBlock)	.Text(InViewModel, &IViewModel::GetFirstName)	.AddMetaData(FDriverMetaData::Id("SignUpFormFirstNameField")) 
```

Id最好尽可能地明确，这样它们就不太可能与任何其他Id发生冲突，从而更容易引用它们。Id可以通过路径引用，从而由其他Id和元素限定范围。但最好生成一个唯一的Id，这样测试就不必依赖脆弱的作用域上下文。

例如，如果您的Id是唯一的，那么您可以像这样定位此控件：

```
	FDriverElementRef FirstNameField = Driver->FindElement(By::Id("SignUpFormFirstNameField")); 
```

如果您的Id不是唯一的，但表示一组唯一的元素，那么您可以使用以下命令立即定位所有这些元素：

```
	FDriverElementCollectionRef SignUpFormFields = Driver->FindElements(By::Id("SignUpFormField"));	TArray<FDriverElementRef> Fields = SignUpFormFields->GetElements(); 
```

在元素集合上调用 `GetElements()` 方法实际上启动了元素发现流程，所以要注意您正在寻找的元素是否已出现。您可能需要显式地等待它们出现。

#### By::Path()

按路径定位元素是当前可用的最脆弱但也最强大的定位方式。利用 `By::Path()` 定位器，您可以通过标签、Id和/或类型匹配来获取特定元素。

以下是一些语法示例：

```
	By::Path("#SignUpFormFirstNameField")	By::Path("FormField"))	By::Path("Documents//Tiles")	By::Path("<SAutomationDriverSpecSuite>")	By::Path("#Piano//#KeyB/<STextBlock>")	By::Path("#Suite//Form//Rows//#A1//<SEditableText>") 
```

##### 路径语法

| 语法 | 说明 |
| --- | --- |
| `#SignUpFormFirstNameField` | `#` 表示以下文本是显式Id，对于 `SWidget`，需要使用自动化驱动程序Id元数据对其进行标记。 |
| `FormField` | 纯文本表示一般标记，对于 `SWidget`，它需要有一个 `Tag` 或 `TagMetadata`，并具有匹配的纯文本值。 |
| `<STextBlock>` | `<>` 表示类型，对于 `SWidget`，它应该是 `SNew` 构造中使用的显式类型。您可以通过查看控件反射器轻松地使用类型创建路径。 |
| `/` | 层级由正斜杠表示，单正斜杠表示下一个值必须与前一个匹配的元素的直接子元素匹配。 |
| `//` | 层级由正斜杠表示，双正斜杠表示下一个值必须与前一个匹配的元素的任何后代匹配。 |

未来会向路径定位器添加更多的语法选项，但目前可用的选项就是这些。

> [!NOTE]
> 不支持转义字符，这意味着路径定位器无法成功匹配包含 `<` 或 `#` 前缀字符的标记或Id。

要查看其他语法使用示例，请通读：`Engine/Source/Developer/AutomationDriver/Private/Specs/AutomationDriver.spec.cpp`

#### By::Cursor()

此定位器直接返回光标当前位置下的元素。

```
	FDriverElementRef ElementUnderCursor = Driver->FindElement(By::Cursor()); 
```

#### By::Delegate()

如果上述的现有定位器都不能满足您的要求，那么您可以通过 `By::Delegate()` 或它的各种重载来传递您自己的委托或lambda。然后，在试图定位元素时，自动化驱动程序将在Game线程上调用代码块。

```
	FDriverElementRef CustomElement = Driver->FindElement(By::WidgetLambda([this](TArray<TSharedRef<SWidget>>& OutWidgets){		OutWidgets.Add(SpeciallyCachedWidget);	})); 
```

### 执行操作

主要有两种方式来利用自动化驱动程序执行操作。当处理单个元素（或一小组元素）时，最简单的方法是直接在 `FDriverElementRef` 上使用可用操作。另一个方法是创建一个 `FDriverSequenceRef`，这样您就能够将针对许多不同元素（或者根本没有特定元素）执行的一连串操作排入队列。

#### 元素

获得驱动程序元素引用后，就可以直接从它执行几个可用的操作，例如：

```
	Driver->FindElement(By::Id("Submit"))->Click(); 
```

在本例中，在获得对 `#Submit` 元素的引用之后，我们直接调用默认的 `Click` 方法。驱动程序元素引用中直接可用的所有操作只影响调用它们的元素。因此，对于上面的 `Click` 示例，自动化驱动程序将首先尝试将光标移动到 `#Submit` 元素。如果Slate DOM中不存在此元素，则驱动程序将等待一段隐式配置的时间间隔，此时间间隔在自动化驱动程序配置中有定义。如果此元素在超时之前出现，则驱动程序将尝试将光标移到此元素上。如果此元素在屏幕之外，驱动程序将尝试找出一个将此元素移动到屏幕上的方法，例如将其滚动到视图中。一旦此元素进入视图，光标被移动到此元素上，然后才模拟完整的单击。

所有驱动程序元素引用方法都以这种方式工作，因此它们的操作仅试图影响驱动程序元素。

#### 序列

驱动程序序列是为驱动程序发出操作的方法，此方法较为稳健。使用序列，您可以在不了解它可能会影响哪些元素的情况下执行操作，也可以针对一组特定元素执行操作。此外，序列还可以被多次调用，因此可重用性很高，非常适用于帮助库。

```
	FDriverSequenceRef Sequence = Driver->CreateSequence();	Sequence->Actions()		.MoveToElement(By::Id("Submit"))		.Click(EMouseButtons::Left);	Sequence->Perform(); 
```

在未调用 `Perform()` 之前，序列不执行其操作。一旦将操作添加到序列中，就不能移除它。在执行序列时，不能向序列添加其他操作，但可以在序列完成后添加其他操作。

如果任何操作失败，则整个序列失败，执行将在系列的这一点停止。

#### 操作

有关可以模拟的所有操作类型的详细信息，请参阅以下文件：

- Engine/Source/Developer/AutomationDriver/Public/IDriverElement.h
- Engine/Source/Developer/AutomationDriver/Public/IDriverSequence.h

目前，操作集合仅限于键盘和鼠标输入，通常包括：

- 鼠标移动
- 鼠标滚轮滚动
- 单击
- 双击
- 按住按钮
- 释放按钮
- 键入
- TypeChord

  > [!TIP]
  > 这便于执行键盘快捷键，如 **Ctrl**+**Shift**+**S**。
- 按住按键
- 释放按键
- 对焦

这包括补充性智能操作，例如滚动直至某个特定元素出现在视图中，获取某个元素显示的文本、大小或位置，等等。

虽然目前尚未积极开发，但我们计划支持以下功能：

- 场景/Actor交互
- 控制器输入
- 触摸输入/手势
- 运动检测

#### 等待

构建用户模拟的自动化测试时，等待各种事件的发生是很常见的，而且自动化驱动程序提供内置支持，让等待行为变得更简单。

对于任何依赖性场景，自动化驱动程序的所有操作都会自动等待一段配置的 `ImplicitWait` 时间间隔才执行，直至超时和操作失败。这方面的一个例子是，在为元素模拟单击事件之前，等待元素出现并可见。

您可以动态配置 `ImplicitWait` 时间间隔，在模拟过程中，还可以根据需要利用自动化驱动程序上的配置选项对它进行调整。例如：

当前默认的 `ImplicitWait` 时间间隔为3秒，您还可以执行显式或条件等待，例如：

```
	Driver->Wait(FTimespan::FromSeconds(2)); 	FDriverSequenceRef Sequence = Driver->CreateSequence();	Sequence->Actions()		.Wait(Until::ElementExists(ElementA, FWaitTimeout::InSeconds(3)))		.Focus(ElementA); 	Driver->Wait(Until::ElementIsVisible(ElementA, FWaitInterval::InSeconds(0.25), FWaitTimeout::InSeconds(1))); 	Driver->Wait(Until::ElementIsInteractable(ElementA, FWaitInterval::InSeconds(0.25), FWaitTimeout::InSeconds(1))); 	Driver->Wait(Until::ElementIsScrolledToBeginning(ScrollBox, FWaitTimeout::InSeconds(3))); 
```

您还可以指定自己的委托或lambda条件，在继续模拟之前，这些必须成功完成。最后，每个等待都有一个必需的超时参数和一个可选的时间间隔，后者定义重新计算等待条件的频率。

## 结合使用

由于自动化驱动程序API不能在 `GameThread` 上执行，编写模拟可能有点困难，但是如果将自动化驱动程序与新的规范测试类型结合起来，这就变得很简单了。

下面是用于规范期望（测试）的120多个测试中的一个测试片段，这些测试用于确保自动化驱动程序本身正常运行。

请阅读[自动化规范](https://dev.epicgames.com/documentation/404)测试类型文档，以更好地理解下面的代码片段：

```
	BEGIN_DEFINE_SPEC(FAutomationDriverSpec, "System.Automation.Driver", EAutomationTestFlags::ProductFilter | EAutomationTestFlags::ApplicationContextMask)		TSharedPtr<SWindow> SuiteWindow;		TSharedPtr<SAutomationDriverSpecSuite> SuiteWidget;		TSharedPtr<IAutomationDriverSpecSuiteViewModel> SuiteViewModel;		FAutomationDriverPtr Driver;	END_DEFINE_SPEC(FAutomationDriverSpec)	void FAutomationDriverSpec::Define()	{		BeforeEach([this]() {			if (IAutomationDriverModule::Get().IsEnabled())			{				IAutomationDriverModule::Get().Disable();			} 			IAutomationDriverModule::Get().Enable(); 			if (!SuiteViewModel.IsValid())			{				SuiteViewModel = FSpecSuiteViewModelFactory::Create();			} 			if (!SuiteWidget.IsValid())			{				SuiteWidget = SNew(SAutomationDriverSpecSuite, SuiteViewModel.ToSharedRef());			} 			if (!SuiteWindow.IsValid())			{				SuiteWindow = FSlateApplication::Get().AddWindow(					SNew(SWindow)					.Title(FText::FromString(TEXT("Automation Driver Spec Suite")))					.ClientSize(FVector2D(600, 540))					[						SuiteWidget.ToSharedRef()					]);			} 			SuiteWidget->RestoreContents();			SuiteWindow->BringToFront(true);			SuiteViewModel->Reset(); 			Driver = IAutomationDriverModule::Get().CreateDriver();		}); 		Describe("Element", [this]()		{			Describe("Type", [this]()			{				It("should focus the element and type the characters of the specified string", EAsyncExecution::ThreadPool, [this]()				{					FDriverElementRef Element = Driver->FindElement(By::Id("A1"));					Element->Type(TEXT("ABCDEFGHIJKLMNOPQRSTUVWXYZ"));					TEST_EQUAL(SuiteViewModel->GetFormString(EFormElement::A1), TEXT("ABCDEFGHIJKLMNOPQRSTUVWXYZ"));				});			});		}); 		AfterEach([this]() {			Driver.Reset();			IAutomationDriverModule::Get().Disable();		});	} 
```

主要要点是在 `GameThread` 上执行传递给 `BeforeEach()` 的lambda，为测试设置场景，创建控件，并相应地定位窗口。`It()` lambda是实际输入模拟所发生的地方，如果仔细观察，您会发现此函数将 `EAsyncExecution::ThreadPool` 值传递给 `It()`。这导致lambda在一个与 `GameThread` 分离的线程上执行，而在 `GameThread` 上模拟输入是安全的。因此，您可以在自动化驱动程序代码中放置断点，并在执行各种操作时单步调试执行这些操作。最后，`AfterEach()` 清理环境，然后返回到 `GameThread` 上执行 `AfterEach()`。

### 最后提示

在处理自动化驱动程序代码时，一定要注意您不是在 `GameThread` 上操作，因此，复制非线程安全的[SharedPtrs](../../../../cpp-programming/reflection-system/smart-pointers/shared-pointers/index.md)是不安全的。这是一个重要的调用，因为Slate只使用非线程安全的 `SharedPtrs`。

如果您必须使用非线程安全的 `SharedPtr` 访问来某些内容，那么您应该为您的测试设置专门的 `BeforeEach()` 块，从而能够在模拟和检查行为时在线程之间进行切换。

如果您知道在执行测试时不会销毁 `SharedPtr`，那么另一种替代方法是，将它缓存到测试类本身，这样lambda就可以访问 `SharedPtr`，而不能复制它，因此引用计数不会导致竞争条件。我们使用上面代码片段中的 `SuiteViewModel` 来实现这一点。

通常，最好的做法是，在一个专门的 `BeforeEach()` 块中执行所有的自动化驱动程序模拟，然后在 `GameThread` 上在 `It()` 中执行期望检查。

---
title: "断言"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/asserts-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "游戏性架构", "断言"]
---

# 断言

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 游戏性架构 / 断言

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/asserts-in-unreal-engine

在C和C++编程中，`assert` 可在开发期间帮助检测和诊断不正常或无效的运行时条件。这些条件通常检查是否指针为非空、除数为非零、函数并非递归运行，或代码要求的其他重要假设。但每次检查会使得效率十分低下。某些情况下，`assert` 会在延迟崩溃发生之前发现导致该崩溃的bug，例如删除未来tick所需的对象，协助开发人员发现引起崩溃的根本原因。`assert` 的关键特性之一是不存在于发布代码中，这意味着不但不会影响发布产品的性能，也没有任何副作用。对 `assert` 最简单的理解就是："断言"必须一律为true，否则程序会停止运行。

虚幻引擎提供 `assert` 等同项的三个不同族系：`check`、`verify` 和 `ensure`。若要检查这些功能背后的代码，可在 `Engine/Source/Runtime/Core/Public/Misc/AssertionMacros.h` 中找到相关的宏。各个功能的行为略有不同，但它们都是开发期间使用的诊断工具，目标大致相同。

## Check

Check族系最接近基础 `assert`，因为当第一个参数得出的值为false时，此族系的成员会停止执行，且默认不会在发布版本中运行。以下Check宏可用：

| 宏 | 参数 | 行为 |
| --- | --- | --- |
| `check` 或 `checkSlow` | `Expression` | 若 `Expression` 为false，停止执行 |
| `checkf` 或 `checkfSlow` | `Expression`、`FormattedText`、`...` | 若 `Expression` 为false，则停止执行并将 `FormattedText` 输出到日志 |
| `checkCode` | `Code` | 在运行一次的do-while循环结构中执行 `Code`；主要用于准备另一个Check所需的信息 |
| `checkNoEntry` | （无） | 若此行被hit，则停止执行，类似于 `check(false)`，但主要用于应不可到达的代码路径 |
| `checkNoReentry` | （无） | 若此行被hit超过一次，则停止执行 |
| `checkNoRecursion` | （无） | 若此行被hit超过一次而未离开作用域，则停止执行 |
| `unimplemented` | （无） | 若此行被hit，则停止执行，类似于 `check(false)`，但主要用于应被覆盖而不会被调用的虚拟函数 |

默认情况下，检查仅在调试（Debug）和开发（Development）构建中运行的宏。Slow"结尾的宏仅在调试（Debug）版本中运行。设置 `USE_CHECKS_IN_SHIPPING=1` 可以启用在测试（Test）和发布（Shipping）构建中检查宏。此法在以下情况中十分实用：怀疑Check宏中的代码正在修改值；发现了仅存在于在发布版本中且难以追踪的bug，但认为现有Check宏能找到这些bug。项目发布时应将 `USE_CHECKS_IN_SHIPPING` 设为默认值 `0`。

## Verify

在大部分版本中，Verify族系的行为与Check族系相同。但即便在禁用Check宏的版本中，Verify宏也会计算其表达式的值。这意味着仅当该表达式需要独立于诊断检查之外运行时，才应使用Verify宏。举例而言，若某个函数执行操作，然后返回 `bool` 来说明该操作是否成功，则应使用Verify而非Check来确保该操作成功。因为在发布版本中Verify将忽略返回值，但仍将执行操作。而Check在发布版本中根本不调用该函数，所以行为才会有所不同。

| 宏 | 参数 | 行为 |
| --- | --- | --- |
| `verify` 或 `verifySlow` | `Expression` | 若 `Expression` 为false，停止执行 |
| `verify` 或 `verifyfSlow` | `Expression`、`FormattedText`、`...` | 若 `Expression` 为false，则停止执行并将 `FormattedText` 输出到日志 |

验证宏在调试（Debug）、开发（Development）、测试（Test）和发布编辑器（Shipping Editor）版本中完整运行（以"Slow"结尾的宏除外，其仅在调试（Debug）版本中运行）。定义 `USE_CHECKS_IN_SHIPPING` 来保留一个true值（通常为 `1`），从而覆盖此行为。在所有其他情况下，Verify宏将计算其表达式，但不会停止执行或将文本输出到日志。

## Ensure

Ensure族系类似于Verify族系，但可在出现非致命错误时使用。这意味着，若Ensure宏的表达式计算得出的值为false，引擎将通知崩溃报告器，但仍会继续运行。为避免崩溃报告器收到太多通知，Ensure宏在每次引擎或编辑器会话中仅报告一次。若实际情况需要Ensure宏在每次表达式计算得值为false时都报告一次，则使用"Always"版本的宏。

| 宏 | 参数 | 行为 |
| --- | --- | --- |
| `ensure` | `Expression` | `Expression` 首次为false时通知崩溃报告器 |
| `ensureMsgf` | `Expression`、`FormattedText`、`...` | `Expression` 首次为false时通知崩溃报告器并将 `FormattedText` 输出到日志 |
| `ensureAlways` | `Expression` | `Expression` 为false时通知崩溃报告器 |
| `ensureAlwaysMsgf` | `Expression`, `FormattedText`, `...` | `Expression` 为false时通知崩溃报告器并将 `FormattedText` 输出到日志 |

Ensure宏在所有版本中计算其表达式的值，但仅在调试（Debug）、开发（Development）、测试（Test）和发布编辑器（Shipping Editor）版本中联系崩溃报告器。

## 用例

以下假设情况展示了一些用例，其中Check、Verify和Ensure可帮助理清代码或协助调试。

```
	// 决不可使用空JumpTarget调用此函数。若发生此情况，须停止程序。	void AMyActor::CalculateJumpVelocity(AActor* JumpTarget, FVector& JumpVelocity)	{		check(JumpTarget != nullptr);		//（计算在JumpTarget上着陆所需的速度。现在可确定JumpTarget为非空。）	}
```

```
	// 这将设置Mesh的值，并预计为非空值。若之后Mesh的值为空，则停止程序。	// 使用Verify而非Check，因为表达式存在副作用（设置网格体）。	verify((Mesh = GetRenderMesh()) != nullptr);
```

```
	// 这行代码捕获了在产品发布版本中可能出现的小错误。	// 此错误较小，无需停止执行便可解决。	// 虽然该bug已修复，但开发者仍然希望了解之前是否曾经出现过此bug。	void AMyActor::Tick(float DeltaSeconds)	{		Super::Tick(DeltaSeconds);		// 确保bWasInitialized为true，然后再继续。若为false，则在日志中记录该bug尚未修复。		if (ensureMsgf(bWasInitialized, TEXT("%s ran Tick() with bWasInitialized == false"), *GetActorLabel()))		{			//（执行一些需要已正确初始化AMyActor的操作。)		}	}
```

```
	// 若添加新形状类型，但忘记在此切换块中处理，则此代码将停止。	switch (MyShape)	{		case EShapes::S_Circle:			//（处理圆圈。）			break;		case EShapes::S_Square:			//（处理方块。）			break;		default:			// 每种形状类型都应有相应情况，因此这种情况不应该发生。			checkNoEntry();			break;	}
```

```
	// 此UObject拥有测试函数IsEverythingOK，没有副作用，若出现问题则返回false。	// 若发生这种情况，将出现致命错误并终止。	// 因为代码无副作用，仅作诊断之用，因此无需在发布版本中运行。	checkCode(		if (!IsEverythingOK())		{			UE_LOG(LogUObjectGlobals, Fatal, TEXT("Something is wrong with %s!Terminating."), *GetFullName());		}	);
```

```
	// 此列表中不应有圆圈，若有，程序将停转。但检查圆圈耗时较长，因此建议在调试版本中操作。	checkSlowf(!MyLinkedList.HasCycle(), TEXT("Found a cycle in the list!"));	//（遍历列表，在各个元素上运行一些代码。）
```

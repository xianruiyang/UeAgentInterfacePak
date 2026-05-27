# CQTest

---
title: "CQTest"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cqtest-test-framework-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "CQTest"]
---

# CQTest

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / CQTest

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cqtest-test-framework-for-unreal-engine

**CQTest**，或称 **Code Quality Test**, 是以下系统的扩展： **Unreal Engine（UE）`** FAutomationTestBase` 提供测试夹具和常用自动化测试命令。 与 UE 之前的测试框架相比，CQTest 的目标是简化新测试编写，并支持 *before* 和 *after* 测试动作，以便在测试之间自动重置状态。

## 设置

CQTest 作为 C++ 模块包含在 UE 中，可以添加到项目里。UE 还包含多个带有测试的插件，可用于查看其工作方式。本节介绍如何设置 CQTest 模块并使用测试插件。

### 将 CQTest 模块添加到项目

要在项目中使用 CQTest 模块，请执行以下步骤：

1. 在你选择的 IDE 中打开项目（例如 Visual Studio、Xcode 或 Rider）。
2. 打开项目的 `.Build.cs` 文件，并将 `CQTest` 添加到项目模块的 `PrivateDependencyModuleNames`:

   项目 Build.cs

   ```
        PrivateDependencyModuleNames.AddRange     (         new string[]          {             "Core",             "CoreUObject",             "Engine",             "CQTest"         }     );
   ```
3. 编译项目。编译完成后，CQTest 应可在项目中使用。

### 测试插件

Unreal Engine 包含两个插件，它们提供一组测试，用于验证并演示 CQTest 的行为：

- Code Quality Tests Unreal Test Plugin
- Enhanced Input Code Quality Unreal Test Plugin

#### 启用插件

要启用测试插件，请执行以下步骤：

1. 打开 **Unreal Editor**.
2. 打开 **Edit**> **插件**.
3. 搜索 **Code Quality Unreal Test Plugin**.
4. 启用上述任一插件。
5. 出现提示时重启 Unreal Editor。

![该 CQ Test example plugins in the Edit > Plugins menu.](../../../../assets/images/49/497427993f8d2a660f48f4fe2531272350835ac658c42e0c5aeef07c0ac8337e.jpg)

启用这些插件后，对应测试即可在项目中使用。

#### 运行插件测试

要在 Unreal Editor 中运行插件提供的测试，请执行以下步骤：

1. 用项目启动 Unreal Editor。
2. 导航到 **Tools** 下拉菜单并选择 **Sessions Frontend**.
3. 默认情况下，测试应首先列在 **Product.Plugins.CQTest**.
4. 选择要运行的测试，然后按 **Start Tests**.

## 测试宏

CQTest 提供多个测试宏：

| **宏** | **说明** |
| --- | --- |
| `TEST` | 基础测试对象。 |
| `TEST_CLASS` | 带有 setup、teardown、通用状态和分组的测试对象。请参阅下方 [Latent Actions](#latentactions) 部分，了解该宏可用的动作。 |
| `TEST_CLASS_WITH_ASSERTS` | 带有自定义断言器的测试对象。 |
| `TEST_CLASS_WITH_BASE` | 可以从其他测试对象继承的测试对象。 |
| `TEST_CLASS_WITH_FLAGS` | 可以使用不同自动化测试标志的测试对象。 |
| `TEST_CLASS_WITH_BASE_AND_FLAGS` | 可以从其他测试对象继承，并使用不同自定义自动化测试标志的测试对象。 |
| `TEST_CLASS_IMPL` | 上述宏使用的基础宏，用于指定自定义断言器、让测试对象继承其他测试对象，或允许使用自定义自动化测试标志。 |

## 扩展框架

CQTest 框架设计为可在若干区域使用扩展。请参阅 *CQTestTests/Private/ExtensionTests.cpp* 中的代码示例。

## 测试组件

CQTest 框架偏向组合而非继承。创建新组件是扩展框架的默认机制。可用组件包括：

| **组件** | **说明** |
| --- | --- |
| `SpawnHelper` | 简化生成 Actor 和其他对象的能力。 Implemented by `ActorTestSpawner` and `MapTestSpawner`. |
| `ActorTestSpawner` | 创建一个最小的 `UWorld` 供测试生成 Actor，并管理其销毁。 |
| `MapTestSpawner` | 创建临时地图或打开指定关卡。可以用它在上述测试世界中生成 Actor。 |
| `CQTestBlueprintHelper` **（已弃用）** | 简化测试生成 Blueprint 对象的能力，预期与 `MapTestSpawner`. 加载 Blueprint 资产仅预期在 Editor 上下文中工作。 使用 `CQTestBlueprintHelper` 的测试应指定 `EAutomationTestFlags::EditorContext` flag. 该方式已弃用，建议改用 CQTestAssetHelper，见下方 [辅助对象和方法](#helperobjectsandmethods). |
| `PIENetworkComponent` | 创建一个服务器和一组客户端。 Good for testing replication. 该 `PIENetworkComponent` 会设置一个 Server 和 Client PIE 实例，该实例只能在 Editor 上下文中使用。 使用 `PIENetworkComponent` 的测试应指定 `EAutomationTestFlags::EditorContext` flag. |
| `InputTestActions` | Injects `InputActions` to the `Pawn`. |
| `CQTestSlateComponent` | 当 UI 已更新时通知当前测试。 |

## 辅助对象和方法

该测试框架提供以下辅助对象和方法：

| **辅助对象** | **说明** |
| --- | --- |
| `FAssetBuilder` | 创建资产过滤器，可与 `CQTestAssetHelper` 命名空间方法一起使用，或用于搜索 `AssetRegistry` directly. |
| `CQTestAssetHelper` | 包含辅助方法的命名空间，可用于： 搜索资产包路径 按名称搜索 Blueprint Build a filter from the `FAssetFilterBuilder` |

## 处理异常

并非所有平台都支持异常，因此断言不能依赖异常。

在不支持异常的平台上运行测试有几种选择：

- 直接抛出异常，并且只在支持异常的平台上运行测试。
- 返回一个 `[[nodiscard]]` bool，以鼓励检查每个断言，并在失败时返回。
- 返回普通 bool，并依赖开发者在重要时进行检查。

异常的优势是可在辅助函数和 lambda 中工作，并且不依赖人为自觉。

普通 bool 噪声更少，并允许开发者使用 [IntelliSense](https://learn.microsoft.com/en-us/visualstudio/ide/using-intellisense)，但更容易出错。

默认实现使用 `[[nodiscard]]` bool，并配有辅助宏 `ASSERT_THAT` 替你执行提前返回检查。 可以在 `Assert.AreEqual` and `Assert.AreNotEqual` 方法中使用自己的类型，前提是已按需定义 `==` and `!=` 操作符。

此外，如果定义了 `ToString` 方法，错误消息也会打印出你类型的字符串版本。 如果框架不知道如何打印你的值，就会报错。

可以在 *CQTestTests/Private/Assert/CQTestConvertTests.cpp*中找到向框架提供字符串的示例；下面是一个简单示例：

C++ 示例

```
	struct MyCustomType	{		int32 Value; 		bool operator==(const MyCustomType& other) const 		{			return Value == other.Value;		} 		bool operator!=(const MyCustomType& other) const 		{			return !(*this == other);		} 		FString ToString() const 		{			//your to string logic			return FString();		} 	}; 	enum struct MyCustomEnum	{		Red, Green, Blue	}; 	template<> 	FString CQTestConvert::ToString(const MyCustomEnum&)	{		//your to string logic		return FString();	}
```

## Latent Actions

CQTest 通过 `TEST_CLASS` 宏支持 latent action。每一步都会先完成所有 latent action，再进入下一步。 如果在 latent action 期间触发断言，则不会继续处理后续 latent action，但 `AFTER_EACH` method will still be invoked.

C++ 示例

```
    TEST_CLASS(LatentActionTest, "Game.Test") 	{		uint32 calls = 0; 		BEFORE_EACH() 		{			AddCommand(new FExecute([&]() { calls++; }));		} 		AFTER_EACH() 		{			AddCommand(new FExecute([&]() { calls++; })); // executed after the next line, as it is a latent action			ASSERT_THAT(AreEqual(2, calls));		} 		TEST_METHOD(PerformLatentAction) 		{			ASSERT_THAT(AreEqual(1, calls));			AddCommand(new FExecute([&]() { calls++; }));		}	};
```

CQTest 还提供以下额外 latent action：

| **Latent Action 类型** | **说明** |
| --- | --- |
| `FExecute` | 只执行一次的 Action。 |
| `FWaitUntil` | 跨多个 tick 执行的 Action，直到完成或持续时间超过超时限制。如果超时前无法满足条件，该 Action 会失败。 |
| `FWaitDelay` | 等待指定时长的 Action。 **警告：** 由于运行时间可变，使用定时等待可能引入不可靠性。 建议改用上方 `FWaitUntil` Action。 |
| `FRunSequence` | 确保一组 latent action 按顺序发生，并且每个 Action 只在所有前置 Action 完成后执行。 |

### 命令构建器

命令还可使用 fluent 风格的命令构建器。

C++ 示例

```
	TEST_METHOD(SomeTest) 	{		TestCommandBuilder			.Do([&]() { StepOne(); })			.Then([&]() { StepTwo(); })			.Until([&]() { return StepThreeComplete(); })			.Then([&]() { ASSERT_THAT(IsTrue(SomethingImportant)); });	}
```

命令构建器提供了对上述 latent action 的命令封装。可用命令如下：

| **命令** | **说明** |
| --- | --- |
| `Do`/`Then` | 添加 `FExecute` latent action，并执行所提供 lambda 的命令。 |
| `StartWhen`/`Until` | 添加 `FWaitUntil` latent action，并评估所提供 lambda 的命令。 |
| `WaitDelay` | 等待指定时长后继续的命令。 由于运行时间可变，使用定时等待可能引入不稳定性，应改用上方 `StartWhen`/`Until` 命令。 |
| `OnTearDown`/`CleanUpWith` | 添加 `FExecute` latent action，并在测试之后执行所提供 lambda。 可以多次调用以添加多个清理 latent action。 使用 OnTearDown 或 CleanUpWith 的 Action 会按相反顺序运行，以减少混淆。 |

> [!WARNING]
> 该框架当前不支持在 latent action 内部添加 latent action。请改为将这些 Action 添加为一系列自包含步骤。

## CQTest 示例

可以编写如下简单测试：

C++ 示例

```
	#include "CQTest.h" 	TEST(MinimalTest, "Game.MyGame")	{		ASSERT_THAT(IsTrue(true));	}
```

使用 `TEST_CLASS` 宏，可创建包含以下能力的测试对象：

- 设置
- Teardown
- 多个测试之间的通用状态
- 对相关测试分组

该 `TEST_CLASS` macro can be used as follows:

C++ 示例

```
	#include "CQTest.h"		TEST_CLASS(MyTest, "Game.MyGame")	{		bool SetupCalled = false;		uint32 SomeNumber = 0;		Thing* Thing = nullptr; 		// Optional static method executed before all tests of this TEST_CLASS		// Remove if unused		BEFORE_ALL()		{			//Perform logic shared with all tests, such as loading a level		} 		BEFORE_EACH()		{			//Perform logic that is called before each test of this TEST_CLASS				SetupCalled = true;			SomeNumber++;			Thing = new Thing();		} 		AFTER_EACH()		{			//Perform logic that is called after each test of this TEST_CLASS			delete Thing;		} 		// Optional static method executed after all tests of this TEST_CLASS		// Remove if unused		AFTER_ALL()		{			//Perform cleanup of any resources allocated in BEFORE_ALL		} 	protected: 		bool HelperMethod() const		{			return true;		} 		TEST_METHOD(BeforeRunTest_CallsSetup)		{			ASSERT_THAT(IsTrue(SetupCalled));		} 		TEST_METHOD(ProtectedMembers_AreAccessible)		{			ASSERT_THAT(IsTrue(HelperMethod()));		} 		TEST_METHOD(DataMembers_BetweenTestRuns_AreReset)		{			ASSERT_THAT(AreEqual(1, SomeNumber));		}	}; 
```


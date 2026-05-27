---
title: "低级别测试类型"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/types-of-low-level-tests-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "低级别测试", "低级别测试类型"]
---

# 低级别测试类型

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 低级别测试 / 低级别测试类型

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/types-of-low-level-tests-in-unreal-engine

**低级别测试（LLT）** 框架包括以下测试类型：

- 显式（Explicit）

  ：由模块构建目标对定义的独立测试。

## 显式测试

**显式测试** 是由模块构建目标对定义的独立测试。显式测试设计为在编译时间和运行时间方面做到轻量级。之所以称为 *显式* ，是因为显式测试需要显式UE模块构建和目标文件。这意味着显式测试需要 `.Build.cs` 和 `.Target.cs` 文件。

### 创建显式测试

执行以下步骤，创建显式测试：

1. 在 `Source/Programs` 目录中，创建一个新目录，名称与你要测试模块的名称相同，并在此目录中添加 `.Build.cs` 文件。

   > [!TIP]
   > 要查看示例，找到目录 `Engine/Source/Programs/LowLevelTests`，其中包含名为基础测试（Foundation Tests）的显式测试目标。
2. 从

   TestModuleRules

   继承你的模块类。

   - 如果你要编写插件测试，则将新模块放到与插件

     Source

     目录同一级别的

     Tests

     目录。
   - 如果你要构建不使用Catch2的测试模块，则继承基类构造函数，将其中第二个参数设置为false：

     base(Target, false)

     。
3. 使用新

   Metadata

   对象参数调用

   UpdateBuildGraphPropertiesFile

   。

   - 此信息用于生成BuildGraph脚本测试元数据。
   - 有关BuildGraph脚本生成的更多信息，请参阅

     生成BuildGraph脚本元数据

     小节。
4. 假定你有一个名为 `UEModuleTests` 的显式测试模块。你的显式测试 `.Build.cs` 文件应类似于如下内容：

   UEModuleTests/UEModuleTests.Build.cs

   ```
    public class UEModuleTests : TestModuleRules {     public UEModuleTests(ReadOnlyTargetRules Target) : base(Target)     {         PrivateIncludePaths.AddRange(             // 所有私有包含路径         );         PrivateDependencyModuleNames.AddRange(             // 要链接到的所有私有依赖项         );          // 其他类型的依赖项或特定于模块的逻辑          UpdateBuildGraphPropertiesFile(new Metadata("UEModule", "UE Module"));     } }
   ```
5. 添加测试目标文件（

   .Target.cs

   ），其中包含从

   TestTargetRules

   继承的类。
6. 如有必要覆盖默认编译。

   - 目标是建立一个最小的可测试模块，该模块没有未为低级别测试增加价值的默认功能。
   - 你可以单独指定受支持的平台。默认平台为：Win64、Mac、Linux和Android。
   - 你可以启用特定于项目的全局定义，并设置Catch2定义，如基准支持所需的定义。
7. 你的显式测试 `.Target.cs` 文件应类似于如下内容：

   UEModuleTests/UEModuleTests.Target.cs

   ```
    [SupportedPlatforms(UnrealPlatformClass.All)] public class UEModuleTestsTarget : TestTargetRules {     public UEModuleTestsTarget(TargetInfo Target) : base(Target)     {         // 像其他目标一样设置：设置编译标志、全局定义等。         GlobalDefinitions.Add("CATCH_CONFIG_ENABLE_BENCHMARKING=1");     } }
   ```

#### 后续步骤

现在你可以在模块的 `Private` 文件夹中编写C++测试文件，并在这些文件中编写Catch2测试。对于测试技巧和最佳实践，请参阅[编写低级别测试](../write-low-level-tests/index.md)文档。最后，了解如何构建和运行你的测试。构建和执行低级别测试的方式不止一种。请参阅[构建和运行低级别测试](../build-and-run-low-level-tests/index.md)文档，选择适合你开发需求的最佳方法。

### 生成BuildGraph脚本元数据文件

如果你要使用BuildGraph构建和运行你的测试，你需要为显式测试启用生成BuildGraph脚本元数据文件。通过 `GenerateProjectFiles.bat` 生成IDE解决方案时，显式测试模块会生成BuildGraph `.xml` 文件。

引擎配置设置是约束此生成的条件。你可以在 `Engine/Config/BaseEngine.ini` 中设置此配置：

```
[LowLevelTestsSettings]bUpdateBuildGraphPropertiesFile=true
```

当你运行 `GenerateProjectFiles.bat` 时，会在 `Build/LowLevelTests/<TEST_NAME>.xml` 文件夹中为每个测试目标生成测试元数据 `.xml` 文件，其中 `<TEST_NAME>` 为测试目标的名称。对于NDA平台，会在 `Platforms/<PLATFORM_NAME>/Build/LowLevelTests/<TEST_NAME>.xml` 下生成这些文件。你可以选择性地在包含全局属性的测试文件旁边放一个附加 `General.xml` 文件。

如果文件已经存在，则根据C#描述的 `Metadata` 对象更新文件。项目文件生成所访问的文件夹和文件必须可写。通常，这些文件在源代码控制下为只读，因此需在生成之前检出文件或使其可写。

> [!TIP]
> 要查看示例，找到目录 `Engine/Build/LowLevelTests` ，其中包含名为Foundation的 `.xml` 文件。这是用于基础测试的已生成BuildGraph元数据。

### 显式测试参考

#### 测试模块规则参考

`TestModuleRules` 类会使用 `UpdateBuildGraphPropertiesFile` 扩展 `ModuleRules` 。`UpdateBuildGraphPropertiesFile` 会接受 `Metadata` 对象，该对象会生成BuildGraph测试元数据 `.xml` 文件。通过 `Metadata` 对象，你可以设置以下属性：

| **字段** | **说明** |
| --- | --- |
| `TestName` | BuildGraph脚本用于生成特定于测试的属性的测试名称。此字段不能包含空格。 |
| `TestShortName` | 在构建系统中用于显示的测试短名称。此字段可包含空格。 |
| `ReportType` | Catch2报告类型。最常见的报告类型为控制台和xml。有关Catch2报告类型的更多信息，请参阅外部Catch2文档。 |
| `Disabled` | 测试是否已禁用。如果为true，将从BuildGraph图表中排除此测试。 |
| `InitialExtraArgs` | 附加在 `RunLowLevelTests` Gauntlet命令的其他参数前的命令行参数。这些通常是仅适用于某些测试的Gauntlet功能启用参数。例如 `-printreport` ，可在测试执行结束时将报告打印到 `stdout` 。 |
| `HasAfterSteps` | 如果为true，则测试必须提供名为 `<TEST_NAME>AfterSteps` 的BuildGraph `Macro` ，其中包含测试执行之后运行所需的清理或步骤。例如，可能是运行一个可清理剩余测试数据的数据库脚本。 |
| `UsesCatch2` | 此属性允许你选择测试框架。某些测试不使用Catch2；例如，这些测试可能使用 `GoogleTest` 。如果你选择自有测试框架，请确保在 `RunLowLevelTests` Gauntlet命令中实现对报告和其他功能的支持。 |
| `PlatformTags` | 特定于平台的标签列表。例如，利用此字段在给定平台上排除不受支持的测试。 |
| `PlatformCompilationExtraArgs` | 平台可能需要的额外编译参数。 |
| `PlatformsRunUnsupported` | 添加一个例外，并且可以在BuildGraph脚本中充当编译安全网，直到实现运行支持。例如：如果一个平台仅支持编译，但缺少低级别测试运行功能。 |

> [!WARNING]
> `TestModuleRules` 将覆盖来自其基类 `ModuleRules` 的很多默认UBT标记。这样可以减少编译膨胀，并最大限度地减少大多数开箱即用测试的编译时间。你始终可以在 `TestModuleRules` 派生类中覆盖这些默认值，但不得直接在 `TestModuleRules` 中更改默认值。

#### 测试目标规则参考

`TestTargetRules` 通过以下标记扩展 `TargetRules` ：

| **标记** | **说明** |
| --- | --- |
| `bUsePlatformFileStub` |  |
| `bMockEngineDefaults` | 在测试引擎模块时，某些资源按默认方式管理或从资产文件加载。这些操作需要烘焙资产。将此标记用于不需要加载资产的测试；效果是模拟引擎默认材质、世界对象和其他资源。 设置此属性可更改 `UE_LLT_WITH_MOCK_ENGINE_DEFAULTS` 的值。 |
| `bNeverCompileAgainstEngine` | LLT框架的默认行为是，每当引擎模块位于构建依赖图中时，自动设置 `bCompileAgainstEngine = true` 。此属性可以阻止此行为，以便即使引擎模块位于该图中，我们也不会使用引擎进行编译。 |
| `bNeverCompileAgainstCoreUObject` | 和 `bNeverCompileAgainstEngine` 相同，但适用于 `CoreUObject` 。 |
| `bNeverCompileAgainstApplicationCore` | 和 `bNeverCompileAgainstEngine` 相同，但适用于 `ApplicationCore` 。 |
| `bNeverCompileAgainstEditor` | 和 `bNeverCompileAgainstEngine` 相同，但适用于 `UnrealEd` 。 |

> [!WARNING]
> 就像 `TestModuleRules` 一样， `TestTargetRules` 可设置默认UBT标记。尤其是，它可以禁用UE功能，如UObjects、本地化、统计数据等。

### 引擎测试

在此类型的显式测试中，LLT框架将编译和运行包含引擎模块的显式测试。因为对于大多数平台来说，加载资产需要烘焙，无法使用引擎模块，因此引擎测试仅适用于 `.Target.cs` 文件中设置的以下标记：

```
public UEModuleTestsTarget(TargetInfo Target) : base(Target){  bUsePlatformFileStub = true;  bMockEngineDefaults = true;}
```

初始化和清理引擎组件也是必要步骤。

具体方法是提供一个包含初始化事件的 `.cpp` 文件：

```
    #include "TestCommon/Initialization.h"     GROUP_BEFORE_ALL(Catch::DefaultGroup)    {        InitAll(true, true);    }     GROUP_AFTER_ALL(Catch::DefaultGroup)    {        CleanupAll();    }
```

## 下一步

当你确定什么测试最适合你的需求后，请参阅[编写低级别测试](../write-low-level-tests/index.md)文档，了解如何在虚幻引擎中编写低级别测试。


- [编写低级别测试](../write-low-level-tests/index.md)

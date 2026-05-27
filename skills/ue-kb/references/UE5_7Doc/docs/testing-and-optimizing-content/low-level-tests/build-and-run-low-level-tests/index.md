---
title: "构建和运行低级别测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/build-and-run-low-level-tests-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "低级别测试", "构建和运行低级别测试"]
---

# 构建和运行低级别测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 低级别测试 / 构建和运行低级别测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/build-and-run-low-level-tests-in-unreal-engine

你可使用以下工具构建和测试低级别测试：

- Visual Studio
- 虚幻编译工具（UBT）
- BuildGraph

你可以使用其中任一工具来构建和运行显式测试。建议你尽可能使用BuildGraph构建和运行显式测试。

| **测试类型可用性** | **Visual Studio** | **虚幻编译工具** | **BuildGraph** |
| --- | --- | --- | --- |
| 显式测试 | 是 | 是 | 是 |

本页面最后，[示例：基础测试](#%E7%A4%BA%E4%BE%8B%EF%BC%9A%E5%9F%BA%E7%A1%80%E6%B5%8B%E8%AF%95)小节将指导你如何构建和运行包含在虚幻引擎中的低级别测试项目。

### Visual Studio

你可以在桌面平台上直接从Visual Studio构建和运行显式测试：

1. 安装UnrealVS。

   - 这是可选项，但强烈推荐使用，因为它能增强测试的发现能力。如需详细了解UnrealVS，请参阅

     UnrealVS扩展

     文档。
2. 从 Visual Studio

   构建

   测试项目以生成可执行文件。

   - Visual Studio内置测试适配器将在Catch2可执行文件中发现测试。你可以使用UnrealVS或直接通过Visual Studio的界面进行构建。
3. 测试会显示在

   测试资源管理器（Test Explorer）

   中。从菜单中选择

   测试（Test）> 测试资源管理器（Test Explorer）

   。从这里，你可以运行测试并找到它们的源代码。
4. 如果测试资源管理器中没有测试，则很可能是步骤2中的构建未更新可执行文件。对测试项目运行

   重新编译（Rebuild）

   以补救此问题。

### 虚幻编译工具

#### 构建

##### 显式测试

你可以使用虚幻编译工具编译显式测试。假设我们使用目标类 `MyTestsTarget` 编译显式测试用例：

```
.\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe MyTestsTarget Development Win64
```

上述用例使用的配置是 `开发（Development）` ，平台是 `Win64` ，以作示范。支持所有配置和平台。

#### 运行

前文的UBT命令编译了一个测试可执行文件。测试可执行文件位于目标通常想要输出到的基础文件夹中，例如 `Binaries/<PLATFORM>` ，但所在的文件夹与目标同名。以下是一个示例，在通过上述方式使用虚幻编译工具编译低级别测试后，从命令行运行这些测试的可执行文件：

```
MyTests.exe --log --debug --sleep=5 --timeout=10 -r xml -# [#MyTestFile][Core] --extra-args -stdout
```

此命令行执行以下操作：

LLT参数：

```
--log --debug --sleep=5 --timeout=10
```

- 启用UE日志记录。
- 打印低级别测试调试消息（测试开始、结束和完成时间）。
- 运行测试之前等待5秒。
- 将每个测试的超时时间设置为10分钟。

Catch2参数：

```
-r xml -# [#MyTestFile][Core]
```

- 启用XML报告。
- 使用文件名作为筛选标签，并从文件

  MyTestFile

  中选择所有被标记为

  [Core]

  的测试。

UE参数：

```
--extra-args -stdout
```

- 将

  -stdout

  设置为UE命令行。

#### 命令行参考

一旦编译完成，你可以使用测试可执行文件来运行预提交测试，或者将其作为持续集成/持续交付（CI/CD）管道的一部分。LLT可执行文件支持一系列命令行选项，可涵盖许多用例。

| **参数** | **标记或键值对** | **说明** |
| --- | --- | --- |
| `--global-setup` | 标记 | 运行用于初始化UE核心组件的全局设置。 |
| `--no-global-setup` | 标记 | 使用此参数禁用全局设置。 |
| `--log` | 标记 | 已启用UE日志输出。 |
| `--no-log` | 标记 | 已禁用UE日志输出。 |
| `--debug` | 标记 | 启用 `LowLevelTestsRunner` 记录器调试消息，以执行当前测试。 |
| `--mt` | 标记 | 设置 `bMultiThreaded=true` 。使用此设置配置多线程环境。 |
| `--no-mt` | 标记 | 设置 `bMultiThreaded=false` 。使用此设置配置单线程环境。 |
| `--wait` | 标记 | 退出之前等待用户输入。 |
| `--no-wait` | 标记 | 退出前不等待用户输入。这是默认行为。 |
| `--attach-to-debugger` 、 `--waitfordebugger` | 标记 | 在全局设置阶段之前，应用程序等待调试器连接。 |
| `--buildmachine` | 标记 | 设置UE全局变量 `bIsBuildMachine=true` 。用于开发，以控制CI/CD行为。 |
| `--sleep=<SECONDS>` | 键值对 | 在全局设置阶段之前设置一个以秒为单位的休眠周期。适用情况：同步操作要求测试在启动前等待。 |
| `--timeout=<MINUTES>` | 键值对 | 设置每个测试的超时（单位为分钟）。若在单个测试用例中达到超时，会打印一条错误消息。 |
| `--reporter=` etc. `-r` etc. | 两者 | Catch2命令行选项。不在--extra-args之后的非上述命令行选项都会自动发送到Catch2。 要全面了解Catch2命令行选项，请参阅Catch2 GitHub元库中的外部[Catch2命令行](https://github.com/catchorg/Catch2/blob/devel/docs/command-line.md#top)文档。 |
| `--extra-args` | 标记 | 此选项之后设置的所有参数都在UE的 `FCommandLine` 上设置。适用情况：功能是从命令行启用的。 |

> [!WARNING]
> 如上文最后两个条目中所述，引用中未枚举的参数，包括 `--extra-args`，都将直接发送到Catch2命令行参数列表。

### BuildGraph

推荐通过BuildGraph脚本构建和运行测试。基本命令大致如下：

```
.\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Run Low Level Tests"
```

> [!NOTE]
> Windows、Mac和Linux可以使用类似命令。

位于 `Engine/Build/LowLevelTests.xml` 的脚本使用测试元数据文件。要生成元数据文件，请参阅[低级别测试类型](../types-of-low-level-tests/index.md)文档的"生成BuildGraph脚本元数据文件"小节。此脚本的正确执行取决于成功生成的测试元数据脚本，所以务必要确认文件在预期位置生成。所有测试元数据 `.xml` 文件都包含在 `LowLevelTests.xml` 中，此元数据将驱动构建图表中各个节点的执行。

以下是一些使用BuildGraph脚本的常见方法：

1. 在Windows上运行名为 `MyTest` 的测试：

   ```
        .\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="MyTest Tests Win64"
   ```
2. 设置一个特定的构建配置而非默认配置，即开发（Development）。例如，你可以将配置设置为 **调试（Debug）** ，如下所示：

   ```
        .\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Foundation Tests Win64" -set:Configuration="Debug"
   ```
3. 在调试（Debug）配置中构建并启动一个测试，然后等待调试器连接到它：

   ```
        .\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Foundation Tests Win64" -set:Configuration="Debug" -set:AttachToDebugger=true
   ```
4. 如果平台的工具支持将应用程序部署到具有给定名称或IP的设备上，你可以在该设备上启动它。如果平台有远程调试工具，此命令也可与 `AttachToDebugger` 配合使用：

   ```
        .\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Foundation Tests Win64" -set:Device="<IP_OR_NAME_OF_DEVICE>"
   ```
5. 为目标平台构建Catch2：

   ```
        .\RunUAT.bat BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Catch2 Build Library Win64"
   ```

## 示例：基础测试

### 概述

基础测试项目位于 `Programs/LowLevelTests` 文件夹下的 Visual Studio **解决方案资源管理器（Solution Explorer）** 中。

`Tests/TestGroupEvents.cpp` 中定义了生命周期事件。注意这些事件的执行顺序，因为它们会影响测试的正确执行。缺少设置或者设置不正确都可能导致运行时错误，清除（teardown）事件也是如此。

### 构建和运行

从Visual Studio构建和运行测试，或使用BuildGraph。

#### Visual Studio

要从Visual Studio构建基础测试，请执行以下步骤：

1. 确保你安装了

   UnrealVS

   ，它能使构建测试更轻松。 请参阅

   UnrealVS扩展

   文档，了解更多信息。
2. 前往Visual Studio菜单，并找到

   解决方案配置（Solution Configurations）

   。
3. 从

   解决方案配置（Solution Configurations）

   下拉菜单中，选择

   测试（Tests）

   。
4. 在UnrealVS工具栏中，找到

   启动项目（Startup Project）

   下拉菜单，并选择

   FoundationTests

   。
5. 在Visual Studio菜单栏中，选择

   构建（Build）> 构建解决方案（Build Solution）

   。

这将构建基础测试及其依赖项。要运行基础测试，从你的终端或命令提示符前往 `Engine/Binaries/Win64/FoundationTests` 目录，并使用 `./FoundationTests` 运行 `FoundationTests.exe` 可执行文件。

如果一切顺利，终端窗口会显示一些日志文本，如果所有测试都通过了，最后会有一个对话框显示"所有测试都已通过...（All tests passed…）"。

#### BuildGraph

要构建和运行基础测试，前往你的项目目录并运行以下命令：

```
.\RunUAT BuildGraph -Script="Engine/Build/LowLevelTests.xml" -Target="Foundation Tests Win64"
```

你可以指定不同平台、构建配置、要运行测试的设备目标，或让测试等待调试器连接。

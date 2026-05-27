---
title: "虚幻头文件分析工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-header-tool-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻头文件分析工具"]
---

# 虚幻头文件分析工具

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻头文件分析工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-header-tool-for-unreal-engine

## 虚幻头文件分析工具概述

**虚幻头文件分析工具（UHT）** 是虚幻引擎的一种自定义解析和代码生成工具。UHT可为虚幻引擎（UE）的 **UObject** 系统解析并生成代码。虚幻引擎中的代码编译分两个阶段进行：

1. 虚幻编译工具（Unreal Build Tool (UBT)）

   会调用UHT，后者将解析C++头文件，获取与虚幻引擎相关的类元数据，并生成自定义代码，以实现各种与UObject相关的功能。
2. UBT会调用配置的C++编译器来编译结果。

本页面包含有关以下内容的信息：

- 从命令行运行UHT
- 运行UHT的常见问题
- 使用自定义脚本生成器扩展UHT
- UHT命令行参考
- 更多相关信息的链接

## 运行虚幻头文件分析工具

你不需要在典型开发工作流程中运行虚幻头文件分析工具（UHT），因为UBT会在内部负责进行处理。但是，如果你要创建UHT插件或修改UHT，单独运行UHT会很有用。

本小节说明了如何手动运行UHT。

### UHT命令行

UHT可以通过以下两种不同方式运行：

- 内部UBT命令
- UHT开发命令

#### 内部UBT命令

UBT在内部使用以下命令行。 UBT会扫描所有头文件，查找UHT关键字，然后生成一个清单文件，其中包含UHT需要解析的所有模块和源文件。

```
RunUBT -Mode=UnrealHeaderTool "<PROJECT_FILE>" "<MANIFEST_FILE>" …
```

#### UHT开发命令

你可以在UHT开发期间或运行其他导出时使用以下命令行。UHT不必依赖之前存在的清单文件，而是执行UBT通常会执行的扫描，然后自动生成清单。 UHT在以此模式运行时使用与UBT相同的目标规范。

```
RunUBT -Mode=UnrealHeaderTool "-Target=<TARGET> <PLATFORM> <CONFIGURATION>" …
```

```
RunUBT -Mode=UnrealHeaderTool "-Target=<TARGET> <PLATFORM> <CONFIGURATION> -Project=\"<PROJECT_FILE>\"" …
```

#### 日志记录选项

UHT支持UBT支持的相同日志记录选项。

#### 错误处理

UHT有两个选项会影响错误处理：

- 警告作为错误
- 生成的代码更改时发生故障

UHT通常使用 `-WarningsAsError` 运行。 顾名思义，UHT会在检测到警告时返回错误代码。 热重载系统使用 `-FailIfGeneratedCodeChanges` 检测对生成的代码的更改，并在发现更改时返回错误。

##### 调试

调试时，由于UHT频繁使用C#任务，调试起来很困难。 `-NoGoWide` 选项会禁用C#任务，并在单个执行线程中运行UHT。

#### 导出器

导出器是UHT用于生成代码和报告的机制。 默认情况下，UHT运行标准Codegen导出器和所有启用的脚本生成器导出器。UHT包括两个默认未启用的示例导出器：

- Json
- Stats

##### 启用导出器

要启用导出器，请使用 `-<EXPORTER_NAME>` 命令行参数。 要禁用通常启用的导出器，请使用 `-No<EXPORTER_NAME>` 命令行参数。 `-NoDefaultExporters` 选项会禁用默认启用的所有导出器。 如果你想独立于默认导出器运行Stats之类的导出器，此选项很方便。

##### 导出器输出

UHT可以创建导出器输出的单个目录，方便进行UHT开发。这些选项的输出位于 `Engine/Programs/UnrealHeaderTool/Saves` 目录中。 在执行UHT开发之前，使用 `-WriteRef` 选项创建所有生成的输出的副本。 对修改进行迭代时，使用 `-VerifyRef` 选项对比新生成的输出与 `-WriteRef` 生成的输出。 这会确保输出没有意外更改。

使用 `-NoOutput` 选项可防止UHT将输出写入通常写入的位置。

### 运行UHT的常见问题

#### 仅包含委托的源文件不会被解析

不同于其他声明，UHT会自动解析所有 `DECLARE_DYNAMIC_` 委托。但是，如果头文件仅包含这些委托，而没有其他UHT关键字，则UBT会认为该头文件不需要解析。

要解决该问题，请在至少一个委托上方使用 `UDELEGATE` 关键字。

## 使用脚本生成器扩展UHT

C# UHT支持在插件中定义脚本生成器。 `Engine\Plugins\ScriptPlugin\Source\ScriptGeneratorUbtPlugin` 中提供了示例。

只要存在 `<PLUGIN_NAME>.ubtplugin.csproj` C#项目文件名，UBT就能识别到插件，其中 `<PLUGIN_NAME>` 是你的插件的名称。 配置C#项目时，不要使用项目引用，而使用 `Engine\Binaries\DotNET\UnrealBuildTool` 目录中UBT和UHT的程序集引用。 这样可避免在UBT编译插件时发生文件锁定的问题。

虽然可以使用UHT中的相同机制来定义说明符、关键字、属性等，但仅支持导出器。此外，导出器只能将文件输出到插件的 `Intermediate` 目录。 UBT不会编译除标准Codegen导出器之外的任何对象所生成的文件。 对于脚本生成器插件，通常会通过插件中的其他C++代码包含的单个生成的 `.inl` 文件来完成编译。

`IUhtExportFactory` 接口提供了往回访问UHT的途径：

| **方法** | **说明** |
| --- | --- |
| `IUhtExportFactory.Session` | 用于访问包及其定义的类型的集合。不同于C++ UHT，类型树包含UHT所解析的有关每个类型的所有信息。 |
| `IUhtExportFactory.CreateTask` | 创建导出内容的任务，或者如果已指定 `-NoGoWide` ，则直接运行。 |
| `IUhtExportFactory.MakePath` | 生成要传递到 `CommitOutput` 的文件名。 |
| `IUhtExportFactory.CommitOutput` | 当且仅当输出发生更改时才将输出写入磁盘。 如果使用了 `-WriteRef` 或 `-VerifyRef` 选项，则文件还会写入其中基于导出器名称的子目录。 |
| `IUhtExportFactory.AddExternalDependency` | 添加要检查的文件，以了解UBT是否需要重新运行UHT。 例如，用于更改输出的配置文件可以添加为外部依赖项。 |

### 启用UHT导出器扩展

要使UHT能够识别扩展，需要做到以下两点：

- 类必须包括

  UnrealHeaderTool

  类属性。
- 函数必须包括

  UhtExporter

  方法属性。

添加导出器时，属性必须包含以下设置：

- 名称（Name）

  ：导出器的名称。 此名称应该基本唯一。
- 选项（Options）

  ：设置为默认值，以便在启用插件时始终运行。
- ModuleName

  ：包含导出器的插件模块的名称。

例如，参阅位于 `Engine\Plugins\ScriptPlugin\Source\ScriptGeneratorUbtPlugin` 中的 `ScriptGenerator.cs` 中的示例：

```
[UhtExporter(Name="ScriptPlugin", Description="Generic Script Plugin Generator", Options=UhtExporterOptions.Default, ModuleName="ScriptPlugin")]
```

其他一些选项并非Epic导出器所需，也并非为其预留。例如，以上示例中的 `说明` 选项不是必需选项。

### 其他UHT扩展

`UnrealHeaderTool` 类属性的用途非常广，远不止于导出器。目前，脚本生成器导出器是唯一支持的扩展类型。

以下属性定义了UHT中的重要元素：

| **属性** | **说明** |
| --- | --- |
| `UhtKeword` | `UCLASS` 之类的标记。 |
| `UhtSpecifier` | 说明符。 |
| `UhtSpecifierValidator` | 元数据验证器。 |
| `UhtPropertyType` | 新属性类型。 |
| `UhtStructDefaultValue` | `USTRUCT` 的默认值。 |
| `UhtLocTextDefaultValue` | `LOCTEXT` 宏的默认值。 |
| `UhtEngineClass` | 将C#类与不同的引擎类型关联。 |

> [!WARNING]
> 可以添加新的说明符、验证器和默认值，因为它们不需要更改代码生成。添加新的引擎类型、属性类型或关键字时应谨慎，因为添加其中任何一项都需要对引擎做出大量更改才能正确实现。

## UHT命令行参考

### 选项

| **命令行参数** | **说明** |
| --- | --- |
| `-Verbose` | 提高日志输出冗长度。 |
| `-VeryVerbose` | 最大化日志输出冗长度。 |
| `-Log` | 指定日志文件位置。没有此参数时，会使用默认位置：`Engine/Programs/UnrealHeaderTool/Saved/Logs/UnrealHeaderTool.log` 。 |
| `-Timestamps` | 在日志中包括时间戳。 |
| `-FromMsBuild` | 为Microsoft Build Engine（MSBuild）格式化消息。 |
| `-NoLog` | 禁用日志文件创建，包括默认日志文件。 |
| `-Test` | 运行测试脚本。 |
| `-WarningsAsErrors` | 将警告视为错误。 |
| `-NoGoWide` | 禁用并发解析和代码生成。 |
| `-WriteRef` | 将所有输出写入参考目录。 |
| `-VerifyRef` | 将所有输出写入验证目录，并与参考输出比较。 |
| `-FailIfGeneratedCodeChanges` | 将对输出文件的所有更改视为错误。 |
| `-NoOutput` | 不保存除了参考输出之外的所有输出文件。 |
| `-IncludeDebugOutput` | 在生成的输出中包括额外内容，辅助调试。 |
| `-NoDefaultExporters` | 禁用所有默认导出器。在特定导出器需要运行时很有用。 |

### 发生器

| **命令行参数** | **说明** |
| --- | --- |
| `-Stats` | 类型stats。 |
| `-NoStats` | 禁用类型stats。 |
| `-Json` | 包的Json说明。 |
| `-NoJson` | 禁用包的Json说明。 |
| `-CodeGen` | 标准虚幻引擎代码生成器。这是默认生成器。 |
| `-NoCodeGen` | 禁用默认虚幻引擎代码生成器。 |

## 更多信息

### 虚幻引擎反射系统

如需详细了解虚幻引擎反射系统，包括UObject及其关联的元数据说明符，请参阅[虚幻引擎反射系统](../../../cpp-programming/reflection-system/index.md)文档。


- [虚幻引擎反射系统](../../../cpp-programming/reflection-system/index.md)

### 虚幻编译工具

如需详细了解虚幻引擎编译过程以及如何自定义你的编译，请参阅[虚幻编译工具](../unreal-build-tool/index.md)文档。


- [虚幻编译工具](../unreal-build-tool/index.md)

---
title: "Horde结构化日志记录"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-structured-logging-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde内部机制", "Horde结构化日志记录"]
---

# Horde结构化日志记录

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde内部机制 / Horde结构化日志记录

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-structured-logging-for-unreal-engine

Horde大量使用来自虚幻引擎和工具的结构化日志记录输出，该输出提供比纯文本日志更多的特定于上下文的信息。

要了解Horde如何使用结构化日志记录，考虑一下我们希望从自动化流程的诊断中获取的信息类型会有所帮助：

- 人工可读消息
- 诊断来源（编译器、连接器等）
- 触发错误的文件（本地路径、版本控制系统中的路径）
- 行号
- 严重程度
- 错误代码
- 其他特定于上下文的信息

理想情况下，我们会在源处标记错误，并尽可能多地添加特定于上下文的信息。例如，以下日志片段：

```
NVENC_EncoderH264.cpp (0:05.95 at +16:18)d:\build\AutoSDK\Sync\HostWin64\Win64\Windows Kits\10\include\10.0.18362.0\um\winnt.h(603): error C2220: the following warning is treated as an errord:\build\AutoSDK\Sync\HostWin64\Win64\Windows Kits\10\include\10.0.18362.0\um\winnt.h(603): warning C4005: 'TEXT': macro redefinitionEngine\Source\Runtime\Core\Public\HAL\Platform.h(1081): note: see previous definition of 'TEXT'
```

...提供以下信息：

- 发生了一个

  编译

  错误。
- 在编译

  NVENC_EncoderH264.cpp

  文件时发生，原因是

  winnt.h

  （第603行）和

  Platform.h

  （第1081行）中定义的宏存在冲突。
- 我们可以将

  NVENC_EncoderH264.cpp

  和

  Platform.h

  映射到源代码控制中的文件，并查看它们的修订历史记录。
- 警告编号为

  C4005

  ，被视为错误

  C2220

  处理。
- 编译该文件花了5.95秒。

我们没有为日志事件输出纯文本，而是保留格式字符串和参数，稍后再呈现它们。这样，我们可以针对我们理解的类型以不同的方式呈现这些参数，我们还可以基于这些字段对日志进行索引和搜索。

Horde原生支持结构化日志事件，借助这一功能，我们可以实现一些功能，例如将源文件呈现为指向P4V延时视图的链接，将错误代码呈现为指向MSDN的链接。我们还可以将路径映射回它们在源代码控制中的历史记录，利用这一点，通过Horde的构建健康系统找出是谁损坏了构建。

那些曾饱受构建系统困扰的人可以松一口气了，以前只要日志行中包含"error:"字符串就会被判定为错误，而现在如果你直接输出结构化日志事件，Horde将不再需要猜测它是否为错误。

## 格式化

虚幻引擎使用标准的[消息模板](https://messagetemplates.org/)语法编写错误，例如：

```
Logger.LogInformation("Hello {Text}", "world");
```

注意：

- 格式字符串中的所有参数都应该命名，而不是使用数字占位符（即使用{Text}，而不是{0}、{1}等）。这些标识符用于命名结构化日志事件中的属性，并可以通过诸如Splunk、Datadog等工具进行索引和搜索。
- 格式字符串应该是常量，而不是使用插值字符串或拼接字符串。这可以让记录器实现对解析后的格式字符串进行缓存，并在不同消息之间重复使用。

日志事件可以呈现为纯文本日志，以便立即在控制台中显示，也可以以结构化形式保存在[JSONL](https://jsonlines.org/)文件中。

## 利用C#编写事件

AutomationTool和UnrealBuildTool支持使用NET ILogger API编写日志事件。

所有日志记录都应通过[ILogger](https://learn.microsoft.com/zh-cn/dotnet/api/microsoft.extensions.logging.ilogger?view=net-9.0-pp)实例（在Microsoft.Extensions.Logging命名空间中定义）完成，而不是通过旧版 `Log.TraceInformation` 以及其他静态方法进行传递。

## 利用C++编写事件

虚幻引擎运行时支持使用 `UE_LOGFMT` 宏编写结构化日志事件。

## 采集输出

Horde设置了一个UE_LOG_JSON_TO_STDOUT环境变量，该变量指示AutomationTool等工具直接将JSON输出到stdout，并将其提取和存储以在操作面板上呈现。

## 旧版日志输出

对于不支持结构化日志的外部工具（例如编译器等），我们有一个正则表达式库，该库可以在纯文本输出上运行，并从中构建结构化日志事件。部分位于UBT (`Engine/Source/Programs/UnrealBuildTool/Matchers/...`)中，还有部分位于UAT (`Engine/Source/Programs/AutomationTool/AutomationUtils/Matchers/...`)中。这些由EpicGames.Core中的 `LogEventParser` 类使用。

要为纯文本日志输出实现一个新的匹配器，请创建一个类使其实现来自 `EpicGames.Core` 的 `ILogEventMatcher` 接口，并确保它已注册

在添加或修改日志解析器时，我们强烈建议在 `UnrealBuildTool.Tests` 和 `HordeAgent.Tests` 项目中运行（并编写）测试，以检查与其他处理程序的交互情况。

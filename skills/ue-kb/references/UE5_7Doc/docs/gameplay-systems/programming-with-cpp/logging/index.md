---
title: "虚幻中的日志记录"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/logging-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "游戏性架构", "虚幻中的日志记录"]
---

# 虚幻中的日志记录

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 游戏性架构 / 虚幻中的日志记录

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/logging-in-unreal-engine

日志是一种非常实用的调试工具，可以详细说明代码当前的执行逻辑。你可以检查函数之间传递的数据值，并报告潜在的问题。

- 虚幻引擎中的日志功能提供了多种方法，来有序记录运行时特定时刻的事件、函数调用和变量值。
- 请前往 **窗口（Window）** > **输出日志（Output Log）** 查看虚幻编辑器中的日志。

![输出日志窗口](../../../../assets/images/37/37ddb8587be455f87ff39ecb619303ca9a183d283fd09904806e450b55bec49b.png)

输出日志窗口位于虚幻编辑器中。

- 日志保存在项目

  Saved/Logs

  目录的

  .txt

  文件中

## UE_LOG

**UE_LOG** 是一个将格式化消息记录到日志文件中的宏。

例如：

```
UE_LOG(LogTemp, Warning, TEXT("Hello World"));
```

- 第一个输入参数 `LogTemp` 是提供给 `DEFINE_LOG_CATEGORY` 宏的类别名称。你可以在位于 `CoreGlobals.h` 的引擎中找到这些类别。要自行创建自定义日志记录类别，请参阅[自行定义日志类别](#%E8%87%AA%E8%A1%8C%E5%AE%9A%E4%B9%89%E6%97%A5%E5%BF%97%E7%B1%BB%E5%88%AB)小节。
- 第二个输入参数 `Warning` 是一个日志详细级别，用于将警告打印到控制台和日志文件中。你可以设置不同的日志详细程度，调整日志的换行模式，或者设置日志的文本颜色。有关更多细节，请参阅[日志详细级别](#%E6%97%A5%E5%BF%97%E8%AF%A6%E7%BB%86%E7%BA%A7%E5%88%AB)小节。
- 第三个输入参数 `Text` 是C语言库函数printf样式中字符串文字的格式。

### 日志详细级别

**ELogVerbosity** 是一个定义日志记录系统日志详细级别的枚举。它定义了额外的非日志详细级别，允许给定日志换行或设置日志文本的颜色。

| 枚举 | 说明 |
| --- | --- |
| 致命（Fatal） | 始终将致命错误打印到控制台和日志文件，即使禁用日志记录，也会出现崩溃。 |
| 错误（Error） | 将错误打印到控制台和日志文件。Commandlet和编辑器会收集并报告错误。错误消息导致commandlet故障。 |
| 警告（Warning） | 将警告打印到控制台和日志文件。Commandlet和编辑器会收集并报告警告。 |
| 显示（Display） | 将消息打印到控制台和日志文件。 |
| 日志（Log） | 将消息打印到日志文件，但不打印到控制台。 |
| 冗长（Verbose） | 如果为给定类别启用了冗长日志记录，则将冗长消息打印到日志文件。 这通常用于详细日志记录。 |
| 极其冗长（VeryVerbose） | 将冗长消息打印到日志文件。如果启用了极其冗长日志记录，则这将用于详细日志记录，否则将产生垃圾信息输出。 下面是一些日志掩码和特殊枚举值示例： `VeryVerbose,NumVerbosity,VerbosityMask = 0xf,SetColor = 0x40, // not actually a verbosity, used to set the color of an output device BreakOnLog = 0x80` |
|  | VeryVerbose, |
|  | NumVerbosity, |
|  | VerbosityMask = 0xf, |
|  | SetColor = 0x40, // not actually a verbosity, used to set the color of an output device |
|  | BreakOnLog = 0x80 |

### 控制台命令

使用 `-LogCmds=` 时，可以从命令行更改不同日志类别的冗长度

例如：

```
    -LogCmds="LogDerivedDataCache Verbose"  
```

你可以使用此命令指定多个类别，包括可将每个日志类别切换到特定日志详细级别的"全部"类别。

### 日志记录基础数据类型

下表提供了关于如何记录特定数据类型的一些语法格式示例。

| 数据类型 | 示例 |
| --- | --- |
| `Fstring` | `UE_LOG(LogTemp, Warning, TEXT("An Actor's name is %s"), *ExampleActor->GetName());` |
| `布尔` | `UE_LOG(LogTemp, Warning, TEXT("The boolean value is %s"), ( bExampleBool ? TEXT("true"): TEXT("false") ));` |
| `整型` | `UE_LOG(LogTemp, Warning, TEXT("The integer value is: %d"), ExampleInteger);` |
| `浮点` | `UE_LOG(LogTemp, Warning, TEXT("The float value is: %f"), ExampleFloat);` |
| `Fvector` | `UE_LOG(LogTemp, Warning, TEXT("The vector value is: %s"), *ExampleVector.ToString());` |
| `多个说明符` | `UE_LOG(LogTemp, Warning, TEXT("Current values are: vector %s, float %f, and integer %d"), *ExampleVector.ToString(), ExampleFloat, ExampleInteger);` |

### 定义你自己的日志类别

你可以自行定义日志类别，并将其用在C++代码示例中。如果你的示例有多个文件或框架需要进行不同的分类，此功能可能会很有用。 在相关的头文件中，在include指令下方添加以下内容：

```
DECLARE_LOG_CATEGORY_EXTERN(<LOG_CATEGORY>, <VERBOSITY_LEVEL>, All);
```

其中 `<LOG_CATEGORY>` 是你的自定义日志类别字符串，而是以下表格值之一：

**日志详细级别**

| 日志详细级别 | 打印在控制台中 | 打印在编辑器日志中 | 文本颜色 | 其他信息 |
| --- | --- | --- | --- | --- |
| 致命（Fatal） | 是 | 不适用 | 不适用 | 会话崩溃。 |
| 错误（Error） | 是 | 是 | 红色 | 不适用 |
| 警告（Warning） | 是 | 是 | 黄色 | 不适用 |
| 显示（Display） | 是 | 是 | 灰色 | 不适用 |
| 日志（Log） | 否 | 是 | 灰色 | 不适用 |
| 冗长（Verbose） | 否 | 否 | 不适用 | 不适用 |
| 极其冗长（VeryVerbose） | 否 | 否 | 不适用 | 可使用日志掩码和特殊枚举值设置文本颜色。 |

在相关的C++文件中，在include指令下方添加以下内容：

```
DEFINE_LOG_CATEGORY(<LOG_CATEGORY>);
```

现在，你可以在C++文件代码中使用此类别，如下所示：

```
UE_LOG(<LOG_CATEGORY>, <VERBOSITY_LEVEL>, TEXT("My log string."));
```

> [!TIP]
> 你可以继承 `FOutputDevice`，实现你自己的输出类。

## UE_LOGFMT

**UE_LOGFMT** 会记录结构化日志事件，支持 **位置（Positional）** 或 **具名（Named）** 参数，但不能混合使用两种类型。要使用此宏，你需要包含 `Logging/StructuredLog.h` 库声明。

> [!WARNING]
> 虚幻引擎5.2中引入了 `UE_LOGFMT` 宏。检查你当前的引擎是否为最新版本。

| 参数名称 | 说明 |
| --- | --- |
| 位置（Positional） | 使用位置参数时，字段值必须与格式引用的字段完全匹配。 例如： `` UE_LOGFMT(LogCore, Warning, "Loading `{Name}` failed with error {Error}", Package->GetName(), ErrorCode); `` |
| 具名（Named） | 使用具名参数时，字段值必须包含格式引用的每个字段。顺序无关紧要，而且允许使用额外字段。 例如： `` UE_LOGFMT(LogCore, Warning, "Loading `{Name}` failed with error {Error}",("Name", Package->GetName()), ("Error", ErrorCode),("Flags", LoadFlags)); `` 字段名称必须匹配"[A-Za-z0-9_]+"格式，并且在此日志事件中必须唯一。字段值使用SerializeForLog或运算符 `<<(FCbWriter&, FieldType)` 进行序列化。 **类别名称（CategoryName）** ：DECLARE_LOG_CATEGORY_* 声明的日志类别的名称。 **冗长度（Verbosity）** ：`ELogVerbosity` 中的日志详细级别的名称。 **格式（Format）** ：以 `FLogTemplate` 样式格式化字符串。 **字段[0-16]（Fields[0-16]）** ： 0到16字段或字段值。 |

### 屏幕调试消息

屏幕调试消息也能起到很好的信息传递作用。你可以使用以下代码添加屏幕调试消息：

```
if (GEngine){    GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::White, TEXT("This is an Example on-screen debug message."));}
```

- 第一个输入参数 *key* 会获取一个唯一的整型值，用于防止同一消息被多次添加。
- 第二个输入参数 *TimeToDisplay* 会获取一个浮点值，用于表示消息在显示多少秒后消失。
- 第三个输入参数 *DisplayColor* 用于指定文本显示的颜色。
- 第四个输入参数 *DebugMessage* 是要显示的消息。你可以像使用日志那样，在屏幕调试消息中使用格式说明符和变量。

![undefined](../../../../assets/images/c7/c7a9d6720ab77f1d9ad0c6326a67b69d27229a3a4f4736095078027f1fc02b4c.jpg)

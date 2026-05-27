# Horde Logs

---
title: "Horde Logs"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-logs-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde内部机制", "Horde Logs"]
---

# Horde Logs

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde内部机制 / Horde Logs

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-logs-for-unreal-engine

过去，在 CI 系统中处理大型日志文件一直很困难。在构建基础设施的多个旧版本中，我们已经习惯了纯文本日志、打开大型 cook 日志时浏览器崩溃、搜索性能差等问题。

日志是 Horde 从一开始就希望正确处理的重点之一。需求列表中最重要的能力包括：

- 快速对大型日志执行索引文本搜索。
- 无需将完整日志下载到客户端即可浏览日志文件。
- 为日志中的事件提供更丰富的上下文感知功能，例如将它们与构建健康问题、Perforce 历史以及解释错误码含义的外部网站交叉引用。

## 存储

Horde 日志使用多种节点类型存储在 bundle 中。所有这些类都实现于 `Engine/Source/Programs/Shared/EpicGames.Horde/Logs`.

- LogNode

  对象是日志数据的主要入口，包含整个日志的元数据（行数、长度、是否仍在追加），以及指向包含日志数据的 chunk 和 index 节点的引用。
- LogChunkNode

  对象包含一段行范围内的原始 UTF-8 编码结构化日志数据，以及用于快速索引其中各行的偏移。从 root 到 chunk 的每个引用

  LogNode

  对象都包含其起始行号，这使系统能够快速确定某一特定行位于哪个节点中。
- LogIndexNode

  对象包含用于确定哪些 chunk 含有特定搜索词的数据块，以及该 chunk 的纯文本渲染。索引/搜索算法在下文描述。

生成日志的 Agent 通常会直接向存储后端上传数据，通过上传新的 root 节点以及任何追加的 chunk 和 index 节点来追加数据。

## 索引

索引从 UTF-8 日志消息的纯文本渲染生成。ANSI 字符 `A-Z` 会转换为小写形式。 `a-z`.

首先，消息会拆分为 token，每个 token 只包含以下类型的字符：

- 0：不属于下列类别的任何内容
- 1：字母字符

  [a-zA-Z]
- 2：数字字符

  [0-9]
- 3：空白字符

  [ \t]
- 4：换行字符

  \n

例如， `hello world123` 会拆分为四个 token： `hello`, ` `,`world`and`123`.

随后，每个 token 会进一步分解为 32 位 ngram；这是一个 32 位整数值，包含连续的 4 字符序列，部分 ngram 会左移到更高有效位。

```
"hell" = ('h' << 24) | ('e' << 16) | ('l' << 8) | 'l' = 0x68656c6c"o"    = ('o' << 24)                                  = 0x6f000000" "    = (' ' << 24)                                  = 0x20000000"worl" = ('w' << 24) | ('o' << 16) | ('r' << 8) | 'l' = 0x776f726c"d"    = ('d' << 24)                                  = 0x64000000"123"  = ('1' << 24) | ('2' << 16) | ('3' << 8)       = 0x31323300
```

这些值会插入稀疏 trie（`NgramSet`），覆盖 64 位整数空间，其中高 32 位为 ngram 值，低 32 位为包含该 ngram 的块索引。这形成了一个空间效率很高的数据结构，可用于粗略搜索 ngram 可能位于日志文件中的位置。

搜索特定字符串时，会对其执行相同的 ngram 转换，并找到所有包含该搜索词 **全部** ngram 的块索引。搜索词中的第一个和最后一个 token 会进行特殊处理，因为它们可能匹配源 token 内部，而源 token 可能具有更长或更短的前缀，从而改变其分解为 ngram 前的对齐。

获得搜索词的潜在匹配后，就可以执行成本更高的操作：获取 chunk，并使用简化的 Knuth-Morris-Pratt 算法搜索精确词项。

## 尾随读取

如果日志尚未标记为完成，则首次请求该日志时会启用日志 tailing。日志 tailing 请求会以 30 秒 TTL 存储在 Redis 中，并在后续调用时重置该值。

上传日志的 Agent 会轮询服务器，以确定是否需要 tailing。启用后，Agent 开始将尚未刷入持久存储的数据直接上传到服务器；这些数据会存储在 Redis 中，并在客户端后续读取日志时返回。

## JSON 语法

Horde Agent 生成的日志每行包含一个 JSON 对象。属性如下：

| 名称 | 类型 | 说明 |
| --- | --- | --- |
| `time` | `String` | 事件发生的时间戳，使用 UTC。 |
| `level` | `String` | 事件级别。有效值列在 [此处](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.logging.loglevel). |
| `id` | `Integer` | 事件标识符。已知事件 ID 列于 `Engine/Source/Progams/Shared/EpicGames.Core/KnownLogEvents.cs.` |
| `message` | `String` | 渲染后的事件消息。 |
| `format` | `String` | 用于使用标准 [消息模板](https://messagetemplates.org/) 语法渲染消息的格式化字符串。 |
| `properties` | `Object` | 格式字符串的属性字典。更多信息见下文。 |
| `lineIndex` | `Integer` | 对于多行消息，表示此日志事件在该消息中的从 0 开始的索引。 |
| `lineCount` | `Integer` | 对于多行消息，表示该消息的总行数。 |

属性可以是任何常规 JSON 类型，也可以是包含 `$type` 属性的对象，表示仪表板可以将其视为特定类型（并相应渲染）。 `$type` 的有效值定义于 `LogValueType` 类，位于 `Engine/Source/Programs/Shared/EpicGames.Core/LogValue.cs`，包括：

| 名称 | 说明 | 附加字段 |
| --- | --- | --- |
| `Asset` | 资产路径 | `file`：包含该资产的本地文件 `depotPath`：包含该资产的文件的 Perforce depot 路径 |
| `SourceFile` | 包含源代码的文件路径 | `file`：包含该资产的本地文件 `depotPath`：包含该资产的文件的 Perforce depot 路径 |
| `Channel` | Unreal Engine 通道名称 |  |
| `Severity` | Unreal Engine 通道严重级别 |  |
| `LineNumber` | 编译器错误消息的行号 |  |
| `ColumnNumber` | 编译器错误消息的列号 |  |
| `Symbol` | C++ 链接器符号 | `identifier`：未修饰符号名称 |
| `ToolName` | 对于标准 Microsoft 错误，表示产生该错误的工具名称。 |  |
| `ScreenshotTest` | 失败截图测试的名称。 |  |

当指定 `$type` 字段时，也可能存在 `$text` 字段。这表示在源头确定的该字段预期渲染方式，不受 Horde 之后添加的任何导航或上下文敏感功能影响。


---
title: "着色器调试工作流程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/shader-debugging-workflows-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "图形编程", "着色器开发", "着色器调试工作流程"]
---

# 着色器调试工作流程

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 图形编程 / 着色器开发 / 着色器调试工作流程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/shader-debugging-workflows-unreal-engine

调试着色器的主要途径是启用控制台变量 `r.Shaders.Symbols` 。这将触发引擎准备着色器以按特定于平台的程序调试，例如[RenderDoc](../../../optimizing-and-debugging-projects-for-realtime-rendering/using-renderdoc/index.md)和PIX。

你可以逐个平台覆盖此控制台变量以及下面列出的其他变量。这样做很重要，可使额外的着色器编译保持可控。

## 着色器调试工作流程

下面说明了三个着色器调试工作流程示例。在每种情况下，你需要编辑你想在其中调试着色器的平台的 **配置文件** 。 例如，如果你要为Android调试着色器，就需要将控制台变量添加到 **AndroidEngine.ini** 文件。

### 示例：使用特定于平台的着色器调试器

你需要使用特定于平台的着色器调试器在该平台上烘焙的游戏中调试着色器。

将以下文本添加到你的 **[平台]Engine.ini** 文件：

```
	[ShaderCompiler]	r.Shaders.Symbols=1 
```

使用编辑器或虚幻编译工具（UBT）为该平台烘焙你的游戏。在该平台上创建GPU捕获。如果系统要求提供着色器符号路径，指向文件夹 `Path/To/My/Project/Saved/ShaderSymbols/Platform` 。

### 示例：仅让构建机器将符号写入Zip文件

你始终需要为平台构建着色器符号，并仅让构建机器将它们写入 `.zip` 文件。

将以下文本添加到你的 **[平台]Engine.ini** 文件：

```
	[ShaderCompiler]	r.Shaders.GenerateSymbols=1 	[ShaderCompiler_BuildMachine]	r.Shaders.WriteSymbols=1	r.Shaders.WriteSymbols.Zip=1 
```

现在构建机器将生成以下 `.zip` 文件：`Path/To/My/Project/Saved/ShaderSymbols/Platform/ShaderSymbols.zip` 。

### 示例：在本地调试着色器

你有一个图形程序员在使用与示例2相同的设置处理一个项目，并且需要在本地调试着色器。

在这种情况下，用户应当在本地编辑 **[平台]Engine.ini** 并添加以下内容：

```
	[ShaderCompiler]	r.Shaders.WriteSymbols=1 
```

当这位程序员烘焙你的项目时，着色器会全部零散地写入 `Path/To/My/Project/Saved/ShaderSymbols/Platform` 。

## 控制台变量摘要

这些是可用于着色器调试的控制台变量。

| 控制台变量 | 说明 |
| --- | --- |
| `r.Shaders.Symbols` | 通过生成符号来启用着色器调试。如果平台需要外部符号，它们会被写入磁盘；否则，它们存储在运行时加载的着色器数据中。你可以逐个平台将其覆盖。 |
| `r.Shaders.ExtraData` | 生成着色器名称和其他逐个平台的额外着色器数据。你可以逐个平台覆盖此变量。 |
| `r.Shaders.GenerateSymbols` | 生成符号，但不将其写入磁盘。你可以逐个平台覆盖此变量。 |
| `r.Shaders.WriteSymbols` | 如果平台支持外部符号，则在它们已生成时将其写入磁盘。你可以逐个平台覆盖此变量。 |
| `r.Shaders.SymbolPathOverride` | 如果平台支持外部符号，你可以使用此控制台变量来覆盖它们所写入的位置。 |
| `r.Shaders.WriteSymbols.Zip` | 如果平台支持外部符号，并且它们需要写入磁盘，则将其写入单个 `.zip` 文件而不是各个单独的文件。 |
| `r.Shaders.AllowUniqueSymbols` | 如果平台支持外部符号，则从产生的着色器而不是其源文件生成符号文件名。我们不推荐启用此变量，因为它可能会显著增加你的符号的大小。 |

## 平台覆盖

你可以通过将特殊分段添加到 **[平台]Engine.ini** 文件，逐个平台覆盖着色器符号控制台变量。

例如，如果你需要在Android平台上覆盖着色器符号控制台变量，则将以下文本添加到你的 **AndroidEngine.ini** ：

```
	[ShaderCompiler_BuildMachine]	控制台变量放在这里。 
```

## UE4以来的更改

在虚幻引擎5中，用于调试着色器的控制台变量已更改。下表高亮显示了旧的UE4控制台变量和UE5中使用的新名称。将项目迁移到UE5时，你需要更新使用这些控制台变量的配置文件，以继续使用生成的数据和调试着色器。

| 旧名称 | 新名称 | 说明 |
| --- | --- | --- |
| `r.Shaders.KeepDebugInfo` | `r.Shaders.Symbols` | 通过生成符号并将其写入主机的磁盘来启用着色器调试，PC符号仍以内联方式存储。 |
| *参见备注* | `r.Shaders.ExtraData` | 生成着色器名称和其他"额外"着色器数据。 |
| `r.Shaders.PrepareExportedDebugInfo` | `r.Shaders.GenerateSymbol` | 生成符号，但不将其写入磁盘（备注：符号存储在DDC中） |
| `r.Shaders.ExportDebugInfo` | `r.Shaders.WriteSymbols` | 如果符号已生成，则将其写入磁盘。 |
| `r.Shaders.AllowUniqueDebugInfo` | `r.Shaders.AllowUniqueSymbols` | 基于着色器源生成符号关联（默认情况下关闭）。 |
| `r.Shaders.ExportDebugInfo.Zip` | `.Shaders.WriteSymbols.Zip` | 启用将所有符号写入磁盘作为单个 `.zip` 文件的操作。 |

> [!NOTE]
> 只需要符号时，`r.Shaders.KeepDebugInfo` 分割为 `r.Shaders.Symbols` 和 `r.Shaders.ExtraData` ，以删除对运行时着色器数据的更改。这尤其适合支持导出的调试信息的平台，因为这样你可以为发布版本生成符号而不更改最终着色器数据。

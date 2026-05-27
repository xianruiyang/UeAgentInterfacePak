# MetaSound Builder API

---
title: "MetaSound Builder API"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/metasound-builder-api-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "Sound Source", "MetaSounds", "MetaSound Builder API"]
---

# MetaSound Builder API

> 路径：虚幻引擎5.7文档 / 处理音频 / Sound Source / MetaSounds / MetaSound Builder API

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/metasound-builder-api-in-unreal-engine

该 **MetaSound Builder API** 指公共蓝图和 C++ API，使 Gameplay 开发者和设计师可以从 Gameplay 代码中程序化创作 MetaSound，并通过可用于支持不同硬件性能等级的变体进行适配。使用 Builder API，可以在内存中创建 MetaSound，而无需使用 MetaSound Editor。

此外，由 builder 管理的 MetaSound Source 提供以下优点：

- 可以在编辑时序列化它们。
- 可以在编辑时或运行时播放它们。
- 可以使用 Blueprint API 实时试听更改。借助该功能，可以为多个 MetaSound 图表实时生成可听反馈，并支持缓冲交叉淡化，避免因图表更改产生爆音或咔哒声。

> [!NOTE]
> Builder API 当前不支持变量。分页输入和图表也仅有有限支持，不能通过蓝图创作，也不能在编辑时之外通过 frontend Builder API 创作。

## Builder API 概述

Builder API 指 MetaSound 插件中一组松散相关的类或结构体，它们支持 MetaSound 的创作和执行。

MetaSound Editor、Engine、Frontend 和 GraphCore 模块各自都有 builder，分别负责：

- 管理 MetaSound 可视化，
- UObject 操作和反射，
- 序列化，
- 执行。

本文更广泛地介绍如何创作 MetaSound，并介绍 `BuilderSubsystem` 类（位于 MetaSound Engine 模块）以及 `FrontendDocumentBuilder` 结构体（位于 Frontend 模块）。

![slide_3](../../../../../assets/images/8e/8e25c007bc132729fb0cf4f1b18227324565d5a9c2b5b16c3469e3e85cd67e7d.png)

MetaSound `UObject` 资产类（`UMetaSoundSource` 和 `UMetaSoundPatch` 类型）包含一个名为 `MetaSoundFrontendDocument`.

该 `MetaSoundFrontendDocument` 的结构体，其中包含：

- 构建

  MetaSoundGenerator

  播放实例所需的所有图表信息。
- 图表使用的样式和显示元数据（包括节点放置坐标、图表对象显示名称和 widget 显示信息）。

该 `MetaSoundFrontendDocumentBuilder` 结构体会操作 `MetaSoundFrontendDocument` 结构体。下文讨论的蓝图友好类会包装 `MetaSoundFrontendDocumentBuilder` 结构体。

## Builder 蓝图 UClass 简介

下表介绍构建 MetaSound 时使用的主要蓝图 UClass。

| **类名** | **上下文** | **说明** |
| --- | --- | --- |
| **MetaSound Builder Subsystem** | Editor / Runtime | 创建和访问 MetaSound Builder 的入口点。 |
| **MetaSound Editor Subsystem** | 仅编辑器 | 操作仅编辑器 MetaSound 数据，以及导出或序列化 MetaSound 资产的入口点。 |
| **MetaSound Asset Subsystem** | Editor / Runtime | 与 MetaSound 特定资产加载/卸载相关的功能。 |
| **MetaSound Patch** | Editor / Runtime | 封装可共享的实用 MetaSound 图表行为。 |
| **MetaSound Source** | Editor / Runtime | 封装输出音频为单个声源的图表。 |
| **MetaSound Document Interface** | Editor / Runtime | 所有 MetaSound UObject 实现的基础接口，作为进入 MetaSound Frontend Document 结构体的入口点。 |
| **MetaSound Patch Builder** | Editor / Runtime | 用于修改或查询 MetaSound Patch UObject 的 UObject。 |
| **MetaSound Source Builder** | Editor / Runtime | 用于修改或查询 MetaSound Source UObject 的 UObject。 |

## Builder 图表句柄

以下 UStruct 是 MetaSound Document 中各种图表数据的句柄。

> [!NOTE]
> 在内容版本化或重建临时资产时，底层句柄 ID 可能会改变。绝不应序列化这些句柄。

| **句柄名称** | **说明** |
| --- | --- |
| **MetaSound Node Handle** | MetaSound 图表中某个节点的句柄。 |
| **MetaSound Node Output Handle** | MetaSound 图表中某个节点输出的句柄。 |
| **MetaSound Node Input Handle** | MetaSound 图表中某个节点输入的句柄。 |

## Builder 蓝图函数和编辑器操作

Blueprint Builder API 中几乎所有功能都可以关联到 MetaSound Editor 中可执行的操作。

以下章节列出最常见的操作，以及其对应的 MetaSound Editor 等价操作。

### MetaSound 构建

下面的示例利用 MetaSound Builder Subsystem 构建一个 builder，该 builder 会创建一个新的、类似于从 Content Browser 创建 MetaSound 的内部管理 MetaSound。

构建 Source builder 会返回 builder，并处理底层 MetaSound 图表的输入和输出。

![slide_8](../../../../../assets/images/bf/bf6ca338078fae0ab93848431f79eaf09e889e220f049c439bc7ad2849f9e6f4.jpg)

根据 Create Source Builder 蓝图节点输入上设置的选项，某些句柄可能无效或依赖上下文。例如，根据 Is One Shot 蓝图输入选项不同，返回的 OnFinished 节点输入句柄可能有效，也可能无效。

![slide_9](../../../../../assets/images/be/beb5242a1931d9ded30aa7843bf1203ca966fcb9c6e340963c542ceb36310661.jpg)

### 添加或移除接口

与使用 MetaSound Editor 中的接口 MetaSound 面板类似，Blueprint API 支持通过接口添加和移除整组相关输入与输出。

![slide_10](../../../../../assets/images/5c/5ccc0eaf8c55ada5cb785bc9f2aa497d7d36287a5433f978e9176995bc5d4011.jpg)

### 添加节点

可以用两个函数添加节点。第一个函数需要类名，适用于 Mixer、Math 或 Generator 等原生定义的节点类。第二个函数需要一个实现 MetaSound Document Interface 的对象引用，例如 MetaSound Source 或 MetaSound Patch。

![slide_11](../../../../../assets/images/df/df85875b403d24158038a8898149af34979955f2159f8b7df908477c2ae9510b.jpg)

无需访问代码，也可以确定原生定义节点类的名称，方法是按住 **Shift** 并将鼠标悬停在 MetaSound Editor 中的节点名称上。工具提示会显示该节点的调试信息，包括完整类名。

![slide_12](../../../../../assets/images/83/8309654723ad8548c40e830e92d5233d6d168707e0f35d61b404325205f25fea.jpg)

> [!NOTE]
> Blueprint Builder API 不支持添加 reroute 等模板节点。不过原生 Frontend Document Builder API 支持。

### 访问 MetaSound 节点顶点

可以使用 **Find Node Input/Output** 函数访问节点上的单个输入和输出。

![slide_13](../../../../../assets/images/12/12fe4e20b1b43f7b4c8adb6b57b16de7cee9160b14dfc8433c0e6d53f5061a24.jpg)

> [!NOTE]
> 根据模块/代码层不同，节点连接点可能称为 pin、vertex，或节点输入和输出。

### 连接 MetaSound 节点顶点

可以使用 **Connect Nodes** 函数以及对应输入和输出句柄，在节点之间应用连接。这等同于在 MetaSound Editor 中拖拽节点连接。

![slide_14](../../../../../assets/images/83/83aa2f400426a05b7ad15d7793b80921982929129caa5926bccd0338cfba7a2a.jpg)

> [!NOTE]
> 根据模块/代码层不同，vertex 之间的关联可能称为 connection 或 edge。

### 访问图表输入/输出节点

可以使用 **Find Graph Input/Output** 函数访问节点上的单个输入和输出。

> 图片已省略：slide_15

> [!NOTE]
> 在 MetaSound Editor 中，可以按住 **Shift** 并将鼠标悬停在节点 pin 上，以显示包含给定成员代码名称的工具提示。Vertex 的显示名称可能不同于 FName。

### 元素移除

可以使用以下函数移除图表元素：

- Disconnect Node

  - 移除所提供输入和输出句柄之间的连接。
- Remove Node

  - 移除与给定句柄关联的节点，以及任何相关连接。
- Remove Graph Input/Output

  - 移除给定图表 vertex、节点和任何相关连接。
- Remove Interface

  - 移除给定接口及所有相关输入、输出、节点和连接。

> 图片已省略：slide_16

## Builder 试听

MetaSound Source Builder 最强大的功能之一，是可以实时试听底层 MetaSound Source 图表拓扑的更改。

可以使用 **Audition** 函数，在 source builder 上通过提供的 AudioComponent 播放受管理的 MetaSound Source。如果设置 **Live Updated Enabled**，图表拓扑的更改会立即反映出来。

> 图片已省略：slide_17

> [!NOTE]
> 截至 5.5，Live Updates 是 Beta 功能。

## MetaSound Editor Subsystem Builder 函数

可以使用 **Find Or Begin Building** 函数修改既有 MetaSound。

> [!NOTE]
> 由于需要 **MetaSound Editor Subsystem**，只能在编辑器构建中修改已序列化的 MetaSound 资产。

> 图片已省略：slide_18

要设置节点的图表位置，可以使用 **Set Node Location** 函数，在编辑时通过 MetaSound Editor Subsystem 执行。

> 图片已省略：slide_19

该 **Build To Asset** 函数会将 Builder 的 MetaSound 导出为具有所提供名称和路径的序列化资产。

> [!TIP]
> 使用 **Content Browser** 中的右键上下文菜单可快速获取路径信息。

> 图片已省略：slide_20


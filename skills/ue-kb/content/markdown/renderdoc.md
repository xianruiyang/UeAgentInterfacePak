# 使用RenderDoc分析虚幻引擎画面

---
title: "使用RenderDoc分析虚幻引擎画面"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-renderdoc-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "使用RenderDoc分析虚幻引擎画面"]
---

# 使用RenderDoc分析虚幻引擎画面

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 使用RenderDoc分析虚幻引擎画面

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-renderdoc-with-unreal-engine

RenderDoc是一款免费开源的图形调试程序，可以逐帧捕捉虚幻引擎等应用的画面。 捕捉内容将被载入到RenderDoc中，并解释各个事件、API等内容对GPU的影响。

## 安装RenderDoc

RenderDoc是一款开源图形调试器，可从[RenderDoc.org](https://renderdoc.org/)免费下载和安装。

> [!NOTE]
> 以下列表指明了RenderDoc当前支持的操作系统和API，它们与虚幻引擎的支持可能有所不同。 有关最新更新，请参阅[RenderDoc常见问题解答](https://renderdoc.org/docs/getting_started/faq.html?highlight=support#what-apis-does-renderdoc-support)页面。

RenderDoc支持以下操作系统：

- Windows 7、10和11
- Linux
- Android

RenderDoc支持以下API：

- Vulkan
- D3D11
- D3D12
- OpenGL 3.2+
- OpenGL ES 2.0 — 3.2

## 在你的项目中启用RenderDoc

**RenderDoc**插件随附在引擎中并默认启用。 你可以通过两种方式对项目运行RenderDoc：使用命令行参数或项目设置。

若RenderDoc在启动时附加，你会在关卡视口右上角看到RenderDoc图标。

![RenderDoc关卡视口图标](../../../../assets/images/fb/fbb6a598b7c6c7e40fccf4c6f53d2dfa291a9b49ff36b401271d02c38e717b25.jpg)

执行下面的步骤，查看每一项的启用方式。

### 使用插件项目设置启用

在项目设置的**插件（Plugins）> RenderDoc**中的**高级设置（Advanced Settings）**下，启用启动时**自动附加（Auto attach on startup）**。 如果你希望不论项目在何时加载均在启动时运行RenderDoc，那么此方法非常适合。

![RenderDoc插件设置](../../../../assets/images/75/756d78937d5ca96f570cf384e8bbc4b1588afa2c6766309d4fa98b3cb3e2f0e9.jpg)

### 通过命令行启用

使用编辑器快捷方式启用命令行参数。 在**快捷方式（Shortcut）**选项卡中，将以下内容添加到**目标（Target）**行：`-AttachRenderDoc`。 如果你只希望在某些时候运行RenderDoc，此方法非常适合。

![RenderDoc项目快捷方式示例](../../../../assets/images/11/118e5fecbaa33b6e920956ff9b048379b1f8d59ea5caf607d04fe91ebebd3f3e.png)

## 执行帧捕获

以下步骤详细介绍如何使用集成的RenderDoc插件或直接在RenderDoc应用程序中对虚幻引擎项目执行单帧采集。

欲知RenderDoc功能和使用的详细信息，请参阅[RenderDoc文档](https://renderdoc.org/docs)。

### RenderDoc插件

以下是使用虚幻引擎的RenderDoc插件进行帧采集的步骤：

1. 为你的项目启用RenderDoc插件。
2. 打开需要执行采集的项目和场景。
3. 在关卡视口中点击**RenderDoc采集（RenderDoc Capture）**按钮。

   *点击查看大图。*

### RenderDoc应用程序

以下是使用虚幻引擎以及独立版RenderDoc进行帧采集的步骤（进阶版）：

1. 使用对应的命令行参数来配置RenderDoc启动游戏或UEEditor.exe。

   > [!NOTE]
   > 启动UEEditor.exe时启用**采集子进程（Capture Child Processes）**。
2. 启动可执行文件。
3. 按下**F12**热键执行帧采集。

> [!NOTE]
> 欲知设置RenderDoc、启动应用程序和执行帧采集的详细信息，请参阅[RenderDoc入门指南](https://renderdoc.org/docs/getting_started/quick_start.html)。

## 项目设置

在项目设置（Project Settings）窗口中设置RenderDoc插件的其他选项。 在主菜单中，选择**编辑（Edit）** > **项目设置（Project Settings）**，然后在**插件（Plugins）**类目下选择**RenderDoc**。

| 属性 | 说明 |
| --- | --- |
| 帧采集设置（Frame Capture Settings） |  |
| **捕获所有活动** | 启用后，RenderDoc将采集整个帧过程中所有视口和编辑器窗口中的所有活动，而不仅是当前视口中的活动。 |
| **捕获所有调用堆栈** | 启用后，RenderDoc将采集所有API调用的调用堆栈。 |
| **引用所有资源** | 启用后，RenderDoc将包括采集中的所有渲染资源，甚至包括帧过程期间未使用的资源。启用此属性会极大增加采集内容的容量。 |
| **保存所有初始状态** | 启用后，RenderDoc将始终采集所有渲染资源的初始状态，即使这些渲染资源不大可能在帧过程中使用也同样如此。启用此属性会极大增加采集内容的容量。 |
| 高级设置 |  |
| **在启动时显示帮助** | 启用后，RenderDoc的帮助窗口将在编辑器启动时显示。 |
| **使用RenderDoc崩溃处理程序** | 启用后，发生崩溃时将使用RenderDoc崩溃处理器。建议在你了解RenderDoc应用程序存在问题并想要通知RenderDoc开发人员时才使用此设置。 |
| **RenderDoc可执行路径** | 设置要使用的RenderDoc可执行文件的路径。安装RenderDoc时，它应自动填写正确路径。 |

## 其他注释和资源

- 欲知有关RenderDoc使用和帧采集分析的更多内容，请参阅[RenderDoc文档](https://renderdoc.org/docs)。
- RenderDoc插件由Fredrik Lindh（"Temaran"）为虚幻引擎开发。 欲知更多信息，请参阅RenderDoc的[GitHub仓库](https://github.com/Temaran/UE4RenderDocPlugin)。


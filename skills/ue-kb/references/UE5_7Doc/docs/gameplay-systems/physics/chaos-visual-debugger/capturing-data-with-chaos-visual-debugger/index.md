---
title: "使用Chaos可视调试器捕获数据"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/capturing-data-with-chaos-visual-debugger"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "Chaos可视调试器", "使用Chaos可视调试器捕获数据"]
---

# 使用Chaos可视调试器捕获数据

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / Chaos可视调试器 / 使用Chaos可视调试器捕获数据

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/capturing-data-with-chaos-visual-debugger

在下文教程中，你将使用**[Chaos可视调试器](../index.md)**（**CVD**）捕获并播放本地或远程机器上目标的录制内容，包括：

- 游戏客户端和服务器
- 已打包构建
- 在编辑器中运行的会话

> 动图已省略：CVD捕获的城市示例

## 数据通道

CVD会录制来自多个系统的大量数据。 场景越复杂，CVD文件就越大，就越影响性能。 要管理文件大小，你可以开关**数据通道**来选择不录制某些数据。

数据通道能控制CVD将录制哪些模拟阶段或数据可视化标记。

要开关数据通道，请点击主工具栏中的**数据通道（Data Channels）**，然后勾选所需的通道。

![开关数据通道](../../../../../assets/images/a7/a71509f66f83a4920212131e9020a067fe827312d2266977e5579cf9d21f35e6.jpg)

> [!WARNING]
> 在CVD中录制需要控制台的访问权限，例如在**测试**或**开发**构建配置中。 使用测试配置时，CVD的大纲视图不会显示对象的调试名称。 如需详细了解构建配置，请参阅[打包虚幻引擎项目](../../../../sharing-and-releasing-projects/packaging-and-cooking/packaging-your-project/index.md)。

## 会话目标

CVD会将你打算录制的应用程序或编辑器描述为**目标**，这包括游戏客户端、游戏服务器、已打包构建或PIE会话等。 除PIE会话外，你可以同时录制一个或多个目标，这些目标被称为**单一**源或**多个**源。

**会话目标**下拉菜单提供了准备录制时可选择的目标预设，但你也可以指定自定义目标。 此菜单的默认对象为"本地编辑器（Local Editor）"，这意味着如果你打算录制本地PIE会话，则可以保留此设置。

![会话目标](../../../../../assets/images/fa/fadba2a00066325334d2502fbae8acf6f80f4d53ecb25a38fa6f4deaee9fcb89.jpg)

| 目标 | 说明 | 源数量 |
| --- | --- | --- |
| **本地编辑器（Local Editor）** | 录制本地PIE会话。 | 单一 |
| **所有远程（All Remote）** | 录制所有非编辑器实例。 | 多个 |
| **所有远程服务器（All Remote Servers）** | 录制所有非编辑器的游戏服务器。 | 多个 |
| **所有远程客户端（All Remote Clients）** | 录制所有非编辑器的游戏客户端。 | 多个 |
| **所有（All）** | 录制所有可用目标。 | 多个 |
| **自定义选择（Custom Selection）** | 录制自定义目标。 | 单一或多个 |

> [!TIP]
> 当你已经在录制一个游戏服务器和客户端时，如果还需要再加录一个客户端，那么多目标录制功能就派上用场了。

## 下一步

- [录制到文件](recording-to-file/index.md) - 使用Chaos可视调试器录制到文件

- [录制实时会话](live-debugging-with-chaos-visual-debugger/index.md) - 使用Chaos可视调试器录制实时会话

- [在Chaos可视调试器中播放](playback-in-chaos-visual-debugger/index.md) - 在Chaos可视调试器中播放录制内容。

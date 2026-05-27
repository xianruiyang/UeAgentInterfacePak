---
title: "Horde构建自动化教程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-build-automation-tutorial-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde教程", "Horde构建自动化教程"]
---

# Horde构建自动化教程

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde教程 / Horde构建自动化教程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-build-automation-tutorial-for-unreal-engine

## 简介

Horde使用BuildGraph作为脚本语言，实现构建自动化系统，支持Windows、Mac和Linux。构建自动化系统与Horde的远程执行功能、UnrealGameSync以及虚幻引擎生态系统中的其他工具紧密集成。

持续集成（CI）和持续交付（CD）是构建自动化的常用术语名称，可确保持续监控项目状态并定期生成构建。

## 先决条件

- Horde服务器和一个或多个Horde代理（参阅

  Horde安装教程

  ）
- 具有流送的已配置Perforce服务器，包含虚幻引擎5.4或更高版本。

  - 目前不支持旧版Perforce分支。
  - Horde将来可能会支持其他修订控制系统。

## 设置

1. 找到包含Horde服务器配置文件的 `C:\ProgramData\Epic\Horde\Server` 文件夹。

   - C:\ProgramData

     文件夹默认隐藏。你可能得手动将其输入到Windows资源管理器地址栏中。
2. 打开 `globals.json` 文件。

   - 此文件是服务器的两个主要配置文件之一。

     server.json

     文件将配置特定于此机器的设置（例如与之通信的其他服务器、日志记录设置等），而

     globals.json

     文件将配置多机器安装中所有服务器实例共享的设置。
   - 有关更多信息，请参阅

     配置 > 方向

     。
   - 有关所有设置的详细信息，请参阅

     配置 > 模式 > Globals.json

     。
3. 在配置文件的 `perforceClusters` 分段配置你的Perforce服务器。

   - 默认配置包含在内但已被注释掉 - 根据你的部署配置

     serverAndPort

     和

     credentials

     条目。
   - 保存文件时，服务器将自动重新加载

     globals.json

     的所有更改。
   - 你可能希望进入Horde操作面板（默认情况下为

     http://localhost:13340

     ），打开

     服务器（Server）

     菜单，然后选择

     状态（Status）

     。此页面显示各种服务器子系统的状态，包括Perforce连接状态 - 应确认其正在工作中。
4. 通过取消注释 `globals.json` 中的以下行来启用示例项目：

   ```
        "projects": [         {             "id": "ue5",             "path": "ue5.project.json"         }     ]
   ```

   - Horde术语中的项目通常是指游戏或项目，类似于Perforce中的流送仓库。Epic在我们的内部Horde实例上的

     UE5

     项目下有数个流送，例如

     //UE5/Main

     、

     //UE5/Release-5.5

     、

     //UE5/Dev-Main-HordeDemo

     等等。
   - 引用的配置文件

     ue5.project.json

     存在于同一目录中，并引用

     ue5-release-5.5.stream.json

     中配置的流送。对于本教程来说，该文件的名称并不重要。

5.打开 `ue5-release-5.5.stream.json` 文件，并将 `name` 属性更新为Perforce服务器上的流送。默认为 `//UE5/Release-5.5-HordeSync` 。

* 你应更新下面的 `Project` 和 `ProjectPath` 宏以引用你的项目。默认情况下，这些设置为编译Epic Games的 **Lyra** 样本。

6.此时，你会在Horde操作面板的菜单栏中看到列出的 **UE5** 项目。单击此按钮并选择你在上面配置的流送。

* 你可能需要在Web浏览器中刷新操作面板才能显示项目。

## 默认作业

示例 `ue5-release-5.5.stream.json` 文件将在Horde操作面板中配置其页面的外观，以及作业模板和代理类型。

- 作业模板

  将定义一组用于构造

  BuildGraph

  命令行的参数。作业模板用于启动作业。
- 代理类型

  将定义从BuildGraph脚本中列出的代理到可以执行该脚本的机器池的映射，以及这些机器应从Perforce同步什么内容来执行该作业的设置。

启用示例流送后，连接到服务器的所有代理都将开始同步必要的Perforce工作区，以支持其匹配的代理类型。

示例流送的默认页面在页面顶部显示选项卡，可用于对相关的作业类型进行分组。不同选项卡上有数个预定义作业。

### 增量

- 增量构建（Incremental Build）

  - 为你的项目编译编辑器，并将编辑器构建上传到可与UnrealGameSync同步的Horde。这些作业设计为在一天之中快速频繁运行，并且使用运行之间不清理的增量工作区。这使得作业能够快速启动并使用以前运行中生成的中间构件。

### 已打包构建

- 已打包项目构建（Packaged Project Build）

  - 为不同的目标平台编译和烘焙独立游戏/客户端/服务器构建，并在构建上运行标准测试。这些作业在非增量工作区上运行，将其恢复到作业开始之前的原始状态。

### 预提交

- 预提交测试（Presubmit Tests）

  - 在代表发起用户提交变更之前，对搁置的变更列表执行快速编辑器编译。可通过UnrealGameSync启用的

  P4VUtils

  工具将为Perforce P4V提供扩展，以便你可以通过UI在架子上启动预提交构建。

### 工具

- 已安装引擎构建（Installed Engine Build）

  - 创建已安装引擎构建，类似于可从Epic游戏商城下载的构建。使用已安装引擎构建，你可以像使用SDK一样使用该引擎。这专为不想对引擎进行大量修改的小型团队而设计。
- 参数演示（Parameter Demo）

  - 展示可通过Horde操作面板配置的不同类型的参数，以及如何从相应的BuildGraph脚本（

  Engine/Build/Graph/Examples/Parameters.xml

  ）中使用参数。
- 远程执行测试（Remote Execution Test）

  - 使用UnrealBuildAccelerator测试编译。Horde通过环境变量将设置传递给作业，环境变量使得UnrealBuildTool无需任何额外配置即可连接到服务器。
- 测试执行器（Test Executor）

  - 运行带有模拟错误或警告的模拟作业，这对于在不同步Perforce工作区的情况下测试与代理的连接很有用。

## 另请参阅

- 配置 > 构建自动化

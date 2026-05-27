---
title: "自动化工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-automation-tool-overview-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "自动工具", "自动化工具"]
---

# 自动化工具

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 自动工具 / 自动化工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-automation-tool-overview-for-unreal-engine

**AutomationTool** 是一个主机程序和一组实用程序库，通过它可以使用C#来编制与 **虚幻引擎（UE）** 相关的无人值守过程脚本。我们在内部使用AutomationTool执行各种任务，包括构建、转化和运行游戏，运行自动化测试，和编制其他操作的脚本以在我们的Build Farm上运行。

AutomationTool的源代码以及在它下面运行的各种脚本都可以在 `Engine/Source/Programs/AutomationTool` 下找到。

> [!WARNING]
> 虽然我们出于好意提供此工具，但我们所能提供的支持级别有限。

## AutomationTool的工作原理

### 自动化项目

AutomationTool运行时会查找所有自动化项目（以Visual Studio C#项目的形式保存，带有 `.Automation.csproj` 扩展名），编译它们，然后使用反射法找到要执行的相应命令。这些命令作为从 `BuildCommand` 基础类衍生的类实现，通过类名标识。

> [!NOTE]
> 要了解更多信息，请阅读如何[添加自动化项目](../create-an-automation-project/index.md)和如何[添加命令](https://dev.epicgames.com/documentation/404)。

### 运行AutomationTool

你可以在Windows上通过Visual Studio调试程序运行命令，也可以从Windows、Mac和Linux上的命令行运行命令。

#### 通过调试程序运行命令

要通过Visual Studio中的调试程序运行AutomationTool：

1. 右键点击AutomationTool项目，然后从情境菜单中选择 **属性（Properties）**。
2. 选择 **调试（Debug）** 选项卡，然后在 启动选项 > 命令行参数：**（Start Options > Command line arguments:）** 字段中输入命令名称（我们在这个示例中使用 `SampleCommand`）。
3. 在脚本中设置断点，然后按F5键（或点击Visual Studio工具栏中的 **启动（Start）** 按钮）。

#### 从命令行运行命令（Windows）

要从命令行运行AutomationTool：

1. 打开一个命令提示符窗口。
2. 将工作目录改到 `Engine/Build/BatchFiles`。
3. 在命令行中输入下列内容：`RunUAT.bat SampleCommand`

#### 从终端运行命令（Mac/Linux）

要从终端运行AutomationTool：

1. 打开终端。
2. 将工作目录改到 `Engine/Build/BatchFiles`。
3. 在命令行中输入下列内容：`./RunUAT.sh SampleCommand`

### 命令行语法

AutomationTool命令行的一般语法：

`RunUAT.bat Command1 [-Arg1 -Arg2...]Command2 [-Arg3 -Arg4…] ...`

这里的两条命令将会依次运行。`-Arg1` 和 `-Arg2` 会传递到 `Command1`，而 `-Arg3` 和 `-Arg4` 传递到 `Command2`。

全局选项：

| 选项 | 说明 |
| --- | --- |
| `-Help` | 显示AutomationTool的一般帮助和选项，或（如果在命令名称之后指定此选项）显示特定命令的帮助。 |
| `-List` | 显示所有可用AutomationTool命令的清单。 |
| `-P4` | 启用Perforce支持。 |
| `-Submit` | 允许自动化进程提交文件。 |
| `-NoCompile` | 禁止AutomationTool在启动时编译任何 `.Automation.csproj` 文件。 |

如果设置此选项，可使用下列环境变量来配置对于构建机器的Perforce支持。它们可以通过AutomationTool命令行按 `VARNAME=VALUE` 语法设置，也可以从当前会话继承。

| 环境变量 | 说明 |
| --- | --- |
| `uebp_PORT` | Perforce服务器和端口（例如 `perforce:1666`）。 |
| `uebp_CLIENT_ROOT` | 到当前客户端的本地根目录的路径（例如 `D:\\P4`）。 |
| `uebp_CL` | 同步到的当前变更列表。 |
| `uebp_CodeCL` | 同步到的当前代码变更列表。它可以在 `uebpCL` 指定的当前变更列表之前。 |
| `uebp_USER` | Perforce用户。 |
| `uebp_CLIENT` | 用于访问Perforce的客户端的名称。 |
| `uebp_BuildRoot_P4` | 到当前分支或流送的根的路径（例如 `//UE4/Release-4.22`）。 |

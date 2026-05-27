---
title: "运行自动化测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/run-automation-tests-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "运行自动化测试"]
---

# 运行自动化测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / 运行自动化测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/run-automation-tests-in-unreal-engine

## 通过编辑器界面运行测试

1. 打开你的项目。
2. 启用

   功能测试编辑器（Functional Testing Editor）

   以及其他所有内含需运行测试的插件。
3. 重启虚幻编辑器。
4. 在编辑器中找到

   工具（Tools） > 测试自动化（Test Automation）

   。
5. 找到

   会话前端（Sessions Frontend）

   测试（Test）

   栏中的

   自动化（Automation）

   选项卡，选择要运行的测试。勾选父级复选框即可运行整个分段的测试。如需细化选择，请展开各分段进行选择。
6. 找到工具栏上的

   自动化（Automation）

   选项卡，点击

   开始测试（Start Tests）

   按钮。

你可以在 **测试（Test）** 面板中监控测试的进程和结果。选择测试行，**结果（Results）** 面板就会显示事件。使用 **屏幕对比（Screen Comparison）** 选项卡即可获取屏幕截图对比结果。

### 通过会话前端运行测试

测试默认从编辑器实例运行。不过会话前端还可以连接到额外编辑器和客户端实例。这对网络测试尤为实用。

连接前，额外实例必须正在运行。使用快速启动功能即可做到这一点。

实例运行后，你可以从会话前端左侧面板的 **我的会话（My Sessions）** 中选择实例。测试列表将更新该实例的兼容测试。

> [!TIP]
> 你可以将测试设置为仅限客户端，使其在编辑器实例上不可用。

## 通过虚幻前端运行测试

你可以将客户端测试作为独立应用程序从[虚幻前端 (UFE)](../../../sharing-and-releasing-projects/packaging-and-cooking/using-the-unreal-frontend-tool/index.md)启动。如果你想在没有编辑器的情况下在远程控制台上编译、打包和部署，这将非常有用。

**自动化（Automation）** 选项卡中的界面与编辑器的相同。

## 通过命令行运行测试

使用编辑器或客户端可执行文件的参数即可通过命令行运行自动化测试。示例如下：

- -ExecCmds="Automation RunTest Test1+Test2;Quit"

  - 运行

  Test1

  和

  Test2

  然后关闭可执行文件。
- -ExecCmds="Automation RunTest MySet.MySubSet;Quit"

  - 运行

  MySet.MySubSet

  分段下的所有测试。
- -ExecCmds="Automation RunTest Group:MyGroup;Quit"

  - 运行

  MyGroup

  组中筛选出的所有测试。关于测试组的详情，请参阅

  配置自动化测试

  。
- -ReportExportPath="<output path>"

  - 将结果与相关HTML文件一起以JSON格式存储。关于HTML报告的详情，请参阅

  设置自动化测试报告服务器

  。
- -ResumeRunTest

  - 当和

  -ReportExportPath

  一起使用时，读取JSON文件并从第一个标记为未运行的测试恢复测试。正在进行的测试将被标记为失败。这有助于在出现严重故障时恢复测试。

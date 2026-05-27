---
title: "蓝图编辑器工具栏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/toolbar-in-the-blueprints-visual-scripting-editor-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面组件", "蓝图编辑器工具栏"]
---

# 蓝图编辑器工具栏

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面组件 / 蓝图编辑器工具栏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/toolbar-in-the-blueprints-visual-scripting-editor-for-unreal-engine

**工具栏** 默认显示在蓝图编辑器的左上方。通过蓝图编辑器工具栏按钮可轻松访问编辑蓝图时所需的常用命令。工具栏上的按钮根据开启的模式和当前编辑的蓝图类型而有所不同。

工具栏包含两个部分：

- **工具栏选项** - 用于处理蓝图的工具。
- **模式按钮** - 可用于切换蓝图所处模式的按钮。

## 工具栏按钮

| 按钮 | 说明 |
| --- | --- |
| Compile Successful Button | 编译成功。单击此按钮可编译进行编辑的蓝图。编译过程的输出显示在消息日志的蓝图日志中。此按钮在调试过程中不可用。 |
| Compile Needed Button | 须对 *蓝图* 进行重新编译。单击此按钮可编译进行编辑的蓝图。编译过程的输出显示在消息日志的蓝图日志中。此按钮在调试过程中不可用。 |
| Compile Warning Button | 编译过程中出现警告。单击此按钮可编译进行编辑的蓝图。编译过程的输出显示在消息日志的蓝图日志中。此按钮在调试过程中不可用。 |
| Compile Failed Button | 编译失败。单击此按钮可编译进行编辑的蓝图。编译过程的输出显示在消息日志的蓝图日志中。此按钮在调试过程中不可用。 |
| Save Button | 保存当前蓝图。 |
| Find in Content Browser Button | 呼出 **内容浏览器** 并导航到此资源。 |
| Search Button | 查找当前蓝图中对函数、事件、变量和引脚的引用。 |
| Blueprint Properties Button | 打开 **详情（Details）** 面板中的蓝图属性。 |
| Blueprint Properties Button | 显示详情（Details）选项卡中的类默认值（Class Defaults）面板 |
| Simulate Button | 以模拟模式启动游戏。请参阅[在编辑器中模拟](../../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#%E5%9C%A8%E7%BC%96%E8%BE%91%E5%99%A8%E4%B8%AD%E6%A8%A1%E6%8B%9F)部分以了解更多信息。 |
| Play In Editor Button | 以正常播放模式启动游戏。单击此箭头可显示 **运行选项（Play Options）** 菜单。请参阅[在编辑器中运行](../../../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#%E5%9C%A8%E7%BC%96%E8%BE%91%E5%99%A8%E4%B8%AD%E8%BF%90%E8%A1%8C)部分以了解更多信息。 |
| Pause Button | 暂停模拟。模拟暂停后，工具栏上将出现 **继续（Resume）** 和 **帧跳跃（Frame Skip）** 按钮。 |
| Resume Button | 命中断点或按下Pause按钮后继续执行。 |
| Frame Skip Button | 前进一帧或一个tick。模拟暂停或命中断点时出现此按钮。 |
| Stop Button | 停止游戏执行并退出在编辑器中模拟模式。 |
| Possess Button | 从在编辑器中模拟模式切换到在编辑器中运行模式。附加到玩家控制器，实现普通游戏功能按钮。与 **Eject** 进行切换。 |
| Eject Button | 从在编辑器中运行模式切换到在编辑器中模拟模式。从玩家控制器解绑，实现普通游戏功能按钮。与 **Possess** 进行切换。 |
| Step Button | 一次一个节点逐步执行图表。模拟时命中断点后出现此按钮。 |
| Debug Dropdown | 如关卡中拥有一个或多个 *蓝图* 实例，可通过此下拉菜单选择进行调试的实例。 |

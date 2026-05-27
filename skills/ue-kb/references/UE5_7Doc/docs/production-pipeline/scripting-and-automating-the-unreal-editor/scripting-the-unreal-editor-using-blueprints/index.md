---
title: "使用蓝图编写编辑器脚本"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/scripting-the-unreal-editor-using-blueprints"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "使用蓝图编写编辑器脚本"]
---

# 使用蓝图编写编辑器脚本

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 使用蓝图编写编辑器脚本

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/scripting-the-unreal-editor-using-blueprints

蓝图可以为项目创建运行时Gameplay，还可以用于开发与项目内容交互的操作和工具。你可以在编辑器中按需运行蓝图图表，以处理资产，在关卡中布局内容，在编辑器用户界面UI中触发操作，或使用自定义UI面板扩展编辑器。

本页将介绍使用蓝图进行虚幻编辑器脚本编写和自动化的相关基础知识。

## 在编辑器中运行蓝图的选项

你可以使用一些技巧来设置和触发蓝图代码。

### 编辑器工具控件

编辑器工具控件是UMG控件，可在编辑器UI内的其他所有工具所用的同种可停靠面板中渲染此类控件。此方法最适用于打造功能丰富的UI来控制蓝图。可将UMG所有显示风格选项，与蓝图丰富的脚本编写控制结合使用。这是最灵活和最强大的选项，同时入门简单，推荐用于多数编辑器脚本编写工作。

欲了解创建编辑器工具控件并在编辑器中打开的方法详情，参阅[编辑器工具控件](editor-utility-widgets/index.md).


- [编辑器工具控件](editor-utility-widgets/index.md)

### 编辑器工具蓝图

编辑器工具蓝图是一种特殊类，专门用于符合以下条件的逻辑：仅在虚幻编辑器中运行，不在运行时运行，且无需自定义UI。

这些类的一个内置用例是支持 *脚本化操作*。脚本化操作即在关卡中右键点击Actor或在内容浏览器中右键点击资源时，在快捷菜单中触发的图表。

欲了解详情，请参阅[脚本化操作](scripted-actions/index.md)。


- [脚本化操作](scripted-actions/index.md)

### 在编辑器中调用

在蓝图类中创建自定义事件或函数时，可在编辑器中将该事件或函数标记为可调用。若将该蓝图类的实例放置在关卡中并选中，可在 **细节（Details）** 面板中触发自定义事件或函数。此方法最适用于需同时在运行时和蓝图中处理蓝图。

欲了解详情，请参阅[在编辑器中调用蓝图](calling-blueprints-in-the-unreal-editor/index.md)。


- [在编辑器中调用蓝图](calling-blueprints-in-the-unreal-editor/index.md)

### 启动对象

可将项目中的特定编辑器工具控件类和编辑器工具蓝图类辨识为启动对象。编辑器加载项目时将自动创建各启动对象的实例并调用预定义函数。此选项适用于加载项目后利用蓝图类固定执行某些操作，或将蓝图逻辑固定绑定到编辑器中处理项目内容时发生的事件。

欲了解详情，请参阅[在编辑器启动时运行蓝图](running-blueprints-at-unreal-editor-startup/index.md)。


- [在编辑器启动时执行蓝图](running-blueprints-at-unreal-editor-startup/index.md)

## 访问纯编辑器蓝图节点

在允许时，涉及修改资源文件或使用虚幻编辑器UI的多数操作无法在游戏中运行。因此，只能在同为纯编辑器的蓝图类中访问此类纯编辑器功能，即在模块中定义且类型设为 `编辑器` 的函数。

例如，若利用派生自可在运行时使用的父类（如基础 **Actor** 类）的蓝图类，蓝图编辑器的 **编辑器脚本编写（Editor Scripting）** 类别下将列出有限的函数集。但若创建派生自纯编辑器父类的编辑器工具蓝图、编辑器工具控件或普通蓝图类，将显示更多、更全面的可用函数集：

|  |  |
| --- | --- |
| Actor类的编辑器脚本编写节点 | Editor Scripting nodes for the EditorUtilityActor class |
| Actor类 | EditorUtilityActor类 |

> [!TIP]
> 若已安装编辑器脚本编写插件，可在此处找到该插件公开函数，用于使用静态网格和其他资源类型。参阅[编辑器脚本编写和自动化](../index.md)。

## 编辑器工具子系统

启动时，虚幻编辑器将初始化专门用于管理编辑器脚本编写功能行为的子系统。例如，此子系统处理生成和清理如[启动对象](running-blueprints-at-unreal-editor-startup/index.md)等操作，并处理[编辑器工具控件](editor-utility-widgets/index.md)的新编辑器面板的创建和销毁。

你也可以在自己的C++或蓝图代码中使用编辑器工具子系统。例如，可获取编辑器工具子系统，并调用其 `SpawnAndRegisterTab()` 方法，以在编辑器UI中程序化打开新面板，此面板包含项目中编辑器工具控件类的实例。

欲了解子系统及在C++、蓝图和Python中访问和使用的方法详情，参阅[编程子系统](../../../cpp-programming/programming-in-the-unreal-engine-architecture/programming-subsystems/index.md)。

## 可脚本化工具系统

**可脚本化工具（Scriptable Tools）** 系统提供了创建自定义交互式工具所需的函数和编辑器模式。可脚本化工具插件向蓝图公开了 **交互式工具框架（Interactive Tools Framework）**，为创作者和技术美术提供了设计工具的方法。

更多详情，请参阅[可脚本化工具系统](scriptable-tools-system/index.md)。


- [可脚本化工具系统](scriptable-tools-system/index.md)

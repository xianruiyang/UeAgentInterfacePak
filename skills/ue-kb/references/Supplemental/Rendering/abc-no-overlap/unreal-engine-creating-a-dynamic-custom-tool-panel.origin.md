# 创建动态自定义工具面板

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 4206 字符。

## 摘要

该项目展示了使用编辑器实用程序小部件和 D...的组合以动态程序方式生成有用的工具选项板的能力。

## 中文整理

### 概览



### 介绍

编辑器实用程序小部件需要一些项目来实现。 - 结构 结构 - 数据表 数据表 - 编辑器实用程序小部件 编辑器实用程序小部件 - 构建工具 构建工具

### 结构

结构基本上是数据表中数据类型的概述。类似于可将数据放入哪些字段。它们在结构布局中有名称和数据类型。

### 数据表

数据表使用结构作为可以添加数据的基础，并且每个项目都包含基础结构的所有元素。这与其他关系数据库设置类似。需要注意的一件事是数据表是只读的，不能动态编辑。可以设计一些解决方法，但本教程中未进行演示。

### 编辑器实用工具小部件

编辑器实用程序小部件是在编辑器模式下执行蓝图的 GUI。这些不是游戏内界面，而是为游戏开发方面提供更多功能而不是游戏玩法。 EUW 可以包含各种按钮、滑块、图像和基于文本的数据。这使得它们对于构建工具以提高项目开发周期的效率非常有用。



### 构建工具

这 3 个组件在创建各种不同的艺术家和开发人员工具以及程序员方面非常强大。在本教程中，我们将探索如何将这些元素组合在一起创建一个带有按钮的工具选项板，这些按钮可以执行存储在数据表中的 python 脚本。那么，让我们开始吧。

### 设置结构

要做的第一件事是在内容浏览器中右键单击并选择 Blueprints->Structure 在结构编辑器中添加变量和类型。在本例中，有 ToolName（字符串）、ToolIcon（Texture2D）和 ToolScript（字符串）。



### 创建数据表

创建结构后，就可以创建数据表并添加数据行。请注意，数据表还允许通过 csv 格式的文件从外部电子表格导入数据。



### 设置动态工具按钮

为了填充工具架调色板，我们必须创建一个按钮作为所有要生成的按钮的模板。在内容浏览器中，右键单击并选择编辑器实用程序 -> 编辑器实用程序小部件。在此示例中，有一个文本元素、一个按钮和一个图标图像，全部设置在一个 Vertical Box 容器内。每个动态元素都需要设置为变量，并绑定到结构。要绑定元素，必须在类型结构图中创建结构变量。在本例中，变量 ItemDetails 设置为结构体，该结构体的名称为 S_ToolBar，这是我们之前创建的结构体，可以在列表中轻松找到。在参数详细信息中，每个元素的绑定可以通过下拉菜单连接到结构。在图中，事件构造事件允许动态构建按钮时正确填充元素。该图中另一件重要的事情是 OnClicked 事件，它使用“Call Tool Cmnd”调度程序与主工具选项板小部件进行通信，并使用行名称作为按钮 ID。







### 定制工具架

在内容浏览器中右键单击，创建一个新的编辑器实用程序小部件。在设计器中，设置中需要一些组件。首先，加载按钮将用于使用最新的数据表条目刷新面板。下面是一个滚动框，其中包含一个 UniformGridPanel，它被设计为动态填充并在详细信息中设置为变量。完整的小部件图。单击“加载工具栏”按钮时，将运行“自定义工具架”图表，从数据表中收集数据，并使用总行数作为要生成的按钮数。对于每个工具按钮，都会调用 Create EUW ToolBtn 2 Widget 函数，并使用当前索引号提供按钮 ID 变量。该图的下一部分将“按钮单击事件”绑定到“工具命令”，这允许将每个按钮与按钮 ID 相关联，从而确定数据表的哪一行，然后将其拆分为每一列，然后执行该按钮 ID 的 Python 命令。 - 引擎中的动画教程：如何制作角色选择器 - 编辑器实用工具小组件的虚幻引擎文档 - 虚拟制作





## 相关链接

- [Unreal Engine Documentation for Editor Utility Widgets](https://docs.unrealengine.com/4.26/en-US/InteractiveExperiences/UMG/UserGuide/EditorUtilityWidgets)
- [Introduction](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#introduction)
- [Structure](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#structure)
- [Data Table](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#datatable)
- [Editor Utility Widget](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#editorutilitywidget)
- [Building The Tool](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#buildingthetool)
- [Set Up The Structure](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#setupthestructure)
- [Create the DataTable](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#createthedatatable)
- [Setting up the Dynamic Tool Button](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#settingupthedynamictoolbutton)
- [The Custom Tool Shelf](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#thecustomtoolshelf)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/2Rrx/unreal-engine-creating-a-dynamic-custom-tool-panel#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)


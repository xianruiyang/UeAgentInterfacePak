---
title: "蓝图编辑器菜单"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/menu-for-the-blueprints-visual-scripting-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面组件", "蓝图编辑器菜单"]
---

# 蓝图编辑器菜单

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面组件 / 蓝图编辑器菜单

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/menu-for-the-blueprints-visual-scripting-editor-in-unreal-engine

默认情况下，**菜单** 显示在蓝图编辑器左上角。

### 文件

| 命令 | 说明 |
| --- | --- |
| **加载并保存（Load and Save）** |  |
| **保存（Save）** | 保存蓝图。 |
| **打开资源...（Open Asset...）** | 调出资源选取窗口。 |
| **全部保存（Save All）** | 保存所有未保存的关卡和资源。 |
| **选择要保存的文件...（Choose Files to Save...）** | 打开一个对话框，其中包含内容和关卡的保存选项。 |
| **连接到源控制...（Connect to Source Control...）** | 如果启用了源控制，打开一个对话框，其中包含内容和关卡的检入选项。 |
| **蓝图** |  |
| **编译（Compile）** | 编译蓝图。 |
| **刷新所有节点（Refresh All Nodes）** | 刷新图中的所有节点以将外部更改更新进去。 |
| **重设蓝图父代（Reparent Blueprint）** | 更改已打开蓝图的父代。 |
| **对比（Diff）** | 与先前修订对比。需要启用源控制。 |
| **开发者（Developer）** | 打开"开发者（Developer）"菜单，你可以在这里更改编译器设置，并像"图编辑器（Graph Editor）"一样重新编译模块。 |

### 编辑

| 命令 | 说明 |
| --- | --- |
| **历史记录** |  |
| **撤销（Undo）** | 撤销上一个操作。 |
| **恢复（Redo）** | 恢复上一个撤销的操作。 |
| **撤销历史（Undo History）** | 显示完整撤销历史。 |
| **搜索** |  |
| **搜索（Search）** | 在当前蓝图中查找对函数、事件、变量和引脚的引用。 |
| **在蓝图中查找（Find in Blueprints）** | 在所有蓝图中查找对函数、事件、变量和引脚的引用。 |
| **删除未使用的变量（Delete Unused Variables）** | 删除从不使用的任何变量。 |
| **配置** |  |
| **编辑器首选项（Editor Preferences）** | 打开编辑器的设置。 |
| **项目设置（Project Settings）** | 打开当前项目的设置。 |
| **插件（Plugins）** | 打开"插件浏览器（Plugin Browser）"选项卡。 |

### 资产

| 列 1 | 列 2 |
| --- | --- |
| **在内容浏览器中查找...（Find in Content Browser...）** | 调出 **内容浏览器（Content Browser）** 并导航到该资源。 |
| **引用查看器...（Reference Viewer...）** | 启动引用查看器以显示当前资源引用的对象和引用当前资源的对象。 |
| **尺寸贴图...（Size Map...）** | 显示一个交互式贴图，其中显示该资源及其引用的所有内容的近似大小。 |

### 视图

| 命令 | 说明 |
| --- | --- |
| **引脚可见性（Pin Visibility）** |  |
| **显示所有引脚（Show All Pins）** | 显示所有节点上的所有引脚。 |
| **隐藏未使用引脚（Hide Unused Pins）** | 隐藏没有连接也没有默认值的所有引脚。 |
| **隐藏未连接引脚（Hide Unconnected Pins）** | 隐藏没有连接的所有引脚。该选项将隐藏已在节点上直接设置的输入的输入引脚。 |
| **缩放** |  |
| **缩放到图范围（Zoom to Graph Extents）** | 让当前视图适应整个图形。 |
| **缩放到选择范围（Zoom to Selection）** | 让当前视图适应选择范围。 |

### 调试

| 命令 | 说明 |
| --- | --- |
| **断点** |  |
| **禁用所有断点（Disable All Breakpoints）** | 禁用当前蓝图或关卡蓝图的所有图形中的所有断点。 |
| **启用所有断点（Enable All Breakpoints）** | 启用当前蓝图或关卡蓝图的所有图形中的所有断点。 |
| **删除所有断点（Delete All Breakpoints）** | 移除当前蓝图或关卡蓝图的所有图形中的所有断点。 |
| **监测** |  |
| **删除所有监测值（Delete All Watches）** | 移除当前蓝图或关卡蓝图的所有图形中的所有监测值。 |

### 窗口

**蓝图编辑器** 中的 **窗口（Window）** 菜单有一个特定的子部分，用于显示特定于蓝图编辑器的选项卡。当蓝图编辑器处于 **默认（Defaults）** 和 **组件（Components）** 模式中时，并非所有选项卡都会出现在该菜单中。

| 命令 | 说明 |
| --- | --- |
| **工具栏（Toolbar）** | 显示工具栏（如果当前不可见）。 |
| **细节（Details）** | 显示[细节（Details）](../../../user-interface-reference-for-the-blue-73593f79/user-interface-components/details-panel-in-the-blueprints-visual-scriting-editor/index.md)窗格（如果当前不可见）。 |
| **调试（Debug）** | 显示 **调试（Debug）** 窗格（如果当前不可见）。 |
| **选用板（Palette）** | 显示[蓝图编辑器控制板](../palette-in-the-bleprints-visual-scripting-editor/index.md)窗格（如果当前不可见）。 |
| **我的蓝图（My Blueprint）** | 显示[蓝图编辑器"我的蓝图"面板](../../../user-interface-reference-for-the-bl-73593f79/user-interface-components/my-blueprint-panel-in-the-blueprints-visual-scr-706fb8aa/index.md)窗格（如果当前不可见）。 |
| **编译结果（Compiler Results）** | 显示 **编译结果（Compiler Results）** 窗格（如果当前不可见）。 |
| **查找结果（Find Results）** | 显示 **查找结果（Find Results）** 窗格（如果当前不可见）。 |
| **组件（Components）** | 显示 **组件（Components）** 面板（如果当前不可见）。 |
| **视口（Viewport）** | 显示 **预览视口（Preview Viewport）** 窗格（如果当前不可见）。 |
| **内容浏览器（Content Browser）** | 打开能够访问所有四个 **内容浏览器** 的子菜单。 |
| **开发者工具（Developer Tools）** | **蓝图调试程序（Blueprint Debugger）**：打开蓝图调试程序，其中显示当前在蓝图中连同所有检测值一起运行的命令"堆栈"。 **碰撞分析程序（Collision Analyzer）**：显示碰撞分析程序。 **调试工具（Debug Tools）**：显示"调试工具（Debug Tools）"面板，其中包含用于执行常用调试任务的一系列功能（重新加载纹理、显示纹理图集、伽玛校正等）。 **消息日志（Message Log）**：打开消息日志。这里将显示来自编辑器的错误或警告。 **输出日志（Output Log）**：打开输出日志。如果你使用"打印（Print）"来进行调试，则结果会显示在这里。 **视觉记录工具（Visual Logger）**：打开视觉记录工具。 **类查看器（Class Viewer）**：打开类查看器。 **设备管理器（Device Manager）**：打开设备管理器。 **设备描述（Device Profiles）**：打开"设备描述（Device Profiles）"选项卡。 **会话前端（Session Frontend）**：显示会话前端。请参阅[Unreal Frontend](../../../../sharing-and-releasing-projects/packaging-and-cooking/using-the-unreal-frontend-tool/index.md)文档以了解更多信息。 **控件反射器（Widget Reflector）**：打开控件反射器。这使你能够在编辑器界面中看到构成界面的各个Slate元素。 |
| **项目启动程序（Project Launcher）** | 显示项目启动程序（Project Launcher），让你能够在任何已设置妥当并连接的设备上运行你的项目。 |
| **插件（Plugins）** | 显示可供你加载/卸载插件的"插件（Plugin）"选项卡。 |
| **重设布局...（Reset Layout...）** | 重设整个虚幻引擎4编辑器的默认布局。这需要重新启动编辑器，但会重新打开当前项目。 |
| **保存布局（Save Layout）** | 保存当前界面布局。 |
| **启用全屏（Enable Fullscreen）** | 为主编辑器窗口启用全屏模式。 |

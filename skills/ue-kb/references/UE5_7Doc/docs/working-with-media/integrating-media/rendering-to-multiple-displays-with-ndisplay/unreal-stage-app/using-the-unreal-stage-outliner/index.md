---
title: "使用Unreal Stage大纲视图"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-outliner-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "使用Unreal Stage大纲视图"]
---

# 使用Unreal Stage大纲视图

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / 使用Unreal Stage大纲视图

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-outliner-in-unreal-engine

## 大纲视图

大纲视图可以随时选择性地显示，还能列出场景中的所有ICVFX内容，并显示当前选定的内容。

## 大纲视图工具

大纲视图菜单栏为管理ICVFX内容提供了如下工具。

### 筛选

与桌面端虚幻引擎的大纲视图一样，这里的内容列表也可以按类型进行筛选，帮助你轻松找到所需的Actor，尤其是在更大、更复杂的场景中。

同样可以通过"按条件搜索（search by）"来按名称搜索内容。

### 可视性

Unreal Stage的可视性按钮可开关"游戏中隐藏Actor（Actor Hidden in Game）"属性，从而对视图隐藏选定的内容。隐藏内容将不再通过LED体积的nDisplay可见，但仍可通过编辑器和应用程序进行进一步操作（例如在不干扰其他现场工作的情况下进行调整，或找到它以使其再次可见）。隐藏内容将在大纲视图中以斜体显示，将其与可见内容区分开来。

### 多选

你可以通过大纲视图开启或关闭多选模式。 开启时，选择内容会将其添加到选择项中并创建选择集，而不是将选择项从一个Actor更改为另一个Actor。

如果选择了可视性状态不同的多个内容（例如一个可见但另一个隐藏），Unreal Stage会将选择的内容视为可见。这意味着点击可视性按钮将隐藏LED体积内所有选定的Actor。

### 省略号菜单

- 省略号菜单中的其他实用操作如下：
- 聚焦到选中项（Focus Selected）
- 编辑器预览将被缩放和平移，以聚焦到选定的Actor。
- 复制选中项（Duplicate Selected）
- 删除选中项（Delete Selected）
- 重命名选中项（Rename Selected）

### 滑动操作

大纲视图中的Actor也可以进行左右滑动，以更快更轻松地访问关键操作：

- 向右滑动
- 切换可视性
- 向左滑动
- 删除选中项

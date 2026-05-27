---
title: "蓝图编辑器细节面板"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/details-panel-in-the-blueprints-visual-scriting-editor-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图编辑器参考", "蓝图用户界面组件", "蓝图编辑器细节面板"]
---

# 蓝图编辑器细节面板

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图编辑器参考 / 蓝图用户界面组件 / 蓝图编辑器细节面板

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/details-panel-in-the-blueprints-visual-scriting-editor-for-unreal-engine

**Details（细节）** 面板是一个情境关联的区域，使得可以在蓝图编辑器中编辑选中项的属性。它包含一个用于快速访问特定属性的搜索条，并且一般还会包含一个或多个可折叠的类目，用于组织其中所包含的属性。

**细节面板** 也是您处理很多蓝图编辑工作的地方，包括：

- 编辑

  蓝图变量

  的过程，包括修改名称、类型、及该变量是否是一个数组。
- 点击蓝图属性（Blueprint Props）按钮后，实现

  蓝图接口

  。
- 为

  蓝图函数

  添加输入和输出。
- 为选中的

  组件

  添加

  事件

  。

## 界面

1. Search Filter（搜索过滤器）

   - 输入您需要的属性的名称，这些属性就会显示在过滤器的下方。
2. Property Matrix（属性矩阵）

   - 打开属性矩阵面板，以电子表格的形式编辑可用的属性。
3. Visibility Filter（可见性过滤器）

   - 这允许您显示或隐藏已修改的属性或高级属性，以及合并或展开所有类目。
4. 可折叠类目（Collapsible Categories）

   - 用于给相关属性分组，可使用名称左边的白色小三角展开及折叠。

> [!NOTE]
> 所有这些区域都是情境关联的。当这些区域中的其中一个区域不适合当前选中的项时，那个区域将会消失。比如，对于很多蓝图节点来说，看到基本上是空白的细节面板是正常的。

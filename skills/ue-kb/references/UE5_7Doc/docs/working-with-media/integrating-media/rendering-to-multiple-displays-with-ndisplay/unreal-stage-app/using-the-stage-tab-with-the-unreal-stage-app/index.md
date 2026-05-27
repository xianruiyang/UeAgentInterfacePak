---
title: "使用Unreal Stage应用程序的舞台选项卡"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-stage-tab-with-the-unreal-stage-app-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "使用Unreal Stage应用程序的舞台选项卡"]
---

# 使用Unreal Stage应用程序的舞台选项卡

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / 使用Unreal Stage应用程序的舞台选项卡

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-stage-tab-with-the-unreal-stage-app-in-unreal-engine

## 编辑器预览

"舞台（Stage）"选项卡通过触碰式、交互式的ICVFX内容，在LED墙上显示nDisplay输出的实时预览。 这与虚幻引擎的nDisplay编辑器预览和桌面端的ICVFX编辑器中显示的预览相同。

### 视图选项

你可以通过下拉菜单开关nDisplay编辑器预览的视图。 视图有四个选项：

- 圆顶（Dome）

  - 针对带天花板的半球形LED体积最常用视图选项
- 正交（Orthographic）

  针对半球形舞台的另一种常用投影选项
- 透视（Perspective）

  - 通常最适用于平面LED墙的配置
- UV

  - LED体积的扁平化表示，可以更轻松地同时显示墙壁和天花板，并且需要为nDisplay配置网格体设置次级UV

### 寻路

你可以在预览中寻路以准确查看所需内容。 与预览的交互如下：

- 捏合缩放（Pinch Zoom）

  - 放大或缩小预览
- 单指（One Finger）

  - 滚动预览
- 双指（Two Fingers）

  - 平移预览

> 动图已省略：752db168fed7bd49d379c375d5baf33cc8218c17540d3a01ba3b169b1aebc958

## 内容控制

虚幻引擎ICVFX编辑器中可放置的ICVFX内容，也可以通过Unreal Stage进行放置：

- 发光板
- 标记
- 色彩校正窗口
- 色键卡
- 模板

### 放置Actor

使用右上角的"添加（Add）"按钮即可在默认位置（可以是在屏幕外）添加新内容。 按住"舞台（Stage）"选项卡中的特定位置，也可以在该位置精确添加内容。

### 定位和重新定位内容

可以使用单根手指按住对象直到选中，从而重新定位场景中放置的ICVFX内容。这时你就可以通过触碰将其自由拖动，并放置在想要的位置。

### 对象模式

对象模式（Object Mode）让你能对对象进行除放置之外的进一步修改。使用先前提过的按住操作，选择内容并切换到对象模式。在对象模式下，功能按钮将仅关注所选的内容，让你可以快速轻松地进行更改，而不会意外地修改场景中的其他内容。捏合缩放将缩放所选对象的大小。在对象模式下，你还可以快速重新定位所选的内容，方法是点击屏幕上的任意位置以将其抓取，然后将其拖动到所需位置。

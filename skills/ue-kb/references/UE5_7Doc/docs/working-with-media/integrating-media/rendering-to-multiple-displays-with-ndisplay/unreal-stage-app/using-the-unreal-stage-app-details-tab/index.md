---
title: "使用Unreal Stage应用程序的细节选项卡"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-app-details-tab-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "使用Unreal Stage应用程序的细节选项卡"]
---

# 使用Unreal Stage应用程序的细节选项卡

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / 使用Unreal Stage应用程序的细节选项卡

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-app-details-tab-in-unreal-engine

## 细节选项卡的属性

细节选项卡的可用属性与桌面端虚幻引擎场景中的对应属性一致，并会根据所选内容的类型而有所不同。

### 发光板和标记

针对发光板（Light Card）和标记（Flag），可用的属性如下：

- 颜色（Color）

  - RGB或HSV值。
- 方向（Orientation）：
- 遮罩（Mask）

  - 针对发光板切换圆形或方形遮罩
- X轴缩放和Y轴缩放（Scale X and Scale Y）

  - 与使用捏合缩放调整大小相比，滑块可以提供更精确的控制
- 经度和纬度（Latitude and Longitude）
- 经度（Longitude）

  - 与纯触碰相比，滑块可提供精确的放置和定位控制
- 旋转（Spin）

  - 与纯触碰相比，滑块可提供更精确的旋转控制
- 外观（Appearance）：

  - 温度（Temperature）
  - 色调（Tint）
  - 增益（Gain）
  - 不透明度（Opacity）
  - 羽化（Feathering）
  - 曝光（Exposure）

    - 曝光的控制由方便的按钮提供，包括四分之一档、半档和全档增量。

### * 颜色校正区域和窗口

颜色校正窗口的可用属性如下：

- 色彩分级（Color Grading）
- RGB或HSV值
- 色彩分级模式（Color Grading Modes）：

  - 全局（Global）
  - 阴影（Shadows）
  - 中间色调（Midtones）
  - 高光（Highlights）
- 色彩分级属性（每种模式均可用）：

  - 饱和度（Saturation）
  - 对比度（Contrast）
  - 伽马（Gamma）
  - 增益（Gain）
  - 偏移（Offset）
- 方向（Orientation）：

  - 遮罩（Mask）

    - 针对颜色校正窗口切换圆形或方形遮罩
  - X轴缩放和Y轴缩放（Scale X and Scale Y）**

    - 与捏合缩放相比，滑块可以提供更精细的控制，实现精确的大小调整
  - 经度和纬度（Latitude and Longitude）

    - 滑块可以提供更精细的控制，实现精确的放置和位置调整
  - 旋转（Spin）

    - 与纯触碰相比，滑块可以提供更精细的控制，实现精确的旋转。
  - 径向偏移（Radial Offset）

    沿nDisplay根Actor的原点轴将色彩校正窗口推离/拉离LED体积的演示。这适合用于对场景中处于某些内容之后但同时在其他内容之前（而不是在nDisplay可见场景中所有内容之前）的位置应用色彩分级。
- 外观（Appearance）：

  - 色温（Color Temperature）
  - 色调（Tint）
  - 强度（Intensity）
  - 向内（Inner）
  - 向外（Outer）
  - 衰减（Falloff）

****颜色校正区域（Color Correct Regions）** 不提供外观功能按钮，因为在Unreal Stage中不存在3D放置工具。 在该应用程序中只能修改色彩分级和外观属性。

### 预览缩略图

细节（Details）选项卡提供了预览缩略图，供用户边修改属性边在应用程序内预览视觉效果。 你可以将预览缩略图移动到Unreal Stage UI的任意角落或将其收起/最小化。

### 将属性设为具体的值

除滑块外，你还可以双击属性，使用弹出的输入对话框和键盘来修改属性并将其设为具体的值。

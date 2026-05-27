---
title: "使用Unreal Stage应用程序的色彩分级选项卡"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-app-color-grading-tab-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "使用Unreal Stage应用程序的色彩分级选项卡"]
---

# 使用Unreal Stage应用程序的色彩分级选项卡

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / 使用Unreal Stage应用程序的色彩分级选项卡

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-unreal-stage-app-color-grading-tab-in-unreal-engine

## 色彩分级

nDisplay的色彩分级（Color Grading）选项卡让你能够像在ICVFX编辑器中那样对整个nDisplay群集进行色彩分级操作。 你既可以对整个群集或单个视口进行色彩分级，也可以根据需求对任何ICVFX摄像机（复数）按节点粒度进行色彩分级。

## 大纲视图

在nDisplay色彩分级选项卡上，修改后的大纲视图将显示两个窗格，而非一个窗格：

- 色彩分级大纲视图

  - 此处将显示关卡中所有可进行色彩分级的内容，包括nDisplay根Actor和后期处理体积等。
  - ICVFX摄像机组件位于相应的nDisplay根Actor下方。选择根Actor即可对视口和摄像机进行色彩分级。
- 逐视口/逐节点的色彩分级

  - 逐视口（针对外视口）和逐节点（针对内视锥体）的色彩分级都可以在虚幻引擎中定义，并在此处显示为选项，从而对LED体积的特定区域（如天花板等）进行色彩分级。
  - 目前还无法在Unreal Stage中直接创建或修改逐视口和逐节点的配置，但我们计划在未来版本中加入此功能。

## 预览缩略图

色彩分级（Color Grading）选项卡提供了预览缩略图，供用户在修改属性时在应用程序内预览视觉效果。 你可以将预览缩略图移动到Unreal Stage UI的任意角落或将其收起/最小化。

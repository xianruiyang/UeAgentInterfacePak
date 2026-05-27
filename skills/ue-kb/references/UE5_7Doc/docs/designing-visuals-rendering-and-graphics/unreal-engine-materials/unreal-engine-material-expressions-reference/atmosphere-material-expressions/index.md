---
title: "大气表达式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/atmosphere-material-expressions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质表达式参考", "大气表达式"]
---

# 大气表达式

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质表达式参考 / 大气表达式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/atmosphere-material-expressions-in-unreal-engine

## AtmosphericFogColor

**AtmosphericFogColor（大气雾颜色）**材质表达式用来在全局空间中的任意位置，查询关卡的大气雾的当前颜色。如果没有向其输送全局位置，那么将使用相关像素的全局位置。这在您需要让材质逐渐融入远方的雾颜色时非常有用。

在以下示例中，使用 AtmosphericFogColor（大气雾颜色）节点来设置"底色"（Base Color），并且 World Position（全局位置）接收一个简单网络，该网络查询相对于摄像机位置而言始终位于对象后方 50,000 个单位处的位置。

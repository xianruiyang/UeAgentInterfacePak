---
title: "色彩校正区域"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/color-correct-regions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "颜色管理", "色彩校正区域"]
---

# 色彩校正区域

> 路径：虚幻引擎5.7文档 / 使用媒体 / 颜色管理 / 色彩校正区域

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/color-correct-regions-in-unreal-engine

借助 **色彩校正区域（Color Correction Regions）**，你可以调整并校正场景中环境和对象的色彩。例如，在ICVFX场景中，你可以用它校准现场实景和LED墙中场景之间的光照和阴影。

采用了色彩校正区域的场景，将球体体积中的引人注目的红色应用于环境。

看完此页面，你将熟悉如何向关卡添加色彩校正区域并修改其设置。

要为你的场景添加 **色彩校正区域**，执行以下步骤：

1. 在编辑器的主菜单中，选择 **编辑（Edit）> 插件（Plugins）**，打开 **插件（Plugins）** 窗口。
2. 在 **插件（Plugins）** 窗口中，在 **其他（Other）** 分段中找到 **色彩校正区域（Color Correct Regions）**。选中 **启用（Enabled）** 复选框，将 **色彩校正区域** 添加到项目中。
3. 重启引擎。
4. 在 **放置Actors（Place Actors）** 面板中，选择 **体积（Volumes）** 类别。
5. 将 **色彩校正区域** 资产拖到关卡中。
6. 在 **细节（Details）** 面板中修改以下设置，以便将色彩分级应用于关卡中的区域：

| 属性 | 说明 |
| --- | --- |
| 类型（Type） | 确定区域的形状。选项包括： 球体 盒体 圆柱体 椎体 |
| 优先级（Priority） | 当多个色彩校正区域重叠时，区域的优先级决定将区域的色彩分级应用于关卡的顺序。 |
| 强度（Intensity） | 控制色彩分级设置的强度。 |
| 内外区域（Inner and Outer） | 控制区域的衰减区域。 |
| 衰减（Falloff） | 使用内外区域（Inner and Outer）控制衰减强度和区域。 |
| 反转（Invert） | 如果选中，则将色彩分级应用于关卡中除内部区域之外的所有内容。 |
| 温度类型（Temperature Type） | 选择不同类型的色温控制选项。选项包括： **温度（Temperature，旧版）** 是CCR最初用来调整某片区域温度的方法，它采用最快的算法来实现，但结果可能无法与传统的色彩校正算法相比。 **白平衡（White Balance）** 是传统的温度控制选项。 **白平衡（White Balance）** 是传统的温度控制选项。 **色温（Color Temperature）** 是白平衡的反向处理（reverse）。 |
| 温度（Temperature） | 控制色彩温度。 |
| 色彩分级设置（Color Grading Settings） | 色彩分级设置，例如Gamma、高光、中间色调和阴影 |
| 启用（Enabled） | 如果未选中，则该区域在场景中将不可见。 |
| 排除模板（Exclude Stencil） | 如果未选中，则包含所有[自定义模板](../../../designing-visuals-rendering-and-graphics/post-process-effects/post-process-materials/index.md#customdepthstencil)的场景模板纹理将被忽视。 |

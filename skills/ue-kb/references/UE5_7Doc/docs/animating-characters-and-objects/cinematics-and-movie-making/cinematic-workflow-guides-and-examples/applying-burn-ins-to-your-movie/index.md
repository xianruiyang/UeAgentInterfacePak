---
title: "应用烧入内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/applying-burn-ins-to-your-movie-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "过场动画流程指南和示例", "应用烧入内容"]
---

# 应用烧入内容

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 过场动画流程指南和示例 / 应用烧入内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/applying-burn-ins-to-your-movie-in-unreal-engine

创建并渲染过场动画时，可能需要包含正在查看的场景信息的覆层，如镜头名称、日期，时间或帧信息。这些覆层被称为 **烧入内容**，将在渲染时被烧入影片中。这在真实的电影制作中为导演、剪辑师或查看片段的人士提供片段的相关信息（一些片段甚至带有版权信息的水印）。

利用 **Sequencer** 可将烧入内容应用到渲出的影片，此外还提供包含镜头总体信息的默认烧入选项。在此指南中，我们将学习如何在渲出过场动画时启用默认烧入选项。

> [!NOTE]
> 此指南中，我们使用 **蓝图第三人称模板（Blueprint Third Person Template）** 创建了一个小型过场动画范例。

## 步骤

1. 准备好渲染 **关卡序列** 后，在 **关卡序列** 中点击 **渲染影片** 按钮。
2. 在 **Render Movie Settings** 窗口中点击 **Show Advanced** 展开按钮。
3. 在 **Burn in Options** 下点击 **Burn in Class** 下拉菜单并选择 **DefaultBurnIn**。

   进行此操作后，即可定义烧入设置。
4. 沿用默认选项，点击 **Capture Movie**。

## 最终结果

影片采集完成后，进行播放时便会发现相似的覆层已应用到过场。默认烧入在画面上方居中显示关卡序列的名称和当前日期。当前镜头名称显示在画面上面居左位置（如未使用镜头，则显示关卡序列名称）。画面下方居中显示 Master 序列的时间和帧数，画面右下显示当前镜头的帧。

在 **Burn in Options** 中的 **Settings** 部分中即可对每个选项进行修改，显示自定义文本。此外，还可在默认烧入选项中添加水印或修改字体。

全屏或在 YouTube 上查看以上视频可更清晰地观察覆层。

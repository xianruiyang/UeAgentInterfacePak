# 在视口和PIE模式中转换颜色

---
title: "在视口和PIE模式中转换颜色"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/apply-color-conversion-to-the-level-viewport-and-play-in-editor-with-opencolorio-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "颜色管理", "OpenColorIO颜色管理", "在视口和PIE模式中转换颜色"]
---

# 在视口和PIE模式中转换颜色

> 路径：虚幻引擎5.7文档 / 使用媒体 / 颜色管理 / OpenColorIO颜色管理 / 在视口和PIE模式中转换颜色

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/apply-color-conversion-to-the-level-viewport-and-play-in-editor-with-opencolorio-in-unreal-engine

你可以通过调整 **视口视图模式（Viewport View Modes）** 直接对 **视口** 应用OCIO配置。你也可以通过创建和配置 **Create In-Game OpenColorIO Display Extension** 蓝图节点，对 **PIE模式（Play in Editor Mode）** 应用OCIO配置。

本文介绍了如何将 **OpenColorIO配置资产（OpenColorIO Configuration Asset）** 应用到视口，以及如何在PIE模式中将其应用到项目。

## 先决条件

你必须在项目中设置以下内容才能完成后续小节：

- 一个OpenColorIO配置资产。请参阅

  OpenColorIO快速入门

  了解创建此资产的步骤。

## 转换关卡视口的颜色

按照下列步骤，将颜色转换应用到关卡视口。

1. 在 **视口（Viewport）** 中，点击 **视图模式（View Modes）** 按钮以打开其下拉菜单。选择 **OCIO显示（OCIO Display）** 以打开 **显示配置（Display Configuration）** 设置。

   ![The Viewport color management display configuration menu](../../../../../assets/images/74/746c1230153ee4a53cfbb2d443b80a03ed01cf6d7835fe3aeb5a26ece8c76d78.jpg)
2. 在 **显示配置（Display Configuration）** 设置中，选择 **Select an OCIO Asset（选择OCIO资产）** ，然后选择 **OCIO配置资产**，以将其添加到视口视图设置。

   ![Select an OCIO configuration asset from the display configuration menu](../../../../../assets/images/d2/d2eefe8f71cbb1a7a1e5339daa74d75c639cb17f5539246011082c79dc854fad.jpg)
3. 以下两个设置是源颜色配置文件和颜色变化的目标文件。在此示例中，源颜色是 **Utility - Linear - sRGB**，目标是 **Output - sRGB Monitor**。

   ![An empty display configuration menu](../../../../../assets/images/84/84cb041a08cf2b4de4d048e67e1dd6ad9dff30f68e664a0db66ffc7bc3857f88.png)
4. 点击 **启用显示（Enable Display）** ，将OCIO颜色变换应用到视口。

   ![The display configuration menu after changing the settings](../../../../../assets/images/2f/2ffdbaffdc2b8bfac92bb72d5cd273737f08ac3be4d4a84a5ed627653db9ed2a.png)
5. 启用这些设置后，视口将禁用色调曲线（Tone Curve），并将颜色转换插入到渲染的后期处理阶段。此操作会在UE应用色调映射之后且在其他所有操作之前执行。

以下图像显示了视口的颜色将如何根据OpenColorIO配置发生变化。

> 图片已省略：禁用OpenColorIO

![启用OpenColorIO](../../../../../assets/images/01/010b1591be0f7c1d24f3ea1009efbffaa0f88135547720cead50827cef228b8c.jpg)

禁用OpenColorIO

启用OpenColorIO

在视口视图模式中启用/禁用OpenColorIO。

## 在游戏内视口中转换颜色

要在游戏内视口中转换颜色，必须向摄像机Actor的蓝图类添加一个 **Create In-Game OpenColorIO Display Extension** 蓝图节点，并将其与OCIO配置相连。

具体步骤如下：

1. 打开摄像机Actors的 **蓝图类**。如果没有附加到摄像机的现成蓝图类，也可以新建一个摄像机组件蓝图类。
2. 点击 **In Display Configuration** 引脚并拖出引线，然后新建一个 **OpenColor IODIsplay Configuration** 变量。或在 **我的蓝图（My Blueprint）** 选项卡中新建一个变量。

   ![The Blueprint editor window with the OpenColor IODisplay Configuration variable visible](../../../../../assets/images/09/090eeef30025ed6a2f44be71dd12c046ad36cba9fecc1a93c42a8661d25db49e.jpg)
3. 在 **细节** 面板中编辑此变量，方法是添加 **OCIO配置资产**，并调整其他设置以匹配所需的颜色配置。

   ![The Blueprint editor showing a completed Blueprint](../../../../../assets/images/5e/5e5be3ede126155f30e64d2f5fca5b6ee5d67ef9f49fad5f45e443333d3f91af.jpg)
4. 新建一个 **Create In-Game OpenColorIO Display Extension** 节点，将其附加到 **EventBeginPlay** 节点，此时OCIO配置变量应如下图所示。
5. **编译（Compile）** 并 **保存（Save）** 蓝图。
6. 在 **关卡编辑器视口** 中点击 **运行**，在PIE模式中打开项目以测试蓝图。


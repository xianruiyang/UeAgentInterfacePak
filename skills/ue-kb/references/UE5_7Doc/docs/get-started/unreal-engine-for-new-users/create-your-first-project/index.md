---
title: "创建首个虚幻项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/create-your-first-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "创建首个虚幻项目"]
---

# 创建首个虚幻项目

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 创建首个虚幻项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/create-your-first-project-in-unreal-engine

在本指南中，你将学习如何启动已安装的虚幻引擎版本、创建新项目、使用现有项目模板，以及如何从Fab下载和安装内容。

## 启动虚幻引擎

下载并[安装虚幻引擎](../../install/index.md)后，与该版本关联的引擎图块将显示**启动（Launch）**按钮。 点击启动按钮即可打开引擎并显示**虚幻项目浏览器（Unreal Project Browser）**窗口。 你可以在此窗口中新建项目或打开设备上的现有项目。

或者，你可以双击**我的工程（My Projects）**分段下的项目图块，从而直接打开现有项目。 这样就能使用与其关联的虚幻引擎版本打开该项目。

## 虚幻项目浏览器

启动虚幻引擎时会打开**虚幻项目浏览器（Unreal Project Browser）**窗口。 此窗口将列出**最近打开的项目（Recent Projects）**以及四个主要类别（**游戏（Games）**、**影视与现场活动（Film / Video & Live Events）**、**汽车、产品设计和制造（Automotive Product Design & Manufacturing）**以及**模拟（Simulation）**）的专门模板。

项目浏览器被分为以下分段：

| 编号 | 名称 | 说明 |
| --- | --- | --- |
| 1 | 最近打开的项目和模板类别 | 这是用于筛选可用模板的类别列表。 |
| 2 | 所选类别的模板 | 这是所选类别中可用的模板的列表。 |
| 3 | 项目默认设置 | 更改这些设置即可设置项目的默认项。 可以进行以下选择：**蓝图（Blueprints）或C++**可用于选择是使用**蓝图可视化脚本**还是**C++**来创建项目。 无论做出何种选择，你都仍然可以向项目添加蓝图和C++代码。 **目****标平台（Target Platform）**可用于选择编译项目所面向的平台。**质量预设（Quality Preset）**可用于选择项目的视觉保真度。 **最大（Maximum）**选项将开启高端功能，而**可伸缩（Scalable）**选项会平衡视觉保真度以优化性能。 所有设置在项目创建后依然可切换。启用初学者内容包（Starter Content）即可使用一个额外的内容包，其中包含带有材质和纹理的简单可放置网格体。 你也可以在创建项目后再添加初学者内容包。 如需了解相关信息，请参阅[初学者内容包](https://dev.epicgames.com/documentation/unreal-engine/starter-content-in-unreal-engine?application_version=5.1)页面。这些选项在**最近打开的项目（Recent Projects）**分段下不可用，因为项目默认设置仅与新项目相关。 |
| 4 | 项目创建菜单 | 这些设置将指定**项目位置（Project Location）**和**项目名称（Project Name）**。 |

## 使用第一人称模板创建项目

游戏（Games）类别下有以下模板：

| 模板名称 |  |
| --- | --- |
| 空白（Blank） | 此模板会创建一个没有额外Gameplay功能的空项目。 |
| 第一人称（First Person） | 此模板主打第一人称角色蓝图。 它附带了射击游戏和恐怖游戏两种变体，以展示这些游戏类型常见的功能。 |
| 第三人称 | 此模板主打第三人称角色蓝图。 它附带了平台跳跃游戏和战斗游戏两种变体，以展示这些流行的第三人称游戏类型的典型功能。 |
| 俯视角 | 此模板主打角色的俯视视角。 它附带了策略游戏和双摇杆射击游戏两种变体。 |
| 手持式AR应用（Handheld AR） | 此模板展示了手持式增强现实项目中常见的功能。 |
| 虚拟现实 | 此模板展示了虚拟现实项目中常见的功能。 |
| 载具 | 此模板附带一辆可驾驶的载具。 它附带了计时赛和越野赛两种变体。 |

对于此示例， 请选择**第一人称（First Person）**模板。 在项目默认设置中选择**蓝图（Blueprint）**，然后输入项目位置和名称。 点击**创建（Create）**即可新建项目。

虚幻引擎打开项目后，你会看到**虚幻引擎关卡编辑器**在默认模板关卡中打开。 请阅读[虚幻编辑器界面](../unreal-editor-interface/index.md)文档，以详细了解该编辑器。

你可以使用**鼠标右键（RMB）**并和**W**、**A**、**S**和**D**键来在关卡中导航。 如需详细了解关卡导航，请参阅[视口功能按钮](../viewport-controls/index.md)页面。

项目目前以高视觉保真度运行。 在处理资源密集型关卡时，你可以点击 **性能和可伸缩性（Performance and Scalability）** > **视口可伸缩性（Viewport Scalability）**并选择较低级的**可伸缩性组（Scalability Group）**（如低或中）来降低视觉保真度。

如需详细了解可伸缩性选项，请参阅可伸缩性参考页面。

## 从Fab下载内容

Fab是一个商城，你可以在其中找到各种内容，包括3D模型、材质、纹理、声音文件等等。 你还可以下载由Epic Games创建的免费示例项目。

在此示例中，你需要从Fab下载**Stack O Bot**示例项目。

前往[Fab](http://www.fab.com/)并搜索Stack O Bot以进入产品页面。

在产品页面上，点击**添加到我的库（Add to My Library）**，即可将示例项目添加到你的Fab库中。 返回Epic Games启动器，然后转到**虚幻引擎（Unreal Engine） > 库（Library） > Fab库（Fab Library）**。 点击**刷新**按钮即可刷新Fab库中的内容列表。 现在你应该能看到Stack O Bot示例。

> [!NOTE]
> 如果你在创建Epic Games账户后未在网站上登录Fab，那么Fab会要求你先登录，然后你才能向库中添加内容。

如需详细了解如何使用模板创建项目，请参阅[项目和模板](../../../understanding-the-basics/working-with-projects-and-templates/index.md)页面。

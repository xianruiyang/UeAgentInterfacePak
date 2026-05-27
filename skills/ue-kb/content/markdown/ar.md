# 设置新的AR项目

---
title: "设置新的AR项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-new-ar-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR开发入门", "设置新的AR项目"]
---

# 设置新的AR项目

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR开发入门 / 设置新的AR项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-new-ar-project-in-unreal-engine

本指南介绍如何在虚幻引擎中创建新的空白项目，并添加必要的蓝图和配置，将其转变成AR体验。

> [!TIP]
> 如果要使用已设置的AR项目进行启动，请参阅下面的AR模板：
>
> - [适用于iOS和Android的手持类AR项目模板](../../developing-for-handheld-augmented-reality-experiences/handheld-ar-template-quickstart/index.md)

按照以下步骤创建新的虚幻引擎项目和关卡，并启用最少的渲染功能。 空白项目将会打开，其中带有默认关卡，包含天空球体和大气雾对象。 这些对象将持久地覆盖AR中的所有内容，因此在创建AR体验时启动空白关卡将很有用，可以控制将显示哪些内容。

1. 从[Epic Games启动器](https://www.epicgames.com/store/en-US/download)启动**虚幻引擎**。
2. 在**虚幻项目浏览器**窗口中，选择**游戏（Games）**。

   ![在虚幻项目浏览器中选择游戏](../../../../../assets/images/2a/2a2c03cf07b1f88e56ab81d435d84d045c29ef7fd0701f7db36ddbdc39470354.jpg)

   点击查看大图。
3. 选择**空白模板（Blank Template）**。

   ![选择空白模板](../../../../../assets/images/2b/2bddf0ca9d440de7b83138b6a59cd75a0d621eb2caf7e6a41dcc62cc526a081a.jpg)

   点击查看大图。
4. 对于**项目默认值**，选择以下各项：

   - 蓝图
   - 可扩展（Scalable）
   - 禁用光线追踪（Raytracing Disabled）
   - 移动端
   - 无初学者内容包（No Start Content）

     ![选择项目默认设置（Choose Project Defaults）](../../../../../assets/images/5e/5e5560159a1a152f557546a95c54e8d3cfa3c3da119b6c7d3f9f2c67fd989095.jpg)

     点击查看大图。
5. 在主菜单中，选择**编辑（Edit） > 插件（Plugins）**，然后在**插件（Plugins）**窗口中，搜索并启用**AR Utilities**插件。 点击**立即重启**，然后等待虚幻引擎重启。

   ![启用AR Utilities插件](../../../../../assets/images/00/00d693fdf9d1764ec7e18861ef07b7abe2d6624807a7c73ae33648c98e4f86a9.jpg)
6. 在编辑器中，选择**文件（File） > 新关卡…（New Level…）**，然后选择**空白关卡（Empty Level）**。 命名关卡之后保存。 在此示例中，关卡名为**Main**。

   ![选择空白关卡](../../../../../assets/images/49/49053c626c7dc4ccf1e44af0f7254aeb5d3d48957a8f02dfdf5e77c95669d427.jpg)
7. 在主导航中，选择**编辑（Edit）> 项目设置（Project Settings）。**
8. 在项目设置（Project Settings）窗口中，在**项目（Project）**部分下选择**地图和模式（Maps & Modes）**。 将**编辑器启动地图（Editor Startup Map）**和**游戏默认地图（Game Default Map）**设置为新关卡**Main。**

   ![项目设置地图和模式](../../../../../assets/images/db/dbf444b49ef876824eb9ebf37d60304cd20b0a9ece825841e26334d8b6877801.jpg)

   点击查看大图。

## 添加Pawn和游戏模式

在虚幻引擎中，[pawn](../../../../gameplay-systems/gameplay-framework/pawn/index.md)是用户的物理呈现，将定义用户如何与世界交互。 [游戏模式](../../../../gameplay-systems/gameplay-framework/game-mode-and-game-state/index.md) 对象会定义体验的规则，例如要使用哪个pawn 对象。 为了构建新的AR项目，你需要设置Pawn， 以便在运行应用时与环境交互。

按照下面的步骤进行操作，为你的AR项目创建Pawn和游戏模式。

1. 在**内容浏览器（Content Browser）**中单击右键，从列表中选择**蓝图类（Blueprint Class）**。 在**选择父类（Pick Parent Class）**窗口中，选择**Pawn**。 将资产命名为**ARPawn**。

   ![选择蓝图类](../../../../../assets/images/3e/3ecb2c687f8b87aaf3efbea75292f5f8928f44fb6c79019fa31857e3684bcc31.jpg)

   ![选择Actor作为父类](../../../../../assets/images/ce/cee3296ddf24f6aaf25b96d8bca05b7125036985f93021a657ed81767f57cdfb.jpg)
2. 双击**内容浏览器（Content Drawer）**中的**ARPawn**对象，在**蓝图编辑器（Blueprint Editor）**中将其打开。 在蓝图编辑器中，选择**添加组件（Add Component）**并搜索**摄像机（Camera）**。

   > 图片已省略：添加摄像机组件
3. 确保**Camera**组件的父项是**DefaultSceneRoot**。

   > 图片已省略：确保DefaultSceneRoot是摄像机组件的父节点
4. 在**内容浏览器（Content Browser）**中单击右键，从列表中选择**蓝图类（Blueprint Class）**。 在**选择父类（Pick Parent Class）**窗口中，选择**游戏模式基础（Game Mode Base）**。 将资产命名为**ARGameMode**。

   > 图片已省略：选择Game Mode Base作为父类
5. 双击**ARGameMode**以编辑设置。 将**默认Pawn类（Default Pawn Class）**设置为**ARPawn**。

   > 图片已省略：将默认Pawn类设置为ARPawn

   点击查看大图。
6. 在主导航中，选择**编辑（Edit）>项目设置（Project Settings）**以打开**项目设置（Project Settings）**窗口。
7. 在左侧**项目（Project）**部分下的**项目设置（Project Settings）**窗口中，选择**地图和模式（Maps & Modes）**。

   1. 将**默认游戏模式（Default GameMode）**设置为**ARGameMode**。
   2. 将**默认Pawn类（Default Pawn Class）**设置为**ARPawn**。

   > 图片已省略：设置默认游戏模式和默认Pawn类

   点击查看大图。

## 创建AR会话

函数**Start AR Session**需要ARSessionConfig对象，该对象会定义项目的所有AR特定功能。 如需详细了解每个设置分别是什么，请参见[UARSessionConfig](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/AugmentedReality/UARSessionConfig?application_version=5.6)。

按照下面的步骤将AR会话逻辑添加到你的项目。

1. 右键点击**内容侧滑菜单（Content Drawer）**。 选择**杂项（Miscellaneous）> 数据资产（Data Asset）**，打开**选择数据资产类（Pick Data Asset Class）**窗口。

   > 图片已省略：选择数据资产
2. 在**选择数据资产类（Pick Data Asset Class）**窗口中，选择**ARSessionConfig**。 将数据资产命名为**ARSessionConfig**。 打开资产，选择**保存（Save）**以确认默认AR选项。

   > 图片已省略：选择ARSessionConfig作为数据资产实例
3. 双击**ARPawn**资产，在**蓝图编辑器（Blueprint Editor）**中打开。 添加函数**Set Tracking Origin**。 将**Origin**值设置为**Floor Level**。

   > 图片已省略：将Tracking Origin节点值设置为Floor Level
4. 添加函数**Start AR Session**。 将**Session Config**资产设置为**ARSessionConfig**。

   > 图片已省略：Start AR Session节点值设置为ARSessionConfig
5. 添加函数**Stop AR Session**。

   > 图片已省略：添加Stop AR Session节点

在你的设备上启动项目时，现在可以 在你的AR环境中导航。 请参阅AR平台的文档 ，了解如何在你的设备上启动虚幻项目的详细步骤。

## 自行尝试

在本指南中，你学习了如何创建新的AR项目，以及如何添加必要的蓝图以开始构建AR应用。


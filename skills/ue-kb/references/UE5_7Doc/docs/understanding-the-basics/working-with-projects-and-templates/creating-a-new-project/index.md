---
title: "新建项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-a-new-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "使用项目和模板", "新建项目"]
---

# 新建项目

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 使用项目和模板 / 新建项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-a-new-project-in-unreal-engine

当你启动 **虚幻引擎** 时， **虚幻项目浏览器（Unreal Project Browser）** 会自动打开。你可以在此处：

- 新建项目。
- 打开现有项目。
- 管理现有项目。

下图说明了在虚幻引擎中新建项目的步骤。

![在虚幻引擎中新建项目](../../../../assets/images/5f/5fa0b3a8618e8c5efd68749efb9aee16c2f0618b9c28ff077761b266e087f062.jpg)

在虚幻引擎中，从 项目浏览器（Project Browser） 窗口新建项目。

要新建项目，请按照以下步骤操作：

1. 选择最符合你的行业和项目目标的 **开发类别** （1）。

   你可以从以下类别中进行选择：

   - 游戏
   - 电影、电视和直播活动
   - 建筑、工程和施工（AEC）
   - 汽车、产品设计和制造（APM）
2. 为你的项目选择 **模板** （2）。你可以选择的模板基于你在步骤1中选择的类别。

   > [!TIP]
   > 虚幻引擎包含许多 **项目模板**，你可以将其用作自己项目的起始点。要了解有关可用的不同项目模板的更多信息，请参阅[模板参考](../template-reference/index.md)页面。
3. 配置 **项目默认值（Project Defaults）** （3）。在此分段中，你可以选择目标平台（即运行游戏或应用程序的硬件，如计算机或移动设备）、配置质量和光线追踪设置等。

   > [!NOTE]
   > 以下某些设置可能不适用于某些模板。例如，手持式AR模板只能使用蓝图实现。

   你可以配置以下设置：

   | 设置 | 说明 |
   | --- | --- |
   | **实现（Implementation）** | 选择你要如何实现项目的逻辑，例如角色移动、关卡过渡等。 你可以选择以下选项： **蓝图（Blueprint）** ，如果你要在虚幻编辑器中构建项目，并使用蓝图视觉效果脚本（Blueprint Visual Scripting）系统来创建交互和行为。 **C++** ，如果你要通过在Visual Studio中使用C++编程来构建你的项目。 有关实现方法的更多信息，请参阅以下页面： [蓝图视觉效果脚本](../../../blueprints-visual-scripting/index.md) [使用C++编程](../../../gameplay-systems/programming-with-cpp/index.md) |
   | **目标平台（Target Platform）** | 选择你的项目适用的平台类型： **桌面（Desktop）** **移动端（Mobile）** |
   | **质量预设（Quality Preset）** | 根据你的项目目标平台，选择最高质量级别。我们建议你选择： **最大值（Maximum）** ，如果你正在为计算机或游戏主机开发项目。 **可扩展（Scalable）** ，如果你正在为移动设备开发项目。 |
   | **初学者内容包（Starter Content）** | 选择你是否希望新项目包含 **初学者内容包** 。初学者内容包包括一些带有基本纹理和材质的简单静态网格体。如果你想立即开始学习和试验，这将非常有用，且无需为获取和导入自定义内容担心。 |
   | **光线追踪（Ray Tracing）** | 为你的项目选择是启用还是禁用 **光线追踪**。 关于虚幻引擎中光线追踪的更多信息，请参阅[实时光线追踪](../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/index.md)页面。 |
4. 选择你要存储项目的位置，并为项目命名（4）。
5. 点击 **创建（Create）** （5），完成项目新建。

## 结果

虚幻引擎使用你配置的设置新建项目，然后自动打开该项目。

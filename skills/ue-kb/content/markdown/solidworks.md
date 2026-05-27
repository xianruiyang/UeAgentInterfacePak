# Solidworks

---
title: "Solidworks"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-solidworks-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Solidworks"]
---

# Solidworks

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Solidworks

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-solidworks-in-unreal-engine

本页面介绍如何安装Datasmith Solidworks导出器插件，如何使用Datasmith将Solidworks内容导入虚幻引擎中，以及Datasmith如何将场景从Solidworks导入到虚幻引擎中。

## 下载和安装Solidworks导出器插件

要使用Datasmith导出Solidworks内容，请从[Datasmith导出插件](https://www.unrealengine.com/zh-CN/datasmith/plugins)页面下载并安装 **Solidworks导出器** 插件。

确保下载的插件适用于你计划使用的虚幻引擎版本。

要查看该插件支持的Solidworks版本，请参阅。

### 安装Solidworks导出器插件

安装Solidworks导出器插件之前：

- 卸载计算机上安装的旧版插件。
- 确保Solidworks未在计算机上运行。

要安装该插件，请打开安装程序并按照说明操作。

> [!NOTE]
> 如果插件安装程序在你的计算机上检测到多个版本的Solidworks，并且其中至少一个版本受支持，它将为检测到的所有Solidworks版本安装导出插件。

### 卸载Solidworks导出器插件

要卸载该插件，请在Windows **控制面板** 中找到它，然后像删除其他Windows应用程序那样将其删除。

## 适用于Solidworks的Datasmith工作流程

你可以通过以下方式将Solidworks内容导入虚幻引擎中：

- 将Solidworks场景导出为

  .udatasmith

  文件，然后将其导入虚幻引擎中。
- 使用Direct Link在虚幻引擎中实时预览Solidworks场景的更改。

### 从Solidworks导出内容

要将Solidworks内容导出为 `.udatasmith` 文件，你需要执行以下操作：

1. 安装

   Solidworks导出器

   插件

   。
2. 在Solidworks中，加载你想导出的场景。
3. 从主工具栏，打开"保存（Save）"菜单（软盘图标），然后选择"另存为（Save As）"。

   ![Solidworks中的](../../../../../assets/images/a4/a43bf840050188e123789dc45a7ef65fedb291f87626408f4ca6aabdf33063a0.jpg)
4. 在

   另存为（Save As）

   窗口中，将

   保存为类型（Save as type）

   设为

   Unreal (

   *.udatasmith

   )

   。

Datasmith会将你的场景另存为 `.udatasmith` 文件，你可以将其导入虚幻引擎中。如需详细信息，请参阅[将Datasmith内容导入到虚幻引擎中](../../datasmith-tutorials/importing-datasmith-content-into/index.md)。

> [!TIP]
> 如果你需要在导入过程中对Solidworks数据执行更多清理、合并或其他修改，你可以使用Dataprep。如需详细信息，请参阅[Dataprep导入自定义](../../dataprep-import-customization/index.md)。

### 使用Direct Link预览Solidworks内容

你不必在每次更改时都手动将Solidworks场景重新导入虚幻引擎中，而可以在Solidworks和虚幻引擎之间设置Datasmith DirectLink，以实时预览场景更改。设置Direct Link后，每当你在Solidworks中更改场景时，虚幻引擎预览都会更新。

如需更多信息，请参阅[使用Datasmith Direct Link](../../datasmith-tutorials/using-datasmith-direct-link/index.md)。

在Solidworks中，Datasmith Direct Link在主工具栏的"虚幻（Unreal）"选项卡中可用。

![Datasmith tools in Solidworks](../../../../../assets/images/56/561c6012add16c2131f04a6b81177e38c54562d7b4cc78320a2ddc9b11008700.png)

> [!NOTE]
> 你必须[安装 **Solidworks导出器** 插件](#%E5%AE%89%E8%A3%85solidworks%E5%AF%BC%E5%87%BA%E5%99%A8%E6%8F%92%E4%BB%B6)才能在Solidworks中访问Datasmith功能，包括DirectLink。

## Datasmith如何从Solidworks导入内容

本小节介绍了当你使用Datasmith将Solidworks中的对象转换并导入为虚幻引擎项目中的元素时会发生什么。Datasmith遵循[Datasmith概述](../../datasmith-plugins-overview/index.md)和[关于Datasmith导入过程](../../datasmith-import-process/index.md)中概括的过程，但增加了与Solidworks相关的一些特殊转译操作。

### Solidworks功能支持

Datasmith Solidworks导出器支持以下功能：

- 产品结构
- 立体几何
- 纹理和材质
- 显示状态
- 配置
- 元数据

**不** 支持以下功能。

- 动画
- 光源
- 摄像机
- 构造几何：点、曲线、平面

### 转换的实体

当你将 `.udatasmith` 文件导入虚幻引擎时，Datasmith会将以下Solidworks实体转换为其虚幻引擎对应物：

| Solidworks | 虚幻引擎 |
| --- | --- |
| 子组件 | Actor |
| 部件 | 静态网格体 |
| 部件实例 | 静态网格体（Actor） |
| 配置 | 变体 |
| 显示状态 | 变体 |
| 外观 | 材质 |

### Solidworks数据加载模型

当你打开组件文件时，Solidworks可以将其激活组件加载为 **轻量级** 或 **完全解析** 。根据选定的模式，来自模型的数据可能在Solidworks中可用或不可用。

我们建议以 **完全解析** 模式打开组件，确保通过Datasmith传输最多的信息。 请参阅有关[组件](http://help.solidworks.com/2021/english/SolidWorks/sldworks/c_lightweight_components_swassy.htm)的文档，了解更多信息。

### 材质和UV

Solidworks没有与部件关联的UV的数据。与虚幻引擎不同，Solidworks会存储每个材质的映射信息。将数据导出到 `.udatasmith` 文件时，Datasmith导出程序会使用材质信息将UV烘焙到静态网格体中。因此，如果部件在Solidworks组件中多次实例化，并且每个部件实例使用不同的材质，则最终虚幻引擎中可能会有多个静态网格体。

### 配置和显示状态

如果Solidworks模型具有显示状态或配置，Datasmith可能会创建关卡变体集资产。此资产将保留已转译的变体实体。 请参阅有关[配置](http://help.solidworks.com/2021/english/SolidWorks/sldworks/c_Configurations_Overview.htm)的Solidworks文档，了解更多信息。

### 元数据

当你导入SolidWorks文件时，Datasmith会向它创建的每个静态网格体Actor添加极少量的预设元数据，用于表示原始SolidWorks设计民中该网格体的部分名称和组件。Datasmith目前不会将你添加的自定义元数据属性结转到你的部分和组件。


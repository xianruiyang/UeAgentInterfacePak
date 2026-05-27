---
title: "3ds Max"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-3ds-max-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "3ds Max"]
---

# 3ds Max

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / 3ds Max

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-3ds-max-in-unreal-engine

本页面简单介绍了Datasmith 3ds Max导出器插件，及其安装方法。

![V-Ray in 3ds Max](../../../../../assets/images/49/499259802a768c1003e93737cefb91fce076ac1eea2d11b93e5a63f9b06057d0.jpg)

V-Ray in 3ds Max

Unreal Engine

图片由Litrix提供。

## 3ds Max工作流程

使用Datasmith将3ds Max内容导入 **虚幻引擎** 的方法如下：

- 导出

  .udatasmith

  文件

  ：将3ds Max内容导出为

  .udatasmith

  文件，并将这些文件导入虚幻引擎。 更多详情请参阅

  从3ds Max导出Datasmith文件

  。
- 设置Direct Link

  ：在3ds Max实例与虚幻引擎（或其他基于虚幻引擎的应用程序）实例间建立实时连接，然后自动或按需将3ds Max内容推送到虚幻引擎。 更多详情请参阅

  使用Direct Link同步3ds Max和虚幻引擎

  。

关于Datasmith如何为虚幻引擎转换3ds Max内容，详见[Datasmith如何转换3ds Max内容](how-datasmith-translates-3ds-max-content/index.md)。

## 为3ds Max安装Datasmith导出器插件

在同步或导出3ds Max内容前，你必须从[Datasmith 导出器插件页面](https://www.unrealengine.com/en-US/datasmith/plugins)下载 **Datasmith 3ds Max导出器插件** 并进行安装。

要查看插件支持哪些版本的Autodesk 3ds Max，请查看[Datasmith支持的软件和文件类型](https://dev.epicgames.com/documentation/404)。

### 预安装检查表

在安装Datasmith 3ds Max导出器插件前，你需要：

- 关闭所有运行中的3ds Max实例。
- 下载与你要使用的虚幻引擎版本匹配的导出器插件安装程序。
- 卸载之前安装过的所有旧版Datasmith 3ds Max导出器插件。

### 安装或移除插件

下载安装程序后，将其打开，按屏幕提示操作。

如果你要卸载Datasmith 3ds Max导出器插件，可以在 **控制面板** 中操作，和其他Windows应用程序一样。

## 为Datasmith配置虚幻引擎项目

要将 `.udatasmith` 文件导入虚幻引擎，或将3ds Max场景同步到虚幻引擎，你的项目必须启用Datasmith导入器插件。如果你不启用该插件，将无法再虚幻引擎中看到Datasmith选项。

> [!TIP]
> 如果你的项目使用的是建筑业模版，将默认启用Datasmith导入器插件。

### 启用Datasmith导入器插件

1. 在虚幻引擎中打开插件窗口：在主菜单中选择

   编辑（Edit）> 插件（Plugins）

   。
2. 在左边窗格中选择

   内置（BUILT-IN）> 导入器（Importer）

   类别。
3. 在右边窗格中，启用

   Datasmith导入器（Datasmith Importer）

   插件。

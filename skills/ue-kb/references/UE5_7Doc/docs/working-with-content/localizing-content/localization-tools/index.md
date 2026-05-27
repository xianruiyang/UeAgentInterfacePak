---
title: "本地化工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/localization-tools-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "本地化", "本地化工具"]
---

# 本地化工具

> 路径：虚幻引擎5.7文档 / 管理内容 / 本地化 / 本地化工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/localization-tools-in-unreal-engine

## 本地化控制板

**虚幻引擎(UE)** 中的 **本地化控制板**是一个负责管理本地化目标的工具。虽然它仍是实验性的，但它运行稳定，供我们的所有项目在内部使用。它是用来管理 **本地化目标** 的推荐方法，可以通过编辑器中的 **工具（Tools）** 菜单来访问。

在默认情况下，控制板将为您创建一个 **游戏（Game）** 本地化目标，除非您的项目特别复杂，否则这可能是您需要的惟一本地化目标。您可以使用 **收集文本（Gather Text）** 设置来指定可以在何处找到源代码和资源，还可以使用 **文化（Cultures）** 设置来指定要本地化项目的语言。这包括将您的 **原生（Native）** 文化设置为编写内容所用的语言。

> [!NOTE]
> 如果添加了一个新的本地化目标，请确保为它指定了适当的加载策略（通常为 **游戏（Game）**）。如果没有这样做，将不会在运行时加载该本地化目标。

设置好本地化目标后，您可以使用 **文化（Cultures）** 部分下的工具栏来 **收集（Gather）**、**导出（Export）**、**导入（Import）**，并 **编译（Compile）** 项目文本。随着时间的推移，当有新的翻译或者添加了新的原文本时，该过程可以迭代运行。

一旦执行了这些操作，您将在"Config/Localization"文件夹中找到一些INI文件。每次使用控制板执行这些操作时都会生成这些文件，不需要将它们提交给源代码控制，除非您计划[自动执行本地化](#%E8%87%AA%E5%8A%A8%E6%89%A7%E8%A1%8C%E6%9C%AC%E5%9C%B0%E5%8C%96)管道。

> [!NOTE]
> 目前，本地化控制板和本地化命令行（构成本地化管道）对于本地化目标有两种完全不同的配置布局（其中本地化控制板生成命令行版本）。

## 翻译编辑器

可以通过本地化控制板访问 **翻译编辑器**。它提供了一种检查文本片段翻译的简单方法。它在用户界面中提供了三个翻译选项卡：

- **未翻译（Untranslated）**：没有相关翻译的文本。
- **需要审阅（Needs Review）**：之前已针对旧版源文本翻译过的文本。
- **已完成（Completed）**：已针对当前版本的源文本翻译过的文本。

翻译编辑器是一个不经常更新的简单工具，可能缺少您想要用于全面翻译工作的功能（例如它没有翻译记忆库）。因此，我们建议您只使用翻译编辑器来进行现场修复。我们建议您不要使用翻译编辑器，而是使用PO导出/导入管道，并将其与外部翻译工具（例如[Poedit](https://poedit.net/)、[OneSky](https://www.oneskyapp.com/)或[XLOC](http://www.xloc.com/)）结合使用来完成一般性的翻译工作。

## 翻译选取器

**翻译选取器** 是一个不经常更新的实验性工具。该工具允许您从UI中使用的文本值查询信息，包括使用 **在编辑器中运行(PIE)** 时。

通过单击 **编辑器偏好设置（Editor Preferences）> 实验性（Experimental）**，启用翻译选取器。一旦启用，可以通过编辑器中的 **窗口（Window）** 菜单访问。

当翻译选取器处于活动状态时，它将在光标附近显示一个浮动窗口，在光标下列出控件使用的所有文本值。一旦找到要检查的文本值，可以按ESC键将选取器锁定到该选择项。

可本地化文本（即有身份且已被收集和编译成LocRes文件的文本）将显示一个内联可编辑文本字段，可用于现场选修复当前翻译。

> [!NOTE]
> 内联编辑翻译的能力在虚幻引擎4.13-4.21版本中受到了损坏，但在虚幻引擎4.22版本中得到了修复。

## 自动执行本地化

通过使用 **虚幻自动工具（Unreal Automation Tool）** (UAT)的Localize脚本，可以实现本地化自动化。该脚本提供了一种方法来运行本地化管道的各个部分，您可以使用它为您的产品生成夜间本地化更新，以及与外部本地化提供方进行接口。该脚本目前是硬编码的，用于Win64开发编辑器版本。

> [!NOTE]
> 在虚幻引擎4.22版本之前：
>
> - 该脚本被命名为 **Localise**。此名称仍作为别名存在。
> - "OneSky"是"LocalizationProvider"参数的默认值。如果未使用本地化提供方，则必须将该参数设置为空字符串。

在没有外部本地化提供方的情况下，对源内构建（虚幻引擎根文件夹内的项目），基本调用如下：

```
	Localize-UEProjectDirectory="YourProject"-UEProjectName="YourProject"-LocalizationProjectNames="TargetName" 
```

在没有外部本地化提供方的情况下，对源外构建（UE根文件夹以外的项目），基本调用如下：

```
	Localize-UEProjectRoot="Path/To/Project"-UEProjectDirectory=""-UEProjectName="YourProject"-LocalizationProjectNames="TargetName" 
```

与外部本地化提供方接口涉及创建一个派生自"LocalizationProvider"的类。默认情况下，我们提供两个本地化提供方：OneSky和XLOC。

| 本地化提供方 | 实现信息 |
| --- | --- |
| **OneSky** | 由"OneSkyLocalizationProvider"实现。 创建一个派生自"OneSkyConfigData"的类，以包含配置数据，并将配置的名称传递给"-OneSkyConfigName"参数以选择正确的配置。 将OneSky组的名称传递给"-OneSkyProjectGroupName"参数。 传递"-LocalizationProvider=OneSky"以使用OneSky本地化提供方。 |
| **XLOC** | 由"XLocLocalizationProvider"实现。 创建一个派生自"XLocLocalizationProvider"的类，并用配置数据填充"Config"变量。 覆盖"StaticGetLocalizationProviderId"和"GetLocalizationProviderId"以返回配置的名称，并将此名称传递给"-LocalizationProvider"参数以选择正确的配置。 |

---
title: "将Cascade转换为Niagara的转换插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cascade-to-niagara-effects-converter-plugin-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara入门介绍", "将Cascade转换为Niagara的转换插件"]
---

# 将Cascade转换为Niagara的转换插件

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara入门介绍 / 将Cascade转换为Niagara的转换插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cascade-to-niagara-effects-converter-plugin-for-unreal-engine

## Cascade到Niagara转换器插件

**Cascade到Niagara转换器** 插件是一个实用程序，旨在转换 **Cascade粒子系统** 资产。 该插件包括一个蓝图函数库，用于以编程方式生成Niagara发射器和Niagara系统资产，以及Python脚本层，用于将Cascade系统转换为新的Niagara系统。

> [!NOTE]
> 对于希望将现有内容从Cascade转换为Niagara的用户而言，此插件是理想之选。此插件作为一个起始点，升级到虚幻引擎使用的最新工具，并将继续更新，直到未来引擎版本弃用和删除Cascade。

## 启用Cascade到Niagara转换器插件

如果要为你的项目启用Cascade到Niagara转换器插件，请执行以下步骤。

1. 导航至主菜单中的 **编辑（Edit） > 插件（Plugins）**，打开 **插件浏览器（Plugins Browser）** 选项卡。
2. 从 **内置（Built-In）** 类别侧菜单中，导航至 **FX > Cascade到Niagara转换器（Cascade To Niagara Converter）** 插件，然后启用该插件。
3. 出现提示时，点击 **立即重启（Restart Now）**，使更改生效。

## 使用Cascade到Niagara转换器插件

在 **内容浏览器** 中右键点击级联粒子，然后从上下文菜单中选择 **转换到Niagara系统（Convert to Niagara System）**， 将所需的 **级联粒子系统** 转换为 **Niagara系统**。

*在上面的示例中，我们使用了初学者内容包文件夹中的级联粒子系统 P_Steam_Lit。

在源Cascade系统所在目录下创建新的Niagara系统，后缀为 `_Converted`。

新生成的Niagara系统会创建转换报告，你可以通过打开新的Niagara系统并查看 **Niagara日志（Niagara Log）** 窗口来查看该报告。 要检查转换后的Niagara系统，建议在编辑器中打开资产，并解决转换报告中可能包含的任何警告或错误。

Niagara日志提供警告：它已跳过转换布尔值 bApplyGlobalSpawnRateScale。

## 错误和警告类型

在转换Cascade系统assimplegalleryagara系统资产后，你可能会看到 **Niagara系统概述窗口** 中显示一些错误和警告。 将鼠标光标悬停在任一符号上都会显示任何可能产生冲突的问题的简短描述。

- – 指示 **错误** 的图标。
- – 表示 **警告** 的图标。

上图展示了两个错误的简要说明，表示粒子更新（Particle Update）字段中的依赖性未得到满足。

选择任一属性都会在界面右侧打开选择（Selection） **细节窗口**，使你能够观察到有关问题的更详细说明。根据问题的类型，可能会提供 **修复问题** 提示，帮助你自动解决问题。

|  |  |
| --- | --- |
| 错误 | 警告 |
| 选择（Selection）细节窗口显示了有关 `加速力` 和 `阻力` 模块的未满足依赖性错误的附加详细说明，以及有关如何纠正它们的建议。选择修复问题将导致插件调整模块堆栈组的顺序。 | 选择（Selection）细节窗口显示警告"未指定错误"，指示变量 `bApplyGlobalRateScale` 已在转换过程中跳过。 |

## Cascade到Niagara支持的转换操作

Cascade到Niagara转换器支持转换级联粒子系统的通用表示形式，但是，有些模块和属性并不完全受支持。下表列出了尚未得到支持或部分支持的项目。

| 功能 | 支持（是/否/部分） | 其他注意事项 |
| --- | --- | --- |
| 事件模块： |  |  |
| **事件生成器** | 否 |  |
| **EventReceiver杀死全部** | 否 |  |
| **EventReceiver生成** | 否 |  |
| 发射器到发射器模块 |  |  |
| **粒子吸引器** | 否 |  |
| **源运动** | 否 |  |
| **发射器初始位置** | 否 |  |
| **发射器直接位置** | 否 |  |
| **种子模块** | 否 |  |
| **光束和AnimTrail渲染器** | 否 |  |
| **条带渲染器** | 部分 | 条带UV不能保证等同于转换后的Niagara系统。 |
| **级联发射器LOD** | 部分 | 转换仅在LOD为0的所有模块上运行。 |

如果转换了具有不受支持模块或渲染器的级联粒子系统， 则生成的Niagara系统会将跳过的模块和/或渲染器转换记录在其消息日志中。

Niagara日志显示一条消息，指示在转换过程中跳过了哪些级联模块。

## 扩展Cascade到Niagara转换器插件的功能

该插件支持通过修改位于转换插件的Python目录中的python脚本来扩展转换功能，该目录位于： `Engine/Plugins/FX/CascadeToNiagaraConverter/Content/Python`。

适用于已在Cascade中创建自己的自定义模块、渲染器和属性的用户。通过从相对接口扩展并将新脚本添加到 `CascadeToNiagaraConverter/Content/Python` 下的相关目录中，可以为每个脚本创建新的转换器脚本。 例如，假如想要转换一个自定义模块，你可以在 `ModuleConversionScripts` 目录下新建一个脚本，然后从 `ModuleConverterInterface` 类派生出一个类。有关更多详细信息或示例，请参阅相关接口脚本的源代码。

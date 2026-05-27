---
title: "PCG Biome Glossary"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-glossary-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "程序化内容生成框架", "PCG群系", "PCG Biome Glossary"]
---

# PCG Biome Glossary

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 程序化内容生成框架 / PCG群系 / PCG Biome Glossary

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-pcg-biome-core-and-sample-plugins-glossary-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

PCG Biome Core 和 Sample 插件展示了如何使用 [PCG Framework](https://dev.epicgames.com/documentation/en-us/unreal-engine/procedural-content-generation-overview)。本页定义此项目文档中使用的许多术语。

组合体（PCG）

使用以下命令，从关卡中找到的所有静态网格体和实例化静态网格体创建并导出的 PCG 点数据： **资产操作 > 从关卡创建 PCG 资产**.

Biome

由 biome 定义和 biome 资产列表定义的空间体积。

Biome Actor

用于在 World 中设置 biome 的蓝图 Actor，包括 biome 体积、biome 样条和 biome 纹理。

Biome 资产

包含将由 Biome Core 生成的资产属性的数据资产。

Biome Core

一种数据驱动的 biome 创建工具，提供包含可自定义步骤的固定管线。PCG Biome Core 插件包含一组 PCG 图表和子图表，用于程序化生成 biome。

Biome Core Runtime

独立的 PCG 组件和图表，用于在运行时通过 GPU 生成相机周围的细节资产。

Biome Sample

PCG Biome Sample 插件包含关卡、数据资产和自定义 PCG 图表，用于展示如何使用 Biome Core 程序化生成 biome。

子点

递归变换步骤中创建的所有点，用于生成子资产。

筛选图表

处理点并从其逻辑或纹理投射写入已定义筛选属性的 PCG 图表。

筛选器

筛选图表列表。

生成器

一种数据资产，包含 **类型**, **优先级**和 **生成器图表** 属性，由 biome 资产条目引用。

生成器图表

一种 PCG 图表，会生成用于在 World 中放置资产的根点。

全局 Biome Core 图表

在 Biome Core BP Actor 上，PCG 组件会分配 Biome Core 图表。执行时，该图表会获取每个 Biome Actor 中所有本地 Biome Core 图表生成的数据。数据会经过按优先级差分的步骤，然后将剩余点生成为静态网格体、组合体或 Actor。

全局参数

全局 Biome Core 上影响其全局行为的图表参数，包括筛选图表和调试缓存显示。

分层生成

将体积和处理划分为多个不同尺寸的网格，PCG 图表的部分内容会在这些网格上执行。分层生成通过在不同网格尺寸上分配计算来加快本地更新，并将数据输出到可单独流送的独立 Actor。更多信息请参阅 [使用 PCG 生成模式](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-pcg-generation-modes-in-unreal-engine?application_version=5.5).

注入数据

在 Biome Core 的不同阶段注入的外部数据，用于排除或添加点。根据其在管线中的入口点，分为不同类型：排除项和自定义 biome 数据。

本地 Biome 缓存

为每个 biome Actor 本地计算的点数据，用作 biome 中生成器的边界形状。本地缓存还用于将 biome 定义应用到生成的点上。

本地 Biome Core 图表

每个 biome Actor 都有自己的 PCG 组件，并分配了本地 Biome Core 图表。本地 Biome Core 图表会按每个 biome Actor 本地生成全部数据。该本地生成输出随后会在全局 Biome Core 图表中使用。

本地参数

本地 Biome Core 中影响其本地行为的图表参数，包括预览模式、调试本地缓存显示和 biome 混合控制。分区 Biome Core 中影响全局行为的图表参数包括筛选图表和调试缓存显示。

根点

生成器及其图表提供的所有点。

运行时资产

包含将由 Biome Core runtime 生成的资产属性的数据资产。

运行时分层生成

运行时基于流送源或 PCG 生成源组件生成网格单元。使用 PCG 图表中为每种网格尺寸配置的生成半径。采用与分层生成相同的多级网格尺寸方法。更多信息请参阅 [使用 PCG 生成模式](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-pcg-generation-modes-in-unreal-engine?application_version=5.5).

变换图表

一种 PCG 图表，它接收来自生成器的点或父级变换点并修改其属性。用于生成和放置子点。

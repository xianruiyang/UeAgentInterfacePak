# 《堡垒之夜》中 HLOD 的生成方式总结

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/zeeb/unreal-engine-summary-of-how-hlods-are-generated-in-fortnite

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 5232 字符。

## 摘要

《堡垒之夜》中如何生成 HLOD 的摘要由 Alex K 撰写。每晚我们都会在所有子关卡上运行重建 HLOD 自动化脚本，这...

## 中文整理

### 概览

文章作者：Alex K.

- 每晚我们都会在所有子关卡上运行重建 HLOD 自动化脚本，这确保艺术家所做的任何更改都会合并到 HLOD 中。

从 4.20 开始，此脚本包含在此链接 RebuildHLODCommand.Automation.cs 中。

您必须登录具有虚幻引擎存储库访问权限的 Github 才能查看此文件。

它以最低限度构建 HLOD，因为我们要求艺术家在更改集群、未对资产进行任何更改（例如

纹理、静态网格物体等），则不会对子关卡进行任何工作。

然而，连续完整重建可能需要几个小时！

每晚，我们都会在所有子关卡上运行重建 HLOD 自动化脚本，这确保艺术家所做的任何更改都会合并到 HLOD 中。

从 4.20 开始，此脚本包含在此链接 RebuildHLODCommand.Automation.cs 中。

您必须登录具有虚幻引擎存储库访问权限的 Github 才能查看此文件。

它以最低限度构建 HLOD，因为我们要求艺术家在更改集群、未对资产进行任何更改（例如

纹理、静态网格物体等），则不会对子关卡进行任何工作。

然而，连续完整重建可能需要几个小时！

- 接下来，我们每晚在持久根图上运行自定义“HLOD Streaming Data”命令行开关（源自 ResavePackages），该根图运行在所有引用的子级别的“基础”参与者上，并提取对生成的 HLOD 静态网格物体（在 ALODActors 中）的引用。

然后它在持久映射中生成自定义代理参与者。

最终结果是持久地图包含所有 HLOD 代理网格，并以低细节表示整个世界。

Note that ‘foundation’ actors represent a hierarchy, i.e.

sublevels can also contain foundations, so we need to recursively load all these sublevels to extract HLOD meshes.

接下来，我们每晚在持久根映射上运行自定义的“HLOD Streaming Data”命令行开关（源自 ResavePackages），该根映射运行在所有引用的子级别的“基础”actor 上，并提取对生成的 HLOD 静态网格物体（在 ALODActors 中）的引用。

然后它在持久映射中生成自定义代理参与者。

最终结果是持久地图包含所有 HLOD 代理网格，并以低细节表示整个世界。

请注意，“基础”参与者代表一个层次结构，即

sublevels can also contain foundations, so we need to recursively load all these sublevels to extract HLOD meshes.

-“HLOD Streaming Data”命令行开关还更新了持久映射的世界设置中的结构，该结构将基础参与者（在持久映射和子级别中）映射到持久代理参与者的 TLazyObjectPtrs。

我们通过参与者的姓名和位置来唯一地识别基金会。

“HLOD Streaming Data”命令行开关还更新了持久映射的世界设置中的结构，该结构将基础参与者（在持久映射和子级别中）映射到持久代理参与者的 TLazyObjectPtrs。

We uniquely identify foundations by their actor name and their location.

- 在运行时，当根基础参与者变得与网络相关时，我们有逻辑来确定是否要在关卡中进行流式传输（当前到其边界框的距离，在“HLOD Streaming Data”命令行开关中重新计算）。

然后，我们发出流请求，当关卡流式传输时，我们将其相应的 HLOD actor 隐藏在持久映射中。

HLOD 网格仍然存在于新加载的子关卡中，因此可能会发生正常的 HLOD 过渡（例如抖动）。

当关卡流出时，我们执行相反的操作。**在运行时，当根基础参与者变得与网络相关时，我们有逻辑来确定是否要在关卡中进行流式传输（当前到其边界框的距离，在“HLOD Streaming Data”命令行开关中重新计算）。

然后，我们发出流请求，当关卡流式传输时，我们将其相应的 HLOD actor 隐藏在持久映射中。

HLOD 网格仍然存在于新加载的子关卡中，因此可能会发生正常的 HLOD 过渡（例如抖动）。

当关卡流出时，我们执行相反的操作。** 如果您想对任何子关卡使用非唯一内容，则实例化子关卡时可能会遇到许多问题。

我们发现我们需要为每个实例生成在客户端和服务器上稳定的特定唯一名称。

在我们的例子中，我们获取了子关卡的基础角色名称及其整数舍入位置（所有基础都被捕捉到 Fortnite 中的网格），并创建了该值的哈希值以附加到关卡的路径（移植到 /Temp/ 安装点）。

我们希望进一步开发该系统，使其成为所有引擎用户都可以用来创造大世界的功能。

该系统非常适合《堡垒之夜》的世界规模，但为了使其普遍适用，我们需要更深层次的 HLOD 代理，这些代理在持久地图中不会全部可见，目前该地图非常“平坦”。

我们还想考虑一个用于转换 LOD 的通用系统，例如跨级别 LODParentPrimitives 之类的潜力。

本文最初发表于 UDN。

- 虚幻引擎

## 相关链接

- [RebuildHLODCommand.Automation.cs](https://github.com/EpicGames/UnrealEngine/blob/release/Engine/Source/Programs/AutomationTool/Scripts/RebuildHLODCommand.Automation.cs)


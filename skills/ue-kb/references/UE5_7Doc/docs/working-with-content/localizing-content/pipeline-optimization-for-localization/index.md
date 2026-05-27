---
title: "管线优化"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pipeline-optimization-for-localization-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "本地化", "管线优化"]
---

# 管线优化

> 路径：虚幻引擎5.7文档 / 管理内容 / 本地化 / 管线优化

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pipeline-optimization-for-localization-in-unreal-engine

## 收集资产

资产收集是使用最多资源的本地化管线的一部分。这是因为本地化通常必须加载资产（及其依赖项）来提取其中包含的本地化文本值。为了最大限度减少收集期间实际需要加载的资产数量，**虚幻引擎(UE)** 在资产文件的标头中添加了一个"收集缓存"（在您保存时生成），这意味着只需要加载资产标头就可以收集文本。

转到 **内容浏览器** 中的 **资产本地化（Asset Localization）** 菜单并选择 **显示本地化缓存（Show Localization Cache）** 即可查看资产的当前缓存。

由于使用字节码，某些类型的资产（例如蓝图或具有非空白关卡蓝图的关卡）无法生成收集缓存。这是因为UE从字节码中收集文本值，但字节码太不稳定，无法在保存时可靠缓存。

在资产收集期间，由于字节码而未缓存的资产总数将打印到日志中。如果您发现您的资产收集花费了大部分时间从包含字节码的资产中收集，那么您可以考虑将这些资产中的文本移动到 **字符串表** 中，以便引用这些条目。

> [!NOTE]
> 在资产收集期间，只加载包含传递"FText::ShouldGatherForLocalization"的序列化文本值的资产。文化不变文本、空白文本、只包含空格的文本以及字符串表引用都无法通过此检查。这就是为什么使用字符串表可以提高资产收集性能。

## 验证资产缓存

有一些工具可用于帮助报告或修复项目中资产上陈旧和丢失的收集缓存。这些工具需要一段时间来运行，因为它们需要将所有资产加载到内存中。但是，如果您有大量未缓存的资产，他们可以大幅降低未来的开销。这些工具在正常的本地化Commandlet中作为额外参数运行。

**示例：**

```
	-run=GatherText-config=Config/Localization/Game_Gather.ini	-ReportStaleGatherCache 
```

> [!NOTE]
> 如果要从低于4.20的虚幻引擎版本升级项目，至少应该运行"ReportStaleGatherCache"来验证缓存是最新缓存，因为陈旧的缓存可能会导致本地化问题。

这些选项未在 **本地化控制板** 中公开。相反，您必须使用控制板为本地化目标生成的收集INI文件，并手动运行本地化Commandlet。

| 参数 | 说明 |
| --- | --- |
| `ReportStaleGatherCache` | 为本地化目标生成一个"StaleGatherCacheReport.txt"文件及清单。该文件包含所有包含陈旧收集缓存的资产的列表。 |
| `FixStaleGatherCache` | 尝试通过重新保存所有包含陈旧收集缓存的资产来自动修复。 |
| `FixMissingGatherCache` | 对于太旧而无法拥有收集缓存的资产，它尝试通过重新保存丢失收集缓存的资产来自动修复。 |

---
title: "文件日志记录分析服务商"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/file-logging-analytics-provider-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "游戏运行的性能分析", "文件日志记录分析服务商"]
---

# 文件日志记录分析服务商

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 游戏运行的性能分析 / 文件日志记录分析服务商

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/file-logging-analytics-provider-for-unreal-engine

此服务商可使用JSON格式将分析API调用写入到磁盘。使用此服务商是为了调试分析过程。它会将数据写入到 `Saved/Analytic` 文件夹，为每个文件指定以 `.analytics` 结尾的唯一名称。然后，你可以将此文件中保存的数据与分析服务商操作面板上的事件进行比较， 确保所有数据正在处理中。此服务商没有任何特殊的配置设置。

> [!NOTE]
> 此服务商会将每个会话的数据写入到磁盘，这将导致发布的游戏或应用中的数据日益增加。我们建议你仅将此服务商用于开发，不要将其包含在发布的产品中。

下图显示的是测试4.8 API添加时创建的文件。

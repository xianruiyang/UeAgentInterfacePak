---
title: "Zen存储服务器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/zen-storage-server-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Zen存储服务器"]
---

# Zen存储服务器

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Zen存储服务器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/zen-storage-server-for-unreal-engine

Zen存储服务器（Zenserver）通过以下方式支持任意规模的项目：

- 支持本地存储、共享存储或云存储
- 提供更快的暂存和部署
- 通过减少文件系统的开销来提高烘焙时间效率。

以下情况适合使用Zen流送：

- 在家庭或办公室等可信网络中。
- 使用非发布构建的配置（调试、开发、测试等）。
- 在Zenserver（工作站上）与目标平台（游戏主机或移动设备）之间的距离较短时。

如需详细了解如何实现这些目标，请参阅下方链接的页面。

- [将Zenserver作为共享DDC](set-up-zen-storage-server-as-shared-ddc/index.md) - 本指南介绍如何将虚幻Zen存储服务器设置为派生数据缓存（DDC）的共享存储服务器。

- [将Zenserver作为烘焙输出存储](using-zen-storage-server-as-cooked-output-store/index.md) - 本指南介绍如何将Zenserver作为烘焙输出存储

- [Zenserver流送](how-to-use-zenserver-streaming-to-play-on-target/index.md) - 使用Zen存储服务器将数据流送至目标设备。

- [Zenserver烘焙数据快照](cooked-data-snapshots-with-zen-storage-server/index.md) - 导出项目的烘焙输出，然后将其导入至目标位置。

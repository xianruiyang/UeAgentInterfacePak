---
title: "分层细节级别（HLOD）"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hierarchical-level-of-detail-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "分层细节级别（HLOD）"]
---

# 分层细节级别（HLOD）

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 分层细节级别（HLOD）

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hierarchical-level-of-detail-in-unreal-engine

虚幻引擎中的一个复杂关卡可以包含上百个细节丰富的静态网格体资产。对于这种程度的细节，一次加载方圆数公里的关卡会非常缓慢。

当模型处于远距离时，分层细节级别（HLOD）系统可以将多个静态网格体Actor合并成单个代理网格体和材质。这能减少场景中需要渲染的Actor数量，从而减少每帧的绘制调用数量，并提高性能。这在处理大型开放世界时特别有用。

- [构建HLOD网格体](building-hierarchical-level-of-detail-meshes/index.md) - 本文介绍了如何在启用HLOD的虚幻引擎5项目中生成HLOD网格体。

- [HLOD概述](hierarchical-level-of-detail-overview/index.md) - 介绍虚幻引擎4中的HLOD系统

- [分层细节级别大纲视图](hierarchical-level-of-detail-outliner/index.md) - HLOD大纲视图中的界面元素和属性的参考页面。

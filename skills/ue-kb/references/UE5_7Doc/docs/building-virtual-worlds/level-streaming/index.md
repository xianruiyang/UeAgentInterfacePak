---
title: "关卡流送"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/level-streaming-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡流送"]
---

# 关卡流送

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡流送

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/level-streaming-in-unreal-engine

关卡流送功能可以将地图文件加载到内存中，或者从内存中卸载，并在游戏过程中切换地图的可视性。 这样一来，场景便能拆分为较小的地图块，并且只有相关部分才会占用资源并被渲染。 正确设置后，开发者便能创建大型、无缝衔接的游戏场景，让玩家仿佛置身于"大世界"之中。

- [关卡流送概述](level-streaming-overview/index.md)

- [关卡流送体积参考](level-streaming-volumes-reference/index.md)

- [使用蓝图加载和卸载关卡](loading-and-unloading-levels-using-blueprints/index.md)

- [Loading and Unloading Levels using C++](loading-and-unloading-levels-using-cplusplus/index.md)

- [World Composition](world-composition/index.md)

- [关卡流送指南](level-streaming-using-volumes/index.md)

## 世界场景构成

世界场景构成用于创建大型场景的特定关卡流送形式。关卡分布在平面网格中，并在玩家靠近时流入。

- [World Composition](world-composition/index.md)

> [!WARNING]
> World Composition是此前用于关卡流送的旧版系统。现在我们推荐使用虚幻引擎5.0或更高版本中的[世界分区（World Partition）](../world-partition/index.md)来实现项目的关卡流送。

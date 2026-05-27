# nDisplay Actor复制

---
title: "nDisplay Actor复制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-actor-replication-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay Actor复制"]
---

# nDisplay Actor复制

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay Actor复制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-actor-replication-in-unreal-engine

nDisplay系统的所有输入仅能由主节点（primary node）处理。无任何复制时，仅主节点能发现场景中的变更。因此，主节点需要能将变更复制到nDisplay网络的所有其他部分。

要进行以上操作，nDisplay提供两种不同组件，可将其附加到Actor：

- **DisplayClusterSceneComponentSyncParent** 组件追踪其父组件3D变换中的变更，并将此类变更推动到网络中的其他群集节点。 nDisplay系统所用的默认DisplayClusterPawn使用此组件。
- **DisplayClusterSceneComponentSyncParent** 组件追踪其子组件3D变换中的变更，并将此类变更推动到网络中的其他群集节点。

例如，在以下Actor中，Actor在关卡中移动时，**DisplayClusterSceneComponentSyncParent_Scene** 组件追踪并复制其父Actor 3D变换的变更。**DisplayClusterSceneComponentSyncThis** 组件追踪并同步其子立方体组件相对于场景图表根的移动。

![DisplayClusterSceneComponentSyncParent](../../../../../assets/images/52/52cf79e4c55502e8dcaad1c64594b960aa08938289b708f5eaa3761b66ca8b19.jpg)

如场景中的其他Actor可能会在游戏进程中受影响，则须使用这两个组件之一将此类变更复制到所有节点。为此，请执行以下操作：

1. 在关卡视口或

   世界大纲视图（World Outliner）

   面板中选择要复制的Actor。
2. 在

   细节（Details）

   面板中，点击

   + 添加组件（+ Add Component）

   。搜索

   DisplayClusterSceneComponentSyncParent

   或

   DisplayClusterSceneComponentSyncThis

   ，并在列表中选择。

![Add an nDisplay sync Component](../../../../../assets/images/5e/5e2dd6eb1a124fbfe56c78d4f1d7a8193cd58f0a41c11ade8ce862e7bd66f1c2.jpg)

> [!NOTE]
> 此类组件不进行完全复制。仅将父Actor或子组件的变换发送到群集。

## 复制自定义数据

如果需要在主节点和其他群集间复制其他自定数据，可以编写自己的C++类来实现 `IDisplayClusterClusterSyncObject` 接口。nDisplay会自动调用此接口中的方法来检查该类中是否需要将每个此类中每个实例从主节点同步到其他群集节点。


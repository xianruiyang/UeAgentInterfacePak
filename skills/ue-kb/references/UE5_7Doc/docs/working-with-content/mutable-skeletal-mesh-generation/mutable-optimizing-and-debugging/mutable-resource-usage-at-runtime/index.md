---
title: "运行时资源使用情况"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mutable-resource-usage-at-runtime-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Mutable骨骼网格体生成", "Mutable优化和调试", "运行时资源使用情况"]
---

# 运行时资源使用情况

> 路径：虚幻引擎5.7文档 / 管理内容 / Mutable骨骼网格体生成 / Mutable优化和调试 / 运行时资源使用情况

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mutable-resource-usage-at-runtime-in-unreal-engine

> [!NOTE]
> 本节适用于在运行时使用Mutable的项目。如果你的项目使用的工作流程仅在虚幻编辑器中使用Mutable，则不会有额外的资源使用。

当在运行时使用Mutable从CustomizableObject创建资产时，Mutable作为一个插件，需要以下额外资源才能运行：

- CPU时间：

  - 大部分CPU加载时间在工作线程中。这使用虚幻任务系统将工作拆分为多个任务。
  - 也有一小部分工作在游戏线程中进行。这些工作必须足够小，以避免卡顿。
- 内存：

  - Mutable生成的最终资产是标准的虚幻引擎资源（纹理、骨骼网格体、动画蓝图等）。
  - 在编译这些资源时，Mutable需要"工作内存"来执行中间操作。
- 磁盘流送带宽：

  - 在角色持续构建过程中，Mutable会加载自身的数据。这会使用虚幻磁盘流送系统。

对于Mutable的CPU和内存使用情况，Unreal Insights中有相应的通道。这些通道默认为关闭，但在捕获时启用它们可以很好地了解运行时工作完成的情况。

## Mutable操作

所有Mutable操作（实例生成或更新）都是按顺序进行，绝不会同时出现两个操作。因此，所有操作都被视为异步操作，并且在操作完成时会有回调通知。

当CustomizableObjectInstance的参数发生更改时，显式调用会强制其进行更新。当Mutable完成更新操作时，将创建或替换引擎资源。

Mutable可以与虚幻引擎的纹理流送功能集成。在进行集成时，每当纹理流送系统请求新的纹理mipmap时，Mutable都会将工作排入队列。在正常的实例更新中，也会按顺序依次进行。

## 内存和缓存

Mutable使用的工作内存量直接取决于正在构建的可自定义对象。其上限的大致估算值约为未压缩格式下生成的最大纹理或最大网格体的内存的2倍。这取决于对纹理执行的操作、UV布局块的使用情况，或者可自定义对象编译设置。

Mutable确实会尝试将工作内存保持在一定限制内。该限制可以在每个平台的INI文件中指定，但某些项目可能希望针对不同的游戏内场景对其进行控制。例如，当玩家处于角色创建界面时，你可能希望为Mutable提供更多内存来缓存数据，从而加快实例更新速度。在这种情况下，可以直接使用 `UCustomizableObject::SetWorkingMemory` 方法或 `mutable.WorkingMemory` 控制台变量进行设置。

---
title: "行为树节点参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/behavior-tree-node-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "行为树", "行为树节点参考"]
---

# 行为树节点参考

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 行为树 / 行为树节点参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/behavior-tree-node-reference-in-unreal-engine

行为树节点（基类）执行行为树的主要工作，包括任务、逻辑流控制和数据更新。

## 行为树节点类型

充当行为树起始点的节点即 **根节点**。它是整个行为树内的一个独特节点，因此拥有一些特殊规则。它只能有一个连接，且不支持附接 **装饰器节点** 或 **服务节点**。尽管根节点没有自己的属性，但选中它会在 **详细信息（Details）** 面板中显示 **行为树（Behavior Tree）** 的属性，您可以在该面板中设置行为树的 **黑板资源（Blackboard Asset）**。

![The Root node has no properties of its own selecting it will show the properties of the Behavior Tree in the Details panel where you can set the Behavior Tree's Blackboard Asset](../../../../../assets/images/70/70aa672b3f9919fb47505e5f161aa1e5ad39e455b382cebc1d5a32542107d838.png)

除根节点外，还有以下四种类型的行为树节点：

| 节点类型 | 说明 |
| --- | --- |
| [合成节点](unreal-engine-behavior-tree-node-reference-composites/index.md) | 此类节点定义分支的根以及执行该分支的基本规则。 |
| [任务节点](unreal-engine-behavior-tree-node-reference-tasks/index.md) | 此类节点是行为树的叶。它们是可执行的操作，没有输出连接。 |
| [装饰器节点](unreal-engine-behavior-tree-node-reference-decorators/index.md) | 也称为条件。它们连接到另一节点，并决定树中的分支、甚至单个节点能否被执行。 |
| [服务节点](unreal-engine-behavior-tree-node-reference-services/index.md) | 此类节点附接至合成节点，而且只要其分支正在执行，它们就会按照定义的频率执行。它们通常用于检查和更新黑板。它们取代了其他行为树系统中的传统并行节点。 |

## 行为树节点实例化规则

行为树节点（此处简称"节点"）作为共享对象存在，这意味着使用同一行为树的所有代理将共享一组节点实例。这样不仅可以在降低内存使用率的同时提升CPU性能，还可以防止节点保存代理特定的数据。不过，对于代理需要存储和更新节点相关信息的情况，虚幻引擎提供了以下三种解决方案：

### 实例化节点

将节点的 `bCreateNodeInstance` 变量设为 `true` 后，将使每个使用行为树的代理成为特殊的节点实例，以牺牲一定性能和内存使用率为代价来确保安全存储代理专属的数据。包括 `UBTTask_BlueprintBase`、`UBTTask_PlayAnimation`、`UBTTask_RunBehaviorDynamic` 在内的部分虚幻引擎节点类均使用此功能。

### 存储在黑板上

常见的解决方案是将变量存储在黑板上。执行此操作的方法是从节点公开变量命名，然后在节点初始化过程中使用该命名获取和存储黑板键。然后便可以使用黑板键在代理的黑板实例上获取并设置该变量的值。此方法支持 `bool`、`float`、`FVector`、`int32`、`enum`（存储为 `uint8`）、`UObject*` 类型的变量。

### 存储在行为树节点上

可以创建自定义结构体或类，将变量存储在节点的内存中。例如，`UBTTask_MoteTo` 类利用 `FBTMoveToTaskMemory`。您可以在 `BTTask_MoteTo.h` 中找到以下代码：

```
	struct FBTMoveToTaskMemory	{		/** Move request ID */		FAIRequestID MoveRequestID; 		FDelegateHandle BBObserverDelegateHandle;		FVector PreviousGoalLocation; 		TWeakObjectPtr<UAITask_MoveTo> Task; 		uint8 bWaitingForPath : 1;		uint8 bObserverCanFinishTask : 1;	};
```

`UBTNode` 中的许多虚函数都将 `uint8*` 参数带到节点的内存中。此参数指示为代理分配的内存块，内存块大小将由 `GetInstanceMemorySize` 的覆盖版本返回。节点将为各个代理分配此大小的内存，并将此内存存储到单一连续块中，以优化性能。但此内存不属于UObject生态系统，也不属于虚幻引擎的反射系统，且无法通过垃圾回收查看。因此，`UPROPERTY` 支持将不可用，建议使用 `TWeakObjectPtr` 来存储可能需要的 `UObject` 指针。

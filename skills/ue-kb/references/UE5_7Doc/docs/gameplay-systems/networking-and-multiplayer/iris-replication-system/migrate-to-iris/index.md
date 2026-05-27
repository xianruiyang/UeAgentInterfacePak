---
title: "Migrate to Iris"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/migrate-to-iris-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "Iris复制系统", "Migrate to Iris"]
---

# Migrate to Iris

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / Iris复制系统 / Migrate to Iris

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/migrate-to-iris-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Iris** 会尽可能保持与 Unreal Engine（UE）通用复制系统的向后兼容性。不过，可能仍需修改 Gameplay 代码，以适应两个系统之间的关键差异。

Iris 的关键设计原则之一，是尽量减少复制系统与 Gameplay 代码之间的交互次数。为此，Iris 减少了虚函数调用数量。通用系统中的这些虚函数调用，会被通过 Iris 复制系统显式调用 API 函数所取代。

下表列出：

- 当前复制系统的功能。
- 这些功能在 Iris 中是否发生变化。
- 如果系统发生变化，对应的 Iris 功能是什么。
- 用于了解更多信息的文档页面链接。

| **现有复制功能** | **在 Iris 中已变化** | **Iris 复制功能** |
| --- | --- | --- |
| [休眠](../../programming-network-multiplayer-games/actor-network-dormancy/index.md) |  |  |
| [优先级](https://dev.epicgames.com/documentation/404) | ✓ | Iris 优先级 |
| [属性复制](../../programming-network-multiplayer-games/replicate-actor-properties/index.md) |  |  |
| [相关性](https://dev.epicgames.com/documentation/404) | ✓ | Iris 筛选 |
| [远程过程调用](https://dev.epicgames.com/documentation/404) |  |  |
| [子对象复制](../../programming-network-multiplayer-games/replicating-uobjects/index.md) | ✓ | [Iris 子对象复制](#subobjectreplication) |

> [!NOTE]
> 上表中未勾选“在 Iris 中已变化”的内容，其工作方式与通用复制系统相同。

## 推送模型

Iris 目标是完全基于推送。也可以在不启用推送模型复制的情况下使用 Iris。如果某个对象未启用推送模型复制，Iris 会基于该对象的 `NetUpdateFrequency`自动回退为轮询该对象。默认情况下，Iris 遵循标准推送模型设置。

## 复制属性

复制属性的工作方式与通用复制系统相同。关于 UE 中复制属性如何工作的更多信息，请参阅 [复制 Actor 属性](../../programming-network-multiplayer-games/replicate-actor-properties/index.md) 文档。

## 远程过程调用

Iris 中远程过程调用（RPC）的声明和执行方式，与通用复制系统和 Replication Graph 中相同。关于 RPC 和复制属性更新如何在接收机器上执行的更多信息，请参阅 [复制执行顺序](https://dev.epicgames.com/documentation/404) 文档。

## 子对象复制

Iris 要求启用 *已注册子对象列表*。要为 Actor 类使用已注册子对象列表，请将以下内容添加到复制 Actor 的构造函数中：

```
	bReplicateUsingRegisteredSubObjectList = true;
```

如果使用 Iris，未派生自 `AActor` or `UActorComponent` 的复制子对象也必须实现虚函数 `RegisterReplicationFragments` 以注册其复制属性和函数。要为 `RegisterReplicationFragments` 实现 `UObject`派生类 `UMyDerivedObject`，请分别将以下代码添加到 `MyDerivedObject.h` 和 `MyDerivedObject.cpp` 文件中：

MyDerivedObject.h

```
	#if UE_WITH_IRIS	// Register replication fragments	virtual void RegisterReplicationFragments(UE::Net::FFragmentRegistrationContext& Context, UE::Net::EFragmentRegistrationFlags RegistrationFlags) override;	#endif // UE_WITH_IRIS
```

MyDerivedObject.cpp

```
	#if UE_WITH_IRIS	#include "Iris/ReplicationSystem/ReplicationFragmentUtil.h"	#endif // UE_WITH_IRIS 	#if UE_WITH_IRIS	void UMyDerivedObject::RegisterReplicationFragments(UE::Net::FFragmentRegistrationContext& Context, UE::Net::EFragmentRegistrationFlags RegistrationFlags)	{		// Build descriptors and allocate PropertyReplicaitonFragments for this object		UE::Net::FReplicationFragmentUtil::CreateAndRegisterFragmentsForObject(this, Context, RegistrationFlags);	}	#endif // UE_WITH_IRIS
```

关于复制子对象的更多信息，请参阅 [复制子对象](../../programming-network-multiplayer-games/replicating-uobjects/index.md) 文档。

## 自定义网络序列化器

Iris 支持所有可作为复制属性进行网络序列化的 Unreal Engine 基础类型。如果结构体使用自定义 `NetSerialize` 方法，但缺少 Iris 专用实现，会记录以下警告：

```
	Warning: Generating descriptor for struct STRUCT_NAME that has custom serialization.
```

如果 `NetSerialize` 方法中的数据仅使用属性网络序列化方法即可复制，可以通过向项目的 `DefaultEngine.ini` 文件添加条目来消除该警告：

DefaultEngine.ini

```
	[/Script/IrisCore.ReplicationStateDescriptorConfig]	; Declarate structs that are vetted to work using reflection based struct serialization even though there exists a custom NetSerialize function for the struct	+SupportsStructNetSerializerList=(StructName=STRUCT_NAME)
```

## 快速数组复制

Iris 支持现有快速数组定义。Iris 还提供一个专用快速数组序列化器： `FIrisFastArraySerializer`，位于 `IrisFastArraySerializer.h`.

## 点对点

Iris 支持 Unreal Engine 监听服务器。使用监听服务器时，游戏实例可以作为多人游戏会话的主机，同时支持自身的本地玩家。

## Replication Graph 特有差异

该 [Replication Graph](../../replication-graph/index.md) 插件是一个网络复制系统，建立在包含待复制持久对象列表的节点之上。Iris 不支持 Replication Graph。Iris 和 Replication Graph 是相互独立的系统，网络驱动只能使用其中之一。Iris 没有 Replication Graph 那种用于控制 Actor 在何时何地复制的节点概念。新的网络对象筛选器和优先级器旨在替代 Replication Graph 的功能。更多信息请参阅筛选和优先级文档。

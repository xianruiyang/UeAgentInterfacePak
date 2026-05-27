---
title: "Iris组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/components-of-iris-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "Iris复制系统", "Iris组件"]
---

# Iris组件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / Iris复制系统 / Iris组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/components-of-iris-in-unreal-engine

**Iris复制系统（Iris Replication System）** 是 **虚幻引擎（Unreal Engine (UE)）** 中用于Iris的主要接口。Iris以量化形式保留所有复制的状态数据的完整副本，最大限度减少Gamep系统与复制系统之间的依赖性。Iris仅执行一次高开销操作，并在各个连接之间共享工作，使系统能够并行执行更多工作。这种并行工作可以节省时间和资源。

本页面提供以下内容：

- 关于如何访问复制网桥和复制系统的说明
- 关于Iris如何复制对象的内部工作机制的概述

## 接口

Iris复制系统接口允许你管理复制系统，并提供了函数来控制：

- 连接
- 组
- 优先级安排
- 筛选
- 远程程序调用

所有Iris接口函数在通过复制网桥创建的网络引用句柄（ `FNetRefHandle` ）上操作。*网络引用句柄* 是Iris复制网桥创建的标识符。网络引用句柄是一个密钥，用于将网络对象唯一地映射到创建期间提供的其关联的Gameplay实例（ `UObject` 、 `UActorComponent` 或 `AActor` ）。

> [!TIP]
> 如需详细了解用于描述Iris的术语，请参阅[Iris术语的术语表](../glossary-of-iris-terms/index.md)文档页面。

### 复制网桥

Iris复制网桥负责在Gameplay实例对象（例如Actor）上操作的所有功能。复制网桥位于你的Gameplay代码和内部Iris复制系统之间。网桥是一个集中通道，Iris中涉及在Iris复制系统与Gameplay代码之间传达状态数据的所有操作都将通过它进行。

在发送计算机上，复制网桥管理复制系统所需的网络对象和协议的生命周期。你可以使用复制网桥获取复制的对象的网络引用句柄。然后将网络引用句柄用于复制系统，为你的对象自定义复制设置。

在接收计算机上，复制网桥负责实例化Actor并管理其生命周期。

更明确地说，复制网桥的作用是：

1. 使用

   BeginReplication

   和

   EndReplication

   为复制的对象开始和结束复制。
2. 驱动复制协议和复制实例协议的创建。
3. 序列化和反序列化所需的数据以将对象实例化。
4. 在游戏端为复制系统将对象实例化。
5. 处理Gameplay实例和网络引用句柄之间的映射。

> [!TIP]
> 复制网桥的相关头文件包括：
>
> - ..\Engine\Source\Runtime\Engine\Public\Net\Iris\ReplicationSystem\ActorReplicationBridge.h
> - ..\Engine\Source\Runtime\Experimental\Iris\Core\Public\Iris\ReplicationSystem\ObjectReplicationBridge.h

#### 控制复制

要复制对象，Iris首先会创建该对象的网络表示。复制网桥会在 `BeginReplication` 中管理网络对象和网络引用句柄的创建。

##### 开始复制

在 `BeginReplication` 期间，Iris会设置一个复制协议，用来描述与对象关联的复制的数据的所有方面。此复制协议对同一类型的所有实例共享。对于对象的每个实例，复制系统会创建一个复制实例协议，将实例特有的数据包含在内。实例特有的数据包括在何处查找应该复制的数据，以及在何处为此特定实例推送接收到的数据。

##### 访问复制网桥

Iris为复制的对象创建网络引用句柄后，你就可以使用复制系统API控制对象如何复制。要获取所复制对象的网络引用句柄，请执行以下步骤：

1. 包含必要的Iris文件：

   ```
            #if UE_WITH_IRIS         #include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"         #include "Net/Iris/ReplicationSystem/ActorReplicationBridge.h"         #endif UE_WITH_IRIS
   ```
2. 检索你的Actor的复制网桥的引用。

   ```
            // 你要获取其网络引用句柄的Actor         AActor* RepActorPtr;		         UActorReplicationBridge* ReplicationBridge = UE::Net::FReplicationSystemUtil::GetActorReplicationBridge(RepActorPtr);
   ```
3. 获取所复制对象的网络引用句柄：

   ```
            UE::Net::FNetRefHandle RepActorNetRefHandle = ReplicationBridge->GetReplicatedRefHandle(RepActorPr);		         // 现在你可以检索复制系统并执行API操作
   ```

##### 结束复制

在 `EndReplication` 期间，复制系统会清除为你的Gameplay对象创建的所有网络资源，并停止复制对象。

#### 状态跟踪

如果游戏在存在待完成工作时通知复制系统，Iris的性能最优。Iris并不预期复制系统会轮询获得更改。复制系统预期在每次修改复制的属性时会得到通知。为了高效实现此修改系统，Iris中所有复制的变量都是复制状态的一部分。*复制状态* 是结构体，其中包含应该通过网络复制或传输的数据。

复制状态分配了空间，用于对成员的脏污度进行位域跟踪。如果成员的状态发生更改，但更改尚未传达给下游系统，则该成员是 *脏* 的。复制状态还包含一个嵌入式标识符，用于通知复制系统，某个对象有脏污状态数据需要更新。

### 复制系统

复制系统是在Iris中与复制的对象交互的主API。在获取你想通过复制网桥与之交互的对象的网络引用句柄后，你可以自定义对象的复制行为。自定义包括筛选该对象复制到哪些连接，或更新该对象的复制优先级。

#### 访问复制网桥

要访问用于所复制对象的复制系统，请执行以下操作：

1. 包含必要的Iris文件：

   ```
            #if UE_WITH_IRIS         #include "Net/Iris/ReplicationSystem/ReplicationSystemUtil.h"         #endif UE_WITH_IRIS
   ```
2. 在Gameplay代码中，检索所复制对象的复制系统：

   ```
            // 你要获取其网络引用句柄的Actor         AActor* RepActorPtr;		         UReplicationSystem* ReplicationSystem = UE::Net::FReplicationSystemUtil::GetReplicationSystem(RepActorPtr);
   ```

> [!TIP]
> 复制系统的相关头文件包括：
>
> - ..\Engine\Source\Runtime\Engine\Public\Net\Iris\ReplicationSystem\ReplicationSystemUtil.h
> - ..\Engine\Source\Runtime\Experimental\Iris\Core\Public\Iris\ReplicationSystem\ReplicationSystem.h

关于如何为复制的对象自定义复制的示例，请参阅筛选和优先级安排文档。

## 复制系统的流程

此小节介绍了Iris的内部工作机制的流程，以及Iris的不同组件如何相互配合。

该流程由一台发送计算机和一台或多台接收计算机组成。发送计算机具有关于所复制对象的新信息，发送者必须将这些信息传达给多人游戏会话中其他连接的计算机。发送计算机的复制过程包含两个步骤：发送前更新和发送更新。具有过时信息的已连接计算机是接收计算机，必须更新其关于所复制对象的信息，以匹配发送计算机的状态。

在发送计算机和接收计算机之间传达数据的过程中，会使用网络序列化器和数据流。网络序列化器将变换数据，以通过网络高效传输。数据流将定义这些数据的发送方式，包括特殊交付保证。

### 发送计算机

#### 发送前更新

复制系统传出端的发送前更新是执行大部分共享工作的地方。这也是系统唯一一次从Gameplay代码访问数据。此更新包含以下步骤：

1. 如果在旧版模式中运行，轮询复制的对象以获取状态更改。
2. 复制并量化所有脏污状态数据。
3. 重置所复制对象的脏污度状态。
4. 更新网络对象的筛选状态。
5. 更新网络对象的优先级安排。

#### 发送更新

填充数据包数据时，目标是不触及未包含在复制系统中的数据。这样就可以更轻松地以缓存友好的方式并发完成任务。对所有连接的发送更新过程按如下所示：

- 通过更新所有数据流，创建并填充数据包。

  - 复制数据流：

    1. 根据对象优先级和安排优先级，安排发送脏污对象的数据。
    2. 基于优先级和依赖性排序。
    3. 序列化状态数据。

### 接收计算机

接收数据包的一端按如下所示为所有连接处理传入数据包：

- 首先更新交付通知。
- 数据流处理每个数据包中包含的数据：

  - 复制数据流：

    - 读取状态数据：

      状态数据在读取整个数据包之后发送。新对象会立即实例化，因为复制系统依赖它们来构建复制协议。
    - 发送状态数据：

      复制系统会将新数据推送到游戏，以更新Gameplay对象。

## 更多信息

如需详细了解Iris复制系统的组件，包括关于如何更改Actor的复制行为的示例，请参阅此小节中的其他文档页面：

- [筛选](iris-filtering/index.md) - 使用Iris筛选要复制到特定网络连接的对象。

- [优先级安排](iris-prioritization/index.md) - 对要使用Iris复制的对象进行优先级安排。

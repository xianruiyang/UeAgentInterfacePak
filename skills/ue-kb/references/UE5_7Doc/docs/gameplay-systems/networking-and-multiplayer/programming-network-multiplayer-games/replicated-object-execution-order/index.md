---
title: "Replicated Object Execution Order"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/replicated-object-execution-order-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "Replicated Object Execution Order"]
---

# Replicated Object Execution Order

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / Replicated Object Execution Order

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/replicated-object-execution-order-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Unreal Engine（UE）的网络复制会结合可靠与非可靠通信方式，在服务器和已连接客户端之间传输信息。 *可靠* 通信会持续发送，并暂停所有其他网络通信，直到接收机器确认为止。 *非可靠* 通信会发送一次；如果接收机器未确认接收，在当前网络 tick 中不会重发。

在 Actor 属性和远程过程调用（RPC）复制中，理解这些通信的相对顺序有哪些保证，以及应如何在游戏代码中考虑这些保证非常重要。本文说明 UE 复制系统提供哪些保证，以及同样重要的：不提供哪些保证。

## Actor 属性

Actor 属性更新是非可靠的，并会作为单个 bunch 发送。可以把它们理解为一个非可靠 RPC：它会在所有其他 RPC 之后、但在已排队 RPC 之前发送。关于已排队 RPC 的更多信息，请参阅 [强制排队](index.md) 章节。

### Replicated Using 顺序

不同复制变量的 OnRep（RepNotify）回调之间没有确定顺序。客户端上的调用顺序与变量是否被标记为 dirty 或其在内存中的声明位置无关。如果需要多个变量之间具有可靠顺序，建议将它们一起存储在结构体中。

如果 Actor 属性复制顺序对游戏很重要，可能需要实现 OnRep 来跟踪逐帧属性更新。在收到复制值并调用其 OnRep 后，可以在 [UObject::PostRepNotifies](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/PostRepNotifies?application_version=5.5) 函数中处理变更。你可能还需要在各自的 OnRep 中保存某些接收到的值，直到它们可以被使用。

## 远程过程调用

Unreal Engine 的复制系统会尽可能可靠地执行 RPC，使 Gameplay 系统可以在较少担心网络副作用的情况下构建。

### 跨 Actor 顺序

没有机制能保留多个 Actor 之间 RPC 的原始调用顺序，并在远程机器上重新应用该顺序。考虑以下发送机器上的 RPC 调用顺序示例：

C++

```
AActor* MyActor;    AActor* OtherActor;     // Valid MyActor pointer    MyActor->ClientRPC1();    OtherActor->ClientRPC2();    MyActor->ClientRPC3();
```

在此示例中，接收机器上的 RPC 执行顺序 *不是* 确定的；这些 RPC 可能以任意组合在接收机器上执行：

C++

```
RPC1 --> RPC2 --> RPC3    RPC1 --> RPC3 --> RPC2    RPC2 --> RPC1 --> RPC3    RPC2 --> RPC3 --> RPC1    RPC3 --> RPC1 --> RPC2    RPC3 --> RPC2 --> RPC1
```

### Actor 内部顺序

复制系统会保证同一 Actor 上可靠 RPC 的调用顺序。它们在接收机器上的执行顺序与发送机器上的调用顺序相同。如果发送机器上的调用顺序是：

C++

```
AActor* MyActor;     // Valid MyActor pointer    MyActor->ClientReliableRPC1();    MyActor->ClientReliableRPC2();    MyActor->ClientReliableRPC3();
```

那么接收机器始终会按此顺序执行这些 RPC：

C++

```
RPC1 --> RPC2 --> RPC3
```

### Actor 与子对象之间的顺序

对于在 Actor 及其子对象上调用的所有 RPC，接收机器会遵守 RPC 执行顺序。例如，如果发送机器发送：

C++

```
AActor* MyActor;     // Valid MyActor pointer    MyActor->RPC1();    MyActor->SubObject1->RPC2();    MyActor->SubObject2->RPC3();    MyActor->RPC4();
```

接收机器上的执行顺序为：

C++

```
RPC1 --> RPC2 --> RPC3 --> RPC4
```

### 非可靠与可靠 RPC 的顺序

非可靠 RPC 与可靠 RPC 之间的执行顺序可能看起来被保留，但这从不保证。当没有丢包或数据包重排时，接收机器上非可靠与可靠 RPC 的执行顺序会与发送机器相同。考虑以下发送机器上的 RPC 调用顺序示例：

C++

```
AActor* MyActor;     // Valid MyActor pointers    MyActor->ClientReliableRPC1();    MyActor->ClientUnicastUnreliableRPC2();    MyActor->ClientReliableRPC3();
```

如果没有发生丢包或重排，接收机器可能按此顺序执行 RPC：

C++

```
RPC1 --> RPC2 --> RPC3
```

If `RPC1` 位于被丢弃或重排的单独数据包中，则接收机器会执行：

C++

```
RPC2 --> RPC1 --> RPC3
```

If `RPC2` 位于被丢弃的单独数据包中，则接收机器会执行：

C++

```
RPC1 --> RPC3
```

在最后一种情况下， `RPC2` 会被丢弃，并且由于它是非可靠的，永远不会在接收机器上执行。

> [!NOTE]
> 不应出现非可靠 `RPC2` 在以下 RPC 之后执行的情况： `RPC3`。如果包含 `RPC2` 的数据包被重排，并且晚于 `RPC3`到达，则接收时会忽略它。

### 多播与单播顺序

多播 RPC 的顺序更复杂，因为 UE 的复制系统并不总是保留多播 RPC 与单播 RPC 之间的调用顺序。

#### 多播为可靠时

可靠多播与其他可靠单播 RPC 之间的调用顺序会被保留。例如，如果发送机器按以下顺序调用函数：

C++

```
MyActor->MulticastReliableRPC1();    MyActor->UnicastReliableRPC2();    MyActor->UnicastReliableRPC3();    MyActor->MulticastReliableRPC4();
```

那么接收机器会按以下顺序执行 RPC：

C++

```
RPC1 --> RPC2 --> RPC3 --> RPC4
```

请记住，非可靠 `RPC3` 的顺序并不确定，它可能更早执行，也可能根本不执行。

#### 多播为非可靠时

非可靠多播永远不会在与其他单播和可靠多播之间保留调用顺序。例如，如果发送机器按以下顺序调用 RPC：

C++

```
MyActor->MulticastUnreliableRPC1();    MyActor->UnicastReliableRPC2();    MyActor->MulticastUnreliableRPC3();    MyActor->UnicastUnreliableRPC4();
```

那么接收机器会按以下顺序执行 RPC：

C++

```
RPC2 --> RPC4 --> RPC1 --> RPC3
```

`RPC1` and `RPC3` 会被排队并最后序列化，因为它们是非可靠多播 RPC。这意味着单播会先执行，非可靠多播会最后执行。关于丢弃非可靠单播 RPC 的规则在这里也适用。

> [!NOTE]
> If `RPC2` 位于被丢弃或重排的单独数据包中，则接收机器会按以下顺序执行 RPC：
>
> C++
>
> ```
> RPC1 --> RPC3 --> RPC2 --> RPC4
> ```

### RPC 发送策略

可以为 RPC 指定显式发送策略，从而影响 RPC 的排序。可通过指定以下内容实现： `ERemoteFunctionSendPolicy`。关于 RPC 发送策略的更多信息，请参阅 [远程过程调用](../remote-procedure-calls/index.md) 文档。

#### 强制发送

具有 `ERemoteFunctionSendPolicy::ForceSend` 策略的 RPC 会改变非可靠多播 RPC 的顺序，并阻止它们排队。以下是示例：

C++

```
MyActor->ForceSendMulticastUnreliableRPC1();    MyActor->UnicastReliableRPC2();    MyActor->MulticastUnreliableRPC3();    MyActor->UnicastUnreliableRPC4();
```

客户端会按以下顺序执行这些 RPC：

C++

```
RPC1 --> RPC2 --> RPC4 --> RPC3
```

#### 强制排队

具有 `ERemoteFunctionSendPolicy::ForceQueue` 策略不会遵守调用顺序，除非与其他 `ForceQueue` RPC 和非可靠多播配合。以下是示例：

C++

```
MyActor->ForceQueueRPC1();    MyActor->UnicastReliableRPC2();    MyActor->MulticastUnreliableRPC3();    MyActor->UnicastUnreliableRPC4();
```

客户端会按以下顺序执行这些 RPC：

C++

```
RPC2 --> RPC4 --> RPC1 --> RPC3
```

## RPC 与 Actor 属性之间的顺序

理解 RPC 执行与复制属性更新应用之间的顺序也很重要。在这种情况下，适用以下规则：

- RPC 先执行。
- 属性随后更新。
- 属性更新会作为单个非可靠数据块发送。

bunch 载荷按以下方式构建：

- 序列化非排队 RPC。
- 序列化复制属性数据。
- 序列化已排队 RPC。

> [!WARNING]
> 在 RPC 内写入的复制变量可能会丢失，并被尚未处理的属性更新立即覆盖。

> [!NOTE]
> 该规则的一个例外是非可靠多播 RPC，因为它们会在调用处排队，并始终最后序列化。这意味着它们会在属性更新应用 *之后* 执行。

以下是示例：

C++

```
MyActor->ReliableRPC1();    MyActor->bReplicatedVar1 = true    MyActor->MulticastUnreliableRPC2();    MyActor->bReplicatedVar2 = true;    MyActor->ReliableRPC3();
```

远程机器会按以下顺序执行这些内容：

C++

```
RPC1 --> RPC3 --> Var1 && Var2 --> RPC2
```

以下是属性更新与 RPC 混合的另一个示例：

C++

```
MyActor->ReliableRPC1();    MyActor->bReplicatedVar1 = true    MyActor->MulticastUnreliableRPC2();    MyActor->bReplicatedVar2 = true;    MyActor->ReliableRPC3();
```

假设属性更新被丢弃，则接收机器会按以下顺序执行 RPC 和属性更新：

C++

```
RPC1 --> RPC3 --> RPC2    // After the next update    Var1 && Var2
```

另一种场景是只有可靠 RPC1 被丢弃，此时接收机器上的执行顺序如下：

C++

```
Var1 && Var2 --> RPC2 --> RPC1 --> RPC3
```

## 使用非可靠 RPC 测试 Gameplay 代码

如果正在创建或依赖使用非可靠 RPC 复制的代码，建议强制丢弃这些 RPC，并观察系统如何响应。关于如何通过模拟较差网络条件实现这一点，请参阅 [使用网络模拟](../../network-debugging/using-network-emulation/index.md) 文档。

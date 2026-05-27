# Remote Procedure Calls

---
title: "Remote Procedure Calls"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-procedure-calls-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "Remote Procedure Calls"]
---

# Remote Procedure Calls

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / Remote Procedure Calls

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-procedure-calls-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**远程过程调用（RPC）** 是在本地调用、但在一个或多个已连接机器上远程执行的函数。RPC 帮助客户端和服务器通过网络连接相互调用函数。RPC 是单向函数调用，因此不能指定返回值。RPC 的主要用途是执行临时性或表现性的非可靠 Gameplay 事件，例如：

- 播放声音
- 生成粒子
- 播放动画

RPC 是对使用以下说明符的复制属性进行补充的重要机制： `Replicated` or `ReplicatedUsing` 。要调用 RPC，必须从 Actor 或 Actor 组件调用该 RPC，并将 Actor 及相关 Actor 组件设置为复制。

由于 Actor 所有权会决定 RPC 远程执行的位置，因此首先理解所有权如何与 RPC 配合非常重要。关于 Actor 所有权的更多信息，请参阅 [Actor 所有者与拥有连接](../actor-owner-and-owning-connection/index.md) 文档。

## RPC 类型

RPC 有四种不同类型，如下表所示：

| 元数据说明符 | 说明 |
| --- | --- |
| `Client` | 该 RPC 会在此 Actor 的拥有客户端连接上执行。 |
| `Server` | 该 RPC 会在服务器上执行。必须从拥有此 Actor 的客户端调用。 |
| `Remote` | 该 RPC 会在连接的远端执行。连接的远端可以是服务器，也可以是客户端，但 RPC 必须在由客户端拥有的 Actor 上调用。该 RPC 的行为类似于 `Client` 和 `Server` RPC，但绝不会在连接本地端执行，只会在远端执行。 |
| `NetMulticast` | 该 RPC 会在服务器以及该 Actor 当前相关的所有已连接客户端上执行。`NetMulticast` RPC 设计为从服务器调用，但也可以从客户端调用。从客户端调用的 `NetMulticast` RPC 只会在本地执行。 |

## RPC 结构

所有 RPC 都由两部分组成：

- 在头文件中定义的基础函数。

  C++

  DerivedActor.h

  ```
  UFUNCTION(Client)      void ClientRPC();
  ```
- 源文件中包含基础函数实现的实现函数。

  C++

  DerivedActor.cpp

  ```
  #include "DerivedActor.h"       void ClientRPC_Implementation()      {				      }
  ```

Unreal Engine 的反射和复制系统会管理较底层的细节，但要求你定义并实现这两部分。以下章节说明如何声明和实现 RPC。

## 创建 RPC

要为 Actor 创建 RPC，请按以下步骤操作：

1. 从 [RPC 类型](index.md) 章节中选择一个函数元数据说明符：

   C++

   DerivedActor.h

   ```
   #pragma once

        #include "DerivedActor.generated.h"

        UCLASS()
        class ADerivedActor : public AActor
        {
            GENERATED_BODY()

        public:
   ```

   > [!TIP]
   > 通常约定在 RPC 函数名称前添加 RPC 类型前缀： *`Client` 用于 Client RPC 函数。* `Server` 用于 Server RPC 函数。 * `Multicast` 用于 Network Multicast RPC 函数。
   >
   > 这样可以在多人会话中快速看出该函数调用面向哪些机器。
2. 确保你的 `AActor`派生类在派生 Actor 的构造函数中被设置为复制：

   C++

   DerivedActor.cpp

   ```
   ADerivedActor::ADerivedActor(const class FPostConstructInitializeProperties & PCIP) : Super(PCIP)     {         bReplicates = true;     }
   ```
3. 实现 RPC 的 `_Implementation` 函数：

   C++

   DerivedActor.cpp

   ```
   #include "DerivedActor.h"

        void ADerivedActor::ClientRPC_Implementation()
        {
            // This log will print on every machine that executes this function.
            UE_LOG(LogTemp, Log, TEXT("ClientRPC executed."))
        }

        void ADerivedActor::ServerRPC_Implementation()
        {	
   ```

## 执行 RPC

要执行 RPC，请调用 RPC 函数的标准版本：

C++

```
// Call from client to run on server
	ADerivedClientActor* MyDerivedClientActor;
	MyDerivedClientActor->ServerRPC();

	// Call from server to run on client
	ADerivedServerActor* MyDerivedServerActor;
	MyDerivedServerActor->ClientRPC();

	// Call from server to run on server and all relevant clients
	ADerviedServerActor* MyDerivedServerActor;
```

## 单播与多播

`Client`, `Server`和 `Remote` RPC 是单播 RPC。 *单播* 之所以称为单播 RPC，是因为它们只在一台机器上执行。 `NetMulticast` is a *多播* RPC，因为它会在多台机器上执行。

## RPC 执行矩阵

下表说明 RPC 会在哪台机器上执行，这取决于 RPC 类型、调用它的机器，以及调用 RPC 的 Actor 的拥有连接。可以按如下方式阅读表格列：

A [*RPC 类型*] 从 [*调用机器*] 调用，其关联 Actor 的拥有连接为 [*拥有连接*]，则会在 [*执行机器*].

例如，Server RPC 表中的第一行可读作：

- A *Server RPC* 从 *Server* 调用，且其关联 Actor 的拥有连接为 *Client* 则会在以下机器执行： *Server*.

Client RPC 表中的最后一行可读作：

- A *Client RPC* 从 *Client* whose associated actor's owning connection is *无* 则会在以下机器执行： *调用客户端*.

### Server RPC

| 调用机器 | 拥有连接 | 执行机器 |
| --- | --- | --- |
| Server | Client | Server |
| Server | Server | Server |
| Server | 无 | Server |
| Client | 调用客户端 | Server |
| Client | 不同客户端 | 丢弃 |
| Client | Server | 丢弃 |
| Client | 无 | 丢弃 |

### Client RPC

| 调用机器 | 拥有连接 | 执行机器 |
| --- | --- | --- |
| Server | 拥有客户端 | 拥有客户端 |
| Server | Server | Server |
| Server | 无 | Server |
| Client | 调用客户端 | 调用客户端 |
| Client | 不同客户端 | 调用客户端 |
| Client | Server | 调用客户端 |
| Client | 无 | 调用客户端 |

### Remote RPC

| 调用机器 | 拥有连接 | 执行机器 |
| --- | --- | --- |
| Server | 拥有客户端 | 拥有客户端 |
| Server | Server | 丢弃 |
| Server | 无 | 丢弃 |
| Client | 调用客户端 | Server |
| Client | 不同客户端 | 丢弃 |
| Client | Server | 丢弃 |
| Client | 无 | 丢弃 |

### Net Multicast RPC

| 调用机器 | 拥有连接 | 执行机器 |
| --- | --- | --- |
| Server | Client | 服务器以及调用 Actor 相关的所有客户端 |
| Server | Server | 服务器以及调用 Actor 相关的所有客户端 |
| Server | 无 | 服务器以及调用 Actor 相关的所有客户端 |
| Client | 调用客户端 | 调用客户端 |
| Client | 不同客户端 | 调用客户端 |
| Client | Server | 调用客户端 |
| Client | 无 | 调用客户端 |

## 可靠性

Unreal Engine 中的 RPC 会被标记为可靠或非可靠：

| 元数据说明符 | 说明 | 执行顺序 |
| --- | --- | --- |
| `Reliable` | 该 RPC 会持续重发，直到接收方确认为止。在该 RPC 被确认之前，后续所有 RPC 执行都会暂停。 | 保证按顺序执行。 |
| `Unreliable` | 如果数据包被丢弃，该 RPC 不会执行。 | 不保证顺序。 |

> [!NOTE]
> RPC 默认是非可靠的。可靠 RPC 需要额外带宽，因此应谨慎使用。

> [!TIP]
> 关于 Unreal Engine 复制执行顺序保证的更多信息，请参阅 [复制对象执行顺序](../replicated-object-execution-order/index.md) 文档。

### 指定 RPC 可靠性

要指定 RPC 的可靠性，请为 RPC 添加相应的元数据说明符：

C++

DerivedActor.h

```
#pragma once

	#include "DerivedActor.generated.h"

	UCLASS()
	class ADerivedActor : public AActor
	{
		GENERATED_BODY()

	public:	
```

## 发送策略

可以为 RPC 指定显式发送策略，从而影响 RPC 的排序。可通过指定以下内容实现： `ERemoteFunctionSendPolicy`:

| 值 | 说明 |
| --- | --- |
| `Default` | 该 RPC 会立即序列化到 [bunch](index.md#bunch) 中，并在帧末的下一次网络更新中发送该 bunch。 |
| `ForceSend` | 如果 RPC 在 `NetDriver::PostTickDispatch`中触发，该 RPC 会立即序列化到 bunch 并通过网络发送。如果 RPC 在该 tick 的其他阶段触发，则会按照 `Default` 行为发送。这是一种特殊 RPC 优化，在以下条件下生效：仅 Replication Graph 和 Iris 支持适用于在以下阶段调用的 RPC： `NetWorldTickTime` 此时会处理传入数据包，并执行远程连接发送的 RPC。该优化会在帧开始而不是帧末发送数据，从而降低重要 Gameplay 事件的延迟。代价是更高的 CPU 使用量和额外带宽。 |
| `ForceQueue` | 如果还有剩余带宽，该 RPC 会在网络更新结束时序列化到 bunch 中。 |

要在项目中为 RPC 指定发送策略，请参阅 [UNetDriver::ProcessRemoteFunctionForChannel](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UNetDriver/ProcessRemoteFunctionForChannel?application_version=5.5)。关于远程机器上 RPC 执行顺序保证的更多信息，请参阅 [复制对象执行顺序](../replicated-object-execution-order/index.md) 文档。

##### Bunch

在 Unreal Engine 网络系统中，一个网络包由多个 bunch 组成。一个 *bunch* 是特定复制对象（例如 Actor）的一组属性变更和 RPC。

## Server RPC 验证

Server RPC 验证实现了一种 *信任并验证* 网络策略。服务器信任客户端传来的信息，但始终验证该信息是否符合服务器端游戏定义的规则和约束。

可以使用 `WithValidation` `UFUNCTION` 元数据标记 Server RPC，并定义对应的 Server RPC 验证函数。验证函数与 RPC 函数同名，但在函数名末尾追加 `_Validate` 。其返回类型为布尔值，并接收与关联 RPC 函数相同的参数。验证函数会根据你定义的验证逻辑，帮助服务器判断 RPC 是否应运行。当客户端请求执行 Server RPC 时，服务器会先调用验证函数。

根据验证函数的输出，会发生以下情况：

- 如果输入通过验证，则调用实现函数。
- 如果输入未通过验证，则调用客户端会从服务器断开连接。

### 添加验证实现

要为 RPC 添加验证函数，请按以下步骤操作：

1. 按照步骤 [声明 Server RPC](index.md) 并添加 `WithValidation` 元数据说明符：

   C++

   DerivedActor.h

   ```
   #pragma once

        #include "DerivedActor.generated.h"

        UCLASS()
        class ADerivedActor : public AActor
        {
            GENERATED_BODY()

        public:
   ```
2. 实现验证函数：

   C++

   DerivedActor.h

   ```
   #include "DerivedActor.h"

        // RPC Validation Implementation
        bool ServerUnreliableRPC_Validate(int32 RecoverHealth)
        {
            if (Health + RecoverHealth > MAXHEALTH)
            {
                return false;
            }
        return true;
   ```

> [!WARNING]
> 如果 Server RPC 验证失败，调用客户端会被断开连接。

## 蓝图中的 RPC

C++ RPC 中存在的相同 RPC 类型、可靠性选项和执行逻辑，也适用于蓝图 RPC。

### 创建蓝图 RPC

也可以使用复制的蓝图事件在蓝图中创建 RPC。要创建复制的蓝图事件，请按以下步骤操作：

1. 创建或打开 Blueprint Actor 或 Actor 派生类。
2. 确保你的蓝图已设置为 **复制** ，位置在蓝图的 **细节面板**。

   ![Set actor to replicate.](../../../../../assets/images/2d/2d6ad4948e60eae31395325c946b89cac0fb9892ac9a1aa54b766815e1a7175d.png)

   点击图片可展开。
3. 打开蓝图的 **事件图表**。

   ![Open Blueprint event graph.](../../../../../assets/images/45/450b4b804a62d53312be016a3f3f8be682a3bb0adde063e2779240b7cde261f6.jpg)

   点击图片可展开。
4. 右键单击并选择 **添加事件 > 添加自定义事件…**

   ![Add a custom event.](../../../../../assets/images/b0/b05ef493f5724e59f040329087df652397d35d147a23ce8e70a7bb73b2723a76.jpg)

   点击图片可展开。
5. 点击你的 **CustomEvent** 节点以显示 **细节面板**。

   ![Open Custom Event details panel.](../../../../../assets/images/dd/dd235874bb0fa45a92bf718cbf80b5d6023c7f44acac50442714e4398449cd2c.jpg)

   点击图片可展开。
6. 可以在以下位置选择事件是否复制、使用哪种复制类型，以及它是可靠还是非可靠： **细节面板 > 图表 > 复制**。

   ![Set Custom Event to replicate.](../../../../../assets/images/27/27b56f8174dcf7e8b9c19a3c711991818e219c8d534854fee4a09d3b5ab94818.jpg)

   点击图片可展开。
7. 选择所需设置后，在蓝图的事件图表中定义 RPC 功能。

   ![Implement replicated event.](../../../../../assets/images/1e/1e4d3c8248baa613d7009f808dcb3091c1aa738a9f730fdbac82dbe3a385ca18.jpg)

   点击图片可展开。

### 执行蓝图 RPC

可以像执行其他蓝图事件一样执行蓝图 RPC，但它遵循与 C++ 中定义的 RPC 相同的规则。RPC 只能从具有有效所有者和拥有连接的复制 Actor 或 Actor 组件执行。

> [!NOTE]
> `Remote` RPC 当前未暴露给蓝图。


---
title: "Horde租赁"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-leases-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde内部机制", "Horde租赁"]
---

# Horde租赁

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde内部机制 / Horde租赁

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-leases-for-unreal-engine

Horde与其代理通信的机制主要基于Google的Remote Worker API。分配给代理的工作项被称为 **租赁** 。

代理与服务器之间的通信是通过代理发起的流式gRPC调用实现的。连接的两端会交换各自认为代理所拥有的当前租赁状态的副本，而状态机将确定在不同时间哪个字段具有权威性。服务器和代理会不断地交换状态对象并协调差异，直至协调一致；此时，代理会确认它正在接受服务器添加的新租赁，而服务器也会确认代理对已解除租赁的完成。

在Horde服务器中，租赁是通过实现 `ITaskSource` 的类分配给代理的。

## 租赁类型

每种租赁类型都由以下关键类组成：

- 一条用于定义租赁本身的消息（即代理需要执行的操作），
- 服务器上用于决定将租期分配给代理的任务源（

  ITaskSource

  ），
- 代理上用于执行该工作的租赁处理程序（

  LeaseHandler

  ）。

Horde附带以下租赁类型：

| 消息 | 任务源（服务器） | 租赁处理程序（代理） | 说明 |
| --- | --- | --- | --- |
| `job_task.proto` | `JobTaskSource` | `JobHandler` | 执行批处理，将其作为CI作业的一部分。 |
| `upgrade_task.proto` | `UpgradeTaskSource` | `UpgradeHandler` | 将Horde代理软件升级到新版本。 |
| `conform_task.proto` | `ConformTaskSource` | `ConformHandler` | 将机器上的所有工作空间同步到最新状态，并可选择删除未追踪的文件。 |
| `restart_task.proto` | `RestartTaskSource` | `RestartHandler` | 重新启动机器。 |
| `shutdown_task.proto` | `ShutdownTaskSource` | `ShutdownHandler` | 关闭机器电源。 |

## 添加新租赁类型

要添加一种新租赁类型，必须添加上文提及的每一种关键类。

- 将任务源添加到服务器后，在

  Startup.cs

  中将其注册为实现

  ITaskSource

  的单例。
- 将租赁处理程序添加到代理后，在

  Program.cs

  中将其注册为实现

  LeaseHandler

  的单例。

---
title: "Horde术语表"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-glossary-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde术语表"]
---

# Horde术语表

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde术语表

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-glossary-for-unreal-engine

Acl操作

在Horde中对实体执行某些操作的能力，例如 `ViewJob` 或 `DownloadTool`。 请参阅 [配置 > 模式 > AclActions](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/horde-schema-for-unreal-engine?application_version=5.5#aclactions) 以获取完整列表。

Acl范围

用于指代Horde的层级权限系统中的某一个层。 作业是流中的一个acl范围，流是项目中的一个acl范围，而项目则是全局权限范围中的一个acl范围。 执行操作的权利通常从父范围继承到子范围，除非通过在 [AclConfig](https://dev.epicgames.com/documentation/zh-cn/unreal-engine/horde-schema-for-unreal-engine?application_version=5.5#aclconfig) 中将 `inherit` 属性设置为false来明确禁止。

Acl配置文件

可以授予用户的各个操作的列表，这样就无需每次单独列出每个操作。 类似于宏。

Blob

一种不透明的字节流，以及对其他blob的一组外部引用。

BuildGraph

Epic Games用于大规模构建管线的脚本语言（例如对游戏进行编译、烘焙以及打包，以便在多个平台上运行）。 描述了生成构件的各个节点之间的参数化依赖关系图。 Epic在内部使用BuildGraph制作虚幻引擎构建和Fortnite构建，并围绕它们运行所有自动化。 Horde在从模板创建的作业中执行BuildGraph脚本。

代理

远程机器上的一项服务，可以连接到Horde服务器，能够收到要执行的工作。

作业

在特定变更列表上使用某些参数运行的模板实例。

作业批处理

作业中的一组步骤，在单台机器上（租赁中）使用同步的工作空间按顺序运行。 批处理中的步骤可能相互依赖，也可能不相互依赖。

作业步骤

可以成功或失败的工作单位，用于追踪节点的执行情况。

分析

数据收集和分析的总称。

后端

特定命名空间的底层存储提供者。 Horde系统支持多种类型的后端，从本地磁盘到云对象存储均包括在内。

命名空间

存储系统的逻辑分区，可以拥有自定义权限、行为和垃圾回收策略。

声明

用于对该用户进行声明的键/值字符串对。 声明是OAuth2标准的一部分，身份提供程序为用户维护唯一的声明列表。 为了防止不同应用程序之间的冲突，键通常使用带有自有域名的URI，以确保全局唯一性，但URI并不标识实际的Web资源。 Horde内部发布的声明都以 `http://epicgames.com/ue/horde` 开头。

引用

对blob的具名引用。 引用通常是客户端应用程序访问存储系统的入口点。 未通过ref进行直接或间接引用的blob将被垃圾回收。

持续交付（CD）

持续交付（'Continuous Delivery'）的简称；通过构建自动化持续生成产品的新构建的过程。

持续集成（CI）

通过构建自动化，持续验证提交到代码库的一系列变更的过程。

指标

从遥测事件中计算的聚合数据，这些遥测事件与特定时间间隔的一组配置标准相匹配。

数据包

一组blob的容器，被写入底层存储系统。 数据包支持压缩，可以减少小对象的存储开销。

权利

用户执行某项操作的能力。

标签

对一组节点进行注解，其结果可以作为一个单元进行监控。 标签在Horde操作面板上突出显示，显示有关构建哪些部分成功或失败的信息。

模板

描述运行特定BuildGraph脚本的选项，并指定如何执行该脚本的参数。

目标

指定用户希望在BuildGraph脚本中执行的节点和聚合。

租赁

分配给代理执行的一个单元。

聚合

为图中一组节点赋予的名称，作为简称。

节点

BuildGraph脚本中的一个工作单元。 每个节点可能依赖于任何其他节点或构建输出，并执行一系列操作以生成输出。 节点作为作业步骤执行。

遥测

应用程序发送到Horde服务器的各个事件。 Horde将遥测事件作为无模式JSON对象进行处理。

预提交

设计用于在用户提交变更之前运行的一套测试。

预检

在通过Perforce的搁置集（shelf）提交之前，运行构建以测试变更内容。

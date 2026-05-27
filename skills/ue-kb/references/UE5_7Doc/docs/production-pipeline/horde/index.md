---
title: "Horde"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde"]
---

# Horde

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-in-unreal-engine

**Horde** 是一组支持工作流程的服务。Epic Games在开发《堡垒之夜》、虚幻引擎和其他项目时使用了它。

## 功能

Horde提供以下功能，其中大部分可以独立启用或禁用：

- 远程执行

  ：该功能可将计算工作分摊到其他计算机，包括使用

  虚幻构建加速器

  进行C++编译。
- 构建自动化(CI/CD)

  ：一种构建自动化系统，为使用大型Perforce仓库的团队设计。
- 测试自动化

  ：用于跨流和项目查询自动化结果的前端，与

  自动化工具

  和

  Gauntlet

  集成。
- Studio分析

  ：从虚幻编辑器接收遥测并显示关键工作流程指标图表。
- UnrealGameSync元数据服务器

  ：为使用

  UnrealGameSync

  的团队提供的各种功能，包括构建状态报告、评论聚合和众包构建健康功能。
- 移动/主机设备管理器

  ：一种用于分配和管理大量开发工具包和移动设备的系统。

## 目标与原理

### 一己之见

我们根据Epic Games长期以来的工作流程和最佳实践创建了Horde。它们不是唯一的方法，也不见得适合所有人。彻底的泛用化不是Horde的目标。我们相信系统和工具使用场景间的交互提供了为创作者创建丝滑工作流程的丰富机会。

### 易于部署

我们在构件Horde的过程中，已尽力减少了其运行所需的设置。尽管你可以实现非常复杂的、由多台计算机组成的分布式部署方法，但我们力求在我们支持的所有台式机平台上实现可在本地轻松运行和调试的方案，只需安装少量的依赖项即可。如果你没有设置过数据库，它将为你创建本地数据库，所有必须的服务都将根据服务器的生命周期自动启动和停止。

### 易于管理

对于像Horde这样的项目，我们控制着其源代码，同时又能将其用于高节奏的开发环境中，这让我们能够针对自身的易用性需求对其进行优化。我们与我们的运营团队保持着紧密沟通，并尽可能让他们的工作变得简单。因此，你可以将大部分配置数据存储在源代码中，并且我们提供了内置的分析和性能工具。

### 私密性强

我们不会用Horde托管你的数据，也不会从用户部署接收任何遥测数据。你可以将其托管在符合你IT政策的私有网络中，并将其与你自己的OpenID连接（OIDC）身份延供应商整合，以进行访问。

### 可伸缩

我们会分发所有Horde客户端和服务器功能的完整源代码。

## 开始使用Horde

在开始使用前，请先下载[Horde Windows MSI安装包](https://github.com/EpicGames/UnrealEngine/releases/download/5.5.0-release/UnrealHordeServer.msi)。

> [!NOTE]
> 这需要访问EpicGames的GitHub库。如果你需要访问权限，请按[在GitHub上访问虚幻引擎源代码](https://www.unrealengine.com/ue-on-github)页面上的指示操作。

下载Horde后，我们建议你根据自身需求先浏览以下教程：

- 安装Horde代理
- 使用虚幻构件加速器启用远程C++编译
- 设置构建自动化
- 使用Gauntlet启用测试自动化
- 为团队获取遥测和分析数据
- 在移动和主机设备上使用
- 安装UnrealGameSync并在团队内分发虚幻编辑器
- 启用身份验证

## 主题目录

- [Horde部署](horde-deployment/index.md) - 关于部署Horde以与虚幻引擎配合使用的概述。

- [Horde配置](horde-configuration/index.md) - 与虚幻引擎配合使用的Horde配置选项概述。

- [Horde内部机制](horde-internals/index.md) - 与虚幻引擎配合使用的Horde内部机制概述。

- [Horde教程](horde-tutorials/index.md) - 配合虚幻引擎使用Horde的教程概览。

- [Horde常见问题解答](horde-frequently-asked-questions/index.md) - Horde与虚幻引擎协同使用的常见问题解答。

- [Horde术语表](horde-glossary/index.md) - 关于Horde与虚幻引擎配合使用的术语表。

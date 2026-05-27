---
title: "启用和配置在线服务EOS"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/enable-and-configure-online-services-eos-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务EOS", "启用和配置在线服务EOS"]
---

# 启用和配置在线服务EOS

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务EOS / 启用和配置在线服务EOS

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/enable-and-configure-online-services-eos-in-unreal-engine

在线服务插件及其接口提供了一种通用的方式来访问各种在线服务的功能，尤其是Epic在线服务（EOS）的功能。要通过在线服务插件利用EOS，你可以使用在线服务EOSGS和在线服务EOS插件。除了概括这些插件之间的差异及其各自支持的接口，本页面还介绍了如何启用和配置这些插件以在你的虚幻引擎项目中使用。

## 插件结构

在线服务插件的EOS实现分为单独的插件：

- 在线服务EOSGS
- 在线服务EOS

Epic在线服务游戏服务（EOSGS）插件处理[EOS游戏服务](https://dev.epicgames.com/docs/game-services)功能。在线服务Epic在线服务（EOS）插件补充EOSGS插件并处理[EOS Epic账号服务](https://dev.epicgames.com/docs/epic-account-services)功能。要利用EOS游戏服务和EOS Epic账号服务，你可以同时在项目中使用这两个插件。

### 实现的接口

下表列出了这些插件实现的接口：

| **接口** | **在线服务EOSGS** | **在线服务EOS** |
| --- | --- | --- |
| [成就](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [身份验证](https://dev.epicgames.com/documentation/404) | ✓ | ✓ |
| [商务](https://dev.epicgames.com/documentation/404) |  | ✓ |
| [外部UI](https://dev.epicgames.com/documentation/404) |  | ✓ |
| [排行榜](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [大厅](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [在线状态](https://dev.epicgames.com/documentation/404) |  | ✓ |
| [会话](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [社交](https://dev.epicgames.com/documentation/404) |  | ✓ |
| [统计数据](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [作品文件](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [用户文件](https://dev.epicgames.com/documentation/404) | ✓ |  |
| [用户信息](https://dev.epicgames.com/documentation/404) |  | ✓ |

## 选择在线服务或在线子系统

在线服务EOSGS和EOS插件是在线子系统插件的改进版，像在线子系统EOS为在线子系统实现Epic在线服务软件开发工具包（EOS SDK）那样为在线服务实现EOS SDK。如需详细了解哪个适合你的项目，请参阅[在线服务概述](https://dev.epicgames.com/documentation/404)文档的[使用在线服务或在线子系统](https://dev.epicgames.com/documentation/404)小节。

## 启用在线服务EOS插件

要在你的虚幻引擎项目中启用在线服务EOSGS或在线服务EOS，请执行以下步骤：

1. 创建或打开虚幻引擎C++项目。
2. 在虚幻编辑器菜单栏中，找到

   编辑（Edit）> 插件（Plugins）

   。这会打开名为

   插件（Plugins）

   的新窗口或选项卡。
3. 在此新窗口中，从左侧的导航栏搜索"Online Services"或选择

   在线平台（Online Platform）

   类别。

   - 界面上应该会显示若干插件。

     在线服务（Online Services）

     基础插件应该会默认启用。
4. 启用你想使用的插件：

   - 在线服务EOS（Online Services EOS）
   - 在线服务EOSGS（Online Services EOSGS）

> [!NOTE]
> 界面上应该会显示一条警告消息，称"你必须重启虚幻编辑器才能使更改生效（You must restart Unreal Editor for your changes to take effect）"。如果你启用了所需的所有插件并准备好重启虚幻编辑器，请点击 **立即重启（Restart Now）** 。

你之前启用的在线服务EOS插件现在应该可以在虚幻引擎项目中使用了。

## 开发者门户

要利用在线服务EOS插件，你必须使用Epic在线服务注册并配置组织和产品。你的EOS产品是在线服务EOS插件为了在你的游戏与Epic在线服务之间传达信息而连接的对象。阅读[开发者门户](https://dev.epicgames.com/docs/dev-portal)中的Epic开发者文档，使用Epic在线服务注册你的组织和产品。

## 配置虚幻引擎

### 默认服务

要在你的项目中使用Epic在线服务，你需要配置在线服务基础插件配置以使用EOS实现。要将EOS指定为默认平台服务，请找到项目的Config目录，在项目的 `DefaultEngine.ini` 文件中添加或编辑以下分段：

```
[OnlineServices]DefaultServices=Epic
```

### 网络驱动程序

网络驱动程序配置独立于在线系统，因此相同配置应该对在线服务插件和在线子系统插件同样有效。

要配置在线系统的网络驱动程序，请将以下内容添加到你的项目的 `DefaultEngine.ini` 文件：

```
[/Script/Engine.Engine]!NetDriverDefinitions=ClearArray+NetDriverDefinitions=(DefName="GameNetDriver",DriverClassName="SocketSubsystemEOS.NetDriverEOSBase",DriverClassNameFallback="OnlineSubsystemUtils.IpNetDriver")+NetDriverDefinitions=(DefName="DemoNetDriver",DriverClassName="/Script/Engine.DemoNetDriver",DriverClassNameFallback="/Script/Engine.DemoNetDriver") [/Script/Engine.GameEngine]!NetDriverDefinitions=ClearArray+NetDriverDefinitions=(DefName="GameNetDriver",DriverClassName="SocketSubsystemEOS.NetDriverEOSBase",DriverClassNameFallback="OnlineSubsystemUtils.IpNetDriver")+NetDriverDefinitions=(DefName="DemoNetDriver",DriverClassName="/Script/Engine.DemoNetDriver",DriverClassNameFallback="/Script/Engine.DemoNetDriver")
```

### Epic在线服务

在线服务EOSGS和EOS插件使用EOS SDK与Epic在线服务后端通信。为了使你的项目能够如[Epic开发者门户](https://dev.epicgames.com/portal/)中所配置那样直接与你的EOS产品通信，你必须配置在线服务插件。

要将你的EOS产品与你的虚幻引擎项目连接，请将以下内容添加到你的项目的 `DefaultEngine.ini` 文件：

```
[OnlineServices.EOS]ProductId=PRODUCT_IDSandboxId=SANDBOX_IDDeploymentId=DEPLOYTMENT_IDClientId=CLIENT_IDClientSecret=CLIENT_SECRETClientEncryptionKey=CLIENT_ENCRYPTION_KEY
```

其中你需要将 `PRODUCT_ID` 、 `SANDBOX_ID` 、 `DEPLOYMENT_ID` 、 `CLIENT_ID` 和 `CLIENT_SECRET` 替换为[Epic开发者门户](https://dev.epicgames.com/portal/)中你的产品的产品设置页面上列明的值。

下表说明了其中每个设置：

| **设置** | **说明** |
| --- | --- |
| 产品ID | EOS SDK使用此ID识别你的产品。 |
| 沙盒ID | 产品属于带有此ID值的沙盒。 |
| 部署ID | 你要作为目标的部署ID。 |
| 客户端ID | 你的产品的客户端ID。此ID以3个字符xyz作为开头。 |
| 客户端密钥 | 用于验证你的客户端ID的客户端密钥。 |
| 客户端加密密钥 | 64字节的十六进制字符串，用于加密上传到EOS服务的数据。不同于其他设置，EOS不管理此加密密钥，该密钥不会存储在你的产品设置中。此密钥特定于你的游戏，Epic Games并不知道密钥，以便保护用户的数据隐私。它用于加密玩家和作品数据存储的数据。 如果你不使用玩家或作品文件存储，可以使用以下值作为默认加密密钥（64个1）：`1111111111111111111111111111111111111111111111111111111111111111` 。如果你要使用玩家或作品文件存储，请自行选择不同于此默认密钥的密钥，并将其保密。 |

## 后续步骤

你的项目现在应该被配置为使用在线服务EOS了。下一步就是在你的游戏中实现Epic在线服务，其中第一步是登录。

## 其他信息

如需更多信息，请参阅以下文档页面：

- Epic开发者门户网站上的文档：

  - Epic在线服务
  - EOS游戏服务
  - EOS Epic账号服务
  - Epic开发者门户
- 虚幻引擎文档网站上的文档：

  - 在线服务插件
  - 在线服务概述
  - 使用在线服务插件

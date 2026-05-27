---
title: "Commerce Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/commerce-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Commerce Interface"]
---

# Commerce Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Commerce Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/commerce-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Online Services Commerce 接口** 是 Unreal Engine 中所有游戏服务的基础，这些服务为玩家提供在 Gameplay 之外购买或兑换游戏内容的能力。Commerce 接口由两个主要组件组成：

- **交易**：使用平台货币购买商店物品的过程。

  - 交易完成后，该接口会向玩家授予对应 entitlement。
- **Entitlement**：玩家有权接收或使用的内容。

  - 玩家可能因购买物品或兑换游戏代码而接收或使用 entitlement。

## API 概述

下表概述 Commerce 接口包含的函数。

| 函数 | 说明 |
| --- | --- |
| **商品** |  |
| [QueryOffers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/QueryOffers?application_version=5.5) | 从商店获取所有可用 offer 列表，并将其缓存在接口中。这包括任何可用的可下载内容（DLC）、捆绑包、物品等。 |
| [QueryOffersById](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/QueryOffersById?application_version=5.5) | 从所提供 ID 列表中获取可用 offer 列表，并将其缓存在接口中。 |
| [GetOffers](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/GetOffers?application_version=5.5) | 获取由以下函数缓存在接口中的 offer： `QueryOffers`. |
| [GetOffersById](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/GetOffersById?application_version=5.5) | 从已缓存在接口中的所提供 ID 列表获取 offer。 |
| **商店** |  |
| [ShowStoreUI](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/ShowStoreUI?application_version=5.5) | 显示原生商店 UI，使用户能在游戏客户端之外查看商店信息或处理交易。 |
| **结账** |  |
| [结账](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/Checkout?application_version=5.5) | 使用通过以下函数获取的一个或多个购买 offer 发起购买流程： `GetOffers` 或 `GetOffersById`. |
| **事件监听** |  |
| [OnPurchaseCompleted](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/OnPurchaseCompleted?application_version=5.5) | 本地用户完成交易时触发的事件。该交易可由内部 `结账` 发起，也可通过原生商店 UI 从外部发起。 |
| **Entitlement** |  |
| [QueryTransactionEntitlements](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/QueryTransactionEntitlements?application_version=5.5) | 查看与成功 `结账` 调用对应的游戏内 entitlement，以向玩家提供这些权益。 |
| [QueryEntitlements](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/QueryEntitlements?application_version=5.5) | 从商店获取特定用户已获得的 entitlement 列表，并将其缓存在接口中。 |
| [GetEntitlements](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/GetEntitlements?application_version=5.5) | 获取由以下函数缓存在接口中的 entitlement： `QueryEntitlements`. |
| [RedeemEntitlement](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/RedeemEntitlement?application_version=5.5) | 将 entitlement 标记为“redeemed”。之后查询时，该 entitlement 会带有 redeemed 标志。当没有外部游戏服务管理 entitlement 时，这很有用。 |
| **验证** |  |
| [RetrieveS2SToken](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ICommerce/RetrieveS2SToken?application_version=5.5) | 返回一个 token，可发送到游戏服务后端，用于与平台通信并验证给定 entitlement 的所有权。 |

## 流程

下面提供一个使用 Online Services Commerce 接口的示例流程，展示用户启动游戏、进入游戏内商店购买并验证该购买以供使用的流程。

### 启动游戏

用户启动游戏并成功通过所需在线服务认证后，游戏调用 `QueryEntitlements`。游戏会比较由 `QueryEntitlements` 缓存的数据与用户存档数据中注册的 entitlement，以判断用户离线期间授予了哪些 entitlement，并将其适当地应用到用户。同时，游戏使用 OnPurchaseCompleted 事件监听用户未来完成购买时的消息。

### 进入游戏内商店界面

用户在游戏中打开商店菜单。游戏在调用 QueryOffers 时为打开商店的用户显示加载画面。查询完成后，游戏调用 GetOffers 获取数据的本地副本。随后，本地副本会传递给 UI 框架，用于渲染并显示游戏 offer。

### 执行交易

查看可购买物品后，用户决定购买特定产品，此处称其为 `PRODUCT_A`。用户将 `PRODUCT_A` 加入游戏内购物车（由游戏内 UI 处理）并确认交易。认证用户后，游戏调用 `结账` ，并传入 `PRODUCT_A`的 ID。这会进入平台 UI，以完成最终确认和支付处理。

当 `结账` 成功完成并触发 `OnPurchaseCompleted` 事件后，游戏调用 `QueryTransactionEntitlements` ，传入给定交易 ID，以获取作为该交易一部分授予用户的游戏内 entitlement ID，并将其应用到用户存档。如果 `PRODUCT_A` 不应全局授予给用户 Gameplay，游戏随后调用 `RedeemEntitlement` 以确保 `PRODUCT_A` 的 entitlement 不会重复。

### 验证交易

成功购买并兑换 `PRODUCT_A`后，用户决定使用新购买的 `PRODUCT_A`进入在线游戏。在游戏服务器认证期间，游戏发现本地用户正在声明新的 entitlement，于是请求验证 token，以确保该产品合法。游戏调用 `RetrieveS2SToken` 并传入用于验证的 ID，获取 JSON Web Token（JWT）。后端服务随后使用该 token 连接到平台服务，并验证产品所有权。成功返回后，用户即可带着新购买物品进入在线游戏。

## 从 Online Subsystem 转换代码

Online Services Commerce 接口负责来自 **商店** （只读代码）和 **Purchase** （读/写代码）接口的所有代码，这些接口来自 [Online Subsystem](../../../online-subsystem/index.md)。下表展示 Online Services Commerce 接口中的对象与旧 Online Subsystem 中对应对象之间的关系。

| Online Services |  | Online Subsystem |  |
| --- | --- | --- | --- |
| **接口** | **对象** | **接口** | **对象** |
| Commerce | Offer | [商店](../../../online-subsystem/online-subsystem-store-interface/index.md) | Offer |
| Commerce | Entitlement | [Purchase](../../../online-subsystem/online-subsystem-purchase-interface/index.md) | Entitlement |

## 更多信息

### 头文件

可按需直接查看 `Commerce.h` 头文件以获取更多信息。Commerce 接口头文件 `Commerce.h` 位于以下目录：

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

关于如何获取 UE 源代码的分步指南，请参阅文档： [下载 Unreal Engine 源代码](../../../../../get-started/install/downloading-source-code/index.md).

### 函数参数和返回类型

请参阅 [函数](../../overview-of-online-services/index.md#functions) 章节，该章节位于 Online Services Overview 页面，其中解释了函数参数和返回类型，包括如何传递参数以及函数返回时如何处理结果。

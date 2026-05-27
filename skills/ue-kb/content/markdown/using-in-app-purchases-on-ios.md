# Using In-App Purchases on iOS

---
title: "Using In-App Purchases on iOS"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-use-inapp-purchases-in-unreal-engine-projects-on-ios"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS", "iOS和tvOS开发指南", "Using In-App Purchases on iOS"]
---

# Using In-App Purchases on iOS

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS / iOS和tvOS开发指南 / Using In-App Purchases on iOS

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-use-inapp-purchases-in-unreal-engine-projects-on-ios

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

应用内购买可让你向用户提供额外内容和功能。可以将其用作免费应用变现方式，也可以为应用提供额外付费内容。本页提供 iOS 特定信息，但你必须熟悉 [使用应用内购买](../../../in-app-purchases-and-ads-in-unreal-engine-projects/using-inapp-purchases-in-unreal-engine-projects-fe38e4e5/index.md) 文档中描述的通用应用内购买信息。

## Apple App Store 详情

下方信息在某些情况下较为概括。请查看官方 [App Store](https://developer.apple.com/documentation/appstoreconnectapi/app-store) and [StoreKit](https://developer.apple.com/documentation/storekit) 文档以了解更多细节。

## 查询产品信息

应用内产品通过字符串形式的产品 ID 标识，该 ID 是在 `AppStoreConnect`.

中为应用的每个产品配置的。StoreKit 以相同方式处理应用内产品或订阅的购买发起。发起某个产品购买前，需要先在某个时刻查询其更新信息，因为该查询产生的一些内部对象会用于触发购买流程。可以使用 **Read In App Purchase Information2** 蓝图节点或 `IOnlineStore::QueryOffersById` 在 C++ 中查询产品信息。

> [!NOTE]
> 如果由于 API 变化导致本文描述的方法无法工作，可以查看 [App Store Server APIs](https://developer.apple.com/documentation/appstoreserverapi) 以找到适合服务器验证的 API；可以在服务器端检查订阅状态，也可以使用 [App Store Server Notifications](https://developer.apple.com/documentation/appstoreservernotifications).

## 验证

应验证 receipt 以避免欺诈。请查看 [关于 receipt 验证的官方文档](https://developer.apple.com/documentation/storekit/choosing-a-receipt-validation-technique) 了解更多信息。

请注意，使用本地验证时无法检查订阅状态和过期时间。可以使用 [Get Transaction Info endpoint](https://developer.apple.com/documentation/appstoreserverapi/get-transaction-info)收集验证信息，也可以使用 [Get All Subscription Statuses endpoint](https://developer.apple.com/documentation/appstoreserverapi/get-all-subscription-statuses).

验证通过且产品授予后，应在设备本地完成所有交易。可以通过调用 `IOnlinePurchase::FinalizePurchase` 或使用 **Finalize In-App Purchase Transaction** 蓝图节点对已完成 receipt 执行此操作。不完成交易可能导致设备性能不佳。

## 产品类型

App Store 区分消耗型应用内产品、非消耗型应用内产品和订阅。它们的交易都以相同方式处理，并且完成后都需要 finalize。自动续订订阅每次续订都会生成新的 receipt。

## Receipt 和 Receipt 持久性

任何时候都只能收集未完成交易的 receipt。一旦通过调用 `IOnlinePurchase::FinalizePurchase` 或使用 Finalize **In-App Purchase Transaction** 蓝图节点完成交易，后续 receipt 查询就不会再为其生成 receipt。因此，必须始终记录已授予用户的产品。

订阅续订时会生成新的 receipt。要在游戏运行时检测这些事件，可以注册到 `OnUnexpectedPurchaseReceipt` 委托。之后查询 receipt 的调用会包含新的 receipt，直到它被处理并 finalize。

成功的延迟和中断购买也会通过 `OnUnexpectedPurchaseReceipt`通知。这些类型的交易最初会生成一个带 deferred 或 canceled 状态的失败 receipt，并在成功时生成新的成功交易。

请参阅 [StoreKit 官方文档](https://developer.apple.com/documentation/storekit/testing-in-app-purchases-with-sandbox) 了解更多信息。

每个 line item 的 receipt 中存储的 ValidationInfo 包含一个 FString，其中含有应当用于验证的 Base64 编码 AppReceipt。

### 订阅过期管理

设备上无法获取订阅状态和过期时间。Receipt finalize 后，不再有关于可能活动订阅的信息。可以在服务器端使用 [Get All Subscription Statuses endpoint](https://developer.apple.com/documentation/appstoreserverapi/get-all-subscription-statuses).

StoreKit 不会以任何方式向设备通知订阅过期、取消或退款。Apple 提供 [App Store Server Notifications](https://developer.apple.com/documentation/appstoreservernotifications) 以在服务器端检测这些事件。

### 测试应用内购买

可以使用 [Xcode 中的 StoreKit 测试](https://developer.apple.com/documentation/xcode/setting-up-storekit-testing-in-xcode/) 或沙盒环境测试应用内购买。Xcode 中的 StoreKit 测试不要求在 App Store Connect 应用中配置应用内产品；但如果已经设置，则可导入配置并在本地环境使用。应用必须从 Xcode 启动，并且有一些工具可控制交易生命周期。

一个 [沙盒环境](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox) 使用真实产品信息，可用于测试服务器到服务器交易。要使用沙盒环境，需要设置 Sandbox Apple ID，并使用在 App Store Connect 中正确配置的开发签名应用。

### 恢复交易

任何时候都可以使用 **Restore Owned In-App Products** 蓝图节点，或调用 `IOnlinePurchase::QueryReceipts` 并将 `bRestore` 参数设置为 true 来恢复交易。在这种情况下会触发恢复交易操作，为过去成功完成的每个非消耗型或订阅交易缓存 receipt，包括订阅续订。在新设备上使用同一 App Store 凭据时，这有助于恢复完整交易列表。

标记为 Restored 的 receipt 不需要 finalize。

## 配置

1. 在 iTunes Connect 中设置应用内购买：Google Play 要求 id 全部为小写，并且最好让 iOS 和 Android 的 ID 尽可能一致，以便简化蓝图设置。

   ![Sample product for testing](../../../../../assets/images/e5/e53382b42c7b331847799b28673c5fa117a5ea902d2af343e0ffd72c9c19173a.jpg)
2. 记录使用的 ID，并记录该物品是消耗型、非消耗型还是订阅。

   1. 订阅的 Product ID 可直接用于 iOS 实现，而 Google Play 实现有一些特定细节。
3. 如果使用代码项目，并且尚未设置项目使用 online subsystem，请将以下代码块添加到项目的 `Build.cs` 文件：

   C#

   ```
   if (Target.Platform == UnrealTargetPlatform.IOS){    PrivateDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "OnlineSubsystem" });    DynamicallyLoadedModuleNames.Add("OnlineSubsystemIOS");}
   ```
4. Edit `[ProjectName]/Config/IOS/IOSEngine.ini`:

   Config

   ```
   [OnlineSubsystem]DefaultPlatformService=IOS [OnlineSubsystemIOS.Store]bSupportsInAppPurchasing=True
   ```
5. 蓝图节点需要正确启用 `OnlineIdentity` 。要使用 GameCenter，请编辑 `[ProjectName]/Config/DefaultEngine.ini`:

   Config

   ```
   [/Script/IOSRuntimeSettings.IOSRuntimeSettings]bEnableGameCenterSupport=True
   ```
6. Provisioning profile 的 AppID 必须匹配 App Store 应用 bundle ID，并且必须拥有 In-App Purchases entitlement。使用通配 provisioning profile 时，应用内购买无法工作。

如果配置应用内购买遇到困难，请参阅主应用内购买文档的 [故障排除章节](../../../in-app-purchases-and-ads-in-unreal-engine-projects/using-inapp-purchases-in-unreal-engine-projects-fe38e4e5/index.md#troubleshoot) 。


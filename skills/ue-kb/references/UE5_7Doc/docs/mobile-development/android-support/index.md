---
title: "Android支持"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/android-support-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持"]
---

# Android支持

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/android-support-for-unreal-engine

**虚幻引擎**支持将项目发布到**安卓（Android）**移动设备上，并且提供了若干功能帮你将项目发布到**Google Play商店**。 本节包含了如何设置Android开发环境、如何使用Android功能和服务、以及如何为发布游戏做准备相关的指南。

## 当前SDK要求

> [!WARNING]
> 自2024年8月31日起，Google Play商店要求应用程序针对Android 14进行适配，这需要API级别34。 要在Google Play商店发布新应用程序，你必须更新到UE 5.4.4或更高版本以支持目标SDK 34。 使用旧版虚幻引擎编译的应用程序将无法再成功提交。 如需更多信息，请参阅[Google Play关于目标API级别要求的Android文档](https://developer.android.com/google/play/requirements/target-sdk)。

- 当前UE版本：5.6
- Android Studio版本：Koala 2024.1.2 2024年8月29日
- Android SDK：

  - 推荐版本：SDK 34
  - 用于编译的最低版本：SDK 34
  - 用于在设备上发布的默认目标SDK版本：34
  - 最低安装SDK级别：26

    > [!NOTE]
    > 不同商城对于目标SDK最低版本的要求是不同的，可能与上文有所不同。
- NDK版本： r27c
- 编译工具：34.0.0
- Java运行时： OpenJDK 21.0.3 2024-04-16
- [AGDE调试](../debugging-and-optimization-for-mobile/debugging-for-android-devices/debugging-unreal-engine-projects-for-android-in-8ae85ef6/index.md)需要AGDE v23.2.91+。

## 当前设备兼容性

当前虚幻引擎版本支持满足以下规格的Android设备：

- Android 8或更高版本
- 64位Arm CPU
- UE 5.6支持4KB和16KB页面大小
- 兼容的GPU

  - Mali T8xx、G68、G71、G72、G76、G77、G78或G7xx系列
  - Adreno 5xx、6xx或7xx系列
  - PowerVR GM9xxx系列
  - 三星Xclipse 9xx系列
- 兼容的图形API

  - OpenGL ES 3.2
  - Vulkan 1.1（需要Android 10或更高版本的设备，以及兼容的驱动程序）

## 入门指南

- [Android快速入门](getting-started-and-setup-for-android-projects/setting-up-unreal-engine-projects-for-android-d-db209844/index.md) - Android平台的开发设置。
- [设置Android SDK和NDK](getting-started-and-setup-for-android-projects/advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md) - 如何为虚幻引擎设置你的Android开发环境
- [设置Android设备](getting-started-and-setup-for-android-projects/setting-up-your-android-device-for-developing-a-f537b307/index.md) - 了解如何设置Android设备以便开发虚幻引擎项目。
- [设置Android SDK和NDK](getting-started-and-setup-for-android-projects/set-up-android-sdk-ndk-and-android-studio-using-turnkey/index.md) - 安装Android Studio并自动添加SDK组件。

## 开发指南

- [使用 Google Play 成就](developing-guides-for-android/using-google-play-achievements-in-unreal-engine-projects/index.md) - 利用 Google Play 成就提升玩家粘着度。
- [在安卓上使用 Ad Mob 游戏内置广告](developing-guides-for-android/using-ad-mob-for-in-game-ads-on-android/index.md) - 在安卓上使用 AdMob 游戏内置广告系统。
- [Android Manifest控制](developing-guides-for-android/how-to-use-android-manifest-control-in-unreal-e-dab1e268/index.md) - 设置及使用Android Mainfest文件。
- [使用安卓内购](developing-guides-for-android/how-to-use-inapp-purchases-in-unreal-engine-pro-0bff4afb/index.md) - 利用内购为安卓游戏增加更多付费内容。
- [使用 Google Play Services 排行榜](developing-guides-for-android/using-google-play-services-leaderboards-in-unre-8e14b830/index.md) - 在游戏中使用排行榜。
- [Android虚拟键盘](developing-guides-for-android/setting-up-android-virtual-keyboard-in-unreal-e-fcc05e81/index.md) - 了解如何设置Android虚拟键盘以在UE5中使用。
- [Android开发参考](developing-guides-for-android/android-development-basics/index.md) - 如何安装不同的Android SDK，设置环境变量，以及使用纹理格式。
- [Android Vulkan移动渲染器](developing-guides-for-android/using-the-android-vulkan-mobile-renderer/index.md) - 介绍Vulkan兼容性以及如何在Android项目中使用移动渲染
- [设置安卓运行画面](developing-guides-for-android/setting-up-android-launch-screens/index.md) - 安卓项目自定义可选运行画面设置的总览。

## 打包和发布

- [项目发布签名](packaging-and-publishing-android-projects/signing-android-projects-for-release-on-the-goo-0fa305d2/index.md) - 为项目上架 Google Play 商店做好准备。
- [Google Play资产交付参考](packaging-and-publishing-android-projects/using-google-play-asset-delivery/index.md) - 有关Google PAD API的参考和实现指南
- [打包Android项目](packaging-and-publishing-android-projects/packaging-android-projects/index.md) - 介绍如何打包最终Android项目。
- [安卓配置规则系统](packaging-and-publishing-android-projects/using-the-android-configuration-rules-system/index.md) - 介绍如何在虚幻引擎项目中设置安卓配置规则系统。
- [关于Android项目的自定义设备描述和伸缩性](packaging-and-publishing-android-projects/customizing-device-profiles-and-scalability-in-e75f27cc/index.md) - 设备描述规则和可伸缩性设置的参考。

## 调试

- [调试Android项目](../debugging-and-optimization-for-mobile/debugging-for-android-devices/debugging-unreal-engine-projects-for-android-us-3a4e6274/index.md) - 了解如何使用Android Studio调试Android项目。
- [在Visual Studio中使用AGDE调试](../debugging-and-optimization-for-mobile/debugging-for-android-devices/debugging-unreal-engine-projects-for-android-in-8ae85ef6/index.md) - 使用AGDE在Visual Studio中调试Android项目
- [Android文件服务器](../debugging-and-optimization-for-mobile/debugging-for-android-devices/android-file-server/index.md) - 使用Android文件服务器代替ADB来推送和编辑虚幻引擎项目的文件。
- [Android Emulator](../debugging-and-optimization-for-mobile/debugging-for-android-devices/debugging-unreal-engine-projects-with-virtual-d-ad0e0d85/index.md) - Use the Android Emulator to launch a virtual device, then test your Unreal Engine apps on it.

## 优化

- [为Android创建捆绑的PSO缓存](../debugging-and-optimization-for-mobile/optimization-guides-for-android/creating-bundled-pso-caches-for-android/index.md) - 为Android设备创建捆绑的PSO缓存的逐步操作说明。
- [Android设备上的Unreal Insights](../debugging-and-optimization-for-mobile/optimization-guides-for-android/how-to-use-unreal-insights-to-profile-android-games/index.md) - 将Unreal Insights诊断工具附加到在测试设备上运行的Android应用程序的分步骤指南。
- [降低安卓二进制文件大小](../debugging-and-optimization-for-mobile/optimization-guides-for-android/reducing-android-binary-size-in-unreal-engine-projects/index.md) - 了解如何缩小安卓平台项目的二进制文件。

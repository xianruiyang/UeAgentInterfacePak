# 补丁和DLC

---
title: "补丁和DLC"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/patching-content-delivery-and-dlc-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "补丁和DLC"]
---

# 补丁和DLC

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 补丁和DLC

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/patching-content-delivery-and-dlc-in-unreal-engine

**虚幻引擎** 可以将内容分割成 **.pak** 文件并将其与主要可执行文件分开交付给用户。此功能支持DCL和修补，以提供实时服务。

## 一般信息

以下页面包含有关 **虚幻引擎** 烘焙和分块过程、如何准备.pak文件以便发布的通用信息，以及有关安装文件块的参考信息。

- [准备资产进行分块](general-patching-information/preparing-assets-for-chunking/index.md) - 如何将资产分成块并将其烘焙成打包文件

- [打补丁概述](general-patching-information/updating-unreal-engine-projects-with-patches-af-7af36ffd/index.md) - 创建更新的内容包，允许您在发布后更新项目。

- [如何创建补丁（与平台无关）](general-patching-information/how-to-create-a-patch/index.md) - 本页面介绍如何为现有项目创建补丁。

## 文件块下载程序插件

**ChunkDownloader** 插件一种通用修补解决方案，适用于需要交付大量小文件的游戏。

- [设置ChunkDownloader插件](using-chunkdownloader-for-patching-unreal-e-c18ea429/setting-up-the-chunkdownloader-plugin/index.md) - 介绍如何设置项目设置以便使用ChunkDownloader

- [托管ChunkDownloader的清单和资产](using-chunkdownloader-for-patch-c18ea429/hosting-a-manifest-and-assets-for-chunkdownloader/index.md) - 设置本地主机网站

- [在游戏中实现ChunkDownloader](using-chunkdownloader-for-patching-c18ea429/implementing-chunkdownloader-in-your-gameplay/index.md) - 如何使用Visual Studio和蓝图将ChunkDownloader集成到你的项目中，以及如何在本地机器上测试该系统。

## Google Play资产交付 (GooglePAD)

**GooglePAD** 插件使用Google Play商店中的Google **Play资产交付（Play Asset Delivery）** 系统。此修补解决方案是 **Android App束（Android App Bundle）** 系统的配套工具，可以交付专为用户个人设备进行优化的自定义APK。

你可以在[Google Play资产交付参考](../../mobile-development/android-support/packaging-and-publishing-android-projects/using-google-play-asset-delivery/index.md)中阅读更多关于GooglePAD的文章。


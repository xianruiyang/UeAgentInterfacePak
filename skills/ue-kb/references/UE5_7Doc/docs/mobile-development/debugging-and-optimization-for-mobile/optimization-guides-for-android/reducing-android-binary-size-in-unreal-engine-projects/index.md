---
title: "降低安卓二进制文件大小"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/reducing-android-binary-size-in-unreal-engine-projects"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "虚幻引擎Android优化指南", "降低安卓二进制文件大小"]
---

# 降低安卓二进制文件大小

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / 虚幻引擎Android优化指南 / 降低安卓二进制文件大小

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/reducing-android-binary-size-in-unreal-engine-projects

移动应用商店通常会限制输往设备的数据流量，尤其是在使用移动数据下载游戏的时候。一些应用商店会对APK和OBB安装包的大小做出强制限制。因此，最好尽可能地缩小移动应用的大小。一些内容分发系统，比如 [Google Play资产交付](../../../android-support/packaging-and-publishing-android-projects/using-google-play-asset-delivery/index.md)和 [ChunkDownloader](../../../../sharing-and-releasing-projects/patching-content-delivery-and-dlc/using-chunkdownloader-for-patching-unreal-engine-games/index.md)可以通过将资产与二进制文件分开，显著缩小核心可执行文件的大小，不过，你仍可以通过缩减二进制文件来降低应用大小。

该页面将介绍 **虚幻引擎** 中可以用于优化安卓二进制文件的各种工具。

## 自UE4以来的变动

UE5包含了升级过的编译器和连接器标记，用于清除无效和重复的代码。一些UE4中的代码也在UE5中经过重新编写，使得占用空间进一步缩小。这些变动默认启用，不需要你进行任何操作。

## 高级优化

其他更高级的二进制文件优化只能用于特定的安卓SDK版本并且需要手动启用。可以在 **项目设置（Project Settings）** > **平台（Platforms）** > **安卓（Android）** 选项中更改最低SDK版本要求，也可以在 `*Engine.ini` 文件中这样更改：

```
	[/Script/AndroidRuntimeSettings.AndroidRuntimeSettings] 	MinSDKVersion=23
```

启用高级优化，将以下设置添加至你的 `*AndroidEngine.ini` 文件：

```
	[/Script/AndroidRuntimeSettings.AndroidRuntimeSettings] 	bEnableAdvancedBinaryCompression = true
```

然后，任何可用于你的SDK版本的优化都会应用于打包文件，包括以下优化。

### 用于安卓SDK 23或者更高

以下优化可以用于不低于23的安卓SDK版本。

#### GNU哈希和启动时间

使用SDK 23或更高版本的项目将使用新的GNU哈希ELF部分而不是旧格式，从而提供更好的性能和更短的启动时间。

#### APS重定位表压缩

除此之外，你的项目还将利用APS重定位表压缩（APS relocation table compression），这是一种Android特有的压缩格式。例如，在我们的测试中，大小为62 MB的重定位表可减少到约8MB。

#### APK压缩和.so二进制文件的直接加载

如果你将最低SDK版本设为23或更高，安卓系统可以直接从应用的APK加载`.so`二进制文件，不再需要将应用从APK中拆包然后安装到设备上。

虚幻引擎默认启用APK压缩，但是你也可以在`*Engine.ini`文件中通过以下配置变量来禁用它：

```
	[/Script/AndroidRuntimeSettings.AndroidRuntimeSettings] 	bExtractNativeLibs = false
```

如果将bExtractNativeLibs设为false，你的应用会跳过压缩直接读取`.so`二进制文件。然而，如果你的APK小于Google Play Store的150 MB 移动数据大小限制，建议将其停用，因为应用商店可以在用户下载你的应用程序时提供更好的动态APK压缩并减少你的应用造成的移动流量消耗。

如果你将其启用，生成的APK会比较小，但是安卓系统会解压并另外在设备上安装`.so`二进制文件，占用更多储存空间。但是，这样更适用Google Play Store以外的应用商店。

### 安卓SDK 28或者更高版本

以下优化可以用于不低于28的安卓SDK版本。

#### RELR重定位表压缩

对于使用不低于SDK 28版本的项目，可利用RELR重定位表压缩，它甚至比APS更高效。这会使二进制大小减少约两个数量级。例如，我们测试中的62 MB表减少到大约600 KB。RELR还能提供比APS更好的性能。

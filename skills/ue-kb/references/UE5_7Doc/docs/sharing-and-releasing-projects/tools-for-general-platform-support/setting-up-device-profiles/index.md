---
title: "设置设备描述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-device-profiles-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "常用平台支持", "设置设备描述"]
---

# 设置设备描述

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 常用平台支持 / 设置设备描述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-device-profiles-in-unreal-engine

设置指定设备配置的最佳方式是在项目中创建自定义的 `Config/DefaultDeviceProfiles.ini`。可在设备描述中设置纹理池尺寸等多种属性；推荐使用此方法在不同移动设备上或PC/Mac的可延展性设定桶中处理延展性。

```
	[iPhone5 DeviceProfile]	DeviceType=IOS	BaseProfileName=IOS	MeshLODSettings=	TextureLODSettings=	+CVars=r.RenderTargetSwitchWorkaround=1 	[iPhone5S DeviceProfile]	DeviceType=IOS	BaseProfileName=IOS	MeshLODSettings=	TextureLODSettings=	+CVars=r.MobileContentScaleFactor=2	+CVars=r.BloomQuality=1	+CVars=r.DepthOfFieldQuality=1	+CVars=r.LightShaftQuality=1
```

参见主要[配置文件](../../../cpp-programming/programming-in-the-unreal-engine-architecture/configuration-files/index.md)文档，了解配置文件设定的相关详情。

### iOS

设备描述可用于设定iOS设备的游戏分辨率。`r.MobileContentScaleFactor` 属性与设备的"标称iOS分辨率"相关。举例而言，视网膜显示屏iPad的实际分辨率为2048x1536，但其标称分辨率则是1024x768，因此需使用2.0获取原生分辨率。如希望获得较高分辨率但不愿运行原生分辨率造成性能损失，可使用1.5之类的小数进行获取。

```
	[iPad3 DeviceProfile]	+CVars=r.MobileContentScaleFactor=1 	[iPad4 DeviceProfile]	+CVars=r.MobileContentScaleFactor=2 	[iPadAir DeviceProfile]	+CVars=r.MobileContentScaleFactor=2
```

可在 `Engine/Config` 的 `BaseDeviceProfiles` 中查看iOS设备描述。这些类目可通过插件系统进行设置，该系统的默认插件为 **iOSDeviceProfileSelector**。iOS设备类目实则为设备的命名。

### Android

Android拥有层级式设备描述类目（`Engine/Config` 中的 `BaseDeviceProfiles.ini` 为例）。这些类目可通过插件系统进行设置，默认插件为 **AndroidDeviceProfileSelector**。

## 内存桶

使用者可以对拥有不同内存性能的不同平台运行虚幻引擎4（UE4）项目的方式进行指定，并添加 **内存桶** 指定其将使用的选项。要添加此性能，首先需要打开文本编辑程序中的项目 **Engine.ini** 文件（使用 **Android/AndroidEngine.ini**、**IOS/IOSEngine.ini**，或任意 **PlatformNameEngine.ini** 文件以平台为基础进行设置）。为了方便使用，其中已经有一些默认设置，以下设置已经呗输入 **AndroidEngine.ini**：

```
	[PlatformMemoryBuckets]	LargestMemoryBucket_MinGB=8	LargerMemoryBucket_MinGB=6	DefaultMemoryBucket_MinGB=4	SmallerMemoryBucket_MinGB=3	 ; for now, we require 3gb	SmallestMemoryBucket_MinGB=3
```

可以在 **DeviceProfiles.ini** 中指定哪个内存桶与哪个设备设置相关联。举例而言，要调整纹理流送池使用的内存量，应向DeviceProfiles.ini文件添加以下信息：

```
	[Mobile DeviceProfile]	+CVars_Default=r.Streaming.PoolSize=180	+CVars_Smaller=r.Streaming.PoolSize=150	+CVars_Smallest=r.Streaming.PoolSize=70	+CVars_Tiniest=r.Streaming.PoolSize=16
```

其中"Mobile"可以替换成要添加设备描述的平台名。使用内存桶还可指定要使用的渲染设置。在下例中，使用 **场景设置** 的纹理的 **TextureLODGroup** 已完成设置，UE4检测到使用最小内存桶的设备时将把 **MaxLODSize** 从1024调整为256，减少自身LOD群组设为"场景"的纹理所需要的内存。

```
	[Mobile DeviceProfile]	+TextureLODGroups=(Group=TEXTUREGROUP_World, MaxLODSize=1024, OptionalMaxLODSize=1024, OptionalLODBias=1, MaxLODSize_Smaller=1024, MaxLODSize_Smallest=1024, MaxLODSize_Tiniest=256, LODBias=0, LODBias_Smaller=0, LODBias_Smallest=1, MinMagFilter=aniso, MipFilter=point)
```

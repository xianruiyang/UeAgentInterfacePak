# 移动端Lumen

---
title: "移动端Lumen"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-lumen-global-illumination-on-mobile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端渲染功能", "移动端Lumen"]
---

# 移动端Lumen

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端渲染功能 / 移动端Lumen

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-lumen-global-illumination-on-mobile-in-unreal-engine

虚幻引擎5.4和更高版本提供在高端Android移动设备上支持[Lumen](../../../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/index.md)的试验性功能。本页面提供以下内容：

- Lumen在移动设备和渲染器上的兼容性信息。
- 关于如何为移动设备启用Lumen的说明。
- 局限性和已知问题。

## 兼容性

兼容运行桌面渲染器的Android Vulkan Shader Model 5（SM5）的高端设备可以使用Lumen。这包括对带有和不带硬件光线追踪的支持。

当你创建新项目时，默认不启用Android的桌面渲染器。但是，启用桌面渲染器后，为你的项目启用Lumen即可令使用以下设备描述文件的设备使用Lumen：

- Android_Vulkan_SM5

  - Android_Adreno_Vulkan_SM5
  - Android_Mali_Vulkan_SM5
  - Android_Xclipse_Vulkan_SM5

以下设备当前使用需要的Vulkan SM5设备描述文件：

- Samsung Xclipse (9xx)
- Adreno (7xx)
- Mali (G7xx)

Lumen当前不适用于iOS/tvOS/iPadOS设备。

## 如何在移动设备上启用Lumen

要在移动设备上启用Lumen，请执行以下步骤：

1. 为移动设备启用桌面渲染器和SM5支持。请参阅[功能级别和渲染模式](../mobile-feature-levels-and-rendering-modes/index.md)中的桌面渲染器小节，了解详细说明。
2. 像在桌面应用程序中那样启用Lumen。请参阅[Lumen全局光照](../../../building-virtual-worlds/lighting-the-environment/global-illumination/lumen-global-illumination-and-reflections/index.md)，了解详细说明。

这会启用 `Android_Vulkan_SM5` 设备描述文件，后者自动应用于上文兼容性小节中列出的设备类型。如果你的设备符合其中一种描述，你在启用Lumen后不需要执行额外步骤。如果你需要向通常没有启用它的设备或设备系列添加支持，请参阅下方小节。

### 将兼容Lumen的现有描述应用于新设备

要使用支持桌面渲染器和Lumen的现有描述文件之一，请打开你的 `DeviceProfiles.ini` 文件，添加 `MatchProfile` 行以指定满足你标准的设备应该使用你选择的SM5描述文件。请参阅上方兼容性小节，了解现有SM5描述文件的列表。

在以下示例中， `MatchProfile` 行为Adreno 7xx设备应用了 `Android_Adreno_Vulkan_SM5` 描述文件。

Engine/Config/BaseDeviceProfiles.ini

```
 ; 启用SM5时在Adreno 7xx上启用SM5 +MatchProfile=(Profile="Android_Adreno_Vulkan_SM5",Match=((SourceType=SRC_GpuFamily,CompareType=CMP_Regex,MatchString="Adreno \\(TM\\) 7[0-9][0-9]"),(SourceType=SRC_AndroidVersion, CompareType=CMP_Regex,MatchString="([0-9]+).*"),(SourceType=SRC_PreviousRegexMatch,CompareType=CMP_GreaterEqual,MatchString="10"),(SourceType=SRC_SM5Available,CompareType=CMP_Equal,MatchString="true"))) 
```

请参阅[自定义Android设备描述文件](../../android-support/packaging-and-publishing-android-projects/customizing-device-profiles-and-scalability-in-e75f27cc/index.md)，详细了解匹配设备描述文件。

### 新建兼容Lumen的设备描述文件

你可以在你的 `DeviceProfiles.ini` 中新建支持Lumen的设备描述文件。

在Android中，这意味着你需要同时启用Vulkan和SM5支持。虽然你可以从头开始创建设备描述文件，但你也可以扩展 `Android_Vulkan_SM5` 设备描述文件，方法是将其设置为新描述文件的 `BaseProfileName` 。

下面是 `Android_Vulkan_SM5` 设备描述文件：

Engine/Config/BaseDeviceProfiles.ini

```
	[Android_Vulkan_SM5 DeviceProfile]	DeviceType=Android	BaseProfileName=Android	+CVars=sg.ViewDistanceQuality=2	+CVars=sg.AntiAliasingQuality=1	+CVars=sg.ShadowQuality=2	+CVars=sg.GlobalIlluminationQuality=2	+CVars=sg.ReflectionQuality=2	+CVars=sg.PostProcessQuality=2	+CVars=sg.TextureQuality=2	+CVars=sg.EffectsQuality=2	+CVars=sg.FoliageQuality=2	+CVars=sg.ShadingQuality=2	+CVars=sg.LandscapeQuality=2	+CVars=r.BloomQuality=2	+CVars=r.LightShaftQuality=1 	; Shadows	+CVars=r.Shadow.MaxResolution=2048	+CVars=r.Shadow.MaxCSMResolution=2048	+CVars=r.Shadow.WholeSceneShadowCacheMb=40	+CVars=r.Shadow.CachedShadowsCastFromMovablePrimitives=0	+CVars=r.Shadow.MaxNumPointShadowCacheUpdatesPerFrame=1	+CVars=r.Shadow.MaxNumSpotShadowCacheUpdatesPerFrame=1	+CVars=r.Shadow.DistanceScale=1.0	+CVars=r.Shadow.CSM.MaxCascades=2 	+CVars=r.ShadowQuality=2	+CVars=r.Shadow.CSMShadowDistanceFadeoutMultiplier=2.5	+CVars=r.SSS.Quality=0	+CVars=r.SSS.Scale=0	+CVars=r.SSR.Quality=0	+CVars=r.Android.DisableVulkanSM5Support=0	+CVars=r.Android.DisableVulkanSupport=0	+CVars=r.DistanceFields=1	+CVars=r.Vulkan.RayTracing.AllowCompaction=0	+CVars=r.Vulkan.RayTracing.TLASPreferFastTraceTLAS=0	+CVars=r.RayTracing.RequireSM6=0
```

此描述文件中最重要的参数如下：

- `r.Android.DisableVulkanSupport`：关闭此设置会启用Vulkan支持。
- `r.Android.DisableVulkanSM5Support`：关闭此设置会启用Vulkan SM5设备描述文件。
- `r.DistanceFields`：启用距离场阴影，Lumen中的软件光线追踪需要此项。
- `r.RayTracing.RequireSM6`：关闭此设置将在非SM6设备上运行光线追踪，Lumen中的硬件光线追踪需要此项。

如需详细了解如何配置设备描述文件，请参阅[自定义Android设备描述文件](../../android-support/packaging-and-publishing-android-projects/customizing-device-profiles-and-scalability-in-e75f27cc/index.md)。

## 局限性和已知问题

移动设备上的桌面渲染器相较于移动正向或延迟渲染会带来显著的性能开销。使用Lumen还会进一步加重性能开销。由于这项支持是试验性的，我们尚不推荐使用它来发布项目，但如果你想在项目中测试和分析它，我们竭诚欢迎你提供反馈！


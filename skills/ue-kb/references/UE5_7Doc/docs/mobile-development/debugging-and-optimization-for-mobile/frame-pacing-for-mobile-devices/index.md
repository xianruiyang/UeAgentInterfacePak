---
title: "移动设备的帧平滑"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/frame-pacing-for-mobile-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "移动设备的帧平滑"]
---

# 移动设备的帧平滑

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / 移动设备的帧平滑

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/frame-pacing-for-mobile-devices-in-unreal-engine

**帧平滑（Frame Pacing）** 用于限制应用程序的渲染帧率不超过设备的本地刷新率。它使应用程序能够在渲染中优先考虑一致性和稳定性，避免无止尽地提升帧率，从而提供更为流畅的用户体验。**在虚幻引擎4(UE4)中**，你可以借助项目配置文件中的 **设备描述（Device Profiles）**，为每台设备单独设置帧率。

## 在设备描述中编辑帧平滑设置

你可以通过 `DeviceProfiles.ini` 文件中的CVar控制帧平滑；该文件包含了你的目标设备信息。

- 如果是iOS设备，你可以在

  [/Script/IOSRuntimeSettings.IOSRuntimeSettings]

  下添加设备描述
- 如果是Android设备，你可以在

  [/Script/AndroidRuntimeSettings.AndroidRuntimeSettings]

  下添加设备描述

控制帧平滑的参数如下：

| 参数 | 使用 | 说明 |
| --- | --- | --- |
| `FrameRateLock = [value]` | `FrameRateLock=True` | 若设置为true，则允许所有帧平滑。 |
| `bEnableDynamicMaxFPS = [value]` | `bEnableDynamicMaxFPS=True` | 若设为true，则只要设备支持，刷新率最高就允许为120Hz。 |
| 适用于4.24和更早版本 |  |  |
| `rhi.synchinterval = [value]` | `rhi.synchinterval = 1` | 4.24和更早版本中的参数，用于设置帧平滑的刷新率。当值为1时，表示刷新率为60Hz。 |
| 适用于4.25和更高版本 |  |  |
| `r.setframepace [value]` | `r.setframepace 30` | 4.25中推荐用于iOS和Android设备的新方法。刷新率直接为设置的数值。 |
| `a.UseSwappyForFramePacing = [value]` | `a.UseSwappyForFramePacing=1` | 默认设为0。将此值设置为1将启用Google的Swappy帧平滑解决方案，以替代Android设备的标准UE4帧平滑器。Swappy使用的CVar和UE4帧平滑器所用的相同。 |

## 高刷新率指南

帧平滑的最大刷新率通常被限制为60Hz，但启用 `bEnableDynamixMaxFPS` 会将这一限值提高到120Hz。支持60Hz以上刷新率的移动设备包括：

- Samsung Galaxy S20
- OnePlus 7T
- Google Pixel 4
- iPad Pro第2代及更高型号

## 适用于Android的Swappy帧平滑

除传统帧平滑系统外，虚幻引擎4.25还从 **Android游戏SDK** 集成了Google的 **Swappy帧平滑器**。

在检测到帧提交延迟后，Android硬件的通常做法是，使用帧缓存来显示之前的帧，从而防止画面撕裂。但游戏渲染器往往不知道此过程，导致同步失效，进而先于显示的帧。这会导致帧的显示时间发生大幅变化，而且由于停滞通常发生在输入取样后，这还会导致触屏控件发生明显的输入延迟。

Swappy是Android专门用于解决此问题的帧平滑解决方案，它不仅能提供帧平滑的优势，还能让游戏的渲染周期和Android设备的刷新周期能更有效地通信。这种方法可以取代传统的、在所有其他硬件上使用的UE4帧平滑器， 它是用于所有其他硬件的传统UE4帧平滑器的替代方案。

### 启用Swappy

在4.25中，由于还需进行测试，Swappy目前还不是虚幻中Android项目的默认帧平滑器，但与传统帧平滑器相比，它始终保持着更流畅的性能。我们建议你启用它，并且我们还计划在未来的引擎版本中，将Swappy作为Android新的默认帧平滑器。

若要为Android项目启用Swappy，请将 `UseSwappyForFramePacing=1` 添加到对应的Android描述文件中。你可将它添加到 `Android_Default` 来让所有Android设备启用它。

## 在C++中控制帧平滑

要在C++中控制帧平滑，你可以从 `FPlatformRHIFramePacer` 接口调用静态函数。在此类函数中，帧平滑以32位整数的形式作为参数传递。

`FPlatformRHIFramePacer::SupportsFramePace` 用于检查指定的帧平滑是否与当前设备的刷新率兼容。`FPlatformRHIFramePacer::SetFramePace` 用于将帧平滑设为指定的整数值，而 `FPlatformRHIFramePacer::GetFramePace` 则会返回当前帧平滑。

---
title: "SteamVR命令参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/steamvr-command-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "SteamVR开发", "SteamVR命令参考"]
---

# SteamVR命令参考

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / SteamVR开发 / SteamVR命令参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/steamvr-command-reference-in-unreal-engine

在下面你可以找到可用来调节虚幻引擎（UE）与SteamVR的交互方式的各种控制台命令。

| 命令 | 描述 |
| --- | --- |
| **vr.SteamVR.AdaptiveDebugGPUTime** | 以毫秒为单位添加到GPU帧时间用于测试。 |
| **vr.SteamVR.AdaptiveGPUTimeThreshold** | 以毫秒为单位的时间，作为稳定GPU帧时间的目标。 |
| **vr.SteamVR.PixelDensityAdaptiveDebugCycle** | 如果不为零，则自适应像素密度将从最大像素密度循环至最小像素密度，然后再跳转至最大密度。 |
| **vr.SteamVR.PixelDensityAdaptiveDebugOutput** | 如果不为零，则自适应像素密度将把调试信息输出到日志。 |
| **vr.SteamVR.PixelDensityAdaptivePostProcess** | 如果不为零，当自适应像素密度更改时，我们将对若干帧禁用时空抗锯齿（TAA）以清除缓冲区。 |
| **vr.SteamVR.PixelDensityMax** | 浮点形式的最大像素密度。 |
| **vr.SteamVR.PixelDensityMin** | 浮点形式的最小像素密度。 |
| **vr.SteamVR.ShowDebug** | 如果不为零，则将调试信息绘制到画布。 |
| **vr.SteamVR.UsePostPresentHandoff** | 是否使用PostPresentHandoff。如果为true，将有更多GPU时间可用，但前提是场景中没有活动的SceneCaptureComponent2D或WidgetComponents。否则，将破坏异步重投影。 |
| **vr.SteamVR.UseVisibleAreaMesh** | 如果不为零，SteamVR除了隐藏区域网格体优化之外，还将使用可用的可见区域网格体。这可能在平台的Beta版本上造成问题。 |

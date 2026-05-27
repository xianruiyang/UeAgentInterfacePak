---
title: "SteamVR 分析与性能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/steamvr-profiling-and-performance-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "SteamVR开发", "SteamVR 分析与性能"]
---

# SteamVR 分析与性能

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / SteamVR开发 / SteamVR 分析与性能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/steamvr-profiling-and-performance-in-unreal-engine

此页面说明如何对虚幻引擎中的 SteamVR 项目进行性能分析。

## SteamVR Frame Timing 工具

SteamVR Frame Timing 工具能够追踪 UE 项目运行性能差的原因。无论在编辑器还是在打包版本中，SteamVR Frame Timing 工具都能够确认实际的 CPU 和 GPU 时间，同时负责应用程序节流。要深度了解能够用 SteamVR Frame Timing 工具进行的操作，请查看 [SteamVR Frame Timing 工具](https://developer.valvesoftware.com/wiki/SteamVR/Frame_Timing) 的官方文档。

执行以下步骤显示 SteamVR **Frame Timing** 工具。

1. 右键点击 SteamVR 工具，从出现的菜单中选择 **Settings** 选项。
2. 然后从 Settings 菜单中点击 **Display Frame Timing** 按钮显示 Frame Timing 工具。
3. Frame Timing 运行后即可启动 UE4 项目，在 Frame Timing 工具中查看具体情况。

## 保存 SteamVR 帧时

您可以保存 **Frame Timing** 工具生成的信息，便于之后查看或发送给其他人员查看。执行以下步骤保存 SteamVR 帧时。

1. 右键点击 SteamVR 工具，从出现的菜单中选择 **Settings** 选项。
2. 然后从 Settings 菜单中点击 **Save Frame Data Now** 按钮保存帧数据。
3. 之后帧时将被保存到一个名为 **VRFrames.csv** 的 .CSV 文件中，保存路径为 **C:\Program Files (x86)\Steam\logs**。

# 设置 SteamVR Chaperone

---
title: "设置 SteamVR Chaperone"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-the-steamvr-chaperone-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "SteamVR开发", "Steam VR 指南", "设置 SteamVR Chaperone"]
---

# 设置 SteamVR Chaperone

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / SteamVR开发 / Steam VR 指南 / 设置 SteamVR Chaperone

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-the-steamvr-chaperone-in-unreal-engine

SteamVR Chaperone 组件用于向用户显示 VR 互动区域的软硬边界。以下指南将说明如何把 SteamVR Chaperone 添加到 UE4 VR Pawn。

> [!WARNING]
> 在 UE4 中禁用 Chaperone 系统 **不** 明智，也不可取。然而，您可以调整用户靠近边界时 UE4 作出的响应。

## SteamVR Chaperone 设置

执行以下操作即可将 SteamVR Chaperone 系统添加到 UE4 玩家 pawn：

1. 打开项目玩家 Pawn 蓝图，确保 **Components** 标签已显示。
2. 点击 **Add Component** 按钮，从显示的列表中搜索 **Steam VRChaperone** 组件，找到后点击将其添加到组件列表。
3. 完成后，玩家 pawn 应与下图相似。

## 最终效果

现在即可在 VR 中运行项目并戴上 Vive 头戴显示器，靠近 VR 交互区的边界时，便会出现以下视频中的内容。

## UE4 项目下载

可使用以下链接下载用于创建此例的 UE4 项目。

- SteamVR Chaperone 设置项目


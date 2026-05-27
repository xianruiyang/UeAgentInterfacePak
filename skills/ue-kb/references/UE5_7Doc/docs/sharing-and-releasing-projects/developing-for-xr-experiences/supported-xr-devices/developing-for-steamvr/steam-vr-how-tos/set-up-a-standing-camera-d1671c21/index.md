---
title: "设置SteamVR的站立式相机"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-a-standing-camera-for-steamvr-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "SteamVR开发", "Steam VR 指南", "设置SteamVR的站立式相机"]
---

# 设置SteamVR的站立式相机

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / SteamVR开发 / Steam VR 指南 / 设置SteamVR的站立式相机

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-a-standing-camera-for-steamvr-in-unreal-engine

开始用虚幻引擎开发SteamVR上的VR项目时，首先要考虑的一点便是确定该体验为坐立式还是站立式。以下指南将讲述如何设置站立式SteamVR 体验的UE项目VR相机。

## 步骤

以下内容将讲述如何进行站立式SteamVR体验的Pawn设置。

1. 首先，打开或新建Pawn蓝图，然后前往 **视口（Viewport）** 选项卡的 **组件（Component）** 部分。在此处用以下命名添加以下两个组件，并将VRCamera设为VRCameraRoot的子项：

   | 组件命名 | 值 |
   | --- | --- |
   | **场景** | VRCameraRoot |
   | **相机** | VRCamera |

   > [!NOTE]
   > 由于VR相机能在不实际移动相机的情况下实现相机位置偏移，因此无论使用何种VR头戴显示器，Epic均推荐以此方式设置VR相机。
2. 接下来，打开Pawn蓝图（如未打开），然后在 **Event Graph** 中从 **Event Begin Play** 节点连出引线，显示可执行操作（Executable Actions）列表。在列表中搜索 **Set Tracking Origin** 节点，点击将其添加到事件图表。

   ![undefined](../../../../../../../assets/images/5d/5dd31bdd0805ec4e794bbd84344a8ca3608af28babaa8e594f3cc4aaae044966.jpg)

   点击查看大图。
3. Set Tracking Origin节点有两个选项：Floor Level和Eye Level。针对站立式体验，需将Set Tracking Origin节点的 **Origin** 留为默认 **Floor Level**。

   ![undefined](../../../../../../../assets/images/df/dfeff7b465069cce468e7bd108b06aeed54b0f6811c0358c27efe6025ee4654c.jpg)

   点击查看大图。
4. 将Pawn蓝图从内容浏览器拖入关卡，将其放置在关卡中0,0,0的位置。

   ![undefined](../../../../../../../assets/images/40/40d48404ef16c3f20947609b6524b6bd4aa7e2453b605d34ad0ce7bc20dc6cfc.jpg)

   点击查看大图。
5. 选中放置在关卡中的Pawn蓝图，然后在 **Pawn** 设置下的 **细节** 面板中，将 **自动拥有玩家（Auto Possess Player）** 从 **禁用（Disabled）** 设为 **玩家0（Player 0）**。

   ![undefined](../../../../../../../assets/images/a8/a8ff9e64e83316a6b5abd049967b4d73169ee44598be08500369d9be5568ab1b.jpg)

   点击查看大图。

## 最终结果

最后，前往 **主工具栏（Main Toolbar）** 将 **播放模式（Play Mode）** 改为 **VR预览（VR Preview）**，然后按下 **播放（Play）** 按钮。戴上HTC Vive头戴显示器，坐下观察关卡时，将看到与以下视频类似的内容：

## UE4项目下载

可使用以下链接下载用于创建此例的UE4项目。

- SteamVR站立式VR相机范例项目

---
title: "为Oculus Rift设置站立式相机"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-a-standing-camera-for-the-oculus-rift-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发", "Oculus 指南", "为Oculus Rift设置站立式相机"]
---

# 为Oculus Rift设置站立式相机

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发 / Oculus 指南 / 为Oculus Rift设置站立式相机

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-a-standing-camera-for-the-oculus-rift-in-unreal-engine

开始用UE4开发Oculus Rift上的VR项目时，首先需要考虑的一点便是确定该体验为坐立式或站立式。以下指南将讲述如何设置站立式Oculus Rift体验的UE4项目VR相机。

## 步骤

以下内容将讲述如何进行站立式Oculus Rift体验的Pawn设置。

1. 首先打开或新建一个Pawn蓝图，然后前往 **视口** 标签的 **组件** 部分。在此处用以下命名添加以下两个组件，并将VRCamera设为VRCameraRoot的子项：

   | 组件命名 | 值 |
   | --- | --- |
   | **场景** | VRCameraRoot |
   | **相机** | VRCamera |

   ![undefined](../../../../../../../assets/images/b9/b907a96eb539eef8ab68028001532e3fc972304f97d40ca5e01d0d9e36d9f140.png)

   点击查看全图。

   When

   > [!NOTE]
   > 无论您使用的是何种VR头戴显示器，Epic都推荐以此方式设置VR相机。因为它能在不实际移动相机的情况下实现相机位置的偏移。
2. 接下来打开Pawn蓝图，然后在 **事件图表（Event Graph）** 中从 **Event Begin Play** 节点连出引线，显示"可执行操作（Executable Actions）"列表。在列表中搜索 **Set Tracking Origin** 节点，点击并将其添加到事件图表。

   ![undefined](../../../../../../../assets/images/5d/5dd31bdd0805ec4e794bbd84344a8ca3608af28babaa8e594f3cc4aaae044966.jpg)

   点击查看全图。
3. Set Tracking Origin节点拥有两个选项：**地面平面（Floor Level）** 和 **视线平面（Eye Level）**。针对站立式体验，需要将Set Tracking Origin节点的 **原点** 保持为默认的 **地面平面**。

   ![undefined](../../../../../../../assets/images/df/dfeff7b465069cce468e7bd108b06aeed54b0f6811c0358c27efe6025ee4654c.jpg)

   点击查看全图。
4. 将Pawn蓝图从内容浏览器拖入关卡，将其放置在关卡中0,0,0处。

   ![undefined](../../../../../../../assets/images/26/265daf5e4ee118633e932d1397e293af7877aa14a06cccee5e9db34a364058ad.jpg)

   点击查看全图。
5. 选中放置在关卡中的Pawn蓝图，然后在 **Pawn** 设置下的 **细节** 面板中将 **自动拥有玩家（Auto Possess Player）** 从 **禁用（Disabled）** 改为 **Player 0**。

   ![undefined](../../../../../../../assets/images/80/804dca1b71f5f435090100934a7c7696998e9dad44331dfaae06dc512538834e.png)

   点击查看全图。

## 最终结果

最后前往 **主工具栏** 将 **播放模式（Play Mode）** 改为 **VR预览（VR Preview）**，然后按下 **播放** 按钮。您戴上Oculus Rift头戴显示器站立观察关卡时，将看到与以下视频相似的内容。

## UE4项目下载

可使用以下链接下载用于创建此例的UE4项目。

- Oculus Rift站立式VR相机范例项目

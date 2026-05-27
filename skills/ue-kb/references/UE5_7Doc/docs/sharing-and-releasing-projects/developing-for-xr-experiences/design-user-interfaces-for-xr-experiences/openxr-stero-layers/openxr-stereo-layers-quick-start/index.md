---
title: "OpenXR立体图层快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/openxr-stereo-layers-quick-start-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "为XR体验设计UI", "OpenXR立体图层", "OpenXR立体图层快速入门"]
---

# OpenXR立体图层快速入门

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 为XR体验设计UI / OpenXR立体图层 / OpenXR立体图层快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/openxr-stereo-layers-quick-start-in-unreal-engine

本文介绍了OpenXR项目中立体图层的入门知识。

> [!TIP]
> 本文中的步骤和图片均出自[VR模板](../../../getting-started-with-xr-development/vr-template/index.md)项目。这些步骤适用于基于OpenXR的所有项目。

要在为项目中的Pawn添加OpenXR立体图层，请按以下步骤操作：

1. 在 **内容侧滑菜单（Content Drawer）** 中，找到 **内容（Content）>VRTemplate>蓝图（Blueprints）** ，双击 **VRPawn** 资产，以便在 **蓝图编辑器（Blueprint Editor）** 中打开它。
2. 在蓝图编辑器的 **组件（Components）** 面板中，点击 **添加组件（Add Component）** 按钮并搜索 **Stereo Layer** 。
3. 将新的 **立体图层（Stereo Layer）** 组件拖到 **摄像机（Camera）** 组件上，使其成为摄像机的子Actor。
4. 从组件（Components）列表中选择立体图层组件（Stereo Layer Component），打开其 **细节（Details）** 面板。在 **变换（Transform）** 分段下，将 **位置（Location）** 的 **X** 值设置为 **100** 。
5. 切换到蓝图编辑器（Blueprint Editor）的 **视口（Viewport）** 选项卡，查看立体图层相对于Pawn摄像机的位置。
6. 在 **细节（Details）** 面板中 **立体图层（Stereo Layer）** 分段下：

   - 将纹理添加到 **纹理（Texture）** 参数。在此示例中，使用的是 **T_Grid** 纹理。
   - 将 **立体图层形状（Stereo Layer Shape）** 设置为 **四边形图层（Quad Layer）** 。
7. **编译（Compile）** 蓝图并关闭蓝图编辑器。
8. 点击 **在VR中运行（Play in VR）** ，在头显上启动你的项目，并验证纹理是否显示在你面前并且固定在屏幕画面上。

> [!TIP]
> 要更改立体图层的显示位置，请更改立体图层类型参数。有关可用选项的细节，请参阅[OpenXR立体图层概述](../openxr-stero-layers-overview/index.md)。

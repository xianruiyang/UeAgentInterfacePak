# 在协作查看器（Collab Viewer）模板中使用书签

---
title: "在协作查看器（Collab Viewer）模板中使用书签"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/working-with-bookmark-in-the-collab-viewer-template-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR开发入门", "协作查看器（Collab Viewer）模板", "在协作查看器（Collab Viewer）模板中使用书签"]
---

# 在协作查看器（Collab Viewer）模板中使用书签

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR开发入门 / 协作查看器（Collab Viewer）模板 / 在协作查看器（Collab Viewer）模板中使用书签

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/working-with-bookmark-in-the-collab-viewer-template-in-unreal-engine

协作查看器（Collab Viewer）提供了 **BP_Bookmark** 内置型蓝图资源，用于在关卡中设置预先确定的位置和摄像机视图。用户可以在运行时轻松传送到这些预先确定的位置。

本页介绍如何在关卡中放置新书签，如何设置热键，用户按下键盘数字键后即可在不同书签之间传送。

## 放置书签

可以在关卡任意位置放置新书签。不过，建议让每个新书签都满足以下条件：

- 位于地面上。
- 位于设有碰撞网格体的静态网格体上方，如

  向协作查看器添加自己的内容

  中所示。

否则，用户在行走模式或VR中可能会在传送后跌倒在地或穿入地面。

### 步骤

要放置书签，请执行以下操作：

1. 在关卡中，每个书签由 **BP_Bookmark** 蓝图类实例表示。可在 **内容浏览器** 的 *CollaborativeViewer/Blueprints/Commands/Bookmark* 文件夹中找到此类。

   ![BP_Bookmark资源](../../../../../../assets/images/48/4837ea3bd9b02fef2e609ee60cbb7ad794efe43d5be15614c77f541541820ab1.jpg)
2. 要设置新书签，将 **BP_Bookmark** 从 **内容浏览器** 拖到关卡中。

   ![将书签拖入关卡](../../../../../../assets/images/9a/9a92a537e06a890a92ee4274823b7ab25df4c08a12d3b34b3d951f6a1ede5bdf.jpg)
3. 在视口或 **世界大纲视图** 中选中书签Actor，将其移至关卡中所需位置并旋转至所需角度。

   > [!NOTE]
   > 必须移动书签Actor，不能只移动子摄像机组件。

   > [!TIP]
   > **导航** Actor可简便快捷地设置视点。参阅[在视口中导航Actor](https://dev.epicgames.com/documentation/unreal-engine/using-editor-viewports-in-unreal-engine)。
4. 在 **细节（Details）** 面板中，在 **~书签（~ Bookmarks）** 部分找到 **热键（Hotkey）** 设置，设置要指定给新书签的热键。 可以在 **热键（Hotkey）** 域中直接输入要指定的数字，也可以用 **指定未使用热键（Assign Unused Hotkey）** 按钮为书签指定可用的最小数字键。

   ![BP_Bookmark热键设置](../../../../../../assets/images/a0/a065ac1109fe870d11a043ed8c8186447891b16b6d65f23bd323272ebaaeb0d9.jpg)

### 最终结果

若以桌面模式加入会话，用户可以按指定热键或使用工具栏中的书签（Bookmarks）菜单或交互菜单（Interaction Menu）中的 **书签（Bookmark）** 项传送到书签位置。

另可参阅[与协作查看器模板交互](../interacting-with-the-collab-viewer/index.md)。

## 在会话期间保存书签

在Collab Viewer的会话期间，你可以将当前位置记录为一个新书签。之后该书签会作为一个选项出现在书签菜单列表中。它将被保存并在重新加载时可用。

保存书签：

1. 移动到你想保存书签的位置。
2. 打开 **交互（Interaction）** 菜单，并选择 **书签（Bookmark）**。
3. 在 **书签（Bookmark）** 菜单中，选择**创建书签**。

   ![在交互菜单中创建书签](../../../../../../assets/images/76/76020b157ec79f439d1e0c293f73e1a5c5e6fa6f897aae150ac9492025c32946.jpg)
4. 命名你的新书签，然后点击 **+添加** 按钮。

   ![命名并保存书签](../../../../../../assets/images/f1/f186a2e3a0be880f118ab0571a267628c8187bf725730a56ac37f5310225c372.jpg)
5. 你可以点击 **创建书签（Create Bookmark）** 菜单中已保存书签旁的 **垃圾箱（bin）** 图标来删除已保存的书签。


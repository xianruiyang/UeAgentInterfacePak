---
title: "关卡流送指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/level-streaming-using-volumes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡流送", "关卡流送指南"]
---

# 关卡流送指南

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡流送 / 关卡流送指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/level-streaming-using-volumes-in-unreal-engine

我们需要在此处开始流入天井。玩家转过弯拐靠近天井时，将加载并显示流送关卡。

设置拥有两个关卡，**SunTemple_Persistent** 和 **SunTemple_Streaming**。**玩家出生点** 位于 **SunTemple_Persistent** 中，游戏中的玩家由 *角色* 表示。

1. 在 **Content Browser** 中打开 **SunTemple_Persistent**。
2. 将 **玩家出生点** 移至庙宇开端的位置。
3. 点击 **Windows**，然后选择 **Levels**。
4. 点击 **Levels** 下拉菜单，然后选择 **Add Existing...** 新增一个关卡分段。
5. 选择 **SunTemple_Streaming** 加入 **Open Level** 对话，然后点击 **Open**。
6. **右键点击** **Persistent Level**，从下拉菜单中选择 **Make Current**。

## 使用体积流入关卡

1. 在 **放置Actor（Place Actors）** 面板的 **体积（Volumes）** 选项卡中将一个 **关卡流送体积（Level Streaming Volume）** 拖入关卡。
2. 使 **关卡流送体积** 包含 **SunTemple_Streaming** 整个可行走的区域。

   > [!TIP]
   > 注意，关卡流送体积的逻辑会追踪使用中摄像机的位置。因此，如果摄像机离玩家 Pawn 或角色较远，可能需要相应地调整 关卡流送体积的大小和放置。
3. 点击 **Windows**，然后选择 **Levels**。
4. 选择 **SunTemple_Streaming**，然后点击 **Level Details** 图标。
5. 点击 **Streaming Volumes** 旁边的加号（**+**）新添加一个体积。然后使用下拉菜单或滴管选择放置在关卡中的 **关卡流送体积**。
6. 确保 **Initially Loaded** 和 **Initially Visible** 复选框未勾选，然后关闭 **Level Details** 面板。
7. 返回 **视口**，选择 **Level Streaming Volume**。在 **Details** 面板中设置体积的以下属性：取消勾选 **Editor Pre Vis Only** 和 **Disabled**；**Streaming Usage** 应被设为 **SVB Visibility Blocking on Load**。
8. 使用 **Play in Editor** 测试流送关卡。

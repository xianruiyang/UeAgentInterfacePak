---
title: "使用蓝图加载和卸载关卡"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/loading-and-unloading-levels-using-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡流送", "使用蓝图加载和卸载关卡"]
---

# 使用蓝图加载和卸载关卡

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡流送 / 使用蓝图加载和卸载关卡

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/loading-and-unloading-levels-using-blueprints-in-unreal-engine

我们想在此处的露台关卡中开始流送，这样在玩家转过拐角并开始靠近露台时，流送中的关卡 就会加载好并可见。

作为设置的一部分，我们有两个关卡：**SunTemple_Persistent** 和 **SunTemple_Streaming** 。我们的 **玩家出生点（Player Start）** 位于 **SunTemple_Persistent** 中，我们的玩家在游戏中 由 *角色* 表示。

1. 在 **内容浏览器（Content Browser）** 中打开 **SunTemple_Persistent** 。
2. 将 **玩家出生点（Player Start）** 移至模板的最开头。
3. 点击 **窗口（Windows）**，然后选择 **关卡（Levels）** 。
4. 点击 **关卡（Levels）** 下拉菜单，然后选择 **添加现有...（Add Existing...）** 以添加新的子关卡。
5. 选择 **SunTemple_Streaming** 以添加 **打开关卡（Open Level）** 对话框，然后点击 **打开（Open）** 。
6. **右键点击** **持久关卡（Persistent Level）** ，并从下拉菜单选择 **设为当前（Make Current）** 。

## 使用蓝图在关卡中流送

1. 打开 **内容浏览器（Content Browser）** 并创建新 **蓝图类** 。此类将基于 **Actor** 。
2. 将新 **蓝图类** 命名为"LevelStreamer"，然后将其保存。
3. 在 **蓝图编辑器** 中打开 **LevelStreamer** 。

对于这种情况，我们需要在 **角色** 与盒体组件重叠时立即流送第二个关卡。

1. 使用 **组件（Components）** 选项卡中的 **添加组件（Add Component）** 按钮添加 **盒体碰撞（Box Collision）** 组件。
2. 打开蓝图的 **事件图表（Event Graph）** 。在 **组件（Components）** 选项卡中选择 **盒体（Box）** 组件，然后 **右键点击** 图表以弹出上下文菜单。
3. 输入"begin overlap"，然后选择 **在组件开始重叠时（On Component Begin Overlap）** 以添加该事件。
4. 点击并拖移 **Other Actor** 引脚，然后在上下文菜单的搜索中输入"="。选择 **Equal (Object)** 条目以添加该节点。
5. 点击并拖移 **==** 节点上的第二个对象（Object）引脚，然后在上下文菜单的搜索中输入"character"。选择 **Get Player Character** 条目以添加该节点。
6. 按住 **B** 键并点击图表以添加 **Branch** 节点，然后将 **==** 节点的布尔值引脚连接到 **Branch** 节点上的输入。
7. 将 **OnComponentBeginOverlap** 节点的执行输出引脚连接到 **Branch** 节点的执行输入引脚。
8. **右键点击** 图表，然后输入"level"以在上下文菜单中搜索。从菜单选择 **加载流送关卡（Load Stream Level）** 。
9. **右键点击** **关卡名称（Level Name）** 引脚并将其提升到变量，然后将该变量命名为"LevelToStream"，并在 **细节（Details）** 面板中将其设为 **可编辑（Editable）** 。
10. 在 **Load Stream Level** 节点上将 **加载后可见（Make Visible After Load）** 和 **加载时应阻止（Should Block on Load）** 切换为true。

    对于本示例，我们将对使用此蓝图的所有关卡采用相同的默认加载行为，但你还可以将那些设为 **可编辑（Editable）** 变量。
11. 将 **Branch** 节点的 **True** 执行输出引脚连接到 **Load Stream Level** 节点的输入执行引脚。
12. 将 **LevelStreamer** 蓝图放入关卡中，然后调整位置并缩放，直至它包含你希望 **角色** 位于其中才能开始流送的持久世界的一部分， 以及流送中的关卡将位于的整个可行走体积。
13. 输入 *SunTemple_Streaming**作为**要流送的关卡** 。
14. 使用在编辑器中运行（Play in Editor）来测试流送中的关卡。

## 使用蓝图卸载关卡

要在 *角色* 离开 **盒体（Box）** 组件时卸载关卡，你的图表将采用非常类似的逻辑，但最终会位于 **Unload Stream Level** 节点中。

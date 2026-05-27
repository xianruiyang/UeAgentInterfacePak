# Quartz快速入门

---
title: "Quartz快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/quartz-quick-start"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "音乐系统", "Quartz", "Quartz快速入门"]
---

# Quartz快速入门

> 路径：虚幻引擎5.7文档 / 处理音频 / 音乐系统 / Quartz / Quartz快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/quartz-quick-start

**Quartz** 是公开蓝图的安排系统，解决了游戏、音频逻辑和音频渲染线程之间的计时问题，以提供精确到采样的音频播放。

本指南介绍如何创建Quartz驱动的节拍器来触发音频和Gameplay事件。

## 先决条件

创建新的[第三人称模板](../../../../understanding-the-basics/working-with-projects-and-templates/template-reference/index.md)项目。

## 1 - 创建MetaSound

![MetaSound图表](../../../../../assets/images/71/716d8e428fa417d505e6a10bda17980616f8a107325375956112473bf9f04adf.jpg)

创建两个 **MetaSound源（MetaSound Sources）** 来表示节拍器哔哔声。请按照下面的步骤构建上述图表。

### 1.1 - 创建高频哔哔声

1. 创建MetaSound源。

   1. 在 **内容浏览器（Content Browser）** 中点击 **添加（Add）** 按钮。
   2. 选择 **音频（Audio）> MetaSound源（MetaSound Source）** 。
   3. 将新的MetaSound命名为 `MSS_BeepA4` 。
2. 双击MetaSound打开 **MetaSound Editor** 。
3. 找到 **On Play Input** 节点并将引脚拖移到空白区域。在节点搜索中输入"AD Envelope (Audio)"以创建连接的节点。你可以拖动节点，在图表内四处移动。
4. 在 **AD Envelope (Audio)** 节点上：

   1. 将 **Decay Time** 设置为0.1。
   2. 将 **完成时（On Done）** 引脚连接到 **On Finished Output** 节点。
   3. 拖移 **输出包络（Out Envelope）** 引脚并创建 **Multiply (Audio)** 节点。
5. 在 **Multiply (Audio)** 节点上：

   1. 拖移底部被乘数引脚并创建 **Sine** 节点。
   2. 将输出引脚连接到 **Out Mono Output** 节点。
6. 点击 **MetaSound编辑器工具栏（MetaSound Editor Toolbar）** 上的 **播放（Play）** 按钮，播放短促高频的哔哔声。
7. 保存MetaSound并关闭 **MetaSound编辑器（MetaSound Editor）** 。

### 1.2 - 创建低频哔哔声

1. 在 **内容浏览器（Content Browser）** 中，右键点击 `MSS_BeepA4` MetaSound，并选择 **复制（Duplicate）** 。
2. 将新的MetaSound命名为 `MSS_BeepA3` 。
3. 双击MetaSound打开 **MetaSound Editor** 。
4. 在 **Sine** 节点上，将 **频率（Frequency）** 设置为220。
5. 点击 **MetaSound编辑器工具栏（MetaSound Editor Toolbar）** 上的 **播放（Play）** 按钮，播放短促低频的哔哔声。
6. 保存MetaSound并关闭 **MetaSound编辑器（MetaSound Editor）** 。

## 2 - 构建关卡蓝图

构造关卡蓝图以创建节拍器的Quartz时钟、声音和事件委托。

### 2.1 - 创建Quartz时钟

![创建Quartz时钟](../../../../../assets/images/4c/4c822179f1b0a58a8c4ce59b9f39992d05b50a42991c12985c7d50be8636a68e.jpg)

1. 在 **关卡编辑器工具栏（Level Editor Toolbar）** 上，点击 **蓝图（Blueprint）** 按钮并选择 **打开关卡蓝图（Open Level Blueprint）** 。
2. 右键点击空白区域并添加 **Get QuartzSubsystem** 节点。
3. 在 **Get QuartzSubsystem** 节点上，拖移输出引脚并添加 **Create New Clock** 节点。
4. 在 **Create New Clock** 节点上：

   1. 将 **执行输入（Exec Input (>)）** 引脚连接到 **Event BeginPlay** 节点。
   2. 将 **时钟名称（Clock Name）** 设置为 `LevelClock` 。
   3. 拖移 **输入设置（In Settings）** 引脚并添加 **Make QuartzClockSettings** 节点。
   4. 拖移 **返回值（Return Value）** 引脚并选择 **提升为变量（Promote to Variable）** 。这会创建 **Set** 节点和名为 `NewVar` 的蓝图变量，用于存储Quartz时钟句柄并防止其垃圾回收。
   5. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Set (NewVar)** 节点。
5. 在 **我的蓝图（My Blueprint）** 面板中，右键点击 **NewVar** 变量并选择 **重命名（Rename）** 。
6. 将变量命名为 `ClockHandle` 。
7. 在 **Make QuartzClockSettings** 节点上，拖移 **Time Signature** 并创建 **Make QuartzTimeSignature** 节点。
8. 在 **Set (Clock Handle)** 节点上：

   1. 拖移输出引脚并创建 **Set Beats Per Minute** 节点。
   2. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Set Beats Per Minute** 节点。
9. 在 **Set Beats Per Minute** 节点上，将 **Beats Per Minute** 设置为100.0。

### 2.2 - 创建声音

![创建声音](../../../../../assets/images/73/7318f14dc1411feab7653276d9c6e7972f5b6381bc5e2ecbed332eb1575537cf.jpg)

1. 在 **Set Beats Per Minute** 节点上（在之前分段的末尾），拖移 **执行输出（Exec Output (>)）** 引脚并创建 **Create Sound 2D** 节点。
2. 在 **Create Sound 2D** 节点上：

   1. 将 **声音（Sound）** 设置为 `MSS_BeepA4` 。
   2. 拖移 **返回值（Return Value）** 引脚并选择 **提升为变量（Promote to Variable）** 。这会创建一个 **Set** 节点和另一个名为 `NewVar` 的蓝图变量。
   3. 拖移 **音频组件输出（Audio Component Output）** 引脚并创建 **Set Play Multiple Instances** 节点。
   4. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Set Play Multiple Instances** 节点。
3. 在 **我的蓝图（My Blueprint）** 面板中，右键点击 **NewVar** 变量并选择 **重命名（Rename）** 。
4. 将变量命名为 `BeepA4` 。
5. 在 **Set Play Multiple Instances** 节点上：

   1. 启用 **Play Multiple Instances** 。
   2. 拖移 **执行输出（Exec Output (>)）** 引脚并创建第二个 **Create Sound 2D** 节点。
6. 在第二个 **Create Sound 2D** 节点上：

   1. 将 **声音（Sound）** 设置为 `MSS_BeepA3` 。
   2. 拖移 **返回值（Return Value）** 引脚并选择 **提升为变量（Promote to Variable）** 。这会创建一个 **Set** 节点和另一个名为 `NewVar` 的蓝图变量。
   3. 拖移 **音频组件输出（Audio Component Output）** 引脚并创建第二个 **Set Play Multiple Instances** 节点。
   4. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Set Play Multiple Instances** 节点。
7. 在 **我的蓝图（My Blueprint）** 面板中，右键点击 **NewVar** 变量并选择 **重命名（Rename）** 。
8. 将变量命名为 `BeepA3` 。
9. 在第二个 **Set Play Multiple Instances** 节点上：

   1. 启用

      Play Multiple Instances

      。

### 2.3 - 启动Quartz时钟

![启动Quartz时钟](../../../../../assets/images/5f/5f57cd40257e294a230bf5830f9e01f6319a5ed8de1798bcd225386d1d0e75f0.jpg)

1. 右键点击空白区域并添加 **Get Clock Handle** 节点。
2. 在 **Get Clock Handle** 节点上，拖移输出引脚并添加 **Start Clock** 节点。
3. 在 **Start Clock** 节点上：

   1. 将 **执行输入（Exec Input (>)）** 引脚连接到第二个 **Set Play Multiple Instances** 节点（在之前分段的末尾）。
   2. 拖移 **Clock Handle** 节点并创建 **Subscribe to All Quantization Events** 节点。
   3. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Subscribe to All Quantization Events** 节点。
4. 在 **Subscribe to All Quantization Events** 节点上，拖移 **On Quantization Event** 引脚并创建 **Create Event** 节点。
5. 在 **Create Event** 节点上：

   1. 点击下拉菜单并选择 **[创建匹配事件（Create a matching event）]** 。这会创建新的 **Custom Event** 节点。
   2. 将 **Custom Event** 命名为 `OnQuantizationEvent` 。

### 2.4 - 构造事件委托

![构造事件委托](../../../../../assets/images/25/255636c4a4d5c0bc71db5d94759ae29bbf1e5990582d2b6a170f398b87c4bf25.jpg)

1. 在 **OnQuantizationEvent** 节点上：

   1. 拖移 **量化类型（QuantizationType）** 引脚并创建 **Switch on EQuartzCommandQuantization** 节点。
   2. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Switch on EQuartzCommandQuantization** 节点。
   3. 拖移 **量化类型（QuantizationType）** 引脚并创建 **Make QuartzQuantizationBoundary** 节点。
   4. 拖移 **量化类型（QuantizationType）** 引脚并创建第二个 **Make QuartzQuantizationBoundary** 节点。
2. 在两个 **Make QuartzQuantizationBoundary** 节点上，将 **计算参考点（Counting Reference Point）** 设置为"相对传输（Transport Relative）"。
3. 在 **Switch on EQuartzCommandQuantization** 节点上：

   1. 拖移 **小节（Bar）** 引脚并创建 **Play Quantized** 节点。
   2. 拖移 **拍子（Beat）** 引脚并创建第二个 **Play Quantized** 节点。
4. 在第一个 **Play Quantized** 节点上：

   1. 拖移 **目标（Target）** 引脚并创建 **Get Beep A4** 节点。
   2. 拖移 **输入时钟句柄（In Clock Handle）** 引脚并创建 **Get Clock Handle** 节点。
   3. 将 **输入量化边界（In Quantization Boundary）** 引脚连接到其中一个 **Make QuartzQuantizationBoundary** 节点的输出引脚。
5. 在第二个 **Play Quantized** 节点上：

   1. 拖移 **目标（Target）** 引脚并创建 **Get Beep A3** 节点。
   2. 拖移 **输入时钟句柄（In Clock Handle）** 引脚并创建 **Get Clock Handle** 节点。
   3. 将 **输入量化边界（In Quantization Boundary）** 引脚连接到未连接的 **Make QuartzQuantizationBoundary** 节点的输出引脚。
6. 编译并保存蓝图。
7. 关闭 **蓝图编辑器（Blueprint Editor）** 。

### 2.5 - 测试关卡

在 **关卡编辑器工具栏（Level Editor Toolbar）** 上点击 **播放（Play）** 按钮。低频哔哔声MetaSound会在每个拍子播放，而高频哔哔声MetaSound会在每个小节播放。

## 3 - 构建蓝图Actor

使用立方体组件创建蓝图Actor，以随你在关卡蓝图上设置的Quartz时钟的拍子缩放。

### 3.1 - 创建蓝图Actor

1. 在 **内容浏览器（Content Browser）** 中点击 **添加（Add）** 按钮。
2. 选择 **蓝图类（Blueprint Class）** 。
3. 从 **选择父类（Pick Parent Class）** 窗口中，选择 **Actor** 。
4. 将新蓝图Actor命名为 `BP_QuartzCube` 。
5. 双击蓝图Actor打开 **蓝图编辑器（Blueprint Editor）** 。
6. 在 **组件（Components）** 面板中，点击 **添加（Add）** 按钮，在搜索栏中输入"Cube"并按Enter键。

### 3.2 - 在Actor的事件图表上获取关卡时钟

![获取关卡时钟](../../../../../assets/images/09/09a76fa8a3412210976cd6c3986f0c5ccfcff73fb21339807cbd85d967246788.jpg)

1. 右键点击空白区域并添加 **Get QuartzSubsystem** 节点。
2. 在 **Get QuartzSubsystem** 节点上，拖移输出引脚并添加 **Get Handle for Clock** 节点。
3. 在 **Get Handle for Clock** 节点上：

   1. 将 **执行输入（Exec Input (>)）** 引脚连接到 **Event BeginPlay** 节点。
   2. 将 **时钟名称（Clock Name）** 设置为 `LevelClock` 。
   3. 拖移 **返回值（Return Value）** 引脚并创建 **Subscribe to Quantization Event** 节点。
   4. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Subscribe to Quantization Event** 节点。
4. 在 **Subscribe to Quantization Event** 节点上：

   1. 将 **输入量化事件（In Quantization Event）** 设置为"拍子（Beat）"。
   2. 拖移 **返回值（Return Value）** 引脚并选择 **提升为变量（Promote to Variable）** 。这会创建名为 `Clock Handle` 的蓝图变量，用于存储Quartz时钟句柄并防止其垃圾回收。
   3. 将 **执行输出（Exec Output (>)）** 引脚连接到 **Set (Clock Handle)** 节点。
   4. 拖移 **发生量化事件时（On Quantization Event）** 引脚并创建 **Create Event** 节点。
5. 在 **Create Event** 节点上：

   1. 点击下拉菜单并选择 **[创建匹配事件（Create a matching event）]** 。这会创建新的 **Custom Event** 节点。
   2. 将 **Custom Event** 命名为 `OnBeat` 。

### 3.3 - 缩放拍子上的Actor

![缩放Actor](../../../../../assets/images/28/28576965b0f37405fa0fd4af9753a222222338e168318a20cb7566968fbf6805.jpg)

1. 在 **OnBeat** 节点上：

   1. 拖移 **执行输出（Exec Output (>)）** 引脚并创建 **Set Actor Scale 3D** 节点。
   2. 将 **拍子（Beat）** 引脚连接到 **Set Actor Scale 3D** 节点上的 **新缩放3D（New Scale 3D）** 引脚。这会自动创建 **To Vector (Integer)** 节点。
2. 编译并保存蓝图。
3. 关闭 **蓝图编辑器（Blueprint Editor）** 。

## 4 - 修改关卡蓝图

![生成Actor](../../../../../assets/images/8f/8f98ef8d8f487fa7146dd0c15b772a94186f49d4b66384c362e3cfb7615fde5a.jpg)

将逻辑添加到关卡蓝图以生成 `BP_QuartzCube` 。

1. 在 **关卡编辑器工具栏（Level Editor Toolbar）** 上，点击 **蓝图（Blueprint）** 按钮并选择 **打开关卡蓝图（Open Level Blueprint）** 。
2. 在 **Subscribe to All Quantization Events** 节点上（在分段2.3中），拖移 **执行输出（Exec Output (>)）** 引脚并创建 **Spawn Actor from Class** 节点。
3. 在 **Spawn Actor** 节点上：

   1. 将 **类（Class）** 设置为 `BP_QuartzCube` 。
   2. 拖移 **生成变换（Spawn Transform）** 引脚并选择 **提升为变量（Promote to Variable）** 。
4. 编译蓝图。
5. 选择 **Spawn Transform** 节点。
6. 在 **细节（Details）** 面板中，将 **默认值（Default Value）> 生成变换（Spawn Transform）> 位置（Location）** 设置为1600.0, 1200.0, 200.0。
7. 编译并保存蓝图。
8. 关闭 **蓝图编辑器（Blueprint Editor）** 。

## 5 - 测试关卡

在 **关卡编辑器工具栏（Level Editor Toolbar）** 上点击 **播放（Play）** 按钮。`BP_QuartzCube` 现在会在关卡中生成并随节拍器拍子缩放。


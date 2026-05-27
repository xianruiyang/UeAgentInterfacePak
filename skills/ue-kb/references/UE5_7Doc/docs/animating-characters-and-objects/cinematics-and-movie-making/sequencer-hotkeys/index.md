---
title: "Sequencer热键"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sequencer-hotkeys-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer热键"]
---

# Sequencer热键

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer热键

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sequencer-hotkeys-in-unreal-engine

下文列出了Sequencer的主要热键及其功能。

## 播放和时序

| 命令 | 说明 |
| --- | --- |
| **空格键** | 切换序列的播放与暂停。 |
| **下方向键** | 播放序列。 |
| **K** | 暂停序列。 |
| **上方向键** | 跳至序列开头。 |
| **Ctrl + 上方向键** | 跳至序列结尾。 |
| **左方向键** | 在序列中后退一个帧。 |
| **右方向键** | 在序列中前进一个帧。 |
| **L** | 向前穿梭。穿梭（Shuttle）是一种编辑概念，是指按递增速度播放Sequencer。按此键将开始播放序列，重复按此键将提高播放速度。 |
| **J** | 向后穿梭。如果序列已经在播放或在向前穿梭，每次按此键将递减播放速度，最终开始向后播放。 |
| **Shift + 左方向键** | 按照你在[播放选项](../unreal-engine-sequencer-movie-tool-overview/sequencer-editor/sequencer-cinematic-toolbar/index.md#playbackoptions)中定义的 **跳帧增量（Jump Frame Increment）** ，向后倒播序列。 |
| **Shift + 右方向键** | 按照你在播放选项中定义的 **跳帧增量（Jump Frame Increment）** ，快播序列。 |
| **Ctrl + 左方向键** | 在序列中后退，幅度由[播放选项（Playback Options）](../unreal-engine-sequencer-movie-tool-overview/sequencer-editor/sequencer-cinematic-toolbar/index.md#%E6%92%AD%E6%94%BE%E9%80%89%E9%A1%B9)菜单中的 **跳转帧增量（Jump Frame Increment）** 定义。 |
| **Ctrl + 右方向键** | 在序列中前进，幅度由"播放选项（Playback Options）"菜单中的 **跳转帧增量（Jump Frame Increment）** 定义。 |
| **[** | 将序列的开始时间设置为播放头。 |
| **]** | 将序列的结束时间设置为播放头。 |
| **End** | 设置主序列的开始和结束时间以匹配所有镜头的时长。 |
| **.** | 在序列中按每个关键帧和分段边界前进。 |
| **,** | 在序列中按每个关键帧和分段边界后退。 |
| **I** | 将[自定义时间轴选择范围](https://dev.epicgames.com/documentation/404)的开始点设置为播放头。 |
| **O** | 将自定义时间轴选择范围的结束点设置为播放头。 |
| **Page Up** | 创建包含从播放头算起的上一个镜头的自定义时间轴选择范围。 |
| **Page Down** | 创建包含从播放头算起的下一个镜头的自定义时间轴选择范围。 |
| **M** | 切换[自定义时间轴标记](https://dev.epicgames.com/documentation/404)在当前播放头时间的创建或删除。 |
| **Ctrl + Shift + .** | 将Sequencer播放快进到上一个自定义时间轴标记。 |
| **Ctrl + Shift + ,** | 将Sequencer播放快进到下一个自定义时间轴标记。 |
| **Ctrl + Shift + T** | 在时间码、秒和帧之间循环切换时间显示。 |
| **Ctrl + A** | 将当前所选Actor添加到Sequencer。 |
| **Shift + S** | 切换自动滚动。启用后，这会随着序列的播放而自动滚动时间轴，使播放头保持可见。 |
| **Ctrl + T** | 输入数字值并按下Enter键以转至时间轴中的具体时间。 |
| **Ctrl + R** | 将Sequencer制作动画的所有对象恢复为原始编辑器默认值。 |

## 时间轴和轨道导航

| 命令 | 说明 |
| --- | --- |
| **右键点击拖动** | 根据光标移动来平移时间轴视图。 |
| **滚动鼠标滚轮** | 上下平移时间轴。 |
| **Shift + 滚动鼠标滚轮** | 左右平移时间轴。 |
| **Ctrl + 滚动鼠标滚轮** | 缩放时间轴。 |
| **Alt + Shift + 右键点击拖动** | 根据光标移动来缩放时间轴。 |
| **Home** | 恢复时间轴缩放级别以设定开始和结束时间的帧。 |
| **-** | 将时间轴放大10%。 |
| **=** | 将时间轴缩小10%。 |
| **V** | 切换所选轨道的展开和折叠，幅度为一个级别。 |
| **Shift + V** | 切换所选轨道及其后代的展开和折叠。 |
| **Ctrl + G** | 将所选轨道分组为新的[文件夹](../unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/organize-cinematic-tracks/index.md)。 |
| **Shift + G** | 从文件夹删除所选轨道。 |
| **Alt + 左方向键** | 后退并打开之前查看的镜头或序列。 |
| **Alt + 右方向键** | 前进并打开之前查看的镜头或序列。 |
| **Ctrl + F** | 聚焦在搜索栏，以便在Sequencer中搜索轨道名称。 |
| **Ctrl + [** | 选择从播放头向后的所有关键帧和分段。 |
| **Ctrl + ]** | 选择从播放头向前的所有关键帧和分段。 |

## 关键帧

你可以将以下命令用于主关键帧操作。

| 命令 | 说明 |
| --- | --- |
| **Enter** | 为播放头处的每个所选轨道创建关键帧。 |
| **中键点击** | 在光标位置处为所选轨道创建关键帧。 |
| **Ctrl + Shift + V** | 从Sequencer的剪贴板历史记录粘贴复制的关键帧。每次复制关键帧时，关键帧会添加到特殊的Sequencer剪贴板历史记录。然后你可以随时选择从此历史记录粘贴一组特定的已复制关键帧。 |
| **Ctrl + 左方向键** | 将所选关键帧和分段左移一个帧。 |
| **Ctrl + 右方向键** | 将所选关键帧和分段右移一个帧。 |
| **Ctrl + M** | 将所选关键帧和分段移动指定数量。 |

### 关键帧插值

你可以使用以下热键设置[关键帧插值](../unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md#%E6%8F%92%E5%80%BC)模式。

| 命令 | 说明 |
| --- | --- |
| **1** | 将所选关键帧设置为 **立方体（自动）（Cubic (Auto)）** 。它会试图在关键帧之间维持平滑曲线，并缓动开始和结束关键帧。每当你添加或移动关键帧时，它会自动调整。 |
| **2** | 将所选关键帧设置为 **立方体（用户）（Cubic (User)）** 。"立方体（用户）"类似于"立方体（自动）"，但它会在你添加或移动关键帧时锁定切线，防止进一步的自动编辑。 |
| **3** | 将所选关键帧设置为 **立方体（拆分）（Cubic (Break)）** 。"立方体（拆分）"类似于"立方体（自动）"，但其切线是拆分的，允许你从曲线编辑器指定不同的传入和传出角度。 |
| **4** | 将所选关键帧设置为 **线性（Linear）** 。线性切线导致关键帧之间没有平滑或缓动，这样在到达每个关键帧时开始和结束都很生硬。 |
| **5** | 将所选关键帧设置为 **常量（Constant）** 。常量切线的运作方式类似于非插值关键帧，在到达下一个关键帧之前会维持当前值。 |

### 分段编辑

你可以使用以下命令编辑[分段](../unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md#%E5%88%86%E6%AE%B5)。

| 命令 | 说明 |
| --- | --- |
| **Ctrl + /** | 在播放头位置拆分所选分段。 |
| **Ctrl + ,** | 将所选分段的左侧修剪到播放头位置。此命令仅删除分段数据。 |
| **Ctrl + .** | 将所选分段的右侧修剪到播放头位置。此命令仅删除分段数据。 |
| **Alt + [** | 将所选轨道上所有分段的左侧修剪到播放头位置。此命令可以添加或删除分段数据。 |
| **Alt + ]** | 将所选轨道上所有分段的右侧修剪到播放头位置。此命令可以添加或删除分段数据。 |

### 变换轨道

你可以使用以下命令为Actor的[变换](../unreal-engine-sequencer-fa6b165a/sequencer-track-list/cinematic-transform-and-property-tracks/index.md#%E5%8F%98%E6%8D%A2%E8%BD%A8%E9%81%93)设置关键帧。

| 命令 | 说明 |
| --- | --- |
| **S** | 创建变换轨道（若不存在），并为位置、旋转和缩放属性设置关键帧。 |
| **Shift + W** | 创建变换轨道（若不存在），并仅为位置属性设置关键帧。 |
| **Shift + E** | 创建变换轨道（若不存在），并仅为旋转属性设置关键帧。 |
| **Shift + R** | 创建变换轨道（若不存在），并仅为缩放属性设置关键帧。 |

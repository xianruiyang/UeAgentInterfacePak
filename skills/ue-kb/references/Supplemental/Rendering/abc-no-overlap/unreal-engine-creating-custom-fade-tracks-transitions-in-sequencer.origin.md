# 在音序器中创建自定义淡入淡出轨道/过渡

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Ya7b/unreal-engine-creating-custom-fade-tracks-transitions-in-sequencer

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 1643 字符。

## 摘要

在本教程中，我们将介绍为镜头之间的关卡序列创建淡入淡出轨道的默认方法，然后继续介绍如何创建自定义...

## 中文整理

### 默认淡入淡出轨道

第一个图/GIF 显示了普通虚幻引擎/音序器附带的默认淡入淡出轨道。默认情况下，淡入淡出轨道只是完全纯色屏幕和完全透明屏幕之间不透明度的动画。你不能改变颜色或任何东西。如果：我们希望淡入淡出为更复杂的颜色怎么办？喜欢 2 种或更多颜色或某种形状？我们希望淡入淡出更多的是一种过渡，从左向右滑动？



### 基于 UMG 的淡入淡出轨道

对于自定义淡入淡出轨道，您可以使用 UMG。您可能已经知道，UMG 小部件允许您控制 2D 元素的多个属性。例如颜色和位置。形状等...所以在我们的例子中，我们希望淡入淡出为绿色：只需创建一个带有绿色边框的小部件。 （注意：您可以用 UMG 支持的任何内容替换边框）。我们想要为滑入和滑出的过渡设置动画：只需为小部件的位置设置动画即可。在本演示中，我们将使用 UMG Cinematics 插件。 UMG Cinematics 插件图/GIF 2 显示了使用 UMG Cinematics 插件进行的转换。该插件只是简化了在音序器/关卡序列中使用小部件的过程。如果没有它，您仍然可以在定序器中使用小部件，但是您需要使用事件跟踪等并手动调用创建小部件，这使得过程很麻烦。结论：您可以在没有插件的情况下执行此操作，但您需要使用事件跟踪并调用“添加到视口”。但如果您是一位想要节省时间的电影制作人，强烈推荐该插件！使用该插件的工作流程类似于在 After Effects 或其他线性编辑应用程序中工作/ - UMG 电影插件 - 插件 - 电影



## 相关链接

- [UMG Cinematics plugin.](https://www.unrealengine.com/marketplace/en-US/product/umg-cinematics)
- [UMG Cinematics Plugin](https://unrealengine.com/marketplace/en-US/product/umg-cinematics)
- [Default Fade Track](https://dev.epicgames.com/community/learning/tutorials/Ya7b/unreal-engine-creating-custom-fade-tracks-transitions-in-sequencer#defaultfadetrack)
- [UMG Based Fade Tracks](https://dev.epicgames.com/community/learning/tutorials/Ya7b/unreal-engine-creating-custom-fade-tracks-transitions-in-sequencer#umgbasedfadetracks)
- [实用链接](https://dev.epicgames.com/community/learning/tutorials/Ya7b/unreal-engine-creating-custom-fade-tracks-transitions-in-sequencer#%E5%AE%9E%E7%94%A8%E9%93%BE%E6%8E%A5)


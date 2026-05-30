# 延迟增强输入操作的“完成”事件 (Part 1/3)

Source file: `unreal-engine-delaying-the-enhanced-input-action-s-completed-event.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/kYx8/unreal-engine-delaying-the-enhanced-input-action-s-completed-event
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 12429 字符。
## 摘要

本教程将研究如何延迟新的增强输入操作系统的“完成”事件。我将扩展我不久前制作的教程（链接位于“有用链接”下的末尾），其中我使用新的增强输入系统重新创建了旧轴映射。
## 中文整理
### 背景：

很久以前（在不远的星系中），我发布了一篇教程，介绍了我如何怀念连续玩家输入（即车辆转向）的传统轴映射。在[旧版轴映射与增强型输入操作行为](https://dev.epicgames.com/community/learning/tutorials/pv90/unreal-engine-legacy-axis-mapping-using-enhanced-inputs)部分中，我使用车辆模板项目来演示旧版输入系统和新输入系统之间的主要区别之一。总之，**传统轴映射在**每个刻度（永远）中连续触发，而**增强输入仅在按下绑定键时触发**。对于输入操作节点，工具提示中有一条注释：我发现此更改非常烦人，因为这意味着我需要创建一个函数，该函数将变量显式重置为某个默认值（例如汽车转向为 0）并将其连接到 Tick 事件或计时器 - 对于每个行为类似的变量。我之前教程中的解决方案很好，但遗漏了一件重要的事情。假设我有一个连续设置为 0 的变量。如果非玩家交互（例如 AI）改变了该变量的值，那么它将（几乎立即）返回到零。这意味着非玩家交互基本上被忽略了。有一些解决方案涉及在不需要时阻止玩家输入，但就我而言，这还不够，因为我需要在玩家输入和 AI 输入之间平滑移动。我找到了一种延迟输入操作的“完成”事件的方法，而不是连续触发输入操作。这有效地将传统输入系统和增强输入系统融合在一起。当按下某个键时，输入动作将触发每个刻度。当松开按键时，输入动作将持续触发指定的时间。此后，输入操作将停止触发并触发“Completed”事件。
### 主要教程：

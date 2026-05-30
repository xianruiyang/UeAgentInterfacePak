# HMD 佩戴状态和 SteamVR

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/rmYd/unreal-engine-hmd-worn-state-and-steamvr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2265 字符。

## 摘要

2020 年 9 月 16 日。知识 HMD 佩戴状态和 SteamVR 文章，作者：Branden T。在制作 VR 应用程序时，有时了解玩家是否佩戴 HMD 很有用。有一个函数和对应的...

## 中文整理

### 概览

2020 年 9 月 16 日。了解 HMD 佩戴状态和 SteamVR *文章作者：[Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner)* 在制作 VR 应用程序时，有时了解玩家是否佩戴 HMD 很有用。为此，有一个名为“获取 HMD 佩戴状态”的函数和相应的蓝图节点。它将返回“磨损”、“未磨损”或“未知”。大多数 VR 平台都有一个 API 函数，我们可以调用它来获取此状态信息，并且结果通常更新得相当快。 SteamVR 可能是一个例外。 SteamVR 有一些注意事项，例如 HMD 需要始终进行跟踪才能改变磨损状态，并且需要移动超过 *Engine.ini 中定义的 HMDWornMovementThreshold 的距离。 SteamVR 也总是需要很长（约 60 秒）的不活动时间，并且 HMD 需要在整个时间内进行跟踪才能发送 VREvent_TrackedDeviceUserInteractionEnded 事件。如果您在 HMD 未被跟踪且佩戴状态为“未知”的情况下开始游戏，则必须将其移至跟踪区域以便被跟踪，并保持静止（最多 60 秒）使其进入“未佩戴”状态（当 SteamVR 发送 VREvent_TrackedDeviceUserInteractionEnded 事件时），然后它才会进入“佩戴”状态（当 SteamVR 发送 VREvent_TrackedDeviceUserInteractionStarted 事件时）。如果 HMD 处于“未知”状态，则不会发生 Started 事件；在 SteamVR 发送 Started 事件之前，它必须进入“Not Worn”状态一次。看起来这个功能是在SteamVR端控制的（比如进入“Not Worn”状态之前的60秒超时），并且我们似乎无法在UE4端控制它。因此，如果您期望在玩家戴上或摘下 HMD 后立即更新 HMD 的状态，恐怕您无法通过 SteamVR 获得这种即时性，而且如果玩家不小心在没有跟踪耳机的情况下开始游戏，您还需要让玩家将耳机放在跟踪区域约 1 分钟。

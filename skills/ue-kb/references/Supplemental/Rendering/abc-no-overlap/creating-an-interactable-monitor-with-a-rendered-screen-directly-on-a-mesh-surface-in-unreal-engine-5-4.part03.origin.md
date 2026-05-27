# 在虚幻引擎 5.4 中直接在网格表面上创建具有渲染屏幕的可交互监视器（续 3）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4
- 原始文件：creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4.origin.md
- 分段：第 3/3 段

您可以扩展它以适应键盘或更多功能，但是，我只需要一个简单的“触摸式”交互，因此“按指针键”节点足以满足此用例。

从这里开始，让我们继续收集 Widget 大小和 Widget Interaction 相对位置，以计算虚拟光标的 0,0 位置，以便稍后代码可以通过 UV 坐标偏移该位置。

我通过获取 Widget 交互位置并将其减去 Widget 绘制大小的一半来计算此值。

在这种情况下，将仅使用 Widget Interaction 的 Y 和 Z 位置，使其与 Widget 保持恒定距离，并且仅在其左侧和向上向量上移动它。

现在，Widget Interaction 已偏移，从界面事件中获取 UV 坐标，并将其用在两个 lerp 节点上，每个轴一个作为 Alpha 值，然后添加到 Widget Interaction 相对位置，将其移动到所需位置。

如前所述，在这里您可以...

### 5. 总结。

## 相关链接

- [The Base Mesh](https://www.thebasemesh.com/)
- [Medium](https://medium.com/@oncgm/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-833df82819cf)
- [How to build the monitor:](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#howtobuildthemonitor:)
- [1. What will be needed to replicate this monitor.](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#1whatwillbeneededtoreplicatethismonitor)
- [2. First, Let’s Prepare our UVs.](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#2first,let%E2%80%99sprepareouruvs)
- [3. Unreal Setup — Part One.](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#3unrealsetup%E2%80%94partone)
- [4. Unreal Setup — Part Two.](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#4unrealsetup%E2%80%94parttwo)
- [5. Wrapping up.](https://dev.epicgames.com/community/learning/tutorials/V2Lq/creating-an-interactable-monitor-with-a-rendered-screen-directly-on-a-mesh-surface-in-unreal-engine-5-4#5wrappingup)

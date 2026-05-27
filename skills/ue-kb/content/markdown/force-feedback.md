# Force Feedback

---
title: "Force Feedback"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/force-feedback-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "输入", "Force Feedback"]
---

# Force Feedback

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 输入 / Force Feedback

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/force-feedback-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**力反馈** 是设备振动，常用于游戏中向玩家传达游戏内发生的力反馈。对于手柄或控制器，此功能也称为“rumble”或控制器振动。例如，可以使用力反馈模拟游戏中爆炸发生时的冲击波，从而增加玩家沉浸感。

许多常见平台都支持力反馈，例如 iOS、Android 以及主机输入控制器。

> [!WARNING]
> 某些反馈功能的支持取决于平台。完整细节请参阅对应平台开发文档。

## 力反馈效果结构

A **力反馈效果** 资产包含用于定义特定力反馈效果的属性。这让设计师可以针对不同情况自定义力反馈。

![Force Feedback Details](../../../../assets/images/75/755ed3589643dc0827cd7605d301726ae192ffb7b8d90e3040c384696c694b42.png)

### 通道详情

力反馈效果可以包含多个通道。每个 **通道** 都可以播放不同效果。例如，一个通道可以在控制器右侧播放幅度大且持续较长的振动，而第二个通道可以在左侧播放短促的小幅振动。

每个通道都有以下属性，用于控制通道效果的播放方式：

| 通道名称 | 说明 |
| --- | --- |
| **影响左大马达** | 如果为 true，将使用左侧大马达播放效果。 |
| **影响左小马达** | 如果为 true，将使用左侧小马达播放效果。 |
| **影响右大马达** | 如果为 true，将使用右侧大马达播放效果。 |
| **影响右小马达** | 如果为 true，将使用右侧小马达播放效果。 |
| **曲线** | 控制效果随时间变化的强度。它定义振动模式。大于 0.0 的值会产生振动，小于 0.0 的值不会产生振动。 |

#### 力反馈曲线

每个通道的效果模式由曲线控制。可以在内部曲线编辑器中通过以下方式向曲线添加关键帧：

- 右键单击并选择添加关键帧。
- 双击曲线图表以打开内部曲线编辑器。

![Internal Curve Editor](../../../../assets/images/3c/3cd7ac07763bea802980295f12baf50269d958fdd8ca613789c73f315c4f563c.png)

> [!TIP]
> 关于曲线、关键帧、创建外部曲线资产以及使用曲线编辑器的信息，请参阅 [曲线编辑器](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/animation-curve-editor/index.md) 和 页面。

### 按设备覆盖

在 Unreal Engine 中使用力反馈资产时，每个平台对振动马达或反馈系统的实现方式都不同。力反馈资产使用 **按设备覆盖** 来支持多个平台。

按设备覆盖是一个抽象层，可为每个平台设置不同反馈配置。例如，可以为 Xbox 控制器应用强烈振动，同时为 PlayStation 控制器应用更细致、更微妙的振动。

要修改这些设置，点击力反馈效果，然后导航到 **细节** > **按设备覆盖**.

![Per Device Overrides](../../../../assets/images/40/40e2404bc596ffa206227ef8c44ca4a44713294483e9cbadb6432b1f182f33c2.png)

### 设备属性

**设备属性** 表示输入设备的不同物理属性，例如灯光颜色显示或触觉扳机阻力。

| 设备属性类型 | 说明 |
| --- | --- |
| **基于音频的振动** | 向输入设备的扬声器播放声音。在支持的平台上，该声音会以振动形式播放，其中左右音频通道分别代表控制器的左右两侧。此功能为实验性功能，并且仅适用于 PS5 DualSense 控制器。要使用此功能，需要将以下内容添加到配置中。 C++ `[SonyController] VibrationMode=Advanced` |
|  | [SonyController] |
|  | VibrationMode=Advanced |
| **设备颜色（曲线）** | 使用曲线随时间改变输入设备灯光颜色。此属性具有平台特定实现，不同平台上的行为可能不同。 |
| **设备颜色（静态）** | 将输入设备颜色设置为静态颜色。该属性完成求值后不会重置设备颜色。可以将其理解为一次性效果：启用后即设置设备属性颜色。此属性具有平台特定实现，不同平台上的行为可能不同。 |
| **扳机反馈** | 设置简单扳机反馈。此属性具有平台特定实现，不同平台上的行为可能不同。 |
| **扳机阻力** | 在扳机被按下并处于起始值和结束值之间时，提供线性阻力。此属性具有平台特定实现，不同平台上的行为可能不同。 |
| **扳机振动** | 设置扳机振动。此属性具有平台特定实现，不同平台上的行为可能不同。 |

请参阅 [设备属性](device-properties/index.md) 获取更多文档。

### 持续时间

力反馈效果的持续时间会根据所有通道曲线中最后一个关键帧的位置自动计算。例如，如果有 3 个通道，并且每个通道中的最后一个关键帧值分别设置为 `1.25`, `1.5`和 `1.75`，则整体效果的持续时间为 `1.75`

## 创建力反馈效果资产

力反馈效果资产通过 **内容浏览器**:

1. 在 **内容浏览器**中，点击 **添加** 并选择 **输入 > 力反馈效果**。打开刚创建的资产。
2. 默认情况下，该资产有一个通道，但可以添加更多通道。对于每个通道，选择希望该通道影响的四个输出组合。
3. 按住 **Shift** and click the **鼠标左键** 在曲线上点击，以添加一个或多个关键帧。
4. 可以直接输入值或在曲线编辑器中拖拽关键帧来操作它们。

   > [!NOTE]
   > 要调整关键帧之间的曲线，右键单击曲线段以更改曲线函数，然后调整切线。

## 播放力反馈

### 在编辑器中预览

将鼠标悬停在力反馈效果图标上时，点击图标中央出现的“播放”按钮，即可在编辑器中预览力反馈效果。

### 直接播放给玩家

力反馈在基础 `PlayerController` 类中实现。要在目标设备或控制器上播放力反馈，需要访问本地 Player Controller。

### 在蓝图中播放力反馈

1. 获取 Player Controller 的引用，可以使用 **Get Player Controller** 节点或已保存的引用。
2. 从该引用的输出引脚拖出，然后输入 `Play Force Feedback` 到上下文菜单中并选择 **Client Play Force Feedback**.

   > [!NOTE]
   > 如果在服务器上调用，力反馈会复制到拥有客户端。
3. 直接在节点上指定要使用的力反馈效果，或通过连接的变量指定。
4. 勾选 **循环** ，如果希望效果循环播放。
5. 可选地，在 Tag 字段中为效果设置唯一名称。此功能允许停止效果；如果同名效果已经在播放，它会停止并改为播放新效果。

### 在 C++ 中播放力反馈

可以在本地 Player Controller 上调用 [ClientPlayForceFeedback](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/APlayerController/ClientPlayForceFeedback?application_version=5.5) 。

C++

```
void ClientPlayForceFeedback	(		class UForceFeedbackEffect * ForceFeedbackEffect,		FForceFeedbackParameters Params	)
```

随后可以使用力反馈效果，指定效果是否循环，并可选地为效果选择名称。如果提供了名称，并且原效果结束前播放了另一个同名力反馈效果，则原效果会立即停止并改为播放新效果。

#### 在 World 位置

可以将 [力反馈组件](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UForceFeedbackComponent?application_version=5.5) 放置在预期源效果的 World 位置。它会播放一个力反馈效果，并根据观察它的玩家距离改变强度。

力反馈组件可按命令播放力反馈效果，同时在 World 中拥有物理位置。与声音或光照类似，玩家体验到的力反馈强度会根据玩家到源的距离，按照数据定义的衰减设置变化。

力反馈组件可以通过源代码或蓝图附加到任何 Actor，并可在 Gameplay 期间动态添加。也可以使用以下实用函数：

- `UGameplayStatics::SpawnForceFeedbackAtLocation`：在给定 World 位置生成
- `UGameplayStatics::SpawnForceFeedbackAttached`：附加到特定的既有组件

这些函数会返回生成的力反馈组件，因此可以继续操作它。不过，如果效果播放完毕后不再需要该组件，请使用 Auto Destroy 布尔选项在效果结束后移除组件。


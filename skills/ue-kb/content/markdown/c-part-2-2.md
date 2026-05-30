# 使用游戏标签 C++ 增强输入绑定 (Part 2/2)

# 使用游戏标签 C++ 增强输入绑定 (Part 2/2)

Source file: `unreal-engine-enhanced-input-binding-with-gameplay-tags-c.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 输入映射上下文

输入映射上下文允许我们将硬件输入映射到输入操作。它们可以分层、区分优先级，还可以根据上下文应用自己的输入触发器和修饰符。例如，W 键可以映射到步行时的“移动”输入操作。如果玩家控制车辆，则可以应用新的输入映射上下文，将 W 键映射到“油门”输入动作，并修改要在几帧上插值的值以实现平滑效果。在此示例中，我们将把游戏手柄和键盘/鼠标拆分为单独的上下文，但这可能不是必需的，具体取决于您的游戏。
### 键盘和鼠标

通过在内容浏览器中右键单击并选择“输入”->“输入映射上下文”来创建输入映射上下文资源。我将我的资产命名为 IMC_KBMDefault。
### 移动

我们将分别使用经典的 WASD 键映射来表示向前、向左平移、向后和向右平移。二进制键报告 0-1 或 On-Off 的布尔值。当映射到 IA_Move 输入操作中指定的 Vector2D 输入值时，默认情况下，此 0-1 值将添加到 X 轴。因此，按下 W、A、S 和 D 时，其结果均为 (1,0)。这就是修饰符发挥作用的地方。通过使用“Swizzle”修改器，我们可以将关键点转换为不同的轴。因此，如果我们向 W 和 S 键添加 Swizzle(YXZ) 修饰符，它们都会报告 (0,1)。在 S 键上添加一个额外的“否定（Y）”修饰符将在按下时为我们提供（0，-1）。现在我们可以用 W 和 S 键表示 (0,1) 到 (0,-1) 范围，以向前和向后移动我们的角色。默认情况下，A 和 D 键已经在 X 轴上，因此我们只需要在 A 键上添加一个“否定（X）”修饰符来表示（-1,0）到（1,0）范围内的角色左右扫射。

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-08.jpg)
### 鼠标外观

将另一个条目添加到 IA_MouseLook 输入操作的 IMC_KBMDefault 输入映射上下文中。我们只需要一个键绑定，**鼠标 XY 2D 轴**。我们已经在 IA_MouseLook 输入操作中添加了“Negate(Y)”修饰符，因此在映射上下文中不需要任何修饰符。
### 跳跃和射击

在我们的示例中，跳跃和开火是不需要修饰符或触发器的简单操作，因此只需将它们映射到适当的键即可。我使用传统的空格键进行跳跃，使用鼠标左键进行射击。

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-09.jpg)
### 游戏手柄

游戏手柄的输入映射上下文要简单得多，因为操纵杆输出 2D 轴值，这些值自然映射到外观和移动输入操作。您需要将“DeadZone”修改器添加到移动和外观条目中以防止漂移。创建一个新的输入映射上下文 (ICM_GamePad) 并添加以下条目。

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-10.jpg)
### 角色蓝图

输入系统已经实现，所有输入资源也已配置，因此设置角色蓝图是最后一步！我正在使用第一人称模板，因此我将修改 BP_FirstPersonCharacter 蓝图。 1. 在角色蓝图的详细信息面板中设置输入配置属性，使其指向我们之前创建的 IC_BaseCharacter 输入配置资源。 2. OnBeginPlay 通过EnhancedInputLocalPlayerSubsystem 添加键盘/鼠标和游戏手柄映射上下文。在运输项目中，您可能希望有一些逻辑，在连接游戏手柄时以更高的优先级应用游戏手柄映射上下文，但这超出了本教程的范围。 3. 在游戏模式或世界设置中将您的角色蓝图设置为默认 Pawn。
### 概括

回顾过去，我们实现了一个基础输入系统，该系统利用增强型输入系统和游戏标签来实现可配置性。首先，我们创建了本机游戏标签来描述输入并使用资源管理器加载它们。接下来，我们创建了一个数据资产来将输入标签映射到输入操作，并使用该数据将输入操作绑定到我们的原生角色的操作。然后我们创建了所有必要的资产来定义和配置我们的输入。最后，我们通过设置角色蓝图来使用该系统，将所有这些结合在一起。
### 下一步

此示例的设置与 Lyra 非常相似，但它排除了 Lyra 的许多高级功能，以使本教程更容易理解。我建议下载 Lyra 示例并深入研究其代码和内容，以获取如何将此方法与游戏能力系统、模块化游戏系统和运行时玩家控件重新映射集成的示例。进一步扩展此示例的想法： - 仅使用输入系统实现全自动或三轮连发射击。 - 实施带有冷却时间的冲刺机制。 - 使用此输入系统应用标签并使用游戏能力系统激活能力。 - [Lyra 示例游戏](https://docs.unrealengine.com/5.0/en-US/lyra-sample-game-in-unreal-engine) - [增强输入](https://docs.unrealengine.com/5.0/en-US/enhanced-input-in-unreal-engine)
## 相关链接

- [Lyra Sample Game](https://docs.unrealengine.com/5.0/en-US/lyra-sample-game-in-unreal-engine)
- [Enhanced Input](https://docs.unrealengine.com/5.0/en-US/enhanced-input-in-unreal-engine)


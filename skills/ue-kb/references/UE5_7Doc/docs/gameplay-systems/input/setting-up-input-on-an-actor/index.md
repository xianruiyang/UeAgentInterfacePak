---
title: "设置Actor的输入"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-input-on-an-actor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "输入", "设置Actor的输入"]
---

# 设置Actor的输入

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 输入 / 设置Actor的输入

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-input-on-an-actor-in-unreal-engine

在开发游戏时，你有时可能会希望让玩家对关卡中的Actor执行某种形式的**输入**。 例如，也许你希望玩家在靠近一个藏宝箱时能打开它，或者你希望他们能打开/关闭一盏灯，或在玩家按下按钮时以某种方式影响一些其它形式的交互对象。

为Actor设置输入能让你在一定程度上控制Actor如何及何时响应玩家的输入。

## 实现指南

本指南介绍以下基础方法： **启用输入** or **禁用输入** 用于 Actor。通过为 Actor 启用输入，可以允许玩家按下按钮或按键，并执行以某种方式影响 Actor 的事件，例如打开或关闭灯、打开或关闭门、激活某个对象等。

“启用/禁用输入用法”章节还介绍了一种使用 **触发体积** 判断玩家是否靠近关卡中 Actor 的启用/禁用输入方法。当你希望玩家只有在 Actor 附近或范围内，符合现实场景中可影响该 Actor 的条件时才能影响它，这种方法很有用。

### 启用 Actor 输入

> [!NOTE]
> 本示例使用 **带 Starter Content 的蓝图第一人称模板**.

以下步骤展示如何为 Actor 启用输入：

1. 在 **StarterContent/Blueprints** 文件夹中，打开 **Blueprint_Effect_Fire** 资产。
2. 在 **事件图表** 标签页中， **右键单击** 图表并搜索，然后添加 **Event Begin Play** 节点。
3. 在图表中， **右键单击** 搜索并添加 **Get Player Controller** 节点。
4. 在图表中， **右键单击** 搜索并添加 **启用输入** 节点。
5. 将以下节点的输出引脚连接到 **Event Begin Play** 的输入引脚： **启用输入** 节点。
6. 将 **Get Player Controller** 节点连接到输入 **Player Controller** 引脚，目标节点是 **启用输入** 节点。

   这是为 Actor 启用输入的基本方法。

该 **启用输入** 节点要求指定 **目标** （通常为 Self，即 Actor 本身）以及 **Player Controller** （将提供输入的玩家）。完成此设置后，就可以搜索并添加 **输入事件** 节点（例如按键或鼠标按钮按下），并在这些按键被按下时执行影响 Actor 的操作。

在上面的示例中， **Event Begin Play** 节点表示当游戏开始时（前提是该 Actor 存在于关卡中）， **启用输入** 会为指定的 **Player Controller** 。默认 Player Controller 对单人游戏使用 **Player Index 0** ；如果是多人游戏场景，可以通过 **Player Index** 值指定具体玩家。

### 禁用 Actor 输入

正如可以为 Actor 启用输入一样，也可以使用 **禁用输入** 节点。

在上面的示例中，我们使用前述方法为 Actor 启用输入，然后添加了 **E** 按键事件。当 **E** 键被按下时，会在屏幕上打印一些文本，然后禁用 Actor 输入，使玩家不能再向该 Actor 提供输入。

与 **启用输入** node, the **禁用输入** 节点要求指定 **目标** 和 **Player Controller** 一样，也需要指定。

### 启用/禁用输入用法

虽然上述方法可以启用/禁用输入，但通常需要一些规则来控制何时允许 Actor 接收玩家输入。假设使用上面在 Event Begin Play 中启用输入的方法，并设置一个按键来开关灯，那么玩家将可以从 World 中任何位置开关该灯。

我们希望根据玩家是否靠近灯来启用/禁用输入，如下所示：

1. 在 **StarterContent/Blueprints** 文件夹中，打开 **Blueprint_CeilingLight** 资产。
2. In the **组件** 面板中点击 **添加组件**，然后搜索并添加 **Sphere Collision**.
3. In the **细节** 面板中，设置 **变量名称** to **Trigger**, the **Z 变换** to **-180.0**, and **缩放** 用于 **X, Y, Z** to **8**.

   我们将根据玩家在球体内部还是外部，启用输入（在内部时）或禁用输入（在外部时）。
4. 返回 **事件图表**.
5. In the **我的蓝图** 窗口， **右键单击** 在 **Trigger** 并选择 **添加事件 -> 添加 OnComponentBeginOverlap**.
6. **右键单击** on **Trigger** 再次选择 **添加事件 -> 添加 OnComponentEndOverlap**.

   这两个事件节点应添加到图表中。
7. 从 **Other Actor** 引脚拖出，该引脚属于 Begin Overlap 节点，然后搜索并添加 **Cast To FirstPersonCharacter** 节点。

   这里表示当名为 **FirstPersonCharacter** 的 Actor（项目模板的默认玩家角色）与 **Trigger**重叠时，执行某些操作。
8. 从 **Other Actor** 引脚拖出，该引脚属于 End Overlap 节点，并添加 **Cast To FirstPersonCharacter** 节点。
9. **右键单击** and add the **Get Player Controller** 节点， **启用输入**, and **禁用输入** 节点。
10. 按下图所示连接节点。

    现在，只有玩家进入触发器时才会启用输入，玩家离开触发器时会禁用输入。这样可以防止玩家从 World 中任意位置影响该 Actor，并将影响范围限制在创建的触发体积内部。
11. **右键单击** and add the **E** 按键事件，并连接到 **Print String** 节点。
12. **编译** 和 **保存**，然后关闭蓝图。（如果收到警告，请忽略并继续下一步。）
13. 将 **Blueprint_CeilingLight** 拖入关卡，然后点击 **播放** 按钮在编辑器中运行。

运行时，如果在远离灯的位置按下 **E** ，不会发生任何事情。当靠近灯（位于触发器内）并按下 **E**时，文本 **Hello** 应显示在窗口左上角。本示例连接了一个 **Print String** 节点；不过，当玩家位于触发球体内并按下按键时，也可以切换灯光颜色、强度或其他设置。

### 输入详情

替换上方示例中的 **E** 按键事件，尝试使用 **空格键** 按键事件。运行编辑器时，注意会发生什么。在灯的触发器外按下 **空格键** 可以跳跃；但是进入触发器并按下 **空格键**时，不再跳跃，而是调用 **Print String** 并显示文本 **Hello**；这是由于 **输入优先级**.

当输入命令共享时（此处 Jump 与灯中分配的输入都绑定到 **空格键**），较低优先级的动作会被忽略。在灯蓝图中，如果点击 **空格键** 按键事件并查看 **细节** 面板，应能看到一个选项： **消耗输入**.

如果取消勾选 **消耗输入** 复选框并再次在编辑器中运行，现在应该可以在灯的触发体积内外都跳跃。当位于灯的触发体积内时，按下 **空格键** 也会调用 **Print String** 节点，并显示 **Hello** 文本。

同样在 **输入详情** 窗口中，还有以下选项： **暂停时执行** （允许在暂停状态下按下按键并执行命令）以及 **覆盖父绑定** （允许移除父类中设置的任何绑定）。

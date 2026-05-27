---
title: "使用模板序列"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/template-sequences-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "使用模板序列"]
---

# 使用模板序列

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / 使用模板序列

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/template-sequences-in-unreal-engine

模板序列功能让你可以通过单根绑定 **绑定Actor类（Bound Actor Class）** 来重复使用包含多个资产的序列。绑定Actor类指定模板序列要在其上运行的 actor类型，且该模板可以在多个序列中重复使用。 你可以创建要重复使用的特定轨道或整个序列，并将其关联至特定对象绑定，类似于如何在任何兼容的骨架网格体上 播放骨骼动画。此外，可以像任何其他序列一样控制和编辑模板序列。

在使用模板序列时，绑定actor在序列中显示为可生成，而你可以根据需要操控actor并对其进行动画处理。在应用模板序列时， 如果模板映射到现有actor，则不会生成新的actor。你还可以将模板序列用作包含在主序列中的 独立序列。

模板序列还可通过绑定Actor类指定 **电影摄像机Actor（Cine Camera Actor）**，从而简化摄像机动画的使用。这会自动将电影摄像机Actor设置为 模板中的主摄像机，并设置何时在序列中使用模板。

在本教程中，我们将使用电影摄像机Actor作为我们的绑定Actor类。

> [!NOTE]
> 此功能目前为试用版。最后，此功能将取代摄像机动画，而摄像机动画使用的是Matinee。

## 设置模板序列

1. 在内容浏览器中的动画下，**添加（Add）** **模板序列（Template Sequence）**。
2. 使用下拉菜单，设置 **绑定Actor类（Bound Actor Class）**。例如，如果此序列将用于对摄像机进行动画处理，请将类设置为 **电影摄像机Actor（Cine Camera Actor）**。这会创建 可生成的摄像机actor。

   另一个示例是，当对角色进行动画处理时，你可以将 **绑定Actor类（Bound Actor Class）** 设置为角色的蓝图类。这会创建可生成的角色actor。

   > [!NOTE]
   > 或者，你也可以创建 **摄像机动画序列（Camera Animation Sequence）**。这样创建的模板序列实际上已将绑定Actor类设置为电影摄像机Actor。
3. 用常规方法在序列中设置你的关键帧。。对于 **电影摄像机Actor（Cine Camera Actor）**，是摄像机转换中的关键帧。你还可以将其他动画导入到转换轨道， 例如FBX动画。

## 播放关卡序列中的模板序列动画

设置模板序列之后，你就可以在关卡序列中使用它。

1. 创建新的 **关卡序列（Level Sequence）** 或打开现有关卡序列。
2. 将 **电影摄像机Actor（Cine Camera Actor）** 添加到你的关卡，然后将摄像机添加为序列中的轨道。
3. 在摄像机轨道上，选择 **+ 轨道（+Track）** > **摄像机动画（Camera Animation）**，然后选择你的模板序列。对于非摄像机Actor，可以在 **模板动画（Template Animation）** 下 找到模板序列。

> [!NOTE]
> 子轨道菜单与上下文相关，仅仅显示使用与轨道兼容的绑定Actor类的模板序列。 例如，尝试将摄像机的动画附加到静态网格体是不可行的，动画将不会显示在静态网格体的子菜单选项中。

模板序列现在是序列的组成部分，将会对其所在的actor进行动画处理。在这种情况下，模板序列在概念上类似于角色上播放的 骨骼动画剪辑：它可以拉伸、修剪、循环等。

## 将模板序列创建为独立动画

通过创建模板序列播放器并绑定你要在播放器中播放的actor，可以仅播放 **模板序列（Template Sequence）** （不播放另一个关卡序列）。

1. 打开关卡蓝图。添加节点 **Create Template Sequence Player**。
2. 在模板序列资产（Template Sequence Asset）下拉菜单下，选择你之前创建的模板序列。
3. 从播放器中调用 **设置绑定（Set Binding）**，并将 **输出Actor（Out Actor）** 连接到 **Target** 引脚。
4. 在世界大纲视图中，将电影摄像机Actor拖放到蓝图。将其连接到Actor引脚。
5. 最后，调用 **Play To** 节点，并将Player节点中的返回值附加至"播放到"目标。

在执行时，此蓝图逻辑将会创建新的 **模板序列Actor（Template Sequence Actor）** 和 **模板序列播放器（Template Sequence Player）**，将其绑定到现有的电影摄像机，然后将 指定的模板序列中的动画播放到Actor。

> [!NOTE]
> 使用蓝图将模板序列分配到actor的操作不依赖于上下文，这与在Sequencer中使用轨道不同。这意味着你可以附加不一致的actor和模板， 这会导致运行时错误和其他意外结果。

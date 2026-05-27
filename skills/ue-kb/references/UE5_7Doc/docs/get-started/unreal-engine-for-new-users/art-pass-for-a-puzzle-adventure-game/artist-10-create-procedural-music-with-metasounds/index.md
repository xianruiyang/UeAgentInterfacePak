---
title: "创建程序化音乐"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/artist-10-create-procedural-music-with-metasounds"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "解谜冒险游戏美术创作指南", "创建程序化音乐"]
---

# 创建程序化音乐

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 解谜冒险游戏美术创作指南 / 创建程序化音乐

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/artist-10-create-procedural-music-with-metasounds

在本教程中，你将学习如何使用**MetaSounds**创建程序化音乐。 你将为自己的冒险游戏创建程序化生成的背景音乐。

MetaSounds是一个高性能音频系统，它可以使用基于节点的系统生成声音源，其方式类似于蓝图可视化脚本系统。

## 开始之前

请确保你已掌握[虚幻引擎新用户指南](../../index.md)文档中涵盖的以下内容：

- 蓝图基础知识，例如如何添加和连接节点。

## 使用MetaSounds创建程序化音乐

你将从创建一个MetaSound资产开始。 执行以下步骤：

1. 进入**内容****浏览器**，导航到**Content > AdventureGame > Artist > Audio**文件夹。
2. 在**音频（Audio）**文件夹中，创建一个名为**Music**的新文件夹。
3. 在**音乐（Music）**文件夹中右键单击，然后选择**Audio > MetaSound Source**。
4. 将该资产命名为`MS_BGM`，即**MetaSound背景音乐**。
5. 打开该资产。

该资产将在**MetaSound编辑器**中打开。 在新窗口中，你将在图表中看到三个节点——**Input**、**Output On Finished**和**Input Out Mono**。

该音频源被播放时就会执行**Input**触发器。 一个MetaSound总是从一个Input开始。

执行**Output On Finished**触发器，从而停止播放该音源。 如果你在其他地方（例如蓝图）停止音频，就不需要使用这个节点来停止音频源播放。 在本例中，你将使用蓝图来启动和停止音频，因此不需要使用这个节点。

**Output** **Out Mono**节点表示MetaSound图表的最终音频输出，它会将所有上游音频信号汇总并输出为单声道（mono）音频。 任何连接到该节点的节点，都会被混合处理，并作为声音的输出发送到引擎。

## 设置音乐节奏与节拍

首先，你将创建一些节点来设置音乐的节奏和节拍。 执行以下步骤：

1. 拖出**Input**节点的引脚，并添加一个**Trigger Repeat**节点。
2. 在**Trigger** **Repeat**节点上，拖出**Period**引脚，并添加一个**BPM To Seconds**节点。 将**全音分法（Divisions of** **Whole Note）**设置为**16**。
3. 在**BPM To Seconds**节点上，拖出**BPM**引脚并选择**提升为图表输入（Promote to Graph Input）**。
4. 在屏幕左上角**成员（Members）**面板中将**Input**的名称从**BPM**重命名为**Note In**。
5. 在**细节**面板中，将**Note In**节点的**默认值**改为**60**。 你也可以在节点底部更改该值。
6. 从**Trigger Repeat**节点拖出**RepeatOut**引脚，并添加一个新的**Trigger** **Counter**节点。
7. 选择**Trigger Counter**节点，并将**重置计数（Reset Count）**设置为**8**。

这一部分用于设置节奏和节拍。 此外，你可以选中你添加的四个节点——**Trigger Counter**、**Trigger Repeat**、**BPM To Seconds**和**Input**，然后按**C**键，添加一个包含这些节点的注释框。 将该注释框命名为**Tempo and Rhythm**。

## 生成旋律

接下来，你将创建功能逻辑，利用你定义的节奏和拍子生成旋律。 执行以下步骤：

1. 在**Trigger Counter**节点中：

   1. 拖出**On Trigger**引脚，并添加一个**Random** **Get** **(Float:Array)**节点。
   2. 拖出**Trigger** **Counter**节点**On** **Reset**引脚，并将其连接到**Random Get**节点的**Reset引脚**。
2. 从**Random Get**节点中，拖出**In Array**引脚并添加一个**Scale to Note Array**节点。
3. 从**Scale to Note Array**节点拖出**Scale Degrees**引脚，选择**提升为图表输入（Promote to Graph Input）**，并将其命名为**Scale**。
4. 从**Random** **Get**节点拖出**Seed**引脚，并添加一个**Random (Int)**节点。
5. 从**Random (Int)**节点中，拖出**Next**引脚并连接到**Trigger Counter**节点的**On Reset**引脚。

这一部分用于生成旋律。 你也可以选中所有新添加的节点，并添加一个名为**旋律生成（Melody Generation）**的注释框。

## 合成旋律

接下来，你将通过创建合成（Synthesis）来塑造旋律的实际声音效果。 这意味着要将生成的旋律音符转换为可听到的声音。 执行以下步骤：

1. 在**Random Get**节点上，拖出**Value**引脚，并添加一个**Add (Float)**节点。
2. 在**Add**节点上，将第二个输入引脚的值从0改为**48**。
3. 从**Add**节点中，拖出**exec**引脚并添加一个**MIDI To Frequency** **(Float)**节点。
4. 从**MIDI To Frequency (Float)**节点拖出**Out Frequency**引脚，并添加一个**Sine**节点。
5. 从**Sine**节点拖出**Audio**输出引脚，并添加一个**Add (Audio)**节点。
6. 你还需要再添加一个**Sine**节点，并将其连接到该**Add**节点。 然后，从**Add**节点拖出另一个输入引脚，并添加一个**Sine**节点。
7. 在新的**Sine**节点上，拖出**Frequency**引脚，并添加一个**MIDI To Frequency (Float)**节点。
8. 从**MIDI To Frequency**节点中，拖出**MIDI In**引脚并添加一个**Add (Float)**节点。
9. 在**Add**节点上：

   1. 将第一个输入引脚连接到与第一个**Sine**节点相连的**Add**节点。
   2. 拖出第二个输入引脚并选择**提升为图表输入（Promote to Graph Input）**。 将其命名为**Detune**。
   3. 选择**Detune**输入，并在**细节**面板中将其**范围（Range）**改为**0**和**12**。
   4. 在**细节**面板中，将**默认值**更改为**12**。

现在，你已经合成了将要生成的旋律。 你可以再次为这个新部分添加一个注释框，并将其命名为**Synthesis**。

## 使用包络（Envelope）塑造声音

接下来，你将添加一个包络来塑造声音随时间变化的方式，通过控制声音的开始、持续和淡出，使其听起来更加自然。

要添加一个包络（Envelope），请执行以下操作：

1. 滚动到你之前创建的旋律生成部分（如果你添加了注释框，它应该命名为**Melody Generation**）。 从**Random Get (Float:Array)**节点拖出**On** **Next**引脚，并添加一个**AD Envelope (Audio)**节点。 将这个新节点移动到你在合成部分添加的两个Sine节点之后。
2. 从该节点拖出**Out Envelope**引脚，并添加一个**Multiply (Audio)**节点。
3. 从这个**Multiply**节点拖出第二个输入引脚，并将其连接到你之前连接了两个**Sine**节点的**Add (Audio)**节点的输出引脚。
4. 在**AD Envelope (Audio)**节点上，将**衰减时间（Decay Time）**改为**0.2**。
5. 从**Multiply (Audio)**节点中，拖出输出引脚并连接到MetaSound Source中已有的**Output****Out** **Mono**节点。

现在，在MetaSound Source窗口顶部工具栏附近点击**播放**按钮。 它将持续播放程序化生成的音乐。

如果想了解更多关于在虚幻引擎中制作程序化音乐的内容，请参阅[使用MetaSound创建程序化音乐](../../../../working-with-audio/sound-source/metasounds/creating-procedural-music-with-metasounds/index.md)页面。

## 使用蓝图在游戏中播放音乐

在继续操作之前，你将创建一个蓝图，用于在关卡中播放背景音乐。

由于这个蓝图会被添加到关卡中，但本身没有可见的模型表示，因此你需要在蓝图中添加一个**广告牌（Billboard）**组件。 该组件会添加一个2D Sprite，使其在编辑器中可见，方便你在编辑关卡时找到它，但它不会在游戏中显示。

要创建背景音乐蓝图，请执行以下操作：

1. 前往**内容****浏览器**，并导航到**Content > AdventureGame > Artist > Audio > Music**。
2. 右键创建一个新的**蓝图类（Blueprint Class）**，并让它继承自**Actor**父类。 将其命名为**BP_BGM**，表示蓝图背景音乐（Blueprint Background Music）。
3. 在**组件**面板中，点击**添加**，然后添加一个**广告牌**组件。 在**细节**面板中，你可以看到**Sprite**默认设置为**S_Actor**。 你可以更改Sprite，也可以保持默认设置。
4. 前往**事件图表**选项卡开始构建功能逻辑。
5. 从**Event****BeginPlay**节点拖出连接线，并添加一个**Branch**节点。
6. 从**Branch**节点拖出**Condition**引脚，并选择**提升为变量（Promote to Variable）**。 将此变量命名为**Active**。 该变量将用于判断这个音频源是否处于激活状态。
7. 在**我的蓝图**面板中的**变量（Variables）**列表里，点击**Active**变量旁边的**眼睛**图标，使其处于打开状态，这样该变量就会变为公开，并且可以在关卡编辑器中进行编辑。
8. **编译**蓝图，并在**细节**面板中确认**Active**变量的**默认值**为**true**（启用）。
9. 从**Branch**节点拖出**True**引脚，并添加一个**Play Sound 2D**节点。
10. 在**Play Sound 2D**节点上，使用下拉菜单将**Sound**引脚设置为**MS_BGM**。
11. 在**Play Sound 2D**节点中，点击向下箭头以展开节点选项。 拖出**音量乘数（Volume Multiplier）**引脚，并选择**提升为变量（Promote to Variable）**。
12. 点击变量的**眼睛**图标，使其公开并且可编辑，然后**编译**蓝图，并将其**默认值**更改为**0.5**。
13. 保存并编译你的蓝图。

在**Play Sound 2D**节点中，“**2D**” 表示该声音的播放不会受到玩家在关卡中位置的影响。 换句话说，该声音不会在三维空间中进行空间化处理，因此距离和方向不会影响玩家听到的效果。

## 在游戏中测试音乐

现在你可以返回关卡编辑器，并将**BP_BGM**蓝图添加到关卡中。

在关卡中选择**BP_BGM**Actor，然后在**细节**面板中确认你添加的两个变量已正确设置：**Active**应处于**开启**状态，而**音量乘数（Volume Multiplier）**应设置为**0.5**。

你可以尝试不同的音量乘数值，看看哪种最适合你的使用场景。 由于这是背景音乐，你可能希望将音量设置为较低值，以保持其作为背景音的效果。

现在，可以开始游戏测试了。 此时，你应该能够听到自己创建的音乐在背景中播放。

## 下一步

在下一个模块中，你将学习如何为玩家角色添加动态脚步声效果，使其在不同类型的地面上行走时播放不同的声音。

- [为角色添加脚步声](../artist-11-add-footstep-sounds-to-a-character/index.md) - 让角色在不同地面材质上移动时产生不同的脚步声。

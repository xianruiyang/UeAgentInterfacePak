---
title: "陷阱和伤害"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/designer-07-traps-and-damage-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "设计解谜冒险游戏", "陷阱和伤害"]
---

# 陷阱和伤害

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 设计解谜冒险游戏 / 陷阱和伤害

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/designer-07-traps-and-damage-in-unreal-engine

环境危险因素可以在塑造Gameplay方面发挥着重要作用。 通过使用危险因素和陷阱，你可以为玩家增添行为的后果，并随着他们在解谜或关卡中取得进展而提升相应的难度和紧张感。

在教程系列的这个部分中，你将创建可以对玩家造成伤害的尖刺陷阱和火焰陷阱。 然后，你需要将火焰陷阱和开关的Gameplay对象连接起来，创建新的Gameplay机制和谜题。

现在玩家会承受伤害并失去所有生命值，你还需要设置一个结束并重新启动游戏的失败条件，让玩家有重试的机会。

## 开始之前

请确保你已掌握[设计解谜冒险游戏](../index.md)前几节讲述的以下内容：

- 蓝图基础知识，如变量、函数、事件图表和添加节点。
- 使用蓝图接口事件来切换另一个Gameplay对象。

你需要准备好在[创建钥匙](../designer-02-create-a-key/index.md)和[谜题：开关和立方体](../designer-05-puzzles-switches-and-cubes/index.md)中创建的下列资产：

- `M_BasicColor`材质和`M_BasicColor_Red`材质实例
- `BPI_Interaction`蓝图接口
- `BP_Switch`蓝图类

## 构建一组相关蓝图类

在本教程系列中，你已经见过使用父节点-子节点关系和继承的虚幻引擎资产。 **继承（Inheritance）**意味着创建一个新的子节点，该子节点复用并扩展现有父节点的功能。 子类可以在这些功能的基础上进行扩展，而无需更改父节点。 继承可以在许多资产中复用功能，而不是手动将它们添加到每个新资产，从而节省你的时间。

你的材质实例资源会从其父材质继承功能。 在之前的许多蓝图中，你已经创建了从父节点继承变换数据的组件。

游戏中通常会设置不同类型的危险因素，但它们的核心功能基本都是相同的。 父节点陷阱蓝图可以定义这些共享的功能，而每个子节点陷阱蓝图都可以扩展这些功能，添加不同的视觉效果和行为。

你的基础（父节点）陷阱需要检测玩家重叠，并使用伤害游戏机制逐渐减少玩家的生命值。 然后你将创建（或子类化）子陷阱，以扩展基本陷阱的功能并添加额外的视觉效果或行为。 尖刺陷阱会在外观上添加额外的静态网格体，而火焰陷阱会添加火焰效果和行为，使其能够打开和关闭。

你的关卡仍处于布局阶段，所以要创建每个陷阱的简化版本，以便为未来的视觉效果设计提供参考。

## 创建基础陷阱蓝图

首先我们要创建基础陷阱蓝图类，作为特殊陷阱的父节点和基础。

要创建定义通用陷阱功能的蓝图，请按照下列步骤操作：

1. 在**内容浏览器**中，找到**Content > AdventureGame > Designer > Blueprints**文件夹，然后创建一个名为`Traps`的新文件夹。
2. 在**Trap**文件夹中，右键点击或点击**添加（Add）**，然后创建新的**蓝图类**。
3. 在`Pick Parent Class`窗口中，单击**Actor**。
4. 将此类命名为`BP_TrapBase`并将其打开。

### 添加组件

对于基础陷阱，你可以创建粗模的静态网格体以显示陷阱的边界。 所有陷阱还需要碰撞体积，以便在玩家踩踏它们时发现。

要创建基础陷阱的物理组件，请执行以下步骤：

1. 在**组件（Components）**选项卡中，点击**添加（Add）**，然后搜索并添加**立方体**静态网格体形状。
2. 将网格体组件命名为`TrapBase`。
3. 在**细节**面板的**变换（Transform）**下，将立方体的**缩放（Scale）**更改为`2`, `2`, `0.1`，以创建扁平的正方形底面。
4. 在**组件（Components）**选项卡中，选择**TrapBase**，点击**添加（Add）**，然后搜索并选择**盒体碰撞**组件。
5. 将碰撞组件命名为`TrapTrigger`。 这是玩家站在陷阱上时用于检测的碰撞体积。

   > [!NOTE]
   > 就像`BP_Switch`一样，你要把碰撞组件附加到网格体，如果你想更改陷阱的大小，触发器区域也会自动调整。
6. 在**细节**面板的**变换（Transform）**下，更改以下属性，在基础网格体上方创建一个大的碰撞盒体：

   1. 将**位置（Location）**设置为`0`、`0`、`400`。
   2. 将**缩放**设置为`1.5`, `1.5`, `12`。

### 添加变量后的面板

所有陷阱还需要可编辑的属性，以便进行自定义：

- 危险是激活还是不激活。
- 陷阱对玩家造成的伤害。
- 伤害间隔，或两次命中之间的时间。

并且陷阱需要知道是谁与它碰撞。

要将常用属性添加到基础陷阱，请执行以下步骤：

1. 在**我的蓝图（My Blueprint）**选项卡中，创建以下变量：

   |  |  |  |  |
   | --- | --- | --- | --- |
   | **变量名称** | **类型** | **类别** | **默认值** |
   | Active | 布尔（Boolean） | 设置 | True |
   | BaseDamage | 浮点（Float） | 设置 | 5.0 |
   | DamageInterval | 浮点（Float） | 设置 | 1.0 |

   > [!NOTE]
   > 创建变量后，编译蓝图以添加默认值。
2. 点击每个变量的眼睛图标，打开眼睛，使所有三个变量都可编辑并公开。
3. 添加一个名为`OtherActor`的变量，并将类型更改为**Actor (Object Reference)（Actor（对象引用））**。

### 创建应用伤害的函数

现在你的陷阱有了基本属性，可以开始创建陷阱的行为了。 当玩家与碰撞体积重叠时，所有陷阱都会定期降低玩家的生命值（HP）。

虚幻引擎有许多内置的常见游戏机制解决方案，包括施加和接收伤害。

对于陷阱，你将使用内置的**Apply Damage**函数节点。 我们要整理一下伤害处理的逻辑，创建自己的函数，在陷阱处于激活状态时，对接触陷阱的所有角色调用**Apply Damage**。

请按照以下步骤，创建一个对玩家造成陷阱伤害的函数：

1. 在**函数**选项中，点击**添加**。 将此函数命名为`fnApplyDamageToTargets`并打开其图表。
2. 你只想在陷阱打开并激活时施加伤害，因此要添加一个**Branch**节点，其中**Condition**是对**Active**变量的引用（Get）。
3. 之后的教程中，你将添加一些NPC敌人，以便同时有多个Actor位于陷阱上。 因此，当陷阱处于激活状态时，循环遍历所有接触陷阱的Actor的数组：

   1. 将**Branch**节点的**True**引脚连接到**For Each Loop**节点。
   2. 对于循环的**数组**输入，你需要创建所有重叠Actor的数组。 虚幻引擎会自动为你执行此操作，即添加**Get Overlapping Actors (TrapTrigger)**节点。 该节点还有对**目标****TrapTrigger**的引用。
   3. 在**Get Overlapping Actors**节点中，将**Class Filter**更改为**Character**，以便可以将玩家和NPC角色添加到数组。
4. 对于每个数组元素或循环的每个迭代，将**BaseDamage**变量中设置的伤害量应用于该数组元素中的Actor。 为此，将**Apply Damage**节点连接到**Loop Body**。

   > [!NOTE]
   > **Apply Damage**函数来自虚幻引擎Game Statics库。 右上角的图标表示该函数可以在联网游戏中使用，并且可以在服务器上运行。
5. 设置**Apply Damage**节点：

   1. 对于**Damaged Actor**引脚，要连接循环的**Array Element**。
   2. 对于**Base Damage**引脚，将引用连接到**BaseDamage**变量。

6. **保存**并**编译**蓝图。

完整的**fnApplyDamageToTarget**函数应如下所示：

Blueprint

fn Apply Damage To Target

Branch

Condition

True

False

Active

ForEachLoop

Exec

Array

Loop Body

Array Element

Array Index

Completed

Get Overlapping Actors

Target

Class Filter

Character

Overlapping Actors

Trap Trigger

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

> [!NOTE]
> 如果你要将此代码片段复制并粘贴到项目中的相应图表中，请将函数条目节点连接到**Branch**节点。

### 创建随时间施加伤害的定时器

接下来，你需要让陷阱定期调用apply-damage函数。 因此要使用虚幻引擎的一种定时器函数来创建定时器。

在此蓝图中，你将使用**Set Timer by Function Name**

此节点会创建定时器并将函数绑定到该定时器，以便在定时器到期时，节点调用该函数，执行该函数中的所有操作。

要在游戏开始时设置定时器，请执行以下步骤：

1. 找到`BP_TrapBase`的**事件图表**选项卡。 删除**Event ActorBeginOverlap**和**Event Tick**节点。
2. 在陷阱执行任何操作之前，你需要检查它是否已激活。 从**Event BeginPlay**节点添加一个**Branch**节点，其中**Condition**是对**Active**变量的引用。
3. 从**Branch**节点的**True**引脚，创建**Set Timer by Function Name**节点。
4. 设置定时器节点：

   1. 对于**Time**引脚，连接对**DamageInterval**变量的引用。
   2. 点击**Function Name**旁边的文本框，并输入`fnApplyDamageToTarget`。

      > [!WARNING]
      > 确保你正确拼写了函数名称，否则逻辑将无法正确执行。
   3. 启用**Looping（循环）**。
5. **Set Timer**节点会输出一个名为"**Timer Handle**的返回值，其作用类似于定时器的跟踪编号或控制器。 要停止、暂停或恢复定时器，就会引用此定时器句柄，因此要把它保存在新变量中：

   1. 在**我的蓝图**面板中，创建一个名为`TimerHandler`的新变量。 将其类型更改为**计时器句柄（Timer Handle）**。
   2. 添加**Set Timer Handler**节点，并将其连接到**Set Timer by Event**的返回值和执行引脚。
6. 在虚幻引擎创建定时器时，它会立即开始运行，因此你需要暂停定时器，直到有角色踩到陷阱。 连接**Pause Timer by Handle**节点并为其提供**TimerHandler**。
7. **保存**并**编译**蓝图。

> [!NOTE]
> 你还可以使用**Set Timer by Event**节点创建定时器。 这里你会使用节点操作列表来**添加自定义事件**，并将其用作**委托**，将操作绑定到定时器。
>
> 自定义事件是可重复使用的命名逻辑块，类似于函数。 与函数不同，它们可以包含延迟、时间轴节点和其他操作，因此你可能需要随着游戏复杂性的增加而使用这种方法。
>
> 连接事件的方形委托引脚，以将该事件的引用传递到定时器节点。 这不会触发事件，而是存储事件及其操作以备后用（时间间隔到期时）。

### 开始和停止伤害

你已经创建并暂停了伤害定时器，它已准备就绪，蓄势待发。 现在我们要使伤害在角色踏上陷阱的碰撞体积时恢复，并在角色停止与体积重叠时暂停。

请按照以下步骤，添加用于启动伤害的逻辑：

1. 在**组件（Components）**面板中，右键点击**TrapTrigger**组件，转到**添加事件（Add Event）**，然后选择**添加OnComponentBeginOverlap（Add OnComponentBeginOverlap）**。
2. 事件之后，连接**Set Other Actor**节点，将重叠的Actor保存在变量中。
3. 连接事件和**Set**节点的**Other Actor**引脚。
4. 连接**fnApplyDamageToTarget**节点，使角色在接触陷阱时立即受到伤害。
5. 连接**Unpause Timer by Handle**节点以恢复定时器和伤害间隔。 对于**Handle input**，将引用连接到**TimerHandler**变量。

请按照以下步骤，添加用于停止持续伤害的逻辑：

1. 右键点击**TrapTrigger**组件，找到**添加事件（Add Event）> 在组件结束重叠时（On Component End Overlap）**。
2. 事件结束后，连接**Pause Timer by Handle**节点，再次为其提供**TimerHandler**的引用。
3. **保存**并**编译**蓝图。

陷阱现在会创建、启动和暂停伤害定时器。

完成后的`BP_TrapBase`事件图表应如下所示：

Blueprint

Event BeginPlay

Branch

Condition

True

False

Active

SetTimer

Object

Function Name

fnApplyDamageToTarget

Time

Looping

Max Once Per Frame

Return Value

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

有关定时器和定时器管理的更多信息，请参阅[Gameplay定时器](../../../../gameplay-systems/gameplay-framework/gameplay-timers/index.md)。

### 测试基础陷阱

要测试陷阱，请添加一条打印字符串（Print String）消息，该消息在陷阱施加伤害时在屏幕上进行报告。

要在屏幕上打印消息，显示陷阱正在按预期工作，请执行以下步骤：

1. 在`BP_TrapBase`中，转到**fnApplyDamageToTarget**选项卡。
2. 在函数的图表中，在**Apply Damage**节点后面连接一个**Print String**节点。
3. 将**In String**更改为`Player hit!`
4. 点击**Print String**节点底部的箭头以显示更多选项，并将**Duration**更改为`5`。 这样就可以更方便地查看随时间推移而造成的损害。
5. **编译**并**保存**此蓝图。 在**内容浏览器**中，将`BP_TrapBase`的实例拖动到你的关卡中。
6. 运行关卡并踩踏陷阱。 新的"Player hit!"消息应该每秒显示一次。

## 创建尖刺陷阱子类

完成父类以后就可以开始创建子类了！

首先，你要创建一个尖刺陷阱，它会修改基础陷阱的外观，添加一些形状语言。 普通的扁平陷阱看起来并不危险，但玩家看到将带有尖刺的东西就知道它可能会造成伤害。

要创建尖刺陷阱，请按照以下步骤操作：

1. 在**内容浏览器**的**Traps**文件夹中，右键点击`BP_TrapBase`，然后选择**Create Child Blueprint Class**。
2. 将蓝图类命名为`BP_TrapSpikes`并将其打开。
3. 在**组件（Components）**选项卡中，选中**DefaultSceneRoot**，点击**添加（Add）**，然后搜索并选择**椎体（Cone）**。

   你可以调整椎体的大小和位置以适应四行排列，每行四个椎体（或总共16个椎体）。
4. 在锥体的**细节**面板的**变换**选项中，更改以下属性：

   1. 将**位置**更改为`-75`、`-75`、`25`。
   2. 将**缩放**更改为`0.5`、`0.5`、`0.4`。

   现在在基础网格体的边角处有一个更小的尖刺。
5. 要获得一定的视觉对比度，在**材质（Materials）**选项中，使用下拉菜单将锥体的材质更改为`M_BasicColor_Red`。
6. 选择并复制（**Ctrl+D**）椎体3次，将每个椎体平移50个单位，以便它们在基础网格体的一侧排成一行。

   > [!TIP]
   > 你可以在细节面板或视口中重新定位椎体。 要更快地使用控件进行调整，请将平移对齐设置更改为50个单位。
7. 按住**Ctrl**键选择所有四个锥体并复制它们。 在**组件（Components）**面板中，选择四个新椎体（它们将具有最大的数字后缀），并将其移动50个单位。 重复此操作两次，以创建4x4的锥体网格。
8. 尖刺中的斜面和角度可能会使玩家很难离开陷阱。 要防止玩家卡在在尖刺之间，请在尖刺顶部添加一个不可见的地板：

   1. 在**组件（Components）**选项卡中，复制**TrapBase**网格体并将其命名为`InvisFloor`。
   2. 将地板上移，这样在地板上方只能看到尖刺的尖端。
   3. 在**细节**面板的**碰撞（Collision）选项**中，确保**碰撞预设（Collision Presets）**设置为**BlockAllDynamic**。 这会阻止所有Actor穿过模型。
   4. 在**渲染（Rendering）**分段中，禁用**可见（Visible）**。 这会在视口中和Gameplay期间隐藏模型。
9. 在**组件（Components）**选项卡中，选择**TrapBase**网格体。 在**细节**面板的**渲染（Rendering）**选项中，启用**在游戏中隐藏（Hidden in Game）**。 这会使网格体在视口中可见，但在Gameplay期间将其隐藏，因此你只会看到尖刺。
10. **保存**并**编译**蓝图。

尖刺陷阱子类具有基础陷阱的所有行为，因此它被触发的时候还会打印"Player hit!"。 将`BP_TrapSpikes`的实例拖到你的关卡中并进行测试！

## 创建火焰陷阱子类

接下来，我们要创建一种陷阱来扩展基本陷阱的行为。 火焰陷阱会增加危险性，但玩家可以使用开关将其关闭，这也是一种可以转化为新谜题的Gameplay机制。

在[谜题：开关和立方体](../designer-05-puzzles-switches-and-cubes/index.md)中，你创建了`BPI_Interaction`蓝图接口，开关可以使用它来打开和关闭其他Gameplay对象。 你还可以在陷阱蓝图中使用此接口，以便开关可以在Gameplay期间更改陷阱的Active变量。

首先，你需要一个新材质，以便在陷阱停用时使用。

要为火焰陷阱创建黑色材质，请按照以下步骤操作：

1. 在**内容浏览器**中，转到 **AdventureGame > Designer > Materials**文件夹。
2. 右键点击`M_BasicColor`并选择**创建材质实例（Create Material Instance）**。
3. 将材质实例命名为`M_BasicColor_Black`并将其打开。
4. 展开**全局向量参数值（Global Vector Parameter Values）**，启用**颜色（Color）**，然后点击色条将其更改为深灰色（十六进制值 sRGB = `3D3B3BFF`）。 这在游戏中会比纯黑色的观感更好。
5. 保存并关闭材质实例。

要对火焰陷阱进行子类化，请执行以下步骤：

1. 在**内容浏览器**中，右键点击`BP_TrapBase`并选择**创建子蓝图类（Create Child Blueprint Class）**。
2. 将蓝图命名为`BP_TrapFire`并将其打开。
3. 更改基础网格体的颜色，使其代表火焰陷阱。 选择**TrapBase**组件，在**细节**面板的**材质**选项中，将材质更改为`M_BasicColor_Red`。
4. 在视口上方，点击**类设置（Class Settings）**。
5. 在**细节**面板的**接口**分段中，在**实现的接口**旁边，点击**添加**，然后搜索并选择`BPI_Interaction`。

   在**我的蓝图（My Blueprint）**面板中，**fnBPISwitchOff**和**fnBPISwitchOn**事件函数会出现在接口（Interfaces）分段中。
6. 就像`BP_Switch`一样，为火焰陷阱设置可自定义的材质：

   1. 在**我的蓝图（My Blueprint）**面板的**变量（Variables）**分段中，创建名为`OffMaterial`和`OnMaterial`的两个变量。
   2. 将其类型更改为**材质接口（对象引用）[Material Interface (Object Reference)]**。
   3. 点击其眼睛图标，将其设为公开可编辑。
   4. 将**类别**更改为**Setup**。
   5. 编译并设置以下默认值：

      - **OffMaterial**：`M_BaseColor_Black`
      - **OnMaterial**: `M_BaseColor_Red`
7. **保存**并**编译**该蓝图，这样可以在陷阱事件图表中使用接口事件。

### 扩展陷阱的行为

就像你在[谜题：移动平台](../designer-06-puzzles-moving-platforms/index.md)中创建移动平台一样，你需要设置陷阱的事件图表，以便在开关调用**fnBPISwitchOn**和**fnBPISwitchOff**时执行以下操作：

- 激活或停用陷阱。
- 更改陷阱的材质。

对于移动平台，你需要让平台在玩家激活开关时开始移动。 对于陷阱，你需要相反的东西 — 关卡开始时陷阱处于激活状态，并且应该在玩家激活开关时关闭。

要添加在玩家按下开关时停用火焰陷阱的逻辑，请执行以下步骤：

1. 转到火焰陷阱的**事件图表（EventGraph）**选项卡。 在**我的蓝图（My Blueprint）**面板的**接口（Interfaces）**列表中，双击**fnBPIButtonOn**以将事件节点添加到图表。
2. `BP_TrapBase变量不会出现在`**我的蓝图（My Blueprint）**面板中，但你可以通过节点操作列表访问它们。 从**Event fnBPISwitchOn**节点的**执行**引脚拖出引脚，搜索`active variable`，然后选择**Set Active**。 保持**Active**禁用状态。
3. 在**Set**节点后，连接**Set Material (TrapBase)**节点（在操作列表的**渲染（Rendering）> 材质（Material）**分段中）。
4. 在**Set Material**节点中，将对**OffMaterial**变量的引用连接到**材质**引脚。

要添加在开关停用时激活火焰陷阱的逻辑，请执行以下步骤：

1. 在**接口（Interfaces）**分段中，双击**Event fnBPISwitchOff**以添加该节点。
2. 事件之后，连接**Set Active**变量节点，但这次启用**Active**。
3. 在**Set**节点之后，连接**Set Material (TrapBase)**节点并连接对**OnMaterial**的引用。
4. **保存**并**编译**蓝图。

完成后，你的完整火焰陷阱事件图表应如下图所示：

Blueprint

Event fnBPISwitchOn

SET

Active

Set Material

Target

Element Index

0

Material

Trap Base

Event fnBPISwitchOff

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

将`BP_TrapFire`的实例添加到关卡中试一试！

## 使用玩家生命值更新HUD

是时候将这些Print String节点替换为一些针对玩家的真实反馈了。 你需要更改HUD，以便实时报告玩家的生命值。

### 将HP变量添加到HUD

要将动态玩家生命值添加到HUD，请执行以下步骤：

1. 在**内容浏览器**中，打开你的`WBP_PlayerHUD`控件蓝图。 确保你在**设计器**视图中。
2. 在**层级（Hierarchy）**中，点击**txtHP**控件。 在**细节**面板中，启用**是变量**并从**文本（Text）**属性中删除**100**。
3. 转到**图表**视图并设置一个新函数来设置**txtHP**的值：

   1. 在**函数（Functions）**分段中，添加名为**fnSetHP**的新函数。
   2. 选择函数后，在**细节**面板中，点击**输入（Inputs）**旁边的**+**。
   3. 将输入参数命名 `NewHP`，并将其类型更改为**浮点数**。

      稍后，你将更改玩家角色，使其在受到伤害时调用此函数。
4. 在**fnSetHP**函数的图表中，在函数入口节点后，连接**SetText (Text)**节点。

   > [!TIP]
   > **如果你在节点操作列表中找不到节点，请禁用上下文关联（Context Sensitive）。**
5. 设置**SetText (Text)**节点：

   1. 对于**Target**，将引用连接到**txtHP**变量。 这是显示玩家生命值的文本控件。
   2. 对于**In Text**，连接函数条目节点的**New HP**输入引脚。 虚幻引擎会自动添加**To Text (Float)**节点来转换数值。
   3. **保存**并**编译**控件蓝图。

完整的**fnSetHP**函数图表如下所示：

Blueprint

fn Set HP

New HP

Set Text

Target

In Text

Txt HP

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

> [!NOTE]
> 如果是将此蓝图代码段复制到图表中，则需要将函数入口节点连接到**SetText**和**To Text**节点。

### 显示玩家的初始生命值

在显示任何可用的HUD变量之前设置它们。 在本例中，你知道玩家的初始生命值，因此可以在游戏开始时显示该信息。

要更新玩家角色蓝图以在HUD上显示其HP，请执行以下步骤：

1. 在**内容浏览器**中，打开`BP_AdventureCharacter`蓝图。 在事件图表中，找到**Event Possessed**逻辑。

   > [!NOTE]
   > 在**我的蓝图（My Blueprint）**面板中，展开**图表（Graphs）** > **事件图表（EventGraph）**并双击图表中的**Event Possessed**以选中它。
2. 在**Set**节点和**Add to Viewport**节点之间，连接一个**fnSetHP**节点：

   1. 对于**目标**，使用**Set**节点的输出引脚使HUD成为目标。
   2. 将**New HP**的引用连接到玩家的**Health**变量。
3. 确保**Add to Viewport**节点的**Target**引脚也连接到**HUD**变量节点。
4. 在**我的蓝图（My Blueprint）** 面板中，点击**Health**变量。 在**细节**面板中，更改（或保留）默认值。 本教程使用的初始生命值为**100**。
5. **保存**和**编译**。

玩家的新**Event Possessed**逻辑应如下所示：

Blueprint

Event Possessed

New Controller

Parent:Receive Possessed

New Controller

Create WBP Player HUD C Widget

Class

WBP_PlayerHUD_C

Owning Player

Return Value

SET

HUD

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

> [!NOTE]
> 如果要将此逻辑复制到你的项目中，请首先删除现有的**Event Possessed**逻辑组。

现在HUD会在游戏开始时显示玩家的生命值。 最后需要的逻辑是在玩家受到伤害时更新HUD。 为此，我们要修改角色的现有伤害处理逻辑，以使用你的HUD。

### 在受到伤害后更新玩家的生命值

请按照以下步骤，处理对玩家造成的伤害：

1. 在`BP_AdventureCharacter`事件图表的左下角，找到以**Event AnyDamage**节点开头的标记为**Damage and death handling**的逻辑分段。 我们要修改此分段，改为执行你自己的逻辑。
2. 删除**Branch**节点之后的所有节点。 保留**Branch**节点。

   > [!NOTE]
   > 此逻辑分段使用**运算符节点（operator node）**来执行计算。 当角色受到伤害时，**Event AnyDamage**节点会触发，传递有关造成的伤害、伤害类型以及发起伤害的控制器和Actor的信息。 接下来，从角色的**Health**变量中减去伤害值。 减去生命值后，**Branch**节点会检查玩家的生命值是否已达到0。
3. 现在，你需要构建在玩家生命值大于0时更新HUD的逻辑。 因此，从**False**引脚连接**FnSetHP**节点，将新的生命值发送到HUD。
4. 设置**fnSetHP**节点：

   1. 对于**Target**，将引用连接到角色的**HUD**变量。
   2. 对于**New HP**输入，连接对**Health**变量的引用。
5. **保存**并**编译**蓝图。

现在HUD会显示玩家的当前生命值，并在玩家受到伤害时更新该数值。

> [!TIP]
> 返回到`BP_TrapBase`蓝图，删除添加到基础陷阱事件图表中的所有**Print String**节点。

再次运行游戏并测试一下！

## 创建失败和重生条件

当玩家的生命值耗尽并被淘汰时，就需要停止游戏，并让玩家有机会重试。 在本教程中，你将禁用玩家的功能按钮，告知玩家他们已经输掉游戏，并加载关卡。

首先，你将创建一个游戏结束控件蓝图，告诉玩家他们已被淘汰。

### 添加游戏结束界面显示

要为游戏结束画面创建控件蓝图，请按照以下步骤操作：

1. 在**内容浏览器**的**AdventureGame > Designer > Blueprints > Widgets**文件夹中，右键点击，找到**用户界面（User Interface）**，然后选择**控件蓝图（Widget Blueprint）**。
2. 在**选取父类（Pick Parent Class）**窗口中，点击**用户控件（User Widget）**。
3. 将控件蓝图命名为`WBP_EliminationScreen`并将其打开。

要设置游戏结束UI，请执行以下步骤：

1. 在**控制板（Palette）**选项卡中，搜索canvas并将一个**画布面板（Canvas Panel）**拖到**层级（Hierarchy）**中的**[WBP_EliminationScreen]**上。 就像HUD一样，这个画布就是根控件。
2. 画布上将显示游戏结束信息，并叠加一层模糊效果，使文本更易于阅读。 从**控制板（Palette）**选项卡中，拖动**覆层（Overlay）**以成为画布的子项。
3. 选择覆层后，在**细节**面板的插槽（画布面板插槽）（Slot (Canvas Panel Slot)分段中，展开**锚点（Anchors）**，并将**最大值（Maximum）**（**X**和**Y**）更改为`1`。

   其他插槽属性（**锚点（Anchors）**下方）更改为**偏移（Offset）**设置。

   > [!NOTE]
   > 当构建HUD时，你要将所有锚点保留在一个角落，因此如果屏幕尺寸发生变化，这些对象就仍会锚定到该锚点。 现在覆层会锚点到整个画布的边界盒体，从而会收缩或拉伸以匹配屏幕尺寸。
4. 当你更改锚点设置时，编辑器会更改一些偏移值，以维持覆层面板的默认形状。 要删除此项，请将**向右偏移（Offset Right）**和**底部偏移（Offset Bottom）**更改为`0`。 现在覆层将填满整个屏幕。
5. 从**控制板（Palette）**选项卡中，拖出一个**背景模糊（Background Blur）**控件，使其成为**覆层（Overlay）**面板的子项。
6. 选择模糊效果后，在**细节**面板的**插槽（覆层插槽）[Slot (Overlay Slot)]**分段中，更改：

   1. **水平对齐**为**水平填充**。
   2. **垂直对齐**为**垂直填充**。
7. 在**外观（Appearance）分**段中，将**模糊强度****（Blur Strength）**更改为`5。`
8. 从**控制板（Palette）**选项卡中，添加**文本（Text）**控件作为**覆层（Overlay）**的子项。
9. 选中**文本（Text）**控件后，在**细节**面板的**插槽（覆盖插槽）（Slot (Overlay Slot)）**分段中，更改：

   1. **水平对齐**为**水平居中对齐**。
   2. **垂直对齐**为**垂直居中对齐**。
10. 在**内容（Content）**选项中，将**文本（Text）**更改为`You are deleted…restarting the level（你已经被淘汰…正在重启关卡）。`
11. 转到**外观（Appearance）**部分，通过配置以下属性，使文本更清晰易读：

    1. 点击**颜色和不透明度（Color and Opacity）**旁边的色条，并为文本选取颜色。 本教程使用粉色（颜色**十六进制sRGB** = `FF4D7AFF`）。
    2. 展开**字体（Font）**标题栏，并将**大小（Size）**更改为`60`。
    3. 展开**字体（Font）>轮廓设置（Outline Settings）**，并将**轮廓大小（Outline Size）**更改为`1`。

12. **保存**并**编译**蓝图。

### 为失败条件构建逻辑

现在你有了游戏结束的显示界面，我们还要修改角色类，在玩家耗尽生命值时显示它。 当出现这种情况时，执行会传递你之前使用的那个Branch节点的True结果。

要处理玩家失败，你需要：

- 禁用玩家输入，使玩家无法移动。
- 显示游戏结束界面。
- 在设定的时间后重新启动关卡。

要在玩家被淘汰时停止并加载游戏，请执行以下步骤：

1. 在`BP_AdventurePlayer`中，返回到角色蓝图中的伤害处理逻辑（从**Event AnyDamage**开始）。
2. 在**Branch**节点的**True**执行引脚之后，连接**Do Once**节点和**Disable Input**节点。

   玩家在生命值耗尽后仍可能被击中，因此Do Once节点可以确保之后的逻辑仅执行一次。
3. **对于Disable Input**节点的**Player Controller**引脚，连接**Get Player Controller**节点（在节点操作列表的**Game > Player**分段中）。

   > [!NOTE]
   > 有几个名为**Get Player Controller**的节点。 确保该节点具有**Player Index**输入引脚。 索引**0**是生成到关卡中的第一个玩家角色的默认索引。
4. 禁用玩家控制器后，创建并显示游戏结束界面：

   1. 连接**Create Widget**节点。 在该节点中，将**Class**更改为`WBP_EliminationScreen`。
   2. 将控件节点的**执行**和**Return Value**引脚连接到**Add to Viewport**节点。
5. 添加时间延迟，获取当前关卡名称，然后加载该关卡：

   1. 在添加到**Add to Viewport**节点后，连接一个**Delay**节点并将**Duration**更改为`5`秒。
   2. 在**Delay**之后连接**Get Current Level Name**节点。
   3. 在**Get Current Level Name**之后连接一个**Open Level (by Name)**节点。
   4. 将**Return Value**引脚连接到**Level Name**引脚。 编辑器会自动添加一个字符串-to-name conversion节点。
6. **保存**并**编译**你的玩家蓝图。

现在，`BP_AdventureCharacter`事件图表的这一部分应与下图一致：

Blueprint

Event Destroyed

Get Game Mode

Return Value

Increment Team Score

Target

Team Byte

Do Once

Reset

Start Closed

Completed

Event AnyDamage

Damage

Damage Type

Instigated By

Damage Causer

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

> [!NOTE]
> 如果要将此逻辑复制到你的项目中，请首先删除节点的现有**Damage**处理组（包括**Event AnyDamage**和**Event Destroyed**逻辑）。

运行关卡以进行测试。 去踩到陷阱，让你的角色失去所有生命值，并确保游戏按预期重置。

## 为谜题添加危险因素

在[谜题：开关和立方体](../designer-05-puzzles-switches-and-cubes/index.md)中，你学习了如何设计能增加难度、紧张感、后果以及风险回报决策的游戏机制。 对玩家造成伤害的环境危险可以形成机制，让玩家的行为带来后果。 你可以使用尖刺陷阱为关卡中的早期谜题和障碍物增加危险性和额外后果，而开关驱动的火焰陷阱可以创建更具动态的谜题，让玩家与环境互动，从而打开安全的路径。

在设计游戏时，要减少开销并提高开发速度，关键是找到多种不同的方法来使用和组合Gameplay对象。 在本系列教程的上一小节中，我们介绍了基于开关的平台如何创建前进的道路。 在这里，同一个开关可以关闭火焰陷阱，为玩家显明道路。 这增加了关卡的多样性，也不需要无穷无尽的独特系统。

与本教程系列之前创建的门与钥匙机制类似，火焰陷阱也是一种机制，用来控制玩家的行进速度以及能够进入哪些区域。

### 创建带有火焰陷阱的迷宫谜题

在Room 2中，你将结合开关和火焰陷阱来构建一个神奇的谜题，玩家必须小心地排除所有危险，找到并收集最后一把钥匙。

先在纸上画出谜题的草图通常会对你有所帮助。 由于陷阱的大小为1m x 1m，示例Room 2可以容纳7 x 9的陷阱网格。 首先绘制一条穿过网格并在钥匙处结束的路径。 然后，将路径划分为多个片段，并放置开关来控制每个片段。

要增加难度并创造更多的惊喜和出其不意的效果，请添加阻挡视线的建筑功能。 例如，将开关放置在墙壁或柱子后面，这样玩家就必须沿路径发现它们。

此循环路径使玩家能够看到钥匙，以便在走过路径的第一片段时发现目标。

完成计划后，开始在关卡编辑器中规划谜题。

创建通向钥匙和粗模形状的路径后，用火焰陷阱填充房间的其余部分，以遮挡正确的路径。

> [!TIP]
> 在**大纲视图**中重命名你的关卡对象，以便清楚地显示每个控制开关对应哪个火焰陷阱。 例如，如果`BP_Switch1`会关闭三个陷阱，则将它们分别命名为`BP_FireTrap_S1_0`、`BP_FireTrap_S1_1`和`BP_FireTrap_S1_2`。 将额外的火焰陷阱重命名为`BP_FireTrap_Extra`之类的名称，以表明它们不是谜题的一部分。

如果需要，你可以在钥匙下面添加一个最终开关，能关闭沿途的一些陷阱，从而帮助玩家在完成谜题时离开。

要经常测试你的谜题，注意视野、挫败点和可能的捷径。 找好朋友来帮忙测试；他们可能会发现你未预料到的漏洞。 在游戏测试期间，你可能会发现到需要一些调整，做出阻挡效果或阻止玩家直接跳过谜题的某些部分。

如果你发现了这种情况，你有两种选择：

- 重新排列路径或谜题。
- 添加更多的阻挡建筑。
- 提高火焰伤害，让偏离路径的玩家遭受更严重的后果。

保留这个漏洞，但增加玩家相应的付出，为玩家提供自主选择权。 他们可以选择花更多时间开辟安全的路径，也可以牺牲生命值来冲向钥匙。

在示例关卡的谜题中，我们在钥匙的拱门下方添加了一些碎石，这样玩家就可以看到钥匙，但无法直接跳到钥匙处。 我们还隐藏了开关，不仅是为了一些好玩的惊喜，也是为了防止玩家直接跳过路径的这一部分。

### 为障碍物添加尖刺

让我们向之前的谜题添加尖刺，以增添失败的后果

从Room 1的谜题开始。 对于第一个移动平台，降低木桩的高度，以便在玩家失败时，他们可以重新爬上来重试。 引入新机制时，要让玩家有足够的空间在安全的环境中学习，以便他们试错

同样在起始房间中，你可以在第一个钥匙下的坑中添加一些尖刺。 玩家可以在前两个平台上练习跳跃，为最后一次跳到钥匙处的、风险更高的跳跃做好准备。 如果玩家能毫发无伤地拿到第一个钥匙，那可真是太厉害了。

玩家已经了解了基础操作，也会在平台和开关上练习了跳跃技巧，现在我们可以添加效果了。 在第二个平台或第三个按钮下，放置一些尖刺陷阱。 现在你已经提高了游戏的刺激性，因为玩家掉落时会受到伤害，但他们可以快速离开陷阱，将伤害降到最低并继续游戏。

最后，对于最后一个平台和开关，我们继续提高危险性。 用尖刺覆盖下面的区域，这样玩家就必须跑得更远才能避开尖刺，因此会受到更多伤害。 此时玩家应该对这个机制更加熟悉了，而且犯错的后果也能接受，因为他们之前已经练习过了。

此设计旨在向玩家介绍游戏机制的常见结构：

1. **介绍**：第一个学习游戏机制的安全平台。
2. **开发**：第二个平台和立方体以中等风险测试玩家技术的成长。
3. **变化**：最后的平台会将危险升级，并增加了新的移动方向，变成了紧张刺激的挑战。

就像你在[谜题：移动平台](../designer-06-puzzles-moving-platforms/index.md)中的Gameplay设计课程中学到的那样，通过在整个谜题中逐步提升危险性，你可以平衡游戏的公平性和刺激性。

### 更改陷阱的伤害

你可以决定通过增加或减少一种陷阱类型的伤害来调整难度关卡。 你可以通过以下两种方式执行此操作：

- 在**大纲视图**中，搜索"spike"或"fire"，并选择该类型的所有陷阱。 在**细节**面板中，根据需要更改**Setup > Base Damage**。 使用这种方法时，请记住还要更改关卡中该陷阱的所有新实例的**基础伤害**。 或者，通过复制现有陷阱向关卡新增陷阱实例，从而避免编辑每个新实例。

  **或者**
- 打开一个子陷阱蓝图，并转至其**构造脚本（Construction Script）**选项卡。 你无法在“我的蓝图”面板中编辑继承的变量，但可以在图表中设置变量。 在这两个**Construction Script**节点之后，连接**Set Base Damage**节点。 在节点中，根据需要更改**Base Damage**数值。

为确保玩家可预测你的Gameplay对象，请确保一种类型的所有陷阱造成的伤害相同。

在教程的示例关卡中，火焰陷阱每秒造成5点伤害，而尖刺陷阱实例修改为每秒造成10点伤害。

## 尝试示例关卡

如果不想自行搭建，而是希望直接使用本节教程中设计的房间部分，可以复制下方的代码片段。

### Room 2的粗模搭建

此文本片段包含Room 2的地板、墙壁和为创建此房间的谜题而添加的新粗模形状。 在**大纲视图**中，所有形状都在名为Room2的文件夹中。

Command Line

```
Begin Map
   Begin Level
      Begin Actor Class=/Script/Engine.TextRenderActor Name=TextRenderActor_19 Archetype="/Script/Engine.TextRenderActor'/Script/Engine.Default__TextRenderActor'" ExportPath="/Script/Engine.TextRenderActor'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.TextRenderActor_19'"
         Begin Object Class=/Script/Engine.TextRenderComponent Name="NewTextRenderComponent" Archetype="/Script/Engine.TextRenderComponent'/Script/Engine.Default__TextRenderActor:NewTextRenderComponent'" ExportPath="/Script/Engine.TextRenderComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.TextRenderActor_19.NewTextRenderComponent'"
         End Object
         Begin Object Class=/Script/Engine.BillboardComponent Name="Sprite" Archetype="/Script/Engine.BillboardComponent'/Script/Engine.Default__TextRenderActor:Sprite'" ExportPath="/Script/Engine.BillboardComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.TextRenderActor_19.Sprite'"
         End Object
         Begin Object Name="NewTextRenderComponent" ExportPath="/Script/Engine.TextRenderComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.TextRenderActor_19.NewTextRenderComponent'"
            Text=NSLOCTEXT("[3C535F7772EB3B3657484B5E2D5B925D]", "2347F80B407C68C27836E990A20143CF", "Room 2")
            HorizontalAlignment=EHTA_Center
```

请按照以下步骤，复制Room 2的所有粗模：

1. 移除Room 2中已有的物品（或Hallway 2末端的物品）：

   - 使用**大纲视图**选择Room 2的现有内容：右键点击`Room2`文件夹，然后选择**选择（Select）> 直接子项（Immediate Children）**。 按**Delete**。
   - 或者将视口切换到**顶部**正交视图，以手动选择和删除现有的房间。
2. 点击**复制完整代码片段**（Copy Full Snippet）。
3. 在虚幻编辑器中，确保视口或**大纲视图**为激活的面板（在视口或大纲视图内点击任意位置后按**Esc**），然后按**Ctrl+V**粘贴。

你的关卡和**大纲视图**应如下所示：

### Room 2的开关、陷阱和钥匙

此文本片段包含谜题的开关、陷阱和红色钥匙。 在大纲视图中，所有对象都在名为Room2的文件夹中。

> [!WARNING]
> 要在项目之间复制蓝图实例，父蓝图资产必须完全相同，并且文件名称和位置必须相同。 如果你在项目中更改了蓝图的组件、变量名称或属性，代码片段可能无法按预期复制，你需要手动设置这些关卡对象。

Command Line

```
Begin Map
   Begin Level
      Begin Actor Class=/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C Name=BP_FireTrap_C_261 Archetype="/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C'/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.Default__BP_TrapFire_C'" ExportPath="/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.BP_FireTrap_C_261'"
         Begin Object Class=/Script/Engine.SceneComponent Name="DefaultSceneRoot" Archetype="/Script/Engine.SceneComponent'/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C:ICH-DefaultSceneRoot_GEN_VARIABLE'" ExportPath="/Script/Engine.SceneComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.BP_FireTrap_C_261.DefaultSceneRoot'"
         End Object
         Begin Object Class=/Script/Engine.StaticMeshComponent Name="TrapBase" Archetype="/Script/Engine.StaticMeshComponent'/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C:TrapBase_GEN_VARIABLE'" ExportPath="/Script/Engine.StaticMeshComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.BP_FireTrap_C_261.TrapBase'"
         End Object
         Begin Object Class=/Script/Engine.BoxComponent Name="TrapTrigger" Archetype="/Script/Engine.BoxComponent'/Game/AdventureGame/Designer/Blueprints/Traps/BP_TrapFire.BP_TrapFire_C:TrapTrigger_GEN_VARIABLE'" ExportPath="/Script/Engine.BoxComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.BP_FireTrap_C_261.TrapTrigger'"
         End Object
         Begin Object Name="DefaultSceneRoot" ExportPath="/Script/Engine.SceneComponent'/Game/AdventureGame/Designer/Lvl_Adventure.Lvl_Adventure:PersistentLevel.BP_FireTrap_C_261.DefaultSceneRoot'"
```

要设置谜题的蓝图，请执行以下步骤：

1. 点击**复制完整代码片段**（Copy Full Snippet）。
2. 在虚幻编辑器中，确保视口或**大纲视图**为激活的面板，然后按**Ctrl+V**。
3. 检查每个开关的**Setup**属性，如有必要，将每个开关重新连接到相应的火焰陷阱：

   1. 在**大纲视图**中的`Room2`文件夹中，点击`BP_Switch4`。
   2. 在**细节**面板的**Setup**分段中，展开**交互对象列表（Interact Object List）**。
   3. 对于列表中的每个元素，点击下拉菜单，搜索`S4`，然后选择一个带有`S4`标签的火焰陷阱。
   4. 对每个开关重复这些步骤：

      - `BP_Switch5`触发`BP_FireTrap_S5_0-7`
      - `BP_Switch6`触发`BP_FireTrap_S6_0-3`
      - `BP_Switch7`触发`BP_FireTrap_S7_0-4`
      - `BP_Switch8`触发`BP_FireTrap_S8_0-3`
      - `BP_Switch9`在钥匙下触发`BP_FireTrap_S9_0-4`

你的关卡和**大纲视图**应如下所示：

## 下一步

接下来，你将学习如何在游戏中添加另一种常见的危险因素——敌方NPC！ 了解如何创建AI敌方角色，并将寻路网格体添加到关卡，以便敌人能够找到玩家并对其造成伤害。

- [创建敌人](https://dev.epicgames.com/documentation/unreal-engine/designer-08-create-an-enemy-in-unreal-engine) - 构建游戏逻辑，创建可以造成和接收伤害的敌人角色。

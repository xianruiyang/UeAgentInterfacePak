---
title: "如何使用蓝图通信"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprint-communications-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "蓝图通信用法", "如何使用蓝图通信"]
---

# 如何使用蓝图通信

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 蓝图通信用法 / 如何使用蓝图通信

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprint-communications-in-unreal-engine

本页将逐步介绍设置并使用 **蓝图通信** 的不同方法。

### 直接蓝图通信

在以下示例中，我们希望关卡中的两个 **蓝图** 能够相互通信。假设我们希望"立方体（Cube）"蓝图与"火花（Sparks）"蓝图通信，以便在玩家角色进入立方体时，使"火花（Sparks）"蓝图将自身关闭。这可借助 **直接蓝图通信** 轻松实现。

- 上图中的立方体是使用

  Shape_Cube

  网格体创建的蓝图，其碰撞设置为

  OverlapOnlyPawn

  ，因此它可以作为触发器。还启用了

  生成重叠事件（Generate Overlap Events）
- 上图中的火花为

  Blueprint_Effect_Sparks

  资源（初学者内容包中随附的）。

使用直接蓝图通信，我们需要执行以下操作：

1. 在 **Shape_Cube** 蓝图中，在 **我的蓝图（My Blueprint）** 下，单击 按钮（位于"变量（Variables）"! 类别下）。
2. 在 **细节（Details）** 面板中的 **变量类型（Variable Type）** 下，选择要访问的蓝图类型。

   将光标悬停在 **Blueprint_Effects_Sparks** 变量类型上，并从列表中选择 **引用（Reference）**。

   在此我们声明了我们要访问 **Blueprint_Effect_Sparks** 蓝图。
3. 在 **细节（Details）** 面板中，更新以下列出的部分。

   1.**变量名称（Variable Name）** - 为变量指定一个描述性的名称，例如，**TargetBlueprint**。 1.**变量类型（Variable Type）** - 应为要访问的蓝图类型。 1.**可编辑（Editable）** - 确保选中它，以公开变量并使它成为公共变量，然后才能够在关卡编辑器中访问它。 1.**工具提示（Tool Tip）** - 添加说明变量的作用或它引用的对象的简短描述。
4. 在关卡中选中 **Shape_Cube** 蓝图，然后，在关卡编辑器的 **细节（Details）** 面板下，你应能够找到在前一步骤中创建且已公开的变量。

   1.单击 **无（None）** 下拉框，指定"目标蓝图（Target Blueprint）"。 1.已放置到关卡中的所有蓝图实例都会在此处列出，你可以指定要作为 **目标蓝图（Target Blueprint）** 的实例。

   我们将在此处声明要影响已放置到关卡中的哪个 **Blueprint_Effect_Sparks** 蓝图Actor（可将其视为实例Actor）。如果关卡中具有多个火花，而我们只希望关闭其中一个火花，可以在此处选择要影响该蓝图的哪个实例，方法是将其设置为 **目标蓝图（Target Blueprint）**。
5. 除了使用下拉框以外，还可以单击 图标，然后单击要引用的已放置到关卡中的对象。

   可以仅将 **目标蓝图（Target Blueprint）** 设置为指向已指定的变量类型（在我们的示例中，为 **Blueprint_Effect_Sparks**）。
6. 在 **Shape_Cube** 蓝图中，按下 **Ctrl** 键的同时将变量拖到图中。

   1.此操作会创建Getter节点，它允许你从 **目标蓝图（Target Blueprint）** 访问事件、变量和函数等等。 1.从输出引脚拖出引线来查看上下文菜单。

   此时我们将从 **目标蓝图（Target Blueprint）** 搜索火花效果和火花音频组件，因为我们要访问这些组件。
7. 以下是声明玩家进入立方体时停用火花效果和火花音频的示例脚本。

#### 适用于生成的Actor的直接蓝图通信

有时你可能需要让两个蓝图彼此相互通信，但是一个（或多个）蓝图尚未放置到关卡中，例如，玩家按下按钮时生成的魔幻效果。在这种情况下，玩家角色和魔幻效果都尚未在关卡中生成，因此无法像上述一样设置 **目标蓝图（Target Blueprint）** 和实例。

使用 **从类生成Actor（Spawn Actor from Class）** 节点时，你可以从其 **返回值（Return Value）** 引脚拖出引线并将它指定为变量。

在以下示例的 **MyCharacter** 蓝图中，我们声明，当按下 **F** 键时，我们希望在玩家所在的位置生成 **Blueprint_Effect_Smoke** 蓝图的实例，并将它指定给 **目标蓝图（Target Blueprint）** 变量。

然后，我们可以访问 **Blueprint_Effect_Smoke** 蓝图（位于上图的黄色框中）并从 **目标蓝图（Target Blueprint）** 获取烟雾效果和烟雾音频组件，并在第二次按下 **F** 键时 **停用** 它们（这正是 **触发器（Flip/Flop）** 节点的作用）。这样，通过 **直接蓝图通信**，我们可以从一个蓝图访问另一个蓝图。

请参阅 [蓝图通信用法](../index.md) 文档来获取更多信息。

### 蓝图转换

在此示例中，关卡中包含火焰效果蓝图（它是Actor），我们希望让它与玩家使用的可操作角色蓝图通信。当玩家进入火焰时，我们希望向角色蓝图发送信号，通知它玩家已进入火焰，它们现在应该受到伤害。通过使用OverlapEvent的返回值，我们可以转换到角色蓝图并访问它里面的事件、函数或变量。

- 上面的火焰效果是

  Blueprint_Effect_Fire

  资源（初学者内容包中随附的）。
- 我们向蓝图添加了

  触发器（Trigger）

  球体组件并将它的碰撞设置为

  OverlapOnlyPawn

  。

使用蓝图转换，我们需要执行以下操作：

1. 指定给 **默认Pawn类（Default Pawn Class）**（可操作角色）的角色蓝图是我们要访问的"目标蓝图（Target Blueprint）。

   你可以从 **编辑（Edit）** 菜单中的 **项目设置（Project Settings）** 下的 **地图和模式（Maps & Modes）** 部分中查看 **默认Pawn类（Default Pawn Class）**。
2. 现在我们已经知道我们的目标是 **MyCharacter** 蓝图，可以在其中创建 **布尔（Bool）** 变量，声明玩家是否 **着火了（Is on Fire）**。

   在 **Event Tick** 上面输入一个 **分支（Branch）**，如果为 **True**，我们向屏幕输出 **应用伤害（Apply Damage）**（与True相连接的是应用伤害脚本）。
3. 在 **Blueprint_Effect_Fire** 蓝图中，我们为 **触发器（Trigger）** 添加两个事件：**OnComponentBeginOverlap** 和 **OnComponentEndOverlap**。
4. 添加好事件之后，我们从 **其他Actor（Other Actor）** 引脚拖出引线并在搜索字段中输入 **Cast To My**。

   在此处我们可以确定/指定要触发事件的Actor（MyCharacter蓝图）并 **转换到（Cast To）** 它，以便我们能够在火焰蓝图中访问它。
5. 选择 **转换到MyCharacter（Cast To MyCharacter）** 选项。
6. 添加好节点之后，我们可以从 **作为我的角色C（As My Character C）** 引脚拖出引线并访问它里面的事件、变量、函数等（在本示例中为 **Set Is on Fire**）。
7. 然后，在 **Blueprint_Effect_Fire** 蓝图中，这两个事件将如下图中所示。

   当与火焰重叠时，我们将 **MyCharacter** 蓝图中的 **IsOnFire** 变量设置为 **True**，当不与火焰重叠时，我们将该变量设置为 **False**。 在 **MyCharacter** 蓝图中，当 **IsOnFire** 设置为 **True** 时（借助火焰蓝图），我们向屏幕输出 **应用伤害（Apply Damage）**（如果你创建了生命值/伤害系统，可以在此处应用伤害并减小玩家的生命值）。

#### 其他类型的转换

存在一些可用于 **转换到（Cast To）** 不同类别的 **蓝图** 的特殊函数。

在上面的示例图中，我们给出了以下示例：

| 蓝图 | 说明 |
| --- | --- |
| **角色（Character）**（1） | 在此处使用了 **获取玩家角色（Get Player Character）** 节点，我们转换到的角色蓝图是 **MyCharacter**。 |
| **玩家控制器（PlayerController）**（2） | 在此处使用了 **获取玩家控制器（Get Player Controller）** 节点，我们转换到的玩家控制器蓝图是 **MyController**。 |
| **游戏模式（Game Mode）**（3） | 在此处使用了 **获取游戏模式（Get Game Mode）** 节点，我们转换到的游戏模式蓝图是 **MyGame**。 |
| **Pawn**（4） | 此处使用 **获取受控Pawn（Get Controlled Pawn）** 和 **获取玩家控制器（Get Player Controller）** 节点转换到 **MyPawn** Pawn蓝图。 |
| **HUD**（5） | 此处使用 **获取HUD（Get HUD）** 和 **获取玩家控制器（Get Player Controller）** 节点转换到 **MyHUD** HUD蓝图。 |

在上面的各个示例中，从 **作为我的X（As My X）**（X是蓝图类型）节点拖出引线之后，你将能够访问相应蓝图中的事件、变量、函数等。

另外需要注意的是，可以使用 **获取玩家角色（Get Player Character）** 和 **获取玩家控制器（Get Player Controller）** 节点中的 **玩家索引（Player Index）** 值来指定多玩家场景中的不同玩家。对于单人玩家场景，将这些值保留为0即可。

#### 目标蓝图转换

在某些情况下，你也可以使用变量来 **转换到（Cast To）** 特定类型的蓝图来访问它。

在上图的1部分中，我们创建了 **保存游戏对象（Save Game Object）** 并将它指定给 **SaveGameObject** 变量。然后我们使用该变量来 **转换到（Cast To）** **MySaveGame** 保存游戏蓝图（我们可以使用它来传递或检索高分、最短用时等保存游戏信息）。

在上图的2部分中，我们创建了 **控件（Widget）蓝图** 并将它指定给 **UserWidget** 变量。然后我们使用该变量来 **转换到（Cast To）** **MyWidgetBlueprint** 控件蓝图（我们可以使用它从控件蓝图（可以为要访问的HUD或其他UI元素）更新或检索信息）。

### 事件调度器

在下图中，关卡中有一个灌木 **Actor蓝图**，我们希望当玩家按下按钮点燃灌木时它能够从 **角色蓝图** 接收通信，然后几秒之后火焰和灌木将销毁。我们希望通过使用 **事件调度器** 来实现从 **角色蓝图** 到 **关卡蓝图** 的通信。

- 上图中的灌木是

  SM_Bush

  资源（初学者内容包中随附的）。

使用 **事件调度器**，我们需要执行以下操作：

1. 在 **MyCharacter** 蓝图中，单击 **事件调度器（Event Dispatcher）** 图标（如果该图标处于隐藏状态，则单击>>箭头），并将该事件调度器命名为 **StartFire**。
2. 在图中 **右键单击** 并添加 **F** 键按键事件，然后从 **按下（Pressed）** 引脚拖出引线，搜索并添加 **调用StartFire（Call StartFire）** 事件调度器。
3. **编译（Compile）** 并 **保存（Save）**，然后关闭 **MyBlueprint**。
4. 在关卡中单击灌木以选中它，然后打开 **关卡蓝图**。
5. 在图中 **右键点击** 并添加从关卡到灌木的引用。
6. **右键单击** 并添加 **事件开始播放（Event Begin Play）** 节点和 **获取玩家角色（Get Player Character）** 节点，然后将 **获取玩家角色（Get Player Character）** 与 **转换到MyCharacter（Cast To MyCharacter）** 相连。
7. 从 **作为我的角色C（As My Character C）** 拖出引线并添加 **Assign Start Fire** 事件调度器（将创建新的绑定事件）。
8. 从 **StartFire_Event** 拖出引线并添加 **SpawnActorFromClass** 节点（类设置为 **Blueprint_Effect_Fire**），对于 **变换（Transform）**，获取 **SM_Bush** 变换。
9. 从"生成Actor（Spawn Actor）"节点的 **返回值（Return Value）** 拖出引线并添加 **销毁时指定（Assign On Destroyed）** 节点。
10. 从 **OnDestroyed_Event** 拖出引线并添加 **销毁Actor（Destroy Actor）** 节点，以 **SM_Bush** 作为目标。
11. 从 **将事件绑定到OnDestroyed（Bind Event to OnDestroyed）** 拖出引线并添加 **延迟（Delay）**（3秒），然后以"生成Actor（Spawn Actor）"节点的 **返回值（Return Value）** 为目标添加 **销毁Actor（Destroy Actor）**。

    完成最后几步之后，效果应如上图中所示。

如果编译并保存，然后在编辑器中运行，你将观察到，当你按下 **F** 键时，将在灌木中生成火焰效果。3秒之后，火焰和灌木应会从关卡中移除。

本示例较为简单，而你可能希望进行更多的检查（玩家距灌木的距离是否近到足以允许它们点燃灌木）以及仅允许玩家引燃火焰一次，但是它说明了如何通过将 **角色蓝图** 与 **事件调度器** 配合使用以在 **关卡蓝图** 中执行事件。上面的示例也展示了如何向生成的Actor指定 **事件调度器**，并在Actor有事件（在本示例中，事件为销毁）发生时执行事件。

请参阅 **[事件分发器](../../event-dispatchers/index.md)** 文档来获取更多信息。

### 蓝图接口

在下图中，关卡中有四个 **蓝图**：作为触发器的立方体、火焰效果、火花效果和吊灯。我们希望当玩家进入立方体时，火焰、灯和火花分别表现出不同的效果。我们也要在角色每次进入立方体时，增加它的移动速度。

- 上图中的立方体是使用

  Shape_Cube

  网格体创建的

  蓝图

  ，其碰撞设置为

  OverlapOnlyPawn

  ，因此它可以作为触发器。
- 上图中的火花为

  Blueprint_Effect_Sparks

  资源（初学者内容包中随附的）。
- 上图中的火焰是

  Blueprint_Effect_Fire

  资源（初学者内容包中随附的）。
- 上图中的光源是

  Blueprint_CeilingLight

  资源（初学者内容包中随附的）。

通过使用 **蓝图接口**，我们可以与这三个不同的蓝图以及玩家角色蓝图通信。

要与它们中的每一个通信，我们需要执行以下操作：

1. 在 **内容浏览器** 中的空白区域中 **右键单击** 并选择 **蓝图（Blueprints）**，然后选择 **蓝图接口（Blueprint Interface）**。
2. 将接口命名为 **CubeInterface**（或其他的名称），然后 **双击** 将其打开，并单击 **添加函数（Add Function）** 按钮。
3. 将新函数命名为 **MagicCube** 或任意名称，然后 **编译（Compile）**，**保存（Save）** 并关闭接口。
4. 打开立方体蓝图，然后 **右键单击** **StaticMesh** 并添加 **OnComponentBeginOverlap** 事件。
5. 新建 **Actor** 变量，将其命名为 **Targets**，单击"变量类型（Variable Type）"旁的框，将其设置为 **数组（Array）**，然后选中 **可编辑（Editable）** 复选框。

   这将存储受 **蓝图接口** 影响的Actor。
6. 在图中 **右键单击**，然后在 **接口消息（Interface Messages）** 下，单击 **MagicCube**（或你选择的名称）函数。
7. 按如下所示设置图，**编译（Compile）**，**保存（Save）**，然后关闭蓝图。

   拖入 **Targets** 变量，然后从它拖出引线以获取 **添加（Add）** 节点。

   将 **Targets** 连接到 **MagicCube** 节点，并将 **获取玩家角色（Get Player Character）** 节点与 **添加（Add）** 节点相连。
8. 在关卡中选中立方体，然后在 **细节（Details）** 面板中，单击目标下的+号并从关卡中添加火焰、灯和火花。
9. 打开 **Blueprint_Effect_Fire** 蓝图，然后从工具栏中单击 **蓝图属性（Blueprint Props）** 按钮。
10. 在 **细节（Details）** 面板的 **接口（Interfaces）** 下，单击 **添加（Add）** 按钮，然后选择接口（在本示例中为 **CubeInterface_C**）。
11. 在图中 **右键单击**，然后在 **添加事件（Add Event）** 下，选择 **Event Magic Cube** 事件。
12. 当玩家进入立方体时，**Event Magic Cube** 之后的所有事件都将立即执行。

    当玩家进入立方体时，我们将增大火焰的大小，然后，当玩家第二次进入火焰时，我们将重置火焰的大小。
13. 打开 **Blueprint_CeilingLight** 蓝图，单击 **蓝图属性（Blueprint Props）**，然后如前所述从 **细节（Details）** 面板添加接口。
14. 在图中 **右键单击**，然后添加 **Event Magic Cube** 事件，以便当玩家进入立方体时，此事件之后的任何事件都将执行。

    在此处，我们通过将灯的亮度设置为0将其关闭，通过将亮度设置为1500来将其打开。
15. 重复此过程，为 **Blueprint_Effect_Sparks** 蓝图添加 **蓝图属性**，然后添加 **CubeInterface_C**。

    此处我们将火花效果设置为进入立方体时向上移动，当第二次进入立方体时向下移动。
16. 重复此过程，为 **MyCharacter** 蓝图添加 **蓝图属性（Blueprint Props）**，然后添加 **CubeInterface_C**。

    此处我们将角色的移动速度设置为每进入立方体一次，其移动速度增加100。

从上面的示例中可以看出，通过使用 **蓝图接口**，你可以同时与多个不同类型的 **蓝图** 通信，每种蓝图都可以执行源自同一个源（在本示例中为触发器）的不同函数。

如果要让一个事件在多个蓝图中执行功能，此示例非常有用，但是使用 **蓝图接口** 的方式并非只有这一种。在下一部分中，我们将介绍如何使用 **蓝图接口** 在蓝图之间传递变量。

#### 通过蓝图接口传递变量

下图中的 **Blueprint_Effect_Fire** 蓝图将代表玩家角色生命力。

此蓝图将检查玩家的生命值，一旦它为0，玩家将渐隐并消失。

- 上图中的火焰是

  Blueprint_Effect_Fire

  资源（初学者内容包中随附的）。

通过使用 **蓝图接口** 传递两个变量（玩家的生命值以及玩家是否已死亡），我们可以告知火焰何时消失。

为了传递这些变量，我们进行了如下设置：

1. 在 **内容浏览器** 中的空白区域中 **右键单击** 并选择 **蓝图（Blueprints）**，然后选择 **蓝图接口（Blueprint Interface）**。
2. 将接口命名为 **BP_Interface**（或其他的名称），然后 **双击** 将其打开，并单击 **添加函数（Add Function）** 按钮。
3. 将新函数命名为 **GetHealth**，然后在 **细节（Details）** 面板中，通过单击 **新建（New）** 按钮添加两个 **输出（Outputs）**。
4. 将其中一个新输出设置为 **布尔（Bool）**，名称为 **playerIsDead**，将另一个输出设置为 **浮点（Float）**，名称为 **playerHealth**，然后 **编译（Compile）**，**保存（Save）** 并关闭接口。
5. 打开 **MyCharacter** 蓝图，然后从工具栏中单击 **蓝图属性（Blueprint Props）** 按钮。
6. 在 **细节（Details）** 面板的 **接口（Interfaces）** 下，单击 **添加（Add）** 按钮，然后选择接口（在本示例中为 **BP_Interface_C**）。
7. 创建一个 **布尔** 变量，名称为 **OutOfHealth**，以及一个 **浮点** 变量，名称为 **PlayerHealthValue**，进行 **编译（Compile）**，然后将 **PlayerHealthValue** 设置为 **100**。
8. 在 **MyBlueprint** 的 **接口（Interfaces）** 部分下，**双击** **GetHealth** 函数将其打开。
9. 在图中，拖入 **OutOfHealth** 和 **PlayerHealthValues**，并按照如下所示将它们与 **ReturnNode** 相连接。

   这会将存储在 **MyCharacter** 蓝图中的数值传递到接口。
10. 返回到 **MyCharacter** 蓝图的 **EventGraph**，并重现下面的设置。

    此处我们声明，当玩家的生命值大于0且玩家按下了 **F** 键时，从当前生命值减去25并调用 **TakeDamage** **事件调度器**。 当生命值小于或等于0时，将OutOfHealth布尔变量设置为 *true*，并调用 **TakeDamage** **事件调度器**。此处我们使用 **事件调度器** 来告知其他蓝图玩家已受到伤害，而非通过使用"Event Tick"让其他蓝图在每一次更新时检查玩家的生命值。
11. 打开要将变量传递到的蓝图（**Blueprint_Effect_Fire**），然后单击 **蓝图属性（Blueprint Props）** 按钮，然后通过 **细节（Details）** 面板 **添加（Add）** 接口。
12. 在 **EventGraph** 中，从 **MyCharacter** 蓝图将一个事件绑定到 **TakeDamage** 事件。

    从 **获取玩家角色（Get Player Character）** 节点拖出引线并 **转换到MyCharacter（Cast To MyCharacter）**，然后从 **作为我的角色C（As My Character C）** 拖出引线并添加 **Assign Take Damage**，以创建绑定事件。
13. 从绑定事件 **TakeDamage_Event** 拖出引线并添加 **GetHealth** 接口消息。

    请确保实现 **接口消息** 而非 **调用函数**。
14. 重现下面的设置。

    ![undefined](../../../../../assets/images/79/799c65382153e22de030d66bac2312c718973d38e0e7aa3ab9f2a191a602f832.jpg)

    *单击查看大图。*

    此处，我们将 **GetHealth** 接口与一系列 **分支（Branch）** 节点相连接，其中首先进行 **PlayerIsDead** 检查（在 **MyCharacter** 蓝图中已定义），如果情况确实如此，文本将输出到屏幕上，而且将停用火焰效果/音频。

    第二个 **分支（Branch）** 节点检查 **PlayerHealth** 值是否为0，如果为0，文本将输出到屏幕，声明"只需再击中1次"角色就会"死亡"。这绝对不是完美的生命值/伤害设置，但是它说明了如何通过接口传递两个变量以及之后如何在另一个蓝图中使用这些变量。例如，可以将本示例中的"PlayerHealth"值传递到一个HUD，然后进行更新以反映当前生命值。

请参阅 **[蓝图接口](../../types-of-blueprints/blueprint-interface/index.md)** 文档来获取更多信息。

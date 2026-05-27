---
title: "额外机制：生成新立方体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/designer-11-spawn-new-cubes-mechanic-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "设计解谜冒险游戏", "额外机制：生成新立方体"]
---

# 额外机制：生成新立方体

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 设计解谜冒险游戏 / 额外机制：生成新立方体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/designer-11-spawn-new-cubes-mechanic-in-unreal-engine

在本教程中，你将学习创建一个蓝图：当玩家站在开关上时，即可在关卡中生成新的立方体。 利用此Gameplay对象，玩家可以在任何可能丢失或破坏立方体的解谜房间中获取新的立方体。

对于立方体生成器，你将创建一个只包含“生成”功能的蓝图，这样你就可以灵活使用任何几何体或美术资产，创造立方体从某个几何体中掉落出来的效果。

如果你一直跟随示例关卡完成操作，那么创建这个蓝图并非强制步骤。但如果你计划继续扩展这款解谜冒险游戏，建议在其中加入这个“立方体再生”机制。

## 开始之前

在继续之前，请确保你已掌握[设计解谜冒险游戏](../index.md)教程前几节所介绍的以下内容：

- 蓝图基础知识，包括蓝图接口、自定义事件和变量。

你需要准备好在[谜题：开关和立方体](../designer-05-puzzles-switches-and-cubes/index.md)中创建的下列资产：

- `BP_Cube`蓝图
- `BP_Switch`蓝图
- `BPI_Interaction`蓝图接口

## 新建蓝图

首先，为立方体生成器创建一个新的蓝图资产。 该蓝图需要实现`BPI_Interaction`蓝图接口，以便响应`BP_Switch`，后者会调用该接口中的事件。

按以下步骤设置新蓝图：

1. 打开**内容浏览器（Content Browser）**，进入**Content > Adventure Game > Designer > Blueprints > Activation**文件夹。
2. 在文件夹内右击，然后选择**蓝图类（Blueprint Class）**。 在类选择窗口中，选择**Actor**类。
3. 将此蓝图命名为`BP_CubeSpawn`，并将其打开。
4. 在蓝图编辑器（Blueprint Editor）窗口中，找到**事件图表（EventGraph）**选项卡。
5. 在蓝图编辑器顶部点击**类设置（Class Settings）** 按钮。
6. 在**细节（Details）**面板的**接口（Interfaces）**下面，点击**已实现接口（Implemented Interfaces）**旁边的**添加（Add）**下拉菜单，选择**BPI_Interaction**。
7. 点击**编译（Compile）**并**保存（Save）**。

添加`BPI_Interaction`接口后，在**我的蓝图（My Blueprint）**面板中会新增一个名为接口（Interfaces）的模块， 其中包含属于BPI_Interaction接口的两个事件：**fnBPISwitchOff**和**fnBPISwitchOn**。

在`BP_CubeSpawn`中，我们将使用**fnBPISwitchOn**事件来定义当玩家踩下开关并触发此事件时的行为。

## 构建立方体生成逻辑

在实现立方体生成逻辑之前，我们先明确立方体生成系统应有的工作机制：

- 要生成立方体，玩家必须先激活开关——通过你在上一步中添加的接口来实现。
- 应设定一个玩家可生成立方体的最大数量，防止立方体过度堆满整个区域。
- 如果玩家尝试生成超出最大数量的立方体，则销毁最早生成的那个立方体。 你可以使用数组变量来追踪已生成的立方体。
- 立方体生成器应设置一个短暂的冷却计时器，避免玩家过快生成新立方体。

### 检查立方体生成条件

在搭建立方体生成器的事件图表时，首先要检查是否满足生成新立方体的条件，以及玩家是否已达到立方体生成上限。

按以下步骤检查能否生成新立方体：

1. 在**我的蓝图（My Blueprint）**面板的**接口（Interfaces）**分类下，双击**fnBPISwitchOn**，将其添加到图表中。
2. 从**fnBPISwitchOn**节点的**执行**引脚拖出，添加一个**分支（Branch）**节点。
3. 在**分支（Branch）**节点上，拖出**条件（Condition）**引脚，选择**提升为变量（Promote to variable）**，并将此变量命名为`CanSpawn`。 你将使用该变量判断冷却时间是否已结束。
4. 在**我的蓝图（My Blueprint）**面板中，新建一个**整型（Integer）**变量，命名为`CubesSpawned`。 该变量用于追踪当前关卡中已生成的立方体数量。
5. 再新建一个变量，命名为`MaxNumCubes`， 用于设置玩家可生成立方体的最大数量。
6. 设置**MaxNumCubes**变量：

   1. 将其类型设为**整型（Integer）**。
   2. 点击其**眼睛**图标，使其变为公开并且可编辑。
   3. 在**细节（Details）**面板中，点击**类别（Category） 字段并输入**`Setup`。
   4. 点击**编译（Compile）**，并将变量的**默认值（Default Value）**设为`3`。

      到目前为止，你的变量应该如下所示：
7. 从**分支**节点拖出**True**引脚，添加第二个**分支**节点。
8. 从第二个**分支**节点拖出**条件**引脚，添加一个**Less Than (<)**节点。
9. 设置**Less Than**节点，检查已生成的立方体数量是否小于允许的最大数量：

   - 从**变量（Variables）**列表中，将**CubesSpawned**拖拽到**Less Than**节点的上方输入引脚。
   - 将**MaxNumCubes**变量拖拽到下方输入引脚。

### 统计已生成的立方体并销毁多余的立方体

如果当前玩家生成的立方体数量小于最大数量，执行流程将通过第二个分支节点的True引脚。 在这种情况下，可以直接跳转到在生成立方体之前将立方体计数加1的逻辑。

要增加已生成的立方体数量，请按照以下步骤操作：

1. 从第二个**分支**节点拖出**True**引脚，添加一个**Increment Int**节点。 移动新节点，在其与**Branch**节点之间留出额外空间。
2. 从**变量**列表中，将**CubesSpawned**拖拽到**Increment Int**节点的输入引脚。

接下来，添加相反情况的逻辑——即当**Cubes Spawned**值大于**最大立方体数量（Max Num Cubes）**，或执行流程通过分支的False引脚时。如果玩家已达到最大立方体数量，则在生成新立方体之前销毁最早的立方体。

要销毁一个立方体以便为新立方体腾出空间，请按照以下步骤操作：

1. 从第二个**分支**节点拖出**False**引脚，添加一个**Destroy Actor**节点。
2. 从**Destroy Actor**节点拖出**目标（Target）**引脚，添加一个**Get (a copy)**节点。
3. 将**Get**节点的第二个输入引脚保持设置为**0**，因为数组的列表从0开始，而你想要获取第一个元素。
4. 从**Get**节点拖出**Array**输入引脚，选择**提升为变量（Promote to variable）**。
5. 将新变量命名为`SpawnedCubes`。 你将使用这个数组来存储玩家在关卡中生成的每个立方体。
6. 从Destroy Actor节点拖出**执行（exec）**引脚，添加一个**Remove Index**节点。
7. 拖出它的**Array**输入引脚，添加一个**Get Spawned Cubes**引用节点。
8. 双击第二个**Branch**节点与**Increment Int**节点之间的连线，创建一个可移动的**reroute**节点。 将**reroute**节点拖近**Increment Int**节点。
9. 将**Remove Index**节点的输出**exec**引脚连接到**reroute**节点。

   （你也可以直接将**Remove Index**节点连接到**Increment Int**节点。）

现在，在生成立方体之前，蓝图要么增加**CubesSpawned**计数器，要么先删除一个立方体然后再增加**CubesSpawned**计数器。 接下来，你将添加生成立方体的逻辑。

### 生成立方体

既然你已经检查了玩家是否可以生成立方体，并确保关卡中的立方体数量不会过多，现在就可以生成一个新的`BP_Cube` Actor了。

要生成一个新的立方体，请按照以下步骤操作：

1. 从**Add**节点拖出**exec**执行引脚，添加一个**Spawn Actor from Class**节点。
2. 设置**SpawnActor**节点：

   1. 点击**Class**引脚旁的下拉菜单，搜索并选择`BP_Cube`。 节点名称会从**SpawnActor NONE**变为**SpawnActor BP Cube**。
   2. 右键点击橙色的**生成变换（Spawn Transform）**引脚，选择**拆分结构体引脚（Split Struct Pin）**。 三个新的引脚会替代原来的生成变换引脚：**生成变换位置（Spawn Transform Location）**、**生成变换旋转（Spawn Transform Rotation）**和**生成变换比例（Spawn Transform Scale）**。

      > [!NOTE]
      > 必须右键点击圆形的**生成变换（Spawn Transform）**引脚本身，而不是整个节点。
   3. 在事件图表（Event Graph）中右键点击，搜索并选择一个**Get Actor Transform**节点。 右键点击返回值（Return Value）引脚，选择**拆分结构体（Split Struct）**。 将**Location**和**Rotation引脚**连接到**Spawn Actor**节点对应的引脚。
3. 从**SpawnActor**节点拖出**exec**执行引脚，在**Array**类别下添加一个**Add**节点（你也可以搜索`Add Array`并选择**Add**节点）。
4. 在**Add Array**节点上执行以下操作：

   1. 拖出**Array**输入引脚，添加一个**Get Spawned Cubes**节点。
   2. 将节点下方的输入引脚连接到**SpawnActor**节点的**返回值（Return Value ）**引脚。
5. 当玩家生成一个立方体后，在冷却时间结束之前，不应允许再次生成立方体。 拖出**Add Array**节点的exec引脚，添加一个**Set Can Spawn**节点。 保持**Can Spawn**设置为false（无勾选状态）。

### 实现冷却计时器

使用**CanSpawn**变量和**Delay**节点来防止玩家在设定的时间间隔内再次生成立方体。

要创建并触发一个重置立方体生成冷却计时器的事件，请按照以下步骤操作：

1. 在事件图表（Event Graph）中的空白处右键点击，搜索并选择**添加自定义事件（Add Custom Event）**。
2. 将新事件命名为`EvResetSpawn`，并将其移动到**Event fnBPISwitchOn**节点下方。
3. 从**EvResetSpawn**事件节点拖出**exec**执行引脚，添加一个**Delay**节点。
4. 在**延迟（Delay）**节点上，拖出**持续时间（Duration）**引脚，选择**提升为变量（Promote to variable）**。 将变量命名为`SpawnCooldown`。
5. 设置新的**SpawnCooldown**变量：

   1. 确保其类型为**浮点（Float）**。
   2. 点击其**眼睛**图标，使其变为公开并且可编辑。
   3. 将**类别（Category）**更改为**Setup**。
   4. 点击**编译（Compile）**，然后将其默认值设置为`1`。 此时，你的变量列表应如下所示。
6. 从**延迟（Delay）**节点拖出**完成（Completed）**引脚，添加一个**Set Can Spawn**节点。 确保将此节点的**Can Spawn**值切换为true。
7. 返回到立方体生成逻辑末尾的**Set Can Spawn**节点。 从**Set Can Spawn**节点拖出exec执行引脚，添加一个**EvResetSpawn**节点以触发事件和生成冷却延迟。
8. 点击**保存（Save）**并**编译（Compile）**。

现在，你的事件图表应该如下所示：

> [!NOTE]
> 如果你使用下面的代码片段，请确保你的蓝图具有上述说明中提到的自定义变量、事件和BP接口。
>
> 要将这些节点复制到你的蓝图中，请点击**复制片段（Copy Snippet）**，转到你的事件图表，然后按**Ctrl+V**。 将逻辑复制到蓝图编辑器后，你可能需要删除蓝色的**Ev Reset Spawn**节点，并在**Set Can Spawn**节点之后手动重新添加它。

Blueprint

EvResetSpawn

SpawnActor BP_Cube_C

Class

BP_Cube_C

Spawn Transform Location

Spawn Transform Rotation

0.0

0.0

0.0

Spawn Transform Scale

1.0

1.0

1.0

Collision Handling Override

Undefined

Instigator

Return Value

GetActorLocation

Target

Return Value

Fullscreen

Reset

Graph

Zoom 1:1

Renderer by

Rancoud

blueprint

INIT INTERACTIONS...

现在你可以退出蓝图编辑器并返回关卡编辑器。

## 将立方体生成蓝图添加到关卡

接下来，你将在关卡中设置一个`BP_CubeSpawn`和一个`BP_Switch`。

立方体生成器蓝图没有视觉组件，因此你可以将其放置在任何几何体或美术资产内，以此创建立方体从该几何体中掉出的效果。

在关卡中选取一个位置，使用**Content > LevelPrototyping > Meshes**文件夹中的网格体来构建一些几何体以代表立方体生成器。

如果你使用示例关卡，可以将其放置在房间1后部的空间中。 在此示例中，我们将使用一个圆柱体来代表一个管道，立方体可以在其内部生成并掉落出来。

然后，按照以下步骤在关卡中设置一个`BP_CubeSpawn`：

1. 打开**内容浏览器（Content Browser）**，进入**Content > Adventure Game > Designer > Blueprints > Activation**文件夹。
2. 将`BP_CubeSpawn`蓝图拖拽到关卡中的所需位置。
3. 从**内容浏览器**中将`BP_Switch`蓝图拖拽到关卡中，确保其在立方体生成器的视线范围内。
4. 在关卡中选择`BP_Switch` Actor。
5. 在**细节（Details）**面板的**Setup**部分中，向**Interact Object List**添加一个新的数组元素。
6. 使用**Index [0]**旁边的下拉菜单选择`BP_CubeSpawn`对象。 这将把此开关的**fnBPISwitchOn**事件传递给`BP_CubeSpawn` Actor。
7. 选择`BP_CubeSpawn` Actor。 可选择更改**Max Cubes Allowed**变量，以设置关卡中允许的最大立方体数量。

现在，如果你运行游戏，就可以踩下开关来生成新的立方体了。

## 下一步

如果你想继续完善关卡，添加材质、灯光、后期处理效果、音效和视觉特效，可以尝试Artist Track教程系列。

- [解谜冒险游戏美术创作指南](../../art-pass-for-a-puzzle-adventure-game/index.md) - 了解如何在解谜冒险游戏中运用材质、声音和视觉特效等美术工作流程。

如果你有兴趣将项目打包为独立程序以进行测试和共享，请参阅以下文档：

- [打包虚幻引擎项目](../../../../sharing-and-releasing-projects/packaging-and-cooking/packaging-your-project/index.md) - 打包虚幻游戏项目以便发布游戏。

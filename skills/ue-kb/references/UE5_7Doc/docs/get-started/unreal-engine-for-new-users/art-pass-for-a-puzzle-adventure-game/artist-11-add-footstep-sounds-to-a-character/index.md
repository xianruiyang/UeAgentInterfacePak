---
title: "为角色添加脚步声"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/artist-11-add-footstep-sounds-to-a-character"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "解谜冒险游戏美术创作指南", "为角色添加脚步声"]
---

# 为角色添加脚步声

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 解谜冒险游戏美术创作指南 / 为角色添加脚步声

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/artist-11-add-footstep-sounds-to-a-character

在本节中，你将为玩家角色添加脚步声，以增强在关卡中奔跑时的真实感。 你将根据玩家行走的表面类型，使用**Sound Cues**创建不同的声音。

你将创建**物理材质**来表示不同的地面类型。 例如，在金属地面上行走时，这种声音应该与在石头地面上行走时有所不同。你还将创建一个自定义数据资产，用于存储表面类型和对应的声音信息。 使用数据资产可以让你在未来更容易添加新的表面类型和声音，而无需修改蓝图代码。

最后，你将在游戏已有的**蓝图函数库** ——**BPL_FPGame**中创建一个**函数**。 该函数随后会调用数据资产中的另一个函数，根据检测到的表面类型返回正确的音效。

## 开始之前

请确保你已理解**[《解谜冒险游戏美术创作指南》](../index.md)**和[虚幻引擎新用户指南](../../index.md)教程系列的前几节中涵盖的相关内容：

- 创建Sound Cue和声音衰减资产。
- 蓝图基础知识，包括创建变量和函数，以及创建和连接节点。

你将在[示例项目文件和内容包](https://dev.epicgames.com/documentation/unreal-engine/setting-up-your-project-in-unreal-engine?application_version=5.5)中使用以下资产：

- **S_Metal-1**声波
- **S_Metal-2**声波
- **S_Metal-3**声波
- **S_Stone-1**声波
- **S_Stone-2**声波
- **S_Stone-3**声波
- **S_DefaultStep-1**声波
- **S_DefaultStep-2**声波
- **S_DefaultStep-3**声波
- **BPL_FPGame**蓝图函数库
- **BP_AdventureCharacter**蓝图
- **ABP_Unarmed**动画蓝图

## 创建带有脚步声的Sound Cue

首先，创建两个Sound Cue：一个用于金属地面脚步声，一个用于石头地面脚步声。

要创建Sound Cue，请执行以下操作：

1. 打开**内容浏览器**，并导航到**AdventureGame > Artist > Audio**。
2. 在**音频（Audio）**文件夹中右键单击，选择**新建文件夹**，并命名为**Footsteps**。
3. 在**脚步（Footsteps）**文件夹中右键单击，选择**Audio > Sound Cue**。 将其命名为**SC_Footsteps_Metal**并打开。 此资产中已经包含一个Output节点，它会根据其所连接的节点来播放声音。
4. 在图表的任意位置右键单击并添加一个**Wave Player**节点。
5. 选择**Wave Player**节点，并在左侧面板中将**声波**修改为**S_Metal-1**。
6. 再添加两个**Wave Player**节点，并重复上述步骤，为它们分别选择在[设置项目与导入内容](../artist-01-project-setup-and-content-import/index.md)中导入的**S_Metal-2**和**S_Metal-3**声波文件。
7. 在图表中右键单击并添加一个**Random**节点。 在**Random**节点中点击**Add input**一次，以添加第三个输入。
8. 将每个**Wave Player**节点连接到**Random**节点的一个输入引脚。
9. 将**Random**节点连接到**Output**节点。
10. 保存Sound Cue。

接下来，创建两个**Sound Cue**资产：一个用于随机播放石头地面上的脚步声，另一个用于默认脚步声：

1. 再创建一个名为**SC_Footsteps_Stone**的**Sound Cue**资产。
2. 对于**Wave Player**节点，使用 **S_Stone**-******1**、**S_Stone-2**和 使用你在[设置项目与导入内容](../artist-01-project-setup-and-content-import/index.md)教程中导入的**S_Stone**-3****音频资产。
3. 创建一个名为**SC_Footsteps_Default**的**Sound Cue**资产。
4. 对于**Wave Player**节点，使用音频资产**S_Default-1、S_Default-2**和**S_Default-3**。

## 创建物理材质

现在你已经创建了Sound Cue，接下来将创建两个[物理材质](../../../../gameplay-systems/physics/physical-materials/index.md)来表示不同的表面类型。 稍后你将把脚步声与这些物理材质进行匹配。

**物理材质**用于定义物理对象在与世界动态交互时的物理响应。 这些材质也可以在游戏运行时用于识别不同类型的地面。

例如，在本教程中，你将创建名为**PM_Metal**和**PM_Stone**的物理材质，分别表示金属和石头表面。 随后，你将检查玩家当前行走的表面类型，并根据该信息播放对应的Sound Cue。

要创建物理材质，请执行以下操作：

1. 前往**内容浏览器**，并进入**AdventureGame > Artist > Materials**文件夹。
2. 在**材质（Materials）**文件夹中右键单击，进入**物理（Physics）**，然后选择**物理材质（Physical Material）**。
3. 在**选择物理材质类（Pick Physical Material Class）**窗口中选择**PhysicalMaterial**，然后点击“选择”（Select）。
4. 将此资产命名为**PM_Metal**。
5. 再创建一个物理材质，命名为**PM_Stone**。

物理材质是一种**数据资产**，可以用于更改表面的各种属性，例如摩擦力。 对于这些物理材质，你不需要在资产本身中修改属性。 你应该将这些资产分配给不同的材质，从而改变其各自的表面类型。

## 使用数据资产蓝图类分配脚步声

接下来，你将创建一个新的**蓝图数据资产**类，用于存储脚步声音效，并创建一个函数，根据对象材质所分配的物理材质返回正确的脚步声。

要设置控制脚步声的蓝图数据资产，请执行以下操作：

1. 在**内容浏览器**中进入**AdventureGame > Artist > Audio > Footsteps**文件夹。
2. 右键单击并创建一个**蓝图类**。
3. 在**选择父类（Pick Parent Class）**窗口中，展开**全部类（All Classes）**下拉菜单，搜索并选择**PrimaryDataAsset**。
4. 将此资产命名为**BP_DA_FootSteps**并将其打开。
5. 在**我的蓝图**面板中，新建一个变量：

   1. 将其命名为**FootStepSounds**。
   2. 选中该资产，然后在**细节**面板中进行设置：

      1. 将**变量类型**改为**物理材质（对象引用）**。
      2. 将**容器（Container）**改为**映射（Map）**。
      3. 将**映射值类型（Map Value Type）**改为**Sound Cue（对象引用）**。

         > [!NOTE]
         > 默认的变量类型为布尔。 由于布尔类型无法进行映射，如果不先更改变量类型，就无法使用**映射**容器。
6. 添加另一个变量：

   1. 将其命名为**DefaultFootSteps**。
   2. 将其类型改为**Sound Cue**。

      由于默认脚步声只有一个Sound Cue，并且只有在对象材质没有指定物理材质时才会播放，因此可以将其容器类型更改为单个变量。

映射变量是一种数据对列表，它将一种资产类型链接到另一种资产类型。 FootStepSounds变量将每种物理材质映射到对应的Sound Cue。

要设置FootStepSounds以将材质与声音关联，请执行以下操作：

1. **编译**蓝图，这样就可以编辑变量的默认值。
2. 选择**FootStepSounds**变量。 在**细节**面板的**默认值**下，添加一个新元素。
3. 在物理材质字段中选择**PM_Stone**资产。
4. 在Sound Cue字段中选择**SC_Footsteps_Default**资产。
5. 重复上述步骤，再添加一个元素，并将**PM_Metal**与**SC_Footsteps_Metal**进行关联。
6. 选择**FootStepSounds**变量。 在**细节**面板中的**默认值**下添加**SC_Footsteps_Default**。

要构建蓝图逻辑，请执行以下操作：

1. 在**我的蓝图**面板中，新建一个**函数**，命名为**fnGetFootStepSounds**。 该资产会在一个新的选项卡中打开。
2. 选择该函数，并在**细节**面板中执行以下操作：

   1. 添加一个新的**Input**，命名为**PhysicalMaterial**，类型为**物理材质**。
   2. 添加一个新的**Output**，命名为**SoundCue**，类型设置为**Sound Cue**。
   3. 在图表中，断开函数入口节点（**fnGetFootStepSounds**）与**Return Node**之间的连线。
3. 在函数图中，将**FootStepSounds**变量拖入图表并选择**Get**。
4. 从**Foot Step Sounds**节点的引脚拖出，添加一个**Find**节点。
5. 从**Find**节点，将第二个输入引脚连接到**fnGetFootStepSounds**节点的**Physical Material**引脚。 这是你之前添加的输入参数。
6. 在**fnGetFootStepSounds**节点上，拖出**exec**引脚并添加一个**Branch**节点。 将**Condition**引脚连接到**Find**节点底部（红色）的输出引脚。
7. 从**Branch**节点，将**True**引脚连接到**Return** **Node**。
8. 从**Return**节点拖出**Sound Cue**引脚，并连接到**Find**节点顶部（蓝色）的输出引脚。
9. 从**Branch**节点拖出**False**引脚，并添加另一个**Return** **Node**。
10. 在新的**Return Node**上，从**Sound** **Cue**引脚拖出并添加**Get Default** **Foot Steps**节点。
11. **编译**并**保存**此蓝图。

该函数会检查FootStepSounds Map中是否存在对应的物理材质（函数输入）。 如果找到了物理材质，函数将返回与该物理材质关联的Sound Cue作为输出变量。

如果没有找到物理材质，则返回DefaultFootSteps Sound Cue。

## 设置默认脚步声

接下来，你将创建一个数据资产来管理蓝图使用的值。 该资产作为一个配置层，允许你在不修改或重新编译蓝图的情况下添加、删除或更新物理材质和Sound Cue。 执行以下步骤：

1. 在**内容浏览器**中进入**AdventureGame > Artist > Audio > Footsteps**文件夹。
2. 右键单击并选择**Miscellaneous > Data Asset**。 （选择带有圆形图标的数据资产类型。）
3. 选择**BP_DA_FootSteps**数据类作为数据资产实例。
4. 将此资产命名为**DA_FootSteps**并将其打开。
5. 对于**默认脚步**，选择**SC_Footsteps_Default**。
6. 展开**脚步声（Foot Step Sounds）**，并确保列表中包含两个**FootStepSounds**映射元素。
7. 保存该数据资产。

## 构建用于播放脚步声的函数

接下来，你将在函数库中创建一个函数来播放脚步声。 项目中的任何蓝图类都可以使用蓝图函数库中的函数。

要创建并设置一个新的函数，请执行以下操作：

1. 在**内容****浏览器**中进入**AdventureGame > Designer > Blueprints > Core**，然后打开**BPL_FPGame**蓝图函数库。
2. 在**我的蓝图**面板中，新建一个函数，命名为**fnBPLPlayFootStepSound**。
3. 选择新函数，在**细节**面板中添加一个新的**输入**，命名为**PlayerReference**，类型为**Pawn**。

设置玩家与地面之间的线条检测，请执行以下操作：

1. 从**fnBPLPlayFootStepSound**节点的**exec**引脚拖出连线，并添加一个**Line** **Trace By Channel**节点。
2. 从**Line Trace By Channel**节点拖出**Start**引脚，并添加**Get Actor Location**节点。

   > [!NOTE]
   > 在节点操作（Node Actions）列表中，如果找不到某个节点，请记得关闭**上下文关联（Context Sensitive）**选项。
3. 从**Get Actor Location**节点的**Target**引脚拖出，添加一个**Get Player** **Reference**节点。
4. 从**Get Player Reference**节点的输出引脚拖出，添加一个**Make Array**节点。
5. 将**Make Array**节点的数组输出引脚连接到**Line Trace By Channel**节点的**Actors to Ignore**引脚。
6. 从**Get Actor Location**节点拖出**Return Value**引脚，并添加一个**Subtract**节点。
7. 将**Subtract**节点的输出引脚连接到**Line Trace By Channel**节点的**End**引脚。
8. 在**Subtract**节点中，将**Z**值设置为**500**。

该操作会从玩家位置向下500个单位发射一条射线进行检测，并忽略玩家角色自身。 在下一部分中，你将根据线条检测返回的表面类型，为角色分配正确的脚步声。

按照以下步骤使用你之前创建的数据资产来分配正确的脚步声：

1. 从**Line Trace By Channel**节点拖出**Out Hit**引脚，并选择**Break Hit Results**。
2. 创建一个本地变量，将其命名为**FootStepsAsset**，并将类型设置为**BP_DA_FootSteps（对象引用）**。 将其**默认值**设置为**DA_FootSteps**。
3. 将**FootStepsAsset**变量拖到**事件图表**中，并选择**Get FootStepAsset**。
4. 从FootStepsAsset节点拖出，搜索并选择**fnGetFootStepSounds**。
5. 将**LineTraceByChannel**节点的**Exec**引脚连接到**FnGetFootStepSounds**节点。 展开**Break Hit Results**节点，并将**Phys Mat**引脚连接到**FnGetFootStepSounds**节点的**Physical Material**引脚。
6. 从**FnGetFootStepSounds**节点拖出，搜索并选择**播放指定位置的声音（Play Sound At Location）**。
7. 将PlaySoundAtLocation节点的**Sound**引脚连接到**FnGetFootStepSounds**节点的**Sound Cue**引脚。
8. 拖出**PlaySoundAtLocation**节点的**Location**引脚，搜索并选择**获取Actor位置（Get Actor Location）**。 拖出其**Target**引脚，并添加**Get Player Reference**节点。
9. **保存**并**编译**函数。

它使用数据资产中的函数**fnGetFootStepSounds**，传入一个物理材质，并返回要播放的Sound Cue。

## 使用脚步声更新动画蓝图

下一步是修改玩家角色的**动画蓝图**，在角色的每只脚接触地面时调用**FnBPLPlayFootStepSound**函数。

大多数**Manny**角色（包括本项目中使用的角色）默认使用包含**通知（Notifications）**的动画。 **动画通知（Animation Notifications**，也称为**Animation Notifies**，或简称**Notifies**）可以让你创建与**动画序列**同步触发的可重复事件。 这些事件可以是声音（例如，行走或奔跑动画的脚步声）、生成粒子和其他类型。

虽然你可以将通知手动添加到动画序列中，但虚幻引擎模板中提供的大多数运动动画已经包含默认的动画通知，这些通知会在角色脚接触地面时触发（FootPlant）。

按照以下步骤查看默认的动画通知：

1. 在**内容****浏览器**中，打开玩家角色使用的动画蓝图。 对于示例项目中的**BP_AdventureChara**cter，导航至**Content > Characters > Mannequins > Anims > Unarmed**，并打开**ABP_Unarmed**。
2. 在右上角点击**动画**按钮（绿色奔跑小人图标）。 此操作会在虚幻引擎中的新标签页中打开该蓝图动画。
3. 如果想更改当前播放的动画，点击动画按钮旁边的三个点，然后选择任意行走或奔跑动画。 例如，**MF_Unarmed_Jog_Fwd**。

   提示：你也可以直接从**内容浏览器**打开慢跑动画。

在时间轴中，你会看到脚落地通知（Footplant Notifies）。

你可以添加新的通知，也可以修改已有的通知，从而构建自己的系统，在需要时触发一系列事件。 在本教程中，你将使用角色动画自带的**默认通知**。 这些通知分别命名为**AN_FootPlant_Right**和**AN_FootPlant_Left**。

要将动画的通知（Notifies）添加到蓝图中并播放脚步声，请执行以下操作：

1. 返回到**ABP_Unarmed**。
2. 在**事件图表**中右键单击，添加**AnimNotify_AN_FootPlant_Left**节点。
3. 从**Notify**节点拖出引脚，搜索并选择**FnBPLPlayFootStepSound**。
4. 添加一个**AnimNotify_AN_FootPlant_Right**节点，并将其连接到**FnBPLPlayFootStepSound**节点的**exec**输入引脚。
5. 从**FnBPLPlayFootStepSound**节点拖出**Player Reference**引脚，并添加**Get Player Pawn**节点。
6. **编译**并**保存**该动画蓝图。

这样，每当动画蓝图中的脚落地通知被触发时，它就会播放脚步声。

> [!NOTE]
> 如果你的角色使用了额外的动画蓝图，那么你也需要在这些动画蓝图中添加相同的代码。

## 更新玩家角色蓝图以播放脚步声

接下来，你将修改玩家蓝图，并添加逻辑，使角色在落地时播放声音（例如从跳跃或下落后落到地面的情况）。 由于你在蓝图函数库中创建了FnBPLPlayFootStepSound函数，因此可以在玩家角色蓝图中重复使用该函数。

要修改玩家蓝图，请执行以下操作：

1. 打开**内容浏览器**，并进入**AdventureGame > Designer > Blueprints > Characters**文件夹。
2. 打开**BP_AdventureCharacter**蓝图，并进入**事件图表**选项卡。
3. 在图表空白处右键单击并添加**Event On Landed**节点。
4. 拖出 从EventOnLanded节点的**exec**引脚拖出连线，搜索并选择**FnBPLPlayFootStepSound**。
5. 从**FnBPLPlayFootStepSound**节点拖出**Player Reference**引脚，并添加一个**Self**节点。
6. **编译**并**保存**此蓝图。

## 为地面分配物理材质

接下来，你将为多个表面分配物理材质。 执行以下步骤：

1. 在关卡中选择一个表面，例如**地面**对象。
2. 在**细节**面板的**碰撞（Collision）**部分，将**物理材质重载****（Phys Material Override）**更改为你之前创建的某个物理材质。
3. 重复上述步骤，将两种物理材质类型添加到关卡的一些地面上。

你也可以通过以下方式为材质实例添加物理材质：

1. 打开材质实例，并进入**细节**面板。
2. 向下滚动到**通用（General）**部分，点击**物理材质（Phys Material）**下拉菜单并选择你需要的物理材质。
3. 保存该材质实例。

## 测试脚步声

运行游戏，在带有物理材质的表面上行走或跳跃，即可听到对应的脚步声。

如果该表面设置了物理材质，你就会听到与之对应的脚步声。 如果没有检测到物理材质，则播放默认脚步声。

## 下一步

在下一个模块中，你将学习如何使用Niagara VFX系统创建火焰视觉效果，并将其应用到你的火焰陷阱上。

- [为游戏添加视觉效果](../at12-adding-visual-effects-to-your-game/index.md) - 为你的游戏添加视觉效果！

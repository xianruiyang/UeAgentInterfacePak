---
title: "创建瞄准偏移"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-an-aim-offset-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "创建瞄准偏移"]
---

# 创建瞄准偏移

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 创建瞄准偏移

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-an-aim-offset-in-unreal-engine

本指南中，我们将创建一个[瞄准偏移](index.md)，这是一种资源，其中存储了一系列可混合的姿势，用于帮助角色瞄准武器。我们将一个动画序列细分成瞄准偏移的可用姿势，获取玩家的鼠标倾斜/偏转位置，并用它来确定使用哪个混合姿势，这样角色就可以在鼠标的位置上移动和瞄准（有一些限制），如下面的例子所示。

完成以下步骤将得到与上述类似的角色：

## 1 - 创建瞄准姿势

在本步骤中，我们更新默认可操作角色，并创建瞄准偏移所需的所有姿势。

> [!NOTE]
> 在本指南中，我们使用 **蓝图第三人称模板（Blueprint Third Person Template）** 项目，并将 **动画初学者包（Animation Starter Pack）** 添加到项目中：
>
> 你可以从Epic启动程序的 **虚幻商城（Marketplace）** 免费下载动画初学者包。

### 步骤

1. 在 **内容浏览器** 的 **Content/ThirdPersonBP/Blueprints** 文件夹下，打开 **第三人称游戏模式（ThirdPersonGameMode）**。
2. 在 **默认Pawn类（Default Pawn Class）** 下，单击下拉菜单并选择 **Ue4ASP_Character**，然后单击 **保存（Save）** 并关闭蓝图。

   我们将默认可操作角色更改为使用动画初学者包随附的角色。
3. 在 **内容浏览器** 中，打开 **Content/AnimStarterPack** 文件夹，然后单击 **新增（Add New）** 并创建一个名为 **AimPoses** 的文件夹。
4. 将 **Aim_Space_Hip** 资源拖动到 **AimPoses** 文件夹上，并选择 **复制（Copy）**。

   这是一个动画序列，包含一系列瞄准武器的动作，我们将把这些动作分解成各个姿势。
5. 在 **AimPoses** 文件夹中，选中 **Aim_Space_Hip**，按 **Ctrl+W** 复制并将其命名为 **Aim_Center**。
6. 打开 **Aim_Center** 资源，单击播放功能按钮中的 **暂停（Pause）** 按钮，然后单击 **ToFront** 按钮。
7. **右键单击** 时间轴中的擦除条，然后选择 **删除第1帧到第87帧（Remove from frame 1 to frame 87

   现在我们有了一个单帧，其中包含一个可在瞄准偏移中使用的姿势。
8. 在 **AimPoses** 文件夹中，选中 **Aim_Space_Hip**，按 **Ctrl+W** 复制并将其命名为 **Aim_Center_Down**。
9. 打开 **Aim_Center_Down**，确保它在第 **0** 帧上，然后单击 **ToNext** 按钮转到第 **20** 帧。

   角色现在将在视口中向下瞄准，这就是用来向下瞄准的姿势。
10. **右键单击** 时间轴中的擦除条，然后选择 **删除第0帧到第20帧（Remove frame 0 to frame 20）** 选项。

    根据在擦除条上 **右键单击** 的位置，帧范围可能差一两帧，只要确保角色向下瞄准就好。
11. 再次 **右键单击** 时间轴中的擦除条，然后选择 **删除第1帧到第68帧（Remove from frame 1 to frame 68）** 选项。
12. 在 **AimPoses** 文件夹中，选中 **Aim_Space_Hip**，按 **Ctrl+W** 复制并将其命名为 **Aim_Center_Up**。
13. 打开 **Aim_Center_Up**，确保它在第 **0** 帧上，然后单击 **ToNext** 按钮转到第 **10** 帧。
14. **右键单击** 时间轴中的擦除条，然后选择 **删除第0帧到第10帧（Remove frame 0 to frame 10）** 选项。
15. 再次 **右键单击** 时间轴中的擦除条，然后选择 **删除第1帧到第78帧（Remove from frame 1 to frame 78）** 选项。
16. 每次都 **复制（Duplicate）** **Aim_Space_Hip** 资源，并基于下表创建剩余的各个姿势。

    | 动画名称 | 起始关键帧 | 删除第1帧 | 删除第2帧 |
    | --- | --- | --- | --- |
    | **Aim_Left_Center** | 30 | 0 - 30 | 1 - 57 |
    | **Aim_Left_Up** | 40 | 0 - 40 | 1 - 48 |
    | **Aim_Left_Down** | 50 | 0 - 50 | 1 - 37 |
    | **Aim_Right_Center** | 60 | 0 - 60 | 1 - 27 |
    | **Aim_Right_Up** | 70 | 0 - 70 | 1 - 17 |
    | **Aim_Right_Down** | 80 | 0 - 80 | 1 - 8 |

    对于每个动画，确保从建议的 **起始关键帧（Start At Keyframe）** 帧开始，然后 **右键单击** 擦除条并 **删除第1帧（Remove Frames 1）**，再次 **右键单击** 擦除条并 **删除第2帧（Remove Frames 2）**。每个动画都应是个单独的帧，角色瞄准其对应名称的方向。创建各个动画后，你的 **AimPoses** 文件夹中每个瞄准方向都有几种姿势。
17. 在 **内容浏览器** 中，按住 **Shift** 并选择各个瞄准姿势。
18. **右键单击** 并在 **资源操作（Asset Actions）** 下选择 **通过属性矩阵批量编辑（Bulk Edit via Property Matrix）** 选项。
19. 在 **属性矩阵（Property Matrix）** 中，在 **附加设置（Additive Settings）** 下，将 **附加动画类型（Additive Anim Type）** 更改为 **模型空间（Mesh Space）**。

    > [!NOTE]
    > 为了使动画与瞄准偏移兼容，必须将其附加动画类型设置为 **模型空间（Mesh Space）**。
20. 将 **基础姿势类型（Base Pose Type）** 更改为 **选定动画帧（Selected animation frame）**，然后在 **基础姿势动画（Base Pose Animation）** 下，单击选取资源图标并选择 **Idle_Rifle_Hip**。

    该基础姿势类型将定义如何计算累加delta。
21. 一旦完成此操作，返回 **内容浏览器** 并单击 **全部保存（Save All）** 按钮。

创建各个姿势资源后，下一步我们将利用这些姿势创建瞄准偏移。

## 2 - 创建瞄准偏移

在这一步中，我们将使用各个瞄准姿势创建瞄准偏移，该偏移会混合在各个姿势之间。

### 步骤

1. 在 **Content/AnimStarterPack/UE4_Mannequin/Mesh** 文件夹中，**右键单击** **UE4_Mannequin** 并选择 **创建瞄准偏移（Create Aim Offset）**。

   这将基于该骨架创建瞄准偏移资源。
2. 在瞄准偏移（Aim Offset）窗口（中央窗口）的 **参数（Parameters）** 下，输入如下所示的参数。

   将 **X轴标签（X Axis Label）** 设置为 **Yaw**，将 **Y轴标签（Y Axis Label）** 设置为 **Pitch**，然后将两个轴范围都设置为 **-90到90（-90 to 90）**，并单击 **应用参数更改（Apply Parameter Changes）**。

   > [!NOTE]
   > 瞄准偏移的工作原理非常类似于[混合空间](../../animation-assets-and-features/blend-spaces/index.md)，可用于基于参数混合我们的姿势。
3. 在 **资源浏览器** 中搜索 **Aim**，然后将 **Aim_Center** 动画拖动到图表中心位置上，如下所示。
4. 将 **Aim_Center_Up** 拖动到位置 **1**，将 **Aim_Center_Down** 拖动到位置 **2**，如下所示。

   你可以选择取消选中 **启用提示文本显示（Enable Tooltip Display）** 选项以关闭网格中的工具提示。
5. 将 **Aim_Left_Center** 拖动到位置 **1**，将 **Aim_Right_Center** 拖动到位置 **2**，如下所示。
6. 添加 **Aim_Left_Up** (1)、**Aim_Right_Up** (2)、**Aim_Left_Down** (3)和 **Aim_Right_Down** (4)姿势以完成瞄准偏移。
7. 在 **资源详情（Asset Details）** 面板中，将 **附加设置（Additive Settings）** 下的 **预览基础姿势（Preview Base Pose）** 选项设置为 **Idle_Rifle_Hip**。

   你可以通过在网格中移动鼠标来预览混合的姿势，视口网格体会根据你的鼠标位置更新它的姿势。

瞄准偏移现已创建，下一步我们将把它挂在我们的 **动画蓝图** 中使用，这样游戏进程就可以驱动混合。

## 3 - 实现瞄准偏移

在这一步中，我们将瞄准偏移添加到动画蓝图，并将其挂到我们现有的动画图表上。

### 步骤

1. 在 **Content/AnimStarterPack** 文件夹中，打开 **UE4ASP_HeroTPP_AnimBlueprint** 并 **双击** **我的蓝图（MyBlueprint）** 面板中的 **动画图表（AnimGraph）**。
2. 从 **资源浏览器（Asset Browser）** 选项卡中，拖入瞄准偏移资源。
3. 按如下所示连接瞄准偏移，然后 **右键单击** **Yaw** 和 **Pitch** 引脚，并 **提升为变量（Promote to Variable）**，然后将它们命名为 **Aim Yaw** 和 **Aim Pitch**。

   每当玩家用鼠标瞄准并驱动瞄准偏移的姿势时，就会使用这两个变量。
4. 在 **我的蓝图（MyBlueprint）** 面板，跳到 **事件图表（EventGraph）**。
5. 在 **事件图表（EventGraph）** 中，找到脚本移动（Movement）部分的 **Sequence** 节点。

   单击 **Sequence** 节点上的 **添加引脚（Add pin）** 按钮。
6. 从 **我的蓝图（MyBlueprint）** 面板，按住 **Alt** 并拖入 **Aim Yaw** 和 **Aim Pitch**，以连接到 **Sequence** 节点。
7. 从 **Cast To Ue4ASP_Character** 节点拖出一根引线，并添加 **Get Control Rotation** 和 **Get Actor Rotation** 节点。
8. 从 **Get Control Rotation** 节点拖出一根引线，并添加 **Delta(Rotator)** 节点。
9. 将 **Get Actor Rotation** 连接到 **Delta(Rotator) B Pin**，然后从 **Return Value** 拖出一根引线，添加一个 **RInterp To** 节点（并将连接从当前（Current）切换到目标（Target））。

   > [!TIP]
   > 可按住 **Ctrl** 并 **单击** **当前（Current）** 引脚，以将其连接拖动到 **目标（Target）** 引脚。
10. 从 **RInterp To** 节点的 **当前（Current）** 引脚拖出一根引线，并选择 **Make Rotator**。
11. 从 **我的蓝图（MyBlueprint）** 面板中，按住 **Ctrl** 并拖入 **Aim Pitch** 和 **Aim Yaw** 变量，然后将它们连接到 **Make Rotator** 节点的 **Pitch** 和 **Yaw**。
12. 在 **移动（Movement）** 脚本的开头，找到 **Event Blueprint Update Animation** 节点并将 **Delta Time X** 提升为名为 **Time** 的变量，然后按如下方式连接。
13. 返回 **RInterp To** 节点，连接新 **Time** 变量，并将 **Interp Speed** 设置为 **15**。

    我们将使用角色的旋转和玩家输入的旋转来创建一个新的旋转器，它将限制角色在某个方向上可以旋转的程度。
14. 从 **RInterp To** 节点拖出一根引线，添加一个 **Break Rotator** 以及 **Pitch** 和 **Yaw** 的 **夹角（Clamp Angle）**，并将最小/最大角度分别设置为 **-90** 和 **90**。
15. 将 **夹角（Clamp Angle）** 从 **Pitch** 连接到 **Aim Pitch**，并从 **Yaw** 连接到 **Aim Yaw**。

    现在，计算角色旋转和玩家当前控制器旋转时要考虑到驱动瞄准偏移的Aim Yaw和Aim Pitch值，且这两个值被夹紧以防止角色在某个方向旋转过多。如不夹紧角度，角色的腿朝向前方的同时，角色的身体可能转一圈并朝向相反方向，这是我们需要避免出现的情况。

我们即将完成设置，下一步，我们将把所有的东西统合起来，测试角色的瞄准能力。

## 4 - 完成

在最后一节中，我们将更新角色蓝图，以更改控制器旋转的处理方式，并在测试前修复一些小问题。

### 步骤

1. 在 **Content/AnimStarterPack** 文件夹中，打开 **Ue4ASP_Character** 蓝图。
2. 在 **组件（Components）** 窗口中单击 **Ue4ASP_Character**，然后在 **详情（Details）** 中取消选中 **使用控制器旋转Yaw（Use Controller Rotation Yaw）**。

   这将防止角色自动转向控制器的偏转位置。
3. 在 **组件（Components）** 窗口中单击 **胶囊体组件（CapsuleComponent）**，然后在 **详情（Details）** 面板中选中 **在游戏中隐藏（Hidden in Game）** 选项。

   这将在游戏进程中隐藏调试碰撞显示。
4. 单击 **我的蓝图（MyBlueprint）** 中的 **事件图表（EventGraph）**，然后找到 **蹲伏（Crouching）** 部分，将 **InputAction Crouch** 节点替换为 **C** 按键事件。

   这将删除窗口左上角编译按钮上的黄色预警信号，因为项目默认情况下没有蹲伏动作映射，我们将使用 **C** 按钮蹲伏（可以使用任何你想要的按键事件）。
5. **编译（Compile）** 并 **保存（Save）**，然后关闭蓝图。
6. 从关卡中移除 **第三人称角色（ThirdPersonCharacter）**。

   这可确保我们使用分配到游戏模式的角色，而不是放置在关卡中的角色。
7. 单击 **运行（Play）** 按钮在编辑器中运行。

### 最终结果

在编辑器中运行时，角色现在将会在静止状态下瞄准，并对鼠标的移动做出反应，指向鼠标的方向。有一些限制，用于防止当鼠标在角色背后时角色转身面朝后方，以及当角色慢跑时，移动鼠标会使角色躯干转向鼠标所指向的方向。

我们可以更进一步，允许角色瞄准一个方向并在该方向上播放射击动画，并且（或）允许角色在朝某个方向移动时或蹲伏（通过在现有动画上[叠加动画](../using-layered-animations/index.md)来实现）时播放射击动画。或者以[骨架网格体套接字](../../animation-assets-and-features/skeletons/skeletal-mesh-sockets/index.md)为例，看看在角色可以瞄准的情况下，如何将武器附加到角色的手中。

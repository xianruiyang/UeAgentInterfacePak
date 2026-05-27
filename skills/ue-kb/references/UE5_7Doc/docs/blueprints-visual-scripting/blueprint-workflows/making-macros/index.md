---
title: "创建宏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/making-macros-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图工作流程", "创建宏"]
---

# 创建宏

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图工作流程 / 创建宏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/making-macros-in-unreal-engine

本质上来说，**宏（Macro）**和折叠的节点图表原理相同。 它们都有通道节点设计的进入点和离开点。 每个通道可拥有任意数量的执行或数据引脚。在其他蓝图和图表上使用时，这些引脚在宏节点上均为可见。

## 创建宏

在本教程中，你将创建一个**宏**来检查角色是否拥有足够的能量执行跳跃。 如果角色确实有足够能量，该宏将消耗玩家的能量，将当前值显示在屏幕上，然后调用跳跃函数。 如果角色没有足够的能量，该宏将在屏幕上显示"能量不足"，并禁止角色跳跃。

> [!NOTE]
> 在此例中，我们将使用启用了**初学者内容包**的蓝图第三人称项目。

1. **创建**并**启动**你的项目后，找到`Content/ThirdPerson/Blueprints`文件夹，打开**BP_ThirdPersonCharacter**蓝图。
2. 找到**我的蓝图（My Blueprint）**窗口，点击**添加宏（Add Macro）**按钮。
3. 将创建新的宏，选中后按**F2**键将其重命名为**EnergyCheck**。
4. 选择宏之后，找到**细节（Details） > 输入（Inputs）**，点击**添加（+）**，创建名为**BeginCheck**的新**输入**，然后将其类型更改为**Exec**（即执行引脚）。
5. 找到**细节（Details）** > **输出（Outputs）**，点击**添加（+）**，创建两个新的输出。 将其中一个命名为**HasEnergy**，另一个命名为**NoEnergy**，然后设置**Exec**引脚类型。

   > [!NOTE]
   > 这将在宏节点本身上创建输入/输出节点，用于与宏之间传递数据。

   对于输入，使用名为**BeginCheck**的执行引脚来启动宏。 接着创建一个脚本，检查玩家是否拥有足够的能量执行跳跃，如有，则执行**HasEnergy**引脚。 如果玩家能量不足，则执行**NoEnergy**引脚。
6. 在**我的蓝图（My Blueprint）**窗口中，点击**添加变量（Add Variable）**按钮，创建名为**Energy**的新浮点变量。
7. 在工具栏上，点击**编译（Compile）**，选择**能量（Energy）**，然后找到**细节（Details）**面板，将其值设置为**100**。
8. 在**能量（Energy）**图表中，按住**B**键并**左键点击**以创建**Branch**节点。

   Blueprint

   context_graph

   Inputs

   Begin Check

   Outputs

   Has Energy

   No Energy

   Branch

   Condition

   True

   False

   Fullscreen

   Reset

   Graph

   Zoom 1:1

   Renderer by

   Rancoud

   blueprint

   INIT INTERACTIONS...
9. 按住**Ctrl**键并将**Energy**浮点变量从**我的蓝图（My Blueprint）**选项卡拖移至宏图表中，点击并拖出输出引脚并搜索**Greater**运算符节点，然后将输出引脚连接到**Branch**。
10. 按住**Alt**键并拖入**Energy**变量以添加**Set**节点。
11. 再次按住**Ctrl**键并拖入**Energy**，将其连接到**Subtact**（**-**）节点，设置为**10**，将其连接到**Set**节点。 此脚本意味着能量大于0时，将从当前能量值中减去10。
12. 在图表中**点击右键**并添加**Print String**节点，然后将**Set Energy**节点连接到**字符串格式（In String）**引脚。

    添加了**Conversion**节点，它会将能量值转换为数值字符串并显示在屏幕上。
13. 拖出**Branch**节点的**False**引脚，添加另一个**Print String**节点，并在框中输入文本**"能量不足！（Out of Energy!）"**。 然后将第一个和第二个**Print String**节点分别连接到**HasEnergy**和**NoEnergy**引脚。

    Blueprint

    context_graph

    Inputs

    Begin Check

    Outputs

    Has Energy

    No Energy

    Branch

    Condition

    True

    False

    Energy

    >

    0.0

    SET

    Energy

    Fullscreen

    Reset

    Graph

    Zoom 1:1

    Renderer by

    Rancoud

    blueprint

    INIT INTERACTIONS...

    该宏现在已被设为检查**Energy**变量（如适用，则从中减去数值），显示玩家是否拥有足够的能量，进而确定玩家是否可以跳跃。 现在，你需要在按"跳跃（Jump）"键之后，且在执行跳跃动作之前实现宏。
14. 在**事件图表（EventGraph）**上，拖出**InputAction Jump**节点的**Pressed**引脚，并搜索**EnergyCheck**。

    可以看到你创建的宏位于**工具（Utilities）**下，宏图标旁是它的名称。
15. 添加宏之后，跳跃脚本应如下所示。
16. 点击**编译（Compile）**和**保存（Save）**按钮，然后关闭蓝图。
17. 点击**编辑器**主**工具栏**上的**播放**按钮。

    按**空格**执行跳跃时，屏幕左上角将显示**能量（Energy）**的值。 **能量**为0时无法跳跃。

## 最终结果

> 动图已省略：ba0033460421c155b5f10205e3c11c74a644dc8b35ba0c23a602edea357229b3

这是使用宏将脚本执行并合并为一个单独节点、改善事件图表和主要角色脚本易读性的基本范例。 除此之外还可在其他情况下调用这个宏。 例如，如果存在其他消耗玩家能量的动作，且需要确定玩家是否有能量执行此操作（如攻击等），你就可以运行此宏来检查玩家在按下攻击键后是否还有足够的能量来攻击，然后利用**HasEnergy**执行引脚执行一次攻击。

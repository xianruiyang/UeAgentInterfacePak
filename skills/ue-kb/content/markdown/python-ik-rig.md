# 使用Python处理IK Rig

---
title: "使用Python处理IK Rig"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-python-to-create-and-edit-ik-rigs-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "IK Rig", "IK Rig编辑器", "使用Python处理IK Rig"]
---

# 使用Python处理IK Rig

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / IK Rig / IK Rig编辑器 / 使用Python处理IK Rig

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-python-to-create-and-edit-ik-rigs-in-unreal-engine

创建和使用[IK Rig](../../index.md)以对 **虚幻引擎（Unreal Engine）** 中的角色和对象制作动画时，你可以使用自定义[Python脚本](https://dev.epicgames.com/documentation/404)控制和自动执行IK Rig资产工作流程。

本文档提供了概述和示例Python脚本，供你参考并用于编辑IK Rig资产以及与之交互。

## 概述

IK Rig是一组控制点和解算器，可将运动数据应用于虚幻引擎中的骨骼网格体资产。IK Rig包含多个部分：

- **骨骼** 、 **目标** 、 **目标设置** 和 **骨骼设置** 的层级。
- 影响层级的骨骼及其彼此之间关系的[IK解算器](../ik-rig-solvers/index.md)的列表。

  - 目标用于驱动IK解算器，而目标设置和骨骼设置用于定义解算器的行为。
- 用于[IK重定向](https://dev.epicgames.com/documentation/404)的 **重定向根骨骼（Retarget Root）** 和 **重定向链（Retarget Chains）** 列表。
- 专用于编辑器中预览的预览场景。

IK Rig系统是使用"模型">"视图">"控制器"设计公式构造的。数据模型本身使用以下术语：

- **解算器（Solver）** ：它包含在链中旋转和定位骨骼的 **逆运动学** 解决方案。你还可同时使用多个解算器，以进一步自定义IK在最终姿势上的效果。
- **目标（Goal）** ：用作IK链的 **执行器点** 。目标与解算器一起使用，以修改传入姿势来到达目标位置。目标可以分配给多个解算器。
- **目标设置（Goal Settings）** ：IK目标中存在的特定于解算器的设置。每次将解算器分配给目标时，都存在不同的特定于解算器的设置对象。
- **骨骼设置（Bone Settings）** ：骨骼中存在的特定于解算器的设置。每次将解算器分配给骨骼时，都存在不同的特定于解算器的设置对象。
- **重定向根骨骼（Retarget Root）** ：会用于从源传输到目标的角色运动的根骨骼。
- **重定向链（Retarget Chains）** ：为了将运动从源传输到目标而定义的骨骼的链。

## 访问IK Rig

针对IK Rig编写脚本时，第一步是获得你将与之交互的主要对象的访问权限，或设置 `The IKRigDefinition` 。有多种方式可以这样做，具体取决于你的情况。以下示例将演示如何使用Python脚本定义IK Rig对象。

### 加载现有IKR资产

要访问现有IK Rig资产（ `ikr` ），你可以直接使用以下示例脚本加载资产：

```
 import unreal # 确保文件路径对于你的资产在项目中的位置是正确的。 ikr = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/IK_Mannequin', outer = None) 
```

## 创建新IKR资产

要创建新IK Rig资产，你可以使用以下工厂：

```
 # 获取资产工具。 asset_tools = unreal.AssetToolsHelpers.get_asset_tools() # 在文件路径定义的位置中创建IK Rig。例如：` …/Game/IK_Mannequin` 。 ikr = asset_tools.create_asset(asset_name='IK_Mannequin', package_path='/Game/', asset_class=unreal.IKRigDefinition, factory=unreal.IKRigDefinitionFactory()) 
```

## 编辑IK Rig

### 访问控制器来准备编辑

控制器是可用于对IK Rig做出更改的中心对象。控制器有许多函数可用于做出编辑。以下示例是你可以使用Python脚本对IK Rig资产做出编辑的一部分方法：

```
 # 获取IK Rig控制器。 ikr_controller = unreal.IKRigController.get_controller(ikr) 
```

### 在新IK Rig中分配骨骼网格体

创建新IK Rig时，你将需要为其分配骨骼网格体。你可以使用以下Python脚本加载IK Rig并为其分配骨骼网格体资产，以及引用或获取分配给IK Rig的骨骼网格体资产。

```
 # 加载骨骼网格体资产。 skel_mesh = unreal.load_asset(name = '/Game/Characters/Mannequins/Meshes/SKM_Manny_Simple') ### 将骨骼网格体资产分配给IK Rig。 ikr_controller.set_skeletal_mesh(skel_mesh) # 获取分配给IK Rig的骨骼网格体。 set_mesh = ikr_controller.get_skeletal_mesh() 
```

### 自动重定向链与自动FBIK

你可以通过控制器应用命令，使用目标自动生成重定向链和全身IK解算器。该自动生成基于常见的两足骨架。

```
# 基于常见两足骨架应用自动生成的重定向链ikr_controller.apply_auto_generated_retarget_definition()  # 基于常见两足骨架应用自动生成的全身IK解算器ikr_controller.apply_auto_fbik()
```

### 添加、编辑和查询IK解算器

你可以通过控制器轻松添加不同的IK解算器。添加解算器需要指定 **IK Rig解算器（IK Rig Solver）** 类。这是必需的，因为项目中可能使用了自定义IK Rig解算器。只要基类为 `IKRigSolver` ，任何类输入都可以。

```
 # 将FBIK、身体移动器、手足、极和设置变换解算器添加到IK Rig。 fbik_index = ikr_controller.add_solver(unreal.IKRigFBIKSolver) bodymover_index = ikr_controller.add_solver(unreal.IKRig_BodyMover) limb_index = ikr_controller.add_solver(unreal.IKRig_LimbSolver) pole_index = ikr_controller.add_solver(unreal.IKRig_PoleSolver) settransform_index = ikr_controller.add_solver(unreal.IKRig_SetTransform) 
```

添加解算器时，控制器将输出解算器索引。此索引会确定IK Rig将解算的解算器顺序。你可以使用索引切换解算器的操作状态，移动堆栈中的解算器，或删除特定解算器。

```
 # 启用或禁用特定解算器。 ikr_controller.set_solver_enabled(bodymover_index, False) # 移动解算器。 ikr_controller.move_solver_in_stack(bodymover_index, limb_index) # 删除解算器。 ikr_controller.remove_solver(bodymover_index) ikr_controller.remove_solver(limb_index) ikr_controller.remove_solver(pole_index) ikr_controller.remove_solver(settransform_index) 
```

你还可以使用以下脚本查询解算器索引或IK Rig中的所有解算器：

```
 # 获取IK Rig控制器在索引中的第一个解算器。 fbik_solver = ikr_controller.get_solver_at_index(fbik_index) # 获取与IK Rig控制器关联的解算器数量。 num_solvers = ikr_controller.get_num_solvers() 
```

### 设置解算器的根骨骼

要使解算器能够正常运行，它需要根骨骼才能开始解算。这将需要解算器索引以设置根骨骼。你可以使用以下脚本设置解算器的根骨骼：

```
 # 设置和获取第一个解算器的根骨骼。 ikr_controller.set_root_bone("pelvis", 0) root_bone = ikr_controller.get_root_bone(0) 
```

### 添加/编辑/查询IK目标

需要目标才能驱动IK解算器。可以使用或不使用目标骨骼添加目标，并且目标可以重命名。

```
 # 将目标添加到IK Rig。你还可以在创建期间分配骨骼。 ikr_controller.add_new_goal("hand_l_goal", None) ikr_controller.add_new_goal("TEMP_hand_r_goal", "hand_r") # 将骨骼分配到现有目标。 # 你还可以在骨骼中查询目标，以及在目标中查询骨骼。 ikr_controller.set_goal_bone("hand_l_goal", "hand_l") ikr_controller.get_goal_name_for_bone("hand_l") ikr_controller.get_bone_for_goal("hand_l_goal") # 重命名目标。 ikr_controller.rename_goal("TEMP_hand_r_goal", "hand_r_goal") # 删除目标。 ikr_controller.remove_goal("hand_r_goal") 
```

你还可以查询IK Rig中的所有目标。

```
 # 获取IK Rig中的所有目标。 ikr_controller.get_all_goals() 
```

要编辑目标属性，你可以获取目标对象并编辑编辑器属性。

```
 # 获取目标对象，并设置位置alpha。 goal = ikr_controller.get_goal("hand_r_goal") goal.set_editor_property("position_alpha", 0.5) new_alpha = goal.get_editor_property("position_alpha") 
```

### 将目标连接到解算器

现在目标已添加，你需要将其连接到解算器。在连接之前，你可以检查目标是否已连接到解算器。

```
 # 检查目标是否已连接到任何解算器或特定解算器。 ikr_controller.is_goal_connected_to_any_solver("hand_r_goal") ikr_controller.is_goal_connected_to_solver("hand_r_goal", 0) # 将目标连接到解算器或从中断开连接 ikr_controller.connect_goal_to_solver("hand_r_goal", 0) ikr_controller.disconnect_goal_from_solver("hand_r_goal", 0) 
```

### 添加/编辑/查询目标和骨骼设置

将目标连接到解算器后，你可以访问该特定目标的目标设置。目标与解算器之间的每个连接都有自己的特定设置。

在以下示例中， `hand_r_goal` 连接到FBIK解算器和身体移动器解算器，因此它会有两个不同的目标设置，分别与对应的解算器关联。

```
 # 通过输入目标名称和解算器来获取目标的特定设置。 hand_r_goal_settings = ikr_controller.get_goal_settings_for_solver("hand_r_goal", 0) # 编辑特定执行器设置的属性。 hand_r_goal_settings.pull_chain_alpha = 0 hand_r_goal_settings.strength_alpha = 1 
```

解算器可以选择支持按骨骼的设置，但是并非所有解算器都需要如此。在IK Rig随附的解算器中，只有FBIK解算器有按骨骼的设置。其示例设置类似于之前介绍的关于目标设置的内容。

```
 # 将骨骼设置添加到手臂 ikr_controller.add_bone_setting("lowerarm_l", 0) ikr_controller.add_bone_setting("lowerarm_r", 0) ikr_controller.add_bone_setting("clavicle_l", 0) ikr_controller.add_bone_setting("clavicle_r", 0) # 获取骨骼设置。 left_lowerarm_setting = ikr_controller.get_bone_settings("lowerarm_l", 0) right_lowerarm_setting = ikr_controller.get_bone_settings("lowerarm_r", 0) left_clav_setting = ikr_controller.get_bone_settings("clavicle_l", 0) right_clav_setting = ikr_controller.get_bone_settings("clavicle_r", 0) # 设置偏好角度和旋转刚度。 left_lowerarm_setting.use_preferred_angles = True left_lowerarm_setting.preferred_angles = unreal.Vector(0,0,90) right_lowerarm_setting.use_preferred_angles = True right_lowerarm_setting.preferred_angles = unreal.Vector(0,0,90) left_clav_setting.rotation_stiffness = 1 right_clav_setting.rotation_stiffness = 1 
```

### 检查与其他骨骼网格体的兼容性

IK Rig与骨架无关，这意味着你可以在相似的骨架层级之间共享IK Rig。通过Python，你可以使用简单命令检查IK Rig的网格体兼容性。

```
 # 检查此IK Rig是否兼容定义的骨骼网格体。 compatible_skel_mesh = unreal.load_asset(name = '/Game/Characters/Mannequins/Meshes/SKM_Quinn_Simple') print(ikr_controller.is_skeletal_mesh_compatible(compatible_skel_mesh)) 
```

### 添加、编辑和查询重定向根骨骼和链

要为重定向设置IK Rig，它需要有重定向根骨骼和重定向链。这些可以使用以下示例Python脚本创建。

```
 # 设置或获取重定向根骨骼。 ikr_controller.set_retarget_root("pelvis") retarget_root = ikr_controller.get_retarget_root() 
```

对于重定向链，你可以在不输入起始骨骼、末端骨骼或目标的情况下创建它们。这些可以稍后根据需要添加到链。

```
 # 添加带有起始骨骼、末端骨骼和目标的重定向链。 ikr_controller.add_retarget_chain("LeftArm", "upperarm_l", "hand_l", "hand_l_goal") # 添加重定向链 ikr_controller.add_retarget_chain("TEMP_RightArm", "", "", "") # 重命名重定向链。 ikr_controller.rename_retarget_chain("TEMP_RightArm", "RightArm") # 设置重定向链的起始骨骼、末端骨骼和目标。 ikr_controller.set_retarget_chain_start_bone("RightArm", "upperarm_r") ikr_controller.set_retarget_chain_end_bone("RightArm", "hand_r") ikr_controller.set_retarget_chain_goal("RightArm", "hand_r_goal") # 获取重定向链的起始骨骼、末端骨骼和目标。 ikr_controller.get_retarget_chain_start_bone("RightArm") ikr_controller.get_retarget_chain_end_bone("RightArm") ikr_controller.get_retarget_chain_goal("RightArm") # 删除重定向链。 ikr_controller.remove_retarget_chain("RightArm") 
```

你还可以查询IK Rig中的所有重定向链条。

```
 # 获取IK Rig中的所有重定向链。 all_retarget_chains = ikr_controller.get_retarget_chains() 
```


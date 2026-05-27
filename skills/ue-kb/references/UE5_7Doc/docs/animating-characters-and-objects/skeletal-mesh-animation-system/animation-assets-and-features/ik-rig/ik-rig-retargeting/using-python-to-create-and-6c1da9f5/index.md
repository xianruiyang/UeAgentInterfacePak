---
title: "使用Python处理IK重定向器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-python-to-create-and-edit-ik-retargeter-assets-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "IK Rig", "IK Rig Retargeting", "使用Python处理IK重定向器"]
---

# 使用Python处理IK重定向器

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / IK Rig / IK Rig Retargeting / 使用Python处理IK重定向器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-python-to-create-and-edit-ik-retargeter-assets-in-unreal-engine

创建和使用[IK重定向器](https://dev.epicgames.com/documentation/404)资产以使用 **虚幻引擎（Unreal Engine）** 中的[IK Rig](../../index.md)重定向角色和对象的动画时，你可以使用自定义[Python脚本](https://dev.epicgames.com/documentation/404)控制和自动执行IK重定向器资产工作流程。

本文档提供了概述和示例Python脚本，供你参考并用于编辑IK重定向器资产以及与之交互。

## 概述

IK重定向器资产包含多个部分：

- 用于定义重定向关系的 **源（Source）** 和 **目标IK Rig（Target IK Rig）** 。
- 源和目标IK Rig中的 **源（Source）** 和 **目标骨骼网格体（Target Skeletal Mesh）** 覆盖。
- 源和目标之间的 **重定向链（Retarget Chain）** 映射，定义每个链之间的关系。
- 源或目标的 **重定向姿势（Retarget Poses）** 的列表，定义重定向将解决的起始姿势。
- **全局（Global）** 、 **重定向根骨骼（Retarget Root）** 和每个 **重定向链（Retarget Chain）** 的属性的列表。
- 专用于编辑器中预览的预览场景。

使用以下术语的IK重定向器数据模型：

- **源（Source）** 和 **目标IK Rig（Target IK Rig）** ：将用于将重定向链映射到一起以将源的运动传输到目标的IK Rig。
- **源（Source）** 和 **目标网格体（Target Mesh）** ：要用于为重定向定义源和目标比例以及访问要预览的源动画的骨骼网格体。
- **源（Source）** 和 **目标重定向姿势（Target Retarget Pose）** ：你希望源或目标用于传输运动的姿势。理想情况下，目标应该匹配到源所在的姿势。
- **全局设置（Global Settings）** ：影响整个重定向的宏观级设置。
- **根设置（Root Settings）** ：影响重定向根骨骼的设置。
- **链设置（Chain Settings）** ：影响指定重定向链的设置。

## 访问IK重定向器

针对IK重定向器资产编写脚本时，第一步是获得你将与之交互的主要对象 `IKRetargeter` 的访问权限。有多种方式可以获得对象的访问权限，具体取决于你的项目。

### 加载现有RTG资产

要访问现有IK重定向器资产（ `rtg` ），你可以直接使用以下示例脚本加载资产：

```
 import unreal #  确保文件路径对于你的资产在项目中的位置是正确的。 rtg = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/RTG_Mannequin', outer = None) 
```

## 创建新RTG资产

要创建新IK重定向器资产，你可以使用以下工厂：

```
 # 获取资产工具。 asset_tools = unreal.AssetToolsHelpers.get_asset_tools() # 在文件路径定义的位置中创建IK重定向器资产。例如， `.../Game/RTG_Mannequin` 。 rtg = asset_tools.create_asset(asset_name='RTG_Mannequin', package_path='/Game/', asset_class=unreal.IKRetargeter, factory=unreal.IKRetargetFactory()) 
```

## 编辑IK重定向器

### 访问控制器来准备编辑

控制器是可用于对IK重定向器做出更改的中心对象。控制器有许多函数可用于做出编辑。以下示例是你可以使用Python脚本对IK重定向器资产做出编辑的一部分方法：

```
 # 获取IK重定向器控制器。 rtg_controller = unreal.IKRetargeterController.get_controller(rtg) 
```

### 将源和目标IK Rig和网格体分配到新资产

要运行重定向，你必须提供源和目标IK Rig。在本例中，我们将创建IK重定向器资产，以将动画从Manny角色重定向到Quinn角色，这意味着我们可以同时将 `IK_Mannequin` 分配为源和目标。

> [!NOTE]
> 你可以使用[第三人称模板项目](https://dev.epicgames.com/documentation/404)访问Manny和Quinn骨骼网格体角色，以及 `IK_Mannequin` IK Rig资产。

```
 # 加载源和目标IK Rig。 source_ik_rig = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/IK_Mannequin', outer = None) target_ik_rig = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/IK_Mannequin', outer = None) # 分配源和目标IK Rig。 rtg_controller.set_ik_rig(unreal.RetargetSourceOrTarget.SOURCE, source_ik_rig) rtg_controller.set_ik_rig(unreal.RetargetSourceOrTarget.TARGET, target_ik_rig) 
```

我们还可以获取源或目标IK Rig，这对于查询重定向链很有用。

```
 # 获取分配到IK重定向器资产的源和目标IK Rig。 rtg_controller.get_ik_rig(unreal.RetargetSourceOrTarget.SOURCE) rtg_controller.get_ik_rig(unreal.RetargetSourceOrTarget.TARGET) 
```

我们不仅可以设置源/目标IK Rig，还可以提供对源/目标预览网格体的覆盖。这将覆盖IK Rig提供的默认预览网格体。

```
 # 加载骨骼网格体。 source_skel_mesh = unreal.load_asset(name = '/Game/Characters/Mannequins/Meshes/SKM_Manny_Simple.SKM_Manny_Simple') target_skel_mesh = unreal.load_asset(name = '/Game/Characters/Mannequins/Meshes/SKM_Quinn_Simple.SKM_Quinn_Simple') # 分配源和目标骨骼网格体。 rtg_controller.set_preview_mesh(unreal.RetargetSourceOrTarget.SOURCE, source_skel_mesh) rtg_controller.set_preview_mesh(unreal.RetargetSourceOrTarget.TARGET, target_skel_mesh) # 获取分配到IK重定向器资产的源和目标骨骼网格体。 rtg_controller.get_preview_mesh(unreal.RetargetSourceOrTarget.SOURCE) rtg_controller.get_preview_mesh(unreal.RetargetSourceOrTarget.TARGET) 
```

### 编辑和查询重定向链映射

类似于编辑器，你可以使用Python执行重定向链的自动映射。你还可以访问自动映射选项，例如 **模糊字符串匹配** 、 **精确字符串匹配** 或完全 **清除映射** 。

```
 # 使用模糊字符串匹配映射链，这将强制重新映射。 rtg_controller.auto_map_chains(unreal.AutoMapChainType.FUZZY, True) # 使用精确字符串匹配映射链，这将强制重新映射。 rtg_controller.auto_map_chains(unreal.AutoMapChainType.EXACT, True) # 清除所有映射。 rtg_controller.auto_map_chains(unreal.AutoMapChainType.CLEAR, True) 
```

如果你不想执行自动映射，可以获取或设置每个目标链的映射。

```
 # 获取映射到给定目标链的源链。 source_mapped_chain_name = rtg_controller.get_source_chain("Spine") # 设置目标映射到的源链，在Python脚本中格式为("Source", "Target")。 rtg_controller.set_source_chain("Spine", "Spine") 
```

### 添加、编辑和查询重定向姿势

重定向姿势用于确定基础姿势来供源或目标重定向。如果目标角色位于不同于源的姿势中，或者如果源需要朝向恰当的前面轴，这会很有用。

你可以使用以下命令查询源或目标的重定向姿势：

```
 # 获取目标的所有重定向姿势。 all_target_poses = rtg_controller.get_retarget_poses(unreal.RetargetSourceOrTarget.TARGET) 
```

你可以创建、复制、重命名或删除重定向姿势，前提是你提供重定向姿势的名称并指定它是源还是目标。

```
 # 创建新重定向姿势。 rtg_controller.create_retarget_pose("my_new_pose", unreal.RetargetSourceOrTarget.TARGET) # 复制新姿势。 rtg_controller.duplicate_retarget_pose("my_new_pose", "duplicated_pose", unreal.RetargetSourceOrTarget.TARGET) # 重命名复制的姿势。 rtg_controller.rename_retarget_pose("duplicated_pose", "renamed_pose", unreal.RetargetSourceOrTarget.TARGET) # 删除复制的姿势。 rtg_controller.remove_retarget_pose("renamed_pose", unreal.RetargetSourceOrTarget.TARGET) 
```

然后，你可以将当前重定向姿势设置为新创建的姿势。

```
 rtg_controller.set_current_retarget_pose("my_new_pose", unreal.RetargetSourceOrTarget.TARGET) print(rtg_controller.get_current_retarget_pose_name(unreal.RetargetSourceOrTarget.TARGET)) 
```

现在你有了新的重定向姿势，可以使用Python脚本编辑该姿势。重定向根骨骼是唯一可以在重定向姿势中有平移和旋转平移增量值的骨骼。对于其他每个骨骼，重定向姿势仅存储相对旋转平移增量值。

例如，目标的重定向根骨骼需要抬高并翻转，以处于正确方向。以下Python脚本会将其向上抬高15个单位并旋转90度：

```
 # 创建平移的向量。 translation_offset = unreal.Vector() translation_offset.z = 15 # 设置重定向根骨骼的平移偏移。 rtg_controller.set_root_offset_in_retarget_pose(translation_offset, unreal.RetargetSourceOrTarget.TARGET) print(rtg_controller.get_root_offset_in_retarget_pose(unreal.RetargetSourceOrTarget.TARGET)) # 创建旋转的旋转体。 rotation_offset = unreal.Rotator() rotation_offset.roll = 90 # 设置重定向根骨骼的旋转偏移，它适用于所有骨骼，并需要定义的骨骼名称。 rtg_controller.set_rotation_offset_for_retarget_pose_bone("pelvis", rotation_offset.quaternion(), unreal.RetargetSourceOrTarget.TARGET) print(rtg_controller.get_rotation_offset_for_retarget_pose_bone("pelvis", unreal.RetargetSourceOrTarget.TARGET)) 
```

最后，你可以将骨骼列表重置回原始变换。

```
 rtg_controller.reset_retarget_pose("my_new_pose", ["pelvis"], unreal.RetargetSourceOrTarget.TARGET) 
```

### 自动对齐重定向姿势

```
 # 自动对齐所有骨骼并应用到目标重定向姿势。rtg_controller.auto_align_all_bones(unreal.RetargetSourceOrTarget.TARGET)  # 定义一个骨骼列表，将它们对齐到源，并应用到目标重定向姿势。bones = ["spine_01", "spine_02", "spine_03"]rtg_controller.auto_align_bones(bones, unreal.RetargetAutoAlignMethod.CHAIN_TO_CHAIN, unreal.RetargetSourceOrTarget.TARGET) 
```

### 编辑和查询全局设置

在重定向器中，全局设置是你可以编辑步幅调整属性或重定向的不同阶段（例如重定向根骨骼、FK和IK）的地方。你可以使用以下Python脚本查询和编辑这些阶段：

```
 # 获取全局设置，更改IK并设置全局设置。 global_settings = rtg_controller.get_global_settings() global_settings.set_editor_property("enable_ik", False) rtg_controller.set_global_settings(global_settings) 
```

### 编辑和查询根设置

在重定向器中，根设置是你编辑与重定向根骨骼相关的属性的地方。这会允许臀部的平移或旋转偏移，缩放垂直或水平运动，或IK目标在垂直或水平平面中受影响的方式。你可以使用以下Python脚本查询和编辑这些属性：

```
 # 获取根设置，将臀部抬高10个单位，设置根设置。 root_settings = rtg_controller.get_root_settings() root_settings.translation_offset = unreal.Vector(0,0,10) rtg_controller.set_root_settings(root_settings) 
```

### 编辑和查询链设置

在重定向器中，链设置是你编辑与每个重定向链相关的属性的地方。对于FK链，这是你更改旋转重定向模式的地方，或者对于IK链，这是你编辑是否想要IK目标固定到源位置、向IK添加偏移或垂直缩放IK的地方。你可以使用以下Python脚本查询和编辑这些属性：

```
 # 专门获取左腿链。 left_leg_chain_settings = rtg_controller.get_retarget_chain_settings("LeftLeg") # 或者，你可以通过从所有链查询并将一行用于循环条件来获取链。 chains = rtg_controller.get_all_chain_settings() left_leg_chain_settings = next((chain.settings for chain in chains if chain.source_chain == "LeftLeg"), None) # 编辑FK设置。 left_leg_chain_settings.fk.rotation_mode = unreal.RetargetRotationMode.INTERPOLATED left_leg_chain_settings.fk.pole_vector_matching = 1 # 编辑IK设置。 left_leg_chain_settings.ik.blend_to_source = 1 left_leg_chain_settings.ik.static_offset = unreal.Vector(0,5,0) # 编辑快速栽植设置。 left_leg_chain_settings.speed_planting.enable_speed_planting = True left_leg_chain_settings.speed_planting.speed_curve_name = "ball_l_translation_speed_XYZ" # 设置重定向链设置。 rtg_controller.set_retarget_chain_settings("LeftLeg", left_leg_chain_settings) 
```

### 重定向后阶段

```
 # 加载RTG_Mannequin资产 rtg = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/RTG_Mannequin') rtg_controller = unreal.IKRetargeterController.get_controller(rtg) # 获取操作符数量 num_ops = rtg_controller.get_num_retarget_ops() # 获取第一个操作符对象 first_op = rtg_controller.get_retarget_op_at_index(0) # 获取第一个op索引 first_op_index = rtg_controller.get_index_of_retarget_op(first_op) # 查看是否启用了操作符 is_op_enabled = rtg_controller.get_retarget_op_enabled(first_op_index) # 将操作符设置为禁用 rtg_controller.set_retarget_op_enabled(first_op_index, False) # 检查结果 is_op_enabled = rtg_controller.get_retarget_op_enabled(first_op_index) rtg_controller.set_retarget_op_enabled(first_op_index, True) # 在堆栈中移动操作符 rtg_controller.move_retarget_op_in_stack(first_op_index, 1) first_op_index = rtg_controller.get_index_of_retarget_op(first_op) # 添加曲线重映射操作符 added_curve_op_index = rtg_controller.add_retarget_op(unreal.CurveRemapOp) added_curve_op = rtg_controller.get_retarget_op_at_index(added_curve_op_index) added_curve_op.set_editor_property("copy_all_source_curves", True) curve_pair_element = unreal.CurveRemapPair() curve_pair_element.set_editor_property("source_curve", "source") curve_pair_element.set_editor_property("target_curve", "target") added_curve_op.set_editor_property("curves_to_remap", [curve_pair_element]) # 移除操作符 rtg_controller.remove_retarget_op(added_curve_op_index) # 添加引脚骨骼操作符 added_pin_bone_op_index = rtg_controller.add_retarget_op(unreal.PinBoneOp) added_pin_bone_op = rtg_controller.get_retarget_op_at_index(added_pin_bone_op_index) translate_vector = unreal.Vector() translate_vector.x = 120 translate_vector.y = 120 translate_vector.z = 120 offset_transform = unreal.Transform() offset_transform.translation = translate_vector bone_pair_element = unreal.PinBoneData() bone_pair_element.set_editor_property("bone_to_pin", "ik_foot_root") bone_pair_element.set_editor_property("bone_to_pin_to", "root") added_pin_bone_op.set_editor_property("pin_type", unreal.PinBoneType.ROTATE_ONLY) added_pin_bone_op.set_editor_property("pin_to", unreal.RetargetSourceOrTarget.SOURCE) added_pin_bone_op.set_editor_property("maintain_offset", False) added_pin_bone_op.set_editor_property("local_offset", offset_transform) added_pin_bone_op.set_editor_property("global_offset", offset_transform) added_pin_bone_op.set_editor_property("bones_to_pin", [bone_pair_element]) # 移除op rtg_controller.remove_retarget_op(added_pin_bone_op_index) # 添加根运动生成器操作符 - 自动填充骨骼名称 added_rm_gen_op_index = rtg_controller.add_retarget_op(unreal.RootMotionGeneratorOp) added_rm_gen_op = rtg_controller.get_retarget_op_at_index(added_rm_gen_op_index) translate_vector = unreal.Vector() translate_vector.x = 120 translate_vector.y = 120 translate_vector.z = 120 offset_transform = unreal.Transform() offset_transform.translation = translate_vector added_rm_gen_op.set_editor_property("global_offset", offset_transform) added_rm_gen_op.set_editor_property("maintain_offset_from_pelvis", False) added_rm_gen_op.set_editor_property("propagate_to_non_retargeted_children", True) added_rm_gen_op.set_editor_property("root_height_source", unreal.RootMotionHeightSource.SNAP_TO_GROUND) added_rm_gen_op.set_editor_property("root_motion_source", unreal.RootMotionSource.GENERATE_FROM_TARGET_PELVIS) added_rm_gen_op.set_editor_property("rotate_with_pelvis", False) # 移除操作符rtg_controller.remove_retarget_op(added_rm_gen_op_index) 
```

### 复制和重定向的批量重定向动画

要批处理你的重定向动画，你可以在Python中运行与复制和重定向相同的命令。

```
 # 使用资产子系统获取资产数据。 asset_subsystem = unreal.get_editor_subsystem(unreal.EditorAssetSubsystem) # 获取资产数据列表，你可以将其用于动画序列、动画蓝图、姿势资产等。 assets_to_retarget = [         asset_subsystem.find_asset_data("/Game/Characters/Mannequins/Animations/Manny/MM_Fall_Loop"),         asset_subsystem.find_asset_data("/Game/Characters/Mannequins/Animations/Manny/MM_Idle")] retarget_asset = unreal.load_asset(name = '/Game/Characters/Mannequins/Rigs/RTG_Mannequin') source_mesh = None # will use mesh from source ik rig target_mesh = None # will use mesh from target ik rig batch_op = unreal.IKRetargetBatchOperation.duplicate_and_retarget(                                                 assets_to_retarget,                                                 source_mesh,                                                 target_mesh,                                                 retarget_asset,                                                 search = "",                                                 replace = "",                                                 prefix = "",                                                 suffix = "",                                                 remap_referenced_assets = True) 
```

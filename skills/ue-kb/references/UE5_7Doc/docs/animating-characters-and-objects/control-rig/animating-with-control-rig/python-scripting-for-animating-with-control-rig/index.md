---
title: "控制绑定动画Python脚本编写"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/python-scripting-for-animating-with-control-rig-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "控制绑定", "使用控制绑定实现动画效果", "控制绑定动画Python脚本编写"]
---

# 控制绑定动画Python脚本编写

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 控制绑定 / 使用控制绑定实现动画效果 / 控制绑定动画Python脚本编写

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/python-scripting-for-animating-with-control-rig-in-unreal-engine

[Python脚本](https://dev.epicgames.com/documentation/404)可以用于自动化并控制在 **Sequencer** 中 **控制绑定** 动画制作的各个部分。该文档介绍通过控制绑定、[动画模式](../animation-editor-mode/index.md)以及其它流程制作动画时使用Python的主要方式。

#### 先决条件

- 你对于

  虚幻引擎Python脚本编写

  和

  Sequencer脚本编写

  有一定经验。
- 你了解如何创建和使用

  控制绑定

  。

## 创建控制绑定轨道

创建控制绑定轨道与通常[在Sequencer中创建轨道](../../../cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/python-scripting-in-sequencer/index.md#%E5%88%9B%E5%BB%BA%E8%BD%A8%E9%81%93%E5%92%8C%E5%88%86%E6%AE%B5)略有不同。控制绑定轨道需要创建一个定义的控制绑定g类。要创建控制绑定轨道，使用以下指令：

```
# 获取编辑器世界editor_system = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_system.get_editor_world()  # 获取绑定类rig_class = unreal.FKControlRig.static_class()  # 通过关卡序列和Actor绑定，我们可以从类中找到或者创建控制绑定轨道rig_track = unreal.ControlRigSequencerLibrary.find_or_create_control_rig_track(world, level_sequence, rig_class, actor_binding)  # 从默认网格体中获取actor_bindinglevel_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_focused_level_sequence()skeletal_mesh_component = rig.get_preview_mesh()actor_binding = level_sequence.add_spawnable_from_instance(skeletal_mesh_component) # 从骨骼网格体路径中获取actor_bindingskeletal_mesh_component = unreal.load_asset(skeletal_mesh_path)actor_binding = level_sequence.add_spawnable_from_instance(skeletal_mesh_component)
```

## 创建控制绑定轨道

与FK控制绑定轨道一样，你需要获得特定的控制绑定类：

```
# 获取编辑器世界world = unreal.EditorLevelLibrary.get_editor_world() # 获取控制绑定资产rig = unreal.load_asset("/Game/Animation/ControlRig/Mannequin_ControlRig") # 获取绑定类rig_class = rig.get_control_rig_class() # 通过关卡序列和Actor绑定，我们可以从类中找到或者创建控制绑定轨道rig_track = unreal.ControlRigSequencerLibrary.find_or_create_control_rig_track(world,level_sequence, rig_class, actor_binding)
```

## 分层控制绑定

### 创建分层控制绑定轨道

创建分层控制绑定轨道的方法与添加普通控制绑定轨道轨道基本相同，只是在 `find_or_create_control_rig_track` 中使用了 `is_layered` 关键字参数。

```
# 获取编辑器世界editor_system = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_system.get_editor_world()  # 获取控制绑定资产rig = unreal.load_asset("/Game/Animation/ControlRig/Mannequin_ControlRig")  # 获取绑定类rig_class = rig.get_control_rig_class()  # 通过关卡序列和Actor绑定，我们可以从类中找到或者创建控制绑定轨道rig_track = unreal.ControlRigSequencerLibrary.find_or_create_control_rig_track(world, level_sequence, rig_class, actor_binding, is_layered_control_rig = True)
```

### 检查控制绑定是否分层

要确定控制绑定是否分层，可以在 `ControlRigSequencerBindingProxy` 实例中的控制绑定对象里进行检查。

```
# 获取Sequencer中的首个控制绑定，然后获取绑定对象rig_proxy = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence)[0]rig = rig_proxy.control_rig  print(unreal.ControlRigSequencerLibrary.is_layered_control_rig(rig))
```

### 变更绑定求值顺序

你可以将多个控制绑定分层，并更改优先顺序。分层控制绑定的运行方式与带子序列的层级偏差类似，都是先按最高数字进行求值。例如，如果 `FKControlRig` 设置为 `100` ，而 `CR_Mannequin_Body` 设置为 `99` ，那么 `FKControlRig` 将先求值。

```
# 在Sequencer内获取绑定rigs = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence)  # 循环遍历所有绑定for rig in rigs:      rig_track = rig.track    rig_obj = rig.control_rig      # 获取并设置优先顺序print(unreal.ControlRigSequencerLibrary.get_control_rig_priority_order(rig_track))unreal.ControlRigSequencerLibrary.set_control_rig_priority_order(rig_track, 200)
```

### 更改分层模式

你还可以在绑定轨道上更改其模式：

```
unreal.ControlRigSequencerLibrary.set_control_rig_layered_mode(rig_track, True)
```

## 屏蔽分段

对于只想显示部分控制点的分段，你可以在Python中设置屏蔽：

```
# 获取控制绑定轨道和分段至关键帧ls = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()rig = unreal.ControlRigSequencerLibrary.get_control_rigs(ls)[0]rig_track = rig.trackkeyed_section = rig_track.get_section_to_key()  # 隐藏关键帧分段上的这些具体控制点ctrls = ["thigh_l_fk_ctrl", "calf_l_fk_ctrl", "foot_l_fk_ctrl", "ball_l_fk_ctrl"]unreal.ControlRigSequencerLibrary.set_controls_mask(keyed_section, ctrls, False)  # 显示所有控制点unreal.ControlRigSequencerLibrary.show_all_controls(keyed_section)
```

## 动画控制

以下示例解释了编辑动画控制的几种方式。

### 控制选择

以下指令可以用于选择控制并且检索控制选择：

```
# 获取Sequncer中的控制绑定，返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 获取第一个代理，假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 选择一个指定的控制rig.select_control("body_ctrl") # 获取当前控制选择selected_controls = rig.current_control_selection()print(selected_controls) # 清空控制选择rig.clear_control_selection()
```

### 获取并设置控制数值

可以使用以下指令在任意帧数从任何控制中获取指定的数值：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 获取第0帧frame_num = unreal.FrameNumber(0) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 获取本地控制数值，每个控制类型都会有其自己的功能transform = unreal.ControlRigSequencerLibrary.get_local_control_rig_transform(level_sequence, rig, "body_ctrl", frame_num)bool = unreal.ControlRigSequencerLibrary.get_local_control_rig_bool(level_sequence, rig, "twist_ctrl_vis", frame_num) print(transform)print(bool)
```

你还可以通过以下指令在任意帧数给任意控制设置指定的数值：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy我们可以获取ControlRig对象rig = rig_proxy.control_rig # 获取当前时间current_time = unreal.LevelSequenceEditorBlueprintLibrary.get_current_time() # 将当前时间转换为帧数（FrameNumber）对象current_frame = unreal.FrameNumber(current_time) # 为控制创建适当的数值对象transform_value = unreal.Transform(location=[0, 10, 20], rotation=[0,30,0], scale=[1,1,1]) bool_value = True # 设置本地控制数值，每个控制类型都会有其自己的功能# 每个类型的功能还会有一个set_key标记，默认为Trueunreal.ControlRigSequencerLibrary.set_local_control_rig_transform(level_sequence, rig, "body_ctrl", frame_num, transform_value)unreal.ControlRigSequencerLibrary.set_local_control_rig_bool(level_sequence, rig, "twist_ctrl_vis", frame_num, bool_value, set_key = False)
```

## 关键帧

### 查询所选关键帧

```
# 从选定的关键帧中获取通道 - 假设有选择的话keyed_channels = unreal.LevelSequenceEditorBlueprintLibrary.get_channels_with_selected_keys()  # 获取所选关键帧selected_keys = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_keys(keyed_channels[0])  # 获取通道对象channel_obj = keyed_channels[0].section.get_channel(keyed_channels[0].channel_name)  # 将关键帧索引转换为关键帧对象key_objs = channel_obj.get_keys_by_index(selected_keys)  # 打印所选关键帧的所有时间值for key_obj in key_objs: print(key_obj.get_time().frame_number.value)
```

### 编辑关键帧选择

下方示例假设有一个使用人体模型/MH控制绑定的关卡序列，其关键帧位于 `hand_l_fk_ctrl` 上。

```
ls = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()start_frame = ls.get_playback_start()end_frame = ls.get_playback_end()  # 获取控制绑定rig = unreal.ControlRigSequencerLibrary.get_control_rigs(ls)[0]rig_track = rig.trackkeyed_section = rig_track.get_section_to_key()  # 通过提供简单的通道名称获取通道代理sc = unreal.SequencerChannelProxy()sc.section = keyed_sectionsc.channel_name = 'hand_l_fk_ctrl.Location.X'  # 获取通道对象并获取所有关键帧对象channel_obj = keyed_section.get_channel('hand_l_fk_ctrl.Location.X')keys = channel_obj.get_keys()  # 供关键帧选择的空数组timed_keys = []  # 循环遍历所有关键帧for key in keys:      # 获取关键帧时间    key_time = key.get_time().frame_number.value      # 检查关键帧时间是否在起始帧之后和结束帧之前    if key_time >= start_frame+1 and key_time <= end_frame-1:          # 添加关键帧至数组        timed_keys.append(keys.index(key))  # 选择关键帧unreal.LevelSequenceEditorBlueprintLibrary.select_keys(sc, timed_keys)
```

## 曲线编辑器

```
# 获取曲线编辑器ses = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem)curve_editor = ses.get_curve_editor()if not curve_editor.is_curve_editor_open(): curve_editor.open_curve_editor()  # 获取所选关键帧和通道keyed_channels = curve_editor.get_channels_with_selected_keys()selected_keys = curve_editor.get_selected_keys(keyed_channels[0])curve_editor.empty_selection()  # 重新选择所有关键帧curve_editor.select_keys(selected_keys)  # 获取通道对象channel_obj = keyed_channels[0].section.get_channel(keyed_channels[0].channel_name)  # 将关键帧索引转换为关键帧对象key_objs = channel_obj.get_keys_by_index(selected_keys)  # 打印所选关键帧的所有时间for key_obj in key_objs: print(key_obj.get_time())  # 关闭曲线编辑器curve_editor.close_curve_editor()
```

## 将动画序列加载到控制绑定分段

```
level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_focused_level_sequence()rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence)rig_proxy = rig_proxies[0]sequencer_binding_proxy = rig_proxy.proxy  # 要插入动画的帧start_frame = unreal.FrameNumber(0)  # 从控制绑定采集影片场景分段cr_tracks = sequencer_binding_proxy.find_tracks_by_type(unreal.MovieSceneControlRigParameterTrack)cr_movie_scene_section = cr_tracks[0].get_section_to_key()  # 引入动画以应用anim_sequence = "/Game/Characters/Mannequins/Animations/Manny/MM_Walk_Fwd"anim_sequence = unreal.load_asset(anim_sequence)  # 获取骨骼网格体组件seq_bindings = level_sequence.get_bindings()playback_range = level_sequence.get_playback_range()editor_system = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_system.get_editor_world()bound_objects = unreal.SequencerTools.get_bound_objects(world, level_sequence, seq_bindings, playback_range)# 注意：假设第一个绑定对象具有骨骼网格体skel_mesh_comp = bound_objects[0].bound_objects[0].skeletal_mesh_component  # 将动画载入控制绑定（在后台使用逆向求解图)unreal.ControlRigSequencerLibrary.load_anim_sequence_into_control_rig_section(cr_movie_scene_section, anim_sequence, skel_mesh_comp, start_frame, reset_controls = True)      
```

## 动画模式

[动画模式工具](../animation-editor-mode/index.md#%E5%8A%A8%E7%94%BB%E6%A8%A1%E5%BC%8F%E5%B7%A5%E5%85%B7)也可以受Python脚本影响。以下是一些示例。

### Tween工具

以下指令可以用于[Tween工具](../animation-editor-mode/index.md#tweens%E5%B7%A5%E5%85%B7):

```
# 将tween数值设为-1 - 1之间# -1会渲染到上一帧# 1会渲染到下一帧tween_value = -1 unreal.ControlRigSequencerLibrary.tween_control_rig(level_sequence, rig, tween_value)
```

### 吸附工具

以下指令可以用于[吸附工具](../animation-editor-mode/index.md#%E5%90%B8%E9%99%84%E5%B7%A5%E5%85%B7)。如果驱动对象动画化，那么驱动对象必须添加至活跃序列。

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy我们可以获取ControlRig对象rig = rig_proxy.control_rig # 获取编辑器Actor子系统来添加Actoreditor_actor_subsystem = unreal.get_editor_subsystem(unreal.EditorActorSubsystem) # 向编辑器世界中添加一个立方体并设置位置cube_mesh = unreal.load_asset("/Engine/BasicShapes/Cube")cube_location = unreal.Vector(0, 10, 20)cube_actor = editor_actor_subsystem.spawn_actor_from_object(cube_mesh, cube_location) # 设置起始和结束帧范围start_frame = unreal.FrameNumber(0)end_frame = unreal.FrameNumber(5) # 为父级和子级创建ControlRigSnapperSelection对象parent = unreal.ControlRigSnapperSelection()children = unreal.ControlRigSnapperSelection() # 创建ActorForWorldTransforms对象# 将立方体Actor设为父级parent_actor = unreal.ActorForWorldTransforms()parent_actor.actor = cube_actor # 创建ControlRigForWorldTransforms对象# 设置到合适的控制绑定，将左手控制设为控制# 这里可以有多个控制名称child_control_rig = unreal.ControlRigForWorldTransforms()child_control_rig.control_rig = rigchild_control_rig.control_names = ["hand_l_ctrl"] # 使用ActorForWorldTransforms对象，将其设为父级ControlRigSnapperSelection# 使用ControlRigForWorldTransforms对象，将其设为子级ControlRigSnapperSelectionparent.actors = [parent_actor]children.control_rigs = [child_control_rig] # 创建并设置吸附设置snap_settings = unreal.ControlRigSnapSettings()snap_settings.keep_offset = Falsesnap_settings.snap_position = Truesnap_settings.snap_rotation = Truesnap_settings.snap_scale = False # 从第0-5帧将左手控制吸附到立方体上unreal.ControlRigSequencerLibrary.snap_control_rig(level_sequence, start_frame, end_frame, children, parent, snap_settings)
```

### 空间切换

以下指令和示例可以用于[空间切换](../re-parent-control-rig-controls-in-real-time/index.md).

要开始空间切换，需要创建空间关键帧。可以将控制的空间设置为其默认父级、世界空间或者任意指定帧数的另一个控制。

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 在第0帧将左手控制的空间设置为世界空间control_name = "hand_l_ctrl"space = unreal.ControlRigSequencerLibrary.get_world_space_reference_key()time = unreal.FrameNumber(value = 0) unreal.ControlRigSequencerLibrary.set_control_rig_space(level_sequence, rig, control_name, space, time) # 然后，在第30帧将空间切换设置到头部space = unreal.RigElementKey(type = unreal.RigElementType.CONTROL, name = "head_ctrl")time = unreal.FrameNumber(value = 30) unreal.ControlRigSequencerLibrary.set_control_rig_space(level_sequence, rig, control_name, space, time) # 最后，在第60帧将空间切换设置到其默认父级space = unreal.ControlRigSequencerLibrary.get_default_parent_key()time = unreal.FrameNumber(value = 60) unreal.ControlRigSequencerLibrary.set_control_rig_space(level_sequence, rig, control_name, space, time)
```

空间关键帧创建好后，可以通过以下指令将它们移动到任意帧数：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 从设置空间关键帧示例中假设我们的空间关键帧位于第0、30和60帧的# 左手控制上。我们将空间关键帧移动到第30和45帧control_name = "hand_l_ctrl"old_time = unreal.FrameNumber(value = 30)new_time = unreal.FrameNumber(value = 45) unreal.ControlRigSequencerLibrary.move_control_rig_space(level_sequence, rig, control_name, old_time, new_time)
```

可以使用以下指令来删除空间关键帧：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 从移动空间关键帧示例中假设我们的空间关键帧位于第0、45和60帧的# 左手控制上。现在我们移除第45帧的空间关键帧control_name = "hand_l_ctrl"time = unreal.FrameNumber(value = 45) unreal.ControlRigSequencerLibrary.delete_control_rig_space(level_sequence, rig, control_name, time)
```

可以使用以下指令将最终动画烘焙到指定的空间：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig # 获取所有选中的绑定控制control_names = rig.current_control_selection() # 从关卡序列中获取起始和结束帧，为烘焙设置创建帧数（FrameNumber）对象start_frame_num = level_sequence.get_playback_start()end_frame_num = level_sequence.get_playback_end() start_frame = unreal.FrameNumber(value = start_frame_num)end_frame = unreal.FrameNumber(value = end_frame_num) # 为空间设置烘焙设置，我们将要烘焙到默认父级空间 space_bake_settings = unreal.RigSpacePickerBakeSettings()space_bake_settings.target_space = unreal.ControlRigSequencerLibrary.get_default_parent_key()space_bake_settings.start_frame = start_framespace_bake_settings.end_frame = end_framespace_bake_settings.reduce_keys = Falsespace_bake_settings.tolerance = 0 unreal.ControlRigSequencerLibrary.bake_control_rig_space(level_sequence, rig, control_names, space_bake_settings)
```

### 动画模式设置

[动画模式设置](#%E5%8A%A8%E7%94%BB%E6%A8%A1%E5%BC%8F%E8%AE%BE%E7%BD%AE)可以通过Python脚本来编辑。每个属性使用以下术语：

| 名称 | 描述 |
| --- | --- |
| **bDisplayHierarchy** | 在角色上绘制骨骼。 |
| **bDisplayNulls** | 在角色上绘制Null。 |
| **bHideManipulators** | 在视口中隐藏所有控制。如果启用了 **Display Hierarchy** 或者 **Display Nulls** ，那么也会隐藏骨骼和Null。 |
| **bCoordSystemPerWidgetMode** | 在视口中改变小工具模式时恢复坐标空间。 |
| **bOnlySelectRigControls** | 启用后，视口中将仅能选择控制绑定控制。所有其余物体，包括角色，都不能选择。 |
| **bLocalTransformsInEachLocalSpace** | 启用后，如果你的转换小工具设为本地坐标，将会把每个选中的控制相对于它们的本地转换空间进行转换。 |
| **GizmoScale** | 放大或者缩小小工具尺寸。 |

可以使用以下指令：

```
# 载入模式设置类并获取默认对象ControlRigSettingsClass = unreal.load_class(None, '/Script/ControlRigEditor.ControlRigEditModeSettings')ControlRigSettings = unreal.get_default_object(ControlRigSettingsClass) # 打印输出检索的数据print(ControlRigSettings.get_editor_property('bDisplayHierarchy'))print(ControlRigSettings.get_editor_property('bDisplayNulls'))print(ControlRigSettings.get_editor_property(GizmoScale)) # 设置属性ControlRigSettings.set_editor_property('bDisplayHierarchy', True)ControlRigSettings.set_editor_property('bDisplayNulls', True)ControlRigSettings.set_editor_property('GizmoScale', 5)
```

## 约束

约束用于创建两个对象之间的关系。这对于动画创作非常有用。你可以将约束添加到动画和非动画场景中。

### 使摄像机视角受限于不使用Sequencer的立方体

```
import unreal  # 创建摄像机camera_location = unreal.Vector(0.0,0.0,200.0)camera_actor = unreal.EditorLevelLibrary().spawn_actor_from_class(unreal.CineCameraActor, camera_location)camera_actor.set_actor_label('CineCameraActor')  # 创建立方体obj = unreal.load_asset("/Engine/BasicShapes/Cube")cube_location = unreal.Vector(400.0,0.0,200.0)cube_actor = unreal.EditorLevelLibrary().spawn_actor_from_object(obj, cube_location)cube_actor.set_actor_label('CubeActor')  # 获取编辑器世界world = unreal.EditorLevelLibrary().get_editor_world()  # 创建约束库constraints_lib = unreal.ConstraintsScriptingLibrary()  # 创建摄像机的子控点child_handle = constraints_lib.create_transformable_component_handle(world, camera_actor.root_component, "")  # 创建立方体的父控点parent_handle = constraints_lib.create_transformable_component_handle(world, cube_actor.root_component, "")  # 创建并添加约束（注意，如果需要，这将创建约束管理器）look_at_constraint = constraints_lib.create_from_type(world, unreal.TransformConstraintType.LOOK_AT)constraints_lib.add_constraint(world, parent_handle, child_handle, look_at_constraint, True)
```

### 使控制绑定控制点父级受限于使用Sequencer的立方体

```
# 获取当前关卡序列level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()  # 在Sequencer内获取控制绑定 - 返回ControlRigSequencerBindingProxy列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy，我们可以获取ControlRig对象rig = rig_proxy.control_rig  # 获取首个所选的控制点selected_ctrl = rig.current_control_selection()[0]  # 创建将驱动控制点的立方体obj = unreal.load_asset("/Engine/BasicShapes/Cube")cube_location = unreal.Vector(400.0,0.0,200.0)cube_actor = unreal.EditorLevelLibrary().spawn_actor_from_object(obj, cube_location)  # 获取世界world = unreal.EditorLevelLibrary().get_editor_world()  # 创建约束的脚本编写库对象constraints_lib = unreal.ConstraintsScriptingLibrary()  # 为控制绑定控制点创建子控点child_handle = rig.create_transformable_control_handle(selected_ctrl)  # 为立方体创建父控点parent_handle = constraints_lib.create_transformable_component_handle(world, cube_actor.root_component, "")  # 创建父约束对象parent_constraint = constraints_lib.create_from_type(world, unreal.TransformConstraintType.PARENT)  # 添加带有控点的约束，并关闭维持偏移constraints_lib.add_constraint(world, parent_handle, child_handle, parent_constraint, False)
```

## 烘焙和合并

### 烘焙到控制绑定

如果Sequencer中Actor上已经有了一个动画序列，那么可以通过将当前动画烘焙到控制绑定来创建控制绑定轨道。请使用以下指令：

```
# 获取当前编辑器关卡editor_system = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_system.get_editor_world() # 获取动画序列导出选项anim_seq_export_options = unreal.AnimSeqExportOption()anim_seq_export_options.export_transforms = Trueanim_seq_export_options.export_curves = True # 获取关键帧容忍数和关键帧减少状态tolerance = 0.01reduce_keys = False # 烘焙到控制绑定unreal.ControlRigSequencerLibrary.bake_to_control_rig(world, level_sequence, rig_class, anim_seq_export_options, False, tolerance, actor_binding)
```

### 烘焙到动画序列

控制绑定动画完成后，可以将动画作为动画序列导出，以便在虚幻引擎的其它地方使用。请使用以下指令：

```
# 获取当前关卡序列level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence() # 获取名称为SK Mannequin的SkeletaMeshActor绑定# 这是将Mannequin_ControlRig拖进关卡编辑器时的默认名称binding = level_sequence.find_binding_by_name("SK Mannequin") # 抓取关卡编辑器世界editor_subsystem = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_subsystem.get_editor_world() # 创建动画序列导出选项anim_seq_export_options = unreal.AnimSeqExportOption()anim_seq_export_options.export_transforms = Trueanim_seq_export_options.export_morph_targets = True # 获取资产工具# 创建空的动画序列 - /Game/Test_Animasset_tools = unreal.AssetToolsHelpers.get_asset_tools()anim_sequence = unreal.AssetTools.create_asset(asset_tools, asset_name = "Test_Anim", package_path = "/Game/", asset_class = unreal.AnimSequence, factory = unreal.AnimSequenceFactory()) # 烘焙至创建的动画序列unreal.SequencerTools.export_anim_sequence(world, level_sequence, anim_sequence, anim_seq_export_options, binding, False) # 如果我们想创建链接的动画序列，只需将最后一个参数改为Trueunreal.SequencerTools.export_anim_sequence(world, level_sequence, anim_sequence, anim_seq_export_options, binding, True)
```

### 合并动画层级

如果你在控制绑定轨道中使用多个分段和层级，你使用以下指令可以将它们烘焙合并至一个层级：

```
# 获取Sequncer中的控制绑定 - 返回一个包含ControlRigSequencerBindingProxy的列表rig_proxies = unreal.ControlRigSequencerLibrary.get_control_rigs(level_sequence) # 抓取第一个代理 - 假设是Mannequin_ControlRigrig_proxy = rig_proxies[0] # 从ControlRigSequencerBindingProxy我们可以获取MovieSceneControlRigParameterTrack对象# 通过该轨道，我们可以将轨道中的所有分段折叠为一个分段rig_track = rig_proxy.track unreal.ControlRigSequencerLibrary.collapse_control_rig_anim_layers(level_sequence, rig_track, key_reduce = False, tolerance = 0.001)
```

### 从关卡序列访问链接的动画序列

```
# 首先获取当前关卡序列level_sequence  = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()  # 然后检查是否有动画序列链接link_check = unreal.SequencerTools.get_anim_sequence_link_from_level_sequence(level_sequence)  # 如果有...if link_check:      # 获取链接    links = link_check.anim_sequence_links      # 循环遍历所有链接    for link in links:          # 获取软对象路径        anim_seq_soft_path = link.path_to_anim_sequence          # 解析它以获取资产        anim_seq = unreal.SystemLibrary.conv_soft_obj_path_to_soft_obj_ref(anim_seq_soft_path)
```

### 从动画序列访问链接的关卡序列

```
# 假设内容文件夹内存在链接的动画序列，名为Test_Animanim_seq = unreal.load_object("/Game/Test_Anim")  # 检查是否有链接link = unreal.SequencerTools.get_level_sequence_link_from_anim_sequence(anim_seq)  # 如果有...if link:      # 获取软对象路径    level_seq_soft_path = link.path_to_level_sequence      # 解析它以获取资产    level_seq = unreal.SystemLibrary.conv_soft_obj_path_to_soft_obj_ref(level_seq_soft_path) 
```

## FBX导入和导出

### FBX导出

```
# 获取关卡序列和绑定分段ls = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()rig = unreal.ControlRigSequencerLibrary.get_control_rigs(ls)[0]rig_track = rig.trackkeyed_section = rig_track.get_section_to_key()filename = "D:/test.fbx"  # 创建带有文件名的导出FBX设置export_fbx_settings = unreal.MovieSceneUserExportFBXControlRigSettings()export_fbx_settings.set_editor_property("ascii", True)export_fbx_settings.set_editor_property("export_file_name", filename)  # 导出控制绑定FBXunreal.ControlRigSequencerLibrary.export_fbx_from_control_rig_section(ls, keyed_section, export_fbx_settings)
```

### FBX导入

```
# 获取关卡序列、绑定轨道和分段以及编辑器世界ls = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence()rig = unreal.ControlRigSequencerLibrary.get_control_rigs(ls)[0]rig_track = rig.trackkeyed_section = rig_track.get_section_to_key()editor_system = unreal.get_editor_subsystem(unreal.UnrealEditorSubsystem)world = editor_system.get_editor_world()  # 为所选控制点创建列表，仅当import_onto_selected_controls设置为True时可行selected_ctrls = ["thigh_l_fk_ctrl", "calf_l_fk_ctrl", "foot_l_fk_ctrl", "ball_l_fk_ctrl"]  # 创建导入设置对象并分配设置和文件名import_fbx_settings = unreal.MovieSceneUserImportFBXControlRigSettings()import_fbx_settings.set_editor_property("import_onto_selected_controls", True)import_fbx_settings.set_editor_property("insert_animation", True)fbx_file = "D:/test.fbx"  # 导入控制绑定FBXunreal.ControlRigSequencerLibrary.import_fbx_to_control_rig_track(world, ls, rig_track, keyed_section, selected_ctrls, import_fbx_settings, fbx_file)
```

## 编辑动画模式窗口

在关卡编辑器和Sequencer中使用控制绑定制作动画时，会弹出动画模式窗口，其中包含动画师需要的工具和选项。这些选项也可以通过Python进行编辑。

动画模式窗口包括以下属性：

- bDisplayHierarchy

  : 为控制绑定中的每个控制点和骨骼绘制线和点
- bDisplayNulls

  : 为控制绑定中的每个null点绘制线和点
- bHideManipulators

  : 隐藏控制绑定中的所有控制点和显示
- bCoordSystemPerWidgetMode

  : 按平移、旋转和缩放模式保持本地/全局空间操纵器状态的选项
- bOnlySelectRigControls

  : 只允许通过视口选择控制绑定控制点
- bLocalTransformsInEachLocalSpace

  : 变换多个选定的控制点时，每个控制点都将在各自的本地空间中变换
- GizmoScale

  : 变更视口小工具操纵器的比例

```
# 加载模式设置类并获取默认对象ControlRigSettingsClass = unreal.load_class(None, '/Script/ControlRigEditor.ControlRigEditModeSettings') ControlRigSettings = unreal.get_default_object(ControlRigSettingsClass)   # 打印查询到的数据print(ControlRigSettings.get_editor_property('bDisplayHierarchy'))print(ControlRigSettings.get_editor_property('bDisplayNulls'))print(ControlRigSettings.get_editor_property(GizmoScale))  # 设置属性ControlRigSettings.set_editor_property('bDisplayHierarchy', True)ControlRigSettings.set_editor_property('bDisplayNulls', True)ControlRigSettings.set_editor_property('GizmoScale', 5)
```

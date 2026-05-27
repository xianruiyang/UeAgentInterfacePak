---
title: "Sequencer中的Python脚本"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/python-scripting-in-sequencer-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "Sequencer中的Python脚本"]
---

# Sequencer中的Python脚本

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / Sequencer中的Python脚本

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/python-scripting-in-sequencer-in-unreal-engine

[Python脚本](https://dev.epicgames.com/documentation/404)可以用于自动执行和控制 **Sequencer** 的各个部分。本文档概述了将Python用于Sequencer的主要方法，以及通用Sequencer脚本的示例。

#### 先决条件

- 你需要有[在虚幻引擎中编写Python脚本](https://dev.epicgames.com/documentation/404)的经验。
- 你需要了解如何使用[Sequencer](../../index.md)。

## Sequencer Python术语

Sequencer使用以下术语：

| Sequencer Python术语 | 说明 |
| --- | --- |
| **世界（World）** | 该对象表示Actor和组件可在其中存在并进行渲染的地图（也称为 **关卡（Level）** ）。 |
| **LevelSequence** | 该资产是过场动画场景的容器（也称为 **序列（Sequence）** ）。关卡序列包含的数据和轨道可以绑定到不同的对象以对其制作动画。 |
| **MovieSceneBindingProxy** | 该结构体定义关卡序列绑定的Actor或组件（也称为 **绑定（Binding）** ）。 |
| **可持有对象（Possessable）** | 该绑定类型描述关卡中存在的Actor或组件，其中关卡序列可以拥有任意可制作动画的属性。 |
| **可生成对象（Spawnable）** | 该绑定类型描述[仅当序列在播放时](https://dev.epicgames.com/documentation/404)存在的Actor或组件。 |
| **MovieSceneTrack** | 该对象位于 **绑定（Binding）** （MovieSceneBindingProxy）下，包含特定类型属性的编辑内容的所有分段。例如， **MovieScene3DTransformTrack > Actor / 组件变换（Component Transform）** 。 |
| **MovieSceneSection** | 该对象位于轨道（MovieSceneTrack）下，包含特定类型属性的所有通道、长度和参数。例如， **MovieScene3DTransformSection > 滚动前/后，完成状态时，活动/静音，叠加（Pre / Post Roll, When Finished State, Active/Muted, Additive）** 。 |
| **MovieSceneScriptingChannel** | 位于分段（MovieSceneSection）下的对象，包含对特定类型属性或子属性制作动画的所有关键帧。例如， **MovieSceneScriptingFloatChannel > Location.X** 。 |
| **MovieSceneScriptingKey** | 该对象表示特定类型通道中的关键帧。例如， **MovieSceneScriptingFloatKey** 。 |
| **FrameNumber** | 该结构体表示一个帧。 |
| **FrameRate** | 该结构体表示定义帧数和秒数的2个整数构成的分数。例如，30帧/秒写作：**30/1** 。 |

## 访问关卡序列

在Sequencer中编写Python脚本时的第一步是访问 **LevelSequence** ，这是你将与之交互的主要对象。有多种方式可以这样做，具体取决于你的情况。

### 简单访问

要访问 **内容浏览器（Content Browser）** 中存在的关卡序列，你可以使用以下示例脚本。序列不必已经打开或存在于当前关卡中。此脚本假定关卡序列资产位于根内容文件夹中。

```
		import unreal 		# 获取关卡序列资产 		level_sequence = unreal.load_asset("/Game/LevelSequenceName") 		# 然后在Sequencer中打开 		unreal.LevelSequenceEditorBlueprintLibrary.open_level_sequence(level_sequence) 
```

### 访问当前关卡序列

你还可以使用以下脚本访问当前打开的关卡序列：

```
		import unreal 		# 获取当前打开的关卡序列 		level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence() 
```

### 创建和打开关卡序列

你可以使用以下脚本创建新的关卡序列资产并将其打开：

```
		import unreal 		# 获取资产工具 		asset_tools = unreal.AssetToolsHelpers.get_asset_tools() 		# 在根内容文件夹中使用名称LevelSequenceName创建关卡序列 		level_sequence = unreal.AssetTools.create_asset(asset_tools, asset_name = "LevelSequenceName", package_path = "/Game/", asset_class = unreal.LevelSequence, factory = unreal.LevelSequenceFactoryNew()) 
```

### 获取和设置当前查看的关卡序列

你可以使用以下脚本获取或设置Sequencer中聚焦的关卡序列：

```
		# 获取聚焦的当前关卡序列 		focused_level_seqeunce = unreal.LevelSequenceEditorBlueprintLibrary.get_focused_level_sequence() 
```

你还可以提供要聚焦的子序列分段，从而聚焦特定子序列：

```
		# 获取第一个子序列轨道并从关卡序列获取第一个分段 		sub_sequence_track = level_sequence.find_tracks_by_type(unreal.MovieSceneSubTrack)[0] 		sub_sequence_section = sub_sequence_track.get_sections()[0] 		# 设置聚焦的当前关卡序列 		unreal.LevelSequenceEditorBlueprintLibrary.focus_level_sequence(sub_sequence_section) 
```

要重新聚焦父序列，你只需要运行以下命令：

```
		unreal.LevelSequenceEditorBlueprintLibrary.focus_parent_sequence() 
```

## 查询和编辑关卡序列

获得在Python中访问关卡序列的权限后，你可以对其执行更改。有各种各样的方式可以影响你的序列，下面将提供一些示例。

### 更改帧率

默认情况下，关卡序列按30帧/秒（fps）的速率播放。要更改此播放速率，你可以使用以下命令：

```
		# 创建帧率对象并设置为所需fps数字 		frame_rate = unreal.FrameRate(numerator = 60, denominator = 1) 		# 设置显示速率 		level_sequence.set_display_rate(frame_rate) 
```

### 更改开始和结束时间

默认情况下，序列的播放范围设置为在帧0处开始，并在帧150处结束（假定帧率为30fps）。你可以使用以下命令调整开始和结束帧：

```
		# 将播放范围设置为20-200 		level_sequence.set_playback_start(20) 		level_sequence.set_playback_end(200) 
```

### 添加Actor

要从当前关卡添加Actor供Sequencer持有，请使用以下命令：

```
		# 获取Actor和关卡序列编辑器子系统 		actor_system = unreal.get_editor_subsystem(unreal.EditorActorSubsystem) 		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		# 将所选Actor添加到当前关卡序列作为可持有对象 		actors = actor_system.get_selected_level_actors() 		bindings = ls_system.add_actors(actors) 
```

要通过Python脚本添加摄像机对象以通过Sequencer UI模仿该过程，请使用以下命令：

```
		# 获取关卡序列编辑器子系统 		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		# 使用镜头切换轨道添加可生成对象摄像机Actor绑定 		camera = ls_system.create_camera(spawnable = True) 
```

你不必持有关卡中存在的Actor，而可以使用可用于序列时长的Python[生成](https://dev.epicgames.com/documentation/404)Actor。使用 **LevelSequenceEditorSubsystem** 中之前提到的 **add_actors** ，你可以首先使用命令将Actor设为可持有对象，然后将其转换为可生成对象。使用以下命令将可生成对象添加到你的序列：

```
		# 获取Actor和关卡序列编辑器子系统 		actor_system = unreal.get_editor_subsystem(unreal.EditorActorSubsystem) 		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		# 将所选Actor添加到当前关卡序列作为可持有对象 		actors = actor_system.get_selected_level_actors() 		bindings = ls_system.add_actors(actors) 		# 在所有添加的绑定中循环 
```

对于bindings中的绑定：

```
		# 转换为可生成对象 		ls_system.convert_to_spawnable(binding) 
```

此外，你可以根据需要，使用 **LevelSequenceEditorSubsystem** 通过以下命令将可生成对象转换回可持有对象：

```
		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		selected_bindings = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_bindings() 
```

对于selected_bindings中的绑定：

```
		ls_system.convert_to_possessable(binding) 
```

### 创建轨道和分段

你还可以通过Python脚本添加[轨道](../sequencer-track-list/index.md)和[分段](../creating-animation-keyframes/index.md#%E5%88%86%E6%AE%B5)，通过每个轨道类型可得出分段类型。例如：

- [变换轨道](../../unreal-engine-sequencer-fa6b165a/sequencer-track-list/cinematic-transform-and-property-tracks/index.md#%E5%8F%98%E6%8D%A2%E8%BD%A8%E9%81%93)定义为 `unreal.MovieScene3DTransformTrack` ，其分段使用 `unreal.MovieScene3DTransformSection` 。
- [骨骼网格体动画轨道](../sequencer-track-list/cinematic-animation-track/index.md)定义为 `unreal.MovieSceneSkeletalAnimationTrack` ，其分段使用 `unreal.MovieSceneSkeletalAnimationSection` 。

要添加轨道和分段，请使用以下命令：

```
		# 使用绑定将轨道添加到Sequencer中 - 由轨道类型指定 		transform_track = actor_binding.add_track(unreal.MovieScene3DTransformTrack) 		anim_track = actor_binding.add_track(unreal.MovieSceneSkeletalAnimationTrack) 		# 将分段添加到轨道，以便能够操控范围、参数或属性 		transform_section = transform_track.add_section() 		anim_section = anim_track.add_section() 		## 获取关卡序列开始帧和结束帧 		start_frame = level_sequence.get_playback_start() 		end_frame = level_sequence.get_playback_end() 		# 将分段范围设置为关卡序列开始帧和结束帧 		transform_section.set_range(start_frame, end_frame) 		anim_section.set_range(start_frame, end_frame) 		# 刷新以直观查看添加的新轨道和分段 		unreal.LevelSequenceEditorBlueprintLibrary.refresh_current_level_sequence() 
```

一些分段可能需要在定义属性之后才能使用。对于动画轨道分段的情况，必须定义动画资产。为此，请使用以下命令：

```
		# 获取动画序列资产 		anim_seq = unreal.load_asset("/Game/Mannequin/Animations/ThirdPersonWalk") 		# 获取分段，获取参数，将动画设置为动画序列资产 		anim_section.params.animation = anim_seq 
```

### 复制和粘贴命令

此外，对象、轨道、分段和文件夹都可以通过Python脚本使用以下复制和粘贴函数进行整理和管理：

#### 文件夹

```
		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		selected_folders = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_folders() 		level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence() 		# 添加到剪贴板，返回可以输入以粘贴的文本 		ls_system.copy_folders(selected_folders) 		# 创建参数以确定这将粘贴到何处 		# 在本例中，这将粘贴到它从中复制的相同关卡序列 		paste_params = unreal.MovieScenePasteFoldersParams() 		paste_params.sequence = level_sequence 		paste_params.parent_folder = None 		# 字符串为空时将查看剪贴板，但你可以从copy_bindings输入返回文本 		ls_system.paste_folders("", paste_params) 
```

#### 绑定

```
		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		selected_bindings = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_bindings() 		# 添加到剪贴板，返回可以输入以粘贴的文本 		ls_system.copy_bindings(selected_bindings) 		# 创建参数以确定这将粘贴到何处 		# 在本例中，这将粘贴到它从中复制的相同关卡序列 		# 由于属性需要特定类型的数组，我们必须传递空数组 		paste_params = unreal.MovieScenePasteBindingsParams() 		paste_params.bindings = [] 		paste_params.folders = [] 		paste_params.parent_folder = [] 		# 字符串为空时将查看剪贴板，但你可以从copy_bindings输入返回文本 		ls_system.paste_bindings("", paste_params) 
```

#### 轨道

```
		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence() 		tracks_to_copy_from = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_tracks() 		# 第一个所选绑定将是所选轨道中的绑定 		bindings_to_paste_to = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_bindings()[1:] 		# 添加到剪贴板，返回可以输入以粘贴的文本 		ls_system.copy_tracks(tracks_to_copy_from) 		# 创建参数以确定这将粘贴到何处 		# 在本例中，这将粘贴到所选轨道、所选绑定 		# 由于属性需要特定类型的数组，我们必须传递空数组 		paste_params = unreal.MovieScenePasteTracksParams() 		paste_params.bindings = bindings_to_paste_to 		paste_params.folders = [] 		paste_params.parent_folder = None 		paste_params.sequence = level_sequence 		# 字符串为空时将查看剪贴板，但你可以从copy_bindings输入返回文本 		ls_system.paste_tracks("", paste_params) 
```

#### 分段

```
		ls_system = unreal.get_editor_subsystem(unreal.LevelSequenceEditorSubsystem) 		level_sequence = unreal.LevelSequenceEditorBlueprintLibrary.get_current_level_sequence() 		# 获取第一个所选轨道中的分段 		sections_to_copy_from = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_tracks()[0].get_sections() 		# 获取第一个所选轨道之后的所有轨道。 		tracks_to_paste_to = unreal.LevelSequenceEditorBlueprintLibrary.get_selected_tracks()[1:] 		# 添加到剪贴板，返回可以输入以粘贴的文本 		ls_system.copy_sections(sections_to_copy_from) 		# 创建参数以确定这将粘贴到何处 		# 在本例中，这将粘贴到序列开始时间处它从中复制的相同关卡序列中的所选分段 		# 由于属性需要特定类型的数组，我们必须传递空数组 		paste_params = unreal.MovieScenePasteSectionsParams() 		paste_params.time = unreal.FrameTime() 		paste_params.track_row_indices = [] 		paste_params.tracks = tracks_to_paste_to 		# 字符串为空时将查看剪贴板，但你可以从copy_bindings输入返回文本 		ls_system.paste_sections("", paste_params) 
```

### 轨道筛选

也可以使用[轨道筛选](../sequencer-track-list/index.md#%E6%90%9C%E7%B4%A2%E5%92%8C%E7%AD%9B%E9%80%89)命令：

```
		# 获取轨道筛选器名称并打印出来 		track_filter_names = unreal.LevelSequenceEditorBlueprintLibrary.get_track_filter_names() 		for track_filter_name in track_filter_names: 		print(track_filter_name) 		# 设置骨骼网格体和所选Control Rig功能按钮的轨道筛选器 		unreal.LevelSequenceEditorBlueprintLibrary.set_track_filter_enabled("Skeletal Mesh", True) 		unreal.LevelSequenceEditorBlueprintLibrary.set_track_filter_enabled("Selected Control Rig Controls", True) 		# 按轨道查看启用筛选器的状态 		print(unreal.LevelSequenceEditorBlueprintLibrary.is_track_filter_enabled("Event")) 		print(unreal.LevelSequenceEditorBlueprintLibrary.is_track_filter_enabled("Skeletal Mesh")) 
```

## 其他Sequencer脚本资源

如需有关一般Sequencer Python脚本的更多资源，请参阅本地引擎路径中的Sequencer脚本示例：

`…\Engine\Plugins\MovieScene\SequencerScripting\Content\Python`

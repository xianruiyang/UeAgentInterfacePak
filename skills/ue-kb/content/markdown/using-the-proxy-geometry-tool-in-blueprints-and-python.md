# Using the Proxy Geometry Tool in Blueprints and Python

---
title: "Using the Proxy Geometry Tool in Blueprints and Python"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-proxy-geometry-tool-in-blueprints-and-python-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "静态网格体", "代理几何工具", "Using the Proxy Geometry Tool in Blueprints and Python"]
---

# Using the Proxy Geometry Tool in Blueprints and Python

> 路径：虚幻引擎5.7文档 / 管理内容 / 静态网格体 / 代理几何工具 / Using the Proxy Geometry Tool in Blueprints and Python

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-proxy-geometry-tool-in-blueprints-and-python-in-unreal-engine

可以从蓝图和 Python 脚本调用 Proxy Geometry 工具。这有助于自动化资产创建和数据准备管线，在 Unreal Editor 内运行脚本来合并并简化 Static Mesh Actor 及其材质。代价是损失一定视觉精度，但可以显著提升渲染性能。

例如，此车轮组件包含 147 个独立 Static Mesh Actor，总计 900,000 个三角形，并且每个网格体都有单独材质。这会在 GPU 上形成数百个高开销 drawcall。运行 Proxy Geometry 工具后，这些 Actor 会合并为一个带单一材质的模型，只需一次 drawcall 即可渲染。

![Before: 147 Static Meshes](../../../../../assets/images/3a/3a80029c1782e90ddb24c1b98398a3b0f5f49c7a163b1a3a9478853bbb92a067.jpg)

![After: 1 Static Mesh](../../../../../assets/images/c4/c4021fa24222fc63eb6fbd54d80defb65465785c202599a6495470bb32fcf4d6.jpg)

之前：147 个 Static Mesh

之后：1 个 Static Mesh

三角形数量也减少了 97%。这会造成一些变形，但可以在脚本中调整设置，在简化程度和视觉质量之间找到合适平衡。

由于 Proxy Geometry 工具会对几何体执行相对复杂的变换，并提供许多用于控制其操作的设置，建议先通过编辑器 UI 使用该工具入门。只有在确信已理解该工具及其设置，并清楚预期效果后，再从脚本调用它。更多信息请参阅本节其他指南。

> [!NOTE]
> **前提条件：** 如果尚未安装，需要安装 Editor Scripting Utilities 插件。详情请参阅 [脚本化和自动化编辑器](../../../../production-pipeline/scripting-and-automating-the-unreal-editor/index.md).

选择实现方法：

蓝图

Python

Proxy Geometry 工具通过 **Editor Level Library > Create Proxy Mesh Actor** 节点暴露。

![Create Proxy Mesh Actor](../../../../../assets/images/bc/bc0fbae9f9eb166c61361a1f2920ff5c34fbcee64ce3159f95979970eefbbfa9.png)

需要为该节点提供以下输入：

- 一个数组，包含要合并的所有 Static Mesh Actor。注意，这些必须是 Static Mesh Actor，而不是包含 Static Mesh Component 的 Actor。
- 一个 **Editor Scripting Create Proxy Mesh Actor Options** object that contains the settings used by the proxy geometry tool. This object exposes most of the settings that are shown in the Proxy Geometry tool's UI. To get one of these objects, drag to the left from the **Merge Options** 输入向左拖拽，并选择 **Make EditorScriptingCreateProxyMeshActorOptions**.

  ![Make an options object](../../../../../assets/images/85/857ca37417146bc0584320ea3080327ce2c7d78c8d8fdcc35e727af65593341d.png)

  点击查看完整图像。

  使用此对象为 Proxy Geometry 工具提供设置。许多详细设置由另一个对象提供，需要将该对象传给 **Mesh Proxy Settings** 输入。要获取其中一个对象，请重复上面的操作：从 **Mesh Proxy Settings** 输入向左拖拽，并选择 **Make MeshProxySettings**.

  ![Make a mesh settings object](../../../../../assets/images/8f/8f5351344ce829305a75bcb2a74af85243dfe4656da34e97e66d0614a30f7ff3.png)

  点击查看完整图像。

例如，以下片段会获取当前在 Level Viewport 和 World Outliner 中选中的所有 Actor，将它们合并为一个代理网格体，把结果保存为指定名称和位置的资产，并用新生成代理资产的单个实例替换关卡中的原始 Static Mesh Actor。

![Proxy Geometry Blueprint example](../../../../../assets/images/28/2868e780ca44eff7487a6e14ab25fd411aa9a9cc2f1cf998f5d43915643eb330.png)

点击查看完整图像。

Proxy Geometry 工具通过 `unreal.EditorLevelLibrary.create_proxy_mesh_actor()` 函数。需要向此函数传递以下参数：

- 一个数组，包含要合并的所有 Static Mesh Actor。注意，这些必须是 Static Mesh Actor，而不是包含 Static Mesh Component 的 Actor。
- 一个

  unreal.EditorScriptingCreateProxyMeshActorOptions

  对象，包含 Proxy Geometry 工具要使用的设置。该对象暴露 Proxy Geometry 工具 UI 中显示的大多数设置。需要创建此类对象并设置其属性。

例如，以下片段会获取关卡中的所有 Static Mesh Actor，将它们合并为一个代理网格体，把结果保存为名为 Proxy 的资产，并用 Proxy 资产的单个实例替换关卡中的原始 Static Mesh Actor。

import unreal actors = unreal.EditorLevelLibrary.get_selected_level_actors() merge_options = unreal.EditorScriptingCreateProxyMeshActorOptions() merge_options.base_package_name = "/Game/Proxy" merge_options.destroy_source_actors = False merge_options.new_actor_label = "Proxy" merge_options.spawn_merged_actor = True merge_options.mesh_proxy_settings.set_editor_property("allow_adjacency", False) merge_options.mesh_proxy_settings.set_editor_property("allow_distance_field", False) merge_options.mesh_proxy_settings.set_editor_property("allow_vertex_colors", False) merge_options.mesh_proxy_settings.set_editor_property("calculate_correct_lod_model", True) merge_options.mesh_proxy_settings.set_editor_property("compute_light_map_resolution", True) merge_options.mesh_proxy_settings.set_editor_property("create_collision", False) merge_options.mesh_proxy_settings.set_editor_property("generate_lightmap_u_vs", True) merge_options.mesh_proxy_settings.set_editor_property("merge_distance", 1.0) merge_options.mesh_proxy_settings.set_editor_property("voxel_size", 0.1) merged_actor = unreal.EditorLevelLibrary.create_proxy_mesh_actor(actors, merge_options)


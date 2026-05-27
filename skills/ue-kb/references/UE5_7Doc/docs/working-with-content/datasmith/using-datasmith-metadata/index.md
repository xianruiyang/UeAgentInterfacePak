---
title: "使用Datasmith元数据"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-metadata-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "使用Datasmith元数据"]
---

# 使用Datasmith元数据

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / 使用Datasmith元数据

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-metadata-in-unreal-engine

Datasmith导入器可自动导入其处理对象相关的 **元数据** ：即在3D设计或CAD应用程序中设置的对象信息。元数据常用于存储资源代表的机械部件或建筑元素的真实信息，如部件成本、制造材质、物理特性（如重量、隔热率）或使用信息（如应用到部件的最大扭矩）。还可使用元数据存储项目所需资源的其他相关信息。

在虚幻编辑器和虚幻引擎中启用此元数据，可提供以下两类帮助：

- 在资源流程中：

  导入资源和设置关卡时可使用元数据，以区分需不同处理的不同类型的资源和Actor。例如：

  - 可在Datasmith导入期间使用元数据，以辨识最终场景中无需的资源类型，从而跳过导入。
  - 导入后，可使用元数据辨识关卡中要合并、连接、替换或替换其材质的Actor。
- 游戏运行时：

  可在运行时使用元数据，向用户显示源设计工具中的Actor相关选择信息。例如：

  - 若关卡中的对象包含BIM数据，且此类数据含有自身结构属性信息，则在玩家在场景中选择此类对象时，需在互动体验中显示此类信息。
  - 如项目为产品配置器，玩家可利用其选择不同设计方案，则可能需设置游戏逻辑，以基于指定到可见资源的成本元数据，计算和显示玩家当前选择的总运行成本。

本页将对通过Datasmith导入流程将元数据导入到虚幻，及在编辑器中和运行时访问脚本中元数据的方法进行讲解。

## 元数据源

Datasmith目前可从以下设计工具中导入元数据：

- Autodesk 3ds Max
- Autodesk Revit
- Dassault Systèmes Solidworks
- Trimble SketchUp Pro
- Maxon Cinema 4D
- IFC 2x3文件
- Graphisoft Archicad
- Autodesk Navisworks
- McNeel Rhinoceros (Rhino)

> [!NOTE]
> Datasmith目前仅处理几何体上的元数据，而非如光源或相机等其他场景对象。

## 在虚幻编辑器中查看元数据

Datasmith导入流程完成后，可在 **细节** 面板中的 **资源用户数据（Asset User Data）** 部分下，查看关卡中静态网格体Actor的元数据：

![在虚幻中查看Datasmith元数据](../../../../assets/images/a7/a7401106f3d719a8ee3c944f6ce673512a92d8b750b020c546196e7b69e40de1.png)

编辑器中的Datasmith元数据当前为只读状态。

## 在蓝图和Python中访问元数据

有多种访问关联场景对象的元数据的方法。应根据在Datasmith导入流程期间或导入完成后访问元数据，选择要使用的方法。

> [!NOTE]
> 忽略设计或CAD应用程序的所有元数据键和值原始类型，均以字符串形式存储于虚幻引擎中。例如，若将3ds Max中的元数据值设为布尔值（如 `true` ）或数字（如 `312` ），在虚幻脚本中读取此类元数据时，将以字符串形式显示。如需布尔值或数字值，使用蓝图转换节点（如 **工具（Utilities）>字符串（String）> String to Int** 或 **String to Float** ），或内置Python字符串解析函数（如 `int()` 或 `float()` ）。

### 导入时访问元数据

如需在Datasmith导入流程 *期间* 访问元数据（例如，在生成场景的虚幻资源前辨识要过滤的特定网格体），可在Datasmith场景中读取元数据。欲了解如何在输入过程运行脚本的背景信息，参见[自定义Datasmith导入流程](https://dev.epicgames.com/documentation/unreal-engine/customizing-the-datasmith-import-process-in-unreal-engine)。

你会发现元数据已附加到Datasmith场景中的 *网格体Actor元素* 。

选择实现方法：

Blueprints

Python

所需节点位于 **Datasmith > 场景（Scene）** 和 **Datasmith >元素（Element）** 下。

> [!NOTE]
> 要使用此类节点，需在快捷菜单中禁用 **情境相关（Context Sensitive）** 复选框，或在控制板中寻找所需节点。

| 节点 | 说明 |
| --- | --- |
| [**Get All Metadata**](https://docs.unrealengine.com/en-US/BlueprintAPI/Datasmith/Scene/GetAllMetadata/) | 检索为Datasmith场景中的所有对象记录的所有元数据对象的数组。 |
| [**Get All Objects and Values for Key**](https://docs.unrealengine.com/en-US/BlueprintAPI/Datasmith/Scene/GetAllObjectsandValuesforKey/) | 检索Datasmith场景中所有具有指定键的对象的列表。你还将获得所有这些对象中为该键记录的所有数值的列表。 |
| [**Get Metadata for Object**](https://docs.unrealengine.com/en-US/BlueprintAPI/Datasmith/Scene/GetMetadataForObject/) | 检索赋值给指定对象的所有元数据。 |
| [**Get Metadata Value for Key**](https://docs.unrealengine.com/en-US/BlueprintAPI/Datasmith/Scene/GetMetadataValueForKey/) | 检索赋值给指定对象的指定键的数值。 |
| [**Get Metadata Keys and Values for Value**](https://docs.unrealengine.com/en-US/BlueprintAPI/Datasmith/Scene/GetMetadataKeysAndValuesForValue/) | 检索指定对象上数值与 **String to Match** 输入匹配的所有键。 |

对于上述返回Datasmith元数据元素对象的节点，可使用 **Datasmith > 元素（Element）> 获取属性（Get Properties）** 、 **获取属性（Get Property）** 和 **获取属性数（Get Property Count）** ，在元数据对象中获取键和值：

![Datasmith元数据元素](../../../../assets/images/db/db117438e4c47575254bcc0a76776ff0bd886fd0cfd627956af3021730b3e9bc.jpg)

**使用范例**

本范例将展示使用指定到元数据键的值，识别项目中无需的几何体，并在创建其静态网格体资源前，将其从Datasmith场景中删除的方法：

![Datasmith metadata usage example](../../../../assets/images/43/433548d2a48dd206c90dd56ab0391eaf5390b46ecda6bd4b759a8de9283c6e82.jpg)

Datasmith导入流程期间，可通过 `unreal.DatasmithSceneElement` 对象，获取场景对象的相关元数据。欲了解以下函数的详情，参见[Python API参考](https://api.unrealengine.com/INT/PythonAPI/)。

|  |
| --- |
| `get_all_metadata(object_class)` 获取Datasmith场景中所有对象记录的全部元数据对象数组。 |
| `get_all_objects_and_values_for_key(key, object_class)` 获取Datasmith场景中具有指定键的所有对象列表。还可获得此类对象中该键记录的所有值列表。 |
| `get_metadata_for_object(object)` 获取指定到指定对象的所有元数据。 |
| `get_metadata_value_for_key(object, key)` 获取指定到指定对象的指定键值。 |
| `get_metadata_keys_and_values_for_value(object, string_to_match)` 获取指定对象上值与第二参数匹配的所有键。 |

**使用范例**

本范例将展示使用指定到元数据键的值，识别项目中无需的几何体，并在创建其静态网格体资源前，将其从Datasmith场景中删除的方法：

```
     key_name = "name"    remove_keyword = "Clutch"    meshes_to_skip = set([])    # 获取所有具有"name"键的场景元素。    objects_and_values = ds_scene_in_memory.get_all_objects_and_values_for_key(key_name, unreal.DatasmithMeshActorElement)    objects = objects_and_values[0]    values = objects_and_values[1]    # 进行迭代，寻找值与关键字匹配的对象    for index, value in enumerate(values):        if remove_keyword in value:            print("removing actor named:"+ value)            # 从场景中删除网格体Actor元素，并将网格体元素放入列表以便稍后删除            mesh_actor = objects[index]            mesh = mesh_actor.get_mesh_element()            meshes_to_skip.add(mesh)            ds_scene_in_memory.remove_mesh_actor(mesh_actor)    # 删除所有无需导入的网格体。    for mesh in meshes_to_skip:        mesh_name = mesh.get_element_name()        print("removing mesh named " + mesh_name)        ds_scene_in_memory.remove_mesh(mesh) 
```

### 导入后访问元数据

在导入流程将Datasmith场景导入虚幻资源和Actor后，其同时会将Datasmith场景中各网格体元素的元数据，应用到关卡中代表该静态网格体实例的所有Actor。之后可使用蓝图或Python获取关卡中任意或所有静态网格体Actor的元数据。

选择实现方法：

Blueprints

Python

以下节点会访问一个特定Actor的元数据。其对性能的影响较小，因此可随时（甚至项目中运行时）使用此类节点。若要可视化场景中一个或多个选定对象的导入元数据（例如，项目运行时UI中的注记或菜单内），可在运行时蓝图图表中使用以下节点。

此类节点位于 **Datasmith用户数据（Datasmith User Data）** 类别下。

| 节点 | 说明 |
| --- | --- |
| [**Get Datasmith User Data Value for Key**](https://docs.unrealengine.com/en-US/BlueprintAPI/DatasmithUserData/GetDatasmithUserDataValueforKey/) | 检索具有赋值给指定对象的指定键的元数据的数值。 |
| [**Get Datasmith User Data Keys and Values for Value**](https://docs.unrealengine.com/en-US/BlueprintAPI/DatasmithUserData/GetDatasmithUserDataKeysandValue-/) | 检索指定对象上所有具有你在 **String to Match** 输入中指定的数值的键。如果你知道自己要查找的 *数值*，但不知道键的名称，请使用此节点。 |
| [**Get Datasmith User Data**](https://docs.unrealengine.com/en-US/BlueprintAPI/DatasmithUserData/GetDatasmithUserData/) | 检索包含为Actor记录的 *所有* 键值对的元数据对象，以便你可以自行遍历它们。 |

相反，以下节点可访问当前关卡中所有静态网格体Actor（或共享给定类的静态网格体Actor）的元数据。由于关卡可能包含大量具有诸多属性的Actor，若在运行时游戏进程中使用此类函数时，会导致CPU资源开销较高，且性能较差。因此，仅可在纯编辑器蓝图类上创建的图表中使用此类节点。

此类节点位于 **编辑器脚本（Editor Scripting）> Datasmith用户数据（Datasmith User Data）** 类别下。

| 节点 | 说明 |
| --- | --- |
| [**Get All Objects and Values for Key**](https://docs.unrealengine.com/en-US/BlueprintAPI/EditorScripting/DatasmithUserData/GetAllObjectsandValuesforKey/) | 检索当前关卡中所有在其Datasmith元数据中具有指定键的Actor的列表。你还将获得所有这些对象中为该键记录的所有数值的列表。 |
| [**Get All Datasmith User Data**](https://docs.unrealengine.com/en-US/BlueprintAPI/EditorScripting/DatasmithUserData/GetAllDatasmithUserData/) | 检索当前关卡中所有Actor的所有元数据对象的完整列表。 |

上述 **Get Datasmith User Data** 和 **Get All Datasmith User Data** 节点返回Datasmith用户数据对象参考。该对象拥有一个名为Metadata的可访问变量，其是组成对象Datasmith元数据的所有键值对的Map。要使用此类对象，从输出引脚连出引线，并选择 **变量（Variables）> Get Metadata** ：

![Datasmith用户数据对象参考](../../../../assets/images/8b/8b12a907fdcca1476f4e6ba5a6cb9c7af83f16133b02fe2e3cdf4695b5772d85.jpg)

此操作将以Map形式提供键和值。然后可使用 **工具（Utilities）> Map** 类别中的工具节点使用数据。例如，此图表对所有键进行逐个迭代，并获取各键关联的值：

![遍历Map](../../../../assets/images/67/67492ab1b48b13b288acfc89a87fc82eb0d2206217ff5c484ea250f19d9b81a8.jpg)

如需有关蓝图Map节点的更多信息，请参阅[蓝图API参考](https://docs.unrealengine.com/en-US/BlueprintAPI/Utilities/Map/)。

**使用范例**

本章节将展示简化范例，对在运行时可视化关卡中玩家选定对象的资源元数据的方法进行讲解。

![UMG控件中的元数据](../../../../assets/images/44/44faa3b218c429557f93e4751578c2f3800645c492faf1c415503fbddf83d32c.jpg)

使用包含两个文本域的UMG控件编写文本，各文本域与字符串变量绑定。在控件的蓝图图表中，自定义操作从传入自定义事件的Actor中提取Datasmith元数据的两个项目，并将此类项目保存到绑定变量。

![UMG控件事件图表](../../../../assets/images/4a/4a03a3c853db4534cfc20c310b9ef25b81bd39e13636e17687a7de437cce4f8d.jpg)

以下关卡蓝图将展示范例，对开始运行时添加此类控件，及用户按下鼠标键时使用光标下的Actor进行填充的方法进行讲解。

![Set up and update the UMG widget](../../../../assets/images/bc/bc4718258d0960eb8dc5c5170e94184da14907650c3c1f47667601f0ead85c6b.jpg)

如需有关在UMG中构建用户界面的更多信息，请参阅[UMG UI设计器快速入门指南](../../../user-interfaces/basics-of-user-interface-development/building-your-ui/umg-ui-designer-quick-start-guide/index.md)及相关小节。

完成Datasmith导入流程后，可使用 `unreal.DatasmithContentLibrary` 类访问所有Actor或选定Actor的元数据。欲了解以下函数，参见[Python API参考](https://api.unrealengine.com/INT/PythonAPI/)。

|  |
| --- |
| `get_all_datasmith_user_data(object_class)` 获取当前关卡中所有Actor的全部元数据对象完整列表。 |
| `get_all_objects_and_values_for_key(key, object_class)` 获取当前关卡中，在Datasmith元数据内具有指定键的所有Actor列表。还可获得此类对象中该键记录的所有值列表。 |
| `get_datasmith_user_data(object)` 获取包含指定Actor记录的所有键值对的元数据对象，以便之后进行迭代。 |
| `get_datasmith_user_data_keys_and_values_for_value(object, string_to_match)` 获取指定Actor上，包含第二参数中指定值的所有键。已知要查找的值，但不知键命名时，可使用此节点。 |
| `get_datasmith_user_data_value_for_key(object, key)` 使用指定到指定Actor的指定键，获取元数据的值。 |

**使用范例**

在虚幻编辑器内运行的Python脚本中，可在导入后使用Datasmith元数据，辨识关卡中要应用部分特殊流程的静态网格体Actor。

```
     import unreal    new_actor_name = "Exterior Walls"    metadata_key = "Type"    metadata_value = "Wall:Exterior"    meshes_to_join = set([])    # 迭代当前关卡中的Actor    all_actors = unreal.EditorLevelLibrary.get_all_level_actors()    for actor in all_actors:        # 获取该Actor的上述键Datasmith元数据值（如有）        actor_value = unreal.DatasmithContentLibrary.get_datasmith_user_data_value_for_key(actor, metadata_key)        # 如键存在，且其值包含上述关键字，将Actor添加到列表        if actor_value and metadata_value in actor_value:            print("found a matching actor:"+ actor_value)            meshes_to_join.add(actor)    # 将之前找到的所有Actor放入具有诸多组件的单个Actor    options = unreal.EditorScriptingJoinStaticMeshActorsOptions(destroy_source_actors=True, new_actor_label=new_actor_name, rename_components_from_source=True)    unreal.EditorLevelLibrary.join_static_mesh_actors(meshes_to_join, options)    print "Merged all actors!" 
```

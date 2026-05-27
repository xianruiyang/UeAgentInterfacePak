---
title: "在影片渲染图表中进行渲染编程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/programming-a-render-in-mrg-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "在影片渲染图表中进行渲染编程"]
---

# 在影片渲染图表中进行渲染编程

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 在影片渲染图表中进行渲染编程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/programming-a-render-in-mrg-in-unreal-engine

本文重点介绍 **影片渲染图表** 的脚本编写，它是 **影片渲染队列** 的后继版本。影片渲染图表（**MRG**）的功能与 **影片渲染队列（MRQ）** 类似，但其配置文件由图表编辑器支持。两个系统都具备队列和执行器功能，但实际的影片配置和渲染现在被分为两套系统，分别使用不同的配置和函数。

完整的可运行脚本和更多示例见 `MovieGraphEditorExample.py` 和 `MovieGraphEditorExampleHelpers.py` 文件，其文件夹路径为 `/Engine/Plugins/MovieScene/MovieRenderPipeline/ Content/Python/` ，暂时附在课程最后。本文档将引用python的代码片段，并讨论关于影片渲染图表的新概念。

#### 先决条件

- 开始阅读前，推荐先熟悉下列关于影片渲染队列和影片渲染图表的文档：

  - [影片渲染队列](https://dev.epicgames.com/documentation/404)
  - [影片渲染图表](https://dev.epicgames.com/documentation/404)
- 一套关卡序列和一套用于渲染的关卡（即镜头）

## 简易自动化示例

要以自动化的方式重复渲染相同镜头，最简单的方法就是将设置好的渲染作业保存在影片管线队列（Movie Pipeline Queue）中。队列可组织渲染作业，应用预设的设置和作业属性，从而简化创作和管理渲染作业的流程。

请确保影片渲染窗口中添加了待渲染作业或加载了队列。请务必提前在设置栏中选择"用图表替换（replace with graph）"，然后选择已创建的影片图表设置（Movie Graph Setting）。在影片渲染队列窗口的"影片图表变量（Movie Graph Variables）"分段中，应该能看到已公开的变量"自定义输出分辨率（Custom Output Resolution）"

### 创建影片图表配置UAsset

为运行示例代码，我们先创建一个图表示例。我们的配置基于默认的影片渲染图表资产。要创建该资产，要么运行以下代码片段，这将在 `/Game/MyTests/IntermediateConfig` 中放置一份图表

```
import MovieGraphCreateConfigExample MovieGraphCreateConfigExample.CreateIntermediateConfig()
```

或者使用内容浏览器手动创建：右键点击并选择"过场动画（Cinematics） > 影片渲染图表配置（Movie Render Graph Config）"，并应用下列两项变更。

- 找到"Global Output Settings"节点，右键点击该节点，勾选快捷菜单中的复选框，公开 `OutputResolution`
- 右键点击"Global Output Settings"节点的 `OutputResolution` 引脚，选择"提升为变量（promote to variable）"，将输出分辨率公开到变量中

你的图表应该与下图相似。

> [!NOTE]
> 如果使用脚本，所有节点看起来都会缠结在一起，将它们分开即可。

![ImageAltText](../../../../../assets/images/e0/e010c9010e4dc8fd70edca5e28620cd0ec6e124dee20ac65975bfcac711f26b6.jpg)

## 修改用户公开参数

![ImageAltText](../../../../../assets/images/5b/5b74172473ee7036fdb938ac12d2ae321d7a425e3162f45bdce005a4569e9d7a.png)

新的影片渲染图表让我们可以将逐属性的重载项以用户参数的形式显示，而这些参数可以在作业的细节面板中直接重载，这就类似于蓝图的方法。在此之前，我们只能用C++创建自己的MoviePipelineExecutorJob变量来实现这一目标，而这需要维护额外的代码并重新编译编辑器。此外，执行器作业（Executor Job）定义的版本也被限定为一个，这对需要为不同类型的渲染公开不同属性的大型项目来说并不理想。而图表则让美术师可以更方便地直接在图表中查看修改属性所用的路径。

下一个代码片段将重载公开的变量 `CustomOutputRes` ，而该变量位于作业的影片渲染队列面板。

```
def set_user_exposed_variables(job:unreal.MoviePipelineExecutorJob):     """找到并修改用户公开的CustomOutputResolution变量"""     graph = job.get_graph_preset()     variables = graph.get_variables()     if not variables:         print("此图表上未公开变量，请公开 'CustomOutputResolution' 以测试此示例")     for variable in variables:         if variable.get_member_name() == "CustomOutputRes":             # 获取图表或子图表的变量赋值              variable_assignment = job.get_or_create_variable_overrides(graph)             # 设新值             variable_assignment.set_value_serialized_string(variable,                  unreal.MovieGraphLibrary.named_resolution_from_profile("720p (HD)").export_text())             # 启用重载开关             variable_assignment.set_variable_assignment_enable_state(variable, True)
```

讨论：

我们先获取了图表预设项，然后遍历变量找到了"CustomOutputResolution"，将其公开到我们的图表，从而重载了被渲染图像的渲染分辨率。然后我们将新的CustomOutputResolution属性设置为"720p"，最后将变量设为启用状态，从而实际应用了重载。

如果你想测试队列中的作业，请获取作业的引用，例如队列中的第一个作业，然后运行下列函数。

```
#获取队列子系统以访问当前队列 subsytem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem) pipeline_queue = subsytem.get_queue() #获取第一个作业 job = pipeline_queue.get_jobs()[0] #测试我们的函数，这应该会更改用户公开的变量 set_user_exposed_variables(job)
```

如果代码运行成功，那么 `Custom Output Resolution` 将被设为720p (HD) - 1280x720。

![ImageAltText](../../../../../assets/images/94/9437217dfefbdc32d9e15004586a82e1b227bdc6d227f5887ea7b6d2f55a158e.png)

## 修改图表节点设置的默认参数

![ImageAltText](../../../../../assets/images/f0/f06185a79b3ecdcfbbc0d638aa37e955b1cbe8ffcab517c3b03be72f43a5ebf9.jpg)

尽管管理重载项的推荐方法是公开图表变量，并将其与图表逻辑挂钩，但你可能需要在某些情况下直接在节点上重载设置。换句话说，你可能没有公开用户变量，但仍希望修改默认值。

```
@staticmethod def set_global_output_settings_node(job:unreal.MoviePipelineExecutorJob):     '''     本示例演示了如何修改Global Output Settings     节点来编辑默认值。如果你只想重载某些公开值，     请查看"set_user_exposed_variables"，这是一种更适合     逐作业进行重载的工作流程。     注意：这是在修改实际的共享图表资产并对其造成污染。     '''     # 从要搜索Output Settings节点的作业中获取图表资产     graph = job.get_graph_preset()     # 获取Globals Output节点     globals_pin_on_output = graph.get_output_node().get_input_pin("Globals")     # 假设Output Settings节点连接到了Globals引脚     output_settings_node = globals_pin_on_output.get_connected_nodes()[0]          if not isinstance(output_settings_node, unreal.MovieGraphGlobalOutputSettingNode):         unreal.log("此示例预设Global Output Settings节点被插入了Globals节点")         return     output_settings_node.set_editor_property("override_output_resolution", True)     # 重载输出分辨率     output_settings_node.set_editor_property("output_resolution",                  unreal.MovieGraphLibrary.named_resolution_from_profile("720p (HD)"))
```

在本示例中，我们首先使用"Globals"节点的输入引脚作为进入点，并假设连接的节点是我们为本示例创建的 `MovieGraphGlobalOutputSettingNode` 。

> [!NOTE]
> 为将本示例的重点放在重载设置上，我们假定Globals（输出节点）的输入是Global Output Settings节点。

要对Global Output Settings节点进行测试设置，可以运行以下代码片段，这样应该就能设定"Global Output Settings"节点的分辨率。

```
#获取队列子系统以访问当前队列 subsytem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem) pipeline_queue = subsytem.get_queue() #获取第一个作业 job = pipeline_queue.get_jobs()[0] #测试我们的函数，这应该会更改用户公开的变量 set_global_output_settings_node(job)
```

## 影片图表遍历

本示例说明如何使用深度优先搜索遍历图表设置项以访问全部的节点。在下面的示例中，我们以Globals节点引脚为起始点，从右向左搜索完所有节点。

```
graph = unreal.load_asset("/Game/YourGraph.YourGraph") output_node = graph.get_output_node() visisted = set() def dfs(node, visisted=None):     visited.add(node.get_name())     print(node)          #不同的节点有不同数量的输入节点和名称     if isinstance(node, unreal.MovieGraphSubgraphNode) or isinstance(node, unreal.MovieGraphOutputNode):         pins = [node.get_input_pin("Globals"), node.get_input_pin("Input")]     elif isinstance(node, unreal.MovieGraphBranchNode):         pins = [node.get_input_pin("True"), node.get_input_pin("False")]     elif isinstance(node, unreal.MovieGraphSelectNode):         pins = [node.get_input_pin("Default")]     else:         pins = [node.get_input_pin("")]     #遍历找到的引脚     for pin in pins:         if pin:             for neighbour in pin.get_connected_nodes():                 dfs(neighbour, visited) dfs(output_node)
```

运用下图所示的图表，我们遍历各节点并使用"引脚"来查找下一个要处理的节点。由于不同的节点类型可能有命名的引脚，在遇到特定的节点类型（如 `MovieGraphBranchNode` ）时，我们需要以表单形式记录这些属性，并以递归的方式搜索"True"和"False"引脚。若节点只有单个输入，其引脚""将为空字符串

![ImageAltText](../../../../../assets/images/69/69007241a214dfabdfebf6b6d5243b8ae216529996324794631fe73a18927096.jpg)

> [!NOTE]
> 下个版本将重点关注图形遍历的领域，以便用更少的代码轻松访问节点。

`Content/Python/MovieGraphCreateConfigExample.py` 内含有关图表操作的其他示例。

## 其他影片渲染图表示例

附件中的两个Python文件内含额外功能和用法案例，并附有注释。你可以导入这些文件并研究其中的逻辑。`MovieGraphEditorExample.py` 文件提供了完整的脚本化示例，说明了如何创建自动化，而 `MovieGraphEditorExample.py` 文件提供了可复用的函数。

```
# Epic Games, Inc. 保留所有权利。 # 这些示例展示了如何用影片渲染图表进行脚本编写 import unreal import MovieGraphCreateConfigExample as graph_helper import MovieGraphEditorExampleHelpers # 用法： #   - 要求项目启用"Python编辑器脚本插件（Python Editor Script Plugin）"。 #   main()函数给出了示例来演示如何加载并  #   修改影片图表、覆盖公开的变量以及执行  #   与影片渲染图表相关的其他操作 # #   注意更改"待加载资产（Assets to load）"部分，以指向你自己的  #   影片渲染队列和影片图表配置资产 ''' Python Globals会让UObjects在垃圾回收时存活。 完成后必须手动删除。 ''' subsystem = None executor = None def render_queue(queue_to_load:unreal.MoviePipelineQueue=None,                   graph_to_load: unreal.MovieGraphConfig=None):     """     本例演示如何：     - 加载队列或使用当前队列     - 将图表配置设为预设     - 添加简易的执行器完成回调      """     # 获取与影片管线队列交互的子系统     subsystem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem)     # 有队列资产则加载该资产，否则使用活动队列       if queue_to_load:         if subsystem.load_queue(queue_to_load, prompt_on_replacing_dirty_queue=False):             unreal.log("Loaded specified queue")          # 获取活动队列的引用     pipeline_queue = subsystem.get_queue()          if not pipeline_queue.get_jobs():         unreal.log("There are no jobs in the Queue.")         return              # 每项作业开始时，我们都可以修改作业参数，例如访问     # 作业的图表预设或修改数值     for job in pipeline_queue.get_jobs():         #确保本例中使用的是作业图表配置         if not job.get_graph_preset():             unreal.log("A Graph Config needs to be specified for this example)")             return                  if graph_to_load:             job.set_graph_preset(graph_to_load)         # 作业运行示例集见          MovieGraphEditorExampleHelpers.advanced_job_operations(job)     # 使用全局关键字表示执行器属于      # 全局域，以避免其在作业渲染完成后被垃圾回收     global executor     executor = unreal.MoviePipelinePIEExecutor(subsystem)          # 渲染作业完成后，执行回调on_queue_finished_callback     executor.on_executor_finished_delegate.add_callable_unique(         MovieGraphEditorExampleHelpers.on_queue_finished_callback     )       # 开始渲染，这类似于在用户界面中按下"渲染（Render）"键，      subsystem.render_queue_with_executor_instance(executor) def allocate_render_job(config_to_load: unreal.MovieGraphConfig=None):     '''     启动渲染前，分配新作业并填充其参数     '''     # 获取当前队列     subsytem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem)     pipeline_queue = subsytem.get_queue()     # 删除现有作业以清除当前队列     pipeline_queue.delete_all_jobs()     job = pipeline_queue.allocate_new_job(unreal.MoviePipelineExecutorJob)          # 要重载作业参数，请检查      # MovieGraphEditorExampleHelpers.set_job_parameters(job)          if config_to_load:         job.set_graph_preset(config_to_load)     subsystem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem)     executor = unreal.MoviePipelinePIEExecutor(subsystem)     subsystem.render_queue_with_executor_instance(executor) def render_queue_minimal():     '''这是一个MVP示例，说明如何渲染已分配好作业的队列     有关重载项的更详尽示例，见函数render_queue     '''     subsystem = unreal.get_editor_subsystem(unreal.MoviePipelineQueueSubsystem)     executor = unreal.MoviePipelinePIEExecutor(subsystem)     subsystem.render_queue_with_executor_instance(executor) def main():     """我们展示的是如何渲染队列(render_queue)，以及      如何在最初不创建队列的情况下从头开始创建作业。 (allocate_render_job)      请分别运行这些示例。      """     # 在/Game/MyTests/IntermediateConfig下创建名为"Example"的图表资产      # 该资产会将输出分辨率公开为用户变量      created_graph = graph_helper.CreateIntermediateConfig()     # 使用已保存的队列资产渲染队列，添加执行器回调，可以传输     # 影片渲染队列资产，或确保影片渲染队列中有作业即可     render_queue()     # 此函数通过分配新的MoviePipelineJob在队列中创建作业，      # 你也可以传入config_to_load以设定图表配置，最后再开始渲染     allocate_render_job() if __name__ == "__main__":     unreal.log("Check the main() function for examples")
```

MovieGraphEditorExample.py

```
# Epic Games, Inc. 保留所有权利。 # # # 影片渲染图表的辅助函数，所有函数都是静态方法， # 这有助于单独测试各个函数。此模块被用于 # MovieGraphEditorExample.py内 import unreal @staticmethod def on_queue_finished_callback(executor: unreal.MoviePipelineExecutorBase, success: bool):     """在执行器完成所有作业渲染后调用     Args:         success (bool): 如果所有作业都成功完成，则为true，如果作业                          出错（比如输出目录无效）                         或用户取消作业（按escape键），则为false         executor (unreal.MoviePipelineExecutorBase): 运行该队列的执行器     """     unreal.log("on_queue_finished_callback Render completed. Success: " + str(success)) @staticmethod def set_global_output_settings_node(job:unreal.MoviePipelineExecutorJob):     '''     本示例演示了如何修改Global Output Settings     节点来编辑默认值。如果你只想重载某些公开值，     请查看"set_user_exposed_variables"，这是一种更适合     逐作业进行重载的工作流程。     注意：这是在修改实际的共享图表资产并对其造成污染。     '''     # 从要搜索Output Settings节点的作业中获取图表资产     graph = job.get_graph_preset()     # 获取Globals Output节点     globals_pin_on_output = graph.get_output_node().get_input_pin("Globals")     # 假设Output Settings节点连接到了Globals引脚     output_settings_node = globals_pin_on_output.get_connected_nodes()[0]          if not isinstance(output_settings_node, unreal.MovieGraphGlobalOutputSettingNode):         unreal.log("此示例预设Global Output Settings节点被插入了Globals节点")         return     output_settings_node.set_editor_property("override_output_resolution", True)     # 重载输出分辨率     output_settings_node.set_editor_property("output_resolution",                  unreal.MovieGraphLibrary.named_resolution_from_profile("720p (HD)")) @staticmethod def set_job_parameters(job:unreal.MoviePipelineExecutorJob):     """该函数展示了如何设置或修改作业参数。通过     使用set_editor_property方法，确保更改会将队列      标记为dirty     Args:         job (unreal.MoviePipelineExecutorJob): 待修改的管线作业     """     job.set_editor_property("sequence", unreal.SoftObjectPath('/Game/Levels/shots/shot0010/shot0010.shot0010'))     job.set_editor_property("map", unreal.SoftObjectPath('/Game/Levels/Main_LVL.Main_LVL'))     job.set_editor_property("job_name", "shot0010")     job.set_editor_property("author", "Automated.User")     job.set_editor_property("comment", "This comment was created through Python") @staticmethod def set_user_exposed_variables(job:unreal.MoviePipelineExecutorJob):     """找到并修改用户公开的CustomOutputResolution变量     Args:         job (unreal.MoviePipelineExecutorJob): 将使用的管线作业，用来查找                                          待修改的图表预设     """     graph = job.get_graph_preset()     variables = graph.get_variables()     if not variables:         print("此图表上未公开变量，请公开 'CustomOutputResolution' 以测试此示例")     for variable in variables:         if variable.get_member_name() == "CustomOutputRes":             # 获取图表或子图表的变量赋值              variable_assignment = job.get_or_create_variable_overrides(graph)             # 设新值             variable_assignment.set_value_serialized_string(variable,                  unreal.MovieGraphLibrary.named_resolution_from_profile("720p (HD)").export_text())             # 启用重载开关             variable_assignment.set_variable_assignment_enable_state(variable, True) @staticmethod def duplicate_queue(pipeline_queue:unreal.MoviePipelineQueue):     """     适用于在交互式会话中复制队列，特别是当你      需要修改队列资产的副本，而非修改原始资产时。     Args:         queue (unreal.MoviePipelineQueue): 待复制的队列     """     new_queue = unreal.MoviePipelineQueue()     new_queue.copy_from(pipeline_queue)     pipeline_queue = new_queue     return pipeline_queue  @staticmethod def advanced_job_operations(job:unreal.MoviePipelineExecutorJob):     """     将在当前作业上运行下列函数的封装函数     - set_job_parameters     - set_user_exposed_variables     - set_global_output_settings_node     Args:         job (unreal.MoviePipelineJob): 当前已处理的队列作业     """     if not job.get_graph_preset():         unreal.log("This Job doesn't have a graph type preset, add a graph preset to the job to test this function")         return     # 设定诸如Author/Level/LevelSequence等作业参数     set_job_parameters(job)     # 在图表配置上设定用户公开的变量     set_user_exposed_variables(job)          # 直接在实际的图表节点上设定属性，这就类似于     # 设定默认值     set_global_output_settings_node(job) @staticmethod def traverse_graph_config(graph:unreal.MovieGraphConfig):     """演示如何使用深度优先搜索访问所有节点，     从"全局（Globals）"引脚开始，从右向左，直到搜索完      所有节点     Args:         graph (unreal.MovieGraphConfig): 用来运行的图表     """     visited = set()     def dfs(node, visisted=None):         visited.add(node.get_name())                  # 节点可能会有不同数量的输入节点和名称需要收集         if isinstance(node, unreal.MovieGraphSubgraphNode) or isinstance(node, unreal.MovieGraphOutputNode):             pins = [node.get_input_pin("Globals"), node.get_input_pin("Input")]         elif isinstance(node, unreal.MovieGraphBranchNode):             pins = [node.get_input_pin("True"), node.get_input_pin("False")]         elif isinstance(node, unreal.MovieGraphSelectNode):             pins = [node.get_input_pin("Default")]         else:             pins = [node.get_input_pin("")]         # 遍历找到的引脚         for pin in pins:             if pin:                 for neighbour in pin.get_connected_nodes():                     dfs(neighbour, visited)
```

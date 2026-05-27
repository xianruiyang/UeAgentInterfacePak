---
title: "使用Python编写编辑器测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/write-editor-tests-with-python-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Create Automation Tests", "使用Python编写编辑器测试"]
---

# 使用Python编写编辑器测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Create Automation Tests / 使用Python编写编辑器测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/write-editor-tests-with-python-in-unreal-engine

> [!NOTE]
> 你需要用到 **PythonAutomationTest** 插件。要将其启用，请执行以下步骤：
>
> 1.选择 **编辑（Edit）>插件（Plugins）** ，打开 **插件（Plugin）** 面板。 1.使用搜索栏找到该插件。 1.启用对应复选框。 1.重启虚幻编辑器。

## PythonAutomationTest插件

PythonAutomationTest插件能自动发现当前项目中的Python脚本，并将其作为测试添加到 **测试自动化（Test Automation）** 窗口中。该插件会对Python脚本进行封装，以便自动化测试系统捕获故障，并提供处理潜在命令的方法。

启用后，插件将包含以 `test_*.py` 模式命名且位于项目和插件 `/Content/Python` 文件夹中的Python脚本。子文件夹结构会被解析并反映在测试名称中，从而将各个测试放置于如下路径：

`Editor > Python > Project/Plugin Name > Sub-folder Structure > Test Name`

在Python脚本本身中，则什么都可以用。你可以通过 **文件（File） > 执行Python脚本（Execute Python Script）** 来执行它。测试结果包含所有异常、日志错误和警告。

## 处理潜在命令

如果调用非阻塞函数，编辑器需要tick才能使其完成。

Python脚本执行期间，编辑器不会tick，因此你需要释放全局解译器锁（GIL），调度一次post-Slate回调，然后再次调用 `python` 。一种可行的方法是，使用Python自动调度程序，具体方法如下：

```
import unreal@unreal.AutomationScheduler.add_latent_commanddef load_some_stuff():    pass
```

指令集将按照你注册的顺序执行。你可以通过注册生成器或从回调返回函数或生成器来进行动态调度。

```
@unreal.AutomationScheduler.add_latent_commanddef do_some_stuff():    print('initiate')     yield    print('start loop')     for i in xrange(10):        print('loop %d'% i)        task = get_a_task_somehow()        while not task.is_task_done():            yield         print('task %d done'% i)
```

## 报告错误

有三种方法可以在测试执行过程中报告错误。

- 使用Python的

  assert

  - 阻止执行当前测试的任何后续代码，并在测试报告中包含Python调用堆栈。
- raise Exception("<error>")

  - 阻止执行当前测试的任何后续代码，并报告异常。
- 记录错误（使用编辑器命令或

  unreal.log_error("<error>")

  ）- 将信息包含在测试报告中并继续执行。

## 预期日志错误

你可以通过以下Python代码利用预期的C++框架错误：

```
unreal.AutomationLibrary.add_expected_log_error(expected_pattern_string, occurrences=1, exact_match=False)
```

该函数匹配错误和警告。模式相同的连续调用不会累计次数。第一次调用时发生情况的次数必须准确，因为发生情况的次数不同会报告失败。

## 截图支持

你可以使用自动化调度程序通过Python测试进行截图。

自动化库中的 `take_high_res_screenshot` 函数将请求截取高分辨率的截图。不过要完成截图就需要一次额外的编辑器tick，因此进行下一步前必须使用调度程序暂停测试。

### 示例

下列示例会在加载关卡后从不同的摄像头拍摄多张截图。

```
import unreal @unreal.AutomationScheduler.add_latent_commanddef setup_level():    unreal.EditorLevelLibrary.load_level("/Game/mymap") @unreal.AutomationScheduler.add_latent_commanddef take_all_cam_screenshots():    level_actors = unreal.EditorLevelLibrary.get_all_level_actors()    all_cameras = unreal.EditorFilterLibrary.by_class(        level_actors,        unreal.CameraActor    )     for cam in all_cameras:        camera_name = cam.get_actor_label()        task = unreal.AutomationLibrary.take_high_res_screenshot(1280, 720, camera_name, camera=cam,)        if not task.is_valid_task():            continue         print ('Requested screenshot for '+ camera_name )        while not task.is_task_done():            yield
```

## 图像对比支持

你可以使用以下命令将图像文件与测试参考进行比较：

```
unreal.AutomationLibrary.compare_image_against_reference(image_file_path, comparison_name, comparison_tolerance)
```

如果成功读取图像并进入比较队列，函数将返回true。队列中的对比将在测试结束时被求值。

## 遥测支持

你可以使用以下函数通过Python测试来存储遥测数据：

```
unreal.AutomationLibrary.add_test_telemetry_data(datapoint, measurement, context)
```

> [!NOTE]
> `measurement` 参数是浮点数。

你可以使用以下函数更改测试的存储名称：

```
unreal.AutomationLibrary.set_test_telemetry_storage(name)
```

---
title: "使用工具蓝图编写编辑器测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/write-editor-tests-with-utility-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Create Automation Tests", "使用工具蓝图编写编辑器测试"]
---

# 使用工具蓝图编写编辑器测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Create Automation Tests / 使用工具蓝图编写编辑器测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/write-editor-tests-with-utility-blueprints-in-unreal-engine

> [!NOTE]
> 你需要用到 **EditorTests** 插件。要将其启用，请执行以下步骤：
>
> 1. 选择
>
>    编辑（Edit）>插件（Plugins）
>
>    ，打开
>
>    插件（Plugin）
>
>    面板。
> 2. 使用搜索栏找到该插件。
> 3. 启用对应复选框。
> 4. 重启虚幻编辑器。

你可以使用[编辑器工具蓝图](../../../../production-pipeline/scripting-and-automating-the-unreal-editor/scripting-the-unreal-editor-using-blueprints/index.md)在编辑器中创建自动化测试脚本。

## 创建编辑器工具蓝图的测试

要创建编辑器工具蓝图，请点击 **内容浏览器（Content Browser）** 中的 **添加（Add）** 按钮，选择 **编辑器工具（Editor Utilities） > 编辑器工具蓝图（Editor Utility Blueprint）** ，然后在 **选择父类（Pick Parent Class）** 窗口中搜索 "EditorUtilityTest"。

因为资产路径将用于测试的命名，请按以下格式为资产适当命名：`Project.Blueprints.EditorUtilities.<内容路径>.<资产名称>` 。

## 实现编辑器工具蓝图的测试

编辑器工具蓝图默认有两条事件建议：

- 准备测试（Prepare Test）

  - 用于在开始测试前执行必要设置，然后调用

  完成准备测试（Finish Prepare Test）

  。如果此事件失败或超时，

  开始测试（Start Test）

  事件将不会被调用。
- 开始测试（Start Test）

  - 主事件。调用此事件后，你就可以使用普通的工具蓝图节点，然后调用

  结束测试（Finish Test）

  从而将测试结束。

必须调用 **结束测试（Finish Test）** ，否则测试将超时。你可以重载 **已完成测试（Finished Test）** 函数，从而指定测试完成时的附加说明。代码执行必须是阻塞式的。

> [!NOTE]
> 你可以在资产的 **细节（Details）** 面板中设置超时和元数据。

## 使用编辑器工具测试来测试编辑器工具蓝图

你可创建将相应编辑器工具蓝图实例化的编辑器工具测试蓝图，从而进行自动测试。

在蓝图图表中，添加 **构造（Construct）** 节点，并将 **类（Class）** 设置为相关的编辑器工具类。之后你就可以调用任意类函数。

> [!TIP]
> 你可以将 **构造（Construct）** 节点的返回值存储在变量中，以便多次调用而无需重新实例化。

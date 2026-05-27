---
title: "配置自动化测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/configure-automation-tests-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "配置自动化测试"]
---

# 配置自动化测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / 配置自动化测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/configure-automation-tests-in-unreal-engine

## 测试组

测试组是从基于测试名称的筛选条件列表中得来的测试集。

你可以通过命令行参数 `-ExecCmds="Automation RunTest"` 或 **测试自动化（Test Automation）** 窗口的筛选条件来引用它们。这有助于收集分属不同分段的测试。

要定义测试组，可编辑配置文件 `DefaultEngine.ini` 并添加下列语句：

```
+Groups=(Name="Group1", Filters=((Contains=".Some String.")))+Groups=(Name="Group2", Filters=((Contains="Group2.", MatchFromStart=true),(Contains=".Group2.")))
```

之后可以在 `ExecCmds` 参数和[Gauntlet] (testing-and-optimizing-your-content\Automation\Gauntlet\Overview)中使用 `Group:<GroupName>` 来引用测试组。

## 排除测试

在项目开发过程中，你可能会需要暂时排除测试。

要排除测试，请编辑 `DefaultEngine.ini` 文件或相应的平台配置文件，使用语句如下：

```
+ExcludeTest=(Test="<test or section name>",Reason="<a reason>",Warn=False)
```

> [!TIP]
> 输入部分名称即可排除所有以字符串开头的测试。

你可添加以下语句，使用渲染硬件接口（RHI）进行排除：

```
+ExcludeTest=(Test="<test or section name>",Reason="<a reason>", RHIs=("Vulkan", "DirectX 11"),Warn=False)
```

RHI的名称必须符合 `Engine\Source\Runtime\AutomationTest\Public\AutomationTestExcludelist.h` 中的语法

被排除的测试将显示为"跳过（Skipped）"，并且原因将作为信息事件附上。

> [!NOTE]
> 你还可以使用测试选择复选框旁的 **排除（Exclude）** 按钮，在 **测试自动化（Test Automation）** 窗口中排除编辑器里的测试。

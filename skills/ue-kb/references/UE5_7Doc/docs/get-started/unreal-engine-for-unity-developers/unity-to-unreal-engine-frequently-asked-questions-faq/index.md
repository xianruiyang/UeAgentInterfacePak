---
title: "常见问题解答"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unity-to-unreal-engine-frequently-asked-questions-faq"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "常见问题解答"]
---

# 常见问题解答

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / 常见问题解答

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unity-to-unreal-engine-frequently-asked-questions-faq

### 如何自动加载上一个项目？

你可以将虚幻引擎配置为在启动时自动加载你之前处理的最后一个项目。 通过Epic启动程序打开项目时，在虚幻引擎启动屏幕上启用**启动时固定加载上次打开的项目（Always Load Last Project on Startup）**选项。

### 哪里可以设置游戏的输入绑定？

在Unity中，你使用项目的输入管理器设置来设置默认绑定。

在虚幻引擎中，通过**项目设置（Project Settings）**窗口中的**输入（Input）**类别配置输入绑定。 在此窗口中，你可以添加各种按钮（操作）和模拟功能按钮（轴）。 为每个功能按钮提供名称和默认绑定。 这样做之后，你就可以在触发输入事件时获得对游戏的Pawn的回调。

如需详细了解如何设置虚幻引擎项目的输入，请参阅[输入](../../../gameplay-systems/input/index.md)页面。

> [!NOTE]
> 如果你的项目需要更多高级输入功能，如复杂输入处理或运行时控制重映射，请考虑使用**Enhanced Input**插件。 如需更多信息，请参阅[增强输入](../../../gameplay-systems/input/enhanced-input/index.md)。

### 如何更改项目的初始场景？

默认情况下，虚幻引擎会在你打开项目时加载默认关卡。 你可以在**编辑器偏好设置（Editor Preferences）**窗口（主菜单：**编辑（Edit）>编辑器偏好设置（Editor Preferences）**）的**通用（General）>加载和保存（Loading & Saving）**类别中更改此行为。

### 如何运行游戏？

有多种方式可试玩（运行）你的游戏：

- 直接在虚幻编辑器中运行，方法是点击**主工具栏**上的**运行（Play）**按钮。
- 作为独立的程序运行，方法是点击**主工具栏**上的**平台（Platforms）**按钮，然后从下拉列表中选择你的机器。 请注意，这会首先为你的平台编译一个可执行文件；例如，如果你在Windows机器上工作，这将构建Windows可执行文件。
- 在不同的平台（例如，移动设备或网页浏览器）上运行，方法是点击**主工具栏**上的**平台（Platforms）**按钮，然后选择你想运行游戏的平台。 请注意，你需要首先安装所有必需的软件。

如需详细了解如何在不同的平台上运行虚幻引擎游戏，请参阅以下页面：

- [运行和模拟](../../../understanding-the-basics/playing-and-simulating/index.md)
- [在虚幻编辑器中管理平台](../../../production-pipeline/automating-platform-and-sdk-management-with-unr-f911fd03/using-the-platforms-dropdown-in-unreal-editor/index.md)

### 虚幻引擎使用什么测量单位？

在Unity中，主要的测量单位是一米。 在虚幻引擎中，主要测量单位是一厘米。

因此，在Unity中移动一个单位（米）相当于在虚幻引擎中移动100个单位（厘米）。

如果你想在Unity中移动2英尺，那就是0.61个单位（米）。 在虚幻引擎中，这相当于61个单位（厘米）。

### 在虚幻引擎的坐标系中，哪个方向是上？

Unity和虚幻引擎都使用左手坐标系，但坐标轴的命名方式不同。 在虚幻引擎中，X的正方向是"前"，Y的正方向是"右"，Z的正方向是"上"。

如需更多信息，请参阅[坐标系与空间](https://dev.epicgames.com/documentation/unreal-engine/coordinate-system-and-spaces-in-unreal-engine?application_version=5.7)。

### 如何查看游戏的输出日志？

点击**底部工具栏**中的**输出日志（Output Log）**按钮。

### 如何抛出异常？

不同于Unity，虚幻引擎并不处理异常。 请改用`check()`函数来触发严重的断言错误。 你可以传入错误信息提示。 如果你想报告错误，但不希望打断程序，请改用`ensure()`。 这将记录一个带有完整调用堆栈的错误信息，但程序会继续执行。 如果你附加了调试器，那么这两个函数都会中断并进入调试器。

### .NET Framework在哪里？

不同于Unity，虚幻引擎并不使用.NET Framework。 虚幻引擎有自己的一套容器类和库。 下面列出了常见的容器比较：

| .NET Framework | 虚幻引擎 |
| --- | --- |
| String | [FString](https://docs.unrealengine.com/latest/INT/API/API/Runtime/Core/Containers/FString)、[FText](https://docs.unrealengine.com/latest/INT/API/API/Runtime/Core/Internationalization/FText) |
| List | [TArray](https://docs.unrealengine.com/latest/INT/API/API/Runtime/Core/Containers/TArray) |
| Dictionary | [TMap](https://docs.unrealengine.com/latest/INT/API/API/Runtime/Core/Containers/TMap) |
| HashSet | [TSet](https://docs.unrealengine.com/latest/INT/API/API/Runtime/Core/Containers/TSet) |

[点击此处](../../../cpp-programming/containers/index.md)详细了解虚幻引擎其他容器。

### 代码更改时虚幻引擎是否会自动重新加载？

会！ 你在编写代码时，可以将编辑器保持开启的状态。 完成代码编辑后，从Visual Studio启动编译，编辑器将自动"热重新加载"你的更改。

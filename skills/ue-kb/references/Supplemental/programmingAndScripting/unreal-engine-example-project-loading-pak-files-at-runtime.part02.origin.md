# 示例项目：在运行时加载 Pak 文件 (Part 2/2)

Source file: `unreal-engine-example-project-loading-pak-files-at-runtime.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 二、项目概况

- 内容文件夹 - BP_PakLoader 是一个示例蓝图，演示如何在运行时应用程序中加载外部 Pak 文件 - PakTest（级别）是应用程序的主级别 - UI_PakTest 是一个包含用户界面元素的内容和逻辑的小组件蓝图。它实现 BP_PakLoader 函数 - C++ 类/PakDemo - BFL_Pak（蓝图函数库）是使用虚幻引擎 API 实现 Pak 处理蓝图功能的 C++ 代码 - PakTest 关卡内容 - 照明文件夹包含用于照亮关卡的各种灯光演员。 - BP_PakLoader 是在关卡中实现蓝图逻辑的关卡 Actor。 - 摄像机演员是一个摄像机，可确保我们的玩家处于预期的视角。 - 目标点是一个角色，用于设置生成 Pak 内容的位置。 - 关卡蓝图 本文档旨在介绍项目内容和 C++ 编程语言的细节。作为快速参考，BFL_Pak.h 头文件将显示在虚幻引擎中注册的公开暴露的 UFUNCTIONS。这与上面屏幕截图中列出的蓝图函数相匹配。这些函数在 BFL_Pak.cpp 文件中实现。在CPP文件中搜索函数名称，您将看到每个函数的工作原理。例如，MountAndRegisterPak 函数如下面的屏幕截图所示。有关虚幻引擎 C++ 编程的更多信息，请参阅[官方文档](https://docs.unrealengine.com/5.2/en-US/programming-with-cplusplus-in-unreal-engine/)。
### 4. 使用蓝图安装 Pak 内容

玩家输入 Pak 文件的文件路径字符串后，按下 Load Pak 按钮会触发 LoadPak 事件（以红色标识）。蓝图逻辑如下： - 在视图中向用户打印一条消息，指示 Pak File：加上路径。 - 为 PakFilePath 设置一个变量以在蓝图范围内使用 - 检查是否已加载 Pak 文件，如果存在则提醒用户。 - 这不是虚幻引擎的限制，它只是此应用程序的设计决策，其中只需要一个 Pak，因此在丢失 Pak 引用的跟踪之前进行验证。 - 由于单个 Actor 实例是关卡中 Pak 内容的一个生成器，因此是否可以在关卡中放置更多实例并以更动态的方式与它们交互。 - 如果当前没有加载 Pak，则使用 Pak 文件路径作为输入变量来调用 C++ 函数“Mount and Register Pak”。 - 此安装操作的结果作为消息打印给用户，并将操作的成功传递到分支进行验证。
### 5. 生成 Pak 内容

- 当安装成功时，Pak 内容将使用 Get Pak Content C++ 函数作为数组传递到 For Each 循环中。 - 对于每个数组元素，都会对包含关键字“BP_UeLogo”的内容进行子字符串搜索。 - 当遇到这种情况时，它将把 Preview Pak Path 变量设置为内容的路径并打破循环。 - 当循环中断或自然完成时，有一个分支来验证 Preview Pak Path 不为空。 - 然后使用 Cast To Actor 来确保内容属于生成器函数所需的 Actor 类。 - SpawnActor 蓝图函数用于在目标位置生成内容。 - 目标是引用关卡上的参与者的公共变量。 - 此引用为 SpawnActor 提供了一个变换位置，以供其放置生成的内容。 - 玩家收到 Pak 已加载的消息。
### 6. 摧毁演员并卸下 Pak

- 当按下用户界面中的 Clear Pak 按钮时，它会调用蓝图中的“ClearPak”事件。 - 首先，我们验证 Pak 资产是否有效，如果无效，玩家会收到“NOTHING TO CLEAR！”消息打印到视图中。 - 如果 Pak 资产有效： - 玩家会收到“清除资产：”以及打印到视图中的 Pak 资产消息的显示名称。 - Pak 资产的显示名称返回...
### 7. 管道方法
### 8. UI 元素逻辑
### 概括：
## 相关链接

- [Cooking Content from the Command Line](https://docs.unrealengine.com/5.2/en-US/cooking-content-in-unreal-engine)
- [C++ Programming In Unreal Engine](https://docs.unrealengine.com/5.2/en-US/programming-with-cplusplus-in-unreal-engine)
- [Blueprint Interfaces](https://docs.unrealengine.com/5.2/en-US/blueprint-interface-in-unreal-engine)
- [Paking and Chunking: Cooking Content and Building .pak Files for Distribution](https://docs.unrealengine.com/5.2/en-US/cooking-content-and-creating-chunks-in-unreal-engine)
- [Patching Overview: Creating updated content packages for updating your project after release.](https://docs.unrealengine.com/5.2/en-US/updating-unreal-engine-projects-with-patches-after-release)
- [Signing and Encryping Pak files: Project-Crypto](https://docs.unrealengine.com/5.2/en-US/packaging-unreal-engine-projects#signingandencryption)
- [Project Packaging: Advanced Settings](https://docs.unrealengine.com/5.2/en-US/packaging-unreal-engine-projects#advancedsettings)
- [Referencing Assets: Control how an asset is referenced and loaded into memory.](https://docs.unrealengine.com/5.2/en-US/referencing-assets-in-unreal-engine)
- [Project Files](https://epicgames.box.com/s/hecu7ew61l3yu9smc5ll44vp8xdbdtgz)

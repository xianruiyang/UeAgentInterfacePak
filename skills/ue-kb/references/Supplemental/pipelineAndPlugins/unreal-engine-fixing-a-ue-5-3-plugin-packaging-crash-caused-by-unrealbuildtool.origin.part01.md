# unreal-engine-fixing-a-ue-5-3-plugin-packaging-crash-caused-by-unrealbuildtool.origin (Part 1/2)

Source file: `unreal-engine-fixing-a-ue-5-3-plugin-packaging-crash-caused-by-unrealbuildtool.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

# 修复 UnrealBuildTool 导致的 UE 5.3 插件打包崩溃问题

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/5E8b/unreal-engine-fixing-a-ue-5-3-plugin-packaging-crash-caused-by-unrealbuildtool

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 11329 字符。

## 摘要

本文记录了由 UnrealBuildTool 的 ModuleRules.IsValidForTarget 内的 ArgumentNullException 引起的棘手的虚幻引擎 5.3 插件打包失败。它逐步诊断问题，解释陈旧的 ModuleRules 程序集和 UBT 对模块属性的反射如何触发崩溃，并展示如何通过强化 IsValidForTarget、删除缓存的 *Rules.dll 文件以及通过 dotnet 手动重建 UBT 来修复它。其结果是为复杂的 C++ 插件提供了可靠的打包管道，您可以通过实用的步骤来解决自己项目中类似的构建时崩溃问题。

## 中文整理

### 有关 ModuleRules.IsValidForTarget 中 ArgumentNullException 的故事

当您在虚幻引擎 5.3 中构建复杂的插件时，没有什么比打包过程在编译任何 C++ 代码之前就失败更令人沮丧的了。这就是打包我们的 **A3DC_Renderer** 插件时发生的情况：UnrealBuildTool (UBT) 因 .NET 异常而崩溃，早在编译器有机会抱怨我们的代码之前。本文是该问题的事后分析： - 确切的错误签名 - 为什么这不是你的插件的错 - UnrealBuildTool 内部出了什么问题 - 如何通过以下方式修复它： - 修补 UBT（空安全 ModuleRules） - 清除缓存的规则 DLL - 通过命令行手动重建 UBT - 最后，确认构建管道再次端到端工作

### 1. 症状：打包在 UnrealBuildTool 中失效

该插件在编辑器中构建得很好。但是当通过 **BuildPlugin** / UAT 打包插件时，过程是这样结束的：

```
Unhandled exception: System.ArgumentNullException: 
Value cannot be null. (Parameter 'element')
   at System.Attribute.GetCustomAttributes(MemberInfo element, Type attributeType, Boolean inherit)
   at System.Reflection.CustomAttributeExtensions.GetCustomAttributes[T](MemberInfo element)
   at UnrealBuildTool.ModuleRules.IsValidForTarget(Type ModuleType, ReadOnlyTargetRules TargetRules, String& InvalidReason)
   at UnrealBuildTool.UEBuildTarget.AddAllValidModulesToTarget(...)
   ...
```

一些重要的观察结果： - 崩溃发生在 UBT 内部，而不是游戏/插件代码中。 - 尚未编译任何插件源文件。 - 即使是新的宿主项目也无济于事。 - 即使删除插件后，UBT 仍然在日志中提到旧模块（过时的元数据）。这强烈指出了**UBT 模块规则发现**中的问题，而不是项目代码中的问题。

### 2. UBT 崩溃时会做什么

在目标创建期间，UBT 扫描并过滤所有可用的模块规则，以确定哪些模块对当前构建目标有效。从概念上讲，它做了这样的事情：

**这些文件位于.cs (C#) 格式，但由于 EDC 规则，C# 不能在 UE 文章中使用。**

```cpp
public static bool IsValidForTarget(Type ModuleType, ReadOnlyTargetRules TargetRules, out string InvalidReason)
{
    var supportedTypes = ModuleType
        .GetCustomAttributes<SupportedTargetTypesAttribute>()
        .SelectMany(x => x.TargetTypes)
        .Distinct();

    // ...
}
```

关键一点：由于陈旧/损坏/缓存的规则元数据或有问题的插件模块，ModuleType 最终可能为 **null**。发生这种情况时，对 GetCustomAttributes 的调用会抛出：

```
ArgumentNullException: Value cannot be null. (Parameter 'element')
```

那时，UBT 不会恢复。它崩溃了，打包过程停止了。

### 3. 为什么在插件打包期间（而不是正常的编辑器构建期间）出现这种情况

普通编辑器构建不会像插件打包那样积极地使用相同的路径。当你跑步时：

```
RunUAT.bat BuildPlugin -Plugin="...\MyPlugin.uplugin" -Package="...\Packaged\MyPlugin"
```

UBT： - 将您的插件复制到临时 HostProject 中。 - 编译或加载规则程序集： - 引擎规则：Engine\Intermediate\Build\BuildRules\UE5Rules.dll Engine\Intermediate\Build\BuildRules\UE5ProgramRules.dll - 项目规则：HostProject\Intermediate\Build\BuildRules\HostProjectModuleRules.dll - 插件规则：Plugins\<PluginName>\Intermediate\Build\BuildRules\<PluginName>ModuleRules.dll - 反映所有规则模块针对当前目标进行规则和过滤。如果这些规则程序集中任何一个**过时**、包含无效元数据或引用已删除的模块，则 UBT 可能会生成 null ModuleType，然后在读取属性时崩溃。

### 4. 具体环境

在这种情况下，设置是： - UE 5.3启动器构建（Windows） - 安装了多个工具链版本的Visual Studio 2022 - 插件：**A3DC_Renderer**（C++ +编辑器模块，自定义渲染+雕刻管道） - 打包路径：E:\UEPkg\Packages\A3DC_Renderer\ 早期日志显示UBT列出了**大量模块**（包括许多项目未使用的模块），然后因ArgumentNullException而死亡ModuleRules.IsValidForTarget。

### 5. 修复第 1 部分 – 修补 ModuleRules.IsValidForTarget

对于高级用户来说，可以舒适地编辑引擎源代码（推荐用于引擎叉/内部设置）。打开：Engine/Source/Programs/UnrealBuildTool/Configuration/ModuleRules.cs 找到 IsValidForTarget(...) 并在顶部添加一个**空防护**，以及一个安全的属性读取块。

### 建议补丁

**这些文件位于.cs (C#) 格式，但由于 EDC 规则，C# 不能在 UE 文章中使用。**

```cpp
public static bool IsValidForTarget(Type ModuleType, ReadOnlyTargetRules TargetRules, out string InvalidReason)
{
    // NEW: Guard against null ModuleType
    if (ModuleType == null)
    {
        InvalidReason = "Null ModuleType encountered while scanning module rules.";
        return false;
    }

    InvalidReason = string.Empty;
```

**结果：** - 当遇到损坏/过时的模块时，UBT 不再崩溃。 - 有问题的模块被简单地标记为无效并被跳过。 - 插件打包可以继续进行，如果有任何错误，您会收到正常的构建错误。

### 6. 修复第 2 部分 – 强制 UBT 重新生成规则程序集（删除 DLL）

无论您是否修补 UBT，通常都需要**清除过时的规则程序集**，以便 UBT 重新生成它们。

### 6.1.关闭 Unreal 和任何 UAT/UBT 进程

确保： - 虚幻编辑器已关闭 - 没有 dotnet.exe / UnrealBuildTool.dll / RunUAT.bat 仍在运行

### 6.2.删除引擎规则程序集

导航到您的引擎安装，例如：C:\Program Files\Epic Games\UE_5.3\Engine\Intermediate\Build\BuildRules\ 删除： - UE5Rules.dll - UE5ProgramRules.dll 不要担心 - UBT 会在下一个版本中重新生成这些。

### 6.3.删除项目和插件规则程序集

对您的项目和插件执行相同的操作： - 对您的项目和插件执行相同的操作：<YourProject>\Intermediate\Build\BuildRules\HostProjectModuleRules.dll - 插件（来自您的实际项目，而不是打包的副本）：<YourProject>\Plugins\A3DC_Renderer\Intermediate\Build\BuildRules\A3DC_RendererModuleRules.dll 如果您正在使用 BuildPlugin 创建的 **HostProject**，则可以请参阅以下等效 DLL： - E:\UEPkg\Packages\A3DC_Renderer\HostProject\Intermediate\Build\BuildRules\ - E:\UEPkg\Packages\A3DC_Renderer\HostProject\Plugins\A3DC_Renderer\Intermediate\Build\BuildRules\ 如果需要，也删除它们。

### 6.4.下一个构建会重新生成所有内容

在下一次打包尝试时，UBT 将记录如下内容：

```
Compiling ...\HostProject\Intermediate\Build\BuildRules\HostProjectModuleRules.dll: Assembly does not exist
Compiling ...\Plugins\A3DC_Renderer\Intermediate\Build\BuildRules\A3DC_RendererModuleRules.dll: Assembly does not exist
```

这正是您想要的 - **新的规则组件**。

### 7. 修复第 3 部分 – 从命令行手动重新编译 UBT

除了删除规则 DLL 之外，我们还从命令行**手动重建 UnrealBuildTool**，以确保 UBT 本身处于干净状态。

### 7.1.打开开发人员命令提示符

使用**“VS 2022 的开发人员命令提示符”**（或任何在 PATH 上有 dotnet 的 shell）。

### 7.2.导航至 UBT 源

```
cd "C:\Program Files\Epic Games\UE_5.3\Engine\Source\Programs\UnrealBuildTool"
```

### 7.3.清理并重建

```
dotnet clean
dotnet build -c Development
```

这将重新生成 UnrealBuildTool.dll 并更新它所需的任何依赖程序集。从那时起，所有 RunUAT.bat BuildPlugin ... 运行都使用 **新重建的 UBT**，并结合步骤 6 中的新规则程序集。

### 8. 修复后打包 – 健康日志和成功构建

一旦： - ModuleRules.IsValidForTarget 被强化 - 规则 DLL 缓存被清除 - UBT 通过 dotnet build 重建 插件打包过程开始按预期工作。现在，典型的运行显示 UBT 干净利落地完成其工作：

```
UATHelper: Package Plugin Task (Windows): Building plugin for host platforms: Win64
UATHelper: Package Plugin Task (Windows): Running: ... UnrealBuildTool.dll UnrealEditor Win64 Development ...
...
UATHelper: Package Plugin Task (Windows): Reflection code generated for UnrealEditor in 2.04 seconds
UATHelper: Package Plugin Task (Windows): Building UnrealEditor...
...
[3/10] Compile [x64] SharedPCH.UnrealEd.Cpp20.cpp
[4/10] Compile [x64] Module.A3DC_RendererEditor.cpp
[5/10] Link   [x64] UnrealEditor-A3DC_RendererEditor.lib
[6/10] Compile [x64] Module.A3DC_Renderer.cpp
```

关于 Json.h 是一个整体标头的小警告是无关的，只是提醒您将来切换到更细粒度的包含：

```
Json.h(10): warning: Monolithic headers should not be used by this module.
```

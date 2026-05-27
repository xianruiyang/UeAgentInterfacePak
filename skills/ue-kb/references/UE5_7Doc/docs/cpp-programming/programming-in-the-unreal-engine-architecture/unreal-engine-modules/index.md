---
title: "虚幻引擎模块"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-modules"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "虚幻引擎模块"]
---

# 虚幻引擎模块

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 虚幻引擎模块

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-modules

**模块（Modules）** 是 **虚幻引擎（UE）** 的软件架构的基本构建块。它们在独立的代码单元中 *封装* 了具体的编辑器工具、运行时功能、库或其他功能。

所有项目和插件在默认情况下都有自己的 **主模块（primary module）**，但是，你可以在它们外部定义其他模块，以整理你的代码。

本页面将概述模块是如何构造的，以及模块可以为你的虚幻引擎项目带来哪些好处。

> [!NOTE]
> 虚幻引擎模块与C++ 20模块无关。

## 使用模块的好处

使用模块整理项目可带来以下好处：

- 模块会强制实施良好的代码分离，可用于封装功能并隐藏代码的内部成分。
- 模块编译为单独的编译单元。这意味着，只有已更改的模块才需要编译，较大项目的编译时间会显著缩短。
- 模块在依赖性图表中链接在一起，并且仅允许实际使用的代码包含头文件，以符合[Include What You Use (IWYU)](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-build-tool/include-what-you-use-iwyu-for-unreal-engine-programming/index.md)标准。这意味着，你的项目中未使用的模块将安全地排除在编译之外。
- 你可以控制在运行时何时加载和卸载具体的模块。这样一来，可以管理哪些系统可用并激活，从而优化项目的性能。
- 你可以基于特定条件（例如，项目是为哪个平台编译的），在你的项目中纳入或排除模块。

总结起来，如果你遵守模块的最佳实践，相较于将项目代码全部放在一个模块中而言，你的项目代码会更加井然有序，能更高效地编译，并且可复用程度更高。

## 设置模块

下面概述了如何从头开始构建和实现模块。如果执行以下步骤，你将创建独立于项目默认包含的主模块的Gameplay模块。

1. 在项目的 **源（Source）** 文件夹顶级为你的模块创建目录。该目录应该与你的模块同名。

   > [!TIP]
   > 你可以将模块放在源（Source）文件夹下任意级数的子目录中。这样一来，就可以使用子目录对模块分组。
2. 在模块的根目录中创建 `[ModuleName].Build.cs` 文件，并使用它来定义与其他模块的依赖性。这样一来，虚幻引擎构建系统就可以发现你的模块。
3. 在你的模块的根目录中创建 **Private** 和 **Public** 子文件夹。
4. 在你的模块的Private子文件夹中创建 `[ModuleName]Module.cpp` 文件。使用此文件可提供启动和关闭模块的方法，以及虚幻引擎用于管理模块的其他常用函数。
5. 要控制模块的加载方式和时间，请在 `.uproject` 或 `.uplugin` 文件中为你的模块添加配置信息。这包括模块的名称、类型、兼容平台和加载阶段。
6. 在 `Build.cs` 文件中将你的模块列为需要使用它的模块的依赖性。这可能包括项目主模块的 `Build.cs` 文件。
7. 只要你修改 `[ModuleName].Build.cs` 文件，或在文件夹之间移动源文件，就需要为IDE生成解决方案文件。你可以使用以下某个方法来执行此操作：

   1. 运行 `GenerateProjectFiles.bat`。
   2. 右键点击项目的 `.uproject` 文件，然后点击 **生成项目文件（Generate Project Files）**。
   3. 在虚幻编辑器中，点击 **文件（File）** > **刷新（Refresh）** **Visual Studio** **项目（Project）**。

有关这些组件及其配置方法的更多细节，请继续阅读本页。有关设置模块的详细操作说明，请参阅[创建Gameplay模块](how-to-make-a-gameplay-module/index.md)。

## 理解模块的结构

所有模块都应放在插件或项目的 **源（Source）** 目录中。模块的根文件夹应与对应模块同名。

对于每个模块，其根文件夹中还应该有一个 `[ModuleName].Build.cs` 文件，并且其C++代码应该包含在 **Private** 和 **Public** 文件夹中。

下面是模块的推荐文件夹结构示例：

- [ModuleName]

  - Private

    - [ModuleName]Module.cpp
    - 所有.cpp文件和私有头文件
  - Public

    - 所有公共头文件
  - [ModuleName].Build.cs

### 在Build.cs文件中配置依赖性

虚幻引擎构建系统会根据项目中的 `Target.cs` 文件和模块中的 `Build.cs` 文件构建项目，而不是根据IDE的解决方案文件构建。

编辑代码时会自动生成IDE解决方案，但虚幻编译工具(UBT)在编译项目时会将其忽略。

所有模块都需要将一个 `[ModuleName].Build.cs` 文件放入模块的根目录，虚幻引擎构建系统才能识别这些模块。

在你的 `[ModuleName].Build.cs` 文件中，需要将你的模块定义为从ModuleRules类继承的类。下面是简单 `Build.cs` 文件的示例：

示例ModuleTest.Build.cs文件

```
	using UnrealBuildTool; 	public class ModuleTest: ModuleRules 	{ 	public ModuleTest(ReadOnlyTargetRules Target) : base(Target) 	{ 	PrivateDependencyModuleNames.AddRange(new string[] {"Core"}); 	} 	} 
```

配置 `Build.cs` 文件时，你将主要使用 `PrivateDependencyModuleNames` 和 `PublicDependencyModuleNames` 列表。若将模块名称添加到这些列表，则会设置模块的代码可用的那些模块。

例如，如果你将"Slate"和"SlateUI"模块名称添加到私有依赖性列表，就能够在你的模块中包含Slate UI类。

### 私有和公共依赖性

如果你公开使用模块中的类（如公共 `.h` 文件中的类），就应该使用 `PublicDependencyModuleNames` 列表。这样一来，依赖于你的模块的其他模块就可以包含你的头文件，不会造成问题。

如果模块仅以私有方式使用（例如在 `.cpp` 文件中），你应该将模块的名称放在 `PrivateDependencyModuleNames` 列表中。尽可能首选私有依赖性，因为可以缩短项目的编译时间。

> [!TIP]
> 你可以在头文件中使用前向声明，将许多依赖性设置为私有而不是公共。

### 使用私有和公共文件夹

如果你的模块是常规C++模块（意味着 `ModuleType` 在你的 `.uproject` 或 `.uplugin` 中未设置为 `External`），其C++文件应该放在模块根目录中的私有（Private）和公共（Public）子文件夹中。

这些与C++代码中的 `Private`、`Public` 或 `Protected` 访问权限说明符无关。它们实际上用于控制模块代码对于其他模块的可用性。如果你使用这些文件夹，所有 `.cpp` 文件都应该放在私有（Private）文件夹中。根据下面的指南，头文件(`.h`)应该放在私有（Private）和公共（Public）文件夹中。

如果你将头文件放在私有（Private）文件夹中，其内容仅会向其所属的模块公开。该文件夹中的类、结构体和枚举可供同一模块中的其他类访问，但不可用于其他模块中的类。

如果你将头文件放在公共（Public）文件夹中，虚幻引擎构建系统会向依赖于当前模块的其他全部模块公开其内容。外部模块中的类将能够扩展公共（Public）文件夹中包含的类，并且你还将能够使用公共（Public）文件夹中的类、结构体和枚举创建变量和引用。`Private`、`Public` 和 `Protected` 说明符将对于函数和变量正常生效。

如果你要工作的模块不会成为其他模块的依赖性，就不需要使用 `Private` 和 `Public` 文件夹。这些文件夹外部的所有代码的行为都如同是私有（Private）一般。这种情况的典型示例是游戏的主模块，它很可能位于依赖性链条的末尾。

你可以在 `Private` 和 `Public` 文件夹中创建子文件夹，进一步整理代码。对于你在 `Public` 中创建的新文件夹，请在 `Private` 中创建同名的对应文件夹。同样，对于你放在 `Public` 中的头文件，须将对应 `.cpp` 文件始终放在 `Private` 中的对应文件夹中。

如果你在虚幻编辑器中使用"新建类向导"创建新类，该向导将自动确保在这些文件夹之间并行构造。

### 在C++中实现模块

若要向C++项目的其余部分公开一个模块，你需要创建一个扩展 `IModuleInterface` 的类，然后将该类提供给 `IMPLEMENT_MODULE` 宏。

对于最简单的实现，你可以在模块的私有（Private）目录中创建一个 `.cpp` 文件，并将其命名为 `[ModuleName]Module.cpp`，其中 `[ModuleName]` 是模块的名称。接着，在其他所有 `#include` 声明之后调用 `IMPLEMENT_MODULE` 宏，然后提供 `FDefaultModuleImpl` 作为类。

ModuleTestModule.cpp

```
	#include "Modules/ModuleManager.h" 	IMPLEMENT_MODULE(FDefaultModuleImpl, ModuleTest); 
```

`FDefaultModuleImpl` 是一个扩展 `IModuleInterface` 的空类。对于更详细的实现，你可以在该 `.cpp` 文件中编写自己的类来实现。

`IModuleInterface` 有几个函数会在你的模块加载和卸载时触发，类似于 `GameInstance**` ** 类中的 `Startup` 和 `Shutdown` 函数。

## 在你的项目中使用模块

只要你创建新的虚幻引擎项目或插件，它就会自动设置自己的主模块，你可以在项目的 `Source` 文件夹中找到。你可以在项目中包含外部模块，方法是将它们添加到项目主模块的 `Build.cs` 文件。

例如，要在名为MyProject的项目中使用Gameplay Tasks系统，你需要打开 `MyProject.Build.cs`，然后添加"GameplayTasks"模块作为依赖性。

为了优化编译速度，虚幻编译工具仅编译在项目的依赖性链条中找到的模块。这意味着，如果一个模块未纳入项目所使用的 `Build.cs` 文件，编译期间会跳过该模块。

## 控制模块如何加载

你的 `.uproject` 和 `.uplugin` 文件包含一个 `模块` 列表，该列表定义了哪些模块会纳入你的项目，以及模块的加载方式。

当你重新生成项目文件时，如果你已将模块纳入依赖性链条，那么模块的条目将自动添加到该列表（如果这些条目尚不存在）。该列表中的条目类似于以下内容：

```
	"Modules": [ 		{ 			"Name": "ModuleTest", 			"Type": "Runtime", 	"LoadingPhase": "Default", 		}, 	{ 	"Name": "ModuleTestEditor", 	"Type": "Editor", 	} 	] 
```

大部分Gameplay模块将直接列出 **名称（Name）**，而 **类型（Type）** 将设置为 `运行时`。如果 **LoadingPhase** 未定义，将设置为 `Default`。有各种各样的其他模块类型、加载阶段和额外参数可控制模块将在哪些平台上加载，不会在哪些平台上加载。

有关可用模块类型的信息，请参阅[EHostType::Type](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Projects/EHostType__Type)的API文档

最常见的模块类型是 `运行时` 和 `编辑器`，它们分别用于游戏内的类和仅限编辑器的类。

有关加载阶段的更多信息，请参阅[ELoadingPhase::Type](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Projects/ELoadingPhase__Type)的API文档

> [!NOTE]
> 虽然 `Default` 加载阶段适合项目中的大多数Gameplay模块，插件有时需要提早加载。如果你经常看到虚幻编辑器尝试在插件中查找C++类时出错，请尝试将其设置为 `PreDefault`。

该列表使用的其他参数包括以下参数：

| 参数 | 说明 |
| --- | --- |
| IncludelistPlatforms / ExcludelistPlatforms（数组） | 纳入或排除模块，用于在列出的平台上编译。平台字符串示例包括 `Win32`、`Win64`、`Mac`、`Linux`、`Android` 和 `IOS`。 |
| IncludelistTargets / ExcludelistTargets（数组） | 纳入或排除模块，用于在列出的编译目标上编译。可用的编译目标是 `Game`、`Server`、`Client`、`编辑器` 和 `Program`。 |
| IncludelistTargetConfigurations / ExcludelistTargetConfigurations（数组） | 纳入或排除模块，用于在列出的编译配置上编译。可用的目标配置是 `Debug`、`DebugGame`、`Development`、`Shipping` 和 `Test`。 |
| IncludelistPrograms / ExcludelistPrograms（数组）： | 纳入或排除模块，用于在特定程序名称下编译。 |
| AdditionalDependencies（数组）： | 指定模块所需的额外依赖性。你应该改为在你的 `Build.cs` 文件中进行指定。 |

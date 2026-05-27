---
title: "创建Gameplay模块"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-make-a-gameplay-module-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "虚幻引擎模块", "创建Gameplay模块"]
---

# 创建Gameplay模块

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 虚幻引擎模块 / 创建Gameplay模块

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-make-a-gameplay-module-in-unreal-engine

**虚幻引擎（UE）中的模块** 很适合用于组织代码，缩短项目的编译时间，以及为系统和代码配置其加载和卸载过程。本指南将涵盖在C++中从头开始实现新的运行时模块所需的步骤。该模块将独立于项目的 **主模块**。

该示例中的模块名为 **ModuleTest**。

## 必要设置

要按照本指南操作，请首先创建名为 **MyProject** 的新项目，必须是 **C++项目**。如果你要使用仅限蓝图的项目按照本指南操作，请在虚幻编辑器中创建一段新的C++代码，以将其转换为C++项目。

## 设置目录

首先，你需要设置目录以包含该模块及其代码。

1. 找到项目的根目录，然后打开 **源（Source）** 文件夹。
2. 在项目的源（Source）文件夹中，创建名为 **ModuleTest** 的新文件夹。这将用作该模块的根目录。
3. 在该模块的根目录中，创建名为 **Private** 和 **Public** 的两个新文件夹。

你的目录结构应该类似于以下内容：

- MyProject

  - Source

    - MyProject.Target.cs
    - MyProjectEditor.Target.cs
    - MyProject（主游戏模块文件夹）

      - Private
      - Public
      - MyProject.Build.cs
      - 游戏模块中的其他C++类
    - ModuleTest

      - Private
      - Public

## 创建Build.cs文件

**虚幻编译工具(UBT)（Unreal Build Tool (UBT)）** 在项目的目录中查找依赖性时，会忽略你的IDE解决方案文件，改为查看源（Source）文件夹中的 `Build.cs` 文件。每个模块都必须有 `Build.cs` 文件，否则不会被UBT发现。

要设置 `Build.cs` 文件，请执行以下步骤：

1. 在模块的根目录中创建名为 `ModuleTest.Build.cs` 的文件。打开此文件并添加以下代码：

   ModuleTest.Build.cs

   ```
    using UnrealBuildTool;  public class ModuleTest: ModuleRules {         public ModuleTest(ReadOnlyTargetRules Target) : base(Target)         {          } } 
   ```

   这将使你的模块对虚幻引擎构建系统可见。
2. 编辑构造函数，使其内容如下所示：

   ModuleTest.Build.cs

   ```
    public ModuleTest(ReadOnlyTargetRules Target) : base(Target) {      PrivateDependencyModuleNames.AddRange(new string[] {"Core", "CoreUObject", "Engine"});  } 
   ```

   这会将 `Core`、`CoreUObject` 和 `Engine` 模块添加为你的模块的私有依赖性。这将使多个类可用于该模块，以执行本指南中的后续步骤。

现在，如果你将代码添加到该模块的文件夹，当UBT编译项目时，以及每当你生成IDE项目文件时，都会发现该代码。

## 在C++中实现你的模块

虽然 `Build.cs` 文件使你的模块可被UBT发现，但你的模块还需要实现为C++类，以便引擎可以进行加载和卸载。

幸好虚幻引擎包括了宏，可以为大多数常见的实现简化这个过程。要快速创建实现文件，请执行以下步骤：

1. 找到模块的根目录，然后打开 `Private` 文件夹。在该文件夹中创建名为 `ModuleTestModule.cpp` 的新文件。不需要为该类创建 `.h` 文件。

   > [!TIP]
   > [ModuleName]Module是虚幻引擎源代码中的模块实现文件的典型命名规范。这很适合在大型代码库中对其进行跟踪。
2. 在 `ModuleTestModule.cpp` 中，添加以下代码：

   ModuleTestModule.cpp

   ```
    #include "Modules/ModuleManager.h"  IMPLEMENT_MODULE(FDefaultModuleImpl, ModuleTest); 
   ```

这为你的模块提供了默认实现，使其可用于C++代码。

你可以手动编写该模块的类、其构造函数以及启动和关闭函数，创建更详细的实现。但是，对于大部分Gameplay模块，此默认实现对于加载和卸载你的模块是足够的。

## 编译你的模块

### 将模块作为项目的一部分编译

定义和实现你的模块后，编译过程非常简单。

1. 右键点击 `MyProject.uproject`，然后点击 **生成Visual Studio文件（Generate Visual Studio Files）** 以重新生成IDE解决方案。这将确保你的新模块在IDE以及虚幻编辑器中可见。

   > [!NOTE]
   > 只要你改写模块的代码或更改其 `Build.cs` 文件的内容，就应该重新生成IDE解决方案，确保它保持最新。
2. 在Visual Studio中编译你的项目。你的新模块将一起编译。

   只要你手动添加新模块，更改模块的目录结构，移动或重命名C++文件，或更改模块的依赖性，就应该重新生成项目文件，以更新Visual Studio解决方案，然后重新编译项目。

   > [!NOTE]
   > 尽管你可以在虚幻编辑器运行的同时编译项目，但有时需要关闭虚幻编辑器，然后在编译后将其重启，以使重大更改或新的类生效。

### 仅编译模块

要只编译模块，而非整个项目，请在UE根目录中执行以下命令：

```
	Engine\Build\BatchFiles\Build.bat -Target="<PROJECT_NAME> <PLATFORM> <BUILD_STATE>" -Module="<MODULE_NAME>" -Project="<PATH_TO_UPROJECT>"
```

For example, to build the Core module as part of the `LyraEditor` project on Windows, execute:

```
	Engine\Build\BatchFiles\Build.bat -Target="LyraEditor Win64 Development" -Module="Core" -Project="Samples\Games\Lyra\Lyra.uproject"
```

## 将你的模块包含在你的项目中

你的模块应该能够编译，若要在你的项目中使用模块中的代码，就需要使用 `.uproject` 文件注册该模块，然后为游戏的主模块创建依赖性。

1. 打开 `MyProject` 根目录，然后在文本编辑器中打开 `MyProject.uproject`，并按如下所示编辑你的"Modules"列表：

   MyProject.uproject

   ```
    "Modules": [          {              "Name": "MyProject",              "Type": "Runtime",              "LoadingPhase": "Default"          },          {              "Name": "ModuleTest",              "Type": "Runtime"          }      ] 
   ```

   你可以使用此列表条目来配置它将在哪个 **加载阶段（Loading Phase）** 中加载，以及其 **类型（Type）**。此示例是运行时模块，因此可以在项目作为独立应用程序或在编辑器中运行的同时使用。

   相比较之下，编辑器模块只能在编辑器中运行。它还使用 **默认（Default）** 加载阶段，该阶段在游戏模块加载后进行初始化。根据模块的具体情况，你可能需要使用之前的加载阶段，确保依赖于该模块的其他模块不会在查找卸载的代码时抛出错误。
2. 找到 `MyProject/Source` 文件夹，然后打开 `MyProject.Build.cs` 文件。将 `ModuleTest` 添加到你的 `PublicDependencyModuleNames` 列表。内容应该如下所示：

   MyProject.Build.cs

   ```
        PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "ModuleTest" }); 
   ```

   现在，可以将你的模块中的代码包含在你的主游戏模块中。

## 将代码添加到你的模块

你可以手动将C++文件添加到模块中的 `Public` 和 `Private` 目录，也可以在虚幻编辑器中添加。

你可以按如下步骤使用"新建类向导"，将代码添加到模块：

1. 在虚幻编辑器中打开你的项目。
2. 在内容浏览器中，点击 **添加（Add）**，然后点击 **新建C++类（New C++ Class）**。
3. 选择 **Actor** 作为父类，然后点击 **下一步（Next）**。
4. 找到 **名称（Name）** 字段旁边的下拉菜单。其内容应该默认为 **MyProject (Runtime)**。点击此下拉菜单，然后将其更改为 **ModuleTest (Runtime)**。

   > [!NOTE]
   > 如果看不到"MyModule (Runtime)"选项，请查看之前的分段，确保你正确执行了相应步骤。
5. 将该类命名为 **ModuleActorBase**，将 **类类型（Class Type）** 设置为 **公共（Public）**，然后点击 **创建类（Create Class）**。

   类的 `.h` 和 `.cpp` 文件将自动在IDE中打开。类的 `.cpp` 文件将添加到模块的 `Private` 文件夹，而其`.h` 文件将添加到 `Public` 文件夹。
6. 打开 `ModuleActorBase.cpp`，然后将以下行添加到 `AModuleActorBase::BeginPlay` 函数：

   ModuleActorBase.cpp

   ```
    GEngine->AddOnScreenDebugMessage(0, 5.0f, FColor::Blue, TEXT("Hello, world!")); 
   ```
7. 保存代码并编译你的模块。

该类定义了一个简单的Actor，用于在游戏启动时输出屏幕上的调试消息。你可以使用虚幻编辑器中的 **放置Actor（Place Actors）** 工具测试此情况。

## 8. 扩展你的模块中的代码

最后，执行下面的步骤，测试你的新Actor类以及主游戏模块能否看到该类。

1. 在虚幻编辑器中打开你的项目。创建 **新蓝图类（New Blueprint Class）**，然后展开 **全部类（All Classes）** 列表。
2. 选择 **ModuleActorBase** 作为父类。将你的蓝图类命名为 **ModuleActorBP**。
3. 将ModuleActorBP的副本从内容浏览器拖动到游戏的世界中。点击 **运行（Play）** 按钮。

如果在类列表中看不到ModuleActorBase，请确保其头文件在 `Public` 文件夹中，该类有 `BlueprintType UCLASS` 说明符，并且你已将 `ModuleTest` 模块添加到项目的依赖性。

## 最终结果

点击"运行（Play）"时，你的项目将开始在编辑器中运行，屏幕上将显示蓝色文本格式的调试消息"Hello, world!"。这个基于蓝图的Actor扩展了单独的Gameplay模块中定义的类。将来你编写模块时，就有了充分准备来创建可扩展的类，作为特定于Gameplay的代码的基础。

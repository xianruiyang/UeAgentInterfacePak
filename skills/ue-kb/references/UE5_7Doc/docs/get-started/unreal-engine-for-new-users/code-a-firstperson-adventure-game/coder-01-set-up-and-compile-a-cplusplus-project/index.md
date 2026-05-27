---
title: "设置并编译项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-01-set-up-and-compile-a-cplusplus-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "设置并编译项目"]
---

# 设置并编译项目

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 设置并编译项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-01-set-up-and-compile-a-cplusplus-project-in-unreal-engine

## 开始之前

确保完成如下事项：

- [安装虚幻引擎](../../../install/index.md) 并为虚幻引擎设置[Visual Studio](../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-studio-development-environmen-6a24252b/index.md)
- 了解项目和Actor，以及如何在虚幻编辑器中导航
- 阅读 [编写第一人称冒险游戏](../index.md)

## 从模板开始

本教程将引导你从一项基于蓝图的项目开始。该项目包含了示例资产。 你将逐步添加代码，这些代码可自我复制并依靠现有蓝图功能进行拓展。 通过这种方式，你可以学习在全新的C++项目中编译新的类，同时也可以将等效的蓝图作为参考。

要使用模板创建新游戏项目，请执行以下步骤：

1. 打开虚幻引擎。 打开**虚幻项目浏览器**，转到**游戏（Games）**项目类别，选择**第一人称（First Person）**模板。
2. 转到**项目默认设置（Project Defaults）**，确保项目类型设为**蓝图（Blueprint）**。 这意味着虚幻引擎将使用蓝图类型的默认资产创建项目，而不是使用C++资产。
3. 将**变体（Variant）**设为**竞技场射击游戏（Arena Shooter）**。
4. 命名你的项目。 本教程使用的项目名称为`AdventureGame`。
5. 点击**创建（Create）**以在编辑器中打开新项目。

## 验证增强输入

使用**增强输入系统**，你可以编译自定义输入操作来定义角色可以做的动作（例如跳跃或下蹲等），从而控制角色的移。 所有输入操作都以数据资产的形式存在，而你可以在代码中引用这些数据资产，从而在代码和角色之间进行通信。

在本教程的稍后部分，你还将结合输入操作和代码，让角色可以移动并环顾四周。

你的项目应该已经启用了增强输入系统。 要验证这一点，请执行以下步骤：

1. 打开虚幻编辑器的主菜单，转到**编辑（Edit）**菜单，选择**插件（Plugins）**。
2. 搜索**Enhanced Input**。 这时你应该能看到该插件已安装且已启用。

如需详细了解增强输入系统和输入操作，请参阅[增强输入](../../../../gameplay-systems/input/enhanced-input/index.md)。

## 创建C++游戏模式类

基于蓝图的项目在一开始并不包含任何可用的C++文件或Visual Studio（VS）项目。 接下来，你需要创建第一个类并将C++引入到项目中。 首先，请创建一个自定义游戏模式（Game Mode）类，该类会让虚幻引擎生成Visual Studio项目以及编码所需的文件。 你的自定义类派生自父类 `AGameModeBase`。

**游戏模式**资产定义了游戏的规则、获胜条件以及使用的角色。 游戏模式还设置了项目所用的默认游戏框架类，包括Pawn、PlayerController和HUD等。 在本教程稍后部分，你将使用游戏模式更改默认的玩家角色。

要创建新的游戏模式C++类，请执行以下步骤：

1. 打开虚幻编辑器主菜单，转到**工具（Tools） > 新C++类（New C++ Class）**。
2. 转到**选择父类（Choose Parent Class）**窗口，找到并选择**游戏模式基础（Game Mode Base）**，然后点击**下一步（Next）**。
3. 输入新类的名称，然后点击**创建类（Create Class）**。 本教程使用 `AdventureGameMode`。
4. 这时会出现两条警告提示，表明你需要在VS中编译至少一次项目，之后C++类才会出现在内容浏览器中。 点击**确定（OK）**，然后在第二个警告提示中点击 **是（Yes）**以打开你的代码。

## 编译项目

在开始添加代码之前，请先在VS中编译项目并刷新虚幻编辑器，以此完成环境准备。

### 在Visual Studio中打开项目

如果在你创建游戏模式类后，引擎没有自动提示你在VS中打开项目，那么请在虚幻编辑器的主菜单中找到**工具（Tools）**，然后选择**打开Visual Studio（Open Visual Studio）**。

另外，项目的`.sln`文件默认位置为`/Documents/Unreal Projects/[项目名称]`。

> [!TIP]
> 虚幻引擎会追踪你对项目所做的更改，例如添加新类、模块、插件或修改编译设置等。 但VS项目文件可能不会自动反映这些更新。 使用 **刷新Visual Studio项目（Refresh Visual Studio Project）**（也在**工具（Tools）**菜单中），即可根据当前项目状态重新生成解决方案和项目文件，从而保持更新所有内容。

打开Visual Studio后，你会看到项目文件已经有序地排列在**解决方案浏览器**中。

> [!NOTE]
> 当你在VS中首次打开虚幻引擎C++项目时，你可能会在**解决方案浏览器**中看到一条关于缺少组件的警告。 点击**安装（Install）**，让VS安装项目所需的所有额外组件。

转到**解决方案浏览器**，展开**游戏（Games） > [*项目名称*] > 源（Source） > [*项目名称*]**。 这里就是游戏主要文件的所在位置，包括对应新游戏模式的两个文件，即`[GameModeName].cpp`和`[GameModeName].h`。

### 编译项目并刷新虚幻编辑器

要让虚幻编辑器识别你的代码项目并将你的C++类包含在内容浏览器中，请在VS中编译你的项目，然后重启虚幻编辑器。

要编译项目并使项目类显示在虚幻编辑器中，请执行以下步骤：

1. 在**解决方案浏览器**中，转到**游戏（Games）** > ***[项目名称]***，右键点击项目，选择 **编译（Build）**。
2. 编译完成后，返回虚幻编辑器，检查底部工具栏是否出现了 **编译（Compile）** 按钮，以及内容浏览器中是否出现了新的 C++Classes 文件夹。
3. 如果上述内容没有出现，请关闭编辑器，然后再次打开你的项目。 打开编辑器会重新编译你的项目，向虚幻引擎表明你的C++类已存在。 如果虚幻引擎询问是否要重新编译项目，请点击 **是（Yes）**。

### 禁用实时编码

在再次编译代码之前，请在虚幻编辑器中关闭**实时编码（Live Coding）**。 你可以使用实时编码在引擎运行时更改并重新编译实现（`.cpp`）文件中的C++代码；但是，实时编码遵循不同的编译工作流程，因此在编辑头文件（`.h`）或尝试使用Visual Studio编译时，可能会造成错误。 实时编码在迭代已开发的代码库时很有用，但我们建议在开始新项目时将其禁用。

要关闭实时编码，请转到编辑器的底部工具栏，点击**编译**按钮旁边的三点号，然后禁用**启用实时编码（Enable Live Coding）**。

## 扩展C++类到蓝图

你已经创建了自定义游戏模式，接下来你需要将其扩展到蓝图，从而向编辑器公开其属性，然后将该新蓝图设为项目的默认游戏模式。

将游戏模式类扩展到蓝图即可直接向编辑器公开类的值，而无需通过代码完成各项操作。 蓝图会充当C++类的子类，继承该类的所有功能。

要从你的GameMode类派生蓝图资产，请执行以下步骤：

1. 打开**内容浏览器（Content Browser）**资产树，转到**C++类（C++ Classes） > [*项目名称*]**，找到你创建的C++类。
2. 右键点击你的**游戏模式基础（Game Mode Base）**类，选择**基于[*游戏模式基础名称*]创建蓝图类（Create Blueprint class based on [GameModeBaseName]）**。
3. 转到**添加蓝图类（Add Blueprint Class）**窗口，用`BP_` 开头命名你的蓝图，方便之后识别。 本教程使用`BP_AdventureGameMode`。
4. 至于**路径（Path）**，选择**All**> **Content**> **FirstPerson**> **Blueprints**，然后 点击**创建类（Create Class）**。

   虚幻引擎会自动在新的蓝图编辑器窗口中打开该蓝图。

> [!TIP]
> 将蓝图的选项卡拖到主编辑器窗口中的地图选项卡（**Lvl_FirstPerson**）旁边，即可将新窗口停靠在主编辑器窗口中。
>
> > 动图已省略：96237c705d005b52e3cde4ad289b9b39bbfa4135826142a29c2d0a85434c963f

## 更改项目的游戏模式

默认情况下，新的虚幻引擎项目会使用示例游戏模式。 要将其更改为你的自定义游戏模式，请编辑项目的设置。

要更改默认游戏模式，请执行以下步骤：

1. 打开虚幻编辑器的主菜单，转到**编辑（Edit） > 项目设置（Project Settings）**。
2. 转到左侧面板的**项目（Project）**分段，选择**地图和模式（Maps & Modes）**。
3. 转到设置表格的顶部，将**默认游戏模式（Default GameMode）**更改为你的游戏模式蓝图。
4. 关闭**项目设置（Project Settings）**。
5. 在主菜单中，前往**窗口（Window）**>**世界设置（World Settings）**。 默认情况下，**世界设置（World Settings）**面板会停靠在**细节（Details）**面板旁边。 这些设置可控制当前关卡的行为方式。
6. 在**游戏模式（Game Mode）**分段，将**游戏模式重载（GameMode Override）**设置为你新创建的游戏模式蓝图。

   > [!TIP]
   > 您只需为示例关卡更改**游戏模式重载（GameMode Override）**。 如果你新建空白关卡，**游戏模式重载（GameMode Override）**将被默认设置为**无（None）**。

## 添加屏上调试消息

要在项目中添加代码，一种不错的做法是在屏幕上添加一条"Hello World!"消息。

添加调试消息即可验证你使用的是你的游戏模式，而不是虚幻引擎提供的默认游戏模式。 日志消息和调试消息对于在开发过程中验证和调试代码非常有用。

### 重载默认StartPlay()函数

`AGameModeBase`自带`StartPlay()`函数，当游戏Gameplay就绪时，虚幻引擎会调用该函数。 通常而言，你会在自定义GameMode类中重载该函数，以此添加新的全局游戏启动逻辑。 在此，你需要重载该函数，以便在游戏开始时显示调试消息。

要重载自定义GameMode类中的`StartPlay()`函数，请执行以下步骤：

1. 转到VS，打开你的游戏模式类的 `.h` 头文件。 本教程示例代码所使用的类名称为 `AdventureGameMode`。

   默认代码如下：

   C++

   ```
   UCLASS()class ADVENTUREGAME_API AAdventureGameMode : public AGameModeBase{	GENERATED_BODY()	};
   ```

   `GENERATED_BODY()` 是虚幻头文件分析工具所使用宏，它可以自动生成该类和其他UObject所需的代码以配合虚幻引擎工作。 如需详细了解虚幻头文件分析工具，请参阅 [虚幻头文件分析工具文档](../../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-header-tool/index.md)。

   `AAdventureGameMode` 类会向你的代码公开不同的游戏模式状态，例如游戏开始或结束、进入地图或游戏正在进行中。 每种状态被触发时都会运行相关函数，如 `StartPlay()` 或 `ResetLevel()`。
2. 为你的`AAdventureGameModeBase`类添加`StartPlay()`函数的重载声明。

   C++

   ```
   UCLASS()class ADVENTUREGAME_API AAdventureGameMode : public AGameModeBase{	GENERATED_BODY() 	virtual void StartPlay() override;	};
   ```
3. 保存`.h`文件。

> [!TIP]
> 虚幻引擎的类和函数会使用前缀名向虚幻头文件分析工具告知类的类型。 例如，前缀`A` 代表Actor，`U`代表UObject，`F`代表结构体（Struct）。 如需详细了解虚幻引擎C++类的前缀，请参阅[Epic C++编码标准：命名规范](../../../../cpp-programming/epic-cplusplus-coding-standard/index.md)。

### 为StartPlay()添加调试消息

使用可打印调试消息的某个自定义代码来实现你的`StartPlay()`重载。

要在游戏开始时在屏上打印调试消息，请执行以下步骤：

1. 打开游戏模式的 `.cpp` 文件，实现刚才声明的函数。
2. 为 `StartPlay()`添加一项新的函数定义。 该函数在 `AAdventureGameMode` 中声明，因此请使用`AAdventureGameMode::StartPlay()`定义该函数。

   C++

   ```
   void AAdventureGameMode::StartPlay(){ }
   ```
3. 在 `AMyGameModeBase::StartPlay()`中，添加 `Super::StartPlay()` 以从 `AAdventureGameMode` 父类中调用 `StartPlay()` 函数。 这是处理游戏启动时应运行的其他逻辑所必需的操作。
4. 接下来，为 `GEngine != nullptr` 添加`check`，以确保全局引擎指针有效。

   C++

   ```
   void AAdventureGameMode::StartPlay(){	Super::StartPlay(); 	check(GEngine != nullptr);}
   ```

   这是一个指向虚幻引擎本身所用的UEngine类的指针。检查该指针是否有效，以确保在继续执行代码前游戏运行正常。 如果全局引擎指针无效，游戏将崩溃。
5. 使用`GEngine`访问虚幻引擎的 `AddOnScreenDebugMessage()`成员函数，该函数会在游戏运行时在屏幕上打印消息。

   该函数需要四个值：

   - 一个唯一的整型键，用于识别消息并防止多次添加同一消息。 如果唯一性不重要，则使用`-1`。
   - 用于显示消息的浮点秒数。
   - 用于设定文本颜色的`FColor`。
   - 待打印的`FString`消息。

   使用以下值，即可在游戏开始后，在屏幕上显示时长5秒钟的黄色"Hello World!"消息文本：

   C++

   ```
   GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Hello World, this is AdventureGameMode!"));
   ```
6. 保存 `.cpp` 文件。

现在， `AAdventureGameMode::StartPlay()` 应该如下所示：

C++

```
#include "AdventureGameMode.h" void AAdventureGameMode::StartPlay(){	Super::StartPlay(); 	check(GEngine != nullptr); 	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Hello World!"));}
```

> [!TIP]
> `UE_LOG`函数也对打印调试消息有所帮助。 该函数不会打印屏上消息，而是在运行时将消息记录到虚幻引擎的输出日志或控制台中。 该函数适合用于记录或追踪游戏中发生事项的详细信息。 你可以将日志分类到不同的通道中，并定义消息的类型（如信息消息、错误消息或警告消息等）。 例如： `UE_LOG(LogTemp, Warning, TEXT("This is a warning message!"));`

## 编译并测试代码

在虚幻编辑器中点击**编译（Compile）**按钮即可重新编译项目；但我们建议你使用VS重新编译。 编译完成后，你可以在编辑器和游戏中看到对应的代码更改。

要在游戏中查看你所做的更改，请点击主工具栏中的**运行（Play）**按钮，以启动**在编辑器中运行**（Play in Editor (**PIE**)）模式。 调试消息将在左上角显示。

要退出PIE模式，请按**Shift + Escape**，或点击关卡编辑器工具栏中的**停止**按钮。

## 下一步

现在你已经拥有了一个使用新游戏模式的基础项目，可以开始创建玩家角色了！ 在下一节中，你将创建一个新的角色类，并学习如何使用输入操作为角色添加移动功能按钮。

- [创建具有输入操作的玩家角色](../coder-02-create-a-player-character-with-input-a-9df71be2/index.md) - 学习如何开始编译具有输入操作的C++角色。

## 完整代码

本节中编译的完整代码如下：

C++

AdventureGameMode.h

```
#pragma once

#include "CoreMinimal.h"
#include "GameFramework/GameModeBase.h"
#include "AdventureGameMode.generated.h"

UCLASS()
class ADVENTUREGAME_API AAdventureGameMode : public AGameModeBase
{
	GENERATED_BODY()
```

C++

AdventureGameMode.cpp

```
#include "AdventureGameMode.h" void AdventureGameMode::StartPlay(){	Super::StartPlay(); 	check(GEngine != nullptr); 	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Hello World!"));}
```

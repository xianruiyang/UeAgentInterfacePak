---
title: "配置角色移动"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-03-configure-character-movement-with-cplusplus-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "配置角色移动"]
---

# 配置角色移动

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 配置角色移动

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-03-configure-character-movement-with-cplusplus-in-unreal-engine

## 开始之前

请确保你已经完成了上一节 [创建具有输入操作的玩家角色](../coder-02-create-a-player-character-with-input-a-9df71be2/index.md)中的以下目标：

- 创建角色C++类。
- 学习了输入操作和输入映射上下文的工作原理。

## 学习关联输入与移动

探索一个角色蓝图示例，了解输入操作、输入映射上下文和代码的结合方式，从而产出移动效果。 然后，学会使用代码复制该功能。

### 在蓝图中可视化输入

第一人称模板附带的`BP_FirstPersonCharacter`类很好地展示了蓝图与输入操作的交互方式。

打开**内容浏览器（Content Browser）**资产树，找到**Content > FirstPerson > Blueprints**。 双击`BP_FirstPersonCharacter`类以将其在**蓝图编辑器**中打开。

该蓝图的**事件图表（Event Graph）**位于**蓝图编辑器**的中间位置。 **EventGraph**是一份节点图表，它可利用各种事件和函数调用执行一系列有序的操作，从而响应Gameplay。 此图表中存在针对**摄像机输入（Camera Input）**、**移动输入（Movement Input）**和**跳跃输入（Jump Input）**的节点组。

### 理解跳跃输入逻辑

放大到**跳跃输入（Jump Input）**组。 其中的**EnhancedInputAction IA_Jump**节点代表了你在上一步中探索过的`IA_Jump`输入操作资产。

当触发输入操作时，它会触发**已开始（Started）**和**已触发（Triggered）**事件。 该节点的**已开始（Started）**事件会导向一个名为**Jump**的函数节点。 此蓝图的父角色类拥有内置的跳跃功能，每当因按下按键而触发**IA_Jump**时，该函数就会被调用。

当跳跃结束时，该节点会触发一个**已完成（Completed）**事件。 此事件会导向另一个函数节点**Stop Jumping**，该节点同样继承自角色类。

> [!NOTE]
> 跳跃输入逻辑还会添加触摸控制，但本教程不涉及这些内容。

### 理解移动输入逻辑

接下来，请查看**移动输入（Movement Input）**组。 该组同样以节点（`IA_Move`）开始，对应着输入操作。

**IA_Move**节点拥有一个**已触发（Triggered）**事件，当绑定到`IA_Move`的按钮被按下时，该事件就会被触发。

**IA_Move**还包含了**X轴操作值（Action Value X）**和**Y轴操作值（Action Value Y）**，即玩家输入产生的**X**轴和**Y**轴移动值。 由于**X**和**Y**值是分开的，你需要分别将它们两者应用到角色上。

**Move**节点是一个自定义函数节点，用于向角色应用移动。 你可以在节点上及其细节（Details）面板中看到，它接收两个名为左/右（Left/Right）和前/后（Forward/Backward）的输入，IA_Move的X和Y移动值被传递到这些输入中。

双击Move节点或点击图表上方的**移动（Move）**选项卡，以查看函数内部的逻辑。

该函数以一个包含其输入值的函数入口节点开始。

**Left/Right**节点组包含一个**Add Movement Input**函数节点，该节点基于以下两个值为角色添加移动：**世界方向（World Direction）**和**缩放值（Scale Value）**。

**世界方向（World Direction）**是角色在世界中所面对的方向，而**缩放值（Scale Value）**是要应用的移动量。 由于该节点处理**左/右**移动，它会先使用**Get Actor** **Right Vector**函数节点获取角色在世界中的右向量，然后将 **左/右（Left / Right）** 输入（或输入操作的X值**）** 作为**缩放值（Scale Value）**，以沿该向量应用移动。

如果 `"左/右（Left / Right）`" 为正值，角色将沿X轴向上（即向右）移动。 如果 `"左/右（Left / Right）"` 为负值，角色将沿X轴向下（即向左）移动。

**Forward/Backward**组的设置与**Left/Right**组相同，但使用**前/后（Forward / Backward）**输入（输入操作的Y值**）**来确定沿Actor**前向量**的**缩放值**。

在代码中复制这些节点需要多花些功夫，但能精确地控制角色的移动方式和位置。

### 使用PlayerController指定玩家输入

输入映射上下文将玩家输入映射到输入操作，但还需要将该输入上下文连接到玩家。 默认玩家会通过PlayerController类和输入子系统来实现这一点。

PlayerController资产充当了人类玩家与其所控制的游戏内Pawn之间的桥梁。 它会接收并处理玩家输入，并将其转换为命令，然后Pawn会接收这些命令，并据此决定如何在游戏世界中执行该移动。 你可以用同一个PlayerController来控制不同的Pawn。

PlayerController还可以：

- 为过场动画或菜单禁用输入。
- 追踪分数或其他玩家数据。
- 生成或隐藏UI元素

分离PlayerController和角色就能带来灵活性和数据的持久性。 例如，这让你能够在不丢失玩家数据或输入处理逻辑的情况下切换角色（例如当玩家死亡时），因为这些逻辑存在于PlayerController中。

要探索如何在蓝图中设置此操作，返回**内容浏览器（Content Browser）**中的**Blueprints**文件夹，打开`BP_FirstPersonPlayerController`蓝图。

PlayerController类拥有一套增强输入本地玩家子系统。 这是一套依附于特定本地玩家的子系统，可管理该玩家的运行时输入上下文和映射。 你可以用该子系统管理哪些输入处于活跃状态，并在运行时切换不同输入上下文。 如需详细了解虚幻引擎子系统，请参阅[编程子系统](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/programming-subsystems/index.md)。

游戏开始时，如果**增强输入本地玩家子系统（Enhanced Input Local Player Subsystem）**有效，那么它会调用**Add Mapping Context**，从而将`IMC_Default`输入映射上下文绑定到玩家的输入子系统。 换句话说，这组节点为玩家激活了对应的输入组。

> [!NOTE]
> - 虽然这套PlayerController逻辑与其他移动逻辑位于不同的蓝图中，但在C++里，你可以在角色类中实现所有上述功能，而无需使用第二个C++类。
> - `BP_FirstPersonCharacter`的事件图表展示了另一种应用输入映射上下文的方式，该方式涉及等到Pawn被拥有。 本教程未涵盖该方法，但你可自行探索。

## 设置你的角色类

你已经了解了移动功能在蓝图中的实现方式，是时候用代码将其编译，然后测试角色在关卡中的移动情况了！ 首先，你需要添加所有必要模块和`#include`语句，然后声明实现角色移动所需的类、函数和属性。

> [!NOTE]
> 本教程中的代码示例使用的项目名为`AdventureGame`，角色类的名称为`AdventureCharacter`。

### 添加增强输入系统

你已经在虚幻编辑器中确保启用了增强输入系统，但你还必须在项目的 `Build.cs` 中手动声明该系统，并为你的角色类添加某些组件。

要在你的C++项目中使用增强输入系统，请执行以下步骤：

1. 在Visual Studio中打开你的项目，然后打开`[项目名].Build.cs`（和其他类文件一样，该文件位于项目的 `Source` 文件夹中）。

   此文件会向虚幻引擎表明，编译你的项目需要哪些模块。
2. 在 `PublicDependencyModuleNames` 函数调用中，将 `"EnhancedInput"` 添加到模块列表中：

   C++

   ```
   PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "EnhancedInput" });
   ```
3. 保存并关闭 `Build.cs` 文件。

要为你的角色类添加增强输入系统组件，请执行以下步骤：

1. 打开角色的 `.h` 文件。在文件顶部附近位置添加以下include语句：

   - `#include "EnhancedInputComponent.h"` 添加增强输入组件模块。
   - `#include "InputActionValue.h"` 启用对输入操作所产生的输入操作值的访问。
   - `#include "EnhancedInputSubsystems.h"` 实现对本地玩家子系统的访问。

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved. #pragma once #include "CoreMinimal.h"#include "GameFramework/Character.h"#include "EnhancedInputComponent.h"#include "EnhancedInputSubsystems.h" #include "InputActionValue.h"#include "AdventureCharacter.generated.h"
   ```

   > [!NOTE]
   > 确保你添加的所有 `#include` 语句都位于 `AdventureCharacter.generated.h` 语句之前。 为了使你的代码能正常运行，此语句必须排在输入列表的最后。
2. 在 `#include` 语句后声明下列三项新类：

   - `UInputMappingContext`
   - `UInputAction`
   - `UInputComponent`

   这些类已经在增强输入模块中存在。 像这样声明一个已存在的对象叫做 "前置声明" ，它会向编译器表明该类存在，并且你将使用它。

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved.

   #pragma once

   #include "CoreMinimal.h"
   #include "GameFramework/Character.h"
   #include "EnhancedInputComponent.h"
   #include "EnhancedInputSubsystems.h" 
   #include "InputActionValue.h"
   #include "AdventureCharacter.generated.h"
   ```

### 声明InputMappingContext指针

在角色的`.h`文件的`protected`小节中，使用`TObjectPtr`添加一个名为`FirstPersonContext`的新`UInputMappingContext`指针。 这是一个指向输入映射上下文的指针，可将你的输入操作与按键操作关联起来。

> [!NOTE]
> `TObjectPtr` 是虚幻引擎中的一种智能指针封装器，能更为安全地引用 `UObject` 派生的类型。 它是一种原始 `UObject` 指针的替代品，支持编辑器感知、对垃圾回收安全。 它是一种硬引用，因此会在运行时保持对象加载。 使用虚幻引擎编程时，建议用这种方式声明指针。

C++

```
protected:	// Called when the game starts or when spawned	virtual void BeginPlay() override; UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Input)TObjectPtr<UInputMappingContext> FirstPersonContext;
```

> [!NOTE]
> "U"前缀会将InputMappingContext标识为UObject。

变量声明前的`UPROPERTY()`宏可向虚幻引擎表明该变量的信息。 虚幻头文件分析工具会使用该宏处理与代码相关的信息，并控制该变量的访问位置、它在编辑器中的显示方式等等。

该指针拥有以下`UPROPERTY`值：

- `EditAnywhere`：在该类的**细节（Details）**面板中，对虚幻编辑器公开该属性。
- `BlueprintReadOnly`：蓝图可以访问该属性，但不能编辑该属性。
- `Category = Input`：该属性将在该类的**细节（Details）**面板的**输入（Input）**分段下出现。 类别有助于组织你的代码，还可以让你更轻松地在编辑器中导航。

### 声明跳跃和移动InputAction指针

同样是在`protected` 小节中，添加两个`UInputAction`指针，分别名为`MoveAction`和`JumpAction`。 这些指针分别指向`IA_Jump`和`IA_Move`输入操作。

为这些指针赋予与`UInputMappingContext`相同的`UPROPERTY()`宏。

C++

```
protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Input)
	TObjectPtr<UInputMappingContext> FirstPersonContext;

	// Move Input Actions
	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Input)
	TObjectPtr<UInputAction> MoveAction;
```

### 声明Move()函数

输入操作会产生输入操作值，你需要将这些值传递给新函数，该函数会使用这些值移动你的角色。

在文件的`public` 小节，声明一个名为`Move()`的新函数，该函数会使用一个名为`Value`的常量`FInputActionValue`引用。

C++

```
// Handles 2D Movement InputUFUNCTION()void Move(const FInputActionValue& Value);
```

函数声明前的`UFUNCTION()`宏可让虚幻头文件分析工具识别该函数。

保存文件。 现在角色的头文件应如下所示：

C++

```
#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Character.h"
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h" 
#include "InputActionValue.h"
#include "AdventureCharacter.generated.h"

class UInputMappingContext;
```

## 实现移动函数

现在你声明了角色移动所需的属性，那么在角色的`.cpp`文件中，你需要设计函数来模拟你在默认角色蓝图中看到的功能。

### 设置Move()函数

打开角色的`.cpp`类，为`Move()`函数添加新的函数定义，以实现你在`.h`文件中声明的函数。

C++

```
void AAdventureCharacter::Move(const FInputActionValue& Value){) 
```

在探索默认角色的输入操作时，你会发现`IA_Move`的**值类型（Value Type）**为**Axis2D (Vector2D)**，因此当被触发时，它会返回一个FVector2D值。

在`Move()`函数内部，获取`FInputActionValue`的值，并将其存储在一个名为`MovementValue`的新FVector2D值中：

C++

```
void AAdventureCharacter::Move(const FInputActionValue& Value){	// 2D Vector of movement values returned from the input action	const FVector2D MovementValue = Value.Get<FVector2D>();}
```

接下来，添加一个`if`语句来检查控制器是否有效。 `控制器（Controller）`是指向拥有此Actor的控制器的指针。要让移动功能正常工作，控制器必须有效。

C++

```
void AAdventureCharacter::Move(const FInputActionValue& Value)
{

	// 2D Vector of movement values returned from the input action
	const FVector2D MovementValue = Value.Get<FVector2D>();

	// Check if the controller possessing this Actor is valid
	if (Controller)
	{
	}
```

### 使用Move()添加2D移动输入

为了在角色蓝图中前后左右移动，事件图表会将`IA_Move`的**X轴操作值（Action Value X）**和**Y轴操作值（Action Value Y）**与Actor的右向量和前向量相结合，从而添加移动输入。 你需要在`Move()`函数的代码中实现这一点。

在`if`语句内部调用`GetActorRightVector()`函数，从而将Actor的右向量存储在一个名为`Right`的新`FVector`中。

C++

```
const FVector Right = GetActorRightVector();
```

然后，调用`AddMovementInput()`函数为角色添加移动，传入`Right`和`MovementValue.X`。

C++

```
AddMovementInput(Right, MovementValue.X);
```

使用`GetActorForwardVector()`函数对前后移动重复此过程，这次传入`MovementValue.Y`。

完整的`Move()`函数应如下所示：

C++

```
void AAdventureCharacter::Move(const FInputActionValue& Value)
{
	// 2D Vector of movement values returned from the input action
	const FVector2D MovementValue = Value.Get<FVector2D>();

	// Check if the controller posessing this Actor is valid
	if (Controller)
	{
		// Add left and right movement
		const FVector Right = GetActorRightVector();
```

### 使用SetupPlayerInputComponent将移动绑定至输入

接下来，将你的`Move`函数关联到你之前声明的`FirstPersonContext`输入映射上下文。

执行此操作的函数`SetupPlayerInputComponent()`已经由角色的`.cpp`文件定义，因为它继承自ACharacter。 此函数会使用UInputComponent，并使用它来设置玩家输入。

#### 检查增强输入组件

默认情况下，此函数首先会调用来自于ACharacter的`SetupPlayerInputComponent()`函数，该函数会检查角色上是否存在输入组件。

C++

```
// Called to bind functionality to inputvoid AAdventure::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent){	Super::SetupPlayerInputComponent(PlayerInputComponent);}
```

这仅会检查角色上是否存在常规输入组件，而你需要检查是否存在增强输入组件，因此请删除对父类的`SetupPlayerInputComponent()`函数的调用。

最为替代，请在if语句中声明一个名为`EnhancedInputComponent`的新`UEnhancedInputComponent`指针。 将此值设为在将传入到此函数的`PlayerInputComponent`转换为`UEnhancedInputComponent`时调用`CastChecked()`函数所得到的结果。

C++

```
if (UEnhancedInputComponent* EnhancedInputComponent = CastChecked<UEnhancedInputComponent>(PlayerInputComponent)){ }
```

#### 绑定移动操作

在`if`语句内部，调用来自于`EnhancedInputComponent`的`BindAction()`函数。

向该函数传递以下参数：

- `MoveAction`：需绑定的输入操作（角色的`.h`文件中已声明）。
- 来自 `ETriggeredEvent` 的 `触发`事件 ：事件的触发类型。
- `this`：要绑定的目标角色。
- `Move()`：需绑定函数的引用。

C++

```
if (TObjectPtr<UEnhancedInputComponent> EnhancedInputComponent = CastChecked<UEnhancedInputComponent>(PlayerInputComponent)){	// Bind Movement Actions	EnhancedInputComponent->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AAdventureCharacter::Move);}
```

现在，当**IA_Move**被触发时，它就会调用`Move()`函数为你的角色添加移动效果！

#### 绑定跳跃操作

接下来，为IA_Jump添加两项绑定，一个绑定用于开始跳跃，另一个用于停止跳跃。

你将使用以下参数：

- `JumpAction`：即你在`.h`文件中声明的指向IA_Jump的输入操作指针。
- `已开始（Started）`和`已完成（Completed）`触发事件。
- 在ACharacter父类中继承并定义的`Jump`和`StopJumping`函数。

C++

```
// Bind Jump ActionsEnhancedInputComponent->BindAction(JumpAction, ETriggerEvent::Started, this, &ACharacter::Jump);EnhancedInputComponent->BindAction(JumpAction, ETriggerEvent::Completed, this, &ACharacter::StopJumping);
```

你的`SetupPlayerInputComponent()`函数现在应该如下所示：

C++

```
// Called to bind functionality to input
void AAdventureCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
{
	// Check the UInputComponent passed to this function and cast it to an UEnhancedInputComponent
	if (UEnhancedInputComponent* EnhancedInputComponent = CastChecked<UEnhancedInputComponent>(PlayerInputComponent))
	{
		// Bind Movement Actions
		EnhancedInputComponent->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AAdventureCharacter::Move);
		
		// Bind Jump Actions
```

### 将输入映射绑定到角色

你已经将输入绑定到了函数，但你还需要将输入映射上下文绑定到角色。 你需要在角色的`BeginPlay()`函数中完成此操作，从而在游戏开始时设置好输入。

> [!TIP]
> `BeginPlay()`是父类 `AActor`中的一个虚拟函数，并且会在游戏开始时或某个Actor在世界中生成并完全初始化时被调用。 该函数可被用于在游戏开始时应为该Actor运行一次的逻辑。

在`BeginPlay()`中，先先请检查全局引擎指针是否为空，然后再继续。

C++

```
check(GEngine != nullptr);
```

在`if`语句中，声明一个名为`PlayerController`的`APlayerController`指针。 将其设置为将`Controller`转换为`APlayerController`的结果。

C++

```
// Get the player controller for this characterif (APlayerController* PlayerController = Cast<APlayerController>(Controller)){ }
```

`if`语句能够确保仅在指针不为空时才继续执行。

现在，你需要获取增强输入本地玩家子系统，并将`FirstPersonContext`输入映射上下文（在你的`.h`文件中声明）添加到该子系统中。

在另一个`if`语句中，请调用`ULocalPlayer::GetSubsystem()`，从而建一个名为`Subsystem`的新`UEnhancedInputLocalPlayerSubsystem`指针，从而传递当前玩家。 调用`PlayerController->GetLocalPlayer()`即可获取当前玩家。

C++

```
if (APlayerController* PlayerController = Cast<APlayerController>(Controller)){  if (UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PlayerController->GetLocalPlayer()))  {   }}
```

调用`AddMappingContext()`函数即可为子系统添加映射上下文，传入映射上下文以及优先级`0`，即可为此映射上下文赋予最高优先级。

C++

```
// Get the enhanced input local player subsystem and add a new input mapping context to itif (UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PlayerController->GetLocalPlayer())){	Subsystem->AddMappingContext(FirstPersonContext, 0);}
```

最后，新增一条调试消息，以验证你的自定义角色类是否正在被使用。

你的`BeginPlay()`函数应如下所示：

C++

```
// Called when the game starts or when spawned
void AAdventureCharacter::BeginPlay()
{
	Super::BeginPlay();

	check(GEngine != nullptr);

	// Get the player controller for this character
	if (APlayerController* PlayerController = Cast<APlayerController>(Controller))
	{
```

在Visual Studio中保存`.h`头文件以及`.cpp`实现文件，然后点击 **编译（Build）**即可编译你的项目。

## 设置角色蓝图的变量

要完成这些移动功能按钮的设置，请使用角色的蓝图，为你在代码中声明的变量分配资产。

要用资产填充角色的新属性，请执行以下步骤：

1. 在虚幻编辑器中打开角色蓝图。如果尚未打开，请在**蓝图编辑器**中将其打开。
2. 打开**细节**面板，转到**输入（Input）**分段，设置以下属性：

   - 将**第一人称上下文（First Person Context）**设置为`IMC_Adventure`。
   - 将**移动操作（Move Action）**设为`IA_Move`。
   - 将**跳跃操作（Jump Action）**设为`IA_Jump`。
3. 保存蓝图并点击**编译（Compile）**即可进行编译。

## 测试角色移动

点击**关卡编辑工具栏**上的**运行**按钮，进入在**编辑器内运行**模式。 游戏开始时，屏幕上应该会打印出"Hello World!"和"We are using AdventureCharacter"。 你应该能够使用WASD键或方向键移动，并使用空格键跳跃！

> 动图已省略：1e25d96123eca149f07e943ff6883c0992c27f955046bf684c57fe82ffddd2f6

## 下一步

你得到了一个可移动的角色，但它仍然缺少合适的网格体和摄像机。 在下一小节中，你将学习如何创建摄像机组件，将其绑定到角色上，并添加骨骼网格体，从而获得真实的第一人称视角！

- [添加第一人称摄像机、网格体和动画](../coder-04-adding-a-firstperson-camera-mesh-and-animation/index.md) - 学习如何使用C++为第一人称角色附加网格体和摄像机组件。

## 完整代码

C++

AdventureCharacter.h

```
#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Character.h"
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h" 
#include "InputActionValue.h"
#include "AdventureCharacter.generated.h"

class UInputMappingContext;
```

C++

AdventureCharacter.cpp

```
#include "AdventureCharacter.h"

// Sets default values
AAdventureCharacter::AAdventureCharacter()
{
	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}
```

C++

AdventureGame.Build.cs

```
// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

public class AdventureGame : ModuleRules
{
	public AdventureGame(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
```

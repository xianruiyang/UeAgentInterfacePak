---
title: "输入概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/input-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "输入", "输入概述"]
---

# 输入概述

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 输入 / 输入概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/input-overview-in-unreal-engine

**玩家输入（PlayerInput）** 对象负责将玩家的输入转换为Actor（如PlayerController或Pawn）能够 理解并使用的数据。它是输入处理流程的一部分，该流程使用PlayerInput映射和InputComponent将来自玩家的硬件输入转换为游戏事件和移动。

> [!NOTE]
> 有关设置输入的示例，请参阅[设置输入](../setting-up-user-inputs/index.md)文档。

## 硬件输入

来自玩家的硬件输入非常简单。它通常包括按键、点击鼠标或移动鼠标、按控制器按钮或移动操纵杆。对于不符合标准轴或按钮索引的专用输入设备，或具有非常见输入范围的专用输入设备，可以使用[原生输入插件](../rawinput-plugin/index.md)进行手动配置。

## 玩家输入

PlayerInput是用于管理玩家输入的PlayerController类中的UObject。它仅在客户端上生成。PlayerInput中定义了 两种结构体。第一种是 **FInputActionKeyMapping**，它定义了操作映射（ActionMapping）。另一种是 **FInputAxisKeyMapping**，它定义了轴映射（AxisMapping）。 在操作映射（ActionMapping）和轴映射（AxisMapping）中使用的硬件输入定义都是在InputCoreType中建立的。

$ ActionMappings : 将离散按钮或按键映射到一个"友好的名称"，该名称稍后将与事件驱动型行为绑定。最终的效果是，按下（和/或释放）单个键、鼠标按钮或键盘按钮将直接触发某个游戏行为。

$ AxisMappings : 将键盘、控制器或鼠标输入映射到一个"友好的名称"，该名称稍后将绑定到连续的游戏行为，例如移动。在轴映射（AxisMapping）中映射的输入会被持续轮询，即使当它们刚刚报告它们的输入值当前为零时也是如此。这可实现移动或其他游戏行为的平稳过渡，而不是由操作映射（ActionMapping）中输入所触发的离散游戏事件。

> [!TIP]
> 硬件轴（例如控制器操纵杆）提供输入的程度，而不是离散的1（按下）或0（不按下）输入。也就是说，它们可以被小幅度或大幅度地移动，而你角色的移动也会相应地变化。虽然这些输入方法非常适合提供可扩展的移动输入量，但轴映射（AxisMapping）也可以将常见的移动键（如WASD键或上下左右方向键）映射到持续轮询的游戏行为。

### 设置输入映射

输入映射存储在配置文件中，可以在项目设置（Project Settings）的输入部分进行编辑。

1. 在关卡编辑器（Level Editor）中，选择 **编辑>项目设置（Edit > Project Settings）**。
2. 在显示的 **项目设置（Project Settings）** 选项卡中，单击 **输入（Input）**。

在此窗口中，你可以：

**更改（硬件）轴输入的属性（Change the properties of (hardware) axis inputs）：**

**添加或编辑操作映射（Add or edit ActionMappings）：**

**添加或编辑轴映射（Add or edit AxisMappings）：**

## InputComponent

**InputComponents** 最常出现在Pawn和控制器中，但如果需要，也可以在其他Actor和关卡脚本中设置它们。InputComponent 将项目中的轴映射（AxisMapping）和操作映射（ActionMapping）链接到 以C++代码或蓝图图表建立的游戏操作（通常为函数）。

InputComponent用于执行输入处理的优先级堆栈如下（最高优先级优先）：

1. 其"接受输入（Accepts input）"已启用的Actor，从最晚启用者到最早启用者。

   > [!TIP]
   > 如果你希望某个特定的Actor总是第一个被考虑进行输入处理的Actor，那么你可以重新启用它的"接受输入（Accepts input）"，该Actor将被移动到堆栈的顶部。
2. 控制器。
3. 关卡脚本。
4. Pawn。

如果一个InputComponent获得了输入，那么它在堆栈的后继部分将不再可用。

## 输入处理程序

### 示例 - 向前移动

此示例取自虚幻引擎4随附提供的第一人称模板。

1. 玩家的硬件输入（Hardware Input from Player）：

   玩家按下W键。
2. **玩家输入映射（PlayerInput Mapping）：**轴映射（AxisMapping）将W转换为比例为1的"向前移动（MoveForward）"。
3. **InputComponent优先级堆栈（InputComponent Priority Stack）：**继续操作InputComponent优先级堆栈，"向前移动（MoveForward）"输入的第一个绑定位于AFirstPersonBaseCodeCharacter类中。此类是当前玩家的Pawn，所以它的InputComponent排在最后检查。

   ```
                void AFirstPersonBaseCodeCharacter::SetupPlayerInputComponent(class UInputComponent* InputComponent)                 {                     // set up gameplay key bindings                     check(InputComponent);                     ...                     InputComponent->BindAxis("MoveForward", this, &AFirstPersonBaseCodeCharacter::MoveForward);                     ...                 }
   ```

   这一步也可以在蓝图中通过在角色的事件图（EventGraph）中设置一个InputAxis MoveForward节点来完成。无论这个节点连接到什么对象，该对象都是按下W键时将执行的对象。
4. **游戏逻辑（Game Logic）：**AFirstPersonBaseCodeCharacter的MoveForward函数执行。

   ```
               void AFirstPersonBaseCodeCharacter::MoveForward(float Value)                {                    if ( (Controller != NULL) && (Value != 0.0f) )                    {                        // find out which way is forward                        FRotator Rotation = Controller->GetControlRotation();                        // Limit pitch when walking or falling                        if ( CharacterMovement->IsMovingOnGround() || CharacterMovement->IsFalling() )                        {                            Rotation.Pitch = 0.0f;                        }                        // add movement in that direction                        const FVector Direction = FRotationMatrix(Rotation).GetScaledAxis(EAxis::X);                        AddMovementInput(Direction, Value);                    }                }
   ```

   蓝图实现：

## 触摸界面

默认情况下，在触控设备上运行的游戏将拥有两个虚拟操纵杆（就像一个主机控制器）。你可以在 **项目设置（Project Settings）** 中的 **输入（Input）** 部分使用 **默认触摸界面（Default Touch Interface）** 属性 更改操纵杆。这将指向一个触摸界面设置（Touch Interface Setup）资源。默认的 **DefaultVirtualJoysticks** 位于共享引擎内容中（`/Engine/MobileResources/HUD/DefaultVirtualJoysticks.DefaultVirtualJoysticks`）。 还有一个仅有左操纵杆的版本 **LeftVirtualJoystickOnly**，适用于不需要转动摄像机的游戏。

请注意，你需要选中对象选取器 **视图选项（View Options）** 设置中的 **显示引擎内容（Show Engine Content）** 复选框才能看到这些内容。

如果你不想要任何虚拟操纵杆，只需清除默认触摸界面（Default Touch Interface）属性。此外，你可以通过选中始终显示触摸界面（Always Show Touch Interface）（或者通过使用-faketouches运行PC游戏）， 强制让你的游戏的触摸界面独立于它所运行的平台。

## 增强输入插件

对于需要更多高级输入功能的项目，比如复杂的输入处理，或运行时控制选项重映射，[增强型输入插件（试验性）](../enhanced-input/index.md)为开发者提供了一个简单的升级路径，并向后兼容引擎的默认输入系统。这个插件实现了径向死区、多键同时输入（chorded actions）、上下文输入和优先级等功能，并且能够在基于资产的环境中扩展自己对原始输入数据的过滤和处理。

## 入门指南

要将你的项目配置为使用增强输入（Enhanced Input），请启用Enhanced Input插件。通过在编辑器中打开 **编辑（Edit）** 下拉菜单并选择 **插件（Plugins）**，可以启用此插件。在插件列表的 **输入（Input）** 部分中，找到Enhanced Input插件并启用，然后重启编辑器。

插件将在你重启编辑器后激活。

编辑器重启之后，你就可以将项目设置为使用Enhanced Input插件类，而不是默认的UE4输入处理程序。转到 **编辑（Edit）** 下拉菜单，然后选择 **项目设置（Project Settings）**。在其中找到 **输入（Input）** 部分（在 **引擎（Engine）** 标题栏下），然后找到 **默认类（Default Classes）** 设置。这些设置最初包含标准的PlayerInput和InputComponent类。

要使用Enhanced Input，需要将这些设置分别更改为EnhancedPlayerInput和EnhancedInputComponent。

## 核心概念

Enhanced Input系统具有四个主要概念： * 输入操作（Input Actions）是Enhanced Input系统和你的项目代码之间的通信链接。输入操作可以是交互角色可能做出的任何动作，例如跳跃或开门，但也可以用于指示用户输入状态，例如按住按钮可以将行走动作更改为奔跑动作。输入操作独立于原始输入；输入操作与触发输入操作的特定输入无关，但知道其当前状态并可以在最多三个独立的浮点轴上报告输入值。例如，"拾取道具"操作可能仅需要一个开/关状态，用于指示用户是否在尝试捡起某个东西，而"行走"操作可能需要两个轴来描述用户尝试行走的方向和速度。

* 输入映射上下文（Input Mapping Contexts）将用户输入映射到操作，并可以动态地为每个用户添加、移除或安排优先次序。你可以通过本地玩家的Enhanced Input本地玩家子系统（Enhanced Input Local Player Subsystem）将一个或多个上下文应用到本地玩家，并安排它们的优先次序，避免多个操作由于尝试使用同一输入而发生冲突。此问题的常见示例是，当角色在世界中四处行走时，一个按钮可以开门，或者在查看角色的背包时，这个按钮又可以选择道具。无论角色何时打开背包，你都可以添加"选择道具"输入映射上下文，使其优先于"开门"上下文，然后在角色关闭背包时，移除"选择道具"上下文。这样可以确保根据角色的环境来正确解译用户的输入，不再需要在输入处理层编写代码来区分门和背包系统。 修饰符（Modifiers）调整来自用户设备的原始输入的值。输入映射上下文可以具有与输入操作的每个原始输入关联的任意数量的修饰符。常见修饰符包括死区、多个帧上的输入平滑处理、将输入矢量从本地转换到世界空间，以及插件中包含的一些其他修饰符；开发人员还可以创建他们自己的修饰符。

* 触发器（Triggers）使用后期修饰符输入值或其他输入操作的输出大小来确定是否应该激活输入操作。输入映射上下文中的任何输入操作对于每个输入都具有一个或多个触发器。例如，为了拍摄照片，可能需要用户在用于瞄准摄像机的单独输入操作处于激活状态时按住鼠标左键约0.25秒。

通过综合利用这些概念，开发人员可以快速设置从简单到复杂的各种输入系统并调整这些系统，而不需要更改项目代码。

## 输入操作

输入操作是系统和你的项目代码之间的连接。通过在 **上下文浏览器（Context Browser）** 中右键点击并展开 **输入（Input）** 选项，然后选择 **输入操作（Input Actions）**，可以创建输入操作。要触发输入操作，必须将其包含在输入映射上下文中，并将该输入映射上下文添加到本地玩家的 **Enhanced Input本地玩家子系统（Enhanced Input Local Player Subsystem）**。

要使你的Pawn类响应所触发的输入操作，你必须将其绑定到SetupPlayerInputComponent中相应类型的 **触发器事件（Trigger Event）**。以下示例代码重载SetupPlayerInputComponent，以便将两个输入操作（MyInputAction和MyOtherInputAction）绑定到处理程序函数：

```
 // 确保我们正在使用 UEnhancedInputComponent；如果未使用，表明项目未正确配置。 if (UEnhancedInputComponent* PlayerEnhancedInputComponent = Cast<UEnhancedInputComponent>(PlayerInputComponent)) {    // 有多种方式可以将UInputAction*绑定到处理程序函数和可能有关的多种类型的ETriggerEvent。     // 当MyInputAction启动时，这会在更新函数上调用处理程序函数，例如在按操作按钮时。    if (MyInputAction)    {        PlayerEnhancedInputComponent->BindAction(MyInputAction, ETriggerEvent::Started, this, &AMyPawn::MyInputHandlerFunction);    }     // 当满足输入条件时，例如在按住某个动作键时，这会在每个更新函数上按名称调用处理程序函数(UFUNCTION)。    if (MyOtherInputAction)    {        PlayerEnhancedInputComponent->BindAction(MyOtherInputAction, ETriggerEvent::Triggered, this, TEXT("MyOtherInputHandlerFunction"));    } }
```

使用Enhanced Input插件绑定输入操作将会替换内置输入系统的操作和轴绑定；如果你正在使用Enhanced Input插件，则应该仅绑定输入操作。 在绑定输入操作时，可以在四种不同的处理程序函数签名之间进行选择，如下所示：

| 返回类型 | 参数 | 用法说明 |
| --- | --- | --- |
| void | `()` | 适用于简单案例，这种案例不需要来自Enhanced Input系统的任何额外信息。 |
| void | `(const FInputActionValue& ActionValue)` | 提供对输入操作当前值的访问权限。 |
| void | `(const FInputActionInstance& ActionInstance)` | 提供对输入操作的当前值、触发事件类型和相关定时器的访问权限。 |
| void | `(FInputActionValue ActionValue, float ElapsedTime, float TriggeredTime)` | 通过名称动态绑定到UFunction时使用的签名；参数可选。 |

输入操作具有内置的事件，可以将其公开给蓝图脚本；在向蓝图脚本开发人员提供对输入操作事件的访问权限时，C++开发人员不必创建传递函数。 典型的处理程序函数可能采用以下形式：

```
 void AMyPawn::MyFirstAction(const FInputActionValue& Value) {    // 用于确认处理程序函数正在运行的调试日志输出。    UE_LOG(LogTemp, Warning, TEXT("%s called with Input Action Value %s (magnitude %f)"), TEXT(__FUNCTION__), *Value.ToString(), Value.GetMagnitude());    // 使用GetType()函数来确定Value的类型，使用索引在0和2之间的[]运算符来访问其数据。 }
```

对于大部分用例，建议使用void (const FInputActionValue&)签名。 将输入操作绑定到处理程序函数可以让Pawn根据函数的具体触发方式来响应这些函数。 对于按按钮时仅发生一次的操作，最常见的触发器类型可能是Started，对于按住输入时每一帧都发生的持续操作，触发器类型可能是Triggered，你可以在[ETriggerEvent](https://dev.epicgames.com/documentation/404)的API参考页上查看完整列表。

## 输入映射上下文

输入映射上下文介绍用于触发一个或多个输入操作的规则。它的基本结构是一个在顶层具有输入操作列表的层级。输入操作层下面是一个用户输入列表，该列表可以触发各个操作，例如键、按钮和动作轴。 底层包含各个用户输入的输入触发器和输入修饰符列表，该列表可以用于确定如何过滤或处理输入的原始值，以及它必须满足哪些限制才能在其层级的顶层驱动输入操作。 任何输入都可以具有多个输入修饰符和输入触发器。这些将按顺序评估，将每个步骤的输出用作下一步的输入。

要创建输入映射上下文，请右键点击 **上下文浏览器（Context Browser）** ，展开 **输入（Input）** 选项，然后选择 **输入映射上下文（Input Mapping Context）**。

使用所有相关的输入操作填充你的输入映射上下文。对于简单的项目，你可以将所有的输入操作放入单个输入映射上下文中。较复杂的项目最好可以使用多个输入映射上下文工作，因为本地玩家可以同时具有多个活动的输入映射上下文。 例如，一个可以游泳、行走和驾驶载具的角色可能具有输入映射上下文，用于始终可用且始终映射到相同用户输入的常见操作，单独的输入映射文本用于行程中每个模式。 开发人员随后可以将与载具相关的输入操作放入单独的输入映射上下文中，而该上下文随后在进入载具时添加到本地玩家，并在退出载具时从本地玩家中移除。这样做可以确保不会运行不恰当的输入操作（并且不会浪费CPU周期），并避免互斥的输入映射上下文将某个用户输入用于不同的输入操作而导致发输入冲突，从而减少漏洞。如需更多详细信息，请参见修饰符和触发器中的相应部分。

此输入映射上下文显示用于奔跑的输入操作，该输入操作可以通过多个输入来激活，包括游戏手柄的左控制杆偏转，将两个轴组合为单个输入。。 该输入的原始值将经过"死区"输入修饰符，生成的值将发送到"按住"输入触发器来驱动"RunAction"输入操作。

下拉列表中有大量的输入绑定可用。要更加快速地选择你的输入绑定，请按下拉列表左侧的小按钮，然后按你要绑定的键或按钮。

这个简单的输入映射上下文支持用于奔跑和跳跃的输入操作。 填充输入映射上下文之后，就可以将其添加到与Pawn的玩家控制器关联的本地玩家。通过重载PawnClientRestart函数和添加代码块可以完成此目标，如下所示：

```
 // 确保我们具有有效的玩家控制器。 if (APlayerController* PC = Cast<APlayerController>(GetController())) {    // 从与我们的玩家控制器相关的本地玩家获取Enhanced Input本地玩家子系统。    if (UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PC->GetLocalPlayer()))    {        // PawnClientRestart在Actor的生命周期中可以运行多次，因此首先要清除任何残留的映射。        Subsystem->ClearAllMappings();         // 添加每个映射上下文及其优先级值。高值的优先级高于低值。        Subsystem->AddMappingContext(MyInputMappingContext, MyInt32Priority);    } }
```

添加你的输入映射上下文（Input Mapping Contexts）之后，你的Pawn就可以响应你在SetupPlayerInputComponent中绑定的任何输入操作事件，或响应蓝图脚本用户已经设置的任何输入操作事件。如果游戏期间发生事件，需要更改可用输入映射上下文集，则你可以使用ClearAllMappings、AddMappingContext和RemoveMappingContext来动态更新可用命令集。 如需更多信息，请查看[IEnhancedInputSubsystemInterface](https://dev.epicgames.com/documentation/404)API参考页面。

## 输入修饰符

输入修饰符（Input Modifiers）是预处理器，能够修改虚幻引擎接收的原始输入值，然后再将其发送到输入触发器上。Enhanced Input插件随附多种输入修饰符，可以执行各种任务，例如更改轴顺序、实施"死区"、将轴输入转换为世界空间以及其他功能。每个与输入映射上下文中的输入操作关联的输入都将经历用户定义的一系列输入修饰符，然后再继续进入该输入的输入触发器。输入修饰符按照列示的顺序进行应用，每个输入修饰符的输出值都会成为下一个修饰符的输入值。 如需查看Enhanced Input插件中包含的输入修饰符的完整列表，请查看[UInputModifier](https://dev.epicgames.com/documentation/404)API参考页面。如果你的项目需要尚不存在的输入修饰符，可以创建你自己的UInputModifier类。

## 输入触发器

输入触发器（Input Triggers ）确定用户输入在经历过输入修饰符的可选列表之后是否应该在其输入映射上下文中激活相应的输入操作。大部分输入触发器都会分析输入本身，检查最小动作值并验证各种模式，例如短暂点击、长时间按住或典型的"按下"或"释放"事件。此规则的一个例外是"弹奏动作"输入触发器，该触发器要求触发另一个输入操作。默认情况下，输入上的任何用户活动都会在每个更新函数上触发。 如需查看Enhanced Input插件中包含的输入触发器的完整列表，请查看[UInputTrigger](https://dev.epicgames.com/documentation/404)API参考页面。如果你需要Enhanced Input插件未提供的输入触发器，那么你可以创建自己的UInputTrigger类。

- [增强输入](../enhanced-input/index.md) - 关于增强输入插件的概述。

- [RawInput插件](../rawinput-plugin/index.md) - 介绍RawInput插件

- [设置Actor的输入](../setting-up-input-on-an-actor/index.md) - 如何在虚幻引擎中设置 Actor 的输入的操作指南

- [设置输入](../setting-up-user-inputs/index.md) - 如何设置用户输入

- [输入概述](index.md) - 输入对象负责将玩家的输入转换为以Actor能够理解和使用之形式表现的数据。

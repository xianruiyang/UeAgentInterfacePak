---
title: "增强输入"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/enhanced-input-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "输入", "增强输入"]
---

# 增强输入

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 输入 / 增强输入

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/enhanced-input-in-unreal-engine

**虚幻引擎5**（UE5）项目有时会需要更多高级的输入功能，例如复杂的输入处理，或在运行时重新映射输入按键。**增强输入（Enhanced Input）** 为开发人员提供了这类功能，并能向上兼容 **虚幻引擎4**（UE4）的默认输入系统。

此插件实现了多种功能，例如径向死区、同时按键、上下文输入和优先级安排，并且能够在基于 **资产** 的环境中，拓展对于原始输入数据的筛选和处理功能。

## 动态和上下文输入映射

使用增强输入时，你可以在运行时为玩家添加和删除 **映射上下文（Mapping Contexts）** 。这样可更轻松地管理大量 **操作（Actions）** 。你可以根据玩家的当前状态更改特定输入的行为。

例如，如果你有一个可以行走、冲刺、俯卧的玩家角色。对于其中每种角色移动类型，你可以交换映射上下文，让CTRL键执行不同的操作。行走时按下CTRL键，角色应该蹲伏。冲刺时按下CTRL键，角色应该滑行。俯卧时按下CTRL键，角色应该重新站起来。

## 创建增强输入资产

增强输入默认启用。你可以从内容浏览器点击 **添加（Add）** ( **+** )并找到 **输入（Input）** 类别，创建输入资产。

## 核心概念

增强输入系统主要有四个概念： **输入动作（Input Actions）** 、 **输入映射上下文（Input Mapping Contexts）** 、 **输入修饰器（Input Modifiers）** 和 **输入触发器（Input Triggers）** 。

### 输入动作

**输入动作（Input Actions）** 是增强输入系统和项目代码之间的通信链接。输入动作在概念上相当于 **操作（Action）** 和 **轴（Axis）** 映射名称，但它们是数据资产。每个输入动作应该表示用户可以执行的某件事，例如"蹲伏"或"发射武器"。你可以在蓝图或C++中添加 **输入侦听器（Input Listeners）** ，侦听输入动作的状态何时发生变化。

输入动作可以是多种不同的类型，这些类型将确定行为。你可以创建简单的布尔动作或更复杂的3D轴。动作类型将确定值。布尔动作采用简单的 **布尔** 值， **Axis1D** 为 **浮点** 值， **Axis2D** 为 **FVector2D** ， **Axis3D** 为整个 **Fvector** 。

输入动作可以是不同的值类型，这些类型将确定行为。

你应该将布尔动作用于状态为开或关的输入。这相当于旧版输入系统中的较旧动作映射。对于游戏手柄控制杆值等控制点，你可以使用2D轴动作来保存控制杆位置的X和Y值。你可以使用3D轴保存更复杂的数据，例如运动控制器信息。

> [!NOTE]
> 例如，"拾取道具"动作可能仅需要一个开/关状态，用于指示用户是否想要角色捡起某个东西，而"行走"动作可能需要2D轴，来描述用户想要角色行走的方向和速度。

Lyra游戏示例中使用的不同输入动作。

#### 触发状态

**触发状态（Trigger State）** 表示动作的当前状态，例如 **已开始（Started）** 、 **进行中（Ongoing）** 、 **已触发（Triggered）** 、 **已完成（Completed）** 和 **已取消（Canceled）** 。通常，你将使用"已触发"状态。你可以绑定到C++和蓝图中的特定状态。

- **已触发（Triggered）：** 动作已触发。这意味着它完成了所有触发器要求的求值。例如，"按下并松开"触发器会在用户松开按键时发送。
- **已开始（Started）：** 发生了开始触发器求值的某个事件。例如，"双击"触发器的第一次按键将调用一次"已开始"状态。
- **进行中（Ongoing）：** 触发器仍在进行处理。例如，当用户按下按钮时，在达到指定持续时间之前，"按住"动作处于进行中状态。根据触发器，此事件将在收到输入值之后在对动作求值时，每次更新触发一次。
- **已完成（Completed）：** 触发器求值过程已完成。
- **已取消（Canceled）：** 触发已取消。例如，在"按住"动作还没触发之前，用户就松开了按钮。

#### 添加输入侦听器

要在蓝图中添加输入动作侦听器，你可以在蓝图的事件图表中右键点击，然后键入你的输入动作数据资产的名称。

添加输入动作事件并将其设置为执行打印字符串。

你还可以在C++中绑定输入动作

```
	void AFooBar::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)	{		UEnhancedInputComponent* Input = Cast<UEnhancedInputComponent>(PlayerInputComponent);		// 你可以通过更改"ETriggerEvent"枚举值，绑定到此处的任意触发器事件		Input->BindAction(AimingInputAction, ETriggerEvent::Triggered, this, &AFooBar::SomeCallbackFunc);	}	 	void AFooBar::SomeCallbackFunc(const FInputActionInstance& Instance)	{		// 获取此处所需任意类型的输入动作的值...		FVector VectorValue = Instance.GetValue().Get<FVector>();		FVector2D 2DAxisValue = Instance.GetValue().Get<FVector2D>();		float FloatValue = Instance.GetValue().Get<float>(); 		bool BoolValue = Instance.GetValue().Get<bool>();	 		// 在此处实现你的精彩功能！	} 
```

### 输入映射上下文

**输入映射上下文（Input Mapping Contexts）** 是输入动作的集合，表示玩家可以处于的特定上下文。它们描述了给定输入动作的触发规则。映射上下文可以动态地为每个用户添加、移除或安排优先次序。

要创建输入映射上下文，请右键点击 **上下文浏览器（Context Browser）** ，展开 **输入（Input）** 选项，然后选择 **输入映射上下文（Input Mapping Context）** 。

输入映射上下文的基本结构是一个层级结构，最上层包含一组输入动作。在输入动作层下面，是可以触发各个输入动作的用户输入，例如键、按钮和动作轴。

底层包含各个用户输入的输入触发器和输入修饰器列表，可用于确定如何筛选或处理输入的原始值，以及它必须满足哪些限制才能驱动顶层的输入动作。

你可以通过本地玩家的增强输入本地玩家子系统（Enhanced Input Local Player Subsystem）将一个或多个上下文应用到本地玩家，并安排它们的优先次序，避免多个操作由于尝试使用同一输入而发生冲突。

你可以在这里将实际的键与输入动作绑定，并为每个动作指定额外触发器或修饰器。将输入映射上下文添加到增强输入子系统时，你还可以指定其优先级。如果你有多个上下文映射到同一个输入动作，那么在触发输入动作时，将考虑优先级最高的上下文，而忽略其他上下文。

例如，你可以为一个可以游泳、行走、驾驶载具的角色提供多个输入映射上下文。一个用于通用动作（始终可用且始终映射到相同用户输入），其他分别用于各类移动模式。

开发人员随后可以将与载具相关的输入动作放入单独的输入映射上下文中，这些操作将在本地玩家进入载具时添加到玩家，并在退出载具时从本地玩家中移除。

这样做有助于确保不合适的输入动作无法运行，从而优化并预防漏洞。此外，使用互斥的输入映射上下文还有助于避免输入冲突，因此当某个用户输入被用于不同的输入动作时，该输入绝不会意外触发错误的操作。

你可以在蓝图或C++中将映射上下文添加到玩家

```
	// 将映射上下文公开为头文件中的属性...	UPROPERTY(EditAnywhere, Category="Input")	TSoftObjectPtr<UInputMappingContext> InputMapping;	 	 	// 在你的cpp中...	if (ULocalPlayer* LocalPlayer = Cast<ULocalPlayer>(Player))	{		if (UEnhancedInputLocalPlayerSubsystem* InputSystem = LocalPlayer->GetSubsystem<UEnhancedInputLocalPlayerSubsystem>())		{			if (!InputMapping.IsNull())			{				InputSystem->AddMappingContext(InputMapping.LoadSynchronous(), Priority);			}		}	}
```

### 输入修饰器

**输入修饰器（Input Modifiers）** 是一种预处理器，能够修改UE接收的原始输入值，然后再将其发送给输入触发器（Input Trigger）。增强输入插件随附多种输入修饰器，可以执行各种任务，例如更改轴顺序、实现"死区"、将轴输入转换为世界空间。

输入修饰器很适合用于应用灵敏度设置，在多个帧上平滑输入，或基于玩家状态更改输入的行为。由于你在创建自己的修饰器时可以访问 `UPlayerInput` 类，你可以访问所属玩家控制器，并获取所需的任意游戏状态。

你可以通过创建 `UInputModifier` 类的子类并重载 `ModifyRaw_Implementation` 函数，在C++或蓝图中创建自己的输入修饰器。

你还可以通过使用 **输入修饰器（Input Modifier）** 作为父类创建新的 **蓝图子类（Blueprint Child Class）** ，创建自己的输入修饰器。

接下来，找到 **我的蓝图（My Blueprint）> 函数（Functions）> 重载（Override）** 并从 **下拉菜单** 选择 **Modify Raw** 函数。

输出参数是 **输入动作值（Input Action Value）** ，其中包含三个 **浮点** 值，这与 **矢量（Vector）** 非常像。该函数的输入参数包含 **玩家输入（Player Input）** 对象、来自输入硬件或之前输入修饰器的 **当前值（Current Value）** 以及 **增量时间（Delta Time）** 值。

你从 **Modify Raw** 返回的输入动作值将进入下一个输入修饰器（如有），或进入第一个输入触发器。

下面是Lyra游戏示例中使用的输入修饰器示例。

```
	/ ** 基于Lyra共享游戏设置中的某个设置应用轴值反转 * /	UCLASS(NotBlueprintable, MinimalAPI, meta = (DisplayName = "Lyra Aim Inversion Setting"))	class ULyraInputModifierAimInversion : public UInputModifier	{		GENERATED_BODY()		 	protected:		virtual FInputActionValue ModifyRaw_Implementation(const UEnhancedPlayerInput* PlayerInput, FInputActionValue CurrentValue, float DeltaTime) override	{	{		ULyraLocalPlayer* LocalPlayer = LyraInputModifiersHelpers::GetLocalPlayer(PlayerInput);		if (!LocalPlayer)		{			return CurrentValue;		}		 		ULyraSettingsShared* Settings = LocalPlayer->GetSharedSettings();		ensure(Settings);	 		FVector NewValue = CurrentValue.Get<FVector>();		 		if (Settings->GetInvertVerticalAxis())		{			NewValue.Y *= -1.0f;		}		 		if (Settings->GetInvertHorizontalAxis())		{			NewValue.X *= -1.0f;		}		 		return NewValue;	}	}	}; 
```

#### 方向输入

使用单一输入动作实现二维方向输入是解释输入修饰器用途的一个好例子。使用鼠标或游戏手柄的虚拟摇杆时，读取二维移动是很简单的事情，只需创建支持至少两个轴的输入动作，并将相应的输入添加到输入映射上下文即可。

增强输入支持来自一维源的输入，例如键盘的方向键或常用的"WASD"键配置；可通过应用正确的输入修饰器来实现此控制方案。具体而言，使用 **负值（Negate）** 可以将某些键注册为负值，而使用 **交换输入轴值（Swizzle Input Axis Values）** 可以将某些键注册为Y轴，而不是默认的X轴值：

| **字母键** | **方向键** | **所需输入解译** | **必需输入修饰器** |
| --- | --- | --- | --- |
| W | 向上 | 正Y轴 | 交换输入轴值（YXZ或ZXY）（Swizzle Input Axis Values (YXZ or ZXY)） |
| A | 向左 | 负X轴 | 负值（Negate） |
| S | 向下 | 负Y轴 | 负交换输入轴值（YXZ或ZXY）（Negate Swizzle Input Axis Values (YXZ or ZXY)） |
| D | 向右 | 正X轴 | （无） |

这种解译方向键或"WASD"键的方式可以将一维输入映射到二维输入动作。

由于每个键都报告一维正值，此值将始终占据X轴并将在任意给定更新函数上具有值0.0或1.0。通过为向左和向下输入设置负值，并切换轴的顺序使输入的X轴值移至Y轴以用于向上和向下输入，你可以使用输入修饰器将一组一维输入解译为单个二维输入值。

### 输入触发器

输入触发器用于确定用户输入在经过一系列可选输入修饰器的处理后，是否会激活输入映射上下文中的相应输入动作。大部分输入触发器都会分析输入本身，检查最小动作值并验证各种模式，例如短暂点击、长时间按住或典型的"按下"或"释放"事件。此规则的一个例外是"同时按键"输入触发器，该触发器仅通过另一个输入动作触发。默认情况下，任意用户输入活动都会在每次更新时触发一次。

输入触发器有三种类型：

- **显式（Explicit）** 类型将使输入在输入触发器成功时成功。
- **隐式（Implicit）** 类型将使输入仅在输入触发器和所有其他隐式类型输入触发器都成功时成功。
- **阻碍（Blocker）** 类型将使输入在输入触发器成功时失败。

下面是一个逻辑示例，说明每种触发器类型在某种情况下如何与其他触发器类型交互：

```
	隐式 == 0，显式 == 0 - 始终触发，除非值为0。 	隐式 == 0，显式 > 0 - 至少一个显式已触发。 	隐式 > 0，显式 == 0 - 所有隐式已触发。 	隐式 > 0，显式 > 0 - 所有隐式和至少一个显式已触发。 	阻碍 - 重载其他所有触发器，强制触发器失败。
```

处理用户输入后，输入触发器可能返回以下三种状态之一：

- **无（None）** 表明未满足输入触发器的条件，因此输入触发器失败。
- **持续（Ongoing）** 表明部分满足了输入触发器的条件，并且输入触发器正在处理，但尚未成功。
- **已触发（Triggered）** 表明已满足输入触发器的所有条件，因此输入触发器成功。

你可以通过扩展输入触发器基类，或 **Input Trigger Timed Base** 来创建自己的输入触发器。

**Input Trigger Timed Base** 会检查输入是否已被按住一段时间，如是，则接受该输入并返回 **持续（Ongoing）** 状态。

插件提供的"Input Trigger Timed Base"类永远不会返回 **已触发（Triggered）** 状态。你要在新建的输入触发器子类中重载该函数，来确定它如何响应用户输入。函数 **Get Trigger Type** 将确定输入触发器的类型。**更新状态（Update State）** 将接受玩家的输入对象、当前输入动作值、增量时间，并返回 **无（None）** 、 **持续（Ongoing）** 或 **已触发（Triggered）** 状态。

作为C++示例，你可以找到 `InputTriggers.h` 并观察 `UInputTriggerHold` 实现。

**UInputTriggerHold.H**

```
	/** UInputTriggerHold		触发器会在输入保持激活状态达到HoldTimeThreshold秒之后触发。		触发器可以选择触发一次或反复触发。	*/	UCLASS(NotBlueprintable, MinimalAPI, meta = (DisplayName = "Hold"))	class UInputTriggerHold final : public UInputTriggerTimedBase	{		GENERATED_BODY() 		bool bTriggered = false; 	protected: 		virtual ETriggerState UpdateState_Implementation(const UEnhancedPlayerInput* PlayerInput, FInputActionValue ModifiedValue, float DeltaTime) override; 	public:		virtual ETriggerEventsSupported GetSupportedTriggerEvents() const override { return ETriggerEventsSupported::Ongoing; }				// 输入要保持多久才能导致触发？		UPROPERTY(EditAnywhere, Config, BlueprintReadWrite, Category = "Trigger Settings", meta = (ClampMin = "0"))		float HoldTimeThreshold = 1.0f; 		// 此触发器应该仅触发一次，还是在满足保持时间阈值之后每帧触发？		UPROPERTY(EditAnywhere, Config, BlueprintReadWrite, Category = "Trigger Settings")		bool bIsOneShot = false; 		virtual FString GetDebugState() const override { return HeldDuration ? FString::Printf(TEXT("Hold:%.2f/%.2f"), HeldDuration, HoldTimeThreshold) : FString(); }	};
```

**UInputTriggerHold.cpp**

```
	ETriggerState UInputTriggerHold::UpdateState_Implementation(const UEnhancedPlayerInput* PlayerInput, FInputActionValue ModifiedValue, float DeltaTime)	{		// 更新HeldDuration并派生基础状态		ETriggerState State = Super::UpdateState_Implementation(PlayerInput, ModifiedValue, DeltaTime); 		// 在HeldDuration达到阈值时触发		bool bIsFirstTrigger = !bTriggered;		bTriggered = HeldDuration >= HoldTimeThreshold;		if (bTriggered)		{			return (bIsFirstTrigger || !bIsOneShot) ? ETriggerState::Triggered : ETriggerState::None;		} 		return State;	} 
```

## 玩家可映射输入配置（PMI）

可映射配置是输入映射上下文的集合，表示映射的一个"配置"或"预设"。例如，你可以有一个"默认"和一个"左撇子"可映射配置，来保存不同的输入映射上下文。

你可以使用这些配置预定义一组上下文及其优先级，以便一次性全部添加，而不必手动添加一组输入映射上下文。映射提供了各种各样的元数据选项，可用于更轻松地编写UI设置屏幕。

## 调试命令

你可以使用多个与输入相关的调试命令，来调试你需要处理的任意与输入相关的行为。

使用命令 `showdebug enhancedinput` 会显示你的项目的可用输入动作和轴映射。

使用命令：`showdebug devices`

## 注入输入

增强输入还为玩家带来了"注入输入"的概念。这样你可以调用蓝图、C++中的函数，或使用控制台命令模拟玩家的输入。 你可以输入 `Input.+key` 控制台命令开始模拟输入。

下面是设置 `Gamepad_Left2D` 键的示例：

```
	Input.+key Gamepad_Left2D X=0.7 Y=0.5 	Input.-key Gamepad_Left2D
```

键名称是实际的FKey名称，可在 `InputCoreTypes.cpp` 文件中找到，如果你在显示的键名称中删除了空格，还可在键选择器控件中找到。

在蓝图中注入输入

```
	UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PC->GetLocalPlayer());	 	UEnhancedPlayerInput* PlayerInput = Subsystem->GetPlayerInput();	 	FInputActionValue ActionValue(1.0f); // 这可以是布尔、浮点、FVector2D或FVector值	PlayerInput->InjectInputForAction(InputAction, ActionValue); 
```

## 平台设置

你可能希望将不同的输入设置用于不同的平台，例如Nintendo Switch上的旋转脸部按钮，或改变移动设备上可用的动作。增强输入提供了逐平台的 **映射上下文重定向（Mapping Context Redirect）** ，可帮助你轻松做到。

你可以基于 **增强输入平台数据（Enhanced Input Platform Data）** 类创建蓝图。你可以在该基类上构建，为你的游戏添加特定于平台的选项。默认情况下，它包含输入映射上下文的映射，允许你将一个上下文重定向到另一个上下文。

只要在特定平台上引用该映射上下文，它都将在重建映射之后替换为映射中的值。

要应用此重定向，请将其添加到你的 **项目设置（Project Settings）** > **增强输入（Enhanced Input）** > **平台设置（Platform Settings）** > **输入数据（Input Data）**

这些项目设置会添加到平台 `DefaultInput.ini`，这样它们可进行热修复并可轻松更改。由于平台设置提供了基类 `UEnhancedInputPlatformData` ，你可以通过创建自己的蓝图或C++子类来创建自定义平台设置，该子类可用于从任意地方访问设置。

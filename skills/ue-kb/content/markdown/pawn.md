# 玩家输入和Pawn

---
title: "玩家输入和Pawn"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-player-input-in-unreal-engine-cpp"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay教程", "C++编程教程", "玩家输入和Pawn"]
---

# 玩家输入和Pawn

> 路径：虚幻引擎5.7文档 / Gameplay教程 / C++编程教程 / 玩家输入和Pawn

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-player-input-in-unreal-engine-cpp

本教程将讲解如何对Pawn类进行扩展，以便响应玩家的输入操作。

## 1 - 自定义Pawn

> [!TIP]
> 如首次使用 **虚幻引擎**，建议先阅读[编程快速入门](../unreal-engine-cpp-quick-start/index.md)。本教程将假设您已熟悉创建项目、向其添加C++代码，及编译代码。

1. 首先用初学者内容包新建基础代码项目，并命名为HowTo_PlayerInput。之后向项目添加自定义 **Pawn** 类，并命名为MyPawn。

   > [!NOTE]
   > Pawn是一种由真实玩家或AI控制的 **Actor**。
2. 首先对MyPawn进行设置，使其在游戏开始时自动对玩家输入做出响应。该Pawn类提供可在初始化期间设置的变量，该变量可协助处理此操作。在MyPawn.cpp中，将以下代码添加到 **AMyPawn::AMyPawn**：

   ```
            // 将该Pawn设为由最小编号玩家控制         AutoPossessPlayer = EAutoReceiveInput::Player0;		
   ```
3. 然后构建数个基本 **组件**。如要深入了解在代码中添加和管理组件，及遇到的部分常见组件类型的相关信息，请阅读[组件教程](../quick-start-guide-to-components-and-collision-i-18905f7e/index.md)。为了记录创建的组件，应将以下代码添加到MyPawn.h中类定义的底部：

   ```
            UPROPERTY(EditAnywhere)         USceneComponent* OurVisibleComponent;		
   ```

   > [!NOTE]
   > 该变量标记为 **UPROPERTY**，因此其将对 **虚幻引擎** 可见。此设置可防止启动游戏时，或项目/关卡关闭后重新载入时重设该变量。

   回到MyPawn.cpp，应将以下代码添加到AMyPawn::AMyPawn：

   ```
        // 创建可附加内容的虚拟根组件。     RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootComponent"));     // 创建相机和可见对象     UCameraComponent* OurCamera = CreateDefaultSubobject<UCameraComponent>(TEXT("OurCamera"));     OurVisibleComponent = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("OurVisibleComponent"));     // 将相机和可见对象附加到根组件。偏移并旋转相机。     OurCamera->SetupAttachment(RootComponent);     OurCamera->SetRelativeLocation(FVector(-250.0f, 0.0f, 250.0f));     OurCamera->SetRelativeRotation(FRotator(-45.0f, 0.0f, 0.0f));     OurVisibleComponent->SetupAttachment(RootComponent); 
   ```
4. 现在已可使用 **Visual Studio** 中的 **构建** 命令或 **虚幻编辑器** 中的 **编译** 按钮保存更改和编译。

现在便拥有响应游戏输入的自定义Pawn，需定义此输入的内容。为此，将在 **虚幻编辑器** 中配置项目的 **输入设置**。

### 阶段代码示例

**MyPawn.h**

```
	// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "GameFramework/Pawn.h"	#include "MyPawn.generated.h" 	UCLASS()	class HOWTO_PLAYERINPUT_API AMyPawn : public APawn	{		GENERATED_BODY() 	public:		// 设置默认值		AMyPawn(); 	protected:		// 游戏开始或生成时调用		virtual void BeginPlay() override; 	public:		// 逐帧调用		virtual void Tick( float DeltaSeconds ) override; 		// 调用以将功能绑定至输入		virtual void SetupPlayerInputComponent(class UInputComponent* InputComponent) override; 		UPROPERTY(EditAnywhere)		USceneComponent* OurVisibleComponent;	}; 
```

**MyPawn.cpp**

```
	// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#include "HowTo_PlayerInput.h"	#include "MyPawn.h" 	// 设置默认值	AMyPawn::AMyPawn()	{		// 设置该Pawn以逐帧调用Tick()。如无需要，可关闭此项以提高性能。		PrimaryActorTick.bCanEverTick = true; 		// 将该pawn设为由最小编号玩家控制		AutoPossessPlayer = EAutoReceiveInput::Player0; 		// 创建可附加内容的虚拟根组件。		RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootComponent"));		// 创建相机和可见对象		UCameraComponent* OurCamera = CreateDefaultSubobject<UCameraComponent>(TEXT("OurCamera"));		OurVisibleComponent = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("OurVisibleComponent"));		// 将相机和可见对象附加到根组件。偏移并旋转相机。		OurCamera->SetupAttachment(RootComponent);		OurCamera->SetRelativeLocation(FVector(-250.0f, 0.0f, 250.0f));		OurCamera->SetRelativeRotation(FRotator(-45.0f, 0.0f, 0.0f));		OurVisibleComponent->SetupAttachment(RootComponent);	} 	// 游戏开始或生成时调用	void AMyPawn::BeginPlay()	{		Super::BeginPlay(); 	} 	// 逐帧调用	void AMyPawn::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 	} 	// 调用以将功能绑定至输入	void AMyPawn::SetupPlayerInputComponent(class UInputComponent* InputComponent)	{		Super::SetupPlayerInputComponent(InputComponent); 	} 
```

## 2 - 配置游戏输入

共有两种输入映射类型：操作和轴。

- 操作映射

  适用于"是/否"输入，例如鼠标或手柄上的按钮。被按下、松开、双击或短时长按时，其将进行报告。跳跃、射击或与物体互动等离散操作是这类映射的理想对象。
- 轴映射

  是连续的，可将其视为"程度"输入，例如手柄上的摇杆，或者鼠标光标的位置。其会逐帧报告自身的值，即使未移动也进行报告。通常使用此方法处理如行走、四处查看和操纵车辆等有量级或方向的对象。

虽然可直接在代码中定义输入映射，但常用方法是在 **虚幻引擎** 编辑器中定义，本教程也将使用此方法。

1. 在 **虚幻引擎** 编辑器中，在 **编辑** 下拉菜单下，点击 **项目设置** 选项。
2. 在此界面左侧的 **引擎（Engine）** 部分中选择 **输入** 选项。之后，展开右侧显示的 **绑定** 类别，添加 **操作映射（Action Mapping）** 和两个 **轴映射（Axis Mappings）**。

   **操作映射** 或 **轴映射** 部分标题旁的加号可用于添加新映射。左侧的扩展箭头可用于显示或隐藏映射。 要向映射添加额外输入，点击该映射旁的加号。以下是所需映射和输入。记录S和A输入的负值。

   | 列 1 | 列 2 | 列 3 |
   | --- | --- | --- |
   | 操作映射 |  |  |
   | Grow | 空格 |  |

   | 列 1 | 列 2 | 列 3 |
   | --- | --- | --- |
   | 轴映射 |  |  |
   | MoveX | W | 1.0 |
   |  | S | -1.0 |
   | MoveY | A | -1.0 |
   |  | D | 1.0 |
3. 输入现已配置完成，接下来在关卡中设置MyPawn。**MyPawn** 类将在 **内容浏览器** 中显示，并可被拖入 **关卡编辑器**。
4. 设置MyPawn还需一个步骤。需向其指定 **静态网格体**，以便其可在游戏中显示。具体操作：选择刚创建的MyPawn，在 **细节**面板 中选择名为 **OurVisibleComponent (Inherited)** 的组件，并利用 **静态网格体** 类别中的下拉框向其指定资源。在本教程中，**Shape_Cylinder** 为现成资源。
5. 现在保存关卡，返回 **Visual Studio** 编写代码，使刚刚放置的MyPawn对定义的输入做出反应。

现在准备在 **Visual Studio** 中完成MyPawn类的编码。

## 3 - 编写和绑定游戏操作

1.在 **Visual Studio** 中，打开MyPawn.h并将以下代码添加到MyPawn类定义的底部：

//输入函数 void Move_XAxis(float AxisValue); void Move_YAxis(float AxisValue); void StartGrowing(); void StopGrowing();

//输入变量 FVector CurrentVelocity; bool bGrowing;

> [!NOTE]
> 四个输入函数将被绑定到输入事件。其运行时，将对新输入变量中存储的值进行更新，MyPawn将使用此类值决定游戏期间应执行的操作。

1. 将切换为MyPawn.cpp，并对刚才声明的四个函数编码。添加以下代码：

   ```
            void AMyPawn::Move_XAxis(float AxisValue)         {             // 以100单位/秒的速度向前或向后移动             CurrentVelocity.X = FMath::Clamp(AxisValue, -1.0f, 1.0f) * 100.0f;         }		         void AMyPawn::Move_YAxis(float AxisValue)         {             // 以100单位/秒的速度向右或向左移动             CurrentVelocity.Y = FMath::Clamp(AxisValue, -1.0f, 1.0f) * 100.0f;         }		         void AMyPawn::StartGrowing()         {             bGrowing = true;         }		         void AMyPawn::StopGrowing()         {             bGrowing = false;         }
   ```

   使用 **FMath::Clamp** 约束输入中得到的值，将其约束在-1到+1的范围内。虽然本例中不存在此问题，但若有会对轴产生相同影响的多个键，则玩家同时按下此类输入时会将累加这些值。例如，如W键和向上方向键均映射到MoveX，且缩放均为1.0，同时按下这两个键会得到2.0的AxisValue。如不进行限制，玩家将以两倍速度移动。

   > [!NOTE]
   > 可以看到，两个"Move"函数将轴值视作浮点，而"Grow"则不同。这是因为其映射到MoveX和MoveY，均为轴映射，因此拥有浮点参数。操作映射无此参数。
2. 现在已定义输入函数，接下来需进行绑定，以便对相应输入做出反应。将以下代码添加到 **AMyPawn::SetupPlayerInputComponent** 中：

   ```
            // 在按下或松开"Grow"键时做出响应。         InputComponent->BindAction("Grow", IE_Pressed, this, &AMyPawn::StartGrowing);         InputComponent->BindAction("Grow", IE_Released, this, &AMyPawn::StopGrowing);		         // 对两个移动轴"MoveX"和"MoveY"的值逐帧反应。         InputComponent->BindAxis("MoveX", this, &AMyPawn::Move_XAxis);         InputComponent->BindAxis("MoveY", this, &AMyPawn::Move_YAxis);		
   ```
3. 变量现在将根据配置的输入进行更新。接下来只需编写代码使其完成部分操作。将以下代码添加到 **AMyPawn::Tick**：

   ```
            // 根据"Grow"操作处理增长和缩减         {             float CurrentScale = OurVisibleComponent->GetComponentScale().X;             if (bGrowing)             {                 // 一秒内增长到两倍大小                 CurrentScale += DeltaTime;             }             else             {                 // 以增长速度缩减一半                 CurrentScale -= (DeltaTime * 0.5f);             }             // 确保不会降至初始大小以下，或者增至两倍大小以上。             CurrentScale = FMath::Clamp(CurrentScale, 1.0f, 2.0f);             OurVisibleComponent->SetWorldScale3D(FVector(CurrentScale));         }		         // 根据"MoveX"和"MoveY"轴处理移动         {             if (!CurrentVelocity.IsZero())             {                 FVector NewLocation = GetActorLocation() + (CurrentVelocity * DeltaTime);                 SetActorLocation(NewLocation);             }         }		
   ```
4. 编译代码后，可返回 **虚幻编辑器** 并按 **运行**。应可使用WASD键控制 **Pawn**，同时可通过长按 **空格** 键来使其增长，松开空格键时看到缩小。

## 最终代码

**MyPawn.h**

```
	// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "GameFramework/Pawn.h"	#include "MyPawn.generated.h" 	UCLASS()	class HOWTO_PLAYERINPUT_API AMyPawn : public APawn	{		GENERATED_BODY() 	public:		// 设置默认值		AMyPawn(); 	protected:		// 游戏开始或生成时调用		virtual void BeginPlay() override; 	public:		// 逐帧调用		virtual void Tick(float DeltaSeconds) override; 		// 调用以将功能绑定至输入		virtual void SetupPlayerInputComponent(class UInputComponent* InputComponent) override; 		UPROPERTY(EditAnywhere)		USceneComponent* OurVisibleComponent; 		//输入函数		void Move_XAxis(float AxisValue);		void Move_YAxis(float AxisValue);		void StartGrowing();		void StopGrowing(); 		//输入变量		FVector CurrentVelocity;		bool bGrowing;	}; 
```

**MyPawn.cpp**

```
	// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#include "HowTo_PlayerInput.h"	#include "MyPawn.h" 	// 设置默认值	AMyPawn::AMyPawn()	{		// 设置该Pawn以逐帧调用Tick()。如无需要，可关闭此项以提高性能。		PrimaryActorTick.bCanEverTick = true; 		// 将该pawn设为由最小编号玩家控制		AutoPossessPlayer = EAutoReceiveInput::Player0; 		// 创建可附加内容的虚拟根组件。		RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootComponent"));		// 创建相机和可见对象		UCameraComponent* OurCamera = CreateDefaultSubobject<UCameraComponent>(TEXT("OurCamera"));		OurVisibleComponent = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("OurVisibleComponent"));		// 将相机和可见对象附加到根组件。偏移并旋转相机。		OurCamera->SetupAttachment(RootComponent);		OurCamera->SetRelativeLocation(FVector(-250.0f, 0.0f, 250.0f));		OurCamera->SetRelativeRotation(FRotator(-45.0f, 0.0f, 0.0f));		OurVisibleComponent->SetupAttachment(RootComponent);	} 	// 游戏开始或生成时调用	void AMyPawn::BeginPlay()	{		Super::BeginPlay(); 	} 	// 逐帧调用	void AMyPawn::Tick(float DeltaTime)	{		Super::Tick(DeltaTime); 		// 根据"Grow"操作处理增长和缩减		{			float CurrentScale = OurVisibleComponent->GetComponentScale().X;			if (bGrowing)			{				// 一秒内增长到两倍大小				CurrentScale += DeltaTime;			}			else			{				// 以增长速度缩减一半				CurrentScale -= (DeltaTime * 0.5f);			}			// 确保不会降至初始大小以下，或者增至两倍大小以上。			CurrentScale = FMath::Clamp(CurrentScale, 1.0f, 2.0f);			OurVisibleComponent->SetWorldScale3D(FVector(CurrentScale));		} 		// 根据"MoveX"和"MoveY"轴处理移动		{			if (!CurrentVelocity.IsZero())			{				FVector NewLocation = GetActorLocation() + (CurrentVelocity * DeltaTime);				SetActorLocation(NewLocation);			}		}	} 	// 调用以将功能绑定至输入	void AMyPawn::SetupPlayerInputComponent(class UInputComponent* InputComponent)	{		Super::SetupPlayerInputComponent(InputComponent); 		// 在按下或松开"Grow"键时做出响应。		InputComponent->BindAction("Grow", IE_Pressed, this, &AMyPawn::StartGrowing);		InputComponent->BindAction("Grow", IE_Released, this, &AMyPawn::StopGrowing); 		// 对两个移动轴"MoveX"和"MoveY"的值逐帧反应。		InputComponent->BindAxis("MoveX", this, &AMyPawn::Move_XAxis);		InputComponent->BindAxis("MoveY", this, &AMyPawn::Move_YAxis);	} 	void AMyPawn::Move_XAxis(float AxisValue)	{		// 以100单位/秒的速度向前或向后移动		CurrentVelocity.X = FMath::Clamp(AxisValue, -1.0f, 1.0f) * 100.0f;	} 	void AMyPawn::Move_YAxis(float AxisValue)	{		// 以100单位/秒的速度向右或向左移动		CurrentVelocity.Y = FMath::Clamp(AxisValue, -1.0f, 1.0f) * 100.0f;	} 	void AMyPawn::StartGrowing()	{		bGrowing = true;	} 	void AMyPawn::StopGrowing()	{		bGrowing = false;	} 
```

## 4 - 自行尝试！

利用所学内容，尝试以下操作：

- 实现定向控制，长按一段时间后其可增加速度。
- 创建特殊输入序列，用户开始按

  轴映射

  后立即按

  操作映射

  时，此序列会即刻将对象扩展到完整缩放。

关于本教程中涵盖的细节：

- 欲了解

  输入

  的更多相关信息，请阅读

  %making-interactive-experiences/Input:title%

  页面。
- 欲学习更多教程，参见

  %programming-and-scripting/programming-language-implementation/cpp-in-unreal-engine/tutorials:title%

  页面。


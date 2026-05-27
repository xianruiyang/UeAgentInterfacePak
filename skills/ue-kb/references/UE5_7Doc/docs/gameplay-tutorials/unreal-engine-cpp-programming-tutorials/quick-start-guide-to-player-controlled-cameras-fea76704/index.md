---
title: "玩家控制的摄像机"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-player-controlled-cameras-in-unreal-engine-cpp"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay教程", "C++编程教程", "玩家控制的摄像机"]
---

# 玩家控制的摄像机

> 路径：虚幻引擎5.7文档 / Gameplay教程 / C++编程教程 / 玩家控制的摄像机

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-player-controlled-cameras-in-unreal-engine-cpp

本教程将讲解如何激活摄像机，以及如何将你的活跃摄像机从一台变更为另一台的方法。

## 1. 将摄像机连接到Pawn

1. 首先打开 **虚幻引擎**，然后新建一个空白模板。
2. 选择一个新的游戏项目。在项目设置窗口中，我们将默认代码从Blueprint改为C++，并启用启动内容。 选择你希望虚幻项目保存的目录，然后将你的项目命名为HowTo_PlayerCamera，然后点击创建项目。
3. 在源码面板中，找到到你的C++类文件夹。你应该能看到一个单类，包含你的游戏模式基类。在相邻的灰色空间上单击右键，从下拉窗口中选择 **新建C++类（New C++ class）**。
4. 选择Pawn作为父类，然后点击下一步。把新的Pawn命名为PawnWithCamera。
5. 在Visual Studio中，找到 `PawnWithCamera.h` 文件，并在类的protect命名空间下添加如下代码：

   ```
            protected:             UPROPERTY(EditAnywhere)             class USpringArmComponent* SpringArmComp;		             UPROPERTY(EditAnywhere)             class UCameraComponent* CameraComp;		             UPROPERTY(EditAnywhere)             UStaticMeshComponent* StaticMeshComp;
   ```

这些变量会创建一个 **SpringArmComponent**，并在末端绑定一个 **CameraComponent**。弹簧臂是一种绑定摄像机（或其它 **组件** ）的简单方式，能让摄像机跟随拍摄对象时平稳自然。

1. 找到 `PawnWithCamera.cpp` 并声明如下代码：

   ```
            #include "GameFramework/SpringArmComponent.h"         #include "Camera/Component.h"		
   ```
2. 在此之后，我们需要在构造函数中创建 **组件** 。 添加如下代码到 **APawnWithCamera::APawnWithCamera** 的`PawnWithCamera.cpp`中：

   ```
            //创建组件         RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootSceneComponent"));         StaticMeshComp = CreateDefaultSubobject <UStaticMeshComponent>(TEXT("StaticMeshComponent"));         SpringArmComp = CreateDefaultSubobject<USpringArmComponent>(TEXT("SpringArmComponent"));         CameraComp = CreateDefaultSubobject<UCameraComponent>(TEXT("CameraComponent"));		         //绑定组件         StaticMeshComp->SetupAttachment(RootComponent);         SpringArmComp->SetupAttachment(StaticMeshComp);         CameraComp->SetupAttachment(SpringArmComp,USpringArmComponent::SocketName);		         //为SpringArm类的变量赋值。         SpringArmComp->SetRelativeLocationAndRotation(FVector(0.0f, 0.0f, 50.0f), FRotator(-60.0f, 0.0f, 0.0f));         SpringArmComp->TargetArmLength = 400.f;         SpringArmComp->bEnableCameraLag = true;         SpringArmComp->CameraLagSpeed = 3.0f;
   ```

我们创建了一个 **SceneComponent** 作为当前 **组件** 层级的根节点，然后在它下面添加了一个 **StaticMeshComponent**。之后，我们又创建了一个 **SpringArmComponent** 和一个 **摄像机** 组件，并且将摄像机组件绑定到了弹簧臂末端的插槽上。弹簧臂的默认角度被设置为-60度，并且位于根节点上方50单位。我们还为 **SpringArmComponent** 声明了一些变量，用于设置它的长度和移动平滑程度。

1. 最后，我们要让默认的玩家控制器在构造函数中控制我们的Pawn。

   ```
            //控制默认玩家         AutoPossessPlayer = EAutoReceiveInput::Player0;		
   ```

我们现在有一个简单的 **Pawn** ，可以让我们自如控制摄像机。接下来，我们要在 **虚幻引擎** 编辑器中配置输入并创建响应代码。

## 部分代码示例

**PawnWithCamera.h**

```
	// Copyright 1998-2021 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "CoreMinimal.h"	#include "GameFramework/Pawn.h"	#include "PawnWithCamera.generated.h" 	UCLASS()	class HOWTO_PLAYERCAMERA_API APawnWithCamera : public APawn	{		GENERATED_BODY() 	public:		// 为Pawn的属性设置默认值		APawnWithCamera(); 	protected:		// 游戏开始时或对象生成时调用		virtual void BeginPlay() override; 	public:		// 每帧调用		virtual void Tick( float DeltaSeconds ) override; 		// 用于绑定功能和输入		virtual void SetupPlayerInputComponent(class UInputComponent* InputComponent) override; 	protected:		UPROPERTY(EditAnywhere)		class USpringArmComponent* SpringArmComp; 		UPROPERTY(EditAnywhere)		class UCameraComponent* CameraComp; 	    UPROPERTY(EditAnywhere)		UStaticMeshComponent* StaticMeshComp; 	}; 
```

**PawnWithCamera.cpp**

```
	// Copyright 1998-2021 Epic Games, Inc. All Rights Reserved. 	#include "HowTo_PlayerCamera.h"	#include "PawnWithCamera.h"	#include "GameFramework/SpringArmComponent.h"	#include "Camera/CameraComponent.h" 	// 设置默认值	APawnWithCamera::APawnWithCamera()	{		// 让这个Pawn每帧调用Tick()。如不需要，你可以关闭这个函数以便提升性能。		PrimaryActorTick.bCanEverTick = true; 		// 创建组件		RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootSceneComponent"));		StaticMeshComp = CreateDefaultSubobject <UStaticMeshComponent>(TEXT("StaticMeshComponent"));		SpringArmComp = CreateDefaultSubobject<USpringArmComponent>(TEXT("SpringArmComponent"));		CameraComp = CreateDefaultSubobject<UCameraComponent>(TEXT("CameraComponent")); 		// 绑定组件		StaticMeshComp->SetupAttachment(RootComponent);		SpringArmComp->SetupAttachment(StaticMeshComp);		CameraComp->SetupAttachment(SpringArmComp,USpringArmComponent::SocketName); 		// 为SpringArm类的变量赋值		SpringArmComp->SetRelativeLocationAndRotation(FVector(0.0f, 0.0f, 50.0f), FRotator(-60.0f, 0.0f, 0.0f));		SpringArmComp->TargetArmLength = 400.f;		SpringArmComp->bEnableCameraLag = true;		SpringArmComp->CameraLagSpeed = 3.0f; 		// 控制默认玩家		AutoPossessPlayer = EAutoReceiveInput::Player0;	} 	// 游戏开始时或对象生成时调用	void APawnWithCamera::BeginPlay()	{		Super::BeginPlay(); 	} 	// 每帧调用	void APawnWithCamera::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 	} 	// 用于绑定功能和输入	void APawnWithCamera::SetupPlayerInputComponent(class UInputComponent* InputComponent)	{		Super::SetupPlayerInputComponent(InputComponent); 	} 
```

## 2.配置输入以控制摄像机

你首先要确定使用哪些输入按键来控制你的摄像机和Pawn，然后进行相应设置。在这个项目中，我们希望按住鼠标右键后，跟随距离会变小并且视野会放大。

1. 我们还希望使用鼠标来控制视角，并且用 WASD 键控制 **Pawn** 的移动。为此，在 **虚幻引擎** 编辑器中点击"编辑"下拉菜单，然后打开 **项目设置**。
2. 在"项目设置"窗口中，找到 **Engine>Input>Bindings**。然后，点击动作和轴映射旁边的 **+** 标志，添加一个新的键值对。
3. 参照下表来定义 **动作映射（Action Mapping）** 和 **轴映射（Axis Mappings）** 。

   | 列 1 | 列 2 | 列 3 |
   | --- | --- | --- |
   | **动作映射：** |  |  |
   | 放大 | 鼠标右键 |  |

   | 列 1 | 列 2 | 列 3 |
   | --- | --- | --- |
   | **轴映射：** |  |  |
   | 向前移动 | W | 1.0 |
   |  | S | -1.0 |
   | 向右移动 | A | -1.0 |
   |  | D | 1.0 |
   | 摄像机倾斜 | MouseY | 1.0 |
   | 摄像机偏转 | MouseX | 1.0 |

   > [!NOTE]
   > 如果你想要了解更多关于输入映射的原理，你可以查看[玩家输入和Pawn](../quick-start-guide-to-player-input-in-unreal-engine-cpp/index.md)教程。

现在我们已经完成了对输入的定义，需要写一些代码来对其进行响应。 我们返回 **Visual Studio** 来进行下一步的工作

## 3.编写C++代码以便响应输入操作

你应该已经在项目设置中为输入按键创建了映射。为了能够利用这些输入，让我们编写代码并设置一些成员变量来存储我们接收到的数据吧。 在Event Tick更新时，你需要获取移动数据和鼠标轴的移动方向数据，它们都是二维向量类型的数值。

你还需要了解接下来摄像机画面应该是放大还是缩小，以及摄像机当前距离这两种状态有多少距离。

1. 首先在PawnWithCamera.h的类的protect下添加以下代码：

   ```
            //输入变量         FVector2D MovementInput;         FVector2D CameraInput;         float ZoomFactor;         bool bZoomingIn;		
   ```
2. 你需要创建函数来跟踪输入，因此，让我们在`PawnWithCamera.h`中添加如下代码：

   ```
            // 输入函数         void MoveForward(float AxisValue);         void MoveRight(float AxisValue);         void PitchCamera(float AxisValue);         void YawCamera(float AxisValue);         void ZoomIn();         void ZoomOut();		
   ```
3. 接着打开PawnWithCamera.Cpp文件，添加下列代码，实现函数逻辑：

   ```
            // 输入函数         void APawnWithCamera::MoveForward(float AxisValue)         {             MovementInput.X = FMath::Clamp<float>(AxisValue, -1.0f, 1.0f);         }		         void APawnWithCamera::MoveRight(float AxisValue)         {             MovementInput.Y = FMath::Clamp<float>(AxisValue, -1.0f, 1.0f);         }		         void APawnWithCamera::PitchCamera(float AxisValue)         {             CameraInput.Y = AxisValue;         }		         void APawnWithCamera::YawCamera(float AxisValue)         {             CameraInput.X = AxisValue;         }		         void APawnWithCamera::ZoomIn()         {             bZoomingIn = true;         }		         void APawnWithCamera::ZoomOut()         {             bZoomingIn = false;         }		
   ```

   > [!NOTE]
   > 我们还没有使用ZoomFactor完成任何内容。这个变量将会在 **Pawn** 的 **Tick（更新）** 函数中更新，因为它的值会基于按键的状态不断变更。
4. 现在你已经有了存储输入数据的函数，接着要告知引擎何时调用该代码。你需要把Pawn的输入事件和函数相绑定，方法是添加如下代码到 **APawnWithCamera::SetupPlayerInputComponent** 中：

   ```
          // 绑定"ZoomIn"的事件       InputComponent->BindAction("ZoomIn", IE_Pressed, this, &APawnWithCamera::ZoomIn);       InputComponent->BindAction("ZoomIn", IE_Released, this, &APawnWithCamera::ZoomOut);		       //为四条轴绑定事件（每帧调用）       InputComponent->BindAxis("MoveForward", this, &APawnWithCamera::MoveForward);       InputComponent->BindAxis("MoveRight", this, &APawnWithCamera::MoveRight);       InputComponent->BindAxis("CameraPitch", this, &APawnWithCamera::PitchCamera);       InputComponent->BindAxis("CameraYaw", this, &APawnWithCamera::YawCamera);		
   ```
5. 最后，你可以使用 **Tick** 函数中的这些值来每帧更新 **Pawn** 和 **Camera**。以下代码块应添加到`PawnWithCamera.cpp`的 **APawnWithCamera::Tick** 中：

   ```
            //如果按下了放大按钮则放大，否则就缩小         {             if (bZoomingIn)             {                 ZoomFactor += DeltaTime / 0.5f;			//Zoom in over half a second             }             else             {                 ZoomFactor -= DeltaTime / 0.25f;		//Zoom out over a quarter of a second             }             ZoomFactor = FMath::Clamp<float>(ZoomFactor, 0.0f, 1.0f);		             //根据ZoomFactor来设置摄像机的视场和弹簧臂的长度             CameraComp->FieldOfView = FMath::Lerp<float>(90.0f, 60.0f, ZoomFactor);             SpringArmComp->TargetArmLength = FMath::Lerp<float>(400.0f, 300.0f, ZoomFactor);         }
   ```

   > [!NOTE]
   > 这段代码多处用到了硬编码，比如半秒和四分之一秒的缩放时间，90度视场的60度视场，以及400和300的摄像机距离。一般来说，这些值应该在编辑器中显示，所以要为它们添加 **UPROPERTY(EditAnywhere)** 的标签。在这个示例中，我们用到了UPROPERTY(EditAnywhere)，方便程序员之外的开发人员更改参数的值。这还能让程序员不用重新编译代码就能调整数值，或者在编辑器中玩游戏时动态地调整数值。

   ```
        //旋转Actor的偏转角度，这样摄像机也能旋转，因为摄像机与Actor相互绑定     {         FRotator NewRotation = GetActorRotation();         NewRotation.Yaw += CameraInput.X;         SetActorRotation(NewRotation);     }      // 旋转摄像机的俯仰角度，但要对其进行限制，这样我们就能始终俯视Actor     {         FRotator NewRotation = OurCameraSpringArm->GetComponentRotation();         NewRotation.Pitch = FMath::Clamp(NewRotation.Pitch + CameraInput.Y, -80.0f, -15.0f);         SpringArmComp->SetWorldRotation(NewRotation);     }
   ```

   这个代码段会直接使用鼠标的X轴来旋转 **Pawn** 的偏转，但只有相机系统会对来自鼠标Y轴的倾斜变更来进行响应。 旋转任意 **Actor** 或 **Actor** 子类实际上会旋转根级 **组件** ，而这又会间接地影响所有附着的内容。

   ```
        // 基于"MoveX"和 "MoveY"坐标轴来处理移动     {         if (!MovementInput.IsZero())         {             // 把移动轴的输入数值放大100倍             MovementInput = MovementInput.SafeNormal() * 100.0f;             FVector NewLocation = GetActorLocation();             NewLocation += GetActorForwardVector() * MovementInput.X * DeltaTime;             NewLocation += GetActorRightVector() * MovementInput.Y * DeltaTime;             SetActorLocation(NewLocation);         }     }
   ```

   借助 **GetActorForwardVector** 和 **GetActorRightVector**，我们可以朝着Actor的朝向移动。由于摄像机朝的向和Actor一样，这使得我们按下"前进键"后，始终能朝着玩家所看的方向移动。
6. 恭喜你！我们已经完成了代码编写。你现在可以编译代码，并将这个新建的类从 **内容浏览器** 中拖到 **虚幻引擎** 编辑器的 **关卡编辑器** 窗口中，创建一个实例。

   你可以随意添加 **Static Mesh（静态网格物体）** 或其它可视化 **组件** ，或者索性不添加。摄像机在关卡中会一直跟随你，并且摄像机的加速和减速应该会很平滑，但摄像机的旋转会十分即时、紧凑的。尝试调整 **SpringArmComponent** 的属性，感受它们带来的影响，比如添加 "Camera Rotation Lag（摄像机旋转延迟）" 或增大/降低 "Camera Lag（摄像机延迟）"。
7. 代码的完整示例如下：

   **摄像机的俯仰/偏转**

   **向前移动/向右移动**

   **放大/缩小**

## 最终代码

**PawnWithCamera.h**

```
	// Copyright 1998-2021 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "CoreMinimal.h"	#include "GameFramework/Pawn.h"	#include "PawnWithCamera.generated.h" 	UCLASS()	class HOWTO_PLAYERCAMERA_API APawnWithCamera : public APawn	{		GENERATED_BODY() 	public:		// 为Pawn的属性设置默认值		APawnWithCamera(); 	protected:		// 游戏开始时或对象生成时调用		virtual void BeginPlay() override; 	public:		// 每帧调用		virtual void Tick( float DeltaSeconds ) override; 		// 用于绑定功能和输入		virtual void SetupPlayerInputComponent(class UInputComponent* InputComponent) override; 	protected: 		UPROPERTY(EditAnywhere)		class USpringArmComponent* OurCameraSpringArm; 		UPROPERTY(EditAnywhere)		class UCameraComponent* OurCamera; 		UPROPERTY(EditAnywhere)		UStaticMeshComponent* StaticMeshComp; 		// 输入变量		FVector2D MovementInput;		FVector2D CameraInput;		float ZoomFactor;		bool bZoomingIn; 		// 输入函数		void MoveForward(float AxisValue);		void MoveRight(float AxisValue);		void PitchCamera(float AxisValue);		void YawCamera(float AxisValue);		void ZoomIn();		void ZoomOut();	}; 
```

**PawnWithCamera.cpp**

```
	// Copyright 1998-2021 Epic Games, Inc. All Rights Reserved. 	#include "PawnWithCamera.h"	#include "GameFramework/SpringArmComponent.h"	#include "Camera/CameraComponent.h" 	// 设置默认值	APawnWithCamera::APawnWithCamera()	{		// 让这个Pawn每帧调用Tick()。如不需要，你可以关闭这个函数以便提升性能。		PrimaryActorTick.bCanEverTick = true; 		// 创建组件		RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("RootComponent"));		StaticMeshComp = CreateDefaultSubobject <UStaticMeshComponent>(TEXT("StaticMeshComponent"));		SpringArmComp = CreateDefaultSubobject<USpringArmComponent>(TEXT("SpringArmComponent"));		CameraComp = CreateDefaultSubobject<UCameraComponent>(TEXT("CameraComponent")); 		StaticMeshComp->SetupAttachment(RootComponent);		SpringArmComp->SetupAttachment(StaticMeshComp);		CameraComp->SetupAttachment(SpringArmComp,USpringArmComponent::SocketName); 		// 设置SpringArmComponent的默认数值和行为		SpringArmComp->SetRelativeLocationAndRotation(FVector(0.0f, 0.0f, 50.0f), FRotator(-60.0f, 0.0f, 0.0f));		SpringArmComp->TargetArmLength = 400.f;		SpringArmComp->bEnableCameraLag = true;		SpringArmComp->CameraLagSpeed = 3.0f; 		// 控制默认玩家		AutoPossessPlayer = EAutoReceiveInput::Player0;	} 	// 游戏开始时或对象生成时调用	void APawnWithCamera::BeginPlay()	{		Super::BeginPlay(); 	} 	// 每帧调用	void APawnWithCamera::Tick( float DeltaTime )	{		Super::Tick(DeltaTime); 		// 按下ZoomIn按钮时进行放大，否则恢复正常		{			if (bZoomingIn)			{				ZoomFactor += DeltaTime / 0.5f;			//Zoom in over half a second			}			else			{				ZoomFactor -= DeltaTime / 0.25f;		//Zoom out over a quarter of a second			}			ZoomFactor = FMath::Clamp<float>(ZoomFactor, 0.0f, 1.0f);			// 基于ZoomFactor设置摄像机的视野和SpringArm的长度			CameraComp->FieldOfView = FMath::Lerp<float>(90.0f, 60.0f, ZoomFactor);			SpringArmComp->TargetArmLength = FMath::Lerp<float>(400.0f, 300.0f, ZoomFactor);		} 		// 旋转Actor的偏转角度，由于摄像机与Actor相互绑定，因此摄像机也会偏转		{			FRotator NewRotation = GetActorRotation();			NewRotation.Yaw += CameraInput.X;			SetActorRotation(NewRotation);		} 		// 旋转摄像机的俯仰角度，但对其进行限制，确保我们始终朝下看		{			FRotator NewRotation = SpringArmComp->GetComponentRotation();			NewRotation.Pitch = FMath::Clamp(NewRotation.Pitch + CameraInput.Y, -80.0f, -15.0f);			SpringArmComp->SetWorldRotation(NewRotation);		} 		// 根据"MoveX"和"MoveY"的处理移动		{			if (!MovementInput.IsZero())			{				//Scale our movement input axis values by 100 units per second				MovementInput = MovementInput.SafeNormal() * 100.0f;				FVector NewLocation = GetActorLocation();				NewLocation += GetActorForwardVector() * MovementInput.X * DeltaTime;				NewLocation += GetActorRightVector() * MovementInput.Y * DeltaTime;				SetActorLocation(NewLocation);			}		}	} 	// 用于绑定输入和函数	void APawnWithCamera::SetupPlayerInputComponent(class UInputComponent* InputComponent)	{		Super::SetupPlayerInputComponent(InputComponent); 		// 为"ZoomIn"事件绑定函数		InputComponent->BindAction("ZoomIn", IE_Pressed, this, &APawnWithCamera::ZoomIn);		InputComponent->BindAction("ZoomIn", IE_Released, this, &APawnWithCamera::ZoomOut); 		// 分别为四个方向轴的移动事件绑定函数		InputComponent->BindAxis("MoveForward", this, &APawnWithCamera::MoveForward);		InputComponent->BindAxis("MoveRight", this, &APawnWithCamera::MoveRight);		InputComponent->BindAxis("CameraPitch", this, &APawnWithCamera::PitchCamera);		InputComponent->BindAxis("CameraYaw", this, &APawnWithCamera::YawCamera);	} 	// 输入函数	void APawnWithCamera::MoveForward(float AxisValue)	{		MovementInput.X = FMath::Clamp<float>(AxisValue, -1.0f, 1.0f);	} 	void APawnWithCamera::MoveRight(float AxisValue)	{		MovementInput.Y = FMath::Clamp<float>(AxisValue, -1.0f, 1.0f);	} 	void APawnWithCamera::PitchCamera(float AxisValue)	{		CameraInput.Y = AxisValue;	} 	void APawnWithCamera::YawCamera(float AxisValue)	{		CameraInput.X = AxisValue;	} 	void APawnWithCamera::ZoomIn()	{		bZoomingIn = true;	} 	void APawnWithCamera::ZoomOut()	{		bZoomingIn = false;	} 
```

## 4.自行尝试！

利用你学到的知识，试着完成以下任务：

- 为玩家添加一个奔跑按键，按住它后将增加

  Pawn

  的移动速度。
- 尝试不同的方式，试着混合使用摄像机自动移动和输入驱动的摄像机移动。这是一个非常深奥的游戏开发领域，有很多值得探索的地方！
- 增加、减少或消除

  弹簧组件（Spring Component）

  的滞后效果（Lag），试着进一步理解滞后对摄像机的整体影响。
- 实现少量的周期运动，如有可能的话，略微应用一些随机效果，或者使用

  曲线（Curve）

  资产，以便为你的摄像机创建一种手持的感觉。
- 为你的

  摄像机（Camera）

  实现一定程度的自动旋转功能，以便摄像机会逐渐移到玩家的移动对象后面，并朝向玩家移动的方向。

有关本教程介绍的细节：

- 关机摄像机以及控制它们的更多信息，请查阅

  摄像机

  框架页面。
- 要了解

  组件（Components）

  的更多信息，请尝试阅读

  组件

  。

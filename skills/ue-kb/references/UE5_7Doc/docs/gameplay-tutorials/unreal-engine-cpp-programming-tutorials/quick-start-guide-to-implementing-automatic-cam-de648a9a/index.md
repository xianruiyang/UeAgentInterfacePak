---
title: "游戏摄像机"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-implementing-automatic-camera-control-in-unreal-engine-cpp"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay教程", "C++编程教程", "游戏摄像机"]
---

# 游戏摄像机

> 路径：虚幻引擎5.7文档 / Gameplay教程 / C++编程教程 / 游戏摄像机

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-to-implementing-automatic-camera-control-in-unreal-engine-cpp

本教程将会向你展示如何激活摄像机以及如何切换你激活的摄像机。

## 1 - 在场景中放置摄像机

> [!TIP]
> 如果你是 **虚幻引擎** (UE)的新手，你可需要先阅读我们的[编程快速入门教程](../unreal-engine-cpp-quick-start/index.md)。对于本教程，我们假设你熟悉以下操作：创建项目，向项目添加C++代码，编译代码，以及在虚幻引擎中向 **Actor** 添加 **组件**

1. 我们将从创建一个新的基本代码项目开始，名为"HowTo_AutoCamera"，其中包含初学者内容。我们需要做的第一件事是在我们的场景中创建两个摄像机。由于设置摄像机有多种方法，在这里我们将使用最常见的两种方法。对于我们的第一个摄像机，找到 **放置Actor（Place Actors）** 面板并选中 **所有类（All Classes）** 选项卡，你将找到一个 **摄像机（Camera）** Actor。将其拖拽到 **关卡编辑器（Level Editor）** 中，并将其放置在合适的位置，以便它能清楚地看到我们的场景。

   完成此操作后，只要我们选择了新的 **摄像机Actor（Camera Actor）**，**关卡编辑器（Level Editor）** 窗口就会有一个画中画视图，显示该 **摄像机Actor（Camera Actor）** 可以看到的内容。
2. 对于我们的第二个摄像机，我们将使用一种更深入的方法，让我们可以进行更多的控制。首先，单击 **放置Actor（Place Actor）** 面板的 **基本（Basic）** 选项卡，将一个 **立方体（Cube）** 拖放到 **关卡编辑器（Level Editor）** 窗口中。

   > [!NOTE]
   > 在这一步骤中，我们几乎可以使用任何Actor类。用我们在快速入门教程中创建的MyActor类来替代立方体（Cube）可能会很有趣。
3. 放置我们的 **立方体（Cube）** Actor后，单击 **详细信息（Details）** 面板中的 **+添加组件（+ Add Component）** 按钮，来为 **立方体（Cube）** 添加 **摄像机组件（CameraComponent）**。你现在可以设置该 **摄像机组件（CameraComponent）** 的位置和旋转，让我们看到一个不同于我们之前放置的 **摄像机Actor（CameraActor）** 的场景视图。
4. 我们应该打开 **约束高宽比（Constrain Aspect Ratio）** 来自定义我们的 **摄像机组件（CameraComponent）**，以便它与我们的 **摄像机Actor（CameraActor）** 上的设置匹配。这会使摄像机视图之间的转换更流畅，但这不是必需的。

设置好我们的场景后，我们现在可以开始创建控制摄像机视图的类。

## 2 - 在C++中控制摄像机视图

1. 我们现在可以创建一个C++类来控制摄像机视图了。在本教程中，我们可以扩展 **Actor** 为新类，我们将其称之为CameraDirector。
2. 在CameraDirector.h中，我们将以下代码添加到ACameraDirector类定义的底部位置：

   ```
           UPROPERTY(EditAnywhere)        AActor* CameraOne;		        UPROPERTY(EditAnywhere)        AActor* CameraTwo;		        float TimeToNextCameraChange;		
   ```

   > [!NOTE]
   > **UPROPERTY** 宏使得变量对 **虚幻引擎** 可见。这样，当我们启动游戏或在将来的工作会话中重新载入关卡或项目时，这些变量中设置的值将不会被重置。我们还添加了 **EditAnywhere** 关键字，这允许我们在 **虚幻编辑器** 中设置摄像机1（CameraOne）和摄像机2（CameraTwo）。
3. 在CameraDirector.cpp中，将以下代码行添加到文件的顶部位置，位于其它#include行的正下方：

   ```
           #include "Kismet/GameplayStatics.h"		
   ```

   GameplayStatics头文件允许我们访问一些有用的通用函数，在本教程中我们需要使用其中一个函数。完成后，将以下代码添加到 **ACameraDirector::Tick** 的底部位置：

   ```
       const float TimeBetweenCameraChanges = 2.0f;    const float SmoothBlendTime = 0.75f;    TimeToNextCameraChange -= DeltaTime;    if (TimeToNextCameraChange <= 0.0f)    {        TimeToNextCameraChange += TimeBetweenCameraChanges;         // 查找处理本地玩家控制的actor。        APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);        if (OurPlayerController)        {            if ((OurPlayerController->GetViewTarget() != CameraOne) && (CameraOne != nullptr))            {                // 立即切换到摄像机1。                OurPlayerController->SetViewTarget(CameraOne);            }            else if ((OurPlayerController->GetViewTarget() != CameraTwo) && (CameraTwo != nullptr))            {                // 平滑地混合到摄像机2。                OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);            }        }    } 
   ```

   此代码将可以让我们每隔3秒在两个不同的摄像机间切换默认玩家的视图。
4. 现在我们的代码可进行编译，我们可以返回到 **虚幻编辑器（Unreal Editor）** 并按下 **编译（Compile）** 按钮。

无需其它代码。我们现在可以在场景中设置CameraDirector了。

### 完成的代码

**CameraDirector.h**

```
	// 版权所有 1998-2017 Epic Games, Inc。保留所有权利。 	#pragma once 	#include "GameFramework/Actor.h"	#include "CameraDirector.generated.h" 	UCLASS()	class HOWTO_AUTOCAMERA_API ACameraDirector : public AActor	{		GENERATED_BODY() 	public:		// 为此Actor的属性设置默认值		ACameraDirector(); 	protected:		// 当游戏开始或生成时调用		virtual void BeginPlay() override; 	public:		// 每一帧调用		virtual void Tick( float DeltaSeconds ) override; 		UPROPERTY(EditAnywhere)		AActor* CameraOne; 		UPROPERTY(EditAnywhere)		AActor* CameraTwo; 		float TimeToNextCameraChange;	}; 
```

**CameraDirector.cpp**

```
	// 版权所有 1998-2017 Epic Games, Inc。保留所有权利。 	#include "HowTo_AutoCamera.h"	#include "CameraDirector.h"	#include "Kismet/GameplayStatics.h" 	// 设置默认值	ACameraDirector::ACameraDirector()	{		// 将此Actor设置为每一帧调用Tick()。如果不需要，可以关闭此选项来提高性能。		PrimaryActorTick.bCanEverTick = true; 	} 	// 当游戏开始或生成时调用	void ACameraDirector::BeginPlay()	{		Super::BeginPlay(); 	} 	// 每一帧调用	void ACameraDirector::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 		const float TimeBetweenCameraChanges = 2.0f;		const float SmoothBlendTime = 0.75f;		TimeToNextCameraChange -= DeltaTime;		if (TimeToNextCameraChange <= 0.0f)		{			TimeToNextCameraChange += TimeBetweenCameraChanges; 			//查找处理本地玩家控制的Actor。			APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);			if (OurPlayerController)			{				if ((OurPlayerController->GetViewTarget() != CameraOne) && (CameraOne != nullptr))				{					//立即切换到摄像机1。					OurPlayerController->SetViewTarget(CameraOne);				}				else if ((OurPlayerController->GetViewTarget() != CameraTwo) && (CameraTwo != nullptr))				{					//平滑地混合到摄像机2。					OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);				}			}		}	} 
```

## 3 - 在场景中放置Camera Director

1. 在代码编译完成后，我们可以将 **内容浏览器（Content Browser）** 中的新类的实例拖曳到 **关卡编辑器（Level Editor）** 中。
2. 接下来，我们需要设置摄像机1（CameraOne）和摄像机2（CameraTwo）变量。在 **World Outliner （世界大纲视图）** 中找到CameraDirector，并在 **详细信息面板（Details Panel）** 中进行编辑。

   单击标记为"无（None）"的下拉框，然后将变量设置为 **Cube（立方体）** 和我们之前创建的 **摄像机Actor （CameraActor）**。
3. 如果我们按下播放（Play），我们将会看到与此视图对齐的摄像机：

   然后平滑混合到此视图：

   需要等待几秒才会对齐。

我们现在的这个系统会完全基于游戏逻辑来移动玩家的摄像机。如果玩家在游戏中无法直接控制摄像机，或者混合摄像机视图十分有用时，我们可以修改代码以在这些游戏中使用。

### 完成的代码

**CameraDirector.h**

```
	// 版权所有 1998-2017 Epic Games, Inc。保留所有权利。 	#pragma once 	#include "GameFramework/Actor.h"	#include "CameraDirector.generated.h" 	UCLASS()	class HOWTO_AUTOCAMERA_API ACameraDirector : public AActor	{		GENERATED_BODY() 	public:		// 为此Actor的属性设置默认值		ACameraDirector(); 	protected:		// 当游戏开始或生成时调用		virtual void BeginPlay() override; 	public:		// 每一帧调用		virtual void Tick( float DeltaSeconds ) override; 		UPROPERTY(EditAnywhere)		AActor* CameraOne; 		UPROPERTY(EditAnywhere)		AActor* CameraTwo; 		float TimeToNextCameraChange;	}; 
```

**CameraDirector.cpp**

```
	// 版权所有 1998-2017 Epic Games, Inc。保留所有权利。 	#include "HowTo_AutoCamera.h"	#include "CameraDirector.h"	#include "Kismet/GameplayStatics.h" 	// 设置默认值	ACameraDirector::ACameraDirector()	{		// 将此Actor设置为每一帧调用Tick()。如果不需要，可以关闭此选项来提高性能。		PrimaryActorTick.bCanEverTick = true; 	} 	// 当游戏开始或生成时调用	void ACameraDirector::BeginPlay()	{		Super::BeginPlay(); 	} 	// 每一帧调用	void ACameraDirector::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 		const float TimeBetweenCameraChanges = 2.0f;		const float SmoothBlendTime = 0.75f;		TimeToNextCameraChange -= DeltaTime;		if (TimeToNextCameraChange <= 0.0f)		{			TimeToNextCameraChange += TimeBetweenCameraChanges; 			//查找处理本地玩家控制的Actor。			APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);			if (OurPlayerController)			{				if (CameraTwo && (OurPlayerController->GetViewTarget() == CameraOne))				{					//平滑地混合到摄像机2。					OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);				}				else if (CameraOne)				{					//立即切换到摄像机1。					OurPlayerController->SetViewTarget(CameraOne);				}			}		}	} 
```

## 4 - 自主操作！

利用你所学到知识，尝试执行以下操作：

- 将摄像机附加到移动Actor上来创建摇臂或移动车镜头。
- 使用一个

  数组

  变量来存储摄像机，而不是摄像机1（CameraOne）和摄像机2（CameraTwo），这样你就可以遍历任意数量摄像机的序列，而不是仅仅两个。
- 不要使用

  Actor

  指针来存储摄像机，而是创建一个[结构](programming-and-scripting\programming-language-implementation## 1 - Place Cameras in the World

> [!TIP]
> 如果你是 **Unreal Engine**的新用户，可能需要先阅读 [编程快速入门](../unreal-engine-cpp-quick-start/index.md) 。对于本教程，我们假设你熟悉创建项目、向项目添加 C++ 代码、编译代码，以及添加 **组件** 到 **Actor** 等 Unreal Engine 操作。

1. 首先创建一个名为“HowTo_AutoCamera”、带有初学者内容的新 Basic Code 项目。第一步是在 World 中创建两个摄像机。设置摄像机有多种方式，这里使用最常见的两种。对于第一个摄像机，前往 **Place Actors** 面板并选择 **All Classes** 标签页，可以找到一个 **Camera** Actor。将它拖入 **Level Editor** 并调整位置，使其能很好地观察场景。

   完成后， **Level Editor** 窗口会以画中画方式显示新 **Camera Actor** 能看到的内容，只要当前选中 **Camera Actor** 。
2. 对于第二个摄像机，我们使用更深入、控制力更强的方法。先点击 **Basic** 标签页，位置在 **Place Actors** 面板中，然后拖入一个 **Cube** 到 **Level Editor** 窗口。

   > [!NOTE]
   > 这一步几乎可以使用任何 Actor 类。用快速入门教程中创建的 MyActor 类替代 Cube 也会很有意思。
3. 当 **Cube** Actor 放置好后，添加一个 **CameraComponent** ，方法是点击 **+ Add Component** 按钮，位置在 **Details** 面板中，对象为 **Cube**。现在可以设置该 **CameraComponent** 的位置和旋转，使其提供不同于先前放置的 **CameraActor** 的场景视角。
4. 应该自定义 **CameraComponent** ，启用 **Constrain Aspect Ratio** 使其匹配 **CameraActor**上的设置。这会让摄像机视图之间的过渡更平滑，但并非必需。

World 设置完成后，就可以创建用于控制摄像机视图的类。

## 2 - 在 C++ 中控制摄像机视图

1. 现在可以创建一个 C++ 类来控制摄像机视图。在本教程中，可以扩展 **Actor** 为一个新类，命名为 CameraDirector。
2. 在 CameraDirector.h 中，将以下代码添加到 ACameraDirector 类定义的底部：

   ```
           UPROPERTY(EditAnywhere)        AActor* CameraOne;		        UPROPERTY(EditAnywhere)        AActor* CameraTwo;		        float TimeToNextCameraChange;		
   ```

   > [!NOTE]
   > 该 **UPROPERTY** 宏会让变量对 **Unreal Engine**可见。这样，在未来工作会话中启动游戏或重新加载关卡/项目时，这些变量中设置的值不会被重置。我们还添加了 **EditAnywhere** 关键字，允许在 **Unreal Editor**.
3. 在 CameraDirector.cpp 中，将以下代码行添加到文件顶部，位于其他 #include 行正下方：

   ```
           #include "Kismet/GameplayStatics.h"		
   ```

   GameplayStatics 头文件使我们能够访问一些有用的通用函数，本教程需要其中一个。完成后，将以下代码添加到 **ACameraDirector::Tick**:

   ```
       const float TimeBetweenCameraChanges = 2.0f;    const float SmoothBlendTime = 0.75f;    TimeToNextCameraChange -= DeltaTime;    if (TimeToNextCameraChange <= 0.0f)    {        TimeToNextCameraChange += TimeBetweenCameraChanges;         // Find the actor that handles control for the local player.        APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);        if (OurPlayerController)        {            if ((OurPlayerController->GetViewTarget() != CameraOne) && (CameraOne != nullptr))            {                // Cut instantly to camera one.                OurPlayerController->SetViewTarget(CameraOne);            }            else if ((OurPlayerController->GetViewTarget() != CameraTwo) && (CameraTwo != nullptr))            {                // Blend smoothly to camera two.                OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);            }        }    } 
   ```

   这段代码会使默认玩家视图每三秒在两个不同摄像机之间切换。
4. 现在代码已准备好编译，可以返回 **Unreal Editor** 并点击 **Compile** 按钮。

无需更多代码。现在可以在 World 中设置 CameraDirector。

### 完成代码

**CameraDirector.h**

```
	// Copyright 1998-2017 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "GameFramework/Actor.h"	#include "CameraDirector.generated.h" 	UCLASS()	class HOWTO_AUTOCAMERA_API ACameraDirector : public AActor	{		GENERATED_BODY() 	public:		// Sets default values for this actor's properties		ACameraDirector(); 	protected:		// Called when the game starts or when spawned		virtual void BeginPlay() override; 	public:		// Called every frame		virtual void Tick( float DeltaSeconds ) override; 		UPROPERTY(EditAnywhere)		AActor* CameraOne; 		UPROPERTY(EditAnywhere)		AActor* CameraTwo; 		float TimeToNextCameraChange;	}; 
```

**CameraDirector.cpp**

```
	// Copyright 1998-2017 Epic Games, Inc. All Rights Reserved. 	#include "HowTo_AutoCamera.h"	#include "CameraDirector.h"	#include "Kismet/GameplayStatics.h" 	// Sets default values	ACameraDirector::ACameraDirector()	{		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.		PrimaryActorTick.bCanEverTick = true; 	} 	// Called when the game starts or when spawned	void ACameraDirector::BeginPlay()	{		Super::BeginPlay(); 	} 	// Called every frame	void ACameraDirector::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 		const float TimeBetweenCameraChanges = 2.0f;		const float SmoothBlendTime = 0.75f;		TimeToNextCameraChange -= DeltaTime;		if (TimeToNextCameraChange <= 0.0f)		{			TimeToNextCameraChange += TimeBetweenCameraChanges; 			//Find the actor that handles control for the local player.			APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);			if (OurPlayerController)			{				if ((OurPlayerController->GetViewTarget() != CameraOne) && (CameraOne != nullptr))				{					//Cut instantly to camera one.					OurPlayerController->SetViewTarget(CameraOne);				}				else if ((OurPlayerController->GetViewTarget() != CameraTwo) && (CameraTwo != nullptr))				{					//Blend smoothly to camera two.					OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);				}			}		}	} 
```

## 3 - 在 World 中放置 Camera Director

1. 代码编译完成后，可以从 **Content Browser** 到 **Level Editor**.
2. 接下来，需要设置 CameraOne 和 CameraTwo 变量。在 **World Outliner** 中找到 CameraDirector，并在 **Details Panel**.

   点击标记为“None”的下拉框，并将变量设置为 **Cube** 和 **CameraActor** ，即先前创建的对象。
3. 如果点击 **Play**，会看到摄像机切换到此视图：

   然后平滑混合到此视图：

   在这里等待几秒后再切换回去。

现在已经有了一个完全基于游戏逻辑移动玩家摄像机的系统。该代码可以修改后用于任何玩家无法直接控制摄像机，或需要在摄像机视图之间混合的游戏。

### 完成代码

**CameraDirector.h**

```
	// Copyright 1998-2017 Epic Games, Inc. All Rights Reserved. 	#pragma once 	#include "GameFramework/Actor.h"	#include "CameraDirector.generated.h" 	UCLASS()	class HOWTO_AUTOCAMERA_API ACameraDirector : public AActor	{		GENERATED_BODY() 	public:		// Sets default values for this actor's properties		ACameraDirector(); 	protected:		// Called when the game starts or when spawned		virtual void BeginPlay() override; 	public:		// Called every frame		virtual void Tick( float DeltaSeconds ) override; 		UPROPERTY(EditAnywhere)		AActor* CameraOne; 		UPROPERTY(EditAnywhere)		AActor* CameraTwo; 		float TimeToNextCameraChange;	}; 
```

**CameraDirector.cpp**

```
	// Copyright 1998-2017 Epic Games, Inc. All Rights Reserved. 	#include "HowTo_AutoCamera.h"	#include "CameraDirector.h"	#include "Kismet/GameplayStatics.h" 	// Sets default values	ACameraDirector::ACameraDirector()	{		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.		PrimaryActorTick.bCanEverTick = true; 	} 	// Called when the game starts or when spawned	void ACameraDirector::BeginPlay()	{		Super::BeginPlay(); 	} 	// Called every frame	void ACameraDirector::Tick( float DeltaTime )	{		Super::Tick( DeltaTime ); 		const float TimeBetweenCameraChanges = 2.0f;		const float SmoothBlendTime = 0.75f;		TimeToNextCameraChange -= DeltaTime;		if (TimeToNextCameraChange <= 0.0f)		{			TimeToNextCameraChange += TimeBetweenCameraChanges; 			//Find the actor that handles control for the local player.			APlayerController* OurPlayerController = UGameplayStatics::GetPlayerController(this, 0);			if (OurPlayerController)			{				if (CameraTwo && (OurPlayerController->GetViewTarget() == CameraOne))				{					//Blend smoothly to camera two.					OurPlayerController->SetViewTargetWithBlend(CameraTwo, SmoothBlendTime);				}				else if (CameraOne)				{					//Cut instantly to camera one.					OurPlayerController->SetViewTarget(CameraOne);				}			}		}	} 
```

## 4 - 自行尝试

使用学到的内容，尝试完成以下操作：

- 将 Camera 附加到移动 Actor 上，以创建摇臂或轨道车镜头。
- 使用单个

  Array

  变量存储摄像机，而不是 CameraOne 和 CameraTwo，这样可以遍历任意数量的摄像机序列，而不仅仅是两个。
- 不要使用

  Actor

  指针存储摄像机，而是创建一个

  结构体

  来保存指针、切换视图前的等待时间，以及混合到新视图所需的时间。

关于本教程涉及的具体内容：

- 关于摄像机及其控制方式的更多信息，请参阅

  Camera

  框架页面，或尝试

  玩家控制的摄像机

  教程。
- 更多教程请参阅

  C++ 编程教程

  page. \Structs)来保持指针以及在更改视图之前的时间，并将时间混合到新视图中。

有关本教程介绍的细节：

- 有关摄像机以及其控制方法的更多信息，请参阅

  摄像机

  框架页面，或尝试

  玩家控制的摄像机

  教程。
- 有关进一步教程，请参阅

  C++编程教程

  页面。

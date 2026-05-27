---
title: "开门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/opening-doors-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "时间轴", "开门"]
---

# 开门

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 时间轴 / 开门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/opening-doors-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

本示例使用了C++**[时间轴](https://dev.epicgames.com/documentation/assets/programming-and-scripting/blueprints-visual-scripting/UserGuide/Timelines)**来创建经典的基于距离的开门动画。

## 创建门Actor

1. 使用**空白（Blank）**模板新建一个**C++**项目，并启用**初学者内容包（Starter Content）**，将其命名为**TimelineDoorActor**。

   点击查看大图。
2. 找到**内容浏览器**，点击**C++ Classes**文件夹，然后点击**添加（+）（Add (+)）**按钮并选择**新建C++类（New C++ Class）**。

   点击查看大图。
3. 选择**Actor**作为**父类**。

   点击查看大图。
4. 将创建的Actor命名为**DoorActor**。

   点击查看大图。
5. 新建Actor后，**Visual Studio**会自动打开`DoorActor.h`以及`DoorActor.cpp`文件。 找到`DoorActor.h`文件并声明如下内容：

   DoorActor.h

   C++

   ```
   #include "Components/TimelineComponent.h"
   ```
6. 接下来，在`DoorActor`类定义中添加以下代码：

   DoorActor.h

   C++

   ```
   protected:

            //MeshComponents to represent Door assets
            UPROPERTY(VisibleAnywhere, BlueprintReadWrite)
            UStaticMeshComponent* DoorFrame;
            UPROPERTY(VisibleAnywhere, BlueprintReadWrite)
            UStaticMeshComponent* Door;

            //TimelineComponent to animate Door meshes
            UPROPERTY(VisibleAnywhere, BlueprintReadWrite)
   ```
7. 找到`DoorActor.cpp`。 需要包括以下类库，方可利用你的盒体组件。

   DoorActor.cpp

   C++

   ```
   #include "Components/BoxComponent.h"
   ```
8. 在你的`ADoorActor::ADoorActor`构造函数中声明以下内容：

   DoorActor.cpp

   C++

   ```
   // Sets default values
        ADoorActor::ADoorActor()
        {
            // Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
            PrimaryActorTick.bCanEverTick = true;

            //Create our Default Components
            DoorFrame = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("DoorFrameMesh"));
            Door = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("DoorMesh"));
            DoorTimelineComp = CreateDefaultSubobject<UTimelineComponent>(TEXT("DoorTimelineComp"));
   ```

   > [!NOTE]
   > *注意*：我们将门的相对变换保留为附件规则，以便稍后使用门Actor的自定义方法来操作它。 详情请参阅[FAttachmentTransformRules](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/FAttachmentTransformRules?application_version=5.5)。
9. 编译你的代码。

## 设置门静态网格体

你需要设置**静态网格体（Static Mesh）**资产，直观地表示你的DoorFrame和Door静态网格体组件。

1. 在**内容浏览器**中，找到你的**C++ Classes文件夹**。
2. 右键点击你的**DoorActor**类，选择**基于DoorActor创建蓝图类（Create Blueprint Class based on DoorActor）**。
3. 将你的蓝图Actor命名为**Bp_DoorActor**并将其放入相应的文件夹。

   点击查看大图。
4. 在**组件（Components）**选项卡中，选择**DoorFrame**静态网格体组件。
5. 找到**细节（Details）面板**，将**静态网格体**更改为**SM_DoorFrame**。
6. 找到**组件（Components）**选项卡，选择**DoorMesh**组件。
7. 在**细节（Details）**面板中，将**静态网格体**更改为**SM_Door**。
8. 然后找到**变换（Transform）**类别，将**Y位置（Y Location）**的值更改为**45.0**。
9. 点击**编译（Compile）**和**保存（Save）**按钮。

## 创建UCurveFloat和时间轴事件轨道

时间轴组件需要[时间轴曲线](../keys-and-curves/index.md)。 每个曲线都可以包含多个关键点，用于定义时间和值。曲线会为这些关键点插值，以计算时间轴中任意点的值。

我们将在此例中使用[UCurveFloat](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Curves/UCurveFloat?application_version=5.5)。

1. 找到`DoorActor.h`中的`ADoorActor`类定义，并声明如下变量：

   DoorActor.h

   C++

   ```
   public:
            // Variable to hold the Curve asset
            UPROPERTY(EditAnywhere)
            UCurveFloat* DoorTimelineFloatCurve;

        private:
            //Float Track Signature to handle our update track event
            FOnTimelineFloat UpdateFunctionFloat;

            //Function which updates our Door's relative location with the timeline graph
   ```
2. 找到`DoorActor.cpp`并实现`UpdateTimelineComp`方法：

   DoorActor.cpp

   C++

   ```
   void ADoorActor::UpdateTimelineComp(float Output)     {         // Create and set our Door's new relative location based on the output from our Timeline Curve         FRotator DoorNewRotation = FRotator(0.0f, Output, 0.f);         Door->SetRelativeRotation(DoorNewRotation);     }
   ```
3. 然后，在`BeginPlay`方法中添加以下代码：

   DoorActor.cpp

   C++

   ```
   //Binding our float track to our UpdateTimelineComp Function's output     UpdateFunctionFloat.BindDynamic(this, &ADoorActor::UpdateTimelineComp);      //If we have a float curve, bind it's graph to our update function     if (DoorTimelineFloatCurve)     {        DoorTimelineComp->AddInterpFloat(DoorTimelineFloatCurve, UpdateFunctionFloat);     }
   ```
4. 编译你的代码。

## 阶段性代码

DoorActor.h

C++

```
// Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.
	#pragma once
	#include "Components/TimelineComponent.h"
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "DoorActor.generated.h"

	UCLASS()
	class TIMELINEDOORACTOR_API ADoorActor : public AActor
	{
```

DoorActor.cpp

C++

```
//Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#include "DoorActor.h"
	#include "Components/BoxComponent.h"

	// Sets default values
	ADoorActor::ADoorActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;
```

## 创建并绑定盒体碰撞重叠事件

盒体组件需要拥有在Actor进入或离开碰撞边界时做出反应的能力。

1. 找到你的`DoorActor.h`文件的类定义并声明如下内容：

   DoorActor.h

   C++

   ```
   // Begin and End Overlap Events for our DoorProxVolume     UFUNCTION()     void OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);      UFUNCTION()     void OnOverlapEnd(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex);
   ```
2. 接下来，找到你的`DoorActor.cpp`文件，实现`OnOverlapBegin`和`OnOverlapEnd`类方法：

   DoorActor.cpp

   C++

   ```
   void ADoorActor::OnOverlapBegin(UPrimitiveComponent * OverlappedComp, AActor * OtherActor, UPrimitiveComponent * OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult & SweepResult)     {         DoorTimelineComp->Play();     }      void ADoorActor::OnOverlapEnd(UPrimitiveComponent * OverlappedComp, AActor * OtherActor, UPrimitiveComponent * OtherComp, int32 OtherBodyIndex)     {         DoorTimelineComp->Reverse();     }
   ```
3. 在`BeginPlay`方法中绑定重叠函数，如下所示：

   DoorActor.cpp

   C++

   ```
   void ADoorActor::BeginPlay()
        {
            Super::BeginPlay();

            //Binding our float track to our UpdateTimelineComp Function's output
            UpdateFunctionFloat.BindDynamic(this, &ADoorActor::UpdateTimelineComp);

            //If we have a float curve, bind it's graph to our update function
            if (DoorTimelineFloatCurve)
            {
   ```
4. 编译你的代码。

## 在虚幻编辑器中创建曲线资产

你必须在**虚幻编辑器**中创建**曲线资产**，以将其指定给你的时间轴Actor蓝图。

1. 找到**内容浏览器**，选择**添加（+）（Add (+)）> 杂项（Miscellaneous）> 曲线（Curve）**。
2. 选择**CurveFloat**并将资产命名为**DoorCurveFloat**。
3. 双击新建的**DoorCurveFloat**，打开**时间轴编辑器**。
4. 右键点击**图表（Graph）**，然后选择**添加关键点（Add Key）**，为浮点曲线添加两个关键点。 将第一个关键点的时间值调整为**(0, 0)**。 将第二个关键点的时间值调整为**(4, 90)**。

   点击查看大图。

   > [!NOTE]
   > 如需详细了解**时间轴**曲线的编辑方法，请参阅[关键点和曲线](../keys-and-curves/index.md)。
5. 按住**Shift**键并点击以选中这两个关键点，右键点击**图表（Graph）**，将它们设置为**自动（Auto）**插值。

   点击查看大图。
6. 现在你的曲线内容应如下所示。 保存你的**DoorCuveFloat**并关闭**时间轴编辑器**。

   点击查看大图。
7. 打开你的**Bp_DoorActor**并在**组件（Components）**选项卡中选择**Bp_DoorActor**。
8. 找到**细节（Details）**面板，打开**门操作（Door Action）**分段的**门时间轴浮点曲线（Door Timeline Float Curve）**下拉菜单，选择**DoorCurveFloat**。
9. 找到**内容浏览器**并将**Bp_DoorActor**放入**关卡**。
10. 编译并保存，然后按PIE。

    *你可以使用WASD键进行输入，以控制旁观者Pawn。 找到你的DoorActor的碰撞边界时，你可以观察时间轴的播放，而在退出边界时，可以观察到时间轴倒放。*

## 已完成代码

DoorActor.h

C++

```
// Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#pragma once
	#include "Components/TimelineComponent.h"
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "DoorActor.generated.h"

	UCLASS()
	class TIMELINEDOORACTOR_API ADoorActor : public AActor
```

DoorActor.cpp

C++

```
// Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#include "DoorActor.h"
	#include "Components/BoxComponent.h"

	// Sets default values
	ADoorActor::ADoorActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;
```

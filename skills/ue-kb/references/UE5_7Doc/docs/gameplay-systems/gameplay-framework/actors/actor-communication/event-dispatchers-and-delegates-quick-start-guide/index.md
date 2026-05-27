---
title: "事件分发器/委托快速入门指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/event-dispatchers-and-delegates-quick-start-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Actors", "Actor通信", "事件分发器/委托快速入门指南"]
---

# 事件分发器/委托快速入门指南

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Actors / Actor通信 / 事件分发器/委托快速入门指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/event-dispatchers-and-delegates-quick-start-guide-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

## 概述

Delegates can call methods in Actor class Blueprints in a type-safe way. A delegate can be bound dynamically to form a communication where one Actor triggers an event on another Actor that is listening to be notified for that event.

> [!NOTE]
> See [Delegates](../../../../../cpp-programming/delegates-and-lambda-functions/index.md) for additional documentation.

## Goals

In this Quick Start guide, you will learn how to use Delegates to create an **OnBossDied**event that will trigger two Actor class Blueprints in your Level.

## Objectives

- Create the **Boss**Actor that will contain an OnBossDied Delegate.
- Create an interactive door Actor with a timeline component that will bind to the **OnBossDied**event.

## 1 - Required Setup

1. In the **New Project Categories** section of the menu, select **Games** and click **Next**.
2. Select the **Third Person** template and click **Next**.
3. Select the **C++**and **With Starter Content** options and click **Create Project**.

### Section Results

You have created a new C++ Third Person project and are now ready to learn about Delegates.

## 2 - Creating the Boss Actor and OnBossDied Delegate

1. From the [C++ Class Wizard](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md), create a new Actor class named BossActor.
2. Navigate to your **BossActor.h**. Underneath your library includes, declare the following Delegate.

   C++

   ```
   DECLARE_DELEGATE(FOnBossDiedDelegate);
   ```
3. In your class defaults, declare the following

   C++

   ```
   protected:             UFUNCTION()             void HandleBossDiedEvent();             UPROPERTY(EditInstanceOnly, BlueprintReadWrite)             class UBoxComponent* BoxComp;             virtual void NotifyActorBeginOverlap(AActor* OtherActor);		         public:             FOnBossDiedDelegate OnBossDied;
   ```
4. Navigate to your BossActor.cpp and add the following class library.

   C++

   ```
   #include "Components/BoxComponent.h"
   ```
5. Implement the following class definitions.

   C++

   ```
   ABossActor::ABossActor()
            {
                BoxComp = CreateDefaultSubobject<UBoxComponent>(TEXT("BoxComp"));
                BoxComp->SetBoxExtent(FVector(128, 128, 64));
                BoxComp->SetVisibility(true);
            }

            void ABossActor::HandleBossDiedEvent()
            {
                OnBossDied.ExecuteIfBound();
   ```
6. **Compile** your code.
7. From the **C++ Classes folder**, right-click your **BossActor**, then from the **C++ Class Actions** dropdown menu, select **Create Blueprint class based on BossActor**. Name your Blueprint class **BP_BossActor**.
8. Drag an instance of your **BossActor** into the Level.

## Finished Code

BossActor.h

C++

```
#pragma once
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "BossActor.generated.h"

	DECLARE_DELEGATE(FOnBossDiedDelegate);
	UCLASS()

	class BPCOMMUNICATION_API ABossActor : public AActor
	{
```

**BossActor.cpp**

C++

```
#include "BossActor.h"
	#include "Components/BoxComponent.h"
	#include "BPCommunicationGameMode.h"

	// Sets default values
	ABossActor::ABossActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;
		BoxComp = CreateDefaultSubobject<UBoxComponent>(TEXT("BoxComp"));
```

### Section Results

In this section you created the **BossActor**class, which contains a Box Component, and Delegate for a **OnBossDied** event, which will be used to signal other Actor classes when the event has been executed.

## 3 - Creating an Interactive Door

1. From the **C++ Class Wizard**, create a new **Actor** class named **DoorActor.**
2. Navigate to your DoorActor.h file and declare the following include:

   C++

   ```
   #include "Components/TimelineComponent.h"
   ```
3. Then declare the following class definitions.

   C++

   ```
   // Variable to hold the Curve asset
                UPROPERTY(EditInstanceOnly)
                UCurveFloat* DoorTimelineFloatCurve;

            protected:

                void BossDiedEventFunction();
                UPROPERTY(EditInstanceOnly,BlueprintReadWrite)
                class ABossActor* BossActorReference;

   ```
4. Inside of **DoorActor.cpp** declare the following class library.

   C++

   ```
   #include "BossActor.h"
   ```
5. Implement the following class definitions.

   C++

   ```
   ADoorActor::ADoorActor()
           {
               //Create our Default Components
               DoorFrame = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("DoorFrameMesh"));
               Door = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("DoorMesh"));
               DoorTimelineComp = CreateDefaultSubobject<UTimelineComponent>(TEXT("DoorTimelineComp"));

               //Setup our Attachments
               DoorFrame->SetupAttachment(RootComponent);
               Door->AttachToComponent(DoorFrame, FAttachmentTransformRules::KeepRelativeTransform);
   ```
6. Compile your code.
7. From the **Content Browser**, select **Add/Import**> **Miscellaneous** > **Curve.**
8. Select **CurveFloat** and name your CurveFloat asset **DoorCurveFloat,**then double-click your DoorCurveFloat asset. Add two keys to your Float Curve and give one key the time-value (0,0), and the other key the time-value of (4,90).
9. Shift-click to select both your keys, and set them to **Auto Cubic interpolation**, then save your Curve.
10. Save your DoorCurveFloat.
11. From the Content Browser, navigate to your **C++ Classes folder**, right-click your DoorActor class, then select **Create Blueprint Class based on Door Actor**. Name your Blueprint Actor **Bp_DoorActor**.
12. Inside **BP_DoorActor**'s **class defaults**, find the **Components**tab, and select the **DoorFrame** **Static Mesh component**, navigate to the **Details**panel and change the Static Mesh to **SM_DoorFrame**.
13. Next, from the Components tab, select the DoorMesh component. Navigate to the Details panel and change the static mesh to **SM_Door**.
14. From the Details panel, select DoorCurveFloat from the Door Timeline Float Curve dropdown menu.
15. Compile and save your Blueprint.

## Finished Code

DoorActor.h

C++

```
#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "Components/TimelineComponent.h"
	#include "DoorActor.generated.h"

	UCLASS()
	class BPCOMMUNICATION_API ADoorActor : public AActor
	{
		GENERATED_BODY()
```

DoorActor.cpp

C++

```
#include "DoorActor.h"
	#include "BossActor.h"

	// Sets default values
	ADoorActor::ADoorActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;

		//Create our Default Components
```

### Section Results

In this section you created an interactive **DoorActor** that binds to the **OnBossDied** Event Dispatcher found in the **BossActor** class. This binding occurs in Begin Play, but is executed at runtime whenever this event is triggered by an overlap in BossActor's**Box Component**.

## 5 - Testing the Event Dispatcher

1. Drag the **BP_Door**Blueprint into your Level. Go to the **Details**panel and click the **Boss Reference Died** dropdown and search for and select **BP_BossDied**.
2. With your Bp_DoorActor selected, navigate to the **Details**panel, click the **Boss Actor Reference**dropdown arrow, then search for and select **BP_BossActpr**.
3. Press Play and walk over the **BP_BossActor**trigger to simulate your boss dying in the game.

   > 动图已省略：93035d469c34f5bf65b5fbc12aa4a8f6bf3bf6dfd46c284bf458d2587f74f481

### Section Results

In this section you tested the **BP_DoorActor**in the Level. You confirmed that the Actor responds to the **OnBossDied**event when the **BP_BossActor's Box Component** overlaps with another Actor to trigger the Delegate.

In this guide you learned how to use Delegates to communicate between multiple Actor class Blueprints.

## Next Steps

Now that you know how to use Delegates, take a look at the other communication types referenced in the documentation page.

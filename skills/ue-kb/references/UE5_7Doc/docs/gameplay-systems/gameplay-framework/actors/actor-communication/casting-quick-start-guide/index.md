---
title: "类型转换快速入门指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/casting-quick-start-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Actors", "Actor通信", "类型转换快速入门指南"]
---

# 类型转换快速入门指南

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Actors / Actor通信 / 类型转换快速入门指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/casting-quick-start-guide-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

## 概述

Casting Blueprint classes is a common communication type, in which you use a reference to an Actor class Blueprint and convert it to a different class. If this conversion is successful, then you can use Direct Blueprint communication to access its information and functionality.

This method requires a reference to the Actor class Blueprint in your Level so you can use the **Cast**node to try to convert it to a specific class. This communication type uses a one-to-one relationship between your working Actor class Blueprint to your target Actor class Blueprint.

In this Quick Start guide, you will learn how to create an Actor in C++, that has the Blueprint casting functionality used to access information from a target Blueprint.

## Setup

1. Begin by creating a new **Games** > **Third Person** > **C++** project named **BPCommunication**.

## Creating a Rotating Actor

For this example, you will create an Actor class Blueprint that has the functionality to rotate its Static Mesh Component when the player is nearby.

1. From the [C++ Class Wizard](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md), create a new Actor class named **RotatingActor**.
2. In the class defaults of your **RotatingActor.h** implement the following code.

   C++

   ```
   public:

               void SetbCanRotate(bool value);

           protected:

               // Called when the game starts or when spawned
               virtual void BeginPlay() override;
               void RotateActor();
               bool bCanRotate;
   ```
3. Navigate to your **RotatingActor.cpp** and declare the following code in the constructor **ARotatingActor::ARotatingActor**

   C++

   ```
   ARotatingActor::ARotatingActor()     {         RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("SceneComponent"));         MeshComp = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("StaticMesh"));         MeshComp->SetupAttachment(RootComponent, FAttachmentTransformRules::KeepRelativeTransform);         bCanRotate = false;     }
   ```
4. Implement the following code for your **ARotatingActor::RotateActor** method.

   C++

   ```
   void ARotatingActor::RotateActor()     {         AddActorLocalRotation(ActorRotation);     }
   ```
5. Navigate to the **ARotatingActor::Tick** method and implement the following code.

   C++

   ```
   void ARotatingActor::Tick(float DeltaTime)         {             Super::Tick(DeltaTime);		             if (bCanRotate)             {                 RotateActor();             }         }
   ```

## Finished Code

RotatingActor.h

C++

```
#pragma once
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "RotatingActor.generated.h"

	UCLASS()
	class BPCOMMUNICATION_API ARotatingActor : public AActor
	{
	GENERATED_BODY()
```

RotatingActor.cpp

C++

```
#include "RotatingActor.h"

	// Sets default values
	ARotatingActor::ARotatingActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;
		RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("SceneComponent"));
		MeshComp = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("MeshComp"));
		MeshComp->SetupAttachment(RootComponent, FAttachmentTransformRules::KeepRelativeTransform);
```

1. **Compile** your code.
2. In the editor, navigate to your **C++ Classes folder**, right-click your **RotatingActor** and from the **C++ class actions** dropdown menu, select **Create Blueprint class based on RotatingActor** named **BP_RotatingActor**.
3. In the class defaults for your **BP_RotatingActor** Blueprint, navigate to the **Components**tab, select the **MeshComp** **Static Mesh Component**, then navigate to the **Details panel**and from the **Static Mesh category**,select the arrow next to the **Static Mesh variable**. Lastly, from the dropdown menu, select the **Shape_Cube**static mesh.
4. **Compile**and **save**your Blueprint.
5. From the **Content Browser**, drag an instance of your **Bp_RotatingActor** into the Level.

## Modifying the Third Person Character Class

In this section, you will modify the **BPCommunicationCharacter**classto cast to the **Rotating Actor**class and set the **bCanRotate**variable to **True** when your player is nearby.

1. Open your **BPCommunicationCharacter.h** and implement the following.

   C++

   ```
   protected:             virtual void NotifyActorBeginOverlap(AActor* OtherActor);             virtual void NotifyActorEndOverlap(AActor* OtherActor);             class USphereComponent* SphereComp;
   ```
2. In your **BPCommunicationCharacter.cpp** include the following class libraries

   C++

   ```
   #include "RotatingActor.h"         #include "Components/SphereComponent.h"
   ```
3. From the constructor **ABPCommunicaionCharacter::BPCommunicationCharacter** declare the following code.

   C++

   ```
   SphereComp = CreateDefaultSubobject<USphereComponent>(TEXT("SphereComp"));         SphereComp->AttachToComponent(GetMesh(), FAttachmentTransformRules::KeepRelativeTransform);         SphereComp->SetSphereRadius(200);
   ```
4. Next, implement the **ABPCommunicationCharacter::NotifyActorBeginOverlap**, and **ABPCommunicationCharacter::NotifyActorEndOverlap**.

   C++

   ```
   void ABPCommunicationCharacter::NotifyActorBeginOverlap(AActor* OtherActor)
            {
                if (ARotatingActor* RotatingActorCheck =Cast<ARotatingActor>(OtherActor))
                {
                    ActorCheck->SetbCanRotate(true);
                }
            }

            void ABPCommunicationCharacter::NotifyActorEndOverlap(AActor* OtherActor)
            {
   ```
5. Compile your code.

## Finished Code

BpCommunicationCharacter.h

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.
	#pragma once
	#include "CoreMinimal.h"
	#include "GameFramework/Character.h"
	#include "BPCommunicationCharacter.generated.h"

	UCLASS(config=Game)
	class ABPCommunicationCharacter : public ACharacter
	{
		GENERATED_BODY()
```

BpCommunication.cpp

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.
	#include "BPCommunicationCharacter.h"
	#include "HeadMountedDisplayFunctionLibrary.h"
	#include "Camera/CameraComponent.h"
	#include "Components/CapsuleComponent.h"
	#include "Components/InputComponent.h"
	#include "GameFramework/CharacterMovementComponent.h"
	#include "GameFramework/Controller.h"
	#include "GameFramework/SpringArmComponent.h"
	#include "CeilingLight.h"
```

1. Press Play and approach the **BP_RotateActor**Actor to see it rotate only when the player is nearby.

   > 动图已省略：5ad9ba28aa27372a995f56020023c281ca20ee038b43f4148c51fc6b7978faaf

## Next Steps

Now that you know how to use Blueprint casting, take a look at the other communication types referenced in the documentation page.

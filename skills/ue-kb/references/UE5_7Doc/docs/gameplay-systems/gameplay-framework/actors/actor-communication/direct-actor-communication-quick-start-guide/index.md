---
title: "直接Actor通信快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/direct-actor-communication-quick-start-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Actors", "Actor通信", "直接Actor通信快速入门"]
---

# 直接Actor通信快速入门

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Actors / Actor通信 / 直接Actor通信快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/direct-actor-communication-quick-start-guide-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

## 概述

Direct Actor communication is a common method of sharing information between Actors in your Level. This method requires a reference to the target Actor so you can access it from your working Actor. This communication method uses a one-to-one relationship between your working Actor and your target Actor. In this Quick Start guide, you will learn how to use direct Actor communication to access information from a target Actor in order to use its functions.

## 1 - Required Setup

1. In the **New Project Categories** section of the menu, select **Games** and click **Next**.
2. Select the **Third Person** template and click **Next**.
3. Select **C++**and **With Starter Content** options and click **Create Project**.

### Section Results

You have created a new Third Person project and are now ready to learn about direct Blueprint communication.

## 2 - Creating the Ceiling Light Actor

1. From the [C++ Class Wizard](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md), create a new Actor class named **CeilingLight**.
2. In the class defaults of **CeilingLight.h** implement the following code.

   C++

   ```
   protected:
               UPROPERTY(EditInstanceOnly, BlueprintReadWrite)
               USceneComponent* SceneComp;

               UPROPERTY(EditInstanceOnly, BlueprintReadWrite)
               class UPointLightComponent* PointLightComp;

               UPROPERTY(EditInstanceOnly, BlueprintReadWrite)
               UStaticMeshComponent* StaticMeshComp;

   ```
3. Next navigate to **CeilingLight.Cpp** and declare the following Include library.

   C++

   ```
   #include "Components/PointLightComponent.h"
   ```
4. From the constructor **ACeilingLight::CeilingLight** declare the following.

   C++

   ```
   ACeilingLight::ACeilingLight()
            {
                // Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
                PrimaryActorTick.bCanEverTick = true;
                SceneComp = CreateDefaultSubobject<USceneComponent>(TEXT("SceneComp"));
                PointLightComp = CreateDefaultSubobject<UPointLightComponent>(TEXT("PointLightComp"));
                StaticMeshComp = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("StaticMeshComp"));
                SceneComp = RootComponent;
                PointLightComp->AttachToComponent(SceneComp,FAttachmentTransformRules::KeepRelativeTransform);
                StaticMeshComp->AttachToComponent(SceneComp, FAttachmentTransformRules::KeepRelativeTransform);
   ```
5. Compile your code.

## Finished Code

CeilingLight.h

C++

```
// Fill out your copyright notice in the Description page of Project Settings.
	#pragma once

	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "CeilingLight.generated.h"

	UCLASS()
	class BPCOMMUNICATION_API ACeilingLight : public AActor
	{
```

CeilingLight.cpp

C++

```
//Copyright Epic Games, Inc. All Rights Reserved.
	#include "CeilingLight.h"
	#include "Components/PointLightComponent.h"

	// Sets default values
	ACeilingLight::ACeilingLight()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
		PrimaryActorTick.bCanEverTick = true;
		SceneComp = CreateDefaultSubobject<USceneComponent>(TEXT("SceneComp"));
```

1. From the **C++ Classes folder**, right-click your **CeilingLight** Actor, then from the **C++ Class Actions** dropdown menu, select **Create Blueprint class based on CeilingLight**. Name your Blueprint **BP_CeilingLight**.
2. From the **BP_CeilingLight** class defaults, navigate to the **Components** panel, then select the **StaticMeshComp**.
3. From the **Details**panel, navigate to the **Static Mesh category**, select the dropdown arrow next to the **Static Mesh** variable, then search and select for **SM_Lamp_Ceiling**.
4. Compile and save your Blueprint.
5. From the **Content Browser**, drag an instance of your **BP_CeilingLight Actor** into your Level.

## Modifying the ThirdPersonCharacter Class

1. Navigate to your C++ Classes folder, and double-click the **BPCommunicationCharacter** class to open its **BPCommunicationCharacter.h**, then declare the following code in the class defaults.

   C++

   ```
   protected:             UPROPERTY(EditInstanceOnly, BlueprintReadWrite)             class ACeilingLight* CeilingLightToToggle;             void ToggleCeilingLight();
   ```
2. Navigate to your **BPCommunicationCharacter.cpp**, and declare the following include.

   C++

   ```
   #include "CeilingLight.h"
   ```
3. Implement your **ABPCommunicationCharacter::ToggleCeilingLight** method.

   C++

   ```
   void ABPCommunicationCharacter::ToggleCeilingLight()         {             if (CeilingLightToToggle)                 {                   CeilingLightToToggle->TurnOffLight();                 }         }
   ```
4. Navigate to the **ABPCommunicationCharacter::SetupPlayerInputComponent** method and declare the following.

   C++

   ```
   PlayerInputComponent->BindAction("Use", IE_Pressed, this, &ABPCommunicationCharacter::ToggleCeilingLight);
   ```
5. In the **编辑器**, navigate to **Edit > Project Settings > Input**. From the **Bindings**category, navigate to the **Action Mappings** then click the **Add (+)** button to create a new **Action mapping** named **Use**, and select the **E** key for the **key value**.
6. Compile your code.

## Finished Code

BPCommunicationCharacter.h

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
```

BPCommunicationCharacter.cpp

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

## 3 - Interacting with the Lamp Blueprint

1. Select your **ThirdPersonCharacter**Blueprint in the Level and position it closer to the lamp.
2. With your **ThirdPersonCharacter**selected, navigate to the **Details**panel, then from the BPCommunication Character category, find the **Ceiling Light To Toggle**variable, and select the arrow adjacent to it. From the dropdown menu, search for and select the **BP_CeilingLight**Actor.
3. Press **Play** to go into **PlE**(Play-in Editor) mode and press the **E key** to turn the lamp on and off.

   > 动图已省略：f4af28a49c2ec91ef2b263b721e8b39747b303b520a51ee6b8c0f47c80e4088e

### Section Results

In this section you added the Ceiling Light Actor reference to the **ThirdPersonCharacter**Blueprint and you turned the light on and off by pressing the E key.

## Next Steps

Now that you know how to use direct Blueprint communication type, take a look at the other communication types referenced in the documentation page.

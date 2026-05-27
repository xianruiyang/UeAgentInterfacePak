---
title: "使用OnHit事件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-onhit-event"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay教程", "使用OnHit事件"]
---

# 使用OnHit事件

> 路径：虚幻引擎5.7文档 / Gameplay教程 / 使用OnHit事件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-onhit-event

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

想象一下你正在创建一款游戏，游戏中涉及对玩家、敌人或物体施加某种类型的伤害。 在这种情况下，你很可能遇到这样的情形：你需要确定这些物体是否被击中，如果是，是什么击中了它们，击中点在哪里，或者有关检测到的攻击的其他信息。 **OnHit事件（OnHit Event）**会在发生碰撞时提供此信息，然后你可以利用数据来推动游戏中的变化。 无论是要影响生命值、摧毁对象，还是导致其他Gameplay相关的操作。

在本教程中，你将使用**OnComponentHit**和**Function**[事件](../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/events/index.md)对Actor施加伤害，而伤害效果将通过更改Actor的网格体材质来呈现。 事件还将在击中位置施加推力推动Actor，模拟被发射物击中的效果，并在击中位置施加作用力。

## Project Setup

1. Begin by creating a new **Games** > **First Person** > **C++** Project named **OnHit**.

## Creating the Mesh Material

1. Navigate to the **Content Browser**, and find the **LevelPrototyping/Materials**folder.
2. Select **MI_SolidBlue**, then duplicate (**CTRL+ D**) and rename the newly duplicated asset **MI_Solid_Red**.
3. Double-click to open the asset, then select and edit the **Base Color** to the color red.
4. **Save**the Asset.

## Creating the Cube Actor

1. In the **编辑器**, click **Add(+)** > **New C++ Class**, then choose**Actor** as your parent class and name your class **Cube**.
2. Declare the following class defaults in your `cube.h` file

   C++

   ```
   UPROPERTY(EditDefaultsOnly, BlueprintReadWrite)
            class UStaticMeshComponent* CubeMesh;

            UPROPERTY(EditDefaultsOnly, BlueprintReadWrite)
            UMaterialInstance* CubeMaterial;

            UPROPERTY(EditDefaultsOnly, BlueprintReadWrite)
            UMaterialInstance* DamagedCubeMaterial;

            FTimerHandle DamageTimer;
   ```
3. Next, in your `cube.cpp` file, declare the following class libraries.

   C++

   ```
   #include "Kismet/GameplayStatics.h"     #include "OnHitProjectile.h"
   ```
4. Navigate to the cube constructor and implement the following functionality.

   C++

   ```
   ACube::ACube()     {         CubeMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("CubeMesh"));         DamagedCubeMaterial = CreateDefaultSubobject<UMaterialInstance>(TEXT("DamageMaterial"));         CubeMaterial = CreateDefaultSubobject<UMaterialInstance>(TEXT("CubeMaterial"));		         CubeMesh->SetSimulatePhysics(true);     }
   ```

### Implementing the Damage functionality

Now that you created a cube, you need to implement a function that sets the mesh's material when it receives damage, then after a delay resets the mesh back to its original material.

1. Declare the following code in your `cube.h` file.

   C++

   ```
   void OnTakeDamage();		         void ResetDamage();
   ```
2. Navigate to the `cube.cpp` file and implement the following for the `ACube::BeginPlay` function.

   C++

   ```
   void ACube::BeginPlay()     {        CubeMesh->OnComponentHit.AddDynamic(this, &ACube::OnComponentHit);     }
   ```
3. Implement the `ACube::OnTakeDamage` function.

   C++

   ```
   void ACube::OnTakeDamage()     {		         CubeMesh->SetMaterial(0, DamagedCubeMaterial);         GetWorld()->GetTimerManager().SetTimer(DamageTimer, this, &ACube::ResetDamage, 1.5f, false);     }
   ```
4. Next, implement the `ACube::ResetDamage` function.

   C++

   ```
   void ACube::ResetDamage()     {         CubeMesh->SetMaterial(0,CubeMaterial);     }
   ```
5. Finally, navigate to the `ACube::OnComponentHit` function and implement the following code.

   C++

   ```
   void ACube::OnComponentHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit)     {     if (AOnHitProjectile* HitActor = Cast<AOnHitProjectile>(OtherActor))     {		         UGameplayStatics::ApplyDamage(this, 20.0f, nullptr, OtherActor, UDamageType::StaticClass());         OnTakeDamage();		     }     }
   ```
6. Compile your code.
7. In the editor, navigate to **C++ Classes**> **Cube** then right-click on the **Cube Actor** and select **Create Blueprint class based on Cube**.
8. From the Components tab, select the **Cube Mesh**, then navigate to **Details** > **Static Mesh** and select the **SM_ChamferCube** asset.
9. In the class defaults of the **BP_Cube**, set the **Cube Material** to the **MI_Solid_Blue** asset, and the **Damaged Cube Material** to the **MI_Solid_Red** asset.
10. **Compile** and **Save**.

### CubeActor.h

C++

```
#pragma once

		#include "CoreMinimal.h"
		#include "GameFramework/Actor.h"
		#include "Cube.generated.h"

		UCLASS()
		class ONHIT_API ACube : public AActor
		{
			GENERATED_BODY()
```

### CubeActor.cpp

C++

```
#include "Cube.h"
		#include "Kismet/GameplayStatics.h"
		#include "OnHitProjectile.h"

		// Sets default values
		ACube::ACube()
		{
			// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
			PrimaryActorTick.bCanEverTick = true;
```

## Setting up the Level

1. Drag the**BP_Cube** into the level from the **Content Browser**.
2. Navigate to the **Outliner** > **Simulated Cubes**, select all **SM_ChauferCubes** then right-click and select **Replace Selected Actors with** > **BP_Cube**.
3. Click **Play** to play in the editor and use the left-mouse button to fire a projectile at the cube.
4. When you play in the editor, you will see that when you hit the cube with the projectile fired it causes the cube to take damage and change its mesh material, and applies an impulse at the location where it was hit causing it to move opposite the direction of the projectile.

   > 动图已省略：5ad9ba28aa27372a995f56020023c281ca20ee038b43f4148c51fc6b7978faaf
5. The amount of force applied is defined inside the `OnHitProjectile.cpp` file which uses the **OnHit** function to determine when the projectile actually hits something.

   C++

   ```
   void AOnHitCPPProjectile::OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit)
        {

            // Only add impulse and destroy projectile if we hit a physics
            if ((OtherActor != nullptr) && (OtherActor != this) && (OtherComp != nullptr) && OtherComp->IsSimulatingPhysics())
            {
                OtherComp->AddImpulseAtLocation(GetVelocity() * 100.0f, GetActorLocation());

                Destroy();
            }
   ```

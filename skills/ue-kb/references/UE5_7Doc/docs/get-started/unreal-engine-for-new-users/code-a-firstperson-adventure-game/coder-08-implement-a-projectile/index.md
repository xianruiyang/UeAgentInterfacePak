---
title: "实现发射物"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-08-implement-a-projectile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "实现发射物"]
---

# 实现发射物

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 实现发射物

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-08-implement-a-projectile-in-unreal-engine

## 开始之前

确保你已完成上一节[装备角色](../coder-07-equip-your-character-with-cplusplus-tools/index.md)中的以下目标：

- 创建了一个可重新生成的拾取物并将其添加到了你的关卡中
- 创建了一个可装备的飞镖发射器，供你的角色持有和使用

## 基本发射物

你的角色可以持有飞镖发射器，你的工具已设置控制绑定来使用它，但尚不具备发射飞镖的能力。 在本节中，你将实现发射物逻辑，使飞镖能从装备的物品中发射出去。

虚幻引擎提供一个**发射物移动（Projectile Movement）**组件类，你可以将其添加到Actor中以将其转换为发射物。 该组件包含许多实用变量，例如发射物速度、反弹力和重力缩放等。

要处理用于实现发射物的数学计算，你需要考虑以下几个方面：

- 发射物的初始变换、速度和方向。
- 你希望从角色的中心还是从其装备的工具生成发射物。
- 你希望发射物与其他对象碰撞时表现出何种行为。

## 创建发射物基类

你将首先创建一个发射物基类，然后从该类派生出子类，以便为工具创建独特的发射物。

要开始设置发射物基类，请执行以下步骤：

1. 在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。 选择**Actor**作为父类，并将类命名为`FirstPersonProjectile`。 点击**创建类（Create Class）**。
2. 在VS中，转到`FirstPersonProjectile.h`。 在文件顶部，前置声明`UProjectileMovementComponent`和`USphereComponent`。

   你将使用一个简单的Sphere组件来模拟发射物和其他对象之间的碰撞。

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved. #pragma once #include "CoreMinimal.h"#include "GameFramework/Actor.h"#include "FirstPersonProjectile.generated.h" class UProjectileMovementComponent;class USphereComponent;
   ```
3. 添加`BlueprintType`和`Blueprintable`说明符，使此类向蓝图公开：

   C++

   ```
   UCLASS(BlueprintType, Blueprintable)class FIRSTPERSON_API AFirstPersonProjectile : public AActor
   ```
4. 打开 `FirstPersonProjectile.cpp`，在文件顶部，添加用于 `"GameFramework/ProjectileMovementComponent.h"` 和 `"Components/SphereComponent.h"` 的include语句，以包含发射物移动和碰撞组件类。

   C++

   ```
   #include "FirstPersonProjectile.h"#include "GameFramework/ProjectileMovementComponent.h"#include "Components/SphereComponent.h" // Sets default valuesAFirstPersonProjectile::AFirstPersonProjectile()
   ```

### 实现发射物击中对象时的行为

为了使发射物更逼真，你可以让其对击中的对象施加一定的力（冲量）。 例如，如果你射击一个启用了物理模拟的方块，发射物会推动方块在地面上移动。 然后，在碰撞后移除发射物，而不是让它继续存在直至默认生命周期结束。 创建一个`OnHit()`函数来实现此行为。

要实现发射物击中行为，请执行以下步骤：

1. 在`FirstPersonProjectile.h`的`public`部分，定义一个名为`PhysicsForce`的`float`（浮点）属性。

   为其添加`UPROPERTY()`宏，并设`EditAnywhere`、`BlueprintReadOnly`、`Category = "Projectile | Physics"`。

   这是发射物击中对象时施加的力度。

   C++

   ```
   // The amount of force this projectile imparts on objects it collides withUPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Projectile | Physics")float PhysicsForce = 100.0f;
   ```
2. 定义一个`void`函数`OnHit()`。 这是AActor中的一个函数，当该Actor与另一个组件或Actor发生碰撞时被调用。 该函数接受以下参数：

   - `HitComp`：被击中的组件。
   - `OtherActor`：被击中的Actor。
   - `OtherComp`：造成碰撞的组件（在本例中为发射物的碰撞组件）。
   - `NormalImpulse`：碰撞的法线冲量。
   - `Hit`：一个`FHitResult`引用，包含有关碰撞事件的更多数据，如时间、距离和位置。

   C++

   ```
   // Called when the projectile collides with an objectUFUNCTION()void OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
   ```
3. 在`FirstPersonProjectile.cpp`中，实现在头文件中定义的`OnHit()`函数。 在`OnHit()`中，通过`if`语句检查：

   1. `OtherActor`不为空且不是发射物自身。
   2. `OtherComp`不为空且正在模拟物理。

   C++

   ```
   void AFirstPersonProjectile::OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit){	// Only add impulse and destroy projectile if we hit a physics object	if ((OtherActor != nullptr) && (OtherActor != this) && (OtherComp != nullptr) && OtherComp->IsSimulatingPhysics())	{	}}
   ```

   这将检查发射物是否击中既非自身且参与物理模拟的其他对象。
4. 在`if`语句内部，使用`AddImpulseAtLocation()`函数向`OtherComp`组件添加冲量。

   将发射物的速度乘以`PhysicsForce`作为参数传入该函数，并在发射物Actor的位置处应用。

   C++

   ```
   void AFirstPersonProjectile::OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit){	// Only add impulse and destroy projectile if we hit a physics object	if ((OtherActor != nullptr) && (OtherActor != this) && (OtherComp != nullptr) && OtherComp->IsSimulatingPhysics())	{		// --- New Code Start ---		OtherComp->AddImpulseAtLocation(GetVelocity() * PhysicsForce, GetActorLocation());		// --- New Code End ---	}}
   ```

   > [!NOTE]
   > `AddImpulseAtLocation()`是虚幻引擎中的物理函数，用于在特定世界空间位置向模拟物理的对象施加瞬时力（冲量）。 当需要模拟爆炸推动物体、子弹击中对象或门被撞开等冲击效果时，该函数非常有用。
5. 由于此发射物已击中另一个Actor，通过调用`Destroy()`将发射物从场景中移除。

完整的`OnHit()`函数应如下所示：

C++

```
void AFirstPersonProjectile::OnHit(UPrimitiveComponent* HitComp, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit){	// Only add impulse and destroy projectile if we hit a physics	if ((OtherActor != nullptr) && (OtherActor != this) && (OtherComp != nullptr) && OtherComp->IsSimulatingPhysics())	{		OtherComp->AddImpulseAtLocation(GetVelocity() * PhysicsForce, GetActorLocation()); 		Destroy();	}}
```

### 添加发射物的网格体、移动和碰撞组件

接下来，为发射物添加静态网格体、发射物移动逻辑和碰撞球体，并定义发射物的移动方式。

要将这些组件添加到发射物，请执行以下步骤：

1. 在`FirstPersonProjectile.h`的 `public`部分，声明一个指向名为`ProjectileMesh`的`UStaticMeshComponent`的 `TObjectPtr`。 这是发射物在世界中的静态网格体。

   为其添加`UPROPERTY()`宏，并设`EditAnywhere`、`BlueprintReadOnly`、`Category = "Projectile | Mesh"`。

   C++

   ```
   // Mesh of the projectile in the world UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Projectile | Mesh")TObjectPtr<UStaticMeshComponent> ProjectileMesh;
   ```
2. 在`protected`部分，声明：

   - 一个指向名为`CollisionComponent`的`USphereComponent`的`TObjectPtr`。
   - 一个指向名为`ProjectileMovement`的`UProjectileMovementComponent`的`TObjectPtr`。

   为这两个添加`UPROPERTY()`宏，并设`VisibleAnywhere`、`BlueprintReadOnly`和`Category = "Projectile | Components"`。

   C++

   ```
   // Sphere collision component UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Projectile | Components")TObjectPtr<USphereComponent> CollisionComponent; // Projectile movement componentUPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Projectile | Components")TObjectPtr<UProjectileMovementComponent> ProjectileMovement;
   ```

   `ProjectileMovementComponent`将为你处理移动逻辑。 它将根据速度、重力和其他变量计算其父级Actor的位置。 然后，在`Tick`时将移动应用到发射物上。
3. 在`FirstPersonProjectile.cpp`的`AFirstPersonProjectile()`构造函数中，为发射物的网格体、碰撞和发射物移动组件创建默认子对象。 然后，将发射物网格体附加到碰撞组件上。

   C++

   ```
   // Sets default values
   AFirstPersonProjectile::AFirstPersonProjectile()
   {
    	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
   	PrimaryActorTick.bCanEverTick = true;

   	// --- New Code Start ---
   	// Use a simple sphere as the collision representation
   	CollisionComponent = CreateDefaultSubobject<USphereComponent>(TEXT("CollisionComponent"));
   	check(CollisionComponent != nullptr);
   ```
4. 调用 `InitSphereRadius()` 以初始化 `CollisionComponent` 的大小。

   C++

   ```
   // Sets default values
   AFirstPersonProjectile::AFirstPersonProjectile()
   {
    	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
   	PrimaryActorTick.bCanEverTick = true;

   	// Use a simple sphere as the collision representation
   	CollisionComponent = CreateDefaultSubobject<USphereComponent>(TEXT("CollisionComponent"));
   	check(CollisionComponent != nullptr);
   ```
5. 使用`BodyInstance.SetCollisionProfileName()`将碰撞组件的碰撞配置文件名称设置为`"Projectile"`。

   C++

   ```
   	CollisionComponent->InitSphereRadius(5.0f); 	// --- New Code Start ---	// Set the collision profile to the "Projectile" collision preset	CollisionComponent->BodyInstance.SetCollisionProfileName("Projectile");	// --- New Code End ---
   ```

   在虚幻编辑器中，碰撞配置文件的存储位置为**项目设置（Project Settings）** > **引擎（Engine）** > **碰撞（Collision）**。你可以在代码中定义最多18个自定义碰撞配置文件以供使用。 此"发射物（Projectile）"碰撞配置文件的默认行为是 **阻挡（Block）**，并在与任何对象碰撞时生成碰撞事件。
6. 你之前定义了`OnHit()`函数，用于在发射物击中对象时激活，但还需要想办法在发生碰撞时发出通知。 为此，使用`AddDynamic()`宏将一个函数订阅到`CollisionComponent`中的`OnComponentHitEvent`。 将此宏传递给`OnHit()`函数。

   C++

   ```
   	CollisionComponent->InitSphereRadius(5.0f); 	// Set the collision profile to the "Projectile" collision preset	CollisionComponent->BodyInstance.SetCollisionProfileName("Projectile"); 	// --- New Code Start ---	// Set up a notification for when this component hits something blocking	CollisionComponent->OnComponentHit.AddDynamic(this, &AFirstPersonProjectile::OnHit);	// --- New Code End ---
   ```
7. 将`CollisionComponent`设置为发射物的`RootComponent`以及移动组件要追踪的`UpdatedComponent`。

   C++

   ```
   	CollisionComponent->InitSphereRadius(5.0f);

   	// Set the collision profile to the "Projectile" collision preset
   	CollisionComponent->BodyInstance.SetCollisionProfileName("Projectile");

   	// Set up a notification for when this component hits something blocking
   	CollisionComponent->OnComponentHit.AddDynamic(this, &AFirstPersonProjectile::OnHit);

   	// --- New Code Start ---
   ```
8. 使用以下值初始化`ProjectileMovement`组件：

   - `InitialSpeed`：发射物生成时的初始速度。 将此值设置为`3000.0f`。
   - `MaxSpeed`：发射物的最大速度。 将此值设置为`3000.0f`。
   - `bRotationFollowVelocity`：对象是否应旋转以匹配速度的方向。 例如，纸飞机上升和下降时的俯仰方式。 将此值设置为`true`。
   - `bShouldBounce`：发射物是否应从障碍物弹开。 将此值设置为`true`。
   - `Bounciness`（反弹力）：碰撞后保留的速度，值越低，抛射物损失的能量越多。 将其设置为 `0.4f`。
   - 摩擦力：撞击后保留多少切向（横向）速度。 将其设置为`0.8f`。

   C++

   ```
   	// Set as root component and UpdatedComponent
   	RootComponent = CollisionComponent;

   	ProjectileMovement->UpdatedComponent = CollisionComponent;
   	// --- New Code Start ---
   	ProjectileMovement->InitialSpeed = 3000.f;
   	ProjectileMovement->MaxSpeed = 3000.f;
   	ProjectileMovement->bRotationFollowsVelocity = true;
   	ProjectileMovement->bShouldBounce = true;
   	ProjectileMovement->Bounciness = 0.2f;  
   ```

### 设置发射物的生命周期

默认情况下，你需要让发射物在发射后的几秒内消失。 不过，当你在编辑器中派生发射物蓝图后，可以尝试更改或移除该默认时间，例如让关卡中充满泡沫飞镖！

要让发射物在几秒之后，请执行以下步骤：

1. 在`FirstPersonProjectile.h`的`public`部分，声明一个名为`ProjectileLifespan`的浮点。

   为其添加`UPROPERTY()`宏，并设`EditAnywhere`、`BlueprintReadOnly`、`Category = "Projectile | Lifespan"`。

   它是发射物的生命周期（以秒为单位）。

   C++

   ```
   // Despawn after 5 seconds by defaultUPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Projectile | Lifespan")float ProjectileLifespan = 5.0f;
   ```
2. 在`FirstPersonProjectile.cpp`中，在`AFirstPersonProjectile()`构造函数的末尾，将发射物的`InitialLifeSpan`设置为`ProjectileLifespan`，使其在五秒后消失。

   C++

   ```
   	ProjectileMovement->UpdatedComponent = CollisionComponent;
   	ProjectileMovement->InitialSpeed = 3000.f;
   	ProjectileMovement->MaxSpeed = 3000.f;
   	ProjectileMovement->bRotationFollowsVelocity = true;
   	ProjectileMovement->bShouldBounce = true;
   	ProjectileMovement->Bounciness = 0.2f;  
   	ProjectileMovement->Friction = 0.8f;  

   	// --- New Code Start ---
   	// Disappear after 5.0 seconds by default.
   ```

   > [!NOTE]
   > `InitialLifeSpan`是从AActor继承的属性。 它是一个用于设置Actor在销毁前存活时长的浮点。 值为`0`表示Actor会一直存在，直到游戏停止。

完整的`FirstPersonProjectile.h`应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "FirstPersonProjectile.generated.h"

class UProjectileMovementComponent;
class USphereComponent;
```

完整的`AFirstPersonProjectile.cpp`应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "FirstPersonProjectile.h"
#include "GameFramework/ProjectileMovementComponent.h"
#include "Components/SphereComponent.h"

// Sets default values
AFirstPersonProjectile::AFirstPersonProjectile()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
```

## 获取角色摄像机方向

发射物应从飞镖发射器本身生成，因此你需要通过计算获取飞镖发射器的位置和朝向。 由于发射器附着在玩家角色上，这些值将随角色位置和视角的变化而变化。

你的第一人称角色包含发射飞镖所需的部分位置信息，因此首先修改你的角色类，通过线迹捕获这些信息并返回结果。

如果要使用追踪从角色获取所需信息，请执行以下步骤：

1. 在VS中，打开你的角色的 `.h`和`.cpp`文件。
2. 在`.h`文件的`public`部分，声明一个名为`GetCameraTargetLocation()` 的新函数，该函数返回一个`FVector`。 此函数将返回角色在世界中视线所指向的位置。

   C++

   ```
   // Returns the location in the world the character is looking atUFUNCTION()FVector GetCameraTargetLocation();
   ```
3. 在你的角色的`.cpp`文件，实现`GetCameraTargetLocation()`函数。 首先声明一个名为`TargetPosition`的`FVector`用于返回。

   C++

   ```
   FVector AAdventureCharacter::GetCameraTargetLocation(){	// The target position to return	FVector TargetPosition;}
   ```
4. 通过调用`GetWorld()`创建`UWorld`的指针。

   C++

   ```
   FVector AAdventureCharacter::GetCameraTargetLocation(){	// The target position to return	FVector TargetPosition; 	// --- New Code Start ---	UWorld* const World = GetWorld();	// --- New Code End ---}
   ```
5. 添加`if`语句检查`World`是否为空。 在`if`语句中，声明一个名为`Hit`的`FHitResult`。

   C++

   ```
   FVector AAdventureCharacter::GetCameraTargetLocation()
   {
   	// The target position to return
   	FVector TargetPosition;

   	UWorld* const World = GetWorld();

   	// --- New Code Start ---
   	if (World != nullptr)
   	{
   ```

   > [!TIP]
   > `FHitResult`是虚幻引擎中的结构体，用于存储碰撞查询结果的信息，包括被击中的Actor或组件以及击中位置。
6. 要确定角色注视的点，你需要沿角色的视线向量模拟一条连接到远处某点的线迹。 如果线迹与对象碰撞，即可确定角色在世界中注视的位置。

   在if语句中，声明两个名为`TraceStart`和`TraceEnd`的`const FVector`值：

   1. 将 `TraceStart` 设置为 `FirstPersonCameraComponent` 的位置。
   2. 将`TraceEnd`设置为`TraceStart`，加上摄像机组件前向向量乘以极大值。 这可确保追踪线足够长，能与世界中的大多数对象碰撞，除非角色正看向天空。 （如果角色正看向天空，`TraceEnd`将作为线迹的终点。）

      C++

      ```
      	if (World != nullptr)
      	{
      		// The result of the line trace
      		FHitResult Hit;

      		// --- New Code Start ---
      		// Simulate a line trace from the character along the vector they're looking down
      		const FVector TraceStart = FirstPersonCameraComponent->GetComponentLocation();
      		const FVector TraceEnd = TraceStart + FirstPersonCameraComponent->GetForwardVector() * 10000.0;
      		// --- New Code End ---
      ```
7. 通过`UWorld`调用`LineTraceSingleByChannel()`模拟追踪。 向它传递`Hit`、`TraceStart`、`TraceEnd`和`ECollisionChannel::ECC_Visibility`。

   这模拟了从`TraceStart`到`TraceEnd`的线迹，与可见对象碰撞并将追踪结果存储在`Hit`中。 `ECollisionChannel::ECC_Visibility`是用于追踪的通道，这些通道定义了你的追踪应尝试命中的对象类型。 使用`ECC_Visibility`进行视线摄像机检查。

   C++

   ```
   	if (World != nullptr)
   	{
   		// The result of the line trace
   		FHitResult Hit;

   		// Simulate a line trace from the character along the vector they're looking down
   		const FVector TraceStart = FirstPersonCameraComponent->GetComponentLocation();
   		const FVector TraceEnd = TraceStart + FirstPersonCameraComponent->GetForwardVector() * 10000.0;

   		// --- New Code Start ---
   ```

   现在，`Hit` 值包含关于命中结果的信息，例如撞击的位置和法线。 它也知道命中是否是对象碰撞的结果。 撞击位置（或追踪线的终点）是要返回的摄像机目标位置。
8. 使用三元运算符将`TargetPosition`设置为`Hit.ImpactPoint`（如果命中是阻挡命中），否则设置为`Hit.TraceEnd`。 然后，返回`TargetPosition`。

   C++

   ```
   	if (World != nullptr)
   	{
   		// The result of the line trace
   		FHitResult Hit;

   		// Simulate a line trace from the character along the vector they're looking down
   		const FVector TraceStart = FirstPersonCameraComponent->GetComponentLocation();
   		const FVector TraceEnd = TraceStart + FirstPersonCameraComponent->GetForwardVector() * 10000.0;

   		// Simulate a line trace and save result in Hit
   ```

完整的`GetCameraTargetLocation()`函数应如下所示：

C++

```
FVector AAdventureCharacter::GetCameraTargetLocation()
{
	// The target position to return
	FVector TargetPosition;

	UWorld* const World = GetWorld();

	if (World != nullptr)
	{
		// The result of the line trace
```

## 使用DartLauncher::Use()生成发射物

现在你已经知道角色的注视点，你可以在飞镖发射器的 `Use()`函数中实现发射物逻辑的其余部分。 你将获得发射发射物的位置和方向，然后生成发射物。

要获取发射物应生成的位置和旋转，请执行以下步骤：

1. 在`DartLauncher.h`中，在文件顶部，添加`AFirstPersonProjectile`的前置声明。
2. 在`public` 部分，声明一个名为`ProjectileClass 的<AFirstPersonProjectile>` TSubclassOf 属性。 这将是飞镖发射器生成的发射物。 为其添加`UPROPERTY()`宏，设置为`EditAnywhere`和`Category = "Projectile"`。

   `DartLauncher.h`现在应如下所示：

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved.

   #pragma once

   #include "CoreMinimal.h"
   #include "EquippableToolBase.h"
   #include "DartLauncher.generated.h"

   class AFirstPersonProjectile;
   ```
3. `DartLauncher.cpp`，添加include语句：

   - `”Kismet/Kismet数学库.h”`。 发射物数学运算可能很复杂，此文件包含多个你将用于发射发射物的函数。
   - `"FirstPersonProjectile.h"`
   - `"EnhancedInputComponent.h"`

   C++

   ```
   #include "Tools/DartLauncher.h"#include "FirstPersonProjectile.h"  #include "Kismet/KismetMathLibrary.h"#include "EnhancedInputComponent.h" #include "AdventureCharacter.h"
   ```
4. 在DartLauncher的`Use()`实现中，在调试消息之后：

   1. 通过调用`GetWorld()`获取`UWorld`。
   2. 添加`if`语句检查`World`和`ProjectileClass`是否为空。
   3. 在 `if` 语句中，通过调用 `OwningCharacter->GetCameraTargetLocation()` 获取角色正在注释的位置。

   C++

   ```
   void ADartLauncher::Use()
   {
   	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));

     UWorld* const World = GetWorld();
     if (World != nullptr && ProjectileClass != nullptr)
     {
       FVector TargetPosition = OwningCharacter->GetCameraTargetLocation();
     }
   ```
5. 发射物应从角色持有的工具生成，而不是从装备对象的中心生成。 飞镖发射器的`SKM_Pistol`网格体有一个"枪口（Muzzle）"插槽，你可以用它来为你的飞镖设置精确的生成点。

   在`if`语句中，声明一个新的`FVector`，命名为`SocketLocation`，并将其设置为在`ToolMeshComponent`上调用`GetSocketLocation(“Muzzle”)`的结果。

   C++

   ```
   	if (World != nullptr && ProjectileClass != nullptr)	{		// Get the direction of the player camera		FVector TargetPosition = OwningCharacter->GetCameraTargetLocation(); 		// --- New Code Start ---		// Get the correct socket to spawn the projectile from		FVector SocketLocation = ToolMeshComponent->GetSocketLocation("Muzzle");		// --- New Code End ---	}
   ```
6. 声明一个名为`SpawnRotation`的`FRotator`。 这是发射物生成时的旋转（俯仰、偏转和滚动值）。

   将其设置为从kismet数学库调用 `FindLookAtRotation()` 的结果，传递你从玩家角色获得的 `SocketLocation` 和 `TargetPosition`。

   C++

   ```
   	if (World != nullptr && ProjectileClass != nullptr)
   	{
   		// Get the direction of the player camera
   		FVector TargetPosition = OwningCharacter->GetCameraTargetLocation();

   		// Get the correct socket to spawn the projectile from
   		FVector SocketLocation = ToolMeshComponent->GetSocketLocation("Muzzle");

   		// --- New Code Start ---
   		// Get projectile's rotation as it spawns so we know in what direction to apply an offset 
   ```

   `FindLookAtRotation` 会计算并返回在 `SocketLocation` 处面对 `TargetPosition` 所需的旋转。
7. 声明一个名为 `SpawnLocation` 的 `FVector`，并将其设置为 `SocketLocation` 加上 `SpawnRotation` 的前向向量乘以 `10.0` 的结果。

   > [!NOTE]
   > 枪口插槽并不完全位于发射器的前端，因此你需要将向量乘以一个偏移量，以使发射物从正确位置发射。

   C++

   ```
   	if (World != nullptr && ProjectileClass != nullptr)
   	{
   		// Get the direction of the player camera
   		FVector TargetPosition = OwningCharacter->GetCameraTargetLocation();

   		// Get the correct socket to spawn the projectile from
   		FVector SocketLocation = ToolMeshComponent->GetSocketLocation("Muzzle");

   		// Get the rotation of the projectile as it spawns so we know in what direction to apply an offset 
   		FRotator SpawnRotation = UKismetMathLibrary::FindLookAtRotation(SocketLocation, TargetPosition);
   ```

现在你已经获得位置和旋转，可以准备生成发射物。

要生成发射物，请执行以下步骤：

1. 仍然在`Use()`函数中，在`if`语句中，声明一个名为`ActorSpawnParams`的`FActorSpawnParameters`。 该类包含关于在何处以及如何生成Actor的信息。

   C++

   ```
   void ADartLauncher::Use()
   {
   	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));

   	UWorld* const World = GetWorld();
   	if (World != nullptr && ProjectileClass != nullptr)
   	{
   		// Get the direction of the player camera
   		FVector TargetPosition = OwningCharacter->GetCameraTargetLocation();
   ```
2. 将 `ActorSpawnParams`中的 `SpawnCollisionHandlingOverride`值设置为`ESpawnActorCollisionHandlingMethod::AdjustIfPossibleButDontSpawnIfColliding`。

   C++

   ```
   		//Set Spawn Collision Handling Override		FActorSpawnParameters ActorSpawnParams; 		// --- New Code Start ---		ActorSpawnParams.SpawnCollisionHandlingOverride = ESpawnActorCollisionHandlingMethod::AdjustIfPossibleButDontSpawnIfColliding;		// --- New Code End ---
   ```

   这行代码尝试找到一个发射物不与其他Actor碰撞的生成位置（例如墙内），如果没有找到合适的位置，则不会生成。
3. 使用 `SpawnActor()` 在飞镖发射器的枪口处生成发射物，传入`ProjectileClass`、`SpawnLocation`、`SpawnRotation`和`ActorSpawnParams`。

   C++

   ```
   		ActorSpawnParams.SpawnCollisionHandlingOverride = ESpawnActorCollisionHandlingMethod::AdjustIfPossibleButDontSpawnIfColliding; 		// --- New Code Start ---		// Spawn the projectile at the muzzle		World->SpawnActor<AFirstPersonProjectile>(ProjectileClass, SpawnLocation, SpawnRotation, ActorSpawnParams);		// --- New Code End ---
   ```

完整的`Use()`函数现在应如下所示：

C++

```
void ADartLauncher::Use()
{
	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));

	UWorld* const World = GetWorld();
	if (World != nullptr && ProjectileClass != nullptr)
	{
		FVector TargetPosition = OwningCharacter->GetCameraTargetLocation();
			
		// Get the correct socket to spawn the projectile from
```

## 派生泡沫飞镖类和蓝图

现在所有生成逻辑已完成，该编译真实的发射物了！ 你的飞镖发射器类需要一个`AFirstPersonProjectile`的子类来发射，因此你需要在代码中编译一个子类，以便在关卡中使用。

要派生一个供游戏中使用的泡沫飞镖发射物类，请执行以下步骤：

1. 在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。
2. 转到**所有类（All Classes）**，搜索并选择 **第一人称发射物（First Person Projectile）** 作为父类，将类命名为 `FoamDart`。 点击 **创建类（Create Class）**。
3. 在VS中，保持这些文件不变，保存代码并编译。

在本教程中，除了在`FirstPersonProjectile`中定义的内容外，你无需实现任何自定义发射物代码，但你可以自行修改`FoamDart`类以满足项目需求。 例如，你可以尝试让飞镖发射物粘在对象上，而不是消失或弹开。

要创建泡棉飞镖蓝图，请按以下步骤：

1. 在虚幻编辑器中，创建一个基于**FoamDart**的蓝图类，命名为`BP_FoamDart`。 将其保存在`FirstPerson/Blueprints/Tools`文件夹中。
2. 打开蓝图后，选择**发射物网格体（Projectile Mesh）**组件，将**静态网格体（Static Mesh）**设置为`SM_FoamBullet`。
3. 泡沫飞镖网格体出现在**视口**中。 放大或按 **F** 键查看网格体的朝向。 飞镖的圆形端是前端，应指向X轴正方向，这样你的飞镖就能以正确的方向发射（`ProjectileMovement` 假设+X为前方）。

   将飞镖沿Z（蓝色）轴旋转+90度。
4. 编译并保存蓝图。
5. 在**内容浏览器（Content Browser）**中，打开**`BP_DartLauncher`**。
6. 在其**细节（Details）**面板的新的**发射物（Projectile）**分段中，将**发射物类（Projectile Class）**设为`BP_FoamDart`。

   > [!NOTE]
   > 如果你未能在列表中看到`BP_FoamDart`，则请转到内容浏览器，选择`BP_FoamDart`，然后回到**发射物类（Projectile Class）**属性，并点击**使用来自内容浏览器的选定资产（Use Selected Asset from Content Browser）**。
7. 点击**编译（Compile）**并**保存（Save）**。

现在是见证成果的时刻。 保存你的资产并点击**播放（Play）**。 游戏开始时，你可以跑到飞镖发射器旁拾取它。 按下鼠标左键会从飞镖发射器的枪口生成一个发射物，并在关卡中弹跳！ 这些发射物应在五秒后消失，并对碰撞的对象（包括你自己！）施加一个小的物理力。

> [!TIP]
> 如果飞镖发射器没有发射，并且你没有看到“正在使用飞镖发射器！”调试消息，确保你已将`IA_UseTool`分配给你的角色的蓝图中的**使用操作**属性。

## 进阶：调整子弹和工具

你可以选择实现这些最终调整，让你的飞镖发射器和飞镖看起来最棒。

#### 使坠落的投射物平放

在`FirstPersonProjectile.cpp`中，当发射物击中某个物体时，检查发射物是否击中地面（一个平坦的水平表面），如果是，则使其平躺。

在`OnHit()`的顶部，添加以下代码：

C++

```
// If we hit the ground (mostly-up surface normal), lay the dart flat.if (FVector::DotProduct(Hit.ImpactNormal, FVector::UpVector) > 0.7f){    FRotator Flat = GetActorRotation();    Flat.Pitch = 0.f;    Flat.Roll = 0.f;    SetActorRotation(Flat);     return;}
```

## 下一步

祝贺你！ 你已完成第一人称程序员路径教程，并在此过程中学到了很多知识！

你已实现了自定义角色和移动、创建拾取物和数据资产，甚至还制作了可装备的工具及其发射物。 现在，你掌握了所有必要的知识，可以将此项目打造成完全属于你自己的作品。

以下是一些建议：

- 能否扩展玩家的物品栏以容纳不同类型的物品？ 要不要实现物品堆叠功能？
- 能否将拾取物与发射物结合，创建可拾取的弹药？ 要不要在飞镖发射器中实现此弹药系统？
- 能否将消耗品发展成可装备的消耗品？ 比如玩家手持的医疗包，或是可拾取并投掷的球？

## 完整代码

C++

FirstPersonProjectile.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "FirstPersonProjectile.generated.h"

class UProjectileMovementComponent;
class USphereComponent;
```

C++

FirstPersonProjectile.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "FirstPersonProjectile.h"
#include "GameFramework/ProjectileMovementComponent.h"
#include "Components/SphereComponent.h"

// Sets default values
AFirstPersonProjectile::AFirstPersonProjectile()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
```

C++

AdventureCharacter.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Camera/CameraComponent.h"
#include "GameFramework/Character.h"
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h" 
#include "InputActionValue.h"
```

C++

AdventureCharacter.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.


#include "AdventureCharacter.h"
#include "InventoryComponent.h"
#include "EquippableToolDefinition.h"
#include "EquippableToolBase.h"

// Sets default values
AAdventureCharacter::AAdventureCharacter()
```

C++

DartLauncher.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "EquippableToolBase.h"
#include "DartLauncher.generated.h"

class AFirstPersonProjectile;
```

C++

DartLauncher.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.


#include "Tools/DartLauncher.h"
#include "FirstPersonProjectile.h"  
#include "Kismet/KismetMathLibrary.h"
#include "EnhancedInputComponent.h" 
#include "AdventureCharacter.h"
```

C++

EquippableToolBase.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "EnhancedInputSubsystems.h"    //
#include "Animation/AnimBlueprint.h"
#include "Components/SkeletalMeshComponent.h"
#include "EquippableToolBase.generated.h"
```

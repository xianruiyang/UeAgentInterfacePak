---
title: "多人游戏编程快速入门指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/multiplayer-programming-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络多人游戏基础", "多人游戏编程快速入门指南"]
---

# 多人游戏编程快速入门指南

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络多人游戏基础 / 多人游戏编程快速入门指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/multiplayer-programming-quick-start-for-unreal-engine

开发多人游戏的游戏进程需要在游戏的 **Actor** 中实现 **复制**。还必须设计特定于 **服务器**（充当游戏会话的主机）或 **客户端**（代表连接到会话的玩家）的功能。本指南将介绍创建简单多人游戏进程的流程，包括以下内容：

- 如何向基本Actor添加复制。
- 如何利用网络游戏中的

  移动组件

  。
- 如何向

  变量

  添加复制。
- 如何在变量更改时使用

  RepNotify

  。
- 如何在C++环境下使用

  远程过程调用(RPC)

  。
- 如何检查Actor的

  网络角色

  ，以过滤在函数中执行的调用。

最终将形成第三人称游戏，玩家可以向对方投掷爆炸性投射物。我们的主要工作是创建投射物并向角色添加伤害响应。

> [!NOTE]
> 在开始之前，强烈建议查看[设置专用服务器](../../network-programming-tutorials-and-examples/setting-up-dedicated-servers/index.md)和[网络概述](../networking-overview/index.md)页面上的要点。作为本指南的比对点，可参见[第一人称射击游戏教程](https://dev.epicgames.com/documentation/404)一文，但其中未介绍复制概念。

## 1.基本设置

1. 打开 **编辑器**，创建一个 **新项目**。确保使用以下设置：

   - 是

     C++项目
   - 使用

     第三人称模板
   - 包括

     初学者内容包
   - 针对

     台式计算机

   应用这些设置后，将项目命名为 **ThirdPersonMP**，然后单击 **创建（Create）** 按钮继续。将创建项目的C++文件，且 **虚幻编辑器** 将自动打开 **ThirdPersonExampleMap**。
2. 单击此场景中站立的 **ThirdPersonCharacter** 并 **删除** 它，然后确保地图中存在两个 **玩家出生点**。这些出生点会生成玩家，而非手动放置场景默认包括的ThirdPersonCharacter。

   ![Add PlayerStarts](../../../../../assets/images/51/51b2a830804020e88b8a165ae63db6c6407b796c7a94a978dec61db89306e428.jpg)

大多数模板中的Pawn和角色默认启用了复制。在此示例中，ThirdPersonCharacter已拥有会自动复制移动的 **角色移动组件**。

> [!NOTE]
> 欲了解角色移动组件处理复制的方式以及扩展该组件的功能的方式，参见[角色移动组件](https://dev.epicgames.com/documentation/404)指南。

化妆组件，如角色的 **骨架网格体** 及其 **动画蓝图**，不会被复制。但与游戏进程和移动相关的变量（如角色的速度）则会被复制。动画蓝图会在变量更新时读取这些变量。通过这种方式，角色在每个客户端上的副本都会更新其视觉呈现。这一过程的执行方式与gameplay变量的准确更新保持一致。同样，[**Gamepla框架**](../../../gameplay-framework/index.md)会自动处理角色在玩家出生点的生成操作，并向角色分配 **玩家控制器**。

若使用此项目启动服务器，并有客户端加入该服务器，这就已经是一个正常的多人游戏。但玩家仅可让其游戏化身移动和跳跃。因此要创建一些其他的多人游戏进程。

## 2.使用RepNotify复制玩家的生命值

玩家需要生命值，才能在游戏进程受到伤害。该值需要复制，使所有客户端都拥有各玩家生命值的同步信息，并需要在玩家受到伤害时向其提供反馈。本节将演示如何在不依赖RPC的情况下，利用RepNotify同步变量的所有必要更新。

> [!NOTE]
> 注意，'Role' 已经被相应替换为 'GetLocalRole()' 和 'GetRemoteRole()'。你会注意到下述小节中有些地方之前使用的是 'Role'，请注意更改。

1. 打开 `ThirdPersonMPCharacter.h`。在 `protected` 下添加以下属性：
2. 打开 `ThirdPersonMPCharacter.h`。在 `protected` 下添加以下属性：

   ThirdPersonMPCharacter.h

   ```
        protected:      /** 玩家的最大生命值。这是玩家的最高生命值。此值为玩家出生时的生命值。*/     UPROPERTY(EditDefaultsOnly, Category = "Health")     float MaxHealth;      /** 玩家的当前生命值。降到0就表示死亡。*/     UPROPERTY(ReplicatedUsing = OnRep_CurrentHealth)     float CurrentHealth;      /** RepNotify，用于同步对当前生命值所做的更改。*/     UFUNCTION()     void OnRep_CurrentHealth(); 
   ```

   你需要严格控制玩家生命值的变化，因此这些生命值有以下约束：

- MaxHealth

  不复制，仅可在默认值中编辑。此值是针对所有玩家预先计算得出的，不会更改。
- CurrentHealth

  复制，但无法在蓝图的任何地方编辑或访问。
- MaxHealth

  和

  CurrentHealth

  都是

  受保护

  的，以防被外部C++类访问。仅可在

  AThirdPersonMPCharacter

  或其派生类中进行修改。

这降低了实时游戏进程中玩家的 `CurrentHealth` 或 `MaxHealth` 发生意外更改的风险。在稍后的步骤中，你要提供其他公共函数，用于获取和修改这些值。

`Replicated` 说明符在服务器上启用Actor的副本，以在变量值更改时，将该变量值复制到所有连接的客户端。`ReplicatedUsing` 也有同样的功能，但还能让你设置 **RepNotify** 函数。此函数将在客户端成功接收复制数据时触发。你将基于此变量的更改，使用 `OnRep_CurrentHealth` 执行各个客户端的更新。

1. 打开 `ThirdPersonMPCharacter.cpp`。在顶部的 `#include "GameFramework/SpringArmComponent.h"` 一行下添加以下 `#include` 语句：

   ThirdPersonMPCharacter.cpp

   ```
        #include "Net/UnrealNetwork.h"     #include "Engine/Engine.h" 
   ```

   它们提供用于复制变量以及访问 `GEngine` 中的 `AddOnscreenDebugMessage` 函数（用于将消息输出至屏幕）的必要功能。
2. 在 `ThirdPersonMPCharacter.cpp` 中，在 `AThirdPersonMPCharacter` 构造函数底部添加以下代码：

   ThirdPersonMPCharacter.cpp

   ```
        //初始化玩家生命值     MaxHealth = 100.0f;     CurrentHealth = MaxHealth; 
   ```

   这将初始化玩家的生命值。创建此角色的新副本时，角色当前生命值将设为其最大生命值。
3. 在 `ThirdPersonMPCharacter.h` 中，在 `AThirdPersonMPCharacter` 构造函数之后添加以下公共函数声明：

   ThirdPersonMPCharacter.h

   ```
        /** 属性复制 */     void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override; 
   ```
4. 在 `ThirdPersonMPCharacter.cpp` 中，为此函数添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
       //////////////////////////////////////////////////////////////////////////    // 复制的属性     void AThirdPersonMPCharacter::GetLifetimeReplicatedProps(TArray <FLifetimeProperty> & OutLifetimeProps) const    {        Super::GetLifetimeReplicatedProps(OutLifetimeProps);         //复制当前生命值。        DOREPLIFETIME(AThirdPersonMPCharacter, CurrentHealth);    } 
   ```

   `GetLifetimeReplicatedProps` 函数负责复制你使用 `Replicated` 说明符指派的任何属性，并可用于配置属性的复制方式。这里使用 `CurrentHealth` 的最基本实现。一旦添加更多需要复制的属性，也必须添加到此函数。

   > [!WARNING]
   > 必须调用 `GetLifetimeReplicatedProps` 的 `Super` 版本，否则从Actor父类继承的属性不会复制，即便该父类指定要复制。
5. 在 `ThirdPersonMPCharacter.h` 中，在 `Protected` 下添加以下函数声明：

   ThirdPersonMPCharacter.h

   ```
        protected:     /** 响应要更新的生命值。修改后，立即在服务器上调用，并在客户端上调用以响应RepNotify*/     void OnHealthUpdate(); 
   ```
6. 在 `ThirdPersonMPCharacter.cpp` 中，添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
        void AThirdPersonMPCharacter::OnHealthUpdate()     {         //客户端特定的功能         if (IsLocallyControlled())         {             FString healthMessage = FString::Printf(TEXT("You now have %f health remaining."), CurrentHealth);             GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Blue, healthMessage);              if (CurrentHealth <= 0)             {                 FString deathMessage = FString::Printf(TEXT("You have been killed."));                 GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Red, deathMessage);             }         }          //服务器特定的功能         if (GetLocalRole() == ROLE_Authority)         {             FString healthMessage = FString::Printf(TEXT("%s now has %f health remaining."), *GetFName().ToString(), CurrentHealth);             GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Blue, healthMessage);         }          //在所有机器上都执行的函数。         /*             因任何因伤害或死亡而产生的特殊功能都应放在这里。         */     } 
   ```

   你将使用此函数执行更新，以响应玩家的 `CurrentHealth` 所发生的更改。目前它的功能仅限于提供屏幕调试消息，但后续可添加更多功能。例如，在所有机器上调用的 `OnDeath` 函数，用于触发死亡动画。注意，`OnHealthUpdate` 不复制，需要在所有设备上手动调用。
7. 在 `ThirdPersonMPCharacter.cpp` 中，为 `OnRep_CurrentHealth` 添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
        void AThirdPersonMPCharacter::OnRep_CurrentHealth()     {         OnHealthUpdate();     } 
   ```

   变量在其值发生更改时复制，而非持续不断地复制，`RepNotify` 在客户端成功收到变量的复制值时运行。因此，只要在服务器上更改玩家的 `CurrentHealth`，`OnRep_CurrentHealth` 就会在所有连接的客户端上运行。这就使 `OnRep_CurrentHealth` 成为在客户端机器上调用 `OnHealthUpdate` 的最佳场所。

## 3.使玩家响应伤害

现在你已实现玩家的生命值，接下来需要想办法在此类之外修改玩家生命值。

1. 在 `ThirdPersonMPCharacter.h` 中，在 `Public` 下添加以下函数声明：

   ThirdPersonMPCharacter.h

   ```
        public:     /** 最大生命值的取值函数。*/     UFUNCTION(BlueprintPure, Category="Health")     FORCEINLINE float GetMaxHealth() const { return MaxHealth; }      /** 当前生命值的取值函数。*/     UFUNCTION(BlueprintPure, Category="Health")     FORCEINLINE float GetCurrentHealth() const { return CurrentHealth; }      /** 当前生命值的存值函数。将此值的范围限定在0到MaxHealth之间，并调用OnHealthUpdate。仅在服务器上调用。*/     UFUNCTION(BlueprintCallable, Category="Health")     void SetCurrentHealth(float healthValue);      /** 承受伤害的事件。从APawn覆盖。*/     UFUNCTION(BlueprintCallable, Category = "Health")     float TakeDamage( float DamageTaken, struct FDamageEvent const& DamageEvent, AController* EventInstigator, AActor* DamageCauser ) override; 
   ```

   `GetMaxHealth` 和 `GetCurrentHealth` 函数取值函数，可在C++环境和蓝图中从 `AThirdPersonMPCharacter` 外部访问玩家生命值。它们作为 `const` 函数，能安全地获取这些值，而且不允许修改。你还声明了用于设置玩家生命值和承受伤害的函数。
2. 在 `ThirdPersonMPCharacter.cpp` 中，为 `SetCurrentHealth` 添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
        void AThirdPersonMPCharacter::SetCurrentHealth(float healthValue)     {         if (GetLocalRole() == ROLE_Authority)         {             CurrentHealth = FMath::Clamp(healthValue, 0.f, MaxHealth);             OnHealthUpdate();         }     } 
   ```

   `SetCurrentHealth` 提供了一种可控的办法从 `AThirdPersonMPCharacter` 外部修改玩家 `CurrentHealth` 。此函数并非复制而来，但是通过检查确认Actor的网络角色为 `ROLE_Authority`，你限制仅在托管的游戏服务器上调用此函数时，此函数才会执行。它将 `CurrentHealth` 值的范围限定于0到玩家 `MaxHealth` 之间，因此无法将 `CurrentHealth` 设置为无效值。它还会调用 `OnHealthUpdate` 以确保服务器和客户端都有对此函数的并行调用。由于服务器不会收到RepNotify，因此此功能是必要的。

   > [!TIP]
   > 虽然并非所有变量都需要这样的"存值"函数，但对于游戏期间会频繁变化的敏感游戏进程变量，尤其是可被很多不同源修改的变量，这种函数很有用。对于类似的单机游戏和多人游戏，使用存值函数都是最佳做法，因为它使这些变量的实时更改更加一致，更便于调试，也更容易扩展新功能。
3. 在 `ThirdPersonMPCharacter.cpp` 中，为 `TakeDamage` 添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
        float AThirdPersonMPCharacter::TakeDamage(float DamageTaken, struct FDamageEvent const& DamageEvent, AController* EventInstigator, AActor* DamageCauser)     {         float damageApplied = CurrentHealth - DamageTaken;         SetCurrentHealth(damageApplied);         return damageApplied;     } 
   ```

   这些内置函数用于对Actor施加伤害，会调用该Actor的 `TakeDamage` 基本函数。本例中使用 `SetCurrentHealth` 实现简单的生命值扣减。

若已学到本节此处，那么以下应是对Actor施加伤害的流程：

- 外部Actor或函数对角色调用

  CauseDamage

  ，而角色又调用其

  TakeDamage

  函数。
- TakeDamage

  调用

  SetCurrentHealth

  以在服务器上更改玩家的当前生命值。
- SetCurrentHealth

  在服务器上调用

  OnHealthUpdate

  ，导致执行功能，响应玩家生命值的更改。
- CurrentHealth

  复制到所有已连接的客户端的角色副本。
- 各个客户端从服务器收到

  CurrentHealth

  的新值时，会调用

  OnRep_CurrentHealth

  。
- OnRep_CurrentHealth

  调用

  OnHealthUpdate

  ，确保各个客户端以相同方式响应

  CurrentHealth

  的新值。

此实现有两个优势。首先，它浓缩了围绕两大关键函数 `SetCurrentHealth` 和 `OnHealthUpdate` 添加的新功能的工作流程，这两个函数会使将来的代码维护和扩展工作变得更加容易。其次，由于此实现不使用任何服务器、客户端或NetMulticast RPC，它浓缩了在整个网络上发送的信息量，仅依靠复制 `CurrentHealth` 以触发所有必要更改。由于无论实现了任何其他函数，`CurrentHealth` 都需要复制，因此这是复制生命值更改的最有效模型。

## 4.使用复制创建投射物

1. 在虚幻编辑器中，使用 **工具（Tools）** 菜单或 **内容浏览器** 创建 **新C++类**。

   ![Create New Class](../../../../../assets/images/03/034dd856ab7fb0223d34ab07775d239b1eb7449502c041eb4890415e1628d2d4.png)
2. 在 **选择父类（Choose Parent Class）** 菜单中，选择 **Actor** 作为父类，并单击 **下一步（Next）**。

   ![undefined](../../../../../assets/images/0a/0aa5f2462e96f534aae6bc0cee065eaca8b23c81614134818e89fab849e383ab.jpg)

   点击查看大图。
3. 在 **命名新Actor（Name Your New Actor）** 菜单，将类命名为 **ThirdPersonMPProjectile**，然后单击 **创建类（Create Class）**。

   ![undefined](../../../../../assets/images/0c/0c52dbb041401ade1b627f7e38f9c44cd810f30f08acf07e27c66ad6de5c9a80.jpg)

   点击查看大图。
4. 打开 `ThirdPersonMPProjectile.h`，并将以下代码添加到类定义中的 `public` 下：

   ThirdPersonMPProjectile.h

   ```
        public:     // 用于测试碰撞的球体组件。     UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Components")     class USphereComponent* SphereComponent;      // 用于提供对象视觉呈现效果的静态网格体。     UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Components")     class UStaticMeshComponent* StaticMesh;      // 用于处理投射物移动的移动组件。     UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Components")     class UProjectileMovementComponent* ProjectileMovementComponent;      // 在投射物撞击其他对象并爆炸时使用的粒子。     UPROPERTY(EditAnywhere, Category = "Effects")     class UParticleSystem* ExplosionEffect;      //此投射物将造成的伤害类型和伤害。     UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Damage")     TSubclassOf<class UDamageType> DamageType;      //此投射物造成的伤害。     UPROPERTY(EditAnywhere, BlueprintReadOnly, Category="Damage")     float Damage; 
   ```

   > [!NOTE]
   > 这些声明中的各个类型前面都冠以 `class` 关键字。这样，这些声明除了是变量声明之外，还是各自类的前向声明，从而确保各自的类会在头文件中被识别。下一个步骤中，你要在CPP文件中为它们添加 `#include`。

   你正在声明的属性将提供以下项目：

   - 静态网格体组件

     ，作为投射物的视觉呈现。
   - 球体组件

     ，用于检查碰撞。
   - 投射物移动组件

     ，用于移动投射物。
   - 粒子系统

     ，引用你要使用的内容，在后续步骤中生成爆炸效果。
   - 伤害类型

     ，用于伤害事件。
   - 伤害

     的浮点值，表示角色被此投射物击中时应扣减的生命值。

   但以上各项都尚未定义。

   > [!NOTE]
   > 像角色移动组件一样，投射物移动组件在移动其所归属的Actor时，若该Actor的 `bReplicates` 设为 `True`，则投射物移动组件自动处理复制。
5. 打开 `ThirdPersonMPProjectile.cpp`，将以下代码添加到文件顶部的 `#include` 语句中的 `#include "ThirdPersonMPProjectile.h"` 一行下：

   ThirdPersonMPProjectile.cpp

   ```
        #include "Components/SphereComponent.h"     #include "Components/StaticMeshComponent.h"     #include "GameFramework/ProjectileMovementComponent.h"     #include "GameFramework/DamageType.h"     #include "Particles/ParticleSystem.h"     #include "Kismet/GameplayStatics.h"     #include "UObject/ConstructorHelpers.h" 
   ```

   你需要在本演示中使用这些语句。前四个是你使用的组件，而 `GamePlayStatics.h` 可用于访问基本游戏进程函数，`ConstructorHelpers.h` 可用于访问一些有用的构造函数以便设置组件。
6. 将以下代码添加到 `AThirdPersonMPProjectile` 中的构造函数中：

   ThirdPersonMPProjectile.cpp

   ```
        bReplicates = true; 
   ```

   `bReplicates` 变量告知游戏此Actor应复制。Actor默认仅存在于生成它的机器上。当 `bReplicates` 设为 `True`，只要Actor的权威副本存在于服务器上，就会尝试将该Actor复制到所有已连接的客户端。
7. 将以下代码添加到 `AThirdPersonMPProjectile` 构造函数中：

   ThirdPersonMPProjectile.cpp

   ```
        //定义将作为投射物及其碰撞的根组件的SphereComponent。     SphereComponent = CreateDefaultSubobject<USphereComponent>(TEXT("RootComponent"));     SphereComponent->InitSphereRadius(37.5f);     SphereComponent->SetCollisionProfileName(TEXT("BlockAllDynamic"));     RootComponent = SphereComponent; 
   ```

   这会在构造对象时定义SphereComponent，使投射物碰撞。
8. 在 `AThirdPersonMPProjectile` 构造函数中添加以下代码：

   ThirdPersonMPProjectile.cpp

   ```
        //定义将作为视觉呈现的网格体。     static ConstructorHelpers::FObjectFinder<UStaticMesh> DefaultMesh(TEXT("/Game/StarterContent/Shapes/Shape_Sphere.Shape_Sphere"));     StaticMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));     StaticMesh->SetupAttachment(RootComponent);      //若成功找到要使用的静态网格体资产，则设置该静态网格体及其位置/比例。     if (DefaultMesh.Succeeded())     {         StaticMesh->SetStaticMesh(DefaultMesh.Object);         StaticMesh->SetRelativeLocation(FVector(0.0f, 0.0f, -37.5f));         StaticMesh->SetRelativeScale3D(FVector(0.75f, 0.75f, 0.75f));     } 
   ```

   这将定义要作为视觉呈现的StaticMeshComponent。将自动尝试在 **初学者内容包** 中查找 **Shape_Sphere** 网格体，并自行填充。球体也将调整尺寸，与SphereComponent尺寸一致。
9. 在构造函数 `AThirdPersonMPProjectile` 中添加以下代码：

   ThirdPersonMPProjectile.cpp

   ```
        static ConstructorHelpers::FObjectFinder<UParticleSystem> DefaultExplosionEffect(TEXT("/Game/StarterContent/Particles/P_Explosion.P_Explosion"));     if (DefaultExplosionEffect.Succeeded())     {         ExplosionEffect = DefaultExplosionEffect.Object;     } 
   ```

   这将把 `ExplosionEffect`的资产引用设置为StarterContent中的 **P_Explosion** 资产。
10. 在构造函数 `AThirdPersonMPProjectile` 中添加以下代码：

    ThirdPersonMPProjectile.cpp

    ```
         //定义投射物移动组件。     ProjectileMovementComponent = CreateDefaultSubobject<UProjectileMovementComponent>(TEXT("ProjectileMovement"));     ProjectileMovementComponent->SetUpdatedComponent(SphereComponent);     ProjectileMovementComponent->InitialSpeed = 1500.0f;     ProjectileMovementComponent->MaxSpeed = 1500.0f;     ProjectileMovementComponent->bRotationFollowsVelocity = true;     ProjectileMovementComponent->ProjectileGravityScale = 0.0f; 
    ```

    这将定义投射物的投射物移动组件。该组件会复制，在服务器上执行的任何移动都将复制到客户端上。
11. 在构造函数 `AThirdPersonMPProjectile` 中添加以下代码：

    ThirdPersonMPProjectile.cpp

    ```
         DamageType = UDamageType::StaticClass();     Damage = 10.0f; 
    ```

    这些代码会初始化投射物将对Actor造成的伤害量以及将在伤害事件中使用的伤害类型。本例中由于尚未定义任何新伤害类型，因此使用基本 `UDamageType` 进行初始化。

## 5.使投射物造成伤害

若已按本指南学到此处，应可在服务器上生成投射物，且将在所有客户端上显示并移动。但若撞到墙壁或阻挡物，就会停止。你需要它对玩家造成伤害，并需要对会话中所有已连接的客户端显示爆炸效果。

1. 在 `ThirdPersonMPProjectile.h` 中，在 `Protected` 下添加以下代码：

   ThirdPersonMPProjectile.h

   ```
        protected:     virtual void Destroyed() override; 
   ```
2. 在 `ThirdPersonMPProjectile.cpp` 中，为此函数添加以下实现：

   ThirdPersonMPProjectile.cpp

   ```
        void AThirdPersonMPProjectile::Destroyed()     {         FVector spawnLocation = GetActorLocation();         UGameplayStatics::SpawnEmitterAtLocation(this, ExplosionEffect, spawnLocation, FRotator::ZeroRotator, true, EPSCPoolMethod::AutoRelease);     } 
   ```

   每当有Actor被摧毁时，就会调用 `Destroyed` 函数。粒子发射器自身通常不复制，但由于Actor摧毁会复制，因此只要在服务器上摧毁此投射物，则各个连接客户端都会在摧毁各自的投射物副本时调用此函数。结果，所有玩家都会看到投射物被摧毁时的爆炸效果。
3. 在 `ThirdPersonMPProjectile.h` 中，在 `Protected` 下添加以下代码：

   ThirdPersonMPProjectile.h

   ```
        UFUNCTION(Category="Projectile")     void OnProjectileImpact(UPrimitiveComponent* HitComponent, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit); 
   ```
4. 在 `ThirdPersonMPProjectile.cpp` 中，为此函数添加以下实现：

   ThirdPersonMPProjectile.cpp

   ```
        void AThirdPersonMPProjectile::OnProjectileImpact(UPrimitiveComponent* HitComponent, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit)     {         if ( OtherActor )         {             UGameplayStatics::ApplyPointDamage(OtherActor, Damage, NormalImpulse, Hit, GetInstigator()->Controller, this, DamageType);         }          Destroy();     } 
   ```

   这是在投射物撞击对象时要调用的函数。若撞击对象是有效Actor，将调用 `ApplyPointDamage` 函数，在碰撞处对该对象造成伤害。同时，无论撞击表面是什么，任何碰撞都将摧毁该Actor，导致爆炸效果显示。
5. 在 `ThirdPersonMPProjectile.cpp` 中，将以下代码添加到 `AThirdPersonMPProjectile` `AThirdPersonMPProjectile`中的 `RootComponent = SphereComponent` 一行下：

   ThirdPersonMPProjectile.cpp

   ```
        //在击中事件上注册此投射物撞击函数。     if (GetLocalRole() == ROLE_Authority)     {         SphereComponent->OnComponentHit.AddDynamic(this, &AThirdPersonMPProjectile::OnProjectileImpact);     } 
   ```

   这将在球体组件上向 `OnComponentHit` 事件注册 `OnProjectileImpact`，该球体组件作为投射物的主碰撞组件。为了专门确保仅有服务器运行此游戏进程逻辑，注册 `OnProjectileImpact` 之前检查确认 `GetLocalRole() == ROLE_Authority`。

## 6.发射投射物

1. 打开 **虚幻编辑器（Unreal Editor）**，然后单击屏幕顶部的 **编辑（Edit）** 下拉菜单，并打开 **项目设置（Project Settings）**。

   ![Project Settings](../../../../../assets/images/f5/f5edfb09dbc21bc7587d0aed3acf5437d6f2965aa4a28207929c416238385d1e.jpg)
2. 在 **引擎（Engine）** 部分中，单击 **输入（Input）** 打开项目的输入设置。展开 **绑定（Bindings）** 部分，添加新条目。将它命名为"**Fire**"，并选择 **鼠标左键** 作为此Actor的绑定键。

   ![undefined](../../../../../assets/images/f8/f88c9bc198dc971d0872eaa0082cd27e28196185424c174a4c3be3d3d0f8fa3e.jpg)

   点击查看大图。
3. 在 `ThirdPersonMPCharacter.cpp` 中，在 `#include "Engine/Engine.h"` 一行下方添加以下 `#include`：

   ThirdPersonMPCharacter.cpp

   ```
        #include "ThirdPersonMPProjectile.h" 
   ```

   这使角色类能够识别投射物类型并生成投射物。
4. 在 `ThirdPersonMPCharacter.h` 中，在 `Protected` 下添加以下代码：

   ThirdPersonMPCharacter.h

   ```
        protected:     UPROPERTY(EditDefaultsOnly, Category="Gameplay|Projectile")     TSubclassOf<class AThirdPersonMPProjectile> ProjectileClass;      /** 射击之间的延迟，单位为秒。用于控制测试发射物的射击速度，还可防止服务器函数的溢出导致将SpawnProjectile直接绑定至输入。*/     UPROPERTY(EditDefaultsOnly, Category="Gameplay")     float FireRate;      /** 若为true，则正在发射投射物。*/     bool bIsFiringWeapon;      /** 用于启动武器射击的函数。*/     UFUNCTION(BlueprintCallable, Category="Gameplay")     void StartFire();      /** 用于结束武器射击的函数。一旦调用这段代码，玩家可再次使用StartFire。*/     UFUNCTION(BlueprintCallable, Category = "Gameplay")     void StopFire();      /** 用于生成投射物的服务器函数。*/     UFUNCTION(Server, Reliable)     void HandleFire();      /** 定时器句柄，用于提供生成间隔时间内的射速延迟。*/     FTimerHandle FiringTimer; 
   ```

   这些是将用于发射投射物的变量和函数。`HandleFire` 是将在本教程中实现的唯一RPC，它将负责在服务器上生成投射物。因为它拥有 `Server` 说明符，如若尝试在客户端上调用它，都会导致该调用通过网络直接被定向到服务器上的权威角色。

   因为 `HandleFire` 也拥有 `Reliable` 说明符，因此一旦调用，它就会被放置到可靠RPC的队列中，并在服务器成功收到之后从队列中移除。这保证服务器一定会收到此函数调用。但若可靠RPC的队列中一次性放入太多RPC却不移除它们，则该队列可能会溢出，如果是这种情况，用户将被强制断开连接。因此，你需要注意允许玩家调用此函数的频率。

   1. 在

      ThirdPersonMPCharacter.cpp

      中，在

      AThirdPersonMPCharacter

      构造函数底部添加以下代码：

   ThirdPersonMPCharacter.cpp

   ```
        //初始化投射物类     ProjectileClass = AThirdPersonMPProjectile::StaticClass();     //初始化射速     FireRate = 0.25f;     bIsFiringWeapon = false; 
   ```

   这些代码将初始化处理投射物发射所需的变量。

   1. 在

      ThirdPersonMPCharacter.cpp

      中，添加以下实现：

   ThirdPersonMPCharacter.cpp

   ```
        void AThirdPersonMPCharacter::StartFire()     {         if (!bIsFiringWeapon)         {             bIsFiringWeapon = true;             UWorld* World = GetWorld();             World->GetTimerManager().SetTimer(FiringTimer, this, &AThirdPersonMPCharacter::StopFire, FireRate, false);             HandleFire();         }     }      void AThirdPersonMPCharacter::StopFire()     {         bIsFiringWeapon = false;     }      void AThirdPersonMPCharacter::HandleFire_Implementation()     {         FVector spawnLocation = GetActorLocation() + ( GetActorRotation().Vector()  * 100.0f ) + (GetActorUpVector() * 50.0f);         FRotator spawnRotation = GetActorRotation();          FActorSpawnParameters spawnParameters;         spawnParameters.Instigator = GetInstigator();         spawnParameters.Owner = this;          AThirdPersonMPProjectile* spawnedProjectile = GetWorld()->SpawnActor<AThirdPersonMPProjectile>(spawnLocation, spawnRotation, spawnParameters);     } 
   ```

   `StartFire` 是玩家在本地机器上调用的函数，用于初始化发射流程，它基于以下条件限制用户调用 `HandleFire` 的频率：

   - 若用户正在发射投射物，则不可发射。这是用

     bFiringWeapon

     指派的，在调用

     StartFire

     时，

     bFiringWeapon

     设为

     true

     。
   - 调用

     StopFire

     时，

     bFiringWeapon

     仅可设为

     false

     。
   - 时长为

     FireRate

     的定时器结束时，会调用

     StopFire

     。

   这意味着用户发射投射物时，必须等待数秒（等于 `FireRate`），之后方可继续发射。无论 `StartFire` 绑定到何种输入，这种情况始终一致。例如，若用户将"Fire"命令绑定到滚轮或类似的不当输入，或用户反复狂按按钮，此函数仍会按可接受的时间间隔执行，不会使 `HandleFire` 调用导致用户的可靠函数队列溢出。

   因为 `HandleFire` 是服务器RPC，其在CPP文件中的实现必须在函数名前面添加前缀 `_Implementation`。本指南中的实施使用角色的控制旋转获取摄像机的朝向，然后生成面朝该方向的投射物，以便玩家瞄准。接下来，投射物的投射物移动组件使其朝该方向移动。
5. 在 `ThirdPersonMPCharacter.cpp` 中，在函数 `SetupPlayerInputComponent` 底部添加以下代码：

   ThirdPersonMPCharacter.cpp

   ```
        // 处理发射投射物     PlayerInputComponent->BindAction("Fire", IE_Pressed, this, &AThirdPersonMPCharacter::StartFire); 
   ```

   这段代码将 `StartFire` 绑定到本节第一个步骤中创建的 **Fire** 输入操作，以便用户将其激活。

## 7.测试游戏

1. 在编辑器中打开项目。单击 **编辑（Edit）** 下拉菜单，并打开 **编辑器首选项（Editor Preferences）**。

   ![Open Level Editor/Play](../../../../../assets/images/5b/5bbbab17db7b0b53ae68f09411f8a60291e17048ff7c880bc94193a9ef391f8a.jpg)
2. 找到 **关卡编辑器（Level Editor）** 分段，并单击 **运行（Play）** 菜单。找到 **多人游戏选项（Multiplayer Options）**，并将 **运行网络模式（Play Net Mode）** 改成 **作为监听服务器运行（Play As Listen Server）**。同时，将 **客户端运行数量（Play Number Of Clients）** 改为2。

   ![undefined](../../../../../assets/images/46/462f00ca810dab910f5f8a2790b9c1a90f98a2246db0931e12ae10026fccede2.jpg)

   点击查看大图。
3. 按 **运行（Play）** 按钮。**在编辑器中运行（Play in Editor）(PIE)** 主窗口将作为服务器启动多人游戏会话，之后第二个PIE窗口打开，作为客户端连接。

## 最终结果

> 图片已省略：undefined

点击查看大图。

游戏中的两位玩家都应能够看到对方移动，并可向对方发射自定义投射物。若其中一位玩家被自定义投射物击中，应向两位玩家同时显示爆炸粒子，且被击中的玩家将收到一条"命中"消息，告知伤害量和当前生命值，而会话中的所有其他玩家不会看到任何消息。若玩家生命值降至0，会看到一条消息，通知已被杀死。

本演练到此完成，你应已掌握在C++环境下构建多人游戏功能的一些基础知识，包括变量和组件复制的概述、网络角色的使用方式，以及使用RPC的适当时机。了解这些信息后，应可在虚幻的服务器-客户端模型中构建自己的多人游戏 。

## 看你的了

要继续扩展网络多人游戏编程方面的技能，尝试完成以下项目：

- 展开投射物的OnHit功能，以在投射物击中目标时创建额外的效果，例如创建球形轨迹以模拟爆炸半径。
- 扩展ThirdPersonMPProjectile并对其ProjectileMovement组件进行试验，以创建采取不同行为的新变体。
- 扩展ThirdPersonMPCharacter中的TakeDamage函数，以杀死玩家的pawn并使它们重新生成。
- 向本地PlayerController添加HUD，使其显示复制的信息或响应客户端函数。
- 使用DamageType在玩家被杀死时创建个性化消息。
- 探索游戏模式、玩家状态和游戏状态的用途，以创建一套完整的规则来利用玩家统计数据和记分板主持比赛。

## 代码示例

ThirdPersonMPProjectile.h

```
	// 版权所有 1998-2022 Epic Games, Inc。保留所有权利。 	#pragma once 	#include "CoreMinimal.h"	#include "GameFramework/Actor.h"	#include "ThirdPersonMPProjectile.generated.h" 	UCLASS()	class THIRDPERSONMP_API AThirdPersonMPProjectile : public AActor	{		GENERATED_BODY() 	public:		// 为此Actor的属性设置默认值		AThirdPersonMPProjectile(); 	protected:		// 当游戏开始或生成时调用		virtual void BeginPlay() override; 	public:		// 每一帧调用		virtual void Tick(float DeltaTime) override; 	public:		// 用于测试碰撞的球体组件。		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Components")		class USphereComponent* SphereComponent; 		// Static Mesh used to provide a visual representation of the object.		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Components")		class UStaticMeshComponent* StaticMesh; 		// Movement component for handling projectile movement.		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Components")		class UProjectileMovementComponent* ProjectileMovementComponent; 		// Particle used when the projectile impacts against another object and explodes.		UPROPERTY(EditAnywhere, Category = "Effects")		class UParticleSystem* ExplosionEffect; 		//此投射物将造成的伤害类型和伤害值。		UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Damage")		TSubclassOf<class UDamageType> DamageType; 		//The damage dealt by this projectile.		UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Damage")		float Damage; 	protected: 		virtual void Destroyed() override; 		UFUNCTION(Category = "Projectile")		void OnProjectileImpact(UPrimitiveComponent* HitComponent, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit); 	}; 
```

ThirdPersonMPProjectile.cpp

```
	// 版权所有 1998-2022 Epic Games, Inc。保留所有权利。 	#include "ThirdPersonMPProjectile.h"	#include "Components/SphereComponent.h"	#include "Components/StaticMeshComponent.h"	#include "GameFramework/ProjectileMovementComponent.h"	#include "GameFramework/DamageType.h"	#include "Particles/ParticleSystem.h"	#include "Kismet/GameplayStatics.h"	#include "UObject/ConstructorHelpers.h" 	// 设置默认值	AThirdPersonMPProjectile::AThirdPersonMPProjectile()	{		// 将此Actor设置为每一帧调用Tick()。如果不需要，可以关闭此选项来提高性能。		PrimaryActorTick.bCanEverTick = true; 		bReplicates = true; 		//定义将作为投射物及其碰撞的根组件的SphereComponent。		SphereComponent = CreateDefaultSubobject<USphereComponent>(TEXT("RootComponent"));		SphereComponent->InitSphereRadius(37.5f);		SphereComponent->SetCollisionProfileName(TEXT("BlockAllDynamic"));		RootComponent = SphereComponent; 		//在击中事件上注册此投射物撞击函数。		if (GetLocalRole() == ROLE_Authority)		{			SphereComponent->OnComponentHit.AddDynamic(this, &AThirdPersonMPProjectile::OnProjectileImpact);		} 		//定义将作为视觉呈现的网格体。		static ConstructorHelpers::FObjectFinder<UStaticMesh> DefaultMesh(TEXT("/Game/StarterContent/Shapes/Shape_Sphere.Shape_Sphere"));		StaticMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));		StaticMesh->SetupAttachment(RootComponent); 		//如果成功找到要用的网格体资产，则设置静态网格体及其位置/比例。		if (DefaultMesh.Succeeded())		{			StaticMesh->SetStaticMesh(DefaultMesh.Object);			StaticMesh->SetRelativeLocation(FVector(0.0f, 0.0f, -37.5f));			StaticMesh->SetRelativeScale3D(FVector(0.75f, 0.75f, 0.75f));		} 		static ConstructorHelpers::FObjectFinder<UParticleSystem> DefaultExplosionEffect(TEXT("/Game/StarterContent/Particles/P_Explosion.P_Explosion"));		if (DefaultExplosionEffect.Succeeded())		{			ExplosionEffect = DefaultExplosionEffect.Object;		} 		//Definition for the Projectile Movement Component.		ProjectileMovementComponent = CreateDefaultSubobject<UProjectileMovementComponent>(TEXT("ProjectileMovement"));		ProjectileMovementComponent->SetUpdatedComponent(SphereComponent);		ProjectileMovementComponent->InitialSpeed = 1500.0f;		ProjectileMovementComponent->MaxSpeed = 1500.0f;		ProjectileMovementComponent->bRotationFollowsVelocity = true;		ProjectileMovementComponent->ProjectileGravityScale = 0.0f; 		DamageType = UDamageType::StaticClass();		Damage = 10.0f;	} 	// 当游戏开始或生成时调用	void AThirdPersonMPProjectile::BeginPlay()	{		Super::BeginPlay();	} 	// 每一帧调用	void AThirdPersonMPProjectile::Tick(float DeltaTime)		{		Super::Tick(DeltaTime);	} 	void AThirdPersonMPProjectile::Destroyed()	{		FVector spawnLocation = GetActorLocation();		UGameplayStatics::SpawnEmitterAtLocation(this, ExplosionEffect, spawnLocation, FRotator::ZeroRotator, true, EPSCPoolMethod::AutoRelease);	} 	void AThirdPersonMPProjectile::OnProjectileImpact(UPrimitiveComponent* HitComponent, AActor* OtherActor, UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit)	{		if (OtherActor)		{			UGameplayStatics::ApplyPointDamage(OtherActor, Damage, NormalImpulse, Hit, GetInstigator()->Controller, this, DamageType);		}		Destroy();	} 
```

ThirdPersonMPCharacter.h

```
	// 版权所有 1998-2022 Epic Games, Inc。保留所有权利。 	#pragma once 	#include "CoreMinimal.h"	#include "GameFramework/Character.h"	#include "ThirdPersonMPCharacter.generated.h" 	UCLASS(config=Game)	class AThirdPersonMPCharacter : public ACharacter	{		GENERATED_BODY() 		/** 摄像机吊杆将摄像机置于角色身后 */		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = Camera, meta = (AllowPrivateAccess = "true"))		class USpringArmComponent* CameraBoom; 		/** 跟随摄像机 */		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = Camera, meta = (AllowPrivateAccess = "true"))		class UCameraComponent* FollowCamera; 	public: 		AThirdPersonMPCharacter(); 		/** 属性复制 */		void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override; 		/** 基础旋转速度，单位为度/秒。其他缩放比例可能会影响最终旋转速度。*/		UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category=Input)		float TurnRateGamepad; 	protected: 		/** 向前/向后输入时调用 */		void MoveForward(float Value); 		/** 侧向输入时调用 */		void MoveRight(float Value); 		/**		* 通过输入调用，以给定速度旋转。		* @param Rate	This is a normalized rate, i.e. 1.0 means 100% of desired turn rate		*/		void TurnAtRate(float Rate); 		/**		* 通过输入调佣，以给定速度向上/下看。		* @param Rate	This is a normalized rate, i.e. 1.0 means 100% of desired turn rate		*/		void LookUpAtRate(float Rate); 		/** 触控输入开始时使用的处理程序。 */		void TouchStarted(ETouchIndex::Type FingerIndex, FVector Location); 		/** 触控输入停止时使用的处理程序。 */		void TouchStopped(ETouchIndex::Type FingerIndex, FVector Location); 		// APawn接口		virtual void SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent) override;		// APawn接口结束 	public: 		/** 返回CameraBoom子对象 **/		FORCEINLINE class USpringArmComponent* GetCameraBoom() const { return CameraBoom; } 		/** Returns FollowCamera subobject **/		FORCEINLINE class UCameraComponent* GetFollowCamera() const { return FollowCamera; } 	protected: 		/** 玩家的最大生命值。这是玩家的最高生命值，也是出生时的生命值。*/		UPROPERTY(EditDefaultsOnly, Category = "Health")		float MaxHealth; 		/** 玩家的当前生命值。降到0就表示死亡。*/		UPROPERTY(ReplicatedUsing=OnRep_CurrentHealth)		float CurrentHealth; 		/** RepNotify，用于同步对当前生命值所做的更改。*/		UFUNCTION()		void OnRep_CurrentHealth(); 		/** 响应要更新的生命值。修改后，立即在服务器上调用，并在客户端上调用以响应RepNotify*/		void OnHealthUpdate(); 	public: 		/** 最大生命值的取值函数。*/		UFUNCTION(BlueprintPure, Category = "Health")		FORCEINLINE float GetMaxHealth() const { return MaxHealth; } 		/** 当前生命值的取值函数。*/		UFUNCTION(BlueprintPure, Category = "Health")		FORCEINLINE float GetCurrentHealth() const { return CurrentHealth; } 		/** 当前生命值的存值函数。将此值的范围限定在0到MaxHealth之间，并调用OnHealthUpdate。仅在服务器上调用。*/		UFUNCTION(BlueprintCallable, Category = "Health")		void SetCurrentHealth(float healthValue); 		/** 承受伤害的事件。从APawn重载。*/		UFUNCTION(BlueprintCallable, Category = "Health")		float TakeDamage(float DamageTaken, struct FDamageEvent const& DamageEvent, AController* EventInstigator, AActor* DamageCauser) override; 	protected: 		UPROPERTY(EditDefaultsOnly, Category = "Gameplay|Projectile")		TSubclassOf<class AThirdPersonMPProjectile> ProjectileClass; 		/** 射击之间的延迟，单位为秒。用于控制测试发射物的射击速度，还可防止服务器函数的溢出导致将SpawnProjectile直接绑定至输入。*/		UPROPERTY(EditDefaultsOnly, Category = "Gameplay")		float FireRate; 		/** 若为true，此武器正在发射过程中。*/		bool bIsFiringWeapon; 		/** 用于启动武器发射的函数。应仅可由本地玩家触发。*/		UFUNCTION(BlueprintCallable, Category = "Gameplay")		void StartFire(); 		/** 用于结束武器射击的函数。一旦调用这段代码，玩家可再次使用StartFire。*/		UFUNCTION(BlueprintCallable, Category = "Gameplay")		void StopFire(); 		/** 用于生成投射物的服务器函数。*/		UFUNCTION(Server, Reliable)		void HandleFire(); 		/** 定时器句柄，用于提供生成间隔时间内的射速延迟。*/		FTimerHandle FiringTimer;	}; 
```

ThirdPersonMPCharacter.cpp

```
	// 版权所有 1998-2022 Epic Games, Inc。保留所有权利。 	#include "ThirdPersonMPCharacter.h"	#include "Camera/CameraComponent.h"	#include "Components/CapsuleComponent.h"	#include "Components/InputComponent.h"	#include "GameFramework/CharacterMovementComponent.h"	#include "GameFramework/Controller.h"	#include "GameFramework/SpringArmComponent.h"	#include "Net/UnrealNetwork.h"	#include "Engine/Engine.h"	#include "ThirdPersonMPProjectile.h" 	//////////////////////////////////////////////////////////////////////////	// AThirdPersonMPCharacter 	AThirdPersonMPCharacter::AThirdPersonMPCharacter()	{		// 设置碰撞胶囊体的大小		GetCapsuleComponent()->InitCapsuleSize(42.f, 96.0f); 		// 设置输入的旋转速度		TurnRateGamepad = 50.f; 		// 控制器旋转时不旋转。只影响摄像机。		bUseControllerRotationPitch = false;		bUseControllerRotationYaw = false;		bUseControllerRotationRoll = false; 		// 配置角色移动		GetCharacterMovement()->bOrientRotationToMovement = true; // Character moves in the direction of input...		GetCharacterMovement()->RotationRate = FRotator(0.0f, 500.0f, 0.0f); // ...at this rotation rate 		// 注意：为了提高迭代速度，可在角色蓝图中微调这些及其他许多变量，		// 而不是通过重新编译来调整它们		GetCharacterMovement()->JumpZVelocity = 700.f;		GetCharacterMovement()->AirControl = 0.35f;		GetCharacterMovement()->MaxWalkSpeed = 500.f;		GetCharacterMovement()->MinAnalogWalkSpeed = 20.f;		GetCharacterMovement()->BrakingDecelerationWalking = 2000.f; 		// Create a camera boom (pulls in towards the player if there is a collision)		CameraBoom = CreateDefaultSubobject<USpringArmComponent>(TEXT("CameraBoom"));		CameraBoom->SetupAttachment(RootComponent);		CameraBoom->TargetArmLength = 400.0f; // 摄像机以这个距离跟在角色身后		CameraBoom->bUsePawnControlRotation = true; // 基于控制器旋转吊臂 		// 创建跟随摄像头		FollowCamera = CreateDefaultSubobject<UCameraComponent>(TEXT("FollowCamera"));		FollowCamera->SetupAttachment(CameraBoom, USpringArmComponent::SocketName); // 将摄像机连接到吊杆末端，调节吊杆以匹配控制器方向		FollowCamera->bUsePawnControlRotation = false; // 摄像机不相对于吊臂旋转 		// 注意：骨架网格体和网格体组件上的动画蓝图引用（继承自角色）		// 都在名为MyCharacter的派生蓝图资产中设置（以避免C++环境下的直接内容引用） 		//初始化玩家生命值		MaxHealth = 100.0f;		CurrentHealth = MaxHealth; 		//初始化投射物类		ProjectileClass = AThirdPersonMPProjectile::StaticClass();		//初始化射速		FireRate = 0.25f;		bIsFiringWeapon = false;	} 	//////////////////////////////////////////////////////////////////////////	// 输入 	void AThirdPersonMPCharacter::SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent)	{		// 设置游戏进程键绑定		check(PlayerInputComponent);		PlayerInputComponent->BindAction("Jump", IE_Pressed, this, &ACharacter::Jump);		PlayerInputComponent->BindAction("Jump", IE_Released, this, &ACharacter::StopJumping); 		PlayerInputComponent->BindAxis("Move Forward / Backward", this, &AThirdPersonMPCharacter::MoveForward);		PlayerInputComponent->BindAxis("Move Right / Left", this, &AThirdPersonMPCharacter::MoveRight); 		// 我们有两个旋转绑定版本，可以用不同的方式处理不同类型的设备		// "turn"处理提供绝对增量的设备。		// "turnrate"用于选择视为变化速度的设备，例如模拟操纵杆		PlayerInputComponent->BindAxis("Turn Right / Left Mouse", this, &APawn::AddControllerYawInput);		PlayerInputComponent->BindAxis("Turn Right / Left Gamepad", this, &AThirdPersonMPCharacter::TurnAtRate);		PlayerInputComponent->BindAxis("Look Up / Down Mouse", this, &APawn::AddControllerPitchInput);		PlayerInputComponent->BindAxis("Look Up / Down Gamepad", this, &AThirdPersonMPCharacter::LookUpAtRate); 		// 处理触控设备		PlayerInputComponent->BindTouch(IE_Pressed, this, &AThirdPersonMPCharacter::TouchStarted);		PlayerInputComponent->BindTouch(IE_Released, this, &AThirdPersonMPCharacter::TouchStopped); 		// 处理发射投射物		PlayerInputComponent->BindAction("Fire", IE_Pressed, this, &AThirdPersonMPCharacter::StartFire);	} 	void AThirdPersonMPCharacter::TouchStarted(ETouchIndex::Type FingerIndex, FVector Location)	{		Jump();	} 	void AThirdPersonMPCharacter::TouchStopped(ETouchIndex::Type FingerIndex, FVector Location)	{		StopJumping();	} 	void AThirdPersonMPCharacter::TurnAtRate(float Rate)	{		// 根据速度信息计算此帧的增量		AddControllerYawInput(Rate * TurnRateGamepad * GetWorld()->GetDeltaSeconds());	} 	void AThirdPersonMPCharacter::LookUpAtRate(float Rate)	{		// 根据速度信息计算此帧的增量		AddControllerPitchInput(Rate * TurnRateGamepad * GetWorld()->GetDeltaSeconds());	} 	void AThirdPersonMPCharacter::MoveForward(float Value)		{		if ((Controller != nullptr) && (Value != 0.0f))		{			// 找出向前的道路			const FRotator Rotation = Controller->GetControlRotation();			const FRotator YawRotation(0, Rotation.Yaw, 0); 			// 获取向前矢量			const FVector Direction = FRotationMatrix(YawRotation).GetUnitAxis(EAxis::X);			AddMovementInput(Direction, Value);		}	} 	void AThirdPersonMPCharacter::MoveRight(float Value)	{		if ( (Controller != nullptr) && (Value != 0.0f) )		{			// 找出正确的道路			const FRotator Rotation = Controller->GetControlRotation();			const FRotator YawRotation(0, Rotation.Yaw, 0); 			// 获取正确的矢量			const FVector Direction = FRotationMatrix(YawRotation).GetUnitAxis(EAxis::Y);			// add movement in that direction			AddMovementInput(Direction, Value);		}	} 	//////////////////////////////////////////////////////////////////////////	// 复制的属性 	void AThirdPersonMPCharacter::GetLifetimeReplicatedProps(TArray <FLifetimeProperty>& OutLifetimeProps) const	{		Super::GetLifetimeReplicatedProps(OutLifetimeProps); 		//Replicate current health.		DOREPLIFETIME(AThirdPersonMPCharacter, CurrentHealth);	} 	void AThirdPersonMPCharacter::OnHealthUpdate()	{		//客户端特定的功能		if (IsLocallyControlled())		{			FString healthMessage = FString::Printf(TEXT("You now have %f health remaining."), CurrentHealth);			GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Blue, healthMessage); 			if (CurrentHealth <= 0)			{				FString deathMessage = FString::Printf(TEXT("You have been killed."));				GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Red, deathMessage);			}		} 		//服务器特定的功能		if (GetLocalRole() == ROLE_Authority)		{			FString healthMessage = FString::Printf(TEXT("%s now has %f health remaining."), *GetFName().ToString(), CurrentHealth);			GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Blue, healthMessage);		} 		//在所有机器上都执行的函数。		/*			因任何因伤害或死亡而产生的特殊功能都应放在这里。		*/	} 	void AThirdPersonMPCharacter::OnRep_CurrentHealth()	{		OnHealthUpdate();	} 	void AThirdPersonMPCharacter::SetCurrentHealth(float healthValue)	{		if (GetLocalRole() == ROLE_Authority)		{			CurrentHealth = FMath::Clamp(healthValue, 0.f, MaxHealth);			OnHealthUpdate();		}	} 	float AThirdPersonMPCharacter::TakeDamage(float DamageTaken, struct FDamageEvent const& DamageEvent, AController* EventInstigator, AActor* DamageCauser)	{		float damageApplied = CurrentHealth - DamageTaken;		SetCurrentHealth(damageApplied);		return damageApplied;	} 	void AThirdPersonMPCharacter::StartFire()	{		if (!bIsFiringWeapon)	{			bIsFiringWeapon = true;			UWorld* World = GetWorld();			World->GetTimerManager().SetTimer(FiringTimer, this, &AThirdPersonMPCharacter::StopFire, FireRate, false);			HandleFire();	}	} 	void AThirdPersonMPCharacter::StopFire()	{		bIsFiringWeapon = false;	} 	void AThirdPersonMPCharacter::HandleFire_Implementation()		{		FVector spawnLocation = GetActorLocation() + (GetActorRotation().Vector() * 100.0f) + (GetActorUpVector() * 50.0f);		FRotator spawnRotation = GetActorRotation(); 		FActorSpawnParameters spawnParameters;		spawnParameters.Instigator = GetInstigator();		spawnParameters.Owner = this; 		AThirdPersonMPProjectile* spawnedProjectile = GetWorld()->SpawnActor<AThirdPersonMPProjectile>(spawnLocation, spawnRotation, spawnParameters);	}
```

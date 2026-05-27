---
title: "仅使用C++的示例"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cpp-only-example"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "类创建基础知识", "仅使用C++的示例"]
---

# 仅使用C++的示例

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 类创建基础知识 / 仅使用C++的示例

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cpp-only-example

通过使用[C++类向导](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md)，你可以轻松地向你的项目中添加新的C++类。你选择完想让新类继承的父类后，该向导将创建必要的头文件和源文件。 如果这是你添加到你的项目中的第一段代码，那么该项目会被转换成代码项目，将创建包含你的源码的游戏模块。该向导还会让虚幻编辑器知道存在该游戏模块，以便它可以从Visual Studio 或 Xcode中加载你的C++代码改变，任何微小的改变都可以在虚幻编辑器中进行编译。

仅使用C++代码创建的LightSwitch类的名称是LightSwitchCodeOnly，以下进行了解释。

## 类设置

使用 [C++类向导](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md) 创建 **LightSwitchCodeOnly** 类，且选择 **Actor** 作为父类。

头文件 `LightSwitchCodeOnly.h` 中包含了该类的声明。

```
	UCLASS()	class [PROJECTNAME]_API ALightSwitchCodeOnly : public AActor	{	GENERATED_BODY() 	};
```

使用 **C++ 类向导** 创建的类声明自动通过 `UCLASS()` 宏进行处理。`UCLASS()` 宏使得引擎意识到这个类的存在，并且还可以同键盘修饰符结合使用来在引擎中设置该类的行为。

类声明包含很多变量 和/或 函数声明。 这些可以通过 `UPROPERTY()` 和 `UFUNCTION()` 宏分别进行处理，这些宏的功能和`UCLASS()` 宏类似。组件也和`UPROPERTY()`宏一起设置。

在 `LightSwitchCodeOnly.h` 中， C++用于：

- 声明PointLightComponent 和 SphereComponent。 PointLightComponent和SphereComponent二者都设置为 `VisibleAnywhere（随处可见）`。这意味着可以在LightSwitchCodeOnly Actor的 **Details（详细信息）** 选卡中看到它们的属性。

  ```
        public:      /** 点光源组件 */      UPROPERTY(VisibleAnywhere, Category = "Switch Components")      class UPointLightComponent* PointLight1;		      /** 球体组件 */      UPROPERTY(VisibleAnywhere, Category = "Switch Components")      class USphereComponent* Sphere1;
  ```
- 声明构造函数，这样你可以为组件和变量设置默认值：

  ```
        ALightSwitchCodeOnly();
  ```
- 声明 `OnOverlapBegin` 和`OnOverlapEnd`函数, 当另一个Actor进入或离开SphereComponent时将调用该函数。 请注意会有不同的签名。

  ```
        /** 当某对象进入球体组件时调用 */      UFUNCTION()      void OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);		      /** 当某对象离开球体组件时调用 */      UFUNCTION()      void OnOverlapEnd(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex);
  ```
- 声明`ToggleLight`，这是一个切换PointLightComponent的可见性的函数。

  ```
        /** 切换光照组件的可见性*/      UFUNCTION()      void ToggleLight();
  ```
- 声明 `DesiredIntensity` 变量，并使用 `VisibleAnywhere` 修饰符设置该属性为在任何地方都可见。 此属性将显示在 LightSwitchCodeOnly Actor的 **Details（详细信息）** 选卡中的 **Switch Variables（切换变量）** 类目中。对于不是子对象的变量，比如这个浮点值， `VisibleAnywhere` 修饰符将使得该变量显示在 **详细信息** 选卡中。你还可以使用 `EditAnywhere`修饰符，但是由于 `DesiredBrightness` 变量仅在把Actor添加到关卡中时使用，所以不需要设置成为可编辑的。

  ```
        /** 该光照的所需强度 */      UPROPERTY(VisibleAnywhere, Category="Switch Variables")      float DesiredIntensity;
  ```

最终的头文件如下所示：

LightSwitchCodeOnly.h

```
		// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 		#pragma once 		#include "GameFramework/Actor.h"		#include "Components/PointLightComponent.h"		#include "Components/SphereComponent.h"		#include "LightSwitchCodeOnly.generated.h" 		/**		 *		 */		UCLASS()		class [PROJECTNAME]_API ALightSwitchCodeOnly : public AActor		{			GENERATED_BODY()			public:			/** 点光源组件 */			UPROPERTY(VisibleAnywhere, Category = "Switch Components")			class UPointLightComponent* PointLight1; 			/** 球体组件 */			UPROPERTY(VisibleAnywhere, Category = "Switch Components")			class USphereComponent* Sphere1; 			ALightSwitchCodeOnly(); 			/** 当某对象进入球体组件时调用 */			UFUNCTION()			void OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult); 			/** 当某对象离开球体组件时调用 */			UFUNCTION()			void OnOverlapEnd(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex); 			/** 切换光照组件的可见性*/			UFUNCTION()			void ToggleLight(); 			/** 该光照的所需强度 */			UPROPERTY(VisibleAnywhere, Category = "Switch Variables")			float DesiredIntensity; 		};
```

**C++ 类向导** 还会创建类的源文件，在这个示例中，就是 `LightSwitchCodeOnly.cpp` 文件。 默认情况下，源文件具有基本的包含文件设置。

你在一开始可以添加类构造函数。

```
		ALightSwitchCodeOnly::ALightSwitchCodeOnly()		{ 		} 
```

在 `LightSwitchCodeOnly` 构造器中, C++代码用于:

- 设置`DesiredIntensity`变量的值为3000。

  ```
        DesiredIntensity = 3000.0f;
  ```
- 创建PointLightComponent，设置其变量 (包括设置其强度为 `DesiredIntensity` 的值), 并使它成为根组件。

  ```
        PointLight1 = CreateDefaultSubobject<UPointLightComponent>(TEXT("PointLight1"));      PointLight1->Intensity = DesiredIntensity;      PointLight1->SetVisibility(true);      RootComponent = PointLight1;
  ```
- 创建SphereComponent、设置其变量，并将其附加到PointLightComponent上。

  ```
        Sphere1 = CreateDefaultSubobject<USphereComponent>(TEXT("Sphere1"));      Sphere1->InitSphereRadius(250.0f);      Sphere1->SetupAttachment(RootComponent);
  ```
- 当一个Actor和SphereComponent相重叠或者离开SphereComponent时，指定`OnOverlap`函数作为代理进行调用。

  ```
        Sphere1->OnComponentBeginOverlap.AddDynamic(this, &ALightSwitchCodeOnly::OnOverlapBegin);		// 当此组件与某对象重叠时，设置通知      Sphere1->OnComponentEndOverlap.AddDynamic(this, &ALightSwitchCodeOnly::OnOverlapEnd);		// 当此组件与某对象重叠时，设置通知
  ```

源文件中也可以定义你的类声明中的函数。 比如， `LightSwitchCodeOnly.cpp` 中有 `OnOverlapBegin` 和 `OnOverlapEnd`函数的实现，该函数通过调用ToggleLight`来切换PointLightComponent的可见性。这些定义和类构造器组合到一起，最终源码文件如下所示：

LightSwitchCodeOnly.cpp

```
	// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#include "BasicClasses.h"	#include "LightSwitchCodeOnly.h" 	ALightSwitchCodeOnly::ALightSwitchCodeOnly()	{		DesiredIntensity = 3000.0f; 		PointLight1 = CreateDefaultSubobject<UPointLightComponent>(TEXT("PointLight1"));		PointLight1->Intensity = DesiredIntensity;		PointLight1->SetVisibility(true);		RootComponent = PointLight1; 		Sphere1 = CreateDefaultSubobject<USphereComponent>(TEXT("Sphere1"));		Sphere1->InitSphereRadius(250.0f);		Sphere1->SetupAttachment(RootComponent); 		Sphere1->OnComponentBeginOverlap.AddDynamic(this, &ALightSwitchCodeOnly::OnOverlapBegin);		// 当此组件与某对象重叠时，设置通知		Sphere1->OnComponentEndOverlap.AddDynamic(this, &ALightSwitchCodeOnly::OnOverlapEnd);		// 当此组件与某对象重叠时，设置通知 	} 	void ALightSwitchCodeOnly::OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult)	{		if (OtherActor && (OtherActor != this) && OtherComp)		{			ToggleLight();		}	} 	void ALightSwitchCodeOnly::OnOverlapEnd(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex)	{		if (OtherActor && (OtherActor != this) && OtherComp)		{			ToggleLight();		}	} 	void ALightSwitchCodeOnly::ToggleLight()	{		PointLight1->ToggleVisibility();	} 
```

> [!NOTE]
> `BasicClasses.h` is referring to the name of the project that the class has been set up in.

如果这是你添加到空白项目的第一个代码类，你需要关闭虚幻编辑器，在Visual Studio或Xcode中编译项目，然后打开虚幻编辑器并重新打开项目，以确保创建了游戏模块并正确载入。同时，需要注意的一点是，要确保 **Build Configuration（版本配置）** 和你打开该项目使用的虚幻编辑器可执行文件的版本一致。请在[编译游戏项目](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/compiling-game-projects-in-unreal-engine-using-cplusplus/index.md)文档中阅读关于编译配置及编译项目的更多信息。

如果你正在添加代码到现存的C++项目，你可以使用Hot Reload（热重载）功能来编译虚幻编辑器中的新代码。

C++类既可以通过C++类进行扩展也可以通过类蓝图进行扩展。在 **C++类向导** 中及在类蓝图创建过程中的 **Pick Parent Class（选择父类）** 窗口的 **Custom Classes（自定义类）** 部分中选中 **Show All Classes（显示所有类）** 复选框，便可以显示这两种扩展选项。

LightSwitchCodeOnly位于 [类查看器](../../../understanding-the-basics/assets-and-content-packs/class-viewer/index.md)中，可以从那里将其拖拽到关卡中。 关于使用 **类查看器** 在关卡放置Actor的更多信息，请参照[放置Actor](../../../understanding-the-basics/actors-and-geometry/placing-actors/index.md) 文档。

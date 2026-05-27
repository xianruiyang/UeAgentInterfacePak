---
title: "实现灯光闪烁"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fading-lights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "时间轴", "实现灯光闪烁"]
---

# 实现灯光闪烁

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 时间轴 / 实现灯光闪烁

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fading-lights-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

本文将介绍如何建立能够在接触时变色并随时间闪烁的光源Actor。

我们将用到[点光源组件](../../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/point-lights/index.md)，该组件包含一个作为重叠触发器的盒体组件，以及一个用于操控点光源Actor的时间轴组件。

## 创建能够熄灭的光源Actor

1. 使用**空白（Blank）**模板新建一个**C++**项目，将项目命名为**FadingLights**。

   点击查看大图。
2. 找到**内容浏览器**，点击**C++ Classes**文件夹，然后点击**添加（+）（Add (+)）**按钮并选择**新建C++类（New C++ Class）**。

   点击查看大图。
3. 选择**Actor**作为**父类**。

   点击查看大图。
4. 将创建的Actor命名为**LightActor**。

   点击查看大图。
5. 创建新Actor时，**Visual Studio**会自动打开`LightActor.h`和`LightActor.cpp`文件。 找到`LightActor.h`文件并声明如下内容：

   LightActor.h

   C++

   ```
   #include "Components/TimelineComponent.h"
   ```
6. 接下来，在`LightActor`的类定义中添加以下代码：

   LightActor.h

   C++

   ```
   public:

                UPROPERTY(EditAnywhere)
                UCurveFloat* PointLightFloatCurve;

                UPROPERTY(EditAnywhere)
                UCurveLinearColor* PointLightColorCurve;

        protected:
   ```
7. 找到`LightActor.cpp`并添加以下类库。

   LightActor.cpp

   C++

   ```
   #include "Components/BoxComponent.h"     #include "Components/PointLightComponent.h"
   ```
8. 在`ALightActor::ALightActor`的构造函数中声明以下内容：

   LightActor.cpp

   C++

   ```
   ALightActor::ALightActor()
        {
            // Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
            PrimaryActorTick.bCanEverTick = true;

            //Create our Default Components
            PointLightComp = CreateDefaultSubobject<UPointLightComponent>(TEXT("PointLightComp"));
            LightTimelineComp = CreateDefaultSubobject<UTimelineComponent>(TEXT("LightTimelineComp"));
            LightOverlapVolume = CreateDefaultSubobject<UBoxComponent>(TEXT("LightOverlapVolume"));
   ```
9. 接下来，实现点光源组件的`UFunction`方法：

   LightActor.cpp

   C++

   ```
   void ALightActor::UpdateLightBrightness(float BrightnessOutput)     {         PointLightComp->SetLightBrightness(BrightnessOutput * 20.0f);     }      void ALightActor::UpdateLightColor(FLinearColor ColorOutput)     {         PointLightComp->SetLightColor(ColorOutput);     }
   ```
10. 然后，在`BeginPlay`方法中添加以下代码：

    LightActor.cpp

    C++

    ```
    void ALightActor::BeginPlay()
         {
             Super::BeginPlay();

             //Binding our float and color track to their respective functions
             UpdateBrightnessTrack.BindDynamic(this, &ALightActor::UpdateLightBrightness);
             UpdateColorTrack.BindDynamic(this, &ALightActor::UpdateLightColor);

             //If we have a float curve, bind it's graph to our update function
             if (PointLightFloatCurve)
    ```
11. 编译你的代码。
12. 在**内容浏览器**中找到**C++Classes文件夹**。
13. 右键点击**LightActor**，选择 **基于LightActor创建蓝图类（Create Blueprint Class based on LightActor）**，并将蓝图Actor命名为**BP_LightActor**。

BP_LightActor的类默认值将按照如下方式显示：

点击查看大图。

## 阶段性代码

LightActor.h

C++

```
//Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#pragma once
	#include "Components/TimelineComponent.h"
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "LightActor.generated.h"

	UCLASS()
	class FADINGLIGHTS_API ALightActor : public AActor
```

LightActor.cpp

C++

```
//Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#include "LightActor.h"
	#include "Components/BoxComponent.h"
	#include "Components/PointLightComponent.h"

	// Sets default values
	ALightActor::ALightActor()
	{
		// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
```

## 创建并绑定碰撞重叠事件

盒体组件需要拥有在Actor进入其碰撞边界时触发**TimelineComponent**的能力。

1. 找到你的`LightActor.h`文件的类定义，并在`BrightnessMultiplier`下声明如下内容：

   LightActor.h

   C++

   ```
   protected:          UFUNCTION()         void OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
   ```
2. 然后，找到`LightActor.cpp`文件并实现`OnOverlapBegin`函数。

   LightActor.cpp

   C++

   ```
   void ALightActor::OnOverlapBegin(class UPrimitiveComponent* OverlappedComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult)     {         LightTimelineComp->Play();     }
   ```
3. 在`BeginPlay`方法中绑定重叠函数：

   LightActor.cpp

   C++

   ```
   //Binding our Box Component to our Light Actor's Overlap Function     LightOverlapVolume->OnComponentBeginOverlap.AddDynamic(this, &ALightActor::OnOverlapBegin);
   ```
4. 编译你的代码。

## 已完成代码

LightActor.h

C++

```
//Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	#pragma once
	#include "Components/TimelineComponent.h"
	#include "CoreMinimal.h"
	#include "GameFramework/Actor.h"
	#include "LightActor.generated.h"

	UCLASS()
	class FADINGLIGHTS_API ALightActor : public AActor
```

LightActor.cpp

C++

```
//Copyright 1998-2022 Epic Games, Inc. All Rights Reserved.

	// Fill out your copyright notice in the Description page of Project Settings.

	#include "LightActor.h"
	#include "Components/BoxComponent.h"
	#include "Components/PointLightComponent.h"

	// Sets default values
	ALightActor::ALightActor()
```

## 设置亮度轨道

当玩家与光源Actor的盒体组件边界重叠时，时间轴组件将需要使用浮点曲线来操控点光源组件的亮度值。

亮度的初始值为**5000**，并将在**5**秒钟内下降到**0**。

1. 找到**内容浏览器**，选择**添加（+）（Add (+)）> 杂项（Miscellaneous）> 曲线（Curve）**。
2. 选择**CurveFloat**并将资产命名为**BrightnessCurveFloat**。
3. 双击**BrightnessCurveFloat**，打开**时间轴编辑器**。
4. 右键点击**图表（Graph）**，然后选择**添加关键点（Add Key）**，为浮点曲线添加两个关键点。 将第一个关键点的时间值调整为**(0, 5000)**。 将第二个关键点的时间值调整为**(5, 0)**。 你的**BrightnessCurveFloat**应如下所示：

   点击查看大图。
5. 保存**BrightnessCurveFloat**，然后回到**内容浏览器**，双击**BP_LightActor**以打开**类默认值（Class Defaults）**。
6. 前往**细节（Details）**面板，在**点光源浮点曲线（Point Light Float Curve）**下拉菜单中，选择**亮度曲线浮点（Brightness Curve Float）**。
7. 点击**编译（Compile）**和**保存（Save）**按钮。

## 设置颜色轨道

当玩家与光源Actor的盒体组件边界重叠时，PointLight时间轴将需要使用线性颜色曲线轨道来操控点光源组件的颜色属性。

1. 找到**内容浏览器**，选择**添加（+）（Add (+)）> 杂项（Miscellaneous）> 曲线（Curve）**。
2. 选择**CurveLinearColor**并将资产命名为**LinearColorCurve**。
3. 双击**LinearColorCurve**以打开**时间轴编辑器**。
4. 双击第一个颜色关键点并修改，将**RGB**值修改为：(**R**：1、**G：**0.665、**B**：0.015)。

   点击查看大图。
5. 双击第二个颜色关键点并修改，将**RGB**值修改为：(**R**：0、**G：**0、**B**：0)。

   点击查看大图。
6. 点击选择**图表**上的第二个**点（Point）**，并将时间设置为**5**秒。

   点击查看大图。
7. 你的**LinearColorCurve**应如下所示：

   点击查看大图。
8. 保存**LinearColorCurve**，然后回到内容浏览器，双击**BP_LightActor**以打开类默认值。
9. 前往**细节（Details）**面板，在**点光源浮点曲线（Point Light Float Curve）**下拉菜单中，选择**亮度曲线浮点（Brightness Curve Float）**。
10. 点击**编译（Compile）**和**保存（Save）**按钮。

## 关卡设置

为了充分展示你编写的代码的功能，需要从关卡中删除所有光源Actor。

1. 在**内容浏览器**中找到**BP_LightActor**资产，将其选中并拖入**关卡**。

   点击查看大图。
2. 在**世界大纲视图**中选择**BP_LightActor**，找到**细节（Details）**面板并将**位置（Location）**设置设为**(0, 0, 300)**，将**缩放（Scale）**设置设为**(10, 10, 10)**。
3. 在**世界大纲视图**中删除**定向光源Actor（DirectionalLight Actor）**。
4. 关卡内容应如下所示。

   点击查看大图。

## 最终结果

现在，光源Actor和关卡已经完成设置，点击**运行(PIE)（Play (PIE)）**即可自动持有旁观者Pawn。

你可以控制旁观者Pawn，可以找到光源Actor的盒体组件边界。

触发时间轴组件的播放功能之后，光源应该开始在5秒的时间跨度内变换颜色和亮度。

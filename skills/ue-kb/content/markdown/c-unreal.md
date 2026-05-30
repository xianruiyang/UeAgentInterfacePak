# [C++] 如何修复 Unreal 中的循环引用

# [C++] 如何修复 Unreal 中的循环引用

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/E9R2/unreal-engine-c-how-to-fix-circular-references-in-unreal

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2738 字符。

## 摘要

轻松修复虚幻中的循环引用

## 中文整理

### 概览

在虚幻 C++ 中，您可能会发现，如果您在创建的标头周围开始#include 太多，您的代码将无法编译。例如，如果您有一个自定义 pawn 和一个自定义 hud 类，并且您想互相引用它们，那么您可能无法做到。有些人建议某些解决方法，例如创建第三个辅助类，但有一种更直接的方法，通过执行两步过程： **第一部分（标题）：前向声明** 解决方案是仅声明 .h 文件顶部未识别的所有类，这称为前向声明

**ACustomHUD 前向声明**

```cpp
#include "ACustomPawn.generated.h"

class ACustomHUD;	// forward declaration

UCLASS() class ACustomPawn : public APawn
{
	GENERATED_BODY()

	ACustomHUD* myHUD;
}
```

**ACustomPawn 前向声明**

```cpp
#include "ACustomHUD.generated.h"

class ACustomPawn;     // forward declaration

UCLASS() class ACustomHUD : public AHUD
{
	GENERATED_BODY()

	ACustomPawn* myPawn; 
}
```

**第二部分（来源）：#include .cpp 文件中的任何内容** 需要注意的是，您可以在任何 .cpp 文件中添加所需的 #include，只有 .h 文件必须在没有循环依赖的情况下进行编译。这些可以添加到您在头文件中转发声明的类的 .cpp 文件中

**源文件**

```cpp
#include "CustomPawn.h"
#include "CustomHUD.h"
```

当您想对 CPP 文件中的各种标头使用 #include 时，您不必担心编译顺序，并且可以只包含您需要的所有类，而无需考虑前向声明问题！ .h 文件只需考虑前向声明 😃 因此，在 .h 文件中添加 Unreal 原生标头，如果您需要在另一个自定义类上引用一个自定义类，则可以在需要时将标头放入 CPP 文件中。 **参考资料** 本教程基于精彩的 wiki 文章 [https://michaeljcole.github.io/wiki.unrealengine.com/Forward_Declarations/](https://michaeljcole.github.io/wiki.unrealengine.com/Forward_Declarations/) **代码示例** 下面是一个虚拟实现，它没有任何目的，只是为了证明这一点。 CustomPawn 从 PlayerController 获取 HUD 类。然后HUD可以显示棋子的名字。重点是，通过遵循此过程，您可以根据需要调用和混合您的类。 CustomPawn.h

```cpp

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Pawn.h"
#include "Kismet/GameplayStatics.h"
#include "CustomPawn.generated.h"

class ACustomHUD;	// forward declaration
```

CustomPawn.cpp

```cpp

#include "CustomPawn.h"
#include "CustomHUD.h"

void ACustomPawn::FindAndSetmyHUD()
{
	// set myHUD
	APlayerController* PlayerController = UGameplayStatics::GetPlayerController(GetWorld(), 0);
	myHUD = Cast<ACustomHUD>(PlayerController->GetHUD());
```

自定义HUD.h

```cpp

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/HUD.h"
#include "CustomHUD.generated.h"

class ACustomPawn;     // forward declaration

UCLASS() class TEST2_API ACustomHUD : public AHUD
```

自定义HUD.cpp

```cpp

#include "CustomPawn.h"
#include "CustomHUD.h"

FString ACustomHUD::GetPawnName()
{
	return myPawn->GetName();
}
```


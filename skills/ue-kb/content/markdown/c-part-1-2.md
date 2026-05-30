# 使用游戏标签 C++ 增强输入绑定 (Part 1/2)

# 使用游戏标签 C++ 增强输入绑定 (Part 1/2)

Source file: `unreal-engine-enhanced-input-binding-with-gameplay-tags-c.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/aqrD/unreal-engine-enhanced-input-binding-with-gameplay-tags-c
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 12412 字符。
## 摘要

本教程介绍在第一人称模板中设置基础增强输入系统。这是在 Lyra 示例中实现的系统的最小化版本。我们将介绍如何设置一个简单的资产管理器、使用本机游戏标签、输入配置资产以及通过游戏标签将输入绑定到角色函数。
## 中文整理
### 介绍

在本教程中，我们将使用第一人称模板和增强输入系统构建一个基本输入系统。我们将介绍如何设置本机游戏标签以及如何使用它们在编辑器中配置输入绑定。这与 Lyra 示例中实现的系统非常相似，但它已被简化并在不太复杂的上下文中呈现。增强型输入系统支持高级输入功能，例如复杂输入处理和运行时控制重新映射。该系统包括径向死区、和弦动作、上下文输入和优先级等功能，以及在基于资产的环境中过滤和处理输入数据的能力。本教程并不是深入探讨增强型输入系统或一般的输入设计，而是作为理解基本概念的良好起点。本教程假设您对虚幻引擎和编辑器有一定的了解，并且具有一些基本的 C++ 知识。
### 入门
### 项目设置

让我们开始基于第一人称模板创建一个 C++ 项目。

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-01.jpg)

打开编辑器后，在插件菜单中启用增强输入插件。您需要重新启动编辑器才能加载插件。编辑->插件

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-02.jpg)
### 游戏标签和资产管理器
### 本机游戏标签设置

我们将使用游戏标签作为游戏代码和编辑器之间的桥梁。我们可以在代码中引用标签进行输入绑定，因为它们是本机定义的。我们还可以在数据资产中使用它们来在编辑器中进行输入配置。我们将首先创建一个单例来保存我们的本机游戏标签。从编辑器创建一个空类并为其命名适当的名称。为了清楚起见，我将在大多数类中坚持使用“My”前缀。我们的游戏标签结构将列出标签并定义一些用于初始化标签的辅助函数。
### MyGameplayTags.h

**MyGameplayTags.h**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "GameplayTagContainer.h"

class UGameplayTagsManager;

/**
```
### MyGameplayTags.cpp

我们正在获取 GameplayTagsManager 并添加描述角色能力的标签。我们将在代码中使用这些标签来绑定实际的字符函数，并且还将在编辑器中使用它们来配置输入绑定。稍后会详细介绍。不要忘记将“GameplayTags”条目添加到 Build.cs 文件中的 PublicDependencyModuleNames 列表中，以避免链接错误。

**MyGameplayTags.cpp**

```cpp
#include "MyGameplayTags.h"
#include "GameplayTagsManager.h"
#include "Engine/EngineTypes.h"

FMyGameplayTags FMyGameplayTags::GameplayTags;

void FMyGameplayTags::InitializeNativeTags()
{
	UGameplayTagsManager& GameplayTagsManager = UGameplayTagsManager::Get();
```
### 资产管理人

我们需要一种在引擎启动过程中尽早初始化本机游戏标签的方法，而资产管理器非常适合这一点。我们将创建一个简单的 AssetManager，它会覆盖 StartInitialLoading 以启动标签的加载和初始化。
### 我的资产管理器.h

**我的资产管理器.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Engine/AssetManager.h"
#include "MyAssetManager.generated.h"

/**
 * 
 */
UCLASS()
```
### 我的资产管理器.cpp

**我的资产管理器.cpp**

```cpp
#include "MyAssetManager.h"
#include "MyGameplayTags.h"

UMyAssetManager::UMyAssetManager()
{

}

UMyAssetManager& UMyAssetManager::Get()
{
```
### 输入配置

我们需要一种方法将输入标签与编辑器级别的输入操作相关联，因此我们将创建一个数据资产来提供帮助。首先，我们将创建一个简单的结构来包含一对类型：UInputAction 和 FGameplayTag。我们将将该结构命名为 FTaggedInputAction 并将其作为类型公开给蓝图。接下来，我们的数据资产将具有这些 FTaggedInputActions 的数组和一个辅助函数，用于使用其关联的标签查找 InputAction。
### 输入配置.h

**输入配置.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Engine/DataAsset.h"
#include "GameplayTags/Classes/GameplayTagContainer.h"
#include "InputConfig.generated.h"

class UInputAction;
struct FGameplayTag;
```
### 输入配置.cpp

**输入配置.cpp**

```cpp
#include "InputConfig.h"
#include "GameplayTagContainer.h"
#include "EnhancedInput/Public/InputAction.h"

const UInputAction* UInputConfig::FindInputActionForTag(const FGameplayTag& InputTag) const
{
	for (const FTaggedInputAction& TaggedInputAction : TaggedInputActions)
	{
		if (TaggedInputAction.InputAction && TaggedInputAction.InputTag == InputTag)
		{
```
### 增强输入组件

完成增强输入设置所需的最后一个对象是自定义增强输入组件。它只是包装 UEnhancedInputComponent::BindAction 的单个辅助函数。这将使我们能够根据游戏标签绑定动作。

**MyEnhancedInputComponent.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "EnhancedInputComponent.h"
#include "InputAction.h"
#include "InputConfig.h"
#include "GameplayTagContainer.h"
#include "MyEnhancedInputComponent.generated.h"

/**
```
### 角色设定

现在我们的增强输入框架已经完成，我们需要设置我们的角色。我将使用 C++ 第一人称模板角色类作为起点。我删除了一些无关的代码，为我们的 InputConfig 资源添加了一个指针，并添加了用于移动、查看、跳跃和射击的函数。
### 标头添加：

```cpp
	/** The input config that maps Input Actions to Input Tags*/
	UPROPERTY(EditDefaultsOnly, Category = "Input")
	UInputConfig* InputConfig;

	/** Handles moving forward/backward */
	void Input_Move(const FInputActionValue& InputActionValue);

	/** Handles mouse and stick look */
	void Input_Look(const FInputActionValue& InputActionValue);
```
### 设置播放器输入组件覆盖

接下来，我们需要使用相关的游戏标签将角色的动作函数绑定到适当的 InputAction。这是通过重写 SetupPlayerInputComponent 并使用我们添加到增强型输入组件中的 BindActionByTag 函数来完成的。使用这种方法需要我们将相应的字符操作硬编码到输入标签，例如本机级别的 InputTag_Move、InputTag_Fire，但是当我们使用 UInputConfig 资产配置 InputActions 时，它为我们提供了编辑器级别的灵活性。

**设置播放器输入组件**

```cpp
void AMyProjectCharacter::SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent)
{

	UMyEnhancedInputComponent* MyEnhancedInputComponent = Cast<UMyEnhancedInputComponent>(PlayerInputComponent);

	//Make sure to set your input component class in the InputSettings->DefaultClasses
	check(MyEnhancedInputComponent);

	const FMyGameplayTags& GameplayTags = FMyGameplayTags::Get();
```

这是角色类的最终来源：
### MyProjectCharacter.h

**MyProjectCharacter.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Character.h"
#include "MyProjectCharacter.generated.h"

class UInputComponent;
class USkeletalMeshComponent;
class USceneComponent;
class UCameraComponent;
```
### 我的项目角色.cpp

**我的项目角色.cpp**

```cpp
#include "MyProjectCharacter.h"
#include "MyProjectProjectile.h"
#include "Animation/AnimInstance.h"
#include "Camera/CameraComponent.h"
#include "Components/CapsuleComponent.h"
#include "EnhancedInput/Public/InputAction.h"
#include "MyEnhancedInputComponent.h"
#include "MyGameplayTags.h"
```
### 输入设置

在输入设置（ProjectSettings->Input）中，清除绑定部分中的现有输入映射。还要按如下方式设置输入默认类： - 默认播放器输入类 = EnhancedPlayerInput - 默认输入组件类 = MyEnhancedInputComponent（或您为组件命名的任何名称）

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-03.jpg)
### 输入资产和配置
### 输入动作

输入动作代表抽象的游戏动作。输入操作返回以下数据类型之一的值：bool、float、Vector2 和 Vector3。它们还可以配置触发规则和值修饰符。触发器通过设置限定符和条件来影响操作的触发方式或时间。例如，“按下”触发器每次按下都会触发一次事件。而“脉冲”触发器将在按下按键或按钮时以一定的时间间隔触发事件。可以应用修改器来调整输入操作的最终输出。例如，“DeadZone”修改器将输入值限制在下阈值和上限阈值之间。对于我们的简单示例，我们需要五个输入操作。我们将 **Look ** 分成两个操作，这样我们就可以分别处理基于鼠标和摇杆的输入。通过在内容浏览器中右键单击并从资产创建菜单中选择“输入”->“输入操作”来创建以下输入操作。 1. IA_Fire - ValueType(bool)、触发器(Pressed)、修饰符(None) 2. IA_Jump - ValueType(bool)、触发器(Pressed)、修饰符(None) 3. IA_Move - ValueType(Axis2D)、触发器(None )、修饰符(None) 4. IA_MouseLook - ValueType(Axis2D)、触发器（无）、修饰符（负 - Y 轴） 5. IA_StickLook - ValueType（Axis2D ）、触发器（无）、修饰符（无）

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-04.jpg)
### 输入配置

输入配置资源将基于我们之前定义的 UInputConfig 类。我们将在此处配置输入标签和应绑定到角色或 pawn 的输入操作之间的关联。通过右键单击内容浏览器并选择“Miscellaneous”->“Data Asset”，然后在类选择器中选择“InputConfig”来创建输入配置资产。

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-05.jpg)

创建后，为每个输入操作/输入标签对添加一个条目。如果您的输入标签未显示，请确保您的 AssetManager 类在引擎设置中设置为默认的 Asset Manager 类，然后重新启动编辑器。最终配置应类似于： 1. IA_Fire - InputTag.Fire 2. IA_Jump - InputTag。跳转 3.IA_Move - 输入标签。步骤 4. IA_MouseLook - 输入标签。 Look.Mouse 5. IA_StickLook - 输入标签。看。戳

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-06.jpg)

![教程图片](assets/unreal-engine-enhanced-input-binding-with-gameplay-tags-c/image-07.jpg)


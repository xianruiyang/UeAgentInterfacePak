# C++ 捉迷藏教程系列：第二部分 (Part 3/3)

Source file: `unreal-engine-c-hide-and-seek-tutorial-series-part-ii.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### CPP_PoisonHazard：第一部分

**CPP_PoisonHazard：头文件**

```cpp
CPP_PoisonHazard.h

protected:

   // Sets default properties for this class
   ACPP_PoisonHazard();

   // This child hazard's version of functionality to execute when player overlaps it
   virtual void OnPlayerOverlap(class ACPP_Player* Player) override;
```
### CPP_PoisonHazard：第二部分

**CPP_PoisonHazard：实施文件**

```cpp
CPP_PoisonHazard.cpp

// Don't forget to add:
#include "CPP_HealthComponent.h"
#include "Components/RectLightComponent.h"
#include "TimerManager.h"

// For our custom PRINT macros:
#include "CPP_Tutorial.h"
```
### CPP_PoisonHazard：蓝图
### 项目设置：碰撞
### CPP_对手：第一部分

**CPP_Opponent：头文件**

```cpp
CPP_Opponent.h

private:
   
   // Functionality to execute when opponent is spotted
   void OpponentSpotted();

private:

   // Mesh component
```
### CPP_对手：第二部分

**CPP_Opponent：实现文件**

```cpp
CPP_Opponent.cpp

// Don't forget to add:
#include "CPP_Player.h"
#include "Kismet/GameplayStatics.h"

// Sets default values
ACPP_Opponent::ACPP_Opponent()
{
   // Instantiate mesh component and set as root
```
### 建模模式：对手网格
### CPP_对手：蓝图
### CPP_VisionComponent：第一部分

**CPP_VisionComponent：头文件**

```cpp
CPP_VisionComponent.h

public:

    // Executes object sweep to determine if actor of specified object type was found, and if it was, returns that actor (if not returns null pointer)
    AActor* LookForObjectType(FCollisionObjectQueryParams ObjectQueryParams, bool bShouldDraw = true, float DrawDuration = 5.f);

private:	
	
   // Determines distance of queries
```
### CPP_VisionComponent：第二部分

**CPP_VisionComponent：实现文件**

```cpp
CPP_VisionComponent.cpp

// Don't forget to add:
#include "Camera/CameraComponent.h"
#include "DrawDebugHelpers.h"

// Executes object sweep to determine if specified object type was found
AActor* UCPP_VisionComponent::LookForObjectType(FCollisionObjectQueryParams ObjectQueryParams, bool bShouldDraw, float DrawDuration)
{
   // Start of the sweep is the location of this owner's scene component
```
### CPP_Player：寻找对手第一部分

**CPP_Player：头文件**

```cpp
CPP_Player.h

// Declare multicast delegate type above class definition (above UCLASS macro)
// We need a multicast delegate so we can broadcast to multiple objects at once
DECLARE_MULTICAST_DELEGATE(FOpponentFoundSignature);

// Anywhere within class's definition, but make sure it's public
public:

   // Variable of type opponent found delegate; broadcasts when player spots the opponent
```
### CPP_Player：寻找对手第二部分

**CPP_Player：实现文件**

```cpp
CPP_Player.cpp

// Don't forget to add:
#include "CPP_VisionComponent.h"

// Sets default values
ACPP_Player::ACPP_Player()
{
   // Under existing code ...
```
### CPP_PlayerController：寻找对手

**CPP_播放器控制器**

```cpp
CPP_PlayerController.h

private:

   // Executes functionality from CPP_Player when input binding for Find action is triggered
   void OnFindOpponent();

private:

   // Stores input action for finding opponent
```
### CPP_Opponent：绑定到 OnOpponentFound

**CPP_Opponent：实现文件**

```cpp
CPP_Opponent.cpp

// Called when the game starts or when spawned
void ACPP_Opponent::BeginPlay()
{
   // Under code getting reference to player character ...

   // Bind OpponentSpotted functionality to player character's multicast delegate
   Player->OnOpponentFound.AddUObject(this, &ACPP_Opponent::OpponentSpotted);
}
```
### 输入：添加“查找”输入操作
### 游戏测试：对手
### 捉迷藏游戏设计
### 交互对象类型和 CPP_InteractionInterface

**CPP_InteractionInterface：头文件**

```cpp
CPP_InteractionInterface.h

// Under UCPP_InteractionInterface class:

class CPP_TUTORIAL_API ICPP_InteractionInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
```
### CPP_Switch：第一部分

**CPP_Switch：头文件**

```cpp
CPP_Switch.h

// Don't forget to add:
#include "CPP_InteractionInterface.h"

// Your class declaration (under UCLASS macro) should look like:
class CPP_TUTORIAL_API ACPP_Switch : public AActor, public ICPP_InteractionInterface

public:
```
### CPP_Switch：第二部分

**CPP_Switch：实现文件**

```cpp
CPP_Switch.cpp

// For PRINT macros:
#include "CPP_Tutorial.h"

// Sets default values
ACPP_Switch::ACPP_Switch()
{
	PrimaryActorTick.bCanEverTick = false;
```
### 材质：开关按钮
### 建模模式：开关网格
### CPP 交换机：蓝图
### CPP_Player：与 Actor 交互

**CPP_Player：头文件和实现文件**

```cpp
CPP_Player.h

public:

    // Executes functionality when the player tries to interact with an actor
    void Interact();

CPP_Player.cpp

// Don't forget to add:
```
### CPP_PlayerController：与 Actor 交互

**CPP_PlayerController：头文件和实现文件**

```cpp
CPP_PlayerController.h

private:

   // Executes functionality from CPP_Player when Activate / Interact input action is triggered
   void OnInteract();

private:

   // Stores input action for interacting / activating
```
### 输入：添加“交互”输入操作
### 游戏测试：Switch
### CPP_网关：第一部分

**CPP_Gateway：头文件**

```cpp
CPP_Gateway.h

// Don't forget to add:
#include "CPP_InteractionInterface.h"

// Class declaration should look like:
UCLASS()
class CPP_TUTORIAL_API ACPP_Gateway : public AActor, public ICPP_InteractionInterface

public:
```
### CPP_网关：第二部分

**CPP_Gateway：实现文件**

```cpp
CPP_Gateway.cpp

// Don't forget to add:
#include "TimerManager.h"

// For PRINT macros:
#include "CPP_Tutorial.h"

// Sets default values
ACPP_Gateway::ACPP_Gateway()
```
### 材料：网关
### 建模模式：网关网状
### CPP_Gateway：蓝图
### 游戏测试：网关
### CPP_LevelScript：第一部分

**CPP_LevelScript：头文件**

```cpp
CPP_LevelScript.h

// Under list of includes:
// Forward declare target point class here to save time
class ATargetPoint;

// Notifies listeners when last hiding spot in an area has been found
DECLARE_MULTICAST_DELEGATE_OneParam(FLastHidingSpotFoundSignature, bool);

// In class definition:
```
### CPP_LevelScript：第二部分

**CPP_LevelScript：实现文件**

```cpp
CPP_LevelScript.cpp

// Don't forget to add:
#include "CPP_Opponent.h"
#include "CPP_Player.h"
#include "Engine/TargetPoint.h"
#include "Kismet/GameplayStatics.h"

// For custom PRINT macros:
#include "CPP_Tutorial.h"
```
### CPP_Switch：绑定到关卡脚本委托

**CPP_开关**

```cpp
CPP_Switch.h

private:

   // Pointer to level script
   UPROPERTY()
   TObjectPtr<class ACPP_LevelScript> LevelScript = nullptr;


CPP_Switch.cpp
```
### 建模模式：搭建试验场
### 添加目标点 Actor
### CPP_LevelScript：关卡蓝图
### 游戏测试：一切！
### 总结
## 相关链接

- [C++ Hide and Seek Tutorial Series: Part I](https://dev.epicgames.com/community/learning/tutorials/bXy3/unreal-engine-hide-and-seek-c-tutorial-series-part-i)

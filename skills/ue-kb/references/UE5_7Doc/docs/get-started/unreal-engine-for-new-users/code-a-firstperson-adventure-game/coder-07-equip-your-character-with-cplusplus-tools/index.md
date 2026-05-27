---
title: "装备角色"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-07-equip-your-character-with-cplusplus-tools"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "装备角色"]
---

# 装备角色

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 装备角色

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-07-equip-your-character-with-cplusplus-tools

## 开始之前

请确保你已完成了[编写第一人称冒险游戏](../index.md)的前面章节中的以下目标：

- 在 [创建具有输入操作的玩家角色](../coder-02-create-a-player-character-with-input-a-9df71be2/index.md) 中编译了C++第一人称玩家角色。
- 在 [管理物品和数据](../coder-05-manage-item-and-data-in-an-unreal-engine-game/index.md) 中设置了数据驱动的Gameplay元素以管理物品数据。
- 在

  创建可重新生成的拾取项目

  中创建了拾取物并将其添加到关卡中。

### 通过新的CreateItemCopy函数创建引用物品

在开始创建新的可装备拾取物之前，你需要先修改**ItemDefinition**和**PickupBase**类，以支持从更多物品类型中捕获引用物品。

在`PickupBase`类的`InitializePickup()`函数中，你将设置一个`UItemDefinition`类型的`ReferenceItem`。 这种方式的限制过多：若以这种方式设置引用物品，将不包含你为所有从`UItemDefinition`派生的新专属物品类所添加的额外属性。

为解决此问题，你将在`ItemDefinition`中创建一个新的虚函数，用于创建并返回该物品的副本。 由于它是一个虚函数，你可以在所有继承自`UItemDefinition`的类中重载它。 当`PickupBase`调用该函数时，编译器会根据调用的类确定要调用的正确函数。

将此函数添加到父类`ItemDefinition`中，可以确保如果你决定继续扩展项目，包含更多继承自`UItemDefinition`的物品类型，该函数仍然可用。

要定义用于创建引用物品的`CreateItemCopy()`函数，请执行以下步骤：

1. 打开`ItemDefinition.h`。 在`public`部分，声明一个名为`CreateItemCopy()`的新虚const函数，该函数会返回`UItemDefinition`指针。

   C++

   ```
   // Creates and returns a copy of the item.virtual UItemDefinition* CreateItemCopy() const;
   ```
2. 在`ItemDefinition.cpp`中，实现`CreateItemCopy()`函数。 在内部，使用`StaticClass()`创建一个名为`ItemCopy`的新`UItemDefinition`对象指针。

   C++

   ```
   UItemDefinition* UItemDefinition::CreateItemCopy() const {	UItemDefinition* ItemCopy = NewObject<UItemDefinition>(StaticClass());}
   ```

   > [!NOTE]
   > Visual Studio会将`UItemDefinition::StaticClass()`消歧义为`StaticClass()`。
3. 将`ItemCopy`的每个字段赋值为此类的对应字段，然后返回`ItemCopy`：

   C++

   ```
   /** 
   *	Creates and returns a copy of this Item Definition.
   *	@return	a copy of the item.
   */
   UItemDefinition* UItemDefinition::CreateItemCopy() const 
   {
   	UItemDefinition* ItemCopy = NewObject<UItemDefinition>(StaticClass());

   	ItemCopy->ID = this->ID;
   	ItemCopy->ItemType = this->ItemType;
   ```

接下来，重构`InitializePickup()`函数，方法是删除手动设置`ReferenceItem`的代码，将该代码替换为调用`CreateItemCopy()`。

使用新的`CreateItemCopy()`函数更新`InitializePickup()`，请执行以下步骤：

1. 打开`PickupBase.cpp`并转到`InitializePickup()`。
2. 删除定义和设置`ReferenceItem`的五行代码：

   C++

   ```
   ReferenceItem = NewObject<UItemDefinition>(this, UItemDefinition::StaticClass()); ReferenceItem->ID = ItemDataRow->ID;ReferenceItem->ItemType = ItemDataRow->ItemType;ReferenceItem->ItemText = ItemDataRow->ItemText;ReferenceItem->WorldMesh = ItemDataRow->ItemBase->WorldMesh;
   ```
3. 在`ReferenceItem`中，通过调用`TempItemDefinition->CreateItemCopy()`：

   C++

   ```
   // Create a copy of the item with the class typeReferenceItem = TempItemDefinition->CreateItemCopy();
   ```

保存`PickupBase.cpp`。 `InitializePickup()`函数现在应如下所示：

C++

```
if (PickupDataTable && !PickupItemID.IsNone()){	// Retrieve the item data associated with this pickup from the data table	const FItemData* ItemDataRow = PickupDataTable->FindRow<FItemData>(PickupItemID, PickupItemID.ToString()); 	UItemDefinition* TempItemDefinition = ItemDataRow->ItemBase.Get(); 	// Create a copy of the item with the class type	ReferenceItem = TempItemDefinition->CreateItemCopy();}
```

## 定义可装备工具数据

在上一节中，你学习了如何在关卡中创建可交互的拾取对象，这些对象是表格数据的具体表现。 在本节中，你将学习如何编译可供角色装备的工具。

要设置新的可装备工具，你需要创建以下内容：

- `EquippableToolDefinition`：从`ItemDefinition`派生的数据资产类，用于存储工具数据。
- `EquippableToolBase`：表示游戏中工具的Actor类。 它可为角色提供动画、输入映射和网格体，使角色能够握持和操作工具。

要让角色能够拾取和装备工具，你需要添加以下内容：

- 项目的存储位置。
- 用于了解物品栏中每个物品类型的方法。
- 工具的装备方法。

请记住，`EquippableToolBase`Actor表示角色握持和使用的工具，而`PickupBase`Actor表示关卡中的拾取物。 角色必须与拾取物发生碰撞才能装备它，因此你还需要修改`PickupBase`，以便在成功碰撞后将物品授予角色。

然后，你将新的工具类与已编译的拾取物和数据表结合，创建自定义飞镖发射器并将其附加到角色！

首先，在新的`ItemDefinition`类中定义工具数据。

要创建新的`EquippableToolDefinition`类，请执行以下步骤：

1. 在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。 转到**所有类（All Classes）**，搜索并选择**ItemDefinition**作为父类，点击**下一步（Next）**。
2. 将类命名为`EquippableToolDefinition`，然后点击**创建类（Create Class）**。
3. 在Visual Studio中，在`EquippableToolDefinition.h`顶部添加`"ItemDefinition.h"`的include语句，然后添加以下前置声明：

   1. `class UInputMappingContext`：每个可装备工具应持有对输入映射上下文的引用，该上下文将应用于握持该工具的角色。
   2. `class AEquippableToolBase`：在游戏中表示工具的Actor。 你将在下一步创建它。

      C++

      ```
      #pragma once

      #include "CoreMinimal.h"
      #include "ItemDefinition.h"
      #include "EquippableToolDefinition.generated.h"

      class AEquippableToolBase;
      class UInputMappingContext;

      UCLASS(BlueprintType, Blueprintable)
      ```
4. 在`public`部分：添加一个`TSubclassOf`类型的属性，名为`ToolAsset`，类型为`AEquippableToolBase`。 为其添加`UPROPERTY()`宏，设置为`EditDefaultsOnly`。

   C++

   ```
   // The tool actor associated with this itemUPROPERTY(EditDefaultsOnly)TSubclassOf<AEquippableToolBase> ToolAsset;
   ```

   `TSubclassOf<AEquippableToolBase>`是围绕`UClass`的模板封装器，允许你引用`AEquippableToolBase`的蓝图子类，同时确保类型安全。 这在需要动态生成不同类型Actor的Gameplay情景中很有用。

   你将使用`ToolAsset`在工具装备到角色时动态生成工具Actor。
5. 声明对`UItemDefinition`中声明的`CreateItemCopy()`函数的重载。 此重载将创建并返回`UEquippableToolDefinition`类的副本。

   完整的`EquippableToolDefinition.h`文件应如下所示：

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved.

   #pragma once

   #include "CoreMinimal.h"
   #include "ItemDefinition.h"
   #include "EquippableToolDefinition.generated.h"

   class AEquippableToolBase;
   class UInputMappingContext;
   ```
6. 在`EquippableToolDefinition.cpp`中，实现`CreateItemCopy()`函数。 该函数应与`ItemDefinition.cpp`中的`CreateItemCopy()`函数类似，但现在还需要复制 `ToolAsset`。

   C++

   ```
   // Copyright Epic Games, Inc. All Rights Reserved.

   #include "EquippableToolDefinition.h"

   UEquippableToolDefinition* UEquippableToolDefinition::CreateItemCopy() const
   {
   	UEquippableToolDefinition* ItemCopy = NewObject<UEquippableToolDefinition>(StaticClass());

   	ItemCopy->ID = this->ID;
   	ItemCopy->ItemType = this->ItemType;
   ```

保存`EquippableToolDefinition`类的两个文件。

## 设置可装备工具Actor

接下来，开始编译可装备工具Actor。 这是游戏中的表示形式，用于为角色添加工具的动画、控制和网格体。

要创建并设置新的基本可装备工具Actor，请执行以下步骤：

1. 在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。 选择**Actor**作为父类，并将类命名为**EquippableToolBase**。
2. 点击**创建类（Create Class）**。 虚幻引擎将自动在VS中打开新类的文件。
3. 在`EquippableToolBase.h`顶部，前置声明类`AAdventureCharacter`和类`UInputAction`。 可装备工具需要知道它被装备到哪个角色，以便将工具特定的输入操作绑定到该角色。
4. 在类声明的`UCLASS`宏中，添加`BlueprintType`和`Blueprintable`说明符，以便将此类公开给蓝图。

   C++

   ```
   UCLASS(BlueprintType, Blueprintable)class ADVENTUREGAME_API AEquippableToolBase : public AActor
   ```

### 声明工具动画

在`EquippableToolBase.h`的`public`部分，添加两个指向`UAnimBlueprint`属性的`TObjectPtr`，分别命名为`FirstPersonToolAnim`和`ThirdPersonToolAnim`。 这些是角色装备此工具时使用的第一人称和第三人称动画。

为这些属性添加`UPROPERTY()`宏，设置为`EditAnywhere`和`BlueprintReadOnly`。

C++

```
// First Person animationsUPROPERTY(EditAnywhere, BlueprintReadOnly)TObjectPtr<UAnimBlueprint> FirstPersonToolAnim; // Third Person animationsUPROPERTY(EditAnywhere, BlueprintReadOnly)TObjectPtr<UAnimBlueprint> ThirdPersonToolAnim;
```

### 创建工具的网格体

在`EquippableToolBase.h`的`public`部分，添加一个指向`USkeletalMeshComponent`的`TObjectPtr`，命名为`ToolMeshComponent`。 这是角色装备工具时看到的工具骨架网格体。 为其添加`UPROPERTY()`宏，设置为`EditAnywhere`和`BlueprintReadOnly`。

C++

```
// Tool Skeletal MeshUPROPERTY(EditAnywhere, BlueprintReadOnly)TObjectPtr<USkeletalMeshComponent> ToolMeshComponent;
```

在`EquippableToolBase.cpp`中，修改`AEquippableToolBase()`构造函数，以创建默认的`USkeletalMeshComponent`并将其分配给`ToolMeshComponent`。 然后检查`ToolMeshComponent`是否不为空，以确保工具在加载时有模型。

C++

```
AEquippableToolBase::AEquippableToolBase(){	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.	PrimaryActorTick.bCanEverTick = true; 	// Create this tool's mesh component	ToolMeshComponent = CreateDefaultSubobject<USkeletalMeshComponent>(TEXT("ToolMesh"));	check(ToolMeshComponent != nullptr);}
```

### 声明工具的所有者

在`EquippableToolBase.h`的`public`部分，创建一个指向角色类实例的`TObjectPtr`，命名为 `OwningCharacter`。 为其添加`UPROPERTY()`宏，设置为`EditAnywhere`和`BlueprintReadOnly`。

这是该工具当前所装备的角色。

C++

```
// The character holding this toolUPROPERTY(EditAnywhere, BlueprintReadOnly)TObjectPtr<AAdventureCharacter> OwningCharacter;
```

### 声明输入和使用工具的函数

你的工具附带需要提供给角色的输入映射上下文和输入操作。

要添加输入映射上下文，请在 `public` 部分，声明一个指向名为 `ToolMappingContext` 的 `UInputMappingContext` 的 `TObjectPtr`。 为其添加UPROPERTY()宏，设置为 `EditAnywhere` 和`BlueprintReadOnly`。

C++

```
// The input mapping context associated with this toolUPROPERTY(EditAnywhere, BlueprintReadOnly)TObjectPtr<UInputMappingContext> ToolMappingContext;
```

类似于实现移动控制时，你将添加一个实现使用工具操作的函数，以及一个将输入操作绑定到该函数的新函数。

在`EquippableToolBase.h`的`public`部分，声明两个虚void函数，名为`Use()`和`BindInputAction()`。

当你实现角色移动控制时，使用了InputComponent的 `BindAction()` 函数，该函数要求你传递目标函数的确切名称。 由于你尚不知道函数的完整名称，因此需要一个自定义 `BindInputAction()` 函数，你可以在每个 `EquippableToolBase` 子类中实现该函数，以调用 `BindAction`，并传递 `[ToolChildClass]::Use`。

`BindInputAction()`函数会接收一个常量`UInputAction`指针，并将给定的输入操作绑定到角色的`Use()`函数。

C++

```
// Use the toolUFUNCTION()virtual void Use(); // Binds the Use function to the owning characterUFUNCTION()virtual void BindInputAction(const UInputAction* ActionToBind);
```

在`EquippableToolBase.cpp`中，实现`Use()`和`BindInputAction()`函数。 在父类中不执行任何操作，因此暂时可以将其留空。 在创建`EquippableToolBase`子类时，你需要向这些函数添加逻辑，例如，`Use()`函数应包含工具特定的操作，如发射发射物或开门。

C++

```
void AEquippableToolBase::Use(){} void AEquippableToolBase::BindInputAction(const UInputAction* ActionToBind){}
```

在VS中保存并编译代码。

你的`EquippableToolBase.h`文件现在应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "EquippableToolBase.generated.h"

class AAdventureCharacter;
class UInputAction;
```

`EquippableToolBase.cpp` 现在应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.


#include "EquippableToolBase.h"
#include "AdventureCharacter.h"

AEquippableToolBase::AEquippableToolBase()
{
	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
```

## 向角色授予物品

你已定义了角色可使用的工具，但角色目前还无法装备工具。 接下来，你将添加物品栏系统，使角色在拾取物品时可以存储和装备物品。

### 编译库存组件

角色的物品栏应向角色添加功能，但不在游戏世界中存在，因此你将使用**Actor组件**类定义一个物品栏，该物品栏知晓角色拥有哪些物品、可切换工具，并可防止角色获取多个相同工具。

在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。 选择**Actor组件**作为父类，并将类命名为`InventoryComponent`。 点击**创建类（Create Class）**。

在VS中，在`InventoryComponent.h`顶部，前置声明`UEquippableToolDefinition`。 这是你将在物品栏中存储的类。

C++

```
#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "InventoryComponent.generated.h"

class UEquippableToolDefinition;

UCLASS( ClassGroup=(Custom), meta=(BlueprintSpawnableComponent) )
class ADVENTUREGAME_API UInventoryComponent : public UActorComponent
{
	GENERATED_BODY()
```

在`public`部分，声明一个新的`UEquippableToolDefinition`指针的 `TArray`，命名为`ToolInventory`。 为其添加`UPROPERTY()`宏，设置为`VisibleAnywhere`、`BlueprintReadOnly`和`Category = Tools`。

C++

```
public:		// Sets default values for this component's properties	UInventoryComponent(); 	// The array of tools stored in this inventory.	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = Tools)	TArray<UEquippableToolDefinition*> ToolInventory;
```

此物品栏仅存储工具，但你可扩展以包含任何想要的物品类型。 更通用的实现方案是仅存储`UItemDefinition`或`TSubclassOf<UItemDefinition>`值，以编译具有UI、图标、音效、成本和其他物品属性的更复杂物品栏。

完整的`InventoryComponent.h`文件现在应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "InventoryComponent.generated.h"

class UEquippableToolDefinition;
```

### 向角色添加工具和物品栏声明

现在你已经有了存储物品的位置，接下来将为角色升级逻辑，使其能够获取物品。

首先，在角色`.h`文件顶部，前置声明`AEquippableToolBase`、`UEquippableToolDefinition`和`UInventoryComponent`类。

C++

```
#include "CoreMinimal.h"
#include "Camera/CameraComponent.h"
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h" 
#include "GameFramework/Character.h"
#include "InputActionValue.h"
#include "AdventureCharacter.generated.h"

class AEquippableToolBase;
class UAnimBlueprint;
```

在`protected`部分，声明一个指向`UInputAction`的`TObjectPtr`，命名为`UseAction`。 这是将绑定到工具`Use()`函数的"使用工具"输入操作。

C++

```
// Use Input ActionsUPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Input)TObjectPtr<UInputAction> UseAction;
```

### 创建角色的物品栏组件

在角色的`.h`文件的`public`部分，声明一个指向`UInventoryComponent`的`TObjectPtr`，命名为`InventoryComponent`。 为其添加`UPROPERTY()`宏，设置为`VisibleAnywhere`和`Category = Inventory`。

C++

```
// Inventory ComponentUPROPERTY(VisibleAnywhere, Category = Inventory)TObjectPtr<UInventoryComponent> InventoryComponent;
```

在角色的构造函数中，在创建网格体组件子对象后，创建一个名为`InventoryComponent`的默认`UInventoryComponent`子对象。 这将确保角色生成时物品栏正确设置。

C++

```
// Create an inventory component for the owning playerInventoryComponent = CreateDefaultSubobject<UInventoryComponent>(TEXT("InventoryComponent"));
```

### 检查现有物品栏

在附加工具前，检查玩家是否已拥有该工具，避免多次装备。

在角色的`.h`文件的`public`部分，声明一个名为`IsToolAlreadyOwned()`的函数，该函数会接收一个`UEquippableToolDefinition`指针，如果玩家物品栏中已存在该工具，则返回true。

C++

```
// Returns whether or not the player already owns this toolUFUNCTION()bool IsToolAlreadyOwned(UEquippableToolDefinition* ToolDefinition);
```

在角色的`.cpp`文件`AdventureCharacter.cpp`中，实现`IsToolAlreadyOwned()`函数。 在内部，在`for`循环中，通过访问`InventoryComponent->ToolInventory`数组获取角色物品栏中的每个工具。

C++

```
bool AAdventureCharacter::IsToolAlreadyOwned(UEquippableToolDefinition* ToolDefinition){	// Check that the character does not yet have this particular tool	for (UEquippableToolDefinition* InventoryItem : InventoryComponent->ToolInventory)	{	}}
```

然后，在`if`语句中，检查传递给此函数的工具的`ToolDefinition->ID`是否与`InventoryItem->ID`匹配。 如果匹配，`返回true`，因为角色已拥有此工具。 否则，`for`循环结束后`返回false`，因为`ToolDefinition`不匹配所有现有物品栏物品，因此是一个新物品。

C++

```
bool AAdventureCharacter::IsToolAlreadyOwned(UEquippableToolDefinition* ToolDefinition)
{
	// Check that the character does not yet have this particular tool
	for (UEquippableToolDefinition* InventoryItem : InventoryComponent->ToolInventory)
	{
		if (ToolDefinition->ID == InventoryItem->ID)
		{
			return true;
		}
	}
```

### 附加工具

在角色的`.h`文件的`public`部分，声明一个名为`AttachTool()`的函数，该函数会接收一个`UEquippableToolDefinition`指针。 此函数会尝试将`ToolDefinition`中的工具装备到玩家。

C++

```
// Attaches and equips a tool to the playerUFUNCTION()void AttachTool(UEquippableToolDefinition* ToolDefinition);
```

在`protected`部分，声明一个指向`AEquippableToolBase`的`TObjectPtr`，命名为`EquippedTool`。 为其添加`VisibleAnywhere`、`BlueprintReadOnly`和`Category = Tools UPROPERTY()`说明符。

C++

```
// The currently-equipped toolUPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = Tools)TObjectPtr<AEquippableToolBase> EquippedTool;
```

在角色的`.cpp`文件中，实现`AttachTool()`。 首先，在`if`语句中通过调用`IsToolAlreadyOwned()`检查角色是否已拥有该工具。

C++

```
void AAdventureCharacter::AttachTool(UEquippableToolDefinition* ToolDefinition){	// Only equip this tool if it isn't already owned	if (not IsToolAlreadyOwned(ToolDefinition))	{	}}
```

#### 生成物品

`ToolDefinition`中存储的`AEquippableToolBase`工具是一个Actor，因此在调用`AttachTool()` 时可能尚未加载。 要处理此情况，你将使用`SpawnActor()`函数生成工具的新实例。

`SpawnActor()`是**UWorld**对象的一部分，该对象是表示地图及其中Actor的核心对象。 从任何Actor调用`GetWorld()`函数都能访问该对象。

在`if`语句中，声明一个名为**ToolToEquip**的`AEquippableToolBase`指针。 将其设置为调用`GetWorld()->SpawnActor()`的结果，传递`ToolDefinition->ToolAsset`作为要生成的Actor，并传递`this->GetActorTransform()`作为生成位置。

C++

```
// Only equip this tool if it isn't already ownedif (not IsToolAlreadyOwned(ToolDefinition)){	// Spawn a new instance of the tool to equip	AEquippableToolBase* ToolToEquip = GetWorld()->SpawnActor<AEquippableToolBase>(ToolDefinition->ToolAsset, this->GetActorTransform());}
```

> [!NOTE]
> 当你将`ToolDefinition->ToolAsset`传递给`SpawnActor`时，虚幻引擎会识别`ToolAsset`的类类型并生成该类型的Actor。 （`ToolAsset`是与该`ToolDefinition`关联的`EquippableToolBase` Actor。）

#### 将物品附加到角色

要将生成的工具附加到角色，声明一个名为`AttachementRules`的新`FAttachementTransformRules`。

`FAttachementTransformRules`是一个结构体，用于定义附加时如何处理位置、旋转和缩放。 它会接收`EAttachmentRules`和末尾的布尔类型参数`InWeldSimulatedBodies`，用于向虚幻引擎表明是否涉及物理。 当为true时，虚幻引擎会将两个物体接合在一起，以便它们在移动时作为一个整体交互。 一些常用的附加规则包括`KeepRelative`（保持与父级的相对变换）、`KeepWorld`（保持世界变换）和`SnapToTarget`（对齐到父级变换）。

在你的`AttachmentRoles`定义中，添加`EAttachmentRule::SnapToTarget`和`true`。

C++

```
// Attach the tool to the First Person CharacterFAttachmentTransformRules AttachmentRules(EAttachmentRule::SnapToTarget, true);
```

然后，调用`ToolToEquip->AttachToActor()`将工具附加到角色，接着调用`ToolToEquip->AttachToComponent()`，将工具附加到第一人称网格体组件的右手插槽。

`AttachToActor`用于将一个Actor附加到目标父级Actor，而`AttachToComponent`用于将Actor的根骨骼组件附加到目标组件。 它们的语法如下：

`MyActor->AttachToActor(ParentActor, AttachmentRules, OptionalSocketName)`

C++

```
// Attach the tool to this character, and then the right hand of their first-person meshToolToEquip->AttachToActor(this, AttachmentRules);ToolToEquip->AttachToComponent(FirstPersonMeshComponent, AttachmentRules, FName(TEXT("HandGrip_R")));
```

#### 将物品的动画添加到角色

使用`SetAnimInstanceClass()`设置第一人称和第三人称网格体的动画，传递工具的第一人称和第三人称动画。

C++

```
// Set the animations on the character's meshes.		FirstPersonMeshComponent->SetAnimInstanceClass(ToolToEquip->FirstPersonToolAnim->GeneratedClass);		GetMesh()->SetAnimInstanceClass(ToolToEquip->ThirdPersonToolAnim->GeneratedClass);
```

`SetAnimInstanceClass`会在运行时为骨架网格体动态更改动画蓝图，该功能常用于装备具有不同动画集的物品和武器。 `GeneratedClass`用于获取从蓝图生成的实际`AnimInstance`类。

#### 将物品添加到物品栏

使用`ToolInventory.Add()`将工具添加到角色的物品栏中。

C++

```
// Add the tool to this character's inventoryInventoryComponent->ToolInventory.Add(ToolDefinition);
```

现在工具已附加，将`ToolToEquip->OwningCharacter`设置为该角色。

C++

```
ToolToEquip->OwningCharacter = this;
```

你已完成将新工具附加到角色的操作，因此将`EquippedTool`设置为`ToolToEquip`。

C++

```
EquippedTool = ToolToEquip;
```

#### 将物品的控制添加到角色

接下来，将工具的**输入操作**和**输入映射上下文**添加到角色。

你将以类似于在[配置角色移动](../coder-03-configure-character-movement-with-cplusplus/index.md)的**将输入映射绑定到角色**分段中设置`AAdventureCharacter::BeginPlay()`的方式实现这一点：获取`玩家控制器`，然后获取增强输入本地子系统，并在过程中使用`if`语句检查空指针。

C++

```
// Get the player controller for this characterif (APlayerController* PlayerController = Cast<APlayerController>(Controller)){	if (UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PlayerController->GetLocalPlayer()))	{		Subsystem->AddMappingContext(ToolToEquip->ToolMappingContext, 1);	}}
```

此次，当你将工具的输入映射上下文添加到玩家子系统时，将优先级设置为`1`。 玩家主映射上下文（`FirstPersonContext`）的优先级较低（`0`），因此当两个映射上下文具有相同的按键绑定时，`ToolToEquip->ToolMappingContext`中的输入绑定将优先于`FirstPersonContext`。

添加映射上下文后，调用`ToolToEquip->BindInputAction()`并传递`UseAction`，将角色的输入操作绑定到工具的`Use()`函数。

C++

```
// Get the player controller for this characterif (APlayerController* PlayerController = Cast<APlayerController>(Controller)){	if (UEnhancedInputLocalPlayerSubsystem* Subsystem = ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>(PlayerController->GetLocalPlayer()))	{		Subsystem->AddMappingContext(ToolToEquip->ToolMappingContext, 1);	} 	ToolToEquip->BindInputAction(UseAction);}
```

完整的`AttachTool()`函数应如下所示：

C++

```
void AAdventureCharacter::AttachTool(UEquippableToolDefinition* ToolDefinition)
{

	// Only equip this tool if it isn't already owned
	if (not IsToolAlreadyOwned(ToolDefinition))
	{
		// Spawn a new instance of the tool to equip
		AEquippableToolBase* ToolToEquip = GetWorld()->SpawnActor<AEquippableToolBase>(ToolDefinition->ToolAsset, this->GetActorTransform());

		// Attach the tool to the First Person Character
```

### 通过GiveItem ()支持不同物品类型

你已经有附加工具的方式，但由于拾取物及其物品定义可能包含工具以外的内容，因此需要一种方式，在调用`AttachTool()`之前，了解角色正在与何种物品交互。

创建一个`GiveItem()`函数，以根据传入的`ItemDefinition`的类型执行不同的操作。 你在`ItemData.h`中使用`EItemType enum`声明了不同的物品类型，现在可以使用该数据区分不同的物品定义。

在`AdventureCharacter.h`的`public`部分，声明一个名为`GiveItem()`的函数，该函数接收一个`UItemDefinition()`指针。 当其他类尝试向玩家授予物品时，会调用此函数。

C++

```
// Public function that other classes can call to attempt to give an item to the playerUFUNCTION()void GiveItem(UItemDefinition* ItemDefinition);
```

在`AdventureCharacter.cpp`中，实现`GiveItem()`。 首先声明一个switch语句，根据传递给该函数的项目的`ItemType`进行分支。

C++

```
void AAdventureCharacter::GiveItem(UItemDefinition* ItemDefinition){	// Case based on the type of the item	switch (ItemDefinition->ItemType)	{	}}
```

在switch语句内部，声明`EItemType::Tool`、`EItemType::Consumable`的分支以及一个默认分支。 在本教程中，仅实现工具类型的物品，因此在`消耗品（Consumable）`和`默认（default）`分支中记录物品类型并跳出switch分支。

C++

```
// Case based on the type of the item
switch (ItemDefinition->ItemType)
{
case EItemType::Tool:
{
}
case EItemType::Consumable:
{
	// Not yet implemented
	break;
```

在`Tool`分支中，将`ItemDefinition`转换为名为`ToolDefinition.`的`UEquippableToolDefinition`指针。

然后，通过检查`ToolDefinition`是否为`空`来确保类型转换成功。 如果不为`空`，调用`AttachTool()`将工具附加到角色。 否则，`打印`错误并`跳出`。

C++

```
case EItemType::Tool:
{
// If the item is a tool, attempt to cast and attach it to the character
	
UEquippableToolDefinition* ToolDefinition = Cast<UEquippableToolDefinition>(ItemDefinition);
	
if (ToolDefinition != nullptr)
{
	AttachTool(ToolDefinition);
}
```

完整的`GiveItem()`函数应如下所示：

C++

```
void AAdventureCharacter::GiveItem(UItemDefinition* ItemDefinition)
{
	// Case based on the type of the item
	switch (ItemDefinition->ItemType)
	{

case EItemType::Tool:
{
	// If the item is a tool, attempt to cast and attach it to the character
	
```

最后，需要一个游戏内触发器来启动物品授予逻辑。 当角色与拾取物碰撞时，拾取物应调用角色的`GiveItem()`函数，将拾取物的`ReferenceItem`授予角色。

为此，打开`PickupBase.cpp`。

在`OnSphereBeginOverlap()`中，检查Character是否有效后， 调用`Character->GiveItem(ReferenceItem)`将物品授予角色。

C++

```
// Checking if it is a First Person Character overlappingAAdventureCharacter* Character = Cast<AAdventureCharacter>(OtherActor);if (Character != nullptr){	// Give the item to the character	Character->GiveItem(ReferenceItem);   // Unregister from the Overlap Event so it is no longer triggered  SphereComponent->OnComponentBeginOverlap.RemoveAll(this);
```

现在已设置好工具数据和Actor，可使用它们编译角色可在游戏中装备的真实工具！

## 实现飞镖发射器

你需要为第一个可装备工具创建飞镖发射器，用于射出发射物。 在本节中，将先创建供角色握持和使用的工具。 在本教程的下一节，将实现发射物逻辑。

### 设置新的DartLauncher类

在虚幻编辑器中，转到**工具（Tools）> 新建C++类（New C++ Class）**。

转到**所有类（All Classes）**，搜索并选择**EquippableToolBase**作为父类，将类命名为`DartLauncher`。创建一个名为**Tools**的新文件夹，用于存储工具代码。 点击**创建类（Create Class）**。

在Visual Studio中，在`DartLauncher.h`顶部：

1. 添加`"[ProjectName]/EquippableToolBase.h"`的include语句。
2. 在`UCLASS()`宏中添加`BlueprintType`和`Blueprintable`说明符。
3. 在`public`部分，声明对`AEquippableToolBase`中`Use()`和`BindInputAction()`函数的重载。

完整的`DartLauncher.h`类应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "AdventureGame/EquippableToolBase.h"
#include "DartLauncher.generated.h"

UCLASS(BlueprintType, Blueprintable)
class ADVENTUREGAME_API ADartLauncher : public AEquippableToolBase
```

在`DartLauncher.cpp`中，在文件顶部，添加`"[ProjectName]/AdventureCharacter.h"`的include声明。 你需要在`BindInputAction()`函数中用到它。

C++

```
#include "DartLauncher.h"#include "AdventureGame/AdventureCharacter.h"
```

### 实现工具控制

由于你正在处理特定工具并明确了要绑定的函数，因此可实现`BindInputAction()`。

首先，实现`Use()`函数。 在`Use()`内部添加调试消息，用于在玩家触发该函数时发出通知。

C++

```
#include "DartLauncher.h"#include "AdventureGame/AdventureCharacter.h" void ADartLauncher::Use(){	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));}
```

接下来，实现`BindInputAction()`函数。 在函数内部的`if`语句中，通过`GetController()`获取`OwningCharacter`的玩家控制器，并将其转换为`APlayerController`。 这类似于你在`AAdventureCharacter::BeginPlay()`函数中添加映射上下文的方式。

C++

```
void ADartLauncher::BindInputAction(const UInputAction* InputToBind){	// Set up action bindings	if (APlayerController* PlayerController = Cast<APlayerController>(OwningCharacter->GetController()))	{ 	}}
```

就像你在[配置角色移动](../coder-03-configure-character-movement-with-cplusplus/index.md)的**绑定移动操作**部分中绑定移动操作一样：在另一个`if`语句中，声明一个名为**EnhancedInputComponent**的新`UEnhancedInputComponent`指针。 将其设置为对传递给此函数的`PlayerInputComponent`调用`Cast()`并转换为`UEnhancedInputComponent`的结果。

最后，使用`BindAction`将`ADartLauncher::Use`操作绑定到通过`BindAction()`传递给此函数的`InputToBind`操作。 这会将InputAction绑定到`Use();`，以便当给定动作发生时调用`Use()`。

C++

```
// Set up action bindingsif (APlayerController* PlayerController = Cast<APlayerController>(OwningCharacter->GetController())){ 	if (UEnhancedInputComponent* EnhancedInputComponent = Cast<UEnhancedInputComponent>(PlayerController->InputComponent))	{		// Fire		EnhancedInputComponent->BindAction(InputToBind, ETriggerEvent::Triggered, this, &ADartLauncher::Use);	}}
```

> [!NOTE]
> 当你设置角色移动时，使用了`CastChecked<>`，如果失败会导致游戏崩溃。 此处，如果拾取控制初始化不正确，你不希望停止游戏，所以只使用`Cast<>`。 只有当类型转换失败会指示严重漏洞时，才使用`CastChecked<>`。

保存并编译代码。

你的`BindInputAction()`函数和完整的`DartLauncher.cpp`类现在应如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "DartLauncher.h"
#include "AdventureGame/AdventureCharacter.h"

void ADartLauncher::Use()
{
	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));

}
```

### 为角色调整动画蓝图

第一人称模板包含一个武器类型物品的示例动画蓝图，但你需要对蓝图进行一些更改，使其能与你的飞镖发射器配合使用。

要为角色调整现有动画蓝图，请执行以下步骤：

1. 在**内容浏览器（Content Browser）**中，转到**Content> Variant_Shooter > Anim**文件夹，右键点击`ABP_FP_Pistol`动画蓝图并选择**复制（Duplicate）**。
2. 将此副本命名为**ABP_FP_DartLauncher**，将其拖到**Content> FirstPerson > Anims**文件夹中，并选择**移至此处（Move Here）**。

   > [!NOTE]
   > `ABP_TP_Pistol`不使用任何特定于`BP_FPShooter`角色的逻辑；你不需要为你的角色修改它。
3. 在事件图表顶部附近，放大查看以**Event Blueprint Begin Play**节点开始的一组节点。

   此蓝图从`BP_FPShooter`获取**第一人称网格体（First Person Mesh）**和**第一人称摄像机（First Person Camera）**变量，因此你将更改此设置以使用你的角色蓝图（本教程使用`BP_AdventureCharacter`）。
4. 单击每个节点并按下**删除（Delete）**：

   - **Cast To BP_FPShooter**
   - **First Person Mesh**
   - **First Person Camera**
5. 右键点击**事件图表**，然后搜索并选择**Cast To BP_AdventureCharacter**节点。
6. 将执行引脚从**Event Blueprint Begin Play**连接到新节点，然后连接到**Set First Person Mesh**节点。
7. 将**Try Get Pawn Owner**节点的**返回值（Return Value）**引脚连接到**Cast To节点的对象（Object）**引脚。
8. 要从**Cast To BP_AdventureCharacter**节点创建新节点，点击**作为蓝图我的冒险角色（As BP My Adventure Character）**引脚并拖至图表中的空白处。

   > 动图已省略：1c3cb22aeedf0d1e7650ee64855b96b549a0b33dab066866f0d06ffc930729a7
9. 搜索并选择**Get Mesh**，该节点位于**变量（Variables）> 角色（Character）**下。 将新节点的**网格体（Mesh）**引脚连接到**Set First Person Mesh**节点。
10. 对于摄像机，从**作为蓝图我的第一人称角色（As BP My First Person Character）**引脚拖动另一个节点，搜索并选择 **Get Component by Class**。

    > [!NOTE]
    > 确保创建的**Get Component by Class**节点中"by"为小写。
11. 在新节点上，将**组件类（Component Class）**设置为**摄像机组件（Camera Component）**。 然后，将**返回值（Return Value）**引脚连接到**Set First Person Camera**节点。

保存并编译`ABP_FP_DartLauncher`蓝图。

### 定义飞镖发射器控制

你的飞镖发射器需要输入操作和输入映射上下文，以便角色可以通过工具发射发射物。

要为飞镖发射器工具创建玩家控制，请执行以下步骤：

1. 在**内容浏览器（Content Browser）**中，转至**Input > Actions**文件夹。
2. 创建并设置"使用工具"输入操作：

   1. 点击**添加（Add）**，转至**输入（Input）**，并选择**输入操作（Input Action）**。 将其命名为**IA_UseTool**。
   2. 双击**IA_UseTool**将其打开。 在**细节（Details）**面板中，确保**值类型（Value Type）**为**数字（布尔）（Digital (bool)）**。
   3. 在**触发器（Triggers）**旁，点击加号按钮（+），然后从触发器列表中选择**按下（Pressed）**。
   4. 保存并关闭"输入操作（Input Action）"。
3. 返回**内容浏览器**，转至**Input****文件夹**。
4. 创建并设置新的输入映射上下文，将鼠标左键和游戏手柄右扳机映射到飞镖发射器的使用操作：

   1. 创建新的**输入映射上下文**，命名为**IMC_DartLauncher**。
   2. 打开**IMC_DartLauncher**。 点击**映射（Mappings）**旁的加号按钮。
   3. 在下拉列表中，选择`IA_UseTool`。
   4. 单击箭头展开映射。 点击键盘按钮，然后按下 鼠标左键，将该按钮绑定到`IA_UseTool`。
   5. 在**IA_UseTool**旁，点击加号按钮添加另一个绑定。 在下拉列表中，展开**游戏手柄（Gamepad）**并选择**游戏手柄右扳机轴（Gamepad Right Trigger Axis）**。
   6. 保存并关闭输入映射上下文。

### 创建DartLauncher蓝图

返回主编辑器，在**内容浏览器（Content Browser）**资产树中，转至**C++ Classes**文件夹，右键点击**DartLauncher**类，并创建新的蓝图类。

将其命名为`BP_DartLauncher`。 在**FirstPerson > Blueprints**文件夹中，创建名为**Tools**的新文件夹，用于存储可装备物品，然后完成蓝图创建。

在蓝图的 **细节（Details）**面板中国，设置以下默认属性：

1. 将**第一人称工具动画（First Person Tool Anim）**设置为`ABP_FP_DartLauncher`。
2. 将**第三人称工具动画（Third Person Tool Anim）**设置为`ABP_TP_Pistol`。
3. 将**工具映射上下文（Tool Mapping Context）**设置为`IMC_DartLauncher`。

> [!NOTE]
> 如果你只能看到蓝图的"细节（Details）"面板，而看不到包含事件图表和"组件（Components）"选项卡的完整蓝图编辑器，请在窗口顶部附近提示信息中，点击**打开完整蓝图编辑器（Open Full Blueprint Editor）**。

在**组件（Components）**选项卡中，选择**工具网格体组件（Tool Mesh Component）**，并将**骨架网格体资产（Skeletal Mesh Asset）**设置为`SKM_Pistol`。

### 创建飞镖发射器数据资产

要创建数据资产以存储该蓝图数据，请执行以下步骤：

1. 在内容浏览器的**FirstPerson > Data**文件夹中，创建新数据资产，并选择**可装备工具定义（Equippable Tool Definition）**作为数据资产实例。 将该资产命名为`DA_DartLauncher`。
2. 在`DA_DartLauncher`内部，在**细节（Details）**面板中，设置以下属性：

   - 将**工具资产（Tool Asset）**设置为`BP_DartLauncher`。
   - 将**ID**设置为**tool_001**。
   - 将**物品类型（Item Type）**设置为**工具（Tool）**。
   - 将**世界网格体（World Mesh）**设置为`SM_Pistol`。
3. 输入**名称**和**描述**。
4. 保存数据资产。

### 创建工具数据表

尽管此工具可以放入DT_PickupData表中，但建立数据表更有利于追踪特定内容。 例如，你可以为特定类可装备的物品创建不同的表格，或为不同敌人被击败时掉落的物品创建表格。 在本教程中，你将创建一个消耗品表和一个工具表。

要创建新数据表以追踪工具物品，请执行以下步骤：

1. 在**内容浏览器（Content Browser）**中，转至**FirstPerson > Data**文件夹，创建新**数据****表**。
2. 选择**ItemData**作为行结构。
3. 将表命名为**DT_ToolData**，然后双击打开。
4. 在DT_ToolData内部，点击**添加（Add）**为飞镖发射器创建新行。
5. 选中新行后，设置以下字段：

   - 将**行名称（Row Name）**和ID设置为**tool_001**。
   - 将**物品类型（Item Type）**设置为**工具（Tool）**。
   - 将**物品基础（Item Base）**设置为`DA_DartLauncher`。
6. 保存并关闭数据表。

## 在游戏中测试飞镖发射器拾取物

你已修改拾取物类以向用户授予物品，已创建可装备物品类以向玩家提供新网格体、动画和控制，并已设置飞镖发射器工具。 现在该将所有内容整合在一起，创建一个游戏内拾取物，用于触发本教程中已设置的可装备物品逻辑。

在**内容浏览器（Content Browser）**中，转至**Content > FirstPerson > Blueprints**，将新的`BP_PickupBase`拖入关卡。 将**拾取物项目ID（Pickup Item ID）**设置为**tool_001**，并将**拾取物数据表（Pickup Data Table）**设置为`DT_ToolData`。

点击**播放（Play）**测试游戏。 游戏开始时，拾取物应初始化为飞镖发射器。 当你穿过拾取物时，你的角色应开始握持该工具！

## 下一步

在最后一节中，你将在飞镖发射器中实现发射物物理效果，使其能发射泡沫飞镖！

- [实现发射物](../coder-08-implement-a-projectile/index.md) - 学习使用C++实现发射物并在Gameplay过程中生成发射物。

## 完整代码

C++

ItemDefinition.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "ItemData.h"
#include "ItemDefinition.generated.h"

/**
*	Defines a basic item with a static mesh that can be built from the editor.
```

C++

EquippableToolDefinition.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "ItemDefinition.h"
#include "EquippableToolDefinition.generated.h"

class AEquippableToolBase;
class UInputMappingContext;
```

C++

EquippableToolDefinition.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "EquippableToolDefinition.h"

UEquippableToolDefinition* UEquippableToolDefinition::CreateItemCopy() const
{
	UEquippableToolDefinition* ItemCopy = NewObject<UEquippableToolDefinition>(StaticClass());

	ItemCopy->ID = this->ID;
	ItemCopy->ItemType = this->ItemType;
```

C++

InventoryComponent.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "InventoryComponent.generated.h"

class UEquippableToolDefinition;
```

C++

DartLauncher.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "AdventureGame/EquippableToolBase.h"
#include "DartLauncher.generated.h"

UCLASS(BlueprintType, Blueprintable)
class ADVENTUREGAME_API ADartLauncher : public AEquippableToolBase
```

N

C++

DartLauncher.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "DartLauncher.h"
#include "AdventureGame/AdventureCharacter.h"

void ADartLauncher::Use()
{
	GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Using the dart launcher!"));

}
```

N

C++

EquippableToolBase.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "EquippableToolBase.generated.h"

class AAdventureCharacter;
class UInputAction;
```

C++

EquippableToolBase.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.


#include "EquippableToolBase.h"
#include "AdventureCharacter.h"

AEquippableToolBase::AEquippableToolBase()
{
	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
```

C++

AdventureCharacter.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Camera/CameraComponent.h"
#include "EnhancedInputComponent.h"
#include "EnhancedInputSubsystems.h" 
#include "GameFramework/Character.h"
#include "InputActionValue.h"
```

C++

AdventureCharacter.cpp

```
// Copyright Epic Games, Inc. All Rights Reserved.

#include "AdventureCharacter.h"
#include "EquippableToolBase.h"
#include "EquippableToolDefinition.h"
#include "ItemDefinition.h"
#include "InventoryComponent.h"

// Sets default values
AAdventureCharacter::AAdventureCharacter()
```

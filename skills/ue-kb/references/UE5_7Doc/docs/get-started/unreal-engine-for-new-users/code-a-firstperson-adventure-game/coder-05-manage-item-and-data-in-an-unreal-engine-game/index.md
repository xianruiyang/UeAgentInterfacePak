---
title: "管理物品和数据"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-05-manage-item-and-data-in-an-unreal-engine-game"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "管理物品和数据"]
---

# 管理物品和数据

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 管理物品和数据

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-05-manage-item-and-data-in-an-unreal-engine-game

## 开始之前

确保拥有一个基于C++的虚幻引擎项目。

> [!NOTE]
> 本页面内容承接 [添加第一人称摄像机、网格体和动画](../coder-04-adding-a-firstperson-camera-mesh-and-animation/index.md) 一文；不过，如果你只是想了解数据驱动型Gameplay，那么你可以独立完成本节内容，而无需参考 [编写第一人称冒险游戏](../index.md) 教程系列的其他内容。

## 游戏中的数据组织

如何组织和呈现数据是游戏设计的重要一环。 可交互物品可能具有截然不同的特性，它们既可以存在于游戏中，也可以仅仅作为一段数据而存在。 你可以为每种物品类型创建单独的类和蓝图来呈现这些数据，从而在不同的Actor之间分发并传递数据。 然而，随着游戏规模的扩大和存储数据的增加，这种方法会变得效率低下。

更好的方法是采用 **数据驱动型Gameplay**。 你无需对数值进行硬编码，而是使用游戏系统管理的位置集中组织数据。 数据驱动型Gameplay让你能够在需要时才加载所需的数据。 例如，许多游戏会使用电子表格文档来组织对话，因为对于系统而言，提取某条对白远比在每个角色中存储数百条对白要容易得多。

在本节中，你将学习如何使用这种方法来创建自定义物品。

### 数据驱动型Gameplay元素

在开始编译基础物品前，请务必理解什么是"物品"。 既然物品可以是玩家与之交互的任何东西，因此它应该具备一组最基本的属性，而这些属性应该适用任何类型的物品。 你需要在**物品数据结构体（Item Data Struct）**中设置这些属性。 你还应该使用一个集中的区域来组织和显示这些物品数据。 为此，你需要使用**数据表（Data Table）**资产。

物品数据结构体就像一个模板，它可定义你的物品所拥有的数据类型，而数据表和**数据资产**会根据你的结构体来存储实际的数据条目。

下方图表展示了你将在此小节教程中创建的四种数据驱动型Gameplay元素。 设置好这四种元素后，你需要更详细地回顾这张图表，以帮助你总结你所编译的内容。

首先请创建两个文件来定义你的物品数据：

- `ItemData.h`：物品数据结构体的容器（`FItemData`）声明。
- `ItemDefinition.h`：一个继承自`UDataAsset` 的类，有了它，你就可以在虚幻编辑器中使用这些物品数据。

物品数据结构体不继承自`UObject`，不能在关卡中实例化，因此你还需要数据资产类才能在编辑器中使用和引用。

然后，在虚幻编辑器中，你需要根据`ItemDefinition`创建一份数据表和一个数据资产实例。

## 定义物品数据

物品数据结构体定义了数据表中各个物品应具有的数据或属性，其作用类似于表格的列。

物品数据结构体有以下属性：

- **ID**：物品的唯一名称，在后续引用表行时很有用。
- **物品类型（Item Type）**：此物品的类型。在本例中，你将定义工具（Tool）和消耗品（Consumable）类型。
- **物品文本（Item Text）**：关于物品的文本数据，包括名称和描述。
- **物品基础（Item Base）**：与此物品关联的ItemDefinition数据资产。

> [!TIP]
> 如果你想创建自己的数据表字段（列），请记住，数据表字段可以是任何兼容`UPROPERTY()`的类型。

### 创建结构体的头文件容器

请设置一个新文件夹和新的头文件（`.h`）来存储你的物品数据结构体定义。

> [!NOTE]
> 你可以在`ItemDefinition.h`内部创建`FItemData`结构体，但将结构体放在单独的文件中有助于数据元素的组织，同时还允许复用。

要为物品数据结构体设置头文件作为容器，请执行以下步骤：

1. 打开虚幻编辑器，转到**工具（Tools）** > **新C++类（New C++ Class）**。
2. 转到**选择父类（Choose Parent Class）**窗口，选择**无（None）**作为父类，然后点击**下一步（Next）**。
3. 点击**路径（Path）**旁的文件夹图标。 转到你的`Source/[项目名称]`文件夹，新建一个名为`Data`的文件夹，以存储该类。
4. 将类命名为 `ItemData`，然后点击 **创建类（Create Class）**。
5. 如果虚幻引擎未能自动打开你的新类文件，请在Visual Studio中打开你的项目和 `ItemData.h` 文件。
6. 删除 `ItemData.cpp`中的所有文本，然后保存并关闭文件。 你不会用到这些东西。
7. 转到`ItemData.h`文件，删除 `#include "CoreMinimal.h"` 行之下的所有内容。

   > [!NOTE]
   > `CoreMinimal.h` 头文件包含了诸如 `FName`和 `FString`这样的基本类型，以及定义数据所需的其他类型。
8. 转到`ItemData.h`的顶部，添加 `#pragma once` 以及下列include语句：

   - `#include "Engine/DataTable.h"`：从`FTableRowBase`继承结构体所必需。
   - `#include "ItemData.generated.h"`：虚幻头文件分析工具必需项。 请确保此include语句排在代码末尾，以保证代码能够正确编译。

   C++

   ```
   #pragma once #include "CoreMinimal.h"#include "Engine/DataTable.h"#include "ItemData.generated.h"
   ```
9. 为名为`UItemDefinition`的类添加一个前置声明。 这将是你可在编辑器中使用的数据资产。

   C++

   ```
   class UItemDefinition;
   ```

### 定义物品属性

目前尚不存在针对物品类型和文本数据的变量类型，因此你需要定义这些类型。

要定义物品类型枚举，请执行以下步骤：

1. 创建一个新的 `枚举类`，列出所有可能的物品类型。 在本教程中，你需要创建工具（Tool）类和消耗品（Consumable）类型的物品。
2. 将枚举类命名为 `EItemType`，并将其类型设为 `uint8`。 在它上面添加 `UENUM()` 宏，以向虚幻头文件分析工具声明此枚举。

   C++

   ```
   // Defines the type of the item.UENUM()enum class EItemType : uint8{};
   ```
3. 为此枚举添加两个自定义值：

   - `Tool`，添加一个 `UMETA()` 宏，并设 `DisplayName = "Tool"`
   - `Consumable`，添加一个 `UMETA()` 宏，并设 `DisplayName = "Consumable"`

   C++

   ```
   // Defines the type of the item.UENUM()enum class EItemType : uint8{	Tool UMETA(DisplayName = "Tool"),	Consumable UMETA(DisplayName = "Consumable")};
   ```

> [!TIP]
> 这些物品类型是自定义的，并非虚幻引擎所内置；所以只要你掌握了基础知识，就可以制作任何你喜欢的物品！ （比如 `QuestItem`、 `Currency`或 `Disguise`？）

要定义一个物品文本结构体，请执行以下步骤：

1. 在 `EItemType`之后，使用 `USTRUCT()`宏创建一个名为 `FItemText`的新结构体。 此结构体包含了关于物品的文本数据。

   C++

   ```
   // Contains textual data about the item.USTRUCT()struct FItemText{};
   ```
2. 在 `FItemText`内部，添加 `GENERATED_BODY()` 宏。
3. 然后，添加两个名为 `Name` 和 `说明` 的 `FText` 属性，用于存储此物品的名称和描述。 为每个属性添加 `UPROPERTY()` 宏，并将 `EditAnywhere` 作为参数。

   C++

   ```
   // Contains textual data about the item.
   USTRUCT()
   struct FItemText
   {
   	GENERATED_BODY()

   	// The text name of the item.
   	UPROPERTY(EditAnywhere)
   	FText Name;
   ```

### 创建物品数据结构体

现在你已经添加了所需的先决声明，接下来请创建一个包含了物品属性的物品数据结构体。 这些属性将成为数据表中的字段。

定义一个名为`FItemData`的结构体，它继承自`FTableRowBase`。 添加`public`说明符，使其在所有地方可见，并为虚幻头文件分析工具添加`GENERATED_BODY()`。

C++

```
// Defines a basic item that can be used in a data table.USTRUCT()struct FItemData : public FTableRowBase{	GENERATED_BODY()};
```

> [!TIP]
> `FTableRowBase`是虚幻引擎提供的基础结构体，它让你可以在数据表资产中使用自定义的`USTRUCT`。 虚幻引擎使用它来了解如何序列化你的行结构体、用它支持从CSV/JSON文件导入和导出数据，以及用它确保从表中提取数据时的类型安全性。

在`FItemData`结构体中，添加以下声明：

- 一个名为`ID`的`FName`。 数据表中的每一行都需要一个关联的`FName`来进行引用。
- 一个名为`ItemType`的`EItemType枚举`。 这是你之前声明的物品类型的枚举。
- 一个名为`ItemText`的`FItemText`结构体。 这是你之前声明的文本数据的结构体。

为每个声明添加`UPROPERTY()`宏，并设`EditAnywhere`和`Category = "Item Data"`参数。

C++

```
// The ID name of this item for referencing in a table row.
UPROPERTY(EditAnywhere, Category = "Item Data")
FName ID;

// The type of the item.
UPROPERTY(EditAnywhere, Category = "Item Data")
EItemType ItemType;
	
// Text struct including the item name and description.
UPROPERTY(EditAnywhere, Category = "Item Data")
```

再添加一个声明：一个指向`TObjectPtr`的`UItemDefinition`，名为`ItemBase`。 为其使用与结构体中其他属性相同的`UPROPERTY`宏。

C++

```
// The Data Asset item definition associated with this item.UPROPERTY(EditAnywhere, Category = "Item Data")TObjectPtr<UItemDefinition> ItemBase;
```

`TObjectPtr`是虚幻引擎中的一种智能指针类型，能更为安全地引用`UObject`派生类型。 它是一种原始`UObject`指针的替代品，支持编辑器感知、对垃圾回收安全。 它是一种硬引用，因此会在运行时保持对象加载。

在下一步中，你将创建一个名为`ItemDefinition`的`UDataAsset`类。 在你的数据表中，你将使用`ItemBase`字段来引用`ItemDefinition Data Asset`的实例。

你的`FItemData`结构体应该如下所示：

C++

```
// Defines a basic item that can be used in a data table.
USTRUCT()
struct FItemData : public FTableRowBase
{
	GENERATED_BODY()

	// The ID name of this item for referencing in a table row.
	UPROPERTY(EditAnywhere, Category = "Item Data")
	FName ID;
```

保存你的代码。

## 编译DataAsset物品定义

到目前为止，你已经定义了物品数据，即出现在你的数据表中的数据类型。 接下来，你将实现在`ItemData.h`中前置声明的`UItemDefinition`类。

这个类继承自`UDataAsset`，因此是一个`UObject`，这意味着你可以直接在编辑器中创建和使用其实例，而无需编写代码。 你将用`UItemDefinition`类的实例填充你的数据表。

要创建你的 `ItemDefinition` DataAsset类（`ItemDefinition.h`），请执行以下步骤：

1. 打开虚幻编辑器，转到**工具（Tools）** > **新C++类（New C++ Class）**。
2. 转到**选择父类（Choose Parent Class）**窗口，点击**所有类（All Classes）**。
3. 搜索并选择**DataAsset**作为父类，然后点击**下一步（Next）**。
4. 将类命名为`ItemDefinition`（匹配你在`ItemData.h`中所做的前置声明），然后点击**创建类（Create Class）**。

VS应该会自动打开你的新类的`.h`和`.cpp`文件。 如果没有自动打开，请刷新VS并手动打开这些文件。 你只需在`.h`文件中进行操作，因此可以在必要时关闭`.cpp`文件。

在`ItemDefinition.h`中，添加对`ItemData.h`的include语句，因为你需要复用之前在该文件中声明的`ItemType`和`ItemText`属性。

C++

```
#include "CoreMinimal.h"#include "Data/ItemData.h"#include "ItemDefinition.generated.h"
```

转到`ItemDefinition.h`，在类定义上方的`UCLASS()`宏中，添加`BlueprintType`和`Blueprintable`说明符，以将其作为创建蓝图的基类公开。

C++

```
// Defines a basic item with a static mesh that can be built from the editor.UCLASS(BlueprintType, Blueprintable)class FIRSTPERSON_API UItemDefinition : public UDataAsset{	GENERATED_BODY()	public:	// Default constructor for the class.	UItemDefinition();};
```

转到public小节，从`ItemData.h`中复制`FName ID`、`EItemType ItemType`和`FItemText ItemText`声明。

你的物品定义与`FItemData`结构体具有相同的数据，因此当你想获取关于物品的信息时，无需引用原表。

C++

```
public:

	// The ID name of this item for referencing in a table row.
	UPROPERTY(EditAnywhere, Category = "Item Data")
	FName ID;

	// The type of this item.
	UPROPERTY(EditAnywhere, Category = "Item Data")
	EItemType ItemType;
```

在`ItemText`之后，声明一个名为`WorldMesh`的`UStaticMesh`类型`TSoftObjectPtr`。 你将使用此静态网格体在世界中显示此物品。

> [!TIP]
> `TSoftObjectPtr` 是一种特殊类型的弱指针，它会作为资产路径的字符串表现形式，仅在需要时加载。 通常，当声明一个引用资产的 `UObject` 指针属性时，资产会在包含该属性的对象被加载时加载。 这可能会导致在游戏启动时加载所有资产，从而造成巨大的开销和卡顿。对于网格体一类应按需加载的大型资产而言，`TSoftObjectPtr` 非常有用。 如需更多信息，请参阅 [资产异步加载](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/asynchronous-asset-loading/index.md)。

为该属性添加相同的`UPROPERTY(EditAnywhere, Category = "Item Data")`宏。

C++

```
// Text struct including the item name and description.UPROPERTY(EditAnywhere, Category = "Item Data")FItemText ItemText; // The Static Mesh used to display this item in the world.UPROPERTY(EditAnywhere, Category = "Item Data")TSoftObjectPtr<UStaticMesh> WorldMesh;
```

> [!TIP]
> 数据表的行类似于CSV行，旨在承载文本数据，而不是保存完整的资产。 为优化数据管理，建议将物品的网格体、材质和动画等信息捆绑在一个DataAsset中，因为这才是单个特定物品的所有数据的集中存放地。 因此，物品的静态网格体属性位于`UItemDefinition`中，而不是`FItemData`结构体中。

完整的`UItemDefinition`类应该如下所示：

C++

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Data/ItemData.h"
#include "ItemDefinition.generated.h"

/**
*	Defines a basic item with a static mesh that can be built from the editor.
```

保存你的代码并在Visual Studio中编译。

## 创建数据资产实例

在定义了物品数据（来自`ItemData.h`的`FItemData`结构体）和物品定义（`UItemDefinition`类）后，你就拥有了编译物品实例和数据表所需的一切要素。

首先，请为新的发射型拾取物创建一个数据资产，然后创建一个数据表，并使用数据资产的信息填充数据表。

要使用你的`ItemDefinition`类创建数据资产物品，请执行以下步骤：

1. 打开**内容浏览器**，转到**Content** > **FirstPerson**文件夹，点击**添加（Add）**或在**资产视图**的空白区域点击右键，选择**新建文件夹（New Folder）**，并将其命名为 `Data`。

   这将是你存储和组织游戏内数据资产的位置。
2. 转到`Data`文件夹，点击**添加（Add）** 或在资产视图的空白区域点击右键，选择**杂项（Miscellaneous）** > **数据资产（Data Asset）**。

   > [!NOTE]
   > 请务必选择带有饼状图图标的数据资产（Data Asset）选项。
3. 转到**为数据资产实例选择类（Pick Class For Data Asset Instance）**窗口，选择**物品定义（Item Definition）**（即你之前定义的C++类），然后点击**选择（Select）**。 将新的数据资产命名为`DA_Pickup_001`。
4. 双击`DA_Pickup_001`以将其打开。 在其**细节（Details）**面板中，你将看到在`ItemDefinition.h`中定义的所有属性。
5. 输入`pickup_001`作为**ID**。
6. 将**物品类型（Item Type）**设为**消耗品（Consumable）**。
7. 展开 物品文本（Item Text） 并任意输入 名称（Name） 和 描述（Description）。
8. 将**世界网格体（World Mesh）**设为`SM_FoamBullet`。
9. 点击窗口左上角附近的**保存**图标以保存你的数据资产。

## 定义数据表格

现在你已经拥有了至少一份可以用来填充数据表的数据资产，那就可以创建数据表了！

数据表中的每一行都是你的ItemData结构体的一个填充实例。

要创建数据表，请执行以下步骤：

1. 打开**内容浏览器**，转到 `Data`文件夹，右键点击空白区域，然后选择**杂项（Miscellaneous）** > **数据表（Data Table）**。
2. 转到**选择行结构（Pick Row Structure）**窗口，选择**ItemData**（你在`ItemData.h`中定义的`FItemData`结构体），然后点击**确定（OK）**。
3. 将新的表格命名为`DT_PickupData`，然后双击将其打开。

数据表最初是空的。 不过，你会看到你在`FItemData`中定义的属性作为标题列在表格顶部，还有一个名为**行名称（Row Name）**的额外列。

要将拾取物数据资产作为行添加到表格中，请执行以下步骤：

1. 点击**添加（Add）**为表格新添加一行。 数据表编辑器会在**数据表（Data Table）**选项卡左上角的面板中列出行的条目。
2. 双击`NewRow`行名称，并将其更改为`pickup_001`（即你的数据资产的ID）。

   > [!TIP]
   > 你可以使用任意 `FName`作为**行名称（Row Name）**；不过，为了在代码中更方便地引用该行，请使行名称与数据资产的ID相同。
3. 转到**行编辑器（Row Editor）**面板，为**ID**、**物品类型（Item Type）**和**物品文本（Item Text）**字段输入你在`DA_Pickup_001`数据资产中所设的相同值。
4. 将**物品基础（Item Base）**设为你的`DA_Pickup_001`数据资产。
5. 保存数据表。

大功告成！ 再次查看你在这一步中创建的数据驱动型Gameplay元素图表，看看它们是如何相互关联的：

你已经创建了一个数据表，该数据表的列来自你的`FItemData`结构体。 你用一行数据填充了该表，这行数据包含了你所创建的消耗品（Consumable）类型的`ItemDefinition`数据资产实例中的数据，并使用`ItemBase`指针来引用该数据资产本身。 最后，你的数据资产实例从你创建的父项`UItemDefinition`数据资产类中获取了其属性。

## 下一步

在下一节中，你将学习如何扩展此物品定义以创建自定义拾取类，并将其在关卡中实例化。

- [创建可重新生成的拾取物](../coder-06-create-a-respawning-pickup-item/index.md) - 了解如何使用C++创建自定义拾取物并将其在关卡中初始化。

## 完整代码

C++

ItemData.h

```
#pragma once

#include "CoreMinimal.h"
#include "Engine/DataTable.h"
#include "ItemData.generated.h"

class UItemDefinition;

/**
*	Defines the type of the item.
```

C++

ItemDefinition.h

```
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Data/ItemData.h"
#include "ItemDefinition.generated.h"

/**
*	Defines a basic item with a static mesh that can be built from the editor.
```

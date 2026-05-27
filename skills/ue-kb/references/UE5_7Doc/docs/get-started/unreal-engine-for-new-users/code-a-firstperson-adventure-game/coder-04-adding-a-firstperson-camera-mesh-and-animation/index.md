---
title: "添加第一人称摄像机、网格体和动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coder-04-adding-a-firstperson-camera-mesh-and-animation"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "虚幻引擎新用户指南", "编写第一人称冒险游戏", "添加第一人称摄像机、网格体和动画"]
---

# 添加第一人称摄像机、网格体和动画

> 路径：虚幻引擎5.7文档 / 入门指南 / 虚幻引擎新用户指南 / 编写第一人称冒险游戏 / 添加第一人称摄像机、网格体和动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coder-04-adding-a-firstperson-camera-mesh-and-animation

## 开始之前

请确保你已经完成了上一节 [配置角色移动](../coder-03-configure-character-movement-with-cplusplus/index.md) 中的以下目标：

- 理解输入操作和输入映射上下文的工作原理。
- 设置角色的前后左右移动以及跳跃移动。

## 第一人称摄像机的控制

要更改摄像机的方向，我们需要更改摄像机**变换（Transform）**属性的**旋转（Rotation）**值。 要在3D空间中旋转，对象会使用**俯仰（Pitch）**、**滚动（Roll）**和**偏转（Yaw）**来控制自身转动的方向以及绕哪个轴转动。

- **俯仰（Pitch）**：控制沿水平（X）轴的旋转。 更改此值会使对象向上或向下旋转，类似于点头。
- **偏转（Yaw）**：控制沿垂直（Y）轴的旋转。 更改此值会使对象向左或向右旋转，类似于向左或向右转。
- **滚动（Roll）**：控制沿纵向（Z）轴的旋转。 更改此值会使对象左右滚动，类似于将头 向左或向右倾斜。

第一人称游戏中的摄像机通常使用偏转和俯仰来控制移动。 如果你正在编写一款游戏，需要让飞机或宇宙飞船旋转，或者需要模拟从角落窥视的场景，那么你可能还会用到滚动（Roll）。

### 探索蓝图中的摄像机移动

打开`BP_FirstPersonCharacter`，查看**蓝图编辑器**中默认角色的摄像机控制逻辑。 在**事件图表（EventGraph）**中，查看**Camera Input**节点组左上角的两个节点。

就像`IA_Move`一样，`IA_Look`输入操作也有一个 **Axis2D值类型（Axis2D Value Type）**，因此它会将移动拆分为**X**值和**Y**值。 此时，X和Y成为自定义**Aim**函数的**偏转（Yaw）**和**俯仰（Pitch）**输入。

双击**Aim**函数节点以查看内部逻辑。 **Add Controller Yaw Input**和**Pitch Input**函数节点会将值添加到角色。

### 探索第一人称角色组件

转到`BP_FirstPersonCharacter`的**视口（Viewport）**选项卡，即可查看该Actor及其组件的3D预览。

在**组件（Components）**选项卡中，你会看到附加组件的结构化层级，而这些组件定义了该角色在世界中的形态。

角色蓝图会使用以下内容自动实例化：

- 一个**胶囊体组件（Capsule Component）**，该组件让角色能够与世界中的对象发生碰撞。
- 一个**骨骼网格体（Skeletal Mesh）**组件，用于实现动画效果并可视化角色。 在**细节（Details）**面板中，你会看到此角色使用`SKM_Manny_Simple`作为其**骨骼网格体资产（Skeletal Mesh Asset）**。
- 一个**角色移动组件（Character Movement Component）**，该组件让角色可以四处移动。

此角色还有第二份**骨骼网格体**（名为**FirstPersonMesh**，同样使用`SKM_Manny_Simple`），它是主网格体组件的子项。 在第一人称游戏中，角色通常会为第三人称和第一人称上下文分别设置不同的网格体。 第三人称网格体仅对其他玩家可见，或者当玩家处于第三人称视角时可见。 第一人称网格体在玩家处于第一人称视角时对玩家可见。

**FirstPersonMesh**拥有一个名为**FirstPersonCamera**的子项**摄像机组件**。 这个摄像机决定了玩家的第一人称视角，并会随着角色环顾四周而旋转。 在本教程的这一部分，你将使用C++在运行时为角色实例化一个摄像机，并为该摄像机设置匹配此摄像机的位置。

如需详细了解角色组件，请参阅[角色Gameplay框架](../../../../gameplay-systems/gameplay-framework/pawn/characters/index.md)文档。

## 在代码中实现观察输入

要在代码中实现此摄像机的功能（就像你在上一步中实现的移动功能一样），你需要将`IA_Look`输入操作绑定到一个函数上，然后将该函数绑定到你的角色上。

### 声明Look()函数和变量

在Visual Studio中打开角色的`.h`文件。

> [!NOTE]
> 本教程中的示例代码使用的角色类名称为`AdventureCharacter`。

当你的角色在运行时编译时，你需要让虚幻引擎为其添加一个摄像机组件，并动态地定位该摄像机。 要启用此功能，请为`"Camera/CameraComponent.h"`添加一个新的`#include`：

C++

```
#include "CoreMinimal.h"#include "Camera/CameraComponent.h"#include "GameFramework/Character.h"#include "EnhancedInputComponent.h"#include "EnhancedInputSubsystems.h" #include "InputActionValue.h"#include "AdventureCharacter.generated.h"
```

在头文件的`protected` 小节中，声明一个名为`LookAction`的新`UInputAction`指针。 为该指针赋予与`MoveAction`和`JumpAction`相同的`UPROPERTY()`宏。 这将指向`IA_Look`输入操作。

C++

```
// Look Input ActionsUPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Input)UInputAction* LookAction;
```

在`public` 小节中，声明一个名为`Look()`的新函数，该函数将接受一个名为`Value`的常量`FInputActionValue`引用。 请确保为该函数添加一个`UFUNCTION()`宏。

C++

```
// Handles Look InputUFUNCTION()void Look(const FInputActionValue& Value);
```

在声明`Look()`函数后，再声明一个名为`FirstPersonCameraComponent`的新`UCameraComponent`指针。 要将此属性公开给虚幻编辑器，请添加一个包含`VisibleAnywhere`和`Category = Mesh`参数的`UPROPERTY()`宏，从而让其出现在 细节面板 的**摄像机（Camera）**分段中。

C++

```
// First Person cameraUPROPERTY(VisibleAnywhere, Category = Camera)UCameraComponent* FirstPersonCameraComponent;
```

声明一个名为`FirstPersonCameraOffset`的`FVector`。 设置角色时，你将使用此偏移来将摄像机定位到合适的位置。 请使用以下值以及`EditAnywhere`和`Category = Camera`宏将其初始化为`FVector`，以便在需要时在虚幻编辑器中对其进行调整。

C++

```
// Offset for the first-person cameraUPROPERTY(EditAnywhere, Category = Camera)FVector FirstPersonCameraOffset = FVector(2.8f, 5.9f, 0.0f);
```

你还需要再添加几个属性来调整近景物体（比如角色的身体）在摄像机视图中的显示效果。 为此请声明如下两个 `float` 变量：

- `FirstPersonFieldOfView`：此摄像机在渲染带有`FirstPerson`标签的图元组件时应使用的水平视场视野（角度）。 设为 `70.0f`。
- `FirstPersonScale`：此摄像机应对带有 `FirstPerson` 标签的图元组件应用的比例。 设为 `0.6f`。

> [!TIP]
> `UPrimitiveComponent`是在世界中实际存在的所有组件的基类。 例如，网格体组件和胶囊体组件就是图元组件的类型。

为这些属性添加配有 `EditAnywhere` 和 `Category = Camera` 说明符的 `UPROPERTY()` 宏。

C++

```
// First-person primitives field of viewUPROPERTY(EditAnywhere, Category = Camera)float FirstPersonFieldOfView = 70.0f; // First-person primitives view scaleUPROPERTY(EditAnywhere, Category = Camera)float FirstPersonScale = 0.6f;
```

> [!NOTE]
> 这些摄像机组件设置让虚幻引擎能够以不同于图元在世界中其他地方呈现的方式为玩家渲染带**FirstPerson**标签的图元，从而优化它们在第一人称视角下的外观和行为。
>
> 在游戏中采用较宽的视野可能会使靠近摄像机的对象（例如玩家手臂或持有的物品）看起来过大或被拉伸，因此为这些对象缩小**视野**可以缓解这种失真效果。 缩小这些对象的**比例**也可以防止它们与墙壁发生穿模。
>
> 如需详细了解如何控制第一人称和第三人称对象向玩家呈现的方式，请参阅[第一人称渲染](../../../../designing-visuals-rendering-and-graphics/general-features-of-rendering/first-person-rendering/index.md)专题文档。

最后，声明一个名为`FirstPersonMeshComponent`的新`USkeletalMeshComponent`指针。 为其添加附带`VisibleAnywhere`和`Category = Inventory`参数的`UPROPERTY()`宏。

C++

```
// First-person mesh, visible only to the owning playerUPROPERTY(VisibleAnywhere, Category = Mesh)USkeletalMeshComponent* FirstPersonMeshComponent;
```

你现在为如下项目设置了声明：

- 第一人称网格体（对应你在蓝图中所见的**FirstPersonMesh**子项）
- 摄像机
- `Look()`函数
- `IA_Look`输入操作

角色的`.h`文件现在应该如下所示：

C++

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

### 使用Look()添加观察输入

打开角色的`.cpp`文件以使用`Look()`函数实现角色蓝图的摄像机输入逻辑。

就和`IA_Move`一样，`IA_Look`也会在被触发时返回一个FVector2D值。 为`Look()`函数添加一个新的函数定义。 在该函数内部，在名为`LookAxisValue`的新`FVector2D`中获取`FInputActionValue`的值。

C++

```
void AAdventureCharacter::Look(const FInputActionValue& Value){	const FVector2D LookAxisValue = Value.Get<FVector2D>();}
```

接下来，在`if`语句中，检查控制器是否有效。

如果有效，则调用`AddControllerYawInput()`和`AddControllerPitchInput()`函数，并分别传入`LookAxisValue.X`和`LookAxisValue.Y`的值。 完整的`Look()`函数应该如下所示：

C++

```
void AAdventureCharacter::Look(const FInputActionValue& Value){	const FVector2D LookAxisValue = Value.Get<FVector2D>(); 	if (Controller)	{		AddControllerYawInput(LookAxisValue.X);		AddControllerPitchInput(LookAxisValue.Y);	}}
```

### 使用SetupPlayerInputComponent将观察功能绑定至输入

在`SetupPlayerInputComponent()`内部（与移动操作类似），你需要将`Look()`函数绑定到`LookAction`输入操作。

C++

```
EnhancedInputComponent->BindAction(LookAction, ETriggerEvent::Triggered, this, &AAdventureCharacter::Look);
```

你的`SetupPlayerInputComponent()`函数应如下所示：

C++

```
// Called to bind functionality to input
void AAdventureCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
{
	// Check the UInputComponent passed to this function and cast it to an UEnhancedInputComponent
	if (UEnhancedInputComponent* EnhancedInputComponent = CastChecked<UEnhancedInputComponent>(PlayerInputComponent))
	{
		// Bind Movement Actions
		EnhancedInputComponent->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AAdventurenCharacter::Move);

		// Bind Look Actions
```

保存代码，并点击**编译（Build）**以在Visual Studio中进行编译。

### 在蓝图中分配查看输入操作

最后，将一个输入操作分配给角色蓝图的新**查看操作（Look Action）**属性。

要将查看控制分配给你的角色，请执行以下步骤：

1. 在虚幻编辑器中打开角色蓝图。
2. 在**组件（Components）**面板中，确保已选择`BP_[CharacterName]`根组件。
3. 在**细节（Details）**面板的**输入（Input）**分段中，将**查看操作（Look Action）**设置为`IA_Look`。
4. 编译并保存蓝图。

### 测试观察的移动情况

按下**运行（Play）**按钮即可测试你的游戏，这时你将能够环顾四周，并朝任意方向移动你的角色！

请注意，虽然你的游戏内视角看起来像是来自于第一人称摄像机，但实际上，这时你的角色身上还没有摄像机组件。 相反地，是虚幻引擎模拟了从角色胶囊体组件中心出发的视角。 在下一步中，你将学习如何为角色类添加摄像机，从而改变这一点。

## 在运行时创建组件

接下来，你将实例化你在头文件中声明的`FirstPersonCameraComponent`和`FirstPersonMeshComponent`指针，从而完成角色的第一人称网格体和摄像机的创建。

首先，打开角色的`.cpp`文件。

在文件顶部，你会看到**类构造函数**（即本教程中的`AAdventureCharacter()`）。 该类会在对象被分配到内存中时运行，并为角色设置默认值。 你将在这里添加额外组件。

> [!NOTE]
> 在为类构造函数或`BeginPlay()`添加代码时，应考虑各函数在Actor生命周期中的执行时间，以及其他对象是否已初始化。
>
> 当类构造函数运行时，其他组件或Actor可能还不存在。 `BeginPlay()` 会在Gameplay开始或Actor生成时运行，因此Actor及其所有组件均已完全初始化和注册，此时引用其他Actor是安全的。
>
> 另外，由于虚幻引擎采用特定的方式在后台处理附件、物理、网络或父子关系的时间安排，某些操作在`BeginPlay()`中执行时会更为可靠，即使从技术上讲，这些操作可以被更早地执行。

### 创建摄像机组件

要为角色添加组件，你需要使用`CreateDefaultSubobject()`模板函数。 该函数会返回一个指向新组件的指针，并使用以下参数：

`CreateDefaultSubobject<type>(TEXT("Name"));`

其中*type*是你正在创建的子对象的类型，*Name*是虚幻引擎用于识别子对象并在编辑器中显示子对象的内部名称。

在类构造函数中，请将`FirstPersonCameraComponent`指针设为调用类型为`UCameraComponent`的`CreateDefaultSubobject()`函数的结果。 在`TEXT`参数中，将对象命名为"FirstPersonCamera"。

C++

```
FirstPersonCameraComponent = CreateDefaultSubobject<UCameraComponent>(TEXT("FirstPersonCamera"));
```

这将创建一个默认的摄像机对象，作为角色类的子对象。接下来，为确保摄像机已被正确实例化，请检查`FirstPersonCameraComponent`是否不为空。

C++

```
// Create a first person camera component.FirstPersonCameraComponent = CreateDefaultSubobject<UCameraComponent>(TEXT("FirstPersonCamera"));check(FirstPersonCameraComponent != nullptr);
```

### 创建网格体组件

为另一个`CreateDefaultSubobject`函数调用设置`FirstPersonMeshComponent`。 这一次，使用`USkeletalMeshComponent`作为类型，并使用"FirstPersonMesh"作为名称。 记得在后面添加一个`check`。

C++

```
// Create a first person mesh component for the owning player.FirstPersonMeshComponent = CreateDefaultSubobject<USkeletalMeshComponent>(TEXT("FirstPersonMesh"));	check(FirstPersonMeshComponent != nullptr);
```

### 附加并配置网格体

现在网格体已创建，请将其附加到角色上并为其启用第一人称渲染。

`SetupAttachment()` 函数可将一个场景组件附加到另一个场景组件上，从而在组件层级中建立父子关系。

请对 `FirstPersonMeshComponent` 所指向的对象调用 `SetupAttachment()` 函数，将父组件传递给它。 在本例中，父组件应该是角色的默认骨架网格体，而你可以使用 `GetMesh()`函数来获取该网格体。

C++

```
// Attach the FirstPerson mesh to the Skeletal MeshFirstPersonMeshComponent->SetupAttachment(GetMesh());
```

你在角色的头文件中声明了针对靠近摄像机的组件时摄像机会采用的视野和缩放比例。 要将这些摄像机属性应用于第一人称网格体，请将网格体的`FirstPersonPrimitiveType`属性设为 `FirstPerson`。

C++

```
FirstPersonMeshComponent->FirstPersonPrimitiveType = EFirstPersonPrimitiveType::FirstPerson;
```

> [!TIP]
> `FirstPerson`类型的图元会在单独的渲染通道中被渲染，通常会使用不同的摄像机参数，因此不会投射阴影。 玩家阴影从第三人称网格体投射时的效果最佳。接下来你将对此进行设置。

### 设置网格体可视性

到目前为止，你的角色拥有第一人称和第三人称骨架网格体，而它们在游戏过程中会重叠。 然而，第一人称网格体应该对其他玩家不可见，而第三人称网格体应该对你（玩家）不可见。

要配置第一人称和第三人称网格体和阴影可视性，请执行以下步骤：

1. 在角色的类构造函数中，当你看到第一人称网格体的图元类型后，请将第三人称网格体组件的`FirstPersonPrimitiveType`设为`WorldSpaceRepresentation`。

   C++

   ```
   GetMesh()->FirstPersonPrimitiveType = EFirstPersonPrimitiveType::WorldSpaceRepresentation;
   ```

   此图元类型针对的是对其他玩家可见的组件。 它会将相关组件的`OwnerNoSee`属性自动设为`false`，使其对所属玩家不可见。 但该网格体仍然会投射阴影。
2. 在 `BeginPlay()` 中，检查全局引擎指针后，请对 `FirstPersonMeshComponent` 调用 `SetOnlyOwnerSee()` 函数，并传入 `true`，以使第一人称网格体仅对其所属的玩家可见。

   C++

   ```
   // Only the owning player sees the first-person meshFirstPersonMeshComponent->SetOnlyOwnerSee(true);
   ```

### 附加摄像机组件

在角色的构造函数中，使用另一个`SetupAttachment()`调用，从而将摄像机组件附加到第一人称网格体上。 这次，你需要添加一个可选的重载项来指定组件应该附加到网格体上的确切位置（即**插槽**）。

本教程中使用的`SKM_Manny_Simple`网格体拥有一套用于动画的预设插槽（或骨骼）。 你可以在代码中使用`FName`字符串来引用插槽。 最好将摄像机放置在角色头部附近，所以你需要将`Head`插槽名称传递给`SetupAttachment`，以此以将摄像机附加到该插槽。 稍后，你需要将摄像机移近到角色的眼部位置。

> [!NOTE]
> `FName`是虚幻引擎所使用的一种特殊类字符串类型，作用是以节省内存的方式存储唯一的、不可变的名称。

C++

```
// Attach the camera component to the first-person Skeletal Mesh.FirstPersonCameraComponent->SetupAttachment(FirstPersonMeshComponent, FName("head"));
```

如需了解插槽以及如何创建插槽，请参阅[骨骼网格体插槽](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-assets-and-features/skeletons/skeletal-mesh-sockets/index.md)。

### 配置摄像机

在初始化摄像机组件时，你将其附加到了角色的头部插槽。 不过，如果将摄像机定位在角色的眼部位置，那么其视野会更准确。 默认情况下，摄像机也是朝下的，因此需要将其旋转到角色头部后方。

要将摄像机移动并旋转到合适位置，请调用`SetRelativeLocationAndRotation()`，同时传入`FirstPersonCameraOffset`和一个被设为`(0.0f, 90.0f, -90.0f)`的新`FRotator`。

C++

```
// Position the camera slightly above the eyes and rotate it to behind the player's headFirstPersonCameraComponent->SetRelativeLocationAndRotation(FirstPersonCameraOffset, FRotator(0.0f, 90.0f, -90.0f));
```

要让摄像机在Gameplay过程中随角色旋转，请将`FirstPersonCameraComponent`的`bUsePawnControlRotation`属性设为`true`。 这会让摄像机继承其父项Pawn的旋转，因此当角色转动时，摄像机也会随之转动。

C++

```
// Enable the pawn to control camera rotation.FirstPersonCameraComponent->bUsePawnControlRotation = true;
```

最后，为摄像机添加第一人称视野和第一人称比例渲染。 将组件的`bEnableFirstPersonFieldOfView`和`bEnableFirstPersonScale`属性设置为`true`。 然后，指定你之前声明的默认视野和比例值。

C++

```
// Enable first-person rendering and set default FOV and scale valuesFirstPersonCameraComponent->bEnableFirstPersonFieldOfView = true;FirstPersonCameraComponent->bEnableFirstPersonScale = true;FirstPersonCameraComponent->FirstPersonFieldOfView = FirstPersonFieldOfView;FirstPersonCameraComponent->FirstPersonScale = FirstPersonScale;
```

角色的构造函数应如下所示：

C++

```
// Sets default values
AAdventureCharacter::AAdventureCharacter()
{
	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it
	PrimaryActorTick.bCanEverTick = true;

	// Create a first person camera component
	FirstPersonCameraComponent = CreateDefaultSubobject<UCameraComponent>(TEXT("FirstPersonCamera"));
	check(FirstPersonCameraComponent != nullptr);
```

保存代码，并点击**编译（Build）**以在Visual Studio中进行编译。

## 在虚幻编辑器中指定网格体

你已设置好了摄像机功能按钮，现在还剩最后一步 — 使用编辑器为你在代码中声明的变量添加骨骼网格体资产。

要为角色蓝图添加骨骼网格体，请执行以下步骤：

1. 在虚幻编辑器中打开角色蓝图（如果尚未打开）。
2. 在 **组件（Components）** 面板中，确保已选择 **BP_*[CharacterName]*** 根组件。
3. 在**细节（Details）**面板的**网格体（Mesh）**分段中，角色拥有两个SkeletalMeshAsset插槽，而不是一个，这是因为你在代码中创建了`FirstPersonMeshComponent`。 点击各个属性的下拉菜单中的箭头，并为两个网格体都选择`SKM_Manny_Simple`。

   当你设置**FirstPersonMeshComponent**时，你的摄像机应该会移动到角色头部后方的位置。
4. 保存你的蓝图并点击**编译（Compile）**。

如果你运行游戏并向下看，你应该能看到角色的第一人称网格体！ 当你环顾四周时，该网格体会随之旋转，而你的摄像机也会匹配此动作。 第三人称网格体在运行时隐藏，只对其他玩家可见。 然而，这时你的角色仍然处于静态的T字姿势，因此接下来你需要使用动画蓝图为角色添加动画，使其栩栩如生！

## 为角色添加动画

在代码中，你可以通过**UAnimInstance**类的实例来访问动画逻辑。此类是一种控制器，它会根据状态和其他变量来决定在骨骼网格体上混合并播放哪些动画。 动画蓝图也派生自`UAnimInstance`，而你可以在C++中使用`UAnimBlueprint`类型来引用动画蓝图。

编译动画实例（Anim Instance）类不在本教程的范围内；相反地，你需要为你的角色添加第一人称模板的预编译动画蓝图。 该蓝图包含了你的角色播放不同移动和闲置动画所需的动画和逻辑。

虚幻引擎中的动画是逐网格体设置的，因此你需要为第一人称和第三人称网格体分别设置动画。 由于在游戏开始时，你的第三人称网格体被隐藏，所以你只需要为第一人称网格体设置动画。

要为你的角色添加动画属性和动画蓝图，请执行以下步骤：

1. 在角色的`.h`文件顶部，前置声明`UAnimBlueprint`类。 此类代表了你项目中的动画蓝图。

   C++

   ```
   class UAnimBlueprint;class UInputMappingContext;class UInputAction;class UInputComponent;
   ```
2. 然后在`public` 小节处，声明一个名为`FirstPersonDefaultAnim`的新`UAnimBlueprint`指针。 为其添加附带`EditAnywhere`和`Category = Animation`的`UCLASS()`宏。

   C++

   ```
   // First Person animationsUPROPERTY(EditAnywhere, Category = Animation)UAnimBlueprint* FirstPersonDefaultAnim;
   ```
3. 在角色的`.cpp`文件中，转到`BeginPlay()`，调用`FirstPersonMeshComponent->SetAnimInstanceClass()`。 即使你尚未在代码中定义Anim Instance类，你也可以使用`GeneratedClass`从动画蓝图中生成一个类。

   C++

   ```
   // Only the owning player sees the first person mesh.FirstPersonMeshComponent->SetOnlyOwnerSee(true); // Set the animations on the first person mesh.FirstPersonMeshComponent->SetAnimInstanceClass(FirstPersonDefaultAnim->GeneratedClass);
   ```
4. 保存你的代码并在Visual Studio中编译。
5. 转到虚幻编辑器，重新打开你的角色蓝图，并选择 **BP_*[CharacterName]*** 根组件。
6. 转到**细节（Details）**面板，在**动画（Animation）**项下，将**第一人称默认动画（First Person Default Anim）**设为`ABP_Unarmed`。
7. 保存你的蓝图并进行编译。

## 测试角色

按下**运行（Play）**来测试你的游戏。 如果你向下看，你会看到 第一人称网格体会随着你的移动而播放动画！ 试着四处移动并跳跃，查看由此蓝图控制的各种动画。

> 动图已省略：683e770a1ad362b0b6b6c116ecd52647112d13953f67aa4fe3a0bcd64b11dc6b

## 下一步

在下一节中，你将学习如何创建物品以供角色拾取和使用！

- [管理物品和数据](../coder-05-manage-item-and-data-in-an-unreal-engine-game/index.md) - 学习使用物品数据结构体、数据资产和数据表来定义物品，并存储和组织物品数据以实现可伸缩性。

## 完整代码

本节中编译的完整代码如下：

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
#include "AdventureCharacter.h"

// Sets default values
AAdventureCharacter::AAdventureCharacter()
{
	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it
	PrimaryActorTick.bCanEverTick = true;

	// Create a first-person camera component
	FirstPersonCameraComponent = CreateDefaultSubobject<UCameraComponent>(TEXT("FirstPersonCamera"));
```

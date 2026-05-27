---
title: "从C++使用Mutable"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-mutable-from-cplusplus-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Mutable骨骼网格体生成", "Mutable开发指南", "从C++使用Mutable"]
---

# 从C++使用Mutable

> 路径：虚幻引擎5.7文档 / 管理内容 / Mutable骨骼网格体生成 / Mutable开发指南 / 从C++使用Mutable

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-mutable-from-cplusplus-in-unreal-engine

你可以使用以下文档了解如何在C++中设置和使用Mutable角色。

## 创建可自定义对象的实例

**CustomizableObjectInstance** 包含 **可自定义对象** 的一组参数值。这些值可供Actor用于创建游戏内的网格体和材质。

要创建 **可自定义对象** 的实例，需要获取对 **对象** 的引用以及一个 **CustomizableObjectInstance** 。你可以使用两种方式获取 **对象** 引用，一是将指针作为 `UPROPERTY()` 添加到Actor的类，然后从蓝图中设置值，二是使用资产的路径加载它。拥有两者后，调用 `SetObject` 函数，即告知实例要表示的对象。这样，实例就知道要存储哪些参数以及这些参数的默认值是什么。

```
UCustomizableObject* CustomizableObject =     LoadObject<UCustomizableObject>(nullptr, TEXT("/Game/MyCustomizableObject")); if (CustomizableObject){    CustomizableObjectInstance = NewObject<UCustomizableObjectInstance>();    CustomizableObjectInstance->SetObject(CustomizableObject);}
```

## 将实例与Actor关联

将实例与Actor关联的最佳方法是使用 **CustomizableSkeletalComponent** ，该组件可以附加到Actor的 **SkeletalMeshComponent** 上，以便用Mutable生成的骨骼网格体（如果使用的是[Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Mesh-Component)节点）或标准的虚幻引擎骨骼网格体（如果使用的是[Passthrough Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Passthrough-Mesh-Component)节点）来更新和替换网格体资产。

创建组件后，当Actor被添加到关卡时，它将自动显示自定义骨骼网格体。你可以参考以下示例设置：

```
CSkeletalComponent =         NewObject<UCustomizableSkeletalComponent>(UCustomizableSkeletalComponent::StaticClass()); // 设置Actor将使用的实例CSkeletalComponent->CustomizableObjectInstance = CustomizableObjectInstance; // 选择在可自定义对象图表中声明的Mesh Component或Passthrough Mesh ComponentCSkeletalComponent->SetComponentName(TEXT("Body")); // 将CustomizableSkeletalComponent附加到Actor的SkeletalMeshComponent上CSkeletalComponent->AttachToComponent(GetMesh(), FAttachmentTransformRules::KeepRelativeTransform);
```

## 更改参数

参数存储在每个实例的公共数组中。你可以直接修改这些参数，但建议使用API函数以避免无效值。下面是如何修改不同类型参数的示例：

```
// 设置参数"Frackles"的布尔值CustomizableObjectInstance->SetBoolParameterSelectedOption(FString("Freckles"), true); // 设置参数"Shirt"的整型值（枚举类型）CustomizableObjectInstance->SetIntParameterSelectedOption(FString("Shirt"), FString("BasicShirt")); // 设置参数"Fatness"的浮点值，取值范围为0到1CustomizableObjectInstance->SetFloatParameterSelectedOption(FString("Fatness"), 0.5f); // 设置参数"EyeColor"的颜色值CustomizableObjectInstance->SetColorParameterSelectedOption(FString("EyeColor"),                                                              FLinearColor(FColor::Blue)); // 设置参数"VParam"的向量值CustomizableObjectInstance->SetVectorParameterSelectedOption(FString("VParam"),                                                              FLinearColor(120.f, 50.f, 180.f)); // 设置参数"Tatto"的投射器值CustomizableObjectInstance->SetProjectorValue(FString("Tatto"), LocalPosition, Direction, Up, Scale, Angle,                                                ECustomizableObjectProjectorType::Planar);
```

## 更改状态

正如[状态](../../mutable-optimizing-and-debugging/using-customizable-states-in-mutable/index.md)页面所述，Mutable具有状态的概念，可以根据用例实现某些优化。给定一个可自定义对象实例，可以使用以下API函数查询和更改其状态：

```
// 获取当前状态CustomizableObjectInstance->GetCurrentState(FString("InGame")); // 设置当前状态。需要待更新的可自定义对象实例FString State = CustomizableObjectInstance->SetCurrentState();
```

给定一个可自定义对象，我们可以查询可用状态和每个状态中的参数：

```
// 获取状态数量int32 Count = CustomizableObject->GetStateCount() // 获取给定状态索引的状态名称FString Name = CustomizableObject->GetStateName(1); // 获取给定状态的参数数量int32 ParameterCount = CustomizableObject->GetStateParameterCount(FString("InGame")); // 获取给定状态中参数索引的名称FString ParameterName = CustomizableObject->GetStateParameterName(FString("InGame"), 1);
```

## 更新实例

更改参数或状态不会自动更新实例。要应用这些更改，必须在 **CustomizableSkeletalComponent** 类中调用 `UpdateSkeletalMeshAsync()` 方法来更新实例。这样做将使用应用这些更改而生成的实例替换所有使用相同 **CustomizableObjectInstance** 的Actor的 **骨骼网格体** 组件。

```
// 更新实例CSkeletalComponent->UpdateSkeletalMeshAsync();
```

## 实例更新委托

你可能希望在网格体更新后运行特定的方法，例如触发动画或使网格体可见。为了在网格体更新后运行方法，Mutable提供了一个可以注册回调的委托。此委托将向注册的回调广播骨骼网格体更新的完成情况。

```
// 将"此"UObject的"OnCustomizableSkeletalUpdated"方法绑定为委托的回调 CSkeletalComponent->UpdatedDelegate.BindUObject(this, &MyCustomCharacter::OnCustomizableSkeletaUpdated); // 取消绑定回调 CSkeletalComponent->UpdatedDelegate.Unbind();
```

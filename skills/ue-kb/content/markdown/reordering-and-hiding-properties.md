# Reordering and Hiding Properties

---
title: "Reordering and Hiding Properties"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/reordering-and-hiding-properties-in-details-panel-customizations-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "编程工具", "细节面板自定义", "Reordering and Hiding Properties"]
---

# Reordering and Hiding Properties

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 编程工具 / 细节面板自定义 / Reordering and Hiding Properties

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/reordering-and-hiding-properties-in-details-panel-customizations-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Details Panel Customizations can change the order in which properties appear in the Details Panel, as well as show or hide properties that wouldn't ordinarily be visible. This page provides instructions on how to show, hide, and reorder both properties and categories.

## Prerequisites

This page uses the [Details Panel Quickstart](../details-panel-quickstart-guide/index.md) tutorial as the basis for its examples and refers to the following:

- FCustomDataProperty – A custom struct consisting of the following:

  - TSoftObjectPtr<UTexture> CustomTexture
  - FName CustomName
  - FString CustomString
  - Int32 CustomInt
- ACustomActor – A simple Actor with the following added properties:

  - TSoftObjectPtr<UStaticMesh> CustomMesh
  - float CustomFloat
  - bool CustomBool
  - FCustomDataProperty CustomData
- FCustomDataPropertyCustomization – A Property Type Customization for FCustomDataProperty.
- FCustomClassDetailsCustomization – A Detail Customization for ACustomActor.

You should also review [Refreshing the Details Panel](../refreshing-custom-details-panels/index.md) if you want to show or hide details based on changes made by the user.

## Properties

### Reorder Properties

You can re-order properties by changing the order in which you make **AddProperty** calls. The Class Details customization in the [Details Panel Quickstart](../details-panel-quickstart-guide/index.md) includes an example of re-ordering properties. The original property declarations for `ACustomActor` are as follows:

C++

CustomActorClass.h

```
UPROPERTY(EditAnywhere)
	TSoftObjectPtr<UStaticMesh> CustomMesh;

	UPROPERTY(EditAnywhere)
	float CustomFloat;

	UPROPERTY(EditAnywhere)
	bool CustomBool;

	UPROPERTY(EditAnywhere)
```

Normally, CustomMesh and CustomFloat would appear first in the Details Panel. However, the `FCustomClassDetailsCustomization::CustomizeDetails` function adds them to the details panel as follows:

C++

CustomActorClassCustomization.h

```
CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomData));	CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomBool));	CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomMesh));	CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomFloat));
```

This results in CustomData and CustomBool appearing first. Similarly, any other custom **Slate** elements will appear in the order that you add them.

> [!NOTE]
> If you do not add a property in your **Details Customization**, it uses the default order and the default category for your actor. See **Hide Properties** below for information on how to avoid displaying properties.

### Hide Properties

Use `IDetailCategoryBuilder::HideProperty` to selectively hide properties that would normally appear due to their UPROPERTY specifiers.

C++

CustomClassDetailsCustomization.cpp

```
DetailBuilder.HideProperty(FCustomDataProperty::StaticStruct()->GetFName());
```

## Categories

### Reorder Categories

Use `IDetailCategoryBuilder::SortCategories` to set the order your custom categories render in.

`IDetailCategoryBuilder::SortCategories` takes a delegate with the signature `void FunctionName (const TMap<FName, IDetailCategoryBuilder*>&)`. Any functions you use for this delegate must be static functions. The [TMap](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Containers/TMap?application_version=5.5) is a map of all the categories added by your custom class. Once you fetch a category from it, use `IDetailCategoryBuilder::SetSortOrder` to change what order the categories appear in. `IDetailCategoryBuilder::SetSortOrder` always sorts from lowest to highest.

C++

CustomClassDetailsCustomization.h

```
static void SortCustomDetailsCategories(const TMap<FName, IDetailCategoryBuilder*>& AllCategoryMap);
```

C++

CustomClassDetailsCustomization.cpp

```
//Custom details with two category names.

	void FCustomClassDetailsCustomization::CustomizeDetails(IDetailLayoutBuilder& DetailBuilder)
	{
		IDetailCategoryBuilder& CustomCategory = DetailBuilder.EditCategory(FName("Custom Settings"));
		IDetailCategoryBuilder& DataCategory = DetailBuilder.EditCategory(FName("Data"));
		CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomBool));
		CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomMesh));
		DataCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomData));
		DataCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomFloat));
```

### Hide Categories

Use `IDetailCategoryBuilder::HideCategory` to hide an entire category. You can use categories you defined with UPROPERTY specifiers or one you defined as part of a detail customization. Provide the `FName` of the category.

C++

CustomClassDetailsCustomization.cpp

```
void FCustomClassDetailsCustomization::CustomizeDetails(IDetailLayoutBuilder& DetailBuilder)	{		FName CustomCategoryName = FName("Custom Settings");		IDetailCategoryBuilder& CustomCategory = DetailBuilder.EditCategory(CustomCategoryName);		DetailBuilder.HideCategory(CustomCategoryName);	}
```

### Advanced Categories

Use `IDetailCategoryBuilder::SetShowAdvanced` to designate a category to show only when you expand the **Advanced** section of the **Details Panel**.

C++

CustomClassDetailsCustomization.cpp

```
void FCustomClassDetailsCustomization::CustomizeDetails(IDetailLayoutBuilder& DetailBuilder)	{		FName CustomCategoryName = FName("Custom Settings");		IDetailCategoryBuilder& CustomCategory = DetailBuilder.EditCategory(CustomCategoryName);		CustomCategory.SetShowAdvanced(true);	}
```


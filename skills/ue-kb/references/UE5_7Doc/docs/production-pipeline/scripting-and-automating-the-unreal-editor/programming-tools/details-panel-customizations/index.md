---
title: "细节面板自定义"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/details-panel-customizations-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "编程工具", "细节面板自定义"]
---

# 细节面板自定义

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 编程工具 / 细节面板自定义

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/details-panel-customizations-in-unreal-engine

[虚幻引擎反射系统](../../../../cpp-programming/reflection-system/index.md)使用来自[UProperty](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties)宏的信息来决定如何在细节面板中显示属性。对于大多数公开属性的用例来说，这可以满足需求。但是，你可能想要自定义细节面板如何更详细地显示和编辑信息。

虚幻引擎提供 **细节面板自定义** 接口类来重载细节面板，并根据需要更改、删除或添加元素。其中包括对显示特定属性、自定义编辑条件或实现复杂的自定义[Slate]控件的修改。本页面介绍了细节面板自定义的基础知识，并提供了教程链接，向你展示如何逐步编译细节面板自定义。

## 细节面板自定义类和方法

用于细节面板自定义的接口类如下：

| **类名称** | **说明** | **自定义方法** |
| --- | --- | --- |
| `IDetailCustomization` | UObject和UActor派生类的细节面板自定义。 | CustomizeDetails |
| `IPropertyTypeCustomization` | 结构体的细节面板自定义。 | CustomizeHeader, CustomizeChildren |

当你实现其中一个类时，你可以重载它们的自定义函数，以添加Slate代码。这些参数会公开工具类，以及有关你正在自定义的类或结构体的数据。接口的详细介绍如下。

### IDetailCustomization

`IDetailCustomization` 将自定义UObject和UActor派生类的细节面板。每当你选择指定了 `IDetailCustomization` 的对象的实例时，细节面板都会根据细节自定义的规则显示。

`ADocumentationActor` 是一个简单示例，展示了一个使用细节自定义的类。`FDocumentationActorCustomization` 是添加按钮以在Web浏览器中打开所附URL的细节自定义。

![文档Actor的细节，包括文档链接和打开帮助URL按钮。](../../../../../assets/images/e4/e456121e60e5d9941983aca2f236b030dc3637f597f81a54bb54334bb57bcb1f.png)

#### IDetailCustomization::CustomizeDetails

```
virtual void (IDetailLayoutBuilder& DetailBuilder) override;
```

`IDetailCustomization::CustomizeDetails` 将提供Slate代码的添加位置，该代码会重载 `UObject` 和 Actor派生类的细节面板。凡是你未明确更改的内容，都会显示默认的细节面板，而没有细节自定义，使你可以仅专注于要添加或重新排列的内容。

### IPropertyTypeCustomization

`IPropertyTypeCustomization` 是为自定义属性类型自定义细节面板显示的基类。每当你将属性类型的实例公开给细节面板进行编辑时，无论是通过蓝图定义的变量进行编辑，还是通过 `UPROPERTY` 说明符进行编辑，如 `EditAnywhere` 或 `EditDefaultsOnly` 。

虚幻引擎中使用属性类型自定义的结构体示例如下：

| 结构体 | 自定义 | 属性自定义说明 |
| --- | --- | --- |
| `FFrameRate` | `FFrameRateCustomization` | 添加自定义下拉列表，帮助缩小帧速率的有效值范围。 |
| `FGameplayTag` | `FGameplayTagCustomization` | 显示可以打开Gameplay标签编辑器的按钮。 |

![Gameplay标签编辑器，通过细节面板中的下拉菜单显示](../../../../../assets/images/03/03858a265a14322c86355c43554e54253f72f0e71f0dbb9cda816e84c5d9a879.jpg)

#### IPropertyTypeCustomization::CustomizeHeader

`IPropertyTypeCustomization::CustomizeHeader` 重载自定义属性类型的细节面板的 **头文件** 部分。

```
 virtual void CustomizeHeader(TSharedRef<IPropertyHandle> PropertyHandle, FDetailWidgetRow& HeaderRow, IPropertyTypeCustomizationUtils& CustomizationUtils) override; 
```

头文件表示属性句柄的详细信息，包括显示在属性成员上方的可折叠下拉列表。在未实现属性类型自定义接口的结构体中，属性的名称将显示在此分段。

![显示名为](../../../../../assets/images/96/968b50ffa2aa23fe04e3a798676413db56db219632f858ebac1e9a314127854e.png)

名为"MyStruct."的结构体的细节自定义。其中包括自定义头文件(1)和子项(2)。

如果你在不带参数的情况下声明此 `IPropertyTypeCustomization::CustomizeHeader` ，则 `IPropertyTypeCustomization::CustomizeChildren` 函数将显示在与类的其他子属性相同的层级级别，并且虚幻编辑器中不会出现可折叠下拉菜单。

或者，你可以自定义头文件，重载CustomizeChildren，而不执行任何操作。

#### IPropertyTypeCustomization::CustomizeChildren

当你点击属性的可折叠下拉列表，以显示所有子属性时，显示的分段将由 `IPropertyTypeCustomization::CustomizeChildren` 自定义。

```
virtual void CustomizeChildren(TSharedRef<IPropertyHandle> PropertyHandle, IDetailChildrenBuilder& ChildBuilder, IPropertyTypeCustomizationUtils& CustomizationUtils) override;
```

在没有属性类型自定义的结构体中，被定义为结构体一部分的所有属性都会显示在此分段中。

![image alt text](../../../../../assets/images/20/20202d5b540f112bcd885db02bcec747fde23d2f030e0965fc0e147aaca8c5cd.png)

填充了CustomizeChildren (1)但没有CustomizeHeader的自定义结构体的示例。字段与Actor的其他属性(2)内联显示，而不是显示在下拉列表中。

如果你在不提供代码的情况下重载此函数，则该结构体的所有子属性都不会出现在细节面板中。如果要显示这些子属性，你需要使用 `IDetailChildrenBuilder::AddProperty` 。你可以循环浏览属性子项的完整列表，以显示全部子项。

```
void FCustomDataDetailsCustomization::CustomizeChildren(TSharedRef<IPropertyHandle> PropertyHandle, IDetailChildrenBuilder& ChildBuilder, IPropertyTypeCustomizationUtils& CustomizationUtils){	if (!PropertyHandle->IsValidHandle())	{		return;	}		uint32 NumChildren = 0;	PropertyHandle->GetNumChildren(NumChildren);		for (uint32 ChildIndex = 0; ChildIndex < NumChildren; ChildIndex++)	{		ChildBuilder.AddProperty(PropertyHandle->GetChildHandle(ChildIndex).ToSharedRef());	}
```

## 辅助类

以下类接口提供了访问Slate类属性的有用函数。

| **类名称** | **说明** |
| --- | --- |
| `IDetailLayoutBuilder` | 用于访问和更改UObject或UActor的属性和类别的工具函数。 |
| `IDetailChildrenBuilder` | 用于访问和更改自定义属性类型的属性和类别的工具函数。 |
| `IPropertyHandle` | 包含细节系统中属性信息的封装器。用于自定义单个属性。 |
| `IPropertyTypeCustomizationUtils` | 用于属性类型自定义的其他工具函数。 |

### IDetailLayoutBuilder

`IDetailLayoutBuilder` 提供用于访问和更改UObject或UActor的属性和类别的工具函数。`IDetailLayoutBuilder` 在 `IDetailCustomization::CustomizeDetails` 中可用。

### IDetailChildrenBuilder

`IDetailChildrenBuilder` 提供用于访问和更改自定义属性类型的属性和类别的工具函数。其运行方式与 `IDetailLayoutBuilder` 类似，但仅限于父 `IPropertyTypeCustomization` 所自定义属性的子属性。

### IPropertyHandle

`IPropertyHandle` 是一个封装器，其中包含细节系统中属性的相关信息，包括响应正在更改的属性的委托以及对属性本身的引用。IPropertyTypeCustomization有两个函数，两者都提供对你正在自定义的属性的IPropertyHandle的引用。 `IDetailCustomization` 和 `IDetailLayoutBuilder` 接口可获取对其正在自定义的类的任何子属性的 `IPropertyHandle` 的共享引用（`TSharedRef`）。

### IPropertyTypeCustomizationUtils

`IPropertyTypeCustomizationUtils` 提供对常见字体的引用、对缩略图池的访问权限以及对 `IPropertyUtilities` 接口的共享引用。

`IPropertyUtilities` 提供各种工具函数。其中包括强制或请求刷新细节面板的能力、对用户当前所选项的相关信息的访问权限，以及可以创建取色器窗口的工具函数。`IPropertyTypeCustomizationUtils` 通过 `IPropertyTypeCustomization::CustomizeHeader` 或 `IPropertyTypeCustomization::CustomizeChildren` 提供。

## 教程

以下教程提供了在自定义细节面板时具体操作的更多细节和示例：

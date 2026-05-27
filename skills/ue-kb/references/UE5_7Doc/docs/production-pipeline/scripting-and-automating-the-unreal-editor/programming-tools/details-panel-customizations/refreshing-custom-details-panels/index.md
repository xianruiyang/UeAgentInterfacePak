---
title: "刷新自定义细节面板"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/refreshing-custom-details-panels-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "编程工具", "细节面板自定义", "刷新自定义细节面板"]
---

# 刷新自定义细节面板

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 编程工具 / 细节面板自定义 / 刷新自定义细节面板

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/refreshing-custom-details-panels-in-unreal-engine

通常，**细节面板** 仅在你选择对象时才会重新编译。这意味着，如果你使用编辑条件在细节面板自定义中添加、隐藏或跳过添加字段，即使在你更改编辑条件中使用的变量时，细节面板也会更新。当你取消选择并重新选择对象时，细节面板会更新。

要手动更新 **细节面板**，请将调用 `IDetailLayoutBuilder::ForceRefreshDetails` 的委托添加到你要触发更新的属性。本教程介绍了如何创建此类委托。

> [!NOTE]
> 本教程基于[细节面板快速入门](../details-panel-quickstart-guide/index.md)中的代码编写。

## 步骤

请按照以下步骤创建用于刷新细节的可复用委托：

1. 设置委托以调用 `IDetailLayoutBuilder::ForceRefreshDetails`。下面是一个简单的lambda函数委托，你可以将内联放入 `CustomizeDetails` 函数中，并复用于你要刷新的所有属性：

   CustomClassDetailsCustomization.cpp

   ```
        const FSimpleDelegate OnValueChanged = FSimpleDelegate::CreateLambda([&DetailBuilder]()     {         DetailBuilder.ForceRefreshDetails();     });
   ```
2. 使用 `IDetailLayoutBuilder::GetProperty` 获取指向属性的TSharedRef。

   CustomClassDetailsCustomization.cpp

   ```
        TSharedRef<IPropertyHandle> boolPropertyHandle = DetailBuilder.GetProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomBool));
   ```
3. 使用 `IPropertyHandle::SetOnPropertyValueChanged` 分配委托，并强制细节面板在属性更改时刷新。

   CustomClassDetailsCustomization.cpp

   ```
        boolProperty->SetOnPropertyValueChanged(OnValueChanged);
   ```

有了此更改，CustomBool字段的任何更改都会导致细节面板刷新。

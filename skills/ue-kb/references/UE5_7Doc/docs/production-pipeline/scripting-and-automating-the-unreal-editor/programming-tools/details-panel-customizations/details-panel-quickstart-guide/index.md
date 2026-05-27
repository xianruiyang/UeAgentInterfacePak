---
title: "细节面板快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/details-panel-quickstart-guide-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "编程工具", "细节面板自定义", "细节面板快速入门"]
---

# 细节面板快速入门

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 编程工具 / 细节面板自定义 / 细节面板快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/details-panel-quickstart-guide-for-unreal-engine

本教程指导你为自定义属性类型（结构体）和Actor类创建 **细节面板自定义（Details Panel Customization）** 。

## 必需设置

开始本教程之前，设置一个运行时模块和对应的编辑器模块。本教程使用 **CustomGameplay** 和 **CustomGameplayEditor** 模块，两者都在[编辑器模块](../../setting-up-editor-modules-for-customizing-the-editor/index.md)教程中定义。你的文件夹结构应该如下所示：

- 项目源文件夹

  - CustomGameplay

    - CustomGameplay.Build.cs
    - Target.cs
    - Editor.Target.cs
    - Private
    - Public
  - CustomGameplayEditor

    - CustomGameplayEditor.Build.cs
    - Private

      - CustomGameplayEditorModule.cpp
    - Public

      - CustomGameplayEditorModule.h

## 自定义属性类型细节

要创建结构体的自定义细节面板，请执行以下步骤：

1. 在CustomGameplay模块的 `Public` 文件夹中创建新的头文件（ `.h` ）。将其命名为 `CustomDataProperty.h` 。
2. 将以下C++代码添加到 `CustomDataProperty.h` ：

   CustomDataProperty.h

   ```
         #pragma once     #include "CoreMinimal.h"     #include "CustomDataType.generated.h"      USTRUCT(BlueprintType, Category="Custom Data")     struct CUSTOMGAMEPLAY_API FCustomDataProperty     {         GENERATED_BODY()          UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Custom Data")         TSoftObjectPtr<UTexture> CustomTexture;          UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Custom Data")         FName CustomName;          UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Custom Data")         FString CustomString;          UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Custom Data")         int32 CustomInt;     };
   ```

   > [!NOTE]
   > 确保 `FCustomDataProperty` 有 `BlueprintType` 说明符，并且其所有属性都具有带 `EditAnywhere` 说明符的 `UPROPERTY` 宏。这样才能使 `FCustomDataProperty` 在蓝图类中变成可访问状态，并显示结构体的属性。
3. 在CustomGameplayEditor模块的 `Public` 文件夹中创建新的头文件（ `.h` ）。将其命名为 `CustomDataPropertyCustomization.h` 。
4. 将以下C++代码添加到 `CustomDataPropertyCustomization.h` ：

   CustomDataPropertyCustomization.h

   ```
        #pragma once     #include "CoreMinimal.h"     #include "IPropertyTypeCustomization.h"      class IPropertyHandle; //IPropertyHandle接口的正向声明      class FCustomDataPropertyCustomization : public IPropertyTypeCustomization     {     public:         // 继承自IPropertyTypeCustomization         virtual void CustomizeHeader(TSharedRef<IPropertyHandle> PropertyHandle, FDetailWidgetRow& HeaderRow, IPropertyTypeCustomizationUtils& CustomizationUtils) override;         virtual void CustomizeChildren(TSharedRef<IPropertyHandle> PropertyHandle, IDetailChildrenBuilder& ChildBuilder, IPropertyTypeCustomizationUtils& CustomizationUtils) override;          //用于创建属性自定义的实例的工具函数。         static TSharedRef<IPropertyTypeCustomization> MakeInstance();     };
   ```
5. 在CustomGameplayEditorModule的 `Private` 文件夹中创建新的类主体（ `.cpp` ）文件。将其命名为 `CustomDataPropertyCustomization.cpp` 。
6. 将以下C++代码添加到 `CustomDataPropertyCustomization.cpp` ：

   CustomDataPropertyCustomization.cpp

   ```
        #include "CustomDataDetailsCustomization.h"     #include "Widgets/SWidget.h"     #include "DetailLayoutBuilder.h"     #include "DetailCategoryBuilder.h"     #include "DetailWidgetRow.h"     #include "IDetailChildrenBuilder.h"     #include "Widgets/Input/SButton.h"     #include "Widgets/Text/STextBlock.h"     #include "HAL/PlatformApplicationMisc.h"     #include "IPropertyUtilities.h"      void FCustomDataDetailsCustomization::CustomizeHeader(TSharedRef<IPropertyHandle> PropertyHandle, FDetailWidgetRow& HeaderRow, IPropertyTypeCustomizationUtils& CustomizationUtils)     {      }      void FCustomDataDetailsCustomization::CustomizeChildren(TSharedRef<IPropertyHandle> PropertyHandle, IDetailChildrenBuilder& ChildBuilder, IPropertyTypeCustomizationUtils& CustomizationUtils)     {         //在继续前确保所访问的属性有效。          if (!PropertyHandle->IsValidHandle())         {             return;         }          //添加显示文本“Hello World!”的自定义行。         ChildBuilder.AddCustomRow( FText::FromString("HelloWorldTest"))             .NameContent()             [                 SNew(STextBlock)                 .Text(FText::FromString(TEXT("Hello, World!")))                 .Font(IDetailLayoutBuilder::GetDetailFont())             ];          //设置一个for循环，可在结构体的子属性中循环,并添加其默认属性细节。         uint32 NumChildren = 0;         PropertyHandle->GetNumChildren(NumChildren);          //显示结构体的原始子属性。         for (uint32 ChildIndex = 0; ChildIndex < NumChildren; ++ChildIndex)         {             ChildBuilder.AddProperty(PropertyHandle->GetChildHandle(ChildIndex).ToSharedRef());         }     }      //创建细节自定义的静态实例。     TSharedRef<IPropertyTypeCustomization> FCustomDataDetailsCustomization::MakeInstance()     {         return MakeShareable(new FCustomDataDetailsCustomization);     }
   ```

   以上代码执行以下操作：

   - include指令添加了对细节自定义所需的类的访问权限，包括：

     - 与控件相关的类（Button、STextBlock）。
     - 用于对细节控件建模的类（DetailLayoutBuilder、DetailWidgetRow、DetailCategoryBuilder、IDetailChildrenBuilder）。
     - 用于定义细节面板自定义的类（IDetailChildrenBuilder、IPropertyUtilities）
   - 必须实现 `FCustomDataDetailsCustomization::CustomizeHeader` 才能满足 `IPropertyTypeCustomization` 的实现要求，但此示例中没有使用它。
   - `FCustomDataDetailsCustomization::CustomizeChildren` 包含显示细节自定义主体的逻辑。

     - `IDetailChildrenBuilder::AddCustomRow` 定义了新的Slate细节控件行。你可以在其中声明其他Slate控件。
     - 然后，一个for循环会为原始结构体的每个子元素设置默认显示。
   - `FCustomDataDetailsCustomization::MakeInstance` 会创建细节自定义的实例，并在 `TSharedRef` 中将其返回，用于在下一步中显示细节面板中的属性。
7. 打开CustomGameplayEditor模块的实现文件（ `CustomGameplayEditor.cpp` ）。将以下代码添加到 `OnModuleStartup` ：

   CustomGameplayEditor.cpp

   ```
        #include "CustomGameplayEditorModule.h"     #include "CustomDataDetailsCustomization.h"     #include "PropertyEditorDelegates.h"     #include "PropertyEditorModule.h"      IMPLEMENT_GAME_MODULE(FCustomGameplayEditorModule, CustomGameplayEditor);      //在StartupModule函数中注册细节自定义。     void FCustomGameplayEditorModule::StartupModule()     {         //获取对属性模块的引用。         FPropertyEditorModule& PropertyModule = FModuleManager::LoadModuleChecked<FPropertyEditorModule>("PropertyEditor");			         /*         注册自定义属性类型的布局。这需要属性类型的名称。你可以手动将其作为字符串（"CustomData"）提供，也可以从StaticStruct获取FName。         你还需要为创建细节自定义实例的函数提供委托。在本例中，这是之前创建的MakeInstance函数。         */          PropertyModule.RegisterCustomPropertyTypeLayout(FCustomDataProperty::StaticStruct()->GetFName(), FOnGetPropertyTypeCustomizationInstance::CreateStatic(&FCustomDataDetailsCustomization::MakeInstance));     }      //在ShutdownModule函数中删除细节自定义。     void FCustomGameplayEditorModule::ShutdownModule()     {         PropertyModule.UnregisterCustomPropertyTypeLayout(FCustomDataProperty::StaticStruct()->GetFName());     } 
   ```

   以上代码执行以下操作：

   - PropertyEditorDelegates.h

     和

     PropertyEditorModule.h

     的include指令添加了注册属性类型自定义所需的类。
   - CustomDataPropertyCustomization.h

     的include指令添加了你在之前步骤中创建的属性类型自定义。
   - `FCustomGameplayEditorModule::StartupModule` 中的代码在虚幻编辑器加载模块时执行以下操作：

     - 加载或获取属性编辑器模块的实例。
     - 使用 `FPropertyEditorModule::RegisterCustomPropertyTypeLayout` 请求编辑器使用你创建的属性类型自定义。

       - 这包括结构体的名称（"CustomDataType"）和在编辑器需要显示属性类型自定义时创建它的实例的方法（

         FCustomDataPropertyCustomization::MakeInstance

         ）。

## 自定义类细节

1. 使用 **Actor** （ `UActor` ） 作为父类，创建新的C++类。将该类命名为 **CustomActor** 。
2. 打开 `CustomActor.h` 并添加以下成员：

   CustomActor.h

   ```
        UPROPERTY(EditAnywhere)     TSoftObjectPtr<UStaticMesh> CustomMesh;      UPROPERTY(EditAnywhere)     float CustomFloat;		     UPROPERTY(EditAnywhere)     bool CustomBool;      UPROPERTY(EditAnywhere) FCustomData CustomData;
   ```

   所有这些属性都不包括类别，因为你将在代码中为细节面板自定义提供类别。
3. 在CustomGameplayEditor模块的 `Public` 文件夹中创建新的头文件（ `.h` ）。将其命名为 `CustomActorClassCustomization.h` 。
4. 将以下C++代码添加到 `CustomActorClassCustomization.h` ：

   CustomActorClassCustomization.h

   ```
        #pragma once     #include "CoreMinimal.h"     #include "IDetailCustomization.h"      //IPropertyHandle的正向声明。     class IPropertyHandle;      //自定义类细节自定义     class FCustomClassDetailsCustomization : public IDetailCustomization     {         public:         //用于自定义细节面板的函数。          virtual void CustomizeDetails(IDetailLayoutBuilder& DetailBuilder) override;         //返回细节面板自定义的静态实例。          static TSharedRef<IDetailCustomization> MakeInstance();     };
   ```

正如在[属性类型自定义](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%B1%9E%E6%80%A7%E7%B1%BB%E5%9E%8B%E7%BB%86%E8%8A%82)中说的那样，此类包括一个 `FCustomClassDetailsCustomization::MakeInstance` 函数，用于稍后向编辑器模块注册它。

1. 在CustomGameplayEditor模块的 `Private` 文件夹中创建新的主体（ `.cpp` ）文件。将其命名为 `CustomActorClassCustomization.cpp` 。
2. 将以下C++代码添加到 `CustomActorClassCustomization.cpp` ：

   CustomActorClassCustomization.cpp

   ```
        #include "Widgets/SWidget.h"     #include "DetailLayoutBuilder.h"     #include "DetailCategoryBuilder.h"     #include "DetailWidgetRow.h"     #include "IDetailChildrenBuilder.h"     #include "Widgets/Input/SButton.h"     #include "Widgets/Text/STextBlock.h"     #include "HAL/PlatformApplicationMisc.h"     #include "IPropertyUtilities.h"     #include "CustomActor.h"     #include "CustomClassDetailsCustomization.h"      void FCustomClassDetailsCustomization::CustomizeDetails(IDetailLayoutBuilder& DetailBuilder)     {         IDetailCategoryBuilder& CustomCategory = DetailBuilder.EditCategory("CustomSettings");          //将CustomData和CustomBool放置在列表开头，以显示属性是按代码中的顺序添加的，而不是按头文件中列出的顺序。          CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomData));         CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomBool));         CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomMesh));         CustomCategory.AddProperty(GET_MEMBER_NAME_CHECKED(ACustomActor, CustomFloat));     }      //创建在模块启动中注册它所需的此细节自定义的静态实例。     TSharedRef<IDetailCustomization> FCustomClassDetailsCustomization::MakeInstance()     {         return MakeShareable(new FCustomClassDetailsCustomization);     }
   ```

   要向类的细节面板自定义添加字段，最简单的方式是定义细节类别，然后向其添加字段。以上代码添加了 `CustomSettings` 类别并使用 `IDetailCategoryBuilder::AddProperty` 函数添加每个属性的细节的默认实现。这会重载你在这些属性的 `UPROPERTY` 说明符中定义的所有类别。
3. 打开CustomGameplayEditor模块的实现文件（ `CustomGameplayEditor.cpp` ）。在 `StartupModule` 函数中添加一个 `PropertyModule.RegisterCustomClassLayout` 调用，并在 `ShutdownModule` 函数中添加一个 `PropertyModule.UnregisterCustomClassLayout` 调用。你的代码应该如下所示：

   CustomGameplayEditorModule.cpp

   ```
        IMPLEMENT_GAME_MODULE(FCustomGameplayEditorModule, CustomGameplayEditor);      void FCustomGameplayEditorModule::StartupModule()     {         FPropertyEditorModule& PropertyModule = FModuleManager::LoadModuleChecked<FPropertyEditorModule>("PropertyEditor");          PropertyModule.RegisterCustomPropertyTypeLayout(FCustomDataProperty::StaticStruct()->GetFName(), FOnGetPropertyTypeCustomizationInstance::CreateStatic(&FCustomDataDetailsCustomization::MakeInstance));          PropertyModule.RegisterCustomClassLayout(ACustomActor::StaticClass()->GetFName(), FOnGetDetailCustomizationInstance::CreateStatic(&FCustomClassDetailsCustomization::MakeInstance));     }      void FCustomGameplayEditorModule::ShutdownModule()     {         FPropertyEditorModule& PropertyModule = FModuleManager::LoadModuleChecked<FPropertyEditorModule>("PropertyEditor");         PropertyModule.UnregisterCustomPropertyTypeLayout(FCustomDataProperty::StaticStruct()->GetFName());         PropertyModule.UnregisterCustomClassLayout(ACustomActor::StaticClass()->GetFName());     }
   ```
4. 编译你的代码并打开你的项目。将CustomActor的实例放置在你的地图中，并查看细节面板。它应该如下所示：

![自定义结构体先显示“Hello World!”，然后再显示其子变量。](../../../../../../assets/images/30/30c6b15292f1fe4f490c902bfbddbdcd4bee855f8df5c5422bd1791393150b7e.jpg)

正如预期那样，自定义数据类型首先显示，其中带有“Hello, World!”字符串和结构体的每个成员，接着是自定义布尔值，然后是其他属性。

## 延伸阅读

以下页面介绍了创建自定义细节面板时的常见操作：

- 重新排序和隐藏属性
- 刷新细节面板
- 编辑条件

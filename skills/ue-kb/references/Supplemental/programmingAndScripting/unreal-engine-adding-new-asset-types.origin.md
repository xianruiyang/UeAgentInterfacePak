# 添加新的资产类型

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/q545/unreal-engine-adding-new-asset-types

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 6809 字符。

## 摘要

文章由 Alex K 撰写。您的项目拥有一些需要编辑、存储并与不同对象关联的自定义数据并不罕见。而不是将这些数据表示为现有的资产类型......

## 中文整理

### 概览

*文章由 [Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写* 您的项目拥有一些需要编辑、存储并与不同对象关联的自定义数据并不罕见。您可以设置自己的自定义资产类型并完全控制其在项目中的创建、表示和使用方式，而不是将此数据表示为现有资产类型（例如数据表）。编辑器工厂允许您设置自己的自定义导入行为以从其他应用程序读取数据，并让您可以自由地添加工作流程以在虚幻中创建甚至导出新资源。

### 定义类

创建自己的数据资产的第一步是定义存储数据的实际类。您可以添加将不同信息与数据资产关联所需的任何 UProperties，请记住，每次创建或导入您类型的新资产时，它将拥有自己的一组属性。

```cpp
UCLASS()
class MYMODULE_API UMyCustomData : public UObject
{
    GENERATED_BODY()

    UPROPERTY(EditAnywhere)
    float myFloat;

    // Add properties here
```

### 创建工厂

接下来，您需要创建工厂来支持导入资产类型，以及在编辑器中创建新资产。您可以实施其中一项或两项，具体取决于对您的资产类型有意义的方式。资产工厂将被自动发现，如果您想确保您的工厂有机会在其他工厂之前处理给定的文件扩展名，则可以指定 ImportPriority。首先，您需要设置构造函数并指定一些如何处理工厂的选项。您可以查看 UFactory 的标头，了解有关这些不同开关控制内容的更多详细信息。

```cpp
UMyCustomDataFactory::UMyCustomDataFactory(const FObjectInitializer& ObjectInitializer)
: Super(ObjectInitializer)
{
    SupportedClass = UMyCustomData::StaticClass();
    Formats.Add(TEXT("myasset;My custom asset extension"));

    bCreateNew = true;
    bText = false;
    bEditorImport = true;
    bEditAfterNew = false;
```

如果您想从某些外部文件导入资源，您需要实现 UFactory 函数 FactoryCanImport 和 FactoryCreateBinary。编辑器将使用 FactoryCanImport 来查看您的工厂是否有资格导入该文件。检查文件扩展名可能足以确定正在导入的文件是否应由您的工厂处理，或者在某些情况下（例如 FBX 文件）您可能实际上需要检查文件的内容以将其路由到正确的导入器。

```cpp
bool UMyCustomDataFactory::FactoryCanImport(const FString& Filename)
{
    const FString Extension = FPaths::GetExtension(Filename);

    if( Extension == TEXT("mydata") )
    {
        return true;
    }
    return false;
}
```

在 FactoryCreateBinary 中，您将在内容浏览器中创建实际资源，并给定一个包含文件内容的缓冲区，以便您可以解析出您感兴趣的任何数据。

```cpp
UObject* UMyCustomDataFactory::FactoryCreateBinary(UClass* InClass, UObject* InParent, FName InName, EObjectFlags Flags, const FString& Filename, const TCHAR* Parms, FFeedbackContext* Warn, bool& bOutOperationCanceled)
{
    UMyCustomData* CustomData = NewObject<UMyCustomData>(InParent, InClass, InName, Flags);

    //Do whatever initialization you need to do here

    return CustomData;
}
```

实现ConfigureProperties也可能很有用，您可以在其中创建一个弹出对话框窗口，以在导入资源之前指定一些导入设置。如果您的资产工厂应支持在编辑器中创建新资产，则应实现两个附加功能。 ShouldShowInNewMenu 将确定该类型是否应出现在编辑器的“添加新”菜单中，并且可以仅返回 true 或 false。 FactoryCreateNew 与上面的 FactoryCreateBinary 类似，只是您不会加载文件，而是创建一个新资源。

### 自定义资产类型

您现在可以导入资产或在编辑器中创建新资产，但您可能需要应用更多自定义功能以将其分类到正确的类别中并影响其在内容浏览器中的显示方式。为此，您将编写一个 AssetTypeActions 类，您可以在模块的 StartupModule 函数中尽早注册该类。

```cpp
IAssetTools& AssetTools = FModuleManager::LoadModuleChecked<FAssetToolsModule>("AssetTools").Get();
AssetTools.RegisterAssetTypeActions(MakeShareable(new FAssetTypeActions_MyCustomData));
```

对于实现，您将扩展 FAssetTypeActions_Base 并实现应用所需自定义所需的任何函数。

```cpp
class FAssetTypeActions_MyCustomData : public FAssetTypeActions_Base
{
public:
    // IAssetTypeActions Implementation
    virtual FText GetName() const override { return NSLOCTEXT("AssetTypeActions", "FAssetTypeActions_MyCustomData", "MyCustomData"); }
    virtual FColor GetTypeColor() const override { return FColor(0, 255, 255); }
    virtual UClass* GetSupportedClass() const override { return UMyCustomData::StaticClass(); }
    virtual uint32 GetCategories() override { return EAssetTypeCategories::Gameplay; }
    virtual void OpenAssetEditor(const TArray<UObject*>& InObjects, TSharedPtr<class IToolkitHost> EditWithinLevelEditor = TSharedPtr<IToolkitHost>()) override;
    virtual bool HasActions(const TArray<UObject*>& InObjects) const override { return true; }
```

其中许多都很简单，而其中一些可以让您更深入地自定义资产与引擎其余部分的交互方式。例如，HasActions/GetActions 将使您有机会将按钮添加到资产的上下文菜单中，您可能希望使用这些按钮对该资产执行自定义操作。如果您创建了一个自定义资源编辑器，OpenAssetEditor 可以让您将资源连接到整个自定义资源编辑器中。

### 接下来是什么？

虽然创建自定义资产编辑器超出了本文的范围，但您可以查看 FAssetTypeActions_DataTable 来了解我们如何在 OpenAssetEditor 中创建自定义数据表编辑器并使用它来修改数据资产，而无需从外部更新数据并重新导入资产。如果您想支持编辑器和创作数据的应用程序之间的进一步互操作性，您还可以编写自己的 UExporter 类，该类定义编辑器如何从内容浏览器获取资源并在磁盘上生成可以在其他地方导入的文件。在编辑器中导入和管理数据的方式有相当大的灵活性，引擎中包含大量 UFactory 实现，您可以查看示例，了解如何将数据转换为 Unreal 中可读和可编辑的内容。

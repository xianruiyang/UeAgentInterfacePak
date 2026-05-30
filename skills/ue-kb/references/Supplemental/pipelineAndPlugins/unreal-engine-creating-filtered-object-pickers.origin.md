# 创建过滤对象选取器

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/R8jv/unreal-engine-creating-filtered-object-pickers

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2910 字符。

## 摘要

由 Cody A 撰写的文章。声明对象 UProperty 时，您可以提供一个类过滤器，通过 AllowedClasses 元数据说明符仅显示具有特定基类的类：UPROPERTY(EditAnywhere, meta = (A…

## 中文整理

### 概览

*由 [Cody A.](https://dev.epicgames.com/community/profile/Zvl0/Cody.Albert) 撰写的文章* 声明对象 UProperty 时，您可以提供一个类过滤器，通过 AllowedClasses 元数据说明符仅显示具有特定基类的类：

```cpp
UPROPERTY(EditAnywhere, meta = (AllowedClasses = "MyBaseClass"))
FSoftObjectPath MyObject;
```

如果您希望对对象选择器应用额外的过滤，可以通过属性自定义来实现。您首先需要将您的属性包装在 UStruct 中，您可以将自定义应用到：

```cpp
USTRUCT(BlueprintType)
struct FMyObjectWrapperStruct
{
	GENERATED_USTRUCT_BODY()

public:
	UPROPERTY(EditAnywhere)
	FSoftObjectPath MyObjectPicker;
};
```

然后，您将编写一个自定义项，以用您自己的过滤版本替换标准选择器。默认情况下，详细信息面板会为对象生成一个 SPropertyEditorAsset。您的自定义将通过 SObjectPropertyEntryBox 小部件执行相同的操作，从而允许您更好地控制生成的小部件的设置：

```cpp
class FMyWrapperStructCustomization
	: public IPropertyTypeCustomization
{
public:

	/**
	 * Creates an instance of this class.
	 *
	 * @return The new instance.
	 */
```

我们还需要使用属性编辑器注册此自定义。对于定义结构的模块，这通常在 StartupModule 中完成：

```cpp
static FName PropertyEditor("PropertyEditor");
static FName WrapperClass("MyObjectWrapperStruct");
FPropertyEditorModule& PropertyModule = FModuleManager::GetModuleChecked<FPropertyEditorModule>(PropertyEditor);
PropertyModule.RegisterCustomPropertyTypeLayout(WrapperClass, FOnGetPropertyTypeCustomizationInstance::CreateStatic(&FMyWrapperStructCustomization::MakeInstance));
```

现在，我们可以编写自定义类。我们将使用CustomizeHeader创建我们自己的选择器小部件，并连接一个过滤器委托，以便我们可以控制显示哪些条目：

```cpp
void FMyWrapperStructCustomization::CustomizeChildren(TSharedRef<IPropertyHandle> StructPropertyHandle, class IDetailChildrenBuilder& StructBuilder, IPropertyTypeCustomizationUtils& StructCustomizationUtils)
{
	// Nothing to do here, we don't want any child properties to appear (we'll display the picker directly on the header row instead)
}


void FMyWrapperStructCustomization::CustomizeHeader(TSharedRef<IPropertyHandle> StructPropertyHandle, class FDetailWidgetRow& HeaderRow, IPropertyTypeCustomizationUtils& StructCustomizationUtils)
{

	TSharedPtr<IPropertyHandle> MyProperty = StructPropertyHandle->GetChildHandle(TEXT("MyObjectPicker"));
```

现在您有了自己的选择器，您可以探索 SObjectPropertyEntryBox 上公开的其他参数，以进一步自定义选择器的显示和过滤。


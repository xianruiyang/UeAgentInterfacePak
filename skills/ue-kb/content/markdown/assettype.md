# 如何：创建自定义 AssetType

# 如何：创建自定义 AssetType

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/l3L0/unreal-engine-how-to-create-a-custom-assettype

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2171 字符。

## 摘要

了解如何使用 ue 5.4+ 中的新 UAssetDefinitionDefault 类在引擎中本地实现您自己的自定义类样式。

## 中文整理

### 介绍

接下来，我们将了解如何使用新的 AssetDefinitionDefaults 类将您自己的自定义数据资产和蓝图资产定义集成到引擎中。 1. 添加新的 Unreal 模块 2. 创建 AssetDefinitionDefault 类 3. 定义新的 UFactory 4. 详细信息编辑和蓝图图之间的区别

### 添加新的虚幻模块

![在这里您应该看到一张图像，显示如何在 Rider 中创建新的 Unreal 模块](assets/unreal-engine-how-to-create-a-custom-assettype/image-01.jpg)

接下来将 **Module Type** 更改为 Editor，并将 **Loding Phase** 更改为 PostEngineInit

![新模块的设置选项应显示在此处。](assets/unreal-engine-how-to-create-a-custom-assettype/image-02.jpg)

以下模块加载代码需要位于插件 .uplugin 或项目 .uproject 文件中，具体取决于您是使用插件还是在项目中。

**插件名称.uplugin / 项目名称.uproject**

```cpp
	"Modules": [
		{
			"Name": "PluginName",
			"Type": "Runtime",
			"LoadingPhase": "Default"
		},
		{
			"Name": "ModuleName",
			"Type": "Editor",
			"LoadingPhase": "PostEngineInit"
```

不要忘记在新模块 Build.cs 中添加公共依赖项。在我的例子中，需要依赖项 AssetDefinition 和 UnrealEd 来使用所有资源样式和 InventorySystem 来访问 Item.h 类。

**模块名称.Build.cs**

```cpp
 PublicDependencyModuleNames.AddRange(
            new string[]
            {
                "Core", "InventorySystem", "AssetDefinition", "UnrealEd", "AssetRegistry"
            }
        );
```

### 创建 AssetDefinitionDefault 类

首先，我们创建一个继承自 UAssetDefinitionDefault 的类并执行资源的样式设置。就我而言，Item.h 是我想要设置样式的 **InventorySystem** 模块中的数据资产类。

**UAssetDefinition_Item.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "AssetDefinitionDefault.h"
#include "Item.h"
#include "UAssetDefinition_Item.generated.h"

UCLASS()
class CUSTOMEDITORASSETS_API UAssetDefinition_Item : public UAssetDefinitionDefault
{
```

### 定义新的UFactory

为了告诉引擎到底什么以及如何创建新的资产类型，我们创建一个继承自 UFactory 的工厂类。

**UItemFactory.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Factories/Factory.h"
#include "UItemFactory.generated.h"

UCLASS()
class UItemFactory: public UFactory
{
```

**UItemFactory.cpp 仅数据**

```cpp
#include "UItemFactory.h"
#include "Item.h"


UItemFactory::UItemFactory(const FObjectInitializer& FObjectInitializer):Super(FObjectInitializer)
{
	SupportedClass = UItem::StaticClass();
	bCreateNew = true;
	bEditorImport = false;
	bEditAfterNew = true;
```

### 详细信息编辑和蓝图图之间的区别

例如，如果您不仅想更改数据，还想在 UObject 中拥有蓝图，以便能够重写函数并添加自定义代码，则必须在创建类时以不同的方式创建对象。

**UItemFactory.cpp 蓝图**

```cpp
#include "UItemFactory.h"
#include "Item.h"


UItemFactory::UItemFactory(const FObjectInitializer& FObjectInitializer):Super(FObjectInitializer)
{
	SupportedClass = UItem::StaticClass();
	bCreateNew = true;
	bEditorImport = false;
	bEditAfterNew = true;
```

蓝图图形资源类型在创建后会立即覆盖 AssetDefinition 样式。因此，如果资产再次变蓝，请不要感到惊讶。为了避免这种情况，您必须创建 UBlueprint 的新子类。然后您可以在那里覆盖样式信息。 - [扩展编辑器：充分利用虚幻引擎现有框架|虚幻盛宴 2024](https://youtu.be/ovpiYkYFlPM?si=rmoooRJqb_Yg2VmU&t=1533)

## 相关链接

- [Extending the Editor: Making the Most of Unreal Engine’s Existing Framework | Unreal Fest 2024](https://youtu.be/ovpiYkYFlPM?si=rmoooRJqb_Yg2VmU&t=1533)


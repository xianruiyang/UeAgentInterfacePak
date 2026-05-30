# 如何：创建自定义项目设置

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/l5O0/unreal-engine-how-to-create-custom-project-settings

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1514 字符。

## 摘要

本教程向您展示如何使用 C++ 为您的项目添加自定义项目设置。

## 中文整理

### 介绍

在本教程中，我将解释如何使用 UDeveloperSettings 类在 C++ 中添加新的项目设置。 1. 将模块添加到 Build.cs 2. 创建 UDeveloperSettings 类 3. 创建变量 4. 加载类默认对象

### 添加 DeveloperSettings 依赖项

在项目的源文件夹中找到 ProjectName.Build.cs 文件并添加 DeveloperSettings 依赖项。

**项目名称.Build.cs**

```cpp
PublicDependencyModuleNames.AddRange(
			new string[]
			{
				"Core",
				"DeveloperSettings",
			}
			);
```

### 创建 DeveloperSettings 类

现在向您的项目添加一个继承自 UDeveloperSettings 的新类。

**类名.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Engine/DeveloperSettings.h"
#include "ClassName.generated.h"

/**
 * 
 */
UCLASS(Config = Game, defaultconfig, meta = (DisplayName = "Your Display Name"))
```

配置名称只能分配给以下预定义 UI 类别名称之一：项目、游戏、引擎、编辑器、平台和插件

### 创建你的变量

现在您可以将自己的变量添加到类中，并为它们分配元说明符 Config。

**类名.h**

```cpp
public:
	UPROPERTY(Config, EditAnywhere, BlueprintReadOnly, Category = "General")
	TArray<FName> SettingsPropertyName;
```

变量的值存储在 Config 文件夹中的 DefaultConfigName.ini 文件中。 .ini 文件无法存储对象，但您可以存储 TSoftObjectPtr 并在运行时加载对象。

### 访问数据

在 C++ 中，您可以使用 GetDefault<> 访问类的默认值

**其他类.cpp**

```cpp
// Access defaults from DefaultConfigName.ini
const UClassName* ProperyName = GetDefault<UClassName>();
OtherProperty = PropertyName->SettingsPropertyName;
```

在蓝图中，您可以通过使用 GetClassDefaults 节点并在该节点的 Class 字段中搜索 DeveloperSettings 类的 DisplayName 来使用类默认值。

**蓝图类**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_GetClassDefaults Name="K2Node_GetClassDefaults_0" ExportPath="/Script/BlueprintGraph.K2Node_GetClassDefaults'/Game/Tutorials/NewBlueprint.NewBlueprint:EventGraph.K2Node_GetClassDefaults_0'"
   ShowPinForProperties(0)=(PropertyName="SettingsPropertyName",PropertyFriendlyName="Settings Property Name",CategoryName="General",bShowPin=True,bCanToggleVisibility=True)
   bExcludeObjectContainers=True
   NodePosX=416
   NodePosY=528
   NodeGuid=3D29704C42790C9156B804B6AB980094
   CustomProperties Pin (PinId=4156632A4C5774CE383DF29920BCF0C5,PinName="Class",PinToolTip="Class\nObject Class Reference\n\nThe class from which to access one or more default values.",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/CoreUObject.Object'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultObject="/Script/PluginPlayground.ClassName",PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=047382844CD8D23BCBFF41AE9ED1B662,PinName="SettingsPropertyName",PinFriendlyName=INVTEXT("Settings Property Name"),PinToolTip="Settings Property Name\nArray of Names",Direction="EGPD_Output",PinType.PinCategory="name",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```

- [UDeveloperSettings](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/DeveloperSettings/UDeveloperSettings?application_version=5.7&lang=en-US)

## 相关链接

- [UDeveloperSettings](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/DeveloperSettings/UDeveloperSettings?application_version=5.7&lang=en-US)

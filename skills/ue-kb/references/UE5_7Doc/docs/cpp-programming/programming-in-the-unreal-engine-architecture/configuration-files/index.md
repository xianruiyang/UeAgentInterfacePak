---
title: "配置文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/configuration-files-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "配置文件"]
---

# 配置文件

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 配置文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/configuration-files-in-unreal-engine

**配置文件**（**Configuration Files或Config Files**）提供 **虚幻引擎（UE）** 的初始设置。 在最基本的层面上，配置文件包含若干键/值对的列表，这些键/值对还组织为不同的分段。 这些文件用于为所有版本和平台设置在虚幻引擎启动时加载的对象和属性的默认值。 配置文件使用 `.ini` 文件扩展名。

## 语法

配置文件的结构如下：

```
[SECTION1]<KEY1>=<VALUE1><KEY2>=<VALUE2> [SECTION2]<KEY3>=<VALUE3>
```

每个配置变量必须属于一个 `[SECTION]`，并且必须包含 `KEY` 且后跟 `=` 符号。 例如，在 `BaseEngine.ini` 中：

```
[Core.Log]LogTemp=warning
```

`VALUE` 在配置变量中可以为空，因此可以表示为：

```
[Core.Log]LogTemp=
```

### 分段名称

分段名称为字母字符串，可以将其设置为任何值。 无论项目代码中是否存在配置变量，配置系统都会加载配置文件中的所有声明。

#### 模块

模块中包含的可配置对象的分段标题使用以下语法：

```
[/Script/ModuleName.ClassName]
```

其中：

- ModuleName

  ：包含可配置对象的模块的名称。
- ClassName

  ：

  ModuleName

  模块中包含可配置对象的类的名称。

#### 插件

插件中包含的可配置对象的分段标题使用以下语法：

```
[/Script/PluginName.ClassName]
```

其中：

- PluginName

  ：包含可配置对象的插件的名称。
- ClassName

  ：

  PluginName

  插件中包含可配置对象的类的名称。

#### 蓝图

蓝图中包含的可配置资产的分段标题使用以下语法：

```
[/PathToUAsset/UAssetName.UAssetName_C]
```

其中：

- PathToUAsset

  ：资产的路径。
- UAssetName

  ：

  PathToUAsset

  中包含可配置对象的资产的名称。

#### 自定义分段名称

可以将任何字母字符串用作自定义类目名称。例如，如果需要一个名为"MyConfigSection"的类目，则可以写作

```
[MyConfigSection]
```

使用自定义分段名称时，必须手动查询分段中包含的配置变量。 请参阅[手动将配置设置应用于变量](#%E6%89%8B%E5%8A%A8)小节，了解更多信息。

### 注释

在任何行前面加上分号（`;`）即可在配置文件中创建注释。 这种做法也可用于注释掉键/值对，而无需从文件中删除键/值对。

```
[Core.Log]; 可以在DefaultEngine.ini中使用此分段来覆盖不同日志类目的显示级别，使用如下所示的行：; LogTemp=warning
```

### 键/值对

配置键可以表示各种不同类型的信息：

- 字符串
- 数字
- 数组
- 结构体

#### 数组

配置文件中的数组结构允许在配置文件层级中的多个配置文件之间组合、累积或覆盖信息。 例如，可以在层级中的多个文件（例如引擎目录中的 `BaseEngine.ini` 和 `DefaultEngine.ini`，以及项目目录中的 `DefaultEngine.ini`）之间向单个配置数组对象中添加多个条目。

配置文件支持下列数组运算：

| **名称** | **运算符** | **描述** | **示例** |
| --- | --- | --- | --- |
| 清空（Empty） | `!` | 清空数组的内容。 `=` 后面的任何值都会被忽略。 为避免产生歧义，建议在 `=` 之后添加一些描述性内容，如 `!MyVar=ClearArray`。 | `!MyArray=ClearArray` |
| 附加（Append） | `+` | 如果数组中还不存在该值，将该值附加到数组中。 如果数组中已存在该值，则不执行任何操作。 | `+MyArray=Value` |
| 删除（Remove） | `-` | 从数组中删除该值。 必须是完全匹配项。 | `-MyArray=Value` |
| 附加重复项（Append Duplicate） | `.` | 即使数组中已经存在该值，也要将该值附加到数组中。 | `.MyArray=Value` |

##### 数组示例

```
MyConfigArray=7!MyConfigArray=ClearArray+MyConfigArray=2+MyConfigArray=3+MyConfigArray=4.MyConfigArray=2-MyConfigArray=4
```

此示例中的行执行以下操作：

- MyConfigArray=7

  ：从数组中删除所有内容，然后附加7
- !MyConfigArray=ClearArray

  ：清除数组的所有条目
- +MyConfigArray=2

  ：向数组附加2
- +MyConfigArray=3

  ：向数组附加3
- +MyConfigArray=4

  ：向数组附加4
- .MyConfigArray=2

  ：向数组附加潜在重复项2
- -MyConfigArray=4

  ：从数组删除4

最后，`MyConfigArray` 包含 `[2,3,2]`。

#### 结构体

配置文件支持更改配置对象中的结构体属性。 设置结构体的语法为

```
[/Script/MyModule.MyClass]MyStruct=(MyStructProperty1=Value1,MyStructProperty2=Value2,...)
```

#### 字符串

引号支持使用特殊转义字符、十六进制值和UTF序列。 这有助于进行本地化和国际化。 例如，`BaseEngine.ini` 中包含以下分段：

```
[Internationalization]; 以下是用于本地化核心引擎本身的路径，本地化的游戏内容设置位于*Game.ini中+LocalizationPaths=../../../Engine/Content/Localization/Engine+CultureDisplayNameSubstitutes="ja;\u53f0\u6e7e;\u30c1\u30e3\u30a4\u30cb\u30fc\u30ba\u30bf\u30a4\u30da\u30a4"+CultureDisplayNameSubstitutes="\u53f0\u6e7e;\u4e2d\u534e\u53f0\u5317"
```

## 项目中的配置文件

在项目中使用配置文件时，有几个重要的注意事项。 其中包括：

- 虚幻引擎可以识别哪些类目的配置文件？
- 同一类目中的文件如何彼此影响？

### 配置文件类目

虚幻引擎可识别几种典型的"已知"类目的配置文件。

#### 通用

- Engine
- Game
- Input
- DeviceProfiles
- GameUserSettings
- Scalability
- RuntimeOptions
- InstallBundle
- Hardware
- GameplayTags

#### 仅适用于编辑器

- 编辑器
- EditorPerProjectUserSettings
- EditorSettings
- EditorKeyBindings
- EditorLayout

#### 仅适用于桌面版

- Compat
- Lightmass

### 配置文件层级

每个类目中可以有多个不同的配置文件。 例如，`Engine` 目录中包含：

- Engine\Config\BaseGame.ini
- Engine\Config\Windows\WindowsGame.ini

这些文件是 `Game` 配置文件类目的一部分。 每个文件都提供额外的自定义层。

同一类目中的配置文件组织为一个分层结构。 如果同一类目中的文件之间存在重复的键/值对，则层级中后面出现的文件中的键/值分配将覆盖层级中前面出现的文件中的键/值分配。 `Engine` 目录中存储的配置文件适用于使用此引擎发行版的所有项目。 位于 `<PROJECT_DIRECTORY>` 中的配置文件仅适用于该特定项目。 同样，位于 `<PLATFORM>` 目录中的配置文件仅适用于该特定平台。

类目配置文件按以下顺序加载：

1. Engine/Config/Base.ini
2. Engine/Config/Base<CATEGORY>.ini
3. Engine/Config/<PLATFORM>/Base<PLATFORM><CATEGORY>.ini
4. Engine/Platforms/<PLATFORM>/Config/Base<PLATFORM><CATEGORY>.ini
5. <PROJECT_DIRECTORY>/Config/Default<CATEGORY>.ini
6. Engine/Config/<PLATFORM>/<PLATFORM><CATEGORY>.ini
7. Engine/Platforms/<PLATFORM>/Config/<PLATFORM><CATEGORY>.ini
8. <PROJECT_DIRECTORY>/Config/<PLATFORM>/<PLATFORM><CATEGORY>.ini
9. <PROJECT_DIRECTORY>/Platforms/<PLATFORM>/Config/<PLATFORM><CATEGORY>.ini
10. <LOCAL_APP_DATA>/Unreal Engine/Engine/Config/User<CATEGORY>.ini
11. <MY_DOCUMENTS>/Unreal Engine/Engine/Config/User<CATEGORY>.ini
12. <PROJECT_DIRECTORY>/Config/User<CATEGORY>.ini

> [!NOTE]
> Engine目录中的配置集适用于使用此引擎分发版的所有项目。 如果可能，请使用位于项目目录中的配置文件更精细地控制配置更改。

> [!TIP]
> 有关配置文件层级的更多信息，请参阅位于 `Engine/Source/Runtime/Core/Public/Misc` 中的头文件 `ConfigHierarchy.h`。

#### 层级示例

为了说明层级的工作原理，假设有一个名为 `MyExampleProject` 的项目，而且 `Engine/Config/BaseEngine.ini` 配置文件中包含：

```
[/Script/EngineSettings.GameMapsSettings]GameDefaultMap=/Engine/Maps/Templates/OpenWorld
```

假设 `MyExampleProject/Config/DefaultEngine.ini` 中有以下配置设置：

```
[/Script/EngineSettings.GameMapsSettings]GameDefaultMap=/Game/ThirdPerson/Maps/ThirdPersonMap.ThirdPersonMap
```

由于项目目录中的 `DefaultEngine.ini` 文件取代了引擎目录中的 `BaseEngine.ini` 文件，因此项目启动时 `GameDefaultMap` 的值为 `/Game/ThirdPerson/Maps/ThirdPersonMap.ThirdPersonMap`。

## 在代码中使用配置变量

可以自动将配置变量应用于 `UPROPERTIES` 和 `USTRUCTS`，也可以从配置管理器手动读取这些配置变量。

### 将配置设置应用于变量

#### 自动

可以定义一个类来从配置文件层级中自动加载值。

##### 分段格式

要在模块代码中自动加载配置设置，请将 `[Section]` 格式设置为：

```
[/Script/ModuleName.ClassName]
```

其中

- ModuleName

  是定义

  ClassName

  类的模块的名称。
- ClassName

  是定义相关变量的类的名称。

> [!NOTE]
> `ClassName` 是类的名称，但不带 `U` 或 `A` 前缀。

##### 自动加载配置变量的步骤

假设一个名为 `MyGameModule` 的模块有一个名为 `AMyConfigActor` 的类，并假设 `AMyConfigActor` 包含你希望能够在配置文件中更改的名为 `MyConfigVariable` 的成员变量。

1. 配置要在 `UCLASS` 声明中读取的配置文件类目。 此示例使用 `Game` 类目：

   ```
        UCLASS(config=Game)     class AMyConfigActor : public UObject
   ```
2. 将类中要配置的任何成员变量标记为 `Config`：

   ```
        UPROPERTY(Config)     int32 MyConfigVariable;
   ```
3. 将上述变量设置在所选配置文件类目的层级中的任意位置。 例如，由于此示例使用 `Game` 类目，因此可以在项目目录内的 `DefaultGame.ini` 中设置以下配置：

   ```
        [/Script/MyGameModule.MyConfigActor]     MyConfigVariable=3
   ```

你的类看起来应该像这样：

```
UCLASS(config=Game)class AMyConfigActor : public UObject{	GENERATED_BODY() 	UPROPERTY(Config)	int32 MyConfigVariable;}
```

#### 手动

如前所述，无论C++代码中是否存在实际的配置变量，配置系统会加载配置文件中的所有声明。 这意味着你可以在任何分段中查询配置变量。 例如，假设 `DefaultGame.ini` 中包含以下配置：

```
[MyCategoryName]MyVariable=2
```

可以使用以下代码将此值读入所需的任何文件：

```
int MyConfigVariable;GConfig->GetInt(TEXT("MyCategoryName"), TEXT("MyVariable"), MyConfigVariable, GGameIni);
```

游戏代码中 `MyConfigVariable` 的值现在为2。

##### 手动读取选项

函数有几个选项可以检索变量，也可以检索从配置文件类目中检索该变量。

###### 函数

可以在 `ConfigCacheIni.h`（位于 `Engine/Source/Runtime/Core/Public/Misc`）中找到以下函数。

- GetBool
- GetInt
- GetInt64
- GetFloat
- GetDouble
- GetString
- GetText
- GetArray

###### 配置类目

配置类目会标识为 `G<CATEGORY>Ini`。 例如，`Engine` 类目表示为 `GEngineIni`。 可以在 `Engine/Source/Runtime/Core/Public` 下的 `CoreGlobals.h` 中找到相应值。

## 编辑配置设置

可以通过以下任一方式更改配置设置：

- 在相应的

  .ini

  文件中编辑配置值。
- 编辑

  虚幻编辑器

  的

  项目设置（Project Settings）

  中公开的配置值。

> [!NOTE]
> **虚幻编辑器** 的 **项目设置（Project Settings）** 中不会公开所有配置设置。

### 在代码中保存配置设置

可以在游戏代码中使用 `SaveConfig` 保存配置设置。

#### 保存配置示例

假设你的代码与[自动加载配置变量的步骤](#%E8%87%AA%E5%8A%A8%E5%8A%A0%E8%BD%BD%E9%85%8D%E7%BD%AE%E5%8F%98%E9%87%8F%E7%9A%84%E6%AD%A5%E9%AA%A4)小节中的示例相同：

```
UCLASS(config=Game)class AMyConfigActor : public UObject{	GENERATED_BODY() 	UPROPERTY(Config)	int32 MyConfigVariable;}
```

在代码中的某个位置，假设编辑以下可配置变量：

```
AMyConfigActor *Settings = GetMutableDefault<AMyConfigActor>();Settings->MyConfigVariable = 42;
```

然后可以将这个新的配置值保存在绝对路径为 `PathToConfigFile` 的配置文件中，如下所示：

```
FString PathToConfigFile;Settings->SaveConfig(CPF_Config, *PathToConfigFile);
```

## 相关的控制台命令

可以使用控制台命令 `GetIni` 来查看任何配置设置的值。 此命令可帮助你查看任何配置设置的值，包括当前使用的平台以外的平台的设置。 此命令仅搜索已加载的配置文件，因此如果设置位于尚未加载的配置文件中，则查询可能会失败。

### 命令

```
GetIni [Platform@]IniFile:Section Key
```

`Platform@` 参数是可选的。 如果未提供，则 `Platform` 默认为你当前使用的平台。

### 示例

在Windows上要在 `Engine` 层级的 `URL` 分段中查找 `Protocol` 的值，请运行以下命令：

```
GetIni Windows@Engine:URL Protocol
```

## 使用命令行来覆盖配置

虚幻引擎提供了一种通过命令行参数来覆盖配置设置的机制。

> [!NOTE]
> 命令行覆盖不适用于数组。

### 特定配置文件属性

#### 命令

```
-ini:<CATEGORY>:[SECTION_1]:<KEY_1>=<VALUE_1>,[SECTION_2]:<KEY_2>=<VALUE_2>,...
```

#### 描述

使用配置文件 `CATEGORY` 的给定 `SECTION` 中包含的 `VALUE` 来覆盖指定的 `KEY`。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

#### 示例

```
-ini:Engine:[/Script/Engine.Engine]:bSmoothFrameRate=False,[TextureStreaming]:PoolSize=100
```

覆盖 `Engine` 类目层级的 `[/Script/Engine.Engine]` 分段中包含的 `bSmoothFrameRate` 值（无论以前的值如何）。 与 `PoolSize` 相同。

### 类目中的默认文件

#### 命令

```
-Def<CATEGORY>Ini=<FILE_NAME>
```

#### 描述

用 `<FILE_NAME>` 文件覆盖 `Default<CATEGORY>.ini` 文件，其中 `CATEGORY` 是你要覆盖的特定配置文件类型。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

#### 示例

```
-DefGameIni=FooGame.ini
```

`FooGame.ini` 覆盖 `DefaultGame.ini` 配置文件。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

### 类目中的所有文件

#### 命令

```
-<CATEGORY>Ini=<FILE_NAME>
```

#### 描述

覆盖给定 `CATEGORY` 中的所有配置文件。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

#### 示例

```
-EngineIni=FooEngine.ini
```

`FooEngine.ini` 覆盖所有其他 `*Engine.ini` 文件。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

### 具有匹配后缀的配置文件

#### 命令

```
-iniFile=<PATH/TO/FILE_NAME>
```

#### 描述

覆盖具有匹配后缀路径的配置文件。

> [!NOTE]
> 此命令要求路径的后缀目录结构与配置文件的引擎目录结构匹配。

#### 示例

```
-iniFile=C:/MyAdditionalConfigFiles/Engine/Config/BaseEngine.ini
```

`C:/MyAdditionalConfigFiles/Engine/Config/BaseEngine.ini` 覆盖 `<PROJECT_DIRECTORY>/Engine/Config/BaseEngine.ini` 配置文件。 有关可用配置文件类目的完整列表，请参阅本页的[配置文件类目](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E7%B1%BB%E7%9B%AE)小节。

### 所有配置文件

#### 命令

```
-IniBootstrap=<FILE_NAME>
```

#### 描述

覆盖正在加载和解析的所有配置文件。 只读。

#### 示例

```
-IniBootstrap=Foo.ini
```

`Foo.ini` 是唯一加载的配置文件，不会加载任何其他配置文件。

## 在配置文件中设置控制台变量

配置文件提供了另一种用于指定控制台变量的机制。 某些控制台变量可以在通用配置类目中设置，而另外一些控制台变量则应在特定配置类目中设置。 通常，在项目目录中的 `DefaultEngine.ini` 的 `[ConsoleVariables]` 分段中设置控制台变量。

### 特定类目

下表描述了应在特定分段中设置的特定控制台变量类目：

| **类型** | **分段** | **描述** |
| --- | --- | --- |
| 渲染（Rendering） | `[/Script/Engine.RendererSettings]` | 任何以 `r` 开头的控制台变量。 |
| 渲染覆盖（Rendering Override） | `[/Script/Engine.RendererOverrideSettings]` | 专用于控制台变量 `r.SupportAllShaderPermutations`。 |
| 流送（Streaming） | `[/Script/Engine.StreamingSettings]` | 任何以 `s` 开头的控制台变量。 |
| 垃圾回收（Garbage Collection） | `[/Script/Engine.GarbageCollectionSettings]` | 任何以 `gc` 开头的控制台变量。 |
| 网络设置（Network Settings） | `[/Script/Engine.NetworkSettings]` | 仅适用于控制台变量 `n.VerifyPeer`、`p.EnableMultiplayerWorldOriginRebasing` 和 `NetworkEmulationProfiles`。 |
| 烘焙器设置（Cooker Settings） | `[/Script/UnrealEd.CookerSettings]` | 任何以 `cook` 开头的控制台变量。 |

## 可提供更多信息的有用源文件

以下引擎文件提供了有关配置系统及其组件的更多信息：

- ConfigCacheIni
- CoreGlobals
- ConfigHierarchy

---
title: "Lyra游戏设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/lyra-sample-game-settings-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "Lyra游戏设置"]
---

# Lyra游戏设置

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / Lyra游戏设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/lyra-sample-game-settings-in-unreal-engine

## Lyra游戏设置

Lyra包含一个 **游戏设置（GameSettings）** 插件，用于简化创建用户界面（UI）及其底层数据的过程。该插件负责管理你可能想存储在配置文件或服务器中的数据。

举例来说：你的玩家是一位探索森林的摄影师，而你的任务是记录珍稀野生动植物。当你的角色进入关卡的特定部分时，游戏设置插件可以管理位于服务器上的数据，以与关卡通信来决定哪些珍稀野生动植物应出现在你的角色当前所在的区域。

框架有几个关键部分：

- **UGameSettingRegistry** - 游戏设置注册表是一组设置。单个注册表可以部分或全部公开给用户，但是，你至少需要注册游戏的一个设置。如果游戏中有其他系统需要没有主游戏设置的设置，那么我们推荐你使用另一个注册表。
- **UGameSetting** - 定义所有设置的基类。UI的列表中的任意设置都被视为游戏设置。此类将处理核心概念，例如名称、描述、依赖项和编辑条件。
- **UGameSettingValue** - 实现有值需要获取和设置的任意设置的基类。一些设置将直接从此类继承，它们将改用：

  ```
            UGameSettingValueScalarDynamic,          UGameSettingValueDiscreteDynamic_Bool,          UGameSettingValueDiscreteDynamic_Number,          UGameSettingValueDiscreteDynamic_Enum.
  ```
- **UGameSettingCollection** - 定义组织设置。游戏设置集合用于将设置组合在一起。例如，如果你需要一个集合来生成列表中的标题，则该集合表示该标题组。
- **FGameSettingEditCondition** - 每个设置有一组附加的编辑条件。 你可以使用这些编辑条件给逻辑编码，用于查询某个设置是否禁用、隐藏或销毁。

### 创建设置

你在代码中为设置编写的大部分方法将形如以下内容：

```
	UGameSettingValueScalarDynamic* Setting = NewObject<UGameSettingValueScalarDynamic>();	Setting->SetDevName(TEXT("OverallVolume"));	Setting->SetDisplayName(LOCTEXT("OverallVolume_Name", "Overall"));	Setting->SetDescriptionRichText(LOCTEXT("OverallVolume_Description", "Adjusts the volume of everything."));	Setting->SetDynamicGetter(GET_LOCAL_SETTINGS_FUNCTION_PATH(GetOverallVolume));	Setting->SetDynamicSetter(GET_LOCAL_SETTINGS_FUNCTION_PATH(SetOverallVolume));	Setting->SetDefaultValue(GetDefault<ULyraSettingsLocal>()->GetOverallVolume());	Setting->SetDisplayFormat(UGameSettingValueScalarDynamic::ZeroToOnePercent);	Setting->AddEditCondition(FWhenPlayingAsPrimaryPlayer::Get()); 
```

所有设置都必须包含在整个注册表中唯一存在的 `DevName` ，并且需要 `DisplayName` 。

大部分设置都需要 `DescriptionRichText` ，系统将检查此项，以确保需要它的每个设置都包含此项。富文本是UMG富文本控件格式的标准，因为纯文本会在对搜索建立索引时进行解析。使用DynamicGetter和DynamicSetter，可在运行时访问设置。若使用：

```
	LocalPlayer->GetLocalSettings()->GetOverallVolume() 
```

来持续访问数据，对于每个设置而言都是冗余的声明，相反，动态getter和setter接受 `FGameSettingDataSourceDynamic` ，它使用提供的宏构建。

DynamicSetter和DynamicGetter要求你可以使用[元数据属性说明符](../../../../cpp-programming/reflection-system/metadata-specifiers/index.md)（UFUNCTION/UPROPERTY）从LocalPlayer访问数据。使用说明符可确保在初始化时满足这些条件。

### 自定义设置

为你的设置使用内置的类可满足大部分需求。但是，在一些情况下，你的设置可能需要更复杂的逻辑。例如，你可能需要检索游戏中打包的所有可用语言。

```
	UGameSettingValueDiscrete_Language* Setting = NewObject<UGameSettingValueDiscrete_Language>();	Setting->SetDevName(TEXT("Language"));	Setting->SetDisplayName(LOCTEXT("LanguageSetting_Name", "Language"));	Setting->SetDescriptionRichText(LOCTEXT("LanguageSetting_Description", "The language of the game."));	Matchmaking->AddSetting(Setting); 
```

`UGameSettingValueDiscrete_Language` 将直接转变我们已存储的语言和文化设置。

### 编辑条件

FGameSettingEditCondition中的所有编辑条件子类将处理一个责任，以在以下任一条件适用时禁用、隐藏、防止重新设置，或将设置从分析中移除：

- **FWhenCondition** - 允许将你的条件编写为内联lambda。
- **FWhenPlatformHasTrait** - 用于基于平台特征隐藏或禁用设置。特征的例子有：

  - 平台是否支持键盘和鼠标？
  - 平台是否支持更改屏幕分辨率？

> [!WARNING]
> 查看几个源代码例子之后，你会注意到，我们在消除设置或Lyra的其他一般区域时并不使用 `#if PLATFORM_FEATURE` 之类的检查，而是依赖平台特征，因为我们可以在PIE中测试时使用该选项测试其他平台，所有内容都可以动态重新求值。因此，我们鼓励你尽可能使用 `FWhenPlatformHasTrait`。

- FWhenPlayingAsPrimaryPlayer

  - 如果你不希望其他本地玩家访问特定设置，你可以使用这些实例来编辑特定条件，使其专门可用于第一个玩家。

例如，位于类 `LyraGameSettingRegistry_Video.cpp` 中的分辨率设置：

```
	Setting->AddEditDependency(WindowModeSetting);	Setting->AddEditCondition(MakeShared<FWhenCondition>([WindowModeSetting](const ULocalPlayer*, FGameSettingEditableState& InOutEditState) { 		if (WindowModeSetting->GetValue<EWindowMode::Type>() == EWindowMode::Windowed) 		{ 			InOutEditState.Disable(LOCTEXT("ResolutionWindowed_Disabled", "When the Window Mode is set to <strong>Windowed</>, the resolution is freely resized with the window.")); 		} 		else if (WindowModeSetting->GetValue<EWindowMode::Type>() == EWindowMode::WindowedFullscreen) 		{ 			InOutEditState.Disable(LOCTEXT("ResolutionWindowedFullscreen_Disabled", "When the Window Mode is set to <strong>Windowed Fullscreen</>, the resolution must match the native desktop resolution.")); 		}	})); 
```

编辑条件会跟踪设置是否切换为 `enabled` 、`disabled` 或 `hidden` 。这些条件旨在确保当用户尝试在运行时期间更改你的项目设置时，你可以提供一种可回溯到调试器的解释。在下图中，窗口模式的编辑条件已切换为禁用（Disabled）。因此，引擎会向用户回送一条消息，使其理解无法更改设置的原因。

![Lyra警告窗口](../../../../../assets/images/fd/fd77a2d31bbf29f691c75ab0babbe63123e2448e81dafb2e5f23db472bd27bb5.jpg)

### 用户界面

用户界面由类 `UGameSettingVisualData` 和 `UGameSettingPanel` 组成。游戏设置面板负责处理显示内容，你可以为其提供注册表和筛选器，让面板显示你的设置。为了决定这些设置的定义方式，游戏设置可视化数据包含一些规则，你的设置会使用这些规则将 `UGameSettingListEntryBase` 连接到 `UGameSetting` 类。

![Lyra游戏设置注册表](../../../../../assets/images/e1/e16a84bc9a8e94184edf3ebc2d7240a3fe29c2ba7551e2909dd0163b8404e462.png)

游戏设置注册表可视化数据包含关于面板应如何显示的详情。

### 数据源

```
	`FGameSettingDataSource`	`FGameSettingDataSourceDynamic` 	`GET_SHARED_SETTINGS_FUNCTION_PATH`	`GET_LOCAL_SETTINGS_FUNCTION_PATH`
```

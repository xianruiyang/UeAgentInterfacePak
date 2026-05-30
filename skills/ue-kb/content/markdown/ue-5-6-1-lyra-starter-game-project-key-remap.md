# 如何修复 UE 5.6.1 中的 Lyra Starter Game Project Key Remap 功能

# 如何修复 UE 5.6.1 中的 Lyra Starter Game Project Key Remap 功能

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/va8B/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4937 字符。

## 摘要

如何修复 UE5.6.1 中的 Lyra Starter Game Project Key Remap 功能

## 中文整理

### 概览

在 UE 5.6.1 中，Lyra Starter Game Project Key Remap 不起作用，但在 UE 5.5 中却起作用，为什么？因为获取可映射密钥配置文件的 API 已发生更改，如下所示：

**用于获取可映射密钥配置文件的 API**

```cpp
/** Returns all player saved key profiles */
UE_DEPRECATED(5.6, "Use GetAllAvailableKeyProfiles instead.")
UE_API const TMap<FGameplayTag, TObjectPtr<UEnhancedPlayerMappableKeyProfile>>& GetAllSavedKeyProfiles() const;
/** Returns all player saved key profiles */
UE_API const TMap<FString, TObjectPtr<UEnhancedPlayerMappableKeyProfile>>& GetAllAvailableKeyProfiles() const;
```

在 5.5 中，我们使用 GetAllSavedKeyProfiles，它工作得很好，正如我们预期的那样，但在 5.6 中，它已被弃用，并建议我们使用 GetAllAvailableKeyProfiles 代替。但是 GetAllAvailableKeyProfiles 并没有像我们预期的那样工作，当您启动 Lyra 并从菜单中进入选项，然后选择键盘和鼠标时，您没有在 UI 中显示任何键。然后你可以使用 UE_LOG 检查我们是否从源代码中得到了任何东西，如果你在 LyraGameSettingRegistry_MouseAndKeyboard.cpp 中这样做，你会发现 GetAllAvailableKeyProfiles 不起作用。如何解决这个问题？进入你的Lyra Starter Game Project的UE 5.6.1编辑器，你可以在 /All/Game/System/FrontEnd 中找到 B_LyraFrontEnd_Experience ，并打开它。

![将 IMC_Default 添加到前端体验中的输入映射](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-01.jpg)

正如我们在屏幕截图中看到的，我们可以在前端体验中将 IMC_Default 添加到输入映射中，然后我们可以从 GetAllAvailableKeyProfiles 获取按键重映射配置文件，我们可以看到按键显示在 UI 中，如下屏幕截图所示：

![鼠标和键盘按键重新映射](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-02.jpg)

但我们在游戏手柄部分仍然没有任何内容，为什么？那是因为没有代码可以为游戏手柄进行按键重新映射，我想分享如何做到这一点。首先我们需要一个继承自ULyraButtonBase的按钮类来实现UI中的按键重映射功能，它会显示按键图标并让用户点击它，以下是参考代码：

**UKeyRemapButtonBase 的标头**

```cpp
// CloudHu:604746493@qq.com All Rights Reserved

#pragma once

#include "CoreMinimal.h"
#include "LyraButtonBase.h"
#include "KeyRemapButtonBase.generated.h"

class UCommonLazyImage;
/**
```

**UKeyRemapButtonBase 的 CPP**

```cpp
// CloudHu:604746493@qq.com All Rights Reserved


#include "KeyRemapButtonBase.h"

#include "CommonLazyImage.h"

void UKeyRemapButtonBase::SetButtonDisplayImage(const FSlateBrush& InBrush)
{
	if (CommonLazyImage_Icon.Get())
```

这些代码是自定义按钮的基础知识，我们稍后将在编辑器中实现该小部件。为了获得游戏手柄的玩家可映射按键配置文件，我们必须为 LyraGameSettingRegistry_Gamepad.cpp 添加一些代码：

**LyraGameSettingRegistry_Gamepad.cpp**

```cpp
////////////////////////////////////////////////////////////////////////////////////
	{
		UGameSettingCollection* GamepadBinding = NewObject<UGameSettingCollection>();
		GamepadBinding->SetDevName(TEXT("GamepadBindingCollection"));
		GamepadBinding->SetDisplayName(LOCTEXT("GamepadBindingCollection_Name", "Controls"));
		Screen->AddSetting(GamepadBinding);

		const UEnhancedInputLocalPlayerSubsystem* EiSubsystem = InLocalPlayer->GetSubsystem<UEnhancedInputLocalPlayerSubsystem>();
		UEnhancedInputUserSettings* UserSettings = EiSubsystem->GetUserSettings();
```

您可以在LyraGameSettingRegistry_Gamepad.cpp中搜索GamepadBinding并复制代码。请忽略 EpicDebug 命名空间，它仅用于调试，如果您想查看游戏手柄的数据，可以使用 UE_LOG 代替。当然，LyraSettingKeyboardInput.h 进行了一些调整，它最初是为键盘输入编写的，但经过调整它也可以适用于游戏手柄。

**ULyraSettingKeyboardInput 的标头**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "GameSettingValue.h"
#include "UserSettings/EnhancedInputUserSettings.h"

#include "LyraSettingKeyboardInput.generated.h"

enum class ECommonInputType : uint8;
```

正如我们所看到的，我添加了 CachedDesiredInputKeyType 来区分我们想要的键类型及其 getter。 GetIconFromKey 用于按键重映射按钮以显示按键的图标。

**ULyraSettingKeyboardInput 的 Cpp**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#include "LyraSettingKeyboardInput.h"

#include "CommonInputSubsystem.h"
#include "CommonInputTypeEnum.h"
#include "EnhancedInputSubsystems.h"
#include "../LyraSettingsLocal.h"
#include "Player/LyraLocalPlayer.h"
```

函数InitializeInputData的实现与原始版本有很大不同，我在Registry中而不是在此处执行了for循环，因为我想从配置文件中屏蔽掉一些无效数据。我认为最好在注册表中执行此操作，这就是使用 NewObject 的时机。我们还需要在 LyraSettingsListEntrySetting_KeyboardInput.h 中进行一些调整：

**LyraSettingsListEntrySetting_KeyboardInput 的标头**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "Widgets/GameSettingListEntry.h"

#include "LyraSettingsListEntrySetting_KeyboardInput.generated.h"

class UKeyRemapButtonBase;
class UKeyAlreadyBoundWarning;
```

正如我们所看到的，我将按钮类更改为我们之前讨论过的 UKeyRemapButtonBase 以及这些按钮的数组。我想绑定更多的键，所以有第三个键和第四个键的按钮，你知道一些ARPG可以使用它。

**ULyraSettingsListEntrySetting_KeyboardInput 的 cpp**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#include "Settings/Widgets/LyraSettingsListEntrySetting_KeyboardInput.h"

#include "CommonUIExtensions.h"
#include "NativeGameplayTags.h"
#include "Settings/CustomSettings/LyraSettingKeyboardInput.h"

#include "UI/Foundation/KeyRemapButtonBase.h"
#include "UI/Foundation/LyraButtonBase.h"
```

最重要的功能是刷新，它定义了 UI 的情况。好的，最后一步是对 UGameSettingPressAnyKey 进行一些调整：

**UGameSettingPressAnyKey 的标头**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CommonActivatableWidget.h"

#include "GameSettingPressAnyKey.generated.h"

#define UE_API GAMESETTINGS_API
```

正如我们在代码中看到的，所有更改都是针对 KeyIndex 的，这是描述我们正在弄乱哪个键槽的另一种方式。

**UGameSettingPressAnyKey 的 CPP**

```cpp
// Copyright Epic Games, Inc. All Rights Reserved.

#include "Widgets/Misc/GameSettingPressAnyKey.h"

#include "Framework/Application/IInputProcessor.h"
#include "Framework/Application/SlateApplication.h"

#include UE_INLINE_GENERATED_CPP_BY_NAME(GameSettingPressAnyKey)

class ICursor;
```

哦，我们还需要更改鼠标和键盘的绑定代码：

**LyraGameSettingRegistry_MouseAndKeyboard.cpp**

```cpp
// Bindings for Mouse & Keyboard - Automatically Generated
	////////////////////////////////////////////////////////////////////////////////////
	{
		UGameSettingCollection* KeyBinding = NewObject<UGameSettingCollection>();
		KeyBinding->SetDevName(TEXT("KeyBindingCollection"));
		KeyBinding->SetDisplayName(LOCTEXT("KeyBindingCollection_Name", "Keyboard & Mouse"));
		Screen->AddSetting(KeyBinding);

		const UEnhancedInputLocalPlayerSubsystem* EISubsystem = InLocalPlayer->GetSubsystem<UEnhancedInputLocalPlayerSubsystem>();
		const UEnhancedInputUserSettings* UserSettings = EISubsystem->GetUserSettings();
```

尝试编译一下，如果有错误可以给我留言。启动编辑器，我们可以复制 W_LyraMenuButton 并将其命名为 W_KeyRemapButton，然后将蓝图重新父级为 UKeyRemapButtonBase ，将 Icon 替换为 CommonLazyImage_Icon：

![将 Icon 替换为 CommonLazyImage_Icon](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-03.jpg)

然后打开 Graph 将所有 Icon Getter 节点替换为 CommonLazyImage_Icon Getter 节点并实现 UpdateIconStyle ：

![更新图标样式](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-04.jpg)

我们应该对 UpdateButtonText 做一些调整：这意味着我们不想同时显示文本和图标。我们也不想再使用 IconBrush 在 UpdateButtonStyles 中渲染 Icon，所以只需将其断开，如下截图所示：

![更新按钮样式](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-05.jpg)

编译并保存，我们应该替换W_SettingsListEntry_KBMBinding中的按钮（位于/All/Game/UI/Settings/Editors）：

![W_SettingsListEntry_KBMBinding](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-06.jpg)

打开图形并将 Button Primary Key Getter 节点替换为我们替换的新刷新按钮：

![获取PrimaryGamepadFocusWidget](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-07.jpg)

该蓝图可以帮助游戏手柄导航找到要聚焦的按钮、编译和保存。我记得这就是我所做的一切，如果我错过了任何内容，你将无法得到下面看到的内容：

![鼠标和键盘重新映射按键](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-08.jpg)

检查一下，如果您的游戏手柄按键重新映射或绑定与我的一样工作：

![游戏手柄按键重新绑定](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-09.jpg)

如果您想更改按键绑定的图标，可以在路径中找到它们：/All/Game/UI/Foundation/Platform/Input/KeyboardMouse

![CommonInput_KeyboardMouse](assets/unreal-engine-how-to-fix-lyra-starter-game-project-key-remap-functions-in-ue-5-6-1/image-10.jpg)

希望这对您实现自己的按键绑定功能有所帮助，如果您有疑问，请随时发表评论。就这样 ！感谢您查看此内容！


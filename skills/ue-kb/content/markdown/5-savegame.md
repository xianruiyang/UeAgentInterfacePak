# 在虚幻引擎 5 中不使用 SaveGame 将数据保存到磁盘的跨平台解决方案

# 在虚幻引擎 5 中不使用 SaveGame 将数据保存到磁盘的跨平台解决方案

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/EPr6/cross-platform-solution-for-saving-data-to-disk-without-using-savegame-in-unreal-engine-5

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 14396 字符。

## 摘要

本文探讨了一种稳健的跨平台方法，用于在虚幻引擎中保存应用程序数据，而不依赖于 SaveGame 系统。它解决了应用程序会话之间持久界面状态的挑战，例如活动日志记录类别和 UI 配置。该解决方案涉及使用 UObject 序列化将结构化数据有效地保存和加载为二进制文件，从而确保高性能和易于实施。

## 中文整理

### 介绍

在开发游戏日志系统 (GLS) [插件](https://fab.com/s/43bbed079742) 时，我遇到需要在应用程序会话之间保存 UI 元素的状态。这包括保存用户选择的日志记录类别、打开的选项卡、活动的属性以及其他运行时设置。为了解决这个问题，该解决方案必须满足几个关键要求：

### 主要要求

1. 通用性：该解决方案应该能够在虚幻引擎支持的所有平台上无缝运行。 2. 易于使用：保存和加载状态只需要几行代码，无需手动管理变量。 3. 性能：即使数据集很大，序列化和反序列化也必须很快，确保用户不会遇到任何明显的延迟。 4.引擎标准解决方案：该方法必须使用虚幻引擎的内置机制来保持跨平台兼容性并避免外部依赖。 5. 不使用SaveGame：虚幻引擎中的SaveGame机制是为了游戏进度而设计的。将其用于插件相关或技术数据是不合适的，因为此类数据不应跨设备同步（例如，PlayStation Plus 云保存）。

![教程图片](assets/cross-platform-solution-for-saving-data-to-disk-without-using-savegame-in-unreal-engine-5/image-01.jpg)

如果启用了选项卡保存，则打开应用程序时的所有界面元素应保持应用程序关闭时的相同状态。

### 为什么不使用 SaveGame？

虚幻引擎的 SaveGame 系统旨在存储玩家进度和游戏相关数据，例如关卡、统计数据、库存或成就。将 SaveGame 用于技术或临时数据（如 UI 状态）可能会导致以下问题： 混合问题：游戏进度和技术数据根本不同，将它们组合起来可能会使管理保存的数据变得不必要的复杂。性能开销：SaveGame 包含额外的元数据和开销，而轻量级临时数据不需要这些。最佳实践：通过将游戏玩法的 SaveGame 和临时数据的技术解决方案分开，我们保持了清晰且可维护的架构。通过选择自定义二进制序列化方法，我们可以避免这些陷阱，同时确保 SaveGame 保持干净并专注于其主要目的。

### 为什么我们不使用虚幻引擎配置文件？

虽然配置文件是在虚幻引擎中保存设置的强大工具，但它们主要适合存储**持久配置设置**，而不是**临时技术数据**。对于游戏日志系统 (GLS) 插件，我们需要一个能够在所有支持的平台（包括控制台）上可靠运行的解决方案，并在会话之间保留应用程序数据（例如 UI 状态）。这就是我们选择自定义序列化而不是配置文件的原因： 1. 跨平台兼容性：GLS 插件旨在跨平台无缝工作，包括控制台。当尝试在某些平台（尤其是控制台）上保存数据时，我们遇到了 GConfig->SetString 问题，其中配置文件可能无法按预期运行。为了确保功能一致，我们选择将数据直接保存到二进制文件。 2. 性能：我们的二进制序列化方法比基于文本的 .ini 文件更快、更高效，尤其是在保存或加载频繁更新的数据（例如 UI 状态）时。 3. 安全性：配置文件很容易手动修改，这可能会导致意外行为。对于临时技术数据，我们首选不易被用户修改的安全二进制格式。 4. 结构化数据：使用 .ini 文件保存复杂的嵌套结构（例如，具有选定类别和状态的多个选项卡）很麻烦。二进制序列化使我们能够以最小的开销处理此类数据。 5. 关注点分离：我们使用.ini 文件来存储插件的默认设置，例如全局配置选项。但是，我们避免将它们用于需要在会话之间保留的应用程序数据，因为这超出了配置文件的预期目的。我们的定制序列化系统确保采用可靠、高效且与平台无关的方法来保存临时技术数据，使其成为满足 GLS 插件独特要求的理想选择。

### 解决方案

该插件使用子系统 (UGLSSaveSubsystem) 来管理名为 FGLSSaveData 的结构，该结构保存插件的状态，例如活动选项卡、类别和功能。该结构会根据最新的用户操作进行更新，并且可以根据需要保存或加载。

### 保存数据

以下代码将插件状态保存到二进制文件：

```cpp
static const FString SaveDirectory = FPaths::ProjectSavedDir() + TEXT("/MySaveFolder/");
static const FString FileName = TEXT("MySaveFile.bin");
static const FString AbsoluteFilePath = SaveDirectory + FileName;

TArray<uint8> OutBytes;
FMemoryWriter MemoryWriter(OutBytes, true);

UGLSSaveSystemObject* SaveObject = NewObject<UGLSSaveSystemObject>();
SaveObject->SaveData = SaveData; // This is the structure of UMG data represented as an array of text or integers.
SaveObject->Serialize(MemoryWriter);
```

**具有数据结构的 UObject。**

```cpp
UCLASS()
class GLS_API UGLSSaveSystemObject : public UObject
{
    GENERATED_BODY()

public:
    UPROPERTY()
    FGLSSaveData SaveData{}; // It is preferable to have basic data types inside
};
```

```cpp
USTRUCT()
struct GLS_API FGLSSaveData
{
    GENERATED_BODY()

public:
    UPROPERTY()
    TMap<FString, FString> Data; // data in the form of key value, such as widget name, enabled or disabled
};
```

### 加载数据

以下代码从二进制文件加载插件状态：

```cpp
static const FString SaveDirectory = FPaths::ProjectSavedDir() + TEXT("/MySaveFolder/");
static const FString FileName = TEXT("MySaveFile.bin");
static const FString AbsoluteFilePath = SaveDirectory + FileName;

if (!FPaths::FileExists(AbsoluteFilePath))
{
    return; // No save file exists
}

TArray<uint8> OutBytes;
```

### 选择正确的路径来保存应用程序数据

在虚幻引擎 5 中开发跨平台应用程序或插件时，选择正确的目录来保存应用程序特定的数据至关重要。本节介绍虚幻引擎中两种常用的文件路径方法之间的差异：FPaths::ProjectSavedDir() 和 FPlatformMisc::GamePersistentDownloadDir()。了解他们的用例将帮助您做出最适合您需求的选择。

### FPaths::ProjectSavedDir()

1. 作用：返回项目文件夹内 Saved 目录的路径。这主要在开发和调试期间使用。 2. 示例： - 在 Windows 上：C:/MyProject/Saved/ - 在 Android 上：/sdcard/UE4Game/MyProject/Saved/ 3. 主要功能： - 非常适合在项目生命周期期间存储日志、临时文件或以开发人员为中心的数据。 - 该路径与项目结构紧密耦合，可能与某些平台上的发布版本不太一致。 4. 限制： - 在移动设备或控制台等平台上，此目录可能无法访问或在发布版本中需要额外的权限。 - 它对于用户或应用程序来说并不是本质上隔离的，这可能导致潜在的数据冲突。

### FPlatformMisc::GamePersistentDownloadDir()

1. 用途：为持久应用程序数据提供特定于平台、用户隔离的目录。 - 在 Windows 上：%LocalAppData%/MyGame/ - 在 Android 上：/data/data/com.mycompany.mygame/files/ - 在 iOS 上：/var/mobile/Containers/Data/Application/.../ - 自动适应目标平台的文件系统。 - 确保用户级数据隔离，使您的应用程序的数据与其他应用程序或系统文件分开。 - 适用于所有平台的发布版本，包括移动设备和控制台。 4. 优点： - 跨平台行为一致。 - 不同操作系统无需手动配置。 - 专为将持久数据存储在安全可靠的位置而设计。

### 您应该使用哪一个？

为了**跨平台兼容性和可靠性**，最好的选择是**FPlatformMisc::GamePersistentDownloadDir()**。原因如下： 1. 平台适配：它可以在所有虚幻引擎支持的平台上无缝工作，并自动选择合适的存储位置。 2. 发布就绪：与 FPaths::ProjectSavedDir() 不同，此方法针对在发布版本中使用进行了优化。 3.数据隔离：为您的应用程序提供私有目录，保证安全并防止与其他应用程序发生冲突。 4. 面向未来：该目录符合特定于平台的数据存储准则，这对于在 Google Play、Apple App Store 或控制台平台等应用商店上分发至关重要。 **FPaths::ProjectSavedDir()** 仅用于： 1. 开发人员工具或临时数据存储。 2. 开发时的调试目的。 3. 数据不需要在应用程序会话或部署之间保留的场景。

### 最佳实践

1. 使用 FPlatformMisc::GamePersistentDownloadDir() 存储运行时数据，例如用户首选项、UI 状态或生产版本中的日志。 2. 避免在发布版本中对关键应用程序数据使用 FPaths::ProjectSavedDir()，因为它可能无法在所有平台上正常工作。 3. 始终在目标平台上测试您的保存和加载功能，以确保预期的行为。通过选择正确的文件路径，您可以确保您的应用程序在跨平台上表现一致并满足现代游戏开发标准的要求。

### 它是如何运作的

核心思想是将包含数据的结构体 (FGLSSaveData) 序列化为 UObject 子类 (UGLSSaveSystemObject)，然后使用虚幻引擎的 Serialize 方法读取或写入它。这种方法消除了手动变量管理的需要。然而，需要注意的是，诸如纹理、动画或 pawn 之类的重对象不应直接保存到磁盘中。在这种情况下，仅序列化文本和数值等轻量级数据，从而使会话之间的管理变得更加容易。通过使用 FMemoryReader 和 FMemoryWriter 进行二进制序列化，我们实现了一个简单、快速、跨平台、不依赖 SaveGame 的解决方案。

### 替代方案：JSON 序列化

如果您更喜欢 JSON 等人类可读的格式，这里有一个以 JSON 格式保存和加载数据的示例：

### 保存为 JSON

```cpp
#include "Serialization/JsonWriter.h"
#include "Serialization/JsonSerializer.h"

void SaveToJson(const FString& FilePath, const FGLSSaveData& SaveData)
{
    TSharedRef<TJsonWriter<>> Writer = TJsonWriterFactory<>::Create();
    
    if (FJsonObjectConverter::UStructToJsonObjectString(SaveData, Writer))
    {
        FFileHelper::SaveStringToFile(Writer->ToString(), *FilePath);
```

### 从 JSON 加载

```cpp
#include "Serialization/JsonReader.h"
#include "Serialization/JsonSerializer.h"

void LoadFromJson(const FString& FilePath, FGLSSaveData& OutSaveData)
{
    FString JsonString;
    if (FFileHelper::LoadFileToString(JsonString, *FilePath))
    {
        TSharedRef<TJsonReader<>> Reader = TJsonReaderFactory<>::Create(JsonString);
        FJsonObjectConverter::JsonObjectStringToUStruct(JsonString, &SaveData, 0, 0);
```

### 二进制与 JSON

1. 二进制序列化：最适合大型数据集和敏感数据。二进制文件的读/写速度更快，而且更安全，因为它们不是人类可读的。 2. JSON 序列化：适合小型数据集或直接调试和检查保存文件时。但是，JSON 解析速度可能较慢，而且该格式对于敏感数据来说不太安全。

### 保存和恢复界面状态

在构建健壮的系统时，确保接口状态在应用程序会话中持续存在至关重要。本节概述了使用虚幻引擎的工具和结构保存和恢复 UI 状态的实用方法，以确保流畅的用户体验。

### 收集并保存接口状态

该过程首先将必要的 UI 状态收集到 TMap 中，其中每个键值对代表一个参数及其当前状态。这是通过在小部件上调用的函数来实现的，例如PrepareDataToSave。

```cpp
TMap<FString, FString> UGLSCustomCategoriesWidgetBase::PrepareDataToSave_Implementation()
{
    TMap<FString, FString> Params;

    const FString ParamName = TEXT("MY_PARAM_NAME-1");
    Params.Add(ParamName, FString::FromInt(int_value));

    return Params; 
}
```

这里，参数 MY_PARAM_NAME-1 被分配了 int_value 的字符串表示形式。然后该地图被序列化并保存到插件的 SaveData 中。这种方法的简单性使得存储各种 UI 相关状态具有灵活性和可扩展性。

### 读取并应用保存的状态

当应用程序重新打开时，保存的数据将被反序列化，使其可以在整个程序中使用。通过查询保存的状态，您可以将 UI 恢复到之前的配置。

```cpp
const FString ParamName = TEXT("MY_PARAM_NAME-1");
bool bParamValue = false;
UGLSSaveSystemUtils::GetSaveValueAsBoolean(this, ParamName, bParamValue);

// Apply the saved state
if (bParamValue)
{
    Widget->SetVisibility(ESlateVisibility::Visible);
}
else
```

在此代码段中，GetSaveValueAsBoolean 检索之前保存的参数 MY_PARAM_NAME-1 的布尔值。然后，小部件的可见性会相应更新，确保界面反映用户的最后配置。

### 为什么这种方法有效

1.灵活性：TMap的使用允许以结构化格式保存各种UI参数（例如，可见性、活动选项卡、选定类别）。 2.可重用性：保存的数据集中在SaveData中，可以在应用程序的任何部分无缝访问和重用。 3. 跨平台兼容性：该解决方案完全依赖于虚幻引擎的工具，使其能够在所有支持的平台上一致地工作。此方法提供了一种优雅且有效的方式来管理 UI 状态，通过保持会话之间的连续性来增强用户体验。

![所有活动界面元素都会在应用程序启动之间保存；它们的状态作为基本数据类型存储在保存中。](assets/cross-platform-solution-for-saving-data-to-disk-without-using-savegame-in-unreal-engine-5/image-02.jpg)

### 结论

通过利用虚幻引擎的 Serialize 方法和二进制序列化，我们实现了一个快速、跨平台的解决方案来保存插件状态。此方法避免了误用 SaveGame 的陷阱，并确保跨所有平台的兼容性。对于那些需要更易于理解的解决方案的人来说，JSON 序列化是一种替代方案，尽管它会带来性能和安全性的权衡。有关更多详细信息，您可以在此处找到完整的[文档](https://dev.epicgames.com/community/learning/tutorials/m36v/unreal-engine-fab-game-logs-system-gls-real-time-log-management-for-shipping-builds-on-mobile-and-console-platforms)


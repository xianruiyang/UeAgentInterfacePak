# 在虚幻引擎中使用自定义 C++ 结构作为 TMap 键

# 在虚幻引擎中使用自定义 C++ 结构作为 TMap 键

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/GxZ9/using-custom-c-structs-as-tmap-keys-in-unreal-engine

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4693 字符。

## 摘要

有关如何设置 USTRUCT 用作 TMAP 中的密钥的教程。

## 中文整理

### 简介

构建解决方案中的数据是成功的重要组成部分。 Epic Games 非常方便地将自定义结构集成到虚幻引擎的基础设施中。在本文中，我们将了解如何将自定义结构体集成到引擎的哈希系统中。这对于比较很有用，更令人兴奋的是，可以使用您的结构作为 [TMap](https://docs.unrealengine.com/en-US/Programming/UnrealArchitecture/TMap/index.html) 实例中的键值。

### 设置

### 最低限度声明

首先让我们定义最小的数据结构。我们有三个 include 语句，其中第三个特别值得注意。文件 HashMeIfYouCan. generated.h 是一个自动生成的标头，包含由[虚幻标头工具](https://docs.unrealengine.com/en-US/Programming/BuildTools/UnrealHeaderTool/index.html)收集的元信息。按照惯例，使用一致的文件名和类型来设置引擎对象。在本例中，我们的类型称为 FHashMeIfYouCan。 F 前缀是虚幻引擎对于任何引擎结构的（强制）[命名约定](https://docs.unrealengine.com/en-US/Programming/Development/CodingStandard/#namingconventions)。另请注意，我们使用虚幻引擎的反射和类型系统宏来注释结构定义。我们提供了一个 BlueprintType [结构说明符](https://docs.unrealengine.com/en-US/Programming/UnrealArchitecture/Reference/Structs/Specifiers/index.html) 来请求蓝图公开。在结构体定义的顶部，通过 GENERATE_BODY 宏进行了一些[样板代码生成](https://docs.unrealengine.com/en-US/Programming/UnrealArchitecture/Objects/#headerfileformat)，它生成使结构可供引擎使用所需的所有功能。接下来，我们声明一个字符串，并通过 BlueprintReadOnly 说明符将其指定为蓝图可视化脚本系统中的只读变量，作为 [UPROPERTY 宏](https://docs.unrealengine.com/en-US/Programming/UnrealArchitecture/Reference/Properties/index.html) 的参数。

**HashMeIfYouCan_Minimal.h**

```cpp
// (c) blurryroots innovation qanat OÜ -- CC BY 4.0

#pragma once

#include "CoreMinimal.h"
#include "UObject/NoExportTypes.h"
#include "HashMeIfYouCan.generated.h"

USTRUCT(BlueprintType)
struct FHashMeIfYouCan
```

例如，如果您加载关卡蓝图并创建一个新变量，您现在可以将其更改为 HashMeIfYouCan 类型 🎉

### 扩展哈希

哈希系统集成的下一步是定义一种标准化方法来比较两个自定义结构并根据结构实例生成哈希值。为了涵盖所有基础，我们实现了三个构造函数。一个默认构造函数、一个值构造函数和一个[复制构造函数](https://en.cppreference.com/w/cpp/language/copy_constructor)。如果使用 TArray 或 TMap 等数据结构，则默认构造函数特别有用，因为它们可能需要预先分配内部空间。现在我们添加比较功能。为了遵循约定，我们实现了一个 Equals 函数，该函数依次将当前结构的两个字符串字段模拟与给定的引用进行比较。我们使用这个 Equals 函数来实现与我们的自定义结构关联的[重写 == 运算符](https://en.cppreference.com/w/cpp/language/operators)。这将使任何代码能够使用 == 运算符来比较 FHashMeIfYouCan 的两个实例。最后一个难题是哈希函数，负责为引擎的框架提供特定类型的哈希值。为了实现这一点，我们声明一个[名为 GetTypeHash 的函数](https://docs.unrealengine.com/en-US/API/Functions/GetTypeHash/index.html)。

**HashMeIfYouCan.h**

```cpp
// (c) blurryroots innovation qanat OÜ -- CC BY 4.0

#pragma once

#include "CoreMinimal.h"
#include "UObject/NoExportTypes.h"
#include "HashMeIfYouCan.generated.h"

USTRUCT(BlueprintType)
struct FHashMeIfYouCan
```

现在，在实际实现中，我们使用由虚幻引擎的各种代码库提供的 [CRC 哈希函数](https://en.wikipedia.org/wiki/Cyclic_redundancy_check#CRC-32_algorithm)。 [FCrc::MemCrc32](https://docs.unrealengine.com/en-US/API/Runtime/Core/Misc/FCrc/MemCrc32/index.html)提供的具体算法受到I[ntel的slice-by-8](https://sourceforge.net/projects/slicing-by-8/files/)实现的启发，由[Micheal发布]库纳维斯](https://www.researchgate.net/profile/Michael_Kounavis)。

**HashMeIfYouCan.cpp**

```cpp
// (c) blurryroots innovation qanat OÜ -- CC BY 4.0

#include "HashMeIfYouCan.h"
#include "Misc/Crc.h"

#if UE_BUILD_DEBUG
uint32 GetTypeHash(const FHashMeIfYouCan& Thing)
{
    uint32 Hash = FCrc::MemCrc32(&Thing, sizeof(FHashMeIfYouCan));
    return Hash;
```

### 用法

让我们看看如何使用新创建的可哈希结构作为 TMap 实例的键值。

**使用StructAsMapKey.cpp**

```cpp
// (c) blurryroots innovation qanat OÜ -- CC BY 4.0

#include "HashMeIfYouCan.h"

void UseStructAsMapKey()
{
    TMap<FHashMeIfYouCan, uint32> DoughMade{
        {FHashMeIfYouCan("Airline Pilot"), 2300000},
        {FHashMeIfYouCan("Teaching assistant"), 133700},
        {FHashMeIfYouCan("Physician"), 420000},
```

现在就这样。感谢您阅读并继续在自由世界中摇摆。

### 分享

此内容由 Bluryroots Innovation qanat OÜ 赞助，并以 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) 形式共享。 - [Discord](https://think-biq.com/community/all) - [网站](https://think-biq.com) - [Github](https://github.com/think-biq)

## 相关链接

- [Discord](https://think-biq.com/community/all)
- [Website](https://think-biq.com)
- [Github](https://github.com/think-biq)


# 在 C++ 中使用 Niagara

- 来源: https://dev.epicgames.com/community/learning/tutorials/Gx5j/unreal-engine-using-niagara-in-c
- 原文标题: Using Niagara in C++

## 概述

由于我在网上没有找到任何关于这个主题的系统信息，所以我想发布一个简短的、适合初学者的指南。

我们的目标是像粒子系统一样，用 C++ 生成和修改 Niagara 系统。

为此，需要将 Niagara 添加到 build.cs 的依赖项中。然后就可以包含必要的头文件，一切就绪。 Step-by-step 逐步进行

1. 添加 build.cs 依赖项

找到项目位于 ...\ProjectName\Source\ProjectName\ProjectName.build.cs 的 build.cs 文件，并将“Niagara”添加到 PublicDependencyModuleNames 中：

```cpp
PublicDependencyModuleNames. AddRange ( new string[] { "Core" , "CoreUObject" , "Engine" , "InputCore" , "UMG" , "Niagara" });
PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "UMG", "Niagara" });
```

2. Rebuild project 2. 重建项目

保存文件并关闭 Visual Studio（如果 UE5 编辑器正在运行，也请将其关闭）。右键单击项目的 .UPROJECT 文件，然后单击“生成 Visual Studio 项目文件”。这可能需要一些时间，具体取决于项目的大小。 3. Include header files 3. 包含头文件

请在项目中包含以下头文件，并在必要时在头文件中添加前向声明：

## # include "NiagaraFunctionLibrary.h"

## # include "NiagaraComponent.h"

```cpp
#include "NiagaraFunctionLibrary.h"
#include "NiagaraComponent.h"
```

4. Niagara in C++ 4. C++中的 Niagara

现在你可以在你的 C++ 项目中使用 NiagaraFunctionLibrary 和 NiagaraComponent 了。

文档详细概述了所有可用的函数和变量： https://docs.unrealengine.com/5.0/en-US/API/Plugins/Niagara/UNiagaraFunctionLibrary/ https://docs.unrealengine.com/5.0/en-US/API/Plugins/Niagara/UNiagaraComponent/

工作流程与传统粒子系统基本相同。举个简单的例子：

```cpp
// BaseWeaponComponent header file
#pragma once
#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "BaseWeaponComponent.generated.h"
// Forward declare this class, so the header file knows it is valid
class UNiagaraSystem;
```

## myWeaponComponent.cpp

```cpp
// BaseWeaponComponent class file
#include "BaseWeaponComponent.h"
#include "Components/SceneComponent.h"
#include "NiagaraFunctionLibrary.h"
#include "NiagaraComponent.h"
```

UBaseWeaponComponent::UBaseWeaponComponent()

```cpp
{
// ...
}
```

## 尼亚加拉用户公开参数

```cpp
UNiagaraFunctionLibrary documentation
```

## 文档 UNiagaraComponent documentation

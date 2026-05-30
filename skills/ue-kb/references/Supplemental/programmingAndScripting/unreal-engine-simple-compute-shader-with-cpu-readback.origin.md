# 具有 CPU 回读功能的简单计算着色器

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/WkwJ/unreal-engine-simple-compute-shader-with-cpu-readback

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3366 字符。

## 摘要

在本教程中，我们将使用 C++ 和 BP 创建并调度我们自己的计算着色器！本教程摘自https://unreal.shadeup.dev/docs/compute/base

## 中文整理

### 0.前提条件

确保您有一个支持 C++ 的 UE5 项目可供使用。如果您希望使用的项目仅为 BP，您可以按照[此](https://forums.unrealengine.com/t/how-can-i-convert-a-blueprint-project-to-c-project-in-ue5/526755) 将其转换为 C++。

### 1. 创建插件

我们将首先创建一个新插件来容纳我们的着色器代码。要创建新插件，请在编辑器中启动您的项目并导航至：编辑 -> 插件 -> 添加。您可以使用空白模板并保留默认设置。

### 1.5 可选 - 只需下载代码

如果您不想遵循下面的所有复制/粘贴步骤，您可以使用我制作的一个特定于虚幻的工具来自动化脚手架着色器的过程：计算|着色](https://unreal.shadeup.dev/docs/compute/base)

### 2. 创建着色器模块

为了启用着色器，我们需要创建一个单独的模块，该模块在与默认插件模块不同的阶段加载。 1. 首先，我们在 YourPlugin/Source 下创建一个名为“MyShaders”的新目录 2. 接下来，在新创建的目录下创建一个名为 MyShaders.Build.cs 的文件，并插入以下内容：

**MyShaders.Build.cs**

```
using UnrealBuildTool; 

public class MyShaders: ModuleRules 

{ 

	public MyShaders(ReadOnlyTargetRules Target) : base(Target) 

	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
```

3. 在 YourPlugin.uplugin 文件中的模块下添加以下内容： "Name": "MyShaders", "Type": "Runtime", "LoadingPhase": "PostConfigInit" 添加后，您的文件应如下所示：

**我的插件.uplugin**

```
{
	"FileVersion": 3,
	"Version": 1,
	"VersionName": "1.0",
	"FriendlyName": "MyPlugin",
	"Description": "",
	"Category": "Other",
	"CreatedBy": "",
	"CreatedByURL": "",
	"DocsURL": "",
```

4. 最后，让我们为模块添加头文件和源文件。 4.1.在 YourPlugin/Source/MyShaders 4.2 下创建 2 个名为“Public”和“Private”的新目录。在“Public”下创建一个名为“MyShaders.h”的新文件并插入以下内容：

**MyShaders.h**

```cpp
#pragma once

#include "CoreMinimal.h"

#include "Modules/ModuleInterface.h"
#include "Modules/ModuleManager.h"

#include "RenderGraphResources.h"
#include "Runtime/Engine/Classes/Engine/TextureRenderTarget2D.h"
```

4.3.在“Private”下创建一个名为“MyShaders.cpp”的新文件并插入以下内容（将 %YourPlugin% 字符串替换为您的插件名称并删除 %s）：

**MyShaders.cpp**

```cpp
#include "MyShaders/Public/MyShaders.h"

#include "Misc/Paths.h"
#include "Misc/FileHelper.h"
#include "RHI.h"
#include "GlobalShader.h"
#include "RHICommandList.h"
#include "RenderGraphBuilder.h"
#include "RenderTargetPool.h"
#include "Runtime/Core/Public/Modules/ModuleManager.h"
```

### 3.创建计算着色器类

1. 在“Public”目录下创建一个名为“MySimpleComputeShader.h”的新文件，并插入以下内容：

**MySimpleComputeShader.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "GenericPlatform/GenericPlatformMisc.h"
#include "Kismet/BlueprintAsyncActionBase.h"

#include "MySimpleComputeShader.generated.h"

struct MYSHADERS_API FMySimpleComputeShaderDispatchParams
{
```

2. 在“Private”目录下创建一个名为“MySimpleComputeShader.cpp”的新文件，并插入以下内容：

**MySimpleComputeShader.cpp**

```cpp
#include "MySimpleComputeShader.h"
#include "MyShaders/Public/MySimpleComputeShader/MySimpleComputeShader.h"
#include "PixelShaderUtils.h"
#include "RenderCore/Public/RenderGraphUtils.h"
#include "MeshPassProcessor.inl"
#include "StaticMeshResources.h"
#include "DynamicMeshBuilder.h"
#include "RenderGraphResources.h"
#include "GlobalShader.h"
#include "UnifiedBuffer.h"
```

3. 在“Private”目录下创建一个名为“MySimpleComputeShader.h”的新文件（是的，这是另一个同名的头文件，没有拼写错误），并插入以下内容：

**MySimpleComputeShader.h**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "MyShaders/Public/MyShaders.h"
#include "MeshPassProcessor.h"
#include "RHICommandList.h"
#include "RenderGraphBuilder.h"
#include "RenderTargetPool.h"
#include "MeshMaterialShader.h"
#include "ShaderParameterUtils.h"
```

### 4.编写HLSL代码

1. 在插件目录的根目录中创建两个相互嵌套的新目录，分别命名为“Shaders”和“Shaders/Private”。 2. 在“Shaders/Private”目录下创建一个名为“MySimpleComputeShader.usf”的新文件，并插入以下内容：

**MySimpleComputeShader.usf**

```cpp
#include "/Engine/Public/Platform.ush"

Buffer<int> Input;
RWBuffer<int> Output;

[numthreads(THREADS_X, THREADS_Y, THREADS_Z)]
void MySimpleComputeShader(
	uint3 DispatchThreadId : SV_DispatchThreadID,
	uint GroupIndex : SV_GroupIndex )
{
```

### 5. 使用方法

哇，这已经很多了，不是吗？我们现在可以编译项目并加载编辑器。

### 从蓝图调用

1. 右键单击​​任意蓝图编辑器并添加节点：“ExecuteBaseComputeShader” 2. 这将为您提供一个具有 2 个输入和 1 个输出的节点。输出 = A * B 3. 享受并深入研究代码

### 从 C++ 调用

**用法**

```cpp
#include "MyShaders/Public/MySimpleComputeShader.h"

// Params struct used to pass args to our compute shader
FMySimpleComputeShaderDispatchParams Params(1, 1, 1);

// Fill in your input parameters here
Params.Input[0] = 2;
Params.Input[1] = 5;

// Executes the compute shader and calls the TFunction when complete.
```

### 最后的想法

计算着色器非常强大，一旦您学会在虚幻引擎中使用它们，就会打开通往充满可能性的世界的大门。如果您对更多内容感兴趣，[shadeup.dev/docs](https://shadeup.dev/docs) 上有很多示例和自动支架可供查看。

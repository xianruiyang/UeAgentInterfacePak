# unreal-engine-nne-neural-post-processing.origin (Part 1/4)

# unreal-engine-nne-neural-post-processing.origin (Part 1/4)

Source file: `unreal-engine-nne-neural-post-processing.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

# NNE-神经后处理

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/7dr8/unreal-engine-nne-neural-post-processing

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 33467 字符。

## 摘要

了解如何对 C++ 和蓝图类进行编程，以将神经网络排队到渲染图管道，该管道将神经后处理应用于最终渲染图像。

## 中文整理

### NNE-神经后处理

### 介绍

在本教程中，您将实现在嵌入虚幻引擎渲染图管道的 GPU 上运行神经网络所需的基础设施。

### 目标

在本教程中，您将... - ... 设置一个简单的 C++ 项目 - ... 创建您自己的插件 - ... 实现准备要馈送到神经网络的渲染目标的着色器 - ... 实现 C++ 代码以将神经网络排队到渲染图生成器 - ... 实现对神经网络输出进行后处理的着色器以覆盖渲染目标 - ... 实现一个蓝图类以访问神经后处理 - ... 创建您自己的基于 Sobel 滤波器的神经网络资产并将其用于后处理 为了使事情简单明了，很多优化都被遗漏了。因此，读者还有一些开放的工作要做，以便为代码生产做好准备。我们还创建并使用能够在任何屏幕分辨率上运行的 Sobel 过滤器，但通过对着色器和代码进行适当更改，您可以使用任何适用于图像的神经网络。在本教程结束时，您将了解如何设置神经网络以与 RDG 资源交互以及如何将它们排入渲染管道。

### 先决条件

您应该已经完成​​了 NNE 系列之前的教程，并熟悉该插件的关键概念。此外，虚幻引擎着色器和渲染管道的基本知识以及对在 PyTorch 中创建神经网络模型的一些熟悉程度也很有帮助。

### 项目设置

您可以重复使用在之前的 NNE 教程中创建的项目。仅当您没有设置 C++ 项目时才需要执行此步骤。创建一个新项目，选择 **Games** 类别、**Third Person** 模板和 **C++**。输入项目的位置和名称，然后单击“**创建**”。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-01.jpg)

单击 **编辑** > **插件** 打开插件窗口。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-02.jpg)

搜索并启用 **NNERuntimeRDG** 插件。重新启动虚幻引擎编辑器。

### 插件设置

将插件添加到项目中，其中将包含所需的着色器和类。单击 **编辑** > **插件** 再次打开插件窗口。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-03.jpg)

点击**+添加**打开插件创建工具。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-04.jpg)

选择**空白**，添加插件名称并单击**创建插件**。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-05.jpg)

您的开发环境将打开并显示代码和新添加的插件。请注意，如果您使用虚幻引擎的自定义构建，则可能需要从开发环境中启动编辑器才能创建插件。创建的插件将包含全局着色器，因此必须以特定方式加载。打开插件文件 **Neural****PostProcessing.uplugin ** 并将 **LoadingPhase** 设置为 **PostConfigInit**。还要添加 **NNERuntimeRDG** 插件作为依赖项，以便我们可以使用它的功能。

```cpp
{
	"FileVersion": 3,
	"Version": 1,
	"VersionName": "1.0",
	"FriendlyName": "NeuralPostProcessing",
	"Description": "",
	"Category": "Other",
	"CreatedBy": "",
	"CreatedByURL": "",
	"DocsURL": "",
```

为了使插件编译时没有链接器错误，我们需要将模块 **Projects**、**RenderCore**、**RHI ** 和 **NNE** 添加到 **NeuralPostProcessing****.Build.cs** 内的私有依赖项。

```cpp
		PrivateDependencyModuleNames.AddRange(
			new string[]
			{
				"CoreUObject",
				"Engine",
				"Slate",
				"SlateCore",
				"Projects",
				"RenderCore",
				"RHI",
```

此外，我们从 **Renderer ** 模块添加了一些私有标头，这些标头需要稍后访问一些必需的类和结构。 。

```cpp
		PublicIncludePaths.AddRange(
			new string[] {
				System.IO.Path.Combine(EngineDirectory, "Source/Runtime/Renderer/Private")
			}
		);
```

### 着色器

在本教程中，我们在渲染图像上运行神经网络。由于渲染目标可能具有与神经网络期望的输入不同的内存布局和像素格式，因此我们需要创建在渲染目标与神经网络的输入和输出之间进行转换的着色器。为此，我们将创建一些全局着色器。

### 设置

在文件资源管理器中，导航到 **Plugins** > **NeuralPostProcessing** > **Source** > **NeuralPostProcessing** 并在 **Private** 和 **Public** 旁边创建一个新文件夹，并将其命名为 **Shaders**。在里面添加一个新文件并将其命名为**NeuralPostProcessing.usf**。在 Visual Studio 中，导航到解决方案资源管理器，并在添加 **Shaders ** 文件夹的同一位置创建 **Shaders ** 过滤器。将您创建的 **NeuralPostProcessing.usf** 文件作为现有项目添加到此过滤器中。我们执行这些步骤是为了确保文件存储在正确的路径中。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-06.jpg)

接下来我们需要让引擎知道我们的着色器所在的位置，以便它们可以被编译。为此，我们向模块添加一些代码。打开位于 **Private** 文件夹中的 **NeuralPostProcessing****.cpp** 并使用以下代码覆盖 **StartupModule()** 函数，该代码将我们的着色器文件夹注册到引擎。我们首先获得对我们自己的插件的引用，以便我们可以解析模块目录。经过健全性检查后，我们调用 **AddShaderSourceDirectoryMapping ** 传递包含着色器文件的文件夹。函数的第一个参数是虚拟着色器目录的映射点，稍后我们可以使用它来引用我们的着色器。

```cpp
#include "NeuralPostProcessing.h"

#include "Interfaces/IPluginManager.h"
#include "ShaderCore.h"

#define LOCTEXT_NAMESPACE "FNeuralPostProcessingModule"

void FNeuralPostProcessingModule::StartupModule()
{
	const TSharedPtr<IPlugin> Plugin = IPluginManager::Get().FindPlugin(TEXT("NeuralPostProcessing"));
```

最后在**Public**文件夹中添加头文件**NeuralPostProcessingCS.h**，在**Private**文件夹中添加源文件**NeuralPostProcessingCS.cpp**。再次确保文件是在相应的文件夹内创建的，方法是首先在文件资源管理器中创建文件，然后将它们导入到 Visual Studio。这些文件将包含封装在 **NeuralPostProcessing.usf** 中定义的着色器代码的着色器类。后缀 **CS** 表示它将包含计算着色器。您的插件文件夹现在应如下所示。

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-07.jpg)

### 执行

让我们从在 **NeuralPostProcessing.usf** 中定义着色器代码本身开始。它将包含两个着色器： **PrepareInput** 对输入纹理 **InputTexture** 进行采样，并将结果以通道优先顺序写入浮点缓冲区 **InputBuffer** 以供我们的神经网络使用。 **ProcessOutput** samples the output buffer **OutputBuffer** filled in by the neural network and changes back to channels-last order so that colors can be written back to the texture.

### 变量

首先定义引擎所需的包含内容以及我们将要编写的着色器使用的变量。

```cpp
#include "/Engine/Public/Platform.ush"
#include "/Engine/Private/Common.ush"

int Width;
int Height;

Texture2D InputTexture;
SamplerState InputTextureSampler;
RWBuffer<float> InputBuffer;
```

### 准备输入

我们需要一个计算着色器，从纹理 **InputTexture ** 中采样每个像素并将其存储在缓冲区 **InputBuffer** 中的通道优先布局中。定义一个函数 **PrepareInput **，它将线程的调度 id 作为输入。用 **[numthreads(THREAD_GROUP_SIZE, THREAD_GROUP_SIZE, 1)]** 装饰它，以便我们稍后可以通过定义 **THREAD_GROUP_SIZE** 从计算着色器类中设置线程组大小。当我们将着色器通道放入队列时，我们告诉引擎要实例化多少个线程组。与 **THREAD_GROUP_SIZE** 定义的每个组中的线程数一起，确定实例化线程的总数。每个线程负责一个像素，因此线程总数必须大于像素数。

```cpp
[numthreads(THREAD_GROUP_SIZE, THREAD_GROUP_SIZE, 1)]
void PrepareInput(in const uint3 DispatchThreadID : SV_DispatchThreadID)
{
	// ...
}
```

我们需要做的第一件事是检查当前线程是否有一个位于纹理边界内的索引，如果不是则返回。 This is necessary, as the input size may not be a multiple of our thread group size and thus some threads outside the input width and height will be created.

```cpp
    if (DispatchThreadID.x >= Width || DispatchThreadID.y >= Height)
    {
        return;
    }
```

我们使用 **DispatchThreadID ** 来计算纹理空间中的像素坐标，并在该位置对输入图像进行采样。

```cpp
	float X = (float)DispatchThreadID.x / (Width  - 1);
	float Y = (float)DispatchThreadID.y / (Height - 1);
	float4 Color = InputTexture.Sample(InputTextureSampler, float2(X, Y));
```

Finally we write back this color to the input buffer of the neural network.请注意，此时我们还将内存布局从纹理提供的 **高度 x 宽度 x 通道** 更改为神经网络消耗的 **通道 x 高度 x 宽度**。 This is achieved by writing colors of a single pixel with an offset **Height x Width** in between each rather than to consecutive indices.

```cpp
    int Idx = DispatchThreadID.y * Width + DispatchThreadID.x;
    int Offset1 = Width * Height;
    int Offset2 = Offset1 + Offset1;
    InputBuffer[Idx] = Color.r;
    InputBuffer[Idx + Offset1] = Color.g;
    InputBuffer[Idx + Offset2] = Color.b;
```

完整的函数如下所示。

```cpp
[numthreads(THREAD_GROUP_SIZE, THREAD_GROUP_SIZE, 1)]
void PrepareInput(in const uint3 DispatchThreadID : SV_DispatchThreadID)
{
    if (DispatchThreadID.x >= Width || DispatchThreadID.y >= Height)
    {
        return;
    }

	float X = (float)DispatchThreadID.x / (Width  - 1);
	float Y = (float)DispatchThreadID.y / (Height - 1);
```


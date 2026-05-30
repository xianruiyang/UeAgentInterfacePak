# 在 C++ 中创建运行时可编辑纹理 (Part 1/2)

Source file: `unreal-engine-creating-a-runtime-editable-texture-in-c.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/ow9v/unreal-engine-creating-a-runtime-editable-texture-in-c
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 14802 字符。
## 摘要

了解如何在 C++ 中创建可以在运行时修改以更改像素值的纹理。在本教程中，我们在可以由玩家绘制的材质中使用此纹理！
## 中文整理
### 简介

我当时正在做一个项目，我想要在运行时用 C++ 以编程方式编辑纹理，而我能找到的唯一教程是针对较旧版本的虚幻引擎，该版本不再与当前版本兼容，并且缺乏一些使其工作的信息。在弄清楚如何让一切正常工作后，我想把它写下来，并想我会把它分享给其他需要解决这个问题的人。
### 概述

- 为动态纹理创建 C++ 组件 - 创建函数以在运行时修改纹理 - 在动态材质中使用该纹理
### 动态纹理组件

创建一个新的 C++ 类作为 **Actor Component** 的子级。这将是包含并更新动态纹理的类。我将组件命名为“**DynamicTextureComponent**”，因此如果您将其命名为不同的名称，则需要更改给定代码片段中的类名称。现在我们需要一个变量来存储纹理数据。这就是我们将操纵来修改纹理的内容。纹理数据存储为无符号 8 位整数数组，其中每个值都是每个像素的重复 **B G R A ** 值的一部分。实际上它看起来像 [B, G, R, A, B, G, R, A,...]

```cpp
private:
    //Array that contains the Pixel Values for the Texture
    uint8* TextureData;
```

我们还需要一些变量来存储有关纹理的信息。

```cpp
private:
    // Total Bytes of Texture Data
    uint32 TextureDataSize;

    // Texture Data Sqrt Size
    uint32 TextureDataSqrtSize;

    // Total Count of Pixels in Texture
    uint32 TextureTotalPixels;
```

接下来我们需要一个用于实际纹理对象的变量。更改 **TextureData ** 后，需要使用新的像素值进行更新，稍后查看更多信息。我们还需要一个 FUpdateTextureRegion2D 指针变量。

```cpp
private:
    // Texture Object
    UPROPERTY()
    UTexture2D* DynamicTexture;

    // Update Region Struct
    FUpdateTextureRegion2D* TextureRegion;
```

为了定义纹理大小，我们需要两个变量。我希望这些可以在编辑器中编辑，因此我添加了 UPROPERTY 说明符。我还将初始大小设置为合理的默认值 512。

```cpp
public:    
    UPROPERTY(EditDefaultsOnly)
    int32 TextureWidth = 512;

    UPROPERTY(EditDefaultsOnly)
    int32 TextureHeight = 512;
```
### 初始化纹理

现在我们需要一个函数来初始化所有值并创建纹理对象。

```cpp
--- Header ---
private:
    void InitializeTexture();


--- CPP ---
void UDynamicTextureComponent::InitializeTexture()
{...}
```

首先我们需要计算纹理的数据大小并初始化纹理数据数组，因此在 IntializeTexture() 中写入

```cpp
// Get Total Pixels in Texture
TotalPixels = TextureWidth * TextureHeight;

// Get Total Bytes of Texture - Each pixel has 4 bytes for RGBA
TextureDataSize = TotalPixels * 4;
TextureDataSqrtSize = TextureWidth * 4;

// Initialize Texture Data Array
TextureData = new uint8[TextureDataSize];
```

然后在InitializeTexture()中我们创建一个瞬态纹理，并设置它的纹理参数。在下面的代码片段中，您可以看到我将“压缩”设置为“VectorDisplacementmap”，关闭了 SRGB，并将“纹理过滤器”设置为“最近”。然后为了防止纹理被垃圾收集，我们将其添加到根，最后更新应用所设置的参数的资源。

```cpp
// Create Dynamic Texture Object
DynamicTexture = UTexture2D::CreateTransient(HorizontalResolution, VerticalResolution, EPixelFormat::PF_R8G8B8A8, "DynamicTexture");
DynamicTexture->CompressionSettings = TextureCompressionSettings::TC_VectorDisplacementmap;
DynamicTexture->SRGB = 0;
DynamicTexture->Filter = TextureFilter::TF_Nearest;
DynamicTexture->AddToRoot();
DynamicTexture->UpdateResource();
```

最后，在 IntializeTexture() 中，我们需要创建 FUpdateTextureRegion2D 结构的实例并设置我们之前创建的变量。

```cpp
//Create Update Region Struct Instance
TextureRegion = new FUpdateTextureRegion2D(0, 0, 0, 0, HorizontalResolution, VerticalResolution);
```

我在 BeginPlay 中调用 InitializeTexture 因为这适合我的目的。值得注意的是，在纹理初始化之前，您无法进行任何调用来修改纹理。我在初始化后调用 super，这样我就可以使用蓝图中的开始播放来修改纹理。

```cpp
void UDynamicTextureComponent::BeginPlay()
{
    InitializeTexture();

    Super::BeginPlay();
}
```
### 调用渲染命令

要更新纹理对象，我们需要调用渲染命令。然而，在执行此操作之前，我们必须告诉 unreal 我们依赖于项目源中 ***ProjectName*.Build.cs** 文件中的两个附加公共依赖模块。您的 Build.cs 将具有不同的名称，而不是 ProjectName，具体取决于您的项目的名称。添加 **RHI **& **RenderCore ** 到 **PublicDependencyModuleNames**，下面是它应该是什么样子的示例：

```cpp
PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "RHI", "RenderCore", "InputCore" });
```

我们还需要向动态纹理组件的 .cpp 文件添加两个包含内容。

```cpp
#include "RHICommandList.h"
#include "Rendering/Texture2DResource.h"
```

现在我们需要一个函数来处理创建和调用渲染命令

```cpp
--- Header ---
private:
    //Update Texture Object from Texture Data
    void UpdateTexture(bool bFreeData = false);
```

```cpp
--- CPP ---
void UDynamicTextureComponent::UpdateTexture(bool bFreeData)
{
    if (DynamicTexture == nullptr)
    {
        UE_LOG(LogTemp, Warning, TEXT("Dynamic Texture tried to Update before being initialized!"));
        return;
    }

    struct FUpdateTextureRegionsData
```

我不会详细介绍其工作原理，但这里是所发生情况的快速概述： 1. 为所有区域数据定义一个结构以传递给渲染命令。 2. 创建该结构的实例并根据纹理变量设置所有值。 3. 创建一个 ENQUEUE_RENDER_COMMAND 来传递我们刚刚定义的区域数据。 4. 调用RHIUpdateTexture2D更新纹理。最后，我们需要调用**UpdateTexture()**来查看对**TextureData**所做的任何更改。然而，每次我们修改 **TextureData ** 时执行此操作都会损害性能，而且更改只会在下一帧上可见，因此为了简单起见，我在 **Tick** 上调用 **UpdateTexture()**。但是，如果您只是偶尔更新动态纹理，则应仅在某些内容发生更改时才调用 **UpdateTexture(**)。就我的目的而言，动态纹理可能会在每个刻度上多次修改，因此最好总是在刻度上更新一次。

```cpp
// Example of the Tick Command
void UDynamicTextureComponent::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
    Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

    UpdateTexture();
}
```
### 修改纹理数据

当纹理数据数组初始化时，初始值可能包含内存中的随机垃圾，因此首先我们应该用初始颜色填充纹理数据。为了让这一切变得简单，让我们从一个非常简单的填充纹理函数开始。如果您想使用纹理资源作为初始状态而不仅仅是纯色，您可以调用我们稍后将创建的 DrawFromTexture() 函数。我们还需要将 FLinearColor 值乘以 255，因为 FLinearColor 介于 0-1 之间，但纹理为 0-255。

```cpp
--- Header ---
public:
    /// Fill Entire Texture with a specified color.
    UFUNCTION(BlueprintCallable, Category = "Dynamic Texture")
    void FillTexture(FLinearColor Color);


--- CPP ---
void UDynamicTextureComponent::FillTexture(FLinearColor Color)
{
```

我在 InitializeTexture() 函数的末尾添加了对 FillTexture 的调用。

```cpp
void UDynamicTextureComponent::InitializeTexture()
{
    ...

    FillTexture(FLinearColor::Black);
    UpdateTexture();
}
```
### 设置像素的颜色

正如我之前提到的，像素的所有值都存储在一个数组中，每个像素通道按顺序 ** B G R A** 因此，要修改单个像素，我们需要做一些数学运算。为了使设置像素更容易，我们可以创建一个函数，将 TextureData 中的设置值抽象为仅设置 X Y 位置的像素颜色。

```cpp
public:
    // Set the Color Value of a Pixel at the given Texture Coordinate
    UFUNCTION(BlueprintCallable, Category="Dynamic Texture")
    void SetPixelColor(int32 X, int32 Y, FLinearColor Color);
```

该函数的工作原理是，通过将纹理宽度乘以 Y 来获取像素数据在数组中的起始位置，以获取水平像素行在数组中的起始位置，然后添加 X 位置，最后乘以 4，即每个像素有多少个值。实际上，我们在纹理中向下移动到右侧，X = 0，Y = 0 是纹理中的左上角像素。然后，我们通过从像素数据在数组中的起始索引开始偏移来设置每个像素颜色值。我们还需要将 FLinearColor 值乘以 255，因为 FLinearColor 介于 0-1 之间，但像素为 0-255。

```cpp
void UDynamicTextureComponent::SetPixelColor(int32 X, int32 Y, FLinearColor Color)
{
    uint32 start = ((Y * TextureWidth) + X) * 4;

    // Ensure Pixel is not outside of the Array
    if (start < 0 || start > TextureDataSize - 4)
    {
        return;
    }
```

请记住，在调用 UpdateTexture() 之前，纹理上实际上不会出现任何变化。
### 添加基本​​绘图功能

在本教程中，我将展示一些绘制动态纹理的示例函数。首先也是最简单的就是画一个矩形。
### 绘制一个矩形

对于高度中的每个 Y 位置，循环遍历宽度中的每个 X 位置，并调用 SetPixelColor 将 StartX/Y 的偏移量添加到给定的 Color。

```cpp
--- Header ---
public:
    // Draw a Rectangle starting from StartX, StartY as Top-Left of the Rectangle.
    UFUNCTION(BlueprintCallable, Category="Dynamic Texture")
    void DrawRectangle(int32 StartX, int32 StartY, int32 Width, int32 Height, FLinearColor Color);


--- CPP ---
void UDynamicTextureComponent::DrawRectangle(int32 StartX, int32 StartY, int32 Width, int32 Height, FLinearColor Color)
{
```

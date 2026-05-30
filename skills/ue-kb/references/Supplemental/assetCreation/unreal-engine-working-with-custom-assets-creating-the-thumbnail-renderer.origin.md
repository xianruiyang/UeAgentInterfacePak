# 使用自定义资源：创建缩略图渲染器

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/DPRe/unreal-engine-working-with-custom-assets-creating-the-thumbnail-renderer

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2676 字符。

## 摘要

了解如何创建具有自定义类别、资产颜色、缩略图等的全新资产。

## 中文整理

### 介绍

在这个简短的教程中，我将完成创建纹理缩略图渲染器的过程，该渲染器可以将自定义资源的任何纹理渲染为内容浏览器中的缩略图。

![示例资产（使用漂亮的 AICON 面孔）](assets/unreal-engine-working-with-custom-assets-creating-the-thumbnail-renderer/image-01.jpg)

### 读者要求

要理解本教程，您应该阅读我的其他[教程](https://dev.epicgames.com/community/learning/tutorials/m3Wq/unreal-engine-working-with-custom-assets-creating-the-asset)，了解如何创建包含自定义 UMyAsset 数据资产的 UAssetDefinition/UFactory。此外，您应该熟悉 C++

### 创建纹理缩略图渲染器

为此，我们需要创建一个从 UTextureThumbnailRenderer 派生的新类，并将 UnrealEd 模块包含在我们的自定义编辑器模块中。

**输出自定义纹理缩略图渲染器**

```cpp
#pragma once

#include "ThumbnailRendering/TextureThumbnailRenderer.h"
#include "MyThumbnailRenderer.generated.h"

class UTexture2D;

UCLASS()
class UMyThumbnailRenderer : public UTextureThumbnailRenderer
{
```

**我们的自定义编辑器模块**

```cpp
using UnrealBuildTool;

public class MyEditor : ModuleRules
{
        public MyEditor(ReadOnlyTargetRules Target) : base(Target)
        {
            PublicDependencyModuleNames.AddRange(new string[]
            {
                "UnrealEd",
            });
```

### 实现纹理缩略图渲染器

为此，我们需要重写 UMyThumbnailRenderer 中的 3 个虚拟函数

```cpp
/** Checks whether the asset can be visualized using this thumbnail renderer.
  * will fallback to default thumbnail if this returns false. */
virtual bool CanVisualizeAsset(UObject* Object) override;

/** To calculate the size of the thumbnail to display, usually should match the textures size*/
virtual void GetThumbnailSize(UObject* Object, float Zoom, uint32& OutWidth, uint32& OutHeight) const override;

/** This actually draws the thumbnail. */
virtual void Draw(UObject* Object, int32 X, int32 Y, uint32 Width, uint32 Height, FRenderTarget*, FCanvas* Canvas, bool bAdditionalViewFamily) override;
```

另外，我将在以后添加一个额外的小帮助方法

```cpp
UTexture2D* GetThumbnailTextureFromObject(UObject* Object) const;
```

**最终结果**

```cpp
#pragma once

#include "ThumbnailRendering/TextureThumbnailRenderer.h"
#include "MyThumbnailRenderer.generated.h"

class UTexture2D;

UCLASS()
class UMyThumbnailRenderer : public UTextureThumbnailRenderer
{
```

现在我们实现这样的功能

```cpp
bool UMyThumbnailRenderer::CanVisualizeAsset(UObject* Object)
{
    // Assuming we can't draw a thumbnail if no texture is present
    return IsValid(GetThumbnailTextureFromObject(Object));
}

void UMyThumbnailRenderer::GetThumbnailSize(UObject* Object, float Zoom, uint32& OutWidth, uint32& OutHeight) const
{
    // We will just call the Super version of this method as it handles all the rest for us
    // All we need to do is to feed in the correct texture using GetThumbnailTextureFromObject()
```

### 注册纹理缩略图渲染器

现在创建它之后，我们还需要告诉虚幻编辑器实际使用它。这可以/应该在自定义编辑器模块中完成为此，我们只需要实现 StartupModule()

**自定义编辑器模块**

```cpp
void FMyEditorModule::StartupModule()
{
    // Lets the Unreal Editor know about our custom thumbnail renderer and maps it to the corresponding asset
    if (GIsEditor)
    {
        UThumbnailManager::Get().RegisterCustomRenderer(UMyAsset::StaticClass(), UMyThumbnailRenderer::StaticClass());
    }
}
```

这就是将自定义纹理渲染为资源缩略图所需的全部内容！对于项目定义之类的事情非常有用，可以快速识别项目的类型。

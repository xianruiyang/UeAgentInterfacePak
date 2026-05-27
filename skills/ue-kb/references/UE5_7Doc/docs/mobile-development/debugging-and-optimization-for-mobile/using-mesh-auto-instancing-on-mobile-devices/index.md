---
title: "移动设备上的网格体自动实例化"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-mesh-auto-instancing-on-mobile-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "移动设备上的网格体自动实例化"]
---

# 移动设备上的网格体自动实例化

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / 移动设备上的网格体自动实例化

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-mesh-auto-instancing-on-mobile-devices-in-unreal-engine

虚幻引擎[**网格体绘制管线**](../../../designing-visuals-rendering-and-graphics/graphics-programming/mesh-drawing-pipeline/index.md)实现合并绘制调用的网格体自动实例化功能，可大大提高图形性能。该功能现在可用于移动设备，但需进行一些额外设置配置。

## 步骤

1. 找到项目的 **Config** 文件夹，然后打开 **DefaultEngine.ini.**。
2. 添加下面几行代码：

   ```
            r.Mobile.SupportGPUScene=1         r.Mobile.UseGPUSceneTexture=1		
   ```

   保存更改并关闭文件。

> [!NOTE]
> 启用此功能将促使为移动平台重建着色器。若将虚幻编辑器设为Android预览模式，编辑器将相应地重新编译着色器。大项目可能有很长的迭代时间。

## 结果

通过为项目启用上述设置，将为所有设备启用自动实例化。`r.Mobile.SupportGPUScene` 在移动设备上启用自动实例化。但它们将与桌面编译使用同一个缓冲区。Mali设备仅支持最大64 kb的缓冲区，通常无法支持此功能。`r.Mobile.UseGPUSceneTexture` 将让自动实例化过程使用纹理而非缓冲区来存储所需信息，因而Mali设备也能使用自动实例化。

## 限制

除[网格体绘制管道](../../../designing-visuals-rendering-and-graphics/graphics-programming/mesh-drawing-pipeline/index.md)页面提到绘制调用合并限制外，自动实例化还有一些针对移动设备的限制：

- 移动设备上的自动实例化主要对严重CPU密集型而非GPU密集型项目有益。尽管启用自动实例化不太可能会损害GPU密集型项目，但不太可能看到显著的性能改进。
- 若游戏需要大量内存，鉴于 `r.Mobile.UseGPUSceneTexture` 在Mali设备上无效，关闭 `r.Mobile.UseGPUSceneTexture` 并使用缓冲区可能会更有益。

自动实例化的有效性在很大程度上取决于项目的具体规范。因此，我们建议你创建启用自动实例化的编译并对其进行分析，从而确定是否会看到显著的性能提升。分析详情，参见[性能和分析](../../../testing-and-optimizing-content/index.md)部分。

# Paper 2D Sprite材质

---
title: "Paper 2D Sprite材质"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper-2d-sprite-material-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D Sprites", "Paper 2D Sprite材质"]
---

# Paper 2D Sprite材质

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D Sprites / Paper 2D Sprite材质

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper-2d-sprite-material-in-unreal-engine

**Sprite材质（Sprite Materials）** 是可分配的[材质](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)资产，会影响关卡中的Sprite外观，例如锐化像素、平滑边缘以及半透明程度。

![选择sprite材质属性](../../../../../assets/images/24/24593f34168e4b0dbbb5a3d7ea634668d73e45c0df6d5a6827005ba1bdebf3c1.jpg)

材质还可能影响Sprite与环境光照交互的方式，甚至可能自己发光。

![sprite材质渲染比较](../../../../../assets/images/26/26b0ecbbfc9ce125a7a609e75533ad341021c1716f9d7cf2f91e0693b27b8705.jpg)

## Sprite材质参考

你可以在此处参考Paper2D插件随附的材质列表，你可以在虚幻引擎中处理Sprite时使用这些材质。

| 材质 | 示例图像 | 说明 |
| --- | --- | --- |
| **DefaultLitSpriteMaterial** | 默认光照sprite材质 | 此材质使用 **默认Sprite纹理设置（Default Sprite Texture Settings）** 作为材质设置。使用此材质还会使Sprite的外观受关卡中的光源影响。 |
| **DefaultSpriteMaterial** | 默认sprite材质 | 此材质会将 **默认Sprite纹理设置（Default Sprite Texture Settings）** 用作材质设置。使用此材质还会使Sprite的外观不受关卡中的光源影响。 引擎内容中有两个DefaultSpriteMaterial，一个是为Paper 2D系统设计的，另一个是为[Niagara粒子系统](../../../../visual-effects/index.md)设计的。你可以将鼠标悬停在材质上来区别这两者，并确保 **路径（Path）** 列出 `/Paper2d` 文件路径。 |
| **MaskedLitSpriteMaterial** | 遮罩光照sprite材质 | 此材质将在背景和关卡中 **遮罩** Sprite，在Sprite和背景之间造成生硬的边界。使用遮罩材质时，不能使用梯度透明度值。使用此材质还会使Sprite的外观受关卡中的光源影响。 |
| **MaskedUnlitSpriteMaterial** | 遮罩无光照sprite材质 | 此材质将在背景和关卡 **遮罩** Sprite，在Sprite和背景之间造成生硬的边界。使用遮罩材质时，不能使用梯度透明度值。使用此材质还会使Sprite的外观不受关卡中的光源影响。 |
| **OpaqueLitSpriteMaterial** | 不透明光照sprite材质 | 此材质将实心层用于整个Sprite对象。此材质不允许Sprite的像素中出现透明度或透明度梯度。如果Sprite包含透明背景，此材质会在背景中填充纯黑色。使用此材质会使Sprite的外观受关卡中的光源影响。 |
| **OpaqueUnlitSpriteMaterial** | 不透明无光照sprite材质 | 此材质将实心层用于整个Sprite对象。此材质不允许Sprite的像素中出现透明度或透明度梯度。如果Sprite包含透明背景，此材质会在背景中填充纯黑色。使用此材质会使Sprite的外观不受关卡中的光源影响。 |
| **TranslucentLitSpriteMaterial** | 半透明光照sprite材质 | 此材质将允许Sprite上出现透明度和透明度梯度。此材质有助于创建可透视的材质，例如窗户或水。使用此材质还会使Sprite的外观受关卡中的光源影响。 透明材质的性能占用程度最高，因此在项目中务必少用这些材质。 |
| **TranlucentUnlitSpriteMaterial** | 半透明无光照sprite材质 | 使用此材质将允许Sprite上出现透明度和透明度梯度。此材质有助于创建可透视的材质，例如窗户或水。此材质的性能占用程度最高，因此务必少用此模式。使用此材质会使Sprite的外观不受关卡中的光源影响。 透明材质的性能占用程度最高，因此在项目中务必少用这些材质。 |

## 自定义Sprite材质

你可以编辑现有的Sprite材质资产，或创建自定义材质资产，以用于在项目中渲染Sprite。

如需详细了解如何创建材质资产，请参阅[材质编辑器指南](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-editor-user-guide/index.md)文档。


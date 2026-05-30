# 轮廓和其他 FX 的覆盖材料

# 轮廓和其他 FX 的覆盖材料

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2694 字符。

## 摘要

有关如何使用网格上的叠加参数创建和应用材质的快速教程。

## 中文整理

### 基本概要

在内容浏览器中，使用以下设置创建新材质。接下来，将发射颜色设置为参数。这将使您能够获得不同的颜色轮廓或效果。使用 TwoSidedSign 节点，添加一个 1 减节点，并将其乘以此处名为 OutlineIntensity 的标量浮点参数。接下来，将 VertexNormalWS（世界空间）节点乘以浮点值标量，并将其通过管道传输到世界位置偏移中。选择静态网格物体，并将该材质的材质实例应用到 Overlay 参数。这将使用该材质实例作为附加材质有效地第二次渲染网格。通过使用 TwoSidedSign 设置，我们在渲染材质时反转网格的法线。轮廓显示为 LineWidth 标量值超过 1，因此扩展了网格的世界位置偏移。在此示例中，为亮绿色轮廓。

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-01.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-02.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-03.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-04.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-05.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-06.jpg)

### 制造一些噪音！

这就是有趣的地方。构建动画噪音。以下设置用于缩放和偏移TextureSample 节点的UV。该纹理是引擎默认的简单噪波纹理。时间节点用于允许 X 和 Y 方向上的每个方向上的快速和慢速偏移值。从“TextureSample”节点中出来，使用“Clamp”节点对值进行标准化，然后将其乘以浮点标量值。它被命名为侵蚀，因为它将有助于减少噪声值对整体效果的影响。 TextureSample 节点下方是一串节点，以 CameraVector 节点和 PixelNormalWS（世界空间）开头，每个节点都连接到一个点积节点。这给了我们菲涅尔效应。接下来的几个节点有助于将菲涅耳值驱动到更高的对比度值。每个参数（Line_Strength、Line_Edge 和 Line_Intensity）与其他参数一样，有助于使材质艺术变得可定向。然后从 Erosion 参数乘数的结果中减去最终结果，然后再次与 OutlineIntensity 参数相乘。然后将最终结果连接到材质的不透明蒙版。注意：如果您希望效果出现在原始网格后面，从而提供轮廓效果，请保留图形中的 TwoSidedSign 和后续节点，这些节点可以添加到最后一个乘数之后，并连接到材质节点上的 OpacityMask。

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-07.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-08.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-09.jpg)

![教程图片](assets/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx/image-10.jpg)

### 结论

在虚幻引擎中，有无数种方法可以让您的项目风格化。使用覆盖参数只是其中之一。在下面的资源中探索本教程和其他教程。最重要的是玩得开心！

### 资源

- Deconstructing A Stylized Comic Shader - Stylized Materials for Linear Content - Simple Stylization Techniques in Unreal Engine 5 - 程序和脚本设计 - animation - materials

## 相关链接

- [Basic Outline](https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx#basicoutline)
- [Make Some Noise!](https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx#makesomenoise!)
- [Conclusion](https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx#conclusion)
- [Resources](https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx#resources)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/zj3x/unreal-engine-fortnite-overlay-materials-for-outlines-and-other-fx#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)


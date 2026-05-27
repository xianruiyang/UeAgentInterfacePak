---
title: "坐标材质表达式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/coordinates-material-expressions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质表达式参考", "坐标材质表达式"]
---

# 坐标材质表达式

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质表达式参考 / 坐标材质表达式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/coordinates-material-expressions-in-unreal-engine

## ActorPositionWS

**ActorPositionWS** 输出向量3(RGB)数据，该数据表示对象在世界场景空间中的位置以及其上的材质。

![Actor Position WS表达式](../../../../../assets/images/02/02a71339cbf23859da59bfdc0078b8810cf8d5a5db989f3c9ace38dfe527948c.png)

在此示例中，ActorPositionWS被直接输入到材质的底色（Base Color）中。因此，当每个对象被移至三维空间中的不同位置时，每个球体以及应用于它们的材质将显示不同的颜色。请注意，ActorPositionWS节点的结果将除以1600，以创建一个漂亮的颜色过渡效果，而不是让颜色突然切换。

## CameraPositionWS

**CameraWorldPosition** 表达式会输出一个三通道向量值，该值表示摄像机在世界场景空间中的位置。

在下面的示例中，摄像机位置（Camera Position）被输入材质的底色。请注意当摄像机位置改变时，预览球体如何改变颜色。

## LightmapUVs

**LightmapUVs（光照贴图 UV）**表达式以双通道向量值形式输出光照贴图 UV 纹理坐标。如果无法获得光照贴图 UV，那么将输出双通道向量值 (0,0)。

## ObjectOrientation

**ObjectOrientation** 表达式输出应用材质的对象的向上空间向量。换言之，对象的局部正z轴正指向此方向。

![Object Orientation表达式](../../../../../assets/images/91/9138f228d7981954fc3a6344c14282415deb454857f2272fc053160c8b66afdc.jpg)

## ObjectPositionWS

**ObjectPositionWS** 表达式输出对象边界的世界场景空间中心位置。下图中的每个球体都呈现出不同的颜色，因为它们被移动到了空间中的不同位置。在关卡中，RGB颜色通道分别对应X、Y和Z轴。此节点在为植物创建球形照明时很有用。

![Object Position表达式](../../../../../assets/images/8b/8b5f14b0f4897ac00b8ab3440fb547f3126640c1d7cc793e6cf937cce448e614.jpg)

## ObjectRadius

**ObjectRadius（对象半径）**输出给定对象以 Unreal 单位计的半径值。系统会对比例缩放加以考虑，并且对于每个对象，结果可能是唯一的。

![Object Radius expression](../../../../../assets/images/aa/aa4bbe9dcccc9878d039433ce71f370aeb6f98aed2fad6b33eb841c81acb75a1.jpg)

在此示例中，两个网格都接收此材质，而在此材质中，ObjectRadius（对象半径）将输送到"漫射"（Diffuse）中。ObjectRadius（对象半径）输出将除以 512，以提供更有意义的视觉效果。

## Panner

**Panner（平移）**表达式输出可用于创建平移（或移动）纹理的 UV 纹理坐标。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **速度 X（SpeedX）** | 指定在 U 方向上平移坐标的速度。 |
| **速度 Y（SpeedY）** | 指定在 V 方向上平移坐标的速度。 |
| 输入 |  |
| **坐标（Coordinate）** | 接收可以通过表达式来修改的基本 UV 纹理坐标。 |
| **时间（Time）** | 接收用来确定当前平移位置的值。这通常是用来提供常量平移效果的 [Time（时间）](../constant-material-expressions/index.md#time) 表达式，但是，也可以使用 [Constant（常量）](../constant-material-expressions/index.md#constant) 或 [ScalarParameter（标量参数）](../material-parameter-expressions/index.md#scalarparameter) 来设置特定偏移，或者通过 Matinee 或蓝图来控制平移。 |

Panner（平移）会生成根据"时间"（Time）输入而变化的 UV。"坐标"（Coordinate）输入可用于处理 Panner（平移）节点所生成的 UV（例如，使其偏移）。

## 粒子位置WS

**粒子位置WS（ParticlePositionWS）** 表达式输出代表世界场景空间中每个单独粒子位置的Vector3(RGB)数据。

![Particle Position WS example](../../../../../assets/images/4d/4d7a32c6c98786e3c278558adfdf053dd8f09015b2bcb58f4824e774ff3f59e8.jpg)

在这幅图像中，粒子位置WS（ParticlePositionWS）被馈送到自发光颜色中来显示数据。粒子系统被放大以显示颜色是如何根据位置变化的。

## PixelNormalWS

**PixelNormalWS** 表达式根据当前法线输出向量数据，该数据表示像素所面对的方向。

![Pixel Normal WS示例](../../../../../assets/images/d6/d662c4fbb971f27950b00547c6789a1b627f3abcec287001ff68693e31064a3b.jpg)

在此示例中，PixelNormalWS被输入到底色（Base Color）中。请注意，法线贴图用于给出逐像素结果。

## Rotator

**Rotator（旋转）**表达式以双通道向量值形式输出 UV 纹理坐标，该向量值可用来创建旋转纹理。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **中心 X（CenterX）** | 指定旋转中心的 U 坐标。 |
| **中心 Y（CenterY）** | 指定旋转中心的 V 坐标。 |
| **速度（Speed）** | 指定以顺时针方向旋转坐标的速度。 |
| 输入 |  |
| **坐标（Coordinate）** | 接收可以通过表达式来修改的基本 UV 纹理坐标。 |
| **时间（Time）** | 接收用来确定当前旋转位置的值。这通常是用来提供常量旋转效果的 [Time（时间）](../constant-material-expressions/index.md#time) 表达式，但是，也可以使用 [Constant（常量）](../constant-material-expressions/index.md#constant) 或 [ScalarParameter（标量参数）](../material-parameter-expressions/index.md#scalarparameter) 来设置特定偏移，或者通过 Matinee 或蓝图来控制旋转。 |

## SceneTexelSize

**SceneTexelSize（场景纹素大小）**表达式允许按纹素大小进行偏移，正如你使用 SceneColor（场景颜色）和 SceneDepth（场景深度）表达式时执行的偏移操作。这对于在多分辨率系统中检测边缘十分有用，因为不进行此计算时，你就必须使用较小的静态值，从而导致分辨率较低时结果不一致。

## ScreenPosition

**ScreenPosition（屏幕位置）**表达式输出当前所渲染像素的屏幕空间位置。

![Screen Position example](../../../../../assets/images/9f/9ff64cdb921ccc5210704aea102de35c0eab85f266b3d5aa0c8efe00587d992d.jpg)

## TextureCoordinate

**TextureCoordinate（纹理坐标）**表达式以双通道向量值形式输出 UV 纹理坐标，从而允许材质使用不同的 UV 通道、指定平铺以及以其他方式对网格的 UV 执行操作。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **坐标索引（Coordinate Index）** | 指定要使用的 UV 通道。 |
| **U 平铺（UTiling）** | 指定 U 方向上的平铺量。 |
| **V 平铺（VTiling）** | 指定 V 方向上的平铺量。 |
| **撤销镜像 U（Un Mirror U）** | 如果为 *true*，那么撤销 U 方向上的所有镜像。 |
| **撤销镜像 V（Un Mirror V）** | 如果为 *true*，那么撤销 V 方向上的所有镜像。 |

**用法示例：** 如需访问网格体的第二个 UV 通道，请创建一个 TextureCoordinate（纹理坐标）节点，将其"坐标索引"（CoordinateIndex）设置为 1（0 表示第一个通道，1 表示第二个通道，等等），并将其连接到 TextureSample（纹理取样）节点的 UV 输入。

![Texture Coordinate Example](../../../../../assets/images/a9/a9bb561690c263199f86c8ca0de3e979337545c162fa77407e8634370615879e.jpg)

## VertexNormalWS

**VertexNormalWS** 表达式输出世界场景空间顶点法线。它只能用于在顶点着色器中执行的材质输入，例如WorldPositionOffset。该表达式对于设置网格体增大或缩小很有用。请注意，沿法线偏移位置会导致几何图形沿UV缝隙拆分。

在上面的示例中，由于每个顶点在各自的法线方向上移动，预览球体似乎会随着正弦运动按比例放大和缩小。

## VertexTangentWS

**VertexTangentWS** 表达式会输出世界空间的顶点切线。和VertexNormalWS一样，它可用于操控网格体的顶点位置，结合 **世界位置偏移** 输入，你可以制作出十分微妙的环境动画。

在上述示例中，球体上的每个顶点都沿着世界空间的顶点切线做正弦运动。这给人产生了球体在左右摆动的效果。在平面上，它导致平面沿着顶点切线左右摆动。

## ViewSize

**ViewSize（视图大小）** 表达式输出一个 2D 向量，以给出当前视图的大小（以像素为单位）。这对于使材质根据当前屏幕分辨率产生各种变化来说非常有用。

在此示例中，ViewSize（视图大小）输送到"底色"（Base Color）。结果将除以 2,400，以提供更有意义的结果。当预览窗口的尺寸增加或减少时，球体的颜色会发生变化。

## WorldPosition

**WorldPosition（全局位置）**表达式输出当前像素在全局空间中的位置。要实现可视化，只需将输出连接到"自发光"（Emissive）：

> 图片已省略：World Position Example

常见用法是确定从摄像机到像素的径向距离，而不是像 PixelDepth（像素深度）那样确定正交距离。WorldPosition（全局位置）也可用作纹理坐标，并让不相关的网格在它们彼此邻近时进行纹理坐标匹配。以下是使用 WorldPosition.xy 对纹理进行二维贴图的基本示例：

> 图片已省略：Planar projection WS

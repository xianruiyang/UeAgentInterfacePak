---
title: "矩形光源"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/rectangular-area-lights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "光源类型及其可移动性", "矩形光源"]
---

# 矩形光源

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 光源类型及其可移动性 / 矩形光源

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/rectangular-area-lights-in-unreal-engine

**矩形光源（Rect Light）** 从一个定义好宽度和高度的矩形平面向场景发出光线。您可以用它来模拟拥有矩形面积的任意类型光源，如电视或显示器屏幕、吊顶灯具或壁灯。

> [!NOTE]
> 矩形光源的行为并非在所有情况下都与真实面积光源一样。请参阅下面有关移动性设置的讨论。

每个矩形光源有两个关键设置 **源宽度（Source Width）** 和 **源高度（Source Height）**，用于沿局部Y和Z轴确定矩形尺寸：

![源宽度和源高度](../../../../../assets/images/be/bef8d62f1bef066e2f475b128ef2bde28ebc5e6b4e8ff12bf5ca9aa92d3ee07a.jpg)

矩形光源拥有球形衰减半径，就像点光源或聚光源一样。如上图所示，矩形光源仅在沿着局部X轴的正方向的球形衰减范围内发射光线，类似于将聚光源的锥形设置为180度。但是，矩形光源的高光区会显示光源矩形面积的宽度和高度。

像其他类型的光源一样，矩形光源有三个移动性设置：

- 静态（Static）：

  通过该设置，在为关卡构建照明时，光源的直接和间接照明都会烘焙到光照贴图。这是最快的渲染方法，但也意味着，不能在运行时更改游戏中的光源。
- 固定（Stationary）：

  通过该设置，在为关卡构建照明时，只会将来自光源的间接照明烘焙到光照贴图。游戏中光源的直接光线投射将逐帧动态计算。该设置保留Lightmass预先计算的高质量柔和阴影和全局光照，但也允许您在运行时更改游戏中的光线颜色和强度。
- 可移动（Movable）：

  如果使用该设置，则光源是完全动态的。Lightmass完全不会烘焙其任何直接或间接照明。这样在运行时，游戏中的光源可以逐帧从运动物体投射正确的阴影。但是，这种设置通常是渲染最慢的方法。

![Rect Light Example](../../../../../assets/images/90/902e7ce83d67b34ce61d9ebbf9862f8f0eff5cbe7fa2b4e793caf4eaa1c379e9.jpg)

您选择的移动性设置也会明显影响矩形光源向场景投射光线的方式：

- 如果您的矩形光源设置为 **静态（Static）** 或 **固定（Stationary）**，则Lightmass在计算来自光源的光线投射时，会考虑光源的宽度和高度。例如，在上方左图中，来自矩形左右范围的光线到达模型下面，照亮了大部分地面。 在此情况下，从矩形光源发射出来的光线是在其矩形表面的多个点处进行的采样。每个采样光线发射出一小部分光强度，所以您可以将矩形光源理解为，对矩形表面分布的许多微弱点光源的模拟。样本数量随着照明构建质量而增加。预览构建使用少量样本，因此阴影看起来浓淡不均。但是，提高质量设置最终会产生更均匀的结果，如上所示。

  > [!TIP]
  > 如果您将矩形光源的移动性设置为 **固定（Stationary）**，则同时启用 **对固定光源使用面积阴影（Use Area Shadows for Stationary Light）** 设置可以实现质量更好的阴影效果。
- 如果您将矩形光源设置为 **可移动（Movable）**，则矩形的宽度和高度仅用于高光反射。实际光线是从矩形光源中心向外发射出来的，类似于点光源。例如，在上方右图中，地板上投射的边缘鲜明的阴影表示，光线是从矩形中心发射出来的。

设置为 **固定（Stationary）** 或 **可移动（Movable）** 的矩形光源的渲染成本通常高于具有相同移动性设置的点光源或聚光源。确切的成本范围取决于平台，但总的来说，可移动光源成本高于固定光源。产生成本的部分原因是阴影投射，因此可以关闭 **投射阴影（Casts Shadows）** 选项来尽量减少额外成本。或者，您可以选择将光源移动性设置为 **静态（Static）**，该设置对运行时渲染性能毫无影响。

> [!NOTE]
> 向前渲染目前不支持矩形光源。如果您需要在项目中使用向前渲染，请使用聚光源或点光源。

## 矩形光源属性

**矩形光源** 的属性划分为四个类别：[光源](#%E5%85%89%E6%BA%90)、[Lightmass](#lightmass)、[光照函数](#%E5%85%89%E7%85%A7%E5%87%BD%E6%95%B0)和[光源描述文件](#%E5%85%89%E6%BA%90%E6%8F%8F%E8%BF%B0%E6%96%87%E4%BB%B6)。

### 光源

| 属性 | 说明 |
| --- | --- |
| **强度（Intensity）** | 光源发射出的总能量。请注意，对于矩形光源，该值是根据光源表面面积求取的平均值。随着光源的源宽度和源高度的增加，您需要增大强度来保持相同的表观亮度。 |
| **光色（Light Color）** | 光源发射出的颜色。 |
| **衰减半径（Attenuation Radius）** | 约束光源的可见影响。像点光源或聚光源一样，矩形光源拥有球形衰减半径。 |
| **源宽度（Source Width）** | 矩形光源沿局部Y轴的长度。 |
| **源高度（Source Height）** | 矩形光源沿局部Z轴的长度。 |
| **挡光板角度（Barn Door Angle）** | 矩形光源附带的挡光板角度。 |
| **挡光板长度（Barn Door Length）** | 矩形光源附带的挡光板长度。 |
| **源纹理（Source Texture）** | 指定将应用于发射光线的矩形的纹理。该纹理影响矩形光源发出的光色，并且在高光反射中可见。但请注意，这只是近似值。它不影响矩形光线投射的阴影。 如果可能，请使用HDR图像来避免条带状瑕疵。 此外，确保将纹理的 **细节层次（Level of Detail）>Mip生成设置（Mip Gen settings）** 选项设置为 **Blur5**。 |
| **温度（Temperature）** | 以开尔文(K)为单位表示光源的色温。 |
| **使用温度（Use Temperature）** | 确定是否应对该光源应用温度设置。 |
| **影响场景（Affects World）** | 完全启用和禁用光源。不能在运行时设置。要在运行时禁用光源效果，更改其"可见性（Visibility）"属性。 |
| **投射阴影（Cast Shadows）** | 确定光源是否从关卡中的对象投射阴影。 |
| **间接照明强度（Indirect Lighting Intensity）** | 调节来自光源的间接照明。 |
| **体积散射强度（Volumetric Scattering Intensity）** | 调节该光源的体积散射的强度和颜色。 |
| **高级设置** |  |
| **强度单位（Intensity Units）** | 确定应如何解译光源的强度设置。 |
| **高光比例（Specular Scale）** | 反射高光上的乘数。请谨慎使用！1以外的任意值皆非物理效果！可用于为艺术效果而移除高光模拟偏振滤镜或照片润色。 |
| **阴影分辨率比例（Shadow Resolution Scale）** | 调节用来计算该光源投射的动态阴影的阴影贴图分辨率。默认情况下，根据阴影投射源的屏幕大小计算该值。请注意，该值受到全局r.Shadow.MaxResolution设置值的限制。 |
| **阴影偏差（Shadow Bias）** | 控制该光源的阴影的精确程度。 |
| **阴影滤波锐化（Shadow Filter Sharpen）** | 对该光源的阴影过滤的锐化程度。 |
| **接触阴影长度（Contact Shadow Length）** | 明显接触阴影的屏幕空间到光线跟踪的长度。值0禁用此选项。 |
| **以场景空间单位表示的接触阴影长度（Contact Shadow Length in World Space Units）** | 确定是以场景空间单位还是以屏幕空间单位来解译接触阴影长度设置。 |
| **投射半透明阴影（Cast Translucent Shadows）** | 确定是否允许该光源通过半透明物体投射动态阴影。 |
| **仅从动画对象投射阴影（Cast Shadows from Cinematic Objects Only）** | 确定该光源是否仅从启用了"投射动画阴影（Cast Cinematic Shadows）"选项的组件投射阴影。 |
| **动态间接照明（Dynamic Indirect Lighting）** | 确定是否应在"光线传播体积（Light Propagation Volumes）"中包含该光源。 |
| **对可移动Primitives强制使用缓存阴影（Force Cached Shadows for Movable Primitives）** | 启用时，该光源将为可移动Primitives生成缓存阴影，即使禁用了全局r.shadow.cachedshadowscastfrommovableprimitives设置也是如此。 |
| **光照通道（Lighting Channels）** | 确定该光源应该影响哪些光照通道。 |
| **投射静态阴影（Cast Static Shadows）** | 确定该光源是否应该从静态对象投射阴影。 |
| **投射动态阴影（Cast Dynamic Shadows）** | 确定该光源是否应该从可移动对象投射阴影。 |
| **影响半透明光照（Affect Translucent Lighting）** | 确定该光源是否应该影响半透明度。如果您的场景包含许多小光源，则禁用该设置会节省GPU时间。 |
| **传输（Transmission）** | 确定该光源投射的光线是否根据次表面散射描述文件透过表面传输。 |
| **投射体积阴影（Cast Volumetric Shadow）** | 确定该光源是否从体积雾投射阴影。 |

### Lightmass

这个部分中的设置特定于[Lightmass](../../global-illumination/index.md)全局光照系统对该光源的处理方式。

| 属性 | 说明 |
| --- | --- |
| **间接光照饱和度（Indirect Lighting Saturation）** | 确定该光源在烘焙光照贴图中的饱和度。值0对该光源进行完全去饱和；1保持不变。 |
| **阴影指数（Shadow Exponent）** | 控制阴影半影的衰减。 |
| **对固定光源使用面积阴影（Use Area Shadows for Stationary Light）** | 确定是否对固定光源使用面积阴影。这会随着与投射源距离的增加让阴影变得柔和，但在阴影清晰的地方，需要更高的光照贴图分辨率来获得理想结果 |

### 光照函数

使用该部分中的设置为该光源设置[光照函数](../../features-and-properties-of-lights/using-light-functions/index.md)。

| 属性 | 说明 |
| --- | --- |
| **光照函数材质（Light Function Material）** | 要应用于该光源的光照函数材质。 |
| **光照函数比例（Light Function Scale）** | 调节光照函数投影。 |
| **淡化距离（Fade Distance）** | 光照函数应完全淡化到"禁用亮度（Disabled Brightness）"中的值的距离。 |
| **禁用亮度（Disabled Brightness）** | 指定但禁用了光照函数时，要应用于光源的亮度系数——例如，超出了上述淡化距离设置所设定的最大范围。 |

### 光源描述文件

使用该部分中的设置为该光源设置[IES描述文件](../../features-and-properties-of-lights/using-ies-light-profiles/index.md)。

> [!NOTE]
> 请注意，矩形光源从光源中心投影IES描述文件，而不是沿着光源的矩形面积边进行投影。这可能会产生意外结果。

| 属性 | 说明 |
| --- | --- |
| **IES纹理（IES Texture）** | 分配给光源描述文件的IES纹理资源。请注意，IES文件是ASCII文件，而不是图像文件，虽然虚幻会将它们表示纹理。 |
| **使用IES亮度（Use IES Brightness）** | 确定光源亮度来源。启用该选项时，光源使用IES描述文件中设置的亮度，以流明为单位。禁用该选项时，光源使用其强度设置。 |
| **IES亮度比例（IES Brightness Scale）** | 启用IES亮度时，调节亮度影响以避免场景光线过强。 |

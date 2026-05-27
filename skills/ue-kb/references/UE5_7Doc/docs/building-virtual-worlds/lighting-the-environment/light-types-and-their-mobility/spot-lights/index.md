---
title: "聚光源"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/spot-lights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "光源类型及其可移动性", "聚光源"]
---

# 聚光源

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 光源类型及其可移动性 / 聚光源

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/spot-lights-in-unreal-engine

**聚光源**会从圆锥形中的单个点发出光线。 用户可利用两个圆锥形来塑造光源的形状：**内锥角**和**外锥角**。 在内圆锥角中，光照将达到完整亮度。 从内半径的范围进入外圆锥角的范围中时将发生衰减，形成一个半影，或在聚光源照明圆的周围形成柔化效果。 光照的半径将定义圆锥的长度。 简单而言，它的工作原理类似于手电筒或舞台照明灯。

和其他光源一样，聚光源可设为以下3种移动性设置中的一种：

- **静态（Static）** - （左图）即无法在游戏中改变光源。 这是最快的渲染方法，可用于已烘焙的光照。
- **固定（Stationary）** - （同见左图）即光源通过Lightmass只烘焙静态几何体的投影和反射光照。其他则为动态光照。 该设置还允许光源在游戏中更改颜色和强度，但它不会移动且允许局部烘焙光照。
- **可移动（Moveable）** - （左图）即为完全动态光源，可进行动态投影。 这是最慢的渲染方法，但在游戏过程中拥有最高灵活性。

以下示例显示了放置在关卡中的**聚光源**，展示了对光源范围和椎体效应器的决定方式：

![无圆锥显示的聚光源](../../../../../assets/images/06/063a4fe1ad40ff14505691cd6be43bf70a86433bdb1f2bc7c8447f9ae661a791.jpg)

![带有圆锥显示的聚光源](../../../../../assets/images/61/617e1151bf2f911544cea50b1f478070f59ff1dee1dc4851636f94aee0889805.jpg)

无圆锥显示的聚光源

带有圆锥显示的聚光源

左侧的聚光源未利用椎体显示光源范围，而右侧的相同聚光源则以椎体效应器显示了自身范围。

## 聚光源属性

聚光源的属性分为以下4类：光源、光源描述文件、Lightmass，以及光照函数。

### 光源

| 属性 | 说明 |
| --- | --- |
| **强度（Intensity）** | 光源发射的总能量。 |
| **光源颜色（Light Color）** | 光源发出的颜色。 |
| **内锥角（Inner Cone Angle）** | 设置聚光源的内锥角（以度为单位）。 |
| **外锥角（Outer Cone Angle）** | 设置聚光源的外锥角（以度为单位）。 |
| **衰减半径（Attenuation Radius）** | 限制光源的可见影响。 |
| **源半径（Source Radius）** | 光源的源形状半径。 |
| **源长度（Source Length）** | 光源形状的长度。 |
| **影响世界（Affects World）** | 完全禁用光源。 无法在运行时设置。 要在运行时禁用光源效果，需修改其可视性属性。 |
| **投射阴影（Casts Shadows）** | 光源是否投射阴影。 |
| **间接光照强度（Indirect Lighting Intensity）** | 缩放光源发出的间接光照贡献。 |
| **使用反转平方衰减（Use Inverse Squared Falloff）** | 是否使用基于物理的反转平方距离衰减，其中衰减半径仅限制光照贡献。 |
| **光源衰减指数（Light Falloff Exponent）** | 禁用UseInverseSquaredFalloff时，控制光源的径向衰减。 |
| **最小粗糙度（Min Roughness）** | 对此光照产生作用的最小粗糙度。用于柔化反射高光。 |
| **阴影偏差（Shadow Bias）** | 控制此光源所投射阴影的精确度。 |
| **阴影过滤锐化（Shadow Filter Sharpen）** | 此光源投射阴影过滤的锐化程度。 |
| **投射半透明阴影（Cast Translucent Shadows）** | 该光源是否可从半透明物体处投射动态阴影。 |
| **影响动态间接光照（Affect Dynamic Indirect Lighting）** | 是否应将光源注入光传播体积。 |
| **投射静态阴影（Cast Static Shadows）** | 此光源是否投射静态阴影。 |
| **投射动态阴影（Cast Dynamic Shadows）** | 此光源是否投射动态阴影。 |
| **影响半透明光照（Affect Translucent Lighting）** | 光源是否影响半透明度。 |

### 光源描述文件

| 属性 | 说明 |
| --- | --- |
| **IES纹理（IES Texture）** | 用于光源描述文件的IES"纹理"。 虚幻引擎将IES文件显示为纹理，其实际上是ASCII，并非图像文件。 |
| **使用IES亮度（Use IES Brightness）** | 若为*false*，将使用光源亮度决定产生的光源量。 若为*true*，将使用IES文件亮度（以流明计）（通常远大于虚幻引擎光源上的默认值）。 |
| **IES亮度比例（IES Brightness Scale）** | IES亮度贡献的比例，其可能会使场景严重曝光。 |

### Lightmass

| 属性 | 说明 |
| --- | --- |
| **间接光照饱和度（Indirect Lighting Saturation）** | 数值为0时将完全去除该Lightmass光源的饱和度，为1时保持不变。 |
| **阴影指数（Shadow Exponent）** | 控制阴影半影的衰减。 |

### 光源函数

| 属性 | 说明 |
| --- | --- |
| **光源函数材质（Light Function Material）** | 应用于该光源的光照函数材质。 |
| **光源函数缩放（Light Function Scale）** | 缩放光照函数投射。 |
| **光源函数淡化距离（Light Function Fade Distance）** | 光照函数应完全淡化到禁用亮度（Disabled Brightness）值的距离。 |
| **禁用亮度（Disabled Brightness）** | 当光照函数已指定但被禁用时，应用于光源的亮度因子，例如从上面的属性来讲：光照函数淡化距离（Light Function Fade Distance）。 |

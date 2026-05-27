---
title: "阴影"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/shadowing-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "阴影"]
---

# 阴影

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 阴影

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/shadowing-in-unreal-engine

阴影能让对象仿佛真的置于场景地面之上。它们能为观众提供一种深度和空间感。虚幻引擎中所有[光源类型](../light-types-and-their-mobility/index.md)都支持阴影，其效果由光源的移动性决定。

## 支持的阴影方法

光源使用的阴影类型取决于其移动性（Mobility）设置：**静态（Static）**、**固定（Stationary）** 或 **可移动（Movable）**。移动性（Mobility）是主要引导因素，决定了光源应如何投射阴影：烘焙到纹理（称为光照贴图）中的预计算阴影、实时生成的动态阴影还是使用预计算阴影和动态阴影的组合。

光源移动性的设置可独立于关卡中的其他光源设置，这意味着你可以使用任意移动性组合来照亮场景。

可供使用的阴影方法如下：

> [!NOTE]
> 有些方法需要启用项目设置（Project Settings），或对光源（Light）启用其他属性才能工作。

- 阴影贴图

  - 这是默认阴影方法，可以将几何体渲染为阴影深度图。这种阴影方法适用于所有支持动态阴影的平台，但它需要手动设置阴影距离并且只能逐个组件剔除，从而导致高多边形场景性能不佳。此外，它不支持

    Nanite

    几何体。
- 虚拟阴影贴图

  - 这种阴影方法将几何体渲染为虚拟化的阴影深度图。它通过简化的设置为下一代项目提供高质量的阴影。与

    Nanite

    几何体一起使用时，具备高效剔除能力。
- 光线追踪阴影

  - 此方法使用

    硬件光线追踪

    和去噪算法逐像素跟踪一组设定数量的样本，从而实时渲染高质量的光线追踪阴影。
- 距离场阴影

  - 此方法对每个静态网格体使用有向距离场，

    Lumen软件光线追踪

    将其用于动态柔和区域阴影。
- 使用Lightmass的预计算阴影

  - 此方法使用场景中的光照数据生成光照贴图纹理，应用于关卡中的静态几何体。几何体需要使用适当的光照贴图UV进行额外设置。对于确定光源构建所需的时间，场景的预计算光照受多种因素的影响，如机器规格、场景复杂性等。

## 静态和固定光源预览阴影

在编辑移动性（Mobility）设置为 **Stationary（固定）** 或 **Static️（静态）** 的光源时，光源被视为 *未构建* 。启用 **预览阴影（Preview Shadowing）** 可让你了解重建光照时阴影的效果，但这并不代表最终的烘焙结果。

为表明哪些是实际的预览阴影，这些光源的阴影会显示在关卡编辑器（Level Editor）中，并带有文本 **预览（Preview）**。

> [!NOTE]
> 只有在关卡编辑器（Level Editor）中工作时，阴影上才会显示预览文本。如果项目的启动模式为：在编辑器中运行（Play-In-Editor (PIE)）或独立游戏（Standalone Game），则未构建的阴影上不会出现任何文本。

要解析任何预览阴影，你需要构建光照。使用主菜单选择 **构建（Build）> 构建所有关卡（Build All Levels）** 以启动光照构建。

| 列 1 | 列 2 |
| --- | --- |
| built scene shadows | preview shadows |
| 构建场景阴影 | 预览阴影 |

在编辑器中工作时可以禁用预览阴影，方法是取消选中关卡视口（Level Viewport）**显示（Show）> 可视化（Visualize）** 菜单下的 **预览阴影指示器（Preview Shadows Indicator）**。

## 配置光源的阴影属性

以下属性位于可用的[光源类型](../light-types-and-their-mobility/index.md)中。

选择光源后，可以通过关卡的 **细节（Details）** 面板访问这些属性。

| 列 1 | 列 2 | 列 3 | 列 4 | 列 5 |
| --- | --- | --- | --- | --- |
| directional light properties | sky light properties | point light properties | spot light properties | rect light properties |
| 定向光源 | 天空光照 | 点光源 | 聚光源 | 矩形光源 |

点击图片查看大图。

### 源角度、半径、高度和宽度

每种类型的光源都提供了一个选项，用于设置其光源的角度、半径或高度和宽度，以控制它投射的阴影的大小和形状。较大的角度、半径、高度和宽度可以柔化受光源影响的对象的阴影。

在下面的示例中，左侧聚光源未指定源半径，会产生锐利的阴影。右侧聚光源指定了一个适中的源半径，会根据与物体之间的距离来柔化该光源的阴影。

![source radius example](../../../../assets/images/88/889b44c8b8b9a07b54b710a525bf474779f2d6d775d6533eb6f99f6922f9f41e.jpg)

在关卡编辑器（Level Editor）视口中查看聚光源（Spot Light）时，可看到光源的源半径由右侧聚光源上的黄色球体表示。

![source radius editor example](../../../../assets/images/35/3514fc64e926f7d399f5d05e5dec51d0ccd6639d01e63a2b0bf9a380e5d3b71d.jpg)

点光源、聚光源和矩形光源都有一个可见的光源大小，在编辑时会实时更新。

![point, spot, rect light source sizes](../../../../assets/images/ef/ef7f76f0213f6198b01d1cabbb3db3fd174a55206c93d6ecb152360ed7eafe50.jpg)

点光源和聚光源有一个额外的选项来控制源半径（Source Radius）的长度，使用 **源长度（Source Length）** 属性，可以创建管状的圆柱形光形状。

![point and spot light source length](../../../../assets/images/a1/a15b7b974eb31293bf6c1be56a85de1956c7da801c935a90a38db9ea95b02ccf.jpg)

### 衰减半径

点光源、聚光源和矩形光源的 **衰减半径（Attenuation Radius）** 使你能够设置此光源将影响的边界区域。尽管这在物理上并不准确，但对于性能来说，限制动态阴影投射光源的边界非常重要。

在下面的示例中，左侧聚光源的衰减半径小于右侧聚光源的衰减半径。请注意光源如何仅影响其半径最远点内的区域。

![light attenuation radius example](../../../../assets/images/e6/e6f838dd7039d9e5722dd2681d6ad728a86bebc3ecf88de5597eb2200bc89e6e.jpg)

选择光源后，你可以看到衰减半径的距离如何影响其区域内的对象，而不会影响其范围之外的对象。

![light attenuation radius editor view](../../../../assets/images/5f/5fbc98f9e6ff9065946d9b64b3cd05eb6863c0fde9ba5c7a467b6f5bfe98e4cb.jpg)

### 投射阴影

**投射阴影（Cast Shadow）** 控制选中的光源是否应该为场景产生阴影。

![shadow casting on and off](../../../../assets/images/26/26a4eb99e2a6c703e805a8e19b7398a86eb311a57ae73d3718eee2c51a489123.jpg)

左，阴影投射已启用；右，阴影投射已禁用。

### 体积阴影

**体积散射强度（Volumetric Scattering Intensity）** 在启用时调整雾气强度和光源颜色。它使光源能够对雾气做出更多贡献，而无需直接增加其强度。

为场景启用时，光源将产生[体积雾（Volumetric Fog）](../environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-fog/index.md)。

你可以使用 **体积散射强度（Volumetric Scattering Intensity）** 控制单个光源对体积雾的贡献。默认情况下，光源的体积阴影是禁用的，但可以使用 **投射体积雾（Cast Volumetric Fog）** 启用。

![体积阴影：禁用（默认）](../../../../assets/images/4f/4f3d313f90541462794f9d3a997d4df3196f16b939041d7be3edfdf0a56b84a8.jpg)

> 图片已省略：体积阴影：启用

体积阴影：禁用（默认）

体积阴影：启用

### 全局光照间接光照

[全局光照](../global-illumination/index.md)为场景提供间接光照，光线照射到表面并在空间内反射。它为空间内地面对象的表面提供填充光照和柔和区域阴影。虚幻引擎支持使用Lightmass的预计算烘焙全局光照的间接光照，并使用[Lumen](../global-illumination/lumen-global-illumination-and-reflections/index.md)和[屏幕空间全局光照（Screen Space Global Illumination）](../global-illumination/screen-space-global-illumination/index.md)实现动态光照。

光源的移动性决定了光源应提供的方法（在某些情况下）。

> 图片已省略：lumen-global-illumination example scene

使用Lumen动态全局光照显示实时间接光照的场景。

> [!NOTE]
> 某些动态全局光照方法无法与预计算的方法相结合，如带有烘焙全局光照的Lumen。但是可以一起使用，例如使用[硬件光线追踪（Hardware Ray Tracing）](../ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)和烘焙全局光照。

### 阴影偏差

使用默认阴影贴图方法时，关卡中为阴影资源生成的阴影贴图是按光源设置的，以便保持性能和阴影质量之间的平衡。阴影贴图存在一些限制，例如曲面几何表面上的小面化或自投射阴影瑕疵，可以使用光源上的 **阴影偏差（Shadow Biasing）** 属性进行调整。

阴影偏差是一组按光源设置的属性，有助于提高光源的自阴影和接触硬化（contact hardening）的准确性。偏差设置对于实现一个区域的精度与减少另一个区域的自阴影瑕疵之间的平衡非常有用。

> 图片已省略：默认阴影偏差设置

> 图片已省略：调整阴影偏差设置

默认阴影偏差设置

调整阴影偏差设置

有关更多信息，请参阅[可移动光源](../light-types-and-their-mobility/movable-light-mobility/index.md)。

### 接触阴影

[接触阴影](contact-shadows/index.md)是一种基于光源的附加功能，可附加在光源的其他阴影方法之上使用。它是一种屏幕空间效果，通过场景的深度缓冲区从像素位置向光源绘制光线。因此，在某些情况下，它有助于提高接触硬化和阴影的准确性，但会受到当前摄像机视图中可见内容的限制。

使用 **接触阴影长度（Contact Shadows Length️）** 属性来定义它们的长度，其中值1表示整个屏幕，值0.5表示屏幕的一半，值0表示禁用。较低的值会产生较少的噪点，并且可能看起来更准确（取决于场景）。

> 图片已省略：接触阴影禁用

> 图片已省略：接触阴影启用

接触阴影禁用

接触阴影启用

### Lightmass设置

当[光源移动性（Light Mobility）](../light-types-and-their-mobility/index.md)设置为 **静态（Static）** 或 **固定（Stationary）** 并且光照构建已完成时，光源上的 **Lightmass** 设置会影响预计算光照。

这些设置使用[源角度（Source Angle）](#%E6%BA%90%E8%A7%92%E5%BA%A6%E3%80%81%E5%8D%8A%E5%BE%84%E3%80%81%E9%AB%98%E5%BA%A6%E5%92%8C%E5%AE%BD%E5%BA%A6)来控制定向光源的阴影的烘焙柔和度，以及此光源的饱和度对间接光照的影响程度，并通过阴影指数控制阴影半影的衰减。

### 材质和纹理的阴影

光源可以使用[光照函数（Light Function）](../features-and-properties-of-lights/using-light-functions/index.md)和[IES光源配置文件（IES Light Profile）](../features-and-properties-of-lights/using-ies-light-profiles/index.md)来进一步定义光源及其阴影的各个方面。

**光照函数（Light Function）** 是一种材质类型，可应用于非光照贴图光源，如 **可移动光源（Movable Light）** 和 **固定光源（Stationary Light）** 的直接光照，以过滤光源的强度，但不过滤其颜色。它还可用于将动画纹理应用于光源。例如，模拟来自定向光源的移动云阴影。

> 图片已省略：light function on a spot light

**IES光源配置文件（IES Light Profile）** 是使用实际的测量数据描述来自光源的光分布的纹理。这是照明行业的标准方法，用于绘制特定灯具中存在的光源亮度和衰减图表。

> 图片已省略：ies profile examples

### 距离场阴影

[网格体距离场（Mesh Distance Field）](../mesh-distance-fields/index.md)具有多种用途，从生成阴影到创建交互式材质以及使用[Lumen](../global-illumination/lumen-global-illumination-and-reflections/index.md)的动态间接光照和反射。

启用 **距离场阴影（Distance Field Shadows）** 属性时，静态网格体的网格体距离场表示用于生成来自 **移动（Movable）** 光源的软阴影。

这种阴影方法与[硬件光线追踪](../ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)和[虚拟阴影贴图](https://dev.epicgames.com/documentation/404)等方法类似，其中[源角度、半径或大小（Source Angle, Radius, or Size）](#%E6%BA%90%E8%A7%92%E5%BA%A6%E3%80%81%E5%8D%8A%E5%BE%84%E3%80%81%E9%AB%98%E5%BA%A6%E5%92%8C%E5%AE%BD%E5%BA%A6)可控制阴影的半影。

> 图片已省略：shadow maps versus distance field shadows

左，阴影贴图；右，来自网格体距离场的阴影。

### 定向光源

[定向光源（Directional Light）](../light-types-and-their-mobility/directional-lights/index.md)包含特定于此光源的设置，以模拟大型世界光照。

#### 云和大气阴影

在光源（Light）的 **大气和云（Atmosphere and Clouds）** 小节，有一些设置和属性会影响此光源与[天空大气（Sky Atmosphere）](../environmental-light-with-fog-clouds-sky-and-atmosphere/sky-atmosphere-component/index.md)和[体积云（Volumetric Clouds）](../environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)的交互方式，例如让太阳影响大气和云、将阴影从云投射或投射到云，以及阴影质量。

> 图片已省略：cloud and atomosphere shadowing

#### 级联阴影贴图

级联阴影贴图将相机视图视锥体分割成不同的级联（或细节的阴影级别），以实现整个场景的动态阴影。这可以优化较远距离的阴影，根据需要提供质量：靠近相机位置的质量越高，远离相机位置的质量越低。

**级联阴影贴图（Cascaded Shadow Maps）** 小节下的设置指定了要使用的级联数量、它们的最大距离、分布质量的位置以及每个级联之间的过渡位置。

级联阴影贴图具有指定的最大距离。但是，当你需要超出此距离在更大的物体上投射阴影时，你可以使用 **远阴影级联（Far Shadow Cascades）** 使阴影效果能作用于更远的距离。但这存在一个区别：你必须启用要在此距离上具有阴影的指定资源。你可以通过在关卡中选择一个Actor并在该资产上启用 **远阴影（Far Shadow）** 来执行此操作。

> 图片已省略：directional light far shadow

## 阴影性能和优化选项

阴影的性能在很大程度上取决于你的项目所采用的[阴影方法](#%E6%94%AF%E6%8C%81%E7%9A%84%E9%98%B4%E5%BD%B1%E6%96%B9%E6%B3%95)。

本节中提到的属性是优化场景中光照的起点，特别是对于动态光照，某些阴影方法对性能要求较高，例如默认阴影贴图。

- 点光源、聚光源和矩形光源的

  衰减半径

  不仅对于控制光源在场景中的位置很重要，而且对于限制必须产生阴影的对象的数量很重要，这对于某些阴影方法来说可能有较高的性能要求，尤其是默认阴影贴图方法。
- 如果阴影对场景的贡献不大，光源会影响大量衰减半径较大的对象，或者资源含有很多几何细节，则可以通过在动态光源上禁用

  投射阴影（Cast Shadows）

  来提高性能。这主要影响使用传统阴影贴图进行光照的方法，但对于任何动态光照，必须考虑这一点，以便降低帧成本。
- 在光源上设置

  最大绘制距离（Max Draw Distance）

  将限制其在该点之前的动态阴影贡献。对于有大量中小型光源影响某个区域的场景，这有助于降低帧成本。除了最大绘制距离之外，使用

  最大消退范围（Max Fade Range）

  会使光线随着时间的推移消退，从而避免其突然出现和消失。
- 阴影贴图（Shadow Map）阴影方法是质量与性能相互平衡的结果。有时，你需要牺牲性能来使质量略有改善。

  阴影贴图分辨率（Shadow Map Resolution）

  属性使你可以增加所选光源的阴影贴图，以牺牲质量换取性能。
- 使用

  硬件光线追踪阴影（Hardware Ray Tracing Shadows）

  时，你可以调整

  光线追踪（Ray Tracing）

  小节下的

  每像素样本数（Samples Per Pixel）

  属性，以将更多样本应用于光源的光线追踪阴影。较少的样本会降低质量并提高性能，而较多的样本会提高质量（取决于使用的去噪算法）但性能开销更大。

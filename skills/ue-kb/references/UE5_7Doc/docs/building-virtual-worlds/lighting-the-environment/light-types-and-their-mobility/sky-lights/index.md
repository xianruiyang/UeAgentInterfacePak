---
title: "天空光照"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sky-lights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "光源类型及其可移动性", "天空光照"]
---

# 天空光照

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 光源类型及其可移动性 / 天空光照

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sky-lights-in-unreal-engine

天空光照（Sky Light）捕获关卡的远处部分并将其作为光源应用于场景。这意味着，即使天空来自大气层、天空盒顶部的云层或者远山， 天空的外观及其光照/反射也会匹配。你还可以手动指定要使用的立方体贴图。

## 场景捕获

天空光照仅会某些情况下捕获场景：

- 对于

  静态天空光照（Static Sky Lights）

  ，构建光照时会自动进行更新。
- 除非启用[**实时捕获**](#realtimecapture)功能，否则对于 **固定（Stationary）** 或 **可移动天空光照（Movable Sky Lights）**，在加载时更新一次，只有调用 **重新捕获（Recapture）** 时才会进一步更新。两者都可通过 **细节（Details）** 面板访问，也可以通过游戏内蓝图调用重新捕获。

  细节面板天空光照重新捕获按钮

> [!NOTE]
> 如果你更改了天空盒使用的纹理，天空盒不会自动知道要进行更新。你需要使用上述方法之一为其进行更新。

应使用天空光照而不是环境立方体贴图来表示天空的光照，因为天空光照支持局部阴影，局部阴影可以防止室内区域被天空照亮。

## 移动性

与其他[光源类型](../index.md)类似，天空光照可以设置为以下 **移动性** 之一：

| 移动性 | 说明 |
| --- | --- |
| **静态（Static）** | 游戏中不能更改光照。这是最快的渲染方法，并且允许烘焙的光照。 |
| **固定（Stationary）** | 构建光照时，将仅从静态几何体捕获阴影和光照反射。所有其他光照都将为动态。该设置还允许光线在游戏中更改颜色、强度和立方体贴图，但它不会移动且允许局部烘焙光照。 |
| **可移动（Movable）** | 可以根据需要在游戏中移动和更改光照。 |

## 静态天空光照

设置为 **静态（Static）** 的天空光照将被完全烘焙到关卡中的静态对象的光照图中，因此不需要任何成本。在对该光源的属性进行编辑后，所做的更改将不可见， 直至为关卡重新构建了光照。

> [!NOTE]
> 使用静态天空光照时，将仅捕获关卡中移动性设置为 **静态（Static）** 或 **固定（Stationary）** 的演算体和光源，并且将仅用于照明。此外，为了避免反馈循环， 使用静态天空光照时，只能捕获材质的自发光贡献部分。因此，请确保任何天空盒具有设置为 **无光照（Unlit）** 的材质。

### 固定天空光照

具有 **固定移动性（Stationary Mobility）** 的天空光照从 **Lightmass** 获得烘焙阴影。 当你在关卡中放置了固定天空光照后，你必须至少重新构建光照一次，才能获得烘焙阴影。 然后，你可以根据需要更改天空光照，而无需重新构建。**Lightmass** 烘焙的天空光照阴影将方向遮蔽信息存储在 **[**环境法线**](#bentnormalforstationaryskylights)** 中。

> [!NOTE]
> 只有具有 **静态（Static）** 或 **固定移动性（Stationary Mobility）** 的组件和光源将被捕获并用于采用固定天空光照的照明。

与所有类型的 **固定光源** 一样，在运行时可通过 **蓝图（Blueprint）** 或 **Sequencer** 更改直接光照的颜色。 然而，间接光照将被烘焙到光照图中，并且无法在运行时进行修改。 间接光照量可以使用 `IndirectLightingIntensity` 来控制。

![仅直接光照](../../../../../assets/images/8e/8e0aa55aef7299e7b9315e192f8396051b471d7c13e80e1526d1954d05f52e93.jpg)

![直接光照和为固定天空光照计算的漫反射GI](../../../../../assets/images/e2/e243f7dc08217979ade6b2f5a439bf31a08640267369948dddecd85c9218be86.jpg)

仅直接光照

直接光照和为固定天空光照计算的漫反射GI

### 可移动天空光照

设置为 **可移动（Movable）** 的天空光照不使用任何形式的预计算。当设置为捕获场景时，它捕获具有任何移动性的组件和光源。

#### 距离场环境光遮蔽

> [!NOTE]
> 此属性要求在项目设置中启用[网格体距离场](../../mesh-distance-fields/index.md)

可移动天空光照的阴影由[距离场环境光遮蔽](../../mesh-distance-fields/distance-field-ambient-occlusion/index.md)从每个刚性对象周围生成的 有向距离场体积提供。距离场环境光遮蔽支持刚性网格体可以移动或隐藏的动态场景变化，同时它会影响遮蔽。

![undefined](../../../../../assets/images/f7/f71cf3ee9e06a7582a1beb5608ab45ed310b308edc61353ffac93e5b8466c411.jpg)

点击查看大图。

> [!NOTE]
> 查看[如何使用距离场环境光遮蔽](../../mesh-distance-fields/using-distance-field-ambient-occlusion/index.md)页面了解更多信息和示例。

## 预计算（静态或固定）天空光照

使用烘焙光照和静态或固定天空光照时，照明和阴影数据将存储在光照图中。下面几个小节将讨论 [Lightmass](../../global-illumination/index.md)。

### 改进的静态天空光照方向性

在虚幻引擎4.18之前，静态天光通常用带3阶球谐（3rd Order Spherical Harmonic）的Lightmass来表示，它无法捕获日出或日落时可能出现的细节。 现在使用经过过滤的立方体贴图，默认情况下会得到更高的分辨率。Lightmass还会基于最终聚集光线的大小选择相应的立方体贴图纹理MIP，以便避免任何失真。

> [!TIP]
> 要查看此类交互的示例，请前往 **引擎内容（Engine Content）** > **贴图模板（MapTemplates）** > **天空（Sky）**，并选择 **SunsetAmbientCubemap**，因为它将显示一个很好的示例。

![3阶球谐|（之前）](../../../../../assets/images/39/3997f328d1ba1a6333f6a7772da03ed6905e2342a75250345f8a91ba87676b0f.jpg)

![已过滤立方体贴图|（之后）](../../../../../assets/images/ce/ce3f2b54d9f004d4aafa92beac01760096e63d6410d0620f5dacbbabb512114b.jpg)

3阶球谐|（之前）

已过滤立方体贴图|（之后）

最大的区别可以在具有大量亮度和颜色变化之天空光照立方体贴图的严重遮挡场景中看到。

#### 暗箱

随着静态天空光照的方向性增强，现在可以利用一个足够小的开口重新创建针孔相机效果([暗箱](https://en.wikipedia.org/wiki/Camera_obscura))。 开口越小，天空光照就越有方向性。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fa25617e-d4f0-40bb-9d84-72bd5f7d533c/co_cubemap.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fa2fe575-d494-405e-81ca-ecd64d741fcc/co_result.png) |
| 天空光照源立方体贴图 | 产生的光源构建 |
| *点击查看大图。* | *点击查看大图。* |

### 固定天空光照的环境法线

对于固定天空光照，静态和固定光照使用Lightmass从可移动对象单独烘焙，以便存储名为 **环境法线** 的方向信息。这是 从纹素到最不被遮挡环境光源的方向。大部分被遮挡的区域将此方向而非表面法线用于天空光照，这样便提高了缝隙的质量。

![仅静态天空光照环境光遮蔽](../../../../../assets/images/8b/8bc3290d264c334b39f7ff2ba95c4fb743e2cf354500dfe2c24876b896c46963.jpg)

![带环境法线的固定天空光照](../../../../../assets/images/83/836b6e724f8cf36d076160a3da11dd870e07cde68bc1298465cc9d8f5623f718.jpg)

仅静态天空光照环境光遮蔽

带环境法线的固定天空光照

第一个图像仅显示了具有环境光遮蔽的天空光照。第二个图像则显示了具有环境法线遮蔽的天空光照。 注意缝隙中的表面如何针对光照的产生位置'达成一致'。

> [!NOTE]
> 有关更多信息，请访问[环境法线贴图](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/bent-normal-maps/index.md)页面。

### 多次光照反射

通过在 **世界场景设置（World Settings）** > **Lightmass** 中调整 **天空光照反射次数（Num Sky Lighting Bounces）** 设置，即可支持多次反射全局光照的间接光线。

设置要使用的天空光照反射次数。

![反射次数：1](../../../../../assets/images/f3/f328217e68f54d25e709dd373eabad6bdf368362b78b3a9b9db05b9a9186a619.jpg)

> 图片已省略：反射次数：10

反射次数：1

反射次数：10

为了使天空光照的多次反射明显可见，在大多数情况下，你的材质需要具备高漫反射值。例如，如果漫反射值为.18（18%灰色），第二次的天空光照反射将仅贡献 18^3 = 0.006的光发射能量，这很难为肉眼所察觉。如果漫反射值为0.5，第二次的天空光照反射将贡献0.125的光发射能量，并且显而易见。

> [!WARNING]
> 每增加一次反射都会增加非分布式的构建时间，因此当未使用[密集（Swarm）分布](../../global-illumination/unreal-swarm/index.md)时要谨慎使用。

## 实时捕获

**实时捕获（Real Time Capture）** 模式提供动态和高光度环境光照，可以通过场景元素的实时反射进行动态昼夜更替模拟。

当天空光照的移动性设置为固定和动态，且从天空光照组件 **细节（Details）** 面板启用 **实时捕获** 时，此模式可用。

此模式支持用于已捕获反射和阴影的以下组件：

- 天空大气
- 体积云
- 指数高度雾
- 带有无光照材质的天空球网格体，标记为

  IsSky

使用此模式时还有记住几点：

- 不支持体积云。
- 场景中要有

  天空大气

  组件才能使实时捕获运行。在未来版本中，无需此要求即可支持实时捕获。
- 在主视图中禁止渲染网格体后，可以仅在实时捕获模式下渲染网格体。
- 与在单个Actor上启用

  在实时天空捕获中可见

  时的实时捕获反射相比，主视图可能具有不同的天空球网格体。
- 启用

  云环境光遮蔽

  后，实时捕获模式允许将来自体积云的环境阴影投射到场景中。
- 实时捕获模式比

  RecaptureSky

  蓝图节点更快且更高效，因为所有计算都保留在GPU上，没有使用任何会导致Gameplay暂停或减慢的CPU处理。
- 如果你使用的是体积云，则性能可能会有很大差异，具体取决于所用云材质的复杂程度。你可以通过调整体积云组件的

  反射示例数范围（Reflection Sample Count Scale）

  和

  阴影反射示例数范围（Shadow Reflection Sample Count Scale）

  值控制性能平衡，同时场景不损失视觉效果。

### 反射质量

天空光照捕获的反射质量通过属性 **立方体贴图分辨率（Cubemap Resolution）** 设置。它使用二值的幂（例如64、128、256等）为捕获的场景指定纹理分辨率。

> [!WARNING]
> 请记住，更高的分辨率值会以牺牲性能为代价提高质量。指定的值将应用于最高的立方贴图mip（纹理的细节级别）。

> 图片已省略：拖动滑块查看正在使用的下降（64）、默认（128）和增加（256）天空光照立方体贴图分辨率。

拖动滑块查看正在使用的下降（64）、默认（128）和增加（256）天空光照立方体贴图分辨率。

> [!NOTE]
> 请注意，这些镜头中已禁用[界面空间反射](../../reflections-environment/screen-space-reflections/index.md)（SSR）。反射只是天空光照的结果。

### 时间分段优化

实时捕获模式利用名为 **时间分段** 的性能优化来将捕获的场景分布于多个帧上，而不是在每个帧上执行完整的场景过程。此优化降低了每帧成本，因为全过程实时捕获每帧的成本太高，无法在某些平台上使用。

例如，在PlayStation 4上使用具有天空和体积云的128x128x6 HDR立方体贴图执行的捕获类似于（以毫秒为单位）：

- 对于128x128立方体贴图，每帧的

  完整

  过程将花费约1.465ms（分为以下几部分）：

  - 天空和云占0.60 ms
  - 立方体贴图Mip生成占0.05 ms
  - 高光度卷积占0.80 ms
  - 漫反射辐射占0.015 ms
- 同样的过程，但在

  9帧的时间切片

  上进行时间分段，对于成本最高的步骤，最多只需要0.20 ms。

将单个帧的捕获分布在多个帧上的好处是，可以将实时天空光照捕获保持在项目可承受的预算范围内，因为时间分段的成本与其成本最高的帧一样昂贵。这也意味着你可以找机会提高其他领域的质量，例如天空或云的质量，因为帧预算会有一点多余的空间。

> [!NOTE]
> 默认启用时间分段，但可以使用控制台命令 `r.SkyLight.RealTimeReflectionCapture.TimeSlice` 设置。

## 来自可移动对象的阴影

使用[胶囊体阴影](../../shadowing/capsule-shadows/index.md)（对于骨架网格体）或 [距离场间接阴影](../../mesh-distance-fields/using-distance-field-indirect-shadows/index.md)（对于刚性网格体），可实现从可移动对象到环境上的软阴影。它们需要单独设置才能正常工作。

## 属性

天空光照组件属性分为两种：天空光照和光源，但在UI中没有区别。你可以从Actor**详细信息（Details）** 面板访问。天空光照属性专属于天空光照Actor，而光源属性通用于所有光源Actor。某些属性仅可通过扩展高级（Advanced）分段访问，如下表所示。

| 属性 | 说明 |  |
| --- | --- | --- |
| 天空光照 |  |  |
| **实时捕获（Real Time Capture）** | 启用后，将捕获并卷积天空以便实现动态漫反射和高光度光照。考虑了SkyAtmosphere、VolumetricCloud组件以及带有天空材质的天空球。 |  |
| **源类型（Source Type）** | 是捕获远处场景并将其作为光源还是使用指定的立方体贴图。捕获场景时，任何与天空光照位置的距离超过SkyDistanceThreshold的部分都将被包括在内： **SLS捕获场景（SLS Captured Scene）**：从捕获的场景构造天空光照。任何与天光位置的距离超过天空距离阈值（Sky Distance Threshold ）的部分都将被包括在内。 **SLS指定立方体贴图场景（SLS Specified Cubemap）**：从指定的立方体贴图构造天空光照。 |  |
| **立方体贴图（Cubemap）** | 如果源类型（Source Type）设置为SLS_SpecifiedCubemap，指定天空光照要使用的立方体贴图。 |  |
| **源立方体贴图角度（Source Cubemap Angle）** | 当源类型（Source Type）设置为SLS指定立方体贴图（SLS Specified Cubemap）时，为旋转源立方体贴图的角度。 |  |
| **立方体贴图分辨率（Cubemap Resolution）** | 经过最顶级处理的立方体贴图MIP的最大分辨率。它还必须是2次幂的纹理。 |  |
| **天空距离阈值（Sky Distance Threshold）** | 与天空光照的距离，在此处，任何几何体都应被视为天空的一部分（亦为反射捕获所使用）。 |  |
| **仅捕获自发光（Capture Emissive Only）** | 仅捕获自发光材质。跳过所有照明，使捕获更便宜。当使用捕获每一帧（Capture Every Frame）时，建议使用此方法。高级。 |  |
| **下半球为纯色（Lower Hemisphere is Solid Color）** | 是否所有来自下半球的照明都应设置为零。这有助于防止从下半球泄漏。高级。 |  |
| **下半球颜色（Lower Hemisphere Color）** | 使用颜色选择器选择下半球的颜色。高级。 |  |
| 光源 |  |  |
| **强度范围（Intensity Scale）** | 光源发出的总能量。 |  |
| **影响世界场景（Affects World）** | 光源是否能影响世界场景，或者光源是否被禁用。 |  |
| **投射阴影（Cast Shadows）** | 光源是否应投射任何阴影。 |  |
| **间接光照强度（Indirect Lighting Intensity）** | 按比例缩放来自该光源的间接照明贡献。如果该值为0，将禁用来自该光源的任何全局照明(GI)。 |  |
| **体积散射强度（Volumetric Scattering Intensity）** | 该光源的体积散射的强度。它缩放强度（Intensity）和光源颜色（Light Color）。 |  |
| **投射静态阴影（Casts Static Shadows）** | 光源是否应从静态对象投射阴影。此外，要求将投射阴影（Cast Shadows）设置为真（True）。高级。 |  |
| **投射动态阴影（Casts Static Shadows）** | 光源是否应从动态对象投射阴影。此外，要求将投射阴影（Cast Shadows）设置为真（True）。高级。 |  |
| **影响半透明光照（Affect Translucent Lighting）** | 光源是否会影响半透明度。禁用此选项可以在有许多小光源的情况下节省GPU时间。高级。 |  |
| **透射光（Transmission）** | 天空光照发出的光是否透过具有次表面散射轮廓的表面。要求光源可移动。高级。 |  |
| **投射体积阴影（Cast Volumetric Shadow）** | 光源是否投下体积雾（Volumetric Fog）阴影。高级。 |  |
| **投射深阴影（Cast Deep Shadow）** | 光源是否应投射高质量的发束自阴影。启用此选项后，此光源将产生额外的GPU成本。高级。 |  |
| **投射光线追踪阴影（Cast Ray Traced Shadows）** | 使用阴影映射还是光线跟踪（如果可用）计算光源阴影。高级。 |  |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 启用光线追踪反射时，光源是否会影响反射中的对象。高级。 |  |
| **影响光线追踪的全局光照（Affect Ray Traced Global Illumination）** | ** | 启用光线跟踪全局光照时，光源是否会影响全局光照。高级。 |
| **深阴影层分布（Deep Shadow Layer Distribution）** | 更改深阴影层分布。0：线性（均匀的图层分布）；1：指数（更多关于附近小阴影的详细信息）。需要启用投射深阴影（Cast Deep Shadow）。高级。 |  |
| 大气和云层 |  |  |
| **云层环境遮蔽（Cloud Ambient Occlusion）** | 控制大气内云层是否应该遮蔽天空的贡献值（逐步淡化多重散射）。 |  |
| **云层环境遮蔽强度（Cloud Ambient Occlusion Strength）** | 环境遮蔽的强度。值越高，阻挡光线更多。 |  |
| **云层环境遮蔽范围（Cloud Ambient Occlusion Extent）** | 摄像机周围的云层环境遮蔽贴图的世界空间半径，单位是公里（km）。 |  |
| **云层环境遮蔽贴图分辨率比例（Cloud Ambient Occlusion Map Resolution Scale）** | 缩放云层的环境遮蔽贴图分辨率。分辨率最大不超过 `r.VolumetricCloud.ShadowMap.MaxResolution` 指定的数值。 |  |
| **云层环境遮蔽孔径比例（Cloud Ambient Occlusion Aperture Scale）** | 控制锥体孔径的角度；会使用角度来计算由于体积云产生的天空遮蔽。值为1时，会考虑整个半球，产生模糊的遮蔽效果。值为0时，只考虑单一方向的遮蔽（垂直），产生清晰的遮蔽效果。 |  |

## 局限性

这些功能对天空光照很有用，但尚未实现：

- 从可移动对象（角色）到环境的柔和阴影未与天空光照集成，并且当前需要以额外的渲染成本实现单独的功能。
- 可以使用SkyLightComponent蓝图函数RecaptureSky()，但是处理成本高，并且至少需要120毫秒，从而导致Gameplay暂停或速度下降。

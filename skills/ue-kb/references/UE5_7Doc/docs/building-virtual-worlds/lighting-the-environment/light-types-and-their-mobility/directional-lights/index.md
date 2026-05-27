---
title: "定向光源"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/directional-lights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "光源类型及其可移动性", "定向光源"]
---

# 定向光源

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 光源类型及其可移动性 / 定向光源

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/directional-lights-in-unreal-engine

**定向光源**将模拟从无限远的源头处发出的光线。 这意味着此光源投射的所有阴影都将是平行的，从而使其非常适合模拟太阳光。 定向光源放置后，可对其**移动性**进行如下设置：

- **静态（Static）** - （左图）即无法在游戏中改变光源。 这是最快的渲染方法，可用于已烘焙的光照。
- **固定（Stationary）** - （同见左图）即光源通过**Lightmass**只烘焙静态几何体的投影和反射光照。其他则为动态光照。 该设置还允许光源在游戏中更改颜色和强度，但它不会移动且允许局部烘焙光照。
- **可移动（Moveable）** - （左图）即为完全动态光源，可进行动态投影。 这是最慢的渲染方法，但在游戏过程中拥有最高灵活性。

下图展示了从开放屋顶照射进来的日光。

![定向光源](../../../../../assets/images/8e/8eca01c6c0c7b953540a7f6513f5380df7a9559e558e4eb805775169d22c4977.jpg)

![定向光源阴影视锥体](../../../../../assets/images/de/def7bd5e27b99e0809833a87944a10a2a00812ea30156ccd97f2c8682bfe1c56.jpg)

定向光源

定向光源阴影视锥体

左图只显示了光源，右图则启用了**阴影视锥体**，展示了定向光源发出的平行光线。

**光源方向**（左图所示）以箭头指出了光线传播的方向，以便使用者根据需要来放置光源的方向。

## 定向光源属性

定向光源的属性分为以下5类：光源、光束、Lightmass、光照函数和级联阴影贴图。

### 光源

| 属性 | 说明 |
| --- | --- |
| **强度（Intensity）** | 光源发射的总能量。 |
| **光源颜色（Light Color）** | 光源发出的颜色。 |
| **光源角度（Source Angle）** | 光源对着的角度，以度数为单位。 默认为0.5357，这是太阳的角度。 |
| **光源软角度（Source Soft Angle）** | 软光源对着的角度，以度数为单位。 |
| **使用色温（Use Temperature）** | 禁用时，使用白色作为光源。 |
| **色温（Temperature）** | 黑体光源的色温，以开氏度为单位。 白色是6500K。 |
| **影响世界（Affects World）** | 完全禁用光源。 无法在运行时设置。 要在运行时禁用光源效果，需修改其**可视性（Visibility）**属性。 |
| **投射阴影（Casts Shadows）** | 光源是否投射阴影。 |
| **间接光照强度（Indirect Lighting Intensity）** | 缩放光源发出的间接光照贡献。 |
| **体积散射强度（Volumetric Scattering Intensity）** | 该光源的体积散射的强度。 |
| **阴影级联偏差分布（Shadow Cascade Bias Distribution）** | 控制级联之间的深度偏差。 此项用于缓解阴影级联过渡时的阴影失真差异。 |
| **前向着色优先级（Forward Shading Priority）** | "正向着色优先级"是指那些涉及正向渲染、半透明、单层水和体积雾的光照的单向光源的正向光照优先级。 如果两个光源的优先级相同，则会根据它们的整体亮度确定优先级。 |
| **投射调制的阴影（Cast Modulated Shadows）** | 是否从动态对象投射调制的阴影（仅限移动端）。 |
| **调制的阴影颜色（Modulated Shadow Color）** | 在渲染调制的阴影时要针对场景颜色调制的颜色（仅限移动端）。 |
| **阴影程度（Shadow Amount）** | 阴影遮蔽程度。 值为0时，表示没有遮蔽，也没有阴影。 |
| **高光度比例（Specular Scale）** | 高光度高光的乘数。 请慎用。 除了1之外的所有值都不是物理的。 |
| **阴影分辨率比例（Shadow Resolution Scale）** | 缩放用于对此光源投影的阴影贴图的分辨率。 |
| **阴影偏差（Shadow Bias）** | 控制此光源所投射阴影的精确度。 |
| **阴影斜率偏差（Shadow Slope Bias）** | 控制此光源整个场景阴影的自投影准确度。 这会根据表面的斜率增加偏差数量，从而对阴影偏差做出贡献。 |
| **阴影过滤锐化（Shadow Filter Sharpen）** | 此光源投射阴影过滤的锐化程度。 |
| **接触阴影长度（Contact Shadow Length）** | 清晰接触阴影的屏幕空间光线追踪的长度。 |
| **以世界空间单位计的接触阴影长度（Contact Shadow Length in World Space Units）** | 是否将世界空间单位用于接触阴影长度。 |
| **投射半透明阴影（Cast Translucent Shadows）** | 是否允许透过半透明Object投射动态阴影。 |
| **仅从过场动画对象投射阴影（Cast Shadows from Cinematic Objects Only）** | 光源是否应该仅从标记为bCastCinematicShadows的组件投射阴影。 这适合用于设置对准角色的过场动画可移动聚光源，并避免背景的阴影深度开销。此选项仅适用于动态阴影贴图，而不适用于静态投影或光线追踪的距离场阴影。 |
| **动态间接光照（Dynamic Indirect Lighting）** | 是否应将光源注入**光传播体积（Light Propagation Volume）**。 |
| **为可移动图元强制缓存阴影（Force Cached Shadows for Movable Primitives）** | 为可移动图元启用缓存阴影。 |
| **光照通道（Lighting Channels）** | 此光源应该影响的通道。 |
| **投射静态阴影（Cast Static Shadows）** | 此光源是否投射静态阴影。 |
| **投射动态阴影（Cast Dynamic Shadows）** | 此光源是否投射动态阴影。 |
| **影响半透明光照（Affect Translucent Lighting）** | 光源是否影响半透明度。 |
| **透射光（Transmission）** | 是否透过具有次表面散射轮廓的表面传播。 |
| **投射体积阴影（Cast Volumetric Shadow）** | 是否对体积雾投影。 |
| **投射深阴影（Cast Deep Shadow）** | 是否投射高质量的发束自投影。 |
| **投射光线追踪阴影（Cast Ray Traced Shadows）** | 是否为此光源启用光线追踪的阴影。 选项如下：禁用（Disabled）使用项目设置启用 |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 在启用光线追踪的反射时是否影响反射中的对象。 |
| **影响光线追踪全局光照（Affect Ray Tracing Global Illumination）** | 在启用光线追踪的全局光照时是否影响全局光照。 |
| **深阴影层分布（Deep Shadow Layer Distribution）** | 更改深阴影层分布。 值为0时表示线性分布（均匀层分布），为1时表示指数分布。 |

### 光束

| 属性 | 说明 |
| --- | --- |
| **光束遮挡（Light Shaft Occlusion）** | 确定此光源是否会对雾气和大气之间的散射形成屏幕空间模糊遮挡。 |
| **遮挡遮罩暗度（Occlusion Mask Darkness）** | 控制遮挡遮罩的暗度，值为1则无暗度。 |
| **遮挡深度范围（Occlusion Depth Range）** | 和相机之间的距离小于此距离的物体均会对光束构成遮挡。 |
| **光束泛光（Light Shaft Bloom）** | 确定是否渲染此光源的光束泛光。 |
| **泛光缩放（Bloom Scale）** | 缩放叠加的泛光颜色。 |
| **泛光阈值（Bloom Threshold）** | 场景颜色必须大于此阈值，方可在光束中形成泛光。 |
| **泛光最高亮度（Bloom Max Brightness）** | 应用曝光之后，此值将约束场景颜色亮度。 |
| **泛光色调（Bloom Tint）** | 对光束发出的泛光效果进行着色时所使用的颜色。 |
| **光束重载方向（Light Shaft Override Direction）** | 可使光束从另一处发出，而非从该光源的实际方向发出。 |

### Lightmass

| 属性 | 说明 |
| --- | --- |
| **光源角度（Light Source Angle）** | 定向光源的自发光表面相对于接收物而延展的角度，影响半影尺寸。 |
| **间接光照饱和度（Indirect Lighting Saturation）** | 数值为0时将完全去除该Lightmass光源的饱和度，为1时保持不变。 |
| **阴影指数（Shadow Exponent）** | 控制阴影半影的衰减。 |
| **固定光源使用区域阴影（Use Area Shadows for Stationary Light）** | 是否将区域阴影用于固定光源预计算的阴影贴图。 |

### 光源函数

| 属性 | 说明 |
| --- | --- |
| **光源函数材质（Light Function Material）** | 应用于该光源的光照函数材质。 |
| **光源函数缩放（Light Function Scale）** | 缩放光照函数投射。 |
| **淡化距离（Fade Distance）** | 光源函数应完全淡化到**禁用亮度（Disabled Brightness）**值的距离。 |
| **禁用亮度（Disabled Brightness）** | 光源函数已指定但被禁用时应用到光源的亮度因子，以之前的 属性为例：**光源函数淡化距离（Light Function Fade Distance）**。 |

### 级联阴影贴图

| 属性 | 说明 |
| --- | --- |
| **可移动光源动态阴影距离（Dynamic Shadow Distance MovableLight）** | 可移动光源**级联阴影贴图（Cascaded Shadow Map）**动态阴影将覆盖的距离，从摄像机位置开始测量。 |
| **固定光源动态阴影距离（Dynamic Shadow Distance StationaryLight）** | 固定光源**级联阴影贴图（Cascaded Shadow Map）**动态阴影将覆盖的距离，从摄像机位置开始测量。 |
| **动态阴影级联数（Num Dynamic Shadow Cascades）** | 为整个场景将视锥体拆分成的级联数。 |
| **分布指数（Distribution Exponent）** | 控制级联是分布在更靠近摄像机（指数较大）还是更远离摄像机（指数较小）的位置。 |
| **过渡部分（Transition Fraction）** | 级联之间消退区域的比例。 |
| **距离淡出部分（Distance Fadeout Fraction）** | 控制动态阴影影响远端淡出区域的大小。 |
| **可移动对象的内嵌阴影（Inset Shadows for Movable Objects）** | （仅限固定光源）是否为可移动组件使用逐对象内嵌阴影，即使启用了级联阴影贴图也同样如此。 |
| **远距离阴影级联计数（Far Shadow Cascade Count）** | 值为0时表示没有远距离阴影级联。 |
| **远距离阴影距离（Far Shadow Distance）** | 远距离阴影级联应结束的距离。 |

### 大气和云

定向光源支持虚幻引擎的[天空大气](../../environmental-light-with-fog-clouds-sky-and-atmosphere/sky-atmosphere-component/index.md)和[体积云](../../environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)功能。

> [!NOTE]
> 其他信息和演示可以在体积云（Volumetric Clouds）页面中的[定向光源交互和投射阴影](../../environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)分段下找到。

| 属性 | 说明 |
| --- | --- |
| 大气和云 |  |
| **大气太阳光（Atmosphere Sun Light）** | 是否允许定向光源与大气和云交互，并生成可见的太阳圆盘，这些组件共同组成天空视觉效果。 |
| **在云层上投射阴影（Cast Shadows on Clouds）** | 光源是否应将不透明网格体的阴影投射到云上。 对于任何次级定向光源，比如另一个太阳或者月亮光源，如果启用了**大气太阳光（Atmosphere Sun Light）**并将**大气太阳光指数（Atmosphere Sun Light Index）**设置为1，则禁用此属性。 |
| **在大气上投射阴影（Cast Shadows on Atmosphere）** | 在使用天空大气时，光源是否应将不透明网格体的阴影投射到大气中。 |
| **投射云层阴影（Cast Cloud Shadows）** | 光源是否应将云阴影投射到大气和其他场景元素上。 |
| **云层散射亮度比例（Cloud Scattering Luminance Scale）** | 调整光源在云中间介质中散射时的贡献值。 因为当前多重散射的实现只是近似值，此属性能帮助抵消一些负面效果。 |
| 高级属性 |  |
| **大气太阳光索引（Atmosphere Sun Light Index）** | 引擎支持在任何时候显示两个大气光源来表示太阳和月亮，或者是两个太阳。 使用此索引来设置主光源和副光源。 例如，太阳是0，月亮是1。 |
| **大气日轮色标（Atmosphere Sun Disk Color Scale）** | 日轮亮度相乘的色标（color scale）。 |
| **逐像素大气透射（Per Pixel Atmosphere Transmittance）** | 是否在不透明网格体上应用逐像素大气透光，而不是使用光源的全局透光。 |
| **云层阴影强度（Cloud Shadow Strength）** | 阴影的强度。 值越大，阻挡的光线越多。 |
| **云层在大气上的阴影强度（Cloud Shadow on Atmosphere Strength）** | 大气上阴影的强度。 设置为0时，会禁用大气上的阴影。 |
| **云层在表面上的阴影强度（Cloud Shadow on Surface Strength）** | 不透明和半透明网格体上的阴影强度。 当设置为0时，禁用不透明和半透明表面上的阴影。 |
| **云阴影深度偏差（Cloud Shadow Depth Bias）** | 控制应用到体积云阴影贴图的前阴影深度上的偏差值。 |
| **云层阴影范围（Cloud Shadow Extent）** | 环绕摄像机的云阴影贴图的世界空间半径值。 单位为千米（km）。 |
| **云阴影贴图分辨率比例（Cloud Shadow Map Resolution Scale）** | 调整云阴影贴图分辨率。 分辨率受`r.VolumetricCloud.ShadowMap.MaxResolution`限制。 |
| **云层阴影光线取样数比例（Cloud Shadow Ray Sample Count Scale）** | 调整用于阴影贴图追踪的取样数。 采样数分辨率受到`r.VolumetricCloud.ShadowMap.RaySampleMaxCount`的限制。 |

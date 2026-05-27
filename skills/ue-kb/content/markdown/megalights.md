# MegaLights

---
title: "MegaLights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/megalights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "直接光照", "MegaLights"]
---

# MegaLights

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 直接光照 / MegaLights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/megalights-in-unreal-engine

MegaLights是虚幻引擎5中的一种全新直接光照路径，让美术师能够放置的动态和阴影区域光源比以往高出几个数量级。

MegaLights专为支持当前世代的游戏主机而设计，并利用光线追踪技术，使各种类型的区域光源产生逼真的柔和阴影。

MegaLights不仅降低了动态阴影的开销，还降低了无阴影光源求值的开销，使在游戏主机上使用高开销光源（如纹理区域光源）成为可能。

MegaLights还支持[体积雾](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/environmental-lighting/volumetric-fog)。

## 使用MegaLights

要为项目启用MegaLights，请在项目设置中的**渲染（Rendering）>定向光源（Direct Lighting）**类别中启用。 这也将提示你启用**支持硬件光线追踪（Support Hardware Ray Tracing）**，这也是MegaLights的推荐设置。

启用后，MegaLights系统将负责处理所有本地光源。 你可以使用**允许MegaLights（Allow MegaLights）**光源组件属性逐个光源禁用MegaLights。 你还可以设置**MegaLights阴影方法（MegaLights Shadow Method）**，将投影源选择为**光线追踪（Ray Tracing）（默认）**或**虚拟阴影贴图（Virtual Shadow Maps）**(VSM)。

> [!WARNING]
> 虽然虚拟阴影贴图可以直接从非简化的Nanite几何体投射阴影，但它只能近似于区域阴影。 虚拟阴影贴图需要逐光源提前准备阴影贴图深度，因此会产生CPU、内存和GPU时间开销。

要对单个项目实现更精细的控制，你可以通过后期处理体积的设置项来启用或禁用MegaLights。

> [!NOTE]
> 你可以使用`r.MegaLights.Allow 0`按可扩展性级别或按设备配置文件来禁用MegaLights。

## 技术概览

MegaLights是一种随机直接光照技术，通过对光源进行重要性取样来解决直接光照的问题。 它向重要光源方向，追踪每个像素点固定数量的光线。 如果某个光源被光线击中，那么该光源的贡献值就会被添加到当前像素中。

这种方法有几个重要的意义：

- 定向光源由单一通道统一处理，取代了多种现存延迟渲染器的投影和着色技术。
- MegaLights不仅降低了投影开销，还降低了本身的着色开销。
- MegaLights具有恒定的性能开销，但给定像素的光源越复杂，质量可能会降低。

延迟着色具有恒定的光照质量，但光源数量越多，GPU开销就越大。 而MegaLights具有恒定的性能，但质量取决于给定像素的光照复杂度。

MegaLights取代了以下功能：

- 阴影贴图距离场阴影
- 光线追踪阴影
- 延迟着色（BRDF和光源求值）
- 体积雾投影和光源评估
- 虚拟阴影贴图投射

  - 如果在单个光源Actor的设置中选择的阴影方法为虚拟阴影贴图，那么虚拟阴影贴图仍可与MegaLights一起使用。

默认情况下，MegaLights会首先追踪一条较短的保守屏幕空间光线，以捕捉微小的细节，而这种细节在简化的光线追踪场景中可能不可用。 如果该光线跑出屏幕，位于物体后方，或达到最大长度，那么MegaLights会使用硬件或软件光线追踪功能，从最后一个有效位置继续追踪。 你也可以将MegaLights配置为对虚拟阴影贴图进行光线追踪，但其阴影需要额外的前期开销，因为阴影贴图需要逐光源生成，而BVH（光线追踪场景）只需为场景中的所有光源生成一次。

MegaLights的光线引导对选择重要光源而言非常有用，对于向可能会对给定像素产生影响的光源发送更多样本至关重要。 反过来讲，光线引导会向影响较小的光源（如可能被遮挡的光源）发送较少的样本。 这是该技术的重要部分，使其能够用固定的逐像素光源样本预算，获得最佳的光照质量。 虽然光线引导会减少向被遮挡光源发送的光线数量，但它仍需要定期对这些光源进行取样，以检查它们是否在当前帧中可见。 因此，应避免放置会影响整个场景的大边界光源。

最后，所有累积的光照都会经过一个降噪器，以试图利用随机的（甚至是有噪点的）输入重建高质量的直接光照。 随着场景中的光照越来越复杂，降噪器相应的工作量也将增加。 复杂的光照可能会导致光照模糊或重影。要避免这种情况，你可以将较小的光源合并为大面积光源，并仔细缩小光源范围以提高最终的光照质量。

## 光照复杂度

由于各像素有固定的预算和固定的取样数量，单个像素能受到多少重要光源的影响是有限制的，之后就得严重依赖降噪器。这可能导致降噪器产生模糊的光照，最终在场景中产生噪点或重影。 因此，优化光源的放置仍然非常重要，比如缩小光源衰减范围、用单个区域光源取代光源簇等。

要让MegaLights在场景中正常工作，最好避免将光源置于场景中的几何体内，并优化光源的边界。 你可以使用控制台命令`r.MegaLights.Debug 1`来查看选定像素发出光线的位置。 你可以使用控制台命令`r.ShaderPrint.Lock 1`冻结选定的光线，这样就可以在场景中随意飞行，检查被追踪的光线。

> [!NOTE]
> 随着MegaLights成为生产就绪的虚幻引擎功能，我们还将提供更多的可视化工具。

下方示例中，纹理矩形光源部分位于墙内，尽管光源不会总是被看到，但MegaLights仍需要对其进行取样样。 可视化效果图也体现了这一点，它显示了部分光线被追踪到墙壁中。 理想情况下，应该缩小纹理矩形光源的**光源宽度（Source Width）**和**光源高度（Source Height）**，让光源在填满整个结构的同时不延伸到结构之外。

> [!TIP]
> 为尽量减少噪点，应避免将光源置于几何体内部，优化光源衰减范围和聚光灯锥体，并用矩形光源的挡光板来缩小光源的影响范围。

## 光线追踪场景

默认情况下，MegaLights会使用光线追踪，而阴影质量则取决于光线追踪场景的表现质量。 为提高性能，光线追踪场景会使用自动简化的Nanite网格体进行编译，相比主视图采用更激进的剔除设置。 这可能会导致阴影瑕疵、漏光或阴影缺失等情况。

光线追踪场景可视化是研究投影问题的绝佳起点。 它们显示了MegaLights进行光线追踪的实际场景表示。 你可以使用以下方法将光线追踪场景可视化：

- 使用视图模式（View Modes）菜单下关卡视口（Level Viewport）中的**光线追踪调试（Ray Tracing Debug）**视图模式。 可通过控制台命令使用光线追踪调试视图模式：`show RayTracingDebug 1`和`r.RayTracing.DebugVisualizationMode = "World Normal"`。
- **Lumen概览（Lumen Overview）**视图模式，可实现画中画的可视化效果，同时显示光线追踪场景和主视图。 Lumen概览视图模式也可通过控制台命令`r.Lumen.Visualize 1`来使用。

|  |  |
| --- | --- |
|  |  |
| 场景视图 | 光线追踪世界法线可视化视图模式 |

如果出现阴影随着距离的增加而缺失或消失的情况，原因可能是光线追踪场景剔除。 你可以使用`r.RayTracing.Culling.*`下的控制台命令来调整剔除效果。 你需要查看剔除模式、半径和立体角变量。

要进行剔除，你可以使用**光线追踪群组ID（Ray Tracing Group Id）**将较小的对象合并在一起，这样就可以使用合并后的边界对它们进行剔除。

如需了解光线追踪场景剔除功能按钮的更多详细信息，请参阅[光线追踪性能指南](https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-performance-guide-in-unreal-engine?application_version=5.5)。

光线追踪场景基于自动简化的Nanite回退网格体。 默认设置有时会导致回退网格体的质量过低，无法产生投影效果，因此可能需要手动调整。 为此，你需要按照以下步骤操作：

1. 在静态网格体编辑器（Static Mesh Editor）中打开相关网格体。
2. 在**细节（Details）**面板中的**Nanite设置（Nanite Setting）**下，将**回退目标（Fallback Target）**设置为相对误差（Relative Error）。
3. 这时将显示一个名为**回退相对误差（Fallback Relative Error）**的新设置项，你可以设置该项的值。 减小该值就能增加三角形的数量和Nanite回退网格体的保真度。
4. 设置完成后，点击**应用更改（Apply Changes）**以重新编译Nanite回退网格体。

如需详细了解Nanite回退网格体的设置，请参阅[Nanite虚拟几何体](https://dev.epicgames.com/documentation/assets/designing-visuals-rendering-and-graphics/rendering-optimization/nanite)。

> [!WARNING]
> 光线追踪场景中包含的Nanite回退网格体三角形数量和实例数量会影响光线追踪BVH的编译时间、内存占用和光线追踪性能。 建议根据项目的可用性能和内存预算谨慎增加这些东西的数量。

针对非实时渲染，也可以使用`r.RayTracing.Nanite.Mode 1`，用全细节的Nanite网格体编译光线追踪场景。 这种模式的性能和内存开销都很高，而且在场景或摄像机动画中，当Nanite LOD镜头发生变化，需要重新编译其BVH时，可能会出现小故障。

## 屏幕空间追踪

MegaLights在为较大的几何体细节投射阴影时会使用光线追踪场景，但针对简化的光线追踪场景中可能缺少的小规模几何体，则会使用屏幕空间追踪。 屏幕空间追踪会使用场景深度（Scene Depth），会击中屏幕上任何可见的物体。 这可能会导致某些美术方面的调整出现问题，例如只存在于光线追踪场景中但不影响场景深度的不可见阴影投射器。

> [!TIP]
> 对于超出光线追踪场景覆盖范围的追踪（或当远场的表示太粗糙时），MegaLights支持远距离屏幕追踪。 使用`r.MegaLights.DistantScreenTraces.Length`将远处屏幕追踪的长度定义为屏幕的百分比。

## 投影方法

MegaLights提供了两种投影方法，可以使用光源组件的属性来逐光源选择投影方法：

- **光线追踪（Ray Tracing）**是默认推荐的方法。 光线追踪不会逐光源增加额外开销，并能实现正确的区域阴影。 缺点是阴影的质量取决于简化的光线追踪场景。
- **虚拟阴影贴图**根据[虚拟阴影贴图](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/shadows/virtual-shadow-maps)来追踪光线。 虚拟阴影贴图使用光栅化技术逐光源生成，可以捕捉完整的Nanite网格体细节。 它的缺点是只能近似于区域阴影，而且在用于生成阴影深度的内存、CPU和GPU开销方面，每个光源都会产生大量额外开销。 因此应尽量少用。

> [!TIP]
> 默认情况下，所有光源，尤其是阴影较柔和的大面积光源或不太重要的光源，都应使用光线追踪，因为较柔和的光源不需要精确的阴影投射器。 此外，光线追踪场景值得多分配一些预算，因为光线追踪表达的质量越高，穿过低开销光线追踪路径的光源就越多。

## 光源函数

只要与[光源函数图集](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/features-of-lights/light-functions/#lightfunctionatlas)兼容，并且项目设置启用了光源函数图集，光源函数就能受到支持。

## Alpha遮罩

默认情况下，只有屏幕空间追踪（Screen Space Traces）可以正确处理Alpha遮罩表面。 可以使用控制台命令`r.MegaLights.HardwareRayTracing.EvaluateMaterialMode 1`为光线追踪启用Alpha遮罩支持。 启用该选项会带来不小的性能开销，因此最好避免在内容中使用Alpha遮罩。

## 定向光源

默认情况下，定向光源是禁用的，必须使用`r.MegaLights.DirectionalLights 1`手动启用。 这是由于各种局限性，使其更适合月光等昏暗柔和的定向光源，而不是延伸到地平线的高质量尖锐太阳阴影。

定向光源阴影的质量在很大程度上取决于远处的光线追踪表示，由于BVH构建和遍历开销，这可能会遇到问题。 启用远场可以隐藏其中一些问题。

强定向光源还会将一些示例重定向到不可见的定向光源，从而使室内出现噪点，这对最终像素并没有好处。 可以通过放置后期处理体积来解决此问题，这将使室内的定向光源更暗，甚至可能禁用它。

## 远场

MegaLights实现了[远场](https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-performance-guide-in-unreal-engine?application_version=5.5)追踪，通过追踪简化和合并的HLOD1网格体，允许以相对较低的开销将阴影光线范围扩展到TLAS剔除范围之上。

`远场追踪由DefaultEngine.ini配置文件中的控制台变量r.MegaLights.HardwareRayTracing.FarField启用，并需要使用世界分区的分层细节级别（HLOD）。` 远场要求使用构建的HLOD1。

## 光照半透明和体积雾

MegaLights与[半透明光照体积](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/lit-translucency/index.md)和[体积雾](../../environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-fog/index.md)集成，可随机计算这些体积上的光照和阴影。

阴影使用统一的froxel体积计算，该体积的分辨率使用`r.MegaLights.Volume.GridPixelSize`和`r.MegaLights.Volume.GridSizeZ`定义。 体积的覆盖范围会根据`r.TranslucencyLightingVolume.OuterDistance`和激活指数高度雾组件的查看距离自动扩展。

> [!NOTE]
> 更改这些设置将影响光照半透明材质和体积雾的阴影质量。

## 前向着色

当前，使用用于光照半透明的相同体积计算前向着色。 尤其高光度光照是通过从球谐中提取单个光源来近似计算的，球谐近似于表面周围的整体光照。

## 粒子光源

MegaLights支持粒子光源，但仅适用于当前由[Niagara系统](../../../../visual-effects/getting-started-in-niagara-effects/overview-of-niagara-effects/index.md)生成的粒子光源。 当由MegaLights处理时，它们也可以进行阴影投射。

默认情况下，只有当用户在资产中显式启用粒子光源时，MegaLights才会处理粒子光源。 可以使用控制台变量`r.MegaLights.SimpleLightMode`更改此行为，将其设置为2会使MegaLights处理所有粒子光源（仍需要按资产启用阴影投射），将其设置为0会禁用来自MegaLights的粒子光源。

要为Niagara发射器启用MegaLights，请执行以下操作：

![具有MegaLights设置的Niagara发射器。](../../../../../assets/images/e9/e9d57aec85c93d8ae6efa04c162997bd67673d41e5a06983cb445581f9de34c3.jpg)

具有MegaLights设置的Niagara发射器。

1. 在发射器下选择**光源渲染器（Light Renderer）**模块。
2. 在**细节面板**中，启用**允许巨型光源（Allow Mega Lights）**和**巨型光源投射阴影（Mega Lights Cast Shadows）**。

   1. 选中第二个设置将使粒子光源投射阴影。
   2. 选中第一个设置，为生成的光源启用MegaLights。

> [!WARNING]
> 由于发射器可以生成大量光源，因此需要注意避免过多强光源同时影响屏幕像素。 否则，质量可能会明显下降。 我们建议在空间中保持稀疏的小型光源，并仅在少量粒子光源上启用阴影投射。

## 可伸缩性

这些是MegaLights可扩展性的主要控制：

- `r.MegaLights.DownsampleMode`控制用于采样和追踪的下采样因子。
- `r.MegaLights.NumSamplesPerPixel`控制每个像素完成的采样和追踪数量。

将光照质量扩展到高端PC或离线渲染的工作仍在开发中，但你可以尝试使用命令`r.MegaLights.DownsampleMode 0`和`r.MegaLights.NumSamplesPerPixel 16`来实现最佳质量。

> [!TIP]
> 为了实现体积雾和毛发发束光照的可扩展性，你可以使用`r.megalights.volume.*`下的控制台变量来调整它们的光照质量。

> [!WARNING]
> MegaLights还没有为[影片渲染队列](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline#movierenderqueue)提供专门支持，但使用时间超级分辨率（TSR）作为抗锯齿方法，或将时间取样数设置为8左右，就能达到很好的效果，且能正确解决光照问题。

## 性能

在比较性能时，请务必理解这一点：MegaLights解决了所有直接光照问题，并取代了各种延迟渲染器通道，例如：

- **阴影深度：**如果使用阴影贴图或虚拟阴影贴图
- **RenderDeferredLighting::Lights**
- **InjectTranslucencyLightingVolume**
- **VolumetricFog::Shadowed Lights**
- 移除**VolumetricFog::LightScattering**的光源求值

影响性能的因素：

- 性能主要取决于内部渲染分辨率。
- 光线追踪是MegaLights开销的第二大组成部分。 开销取决于多个因素：光线追踪场景中实例的数量、复杂程度、重叠实例的数量、每帧需要更新的动态三角形的数量。 如需详细了解如何优化光线追踪场景，请参阅[光线追踪性能指南](https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-performance-guide-in-unreal-engine?application_version=5.5)。
- 为各光源生成阴影贴图深度会产生额外的内存、CPU和GPU开销，因为在进行投影时使用的是虚拟阴影贴图而不是光线追踪。
- 具有复杂BRDF的屏幕上像素和受重型光源类型（纹理矩形光源）影响的像素，会产生少量开销。

> [!TIP]
> MegaLights的开销基本恒定，而且无阴影光源和有阴影光源之间的差别不大，因此可以为场景中的所有光源启用阴影。

> [!TIP]
> 理想情况下，MegaLights应与[Lumen HWRT](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/global-illumination/lumen/TechOverview/#hardwareraytracing)一起使用，让两个系统共享光线追踪场景的开销和优化。

`Stat GPU`会显示包括MegaLights通道的GPU时序概览。 使用内置的`ProfileGPU`或第三方分析器都可获得详细的时序情况。

> [!WARNING]
> 虚幻引擎使用异步计算（Async Compute）来重叠来自各种功能的多个调度。 `Stat GPU`和`ProfileGPU`时序会失真，除非你用控制台命令`r.RDG.AsyncCompute 0`来禁用异步计算。

虽然MegaLights完全由GPU驱动，但每处光源仍存在一些遗留的CPU开销。 如果所有光源都是使用光线追踪技术的MegaLights，那么可以使用控制台命令`r.Visibility.LocalLightPrimitiveInteraction 0`来消除各光源的大部分CPU开销。

## 局限性

通用限制：

- MegaLights与前向渲染器不兼容

我们计划解决的现存限制：

- 每处光源都存在用于追踪图元交互的遗留CPU开销，而MegaLights不需要这些开销
- 不支持定向光源云阴影。
- 不支持次表面散射的厚度估算。
- 不支持水、云、异类体积和局部体积

## 平台支持

- MegaLights专为具有光线追踪功能的当前世代游戏主机（如PlayStation 5、Xbox Series X | S）和PC而设计。
- MegaLights不支持移动端、Switch或上一代主机（如PlayStation 4和Xbox One）


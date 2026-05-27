---
title: "硬件光线追踪"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hardware-ray-tracing-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "硬件光线追踪和路径追踪功能", "硬件光线追踪"]
---

# 硬件光线追踪

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 硬件光线追踪和路径追踪功能 / 硬件光线追踪

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hardware-ray-tracing-in-unreal-engine

光线追踪技术主要用于电影、电视和可视化内容的离线渲染。该技术能产出高质量且自然的图像，同时提供物理维度上精确的投影、环境光遮蔽、反射和全局光照效果。渲染场景的单个帧可能更为耗时，并且通常需要在渲染农场中使用高性能计算机才能完成。

虚幻引擎可以使用支持的硬件进行实时和离线的光线追踪。对于部分功能，虚幻引擎支持独立的光线追踪，例如光线追踪阴影。但大多数核心光追功能都内置在[Lumen全局光照和反射系统](../../global-illumination/lumen-global-illumination-and-reflections/index.md)之中。硬件光线追踪也可以搭配[Sequencer](../../../../animating-characters-and-objects/cinematics-and-movie-making/index.md)和[影片渲染队列](https://dev.epicgames.com/documentation/404)一起使用，产出高质量的渲染结果。

虚幻引擎的硬件光线追踪功能还结合了传统的光栅技术，这意味着每帧需要逐像素取样的光线更少。结合降噪算法后，能产出明显更接近离线渲染器的结果。

![使用光线追踪功能的示例场景](../../../../../assets/images/e5/e50a788151993786189b6168abd73c511cfaa8c86deb8954070b26ed8791b9eb.jpg)

使用光线追踪功能的示例场景，例如光线追踪阴影和光线追踪反射。

## 启用硬件光线追踪

要为项目启用硬件光线追踪，请转到项目设置（Project Settings）的 **引擎（Engine） > 渲染（Rendering） > 硬件光线追踪（Hardware Ray Tracing）** 。勾选 **支持硬件光线追踪（Support Hardware Ray Tracing）** 即可。

![硬件光线追踪项目设置](../../../../../assets/images/c1/c1e7e92fb3a9a4978d97f6000f7da0bb674f29511cc6346491ed49e14a846833.jpg)

注意事项：

- 启用

  支持硬件光线追踪（Support Hardware Ray Tracing）

  后，如果尚未启用"支持计算皮肤缓存（Support Compute Skin Cache）"，系统可能会弹出提示，让你启用该功能。硬件光线追踪要求启用该功能。
- 如果你勾选了

  在可用时使用硬件光线追踪（Use Hardware Ray Tracing when available）

  且

  光线照射模式（Ray Lighting Mode）

  为

  反射的击中照射（Hit Lighting for Reflections）

  ，那么Lumen将使用硬件光线追踪。有关Lumen硬件光线追踪模式的更多信息，请参阅

  Lumen技术细节

  。

### 光线追踪项目设置

与硬件光线追踪相关的项目设置如下：

| 属性 | 说明 |
| --- | --- |
| Lumen |  |
| **在可用时使用硬件光线追踪（Use Hardware Ray Tracing when available）** | 当显卡、RHI和操作系统支持时，为Lumen功能使用硬件光线追踪。否则，Lumen将退回到软件光线追踪模式。请注意，对于具有超过10万个实例的场景，硬件光线追踪将产生显著的场景更新成本。 |
| **光线照射模式（Ray Lighting Mode）** | 当Lumen使用硬件光线追踪时，控制Lumen反射光线的发光方式。默认情况下，Lumen将使用"表面缓存（Surface Cache）"来获得最佳性能，但如果要获得更高质量，可以设置为"击中照射（Hit Lighting）"。 **表面缓存：**使用Lumen生成的卡片逐个计算网格体的光照，以便快速查找场景中光线命中点的光照。此方法可提供最佳的反射性能。 **反射的击中照射（Hit Lighting for Reflections）：**根据光线的命中点计算光照。此方法能提供最高反射质量，但由于需要对材质求值并追踪阴影光线，会大幅增加GPU开销。表面缓存技术仍然被用于间接光照漫反射（即反射中看到的全局光照）。 |
| 硬件光线追踪 |  |
| **支持硬件光线追踪（Support Hardware Ray Tracing）** | 启用对硬件光线追踪功能的支持。需要勾选 **支持计算皮肤缓存（Support Compute Skin Cache）** 。 |
| **光线追踪阴影（Ray Traced Shadows）** | 决定是否将光线追踪阴影作为项目中光源的默认投影方法。光源可以重载并强制打开或关闭光线追踪阴影。此选项需要启用 **支持硬件光线追踪（Support Hardware Ray Tracing）** 。 |
| **纹理LOD（Texture LOD）** | 为光线追踪材质着色器启用自动纹理Mip级别选择。取消勾选后，所有纹理将使用最高分辨率的Mip级别。勾选后，纹理LOD将基于总光线长度、输出分辨率和击中点处的纹理密度取近似值。 |

## 硬件光线追踪的功能

在虚幻引擎的硬件光线追踪功能中，部分功能是独立的，还有一些则集成到了[Lumen全局光照和反射](../../global-illumination/lumen-global-illumination-and-reflections/index.md)系统中。

### 硬件光线追踪阴影

**光线追踪阴影** 属于硬件光线追踪的独立功能，能够模拟环境中对象的柔和区域投影。这些阴影比传统阴影贴图或[虚拟阴影图](https://dev.epicgames.com/documentation/404)更为精准，因为它们可以具有硬接触阴影，而阴影投射物距离接收表面越远，阴影就越柔和。

虚拟阴影贴图是虚幻引擎的默认投影方法，提供合理的柔和阴影，支持更高的阴影分辨率，能够以可控的性能开销匹配Nanite细节丰富的几何形状。光线追踪投影则放弃了这种可控性，实现了更准确的阴影定义。

示例中的灯杆很高，其光源灯具也位于地面上方的高处。在高空中有定向光源的情况下，你可以看到各方法的阴影受到的影响。此示例中的光线追踪阴影越靠近灯杆，地面上的接触阴影就越清晰。而对象距离接收表面越远，阴影就越柔和。虚拟阴影贴图则相反，接触阴影会越硬，但区域阴影越微妙。而传统阴影贴图的硬细节和软细节则始终保持一致，阴影投射物与接收表面的距离不造成任何影响。

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/39a52abf-172c-4ac0-9e49-11e2656a1bc9/shadows-rt.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/851328fe-7ed4-4a73-9525-90babfb0a7ca/shadows-vsm.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/549a99b9-871c-471a-a376-18d87aa73671/shadows-shadowmap.png) |
| 光线追踪阴影 | 虚拟阴影贴图 | 传统阴影贴图 |

光源的 **光源尺寸（Source Size）** （点光源、聚光源和矩形光源）或 **光源角度（Source Angle）** （定向光源）也会影响阴影的锐利度和柔和度。尺寸和角度越大，阴影越柔和，越小则阴影越锐利。

下方示例采用定向光源，展示了默认、较大和较小光源角度之间的差异。请注意这些变化对两种阴影方法产出树影的整体锐度和柔和度的影响。在这个方面，传统阴影贴图不受光源尺寸或角度的影响。

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/893d226e-2f89-4c8e-9a02-fe59c5c8cb5f/sourceangle-default.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/c9fcbf3d-e5b4-43d2-98d6-2634688bc251/sourceangle-increased.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/4f5a156c-ca36-465a-8baf-bef40fd4a823/sourceangle-decreased.png) |
| 定向光源角度：0.5357（默认值） | 定向光源角度：1.25 | 定向光源角度：0.1 |

> [!NOTE]
> 如果为对象启用了Nanite，那么光线追踪功能将使用Nanite回退目标（或回退网格体）为独立的光线追踪阴影投射阴影。回退目标的三角形数量通常比Nanite网格体少，所以可能会导致视觉瑕疵，原因是光线会按网格体的三角形数量进行追踪。你可以禁用此对象的Nanite，或增加回退目标的值，从而减少瑕疵。

### 光线追踪环境光遮蔽

> [!NOTE]
> 禁用Lumen的全局光照才能使用此项独立光线追踪功能。Lumen有自己的环境光遮蔽功能。

**光线追踪环境光遮蔽** （RTAO）能准确地为遮挡环境光照的区域投射阴影，进而使物体更自然地融入环境。例如在墙壁相交处（角落和边缘）投射阴影，或者为裂缝或皮肤上的皱纹增添深度。

下方示例为光线追踪环境光遮蔽与屏幕空间环境光遮蔽（SSAO）的对比。环境光遮蔽可视化后，差异变得更加明显，因为SSAO仅为屏幕上可见的区域应用环境光阴影。例如，汽车下方的区域明显比光线追踪环境光遮蔽的区域更亮。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fa71ad6c-e5a6-41a1-a2d1-8906e12d64f8/ao-raytraced.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6f01035c-3946-48ea-9722-db21355f8f1a/ao-screenspace.png) |
| 光线追踪环境光遮蔽（RTAO） | 屏幕空间环境光遮蔽（SSAO） |

### Lumen的硬件光线追踪反射

Lumen的反射系统内置了光线追踪反射，在项目设置中启用后即可使用。光线追踪反射比Lumen的软件光线追踪模式支持更多几何体类型。特别是，它支持对蒙皮网格体进行追踪。由于光线与网格体的三角形相交，因此它还可以更好地缩放为更高质量的图像，可以选择在光线命中点对光照进行求值，相比之下，Lumen的软件光线追踪只能使用较低质量的表面缓存。

要将硬件光线追踪反射与Lumen结合使用，请打开 **项目设置（Project Settings）** ，找到 **引擎 > 渲染（Engine > Rendering）**，在 **Lumen** 类别中将 **光线照射模式（Ray Lighting Mode）** 设为 **反射的高级照射（High Lighting for Reflections）** 。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/52dcd6b5-b795-471d-bd90-94a2fa33c08a/reflections-hardware.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/cf4642f8-e563-40eb-b68d-8a2624e4df28/reflections-software.png) |
| 硬件光线追踪下的Lumen反射 | 软件光线追踪下的Lumen反射 |

Lumen的反射系统将屏幕空间跟踪与硬件和软件光线追踪模式相结合，以此提供更可靠的反射方法。这有助于掩盖Lumen场景和三角形场景之间的反射不匹配。

> [!TIP]
> 要检查无屏幕追踪情况下Lumen硬件和软件光线追踪模式之间的差异，可以取消勾选后期处理体积设置中 **屏幕追踪（Screen Traces）** 旁边的复选框，以将屏幕追踪禁用。

如需详细了解Lumen反射系统，请参阅[Lumen全局光照和反射](../../global-illumination/lumen-global-illumination-and-reflections/index.md)以及[Lumen技术细节](../../global-illumination/lumen-global-illumination-and-reflections/lumen-technical-details/index.md)。

## 使用光线追踪功能

下方小节将介绍在你自己的项目中使用并配置光线追踪功能的方法。光线追踪设置主要针对单个Actor（例如光源、静态网格体和骨骼网格体）以及后期处理体积。

### 后期处理体积

后期处理体积包含了配置硬件光线追踪功能所需的大部分设置。这些放置的体积可用于配置关卡中光线追踪的全局使用，或配置关卡的特定区域。例如，你可以将大面积区域设为使用较低质量的设置，从而节省性能开销，同时在室内使用较小的体积和较高质量的设置，从而提高反射质量，或让多个光源弹射以进行反射。

你可以使用后期处理体积控制以下光线追踪功能：

后期处理体积提供下列独立的光线追踪功能的功能按钮：

- 环境光遮蔽（独立功能）
- 使用击中照射的Lumen反射
- 半透明度（独立功能）

如需详细了解可用的后期处理设置，请参阅"光线追踪和路径追踪器属性"。

### 光源

默认情况下，光源将使用项目设置中指定的默认投影方法。但如果项目启用了光线追踪，那么光源可以选择使用项目设置中指定的方法，或强制启用或禁用光线追踪。

你可以打开 **细节（Details）** 面板，从 **投射光线追踪阴影（Cast Ray Traced Shadows）** 下拉框中选择 **使用项目设置（Use Project Setting）** （默认）、 **启用（Enable）** 或 **禁用（Disabled）** 。

光源的尺寸和角度也会影响物体阴影的外观。尺寸和角度等因素可以让受到光源影响的对象产生更为锐利或更为柔和的投影。例如，你可以看到增加定向光源角度对水塔阴影的影响。相比默认值，阴影更柔和，锐利的阴影更少。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fc513d74-a89f-4f48-94d8-c26a00266512/sourceangle-1-default.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/da472d49-daa0-454d-af0c-06b8dc14906e/sourceangle-1-increased.png) |
| 定向光源角度：0.5357（默认值） | 定向光源角度：1.5 |

点光源和聚光源对物体阴影的柔化效果类似，具体视其大小而定。尺寸越大，阴影越柔和。

另一方面，矩形光源可以大也可以小，而且其光源并非来自单个点。矩形光源可以产生具有明确[本影、半影和伪本影](https://zh.wikipedia.org/zh-cn/%E6%9C%AC%E5%BD%B1%E3%80%81%E5%8D%8A%E5%BD%B1%E5%92%8C%E5%81%BD%E6%9C%AC%E5%BD%B1)的阴影（由不透明物体产生的阴影内外部）。光源面积越大，越能体现这种效果。

下方视频展示了改变矩形光源的宽度和高度对物体投射阴影的影响。

如需详细了解这些类型的光源及其属性，请参阅[光源类型及其可移动性](../../light-types-and-their-mobility/index.md)。

## 性能和调试

如需详细了解和制定策略来优化项目和调试使用光线追踪功能的内容，请参阅[光线追踪性能指南](https://dev.epicgames.com/documentation/404)。

## 附加提示

以下是针对硬件光线追踪功能的额外考虑因素。

### 搭配Vulkan使用硬件光线追踪

> [!WARNING]
> 此功能为试验性功能。

Vulkan支持光线追踪功能，包括与DirectX 12和Shader Model 6对等的功能。这意味着它可以使用全套光线追踪功能，包括Lumen的击中照射模式以及路径追踪。

Vulkan光线追踪支持Linux和Windows平台。

要为项目启用Vulkan光线追踪，请将以下行添加到对应配置文件（*ini）中：

将以下行添加到 **Engine/Config/VulkanPC** 文件夹 **DataDrivenPlatformInfo.ini** 文件的 `[ShaderPlatform VULKAN_SM6]` 分段中：

```
bSupportsRayTracingShaders = truebSupportsPathTracing = truebSupportsRayTracingCallableShaders = truebSupportsRayTracingProceduralPrimitive = trueBindlessSupport=RayTracingOnly
```

你需要更新位于文件夹 **Engine/Config/Linux** 或 **Engine/Config/Windows** 中的 **BaseLinuxEngine.ini** 或 **BaseWindowEngine.ini** 文件，具体取决于你是为Windows还是Linux添加了Vulkan光线追踪。

```
[SF_VULKAN_SM6]BindlessResources=EnabledBindlessSamplers=Enabled
```

### 在运行时开关光线追踪

> [!WARNING]
> 此功能为试验性功能。

你可以动态地为PC游戏项目打开或关闭硬件光线追踪，无需重新启动游戏。如果你想让玩家可以因为性能原因而选择关闭相关功能，这将很有用。 你可以将以下命令添加到 **WindowsEngine.ini** 配置文件，从而启用此功能：

- r.RayTracing.EnableOnDemand=1
- r.RayTracing.Enable=1

  - 1为默认值，表示启动时启用硬件光线追踪。0表示启动时禁用。

在项目配置文件中设置好后，你可以使用以下 `r.RayTracing.Enable` 命令开关硬件光线追踪。选项如下：

- 0

  禁用光线追踪。
- 1

  始终启用光线追踪。

## 支持的光线追踪功能

> [!NOTE]
> 以下功能列表旨在让你了解虚幻引擎的核心硬件光线追踪功能支持哪些功能。下表并非受支持功能的完整列表。

| 功能 | 支持（是/否/部分） | 备注 |
| --- | --- | --- |
| 渲染路径 |  |  |
| **延迟** | 是 |  |
| **前向** | 否 |  |
| 几何体类型 |  |  |
| **Nanite** | 否 | 回退目标（即回退网格体）仅被用于启用了Nanite的网格体。在静态网格体编辑器中调低回退相对误差设置，以便在光线追踪场景中使用更多网格三角形进行表示。用 `r.RayTracing.Nanite.Mode` 启用Nanite。0（默认值）表示支持Nanite的回退网格体。1表示支持流出网格体。 |
| **蒙皮网格体（Skinned Meshes）** | 是 |  |
| **静态网格体（Static Mesh）** | 是 |  |
| **几何体缓存（Geometry Cache）（Alembic）** | 是 |  |
| **地形（Landscape）** | 是 |  |
| **层级实例化静态网格体（Hierarchical Instanced Static Mesh ）（HISM）** | 是 |  |
| **实例化静态网格体（Instanced Static Mesh）(ISM)** | Y |  |
| **样条线（Splines）** | 是 |  |
| **程序化网格体（Procedural Mesh）** | 是 | 在光线追踪中渲染此类几何体的开销较高。 |
| **细节等级（LOD）** | 是 | 尚不支持颤动LOD过渡。 |
| **世界位置偏移驱动型动画（World Position Offset-driven Animation）** | 是 | 检查单个场景Actor的 **求值世界位置偏移（Evaluate World Position Offset）** 属性以选择对光线追踪使用世界位置偏移（WPO）。 |
| **毛发发束（Hair Strands）** | 是 | 对毛发发束的支持仍处于试验阶段，因为它可能需要许多资源来编译高效的加速结构。你可以使用控制台变量 `r.HairStrands.RayTracingProceduralSplits` 来平衡渲染性能和加速结构编译性能（内存占用）。使用默认值4时，会注重渲染性能，但大量开槽器（Groover）可能导致不稳定。如果你遇到GPU超时，尝试降低该值，减少Groom中的毛发片段数量。 |
| **水体几何体（Water Geometry）** | 是 | `r.RayTracing.Geometry.Water` 为1时支持。 |
| 视觉效果（VFX） |  |  |
| **Niagara** | 部分 | 目前仅支持Sprite、条带（Ribbon）和网格体发射器。 |
| 光源类型 |  |  |
| **定向光源（Directional Light）** | 是 |  |
| **天空光照（Sky Light）** | 是 |  |
| **点光源（Point Light）** | 是 |  |
| **聚光源（Spot Light）** | 是 |  |
| **矩形光源（Rect Light）** | 是 |  |
| 光源功能 |  |  |
| **自发光表面（Emissive Surfaces）** | 是 | Lumen全局光照和反射系统的软件和硬件光线追踪模式支持此功能。 |
| **天空大气（Sky Atmosphere）** | 是 |  |
| **体积云（Volumetric Clouds）** | 是 |  |
| **高度云（Height Fog）** | 是 |  |
| **体积雾（Volumetric Fog）** | 是 | 通过控制台变量 `r.VolumetricFog.InjectRayTracedLights` 启用： 0：禁用（出于性能开销考虑，此为默认值） 1：将带有光线追踪的光源注入体积雾 |
| **IES Profiles（IES描述文件）** | 是 |  |
| **Light Functions（光照函数）** | 是 |  |
| **基于图像的照明（IBL）（Image Based Lighting (IBL)）** | 是 | HDRI和天空光照支持此功能。 |
| **光透射（Light Transmission）** | 否 | 半透明阴影被视为不透明，意味着没有彩色阴影或光线能穿透材质。 |
| 材质：着色模型 |  |  |
| **默认光照（Default Lit）** | 是 |  |
| **无光照（Unlit）** | 部分 |  |
| **遮罩（Masked）** | 部分 | 支持投射遮罩阴影。 |
| **次表面和次表面轮廓（SubSurface and SubSurface Profile）** | 是 |  |
| **预整合皮肤（Preintegrated Skin）** | 部分 | 可运行，但未正确光线追踪结果。其使用栅格化流程。 |
| **透明涂层（Clear Coat）** | 是 | UE 4.25对透明图层着色模型进行了显著改善。 |
| **双面植被（TwoSided Foliage）** | 是 |  |
| **头发（Hair）** | 部分 | 可运行，但未正确光线追踪结果。其使用栅格化流程。 |
| **布料（Cloth）** | 部分 | 可运行，但未正确光线追踪结果。其使用栅格化流程。 |
| **眼睛（Eye）** | 是 |  |
| **单层水（Single Layer Water）** | 是 |  |
| **薄半透明（Thin Translucent）** | 是 | 不支持彩色光透射。 |
| **从材质表达式（From Material Expression）** | 是 |  |
| 材质功能 |  |  |
| **Substrate** | 是 | 实现了试验性的支持。 |
| **彩色阴影（Colored Shadows）** | 否 |  |
| **半透明阴影（Translucent Shadows）** | 是 |  |
| **折射（Refraction）** | 是 |  |
| **贴花（Decals）** | 是 |  |
| **各向异性（Anisotropy）** | 是 |  |
| 系统支持 |  |  |
| **Sequencer影片渲染队列（Sequencer Movie Render Queue）** | 是 |  |
| **正色摄像机投影（Orthographic Camera Projection）** | 是 |  |
| **多视图（VR和分屏）（Multi-View (VR and Split-Screen)）** | 是 |  |

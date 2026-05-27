---
title: "渲染"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/rendering-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "渲染"]
---

# 渲染

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 渲染

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/rendering-settings-in-the-unreal-engine-project-settings

## 渲染

### 移动

| **分段** | **说明** |
| --- | --- |
| **禁用移动着色器中的顶点雾（Disable Vertex Fogging in Mobile Shaders）** | 如果启用，顶点雾将从大部分移动基础通道着色器中省略。 相反，雾将在单独的通道中应用，并且仅在场景有雾组件时应用。 |
| **要渲染的CSM级联最大数量（Maximum Number of CSM Cascades to Render）** | 使用移动渲染器时，要用于渲染动态定向光源阴影的级联的最大数量。 |
| **移动抗锯齿方法（Mobile Anti-Aliasing Method）** | 移动默认抗锯齿方法。 你可以选择以下选项： **无（None）** **快速近似抗锯齿（Fast Approximate Anti-Aliasing (FXAA)）** **时间抗锯齿（Temporal Anti-Aliasing (TAA)）** **多重采样抗锯齿（Multisample Anti-Aliasing (MSAA)）** |
| **移动浮点精度模式（Mobile Float Precision Mode）** | 着色器和材质的项目范围移动浮点精度模式。 更改此设置需要重新启动编辑器。 你可以选择以下选项： **使用半精度（Use Half-Precision）**半精度，但 `.ush` / `.usf` 中的显式浮点除外。 **仅将全精度用于MaterialExpressions（Use Full-Precision for MaterialExpressions Only）** ：半精度，但用于 `.ush` / `.usf` 中的材质浮点和显式浮点的全精度除外。 **将全精度用于每个浮点（Use Full-Precision for Every Float）** ：所有浮点都为全精度。 |
| **允许抖动LOD过渡（Allow Dithered LOD Transition）** | 定义是否在移动平台上支持 **抖动LOD过渡（Dithered LOD Transition）** 材质选项。 启用此选项可能会降低性能，因为早期Z优化对渲染没有帮助。 |
| **在移动平台上启用虚拟纹理支持（Enable Virtual Texture Support on Mobile）** | 定义是否在移动平台上支持虚拟纹理。 还需要启用通用虚拟纹理选项。 更改此设置需要重新启动编辑器。 |
| **移动反射捕获压缩（Mobile Reflection Capture Compression）** | 定义是否将反射捕获压缩用于移动平台。 它将使用ETC2格式执行压缩。 |
| **支持可移动光源CSM着色器剔除（Support Movable Light CSM Shader Culling）** | 可移动定向光源照亮的图元将仅在确定位于CSM范围内时使用CSM着色器渲染。 更改此设置需要重新启动编辑器。 |
| **移动环境光遮蔽（Mobile Ambient Occlusion）** | 启用移动环境光遮蔽。 在启用移动环境光遮蔽后，将在移动基础通道像素着色器中额外占据一个采样器。 更改此设置需要重新启动编辑器。 |
| **平面反射模式（Planar Reflection Mode）** | 移动平台上的平面反射的工作方式不同，具体取决于所选模式。根据你的移动项目选择最适合的模式。 更改此设置需要重新启动编辑器。 你可以选择以下选项： **通常（Usual）** ：平面反射Actor在所有平台上照常工作。 **MobilePPR专有（MobilePPR Exclusive）** ：平面反射Actor仅用于移动像素投影反射，不会影响PC/主机。使用此模式时将禁用MobileMSAA。 **MobilePPR** ：平面反射Actor在PC/主机平台上照常工作，并用于移动平台上的移动像素投影反射。使用此模式时将禁用MobileMSAA。 |
| **在移动平台上支持台式机第四代TAA（Supports Desktop Gen4 TAA on Mobile）** | 定义使用移动渲染时是否支持桌面Gen4 TAA。 更改此设置需要重新启动编辑器。 |

### 材质

| **分段** | **说明** |
| --- | --- |
| **游戏废弃未使用的材质量级别（Game Discards Unused Material Quality Levels）** | 在游戏模式下运行时，定义是将所有质量级别的着色器保留在内存中，还是仅保留当前质量级别所需的着色器。 如果该选项未启用，则引擎会将所有质量级别保留在内存中，以便实现在运行时更改质量级别。此选项为默认。 如果启用了该选项，则引擎会在加载游戏内容时废弃未使用的质量级别，节省一些内存。 |
| **着色器压缩格式（Shader Compression Format）** | 选择如何压缩着色器进行存储。 你可以选择以下选项： **不压缩（Do not compress）** **LZ4** **Oodle** **ZLib** |
| **透明涂层启用第二法线（Clear Coat Enable Second Normal）** | 将单独的法线贴图用于透明涂层材质的底部层。 这是质量更高的功能，但成本很高。 |
| **启用粗糙漫反射材质（Enable Rough Diffuse Material）** | 使材质的漫反射组件能够根据材质的根节点上设置的粗糙度输入受到影响。 |
| **在材质上启用节能（Enable Energy Conservation on Material）** | 启用后，材质会减少金属和玻璃材质的高光度波瓣中的能量（光）损失。此功能仅使用路径追踪器实现。 更改此属性需要重新启动编辑器。 |

### 剔除

| **分段** | **说明** |
| --- | --- |
| **遮挡物剔除（Occlusion Culling）** | 如果未启用，允许剔除而不渲染遮挡的网格体。 |
| **光源的最小屏幕半径（Min Screen Radius for Lights）** | 将导致从渲染中剔除光源的光源最小屏幕半径（以厘米为单位）。 使用更大半径大小可剔除更多光源，提高性能，但会使其在仅影响小部分屏幕时快速消失。 |
| **早期Z通道的最小屏幕半径（Min Screen Radius for Early Z Pass）** | 将导致使用深度检查从渲染中剔除Actor的最小屏幕半径（以厘米为单位）。 使用更大值可剔除更大对象遮挡的对象，提高性能。但是，使用太大的值还会删除遮挡了背后对象的大对象，进而渲染意外的对象数量。 |
| **级联阴影贴图的最小屏幕半径（Min Screen Radius for Cascaded Shadow Maps）** | 在级联阴影贴图深度通道中从渲染剔除对象的最小屏幕半径（以厘米为单位）。 使用更大值可将更少Actor渲染到阴影贴图中，提高性能，但会导致满足最小屏幕半径的Actor不再投射阴影。 |
| **就没有预计算的可视性发出警告（Warn About No Precomputed Visibility）** | 在当前摄像机位置没有预计算的可视性数据时，显示警告。 如果你制作的游戏依赖于预计算的可视性，例如第一人称移动游戏，这样做很有用。 |

### 纹理

| **分段** | **说明** |
| --- | --- |
| **纹理流送（Texture Streaming）** | 启用后，纹理将基于屏幕上可见的内容进行流送。 纹理流送器会提高和降低可见纹理的分辨率，允许在要紧之处实现合适的视觉效果质量，同时更高效地管理可用内存。 |
| **使用DXT5法线贴图（Use DXT5 Normal Maps）** | 定义是否将DXT5用于法线贴图。如果未启用，将使用BC5，后者并非在所有硬件上都受支持。 更改此设置需要重新启动编辑器。 |

### 虚拟纹理

| **分段** | **说明** |
| --- | --- |
| **启用虚拟纹理支持（Enable Virtual Texture Support）** | 启用后，纹理可以使用虚拟纹理系统进行流送。 更改此设置需要重新启动编辑器。 |
| **在纹理导入时启用虚拟纹理（Enable Virtual Texture on Texture Import）** | 基于纹理导入设置中的"自动虚拟纹理大小（Auto Virtual Texturing Size）"，为导入的纹理设置"虚拟纹理流送（Virtual Texture Streaming）"设置。 |
| **启用虚拟纹理光照贴图（Enable Virtual Texture Lightmaps）** | 启用后，光照贴图将使用虚拟纹理系统进行流送。 更改此设置需要重新启动编辑器。 |
| **启用虚拟纹理各向异性筛选（Enable Virtual Texture Anisotropic Filtering）** | 启用后，虚拟纹理将使用各向异性筛选。 这为使用虚拟纹理的所有着色器增加了成本。 更改此设置需要重新启动编辑器。 |
| **图块大小（Tile Size）** | 虚拟纹理图块的大小（以像素为单位）将舍入为2的下一个幂。 更改此设置需要重新启动编辑器。 |
| **图块边框大小（Tile Border Size）** | 虚拟纹理图块边框的大小（以像素为单位）将舍入为2的下一个幂。 使用更大边框可实现更高程度的各向异性筛选，但会使用更多磁盘/缓存内存。 更改此设置需要重新启动编辑器。 |
| **反馈分辨率因子（Feedback Resolution Factor）** | 使用较低因子会提高虚拟纹理反馈分辨率，从而提高CPU/GPU开销，但可能会降低流送延迟，尤其是材质使用许多虚拟纹理时。 |

### 工作颜色空间

| **分段** | **说明** |
| --- | --- |
| **工作颜色空间（Working Color Space）** | 从提供的工作颜色空间列表中选择，或选择"自定义（Custom）"以提供用户定义的空间： **sRGB / Rec709** **Rec2020** **ACES AP0** **ACES AP1 / ACEScg** **P3DCI** **P3D65** **自定义（Custom）** |
| **红色色度坐标（Red Chromaticity Coordinate）** | 工作颜色空间红色色度坐标。 |
| **绿色色度坐标（Green Chromaticity Coordinate）** | 工作颜色空间绿色色度坐标。 |
| **蓝色色度坐标（Blue Chromaticity Coordinate）** | 工作颜色空间蓝色色度坐标。 |
| **白色色度坐标（White Chromaticity Coordinate）** | 工作颜色空间白色色度坐标。 |

### 全局光照

| **分段** | **说明** |
| --- | --- |
| **动态全局光照方法（Dynamic Global Illumination Method）** | 设置动态全局光照的方法。 你可以选择以下选项： **无（None）** ：将不会使用动态全局光照方法。全局光照仍可以烘焙到光照贴图中。 **Lumen** ：将Lumen全局光照用于所有光源、自发光材质投射光源和天空光照遮蔽。需要为软件光线追踪启用"生成网格体距离场（Generate Mesh Distance Fields）"，并为硬件光线追踪启用"支持硬件光线追踪（Support Hardware Ray Tracing）"。 **屏幕空间（测试版）（Screen Space (Beta)）** ：独立屏幕空间全局光照。低成本，但受限于屏幕空间信息。 **独立光线追踪（废弃）（Standalone Ray Traced (Deprecated)）** ：独立光线追踪全局光照技术。已废弃，请改用Lumen全局光照。 **插件（Plugin）** ：使用全局光照的插件。 |

### 反射

| **分段** | **说明** |
| --- | --- |
| **反射方法（Reflection Method）** | 反射方法。 你可以选择以下选项： **无（None）** ：将不会使用全局反射方法。反射仍可以来自反射捕获、平面反射或放入关卡中的天空光照。 **Lumen** ：使用Lumen反射，它同时支持屏幕/软件/硬件光线追踪，并与Lumen全局光照集成，实现粗糙反射以及反射中看到的全局光照。 **屏幕空间（Screen Space）** ：独立屏幕空间反射。低成本，但受限于屏幕空间信息。 **独立光线追踪（废弃）（Standalone Ray Traced (Deprecated)）** ：独立光线追踪反射技术。已废弃，请改用Lumen反射。 **插件（Plugin）** ：使用全局光照的插件。 |
| **反射捕获分辨率（Reflection Capture Resolution）** | 所有反射捕获探针的立方体贴图分辨率。 必须是2的幂。 请注意，对于非常高的值，内存和性能影响可能很严重。 |
| **减少光滑表面上的光照贴图混合（Reduce Lightmap Mixing on Smooth Surfaces）** | 定义是否为非常光滑的表面减少反射捕获的光照贴图混合。 这适合用于确保反射捕获匹配屏幕空间反射（SSR）或平面反射的亮度。 |
| **支持平面反射的全局裁剪平面（Support Global Clip Plane for Planar Reflections）** | 定义是否支持平面反射所需的全局裁剪平面。 启用此项可增加基础通道三角形成本大约12%，无论平面反射是否处于活动状态。 更改此设置需要重新启动编辑器。 |

### Lumen

| **分段** | **说明** |
| --- | --- |
| **在可用时使用硬件光线追踪（Use Hardware Ray Tracing When Available）** | 在显卡、RHI和操作系统支持时，将硬件光线追踪用于Lumen功能。 否则，Lumen将重新使用软件光线追踪。 对于具有超过10万个实例的场景，硬件光线追踪将产生显著的场景更新成本。 |
| **光线照射模式（Ray Lighting Mode）** | 当Lumen使用硬件光线追踪时，控制Lumen反射光线如何发光。 默认情况下，Lumen使用"表面缓存（Surface Cache）"来获得最佳性能，但如果要获得更高的质量，可以设置为"击中照射（Hit Lighting）"。 |
| **软件光线追踪模式（Software Ray Tracing Mode）** | 在使用软件光线追踪时，控制Lumen使用哪种追踪方法。 你可以选择以下选项： **细节追踪（Detail Tracing）** ：使用软件光线追踪时，Lumen将针对单独网格体的距离场进行追踪，以实现最高质量。在有许多重叠实例的场景中，成本可能很高。 **全局追踪（Global Tracing）** ：使用软件光线追踪时，Lumen将针对全局距离场进行追踪，以实现最快速追踪。 |

### 阴影

| **分段** | **说明** |
| --- | --- |
| **阴影贴图方法（Shadow Map Method）** | 选择主阴影映射方法。在为项目启用"前向着色（Forward Shading）"时，自动使用 **阴影贴图（Shadow Maps）**，因为不支持虚拟阴影贴图。 你可以选择以下选项： **阴影贴图（Shadow Maps）** ：将几何体渲染到阴影深度贴图中以投射阴影。需要手动设置阴影投射实例，并仅逐个组件剔除，导致高精度多边形场景的性能较差。为固定光源烘焙阴影投射需要此方法。但是，固定光照与启用Nanite且可移动的网格体不兼容，因此它们不会投射动态阴影。 **虚拟阴影贴图（测试版）（Virtual Shadow Maps (Beta)）** ：将几何体渲染到虚拟化阴影深度贴图中以投射阴影。为带有简化设置的下一代项目提供高质量阴影。用于Nanite时可进行高效率剔除。 该系统在开发中，因此存在一些性能缺陷。 |

### 硬件光线追踪

| **分段** | **说明** |
| --- | --- |
| **支持硬件光线追踪（Support Hardware Ray Tracing）** | 设置硬件光线追踪功能的支持。 需要 **支持计算皮肤缓存（Support Compute Skincache）**，才允许项目进行此设置。 |
| **光线追踪阴影（Ray Traced Shadows）** | 控制是否默认使用光线追踪阴影。 光源仍可以覆盖和强制光线追踪阴影打开或关闭。 需要启用硬件光线追踪。 |
| **光线追踪天空光照（Ray Traced Skylight）** | 控制是否默认使用光线追踪天空光照。 天空光照仍可以覆盖和强制光线追踪天空光照打开或关闭。 需要启用硬件光线追踪。 在动态全局光照方法设置为Lumen时不起作用。 |
| **纹理LOD（Texture LOD）** | 在光线追踪材质着色器中启用自动纹理Mip级别选择。 如果取消勾选，最高分辨率Mip级别用于所有纹理（默认值）。 如果勾选，纹理LOD基于总光线长度、输出分辨率和击中点处的纹理密度取近似值（光线椎体方法）。 |
| **路径追踪（Path Tracing）** | 启用路径追踪渲染器。 这可启用更多材质排列。 需要启用硬件光线追踪。 |

### 软件光线追踪

| **分段** | **说明** |
| --- | --- |
| **生成网格体距离场（Generate Mesh Distance Fields）** | 定义是否构建静态网格体的距离场（Lumen中的软件光线追踪所需）、距离场AO（用于实现可移动天空光照阴影）以及定向光源上的光线追踪距离场阴影。 启用此功能将会增加静态网格体的构建时间、内存使用和磁盘大小。 更改此设置需要重新启动编辑器。 |
| **距离场体素密度（Distance Field Voxel Density）** | 确定网格体的默认刻度如何转换成距离场体素维度。 更改此值将导致重新构建所有距离场。 值越大，占用内存的速度可能会越快！ 更改此设置需要重新启动编辑器。 |

### 杂项光照

| **分段** | **说明** |
| --- | --- |
| **允许静态光照（Allow Static Lighting）** | 定义是否允许生成和使用静态光照，例如光照贴图和阴影贴图。 仅使用动态光照的游戏应将其设置为0，节省一些静态光照开销。 将其禁用，材质AO和材质BentNormal就可以用于Lumen全局光照。 更改此设置需要重新启动编辑器。 |
| **将法线贴图用于静态光照（Use Normal Maps for Static Lighting）** | 定义是否允许静态光照将法线贴图用于光照计算。 |
| **DBuffer贴花（DBuffer Decals）** | 定义是否在基础通道之前将贴花属性累加到缓冲区。 DBuffer贴花会正确地影响光照贴图和天空光照，这与常规延迟贴花不同。 DBuffer启用了强制完全预通道。 更改此设置需要重新启动编辑器。 |

### 正向渲染器

| **分段** | **说明** |
| --- | --- |
| **正向着色（Forward Shading）** | 定义是否在台式机平台上使用正向着色，需要Shader Model 5硬件。 正向着色支持MSAA，并且其默认成本较低，但总体支持的功能较少。 材质必须选择加入成本更高的功能，例如高质量反射。 更改此设置需要重新启动编辑器。 |
| **不透明材质的顶点雾（Vertex Fogging for Opaque）** | 导致不透明材质使用逐个顶点的雾，这样成本稍低。 仅支持用于正向着色。 更改此设置需要重新启动编辑器。 |

### 半透明

| **分段** | **说明** |
| --- | --- |
| **单独半透明（Separate Translucency）** | 允许将半透明渲染到在景深之后定位与合成的单独渲染。 防止半透明看起来失焦。 |
| **半透明排序策略（Translucent Sort Policy）** | 半透明图元的排序模式，会影响其排序发生以及它们随摄像机移动而改变顺序的方式。 需要单独半透明（位于 **显示（Show）> 高级（Advanced）** 下的 **视口选项（Viewport Options）** 中）为true。 你可以选择以下选项： **按距离排序（Sort by Distance）** ：基于从摄像机中心点到边界球体中心点的距离排序（默认值，最适合3D游戏）。 **按投影的Z排序（Sort by Projected Z）** ：基于与摄像机的投影后Z距离排序。 **沿轴排序（Sort Along Axis）** ：基于到固定轴的投影排序（最适合2D游戏）。 |
| **半透明排序轴（Translucent Sort Axis）** | 半透明排序策略设置为 `SortAlongAxis` 时，将沿哪个轴排序。 |

### VR

| **分段** | **说明** |
| --- | --- |
| **HMD固定注视点级别（试验性）（HMD Fixed Foveation Level (Experimental)）** | 设置在生成可变速率着色附件时要应用的固定注视点级别。 此功能当前为试验性功能。 这可以对支持Tier 2 VRS的GPU产生一些相当显著的性能优势。 使用更低的设置时，大部分头戴式设备（HMD）上的瑕疵几乎察觉不到；使用更高的设置时，视图边缘附近会显示一些瑕疵。 你可以选择以下选项： **禁用（Disabled）** **低（Low）** **中（Medium）** **高（High）** **最高（High Top）** |
| **动态固定注视点（试验性）（Dynamic Fixed Foveation (Experimental)）** | 允许固定注点视级别基于GPU利用率动态调整。 级别在最小值处为"无"，在最大值处为当前所选注视点级别。 |
| **实例化立体（Instanced Stereo）** | 通过视图实例化或绘制调用实例化启用单通道立体渲染。 |
| **移动HDR（Mobile HDR）** | 如果勾选，移动管线将包括带有色调映射的完全后期处理通道。 禁用此设置可提升性能并实现立体渲染优化。 更改此设置需要重新启动编辑器。 |
| **移动多视图（Mobile Multi-View）** | 在移动平台上启用单通道立体渲染。 |
| **循环遮蔽查询（Round-Robin Occlusion Queries）** | 启用VR的遮蔽查询的循环安排。 |

### 后期处理

| **分段** | **说明** |
| --- | --- |
| **自定义深度-模板通道（Custom Depth-Stencil Pass）** | 定义是否启用自定义深度通道来为后期处理通道标记图元。 按需启用可节省内存，但可能在首次使用该功能时导致卡顿。 你可以选择以下选项： **禁用（Disabled）** **启用（Enabled）** ：深度缓冲区将立即创建，模板将禁用。 **按需启用（Enabled on Demand）** ：深度缓冲区在首次使用时创建；此选项可节省内存，但会导致停顿。模板将禁用。 **使用模板启用（Enabled with Stencil）** ：深度缓冲区将立即创建，模板将可用于读/写。 |
| **带TemporalAA抖动的自定义深度（Custom Depth with TemporalAA Jitter）** | 定义自定义深度通道是否启用了TemporalAA抖动。 在TAA之后（例如，在色调映射之后）使用自定义深度通道的结果时，将其禁用很有用。 |
| **在后期处理中启用Alpha通道支持（试验性）（Enable Alpha Channel Support in Post-Processing (Experimental)）** | 在渲染器的后期处理链中配置Alpha通道支持。 仍为试验性：仅适用于时间抗锯齿、动态模糊、圆圈景深。 此选项还会强制禁用单独半透明。 你可以选择以下选项： **禁用（Disabled）** ：将GPU成本降低到最低限度。默认选项。 **仅线性颜色空间（Linear Color Space Only）** ：仅在线性颜色空间中维持Alpha通道。色调映射器不会输出Alpha通道。 **允许通过色调映射器（Allow Through Tonemapper）** ：在线性颜色空间中维持Alpha通道，但还会通过色调映射器传递它。 通过色调映射器传递Alpha通道可能会不可避免地导致相较于线性颜色空间合成而言相当差的合成质量，尤其是在泛光可以生成的纯叠加像素上。 此设置专门针对广播行业，以防硬件无法执行线性颜色空间合成和色调映射。 |

### 默认设置

| **分段** | **说明** |
| --- | --- |
| **泛光（Bloom）** | 定义是否启用泛光的默认值（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **环境光遮蔽（Ambient Occlusion）** | 定义是否启用AmbientOcclusion的默认值（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **环境光遮蔽静态部分（AO用于烘焙光照）（Ambient Occlusion Static Fraction (AO for Baked Lighting)）** | 定义是否启用 `AmbientOcclusionStaticFraction` 的默认值（仅适合用于烘焙光照，如果AO打开，还允许让SSAO影响烘焙光照，后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **自动曝光（Auto-Exposure）** | 定义是否启用自动曝光的默认值（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **自动曝光方法（Auto-Exposure Method）** | 自动曝光的默认方法（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 你可以选择以下选项： **自动曝光柱状图（Auto-Exposure Histogram）** ：此方法构造64柱的柱状图，能够使用一些高级设置更精细地控制自动曝光。 **自动曝光基本（Auto-Exposure Basic）** ：通过下采样计算单个值的更快速方法。 **手动（Manual）** ：此方法使用摄像机设置。 |
| **自动曝光偏差（Auto-Exposure Bias）** | 自动曝光偏差的默认值。 |
| **动态模糊（Motion Blur）** | 定义是否启用MotionBlur的默认值（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **镜头光晕（基于图像）（Lens Flares (Image-Based)）** | 定义是否启用LensFlare的默认值（后期处理体积/摄像机/游戏设置仍可以独立覆盖并启用或禁用它）。 |
| **时间上采样（Temporal Upsampling）** | 定义是否对时间抗锯齿通道执行主屏幕百分比分辨率修改。 |
| **抗锯齿方法（Anti-Aliasing Method）** | 选择要使用的抗锯齿方法。 你可以选择以下选项： **无（None）** **快速近似抗锯齿（Fast Approximate Anti-Aliasing (FXAA)）** **时间抗锯齿（Temporal Anti-Aliasing (TAA)）** **多重采样抗锯齿（Multisample Anti-Aliasing (MSAA)）** **时间超级分辨率（Temporal Super-Resolution (TSR)）** |
| **MSAA取样数量（MSAA Sample Count）** | MSAA的默认取样数量。 你可以选择以下选项： **无MSAA（No MSAA）** ： **2倍MSAA（2x MSAA）** **4倍MSAA（4x MSAA）** **8倍MSAA（8x MSAA）** |
| **光源单位（Light Units）** | 要用于新放置的点光源、聚光光源和矩形光源的单位。 你可以选择以下选项： **无单位（Unitless）** **烛光（Candelas）** **Lumens** |
| **帧缓冲区像素格式（Frame Buffer Pixel Format）** | 未指定时，用于后台缓冲区的像素格式。 你可以选择以下选项： **8位RGBA（8-bit RGBA）** **浮点RGBA（Float RGBA）** **10位RGB，2位Alpha（10-bit RGB, 2-bit Alpha）** |

### 优化

| **分段** | **说明** |
| --- | --- |
| **渲染游戏中未构建的预览阴影（Render Unbuilt Preview Shadows in Game）** | 定义是否渲染游戏中未构建的预览阴影。 启用后，来自未构建静态光照的阴影将使用动态可移动光照在游戏中渲染。 禁用后，之前未构建的静态光照将不会渲染阴影。 禁用此设置后，在关卡编辑器中工作和启动游戏之间的光照不会匹配，因为未构建的静态阴影没有替换为动态预览阴影。 |
| **将模板用于LOD抖动消退（Use Stencil for LOD Dither Fading）** | 定义是否将模板用于LOD抖动消退。 这可在启用了抖动消退的材质的基础通道中节省GPU时间，但会强制执行完全预通道。 更改此设置需要重新启动编辑器。 |
| **早期Z通道（Early Z Pass）** | 定义是否使用仅深度通道来发起基础通道的Z剔除。 你可以选择以下选项： **无（None）** **仅不透明网格体（Opaque Meshes Only）** **不透明和遮罩网格体（Opaque and Masked Meshes）** **自动决定（Decide Automatically）** ：让引擎基于所使用功能决定在早期Z通道中渲染什么内容。 |
| **早期Z通道的遮罩材质（Mask Material Only in Early Z Pass）** | 定义是否仅在早期Z通道中计算材质的遮罩不透明度。 更改此设置需要重新启动编辑器。 |
| **启用CSM缓存（Enable CSM Caching）** | 启用缓存CSM（级联阴影贴图），减少投射CSM的绘制调用，并可能提高性能。 |
| **清除场景（Clear Scene）** | 定义如何在游戏模式下清除GBuffer（仅影响延迟着色）。 你可以选择以下选项： **不清除（Do Not Clear）** ：此选项是速度最快的方法，但除非你渲染到每个像素，否则可能导致瑕疵。确保将天空盒用于此选项！ **硬件清除（Hardware Clear）** ：此选项在渲染之前执行完全清除。大部分项目都应该使用此选项。 **在远平面清除（Clear at Far Plane）** ：此选项绘制一个四边形在远平面执行清除。这样做比一些GPU上的硬件清除更快。 |
| **速度通道（Velocity Pass）** | 定义何时写入速度缓冲区。 更改此设置需要重新启动编辑器。 你可以选择以下选项： **在深度通道期间写入（Write During Depth Pass）** **在基础通道期间写入（Write During Base Pass）** **在基础通道之后写入（Write After Base Pass）** |
| **顶点变形造成的输出速度（Output Velocities Due to Vertex Deformation）** | 允许带有世界位置偏移和/或世界置换的材质在速度通道期间输出速度，即使Actor没有移动时也不例外。 如果 `VelocityPass` 设置为"在基础通道之后写入（Write After Base Pass）"，这可能由于额外的绘制调用而带来性能成本。 如果许多对象在使用世界位置偏移（例如，树林），该性能成本会更高。 你可以选择以下选项： **关闭（Off）** ：总是关闭 **打开（On）** ：总是打开 **自动（Auto）** ：在性能成本很低（深度或基础通道中的速度）时打开。 |
| **选择性GBuffer渲染目标输出（Selective GBuffer Render Targets Output）** | 启用此设置后，不相关的GBuffer渲染目标不会导出。 更改此设置需要重新启动编辑器。 |
| **默认启用粒子镂空（Enable Particle Cutouts by Default）** | 启用此设置后，粒子镂空会自动将粒子的正方形形状向下剪切至其遮罩区域。 此过程用过度绘制来获得稍有增加的顶点数量。 粒子镂空是使用不透明遮罩纹理（如果粒子材质中存在该纹理）自动选择的。如果不透明度遮罩纹理不存在，则将使用该不透明纹理（如果存在）。 |
| **GPU粒子模拟纹理大小 - X（GPU Particle Simulation Texture Size - X）** | GPU模拟纹理大小的X大小。 `SizeX*SizeY` 决定了发射器中GPU模拟的粒子的最大数量。 有可能被 `BaseDeviceProfile.ini` 中的控制台变量设置覆盖。 |
| **GPU粒子模拟纹理大小 - Y（GPU Particle Simulation Texture Size - Y）** | GPU模拟纹理大小的Y大小。 SizeX*SizeY决定了发射器中GPU模拟的粒子的最大数量。 有可能被 `BaseDeviceProfile.ini` 中的控制台变量设置覆盖。 |
| **GBuffer格式（GBuffer Format）** | 选择应该使用哪个GBuffer格式。 主要通过使用多少GPU内存带宽来影响性能。 你可以选择以下选项： **强制每个通道8位（Force 8 Bits Per Channel）** ：强制所有GBuffer采用每个通道8位。旨在用于分析以实现最佳性能。 **默认值（Default）** ：请参阅GBuffer分配函数，了解布局详细信息。 **高精度法线（High Precision Normals）** ：与"默认值"相同，但法线按每个通道16位编码。 **强制每个通道16位（Force 16 Bits Per Channel）** ：强制所有GBuffer采用每个通道16位。旨在用于分析以实现最佳质量。 |
| **将GPU用于计算变形目标（Use GPU for Computing Morph Targets）** | 是使用原始CPU方法（逐个变形循环，然后按顶点），还是使用Shader Model 5硬件上基于GPU的方法。 |
| **支持计算皮肤缓存（Support Compute Skin Cache）** | 启用皮肤缓存系统以使用计算着色器对位置和法线/切线蒙皮，结果会缓存在顶点缓冲区中，然后传递进行渲染。 请注意，当启用硬件光线追踪时，此设置无法禁用。 |
| **默认皮肤缓存行为（Default Skin Cache Behavior）** | 针对骨骼网格体使用哪个渲染路径以及是否自动使用皮肤缓存或 `GPUSkinVertexFactory` 渲染路径，设置默认行为。 如果启用了 **支持光线追踪（Support Ray Tracing）** 的项目设置，并且骨骼网格体在其属性中有 **支持光线追踪**，它将包含到皮肤缓存中（包容行为）。 你可以选择以下选项： **排除（Exclusive）** ：所有骨骼网格体都从皮肤缓存中排除。每个网格体必须单独选择加入。如果在网格体上启用"支持光线追踪（Support Ray Tracing）"，将在该网格体上强制采用包容行为。 **包容（Inclusive）** ：所有骨骼网格体都包含到皮肤缓存中。每个网格体必须单独选择退出。 |
| **每个世界的计算皮肤缓存最大内存（Maximum Memory for Compute Skin Cache Per World (MB)）** | 每个世界/场景允许计算皮肤缓存生成输出顶点数据并重新计算切线的最大内存（以MB为单位）。 |
| **支持仅深度索引缓冲区（Support Depth-Only Index Buffers）** | 支持仅深度索引缓冲区，可带来渲染速度小幅提升，但代价是要使用两次索引缓冲区内存。 |
| **支持反向索引缓冲区（Support Reversed Index Buffers）** | 支持反向索引缓冲区，可带来渲染速度小幅提升，但代价是要使用两次索引缓冲区内存。 |

### 调试

| **分段** | **说明** |
| --- | --- |
| **启用特定于供应商的GPU崩溃分析工具（Enable Vendor-Specific GPU Crash Analysis Tools）** | 启用特定于供应商的GPU崩溃分析工具。 |

### 试验性

| **分段** | **说明** |
| --- | --- |
| **全向立体捕获（Omni-Directional Stereo Capture）** | 使用左、右和全向立体捕获的场景捕获立方体和纹理目标，启用360度立体图像的捕获。 |
| **网格体流送（Mesh Streaming）** | 启用后，网格体将基于屏幕上可见的内容进行流送。 |

### 编辑器

| **分段** | **说明** |
| --- | --- |
| **线框剔除阈值（Wireframe Cull Threshold）** | 将剔除线框视图模式中对象的对象边界框屏幕半径（以厘米为单位）。 |

### 着色器排列缩减

| **分段** | **说明** |
| --- | --- |
| **支持固定天空光照（Support Stationary Skylight）** | 固定天空光照需要基础通道着色器的排列。 禁用此设置将减少每个材质所需的着色器排列数量。 更改此设置需要重新启动编辑器。 |
| **支持低质量光照贴图着色器排列（Support Low-Quality Lightmap Shader Permutations）** | 低质量光照贴图需要光照贴图渲染着色器的排列。 禁用此设置将减少每个材质所需的着色器排列数量。 移动渲染器需要低质量光照贴图，因此对于使用静态光照的移动游戏，不推荐禁用此设置。 更改此设置需要重新启动编辑器。 |
| **支持点光源全场景阴影（Support PointLight WholeSceneShadows）** | PointLight WholeSceneShadows需要许多顶点和几何体着色器排列进行立方体贴图渲染。 禁用此设置将减少每个材质所需的着色器排列数量。 更改此设置需要重新启动编辑器。 |
| **支持天空大气（Support Sky Atmosphere）** | 天空大气组件需要绑定额外采样程序/纹理，以在透明表面（以及通过逐个顶点的评估在移动平台上的所有表面）上应用空中视角。 |
| **支持天空大气影响高度雾（Support Sky Atmosphere Affecting Height Fog）** | 天空大气组件可以照亮高度，但需要绑定额外采样程序/纹理，以在透明表面（以及通过逐个顶点的评估在移动平台上的所有表面）上应用空中视角。 它需要 `r.SupportSkyAtmosphere` 为true。 |
| **支持正向光照半透明材质上的云阴影（Support Cloud Shadow on Forward Lit Translucent）** | 在不依赖半透明光照体积的半透明表面上启用云阴影，例如使用正向光照。 这会逐个顶点进行求值以减少GPU成本，并需要将额外采样程序/纹理绑定到顶点着色器。 这在移动平台上未实现，因为VolumetricCloud在这些平台上不可用。 |

### 移动着色器排列缩减

| **分段** | **说明** |
| --- | --- |
| **支持合并静态和CSM阴影投射（Support Combined Static and CSM Shadowing）** | 允许图元从固定光源接收静态和CSM（级联阴影贴图）阴影。 禁用此设置将释放一个移动纹理采样程序并减少着色器排列。 更改此设置需要重新启动编辑器。 |
| **在启用了强制无预计算光照的关卡上支持CSM（Support CSM on Levels with Force No Precomputed Lighting Enabled）** | 启用 **允许静态光照** 后，用于在没有预计算光照的情况下支持CSM的着色器通常不会生成。 此设置在此情况下允许CSM，代价是需要额外的着色器排列。 更改此设置需要重新启动编辑器。 |
| **支持预烘焙距离场阴影贴图（Support Pre-Baked Distance Field Shadow Maps）** | 为静态网格体图元生成着色器，以便渲染拥有软阴影的距离场贴图（阴影来自Lightmass烘焙的静态直接光源）。 更改此设置需要重新启动编辑器。 |
| **支持可移动定向光源（Support Movable Directional Lights）** | 为图元生成着色器，以接收可移动定向光源。 更改此设置需要重新启动编辑器。 |
| **最大可移动聚光光源/点光源数量（Max Movable Spotlights / Point Lights）** | 在移动设备上要支持的动态聚光光源或点光源的数量。 针对不需要动态聚光光源或点光源的游戏将其设置为0，可减少生成的着色器数量。 更改此设置需要重新启动编辑器。 |
| **支持可移动聚光光源（Support Movable Spotlights）** | 为图元生成着色器，以从可移动聚光光源接收光照。 这在处理可移动光源时会带来额外成本。 更改此设置需要重新启动编辑器。 |
| **支持可移动SpotlightShadows（Support Movable SpotlightShadows）** | 为图元生成着色器，以从可移动聚光光源接收阴影。 更改此设置需要重新启动编辑器。 |

### 蒙皮

| **分段** | **说明** |
| --- | --- |
| **支持16位骨骼索引（Support 16-bit Bone Index）** | 如果启用，导入的新网格体将使用8位（如果骨骼数量不超过256）或16位（如果骨骼数量大于256）骨骼索引来渲染。 |
| **将GPU蒙皮限制为2个骨骼的影响（Limit GPU Skinning to 2-Bones Influence）** | 对于GPU蒙皮，定义是否使用2个骨骼的影响，而不是默认的4。 这不会更改骨骼网格体资产，但会减少GPU皮肤顶点着色器所需的指令数量。 更改此设置需要重新启动编辑器。 |
| **使用无限制的骨骼影响（Use Unlimited Bone Influences）** | 如果启用，导入的新网格体将使用无限制的骨骼缓冲区渲染，而不使用固定的 `MaxBoneInfluences` 。 |
| **无限制的骨骼影响阈值（Unlimited Bone Influences Threshold）** | 启用无限制的骨骼影响时，它仍将使用固定骨骼影响缓冲区，直到网格体的最大骨骼影响超过该值。 |
| **每个分段的最大骨骼数量（Maximum Bones Per Sections）** | 为导入到引擎中的骨骼网格体设置每个材质分段的骨骼数量最大限制。 每个分段允许的骨骼数量是单个绘制调用期间可以在GPU上蒙皮的骨骼数量。 如果源网格体超过该限制，分段将划分为符合该限制的更小数据块。 使用"添加（Add (+)）"按钮可逐个平台指定每个分段要使用的骨骼数量的最大限制。例如，移动平台已添加并设置为最大256个。 更改此设置需要重新启动编辑器。 |

### 后期处理校准材质

| **分段** | **说明** |
| --- | --- |
| **可视化校准颜色材质路径（Visualize Calibration Color Material Path）** | 启用VisualizeCalibrationColor显示标记时（在 **关卡视口（Level Viewport）> 显示（Show）> 开发人员（Developer）** 菜单中），此路径将用作要渲染的后期处理材质。 |
| **可视化校准自定义材质路径（Visualize Calibration Custom Material Path）** | 启用VisualizeCalibrationCustom显示标记时（在 **关卡视口（Level Viewport）> 显示（Show）> 开发人员（Developer）** 菜单中），此路径将用作要渲染的后期处理材质。 |
| **可视化校准灰阶材质路径（Visualize Calibration Grayscale Material Path）** | 启用VisualizeCalibrationGrayscale显示标记时（在 **关卡视口（Level Viewport）> 显示（Show）> 开发人员（Developer）** 菜单中），此路径将用作要渲染的后期处理材质。 |

---
title: "材质属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-material-properties"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质属性"]
---

# 材质属性

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-material-properties

本文详细介绍了材质中的属性。当你选中 **主材质节点（Main Material Node）** 后，这些材质会显示在 **细节** 面板中。

材质中的属性：

![全部材质属性](../../../../assets/images/49/494caa8e4a031a788a5a6f93d4d39b5a36b1abb1e2481e6b912e0520e8d1af57.jpg)

- 物理材质（Physical Material）
- 材质属性（Material Properties）
- 物理材质遮罩（Physical Material Mask）
- 半透明和半透明自身阴影（Translucency and Translucency Self Shadowing）
- 用途标记（Usage Flags）
- 移动（Mobile）
- 前向着色（Forward Shading）
- 分组排序（Group Sorting）
- 后期处理材质（Post Process Material）
- 折射（Refraction）
- Lightmass设置（Lightmass Settings）
- 预览（Previewing）
- 导入设置（Import Settings）

上述属性决定了材质能够实现哪些效果、材质如何与光线交互、以及如何与背后的像素混合。以下篇幅将描述这些属性，按照它们在 **细节（Details）** 面板中的顺序显示。

## 物理材质

![Physical Material properties](../../../../assets/images/bc/bcf4473db151453ba8046f552c14701173bb77d91419e963ca7fc49887f0a681.png)

| 属性 | 描述 |
| --- | --- |
| **物理材质（Phys Material）** | 与此材质关联的[物理材质](../../../gameplay-systems/physics/physical-materials/index.md)。**物理材质（Physical Material）** 提供了物理属性的定义，例如碰撞（弹力）及其他基于物理的方面将保留多少能量。物理材质（Physical Material）对材质的外观没有影响。 |
| **物理材质遮罩（Phys Material Mask）** | 用于此图表材质的物理材质遮罩。用于声音、效果等。 |

## 材质

![Material Properties section](../../../../assets/images/bd/bd63473404ef3fe47fef6642735f453cb5b1d3f1df355c762c1922b002d3ac96.png)

| 属性 | 描述 |
| --- | --- |
| **材质域（Material Domain）** | 你可以使用此设置指定如何使用此材质。某些材质的使用（例如贴花）需要额外的指令，以便渲染引擎加以考虑。正因为如此，指定用于这些情况的材质十分重要。材质域（Material Domain）包括以下选项： **表面（Surface）**：该设置将材质定义为将用于对象表面的东西；可以是金属、塑料、皮肤或任何物理表面。因此这是你大部分时间里都会用到的设置。 **延迟贴花（Deferred Decal）**：制作[贴花材质](../../../understanding-the-basics/actors-and-geometry/unreal-engine-actors-reference/decal-actors/index.md)时，你将使用此设置。 **光照函数（Light Function）**：创建结合光照函数使用的材质时应使用此设置。 **体积（Volume）**：将材质的属性描述为3D体积时使用。 **后期处理（Post Process）**：如果材质将用作[后期处理材质](../../post-process-effects/post-process-materials/index.md)，则使用此设置。 **用户界面（User Interface）**：材质用于UMG或Slate用户界面时使用。 **虚拟纹理（Virtual Texture）**：需要使用[运行时虚拟纹理](../../optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/index.md)时使用。 |
| **混合模式（Blend Mode）** | 混合模式（Blend Mode）描述当前材质的输出如何与背景中已经绘制的内容进行混合。从技术的角度来讲，你可以控制引擎在渲染时将这个材质（**源颜色（Source color）**）与帧缓冲中已经存在的材质（**目标颜色（Destination color）**）结合起来的方式。可用混合模式有： **BLEND_Opaque**：最终颜色 = 源颜色。这意味着材质将在背景上绘制。此混合模式与光照兼容。 **BLEND_Masked**：最终颜色 = 如OpacityMask > OpacityMaskClipValue，则为源颜色；否则该像素将被丢弃。此混合模式与光照兼容。 **BLEND_Translucent**：最终颜色 = 源颜色 *不透明度 + 目标颜色* (1 - 不透明度)。此混合模式与动态光照 **不** 兼容。 **BLEND_Additive**：最终颜色 = 源颜色 + 目标颜色。此混合模式与动态光照 **不** 兼容。 **BLEND_Modulate**：最终颜色 = 源颜色 x 目标颜色。此混合模式与动态光照或雾 **不** 兼容，除非该材质为贴花材质。 **AlphaComposite**：用于那些纹理已经预先与alpha值相乘的材质。也就是说，颜色通道已经乘以alpha，所以当与帧缓冲区混合时，GPU可以跳过通常用于alpha混合的（SrcAlpha * SrcColor）算法。可以改善叠加混合的视觉效果。 **AlphaHoldout**：允许你"继续使用"材质的alpha，在视图空间中，直接在半透明对象上显示一个孔洞。 欲知这些混合模式的详情，请参阅[混合模式](material-blend-modes/index.md)文档。 |
| **着色模型（Shading Model）** | [INCLUDE:#ShadingModels |
| **双面（Two Sided）** | 法线将被翻转到背面，这意味着将同时计算正面和背面的光照。这通常用于植物，避免多边形数量加倍。"双面"无法正常用于静态光照，因为网格体仍然只使用单一UV集进行光线映射。因此，使用静态光照的双面材质两侧会有相同的阴影。 |
| **使用材质属性（Use Material Attributes）** | 此勾选框将使材质主节点被压缩成标记为"材质属性（Material Attributes）"的单一输入。需要使用分层材质混入多个材质、或使用 **创建材质属性）Make Material Attributes）** 表达式节点定义多个材质类型时，此属性十分实用。欲知详情，请参阅[分层材质](../layering-materials/index.md)文档。 |
| **投射光线追踪阴影（Cast Ray Traced Shadows）** | 在项目设置（Project Settings）中启用[光线追踪](../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/index.md)功能后，选中此勾选框可实现将光线追踪阴影与此材质一同使用。 |
| **次表面轮廓（Subsurface Profile）** | 用于更改材质中使用的[次表面轮廓](shading-models/subsurface-profile-shading-model/index.md)。 |

### 高级材质属性

![Material Properties advanced](../../../../assets/images/6b/6b666a30c1b2352d9cf0f524a7bca6edd853025c59bb948f0b7a42ae4797b43e.png)

| 属性 | 描述 |
| --- | --- |
| **贴花响应（Decal Response）（DBuffer）** | 此属性定义了材质对DBuffer贴花的响应（影响外观、性能和纹理/样本使用）。你可以在基元（例如静态网格体）上禁用非DBuffer贴花 |
| **如同被遮罩一样投射动态阴影（Cast Dynamic Shadow as Masked）** | 材质是否应将阴影投射为被遮罩，即使其设置了半透明混合模式也同样如此。 |
| **不透明遮罩剪切值（Opacity Mask Clip Value）** | 此属性是遮罩材质的OpacityMask输入根据每个像素进行剪切的参考值。高于OpacityMaskClipValue的任何值将符合要求，像素将被绘制（不透明）；而低于OpacityMaskClipValue的任何值则不符合要求，像素将被丢弃（透明）。 |
| **抖动LOD过渡（Dithered LOD Transition）** | 用此材质渲染的网格体是否支持抖动LOD过渡。 |
| **抖动不透明遮罩（Dither Opacity Mask）** | 结合临时抗锯齿（TAA）使用时，这可用作一种受限半透明度，其支持所有光照功能。 |
| **允许负自发光颜色（Allow Negative Emissive Color）** | 材质是否应允许输出负自发光颜色值。只有 **无光照** 材质支持此属性。 |
| **自定义UV数量（Num Customized UVs）** | 此属性设置要显示的自定义UV输入的数量。未连接的自定义UV输入只通过顶点UV。 |
| **生成球形粒子法线（Generate Spherical Particle Normal's）** | 围绕使用此材质的粒子系统旋转时，此属性会生成保持球形的表面法线。这适用于体积粒子系统，因为sprite会固定旋转朝向摄像机。通过此选项，它们将拥有更似球形的体积外观。 |
| **切线空间法线（Tangent Space Normal）** | 切线空间法线由物体表面计算而来，Z轴（蓝色）固定指向远离物体表面的方向。世界空间法线使用世界坐标系来计算像素角，忽略表面的原始朝向。在性能方面，切线空间的计算开销更高一些，但通常更方便，因为这些通常是能够在Photoshop等2D应用程序中创建的法线贴图类型。在视觉上，切线空间的法线贴图看上去往往以蓝色为主，而世界空间地图则是生动地呈现为彩虹色。 |
| **自发光（动态区域光）（Emissive(Dynamic Area Light)）** | 如启用，材质的自发光颜色会注入光传播体积。 |
| **完全粗糙（Fully Rough）** | 强制材质为完全粗糙。这样做可以节省很多材质指令和一个采样器。 |
| **法线曲率至粗糙度（Normal Curvature to Roughness）** | 根据屏幕空间法线变化降低粗糙度。 |
| **线框（Wire Frame）** | 启用应用该材质的网格体的线框视图。 |
| **着色率（Shading Rate）** | 选择可变着色率的平台使用何种着色率。 |
| **为天空（Is Sky）** | 材质中使用的无光照（Unlit）和不透明（Opaque）混合模式可以用作穹顶网格体上的天空材质。启用后，这些网格体不会接收来自空中透视的任何贡献。仍将应用高度雾和体积雾效果。 |
| **资产用户数据（Asset User Data）** | 与资产一同存储的一组用户数据。 |

## 物理材质遮罩

![Physical Material Mask](../../../../assets/images/91/91922b50619ed4046ecd02eb61bd75e2e9736956002d0ac357ffee2ef4bd516f.png)

| 属性 | 描述 |
| --- | --- |
| **物理材质图（Physical Material Map）** | 用于此材质的一组物理材质图。遮罩槽可用于将声音、效果或其他类型的物理材质应用于所需颜色通道。 |

## Nanite

| 属性 | 说明 |
| --- | --- |
| **Nanite覆盖材质** | 一种覆盖材质，在使用nanite渲染时，将使用它来代替这个。 |

## 半透明度

![Translucency Properties](../../../../assets/images/3c/3ccfe0d0c5c65ff9c64a79ba12cae6405adf9a1e13c8b8731bf957a9920d7bfb.png)

| 属性 | 描述 |
| --- | --- |
| **屏幕空间反射（Screen Space Reflections）** | 启用此属性后，将支持半透明材质上的屏幕空间反射（SSR）。 |
| **接触阴影（Contact Shadows）** | 启用此属性后，将支持半透明材质上的接触阴影。 |
| **光照模式（Lighting Mode）** | 这可以控制半透明（Translucency）在该材质中使用的光照模式。这特别适用于利用半透明（例如自投影烟雾或蒸汽）的粒子系统。 **体积非定向（Volumetric NonDirectional）**：光照将针对体积计算，且没有方向性。此设置用于烟雾和灰尘等粒子特效。这是开销最低的光照法，但是材质法线并未纳入计算。 **体积定向（Volumetric Directional）**：光照将针对体积计算，且拥有方向性，因此材质法线将纳入计算。请注意：默认粒子切线空间面向摄像机，因此启用 **bGenerateSphericalParticleNormals** 能获取更有用的切线空间。 **体积逐顶点非定向（Volumetric PerVertex NonDirectional）**：与体积非定向（Volumetric NonDirectional）相同，但光照只在顶点处计算，因此像素着色器的开销将大幅降低。请注意，光照仍然来自于一个体积纹理，所以它被限制在一定范围内。定向光源在远处将变得没有阴影。 **体积逐顶点定向（Volumetric PerVertex Directional）**：与体积定向（Volumetric Directional）相同，但光照只在顶点处计算，因此像素着色器的开销将大幅降低。请注意，光照仍然来自于一个体积纹理，所以它被限制在一定范围内。定向光源在远处将变得没有阴影。 **表面半透明体积（Surface Translucency Volume）**：将针对表面计算光照。光在一个体积中累积，因此结果是模糊而有限的距离，但逐像素的开销非常低。适合在半透明表面（如玻璃和水）上使用。仅支持漫反射光照。 **表面前向着色（Surface Forward Shading）**：将为表面计算光照。适合在半透明表面（如玻璃和水）上使用。这是通过前向着色实现的，因此支持来自本地光源的镜面反射高光，但不支持许多纯延迟功能。这是 **开销最高** 的半透明光照法，因为每个光源的贡献都是逐像素计算。 参阅[光照半透明](../lit-translucency/index.md)，了解更多关于材质中半透明的用法。 |
| **定向光源强度（Directional Light Intensity）** | 用于人为加强法线对半透明光照效果的影响。大于1的值会加强法线的影响，而小于1的值会使光照更偏氛围化。 |
| **应用雾化（Apply Fogging）** | 启用此属性后，半透明材质将雾化。 |
| **逐像素计算雾（Compute Fog Per Pixel）** | 启用后，半透明材质将针对每个像素完成雾计算，虽然开销更高，但可修复因低曲面细分导致的瑕疵。 |
| **输出速度（Output Velocity）** | 启用后，半透明材质将在速度通道中输出运动向量。 |

### 高级半透明属性

![Advanced translucency properties](../../../../assets/images/1d/1d9882c60cda1b3d206bae437cbbba9efd3efc6d5e2161b42c7d5e699940840d.png)

| 属性 | 描述 |
| --- | --- |
| **响应式抗锯齿（Responsive AA (Ant aliasing)）** | 小型移动对象（尤其是粒子）有时会被抗锯齿所消除；将此属性设为 **true**，便会使用另一种AA算法，此算法提供了更多定义。换言之，如果你创建了一个暴风雪或类似的粒子系统，但觉得无法真正看到雪花，那就启用此属性，它会有所帮助。但是，此属性应仅用于小型移动对象，因为它会在背景上产生锯齿瑕疵。 |
| **半透明通道** | 表示材质应该在 **单独半透明通道** 中渲染（不受DOF的影响，并且需要在.ini文件中设置"AllowSeparateTranslucency"）。 |
| **移动单独半透明度（Mobile Separate Translucency）** | 此属性表明材质将在单独半透明通道（Separate Translucency Pass）中渲染（这意味着，它不会受到景深的影响，并且需要在.INI文件中设置 **bAllowSeparateTranslucency**）。 |
| **禁用深度测试（Disable Depth Test）** | 允许材质禁用深度测试，此属性只有在半透明混合模式下才有意义。禁用深度测试将使渲染明显变慢，因为被遮挡的像素无法进行Z剔除。 |
| **仅写入透明度（Write Only Alpha）** | 半透明通道是否将其透明度（且仅透明度）写入帧缓冲。 |
| **允许自定义深度写入（Allow Custom Depth Writes）** | 编译其他着色器，允许半透明材质与自定义深度写入配合使用。 |
| **允许前层半透明度（Allow Front Layer Translucency）** | 编译额外的着色器，以允许半透明材质与前层半透明度共用。适用于控制哪些内容应该包含在前层半透明度中。 |

## 半透明自投影

![Translucency self-shadowing properties](../../../../assets/images/08/08fc2b047e72eecedaa6f38a4ee24895afe0b8f616742cd9a965ed2c19f665e7.png)

半透明自身阴影是一种获得体积光照半透明对象（例如烟柱或蒸汽柱）的好方法。自投影分为两个主要部分：自身阴影密度（Self Shadow Density）和第二自身阴影密度（Second Self Shadow Density）。这两个部分的存在为变化提供了可能。你可以单独定义各个部分的密度，并使用它们之间的差异在整个自身阴影中获得你需要的模式。

| 属性 | 描述 |
| --- | --- |
| **阴影密度比例（Shadow Density Scale）** | 此属性设置了由该半透明材质投射到其他表面的阴影的密度。这有点像阴影的主比例；如果设为0，则没有任何阴影。当你将数值增加到1或更高时，投影和自身阴影都会变暗。 |
| **自身阴影密度比例（Self Shadow Density Scale）** | 设置该材质投射在自身上的阴影的密度。考虑烟雾柱中的阴影。 |
| **第二密度比例（Second Density Scale）** | 这是第二个自身阴影密度，可以设置变化。这个值和半透明自身阴影密度比例（Translucent Self Shadow Density Scale）之间形成了一个内部梯度。 |
| **第二不透明度（Second Opacity）** | 此属性设置了第二自身阴影的不透明度值，用于缩放自身阴影与第二自身阴影之间的梯度效应。 |
| **反向散射指数（Backscattering Exponent）** | 此属性控制使用次表面着色模型和半透明（Translucency）时使用的反向散射。较大的值会产生较小、较亮的反向散射高光。此值仅用于由定向光源形成的体积半透明阴影中。 |
| **多重散射消光（Translucent Multiple Scattering Extinction）** | 针对拥有体积半透明阴影的对象（如烟雾或蒸汽），此属性将给出一个彩色消光值（基本上相当于阴影颜色）。 |
| **初始偏移（Start Offset）** | 这是在半透明体中创建的自身阴影的世界空间偏移。数值越高，阴影离光源越远。 |

## 用途

> 图片已省略：Usage flags

用途（Usage）标记可控制材质应用对象的类型。这些设置允许引擎为每个应用程序编译特殊版本。这些仅在使用 **表面材质域（Surface Material Domain）** 设置时有效。

在编辑器中，将为地图中已经存在的所有对象自动设置这些标记。举例而言，如果你有一个粒子系统，它使用放置在某个关卡某处的材质；当你在编辑器中加载该地图时，它将自动设置 **结合粒子系统使用（Used with Particle System）** 标记。你需要保存材质资产，才能让游戏在特定网格体上使用该材质。

> [!WARNING]
> 如果没有设置适当的用途标志，游戏将使用默认的世界网格材质。游戏客户端日志中会对此给出相应的消息。

| 属性 | 描述 |
| --- | --- |
| **结合骨架网格体使用（Used with Skeletal Mesh）** | 如果材质将被放置在一个静态网格体上，则设置此属性。 |
| **结合编辑器复合使用（Used with Editor Compositing）** | 如果材质将用于编辑器UI，设置此属性。 |
| **结合粒子sprite使用（Used with Particle Sprites）** | 如果此材质将放置于粒子系统上，则使用此属性。 |
| **结合光束轨迹使用（Used with Beam Trails）** | 如果材质将结合光束轨迹使用，则设置此属性。 |
| **集合网格体粒子使用（Used with Mesh Particles）** | 说明该材质及其实例可以结合网格体粒子使用。这将导致支持网格体粒子所需的着色器被编译，从而增加着色器编译时间和内存使用量。 |
| **结合Niagara Sprite使用（Used with Niagara Sprites）** | 如果材质将结合Niagara Sprites使用，则设置此属性。 |
| **结合Niagara条带使用（Used with Niagara Ribbons）** | 如果材质将结合Niagara条带使用，则设置此属性。 |
| **结合Niagara网格体粒子使用（Used with Niagara Mesh Particles）** | 如果材质将结合Niagara网格体粒子使用，则设置此属性。 |
| **结合几何体缓存使用（Used with Geometry Cache）** | 如果材质将结合几何体缓存使用，则设置此属性。 |
| **结合变形目标使用（Used with Morph Targets）** | 如果该材质将应用于使用变形目标的骨架网格体，则设置此属性。 |
| **结合样条网格体使用（Used with Spline Meshes）** | 如果材质将应用于地形样条网格体，则设置此属性。 |
| **结合实例化样条网格体使用（Used with Instanced Static Meshes）** | 如果材质将应用于实例化静态网格体，则设置此属性。 |
| **结合几何体集合使用（Used with Geometry Collections）** | 如果材质将结合几何体集合使用，则设置此属性。 |
| **结合布料使用（Used with Clothing）** | 如果材质将应用于Apex物理模拟衣服，则设置此属性。 |
| **结合水使用（Used with Water）** | 与用于水网格体表面的材质结合使用。 |
| **结合发束使用（Used with Hair Strands）** | 与用于毛发梳理的材质结合使用。 |
| **结合LiDAR点云使用（Used with Lidar Point Cloud）** | 与用于LiDAR点云的材质结合使用。 |
| **结合地形使用（Used with Landscape）** | 如果材质将用于地形表面，设置此属性。 |
| **结合UI使用（Used with UI）** | 此属性表明该材质和任何材质实例都可与Slate UI和UMG配合使用。 |
| **在编辑器中自动设置用途（Automatically Set Usage in Editor）** | 是否根据在编辑器中应用材质的对象来自动设置用途标志。该属性的默认选项为启用。 |

## 移动平台

> 图片已省略：Mobile Material properties

| 属性 | 描述 |
| --- | --- |
| **全精度模式（Full Precision Mode）** | 强制此材质在像素着色器中使用全（highp）精度。它的处理速度比默认设置（mediump）慢，但可用于解决与精度相关的渲染错误。此设置对不支持高精度的旧版移动设备无效。 |
| **使用光照图方向性（Use Lightmap Directionality）** | 此属性将使用光照图方向性和逐像素法线。如果禁用此属性，光照图中的光照将是平面的，但开销更低。 |
| **移动高质量BRDF（Mobile High Quality BRDF）** | 在移动设备上使用高质量的brdf功能可以获得更好的视觉效果。这会增加GPU开销。 |

### 高级移动属性

| 属性 | 说明 |
| --- | --- |
| **使用Alpha来覆盖（Use Alpha to Coverage）** | 将Alpha用于在移动设备上对被遮盖的材质进行覆盖。必须启用多重取样抗锯齿（MSAA），才能发挥作用。 |

## 前向着色

> 图片已省略：Forward shading properties

| 属性 | 描述 |
| --- | --- |
| **简单IBL预整合（Preintegrated For Simple IBL）** | 前向（包括移动）渲染器使用简单IBL的预整合GF lut，但使用另一个采样器。 |
| **高质量反射（High Quality Reflections）** | 前向渲染器支持混合在一起、经过视差校正的多个反射采集。移动前向渲染器在最近的三次反射采集之间进行混合，但由于反射立方体贴图将使用+2采样器，因此减少了材质可用的采样器数量。 |
| **混合天空光照立方体贴图（Blend Sky Light Cubemaps）** | 启用天空光照立方体贴图纹理混合。启用后，只有当混合系数为1时，才能看到二级立方体贴图。 |
| **平面反射（Planar Reflections）** | 使用前向渲染器时启用平面反射、或在移动设备上启用。启用该设置会减少材质可用的采样器数量，因为平面反射将使用+1采样器。 |

## 后期处理材质

> 图片已省略：Post-process Material setttings

| 属性 | 描述 |
| --- | --- |
| **可混合位置（Blendable Location）** | 如果此材质用作后期处理材质，则可以通过此属性来控制材质在色调映射之前还是之后计算。如果你的材质将用于修改后期处理的颜色，那么此属性很重要。 |
| **输出透明度（Output Alpha）** | 如果启用，可混合对象将输出透明度。 |
| **可混合优先级（Blendable Priority）** | 当多个节点同时出现，该参数将决定它们的优先级，以及它们是否会合并。仅当材质域设置为 **后处理（PostProcess）** 时使用。 |
| **为可混合（Is Blendable）** | 允许关闭可混合性。仅当材质域（Material Domain）设为后期处理（Post Process）时才使用。 |
| 高级属性 |  |

### 高级后期处理材质属性

| 属性 | 说明 |
| --- | --- |
| **启用模具测试（Enable Stencil Test）** | 仅针对通过自定义深度/模具缓冲模具测试的像素选择性地执行材质后期处理。未通过模具测试的像素将填充之前的材质后期处理输出或场景颜色。 |
| **模具对比（Stencil Compare）** | 使用下拉菜单比较模具测试。 |
| **模具参考值（Stencil Ref Value）** | 设置模具参考值。 |

## 折射

> 图片已省略：Refraction properties

| 属性 | 描述 |
| --- | --- |
| **折射方法（Refraction Method）** | 此模式控制你材质将采用的折射类型。 **折射率（Index Of Refraction）**：根据进入介质的摄像机向量计算折射，该介质的折射率由Refraction材质输入定义。新介质的表面由材质的法线定义。在此模式下，从侧面看，平面将拥有恒定的折射偏移。这是折射物理模型，但会导致在场景颜色纹理外读取。因此不适用于对大折射表面（例如水面）。 **像素法线偏移（Pixel Normal Offset）**：基于逐像素法线与逐顶点法线之间的差异计算场景颜色的折射偏移。在此模式下，法线为默认值（0,0,1）的材质永远不会引起折射。此模式仅对切线空间法线有效。折射材质输入可缩放偏移量，值1.0映射为无折射，值2映射为偏移量缩放1.0。这是非物理折射模型，但适用于类似于水面的大型折射表面，因为偏移量必须保持很小，以免读取场景外的颜色。 ： **2D偏移（2D Offset）**：默认情况下，当根节点折射引脚断开时，将不会出现折射。显式2D屏幕偏移与屏幕分辨率和高宽比无关。用户负责任意强度和淡化。 |
| **折射偏差（Refraction Bias）** | 此属性弥补折射测试的深度。当折射值导致附近不需要的对象（通常在半透明对象前面）呈现到材质表面时，此属性十分实用。但较高的数值将开始分离折射，造成表面和折射对象之间出现可见的分裂。此属性在将某个表达式节点连接到Refraction输入之前不会启用。 |

## 世界位置偏移

| 属性 | 说明 |
| --- | --- |
| **最大世界位置偏移置换（Max World Position Offset Displacement）** | 指定材质的最大世界位置偏移。用此值来解决世界位置偏移造成的剔除和自遮挡问题，和限制允许的偏移量。例如，值被限制在每根轴上。请注意0值有效地代表"无最大值"，并且不会限制偏移。但是它也不会扩展剔除边界。 |

### 最大世界位置偏移置换的使用

有些时候，你想限制世界位置偏移在材质中允许的偏移量，以减少失真现象的发生，比如几何体被推到物体的边界之外太远，因为这会导致视觉失真和剔除问题。这些类型的问题在Nanite网格体中更为明显，因为它们被分割成更小的群集。这些群集中的每一个都有自己独立的界限，并在GPU上单独进行剔除。限制WPO是管理这个问题的好方法，并对Nanite和非Natie的几何体都有效。

使用 **最大世界位置偏移置换** 来限制材质的WPO的上限，以防止出现典型WPO失真。当设置为0时，材质相当于没有限制，这就是传统的做法。

> 图片已省略：Max World Position Offset Displacement setting

> [!TIP]
> 这个设置可以在材质实例中被覆盖。当一个参数的覆盖对WPO的规模有影响时，它便是有用的。你可以在 **材质属性覆盖** 部分中覆盖由父材质提供的最大世界位置偏移置换。

材质的最大世界位置偏移量大于零的网格体，会自动将网格的边界向外推开这个量。推进边界会强制执行上界，以防止网格体超过最大偏移量。网格体永远无法在其边界之外进行渲染，防止因 "弹出 "而产生的视觉失真。不过，在材质中限制WPO并非不会出现失真效果。统一设置的偏移量可能会在某些地方出现挤压或压平的情况（见下文）。另一个例子是，原本应该平稳或连续播放的WPO驱动动画，有时可能会停滞或卡顿。

下面的例子展示了一个施加了一定量WPO位移的网格体。两个网格都有相同的位移量，但右边的那个网格由其最大WPO置换量所限制。与其他部位相比，手部、膝盖和角部周围的区域有明显的限制。

> 图片已省略：WPO Amount: 7.5 | Max WPO Displacement: 0

> 图片已省略：WPO Amount: 7.5 | Max WPO Displacement: 3.5

WPO Amount: 7.5 | Max WPO Displacement: 0

WPO Amount: 7.5 | Max WPO Displacement: 3.5

在下面的例子中，WPO材质使用正弦波在顶点法线的方向上进行动画偏移。该材质的偏移量级为5.0。应用一个大于0且小于偏移量的最大世界位置偏移置换值，这演示了如何使用这个设置来限制偏移量。

你可以使用**越界像素（Out of Bounds Pixel）**显示标志来检查WPO正在被限制的对象。你可以在关卡视窗的 **显示（Show） >可视化（Visualize）** 菜单下找到它。

> 图片已省略：Out of Bounds Pixels Visualization

越界像素显示标志照亮了部分网格体，这是由于材质的世界位置偏移大小超过了其最大世界位置偏移位移而被限制的结果。

## Lightmass

> 图片已省略：Lightmass settings properties

| 属性 | 描述 |
| --- | --- |
| **漫反射增强（Diffuse Boost）** | 材质漫反射组件对静态光照影响量的乘数。 |
| **导出分辨率缩放（Export Resolution Scale）** | 导出该材质属性时的分辨率乘数。在需要详细信息时应增大此数值。 |
| **如被遮罩一样投射阴影（Cast Shadow as Masked）** | 如果置为 *true*，光照半透明对象将投射阴影，就好像它们在使用遮罩光照模式。这有助于在半透明对象上得到更清晰的阴影。 |

## 预览

> 图片已省略：Previewing properties

| 属性 | 描述 |
| --- | --- |
| **预览网格体（Preview Mesh）** | 设置用于在 **预览（Preview）** 窗格中预览材质的静态网格体。 |

## 导入设置

> 图片已省略：Import settings properties

| 属性 | 描述 |
| --- | --- |
| **资产导入数据（Asset Import Data）** | 结合此材质使用的一系列导入数据类型和选项。举例而言，选择 **Fbx纹理导入数据（Fbx Texture Import Data）** 可提供影响此导入类型的一套自有属性。 |

着色模型决定了材质输入（如自发光、漫反射、高光度、法线）如何组合以形成最终颜色。

- 无光照（Unlit）

  ：材质仅由自发光（Emissive）和不透明度（Opacity）输入定义。它不响应光照。
- 默认光照（Default Lit）

  ：默认着色模型。完美适用于大部分实心物体。
- 次表面（Subsurface）

  ：用于次表面散射材质，如蜡和冰。激活次表面颜色（Subsurface Color）输入。
- 预整合皮肤（Preintegrated Skin）

  ：用于类似于人类皮肤的材质。激活次表面颜色（Subsurface Color）输入。
- 透明涂层（Clear Coat）

  ：用于表面有半透明涂层的材质，如车漆或清漆。激活透明涂层（Clear Coat）和透明涂层粗糙度（Clear Coat Roughness）输入。
- 次表面轮廓（Subsurface Profile）

  ：用于类似于人类皮肤的材质。需要使用

  次表面轮廓

  才能正常使用。
- 双面植物（Two Sided Foliage）

  ：利用准确的光照和穿过表面（如树上的树叶）的光线透射来制作真实外观植物的材质。
- 毛发（Hair）

  ：用于制作逼真的头发材质，可以精确照亮发束并处理高光度。
- 布料（Cloth）

  ：用于制作逼真布料及其表面绒毛的材质。
- 眼睛（Eye）

  ：用于重新制作类人眼睛自然外观的材质。
- 单层水（Single Layer Water）

  ：允许你使用不透明混合模式实现透明水面效果。这能免去透明混合模式产生的额外材质开销。
- 薄半透明（Thin Translucent）

  ：用于基于物理原理制作玻璃的材质，例如有色玻璃或彩色玻璃。可以有效处理来自光源和有色背景对象的白色高光。
- From材质表达式（From Material Expression）

  ：用于在单一材质中处理多个着色模型。

欲知这些着色模型的更多信息，请参阅[着色模型文档](shading-models/index.md)。

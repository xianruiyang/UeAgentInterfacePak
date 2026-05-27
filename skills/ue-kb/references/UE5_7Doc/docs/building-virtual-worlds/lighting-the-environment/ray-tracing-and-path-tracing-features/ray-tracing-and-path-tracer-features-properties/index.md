---
title: "硬件光线追踪和路径追踪器功能属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-and-path-tracer-features-properties-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "硬件光线追踪和路径追踪功能", "硬件光线追踪和路径追踪器功能属性"]
---

# 硬件光线追踪和路径追踪器功能属性

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 硬件光线追踪和路径追踪功能 / 硬件光线追踪和路径追踪器功能属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ray-tracing-and-path-tracer-features-properties-in-unreal-engine

此页面包含[实时光线追踪](../hardware-ray-tracing/index.md)和[路径追踪器](../path-tracer/index.md)功能的属性和设置参考。

## 后期处理体积

光线追踪和路径追踪器的以下功能可在[后期处理体积](../../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)设置中找到。

| 属性 | 说明 |
| --- | --- |
| 全局光照 |  |
| **方法（Method）** | 选择要使用的全局光照方法："无（None）"、"Lumen"、"屏幕空间（Screen Space）"或"光线追踪（Ray Traced）"。 |
| 光线追踪全局光照 |  |
| **类型（Type）** | 设置要使用的"光线追踪全局光照"方法： **禁用（Disabled）：** 禁用RTGI方法。 **Brute Force：** 将更缓慢、更准确的Brute Force方法用于使用RTGI的动态间接光照。 **Final Gather：** 将更快速、更不准确的Final Gather方法用于使用RTGI的动态间接光照。 有关更多信息，请参阅[实时光线追踪](../hardware-ray-tracing/index.md)页面的"光线追踪的全局光照"分段。 |
| **最大反弹次数（Max Bounces）** | 设置将由RTGI使用的光线最大反弹次数。 |
| **每个像素的取样数（Samples Per Pixel）** | 为RTGI设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |
| 反射 |  |
| **方法（Method）** | 设置要使用的动态场景反射方法："无（None）"、"Lumen"、"屏幕空间（Screen Space）"或"光线追踪（Ray Traced）"。 |
| 光线追踪反射 |  |
| **最大粗糙度（Max Roughness）** | 设置"光线追踪的反射"将可见的最大粗糙度，超过该值之后，将回退到成本更低的光栅格方法。反射影响在接近粗糙度阈值时会平滑消退，并且此参数的行为类似于SSR的"最大粗糙度（Max Roughness）"设置。更低的值会更快回退到其他方法。 |
| **最大反弹次数（Max Bounces）** | 设置"光线追踪的反射"使用的最大反弹次数。更多反弹会造成相互反射，但成本更高。默认设置为1次反弹。 |
| **每个像素的取样数（Samples Per Pixel）** | 为"光线追踪的反射"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |
| **阴影（Shadows）** | 设置阴影应如何反射。从以下选项中选择： **硬阴影（Hard Shadows）** ，其中没有软阴影 **区域阴影（Area Shadows）** ，以使用软投影，如光线追踪的阴影 **禁用（Disable）** ，以在"光线追踪的反射"中禁用投影 |
| **包含半透明对象（Include Translucent Objects）** | 选中该复选框时，这将设置"光线追踪的反射"中是否将包含半透明材质。 |
| 光线追踪环境光遮蔽 |  |
| **已启用（Enabled）** | 选中该复选框时，将"启用光线追踪环境光遮蔽(RTAO)"。 |
| **每个像素的取样数（Samples Per Pixel）** | 为[光线追踪的环境光遮蔽](../../mesh-distance-fields/distance-field-ambient-occlusion/index.md)(RTAO)设置每个像素的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |
| **强度（Intensity）** | 定义多少环境光遮蔽会影响[光线追踪的环境光遮蔽](../../mesh-distance-fields/distance-field-ambient-occlusion/index.md)的非直接光照。更低的值会降低效果，而更高的值会提高效果的强度。 |
| **半径（Radius）** | 控制环境光遮蔽所影响的距离（以虚幻单位测量）。 |
| 半透明 |  |
| **类型（Type）** | 设置是将 **光线追踪（Ray Tracing）** 还是 **栅格（Raster）** 方法用于此体积中的反射。选择"栅格（Raster）"时，将使用默认半透明方法，而不是光线追踪的方法。 |
| 光线追踪半透明 |  |
| **最大粗糙度（Max Roughness）** | 设置"光线追踪的半透明"将可见的最大粗糙度，超过该值之后，将回退到成本更低的栅格方法。半透明影响在接近粗糙度阈值时会平滑消退，并且此参数的行为类似于SSR的"最大粗糙度（Max Roughness）"设置。更低的值会更快回退到其他方法。 |
| **最大折射光线次数（Max Refraction Rays）** | 设置"光线追踪的半透明"使用的最大折射光线次数。更多取样数会降低性能，而提高质量和准确性。默认设置为3次折射光线。 |
| **每个像素的取样数（Samples Per Pixel）** | 为"光线追踪的半透明"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |
| **阴影（Shadows）** | 设置阴影应如何反射。从以下选项中选择： **硬阴影（Hard Shadows）** ，其中没有软阴影 **区域阴影（Area Shadows）** ，以使用软投影，如光线追踪的阴影 **禁用（Disable）** ，以在"光线追踪的半透明"中禁用投影 |
| **折射（Refraction）** | 设置是否应该为"光线追踪的半透明"启用折射。如果禁用，光线不会散射，而仅会沿相交事件之前的相同方向前进。 |
| 路径追踪 |  |
| **最大反弹次数（Max. Bounces）** | 设置光线在被终止之前应该前进的最大可能反弹次数。 |
| **每个像素的取样数（Samples Per Pixel）** | 为收敛设置每个像素要使用的取样数。更高的取样数量会减少所渲染图像的噪点。 |
| **滤波器宽度（Filter Width）** | 设置抗锯齿所使用的滤波器宽度，以改进所渲染图像的质量。更低的宽度会产生更尖锐（或锯齿更突出）的结果。更大的值会软化（或模糊）锯齿结果。 |
| **自发光材质（Emissive Materials）** | 为自发光材质启用反射光照。启用此属性可防止对同时由实际光源表示的表面光照重复计数，并防止来自小型发射器的噪点。例如，让自发光材质表示一个小灯泡，同时使用点光源或聚光源来照亮该区域，在这种情况下就会重复计数。 |
| **最大路径曝光（Max Path Exposure）** | 设置路径追踪允许的最大曝光，以便减少[萤火虫伪影（firefly artifacts）](https://en.wikipedia.org/wiki/Fireflies_computer_graphics)的发生情况。将曝光调整为比场景曝光更高的值有助于缓解这些伪影。（请参阅此页面的[其他信息](#%E5%85%B6%E4%BB%96%E4%BF%A1%E6%81%AF)分段，了解此类型伪影的更多细节以及示例）。 |
| **降噪器（Denoiser）** | 此开关使用上一次取样中目前加载的降噪器插件来从渲染的输出中删除噪点。默认情况下，虚幻引擎使用Intel的"打开图像降噪器（Open Image Denoiser）"插件。如果未启用降噪器插件，此开关对渲染的输出不起作用。 |

## 光源类型

虚幻引擎包含不同[类型的光源](../../light-types-and-their-mobility/index.md)，它们有自己的设置，专门用于光线追踪和路径追踪。

### 定向光源

[定向光源](../../light-types-and-their-mobility/directional-lights/index.md)的以下属性会影响实时光线追踪和路径追踪。属性位于 **细节（Details）** 面板的 **光源（Light）** 和 **光线追踪（Ray Tracing）** 类别中。

| 属性 | 说明 |
| --- | --- |
| 光源 |  |
| **源角度（Source Angle）** | 光源对着的角度，以度数为单位（也称为角直径）。更低的角度会带来更尖锐的阴影接触，而更高度数的角度会带来更柔和的阴影。 |
| **投射光线追踪的阴影（Cast Ray Traced Shadow）** | 设置来自此光源的阴影是通过传统阴影贴图还是光线追踪的方式进行计算。选择 **使用项目设置（Use Project Setting）** 时，光源默认为光线追踪的阴影在"项目设置（Project Settings)"中的"引擎（Engine）> 渲染（Rendering）> 硬件光线追踪（Hardware Ray Tracing）"下使用属性 **光线追踪的阴影（Ray Traced Shadows）** 启用或禁用。 |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 启用"光线追踪的反射"时，光源是否会影响反射中的对象。 |
| **影响光线追踪全局光照（Affect Ray Tracing Global Illumination）** | 启用"光线追踪全局光照"时，光源是否会影响光线追踪的全局光照。 |
| 光线追踪 |  |
| **阴影源角度因子（Shadow Source Angle Factor）** | 将比例因子添加到相对于 **光源角度（Light Source Angle）** 所指定的阴影源角度。此属性要求启用 **投射光线追踪的阴影（Cast Ray Traced Shadow）**。 |
| **每个像素的取样数（Samples Per Pixel）** | 为"来自定向光源的光线追踪的阴影"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |

### 点光源和聚光源

[点光源](../../light-types-and-their-mobility/point-lights/index.md)和[聚光源](../../light-types-and-their-mobility/spot-lights/index.md)的以下属性会影响实时光线追踪和路径追踪。属性位于 **细节（Details）** 面板的 **光源（Light）** 和 **光线追踪（Ray Tracing）** 类别中。

| 属性 | 说明 |
| --- | --- |
| 光源 |  |
| **源半径（Source Radius）** | 光源形状的半径。更小的半径会带来更尖锐的阴影接触，而更高的半径会带来更柔和的阴影。 |
| **投射光线追踪的阴影（Cast Ray Traced Shadow）** | 设置来自此光源的阴影是通过传统阴影贴图还是光线追踪的方式进行计算。选择 **使用项目设置（Use Project Setting）** 时，光源默认为光线追踪的阴影在"项目设置（Project Settings)"中的"引擎（Engine）> 渲染（Rendering）> 硬件光线追踪（Hardware Ray Tracing）"下使用属性 **光线追踪的阴影（Ray Traced Shadows）** 启用或禁用。 |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 启用"光线追踪的反射"时，光源是否会影响反射中的对象。 |
| **影响光线追踪全局光照（Affect Ray Tracing Global Illumination）** | 启用"光线追踪全局光照"时，光源是否会影响光线追踪的全局光照。 |
| 光线追踪 |  |
| **每个像素的取样数（Samples Per Pixel）** | 为"来自点光源和聚光源的光线追踪的阴影"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |

### 矩形光源

[矩形光源](../../light-types-and-their-mobility/rectangular-area-lights/index.md)的以下属性会影响实时光线追踪和路径追踪。属性位于 **细节（Details）** 面板的 **光源（Light）** 和 **光线追踪（Ray Tracing）** 类别中。

| 属性 | 说明 |
| --- | --- |
| 光源 |  |
| **源宽度（Source Width）** | 光源形状的宽度。 |
| **源高度（Source Height）** | 光源形状的高度。 |
| **挡光板角度（Barn Door Angle）** | 矩形光源形状边缘的翼门角度。该角度控制光源的向前方向和展度。 |
| **挡光板长度（Barn Door Length）** | 矩形光源形状边缘的翼门长度。该长度控制光源边缘的锐度，类似于"源半径（Source Radius）"作用于点光源和聚光源的方式。 |
| **投射光线追踪的阴影（Cast Ray Traced Shadow）** | 设置来自此光源的阴影是通过传统阴影贴图还是光线追踪的方式进行计算。选择 **使用项目设置（Use Project Setting）** 时，光源默认为光线追踪的阴影在"项目设置（Project Settings)"中的"引擎（Engine）> 渲染（Rendering）> 硬件光线追踪（Hardware Ray Tracing）"下使用属性 **光线追踪的阴影（Ray Traced Shadows）** 启用或禁用。 |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 启用"光线追踪的反射"时，光源是否会影响反射中的对象。 |
| **影响光线追踪全局光照（Affect Ray Tracing Global Illumination）** | 启用"光线追踪全局光照"后，光源是否会影响光线追踪的全局光照。 |
| 光线追踪 |  |
| **每个像素的取样数（Samples Per Pixel）** | 为"来自矩形光源的光线追踪的阴影"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |

### 天空光照

[天空光照](../../light-types-and-their-mobility/sky-lights/index.md)的以下属性会影响实时光线追踪和路径追踪。属性位于 **细节（Details）** 面板的 **光源（Light）** 和 **光线追踪（Ray Tracing）** 类别中。

| 属性 | 说明 |
| --- | --- |
| 光源 |  |
| **投射光线追踪的阴影（Cast Ray Traced Shadow）** | 设置来自此光源的阴影是通过传统阴影贴图还是光线追踪的方式进行计算。选择 **使用项目设置（Use Project Setting）** 时，光源默认为光线追踪的阴影在"项目设置（Project Settings)"中的"引擎（Engine）> 渲染（Rendering）> 硬件光线追踪（Hardware Ray Tracing）"下使用属性 **光线追踪的阴影（Ray Traced Shadows）** 启用或禁用。 |
| **影响光线追踪反射（Affect Ray Tracing Reflections）** | 启用"光线追踪的反射"时，光源是否会影响反射中的对象。 |
| **影响光线追踪全局光照（Affect Ray Tracing Global Illumination）** | 启用"光线追踪全局光照"时，光源是否会影响光线追踪的全局光照。 |
| 光线追踪 |  |
| **每个像素的取样数（Samples Per Pixel）** | 为"来自天空光照的光线追踪的阴影"设置每个像素要使用的取样数。更多取样数会降低性能，而提高质量和准确性。默认设置为每个像素1个取样。 |

## Actor

放入的 **Actor** 的以下属性会影响实时光线追踪和路径追踪。属性位于 **细节（Details）** 面板的 **渲染（Rendering）** 和 **光线追踪（Ray Tracing）** 类别中。

| 属性 | 说明 |
| --- | --- |
| 渲染：高级 |  |
| **光线追踪中可见（Visible in Ray Tracing）** | 启用后，此组件将在光线追踪效果中可见。禁用后，它将从反射、半透明、阴影等光线追踪效果中删除。 |
| 光线追踪：高级 |  |
| **评估世界位置偏移（Evaluate World Position Offset）** | 启用后，将针对利用世界位置偏移的所有已分配材质光线追踪效果评估此Actor。 |
| **光线追踪远场（Ray Tracing Far Field）** | 如果为true，此组件可作为远场基元进行光线追踪，即使它是隐藏的也不例外。 |
| **光线追踪组ID（Ray Tracing Group Id）** | 定义组件的运行时组。例如，它允许在运行时组合建筑物的多个部分。设置为-1时，该组件不属于任何组。 |
| **光线追踪组剔除优先级（Ray Tracing Group Culling Priority）** | 定义应多快剔除此Actor。例如，建筑物和更大对象的优先级应较低，但更小对象的优先级应更高，这样它们会更快被剔除。 |

## 材质

[材质](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-editor-user-guide/index.md)的以下属性会影响实时光线追踪和路径追踪。属性位于材质编辑器的 **细节（Details）** 面板中。

| 属性 | 说明 |
| --- | --- |
| 材质 |  |
| **投射光线追踪的阴影（Cast Ray Traced Shadows）** | 设置此材质是否应该允许其分配的Actor在启用光线追踪功能时投射光线追踪的阴影。要求投射阴影的光源启用 **投射光线追踪的阴影（Cast Ray Traced Shadows）** 。 |

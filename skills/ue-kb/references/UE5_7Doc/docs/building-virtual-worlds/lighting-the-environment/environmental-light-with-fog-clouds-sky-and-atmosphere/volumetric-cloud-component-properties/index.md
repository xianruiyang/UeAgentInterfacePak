---
title: "体积云组件属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/volumetric-cloud-component-properties-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "雾、云、天空和大气的环境光源", "体积云组件属性"]
---

# 体积云组件属性

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 雾、云、天空和大气的环境光源 / 体积云组件属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/volumetric-cloud-component-properties-in-unreal-engine

本页面包括体积云、材质表达式和光源组件属性的参考信息。

## 体积云组件

在把 **体积云（Volumetric Cloud）** 组件加入关卡中后，该组件对应的 **细节（Details）** 面板会列出下列属性。你可以通过此组件的属性定义关卡中云的物理属性，比如与星球表面的距离、云体积高度、光线步进云的质量等。

![体积云组件属性](../../../../../assets/images/7c/7c90541c9d2647a3e96ba9ad637578c0224aa65ee37eca5c405ffecf5d3b77c5.png)

| 属性 | 说明 |
| --- | --- |
| 云层（Layer） |  |
| **云层底部高度（Layer Bottom）** | 云层底部的海拔高度，以距离地面的公里数（km）表示。 |
| **云层顶部高度（Layer Height）** | 云层顶部的海拔高度，以距离地面的公里数（km）表示。 |
| **追踪起始最大距离（Tracing Start Max Distance）** | 体积表面的最大距离，在此距离之前将接受开始追踪操作。单位为公里（km）。 |
| **追踪最大距离模式（Tracing Max Distance Mode）** | 从以下模式中选择一个，控制如何表示跟踪最大距离： **从视点开始的距离（Distance from Point of View）** **从云层进入点开始的距离（Distance from Cloud Layer Entry Point）** |
| **追踪最大距离（Tracing Max Distance）** | 云层内部可追踪的最大距离。单位为公里（km）。 |
| 星球（Planet） |  |
| **星球半径（Planet Radius）** | 当场景中不存在[天空大气](../sky-atmosphere-component/index.md)组件时，所使用的星球半径。 |
| **地面反射率（Ground Albedo）** | 在太阳光和天空大气（Sky Atmosphere）之外，用于从底部照亮云的地面反射颜色。此属性只用于云材质，并且只有在 **Volumetric Advanced Material Output** 节点的 **地面影响（Ground Contribution）** 属性启用时才可用。（参见本页面中的材质表达式（Material Expression）分段。） |
| 云材质（Cloud Material） |  |
| **材质（Material）** | 用于呈现云体积的指定材质。该材质必须使用 **体积（Volume）** 材质域。 |
| 云追踪（Cloud Tracing） |  |
| **使用逐采样大气光源透射（Use Per Sample Atmospheric Light Transmittance）** | 是否用逐采样大气透射代替光源全局透射。 |
| **天空光照云底部遮蔽（Sky Light Cloud Bottom Occlusion）** | 用于计算天空光照对云层底部影响的遮蔽量参数。此属性是对天空光照被云层遮蔽效果的快速近似，无需追踪光线或者对环境光遮蔽（AO）纹理进行采样。 |
| **视图采样数范围（View Sample Count Scale）** | 视图跟踪采样个数的范围。质量级别可延展性控制台变量会影响最大范围。根据 `r.VolumetricCloud.ViewRaySampleCountMax` 的可延展性设置，将对采样数分辨率进行限制。 |
| **反射采样数范围（Reflection Sample Count Scale）** | 反射跟踪采样数的范围。质量级别可延展性控制台变量会影响最大范围。根据 `r.VolumetricCloud.ReflectionRaySampleMaxCount` 的可延展性设置，将对采样数分辨率进行限制。 |
| **阴影视图采样数范围（Shadow View Sample Count Scale）** | 阴影视图跟踪采样数的范围。质量级别可延展性控制台变量会影响最大范围。根据 `r.VolumetricCloud.Shadow.ViewRaySampleMaxCount` 的可延展性设置，将对采样数分辨率进行限制。 |
| **阴影反射采样数范围（Shadow Reflection Sample Count Scale）** | 阴影反射视图跟踪采样数的范围。质量级别可延展性控制台变量会影响最大范围。根据 `r.VolumetricCloud.Shadow.ReflectionRaySampleMaxCount` 的可延展性设置，将对采样数分辨率进行限制。 |
| **阴影追踪距离（Shadow Tracing Distance）** | 阴影追踪距离，单位为公里（km）。 |
| **停止追踪透射阈值（Stop Tracing Transmittance Threshold）** | 当平均透射率低于此值时，将停止追踪。这可以有效减少光线行进采样数，从而提升性能。 |

## 材质表达式

可以添加以下材质表达式到材质图表中，以便定义体积云的属性。

### 体积高级材质输出表达式

**体积高级材质输出（Volumetric Advanced Material Output）** 表达式可以控制一系列云参数，当把体积材质添加到材质图表并应用于体积云组件后，这些参数可以影响体积材质。选中之后，该表达式可在材质编辑器的细节面板中显示额外的云属性（如下所示）。

![Volumetric Advanced Material Output Expression](../../../../../assets/images/27/273805ee49e7367a4bbba1f5915a0a399abea922bd31bbc86f8377cc398a670a.jpg)

| 属性 | 说明 |
| --- | --- |
| 相位（Phase） |  |
| **常量相位G（Phase G）** | 输入到相位函数的参数 **G** 描述周围有多少前向（g小于0）和后向（g大于0）光源散射。有效值范围为-1.0到1.0之间。未指定该值时，默认值为0。如果启用了 **逐采样相位求值（Per Sample Phase Evaluation）**，该值将会逐采样求值。 |
| **常量相位G2（Phase G2）** | 输入到第二个相位函数的参数 **G2** 描述周围有多少前向（g小于0）和后向（g大于0）光源散射。有效值范围为-1.0到1.0之间。未指定该值时，默认值为0。如果启用了 **逐采样相位求值（Per Sample Phase Evaluation）**，该值将会逐采样求值。 |
| **常量相位混合（Phase Blend）** | 混合由 **G** 和 **G2** 参数化的两个相位函数时所用的线性插值（lerp）因子。有效值范围为0.0到1.0之间。未指定该值时，默认值为0。如果启用了 **逐采样相位求值（Per Sample Phase Evaluation）**，该值将会逐采样求值。 |
| **多重散射贡献（Multi Scattering Contribution）** | 表示每个连续的倍频将对多重散射增加多少贡献值。该值逐像素求值，有效值范围为0.0到1.0之间，代表贡献率从低到高。如果该属性值未设置，默认值为0.5。 |
| **多重散射遮蔽（Multi Scattering Occlusion）** | 表示每个连续的倍频将减少多少遮蔽。该值逐像素求值，有效值范围为0.0到1.0之间，代表遮挡率从低到高。如果该属性值未设置，默认值为0.5。 |
| **多重散射离心率（Multi Scattering Eccentricity）** | 表示每个连续的倍频上多少相位将变为各向同性。该值逐像素求值，有效值范围为0.0到1.0之间，代表从各向异性到各向同性过渡。如果该属性值未设置，默认值为0.5。 |
| **守恒密度（Conservative Density）** | 表示三分量浮点向量（Vector3）。X分量必须表示参与介质守恒密度。如果该值大于0，表示该材质已求值，因此将直接对下一个采样求值。上述优化将跳过先前耗时的材质求值过程，用于加速光线步进。（Vector3）的Y和Z分量用于传递守恒密度相关的额外数据到材质求值步骤，从而避免再次计算。 例如，如果忽略材质空白区域的求值，一个简单的自上而下的2D密度纹理就已足够。Y和Z分量可以包含参数，这些参数在使用 **Volumetric Advanced Material Input** 节点计算材质的过程中可以重新获取。此属性值逐像素求值。 |

当被选中时，材质编辑器的 **细节（Details）** 面板将显示附加属性，这些属性可用于使用此材质的任何云材质。你可以直接设置没有被参数化的 **相位（Phase）** 和 **多重散射（Multi-Scattering）** 值。你可以控制用于模拟光源多重散射效果的倍频近似数，应用地面光的贡献值来照射云层底部等。

![Volumetric advanced material output node properties](../../../../../assets/images/86/86e0d4076f6f3bfc9d4825c0b8c38e7c1f61d15036d9e3417a5881d1febf5944.png)

| 属性 | 说明 |
| --- | --- |
| 相位（Phase） |  |
| **逐采样相位计算（Per Sample Phase Evaluation）** | 启用此选项来强制相位函数逐采样求值，而不是每像素求值一次（全局）。逐采样求值过程较慢。 |
| 多重散射（Multi-Scattering） |  |
| **多重散射近似倍频数（Multi Scattering Approximation Octave Count）** | 多少个倍频将用于多重散射近似。此属性将增加着色器开销，因此最好使用单个倍频。0代表只有单散射。 |
| 选项（Options） |  |
| **地面贡献（Ground Contribution）** | 采样从地面到介质的阴影光照贡献（单散射）。启动此选项将加大追踪成本。 |
| **灰阶材质（Gray Scale Material）** | 设置此材质为灰阶材质，在内部只使用输入参数的R信道。光照仍然被渲染为彩色。这是一个优化选项。 |
| **光线步进体积阴影（Ray March Volume Shadow）** | 禁用此选项将使用云阴影贴图而不是次级光线步进。禁用此选项通常足以满足从地面观察云的需求，同时将提升性能。禁用后，阴影将拥有无限长度，但同时也更不精确并呈现灰阶化。 |
| **限制多重散射贡献（Clamp Multi Scattering Contribution）** | 设置是否将多重散射贡献限制在[0,1]。禁用此项时，将由美术师确保视觉效果保持在合理的亮度范围内。 |

## 大气光照和天空光照

大气光照影响场景中体积云的渲染，其属性定义了光照性质，适用于静态和动态昼夜变换场景。

### 定向光源

体积云组件支持最多两个自上而下的光源[定向光源](../../light-types-and-their-mobility/directional-lights/index.md)，比如月亮和太阳，或者两个太阳。定向光源为云和不透明物体提供了光照和阴影。用户还可以为场景配置云阴影的强度、范围、分辨率。

![Directional Light Atmosphere and Cloud properties](../../../../../assets/images/cf/cfb25c80017a8d29bee32051e919ea7e17f5f3e88ac41f2978370f05edccf3c2.png)

| 属性 | 说明 |
| --- | --- |
| 大气与云（Atmosphere and Cloud） |  |
| **大气太阳光（Atmosphere Sun Light）** | 是否允许定向光源与大气和云交互，并生成可见的太阳圆盘，这些组件共同组成天空视觉效果。 |
| **在云上投射阴影（Cast Shadows on Clouds）** | 光源是否把不透明网格体的阴影投射到云上。对于任何次级定向光源，比如另一个太阳或者月亮光源，如果启用了 **大气太阳光源（Atmosphere Sun Light）** 并将 **大气太阳光源指数（Atmosphere Sun Light Index）** 设置为1，则将禁用此属性。 |
| **在大气上投射阴影（Cast Shadows on Atmosphere）** | 在使用天空大气时，光源是否把不透明网格体的阴影投射到大气中。 |
| **投射云阴影（Cast Cloud Shadows）** | 光源是否把云阴影投射到大气和其他场景元素上。 |
| **云散射亮度范围（Cloud Scattering Luminance Scale）** | 缩放光源在云中间介质中散射时的贡献值。因为当前多重散射的实现只是近似值，此属性能帮助抵消一些负面效果。 |
| 高级属性（Advanced Properties） |  |
| **逐像素大气透光（Per Pixel Atmosphere Transmittance）** | 是否在不透明网格体上应用逐像素大气透光，而不是使用光源的全局透光。 |
| **云阴影强度（Cloud Shadow Strength）** | 阴影强度。值越大，阻挡的光线越多。 |
| **大气强度上的云阴影（Cloud Shadow on Atmosphere Strength）** | 大气上的阴影强度。当设置为0时，禁用大气上的阴影。 |
| **表面强度上的云阴影（Cloud Shadow on Surface Strength）** | 不透明和半透明网格体上的阴影强度。当设置为0时，禁用不透明和半透明表面上的阴影。 |
| **云阴影深度偏差（Cloud Shadow Depth Bias）** | 控制应用到体积云阴影贴图的前阴影深度上的偏差值。 |
| **云阴影范围（Cloud Shadow Extent）** | 环绕摄像机的云阴影贴图的世界空间半径值。单位为公里（km）。 |
| **云阴影贴图分辨率范围（Cloud Shadow Map Resolution Scale）** | 缩放云阴影贴图分辨率。分辨率受 `r.VolumetricCloud.ShadowMap.MaxResolution` 限制。 |
| **云阴影光线采样数范围（Cloud Shadow Ray Sample Count Scale）** | 缩放用于阴影贴图追踪的采样个数。采样数分辨率受 `r.VolumetricCloud.ShadowMap.RaySampleMaxCount` 限制。 |

### 天空光照

[天空光照](../../light-types-and-their-mobility/sky-lights/index.md)组件提供柔和的环境光阴影支持，可通过以下属性启用和控制。

![Sky Light Atmosphere and Cloud properties](../../../../../assets/images/2a/2a4eca3c9ce51f30c987e3737c5d8e4a92963ec78563f3e0e7ce4a4d774ed834.png)

| 属性 | 说明 |
| --- | --- |
| 大气与云（Atmosphere and Cloud） |  |
| **云环境光遮蔽（Cloud Ambient Occlusion）** | 云是否应当遮蔽大气中的天空贡献（逐渐淡出多重散射）。 |
| **云环境光遮蔽强度（Cloud Ambient Occlusion Strength）** | 环境光遮蔽的强度。值越大，阻挡的光线越多。 |
| **云环境光遮蔽范围（Cloud Ambient Occlusion Extent）** | 环绕摄像机的云环境光遮蔽贴图的世界空间半径，单位为公里（km）。 |
| **云环境光遮蔽贴图分辨率缩放（Cloud Ambient Occlusion Map Resolution Scale）** | 缩放云环境光遮蔽贴图的分辨率。分辨率受 `r.VolumetricCloud.ShadowMap.MaxResolution` 限制。 |
| **云环境光遮蔽光圈缩放（Cloud Ambient Occlusion Aperture Scale）** | 计算体积云时，控制天空遮蔽的椎体张角。值为1时，将整个半球纳入计算，结果是模糊遮蔽。值为0时，只计算某个（垂直）方向上的遮蔽，结果是锐利遮蔽。 |

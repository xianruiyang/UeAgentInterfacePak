---
title: "使用Substrate GBuffer格式进行编程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/programming-with-substrate-gbuffer-formats"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "Substrate材质", "使用Substrate GBuffer格式进行编程"]
---

# 使用Substrate GBuffer格式进行编程

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / Substrate材质 / 使用Substrate GBuffer格式进行编程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/programming-with-substrate-gbuffer-formats

Substrate对材质数据的收集、处理、存储和用于光照的方式进行了更改。 本页面简要概述了该系统对于程序员的工作原理。

从创作的角度来看，材质可以继续使用现有根节点的输入，或使用[Substrate材质节点](../overview-of-substrate-materials/index.md#substrate-material-nodes)（Slab、运算符）并将其插入根节点的**Front Material**输入。 在材质着色器中，前一种情况按`TEMPLATE_USES_SUBSTRATE==0`转换，后一种情况按`TEMPLATE_USES_SUBSTRATE==1`转换。

使用延迟光照时，材质数据会被保存到一个名为**GBuffer**的中间存储。 Substrate有两种GBuffer存储模式：

- **可混合GBuffer：**这类似于现有的GBuffer存储格式。
- **自适应GBuffer：**此存储更改为数据的比特流，其格式因像素而异。

此GBuffer格式在项目设置中配置，取决于预期目标平台是否支持自适应GBuffer。

> [!NOTE]
> 有关GBuffer及其与Substrate用法的更多信息，请参阅[Substrate材质概述](../overview-of-substrate-materials/index.md)的“GBuffer”分段。

## 场景纹理数据

继续使用`SceneTextureLookup()`查询场景纹理数据，以获取**可混合GBuffer**和**自适应GBuffer**格式。 使用自适应GBuffer时，此函数将仅返回第一个闭合数据。

## 全局着色器

当需要在延迟渲染中（例如为了光照目的）访问全局着色器中的数据时，你需要像这样声明和绑定Substrate全局参数：

C++

声明

```
class FMyGlobasShaderCS : public FGlobalShader
{
  DECLARE_SHADER_TYPE(FMyGlobasShaderCS, Global)
  SHADER_USE_PARAMETER_STRUCT(FMyGlobasShaderCS, FGlobalShader);
  using FPermutationDomain = TShaderPermutationDomain<>;
  BEGIN_SHADER_PARAMETER_STRUCT(FParameters, )
   ...
   SHADER_PARAMETER_RDG_UNIFORM_BUFFER(FSubstrateGlobalUniformParameters, Substrate)
   ...
  END_SHADER_PARAMETER_STRUCT()
```

C++

着色器参数绑定

```
FMyGlobasShaderCS::FParameters PassParameters;PassParameters.Substrate = Substrate::BindSubstrateGlobalUniformParameters(View);
```

在着色器中，需要处理可混合（Blendable）和自适应GBuffer（Adaptive GBuffer）格式。

> [!NOTE]
> 计划在未来的版本中提供更好的抽象功能，以方便维护。

C++

```
#if SUBSTRATE_LOAD_FROM_MATERIALCONTAINER
// For Adaptive GBuffer
FSubstrateAddressing Addressing = GetSubstratePixelDataByteOffset(PixelPos, uint2(View.BufferSizeAndInvSize.xy), Substrate.MaxBytesPerPixel);
FSubstratePixelHeader Header = UnpackSubstrateHeaderIn(Substrate.MaterialTextureArray, Addressing, Substrate.TopLayerTexture);
#else
// For Blendable GBuffer
FSubstrateGBufferBSDF Data = SubstrateReadGBufferBSDF(GetScreenSpaceDataUint(PixelPos));
#endif
```

## 材质着色器

在材质着色器中，如果材质插入了**Front Material**输入，则将定义`TEMPLATE_USES_SUBSTRATE==1`，并且可以像这样处理和检索闭合数据：

C++

```
// Initialise a Substrate header with normal in registers
FSubstrateData SubstrateData = PixelMaterialInputs.GetFrontSubstrateData();
FSubstratePixelHeader Header = MaterialParameters.GetFrontSubstrateHeader();
Header.IrradianceAO.MaterialAO = GetMaterialAmbientOcclusion(PixelMaterialInputs);

if (Header.SubstrateTree.BSDFCount > 0)
{
   FSubstrateIntegrationSettings Settings = InitSubstrateIntegrationSettings(false, true, 0, false);
   float3 TotalTransmittancePreCoverage = 0;
   Header.SubstrateUpdateTree(SubstrateData, V, Settings, TotalCoverage, TotalTransmittancePreCoverage);
```

对于不使用Substrate节点的材质，例如旧版根节点输入，将定义TEMPLATE_USES_SUBSTRATE==0，并且可以照常检索数据，如下所示：

C++

```
float3 BaseColor = GetMaterialBaseColor(PixelMaterialInputs);float Metallic = GetMaterialMetallic(PixelMaterialInputs);...
```

## 材质属性

检索到BSDFContext后（请参阅上面的代码），你可以像这样访问闭合数据：

C++

```
SLAB_DIFFUSEALBEDO(BSDFContext.BSDF)SLAB_F0(BSDFContext.BSDF);SLAB_ROUGHNESS(BSDFContext.BSDF)
```

## 光照求值

要对具有**延迟光照**的特定光源求值，可以使用位于`Substrate\SubstrateDeferredLighting.ush`中的以下函数：

C++

```
FSubstrateDeferredLighting SubstrateDeferredLighting(...)
```

为了评估**前向渲染**中的整个光照，可以使用位于`Substrate\SubstrateForwardLighting.ush`中的以下函数：

C++

```
float3 SubstrateForwardLighting(...)
```

此外，在`Substrate/SubstrateEvaluation.ush`中还有两个有用的函数，分别用于求值分析光源和环境光照：

C++

```
// Analytical lightingFSubstrateEvaluateResult SubstrateEvaluateBSDFCommon(...); // Environment lightingFSubstrateEnvLightResult SubstrateEvaluateForEnvLight(...);
```

## 着色器文件

以下是常用的着色器文件列表：

> [!NOTE]
> 当前的着色器API可能会在未来的版本中发生变化。

| 着色器文件 | 说明 |
| --- | --- |
| `Substrate/Substrate.ush` | 包含Substrate的核心数据结构体、数据访问器以及自适应GBuffer的数据读取。 |
| `Substrate/SubstrateRead.ush` | 包含可混合GBuffer数据的读取/解包逻辑。 |
| `Substrate/SubstrateEvaluation.ush` | 包含用于分析光源和环境光源的主着色求值逻辑。 |
| `Substrate/SubstrateDeferredLighting.ush` | 包含延迟光照路径的着色评估。 |
| `Substrate/SubstrateForwardLighting.ush` | 包含前向光照路径的着色求值。 |

## 其他资源

- Substrate技术演示：[Siggraph 2023 - 虚幻引擎Substrate：创作重要材质](https://advances.realtimerendering.com/s2023/2023%20Siggraph%20-%20Substrate.pdf)
- Substrate创作演示：Unreal Fest 2025斯德哥尔摩 - 你想知道的关于Substrate的一切

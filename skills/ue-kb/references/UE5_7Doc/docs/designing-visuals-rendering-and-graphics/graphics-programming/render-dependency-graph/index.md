---
title: "渲染依赖图"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/render-dependency-graph-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "图形编程", "渲染依赖图"]
---

# 渲染依赖图

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 图形编程 / 渲染依赖图

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/render-dependency-graph-in-unreal-engine

**渲染依赖图（Render Dependency Graph）**，也称为渲染图或 **RDG**，是一种即时模式应用程序编程接口（API），它将要编译和执行的渲染命令记录到图数据结构中。RDG通过自动化易出错的操作来简化高级渲染代码，并遍历依赖图以优化内存使用并在CPU和GPU上并行渲染通道。

渲染依赖图包括以下功能：

- 安排异步计算栅栏的执行
- 以最佳生命周期和内存别名分配临时资源
- 使用拆分屏障转换子资源，在GPU上隐藏延迟并改善重叠
- 命令列表并行记录
- 剔除图中未使用的资源和通道
- 验证API的使用和资源依赖关系
- 在RDG Insights中实现图结构和内存生命周期的可视化

> [!NOTE]
> 渲染依赖图API已针对延迟渲染器和移动渲染器以及相关插件进行了转换。所有高级渲染代码都应使用RDG编写，尤其在需要上述任何高级功能时更是如此。

## RDG编程指南

本指南针对使用C++编写低级渲染功能并对着色器和渲染硬件接口（RHI）有所的人员，在解释基本概念的同时，通过示例演示API的使用。

### 着色器参数结构体

RDG通过对着色器参数结构体系统的扩展来表达图依赖关系。

> [!NOTE]
> 考虑在HLSL源文件中声明的以下着色器参数。

**HLSL源文件中的着色器输入：**

```
	float2 ViewportSize;	float4 Hello;	float World;	float3 FooBarArray[16]; 	Texture2D BlueNoiseTexture;	SamplerState BlueNoiseSampler; 	Texture2D SceneColorTexture;	SamplerState SceneColorSampler; 	RWTexture2D<float4> SceneColorOutput;
```

这些着色器参数也可以由扁平化的C++数据结构表示。

**理想的C++ 等价：**

```
	struct FMyShaderParameters	{		FVector2D ViewportSize;		FVector4 Hello;		float World;		FVector FooBarArray[16]; 		FRHITexture*    	BlueNoiseTexture = nullptr;		FRHISamplerState*   BlueNoiseSampler = nullptr; 		FRHITexture*    	SceneColorTexture = nullptr;		FRHISamplerState*   SceneColorSampler = nullptr; 		FRHIUnorderedAccessView* SceneColorOutput = nullptr;	};
```

着色器参数结构体系统使用一组声明宏来实现这一点。

**着色器参数结构体：**

```
	BEGIN_SHADER_PARAMETER_STRUCT(FMyShaderParameters, /** MODULE_API_TAG */)		SHADER_PARAMETER(FVector2D, ViewportSize)		SHADER_PARAMETER(FVector4, Hello)		SHADER_PARAMETER(float, World)		SHADER_PARAMETER_ARRAY(FVector, FooBarArray, [16]) 		SHADER_PARAMETER_TEXTURE(Texture2D, BlueNoiseTexture)		SHADER_PARAMETER_SAMPLER(SamplerState, BlueNoiseSampler) 		SHADER_PARAMETER_TEXTURE(Texture2D, SceneColorTexture)		SHADER_PARAMETER_SAMPLER(SamplerState, SceneColorSampler) 		SHADER_PARAMETER_UAV(RWTexture2D, SceneColorOutput)	END_SHADER_PARAMETER_STRUCT()
```

这些宏生成等效的扁平化C++数据结构以及编译时反射元数据，可作为结构体的静态成员访问。

**编译时反射元数据：**

```
	const FShaderParametersMetadata* ParameterMetadata = FMyShaderParameters::FTypeInfo::GetStructMetadata();
```

此元数据支持结构体的运行时遍历，这是将参数动态绑定到RHI所必需的。每个成员的可用信息包括 **名称**、**C++类型**、**HLSL类型** 和 **字节偏移量**。

> [!TIP]
> 有关更多信息，请参阅 `FShaderParametersMetadata::FMember`。RDG依赖此元数据来遍历 **通道参数**（本页面后面有述）。

#### 着色器绑定

着色器参数结构体与 `FShader` 成对提供，以生成提交到RHI命令列表所需的绑定。

你可以通过在 `FShader` 派生类中将参数结构体声明为 `FParameters` 类型来实现。

它可以作为内联定义或通过using / typedef指令实现。然后，使用 `SHADER_USE_PARAMETER_STRUCT` 宏为将注册绑定的类生成一个构造函数。

**第一个着色器类：**

```
	class FMyShaderCS : public FGlobalShader	{		DECLARE_GLOBAL_SHADER(FMyShaderCS); 		// 生成一个构造函数，该构造函数将使用此FShader实例注册FParameter绑定。		SHADER_USE_PARAMETER_STRUCT(FMyShaderCS, FGlobalShader); 		// 将FParameters类型分配给着色器——使用内联定义或using指令。		using FParameters = FMyShaderParameters;	};
```

将着色器参数绑定到RHI命令列表是通过实例化结构体、填充数据并调用 `SetShaderParameters` 辅助函数来完成的。

**参数赋值：**

```
	TShaderMapRef<FMyShaderCS> ComputeShader(View.ShaderMap);	RHICmdList.SetComputeShader(ComputeShader.GetComputeShader()); 	FMyShaderCS::FParameters ShaderParameters; 	// 参数赋值。	ShaderParameters.ViewportSize = View.ViewRect.Size();	ShaderParameters.World = 1.0f;	ShaderParameters.FooBarArray[4] = FVector(1.0f, 0.5f, 0.5f); 	// 参数提交。	SetShaderParameters(RHICmdList, ComputeShader, ComputeShader.GetComputeShader(), Parameters); 	RHICmdList.DispatchComputeShader(GroupCount.X, GroupCount.Y, GroupCount.Z);
```

### 统一缓冲区

**统一缓冲区（Uniform Buffer）** 将着色器参数作为一组RHI资源，本身将作为着色器参数绑定。每个统一缓冲区都在HLSL中定义了一个全局命名空间。使用 `BEGIN_UNIFORM_BUFFER_STRUCT` 和 `END_UNIFORM_BUFFER_STRUCT` 宏声明统一缓冲区。

**定义统一缓冲区：**

```
	BEGIN_UNIFORM_BUFFER_STRUCT(FSceneTextureUniformParameters, RENDERER_API)		SHADER_PARAMETER_TEXTURE(Texture2D, SceneColorTexture)		SHADER_PARAMETER_SAMPLER(SamplerState, SceneColorTextureSampler)		SHADER_PARAMETER_TEXTURE(Texture2D, SceneDepthTexture)		SHADER_PARAMETER_SAMPLER(SamplerState, SceneDepthTextureSampler) 		// ...	END_UNIFORM_BUFFER_STRUCT() 
```

在C++源文件中使用 `IMPLEMENT_UNIFORM_BUFFER_STRUCT` 向着色器系统注册统一缓冲区定义并生成其HLSL定义。

**实现统一缓冲区：**

```
	IMPLEMENT_UNIFORM_BUFFER_STRUCT(FSceneTextureUniformParameters, "SceneTexturesStruct") 
```

统一缓冲区参数由着色器自动生成，使用 `UniformBuffer.Member` 语法编译和访问。

**HLSL中的统一缓冲区：**

```
	// 包含统一缓冲区声明的生成文件。由Common.ush自动包含。	#include "/Engine/Generated/GeneratedUniformBuffers.ush" 	// 引用统一缓冲区成员（类似于结构体）。	Texture2DSample(SceneTexturesStruct.SceneColorTexture, SceneTexturesStruct.SceneColorTextureSampler); 
```

现在，`SHADER_PARAMTER_STRUCT_REF` 宏可用于将统一缓冲区作为参数包含在父着色器参数结构体中。

**SHADER_PARAMETER_STRUCT_REF:**

```
	BEGIN_SHADER_PARAMETER_STRUCT(FParameters, )		// ... 		// 定义一个引用计数的TUniformBufferRef<FSceneTextureUniformParameters>实例。		SHADER_PARAMETER_STRUCT_REF(FSceneTextureUniformParameters, SceneTextures)	END_SHADER_PARAMETER_STRUCT()
```

#### 静态绑定

每个着色器的着色器参数都是唯一绑定的，每个着色器阶段（例如，顶点和像素）都需要自己的着色器。使用 `Set{Graphics, Compute}PipelineState` ，在RHI命令列表中将着色器作为管线状态对象（Pipeline State Object）（PSO）绑定在一起。

> [!WARNING]
> 在命令列表绑定一个管线状态 **会使所有着色器绑定** 无效。

设置PSO后，需要绑定所有着色器参数。例如，考虑让一组典型绘制调用的命令流共享PSO。

- 设置PSO A
- 对于每个绘制调用

  - 设置顶点着色器参数
  - 设置像素着色器参数
  - 绘制
- 设置PSO B
- 对于每个绘制调用

  - 设置顶点着色器参数
  - 设置像素着色器参数
  - 绘制

这种方法的一个问题是渲染器中的网格绘制命令会被缓存并在多个通道和视图之间共享。为每帧的每个通道/视图组合生成一组独特的绘制命令是非常低效的。但是，网格绘制命令还需要知道通道/视图统一缓冲区资源，以便正确绑定它们。为了解决此问题，统一缓冲区使用了一个 **静态** 绑定模型。

使用静态绑定声明时，统一缓冲区直接绑定到RHI命令列表的 **静态插槽**，而不是为每个单独的着色器提供的 **唯一插槽**。当着色器请求统一缓冲区时，命令列表直接从静态插槽中提取绑定。现在，绑定以 **通道** 频率发生，而非 **PSO** 频率。

采用与上面相同的示例，但着色器输入来自静态统一缓冲区：

- 设置静态统一缓冲区
- 设置PSO A
- 对于每个绘制调用

  - 绘制
- 设置PSO B
- 对于每个绘制调用

  - 绘制

此模型允许每个绘制调用从命令列表继承着色器绑定。

##### 定义静态统一缓冲区

要使用静态绑定来定义统一缓冲区，请使用 `IMPLEMENT_STATIC_UNIFORM_BUFFER_STRUCT` 宏。需要额外的插槽声明。它由 `IMPLEMENT_STATIC_UNIFORM_BUFFER_SLOT` 宏指定。

> [!TIP]
> 多个静态统一缓冲区定义可以引用同一个静态插槽，但一次只能绑定其中一个。最好尽可能重用插槽，以减少引擎中插槽的总数。

**静态统一缓冲区：**

```
	// 按名称定义一个唯一的静态插槽。	IMPLEMENT_STATIC_UNIFORM_BUFFER_SLOT(SceneTextures); 	// 使用SceneTextures插槽的静态绑定定义SceneTexturesStruct统一缓冲区。	IMPLEMENT_STATIC_UNIFORM_BUFFER_STRUCT(FSceneTextureUniformParameters, "SceneTexturesStruct", SceneTextures); 	// 定义具有相同静态插槽的MobileSceneTextures统一缓冲区。一次只能绑定一个。	IMPLEMENT_STATIC_UNIFORM_BUFFER_STRUCT(FMobileSceneTextureUniformParameters, "MobileSceneTextures", SceneTextures);
```

> [!NOTE]
> 使用 `RHICmdList.SetStaticUniformBuffers` 方法绑定静态统一缓冲区。**RDG在执行每个通道之前自动将静态统一缓冲区绑定到命令列表**。任何静态统一缓冲区都应包含在通道参数结构体中。

### 渲染图生成器

渲染图生成器（Render Graph Builder）的设计考虑了易用性。(@@@)

- 实例化一个

  FRDGBuilder

  实例，创建资源并添加通道以设置该图。然后，调用

  FRDGBuilder::Execute

  编译并执行该图。
- 使用

  FRDGBuilder::CreateTexture

  创建纹理或使用

  FRDGBuilder::CreateBuffer

  创建缓冲区。

  - 这些方法只分配描述符。底层RHI资源之后将在执行期间分配。
- 使用

  FRDGBuilder::AddPass

  函数添加通道，指定通道参数结构体和执行Lambda作为参数。

  - 通道参数结构体使用包含RDG资源的参数扩展着色器参数结构体。

    - RDG使用这些参数来推导出图中的通道和临时资源的生命周期之间的依赖关系。
    - 使用

      GraphBuilder::AllocParameters

      分配通道参数，并分配执行Lambda中使用的所有相关RDG资源。
  - 通道执行Lambda记录在图的执行期间提交到RHI命令列表的工作。

    - 使用

      FRHIComputeCommandList

      进行计算通道（异步和图计算之间的共享接口），或用于

      FRHICommandList

      的栅格通道。
    - 除非绝对必要，否则避免使用

      FRHICommandListImmediate

      ，因为它会使通道无法并行执行。
    - 理想情况下，所有通道Lambda都是线程安全的，但实际上一些通道仍然需要在执行期间创建或锁定RHI资源，这必须在渲染线程上完成。对于这些情况，请使用即时命令列表。

下面的示例代码片段是一个起始示例。

**图生成器：**

```
	{		FRDGBuilder GraphBuilder(RHICmdList); 		FMyShaderCS::FParameters* PassParameters = GraphBuilder.AllocParameters<FMyShaderCS::FParameters>();		//...		PassParameters->SceneColorTexture = SceneColor;		PassParameters->SceneColorSampler = TStaticSamplerState<SF_Point, AM_Clamp, AM_Clamp>::GetRHI();		PassParameters->SceneColorOutput = GraphBuilder.CreateUAV(NewSceneColor); 		GraphBuilder.AddPass(			// 使用printf语义，用于分析器的通道友好名称。			RDG_EVENT_NAME("MyShader %d%d", View.ViewRect.Width(), View.ViewRect.Height()),			// 提供给RDG的参数。			PassParameters,			// 发出计算命令。			ERDGPassFlags::Compute,			// 推迟到执行。可以与其他通道并行执行。			[PassParameters, ComputeShader, GroupCount] (FRHIComputeCommandList& RHICmdList)		{			FComputeShaderUtils::Dispatch(RHICmdList, ComputeShader, PassParameters, GroupCount);		}); 		// 执行图。		GraphBuilder.Execute();	} 
```

图构建器API是单线程的，一次只能实例化一个实例，不含层级图或并列图。对每个场景渲染调用，延迟渲染器和移动渲染器都使用单个构建器实例。

#### 设置和执行时间轴

RDG将渲染管线分成两个时间轴：**设置** 和 **执行**。

该图是在设置时间轴期间构建的。这是完成资源创建和渲染管线配置分支的位置。所有RHI命令都被推迟到通道Lambda，在执行时间轴上调用。

通道Lambda中指定的代码应该没有副作用，并且只需将命令记录到命令列表中，这是因为通道可能会并行执行。

![Setup and execute timelines with and without RDG.](../../../../assets/images/c2/c20de34f8fccbc1d78256aa9fe028600190d98d90c095bc116cfe192c298a7f4.jpg)

上图描述了有/无RDG的渲染管线时间轴。

在没有RDG的图表中，渲染功能编写在一个时间轴上，并直接进行设置和执行。根据管线分支和资源分配直接记录和提交RHI命令。

使用RGD，设置代码通过用户提供的通道执行Lambda与执行分离。RDG在调用通道执行Lambda之前执行一个额外的编译步骤，然后将跨多个线程执行，调用这些Lambda以将渲染命令记录到RHI命令列表中。

### RDG辅助函数

渲染依赖图包含几个有用的辅助函数，用于添加常用通道，位于 `RenderGraphUtils.h`。应尽可能使用这些辅助函数来减少整个引擎的样板代码。

例如，将 `FComputeShaderUtils::AddPass` 用于计算着色器通道，而将 `FPixelShaderUtils::AddFullscreenPass` 用于全屏像素着色器通道。

> [!NOTE]
> 以下示例出于教学目的详细编写。**尽可能使用辅助函数。**

### RDG资源和视图

RDG资源最初包含RHI资源描述符。关联的RHI资源只能在通道的执行Lambda中访问，该通道将资源声明为通道参数。所有RDG资源为特定子类类型提供 `FRDGResource::GetRHI` 重载。对该方法的访问仅限于通道Lambda，如果该方法调用不正确，验证层将断言。

以下属性特定于 **缓冲区** 和 **纹理** 资源：

- 一个资源可以是

  临时

  的，因此它的生命周期被限制在图上，并且可以与其他生命周期不相交的临时资源以别名方式共用内存。
- 或者，资源可以是

  外部

  的，其生命周期将延伸至图外。如果用户将现有RHI资源注册到图中，或者在执行完成后从图中提取资源，则会发生这种情况。

RDG缓冲区和纹理可通过RDG非顺序访问或着色器资源视图进行特殊处理。与其他RDG资源类似，底层RHI资源在执行期间将按需分配，仅允许声明为参数的通道进行访问。 下面的代码示例演示了如何创建纹理、缓冲区和视图资源。

**资源创建示例：**

```
	// 创建一个新的临时纹理实例。此时未分配GPU内存，仅分配了描述符。	FRDGTexture* Texture = GraphBuilder.CreateTexture(FRDGTextureDesc::Create2D(...), TEXT("MyTexture")); 	// 无效！将触发断言。如果在通道上声明，则仅允许在通道Lambda中使用！	FRHITexture* TextureRHI = Texture->GetRHI(); 	// 创建一个新的UAV，引用特定mip级别的纹理。	FRDGTextureUAV* TextureUAV = GraphBuilder.CreateUAV(FRDGTextureUAVDesc(Texture, MipLevel)); 	// 无效！	FRHIUnorderedAccessView* UAVRHI = TextureUAV->GetRHI(); 	// 创建一个新的临时结构化缓冲区实例。	FRDGBuffer* Buffer = GraphBuilder.CreateBuffer(FRDGBufferDesc::CreateBufferDesc(...), TEXT("MyBuffer")); 	// 无效！	FRHIBuffer* BufferRHI= Buffer->GetRHI(); 	// 创建一个新的SRV，引用具有R32浮点格式的缓冲区。	FRDGBufferSRV* BufferSRV = GraphBuilder.CreateSRV(Buffer, PF_R32_FLOAT); 	// 无效！	FRHIShaderResourceView* SRVRHI = TextureSRV->GetRHI(); 
```

> [!WARNING]
> RDG资源指针有图生成器所有。它们在销毁后失效。**图在执行后的任何指针都应该为null。**

### 通道和参数

通道参数是使用 `FRDGBuilder::AllocParameters` 函数分配的，可保证正确的内存生命周期。RDG使用自己的宏扩展了着色器参数结构体系统。`FRDGBuilder:AddPass` 接受自定义RDG宏，同时忽略着色器参数宏。

通道参数与着色器参数的耦合是有意这样做。虚幻引擎中的大多数通道参数也是着色器参数。二者使用相同的API进行声明可减少样板代码。

以下具体示例很好地说明了如何使用通道和参数。

#### 着色器参数示例

这个着色器参数示例声明了一个简单的假定的计算着色器，并将一些着色器参数绑定到它，并不涉及任何RDG。

这样建立了一个基线，有助于演示RDG如何作为着色器参数结构体系统的扩展。

> [!NOTE]
> 阅读注释代码以了解此示例中的全部内容。

**HLSL代码示例：**

```
	Texture2D MyTexture;	Texture2D MySRV;	RWTexture2D MyUAV;	float MyFloat; 
```

**C++代码示例：**

```
	class FMyComputeShader: public FGlobalShader	{	public:		DECLARE_GLOBAL_SHADER(FMyComputeShader); 		// 为FParameters生成着色器绑定。		SHADER_USE_PARAMETER_STRUCT(FMyComputeShader, FGlobalShader); 		// 内联着色器参数定义。按照约定使用FParameters名称。		BEGIN_SHADER_PARAMETER_STRUCT(FParameters, /** MODULE_API */) 			// 映射到HLSL代码中的 'MyTexture' 的FRHITexture*。			SHADER_PARAMETER_TEXTURE(Texture2D, MyTexture) 			// 映射到HLSL代码中的 'MySRV' 的FRHIShaderResourceView*。			SHADER_PARAMETER_SRV(Texture2D, MySRV) 			// 映射到HLSL代码中的 'MyUAV' 的FRHIUnorderedAccessView*。			SHADER_PARAMETER_UAV(RWTexture2D, MyUAV) 			// 浮点着色器参数，映射到HLSL代码中的 'MyFloat'。			SHADER_PARAMETER(float, MyFloat) 		END_SHADER_PARAMETER_STRUCT()	}; 	IMPLEMENT_GLOBAL_SHADER(FMyComputeShader, "Path/To/Shader.usf", "MainCS", SF_Compute); 	void Render(FRHICommandList& RHICmdList, TShaderMapRef<FMyComputeShader> ComputeShader)	{		RHICmdList.SetComputeShader(ComputeShader.GetComputeShader()); 		// 正常进行C++结构体实例化。		FMyComputeShader::FParameters Parameters; 		FRHITexture* MyTexture = ...;		Parameters.MyTexture = MyTexture; 		FRHIUnorderedAccessView* MyUAV = ...;		Parameters.MyUAV = MyUAV; 		FRHIShaderResourceView* MySRV = ...;		Parameters.MySRV = MySRV; 		Parameters.MyFloat = 1.0f; 		// 使用来自着色器的绑定在RHI命令列表中设置整个着色器参数结构体。		SetShaderParameters(RHICmdList, ComputeShader, ComputeShader.GetComputeShader(), Parameters); 		// ...	}
```

#### 着色器和通道参数示例

在此示例中，代码已转换为RDG。计算着色器在其 `FParameters` 结构体中包含RDG资源，并添加了一个新的RDG通道来绑定计算着色器参数。

**C++代码示例：**

```
	class FMyComputeShader: public FGlobalShader	{	public:		DECLARE_GLOBAL_SHADER(FMyComputeShader);		SHADER_USE_PARAMETER_STRUCT(FMyComputeShader, FGlobalShader); 		BEGIN_SHADER_PARAMETER_STRUCT(FParameters, ) 			// 声明对FRDGTexture*的读取访问权限，该FRDGTexture*映射到HLSL代码中的 'MyTexture'。			SHADER_PARAMETER_RDG_TEXTURE(Texture2D, MyTexture) 			// 声明对FRDGTextureSRV*的读取访问权限，该FRDGTextureSRV*映射到HLSL代码中的 'MySRV'。			SHADER_PARAMETER_RDG_TEXTURE_SRV(Texture2D, MySRV) 			// 声明对FRDGTextureUAV*的写访问权限，该FRDGTextureUAV*映射到HLSL代码中的 'MyUAV'。			SHADER_PARAMETER_RDG_TEXTURE_UAV(RWTexture2D, MyUAV) 			// 浮点着色器参数，映射到HLSL代码中的 'MyFloat'。RDG将其忽略。			SHADER_PARAMETER(float, MyFloat) 		END_SHADER_PARAMETER_STRUCT()	}; 	IMPLEMENT_GLOBAL_SHADER(FMyCS, "Path/To/Shader.usf", "MainCS", SF_Compute); 	void AddPass(FRDGBuilder& GraphBuilder, TShaderMapRef<FMyCS> ComputeShader)	{		FMyComputeShader::FParameters* PassParameters = GraphBuilder.AllocParameters<FMyCS::FParameters>(); 		// 由FRDGBuilder::AddPass和SetShaderParameters使用		FRDGTexture* MyTexture = ...;		PassParameters->MyTexture = MyTexture; 		FRDGTextureUAV* MyUAV = ...;		PassParameters->MyUAV = MyUAV; 		// 注：你也可以像使用着色器参数一样分配空指针。RDG将忽略空参数。		FRDGTextureSRV* MySRV = nullptr;		PassParameters->MySRV = MySRV; 		// 被FRDGBuilder::AddPass忽略，由SetShaderParameters使用		PassParameters->MyFloat = 1.0f; 		// 添加一个计算通道，稍后在GraphBuilder.Execute()期间执行。用户提供PassParameter结构体		// 以及稍后在图的执行期间调用的C++ Lambda。ERDGPassFlags::Compute告知RDG此通道只会		// 发出计算命令（例如，不允许使用栅格命令）。 		GraphBuilder.AddPass(			RDG_EVENT_NAME("MyComputeShader"),			PassParameters, // <- RDG will consume the pass parameters here.			ERDGPassFlags::Compute,			[ComputeShader, PassParameters /** <- PassParameters is marshaled into the lambda here */](FRHIComputeCommandList& RHICmdList)		{			RHICmdList.SetComputeShader(ComputeShader.GetComputeShader()); 			// PassParameters在此处设置。所有非空RDG参数都被解引用到其各自的RHI资源。			SetShaderParameters(RHICmdList, ComputeShader, ComputeShader.GetComputeShader(), *PassParameters); 			// ...		});	} 
```

#### 不带着色器参数的通道参数示例

继续这个例子，代码通过在RDG中实现一个简单的 `CopyTexture` 辅助函数来展示某些通道参数没有着色器语义的情况。

> [!TIP]
> 这在通道与着色器不是一一对应或根本不涉及着色器的情况下很有用。

**C++ Code Example:**

```
	BEGIN_SHADER_PARAMETER_STRUCT(FCopyTextureParameters, ) 		// 声明CopySrc访问FRDGTexture*		RDG_TEXTURE_ACCESS(Input,  ERHIAccess::CopySrc) 		// 声明CopyDest访问FRDGTexture*		RDG_TEXTURE_ACCESS(Output, ERHIAccess::CopyDest) 	END_SHADER_PARAMETER_STRUCT() 	void AddCopyTexturePass(		FRDGBuilder& GraphBuilder,		FRDGTextureRef InputTexture,		FRDGTextureRef OutputTexture,		const FRHICopyTextureInfo& CopyInfo)	{		FCopyTextureParameters* Parameters = GraphBuilder.AllocParameters<FCopyTextureParameters>();		Parameters->Input = InputTexture;		Parameters->Output = OutputTexture; 		GraphBuilder.AddPass(			RDG_EVENT_NAME("CopyTexture(%s -> %s)", InputTexture->Name, OutputTexture->Name),			Parameters,			ERDGPassFlags::Copy,			[InputTexture, OutputTexture, CopyInfo](FRHICommandList& RHICmdList)		{			RHICmdList.CopyTexture(InputTexture->GetRHI(), OutputTexture->GetRHI(), CopyInfo);		});	} 
```

#### 栅格通道

RDG通过 `RENDER_TARGET_BINDING_SLOTS` 参数公开了栅格通道的固定功能渲染目标。RHI利用渲染通道将渲染目标绑定到命令列表。RDG通过确定何时开始和结束渲染通道来自动为你处理所有这些。你只需要为其提供绑定即可。

##### 加载操作

绑定颜色或深度/模板目标需要指定一个或多个 **加载操作**。这些操作用于控制每个目标的初始像素值。平铺渲染硬件需要准确的操作才能获得最佳性能。

以下是有效的加载操作：

- Load：

  保留纹理的现有内容。
- Clear：

  清除纹理，采用其优化的清除值。
- NoAction：

  可能不保留内容。如果写入所有有效像素，则此选项在某些硬件上更快。

> [!NOTE]
> 为深度和模板分别指定了单独的加载操作。深度模板目标还需要 `FExclusivieDepthStencil` 结构体来控制每个平面是否具有读取或写入访问权限。

以下示例显示了使用RDG清除渲染目标的几种不同方法。颜色目标手动清除，而深度和模板目标使用硬件清除操作。

**C++代码示例：**

```
	BEGIN_SHADER_PARAMETER_STRUCT(FRenderTargetParameters, RENDERCORE_API) 		// 这些绑定插槽包含颜色和深度模板目标。		RENDER_TARGET_BINDING_SLOTS() 	END_SHADER_PARAMETER_STRUCT() 	void AddClearRenderTargetPass(FRDGBuilder& GraphBuilder, FRDGTexture* Texture, const FLinearColor& ClearColor, FIntRect Viewport)	{		FRenderTargetParameters* Parameters = GraphBuilder.AllocParameters<FRenderTargetParameters>(); 		Parameters->RenderTargets[0] = FRenderTargetBinding(			Texture,			ERenderTargetLoadAction::ENoAction // <- We do not want to load prior contents of the render target, since we are manually clearing.		); 		GraphBuilder.AddPass(			RDG_EVENT_NAME("ClearRenderTarget(%s) [(%d, %d), (%d, %d)] ClearQuad", Texture->Name, Viewport.Min.X, Viewport.Min.Y, Viewport.Max.X, Viewport.Max.Y),			Parameters,			ERDGPassFlags::Raster,			[Parameters, ClearColor, Viewport](FRHICommandList& RHICmdList)		{			RHICmdList.SetViewport(Viewport.Min.X, Viewport.Min.Y, 0.0f, Viewport.Max.X, Viewport.Max.Y, 1.0f);			DrawClearQuad(RHICmdList, ClearColor);		});	} 	void AddClearDepthStencilPass(FRDGBuilder& GraphBuilder, FRDGTextureRef Texture)	{		auto* PassParameters = GraphBuilder.AllocParameters<FRenderTargetParameters>(); 		PassParameters->RenderTargets.DepthStencil = FDepthStencilBinding(			Texture,			ERenderTargetLoadAction::EClear, // <- Clear depth to its optimized clear value.			ERenderTargetLoadAction::EClear, // <- Clear stencil to its optimized clear value.			FExclusiveDepthStencil::DepthWrite_StencilWrite // <- Allow writes to both depth and stencil.		); 		GraphBuilder.AddPass(			RDG_EVENT_NAME("ClearDepthStencil (%s)", Texture->Name),			PassParameters,			ERDGPassFlags::Raster,			[](FRHICommandList&)		{			// Lambda中无实际工作！RDG为我们处理渲染通道！清除通过Clear操作完成。		});	} 
```

##### UAV栅格通道

REG支持栅格通道，它输出到非顺序访问视图（UAV），而不是固定功能渲染目标。最直接的方法是使用 `FPixelShaderUtils::AddUAVPass` 辅助函数，创建一个没有任何渲染目标的自定义渲染通道并为你绑定RHI视口。

**C++代码示例：**

```
	BEGIN_SHADER_PARAMETER_STRUCT(FUAVRasterPassParameters, RENDERCORE_API)		SHADER_PARAMETER_RDG_TEXTURE_UAV(RWTexture2D, Output)	END_SHADER_PARAMETER_STRUCT() 	auto* PassParameters = GraphBuilder.AllocParameters<FUAVRasterPassParameters>();	PassParameters.Output = GraphBuilder.CreateUAV(OutputTexture); 	// 指定视口矩形。	FIntRect ViewportRect = ...; 	FPixelShaderUtils::AddUAVPass(		GraphBuilder,		RDG_EVENT_NAME("Raster UAV Pass"),		PassParameters,		ViewportRect,		[](FRHICommandList& RHICmdList)	{		// 绑定参数并绘制。	});
```

##### 资源依赖管理

当提供给 `FRDGBuilder::AddPass` 的通道参数结构体中存在RDG资源时，关联可能会延长资源的生命周期，或使用先前的通道创建依赖关系。理想情况下，仅在需要时声明资源可降低图的复杂性，并且应将未使用的资源参数标记为null以将其从通道中删除。

挑战在于着色器决定是否使用资源，因为着色器的排列可能会编译出资源或引入新资源。为了解决这个问题，RDG包含了 `ClearUnusedGraphResources` 辅助函数，它可以清除着色器未使用的资源。

**ClearUnusedGraphResources辅助函数示例：**

```
FMyShaderCS::FParameters* PassParameters = GraphBuilder.AllocParameters<FMyShaderCS::FParameters>();//... ClearUnusedGraphresources(*ComputeShader, PassParameters);GraphBuilder.AddPass( 	RDG_EVENT_NAME("..."),	PassParameters,	ERDGPassFlags::Compute,	[PassParameters, ComputeShader, GroupCount] (FRHIComputeCommandList& RHICmdList){	FComputeShaderUtils::Dispatch(RHICmdList, ComputeShader, *PassParameters, GroupCount);});
```

> [!NOTE]
> 有一个 `ClearUnusedGraphResources` 辅助函数版本可用于多个着色器。此变体仅清除任何着色器未使用的资源。

##### Mipmap生成示例

完成了所有主要部分，本节中的代码示例演示了如何使用 **栅格** 和 **计算** 通道生成mipmap链。使用纹理非顺序访问视图（UAV）和着色器资源视图（SRV）将多个通道进行串接来表达子资源。

> [!NOTE]
> 以下是一个取自虚幻引擎基本代码的简化示例，演示了使用辅助函数来减少简单全屏绘制或计算分发的样板代码。

**栅格Mipmap生成示例：**

```
	class FGenerateMipsVS : public FGlobalShader	{	public:		DECLARE_GLOBAL_SHADER(FGenerateMipsVS);	}; 	IMPLEMENT_GLOBAL_SHADER(FGenerateMipsVS, "/Engine/Private/ComputeGenerateMips.usf", "MainVS", SF_Vertex); 	class FGenerateMipsPS : public FGlobalShader	{	public:		DECLARE_GLOBAL_SHADER(FGenerateMipsPS);		SHADER_USE_PARAMETER_STRUCT(FGenerateMipsPS, FGlobalShader); 		BEGIN_SHADER_PARAMETER_STRUCT(FParameters, )			SHADER_PARAMETER(FVector2D, HalfTexelSize)			SHADER_PARAMETER(float, Level)			SHADER_PARAMETER_RDG_TEXTURE_SRV(Texture2D, MipInSRV)			SHADER_PARAMETER_SAMPLER(SamplerState, MipSampler)			RENDER_TARGET_BINDING_SLOTS()		END_SHADER_PARAMETER_STRUCT()	}; 	IMPLEMENT_GLOBAL_SHADER(FGenerateMipsPS, "/Engine/Private/ComputeGenerateMips.usf", "MainPS", SF_Pixel); 	void FGenerateMips::ExecuteRaster(FRDGBuilder& GraphBuilder, FRDGTexture* Texture, FRHISamplerState* Sampler)	{		auto ShaderMap = GetGlobalShaderMap(GMaxRHIFeatureLevel);		TShaderMapRef<FGenerateMipsVS> VertexShader(ShaderMap);		TShaderMapRef<FGenerateMipsPS> PixelShader(ShaderMap); 		for (uint32 MipLevel = 1, MipCount = Texture->Desc.NumMips; MipLevel < MipCount; ++MipLevel)		{			const uint32 InputMipLevel = MipLevel - 1; 			const FIntPoint DestTextureSize(				FMath::Max(Texture->Desc.Extent.X >> MipLevel, 1),				FMath::Max(Texture->Desc.Extent.Y >> MipLevel, 1)); 			FGenerateMipsPS::FParameters* PassParameters = GraphBuilder.AllocParameters<FGenerateMipsPS::FParameters>();			PassParameters->HalfTexelSize = FVector2D(0.5f / DestTextureSize.X, 0.5f / DestTextureSize.Y);			PassParameters->Level = InputMipLevel;			PassParameters->MipInSRV = GraphBuilder.CreateSRV(FRDGTextureSRVDesc::CreateForMipLevel(Texture, InputMipLevel));			PassParameters->MipSampler = Sampler;			PassParameters->RenderTargets[0] = FRenderTargetBinding(Texture, ERenderTargetLoadAction::ELoad, MipLevel); 			FPixelShaderUtils::AddFullscreenPass(				GraphBuilder,				ShaderMap,				RDG_EVENT_NAME("GenerateMips DestMipLevel=%d", MipLevel),				PixelShader,				PassParameters,				FIntRect(FIntPoint::ZeroValue, DestTextureSize));		}	} 
```

**计算Mipmap生成示例：**

```
	class FGenerateMipsCS : public FGlobalShader	{	public:		DECLARE_GLOBAL_SHADER(FGenerateMipsCS)		SHADER_USE_PARAMETER_STRUCT(FGenerateMipsCS, FGlobalShader) 		BEGIN_SHADER_PARAMETER_STRUCT(FParameters, )			SHADER_PARAMETER(FVector2D, TexelSize)			SHADER_PARAMETER_RDG_TEXTURE_SRV(Texture2D, MipInSRV)			SHADER_PARAMETER_RDG_TEXTURE_UAV(RWTexture2D, MipOutUAV)			SHADER_PARAMETER_SAMPLER(SamplerState, MipSampler)		END_SHADER_PARAMETER_STRUCT()	}; 	IMPLEMENT_GLOBAL_SHADER(FGenerateMipsCS, "/Engine/Private/ComputeGenerateMips.usf", "MainCS", SF_Compute); 	void FGenerateMips::ExecuteCompute(FRDGBuilder& GraphBuilder, FRDGTexture* Texture, FRHISamplerState* Sampler)	{		TShaderMapRef<FGenerateMipsCS> ComputeShader(GetGlobalShaderMap(GMaxRHIFeatureLevel)); 		// 循环遍历需要创建的mip的每个级别，并为每个级别添加一个调度通道。		for (uint32 MipLevel = 1, MipCount = TextureDesc.NumMips; MipLevel < MipCount; ++MipLevel)		{			const FIntPoint DestTextureSize(				FMath::Max(TextureDesc.Extent.X >> MipLevel, 1),				FMath::Max(TextureDesc.Extent.Y >> MipLevel, 1)); 			FGenerateMipsCS::FParameters* PassParameters = GraphBuilder.AllocParameters<FGenerateMipsCS::FParameters>();			PassParameters->TexelSize  = FVector2D(1.0f / DestTextureSize.X, 1.0f / DestTextureSize.Y);			PassParameters->MipInSRV   = GraphBuilder.CreateSRV(FRDGTextureSRVDesc::CreateForMipLevel(Texture, MipLevel - 1));			PassParameters->MipOutUAV  = GraphBuilder.CreateUAV(FRDGTextureUAVDesc(Texture, MipLevel));			PassParameters->MipSampler = Sampler; 			FComputeShaderUtils::AddPass(				GraphBuilder,				RDG_EVENT_NAME("GenerateMips DestMipLevel=%d", MipLevel),				ComputeShader,				PassParameters,				FComputeShaderUtils::GetGroupCount(DestTextureSize, FComputeShaderUtils::kGolden2DGroupSize));		}	} 
```

##### 异步计算

RDG通过检查图依赖关系并在同步点插入栅栏来支持异步计算调度。

通过使用 `ERDGPassFlags::AsyncCompute` 标志来标记通道，并使用 `FRHIComputeCommandList` 类型作为通道Lambda中的参数来启用异步计算。

> [!NOTE]
> 平台和RDG还必须启用异步计算。不支持异步计算的平台将回退到图形管道。可使用控制台命令 `r.RDG.AsyncCompute`（默认启用）来显式禁用RDG支持。

**C++代码示例：**

```
	GraphBuilder.AddPass(		RDG_EVENT_NAME("MyAsyncComputePass"),		ERDGPassFlags::AsyncCompute, // <- 在此处指定AsyncCompute标志。		PassParameters,		[] (FRHIComputeCommandList& RHICmdList) // <- 在此处指定FRHIComputeCommandList。	{		// 执行。	});
```

> [!TIP]
> 对于简单的计算着色器，可使用 `FComputeShaderUtils::AddPass` 的异步计算变体。

使用依赖图安排异步计算工作。当标记一个或多个通道时，RDG遍历该图以找到图形管线上的最后一个生产者并插入栅栏。同样，图形管线上第一次进行计算时，异步计算会重新连接到图形。

下图描述了上述场景。

![Asynchronous compute scheduling](../../../../assets/images/5b/5b3e158b4b382c9bf73d5d86eead9d1ce40d84cd3d7de430fce0b5d50a953568.jpg)

此图描述了图形和异步计算队列，时间显示为水平轴。

在上图中，**通道A** 是 **通道C** 的生产者。因此，在通道A执行之后，引入了一个栅栏，它表示通道C开始工作。异步计算管道运行直到 **通道D** 完成，此时它与图形管道同步，以便消费者— **通道E** —看到正确的结果。

> [!NOTE]
> 使用RDG Insights工具在图中可视化异步计算事件。屏幕截图显示RDG Insights工具中与上图类似的视图，但它是从引擎中的实际工作负载中捕获的。有关使用该工具的更多信息，请参阅本页的[RDG Insights](#rdginsightsplugin)部分。
>
> ![RDG Insights Timeline Views](../../../../assets/images/9f/9f7b4cb1a99e2b295aec8144368dbe59d58b6f87e329caaa59c162cf84fb0e6f.jpg)

##### 外部资源

如果资源的生命周期延伸到图外，则资源被视为 **外部**，这可能在两种情况下发生：资源被注册到图中，或者从图中提取出来。

注册到图中是使用 `FRDGBuilder::RegisterExternal{Texture, Buffer}` 方法完成的。这将采用预分配引用计数池RHI资源指针创建一个新RDG资源：`IPooledRenderTarget` 用于纹理，或 `FRDGPooledTexture` 用于缓冲区。

执行完成后，从图中进行提取填充池化资源指针。注册资源会将RDG资源的生命周期延长到图的前面。需要考虑在图设置期间发生分配。提取操作则相反，它将资源生命周期延长到图的末尾，因为用户现在持有一个引用。

如果用户并未持有图之外的引用，注册或提取的资源仍可在技术上稍后或更早地与帧中的其他RDG资源共享池化内存。

下面的代码摘录演示了使用图构建器注册或提取纹理的各种方法。请注意，注册和提取如何使用相同的池化纹理类型，从而允许从图到图的往返。

**C++代码示例：**

```
	// 提取池化渲染目标。调用Execute()后，指针被填充。	TRefCountPtr<IPooledRenderTarget> ExtractedTexture; 	// 第一个图生成纹理并提取该纹理。	{		FRDGBuilder GraphBuilder(RHICmdList); 		FRDGTexture* Texture = GraphBuilder.CreateTexture(...); 		// ... 		GraphBuilder.QueueTextureExtraction(Texture, &ExtractedTexture);		GraphBuilder.Execute(); 		check(ExtractedTexture); // Valid	} 	// 第二个图注册池化纹理。	{		FRDGBuilder GraphBuilder(RHICmdList); 		// 注册池化渲染目标以获取RDG纹理。		FRDGTexture* Texture = GraphBuilder.RegisterExternalTexture(ExtractedTexture); 		// ... 		GraphBuilder.Execute();	}
```

> [!NOTE]
> 除了使用 `FRDGPooledBuffer` 类之外，缓冲区的代码实际上是相同的。

##### 替代方法：转换为外部

外部资源的另一种方法是 `FRDGBuilder:ConvertToExternal{Texture, Buffer}`。它执行底层池化资源的立即分配并返回该资源。

在无法等到在图末尾提取资源的情况下，此方法很有用。转换和提取之间的最大区别是生命周期范围。转换将生命周期延伸到图的开头，而提取将其延伸到图的末尾，这意味着资源将无法与框架中的任何其他资源共享底层分配。

#### 临时资源

渲染依赖图在图编译期间使用临时资源分配器来计划跨执行时间轴的分配。生命周期不相交的资源可以在内存中重叠。

与默认资源池方法相比，实现了临时分配器的平台可以显著减少GPU内存水印。这是由于在内存别名方面增加了灵活性。资源池必须比较和匹配RHI描述符以确定它们的重用性。而临时分配器可以共享底层内存。

你可以使用控制台变量 `r.RDG.TransientAllocator` 来控制是否启用临时分配器。

在查找特定于别名的问题时，此变量对于切换很有用。特别要注意的是不要依赖资源明确定义的先前内容。资源池通常会掩盖这些问题，因为被重用的通常是相同或相似的资源，但临时分配器并非如此。之前的内容将作为垃圾。

### RDG统一缓冲区

RDG统一缓冲区可能包含RDG资源。正如预期，RDG在图设置期间初始化描述符，并将底层RHI统一缓冲区的创建推迟到执行。如果资源被确定为未使用，则将其剔除并且从不初始化。

使用 `FRDGBuilder::CreateUniformBuffer` 以 **统一参数结构体** 作为输入来创建RDG统一缓冲区。统一参数结构体是通道参数的扩展，可包含RDG资源。`FRDGBuilder::AddPass` 除了根通道参数之外，还遍历子统一参数。

> [!NOTE]
> 目前RDG统一缓冲区的主要缺点是它们不能为空资源参数，并且着色器不可能反射和剔除未使用的参数。目前，必须通过为每组参数创建唯一的统一缓冲区来手动修剪资源。
>
> 有关实际示例，请参阅：延迟着色渲染器中的场景纹理统一缓冲区。

RDG统一缓冲区 **必须** 在提供给 `FRDGBuilder:AddPass` 的通道参数结构体上使用 `SHADER_PARAMETER_RDG_UNIFORM_BUFFER` 进行声明，以便统一缓冲区在通道Lambda中可取消引用。

**C++代码示例：**

```
	// 包含单个RDG纹理的简单统一缓冲区。	BEGIN_UNIFORM_BUFFER_STRUCT(FMyUniformParameters, )		SHADER_PARAMETER_RDG_TEXTURE(Texture2D, Texture)	END_UNIFORM_BUFFER_STRUCT() 	// 使用单个RDG统一缓冲区参数定义通道参数。	BEGIN_SHADER_PARAMETER_STRUCT(FMyPassParameters, )		SHADER_PARAMETER_RDG_UNIFORM_BUFFER(FMyUniformParameters, UniformBuffer)		RENDER_TARGET_BINDING_SLOTS()	END_SHADER_PARAMETER_STRUCT() 	void AddPass(FRDGBuilder& GraphBuilder, TShaderMapRef<FShader> PixelShader, FRDGTexture* InputTexture, FRDGTexture* OutputTexture)	{		// 首先创建统一缓冲区。		FMyUniformParameters* UniformParameters = GraphBuilder.AllocParameters<FMyUniformParameters>();		UniformParameters->Texture = InputTexture; 		TRDGUniformBuffer<FMyUniformParameters>* UniformBuffer = GraphBuilder.CreateUniformBuffer(UniformParameters); 		// 现在构造通道。		FMyPassParameters* PassParameters = GraphBuilder.AllocParameters<FMyPassParameters>();		PassParameters->UniformBuffer = UniformBuffer;		PassParameters->RenderTargets[0] = FRenderTargetBinding(OutputTexture, ERenderTargetLoadAction::ELoad); 		GraphBuilder.AddPass(			RDG_EVENT_NAME("MyPass"),			PassParameters,			ERDGPassFlags::Raster,			[PassParameters, UniformBuffer, PixelShader](FRHICommandList& RHICmdList)		{			// ... 绑定着色器等 			// 你可以在此处访问RHI统一缓冲区！			FRHIUniformBuffer* UniformBufferRHI = UniformBuffer->GetRHI(); 			// 你也可以访问RDG纹理，它是RHI纹理！			FRHITexture* TextureRHI = (*UniformBuffer)->Texture->GetRHI(); 			// 你也可以调用相同的SetShaderParameters辅助方法来绑定RDG统一缓冲区。			SetShaderParameters(RHICmdList, PixelShader, PixelShader.GetComputeShader(), *PassParameters);		});	}
```

### 上传缓冲区

如果RDG资源在执行图之前需要来自CPU的初始数据，则 `FRDGBuilder::QueueBufferUpload` 方法是最有效的调度方法。RDG在图编译期间一起批量上传，并且可能与其他编译任务重叠进行。

下面的示例代码演示了如何将CPU数据数组上传到RDG缓冲区。

**缓冲区上传示例：**

```
	FRDGBuffer IndexBuffer = GraphBuilder.CreateBuffer(		FRDGBufferDesc::CreateUploadDesc(sizeof(uint32), NumIndices),		TEXT("MyIndexBuffer")); 	// 针对延迟，使用内部RDG分配器为分配数据数组。	FRDGUploadData<int32> Indices(GraphBuilder, NumIndices); 	// 分配数据	Indices[0] = // ...;	Indices[1] = // ...;	Indices[NumIndices - 1] = // ...; 	// 上传数据	GraphBuilder.QueueBufferUpload(IndexBuffer, Indices, ERDGInitialDataFlags::NoCopy);
```

在RDG中使用上传缓冲区时，请考虑以下事项：

- 请务必使用RDG执行上传。

  - 在一个通道中使用立即命令列表手动锁定/解锁会引入一个同步点并阻止并行执行。
  - 上传缓冲区自动标记为非临时。临时资源不支持CPU上传。
- 请使用最准确的

  ERDGInitialDataFlags

  。

  - 如果数据生命周期足以承受图的延迟，请使用

    NoCopy

    。否则，让RDG进行复制。

### 内存生命周期

在处理内存生命周期时，设置和执行时间轴的拆分需谨慎。一个常见的错误是将内存传递到RDG Lambda中，但图在执行时不能保证该内存仍存在。

为了帮助解决这个问题，RDG包含了自己的线性分配器，具有适当的生命周期保证。API支持不同开销的分配。

对于POD类型，请使用 `FRDGBuilder::AllocPOD`。

> [!NOTE]
> 如果C++对象需要析构函数跟踪，请使用 `FRDGBuilder::AllocObject`。

**C++代码示例：**

```
	// 不佳！	FMyObject Object;	GraphBuilder.AddPass(..., [&Object] (FRHICommandList&) { /** Object is captured by reference but exists on the stack! 指针无效！*/ }); 	// 良好	TUniquePtr<FMyObject> Object(new FMyObject());	GraphBuilder.AddPass(..., [Object = MoveTemp(Object)] (FRHICommandList&) { /** Object is valid but was expensive to allocate. */ }); 	// 最佳情况是C++对象（调用析构函数，增加一点开销）	FMyObject* Object = GraphBuilder.AllocObject<FMyObject>();	GraphBuilder.AddPass(..., [Object = MoveTemp(Object)] (FRHICommandList&) { /** Object is valid and was cheap to allocate. */ }); 	// 最佳情况是POD结构体（不会调用析构函数）	FMyObject* Object = GraphBuilder.AllocPOD<FMyObject>();	... 	// 对于原始内存。	void* Memory = GraphBuilder.Alloc(SizeInBytes, AlignInBytes); 	// 对于RDG通道参数——可能会执行额外的跟踪。	FMyPassParameters* PassParameters = GraphBuilder.AllocParameters<FMyPassParameters>();
```

> [!NOTE]
> 所有分配的内存都将持续存在，直到图构建器实例被销毁。它使用线性分配器并且非常快。

### 性能分析

RDG支持引擎中各种分析器的范围定义：

- 使用

  RDG_EVENT_SCOPE

  在通道周围添加GPU配置文件范围。这些将由RenderDoc等外部分析器以及RDG Insights使用。
- 使用

  RDG_GPU_STAT_SCOPE

  为

  stat gpu

  命令添加新范围。
- 使用

  RDG_CSV_STAT_EXCLUSIVE_SCOPE

  为CSV分析器添加新范围。

RDG范围将构建器作为输入，并适当考虑单独的设置和执行时间轴。

### 约定

以下是使用RDG编写代码时使用的常规编码约定。遵循这些约定可确保整个渲染器的一致性。

- 采用句点分隔为资源构建命名空间。

  - 例如，

    TSR.History.ScreenPercentage

    。这简化了RDG Insights和其他工具中的名称过滤。
- 命名图生成器实例：

  GraphBuilder
- 在着色器实例上内联命名着色器参数：

  FParameters
- 使用

  RDG_EVENT_SCOPE

  作为通道的命名空间。
- 尽可能使用

  RenderGraphUtils.h

  或

  ScreenPass.h

  中的辅助函数。

## 调试和验证

渲染图系统通过引入延迟模式数据结构增加了复杂性。当执行期间发生故障时，可能很难找到与其执行Lambda关联的通道设置位置。当启用RHI线程时，情况会更加复杂，因为正在执行的RHI命令现在从其设置位置移开两度。

例如，如果在平台RHI内设置RHI着色器参数时发生崩溃，则无法仅从调用堆栈位置推断故障发生的位置。RDG和RHI都有工具来帮助解决这些问题。RDG **即时模式** 是一种调试功能，它绕过图的编译，有利于直接在 `AddPass` 调用中执行通道。

使用调试或开发版本时启用以下方法。

| 方法 | 变量 |
| --- | --- |
| 控制台变量 | `r.RDG.ImmediateMode` |
| 命令行参数 | `-rdgimmediate` |

在另一个示例中，如果由于通道参数结构体中的空指针导致RDG通道Lambda内发生崩溃，则调试器会在Lambda内部中断，此时检查任何设置代码为时已晚（其中真正的问题被引入）。启用即时模式后，Lambda会在设置时间轴上执行，从而可以直接检查设置代码。

使用控制台命令 `r.RHICmdBypass` 禁用并行渲染和软件命令列表。结合RDG即时模式，它消除了所有延迟机制，提供了一个用于调试的调用堆栈。

> [!TIP]
> 还有其他一些控制台变量来控制RHI线程行为，可参考[并行渲染概述](../parallel-rendering-overview/index.md)文档。

> [!NOTE]
> 在即时模式下，所有图优化都被禁用，包括临时分配、图剔除、渲染通道合并等。这将引入它们被禁用的副作用。

此外，如果出现问题，请使用以下控制台变量禁用RDG中的各个功能，而无需调用即时模式将其排除。

| 变量 | 描述 |
| --- | --- |
| `r.RDG.CullPasses` | 禁用以排除被剔除的通道。 |
| `r.RDG.MergeRenderPasses` | 禁用以要求每个RDG栅格通道具有唯一的渲染通道。 |
| `r.RDG.ParallelExecute` | 禁用以在渲染线程上串行运行所有通道。 |
| `r.RDG.TransientAllocator` | 禁用以回退到资源池。 |

#### 验证层

RDG包含一个验证层，在使用调试或开发构建时默认启用。如果RDG使用不正确，该层会尽早发出致命检查，带有明确标记的资源/通道名称。它增加了额外的CPU开销，并会在测试和交付版本中编译出来。

### 资源转换调试

RHI中的资源转换API为每个子资源分配一个 `ERHIAccess` 和 `ERHIPipeline` 掩码。RDG负责在整个图中的状态之间转换各个子资源，假设资源使用RDG通道参数正确声明。当资源转换不正确时，RHI验证会记录日志，但可能很难调试在RDG中发生的转换，因为调用堆栈位置看起来总是相同的。

> [!NOTE]
> RDG本身已经过严格测试，以确保生成正确的转换。但是，如果需要，可以将RDG转换日志与RHI转换日志混合以发现不一致之处。

**RDG转换日志：**

- 使用-rdgtransitionlog或r.rdg.transitionlog X（其中X是要记录的帧数）记录RDG中发生的所有转换。
- 使用

  r.RDG.Debug.ResourceFilter [ResourceName]

  按资源名称过滤日志。
- 使用

  r.RDG.Debug.PassFilter

  PassName按通道名称过滤日志。

**RHI转换日志：**

使用 `-rhivalidation` 和 `-rhivalidationlog=ResourceName` 记录特定资源。

默认情况下，RDG打印来自 **渲染线程** 的转换，而RHI打印来自 **RHI线程** 的转换日志。要使它们对齐，你必须指定 `-norhithread -forcerhibypass` 或 `-onethread`。然而，禁用RHI线程会掩盖某些跨管线转换错误，但在大多数情况下，该问题仍会重现。

例如，要记录 `SceneDepthZ` 的所有RDG和RHI活动，请使用命令行参数：

-rhivalidation -rhivalidationlog=SceneDepthZ -rdgtransitionlog -rdgdebugresourcefilter=SceneDepthZ -onethread

### 可视化纹理

在开发版本中，RDG发布了所有纹理UAV或RTV写入 `vis` 命令。使用此命令在屏幕上可视化资源。在命令行中键入'vis'查看可用资源列表和命令格式。

### 临时分配器调试

临时分配器引入潜在瑕疵来源。使用 `r.RDG.TransientAllocator` 启用或禁用系统。

如果禁用系统消除了瑕疵，请考虑以下附加测试：

- 使用

  .RDG.ClobberResources

  将所有资源强制初始化为已知值。如果这在没有启用临时分配器的情况下产生类似瑕疵，那么可能的解释是资源在被读取之前没有正确初始化。
- 使用

  r.RDG.Debug.ExtendResourceLifetimes

  禁用图中的所有别名。这对于排除缺少别名屏障或不正确的资源生命周期很有用。
- 使用

  r.RDG.Debug.DisableTransientResources

  从临时分配器中禁用资源。

> [!TIP]
> 对于上述任一命令，使用 `r.RDG.Debug.ResourceFilter` 过滤受影响的资源。这有助于缩小有问题的资源范围。

### RDG Insights插件

作为[Unreal Insights](../../../testing-and-optimizing-content/unreal-insights/index.md)工具的扩展，渲染依赖图有自己的插件，称为 **RDG Insights**，用于RDG图结构的实时可视化。捕获追踪被并在 **Timing Insights** 视图中与其他CPU轨道一起显示为轨道。

转到主菜单并选择 **编辑（Edit）> 插件（Plugins）> Insights**，启用 **RDG Insights** 插件。

![RDG Insights Timeline Views](../../../../assets/images/9f/9f7b4cb1a99e2b295aec8144368dbe59d58b6f87e329caaa59c162cf84fb0e6f.jpg)

RDG Insights插件可用于查看图的属性：

- 资源生命周期、通道关联和资源池分配重叠
- 异步计算栅栏和重叠
- 图剔除和渲染通道合并
- 并行执行通道范围
- 临时内存布局

RDG Insights插件也可以用作调试和诊断工具来回答以下问题：

- 为什么异步计算通道不与图通道重叠？
- 跨框架如何使用资源？
- 资源分配是否与其他资源重叠？
- 后处理使用哪些资源？
- 哪些通道被剔除？

#### 捕获追踪

捕获追踪只需要在Unreal Insights中启用RDG通道。启动客户端应用程序时，指定 `-trace=rdg,defaults` 参数即可。

如果连接到Unreal Insights中的实时追踪（Live Trace），启用RDG通道即可。

> [!WARNING]
> RDG追踪会生成大量数据。

#### 参考幻灯片

有关该工具的更深入演练，请参阅以下[幻灯片](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/98d7ea4e-3368-449f-a931-e34b68003cc4/rdg-insights-presentation.pdf)。

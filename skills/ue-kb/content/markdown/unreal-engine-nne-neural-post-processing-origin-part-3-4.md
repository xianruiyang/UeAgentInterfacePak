# unreal-engine-nne-neural-post-processing.origin (Part 3/4)

# unreal-engine-nne-neural-post-processing.origin (Part 3/4)

Source file: `unreal-engine-nne-neural-post-processing.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 入队后处理

最后一个要实现的函数是**PrePostProcessPass_RenderThread**。每当渲染管道准备好将后处理通道加入队列时，**FSceneViewExtensionBase** 基类就会从渲染线程内调用它。首先添加一个健全性检查，确保调用者在渲染线程上运行，并且传递的 **FSceneView** 的类型为 **FViewInfo,**，以便我们稍后可以安全地进行静态转换。如果 **Model** 无效，则返回，以便我们跳过后处理。

```cpp
void FNeuralPostProcessingViewExtension::PrePostProcessPass_RenderThread(FRDGBuilder& GraphBuilder, const FSceneView& View, const FPostProcessingInputs& Inputs)
{
	check(IsInRenderingThread());
	check(View.bIsViewInfo);

	if (!ModelInstance.IsValid())
	{
		return;
	}
	// ...
```

在本教程中，我们将神经网络模型的输入和输出限制为形状为**1 x 3 x 高度 x 宽度**的单个张量，其中高度和宽度必须是动态尺寸。此限制使我们能够保持着色器代码简单，同时仍然能够支持所有屏幕分辨率。从而检查输入的数量是否为1以及等级和输入形状是否满足要求。

```cpp
	using namespace UE::NNE;
	checkf(ModelInstance->GetInputTensorDescs().Num() == 1, TEXT("Neural Post Processing requires models with a single input tensor!"));
	FSymbolicTensorShape InputShape = ModelInstance->GetInputTensorDescs()[0].GetShape();
	checkf(InputShape.Rank() == 4, TEXT("Neural Post Processing requires models with input shape 1 x 3 x height x width!"));
	checkf(InputShape.GetData()[0] == 1, TEXT("Neural Post Processing requires models with input shape 1 x 3 x height x width!"));
	checkf(InputShape.GetData()[1] == 3, TEXT("Neural Post Processing requires models with input shape 1 x 3 x height x width!"));
	checkf(InputShape.GetData()[2] == -1, TEXT("Neural Post Processing requires models with input shape 1 x 3 x height x width!"));
	checkf(InputShape.GetData()[3] == -1, TEXT("Neural Post Processing requires models with input shape 1 x 3 x height x width!"));
```

**NNE** 需要在模型运行之前或输入形状更改时调用 **SetInputTensorShapes**。这允许模型根据输入形状分配或调整资源大小。由于这可能是一个昂贵的操作，因此我们仅在发生更改时调用该函数。因此，通过将当前输入形状与最后设置的输入形状进行比较的测试来包装调用。

```cpp
	FIntPoint TextureSize = (*Inputs.SceneTextures)->SceneColorTexture->Desc.Extent;
	if (LastInputSize.X != TextureSize.X || LastInputSize.Y != TextureSize.Y)
	{
		TArray<FTensorShape> InputShapes = { FTensorShape::Make({ 1, 3, (uint32)TextureSize.Y, (uint32)TextureSize.X }) };
		ModelInstance->SetInputTensorShapes(InputShapes);
		LastInputSize = TextureSize;
	}
```

在模型上调用 **SetInputTensorShapes** 后，可以查询输出形状。与输入形状类似，我们执行一些检查。这次我们还必须确保输出的高度和宽度与输入的高度和宽度匹配。

```cpp
	checkf(ModelInstance->GetOutputTensorShapes().Num() == 1, TEXT("Neural Post Processing requires models with a single output tensor!"));
	FTensorShape OutputShape = ModelInstance->GetOutputTensorShapes()[0];
	checkf(OutputShape.Rank() == 4, TEXT("Neural Post Processing requires models with output shape 1 x 3 x height x width!"));
	checkf(OutputShape.GetData()[0] == 1, TEXT("Neural Post Processing requires models with output shape 1 x 3 x height x width!"));
	checkf(OutputShape.GetData()[1] == 3, TEXT("Neural Post Processing requires models with output shape 1 x 3 x height x width!"));
	checkf(OutputShape.GetData()[2] == TextureSize.Y, TEXT("Neural Post Processing requires models with output height == input height!"));
	checkf(OutputShape.GetData()[3] == TextureSize.X, TEXT("Neural Post Processing requires models with output width == input width!"));
```

在调用神经网络模型之前，我们首先需要准备一个输入缓冲区并用场景纹理的像素填充它。为此，我们首先要求 FRDGBuilder 为我们分配（或返回分配的）内存。然后，我们可以填写 **FNeuralPostProcessingPrepareInputCS** 着色器通道的参数结构。

```cpp
	FRDGBufferDesc InputBufferDesc = FRDGBufferDesc::CreateBufferDesc(sizeof(float), TextureSize.X * TextureSize.Y * 3);
	FRDGBufferRef InputBuffer = GraphBuilder.CreateBuffer(InputBufferDesc, *FString("NeuralPostProcessing::InputBuffer"));
	FRDGBufferUAVRef InputBufferUAV = GraphBuilder.CreateUAV(FRDGBufferUAVDesc(InputBuffer, PF_R32_FLOAT));

	FNeuralPostProcessingPrepareInputCS::FParameters* PrepareInputParameters = GraphBuilder.AllocParameters<FNeuralPostProcessingPrepareInputCS::FParameters>();
	PrepareInputParameters->InputTexture = (*Inputs.SceneTextures)->SceneColorTexture;
	PrepareInputParameters->InputTextureSampler = TStaticSamplerState<SF_Point, AM_Clamp, AM_Clamp, AM_Clamp>::GetRHI();
	PrepareInputParameters->Width = TextureSize.X;
	PrepareInputParameters->Height = TextureSize.Y;
	PrepareInputParameters->InputBuffer = InputBufferUAV;
```

我们需要计算所需的线程组数量，以便输入缓冲区的每个像素都有一个线程。然后创建 **FNeuralPostPro...

```cpp
	FIntVector PrepareInputThreadGroupCount = FIntVector(FMath::DivideAndRoundUp(TextureSize.X, NEURAL_POST_PROCESSING_THREAD_GROUP_SIZE), FMath::DivideAndRoundUp(TextureSize.Y, NEURAL_POST_PROCESSING_THREAD_GROUP_SIZE), 1);
	FGlobalShaderMap* GlobalShaderMap = GetGlobalShaderMap(GMaxRHIFeatureLevel);
	TShaderMapRef<FNeuralPostProcessingPrepareInputCS> PrepareInputShader(GlobalShaderMap);
	FComputeShaderUtils::AddPass(
		GraphBuilder,
		RDG_EVENT_NAME("NeuralPostProcessing.PrepareInput"),
		ERDGPassFlags::Compute | ERDGPassFlags::NeverCull,
		PrepareInputShader,
		PrepareInputParameters,
		PrepareInputThreadGroupCount);
```

```cpp
	FRDGBufferDesc OutputBufferDesc = FRDGBufferDesc::CreateBufferDesc(sizeof(float), TextureSize.X * TextureSize.Y * 3);
	FRDGBufferRef OutputBuffer = GraphBuilder.CreateBuffer(OutputBufferDesc, *FString("NeuralPostProcessing::OutputBuffer"));
	FRDGBufferUAVRef OutputBufferUAV = GraphBuilder.CreateUAV(FRDGBufferUAVDesc(OutputBuffer, PF_R32_FLOAT));
```

```cpp
	TArray<FTensorBindingRDG> InputBindings;
	TArray<FTensorBindingRDG> OutputBindings;
	FTensorBindingRDG& Input = InputBindings.Emplace_GetRef();
	FTensorBindingRDG& Output = OutputBindings.Emplace_GetRef();
	Input.Buffer = InputBuffer;
	Output.Buffer = OutputBuffer;
	ModelInstance->EnqueueRDG(GraphBuilder, InputBindings, OutputBindings);
```

```cpp
	const FIntRect Viewport = static_cast<const FViewInfo&>(View).ViewRect;
	FScreenPassTexture SceneColor((*Inputs.SceneTextures)->SceneColorTexture, Viewport);
	FNeuralPostProcessingProcessOutputPS::FParameters* ProcessOutputParameters = GraphBuilder.AllocParameters<FNeuralPostProcessingProcessOutputPS::FParameters>();
	ProcessOutputParameters->Width = TextureSize.X;
	ProcessOutputParameters->Height = TextureSize.Y;
	ProcessOutputParameters->OutputBuffer = OutputBufferUAV;
	ProcessOutputParameters->RenderTargets[0] = FRenderTargetBinding(SceneColor.Texture, ERenderTargetLoadAction::ENoAction);

	TShaderMapRef<FNeuralPostProcessingProcessOutputPS> WriteOutputShader(GlobalShaderMap);
	FPixelShaderUtils::AddFullscreenPass(
```

```cpp
void FNeuralPostProcessingViewExtension::PrePostProcessPass_RenderThread(FRDGBuilder& GraphBuilder, const FSceneView& View, const FPostProcessingInputs& Inputs)
{
	check(IsInRenderingThread());
	check(View.bIsViewInfo);

	if (!ModelInstance.IsValid())
	{
		return;
	}
```

### 蓝图

### 设置

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-09.jpg)

![教程图片](assets/unreal-engine-nne-neural-post-processing/image-10.jpg)


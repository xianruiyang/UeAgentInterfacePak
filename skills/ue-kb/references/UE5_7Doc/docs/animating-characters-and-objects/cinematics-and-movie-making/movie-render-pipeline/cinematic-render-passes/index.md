---
title: "渲染通道"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematic-render-passes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "渲染通道"]
---

# 渲染通道

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 渲染通道

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematic-render-passes-in-unreal-engine

电影渲染队列支持在单独的通道中渲染不同类型的输出图像，例如最终图像、对象ID和其他渲染相关通道。每个渲染通道设置将在单独的渲染模式中输出你的电影。然后，你可以在外部后期制作或所选的合成程序中使用它们。

#### 先决条件

- 你已经完成了

  电影渲染队列（Movie Render Queue）

  页面中的先决条件步骤。
- 如果你要使用 **对象ID（Object ID's）** ，必须启用插件才能使用。在虚幻引擎菜单中，找到 **编辑（Edit）> 插件（Plugins）** ，在 **渲染（Rendering）** 分段中找到 **电影渲染队列其他渲染通道（Movie Render Queue Additional Render Passes）** ，并启用它。之后你将需要重启编辑器。

  ![渲染通道插件](../../../../../assets/images/76/7662d390ee77c2cd5c7d722939f1f6b9a43e34ed2c1410fa0fa3e6faadb9557f.png)

> [!NOTE]
> 虽然电影渲染队列能够输出 *一些* 渲染通道，由于延迟渲染的局限性，无法输出要从中组装最终图像的所有通道。这意味着，其他渲染程序包（AOV）中可用的常见通道（例如环境光遮蔽或子表面散射）在虚幻引擎中不可用。此页面仅列出了支持的通道。

## 概述

点击 **+ 设置（+ Setting）** 按钮并选择 **渲染（Rendering）** 类别中的条目，即可将 **渲染通道（Render Passes）** 添加到输出中。

![渲染通道列表](../../../../../assets/images/de/de6a88017375c8a7f938e8f915dfe097755031fd188c453f94ad73a0cddbb439.png)

你可以像使用任何其他设置一样启用和禁用渲染通道，并且可以选择它们来编辑其属性（若可用）。

默认情况下，你选择的所有渲染通道将在最终输出文件夹中一起输出。你可以利用格式字符串令牌 `{render_pass}` 帮助整理你的通道。例如，在 **文件名格式（File Name Format）** 中设置以下内容，将导致你的通道分成相对于 **输出目录（Output Directory）** 的通道相关子文件夹：

```
	{render_pass}/{sequence_name}.{frame_number}
```

![电影渲染队列可以生成的一些渲染通道示例。](../../../../../assets/images/ec/ece532d283c61b771ae1864d648084b39c127f6f9086310bfa7f9a4108e6e740.jpg)

**电影渲染队列可以生成的一些渲染通道示例。**

## 延迟渲染

虚幻（Unreal）的主要输出由默认的 **延迟渲染（Deferred Rendering）** 设置来处理，将产生你在视口中看到的最终图像。其中提供了一些变体，包括 **细节光照（Detail Lighting）** 、 **仅光照（Lighting Only）** 、 **反射（Reflections）** 和 **无光照（Unlit）** 。这些变体不会在创建最终图像时使用，在此处提供只是为了匹配关卡编辑器视口。

延迟渲染（Deferred Rendering）包括以下选项：

| 渲染通道 | 说明 |
| --- | --- |
| **延迟渲染（Deferred Rendering）** | 显示场景的最终图像，与你在视口中看到的相匹配。 延迟渲染 |
| **细节光照（Detail Lighting）** | 一种特殊着色器变体，仅显示与法线贴图相结合的光照。在显示场景的几何体时非常有用。 延迟细节光照 |
| **仅光照（Lighting Only）** | 与细节光照相似，但没有影响光照的法线贴图。 仅延迟光照 |
| **仅反射（Reflections Only）** | 一种特殊的着色器变体，使世界中的所有内容都100%反光。 仅延迟反射 |
| **无光照（Unlit）** | 一种特殊的着色器变体，仅显示基础颜色，没有光照信息。 延迟无光照 |

所有延迟渲染（Deferred Rendering）通道都具有相同的属性，但每个渲染通道可以单独配置。

![延迟渲染细节](../../../../../assets/images/8b/8b37a1e5374fddbff1cc6fcc5653938251dab70189281c93a77f32103888b03b.png)

| 名称 | 说明 |
| --- | --- |
| **累加器包含Alpha（Accumulator Includes Alpha）** | 如果启用，将针对alpha通道累积多个时间/空间采样。这需要r.PostProcessing.PropagateAlpha设置为1或2，为此，你可以转至"项目设置（Project Settings）> 渲染（Rendering）"，并使用"在后期处理中启用Alpha通道支持（Enable Alpha Channel Support in Post Processing）"设置。 这样做会增加大约30%的累积成本，因此除非确有必要，否则应避免使用此项。这适用于使用多个时间或空间采样的渲染。 |
| **禁用多重采样效果（Disable Multisample Effects）** | 禁用混合了多种像素的后期处理效果，例如景深、时间抗锯齿、动态模糊和色象差，在使用对象ID渲染通道时，不需要这些效果。你可以利用此设置为渲染作业排除这些后期处理，而不必在你的场景中手动禁用。 |
| **使用32位后期处理材质（Use 32Bit Post Process Materials）** | 启用此项将导致后期处理材质写入32位质量，而不是16位。 |
| **其他后期处理材质（Additional Post Process Materials）** | 要包含的其他后期处理渲染通道的数组。默认包含MovieRenderQueue_WorldDepth和MovieRenderQueue_MotionVectors。必须启用该材质，通道才能渲染。 |
| **添加默认层（Add Default Layer）** | 创建一个额外的模板层，其中包含模板层（Stencil Layers）数组中尚未包含的所有对象。此默认层将单独渲染，这样你就可以在创建的渲染中排除较小的对象组，以后再重新复合。 |
| **模板层（Stencil Layers）** | 模板层列表，其中包含场景中的很多对象组。此场景将重新渲染所有对象，然后，不包含指定层中的对象的像素将被剪切并变成黑色。随后应用后期处理，并保留使用DoF、动态模糊和TAA的能力。 |

### 后期处理渲染通道

后期处理渲染通道是你可以从延迟渲染器指定的其他渲染通道。**你必须以.exr格式输出**，因为其中有颜色和元数据信息无法通过其他格式显示和解译。

#### 世界深度

**世界深度（World Depth）** 是以世界单位编写的深度，存储在红色通道中。这可以用于在后期制作中重新创建 **景深（Depth of Field）** 。可以从EXR元数据中读取摄像机焦距和快门大小，以自动匹配游戏内的景深。

![世界深度渲染通道](../../../../../assets/images/8e/8e12752db831a275cc60f8832cb62b6efe370c98725dbe357432dff26c009424.jpg)

以下是 **[Nuke ZDefocus2](https://learn.foundry.com/nuke/content/reference_guide/filter_nodes/zdefocus.html)** 节点的示例。此示例将从EXR文件读取元数据，并生成与实时发现的模糊相似的模糊。你必须在粘贴后重新调整focal_point属性，使其正确对WorldDepth纹理采样。

ZDefocus Nuke节点的世界深度

```
	set cut_paste_input [stack 0]	version 12.0 v3	push $cut_paste_input	add_layer {FinalImageMovieRenderQueue_WorldDepth FinalImageMovieRenderQueue_WorldDepth.red FinalImageMovieRenderQueue_WorldDepth.green FinalImageMovieRenderQueue_WorldDepth.blue FinalImageMovieRenderQueue_WorldDepth.alpha}	ZDefocus2 {	z_channel FinalImageMovieRenderQueue_WorldDepth.red	math depth	fill_foreground false	center {{"[metadata exr/unreal/camera/FinalImage/focalDistance]"}}	focal_point {960 540}	size {{"((input.height*(focalLength*focalLength / (fstop * (focalDistance - focalLength)))*.5 / sensorWidth)/10)" x1 26}}	max_size 100	filter_type bladed	legacy_resize_mode false	show_legacy_resize_mode false	blades {{"[metadata exr/unreal/camera/FinalImage/dofDiaphragmBladeCount]"}}	name ZDefocus1	selected true	xpos 959	ypos 229	addUserKnob {20 User}	addUserKnob {7 focalLength l "Focal Length"}	focalLength {{"[metadata exr/unreal/camera/FinalImage/focalLength]"}}	addUserKnob {7 focalDistance l "Focal Distance"}	focalDistance {{"[metadata exr/unreal/camera/FinalImage/focalDistance]"}}	addUserKnob {7 sensorWidth l "Sensor Width"}	sensorWidth {{"[metadata exr/unreal/camera/FinalImage/sensorWidth]"}}	addUserKnob {7 fstop l Fstop}	fstop {{"[metadata exr/unreal/camera/FinalImage/fstop]"}}	} 
```

#### 运动向量

**运动向量（Motion Vectors）** 存储在X和Y为 **0,1** 的坐标上，其中 **0.5, 0.5** 表示无运动。

![运动向量渲染通道](../../../../../assets/images/f1/f142899729cba4f6bc86a7908e45ca792d8c9caa2dc61d06bbc83881e1acfcb2.jpg)

在Nuke中， **[VectorBlur](https://learn.foundry.com/nuke/content/comp_environment/3d_compositing/adding_motion_blur_vectorblur.html)** 节点可用于将运动向量应用至你的图像。虚幻引擎将规格化的运动向量存储到整个屏幕上，这可能与其他渲染包不同。因此，在Nuke VectorBlur节点中，uv_offset设置为-0.5（重新调节为/[-.5, .5/]，而非/[0, 1/]），然后根据图像的宽度来推动动态模糊比例。

VectorBlur Nuke节点的运动向量

```
	set cut_paste_input [stack 0]	version 12.0 v3	push $cut_paste_input	add_layer {FinalImageMovieRenderQueue_MotionVectors FinalImageMovieRenderQueue_MotionVectors.red FinalImageMovieRenderQueue_MotionVectors.green FinalImageMovieRenderQueue_MotionVectors.blue FinalImageMovieRenderQueue_MotionVectors.alpha}	VectorBlur2 {	uv FinalImageMovieRenderQueue_MotionVectors	uv_offset -0.5	blur_type uniform	scale {{input.width}}	soft_lines true	name Unreal_VectorBlur	selected true	xpos 1338	ypos -93	}
```

根据你选择的软件，可能需要分别重新调节运动向量的X和Y通道，因为其他软件可能期望它们采用像素值，而不是根据屏幕规格化。X和Y通道根据屏幕规格化后，具有不同的强度。

### 模板层

使用模板层，可以基于 **[层（Layers）](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)** 中的对象对序列进行分层渲染。

利用模板层，针对每个层重新渲染整个场景，属于一个的Actor会渲染到 **模板缓冲区（Stencil Buffer）** 中。然后，模板缓冲区用于剪切不属于要置于此层上的Actor范围内的像素。优势在于，阴影投射对象可以将阴影投射到其他Actor和层。

一旦渲染到模板缓冲区，应用的后期处理效果将占用每个像素，并将半透明黑色写入到像素中。此过程在半透明之后并在后期处理之前发生，然后将对此层应用后期处理。Alpha通道可以保留，以便在后期制作中了解哪些像素实际受到影响以及受影响程度。

以下是三个模板层和默认层的示例。你可以看到后期处理效果（例如景深）已正确应用，并且前景中的对象已经从背景图像中剪切出来。这些图像可以一起添加回去，从而形成与最终渲染相似的结果，不过这可能需要取消预乘数据。

![模板层渲染通道](../../../../../assets/images/13/130a936332df508e855fde1786737d837d4fcd1443f3365ed9149ed34e442510.png)

以下是Nuke中的示例，该示例对原始图像中的某个指定层应用了简单的色调偏移。渲染原始图像时，在"颜色输出（Color Output）"设置中启用了alpha通道累加，但禁用了色调曲线（Tone Curve）。

![模板层nuke色调](../../../../../assets/images/84/848bf3d4379d583f25c630a243672377fc62f0ed8deac28596a2c3f4b3760e75.png)

要像这样正确重新组合多个图像，图像应该在线性空间中导出（在"颜色输出（Color Output）"设置中禁用"色调曲线（Tone Curve）"）。你应该使用基于OCIO的工作流程来完成这种后期制作工作。

> [!NOTE]
> 模板层不是真正的层系统，因为半透明对象将显示其后面其他层中的不透明对象，并且在前景对象挡信半透明对象时，背景层将显示黑洞。 模板层不支持逐层后期处理材质，因为它们将匹配基础层的额外后期处理材质，并且仅与支持 **自定义深度/模板（Custom Depth/Stencil）** 的材质兼容。

## 路径追踪器

路径追踪器基于 **[路径追踪器](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/path-tracer/index.md)** 渲染方法输出图像。它具有与延迟渲染通道相似的细节。

> 图片已省略：路径追踪器渲染细节

路径追踪器（Path Tracer）渲染模式累加渲染的每个帧的路径数据。这会产生有噪点的图像，因为填充了图像的像素，尤其是当摄像机帧的内容发生显著变化时。

要减少此噪点，你可以在 **抗锯齿（Anti-Aliasing）** 设置中增加 **空间采样（Spatial Samples）** 的数量。

> 图片已省略：路径追踪器空间采样

这将多次渲染图像，并且额外的采样将使路径追踪器更有效地填充空隙。需要大量 **空间采样（Spatial Samples）** 才能有效去除路径追踪器渲染中的噪点，而这会极大增加输出图像所需的时间。

> 图片已省略：增加空间采样抗锯齿属性会减少路径追踪器渲染中的噪点。

**增加空间采样抗锯齿属性会减少路径追踪器渲染中的噪点。**

> [!NOTE]
> 路径追踪器渲染模式当前是试验性质的，目前并非所有材质着色模式都受支持。

## 对象ID

**对象ID（Object Id）** 渲染通道输出一个图像，其中，场景中的每个Actor分配有一个ID。这些ID可以是每个Actor完全唯一的，也可以基于特定属性进行分组。

> 图片已省略：对象ID渲染通道细节

你可以在后期制作套件中使用此图像，以在场景中选择单独的对象，并为这些对象创建遮罩，以便可以有选择地将调整应用到特定对象。

> 图片已省略：原始图像（无后期处理）

> 图片已省略：对象ID通道

原始图像（无后期处理）

对象ID通道

### 设置

对象ID通道需要满足特定要求，才能正确渲染：

1. 对于计划与对象ID通道组合在一起的其他渲染通道，将 **禁用多重采样效果（Disable Multisample Effects）** 。这将排除动态模糊、景深、抗锯齿和其他将混合多个像素层的后期处理，确保所有对象保持清晰的边缘。为了让对象ID通道需要与最终图像正确排队，此设置是必需的。

   > 图片已省略：禁用多重采样效果
2. 在 **延迟渲染器（Deferred Renderer）** 设置下，展开 **其他后期处理材质（Additional Post Process Materials）** 并启用 **MovieRenderQueue_WorldDepth** 和 **MovieRenderQueue_MotionVectors** 材质。

   > 图片已省略：其他后期处理材质
3. 将 **抗锯齿（Anti-aliasing）** 设置添加到你的作业，并将 **空间采样计数（Spatial Sample Count）** 至少设置为 **8** 。还要启用 **覆盖抗锯齿（Override Anti Aliasing）** 并将 **抗锯齿方法（Anti Aliasing Method）** 设置为 **无（None）** 。

   > 图片已省略：对象ID抗锯齿

   这有助于克服不支持TAA的限制。使用 **时间采样计数（Temporal Sample Count）** 不会产生所需的结果，因为每个采样之间缺少可以覆盖缝隙的动态模糊；你最终将得到对象的多个副本，彼此隐约重叠在一起。
4. 将 **.exr序列（.exr Sequence）** 输出模式添加到你的设置，并停用或移除其他所有导出格式。确保 **启用了** **多层（Multilayer）** 属性。

   > 图片已省略：对象ID exr

在完成这些设置后，启动电影渲染队列时，它将输出一个多层EXR，其中包含最终图像、对象ID、世界深度和运动向量。

对象ID使用 **[Cryptomatte](https://github.com/Psyop/Cryptomatte)** 规范存储在EXR文件中，用于读取此数据的插件可用于第三方软件。

> [!NOTE]
> 对象ID渲染通道在虚幻引擎中是试验性质的。仅在虚幻编辑器中可用，不能用于发布版本。

### 对象ID分组

默认情况下，唯一的颜色或ID分配给关卡中的每个Actor或组件。你可以在 **对象ID（Object Ids）** **ID类型（Id Type）** 属性上更改。

> 图片已省略：对象ID组

| ID类型 | 说明 |
| --- | --- |
| **完全（Full）** | 默认行为。将为关卡中所有Actor上应用的每个图元的每个材质创建唯一的ID。 |
| **材质（Material）** | ID将基于其材质或材质实例分组。材质实例将与其父材质分成一组。 |
| **Actor** | ID将按相同Actor实例分组。 |
| **带层级的Actor（Actor With Hierarchy）** | ID将按相同Actor实例分组。不同 **[World Outliner](../../../../building-virtual-worlds/level-editor/outliner/index.md)** 文件夹中的Actor将相对于这些文件夹单独分组。 |
| **文件夹（Folder）** | ID将按 **[World Outliner](../../../../building-virtual-worlds/level-editor/outliner/index.md)** 文件夹中的Actor分组。这些文件夹中的所有Actor将合并为一个ID。 |
| **层（Layer）** | ID将按 **[层（Layers）](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)** 中分配的Actor分组。若Actor属于多个层，可能导致不可靠的结果。 |

### 在后期制作中合并对象ID、深度和速度

可以通过合并多重空间采样、深度和速度，生成与虚幻的后期处理管线相似的结果；通过深度贴图实现的 **景深（Depth of Field）** 和通过速度纹理实现的 **动态模糊（Motion Blur）** 。这样可以使用对象ID遮片来选择对象和颜色以进行更正，然后再应用后期处理通道。

要通过景深和动态模糊保留正确的光亮高光，应在禁用色调曲线的情况下渲染场景。为此，请添加颜色输出（Color Output）项目，并启用 **禁用色调曲线（Disable Tone Curve）** 属性。这将在sRGB色彩空间中输出HDR线性数值。应用景深和动态模糊后，现在可以将其（从线性sRGB）转换为所需的色彩空间。

> 图片已省略：禁用色调曲线

你还必须将 **速度路径（Velocity Path）** 设置为 **在基础通道期间写入（Write during base pass）** 。为此，在虚幻引擎主菜单中找到 **编辑（Edit）> 项目设置（Project Settings）> 引擎（Engine）> 渲染（Rendering）** ，并将 **速度路径（Velocity Path）** 设置为 **在基础通道期间写入（Write during base pass）** 。 更改此项目设置后，必须重启编辑器。

> 图片已省略：在基础通道期间输出速度

此外，`r.BasePassForceOutputsVelocity` 变量必须设置为1。你可以通过编辑/Engine/Config/ConsoleVariables.ini，在引擎范围内执行此操作，也可以在渲染期间将其作为 **控制台变量（Console Variable）** 应用。

> 图片已省略：基础通道控制台命令

以下是一个示例Nuke图表，该图表使用了上述ZDefocus和VectorBlur节点。对于要在Nuke中使用的速度纹理，需交换其红色和绿色通道（以下图表中的RG_TO_GR，使用ShuffleCopy节点）。

该Nuke图表利用8次空间采样、对象ID通道、运动向量和世界深度来渲染exr。景深信息是自动从exr元数据中提取的。Cryptomatte节点可用于创建牛顿摆设备的遮罩，然后用作单次色调偏移的遮罩。应用色调偏移之后，将会应用此前提及的ZDefocus节点，然后应用VectorBlur。

> 图片已省略：nuke图表示例

ObjectID、ZDefocus和VectorBlur Nuke节点

```
	set N56cf6800 [stack 0]	add_layer {ActorHitProxyMask00 ActorHitProxyMask00.red ActorHitProxyMask00.green ActorHitProxyMask00.blue ActorHitProxyMask00.alpha}	add_layer {ActorHitProxyMask01 ActorHitProxyMask01.red ActorHitProxyMask01.green ActorHitProxyMask01.blue ActorHitProxyMask01.alpha}	add_layer {ActorHitProxyMask02 ActorHitProxyMask02.red ActorHitProxyMask02.green ActorHitProxyMask02.blue ActorHitProxyMask02.alpha}	Cryptomatte {	name Cryptomatte1	xpos 66	ypos -87	matteOutput alpha	matteList LivingRoom/CoffeeTable/BP_NewtonsCradle.NewtonsCradle	cryptoLayer ActorHitProxyMask	expression "((ActorHitProxyMask00.red == 30057640.0) ? ActorHitProxyMask00.green : 0.0) + ((ActorHitProxyMask00.blue == 30057640.0) ? ActorHitProxyMask00.alpha : 0.0) + ((ActorHitProxyMask01.red == 30057640.0) ? ActorHitProxyMask01.green : 0.0) + ((ActorHitProxyMask01.blue == 30057640.0) ? ActorHitProxyMask01.alpha : 0.0) + ((ActorHitProxyMask02.red == 30057640.0) ? ActorHitProxyMask02.green : 0.0) + ((ActorHitProxyMask02.blue == 30057640.0) ? ActorHitProxyMask02.alpha : 0.0) + 0"	keyedName ""	previewExpression0 "((mantissa(abs(ActorHitProxyMask00.red)) * 1 % 0.25) * ActorHitProxyMask00.green + (mantissa(abs(ActorHitProxyMask00.blue)) * 1 % 0.25) * ActorHitProxyMask00.alpha + (mantissa(abs(ActorHitProxyMask01.red)) * 1 % 0.25) * ActorHitProxyMask01.green + (mantissa(abs(ActorHitProxyMask01.blue)) * 1 % 0.25) * ActorHitProxyMask01.alpha)"	previewExpression1 "((mantissa(abs(ActorHitProxyMask00.red)) * 16 % 0.25) * ActorHitProxyMask00.green + (mantissa(abs(ActorHitProxyMask00.blue)) * 16 % 0.25) * ActorHitProxyMask00.alpha + (mantissa(abs(ActorHitProxyMask01.red)) * 16 % 0.25) * ActorHitProxyMask01.green + (mantissa(abs(ActorHitProxyMask01.blue)) * 16 % 0.25) * ActorHitProxyMask01.alpha)"	previewExpression2 "((mantissa(abs(ActorHitProxyMask00.red)) * 64 % 0.25) * ActorHitProxyMask00.green + (mantissa(abs(ActorHitProxyMask00.blue)) * 64 % 0.25) * ActorHitProxyMask00.alpha + (mantissa(abs(ActorHitProxyMask01.red)) * 64 % 0.25) * ActorHitProxyMask01.green + (mantissa(abs(ActorHitProxyMask01.blue)) * 64 % 0.25) * ActorHitProxyMask01.alpha)"	previewExpression3 ""	previewChannel none	in00 ActorHitProxyMask00	in01 ActorHitProxyMask01	in02 ActorHitProxyMask02	in03 none	in04 none	in05 none	in06 none	in07 none	in08 none	in09 none	in10 none	in11 none	}	push $N56cf6800	Dot {	name Dot1	xpos 13	ypos -171	}	Dot {	name Dot2	xpos 13	ypos -32	}	HueShift {	inputs 1+1	saturation 2.32	color_saturation 0.94	hue_rotation 88	name HueShift1	xpos 66	ypos -36	}	Dot {	name Dot3	xpos 194	ypos -32	}	Dot {	name Dot4	xpos 194	ypos -206	}	add_layer {FinalImageMovieRenderQueue_WorldDepth FinalImageMovieRenderQueue_WorldDepth.red FinalImageMovieRenderQueue_WorldDepth.green FinalImageMovieRenderQueue_WorldDepth.blue FinalImageMovieRenderQueue_WorldDepth.alpha}	ZDefocus2 {	z_channel FinalImageMovieRenderQueue_WorldDepth.red	math depth	fill_foreground false	center {{"[metadata exr/unreal/camera/FinalImage/focalDistance]"}}	focal_point {960 540}	size {{"((input.height*(focalLength*focalLength / (fstop * (focalDistance - focalLength)))*.5 / sensorWidth)/10)" x1 26}}	max_size 100	filter_type bladed	legacy_resize_mode false	show_legacy_resize_mode false	blades {{"[metadata exr/unreal/camera/ActorHitProxyMask/dofDiaphragmBladeCount]"}}	name ZDefocus1	xpos 296	ypos -216	addUserKnob {20 User}	addUserKnob {7 focalLength l "Focal Length"}	focalLength {{"[metadata exr/unreal/camera/FinalImage/focalLength]"}}	addUserKnob {7 focalDistance l "Focal Distance"}	focalDistance {{"[metadata exr/unreal/camera/FinalImage/focalDistance]"}}	addUserKnob {7 sensorWidth l "Sensor Width"}	sensorWidth {{"[metadata exr/unreal/camera/FinalImage/sensorWidth]"}}	addUserKnob {7 fstop l Fstop}	fstop {{"[metadata exr/unreal/camera/FinalImage/fstop]"}}	}	set N62ca2800 [stack 0]	push $N62ca2800	add_layer {FinalImageMovieRenderQueue_MotionVectors FinalImageMovieRenderQueue_MotionVectors.red FinalImageMovieRenderQueue_MotionVectors.green FinalImageMovieRenderQueue_MotionVectors.blue FinalImageMovieRenderQueue_MotionVectors.alpha}	ShuffleCopy {	inputs 2	in FinalImageMovieRenderQueue_MotionVectors	in2 none	red green	green red	out FinalImageMovieRenderQueue_MotionVectors	name RG_TO_GR	xpos 296	ypos -178	}	Add {	value -0.5	name Subtract_05	xpos 296	ypos -152	}	Multiply {	channels FinalImageMovieRenderQueue_MotionVectors	value {0.5625 1 1 1}	name MultiplyByAspectRatio	xpos 296	ypos -114	}	Add {	value 0.5	name Add_05	xpos 296	ypos -76	}	VectorBlur2 {	uv FinalImageMovieRenderQueue_MotionVectors	mv_presets "V-Ray Velocity"	uv_offset -0.5	blur_type uniform	scale {{width}}	soft_lines true	maskChannelInput FinalImageMovieRenderQueue_WorldDepth.red	name VectorBlur3	xpos 296	ypos -38	}	Viewer {	frame 1	frame_range 1-100	colour_sample_bbox {0.8895833492 -0.2208333313 0.890625 -0.2197916657}	samplepoints {{0.8895833492 -0.2208333313}	}	name Viewer1	xpos 292	ypos 12	}
```

此外，由于虚幻引擎会存储X和Y中规格化为[0-1]的运动向量，你需要将红色通道重新调节为ImageHeight和ImageWidth（在此示例中为1080、1920）或0.5625。要执行此重新调节，请从速度通道减去0.5，乘以0.5625，然后将0.5加回速度通道，再将其插入VectorBlur节点。如果不重新调节红色通道，动态模糊的角度就会不正确。

与模板层一样，该功能旨在与基于OCIO的工作流程一起使用。景深必须应用于线性空间中的图像，以便确定哪些高光光亮得足以创建散景。禁用色调曲线后，图像的外观会改变。使用基于OCIO的工作流程，你可以直观地查看视口中的最终外观，并在后期制作中将外观重新应用到你的图像，以重新创建外观。

> [!NOTE]
> 如果你想试用Nuke节点创建功能，可以从以上示例 **[下载帧和nuke文件](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/85463f6c-47df-461b-878a-4ccab6a9ae30/objectidcomboexample.zip)** 。

## UI渲染器

**UI渲染器（UI Renderer）** 将作为含有alpha的单独输出添加到视口的 **[Slate](../../../../user-interfaces/slate-user-interface-programming-framework/index.md)** 或 **[UMG](../../../../user-interfaces/umg-editor-reference/index.md)** 控件。你可以将此功能与合成程序中的最终图像结合使用，从而添加你想渲染的UI元素。

## VT待处理Mip

VT（[虚拟纹理](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/index.md)待处理Mip是设计为与[预流送录制器](../cinematic-render-settings-and-formats/cinematic-rendering-export-formats/index.md#%E9%A2%84%E6%B5%81%E9%80%81%E5%BD%95%E5%88%B6%E5%99%A8)一起使用的渲染通道。该通道将虚拟纹理mip调试帧导出到你的输出目录，可用于调试你的预流送缓存。

> [!NOTE]
> 该调试渲染通道不会显示Nanite几何体上的虚拟纹理信息。如果你要使用大量Nanite几何体，请使用 `r.nanite 0` 控制台命令，这样会将所有网格体恢复为非Nanite版本，调试信息也更易于辨识。

---
title: "GPU Lightmass全局光照"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gpu-lightmass-global-illumination-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "全局光照", "GPU Lightmass全局光照"]
---

# GPU Lightmass全局光照

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 全局光照 / GPU Lightmass全局光照

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gpu-lightmass-global-illumination-in-unreal-engine

GPU Lightmass (GPULM)是一种光照烘焙解决方案，它可以预计算移动性设置为静止（Stationary）或静态（Static）的光源的复杂光线交互，并将这些数据保存在生成的光照贴图纹理中，这些纹理又转而应用到场景几何体。这个将光照烘焙到纹理中的系统类似于基于CPU的[Lightmass全局光照](../cpu-lightmass-global-illumination/index.md)系统。然而，使用GPU来生成和构建光照数据意味着我们可以利用DirectX 12 (DX12)和微软DXR框架的最新光线追踪功能。

GPULM大大减少了计算、构建和生成复杂场景光照数据所需的时间，其速度可与基于CPU的Lightmass使用Swarm进行分布式构建时的速度相媲美。此外，GPULM提供具有交互性的新工作流，可以实时编辑场景、重新计算和重新构建光照。基于CPU的Lightmass系统无法使用此工作流。

## 启用GPU Lightmass

按照以下步骤，在项目中启用GPU Lightmass：

1. 从 **编辑器（Editor）> 插件（Plugins）** 菜单打开 **插件（Plugins）** 浏览器。在 **内置（BUILT-IN）> 编辑器（Editor）** 类别下，找到并启用 **GPU Lightmass** 。

   ![启用GPU Lightmass插件](../../../../../assets/images/d7/d73404e0b3427467b320e39d3b3e614002170818cec486549744d792d74326aa.jpg)

   > [!TIP]
   > 启用GPU Lightmass之后，虚幻编辑器会提示你重启。为了节省时间，在重启编辑器之前，请修改以下项目设置。
2. 从 **编辑器（Editor）> 项目设置（Project Settings）** 菜单打开 **项目设置（Project Settings）** 窗口：

   1. 在

      引擎（Engine）> 渲染（Rendering）

      类别下，启用以下项目：

      1. **硬件光线追踪（Hardware Ray Tracing） > 支持硬件光线追踪（Support Hardware Ray Tracing）**

         ![支持硬件光线追踪切换开关](../../../../../assets/images/1f/1fb881c6434dda569e316ed7a63987c49923a0db4887c3483eecd31e0f250b47.png)

         > [!NOTE]
         > GPU Lightmass无需用到 **光线追踪阴影（Ray Traced Shadows）** 和 **光线追踪天空光照（Ray Traced Skylight）** 。除非项目需要这些功能，否则请关闭它们。
      2. 虚拟纹理（Virtual Textures）

         >

         启用虚拟纹理支持（Enable Virtual Texture Support）
      3. 虚拟纹理（Virtual Textures）

         >

         启用虚拟纹理光照贴图（Enable Virtual Texture Lightmaps）
   2. 在

      平台（Platforms）> Windows

      类别下，进行以下设置：

      1. 目标RHI（Targeted RHIs） > 默认RHI：DirectX 12（Default RHI: DirectX 12）
3. **重启** 编辑器，使这些更改生效。

### 设置GPU Lightmass的其他要求

以下是在项目中使用GPU Lightmass时的其他建议。

### 减少GPU超时检测和崩溃恢复

在复杂场景或情况下，GPU负载过重可能会导致超时或崩溃，通常还会导致使用该GPU的软件关闭，例如虚幻引擎。一般会看到如下信息：

![GPU驱动器崩溃错误消息](../../../../../assets/images/64/6433058294b3e6c35a3e656bb06feaf536c183d286e8f5ad51953fd254a91fb8.png)

可以通过延长GPU的超时延迟来防止此类崩溃，给它时间恢复而不会导致引擎关闭。

有关在Windows 10中调整超时延迟和恢复设置的详细信息，请参阅[电影渲染队列](../../ray-tracing-and-path-tracing-features/rendering-high-quality-frames-with-movie-render-queue/index.md)中诸如此类事宜。

#### 禁用实时光线追踪功能

> [!NOTE]
> 光线追踪功能需要Windows 10开发环境、DirectX 12和支持光线追踪的NVIDIA GPU。 如需更多信息，请参阅我们的[光线追踪](../../ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)功能文档，获取完整的要求列表。

GPU Lightmass利用微软的DXR API来实现光线追踪，而且需要用到DirectX 12。虽然GPU Lightmass需要用到光追才能工作，但它并不需要用到其他光线追踪功能（默认会启用），例如光追阴影、环境光遮挡、以及反射。

相反，最好是禁用所有这些功能，除非你确实想将这些光追功能与烘焙光一起用。如果你想让光追功能与烘焙光一起用，你可以让场景同时包含静态光和动态光。使用以下命令来禁用光追效果。

```
	r.RayTracing.ForceAllRayTracingEffects 0 
```

或者，你可以在项目中进行设置，以便在加载时自动禁用所有光线追踪功能，方法是将它们添加到项目配置目录中的 **DefaultEngine.ini** 配置文件中。在 `[/Script/Engine.RendererSettings]` 中添加代码，使其看起来如下所示：

```
	[/Script/Engine.RendererSettings]	r.RayTracing.ForceAllRayTracingEffects=0 
```

#### 配置GPU内存

GPULM要求有足够的GPU内存支付它的开销。考虑到这一点，下述考量是成功使用GPULM烘焙复杂场景的一个因素：

- 必须有足够的GPU内存，以便在细节级别（LOD）最低的情况下保存整个场景，相当于以最高品质的LOD来保存场景。

  > [!NOTE]
  > 烘焙时，GPULM目前未将LOD纳入考量。详情请参阅本页面的[GPU Lightmass的限制](#gpulightmass%E7%9A%84%E9%99%90%E5%88%B6)部分。
- 在光源构建期间，虚拟纹理系统可能需要大量内存。这很大程度上取决于场景的复杂性以及大小。
- 必须有足够的CPU内存，将所有生成的光照贴图都存储到RAM中。GPU可以将光照贴图置换到CPU的RAM中，但仅在整个光照烘焙完成之后，光照贴图才会保存到磁盘上。
- DX12使用的GPU内存通常比DX11多。如果某个场景挑战了DX11中GPU内存的极限，你可能会发现，在使用光线追踪和虚拟纹理产生的额外开销下，如果不做出一些取舍，这个场景很难在DX12中使用。
- 对于可选设置，比如

  Irradiance Cache

  ，GPULM有自己的内存使用要求。

> [!NOTE]
> 对于大型场景，基于CPU的Lightmass系统需要大量的内存，这可能会给光照烘焙带来麻烦。使用Swarm的分布式构建通常可以缓解这类问题。如果使用GPULM，内存耗尽时唯一的解决方案（目前）是通过减少几何或纹理细节来优化场景，或升级到内存更多的GPU。

##### 使用虚拟纹理光照贴图在编辑器内预览

启用[虚拟纹理](../../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/index.md)系统和虚拟纹理光照贴图可以生成光照贴图并将其存储为虚拟纹理。这还有一个好处，即光源构建可以在关卡视口中实时更新。它还允许在构建场景时进行编辑，而不必取消或等待构建完成。

> [!NOTE]
> 如果只是单纯地构建光照，那么GPULM并不需要启用虚拟纹理系统，但要实现交互和实时编辑功能的话，就需要启用了。如果不打算在项目中使用虚拟纹理，或者不需要交互式预览，你可以放弃启用这些功能，这样在编辑器中工作时可以节省一些开销。

#### 为光照构建启用多GPU支持

> [!WARNING]
> 多GPU支持需要系统为Windows 10 2004版本或更新版本。

当使用同时支持光线追踪的基于NVIDIA SLI的GPU时，支持多个GPU来计算项目的照明。多GPU支持是通过以下方式实现的。

- GPU必须用NVLink网桥连接，并且必须在NVIDIA控制面板中启用SLI。
- 在你的

  [引擎安装路径]/Engine/Config

  文件夹中的虚幻引擎

  DefaultEngine.ini

  文件中，在

  [/Script/Engine.RendererSettings]

  部分下添加

  r.AllowMultiGPUInEditor=1

  。
- 在启动编辑器时，传入命令行参数 `-MaxGPUCount=[n]` ——其中 **n** 是SLI可用的GPU数量。例如，`-MaxGPUCount=2` 表示在多GPU模式下使用两个GPU来计算光照。

  > [!TIP]
  > 你也可以为 UE4Editor.exe 创建一个快捷方式，在 **属性** 设置中，在 **目标** 行中添加 `-MaxGPUCount=[n]` 。
  >
  > ![UnrealEditor.exe属性设置](../../../../../assets/images/89/89baa6d850b7d96e1ee2c89e6cb4cd252d9263aff8daab4f9afb130f591212de.png)

编辑器启动后，你可以打开 **输出日志（Output Log）** 并在日志中搜索消息来确认你是否使用了多GPU模式。

```
	 LogD3D12RHI：为包含2个节点系统启用多GPU支持 
```

使用多个GPU时，构建所需的平均时间将会减少。例如，在测试中型场景时（使用两张RTX-2080TI显卡），我们发现在没有大量使用体积光照贴图时，构建时间平均快了约1.7倍。构建完成速度的提高取决于许多因素，如场景大小和复杂度、引擎功能对多GPU的支持，以及当前使用的GPU数量。

GPU Lightmass的多GPU支持非常适合建筑和虚拟制片类型的场景（这些场景通常只依赖单个场景）。大型游戏大小的关卡可能会遇到内存和虚拟纹理的限制，这取决于其复杂性和GPU上可用的VRAM数量。如果建筑和虚拟生产环境的设计和设置有很大的复杂性，就有可能达到与游戏大小关卡相同的限制。 多GPU的限制：

- 体积光照贴图

  计算还不支持。有大量体积光影图计算的场景将看到较少的整体性能提升。
- 辐照度（Irradiance）缓存是在每个GPU上本地生成的。根据内容的不同，你可能会在不同的烤漆瓦片之间有轻微的阴影差异。这可以通过提高

  辐照度缓存质量

  ，或完全禁用

  使用辐照度缓存

  来解决。
- 纹理编码和去噪是在CPU上运行的，不受多GPU的影响。

## 使用GPU Lightmass

GPULM有自己的面板，可通过关卡编辑器的工具栏访问，在 **构建（Build）** 下拉菜单下选择 **GPU Lightmass** 即可。

![显示GPU Lightmass选项的工具栏构建下拉菜单](../../../../../assets/images/e9/e9a80b1d7284a55e14b698b5181f016f2c75dd193d36145cb66eb896e7068076.jpg)

GPU Lightmass面板可以停靠在编辑器内，类似于其他面板。

![GPU Lightmass设置已停靠](../../../../../assets/images/10/1074c5e150d6dc349f9cd8bab8bd1e093d70e00e401e7c569f3738629855e881.png)

配置完设置之后，按 **构建光照（Build Lighting）** 开始烘焙。

![GPU Lightmass面板构建光照按钮](../../../../../assets/images/80/80d63331776587be63e4e11084879675ea070e410fd6015c0ffa3a9f38efb1ac.png)

> [!TIP]
> 请使用 **视口实时（Viewport Realtime）** 勾选框来启用视口实时模式。视口禁用实时模式后，GPU Lightmass构建光照的速度会明显加快。详情请参见本文的[使用GPU Lightmass速度模式](#%E4%BD%BF%E7%94%A8gpulightmass%E9%80%9F%E5%BA%A6%E6%A8%A1%E5%BC%8F)。
>
> ![GPU Lightmass面板实时视口切换开关](../../../../../assets/images/96/96f1578b6f88c9c968eb0da4cc5782b199b0d269d2f5020d63b53304e30f24b1.png)

### GPU Lightmass烘焙模式

GPULM包括两种光照烘焙模式：**完全烘焙（Full Bake）** 和 **烘焙所见内容（Bake What You See(BWYS)）** 。

> 图片已省略：GPU Lightmass烘焙模式下拉菜单

- 完全烘焙（Full Bake）

  模式下，在计算和构建光照时，将为场景中的每个对象渲染完整的光照贴图分辨率。在构建完成之前结果不可见。
- 烘焙所见内容（Bake What You See）

  模式更为灵活，仅构建视口内可见内容的光照，而非整个场景。启用视口的实时模式后，还可在光源构建过程中进行交互，在进行更改时重新计算光照。

这两种烘焙模式都依赖于视图，这意味着它们在移动到场景中的其他对象之前，都会优先考虑视图中的对象。

在完全烘焙模式下，GPULM使用以下流程：

- 将处理场景中的所有对象，优先处理当前视图中的对象。
- 以对象的完整光照贴图分辨率在纹理空间内烘焙光照。已完成的光照贴图将发送到虚拟纹理系统以更新显示。
- 一旦计算了所有对象并渲染了光照贴图，就进行编码并自动保存数据。

烘焙所见内容模式的交互方式是非破坏性的，可在场景中实时计算（和重新计算）光照结果。它鼓励在场景中正在积极处理光照的区域内动态地进行调整。由于这种交互性，光源构建的工作流在以下方面区别于完全烘焙：

- 运行时虚拟纹理系统确定在界面上解析所需的mipmap级别的可见图块。
- 光照在纹理空间内以各个图块在摄像机视图中的解析mipmap分辨率进行烘焙。
- 界面上的所有图块完成后，BWYS无限期等待场景或视口摄像机更新。
- 按

  保存（Save）

  按钮开始对最终光照贴图进行编码。如果你选择保存结果，就不会为场景生成完整的光照构建；只有界面上可见的部分场景已准备好存储和保存其光照数据。
- 按下保存键并不会结束光照烘焙，它会保存目前为止生成的所有已编码光照贴图数据。按

  取消（Cancel）

  才会停止此流程。

#### 交互式烘焙

交互式烘烤随时可用于完全烘焙和BWYS模式，优先处理已映射到当前摄像机视图的可见虚拟纹理图块；移动摄像机会重新优先处理当前视图的图块。当交互式烘焙用于两种光照烘焙模式时，它的主要用于与"只烘焙所见内容"（BWYS）模式结合使用。

启动BWYS模式会启动光照构建，仅在手动停止时才会完成。此模式仅考虑摄像机视图中的对象并为其构建光照。在场景中四处移动摄像机，更改位置或从场景中添加/移除对象，或更改场景Actor的属性，都会导致重新实时计算光照。由于此模式需要手动保存光照结果，如果之前已经为场景构建了光照，可以选择这种非破坏性的工作方式。

#### 使用GPU Lightmass速度模式

GPULM的一个优势是，它在光照烘焙期间会利用虚拟纹理。这样就可以在编辑器视口中实时构建和显示光照。如果场景此时正在编辑，GPULM也会逐步工作，相应地更新场景光照。实时使用编辑器内预览的缺点是，在场景中重新渲染帧以更新可见结果会产生额外开销。禁用此开销会释放GPU内存，使其更高效更快速。

关卡视口的 **实时** 模式控制着GPULM的两种运行速度：

- 当模式为

  开（On）

  时，使用

  慢（Slow）

  模式，此时需要实时渲染帧，会带来额外的开销。
- 当模式为

  关（Off）

  时，由于免去了实时渲染场景带来的开销，所以能大大加快光照渲染速度。

要切换 **实时（Realtime）** 模式的开关状态，可以使用以下方法：

- 使用GPU Lightmass面板的实时视口复选框来切换视口的实时模式。

  > 图片已省略：GPU Lightmass面板实时视口切换开关
- 使用关卡视口的下拉菜单来切换 **实时** 模式。

  > 图片已省略：关卡视口实时切换开关
- 使用键盘快捷键 **Ctrl + R** 。

除了视口的实时模式切换，GPULM还提供了设置，通过内置参数来增加光照构建模式。

> 图片已省略：GPU Lightmass构建速度设置

- 实时负载系数（Realtime Workload Factor）

  是一个乘数，当

  实时（Realtime）

  模式在视口中切换成

  开（On）

  时，可以提高光照构建速度。此值过高时，若场景中有大量几何体，编辑器会反应迟钝。
- 非实时负载系数（Non-Realtime Workload Factor）

  是一个乘数，当

  实时（Realtime）

  模式切换成

  关（Off）

  时，可以提高光照构建速度。

> [!WARNING]
> **负载系数（Workload Factor）** 选项并不能保证你的构建会立即变快，请谨慎使用。乘数决定了发送到GPU的工作数据块的大小，这个大小的有效性是决定GPU最终速度的众多因素之一。例如，在某些项目中，增大 **非实时负载系数（Non-Realtime Workload Factor）** 会使快速烘焙变慢。在设置上，没有普适性的硬性规则。

### GPU Lightmass设置

GPU Lightmass自己的面板中就包含其大部分设置。

> 图片已省略：GPU Lightmass面板

| 属性 | 说明 |
| --- | --- |
| 一般 |  |
| **显示进度条（Show Progress Bars）** | 若为true，则渲染时每个图块内都会绘制一个绿色进度条。红条表示 **第一反射光线引导（First Bounce Ray Guiding）** 正在进行中。在非常明亮的场景中，条的曝光值会调低，可能会显示为黑色。 |
| **模式（Mode）** | 根据你的开发需求选择最适合的烘焙模式： **完全烘焙（Full Bake）：** 此模式为场景中的每个对象渲染全光照贴图分辨率。 **烘焙所见内容（Bake What You See）：** 此模式仅以虚拟纹理系统确定的mip级别渲染视图中对象的虚拟纹理图块。可以移动摄像机以渲染更多图块。此模式下，仅在按 **保存（Save）** 按钮时才会保存结果。 |
| 降噪 |  |
| **降噪时间（Denoise when）** | 启用后，在CPU上，降噪会在渲染完成后进行。当你选择光照贴图烘焙的降噪何时应该发生时，请在下列选项中选择： **无（None）：** 不对光照贴图进行任何降噪处理。 **完成时（On Completion）：** 烘焙完成后对整个光照贴图进行降噪处理。 **交互式预览期间（During Interactive Preview）：** 每个图块在完成时进行降噪处理，适用于预览场景的各个部分，但效率较低。 |
| **降噪器（Denoiser）** | **Intel开放图像降噪（Intel Open Image Denoise）：** 默认选项使用[Intel开放图像降噪](https://www.openimagedenoise.org/)库减少渲染的输出中的总体残余噪点数量。 **简单萤火虫删除器（Simple Firefly Remover）：** 一种替代降噪器，专门针对萤火虫瑕疵，或者有时由小型强光源导致的过度明亮的斑点。 |
| 全局光照 |  |
| **GI样本（GI Samples）** | 在表面上的所有反射中，针对每个纹素所执行的光线路径总数。应设为降噪器能得到无伪影结果时的最低值。 |
| **静止光源阴影样本（Stationary Light Shadow Samples）** | 移动性设置为 **静止（Stationary）** 的光源的样本数量。阴影的计算和存储独立于全局光照。 |
| **使用辐照强度缓存（Use Irradiance Caching）** | 室内场景可启用此设置，实现物理意义上更正确的全局光照强度（稍有偏差）。若不启用此设置，结果可能会比预期更暗一些。针对室外场景禁用。 |
| **使用第一反射光线引导（First Bounce Ray Guiding）** | 启用 **使用辐照强度缓存（Use Irradiance Caching）** 后，此选项在每个首次反射样本上搜索半球体，以找到最亮的方向来衡量其余样本的朝向。它改善了室内场景中特定光源的效果，比如窗户。此通道的质量由 **试用样本（Trial Samples）** 设置控制。 |
| 体积光照贴图 |  |
| **质量乘数（Quality Multiplier）** | 允许你将更多全局光照示例分配到体积光照贴图中，减少噪点。 |
| **细节单元大小（Detail Cell Size）** | 设置在场景中几何体周围使用的最高密度的体积光照贴图体素的大小，以世界空间单位计。 |
| 辐照强度缓存 |  |
| **质量（Quality）** | 每个辐照强度缓存单元的样本数量。 |
| **防止严重泄露（Agressive Leak Prevention）** | 启用后，使用辐照强度缓存背面检测来防止光泄露，代价是萤火虫更多、速度更慢。辐照强度缓存质量>=256时推荐启用。 |
| **大小（Size）** | 每个辐照强度缓存单元的大小。尺寸越小越慢，但也越精确。 |
| **角落抑制（Corner Rejection）** | 能够更好地控制对角落周围的辐照强度缓存条目的抑制，帮助减少可能发生的漏光和伪影。 |
| **调试：可视化（Debug: Visualize）** | 启用后，辐照强度缓存单元将可见，有助于设置辐照强度缓存单元的大小及其质量。在非常明亮的场景中，曝光值会调低，可视化效果可能会显示为黑色。 |
| 第一反射光线引导 |  |
| **试用样本（Trial Samples）** | 用于 **第一反射光线引导（First Bounce Ray Guiding）** 的样本数量，在进行光照采样之前会扔掉。 |
| 系统 |  |
| **实时工作负载因子（Realtime Workload Factor）** | 在视口启用了 **实时（Realtime）** 模式的情况下，此设置可使用此乘数控制烘焙速度。 |
| **非实时工作负载因子（Non-Realtime Workload Factor）** | 在视口禁用了 **实时（Realtime）** 模式的情况下，此设置可使用此乘数控制烘焙速度。 |
| **光照贴图图块池大小（Lightmap Tile Pool Size）** | GPU Lightmass管理的可见图块池，用于计算。应根据视口大小和界面上一次显示的图块数量来设置此池的大小。增加池大小会增加GPU内存使用率。 |

> [!WARNING]
> **体积光照贴图细节单元大小（Volumetric Lightmap Detail Cell Size)** 设定了场景中几何体周围最高密度的体积光照贴图体素。减少体素大小会增加光照构建时间以及内存占用。某些情况下，它可能将内存占用增加到8倍之多。
>
> > 图片已省略：体积光照贴图细节单元大小

#### 设置光照贴图UV及其分辨率

烘焙光照要求每个静态网格体都有自己的光照贴图UV，UV图表（也称UV岛）都包含在0-1纹理空间内，没有重叠或包装块。这可确保在计算光照时，不会因为光照贴图UV不佳而产生伪影。

> [!NOTE]
> 若要了解有关设置光照贴图UV以及在虚幻引擎中生成光照贴图UV的更多信息，请查看以下页面：
>
> - 展开光照贴图的UV
> - 自动生成光照贴图UV

要获得对象几何体的高质量光照烘焙，第一步就是设置一个良好的光照贴图UV。接下来，务必确保应用于几何体的光照贴图纹理有足够的分辨率来捕捉所有必要的光照和阴影细节。这意味着酌情改变每个对象的光照贴图分辨率。有两种方法可以做到这一点：

- 通过 **静态网格体编辑器** 设置对象的 **光照贴图分辨率（Light Map Resolution）** 。

  > 图片已省略：静态网格体编辑器光照贴图分辨率设置
- 或者在场景中选择一个 **静态网格体Actor** ，然后在 **细节** 面板的 **光照（Lighting）** 分类下，使用此Actor的 **覆盖光照贴图分辨率（Overridden Light Map Res）** 属性为此Actor设置新的光照贴图分辨率。

  > 图片已省略：细节面板中的覆盖光照贴图分辨率属性

#### 控制光线反射次数

任何给定场景中的光线反射次数都是不可控的。GPULM使用[俄罗斯轮盘](http://www.pbr-book.org/3ed-2018/Monte_Carlo_Integration/Russian_Roulette_and_Splitting.html)算法，考虑到各种可能性和权重计算，确定投射的任何给定光线会发生多少次反射。这也意味着不太可能对间接光照和场景照明做出贡献的光反射更有可能被终止。

> [!NOTE]
> GPULM的 **GI样本（GI Samples）** 属性控制每个体素（或纹理贴图中的像素）的路径追踪片段的最大数量，包括空间样本和反射片段。增加GI采样数量时，空间采样和深度采样（有可能）的数量也将增加。

#### 选择降噪选项

GPULM依赖于由[Intel的开放图像降噪库](https://www.openimagedenoise.org/)提供的降噪方法来去除噪声，使最终光照贴图渲染结果流畅。

考虑对光照烘焙进行降噪时，有三种方法可供选择。使用 **降噪（Denoising）** 下拉菜单进行选择：

> 图片已省略：GPU Lightmass降噪设置选项下拉菜单

- 无（None）

  ，不对光照渲染应用降噪。这可用于确定特定场景中使用的

  Gi样本

  数量。例如，如果你发现降噪器正在引入伪影，增加样本和可能的其他设置，如辐照强度缓存（Irradiance Cache）和第一反射光线引导（First Bounce Ray Guiding），可以为降噪器提供更高质量的输入。
- 完成时（On Completion）

  会在渲染之后在CPU上对光源构建结果进行降噪。它会在光源构建完成后对整个场景的光照贴图进行降噪。
- 交互式预览期间（During Interactive Preview）

  在各个虚拟纹理图块完成时对其进行降噪。这有助于更快看到最终结果，但效率较低，因为它需要将各个图块从GPU转移到CPU上执行降噪处理，然后再返回GPU进行显示。

以下是已完成光源构建在应用和未应用降噪情况下的对比。

> 图片已省略：禁用降噪

> 图片已省略：最终添加降噪效果

禁用降噪

最终添加降噪效果

## GPU Lightmass的限制

> [!WARNING]
> 以下是当前实现GPULM的部分已知限制。此列表并不详尽，只是让你对核心功能的支持有一个大致的了解。请记住，此列表中的某些功能可能永远不会受到支持，但很多功能会在未来的引擎版本中得到解决。

| 功能 | 支持（是/否/部分） | 说明 |
| --- | --- | --- |
| **分布式烘焙（Distributed Baking）** | 否 | 目前尚无计划为GPULM支持Swarm Agent的分布式构建。当下的策略是专注于支持多种GPU，并依赖于它们的功率和内存容量。 |
| **多GPU（Multiple GPU）** | 是 | 需要支持NVLink或SLI的NVIDIA显卡。 |
| **半透明阴影（Translucent Shadows）** | 是 | 现在支持半透明阴影以及带有颜色的半透明阴影。 |
| **世界场景位置偏移（World Position Offset）** | 否 |  |
| **像素深度偏移（Pixel Depth Offset）** | 否 | GPULM不考虑支持PDO，因为它会导致光照不连续。 |
| **固定天空光照（Stationary Sky Light）** | 否 | 已计划在未来引擎版本中支持。 |
| **光照通道（Lighting Channels）** | 否 |  |
| **光照场景（Lighting Scenarios）** | 是 |  |
| **光源的自定义设置和属性（Custom Settings and Properties of Lights）** | 否 | 以下光源设置尚不支持GPULM： 间接光照强度 源纹理（矩形光源例外） 其中一些设置可以部分配合 **静止（Stationary）** 光源使用。烘焙的GI不会调用此功能，但光源的动态直接光照会调用此功能。 |
| **预计算的环境光遮挡（Precomputed Ambient Occlusion）** | 否 |  |
| **Lightmass门户（Lightmass Portals）** | 否 | 这部分是由GPULM的第一反射光线引导（First Bounce Ray Guiding）属性处理的。 |
| **Lightmass重要体积（Lightmass Importance Volume）** | 部分 | 这些体积不用于区分场景区域以控制质量。它们用于确定体积光照贴图的位置。 |
| **体积光照贴图（Volumetric Lightmaps）** | 是 | 这些光照贴图由GPULM调用。可以使用关卡四周的Lightmass重要体积来放置这些光照贴图，但这并不是必需的。GPULM使用世界设置（World Settings）> Lightmass中有关体积光照贴图细节单元大小（Volumetric Lightmap Detail Cell Size）的设置。体积光照贴图始终完全渲染，即使在烘焙所见内容（Bake What You See）模式下也是如此。 |
| **细节级别网格体（Level of Detail Meshes）** | 是 |  |
| **Lightmass世界设置和逐对象设置（Lightmass World Settings and Per-Object Settings）** | 否 | 对于基于CPU的工作流，有很多设置可用于调整lightmass的结果。这些设置大部分不可与GPULM配合使用，并且没有等效的功能或设置。 |

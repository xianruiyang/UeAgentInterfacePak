---
title: "虚拟纹理参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/virtual-texturing-settings-and-properties-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "虚拟纹理", "虚拟纹理参考"]
---

# 虚拟纹理参考

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 虚拟纹理 / 虚拟纹理参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/virtual-texturing-settings-and-properties-in-unreal-engine

本页面包含虚拟纹理系统的要求、设置、控制台命令的相关信息。

## 流送虚拟纹理设置

以下为用于设置和处理[流送虚拟纹理](../../../optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/streaming-virtual-texturing/index.md)的设置和属性。

### 项目设置

在项目中激活 **启用虚拟纹理支持（Enable virtual texture support）** 后，可在 **项目设置（Project Settings）** 窗口下的 **编辑器（Editor）** 和 **渲染（Rendering）** 类别中访问以下设置。

![Enable Virtual Textures](../../../../../assets/images/55/5557a553dcbdefb50b3548bce0cc7f34753aed575dbff4398f7b81239fdf103d.png)

#### 渲染设置

可用渲染选项位于 **项目设置（Project Settings）** 窗口中的 **引擎（Engine）** > **渲染（Rendering）** > **虚拟纹理（Virtual Textures）** 类别下。

| 属性 | 说明 |
| --- | --- |
| **启用虚拟纹理支持（Enable virtual texture support）** | 启用后可使用虚拟纹理系统流送纹理。更改此设置需重启编辑器。 |
| **在导入纹理时启用虚拟纹理（Enable virtual texture on texture import）** | 启用后，只要导入的新纹理尺寸大于或等于纹理导入设置中的 **自动虚拟纹理尺寸（Auto Virtual Texturing Size）**，其就会自动被导入为虚拟纹理。 |
| **启用虚拟纹理光照贴图（Enable virtual texture lightmaps）** | 将光照贴图烘焙为虚拟纹理。这意味光照贴图将具有[流送虚拟纹理](../../../optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/streaming-virtual-texturing/index.md)的所有优缺点。与传统光照贴图纹理图谱表相比，VT可使关卡中的所有光照适应单个纹理，从而提高批处理效率。须重建项目光照后，此更改才会生效。更改此设置需重启编辑器。 |
| **启用虚拟纹理各异向性过滤（Enable virtual texture anisotropic filtering）** | 启用后，虚拟纹理将使用各异向性过滤。这会增加所有使用虚拟纹理的着色器的开销。更改此设置需要重启编辑器。 |
| **为不透明度遮罩启用虚拟纹理（Enable virtual textures for Opacity Mask）** | 启用后，限制会有所放宽，即虚拟纹理不会影响"不透明度遮罩"材质的输出。虽然启用这一功能是安全的，但并不十分可靠。在最糟糕的情况下，虚拟纹理可能无法以预期的分辨率进行流送，或者缓存的阴影图可能会包含低分辨率的边缘。 |
| **图块大小（Tile size）** | 虚拟纹理图块的大小（以像素计）。所有非二幂次方的值将四舍五入为下一个二幂次方值。更改此设置需重启编辑器。 |
| **图块边界大小（Tile size）** | 虚拟纹理图块边界的大小（以像素计）。所有非二幂次方的值将四舍五入为下一个二幂次方值。较大边界将启用较高程度的各向异性过滤，但会占用较多硬盘/缓存。更改此设置需重启编辑器。 |
| **反馈分辨率因子（Feedback resolution factor** | 较小因子将增大虚拟纹理反馈分辨率，同时增加CPU/GPU开销。其会缩短流送延迟，特别是材质使用过多虚拟纹理时。 |

#### 编辑器设置

可用编辑器设置位于 **项目设置（Project Settings）** 窗口中的 **编辑器（Editor）** > **纹理导入（Texture Import）** > **虚拟纹理（Virtual Textures）** 类别下。

| 属性 | 说明 |
| --- | --- |
| **自动虚拟纹理大小（Auto Virtual Texturing Size）** | 自动启用大于或等于此大小纹理的 **虚拟纹理流送（Virtual Texture Streaming）** 纹理设置。此设置不会影响项目中的现有纹理。 |

### 纹理编辑器

使用纹理编辑器设置和控制有损压缩量以及纹理是否支持SVT。

![undefined](../../../../../assets/images/fc/fc5cdfbb327b831c4086ca735c9876f98a57cb61fff4a76b05dd70a08a2f2caf.jpg)

点击查看大图。

| 属性 | 说明 |
| --- | --- |
| 压缩 |  |
| **有损压缩量（Lossy Compression Amount）** | 相关有损压缩的应用程度。从最低的无有损压缩到最高压缩等选项中，选择使用一个选项，文件最小时图像质量最差。 |
| 纹理 |  |
| **虚拟纹理流送（Virtual Texture Streaming）** | 使用虚拟纹理时是否应流送此纹理。注意：对等于或大于 **自动虚拟纹理大小（Auto Virtual Texturing Size）** 的所有导入纹理，默认启用此参数。（此纹理大小在 **项目设置（Project Settings）** 中 **编辑器（Editor）** > **虚拟纹理（Virtual Texturing）** 下设置） |

## 运行时虚拟纹理设置

在项目中使用以下设置和属性设置和处理[运行时虚拟纹理](../../../optimizing-and-debugging-projects-for-realtime-rendering/virtual-texturing/runtime-virtual-texturing/index.md)。

### 运行时虚拟纹理资源

打开 **运行时虚拟纹理** 资源时，使用此窗口设置场景生成RVT的参数，包括引用该RVT的 **运行时虚拟纹理体积**。可在 **材质和纹理（Materials & Textures）** 下的 **新增（Add New）** 菜单中创建RVT资源。

![Runtime Virtual Texture Window](../../../../../assets/images/a8/a8cd97ded775523da1f6151d096b2818edb9664e591aa9ed047b4c9c6742d61a.jpg)

| 属性 | 说明 |
| --- | --- |
| 细节 |  |
| **页面表纹理内存（预计）（Page Table Texture Memory (estimated)）** | 预估此虚拟纹理资源正在使用的页面表纹理内存。 |
| **物理纹理内存（预估）（Physical Texture Memory (estimated)）** | 预估此虚拟纹理资源正在使用的物理纹理内存。 |
| 大小 |  |
| **虚拟纹理的大小（以图块计）（Size of the virtual texture in tiles）** | 此RVT的大小（以图块计）。RVT的最终分辨率为此值乘以图块大小。目前最多支持4096个图块。此值应用于相关RVT中的最大宽度或高度。将选择较小轴的大小与RVT体积的宽高比匹配。 |
| **各虚拟纹理图块的大小（Size of each virtual texture tile）** | 此RVT使用的图块大小。在图块中渲染和储存虚拟纹理数据。使用小图块表示生成各图块的开销更低，但需生成更多图块。 |
| **各虚拟纹理图块的边界填充（Border padding for each virtual texture tile）** | 各图块使用的填充纹素数量。数量越多，对内存和性能的影响就越小。值为0时，由于双线性采样瑕疵，将将导致图块边缘出现着色接缝。值为2可能解决此问题，需更大的值才能启用启用各向异性采样。 |
| 布局 |  |
| **虚拟纹理内容（Virtual texture content）** | 选择要存储在此RVT中的材质属性： **底色（Base Color）**：仅存储底色。启用压缩后将存储为BC1格式。 **底色、法线（Base Color, Normal）**：存储底色和法线。启用压缩后底色存储将被为BC1格式，法线将被存储为BC5格式。 **底色、法线、粗糙度、高光度（Base Color, Normal, Roughness, Specular）**：存储底色、法线、粗糙度和高光度。启用压缩后底色将被存储为BC1格式，其他属性将被打包为BC3格式。 **底色、法线、粗糙度、高光、遮罩（Base Color, Normal, Roughness, Specular, Mask）**：与上述选项相同，但多了一个通用的8位遮罩通道。 **世界高度（World Height）**：存储一个16位高度值。该值根据RVT体积中最小和最大z坐标范围进行规格化并存储。 此设置须与相关材质资源中的设置匹配，RVT才能正常运行。 |
| **启用BC纹理压缩（Enable BC texture compression）** | 启用RVT中存储数据的纹理压缩。此设置可将内存开销降低四到八倍，同时提高采样性能。建议仅在调试和质量比较时使用无压缩。 |
| **启用渲染前清理（Enable clear before render）** | 设置此选项后，将渲染前清理图块。若已知纹理将固定被渲染完整覆盖，则建议禁用此选项以进行优化。 |
| **启用打包页面表（Enable packed page table）** | 设置此选项后，RVT将使用优化页面表设置。此操作可减少页面表的内存和更新开销，但会削弱与其他虚拟纹理共享物理内存的能力。 |
| **启用私有页面表（Enable private page table）** | 设置此选项后，RVT将单独分配页面表资源，而非在全局共享的页面表图谱中分配。此操作可减少页面表内存总体分配，但也将减少支持的虚拟纹理总数。 |
| **启用自适应页面表（Enable adaptive page table）** | 设置此选项后，RVT将使用稀疏自适应页表。这支持的图块数量可超过页表大小，从而意味着可以实现更大的虚拟纹理分辨率。然而，在对自适应页表进行采样时存在一定的性能损耗，因此只有在需要较大图块数量的情况下才应设置此选项。 |
| **启用连续页面更新（Enable continuous page updates）** | 设置此选项后，RVT会在每帧中刷新一定数量的已生成页面。具体数量由 **r.VT.MaxContinuousUpdatesPerFrame** CVar 控制。启用此功能可为在某些RVT页面生成之前其依赖纹理尚未完全流送的情况下出现的视觉问题提供一种简单的解决方案。 |
| **要移除的低mip（Low Mips to Remove）** | 要从此RVT中移除的低mip数。低mip覆盖多数区域，因此渲染开销最高。移除后可提高性能。但若无低mip，会导致最终渲染中出现mip闪烁瑕疵。因此通常建议使用流送低mip。 |
| **纹理组（Texture Group）** | 每个RVT都可以归属于某个LOD纹理组，该组可针对不同平台配置以重载图块数量或图块大小。 |

### 运行时虚拟纹理采样材质节点设置

可在材质编辑器中的部分运行时虚拟纹理材质表达式中找到以下属性。

| 属性 | 描述 |
| --- | --- |
| 虚拟纹理 |  |
| **虚拟纹理（Virtual Texture）** | 要采样的运行时虚拟纹理资源。 |
| **虚拟纹理内容（Virtual Texture Content）** | 解译虚拟纹理内容的方式。注意：绑定的虚拟纹理资源应进行相同设置，以便保证正确采样。 |
| **启用打包页面表（Enable packed page table）** | 启用页面表通道打包。注意，绑定的虚拟纹理资源应具有相同的设置，这样采样才能正确运行。 |
| **启用自适应页表（Enable adaptive page table）** | 启用稀疏的自适应页表采样。请注意，绑定的虚拟纹理资产应有相同设置，以使采样工作正常进行。 |
| 纹理采样（Texture Sample） |  |
| **mip值模式（Mip Value Mode）** | 定义运行时虚拟纹理表达式上mip值属性应用到虚拟纹理查找的方式。 **无（None）（使用计算的mip等级）：**结合自动各向异性过滤支持使用硬件计算的样本mip等级。 **mip等级（MipLevel）（绝对值，0为完整分辨率）：**显式计算样本的mip等级。禁用各向异性过滤。 **mip偏差（MipBias）（相对于计算的mip）：**偏移硬件计算的样本的mip等级。禁用各向异性过滤。 极端设置可能会对性能产生影响。例如，如果将MipBias设置为较大的负值，或强制MipLevel为0，会导致更多的虚拟纹理页需要驻留。这可能会导致物理池的不稳定。 |

### 运行时虚拟纹理体积

使用 **运行时虚拟纹理体积** 指定 **运行时虚拟纹理**，在使用相同RVT资源的地形Actor和场景图元中的场景内生成RVT。

![Runtime Virtual Texture Volume Settings](../../../../../assets/images/87/876193327a8344fe9130eb28a669ea9f24739340998e260aaee159a808f3dfe9.png)

| 属性 | 说明 |
| --- | --- |
| 虚拟纹理 |  |
| **虚拟纹理（Virtual Texture）** | 要使用的运行时虚拟纹理资源。 |
| **可扩展性组（Scalability Group）** | RVT体积使用的可扩展性组。选择哪一个 **r.VT.RVT.TileCountBias.Group** 将用于体积上的RVT集。 |
| **隐藏图元（Hide Primitives）** | 在主通道中隐藏相关图元。效果适用于渲染到此体积上的RVT的所有图元（这些图元的"在主通道中渲染（Draw in Main Pass）"被设置为"来自虚拟纹理（From Virtual Texture）"。 |
| **流送纹理（Streaming Texture）** | 此虚拟纹理的低Mip使用的流送纹理。 |
| **启用Crunch（Enable Crunch）** | 启用Crunch库来压缩流送的虚拟纹理。Crunch是一个开源压缩库，可以进一步压缩GPU的压缩纹理（使用DXT/BC/ETC压缩）。它使数据比Zlib小得多，并降低了CPU的解压开销。 |
| **在编辑器中查看流送Mip（View Streaming Mips in Editor）** | 启用此功能后，可以在编辑器中显示低Mip的流送虚拟纹理。默认情况下，该功能是禁用的，因为流送虚拟纹理只能通过"构建"按钮手动更新，所以在编辑会话中可能会出现不同步的情况。 |

### Actor属性

使用以下场景图元和地形的设置和属性。

#### 图元

场景中的Actor特定设置和属性。

![Actor Runtime Virtual Texture Setting](../../../../../assets/images/60/60fe660a1814ab954f8debdc5b9ce35c4f585a726e09ec08a1711880dc8ba3f9.png)

| 属性 | 说明 |
| --- | --- |
| 虚拟纹理 |  |
| **渲染至虚拟纹理（Render to Virtual Textures）** | 运行时虚拟纹理排列，选中Actor的网格体将渲染到其中。还需设置材质以输出到虚拟纹理。 |
| **虚拟纹理通道类型（Virtual Texture Pass Type）** | 基于选中虚拟纹理设置渲染至主通道： **从不（Never）**：从不在主通道中渲染此Actor。如果场景中没有RVT，那么它根本不会被渲染。此法适用于那些即便没有启用虚拟纹理支持也不必考虑是否删除它们的项目。 **始终（Always）**：无论虚拟纹理支持是否启用，都会将此Actor渲染到RVT和主通道中。此法适用于那些需要同时读取和写入虚拟纹理的项目。例如，地形设置就需要这种方式。 **从虚拟纹理（From Virtual Texture）**：根据虚拟纹理支持情况和设置，将此Actor渲染到RVT或主通道中。此法适用于那些在启用虚拟纹理且存在RVT的情况下应绘制到虚拟纹理中的项目，但在其他情况下应绘制到主通道中的项目。 |
| **虚拟纹理LOD偏差（Virtual Texture LOD Bias）** | 为渲染至运行时虚拟纹理而选择的细节级别（LOD）偏差。 |
| **虚拟纹理跳过Mip（Virtual Texture Skip Mips）** | 运行时虚拟纹理中要跳过渲染此图元的最低mip数。较大值可缩短运行时虚拟纹理中的有效绘制距离。剔除方法不考虑图元大小或虚拟纹理大小。 |
| **虚拟纹理最小覆盖（Virtual Texture Min Coverage）** | 设置从运行时虚拟纹理中剔除前的最小像素覆盖。较大值可缩短运行时虚拟纹理中的有效绘制距离。 |

#### 地形

场景中的地形和地形样条Actor特定的设置和属性。

![Runtime Virtual Texture Landscape Settings](../../../../../assets/images/76/76de60aa9f982f961260b52b3b883d2b8cff4fc44e79791f20e5b5369d003c4b.png)

| 属性 | 说明 |
| --- | --- |
| 虚拟纹理 |  |
| **渲染至虚拟纹理（Render to Virtual Textures）** | 运行时虚拟纹理排列，选中Actor的网格体将渲染到其中。还需设置材质以输出到虚拟纹理。 |
| **虚拟纹理通道类型（Virtual Texture Pass Type）** | 基于选中虚拟纹理设置渲染至主通道： **从不（Never）**：从不在主通道中渲染此Actor。如果场景中没有RVT，那么它根本不会被渲染。此法适用于那些即便没有启用虚拟纹理支持也不必考虑是否删除它们的项目。 **始终（Always）**：无论虚拟纹理支持是否启用，都会将此Actor渲染到RVT和主通道中。此法适用于那些需要同时读取和写入虚拟纹理的项目。例如，地形设置就需要这种方式。 **从虚拟纹理（From Virtual Texture）**：根据虚拟纹理支持情况和设置，将此Actor渲染到RVT或主通道中。此法适用于那些在启用虚拟纹理且存在RVT的情况下应绘制到虚拟纹理中的项目，但在其他情况下应绘制到主通道中的项目。 |
| **虚拟纹理LOD数量（Virtual Texture Num LODs）** | 将地形渲染至运行时虚拟纹理中所用的网格体级别数。仅当用于渲染虚拟纹理的材质需要内插顶点数据（如高度）时设置此值。较大值将使用曲面更细分的网格体，因而在渲染运行时虚拟纹理时开销较高。 |
| **虚拟纹理LOD偏差（Virtual Texture LOD Bias）** | 为渲染至运行时虚拟纹理而选择的细节级别（LOD）偏差。 |

#### 地形样条

场景中地形样条Actor的特定设置和属性。

![Runtime Virtual Texture Landscape Spline](../../../../../assets/images/01/014318871c3bec91a876767234ebedf75984fe334037e15aeb7aa24ccc594640.png)

| 属性 | 描述 |
| --- | --- |
| 虚拟纹理 |  |
| **渲染至虚拟纹理（Render to Virtual Textures）** | 运行时虚拟纹理排列，选中Actor的网格体将渲染到其中。还需设置材质以输出到虚拟纹理。 |
| **虚拟纹理通道类型（Virtual Texture Pass Type）** | 基于选中虚拟纹理设置渲染至主通道： **从不（Never）**：从不在主通道中渲染此Actor。如果场景中没有RVT，那么它根本不会被渲染。此法适用于那些即便没有启用虚拟纹理支持也不必考虑是否删除它们的项目。 **始终（Always）**：无论虚拟纹理支持是否启用，都会将此Actor渲染到RVT和主通道中。此法适用于那些需要同时读取和写入虚拟纹理的项目。例如，地形设置就需要这种方式。 **从虚拟纹理（From Virtual Texture）**：根据虚拟纹理支持情况和设置，将此Actor渲染到RVT或主通道中。此法适用于那些在启用虚拟纹理且存在RVT的情况下应绘制到虚拟纹理中的项目，但在其他情况下应绘制到主通道中的项目。 |
| **虚拟纹理LOD数量（Virtual Texture Num LODs）** | 将地形渲染至运行时虚拟纹理中所用的网格体级别数。仅当用于渲染虚拟纹理的材质需要内插顶点数据（如高度）时设置此值。较大值将使用曲面更细分的网格体，因而在渲染运行时虚拟纹理时开销较高。 |
| **虚拟纹理LOD偏差（Virtual Texture LOD Bias）** | 为渲染至运行时虚拟纹理而选择的细节级别（LOD）偏差。 |
| **虚拟纹理跳过Mip（Virtual Texture Skip Mips）** | RVT中跳过渲染此图元的较低Mip数。较大的值可缩短RVT中的有效绘制距离。此剔除方法不考虑图元大小或虚拟纹理大小。 |
| **主通道中最大绘制距离（Max Draw Distance in Main Pass）** | 如同时渲染 **虚拟纹理和主通道**，主通道中需要的剔除距离。值为0则无效果。 |

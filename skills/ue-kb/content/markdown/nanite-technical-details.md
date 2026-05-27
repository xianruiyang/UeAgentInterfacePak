# Nanite Technical Details

---
title: "Nanite Technical Details"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/nanite-technical-details"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "Nanite虚拟几何体", "Nanite Technical Details"]
---

# Nanite Technical Details

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / Nanite虚拟几何体 / Nanite Technical Details

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/nanite-technical-details

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

本页提供对 Nanite geometry system 的更深入理解与使用示例。

## Nanite Fallback Mesh 与 Precision Settings

Static mesh 和 skeletal mesh 包含额外属性，用于控制 Nanite representation 的 precision，以及从原始导入 source mesh 生成的 fallback mesh。

这些设置位于 mesh asset editor 的 **Details（详情）**面板中，位于 **Nanite Settings（Nanite 设置）**部分。

Nanite Mesh Editor Settings（Nanite 网格体编辑器设置）

| Property（属性） | 说明 |
| --- | --- |
| Enable Nanite Support（启用 Nanite 支持） | 允许此 mesh 使用 Nanite，并在无法使用 Nanite 的情况下生成 fallback mesh。 |
| Preserve Area（保留面积） | 让因简化而丢失表面积的 Nanite mesh 通过向外 dilate open boundary edge，把丢失面积重新分配到剩余 triangle 上。它最适合 foliage，因为叶片在简化后容易变成分离的 triangle 和 quad。此设置的效果相当于放大每片叶子。对于草叶这类 geometry ribbon，它的效果是加厚。该设置应只在 foliage mesh 上启用。 |
| Explicit Tangents（显式切线） | 为 true 时，会按资产存储并使用原始 model tangent。这表示 tangent 会显式存储在磁盘上，而不是在运行时隐式派生。Tangent Precision 设置会变为可用，用于进一步控制 vertex tangent。启用此设置会使存储增加约 10%，但当 implicit tangent 精度不足时可能更合适。 |
| Lerp UVs（插值 UV） | 控制简化时是否插值 UV。应尽可能启用。对于真实 UV coordinate，此设置允许在简化时为新 vertex 计算误差最低的 optimal UV，前提是 UV 被作为常规 texture coordinate 使用，并会跨 triangle face 插值。如果 UV 中存储的数据不适合插值，则应禁用。例如，如果 UV 中存储 index，lerp index 没有意义，并会破坏尝试使用它的 shader。如果禁用，Nanite 选择要渲染的 LOD 时将不再考虑 UV 误差，因为任意不可插值 vertex attribute 造成的误差通常无法推理。 |
| Position Precision（位置精度） | 选择此 mesh 在生成 Nanite mesh vertex position 时应使用的 precision。系统会根据 mesh 尺寸自动确定合适 precision。也可以覆盖 precision，以提高精度或优化 disk footprint。 |
| Normal Precision（法线精度） | 选择此 mesh 在生成 Nanite mesh vertex normal 时应使用的 precision。系统会根据 mesh 尺寸自动确定合适 precision。也可以覆盖 precision，以提高精度或优化 disk footprint。 |
| Minimum Residency（Root Geometry，最小常驻） | 设置此 mesh 应始终保留在内存中的 byte size，其余数据会 streamed in。较高值需要更多内存，但对某些 mesh 可缓解 streaming pop-in 问题。 |
| Keep Triangle Percent（保留三角形百分比） | 从 source mesh 中保留的 triangle 百分比。降低此百分比可优化 disk size。 |
| Trim Relative Error（裁剪相对误差） | 设置可从 Nanite mesh 中移除的最大 relative error。source mesh 中视觉影响低于该 relative error 的所有细节都会被移除。relative error 没有单位大小，而是相对于 mesh 尺寸。默认情况下，Nanite 会存储原始 source mesh 的所有 triangle。 |
| Fallback Target（回退目标） | 决定生成 fallback mesh 时使用哪个 targeting system。Auto：根据项目设置自动创建 fallback mesh。Fallback Triangle Percent：设置为 Nanite 简化 source mesh 时保留的 triangle 百分比。Fallback Relative Error：相对于 mesh 尺寸进行简化，直到达到指定误差。生成的 fallback mesh 中视觉影响低于该 relative error 的所有细节都会被移除。 |
| Source Import Filename（源导入文件名） | 用于导入供 Nanite 使用的 high-resolution mesh 的文件路径。可以受益于更详细几何体的系统（如 Nanite 和 Unreal Engine 中的 Geometry Modeling）会使用该 mesh 的高分辨率版本代替 LOD0。 |
| Displacement UV Channel（位移 UV 通道） | 采样 displacement map 时使用的 UV channel。 |
| Displacement Maps（位移贴图） | 添加并编辑 displacement map。 |
| Max Edge Length Factor（最大边长系数） | 控制屏幕上 mesh 各 vertex 之间允许的最大距离。它可用于防止需要变形的 mesh 被过度简化，例如使用 world position offset 的动画和 spline mesh。默认应保持为 0，除非明确需要修复过度简化造成的问题。 |

### Vertex Precision（顶点精度）

Nanite 会 quantize mesh vertex position，以最大化 memory density 并最小化 disk footprint。quantization step size 是 2 的幂，可通过 Position Precision 属性选择，以匹配各个 mesh 的需求。默认情况下，Auto 会根据 mesh 尺寸和 triangle density 选择合适 precision。也可以手动选择 precision size，以提高精度或优化 disk footprint。

Vertex Position Precision Options（顶点位置精度选项）

Quantization 是一种 lossy compression。处理 modular mesh piece 或其他具有 shared boundary 的 mesh 时，lossy compression 尤其具有挑战性，特别是这些边界必须完美对齐以避免几何体出现孔洞或裂缝时。

为确保一致性，quantization 会在以 mesh origin 为中心的 unnormalized object coordinate 中进行。这可确保当 mesh 使用相同 precision setting，且 mesh center 之间的 translation 是该 precision 的倍数时，quantization 不会造成 crack。

### Trimming Mesh Data（裁剪网格体数据）

有时需要减少 Nanite 存储的数据量，以优化 disk size。Nanite 提供相关设置，使你可以在制作期间的任意时间，从已存储的 Nanite mesh 中 trim detail data。这意味着可以在前期安全地超出质量目标，并在后期根据项目和平台目标的 size budget 进行调整。

Trimming Nanite detail data 类似于在存储为 Nanite mesh 之前执行 pre-decimate。对 Nanite 来说，detail 不需要在整个 mesh 上均匀，因为它会先移除最不重要的数据，更接近 lossy compression。

要 trim detail data，可以调整以下设置：

- Keep Triangle Percent 设置从原始 source（full detail）mesh 中保留的 triangle 百分比。
- Trim Relative Error 设置从 source mesh trim data 时允许的最大 relative error。任何移除后产生 relative error 小于该值的 triangle 都会被移除。

  - > [!NOTE]
    > relative error 没有单位大小，而是相对于 mesh 尺寸。

这两个属性的默认值都表示默认不 trim，Nanite 会存储原始 source mesh 的所有 triangle。因此，trim data 的重点是减少 disk size（换句话说是 download size），而不是专门提升性能。

有关此方面的更多详细信息，请参阅 [Data Size（数据大小）](index.md) 下方内容。

### Fallback Mesh（回退网格体）

Unreal Engine 的许多部分需要访问传统渲染 mesh 提供的 vertex buffer。当为 static mesh 启用 Nanite 时，它会为高细节 mesh 生成一个粗略表示，即 fallback mesh。fallback mesh 会在不支持 Nanite rendering 时使用；当不适合使用 full-detail mesh 时也会使用，例如需要 complex collision、使用 lightmap 进行 baked lighting，以及 Lumen 的 hardware ray tracing reflection。

该 **Fallback Triangle Percent（回退三角形百分比）** 属性表示用于生成 Fallback Mesh 的原始 source mesh triangle 百分比。可以在 0 到 100 percent 之间指定保留 triangle 的百分比；较大百分比会保留更多原始 mesh detail。

该 **Fallback Relative Error（回退相对误差）** 属性设置从 source mesh 移除 detail 时可接受的最大 relative error。任何移除后产生 relative error 小于该值的 triangle 都会被移除，视觉影响较小的 detail 会优先移除。relative error 没有单位大小，而是相对于 mesh 尺寸。

例如，如果希望 mesh 不发生任何 decimation（三角形移除），应使用 Fallback Triangle Percentage 100 和 Fallback Relative Error 0。

下方比较展示了基于原始 source mesh 的高细节 Nanite mesh，与使用默认设置生成的 Fallback Mesh。

![High Poly Nanite Mesh](../../../../../assets/images/86/860d8cb1c577d6e49efb4ecc4bf2ec5c12210cbec5bc524c6b0b5738b135cde0.jpg)

![Nanite-generated Fallback mesh with Default Settings](../../../../../assets/images/8a/8ab4a5dd34ea5ffdc317e75dfdaef745404a2f2c968ea8bb7b243085c6b22867.jpg)

High Poly Nanite Mesh（高面数 Nanite 网格体）

使用默认设置由 Nanite 生成的 Fallback Mesh

使用 Fallback Relative Error 值指定从 source mesh 保留多少原始 detail，并使用 Fallback Percentage 值设置实际使用其中多少 detail。

下方比较展示了调整 Fallback Triangle Percent 和 Fallback Relative Error 属性后，fallback mesh 如何保留更多原始 source mesh triangle。调整这些值时，请使用 viewport 中 Nanite details 的 **Nanite Triangles（Nanite 三角形）** 作为 fallback mesh triangle 数量的指示。

![Nanite-generated Fallback Mesh with Default Settings](../../../../../assets/images/8a/8ab4a5dd34ea5ffdc317e75dfdaef745404a2f2c968ea8bb7b243085c6b22867.jpg)

默认设置下由 Nanite 生成的 Fallback Mesh

#### Fallback Mesh/Visualization（回退网格体可视化）（回退网格体可视化）

在 Static Mesh editor 中，可以使用 viewport 的 Show 下拉菜单中的 Nanite Fallback 选项，在 full-detail Nanite mesh 与 Nanite fallback mesh 之间切换。也可以使用 Ctrl + N 快捷键在两个 visualization option 之间快速切换。

#### 为启用 Nanite 的 mesh 使用自定义 Fallback Mesh LOD

fallback mesh 用于 complex per-poly collision、ray tracing、light baking 等 engine feature，也用于不支持 Nanite 的平台。生成 fallback mesh 时，启用 Nanite 的 mesh 总是使用 source mesh 的 LOD0 slot 自动生成 fallback mesh。不过，有时可能希望使用手动指定的 fallback mesh，或使用一系列传统 LOD，而不是自动生成的 fallback mesh。

这种控制级别允许在项目中使用 Nanite，同时直接控制 ray-traced reflection 中看到的几何体，或控制不支持 Nanite 的平台上看到的几何体。

按以下步骤指定自定义 fallback mesh，或使用一系列 LOD：

1. 将 Fallback Triangle Percent 设为 0，使 fallback mesh 尽可能小，因为使用此方法时它会被忽略。
2. 使用传统 LOD 设置流程向 mesh 添加一个或多个 LOD。
3. 在 LOD Settings section 中使用 LOD Import 下拉菜单导入 LOD Level 1。
4. 在 LOD Settings section 下将 Minimum LOD 设为 1。这会使 Nanite 生成的 fallback mesh 被忽略。

Complex collision 是特殊情况。使用 General Settings 下的 LOD for Collision 属性指定哪个 LOD 应用于 collision。任意 LOD 都可用于 collision，包括 LOD0。

> [!NOTE]
> 这种方法不一定能让 Nanite 项目自动兼容不支持 Nanite 的平台，应针对具体项目进行测试和评估。

Nanite 可以高效处理大量 instance，但如果禁用 Nanite，传统渲染管线可能产生压倒性的 draw call 数量。可以在自己的项目中使用 r.Nanite 0 切换 Nanite 开关来测试这一点。

更多信息请参阅本页 Console Variables and Commands 一节。

## Data Size（数据大小）

可能有人会认为，因为 Nanite 能实现 micro detail，所以 geometry data 会大幅增加，最终导致游戏包和玩家下载大小变大。但由于专用 encoding，Nanite mesh format 显著小于标准 static mesh format。

例如，在 Unreal Engine 5 示例 Valley of the Ancients 中，Nanite mesh 平均每个 input triangle 14.4 byte。这意味着一个平均一百万 triangle 的 Nanite mesh 在磁盘上约为 13.8 MB。

比较传统 low poly mesh 加 Normal map 与 high poly Nanite mesh 时，会看到类似如下结果：

![Low Polygon Static Mesh with a 4k Normal Map](../../../../../assets/images/7e/7e09149d1d8cd69958262fce1f29d64714499851703e635bc6ad79473f33b2e4.jpg)

![High Polygon/Static Mesh（高面数静态网格体） with 4k Normal Map](../../../../../assets/images/90/904dc4e2b601e9740268bd16edd64cf5fb566c2f43d0a7f2488713f0de5b8340.jpg)

带 4k Normal Map 的 Low Polygon Static Mesh

带 4k Normal Map 的 High Polygon/Static Mesh（高面数静态网格体）

| Low Polygon/mesh（低面数网格体）（低面数网格体） | High Polygon Mesh（高面数网格体） |
| --- | --- |
| Triangles（三角形）：19,066Vertices（顶点）：10,930Num LODs（LOD 数）：4Nanite 状态：Disabled（禁用）Static mesh compressed package size（静态网格体压缩包大小）：1.34MB | Triangles（三角形）：1,545,338Vertices（顶点）：793,330Num LODs（LOD 数）：n/aNanite 状态：Enabled（启用）Static mesh compressed package size（静态网格体压缩包大小）：19.64MB |

不过，compressed package size 并不是资产的完整大小。还必须考虑此 mesh 独有的 texture。mesh 使用的许多 material 都有自己的 unique texture，由不同的 Normal、BaseColor、Metallic、Specular、Roughness 和 Mask texture 组成。

该特定资产只使用两个 texture（BaseColor 和 Normal），因此在 disk space 上不如包含许多其他 unique texture 的资产昂贵。例如，注意这个约 150 万 triangle 的 Nanite mesh 大小（19.64MB）小于一张 4k normal map texture。

| Texture Type（纹理类型） | Texture Size（纹理大小） | Size on Disk（磁盘大小） |
| --- | --- | --- |
| BaseColor | 4k x 4k | 8.2MB |
| Normal | 4k x 4k | 21.85MB |

该 mesh 及其 texture 的 total compressed package size 为：

- Low-polygon mesh：31.04MB
- High-polygon mesh：49.69MB

由于 Nanite mesh 已经非常详细，用与其他资产共享的 tiling detail map 替换 unique normal map，是减少 texture size 的好方法。这可能造成一些视觉质量损失，但小于 low poly 与 high poly mesh 之间的质量差异。考虑这一点后，一个 150 万 triangle 的 Nanite mesh 既可以比带 4k normal map texture 的 low poly mesh 看起来更好，也可以更小。

启用 Nanite 的 mesh 及其 texture 的 total compressed package size：27.83 MB

![High Polygon/Static Mesh（高面数静态网格体） with 4K Normal Map](../../../../../assets/images/90/904dc4e2b601e9740268bd16edd64cf5fb566c2f43d0a7f2488713f0de5b8340.jpg)

![Nanite Mesh with 4K "Detail" Normal Map](../../../../../assets/images/42/42377b7d47bfc9d0d273a7b510997074648d69c224d7b7e9f8fe28f813637348.jpg)

带 4K Normal Map 的 High Polygon/Static Mesh（高面数静态网格体）

带 4K “Detail” Normal Map 的 Nanite Mesh

> [!NOTE]
> 可以对 texture resolution 和“detail”normal map 做大量实验；这个特定比较说明，Nanite mesh 的数据大小与 artist 已熟悉的数据并没有太大差异。

最后，可以使用 high poly 比较 Nanite compression 与标准 static mesh format，此时二者在 LOD0 相同。

| High Polygon/Static Mesh（高面数静态网格体）（高面数静态网格体） | Nanite Static Mesh（Nanite 静态网格体） |
| --- | --- |
| Triangles（三角形）：1,545,338Vertices（顶点）：793,330Num LODs（LOD 数）：4Nanite 状态：Disabled（禁用）Static mesh compressed package size（静态网格体压缩包大小）：148.95MB | Triangles（三角形）：1,545,338Vertices（顶点）：793,330Num LODs（LOD 数）：n/aNanite 状态：Enabled（启用）Static mesh compressed package size（静态网格体压缩包大小）：19.64MB |

与前面 19.64MB 的 Nanite compression 相比，它比包含 4 个 LOD 的标准 static mesh compression 小 7.6 倍。

### General Advice on Data Size（数据大小通用建议）

Nanite 和 [Virtual Texturing（虚拟纹理）](../../virtual-texturing/index.md) 系统结合高速 SSD，已经降低了对 geometry 与 texture runtime budget 的担忧。现在最大的瓶颈是如何把这些数据交付给用户。

考虑内容如何交付时，无论是物理介质还是互联网下载，disk data size 都是重要因素，而 compression technology 能做的有限。普通最终用户的 internet bandwidth、optical media size 和 hard drive size 并没有以 hard drive bandwidth/access latency、GPU compute power 以及 Nanite 等 software technology 相同的速度扩展。向用户推送这些数据正在变得具有挑战性。

使用 Nanite 后，高效渲染高细节 mesh 不再那么令人担忧，但必须控制其磁盘数据存储。

## Visualization Modes（可视化模式）

Nanite 包含多种 visualization mode，用于检查当前场景中的 Nanite 数据。

在 Level viewport 的 View Modes 下拉菜单中，悬停到 Nanite Visualization，并从选项中选择。

Overview visualization 会在图像中心显示渲染场景，并在屏幕周围显示选定 Nanite visualization 作为参考。

可选择以下 Nanite visualization mode：

| Nanite Vis |  |
| --- | --- |
| Mask（遮罩） | 标记 Nanite（绿色）和 Non-Nanite（红色）geometry 的 visualization。 |
| Triangles（三角形） | 显示当前场景中 Nanite mesh 的所有 triangle。 |
| Patches（补丁） | 显示当前场景中 Nanite mesh 的所有 patch。 |
| Clusters（集群） | 用颜色表示当前 scene view 中渲染的所有 triangle grouping。 |
| Primitives（图元） | 对 instanced static mesh（ISM）中所有 instance 的 component 使用相同颜色的 visualization。 |
| Instances（实例） | 为场景中的每个 instance 应用不同颜色的 visualization。 |
| Overdraw（过度绘制） | 显示 scene geometry 发生的 overdraw 数量。所有 evaluated pixel，包括 masked-out pixel，都会加入 overdraw view。紧密堆叠的小对象比大对象产生更多 overdraw。 |
| Lightmap UV（光照贴图 UV） | 显示 Nanite mesh surface UV coordinate 的 visualization。 |
| Evaluate WPO（评估 WPO） | 对使用 world position offset 的 Nanite-enabled geometry 标为绿色，对未使用者标为红色。 |
| Pixel Programmable（像素可编程） |  |
| Tessellation（细分） | 用于显示使用 tessellation 的 Nanite mesh，以及仅在 tessellated mesh 上发生的 tessellation 量。 |
| Raster Bins（栅格化分箱） | 显示代表 geometry batch 的 group。 |
| Shading Bins（着色分箱） |  |

> [!NOTE]
> Nanite 包含 Advanced visualization mode，可在 Nanite Visualization 菜单中启用额外 visualization option。这些 visualization 对调试或分析 Nanite 各种底层方面的 programmer 很有用。
>
> 使用 console variable `r.Nanite.Visualize.Advanced 1` 启用 advanced visualization mode。

## Console Variables and Commands（控制台变量和命令）

以下 stat 和 console variable 可用于调试和配置 Nanite。

> [!NOTE]
> 可以在运行时使用 console variable `r.Nanite 0` 全局启用和禁用 Nanite rendering。禁用 Nanite 是模拟不支持 Nanite 的平台的好方法。

### Nanite Fallback Rendering Modes（Nanite 回退渲染模式）

当 Nanite 被禁用或平台不支持 Nanite 时，Nanite 会提供 fallback mesh rendering mode。可以使用 控制变量 r.Nanite.ProxyRenderMode（Nanite 回退渲染模式）（Nanite 回退渲染模式变量） 控制使用哪种 mode。

- **0** 是默认 mode，会回退为渲染 fallback mesh，或在设置后渲染 screen space-driven LOD。这包括识别 Static Mesh Editor 属性中的 Min LOD（见上方 Fallback Mesh 一节）。
- **1** 会禁用所有 Nanite-enabled mesh 的渲染。
- **2** 与 mode 1 类似，但允许 Static Mesh Editor 中的 Show > Nanite Fallback visualization 渲染 Nanite fallback。

> [!NOTE]
> fallback render mode 1 和 2 适用于 instance 数量远超无 Nanite 时可支持数量的场景。它们提供一种方式，让场景可以在不支持 Nanite 的平台上于 editor 中打开。

例如，在 Unreal Engine 5 Valley of the Ancients 示例项目中，禁用 Nanite 会产生数万个常规 draw call，使该 map 难以在不支持的平台上打开。

### Nanite Stats Command（Nanite 统计命令）

`NaniteStats` 命令会在 viewport 右上角添加 Nanite culling statistics overlay。

屏幕上的 NaniteStats 显示。

command argument 用于指定 Nanite 在屏幕上显示哪些 stat。未提供 argument 时，会使用 primary view。

使用 NaniteStats List 在 debug output 中显示所有可用 view：

- Primary（主视图）
- VirtualShadowMaps（虚拟阴影贴图）
- ShadowAtlas（仅可用时）
- CubemapShadows（仅可用时）

输入命令并跟随想查看的 stat list name，即可选择 view。例如输入 `NaniteStats VirtualShadowMaps`。

> [!NOTE]
> 对于使用 two-pass occlusion culling 的 view，statistics 会拆分为 Main 和 Post pass 两个 bucket。

### Resizing Nanite Streaming Pool Size（调整 Nanite Streaming Pool 大小）（调整 Nanite Streaming Pool 大小）

使用 console variable `r.Nanite.Streaming.StreamingPoolSize` 控制用于保存 Nanite streaming data 的 memory 量。更大的 pool 会在场景中移动时减少 IO 和 decompression 工作，但代价是更大的 memory footprint。

如果 pool 不够大，无法容纳某个 view 所需的全部数据，可能发生 cache thrashing，即使静态 view 下 streaming 也无法稳定。

要可视化 Nanite streaming data，可以使用 **Streaming Geometry（流送几何体）** show flag： **Show > Nanite > Streaming Geometry**。禁用时，Nanite mesh 只会以始终常驻内存的 quality level 渲染。

### Setting Maximum Clusters/Single Pass（设置单个 Pass 中的最大 Cluster）（设置单个 Pass 中的最大 Cluster）

可以使用 console variable `r.Nanite.MaxCandidateClusters` 和 `r.Nanite.MaxVisibleClusters` 指定 single pass 中使用的 candidate cluster 与 visible cluster 最大数量。这些值用于确定 intermediate buffer 大小，其默认值已选择为适用于常见 rendering scenario。

目前没有机制可动态调整这两个 buffer 的大小，也没有在 overflow 时自动降低 quality 的机制；如果它们相对于 scene complexity 过小，可能产生 rendering artifact，通常表现为 geometry 缺失或闪烁。出现这类 artifact 时，请使用 NaniteStats 为 candidate 与 visible cluster 确定保守 bound。更具体地说，请查看 ClustersSW 和 ClustersHW stat。当前 candidate cluster 的 memory cost 为 12 byte，visible cluster 为 16 byte。

> [!NOTE]
> 此 console variable 不能在运行时更改，必须在 configuration（.ini）file 中指定。


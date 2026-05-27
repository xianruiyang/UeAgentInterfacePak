---
title: "纹理流送指标"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-metrics-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "纹理流送", "纹理流送指标"]
---

# 纹理流送指标

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / 纹理流送 / 纹理流送指标

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-metrics-in-unreal-engine

可使用 `STAT STREAMING` 控制台命令分析纹理流送状态。此分析报告性能、内存使用，以及纹理流送器使用的其他指标。

`STAT STREAMING sortby=name maxhistoryframes=1`

读取内存数据时，术语"pool"代表概念（保留）内存，与实际使用的内存无关。 术语"mips"代表纹理当前使用的内存，而非未发生或未来的使用。内存指标分为三种主要的池：

- Texture
- Streaming
- Wanted

> [!NOTE]
> 这些池的大小显示在 Memory Counters 类目中每行的右方。

| 数据 | 描述 |
| --- | --- |
| 循环计数器 |  |
| Game Thread Update Time | 流送器更新函数所占用的时间。这负责大多数的纹理流送工作。只有少数任务在纹理流送器外处理，如移除对纹理、组件或关卡的引用。在一个游戏线程更新中，流送器向完整更新执行一步。完成更新将持续数帧，并与 `r.Streaming.FramesForFullUpdate` 相关。如数据的 **Counter** 部分所定义，更新步骤各有不同。 |
| 内存计数器 |  |
| Texture Pool | 纹理资源可用的总内存。这包含各种非流送资源，如渲染目标、GPU 粒子缓存、立方体贴图、UI 纹理和不可流送纹理。在部分平台上，此内存可用于保存静态网格体之类的非纹理资源。**Texture Pool** 约等于 **Safety Pool** + **Temporary Pool** + **Streaming Pool** + **NonStreaming Mips**（如有，仅限波动的量，上至安全池的大小） |
| Safety Pool | 此值在 `Engine` 配置文件中设置（在 `[TextureStreaming]` 下，作为 `MemoryMargin`）。这是为意外（非流送）分配预留的内存。如可用的内存因低于此值的量形成周期波动，纹理流送器将在此波动下最大程度地稳定其流送池如正常（预计）的波动超过安全池大小，纹理流送器将不断应用其预算，可能会创建流入和流出纹理的无限循环。 |
| Temporary Pool | 此值由 `r.Streaming.MaxTempMemoryAllowed` 控制，并指定调整纹理大小时流送器可用的额外内存量。变更纹理的 mip 数量时，引擎需要新建一个纹理（无论大小），用于保存之后的 mip 数据。这能间接控制进行中请求的数量，因为流送器将向 IO 系统发送临时池允许的请求数量。 注意：临时池最小尺寸必须与需要流送的最大资源相同，但设为过大会浪费内存（因其正是为此目的而预留）。从另一方面而言，设为过小会减缓流送速度（无法为 IO 系统生成足够的工作，使其进入待机状态）。此外还需注意：流送器无法对进行中请求内的处理顺序进行较大程度的控制。这意味着使用相对较小的临时池可更大程度地控制加载顺序。 |
| Streaming Pool | 纹理流送器可用的内存量。流送器通常会将所有可用内存用于流送新 mip，或将之前流送的 mip 尽可能久地保存在内存中。流送池（Streaming Pool）包含可见 Mip（Visible Mip）、隐藏 Mip（Hidden Mip）、强制 Mip（Force Mip）和缓存 Mip（Cached Mip）。**Streaming Pool** 约等于 **Visible Mips*** + **Hidden Mips** + **Forced Mips** + **Cached Mips**（完全使用时为 *:，否则未使用的空间必须被占用） |
| NonStreaming Mips | 非流送分配使用的内存量。如这些分配因超过安全池的值而出现定期波动，这将影响流送池的预算，应避免出现此状况（减少分配次数或增加安全池）。 |
| Required Pool | 纹理流送器需要根据其指标加载的 mip 数据量。这可超过纹理流送池的 100%，但同时也会进行一些妥协，部分纹理将不会以其所要求的分辨率加载。 |
| Visible Mips | 可见纹理 mip 当前占用的所需内存。这并不包含强制 mip。 |
| Hidden Mips | 非可见纹理 mip 当前占用的所需内存。这并不包含强制 mip。为防止首次显示纹理时出现低精度纹理，流送器会提前预流送纹理，但通常会比所需要的少一个 mip（详见 [`r.Streaming.HiddenPrimitiveScale`](../texture-streaming-configuration/index.md)）。 |
| Forced Mips | 强制流入纹理当前占据的所需内存。纹理通常通过游戏性机制在一小段时间内强制流入。这并不包含被标记为不可流送的纹理。 |
| Cached Mips | 不再需要的纹理 mip 所占据的内存。它们将被缓存，除非其内存被其他所需的 mip 占据。 |
| Wanted Pool | 将逐渐被流入的所需池的部分。 |
| Wanted Mips | 实际流入的所需池大小。达到 100% 后，流送器将停止发送 IO 请求加载新 mip。**Wanted Mips** 等于 **Visible Mips** + **Hidden Mips** + **Forced Mips** |
| Inflight Requests | 仍然被 IO 处理的内存量。为 0 时，所有之前的请求已在新建请求时处理。如流送器正在流送内容时出现此情况，则说明流送器未使用所有可用的带宽。增加 `r.Streaming.MaxTempMemoryAllowed`（代价是浪费的内存更多，加载顺序控制更少）或降低 `r.Streaming.FramesForFullUpdate`（代价是更新时间更长）可增加带宽。 |
| IO Bandwidth | 上次更新之后加载完成的 mip 大小，除以上次更新后的时间。用此法测算的 IO 带宽并不准确，但仍可用于确定系统加载请求的时间。 |
| 计数器 |  |
| Setup Async Task | 准备同步流送器任务数据的时间。它作为完整更新循环的第一步运行。 |
| Update Streaming Data | 这是用于增量更新流送数据的时间。这包括刷新可视性、更新纹理状态，更新已使用动态组件的边界。如 `r.Streaming.FramesForFullUpdate` 所定义，该步骤将连续运行数帧。 |
| Streaming Texture | 准备和发送加载与取消请求所需的时间。 |

## 新加载关卡的增量处理

从虚幻引擎 4.15 版本起，纹理流送器将增量处理关卡数据，只是帧和帧中加载和显示之间的一点时间。 之前的版本中，此处理将会发生在关卡显示的帧中，执行操作时将出现一些明显的卡顿。

每帧处理的工作量由 `r.Streaming.NumStaticComponentsProcessedPerFrame` 控制，其默认值为 50。 将此值设为 **0** 后将禁用增量工作，使系统以 4.15 版本之前的操作进行工作。

> [!NOTE]
> 必须指出的是，增量关卡处理只会应用到移动性（Mobility） 设为 **静态（Static）** 的组件。可移动组件在引擎 tick 中固定为增量处理。

增量处理完成后，关卡显示之前则不再需要进行处理。如它在增量处理完成之前显示， 那么所有等待的工作需要立即完成，进行此操作时会出现较小的卡顿。

运行此控制台命令即可调查增量处理：

```
	Stat Streaming SortBy=name 
```

开销包括在 *Update Streaming Data* 类目中。

## 性能

4.15 版本对纹理流送器进行了改良，以下信息列表用一些具体指标描述了改良目标，具体说明了改良内容。

### 减少纹理流送器占据的纹理数量

此改良通过处理每个组件的可见性实现。非可见和隐藏组件使用的纹理流送时少一个 mip，作为预取。 新增的逐材质纹理流送数据可正确计算细节贴图之类的资源应用到 UV 通道的比例。

最后，此处的其他改良来自对静态几何体（较小）逐材质边界的计算。

以下指标取自 Paragon 关卡中的 3 个不同视点。

| 所需纹理池 | 前 | 后 | 可见量 |
| --- | --- | --- | --- |
| Startup | 678 MB | 564 MB | 370 MB |
| Side Lane of Map | 796 MB | 597 MB | 308 MB |
| Middle Lane of Map | 1086 MB | 674 MB | 271 MB |

## 减少可见纹理流入的时间

为减少可见纹理的流入时间（除减少整体纹理预算外），流送器将保存一个可见 mip 和已纳入预算 mip 的表。 通过从已纳入预算的 mip 中追踪可见 mip，流送器可在流入预取和强制加载数据前流入可见数据。

以下指标取自 Paragon 关卡中的 3 个不同视点。

| 加载可见 mip | 前 | 后 |
| --- | --- | --- |
| Startup | 20s | 10s |
| Side Lane of Map | 19s | 9s |
| Middle Lane of Map | 20s | 6s |

### 减少流送器占用的 CPU 时间

已将动态组件处理移至同步纹理流送任务，改善占用的 CPU 时间。此外还有其他改良， 如超出预算的处理和纹理加载顺序的确定。

下例中显示了 Paragon 中最差更新帧的改良。

| 游戏线程更新开销 | 前 | 后 |
| --- | --- | --- |
| Worst Update Frame | 1.1 ms | 0.6 ms |

该部分的另一个重要改良是关卡已加载但尚未显示时新加载关卡流送数据的增量处理。

| 游戏线程关卡加载开销 | 前 | 后 |
| --- | --- | --- |
| Incemental Update | 150 ms | 3 ms |

### 消除低精度和不良操作

网格体 UV 密度按每个材质计算，而非每个网格体计算。该新数据还会考虑到 LOD。 这能解决多数纹理分辨率较低的问题。

此外，来自组件的纹理流送支持更广，包括粒子系统和实例化网格体。 这能解决其他的低精度问题，有时还能解决内存消耗过高的问题。

### 无需对不同内存预算进行手动调整

纹理流送器无法自动匹配不同的内存预算，必须进行手动调整。 流送器将使用不同的启发法选择需要减少的纹理，将视觉影响减至最小。

只有最少量的纹理会收到影响，且效果因不同区域而异，不同区域的效果削减均不相同。

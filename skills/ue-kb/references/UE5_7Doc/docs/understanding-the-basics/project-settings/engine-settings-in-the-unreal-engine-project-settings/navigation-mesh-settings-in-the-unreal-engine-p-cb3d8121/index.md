---
title: "寻路网格体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/navigation-mesh-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "寻路网格体"]
---

# 寻路网格体

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 寻路网格体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/navigation-mesh-settings-in-the-unreal-engine-project-settings

## 寻路网格体

### 显示信息

| **分段** | **说明** |
| --- | --- |
| **绘制三角形边缘（Draw Triangle Edges）** | 绘制每个寻路网格体的三角形的边缘。 |
| **绘制多边形边缘（Draw Poly Edges）** | 绘制每个多边形的边缘（即，不仅仅是边界边缘）。 |
| **绘制实心多边形（Draw Filled Polys）** | 如果禁用，将不会填充绘制的寻路网格体多边形。 |
| **绘制寻路网格体边缘（Draw NavMesh Edges）** | 绘制边界边缘。 |
| **绘制图块边界（Draw Tile Bounds）** | 绘制图块边界。 |
| **绘制路径碰撞几何体（Draw Path Colliding Geometry）** | 绘制传递到寻路网格体生成器的输入几何体。 推荐通过编辑器中的视口显示标记禁用其他几何体渲染。 |
| **绘制图块标签（Draw Tile Labels）** | 绘制图块的标签。 |
| **绘制多边形索引（Draw Polygon Indices）** | 为每个多边形绘制标记，以指示其多边形和图块索引。 |
| **绘制多边形成本（Draw Polygon Costs）** | 为每个多边形绘制标记，以指示其默认和固定成本。 |
| **绘制多边形标记（Draw Polygon Flags）** | 为每个多边形绘制标记，指示其多边形和区域标记。 |
| **在路径节点上绘制标记（Draw Labels on Path Nodes）** | 在路径节点上绘制标记。 |
| **绘制寻路链接（Draw Nav Links）** | 绘制寻路链接。 |
| **绘制失败的寻路链接（Draw Failed Nav Links）** | 绘制失败的寻路链接。 |
| **绘制群集（Draw Clusters）** | 绘制寻路网格体的群集和群集链接（需要 `WITH_NAVMESH_CLUSTER_LINKS=1` ）。 |
| **绘制八叉树（Draw Octree）** | 绘制每个寻路网格体的三角形的边缘。 |
| **绘制八叉树细节（Draw Octree Details）** | 绘制八叉树细节。 |
| **绘制标记的禁止多边形（Draw Marked Forbidden Polys）** | 绘制经过标记的禁止多边形。 |
| **绘制偏移（Draw Offset）** | 添加到寻路网格体的调试表示以提高可读性的垂直偏移。 |

### 图块生成调试

| **分段** | **说明** |
| --- | --- |
| **启用图块生成调试（Tile Generation Debug Enabled）** | 如果设置，将在图块生成期间保留所选内部调试数据，随寻路网格体显示。 |
| **图块坐标（Tile Coordinate）** | 所选图块将保留其内部数据。 使用 **绘制图块标记（Draw Tile Labels）** 显示寻路网格体将显示图块坐标。 |
| **来自光栅化的实心高度场（Heightfield Solid from Rasterization** | 来自光栅化的实心高度场。 |
| **实心高度场柱体半径筛选（Heightfield Solid Post Radius Filtering** | 实心高度场柱体半径筛选。 |
| **实心高度场柱体高度筛选（Heightfield Solid Post Height Filtering** | 实心高度场柱体高度筛选。 |
| **紧凑高度场（Compact Heightfield）** | 紧凑高度场。 |
| **紧凑高度场被侵蚀（Compact Heightfield）** | 紧凑高度场被侵蚀。 |
| **紧凑高度场区域（Compact Heightfield Regions）** | 紧凑高度场区域。 |
| **紧凑高度场距离（Compact Heightfield Distances）** | 紧凑高度场距离。 |
| **图块缓存层面积（Tile Cache Layer Areas）** | 图块缓存层面积。 |
| **图块缓存层区域（Tile Cache Layer Regions）** | 图块缓存层区域。 |
| **图块缓存轮廓线（Tile Cache Contours）** | 图块缓存轮廓线。 |
| **图块缓存多边形网格体（Tile Cache Poly Mesh）** | 图块缓存多边形网格体。 |
| **图块缓存细节网格体（Tile Cache Detail Mesh）** | 图块缓存细节网格体。 |

| **分段** | **说明** |
| --- | --- |
| **启用绘制（Enable Drawing）** | 启用后，如果编辑器偏好设置中启用了“显示寻路”标记时，将在关卡中显示构建的寻路数据。默认情况下，按 **P** 键可切换开启/关闭。 |

### 生成

| **分段** | **说明** |
| --- | --- |
| **固定图块池大小（Fixed Tile Pool Size）** | 如果启用，寻路网格体将为图块分配固定大小的池。 应该启用它以支持流送。 |
| **图块池大小（Tile Pool Size）** | 寻路网格体可以容纳的图块的最大数量。 |
| **以虚幻单位计的图块大小（Tile Size UU）** | 单个寻路图块的大小，以虚幻单位表示（1 UU = 1 cm）。 |
| **单元格大小（Cell Size）** | 体素化单元格的水平大小。 |
| **单元格高度（Cell Height）** | 体素化单元格的垂直大小。 |
| **代理半径（Agent Radius）** | 遍历该寻路网格体的最小代理的半径。 |
| **代理高度（Agent Height）** | 能够使用此寻路网格体寻路的最高代理的高度。 |
| **代理最大坡度（Agent Max Slope）** | 代理可以行走的最大坡度。 |
| **代理最大阶梯高度（Agent Max Step Height）** | 代理可以攀爬的垂直阶梯的最大高度。 |
| **最小区域面积（Min Region Area）** | 区域的最低尺寸。 比这更小的区域将废弃。 |
| **合并区域大小（Merge Region Size）** | 能够与更大区域合并的区域的大小限制（仅限分水岭分区）。 |
| **最大简化误差（Max Simplification Error）** | 定义可寻路形状能够简化的程度。值越高，自由度越大，约束越少。 |
| **按成本对寻路区域排序（Sort Navigation Areas by Cost）** | 在NavMesh生成过程中，控制是否在将寻路区域应用到NavMesh之前，将其按成本排序。 当有区域相重叠，并且你也想让区域成本表示区域相关性时，这样做是有意义的。 启用此选项会按成本对区域排序，但这也会使寻路网格体的生成成本有所上升。 |
| **世界是否分区（Is World Partitioned）** | 在世界分区地图中，定义此寻路网格体是否使用世界分区。 |
| **最大同时图块生成作业数量（Max Simultaneous Tile Generation Jobs Count）** | 设置可同时运行的异步图块生成器的上限。也用于一些同步任务。 |
| **图块数量硬限制（Tile Number Hard Limit）** | 寻路网格体图块数量的绝对硬限制。 如果你的项目中有带寻路网格体的大型地图，修改此设置要格外谨慎。 单个空图块占据176字节，并且空图块会提前分配这（在未来版本中可能会发生变化）。 `TileNumberHardLimit` 总是会向上取整到最接近2的幂。 |
| **多边形引用图块位（Poly Ref Tile Bits）** | 多边形引用图块位。 |
| **多边形引用寻路多边形位（Poly Ref Nav Poly Bits）** | 多边形引用寻路多边形位。 |
| **多边形引用盐位（Poly Ref Salt Bits）** | 多边形引用盐位。 |
| **寻路网格体原点偏移（NavMesh Origin Offset）** | 如果你不希望图块在 `(0,0,0)` 开始，则设置此值。 |
| **区域分区（Region Partitioning）** | 创建寻路网格体多边形的分区方法。 你可以从以下选项中选择： **单色调（Monotone）** **分水岭（Watershed）** **大块单色调（Chunky Monotone）** |
| **层分区（Layer Partitioning）** | 创建图块层的分区方法。 你可以从以下选项中选择： **单色调（Monotone）** **分水岭（Watershed）** **大块单色调（Chunky Monotone）** |
| **区域数据块拆分（Region Chunk Splits）** | 当你在 **区域分区（Region Partitioning）** 设置中选择 **大块单色调（Chunky Monotone）** 选项时，确定要沿每个轴使用多少数据块划分当前区域。 |
| **层数据块拆分（Layer Chunk Splits）** | 当你在 **层分区（Layer Partitioning）** 设置中选择 **大块单调（Chunky Monotone）** 选项时，确定要沿每个轴划使用多少数据块分当前层。 |
| **执行体素筛选（Perform Voxel Filtering）** | 控制是否要应用体素筛选（通过 `FRecastTileGenerator::ApplyVoxelFilter`）。 这将生成更适合寻路边界的寻路网格体，但生成性能会有所降低。 |
| **标记低高度区域（Mark Low Height Areas）** | 标记上方自由高度不足的区域，而不是将其切除（只有使用替换模式的区域修饰体积可以访问）。 |
| **标记区域时使用额外顶部单元格（Use Extra Top Cell when Marking Areas）** | 应用到寻路网格体时，将区域寻路修饰体积的边界顶部扩展一个单元格的高度。 |
| **筛选低跨度序列（Filter Low Span Sequences）** | 如果设置，在有效高度跨度下只允许一个低高度跨度。 |
| **筛选图块缓存中的低跨度（Filter Low Span from Tile Cache）** | 如果设置，图块缓存将只保存带对应区域修饰体积的低高度跨度（可减少内存占用，但修改后必须完全重新构建图块）。 |
| **执行完全异步寻路数据采集（Do Fully Async Nav Data Gathering）** | 如果设置，将不会在游戏线程上进行寻路网格体数据采集，而只会在后台线程上执行它。 |

### 查询

| **分段** | **说明** |
| --- | --- |
| **启发式比例（Heuristic Scale）** | 查找路径时使用的欧氏距离启发式比例。 |
| **地面垂直偏差补偿（Vertical Deviation from Ground Compensation）** | 为补偿寻路网格体多边形与可行走几何体之间误差而添加到每个搜索高度的值。 |

### 运行时

| **分段** | **说明** |
| --- | --- |
| **加载时强制重新构建（Force Rebuild on Load）** | 默认情况下，寻路将在成功加载后跳过第一次更新。 将 `bForceRebuildOnLoad` 设置为false可以重载此行为。 |
| **无寻路时自动销毁（Auto-Destroy when No Navigation）** | 定义在创建或加载世界时，如果世界中没有寻路系统，这个实例是否应该销毁自己。 |
| **运行时生成（Runtime Generation）** | 寻路数据运行时生成选项。 你可以从以下选项中选择： **静态（Static）** **仅动态修饰体积（Dynamic Modifiers Only）** **动态（Dynamic）** |
| **观测路径更新间隔（Observed Paths Tick Interval）** | 所有观测路径将每 `ObservedPathsTickInterval` 秒处理一次。 |
| **可以是主寻路数据（Can Be Main Nav Data）** | 设置后，寻路数据可以在寻路系统的查询中充当默认数据。 |
| **可以在重新构建时生成（Can Spawn on Rebuild）** | 设置后，如果Actor不存在，将在重新构建期间在持久关卡中生成寻路数据。 |

### 更新

| **分段** | **说明** |
| --- | --- |
| **允许在开始播放之前更新（Allow Tick Before Begin Play）** | 定义是否允许此Actor在收到 `BeginPlay` 事件之前更新。 正常情况下，Actor只应该在 `BeginPlay` 之后更新。此设置允许重载此行为。 此Actor必须能够更新，此设置才有意义。 |

### 碰撞

| **分段** | **说明** |
| --- | --- |
| **在关卡流送期间生成重叠事件（Generate Overlap Events During Level Streaming）** | 如果为true，此Actor将在作为关卡流送（包括初始关卡加载）的一部分生成时，生成重叠开始/结束事件。 如果流送关卡是围绕某个Actor加载的，且你想要触发开始/结束重叠事件，请启用此项。 请参阅此分段中的 **在关卡流送期间更新重叠方法（Update Overlaps Method During Level Streaming）** 设置。 |
| **在关卡流送期间更新重叠方法（Update Overlaps Method During Level Streaming）** | 在关卡流送中被加载时，调用 `UpdateOverlaps()` 来初始化重叠状态的条件。 如果设置为 `UseConfigDefault`，将使用 `.ini` 中指定的默认值（显示在 `DefaultUpdateOverlapsMethodDuringLevelStreaming` 中）。 如果不初始化重叠状态，此Actor及其附加组件将不知道哪些对象正与其接触，只有当其中一个对象自行更新了重叠状态之后（例如，在移动时）才能触发重叠事件。 但是，如果接触它的对象确实初始化了状态，两个对象都将知道彼此的接触状态。 这有可能在关卡加载和流送期间大幅节省性能，并且如果该对象和一开始就之重叠的其他对象不需要重叠状态，这种情况就是安全的，因为它们不会触发重叠通知。 你可以从以下选项中选择： **使用配置默认值（Use Config Default）** **总是更新（Always Update）** **只更新可移动对象（Only Update Movable）** **从不更新（Never Update）** 如果 `bGenerateOverlapEventsDuringLevelStreaming` 为true，在这种情况下总是会更新重叠，但该标记会确定是否触发开始/结束重叠事件。 具体请参阅 `bGenerateOverlapEventsDuringLevelStreaming`、`DefaultUpdateOverlapsMethodDuringLevelStreaming`、`GetUpdateOverlapsMethodDuringLevelStreaming()`。 |
| **在关卡流送期间默认更新重叠方法（Default Update Overlaps Method During Level Streaming）** | 为 `UpdateOverlapsMethodDuringLevelStreaming` 选择 `UseConfigDefault` 时，从该类的配置文件中获取的默认值。 这允许在匹配的配置中为每个类选择一个默认值。 例如，对于Actor，可以在 `DefaultEngine.ini` 中指定为： `[/Script/Engine.Actor] DefaultUpdateOverlapsMethodDuringLevelStreaming = OnlyUpdateMovable` 另一个子类可以将其默认值设置为不同的值，例如： `[/Script/Engine.BlockingVolume] DefaultUpdateOverlapsMethodDuringLevelStreaming = NeverUpdate` 具体请参阅 `UpdateOverlapsMethodDuringLevelStreaming`。 |
|  | [/Script/Engine.Actor] |
|  | DefaultUpdateOverlapsMethodDuringLevelStreaming = OnlyUpdateMovable |
|  |  |
|  | [/Script/Engine.BlockingVolume] |
|  | DefaultUpdateOverlapsMethodDuringLevelStreaming = NeverUpdate |
|  |  |
| **对于关卡边界有意义（Relevant for Level Bounds）** | 如果为true，此Actor的组件边界将被包含在关卡的边界框中，除非Actor的类已重载 `IsLevelBoundsRelevant` 。 |

### HLOD

| **分段** | **说明** |
| --- | --- |
| **在HLOD中包含Actor（Include Actor in HLOD）** | 指定在HLOD生成期间是否应考虑此Actor。 |
| **HLOD层（HLOD Layer）** | 此Actor应包含在的UHLODLayer。 |

### 世界分区

| **分段** | **说明** |
| --- | --- |
| **运行时网格（Runtime Grid）** | 确定此Actor将放置在分区中的哪个分区网格中（如果世界采用了分区）。 如果设置为 `None`，将由分区做决定。 |
| **是否空间化加载（Is Spatially Loaded）** | 确定在将Actor放入在分区世界中时，是否对其进行空间化加载。 如果为true，此Actor将在以下条件下加载：位于任意流送源的范围内，并且(1)不在数据层内，或者(2)启用了其中一个或多个数据层。 如果为false，此Actor将在以下条件下加载：(1)不在数据层内，或者(2)启用了其中一个或多个数据层。 |

### 烘焙

| **分段** | **说明** |
| --- | --- |
| **为编辑器限定Actor（Is Editor Only Actor）** | 定义此Actor是否仅限编辑器。 请谨慎使用，因为如果有任何其他项引用了此Actor，该引用在烘焙的版本中将变成 `NULL` 。 |
| **生成优化蓝图组件数据（Generate Optimized Blueprint Component Data）** | 定义是否为基于此Actor的所有蓝图类烘焙额外数据，以在运行时加速生成事件。 此选项可能会略微增加烘焙版本中的内存使用量。 |

### 数据层

| **分段** | **说明** |
| --- | --- |
| **数据层（Data Layers）** | Actor所属的 `DataLayers` 。 |

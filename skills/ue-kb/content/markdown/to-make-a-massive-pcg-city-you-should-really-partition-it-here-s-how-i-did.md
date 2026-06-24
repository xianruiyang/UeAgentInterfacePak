# To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did

# To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did

## 知识目标

- 围绕“To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`Spline`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Loop`、`Graph`、`Instance`、`buildings`、`PCG Graph`、`PCG Component`、`Spline Sampler`、`Volume`、`Static Mesh Spawner`、`Spline Mesh`、`Create Spline`

## 分段知识

### 00:00:00-00:04:49 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG`、`Point`、`Spline`、`Filter`、`Partition`、`Random`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s01-02-S01_2_00_02_24.jpg)

### 00:04:49-00:09:42 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Spline`、`Spline Sampler`、`Create Spline`、`Loop`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s02-01-S02_1_00_04_59.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s02-02-S02_2_00_07_15.jpg)

### 00:09:42-00:14:37 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Bounds`、`Spline`、`Static Mesh`、`Static Mesh Spawner`、`Create Spline`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s03-01-S03_1_00_09_52.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s03-02-S03_2_00_12_09.jpg)

### 00:14:37-00:17:43 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：PCG Component 的 Graph Instance / Parameter Overrides 用于覆盖图表参数，复现时要确认实例参数已勾选并生效。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG Component`、`PCG`、`Point`、`Spline`、`Volume`、`Actor`、`Static Mesh`、`Filter`、`Partition`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s04-01-S04_1_00_14_47.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s04-02-S04_2_00_16_10.jpg)

### 00:17:43-00:20:51 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`Point`、`Bounds`、`Actor`、`Static Mesh`、`Static Mesh Spawner`、`Partition`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s05-01-S05_1_00_17_53.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s05-02-S05_2_00_19_17.jpg)

### 00:20:52-00:24:32 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Spline`、`Static Mesh`、`Spline Mesh`、`Create Spline`、`Partition`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s06-01-S06_1_00_21_02.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s06-02-S06_2_00_22_42.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


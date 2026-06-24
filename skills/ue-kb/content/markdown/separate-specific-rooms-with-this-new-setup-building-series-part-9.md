# Separate Specific Rooms With This New Setup ｜ Building Series Part 9

# Separate Specific Rooms With This New Setup ｜ Building Series Part 9

## 知识目标

- 围绕“Separate Specific Rooms With This New Setup ｜ Building Series Part 9”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及 Dynamic Mesh 或 Geometry Script 时，先小规模验证布尔、倒角、修补和 UV，再扩展到批量生成。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`Spline`、`Transform`、`Point`、`Actor`、`Density`、`Random`、`Loop`、`Graph`、`Instance`、`points`、`plug`、`node`、`PCG Graph`、`Point Data`、`Spline Sampler`、`Transform Points`、`Filter`、`Branch`、`Boolean`

## 分段知识

### 00:00:00-00:03:25 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：自定义 Blueprint Element 要把输入/输出类型改为 Dynamic Mesh，并在执行图里 Cast 到 PCG Dynamic Mesh Data。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG Graph`、`PCG`、`Point Data`、`Point`、`Blueprint`、`Loop`、`Random`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s01-02-S01_2_00_01_42.jpg)

### 00:03:25-00:07:05 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Point Data`、`Point`、`Density`、`Loop`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s02-01-S02_1_00_03_35.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s02-02-S02_2_00_05_15.jpg)

### 00:07:05-00:11:55 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Point Data`、`Point`、`Branch`、`Loop`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s03-01-S03_1_00_07_15.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s03-02-S03_2_00_09_30.jpg)

### 00:11:55-00:15:22 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`Point`、`Density`、`Branch`、`Geometry Script`、`Dynamic Mesh`、`Boolean`、`Instance`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s04-01-S04_1_00_12_05.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s04-02-S04_2_00_13_39.jpg)

### 00:15:23-00:20:19 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Density`、`Spline`、`Spline Sampler`、`Actor`、`Blueprint`、`Filter`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s05-01-S05_1_00_15_33.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s05-02-S05_2_00_17_51.jpg)

### 00:20:19-00:25:10 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Point Data`、`Point`、`Density`、`Transform Points`、`Loop`、`Random`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s06-01-S06_1_00_20_29.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s06-02-S06_2_00_22_45.jpg)

### 00:25:11-00:29:47 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`PCG`、`Point Data`、`Point`、`Density`、`Filter`、`Branch`、`Loop`、`Geometry Script`、`Dynamic Mesh`、`Boolean`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s07-01-S07_1_00_25_21.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s07-02-S07_2_00_27_29.jpg)

### 00:29:47-00:30:51 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Blueprint`、`Static Mesh`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p16/s08-01-S08_1_00_29_57.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p16/s08-02-S08_2_00_30_19.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。
- Dynamic Mesh/Geometry Script 流程要单独测试布尔、倒角、网格修补、UV 和保存 Static Mesh 的成本。


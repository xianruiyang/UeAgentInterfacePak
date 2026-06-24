# The Missing Piece in Most UE5 PCG City Generators： Districts!

# The Missing Piece in Most UE5 PCG City Generators： Districts!

## 知识目标

- 围绕“The Missing Piece in Most UE5 PCG City Generators： Districts!”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及 Dynamic Mesh 或 Geometry Script 时，先小规模验证布尔、倒角、修补和 UV，再扩展到批量生成。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`Point Filter`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Loop`、`Graph`、`PCG Graph`、`Spline Sampler`、`Volume`、`Create Spline`、`Partition`、`Geometry Script`

## 分段知识

### 00:00:00-00:04:52 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Density`、`Spline`、`Actor`、`Blueprint`、`Loop`、`Geometry Script`、`Dynamic Mesh`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s01-02-S01_2_00_02_26.jpg)

### 00:04:52-00:08:59 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Bounds`、`Spline`、`Spline Sampler`、`Volume`、`Actor`、`Static Mesh`、`Loop`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s02-01-S02_1_00_05_02.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s02-02-S02_2_00_06_55.jpg)

### 00:08:59-00:13:25 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Attribute`、`Bounds`、`Spline`、`Volume`、`Actor`、`Create Spline`、`Loop`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s03-01-S03_1_00_09_09.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s03-02-S03_2_00_11_12.jpg)

### 00:13:25-00:18:24 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Attribute`、`Spline`、`Create Spline`、`Partition`、`Loop`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s04-01-S04_1_00_13_35.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s04-02-S04_2_00_15_54.jpg)

### 00:18:24-00:21:39 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s05-01-S05_1_00_18_34.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s05-02-S05_2_00_20_02.jpg)

### 00:21:39-00:25:58 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Attribute`、`Bounds`、`Spline`、`Blueprint`、`Random`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s06-01-S06_1_00_21_49.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s06-02-S06_2_00_23_49.jpg)

### 00:25:58-00:28:04 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Attribute`、`Spline`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p86/s07-01-S07_1_00_26_08.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p86/s07-02-S07_2_00_27_01.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。
- Dynamic Mesh/Geometry Script 流程要单独测试布尔、倒角、网格修补、UV 和保存 Static Mesh 的成本。


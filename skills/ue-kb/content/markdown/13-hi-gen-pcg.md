# 13 Hi Gen分区：大规模PCG工作流

# 13 Hi Gen分区：大规模PCG工作流

## 知识目标

- 围绕“13 Hi Gen分区：大规模PCG工作流”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及运行时、World Partition、Hierarchical Generation 或 GPU 节点时，单独验证触发模式、缓存和性能。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Seed`、`Graph`、`Material`、`Instance`、`GPU`、`图表`、`点`、`采样`、`分区`、`生成`

## 分段知识

### 00:00:07-00:04:53 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 知识点：GPU PCG 节点能提升运行时生成吞吐，但 CPU/GPU 数据传输会形成边界，图表中要减少不必要的跨设备传递。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`Actor`、`图表`、`点`、`点数据`、`采样`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s01-01-S01_1_00_00_17.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s01-02-S01_2_00_02_30.jpg)

### 00:04:53-00:09:40 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Difference 节点根据连接对象的 Bounds 移除相交点；如果需要保留相交区域，应改用交集或反向过滤逻辑。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Bounds`、`Actor`、`图表`、`点`、`点数据`、`采样`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s02-02-S02_2_00_07_17.jpg)

### 00:09:40-00:14:39 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Bounds`、`点`、`点数据`、`采样`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s03-01-S03_1_00_09_50.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s03-02-S03_2_00_12_10.jpg)

### 00:14:39-00:19:13 运行时生成、分区与性能

- 本段定位：运行时生成、分区与性能。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：GPU PCG 节点能提升运行时生成吞吐，但 CPU/GPU 数据传输会形成边界，图表中要减少不必要的跨设备传递。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG`、`GPU`、`图表`、`点`、`采样`、`分区`、`生成`、`网格`、`运行时`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s04-01-S04_1_00_14_49.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s04-02-S04_2_00_16_56.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


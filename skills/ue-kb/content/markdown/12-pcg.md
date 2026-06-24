# 12 PCG+世界分区

# 12 PCG+世界分区

## 知识目标

- 围绕“12 PCG+世界分区”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及运行时、World Partition、Hierarchical Generation 或 GPU 节点时，单独验证触发模式、缓存和性能。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Grid`、`Bounds`、`Density`、`Random`、`Seed`、`Graph`、`Material`、`Instance`、`Landscape`、`网格`、`Partition`、`World Partition`、`图表`、`组件`、`点`、`采样`

## 分段知识

### 00:00:00-00:04:39 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG`、`Partition`、`World Partition`、`图表`、`点`、`属性`、`过滤`、`分区`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s01-02-S01_2_00_02_20.jpg)

### 00:04:39-00:09:31 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Niagara 或组件输出应挂在筛选后的 PCG 点上，先核对点位置、随机偏移和实例数量，再接入 Niagara Component。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 知识点：Transform Points 的坐标空间会影响点集是按世界坐标生成，还是围绕组件本地空间生成。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG`、`Partition`、`World Partition`、`图表`、`组件`、`点`、`属性`、`过滤`、`分区`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s02-01-S02_1_00_04_49.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s02-02-S02_2_00_07_05.jpg)

### 00:09:31-00:14:22 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 知识点：Transform Points 的坐标空间会影响点集是按世界坐标生成，还是围绕组件本地空间生成。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`、`分区`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s03-01-S03_1_00_09_41.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s03-02-S03_2_00_11_57.jpg)

### 00:14:22-00:19:21 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Actor`、`图表`、`点`、`属性`、`过滤`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s04-01-S04_1_00_14_32.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s04-02-S04_2_00_16_51.jpg)

### 00:19:21-00:24:19 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 知识点：Difference 节点根据连接对象的 Bounds 移除相交点；如果需要保留相交区域，应改用交集或反向过滤逻辑。
- 知识点：World Partition 与 Hierarchical Generation 按网格层级缓存和生成 PCG 数据，复现时要核对分区尺寸、触发范围和缓存状态。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`图表`、`组件`、`点`、`点数据`、`采样`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s05-01-S05_1_00_19_31.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s05-02-S05_2_00_21_50.jpg)

### 00:24:19-00:24:59 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s06-01-S06_1_00_24_27.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s06-02-S06_2_00_24_39.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


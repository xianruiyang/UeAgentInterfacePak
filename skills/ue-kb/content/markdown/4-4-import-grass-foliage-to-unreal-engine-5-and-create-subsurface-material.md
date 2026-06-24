# 4 4 Import Grass Foliage to Unreal Engine 5 and create Subsurface Material

# 4 4 Import Grass Foliage to Unreal Engine 5 and create Subsurface Material

## 知识目标

- 围绕“4 4 Import Grass Foliage to Unreal Engine 5 and create Subsurface Material”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`Spline`、`Point`、`Random`、`Mask`、`Material`、`Instance`、`Landscape`、`grass`、`more`、`good`、`foliage`、`some`、`Branch`

## 分段知识

### 00:00:00-00:03:05 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s01-02-S01_2_00_01_32.jpg)

### 00:03:08-00:06:10 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s02-01-S02_1_00_03_18.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s02-02-S02_2_00_04_39.jpg)

### 00:06:14-00:09:08 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Static Mesh`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s03-01-S03_1_00_06_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s03-02-S03_2_00_07_41.jpg)

### 00:09:14-00:12:21 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s04-01-S04_1_00_09_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s04-02-S04_2_00_10_47.jpg)

### 00:12:26-00:15:07 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s05-01-S05_1_00_12_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s05-02-S05_2_00_13_47.jpg)

### 00:15:18-00:19:51 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Random`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s06-01-S06_1_00_15_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s06-02-S06_2_00_17_34.jpg)

### 00:19:56-00:22:37 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`Material`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s07-01-S07_1_00_20_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s07-02-S07_2_00_21_16.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


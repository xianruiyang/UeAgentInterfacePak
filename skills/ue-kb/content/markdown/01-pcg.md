# 01 PCG基础 数据集、点、边界、检查、调试

# 01 PCG基础 数据集、点、边界、检查、调试

## 知识目标

- 围绕“01 PCG基础 数据集、点、边界、检查、调试”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`SubGraph`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Bounds`、`Density`、`Seed`、`Graph`、`Material`、`Instance`、`Landscape`、`网格`、`体积`、`图表`、`点`、`属性`、`密度`、`边界`、`过滤`

## 分段知识

### 00:00:00-00:04:51 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：通过获取样条点数量、样条点位置和切线，计算新样条段的起止位置，再用 Spline Mesh 生成管道网格。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`图表`、`点`、`属性`、`边界`、`过滤`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p02/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p02/s01-02-S01_2_00_02_25.jpg)

### 00:04:51-00:09:35 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`点`、`属性`、`边界`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p02/s02-01-S02_1_00_05_01.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p02/s02-02-S02_2_00_07_13.jpg)

### 00:09:35-00:14:30 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：Difference 节点根据连接对象的 Bounds 移除相交点；如果需要保留相交区域，应改用交集或反向过滤逻辑。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`图表`、`点`、`属性`、`密度`、`边界`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p02/s03-01-S03_1_00_09_45.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p02/s03-02-S03_2_00_12_02.jpg)

### 00:14:30-00:19:08 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：道路或街区边界由样条/Spline Mesh 驱动，复现时要核对样条点、切线、宽度和交叉口连接。
- 知识点：建筑类型可用密度、比例或属性权重控制混合生成，检查时要看局部街区中不同楼型的分布是否符合目标比例。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`边界`、`采样`、`生成`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p02/s04-01-S04_1_00_14_40.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p02/s04-02-S04_2_00_16_49.jpg)

### 00:19:08-00:20:25 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：本段在蓝图/PCG 节点中组织数据流，复现时要核对输入输出引脚、执行顺序和写回的点属性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p02/s05-01-S05_1_00_19_18.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p02/s05-02-S05_2_00_19_47.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


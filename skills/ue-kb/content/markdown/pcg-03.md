# PCG 隧道系统 03：动态网格保存、材质槽与资产化

# PCG 隧道系统 03：动态网格保存、材质槽与资产化

## 知识目标

- 围绕“PCG 隧道系统 03：动态网格保存、材质槽与资产化”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Static Mesh`、`Mesh`、`MeshSampler`、`Point`、`Actor`、`Component`、`Spawn`、`Bounds`、`Density`、`Graph`、`Material`、`网格`、`体积`、`材质`、`属性`、`采样`、`参数`、`图表`、`组件`、`点`、`边界`、`生成`

## 分段知识

### 00:00:00-00:04:57 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh 清单、Transform、Density、Seed 和材质覆盖。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 知识点：材质覆盖应在生成器或实例参数层处理，避免把材质选择写死在单个 Static Mesh 资产中。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`组件`、`点`、`点数据`、`采样`、`生成`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p03/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p03/s01-02-S01_2_00_02_28.jpg)

### 00:04:57-00:09:37 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 知识点：Get Actor Data 可按 Actor 标签从关卡收集体积或蓝图实例，作为 PCG Graph 的外部输入。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Actor`、`图表`、`点`、`属性`、`边界`、`过滤`、`生成`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p03/s02-01-S02_1_00_05_07.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p03/s02-02-S02_2_00_07_17.jpg)

### 00:09:37-00:10:55 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`图表`、`点`、`点数据`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p03/s03-01-S03_1_00_09_47.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p03/s03-02-S03_2_00_10_16.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


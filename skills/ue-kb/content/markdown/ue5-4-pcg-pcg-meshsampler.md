# 【UE5.4 PCG教程】PCG MeshSampler节点的相关应用

# 【UE5.4 PCG教程】PCG MeshSampler节点的相关应用

## 知识目标

- 围绕“【UE5.4 PCG教程】PCG MeshSampler节点的相关应用”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`MeshSampler`、`SubGraph`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Seed`、`Graph`、`Material`

## 分段知识

### 00:00:00-00:03:00 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s01-02-S01_2_00_01_30.jpg)

### 00:03:00-00:06:00 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s02-02-S02_2_00_04_30.jpg)

### 00:06:00-00:09:00 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s03-02-S03_2_00_07_30.jpg)

### 00:09:00-00:09:22 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s04-01-S04_1_00_09_04.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s04-02-S04_2_00_09_11.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


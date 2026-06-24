# PCG 隧道系统 02：动态网格处理与隧道段生成

# PCG 隧道系统 02：动态网格处理与隧道段生成

## 知识目标

- 围绕“PCG 隧道系统 02：动态网格处理与隧道段生成”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Mesh`、`Loop`、`Graph`、`样条`、`网格`、`体积`、`材质`、`采样`、`参数`、`节点`、`生成`、`Process`、`JaysongShao`、`Dynamic`、`LOCAL`、`图表`、`组件`、`点`、`循环`、`运行时`

## 分段知识

### 00:00:00-00:04:54 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：GPU PCG 节点能提升运行时生成吞吐，但 CPU/GPU 数据传输会形成边界，图表中要减少不必要的跨设备传递。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`点`、`点数据`、`采样`、`生成`、`网格`、`运行时`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p02/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p02/s01-02-S01_2_00_02_27.jpg)

### 00:04:54-00:09:47 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：Difference 节点根据连接对象的 Bounds 移除相交点；如果需要保留相交区域，应改用交集或反向过滤逻辑。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`组件`、`点`、`样条`、`采样`、`生成`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p02/s02-01-S02_1_00_05_04.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p02/s02-02-S02_2_00_07_21.jpg)

### 00:09:48-00:10:49 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：点数据流程需要在 Inspect 中核对点数量、Bounds、Density、Transform、Seed 和自定义属性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`图表`、`点`、`点数据`、`采样`、`循环`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-tunnel-system-p02/s03-01-S03_1_00_09_58.jpg)
![关键截图 2](../assets/ue5-pcg-tunnel-system-p02/s03-02-S03_2_00_10_19.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


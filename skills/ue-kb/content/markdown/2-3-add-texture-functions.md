# 2 3 Add Texture Functions

# 2 3 Add Texture Functions

## 知识目标

- 围绕“2 3 Add Texture Functions”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及 Dynamic Mesh 或 Geometry Script 时，先小规模验证布尔、倒角、修补和 UV，再扩展到批量生成。

## 关键术语

- `Component`、`Material`、`Instance`、`Landscape`、`distance`、`blend`、`albedo`、`texture`、`logic`、`near`、`normal`、`roughness`、`tiling`、`Boolean`

## 分段知识

### 00:00:00-00:02:53 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s01-02-S01_2_00_01_26.jpg)

### 00:02:53-00:06:43 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：Auto UV 可用 X Atlas 或 Patch Builder 重新生成 UV。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s02-01-S02_1_00_03_03.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s02-02-S02_2_00_04_48.jpg)

### 00:06:43-00:11:36 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s03-01-S03_1_00_06_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s03-02-S03_2_00_09_10.jpg)

### 00:11:36-00:16:29 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s04-01-S04_1_00_11_46.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s04-02-S04_2_00_14_02.jpg)

### 00:16:29-00:19:43 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s05-01-S05_1_00_16_39.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s05-02-S05_2_00_18_06.jpg)

### 00:19:43-00:22:59 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`Geometry Script`、`Dynamic Mesh`、`Boolean`、`Material`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p11/s06-01-S06_1_00_19_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p11/s06-02-S06_2_00_21_21.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。
- Dynamic Mesh/Geometry Script 流程要单独测试布尔、倒角、网格修补、UV 和保存 Static Mesh 的成本。


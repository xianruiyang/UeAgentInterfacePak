# 2 13 Add Parallax Occlusion with Displacement and LightVector

# 2 13 Add Parallax Occlusion with Displacement and LightVector

## 知识目标

- 围绕“2 13 Add Parallax Occlusion with Displacement and LightVector”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `Blueprint`、`Actor`、`Component`、`Graph`、`Mask`、`Material`、`Instance`、`Landscape`、`displacement`、`shadow`、`shadows`、`texture`、`vector`、`light`、`Branch`

## 分段知识

### 00:00:00-00:04:04 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s01-02-S01_2_00_02_02.jpg)

### 00:04:06-00:09:00 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s02-01-S02_1_00_04_16.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s02-02-S02_2_00_06_33.jpg)

### 00:09:01-00:14:00 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s03-01-S03_1_00_09_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s03-02-S03_2_00_11_30.jpg)

### 00:14:01-00:17:33 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s04-01-S04_1_00_14_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s04-02-S04_2_00_15_47.jpg)

### 00:17:37-00:20:34 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s05-01-S05_1_00_17_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s05-02-S05_2_00_19_05.jpg)

### 00:20:38-00:24:08 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Blueprint`、`Material`、`Instance`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s06-01-S06_1_00_20_48.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s06-02-S06_2_00_22_23.jpg)

### 00:24:11-00:29:02 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Blueprint`、`Material`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s07-01-S07_1_00_24_21.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s07-02-S07_2_00_26_37.jpg)

### 00:29:03-00:32:15 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s08-01-S08_1_00_29_13.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s08-02-S08_2_00_30_39.jpg)

### 00:32:19-00:35:29 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s09-01-S09_1_00_32_29.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s09-02-S09_2_00_33_54.jpg)

### 00:35:33-00:39:04 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s10-01-S10_1_00_35_43.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s10-02-S10_2_00_37_18.jpg)

### 00:39:07-00:42:22 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s11-01-S11_1_00_39_17.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s11-02-S11_2_00_40_44.jpg)

### 00:42:24-00:47:15 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Actor`、`Blueprint`、`Branch`、`Material`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s12-01-S12_1_00_42_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s12-02-S12_2_00_44_49.jpg)

### 00:47:15-00:50:11 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s13-01-S13_1_00_47_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s13-02-S13_2_00_48_43.jpg)

### 00:50:14-00:51:31 PCG 数据流与生成规则

- 本段定位：PCG 数据流与生成规则。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p21/s14-01-S14_1_00_50_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p21/s14-02-S14_2_00_50_52.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


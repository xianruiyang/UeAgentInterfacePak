# 5 6 Create a Cinematic with the Movie Render Queue

# 5 6 Create a Cinematic with the Movie Render Queue

## 知识目标

- 围绕“5 6 Create a Cinematic with the Movie Render Queue”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Mesh`、`Spline`、`Transform`、`Actor`、`Random`、`Mask`、`Material`、`Instance`、`Landscape`、`camera`、`Volume`、`Spline Mesh`、`ISM`

## 分段知识

### 00:00:00-00:04:49 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`Volume`、`Actor`、`Spline Mesh`、`Material`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s01-02-S01_2_00_02_24.jpg)

### 00:04:51-00:09:40 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 核对对象：`PCG`、`Actor`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s02-01-S02_1_00_05_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s02-02-S02_2_00_07_15.jpg)

### 00:09:40-00:13:10 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 核对对象：`PCG`、`Actor`、`Material`、`Instance`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s03-01-S03_1_00_09_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s03-02-S03_2_00_11_25.jpg)

### 00:13:15-00:16:47 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`Actor`、`Random`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s04-01-S04_1_00_13_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s04-02-S04_2_00_15_01.jpg)

### 00:16:51-00:21:43 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s05-01-S05_1_00_17_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s05-02-S05_2_00_19_17.jpg)

### 00:21:46-00:24:40 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 核对对象：`PCG`、`Actor`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s06-01-S06_1_00_21_56.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s06-02-S06_2_00_23_13.jpg)

### 00:24:43-00:29:00 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Volume`、`Blueprint`、`Random`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s07-01-S07_1_00_24_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s07-02-S07_2_00_26_51.jpg)

### 00:29:00-00:33:38 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Actor`、`Blueprint`、`Random`、`ISM`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s08-01-S08_1_00_29_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s08-02-S08_2_00_31_19.jpg)

### 00:33:40-00:36:34 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s09-01-S09_1_00_33_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s09-02-S09_2_00_35_07.jpg)

### 00:36:37-00:39:37 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s10-01-S10_1_00_36_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s10-02-S10_2_00_38_07.jpg)

### 00:39:40-00:43:02 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`Volume`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s11-01-S11_1_00_39_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s11-02-S11_2_00_41_21.jpg)

### 00:43:02-00:46:01 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s12-01-S12_1_00_43_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s12-02-S12_2_00_44_32.jpg)

### 00:46:05-00:50:08 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s13-01-S13_1_00_46_15.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s13-02-S13_2_00_48_06.jpg)

### 00:50:11-00:53:26 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s14-01-S14_1_00_50_21.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s14-02-S14_2_00_51_49.jpg)

### 00:53:30-00:58:02 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`Actor`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s15-01-S15_1_00_53_40.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s15-02-S15_2_00_55_46.jpg)

### 00:58:06-00:59:01 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s16-01-S16_1_00_58_16.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s16-02-S16_2_00_58_34.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


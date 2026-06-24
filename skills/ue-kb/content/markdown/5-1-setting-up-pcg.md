# 5 1 Setting up PCG

# 5 1 Setting up PCG

## 知识目标

- 围绕“5 1 Setting up PCG”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`Spline`、`Transform`、`Point`、`Spawn`、`Density`、`Random`、`Graph`、`Mask`、`Material`、`Instance`、`Landscape`、`grass`、`more`、`PCG Graph`、`Surface Sampler`、`Volume`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Branch`

## 分段知识

### 00:00:01-00:04:53 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Spline`、`Blueprint`、`Branch`、`Material`、`Instance`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s01-02-S01_2_00_02_27.jpg)

### 00:04:53-00:09:25 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Density`、`Surface Sampler`、`Static Mesh`、`Static Mesh Spawner`、`Filter`、`Material`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s02-02-S02_2_00_07_09.jpg)

### 00:09:25-00:12:58 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Surface Sampler`、`Static Mesh`、`Transform Points`、`Filter`、`Random`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s03-01-S03_1_00_09_35.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s03-02-S03_2_00_11_12.jpg)

### 00:12:58-00:16:50 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Transform Points`、`Random`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s04-01-S04_1_00_13_08.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s04-02-S04_2_00_14_54.jpg)

### 00:16:50-00:21:43 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Auto UV 可用 X Atlas 或 Patch Builder 重新生成 UV。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Branch`、`Instance`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s05-01-S05_1_00_17_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s05-02-S05_2_00_19_17.jpg)

### 00:21:43-00:25:10 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Point`、`Density`、`Transform Points`、`Filter`、`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s06-01-S06_1_00_21_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s06-02-S06_2_00_23_27.jpg)

### 00:25:10-00:29:56 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG`、`Surface Sampler`、`Volume`、`Static Mesh`、`Static Mesh Spawner`、`Branch`、`GPU`、`Material`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s07-01-S07_1_00_25_20.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s07-02-S07_2_00_27_33.jpg)

### 00:29:56-00:34:41 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Filter`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s08-01-S08_1_00_30_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s08-02-S08_2_00_32_18.jpg)

### 00:34:41-00:39:08 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Random`、`Material`、`ISM`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s09-01-S09_1_00_34_51.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s09-02-S09_2_00_36_54.jpg)

### 00:39:08-00:39:17 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s10-01-S10_1_00_39_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s10-02-S10_2_00_39_13.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


# 虚幻引擎5.6！制作PCG森林小径环境！

## 知识目标

- 围绕“虚幻引擎5.6！制作PCG森林小径环境！”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Seed`、`Graph`、`Mask`、`PCG Graph`、`Spline Sampler`、`Surface Sampler`、`Volume`、`Static Mesh Spawner`、`Spawn Actor`

## 分段知识

### 00:00:12-00:04:27 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Volume`、`Material`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s01-01-S01_1_00_00_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s01-02-S01_2_00_02_19.jpg)

### 00:04:27-00:09:11 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：涉及 Dynamic Mesh 时还要启用 Geometry Script Interop。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Surface Sampler`、`Static Mesh`、`Static Mesh Spawner`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s02-01-S02_1_00_04_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s02-02-S02_2_00_06_49.jpg)

### 00:09:11-00:11:55 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Bounds`、`Spline`、`Spline Sampler`、`Surface Sampler`、`Actor`、`Static Mesh`、`Static Mesh Spawner`、`Filter`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s03-01-S03_1_00_09_21.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s03-02-S03_2_00_10_33.jpg)

### 00:11:55-00:15:44 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Bounds`、`Surface Sampler`、`Static Mesh`、`Filter`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s04-01-S04_1_00_12_05.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s04-02-S04_2_00_13_50.jpg)

### 00:15:44-00:19:44 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s05-01-S05_1_00_15_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s05-02-S05_2_00_17_44.jpg)

### 00:19:44-00:23:19 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Transform Points`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s06-01-S06_1_00_19_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s06-02-S06_2_00_21_31.jpg)

### 00:23:19-00:28:06 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Density`、`Bounds`、`Transform Points`、`Filter`、`Seed`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s07-01-S07_1_00_23_29.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s07-02-S07_2_00_25_43.jpg)

### 00:28:06-00:32:45 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Density`、`Bounds`、`Transform Points`、`Copy Points`、`Filter`、`Seed`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s08-01-S08_1_00_28_16.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s08-02-S08_2_00_30_25.jpg)

### 00:32:45-00:35:44 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Seed`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s09-01-S09_1_00_32_55.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s09-02-S09_2_00_34_15.jpg)

### 00:35:44-00:38:50 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Surface Sampler`、`Seed`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s10-01-S10_1_00_35_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s10-02-S10_2_00_37_17.jpg)

### 00:38:50-00:43:34 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：自定义 Blueprint Element 要把输入/输出类型改为 Dynamic Mesh，并在执行图里 Cast 到 PCG Dynamic Mesh Data。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Bounds`、`Surface Sampler`、`Blueprint`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s11-01-S11_1_00_39_00.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s11-02-S11_2_00_41_12.jpg)

### 00:43:34-00:46:21 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Density`、`Bounds`、`Surface Sampler`、`Filter`、`Seed`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s12-01-S12_1_00_43_44.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s12-02-S12_2_00_44_57.jpg)

### 00:46:21-00:51:17 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Attribute`、`Density`、`Bounds`、`Transform Points`、`Filter`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s13-01-S13_1_00_46_31.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s13-02-S13_2_00_48_49.jpg)

### 00:51:17-00:55:42 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Attribute`、`Density`、`Bounds`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Seed`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s14-01-S14_1_00_51_27.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s14-02-S14_2_00_53_29.jpg)

### 00:55:42-01:00:27 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：自定义 Blueprint Element 要把输入/输出类型改为 Dynamic Mesh，并在执行图里 Cast 到 PCG Dynamic Mesh Data。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Bounds`、`Blueprint`、`Transform Points`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s15-01-S15_1_00_55_52.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s15-02-S15_2_00_58_05.jpg)

### 01:00:27-01:04:22 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Seed`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s16-01-S16_1_01_00_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s16-02-S16_2_01_02_25.jpg)

### 01:04:22-01:09:04 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Density`、`Transform Points`、`Filter`、`Seed`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s17-01-S17_1_01_04_32.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s17-02-S17_2_01_06_43.jpg)

### 01:09:04-01:12:17 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Attribute`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s18-01-S18_1_01_09_14.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s18-02-S18_2_01_10_40.jpg)

### 01:12:17-01:16:49 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Bounds`、`Transform Points`、`Seed`、`Material`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s19-01-S19_1_01_12_27.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s19-02-S19_2_01_14_33.jpg)

### 01:16:49-01:21:12 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Material`、`Instance`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s20-01-S20_1_01_16_59.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s20-02-S20_2_01_19_00.jpg)

### 01:21:12-01:24:43 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Actor`、`Spawn Actor`、`Transform Points`、`Random`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s21-01-S21_1_01_21_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s21-02-S21_2_01_22_58.jpg)

### 01:24:43-01:28:06 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Attribute`、`Density`、`Static Mesh`、`Filter`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s22-01-S22_1_01_24_53.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s22-02-S22_2_01_26_25.jpg)

### 01:28:06-01:31:13 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Density`、`Spline`、`Spline Sampler`、`Actor`、`Spawn Actor`、`Transform Points`、`Filter`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s23-01-S23_1_01_28_16.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s23-02-S23_2_01_29_40.jpg)

### 01:31:13-01:35:59 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Attribute`、`Density`、`Actor`、`Static Mesh`、`Spawn Actor`、`Transform Points`、`Filter`、`Random`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s24-01-S24_1_01_31_23.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s24-02-S24_2_01_33_36.jpg)

### 01:35:59-01:39:12 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Attribute`、`Density`、`Actor`、`Spawn Actor`、`Filter`、`Seed`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s25-01-S25_1_01_36_09.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s25-02-S25_2_01_37_36.jpg)

### 01:39:12-01:42:00 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Volume`、`Static Mesh`、`Static Mesh Spawner`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s26-01-S26_1_01_39_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s26-02-S26_2_01_40_36.jpg)

### 01:42:00-01:45:27 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Density`、`Volume`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s27-01-S27_1_01_42_10.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s27-02-S27_2_01_43_43.jpg)

### 01:45:27-01:48:04 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s28-01-S28_1_01_45_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s28-02-S28_2_01_46_45.jpg)

### 01:48:04-01:51:00 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Density`、`Volume`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s29-01-S29_1_01_48_14.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s29-02-S29_2_01_49_32.jpg)

### 01:51:00-01:55:33 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Attribute`、`Random`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s30-01-S30_1_01_51_10.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s30-02-S30_2_01_53_17.jpg)

### 01:55:33-01:58:19 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`Actor`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s31-01-S31_1_01_55_43.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s31-02-S31_2_01_56_56.jpg)

### 01:58:19-02:03:15 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s32-01-S32_1_01_58_29.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s32-02-S32_2_02_00_47.jpg)

### 02:03:15-02:07:41 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`Volume`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s33-01-S33_1_02_03_25.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s33-02-S33_2_02_05_28.jpg)

### 02:07:41-02:11:41 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Point`、`Bounds`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s34-01-S34_1_02_07_51.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s34-02-S34_2_02_09_41.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。

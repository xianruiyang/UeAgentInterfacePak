# 【UE5】1.5小时超干！初学者教程！程序生成PCG创建一个村庄

## 知识目标

- 围绕“【UE5】1.5小时超干！初学者教程！程序生成PCG创建一个村庄”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`蓝图`、`Static Mesh`、`Mesh`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Loop`、`Graph`、`PCG Graph`、`PCG Volume`、`Spline Sampler`、`Surface Sampler`、`Volume`、`Static Mesh Spawner`

## 分段知识

### 00:00:00-00:02:58 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：涉及 Dynamic Mesh 时还要启用 Geometry Script Interop。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Blueprint`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s01-02-S01_2_00_01_29.jpg)

### 00:02:58-00:06:29 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Surface Sampler`、`Volume`、`Partition`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s02-01-S02_1_00_03_08.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s02-02-S02_2_00_04_43.jpg)

### 00:06:29-00:10:47 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：PCG 部分围绕点数据、属性和生成器展开，复现时要核对输入点、属性写入、过滤条件以及最终 Spawner 的实例化结果。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Density`、`Surface Sampler`、`Volume`、`Static Mesh`、`Static Mesh Spawner`、`Filter`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s03-01-S03_1_00_06_39.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s03-02-S03_2_00_08_38.jpg)

### 00:10:47-00:14:08 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Density`、`Static Mesh`、`Static Mesh Spawner`、`Transform Points`、`Filter`、`Random`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s04-01-S04_1_00_10_57.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s04-02-S04_2_00_12_27.jpg)

### 00:14:08-00:16:48 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Volume`、`PCG`、`Point`、`Spline`、`Volume`、`Actor`、`Blueprint`、`Loop`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s05-01-S05_1_00_14_18.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s05-02-S05_2_00_15_28.jpg)

### 00:16:48-00:21:01 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Spline`、`Spline Sampler`、`Blueprint`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s06-01-S06_1_00_16_58.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s06-02-S06_2_00_18_55.jpg)

### 00:21:01-00:24:37 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Bounds`、`Spline`、`Volume`、`Actor`、`Blueprint`、`Static Mesh`、`Static Mesh Spawner`、`Spawn Actor`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s07-01-S07_1_00_21_11.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s07-02-S07_2_00_22_49.jpg)

### 00:24:37-00:27:28 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Attribute`、`Density`、`Spline`、`Spline Sampler`、`Filter`、`Random`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s08-01-S08_1_00_24_47.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s08-02-S08_2_00_26_02.jpg)

### 00:27:28-00:30:22 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Actor`、`Transform Points`、`Filter`、`Random`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s09-01-S09_1_00_27_38.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s09-02-S09_2_00_28_55.jpg)

### 00:30:22-00:35:04 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Point`、`Attribute`、`Density`、`Actor`、`Spawn Actor`、`Filter`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s10-01-S10_1_00_30_32.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s10-02-S10_2_00_32_43.jpg)

### 00:35:04-00:38:18 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Actor`、`Spawn Actor`、`Transform Points`、`Filter`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s11-01-S11_1_00_35_14.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s11-02-S11_2_00_36_41.jpg)

### 00:38:18-00:41:33 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Density`、`Bounds`、`Blueprint`、`Static Mesh`、`Static Mesh Spawner`、`Copy Points`、`Filter`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s12-01-S12_1_00_38_28.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s12-02-S12_2_00_39_56.jpg)

### 00:41:33-00:46:03 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Bounds`、`Actor`、`Static Mesh`、`Transform Points`、`Copy Points`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s13-01-S13_1_00_41_43.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s13-02-S13_2_00_43_48.jpg)

### 00:46:03-00:50:56 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Attribute`、`Density`、`Actor`、`Blueprint`、`Static Mesh`、`Static Mesh Spawner`、`Spawn Actor`、`Transform Points`、`Filter`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s14-01-S14_1_00_46_13.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s14-02-S14_2_00_48_30.jpg)

### 00:50:56-00:55:49 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG`、`Static Mesh`、`Static Mesh Spawner`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s15-01-S15_1_00_51_06.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s15-02-S15_2_00_53_23.jpg)

### 00:55:51-00:59:04 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Static Mesh`、`Static Mesh Spawner`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s16-01-S16_1_00_56_01.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s16-02-S16_2_00_57_27.jpg)

### 00:59:06-01:02:37 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s17-01-S17_1_00_59_16.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s17-02-S17_2_01_00_51.jpg)

### 01:02:41-01:07:37 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Bounds`、`Spline`、`Spline Sampler`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s18-01-S18_1_01_02_51.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s18-02-S18_2_01_05_09.jpg)

### 01:07:37-01:12:25 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Spline`、`Transform Points`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s19-01-S19_1_01_07_47.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s19-02-S19_2_01_10_01.jpg)

### 01:12:27-01:15:31 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Random`、`Material`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s20-01-S20_1_01_12_37.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s20-02-S20_2_01_13_59.jpg)

### 01:15:33-01:19:02 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Actor`、`Blueprint`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s21-01-S21_1_01_15_43.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s21-02-S21_2_01_17_17.jpg)

### 01:19:04-01:23:36 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`Volume`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s22-01-S22_1_01_19_14.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s22-02-S22_2_01_21_20.jpg)

### 01:23:38-01:28:34 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Density`、`Spline`、`Volume`、`Static Mesh`、`Instance`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s23-01-S23_1_01_23_48.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s23-02-S23_2_01_26_06.jpg)

### 01:28:34-01:33:29 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`Static Mesh`、`Loop`、`Instance`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s24-01-S24_1_01_28_44.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s24-02-S24_2_01_31_01.jpg)

### 01:33:29-01:37:58 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Bounds`、`Spline`、`Spline Sampler`、`Actor`、`Blueprint`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s25-01-S25_1_01_33_39.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s25-02-S25_2_01_35_43.jpg)

### 01:38:00-01:42:49 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：Auto UV 可用 X Atlas 或 Patch Builder 重新生成 UV。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Point`、`Static Mesh`、`Static Mesh Spawner`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s26-01-S26_1_01_38_10.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s26-02-S26_2_01_40_25.jpg)

### 01:42:49-01:43:10 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-beginner-village-tutorial/s27-01-S27_1_01_42_53.jpg)
![关键截图 2](assets/ue5-pcg-beginner-village-tutorial/s27-02-S27_2_01_43_00.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。

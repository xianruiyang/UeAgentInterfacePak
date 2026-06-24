# 【UE5 | 教程 | PCG】虚幻引擎5 利用PCG创建逼真的样条路径

## 知识目标

- 围绕“【UE5 | 教程 | PCG】虚幻引擎5 利用PCG创建逼真的样条路径”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Static Mesh`、`Mesh`、`Point Filter`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Density`、`Random`、`Seed`、`Loop`、`Graph`、`Material`、`PCG Graph`、`Static Mesh Spawner`、`Copy Points`、`Instance`

## 分段知识

### 00:00:02-00:03:24 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Spline`、`Blueprint`、`Copy Points`、`Random`、`Instance`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s01-01-S01_1_00_00_12.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s01-02-S01_2_00_01_43.jpg)

### 00:03:24-00:08:01 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`PCG Graph`、`PCG`、`Point`、`Blueprint`、`Copy Points`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s02-01-S02_1_00_03_34.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s02-02-S02_2_00_05_42.jpg)

### 00:08:01-00:13:00 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：本段以样条作为输入，使用采样点、切线和 Transform 驱动后续生成，复现时重点检查采样间距和端点对齐。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：创建 PCG Graph 后，将规则绑定到 PCG Component 或放置到场景 Actor 上进行调试。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG Graph`、`PCG`、`Spline`、`Actor`、`Blueprint`、`Instance`、`采样`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s03-01-S03_1_00_08_11.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s03-02-S03_2_00_10_30.jpg)

### 00:13:00-00:17:49 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh 清单、Transform、Density、Seed 和材质覆盖。
- 知识点：自定义 Blueprint Element 要把输入/输出类型改为 Dynamic Mesh，并在执行图里 Cast 到 PCG Dynamic Mesh Data。
- 知识点：Spawn Actor 适合生成带蓝图逻辑的对象。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 知识点：Static Mesh Spawner 可覆盖生成实例的材质，用于快速验证网格实例的分类和可见性。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Attribute`、`Spline`、`Blueprint`、`Static Mesh`、`Static Mesh Spawner`、`Copy Points`、`Material`、`Instance`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s04-01-S04_1_00_13_10.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s04-02-S04_2_00_15_24.jpg)

### 00:18:24-00:23:16 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：样条流程需要核对采样间距、端点、切线、Transform 和下游网格对齐结果。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s05-01-S05_1_00_18_34.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s05-02-S05_2_00_20_50.jpg)

### 00:23:16-00:26:14 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：属性过滤流程需要核对属性名、阈值、分支条件和过滤后的点数量。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Attribute`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s06-01-S06_1_00_23_26.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s06-02-S06_2_00_24_45.jpg)

### 00:26:56-00:29:50 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：样条流程需要核对采样间距、端点、切线、Transform 和下游网格对齐结果。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s07-01-S07_1_00_27_06.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s07-02-S07_2_00_28_23.jpg)

### 00:29:53-00:32:33 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：样条流程需要核对采样间距、端点、切线、Transform 和下游网格对齐结果。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s08-01-S08_1_00_30_03.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s08-02-S08_2_00_31_13.jpg)

### 00:32:36-00:35:39 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：样条流程需要核对采样间距、端点、切线、Transform 和下游网格对齐结果。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s09-01-S09_1_00_32_46.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s09-02-S09_2_00_34_07.jpg)

### 00:35:42-00:36:32 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：样条流程需要核对采样间距、端点、切线、Transform 和下游网格对齐结果。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s10-01-S10_1_00_35_52.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s10-02-S10_2_00_36_07.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。

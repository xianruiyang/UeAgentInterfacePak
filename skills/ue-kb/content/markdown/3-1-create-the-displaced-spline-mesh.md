# 3 1 Create the Displaced Spline Mesh

# 3 1 Create the Displaced Spline Mesh

## 知识目标

- 围绕“3 1 Create the Displaced Spline Mesh”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `Mesh`、`Spline`、`Transform`、`Point`、`Density`、`Loop`、`Mask`、`Material`、`Landscape`、`more`、`displacement`、`Spline Mesh`、`Filter`

## 分段知识

### 00:00:04-00:04:54 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：为枝条圆柱增加适量环线拓扑后再弯曲，拓扑数量要兼顾平滑形变和高密度树木的面数预算。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`Spline Mesh`、`Loop`、`Material`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s01-01-S01_1_00_00_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s01-02-S01_2_00_02_29.jpg)

### 00:04:54-00:09:21 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s02-01-S02_1_00_05_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s02-02-S02_2_00_07_08.jpg)

### 00:09:21-00:14:20 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s03-01-S03_1_00_09_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s03-02-S03_2_00_11_51.jpg)

### 00:14:20-00:19:20 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：将 Static Mesh 或生成参数暴露为 Blueprint 变量/Graph 参数后，可在不同实例中替换生成资产。
- 知识点：Static Mesh Spawner 负责把点数据实例化为网格；替换 Mesh 时要同步检查 Transform、Density 和材质覆盖。
- 知识点：Spline 输入通常先采样为点，再用距离、切线或标签过滤道路范围内外的生成点。
- 知识点：用 Actor Tag 或 Spline 作为外部输入时，应先确认标签命中对象，再检查过滤后的点集。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Filter`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s04-01-S04_1_00_14_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s04-02-S04_2_00_16_50.jpg)

### 00:19:20-00:23:49 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`Spline Mesh`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s05-01-S05_1_00_19_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s05-02-S05_2_00_21_34.jpg)

### 00:23:52-00:28:11 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s06-01-S06_1_00_24_02.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s06-02-S06_2_00_26_01.jpg)

### 00:28:14-00:32:26 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`Spline Mesh`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s07-01-S07_1_00_28_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s07-02-S07_2_00_30_20.jpg)

### 00:32:26-00:37:17 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s08-01-S08_1_00_32_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s08-02-S08_2_00_34_51.jpg)

### 00:37:17-00:42:15 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Spline`、`Spline Mesh`、`Material`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s09-01-S09_1_00_37_27.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s09-02-S09_2_00_39_46.jpg)

### 00:42:15-00:47:12 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：进入 Substance Painter 前检查导出比例、材质槽和 UV，保证树皮、针叶和遮罩贴图能按对象区域正确烘焙与绘制。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`Spline Mesh`、`Filter`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s10-01-S10_1_00_42_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s10-02-S10_2_00_44_43.jpg)

### 00:47:13-00:51:51 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 知识点：Spline 输入通常先采样为点，再用属性、距离或索引区分路段、端点、交叉点和曲线段。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Point`、`Density`、`Spline`、`Spline Mesh`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s11-01-S11_1_00_47_23.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s11-02-S11_2_00_49_32.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


# 1 3 Modeling the Branches of the Black Spruce

# 1 3 Modeling the Branches of the Black Spruce

## 知识目标

- 围绕“1 3 Modeling the Branches of the Black Spruce”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及运行时、World Partition、Hierarchical Generation 或 GPU 节点时，单独验证触发模式、缓存和性能。
- 涉及 Dynamic Mesh 或 Geometry Script 时，先小规模验证布尔、倒角、修补和 UV，再扩展到批量生成。

## 关键术语

- `Mesh`、`Transform`、`Point`、`Attribute`、`Spawn`、`Density`、`Loop`、`Material`、`branch`、`chunk`、`more`、`GPU`、`Bevel`、`ISM`

## 分段知识

### 00:00:00-00:04:56 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：使用 Array Modifier 批量复制针叶或枝条单元，再通过偏移、旋转、弯曲和局部删除形成自然枝簇。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s01-02-S01_2_00_02_28.jpg)

### 00:04:56-00:08:04 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：为枝条圆柱增加适量环线拓扑后再弯曲，拓扑数量要兼顾平滑形变和高密度树木的面数预算。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`Density`、`Branch`、`Geometry Script`、`Dynamic Mesh`、`Bevel`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s02-01-S02_1_00_05_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s02-02-S02_2_00_06_30.jpg)

### 00:08:04-00:12:59 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：为枝条圆柱增加适量环线拓扑后再弯曲，拓扑数量要兼顾平滑形变和高密度树木的面数预算。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`Branch`、`Geometry Script`、`Dynamic Mesh`、`Bevel`、`Material`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s03-01-S03_1_00_08_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s03-02-S03_2_00_10_31.jpg)

### 00:12:59-00:16:59 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：使用 Array Modifier 批量复制针叶或枝条单元，再通过偏移、旋转、弯曲和局部删除形成自然枝簇。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s04-01-S04_1_00_13_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s04-02-S04_2_00_14_59.jpg)

### 00:16:59-00:20:18 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：为枝条圆柱增加适量环线拓扑后再弯曲，拓扑数量要兼顾平滑形变和高密度树木的面数预算。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放导致倒角、弯曲和法线表现异常。
- 核对对象：`PCG`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s05-01-S05_1_00_17_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s05-02-S05_2_00_18_38.jpg)

### 00:20:18-00:25:07 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放导致倒角、弯曲和法线表现异常。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s06-01-S06_1_00_20_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s06-02-S06_2_00_22_42.jpg)

### 00:25:09-00:30:02 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 核对对象：`PCG`、`Material`、`ISM`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s07-01-S07_1_00_25_19.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s07-02-S07_2_00_27_35.jpg)

### 00:30:02-00:34:57 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：在枝条仍是简单形体时标记接缝并做 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s08-01-S08_1_00_30_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s08-02-S08_2_00_32_29.jpg)

### 00:34:59-00:38:09 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s09-01-S09_1_00_35_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s09-02-S09_2_00_36_34.jpg)

### 00:38:12-00:43:02 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Point`、`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s10-01-S10_1_00_38_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s10-02-S10_2_00_40_37.jpg)

### 00:43:05-00:47:19 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s11-01-S11_1_00_43_15.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s11-02-S11_2_00_45_12.jpg)

### 00:47:21-00:52:03 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s12-01-S12_1_00_47_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s12-02-S12_2_00_49_42.jpg)

### 00:52:04-00:56:50 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s13-01-S13_1_00_52_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s13-02-S13_2_00_54_27.jpg)

### 00:56:50-01:01:49 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s14-01-S14_1_00_57_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s14-02-S14_2_00_59_19.jpg)

### 01:01:50-01:06:45 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s15-01-S15_1_01_02_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s15-02-S15_2_01_04_18.jpg)

### 01:06:47-01:09:53 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：运行时、分区或 GPU 生成需要单独验证缓存、触发时机、平台支持和性能预算。
- 核对对象：`Branch`、`GPU`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s16-01-S16_1_01_06_57.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s16-02-S16_2_01_08_20.jpg)

### 01:09:55-01:13:56 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s17-01-S17_1_01_10_05.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s17-02-S17_2_01_11_56.jpg)

### 01:13:59-01:18:24 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s18-01-S18_1_01_14_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s18-02-S18_2_01_16_12.jpg)

### 01:18:24-01:23:18 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：在枝条仍是简单形体时标记接缝并做 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Material`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s19-01-S19_1_01_18_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s19-02-S19_2_01_20_51.jpg)

### 01:23:18-01:28:07 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：属性是 PCG 数据流中的关键状态，应明确保存分类、索引、随机种子、缩放或材质选择等信息。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Attribute`、`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s20-01-S20_1_01_23_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s20-02-S20_2_01_25_42.jpg)

### 01:28:07-01:33:00 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放导致倒角、弯曲和法线表现异常。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s21-01-S21_1_01_28_17.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s21-02-S21_2_01_30_33.jpg)

### 01:33:00-01:35:09 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 知识点：进入 Substance Painter 前检查导出比例、材质槽和 UV，保证树皮、针叶和遮罩贴图能按对象区域正确烘焙与绘制。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放导致倒角、弯曲和法线表现异常。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Branch`、`Loop`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s22-01-S22_1_01_33_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s22-02-S22_2_01_34_04.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。
- Dynamic Mesh/Geometry Script 流程要单独测试布尔、倒角、网格修补、UV 和保存 Static Mesh 的成本。


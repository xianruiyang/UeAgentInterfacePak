# 4 1 Create the Grass Foliage

# 4 1 Create the Grass Foliage

## 知识目标

- 围绕“4 1 Create the Grass Foliage”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `Mesh`、`Transform`、`Point`、`Random`、`Mask`、`Material`、`Landscape`、`more`、`grass`、`Filter`、`ISM`

## 分段知识

### 00:00:00-00:03:59 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：用平面卡片制作针叶基础单元，在编辑模式调整比例、朝向和中心点，作为后续阵列复制与变形的最小构件。
- 知识点：在枝条仍是简单形体时标记接缝并做 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 核对对象：`PCG`、`ISM`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s01-02-S01_2_00_01_59.jpg)

### 00:04:01-00:07:15 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：在枝条仍是简单形体时标记接缝并做 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s02-01-S02_1_00_04_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s02-02-S02_2_00_05_38.jpg)

### 00:07:18-00:10:32 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s03-01-S03_1_00_07_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s03-02-S03_2_00_08_55.jpg)

### 00:10:37-00:13:34 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：导入 UE 前检查 pivot、命名、法线、材质和 Nanite/实例化策略，保证高密度树木在场景中可管理且可重复使用。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`Filter`、`属性`、`过滤`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s04-01-S04_1_00_10_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s04-02-S04_2_00_12_05.jpg)

### 00:13:37-00:16:29 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s05-01-S05_1_00_13_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s05-02-S05_2_00_15_03.jpg)

### 00:16:33-00:20:28 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s06-01-S06_1_00_16_43.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s06-02-S06_2_00_18_30.jpg)

### 00:20:28-00:23:22 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`Random`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s07-01-S07_1_00_20_38.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s07-02-S07_2_00_21_55.jpg)

### 00:23:26-00:26:21 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：复现时先对照本段截图确认关键对象、参数面板和结果视图，再继续下游步骤。
- 核对对象：`PCG`、`Random`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s08-01-S08_1_00_23_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s08-02-S08_2_00_24_54.jpg)

### 00:26:23-00:29:21 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：缩放、旋转、倒角或弯曲前后使用 `Ctrl+A > Apply All Transforms` 归一化对象变换，避免非统一缩放影响倒角、弯曲和法线。
- 核对对象：`PCG`、`Random`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s09-01-S09_1_00_26_33.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s09-02-S09_2_00_27_52.jpg)

### 00:29:24-00:33:01 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：在枝条仍是简单形体时标记接缝并执行 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：在枝条仍是简单形体时标记接缝并做 Angle Based Unwrap，先得到干净 UV，再进入复制、弯曲和变体制作。
- 核对对象：`PCG`、`Random`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s10-01-S10_1_00_29_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s10-02-S10_2_00_31_13.jpg)

### 00:33:02-00:36:13 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：PCG 流程要按点数据、属性写入、过滤条件和 Spawner 输出四步核对，避免只看最终实例而漏掉中间点状态。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Point`、`Bounds`、`Random`、`Material`、`点`、`点数据`、`采样`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s11-01-S11_1_00_33_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s11-02-S11_2_00_34_37.jpg)

### 00:36:19-00:41:09 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：基础阶段就分配并命名材质槽，保证枝条、针叶或树皮在复制、导入 UE 和材质替换时保持稳定归类。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`Random`、`Material`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s12-01-S12_1_00_36_29.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s12-02-S12_2_00_38_44.jpg)

### 00:41:12-00:44:33 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 知识点：通过曲线或弯曲变形控制枝条走势，先检查对象变换和拓扑，再调整弯曲强度，避免卡片被拉伸或扭曲。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s13-01-S13_1_00_41_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s13-02-S13_2_00_42_53.jpg)

### 00:44:34-00:47:25 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 核对对象：`PCG`、`Random`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s14-01-S14_1_00_44_44.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s14-02-S14_2_00_45_59.jpg)

### 00:47:33-00:50:03 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：在 Blender 中制作可复用的枝条/针叶簇模块，先确定主枝比例、枝簇数量和变体目标，再用多个差异化模块组合树冠。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p28/s15-01-S15_1_00_47_43.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p28/s15-02-S15_2_00_48_48.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


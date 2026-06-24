# 9.风格化的塞尔达景观！使用虚幻引擎中的盖亚地图制作大型 PCG 教程

# 9.风格化的塞尔达景观！使用虚幻引擎中的盖亚地图制作大型 PCG 教程

## 知识目标

- 围绕“9.风格化的塞尔达景观！使用虚幻引擎中的盖亚地图制作大型 PCG 教程”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及运行时、World Partition、Hierarchical Generation 或 GPU 节点时，单独验证触发模式、缓存和性能。

## 关键术语

- `Gaia`、`World Partition`、`Generate Mesh Distance Fields`、`Virtual Texture`、`Landscape`、`Landscape Layer`、`PCG Volume`、`Surface Sampler`、`Density Filter`、`Static Mesh Spawner`、`Transform Points`、`Absolute Rotation`、`PCG World Actor`、`Partitioned PCG`、`PCG`、`Blueprint`、`图表`、`点`、`点数据`、`属性`、`密度`、`采样`、`过滤`、`分区`

## 分段知识

### 00:00:00-00:04:40 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s01-02-S01_2_00_02_20.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s01-03-S02_1_00_04_50.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s01-04-S02_2_00_06_59.jpg)

### 00:04:40-00:09:17 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：我想用 PCG 创建一个新的树叶生成设置；这样我就可以开始生成我的草了。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`分区`、`生成`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s02-01-S03_1_00_09_27.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s02-02-S03_2_00_11_41.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s02-03-S04_1_00_14_16.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s02-04-S04_2_00_16_26.jpg)

### 00:09:17-00:14:06 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：PCG 体积一边选择生成点和数页的位置。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`图表`、`点`、`点数据`、`属性`、`密度`、`采样`、`过滤`、`生成`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s03-01-S05_1_00_18_55.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s03-02-S05_2_00_21_08.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s03-03-S06_1_00_23_41.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s03-04-S06_2_00_25_51.jpg)

### 00:14:06-00:18:45 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：选择点过滤器节点。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`点`、`属性`、`采样`、`过滤`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s04-01-S07_1_00_28_21.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s04-02-S07_2_00_30_33.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s04-03-S08_1_00_33_05.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s04-04-S08_2_00_35_14.jpg)

### 00:18:45-00:23:31 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 知识点：使表面上生成的实际点变大。
- 知识点：并断开连接来断开静态网格物体生成器。
- 知识点：添加一个静态网格物体生成器或。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`图表`、`点`、`属性`、`密度`、`采样`、`过滤`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

### 00:23:31-00:28:11 生成器输出与蓝图交互

- 本段定位：生成器输出与蓝图交互。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：我将拖出密度过滤器并输入蓝图；需要得到一些点来 在树周围生成。
- 知识点：并将密度过滤器插入圆中。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Static Mesh Spawner 用于高效实例化；Spawn Actor/Blueprint 用于需要逻辑的对象，成本和生命周期不同。
- 核对对象：`Blueprint`、`点`、`密度`、`采样`、`过滤`、`生成`、`蓝图`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

### 00:28:11-00:32:55 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`点`、`属性`、`密度`、`采样`、`过滤`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

### 00:32:55-00:37:33 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`点`、`属性`、`密度`、`采样`、`过滤`、`分区`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

### 00:37:33-00:42:33 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：植被生成要按点密度、随机 Transform、网格清单和剔除规则逐项核对，避免道路、岩石或地形边缘出现穿插。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`、`分区`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

### 00:42:33-00:42:40 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：属性过滤流程需要核对属性名、阈值、分支条件和过滤后的点数量。
- 知识点：属性、过滤与数据分流。
- 核对对象：`PCG`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-01-S09_1_00_37_43.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-02-S09_2_00_40_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-03-S10_1_00_42_34.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p09/s05-04-S10_2_00_42_36.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


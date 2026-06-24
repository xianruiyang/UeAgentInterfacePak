# 02 - PCGEx 沿道路生成建筑与入口路径

# 02 - PCGEx 沿道路生成建筑与入口路径

## 知识目标

- 围绕“02 - PCGEx 沿道路生成建筑与入口路径”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`蓝图`、`Static Mesh`、`Mesh`、`SubGraph`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Bounds`、`Density`、`Random`、`Seed`、`Loop`、`图表`、`组件`、`点`、`属性`、`密度`、`边界`

## 分段知识

### 00:00:00-00:04:36 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCGEx 城市建筑流程从一条普通道路样条开始，先启用 PCG、PCGEx/Extend Toolkit 与 Geometry Script，再用 Actor Tag 标记道路输入。
- 知识点：用 Draw Spline 创建道路 Actor 后，Get Actor Data 按标签读取样条，后续所有建筑点、道路偏移和入口路径都围绕这条样条生成。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`Actor`、`图表`、`点`、`样条`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s01-02-S01_2_00_02_18.jpg)

### 00:04:36-00:09:14 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：Bounds Modifier 先放大样条点的 Y/Z Bounds 方便调试和后续剔除；Clipper2 Offset 按偏移距离把单条道路样条扩成道路两侧候选线。
- 知识点：Clipper2 Offset 的 End Type 控制端点形状，方形端点更适合道路边界；偏移过大导致内部重叠时，PCGEx 会自动丢弃无法容纳的点。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`Actor`、`组件`、`点`、`边界`、`样条`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s02-01-S02_1_00_04_46.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s02-02-S02_2_00_06_55.jpg)

### 00:09:14-00:14:05 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：Path Split 配合 Filter Angle 按硬角断开偏移后的路径，角度阈值可在 90 到 91 度附近微调以去掉死胡同或异常端点。
- 知识点：Difference 节点配合放大的道路 Bounds 移除离道路过近或落在角落中的建筑候选点，避免建筑压到主路和交叉口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`图表`、`点`、`边界`、`样条`、`采样`、`过滤`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s03-01-S03_1_00_09_24.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s03-02-S03_2_00_11_40.jpg)

### 00:14:06-00:18:52 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCG Grammar 通过图表参数 `grammar` 和 `modules` 控制建筑模块排列；默认语法如 `{A*}` 表示随机重复 A 模块。
- 知识点：`PCGEx Mode Mesh Module Info` 数组保存模块符号、静态网格和边界使用方式；Apply Grammar 后再 Create Spline / Subdivide Spline 生成可放置建筑的位置。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`图表`、`点`、`属性`、`边界`、`样条`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s04-01-S04_1_00_14_16.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s04-02-S04_2_00_16_29.jpg)

### 00:18:52-00:23:51 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：建筑缩放不能只在 Transform Points 后做，否则点 Bounds 不会同步变大；应在读取网格 Bounds 后把 Extents 乘以 `building scale`。
- 知识点：`extra spacing` 可额外增加 X 方向 Extents，为建筑之间预留间距，减少后续自修剪和重叠剔除压力。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`图表`、`点`、`边界`、`样条`、`采样`、`过滤`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s05-01-S05_1_00_19_02.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s05-02-S05_2_00_21_21.jpg)

### 00:23:51-00:28:29 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：PCGEx Sample Nearest Point 用原始道路样条作为目标，让建筑点朝向最近道路点；采样范围只需要覆盖道路偏移距离，避免无意义的大范围搜索。
- 知识点：Apply Sampling 中只绕 Z 轴调整朝向，并把 Forward Axis 改成建筑资产实际的前向轴；原始样条重采样越密，建筑朝向道路越稳定。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`点`、`属性`、`密度`、`边界`、`样条`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s06-01-S06_1_00_24_01.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s06-02-S06_2_00_26_10.jpg)

### 00:28:29-00:33:18 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：常规 Self Prune 容易过度删除建筑点；PCGEx Self Prune 能保留更多候选点，开启 Exact Test 后可进一步减少误删。
- 知识点：Exact Test 会增加空间测试成本，但在点数不大、重叠不严重的道路建筑场景中通常仍可接受；大城市需要用性能面板复核耗时。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`点`、`属性`、`边界`、`过滤`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s07-01-S07_1_00_28_39.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s07-02-S07_2_00_30_54.jpg)

### 00:33:18-00:37:57 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：建筑入口用 Static Mesh 的 Slot 标记，所有建筑资产应统一添加 `Entrance` 标签并把插槽放在门口中心。
- 知识点：PCGEx 插槽节点可根据 Static Mesh 属性和 Slot 标签直接输出入口点；连接入口路径前要确保道路/车道网格的 Pivot 与 X 前向设置正确。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`点`、`属性`、`样条`、`采样`、`过滤`、`循环`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s08-01-S08_1_00_33_28.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s08-02-S08_2_00_35_37.jpg)

### 00:37:57-00:42:34 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：入口点和道路目标点的位置可通过 Offset 相加对齐，再按 `road index` 分区，保证每个建筑入口只连接到对应道路段。
- 知识点：Solidify 可把入口点与道路点合成为一个带 Bounds 的单点车道段；在 Solidify 前先写入 `lane mesh` 属性，后续才能按车道网格尺寸缩放。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Spline`、`图表`、`点`、`属性`、`边界`、`样条`、`采样`、`分区`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s09-01-S09_1_00_38_07.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s09-02-S09_2_00_40_15.jpg)

### 00:42:34-00:47:20 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：Solidify 后用道路半宽参数从 Extents X 中减去一段距离，让入口车道停在道路边缘而不是延伸到道路中心。
- 知识点：Merge Points 的输入顺序会影响车道起点和终点，入口点应先作为起点、道路点作为终点；尝试封装子图前应保存，避免输入子图导致编辑器崩溃。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`PCG`、`Point`、`Spline`、`图表`、`组件`、`点`、`属性`、`样条`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s10-01-S10_1_00_42_44.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s10-02-S10_2_00_44_57.jpg)

### 00:47:20-00:50:27 Spline 采样与路径生成

- 本段定位：Spline 采样与路径生成。
- 知识点：最终接入城市生成器时，把建筑缩放、道路宽度、车道网格、grammar 和 modules 归入 Building 参数分类，方便统一调参。
- 知识点：建筑模块可使用 A/B/C/D 等符号混合，交叉口处依靠 Bounds Modifier 与剪切逻辑剔除异常建筑；后续可扩展为住宅、商业、工业分区。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Spline 流程要单独核对采样间距、切线、端点、交叉点和生成网格的对齐方式。
- 核对对象：`Spline`、`点`、`边界`、`样条`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue5-pcg-city-streets-and-zones-p02/s11-01-S11_1_00_47_30.jpg)
![关键截图 2](../assets/ue5-pcg-city-streets-and-zones-p02/s11-02-S11_2_00_48_54.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


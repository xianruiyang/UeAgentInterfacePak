# 15 使用PCG和几何脚本的程序化几何工作流程

# 15 使用PCG和几何脚本的程序化几何工作流程

## 知识目标

- 围绕“15 使用PCG和几何脚本的程序化几何工作流程”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。
- 涉及 Dynamic Mesh 或 Geometry Script 时，先小规模验证布尔、倒角、修补和 UV，再扩展到批量生成。

## 关键术语

- `PCG`、`Blueprint`、`蓝图`、`Static Mesh`、`Mesh`、`MeshSampler`、`Spline`、`Transform`、`Point`、`Attribute`、`Actor`、`Component`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Seed`、`Geometry Script`、`图表`、`组件`、`点`、`属性`、`密度`

## 分段知识

### 00:00:01-00:04:48 Geometry Script 与 Dynamic Mesh 处理

- 本段定位：Geometry Script 与 Dynamic Mesh 处理。
- 知识点：本段在蓝图/PCG 节点中组织数据流，复现时要核对输入输出引脚、执行顺序和写回的点属性。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：Dynamic Mesh/Geometry Script 节点通常计算成本较高，布尔、倒角和 Auto UV 应在质量与重算成本之间取舍。
- 核对对象：`PCG`、`Geometry Script`、`Dynamic Mesh`、`图表`、`组件`、`点`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s01-02-S01_2_00_02_25.jpg)

### 00:04:48-00:09:42 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：采样器决定点来源和分布规则；Volume、Surface、Spline 等输入要分别核对采样范围、密度和生成方向。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`密度`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s02-01-S02_1_00_04_58.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s02-02-S02_2_00_07_15.jpg)

### 00:09:42-00:14:28 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh 清单、Transform、Density、Seed 和材质覆盖。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s03-01-S03_1_00_09_52.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s03-02-S03_2_00_12_05.jpg)

### 00:14:28-00:19:09 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 知识点：GPU PCG 节点能提升运行时生成吞吐，但 CPU/GPU 数据传输会形成边界，图表中要减少不必要的跨设备传递。
- 知识点：Static Mesh Spawner 将点数据实例化为静态网格，复现时要检查 Mesh、Transform、Density 和材质覆盖。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`Actor`、`图表`、`组件`、`点`、`点数据`、`采样`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s04-01-S04_1_00_14_38.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s04-02-S04_2_00_16_48.jpg)

### 00:19:09-00:23:59 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`PCG`、`图表`、`点`、`属性`、`过滤`、`生成`、`网格`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s05-01-S05_1_00_19_19.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s05-02-S05_2_00_21_34.jpg)

### 00:23:59-00:28:50 属性、过滤与数据分流

- 本段定位：属性、过滤与数据分流。
- 知识点：PCG 点默认包含 Position、Rotation、Scale、Bounds、Density、Seed 等属性，自定义属性不带 `$` 前缀，Inspect 时要分清来源。
- 知识点：Transform Points 可调整点的位置、旋转和缩放；使用非统一缩放时要分别检查各轴最小值和最大值。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 复现要点：属性命名要稳定，过滤、分区和分支节点应保留可检查的中间数据，避免后续规则难以追踪。
- 核对对象：`点`、`属性`、`过滤`、`蓝图`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s06-01-S06_1_00_24_09.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s06-02-S06_2_00_26_25.jpg)

### 00:28:50-00:33:37 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：本段在蓝图/PCG 节点中组织数据流，复现时要核对输入输出引脚、执行顺序和写回的点属性。
- 知识点：Scriptable Tools 与 PCG Component 联动时，核心是让编辑器工具修改输入参数后触发图表重新生成。
- 知识点：脚本工具应只更新必要参数，并在生成后检查 PCG Component、HLOD、碰撞或物理状态是否同步。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`蓝图`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s07-01-S07_1_00_29_00.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s07-02-S07_2_00_31_13.jpg)

### 00:33:37-00:38:33 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：Landscape/Surface 输入负责提供地表采样点，复现时要核对采样范围、Layer/材质过滤、坡度或高度条件。
- 知识点：Gaea 输出高度图和遮罩贴图后，需要在 UE 中正确导入并绑定到 Landscape/材质层，PCG 再按图层信息控制地貌与植被。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`图表`、`点`、`点数据`、`采样`、`蓝图`、`网格`、`材质`。

**关键画面：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p15/s08-01-S08_1_00_33_47.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p15/s08-02-S08_2_00_36_05.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。
- Dynamic Mesh/Geometry Script 流程要单独测试布尔、倒角、网格修补、UV 和保存 Static Mesh 的成本。


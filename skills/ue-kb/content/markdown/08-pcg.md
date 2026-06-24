# 08 改进的程序化PCG室内设计

# 08 改进的程序化PCG室内设计

## 知识目标

- 围绕“08 改进的程序化PCG室内设计”整理 PCG 视频中的输入数据、图表规则、关键节点、参数风险和最终生成结果。
- 阅读时重点区分三层：输入来源（点、样条、表面、体积、Actor 或属性）、规则处理（采样、过滤、变换、分区、循环、HLSL 或子图）、输出方式（Static Mesh Spawner、Spawn Actor、Spline Mesh、Blueprint 或 Dynamic Mesh）。

## 可复现主流程

- 确认 PCG Graph/PCG Component 已绑定到正确 Actor，并先用 Debug/Inspect 查看中间点数据。
- 明确输入来源：Spline、Surface、Mesh、Volume、Actor、Data Asset/Data Table 或手工参数。
- 在图表中按顺序处理采样、属性写入、过滤、Transform、分区/循环和输出节点。
- 生成可见结果前，先核对 Point 的 Transform、Bounds、Density、Seed 和自定义 Attribute。
- 用 Static Mesh Spawner 输出大量网格实例；需要蓝图逻辑时改用 Spawn Actor 或 Blueprint 交互。

## 关键术语

- `PCG`、`Blueprint`、`Mesh`、`Point Filter`、`Transform`、`Point`、`Attribute`、`Actor`、`Spawn`、`Grid`、`Bounds`、`Density`、`Random`、`Seed`、`Loop`、`Graph`、`Material`、`密度`、`图表`、`点`、`点数据`、`循环`、`生成`

## 分段知识

### 00:00:00-00:04:47 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`循环`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s01-02-S01_2_00_02_23.jpg)

### 00:04:48-00:09:32 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`循环`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s02-01-S02_1_00_04_58.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s02-02-S02_2_00_07_10.jpg)

### 00:09:32-00:14:29 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：多楼层流程用循环逐层重新生成并存储地板/墙体点数据，下游房间、门和屋顶分支都要读取对应楼层的数据。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`Bounds`、`图表`、`点`、`点数据`、`采样`、`循环`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s03-01-S03_1_00_09_42.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s03-02-S03_2_00_12_00.jpg)

### 00:14:30-00:19:16 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Point`、`Bounds`、`Loop`、`Random`、`点`、`点数据`、`密度`、`采样`、`循环`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s04-01-S04_1_00_14_40.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s04-02-S04_2_00_16_53.jpg)

### 00:19:16-00:23:12 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`密度`、`采样`、`循环`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s05-01-S05_1_00_19_26.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s05-02-S05_2_00_21_14.jpg)

### 00:23:17-00:27:43 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：自定义房间墙节点记录 X/Y 边界点，随机选取非边界点作为墙段起点，并用随机整数加数组索引改善 PCG 随机性。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`循环`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s06-01-S06_1_00_23_27.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s06-02-S06_2_00_25_30.jpg)

### 00:27:47-00:30:02 点数据、Bounds 与采样来源

- 本段定位：点数据、Bounds 与采样来源。
- 知识点：室内划分从地板点复制出两套重叠墙点，其中一套旋转 90 度，合并后用密度或属性区分墙段与门洞候选。
- 知识点：门洞通过在墙段点中选择一个候选点并写入不同密度/属性生成，复现时要保证每个房间至少保留可通行入口。
- 知识点：多楼层流程用循环逐层重新生成并存储地板/墙体点数据，下游房间、门和屋顶分支都要读取对应楼层的数据。
- 复现要点：先用 Debug/Inspect 核对点数量、Bounds、Density 和关键属性，再判断最终生成结果。
- 核对对象：`PCG`、`Bounds`、`点`、`点数据`、`采样`、`生成`。

**关键画面：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s07-01-S07_1_00_27_57.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s07-02-S07_2_00_28_54.jpg)

## 复现检查

- 每个图表先检查输入数据是否正确进入 PCG Graph，再看下游生成结果。
- Debug/Inspect 时重点看点数量、Bounds、Density、Transform、Seed 和自定义 Attribute。
- Static Mesh Spawner、Spawn Actor、Spline Mesh 和 Blueprint 输出节点不能混用语义；选择前先确定是否需要实例化性能或蓝图逻辑。
- 涉及样条、分区、运行时或 GPU 生成时，必须额外验证更新触发、缓存、世界分区和性能预算。


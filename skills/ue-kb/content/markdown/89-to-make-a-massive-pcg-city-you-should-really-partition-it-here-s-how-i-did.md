# 89. To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did

# 89. To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did

## 知识目标

- 本文整理“89. To Make a Massive PCG CIty You Should Really Partition It, Here's How I Did”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果。
- 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成。

## 关键术语

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Random`
- `Loop`
- `Graph`
- `Instance`
- `buildings`
- `spline`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s01-02-S01_2_00_02_24.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Bounds`
- `Random`
- `Graph`
- `buildings`
- `dead`
- `show`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s02-01-S02_1_00_04_59.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s02-02-S02_2_00_07_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Spline`
- `Point`
- `Spawn`
- `Loop`
- `pivot`
- `buildings`
- `building`
- `splines`

### 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果

**内容要点：**

- 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s03-01-S03_1_00_09_52.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s03-02-S03_2_00_12_09.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Actor`
- `Spawn`
- `Bounds`
- `buildings`

### 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成

**内容要点：**

- 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s04-01-S04_1_00_14_47.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s04-02-S04_2_00_16_10.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Graph`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s05-01-S05_1_00_17_53.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s05-02-S05_2_00_19_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point`
- `Actor`
- `Spawn`
- `Grid`
- `Bounds`
- `Graph`
- `buildings`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p89/s06-01-S06_1_00_21_02.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p89/s06-02-S06_2_00_22_42.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Spawn`
- `Grid`
- `Graph`
- `spline`
- `partition`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


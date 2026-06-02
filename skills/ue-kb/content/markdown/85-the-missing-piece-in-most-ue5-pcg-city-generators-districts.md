# 85. The Missing Piece in Most UE5 PCG City Generators： Districts!

# 85. The Missing Piece in Most UE5 PCG City Generators： Districts!

## 知识目标

- 本文整理“85. The Missing Piece in Most UE5 PCG City Generators： Districts!”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果。
- 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Point Filter`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Random`
- `Seed`
- `Loop`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s01-02-S01_2_00_02_06.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Actor`
- `Component`
- `Spawn`
- `Bounds`
- `Random`
- `Graph`
- `spline`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s02-01-S02_1_00_04_23.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s02-02-S02_2_00_06_42.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Spawn`
- `Bounds`
- `Graph`
- `spline`
- `split`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（3）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（3）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s03-01-S03_1_00_09_21.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s03-02-S03_2_00_11_00.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Spawn`
- `Bounds`
- `Random`
- `Graph`
- `grammar`
- `points`

### 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果

**内容要点：**

- 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s04-01-S04_1_00_12_59.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s04-02-S04_2_00_14_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Spawn`
- `Bounds`
- `Random`
- `Graph`

### 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果（2）

**内容要点：**

- 城市/道路类流程要把路网、街区、分区和道路边界当作一等输入，先稳定道路点和交叉口，再按区域属性生成建筑、道具、道路边缘和 Zone Graph 相关结果（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s05-01-S05_1_00_15_55.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s05-02-S05_2_00_18_14.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Spawn`
- `Grid`
- `Bounds`
- `Loop`

### 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成

**内容要点：**

- 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s06-01-S06_1_00_20_54.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s06-02-S06_2_00_22_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point Filter`
- `Spline`
- `Point`
- `Attribute`
- `Spawn`
- `Bounds`
- `Density`

### 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成（2）

**内容要点：**

- 大范围城市必须关注 PCG Partition、Spline Mesh、World Partition 与生成结果固化之间的关系，避免分区后样条断裂或同一区域重复生成（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s07-01-S07_1_00_23_56.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s07-02-S07_2_00_26_11.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point Filter`
- `Point`
- `Attribute`
- `Spawn`
- `Grid`
- `Bounds`
- `Random`

### 节点、参数和生成结果校验 08

**内容要点：**

- 节点、参数和生成结果校验 08。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s08-01-S08_1_00_28_47.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s08-02-S08_2_00_31_04.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Spawn`
- `Bounds`
- `Graph`
- `point`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s09-01-S09_1_00_33_41.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s09-02-S09_2_00_35_16.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point Filter`
- `Point`
- `Attribute`
- `Spawn`
- `Bounds`
- `Graph`
- `mesh`

### **内容要点：**

- **内容要点：**（3）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s10-01-S10_1_00_37_11.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s10-02-S10_2_00_39_28.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Point`
- `Component`
- `Spawn`
- `Bounds`
- `Random`
- `Seed`

### **内容要点：**

- **内容要点：**（4）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p85/s11-01-S11_1_00_41_57.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p85/s11-02-S11_2_00_42_00.jpg)


**参数、节点和风险点：**

- `Carry`
- `grammar`
- `haven`
- `looked`
- `highly`
- `recommend`
- `checking`
- `video`
- `quite`
- `more`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


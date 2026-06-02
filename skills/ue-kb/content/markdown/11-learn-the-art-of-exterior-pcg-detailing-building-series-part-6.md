# 11. Learn the Art of Exterior PCG Detailing ｜ Building Series Part 6

# 11. Learn the Art of Exterior PCG Detailing ｜ Building Series Part 6

## 知识目标

- 本文整理“11. Learn the Art of Exterior PCG Detailing ｜ Building Series Part 6”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成。
- 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Density`
- `Random`
- `Seed`
- `Loop`
- `Graph`
- `floor`
- `unique`
- `point`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s01-02-S01_2_00_02_26.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Point`
- `Actor`
- `Random`
- `Loop`
- `Graph`
- `floor`
- `unique`
- `node`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s02-01-S02_1_00_05_02.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s02-02-S02_2_00_07_04.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Density`
- `Loop`
- `Graph`
- `points`
- `point`
- `array`

### 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成

**内容要点：**

- 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s03-01-S03_1_00_09_25.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s03-02-S03_2_00_11_41.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Point`
- `Actor`
- `Density`
- `Loop`
- `Graph`
- `floor`
- `first`

### 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成（2）

**内容要点：**

- 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s04-01-S04_1_00_14_18.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s04-02-S04_2_00_16_34.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Density`
- `Random`
- `Graph`
- `floor`
- `unique`
- `point`
- `floors`
- `every`

### 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠

**内容要点：**

- 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s05-01-S05_1_00_19_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s05-02-S05_2_00_20_47.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Transform`
- `Point`
- `Density`
- `Loop`
- `Graph`
- `floor`
- `unique`
- `goes`

### 节点、参数和生成结果校验 06

**内容要点：**

- 节点、参数和生成结果校验 06。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s06-01-S06_1_00_22_44.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s06-02-S06_2_00_25_00.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s07-01-S07_1_00_27_37.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s07-02-S07_2_00_29_55.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Random`
- `Seed`

### **内容要点：**

- **内容要点：**（3）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p11/s08-01-S08_1_00_32_34.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p11/s08-02-S08_2_00_33_23.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Actor`
- `Graph`
- `same`
- `floor`
- `floors`
- `spline`
- `sampler`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


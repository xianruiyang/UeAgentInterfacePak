# 9. Unbelievable-Multi-Floor-Interiors-PCG

# 9. Unbelievable-Multi-Floor-Interiors-PCG

## 知识目标

- 本文整理“9. Unbelievable-Multi-Floor-Interiors-PCG”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成。
- 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Bounds`
- `Density`
- `Random`
- `Loop`
- `Graph`
- `wall`
- `points`
- `floors`
- `point`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s01-02-S01_2_00_02_29.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `wall`
- `than`
- `swap`
- `over`
- `today`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s02-01-S02_1_00_05_08.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s02-02-S02_2_00_07_24.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Loop`
- `floor`
- `points`

### 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成

**内容要点：**

- 建筑类流程要先确认模块尺寸、Pivot、楼层高度和房间/门窗/楼梯的分支规则，再用点类型、密度区间、循环或子图把立面、楼层、屋顶、室内和家具拆开生成。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s03-01-S03_1_00_09_59.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s03-02-S03_2_00_11_36.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Bounds`
- `Density`
- `Random`
- `Loop`
- `wall`
- `point`

### 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠

**内容要点：**

- 每次新增建筑分支都要用 Debug 点和 Bounds 检查占用范围，避免门窗、墙体、楼梯、家具或屋顶在同一点重叠。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s04-01-S04_1_00_13_32.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s04-02-S04_2_00_15_45.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Random`
- `Loop`
- `Graph`
- `floors`
- `random`
- `points`
- `number`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s05-01-S05_1_00_18_18.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s05-02-S05_2_00_20_01.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Density`
- `Random`
- `Loop`
- `Graph`
- `points`
- `point`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p09/s06-01-S06_1_00_22_04.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p09/s06-02-S06_2_00_23_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point`
- `Actor`
- `Random`
- `Loop`
- `Graph`
- `floors`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


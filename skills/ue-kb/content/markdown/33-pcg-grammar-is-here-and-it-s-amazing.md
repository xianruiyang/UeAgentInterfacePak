# 33. PCG Grammar is Here And It's AMAZING

# 33. PCG Grammar is Here And It's AMAZING

## 知识目标

- 本文整理“33. PCG Grammar is Here And It's AMAZING”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 功能/节点类视频要重点记录新节点解决的具体痛点：循环、反馈、语法、光线投射、HLSL、自定义节点、PCG Mode 笔刷或新版功能通常改变的是规则表达能力，而不是单个静态结果。
- 复现时先用极小点集验证节点输入输出，再把节点接回完整图表；新版功能要记录 UE 版本依赖和旧版本替代方案。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `SubGraph`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Component`
- `Spawn`
- `Bounds`
- `Random`
- `Seed`
- `Loop`
- `Graph`
- `grammar`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s01-02-S01_2_00_02_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Attribute`
- `Component`
- `Bounds`
- `Loop`
- `Graph`
- `grammar`
- `spline`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s02-01-S02_1_00_04_44.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s02-02-S02_2_00_07_03.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Point`
- `Spawn`
- `Random`
- `Graph`
- `fence`
- `spawn`
- `brackets`
- `fences`

### 功能/节点类视频要重点记录新节点解决的具体痛点：循环、反馈、语法、光线投射、HLSL、自定义节点、PCG Mode 笔刷或新版功能通常改变的是规则表达能力，而不是单个静态结果

**内容要点：**

- 功能/节点类视频要重点记录新节点解决的具体痛点：循环、反馈、语法、光线投射、HLSL、自定义节点、PCG Mode 笔刷或新版功能通常改变的是规则表达能力，而不是单个静态结果。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s03-01-S03_1_00_09_42.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s03-02-S03_2_00_10_55.jpg)


**参数、节点和风险点：**

- `Point`
- `Spawn`
- `Seed`
- `doors`
- `still`
- `priority`
- `many`
- `grammar`
- `than`

### 复现时先用极小点集验证节点输入输出，再把节点接回完整图表；新版功能要记录 UE 版本依赖和旧版本替代方案

**内容要点：**

- 复现时先用极小点集验证节点输入输出，再把节点接回完整图表；新版功能要记录 UE 版本依赖和旧版本替代方案。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s04-01-S04_1_00_12_28.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s04-02-S04_2_00_14_48.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Spawn`
- `Random`
- `Graph`
- `floor`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s05-01-S05_1_00_17_27.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s05-02-S05_2_00_19_39.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Bounds`
- `Graph`
- `size`
- `spline`
- `attribute`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p33/s06-01-S06_1_00_22_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p33/s06-02-S06_2_00_23_32.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `SubGraph`
- `Spline`
- `Transform`
- `Attribute`
- `Spawn`
- `Bounds`
- `Graph`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


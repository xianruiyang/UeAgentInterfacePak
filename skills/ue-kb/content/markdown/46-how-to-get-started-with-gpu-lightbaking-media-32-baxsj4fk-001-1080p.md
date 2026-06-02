# 46. How-To-Get-Started-With-GPU-Lightbaking-_Media_32_BAxsj4Fk_001_1080p

# 46. How-To-Get-Started-With-GPU-Lightbaking-_Media_32_BAxsj4Fk_001_1080p

## 知识目标

- 本文整理“46. How-To-Get-Started-With-GPU-Lightbaking-_Media_32_BAxsj4Fk_001_1080p”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Component`
- `Spawn`
- `Grid`
- `Random`
- `Graph`
- `Mask`
- `Instance`
- `static`
- `bake`
- `sure`
- `default`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p46/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p46/s01-02-S01_2_00_02_25.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Component`
- `Spawn`
- `Grid`

### 节点、参数和生成结果校验 02

**内容要点：**

- 节点、参数和生成结果校验 02。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p46/s02-01-S02_1_00_05_00.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p46/s02-02-S02_2_00_06_24.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Component`
- `Random`
- `Instance`
- `around`
- `post`
- `default`
- `bake`
- `settings`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


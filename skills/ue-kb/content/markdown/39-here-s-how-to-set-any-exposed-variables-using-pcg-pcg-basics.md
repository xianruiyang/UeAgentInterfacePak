# 39. Here's How to Set Any Exposed Variables Using PCG ｜ PCG Basics

# 39. Here's How to Set Any Exposed Variables Using PCG ｜ PCG Basics

## 知识目标

- 本文整理“39. Here's How to Set Any Exposed Variables Using PCG ｜ PCG Basics”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑。
- 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Random`
- `Graph`
- `Material`
- `Instance`
- `mobility`
- `distance`
- `call`
- `select`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p39/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p39/s01-02-S01_2_00_02_26.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Graph`

### 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑

**内容要点：**

- 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p39/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p39/s02-02-S02_2_00_06_19.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Instance`
- `call`

### 节点、参数和生成结果校验 03

**内容要点：**

- 节点、参数和生成结果校验 03。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p39/s03-01-S03_1_00_07_55.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p39/s03-02-S03_2_00_09_29.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Random`
- `Graph`
- `Instance`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


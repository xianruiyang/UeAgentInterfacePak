# 52. Create-a-FUN-Gameplay-Mechanic-With-PCG-_Media_m6bLuf8oAMw_001_1080p

# 52. Create-a-FUN-Gameplay-Mechanic-With-PCG-_Media_m6bLuf8oAMw_001_1080p

## 知识目标

- 本文整理“52. Create-a-FUN-Gameplay-Mechanic-With-PCG-_Media_m6bLuf8oAMw_001_1080p”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑。
- 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Bounds`
- `Random`
- `Loop`
- `Graph`
- `Material`
- `Instance`
- `collection`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s01-02-S01_2_00_01_48.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Component`
- `Spawn`
- `Random`
- `Loop`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s02-01-S02_1_00_03_46.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s02-02-S02_2_00_06_03.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Component`
- `Spawn`
- `Random`

### 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑

**内容要点：**

- 重点检查 PCG 与蓝图/运行时数据如何互通：哪些参数暴露到 Details 面板，哪些变量从 Blueprint 传入 PCG，哪些 PCG Attribute 又回写给 Actor 或运行时逻辑。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s03-01-S03_1_00_08_40.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s03-02-S03_2_00_10_18.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Graph`
- `Instance`
- `collection`

### 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统

**内容要点：**

- 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s04-01-S04_1_00_12_16.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s04-02-S04_2_00_14_30.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Loop`
- `Graph`
- `Instance`

### 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统（2）

**内容要点：**

- 复现时先用最小 Actor 或测试关卡验证属性读写，再扩大到完整玩法、保存加载、敌人生成、实例动态上色或可交互生成系统（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s05-01-S05_1_00_17_05.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s05-02-S05_2_00_18_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Component`
- `Spawn`
- `Loop`
- `Graph`

### 节点、参数和生成结果校验 06

**内容要点：**

- 节点、参数和生成结果校验 06。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s06-01-S06_1_00_20_09.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s06-02-S06_2_00_22_24.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Actor`
- `Component`
- `Spawn`
- `Random`
- `Loop`
- `Graph`
- `Material`
- `Instance`
- `crystal`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p52/s07-01-S07_1_00_24_59.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p52/s07-02-S07_2_00_26_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Actor`
- `Component`
- `Spawn`
- `Bounds`
- `Random`
- `Loop`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


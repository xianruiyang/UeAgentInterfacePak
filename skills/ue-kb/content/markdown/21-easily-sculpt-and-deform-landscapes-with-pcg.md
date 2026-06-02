# 21. Easily Sculpt and Deform Landscapes With PCG

# 21. Easily Sculpt and Deform Landscapes With PCG

## 知识目标

- 本文整理“21. Easily Sculpt and Deform Landscapes With PCG”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。
- 环境类流程要先稳定地形/表面/样条输入，再逐层加入树木、草、岩石、水体、洞穴、迷宫或地下城结构，并通过密度、坡度、高度和距离过滤分层控制。
- 关键检查点是投射到地形、随机缩放旋转、碰撞、Cull Distance、实例数量和边缘过渡，避免资产漂浮、穿地或密度失控。

## 关键术语

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Random`
- `Loop`
- `Graph`
- `Landscape`
- `landscape`
- `them`
- `texture`

## 操作步骤与要点

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s01-02-S01_2_00_01_48.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Component`
- `Graph`
- `Landscape`
- `landscape`

### 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）

**内容要点：**

- 先把本集标题对应的 PCG 目标拆成输入、规则、生成结果三层：输入通常是点、Spline、Volume、Actor、属性或表面数据；规则通常由过滤、变换、循环、语法、HLSL、自定义节点或子图负责；生成结果再交给 Static Mesh Spawner、Spawn Actor、Spline Mesh、实例化 Actor 或 Blueprint（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s02-01-S02_1_00_03_46.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s02-02-S02_2_00_05_56.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Random`
- `Graph`
- `Landscape`

### 环境类流程要先稳定地形/表面/样条输入，再逐层加入树木、草、岩石、水体、洞穴、迷宫或地下城结构，并通过密度、坡度、高度和距离过滤分层控制

**内容要点：**

- 环境类流程要先稳定地形/表面/样条输入，再逐层加入树木、草、岩石、水体、洞穴、迷宫或地下城结构，并通过密度、坡度、高度和距离过滤分层控制。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s03-01-S03_1_00_08_26.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s03-02-S03_2_00_09_50.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Point`
- `Random`
- `Landscape`
- `height`
- `scale`
- `encoding`
- `settings`
- `size`
- `only`

### 关键检查点是投射到地形、随机缩放旋转、碰撞、Cull Distance、实例数量和边缘过渡，避免资产漂浮、穿地或密度失控

**内容要点：**

- 关键检查点是投射到地形、随机缩放旋转、碰撞、Cull Distance、实例数量和边缘过渡，避免资产漂浮、穿地或密度失控。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s04-01-S04_1_00_11_33.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s04-02-S04_2_00_13_46.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Random`
- `Loop`
- `Graph`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s05-01-S05_1_00_16_20.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s05-02-S05_2_00_18_35.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Graph`
- `Landscape`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-practical-masterclass-collection-p21/s06-01-S06_1_00_21_09.jpg)
![关键截图 2](../assets/ue5-pcg-practical-masterclass-collection-p21/s06-02-S06_2_00_22_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Spawn`
- `Graph`
- `Landscape`

## 复现检查清单

- 所有 Static Mesh、Actor、Spline、Volume、PCG Graph 和 Blueprint 引用都要检查路径、类名、标签和坐标空间是否一致。
- PCG 点属性一旦跨子图、循环或 Blueprint 传递，必须核对属性名、类型和默认值；属性丢失通常会让后续过滤或生成分支静默失败。
- 大范围生成前先用小范围点集验证节点链路，再扩大密度和范围；不要在全量城市、森林或建筑上直接调试复杂规则。
- 涉及 UE 5.5/5.6/5.7 的新功能时，要记录版本依赖；旧项目复现前先确认节点是否存在或需要启用实验插件。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


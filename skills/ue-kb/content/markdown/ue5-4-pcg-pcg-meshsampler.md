# 【UE5.4 PCG教程】PCG MeshSampler节点的相关应用

# 【UE5.4 PCG教程】PCG MeshSampler节点的相关应用

## 知识目标

- 扩展 MeshSampler 的应用场景，用网格采样结果驱动多种表面生成和属性处理。

## 可复现主流程

- 选择不同网格作为采样源，比较采样分布和输出点属性。
- 结合法线、位置或材质区域决定实例朝向和过滤条件。
- 把采样结果接入不同生成分支，形成多类型细节。
- 检查复杂网格上的采样密度和性能。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `MeshSampler`
- `SubGraph`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `Material`

## 操作步骤与要点

### 选择不同网格作为采样源，比较采样分布和输出点属性

**内容要点：**

- 这一段对应“选择不同网格作为采样源，比较采样分布和输出点属性。”，主要作用是把本集主题“【UE5.4 PCG教程】PCG MeshSampler节点的相关应用”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`LitShow`
- 画面线索：`A+0281010101`
- 画面线索：`PCG`
- 画面线索：`L_MeshSample*`
- 画面线索：`INIA:`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`PerspectiveLitShow`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `L_MeshSample`
- `LitShow`
- `INIA`
- `Platforms`
- `Setings`
- `PerspectiveLitShow`
- `PlaceActors`

### 结合法线、位置或材质区域决定实例朝向和过滤条件

**内容要点：**

- 这一段对应“结合法线、位置或材质区域决定实例朝向和过滤条件。”，主要作用是把本集主题“【UE5.4 PCG教程】PCG MeshSampler节点的相关应用”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG`
- 画面线索：`L_MeshSample*`
- 画面线索：`INIA`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`LitShow`
- 画面线索：`82名10410`
- 画面线索：`World Sett..`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `L_MeshSample`
- `INIA`
- `Platforms`
- `Setings`
- `LitShow`
- `Sett`
- `Uncontrolled`
- `Unsaved`

### 把采样结果接入不同生成分支，形成多类型细节

**内容要点：**

- 这一段对应“把采样结果接入不同生成分支，形成多类型细节。”，主要作用是把本集主题“【UE5.4 PCG教程】PCG MeshSampler节点的相关应用”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG`
- 画面线索：`L_MeshSample*`
- 画面线索：`Selection Mode`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`PlaceActors`
- 画面线索：`World Sett.`
- 画面线索：`Uncontrolled`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s03-02-S03_2_00_07_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `L_MeshSample`
- `Selection`
- `Mode`
- `Platforms`
- `Setings`
- `PlaceActors`
- `Sett`

### 检查复杂网格上的采样密度和性能

**内容要点：**

- 这一段对应“检查复杂网格上的采样密度和性能。”，主要作用是把本集主题“【UE5.4 PCG教程】PCG MeshSampler节点的相关应用”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`OLitShow`
- 画面线索：`+33用1041011`
- 画面线索：`15.12FPS`
- 画面线索：`56.12ms`
- 画面线索：`OLit`
- 画面线索：`+22用10410101`
- 画面线索：`36.14FPS`
- 画面线索：`28.66ms`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p13/s04-01-S04_1_00_09_04.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p13/s04-02-S04_2_00_09_11.jpg)


**参数、节点和风险点：**

- `OLitShow`
- `OLit`
- `CLit`

## 复现检查清单

- 复杂网格上采样成本更高。
- 采样结果需要和目标实例的 Pivot/朝向匹配。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


# 4-4 - Import Grass Foliage to Unreal Engine 5 and create Subsurface Material

# 4-4 - Import Grass Foliage to Unreal Engine 5 and create Subsurface Material

## 知识目标

- 本文整理“4-4 - Import Grass Foliage to Unreal Engine 5 and create Subsurface Material”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 把草资产导入 UE5，设置双面 foliage/subsurface 材质。
- 连接 Base Color、Opacity Mask、Normal、Roughness、Subsurface Color 和风动画输入。
- 建立材质实例，暴露颜色、透光、粗糙度、风强度和随机变化参数。
- 在地表上批量放置测试，检查明暗、透明排序、阴影和性能。

## 关键术语

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Random`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `grass`
- `more`
- `good`
- `foliage`
- `some`

## 操作步骤与要点

### 把草资产导入 UE5，设置双面 foliage/subsurface 材质

**内容要点：**

- 把草资产导入 UE5，设置双面 foliage/subsurface 材质。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s01-02-S01_2_00_01_32.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Landscape`
- `lower`
- `more`
- `some`
- `forth`
- `better`
- `spline`
- `detailed`

### 把草资产导入 UE5，设置双面 foliage/subsurface 材质（2）

**内容要点：**

- 把草资产导入 UE5，设置双面 foliage/subsurface 材质（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s02-01-S02_1_00_03_18.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s02-02-S02_2_00_04_39.jpg)


**参数、节点和风险点：**

- `Material`
- `material`
- `paint`
- `layer`
- `brush`
- `displacement`
- `third`
- `strength`
- `good`
- `reveal`

### 连接 Base Color、Opacity Mask、Normal、Roughness、Subsurface Color 和风动画输入

**内容要点：**

- 连接 Base Color、Opacity Mask、Normal、Roughness、Subsurface Color 和风动画输入。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s03-01-S03_1_00_06_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s03-02-S03_2_00_07_41.jpg)


**参数、节点和风险点：**

- `Static Mesh`
- `Mesh`
- `Mask`
- `Material`
- `grass`
- `build`
- `dead`
- `more`
- `material`
- `Good`

### 连接 Base Color、Opacity Mask、Normal、Roughness、Subsurface Color 和风动画输入（2）

**内容要点：**

- 连接 Base Color、Opacity Mask、Normal、Roughness、Subsurface Color 和风动画输入（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s04-01-S04_1_00_09_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s04-02-S04_2_00_10_47.jpg)


**参数、节点和风险点：**

- `Mask`
- `Material`
- `color`
- `subsurface`
- `mask`
- `promote`
- `parameter`
- `call`
- `grass`
- `multiply`

### 建立材质实例，暴露颜色、透光、粗糙度、风强度和随机变化参数

**内容要点：**

- 建立材质实例，暴露颜色、透光、粗糙度、风强度和随机变化参数。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s05-01-S05_1_00_12_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s05-02-S05_2_00_13_47.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Mask`
- `Material`
- `Instance`
- `grass`
- `collision`
- `remove`
- `save`
- `material`
- `foliage`

### 建立材质实例，暴露颜色、透光、粗糙度、风强度和随机变化参数（2）

**内容要点：**

- 建立材质实例，暴露颜色、透光、粗糙度、风强度和随机变化参数（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s06-01-S06_1_00_15_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s06-02-S06_2_00_17_34.jpg)


**参数、节点和风险点：**

- `Point`
- `Random`
- `Landscape`
- `point`
- `five`
- `subsurface`
- `more`
- `some`
- `curve`

### 在地表上批量放置测试，检查明暗、透明排序、阴影和性能

**内容要点：**

- 在地表上批量放置测试，检查明暗、透明排序、阴影和性能。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p31/s07-01-S07_1_00_20_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p31/s07-02-S07_2_00_21_16.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Material`
- `Landscape`
- `small`
- `good`
- `spruce`
- `some`
- `think`
- `foliage`

## 复现检查清单

- 草材质既要透光自然，也要避免阴影过重或透明排序导致闪烁。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


# 5-2 - Finish PCG System

# 5-2 - Finish PCG System

## 知识目标

- 本文整理“5-2 - Finish PCG System”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 完善 PCG 分支，把树木、草、石头、落叶等资源按不同规则生成。
- 加入密度过滤、坡度/高度约束、随机种子和资源变体，形成自然分布。
- 整理参数暴露和图表注释，方便后续调场景时快速修改。
- 在目标地形上反复 Generate，检查实例数量、重叠、贴地和性能。

## 关键术语

- `PCG`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`
- `Material`
- `Instance`
- `Landscape`
- `point`
- `more`
- `density`
- `tree`
- `trees`

## 操作步骤与要点

### 完善 PCG 分支，把树木、草、石头、落叶等资源按不同规则生成

**内容要点：**

- 完善 PCG 分支，把树木、草、石头、落叶等资源按不同规则生成。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p33/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p33/s01-02-S01_2_00_02_08.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Graph`
- `Material`
- `Landscape`
- `some`
- `water`
- `lighting`
- `already`

### 加入密度过滤、坡度/高度约束、随机种子和资源变体，形成自然分布

**内容要点：**

- 加入密度过滤、坡度/高度约束、随机种子和资源变体，形成自然分布。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p33/s02-01-S02_1_00_04_27.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p33/s02-02-S02_2_00_06_44.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`
- `Material`
- `Instance`

### 整理参数暴露和图表注释，方便后续调场景时快速修改

**内容要点：**

- 整理参数暴露和图表注释，方便后续调场景时快速修改。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p33/s03-01-S03_1_00_09_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p33/s03-02-S03_2_00_11_05.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `Landscape`

## 复现检查清单

- 完成 PCG 系统时要把可调参数集中管理，避免长图表难以维护。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


# 5-1 - Setting up PCG

# 5-1 - Setting up PCG

## 知识目标

- 本文整理“5-1 - Setting up PCG”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源。
- 用 Surface Sampler 或相关节点生成基础点云，先用 Debug 检查范围和密度。
- 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件。
- 建立与样条路径的交互逻辑，为道路留白和边缘植被做准备。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `grass`
- `point`
- `more`

## 操作步骤与要点

### 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源

**内容要点：**

- 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s01-02-S01_2_00_02_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Spawn`
- `Graph`
- `Mask`
- `Material`
- `Instance`
- `Landscape`

### 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源（2）

**内容要点：**

- 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s02-02-S02_2_00_07_09.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `Material`
- `density`
- `mesh`

### 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源（3）

**内容要点：**

- 创建 PCG Graph/Volume，读取 Landscape 或目标区域作为采样源（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s03-01-S03_1_00_09_35.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s03-02-S03_2_00_11_12.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`
- `point`

### 用 Surface Sampler 或相关节点生成基础点云，先用 Debug 检查范围和密度

**内容要点：**

- 用 Surface Sampler 或相关节点生成基础点云，先用 Debug 检查范围和密度。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s04-01-S04_1_00_13_08.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s04-02-S04_2_00_14_54.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Random`
- `Graph`
- `Landscape`
- `rotation`
- `five`
- `point`
- `minus`

### 用 Surface Sampler 或相关节点生成基础点云，先用 Debug 检查范围和密度（2）

**内容要点：**

- 用 Surface Sampler 或相关节点生成基础点云，先用 Debug 检查范围和密度（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s05-01-S05_1_00_17_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s05-02-S05_2_00_19_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `Instance`
- `Landscape`

### 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件

**内容要点：**

- 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s06-01-S06_1_00_21_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s06-02-S06_2_00_23_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `Mask`
- `Material`
- `more`

### 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件（2）

**内容要点：**

- 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s07-01-S07_1_00_25_20.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s07-02-S07_2_00_27_33.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spawn`
- `Graph`
- `Material`
- `Landscape`
- `grass`
- `mesh`

### 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件（3）

**内容要点：**

- 接入树、草、岩石等资源分支，分别控制密度、随机旋转、缩放和过滤条件（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s08-01-S08_1_00_30_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s08-02-S08_2_00_32_18.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Graph`
- `grass`
- `more`

### 建立与样条路径的交互逻辑，为道路留白和边缘植被做准备

**内容要点：**

- 建立与样条路径的交互逻辑，为道路留白和边缘植被做准备。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s09-01-S09_1_00_34_51.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s09-02-S09_2_00_36_54.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Random`
- `Graph`
- `Material`

### 建立与样条路径的交互逻辑，为道路留白和边缘植被做准备（2）

**内容要点：**

- 建立与样条路径的交互逻辑，为道路留白和边缘植被做准备（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p32/s10-01-S10_1_00_39_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p32/s10-02-S10_2_00_39_13.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `more`
- `populate`
- `scene`
- `continue`
- `next`
- `lecture`
- `bilibii`

## 复现检查清单

- PCG 第一版要先验证点云范围，不要一开始就接入大量资产。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


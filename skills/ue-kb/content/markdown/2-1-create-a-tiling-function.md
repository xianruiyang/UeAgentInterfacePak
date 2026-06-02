# 2-1 - Create a Tiling Function

# 2-1 - Create a Tiling Function

## 知识目标

- 本文整理“2-1 - Create a Tiling Function”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建可复用的材质函数，封装 Texture Coordinate、缩放和平铺参数。
- 把不同地表纹理通过同一函数控制比例，避免每个材质层手动重复节点。
- 暴露 tiling 参数给材质实例，方便在场景中快速调整地表纹理尺度。
- 用简单材质预览函数输出，确认 UV 比例和纹理方向正确。

## 关键术语

- `Material`
- `Instance`
- `Landscape`
- `material`
- `function`
- `landscape`
- `texture`
- `near`
- `inside`
- `tiling`

## 操作步骤与要点

### 创建可复用的材质函数，封装 Texture Coordinate、缩放和平铺参数

**内容要点：**

- 创建可复用的材质函数，封装 Texture Coordinate、缩放和平铺参数。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p09/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p09/s01-02-S01_2_00_02_31.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `function`
- `material`
- `landscape`
- `near`
- `inside`
- `lighting`
- `already`

### 暴露 tiling 参数给材质实例，方便在场景中快速调整地表纹理尺度

**内容要点：**

- 暴露 tiling 参数给材质实例，方便在场景中快速调整地表纹理尺度。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p09/s02-01-S02_1_00_05_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p09/s02-02-S02_2_00_07_17.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `material`
- `landscape`
- `function`
- `texture`
- `tiling`
- `input`
- `near`

## 复现检查清单

- 材质函数的输入输出类型要稳定，后续层函数会复用它。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


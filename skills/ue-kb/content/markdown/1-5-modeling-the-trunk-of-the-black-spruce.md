# 1-5 - Modeling the Trunk of the Black Spruce

# 1-5 - Modeling the Trunk of the Black Spruce

## 知识目标

- 本文整理“1-5 - Modeling the Trunk of the Black Spruce”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 根据黑云杉树形建立树干主干、根部过渡和可挂接枝条的位置关系。
- 控制树干轮廓的弯曲、粗细变化和分段密度，让远景有形体、近景不显得过度规则。
- 为树干创建 UV 与材质分区，保证树皮纹理方向沿主干自然延伸。
- 检查 pivot、比例和枝条挂点，让组装整棵树时旋转、缩放和风动画都能稳定工作。

## 关键术语

- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Loop`
- `more`
- `already`
- `scale`

## 操作步骤与要点

### 根据黑云杉树形建立树干主干、根部过渡和可挂接枝条的位置关系

**内容要点：**

- 根据黑云杉树形建立树干主干、根部过渡和可挂接枝条的位置关系。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s01-02-S01_2_00_02_26.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Loop`
- `already`
- `tree`
- `branches`
- `trunk`
- `even`
- `increase`
- `half`

### 根据黑云杉树形建立树干主干、根部过渡和可挂接枝条的位置关系（2）

**内容要点：**

- 根据黑云杉树形建立树干主干、根部过渡和可挂接枝条的位置关系（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s02-02-S02_2_00_06_36.jpg)


**参数、节点和风险点：**

- `Transform`
- `scale`
- `more`
- `shift`
- `sorry`
- `pack`
- `unwrap`

### 控制树干轮廓的弯曲、粗细变化和分段密度，让远景有形体、近景不显得过度规则

**内容要点：**

- 控制树干轮廓的弯曲、粗细变化和分段密度，让远景有形体、近景不显得过度规则。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s03-01-S03_1_00_08_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s03-02-S03_2_00_10_47.jpg)


**参数、节点和风险点：**

- `Actor`
- `texture`
- `textures`
- `they`
- `already`
- `apply`
- `resolution`

### 为树干创建 UV 与材质分区，保证树皮纹理方向沿主干自然延伸

**内容要点：**

- 为树干创建 UV 与材质分区，保证树皮纹理方向沿主干自然延伸。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s04-01-S04_1_00_13_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s04-02-S04_2_00_14_53.jpg)


**参数、节点和风险点：**

- `Actor`
- `more`
- `still`
- `detail`
- `small`
- `chunk`
- `radius`

### 为树干创建 UV 与材质分区，保证树皮纹理方向沿主干自然延伸（2）

**内容要点：**

- 为树干创建 UV 与材质分区，保证树皮纹理方向沿主干自然延伸（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s05-01-S05_1_00_16_41.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s05-02-S05_2_00_18_57.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Point`
- `more`
- `center`
- `origin`
- `move`
- `perfectly`
- `fine`
- `select`

### 检查 pivot、比例和枝条挂点，让组装整棵树时旋转、缩放和风动画都能稳定工作

**内容要点：**

- 检查 pivot、比例和枝条挂点，让组装整棵树时旋转、缩放和风动画都能稳定工作。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p05/s06-01-S06_1_00_21_29.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p05/s06-02-S06_2_00_21_38.jpg)


**参数、节点和风险点：**

- `some`
- `export`
- `next`
- `lecture`
- `nice`
- `polyhaven`
- `textures`
- `everything`
- `outside`
- `blue`

## 复现检查清单

- 树干是后续树冠组织的骨架，比例和 pivot 错误会放大到整棵树资产。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


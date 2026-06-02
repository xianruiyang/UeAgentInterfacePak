# 2-15 - Enable RVT Height Blending Mesh Material

# 2-15 - Enable RVT Height Blending Mesh Material

## 知识目标

- 本文整理“2-15 - Enable RVT Height Blending Mesh Material”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色。
- 用高度差、法线和颜色信息让 Mesh 边缘与地面自然混合。
- 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表。
- 在不同地形高度和坡度上测试融合效果。

## 关键术语

- `Blueprint`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Bounds`
- `Random`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `height`
- `blend`
- `landscape`
- `normal`

## 操作步骤与要点

### 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色

**内容要点：**

- 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s01-02-S01_2_00_02_25.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `landscape`
- `show`
- `only`
- `blend`

### 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色（2）

**内容要点：**

- 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s02-01-S02_1_00_05_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s02-02-S02_2_00_06_37.jpg)


**参数、节点和风险点：**

- `Actor`
- `Material`
- `Landscape`
- `height`
- `material`
- `texture`
- `landscape`
- `virtual`
- `copy`

### 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色（3）

**内容要点：**

- 在道路、岩石或样条 Mesh 材质中读取 Landscape RVT 高度和颜色（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s03-01-S03_1_00_08_33.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s03-02-S03_2_00_10_25.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Attribute`
- `Component`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `world`
- `space`

### 用高度差、法线和颜色信息让 Mesh 边缘与地面自然混合

**内容要点：**

- 用高度差、法线和颜色信息让 Mesh 边缘与地面自然混合。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s04-01-S04_1_00_12_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s04-02-S04_2_00_14_54.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Mask`
- `Material`
- `Landscape`
- `channel`
- `height`
- `node`
- `object`
- `bounce`

### 用高度差、法线和颜色信息让 Mesh 边缘与地面自然混合（2）

**内容要点：**

- 用高度差、法线和颜色信息让 Mesh 边缘与地面自然混合（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s05-01-S05_1_00_17_32.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s05-02-S05_2_00_19_39.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Mesh`
- `Component`
- `Mask`
- `Material`
- `Landscape`
- `material`
- `function`
- `vertex`

### 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表

**内容要点：**

- 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s06-01-S06_1_00_22_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s06-02-S06_2_00_24_26.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Attribute`
- `Actor`
- `Bounds`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `landscape`
- `normal`

### 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表（2）

**内容要点：**

- 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s07-01-S07_1_00_27_03.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s07-02-S07_2_00_28_32.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Material`
- `Landscape`
- `material`
- `blend`
- `normal`
- `attributes`
- `drag`
- `drop`
- `information`

### 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表（3）

**内容要点：**

- 调整混合宽度、偏移和噪声，避免 Mesh 像贴片一样浮在地表（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s08-01-S08_1_00_30_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s08-02-S08_2_00_31_40.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Attribute`
- `Material`
- `Landscape`
- `material`
- `only`
- `transform`
- `vector`
- `space`

### 在不同地形高度和坡度上测试融合效果

**内容要点：**

- 在不同地形高度和坡度上测试融合效果。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s09-01-S09_1_00_33_15.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s09-02-S09_2_00_35_18.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Bounds`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `height`
- `project`
- `blend`
- `landscape`

### 在不同地形高度和坡度上测试融合效果（2）

**内容要点：**

- 在不同地形高度和坡度上测试融合效果（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p23/s10-01-S10_1_00_37_45.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p23/s10-02-S10_2_00_38_29.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Random`
- `Material`
- `Instance`
- `Landscape`
- `much`
- `course`
- `better`
- `perfectly`
- `textures`

## 复现检查清单

- Mesh 与 Landscape 的坐标空间、高度基准和 RVT 数据通道必须一致。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


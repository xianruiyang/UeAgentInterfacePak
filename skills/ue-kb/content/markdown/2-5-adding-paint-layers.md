# 2-5 - Adding Paint Layers

# 2-5 - Adding Paint Layers

## 知识目标

- 本文整理“2-5 - Adding Paint Layers”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 在 Landscape 材质中添加 Paint Layer，并为每层创建对应 Layer Info。
- 把地表纹理函数接入 Landscape Layer Blend，建立可手绘的泥土、草地、岩石等层。
- 在 Landscape Paint 模式下刷涂并检查层权重、过渡边缘和材质响应。
- 整理材质实例参数，让不同层的 tiling、颜色和强度可以单独调整。

## 关键术语

- `Graph`
- `Material`
- `Instance`
- `Landscape`
- `layer`
- `material`
- `rock`
- `distance`
- `landscape`
- `layers`
- `inside`
- `logic`
- `blend`
- `save`

## 操作步骤与要点

### 在 Landscape 材质中添加 Paint Layer，并为每层创建对应 Layer Info

**内容要点：**

- 在 Landscape 材质中添加 Paint Layer，并为每层创建对应 Layer Info。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s01-02-S01_2_00_01_41.jpg)


**参数、节点和风险点：**

- `Graph`
- `Material`
- `Landscape`
- `layers`
- `layer`
- `distance`
- `call`
- `material`
- `copy`
- `folder`

### 在 Landscape 材质中添加 Paint Layer，并为每层创建对应 Layer Info（2）

**内容要点：**

- 在 Landscape 材质中添加 Paint Layer，并为每层创建对应 Layer Info（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s02-01-S02_1_00_03_32.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s02-02-S02_2_00_05_36.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `everything`
- `inside`
- `layer`
- `material`
- `distance`
- `texture`

### 把地表纹理函数接入 Landscape Layer Blend，建立可手绘的泥土、草地、岩石等层

**内容要点：**

- 把地表纹理函数接入 Landscape Layer Blend，建立可手绘的泥土、草地、岩石等层。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s03-01-S03_1_00_08_05.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s03-02-S03_2_00_09_33.jpg)


**参数、节点和风险点：**

- `Graph`
- `Material`
- `Landscape`
- `material`
- `layer`
- `would`
- `distance`
- `case`
- `first`
- `texture`

### 把地表纹理函数接入 Landscape Layer Blend，建立可手绘的泥土、草地、岩石等层（2）

**内容要点：**

- 把地表纹理函数接入 Landscape Layer Blend，建立可手绘的泥土、草地、岩石等层（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s04-01-S04_1_00_11_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s04-02-S04_2_00_12_42.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `layer`
- `would`
- `underscore`
- `align`
- `albedo`
- `controls`
- `distance`

### 在 Landscape Paint 模式下刷涂并检查层权重、过渡边缘和材质响应

**内容要点：**

- 在 Landscape Paint 模式下刷涂并检查层权重、过渡边缘和材质响应。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s05-01-S05_1_00_14_23.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s05-02-S05_2_00_16_31.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `rock`
- `layer`
- `material`
- `save`
- `slope`
- `layers`
- `align`
- `automatically`

### 在 Landscape Paint 模式下刷涂并检查层权重、过渡边缘和材质响应（2）

**内容要点：**

- 在 Landscape Paint 模式下刷涂并检查层权重、过渡边缘和材质响应（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s06-01-S06_1_00_18_59.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s06-02-S06_2_00_21_03.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `distance`
- `blend`
- `logic`
- `material`
- `reroute`
- `sense`
- `copy`
- `cache`

### 整理材质实例参数，让不同层的 tiling、颜色和强度可以单独调整

**内容要点：**

- 整理材质实例参数，让不同层的 tiling、颜色和强度可以单独调整。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s07-01-S07_1_00_23_27.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s07-02-S07_2_00_25_06.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `material`
- `layer`
- `landscape`
- `reason`
- `blend`
- `function`

### 整理材质实例参数，让不同层的 tiling、颜色和强度可以单独调整（2）

**内容要点：**

- 整理材质实例参数，让不同层的 tiling、颜色和强度可以单独调整（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p13/s08-01-S08_1_00_27_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p13/s08-02-S08_2_00_28_20.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `layer`
- `landscape`
- `inside`
- `save`
- `info`
- `material`
- `function`

## 复现检查清单

- Layer Info 缺失或类型错误会导致 Paint Layer 不能正常保存或显示。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


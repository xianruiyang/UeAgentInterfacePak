# 2-10 - Add Slope Function

# 2-10 - Add Slope Function

## 知识目标

- 本文整理“2-10 - Add Slope Function”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质。
- 设置坡度阈值、过渡宽度和噪声扰动，使岩石等材质自然出现在陡坡区域。
- 把坡度结果与手绘层或高度混合结合，避免自动规则完全覆盖人工绘制。
- 在不同地形起伏下检查函数输出，保证山坡、沟谷和道路边缘都稳定。

## 关键术语

- `Blueprint`
- `Attribute`
- `Component`
- `Graph`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `alpha`
- `material`
- `normal`
- `function`
- `slope`
- `call`
- `albedo`
- `wanna`

## 操作步骤与要点

### 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质

**内容要点：**

- 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s01-02-S01_2_00_01_28.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Material`
- `material`
- `underscore`
- `reroute`
- `call`
- `node`
- `color`
- `function`
- `named`

### 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质（2）

**内容要点：**

- 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s02-01-S02_1_00_03_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s02-02-S02_2_00_04_45.jpg)


**参数、节点和风险点：**

- `Graph`
- `Material`
- `alpha`
- `albedo`
- `lerp`
- `remove`
- `normal`
- `first`
- `call`
- `reroute`

### 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质（3）

**内容要点：**

- 创建基于法线或坡度的材质函数，用来在陡坡与平地之间自动切换材质（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s03-01-S03_1_00_06_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s03-02-S03_2_00_09_00.jpg)


**参数、节点和风险点：**

- `Material`
- `normal`
- `alpha`
- `specular`
- `roughness`

### 设置坡度阈值、过渡宽度和噪声扰动，使岩石等材质自然出现在陡坡区域

**内容要点：**

- 设置坡度阈值、过渡宽度和噪声扰动，使岩石等材质自然出现在陡坡区域。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s04-01-S04_1_00_11_33.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s04-02-S04_2_00_13_11.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Material`
- `alpha`
- `material`
- `normal`
- `wanna`
- `logic`
- `call`
- `would`
- `vertex`

### 设置坡度阈值、过渡宽度和噪声扰动，使岩石等材质自然出现在陡坡区域（2）

**内容要点：**

- 设置坡度阈值、过渡宽度和噪声扰动，使岩石等材质自然出现在陡坡区域（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s05-01-S05_1_00_15_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s05-02-S05_2_00_16_55.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Component`
- `Mask`
- `Material`
- `Landscape`
- `material`
- `output`
- `specular`
- `roughness`
- `normal`

### 把坡度结果与手绘层或高度混合结合，避免自动规则完全覆盖人工绘制

**内容要点：**

- 把坡度结果与手绘层或高度混合结合，避免自动规则完全覆盖人工绘制。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s06-01-S06_1_00_18_58.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s06-02-S06_2_00_20_28.jpg)


**参数、节点和风险点：**

- `Mask`
- `Material`
- `Normal`
- `wanna`
- `multiply`
- `output`
- `slope`
- `same`
- `Vertex`
- `Pixel`

### 把坡度结果与手绘层或高度混合结合，避免自动规则完全覆盖人工绘制（2）

**内容要点：**

- 把坡度结果与手绘层或高度混合结合，避免自动规则完全覆盖人工绘制（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s07-01-S07_1_00_22_20.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s07-02-S07_2_00_24_40.jpg)


**参数、节点和风险点：**

- `Graph`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `function`
- `slope`
- `layer`
- `landscape`
- `logic`

### 在不同地形起伏下检查函数输出，保证山坡、沟谷和道路边缘都稳定

**内容要点：**

- 在不同地形起伏下检查函数输出，保证山坡、沟谷和道路边缘都稳定。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s08-01-S08_1_00_27_20.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s08-02-S08_2_00_28_42.jpg)


**参数、节点和风险点：**

- `Mask`
- `Material`
- `Landscape`
- `rock`
- `slope`
- `working`
- `albedo`
- `mossy`
- `falloff`
- `five`

### 在不同地形起伏下检查函数输出，保证山坡、沟谷和道路边缘都稳定（2）

**内容要点：**

- 在不同地形起伏下检查函数输出，保证山坡、沟谷和道路边缘都稳定（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p18/s09-01-S09_1_00_30_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p18/s09-02-S09_2_00_32_05.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `rock`
- `working`
- `tiling`
- `save`
- `landscape`
- `eight`

## 复现检查清单

- 坡度函数要和地形法线、世界空间方向一致，阈值过窄会造成斑块闪烁。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


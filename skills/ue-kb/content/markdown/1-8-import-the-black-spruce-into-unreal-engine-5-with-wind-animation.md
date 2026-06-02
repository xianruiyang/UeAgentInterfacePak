# 1-8 - Import the Black Spruce into Unreal Engine 5 with Wind Animation

# 1-8 - Import the Black Spruce into Unreal Engine 5 with Wind Animation

## 知识目标

- 本文整理“1-8 - Import the Black Spruce into Unreal Engine 5 with Wind Animation”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接。
- 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化。
- 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重。
- 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能。

## 关键术语

- `Mesh`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Density`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `color`

## 操作步骤与要点

### 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接

**内容要点：**

- 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s01-02-S01_2_00_02_26.jpg)


**参数、节点和风险点：**

- `Actor`
- `Mask`
- `Material`
- `Landscape`
- `project`
- `already`
- `level`
- `lighting`
- `case`
- `reflections`

### 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（2）

**内容要点：**

- 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s02-01-S02_1_00_05_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s02-02-S02_2_00_07_24.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `Landscape`
- `more`
- `backdrop`
- `sure`
- `landscape`
- `cube`

### 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（3）

**内容要点：**

- 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s03-01-S03_1_00_10_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s03-02-S03_2_00_11_26.jpg)


**参数、节点和风险点：**

- `Landscape`
- `HDRI`
- `Control`
- `bookmark`
- `same`
- `backdrop`

### 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（4）

**内容要点：**

- 将黑云杉导入 UE5，检查比例、pivot、法线、材质槽、透明/双面设置和贴图连接（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s04-01-S04_1_00_13_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s04-02-S04_2_00_15_25.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Component`
- `Density`
- `Landscape`
- `zero`
- `height`
- `fork`
- `light`
- `still`
- `completely`

### 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化

**内容要点：**

- 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s05-01-S05_1_00_18_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s05-02-S05_2_00_20_12.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `material`
- `trunk`
- `base`
- `roughness`
- `color`
- `textures`
- `normal`
- `more`

### 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化（2）

**内容要点：**

- 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s06-01-S06_1_00_22_46.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s06-02-S06_2_00_25_06.jpg)


**参数、节点和风险点：**

- `Material`
- `color`
- `roughness`
- `material`
- `base`
- `value`
- `black`
- `node`
- `alpha`

### 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化（3）

**内容要点：**

- 建立树叶/树枝材质，处理 Two Sided Foliage、Opacity Mask、Normal、Roughness 与颜色变化（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s07-01-S07_1_00_27_46.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s07-02-S07_2_00_29_21.jpg)


**参数、节点和风险点：**

- `Material`
- `wind`
- `simple`
- `promote`
- `parameter`
- `color`
- `material`

### 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重

**内容要点：**

- 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s08-01-S08_1_00_31_17.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s08-02-S08_2_00_32_46.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Material`
- `Instance`
- `already`
- `hook`
- `variable`
- `normal`
- `same`
- `values`

### 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重（2）

**内容要点：**

- 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s09-01-S09_1_00_34_35.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s09-02-S09_2_00_36_52.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Material`
- `Instance`
- `material`
- `surface`
- `color`
- `instance`
- `change`
- `sided`

### 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重（3）

**内容要点：**

- 加入风动画或 World Position Offset，控制树枝摆动幅度、频率和顶点权重（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s10-01-S10_1_00_39_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s10-02-S10_2_00_41_24.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `Instance`
- `material`
- `decimate`
- `instance`
- `blender`
- `trunk`
- `step`

### 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能

**内容要点：**

- 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s11-01-S11_1_00_43_38.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s11-02-S11_2_00_45_56.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `color`
- `scatter`
- `collision`
- `intensity`
- `already`
- `subsurface`

### 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能（2）

**内容要点：**

- 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s12-01-S12_1_00_48_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s12-02-S12_2_00_50_48.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Attribute`
- `Material`
- `Instance`
- `Landscape`
- `light`
- `subsurface`
- `material`
- `scattering`
- `tree`

### 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能（3）

**内容要点：**

- 在关卡中放置多个实例，检查风动画同步感、阴影、Nanite/LOD、碰撞和性能（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p08/s13-01-S13_1_00_53_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p08/s13-02-S13_2_00_54_16.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Material`
- `Landscape`
- `trees`
- `course`
- `mean`
- `rotate`

## 复现检查清单

- 风动画要避免整棵树刚性摆动，枝叶权重、WPO 幅度和性能需要一起验证。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


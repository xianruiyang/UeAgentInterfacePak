# 1-6 - Texturing the Trunk of the Black Spruce in Substance Painter

# 1-6 - Texturing the Trunk of the Black Spruce in Substance Painter

## 知识目标

- 本文整理“1-6 - Texturing the Trunk of the Black Spruce in Substance Painter”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 在 Substance Painter 中烘焙或检查树干法线、AO、曲率等辅助贴图。
- 制作树皮颜色、粗糙度、法线和细节变化，强调纵向纹理、裂缝和根部过渡。
- 导出贴图时匹配 UE5 材质输入，必要时把 Roughness/AO/Displacement 等通道打包。
- 回到 DCC 或 UE5 中预览树干与枝条的色彩、粗糙度和明暗是否协调。

## 关键术语

- `Mesh`
- `Mask`
- `Material`
- `color`
- `change`
- `case`
- `more`
- `curvature`
- `texture`

## 操作步骤与要点

### 在 Substance Painter 中烘焙或检查树干法线、AO、曲率等辅助贴图

**内容要点：**

- 在 Substance Painter 中烘焙或检查树干法线、AO、曲率等辅助贴图。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s01-02-S01_2_00_02_26.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `texture`
- `change`
- `displacement`
- `layer`
- `material`
- `already`
- `trees`

### 在 Substance Painter 中烘焙或检查树干法线、AO、曲率等辅助贴图（2）

**内容要点：**

- 在 Substance Painter 中烘焙或检查树干法线、AO、曲率等辅助贴图（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s02-01-S02_1_00_05_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s02-02-S02_2_00_06_41.jpg)


**参数、节点和风险点：**

- `Mask`
- `curvature`
- `thickness`
- `weird`
- `levels`
- `called`
- `generator`
- `increase`

### 制作树皮颜色、粗糙度、法线和细节变化，强调纵向纹理、裂缝和根部过渡

**内容要点：**

- 制作树皮颜色、粗糙度、法线和细节变化，强调纵向纹理、裂缝和根部过渡。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s03-01-S03_1_00_08_38.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s03-02-S03_2_00_10_10.jpg)


**参数、节点和风险点：**

- `Mask`
- `Material`
- `case`
- `color`
- `change`
- `multiply`
- `only`
- `always`
- `nice`
- `more`

### 导出贴图时匹配 UE5 材质输入，必要时把 Roughness/AO/Displacement 等通道打包

**内容要点：**

- 导出贴图时匹配 UE5 材质输入，必要时把 Roughness/AO/Displacement 等通道打包。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s04-01-S04_1_00_12_05.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s04-02-S04_2_00_13_37.jpg)


**参数、节点和风险点：**

- `color`
- `more`
- `change`
- `brownish`
- `think`
- `filter`
- `source`

### 导出贴图时匹配 UE5 材质输入，必要时把 Roughness/AO/Displacement 等通道打包（2）

**内容要点：**

- 导出贴图时匹配 UE5 材质输入，必要时把 Roughness/AO/Displacement 等通道打包（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s05-01-S05_1_00_15_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s05-02-S05_2_00_16_45.jpg)


**参数、节点和风险点：**

- `Mask`
- `color`
- `occlusion`
- `multiply`
- `ambient`
- `contrast`
- `more`
- `instead`
- `lighten`
- `original`

### 回到 DCC 或 UE5 中预览树干与枝条的色彩、粗糙度和明暗是否协调

**内容要点：**

- 回到 DCC 或 UE5 中预览树干与枝条的色彩、粗糙度和明暗是否协调。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p06/s06-01-S06_1_00_18_19.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p06/s06-02-S06_2_00_20_06.jpg)


**参数、节点和风险点：**

- `color`
- `ambient`
- `occlusion`
- `moss`
- `repetition`
- `hide`
- `roughness`

## 复现检查清单

- 树干材质要与枝条材质统一光照响应，避免组装后出现树干过亮或树冠过黑。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


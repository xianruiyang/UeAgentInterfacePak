# 1-3 - Modeling the Branches of the Black Spruce

# 1-3 - Modeling the Branches of the Black Spruce

## 知识目标

- 本文整理“1-3 - Modeling the Branches of the Black Spruce”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块。
- 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向。
- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强。
- 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度。
- 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别。

## 关键术语

- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Spawn`
- `Density`
- `Loop`
- `Material`
- `branch`
- `chunk`
- `more`

## 操作步骤与要点

### 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块

**内容要点：**

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s01-02-S01_2_00_02_28.jpg)


**参数、节点和风险点：**

- `Transform`
- `Spawn`
- `branch`
- `chunk`

### 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（2）

**内容要点：**

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s02-01-S02_1_00_05_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s02-02-S02_2_00_06_30.jpg)


**参数、节点和风险点：**

- `Transform`
- `Density`
- `topology`
- `control`
- `always`
- `tree`
- `copy`

### 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（3）

**内容要点：**

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s03-01-S03_1_00_08_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s03-02-S03_2_00_10_31.jpg)


**参数、节点和风险点：**

- `Transform`
- `Material`
- `branch`
- `scale`
- `unwrap`
- `move`
- `edit`
- `mode`

### 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（4）

**内容要点：**

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s04-01-S04_1_00_13_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s04-02-S04_2_00_14_59.jpg)


**参数、节点和风险点：**

- `Mesh`
- `more`
- `needle`
- `already`
- `shape`

### 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（5）

**内容要点：**

- 准备枝条参考，拆分主枝、侧枝、针叶簇和枝尖轮廓，先定义一组可重复拼装的枝条模块（5）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s05-01-S05_1_00_17_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s05-02-S05_2_00_18_38.jpg)


**参数、节点和风险点：**

- `Transform`
- `Material`
- `topology`
- `means`
- `straight`
- `perfectly`

### 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向

**内容要点：**

- 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s06-01-S06_1_00_20_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s06-02-S06_2_00_22_42.jpg)


**参数、节点和风险点：**

- `Transform`
- `Point`
- `mode`
- `plus`
- `apply`

### 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（2）

**内容要点：**

- 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s07-01-S07_1_00_25_19.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s07-02-S07_2_00_27_35.jpg)


**参数、节点和风险点：**

- `Transform`
- `Material`
- `Shift`
- `move`
- `some`
- `rotate`
- `already`
- `more`
- `eight`

### 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（3）

**内容要点：**

- 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s08-01-S08_1_00_30_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s08-02-S08_2_00_32_29.jpg)


**参数、节点和风险点：**

- `plus`
- `more`
- `wanna`
- `branch`
- `scale`
- `needle`
- `rotate`

### 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（4）

**内容要点：**

- 在 DCC 中创建枝条几何或卡片结构，控制枝条长度、弯曲、分叉角度和针叶朝向（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s09-01-S09_1_00_35_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s09-02-S09_2_00_36_34.jpg)


**参数、节点和风险点：**

- `branch`
- `small`
- `chunk`
- `case`
- `fine`
- `shift`
- `perfectly`
- `select`
- `size`

### 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强

**内容要点：**

- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s10-01-S10_1_00_38_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s10-02-S10_2_00_40_37.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Point`
- `branch`
- `copy`
- `perfectly`
- `everything`
- `sure`
- `origin`

### 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（2）

**内容要点：**

- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s11-01-S11_1_00_43_15.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s11-02-S11_2_00_45_12.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `Control`
- `material`
- `branch`
- `bend`
- `inside`
- `mode`
- `chunk`

### 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（3）

**内容要点：**

- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s12-01-S12_1_00_47_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s12-02-S12_2_00_49_42.jpg)


**参数、节点和风险点：**

- `copy`
- `twist`
- `medium`
- `deform`
- `apply`
- `bend`
- `small`
- `same`

### 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（4）

**内容要点：**

- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s13-01-S13_1_00_52_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s13-02-S13_2_00_54_27.jpg)


**参数、节点和风险点：**

- `Material`
- `they`
- `copy`
- `first`
- `mirror`

### 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（5）

**内容要点：**

- 为枝条建立 UV，给透明/针叶纹理留出足够空间，并避免同一枝条模块重复感太强（5）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s14-01-S14_1_00_57_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s14-02-S14_2_00_59_19.jpg)


**参数、节点和风险点：**

- `Shift`
- `rotate`
- `more`
- `smaller`
- `narrow`
- `better`

### 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度

**内容要点：**

- 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s15-01-S15_1_01_02_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s15-02-S15_2_01_04_18.jpg)


**参数、节点和风险点：**

- `them`
- `always`
- `chunk`
- `crazy`

### 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（2）

**内容要点：**

- 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s16-01-S16_1_01_06_57.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s16-02-S16_2_01_08_20.jpg)


**参数、节点和风险点：**

- `chunks`
- `everything`
- `needles`
- `main`
- `chunk`
- `even`

### 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（3）

**内容要点：**

- 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s17-01-S17_1_01_10_05.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s17-02-S17_2_01_11_56.jpg)


**参数、节点和风险点：**

- `Material`
- `chunk`
- `origin`
- `plus`
- `more`
- `branches`
- `select`

### 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（4）

**内容要点：**

- 用多个枝条变体填充树冠，检查空洞、剪影和视角切换时的厚度（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s18-01-S18_1_01_14_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s18-02-S18_2_01_16_12.jpg)


**参数、节点和风险点：**

- `rotate`
- `realign`
- `down`
- `shift`
- `more`

### 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别

**内容要点：**

- 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s19-01-S19_1_01_18_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s19-02-S19_2_01_20_51.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Material`
- `chunk`
- `rotate`

### 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（2）

**内容要点：**

- 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s20-01-S20_1_01_23_28.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s20-02-S20_2_01_25_42.jpg)


**参数、节点和风险点：**

- `Transform`
- `Attribute`
- `they`
- `needle`
- `select`
- `unwrap`
- `didn`
- `chunk`
- `perfectly`

### 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（3）

**内容要点：**

- 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s21-01-S21_1_01_28_17.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s21-02-S21_2_01_30_33.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `chunk`
- `sure`
- `pack`
- `would`
- `select`
- `next`
- `them`
- `they`

### 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（4）

**内容要点：**

- 导出前检查 pivot、比例、法线和命名，保证后续 Substance Painter 与 UE5 能稳定识别（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p03/s22-01-S22_1_01_33_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p03/s22-02-S22_2_01_34_04.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Transform`
- `Loop`
- `origin`
- `important`
- `next`
- `textures`
- `object`
- `selected`

## 复现检查清单

- 枝条资产的自然度主要来自变体数量、剪影和针叶密度，不能只看单根枝条的局部细节。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


# 2-4 - Add Layer Functions

# 2-4 - Add Layer Functions

## 知识目标

- 本文整理“2-4 - Add Layer Functions”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息。
- 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致。
- 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换。
- 在 Landscape 上测试层混合、法线叠加和参数继承是否正确。

## 关键术语

- `Point`
- `Attribute`
- `Component`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `channel`
- `albedo`
- `normal`
- `specular`
- `intensity`
- `function`
- `Fresnel`

## 操作步骤与要点

### 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息

**内容要点：**

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s01-02-S01_2_00_01_41.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `input`
- `function`
- `material`
- `albedo`
- `normal`
- `distance`
- `near`
- `logic`

### 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（2）

**内容要点：**

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s02-01-S02_1_00_03_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s02-02-S02_2_00_05_47.jpg)


**参数、节点和风险点：**

- `Material`
- `albedo`
- `call`
- `texture`
- `more`
- `control`
- `function`
- `input`
- `scalar`
- `value`

### 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（3）

**内容要点：**

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s03-01-S03_1_00_08_22.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s03-02-S03_2_00_10_21.jpg)


**参数、节点和风险点：**

- `Material`
- `albedo`
- `contrast`
- `function`
- `brightness`
- `tint`
- `node`
- `saturation`
- `material`
- `would`

### 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（4）

**内容要点：**

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s04-01-S04_1_00_12_40.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s04-02-S04_2_00_14_56.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Material`
- `Landscape`
- `material`
- `distance`
- `albedo`
- `blend`
- `channel`
- `color`
- `hook`

### 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（5）

**内容要点：**

- 将单层纹理函数封装为 Landscape Layer 可用的结构，包含颜色、法线、粗糙度和高度信息（5）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s05-01-S05_1_00_17_32.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s05-02-S05_2_00_19_10.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Material`
- `Instance`
- `Landscape`
- `material`
- `landscape`
- `black`
- `know`
- `work`
- `tint`

### 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致

**内容要点：**

- 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s06-01-S06_1_00_21_08.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s06-02-S06_2_00_23_24.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `working`
- `blend`
- `call`
- `distance`
- `about`
- `specular`
- `alpha`

### 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（2）

**内容要点：**

- 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s07-01-S07_1_00_26_00.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s07-02-S07_2_00_28_18.jpg)


**参数、节点和风险点：**

- `Component`
- `Mask`
- `Material`
- `Fresnel`
- `specular`
- `Albedo`
- `channel`
- `function`
- `value`
- `input`

### 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（3）

**内容要点：**

- 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s08-01-S08_1_00_30_56.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s08-02-S08_2_00_33_15.jpg)


**参数、节点和风险点：**

- `Point`
- `Attribute`
- `Material`
- `Landscape`
- `specular`
- `Fresnel`
- `intensity`
- `material`
- `channel`

### 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（4）

**内容要点：**

- 为多层地表建立统一的 Layer Blend 输入，确保每层参数命名一致（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s09-01-S09_1_00_35_54.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s09-02-S09_2_00_37_19.jpg)


**参数、节点和风险点：**

- `Point`
- `Material`
- `Instance`
- `specular`
- `Fresnel`
- `intensity`
- `zero`
- `material`
- `instance`
- `three`

### 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换

**内容要点：**

- 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s10-01-S10_1_00_39_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s10-02-S10_2_00_41_23.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Component`
- `Mask`
- `Material`
- `Landscape`
- `roughness`
- `inside`
- `final`
- `distance`
- `material`

### 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（2）

**内容要点：**

- 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s11-01-S11_1_00_44_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s11-02-S11_2_00_46_08.jpg)


**参数、节点和风险点：**

- `Point`
- `Component`
- `Mask`
- `Material`
- `Instance`
- `intensity`
- `roughness`
- `normal`
- `zero`
- `specular`

### 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（3）

**内容要点：**

- 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s12-01-S12_1_00_48_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s12-02-S12_2_00_50_53.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Component`
- `Mask`
- `Material`
- `Landscape`
- `normal`
- `intensity`
- `channel`
- `after`
- `value`

### 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（4）

**内容要点：**

- 配置材质实例中的层参数，方便泥土、岩石、草地等地表快速替换（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s13-01-S13_1_00_53_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s13-02-S13_2_00_54_56.jpg)


**参数、节点和风险点：**

- `Point`
- `Material`
- `Instance`
- `Landscape`
- `normal`
- `landscape`
- `material`
- `texture`
- `change`
- `black`

### 在 Landscape 上测试层混合、法线叠加和参数继承是否正确

**内容要点：**

- 在 Landscape 上测试层混合、法线叠加和参数继承是否正确。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s14-01-S14_1_00_56_42.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s14-02-S14_2_00_58_54.jpg)


**参数、节点和风险点：**

- `Point`
- `Attribute`
- `Mask`
- `Material`
- `ambient`
- `occlusion`
- `gray`
- `black`
- `scale`
- `middle`

### 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（2）

**内容要点：**

- 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s15-01-S15_1_01_01_26.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s15-02-S15_2_01_03_03.jpg)


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `ambient`
- `channel`
- `black`
- `albedo`
- `occlusion`
- `call`
- `middle`

### 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（3）

**内容要点：**

- 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s16-01-S16_1_01_05_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s16-02-S16_2_01_06_38.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `intensity`
- `normal`
- `inside`
- `albedo`
- `eleven`
- `Roughness`
- `space`
- `displacement`

### 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（4）

**内容要点：**

- 在 Landscape 上测试层混合、法线叠加和参数继承是否正确（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p12/s17-01-S17_1_01_08_34.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p12/s17-02-S17_2_01_09_25.jpg)


**参数、节点和风险点：**

- `Material`
- `Albedo`
- `Apply`
- `everything`
- `brightness`
- `nine`
- `eight`
- `tint`
- `save`

## 复现检查清单

- Layer 函数是 Landscape 材质的核心，通道、参数组和默认值必须保持一致。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


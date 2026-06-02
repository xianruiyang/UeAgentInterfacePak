# 2-9 - Height Blend Function

# 2-9 - Height Blend Function

## 知识目标

- 本文整理“2-9 - Height Blend Function”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建 Height Blend 材质函数，用高度图控制不同地表层的过渡顺序。
- 把高度强度、对比度和混合宽度暴露为参数，避免层边缘糊成一片。
- 在 Landscape 材质中替换普通权重混合，观察岩石/泥土/草地交界变化。
- 调试高度图通道和数值范围，让纹理细节自然参与边界过渡。

## 关键术语

- `Component`
- `Mask`
- `Material`
- `Landscape`
- `height`
- `material`
- `blend`
- `displacement`
- `texture`
- `layers`
- `layer`
- `function`
- `channel`

## 操作步骤与要点

### 创建 Height Blend 材质函数，用高度图控制不同地表层的过渡顺序

**内容要点：**

- 创建 Height Blend 材质函数，用高度图控制不同地表层的过渡顺序。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p17/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p17/s01-02-S01_2_00_02_23.jpg)


**参数、节点和风险点：**

- `Component`
- `Mask`
- `Material`
- `height`
- `channel`
- `displacement`
- `texture`
- `blend`
- `output`

### 把高度强度、对比度和混合宽度暴露为参数，避免层边缘糊成一片

**内容要点：**

- 把高度强度、对比度和混合宽度暴露为参数，避免层边缘糊成一片。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p17/s02-01-S02_1_00_04_57.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p17/s02-02-S02_2_00_06_23.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `material`
- `layer`
- `layers`
- `height`
- `blend`
- `function`
- `four`
- `remember`

### 在 Landscape 材质中替换普通权重混合，观察岩石/泥土/草地交界变化

**内容要点：**

- 在 Landscape 材质中替换普通权重混合，观察岩石/泥土/草地交界变化。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p17/s03-01-S03_1_00_08_09.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p17/s03-02-S03_2_00_09_03.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `default`
- `brush`
- `roughness`
- `texture`
- `displacement`
- `change`
- `paint`
- `blend`

## 复现检查清单

- 高度混合容易产生过硬边缘或黑边，需要逐层检查高度图值域。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


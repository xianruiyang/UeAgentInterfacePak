# 3-2 - Texturing Spline Mesh in Substance Painter

# 3-2 - Texturing Spline Mesh in Substance Painter

## 知识目标

- 本文整理“3-2 - Texturing Spline Mesh in Substance Painter”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开。
- 制作表面颜色、粗糙度、法线、边缘磨损和高度信息。
- 导出与 UE5 材质函数匹配的贴图，必要时做通道打包。
- 用预览材质检查贴图在重复铺设时是否会产生明显接缝。

## 关键术语

- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Mask`
- `Material`
- `Landscape`
- `color`
- `more`
- `occlusion`
- `ambient`
- `texture`

## 操作步骤与要点

### 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开

**内容要点：**

- 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s01-01-S01_1_00_00_17.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s01-02-S01_2_00_02_34.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Material`
- `base`
- `texture`
- `normal`
- `sand`
- `some`
- `mesh`
- `color`

### 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开（2）

**内容要点：**

- 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s02-01-S02_1_00_05_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s02-02-S02_2_00_07_27.jpg)


**参数、节点和风险点：**

- `Actor`
- `color`
- `more`
- `better`
- `much`
- `shadow`

### 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开（3）

**内容要点：**

- 把样条 Mesh 导入 Substance Painter，确认 UV 能沿道路或溪流方向连续展开（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s03-01-S03_1_00_10_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s03-02-S03_2_00_11_25.jpg)


**参数、节点和风险点：**

- `Mesh`
- `occlusion`
- `texture`
- `ambient`
- `color`
- `nice`
- `course`
- `disable`
- `roughness`

### 制作表面颜色、粗糙度、法线、边缘磨损和高度信息

**内容要点：**

- 制作表面颜色、粗糙度、法线、边缘磨损和高度信息。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s04-01-S04_1_00_13_06.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s04-02-S04_2_00_14_49.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Mask`
- `ambient`
- `occlusion`
- `color`
- `invert`
- `getting`
- `information`
- `generator`

### 制作表面颜色、粗糙度、法线、边缘磨损和高度信息（2）

**内容要点：**

- 制作表面颜色、粗糙度、法线、边缘磨损和高度信息（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s05-01-S05_1_00_16_52.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s05-02-S05_2_00_19_07.jpg)


**参数、节点和风险点：**

- `Mask`
- `more`
- `paint`
- `much`
- `aggressive`
- `color`

### 导出与 UE5 材质函数匹配的贴图，必要时做通道打包

**内容要点：**

- 导出与 UE5 材质函数匹配的贴图，必要时做通道打包。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s06-01-S06_1_00_21_43.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s06-02-S06_2_00_24_00.jpg)


**参数、节点和风险点：**

- `Point`
- `paint`
- `island`
- `honest`
- `think`
- `only`
- `still`

### 导出与 UE5 材质函数匹配的贴图，必要时做通道打包（2）

**内容要点：**

- 导出与 UE5 材质函数匹配的贴图，必要时做通道打包（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s07-01-S07_1_00_26_37.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s07-02-S07_2_00_28_45.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Mask`
- `paint`
- `brush`
- `color`
- `more`
- `black`

### 导出与 UE5 材质函数匹配的贴图，必要时做通道打包（3）

**内容要点：**

- 导出与 UE5 材质函数匹配的贴图，必要时做通道打包（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s08-01-S08_1_00_31_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s08-02-S08_2_00_32_58.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Mask`
- `normal`
- `green`
- `channel`
- `color`
- `flip`
- `only`

### 用预览材质检查贴图在重复铺设时是否会产生明显接缝

**内容要点：**

- 用预览材质检查贴图在重复铺设时是否会产生明显接缝。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s09-01-S09_1_00_35_02.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s09-02-S09_2_00_37_17.jpg)


**参数、节点和风险点：**

- `Mask`
- `clouds`
- `more`
- `some`
- `multiply`
- `color`
- `fill`
- `stone`

### 用预览材质检查贴图在重复铺设时是否会产生明显接缝（2）

**内容要点：**

- 用预览材质检查贴图在重复铺设时是否会产生明显接缝（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p25/s10-01-S10_1_00_39_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p25/s10-02-S10_2_00_40_50.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Mask`
- `Material`
- `Landscape`
- `nice`
- `save`
- `export`
- `texture`
- `episode`

## 复现检查清单

- 样条 Mesh 的纹理方向必须与 UE5 Spline 前向方向一致。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


# 3-1 - Create the Displaced Spline Mesh

# 3-1 - Create the Displaced Spline Mesh

## 知识目标

- 本文整理“3-1 - Create the Displaced Spline Mesh”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移。
- 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形。
- 为后续材质准备高度、边缘遮罩或顶点颜色数据。
- 导出前检查法线、切线、分段密度和命名。

## 关键术语

- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Density`
- `Loop`
- `Mask`
- `Material`
- `Landscape`
- `mask`
- `more`
- `spline`
- `displacement`

## 操作步骤与要点

### 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移

**内容要点：**

- 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s01-01-S01_1_00_00_14.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s01-02-S01_2_00_02_29.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Transform`
- `Loop`
- `Mask`
- `Material`
- `Landscape`
- `plane`
- `spline`
- `good`

### 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移（2）

**内容要点：**

- 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s02-01-S02_1_00_05_04.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s02-02-S02_2_00_07_08.jpg)


**参数、节点和风险点：**

- `Mask`
- `Material`
- `mask`
- `black`
- `color`
- `invert`
- `paint`

### 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移（3）

**内容要点：**

- 创建可沿样条铺设的道路/溪流/地表 Mesh，并加入足够分段支持位移（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s03-01-S03_1_00_09_31.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s03-02-S03_2_00_11_51.jpg)


**参数、节点和风险点：**

- `Mask`
- `more`
- `paint`
- `some`
- `variation`
- `layer`

### 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形

**内容要点：**

- 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s04-01-S04_1_00_14_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s04-02-S04_2_00_16_50.jpg)


**参数、节点和风险点：**

- `Mask`
- `tire`
- `more`
- `paint`
- `blur`
- `tracks`
- `some`

### 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形（2）

**内容要点：**

- 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s05-01-S05_1_00_19_30.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s05-02-S05_2_00_21_34.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Mask`
- `Landscape`
- `mask`
- `white`
- `sure`
- `completely`
- `edges`
- `black`

### 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形（3）

**内容要点：**

- 设置 UV、宽度、边缘和 pivot，使 Mesh 能稳定跟随 UE5 Spline 变形（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s06-01-S06_1_00_24_02.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s06-02-S06_2_00_26_01.jpg)


**参数、节点和风险点：**

- `Spline`
- `Mask`
- `black`
- `white`
- `mask`
- `some`
- `nice`
- `good`

### 为后续材质准备高度、边缘遮罩或顶点颜色数据

**内容要点：**

- 为后续材质准备高度、边缘遮罩或顶点颜色数据。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s07-01-S07_1_00_28_24.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s07-02-S07_2_00_30_20.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Transform`
- `Mask`
- `spline`
- `mask`
- `displacement`
- `GIMP`
- `case`

### 为后续材质准备高度、边缘遮罩或顶点颜色数据（2）

**内容要点：**

- 为后续材质准备高度、边缘遮罩或顶点颜色数据（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s08-01-S08_1_00_32_36.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s08-02-S08_2_00_34_51.jpg)


**参数、节点和风险点：**

- `Spline`
- `Mask`
- `displacement`
- `fine`
- `layer`
- `perfectly`
- `everything`

### 为后续材质准备高度、边缘遮罩或顶点颜色数据（3）

**内容要点：**

- 为后续材质准备高度、边缘遮罩或顶点颜色数据（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s09-01-S09_1_00_37_27.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s09-02-S09_2_00_39_46.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Mask`
- `Material`
- `mesh`
- `file`
- `export`
- `spline`

### 导出前检查法线、切线、分段密度和命名

**内容要点：**

- 导出前检查法线、切线、分段密度和命名。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s10-01-S10_1_00_42_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s10-02-S10_2_00_44_43.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Mask`
- `some`
- `paint`
- `displacement`
- `blur`
- `plane`

### 导出前检查法线、切线、分段密度和命名（2）

**内容要点：**

- 导出前检查法线、切线、分段密度和命名（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p24/s11-01-S11_1_00_47_23.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p24/s11-02-S11_2_00_49_32.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Density`
- `Mask`
- `Landscape`
- `tileable`
- `plane`
- `spline`

## 复现检查清单

- Spline Mesh 的分段、pivot 和前向轴错误会直接导致 UE5 中扭曲或翻转。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


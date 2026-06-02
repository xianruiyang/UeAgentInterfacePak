# 5-6 - Create a Cinematic with the Movie Render Queue

# 5-6 - Create a Cinematic with the Movie Render Queue

## 知识目标

- 本文整理“5-6 - Create a Cinematic with the Movie Render Queue”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深。
- 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置。
- 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性。

## 关键术语

- `PCG`
- `Blueprint`
- `Mesh`
- `Spline`
- `Transform`
- `Actor`
- `Random`
- `Mask`
- `Material`
- `Instance`
- `Landscape`
- `camera`

## 操作步骤与要点

### 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深

**内容要点：**

- 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s01-02-S01_2_00_02_24.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Spline`
- `Actor`
- `Mask`
- `Material`
- `Landscape`
- `course`
- `nice`
- `water`

### 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（2）

**内容要点：**

- 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s02-01-S02_1_00_05_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s02-02-S02_2_00_07_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `Material`
- `camera`
- `everything`
- `same`
- `cine`
- `actor`
- `about`

### 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（3）

**内容要点：**

- 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s03-01-S03_1_00_09_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s03-02-S03_2_00_11_25.jpg)


**参数、节点和风险点：**

- `Actor`
- `Mask`
- `Material`
- `Instance`
- `fake`
- `plane`
- `texture`
- `planes`
- `material`

### 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（4）

**内容要点：**

- 创建 cinematic 镜头，规划森林路径环境中的构图、运动和景深（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s04-01-S04_1_00_13_25.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s04-02-S04_2_00_15_01.jpg)


**参数、节点和风险点：**

- `Actor`
- `Random`
- `CineCameraActor`
- `change`
- `fake`
- `planes`
- `crop`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s05-01-S05_1_00_17_01.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s05-02-S05_2_00_19_17.jpg)


**参数、节点和风险点：**

- `focus`
- `always`
- `change`
- `DaVinci`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s06-01-S06_1_00_21_56.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s06-02-S06_2_00_23_13.jpg)


**参数、节点和风险点：**

- `Transform`
- `Actor`
- `always`
- `frames`
- `light`
- `everything`
- `more`
- `they`
- `down`
- `focus`

### **内容要点：**

- **内容要点：**（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s07-01-S07_1_00_24_53.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s07-02-S07_2_00_26_51.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Mesh`
- `Transform`
- `Random`
- `fork`
- `distance`
- `fields`
- `transform`
- `height`
- `texture`

### **内容要点：**

- **内容要点：**（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s08-01-S08_1_00_29_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s08-02-S08_2_00_31_19.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Transform`
- `Actor`
- `Random`
- `camera`
- `shake`
- `noise`
- `Perlin`
- `feel`
- `means`

### 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置

**内容要点：**

- 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s09-01-S09_1_00_33_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s09-02-S09_2_00_35_07.jpg)


**参数、节点和风险点：**

- `rotation`
- `down`
- `believe`
- `honest`
- `pitch`
- `rotating`
- `multiplier`
- `much`
- `doing`

### 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（2）

**内容要点：**

- 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s10-01-S10_1_00_36_47.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s10-02-S10_2_00_38_07.jpg)


**参数、节点和风险点：**

- `think`
- `more`
- `three`
- `rotation`

### 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（3）

**内容要点：**

- 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s11-01-S11_1_00_39_50.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s11-02-S11_2_00_41_21.jpg)


**参数、节点和风险点：**

- `Transform`
- `change`
- `fork`
- `exponential`
- `height`
- `focus`
- `last`
- `position`
- `ultra`

### 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（4）

**内容要点：**

- 配置 Movie Render Queue，选择分辨率、抗锯齿、输出格式和必要的渲染设置（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s12-01-S12_1_00_43_12.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s12-02-S12_2_00_44_32.jpg)


**参数、节点和风险点：**

- `Transform`
- `transform`
- `play`
- `animation`
- `inside`
- `better`
- `crow`

### 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性

**内容要点：**

- 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s13-01-S13_1_00_46_15.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s13-02-S13_2_00_48_06.jpg)


**参数、节点和风险点：**

- `Transform`
- `animation`
- `flapping`
- `root`
- `copy`
- `being`
- `flying`
- `motion`
- `well`

### 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（2）

**内容要点：**

- 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（2）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s14-01-S14_1_00_50_21.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s14-02-S14_2_00_51_49.jpg)


**参数、节点和风险点：**

- `Transform`
- `transform`
- `last`
- `check`
- `frame`
- `Frame`
- `slower`

### 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（3）

**内容要点：**

- 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（3）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s15-01-S15_1_00_53_40.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s15-02-S15_2_00_55_46.jpg)


**参数、节点和风险点：**

- `Actor`
- `stand`
- `animation`
- `zero`
- `correct`
- `sure`
- `again`
- `being`
- `played`

### 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（4）

**内容要点：**

- 渲染前检查材质、风动画、PCG 实例、透明草和水体在镜头中的稳定性（4）。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p37/s16-01-S16_1_00_58_16.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p37/s16-02-S16_2_00_58_34.jpg)


**参数、节点和风险点：**

- `they`
- `save`
- `camera`
- `nice`
- `close`
- `together`
- `believe`
- `fine`
- `sequencer`

## 复现检查清单

- 电影输出要按最终镜头检查，不要只看编辑器实时视口。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


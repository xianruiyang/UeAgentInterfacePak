# 14-高级PCG：使用语法进行结构化程序生成

# 14-高级PCG：使用语法进行结构化程序生成

## 知识目标

- 本文整理“14-高级PCG：使用语法进行结构化程序生成”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。
- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数。
- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Random`
- `Seed`
- `Graph`
- `Material`

## 操作步骤与要点

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s01-02-S01_2_00_02_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Component`
- `样条`
- `网格`
- `属性`
- `程序化`
- `生成`
- `ProceduralTrain`
- `tutorial`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s02-01-S02_1_00_04_40.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s02-02-S02_2_00_06_50.jpg)


**参数、节点和风险点：**

- `Graph`
- `样条`
- `网格`
- `属性`
- `过滤`
- `节点`
- `生成`
- `Regen`
- `City`
- `SubwayTrainModular`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（3）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s03-01-S03_1_00_09_21.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s03-02-S03_2_00_11_38.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Graph`
- `样条`
- `网格`
- `实例`
- `属性`
- `过滤`
- `节点`
- `生成`
- `created`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（4）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（4）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s04-01-S04_1_00_14_16.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s04-02-S04_2_00_16_31.jpg)


**参数、节点和风险点：**

- `PCG`
- `Component`
- `样条`
- `网格`
- `属性`
- `参数`
- `节点`
- `生成`
- `CitySubwayTrainModular`
- `ProceduralTrain`

### 节点、参数和生成结果校验 05

**内容要点：**

- 节点、参数和生成结果校验 05。


**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s05-01-S05_1_00_19_05.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s05-02-S05_2_00_21_18.jpg)


**参数、节点和风险点：**

- `Component`
- `样条`
- `CitySubwayTrainModular`
- `ProceduralTrain`
- `Selection`
- `Mode`
- `Platforms`
- `JaysongShao`
- `Asset`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s06-01-S06_1_00_23_51.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s06-02-S06_2_00_26_01.jpg)


**参数、节点和风险点：**

- `Component`
- `Graph`
- `样条`
- `属性`
- `过滤`
- `采样`
- `节点`
- `Regen`
- `City`
- `SubwayTrainModular`

### **内容要点：**

- **内容要点：**（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s07-01-S07_1_00_28_31.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s07-02-S07_2_00_30_45.jpg)


**参数、节点和风险点：**

- `Component`
- `样条`
- `属性`
- `采样`
- `节点`
- `Regen`
- `City`
- `SubwayTrainModular`
- `ProceduralTrain`
- `bilibii`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s08-01-S08_1_00_33_21.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s08-02-S08_2_00_35_31.jpg)


**参数、节点和风险点：**

- `PCG`
- `Component`
- `Graph`
- `样条`
- `网格`
- `属性`
- `生成`
- `Regen`
- `City`
- `SubwayTrainModular`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（2）

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s09-01-S09_1_00_38_01.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s09-02-S09_2_00_40_09.jpg)


**参数、节点和风险点：**

- `Transform`
- `Point`
- `Graph`
- `属性`
- `节点`
- `生成`
- `points`
- `Regen`
- `CitySubway`
- `TrainModular`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（3）

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s10-01-S10_1_00_42_40.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s10-02-S10_2_00_44_48.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `样条`
- `网格`
- `参数`
- `节点`
- `ProceduralTrain`
- `Interior`
- `Wall`
- `CitySubwayTrainModular`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（4）

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（4）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s11-01-S11_1_00_47_15.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s11-02-S11_2_00_49_29.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `样条`
- `网格`
- `属性`
- `过滤`
- `节点`
- `生成`
- `ProceduralTrain`

### 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置

**内容要点：**

- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s12-01-S12_1_00_52_02.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s12-02-S12_2_00_54_12.jpg)


**参数、节点和风险点：**

- `PCG`
- `样条`
- `网格`
- `属性`
- `节点`
- `生成`
- `建筑`
- `Regen`
- `CitySubwayTrainModular`
- `ProceduralTrain`

### 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（2）

**内容要点：**

- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s13-01-S13_1_00_56_44.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s13-02-S13_2_00_58_50.jpg)


**参数、节点和风险点：**

- `Component`
- `网格`
- `属性`
- `过滤`
- `建筑`
- `ProceduralTrain`
- `helps`
- `understand`
- `setups`

### 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（3）

**内容要点：**

- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p14/s14-01-S14_1_01_01_18.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p14/s14-02-S14_2_01_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `Component`
- `ProceduralTrain`
- `City`
- `SubwayTrainModular`
- `Selection`
- `Mode`

## 复现检查清单

- 每个示例都要先确认输入点、Bounds、属性和 Debug 结果，再判断生成节点是否有问题。
- 涉及运行时、分区、HLSL 或 Geometry Script 的内容，要记录 UE 版本、插件和执行环境限制。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


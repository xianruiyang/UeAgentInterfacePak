# 16-PCG中的HLSL解析｜虚幻引擎过程生成

# 16-PCG中的HLSL解析｜虚幻引擎过程生成

## 知识目标

- 本文整理“16-PCG中的HLSL解析｜虚幻引擎过程生成”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。
- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数。
- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置。

## 关键术语

- `PCG`
- `Static Mesh`
- `Mesh`
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
- `Instance`
- `Landscape`

## 操作步骤与要点

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s01-01-S01_1_00_00_12.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s01-02-S01_2_00_02_25.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `体积`
- `过滤`
- `密度`
- `节点`
- `生成`
- `graph`
- `PCGSeries`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s02-01-S02_1_00_04_59.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s02-02-S02_2_00_06_32.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `节点`
- `生成`
- `Regen`
- `Source`
- `Shader`
- `PCGSeries`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（3）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s03-01-S03_1_00_08_29.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s03-02-S03_2_00_10_44.jpg)


**参数、节点和风险点：**

- `PCG`
- `节点`
- `生成`
- `PCGSeries`
- `Selection`
- `Mode`
- `Platforms`
- `JaysongShao`
- `ltemLabel`

### 节点、参数和生成结果校验 04

**内容要点：**

- 节点、参数和生成结果校验 04。


**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s04-01-S04_1_00_13_21.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s04-02-S04_2_00_15_40.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Graph`
- `属性`
- `节点`
- `生成`
- `Regen`
- `points`
- `position`
- `PCGSeries`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s05-01-S05_1_00_18_20.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s05-02-S05_2_00_20_33.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `体积`
- `节点`
- `生成`
- `PCGSeries`
- `Selection`
- `Mode`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s06-01-S06_1_00_23_05.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s06-02-S06_2_00_25_19.jpg)


**参数、节点和风险点：**

- `PCG`
- `Landscape`
- `网格`
- `属性`
- `过滤`
- `密度`
- `节点`
- `生成`
- `Editor`
- `Type`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（2）

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s07-01-S07_1_00_27_53.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s07-02-S07_2_00_30_07.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Graph`
- `网格`
- `过滤`
- `密度`
- `程序化`
- `生成`
- `float4`
- `Regen`

### 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（3）

**内容要点：**

- 重点整理 Spawner 的输入点、资源选择、实例化设置、碰撞、随机变换和性能相关参数（3）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s08-01-S08_1_00_32_41.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s08-02-S08_2_00_34_57.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `体积`
- `节点`
- `程序化`
- `生成`
- `Regen`
- `PCGSeries`

### 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置

**内容要点：**

- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s09-01-S09_1_00_37_33.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s09-02-S09_2_00_39_47.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `密度`
- `生成`
- `PCGSeries`
- `Silibili`
- `Selection`
- `Mode`
- `Platforms`

### 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（2）

**内容要点：**

- 生成前先用 Debug 点确认输入，再逐步开启 Mesh/Actor 生成，便于定位问题发生在点逻辑还是生成器设置（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p16/s10-01-S10_1_00_42_19.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p16/s10-02-S10_2_00_42_33.jpg)


**参数、节点和风险点：**

- `PCG`
- `生成`
- `Worid`
- `PCGSeries`
- `Selection`
- `Mode`
- `Jaysongshao`
- `Shift`
- `Mouse`

## 复现检查清单

- 每个示例都要先确认输入点、Bounds、属性和 Debug 结果，再判断生成节点是否有问题。
- 涉及运行时、分区、HLSL 或 Geometry Script 的内容，要记录 UE 版本、插件和执行环境限制。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


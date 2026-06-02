# 12-PCG+世界分区

# 12-PCG+世界分区

## 知识目标

- 本文整理“12-PCG+世界分区”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。
- 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续。
- 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题。

## 关键术语

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Grid`
- `Bounds`
- `Density`
- `Random`
- `Seed`
- `Graph`
- `Material`
- `Instance`
- `Landscape`
- `网格`

## 操作步骤与要点

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s01-02-S01_2_00_02_20.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Grid`
- `PCGPartitionGridActor_25600_3_`
- `world`
- `PCGSeries`
- `Selection`
- `Mode`
- `Platforms`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s02-01-S02_1_00_04_49.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s02-02-S02_2_00_07_05.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Landscape`
- `网格`
- `实例`
- `节点`
- `生成`
- `world`
- `PCGSeries`
- `bilibii`

### 节点、参数和生成结果校验 03

**内容要点：**

- 节点、参数和生成结果校验 03。


**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s03-01-S03_1_00_09_41.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s03-02-S03_2_00_11_57.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `体积`
- `节点`
- `生成`
- `Mode`
- `PCGSeries`
- `Selection`
- `Platforms`

### 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续

**内容要点：**

- 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s04-01-S04_1_00_14_32.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s04-02-S04_2_00_16_51.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Graph`
- `网格`
- `体积`
- `过滤`
- `节点`
- `生成`
- `PCGSeries`

### 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续（2）

**内容要点：**

- 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s05-01-S05_1_00_19_31.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s05-02-S05_2_00_21_50.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `网格`
- `采样`
- `节点`
- `生成`
- `建筑`
- `柱子`
- `PCGSeries`
- `Selection`

### 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题

**内容要点：**

- 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p12/s06-01-S06_1_00_24_27.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p12/s06-02-S06_2_00_24_39.jpg)


**参数、节点和风险点：**

- `PCG`
- `生成`
- `PCGSeries`
- `Selection`
- `Mode`
- `Platforms`
- `JaysongShao`
- `xins`
- `itemLabel`

## 复现检查清单

- 每个示例都要先确认输入点、Bounds、属性和 Debug 结果，再判断生成节点是否有问题。
- 涉及运行时、分区、HLSL 或 Geometry Script 的内容，要记录 UE 版本、插件和执行环境限制。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


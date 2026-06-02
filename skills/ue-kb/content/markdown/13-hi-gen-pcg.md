# 13-Hi-Gen分区：大规模PCG工作流

# 13-Hi-Gen分区：大规模PCG工作流

## 知识目标

- 本文整理“13-Hi-Gen分区：大规模PCG工作流”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。
- 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续。
- 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题。

## 关键术语

- `PCG`
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
- `Instance`

## 操作步骤与要点

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s01-01-S01_1_00_00_17.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s01-02-S01_2_00_02_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Grid`
- `网格`
- `体积`
- `节点`
- `生成`
- `PCGPartionGridActor_1600_9_`
- `position`
- `every`

### 节点、参数和生成结果校验 02

**内容要点：**

- 节点、参数和生成结果校验 02。


**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s02-01-S02_1_00_05_03.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s02-02-S02_2_00_07_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Grid`
- `网格`
- `体积`
- `节点`
- `生成`
- `PCGParitionGridActor_1600_9_`
- `PCGSeries`

### 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续

**内容要点：**

- 关注 PCG 与 World Partition/Hi-Gen 分区的协作：哪些数据按分区生成，哪些结果需要跨分区保持连续。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s03-01-S03_1_00_09_50.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s03-02-S03_2_00_12_10.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Grid`
- `Graph`
- `网格`
- `体积`
- `节点`
- `生成`
- `Regen`
- `same`

### 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题

**内容要点：**

- 复现时检查分区边界、加载状态、重复生成和跨分区样条/道路断裂问题。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p13/s04-01-S04_1_00_14_49.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p13/s04-02-S04_2_00_16_56.jpg)


**参数、节点和风险点：**

- `PCG`
- `Grid`
- `Graph`
- `网格`
- `采样`
- `生成`
- `Regen`
- `PCGSeries`
- `Selection`

## 复现检查清单

- 每个示例都要先确认输入点、Bounds、属性和 Debug 结果，再判断生成节点是否有问题。
- 涉及运行时、分区、HLSL 或 Geometry Script 的内容，要记录 UE 版本、插件和执行环境限制。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


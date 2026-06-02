# 07-停止硬编码PCG：使用参数与角色数据

# 07-停止硬编码PCG：使用参数与角色数据

## 知识目标

- 本文整理“07-停止硬编码PCG：使用参数与角色数据”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。
- 把硬编码数值迁移为 Graph Parameters、Actor Data 或 Blueprint 暴露参数，让同一图表可被不同 Actor 复用。
- 复现时检查参数默认值、实例覆盖值和运行时更新路径，避免改了蓝图变量但 PCG 图表没有重新读取。

## 关键术语

- `PCG`
- `Blueprint`
- `蓝图`
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

## 操作步骤与要点

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s01-01-S01_1_00_00_11.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s01-02-S01_2_00_02_21.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Actor`
- `Graph`
- `实例`
- `属性`
- `过滤`
- `参数`
- `节点`
- `生成`

### 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）

**内容要点：**

- 先明确本集在 PCG 基础课中的位置：输入数据是什么、点数据如何产生、属性如何流转、最终由哪个生成节点或蓝图消费（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s02-01-S02_1_00_04_50.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s02-02-S02_2_00_07_00.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Graph`
- `Landscape`
- `实例`
- `属性`
- `参数`
- `节点`
- `生成`
- `adding`

### 节点、参数和生成结果校验 03

**内容要点：**

- 节点、参数和生成结果校验 03。


**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s03-01-S03_1_00_09_29.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s03-02-S03_2_00_11_42.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Actor`
- `Graph`
- `网格`
- `节点`
- `生成`
- `Regen`
- `PCGSeries`
- `Selection`

### **内容要点：**

- **内容要点：**（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s04-01-S04_1_00_14_16.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s04-02-S04_2_00_16_34.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Actor`
- `Seed`
- `Graph`
- `材质`
- `属性`
- `参数`
- `节点`

### 把硬编码数值迁移为 Graph Parameters、Actor Data 或 Blueprint 暴露参数，让同一图表可被不同 Actor 复用

**内容要点：**

- 把硬编码数值迁移为 Graph Parameters、Actor Data 或 Blueprint 暴露参数，让同一图表可被不同 Actor 复用。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s05-01-S05_1_00_19_13.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s05-02-S05_2_00_21_27.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Graph`
- `网格`
- `参数`
- `节点`
- `生成`
- `PCGSeries`
- `Asset`

### 把硬编码数值迁移为 Graph Parameters、Actor Data 或 Blueprint 暴露参数，让同一图表可被不同 Actor 复用（2）

**内容要点：**

- 把硬编码数值迁移为 Graph Parameters、Actor Data 或 Blueprint 暴露参数，让同一图表可被不同 Actor 复用（2）。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s06-01-S06_1_00_24_01.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s06-02-S06_2_00_26_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Actor`
- `Graph`
- `实例`
- `属性`
- `参数`
- `节点`
- `生成`
- `actor`

### 复现时检查参数默认值、实例覆盖值和运行时更新路径，避免改了蓝图变量但 PCG 图表没有重新读取

**内容要点：**

- 复现时检查参数默认值、实例覆盖值和运行时更新路径，避免改了蓝图变量但 PCG 图表没有重新读取。

**关键截图：**

![关键截图 1](../assets/ue56-pcg-fundamentals-course-p08/s07-01-S07_1_00_28_49.jpg)
![关键截图 2](../assets/ue56-pcg-fundamentals-course-p08/s07-02-S07_2_00_30_46.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Actor`
- `Graph`
- `实例`
- `属性`
- `过滤`
- `参数`
- `节点`
- `PCGSeries`

## 复现检查清单

- 每个示例都要先确认输入点、Bounds、属性和 Debug 结果，再判断生成节点是否有问题。
- 涉及运行时、分区、HLSL 或 Geometry Script 的内容，要记录 UE 版本、插件和执行环境限制。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


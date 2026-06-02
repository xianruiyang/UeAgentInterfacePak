# 4.7分钟真实森林!程序内容生成PCG在虚幻引擎

# 4.7分钟真实森林!程序内容生成PCG在虚幻引擎

## 知识目标

- 用一个紧凑流程演示森林 PCG：从 Landscape 采样开始，逐层生成地表细节、树木、灌木、石块和树枝。
- 突出密度、Bounds 和 Transform 调整对自然分布的影响。

## 可复现主流程

1. 创建 PCG Graph 和 PCG Volume，让 Landscape 输入进入 Surface Sampler。
2. 打开 Debug 点云，确认采样区域、密度和点大小。
3. 先生成小型地表细节资产，使用 Density Noise + Density Filter 打散分布。
4. 复制分支或新增分支生成树木、灌木、石块、树枝等不同层级资产。
5. 对树木使用 Bounds Modifier，让点范围接近树冠或树干占地，减少重叠。
6. 对石块、树枝等小物件重新检查 Transform Points 的偏移，避免沿用树木分支导致埋入地面。

## 关键术语

- `PCG Graph`
- `PCG Volume`
- `Landscape`
- `Surface Sampler`
- `Density Noise`
- `Density Filter`
- `Static Mesh Spawner`
- `Transform Points`
- `Bounds Modifier`
- `Quixel Bridge`

## 操作步骤与要点

### Landscape 采样与点云调试

- 从 Landscape 采样建立基础点云，先看 Debug 点是否覆盖正确范围。
- 点云正确比一开始选择什么网格更重要。

**内容要点：**

- Landscape 采样与点云调试。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p04/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p04/s01-02-S01_2_00_01_58.jpg)

### 地表细节与自然打散

- 小型地表资产通过 Density Noise / Density Filter 打散，避免规则网格感。
- Quixel 森林地表碎片适合做低层填充。

**内容要点：**

- 地表细节与自然打散。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p04/s02-01-S02_1_00_04_09.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p04/s02-02-S02_2_00_05_25.jpg)

### 树木、灌木和小物件分支

- 树木需要更大的 Bounds，小石块和树枝则要避免继承树木分支的大偏移。
- 同一套采样结果可以分层复用，但每层资产的密度、缩放和偏移应独立调。

**内容要点：**

- 树木、灌木和小物件分支。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p04/s03-01-S03_1_00_07_03.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p04/s03-02-S03_2_00_08_42.jpg)

## 复现检查清单

- 先调点云，再调网格；没有正确点云时不要继续堆资产。
- 树木分支和小物件分支不要共用 Bounds 与 Z 偏移。
- 每一层资产都要单独检查随机缩放、随机旋转和密度过滤。


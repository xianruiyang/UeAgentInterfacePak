# 6.使用 PCG 样条自动创建整个城市！虚幻引擎中的程序内容生成

# 6.使用 PCG 样条自动创建整个城市！虚幻引擎中的程序内容生成

## 知识目标

- 使用样条线定义中世纪小镇的边界和道路，再用 PCG 自动填充建筑与路径资产。
- 展示 spline 如何同时参与区域约束、森林扣除、建筑采样和道路生成。

## 可复现主流程

1. 在 Modeling Mode / Draw Spline 中绘制闭合小镇边界。
2. 在 PCG 中读取边界 spline，用它定义小镇内部区域。
3. 把小镇区域从原有森林/植被生成中 Difference/Subtract 出来，避免建筑和树木重叠。
4. 在小镇内部采样点，使用 Bounds Modifier 和点间距近似建筑占地。
5. 用 Static Mesh Spawner 在内部点生成建筑。
6. 再绘制或读取道路 spline，沿线生成道路、路径或地面网格。
7. 建筑分支和道路分支分开调 Transform、Offset 和随机性，避免道路资产影响建筑朝向。

## 关键术语

- `Modeling Mode`
- `Draw Spline`
- `Closed Spline`
- `Spline Sampler`
- `Interior Sampling`
- `Difference`
- `Subtract`
- `Bounds Modifier`
- `Static Mesh Spawner`
- `Road Spline`
- `Transform Points`

## 操作步骤与要点

### 绘制小镇边界样条

- 闭合 spline 定义小镇范围，是后续建筑采样和森林扣除的边界。
- 样条需要保持闭合和尺度稳定，否则内部采样会出错。

**内容要点：**

- 绘制小镇边界样条。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p06/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p06/s01-02-S01_2_00_01_31.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p06/s01-03-S02_1_00_03_15.jpg)

### 从森林中扣出小镇区域

- PCG 可用 Difference/Subtract 类逻辑把小镇范围从森林点集中移除。
- 这一步解决建筑、道路和树木互相穿插的问题。

**内容要点：**

- 从森林中扣出小镇区域。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p06/s02-01-S02_2_00_05_31.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p06/s02-02-S03_1_00_08_08.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p06/s02-03-S03_2_00_09_22.jpg)

### 建筑点采样与生成

- 建筑采样点要结合 Bounds Modifier 近似占地，不能像草点一样密集。
- Static Mesh Spawner 可以先用少量建筑资产验证朝向和间距，再扩展资源池。

**内容要点：**

- 建筑点采样与生成。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p06/s03-01-S04_1_00_10_59.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p06/s03-02-S04_2_00_12_37.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p06/s03-03-S05_1_00_14_38.jpg)

### 道路样条与地面资产

- 道路 spline 负责线性路径，和闭合边界 spline 是两个不同角色。
- 道路网格通常需要贴地偏移和随机细节，但主线形状应由 spline 控制。

**内容要点：**

- 道路样条与地面资产。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p06/s04-01-S05_2_00_16_53.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p06/s04-02-S06_1_00_19_21.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p06/s04-03-S06_2_00_19_26.jpg)

## 复现检查清单

- 闭合边界 spline 和道路 spline 分别命名，避免在 PCG 中引用错对象。
- 森林扣除要在树木生成前完成，否则道路和建筑区域仍会残留植被。
- 建筑点密度按建筑占地调，不按草地密度调。
- 道路资产生成后检查贴地、旋转和边缘穿插。


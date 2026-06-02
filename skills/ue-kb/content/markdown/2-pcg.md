# 2.虚幻引擎中的PCG密度噪声节点在哪里_程序内容生成指南

# 2.虚幻引擎中的PCG密度噪声节点在哪里_程序内容生成指南

## 知识目标

- 解释新版 UE/PCG 中找不到 Density Noise 时的替代方法：使用 Attribute Noise 作用到 Density 属性，再接 Density Filter。
- 让旧教程或旧图表迁移到新版时能保持相同的点密度扰动逻辑。

## 可复现主流程

1. 先确认旧图表里 Density Noise 的用途：给点的 Density 属性加噪声，而不是直接生成网格。
2. 新版搜索不到 Density Noise 时，改用 Attribute Noise 节点。
3. 在 Attribute Noise 中选择或写入 Density 属性，设置 Noise Min / Noise Max。
4. 把 Attribute Noise 输出接到 Density Filter，用阈值控制哪些点保留。
5. 打开 Debug 点显示，对比替换前后的点分布，确认噪声范围和过滤阈值接近旧效果。

## 关键术语

- `Density Noise`
- `Attribute Noise`
- `Density`
- `Density Filter`
- `Surface Sampler`
- `Noise Min/Max`
- `Attribute`

## 操作步骤与要点

### Density Noise 的新版替代

- 本集是一个节点迁移提示：旧教程中的 Density Noise 在新版中可能被移除或改名。
- 正确替代链路是 Attribute Noise 写 Density，再用 Density Filter 筛点。
- 采样器相关术语以画面节点名为准，按 Surface Sampler 链路整理。

**内容要点：**

- Density Noise 的新版替代。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p02/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p02/s01-02-S01_2_00_00_55.jpg)

## 复现检查清单

- 替换节点后检查 Attribute Name 是否是 Density。
- Noise Min / Max 和 Density Filter 阈值要一起调，单独改一个参数会改变保留点比例。
- 用 Debug 点云确认分布，再接 Static Mesh Spawner。


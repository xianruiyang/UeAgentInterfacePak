# 2-7 - Pack RGB Channels - Roughness - Displacement - Ambient Occlusion

# 2-7 - Pack RGB Channels - Roughness - Displacement - Ambient Occlusion

## 知识目标

- 本文整理“2-7 - Pack RGB Channels - Roughness - Displacement - Ambient Occlusion”的 PCG 实操流程、关键节点、参数组织方式和复现风险点。

## 可复现主流程

- 把 Roughness、Displacement、Ambient Occlusion 等灰度贴图按 RGB 通道打包，减少采样数量。
- 确认每个通道的值域、反相需求和 sRGB 设置，避免粗糙度/AO 解释错误。
- 在材质函数中按通道拆出数据，并接入对应材质输入。
- 用材质实例对比打包前后效果，确认视觉一致且采样更少。

## 关键术语

- `Material`
- `Landscape`
- `channel`
- `texture`
- `displacement`
- `occlusion`
- `textures`
- `inside`
- `ambient`
- `roughness`
- `green`

## 操作步骤与要点

### 把 Roughness、Displacement、Ambient Occlusion 等灰度贴图按 RGB 通道打包，减少采样数量

**内容要点：**

- 把 Roughness、Displacement、Ambient Occlusion 等灰度贴图按 RGB 通道打包，减少采样数量。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p15/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p15/s01-02-S01_2_00_01_50.jpg)


**参数、节点和风险点：**

- `channel`
- `displacement`
- `ambient`
- `occlusion`
- `roughness`
- `inside`
- `green`
- `control`
- `textures`
- `blue`

### 在材质函数中按通道拆出数据，并接入对应材质输入

**内容要点：**

- 在材质函数中按通道拆出数据，并接入对应材质输入。

**关键截图：**

![关键截图 1](../assets/ue5-black-spruce-pcg-environment-course-p15/s02-01-S02_1_00_03_51.jpg)
![关键截图 2](../assets/ue5-black-spruce-pcg-environment-course-p15/s02-02-S02_2_00_04_51.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `texture`
- `some`
- `landscape`
- `know`
- `blend`
- `materials`
- `wild`
- `grass`

## 复现检查清单

- 打包贴图必须关闭 sRGB，并记录 R/G/B 分别代表什么。
- 所有 UE5 资产都要检查比例、pivot、材质槽、贴图色彩空间和实例化性能。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


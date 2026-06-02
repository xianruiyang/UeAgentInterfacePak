# 7.绘制 PCG！在虚幻引擎 5 中使用 PCG 绘制纹理和景观图层

# 7.绘制 PCG！在虚幻引擎 5 中使用 PCG 绘制纹理和景观图层

## 知识目标

- 用纹理遮罩和 Landscape Layer 驱动 PCG 生成位置，实现可绘制、可导入地图的程序化资产分布。
- 比较三种思路：普通纹理遮罩、Gaia/World Machine 导出地图、Landscape Layer 驱动。

## 可复现主流程

1. 从现有 PCG Graph 出发，按需要断开直接 Surface Sampler 分支。
2. 添加 Texture Data 节点，读取黑白或 RGB 遮罩贴图。
3. 检查贴图压缩/格式设置，确保 PCG 能读取像素通道数据。
4. 选择目标通道，把白色或指定颜色区域转换为点密度。
5. 用 Projection 把纹理数据投射到 Landscape，并接 Density Filter 保留目标区域。
6. 使用 Transform Points 打散纹理采样带来的网格感。
7. 对于 Gaia/World Machine 导出的地图，可先转成 Landscape Layer，再让 PCG 读取 Layer，流程更稳定也更适合大场景。

## 关键术语

- `Texture Data`
- `Mask Texture`
- `RGB Channel`
- `Compression Settings`
- `Projection`
- `Landscape`
- `Density Filter`
- `Transform Points`
- `Gaia`
- `World Machine`
- `Landscape Layer`

## 操作步骤与要点

### Texture Data 读取遮罩

- Texture Data 把贴图像素变成 PCG 可用的数据源，适合用黑白图控制生成区域。
- 贴图压缩和通道选择是常见失败点，必须按画面设置核对。

**内容要点：**

- Texture Data 读取遮罩。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p07/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p07/s01-02-S01_2_00_02_28.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p07/s01-03-S02_1_00_05_08.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p07/s01-04-S02_2_00_07_18.jpg)

### 投射到 Landscape 并过滤密度

- Projection 把纹理数据对齐到 Landscape 后，Density Filter 决定哪些区域真正保留点。
- 纹理采样容易形成规则点阵，需要 Transform Points 做旋转、缩放或位置扰动。

**内容要点：**

- 投射到 Landscape 并过滤密度。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p07/s02-01-S03_1_00_09_51.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p07/s02-02-S03_2_00_11_15.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p07/s02-03-S04_1_00_13_02.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p07/s02-04-S04_2_00_14_10.jpg)

### Gaia / World Machine 地图

- 外部地形工具导出的高度图、坡度图、湿度图或遮罩图可以作为 PCG 的高层控制数据。
- 这些地图更适合驱动区域规则，而不是逐个手摆资产。

**内容要点：**

- Gaia / World Machine 地图。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p07/s03-01-S05_1_00_15_40.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p07/s03-02-S05_2_00_18_00.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p07/s03-03-S06_1_00_20_41.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p07/s03-04-S06_2_00_22_59.jpg)

### Landscape Layer 驱动

- 把地图转成 Landscape Layer 后，PCG 可直接按 Layer 生成对应植被或地表细节。
- 这比直接读单张纹理更适合大型关卡和后续迭代。

**内容要点：**

- Landscape Layer 驱动。

**关键截图：**

![关键截图 1](../assets/ue5-pcg-landscape-optimization-recipes-p07/s04-01-S07_1_00_25_40.jpg)
![关键截图 2](../assets/ue5-pcg-landscape-optimization-recipes-p07/s04-02-S07_2_00_27_03.jpg)
![关键截图 3](../assets/ue5-pcg-landscape-optimization-recipes-p07/s04-03-S08_1_00_28_49.jpg)
![关键截图 4](../assets/ue5-pcg-landscape-optimization-recipes-p07/s04-04-S08_2_00_30_28.jpg)

## 复现检查清单

- 先确认贴图通道和压缩设置，再排查 PCG 节点。
- Projection 的目标必须和实际 Landscape 对齐。
- 直接纹理遮罩适合快速验证；大型地形优先考虑 Landscape Layer 驱动。
- 用 Transform Points 消除网格感，但不要让随机偏移越过遮罩边界太多。


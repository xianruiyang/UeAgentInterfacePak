# 【UE5.3 PCG教程】PCG 网格顶点颜色作为遮罩Mask做程序化生成

# 【UE5.3 PCG教程】PCG 网格顶点颜色作为遮罩Mask做程序化生成

## 知识目标

- 把网格顶点颜色当作遮罩，用颜色通道控制 PCG 在哪些区域生成内容。

## 可复现主流程

- 准备带顶点色的网格，并确保目标区域已经绘制对应颜色通道。
- 在 PCG 中采样网格表面，读取顶点颜色或相关属性。
- 用阈值或通道过滤保留需要生成的点。
- 把过滤后的点接入生成节点，使实例只出现在遮罩允许的区域。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `MeshToPoints`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `Mask`
- `Material`
- `Instance`

## 操作步骤与要点

### 准备带顶点色的网格，并确保目标区域已经绘制对应颜色通道

**内容要点：**

- 这一段对应“准备带顶点色的网格，并确保目标区域已经绘制对应颜色通道。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG 网格顶点颜色作为遮罩Mask做程序化生成”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`Platforms`
- 画面线索：`LitShow`
- 画面线索：`PlaceActors`
- 画面线索：`DetailsxLevels`
- 画面线索：`World..`
- 画面线索：`Search Clas`
- 画面线索：`S_Huge_Sandstone_Cliff_vmill+Add`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p04/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p04/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Actor`
- `Component`
- `Instance`
- `Light`
- `MyEnvironment`
- `Platforms`
- `LitShow`
- `PlaceActors`

### 用阈值或通道过滤保留需要生成的点

**内容要点：**

- 这一段对应“用阈值或通道过滤保留需要生成的点。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG 网格顶点颜色作为遮罩Mask做程序化生成”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`MyEnvironment`
- 画面线索：`Platforms`
- 画面线索：`LitShow`
- 画面线索：`PlaceActors`
- 画面线索：`DetailsxLevels`
- 画面线索：`World..`
- 画面线索：`Search Clas`
- 画面线索：`S_Huge_Sandstone_Clif_vmill+Add`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p04/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p04/s02-02-S02_2_00_03_25.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Point`
- `Actor`
- `Component`
- `Instance`
- `Light`
- `MyEnvironment`
- `Platforms`
- `LitShow`
- `PlaceActors`

## 复现检查清单

- 顶点色通道和阈值要逐项确认，避免把 R/G/B/A 通道用错。
- 遮罩边缘通常需要密度或随机过滤来避免生硬边界。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


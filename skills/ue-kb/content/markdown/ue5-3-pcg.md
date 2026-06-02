# 【UE5.3 PCG教程】创建样条和高架桥下的柱子

# 【UE5.3 PCG教程】创建样条和高架桥下的柱子

## 知识目标

- 创建样条并沿高架桥方向生成桥下柱子，让柱子位置、高度和间距跟随样条/地形变化。

## 可复现主流程

- 创建或读取表示桥梁走向的 Spline。
- 沿样条采样点，并用间距控制柱子数量。
- 根据地面或桥面高度计算柱子长度和位置。
- 把柱子 Mesh 实例化到采样点上，检查朝向、间距和高度是否稳定。

## 关键术语

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `Material`
- `Instance`
- `Landscape`

## 操作步骤与要点

### 创建或读取表示桥梁走向的 Spline

**内容要点：**

- 这一段对应“创建或读取表示桥梁走向的 Spline。”，主要作用是把本集主题“【UE5.3 PCG教程】创建样条和高架桥下的柱子”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`OLit`
- 画面线索：`3曲101002516`
- 画面线索：`Segment=13`
- 画面线索：`el=iuawbag`
- 画面线索：`SL=uewag`
- 画面线索：`=w6og`
- 画面线索：`PCG_HighTrestleTrail`
- 画面线索：`L_spline`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p15/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p15/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Actor`
- `Instance`
- `L_spline`
- `Actor2`
- `OLit`
- `Segment`
- `iuawbag`
- `uewag`

### 创建或读取表示桥梁走向的 Spline（2）

**内容要点：**

- 这一段对应“创建或读取表示桥梁走向的 Spline。”，主要作用是把本集主题“【UE5.3 PCG教程】创建样条和高架桥下的柱子”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG_HighTrestleTrail`
- 画面线索：`L_spline`
- 画面线索：`Selection Mode`
- 画面线索：`Platforms`
- 画面线索：`Actor2`
- 画面线索：`+Add`
- 画面线索：`ItemLabel`
- 画面线索：`Type`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p15/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p15/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Actor`
- `Instance`
- `L_spline`
- `Actor2`
- `PCG_HighTrestleTrail`
- `Selection`
- `Mode`
- `Platforms`

### 沿样条采样点，并用间距控制柱子数量

**内容要点：**

- 这一段对应“沿样条采样点，并用间距控制柱子数量。”，主要作用是把本集主题“【UE5.3 PCG教程】创建样条和高架桥下的柱子”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG_HighTrestleTrail`
- 画面线索：`L_spline`
- 画面线索：`Selection Mode`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`Actor2`
- 画面线索：`PPV+`
- 画面线索：`ItemLabel`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p15/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p15/s03-02-S03_2_00_07_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Actor`
- `Instance`
- `L_spline`
- `Actor2`
- `PCG_HighTrestleTrail`
- `Selection`
- `Mode`
- `Platforms`

### 根据地面或桥面高度计算柱子长度和位置

**内容要点：**

- 这一段对应“根据地面或桥面高度计算柱子长度和位置。”，主要作用是把本集主题“【UE5.3 PCG教程】创建样条和高架桥下的柱子”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG_HighTrestleTrail`
- 画面线索：`L_spline`
- 画面线索：`Selection Mode`
- 画面线索：`Platforms`
- 画面线索：`Actor2`
- 画面线索：`PPV+`
- 画面线索：`ItemLabel`
- 画面线索：`Type`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p15/s04-01-S04_1_00_09_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p15/s04-02-S04_2_00_10_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Actor`
- `Instance`
- `L_spline`
- `Actor2`
- `PCG_HighTrestleTrail`
- `Selection`
- `Mode`
- `Platforms`

### 把柱子 Mesh 实例化到采样点上，检查朝向、间距和高度是否稳定

**内容要点：**

- 这一段对应“把柱子 Mesh 实例化到采样点上，检查朝向、间距和高度是否稳定。”，主要作用是把本集主题“【UE5.3 PCG教程】创建样条和高架桥下的柱子”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG_HighTrestleTrail`
- 画面线索：`L_spline`
- 画面线索：`Selection Mode`
- 画面线索：`Platforms`
- 画面线索：`QSearch.`
- 画面线索：`Actor2`
- 画面线索：`+Add`
- 画面线索：`ItemLabel`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p15/s05-01-S05_1_00_12_03.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p15/s05-02-S05_2_00_12_09.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Actor`
- `Instance`
- `L_spline`
- `Actor2`
- `PCG_HighTrestleTrail`
- `Selection`
- `Mode`
- `Platforms`

## 复现检查清单

- 柱子需要对齐桥面和地面，不能只按水平位置生成。
- 样条端点和急弯位置要单独检查。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


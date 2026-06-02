# 【UE5.3 PCG教程】PCG实现原神加载界面动态

# 【UE5.3 PCG教程】PCG实现原神加载界面动态

## 知识目标

- 用 PCG 组织类似加载界面的动态画面元素，重点是程序化分布、节奏变化和视觉层次。

## 可复现主流程

- 确定画面中需要动态生成或变化的元素。
- 用 PCG 点集控制元素位置、数量和分布。
- 通过蓝图或参数驱动变化，例如显隐、移动、材质变化或生成阶段。
- 检查最终画面是否符合加载界面节奏，而不是只生成静态实例。

## 关键术语

- `PCG`
- `Blueprint`
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
- `Mask`

## 操作步骤与要点

### 确定画面中需要动态生成或变化的元素

**内容要点：**

- 这一段对应“确定画面中需要动态生成或变化的元素。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG实现原神加载界面动态”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`EditWindow`
- 画面线索：`PCG`
- 画面线索：`Project Settings`
- 画面线索：`IA:`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`PerspectiveLitShow`
- 画面线索：`#曲1010101`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p14/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p14/s01-02-S01_2_00_01_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `EditWindow`
- `Project`
- `Platforms`
- `Setings`
- `PerspectiveLitShow`
- `PlaceActors`
- `Detailsx`
- `Worl`

### 用 PCG 点集控制元素位置、数量和分布

**内容要点：**

- 这一段对应“用 PCG 点集控制元素位置、数量和分布。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG实现原神加载界面动态”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG`
- 画面线索：`Project Settings`
- 画面线索：`FractureMode`
- 画面线索：`IIAI`
- 画面线索：`Platforms`
- 画面线索：`Setings`
- 画面线索：`Mode Toolbar`
- 画面线索：`Generate`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p14/s02-01-S02_1_00_03_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p14/s02-02-S02_2_00_04_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Level`
- `Project`
- `FractureMode`
- `IIAI`
- `Platforms`
- `Setings`
- `Mode`
- `Toolbar`
- `Generate`

### 通过蓝图或参数驱动变化，例如显隐、移动、材质变化或生成阶段

**内容要点：**

- 这一段对应“通过蓝图或参数驱动变化，例如显隐、移动、材质变化或生成阶段。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG实现原神加载界面动态”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG`
- 画面线索：`Project Settings`
- 画面线索：`Platforms`
- 画面线索：`+02名用10610`
- 画面线索：`Detailsx`
- 画面线索：`Worl.`
- 画面线索：`Uncontrolled`
- 画面线索：`Unsaved`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p14/s03-01-S03_1_00_06_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p14/s03-02-S03_2_00_07_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Project`
- `Platforms`
- `Detailsx`
- `Worl`
- `Uncontrolled`
- `Unsaved`
- `object`
- `view`
- `details`

### 检查最终画面是否符合加载界面节奏，而不是只生成静态实例

**内容要点：**

- 这一段对应“检查最终画面是否符合加载界面节奏，而不是只生成静态实例。”，主要作用是把本集主题“【UE5.3 PCG教程】PCG实现原神加载界面动态”中的该流程环节落到具体节点、参数或资产操作上。

- 画面线索：`PCG`
- 画面线索：`Project Settings`
- 画面线索：`INIA`
- 画面线索：`Platforms`
- 画面线索：`A中32用10人10`
- 画面线索：`Detailsx`
- 画面线索：`Worl..`
- 画面线索：`Uncontrolled`


**关键截图：**

![关键截图 1](../assets/ue53-pcg-practical-node-recipes-p14/s04-01-S04_1_00_09_10.jpg)
![关键截图 2](../assets/ue53-pcg-practical-node-recipes-p14/s04-02-S04_2_00_09_55.jpg)


**参数、节点和风险点：**

- `PCG`
- `Project`
- `INIA`
- `Platforms`
- `Detailsx`
- `Worl`
- `Uncontrolled`
- `Unsaved`
- `object`
- `view`

## 复现检查清单

- 动态效果应优先控制刷新范围，避免全图频繁重建。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


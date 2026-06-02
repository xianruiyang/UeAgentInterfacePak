# 06 - 学习外部PCG细节设计的艺术

# 06 - 学习外部PCG细节设计的艺术

## 知识目标

- 围绕“06 - 学习外部PCG细节设计的艺术”整理 UE PCG 建筑生成系列第 06 集：把建筑点云、属性、过滤和生成规则转成可复现的中文操作文档。

## 可复现主流程

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支。
- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上。
- 外部细节应围绕建筑表面、边缘和入口分布，按距离、朝向或表面类型过滤点。
- 细节资产要控制密度、随机缩放和碰撞，避免立面变得重复或过密。

## 关键术语

- `PCG`
- `Blueprint`
- `蓝图`
- `Static Mesh`
- `Mesh`
- `Point Filter`
- `Spline`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Component`
- `Spawn`
- `Grid`
- `Density`
- `Random`
- `Seed`
- `Loop`

## 操作步骤与要点

### 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支

**内容要点：**

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s01-02-S01_2_00_02_06.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `蓝图`
- `Actor`
- `Graph`
- `节点`
- `Class`
- `elements`
- `canhavea`
- `unique`

### 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支（2）

**内容要点：**

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s02-01-S02_1_00_04_27.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s02-02-S02_2_00_06_31.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Point`
- `Graph`
- `节点`
- `data`
- `points`
- `element`
- `members`
- `trap`

### 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上

**内容要点：**

- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s03-01-S03_1_00_08_58.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s03-02-S03_2_00_10_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Graph`
- `过滤`
- `密度`
- `节点`
- `Variable`
- `Diff`
- `HideUnrelated`
- `Class`
- `ClassDefaults`

### 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上（2）

**内容要点：**

- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s04-01-S04_1_00_13_20.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s04-02-S04_2_00_15_35.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `蓝图`
- `Actor`
- `Graph`
- `属性`
- `过滤`
- `采样`
- `密度`
- `参数`

### 外部细节应围绕建筑表面、边缘和入口分布，按距离、朝向或表面类型过滤点

**内容要点：**

- 外部细节应围绕建筑表面、边缘和入口分布，按距离、朝向或表面类型过滤点。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s05-01-S05_1_00_18_11.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s05-02-S05_2_00_20_26.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Graph`
- `采样`
- `密度`
- `节点`
- `建筑`
- `compileDiff`
- `Find`
- `HideUnrelated`

### 外部细节应围绕建筑表面、边缘和入口分布，按距离、朝向或表面类型过滤点（2）

**内容要点：**

- 外部细节应围绕建筑表面、边缘和入口分布，按距离、朝向或表面类型过滤点（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s06-01-S06_1_00_23_03.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s06-02-S06_2_00_25_19.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Graph`
- `网格`
- `过滤`
- `采样`
- `密度`
- `节点`
- `生成`
- `Class`

### 细节资产要控制密度、随机缩放和碰撞，避免立面变得重复或过密

**内容要点：**

- 细节资产要控制密度、随机缩放和碰撞，避免立面变得重复或过密。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s07-01-S07_1_00_27_55.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s07-02-S07_2_00_30_10.jpg)


**参数、节点和风险点：**

- `蓝图`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Density`
- `Graph`
- `网格`

### 细节资产要控制密度、随机缩放和碰撞，避免立面变得重复或过密（2）

**内容要点：**

- 细节资产要控制密度、随机缩放和碰撞，避免立面变得重复或过密（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p06/s08-01-S08_1_00_32_47.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p06/s08-02-S08_2_00_34_36.jpg)


**参数、节点和风险点：**

- `PCG`
- `样条`
- `属性`
- `采样`
- `节点`
- `柱子`
- `PCG_BuildingTut`
- `L_Building`
- `Selection`
- `Mode`

## 复现检查清单

- 墙、门、楼层、屋顶、房间、楼梯和家具要用点类型或属性拆开，不要共享同一批未分类点。
- 所有模块资产的 Pivot、尺寸和朝向必须统一，否则 PCG 规则正确也会出现错位。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


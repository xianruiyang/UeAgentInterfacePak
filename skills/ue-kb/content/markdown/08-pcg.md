# 08 - 改进的程序化PCG室内设计

# 08 - 改进的程序化PCG室内设计

## 知识目标

- 围绕“08 - 改进的程序化PCG室内设计”整理 UE PCG 建筑生成系列第 08 集：把建筑点云、属性、过滤和生成规则转成可复现的中文操作文档。

## 可复现主流程

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支。
- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上。
- 室内生成要先划分房间边界、通道和可放置区域，再生成墙面、门洞、家具和装饰。
- 每次加入家具或室内细节都要检查 Bounds 和碰撞，避免家具穿墙、重叠或堵住通道。

## 关键术语

- `PCG`
- `Blueprint`
- `Mesh`
- `Point Filter`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Random`
- `Seed`
- `Loop`
- `Graph`
- `Material`
- `密度`

## 操作步骤与要点

### 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支

**内容要点：**

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s01-01-S01_1_00_00_10.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s01-02-S01_2_00_02_23.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spawn`
- `节点`
- `生成`
- `walls`
- `miss`
- `duplicate`
- `however`
- `many`
- `floors`

### 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支（2）

**内容要点：**

- 把本集放进 PCG 建筑系列主线：先确定建筑输入范围，再把墙、门、楼层、屋顶、房间、楼梯、家具或室内细节拆成独立分支（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s02-01-S02_1_00_04_58.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s02-02-S02_2_00_07_10.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Graph`
- `生成`
- `Class`
- `View`
- `Debug`
- `PCG_Building`
- `Diff`
- `Hide`

### 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上

**内容要点：**

- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s03-01-S03_1_00_09_42.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s03-02-S03_2_00_12_00.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Loop`
- `节点`
- `生成`
- `Wall`
- `Array`
- `InteriorWalls`
- `ExecutewithContext`
- `Rotated`

### 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上（2）

**内容要点：**

- 阅读分段时优先记录点类型、属性、过滤条件、Bounds 和生成器设置，避免把多个建筑部件混在同一批点上（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s04-01-S04_1_00_14_40.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s04-02-S04_2_00_16_53.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Random`
- `Loop`
- `密度`
- `节点`
- `生成`
- `random`
- `wall`
- `point`

### 室内生成要先划分房间边界、通道和可放置区域，再生成墙面、门洞、家具和装饰

**内容要点：**

- 室内生成要先划分房间边界、通道和可放置区域，再生成墙面、门洞、家具和装饰。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s05-01-S05_1_00_19_26.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s05-02-S05_2_00_21_14.jpg)


**参数、节点和风险点：**

- `PCG`
- `Point`
- `Random`
- `Loop`
- `密度`
- `节点`
- `生成`
- `InteriorWalls`
- `loop`
- `False`

### 室内生成要先划分房间边界、通道和可放置区域，再生成墙面、门洞、家具和装饰（2）

**内容要点：**

- 室内生成要先划分房间边界、通道和可放置区域，再生成墙面、门洞、家具和装饰（2）。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s06-01-S06_1_00_23_27.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s06-02-S06_2_00_25_30.jpg)


**参数、节点和风险点：**

- `生成`
- `some`
- `Thankyou`
- `support`
- `PeterWey`
- `EdwinJThomas`
- `RealNoobmaster`
- `Olli`
- `PekkaLehtinen`
- `Sayantan`

### 每次加入家具或室内细节都要检查 Bounds 和碰撞，避免家具穿墙、重叠或堵住通道

**内容要点：**

- 每次加入家具或室内细节都要检查 Bounds 和碰撞，避免家具穿墙、重叠或堵住通道。

**关键截图：**

![关键截图 1](../assets/ue53-pcg-procedural-building-series-p08/s07-01-S07_1_00_27_57.jpg)
![关键截图 2](../assets/ue53-pcg-procedural-building-series-p08/s07-02-S07_2_00_28_54.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Density`
- `生成`
- `建筑`
- `InteriorWalls`
- `CalculateDistance`
- `toEdge`
- `Zoom`

## 复现检查清单

- 墙、门、楼层、屋顶、房间、楼梯和家具要用点类型或属性拆开，不要共享同一批未分类点。
- 所有模块资产的 Pivot、尺寸和朝向必须统一，否则 PCG 规则正确也会出现错位。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


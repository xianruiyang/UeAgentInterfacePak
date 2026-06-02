# 【UE5 | 教程 | PCG】虚幻引擎5 利用PCG创建逼真的样条路径

# 【UE5 | 教程 | PCG】虚幻引擎5 利用PCG创建逼真的样条路径

## 知识目标

- 围绕“【UE5 | 教程 | PCG】虚幻引擎5 利用PCG创建逼真的样条路径”整理 UE5 PCG 样条路径生成流程：复用 Electric Dreams 示例中的 PCG 子图和层级点复制逻辑，把设计师绘制的 Spline 转换为可生成道路、岩石、树木和边缘装饰的程序化路径工具。

## 可复现主流程

- 先建立示例工程上下文：打开 Electric Dreams/PCG 示例，定位 PCG Graphs、Spline Example、PCG Custom Graphs，并识别可复用的 Copy Points with Hierarchy 与 Apply Hierarchy 子图。
- 准备道路资产和路径蓝图：确认路径网格沿 X 轴朝向，整理道路段、岩石、树木等资产，并创建用于承载样条和 PCG 的 Actor Blueprint。
- 创建 PCG Graph 并读取样条输入：让 PCG 图表从蓝图或关卡中的 Spline 获取路径数据，生成沿路径分布的基础点集。
- 用 Copy Points with Hierarchy 和 Apply Hierarchy 继承 Electric Dreams 的层级逻辑，把 Mesh、Material Path 等属性挂到点上，供后续 Static Mesh Spawner 使用。
- 为道路本体设置 Mesh 与 Material Path 属性，并把转换后的点接入 Static Mesh Spawner，先确认道路能沿样条生成。
- 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置。
- 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化。
- 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序。
- 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转。
- 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新。

## 关键术语

- `PCG`
- `Blueprint`
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
- `Density`
- `Random`
- `Seed`
- `Loop`
- `Graph`
- `Material`

## 操作步骤与要点

### 先建立示例工程上下文：打开 Electric Dreams/PCG 示例，定位 PCG Graphs、Spline Example、PCG Custom Graphs，并识别可复用的 Copy Points with Hierarchy 与 Apply Hierarchy 子图

**内容要点：**

- 本段先展示目标效果：设计师在关卡中调整一条 Spline，PCG 会沿路径重建道路，并在道路两侧随机生成树木、岩石和植被。随后定位 Electric Dreams 示例关卡和 PCG Spline Example，说明本教程会复用官方示例中的路径生成逻辑。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s01-01-S01_1_00_00_12.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s01-02-S01_2_00_01_43.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `Point`
- `Actor`
- `Spawn`
- `Random`
- `Graph`
- `Instance`
- `path`

### 准备道路资产和路径蓝图：确认路径网格沿 X 轴朝向，整理道路段、岩石、树木等资产，并创建用于承载样条和 PCG 的 Actor Blueprint

**内容要点：**

- 本段主要查找可复用资源：进入 PCG Custom Graphs，确认 Copy Points with Hierarchy、Apply Hierarchy 以及相关 Post Copy Points 蓝图可直接拿来继承层级属性。随后开始整理道路段、岩石等资产，并强调路径网格朝向要沿 X 轴。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s02-01-S02_1_00_03_34.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s02-02-S02_2_00_05_42.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Point`
- `Actor`
- `Graph`
- `path`
- `project`
- `created`
- `able`
- `nice`

### 创建 PCG Graph 并读取样条输入：让 PCG 图表从蓝图或关卡中的 Spline 获取路径数据，生成沿路径分布的基础点集

**内容要点：**

- 本段把资产和蓝图准备串起来：把岩石等候选资产放入便于选择的集合，创建 BP Desert Paths 一类的 Actor Blueprint，并开始建立用于路径生成的 PCG Graph，为后续读取 Spline 和生成点集做准备。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s03-01-S03_1_00_08_11.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s03-02-S03_2_00_10_30.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Spline`
- `Actor`
- `Component`
- `Graph`
- `Instance`
- `Paths`
- `instance`
- `Desert`

### 用 Copy Points with Hierarchy 和 Apply Hierarchy 继承 Electric Dreams 的层级逻辑，把 Mesh、Material Path 等属性挂到点上，供后续 Static Mesh Spawner 使用

**内容要点：**

- 本段进入 PCG 图表核心：添加 Copy Points with Hierarchy 与 Apply Hierarchy 子图，把 Mesh、Material Path 等属性写入点数据，再把点数据送入 Static Mesh Spawner，先让道路或基础资产能沿路径正确生成。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s04-01-S04_1_00_13_10.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s04-02-S04_2_00_15_24.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Attribute`
- `Spawn`
- `Density`
- `Graph`

### 为道路本体设置 Mesh 与 Material Path 属性，并把转换后的点接入 Static Mesh Spawner，先确认道路能沿样条生成

**内容要点：**

- 本段处理岩石分支的过滤逻辑：因为多块岩石不能全部堆在同一点上，需要通过过滤、随机选择、Difference 或自定义过滤把点集拆分，让不同岩石在路径两侧有机会互斥分布。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s05-01-S05_1_00_18_34.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s05-02-S05_2_00_20_50.jpg)


**参数、节点和风险点：**

- `Blueprint`
- `Point`
- `Density`
- `Untirted`
- `Selection`
- `Mode`
- `Asset`
- `Flegen`
- `Desty`
- `Debug`

### 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置

**内容要点：**

- 本段开始处理树木分支：复用前面已经拆好的点集，给树木创建独立的随机过滤、变换、缩放和朝向控制，让大树、小树能够沿道路边缘自然分布，而不是规则重复。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s06-01-S06_1_00_23_26.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s06-02-S06_2_00_24_45.jpg)


**参数、节点和风险点：**

- `Attribute`
- `Actor`
- `densitivity`
- `hierarchy`
- `node`
- `Untided`
- `Label`
- `Uneied`
- `Ednor`
- `PahGeo`

### 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化

**内容要点：**

- 本段继续细化小树和随机分布：调整随机比例、最小值、属性过滤和标签，把不同植被分支分别接回图表，确保大树、小树、岩石各自使用正确的点集和资源路径。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s07-01-S07_1_00_27_06.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s07-02-S07_2_00_28_23.jpg)


**参数、节点和风险点：**

- `Actor`
- `tutorial`
- `Label`
- `Ednor`
- `Pahoeo`
- `SmalsShrubs`
- `PahGeolckup`
- `P_DeertPah`
- `PPCoFece1`
- `PPOG_Fence`

### 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序

**内容要点：**

- 本段把各个分支合并回完整道路系统：道路本体、岩石、树木、小树等分支都接入同一个 PCG 结构，通过过滤和 Transform 控制它们如何围绕路面分布，形成接近 Electric Dreams 示例的随机路径环境。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s08-01-S08_1_00_30_03.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s08-02-S08_2_00_31_13.jpg)


**参数、节点和风险点：**

- `PCG`
- `tutorial`
- `Uneded`
- `Ednor`
- `Pahoeo`
- `PahGeobackup`
- `SmallShrubs`
- `Trees`
- `IPDesetPa`
- `P_POGFence`

### 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转

**内容要点：**

- 本段重点解决道路段与 Spline 的连接问题：如果直接把网格段接到 Spline 点，转角和高度变化容易产生缝隙或错位；需要在中间增加点、根据网格长度偏移位置，并保证点与 Spline 起点、路径方向一致。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s09-01-S09_1_00_32_46.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s09-02-S09_2_00_34_07.jpg)


**参数、节点和风险点：**

- `Actor`
- `tutorial`
- `Untided`
- `Uned`
- `Ednor`
- `PahOeo`
- `PahGeoackup`
- `Trees`
- `Folder`
- `IPDesertPah`

### 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新

**内容要点：**

- 本段修正最终 Transform：拆分点的 Transform，把 X/Y/Z 位移或旋转按路径点计算后重新组合，使道路和装饰物能跟随地形坡度与路径角度。最终通过移动 Spline 验证生成结果能稳定更新，减少漂浮、穿插和翻转问题。


**关键截图：**

![关键截图 1](assets/ue5-pcg-realistic-spline-path/s10-01-S10_1_00_35_52.jpg)
![关键截图 2](assets/ue5-pcg-realistic-spline-path/s10-02-S10_2_00_36_07.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Untted`
- `SonMode`
- `Label`
- `Uneted`
- `Ednor`
- `Pahoeo`
- `SmalShrubs`
- `iTrees`

## 复现检查清单

- 路径网格必须沿正确轴向建模，视频中强调沿 X 轴，否则 Spline Mesh 或点实例会整体朝向错误。
- Mesh 与 Material Path 属性名要和 Static Mesh Spawner/子图读取的一致，属性拼写错误会导致资产不生成或材质丢失。
- 岩石、树木、小树等分支应先用点调试确认互斥关系，再接 Spawner，避免同一点重复生成多个资产。
- 随机过滤和 Density/Filter 分支要保持可调参数，方便在不同路径长度和场景密度下复用。
- 旋转修正不能只看道路平面，还要检查地形坡度和路径转弯处的实例方向。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


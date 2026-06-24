# 虚幻引擎5.4.4中制作PCG森林路径全流程

## 知识目标

- 围绕“虚幻引擎5.4.4中制作PCG森林路径全流程”整理 UE5 PCG 样条路径生成流程：复用 Electric Dreams 示例中的 PCG 子图和层级点复制逻辑，把设计师绘制的 Spline 转换为可生成道路、岩石、树木和边缘装饰的程序化路径工具。

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
- `蓝图`
- `Static Mesh`
- `Mesh`
- `SubGraph`
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

## 操作步骤与要点

### 先建立示例工程上下文：打开 Electric Dreams/PCG 示例，定位 PCG Graphs、Spline Example、PCG Custom Graphs，并识别可复用的 Copy Points with Hierarchy 与 Apply Hierarchy 子图

**内容要点：**

- 本段先展示目标效果：设计师在关卡中调整一条 Spline，PCG 会沿路径重建道路，并在道路两侧随机生成树木、岩石和植被。随后定位 Electric Dreams 示例关卡和 PCG Spline Example，说明本教程会复用官方示例中的路径生成逻辑。


**关键截图：**

画面说明：第一张展示目标森林路径效果，路径穿过密林并在两侧分布树木、岩石和植被；第二张展示从 UE 示例工程的 ThirdPersonMap 和 StarterContent/Architecture 资源开始整理路径制作上下文。两张图不包含正文之外的节点连接、参数值或操作步骤。


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Actor`
- `Component`
- `体积`
- `森林`
- `tutorial`
- `Light`
- `ThirdPersonMap`
- `Magnet`

### 先建立示例工程上下文：打开 Electric Dreams/PCG 示例，定位 PCG Graphs、Spline Example、PCG Custom Graphs，并识别可复用的 Copy Points with Hierarchy 与 Apply Hierarchy 子图（2）

**内容要点：**

- 本段主要查找可复用资源：进入 PCG Custom Graphs，确认 Copy Points with Hierarchy、Apply Hierarchy 以及相关 Post Copy Points 蓝图可直接拿来继承层级属性。随后开始整理道路段、岩石等资产，并强调路径网格朝向要沿 X 轴。


**关键截图：**

画面说明：第一张展示当前示例关卡中选中的 Landscape、基础地形和 StarterContent 资源浏览器，用于确认工程已经进入地形与资源整理阶段。
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s02-02-S02_2_00_07_01.jpg)


**参数、节点和风险点：**

- `Material`
- `Landscape`
- `网格`
- `材质`
- `过滤`
- `森林`
- `landscape`
- `Quixel`
- `Unreal`
- `Senji`

### 先建立示例工程上下文：打开 Electric Dreams/PCG 示例，定位 PCG Graphs、Spline Example、PCG Custom Graphs，并识别可复用的 Copy Points with Hierarchy 与 Apply Hierarchy 子图（3）

**内容要点：**

- 本段把资产和蓝图准备串起来：把岩石等候选资产放入便于选择的集合，创建 BP Desert Paths 一类的 Actor Blueprint，并开始建立用于路径生成的 PCG Graph，为后续读取 Spline 和生成点集做准备。


**关键截图：**

画面说明：第一张展示草地 Landscape 与 Megascans/Surfaces 资源目录，用于确认地表材质资源已经纳入项目；第二张展示 Landscape Paint 模式中选择 `C_LayerInfo` 目标层，并打开 `M_Landscape_NaniteEx` 的 Layer Parameters。可见 `A_Material` 中启用了 `Color A`、`Roughness A`、`Normal A`、`Size A=0.075`、`Height Blend Offset A=0.0`，同时在 Megascans/Surfaces 中选中了 `Nordic_Forest_Ground_Roots_Coarse_xkglaihn` 资源目录。


**参数、节点和风险点：**

- `Material`
- `Instance`
- `Landscape`
- `材质`
- `实例`
- `过滤`
- `Ground`
- `Mega`
- `texture`
- `Paint`

### 准备道路资产和路径蓝图：确认路径网格沿 X 轴朝向，整理道路段、岩石、树木等资产，并创建用于承载样条和 PCG 的 Actor Blueprint

**内容要点：**

- 本段进入 PCG 图表核心：添加 Copy Points with Hierarchy 与 Apply Hierarchy 子图，把 Mesh、Material Path 等属性写入点数据，再把点数据送入 Static Mesh Spawner，先让道路或基础资产能沿路径正确生成。


**关键截图：**

画面说明：第一张展示当前 Landscape 预览和 Megascans/Plants 资源目录，用于确认植物资源已经导入并参与后续路径环境制作。第二张展示 `LG_A` LandscapeGrassType 的可见设置：`Grass Mesh=xisgcic_tier_1`，`Grass Density=400.0`，`Grass Density Quality=400.0`，启用 `Use Grid`，`Placement Jitter=1.0`，`Start Cull Distance=10000`，`End Cull Distance=10000`，`Min LOD=-1`，`Scaling=Uniform`，`Scale X Min/Max=1.0/1.0`，并启用 `Random Rotation` 与 `Align to Surface`。


**参数、节点和风险点：**

- `Static Mesh`
- `Mesh`
- `Density`
- `Material`
- `Landscape`
- `网格`
- `材质`
- `过滤`
- `道路`
- `Grass`

### 准备道路资产和路径蓝图：确认路径网格沿 X 轴朝向，整理道路段、岩石、树木等资产，并创建用于承载样条和 PCG 的 Actor Blueprint（2）

**内容要点：**

- 本段处理岩石分支的过滤逻辑：因为多块岩石不能全部堆在同一点上，需要通过过滤、随机选择、Difference 或自定义过滤把点集拆分，让不同岩石在路径两侧有机会互斥分布。


**关键截图：**

画面说明：第一张展示岩石资源加入后的小径边缘预览，并在 `LG_A` LandscapeGrassType 中把 `Grass Density` 调为 `5.0`，其余可见设置仍包括 `Grass Mesh=xisgcic_tier_1`、`Use Grid`、`Placement Jitter=1.0`、`Start/End Cull Distance=10000`、`Random Rotation` 和 `Align to Surface`。第二张展示路径两侧已经生成岩石和低矮植被，内容浏览器切到 `EuropeanHornbeam` 静态网格资源目录，用于继续准备树木分支资源。


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spawn`
- `Landscape`
- `网格`
- `材质`
- `过滤`
- `采样`
- `节点`

### 创建 PCG Graph 并读取样条输入：让 PCG 图表从蓝图或关卡中的 Spline 获取路径数据，生成沿路径分布的基础点集

**内容要点：**

- 本段开始处理树木分支：复用前面已经拆好的点集，给树木创建独立的随机过滤、变换、缩放和朝向控制，让大树、小树能够沿道路边缘自然分布，而不是规则重复。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s06-01-S06_1_00_21_38.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s06-02-S06_2_00_23_04.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Attribute`
- `Density`
- `Graph`
- `网格`
- `属性`
- `过滤`
- `密度`

### 创建 PCG Graph 并读取样条输入：让 PCG 图表从蓝图或关卡中的 Spline 获取路径数据，生成沿路径分布的基础点集（2）

**内容要点：**

- 本段继续细化小树和随机分布：调整随机比例、最小值、属性过滤和标签，把不同植被分支分别接回图表，确保大树、小树、岩石各自使用正确的点集和资源路径。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s07-01-S07_1_00_24_55.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s07-02-S07_2_00_27_11.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Material`
- `Landscape`
- `网格`
- `材质`
- `属性`

### 用 Copy Points with Hierarchy 和 Apply Hierarchy 继承 Electric Dreams 的层级逻辑，把 Mesh、Material Path 等属性挂到点上，供后续 Static Mesh Spawner 使用

**内容要点：**

- 本段把各个分支合并回完整道路系统：道路本体、岩石、树木、小树等分支都接入同一个 PCG 结构，通过过滤和 Transform 控制它们如何围绕路面分布，形成接近 Electric Dreams 示例的随机路径环境。


**关键截图：**

画面说明：第一张展示道路两侧已经生成森林植被，并在 Content Browser 中选中 Manny 角色网格，用于后续路径尺度参照。第二张展示 `BP_Spline` Actor 蓝图的组件结构：`DefaultSceneRoot` 下添加 `Spline` 组件，Details 中 `Variable Name=Spline`、`Editable when Inherited` 启用、Transform 为 Location/Rotation `0` 且 Scale `1`，Mobility 设为 `Movable`；Spline 设置中 `Duration=1.0`，`Draw Debug` 启用，`Closed Loop` 未启用，`Default Up Vector=(0,0,1)`，并保留编辑器中的未选中/选中/切线颜色与 `Adjust Tangents on Snap`。


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `蓝图`
- `Spline`
- `Actor`
- `Landscape`
- `样条`
- `tutorial`
- `shift`
- `LandscapeModev`

### 用 Copy Points with Hierarchy 和 Apply Hierarchy 继承 Electric Dreams 的层级逻辑，把 Mesh、Material Path 等属性挂到点上，供后续 Static Mesh Spawner 使用（2）

**内容要点：**

- 本段重点解决道路段与 Spline 的连接问题：如果直接把网格段接到 Spline 点，转角和高度变化容易产生缝隙或错位；需要在中间增加点、根据网格长度偏移位置，并保证点与 Spline 起点、路径方向一致。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s09-01-S09_1_00_32_32.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s09-02-S09_2_00_34_40.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `蓝图`
- `Spline`
- `Actor`
- `Component`
- `Density`
- `Graph`
- `Landscape`
- `样条`

### 为道路本体设置 Mesh 与 Material Path 属性，并把转换后的点接入 Static Mesh Spawner，先确认道路能沿样条生成

**内容要点：**

- 本段修正最终 Transform：拆分点的 Transform，把 X/Y/Z 位移或旋转按路径点计算后重新组合，使道路和装饰物能跟随地形坡度与路径角度。最终通过移动 Spline 验证生成结果能稳定更新，减少漂浮、穿插和翻转问题。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s10-01-S10_1_00_37_14.jpg)
画面说明：第二张展示用 `CineCameraActor` 预览生成后的森林路径，并在 Sequencer `Tutorial_sequence` 中包含 `Camera Cuts`、`CineCameraActor` 与 `CameraComponent` 轨道；Details 面板搜索 `exposure`，`CameraComponent` 的 Post Process/Lens/Exposure 设置里 `Metering Mode=Manual`，`Exposure Compensation=10.0`。


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Component`
- `Graph`
- `Material`
- `Landscape`
- `样条`
- `网格`
- `材质`
- `过滤`

### 为道路本体设置 Mesh 与 Material Path 属性，并把转换后的点接入 Static Mesh Spawner，先确认道路能沿样条生成（2）

**视频内容贴合整理：**

**内容要点：**

- 为道路本体设置 Mesh 与 Material Path 属性，并把转换后的点接入 Static Mesh Spawner，先确认道路能沿样条生成（2）。


**关键截图：**

画面说明：两张图都在用 `LG_A` LandscapeGrassType 调整道路边缘植被。第一张显示 `Grass Varieties` 已有 `4 Array elements`，当前展开 `Index[1]`，可见 `Grass Mesh=xjjifd1_tier_1`、`Grass Density=2.0`、`Use Grid` 启用、`Placement Jitter=1.0`、`Start/End Cull Distance=10000`、`Min LOD=-1`、`Scaling=Uniform`、`Scale X Min/Max=1.0/1.0`。第二张继续调整低矮物体分布，显示 `Grass Density=241.404968`，`Scale X Min/Max=0.3/0.8`，并保持 `Use Grid`、`Placement Jitter=1.0`、`Start/End Cull Distance=10000`、`Min LOD=-1` 和 `Random Rotation`。


**参数、节点和风险点：**

- `Static Mesh`
- `Mesh`
- `Actor`
- `Component`
- `Density`
- `Material`
- `Landscape`
- `网格`
- `过滤`
- `密度`

### 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置

**视频内容贴合整理：**

**内容要点：**

- 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置。


**关键截图：**

画面说明：第一张展示 Landscape Mode 的 `Sculpt/Smooth` 工具正在用于平滑小径地形，视口中可见样条路径、森林、岩石和地面细节，Content Browser 中保留 Fab/Megascans 资源用于继续补充路径边缘物体。
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s12-02-S12_2_00_47_51.jpg)


**参数、节点和风险点：**

- `PCG`
- `蓝图`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Material`

### 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置（2）

**视频内容贴合整理：**

**内容要点：**

- 给岩石和边缘物体创建独立分支：用过滤、随机选择、自定义过滤或 Difference 把点集拆分，避免多类资产挤在同一个位置（2）。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s13-01-S13_1_00_50_31.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s13-02-S13_2_00_52_47.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Graph`
- `Material`
- `Landscape`
- `样条`

### 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化

**视频内容贴合整理：**

**内容要点：**

- 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化。


**关键截图：**

画面说明：第一张展示道路边缘已经形成完整森林环境，路径两侧分布树木、岩石、枝条和地表覆盖物；Content Browser 中可见 `BP_Spline`、`PCG_ground_vegetations`、`PCG_road`、`PCG_tree` 等资源，用于组织道路、植被和树木生成。
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s14-02-S14_2_00_57_41.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Actor`
- `Spawn`
- `网格`
- `过滤`
- `采样`
- `密度`

### 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化（2）

**视频内容贴合整理：**

**内容要点：**

- 处理树木和小树分支：基于路径两侧的点做随机筛选、变换、缩放和朝向控制，让植被在道路边缘形成自然变化（2）。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s15-01-S15_1_01_00_20.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s15-02-S15_2_01_01_49.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Graph`
- `Landscape`
- `网格`
- `过滤`

### 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序

**视频内容贴合整理：**

**内容要点：**

- 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s16-01-S16_1_01_03_41.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s16-02-S16_2_01_05_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Actor`
- `Spawn`
- `Graph`
- `Landscape`
- `网格`
- `体积`

### 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序（2）

**视频内容贴合整理：**

**内容要点：**

- 把道路、岩石、树木等分支组合回同一个 PCG 图表，检查每个分支的点数、资产路径、材质路径和生成顺序（2）。


**关键截图：**

![关键截图 1](assets/ue54-pcg-forest-path-full-workflow/s17-01-S17_1_01_08_34.jpg)
![关键截图 2](assets/ue54-pcg-forest-path-full-workflow/s17-02-S17_2_01_10_06.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Graph`
- `Landscape`
- `网格`

### 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转

**视频内容贴合整理：**

**内容要点：**

- 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转。


**关键截图：**

画面说明：第一张展示修正后的小径结果，Outliner 中可见 `BP_Spline_Generated` 下生成了多个 `DecalActor`，Content Browser 保持在 `MS_ForestTut` 静态网格资源目录。第二张切到 Foliage Mode 的 `Paint` 工具，视口以 `CineCameraActor` 预览森林路径，Paint 面板中 `Brush Size=512.0`、`Paint Density=0.5`、`Erase Density=0.0`，过滤器启用 `Landscape`、`Static Meshes` 和 `BSP`，底部选中了多件 `Sctr_wood_stick_M_pdye3` 静态网格资源。


**参数、节点和风险点：**

- `Spline`
- `Actor`
- `密度`
- `Directional`
- `Light`
- `Sequencer`
- `tutorial`
- `Whose`
- `Selection`
- `shift`

### 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转（2）

**视频内容贴合整理：**

**内容要点：**

- 修正旋转和贴地问题：使用 Transform Points、点属性和角度计算，让实例跟随地面和路径方向，避免路面或装饰物出现穿插、漂浮或奇怪翻转（2）。


**关键截图：**

画面说明：第一张展示 `Tutorial_sequence` 的镜头预览和 Sequencer 时间线，轨道包含 `Camera Cuts`、`CineCameraActor` 与 `CameraComponent`，Outliner 中可见 `Landscape`、`PCG_big_tree1`、`PCG_ground_ground_...`、`PCG_ground_rocks`、`PCG_ground_vegetatio...`、`PCG_tree`、`PCGWorldActor0`、`SKM_Manny`、`SkyAtmosphere` 等场景对象。第二张展示选中路径边缘静态网格 `tlnvecpfa_tier_3` 后的贴地和旋转检查：视口中显示旋转坐标轴，Details 面板中 `Location=(-10117.65, 23376.050, -648.8912)`、`Rotation=(0.0, 0.0, 86.1846)`、`Scale=(1.0, 1.0, 1.0)`，Mobility 为 `Static`，Static Mesh 指向 `tlnvecpfa_tier_3`。


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Actor`
- `Landscape`
- `网格`
- `过滤`
- `tutorial`
- `Sequencer`
- `Static`

### 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新

**视频内容贴合整理：**

**内容要点：**

- 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新。


**关键截图：**

画面说明：第一张展示在 `Tutorial_sequence` 中复测镜头路径，视口里使用 Manny 角色作为道路尺度参照，Sequencer 打开关键帧插值菜单，可见 `Key All`、`Key Group`、`Key Changed`，以及 `Cubic (Smart Auto)`、`Cubic (Auto)`、`Cubic (User)`、`Cubic (Break)`、`Linear`、`Constant` 等插值选项。第二张继续在同一序列中检查 `CineCameraActor`，Outliner 中可见 `BP_Spline_Generated`、多个 `DecalActor`、`BP_Spline`、`CineCameraActor`、`DirectionalLight`、`ExponentialHeightFog` 和 `InstancedFoliageActor`；Sequencer 中增加 `Camera Shake` 轨道并使用 `NewBlueprint_C`，Details 面板选中 `CameraComponent`，Transform 为 Location/Rotation `0`、Scale `1`，Camera Settings 中 `Filmback=16:9 DSLR`、`Lens Settings=Universal Zoom`、`Crop Settings=No Crop`、`Current Focal Length=15.0`、`Current Aperture=1.67222`。


**参数、节点和风险点：**

- `蓝图`
- `Static Mesh`
- `Mesh`
- `Actor`
- `网格`
- `过滤`
- `Shake`
- `Camera`
- `Movie`
- `Render`

### 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新（2）

**视频内容贴合整理：**

**内容要点：**

- 最后在关卡中移动/编辑 Spline 进行复测，确认路径、边缘随机物体、植被、材质和层级复制逻辑都能随样条稳定更新（2）。


**关键截图：**

画面说明：两张图都在 Movie Render Queue 中配置最终复测渲染。作业名为 `Tutorial_sequence`，Sequence 选择 `Tutorial`，Map 选择 `tutorial`。第一张打开 `Anti-aliasing` 设置，`Spatial Sample Count=1`、`Temporal Sample Count=16`，`Override Anti Aliasing` 未勾选，旁边提示该选项用于在电影渲染时覆盖项目抗锯齿设置。第二张切到 `High Resolution` 设置，`Tile Count=1`、`Texture Sharpness Bias=0.0`、`Overlap Ratio=0.0`、`Override Sub Surface Scattering` 勾选，`Burley Sample Count=64`，`Allocate History Per Tile` 勾选；右下角还显示编辑器提示有 5 个 asset editor 可重新打开。


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `材质`
- `Temporal`
- `Sample`
- `Count`
- `Override`
- `anti`
- `aliasing`
- `Frame`

## 复现检查清单

- 路径网格必须沿正确轴向建模，视频中强调沿 X 轴，否则 Spline Mesh 或点实例会整体朝向错误。
- Mesh 与 Material Path 属性名要和 Static Mesh Spawner/子图读取的一致，属性拼写错误会导致资产不生成或材质丢失。
- 岩石、树木、小树等分支应先用点调试确认互斥关系，再接 Spawner，避免同一点重复生成多个资产。
- 随机过滤和 Density/Filter 分支要保持可调参数，方便在不同路径长度和场景密度下复用。
- 旋转修正不能只看道路平面，还要检查地形坡度和路径转弯处的实例方向。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。

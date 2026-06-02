# 虚幻引擎5.6！制作PCG森林小径环境！

# 虚幻引擎5.6！制作PCG森林小径环境！

## 知识目标

- 围绕“虚幻引擎5.6！制作PCG森林小径环境！”整理一套 UE5.6 PCG 森林小径环境制作流程：从基础关卡、Landscape 和资源准备开始，用 Spline 定义小径，用 PCG Surface/Spline 采样生成树木、草、岩石、落叶和苔藓细节，最后补充材质、灯光、Niagara 落叶、Sequencer 镜头和 Movie Render Queue 输出。

## 可复现主流程

- 创建基础关卡并清理默认内容，保留需要的天空、云、光照和地形基础对象；先把关卡文件夹、资源文件夹和后续 PCG 图表位置整理好。
- 建立或导入 Landscape，调整地形高度、缩放和基础材质，让森林小径有足够的坡度、起伏和可投射表面。
- 准备环境资源：树木、草、岩石、落叶、枝条、苔藓、土壤/小径材质等资源要先按类别放好，并检查 Pivot、尺寸、Nanite 和碰撞设置。
- 创建 PCG Graph，把 PCG 组件或 PCG Volume 放入场景，确认图表能读取 Landscape 并在目标区域产生初始点。
- 用 Surface Sampler 从 Landscape 采样生成森林候选点，先用低密度调试点云，确认点落在地形表面而不是悬空或穿地。
- 接入 Static Mesh Spawner 生成第一批树木，并通过 Mesh Entries、随机缩放、随机旋转和密度参数控制树种比例与分布。
- 绘制或引用 Spline 小径 Actor，用 Spline Sampler / Get Spline Data 读取路径，设置 Actor Selection、Landscape 类选择和 Unbounded 等关键项。
- 用 Spline 距离、Bounds Modifier、Difference、Density Filter 等节点从森林点云中清出小径空间，形成路面留白和边缘过渡。
- 把路径相关点写入 Path 类型或密度属性，分离小径内部、小径边缘和森林主体，避免所有资产共享同一套点集。
- 使用 Transform Points 调整小径两侧树木或灌木的偏移、旋转、缩放和密度，让植被沿路径边缘自然展开。
- 加入草、灌木和低矮植被分支；每类资产单独控制密度、随机缩放、材质变化和排除范围，避免重复图案。
- 复用树木边缘逻辑生成岩石、树枝和地面杂物；用偏移和过滤保证这些物体主要出现在小径边缘和森林地表上。
- 加入落叶、枝条、苔藓等地面细节，必要时使用 Decal 或 Mesh Renderer 区分覆盖层级，避免苔藓和树叶互相遮挡错误。
- 调整 Landscape/土壤/路径材质，让路径区域、森林地表和细节资产在颜色、粗糙度和比例上保持一致。
- 使用 Execute Blueprint 或 Blueprint Element 时，确认输入点属性、执行上下文和输出结果都能被后续 PCG 节点正确消费。
- 整体检查 PCG 图表性能：Nanite、碰撞、实例数量、Cull Distance、密度过滤和调试节点要在大范围生成前先收敛。
- 建立灯光环境：Directional Light、Sky Light、Exponential Height Fog、Volumetric Fog 和 Post Process Volume 共同决定森林氛围。
- 根据镜头需求调整雾密度、曝光、色调、太阳方向和阴影，让小径读得清楚，远景不过曝或过黑。
- 创建 Niagara 落叶或粒子系统，用 Mesh Renderer 或相关设置控制落叶实例，并保证粒子不会破坏主场景性能。
- 使用 Movie Render Queue 输出最终镜头，渲染前关闭临时 Debug、确认后处理、抗锯齿、分辨率和输出路径。

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

### 创建基础关卡并清理默认内容，保留需要的天空、云、光照和地形基础对象；先把关卡文件夹、资源文件夹和后续 PCG 图表位置整理好

**内容要点：**

- 本段从空白 Basic Level 开始搭建环境：删除默认云、天空球、Player Start 和地板，保存关卡后创建 Landscape，并设置 sections、components、50 倍缩放和 edit layers。随后复制土壤材质到项目材质目录，调整 tiling 与 specular，再用 Landscape Spline 在单独 edit layer 中绘制小径，设置 half width 和 side falloff，为后续 PCG 路径留白打基础。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s01-01-S01_1_00_00_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s01-02-S01_2_00_02_19.jpg)


**参数、节点和风险点：**

- `Point`
- `Actor`
- `Component`
- `Material`
- `Landscape`
- `landscape`
- `material`
- `control`
- `line`
- `select`

### 创建基础关卡并清理默认内容，保留需要的天空、云、光照和地形基础对象；先把关卡文件夹、资源文件夹和后续 PCG 图表位置整理好（2）

**内容要点：**

- 本段先修整 Landscape Spline 控制点，旋转和移动异常点，整体下移 spline 控制点，让路径形状稳定且可随 edit layer 自动更新。之后开启 PCG 插件，新建 `PCG_environment_forest` 图表，添加 Surface Sampler 和 Get Landscape Data，将 PCG 图表放入关卡，生成覆盖 Landscape 的初始点，并接 Static Mesh Spawner 放入第一棵 Quixel European Hornbeam 树。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s02-01-S02_1_00_04_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s02-02-S02_2_00_06_49.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Spawn`
- `Graph`
- `Landscape`
- `landscape`
- `trees`

### 建立或导入 Landscape，调整地形高度、缩放和基础材质，让森林小径有足够的坡度、起伏和可投射表面

**内容要点：**

- 本段开始控制树木密度和路径清空。先把 Surface Sampler 的 point per square meter 从过高值降到 0.05/0.03，确认树木不会填满画面；随后因为路径上也生成了树，临时禁用 Spawner，添加 Spline Sampler、Get Spline Data，按 Landscape 类读取路径，并启用 Unbounded 和 Debug 检查路径点。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s03-01-S03_1_00_09_21.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s03-02-S03_2_00_10_33.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spline`
- `Point`
- `Actor`
- `Spawn`
- `Bounds`
- `Graph`
- `Landscape`

### 建立或导入 Landscape，调整地形高度、缩放和基础材质，让森林小径有足够的坡度、起伏和可投射表面（2）

**内容要点：**

- 本段用 Bounds Modifier 调整 Spline 影响范围，将 Y 方向 bounds 缩到合适宽度，X 方向 bounds 加大，用 named reroute 标记为 `path`。接着用 Difference 将 Surface Sampler 的树木点集减去 Path 点集，开启 Show Bounds 检查删除范围，解决树木压到路径上的问题。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s04-01-S04_1_00_12_05.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s04-02-S04_2_00_13_50.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Bounds`
- `Density`
- `Graph`
- `bound`
- `them`

### 准备环境资源：树木、草、岩石、落叶、枝条、苔藓、土壤/小径材质等资源要先按类别放好，并检查 Pivot、尺寸、Nanite 和碰撞设置

**内容要点：**

- 本段把树木分成多个 Mesh Entry/Spawner 分支，分别估算三种树的缩放范围，设置 Z 轴随机旋转 360 度，并为不同树种设置不同 scale min/max。这里的重点是不要让所有树同尺寸同朝向，而是先建立主树种的随机大小和方向差异。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s05-01-S05_1_00_15_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s05-02-S05_2_00_17_44.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Graph`
- `scale`
- `them`
- `trees`

### 创建 PCG Graph，把 PCG 组件或 PCG Volume 放入场景，确认图表能读取 Landscape 并在目标区域产生初始点

**内容要点：**

- 本段处理复制到路径边缘的树木点的缩放问题。因为直接复制点会继承不合适的 scale，所以在连接到目标输入前加入 Transform Points，启用 absolute scale，再用 Bounds Modifier 可视化这些点，并准备沿小径两侧生成树带。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s06-01-S06_1_00_19_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s06-02-S06_2_00_21_31.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Bounds`
- `Graph`
- `Landscape`
- `points`
- `transform`
- `good`
- `node`

### 创建 PCG Graph，把 PCG 组件或 PCG Volume 放入场景，确认图表能读取 Landscape 并在目标区域产生初始点（2）

**内容要点：**

- 本段调整小径两侧树带：在 Transform Points 中给 X 方向加入 -50 到 50 的偏移变化，调整 Bounds 到 40 增加树点数量，再加入 Spatial Noise，通过 contrast、scale 和 density 函数制造有树和无树的区域，避免路径两侧密度过于均匀。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s07-01-S07_1_00_23_29.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s07-02-S07_2_00_25_43.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `some`
- `trees`
- `noise`

### 用 Surface Sampler 从 Landscape 采样生成森林候选点，先用低密度调试点云，确认点落在地形表面而不是悬空或穿地

**内容要点：**

- 本段继续调树木比例并把节点整理成 `trees side of the path` 注释块：三种树分别设置不同 scale min/max。随后进入 seedlings 阶段，复用现有点或采样逻辑，在树木周围添加幼苗/小树，使主树和低层植被之间有过渡。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s08-01-S08_1_00_28_16.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s08-02-S08_2_00_30_25.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Grid`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `trees`
- `points`

### 用 Surface Sampler 从 Landscape 采样生成森林候选点，先用低密度调试点云，确认点落在地形表面而不是悬空或穿地（2）

**内容要点：**

- 本段完善幼苗点：增加点数量到 40，加入 Projection 节点把点投射回 Landscape，仅取高度，并用 Transform Points 加入 Z 轴随机旋转和 X/Y 轻微倾斜。这样幼苗不再悬空，也不会全部笔直重复。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s09-01-S09_1_00_32_55.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s09-02-S09_2_00_34_15.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Seed`
- `Graph`
- `Landscape`
- `points`

### 接入 Static Mesh Spawner 生成第一批树木，并通过 Mesh Entries、随机缩放、随机旋转和密度参数控制树种比例与分布

**内容要点：**

- 本段进入草地分支。先整理 seedlings 节点注释，然后准备 Megascans grass meshes，复制前面采样/过滤结构，建立 grass clumps 的生成链路，为森林地表增加第一层低矮草丛。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s10-01-S10_1_00_35_54.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s10-02-S10_2_00_37_17.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Point`
- `Seed`
- `Graph`
- `Landscape`
- `grass`
- `search`
- `axis`
- `bounce`

### 绘制或引用 Spline 小径 Actor，用 Spline Sampler / Get Spline Data 读取路径，设置 Actor Selection、Landscape 类选择和 Unbounded 等关键项

**内容要点：**

- 本段为草丛加入 Spatial Noise 和 Density Filter，降低草点数量并制造块状分布。随后使用 Execute Blueprint 节点和 `scale and density` Blueprint Element，让靠近路径的草缩小或降低密度，避免草丛侵入小径中心。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s11-01-S11_1_00_39_00.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s11-02-S11_2_00_41_12.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Bounds`
- `Density`
- `Graph`

### 绘制或引用 Spline 小径 Actor，用 Spline Sampler / Get Spline Data 读取路径，设置 Actor Selection、Landscape 类选择和 Unbounded 等关键项（2）

**内容要点：**

- 本段调小路径附近草的 scale 和 bounds，让靠近 path 的 grass clump 更低、更稀。之后开始制作 single grass 分支，改变 Surface Sampler seed，准备生成更细、更分散的单根草或小草束。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s12-01-S12_1_00_43_44.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s12-02-S12_2_00_44_57.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Grid`
- `Bounds`
- `Density`
- `Seed`
- `Graph`
- `grass`
- `point`

### 用 Spline 距离、Bounds Modifier、Difference、Density Filter 等节点从森林点云中清出小径空间，形成路面留白和边缘过渡

**内容要点：**

- 本段排查 single grass 点过大和分布异常：缩小 grid extents/cell size，降低 Bounds Modifier 的范围，把 Transform Points 的 offset mean/max 调整到更合适的值，再设置旋转和缩放，让单根草覆盖地表但不形成大块异常点。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s13-01-S13_1_00_46_31.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s13-02-S13_2_00_48_49.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Attribute`
- `Grid`
- `Bounds`
- `Density`
- `Graph`
- `Landscape`
- `node`

### 把路径相关点写入 Path 类型或密度属性，分离小径内部、小径边缘和森林主体，避免所有资产共享同一套点集

**内容要点：**

- 本段通过距离、Density 节点和不同 seed 修正草点分布。讲解中特别指出 seed 与 Attribute Noise 相同会导致结果异常，换 seed 后分布恢复；随后创建两类 single grass mesh，让草层次更丰富。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s14-01-S14_1_00_51_27.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s14-02-S14_2_00_53_29.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`

### 把路径相关点写入 Path 类型或密度属性，分离小径内部、小径边缘和森林主体，避免所有资产共享同一套点集（2）

**内容要点：**

- 本段处理草与树之间的关系。删除不必要的 Difference，因为允许草长在树附近；然后通过 Distance 节点按离树距离缩放点，让靠近树干的草更小或更稀，避免草与树根部穿插明显。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s15-01-S15_1_00_55_52.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s15-02-S15_2_00_58_05.jpg)


**参数、节点和风险点：**

- `PCG`
- `Blueprint`
- `Transform`
- `Point`
- `Spawn`
- `Grid`
- `Bounds`
- `Density`
- `Graph`
- `Landscape`

### 使用 Transform Points 调整小径两侧树木或灌木的偏移、旋转、缩放和密度，让植被沿路径边缘自然展开

**内容要点：**

- 本段进入 twigs 分支：复制草/点生成节点，删除不需要的 scale by density 和 distance，改变 Transform Points seed，调整 Density Filter lower bound 让树枝数量更多，再加入 Transform Points 和 Spawner 生成地面枝条。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s16-01-S16_1_01_00_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s16-02-S16_2_01_02_25.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Grid`
- `Density`
- `Seed`
- `Graph`

### 使用 Transform Points 调整小径两侧树木或灌木的偏移、旋转、缩放和密度，让植被沿路径边缘自然展开（2）

**内容要点：**

- 本段继续调 twigs：给 Transform Points 设置正负 offset，让枝条有左右分布，也允许部分枝条落在 path 上；随后复制同一套节点生成 leaves，改变 seed 和 density，让地面落叶成为独立分支。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s17-01-S17_1_01_04_32.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s17-02-S17_2_01_06_43.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Spawn`
- `Density`
- `Seed`
- `Graph`
- `leaves`
- `them`

### 加入草、灌木和低矮植被分支；每类资产单独控制密度、随机缩放、材质变化和排除范围，避免重复图案

**内容要点：**

- 本段完成 leaves 基础分支，设置 scale min/max 让落叶大小有变化，并把节点注释为 leaves。随后进入 rocks on the sides of the path，复用小径两侧树木的点逻辑，准备把岩石分布到路径边缘。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s18-01-S18_1_01_09_14.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s18-02-S18_2_01_10_40.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Spawn`
- `Graph`
- `scale`
- `some`

### 复用树木边缘逻辑生成岩石、树枝和地面杂物；用偏移和过滤保证这些物体主要出现在小径边缘和森林地表上

**内容要点：**

- 本段调整岩石 Spawner：关闭调试后观察岩石，增加 scale mean/max，给 Z 轴 offset 负值让岩石更贴近地表，再改变 Transform Points seed。之后开始给岩石或相关细节调整材质。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s19-01-S19_1_01_12_27.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s19-02-S19_2_01_14_33.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Seed`
- `Graph`
- `Material`
- `Landscape`
- `material`
- `minus`

### 复用树木边缘逻辑生成岩石、树枝和地面杂物；用偏移和过滤保证这些物体主要出现在小径边缘和森林地表上（2）

**内容要点：**

- 本段处理 Decal 材质边缘。作者复制 parent material 并编辑 opacity 部分，加入 radial gradient/mask，目的是软化 Decal 边缘，让贴地苔藓、落叶或污迹不出现硬边。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s20-01-S20_1_01_16_59.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s20-02-S20_2_01_19_00.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spawn`
- `Density`
- `Mask`
- `Material`
- `Instance`
- `radial`
- `gradient`

### 加入落叶、枝条、苔藓等地面细节，必要时使用 Decal 或 Mesh Renderer 区分覆盖层级，避免苔藓和树叶互相遮挡错误

**内容要点：**

- 本段限制哪些 Mesh 接收 Decal：关闭非目标 mesh 的 receive decal，只让路径边缘岩石接收。随后为 rocks 增加 random rotation、调整 scale 和 offset，并复用岩石点来散布苔藓/碎屑 Decal。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s21-01-S21_1_01_21_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s21-02-S21_2_01_22_58.jpg)


**参数、节点和风险点：**

- `PCG`
- `Mesh`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Random`
- `Graph`
- `scale`
- `decal`

### 加入落叶、枝条、苔藓等地面细节，必要时使用 Decal 或 Mesh Renderer 区分覆盖层级，避免苔藓和树叶互相遮挡错误（2）

**内容要点：**

- 本段在 Attribute Noise 后加入 Density Filter，移除一部分 Decal 点，避免苔藓或碎屑过密。之后复制 Decal 到项目 details 文件夹，调整 albedo/color overlay 和 overlay intensity，让 Decal 颜色更贴合场景。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s22-01-S22_1_01_24_53.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s22-02-S22_2_01_26_25.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Point`
- `Attribute`
- `Density`
- `Graph`
- `decals`
- `leaves`
- `duplicate`

### 调整 Landscape/土壤/路径材质，让路径区域、森林地表和细节资产在颜色、粗糙度和比例上保持一致

**内容要点：**

- 本段发现复用岩石点生成 leaves/twigs decal 会产生过多点，于是断开旧点，重新复制一套独立点源，调整采样范围、密度和 Transform，让落叶/树枝 Decal 不再和岩石分布完全一致。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s23-01-S23_1_01_28_16.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s23-02-S23_2_01_29_40.jpg)


**参数、节点和风险点：**

- `PCG`
- `Spline`
- `Transform`
- `Point`
- `Actor`
- `Spawn`
- `Grid`
- `Density`
- `Graph`
- `points`

### 使用 Execute Blueprint 或 Blueprint Element 时，确认输入点属性、执行上下文和输出结果都能被后续 PCG 节点正确消费

**内容要点：**

- 本段将 leaves/twigs Decal 分成两类：大叶片和小叶片。通过 Attribute Noise、Density Filter、invert filter 和两个 Spawn Actor 分支，把两类 Decal 分离生成，减少重复图案并增强地表层次。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s24-01-S24_1_01_31_23.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s24-02-S24_2_01_33_36.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Transform`
- `Point`
- `Attribute`
- `Actor`
- `Spawn`
- `Density`
- `Random`

### 使用 Execute Blueprint 或 Blueprint Element 时，确认输入点属性、执行上下文和输出结果都能被后续 PCG 节点正确消费（2）

**内容要点：**

- 本段解释 Decal sort order：苔藓 Decal sort priority 为 0，其他碎屑如果也为 0 可能被盖住；把 rock debris 或 leaves/twigs Decal 的 sort order 提高到 1，使它们能正确显示在苔藓上方。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s25-01-S25_1_01_36_09.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s25-02-S25_2_01_37_36.jpg)


**参数、节点和风险点：**

- `PCG`
- `Attribute`
- `Actor`
- `Spawn`
- `Density`
- `Seed`
- `Graph`
- `decal`
- `must`
- `decals`

### 整体检查 PCG 图表性能：Nanite、碰撞、实例数量、Cull Distance、密度过滤和调试节点要在大范围生成前先收敛

**内容要点：**

- 本段合并并整理 Decal 分支：检查碎屑是否在落叶下方或上方，关闭不需要的 debug，把 Mass/Decal 节点分组注释，重新启用各类 Static Mesh Spawner，整体查看森林小径效果。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s26-01-S26_1_01_39_22.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s26-02-S26_2_01_40_36.jpg)


**参数、节点和风险点：**

- `PCG`
- `Static Mesh`
- `Mesh`
- `Spawn`
- `Graph`
- `lighting`
- `under`
- `enable`
- `everything`
- `First`

### 建立灯光环境：Directional Light、Sky Light、Exponential Height Fog、Volumetric Fog 和 Post Process Volume 共同决定森林氛围

**内容要点：**

- 本段进入灯光和后处理。设置 EV100 min/max，使用 `r.raytracing.nanite.mode 1` 兼容 Nanite foliage 与 ray tracing；整理 Post Process Volume 到 lighting 文件夹，调整 Directional Light 色温、Volumetric Scattering，并开启 Volumetric Fog。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s27-01-S27_1_01_42_10.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s27-02-S27_2_01_43_43.jpg)


**参数、节点和风险点：**

- `PCG`
- `Actor`
- `Density`
- `Mask`
- `Landscape`
- `exposure`
- `parameters`
- `tweak`
- `First`

### 建立灯光环境：Directional Light、Sky Light、Exponential Height Fog、Volumetric Fog 和 Post Process Volume 共同决定森林氛围（2）

**内容要点：**

- 本段继续调 Post Process：设置 shadow contrast、highlight contrast、temperature、saturation、midtones gain，并检查 Skylight 需要 movable。目标是形成中午阳光下的森林氛围，同时避免画面过灰或过饱和。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s28-01-S28_1_01_45_37.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s28-02-S28_2_01_46_45.jpg)


**参数、节点和风险点：**

- `Actor`
- `Landscape`
- `think`
- `increase`
- `good`
- `contrast`
- `Under`
- `much`
- `around`
- `better`

### 根据镜头需求调整雾密度、曝光、色调、太阳方向和阴影，让小径读得清楚，远景不过曝或过黑

**内容要点：**

- 本段微调后期和雾：提高 toe、全局 contrast，降低 fog density 到 0.01/0.015 左右，并用 Ctrl+L 旋转太阳方向。此时灯光不追求电影级复杂调色，而是让森林路径和远景可读。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s29-01-S29_1_01_48_14.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s29-02-S29_2_01_49_32.jpg)


**参数、节点和风险点：**

- `Point`
- `Density`
- `good`
- `think`
- `select`
- `post`
- `process`
- `volume`
- `higher`
- `better`

### 根据镜头需求调整雾密度、曝光、色调、太阳方向和阴影，让小径读得清楚，远景不过曝或过黑（2）

**内容要点：**

- 本段创建 Niagara falling leaves 系统：用 blowing particles preset 新建 Niagara System，先在空 Basic Level 里测试；关闭 Sprite Renderer，改用 Mesh Renderer 或叶片 mesh，让粒子成为真实落叶效果。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s30-01-S30_1_01_51_10.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s30-02-S30_2_01_53_17.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Attribute`
- `Actor`
- `Spawn`
- `Random`
- `Landscape`
- `leaves`
- `level`
- `scale`
- `Niagara`

### 创建 Niagara 落叶或粒子系统，用 Mesh Renderer 或相关设置控制落叶实例，并保证粒子不会破坏主场景性能

**内容要点：**

- 本段把 falling leaves Niagara 放回主环境，移动到相机附近或需要的区域，并保存全部内容。随后进入渲染阶段，准备添加 Cine Camera、Sequencer 和 Movie Render Queue。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s31-01-S31_1_01_55_43.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s31-02-S31_2_01_56_56.jpg)


**参数、节点和风险点：**

- `Mesh`
- `Actor`
- `Spawn`
- `Random`
- `camera`
- `environment`
- `save`
- `drag`
- `good`
- `anywhere`

### 节点、参数和生成结果校验 32

**内容要点：**

- 节点、参数和生成结果校验 32。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s32-01-S32_1_01_58_29.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s32-02-S32_2_02_00_47.jpg)


**参数、节点和风险点：**

- `Actor`
- `Instance`
- `render`
- `sequence`
- `open`
- `them`
- `settings`
- `folder`
- `select`
- `MovieRenderQueue`

### **内容要点：**（2）

- 本段配置 Movie Render Queue：设置高质量 preset、screen percentage 150、anti-aliasing spatial samples 4、输出路径，并启用 render warmup/engine warmup。作者还发现落叶没有进入镜头，重新把 Niagara 放到相机附近，再渲染并导入 DaVinci Resolve 检查结果。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s33-01-S33_1_02_03_25.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s33-02-S33_2_02_05_28.jpg)


**参数、节点和风险点：**

- `PCG`
- `Landscape`
- `render`
- `local`
- `drag`
- `warmup`
- `anti`
- `aliasing`
- `accept`
- `forgot`

### 使用 Movie Render Queue 输出最终镜头，渲染前关闭临时 Debug、确认后处理、抗锯齿、分辨率和输出路径

**内容要点：**

- 本段补充两个收尾问题：如果地平线太空，可以扩展或雕刻 Landscape 边缘，再把 PCG 放回场景；如果边缘地形导致树木倾斜，要把主树 Transform Points 的 rotation 设为 absolute。最后说明竖屏输出流程：复制相机和 Sequence，交换 sensor width/height，并在 Movie Render Queue 设置 1080x1920。


**关键截图：**

![关键截图 1](assets/ue56-pcg-forest-trail-environment/s34-01-S34_1_02_07_51.jpg)
![关键截图 2](assets/ue56-pcg-forest-trail-environment/s34-02-S34_2_02_09_41.jpg)


**参数、节点和风险点：**

- `PCG`
- `Transform`
- `Point`
- `Landscape`
- `camera`
- `render`
- `vertical`
- `output`
- `landscape`
- `edges`

## 复现检查清单

- Spline 小径和 PCG 采样必须处在同一坐标空间；如果路径清空区域偏移，先检查 Actor Selection、Spline Data 和 Landscape 投射。
- 道路留白不要只靠硬删除点，边缘最好通过距离、密度或过渡分支处理，否则小径两侧会显得像被直线裁掉。
- 树、草、岩石、落叶和苔藓要分支控制密度与随机性，不要把所有资产塞进同一个 Spawner。
- Nanite 资源、实例数量、碰撞、阴影和 Cull Distance 是长场景性能风险；每次新增一类资产后都要重新检查帧率和生成耗时。
- 灯光、雾和后处理应在资产布局稳定后再精调；过早调色会掩盖点云密度、材质比例和遮挡问题。
- 复现时先固定随机种子，再调整密度、过滤和生成资源，避免随机结果掩盖逻辑错误。


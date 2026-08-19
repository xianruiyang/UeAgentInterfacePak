# 12-2 制作Niagara粒子特效

# 12-2 制作Niagara粒子特效

## 关键术语

- `Alpha`、`GPU`、`Material`、`Actor`、`粒子`、`发射器`、`渲染器`、`精灵`、`网格`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Particle Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:01-00:04:43 GPU、发射器、渲染器

- 本段定位：GPU、发射器、渲染器。
- 知识点：这感觉可能会好一点 现在感觉展开了好多 展开的感觉还不错 这第二个做的颜色调有点 感觉饱和度太高了 尽量靠近一点白色 需要适当调整一下颜色。
- 知识点：用浮动的成法 向量再反挥 让白色感觉更加突出 然后用笔记背 从2.3开始感觉减少 这种快速消失的感觉 自然多了 而且第二个做的水彩 需要把混合模式改为加法。
- 知识点：希望能更好地混合 因为这是我们做的元素 感觉更加柔和更好了 有点紧张的感觉 适当慢了一点 这个要尝试加上冰网隔 尽管这样有点慢的感觉 需要调整一下。
- 知识点：重新保存 我们就从添加发射器开始 需要叫它I-Smash 首先确认一下精灵渲染器的 纹理样本是否正常。
- 知识点：再转到网格 使用样本纹理模块时 必须确保仅通过GPU操作 因此请打开GPU模块 冰块网格会有一点延迟 所以打开延迟 来操作 先行数量 如果应用到网格上。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`GPU`、`纹理`、`发射器`、`渲染器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `03_Ice_Explosion` 关卡播放后效果确认
> - 组成部分: Level Viewport + Content Browser + Outliner + Floor Details + 下方 Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01` Niagara System。
> - 目的: 记录 p15 完成后的初始观察状态，作为 p16 添加冰网格 emitter 前的视觉基准。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色位于棋盘地面中部，仅角色附近有淡淡雾状残留和小亮点。
> - 大面积蓝白冰爆已消散，地面格线清晰可见。
>
> Outliner / Details:
> - 世界为 `03_Ice_Explosion`。
> - `Floor` 被选中。
> - `Floor` Transform: Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
> - Static Mesh 字段显示 `SM_Template_M...`。
>
> Content Browser:
> - 当前搜索 `Texture`，可见 `T_Radial...`、`T_Rock...`、`T_Soft...`、`T_Streak...`、`T_Wave...` 等贴图。
>
> 画面含义: 该帧记录添加 `Ice_Mesh_01` 前，现有 Decal/Glow/Mesh 效果播放后的轻量残留状态。
> 图表转写（UE-GTXT v4）
> - 类型: `Exp_01` 调试窗口展开前的关卡效果确认
> - 组成部分: Level Viewport + Floor Details + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01`。
> - 目的: 对已有冰爆效果做二次观察，确认后续新增 emitter 的对比起点。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色附近可见很少量半透明雾状残留。
> - 没有大面积冰刺或网格粒子覆盖。
>
> 下方 Niagara 窗口:
> - 标签可见 `Exp_01`、`M_Decal_01_Ins_02`、`M_Mesh_v01_Ins_01`、`M_Mesh_v01_Ins_02`。
> - 底部区域露出 `System Overview`，其中可见 `Mesh_01` 和 `Mesh_01001` emitter 头部。
>
> Floor Details:
> - `Floor` 仍被选中。
> - Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
>
> 画面含义: 该帧记录当前效果“更柔和”的观察状态，同时显示即将切回 Niagara System 进行新 emitter 配置。
> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Initialize Particle` 初始参数
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01` GPU emitter。
> - 目的: 新增冰网格粒子 emitter，并设置基础生命周期与精灵尺寸以便后续采样纹理和网格渲染。
>
> Niagara Preview:
> - 左侧预览显示一个倾斜的白色点阵平面。
> - `Particle Counts` 中 `Ice_Mesh_01` 为 `2500 Current, 2500 Max (est.)`，状态 `Inactive`。
>
> System Overview:
> - 可见 `Decal` emitter 和新增 `Ice_Mesh_01` emitter。
> - `Ice_Mesh_01` 标记为 `GPU`。
> - `Ice_Mesh_01` Stack 包含 `Emitter State`、`Spawn Particles in Grid`、`Initialize Particle`、`Grid Location`、`Sprite Renderer`。
> - `Initialize Particle` 被选中。
>
> Details:
> - Owner: `Ice_Mesh_01`。
> - `Lifetime Mode = Direct Set`。
> - `Lifetime = 5.0`。
> - `Color Mode = Unset`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 未启用，值为 `0.0, 0.0, 0.0`。
> - `Sprite Size Mode = Uniform`。
> - `Uniform Sprite Size = 10.0`。
> - Mesh/Ribbon 相关属性为 Unset。
>
> 画面含义: 该帧记录 `Ice_Mesh_01` 创建后的基础粒子参数，先以 Sprite/点阵方式检查 GPU 网格生成。

### 00:04:43-00:09:27 Actor、粒子、渲染器

- 本段定位：Actor、粒子、渲染器。
- 知识点：自动生成了 生命周期暂时设置为2秒 视眼天一亮 大约-5 先取出重新安装样本纹理 纹理 后续会使用这个地图 这个纹理是。
- 知识点：现在这个纹理累积 我提前制作了这个边缘形状 只进行剪裁 纹理外扩的部分 适当加了一些剪边降掉 这样冰的网格 也会有一定的调色适用 所以将使用这个纹理。
- 知识点：我在多人游戏上 有些不太顺利 这样进行使用 音频有时会有些空白 请多多理解 有时需要瞬间判断 这样做了 现在将第一小时学到的UA部分 拿来用。
- 知识点：Make Factor 2D制作 然后获取位置进行使用 这里也Make From Vector 标准化位置 是的,这样生成得很狠 现在是复制 所以看起来像是埋在下面。
- 知识点：确实区域大小似乎不太匹配 所以需要适当增加这个维度 可以理解为增加两倍 本来应该是 100x100 但如果做成100x100 粒子生成会变得太多。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`、`渲染器`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Initialize Particle` 生命周期与偏移调整
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01` GPU emitter。
> - 目的: 缩短新冰网格粒子的生命周期，并启用位置偏移字段，为后续放置到冰爆区域做准备。
>
> Details:
> - Owner: `Ice_Mesh_01`。
> - `Lifetime Mode = Direct Set`。
> - `Lifetime = 2.0`。
> - `Color Mode = Unset`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 已启用。
> - `Position Offset` 可见值为 `0.0, 0.0, 0.0`。
> - `Position Offset Coordinate Space = Simulation`。
> - `Uniform Sprite Size = 10.0`。
>
> System Overview:
> - `Ice_Mesh_01` Stack 中 `Initialize Particle` 仍被选中。
> - `Spawn Particles in Grid`、`Grid Location`、`Sprite Renderer` 保持在该 emitter 中。
>
> Timeline:
> - 当前时间约 `2.57` 秒。
> - `Decal` 轨道处于绿色片段末端附近。
>
> 画面含义: 该帧记录 `Ice_Mesh_01` 生命周期从初始长时间改为 `2.0`，并打开偏移字段以便后续定位。
> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01` 采样纹理叠加后的关卡预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Floor Details + Niagara Details 边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Ice_Mesh_01`。
> - 目的: 观察 `Sample Texture` 后的白蓝冰雾扩散区域和粒子数量。
>
> Level Viewport:
> - 角色位于大面积白蓝冰雾中心。
> - 冰雾呈圆形外扩，外缘柔和、局部呈水彩状。
> - 中心偏白，外围出现浅蓝阴影和半透明渐变。
>
> Niagara 边缘信息:
> - 下方 Details 区域选中 `Ice_Mesh_01`。
> - 可见 `2,500 Particles`。
> - Stack 区域显示 `Sample Texture` 模块。
>
> Content Browser:
> - 当前搜索 `Texture`，可见 `T_Radial...`、`T_Rock...`、`T_Soft...`、`T_Streak...`、`T_Wave...` 等纹理资源。
>
> Floor Details:
> - `Floor` 被选中，Transform 仍为 Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
>
> 画面含义: 该帧记录 `Ice_Mesh_01` 通过纹理采样生成大面积冰雾遮罩后的初步效果。
> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Mesh Renderer` 设置
> - 组成部分: Niagara Preview + System Overview + Mesh Renderer Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01` GPU emitter。
> - 目的: 将采样粒子从 Sprite 检查切换为冰刺网格渲染。
>
> Niagara Preview:
> - 预览中冰雾环上叠加大量浅蓝冰刺。
> - 中央存在较暗空洞，外围为白蓝雾状扩散。
> - `Particle Counts` 中 `Ice_Mesh_01` 显示 `116 Current, 2500 Max (est.)`，状态 Active。
>
> System Overview:
> - `Ice_Mesh_01` emitter 包含 `Spawn Particles in Grid`、`Initialize Particle`、`Grid Location`、`Sample Texture`、`Kill Particles`、`Mesh Renderer`。
> - `Sprite Renderer` 在 Render 下方可见但未作为当前选中项。
> - `Mesh Renderer` 被选中。
>
> Mesh Renderer Details:
> - Meshes: `1 Array element`。
> - Index `[0]` Mesh: `SM_Ice_Spikes`。
> - Scale: `1.0, 1.0, 1.0`。
> - Rotation: `0.0, 0.0, 0.0`。
> - Pivot Offset: `0.0, 0.0, 0.0`。
> - Override Materials: Index `[0]`，Explicit Material = `M_Ice_01`。
> - Source Mode = `Particles`。
> - Facing Mode = `Default`。
> - Sort Mode = `None`。
>
> 画面含义: 该帧记录冰网格 emitter 使用 `SM_Ice_Spikes` 和 `M_Ice_01` 渲染，形成叠加在冰雾环上的冰刺层。

### 00:09:27-00:14:10 速度、曲线

- 本段定位：速度、曲线。
- 知识点：还有 皮肤偏移 给了父母的指 从下面中心适当 往下移 皮肤中心适当下移了 基本上我们是 在面部模式调整到速度。
- 知识点：在这里添加速度 适当远离中心的时候 朝向调整成放射状 无论如何下面更新的地方 我们就用这个比例进行控制 这个速度就是用来定方向的。
- 知识点：向上的视角完成了 将中心点改为点 从这个点来看 大约是45度的 对齐就完成了 先调整一下大小 用random uniform 生成1.5。
- 知识点：2.8 2.8 2.5 2.5 2.6 希望适当像刺一样突出 给了这种感觉的随机值 方向似乎调整得不错 然后在这里先用比例速度。
- 知识点：控制不让它动 乘以浮点向阳瞬间出现 然后在0.1时速度 立刻消失 如果完全没有就会失去方向性 是这种感觉做的 现在似乎有些发光 但在生成时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Mesh Renderer` Pivot Offset 调整
> - 组成部分: Niagara Preview + System Overview + Mesh Renderer Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01`。
> - 目的: 调整冰刺网格枢轴偏移，让冰刺相对采样区域产生更合适的突出形态。
>
> Niagara Preview:
> - 冰刺层比上一阶段更明显，多个尖刺从蓝白雾环内外穿出。
> - 中央仍有暗色空洞，外圈保持白蓝扩散。
> - `Ice_Mesh_01` 显示 `116 Current, 2500 Max (est.)`，状态 Active。
>
> Mesh Renderer Details:
> - Mesh: `SM_Ice_Spikes`。
> - Scale: `1.0, 1.0, 1.0`。
> - Rotation: `0.0, 0.0, 0.0`。
> - Pivot Offset: `-5.0, 0.0, 0.0`。
> - Pivot Offset Space = `Mesh`。
> - Explicit Material = `M_Ice_01`。
> - Source Mode = `Particles`。
> - Facing Mode = `Default`。
>
> System Overview:
> - `Ice_Mesh_01` 仍为 GPU emitter。
> - `Mesh Renderer` 被选中，前置模块包括 `Grid Location`、`Sample Texture`、`Kill Particles`。
>
> 画面含义: 该帧记录通过 Mesh Renderer 的 Pivot Offset 改变冰刺网格相对粒子采样点的位置。
> 图表转写（UE-GTXT v4）
> - 类型: 冰刺网格方向与整体效果预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Ice_Mesh_01`。
> - 目的: 在关卡视角中检查冰刺网格叠加后的方向、密度和颜色。
>
> Level Viewport:
> - 角色站在白蓝冰雾中心。
> - 冰刺围绕角色形成圆环状扩散，尖刺向外侧突出。
> - 冰刺颜色以浅青、浅蓝和白色为主，中心区域较白。
> - 地面格线仍在外圈可见，说明效果仍保持半透明叠加。
>
> Content Browser:
> - 当前位于 `Content/Coloso_Second/Material/03`。
> - 可见资源包括 `M_Decal_...`、`M_Ice_01`、`M_Mesh...` 等材质/材质实例。
> - `M_Ice_01` 被选中。
>
> Outliner:
> - 世界为 `03_Ice_Explosion`。
> - 可见 `Lighting`、`DirectionalLight`、`01_Swing_Trail`、`Aurora`、`Cine Camera Actor`、`Exp01`。
>
> 画面含义: 该帧记录冰刺方向调整后的关卡整体效果，冰刺层已经和原冰雾/Decal 层形成明显组合。
> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Scale Mesh Size` 与速度模块
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01`。
> - 目的: 用曲线控制冰刺网格尺寸快速生成，同时配置线性速度和从点发散速度模块。
>
> Niagara Preview:
> - 冰刺围绕中心形成明亮圆环，中心留有暗色空洞。
> - 外圈冰刺细长、浅青白，沿环状区域突出。
> - `Ice_Mesh_01` 显示 `116 Current, 2500 Max (est.)`，状态 Active。
>
> System Overview:
> - `Ice_Mesh_01` Stack 中 Particle Spawn 包含 `Initialize Particle`、`Grid Location`、`Sample Texture`、`Kill Particles`。
> - Particle Update 包含 `Particle State`、`Scale Mesh Size`、`Scale Velocity`、`Solve Forces and Velocity`。
> - `Add Velocity Linear` 与 `Add Velocity 001 From Point` 显示在 `Particle State` 上方。
> - `Mesh Renderer` 启用，`Sprite Renderer` 未启用。
>
> Scale Mesh Size Details:
> - `Scale Factor = Make Vector`。
> - X 使用 `Float from Curve`。
> - X 曲线索引为 `PARTICLES NormalizedAge`。
> - X 曲线从约 `0.2` 快速上升到 `1.0`，在接近 `0.5` 生命周期前后达到并保持 `1.0`。
> - Y = `1.0`。
> - Z = `1.0`。
>
> Timeline:
> - 当前时间约 `0.68` 秒。
> - `Decal` 轨道仍位于绿色片段中。
>
> 画面含义: 该帧记录冰刺网格的快速缩放曲线，并展示速度模块已加入，用于控制生成后方向和运动感。

### 00:14:10-00:18:50 Material、颜色

- 本段定位：Material、颜色。
- 知识点：有种瞬间出现的感觉 感觉很好 而且现在颜色也太深了 需要再做一个渐变色 渐变色 即使不提供图形 也会接近白色调 然后我们打开material。
- 知识点：适当修改一下 之前做的material 需要这样做 首先普通部分希望感觉更强一些 现在感觉好像更好了 原本有些定位 原本有些地方感觉不太明显。
- 知识点：这个部分我们再改回 试试看 这个感觉更明显了 好像因为太细致 所以不太明显 希望颜色再适当偏白一点。
- 知识点：会不会适当提高一些阴影 现在感觉色调更接近了 然后这个也试着上下交换一下 这个感觉有些单调 在这种感觉下 图像的颜色部分。
- 知识点：如果能更突出就好了 需要一个一个地提高0 现在有点闪烁的那种感觉 感觉好像 适当能感受到 有点粗糙的感觉 在这个程度的感觉下 先看看吧 感觉扩散的感觉似乎有点长。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Ice_01` 调色后的关卡预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡、`Exp_01 / Ice_Mesh_01`。
> - 目的: 检查冰刺材质颜色偏白后与冰雾层的组合效果。
>
> Level Viewport:
> - 角色位于蓝白冰刺环中心。
> - 冰刺层围绕角色形成圆形扩散，尖刺颜色为浅青、浅蓝和白色。
> - 冰雾底层仍保留柔和白蓝扩散，外圈地面格线可见。
>
> Content Browser:
> - 位于 `Content/Coloso_Second/Material/03`。
> - 可见 `M_Decal...`、`M_Ice_01`、`M_Mesh...` 等资源。
> - `M_Ice_01` 被选中。
>
> Niagara 窗口边缘:
> - 下方可见 `Exp_01` System Overview，`Ice_Mesh_01` 处于当前调试上下文。
> - Details 边缘显示 `Ice_Mesh_01`，粒子数为 `116 Particles`。
>
> 画面含义: 该帧记录冰刺材质调色后，整体更接近白色冰晶的关卡效果。
> 图表转写（UE-GTXT v4）
> - 类型: 冰刺材质/尺寸效果放大观察
> - 组成部分: Level Viewport + Sequencer 窗口边缘 + Content Browser + Outliner
> - 所属: `03_Ice_Explosion` 关卡。
> - 目的: 检查冰刺变亮、变细密后的视觉可读性。
>
> Level Viewport:
> - 角色位于冰刺环内侧。
> - 冰刺非常长且密集，从中心周围向外形成放射状轮廓。
> - 颜色以白色和浅青为主，局部有淡蓝阴影。
> - 中心冰雾较亮，外圈冰刺边缘更尖锐。
>
> Sequencer 边缘:
> - 下方可见 `Sequencer` 窗口，帧率为 `30 fps`。
> - 时间线位于约 `0050` 附近，`03_Ice_Explosion` 序列正在被观察。
>
> Content Browser:
> - 仍位于 Material/03，`M_Ice_01` 被选中。
>
> 画面含义: 该帧记录冰刺细节过密、整体亮度较高的中间效果，用于判断是否需要进一步调整材质明暗。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Ice_01` Material Graph 调试上下文
> - 组成部分: Level Viewport + Material Graph 窗口边缘 + Content Browser + Outliner
> - 所属: `M_Ice_01` 材质与 `03_Ice_Explosion` 关卡。
> - 目的: 标记进入 `M_Ice_01` 材质图后，关卡视口中效果播放结束或大面积冰刺消散的状态。
>
> Level Viewport:
> - 角色位于棋盘地面中央附近。
> - 大面积冰刺和冰雾已经消失，仅角色头部附近有轻微亮雾。
> - 地面格线清晰可见。
>
> Material Graph 边缘:
> - 下方窗口标签为 `M_Ice_01`。
> - 工具栏可见 `Home`、`Hierarchy`、`Live Update`、`Clean Graph`、`Preview State`、`Hide Unrelated`、`Stats`。
> - 标题区域显示 `M_Ice_01 > Material Graph`。
> - 材质图主体仅露出顶部边缘，内部节点连接不可完整读取。
>
> Content Browser:
> - `M_Ice_01` 在 Material/03 中仍为选中资源。
>
> 画面含义: 该帧记录材质图调试入口和播放后消散状态，不能从该截图补写材质内部节点。

### 00:18:50-00:22:06 Alpha、渲染器、生命周期

- 本段定位：Alpha、渲染器、生命周期。
- 知识点：大约1.2秒 那部分似乎负责余韵 感觉更像是单独添加的 感觉1.2秒会更好 这个消息突出的感觉 这个消息突出的感觉非常强烈 感觉似乎更好。
- 知识点：先保存一次 这些消息出来得很好 消息到一定程度上 已经制作完成 需要尝试添加光 这个在电脑上发生错误 需要删除并重新制作 高度值设置为100。
- 知识点：其余的现在 制作光渲染器 打开亮度 然后需要从这里获取光选项 无线电数量大约是100 散射大约是10G 然后写下颜色。
- 知识点：我的图表中 Alpha的亮度可以被控制 但只是适当快一点的时候 生命周期大约是3秒左右。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`渲染器`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Mesh_01.Initialize Particle` 生命周期与 Mesh Scale
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Mesh_01`。
> - 目的: 调整已有 Mesh 粒子的生命周期和位置偏移，使余韵更短并配合冰刺层。
>
> Niagara Preview:
> - 左侧预览为白色冰刺环，中心留有暗色空洞。
> - `Ice_Mesh_01` 显示 `116 Current, 2500 Max (est.)`，状态 Inactive。
> - `Mesh_01` 与 `Mesh_01001` 显示 Complete。
>
> System Overview:
> - `Mesh_01` 和 `Mesh_01001` 两个 emitter 可见。
> - `Mesh_01.Initialize Particle` 被选中。
>
> Details:
> - Owner: `Mesh_01`。
> - `Lifetime Mode = Direct Set`。
> - `Lifetime` 字段约为 `1.3`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 启用，值为 `0.0, 0.0, 10.0`。
> - `Position Offset Coordinate Space = Simulation`。
> - `Mesh Scale Mode = Uniform`。
> - `Mesh Uniform Scale = 0.45`。
>
> 画面含义: 该帧记录调整 Mesh 粒子寿命和 Z 偏移，使它作为冰爆余韵层参与叠加。
> 图表转写（UE-GTXT v4）
> - 类型: `Light_01` emitter 编译失败状态
> - 组成部分: Niagara Preview + System Overview + Emitter Properties Details + Timeline
> - 所属: `Exp_01 / Light_01`。
> - 目的: 新建或编辑 Light emitter 时检查 Light Renderer，但当前截图显示编译失败。
>
> Niagara Preview:
> - 左侧显示 `Compilation Failed!`。
> - 当前预览未正常运行。
>
> System Overview:
> - 选中 emitter 为 `Light_01`。
> - `Light_01` 标记为 CPU。
> - Stack 中可见 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Set PARTICLES LightRadius/LightExponent/LightVolumetricScattering`、`Particle State`、`Scale Color`、`Light Renderer`。
> - `Light Renderer` 在 Render 下启用。
>
> Details:
> - Owner: `Light_01`。
> - `Local Space` 启用。
> - `Interpolated Spawning` 启用。
> - `Sim Target = CPUSim`。
> - `Calculate Bounds Mode = Dynamic`。
> - Emitter State: `Life Cycle Mode = Self`。
> - `Inactive Response = Complete (Let Particles Finish then ...)`。
> - `Loop Behavior = Once`。
> - `Loop Duration Mode = Fixed`。
> - `Loop Duration = 1.0`。
>
> 画面含义: 该帧记录 Light emitter 初建阶段出现编译失败，同时保留 Light Renderer 和生命周期设置证据。
> 图表转写（UE-GTXT v4）
> - 类型: `Empty.Scale Color` 基础亮度控制
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Empty` light emitter。
> - 目的: 通过 Scale Color 控制 Light Renderer 的 RGB 与 Alpha 基础值。
>
> Particle Counts:
> - `Empty` 显示 `0 Current, 0 Max (est.)`，状态 Active。
> - `Ice_Mesh_01` 显示 Complete。
>
> System Overview:
> - `Empty` emitter 被选中。
> - Stack 中包含 `Initialize Particle`、`Set PARTICLES LightRadius`、`LightExponent`、`LightVolumetricScattering`、`Particle State`、`Scale Color`、`Light Renderer`。
> - `Light Renderer` 启用。
> - `Scale Color` 被选中。
>
> Details:
> - Owner: `Empty`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB = Multiply Vector by Float`。
> - Vector = `1.0, 1.0, 1.0`。
> - Float = `1.0`。
> - `Scale Alpha = 1.0`。
>
> Timeline:
> - `Empty` 轨道为长蓝色片段。
> - 当前时间约 `4.85` 秒。
>
> 画面含义: 该帧记录 Light emitter 的初始颜色缩放仍为白色基础值，Alpha 固定为 1。

### 00:22:09-00:25:32 网格、颜色、贴图

- 本段定位：网格、颜色、贴图。
- 知识点：我觉得可以适当柔和一点 颜色 就这样我们试试看吧 现在灯光没有设置好 是的正在出现 灯光再进来 这3S的颜色感觉完全不同了。
- 知识点：这个贴图部分现在也在接受光线 能善用下面这些也是个好方法 这样一来这个形状 绿色就有点显现出来了 这个感觉应该还不错 希望成年网格能有随机的旋转。
- 知识点：用方向向量进行定位 应该是反向 先这样 因为在S轴上是对齐的 先在Z轴上旋转。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`贴图`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Empty.Scale Color` Alpha 衰减曲线
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Empty` light emitter。
> - 目的: 让 Light Renderer 的 Alpha 随生命周期从亮到暗衰减。
>
> System Overview:
> - `Empty` emitter 被选中。
> - Stack 中 `Scale Color` 被选中。
> - `Light Renderer` 启用。
>
> Details:
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB = Multiply Vector by Float`。
> - RGB Vector = `1.0, 1.0, 1.0`。
> - RGB Float = `1.0`。
> - `Scale Alpha = Float from Curve`。
> - Alpha 曲线索引为 `PARTICLES NormalizedAge`。
> - 曲线从接近 `1.0` 随生命周期下降到 `0.0`，中后段逐渐变缓。
>
> Timeline:
> - `Empty` 轨道为长蓝色片段。
> - 当前时间约 `3.96` 秒。
>
> 画面含义: 该帧记录光亮度通过 Alpha 曲线衰减，避免 Light 在全生命周期内保持固定亮度。
> 图表转写（UE-GTXT v4）
> - 类型: `Empty.Scale Color` 高强度蓝白光设置
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Empty` light emitter。
> - 目的: 提高 Light Renderer 的 RGB 强度，并继续用 Alpha 曲线控制消退。
>
> Niagara Preview:
> - 左侧预览显示冰刺环仍可见，中心为暗空洞。
> - `Empty` 显示 `1 Current, 1 Max (est.)`，状态 Active。
>
> Details:
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB = Multiply Vector by Float`。
> - RGB Vector = `3.0, 4.0, 10.0`。
> - RGB Float = `50000.0`。
> - `Scale Alpha = Float from Curve`。
> - Alpha 曲线从接近 `1.0` 下降到 `0.0`，由 `PARTICLES NormalizedAge` 驱动。
>
> System Overview:
> - `Empty.Scale Color` 被选中。
> - Stack 中保留 `Set PARTICLES LightRadius/LightExponent/LightVolumetricScattering` 和 `Light Renderer`。
>
> 画面含义: 该帧记录 Light emitter 的颜色强度提高到偏蓝白的高亮值，并通过 Alpha 曲线逐渐衰减。
> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Initial Mesh Orientation`
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01` GPU emitter。
> - 目的: 设置冰刺网格初始朝向，使网格按指定向量对齐。
>
> Particle Counts:
> - `Ice_Mesh_01` 显示 `0 Current, 2500 Max (est.)`，状态 Complete。
> - `Empty` 显示 `1 Current, 1 Max (est.)`，状态 Active。
>
> System Overview:
> - `Ice_Mesh_01` Stack 中新增或选中 `Initial Mesh Orientation`。
> - 其上方可见 `Add Velocity Linear`、`Add Velocity 001 From Point`。
> - 其下方可见 `Scale Mesh Size`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Mesh Renderer`。
>
> Details:
> - `Mesh Orientation Mode = Orient to Vector`。
> - `Orientation Vector = 0.0, 0.0, -1.0`。
> - `Orientation Coordinate Space = Simulation`。
> - `Mesh Axis To Orient = 1.0, 0.0, 0.0`。
> - Rotation 区域未启用，Rotation 值显示 `0.0, 0.0, 0.0`。
>
> Timeline:
> - 当前时间约 `7.76` 秒。
> - `Empty` 轨道为蓝色长片段。
>
> 画面含义: 该帧记录冰刺网格朝向从模块层面改为由向量控制，并指定对齐的网格轴。

### 00:25:48-00:30:14 网格、速度、颜色

- 本段定位：网格、速度、颜色。
- 知识点：再用方向向量对齐一次 在这个S轴上 再用方向向量对齐一次 在这个状态下获取随机值 放进去了 用Random Managing Map在X轴上。
- 知识点：放随机值 以这个轴为基准 适当使方向不同 感觉有点像是 同样的纹理太多 所以只加了这个 如果有些人觉得太像刺的感觉 调整一下 扩大也可以试试看。
- 知识点：可以尝试给予更多的厚度感 这现在可能适当买下去 适当买下去比较好 位置值从眼中出来的感觉 再高一点可能会更好 如果觉得方向太倾斜的话 适当调低一点也不错。
- 知识点：这个感觉更好一些 那么冰网格添加到完成状态了 那么现在附加元素碎片之类的 像是那种火花的小颗粒的感觉 烟雾一起出来 有些若隐若现的感觉。
- 知识点：像是那种火花的小颗粒的感觉 烟雾一起出来 有些若隐若现的感觉 加上这个会更好 从烟雾那部分开始看看 第二个例子就是使用过的烟雾 资源会照原样使用。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`速度`、`颜色`、`烟雾`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Ice_Mesh_01.Initial Mesh Orientation 001` 旋转设置
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Ice_Mesh_01` GPU emitter。
> - 目的: 继续调整冰刺网格朝向，使同一网格实例产生更多方向差异。
>
> Particle Counts:
> - `Ice_Mesh_01` 显示 `0 Current, 2500 Max (est.)`，状态 Complete。
> - `Empty` 显示 Active。
>
> System Overview:
> - `Ice_Mesh_01` Stack 中选中 `Initial Mesh Orientation 001`。
> - 该模块显示模式标签 `None`。
> - 上方可见 `Add Velocity Linear`、`Add Velocity 001 From Point`。
> - 下方可见 `Initial Mesh Orientation Vector`、`Initial Mesh Orientation 002 None`、`Scale Mesh Size`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Mesh Renderer`。
>
> Details:
> - `Mesh Orientation Mode = None`。
> - Rotation 启用。
> - Rotation 值为 `0.0, -0.25, 0.0`。
> - `Rotation Coordinate Space = Mesh`。
> - 鼠标提示说明该模块用于直接设置网格朝向，不同于基于物理的旋转力/速度模块。
>
> Timeline:
> - 当前时间约 `4.56` 秒。
>
> 画面含义: 该帧记录 `Ice_Mesh_01` 在向量朝向之外又添加一个旋转朝向模块，用于调整冰刺方向变化。
> 图表转写（UE-GTXT v4）
> - 类型: 冰刺网格完成状态关卡预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Ice_Mesh_01`。
> - 目的: 检查冰网格完成状态的整体厚度、方向和颜色。
>
> Level Viewport:
> - 角色位于冰爆中心。
> - 白蓝冰雾铺满中心区域，周围有大量长冰刺向外形成圆环。
> - 冰刺颜色以白色和浅青为主，亮度较高。
> - 冰雾底部带有柔和蓝色阴影，外圈仍能看到地面格线。
>
> Content Browser:
> - 位于 `Content/Coloso_Second/Material/03`。
> - `M_Ice_01` 被选中。
>
> Niagara 窗口边缘:
> - 下方显示 `Exp_01` 和 `Ice_Mesh_01` 调试上下文。
> - Details 边缘选中 `Ice_Mesh_01`。
>
> 画面含义: 该帧记录冰网格添加完成后的关卡效果，冰刺层已与原冰雾、Decal、Light 形成完整组合。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Scale Velocity` 烟雾速度衰减
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Smoke_01` emitter。
> - 目的: 在冰爆完成后加入烟雾层，并用速度缩放曲线控制烟雾由快到慢的扩散。
>
> Niagara Preview:
> - 左侧预览为高亮白蓝冰爆，外围可见冰刺，中心亮度很高。
> - `Particle Counts` 中 `Smoke_01` 显示 `20 Current, 20 Max (est.)`，状态 Active。
> - `Ice_Mesh_01` 显示 `2500 Current, 2500 Max (est.)`，状态 Active。
> - `Decal`、`Glow_01`、`Glow_02`、`Mesh_01`、`Mesh_01001` 和 `Empty` 也为 Active。
>
> System Overview:
> - 可见 `Ice_Mesh_01` 与新增 `Smoke_01` emitter。
> - `Smoke_01` Stack 包含 `Initialize Particle`、`Shape Location Ring / Disc`、`Add Velocity From Point`、`Particle State`、`Sub UV Animation Linear`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
> - `Scale Velocity` 被选中。
>
> Details:
> - Owner: `Smoke_01`。
> - `Coordinate Space = Local`。
> - `Velocity Scale = Multiply Vector by Float`。
> - Vector = `1.0, 1.0, 1.0`。
> - Float 使用 `Float from Curve`。
> - 曲线由 `PARTICLES NormalizedAge` 驱动。
> - Float 曲线从约 `7.0` 逐步下降到 `0.0`，前段下降较快，后段趋近 0。
>
> Timeline:
> - 当前时间约 `0.18` 秒。
> - Decal 轨道位于早期绿色片段。
>
> 画面含义: 该帧记录在冰刺完成后加入烟雾 emitter，并通过速度衰减曲线让烟雾从快速扩散转为缓慢消散。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


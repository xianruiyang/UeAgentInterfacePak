# 03 Magic Projectiles

# 03 Magic Projectiles

## 关键术语

- `Emitter`、`Alpha`、`GPU`、`CPU`、`UV`、`Texture`、`粒子`、`系统`、`速度`、`Niagara`、`颜色`、`Niagara System`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`

## 分段知识

### 00:00:05-00:05:04 UV

- 本段定位：UV。
- 知识点：在这一集需要在等级中制作一张阶段 在里面需要调整个角色的动作 然后需要慢慢地进入准备效果的准备 就是预测的部分 我现在在阶段的。
- 知识点：folder 需要制作 需要把阶段转到等级 我们还可以把演员加进去 让可以从等级中进入 我们还可以调整等级 例如提升光度 在后处执行时提升。
- 知识点：调整阶段 也会设置在这里 像这个你也可以改变它 任何你想要的 可以制作一个镜头 可以加一个镜头演员 或者可以拿这个 然后把它转到准备器。
- 知识点：可以设置一个镜头 可以制作一个上层观点 我真的喜欢从上层观点 可以试试旁边观点 可以调整阶段 像这个也有不同的预测 例如可以切。
- 知识点：但我不会选择 开始的时候可以放在旁边 来看看效果 可以调整阻力 需要调整它 让我们把效果调到准备器 让它们在时间线上调整 这样就可观察到它。

**关键画面：**

这是 `p61.md` 的开场画面，重点已经从上一页的 Niagara 细节制作切换到“如何在关卡里为 Magic Projectiles 做演出准备”。画面展示的是测试角色、测试圆柱和 `NS_MagicProjectiles` 所在的演示关卡

场景与对象可确认
- 当前是 Unreal 关卡视图
- 画面中可见：
  - 左侧站立的 `Gideon_Inquisitor` 角色
  - 右侧白色 `Cylinder`
  - `NS_MagicProjectiles` 仍在场景中存在，但当前未明显显示拖尾效果
- 顶部关卡标签显示为 `VFX_Library`

`Outliner` 可确认
- 当前选中的对象是 `NS_MagicProjectiles`
- 同层还能看到：
  - `Cylinder`
  - `Gideon_Inquisitor`
- 环境对象仍包含：
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `Floor`
  - `PointLight`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`

`NS_MagicProjectiles` 实例可确认
- `Details` 面板对象为 `NS_MagicProjectiles`
- 组件层级可见：
  - `NS_MagicProjectiles (Instance)`
  - `NiagaraComponent (NiagaraComponent0)`
- `Niagara System Asset = NS_MagicProjectiles`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用
- `Activation > Auto Activate` 已勾选
- `Niagara Utilities` 可见：
  - `Debug`
  - `Reset`
  - `Capture`

资源定位可确认
- 底部 `Content Browser` 当前路径已切到 `Content > VFX_Library > Sequences > MagicProjectiles`
- 当前目录里没有列出资源卡片，说明作者此时主要在定位序列/演出目录，而不是继续调材质实例

输出/预览
- 字幕提到“逐渐开始准备效果、预期部分”，结合当前画面可理解为：教程进入了关卡演出阶段，先把角色、测试物和 Niagara 系统都放在一个统一的场景里，再开始布置镜头、动作和准备阶段效果
这张图把重点切到关卡演出工具。作者已经开始使用 Sequencer 和 CineCameraActor，为 Magic Projectiles 的准备镜头搭建基础时间线和取景，而不仅仅是在关卡里摆角色和测试物

场景与镜头可确认
- 视口左上显示 `Pilot Actor: CineCameraActor`
- 当前镜头从较远处观察角色与白色圆柱体
- 画面仍是棋盘测试地面，说明这是专门为演出调度服务的工作镜头

Sequencer 可确认
- 底部已打开 `Sequencer`
- 当前序列标签为 `Sequencer*`
- 时间轴项目中可见：
  - `Camera Cuts`
  - `CineCameraActor`
  - `CameraComponent`
  - `Transform`
- 序列帧率显示为 `30 fps`
- 当前播放头在 `0.00`

相机参数可确认
- `CameraComponent` 下可见：
  - `Current Aperture = 2.8`
  - `Current Focal Length = 48.164337`
  - `Manual Focus Distance = 100000.0`

场景对象与 World Outliner 可确认
- 右侧 `Outliner` 中可见：
  - `CineCamera...`
  - `Cylinder`
  - `Gideon_Inqu...`
  - `LQ_MagicPr...`
  - `NS_MagicPr...`
- 这说明镜头、角色、测试物和 Niagara 系统已经一起纳入了演出场景

当前选中环境对象可确认
- 右侧当前选中的是 `ExponentialHeightFog`
- `Details` 面板中可见：
  - `Fog Height Falloff = 0.001`
- `Second Fog Data` 下可见：
  - `Fog Density = 0.05`
  - `Fog Height Falloff = 0.0`
  - `Fog Height Offset = 0.0`
- 还可见：
  - `Fog Max Opacity = 1.0`
  - `Start Distance = 0.0`
  - `Fog Cutoff Distance = 2000000.0`

输出/预览
- 这张图说明教程正在把特效从“单纯能工作”推进到“能被拍得好看”：先用 Sequencer 建立镜头轨，再同步调整相机参数和雾效，让角色、圆柱和后续特效都有一个合适的演出氛围
这张图回到 Niagara System，本段定位是 `UV`，当前选中的是 `Ribbon_Glow`。右侧展开 `Dynamic Material Parameters`，说明作者正在为 Glow 层继续调材质端的 UV/失真驱动，而不是再改基础发射节奏

系统结构可确认
- 当前系统为 `NS_MagicProjectiles`
- 系统概览中并排可见：
  - `Ribbon_Glow`
  - `Ribbon_Magic`
  - `Ribbon_GlowDark`
- 时间轴中还可见：
  - `Glows`
  - `Lights`
  - `Ribbon_Dark`
  - `Ribbon_Glow`
  - `Ribbon_GlowDark`
- 当前时间约为 `1.31`

预览状态可确认
- 左侧预览里能看到三条近距离的紫粉色能量流，表面带明显扭动纹理和高亮边缘
- 这说明当前调的不是纯颜色常量，而是会直接影响纹理滚动和表面扰动的材质参数

`Dynamic Material Parameters` 可确认
- 当前查看的是 `All`
- 顶部索引页签可见：
  - `Index 0`
  - `Index 1`
  - `Index 2`
  - `Index 3`
- `Dynamic Parameter Index 0` 已启用
- `Write Parameter Index 0` 已勾选

参数与曲线可确认
- `Distortion = Float from Curve`
- 曲线类型为 `Curve for Floats`
- 曲线从前段较低值开始，随生命周期逐步上升，到后段达到更高值
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 0.25`

随机偏移可确认
- `RandomUVoffset = Random Range Float`
- `Minimum = 0.0`
- `Maximum = 2.0`
- `Evaluation Type = Spawn Only`
- 其余未使用参数当前为：
  - `Param2-0 (...) = 0.0`
  - `Param3-0 (...) = 0.0`

输出/预览
- 这张图说明 `Ribbon_Glow` 也沿用了与 `Ribbon_Magic` 相似的 UV/失真驱动方式：失真强度随粒子年龄增加，同时每条 Ribbon 出生时拿到不同的 UV 偏移
- 复建时可在 `Ribbon_Glow.Dynamic Material Parameters.Index 0` 中保留一条随 `NormalizedAge` 上升的 `Distortion` 曲线，并设置 `0-2` 的 `RandomUVoffset`，让 Glow 层纹理滚动更活、更不整齐

### 00:05:04-00:09:44 速度、颜色

- 本段定位：速度、颜色。
- 知识点：把颜色的颜色放在这里 没有人禁止你做这个 而且效果可以变化得很快 但需要把它回到 当时的状态 需要慢慢地 调整角色的动作 我们怎么做 需要把角色。
- 知识点：拉在这里 它有动作 这里有全他动作的列表 让我选择idle idle是动作 当他在最开始时 站立 他站立了 动作就像站立了 需要尝试找一列动作。
- 知识点：它们在哪里 现在需要找到 这里有全个动作 可观察到它们是什么样的 在不同的地方 有不同的动作 需要告诉你找到哪里 如果去EPIGAME的传送中心。
- 知识点：去市场 然后点PARAGONY 这就是EPIGAME的 不出现的游戏 它们都会为了免费 分享各个角色和动作 甚至有这些角色的 视觉效果 可以选择一个角色。
- 知识点：把它们拖进游戏 这可以做到 这里有不同的机构 为了角色 动作和其他东西 在这种情况下 我们需要找到一个攻击动作 让它们像是 在射枪一样 像这种动作。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这张图处于 `p61` 的“速度、颜色”段，但当前画面重点其实是把特效放回 Sequencer 演出里做镜头预演。三条紫粉色拖尾已经被打到白色圆柱上，用来同时检查角色动作、镜头时机和受光表现

场景与镜头可确认
- 当前仍是带 `Sequencer` 的关卡视图
- 画面中央偏右是白色 `Cylinder`
- 左侧拖尾已经明显撞向或掠过圆柱体
- 地面上出现强烈的紫粉色受光，说明 `Lights` 层与拖尾层都在正常工作

Sequencer 可确认
- 底部序列标签为 `Sequencer*`
- 当前序列名显示为 `LQ_MagicProjectiles`
- 帧率为 `30 fps`
- 当前播放头大约在 `1.37`
- 轨道中可见：
  - `Camera Cuts`
  - `CineCameraActor`
  - `CameraComponent`
  - `Transform`
  - `NS_MagicProjectiles`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 轨道处于一条明显的红色区段中，说明 Niagara 系统生命周期已经被直接编排进序列

相机参数可确认
- `CameraComponent` 下仍可见：
  - `Current Aperture = 2.8`
  - `Current Focal Length = 48.164337`
  - `Manual Focus Distance = 100000.0`

场景对象与环境可确认
- `Outliner` 中可见：
  - `CineCamera`
  - `Cylinder`
  - `Gideon_Inqu...`
  - `LQ_MagicPr...`
  - `NS_MagicPr...`
- 当前选中的是 `SkyAtmosphere`
- `Details` 中可见：
  - `Transform Mode = Planet Top at Absolute World Origin`
  - `Ground Radius = 6360.0`
  - `Atmosphere Height = 60.0`
  - `MultiScattering = 1.0`

输出/预览
- 这张图说明教程已经从“做出特效”推进到“让特效在演出时间线上正确出现”
- 复建时应把 `NS_MagicProjectiles` 加进 Sequencer，并用 `System Life Cycle` 轨道控制它在镜头中的启停，同时在角色、圆柱和相机都就位的情况下观察颜色与速度表现
这张图从关卡切到了角色动画资源编辑界面。作者正在为 `Gideon` 角色挑选一个看起来像“发射投射物”的动作，好让后面的 Magic Projectiles 不只是静态播放，而是跟角色肢体动作配合起来

资源与窗口可确认
- 当前打开的是动画资源 `Burden`
- 中央预览中是 `Gideon` 角色的单独动作姿势
- 角色当前姿态表现为身体前倾、手臂外伸，确实接近一个施法或投射动作

动画资源信息可确认
- 右侧悬浮信息框显示当前选中的动画序列为 `JumpPad (Animation Sequence)`
- 路径可确认为：
  - `/Game/VFX_Library/ParagonGideon/Characters/Heroes/Gideon/Animations`
- 还可确认：
  - `Additive Anim Type = None`
  - `EnableRootMotion = False`
  - `Use Normalized Root Motion Scale = True`
  - `Imported File Frame Rate = 0.000000`
  - `Import Resample Framerate = 0`
  - `Interpolation = Linear`
  - `Number Of Frames = 60`
  - `Number Of Keys = 61`
  - `Parent Asset = None`
  - `Preview Skeletal Mesh = None`
  - `Retarget Source = None`
  - `Sequence Length = 2.000000`
  - `Skeleton = Gideon_Skeleton`
  - `Source Frame Rate = 30.00`
  - `Target Frame Rate = 30.00`

左侧资产参数可确认
- `Target Frame Rate = 29.032 fps`
- `Platform Target Frame Rate = 29.032 fps`
- `Number of Sampled Keys = 31`
- `Number of Sampled Frames = 30`
- `Rate Scale = 1.0`
- `Loop` 未启用
- `Skeleton = Gideon_Skeleton`

时间线与曲线可确认
- 底部时间线当前播放头在大约 `0.31s (29.76%)`
- 曲线列表中可见三条与外环几何缩放相关的曲线：
  - `outer_ring_bott_geo_scaled`
  - `outer_ring_inside_geo_scaled`
  - `outer_ring_top_geo_scaled`

输出/预览
- 字幕明确说“Make something look like he's firing a projectile”，所以这张图的核心是动作选型而不是 Niagara 参数
- 可按图理解为：先在 `ParagonGideon` 的动画资源中筛选一个 2 秒左右、姿势带前冲或抬臂感的动作，再把它带回关卡或 Sequencer 中与投射物发射时刻对齐
这张图把角色动作、投射物时机和 Sequencer 真正合到了一起。`Gideon_Inquisitor` 已经在镜头中执行攻击动作，同时三条紫粉色 Magic Projectiles 从角色附近飞出，说明教程已经完成了“动作与特效发射同步”的第一轮对位

场景与预览可确认
- 当前是带 `Sequencer` 的关卡视图
- 角色 `Gideon_Inquisitor` 处于施法/攻击姿态
- 三条亮粉白色投射体从角色前方飞出
- 地面上仍有紫粉色受光，说明特效与灯光层都已生效

Sequencer 可确认
- 底部序列仍为 `LQ_MagicProjectiles`
- 帧率为 `30 fps`
- 当前播放头约在 `0.40`
- 轨道中清楚可见：
  - `Camera Cuts`
  - `CineCameraActor`
  - `Gideon_Inquisitor`
  - `Animation`
  - `Transform`
  - `NS_MagicProjects...`

角色动画片段可确认
- 在 `Gideon_Inquisitor > Animation` 轨道上，当前片段为 `Primary_Attack_A_Medium`
- 浮窗信息可确认：
  - `6 - 59 (53 frames)`
  - `Start: 0.7s`
  - `Duration: 1.767s`
  - `Play Rate: 1`
  - `Ease In: Cubic InOut (4 frames)`
- 片段前面还能看到一段 `Idle`
- 当前片段上的标记值显示为 `0.90`

角色对象可确认
- 当前 `Outliner` 选中的是 `Gideon_Inquisitor`
- `Details` 面板中可见：
  - `Animation Mode = Use Custom Mode`
  - `Skeletal Mesh Asset = Gideon_Inquisitor`
- 下方材质槽里还能看到角色材质条目

输出/预览
- 这张图的核心不是再调 Niagara 参数，而是把“角色动作开始发力的时间点”和“投射物真正飞出的时间点”压到同一个序列里
- 复建时可先让角色从 `Idle` 过渡到 `Primary_Attack_A_Medium`，再在攻击动作前段把 `NS_MagicProjectiles` 的系统生命周期或激活时机对齐到角色抬手/出手瞬间

### 00:09:44-00:13:57 速度

- 本段定位：速度。
- 知识点：还有一个选项 可以选择转移 只要它是柔软的转移 从一个动作到另一个动作 我们去这个动作的计算器 然后需要改变它 速度。
- 知识点：可以在这里加速 它们也会从开始开始 但它们会慢慢地进入 它的结局 会在这里接近 它开始了 慢慢地 这个动作继续 可以用另一个动作 例如这里。
- 知识点：现在我们加 我加了另一个动作 需要移到这里 可以在这里删除 惊喜的他通过了 我们看看原本的动作 需要做一些转移 这样它们会从一个动作 到另一个动作。
- 知识点：我们看看不同的变化 我们改变动作速度的 某些图案 然后我们改变它们的结局 从一个动作的位置 慢慢地移到另一个位置 转移必须改变 让它们更轻松。
- 知识点：可以删除它们 看看它们全部都结合 必须要检查 它们会慢慢地进入 因此当某个人出现时 它会开始移动 他的手 主要是要正确地 把所有转移 确保它们都正确地确定。
- 核对对象：`速度`。

**关键画面：**

这一帧在 Sequencer 中对齐 Gideon 的攻击动作与投射物发射时机。当前序列为 `LQ_MagicProjectiles`，时间标尺为 `30 fps`，播放头位于约 `0.47` 秒位置，左侧轨道可见 `Camera Cuts`、`CineCameraActor`、`Gideon_Inquisitor`、`Animation`、`Transform` 与 `NS_MagicProjectiles`

当前选中的是 `Gideon_Inquisitor` 的动画片段，右键已打开片段菜单，说明这里正在调整角色动画片段的衔接方式。菜单中可确认以下匹配选项：

- `Match X and Y Translation`
- `Match Z Height`
- `Match Yaw Rotation`
- `Match Pitch Rotation`
- `Match Roll Rotation`

其中 `Match X and Y Translation` 与 `Match Yaw Rotation` 已勾选，表示让本段攻击动作在平面位置和朝向上与前后片段连续；`Match Z Height`、`Match Pitch Rotation`、`Match Roll Rotation` 未勾选。时间线上可见前一段是 `Idle`，后一段是 `Primary_Attack_A_Medium`，攻击片段上显示权重轨道 `Weight = 1.0`

视口中已经能看到 Gideon 身前出现三道紫粉色投射物拖尾，因此这一步的目的，是在保持角色根部位置与朝向连续的前提下，把攻击动画与 `NS_MagicProjectiles` 的发射位置对齐，避免切到攻击片段时角色或特效发生跳动
这张图展示调整后的 Sequencer 时间线效果，用来观察角色攻击动画在发射瞬间的推进速度与结束位置。当前仍在序列 `LQ_MagicProjectiles` 中，帧率为 `30 fps`，播放头位于约 `0.53` 秒

时间线可确认
- `CineCameraActor` 镜头轨道覆盖区间为 `0 - 150 (150 frames)`
- `Gideon_Inquisitor` 仍保留 `Animation` 与 `Transform` 轨道
- 动画轨道前段是 `Idle`
- 后面接两段 `Primary_Attack_A_Medium`
- `Weight` 轨道当前值为 `1.0`

画面中的 Gideon 已经站定，三道紫粉色投射物从角色身前向右前方飞出，说明教程此时在通过观察镜头预演结果来微调攻击片段，而不是再改 Niagara 发射器本身。字幕可确认当前操作意图是“修改动画速度的一些参数，并改变它结束的位置”

结合这一帧可按下面的方式理解操作目标：

1. 保留攻击动作的主体片段 `Primary_Attack_A_Medium`
2. 通过时间线上的片段长度、衔接或局部速度控制，让发射瞬间更贴近投射物出现的节奏
3. 同时调整动画片段的结束落点，使角色在动作结束时仍保持与镜头、特效拖尾一致的位置关系

这一帧本身没有展开具体数值面板，因此可可靠确认的是 Sequencer 中已经进入“通过动画片段速度与结束位置来修正发射表演”的阶段
这张图是同一“速度”段里的进一步结果图，用来确认修改后的攻击动画已经在时间线上形成更稳定的连续推进。当前仍在 `LQ_MagicProjectiles` 序列中，帧率为 `30 fps`，播放头仍位于约 `0.53` 秒，选中对象依然是 `Gideon_Inquisitor`

与上一张相比，这一帧的 `Animation` 轨道已经清晰显示为两段连续的 `Primary_Attack_A_Medium`，前面的 `Idle` 片段不再处于当前可见重点区间。可确认的信息如下：

- `CineCameraActor` 轨道提示仍显示 `0 - 150 (150 frames)`
- `Animation` 轨道中前后两段都标记为 `Primary_Attack_A_Medium`
- `Weight` 轨道保持 `1.0`
- `Transform` 轨道仍在角色轨道下方保留
- `NS_MagicProjectiles` 轨道继续存在，用于和角色动画共同预演

视口里 Gideon 已抬手朝右前方发射三道紫粉色投射物，拖尾长度与角色姿态已经匹配，说明教程这里是在检查：当同一个攻击动作片段经过时序和结束位置修正后，是否能让角色出手、拖尾方向与镜头构图稳定连贯

可据此把这一帧理解为当前段落的验收目标：

1. 攻击动作片段在时间线上连续可用
2. 角色朝向与根部落点不会在衔接处突然跳变
3. 投射物的起飞方向、拖尾长度与角色当前姿态保持一致

这张图仍未展示具体参数面板，所以不能可靠抄写数值；但可以明确确认教程已经把重点放在 Sequencer 里检查调整后的整体表演结果

### 00:13:57-00:15:41 速度

- 本段定位：速度。
- 知识点：例如 可以用这个转移 来伸展这个时刻 我们可观察到它很细腻 这东西控制着 它们的速度 可以这样把它们 改变后 最后 它们会再次移动 当它们把手移动。
- 知识点：它们会慢慢地移动 到一个正确的姿态 再次移动 它们会做出一个轻松的转移 它们会移动 然后它们会慢慢地 移动到一个平行的位置 可能在这里 需要更好地调整 看看这些转移。
- 核对对象：`速度`。

**关键画面：**

这一帧把“速度”段的调整结果直接显示在 Sequencer 时间线上。当前序列仍是 `LQ_MagicProjectiles`，帧率为 `30 fps`，播放头位于约 `0.63` 秒，视口中 Gideon 已经抬手，三道紫粉色投射物正朝右前方飞出

当前选中的是角色 `Gideon_Inquisitor` 的攻击动画片段，提示框可确认该片段参数为：

- 动画名：`Primary_Attack_A_Medium`
- 时间范围：`13 - 66 (53 frames)`
- `Start: 0s`
- `Duration: 1.76s`
- `Play Rate: 0.5`
- `Ease In: Cubic InOut (8 frames)`

时间线上还能看到：

- 前一段是 `Idle`
- 当前攻击片段左侧有一个蓝色偏移标记 `[-0.20s]`
- 片段下方显示一段蓝色数值 `0.10`
- `Weight` 轨道仍为 `1.0`
- `Transform` 与 `NS_MagicProjectiles` 轨道仍保留在下方

这张图说明教程已经开始通过降低动画播放速度来拉长攻击动作。`Play Rate` 被改成 `0.5` 后，角色抬手和投射物离手的过程会被放慢，从而给拖尾更多展开时间；同时攻击片段又通过时间线偏移与缓入设置接回 `Idle`，避免直接减速后出现动作衔接生硬的问题
这一帧继续展示攻击动作在减速后的时间线表现。当前序列仍为 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头已推进到约 `0.70` 秒。视口中 Gideon 保持抬手发射姿态，三道紫粉色投射物继续向右前方延伸，拖尾长度明显被拉长

Sequencer 中当前可确认的信息：

- `Gideon_Inquisitor` 仍处于选中状态
- `Animation` 轨道前面依次可见 `Idle` 与一段 `Primary_Attack_A_Medium`
- 右侧又接了一段新的 `Primary_Attack_A_Medium`
- 前一段攻击片段下方显示蓝色数值 `0.76`
- `Weight` 轨道仍为 `1.0`
- `Transform`、`NS_MagicProjectiles` 轨道依旧保留

这张图与上一张相比，重点不再是读取片段详情提示框，而是观察减速后的攻击动作在时间轴上的实际覆盖范围。可以把它理解为教程在检查两件事：

1. 第一段攻击动作被放慢后，是否已经把出手过程拖长到合适时长
2. 后续第二段 `Primary_Attack_A_Medium` 接续时，角色姿态和投射物发射方向是否仍然连贯

由于这张图没有展开参数弹窗，不能再额外补写新的数值；但从时间线与视口结果可以可靠确认，本段确实是在通过调整动画速度，让投射物拖尾有更充足的展开时间，同时维持角色动作与特效的连续性
这张图展示“速度”段调整后的尾段结果。当前序列仍为 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头已经推进到约 `1.97` 秒。视口中 Gideon 基本回到站立状态，紫粉色投射物已经飞到画面右侧边缘，只剩少量拖尾残影可见

时间线可确认：

- `Animation` 轨道左侧仍能看到前一个攻击片段的残余区间，标签可见为 `Primary` / `Primary_Attack_A_Medium`
- 当前播放头右侧已经进入 `Idle` 片段
- 播放头附近下方显示蓝色数值 `0.07`
- `Weight` 轨道仍为 `1.0`
- `Transform` 与 `NS_MagicProjectiles` 轨道继续保留

这说明教程不仅把攻击片段前段减速拉长，还检查了动作尾端如何平顺回到待机。可以把这一帧理解为以下验收点：

1. 投射物已经在角色动作结束后继续飞离，不会因为角色回收动作过快而显得发射过短
2. 攻击片段结束后，角色能自然衔接回 `Idle`
3. 在角色回到待机的同时，镜头中仍能保留投射物飞出后的残余拖尾，强化速度感

因此，这一帧给出的核心结论是：通过调整攻击动画的速度和结束位置，既延长了出手时的视觉表现，又让动作尾端和待机回接更自然

### 00:18:11-00:23:10 系统、速度

- 本段定位：系统、速度。
- 知识点：它们在一开始 从一开始就在平行的位置 它们会很快地 移动它的手 可能需要调整它的速度 例如 把它调到0.25 在这个点子停止 我们的效果开始了。
- 知识点：需要适当移动它 可能甚至是前一段时间 它已经开始 在这里被放松了 可能需要把动作 放在这里 因为它们会太快 所以我把这一刻 当动作开始之前。
- 知识点：我把动作开始之前 它们会慢慢地 移动到这个位置 这里它们会适当移动 例如 可以调整它的速度。
- 知识点：0.35 这就要你了 需要调整它 看看它会如何好看 做软转移 现在需要专注 在效果上 并且创造训练 想象一下 这个角色会把我们的硬件 放松 在这个位置。
- 知识点：它会把硬件放松 我们移动到手上 这里 大概是这样 我们移动到 粑粑系统 需要做什么 需要做一些光线 我们需要新的材料 现在 我们去到文件中心 我们把它复制 我们称它。
- 核对对象：`系统`、`速度`。

**关键画面：**

这张图处于 `系统、速度` 段，作用是先定位当前表演里“角色出手太快”的问题。当前序列仍为 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头位于约 `0.83` 秒，字幕明确指出：`Very quickly he starts to move his hand`

Sequencer 中可确认：

- `CineCameraActor` 轨道提示为 `0 - 150 (150 frames)`
- `Gideon_Inquisitor` 仍为当前选中对象
- `Animation` 轨道中当前可见两段 `Primary_Attack_A_Medium`
- `Weight` 轨道仍为 `1.0`
- `Transform` 与 `NS_MagicProjectiles` 轨道继续保留

视口里 Gideon 已经把手抬起，两道主要紫粉色投射物拖尾正在快速向右前方飞出，下方还有更长的一道亮色拖尾。因为角色手部启动得太快，投射物已经明显离开角色，导致角色动作、发射瞬间和拖尾展开之间的节奏显得过急

这一帧要表达的判断是：在继续做系统和材质调整前，必须先把角色手臂开始移动的时机放慢或往前后重新摆放，否则后面的特效即使本身做得正确，镜头里仍然会显得发射太仓促
这张图展示对角色攻击片段和 Niagara 系统生命周期进行联动调整后的时间线状态。当前序列仍是 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头位于约 `0.37` 秒。画面构图拉远，可以同时看到左侧的 Gideon 和右侧的白色 `Cylinder`，说明教程此时在整体检查角色、目标物和系统启动时机

当前选中的攻击片段提示框可确认以下参数：

- 动画名：`Primary_Attack_A_Medium`
- 时间范围：`13 - 66 (53 frames)`
- `Start: 0s`
- `Duration: 1.76s`
- `Play Rate: 0.5`
- `Ease In: Cubic InOut (14 frames)`
- `Ease Out: Cubic InOut (9 frames)`

时间线中还能确认：

- `Animation` 轨道仍由两段 `Primary_Attack_A_Medium` 组成
- 下方 `NS_MagicProjectiles` 已展开到 `NiagaraComponent0`
- `System Life Cycle` 轨道可见，模式显示为 `Desired Age`
- 底部有红色 `Life Cycle` 区段，说明系统启停时段正在被明确控制
- `Weight` 轨道仍为 `1.0`

这一帧表明教程不只是单独减慢角色动画，而是在同步校准两条时间轴：

1. 角色攻击片段通过 `Play Rate: 0.5` 放慢出手节奏
2. 片段头尾通过 `Ease In`、`Ease Out` 软化衔接
3. `NS_MagicProjectiles` 的 `System Life Cycle` 同时被推到合适的起止区间，确保特效不是过早或过晚开始

因此，这张图给出的关键结论是：角色动作速度和 Niagara 系统启动时间必须一起调，才能让发射表演既不抢拍，也不滞后
这张图已经从 Sequencer 切到材质实例编辑器，开始为这一套投射物系统准备新的光效材质。当前打开的资源标签是 `MI_Flare_01`，右侧是实例参数面板，左侧预览窗口里能看到一个大面积柔和的白色圆形发光片

可确认的材质实例结构如下

- 资源名：`MI_Flare_01`
- 父材质：`M_UberMaterial`
- 顶部参数页签包含 `Details` 和 `Layer Parameters`

参数组与当前可见设置

- `Base Texture`
  - `Colormap` 贴图为 `VFX_T_ColorMap_Blue_06`
  - `T_Main` 已启用
  - `T_Main` 使用的贴图为 `T_Glow`
  - `Use Colormap?` 当前值为 `0.0`
- `Dissolve`
  - `T_Dissolve` 使用贴图 `T_Noise111`
  - `Smoothness = 0.1`
- `Distortion`
  - `Distortion Influence = 0.0`
  - `T_Distortion` 使用贴图 `T_Voronoise002`
- `Global Scalar Parameter Values`
  - `Depth Fade = 100.0`
- `Mask`
  - `T_Mask` 使用贴图 `WhiteSquareTexture`

通用/材质属性区域可确认

- `Phys Material = None`
- `Blend Mode = Additive`

字幕说明当前目标是制作一张“低尺寸纹理，512x512 质量”的贴图型材质，因此这一步的实际用途，是先复制并整理一个适合 flare/亮斑用途的材质实例：主发光由 `T_Glow` 提供，遮罩由 `WhiteSquareTexture` 控形，失真和溶解分别预留了 `T_Voronoise002` 与 `T_Noise111`，后续再把它接回 Niagara 系统作为新的发光层使用

### 00:23:10-00:25:46 关键流程 06

- 本段定位：关键流程 06。
- 知识点：为低大质量的质量 512x512质量 质量很低 但可以这样改善 这就会让我们 做出质量质量的质量 我们需要这个质量 它会变成粑粑 可以保留它。
- 知识点：在这里 我们把硬件 我们创造了 空气启动器 一块粑粑会出现 这里我们设置生命 它会很快就会消失 设置一个选项色 橙色 我们设置了 既然它是粑粑 它也不会变成粑粑。
- 知识点：需要把它伸向 X线的方向 我们把我们创造的材料 移动到手上 这是现在的样子 我们看看它是怎么看。

**关键画面：**

这张图处于“关键流程 06”段，已经切到贴图资源编辑器，目标是把刚才准备用作 flare 的贴图控制在较低分辨率并采用合适压缩。当前打开的资源标签是 `T_Flare30`

可确认的资源信息

- 贴图名：`T_Flare30`
- `Imported: 512x512`
- `Displayed: 512x512`
- `Max In-Game: 512x512`
- `Resource Size: 171 KB`
- `Has Alpha Channel: False`
- `Source Alpha Detected: Unknown`
- `Method: Streamed`
- `Format: DXT1`
- `Number of Mips: 10`
- `Encode Speed: Fast`

当前可见设置

- `Mip Gen Settings = FromTextureGroup`
- `LOD Bias = 0`
- `Texture Group = World`
- `Compression Settings` 正在展开下拉列表
- 当前选项显示为 `Default (DXT1/5, BC1/3 on DX11)`
- 下拉列表中能看到 `Masks (no sRGB)`、`Grayscale`、`Displacementmap`、`VectorDisplacementmap`、`HDR`、`Alpha`、`DistanceFieldFont` 等其他压缩模式
- `sRGB` 已启用
- `X-axis Tiling Method = Wrap`
- `Y-axis Tiling Method = Wrap`

预览窗口中这张贴图是一个中心高亮、向外逐渐衰减的白色 flare 形状，因此这一步的目的，是把用于发光片的贴图维持在 `512x512` 的低成本规格，并检查压缩模式是否适合这种非透明、渐变型亮斑纹理，避免后续接入材质和 Niagara 后出现不必要的显存占用或压缩失真
这张图回到 Niagara 系统编辑器 `NS_MagicProjectiles`，开始把刚才准备好的 flare 资源接成一个新的发射器层。系统概览中新增并选中了一个名为 `Empty` 的发射器，左侧预览里已经能看到几条明亮的白紫色细长 flare 被叠加到原有投射物上

系统概览中可确认

- 当前系统为 `NS_MagicProjectiles`
- 新发射器名：`Empty`
- 下方仍能看到已有发射器：`Glows`、`Lights`、`Ribbon_Dark`、`Ribbon_Glow`
- 时间轴为 `240 fps`
- 播放头位于约 `1.27`

`Empty` 发射器当前模块结构

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

右侧详情面板当前展开的是 `Spawn Burst Instantaneous`，可确认参数：

- `Spawn Count = 1`
- `Spawn Time = 0.0`
- `Spawn Probability = 1.0`
- `Loop Count Limit = 1`

这说明教程这里在创建一个一次性爆发的精简 sprite 发射器，用来挂载新的 flare 材质。它不是持续刷新的拖尾发射器，而是在指定时刻只生成极少量粒子，再通过 sprite 材质把一个短命的亮斑或拉伸光片放到投射物附近，作为额外的发射强调层
这张图继续在 `NS_MagicProjectiles` 中配置新建的 `Empty` 发射器，不过重点从爆发生成切换到发射器生命周期和粒子初始化。左侧预览里可以看到白紫色 flare 已经沿着投射物方向叠加在画面上，说明这个新层已经开始影响整体效果

`Empty` 发射器当前可确认的结构仍为：

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

右侧详情面板当前显示的关键设置

- `Emitter Properties`
  - `Interpolated Spawning` 已启用
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- `Emitter State`
  - `Life Cycle Mode` 可见 `System / Self`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Once`
  - `Loop Duration Mode = Infinite`
  - `Loop Duration = 1.0`
  - `Loop Delay = 0.0`
- `Spawn Burst Instantaneous`
  - `Spawn Count = 1`
  - `Spawn Time = 0.0`
  - `Spawn Probability = 1.0`
  - `Loop Count Limit = 1`
- `Initialize Particle`
  - 处于 `All` 视图
  - `Lifetime Mode = Direct Set`

这张图说明教程正在把这个 flare 发射器定义成“自控的一次性短命粒子”：

1. 发射器只生成一次，不循环刷出大量粒子
2. 发射器停用时允许现有粒子自然播放完再销毁
3. 粒子寿命会在 `Initialize Particle` 里直接指定，而不是依赖随机默认值

这样做的目的，是让新 flare 层只在关键发射时刻闪一下，跟随投射物方向形成短促的起飞强调，而不会像拖尾层那样持续占据画面

### 00:25:49-00:30:31 系统、颜色

- 本段定位：系统、颜色。
- 知识点：粑粑有了粑粑 它 移动到手上 我们不需要它 所以我们加了一个启动摄像机 需要把它移动 通过启动摄像机 我觉得大小的数字 应该在这里设置 但如果我们很近。
- 知识点：它会太大 可能是50 或者100 超 我们伸向了X线 现在它必须 移动它 让它增长 我们来做一个测试 我们看看 超 它应该消失 时间过去 它必须 创造颜色。
- 知识点：透明 我们来做一个测试 看看结果 它会逐渐消失 需要有一个测试 可以复制 这是背景的背景光 它会用到物件 但它们的尺寸会不同 需要把它们调整成一块。
- 知识点：需要调整一个缘隙 它们会跟动画一样 但它们的尺寸会不同 需要只调整两个 需要有一个测试 在旁边 还有一个圆的 总共它们会给予 一个非常有趣的结果。
- 知识点：需要创造 新的物件 为什么我把它叫成了 黄金链 这是一个黄金的颜色 需要展示它 这是它看起来的 但我们没有看到颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`系统`、`颜色`。

**关键画面：**

这张图回到带 `Sequencer` 的关卡视图，用来检查新加入的 flare 层在角色手部附近的整体表现。当前序列仍为 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头位于约 `1.13` 秒

画面中 Gideon 抬起手臂，手部位置出现一大片横向展开的紫粉色发光带，说明新增的亮斑/flare 已经开始在发射前后参与画面构图。与前面单纯的拖尾不同，这一层更像贴近手部的局部发光面，用于强化起手时的能量聚集感

Sequencer 与对象信息可确认：

- 当前选中对象是 `NS_MagicProjectiles`
- 时间线中可见 `Gideon_Inquisitor` 的 `Animation` 轨道
- 角色动画片段依次可见 `Primary_Attack_A_Medium` 与后续 `Idle`
- `NS_MagicProjectiles` 下展开了 `NiagaraComponent0`
- `System Life Cycle` 模式显示为 `Desired Age`
- 底部红色 `Life Cycle` 区段已经覆盖当前播放位置

右侧 `Details` 面板还能确认当前系统实例的 `Transform`

- `Location = (-29.0, 75.0, 155.0)`
- `Rotation = (0.0, 0.0, 90.0)`
- `Scale = (1.0, 1.0, 1.0)`

这一步的作用，是把前面新做的 flare/颜色层放回到关卡时序中核对位置、朝向和出现时机。只有当 `NS_MagicProjectiles` 的整体偏移、旋转和生命周期都正确时，这种贴近手部的紫色亮斑才会稳定地贴在角色出手点附近，而不会漂移或错位
这一帧继续在关卡里预演 `NS_MagicProjectiles`，但新 flare 层的表现已经从横向拉开的发光带，收敛成角色手边一个更集中的紫白色光团。当前序列仍是 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头位于约 `0.80` 秒

可确认的对象与时间线信息：

- 当前选中对象仍为 `NS_MagicProjectiles`
- `System Life Cycle` 仍处于 `Desired Age`
- 底部红色 `Life Cycle` 区段仍覆盖当前播放位置
- `Gideon_Inquisitor` 的动画轨道可见 `Primary_Attack_A_Medium` 后接 `Idle`
- 右侧系统实例 `Transform` 仍为
  - `Location = (-29.0, 75.0, 155.0)`
  - `Rotation = (0.0, 0.0, 90.0)`
  - `Scale = (1.0, 1.0, 1.0)`

与上一张相比，这张图的关键观察点是颜色和尺寸控制后的视觉集中度。角色胸前偏手部位置只保留了一团高亮紫白发光，说明教程正在把新加的 sprite/flare 层压到更小、更聚焦的范围，避免它像大面积光幕一样遮挡角色动作

可以把这一帧理解为以下检查：

1. flare 的尺寸是否已经缩到只强调出手点，而不是覆盖整个角色前方
2. 颜色是否保持在紫白色高亮区间，与原有 `MagicProjectiles` 主色一致
3. flare 的中心是否仍牢靠地附着在角色手部附近，而不是随系统偏移漂到其他位置

因此，这张图体现的是“系统、颜色”段里的第一次收束：把新层从过大的测试效果，调成更适合附着在手部的局部高亮能量团
这张图回到 `NS_MagicProjectiles` 的系统编辑器，开始为一个新的环形颜色层指定材质。当前选中的发射器名为 `RingChroma`，右侧详情面板展开的是它的 `Sprite Renderer`

`RingChroma` 发射器当前可见模块结构

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

`Sprite Renderer` 中当前可确认的设置

- `Material` 当前值是 `MI_Flare_01`
- 材质选择下拉已打开，并用关键字 `chroma` 搜索
- 搜索结果中可见两个候选：
  - `M_ColorDifferenceKey`（Material）
  - `MI_ChromaRing_01`（Material Instance）
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Renderer Visibility = 0`

下方时间轴显示当前系统里已经有多层发射器并行存在，包括：

- `Flare`
- `GlowBackground`
- `Glows`
- `Lights`
- `Ribbon_Dark`

左侧预览窗口中能看到一个大面积、柔和的白色圆形面片，说明当前仍在测试一种圆盘或环状的 sprite 外观

这张图说明教程下一步是把单纯的 flare 材质切换成更偏“色环/色差环”的材质实例。结合发射器命名 `RingChroma` 和搜索结果 `MI_ChromaRing_01`，可以明确确认这里是在为新的环形颜色层挑选专用材质，以便后续通过 `Scale Sprite Size` 和 `Scale Color` 把它做成贴近手部或投射物起点的色环强调效果

### 00:30:31-00:35:12 Alpha、颜色

- 本段定位：Alpha、颜色。
- 知识点：它看起来很大 如果我们来调整 它会很大 首先我们需要改变光光 把很小的颜色放在上面 可观察到 这种很有趣的东西 我还想加一点粉红色 让大家来调整。
- 知识点：需要提升光光 看起来很有趣 需要继续调整 同样是300颜色 需要把颜色的颜色改变 让它吸收了最大颜色。
- 知识点：看起来很有趣 我们删除 需要调整中间的灯光 可以用我就用的颜色 让我们拿到了我们已经提供的光 这里是这个 我们把它适当安排到这里 然后我们现在可以开始。
- 知识点：把颜色改变 让它亮一点 对了,它会在中间的亮一点 在本体上需要做同样的事情 我们问问结果 不太亮,为什么? 因为我把Galpha编辑在这里。
- 知识点：当然它会太大了 我们需要在中间的地方 因此需要调整它 让它在中间更亮 然后需要改变它的线条 可能会改变某个转折 这里有点像 需要慢慢地增长。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`颜色`。

**关键画面：**

这张图处于 `Alpha、颜色` 段，展示新加入的色环层第一次放回关卡后的结果。当前序列仍是 `LQ_MagicProjectiles`，帧率 `30 fps`，播放头位于约 `0.93` 秒，当前选中对象仍为 `NS_MagicProjectiles`

画面中心可以直接看到一个明显的环形效果：

- 外圈是偏橙黄的高亮圆环
- 中心区域保留紫白色发光核心
- 整个色环包裹在 Gideon 手部附近，和原本的紫色能量团叠在一起

时间线和系统实例可确认：

- `System Life Cycle` 仍处于 `Desired Age`
- 底部红色 `Life Cycle` 区段覆盖当前播放位置
- `Gideon_Inquisitor` 的动画轨道仍是 `Primary_Attack_A_Medium` 后接 `Idle`
- 右侧 `Transform` 仍为
  - `Location = (-29.0, 75.0, 155.0)`
  - `Rotation = (0.0, 0.0, 90.0)`
  - `Scale = (1.0, 1.0, 1.0)`

这一帧的关键问题也很明显：色环已经出现，但尺寸偏大、边缘亮度很强，几乎把角色上半身包在中间。结合本段标题“Alpha、颜色”，可以把当前状态理解为第一版测试结果：

1. 颜色层已经从单纯紫色 flare 扩展到带暖色外环的多层效果
2. Alpha 边界仍偏宽，外环覆盖范围过大
3. 中心紫色能量团与外圈橙色环已经形成对比，但还需要继续压缩尺寸并细调亮度分布

因此，这张图相当于本段的起点样例：先确认环形颜色层能正确出现，再针对透明度衰减和颜色强弱做后续收束
这张图回到 `NS_MagicProjectiles` 的系统编辑器，开始分别处理中心高亮层与外圈层的颜色。当前选中的发射器是 `GlowCenter`，字幕直接说明当前操作意图是“现在我们会稍微改变第一个颜色”

系统中当前可见的关键发射器包括：

- `RingChroma`
- `GlowCenter`
- `Ribbon_Magic`
- `Ribbon_GlowDark`
- `Ribbon_Dark`

从模块结构看，`GlowCenter` 与前面的 `RingChroma` 类似，都包含：

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

右侧 `Sprite Renderer` 当前可确认的设置：

- 发射器名：`GlowCenter`
- `Material = MI_Glow_01`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Renderer Visibility = 0`

下方时间轴还能确认系统里同时存在多层并行发射器：

- `Flare`
- `GlowBackground`
- `GlowCenter`
- `Glows`
- `Lights`

这张图说明本段已经从“让环形层出现”进入“分层配色”阶段。`GlowCenter` 显然承担中心亮核的职责，材质也切回更基础的 `MI_Glow_01`，而不是色环用的 `MI_ChromaRing_01`。因此这里要调整的“第一个颜色”，更可能指中心亮核的主色或其随时间变化的色值，让它和外圈 `RingChroma` 拉开层次：中心保持更亮、更纯的核心，外圈再承接偏暖或偏粉的过渡颜色
这张图仍在 `NS_MagicProjectiles` 的系统编辑器中，当前聚焦的发射器还是 `GlowCenter`。与上一张相比，右侧参数面板已经清空为普通搜索状态，中央弹出了空白区域的右键菜单，字幕则开始引出“接下来要展示一个有趣的东西”，说明本段的 Alpha 和颜色层调整已经基本告一段落

当前仍可确认的 `GlowCenter` 发射器结构：

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

时间轴里仍能看到并行存在的几层：

- `Flare`
- `GlowBackground`
- `GlowCenter`
- `Lights`

画面左侧预览窗口中保留着一个柔和的白色圆形面片，说明当前中心高亮层的基本 sprite 形态已经保留，没有再切换成别的贴图类型

中央右键菜单当前可见的操作包括：

- `Add Emitter...`
- `Add empty emitter`
- `Add Comment`
- `Clear Isolated`
- `Zoom to Fit`
- `Zoom to Fit All`
- `Paste`

这张图的意义不在新增具体参数，而在于阶段收束：到这里为止，`GlowCenter` 这类中心亮核层已经具备独立的发射器、独立的材质和可调的 `Scale Color` / `Scale Sprite Size` 路径，教程接下来准备引入下一种机制，而不是继续停留在当前这套 Alpha 与颜色细调上

### 00:35:12-00:39:56 Emitter、GPU、Texture

- 本段定位：Emitter、GPU、Texture。
- 知识点：也有一个很有趣的东西 叫做SAMPLE TEXTURE 可以从它们的Texture 由黑色和白色 来组成我们的粒子。
- 知识点：现在需要展示 我说过的这些东西 需要在这里 产生很多粒子 Pound rate 我们需要放一大张 生命是逻辑的 我们也会逻辑颜色。
- 知识点：也会是粉红色 也许是黑色 也许是白色 现在在SAMPT中 加了一个很有趣的粒子 它会给我们一些警告 它说它正在工作 还有在处理中的评测。
- 知识点：用最基本的评测 现在需要在GPU上使用 有什么区别 当你开车很多 和很多粒子 就会用GPU评测 会更快 还有一定的限制 当在粒子上制作。
- 知识点：需要有相同的评测限制 它们经常在 当在中央处理中 它们会站立 例如粒子在限制之间 飞到某些地方 它们就会更新 这些工程师 它们都会更新。
- 知识点：现在需要在基本上展示 当我把相片的质感转换掉 我们转转转转 还有 是的 我们不需要它 这是这里 这是这里 让在时间上 有很多粒子。
- 知识点：在手机模式中 有这种限制 如果我把它们提升 那我们的限制 会变化得相同 这 这全都要看 它们的粒子系统的大小。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Emitter`、`Texture`、`GPU`、`粒子`、`系统`、`颜色`。

**关键画面：**

这张图进入 `Emitter、GPU、Texture` 段，当前又回到 Niagara 系统编辑器 `NS_MagicProjectiles`，并重新选中了名为 `Empty` 的发射器。字幕明确提到“可以从它的黑白纹理中获取”，说明教程开始引入基于黑白贴图分布来驱动粒子生成或属性分配的做法

当前系统中可见的关键发射器包括：

- `GlowCenter`
- `Empty`
- `Ribbon_GlowDark`
- `Ribbon_Dark`

`Empty` 发射器当前可见结构

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

右侧详情面板当前展开的是 `Initialize Particle`，可确认的属性包括：

- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Mass Mode = Unset (Mass of 1)`
- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Unset`
- `Mesh Scale Mode = Unset`

同一面板上方的 `Emitter Properties` 还能确认：

- `Interpolated Spawning` 已启用
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`

这一帧说明教程正在把之前用来做单次 flare 的简单发射器，重新作为一个更通用的纹理采样粒子层来改造。当前还没有把颜色、尺寸等基础属性显式写死，而是先保留 `Initialize Particle` 的默认骨架，准备下一步通过黑白纹理或坐标采样结果，把粒子的生成位置、分布或数量交给贴图控制
这张图展示 `Empty` 发射器从简单 sprite 层进一步升级为大数量纹理采样粒子层后的状态。核心变化有三项：加入连续生成、加入 `Sample Texture`，并把模拟目标切换到 GPU

`Empty` 发射器当前结构可确认：

- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

右侧 `Emitter Properties` 当前可确认：

- `Sim Target = GPUCompute Sim`
- `Calculate Bounds Mode = Dynamic`
- 顶部黄色警告指出：
  - 发射器使用 GPU 且仍在动态 bounds 模式
  - 需要更新 emitter 或 system 属性，否则 bounds 可能不正确
  - `Missing fixed bounds`

`Emitter State` 与生成设置可确认：

- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`
- `Spawn Rate > SpawnRate = 1000000.0`
- `Spawn Probability = 1.0`

`Initialize Particle` 当前至少可确认：

- `Lifetime Mode = Random`

从系统概览还能看到 `Empty` 节点上已经新增 `Sample Texture` 模块，左侧预览窗口里也出现了大量分散的白色笔触状粒子，说明教程此时正让粒子按照贴图中的黑白分布生成，而不是像前几段那样只生成极少量 flare

这一帧的关键结论是：

1. 当粒子数量显著增加时，发射器从 `CPUSim` 切到 `GPUCompute Sim`
2. 粒子不再只靠固定坐标生成，而是通过 `Sample Texture` 从纹理读取分布信息
3. 切到 GPU 后必须单独处理 `fixed bounds`，否则可见性和剔除会出问题

因此，这一张图已经把本段的三个主题串起来了：发射器结构调整、GPU 计算切换，以及贴图驱动的高密度粒子生成
这张图回到关卡视图，目的是直接验证纹理采样粒子层在实际场景中的可见效果。字幕明确说“现在我们都能完美地看到它们”，说明前面关于 GPU、bounds 和贴图采样的调整已经开始得到稳定结果

画面中可确认：

- 角色 `Gideon_Inquisitor` 站在右侧，处于伸手动作中
- 左侧出现一整列向上延展的粒子柱
- 每个粒子呈小型亮点或柔和发光斑，整体分布形成竖直带状体积
- 这些粒子不再是单个 flare 或环形面片，而是明显的大数量粒子群

当前选中的系统实例是 `NS_MagicProjectiles2`

右侧 `Details` 面板可确认：

- `Location = (-170.0, -347.0, 0.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_MagicProjectiles`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

底部 `Content Browser` 当前定位在：

- `Content > VFX_Library > Niagara > MagicProjectiles`

列表中可见系统资源 `NS_MagicProjectiles`

这张图说明教程已经把同一个 Niagara 系统作为一个独立实例摆到场景里，用来专门观察纹理采样粒子的最终可见结果，而不是只在系统编辑器预览窗口里看。通过把实例移到单独位置，可以更清楚地检查：

1. GPU 粒子在关卡里是否真正可见
2. 贴图采样形成的密集分布是否足够清晰
3. 系统实例的世界位置和缩放是否会影响这一列粒子的整体轮廓

因此，这一帧是本段的关卡级验收：此前通过 `Sample Texture` 和 `GPUCompute Sim` 搭出来的粒子层，现在已经能在场景中稳定显示成一组高密度、易于观察的粒子体

### 00:39:56-00:44:51 GPU、CPU、粒子

- 本段定位：GPU、CPU、粒子。
- 知识点：它们消失了 为什么 我还展示了我们有这些限制的构围 当然,当我们使用CPU 需要展示给你们看 这样就全部都可以了 我没有做所有事情就很棒了。
- 知识点：因为它们在世界上自动更新 也就是 这些构围自动增长 关于在哪里的粒子上 也就是它们飞起来 而这些构围自动增长 如果我们使用CPU 我们必须把它们设定成本。
- 知识点：也有设定 但可以写得很顺利 我们看到 我们看到它变化 不过不过 我已经出生了 它们变化了 当我们使用CPU 它们做了什么 我们必须把它们设定成本。
- 知识点：例如 如果它们飞得很高 我们只能改变 我们看到它们 从这个角度不见了 如果它们 在中间的地方 需要在5的位置 改变粒子。
- 知识点：现在有多少粒子在生成 250 但在极限时 有250 000 你看到很多 现在它们 在一定的时间内 如果我去到粒子。
- 知识点：例如 你看到10 20秒 它们只是生成34秒 你看到有很大的分别 那就是 它们是数百万 如果我没有 一次过充电 因此 这些是我们 在我们留下很多粒子时。
- 知识点：它们问我们 我们用的是什么 在GPU上 因为我们留下很多粒子 在用专辑的数字 在本体上 它们不影响 在游戏中的表现 这里你也要小心 例如 为什么按照常词。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`CPU`、`粒子`。

**关键画面：**

这张图处于 `GPU、CPU、粒子` 段，当前在关卡里直接观察高密度粒子系统的中心点和分布范围。字幕明确说“这里就是我们的中心，一切都从这里起源”，画面也确实显示粒子从地面附近一个中心原点向上扩散成细长柱状体

场景与系统实例可确认：

- 当前选中的实例是 `NS_MagicProjectiles2`
- 角色 `Gideon_Inquisitor` 位于右侧，保持伸手姿态
- 左侧到中部是一整列向上延展的细小亮点粒子
- 中心原点处可见三轴 gizmo，说明教程正在强调粒子分布的世界空间起点

右侧 `Details` 面板可确认：

- `Location = (-170.0, -347.0, 0.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_MagicProjectiles`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

这一帧要说明的重点不是颜色，而是粒子系统的“中心”和“可见范围”概念：

1. GPU/CPU 粒子最终都要围绕一个系统实例中心或局部原点展开
2. 当粒子大量向上飞散时，真正决定可见性的，不只是粒子有没有生成，还包括这个中心附近的 bounds 是否能覆盖整段运动范围
3. 如果中心和粒子扩散方向不匹配，或 bounds 没跟上，画面就会出现中途消失、只在某个角度可见等问题

因此，这张图相当于本段的空间基准图：先明确系统实例原点在哪里，再讨论 GPU 与 CPU 模拟下 bounds 和可见性为什么会不一样
这张图继续在关卡里观察同一个 `NS_MagicProjectiles2` 实例，但相机已经切到更高、更远的视角，专门看高密度粒子群在远景中的可见性。画面中央偏下只剩一束细长的粉紫色竖直粒子带，底部右侧还能看到一小部分白色角色或道具轮廓

从这一帧可以可靠确认：

- 粒子系统在远距离下不再明显显示为离散亮点，而被视觉上压成连续的细柱
- 远景里可见范围高度明显增加，说明相机视角变化后，是否还能持续看到整束粒子，已经成为当前检查重点
- 当前实例仍为 `NS_MagicProjectiles2`
- 右侧 `Transform` 仍保持：
  - `Location = (-170.0, -347.0, 0.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`

字幕说“然后我们逐渐过渡到关键点”，结合本段上下文，这里的“关键点”就是：大量粒子在不同视角和距离下，会不会因为 GPU/CPU 模拟方式和 bounds 设定不同而出现突然消失或显示不完整

这张图可以这样理解：

1. 当粒子密度足够高时，近景里看到的是大量点状粒子，远景里则会被视觉整合成一束连续体
2. 这类连续体最容易暴露 bounds 问题，因为一旦包围范围不对，整束粒子会从某个视角突然被截掉
3. 因此教程需要从多个距离反复看同一系统，确保可见性问题不是偶然视角造成的

这一帧的作用，就是把讨论从“粒子有没有生成”推进到“在实际远景镜头里能不能稳定看到完整形态”
这张图回到 `NS_MagicProjectiles` 的系统编辑器，并且打开了 `Bounds` 与 `Performance` 相关视图，用来直接比较当前各发射器的粒子量级和 GPU bounds 管理成本。字幕给出的结论是：对于这种简单的事情，需要使用 `CPU`

当前系统概览中可确认：

- 中央可见 `GlowCenter` 发射器
- 右侧可见 `Empty` 发射器
- 下方时间轴里同时存在：
  - `Empty`
  - `Flare`
  - `GlowBackground`
  - `GlowCenter`

左侧预览窗口直接叠加了粒子统计信息，能可靠读到：

- `Source`、`Ribbon_Magic`、`Ribbon_GlowDark`、`Ribbon_Glow`、`Ribbon_Dark`、`Glows`、`Lights`、`Flare`、`GlowBackground`、`RingChroma`、`GlowCenter` 等层的当前粒子数都较低
- `Empty` 一项显著更高，显示为：
  - `13343 Current`
  - `262975 Max(est.)`

右侧 `Details` 面板当前虽然停留在 `GlowCenter` 的参数界面，但顶部警告和发射器属性仍清楚显示了本段的 GPU 议题：

- 发射器使用 GPU 且仍在 `dynamic bounds` 模式
- `Missing fixed bounds`
- `Sim Target = GPUCompute Sim`
- `Calculate Bounds Mode = Dynamic`

`GlowCenter` 当前可见的生命周期设置还包括：

- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`
- `Spawn Burst Instantaneous > Spawn Count = 1`
- `Spawn Time = 0.0`

结合左侧统计和字幕，这张图要表达的是一个工程判断：

1. 不是所有层都值得切到 GPU
2. 像 `Empty` 这种粒子量级极高、需要大范围更新的层，GPU 有明确价值，但也会带来 fixed bounds 等额外管理成本
3. 像 `GlowCenter` 这种简单、粒子数极低的层，如果仍放在 GPU 路径上，收益有限，反而增加维护复杂度

因此，这一帧给出的核心结论是：在 Niagara 系统里应按发射器复杂度分工，重粒子层用 GPU，简单且低数量的发光层优先放在 CPU 或保持更轻量的实现

### 00:44:52-00:48:16 颜色

- 本段定位：颜色。
- 知识点：现在需要 把所得到的 1-2的东西 如果我没错 啊 没有 0.5 这些生命是需要的 我会改变 这是生命 还有 基本上 是大小 需要有 很小的。
- 知识点：有很多的 但很少的 你不必把对方放进去 形状不需要 它们会比较 光滑于这个质感 这怎么办 这些东西 真是有趣 我们把质感交给人 让我们用一些光 像这种东西。
- 知识点：需要 把这个东西打开 这是这个质感 它会只是用来 做一个位置 需要用一个质感 像是引引力的地方 这是质感 我们有多大质量的地方 会有生物。
- 知识点：这些都是生物 这不是质感 所以你们明白 我现在把它升起来 我们看看 它还是 在全球的质感 如果我把它放在地区 它一定会在同一个地方 但想象一下。
- 知识点：你们在那里 我不知道 你们需要 把质感生出来 它还在移动 可以 只是增加生命 在那里一两个 是的 现在它在那里旋转 但重点是 比如说 我们移动 升起来。
- 知识点：它只是 生成了质感 在这个质感上 这是一个很酷的东西 但你们要 小心于于 你不常用它 在很很少的情况下 它还是 让我们看到 很多生物 这就是 很多生物。
- 知识点：在这里生成了 但它看起来很酷 这就是 我们先从原则上开始 需要把它升到最低 然后 也会把RGB 放在地区 这就是 它只是看起来 是这个质感的颜色。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图处于 `颜色` 段，当前重新聚焦在高数量粒子用的 `Empty` 发射器，并直接在 `Initialize Particle` 里调颜色、寿命和尺寸。目标明显是让这批由纹理采样生成的粒子，看起来更像有控制的彩色发光点，而不是无差别的默认粒子

`Empty` 发射器当前可见结构

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
  - `Add Velocity Linear`
  - `Shape Location Sphere`
- `Particle Update`
  - `Particle State`
  - `Gravity Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Initialize Particle` 当前可确认参数

- `Lifetime Mode = Random`
- `Lifetime Min = 1.0`
- `Lifetime Max = 2.0`
- `Color Mode = Random Range`
- `Color Minimum` 为偏粉紫色
- `Color Maximum` 为更亮的粉紫色
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 5.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

左侧性能统计还能确认当前 `Empty` 的粒子量级：

- `156670 Current`
- `286686 Max(est.)`

这一帧说明本段“颜色”处理不是在材质里继续调贴图，而是先从粒子基础属性层面下手：

1. 把寿命控制在 `1.0 - 2.0` 秒之间，避免粒子停留过久
2. 用 `Random Range` 给粒子分配一组接近但不完全相同的粉紫色，形成细微色差
3. 把精灵尺寸限制在统一且较小的 `5.0`，让高数量粒子仍保持细腻颗粒感

因此，这一张图给出的关键结论是：对于这种基于纹理采样的大量粒子，先在 `Initialize Particle` 里把寿命、颜色区间和基础尺寸收住，才能让后续画面既有密度又不显得杂乱
这张图继续在 `Empty` 发射器的 `Initialize Particle` 里收紧颜色层参数，重点变成“更短寿命、更小尺寸、但仍保留颜色随机”。字幕虽然说“可以在那增加一两倍的寿命”，但当前画面里实际可读到的数值，是寿命区间已经被压得比上一张更短

当前可确认的 `Initialize Particle` 参数：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.25`
- `Lifetime Max = 0.5`
- `Color Mode = Random Range`
- `Color Minimum` 仍为粉紫色
- `Color Maximum` 仍为更亮的粉紫色
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 1.0`

左侧统计信息还能确认当前 `Empty` 的粒子量已经明显下降为：

- `40876 Current`
- `49052 Max(est.)`

与上一张相比，这里能明确看出三处关键收束：

1. 粒子寿命从 `1.0-2.0` 收缩到 `0.25-0.5`
2. 精灵尺寸从 `5.0` 缩小到 `1.0`
3. 当前粒子量从十几万量级降到四万量级左右

这一组变化说明教程在做的不是单纯“增加更多颜色”，而是在让纹理采样粒子变得更轻、更细、更像闪烁颗粒。寿命更短意味着粒子不会拖成持续雾状，尺寸更小意味着屏幕上看到的是更细的点状噪声，配合保留的粉紫色随机范围，就能让这一层看起来像沿着纹理区域跳动的微小能量粒子
这张图把重点从 `Initialize Particle` 切到 `Sample Texture` 模块本身，说明这一段的颜色处理已经进一步依赖贴图采样与筛选规则。字幕明确说“我们将使用这个纹理作为基础来丢弃我们的……”，结合右侧面板内容，可以可靠判断这里是在用贴图亮度或区域分布来决定哪些粒子被保留、哪些粒子被剔除

`Empty` 发射器当前仍包含：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
- `Particle Update`
  - `Particle State`
  - `Gravity Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Sample Texture` 面板当前可确认设置

**Texture Sampling**
- `Sample Texture` 已启用
- `Texture = T_Glow`
- `Texture User Parameter = None`
- `Mip Level = 0.0`
- `Apply Sampled RGBA to Particle Color` 未勾选

**Texture UV**
- `UV = (0.0, 0.0)`
- `Generate UV Using Importance Sample` 已启用

**Importance Sampling**
- `Importance Texture = T_InvokeArea`
- `Texture User Parameter = None`
- `Importance Method = RGB Luminance`
- `Premultiply Importance Alpha` 未启用
- `Importance Threshold = 1.0`
- `Kill Particles If Their Importance Samp...` 未启用

**Transform**
- `Transform UV Into Position` 已启用
- `UV Origin = SimulationPosition`
- `UV Scale = 500.0, 500.0`
- `Rotation Mode = None`
- `Orient UV To Camera` 未启用
- `Apply Transform UV to Particle Posi...` 已启用

左侧预览窗口里已经不再只是普通散点，而是能清楚看到一个由大量白色粒子勾出的魔法阵/圆环图案，这说明粒子分布确实已经被纹理图形本身强约束，而不是自由散布

这张图给出的核心含义是：

1. `T_Glow` 提供基础采样纹理
2. `T_InvokeArea` 作为重要性纹理，决定哪些 UV 区域更值得生成粒子
3. `RGB Luminance` 被用作亮度判定依据
4. `Transform UV Into Position` 和 `UV Scale = 500` 把纹理空间直接映射成世界中的粒子排布范围

因此，本段最后这张图明确证明了“颜色/分布来自纹理”这一点：粒子不是随机涂在空间里，而是沿着指定贴图的亮部和图案结构生成，最终在世界中重建出一个清晰的魔法阵形状

### 00:48:24-00:53:20 颜色

- 本段定位：颜色。
- 知识点：就是 会发生什么事 比如说 需要有两个数字 而它们会相比 如果A 是 比B少 也就是需要有 一个弧形 在这里需要分开 而在这时 1500的。
- 知识点：一秒钟 需要做 是的 然后 V 需要看到 它们不立即生长 但就像是 转移的一样 可以放一秒 让你们可观察到 在这三秒钟 发生的事 这是一个有趣的东西。
- 知识点：而我们不去全程 我们还没去全程 我们已经有95% 它们 可以用不同的颜色 而且 它现在 估计 一直都在地上 我忘了加一些东西 而这里 它们是 对镜头的指向。
- 知识点：我们不需要它 需要用它为角度 也就是可以 例如 把它们放在 我们想要的地方 所以我放了一个X 现在它转向旁边 而它会带我们到哪里 让我们看看。
- 知识点：它是怎么看的 这让我最有趣的 是的 我们看看 这个镜头 这是 它是完全转向 这个角度 就是 它在我们国家 制作的地方 只是我们的预算 是的 现在我可以删除。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图继续处理 `Empty` 发射器里的纹理采样粒子，但重点已经从“按纹理生成”转到“按规则剔除”。右侧当前显示的是 `Sample Texture` 模块的 `Sample Rejection` 配置，字幕也明确提到“如果 A 小于 B”，说明教程正在通过比较规则筛掉一部分粒子

当前可确认的 `Sample Texture` 相关配置

**Texture Sampling**
- `Sample Texture` 已启用
- `Texture = T_Glow`
- `Texture User Parameter = None`
- `Mip Level = 0.0`
- `Apply Sampled RGBA to Particle Color` 未启用

**Texture UV**
- `UV = (0.0, 0.0)`
- `Generate UV Using Importance Sample` 已启用

**Importance Sampling**
- `Importance Texture = T_InvokeArea`
- `Importance Method = RGB Luminance`
- `Importance Falloff = 1.0`

**Transform**
- `Transform UV Into Position` 已启用
- `UV Origin = SimulationPosition`
- `UV Scale = 500.0, 500.0`
- `Rotation Mode = None`
- `Apply Transform UV to Particle Position` 已启用

**Sample Rejection**
- `Enable Sample Rejection` 已启用
- `Comparison Type` 下拉已展开
- 下拉列表中可见：
  - `A Greater Than B`
  - `A Greater Than Or Equal To B`
  - `A Equal To B`
  - `A Not Equal To B`
  - `A Less Than B`
  - `A Less Than Or Equal To B`
- 当前字幕所指向的规则是 `A Less Than B`

左侧预览窗口里已经能看到一个由粒子勾出的白色魔法阵图案，说明在启用 rejection 之前，粒子本来会覆盖较大面积；现在通过比较采样值和阈值，只保留满足条件的区域

这一帧可以理解为本段的关键规则设定：

1. `A` 代表当前采样值或重要性结果
2. `B` 代表用于比较的阈值
3. 当规则设成 `A Less Than B` 时，低于阈值的样本会被单独筛选或剔除

因此，这张图的重点不是新增颜色，而是用比较逻辑把粒子从“整张纹理都能生成”进一步收缩到更受控的局部区域，为后面更精确的颜色/形状控制打基础
这张图继续细化 `Sample Rejection`，但重点已经从“选哪个比较规则”推进到“比较阈值 B 如何随时间变化”。右侧面板当前清楚显示，`Comparison Value (B)` 不再是常量，而是一个 `Float from Curve`

当前 `Sample Rejection` 可确认配置

- `Enable Sample Rejection` 已启用
- `Comparison Type = A Less Than B`
- `Comparison Value (A) = RGB Luminance`
- `Comparison Value (B) = Float from Curve`

曲线与驱动方式可确认

- 曲线资源类型：`Curve for Floats`
- `CurveIndex = EMITTER.Age`
- `Scale Curve = 1.0`
- 曲线图形从左高右低，表示随着 `EMITTER.Age` 增长，阈值会逐步下降

从可见曲线形态可以可靠得出：

1. 发射器刚开始时，`B` 处在较高值，剔除条件更严格或更偏向保留亮部
2. 随着发射器年龄推进，`B` 持续下降，粒子保留/剔除范围会随时间发生过渡
3. 这种变化不是瞬间切换，而是沿曲线平滑演化

左侧预览窗口里，魔法阵粒子分布依旧清晰，但当前 `Empty` 的统计值变为：

- `17855 Current`
- `56676 Max(est.)`

说明在启用时间驱动的 rejection 后，当前屏幕上保留下来的粒子量已经比上一些阶段更受控制

这张图的核心意义是：粒子筛选不再是固定阈值判断，而是“随发射器年龄变化的动态阈值”。这样一来，纹理中的某些区域可以在早期先出现、后期再逐渐放开或收缩，从而让魔法阵不是一次性完整显现，而是带有时间推进感地生长、消隐或过渡
这张图仍在 `Empty` 发射器的 `Sample Texture` 模块中，但当前重点已经从 rejection 规则本身，转到贴图如何映射到世界空间。右侧展开的是 `Transform` 区域，说明教程正在调纹理图案在场景中的大小、朝向和局部对齐方式

当前仍可确认的基础采样配置：

- `Texture = T_Glow`
- `Importance Texture = T_InvokeArea`
- `Importance Method = RGB Luminance`
- `Generate UV Using Importance Sample` 已启用
- `Enable Sample Rejection` 已启用
- `Comparison Type = A Less Than B`
- `Comparison Value (A) = RGB Luminance`
- `Comparison Value (B) = Float from Curve`

`Transform` 区域当前可确认：

- `Transform UV Into Position` 已启用
- `UV Origin = SimulationPosition`
- `UV Scale` 已从前面的超大范围缩小到约 `125` 量级
- `Rotation Mode = Axis Angle`
- `Rotation Axis = (1.0, 0.0, 0.0)`
- `Rotation Angle = 0.0`
- `Rotation Angle Type = Normalized Angle (0-1)`
- `Rotation Coordinate Space = Local`
- `Orient UV To Camera` 未启用
- `Apply Transform UV to Particle Position` 已启用

左侧预览窗口里，魔法阵图案已经被压到更小、更聚焦的区域内，不再像前几张那样大面积铺开；粒子统计也显示 `Empty` 当前大约在：

- `47519 Current`
- `216676 Max(est.)`

这张图说明当前的颜色层控制已经不只是“筛掉哪些像素”，而是开始决定“保留下来的图案在世界里有多大、朝哪边、贴在哪里”。通过把 `UV Scale` 从更大的取值收缩到大约 `125`，再配合局部轴旋转设置，教程可以把原本过大的魔法阵纹理压缩成更适合附着在角色周围或某个局部区域的尺寸

因此，这一帧给出的关键结论是：`Sample Texture` 的最终效果由三部分共同决定

1. 纹理本身提供图案
2. `Sample Rejection` 决定哪些图案区域被保留
3. `Transform` 决定这些被保留的图案以多大尺度、什么朝向落到世界中的粒子位置上

也就是说，本段到这里已经把“颜色”从单纯色值问题，推进成“带图案的彩色粒子区域如何在空间中被塑形”

### 00:53:20-00:58:06 颜色

- 本段定位：颜色。
- 知识点：所有东西 可以删除 0.15 哦 还有 在这里 要是能够 转向好 所以它不能 太长 我们需要0.2一次 可以删除 它们可以 把我们的东西 降低一点。
- 知识点：0.2 可以 更多地 增加了 额外的额外的额外 还有 让我们有趣的东西 可以加 把它们可以加速 例如 在这个方向 可以加速一个蛋 我们看看。
- 知识点：这是否是正确的方向 是的 这是所有的 我们看到它不是制作的 它们是在这种方向飞行 我们有什么错误 很清楚 很棒 也许0.15 我 会 删除 所以 它们不会。
- 知识点：一直到最后 我们只需要 调整生命时间 哦 这很正确 在整体上 非常好 可能0.13 这样它们 不会给我们 这些额外的东西 可以 很明显地 我觉得 可以。
- 知识点：调整到这种程度 好 可能 有些东西 会被看到 然后 为了细节 我们有什么错误 需要计算什么大量的额外 2.50 让它们变化 它们还在移动 在这儿 和在这儿。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图继续在 `Empty` 发射器上做颜色段的收束，不过重点已经从纹理采样规则转到发射器整体节奏控制。右侧当前展开的是 `Emitter State`，字幕明确提示“持续太久，你需要 0.2”，说明教程在压缩循环时长，避免这一层魔法阵粒子停留过久

当前 `Emitter State` 可确认：

- `Life Cycle Mode` 可在 `System / Self` 间切换
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 0.2`
- `Recalculate Duration Each Loop` 未启用
- `Loop Delay = 0.0`

系统概览中，`Empty` 当前仍是 GPU 粒子发射器，结构可见为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
- `Particle Update`
  - `Particle State`
  - `Gravity Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

左侧统计信息还能确认当前 `Empty` 大约为：

- `20850 Current`
- `224281 Max(est.)`

左侧预览窗口中，魔法阵图案依然清晰可见，但已经被控制在更局部、更短促的表现方式里。把 `Loop Duration` 压到 `0.2` 的意义，是让这一层不再长时间停留在屏幕上，而是更像一闪而过的局部符文/纹理能量信号

因此，这一帧的核心结论是：在颜色和图案都已经成形之后，还必须回到发射器生命周期层面收时长，否则即使单帧看起来正确，整段动画仍会因为持续过久而显得拖沓
这张图继续压缩 `Empty` 发射器的生命周期，已经从“短循环”进一步收束成“一次性短脉冲”。右侧 `Emitter State` 当前可确认的设置，比上一张更激进：

- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 0.1`
- `Loop Delay = 0.0`

与上一张相比，这里发生了两个关键变化：

1. `Loop Behavior` 从 `Infinite` 改成 `Once`
2. `Loop Duration` 从 `0.2` 继续缩到 `0.1`

系统概览中，`Empty` 发射器当前还能确认：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
  - `Add Velocity Linear`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧统计信息显示 `Empty` 这一层当前约为：

- `12055 Current`
- `266766 Max(est.)`

左侧预览窗口中的魔法阵图案已经明显更像一次局部闪现，而不再是持续停留的纹理层。把循环模式改成 `Once` 后，这层粒子会只在一个极短时段内完成生成和表现，更适合作为某个瞬时能量事件，而不是背景持续效果

因此，这张图的核心含义是：教程正在把这个纹理采样粒子层从“持续播放的装饰层”改造成“短促触发的瞬时特效”。这不仅能减少视觉拖尾，还能避免图案过久悬停在场景里抢走主体动作的注意力
这张图是本段收尾时的进一步整理结果。当前这层发射器在系统概览中已经显示为 `SampleTexture`，说明教程已经把它从一个通用临时层整理成明确以纹理采样为核心职责的发射器。右侧依然停留在 `Emitter State`，并把短时长微调到一个更折中的值

当前可确认的生命周期设置：

- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 0.13`
- `Loop Delay = 0.0`

与上一张相比，主要变化是：

1. 发射器名称显示为 `SampleTexture`
2. `Loop Duration` 从 `0.1` 回调到 `0.13`
3. 这一层已经不再只是最初的 `Empty` 测试节点，而是更明确地承担采样纹理粒子层的角色

当前系统概览中 `SampleTexture` 发射器可见结构包括：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
  - `Add Velocity Linear`
- `Particle Update`
  - `Particle State`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Drag`
  - `Solve Forces and Velocity`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

左侧预览窗口中可以看到中心区域有一团短促而高亮的紫白色发光，同时外围仍保留细碎粒子，说明这层采样粒子在短时爆发时既有中心亮点也有外扩细节。统计信息还能确认这一层当前约为：

- `11991 Current`
- `134343 Max(est.)`

这张图的意义在于：教程没有把时长一味压到最短，而是在 `0.1` 基础上略微回调到 `0.13`，以换取更自然的瞬时表现。再配合 `Curl Noise Force`、`Drag`、`Scale Color` 这些更新模块，粒子不会只是静态闪现，而会在极短时间里带一点轻微扰动、衰减和颜色变化

因此，这一帧给出的最终结论是：本段“颜色”调节已经完成从大图案持续显示到短促采样爆发的过渡，发射器时长、命名和更新模块都已经收束到一个更可用于正式效果的状态

### 00:58:06-00:59:31 关键流程 14

- 本段定位：关键流程 14。
- 知识点：它 调整到这种额外 非常非常严格 Dim7 仍然可以被调整 数字的部分 在哪里 需要这多是足够的 虽然可能甚至是少 这并没有 在我们国家 吸引很多注意。
- 知识点：在这里 它们可以 被认为很多 这会吸引很多 注意 我们不需要这些 我们从摄像机看 这种准备 就像在炸裂一个图线 但我们已经准备好了 那我们就会 更了解。
- 知识点：还有更多的东西 例如如何把一个 图像的效果 加上一个效果 我还想要 有一个东西 也就是 预测也确定了 他之前 炸裂了图线 那就是这里 谢谢观看 拜拜。

**关键画面：**

这张图进入 `关键流程 14`，本质上是在对上一段已经基本成形的 `SampleTexture` 发射器做最终数值收束。右侧仍然是 `Emitter State`，但 `Loop Duration` 已经被微调到一个更细的非整值，说明教程正在为最终成片效果做最后一轮“刚刚好”的持续时间修正

当前可确认的 `Emitter State` 设置：

- 发射器名：`SampleTexture`
- `Life Cycle Mode` 可在 `System / Self` 间切换
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration ≈ 0.1335`
- `Loop Delay = 0.0`

系统概览中，`SampleTexture` 当前结构仍为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Rate`
- `Particle Spawn`
  - `Initialize Particle`
  - `Sample Texture`
  - `Add Velocity Linear`
- `Particle Update`
  - `Particle State`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Drag`
  - `Solve Forces and Velocity`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

左侧预览窗口中能看到一圈围绕亮点中心展开的符文环，表现上已经非常接近最终效果；左上统计里 `SampleTexture` 当前约为：

- `40859 Current`
- `134343 Max(est.)`

字幕说明“Dim 7 仍然可以减少”，结合当前画面可以合理理解为：某个维度、参数或持续量级虽然已经收紧，但仍有继续下压的空间。教程此时强调的不是结构性修改，而是末端的数值敏感度调整

因此，这一帧的意义在于：正式效果往往不是靠大改，而是靠最后这些小数级别的时长修正来决定观感。把 `Loop Duration` 从粗略值调到约 `0.1335`，就是在避免符文层既不过早消失，也不过久停留
这张图继续停留在 `SampleTexture` 发射器上，但检查点已经从 `Emitter State` 回到 `Initialize Particle`。这说明教程在做最后收尾时，不只是改整体循环时长，还要再次确认粒子个体寿命和颜色随机范围是否和当前节奏匹配

当前 `Initialize Particle` 可确认的参数：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.25`
- `Lifetime Max = 0.5`
- `Color Mode = Random Range`
- `Color Minimum` 为偏粉紫色
- `Color Maximum` 为更亮的粉紫色
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 1.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

左侧预览窗口中，中心亮点和外圈细碎粒子同时存在，但整体亮度与覆盖范围已经比早期测试版更克制；左上统计显示当前 `SampleTexture` 约为：

- `4087 Current`
- `133433 Max(est.)`

这张图的意义在于把“整体节奏”和“单粒子属性”重新对齐。当前系统已经改成短促触发，如果粒子寿命仍然过长、尺寸仍然过大，画面就会在发射器结束后留下过多残留；而现在保持 `0.25-0.5` 的寿命、`1.0` 的统一尺寸和受控的粉紫色随机范围，能让这层粒子在一次短脉冲里完成出现、闪烁和消退

因此，这一帧说明最终效果的成立依赖两层配合：

1. `Emitter State` 决定这层什么时候开始、持续多久
2. `Initialize Particle` 决定单个粒子在这段短时间里长什么样、能活多久、颜色怎么变化

两者一起收紧后，整个采样纹理粒子层才真正变成一个可控的“结束镜头用短爆发细节”
这张图回到最终的关卡 Sequencer 视图，相当于本页内容的结果镜头。角色 Gideon 站在左侧，三道紫粉色投射物朝右侧白色圆柱飞去，地面中间保留了一处局部高亮紫色能量点。字幕开始提到“例如，如何将效果附加到角色上”，说明当前这一页的调试流程已经基本结束，后续会转到效果挂接和扩展应用

画面与时间线可确认：

- 当前序列为 `LQ_MagicProjectiles`
- 帧率为 `30 fps`
- 播放头位于约 `1.43`
- `Camera Cuts` 轨道存在
- `Gideon_Inquisitor` 轨道下可见：
  - `Animation`
  - `Weight = 1.0`
  - `Transform`
- 动画片段当前仍处于 `Primary_Attack_A_Medium` 向 `Idle` 过渡区间

场景中当前可见的结果要点：

1. 三道主投射物拖尾已经稳定形成，方向统一指向白色圆柱
2. 角色出手点附近保留紫粉色核心光效
3. 地面上额外有一个短促的局部高亮点，说明前面调好的短时采样粒子/附加细节层已经能在镜头里出现，但不会长期停留
4. 白色圆柱仍作为受击或对照目标存在，用来验证飞行方向和构图

这张图的意义不在新增参数，而在于给出本页整段工作的综合验收结果：角色动作、主拖尾、局部附加光效和镜头中的目标物已经能够同时协同工作。换句话说，前面在 `SampleTexture`、颜色、生命周期、采样剔除和粒子时长上的所有微调，最终都落实成了这张镜头内可见且不抢戏的局部细节增强

因此，这一帧也自然把话题引向下一步：当这些局部效果已经调顺之后，就可以进一步研究如何更正式地把它们附着到角色或其他对象上

## 补充视觉证据

### S01 00:00:59

这张补充图记录的是关卡级后处理材质设置，不是 Niagara 发射器本身。当前选中对象为 `PostProcessVolume`，时间线播放头在序列 `LQ_MagicProjectiles` 的 `0.00` 位置，说明这是开场镜头的基础画面风格参数证据

当前场景可确认：

- 关卡视图中左下是 `Gideon_Inquisitor`
- 中间偏下是白色 `Cylinder`
- 顶部打开的相关资源标签包括：
  - `NS_MagicProjectiles`
  - `M_MagicRibbon`
  - `MI_MagicRibbon_01`
  - `MI_MagicRibbon_02`
  - `MI_Glow_01`
- 右侧 `Outliner` 中可见：
  - `Cylinder`
  - `Gideon_Inqu...`
  - `LQ_MagicPr...`
  - `NS_MagicPr...`

`PostProcessVolume` 的 `Details` 面板当前搜索关键词为 `mater`，可确认的参数位于 `Rendering Features > Post Process Materials`

- `Post Process Materials`
  - `Array`
  - 数组第 `1.0` 项使用材质 `PPM_DepthFog`
- 该条目右侧可见资源跳转/引用按钮

结合画面整体偏暗、远处地平线和场景景深雾化效果，可以把这张图理解为教程镜头氛围的底层补充证据：除了 Niagara 系统本体，最终观感还依赖 `PostProcessVolume` 挂载的后处理材质 `PPM_DepthFog`。它负责给整个镜头增加深度雾和空间层次，使远处区域压暗、近处主体和特效更容易被凸显

因此，这张补充图的关键结论是：本教程的最终视觉并不只由 Niagara 粒子和材质实例组成，场景级后处理材质同样参与了结果塑形；复现时如果忽略 `PostProcessVolume > Post Process Materials > PPM_DepthFog`，画面氛围会和关键截图存在明显差异

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


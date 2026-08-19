# 13 Sequencer设置和光束随机生成模块制作

# 13 Sequencer设置和光束随机生成模块制作

## 关键术语

- `Module`、`Sequencer`、`Skeletal Mesh`、`PS`、`Mesh`、`材质`、`粒子`、`发射器`、`系统`、`网格`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:05-00:04:45 Sequencer、网格、光束

- 本段定位：Sequencer、网格、光束。
- 知识点：你好,我在第13课再次问候你 这次是第4个例子的第一开始时间 一样地,需要先开始这个角色序列器的设置 在这个例子中呢,可以使用一点这个新功能。
- 知识点：使用Scratch模块电,通过非常简单的脚本 可以随机地将光束效果与缩放网格关联起来 这种模块将简单地制作一次 然后再下次结束雷电的表达。
- 知识点：之后的时间将制作最后的例子爆炸 那么首先,简单地进行序列器设置 现在我打开的关卡是第3个用过冰爆的关卡 这里通过另存当前关卡围的方式保存雷其他名称。
- 知识点：在这里开始出发 序列器同样复制冰心键 要将Standard连接在一起 然后打开序列器 后续会再次删除角色和拐杖 将会引入新的角色 我们这次使用的角色是Viter。
- 知识点：角色英雄的利托尔 进入网格后 这里是骷髅网格 对吧,是写着利托尔 需要拖动这一部分过来 这是长这种人物 结构有点特别吧 这个角色的链条部分。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`序列`、`闪电`、`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 雷电例子关卡起始设置
> - 组成部分: Level Viewport + Content Browser + Outliner + Details + 字幕
> - 所属: `03_Ice_Explosion` 关卡，后续将另存并转入雷电例子。
> - 目的: 记录从冰爆关卡开始复制场景设置，用作第 4 个例子的初始关卡状态。
>
> Level Viewport:
> - 视口处于 `Perspective / Lit`。
> - 场景中只有大面积棋盘格地面、灯光图标、摄像机/序列相关图标和选中对象 gizmo。
> - 当前选中对象是 `Floor`，地面外框以黄色高亮。
>
> Content Browser:
> - 当前位于 `Content/Coloso_.../Material` 一类目录。
> - 可见示例文件夹 `Ex_01_SwordTrail`、`Ex_02_Earth...`、`Ex_03_Ice_Explosion`、`Ex_04_Thunder...`、`Ex_05_Death...`、`Ex_06_Water...`、`Ex_07_FireExplosion`、`Ex_08_Constella...`。
> - 下方可见多个材质资源，如 `M_Additive...`、`M_Decal_...`、`M_Ribbon...`。
>
> Outliner / Details:
> - 世界为 `03_Ice_Explosion (Editor)`。
> - 可见对象包括 `DirectionalLight`、`01_Swing_Trail`、`Floor`、`PlayerStart`、`PostProcessVolume`。
> - `Floor` 的 Transform 可读值: Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
> - `Floor.Static Mesh` 显示 `SM_Template_Map_...`，Material Element 0 为 `MI_ProcGrid`。
>
> 字幕:
> - 字幕文字为“这次是第四个例子的第一开始时间。”
>
> 画面含义: 该帧记录雷电例子开始前仍处于冰爆关卡，选中地面对象并准备基于现有关卡和示例目录继续设置。
> 图表转写（UE-GTXT v4）
> - 类型: `04_Thunder_Explosion` Sequencer 初始轨道
> - 组成部分: Sequencer + Content Browser + Outliner + 字幕
> - 所属: `04_Thunder_Explosion` Level Sequence / 关卡。
> - 目的: 复制冰爆 Sequencer 的相机和震动轨道，并从 Riktor 角色资产目录选择新角色。
>
> Sequencer:
> - 窗口标题为 `Sequencer*`，右上角序列名为 `04_Thunder_Explosion*`。
> - 帧率为 `30 fps`。
> - 顶部时间轴可见 `0000` 到 `0120`，当前播放头在起始附近。
> - `Camera Cuts` 轨道显示一段摄像机预览条。
> - `Cine Camera Actor` 下展开 `CameraComponent`。
> - `Camera Shake` 轨道使用 `ExShake_01_C`。
> - CameraComponent 可读字段包括 `Current Aperture = 2.8`、`Current Focal Length = 25.0`、`Manual Focus Distance (Focus Settings) = 100000.0`。
> - `Spawned` 复选框处于勾选状态。
>
> Content Browser:
> - 当前路径位于 `Content/Coloso_.../ParagonRiktor/Characters/Heroes/Riktor/Meshes`。
> - 可见 `belly_Riktor`、`belly_Riktor_...`、`Paragon...`、`Riktor`、`Riktor_Cyb...`、`Riktor_...`、`SK_Jump...` 等资源。
> - `Riktor` 资源被选中，类型显示 `Skeletal Mesh`。
>
> Outliner:
> - 可见 `04_Thunder_Explosion (Editor)`、`Lighting`、`DirectionalLight`、`LevelSequence...`、`CineCamera...`、`PlayerStart` 等对象。
>
> 字幕:
> - 字幕文字为“对吧？是写着利托尔的”。
>
> 画面含义: 该帧记录新雷电关卡已建立 Sequencer，并定位到 `Riktor` Skeletal Mesh，用于后续把角色加入序列。
> 图表转写（UE-GTXT v4）
> - 类型: Riktor 角色 Sequencer 轨道加入
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner + Details + 字幕
> - 所属: `04_Thunder_Explosion` 关卡 / Level Sequence。
> - 目的: 检查新角色加入序列后，角色外观、动画段和关卡对象关系。
>
> Level Viewport:
> - 视口处于 `Perspective / Lit`。
> - 地面 `Floor` 仍被选中并以黄色外框高亮。
> - `Riktor` 角色站在地面中央附近，造型为重甲角色，双臂带有机械臂/链条状部件。
> - 角色脚下可见选中对象 gizmo；不额外断言该 gizmo 与角色或地面的坐标语义。
>
> Sequencer:
> - 当前序列为 `04_Thunder_Explosion*`。
> - 当前时间显示约 `0031`，顶部时间轴仍可见到 `0120`。
> - `Cine Camera Actor` 轨道存在。
> - 新增 `Riktor` 轨道。
> - `Riktor / Animation` 轨道中可见动画片段 `Ability_Ultimate`。
> - `Riktor / Spawned` 复选框处于勾选状态。
>
> Content Browser / Outliner:
> - 左侧仍位于 Riktor Meshes 目录，`Riktor` Skeletal Mesh 被选中。
> - Outliner 中可见 `Cine Camera Actor`、`Floor`、`PlayerStart`、`PostProcessVolume`、`Riktor`、`SpotLight` 等对象。
>
> 字幕:
> - 字幕文字为“这样就把两只手臂和身体的电分别设置。”
>
> 画面含义: 该帧记录 `Riktor` 已加入关卡和 Sequencer，后续会围绕角色双臂与身体分别制作电流效果。

### 00:04:45-00:09:41 粒子、网格、骨骼网格

- 本段定位：粒子、网格、骨骼网格。
- 知识点：再再下次添加另外两个 这样就把两只手臂和身体的电分别设置 那么先设置爆炸 会复制势力2中的爆炸例子 不是40是40 取出例子 真是这个角色。
- 知识点：爆炸形态现在是圆顶形的球体 这将使其半球形爆炸 这会形成一种打开的感觉 如果与这个姿势一起爆炸 在身体展开的瞬间 从开始的瞬间出现 最好。
- 知识点：这次的例子将不会使用Decay了 第一次打开时 编译需要一点时间 文件已完成 然后没用的东西 我就会先关闭 这里都被删除了 我先让灰尘出来了。
- 知识点：发光和 在这种时机爆发之后 电力持续维持着某种东西 需要以与咆哮的感觉 相符合的形式来保持 电力死是在时 先做身体部分 Body就叫这个名字吧。
- 知识点：放进这里 首先是关于这次的例子中学习的功能 适当简单地 测验证效果再给您展示 然后这个框架最后会试图 補捉Admitter 将创建一个空间。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Exp_01` Niagara System 复制后编译状态
> - 组成部分: Niagara Preview + System Overview + Parameters + Timeline + 编译日志
> - 所属: `Exp_01` Niagara System。
> - 目的: 复制旧爆炸示例并等待 Niagara emitter 编译完成，作为后续身体电流 emitter 的来源。
>
> Niagara Preview / 编译日志:
> - Preview 区中央显示 `Compiling...`。
> - 左侧日志列出正在编译的 emitter: `Decal`、`Glow_01`、`Glow_02`、`Smoke_01`、`Debris_01002`、`Debris_01003`、`Light_01`、`Refraction_01`、`RadialBlur_01`。
>
> System Overview:
> - 系统标题可读为 `Exp_01`。
> - 可见多个 emitter 卡片，其中 `Glow_01`、`Glow_02` 卡片处于 Disabled 状态。
> - 卡片内可见分组包括 `Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Particle Spawn`、`Particle Update`、`Render`。
>
> Parameters:
> - 左下 `Parameters / Active Overview` 面板展开 `System Attributes`。
> - 可见 `SYSTEM Age`、`SYSTEM bCompleteOnInactive`、`SYSTEM CurrentLoopDuration`、`SYSTEM ExecutionState`、`SYSTEM ExecutionStateSource`、`SYSTEM LoopCount`、`SYSTEM LoopedAge`、`SYSTEM NormalizedLoopAge`。
>
> Timeline:
> - 下方 Timeline 可见 `Debris_01002`、`Debris_01003`、`Decal` 等轨道。
> - 当前时间约 `1.18` 秒。
>
> 画面含义: 该帧记录从爆炸例子复制出的 Niagara System 正在重新编译，多个旧爆炸 emitter 仍在系统中，后续会清理或改造成身体电流结构。
> 图表转写（UE-GTXT v4）
> - 类型: `Thunder_Body_01` DynamicBeam 初始结构
> - 组成部分: Niagara Preview + System Overview + Renderer Details + Parameters + Timeline
> - 所属: `Thunder_Body_01` Niagara System。
> - 目的: 新建身体电流 emitter，并用 Ribbon Renderer 输出一条可持续连接的光束。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示一条水平的青蓝色短光束，形态接近两端收尖的 Ribbon。
> - `Empty` 显示 `0 Current, 0 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `100 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - 系统标题为 `Thunder_Body_01`。
> - 可见两个 emitter: `Empty` 与 `DynamicBeam`。
> - `DynamicBeam` 为 CPU emitter，`Emitter State` 显示 Self / Infinite。
> - `DynamicBeam` Stack 可见模块顺序: `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
> - `Ribbon Renderer` 被选中。
>
> Renderer Details:
> - Owner: `DynamicBeam.Ribbon Renderer`。
> - Renderer 类型为 `Ribbon Renderer`。
> - `Material = DefaultRibbonMaterial`。
> - `Material User Param = None`。
> - `Facing Mode = Screen`。
> - `Max Num Ribbons = 0`。
> - `Draw Direction = Front to Back`。
> - `Use GPUInit` 未勾选。
> - `Ribbon Shape.Shape = Plane`。
> - `Use Material Back...` 未勾选。
> - `Width Segmentation... = 1`。
> - `Ribbon Tessellation.Mode = Automatic`。
> - `Curve Tension = 0.0`。
>
> Parameters:
> - `System Attributes` 展开，能读到 `SYSTEM Age`、`SYSTEM bCompleteOnInactive`、`SYSTEM CurrentLoopDuration`、`SYSTEM ExecutionState`、`SYSTEM ExecutionStateSource`、`SYSTEM LoopCount`、`SYSTEM LoopedAge`、`SYSTEM NormalizedLoopAge`。
>
> Timeline:
> - 可见 `DynamicBeam` 与 `Empty` 两条轨道。
> - 当前时间约 `5.40` 秒。
>
> 画面含义: 该帧记录身体电流系统已经由 `DynamicBeam` emitter 通过 Beam 模块和 Ribbon Renderer 生成一条青蓝色连续光束。
> 图表转写（UE-GTXT v4）
> - 类型: `Thunder_Body_01` 光束持续连接状态复核
> - 组成部分: Niagara Preview + System Overview + Renderer Details + Timeline + 字幕
> - 所属: `Thunder_Body_01 / DynamicBeam`。
> - 目的: 检查 `DynamicBeam` 结构在 Timeline 中持续存在，并确认光束仍以 Ribbon 方式渲染。
>
> Niagara Preview:
> - Preview 中仍显示一条青蓝色短光束。
> - 光束呈扁平 Ribbon 外观，中心较亮，两端逐渐收细。
>
> System Overview / Stack:
> - `Thunder_Body_01` 中仍可见 `Empty` 与 `DynamicBeam` 两个 emitter。
> - `DynamicBeam` Stack 保持 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer` 的结构。
> - 右侧 Details 仍对应 `DynamicBeam.Ribbon Renderer`，可见 `Material = DefaultRibbonMaterial`、`Facing Mode = Screen`、`Ribbon Shape = Plane`、`Ribbon Tessellation.Mode = Automatic`、`Curve Tension = 0.0`。
>
> Timeline:
> - Timeline 显示 `DynamicBeam` 轨道从开始处持续到后段，当前播放头约在 `5.40` 秒。
> - `Empty` 轨道只在开头附近显示较短片段。
>
> 字幕:
> - 字幕文字为“继续连接同时变化的结构是这样看的话可以。”
>
> 画面含义: 该帧记录身体电流的基础光束结构已能持续连接，后续可以在此结构上继续做随机位置和角色绑定。

### 00:09:41-00:14:36 Module、PS、粒子

- 本段定位：Module、PS、粒子。
- 知识点：骨骼网格中随机生成 也许下次会学习 骨骼网格位置模块 但在本力中不使用到这个 模块 而是自定义生成一个 Locomodule script。
- 知识点：使用这个 在这里添加模块时 暂时命名为 Scale Position 这样生成后 上面会显示名为Scale Position 点击系统盖缆后。
- 知识点：会返回到可以控制 粒子的发射器的区域 这里有Scratch Script Manager 如果添加模块 可以视为仅在这个粒子。
- 知识点：奈何系统内使用的模块 不能在其他奈何系统中 使用 想要在其他奈何系统中使用 必须制作成可搜索的 奈何模块脚本 这样制作后 在这个系统中调用使用。
- 知识点：需要简单地在这里进行制作 这个脚本本身可能会显得 有些困难 这样一些在这里使用的这些 节点们或函数们 非常多 关于这个的详细说明文档 还没有。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`发射器`、`系统`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Empty.Initialize Particle` 与 `DynamicBeam` 基础光束系统
> - 组成部分: Niagara Preview + System Overview + Initialize Particle Details + Parameters + Timeline + 字幕
> - 所属: `Thunder_Body_01` Niagara System。
> - 目的: 在制作骨骼网格位置模块前，确认 `Empty` emitter 的初始化设置和 `DynamicBeam` 光束结构。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示一条青蓝色短光束。
> - `Empty` 显示 `0 Current, 0 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `100 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - 可见 `Thunder_Body_01`、`Empty`、`DynamicBeam` 三个卡片。
> - `Empty` 为 CPU emitter，Stack 可见 `Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Emitter State`、`Particle Spawn`、`Initialize Particle`、`Particle Update`、`Particle State`、`Render`、`Sprite Renderer`。
> - `Empty.Initialize Particle` 被选中。
> - `DynamicBeam` 为 CPU emitter，`Emitter State` 显示 Self / Infinite；Stack 可见 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `Empty.Initialize Particle`。
> - `Lifetime Mode = Direct Set`。
> - `Lifetime = 5.0`。
> - `Color Mode = Unset`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 可见为 `0.0, 0.0, 0.0`，未启用。
> - `Mass Mode = Unset / Mass of 1`。
> - Sprite、Mesh、Ribbon 相关属性多为 `Unset`。
>
> Parameters / Timeline:
> - `System Attributes` 可见 `SYSTEM Age`、`SYSTEM bCompleteOnInactive`、`SYSTEM CurrentLoopDelay`、`SYSTEM CurrentLoopDuration`、`SYSTEM ExecutionState`、`SYSTEM ExecutionStateSource`、`SYSTEM LoopCount`、`SYSTEM LoopedAge`、`SYSTEM NormalizedLoopAge`。
> - Timeline 当前时间约 `7.62` 秒，`DynamicBeam` 与 `Empty` 轨道均可见。
>
> 字幕:
> - 字幕文字为“也许下次会学习骨骼网格位置模块”。
>
> 画面含义: 该帧记录 `Empty` emitter 用于承载后续位置采样逻辑，当前初始化只设置基础寿命和模拟位置。
> 图表转写（UE-GTXT v4）
> - 类型: `DynamicBeam.Beam Width` 曲线与 `Skel_Position` 模块入口
> - 组成部分: Niagara Preview + System Overview + Beam Width Details + Local Modules/Scratch Script Manager + Timeline + 字幕
> - 所属: `Thunder_Body_01 / DynamicBeam` 与本地模块 `Skel_Position`。
> - 目的: 打开或定位自定义模块前，记录光束宽度曲线和 Scratch Script Manager 中的模块项。
>
> Niagara Preview:
> - Preview 中仍显示青蓝色短 Ribbon 光束。
>
> System Overview / Stack:
> - `Thunder_Body_01`、`Empty`、`DynamicBeam` 均可见。
> - `DynamicBeam.Beam Width` 被选中。
> - `DynamicBeam` Stack 保留 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Beam Width Details:
> - Owner: `DynamicBeam.Beam Width`。
> - `Beam Width = Float from Curve`。
> - 曲线类型为 `Curve for Floats`。
> - 曲线从接近 `0` 快速上升到约 `1.0`，中段逐步下降，末端回到接近 `0`。
> - `CurveIndex = PARTICLES RibbonLinkOrder`。
> - 下方可读数值包括 `10.0` 和 `0.0` 字段。
>
> Scratch Script Manager / Local Modules:
> - 左下当前标签为 `Local Modules`。
> - `Scratch Script Manager` 中可见模块 `Skel_Position`。
>
> Timeline:
> - `DynamicBeam` 轨道前段为绿色片段，后段为蓝色持续片段。
> - 当前时间约 `9.51` 秒。
>
> 字幕:
> - 字幕文字为“这样双击就可以打开”。
>
> 画面含义: 该帧记录光束宽度由 `Particles.RibbonLinkOrder` 曲线控制，并准备打开 `Skel_Position` 自定义模块。
> 图表转写（UE-GTXT v4）
> - 类型: `Skel_Position` Niagara Module Script 空图与参数接口
> - 组成部分: Niagara Script Graph + Details + Parameters + Timeline + Preview + 字幕
> - 所属: `Skel_Position` 模块脚本。
> - 目的: 显示自定义模块脚本刚打开时的基础接口、Usage Bitmask 和 Parameter Map 输入输出。
>
> Niagara Script Graph:
> - 当前标签为 `Skel_Position`。
> - 图中只有一个 `Map Get` 节点。
> - `Map Get` 可见输入 Pin `Source`。
> - 图表上方可见一条横向白色连线/边界线，但图中没有可读端点；不将其写成数据流。
>
> Details:
> - Owner: `Skel_Position` 模块脚本。
> - `Module Usage Bitmask` 显示包含 `Module | Particle Spawn Script | Particle U...`。
> - `Category = Default`。
> - `Provided Dependencies = 0 Array element`。
> - `Required Dependencies = 0 Array element`。
> - `Deprecation Recommendation = None`。
> - `Conversion Utility = None`。
> - `Library Visibility = Unexposed`。
> - `Numeric Output Type Selection = Largest`。
> - `Inline Expression Format = 0 Array element`。
> - `Inline Graph Format = 0 Array element`。
> - `Script Metadata = 0 Map elements`。
> - `Input Sections = 0 Array element`。
> - `Input Parameters`: `InputMap` 类型为 `Niagara Parameter Map`。
> - `Output Parameters`: `OutputMap` 类型为 `Niagara Parameter Map`。
>
> Parameters:
> - 左下 `Active Module` 面板列出 `System Attributes`、`Emitter Attributes`、`Particle Attributes`、`Module Inputs`、`Static Switch Inputs`、`Module Locals`、`Module Outputs`、`Engine Provided`、`Stack Context Sensitive`、`Stage Transients` 等分组。
>
> Timeline / Preview:
> - Preview 仍显示青蓝色短光束。
> - Timeline 当前时间约 `9.03` 秒，可见 `DynamicBeam` 和 `Empty` 轨道。
>
> 字幕:
> - 字幕文字为“所以一点一点进行的时候会有熟悉的瞬间”。
>
> 画面含义: 该帧记录 `Skel_Position` 仍是初始脚本结构，只有 Parameter Map 接口和一个 `Map Get` 节点，后续需要加入 Skeletal Mesh 输入与顶点采样逻辑。

### 00:14:36-00:19:13 Skeletal Mesh、Mesh、材质

- 本段定位：Skeletal Mesh、Mesh、材质。
- 知识点：将这些模块变成 一个非常简单的结构 可以获取皮肤顶点数据 将Vertex连接到这个功能这里 然后顶点也产生了一个新的输入 所以可以看作是。
- 知识点：模块输入的新参数 每次添加了一种新的数据类型 这个功能的意义是 这里输入的Skeletal Mesh 顶点数据、顶点值提取 想象可以这样考虑。
- 知识点：将这个股价网格放进去 就可以获取那个股价网格的 某个顶点的位置值 或者顶点的发现值 或者顶点的双发现 切线、速度啊这些进行计算。
- 知识点：后续会为这个股价网格创建 随机生成的点 Position值连接在哪里 我就会搜索Position 然后就会出现Particle。
- 知识点：Position 这里连接的话就会申请 那Particle的位置 会在这里更新为 Skeletal Mesh的位置 就是您可以理解为这种概念。
- 知识点：来试试看 刚才关于这个参数 适当简单解释一下 这里是在这里也能看到的 粒子部分的属性 这些属性对应于 这里的粒子属性。
- 知识点：这全部分开的原因 可以把这些属性视为 能移动的粒子 在这种粒子属性的情况下 只能用于与粒子相关的用途。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`材质`、`粒子`、`发射器`、`系统`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Skel_Position` 输入 `Skeletal Mesh` 加入
> - 组成部分: Niagara Script Graph + Details + Parameters + Timeline + Preview + 字幕
> - 所属: `Skel_Position` 模块脚本。
> - 目的: 为模块脚本添加 `Skeletal Mesh` 类型输入，作为后续读取皮肤顶点数据的来源。
>
> Niagara Script Graph:
> - 当前标签为 `Skel_Position*`，上方 `Apply` 按钮可见。
> - `Map Get` 节点被放大显示。
> - `Map Get.Source` 输入 Pin 可见。
> - `Map Get` 内新增 `INPUT Skeletal Mesh` 参数。
> - `INPUT Skeletal Mesh` 行右侧有可继续添加/展开的控件。
> - 图中有一条白色长线经过节点上方，端点不可读；不写成已确认数据流。
>
> Parameters:
> - 左下 `Active Module` 面板中 `Module Inputs` 展开。
> - `Module Inputs` 下可见 `INPUT Skeletal Mesh`。
>
> Details:
> - Owner: `Skel_Position` 模块脚本。
> - `Module Usage Bitmask`、`Category = Default`、`Provided Dependencies = 0 Array element`、`Required Dependencies = 0 Array element`、`Library Visibility = Unexposed`、`InputMap` / `OutputMap` Parameter Map 字段仍可见。
>
> Timeline / Preview:
> - Preview 仍显示青蓝色短光束。
> - Timeline 当前时间约 `8.91` 秒，`DynamicBeam` 和 `Empty` 轨道可见。
>
> 字幕:
> - 字幕文字为“并且有获取皮肤顶点数据。”。
>
> 画面含义: 该帧记录模块输入已经加入 `Skeletal Mesh`，为下一步获取 Skeletal Mesh 顶点位置、法线、切线或速度数据提供入口。
> 图表转写（UE-GTXT v4）
> - 类型: `Skel Position` 模块在 `Empty` emitter 中的 Skeletal Mesh 数据接口设置
> - 组成部分: Niagara Stack + Details + Scratch Script Manager + Timeline + Preview
> - 所属: `Thunder_Body_01 / Empty / Skel Position`。
> - 目的: 将 `Skel_Position` 模块加入 `Empty` emitter，并查看 Skeletal Mesh 输入当前未指定网格时的警告和默认字段。
>
> System Overview / Stack:
> - `Thunder_Body_01`、`Empty`、`DynamicBeam` 三个卡片可见。
> - `Empty` 卡片出现黄色警告标记。
> - `Empty` Stack 在 `Particle Update` 下新增 `Skel Position` 模块，模块行被选中。
> - `DynamicBeam` Stack 仍包含 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `Empty.Skel Position`。
> - 顶部显示 `No running preview...`。
> - `Skeletal Mesh` 数据接口类型为 `Skeletal Mesh`。
> - 警告: `Object has warnings`，`No mesh assigned warning`。
> - `Mesh.Source Mode = Default`。
> - `Preview Mesh = None`。
> - `Source Actor = None`。
> - `Component T... = 0 Array element`。
> - `Mesh User P... = None`。
> - `Skinning Mode = Skin on the Fly`。
> - `Sampling Reg... = 0 Array element`。
> - `Whole Mesh... = -1`。
> - `Skeleton.Filtered Bones = 0 Array element`。
> - `Skeleton.Filtered Sock... = 0 Array element`。
> - `UV Set Index = 0`。
> - `Require Curre...` 处于勾选状态。
> - `Vertex = 0`。
>
> Scratch Script Manager / Timeline / Preview:
> - 左下 `Scratch Script Manager` 中选中 `Skel_Position`。
> - Timeline 当前时间约 `8.40` 秒，`DynamicBeam` 与 `Empty` 轨道可见。
> - Preview 仍显示青蓝色短光束，粒子计数仍为 `DynamicBeam 100 Current`。
>
> 画面含义: 该帧记录 `Skel Position` 已加到 `Empty` emitter，但 Skeletal Mesh 还没有分配，因此当前采样输入处于警告状态。
> 图表转写（UE-GTXT v4）
> - 类型: `Empty.Emitter State` 循环时长与添加模块入口
> - 组成部分: Niagara Stack + Emitter State Details + Add Module 菜单 + Parameters + Timeline + Preview
> - 所属: `Thunder_Body_01 / Empty`。
> - 目的: 调整 `Empty` emitter 的循环时长，并通过 Add Module 搜索框继续添加后续模块。
>
> System Overview / Stack:
> - `Empty` emitter 被选中，`Emitter Update` 组右侧的添加模块按钮被指向，提示为 `Add a new Module to this group`。
> - 弹出的 `Add new Module` 面板中，Source Filtering 可见 `Show all`、`Niagara`、`Game`、`Plugins`、`Developer`。
> - Library Filtering 中 `Library Only` 被勾选。
> - 搜索框中输入 `bus`。
> - `DynamicBeam` Stack 仍可见，保持 Beam/Ribbon 结构。
>
> Details:
> - Owner: `Empty.Emitter State`。
> - `Life Cycle Mode = Self`。
> - `Inactive Response = Complete (Let Particles Finish then ...)`。
> - `Loop Behavior = Infinite`。
> - `Loop Duration = 0.2`。
> - `Recalculate Duration E...` 未勾选。
> - `Loop Delay = 0.0`，未启用。
> - `Scalability Mode = System`。
>
> Parameters / Timeline / Preview:
> - 左下 `Active Overview` 中可见 `SYSTEM bCompleteOnInactive`、`SYSTEM CurrentLoopDuration`、`SYSTEM ExecutionState`、`SYSTEM ExecutionStateSource`、`SYSTEM LoopCount`、`SYSTEM LoopedAge`、`SYSTEM NormalizedLoopAge`。
> - Timeline 当前时间约 `9.40` 秒。
> - Preview 中仍显示青蓝色短光束，`DynamicBeam` 粒子计数为 `100 Current, 100 Max (est.)`。
>
> 画面含义: 该帧记录 `Empty` emitter 被设置为每 `0.2` 秒循环，为后续持续刷新 Skeletal Mesh 采样位置并驱动粒子位置更新做准备。

### 00:19:26-00:24:15 Skeletal Mesh、Mesh、粒子

- 本段定位：Skeletal Mesh、Mesh、粒子。
- 知识点：首先这个要与这里的身体相配 持续生成与否是重要的 将生命周期设置为0.2秒 每0.2秒会持续生成的状态 然后后续会带来的标度网格 放入这里的冲托。
- 知识点：定点 决定每个漩涡的位置 使用漩涡编号 这个位置是 决定每个漩涡的位置 使用漩涡编号 这个用随机范围设置 先设为3000 像这个雷霆身体。
- 知识点：由于我们现在 在使用谷歌输入 要正确利用谷歌网格 这里的粒子始终在该 谷歌网格信息的谷歌网格下 需要让它附加 所以选择Skeletal。
- 知识点：Made 现在使用的None将进行 在这种情况下 开的词写更干净 那么现在这个particle。
- 知识点：可以认为是和Skeletal Mesh 有关联的 点击Fix Now 就一直在移动 现在看一下 这样每0.2秒 去不同位置 可观察到生成 更明显。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`粒子`、`生命周期`、`颜色`、`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Empty` emitter 0.2 秒刷新与 `Skel Position` 运行状态
> - 组成部分: Niagara Preview + System Overview + Emitter State Details + Parameters + Timeline
> - 所属: `Thunder_Body_01 / Empty` 与 `DynamicBeam`。
> - 目的: 检查 `Empty` emitter 以短循环持续生成点，并与 `DynamicBeam` 光束同时运行。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示一条青蓝色短光束，末端附近有一个白色点。
> - `Empty` 显示 `25 Current, 26 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `100 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - `Empty` 卡片处于警告状态。
> - `Empty` Stack 可见 `Emitter State`，`Particle Spawn` 下有 `Initialize Particle`、`Camera Offset`，`Particle Update` 下有 `Particle State`、`Skel Position`，`Render` 下有 `Sprite Renderer`。
> - `DynamicBeam` Stack 保持 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `Empty.Emitter State`。
> - `Life Cycle Mode = Self`。
> - `Inactive Response = Complete (Let Particles Finish then ...)`。
> - `Loop Behavior = Infinite`。
> - `Loop Duration = 0.2`。
> - `Loop Delay = 0.0`，未启用。
> - `Scalability Mode = System`。
>
> Timeline:
> - 当前时间约 `5.59` 秒。
> - `DynamicBeam` 轨道前段为绿色片段，后段为蓝色持续片段。
> - `Empty` 轨道为蓝色长片段。
>
> 画面含义: 该帧记录 `Empty` emitter 已按 `0.2` 秒循环刷新点，后续可用这些点作为光束或位置读取来源。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中 `Exp_01` 与 `Thunder Body 01` 轨道绑定
> - 组成部分: Sequencer + Niagara 窗口边缘 + Content Browser + Outliner + Preview + 字幕
> - 所属: `04_Thunder_Explosion` Level Sequence，`Exp_01` 与 `Thunder_Body_01` Niagara System。
> - 目的: 检查雷电身体系统已经加入 Sequencer，并与角色 `Riktor` 相关联。
>
> Sequencer:
> - 序列为 `04_Thunder_Explosion*`，帧率 `30 fps`。
> - 当前时间约 `0012`，顶部时间轴可见 `0000` 到 `0120`。
> - `Camera Cuts`、`Cine Camera Actor / CameraComponent`、`Riktor / Animation / Ability_Ultimate`、`Exp 01`、`Thunder Body 01` 轨道可见。
> - `Riktor.Spawned`、`Exp 01.Spawned`、`Thunder Body 01.Spawned` 均可见勾选状态。
> - `Thunder Body 01` 下可见 `Attach` 子轨道，轨道片段标注 `Riktor`。
> - `Exp 01` 轨道上可见关键帧点。
>
> Niagara 窗口边缘:
> - 下方仍打开 `Thunder_Body_01`。
> - Particle Counts 显示 `Empty` 约 `1 Current, 2 Max (est.)`，`DynamicBeam` 为 `0 Current, 100 Max (est.)`。
> - Details 区仍在 `Empty / Skel Position` 附近，提示 `No running preview...`。
>
> Content Browser / Outliner:
> - 左侧 Content Browser 可见 `Exp_01` Niagara System 资源。
> - Outliner 中可见 `04_Thunder_Explosion` 相关 Niagara Actor 条目。
>
> 字幕:
> - 字幕文字为“现在看一下”。
>
> 画面含义: 该帧记录 `Thunder Body 01` 已作为序列轨道加入并附着到 `Riktor`，为角色身上的电流持续生成提供 Sequencer 上下文。
> 图表转写（UE-GTXT v4）
> - 类型: `DynamicBeam.Beam Emitter Setup` 临时终点设置
> - 组成部分: Niagara Preview + System Overview + Beam Emitter Setup Details + Parameters + Timeline
> - 所属: `Thunder_Body_01 / DynamicBeam`。
> - 目的: 设置光束起点/终点的基础字段，用临时 `Beam End` 检查光束方向和可见性。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示一条青蓝色斜向长光束，附近有多个红色发光粒子点。
> - `Empty` 显示 `5 Current, 10 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `100 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - `DynamicBeam.Beam Emitter Setup` 被选中。
> - `DynamicBeam` Stack 可见 `Emitter State`、`Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
> - `Empty` Stack 可见 `Skel Position`，仍作为位置来源相关 emitter。
>
> Details:
> - Owner: `DynamicBeam.Beam Emitter Setup`。
> - `Beam Start = Simulation Position`。
> - `Absolute Beam Start` 处于勾选状态。
> - `Beam End = 200.0, 0.0, 0.0`。
> - `Absolute Beam End` 未勾选。
> - `Use Beam Tangents` 未勾选。
>
> Timeline:
> - 当前时间约 `1.04` 秒。
> - `DynamicBeam` 和 `Empty` 轨道均处于前段。
>
> 画面含义: 该帧记录光束先使用模拟位置作为起点，并将终点临时设为 `(200.0, 0.0, 0.0)` 进行预览；该数值只按 Details 字段记录，不额外断言其坐标空间。

### 00:24:15-00:29:07 粒子

- 本段定位：粒子。
- 知识点：设置为导入位置 把这里的名字改为刚才的原 在导入位置这里按加号 搜索领导者 找到粒子属性领导者。
- 知识点：生成这个并设置为 nf参数 这生成并获取VectorBinded的函数 然后这里attribute 里面也写上position 这是我们要获取的attribute。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：并会在这个位置写上值 不添加一个2米属性 拿到外面使用 创建一个position属性值 所以需要写force 然后把这个拖到这里 把这个值连接到这里。
- 知识点：就会自动 生成一个将Vector转换为 position单位的节点 这样应该可以 所以就暂时出来看看 现在出现错误的原因是 这里部分是2米单位。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Particle`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Empty` 重命名/作为 `Source` 后的光束来源状态
> - 组成部分: Niagara Preview + System Overview + Beam Emitter Setup Details + Scratch Script Manager + Timeline + 字幕
> - 所属: `Thunder_Body_01 / Source` 与 `DynamicBeam`。
> - 目的: 将位置来源 emitter 命名为 `Source`，作为后续 Particle Attribute Reader 的读取目标。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示青蓝色斜向长光束，以及多个红色发光粒子点。
> - `Source` 显示 `5 Current, 10 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `50 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - 左侧 emitter 卡片露出一部分，可见其名称为 `Source`。
> - `DynamicBeam.Beam Emitter Setup` 仍被选中。
> - `DynamicBeam` Stack 保持 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `DynamicBeam.Beam Emitter Setup`。
> - `Beam Start = Simulation Position`。
> - `Absolute Beam Start` 处于勾选状态。
> - `Beam End = 200.0, 0.0, 0.0`。
> - `Absolute Beam End` 未勾选。
> - `Use Beam Tangents` 未勾选。
>
> Scratch Script Manager / Timeline:
> - 左下 `Local Modules` 中 `Skel_Position` 可见。
> - Timeline 当前时间约 `2.71` 秒。
>
> 字幕:
> - 字幕文字为“把这里的名字改为刚才的源。”
>
> 画面含义: 该帧记录位置来源 emitter 已命名为 `Source`，`DynamicBeam` 仍用临时 Beam End 预览光束。
> 图表转写（UE-GTXT v4）
> - 类型: `Import_Position` 模块脚本中读取 `Position` 属性
> - 组成部分: Niagara Script Graph + Details + Parameters + Preview + Timeline
> - 所属: `Import_Position` 模块脚本。
> - 目的: 创建导入位置模块，用 Particle Attribute Reader 按索引读取 `Position` 属性，并准备写入 Output Module。
>
> Niagara Script Graph:
> - 当前标签为 `Import_Position*`，上方 `Apply` 按钮可见。
> - 左侧可见 `Vector by Index` 节点。
> - `Vector by Index.Attribute = Position`。
> - `Vector by Index` 输入 Pin 可读为 `Particle Reader`、`Particle Index`。
> - `Vector by Index` 输出 Pin 可读为 `Valid` 与 `Value`。
> - 中上方可见 `Map Set` 节点，Pin 为 `Source` 和 `Dest`。
> - `Map Set.Dest` 连接到 `Output Module.OutputMap`。
> - `Vector by Index.Value` 和 `Valid` 的去向在截图中未连到可读端点；不补写未显示连线。
>
> Details:
> - Owner: `Import_Position` 模块脚本。
> - `Module Usage Bitmask` 显示包含 `Module | Particle Spawn Script | Parti...`。
> - `Category = Default`。
> - `Provided Dependencies = 0 Array element`。
> - `Required Dependencies = 0 Array element`。
> - `Deprecation Recommendation = None`。
> - `Conversion Utility = None`。
> - `Library Visibility = Unexposed`。
> - `Numeric Output Type Select... = Largest`。
> - `Input Parameters`: `InputMap` 类型为 `Niagara Parameter Map`。
> - `Output Parameters`: `OutputMap` 类型为 `Niagara Parameter Map`。
>
> Parameters / Preview / Timeline:
> - `Active Module` 的 `Module Inputs` 中可见 `INPUT Particle Attribute Reader`。
> - Preview 中显示红色粒子点和青蓝色光束。
> - Particle Counts 显示 `Source` 为 `5 Current, 10 Max (est.)`，`DynamicBeam` 为 `50 Current, 50 Max (est.)`。
> - Timeline 当前时间约 `6.38` 秒。
>
> 画面含义: 该帧记录 `Import_Position` 已使用 Particle Attribute Reader 读取 `Position` 属性，后续仍需把读取出的 Vector 值写入模块输出或粒子属性。
> 图表转写（UE-GTXT v4）
> - 类型: `DynamicBeam.Import Position` 中 Particle Attribute Reader 未绑定 Source 警告
> - 组成部分: Niagara Stack + Import Position Details + Scratch Script Manager + Preview + Timeline + 字幕
> - 所属: `Thunder_Body_01 / DynamicBeam / Import Position`。
> - 目的: 将 `Import_Position` 模块加入 `DynamicBeam`，并设置 Particle Attribute Reader 的 Source emitter 名称。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示一条青蓝色斜向光束和一个红色发光粒子点。
> - `Source` 显示 `5 Current, 10 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `50 Current, 50 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - `Source` emitter 卡片位于左侧，`DynamicBeam` 位于右侧。
> - `DynamicBeam` 卡片带黄色警告标记。
> - `DynamicBeam` 的 `Emitter Update` 组中新增并选中 `Import Position`。
> - `DynamicBeam` Stack 仍包含 `Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `DynamicBeam.Import Position`。
> - 数据接口类型为 `Particle Attribute Reader`。
> - 警告: `Object has warnings`。
> - 错误/警告中可读: `Source emitter '' could not be found`，重复出现两条。
> - `Emitter Name` 输入框为空，提示文本为 `Enter Emitter Name...`。
>
> Scratch Script Manager / Timeline:
> - 左下 `Local Modules` 中可见 `Import_Position` 与 `Skel_Position`，当前选中 `Import_Position`。
> - Timeline 当前时间约 `9.31` 秒。
>
> 字幕:
> - 字幕说明之前制作的 Particle Attribute Reader 输入现在显示在这里。
>
> 画面含义: 该帧记录 `Import Position` 已加入 `DynamicBeam`，但 `Emitter Name` 尚未填写为 `Source`，因此 Attribute Reader 暂时找不到来源 emitter。

### 00:29:09-00:33:10 光束

- 本段定位：光束。
- 知识点：以前经常使用参数 在这里输入source 然后这个source 打开id 然后local也打开 这里也打开local 接下来 现在来看一下v连接部分。
- 知识点：光束的开始部分 以及光束的结束部分 光束的结束部分 暂时设为200 否则我先随机更改一下 随机犯为 设置位 这里也会无限地大约变更0.2秒。
- 知识点：在 开始部分制作convert position to vector 后续会之前提取的姿势值 放在这里 现在正好匹配地出现 做成一个看起来会更方便。
- 知识点：保存后就这样出现了 有什么被附着着不断跟随着 需要设置这个absolute vement值 那么基于这个center值 大于200的 xy-f200近00的。
- 知识点：n值会 随机生成 star值与这个指令老太子的 随机pause x 连接着 功能上正常运作 简单地先解释一下这个构成 然后进入正式制作 我觉得不会太难理解。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `DynamicBeam.Import Position` 绑定 Source emitter 名称
> - 组成部分: Niagara Preview + System Overview + Import Position Details + Scratch Script Manager + Timeline + 字幕
> - 所属: `Thunder_Body_01 / DynamicBeam / Import Position`。
> - 目的: 在 Particle Attribute Reader 的 `Emitter Name` 中选择 `Source`，让 `DynamicBeam` 能读取来源 emitter 的粒子属性。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示青蓝色斜向光束和多个红色发光粒子点。
> - `Source` 显示 `5 Current, 10 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `50 Current, 50 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - `Source` emitter 位于左侧，`DynamicBeam` 位于右侧。
> - `DynamicBeam.Import Position` 被选中。
> - `DynamicBeam` 卡片仍带黄色警告标记。
>
> Details:
> - Owner: `DynamicBeam.Import Position`。
> - 数据接口类型为 `Particle Attribute Reader`。
> - 警告区仍显示 `Source emitter '' could not be found`。
> - `Emitter Name` 输入框中已输入 `Sou`。
> - 下拉候选中可见 `Source` 和 `DynamicBeam`。
>
> Scratch Script Manager / Timeline:
> - 左下 `Local Modules` 中可见 `Import_Position` 与 `Skel_Position`，当前选中 `Import_Position`。
> - Timeline 当前时间约 `1.18` 秒。
>
> 字幕:
> - 字幕文字为“然后这个 source 中”。
>
> 画面含义: 该帧记录正在把 Particle Attribute Reader 的来源 emitter 指向 `Source`；选择完成后警告应解除并可读取 `Source.Position`。
> 图表转写（UE-GTXT v4）
> - 类型: `DynamicBeam.Beam Emitter Setup` 起点读取与随机终点
> - 组成部分: Niagara Preview + System Overview + Beam Emitter Setup Details + Parameters + Timeline + 字幕
> - 所属: `Thunder_Body_01 / DynamicBeam`。
> - 目的: 用 `Emitter.Pos` 转换成 Vector 作为 Beam Start，并用随机范围设置 Beam End。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示红色来源粒子点和一条从其附近延伸出的青蓝色光束。
> - `Source` 显示 `5 Current, 10 Max (est.)`，状态 Active。
> - `DynamicBeam` 显示 `50 Current, 100 Max (est.)`，状态 Active。
>
> System Overview / Stack:
> - `DynamicBeam.Import Position` 位于 `Emitter Update` 组，`Beam Emitter Setup` 被选中。
> - `DynamicBeam` Stack 仍可见 `Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。
>
> Details:
> - Owner: `DynamicBeam.Beam Emitter Setup`。
> - `Beam Start = Convert Position to Vector`。
> - `Input Position = EMITTER Pos`。
> - `Conversion Oper... = Passthrough as a Non Large World V...`。
> - `Absolute Beam Start` 处于勾选状态。
> - `Beam End = Random Range Vector`。
> - Minimum = `200.0, 200.0, 0.0`。
> - Maximum = `-200.0, -200.0, 0.0`。
> - `Evaluation Type = Spawn Only`。
> - `Recalculate Rang...` 处于勾选状态。
> - `Absolute Beam End` 未勾选。
> - `Use Beam Tangents` 未勾选。
>
> Parameters / Timeline:
> - `Emitter Attributes` 中选中 `EMITTER Pos`。
> - Timeline 当前时间约 `5.28` 秒。
>
> 字幕:
> - 字幕文字为“这样的话，现在正好匹配着出现。”。
>
> 画面含义: 该帧记录光束起点从 `Emitter.Pos` 转成 Vector，终点在随机 Vector 范围内生成；具体坐标空间只按 Details 已显示字段记录。
> 图表转写（UE-GTXT v4）
> - 类型: `Thunder_Body_01` 关卡预览与 Sequencer 上下文
> - 组成部分: Level Viewport + Content Browser + Outliner + Sequencer + Niagara 窗口边缘 + 字幕
> - 所属: `04_Thunder_Explosion` 关卡，`Thunder_Body_01` Niagara System。
> - 目的: 在关卡中检查 `Thunder_Body_01` 光束系统附着角色后的可见效果。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - `Riktor` 角色位于棋盘格地面中部。
> - 角色周围有一圈灰色/褐色烟雾状地面效果。
> - 角色身体前方可见一条青蓝色细长光束。
> - 该光束是当前效果预览，不额外断言其坐标空间或真实运动方向。
>
> Content Browser:
> - 当前搜索 `04`，可见 `Exp_01` 和 `Thunder_Body_01` Niagara System。
> - `Thunder_Body_01` 被选中。
>
> Outliner:
> - 世界为 `04_Thunder_Explosion (Editor)`。
> - 可见 `Exp 01`、`Floor`、`PlayerStart`、`PostProcessVolume`、`Riktor`、`Thunder Body` 等对象。
>
> Sequencer:
> - 下方打开 `04_Thunder_Explosion*`。
> - 当前时间约 `0031`，序列中可见 `Camera Cuts` 和 `Cine Camera Actor`。
>
> 字幕:
> - 字幕文字为“这里手部分”。
>
> 画面含义: 该帧记录 `Thunder_Body_01` 已在关卡中与角色同时预览，当前可见身体/手部附近的青蓝光束和底部烟雾效果。

## 补充视觉证据

### S01 00:00:22

> 图表转写（UE-GTXT v4）
> - 类型: p18 起始关卡补充证据
> - 组成部分: Level Viewport + Content Browser + Outliner + Details + 字幕
> - 所属: `03_Ice_Explosion` 关卡。
> - 目的: 补充记录第 13 课开始时的旧冰爆关卡状态和地面对象设置。
>
> Level Viewport:
> - 视口处于 `Perspective / Lit`。
> - 场景主体是大面积棋盘格地面，`Floor` 被选中并以黄色边框高亮。
> - 视口中可见摄像机/灯光图标和选中对象 gizmo。
>
> Content Browser:
> - 当前目录中可见示例文件夹 `Ex_01_SwordTrail`、`Ex_02_Earth...`、`Ex_03_Ice_Explosion`、`Ex_04_Thunder...`、`Ex_05_Death...`、`Ex_06_Water...`、`Ex_07_FireExplosion`、`Ex_08_Constella...`。
> - 可见多个材质资源缩略图，包括 `M_Additive...`、`M_Decal_...`、`M_Ribbon...` 等。
>
> Outliner / Details:
> - 世界为 `03_Ice_Explosion (Editor)`。
> - 可见 `DirectionalLight`、`01_Swing_Trail`、`Floor`、`PlayerStart`、`PostProcessVolume`。
> - `Floor.Transform`: Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
> - `Floor.Static Mesh` 显示 `SM_Template_Map_...`。
> - Material Element 0 为 `MI_ProcGrid`。
>
> 字幕:
> - 字幕文字为“在这个例子中，可以使用一点新功能。”。
>
> 画面含义: 该补充截图确认 p18 开始时仍处在旧 `03_Ice_Explosion` 关卡，后续会基于该场景进入 `04_Thunder_Explosion` 雷电例子。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


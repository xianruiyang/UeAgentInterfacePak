# 05-2 制作Niagara粒子特效

# 05-2 制作Niagara粒子特效

## 关键术语

- `Color`、`Scale Color`、`GPU`、`Multiply`、`Sequencer`、`Curve`、`材质`、`粒子`、`发射器`、`速度`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Particle`

## 分段知识

### 00:00:02-00:04:40 颜色、纹理

- 本段定位：颜色、纹理。
- 知识点：有一点不同感觉的颜色适当混合 虽然不会很多显现出来 这样来给予面具纹理 是的,需要加入这个纹理。
- 知识点：可以感受到余韵 这次因为会使用扭曲 也会改变正常部分 提高一点偏差值 其他部分的扭曲 用一种简单的形式给大动作的扭曲 区域也会更深 所以为了能更清楚给提高亮度。
- 知识点：为了大动作的关系 适当粗放地调整瓷砖 这部分的折射值 大概不需要太强 保存资源 我来开一下它 看看 现在是这种显示 感觉需要调整一下 我就想感觉要更有余韵。
- 知识点：似乎生命时间要长一些 因为不使用雪碧 所以全都关掉了 而且感觉尺寸有点小 这个的纹理应该更粗一点。
- 知识点：表现出来 表现扭曲 一开始没有外观 按一下就表现出来了 快速 现在让它应用 但是1的值太强 所以大概0.1 试着调整到这个程度 感觉像是某种呼吸在移动。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 黑色余韵材质实例调整
> - 组成部分: Material Instance Preview + Layer Parameters
> - 所属: `M_SwordTrail_01_Ins_04`
> - 目的: 在上一页黑色余韵元素基础上继续调整颜色、纹理与扭曲强度。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Preview | 暗灰色竖向拖尾/裂纹形状，局部带红黑色痕迹 |
> | 参数面板 | Global Scalar、Texture、Vector 参数展开 |
> | 可见纹理参数 | `Color_Tex`、`Normal_Tex`、`Opacity_Tex` 资源槽可见 |
> | 可见颜色参数 | `Head_Color`、`Tail_Color` 色带可见，整体偏浅红/粉与黑灰 |
> | 字幕语义 | 继续调整不同感觉的颜色混合，并加入面具/纹理余韵 |
>
> 该图记录 p06 开始时黑色余韵材质实例的基础预览状态。
> 图表转写（UE-GTXT v4）
> - 类型: `Black` 发射器 Initialize Particle
> - 组成部分: Niagara System Overview + Initialize Particle Details + Curve Panel
> - 所属: `Trail_01 / Black`
> - 目的: 调整黑色余韵发射器的生命周期、Ribbon 宽度和基础粒子属性。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Emitter 列表 | `Sub`、`Dark`、`Black` 并列可见，`Black` 被选中 |
> | Emitter State | `Self / Once` |
> | Emitter Update | `Spawn Per Frame` 勾选 |
> | Particle Spawn | `Initialize Particle` 被选中，`Camera Offset` 在下方可见 |
> | Particle Update | `Particle State`、`Dynamic Material Parameters`、`Scale Color` |
> | Render | `Ribbon Renderer` |
> | Lifetime Mode | `Direct Set` |
> | Lifetime | `0.5` |
> | Position Mode | `Simulation Position` |
> | Ribbon Width Mode | `Direct Set` |
> | Ribbon Width | `150.0` |
> | Ribbon Facing Mode | `Direct Set` |
> | Ribbon Facing Vector | `0.0, 0.0, 1.0` |
> | Timeline | 当前约 `2.21` 秒，`531 of 2400`，`240 fps` |
>
> 该图记录 `Black` 发射器用于黑色余韵轨迹时的初始化参数。
> 图表转写（UE-GTXT v4）
> - 类型: 黑色余韵轨迹动画预览
> - 组成部分: Animation Editor + Anim Notify Details + Asset Browser
> - 所属: `Q_swing_B / Trail_01`
> - 目的: 在动作中查看黑色余韵轨迹是否随挥击出现，并判断扭曲强度是否过强。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Animation | `Q_swing_B` |
> | Preview | Terra 角色挥动武器，黑色/灰色宽弧形拖尾围绕动作显示 |
> | Notify | 时间线中 `Trail_01` 区段可见 |
> | Details | Notify 的 Niagara System、Socket、Offset、Notify Color、Trigger Settings 面板可见 |
> | 轨道 | 多条动画曲线轨道可见 |
> | 字幕 | 提到 `1` 的值太强，调整到约 `0.1` 后产生呼吸般移动感 |
>
> 该图记录黑色余韵轨迹在动画中的可见效果和强度调整结果。

### 00:04:40-00:08:29 透明度、纹理、曲线

- 本段定位：透明度、纹理、曲线。
- 知识点：虽然有点语韵的感觉 但有点突出的感觉 快速让透明度降低一点 这样设置会较好吧 而且大部分是黑色调 但不要太红 适当填补一下刚才的空白 让眼睛有点乐趣的感觉。
- 知识点：感觉那个纹理的线条 看起来更合适旋转的结果 但如果在旋转中 那个纹理本身非常浓 会有点窒息的感觉 会有点像烟雾的感觉 我觉得这种感觉不错啊。
- 知识点：我觉得有点过于规矩的感觉 这个适当增加一下比例 觉得变化再多一点 如果拿出比例的丝带模块 从曲线的0.3开始 保持原本的尺寸适当宽一点。
- 知识点：会比较好 适当不太显眼 这样有点明显 但是不过太严重的话又不行 适当适度比较好 嗯 感觉不错 那么基本的轨迹形状差不多都出来了 对啊 像火花那样。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`透明度`、`曲线`、`烟雾`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Black` 发射器 Scale Color 曲线
> - 组成部分: Niagara System Overview + Scale Color Details + Curve Panel
> - 所属: `Trail_01 / Black / Scale Color`
> - 目的: 降低黑色余韵的透明度和红色感，让烟雾状纹理更自然。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 当前选中 | `Black` 的 `Scale Color` |
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `10.0, 5.0, 4.0` |
> | RGB Float | `Float from Curve` |
> | RGB 曲线 | 随 `PARTICLES NormalizedAge` 从约 `1.0` 衰减到接近 `0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha 曲线 | 随 `PARTICLES NormalizedAge` 下降，末端接近 `0` |
> | 左下曲线 | 另一个曲线面板显示从 `0` 上升到约 `0.1` 的曲线 |
> | Timeline | 当前约 `1.53` 秒，`367 of 2400` |
>
> 该图记录 `Black` 发射器通过 RGB/Alpha 分离曲线降低透明度和颜色强度。
> 图表转写（UE-GTXT v4）
> - 类型: 黑色余韵轨迹场景预览
> - 组成部分: Level Viewport + Content Browser + Niagara/Material 窗口背景
> - 所属: `Trail_01 / Black`
> - 目的: 在测试场景中查看黑色余韵轨迹是否填补主轨迹空白。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Viewport | Terra 角色位于灰色网格测试场景 |
> | 轨迹效果 | 角色附近可见较淡的黑灰烟雾/拖尾残影 |
> | Content Browser | Texture 目录缩略图可见 |
> | 打开窗口 | 下方可见 `Q_swing_B`、`Trail_01` 和多个 `M_SwordTrail_01_Ins_0x` 标签 |
> | 字幕 | 讨论黑色调填补刚才的空白，让画面更有变化 |
>
> 该图记录黑色余韵元素在场景中的可见状态和整体密度。
> 图表转写（UE-GTXT v4）
> - 类型: 基础轨迹形状完成预览
> - 组成部分: Level Viewport + Content Browser + Sequencer/Niagara 背景
> - 所属: `Trail_01`
> - 目的: 确认主轨迹、辅助轨迹和黑色余韵混合后的基本形状。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Viewport | Terra 角色站在灰色网格场景中 |
> | 轨迹效果 | 当前帧轨迹不明显，仅保留弱暗色残影感 |
> | Content Browser | Texture 资源缩略图可见 |
> | 下方窗口 | `Trail_01` 和材质实例相关窗口仍打开 |
> | 字幕 | “那么基本的轨迹形状差不多都出来了” |
>
> 该图记录黑色余韵和前几层轨迹混合后，基础形状阶段基本完成。

### 00:08:33-00:13:27 材质、粒子、发射器

- 本段定位：材质、粒子、发射器。
- 知识点：再添加一个元素的话 第一次挥动会结束 那就用添加发射器做一个吧 在这种情况下 我们一开始生成数量会少 后半段挥动时生成数量会增加 所以时间大概定在0.4左右。
- 知识点：延迟点0.15左右 直接出来的东西 接下来将给您带来喷发器单元 循环 从曲线这里 现在将进入过算循环年龄 这句话是说将0.4变为0到1的值。
- 知识点：开始时不太是大量喷发 而是现在20左右的值 那么距离将每20个单位生成粒子 但需要适当快速递几句减少距离值 大约1.5 将图表适当拉低。
- 知识点：感觉像是变得更宽 将这样设定 然后随机递啊 现在一些火花 需要分散并消失 所以将宽度随机递增加较大的生命周期。
- 知识点：用random uniform将大小也随机设置 从0.7开始 试试看这个大小 然后 首先材质 需要用适合火花的自动材质。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`发射器`、`生命周期`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 新增火花发射器前置设置
> - 组成部分: Niagara System Overview + Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 在已有轨迹层基础上添加新的火花发射器，准备设置生成数量随时间变化。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Emitter 列表 | `Black` 与新增 `Empty` 发射器可见 |
> | 当前选中 | `Empty` 的 `Initialize Particle` |
> | Initialize Particle | Lifetime Mode 为 `Random`，Lifetime 字段显示 `5.0` |
> | Render | `Sprite Renderer` 可见 |
> | Curve Panel | 左下曲线从高值快速衰减，列表中有 Main/Sub/Dark 等发射器曲线 |
> | Timeline | 当前约 `1.76` 秒，`423 of 2400` |
> | 字幕 | 说明再添加一个元素后第一次挥动会结束 |
>
> 该图记录新增火花发射器的初始化入口和较长生命周期设置。
> 图表转写（UE-GTXT v4）
> - 类型: 火花发射器 Spawn Per Unit 曲线
> - 组成部分: Niagara System Overview + Spawn Per Unit Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 用曲线控制火花的按距离生成数量，使后半段挥动产生更多粒子。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 当前发射器 | `Empty` |
> | Emitter State | `Self / Once` |
> | Emitter Update | `Spawn Per Unit` 被选中 |
> | Details 标题 | `Spawn Per Unit` |
> | Curve Index | `EMITTER NormalizedLoopAge` |
> | Unit Scalar | `1.0` |
> | Spawn Per Unit 曲线 | 曲线随时间下降，右侧有多段关键点 |
> | Movement Tolerance | `0.1` |
> | Max Movement Threshold | `300.0` |
> | Leftover Spawn Fraction | `0.0` |
> | 字幕 | 说明把约 `0.4` 时间段映射为 `0` 到 `1` 的值，并让距离值逐步降低 |
>
> 该图记录火花发射器按单位距离生成粒子的曲线化设置。
> 图表转写（UE-GTXT v4）
> - 类型: 火花材质/粒子初始预览
> - 组成部分: Material/Particle Preview + Layer Parameters + Content Browser
> - 所属: `Trail_01 / Empty`
> - 目的: 为新增火花发射器选择适合的火花材质，并检查初始外观。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Preview | 黑灰色碎片/火花状图案分布在预览区域 |
> | Content Browser | 左侧资源列表中可见粉红亮点材质/纹理缩略图 |
> | 参数面板 | Global Scalar、Texture、Vector 参数展开 |
> | 可见纹理参数 | `Color_Tex`、`Normal_Tex`、`Opacity_Tex` 资源槽可见 |
> | 可见颜色参数 | 白色到粉色/紫色的色带可见 |
> | 字幕 | 说明首先需要适合火花的材质 |
>
> 该图记录火花元素材质与初始粒子外观，作为后续速度、随机大小和颜色调整的起点。

### 00:13:27-00:18:03 Color、Scale Color、Multiply

- 本段定位：Color、Scale Color、Multiply。
- 知识点：现在刚开始是生成较少 后期会有大量生成 因为一开始要飞起来 需要速度 但是由于没有继承速度 故障问题没有在这里 现在当前移动轨迹的速度方向会大。
- 知识点：那个动作的移动方向 适当一起移动一下 random range foot 给100到200左右 这种话 在这种挥动方向上 会适当移动一下。
- 知识点：现在其实点感觉有点不对劲 需要把位置偏移大约30 会更靠前一些 而且在消失时的大小 从飞均匀曲线的0.5的时刻开始 会让大小现在的长度变小。
- 知识点：让它快速缩小 只有V方向缩小 而且需要调整颜色值 用scale color对flow进行成法 然后在这里给出想要的颜色。
- 知识点：让它更有黄色的感觉 但是因为感觉亮度非常弱 scale curve multiply flow的部分 一开始是亮的 这种感觉用的非常多 需要给予大约3.0的增强。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`Scale Color`、`Curve`、`Multiply`、`速度`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 火花生成后的场景预览
> - 组成部分: Level Viewport + Content Browser + Niagara/Sequencer 背景
> - 所属: `Trail_01 / Empty`
> - 目的: 检查新增火花粒子在第一段挥击轨迹中的生成密度和可见位置。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Viewport | Terra 角色位于灰色网格场景，角色附近可见少量彩色火花/点状效果 |
> | Content Browser | 左侧显示教程资源树和材质/纹理缩略图 |
> | 下方窗口 | `Trail_01` Niagara 窗口、曲线/参数区域和材质实例标签可见 |
> | Outliner | `Terra Gryphon` 被选中 |
> | 字幕 | 讨论“刚开始生成比较少，后期会有大量生成” |
>
> 该图记录火花发射器加入后的初始场景表现，作为后续速度和颜色调整的视觉基准。
> 图表转写（UE-GTXT v4）
> - 类型: 火花 Particle State 与颜色调整入口
> - 组成部分: Niagara System Overview + Particle State Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 在火花发射器中调整粒子状态和颜色值，使火花可以分散并自然消失。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Emitter 列表 | `Black` 与 `Empty` 可见 |
> | 当前选中 | `Empty` 的 `Particle State` |
> | Particle Spawn | `Initialize Particle`、`Inherit Velocity` |
> | Particle Update | `Particle State`、`Scale Sprite Size`、`Solve Forces and Velocity` |
> | Render | `Sprite Renderer` |
> | Details | `Particle State` 面板中 `Kill Particles When ...` 勾选 |
> | Curve Panel | 左下可见绿色衰减曲线 |
> | 字幕 | “而且需要调整颜色值” |
>
> 该图记录火花发射器进入粒子状态和颜色调整阶段。
> 图表转写（UE-GTXT v4）
> - 类型: 火花颜色/亮度预览
> - 组成部分: Level Viewport + Content Browser + Niagara 背景
> - 所属: `Trail_01 / Empty`
> - 目的: 调整 `Scale Color` 后查看火花是否更偏黄色并更明亮。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Viewport | Terra 角色位于测试场景，角色附近有少量绿色/黄色火花点 |
> | Content Browser | 左侧资源树和火花材质缩略图可见 |
> | 下方窗口 | `Trail_01` Niagara、曲线面板和材质实例标签仍打开 |
> | Outliner | `Terra Gryphon` 被选中 |
> | 字幕 | 说明颜色需要更有黄色感觉，并用约 `3.0` 的增强提高亮度 |
>
> 该图记录火花颜色和亮度增强后的场景预览。

### 00:18:03-00:20:42 GPU、颜色、噪声

- 本段定位：GPU、颜色、噪声。
- 知识点：需要换成GPU使用 按照这个意图适当增加了张力 是的,虽然移动还是有点无聊 所以在这里加入窝减噪声 试着减轻一些无聊的效果 现在因为缩放需要给的数值要重。
- 知识点：有点被抑制了 在某种程度上消失时不会那么无聊 亮度也有点弱的感觉 大小太小也可能是原因 感觉颜色发光了感觉有点少。
- 知识点：现在感觉差不多完成了 我觉得有点偏向后面 所以把这个时机适当往前移动了一下 更多的 对,确实会下上去 这种话就感觉就刚刚好。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`颜色`、`噪声`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 火花发射器切换 GPU Simulation
> - 组成部分: Niagara System Overview + Emitter Properties Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 将火花发射器改为 GPU 计算，并准备添加噪声/力来减轻运动单调。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 当前发射器 | `Empty` |
> | Emitter Properties | 选中，标题旁显示 `GPU` |
> | Local Space | 未勾选 |
> | Determinism | 未勾选 |
> | Interpolated Spawning | 勾选 |
> | Sim Target | `GPUCompute Sim` |
> | Calculate Bounds | `Fixed` |
> | Particle Update | `Scale Velocity`、`Solve Forces and Velocity` 可见 |
> | Render | `Sprite Renderer` |
> | Timeline | 当前约 `0.23` 秒，`55 of 2400` |
>
> 该图记录火花发射器从 CPU 逻辑切换到 GPUCompute Sim 的设置。
> 图表转写（UE-GTXT v4）
> - 类型: 火花噪声/缩放调整
> - 组成部分: Niagara System Overview + Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 通过噪声、缩放或速度曲线让火花消失时不单调。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Emitter 列表 | `Black` 与 `Empty` 可见 |
> | Particle Update | `Scale Velocity`、`Solve Forces and Velocity` 等模块可见 |
> | Details | 曲线编辑区域打开，绿色曲线从高值下降到接近 `0` |
> | Curve Panel | 左下仍显示 `Scale Color` 相关曲线 |
> | Timeline | 当前约 `1.57` 秒，`362 of 2400` |
> | 字幕 | 讨论大小太小可能导致亮度弱，需要调整噪声和缩放数值 |
>
> 该图记录在 GPU 火花发射器中继续调整噪声、缩放和曲线以改善消失效果。
> 图表转写（UE-GTXT v4）
> - 类型: 第一段粒子效果完成前的参数检查
> - 组成部分: Niagara System Overview + Details + Curve Panel
> - 所属: `Trail_01 / Empty`
> - 目的: 在第一段挥击完成前，确认火花大小、颜色和时机的调整状态。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 当前发射器 | `Empty` |
> | Particle Update | `Particle State`、`Scale Sprite Size`、`Solve Forces and Velocity` 等模块可见 |
> | Details | 右侧为曲线/参数编辑面板，数值输入框和曲线关键点可见 |
> | Curve Panel | 左下显示红色衰减曲线 |
> | Timeline | 当前约 `1.13` 秒，时间线中 `Black`、`Dark`、`Empty` 等发射器条可见 |
> | 字幕 | 说明感觉差不多完成，并把时机适当前移 |
>
> 该图记录第一段火花粒子在完成前的最终参数检查。

### 00:20:47-00:25:27 粒子、发射器、颜色

- 本段定位：粒子、发射器、颜色。
- 知识点：这样第一个汇动轨迹就完成了 第二个轨迹 感觉有点白色 所以希望这个颜色能更匹配轨迹色 适当加一些的话会更好 第一个汇动轨迹完成了 那么接下来要接着做第二个汇动轨迹。
- 知识点：第二个就是汇动轨迹给人感觉会更强烈一些 第一个作为基础 第二个颜色会更高饱和度 或者更亮的部分 这些部分需要尝试变化一下 粒子发射器会采取相同方式。
- 知识点：那就先复制第一个粒子来用 先试着摆放一下 第一个粒子因为工作量太多 看起来不太方便 所以就先关掉 你的灰杆也保存一次 打开第二个粒子。
- 知识点：从时机开始配置 第二个粒子 把这个通知复制一个 然后粘贴对齐 从这个时候开始摇晃的很多 从这个点开始 有什么开始 大约在这个点结束 出来的很好。
- 知识点：粒子需要更换 需要替换 保存资源 现在要在这里尝试做一个第二个粒子的变化 现在看到这种火花这个时机不对 没有生成 因为有延迟 需要关闭火 在最后。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`发射器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 第一段挥击粒子完成预览
> - 组成部分: Level Viewport + Content Browser + Sequencer/Niagara 背景
> - 所属: `Trail_01`
> - 目的: 确认第一段挥击轨迹和火花制作完成，准备进入第二段挥击。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Viewport | Terra 角色站在灰色网格场景中 |
> | Content Browser | 左侧教程资源树和火花材质缩略图可见 |
> | 下方窗口 | `Trail_01` Niagara 和材质实例标签仍打开 |
> | Outliner | `01_Swing_Trail` 场景对象可见 |
> | 字幕 | “这样第一个挥动轨迹就完成了” |
>
> 该图记录第一段挥击粒子完成后的场景状态。
> 图表转写（UE-GTXT v4）
> - 类型: 第二段挥击 Notify 复制与对齐
> - 组成部分: Animation Editor + Anim Notify Details + Asset Browser
> - 所属: `Q_swing_B / Trail_02`
> - 目的: 复制第一段粒子 Notify，粘贴并对齐到第二段挥击的起止时机。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Animation | `Q_swing_B` |
> | Preview | 角色在动画中抬起武器，当前帧轨迹不明显 |
> | Notify 时间线 | 多个紫色 Notify 区段可见，其中第二段区段位于后半段 |
> | Details | Anim Notify 的 Niagara System、Socket、Offset、Notify Color、Trigger Settings 面板可见 |
> | Asset Browser | `Q_swing_B` 被选中 |
> | 字幕 | 说明复制一个 Notify 并粘贴对齐，从第二段摇晃开始位置到结束位置 |
>
> 该图记录第二段挥击粒子触发时机的复制与对齐步骤。
> 图表转写（UE-GTXT v4）
> - 类型: `Trail_02` 主发射器初始化
> - 组成部分: Niagara System Overview + Initialize Particle Details + Curve Panel
> - 所属: `Trail_02 / Main`
> - 目的: 打开复制出的第二段粒子系统，检查主发射器基础生命周期与 Ribbon 宽度。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | Emitter 列表 | `Main`、`Sub`、`Dark` 可见 |
> | 当前选中 | `Main` 的 `Initialize Particle` |
> | Emitter State | `Self / Once` |
> | Emitter Update | `Spawn Per Frame` 勾选 |
> | Particle Spawn | `Initialize Particle`、`Camera Offset` |
> | Particle Update | `Particle State`、`Dynamic Material Parameters`、`Scale Color` |
> | Render | `Ribbon Renderer` |
> | Lifetime Mode | `Direct Set` |
> | Lifetime | `0.2` |
> | Position Mode | `Simulation Position` |
> | Ribbon Width Mode | `Direct Set` |
> | Ribbon Width | `100.0` |
> | Ribbon Facing Vector | `0.0, 0.0, 1.0` |
> | Timeline | 当前约 `0.48` 秒，`117 of 2400` |
>
> 该图记录 `Trail_02` 复制后主发射器的初始参数，作为第二段挥击变化调整的起点。

### 00:25:27-00:30:09 生命周期、颜色

- 本段定位：生命周期、颜色。
- 知识点：有点太短消失的感觉 将生命适当延长一下 其他形状的部分大概不需要动 快速跳过这些部分 重要的只是这些时机部分快速提一下 主机做到这个程度。
- 知识点：看一下然后调试一次 服务器也一样需要调整距离 它的生命需要再长一点 似乎挺合适的 第三个 长度黑色调验证效果 生命周期适当延长一下。
- 知识点：到这里感觉简单地对准了什么 似乎不需要大改变 谢谢 最后一个元素也 先是 修正距离值 适当延长一下生命周期吗。
- 知识点：感觉很好 第七个 但是存在遗憾的部分 第二个就是 刚才希望能适当强一点的 那部分感觉表达就少了一点 想再做一个第一材料 给个不同的数值试试。
- 知识点：来打开教程实例看看 颜色是在这个区域适当削减的区域。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 第二段挥击时长检查
> - 组成部分: Animation Editor + Skeleton Tree + Details + Timeline
> - 所属: `Q_swing_B` 动画中的第二段挥击
> - 目的: 对比第二段剑气/拖尾的可见持续时间，判断当前消失节奏偏短，需要继续调整生命周期和颜色衰减。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 主视口 | Terra 角色处于挥击动作中，剑附近有黄色拖尾效果 |
> | 顶部标签 | `Q_swing_B` 动画编辑器界面 |
> | 左侧 | Skeleton Tree 与 Preview Scene Settings 面板可见 |
> | 右侧 | Details 面板显示当前选中对象的参数区域 |
> | 底部 | 动画时间轴与 Notify 轨道可见 |
> | 字幕 | 说明当前第二段效果“有点太短消失”的感觉 |
>
> 该图记录第二段挥击在动画预览中的时长问题，后续需要通过 Niagara 生命周期、材质和颜色曲线使拖尾保留更久。
> 图表转写（UE-GTXT v4）
> - 类型: Ribbon Renderer 设置
> - 组成部分: Niagara System Overview + Ribbon Renderer Details + Curve Panel
> - 所属: `Trail_02 / Dark / Ribbon Renderer`
> - 目的: 检查第二段暗色拖尾的材质和 Ribbon UV 设置，为延长残影并调整可见效果提供参数依据。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | 当前选中 | `Dark` 发射器中的 `Ribbon Renderer` |
> | Renderer Material | `M_SwordTrail_01_Ins_03` |
> | Facing Mode | `Custom` |
> | UV0 Mode | `Tiled By Distance` |
> | UV0 Tiling Length | `750.0` |
> | UV0 Offset | `0.0, -0.05` |
> | UV0 Scale | `1.0, 1.0` |
> | Max Num Ribbons | `0` |
> | Draw Direction | `Front to Back` |
> | Shape | `Plane` |
> | Width Segmentation Count | `1` |
> | Tessellation Mode | `Automatic` |
> | Curve Tension | `0.0` |
>
> 该设置说明第二段暗色 Ribbon 使用独立材质实例和距离平铺 UV，主要影响剑气纹理沿 Ribbon 的重复方式、偏移和绘制顺序。
> 图表转写（UE-GTXT v4）
> - 类型: 材质实例颜色/纹理预览
> - 组成部分: Material Instance Editor + 参数列表 + 材质预览视口
> - 所属: `M_SwordTrail_01_Ins_05`
> - 目的: 查看第二段拖尾使用的材质实例，通过颜色和贴图参数控制剑气亮部、暗部和衰减质感。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 编辑器标签 | `M_SwordTrail_01_Ins_05` 材质实例 |
> | 预览视口 | 球体/平面预览中可见白色、黄色与黑色碎片状剑气纹理 |
> | 参数区 | `Scalar Parameter Values`、`Texture Parameter Values`、`Vector Parameter Values` 分组可见 |
> | 资源关系 | 左侧 Content Browser 中材质实例、纹理和 Niagara 资源缩略图可见 |
> | 字幕 | 说明需要把当前区域的颜色降低 |
>
> 该图记录第二段拖尾材质实例的整体颜色预览，重点是用材质参数减弱局部颜色强度，避免拖尾过亮或过饱和。

### 00:30:09-00:35:04 颜色

- 本段定位：颜色。
- 知识点：简单点 适当扩大影像 这一部分看看 一开始看起来这个差别好像很大 这个视图中似乎那种差别 有点被减弱的感觉 颜色调整也适当需要一下。
- 知识点：这个给我适当强一些 好像更显眼一些 饱和度也试着提高一下 让它感觉更具攻击性 有更多红色调混合嘛 所以感觉更强一些 感觉颜色有点过于极端。
- 知识点：这个辅助颜色 这个颜色也提高饱和度 比较好 与其说依赖于一个图像效果 后面混合的感觉好像更自然了 不只是集中在前面 因为现在电脑录制同时进行。
- 知识点：粘可会混合 会中断或者偶尔中断一次 这个颜色适当感觉还不错 最后那部分如果表现出这个弧度的话 会感觉更强 打开后现在最后这个火花停息 实际上首先得缩短延迟观察。
- 知识点：那首先从前脑生成 这个单位在每针略微变化的数量 是因为那瞬间有点卡顿。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质实例颜色调整结果
> - 组成部分: Material Instance Editor + 参数列表 + 预览视口
> - 所属: `M_SwordTrail_01_Ins_05`
> - 目的: 观察材质实例调色后的白黄剑气纹理表现，并确认后续还需要通过 Niagara 的 `Scale Color` 细化颜色强度。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 预览视口 | 可见白色亮部、黄色过渡和黑色背景/暗部组成的碎片状拖尾材质 |
> | 参数列表 | Scalar、Texture、Vector 参数分组仍处于材质实例面板 |
> | Content Browser | 多个 `M_SwordTrail` 材质实例与贴图资源缩略图可见 |
> | 字幕 | 说明当前颜色“好像是感觉还是有点强” |
>
> 该图记录材质实例层面的颜色调整后，整体亮度/饱和度仍偏强，因此后续在 Niagara 发射器中继续压低颜色输出。
> 图表转写（UE-GTXT v4）
> - 类型: Sub 发射器 Scale Color 设置
> - 组成部分: Niagara System Overview + Scale Color Details + Curve Panel
> - 所属: `Trail_02 / Sub / Scale Color`
> - 目的: 通过 RGB 与 Alpha 分离缩放，降低第二段副拖尾的颜色强度并控制透明度衰减。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | 当前选中 | `Sub` 发射器中的 `Scale Color` |
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | RGB Vector | `10.0, 1.0, 0.5` |
> | RGB Float | `Float from Curve` |
> | Scale Alpha | `Float from Curve` |
> | 曲线输入 | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0` |
> | Curve Panel | RGB 与 Alpha 曲线随生命周期向低值衰减 |
> | 发射器列表 | `Main`、`Sub`、`Dark` 可见 |
>
> 该设置用生命周期归一化曲线控制颜色和透明度：RGB 先乘向量再乘曲线，Alpha 单独由曲线衰减，使副拖尾从较强颜色逐步淡出。
> 图表转写（UE-GTXT v4）
> - 类型: 火花发射器生成节奏检查
> - 组成部分: Niagara System Overview + Emitter/Module Details + Timeline/Curve Panel
> - 所属: `Trail_02 / Empty`
> - 目的: 在第二段拖尾中检查火花生成起点与节奏，为后续调整 Spawn Per Unit、延迟和速度随机性做准备。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | 发射器列表 | `Main`、`Sub`、`Dark`、`Empty` 可见 |
> | 当前操作 | 焦点位于火花相关发射器/模块的 Details 区 |
> | 下方时间线 | Niagara 预览时间线和曲线区域可见 |
> | 字幕 | 讨论火花需要从挥击前段开始生成，避免节奏上显得滞后 |
>
> 该图记录第二段火花生成时机的检查点：颜色压低后，还需要让火花在挥击开始阶段进入画面，并避免单帧或短时间内生成过密。

### 00:35:04-00:39:55 Sequencer、粒子、速度

- 本段定位：Sequencer、粒子、速度。
- 知识点：会导致不生成的情况 图表需要时间缩短生成 要在短moment变多 所以建议从5开始 而不是20 然后适当更快地降低 感觉节奏感觉不错 是否适当减少延迟呢。
- 知识点：开始部分感觉有点不流畅 这个看起来更好 那么适当缩短后面部分 就与图表有关系 现在也还可以 不过有点遗憾的是 如果更强烈会动那么速度。
- 知识点：也希望更强劲一些 我觉得变化幅度如果更加多样 会更好 感觉会更接近 建议您挑选喜欢的拍摄角度 在多个角度中 需要多使用最基本的正面视角 现在粒子表现似乎完成了。
- 知识点：最后可以适当减轻单调感 不如一起混合一下摇动的感觉 先保存资源 拿出序列器 看一下序列器 可以考虑什么时候适合的时机 在中间的时候 有那种摇动的感觉会更好。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`粒子`、`序列`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 火花生成密度/节奏调整
> - 组成部分: Niagara System Overview + Details + Curve/Timeline Panel
> - 所属: `Trail_02 / Empty`
> - 目的: 调整第二段火花的生成密度，使火花不在短时间内集中爆发，并与挥击节奏更贴合。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | 当前发射器 | `Empty` 火花发射器区域被操作 |
> | 相关模块 | Emitter/Particle 模块堆栈与下方曲线面板可见 |
> | 预览时间线 | 播放头位于第二段动作预览时间段 |
> | 字幕 | 说明生成粒子时有瞬间卡顿感，需要调整生成数量/时机 |
>
> 该图记录火花生成密度的调试节点：在颜色调整后继续处理生成节奏，降低集中生成造成的突兀感。
> 图表转写（UE-GTXT v4）
> - 类型: Inherit Velocity 随机速度设置
> - 组成部分: Niagara System Overview + Inherit Velocity Details + Curve Panel
> - 所属: `Trail_02 / Empty / Inherit Velocity`
> - 目的: 通过继承速度与随机缩放，让火花粒子的运动变化更丰富，减少速度表现单一的问题。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Niagara System | `Trail_02` |
> | 当前选中 | `Empty` 发射器中的 `Inherit Velocity` |
> | Velocity Source | `ENGINE OWNER Velocity` |
> | Inherit Velocity A | `1.0, 1.0, 1.0` |
> | Inherited Velocity Scale | `Random Range Float` |
> | Minimum | `100.0` |
> | Maximum | `200.0` |
> | 后续模块 | `Curl Noise Force`、`Solve Forces and Velocity` 可见 |
> | 字幕 | 说明希望变化幅度更加多样化 |
>
> 该设置让火花从拥有者速度继承基础运动，再用 `100.0-200.0` 的随机缩放扩大差异；后续由噪声力和速度求解继续影响火花轨迹。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 场景预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Niagara 编辑窗口
> - 所属: 第二段挥击粒子效果整体预览
> - 目的: 离开单独 Niagara 参数面板，在 Sequencer/关卡视口中查看角色动作、拖尾和火花的整体时间配合。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Level Viewport | Terra 角色位于灰色网格场景，身旁可见暗色拖尾/地面附近残影效果 |
> | Sequencer | 下方时间轴显示角色/轨道片段，播放头位于第二段动作后段 |
> | Content Browser | 可见 Niagara System 缩略图资源 |
> | 背景窗口 | `Trail_02` Niagara 编辑窗口仍打开 |
> | 字幕 | 说明粒子表现“这样子就 OK 了”，准备放到 Sequencer 中观察 |
>
> 该图记录参数调整后的整体预览节点：通过关卡和 Sequencer 检查第二段拖尾、火花和角色动作是否同步。

### 00:39:55-00:43:02 粒子、噪声

- 本段定位：粒子、噪声。
- 知识点：这个摇摆本身 第一次的摇摆适当弱一点 第二次时希望有更强烈的摇动 在这里 需要提前提供相机摇动 提前做了 这个在第一片中如何调整 曾经讨论过。
- 知识点：这个就不长时间说明了 在这里去看看 打开看看 这样就可以把这个竖直给到噪声形态 持续时间也可以调整 进时间和出时间可以调整 可以调整那个轴会晃动很多。
- 知识点：如果调整竖直的话会很快 有感觉 是怎么进去的 进入了抖动 因摇摆而产生的抖动不要过于剧烈 适当的震动程度 这里有一个中间针的抖动。
- 知识点：第二个会是适当更强的抖动 震动看起来更强烈 现在这样带有抖动的成果物完成了 推荐您直接调整竖直 以更有质量的方式调整细节 我是因为这个粒子指导的结果物。
- 知识点：到这里完成吧 自己的作品绝对不要轻易满足 继续发现有些差强人意的部分的话 要给修正那些部分的话 自然质量就会上升 那么到现在为止 做了第一次完成 这次讲座就到这里为止 谢谢。
- 核对对象：`粒子`、`噪声`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中第一次镜头摇动预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner
> - 所属: `01_Swing_Trail` Sequencer / `Cine Camera Actor`
> - 目的: 在完整镜头中检查第一次挥击的镜头摇动强度，使第一次摇动保持较弱，避免抢过粒子主体。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Level Viewport | 视口处于 `Pilot Actor: Cine Camera Actor`，Terra 角色位于灰色网格场景中 |
> | Content Browser | 显示 `Trail_01`、`Trail_02` Niagara System 缩略图 |
> | Outliner | `01_Swing_Trail`、`Cine Camera Actor`、`Terra Gryphon` 等对象可见 |
> | Sequencer | `01_Swing_Trail` 时间轴打开，播放头约在第 36 帧附近 |
> | 轨道 | `Camera Cuts` 与 `Cine Camera Actor` 轨道可见 |
> | 字幕 | 说明“第一次的摇摆稍微弱一点” |
>
> 该图记录第一次相机摇动的整体预览位置，重点是确认第一次挥击的镜头震动只提供轻微反馈。
> 图表转写（UE-GTXT v4）
> - 类型: Camera Shake 轨道设置与第二段震动预览
> - 组成部分: Content Browser + Level Viewport + Details + Sequencer Timeline
> - 所属: `01_Swing_Trail / Cine Camera Actor / CameraComponent`
> - 目的: 将相机震动资源加入 Sequencer，检查第二段挥击时的震动幅度和持续时间。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Content Browser | `ExShake_01` Blueprint Class 被选中，下方还能看到 `ExShake_02`、`ExShake_03` |
> | Level Viewport | Terra 角色挥击时可见亮色拖尾和散点火花 |
> | Details | `Cine Camera Actor` 被选中，`CameraComponent` 可见 |
> | Transform | Location 显示为 `0.0, 0.0, 0.0`，Rotation 显示为 `0.0, 0.0, 0.0`，Scale 显示为 `1.0, 1.0, 1.0` |
> | Sequencer | `Camera Shake` 轨道可见，片段名显示为 `ExShake_01_C` |
> | 播放头 | 约在第 61 帧附近 |
> | 字幕 | 说明“稍微的震动程度就可以了” |
>
> 该图记录把 `ExShake_01` 作为 Camera Shake 片段放入相机轨道后的预览结果，用轻微震动增强第二段挥击而不过度干扰画面。
> 图表转写（UE-GTXT v4）
> - 类型: 最终 Sequencer 效果验收
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner
> - 所属: `01_Swing_Trail` 完整镜头预览
> - 目的: 在最终镜头中检查角色动作、拖尾、火花和镜头震动组合后的完成状态。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Level Viewport | Terra 角色处于挥击动作后段，灰色网格场景中可见角色、武器和阴影 |
> | Content Browser | `ExShake_01`、`ExShake_02`、`ExShake_03` Blueprint Class 资源缩略图可见 |
> | Sequencer | `01_Swing_Trail` 时间轴打开，播放头约在第 114 帧附近 |
> | Outliner | 关卡中相机、灯光、后处理、角色等对象可见 |
> | 字幕 | 说明“到现在为止做了第一次完成” |
>
> 该图记录 p06 调整后的阶段性完成预览：粒子、拖尾和 Camera Shake 已被放入完整 Sequencer 镜头中检查。

## 补充视觉证据

### S10 00:42:27

> 图表转写（UE-GTXT v4）
> - 类型: 补充视觉证据 - Sequencer/关卡预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner
> - 所属: `01_Swing_Trail` 最终预览段
> - 目的: 补充记录角色挥击后段与相机震动资源所在工程环境，辅助确认最终预览不是单独 Niagara 面板截图。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Level Viewport | Terra 角色位于镜头中央，武器/残影靠近角色身体，场景为灰色网格地面 |
> | Content Browser | Sequencer 文件夹中 `ExShake_01`、`ExShake_02`、`ExShake_03` Blueprint Class 资源可见 |
> | Sequencer | `01_Swing_Trail` 时间轴打开，播放头约在第 104 帧附近 |
> | Outliner | `01_Swing_Trail`、`Cine Camera Actor`、`Terra Gryphon` 等对象可见 |
> | Details | 未选中具体对象，显示选择对象提示 |
> | 字幕 | 说明这是示例指导结果物 |
>
> 虽然文件名包含 `graph`，实际截图内容是 Sequencer/关卡预览，不包含可读节点图或参数图；因此按最终视觉证据记录。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


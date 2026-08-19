# 20-2.Unreal建筑墙体破坏特效

# 20-2.Unreal建筑墙体破坏特效

## 关键术语

- `Velocity`、`Alpha`、`GPU`、`Add`、`Sequencer`、`Houdini`、`VAT`、`Smoke`、`材质`、`粒子`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Particle`

## 分段知识

### 00:00:00-00:04:43 粒子、生命周期、速度

- 本段定位：粒子、生命周期、速度。
- 知识点：可以这样大致放置 这样应该没问题 速率值会适当提高最初设定也做了调整 初始发射数也增加到3个左右 生命周期方面也会做些调整。
- 知识点：让粒子存活时间稍长一些 随机值设为75左右尺寸也相应调整 这里将通过光照定位来强化体积表现 稍作 空间 为了营造更充实的空间填充感将采用核形布局。
- 知识点：空间设为约350x60x60 这里之前也是按自上而下的感觉做的 这部分可以直接沿用 可以这样处理这个值设为200左右 让粒子从这个位置开始下落。
- 知识点：沿Z轴方向把这两个选项一起打开 确认位置是否对其空间略有偏移 以洞口位置为准微调即可 应该是这样Shade Location的CD值已经固定。
- 知识点：完全可以再填满一些空间 可以 稍作丰富这里也复制粘贴这段设置会更好 这里是用于其他效果的粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`生命周期`、`速度`。

**关键画面：**

新一讲一开始继续沿用上一页的墙体破坏 Niagara 系统，先从辅助发射器 `Minimal003` 的发射频率入手，给这一层粒子建立更稳定的空间填充。

- 当前编辑器：`Ex_05_Wall_Destruction`
- 当前选中发射器：`Minimal003`
- 当前选中模块：`Spawn Rate`
- 可见参数：
  - `SpawnRate = 20`
- 当前时间线位置约为 `0.32`
- 系统结构：中间 `System Overview` 中能看到多层 `Minimal` 发射器，以及下方的 `Minimal005`、`Source`，说明当前是在多层叠加的墙体破坏系统中逐个细调辅助层。
- 左侧预览结果：墙体整体仍保持较完整的初始姿态，画面重点在于系统内部模块调参，而不是观察大规模破碎后的最终帧。
- 这一步的作用：先确定这一层辅助粒子的基础持续生成频率，后面再叠加初始爆发数、生命周期和速度方向，逐步把空间填充做厚。
这一步把已经调好的辅助层复制到新的发射器 `Minimal004`，用同样的模块结构快速扩充墙体破坏系统中的额外粒子层。

- 当前编辑器仍是：`Ex_05_Wall_Destruction`
- 当前系统概览中并排可见两个相似的辅助发射器：
  - `Minimal003`
  - `Minimal004`
- `Minimal004` 当前处于选中状态，橙色高亮包围了整列发射器模块。
- 复制后的发射器结构中可以清楚看到：
  - `Emitter State`
  - `Spawn Rate`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity`
  - `Camera Offset`
  - `Shape Location Box / Plane`
  - `Gravity Force`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `SubUV Animation Curve`
  - `Scale Color`
  - `Sprite Renderer`
- 当前时间线位置约为 `2.50`
- 左侧预览结果：墙体门洞附近已经能看到一团更厚的烟雾和更多碎片条状粒子，说明复制额外辅助层后，整体体积和层次感立即增强。
- 这一步的作用：把一套已经验证有效的辅助粒子配置直接复用到新的发射器上，减少重复搭建成本，并为不同空间区域分别做微调。
这一步在复制出的 `Minimal004` 上开始做差异化参数调整，让这层粒子在生命周期、尺寸和位置上与前一层形成区分。

- 当前选中发射器：`Minimal004`
- 当前选中模块：`Initialize Particle`
- `Initialize Particle` 可见关键设置：
  - `Lifetime Mode = Random`
  - `Lifetime Min = 2.0`
  - `Lifetime Max = 3.0`
  - `Position Mode = Simulation Position`
  - `Position Offset` 已启用，当前可见首个分量约为 `-100.0`
  - `Sprite Size Mode = Random Uniform`
  - 两个 `Uniform Sprite Size` 数值分别为 `300.0` 和 `200.0`
  - `Sprite Rotation Mode = Random`
  - `Mesh Scale Mode = Unset`
- 中间 `System Overview` 说明：
  - `Minimal003` 与 `Minimal004` 结构相近
  - `Minimal004` 当前正在做粒子生成差异化，而不是复制后原样保留
- 左侧预览结果：预览中这层粒子尚未形成大团烟雾，而是保留在更早的播放时刻，方便逐项确认随机寿命和空间偏移是否合理。
- 这一步的作用：给复制出来的新层加入随机生命周期和随机尺寸，避免所有辅助粒子层表现得过于一致，从而让墙体破坏后的空间填充更自然。

### 00:04:43-00:09:29 材质、粒子、发射器

- 本段定位：材质、粒子、发射器。
- 知识点：反正得看落地的时机 差不多合适了 想更精细点 这边加个发射器 拉长一点 延伸段就行 现在这边适当 用这么少的发射器。
- 知识点：误概有点勉强 这部分再加2-3个也完全没问题 先到这里 我们来检查一下 刚才的效果挺不错的 效果是出来了 但一开始地面那块往里凹的部分 有点便宜。
- 知识点：要不这样处理 可以在这部分对应的位置 让地面轻微向内拉伸 加点深度感 设成0.4左右就行 设到这个程度就够了 别太长 差不多了 粒子数量控制在20个左右。
- 知识点：发射值设690.7附近 适当拉一下曲线张力就行 让初段速度更快些 调调一下 我来改一下 比刚才适当遮挡了些 遮挡感更强了 效果总算出来了 再快点处理。
- 知识点：应该更好 这部分适当调一下 当前材质的深度剑影值 竖直 先把竖直提上去 这应该是第一步 可能得复制个水材质。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`发射器`、`速度`、`曲线`。

**关键画面：**

进入第二小节后，作者继续在辅助发射器 `Minimal004` 上调整粒子发射区域的空间分布，让墙体内凹处的烟雾和碎屑更贴合破口深度，而不是只停留在表面。

- 当前选中发射器：`Minimal004`
- 当前调节对象：`Shape Location Box / Plane`
- 右侧细节面板可见的关键设置包括：
  - `Box Midpoint = (0.5, 0.5, 0.5)`
  - `Surface Only ... = 0.0`
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate = Local`
  - `Offset Mode = Default`
  - `Shape Origin = Position`
  - `Offset` 已展开，其中 `Y` 轴使用 `Float from Curve`
  - 曲线输入为 `NormalizedLoopAge`，可见起点约为 `0`，终点提升到接近 `1`
  - 下方可见两个数值输入：`Scale Curve = 900.0`，`Z = 20.0`
- 中间 `System Overview` 中同时能看到 `Minimal003`、`Minimal004`、`Minimal005`，说明当前是在多层辅助发射器之间细调其中一层的空间分布。
- 左侧预览里，烟雾主要堆积在墙体缺口与地面交界附近，目标是让这一层粒子沿局部区域继续向内或向侧面拉开，增加破口的纵深和遮挡感。
- 这一步的作用：通过给 `Shape Location` 的偏移加入随年龄变化的曲线，把粒子出生位置做成随时间扩展的分布，而不是固定在单一平面上。
在确认 `Minimal004` 的分布方式可用后，作者又复制并切换到新的辅助发射器 `Minimal006`，继续用相似逻辑补更多体积层，但把发射盒尺寸单独拉开，避免多层粒子完全重叠在同一个区域。

- 当前选中发射器：`Minimal006`
- 当前选中模块：`Shape Location`
- `Shape` 页签下可见的关键设置：
  - `Shape Primitive = Box / Plane`
  - `Box / Plane Mode = Box`
  - `Box Size = (400.0, 100.0, 50.0)`
  - `Box Midpoint = (0.5, 0.5, 0.5)`
- `Distribution` 部分仍可见：
  - `Surface Only ... = 0.0`
- `Transform` 与偏移设置延续上一层的思路：
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate = Local`
  - `Offset Mode = Default`
  - `Shape Origin = Position`
  - `Offset` 中 `Y` 轴继续使用 `Float from Curve`
  - 曲线输入仍是 `NormalizedLoopAge`
- 中间 `System Overview` 显示当前系统已经排布出 `Minimal001`、`Minimal002`、`Minimal003`、`Minimal004`、`Minimal006` 等多层辅助发射器，说明当前策略是通过复制多层近似结构，再分别微调参数来堆叠破坏效果。
- 左侧预览里，墙体破口左下区域的烟雾量更厚，表明这一层主要用于补充局部空间中的体积感，而不是改变主形态。
- 这一步的作用：为新增的辅助层单独定义一个较扁的盒体发射区域，让粒子更集中地分布在破口附近的狭长范围内，从而加强内凹与遮挡。
这一张回到较早的辅助发射器 `Minimal002`，重点是把粒子初始化参数调到和墙体破口尺度匹配。画面字幕明确指出，关键做法是一开始就准备一个与洞口大小相近的 `Shape Location`，再从那里开始生成这一层粒子。

- 当前选中发射器：`Minimal002`
- 当前选中模块：`Initialize Particle`
- `Point Attributes` 下可见参数：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 2.0`
  - `Color Mode = Unset`
  - `Position Mode = Simulation Position`
  - `Position Offset = (-50.0, -20.0, 200.0)`
  - `Position Offset Coordinate = Simulation`
  - `Mass Mode = Unset / (Mass of 1)`
- `Sprite Attributes` 下可见参数：
  - `Sprite Size Mode = Non-Uniform`
  - `Sprite Size = (750.0, 750.0)`
  - `Sprite Rotation Mode = Direct Normalized Angle (0-1)`
  - `Sprite Rotation Angle = 0.25`
  - `Sprite UV Mode = Unset`
- 画面中同时能看到 `Minimal001`、`Minimal002`、`Minimal006`，下方还有 `Minimal003`、`Minimal004`，说明作者正在不同辅助层之间来回调整，使每层都对齐破口形态和遮挡目的。
- 左侧预览里，烟雾主体仍贴着墙体缺口下缘和侧边，说明这层不是大范围散开，而是先把出生位置和尺寸控制在与洞口相称的局部区域内。
- 这一步的作用：通过固定寿命、较大的初始 `Sprite Size` 和明确的空间偏移，让这一层粒子从一开始就覆盖住破口附近的主要空洞区域，先建立厚度，再交给后续速度和曲线去拉开运动。

### 00:09:29-00:14:20 Velocity、GPU、Add

- 本段定位：Velocity、GPU、Add。
- 知识点：一起喷点也行 这样加一次试试也行 现在角色提前穿出的部分 角色提前穿出的那部分 我们把它装在机器人身上 加点烟雾效果 就先试试喷的效果 稍后再加个发射器那样用。
- 知识点：先接着加这块石头还有碎片部分 还有碎片蹦射时尾部 烟雾也会再加一点 不用太担心 没问题先这样 试着再多加一点 先来调整一下碎片 爆炸延迟保持一致这里。
- 知识点：只用于爆发模式数量 约200个剑仪用GPU 但材质却是OPEC 确实设成了精灵贴图 显示为出现了警告 这不是OPEC材质。
- 知识点：应该改成MASK的材质当时 设成了OPEC带遮罩 初始粒子部分的生命周期 保持不变位置 稍作调整 我来调一下 尺寸的随机范围 可以再稍调大一点。
- 知识点：阴影位置的画子波动画 直接沿用就行 这部分直接用就行 阴影位置再往外拉宽些 下方也一并扩展出来 现在粒子能从下面弹出来了。
- 知识点：记得把凹槽彻底挖出来 这里用Add Velocity的 追形发射 把速度设成400-500 让粒子向外弹出。
- 知识点：方向沿歪轴往外角度 再拉开点 让粒子往四面八方散开 这样效果就对了 延迟没生效的感觉 这种情况多半是组合节点连错了 也可能是 有这种可能 感觉对上了这种问题。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Velocity`、`GPU`、`Add`、`材质`、`贴图`、`粒子`、`发射器`、`生命周期`。

**关键画面：**

这一张是在 Sequencer 场景里直接检查墙体破坏特效的落地效果。作者把 `Ex_05_Wall_Destruction` 放进关卡序列后，先看机器人穿出墙体时，破口底部和角色脚边是否已经有足够的烟雾与碎片遮挡。

- 当前界面上半部分是关卡视口，下半部分是 Niagara 编辑器，说明这一步不是单看系统预览，而是联动实际镜头检查效果。
- 内容浏览器中同时选中了：
  - `Ex_05_Wall_Destruction`
  - `Ex_05_Wall_Destruction Niagara System`
- 右上 `Outliner` 里可以确认当前关卡挂有多个序列对象，其中包含：
  - `Additional_Picku...`
  - `BRolls`
  - `QA_Perf_Flythro`
  - `Ex_05_Wall_Destr...`
- 主画面里可见机器人正从墙体破口处前冲，墙体下缘和地面附近铺开一层较厚的灰尘烟雾，前景还能看到向外飞出的碎片条状物。
- 这一步的作用：先在真实镜头中确认“角色提前穿出的位置”是否已经被烟雾、碎石和破口遮挡住，确定当前多层辅助发射器的总体方向没有偏掉，之后再继续补 `Add Velocity`、GPU 粒子和尾部烟雾。
这一步切到源发射器 `Source001`，直接调碎片或附带烟雾的外喷速度，让粒子从破口处沿一个偏斜锥形方向向外弹出，而不是只在原地堆积。

- 当前选中发射器：`Source001`
- 当前选中模块：`Add Velocity`
- `Add Velocity` 细节面板中可确认的参数：
  - `Velocity Mode = In Cone`
  - `Velocity Speed = Random Range Float`
  - `Minimum = 400.0`
  - `Maximum = 500.0`
  - `Distribution Along ... = 0.5`
  - `Speed Falloff Fro... = 0.7`
- `Cone` 参数可见：
  - `Cone Axis = (-0.3, -3.0, 1.0)`
  - `Cone Angle = 30.0`
  - `Inner Cone Angle = 0.0`
  - `Cone Angle Mode = Degrees`
- 中间 `System Overview` 里，`Source001` 处于启用状态，旁边还有被临时禁用的列，说明作者正在逐层比较不同来源发射器和附加层的效果。
- 左侧预览中，墙体破口附近的烟雾仍集中在底部，但这一步的重点不是看最终遮挡，而是给随后弹出的碎片和烟雾尾迹提供明确的外喷初速度。
- 这一步的作用：把粒子速度设成 `400-500` 的随机区间，并通过偏斜锥体轴控制出射方向，让碎片更自然地从洞口往外炸开。
这一张继续在主源发射器 `Source` 上微调粒子的初始化属性，目的是在保持寿命稳定的前提下，把出生位置向破口外侧和下方再拉开一些，同时适当放大精灵尺寸的随机范围。

- 当前选中发射器：`Source`
- 当前选中模块：`Initialize Particle`
- `Point Attributes` 下可见参数：
  - `Lifetime Mode = Random`
  - `Lifetime Min = 3.0`
  - `Lifetime Max = 3.0`
  - `Color Mode = Unset`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, -20.0, 150.0)`
  - `Position Offset Coordinate = Simulation`
  - `Mass Mode = Unset / (Mass of 1)`
- `Sprite Attributes` 下可见参数：
  - `Sprite Size Mode = Random Uniform`
  - 两个 `Uniform Sprite Size` 数值为 `10.0` 和 `20.0`
  - `Sprite Rotation Mode = Random`
  - `Sprite UV Mode = Random X`
- `Mesh Attributes` 与 `Ribbon Attributes` 都保持 `Unset`
- 中间 `System Overview` 显示：
  - `Source002` 被禁用
  - `Source` 当前启用
  - `Minimal005` 在右侧同样处于禁用状态
- 左侧预览里，墙体破口处已经形成较浓的烟尘团，周围散布短条状碎片，说明这层主要负责补足较细小的漂浮碎屑和烟雾颗粒。
- 这一步的作用：先把主源发射器的寿命固定在约 `3` 秒，再通过 `Position Offset` 和小尺寸随机精灵，把更多细颗粒补到破口外围与下缘区域。

### 00:14:20-00:19:17 Add、粒子、精灵

- 本段定位：Add、粒子、精灵。
- 知识点：调整抖动位置和偏移量 刚才设了100左右吧 这里也用同样的数值再调下角度就行 速度也再加一个。
- 知识点：我来设置一下 为了让粒子岩发射方向 飞得更远 用随机范围向量加个500左右的值 往400到500之间调就行 行了这边也把图形参数调高点。
- 知识点：数值再拉高一点延迟效果已经有了 不过还能再往后推点 再往后推一点也行 刚才那个 刚才这儿我显示碰撞器就保持不动了 这得加个随动圆环先存一下。
- 知识点：这边也一样 打开后激活设一下延迟 反正已用AdderiMeter配置好了这里 就不必再调了 必须先在这边生成那边才会出现 所以延迟设个2S就行AdderiMeter已经配好。
- 知识点：数量和生命周期保持一致 只把大小调一下就行了 大小调一下就对上了其他部分摄像机片 也往后拉一点 接着调整精灵尺寸 现在这程度已经可以了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Add`、`粒子`、`生命周期`、`速度`、`碰撞`。

**关键画面：**

进入第四小节后，作者开始检查另一层源发射器的精灵帧动画设置。当前画面显示 `Source002` 这列发射器处于禁用状态，但右侧仍打开了它的 `Sub UV Animation` 面板，用来确认精灵贴图帧序和输出范围。

- 当前选中发射器：`Source002`
- 发射器状态：顶部提示 `Emitter is not enabled. Excluded from code.`，说明这一层当前被停用，不参与实时生成。
- 当前选中模块：`Sub UV Animation`
- `Setup` 中可见：
  - `SubUV Animation Mode = Random`
  - `Renderer Type = Sprite`
- `Sprite Renderer` 区域可见：
  - `Sprite Renderer = Sprite Renderer`
- `Animation` 中可见：
  - `Evolution Type = Spawn Only`
- `Output` 中可见：
  - `Output Alternate R...` 未勾选
  - `Start Frame Range = 0`
  - `End Frame Range = 63`
- 中间 `System Overview` 里，`Source` 仍是当前主启用列，`Source002` 与右侧 `Minimal005` 都处于关闭比较状态。
- 左侧预览只剩墙体模型本体，几乎没有明显烟雾或碎片，和右侧“发射器被禁用”的状态相互对应。
- 这一步的作用：在不启用该层发射器的情况下，先确认这套 SubUV 精灵会以随机帧起始、`0-63` 的帧范围、只在生成时取样的方式播放，便于后续需要时再重新启用。
这一张切到辅助发射器 `Minimal005`，重点不是自己按固定速率生成，而是通过“从其他发射器读取粒子”来派生一层额外粒子，让主源发射出的碎片或烟雾再带出第二层效果。

- 当前选中发射器：`Minimal005`
- 当前选中模块：`Spawn Particles from Other Emitter`
- `Attribute Reader` 区域可见：
  - `Emitter Binding = Source`
- 当前生成设置可见：
  - `Spawn Rate = 5.0`
  - `Calculate Spawn Rate` 已勾选
  - `Spawn Rate Per Parti... = 100.0`
  - `Spawning Enabled` 已勾选
  - `Minimum Age Sp... = 0.3333`
  - `Maximum Age Sp... = 1.0`
- 中间 `System Overview` 中，左侧 `Source` 为主启用列，右侧 `Minimal005` 也已启用，说明当前是在把主源粒子的运动结果继续转化为附加层。
- 左侧预览里，墙体破口前方已经能看到更多分散的小块碎片和更厚的烟团，说明这一层派生粒子正在帮助扩大体积和二次飞散范围。
- 这一步的作用：把 `Minimal005` 绑定到 `Source`，根据源粒子年龄区间和每粒子的生成倍率再派生一层新粒子，用更低的基础速率补出附加碎片或烟雾层。
这一张是在第四小节末尾再次回看系统整体状态，确认源发射器与派生发射器一起启用后，墙体破口周围的烟雾、细碎片和附加层是否已经达到可接受的密度。

- 当前 `System Overview` 中可见三列主要发射器：
  - `Source002`
  - `Source001`
  - `Minimal005`
- 三列都处于启用状态，说明作者已经从前面的单列调参切回“多列同时工作”的整体验证。
- `Minimal005` 标题栏右上可见黄色告警三角，表示这一层当前存在需要留意的警告状态，但从当前截图无法进一步确认告警具体内容。
- 右侧 `Details` 面板为空，说明这一步的重点不是继续改某个单独参数，而是观察系统组合后的总体结果。
- 左侧预览中，墙体外侧已经形成一团集中但不过分扩散的白灰色烟雾，破口前方还有少量离散碎片，表明附加层已经开始补上原先偏薄的区域。
- 时间线位置约为 `0.58`，比前一张更接近生成初段，适合检查延迟、派生生成和初始遮挡是否已经对上。
- 这一步的作用：在 `Source002`、`Source001` 和 `Minimal005` 同时启用的状态下，确认主层、附加层和派生层叠加后的初始破口效果已经基本成立，再决定是否继续细调延迟、碰撞或精灵尺寸。

### 00:19:17-00:24:12 Alpha、Sequencer、Smoke

- 本段定位：Alpha、Sequencer、Smoke。
- 知识点：我也糊涂了 这边单独开能正常显示的两个一起开才对 两个一起大开 这才正常显示出来了 原来延迟还真有关系 抱歉都是因为这个 差不多了就差一点。
- 知识点：没错 这部分可能被系统当做一个整体处理 随着Negra更新这些细节 可能会变动先这样看着吧 算了就这样吧 现在不对劲的地方就是这里吧 这里这部分现在加个发射器调整一下。
- 知识点：就会更自然 看起来更自然 整体效果不错 除了那点外远看也更自然 侧面看效果明显提升这些烟雾 烟泡雾线轨迹延伸 动势更连贯 如果这部分显得突兀。
- 知识点：可以调整当前的参数 参数 数值稍高 显得太突兀了 太靠近眼前了 应该延长消散距离效果更好 这样把V体圆和现有粒子。
- 知识点：混合使用真实感更强 我们再加一个粒子 命名为Bal E-Smoke 命名完成复制 身体烟雾已创建好了 保存资源马上进入下一步 这里再新建一个粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Alpha`、`Sequencer`、`粒子`、`发射器`、`系统`、`序列`、`烟雾`、`拖尾`。

**关键画面：**

这一张是在第五小节开头继续回看墙体破坏系统的整体叠加效果，重点是确认多个发射器同时工作时，烟雾是否已经连成一体，而不是像前面那样单独开某一层时出现显示不对或延迟对不上的问题。

- 当前 `System Overview` 中主要可见三列发射器：
  - `Source002`
  - `Source001`
  - `Minimal005`
- 发射器启停状态可直接确认：
  - `Source002` 处于禁用状态
  - `Source001` 处于启用状态
  - `Minimal005` 处于禁用状态
- `Minimal005` 标题栏右上仍带有黄色告警三角，说明这一层存在需要留意的警告，但从当前截图无法确认告警详情。
- 左侧预览时间约为 `3.60` 秒，墙体前方只剩一团较淡的残留烟雾，说明当前检查点已经进入烟雾后段，适合判断消散距离是否足够自然。
- 右侧 `Details` 面板没有展开具体参数，说明这一步更偏向整体验证，而不是继续细调单个模块数值。
- 这一步的作用：先确认在当前启停组合下，后段烟雾的衰减状态是否自然，再决定后面是否需要通过新增发射器或调整 Alpha/消散距离来补掉“太突兀、太靠近镜头”的问题。
这一张从资源和系统结构层面检查墙体破坏 Niagara 系统，准备为后续新增或复制一层身体烟雾粒子做铺垫。画面重点不是某个模块参数，而是当前系统里已经有哪些发射器层，以及内容浏览器里实际选中了哪一个 Niagara 资源。

- 内容浏览器中同时选中了：
  - `Ex_05_Wall_Destr...`
  - `Ex_05_Wall_Destr... Niagara System`
  - 一个额外的同类 Niagara System 资源缩略图
- 中间 `System Overview` 可见当前系统包含多层 `Minimal` 发射器以及底部的 `Source` 系列，至少能确认：
  - 顶部存在 `Minimal`、`Minimal001`、`Minimal002`、`Minimal006`
  - 中部存在 `Minimal003`、`Minimal004`
  - 底部存在 `Source002`、`Source001`、`Minimal005`
- 左侧预览时间约为 `0.48` 秒，此时画面里还没有明显烟雾扩散，只看到墙体模型本体，说明这一步更适合检查系统初始结构和生成时机，而不是看尾段效果。
- 右侧没有展开具体模块细节，说明当前操作重心是整理资源和系统层级，确认是否要基于现有系统直接复制出新的烟雾层。
- 这一步的作用：先确认墙体破坏系统已经具备足够多的基础发射器层，并在内容浏览器里锁定要复制或继续扩展的 Niagara System，为后面新增一层 `E-Smoke` 类身体烟雾做准备。
这一张已经切到新建出来的身体烟雾系统 `Ex_05_BodySmoke`，开始单独调它的基础发射器 `Minimal003`。当前先处理的是 `Shape Location`，也就是烟雾最初从多大范围内生成、以什么分布方式从角色身体附近冒出来。

- 当前打开的系统标签页：`Ex_05_BodySmoke`
- 当前选中发射器：`Minimal003`
- 当前选中模块：`Shape Location`
- `Shape` 下可见：
  - `Shape Primitive = Sphere`
  - `Sphere Radius = 30.0`
- `Distribution` 下可见：
  - `Sphere Distribution = Random`
  - `Sphere Surface Distri...` 两个当前可见值都为 `0`
  - `Hemisphere Distributi...` 两个当前可见值都为 `1.0`
- `Transform` 下可见：
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate = Local`
  - `Offset Mode = Default`
  - `Shape Origin = Position`
  - `Offset = (0.0, 0.0, 0.0)`
  - `Offset Coordinate = Simulation`
- 左侧预览时间约为 `3.45` 秒，只能看到一小团较淡的烟雾，说明这是一个规模较小、贴近身体局部位置使用的烟雾系统，而不是墙体大范围爆破烟。
- 这一步的作用：先用半径约 `30` 的球形发射区域定义身体烟雾的出生范围，让烟雾从角色局部空间内随机冒出，为后续再叠加重力、波动和 Alpha 调整做基础。

### 00:24:12-00:28:57 Niagara、Alpha、Houdini

- 本段定位：Niagara、Alpha、Houdini。
- 知识点：这样就醒颜色不用动了 应该不用再改了 差不多了 刚才说过的Alpha值适当调低点就行 这部分适当调低就行 这样就该加了 先放下来 然后在这加一下。
- 知识点：生成了 身体烟雾这次线 先做附加 进入Attach选择Crunch 它会自动显示可附加的位置 在FX里搜一下Hand Direction。
- 知识点：就是左拳那个位置 选这里 选好就成这样 您能看到泡沫涌动的效果 设好这段区域后 它就不会在原位附着得益到这边才行 就差不多了 这么操作就行真的话。
- 知识点：目前是设为 现在是可生成状态通过变更类型 将类型改为这里设为可附着 像这种设置循环效果这样用 这么一弄 建个Niagara组件接着。
- 知识点：设置好生命周期后就能这样操作 会生成可调节R值的控制点 让其调至最短再选定需要的 我们来选真数 要确定一下从撞墙瞬间开始连续生成 这样设置就行。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`Alpha`、`Houdini`、`生命周期`、`颜色`、`烟雾`。

**关键画面：**

这一张继续在 `Ex_05_BodySmoke` 中处理 `Minimal003` 的颜色和透明度衰减，重点是通过 `Scale Color` 里的 Alpha 曲线，让身体烟雾在生命周期前段快速显现、中段保持，再在后段自然淡出。

- 当前系统：`Ex_05_BodySmoke`
- 当前选中发射器：`Minimal003`
- 当前选中模块：`Scale Color`
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB` 当前为：
  - `(1.0, 1.0, 1.0)`
- `Scale Alpha` 已启用，并使用：
  - `Float from Curve`
- 曲线区域可确认：
  - 曲线输入索引为 `PARTICLES.NormalizedAge`
  - 曲线前段从接近 `0` 的透明度快速抬升
  - 中段维持在接近 `1` 的高透明度
  - 后段再下降回接近 `0`
- 曲线下方参数可见：
  - `Scale Curve = Random Range Float`
  - `Minimum = 1.25`
  - `Maximum = 0.9`
  - `Evaluation Type = Spawn Only`
- 左侧预览时间约为 `0.28` 秒，只能看到一团很小的白色烟雾，说明当前正在校正这种贴身烟雾的显隐节奏，而不是扩大其空间范围。
- 这一步的作用：把身体烟雾的 Alpha 变化做成“先显现、再维持、后淡出”的曲线，同时给缩放曲线保留一定随机区间，避免多次生成的烟团完全同步。
这一张切到 Sequencer，把刚做好的 `Ex_05_BodySmoke` 真正挂到角色动作上。重点不是粒子内部参数，而是把 Niagara 组件附着到角色的手部方向节点附近，并把生成区间放到冲刺撞墙动作发生的时段内。

- 当前编辑界面是 `Sequencer`
- 时间线上可见角色动作片段：
  - `Ability_DashingCross...`
  - `Ability_Dashing_Recovery`
- 当前新增的 Niagara 轨道为：
  - `Ex_05_BodySmoke`
  - 其下包含 `NiagaraComponent0`
- 该组件的生命周期轨道显示：
  - `System Life Cyc...`
- 附着对象可见为：
  - `Crunch (FX_handDir_)`
- 同一段时间线上还能看到已有的：
  - `Ex_05_Wall_Destruction`
- 当前光标位于大约 `0013` 帧附近，`Ex_05_BodySmoke` 的红色条带从这一段开始持续向后延伸，说明作者正在把身体烟雾的生成窗口放进具体动作时间范围内。
- 左侧可见 `Spawned`、`Transform`、`Location` 等轨道，其中 `Location` 当前可见：
  - `X = -2350.0`
  - `Y = -1507.474997`
  - `Z = 50.0`
- 这一步的作用：把身体烟雾系统从“单独可预览的 Niagara 资源”变成“随角色左手/手部方向节点一起运动的序列组件”，确保烟雾从撞墙瞬间开始跟着动作连续生成，而不是固定留在原地。
这一张回到实际镜头验证附着后的结果，确认 `Ex_05_BodySmoke` 不再停在原位，而是已经跟着机器人动作一起出现在身体附近，与原有的墙体破坏烟雾合成到同一镜头里。

- 当前界面重新回到关卡视口联调状态，下方仍打开 `Sequencer`，说明这是边看镜头边检查时序的结果图。
- 画面中机器人已经冲出墙体破口，左侧与脚边可见一层较淡但连续的烟雾条带，说明新增的身体烟雾正在和原有地面/破口烟雾一起工作。
- 与前面只看墙体破坏系统的结果相比，这一张的烟雾分布更贴近角色本体，而不是只停留在墙体前缘。
- 左侧内容浏览器仍选中了 `Ex_05_BodySmoke` 相关 Niagara System 资源，右侧 `Outliner` 中还能看到当前关卡下的序列对象：
  - `Additional_Picku...`
  - `BRolls`
  - `QA_Perf_Flythro`
  - `Ex_05_Wall_Destr...`
- 下方时间线光标已推进到约 `0085+` 附近，说明这是在更靠后的镜头时刻检查附着烟雾是否仍保持正确跟随。
- 这一步的作用：确认身体烟雾已经成功绑定到角色动作链路，在实际镜头里既能增强冲刺穿墙后的动势，又不会因为附着错误而留在原地或脱离角色轨迹。

### 00:28:57-00:31:54 Niagara、Houdini、粒子

- 本段定位：Niagara、Houdini、粒子。
- 知识点：光靠这些粒子想用的自信确实挺难的 很正常 但可以把它当个入门起点 哪怕只是尝了个滋味 也别在这儿半途而废 只要不因难 而放弃以后 慢慢就会越来越常用到它。
- 知识点：到时候哪怕只是做过一点点也会帮上大忙 我当初刚学Houdini时真的是一头雾水 特别难想过放弃的次数也太多了 现在我也觉得挺难的 我自己都还没到得心应手的地步能教的。
- 知识点：也就尽量教了 虽然我尽力讲 但在游戏领域哪怕只懂一点点也够用了 在游戏这边只要懂点皮毛 其实就能用上 所以哪怕只懂一点点完全够用了 所以我还是尽量教你。
- 知识点：而且说到模拟 我们现在主要围绕Houdini来教 模拟这块在Houdini里算挺容易的 之后去学Vex、Rango、Wall 这些可能觉得比Niagara模块脚本更难一点。
- 知识点：我倒是觉得模块脚本更难主要是没什么引导这些 当闲聊听一听就知道了 但是我还是觉得模块脚本比Niagara模块脚本更难一点。
- 核对对象：`Niagara`、`Houdini`、`粒子`。

**关键画面：**

这一张是整套效果接近收尾时的实机镜头回看，用来确认墙体破坏烟雾、地面碎片以及后面新增的身体跟随烟雾已经在同一镜头里融合到一起，而不是各层各自独立。

- 当前界面是关卡视口与 `Sequencer` 联动状态，不是单独的 Niagara 参数面板。
- 画面中机器人已经冲出墙体破口，身体周围、脚边和墙体前缘都被较厚的灰色烟雾包住。
- 地面近景仍能看到零散向外飞射的白色碎片条，说明破口碎片层仍在工作，没有被后加的烟雾完全盖掉。
- 烟雾主体主要分布在：
  - 角色脚边和身前下方
  - 墙体破口外缘
  - 角色左侧与背后的一条上扬残烟
- 左侧内容浏览器仍选中了 `Ex_05_BodySmoke` 相关 Niagara System 资源，说明当前是在确认新增身体烟雾加入后的最终合成效果。
- 右侧 `Outliner` 中可见当前关卡仍挂着同一组序列对象，包括：
  - `Additional_Picku...`
  - `BRolls`
  - `QA_Perf_Flythro`
  - `Ex_05_Wall_Destr...`
- 这一步的作用：在最终镜头里确认所有粒子层叠加后，冲刺穿墙这一动作既有墙体爆破感，也有贴身拖尾烟雾，不会只剩静态破口烟或孤立的身体烟。
这一张是穿墙爆发最强的一帧结果验证，主要检查大团烟雾是否足够把破口和角色出场瞬间包住，同时确认大块碎片、小碎块和细长碎片条都还保留清晰的飞散层次。

- 当前界面仍是关卡视口与 `Sequencer` 联调画面。
- 画面中央被高密度灰白色烟雾完全占据，烟雾从地面一直抬升到角色上方，说明破口爆发阶段的体积已经被做厚。
- 机器人主体只剩局部绿色机体从烟雾中露出，证明这一步的遮挡目标已经达成：角色不是干净地直接穿出，而是裹在爆发烟团里出现。
- 可见碎片类型包括：
  - 上方和中景中飞散的深色块状碎片
  - 下方和前景的白色细长条状碎片
  - 地面附近向外抛出的较大块砖石
- 烟雾分布不是单一圆团，而是同时向左右、向上和向镜头前方扩散，说明前面多层 `Source`、`Minimal` 与身体烟雾系统的叠加已经形成更完整的三维体积感。
- 右侧 `Outliner` 仍显示同一组序列对象，说明这是在同一镜头管线里直接看最终落地效果，而不是单独渲染某一层粒子。
- 这一步的作用：确认爆发瞬间既有足够的遮挡密度，又保留了碎片飞散的可读性，避免烟太薄或太厚导致画面失去层次。
这一张是本页教程结束前的收尾镜头，用来确认所有烟雾、碎片和附着粒子在镜头后段都已经正确消散，不会在场景里留下悬空残影、错误附着或持续生成的问题。

- 当前界面仍是关卡视口与 `Sequencer` 联动状态。
- 主画面已经回到基本干净的场景，只剩地形、远处残破结构和右侧墙体，说明前面生成的墙体爆破烟雾与身体跟随烟雾都已退出镜头。
- 画面中没有可见的大团烟雾、漂浮碎片或持续喷发的粒子条带，说明生命周期与销毁时机总体是对的。
- 左侧内容浏览器仍选中了 `Ex_05_BodySmoke` 相关 Niagara System 资源，表示作者是在完整演示跑完后直接回看最终退出效果。
- 右侧 `Outliner` 中的序列对象列表保持不变，说明这是同一关卡与同一序列的收尾帧，而不是切到别的测试场景。
- 这一步的作用：验证整套粒子链路从爆发到收尾都能正常结束，确保不会因为 Sequencer 生命周期、附着组件或 Niagara 自身循环设置导致粒子在镜头结束后还残留在场景中。

## 补充视觉证据

### S01 00:03:37

这是给前文 `S01` 段补的一张参数特写，专门用来补证 `Minimal004` 的 `Shape Location` 已经从普通盒体改成 `Ring / Disc` 方案，并且环半径中有一项使用了随发射器循环年龄变化的曲线控制。

- 当前选中发射器：`Minimal004`
- 当前选中模块：`Shape Location`
- `Shape` 下可见：
  - `Shape Primitive = Ring / Disc`
  - `Ring / Disc Mode = Circle`
- `Ring Radius` 下可见：
  - `A = 150.0`
  - `B = Float from Curve`
- `B` 对应的曲线面板可确认：
  - 曲线类型为 `Curve for Floats`
  - 曲线索引输入为 `EMITTER.NormalizedLoopAge`
  - 曲线从前段接近 `1.0` 逐步下降到后段约 `0.3`
  - 下方 `Scale Curve = 1.0`
- `Distribution` 下可见：
  - `Ring / Disc Distributi... = Random`
  - `Disc Coverage` 当前第二个值为 `0.0`
  - `U Distribution` 当前第二个值为 `0.0`
- `Transform` 下可见：
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
- 中间 `System Overview` 中同时能看到 `Minimal003`、`Minimal004`，说明这张补图仍然属于前面那组墙体破坏辅助发射器调参过程。
- 左侧预览时间约为 `4.08` 秒，画面里几乎只剩墙体模型本体，说明这张补图的重点完全是参数面板本身，而不是最终结果帧。
- 这一步的作用：补足前文缺失的关键证据，说明 `Minimal004` 的发射区域不是固定半径圆环，而是用 `Emitter NormalizedLoopAge` 驱动其中一维环半径逐步缩小，从而让粒子出生区域随循环时间发生变化。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


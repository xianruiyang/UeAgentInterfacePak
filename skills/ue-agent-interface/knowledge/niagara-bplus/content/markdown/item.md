# 整体节奏与光感调整

# 整体节奏与光感调整

## 关键术语

- `Emitter`、`Spawn`、`Local Space`、`Power`、`Emissive`、`Camera`、`Camera Shake`、`Curve`、`材质`、`粒子`、`Niagara`、`Spawn Rate`、`Lifetime`、`Normalized Age`、`发射器`、`系统`、`Niagara System`、`Particle`

## 分段知识

### 00:00:00-00:02:51 材质、粒子、发射器

- 本段定位：材质、粒子、发射器。
- 知识点：我们这一节是一个补录章节 我们要对整个雷神之锤这个公开课案例做一个整体节奏的调整 因为之前的公开课每一节都有新东西 新的材质,新的发射器,新的支持点给大家讲。
- 知识点：我们就精益求精 把它的整个美术节奏都再调整一遍 让它变得更好 虽然你单独调整一个发射器的细节。
- 知识点：对整体的效果并没有很明显的变化 但是量变引起质变 很多细节对压到一起之后 就会对整个特效有一个比较不错的提高 好的 那么我们就开始吧 这节课我们不会新建发射器。
- 知识点：说我们就对原有的这个发射器进行一个调整 OK 我把这个窗口再缩小一点 好 我这次换了一个1080P的显示器 这个字体和UI应该会比较合适。
- 知识点：因为之前有同学反馈 那个字体和UI太小了 在小屏幕比这本屏幕上看不太清晰 因为那个之前是4K转录1080P的 这一次我换了一个原生1080P的屏幕应该会好一些。
- 知识点：OK 那么我们就开始吧 好 我们首先运行一下 先看一下我们之前做的这个特效 整体还是不错的 但是有一些小细节我们还可以给它再提高一层楼 首先是这个粒子。
- 知识点：我们单独显示一下 这个粒子现在我感觉它有点太小夹子气了 就是飞的扩散的不够大 我们给它的阻力 适当的调整一下 这个屏幕空间感觉好紧促 OK。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`发射器`、`速度`、`曲线`。

**关键画面：**

这是进入 `p14` “整体节奏与光感调整”章节后的基线场景视图。当前画面还没有展开具体 Niagara 发射器参数，重点是确认本章仍在同一套落锤测试场景中，对既有系统做整体节奏微调，而不是新建全新的案例：

- 当前关卡/对象环境可见为：
  - 顶部已打开 Niagara System：`NS_Lightning_HammerHit`
  - 右侧 `Outliner` 中可见：
    - `BP_Skill_02`
    - `NS_Fog`
    - `PostProcessVolume`
    - `SkyLight`
    - `SM_Ground`
    - `SM_Ground_Collision`
  - 当前选中对象：`SM_Ground`
- 当前 `SM_Ground (Instance)` 的 `Transform`
  - `Location`：`(0.0, 0.0, 0.0)`
  - `Rotation`：`(0.0, 0.0, 0.0)`
  - `Scale`：`(300.0, 300.0, 1.0)`
  - `Mobility`：`Static`
- 视口中可见：
  - 角色手持锤子站在场景中心
  - 使用棋盘地面作为统一测试平面
  - 章节开场先在完整场景里回看现有效果，再决定后续逐个发射器精修

结合正文“这节课不会新建发射器”“对原有的发射器进行一个调整”“首先运行一下，先看一下我们之前做的这个特效”，这张图的作用是给后续所有微调提供统一参照：仍基于 `NS_Lightning_HammerHit` 和 `BP_Skill_02` 的原有落锤场景，只做整体节奏与光感的二次打磨。
这是本章开始进入具体发射器微调的画面。左侧系统总览已经切到粒子相关发射器，但当前右侧实际展开的是 `NE_Rock` 的 `Point Attraction Force`，说明作者先从既有石块/粒子系统里挑出影响节奏与扩散感的核心参数来调整：

- 当前系统总览中可见发射器：
  - `NE_Sparks_Burst`
  - 右侧相邻还有一个以 `NE_Eletric...` 开头的发射器卡片，但名称未完整展开
- 当前右侧选中发射器：`NE_Rock`
- `NE_Rock` 当前可见堆栈片段：
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Sub UVAnimation`
  - `Render > Sprite Renderer`
- 当前右侧打开的是 `Point Attraction Force`
  - `Attraction Strength`：`Random Range Float`
  - `Minimum`：`-45.0`
  - `Maximum`：`-35.0`
  - `Attraction Radius`：`100.0`
  - `Falloff Exponent`：`0.5`
  - `Attractor Position Offset`：`(0.0, 0.0, -60.0)`
  - `Attractor Position Offset Coordinate Space`：`Simulation`
  - `Kill Radius`：`4.0`
  - `Position To Attract`：`Particles.Position`
  - `Attractor Position`：`Engine.Emitter.SimulationPosition`

这张图说明本章虽然强调“先看整体粒子节奏”，但真正落手时还是回到已有发射器的受力/扩散参数上做精修。结合正文“粒子现在飞得扩散不够大”“给它的阻力适当调整”，当前这一步可以理解为先检查与粒子聚拢、回拉相关的 `Point Attraction Force` 是否过强或位置过深，为后续继续放大粒子扩散感做准备。
这是本章第一段真正落到“粒子飞得不够开、阻力需要调整”的核心画面。当前发射器是 `NE_Sparks_Burst`，作者通过修改 `Drag` 曲线，让电火花在前段更容易冲出去、后段再逐渐收住，从而得到更大但不至于失控的扩散范围：

- 发射器：`NE_Sparks_Burst`
- 当前堆栈结构可见为：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity From Point`
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Drag`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Render > Sprite Renderer`
- 当前右侧打开的是 `Drag`
  - `Drag`：`Float from Curve`
  - 曲线源：`Curve for Floats`
  - 曲线索引：`Particles.NormalizedAge`
  - `Scale Curve`：`Random Range Float`
  - `Minimum`：`2.5`
  - `Maximum`：`4.0`
  - `Evaluation Type`：`Spawn Only`
  - `Rotational Drag`：`1.0`
  - 曲线形态：
    - 出生时几乎为 `0`
    - 前段快速升到约 `0.67`
    - 后半段继续平滑抬升到约 `1.0`

左侧运行态里可以直接看到电火花条带被明显抛得更开，覆盖范围比之前更大，但仍然保留了向外扩散后的衰减感。结合正文“飞的扩散的不够大，我们给它的阻力适当调整一下”，复建时应把 `Drag` 做成“出生小、随后逐步增大”的生命周期曲线，而不是从一开始就给很高阻力。这样粒子前段能先冲出去，后段再被逐渐刹住，整体屏幕空间就会更舒展。

### 00:02:55-00:05:55 Emitter、Emissive、Camera

- 本段定位：Emitter、Emissive、Camera。
- 知识点：我们也加入了一个Camera Shake 是吧 所以说在这个Camera Shake生成的那一瞬间 屏幕会进行一个剧烈的抖动 你在那一瞬间去发射粒子的话。
- 知识点：很有可能会把很多粒子的细节给掩埋掉 因为屏幕抖的厉害 你根本看不清楚 所以说我们粒子的发射的时间。
- 知识点：可以让它适当延后一点 不用很多 不要延迟太多 要不然那样会有明显的滞后感 我们适当延迟一点 我们再来看一下效果 其实本质上就是想让我们粒子看得更加清晰。
- 知识点：可以 这个动感我觉得还是不错的 然后我们把它Sprite Size 我们再给它调整一下 OK 我们把它适当拉高一点 把这个自力吸服关掉 这个真的好烦人。
- 知识点：好 让它的粒子的缩放更强一点 并且衰减的更慢一点 可以单独显示看一下 再整体看一下 可以 这样粒子会更加的明显。
- 知识点：节奏也会更加的强 还有之前有同学在交流群里跟我说 这个粒子它离远了 它就会感觉光感不够 可以看一下 这个是正常的 这个是UE抗锯齿正常的一个裁减。
- 知识点：可以有两个解决办法 一个就是你继续增强它的Emissive强度 另外一个办法 你就是可以给它一个Camera Offset 给它一个Camera。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Emissive`、`粒子`。

**关键画面：**

这是在 `NE_Sparks_Burst` 上调整粒子发射时机的画面，用来避开 `Camera Shake` 最剧烈的那一瞬间，让粒子细节不要被屏幕抖动完全掩盖：

- 发射器：`NE_Sparks_Burst`
- 当前堆栈结构可见为：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity From Point`
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Drag`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Render > Sprite Renderer`
- 当前右侧打开的是 `Spawn Burst Instantaneous`
  - `Spawn Count`：`150`
  - `Spawn Time`：`0.025`
  - `Spawn Probability`：`1.0`
  - `Loop Count Limit`：`1`

结合正文“Camera Shake 生成的那一瞬间屏幕会剧烈抖动”“粒子的发射时间可以适当延后一点”，这一步的核心就是把 `Spawn Time` 从即时触发改成轻微延后 `0.025` 秒。这样火花仍然紧跟落锤出现，但会错开最强镜头震动的瞬间，让粒子条带和扩散方向更容易被看清。
这是在 `NE_Sparks_Burst` 中增强粒子体量感的画面。当前打开的是 `Scale Sprite Size`，作者用一条“前段迅速放大、后段慢慢回落”的曲线，让火花在爆发瞬间更醒目，同时保留更慢的尺寸衰减：

- 发射器：`NE_Sparks_Burst`
- 当前堆栈结构可见为：
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Drag`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Render > Sprite Renderer`
- 当前右侧打开的是 `Scale Sprite Size`
  - `Scale Sprite Size Mode`：`Uniform Curve`
  - 曲线源：`Curve for Floats`
  - `Uniform Curve Index`：`Particles.NormalizedAge`
  - `Uniform Curve Scale`：`1.0`
  - 曲线形态：
    - 出生时为 `0`
    - 前段快速抬升到约 `2.75`
    - 随后回落到约 `1.0`
    - 尾段再逐步衰减到 `0`

结合正文“把它 Sprite Size 再调整一下，适当拉高一点”“让粒子的缩放更强一点，并且衰减得更慢一点”，复建时应把尺寸曲线做成先猛然放大、再缓慢回落，而不是线性收缩。这样火花在爆发时更有冲击感，离远看也更容易被看见。
这是在 `NE_Sparks_Burst` 上补 `Camera Offset` 模块的画面，用来作为“离远后光感不够”时的第二种处理思路入口。当前截图只显示模块已添加，但还没有把偏移值真正调高：

- 发射器：`NE_Sparks_Burst`
- 当前堆栈结构可见为：
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Drag`
  - `Gravity Force`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Camera Offset`
  - `Render > Sprite Renderer`
- 当前右侧打开的是 `Camera Offset`
  - `Camera Offset Amount`：`0.0`

结合正文“有两个解决办法，一个是继续增强 Emissive，另一个办法就是给它一个 Camera Offset”，这张图能确认的事实是：作者已经把 `Camera Offset` 正式接入 `NE_Sparks_Burst` 的更新链路中，作为增强远距离可见性的备用方案。但本图里 `Camera Offset Amount` 仍然是 `0.0`，说明此时还停留在模块挂载/准备调参阶段，尚未展示最终偏移数值。

### 00:05:58-00:08:50 Power、材质、粒子

- 本段定位：Power、材质、粒子。
- 知识点：OK 就是要这种充平的感觉 然后我们再来到这个可以看一下 这个我也不是很满意 就是我们这个X型闪电 我们把它的亮度再适当提高一点 我们把它的峰值亮度适当提高一点点。
- 知识点：让它衰减 同样的跟粒子一样 也是让它衰减的更慢一点 我们还是希望这个闪电在最亮的时候 更加的耀眼一些 这样应该能看得到 OK 再适当往这边移一些。
- 知识点：好 我们看一下 现在看起来会更强一些 然后我们来到它这个材质实力 也可以把它这个re-fan 我们让它不要power那么多 保存资源 OK。
- 知识点：同样的另外一个材质实力 也是它的这个re-fan 我们给它改成2 之前是2.5 它会被更多的指数函数所影响 再整体看一下 它现在这个光感我觉得就还是不错的。
- 知识点：我们慢动作看一下 可以 OK 然后我们继续去调整 还有就是我们这个石块 现在的石块大家可以看一下 我感觉它现在整体说的速度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`速度`、`曲线`、`闪电`。

**关键画面：**

这是从火花粒子调整切换到 X 型闪电发射器的过渡画面。系统总览已经选中 `NE_Lightning_Strike`，说明作者开始处理本段里提到的“X 型闪电亮度和衰减”，但当前右侧详情面板还停留在上一发射器的 `Camera Offset`，因此这张图主要能确认的是发射器切换与总览结构，而不是最终闪电参数：

- 当前系统总览选中发射器：`NE_Lightning_Strike`
- `NE_Lightning_Strike` 当前可见堆栈结构：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Set: Particles.VisibilityTag`
  - `Sprite Facing and Alignment`
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Set: Particles.SubImageIndex`
  - `Render`
  - `Sprite Renderer`
  - `Sprite Renderer`
- 当前右侧仍显示上一发射器 `NE_Sparks_Burst` 的 `Camera Offset`
  - `Camera Offset Amount`：`0.0`

结合正文“这个 X 型闪电我也不是很满意，我们把它的亮度再适当提高一点”，这张图的意义是标记出本段开始转向 `NE_Lightning_Strike` 发射器本身。可复建信息是：后续要调的对象不是火花而是这个带双 `Sprite Renderer` 的闪电发射器，其更新链路里已经包含 `Scale Color`、`Scale Sprite Size` 和 `SubImageIndex` 控制。
这是在 `NE_Lightning_Strike` 中检查 X 型闪电渲染层的画面。当前作者没有直接开材质图，而是先定位到 `Sprite Renderer`，确认这层闪电实际使用的材质资源与渲染可见性：

- 发射器：`NE_Lightning_Strike`
- 当前堆栈结构可见为：
  - `Particle Spawn`
  - `Initialize Particle`
  - `Set: Particles.VisibilityTag`
  - `Sprite Facing and Alignment`
  - `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Scale Sprite Size`
  - `Set: Particles.SubImageIndex`
  - `Render`
  - `Sprite Renderer`
  - `Sprite Renderer`
- 当前右侧打开的是其中一个 `Sprite Renderer`
  - `Material`：`M_FX_Lightning_Strike_002`
  - `Material User Param Binding`：`None`
  - `Source Mode`：`Particles`
  - `Alignment`：`Automatic`
  - `Facing Mode`：`Automatic`
  - `Macro UVRadius`：`0.0`
  - `Default Pivot in UV Space`：`(0.5, 0.5)`
  - `Pixel Coverage Blend`：`1.0`
  - `Sort Mode`：`None`
  - `Enable Camera Distance Culling`：关闭
  - `Renderer Visibility`：`1`

结合正文“我们这个 X 型闪电，把它的亮度再适当提高一点”“让它最亮的时候更加耀眼一些”，这张图能先确认负责该闪电层的基础材质就是 `M_FX_Lightning_Strike_002`，并且当前渲染器本身是开启可见的。后续若要继续增强亮度，应优先检查这个材质或与之对应的材质实例参数，而不是误改到其他发射器。
这是在继续调整石块整体运动速度的画面。当前发射器切回 `NE_Rock`，作者把 `Add Velocity In Cone` 从单纯常量速度改成曲线驱动，并配合较大的缩放因子控制石块飞出的前后节奏：

- 发射器：`NE_Rock`
- 当前堆栈结构可见为：
  - `Particle Spawn`
  - `Initialize Particle`
  - `Add Rotational Velocity`
  - `Shape Location Cylinder`
  - `Initial Mesh Orientation`
  - `Calculate Mass and Rotational Inertia by Volume`
  - `Point Attraction Force`
  - `Add Velocity In Cone`
  - `Curl Noise Force`
  - `Apply Initial Forces`
  - `Dynamic Material Parameters`
  - `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Drag`
  - `Collision`
  - `Solve Forces and Velocity`
  - `Update Mesh Orientation Rolling`
  - `Dynamic Material Parameters 001`
- 当前右侧打开的是 `Add Velocity`
  - `Velocity Mode`：`In Cone`
  - `Velocity Speed`：`Float from Curve`
  - 速度曲线形态：
    - 出生时约 `2.35`
    - 很快降到约 `1.45`
    - 中段维持在约 `1.45`
    - 尾段再降到约 `0.5`
  - `CurveIndex`：`Random(0,1)`
  - `Scale Curve`：`600.0`
  - `Distribution Along Cone Axis`：`0.5`
  - `Speed Falloff From Cone Axis`：`0.7`
  - `Cone Axis`：`(0.0, 0.0, 1.0)`
  - `Cone Angle`：`110.0`
  - `Inner Cone Angle`：`50.0`
  - `Cone Angle Mode`：`Degrees`

结合正文“还有就是这个石块，我感觉它现在整体速度……”，这张图说明作者在收尾阶段也顺手回调了石块喷发节奏：前段给更高的抛出速度，中后段用曲线压下来，避免石块从头到尾都以同样强度飞散。这样既保留落锤冲击感，又不会让石块运动过分抢戏。

### 00:08:58-00:12:12 Emitter、Spawn、Camera

- 本段定位：Emitter、Spawn、Camera。
- 知识点：我们看一下 总体先看一下 可观察到现在这个石块 感觉飞舰的会更加不规律 可观察到 这个有一个充平的感觉 之前它飞舰的有点太过于规律 可观察到它是一个以。
- 知识点：圆形扩散出去的 现实中其实不会有这么规则的情况 我们要让它更符合物理 可以 然后我们把它的大小也再缩小一点 因为这个石块它是根据一个物理的质量。
- 知识点：和密度去进行一个计算的 所以说它的石块越小 它收到的力就会越强 我们它的大小也适当再降低一点 可以直接给这个Skyl Curve 0.7。
- 知识点：我们再看一下 可观察到它现在有的石块飞得非常高 有的石块比较低 整体并没有那么均匀 OK 我们再给它调整一下这个曲线 让它适当的降下来一些。
- 知识点：这边也是让它适当降下来一些 整体的 这个0.725 可观察到它现在这个石块飞舰就非常的漂亮 OK 好的 最后我们来到我们这个进阶光斑 再放大一点。
- 知识点：我们也是跟我们普通光斑一样 我们先让它的位置适当上移一些 先给它单独显示出来 让它的位置适当往上移一些 不要全都埋在地底下 然后我们把它Dynamic。
- 知识点：Pre-Emitter里面的Fit Distance 我们给它降低一点 不需要它飞得那么多 其实它只要跟这个地面没有一个明显的穿帮。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Emitter`、`Spawn`、`Curve`、`曲线`。

**关键画面：**

这是在运行态检查 `NE_Rock` 石块喷发形态的画面。作者当前关注的重点是让石块飞行分布摆脱过分规则的圆形扩散，变得更像真实受力后的不均匀抛散：

- 发射器：`NE_Rock`
- 当前堆栈结构可见为：
  - `Particle Spawn`
  - `Initialize Particle`
  - `Add Rotational Velocity`
  - `Shape Location Cylinder`
  - `Initial Mesh Orientation Random`
  - `Calculate Mass and Rotational Inertia by Volume`
  - `Point Attraction Force`
  - `Add Velocity In Cone`
  - `Curl Noise Force`
  - `Apply Initial Forces`
  - `Dynamic Material Parameters`
  - `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Drag`
  - `Collision`
  - `Solve Forces and Velocity`
  - `Update Mesh Orientation Rolling`
  - `Dynamic Material Parameters 001`
  - `Render > Mesh Renderer`
- 当前右侧打开的是 `Add Velocity`
  - `Velocity Mode`：`In Cone`
  - `Velocity Speed`：`Float from Curve`
  - 速度曲线：
    - 前段约 `2.35`
    - 中段约 `1.45`
    - 尾段约 `0.5`
  - `CurveIndex`：`Random(0,1)`
  - `Scale Curve`：`600.0`
  - `Distribution Along Cone Axis`：`0.5`
  - `Speed Falloff From Cone Axis`：`0.7`
  - `Cone Axis`：`(0.0, 0.0, 1.0)`
  - `Cone Angle`：`110.0`
  - `Inner Cone Angle`：`50.0`

左侧运行态里可以直接看到：石块并不是一圈均匀整齐地向外炸开，而是高低、远近、方向都更有变化，同时仍然围绕烟尘中心爆散。结合正文“之前它飞溅得有点太过于规律”“现实中不会有这么规则的情况”，这张图可以作为当前石块运动节奏已经接近目标形态的证据：依靠随机曲线速度和宽锥形分布，把飞散结果打破为更自然的非均匀状态。
这是 `NE_Rock` 发射器里用于控制石块大小随机性和生命周期缩放的 `Mesh Scale` 设置画面，目的就是把石块整体再压小，并让不同石块尺寸产生差异，从而配合前面的受力逻辑形成“大块慢、小块快”的观感。

- 发射器：`NE_Rock`
- 当前模块：`Mesh Scale`
- 顶层表达式：`Multiply Vector by Float`
- `Vector` 输入：`Random Range Vector`
  - `Minimum`：`(0.85, 0.85, 0.8)`
  - `Maximum`：`(1.25, 1.25, 1.25)`
- `Float` 输入：`Float from Curve`
  - 曲线资源：`Curve for Floats`
  - 曲线趋势：
    - 出生时约 `1.8`
    - 前段快速降到约 `1.2`
    - 中后段维持在约 `1.15`
    - 末段继续降到约 `0.95`
  - `CurveIndex`：`Random(0,1)`
  - `Scale Curve`：`0.725`
- `Mesh Renderer Array Visibility`：`Unset`

这张图对应正文里“石块越小，它受到的力就会越强”“可以直接给这个 Scale Curve 0.7”“整体这个 0.725”的调整说明。也就是说，这一步不是单纯统一缩小模型，而是先用 `Random Range Vector` 给每个石块一个不同的基础尺寸，再用生命周期曲线乘上 `0.725` 的整体缩放系数，让石块在出生初期偏大、随后收敛到更克制的体量。这样既能避免石块尺寸整齐一致，也能为后续运动表现提供更自然的轻重差异。
这是 `NS_Lightning_HammerHit` 系统中 `NE_A_Flare` 发射器的 `Scale Sprite Size` 设置画面，用来控制闪光片精灵在生命周期内的放大和收缩节奏。

- 系统：`NS_Lightning_HammerHit`
- 发射器：`NE_A_Flare`
- 当前模块位置：
  - `Emitter Update`
  - `Particle Spawn`
    - `Initialize Particle`
  - `Particle Update`
    - `Particle State`
    - `Scale Color`
    - `Scale Sprite Size`
    - `Dynamic Material Parameters`
    - `Camera Offset`
  - `Render`
    - `Sprite Renderer`
- `Scale Sprite Size Mode`：`Uniform Curve`
- 曲线资源：`Curve for Floats`
- `Uniform Curve Index`：`Particles.NormalizedAge`
- `Uniform Curve Scale`：`1.0`
- 曲线形态：
  - 出生时接近 `0`
  - 前段迅速抬升到约 `2.5`
  - 中段回落到约 `1.1`
  - 末段继续衰减到 `0`

左侧预览能看到角色挥锤位置前方存在一团镜头向的亮斑，因此这张图表达的是闪光片不是从头到尾保持同一尺寸，而是按生命周期先迅速膨胀、形成一瞬间的高亮爆点，再逐步缩回并消失。结合该段主题里对 `Emitter`、`Spawn`、`Camera` 的调整，这条曲线的作用就是把命中特效中的 flare 峰值集中在出现初期，避免亮片停留过久或尺寸始终僵硬不变。

### 00:12:19-00:14:41 Local Space、Camera、Camera Shake

- 本段定位：Local Space、Camera、Camera Shake。
- 知识点：OK 没什么问题 同样的可以把它Camera Offset 给它适当加大一点 让它离我们的摄像机渲染的更近 来看一下 好的 那么我们基本上就把我们想调整的都调整完了。
- 知识点：我们再去整体检查一遍 这每一个发热器的Local Space Local Space和World Space 其实还是比较重要的 这个果然就没有勾。
- 知识点：因为它会涉及到在特效装配时候 一些空间的转换 都给它勾上 所以说在这边你就先跟着我做 先把它都勾上 然后等到我们正式课的时候 我再给大家解释。
- 知识点：什么时候勾 什么时候不勾 勾不勾会有什么影响 OK 先都勾上 看着整齐一点 这Camera Shake也可以勾上 好的 我们再整体播放一下 看起来没什么太大问题。
- 知识点：可以慢动作看一下 OK 如果你运行的时候保存的话 它就会比较卡 这个是正常现象 它又卡了一下 可以按键盘上的F11全屏显示 好的 那么在这里就基本上还原了。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Local Space`。

**关键画面：**

这是 `NS_Lightning_HammerHit` 的整体播放检查画面，当前右侧选中的是 `NE_A_Flare` 发射器，用于核对命中瞬间的镜头向亮片尺寸曲线在实际播放中的表现。

- 系统：`NS_Lightning_HammerHit`
- 当前发射器：`NE_A_Flare`
- 当前模块：`Particle Update > Scale Sprite Size`
- `Scale Sprite Size Mode`：`Uniform Curve`
- 曲线资源：`Curve for Floats`
- `Uniform Curve Index`：`Particles.NormalizedAge`
- `Uniform Curve Scale`：`1.0`
- 曲线趋势：
  - 起点接近 `0`
  - 很快抬升到约 `2.5`
  - 中段回落到约 `1.1`
  - 尾段衰减到 `0`

左侧运行态中，角色已经挥锤站定，地面上还能看到一小片贴近命中区域的蓝白色闪电与亮片残留。这说明 `NE_A_Flare` 的表现不是持续铺满画面，而是依靠一条“快速放大再衰减”的精灵尺寸曲线，把亮片峰值压缩在命中后的短时间窗口里。就这一张图能确认的内容而言，它主要用于检查 flare 的出现时机、峰值大小和消退节奏是否与整体命中特效同步。
这张图是在检查某个发射器的 `Emitter Properties`，重点是 `Local Space` 是否启用。但当前截图里发射器归属不一致：右上详情标题显示为 `NE_Rock`，中间浮动堆栈窗口标题显示为 `NE_Decal`，因此不能可靠判断这些属性究竟属于哪一个发射器，当前帧未确认 owner。

当前能确认的信息只有：

- 当前查看的是 `Emitter Properties`
- `Local Space`：已勾选
- `Determinism`：未勾选
- `Interpolated Spawning`：已勾选
- `Sim Target`：`GPUCompute Sim`
- `Calculate Bounds Mode`：`Dynamic`
- `Requires Persistent IDs`：未勾选

从正文“这个果然就没有勾”“都给它勾上”可以确认，本段核心动作是在逐个检查发射器的 `Local Space`。但就这张截图本身，只能证明某个发射器的 `Local Space` 已经被打开，无法无歧义证明是 `NE_Rock` 还是 `NE_Decal`，也无法据此推断其余发射器的状态。
这是 `NS_Lightning_HammerHit` 在完成本段 `Local Space`、`Camera`、`Camera Shake` 检查后的最终播放结果画面。截图里没有参数面板，能确认的是命中特效在视口中的落点和残留形态：

- 地面中心保留一块清晰的命中裂纹 decal
- 裂纹内部和边缘有蓝白色电流高亮
- 命中点上方仍有一团半透明烟雾/冲击残影
- 周围散落少量黑色碎石，分布在命中点外圈
- 角色本体已经不在画面中心，镜头主要对准地面命中区域

这张图的意义是验证整体结果是否稳定锚定在落点附近，而不是随着角色或镜头移动发生明显漂移。结合本段正文里“把每一个发射器的 Local Space 都检查一遍”“再整体播放一下，看起来没什么太大问题”，可以把它视为本次空间与镜头相关设置调整后的结果确认图：最终保留下来的裂纹、电流、烟雾和碎石都仍然围绕同一个地面命中点组织，没有出现一眼可见的错位。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


# Strike 闪电序列帧随机

# Strike 闪电序列帧随机

## 关键术语

- `Spawn`、`Update`、`Particle Spawn`、`Particle Update`、`Velocity`、`Color`、`Alpha`、`Scale Color`、`Scale Sprite Size`、`SubUV`、`UV`、`Add`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:00-00:03:58 Velocity、Add、材质

- 本段定位：Velocity、Add、材质。
- 知识点：我们回来继续开始雷霆之锤的制作 这节课我们就会专注于NS里面的操作 暂时就不用新做材质了。
- 知识点：我们整体再来调整一下 看看其他的发射器 有没有值得需要完善的地方 首先是FLAIR 这个它现在时间太短了 给它适当提高一点0.35。
- 知识点：我把它的这个亮度适当降下来一点 但是衰减的让它变慢 同时我们要把这边不要让它的亮度归零 因为它这边用的是一个Translucent的材质。
- 知识点：不需要那么快的消散掉 OK 上海的我们就暂时先不改了 我们先往后坐 然后之后如果有需要配合的我们再加 在这边给地面再添加一个粒子发射器。
- 知识点：等于说进一步完善我们这个SHAKWEIWO 不光是有这个气流还有这个能量 我们还有一些粒子去配合它。
- 知识点：这个slender是怎么分布的 我们先把粒子数量给多一点 300 然后把粒子数量适当调小一点。
- 知识点：它现在太大了 不方便我们看分布 我们就实施 这个足够了 然后我们把它的中心点往上提 可观察到它现在这个粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Velocity`、`Add`、`Translucent`、`材质`、`粒子`、`发射器`、`速度`、`冲击波`。

**关键画面：**

这张图先回到系统中已有的 `NE_Flare` 发射器，对它的 `Scale Sprite Size` 做一次收缩和时序修整。右侧详情面板显示当前模块为 `Scale Sprite Size`，缩放模式使用 `Uniform Curve`，曲线横轴是 `Particles.NormalizedAge`；曲线从开头的 `0` 迅速拉到峰值约 `4`，随后下降到中段约 `1.5`，最后回落到 `0`。结合正文里“这个它现在时间太短了，给它适当提高一点 0.35”“亮度适当降一点但衰减慢一点”的上下文，这一步是在先把闪光层的尺寸节奏调整顺，再去处理后续新加的地面粒子层。

节点定义集：

- Niagara 发射器：`NE_Flare`
- `Scale Sprite Size`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 模块曲线配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Scale Sprite Size`
- `Scale Sprite Size Mode = Uniform Curve`
- 曲线源：`Curve for Floats`
- 曲线横轴：`Particles.NormalizedAge`
- 当前可见曲线关键趋势：
- 起点 `0`
- 早期快速升到约 `4.0`
- 中段回落到约 `1.5`
- 末端归零
- `Uniform Curve Scale = 1.0`

输出/预览：

- 左侧主视口中 `NE_Flare` 当前几乎不可见，说明当前时间片下它的尺寸和亮度都被压得较低
- 当前画面的复建重点是：先重新整理 Flare 层的生命周期尺寸曲线，让它不要过大或过快消散，为后面在同一系统里继续补速度线/地面能量粒子做平衡
这张图开始为地面速度线/能量粒子新增一个独立发射器，但还没进入具体参数细调。右侧系统概览里可以看到一个新插入的 `Empty` 发射器骨架，已经包含 Niagara 默认的基础模块栈：`Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Emitter State`、`Particle Spawn`、`Initialize Particle`、`Particle Update`、`Particle State`、`Render`、`Sprite Renderer`。结合正文“给地面再添加一个粒子发射器”的说明，这一步是先把新的粒子层容器搭出来，后续才会往里面填数量、尺寸、速度和颜色。

节点定义集：

- Niagara System：`NS_Lightning_HammerHit`
- 新发射器：`Empty`
- `Emitter Summary`
- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Particle Spawn`
- `Initialize Particle`
- `Particle Update`
- `Particle State`
- `Render`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 发射器骨架创建界面，不涉及节点连线

设置/参数：

- 当前新建的是一个默认空发射器模板
- 发射器内已带默认 `Sprite Renderer`
- 时间轴底部可见当前系统中已有 `5 items`，说明这是在原系统基础上继续追加新层，而不是单独新建新系统

输出/预览：

- 左侧主视口里暂时还看不到新增发射器的可见粒子
- 当前画面的复建重点是：先把用于地面速度线/能量补层的新发射器插入系统，为下一步具体设置粒子数、尺寸和分布做准备
这张图已经把刚才的空发射器落成具体用途层，并命名为 `NE_Sparks_Ground`。当前发射器栈中可见它使用了 `Shape Location Cylinder` 和 `Add Velocity From Point`，说明这层粒子不是随意散布，而是先在一个圆柱区域内生成，再从中心向外施加速度，做出地面速度线/能量喷射的分布。右侧当前选中的就是 `Add Velocity` 模块，细节面板清楚给出了它的径向速度设置。

节点定义集：

- 发射器：`NE_Sparks_Ground`
- `Shape Location Cylinder`
- `Add Velocity`
- `Solve Forces and Velocity`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 模块栈与参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Add Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed = 25.0`
- `Velocity Origin = Emitter.SimulationPosition`
- `Origin Offset = (0.0, 0.0, 0.0)`
- `Origin Offset Coordinate Space = Local`
- 发射器栈中当前可见模块顺序包含：
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Shape Location Cylinder`
- `Add Velocity From Point`
- `Solve Forces and Velocity`
- `Sprite Renderer`

输出/预览：

- 左侧主视口暂时仍看不到明显粒子，这是因为当前时间片和发射量都还在初步配置阶段
- 当前画面的复建重点是：把地面速度线层定成“圆柱分布 + 从中心向外加速度”的基本结构，为后续把速度提到 2400-2500、再配颜色和 Alpha 打下准确的发射逻辑

### 00:04:01-00:06:57 Update、Color、Alpha

- 本段定位：Update、Color、Alpha。
- 知识点：那么我们这个速度就直接在这边改一下 我们让它速度直接给一个比较大的数值 2400 2500 可观察到它就一瞬间就扩散出去了 非常的有力量感。
- 知识点：这个数量我们还是改回到30 300太多了 OK 就形成了一个类似于速度线的效果 我们把它的颜色也设置一下。
- 知识点：现在太暗了 看不太清 亮度给100 给成1000了 好颜色适当的 看起来效果还可以 然后我们把它的生命 也random一下 这个就没必要用它那个曲线去精确的控制了。
- 知识点：因为它这个飞得非常快 我们也只是要它这样一个动感 可以 可以跟那个冲击波合起来看 因为它们是属于一个体系的 它这个粒子的问题现在就是一开始飞得太快了。
- 知识点：我们都已经看不到残留了 我们给它这个update这边加一个转 让它一开始适当有一点阻力 然后越飞越快 这样看起来可能会更好看一点 好我们直接给它3。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Scale Color`、`材质`、`粒子`、`速度`、`颜色`、`曲线`。

**关键画面：**

这张图把 `NE_Sparks_Ground` 的地面速度线从低速试探推进到真正的爆发速度。当前右侧选中模块仍是 `Add Velocity`，但 `Velocity Speed` 已从单值切到 `Random Range Float`，并把最小值和最大值分别设到 `2400.0` 与 `2500.0`。结合正文里“速度直接给一个比较大的数值 2400、2500，一瞬间就扩散出去”的说明，这一步的核心就是让地面粒子拥有强烈的外冲感，而不是慢速滑开。

节点定义集：

- 发射器：`NE_Sparks_Ground`
- `Shape Location Cylinder`
- `Add Velocity`
- `Solve Forces and Velocity`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Add Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed = Random Range Float`
- `Minimum = 2400.0`
- `Maximum = 2500.0`
- `Velocity Origin = Emitter.SimulationPosition`
- `Origin Offset = (0.0, 0.0, 0.0)`
- `Origin Offset Coordinate Space = Local`

输出/预览：

- 左侧主视口当前仍看不到稳定残留，这是因为粒子速度被拉得很高，处于“瞬间冲散”的调试阶段
- 当前画面的复建重点是：把地面速度线层的径向速度直接提升到爆发级区间，为后面再通过数量、颜色、寿命和阻力把观感拉回可读范围
这张图在 `NE_Sparks_Ground` 的 `Particle Update` 中加入了 `Drag`，用来修正“粒子一开始飞得太快、几乎看不到残留”的问题。右侧详情面板显示当前 `Drag` 使用 `Float from Curve`，曲线横轴是 `Particles.NormalizedAge`，数值从开头接近 `1` 线性下降到末端 `0`。结合正文“让它一开始适当有一点阻力，然后越飞越快”的说明，这条曲线的作用不是持续减速，而是让速度线在出生早期被轻微压住，随后逐步解除阻力，形成更有层次的外冲节奏。

节点定义集：

- 发射器：`NE_Sparks_Ground`
- `Shape Location Cylinder`
- `Add Velocity From Point`
- `Drag`
- `Solve Forces and Velocity`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 模块曲线配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Drag`
- `Drag = Float from Curve`
- 曲线横轴：`Particles.NormalizedAge`
- 当前可见曲线特征：
- 起始值约 `1.0`
- 中段线性下降
- 末端归零
- `Scale Curve = 1.0`
- `Rotational Drag = 1.0`

输出/预览：

- 左侧主视口中已经能看到一圈稀疏的地面速度线残影，说明粒子不再瞬间完全飞散
- 当前画面的复建重点是：通过 `Drag` 让速度线先“稍微刹一下”，再逐渐释放速度，从而得到比单纯高初速更可读的动感轨迹
这张图把 `NE_Sparks_Ground` 的视觉调色推进到 `Scale Color` 阶段，并且不是只调一种曲线，而是把 `RGB` 和 `Alpha` 分开控制。右侧详情面板显示 `Scale Mode = RGB and Alpha Separately`：上半部分的 `Scale RGB` 使用 `Vector from Float`，其底层 `FloatCurve` 在出生极早期维持很高的亮度值，随后迅速掉到约 `1.x` 并继续缓慢下降；下半部分的 `Scale Alpha` 也使用 `Float from Curve`，从接近 `1` 平滑衰减到末端接近 `0`。结合正文里“颜色太暗了，亮度给到 100”“颜色设一下”“生命 random 一下”的上下文，这一步的目标是把高速地面粒子的可见度抬起来，同时通过透明衰减保住它的速度线感，而不是让它们变成一团持续发亮的杂点。

节点定义集：

- 发射器：`NE_Sparks_Ground`
- `Scale Color`
- `Drag`
- `Solve Forces and Velocity`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 曲线配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Scale Color`
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Vector from Float`
- `Scale Alpha = Float from Curve`
- 两条曲线横轴均基于 `Particles.NormalizedAge`
- `Scale RGB` 当前可见趋势：
- 出生极早期保持高亮
- 很快跌落到约 `1.x`
- 后续继续缓慢衰减
- `Scale Alpha` 当前可见趋势：
- 起始接近 `1`
- 中后期持续下滑
- 末端接近 `0`

输出/预览：

- 左侧主视口里地面速度线已经形成一圈更清楚的亮弧和散点残影
- 当前画面的复建重点是：用高亮但快速回落的 `RGB` 曲线配合持续衰减的 `Alpha` 曲线，把 `NE_Sparks_Ground` 调成“亮一下就拉出残影”的速度线层，而不是稳定停留的发光粒子

### 00:07:15-00:10:07 材质、粒子、发射器

- 本段定位：材质、粒子、发射器。
- 知识点：这个粒可以适当给小一点 太大了 好的我们再给它适当来一个coronoids 不过这个coronoids我们就不会给的很强 因为我们还是想要它这样一个往外。
- 知识点：迸发的速度感 而不是过分的被空气乱流所扰动 要不然它就会失去它的力量大了 我们给它的这个strength 就简单给一个50到200 让它适当有一点点偏移。
- 知识点：是那么规则 其实也是变相增加它的一些随机感 OK我们把它这个 长度也再降一点 好我们整体来看一下 整体看着就感觉很好了 它地面上也有一些粒子在往外飞。
- 知识点：但是它很小 它只是提到一个点缀作用 可以再给它搞弱一点 OK 好我们地面这个粒子发射器就添加完成了。
- 知识点：紧接着我们就要开始重头戏 也就是我们这个闪电 是我们两个从天而降的闪电 好我们再来添加一个 coronoids的发射器。
- 知识点：给它单独显示 然后我们改成叫ne-lightning-strength 这个技能的设计灵感是我参考了战神5 它里面雷神索尔 它在用它的雷神之锤砸地的时候。
- 知识点：它为了让整个特效更加的立体 所以说就会有两道从天而降的闪电来帮助它 并且形成一个X形状 看起来非常的有力量感 好的那么我们就先burst一个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`材质`、`贴图`、`粒子`、`发射器`、`序列`、`速度`、`闪电`。

**关键画面：**

这张图仍在微调 `NE_Sparks_Ground`，目的是把地面速度线压回“点缀层”而不是主视觉。右侧当前选中的还是 `Add Velocity`，但随机速度区间已经从上一段更高的 `2400-2500` 回收到了 `2300-2400`。结合正文里“可以再给它搞弱一点”“地面这个粒子发射器就添加完成了”的说明，这一步是在最后轻微削弱地面粒子的外冲力度，让它保留力量感，同时避免抢掉后面要加的下劈闪电主戏份。

节点定义集：

- 发射器：`NE_Sparks_Ground`
- `Shape Location Cylinder`
- `Add Velocity From Point`
- `Drag`
- `Solve Forces and Velocity`
- `Scale Color`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Add Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed = Random Range Float`
- `Minimum = 2300.0`
- `Maximum = 2400.0`
- `Velocity Origin = Emitter.SimulationPosition`
- `Origin Offset = (0.0, 0.0, 0.0)`
- `Origin Offset Coordinate Space = Local`

输出/预览：

- 左侧主视口中仍能看到一圈淡蓝白色地面速度线残影
- 当前画面的复建重点是：把 `NE_Sparks_Ground` 的最终速度稍微往回压一档，使它只承担外围动感和地面点缀，不盖过后面两道主闪电的视觉权重
这张图开始搭建“从天而降的闪电”新发射器，但当前阶段还停留在新建骨架与基础初始化，并未进入具体闪电形状。系统里新增了一列 `Empty` 发射器，右侧详情面板当前显示它的基础属性和 `Initialize Particle`。可以确认这层仍是默认空模板，使用 `Sprite Renderer`，并先把 `Lifetime` 设成较长的 `5.0`，为后面做纵向下劈闪电留出足够存在时间。

节点定义集：

- 新发射器：`Empty`
- `Emitter Summary`
- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Particle Spawn`
- `Initialize Particle`
- `Particle Update`
- `Particle State`
- `Render`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 发射器骨架和基础属性配置界面，不涉及节点连线

设置/参数：

- 当前新建发射器名称仍为 `Empty`
- `Life Cycle Mode = System`
- `Scalability Mode = System`
- `Initialize Particle`
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- 当前模板渲染器为 `Sprite Renderer`

输出/预览：

- 左侧主视口还没有出现新的闪电图形
- 当前画面的复建重点是：先插入一个独立的新发射器容器，并把生命周期拉长，为后续把它改造成两道从天而降、形成 X 形的主闪电层做准备
这张图从 Niagara 切到了闪电材质本身，开始核对后续要给新闪电发射器使用的材质资源。当前打开的是 `M_FX_Lightning_Strike`，右侧参数面板能确认它继承自 `M_FX_SimpleParticle`，核心贴图槽 `Tex_Base` 绑定的是 `T_LightningsImpact_03`。同时在 `Material Property Overrides` 中能看到混合模式被设为 `Translucent`、着色模型为 `Unlit`，并启用了 `Two Sided`。这说明教程在真正搭“从天而降的闪电”发射器前，先回头确认闪电条纹材质是否具备正确的透明粒子基础。

节点定义集：

- 材质/材质实例：`M_FX_Lightning_Strike`
- 父材质：`M_FX_SimpleParticle`
- 纹理参数：`Tex_Base`
- 全局标量参数：`FadeDistance`
- 全局向量参数：`EmissiveChannelSelect`
- 全局向量参数：`AlphaChannelSelect`
- 全局向量参数：`EmissiveAndOpacity`
- 全局向量参数：`Refine`

连线集：

- 本图为材质参数检查界面，不涉及节点连线

设置/参数：

- `Tex_Base = T_LightningsImpact_03`
- `FadeDistance = 100.0`
- `Switch(RGB,Single) = 0.0`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided = Enabled`
- `Opacity Mask Clip Value = 0.3333`
- 父材质：`M_FX_SimpleParticle`

输出/预览：

- 左侧预览中当前只看到非常细小的亮点/条纹，说明闪电贴图本身是细碎高亮的粒子条纹资源
- 当前画面的复建重点是：确认后续闪电发射器会使用一套以 `T_LightningsImpact_03` 为核心、基于 `M_FX_SimpleParticle` 的半透明无光照材质，为后面的 X 形落雷层提供正确的纹理和混合基础

### 00:10:10-00:13:09 Alpha、UV、Power

- 本段定位：Alpha、UV、Power。
- 知识点：OK我也不想要它本来的颜色 在ns中自己给它调一个 改成1 我可以先带大家看一下这张图 move过来它是带有alpha通道的 OK它就是一张闪电序列针。
- 知识点：但是它一张图里存储了两张闪电序列针 这样可以有效地利用这张贴图的空间 是一个4096×4096的 这边是一个闪电 这边也是一个闪电 然后我们这边还有一张图。
- 知识点：move过来 这张图也是两个闪电 上面1到第16帧是一张闪电 17到32帧又是一个闪电 也就是说我们现在总共有四张不同的闪电序列针 但是是存储在两个贴图里。
- 知识点：OK我们给它通道选择一下 我们就还是默认选择G通道 这个为什么选择G通道 我之后会跟大家说 它跟UE的采样分配有关系 G通道会比RB两个通道多分配到一点采样。
- 知识点：OK我们都是alpha也选择它的G通道 也就是它的绿通道 imisio也选择它的G通道 往后我们调整一下它的refund 给它适当的power一下。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`贴图`、`序列`、`颜色`、`闪电`。

**关键画面：**

这张图开始正式把闪电发射器要用的材质贴图切到闪电序列资源本体。当前打开的仍是 `M_FX_Lightning_Strike`，但 `Tex_Base` 已切换为 `T_Lightnings_001`，同时全局标量参数 `Switch(RGB,Single,1)` 被设成 `1.0`。左侧预览里能看到多条细长的竖向闪电纹理，说明当前材质已经不再是冲击类条纹，而是进入真正的闪电序列帧资源检查阶段。

节点定义集：

- 材质/材质实例：`M_FX_Lightning_Strike`
- 父材质：`M_FX_SimpleParticle`
- 标量参数：`FadeDistance`
- 标量参数：`Switch(RGB,Single,1)`
- 纹理参数：`Tex_Base`
- 向量参数：`EmissiveChannelSelect`
- 向量参数：`AlphaChannelSelect`
- 向量参数：`EmissiveAndOpacity`
- 向量参数：`Refine`

连线集：

- 本图为材质参数检查界面，不涉及节点连线

设置/参数：

- `FadeDistance = 100.0`
- `Switch(RGB,Single,1) = 1.0`
- `Tex_Base = T_Lightnings_001`
- 资源路径可见为 `/Game/VFX/Texture/Lightning/T_Lightnings_001`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided = Enabled`
- 父材质：`M_FX_SimpleParticle`

输出/预览：

- 左侧预览中已经能看到多条细碎的白色竖向闪电条纹
- 当前画面的复建重点是：把闪电材质的主纹理明确切换到 `T_Lightnings_001`，并启用对应的序列/通道切换开关，为后面继续按 G 通道采样 Alpha 与 Emissive 做准备
这张图开始把闪电序列贴图的采样通道锁定下来。右侧参数面板显示：`EmissiveChannelSelect` 与 `AlphaChannelSelect` 都被设置为纯 `G` 通道，也就是 `R=0 / G=1 / B=0 / A=0`。结合正文“默认选择 G 通道，G 通道在 UE 的采样分配上更优”“alpha 也选择它的 G 通道，emissive 也选择它的 G 通道”的说明，这一步的目标是统一发光和透明都从同一个绿色通道读取，减少后续材质行为分裂。同时，`Refine` 参数也已开始被推高，用于后续再用 `Power` 收窄闪电条纹。

节点定义集：

- 材质/材质实例：`M_FX_Lightning_Strike`
- 纹理参数：`Tex_Base`
- 向量参数：`EmissiveChannelSelect`
- 向量参数：`AlphaChannelSelect`
- 向量参数：`EmissiveAndOpacity`
- 向量参数：`Refine`
- 标量参数：`FadeDistance`
- 标量参数：`Switch(RGB,Single,1)`

连线集：

- 本图为材质参数检查界面，不涉及节点连线

设置/参数：

- `Tex_Base = T_Lightnings_001`
- `Switch(RGB,Single,1) = 1.0`
- `EmissiveChannelSelect = (R=0.0, G=1.0, B=0.0, A=0.0)`
- `AlphaChannelSelect = (R=0.0, G=1.0, B=0.0, A=0.0)`
- `Refine = (R=2.0, G=1.0, B=1.0, A=0.0)`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- 父材质：`M_FX_SimpleParticle`

输出/预览：

- 左侧预览中的闪电条纹已经更清晰，只保留少量高亮细线
- 当前画面的复建重点是：让 `Alpha` 与 `Emissive` 同时走 `G` 通道，并预先把 `Refine` 提起来，为下一步继续调整闪电边缘的收敛和强度做基础
这张图回到 Niagara System，把刚才检查过的闪电材质真正挂到新闪电发射器上。当前系统中的新发射器已命名为 `NE_Lightning_Strike`，右侧详情面板选中的是它的 `Sprite Renderer`；可以确认 `Material` 已设置为 `M_FX_Lightning_Strike_001`。左侧同时打开了纹理查看窗口 `T_Lightnings_001`，并切到 `G` 通道显示，进一步验证教程前面强调的“用绿通道采样”确实和发射器当前使用的闪电材质对应。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Sub UV Animation`
- `Sprite Renderer`
- 材质：`M_FX_Lightning_Strike_001`
- 纹理：`T_Lightnings_001`

连线集：

- 本图为 Niagara Renderer 与贴图检查界面，不涉及节点连线

设置/参数：

- 当前选中发射器：`NE_Lightning_Strike`
- 发射器栈中可见模块：
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Sub UV Animation`
- `Sprite Renderer`
- `Sprite Renderer.Material = M_FX_Lightning_Strike_001`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Sort Mode = None`
- `Sub Image Size = (1.0, 1.0)`
- 左侧纹理查看窗口当前显示 `T_Lightnings_001` 的 `G` 通道

输出/预览：

- 主视口里当前只看到发射器 gizmo 和贴图查看窗口，说明此时重点是核对渲染资源绑定，而不是看最终闪电效果
- 当前画面的复建重点是：确认新闪电发射器 `NE_Lightning_Strike` 的 `Sprite Renderer` 已经绑定到闪电材质，并且该材质确实基于 `T_Lightnings_001` 的 `G` 通道工作，为下一段继续做透明度、序列与 UV 控制打好资源基础

### 00:13:13-00:16:04 材质、纹理与透明度控制

- 本段定位：材质、纹理与透明度控制。
- 知识点：我们就先给它0到第15针 也就是总共16针 我们看一下 我们给它一个颜色 也是一个大蓝色 还是太小了 我们把它的歪轴改大一点 400 可观察到它就可以在正常的播放了。
- 知识点：说明它没什么问题 我们这种话不太方便操控 我们给它乘一下 乘一个统一的flot值 当然了你也可以在这边 给它一个统一的scale sprite。
- 知识点：size 都是一样的 选择uniform 但是我这边还是选择在这边 我们直接给它victor2d再乘一个flot 然后我们把这边random。
- 知识点：我给它大约1 比4 这个就是1比4.5 就它的这个xy的比例 然后这边统一给400 可观察到 这边序列跟闪电就已经发射出来了 但是只发射这一针。
- 知识点：是不是有点太单调了 所以说我们怎么办呢 我们希望它有更多的随机性 并且减少重复感 在这边可以把这个 spread rendering我们再复制一个。
- 知识点：把我们刚才的另外一个 材质实例给过来 这个002 给到它这边 大家可观察到它就等于说多 给你渲染了一个 但是我们不想让它同时渲染 我们是希望它。
- 知识点：每次随机渲染 那我们怎么办呢 我们来这个 vizibility 我们把第二个 spread rendering的vizibility改成1。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Spawn`、`Particle Spawn`、`Scale Sprite Size`、`材质`、`纹理`、`粒子`、`序列`。

**关键画面：**

这张图回到 `NE_Lightning_Strike` 的 `Initialize Particle`，先把闪电序列帧发射器的基础寿命和初始尺寸压到一个可控范围。右侧详情面板显示：`Lifetime Mode = Direct Set`，当前值约为 `0.5`；`Sprite Size Mode = Non-Uniform`，`Sprite Size = (100.0, 100.0)`。结合正文里“先给它 0 到第15帧，总共16帧”“给它一个颜色，也是一个大蓝色，还是太小了”的说明，这一步是在先让闪电粒子足够短促且可见，便于后续继续调序列范围、比例和统一缩放。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Sub UV Animation`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Initialize Particle`
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.5`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Sprite Size Mode = Non-Uniform`
- `Sprite Size = (100.0, 100.0)`
- 当前 `Sprite Rotation Mode = Unset`
- 当前 `Sprite UV Mode = Unset`

输出/预览：

- 左侧主视口里当前仍只显示发射器 gizmo，没有明显闪电条纹
- 当前画面的复建重点是：先把闪电发射器的基础存活时间和可见尺寸定下来，给后面的序列帧播放和比例拉伸留出一个稳定起点
这张图继续在 `NE_Lightning_Strike` 的 `Initialize Particle` 里把闪电条纹拉成真正的长条形，并且给统一缩放乘子。右侧详情面板显示：`Color Mode` 已改成 `Direct Set`，颜色被设成一组高亮蓝白值；`Sprite Size` 切换成 `Multiply Vector 2D by Float`，其中 `Float = 400.0`，底层 `Vector2D` 则使用 `Random Range Vector 2D`，把宽高比例限制在一个窄而高的范围内。结合正文“给它一个大蓝色”“向量2D再乘一个float”“大约 1 比 4.5，统一给 400”的描述，这一步的作用是让闪电精灵既有统一的总体长度，又在细微长宽比上保持随机差异。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Initialize Particle`
- `Sub UV Animation`
- `Sprite Renderer`

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Initialize Particle`
- `Lifetime = 0.5`
- `Color Mode = Direct Set`
- 颜色当前可见约为 `R 3.312941 / G 5.313077 / B 10.0 / A 1.0`
- `Sprite Size Mode = Non-Uniform`
- `Sprite Size = Multiply Vector 2D by Float`
- `Float = 400.0`
- `Vector2D = Random Range Vector 2D`
- `Minimum = (1.0, 4.0)`
- `Maximum = (1.0, 4.5)`

输出/预览：

- 左侧主视口中间已经能看到一条细长的竖向闪电精灵预览
- 当前画面的复建重点是：把闪电精灵的横纵比例约束成“细宽、长高”的形态，并通过统一的 `400` 倍放大把序列帧拉到足够可见的尺寸，同时保留少量随机比例变化以减少重复感
这张图开始为 `NE_Lightning_Strike` 增加序列随机性，方法不是改贴图本体，而是直接复制第二个 `Sprite Renderer`。发射器栈左侧已经能看到两个 `Sprite Renderer` 条目；中间参数面板选中了 `Particles.VisibilityTag`，说明教程准备用粒子属性来决定哪一个 Renderer 生效。右侧当前显示的是其中一个 `Sprite Renderer` 的详情：材质仍为 `M_FX_Lightning_Strike_001`，但 `Sub Image Size` 已明确设为 `8 x 4`，这对应正文里对多张闪电序列帧的组织方式。结合正文“复制一个 Sprite Rendering”“把另外一个材质实例 002 给到它”“不想让它同时渲染，希望每次随机渲染”的说明，这一步的核心是先把双 Renderer 和可见性标签结构搭好，再用不同材质实例减少重复感。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Sub UV Animation`
- `Sprite Renderer` x2
- 粒子属性：`Particles.VisibilityTag`
- 材质：`M_FX_Lightning_Strike_001`

连线集：

- 本图为 Niagara Renderer 与粒子属性配置界面，不涉及节点连线

设置/参数：

- 发射器栈中已可见两个 `Sprite Renderer`
- 当前高亮粒子属性：`Particles.VisibilityTag`
- 当前 `Sprite Renderer.Material = M_FX_Lightning_Strike_001`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Sort Mode = None`
- `Sub UV Blending Enabled = False`
- `Sub Image Size = (8.0, 4.0)`
- `Renderer Visibility = 0`

输出/预览：

- 左侧主视口当前看不到稳定闪电结果，说明此时主要在搭 Renderer 随机化结构而非看最终表现
- 当前画面的复建重点是：复制第二个 `Sprite Renderer`，并引入 `VisibilityTag` 作为随机显隐的控制入口，让不同闪电材质实例可以交替渲染，从而减少单一序列帧带来的重复感

### 00:16:07-00:19:09 Update、Particle Update、Color

- 本段定位：Update、Particle Update、Color。
- 知识点：每一次它是一个整形的random 所以说它不是0 就是1 当然每一次是不一样的 每一次我们发射都是不一样的 我们再回到场景中看一下 可观察到它是不是每一次。
- 知识点：发射的就是不同的闪电了 还记不记得我们这两张闪电序列帧 其实存储着4根闪电 对不对 不好意思 打开它 我们这两张闪电序列帧 其实是存储了4根闪电。
- 知识点：一张图是两根 那么我们怎么让它在播放 这个UV序列帧的时候 也做到一个随机 我随机在这张图上 选择一组闪电去播放 我们就先不用这边的 subuva。
- 知识点：animation这个节点了 我们给它手动写一下 在这边手动搜索 subindex 然后把它放到particle。
- 知识点：update里面来 它现在是没有任何变化 因为它永远是D0帧 在这边给它add一下 A和B相加 我们这边去选择 我们先做B 我们给B一个曲线。
- 知识点：也就是我们做一个序列帧动画的播放 它是什么 它应该是0到 我们每一个都是16帧 那就是说0到15 我们自动减移 可观察到 我们做到这里 就跟我们刚才subuva。
- 知识点：animation没什么区别 我们重点其实是在上面 在这边给它random 然后是这个 在数组中选择去random 这边有两个index。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Particle Update`、`Color`、`Scale Color`、`SubUV`、`Add`、`序列`、`曲线`。

**关键画面：**

这张图先完成双 `Sprite Renderer` 的随机显隐逻辑，而不是直接写序列帧播放。当前发射器仍是 `NE_Lightning_Strike`，在 `Particle Spawn` 阶段新增了 `Set (PARTICLES) VisibilityTag` 模块；右侧详情面板显示该值使用 `Random Range Int`，并把范围限定为 `0` 到 `1`。结合上一段“复制第二个 Sprite Rendering”“希望每次随机渲染”的上下文，这一步的作用是给每个闪电粒子随机分配一个可见性标签，让两个 Renderer 不是同时显示，而是按标签轮流出图。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Set (PARTICLES) VisibilityTag`
- `Sprite Renderer` x2
- `Sub UV Animation`

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前新增模块：`Set (PARTICLES) VisibilityTag`
- `VisibilityTag = Random Range Int`
- `Minimum = 0`
- `Maximum = 1`
- 发射器栈中可见该模块位于 `Particle Spawn` 阶段

输出/预览：

- 左侧主视口当前仍主要显示发射器 gizmo，没有稳定闪电结果
- 当前画面的复建重点是：先给粒子打上 `0/1` 两种随机标签，作为两个 `Sprite Renderer` 随机切换材质实例和出图内容的基础条件
这张图开始手写闪电序列帧播放，不再依赖现成的 `Sub UV Animation` 行为。发射器 `NE_Lightning_Strike` 的 `Particle Update` 中新增了 `Set (PARTICLES) SubImageIndex`，右侧详情面板显示它当前使用 `Add Float`：`A` 先固定为 `0.0`，`B` 接一条 `Float from Curve`。此时 `B` 的曲线仍然停在整段为 `0`，所以虽然结构已经搭好，但序列帧还没真正开始向后播放，仍然等价于一直锁在第 0 帧。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Set (PARTICLES) VisibilityTag`
- `Set (PARTICLES) SubImageIndex`
- `Sub UV Animation`
- `Sprite Renderer` x2

连线集：

- 本图为 Niagara 参数与曲线配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Set (PARTICLES) SubImageIndex`
- `SubImageIndex = Add Float`
- `A = 0.0`
- `B = Float from Curve`
- `B` 的曲线横轴：`Particles.NormalizedAge`
- 当前可见 `B` 曲线整段保持在 `0`
- `Scale Curve = 1.0`

输出/预览：

- 左侧主视口里仍然只显示发射器 gizmo，看不到明显闪电序列变化
- 当前画面的复建重点是：先把手写序列帧播放的数学结构搭出来，用 `A+B` 形式为后续“播放帧偏移 + 随机起始组别”做拆分；此时尚未真正推进帧号
这张图把前面双 `Sprite Renderer + VisibilityTag` 的结构真正闭环起来。发射器 `NE_Lightning_Strike` 的栈中可见两个 `Sprite Renderer`，右侧当前选中的第二个 Renderer 已绑定另一份材质实例 `M_FX_Lightning_Strike_002`，并把 `Renderer Visibility` 设为 `1`。这样就与前面 `VisibilityTag` 的 `0/1` 随机值形成一一对应关系：一个 Renderer 只在标签为 `0` 时显示，另一个只在标签为 `1` 时显示，从而让两份不同的闪电序列随机交替出现，而不是每次都固定用同一组条纹。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Set (PARTICLES) VisibilityTag`
- `Set (PARTICLES) SubImageIndex`
- `Sprite Renderer` x2
- 材质：`M_FX_Lightning_Strike_002`

连线集：

- 本图为 Niagara Renderer 配置界面，不涉及节点连线

设置/参数：

- 当前选中的是第二个 `Sprite Renderer`
- `Material = M_FX_Lightning_Strike_002`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Sort Mode = None`
- `Renderer Visibility = 1`
- 发射器栈中上一个 `Sprite Renderer` 仍保留，用于与当前 Renderer 形成 `0/1` 切换

输出/预览：

- 左侧主视口当前仍没有稳定闪电可视结果，说明这一步仍在做渲染选择逻辑而不是最终外观展示
- 当前画面的复建重点是：让第二个 `Sprite Renderer` 绑定到另一份闪电材质实例，并把可见性值固定为 `1`，从而与 `VisibilityTag` 的整型随机值配套实现“每次发射随机渲染不同闪电”的效果

### 00:19:13-00:22:35 Alpha、Power、材质

- 本段定位：Alpha、Power、材质。
- 知识点：跟之前的思路一样 我们也是希望它刚出现的时候爆亮 然后立刻的衰减下来 就跟我们天空中划过的闪电一样 它是一瞬间非常的闪亮 好 我们给它亮度K一个曲线。
- 知识点：这边是0 尽量让它不要出现0的情况 给它1 因为它是一个translucent的材质 我们大约给它一个15 然后让它迅速的衰减下去 再适当快一点。
- 知识点：好 我们给它这边的alpha适当调低一点 OK 然后我们现在需要什么呢 我们现在需要给它做一个X的形状 目标是它是一个这样 这样交叉的一个形状。
- 知识点：这样看起来会更炫酷一点 那么我们来到这边 这个Sprite Rotation Mode 我们给它进行一个 直接设置角度 好 同样的 我们也是直接选择。
- 知识点：在它这个数组中进行随机 因为目标是它是一个固定的 而不是一个在这边随便旋转 乱转的一个闪电 我们给它加几个参数。
- 知识点：都验证效果 27 可能没有随到 我们就是-27 或者是25 这边是26 大约是旋转20度左右 可观察到 现在就是我们一个形状的感觉了 我们这边再给它多发射一个。
- 知识点：发射两个 或者我们保证它至少两个 我们给它这边发射的数量也可以Random 但是这个要特别小心 它每一次很有可能会崩 赶紧保存资源 每一次我在这边随机。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Translucent`、`材质`、`曲线`、`闪电`。

**关键画面：**

这张图开始在 `NE_Lightning_Strike` 的 `Particle Update` 中补亮度与透明度控制，但当前还只是先把 `Scale Color` 模块插入并保持默认占位值。右侧详情面板显示：`Scale Mode = RGB and Alpha Separately`，`Scale RGB = Vector from Float`，当前 `Value = 1.0`；`Scale Alpha` 也保持 `1.0`。结合正文里“希望它刚出现的时候爆亮，然后立刻衰减下来”的目标，可以确认这一步还没进入曲线细调，只是先把后续要承载亮度/Alpha 曲线的模块结构搭上。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Set (PARTICLES) VisibilityTag`
- `Scale Color`
- `Scale Sprite Size`
- `Set (PARTICLES) SubImageIndex`
- `Sprite Renderer` x2

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前新增/选中模块：`Scale Color`
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Vector from Float`
- `Scale RGB.Value = 1.0`
- `Scale Alpha = 1.0`
- 发射器栈中该模块位于 `Particle Update` 阶段

输出/预览：

- 左侧主视口里当前仍主要显示发射器 gizmo，看不到明显闪电脉冲
- 当前画面的复建重点是：先把闪电发射器的亮度与透明度缩放模块挂到 `Particle Update`，为后面继续用曲线做“瞬间爆亮后迅速衰减”的节奏控制打基础
这张图开始做“X 形下劈闪电”的关键姿态控制。当前仍在 `NE_Lightning_Strike` 的 `Initialize Particle` 中，但 `Sprite Rotation Mode` 已改成 `Direct Angle (Degrees)`；下面的 `Sprite Rotation Angle` 使用 `Select Float from Array`，并把 `Array Sampling Mode` 设为 `Random`。这说明教程不是让闪电自由随机旋转，而是只允许它从一组预设角度中抽选，从而稳定形成斜向交叉的落雷形态。与此同时，本图还能看到前面建立的高亮蓝色颜色值、非均匀尺寸放大和长条比例仍然保留。

节点定义集：

- 发射器：`NE_Lightning_Strike`
- `Initialize Particle`
- `Set (PARTICLES) VisibilityTag`
- `Set (PARTICLES) SubImageIndex`
- `Scale Color`
- `Scale Sprite Size`
- `Sprite Renderer` x2

连线集：

- 本图为 Niagara 参数配置界面，不涉及节点连线

设置/参数：

- 当前选中模块：`Initialize Particle`
- `Lifetime = 0.5`
- `Color Mode = Direct Set`
- 当前可见颜色约为 `R 3.312941 / G 5.313075 / B 10.0 / A 0.8`
- `Sprite Size = Multiply Vector 2D by Float`
- `Float = 400.0`
- `Vector2D = Random Range Vector 2D`
- `Minimum = (1.0, 4.0)`
- `Maximum = (1.0, 4.5)`
- `Sprite Rotation Mode = Direct Angle (Degrees)`
- `Sprite Rotation Angle = Select Float from Array`
- `Array Sampling Mode = Random`
- 当前可见数组元素至少包含 `0.0` 与 `1.0` 两项，后续仍会继续改成更明确的斜向角度

输出/预览：

- 左侧主视口中间已能看到一条细长的竖向闪电精灵
- 当前画面的复建重点是：把闪电旋转从“自由旋转”改为“固定角度集合随机”，为下一步把角度收敛到大约正负二十多度、形成 X 形交叉落雷打基础
这张图回到闪电材质实例本身，重点不是发射器数量，而是核对序列纹理排布与当前采样参数。左侧打开的是 `T_Lightnings_001` 纹理查看窗口，可以直接看到一张 `8 x 4` 的闪电序列图集，其中不同格子里排布着多根闪电帧。右侧则是当前闪电材质实例的参数面板：`Tex_Base` 仍为 `T_Lightnings_001`，`EmissiveChannelSelect` 与 `AlphaChannelSelect` 依旧锁定在 `G` 通道，`Refine` 当前为 `(R=2.0, G=1.0, B=1.0, A=0.5)`。这一步的作用是把前面 Niagara 里手写的 `SubImageIndex` 播放逻辑，与贴图图集本身的帧排布再做一次人工核对，确保序列索引和实际纹理布局一致。

节点定义集：

- 纹理：`T_Lightnings_001`
- 材质/材质实例：`M_FX_Lightning_Strike`
- 纹理参数：`Tex_Base`
- 向量参数：`EmissiveChannelSelect`
- 向量参数：`AlphaChannelSelect`
- 向量参数：`Refine`
- 父材质：`M_FX_SimpleParticle`

连线集：

- 本图为纹理图集与材质参数核对界面，不涉及节点连线

设置/参数：

- 左侧可见 `T_Lightnings_001` 图集为多帧闪电序列排布
- `Tex_Base = T_Lightnings_001`
- `EmissiveChannelSelect = (R=0.0, G=1.0, B=0.0, A=0.0)`
- `AlphaChannelSelect = (R=0.0, G=1.0, B=0.0, A=0.0)`
- `Refine = (R=2.0, G=1.0, B=1.0, A=0.5)`
- `FadeDistance = 100.0`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- 父材质：`M_FX_SimpleParticle`

输出/预览：

- 左侧图集清楚显示出多根闪电被打包在同一张纹理中
- 右侧预览里则只显示少量很细的闪电条纹，说明当前材质实例已经按通道选择和 refine 收敛出细长高亮结果
- 当前画面的复建重点是：确认手写序列帧播放将要索引的真实图集布局，以及当前材质采样仍然围绕 `G` 通道和 `Refine` 参数工作，为后续继续做 UV/序列随机打底

### 00:22:39-00:25:36 UV

- 本段定位：UV。
- 知识点：把这个曲线再调一调 让它迅速的衰减下来 就那一帧是最闪亮的最亮的 来1到2 不要发射太多 OK 我们整体看一下 感觉还是再多发射一个 大家有没有发现一个问题。
- 知识点：现在这个闪电 一旦我们把视角往上拉的时候 它也是始终跟着在旋转 就是Facing和Alignment 它还是有问题 在这边给它加一个。
- 知识点：Sprite Facing and Alignment 我们这边都是让它始终朝向着我们 因为它是一个面片 它如果不朝向我们就穿帮了 但是在这边这个Alignment。
- 知识点：可以给它锁一下轴 给它锁定在 Z轴 现在它就不会的朝向我们了 但是它还是会跟着我们旋转 这样看起来就不用那么穿帮了 OK 我们给它颜色再适当调一调。
- 知识点：这个颜色太紫了 可以让它往下一点 OK 没什么问题 那么我们这边主要讲的它各种随机 就是增加它的随机感 而不是让它太过于重复 在这边这个Sprite。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`颜色`、`曲线`、`闪电`。

**关键画面：**

这一帧在 `NS_Lightning_HammerHit` 的 `NE_Lightning_Strike` 发射器内调整 `Particle Update > Scale Color`，目标是让闪电亮度在生命周期前段迅速抬高，再快速回落并拖出较弱尾光。

- `Scale Mode`：`RGB and Alpha Separately`
- `Scale RGB`：
  - 输入类型：`Vector from Float`
  - `Value` 来源：`Float from Curve`
  - `Curve for Floats` 的 `CurveIndex` 绑定为 `Particles.NormalizedAge`
  - 曲线形态：起点接近 0；在前段迅速升到约 14-15 的峰值；随后立刻降到约 3-4；后半段继续缓慢衰减到接近 0
  - `Scale Curve`：`1.0`
- `Scale Alpha`：勾选，数值保持 `1.0`

预览窗口可见两条细长闪电弧在黑色场景中闪烁，说明这里主要通过 RGB 强度曲线塑造“瞬间爆亮、随后衰减”的电击观感，而不是改动透明度。
这一帧切回 `Initialize Particle`，重点是在 `Point Attributes` 中把闪电精灵的基础颜色直接设成高亮蓝白色，用来配合上一张的 `Scale Color` 曲线得到更强的电流发光。

- 模块位置：`Particle Spawn > Initialize Particle`
- `Lifetime Mode`：`Direct Set`
- `Lifetime`：`0.5`
- `Color Mode`：`Direct Set`
- `Color`：
  - 打开颜色选择器后可见这是偏蓝紫的高亮白色
  - `R = 2.516575`
  - `G = 2.875655`
  - `B = 10.0`
  - `A = 0.8`
  - `Hex Linear`：`FFFFFFCC`
  - `Hex sRGB`：`FFFFFFCC`
- `Position Mode`：`Simulation Position`
- `Position Offset`：图中可见 X 分量为 `0.0`，其余分量未清晰展示

左侧预览中的闪电几乎融入黑暗背景，只在局部留下蓝白色发光边缘，说明这里的基础色已经被推到明显超白的亮度范围，后续由材质和曲线共同塑形。
这一帧继续展示 `Particle Spawn > Initialize Particle` 的最终可见参数，用来把闪电条带的颜色、落点高度、长宽比例和斜向角度一起定下来。

- `Point Attributes`
  - `Lifetime Mode`：`Direct Set`
  - `Lifetime`：`0.5`
  - `Color Mode`：`Direct Set`
  - `Color`：`R 2.52545`，`G 3.518632`，`B 8.0`，`A 0.8`
  - `Position Mode`：`Simulation Position`
  - `Position Offset`：可见分量为 `X = 0.0`、`Z = 125.0`；中间分量被 UI 遮挡，图中无法可靠确认
  - `Position Offset Coordinate Space`：`Simulation`
- `Sprite Attributes`
  - `Sprite Size Mode`：`Non-Uniform`
  - `Sprite Size`：`Multiply Vector 2D by Float`
  - `Float`：`40.0`
  - `Vector2D`：`Random Range Vector 2D`
  - `Minimum`：`(1.0, 4.0)`
  - `Maximum`：`(1.0, 4.5)`
  - 含义：X 宽度固定为 1，Y 长度在 4.0 到 4.5 间轻微随机，随后整体再乘 40，得到细长闪电片
  - `Sprite Rotation Mode`：`Direct Angle (Degrees)`
  - `Sprite Rotation Angle`：`Select Float from Array`
  - `Array Sampling Mode`：`Random`
  - `Float Data` 4 个元素：`-27.0`、`-24.0`、`24.0`、`28.0`
  - 含义：每个粒子从四个固定斜角里随机选一个，形成左右交叉的闪电朝向
  - `Sprite UV Mode`：`Random X`

左侧预览已能看到地面冲击环、中心爆点和向上抬起的主闪电，说明这一组 `Initialize Particle` 参数正在直接决定单张闪电片的长度、角度和整体抬升位置。

## 补充视觉证据

### S06 00:17:50

这张补充图回到 `NS_Lightning_HammerHit` 的 `NE_Lightning_Strike` 发射器，展开的是 `Particle Update` 里的 `Set (PARTICLES) SubImageIndex`，用于控制闪电贴图在生命周期中如何切换子帧。

- 模块位置：`Particle Update > Set (PARTICLES) SubImageIndex`
- 写入属性：`Particles.SubImageIndex`
- 计算方式：`Add Float`
  - `A`：`0.0`
  - `B`：`Float from Curve`
- `Float from Curve`
  - 曲线类型：`Curve for Floats`
  - `CurveIndex`：`Particles.NormalizedAge`
  - `Scale Curve`：`1.0`
  - 曲线形态：前段基本保持在 `0`；随后随生命周期线性上升；末端到达约 `15`

可据此复建出该闪电精灵的子图采样策略：粒子出生后先停留在图集的起始帧，随后随着 `NormalizedAge` 增长逐步推进到后面的帧位，适合驱动 `T_Lightnings_001` 这类多帧闪电贴图产生连续变化，而不是始终固定采样同一帧。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


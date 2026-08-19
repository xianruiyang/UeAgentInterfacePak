# 03 Velocity Modules in Niagara

# 03 Velocity Modules in Niagara

## 关键术语

- `Module`、`Velocity`、`UV`、`Add`、`Noise`、`粒子`、`速度`、`NS_TestNiagara`、`Niagara`、`Particle`、`Material`、`Vortex Force`、`Drag`、`发射器`、`颜色`、`Niagara System`、`Emitter`、`Spawn Rate`

## 分段知识

### 00:00:04-00:04:56 Velocity、Add、速度

- 本段定位：Velocity、Add、速度。
- 知识点：邀請! 在这段影片中,需要讨论 在一个物体的速度上的模組 我们也会學習如何在物体的存在 改变價值 例如,大小,颜色等等。
- 知识点：我们来讨论物体更新的类型 我们也会學習关于物体的功能 追蹤! 首先,我有一台納格系统 需要製造一个发射器。
- 知识点：让它有25个物体 形状、位置、範圍50 所以它们都在不同的存在位置 我们来增加速度 Node叫做Add Velocity 它设置了物体的速度在物体中。
- 知识点：当我们加速时,需要有錯誤 因为物体的存在位置是別的 在这个情况下,这一个物体 是跟隨物体的速度和速度的。
- 知识点：我们點選定問題,让它自動加速 它会在物体更新中加速 在做什么? 我们设置了物体的最初速度 这一个物体应该在物体的速度上。
- 知识点：它在背景上工作,你不会做任何事情 它只要在那里 它总是更新,它檢查速度 它总是更新 物体更新时间,它更新了 Node Velocity设置了。
- 知识点：最初速度 我们可观察到,有不同的線性 從點和角度 我们开始用線性 它设置了物体的速度 物体总是在同一个速度上飛。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Velocity`、`Add`、`发射器`、`系统`、`速度`、`颜色`。

**关键画面：**

这是本页教程开头的系统初始状态图，表示 `NS_TestNiagara` 已打开，但还没有开始搭建发射器内容。

- 当前界面处于 Niagara 编辑器的 `System Overview` 视图。
- 中央系统画布为空，没有可见的 emitter 堆栈或模块块。
- 下方时间轴也没有任何 emitter 轨道条目，左下 `Add` 按钮可见，说明下一步会从空系统开始添加发射器。
- 左侧预览窗口中还看不到明确的粒子喷发结果，对应正文里“首先，我有一个 Niagara System，需要制作一个发射器”的起点状态。
这是发射器已经搭好基础模块后的系统总览图，重点是 `Particle Spawn` 阶段加入了 `Shape Location` 和 `Add Velocity`。

模块栈可见项：

- 发射器名称为 `Empty`，顶部显示当前粒子数约 `51 Particles`。
- `Emitter Update` 下可见 `Emitter State`（`Self / Infinite`）和 `Spawn Rate`。
- `Particle Spawn` 下依次可见 `Initialize Particle`、`Shape Location`（类型显示为 `Sphere`）、`Add Velocity`（标签显示 `Linear`）。
- `Particle Update` 下可见 `Solve Forces and Velocity` 与 `Particle State`。
- `Render` 下使用 `Sprite Renderer`。

`Add Velocity` 面板可见参数：

- `Velocity Mode`：`Linear`
- `Velocity`：`X=0.0, Y=0.0, Z=50.0`
- `Velocity Speed Scale`：`1.0`
- `Rotation Mode`：`Default`
- `Rotation Coordinate Space`：`Local`

输出/预览：

- 左侧预览中，白色精灵粒子从一个较小区域生成后整体向同一主方向拉出，符合“给粒子添加初始线性速度”的效果。
- 结合字幕“from point and in cone”，本图对应的是先用线性模式建立最基础的速度效果，后续再扩展到其他方向分布方式。
这张图切换到 `Initialize Particle` 模块，补充的是粒子的基础生命周期和颜色初始化设置。

可见设置：

- 当前展开模块：`Initialize Particle`
- `Lifetime Mode`：`Random`
- `Lifetime Min`：`1.0`
- `Lifetime Max`：`3.0`
- `Color Mode`：`Random Range`
- `Color Minimum`：显示为偏青绿的颜色
- 颜色选择器当前打开，所选新颜色可见为：
  - `R=0.0`
  - `G=1.0`
  - `B=0.48216`
  - `A=1.0`
  - `Hex Linear = 00FF7BFF`
  - `Hex sRGB = 00FFB8FF`

模块上下文：

- 中央发射器栈仍然保持上一张的基础结构：`Shape Location` 为 `Sphere`，`Add Velocity` 为 `Linear`，说明这一步是在已有发射与速度设置之上，再补粒子的初始属性。

输出/预览：

- 左侧预览中可见少量点状精灵粒子已从地面附近向外飞散。
- 这张图的重点不是速度方向本身，而是说明本段除了 `Add Velocity` 之外，也会在 `Initialize Particle` 中同步设置寿命范围和颜色随机范围，为后续观察粒子运动提供可见性。

### 00:04:56-00:09:20 速度

- 本段定位：速度。
- 知识点：我们增加它的亮度 接下来是從點开始 從點开始,在这个情况下 它是一个點,它是一个发射器 模拟位置 这就是我们模拟的开始 它开始时会有一个點。
- 知识点：慢慢地在这點下,在每个方向下加速 如果我加一个點发射器,像是下一个點 中间的點在这里 它慢慢地增加了方向 從这个點开始,可以改变它们的速度。
- 知识点：需要畫它是怎樣的 我们想像中间 物体與中间相關的雜質 在这个方向下 如果我用这个方向 需要把中间轉向100个位置 我们把中间轉向了 方向在这方向上。
- 知识点：但物体的方向高了 物体的方向向上了 例如,如果我提高它们 它们都会向下轉 如果中间,它们都会飛走 接下来的物体在角落 在角落 雖然你不能看到它们的样子。
- 知识点：但需要增加物体的数量 现在你看到物体的方向 可以改变角度 如果,例如,-1 它们会向另一邊移动 如果我们想要角落向上移动 需要设置1和Z。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`发射器`、`速度`。

**关键画面：**

这张图展示 `Add Velocity` 从基础线性速度切换到“从一个点向外发散”的设置。

模块上下文：

- 发射器仍为 `Empty`。
- `Particle Spawn` 下可见 `Initialize Particle`、`Shape Location`（`Sphere`）、`Add Velocity`。
- `Add Velocity` 标签已从上一段的 `Linear` 变为 `From Point`。

`Add Velocity` 可见参数：

- `Velocity Mode`：`From Point`
- `Velocity Speed`：`25.0`
- `Constrain to Radius`：当前未启用，数值显示 `0.0`
- `Velocity Origin`：`SimulationPosition`
- `Origin Offset`：`X=0.0, Y=0.0, Z=0.0`
- `Origin Offset Coordinate Space`：`Local`

输出/预览：

- 左侧预览里，粒子围绕中心形成一圈向外散开的点状分布，不再是单一主方向的线性拉伸。
- 这对应正文“从点开始，在每个方向下加速”的说明：粒子速度由中心点向外径向发散，而不是统一朝一个方向飞行。
这张图继续使用 `Add Velocity = From Point`，但把发散中心沿第三个偏移分量抬高，因此粒子生成与发散的中心位置整体上移。

`Add Velocity` 可见参数变化：

- `Velocity Mode`：仍为 `From Point`
- `Velocity Speed`：`200.0`
- `Velocity Origin`：仍为 `SimulationPosition`
- `Origin Offset`：`X=0.0, Y=0.0, Z=100.0`
- `Origin Offset Coordinate Space`：`Local`

输出/预览：

- 字幕直接说明“生成的粒子更高”，与参数中的 `Origin Offset` 第三个分量增大一致。
- 左侧预览中，粒子团相对上一张出现在更高的位置，说明发散参考点已经离开发射器原始中心，被抬到上方后再向外散开。
- 这一张的重点是：在 `From Point` 模式下，不只可以控制发散速度，也可以通过修改原点偏移来移动粒子径向发散的参考中心。
这张图把 `Add Velocity` 切换到了锥形分布模式，用同一发射器生成一个向上张开的喷泉状速度场。

`Add Velocity` 可见参数：

- `Velocity Mode`：`In Cone`
- `Velocity Speed`：`200.0`
- `Distribution Along Cone Axis`：`0.5`
- `Speed Falloff From Cone Axis`：界面可见数值 `0.7`
- `Cone Axis`：`X=0.0, Y=0.0, Z=1.0`
- `Cone Angle`：`25.0`
- `Inner Cone Angle`：`0.0`
- `Cone Angle Mode`：`Degrees`
- `Rotation Mode`：`Default`
- `Rotation Coordinate Space`：`Local`

输出/预览：

- 左侧预览已经不再是从一点向四周散开，而是形成一个从底部发出、向上扩张的明亮锥形粒子束。
- `Cone Axis = (0,0,1)` 配合 `Cone Angle = 25` 的可见结果，就是把速度限制在一个朝向第三分量正向的锥体内，而不是全向发散。
- 这一张对应本段后半部分“改变角度”和“让它朝上移动”的演示：通过锥轴和锥角定义粒子整体喷发方向与张开范围。

### 00:09:20-00:12:50 速度

- 本段定位：速度。
- 知识点：这樣它会更加显示 你还可以把它这樣剪輯 可以控制速度 这里的方向是剪輯的 可以轉動 我提速度越来越高。
- 知识点：它们会飛走 如果我把形状解決 就不会發生任何事 很大量的物体会飛走 接下来需要說的是 最初的速度。
- 知识点：需要用不同的模具 可以用 我们也会用形状的位置 例如,需要要增加速度 第一个模具 会让大家有50%的速度。
- 知识点：需要它们会往左邊飛 除了第一个模具 增加了向右的動作 第二个模具 会把速度调整到左邊 让它们往左邊飛 它们会飛上去 可以用相反的方式 让它们往左邊飛。
- 知识点：例如,把它移到左邊 所以可以加上 相同的模具 同樣的方式可以用形状 例如 可以用一个形状 它们会在一顆星球中 再用另一个形状 它们会在一顆星球中。
- 核对对象：`速度`。

**关键画面：**

这张图继续使用 `Add Velocity = In Cone`，但通过增大内锥角，把上一段较实心的喷泉束改成了更空心、更外扩的锥形分布。

`Add Velocity` 可见参数：

- `Velocity Mode`：`In Cone`
- `Velocity Speed`：`200.0`
- `Distribution Along Cone Axis`：`0.5`
- `Speed Falloff From Cone Axis`：`0.7`
- `Cone Axis`：`X=0.0, Y=0.0, Z=1.0`
- `Cone Angle`：`25.0`
- `Inner Cone Angle`：`100.0`
- `Cone Angle Mode`：`Degrees`
- `Rotation Mode`：`Default`
- `Rotation Coordinate Space`：`Local`

输出/预览：

- 左侧预览中的粒子已经不是一束实心向上的喷流，而是形成一个中间更空、外围更明显的扩张锥形体。
- 结合本段“这样它会更加显示”“可以控制速度、方向”的语境，这张图强调的是：在同一锥轴方向下，只改角度相关参数，就能明显改变粒子覆盖范围和锥体内部的填充感。
这张图开始演示在同一个发射器里叠加多个速度模块。

模块结构变化：

- `Particle Spawn` 下现在连续出现两个速度模块：
  - `Add Velocity`：标签仍显示 `Linear`
  - `Add Velocity 001`：标签显示 `From Point`
- 当前右侧展开的是第二个模块 `Add Velocity 001`。

`Add Velocity 001` 可见参数：

- `Velocity Mode`：`From Point`
- `Velocity Speed`：`0.0`
- `Constrain to Radius`：`0.0`
- `Velocity Origin`：`SimulationPosition`
- `Origin Offset`：`X=0.0, Y=0.0, Z=0.0`
- `Origin Offset Coordinate Space`：`Local`

输出/预览：

- 左侧预览里的粒子仍然主要聚集在局部区域，没有出现强烈的二次偏转或新的发散趋势。
- 结合参数可判断，这一帧更像是在“先复制/新增第二个速度模块，再准备调整它”的过渡状态：结构上已经能把多个速度影响叠加到同一批粒子上，但第二个模块此刻还没有产生明显速度贡献。
这张图展示的是当前可见速度模块的线性设置状态。

可确认内容：

- `Particle Spawn` 中当前能可靠看见的是一个 `Add Velocity`，标签为 `Linear`。
- 右侧展开参数为：
  - `Velocity Mode`：`Linear`
  - `Velocity`：`X=0.0, Y=0.0, Z=50.0`
  - `Velocity Speed Scale`：`1.0`
  - `Rotation Mode`：`Default`
  - `Rotation Coordinate Space`：`Local`
- 鼠标停在模块右侧复选开关上，提示为 `Enable or disable this item.`，说明教程此时正在操作模块启用状态。

输出/预览：

- 左侧预览里，少量粒子从局部区域向上飘散，没有出现上一张那种明显的锥体喷发。
- 仅凭当前图片，能够确认的是教程回到了线性速度模块的查看或启用状态；无法仅靠这张图可靠证明第二个速度模块此刻的具体参数或它是否仍在同时生效。

### 00:13:44-00:18:23 速度

- 本段定位：速度。
- 知识点：是重量的力量 980公斤 可以改变它 例如 可以设置100 它会适当升起 因为其他動作 有不同的力量 重量可以变成負重 更多的動作都可以做。
- 知识点：需要把它打開 并展示下一个模具 叫做风力 它也有一个 叫作引力的主要模具 引力是什么? 我们现在先明白 引力是什么? 引力是抵抗 你能看到物体上升。
- 知识点：我把重量打開了 我只留下了这个引力 如果它打開了 所有物体都会飛 它们都会飛同一个速度 引力是抵抗 假設它是氣力抵抗 如果我把它设置为0 它们也有轉向抵抗。
- 知识点：如果它们会轉動 我们也可以设置它们 它们会轉動的角度 如果價值是0 它们会做什么都不会 越是價值越是抵抗 是它们的引力 如果我们想它们会轉動。
- 知识点：可以设置抵抗 现在我们来談談风力 这里有些錯誤 需要把它们修正 风力和引力 这是风力 可以把速度。
- 核对对象：`速度`。

**关键画面：**

这张图把关注点从生成阶段的速度切到 `Particle Update` 阶段的重力控制。

模块上下文：

- `Particle Spawn` 里仍保留 `Initialize Particle`、`Shape Location`、`Add Velocity`
- `Particle Update` 下新增并展开了 `Gravity Force`
- 同一段里还能看见 `Particle State` 与 `Solve Forces and Velocity`

`Gravity Force` 可见参数：

- `Gravity`：`X=0.0, Y=0.0, Z=-100.0`

输出/预览：

- 左侧预览中，粒子整体仍然向上抛出，但轨迹已经不像纯线性速度那样一直上冲，而是开始出现更明显的下拉趋势。
- 结合正文“可以把 980 改成 100，它会适当升起”，这张图对应的是把默认更强的下拉值减小到 `-100`，让重力仍然存在，但不足以立刻把粒子压回地面。
这张图展示的是 `Particle Update` 中新增 `Wind Force` 后的设置界面，但当前系统处于编译失败状态，无法把左侧预览当成可靠结果图使用。

已确认内容：

- 发射器顶部与右侧详情面板都有红色错误标记。
- 左侧预览明确显示 `Compilation Failed!`
- `Particle Update` 下当前可见模块顺序包含：
  - `Gravity Force`
  - `Wind Force`
  - `Drag`
  - `Particle State`
  - `Solve Forces and Velocity`

`Wind Force` 面板可见参数：

- `Wind Speed`：`X=100.0, Y=0.0, Z=0.0`
- `Wind Speed Scale`：`1.0`
- `Turbulence Mode`：`Curl Noise`
- `Turbulence Scale Mode`：`Direct Set`
- `Scale`：`0.5`
- `Turbulence Frequency Mode`：`Constant`
- `Frequency`：`1.0`
- `Turbulence Offset Mode`：`Time Offset`
- `Offset By Time`：`X=0.0, Y=0.0, Z=-100.0`
- `Turbulence Flow Loop Duration`：`3.0`
- `Noise Quality / Cost`：`Baked (Medium)`

报错与不确定点：

- 右侧 `Compile Error` 文本表明 `Transient.FirstFrame` 在设值前被读取，错误源定位到 `WindForce` 资产。
- 由于当前截图就是报错状态，无法仅凭这张图可靠确认风力模块启用后的最终粒子运动效果。
这张图是 `Wind Force` 修正后的可编译状态，说明上一张的风力模块错误已经被处理掉。

已确认内容：

- 底部 `Niagara Log` 显示：`System successfully compiled.`
- `Particle Update` 下当前可见模块包含：
  - `Gravity Force`
  - `Particle State`
  - `Wind Force`
  - `Drag`
  - `Solve Forces and Velocity`

`Wind Force` 面板可见参数：

- `Wind Speed`：`X=500.0, Y=0.0, Z=0.0`
- `Wind Speed Scale`：`1.0`
- `Turbulence Mode`：`Curl Noise`
- `Turbulence Scale Mode`：`Direct Set`
- `Scale`：`1.0`
- `Turbulence Frequency Mode`：`Constant`
- `Frequency`：`1.0`
- `Turbulence Offset Mode`：`Time Offset`
- `Offset By Time`：`X=0.0, Y=0.0, Z=-100.0`
- `Turbulence Flow Loop Duration`：`0.5`
- `Noise Quality / Cost`：`Baked (Medium)`

输出/预览：

- 左侧预览里，粒子整体不再只是垂直上升，而是形成一条明显向侧方偏移的细长流线，说明风力已经开始主导粒子的横向运动。
- 结合正文“如果我设一个小值，例如 5”这一段风力讨论，这张图可作为 `Wind Force` 模块已生效的结构证据：通过增大 `Wind Speed` 第一分量，并保留卷曲噪声扰动，粒子会在原有速度和重力之外再叠加一股持续侧向推力。

### 00:18:23-00:23:03 粒子、速度

- 本段定位：粒子、速度。
- 知识点：它会向一邊動 在这个方向可以修正 例如让它们向500動 向更高的方向動 所以这是风力的做法 这是一个很特别的东西 而浮動影响了浮動力 在这个时候。
- 知识点：需要要来看看 这些物体的特徵 因为它们会很棒 加上一些种类 我们想像 我们有风力 或是速度 但它们会向同一个速度浮動。
- 知识点：看起来不太有趣 不同的物体 会跟不同的时间 不同的颜色 甚至不同的尺寸 但速度看起来一樣 可以改变它嗎 或者是抵抗 例如 我们开始看抵抗。
- 知识点：想說个有趣的东西 关于物体 我们有颜色物体 生命物体 这里可以點選 这个圖案 它会显示所有物体 發電物物体 物体物体 它就像一个意義 它长期生长的颜色。
- 知识点：位置 例如 我们加一个模式 我點選它 它会显示它在哪裏 例如 速度 我现在可以 通常不设置速度 我设置了速度。
- 知识点：当我们到圖案上 它仍然在这裏 还有风力 可以用这个方法 来解決 例如 某些模組 它们加了更多的模式 我现在在显示 它们都消失了 我们的速度消失了。
- 知识点：这是它的大小 开始位置 当我们加上模組 例如 速度和其他模組 它们会產生 模組 创建的圖案 它们会產生 速度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`速度`、`颜色`。

**关键画面：**

这张图继续调整 `Particle Update` 中的 `Wind Force`，用较小的风速值来观察粒子是否还会保持明显的统一侧向漂移。

已确认内容：

- 底部 `Niagara Log` 显示：`System successfully compiled.`
- `Particle Update` 当前可见模块包含：
  - `Gravity Force`
  - `Particle State`
  - `Wind Force`
  - `Drag`
  - `Solve Forces and Velocity`
- 右侧仍展开 `Wind Force`。

`Wind Force` 当前可见参数：

- `Wind Speed` 三个分量仍在编辑中，其中第一个分量被选中并正在输入较小数值；输入提示浮层显示 `10.0`
- `Wind Speed Scale`：`1.0`
- `Turbulence Mode`：`Curl Noise`
- `Turbulence Scale Mode`：`Direct Set`
- `Scale`：`1.0`
- `Turbulence Frequency Mode`：`Constant`
- `Frequency`：`1.0`
- `Turbulence Offset Mode`：`Time Offset`
- `Offset By Time`：`X=0.0, Y=0.0, Z=-100.0`
- `Turbulence Flow Loop Duration`：`0.5`
- `Noise Quality / Cost`：`Baked (Medium)`

输出/预览：

- 左侧预览中几乎看不到大幅侧向拖拽的长轨迹，只剩少量局部粒子。
- 结合本段“如果把风力设成较小值”的语境，这张图表达的是：当风速减弱到较小量级时，风力对整体运动方向的支配会明显下降。
这张图演示的是 Niagara 编辑器里的属性浏览方式：切到左下属性列表后，系统堆栈和粒子属性仍然可以同时查看。

界面状态：

- 中央 `System Overview` 中仍能看到完整发射器 `Empty` 的模块栈。
- 底部 `Niagara Log` 仍显示：`System successfully compiled.`
- 左下当前选项卡是 `User Parameters`，子页签为 `Active Overview`。

左下可见属性示例：

- `PARTICLES NewPosition`
- `PARTICLES NormalizedAge`
- `PARTICLES Position`
- `PARTICLES PRESOLVE PhysicsForce`
- `PARTICLES PRESOLVE Velocity`
- `PARTICLES PREVIOUS Position`
- `PARTICLES PREVIOUS Velocity`
- `PARTICLES RotationalVelocityEnabled`
- `PARTICLES SHAPE LOCATION ShapeBitangent`
- `PARTICLES SHAPE LOCATION ShapeNormal`

右侧当前展开内容：

- `Emitter Properties`
- `Emitter State`
- `Spawn Rate`
- `Initialize Particle`

输出/用途：

- 这张图的重点不是某个单独参数值，而是说明：进入属性视图后，粒子位置、速度、年龄等运行期属性仍然能从左下列表直接定位和检查。
- 这对应正文“当我们查看属性时，这里仍然存在”的说明，可作为后续检查速度、颜色或位置相关属性的入口。
这张图切换到 `Particle Update` 的 `Drag` 模块，演示如何用简单的数值运算来组合阻力参数。

模块上下文：

- 发射器仍为 `Empty`
- `Particle Spawn` 下当前可见 `Initialize Particle`、`Shape Location`、`Add Velocity`（标签为 `From Point`）
- `Particle Update` 下当前可见 `Gravity Force`、`Particle State`、`Wind Force`、`Drag`、`Solve Forces and Velocity`
- 底部 `Niagara Log` 仍显示：`System successfully compiled.`

`Drag` 面板可见设置：

- 主参数 `Drag` 的输入类型被切成 `Add Float`
- `A`：`15`
- `B`：`1.0`
- `Rotational Drag`：`1.0`

输出/用途：

- 左侧预览里只剩少量粒子，说明此时重点不在展示夸张的运动外观，而在讲解模块内参数如何通过表达式组合。
- 结合字幕“加法，我们可以将两个数字相加”，这张图的核心是：`Drag` 不一定直接填一个常数，也可以先用 `Add Float` 这类简单运算节点把多个数值合成为最终阻力值。

### 00:27:14-00:31:52 速度

- 本段定位：速度。
- 知识点：有數學会下降 有數學不会下降 这就是我们想要影响的 所有的方向 如果我们想要影响 所有的方向 可以用 轉向来做 從流行圖 從分數 從流行圖 從分數成为分數。
- 知识点：现在我们有一个分數 需要把重量調節掉 如果我现在是500 它会设置在每个方向 500的分數 X Y Z 需要做一张圖案 C 和 V C 和 V C 和 V C 和。
- 知识点：V 需要把这个調節掉 需要展示500的分數 結果是一樣的 这是一个更方便的东西 后续会需要它在未来 有时候需要覺得 这很方便去管理分數。
- 知识点：有时候我们想要 所有的分數都一樣 我们稍後会看到 一个例子 主要的事是 你能够理解 分數能够被分成 分成 分成 分成 分成 我们已经看到了 更有体驗的例子。
- 知识点：我们已经看到了 该如何? 我们继续 我们略过了 软件積值 加速 打圖線 加个橫頓暴動 橫頓暴動 这麼快变了 这從兩邊方向 设置進一度其中的分別 把它設置在这。
- 核对对象：`Particle`、`速度`。

**关键画面：**

这张图演示的是把 `Gravity Force` 从单一常量改成统一的向量范围输入方式，方便按 `X/Y/Z` 三个分量统一管理。

模块上下文：

- 当前展开模块：`Particle Update > Gravity Force`
- 同一发射器中仍可见 `Particle State`、`Wind Force`、`Drag`、`Solve Forces and Velocity`
- 底部 `Niagara Log` 显示：`System successfully compiled.`

`Gravity Force` 可见设置：

- 输入类型：`Random Range Vector`
- `Minimum`：`X=0.0, Y=0.0, Z=0.0`
- `Maximum`：`X=0.0, Y=0.0, Z=-980.0`
- `Evaluation Type`：`Spawn Only`

输出/用途：

- 这张图的重点不是当前画面里的粒子外观，而是参数组织方式。
- 结合正文“如果现在是 500，它会设置在每个方向”“更方便去管理分量”的语境，这里说明：重力或其他向量参数可以切成 `Vector` 形式，分别控制三个分量，而不是只保留单一标量输入。
这张图演示的是 `Add Velocity` 的统一缩放写法：先生成一个随机方向向量，再用一个公共标量同时缩放三个分量。

模块上下文：

- 当前展开模块：`Particle Spawn > Add Velocity`
- `Velocity Mode`：`Linear`
- 底部 `Niagara Log` 显示：`System successfully compiled.`

`Add Velocity` 可见设置：

- `Velocity` 的输入形式切成了 `Random Vector`
- `Vector Scale`：`500.0`
- `Constrain to Hemisphere`：当前未勾选
- `Velocity Speed Scale`：字段存在，但当前截图未清楚显示具体数值
- `Rotation Mode`：`Default`
- `Rotation Coordinate Space`：`Local`

左下属性浏览器当前可见：

- 处于 `Active Overview`
- 可见分类包含 `System Attributes`、`Emitter Attributes`、`Particle Attributes`
- `Particle Attributes` 列表中当前可见示例包括：
  - `PARTICLES Age`
  - `PARTICLES Color`
  - `PARTICLES DistanceTraveled`
  - `PARTICLES Lifetime`
  - `PARTICLES Mass`
  - `PARTICLES MaterialRandom`
  - `PARTICLES NewPosition`
  - `PARTICLES NormalizedAge`

输出/用途：

- 这张图的重点不是某个具体方向，而是参数构造方式：当希望三个方向统一使用同一强度时，用 `Random Vector + Vector Scale` 会比逐个填写 `X/Y/Z` 分量更易维护。
- 这与正文“结果是一样的，这是一个更方便的东西”一致。
这张图已经切换到新的 `Particle Update` 模块 `Vortex Force`，开始演示让粒子围绕一个轴心旋转并向中心收拢。

模块上下文：

- 当前展开模块：`Particle Update > Vortex Force`
- 同一堆栈下仍可见 `Particle State`、`Drag`、`Solve Forces and Velocity`
- 底部 `Niagara Log` 显示：`System successfully compiled.`

`Vortex Force` 可见设置：

- `Vortex Force Amount`：`1000.0`
- `Vortex Axis`：`X=0.0, Y=0.0, Z=1.0`
- `Vortex Axis Coordinate Space`：`Simulation`
- `Vortex Origin`：`SimulationPosition`
- `Origin Pull Amount`：`500.0`
- `Origin Pull Only On Vortex Axis`：已启用
- `Vortex Origin Offset`：`X=0.0, Y=0.0, Z=0.0`
- `Use Influence Falloff`：未启用

左下属性浏览器当前仍处于：

- `Active Overview`
- 显示 `System Attributes`、`Emitter Attributes`、`Particle Attributes`

输出/预览：

- 左侧预览中的粒子围绕中心亮点形成明显的旋涡状团块，不再只是简单直线飞散。
- 这张图说明：除了线性速度、风力和重力，还可以通过 `Vortex Force` 在更新阶段给粒子叠加绕轴旋转和向原点拉回的运动特征。

### 00:31:52-00:36:42 Module

- 本段定位：Module。
- 知识点：如果我減少它到这个價值 它会更多的發光 需要放大價值 它会很快的推向 这是你能得到的結果 它会保持中心 如果我放少了它 它会飛走 这是它会飛走的力量。
- 知识点：这跟它有關的有趣 我们減少它 如果我们減少它到25 这里也有 它是指向Z向上 如果我们想改变它 可以向X向上 在这个方向 需要減少它到100。
- 知识点：我们可观察到它会推向 这是拉動力的效果 它会推向 particle 这是拉動力的效果 需要增加拉動力 需要增加数量的 particle。
- 知识点：拉動力的效果是怎樣的 我们有位置的出现 我们需要把它提升 我们把拉動力移到中心 需要移到一旁 需要加上拉動力的模式 它会拉動我们的 particle。
- 知识点：它会拉動它们 需要将力量調到100 例如我们提升到100 现在它会更高 它会拉動这些 particle。
- 知识点：如果我提升到0 它不会拉動任何东西 它只会提升到这个 radius particle 飛起来了 它们会出现在 radius 它会开始拉動它们。
- 知识点：我稍後会展示它是 100 radius 需要把它放在X向上 它会影响拉動力的力量 我提升到100 当它开始影响力的力量 需要把它放在0.5。
- 核对对象：`Particle`。

**关键画面：**

这张图继续演示 `Vortex Force`，重点是把拉回原点的强度显著提高，让粒子更紧地束缚在中心附近。

模块上下文：

- 当前展开模块：`Particle Update > Vortex Force`
- 底部 `Niagara Log` 显示：`System successfully compiled.`
- 左下仍处于 `Active Overview`，可同时查看属性分类。

`Vortex Force` 可见设置：

- `Vortex Force Amount`：`1000.0`
- `Vortex Axis`：`X=0.0, Y=0.0, Z=1.0`
- `Vortex Axis Coordinate Space`：`Simulation`
- `Vortex Origin`：`SimulationPosition`
- `Origin Pull Amount`：`50000.0`
- `Origin Pull Only On Vortex Axis`：已启用
- `Vortex Origin Offset`：`X=0.0, Y=0.0, Z=0.0`
- `Use Influence Falloff`：未启用

输出/预览：

- 左侧预览里的粒子不再松散铺开，而是围绕中心亮点形成更紧密的高亮团块。
- 结合正文“它会保持中心”“如果放少了它，它会飞走”的描述，这张图说明：`Origin Pull Amount` 提高后，涡旋不只是绕圈，还会更强地把粒子拉回到中心附近。
这张图已经切换到新的 `Particle Update` 模块 `Point Attraction Force`，演示如何把粒子拉向一个偏移后的吸引点。

模块上下文：

- 当前展开模块：`Particle Update > Point Attraction Force`
- 同一堆栈下仍可见 `Vortex Force`、`Drag`、`Solve Forces and Velocity`

`Point Attraction Force` 可见设置：

- `Attraction Strength`：`100.0`
- `Attraction Radius`：`100.0`
- `Falloff Exponent`：`0.5`
- `Attractor Position Offset`：`X=100.0, Y=0.0, Z=100.0`
- `Attractor Position Offset Coordinate Space`：`Simulation`
- `Kill Radius`：`4.0`
- `Position To Attract`：`PARTICLES Position`
- `Attractor Position`：`SimulationPosition`

输出/预览：

- 左侧预览中，粒子团不再只围绕中心，而是被拉向右上侧的一个偏移位置；画面中的调试线框和箭头也在辅助显示吸引方向。
- 这张图说明：与 `Vortex Force` 的“绕轴旋转 + 拉回中心”不同，`Point Attraction Force` 是把粒子朝一个明确的目标点吸引，并且这个目标点可以通过偏移量移到发射器旁边。
这张图继续讲 `Point Attraction Force`，重点转到“吸引半径变大后会影响更大范围的粒子”，并展示了同类模块可以叠加。

模块结构变化：

- `Particle Update` 下现在同时出现：
  - `Point Attraction Force`
  - `Point Attraction Force 001`
- 当前右侧展开的是第一个 `Point Attraction Force`。

第一个 `Point Attraction Force` 可见参数：

- `Attraction Strength`：`50.0`
- `Attraction Radius`：`100.0`
- `Falloff Exponent`：`0.2`
- `Attractor Position Offset`：`X=100.0, Y=0.0, Z=0.0`
- `Attractor Position Offset Coordinate Space`：`Simulation`
- `Kill Radius`：`4.0`
- `Position To Attract`：`PARTICLES Position`
- `Attractor Position`：`SimulationPosition`

输出/预览：

- 字幕直接说明“如果我们增加半径”，对应当前高亮的 `Attraction Radius` 字段。
- 左侧预览中，粒子不再只集中在一个小点上，而是在更大的局部范围内被这个吸引场影响并重新分布。
- 这张图的核心是两点：
- `Attraction Radius` 决定吸引力能影响多大范围的粒子。
- 同一个发射器里可以叠加多个 `Point Attraction Force` 模块，分别控制不同的吸引中心或吸引行为。

### 00:36:42-00:41:25 速度

- 本段定位：速度。
- 知识点：獨立的引力 这里一邊影响左邊 另一邊影响右邊 它们有同樣的名字 引力,引力,只有 0.1 到最後 1 到最後,以令它更方便 點引力,可以在这里點選。
- 知识点：在这里重新取名 或者按 F2 可以改名 让它是右邊 我们把名字做到左邊 以更好理解它们的模式 例如我们有兩點引力 我们也可以选择 例如 drag。
- 知识点：和 vortex force 它们都会混合 这里有一个重要的項目 Vortex force 首先發生 然后點引力 點引力發生 如果我改变項目 我可以得到不同的結果。
- 知识点：因为項目也很重要 點引力發生後,force 發生 在这次情况下,它们不見了 但有趣的結果可以得到 它们是引力和轉向的 可以改变它们的速度。
- 知识点：加更多的速度 让它们飛得更高 有些非常大的價值 它们飛得非常快 我们把所有东西都打掉 我们现在準備 我们有形状 让我再做一个形状 它会是平的。
- 核对对象：`Vortex Force`、`Drag`、`速度`。

**关键画面：**

这张图继续在 `Particle Update` 中使用两个点吸引模块，当前展开的是第二个 `Point Attraction Force 001`，用于在另一侧建立对称吸引点。

模块结构：

- `Particle Update` 下当前可见：
  - `Vortex Force`
  - `Drag`
  - `Point Attraction Force`
  - `Point Attraction Force 001`
  - `Solve Forces and Velocity`
- 当前右侧展开模块：`Point Attraction Force 001`

`Point Attraction Force 001` 可见参数：

- `Attraction Strength`：`100.0`
- `Attraction Radius`：`110.0`
- `Falloff Exponent`：`0.2`
- `Attractor Position Offset`：`X=-100.0, Y=0.0, Z=0.0`
- `Attractor Position Offset Coordinate Space`：`Simulation`
- `Kill Radius`：`4.0`
- `Position To Attract`：`PARTICLES Position`
- `Attractor Position`：`SimulationPosition`

输出/用途：

- 左侧预览中的粒子被压低在地面附近的一条带状区域，不再只偏向单侧。
- 结合正文“这里一边影响左边，另一边影响右边”“它们有同样的名字”的描述，这张图说明：通过复制同类 `Point Attraction Force` 并把偏移改成相反方向，可以快速搭出左右两侧的独立吸引点。
这张图说明前面两个点吸引模块已经完成重命名，同时又加入了新的噪声力模块。

模块结构变化：

- `Particle Update` 下当前可见模块顺序为：
  - `Particle State`
  - `Point Attraction Force - Right`
  - `Point Attraction Force - Left`
  - `Vortex Force`
  - `Drag`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
- 这对应正文里“重新取名”“让它是右边、左边”“Vortex force 首先发生，然后点引力”的模块组织思路。

当前展开模块：`Curl Noise Force`

`Curl Noise Force` 可见参数：

- `Noise Strength`：`10.0`
- `Noise Frequency`：`50.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Part Noise Field`：`X=0.0, Y=0.0, Z=0.0`
- `Mask Curl Noise`：未启用

输出/用途：

- 左侧预览中的粒子保持一束较窄的上行流线，说明当前更多是在整理模块结构和准备下一步，而不是刻意展示强烈的新外观。
- 这张图可作为两个关键证据：
  - 同类模块可以重命名为有语义的左右名称，便于后续维护。
  - `Curl Noise Force` 可以在 `Particle Update` 阶段继续叠加到已有的点吸引、涡旋和阻力之上。
这张图把生成形状切成平面分布，并继续用 `Curl Noise Force` 让平面上的粒子朝不同方向分开运动。

模块结构变化：

- `Particle Spawn` 下当前可见：
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity`
  - `Shape Location 001`，标签为 `Box / Plane`
- `Particle Update` 下当前可见：
  - `Particle State`
  - `Point Attraction Force - Right`
  - `Point Attraction Force - Left`
  - `Vortex Force`
  - `Drag`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`

当前展开模块：`Curl Noise Force`

`Curl Noise Force` 可见参数：

- `Write to Intrinsic Parameters`：已启用
- `Noise Strength`：`150.0`
- `Noise Frequency`：`1.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`X=0.0, Y=0.0, Z=0.0`
- `Sample Position`：`PARTICLES Position`
- `Randomize Noise Sample`：已启用
- `Random Seed`：`11`
- `Randomization Vector`：`X=0.65, Y=0.125, Z=0.37`
- `Scale Curl Lookup By Engine Owner Scale`：已启用
- `Mask Curl Noise`：未启用

输出/预览：

- 左侧预览中的粒子先以一块彩色平面云的形态出现，然后被噪声扰动撕开，形成不同区域向不同方向偏移的流动。
- 这与字幕“这部分朝这个方向走，另一部分朝另一个方向走”一致，说明当前重点是通过 `Curl Noise Force` 给平面分布中的不同粒子局部施加不同流向，而不是让所有粒子保持统一速度。

### 00:41:25-00:44:08 UV、Noise、速度

- 本段定位：UV、Noise、速度。
- 知识点：它的發電会改变 需要把它按 pause 我们可观察到 聲音会显示方向 需要改变它,按1 我停止了,让它显示方向 现在显示方向 依照这个方向 我们的部分会往这方向移动。
- 知识点：聲音会影响帧率 越大音量 越有分別 它们会飛往不同的部分 而且聲音的质感是 我们把它当標準 我先把帧率调整到5 让它们更顯的方向 也会显示到。
- 知识点：我们也可以移动这个聲音 和 UV 相關的聲音 可以用这方式 移动聲音来改变大小 需要轉到X方向 也会给这方向 改变好聲音 这个聲音在移动 我可以切換速度。
- 知识点：如果它们不移动 它们也会移动在同一方向 可以变成所有大小 用这个可以增加 chaos 奇怪的效果是它们会动 如果我问 1000 它们就会很快飞走。
- 知识点：如果我把它调到100 它们就会变得很慢 这就设置了速度 频率是声音频率 如果您提高了价值 声音会有更多的详细 可以把声音调到 加变能力 Curl Noise是用来做什么的。
- 核对对象：`Noise`、`速度`。

**关键画面：**

这张图是在较慢观察状态下查看 `Curl Noise Force` 的方向效果，用大量方向线把不同粒子的局部运动趋势直接可视化出来。

模块上下文：

- 当前展开模块：`Particle Update > Curl Noise Force`
- `Particle Spawn` 下当前仍可见 `Shape Location 001`，标签为 `Box / Plane`
- `Particle Update` 下当前可见 `Point Attraction Force - Right`、`Point Attraction Force - Left`、`Vortex Force`、`Drag`、`Curl Noise Force`

`Curl Noise Force` 可见参数：

- `Write to Intrinsic Parameters`：已启用
- `Noise Strength`：`150.0`
- `Noise Frequency`：`25.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`X=0.0, Y=0.0, Z=0.0`
- `Sample Position`：`PARTICLES Position`
- `Randomize Noise Sample`：已启用
- `Random Seed`：`11`
- `Randomization Vector`：`X=0.65, Y=0.125, Z=0.37`
- `Scale Curl Lookup By Engine Owner Scale`：已启用
- `Mask Curl Noise`：未启用

输出/预览：

- 左侧预览里布满了彩色短线和拖尾，每一簇粒子的方向并不一致，说明 `Curl Noise Force` 不是给所有粒子同一个速度，而是在局部空间内提供不同方向的流场。
- 这与正文“显示方向”“依照这个方向，我们的部分会往这方向移动”一致，适合用来观察噪声流场本身的走向。
这张图继续用方向线观察 `Curl Noise Force`，但把噪声频率降到较低值，以便看清更大尺度的流场块面。

模块上下文：

- 当前展开模块：`Particle Update > Curl Noise Force`
- `Particle Spawn` 仍可见 `Shape Location 001`，标签为 `Box / Plane`
- `Particle Update` 下仍保留 `Point Attraction Force - Right`、`Point Attraction Force - Left`、`Vortex Force`、`Drag`、`Curl Noise Force`

`Curl Noise Force` 可见参数：

- `Noise Strength`：`150.0`
- `Noise Frequency`：`5.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`X=0.0, Y=0.0, Z=0.0`
- `Mask Curl Noise`：未启用

输出/预览：

- 左侧平面粒子云不再表现为细碎抖动，而是被组织成较大块的彩色流线带，每一大片区域内部方向更连续。
- 这说明当 `Noise Frequency` 变低时，噪声变化尺度变大，流场细节减少，但整体流向更容易被肉眼追踪。
- 对应正文里“让它们更显方向”“提高值会有更多细节”的对比关系，这张图正是较低频率下的方向展示。
这张图继续调整 `Curl Noise Force`，重点变成把噪声推动强度提升到很大值，让粒子在同一平面分布上更快、更混乱地散开。

`Curl Noise Force` 可见参数：

- `Noise Strength`：`1000`
- `Noise Frequency`：`25.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`X=0.5, Y=0.0, Z=1.0`
- `Mask Curl Noise`：未启用

模块上下文：

- `Particle Spawn` 当前仍使用 `Shape Location 001`，标签为 `Box / Plane`
- `Particle Update` 下仍保留 `Point Attraction Force - Right`、`Point Attraction Force - Left`、`Vortex Force`、`Drag`、`Curl Noise Force`

输出/预览：

- 左侧平面粒子云相比前两张更躁动，彩色方向线更密集、更长，局部运动的发散感也明显增强。
- 这与正文“如果问 1000，它们就会很快飞走”“如果调到 100 就会变得很慢”的说明一致：`Noise Strength` 直接影响噪声场给粒子的速度量级。
- `Pan Noise Field` 出现非零分量，说明噪声采样场本身也被偏移，因此同一平面上不同区域会获得不同的扰动方向和节奏。

### 00:44:18-00:48:02 Noise、粒子、速度

- 本段定位：Noise、粒子、速度。
- 知识点：当我们需要加适合的变化 让我删除这个形状 需要调低数字 现在它们飞向直方 需要加一些变化 让它们移动到旁边 这里和那里Curl Noise会帮助。
- 知识点：需要把声音调到 您可观察到 变化在变化中 力量在变化中的力量上 如果您调低频率 变化就会变化 在变化中 如果我提高了 变化就会变化 您可以把声音调到。
- 知识点：这样它们会保持在位置 粒子开始移动得更加恶意 开始改变动作的方向 您可以试试 Pan会改变它的位置 改变这个声音 它们会更加恶意 让我们改变它的意义。
- 知识点：这些线展示了方向 我还调整到Spin 它们会在Spin中改变方向 而Drag会让它们停留一些 它们会更加恶意 我们还可以加更多的变化 例如。
- 知识点：变化的温度 一块块会移动 50的速度 另一块会移动 500的速度 您也可以把每块的变化 都调到不同的速度。
- 核对对象：`Noise`、`Drag`、`粒子`、`速度`。

**关键画面：**

这是当前 `NS_TestNiagara2` 在场景里的结果验证图，用来观察前面噪声、阻力和速度组合后的整体运动状态。

- 当前选中的是场景中的 `NS_TestNiagara2`。
- 粒子没有再铺成大面积平面噪声云，而是收拢成一小束竖向上升的亮点流。
- 这说明当前参数组合已经明显抑制了横向大范围发散，让粒子更多保持在局部区域内缓慢上升。
- 结合本段正文“调低数字”“需要加一些变化”“Drag 会让它们停留一些”，这张图可以理解为：在加入噪声扰动的同时，又通过较强的约束把粒子重新压回成较窄的运动通道。
这是同一系统在场景中的另一张结果图，重点转到“局部方向差异”本身，而不是整体束流形状。

- 画面中粒子仍集中在发射器附近，没有大范围飞散。
- 每个粒子周围带有短小的方向线，不同粒子的朝向并不一致，说明当前噪声并没有把所有粒子推向同一个统一方向。
- 粒子群整体呈一个小范围聚集团，但团内已经能看出若干朝不同侧向分裂的小流向。
- 这与正文“这些线展示了方向”“一块块会移动，50 的速度，另一块会移动 500 的速度”的语境一致：当前更关注的是粒子局部速度块之间的差异，而不是单一总体移动方向。
这张图切回 `Particle Spawn` 阶段，强调初速度通常在粒子生成时一次性赋予，而不是在更新阶段反复叠加。

模块上下文：

- 当前展开模块：`Particle Spawn > Add Velocity`
- `Velocity Mode`：`Linear`
- `Particle Update` 下仍保留：
  - `Particle State`
  - `Point Attraction Force - Right`
  - `Point Attraction Force - Left`
  - `Vortex Force`
  - `Drag`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`

`Add Velocity` 可见设置：

- `Velocity` 输入类型：`Random Range Vector`
- `Minimum`：`X=0.0, Y=0.0, Z=25.0`
- `Maximum`：`X=0.0, Y=0.0, Z=100.0`
- `Velocity Speed Scale`：`1.0`
- `Rotation Mode`：`Default`
- `Rotation Coordinate Space`：`Local`

输出/用途：

- 左侧预览中的粒子又回到较小的局部团块，没有继续保留前两张那种大面积方向线展示，说明当前重点转回“出生瞬间给什么速度”。
- 字幕直接说明“Add velocity is usually added only in particle spawn”，所以这张图可作为流程结论：初速度更适合放在 `Particle Spawn` 中设置，并且可以用 `Random Range Vector` 给每个新生成粒子分配一个第三分量在 `25-100` 之间的随机上升速度。

## 补充视觉证据

### S09 00:43:02

这是 `S09` 段的补充参数图，专门补证 `Curl Noise Force` 的噪声平移方向设置。

模块上下文：

- 当前展开模块：`Particle Update > Curl Noise Force`
- `Particle Spawn` 下仍可见：
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity`
  - `Shape Location 001`，标签为 `Box / Plane`
- `Particle Update` 下仍可见：
  - `Particle State`
  - `Point Attraction Force - Right`
  - `Point Attraction Force - Left`
  - `Vortex Force`
  - `Drag`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`

`Curl Noise Force` 可见参数：

- `Noise Strength`：`150.0`
- `Noise Frequency`：`5.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`X=1.062425, Y=0.0, Z=0.0`
- `Mask Curl Noise`：未启用

输出/用途：

- 左侧平面粒子云已经被组织成大片连续的彩色流线块，不同块面内部方向一致，但块与块之间方向不同。
- 字幕直接说明“我会沿着 X 轴进行更改”，与 `Pan Noise Field` 只有 `X` 分量非零相互印证。
- 这张补充图说明：除了调噪声强度和频率，还可以通过平移噪声采样场本身来改变流场在平面上的分布位置和方向过渡。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


# 02 Explosion Simulation In Embergen

# 02 Explosion Simulation In Embergen

## 关键术语

- `Alpha`、`EmberGen`、`速度`、`透明度`、`在这个爆炸中，我关闭了最开始存在的额外噪波`、`Niagara`、`发射器`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`、`Opacity`、`Renderer`

## 分段知识

### 00:00:04-00:04:58 EmberGen、速度

- 本段定位：EmberGen、速度。
- 知识点：在这段影片中,我们看看在EmberGen的爆炸和烟霧模式中 如何把烟霧模式進入Unreal Engine 視乎我準備的画面在Unreal。
- 知识点：Engine中 并且制作爆炸的材料 首先,需要說我用了 在EmberGen已经制作的模式 我们的爆炸的圖案是这个爆炸的圖案 还有烟霧或烟霧的模式。
- 知识点：我还加了烟霧,它会在爆炸时爆发时爆发 烟霧会從下面爆发出来 首先,我用了这个爆炸的圖案 我用了不同的圖案 需要展示它如何在我们的位置看起来。
- 知识点：它是 需要给你所有这些圖案 它可以很慢 需要给你一张圖案,没有上限 可观察到有多少个Voxel 很多 如果你的电脑可以允許 可以增加上限。
- 知识点：上限为2 如果你仍然在工作 你不能把它设置好 它会有多少速度 我选择了標準的鏡頭 因为我设置了鏡頭为 让你拍摄的角度 如果我没有錯 这是它 我放了这个樣的显示器。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`EmberGen`、`发射器`、`速度`。

**关键画面：**

这张图是 EmberGen 的预设浏览首页，用来从现成模板中挑选爆炸或烟雾效果作为起点

- 顶部当前工程名为 `smoke_shockwave.ember`
- 左侧导航包含 `Home`、`Learn`、`Presets`、`My Projects`
- 顶部预设分类可见：
  - `All`
  - `Fire & Smoke`
  - `Fire`
  - `Smoke`
  - `Explosion`
  - `Magic`
  - `Particles`
  - `8 GB`
  - `24 GB`
- 主区域展示大量可直接使用的预设缩略图，当前可见的示例包括：
  - `73 Nebula`
  - `73 Nebula 02`
  - `73 Nebula 03`
  - `Aerial Explosion 1`
  - `Aerial Explosion 2`
  - `Aerial Explosion 3`
  - `Aerial Explosion 4`
  - `Aerial Explosion 5 Massive`
  - `Artillery Explosion 1`
  - `Artillery Explosion 2`
  - `Battle Ship Muzzle Flash`
  - `Cannon Explosion`
- 这一步传达的重点是：先在 EmberGen 的预设库里选择接近目标观感的爆炸模板，再在后续步骤中继续调速度、形状和材质表现
这张图是 EmberGen 的主编辑界面，展示如何在节点图和时间线中调整爆炸体积后处理与发射器参数，得到更合适的烟火体积和速度表现

节点定义集
- `Simulation`
- `Shading`
- `Camera`
- `Scene`
- `Render`
- `Volume Processing`，当前被选中
- 左侧时间线中可见的轨道包括：
  - `Emitter: Volume`
  - `Simulation`
  - `Volume Processing`
  - `Force: Noise`

连线集
- `Light: Ambient`、`Light: Directional` 接入 `Shading`
- `Simulation` 的 `Volume` 输出连接到 `Scene`
- `Simulation` 的 `Particles` 输出连接到 `Scene`
- `Volume Processing` 的 `Volume` 输出连接到 `Scene`
- `Volume Processing` 的 `VDB` 输出也参与后续渲染链路
- `Scene` 连接到 `Render`
- `Camera` 连接到 `Render`

设置/参数
- 左上视口里显示的是一团橙色火焰核心包裹灰色烟雾的爆炸体积
- 右上视口统计与显示设置可见：
  - `Render Quality: Low`
  - `View Mode: Lit`
  - `Projection Quality: Extreme`
- `Volume Processing > Post Process` 选项卡当前启用
- `Volume post process` 模式为 `Dilate`
- 可见的后处理参数包括：
  - `Smoke dilate = 105.000 %`
  - `Temperature dilate = 100.000 %`
  - `Flames dilate = 395.000 %`
  - `Fuel dilate = 100.000 %`
  - `Dilate softness = 0.000 %`
- 时间线左侧还能看到关键参数的动画轨道，例如：
  - `Smoke rate ≈ 531.973 /s`
  - `Additional pressure rate = 100.000 /s`
  - `Emitter activity = Enabled`
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 0.000 %`
- 结合字幕，这一步强调的是把开头额外噪声关掉，并通过体积膨胀参数控制火焰与烟雾的外扩范围

输出/预览
- 视口中的爆炸轮廓圆润，中心火焰明亮，外围烟团较厚，说明体积后处理已显著改变最终观感
- 时间线里多条带关键帧的曲线说明该爆炸不仅调静态参数，还通过时间驱动来控制速度与扩散节奏
这张图展示 EmberGen 中用于火花或高亮粒子的粒子发射器设置，重点是把粒子渲染成自发光的 Additive 叠加效果，并与体积烟雾同步注入

节点定义集
- `Emitter: Particles`，当前被选中
- 上方节点图可见与粒子相关的分支：
  - `High velocity particles`
  - `Spark like volume advected parti...`
- 这些粒子发射器与 `Simulation`、`Scene`、`Render` 链路共同组成最终效果

连线集
- 多个 `Force: Line`、`Force: Noise`、`Shape: Primitive` 节点接入 `Emitter: Volume` 或粒子分支
- 粒子分支输出参与 `Simulation` 和后续 `Scene`、`Render` 合成
- 这表明爆炸效果不是纯体积烟雾，而是叠加了独立的高亮粒子层

设置/参数
- 当前位于 `Emitter: Particles > Rendering` 选项卡
- `Render particles` 已启用
- `Particles type` 为 `Emissive`
- `Particles blend type` 为 `Additive`
- `Inject light in scattering` 当前未启用
- `Initial color type` 为 `Uniform Color`
- `Initial color` 为橙黄色
- `Emissive boost` 为 `50000.000 %`
- `Modulation type` 为 `Uniform Color Modulation`
- `Modulation color` 为白色
- `Color attenuation over life` 为 `0.000 %`
- 在下方 `Injection` 分组中可见：
  - `Inject velocities & components` 已启用
  - `Smoke = 100.000 %`

输出/预览
- 左侧视口中的爆炸此时主要呈灰白烟团，中心亮度被压低，更便于单独检查粒子层对整体效果的贡献
- 时间线仍显示 `Emitter: Volume`、`Simulation`、`Volume Processing`、`Force: Noise` 等关键轨道，说明粒子设置也是和主体爆炸一起按时间驱动的
- 这一步的关键作用是为爆炸加入会发光的叠加粒子，让高速火花和局部亮斑在最终效果中更明显

### 00:04:58-00:09:48 Niagara、Alpha、透明度

- 本段定位：Niagara、Alpha、透明度。
- 知识点：它们只会用很多氣泡 这是火 在合作时使用烟霧来爆炸 它们会一起爆炸 变化在时间內 烟霧的数量減少 然后慢慢地增加 我把发射器關掉。
- 知识点：它会用36个鏡頭爆炸 然后關掉 它也会受到壓力 從这刻起,烟霧开始快速消失 这个標誌影响烟霧的散熱 然后这段影片就結束了 为什么?因为这次的鏡頭。
- 知识点：我把它在这里冷卻 冷卻 这就是最後的画面 这里有一个刷新的 这次的画面結束了 我可观察到結果 你可能覺得它没有完全消失 为什么我们没有把它最後散熱?。
- 知识点：因为最後的鏡頭仍然会有烟霧 可以用alpha来爆炸 可以在niagara改变它的透明度。
- 知识点：这就是它 我把它适当推動一下 这个標誌是受到烟霧的影响 然后慢慢地降低 这樣它不会跟我们打爛 烟霧控制了一点 但我把它關掉了 可观察到烟霧会散熱。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`Alpha`、`发射器`、`透明度`。

**关键画面：**

这张图展示在 EmberGen 中通过 `Shape: Primitive` 节点定义一个球形体，作为烟雾或粒子系统的发射/遮罩基础区域

节点定义集
- 当前选中节点：`Shape: Primitive 2`
- 相关可见节点：
  - `Emitter: Volume`
  - `Simulation`
  - `Shape: Primitive`
  - `Emitter: Particles`
  - `Volume Processing`
- 左侧视口中显示一个带操纵器的球形范围，位于烟雾体积底部

连线集
- 当前选中的 `Shape: Primitive 2` 节点向右连接到粒子相关分支
- 上方另一组 `Shape: Primitive`、`Force: Line`、`Emitter: Volume`、`Simulation` 共同构成主体烟雾流程
- 从可见连接关系可判断，球形 primitive 被用作某个粒子发射器或遮罩输入，而不是最终渲染节点

设置/参数
- 当前位于 `Shape: Primitive > General` 选项卡
- `Shape Activity` 已启用
- `Type` 为 `Sphere`
- `Radius` 为 `14.667 m`
- `Fill motion gaps` 当前未启用
- `Transform` 分组中可见：
  - `Position X = 0.000 m`
  - `Position Y = -0.000 m`
  - `Position Z = 11.534 m`
  - `Rotation X = 0.000°`
  - `Rotation Y = 0.000°`
  - `Rotation Z = 0.000°`
- 左上视口统计显示：
  - `Render Quality: Low`
  - `View Mode: Lit`
  - `Projection Quality: Extreme`

输出/预览
- 视口中可见一团偏灰色的烟雾立柱，球形操纵器位于底部区域，说明这个 primitive 正在限定局部发射或受力范围
- 底部时间线显示该爆炸在约第 `63` 帧处进行预览，并带有多条关键帧轨道
- 这一步的作用，是通过独立的球形 shape 控制某一层烟雾或粒子在空间中的生成位置，从而为后续在 Niagara 中通过 Alpha/透明度衰减创造更可控的源形状
这张图展示 EmberGen 的体积发射器参数设置，重点是控制烟雾的发射方式、温度和附加压力，让爆炸在模拟中更快扩散，然后在后续 Niagara 阶段再用透明度收尾

节点定义集
- 当前选中节点：`Emitter: Volume`
- 相关可见节点：
  - `Simulation`
  - `Shape: Primitive`
  - `Force: Line`
  - `Volume Processing`
  - `Emitter: Particles`

连线集
- `Shape: Primitive` 和 `Force: Line` 等输入接入 `Emitter: Volume`
- `Emitter: Volume` 输出连接到 `Simulation`
- `Simulation` 再把体积结果送往 `Scene` 与 `Render`
- 说明这一节点负责把源形状和外力转成真正进入模拟的烟雾/温度/压力数据

设置/参数
- 当前位于 `Emitter: Volume` 面板，标签行可见：
  - `Activity`
  - `Transform`
  - `Emission`
  - `Pressure`
  - `Forces`
  - `Visuals`
- `Transform` 中可见：
  - `Position X = 0.000 m`
  - `Position Y = 0.000 m`
  - `Position Z = 0.000 m`
  - `Rotation X = 0.000°`
  - `Rotation Y = -0.000°`
  - `Rotation Z = 0.000°`
- `Emission` 分组当前参数包括：
  - `Fuel emission = No Emission`
  - `Smoke emission = Add`
  - `Smoke rate = 593.755 %/s`
  - `Temperature emission = Replace`
  - `Temperature = 4100.000 K`
  - `Emission gradient = 22.333`
- `Pressure` 分组当前参数包括：
  - `Additional pressure rate = 100.000 %/s`
  - `Pressure random seed = 45275`
  - `Pressure random speed = 0.400`
- 时间线左侧还能看到与此阶段配合的模拟参数，例如：
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 22.056`
  - `Temperature Diffusion = 10.000 m/s`

输出/预览
- 左侧视口中是一团较暗的烟雾团，表示当前主要在观察烟雾扩散和消散行为，而不是火焰亮度
- 底部字幕也强调“可以在模拟中看到火焰如何扩散”，与体积发射器的烟雾、温度和压力参数相对应
- 这一步的要点是先在 EmberGen 内把体积爆炸的扩散节奏调对，之后再在 Niagara/材质里通过 Alpha 和透明度控制收尾阶段的可见性
这张图展示 EmberGen 的 `Shading` 节点中 `Flames` 选项卡，用于调整火焰亮部的成形方式、颜色映射和透明感，从而决定爆炸在最终渲染中的火焰主体观感

节点定义集
- 当前选中节点：`Shading`
- 与其相连的可见节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Camera`
  - `Scene`
  - `Render`
  - `Simulation`
  - `Volume Processing`
- 左侧视口显示的是已经带亮部火焰和外围烟团的爆炸成品预览

连线集
- `Light: Ambient` 和 `Light: Directional` 输入连接到 `Shading`
- `Shading` 输出连接到 `Scene`
- `Scene` 连接到 `Render`
- 说明这里调的并不是模拟本身，而是最终渲染阶段对火焰和烟雾的着色表现

设置/参数
- 当前位于 `Shading` 节点的 `Flames` 选项卡
- 可见标签包括：
  - `Lighting`
  - `Scattering`
  - `Emissive masking`
  - `Flames`
  - `Smoke`
  - `Fuel`
  - `Rendering`
- `Flames` 分组中当前可见参数包括：
  - `Coloring remap range`：`min 0.000`，`max 4000.000`
  - `Coloring remap ramp = 1.000`
  - `Clamp the remapping` 已启用
  - `Shaping by flames = 266.667`
  - `Shaping by density = 0.000`
  - `Flames coloring = Blackbody`
  - `Blackbody ramp scale = 100.000 %`
  - `Flames translucency` 当前未启用
  - `Translucency by density = 11.667`
  - `Flames opacity = 0.000`
- 结合字幕“Here I changed the value for fire”，这一帧的重点就是改火焰相关值，而不是改烟雾模拟参数

输出/预览
- 左侧视口里的爆炸中心明亮泛白，外围包着偏橙黄的火焰和灰色烟团，说明火焰着色已被明显强化
- 时间线此时位于约第 `35` 帧，左下还能看到 `Volume Processing`、`Force: Noise`、`Render` 等轨道，说明火焰着色是在已有模拟基础上做的最终观感调节
- 这一步的关键作用，是把 EmberGen 爆炸的火焰层调到适合输出贴图的亮度和形状，后续在 Niagara 里再通过 Alpha/透明度控制整体淡出

### 00:09:48-00:14:30 速度

- 本段定位：速度。
- 知识点：也有一个選項 我用这个選項来设置烟霧的颜色 我没有用光线 这是烟霧 它看起来很好 可以用光线 我告訴你 它通常会用光线看起来好 但在这个情况下。
- 知识点：我特别用黑色的光线 来示範你能够用它做得很好 如果我设置了一些有趣的光线 需要尝试创建 这是光线的光线的变化 需要把價值改变了 如果你喜欢这个選項。
- 知识点：可以把它放下 可以在这里设置颜色 你喜欢哪些颜色 但需要放下我的選項 这里有一个選項 我把烟霧改变了 我没有用光线 我把烟霧改变了 我喜欢它。
- 知识点：它变得更精緻 烟霧的分別特别显示 我设置了这些價值 需要慢慢地看 这里我把灯光量減少了 这里是烟霧的数量 这里是烟霧的分量 这里是烟霧的分量。
- 知识点：我慢慢地把速度降低 让它升起一点 然后慢慢地緩慢 用速度降低 这是我设置的價值 烟霧的分量 然后我再加更多 很快地降低 可以用它来玩滑浮。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这张图展示 EmberGen 中 `Shading` 节点对火焰与烟雾显示的联合调整，重点是降低烟雾存在感、保留火焰速度感，并用黑体火焰着色维持爆炸主亮部

节点定义集
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Camera`
  - `Scene`
  - `Render`
  - `Volume Processing`

连线集
- `Light: Ambient` 与 `Light: Directional` 接入 `Shading`
- `Shading` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- 说明此处调的是最终视觉表现，不是发射器或模拟数据本身

设置/参数
- 当前位于 `Shading` 节点
- 上方激活页签为 `Flames`
- `Flames` 分组中可见参数：
  - `Shaping by flames = 266.667 %`
  - `Shaping by density = 0.000`
  - `Flames coloring = Blackbody`
  - `Blackbody ramp scale = 100.000 %`
  - `Flames translucency` 未启用
  - `Flames density min limit = 0.000`
  - `Flames density scale = 100.000 %`
  - `Flames opacity = 0.000`
- 下方同时展开了 `Smoke` 分组，可见：
  - `Render smoke` 已启用
  - `Remap by temperature` 当前未启用
  - `Smoke Histogram` 面板开启，并勾选了 `Log Y`
- 左下时间线里还能看到当前阶段参数：
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 10.000 m/s`
  - `Motion blur intensity = 16.322 %`
  - `Force: Noise > Bias Z = 0.049`

输出/预览
- 左侧视口中的爆炸中心极亮，外围烟团较暗，说明当前在强调火焰主体，同时弱化烟雾遮挡
- 这一步与上下文“速度、颜色”一致，重点是通过着色而不是额外灯光，让烟雾更克制、火焰更集中，从而形成更利落的爆炸速度感
这张图继续在 EmberGen 的 `Shading` 节点里调整火焰与烟雾显示，不过当前预览主要观察的是只保留烟雾体积后的形态，用来判断颜色和消散速度是否合适

节点定义集
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Scene`
  - `Render`
  - `Volume Processing`
  - `Emitter: Particles`

连线集
- 灯光节点接入 `Shading`
- `Shading` 输出接入 `Scene`
- `Scene` 再接入 `Render`
- 这一图仍属于渲染表现阶段，而不是模拟拓扑或发射器拓扑修改

设置/参数
- 当前页签仍为 `Flames`
- 可见参数包括：
  - `Coloring remap range`：`min 0.000`，`max 4000.000`
  - `Coloring remap ramp = 1.000`
  - `Clamp the remapping` 已启用
  - `Shaping by flames = 266.667 %`
  - `Shaping by density = 0.000`
  - `Flames coloring = Blackbody`
  - `Blackbody ramp scale = 100.000 %`
  - `Flames translucency` 未启用
  - `Flames density min limit = 11.667`
  - `Flames density scale = 100.000 %`
  - `Flames opacity = 0.000`
- 下方 `Smoke` 分组可见：
  - `Render smoke` 已启用
  - `Remap by temperature` 当前未启用
- 时间线左侧可见当前相关参数：
  - `Smoke dissipation = 0.005 units/s`
  - `Vorticity intensity = 15.073`
  - `Temperature Diffusion = 10.000 m/s`
  - `Motion blur intensity = 0.000 %`
  - `Force: Noise > Bias Z = 0.049`

输出/预览
- 视口中的爆炸已经几乎只表现为灰色烟柱和烟团，没有明显火焰亮部，说明教程正在对比关闭或弱化火焰后的烟雾结果
- 这一步的意义，是确认即便不依赖额外亮火，烟雾本身的层次、升腾速度和体积分布也成立，后续再决定保留多少火焰或透明度
这张图切到 EmberGen 的 `Simulation` 节点，用于调整烟雾在受力、重力和地面约束下的运动方式，从而控制爆炸速度和升腾行为

节点定义集
- 当前选中节点：`Simulation`
- 可见相关节点：
  - `Emitter: Volume`
  - `Force: Line`
  - `Shape: Primitive`
  - `Emitter: Particles`
  - `Volume Processing`
  - `Shading`
  - `Scene`
  - `Render`

连线集
- `Emitter: Volume` 输出连接到 `Simulation`
- `Simulation` 输出：
  - `Volume`
  - `Particles`
- `Simulation` 的输出继续连接到 `Scene`
- 说明这一节点是体积烟雾和粒子行为的核心求解阶段

设置/参数
- 当前位于 `Simulation` 节点的 `Force` 页签
- 顶部可见页签包括：
  - `Domain`
  - `Simulation`
  - `Time Control`
  - `Projection`
  - `Combustion`
  - `Dissipation`
  - `Diffusion`
  - `Vorticity`
- `Force` 页签中可见参数：
  - `Force randomness = 0.000`
  - `Buoyancy = 0.000 % of gravity per 1000K`
  - `Smoke weight = 100.000 % of gravity`
  - `Fuel weight = 0.000 % of gravity`
  - `Gravity multiplier = 100.000 %`
  - `Solid Ground` 已启用
  - `Solid Ceiling` 未启用
  - `Solid Wall -X` 未启用
  - `Solid Wall +X` 未启用
  - `Solid Wall -Y` 未启用
  - `Solid Wall +Y` 未启用
  - `Wind direction X = 0.000`
  - `Wind direction Y = 0.000`
  - `Wind direction Z = 0.000`
  - `Wind speed = 0.000 m/s`
- 左下时间线当前还能看到配合的动态值：
  - `Smoke dissipation = 0.048 units/s`
  - `Vorticity intensity = 0.000`
  - `Temperature Diffusion = 10.000 m/s`
  - `Motion blur intensity = 0.000 %`
  - `Force: Noise > Bias Z = 0.049`

输出/预览
- 左侧视口中的烟雾已经扩散成一大团较平的灰色云层，说明当前更关注后期漂散状态而非爆炸初始火焰
- 字幕提到“它也考虑了地面”，与 `Solid Ground` 启用相对应，表示模拟会让烟雾与地面发生碰撞或贴地扩散
- 这一步的关键作用，是通过地面约束、重力和消散设置，把烟雾的移动速度压下来并让其更自然地铺开，为后续导出到 Niagara 的透明度控制提供合理基础

### 00:14:30-00:19:21 速度

- 本段定位：速度。
- 知识点：有个爆破 这很重要 它必须把烟霧 移动掉 然后需要 这个设置 这里我都设置了 我把这些價值 加上了速度。
- 知识点：我把它降低了 这里我都设置了 这里是普通的 我把颜色适当加上了 可观察到 烟霧的光亮 这里的效果 跟普通的不同 这些價值 我们来做一个刪測 这是它们的效果。
- 知识点：这是我给你们的爆破 我把價值加上了 我把價值改变了 在时间內改变了 在刪測上 我用了我给你们的 最佳设置 在最後一課的 这里我用了一个非常大的大小。
- 知识点：不要把它放大 设置4K最大 但我做了这件事 为示範 这樣的大大小 我们想它们能够看起来 最好 可以用在 在现實的4K或2K 2048 这是最佳用處。
- 知识点：但这視乎这个計劃 需要回到原本的设置 我錯过了一个画面 在一个画面之后 会有一个刪測 我把它放在一个 folder 我把它放在PNG 现在我们来看看。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这张图展示 EmberGen 的 `Simulation` 节点在爆炸中前段的受力与地面约束设置，用来控制烟团厚度、上升速度和早期消散幅度

节点定义集
- 当前选中节点：`Simulation`
- 可见相关节点：
  - `Emitter: Volume`
  - `Force: Line`
  - `Shape: Primitive`
  - `Shading`
  - `Scene`
  - `Render`
  - `Volume Processing`
  - `Emitter: Particles`

连线集
- `Emitter: Volume` 输出连接到 `Simulation`
- `Simulation` 输出体积与粒子结果到 `Scene`
- `Scene` 再输出到 `Render`
- 说明这里仍在核心模拟阶段调烟雾运动，而不是改渲染外观

设置/参数
- 当前位于 `Simulation > Force` 页签
- 可见参数包括：
  - `Force randomness = 0.000`
  - `Buoyancy = 0.000 % of gravity per 1000K`
  - `Smoke weight = 100.000 % of gravity`
  - `Fuel weight = 0.000 % of gravity`
  - `Gravity multiplier = 100.000 %`
  - `Solid Ground` 已启用
  - `Solid Ceiling` 未启用
  - `Solid Wall -X` 未启用
  - `Solid Wall +X` 未启用
  - `Solid Wall -Y` 未启用
  - `Solid Wall +Y` 未启用
  - `Wind direction X = 0.000`
  - `Wind direction Y = 0.000`
  - `Wind direction Z = 0.000`
  - `Wind speed = 0.000 m/s`
- 左侧统计面板显示当前预览状态：
  - `Sim Time = 125.4 ms`
  - `Sim Speed = 452 Mvox/s`
  - `Resolution = 2030x1543`
- 底部时间线当前值还能看到：
  - `Smoke dissipation = 0.013 units/s`
  - `Vorticity intensity = 6.874`
  - `Temperature Diffusion = 10.000 m/s`
  - `Motion blur intensity = 0.000 %`
  - `Force: Noise > Bias Z = 0.049`

输出/预览
- 左侧视口中是一团厚重、顶部鼓起的灰色烟云，底部仍保留明显向上的主柱，说明此时模拟还处在较早的扩张阶段
- 与上一段后期铺散状态相比，这里更强调“烟团还未完全散开时”的速度和体积感
- 这一步的作用，是用较低的消散和适中的旋涡值保住烟团厚度，再逐渐推进到后续更平缓的漂散结果
这张图展示 EmberGen 的 `Render` 节点与导出设置，用于把当前爆炸输出成项目可用的 Flipbook 序列，并控制哪些渲染通道参与最终输出

节点定义集
- 当前选中节点：`Render`
- 可见相关节点：
  - `Camera`
  - `Scene`
  - `Shading`
  - `Simulation`
  - `Emitter: Volume`
  - `Emitter: Particles`
  - `Volume Processing`
- 左侧视口显示带少量橙红火芯的爆炸烟团预览

连线集
- `Camera` 连接到 `Render`
- `Scene` 连接到 `Render`
- `Shading` 连接到 `Scene`
- `Simulation` 的体积和粒子输出先进入 `Scene` 再送到 `Render`
- 这说明 `Render` 节点负责最终采集视角与场景结果并执行导出

设置/参数
- 当前位于 `Render` 节点的 `Render Passes` 页面
- 左上导出相关下拉可见：
  - `Alpha Blending Mode = Premultiplied`
  - `Emissive Alpha Mode = None`
  - `Invert Render Alpha` 已启用
  - `Shapes Rendering = Holdout`
  - `Shapes Masking = No Mask...`
  - `Invert Shapes Alpha` 已启用
  - `Volume Occludes Particles` 已启用
  - `Particles Occlude Volume` 已启用
  - `Render Volume` 已启用
  - `Render Particles` 已启用
- `Export` 分组中可见：
  - `Export Mode = Flipbook`
  - `Flipbook Size = 8192 x 8192`
  - `Flipbook Columns / Rows = 8 x 8`
- 下方绿色网格预览表示将输出为 8x8 的 sprite sheet
- 左上统计还可见：
  - `Resolution = 1430x1080`
  - `Render Time = 264.3 ms`

输出/预览
- 视口中的爆炸主体以灰烟为主，内部夹杂红橙色亮点，说明这套输出同时保留体积烟雾和局部发光粒子
- 字幕提到实际项目常用 4K 甚至 2K，对应这里教程在讨论高规格导出与真实项目分辨率取舍
- 这一步的关键作用，是把 EmberGen 爆炸整理成可供 Niagara 使用的 flipbook 贴图资源，并提前决定 Alpha、遮挡和体积/粒子通道的组合方式
这张图展示 EmberGen 在 `Render` 节点下为六方向光照或多通道贴图做 Render Pass 映射的界面，重点是把烟雾、发光和运动信息拆到不同输出通道，供后续 Niagara/材质重建使用

节点定义集
- 当前选中节点：`Render`
- 可见相关节点：
  - `Camera`
  - `Scene`
  - `Shading`
  - `Simulation`
  - `Emitter: Volume`
  - `Emitter: Particles`
  - `Volume Processing`
- 左侧视口中的爆炸被伪彩色显示，明显不是最终成片色，而是某种通道/方向调试预览

连线集
- `Camera` 与 `Scene` 接入 `Render`
- `Shading` 先接入 `Scene`
- `Simulation` 的结果经 `Scene` 汇总后再进入 `Render`
- 当前工作重点是在 `Render` 内部分配输出通道，而不是改模拟链路

设置/参数
- 顶部导出视图模式显示为 `Render 1` 与 `Six Point...`
- 左侧通用渲染选项可见：
  - `Alpha Blending Mode = Premultiplied`
  - `Emissive Alpha Mode = None`
  - `Invert Render Alpha` 已启用
  - `Shapes Rendering = Holdout`
  - `Shapes Masking = No Mask...`
  - `Invert Shapes Alpha` 已启用
  - `Volume Occludes Particles` 已启用
  - `Particles Occlude Volume` 已启用
  - `Render Volume` 已启用
  - `Render Particles` 已启用
  - `Six points world space` 已启用
  - `Six points black background` 已启用
  - `Smoke density boost = 0.000 %`
  - `Exposure adjustment = 0.000`
  - `Gamma adjustment = 0.000`
  - `Blacks adjustment = 0.000`
  - `Whites adjustment = 0.000`
  - `Per direction parameters` 已启用
  - `Shadowing intensity = 150.000 %`
  - `Top shadowing intensity = 150.000 %`
  - `Right shadowing intensity = 150.000 %`
  - `Left shadowing intensity = 150.000 %`
- 下方 `Render Passes` 的 `Mapping` 区可见通道映射：
  - `Alpha` 输出到 `Alpha / R`
  - `Smoke` 输出到 `Smoke / RGBA`
  - `Emissive + Scatte...` 输出到 `Emissive + Scatt... / RGBA`
  - `Motion Vector` 输出到 `Motion Vector / RGBA`

输出/预览
- 视口中的红、绿、蓝等伪彩烟团说明这里在预览六方向光照或分通道数据，而不是最终美术色
- 这种拆分方式能让后续材质在 Unreal 中利用多张或多通道 flipbook 还原烟雾亮暗、发光和运动信息
- 这一步的核心作用，是把 EmberGen 爆炸整理成适合实时项目的多通道贴图资产，而不只是单张彩色序列

### 00:19:21-00:24:20 速度

- 本段定位：速度。
- 知识点：还有兩條普通MAP 普通MAP通常用三條 需要把 第三條的物料刪測 这里所有东西都標準 可能需要刪測 需要写这里 它是新的 我按了輸出鍵 让結果开始刪測。
- 知识点：在等待結果 刪測完成 可观察到結果 或者开启文件 这里是这條圖 这里是我们的图片 所有东西都標準 我们看看 动画圖,烟 可观察到高质感的质感。
- 知识点：非常高的溫度 如果是少,会比較低质感 表现会很差 如果我们做出高质感的质感 但在我们的情况下 这是一个示範,所以让它是 我们来談談烟 我们把这个当作。
- 知识点：一个基礎,很像这个图片 我剪輯了一点 我们進入画面 進入刪測 这是它会看起来的刪測 这里它很快就消失了 这里發生什么事 它可以被删除 这兩个都可以刪測。
- 知识点：这是一个图片 它们在我们的情况下刪測烟 它们是没有其他东西的 它们会被重量刪測 如果你增加它们的数字 可以改变生命的时间 因此它们会变得更多。
- 核对对象：`速度`。

**关键画面：**

这张图展示 EmberGen 的 `Render` 节点中多通道 Render Pass 映射配置，重点是为材质生成第三张贴图或第三组数据通道，用来承载深度、法线或 six-point 光照重建信息

节点定义集
- 当前选中节点：`Render`
- 可见相关节点：
  - `Camera`
  - `Scene`
  - `Shading`
  - `Simulation`
  - `Emitter: Volume`
  - `Emitter: Particles`
  - `Volume Processing`
- 左侧视口中的爆炸被伪彩色渲染，说明正在检查六方向或分通道调试输出

连线集
- `Camera` 与 `Scene` 接入 `Render`
- `Scene` 汇总来自 `Shading`、`Simulation` 等节点的结果
- 当前工作集中在 `Render Passes` 内部的源通道到目标通道映射，而不是节点网络结构改动

设置/参数
- 顶部模式显示为 `Render 1` 和 `Six Point...`
- 左侧可见通用渲染选项：
  - `Alpha Blending Mode = Premultiplied`
  - `Emissive Alpha Mode = None`
  - `Invert Render Alpha` 已启用
  - `Shapes Rendering = Holdout`
  - `Shapes Masking = No Mask...`
  - `Invert Shapes Alpha` 已启用
  - `Volume Occludes Particles` 已启用
  - `Particles Occlude Volume` 已启用
  - `Render Volume` 已启用
  - `Render Particles` 已启用
  - `Six points world space` 已启用
  - `Six points black background` 已启用
  - `Per direction parameters` 已启用
  - `Shadowing intensity = 150.000 %`
  - `Top shadowing intensity = 150.000 %`
  - `Right shadowing intensity = 150.000 %`
  - `Left shadowing intensity = 150.000 %`
- `Render Passes` 映射区当前可见的通道包括：
  - `Depth`
  - `Mask`
  - `Six Point Normal Map`
  - `Six Point 1 (TLR)`，目标映射到 `RGB`
  - `Six Point 2 (BBF)`，目标映射到 `RGB`
- 字幕明确提到“在材质中生成第三个通道”，与这里继续增加 render pass 映射相吻合

输出/预览
- 伪彩烟团显示出不同方向的亮色分区，说明 six-point 方向数据正在被编码而不是显示最终颜色
- 这一步的核心作用，是为 Unreal 材质准备更完整的多贴图/多通道输入，使实时材质能在不依赖体积模拟的情况下重建烟雾的方向感和厚度
这张图切换到 `smoke_shockwave.ember` 工程，用一个黑底下的烟雾冲击波示例来演示较轻烟雾层的输出与寿命控制

节点定义集
- 当前工程名：`smoke_shockwave.ember`
- 可见节点包括：
  - `Force: Line`
  - `Turbulence with animated bias`
  - `Light: Ambient`
  - `Light: Directional`
  - `Shading`
  - `Simulation`
  - `Volume Processing`
  - `Camera`
  - `Scene`
  - `Render`
  - `Shape: Primitive`
  - `Emitter: Particles`
  - `Force Point`
- 其中一个 `Shape: Primitive` 节点被黄色框标注，标题提示为 `Changing the radius of this...`
- 视口里可见一个环形或圆周状的稀薄烟圈

连线集
- `Force: Line`、`Shape: Primitive`、`Emitter: Particles` 等节点接入 `Simulation`
- `Simulation` 输出连接到 `Scene`
- `Light: Ambient`、`Light: Directional` 接入 `Shading`
- `Shading` 与 `Volume Processing` 一起接入 `Scene`
- `Scene` 与 `Camera` 最终连接到 `Render`

设置/参数
- 顶部处于 `Render` 视图
- 当前左侧统计信息可见：
  - `Bounds = 512x512x128`
  - `Voxels = 33.6 Mvox`
  - `Resolution = 1430x1080`
  - `Render Time = 71.1 ms`
  - `UI Framerate = 60.1 fps`
  - `Particles = 0`
- 左上渲染选项可见：
  - `Alpha Blending Mode = Premultiplied`
  - `Emissive Alpha Mode = Black To...`
  - `Invert Render Alpha` 已启用
  - `Shapes Rendering = Holdout`
  - `Shapes Masking = No Mask...`
  - `Invert Shapes Alpha` 已启用
  - `Volume Occludes Particles` 已启用
  - `Particles Occlude Volume` 已启用
  - `Render Volume` 已启用
  - `Render Particles` 已启用
- 时间线左侧当前关键参数包括：
  - `Smoke dissipation = 0.250 units/s`
  - `Force: Noise > Bias Z = 0.199`
  - `Render > Duration = 64 f`
  - `Force: Line > Force activity = Enabled`

输出/预览
- 左侧视口中只剩很淡的烟圈，中心几乎透明，说明这是用来检查轻量烟雾如何快速淡出的示例
- 这一图与上下文“速度”一致，强调的是通过更高的烟雾消散和有限帧数，让冲击波式烟层在较短时间内消失
这张图展示 `smoke_shockwave.ember` 中 `Simulation` 节点的扩散设置，用于单独控制烟雾、温度和速度的扩散强度，从而决定冲击波烟圈的边缘清晰度和持续时间

节点定义集
- 当前工程名：`smoke_shockwave.ember`
- 当前选中节点：`Simulation`
- 可见相关节点：
  - `Wind`
  - `Turbulence with animated bias`
  - `Emitter: Particles`
  - `Shape: Primitive`
  - `Light: Ambient`
  - `Light: Directional`
  - `Shading`
  - `Scene`
  - `Render`
  - `Volume Processing`
- 左侧视口中是一团近似圆盘状的烟雾冲击波，边缘有向外拉伸的细丝

连线集
- `Wind`、`Emitter: Particles`、`Shape: Primitive` 等输入接入 `Simulation`
- `Simulation` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- `Shading`、`Volume Processing` 作为视觉结果链路并入 `Scene`

设置/参数
- 当前位于 `Simulation` 节点的 `Diffusion` 页签
- 顶部可见标签包括：
  - `Domain`
  - `Simulation`
  - `Time Control`
  - `Projection`
  - `Combustion`
  - `Dissipation`
  - `Diffusion`
  - `Vorticity`
- `Diffusion` 分组中当前可见参数：
  - `Smoke Diffusion Speed = 0.000 m/s`
  - `Temperature Diffusion Speed = 0.770 m/s`
  - `Fuel Diffusion Speed = 0.000 m/s`
  - `Flames Diffusion Speed = 0.000 m/s`
  - `Velocity Diffusion Speed = 0.000 m/s`
- 下方 `Vorticity` 分组可见：
  - `Vorticity intensity = 0.000 %`
  - `Large vorticity intensity = 0.000 %`
  - `Velocity mask = 100.000 %`
  - `Vorticity by temperature = 0.000`
  - `Smoke mask = 0.000`
  - `Temperature Range` 可见，范围从 `0.000 K min` 到 `10000.000 K`
  - `Smoke Range` 可见，范围从 `0.000 % min` 到 `300.000 %`
- 左下时间线当前关键值包括：
  - `Smoke dissipation = 0.005 units/s`
  - `Force: Noise > Bias Z = 1.943`
  - `Render > Duration = 64 f`
  - `Force: Line > Force activity = Enabled`

输出/预览
- 左侧视口中的烟圈边缘较锐利、中心更空，说明烟雾扩散被压得较低，主要保留外缘冲击感
- 字幕提到“烟雾本身、温度等等”，与这里分别控制 smoke 与 temperature diffusion 的设置相对应
- 这一步的核心作用，是把冲击波烟圈调成更适合实时贴图的形态：边缘清晰、衰减快、不会过度糊开

### 00:24:20-00:29:03 Alpha、速度

- 本段定位：Alpha、速度。
- 知识点：把它降低 把調校调整了一点 后期也改变了 重新重新 灯光也被刪測 现在的刪測已经降低了 这里的所有东西都標準了 这里的所有东西都跟我们一樣。
- 知识点：的所有东西都跟我们一樣 我们刪測的时间是有點不一樣的 因为我们没有火 我们没有烟霧 只有烟霧 你看,我现在在看电影 在擺放 这里没有什么。
- 知识点：只有Dim,Alpha,Vovshin 和普通的Disex 我把这里的尺寸降低了 我覺得4K会足夠 我認为4K也足夠在Vibes。
- 知识点：但我放了8K 因为会更好看 結果会更好看 我这里每个画面 我没有錯过任何东西 在每个画面中我都会發生 还是仍然在刪測? 这里的反射速度降低了。
- 知识点：的反射速度降低了 开始在最初的一刻开始刪測 甚至是自己的一刻 这是它 这里我基本上都放了 它们的样子 按照標準 这就是所有的 我们也選了刪測的。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`速度`。

**关键画面：**

这张图展示 `smoke_shockwave.ember` 中 `Volume Processing` 节点的后处理设置，用于直接改变烟雾冲击波的边缘膨胀和切片遮罩，因此会显著影响最终 Alpha 轮廓

节点定义集
- 当前工程名：`smoke_shockwave.ember`
- 当前选中节点：`Volume Processing`
- 可见相关节点：
  - `Simulation`
  - `Wind`
  - `Turbulence with animated bias`
  - `Emitter: Particles`
  - `Shape: Primitive`
  - `Shading`
  - `Scene`
  - `Render`
- 左侧视口中可见一个圆形爆开的烟雾冲击波，外缘带细丝

连线集
- `Simulation` 输出连接到 `Volume Processing`
- `Volume Processing` 的 `Volume` 与 `VDB` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- 说明这里的调整发生在模拟之后、渲染之前，属于直接修饰体积结果的后处理层

设置/参数
- 当前位于 `Volume Processing` 节点
- 可见标签包括：
  - `Post Process`
  - `Post Modulation 1`
  - `Slicing Mask`
- `Post Process` 分组当前可见参数：
  - `Fuel dilate = 102.500 %`
  - `Dilate softness = 500.000 %`
- `Post Modulation 1` 分组当前：
  - `Active` 未启用
- `Slicing Mask` 分组中可见一系列墙面/地面裁切参数，当前都为 `0.000`，包括：
  - `X- wall offset`
  - `X- wall width`
  - `X+ wall offset`
  - `X+ wall width`
  - `Y- wall offset`
  - `Y- wall width`
  - `Z- ground offset`
  - `Z- ground width`
- 左侧统计可见：
  - `Bounds = 512x512x128`
  - `Voxels = 33.6 Mvox`
  - `Resolution = 2030x1543`
  - `Render Time = 12.8 ms`
  - `Particles = 60.0 K`
- 时间线左侧当前参数：
  - `Smoke dissipation = 0.005 units/s`
  - `Force: Noise > Bias Z = 1.943`
  - `Render > Duration = 64 f`

输出/预览
- 视口中的烟雾冲击波整体呈白灰色，边缘被拉得比较毛糙，说明后处理已经在改变体积外轮廓
- 字幕也明确指出“后处理在这里也发生了变化”，与当前 `Volume Processing` 节点被选中相对应
- 这一步的作用，是在导出前把烟圈的体积边缘修成更适合做 Alpha flipbook 的形状，避免进入材质后轮廓过硬或太薄
这张图展示 `smoke_shockwave.ember` 在 `Render` 节点的导出页面，重点是把准备好的烟雾冲击波序列导出为 PNG 文件，并确认 Alpha 与遮挡相关渲染设置

节点定义集
- 当前工程名：`smoke_shockwave.ember`
- 当前选中节点：`Render`
- 可见相关节点：
  - `Camera`
  - `Scene`
  - `Shading`
  - `Simulation`
  - `Volume Processing`
  - `Emitter: Particles`
  - `Shape: Primitive`
  - `Light: Ambient`
  - `Light: Directional`
- 左侧视口中可见一个较薄的环形烟圈预览

连线集
- `Camera` 与 `Scene` 接入 `Render`
- `Scene` 汇总 `Shading`、`Simulation`、`Volume Processing` 的结果后送到 `Render`
- 当前是在输出阶段确认文件路径和渲染参数，不再改模拟逻辑

设置/参数
- 当前位于 `Render` 节点的 `Export` 页面
- 导出目录为：
  `C:/Users/Stand1k/Desktop/Embergen/ember/ground`
- 文件名模板为：
  `$(project)_$(safename)_###`
- 输出格式为 `.png`
- 右侧示例输出名可见为类似：
  `smoke_shockwave_render_all_###.png`
- 可见操作按钮：
  - `Export Now`
  - `Open Folder`
- 下方 `Render Settings` 中可见：
  - `Alpha Blending Mode = Premultiplied Alpha`
  - `Invert Render Alpha` 当前未启用
  - `Shapes Rendering = Holdout`
  - `Shapes Masking = No Masking`
  - `Invert Shapes Alpha` 当前未启用
  - `Volume Occludes Particles` 已启用
  - `Particles Occlude Volume` 已启用
  - `Render Volume` 已启用
  - `Render Particles` 已启用
  - `MV outer blur radius = 4.000 pixels`
  - `MV inner blur radius = 2.000 pixels`
- 左侧统计可见：
  - `Bounds = 512x512x128`
  - `Voxels = 33.6 Mvox`
  - `Resolution = 2030x1543`
  - `Render Time = 11.9 ms`
  - `Particles = 0`
- 时间线左侧当前值包括：
  - `Smoke dissipation = 0.250 units/s`
  - `Force: Noise > Bias Z = 0.828`
  - `Render > Duration = 64 f`
  - `Force: Line > Force activity = Enabled`

输出/预览
- 左侧烟圈已经非常轻薄，说明这是更偏 Alpha/烟圈层的导出结果，而不是带火焰的主爆炸序列
- 这一步的作用，是在正式导出前确认路径、文件命名和 Alpha 渲染行为都已经就绪，方便后续直接把 PNG 序列整理进 Niagara 贴图流程
这张图回到 `boom.ember` 爆炸工程，在 `Shading` 节点的 `Emissive masking` 页面调发光遮罩，以控制哪些高温区域会被当作明亮火焰输出、哪些区域只保留为烟雾体积

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Volume Processing`
  - `Scene`
  - `Render`
  - 两个 `Emitter: Particles` 分支
  - `Force: Line`
  - `Shape: Primitive`
- 左侧视口中是带少量橙色火芯的灰色爆炸烟团

连线集
- 两个灯光节点连接到 `Shading`
- `Shading` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- 说明当前是在着色层通过遮罩决定发光区域，而不是回到模拟层改烟雾结构

设置/参数
- 当前位于 `Shading` 节点
- 激活页签为 `Emissive masking`
- `Emissive masking` 分组当前参数包括：
  - `Masking Active` 已启用
  - `Density reference = 0.220`
  - `Width = 0.377`
  - `Masking ramp = 1.000`
  - `Masking intensity = 100.000 %`
  - `Low frequencies = 50.000 %`
  - `Medium frequencies = 50.000 %`
  - `High frequencies = 50.000 %`
- 下方 `Flames` 分组可见：
  - `Render flames` 已启用
  - `Temperature Histogram` 可见，并勾选了 `Log Y`
- 左下时间线当前还能看到主爆炸参数：
  - `Smoke rate = 531.973 %/s`
  - `Additional pressure rate = 100.000 %/s`
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 0.000 %`

输出/预览
- 视口中的火焰只在烟团内部少量区域发亮，其余主体保持灰色，说明遮罩已经把发光范围限制在高温核心附近
- 这种做法与本段“Alpha、速度”相符：通过更精确的 emissive mask，可以在输出贴图时把亮火和烟雾分得更干净，后续在 Niagara 材质里更容易控制透明度和节奏

### 00:29:04-00:29:47 关键流程 07

- 本段定位：关键流程 07。
- 知识点：非常有趣的选择 这是一个很好的版本 可以这樣做 只要改变幾个风格 你就可以得到一个完全不同的結果 所以 可以用来做一个很好的测试。
- 知识点：看看你喜欢的风格 这里,就这樣 下个影片需要来到Unreal Engine 制作材料,整理所有东西 謝謝,再見。

**关键画面：**

这张图展示 `boom.ember` 在 `Shading` 节点的 `Emissive masking` 风格变体效果，说明只调整少量发光遮罩与后处理参数，就能把同一套爆炸改成更亮、更偏火焰主导的版本

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Volume Processing`
  - `Scene`
  - `Render`
  - `Emitter: Particles` 两个分支
  - `Force: Line`
  - `Shape: Primitive`
- 左侧视口中的爆炸以亮黄色火焰为主，外围只残留少量暗灰色体积

连线集
- 灯光节点接入 `Shading`
- `Shading` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- 当前仍是着色层面的风格调整，而非模拟结构变化

设置/参数
- 当前位于 `Shading > Emissive masking`
- `Emissive masking` 分组可见：
  - `Masking Active` 已启用
  - `Density reference = 0.220`
  - `Width = 0.377`
  - `Masking ramp = 1.000`
  - `Masking intensity = 100.000 %`
  - `Low frequencies = 50.000 %`
  - `Medium frequencies = 50.000 %`
  - `High frequencies = 50.000 %`
- 下方 `Flames` 分组中：
  - `Render flames` 已启用
  - `Temperature Histogram` 可见，并勾选 `Log Y`
- 左上渲染选项可见：
  - `Alpha Blending Mode = Premultiplied`
  - `Emissive Alpha Mode = None`
  - `Invert Render Alpha` 已启用
  - `Shapes Rendering = Holdout`
- 时间线当前关键值包括：
  - `Smoke rate = 203.874 %/s`
  - `Additional pressure rate = 100.000 %/s`
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 57.419 %`

输出/预览
- 左侧视口中，爆炸内部大面积变成高亮黄橙火焰，烟雾只作为背景轮廓存在，说明 emissive masking 让高温区被更强烈地保留下来
- 这与本段“只改几个风格就能得到完全不同的结果”一致，体现了同一套模拟通过材质/着色风格化可以快速生成多种版本
这张图继续展示同一个 `Emissive masking` 配置下的另一种结果取向：保留大体积灰烟，只在内部留下少量弱火芯，从而得到和上一张明显不同的爆炸风格

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Volume Processing`
  - `Scene`
  - `Render`
  - 两个 `Emitter: Particles` 分支
  - `Force: Line`
  - `Shape: Primitive`
- 左侧视口中的爆炸以厚重灰烟为主，内部只有极少量暗橙色亮点

连线集
- 灯光节点接入 `Shading`
- `Shading` 输出连接到 `Scene`
- `Scene` 输出连接到 `Render`
- 和上一张相比，节点网络不变，变化主要来自风格参数取舍或时间点差异

设置/参数
- 当前仍位于 `Shading > Emissive masking`
- 可见参数保持：
  - `Masking Active` 已启用
  - `Density reference = 0.220`
  - `Width = 0.377`
  - `Masking ramp = 1.000`
  - `Masking intensity = 100.000 %`
  - `Low frequencies = 50.000 %`
  - `Medium frequencies = 50.000 %`
  - `High frequencies = 50.000 %`
- 下方 `Flames` 分组中：
  - `Render flames` 已启用
  - `Temperature Histogram` 仍显示，并勾选 `Log Y`
- 左侧统计可见：
  - `Sim Time = 123.9 ms`
  - `Sim Speed = 457 Mvox/s`
  - `Resolution = 1430x1080`
  - `Render Time = 322.4 ms`
- 时间线当前参数包括：
  - `Smoke rate = 562.204 %/s`
  - `Additional pressure rate = 100.000 %/s`
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 0.000 %`

输出/预览
- 左侧视口中灰烟占比明显更大，火焰亮度被压到只剩局部核心，这与字幕“可以得到完全不同的结果”完全一致
- 这一步说明即使底层模拟没变，只调整火焰遮罩、亮度保留或观察时机，也能把同一资产改成更偏烟雾主导的版本
这张图给出了同一爆炸工程的第三种结尾风格：几乎完全去掉火焰显示，只保留纯灰烟爆体，用来证明当前流程可以很容易扩展成更写实或更克制的版本

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Shading`
- 可见相关节点：
  - `Light: Ambient`
  - `Light: Directional`
  - `Emitter: Volume`
  - `Simulation`
  - `Volume Processing`
  - `Scene`
  - `Render`
  - 两个 `Emitter: Particles`
  - `Force: Line`
  - `Shape: Primitive`
- 左侧视口中只有灰色烟云，几乎没有橙色火光

连线集
- 节点连接关系与前两张一致：
  - 灯光节点接入 `Shading`
  - `Shading` 输出到 `Scene`
  - `Scene` 输出到 `Render`
- 这再次说明风格差异主要来自参数取舍，而不是流程结构变化

设置/参数
- 当前页签仍为 `Shading > Emissive masking`
- `Emissive masking` 分组当前可见：
  - `Masking Active` 已启用
  - `Density reference = 0.220`
  - `Width = 0.377`
  - `Masking ramp = 1.000`
  - `Masking intensity = 100.000 %`
  - `Low frequencies = 50.000 %`
  - `Medium frequencies = 50.000 %`
  - `High frequencies = 50.000 %`
- `Flames` 分组中：
  - `Render flames` 仍处于启用状态
  - `Temperature Histogram` 可见，并勾选 `Log Y`
- 左侧统计显示：
  - `Sim Time = 78.8 ms`
  - `Sim Speed = 719 Mvox/s`
  - `Resolution = 1430x1080`
  - `Render Time = 376.7 ms`
- 时间线当前参数包括：
  - `Smoke rate = 613.434 %/s`
  - `Additional pressure rate = 100.000 %/s`
  - `Smoke dissipation = 0.016 units/s`
  - `Vorticity intensity = 3.636`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 0.000 %`

输出/预览
- 视口中的爆炸完全转为纯灰色体积云，没有明显火芯，说明最终可以把同一资产处理成接近纯烟爆或尘爆的观感
- 这张图与前两张组成清晰对比：从强火焰版本，到弱火芯版本，再到纯烟版本，体现了教程总结时强调的“改少量风格参数即可得到不同结果”

## 补充视觉证据

### S01 00:02:32

这张补充截图展示 `boom.ember` 中 `Volume Processing` 节点的 `Post Process` 参数细节，用来具体说明爆炸体积后处理里各类 dilate 值是如何设置的

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Volume Processing`
- 可见相关节点：
  - `Simulation`
  - `Shading`
  - `Scene`
  - `Render`
  - `Light: Ambient`
  - `Light: Directional`
  - 多个粒子与体积分支
- 左侧视口显示的是带亮火芯和灰色烟团的主爆炸预览

连线集
- `Simulation` 输出连接到 `Volume Processing`
- `Volume Processing` 的 `Volume` 与 `VDB` 输出连接到 `Scene`
- `Scene` 再连接到 `Render`
- 说明这些参数是在模拟结果之后统一修饰体积边缘、火焰和烟雾分布

设置/参数
- 当前位于 `Volume Processing` 节点
- 顶部页签为：
  - `Post Process`
  - `Post Modulation 1`
  - `Slicing Mask`
- `Post Process` 当前模式为 `Dilate`
- 可见参数包括：
  - `Smoke dilate = 105.000 %`
  - `Temperature dilate = 100.000 %`
  - `Flames dilate = 395.000 %`
  - `Fuel dilate = 100.000 %`
  - `Dilate softness = 0.000 %`
- `Post Modulation 1` 当前未启用
- 左侧统计可见：
  - `Bounds = 384x384x384`
  - `Voxels = 56.6 Mvox`
  - `Resolution = 2261x1543`
  - `Render Time = 50.6 ms`
  - `Particles = 29.3 K`
- 时间线左侧当前参数包括：
  - `Smoke rate = 531.973 %/s`
  - `Additional pressure rate = 100.000 %/s`
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 25.000`
  - `Temperature Diffusion = 25.000 m/s`
  - `Motion blur intensity = 0.000 %`

输出/预览
- 左侧爆炸中心明亮、外围烟团厚实，说明 `Flames dilate` 被显著放大，而烟雾和温度通道只做了较保守的膨胀
- 这张补图的作用，是把教程口头提到的“关闭额外噪声并调整后处理”落实到具体参数值上，便于后续复刻同类爆炸体积外观

### S02 00:07:24

这张补充截图展示 `boom.ember` 中 `Emitter: Volume` 的参数细节，用来补充说明主爆炸在烟雾、温度和附加压力上的具体发射设置

节点定义集
- 当前工程名：`boom.ember`
- 当前选中节点：`Emitter: Volume`
- 可见相关节点：
  - `Shape: Primitive`
  - `Force: Line`
  - `Simulation`
  - `Shading`
  - `Scene`
  - `Render`
  - `Volume Processing`
  - `Emitter: Particles` 两个分支
- 左侧视口中的爆炸此时较暗，主要用于观察模拟扩散行为而不是最终着色

连线集
- `Shape: Primitive` 与 `Force: Line` 等输入接到 `Emitter: Volume`
- `Emitter: Volume` 输出连接到 `Simulation`
- `Simulation` 再把结果送往 `Scene` 和 `Render`
- 说明这里是主爆炸体积源头的参数定义处

设置/参数
- 当前位于 `Emitter: Volume` 面板
- 顶部标签包括：
  - `Activity`
  - `Transform`
  - `Emission`
  - `Pressure`
  - `Forces`
  - `Visuals`
- `Transform` 分组可见：
  - `Position X = 0.000 m`
  - `Position Y = 0.000 m`
  - `Position Z = 0.000 m`
  - `Rotation X = 0.000°`
  - `Rotation Y = -0.000°`
  - `Rotation Z = 0.000°`
- `Emission` 分组可见：
  - `Fuel emission = No Emission`
  - `Smoke emission = Add`
  - `Smoke rate = 593.755 %/s`
  - `Temperature emission = Replace`
  - `Temperature = 4100.000 K`
  - `Emission gradient = 22.333`
- `Pressure` 分组可见：
  - `Additional pressure rate = 100.000 %/s`
  - `Pressure random seed = 45275`
  - `Pressure random speed = 0.400`
- 左侧统计可见：
  - `Bounds = 384x384x384`
  - `Voxels = 56.6 Mvox`
  - `Resolution = 2030x1543`
  - `Render Time = 28.7 ms`
  - `Particles = 29.3 K`
- 时间线左侧还能看到配合参数：
  - `Smoke dissipation = 0.000 units/s`
  - `Vorticity intensity = 22.056`
  - `Temperature Diffusion = 10.000 m/s`
  - `Motion blur intensity = 0.000 %`

输出/预览
- 左侧视口中的烟团处于较暗的中段状态，说明教程这里是在检查主体爆炸如何从发射器参数出发逐步扩散，而不是看最终高亮火焰
- 这张补图的价值在于把主爆炸最关键的一组发射参数固定下来，便于后续在 Unreal 或其他变体工程中复用同样的体积源头

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


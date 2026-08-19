# 12-3 制作Niagara粒子特效

# 12-3 制作Niagara粒子特效

## 关键术语

- `材质`、`粒子`、`生命周期`、`速度`、`曲线`、`+Add`、`Bounds`、`lce_Mesh.01`、`Niagara`、`Normalized Age`、`Add`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`

## 分段知识

### 00:00:00-00:04:56 速度、颜色

- 本段定位：速度、颜色。
- 知识点：这程度放在 速度也似乎适当 只要把这个颜色感适当做得白一点 怎么样呢 0.8 1.2 感觉蓝色多一点 然后 刚开始有点亮 最终值会出来 需要把原始值适当做得白一点。
- 知识点：相反 要下值适当随机 降低同时随机 这样感觉 现在前面适当没有一些分布的例子 适当把下底拉前一点 但反正也是辅数性 如果不突兀仅仅是营造气氛就好。
- 知识点：在这种情况下可以叠加使用 稍后复制一下 感受一下 做成加法 然后保存 连接着 感觉像是混合得更好 数量适当增加一下吧 好 请为 不那么远地出发 给予随机值。
- 知识点：大约80 不能太少 把这个减少到大约50 感觉十次更好 在这种情况下适当降低一下 这样看起来不错 适当多一点。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Scale Velocity` 速度衰减复核
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 继续调整烟雾速度，让烟雾从较高速度快速减弱。
>
> Niagara Preview:
> - 左侧预览区当前几乎为空，粒子计数中多个 emitter 处于 Complete。
> - `Smoke_01` 显示 `0 Current, 20 Max (est.)`，状态 Complete。
> - `Empty` 显示 Active。
>
> System Overview:
> - 可见 `Ice_Mesh_01` 和 `Smoke_01`。
> - `Smoke_01` 为 CPU emitter。
> - `Smoke_01.Scale Velocity` 被选中。
> - `Smoke_01` Stack 包含 `Shape Location Ring / Disc`、`Add Velocity From Point`、`Sub UV Animation Linear`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
>
> Details:
> - Owner: `Smoke_01`。
> - `Coordinate Space = Local`。
> - `Velocity Scale = Multiply Vector by Float`。
> - Vector = `1.0, 1.0, 1.0`。
> - Float 使用 `Float from Curve`。
> - 曲线由 `PARTICLES NormalizedAge` 驱动。
> - 曲线从约 `7.0` 下降到 `0.0`，前段下降快，后段趋近 0。
>
> Timeline:
> - 当前时间约 `7.11` 秒。
>
> 画面含义: 该帧记录烟雾速度衰减曲线在 p17 开头继续作为速度调节基础。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Sprite Renderer` 与烟雾叠加预览
> - 组成部分: Niagara Preview + System Overview + Sprite Renderer Details + Content Browser + Timeline
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 检查烟雾 Sprite Renderer 叠加到冰刺环后的混合状态。
>
> Niagara Preview:
> - 预览中白蓝冰刺环仍可见，中心留有暗色空洞。
> - 冰刺外侧叠加灰白雾状层，整体比单独冰刺更柔和。
> - `Smoke_01` 显示 `20 Current, 20 Max (est.)`，状态 Active。
>
> System Overview:
> - 可见 `Ice_Mesh_01` 与 `Smoke_01` 两个主要 emitter。
> - `Smoke_01.Sprite Renderer` 被选中。
> - `Smoke_01` Stack 中 `Sub UV Animation Linear`、`Scale Velocity`、`Scale Color`、`Sprite Renderer` 均可见。
>
> Details:
> - Owner: `Smoke_01`。
> - `Sprite Renderer` 面板可见。
> - 可见属性组包括 `Sprite Rendering`、`Sorting`、`Visibility`、`Sub UV`、`Bindings`、`Cutout`、`Scalability`、`Rendering`。
> - Material 字段所在区域可见但当前帧未确认具体材质值。
>
> Curves:
> - 左下曲线面板显示 FloatCurve 从约 `2.0` 快速下降到接近 `0.0`。
>
> 画面含义: 该帧记录烟雾 Sprite Renderer 已参与渲染，并与冰刺环叠加成更柔和的白蓝烟雾外观。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Scale Color` RGB 与 Alpha 曲线
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 将烟雾颜色调整为更偏白、略带蓝色，并让透明度随生命周期下降。
>
> Niagara Preview:
> - 预览为白蓝冰刺环和淡灰白烟雾层。
> - `Smoke_01` 显示 `30 Current, 30 Max (est.)`，状态 Inactive。
>
> System Overview:
> - `Smoke_01.Scale Color` 被选中。
> - `Smoke_01` Stack 中 `Sub UV Animation Linear`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` 可见。
>
> Details:
> - Owner: `Smoke_01`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB = Multiply Vector by Float`。
> - RGB Vector = `0.8, 1.0, 1.2`。
> - RGB Float 使用 `Float from Curve`。
> - RGB Float 曲线由 `PARTICLES NormalizedAge` 驱动，从高值快速下降并在后段保持低值。
> - `Scale Alpha = Float from Curve`。
> - Alpha 曲线由 `PARTICLES NormalizedAge` 驱动，从接近 `1.0` 下降到接近 `0.0`。
> - 下方可见 `Random Range Float`，Minimum = `0.5`，Maximum = `0.75`，`Evaluation Type = Spawn Only`。
>
> 画面含义: 该帧记录烟雾颜色调整为偏白蓝的向量，并使用颜色/Alpha 曲线控制快速消退。

### 00:04:56-00:09:53 颜色

- 本段定位：颜色。
- 知识点：似乎也可以更快消失 还有尘埃已经添加了 然后碎片也会再添加 在第二次释放中制作过的 在爆炸中使用的石头网的感觉 会复制这个碎片带过来。
- 知识点：不需要的模块删除掉 再适当多撒一点这个 一次性出来的东西 代替地颗粒适当减小一下 感觉 给15到30左右 钟声时间似乎可以不改变 比起阴暗位置更广泛。
- 知识点：首先想要添加 感觉更强的东西 这似乎不需要太突出的上方 会适当更快下落 只是颜色现在适当 按照比例颜色。
- 知识点：35 30 做什么 啊 太虚弱 似乎可以到这种程度 降低到10左右 代替地扩大这个区域 可能更好 刺伸出位 到一定程度要对齐 由于刺而产生的感觉 做这个会更好。
- 知识点：让它传播得更远 好像颗粒太大了 这种张力不是更好吗 没必要 所以需要关掉 现在差不多快完成了 只要加入火花调料元素 添加些许摇动就可以结束了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Scale Color` 系统布局复核
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 在加入碎片前复核烟雾颜色曲线和当前系统中多个 emitter 的布局。
>
> System Overview:
> - 视图缩放较远，可见 `Decal`、`Ice_Mesh_01`、`Smoke_01`、`Empty` 以及下方多个 Debris emitter 区域。
> - `Smoke_01.Scale Color` 仍被选中。
>
> Details:
> - Owner: `Smoke_01`。
> - `Scale Mode = RGB and Alpha Separately`。
> - RGB Vector = `0.8, 1.0, 1.2`。
> - RGB Float 使用 `Float from Curve`，曲线从高值下降。
> - `Scale Alpha` 使用 FloatCurve，从约 `1.0` 下降到接近 `0.0`。
> - `Random Range Float` 可见，Minimum = `0.5`，Maximum = `0.75`，`Evaluation Type = Spawn Only`。
>
> Timeline:
> - 当前时间约 `5.84` 秒。
> - `Decal` 轨道在前段绿色片段附近。
>
> 画面含义: 该帧记录烟雾颜色曲线已确定，并显示系统中将继续加入碎片 emitter 的布局状态。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01001.Scale Color` 碎片颜色
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: `Exp_01 / Debris_01001`。
> - 目的: 为新复制的碎片 emitter 设置高强度蓝白颜色。
>
> Particle Counts:
> - `Debris_01001` 显示 `0 Current, 100 Max (est.)`，状态 Complete。
> - `Smoke_01` 显示 `0 Current, 30 Max (est.)`，状态 Complete。
>
> System Overview:
> - 可见 `Smoke_01` 与 `Debris_01001`。
> - `Debris_01001` 为 CPU emitter。
> - Stack 中包含 `Initialize Particle`、`Shape Location Ring / Disc`、`Add Velocity From Point`、`Add Velocity 001 Linear`、`Sub UV Animation Random`、`Gravity Force`、`Collision`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
> - `Scale Color` 被选中。
>
> Details:
> - Owner: `Debris_01001`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB` 启用。
> - RGB Vector = `5.0, 15.0, 30.0`。
> - `Scale Alpha = 1.0`。
>
> Timeline:
> - `Debris_01001` 轨道为蓝色长片段。
> - 当前时间约 `8.06` 秒。
>
> 画面含义: 该帧记录新碎片 emitter 的颜色强度设置，用更强的蓝白发光值让碎片在冰爆中可见。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01001` 关卡播放后状态
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Debris_01001`。
> - 目的: 检查碎片/烟雾层播放后是否只留下轻微残留。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 棋盘地面清晰可见。
> - 角色附近仅有少量淡灰白烟雾或粒子残留。
> - 没有大面积冰刺环或高亮碎片覆盖。
>
> Content Browser:
> - 当前位于 `Content/Coloso_Second/Particle/02`。
> - `Exp_01` Niagara System 资源被选中。
>
> Outliner:
> - 世界为 `03_Ice_Explosion`。
> - 可见 `DirectionalLight`、`01_Swing_Trail`、`Aurora`、`Cine Camera Actor`、`Floor` 等对象。
>
> Niagara 窗口边缘:
> - 下方 Details 仍选中 `Debris_01001`。
> - `Debris_01001` 显示 `0 Particles`。
>
> 画面含义: 该帧记录碎片/烟雾层在生命周期结束后的弱残留状态，作为颜色与数量调整后的关卡检查。

### 00:09:53-00:14:33 生命周期、速度、颜色

- 本段定位：生命周期、速度、颜色。
- 知识点：需要按预计来使用这个摇动 去掉不必要的部分 将生成数量多喷洒一些 生命周期大约2秒 只提升到20 然后这个尺寸先放着 而且感觉太往上升了。
- 知识点：希望能扩散得更远 感觉从缩放速度调整 会比较好 在Z轴上一开始不要往上升太多 后面再让它往上升的多一些 把这一部分改成曲线 从1.5开始逐渐往上升。
- 知识点：整体张力就从4开始逐渐减小的感觉 感觉不需要太往上升 这种感觉 长度会适当缩短一些 感觉像雪的感觉少了一些 需要调整颜色一次 打圆水 也很开心。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Exp_01` Debris emitter 布局复核
> - 组成部分: Niagara Preview + System Overview + Timeline + 曲线面板
> - 所属: `Exp_01` Niagara System。
> - 目的: 在调整碎片生命周期、速度和颜色前，检查多个 Debris emitter 的系统布局和粒子状态。
>
> Niagara Preview / Particle Counts:
> - 当前预览区几乎为空。
> - `Smoke_01` 显示 `30 Current, 30 Max (est.)`，状态 Inactive。
> - `Debris_01001` 显示 `100 Current, 100 Max (est.)`，状态 Inactive。
> - `Debris_01002` 显示 Complete。
> - `Ice_Mesh_01` 显示 Complete。
> - `Empty` 显示 Active。
>
> System Overview:
> - 视图缩放较远，能看到 `Empty`、`Debris_01002` 和多个 Debris emitter 卡片。
> - 卡片分布表明当前系统已经加入多个附加粒子层。
>
> Timeline:
> - 当前时间约 `2.48` 秒。
> - `Debris` 和 `Decal` 轨道位于前段绿色片段附近。
>
> 画面含义: 该帧记录 p17 后半段开始时的系统布局和粒子状态，为后续 Debris 速度/颜色曲线调整提供上下文。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002.Scale Velocity 001`
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 调整碎片速度缩放，让其中一个分量随生命周期上升，同时保留另一条速度强度衰减曲线。
>
> Particle Counts:
> - `Debris_01002` 显示 `0 Current, 100 Max (est.)`，状态 Complete。
> - `Debris_01001` 显示 `1 Current, 1 Max (est.)`，状态 Active。
>
> System Overview:
> - `Debris_01002` 为 GPU emitter。
> - Stack 中可见 `Initialize Particle`、`Shape Location Sphere`、`Add Velocity From Point`、`Add Velocity 001 Linear`、`Particle State`、`Scale Sprite Size 001`、`Scale Velocity 001`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
> - `Scale Velocity 001` 被选中。
>
> Details:
> - Owner: `Debris_01002`。
> - `Coordinate Space = Local`。
> - `Velocity Scale = Multiply Vector by Float`。
> - Vector 使用 `Make Vector`。
> - X = `1.0`。
> - Y = `1.0`。
> - Z 使用 `Float from Curve`。
> - Z 曲线由 `PARTICLES NormalizedAge` 驱动，从约 `0.5` 上升到约 `5.0`。
> - 下方另一个 Float 曲线从约 `6.0` 降低到接近 `0.0`。
>
> Timeline:
> - 当前时间约 `6.84` 秒。
> - `Debris_01002` 轨道为蓝色长片段。
>
> 画面含义: 该帧记录 `Debris_01002` 的速度缩放被拆成向量分量和 Float 曲线，控制碎片运动随生命周期变化。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` 调整后的关卡预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Debris_01002`。
> - 目的: 检查碎片/烟雾增加后的整体亮度和覆盖范围。
>
> Level Viewport:
> - 角色位于冰爆中心偏上区域。
> - 中心区域被高亮白色烟雾覆盖，局部能看到角色轮廓。
> - 外圈有浅蓝冰刺和白色雾状扩散。
> - 地面格线在外圈仍可见。
> - 效果中有少量小白点/碎片散布在冰雾上方。
>
> Content Browser:
> - 位于 `Content/Coloso_Second/Particle/02`。
> - `Exp_01` Niagara System 被选中。
>
> Niagara 窗口边缘:
> - 下方 Details 仍选中 `Debris_01002`。
> - `Debris_01002` 显示 `0 Particles`。
>
> 画面含义: 该帧记录碎片速度/颜色调整后的整体预览，中心亮度和烟雾覆盖明显增强。

### 00:14:33-00:19:16 材质、粒子

- 本段定位：材质、粒子。
- 知识点：现在效果几乎完成了 最后只需添加震动并结束 在22阵中现在有粒子出现 可以在同一阵中放震动 使用2号 现在摄像头似乎有点翘 我试着放1号。
- 知识点：1号适当弱了一点 比起2号太强 1号似乎更好 本来考虑的概念大致上是 想要一种平滑展开的感觉 而不是爆炸感 刺虽然集中得非常强 但是 给延迟时间再多一点也是方法。
- 知识点：这种程度的刺痛感 有点提前出现的感觉 好像适当好一点 适当再增加一点 或者说让维C的延长时间 适当增加一点也是方法 这样看着抓住眼睛里刺人的部分。
- 知识点：一个一个地 处理是挺重要的 所有时机集中在一个点上 那样也会互相太拥挤 导致彼此需要表现的张力感 消失的情况 彼此的存在 能够良好融合实至最好的状态。
- 知识点：我尝试做到的第三个粒子 好像完成的都不错 那么这次呢就到这里 我觉得冰网的材质 其实有很多种不同的案例 如果想要更加明显的半透明效果。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 近完成状态关卡预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘 + 字幕
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01 / Debris_01002`。
> - 目的: 检查添加震动前的最终粒子组合效果。
>
> Level Viewport:
> - 角色站在淡蓝白冰雾中心。
> - 大面积 Decal/烟雾覆盖地面，表面有多个深浅不一的圆形凹状纹理。
> - 冰刺层较前段收敛，只在外圈和局部区域可见。
> - 周围散落许多小白色碎片点。
> - 地面格线在外圈和半透明区域仍可见。
>
> Content Browser:
> - `Exp_01` Niagara System 资源被选中。
>
> Niagara 窗口边缘:
> - 下方 Details 仍显示 `Debris_01002`。
>
> 字幕:
> - 字幕文字为“最后只需添加震动并结束”。
>
> 画面含义: 该帧记录粒子主体基本完成，后续只需加入镜头/序列震动作为收尾。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002.Scale Color` 收尾调色
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 降低或调整碎片颜色强度，使附加碎片与整体冰雾融合。
>
> Particle Counts:
> - `Debris_01002` 显示 `0 Current, 500 Max (est.)`，状态 Complete。
> - `Debris_01001` 显示 `0 Current, 100 Max (est.)`，状态 Complete。
> - `Empty` 显示 Active。
>
> System Overview:
> - 当前选中 `Debris_01002.Scale Color`。
> - `Empty` emitter 位于中央。
>
> Details:
> - Owner: `Debris_01002`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB = Multiply Vector by Float`。
> - RGB Vector = `0.5, 7.0, 10.0`。
> - RGB Float 使用 `Float from Curve`。
> - RGB Float 曲线由 `PARTICLES NormalizedAge` 驱动，从接近 `1.0` 降到约 `0.2`。
> - `Scale Curve` 字段显示 `300.0`。
> - `Scale Alpha = Float from Curve`。
> - Alpha 曲线从接近 `1.0` 下降到接近 `0.0`。
> - 下方可见 `Random Range Float`，Minimum = `1.0`，Maximum = `1.0`。
>
> Curves:
> - 左下曲线面板显示另一条 FloatCurve 从约 `0.0` 上升到约 `3.0`。
>
> 画面含义: 该帧记录 Debris 收尾调色：颜色偏蓝白，亮度/透明度随生命周期下降。
> 图表转写（UE-GTXT v4）
> - 类型: 最终效果与 Sequencer/Shake 资源选择
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡、`Exp_01` Niagara System、Sequencer 资源目录。
> - 目的: 记录 p17 结束时的完整粒子外观和震动资源选择上下文。
>
> Level Viewport:
> - 角色站在蓝白冰雾中心。
> - 冰刺围绕角色形成环状层，密度中等，外圈有多个长尖刺。
> - 冰雾/Decal 覆盖中心地面，亮度较柔和。
> - 小白色碎片散布在冰雾外围和上方。
> - 地面格线在外圈清晰可见，效果整体仍保持半透明融合。
>
> Content Browser:
> - 当前位于 `Content/Coloso_Second/Sequencer`。
> - 可见 `Ex_01`、`Ex_02`、`Ex_03_Ice...`、`Ex_04...`、`Ex_05...`、`Ex_06...`、`Ex_07_Fire...`、`Ex_08...` 等 Level Sequence。
> - 下方可见 `ExShake_01`、`ExShake_02`、`ExShake_03`、`ExShake_04` Blueprint Class 资源。
> - `ExShake_01` 被选中。
>
> Niagara 窗口边缘:
> - 下方仍打开 `Exp_01` Niagara System。
> - Details 边缘选中 `Ice_Mesh_01`，显示 `0 Particles`。
>
> 画面含义: 该帧记录 p17 的最终视觉：冰刺、烟雾、碎片、Decal 和震动资源选择已进入收尾状态。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


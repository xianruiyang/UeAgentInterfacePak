# 13 - GPU 精灵

# 13 - GPU 精灵

## 关键术语

- `GPU`、`CPU`、`材质`、`粒子`、`发射器`、`系统`、`渲染器`、`精灵`、`碰撞`、`速度`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Particle Update`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:04-00:03:38 GPU、CPU、材质

- 本段定位：GPU、CPU、材质。
- 知识点：是因为我们使用的材质 到目前为止,我们只使用了所谓的CPU精灵 首先,所有的粒子,他们都是在CPU上生成的。
- 知识点：左边的是,这是CPU精灵右边的是 这是GPU精灵 所以两者之间唯一的区别是 CPU精灵完全在CPU上处理 而GPU精灵完全在GPU上处理。
- 知识点：使用GPU精灵的许多好处之一是 不涉及GPU的情况下,可以处理 成千上万个粒子 比CPU更多的粒子,太多性能损失。
- 知识点：现在你可能会想 这是否意味着我们应该一直使用GPU精灵 其实不是这种 因为,某些模块仅适用于CPU 如果你选择了一个模块 不支持在CPU或GPU上运行。
- 知识点：另一个需要称之为05GPU 精灵并双击打开像往常一样 创建一个Negra系统 选择这个简单的精灵爆发作为我们的发射器。
- 知识点：并将其命名为GPU 精灵并双击打开它 首先为了使用GPU精灵 可以在这些属性中设置它 点击它之后 可观察到这里的相同目标被设置为CPU。
- 知识点：我们还需要更改这个计算反弹模式 所以我们需要将其从动态更改为固定 现在可观察到那个警告消息消失了 原因是 那是因为在后续会粒子设置为在GPU上处理之后。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`CPU`、`材质`、`粒子`、`发射器`、`系统`、`渲染器`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: UE 关卡视口 + 教学文字 + 内容浏览器状态
> - 组成部分: 效果图、屏幕文字、Content Browser、Place Actors 面板。
> - 所属: `NiagaraBasic / 04-Forces / NS_Forces`
> - 目的: 以上一节的力场粒子效果作为 GPU Sprites 课程的引入案例。
>
> 可读文字:
> - 标题: `Forces`
> - 说明: `When are forces applied: Applied in particle update stage`
> - 使用的力: `Curl Noise Force / Drag / Vortex Velocity`
>
> 视觉状态:
> - 关卡展示一个白色粒子团，粒子集中在显示屏中部附近，呈被力场扰动后的散布状态。
> - Content Browser 路径显示在 `Content > Niagara > NiagaraBasic > 04-Forces`，选中资产为 `NS_Forces`。
>
> 联动关系: 该图不是当前 GPU 设置步骤，而是回顾前一节 `Particle Update` 中通过力模块实现粒子运动；后续 GPU Sprites 会在更大量粒子的前提下复用类似的力模块思路。
> 图表转写（UE-GTXT v4）
> - 类型: CPU/GPU Sprites 对比教学图
> - 组成部分: 标题、左右对比缩略图、要点文字。
> - 所属: GPU Sprites 概念说明。
> - 目的: 对比 CPU Sprites 与 GPU Sprites 的处理位置、模块限制和粒子数量能力。
>
> 对比表:
> | 项 | CPU Sprites | GPU Sprites |
> |---|---|---|
> | 处理位置 | `Processed entirely on CPU` | `Processed entirely on GPU` |
> | 生成说明 | 标题区写明 `Particles are spawned on CPU` | 粒子仍由 CPU 侧发起生成语义，但模拟处理放到 GPU |
> | 模块限制 | `Certain modules are only available to CPU` | 部分 CPU 专用模块不可用 |
> | 数量优势 | 适合常规数量 | `Can process thousands more particles` |
>
> 联动关系: 该图解释为什么后续要把 `Emitter Properties.Sim Target` 切换为 GPU 计算，并同时保留对 CPU 专用模块限制的注意。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + Selection 属性图 + Preview
> - 组成部分: System Overview、Emitter Stack、`Spawn Burst Instantaneous` 属性、Preview 粒子状态、Parameters 面板。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst`
> - 目的: 展示 `NS_GPUSprites` 初始发射器栈，并定位当前仍在使用的 `Spawn Burst Instantaneous` 模块。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 |
> |---|---|---|---|
> | 左侧 Preview | 效果图 | `NS_GPUSprites` 预览 | 一个白色 Sprite 粒子；红字提示视频内存超预算 |
> | 中央 System Overview | Niagara Stack | `NS_GPUSprites / SimpleSpriteBurst` | System、Emitter、Particle、Render 层级 |
> | 右侧 Selection | 属性图 | `Spawn Burst Instantaneous` | `Spawn Count=1`, `Spawn Time=0.0`, `Spawn Probability=1.0`, `Loop Count Limit=1` |
> | 左下 Parameters | 参数面板 | `User Parameters` | 面板可见但无新增 User 参数 |
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | System | `NS_GPUSprites` | Enabled | `System State` 可见 | System 容器 |
> | 2 | Emitter Update | `Emitter State` | Enabled | `Self`, `Infinite` | 发射器持续运行 |
> | 3 | Emitter Update | `Spawn Burst Instantaneous` | Enabled | `Spawn Count=1`, `Spawn Time=0.0` | 初始瞬时生成 1 个粒子 |
> | 4 | Particle Spawn | `Initialize Particle` | Enabled | 未展开 | 初始化粒子 |
> | 5 | Particle Update | `Particle State`, `Scale Color`, `Solve Forces and Velocity` | Enabled | 未展开 | 生命周期状态、颜色缩放和力求解 |
> | 6 | Render | `Sprite Renderer` | Enabled | 未展开 | 使用 Sprite 渲染粒子 |
>
> 效果/预览:
> - 观察对象: `NS_GPUSprites` 预览视口。
> - 可读状态: 当前只看到一个白色 Sprite，符合 `Spawn Burst Instantaneous` 的 `Spawn Count=1`。
> - 验证方式: 在 Selection 中读回 `Spawn Count` 与预览粒子数量级是否一致；红色内存提示不作为本节 GPU 设置参数。

### 00:03:41-00:06:16 GPU、CPU、粒子

- 本段定位：GPU、CPU、粒子。
- 知识点：并且需要把数字改为1000 所以需要有1000个由这个模块生成的粒子 另一个由这个模块生成的3000个粒子。
- 知识点：这将完全 如果这是一个CPUSI-M 将完全杀死我们的信仰 但信的是我们有GPUSI-M 现在转到这个初始化粒子。
- 知识点：对于它的生命周期 而不是直接设置 需要其设置为随机 所以目标是我的一些粒子能存活 三秒其他的 存活五秒 好的类似这种 他们的大小需要设定为1.5。
- 知识点：需要添加另一个模块 因为所有的粒子都聚集在一起 需要使用形状位置 现在可观察到这里有很多粒子。
- 知识点：对于球体半径 从100改为15 现在他们都将从 这个小球体中生成 好的这些就是 需要在这个阶段设置的一切 现在进行粒子更新。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`CPU`、`粒子`、`发射器`、`生命周期`、`曲线`、`噪声`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + `Spawn Rate` 属性图 + Preview
> - 组成部分: Emitter Stack、Selection 属性、Tooltip、Preview 粒子亮度状态。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst`
> - 目的: 将粒子生成从单次 Burst 扩展为持续 Spawn Rate，以形成 GPU 粒子数量压力。
>
> 模块栈变化:
> | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---|---|---|---|---|
> | Emitter Update | `Spawn Rate` | Enabled/选中 | `SpawnRate=1000.0` | 每秒持续生成大量粒子 |
> | Emitter Update | `Spawn Burst Instantaneous` | Enabled | Tooltip: `Spawns a burst of particles instantaneously.` | 仍保留瞬时生成模块 |
> | Particle Spawn | `Initialize Particle` | Enabled | 未展开 | 负责新生粒子初始化 |
> | Particle Update | `Scale Color`, `Solve Forces and Velocity` | Enabled | 未展开 | 更新颜色与速度求解 |
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `SpawnRate.SpawnRate` | `1000.0` | float / particles per second | Selection | 增加持续生成密度 |
> | `SpawnRate.Spawn Probability` | `1.0` | float | Selection 灰置 | 生成概率显示为默认值 |
>
> 效果/预览: Selection 顶部显示约 `5,600 Particles`，左侧预览因大量白色粒子叠加而出现高亮区域。验证时读回 `SpawnRate=1000.0`，并确认粒子数不再是单个 Burst 的数量级。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + 曲线属性图 + Preview
> - 组成部分: `Scale Sprite Size` Selection、Curve 编辑器、Emitter Stack、Preview。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Scale Sprite Size`
> - 目的: 用 `Scale Sprite Size` 在粒子生命周期中调整 Sprite 尺寸。
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Scale Sprite Size.Scale Sprite Size Mode` | `Uniform Curve` | enum | Selection | 使用统一曲线控制尺寸缩放 |
> | `Scale Sprite Size.Uniform Curve Sprite Size` | `Curve for Floats` | curve | Selection | 由曲线驱动尺寸 |
> | `Scale Sprite Size.Uniform Curve Index` | `Particles.NormalizedAge` | Niagara parameter | Selection | 按归一化生命周期取曲线值 |
> | `Scale Sprite Size.Uniform Curve Scale` | `1.0` | float | Selection | 曲线缩放系数 |
>
> 曲线可读状态:
> - 曲线编辑器显示从接近 `0` 逐步上升的红色曲线。
> - 鼠标悬停的模板为 `Smooth Ramp Down`，该模板是可选曲线预设，不等同于当前已确认的最终曲线。
>
> 联动关系: `Particles.NormalizedAge` 作为横轴索引，决定粒子在生命周期内的 Sprite 尺寸变化；左侧预览中单个白色粒子用于验证尺寸调整结果。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + Point Attraction Force 属性图 + Preview
> - 组成部分: Emitter Stack、`Point Attraction Force` Selection、Preview 粒子运动结果。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Point Attraction Force`
> - 目的: 添加吸引力模块，把粒子位置吸向发射器模拟位置，形成被拉拢的粒子束。
>
> 模块栈:
> | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---|---|---|---|---|
> | Particle Spawn | `Shape Location` | Enabled | `Sphere` | 从球形区域生成粒子 |
> | Particle Update | `Curl Noise Force` | Enabled | 未展开 | 给粒子引入噪声扰动 |
> | Particle Update | `Point Attraction Force` | Enabled/选中 | 见属性表 | 将粒子吸向指定位置 |
> | Particle Update | `Drag` | Enabled | 未展开 | 阻尼运动 |
> | Particle Update | `Solve Forces and Velocity` | Enabled | 未展开 | 求解力和速度 |
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `PointAttractionForce.Attraction Strength` | `4.0` | float | Selection | 吸引强度 |
> | `PointAttractionForce.Attraction Radius` | `100.0` | float | Selection | 吸引半径 |
> | `PointAttractionForce.Falloff Exponent` | `0.5` | float / enabled | Selection | 控制吸引衰减 |
> | `PointAttractionForce.Attractor Position Offset` | `0,0,0` | vector / disabled | Selection | 未启用偏移 |
> | `PointAttractionForce.Kill Radius` | `4.0` | float / disabled | Selection | 未启用半径杀死 |
> | `PointAttractionForce.Position To Attract` | `Particles.Position` | Niagara attribute | Selection | 被吸引的粒子位置 |
> | `PointAttractionForce.Attractor Position` | `Engine.Emitter.SimulationPosition` | Niagara attribute | Selection | 吸引目标位置 |
>
> 效果/预览: 左侧预览显示大量白色粒子被拉成向一侧集中的束状。空间/坐标说明: 图中只显示属性来源和视口结果，不额外断言坐标系。

### 00:06:19-00:11:00 Niagara、GPU、粒子

- 本段定位：Niagara、GPU、粒子。
- 知识点：我们有两个地方可以做到这一点 首先可以设置它的初始颜色 在这个初始化粒子模块中 所以可以在这里直接改变它的颜色。
- 知识点：但请记住这只会运行一次 设置颜色后 我们现在可以在这个阶段中更改它 在这个粒子更新中 有一个更强大的模块可以使用 需要点击这个应用按钮。
- 知识点：我们不再有比例颜色模块 所以需要删除它 这个模块将不断更新 意味着可以改变 粒子在他们的生命周期内的颜色。
- 知识点：改为动态输入 如果你点击这里的下拉菜单 可观察到所有可用的动态输入 可以使用的 通常建议的那些已经足够 所有我们想做的事情 所以需要选择这个曲线颜色。
- 知识点：可观察到我们得到了这个渐变图 默认有四个固定点 上面的这两个可以用来 控制颜色 下面的 这些是与不透明度相关的固定点 在5.1版本中。
- 知识点：这将是颜色 当不透明度为1时 所以让我们尝试改掉双击 打开对应资源固定点 可观察到我们得到了一个 所以颜色需要开始的颜色会是蓝色的。
- 知识点：点击确定 现在可观察到我们的粒子它没有颜色了 可观察到我们又有这个剑影效果 那是因为 当我们的粒子在世界中存在时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Niagara`、`GPU`、`粒子`、`发射器`、`系统`、`生命周期`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + Drag 属性图 + Preview
> - 组成部分: `Drag` Selection、Particle Update 栈、Preview 粒子数量状态。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Drag`
> - 目的: 在粒子更新阶段加入阻力，减缓前面力模块产生的运动。
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Drag.Drag` | `1.0` | float / enabled | Selection | 对粒子平移运动施加阻尼 |
> | `Drag.Rotational Drag` | `1.0` | float / enabled | Selection | 对旋转运动施加阻尼 |
>
> 模块联动:
> - `Point Attraction Force` 和 `Curl Noise Force` 先改变粒子运动趋势。
> - `Drag` 在同一 `Particle Update` 阶段削弱运动速度。
> - `Solve Forces and Velocity` 负责在后续求解这些力和速度。
>
> 效果/预览: Selection 顶部显示约 `12,124 Particles`，左侧预览中白色粒子束仍集中但运动被阻尼控制。空间/坐标说明: 只记录粒子视觉状态和模块顺序，不额外断言坐标系。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack + Color 曲线属性图 + Preview
> - 组成部分: `Color` Selection、`ColorCurve` 渐变编辑器、Particle Update 栈、Preview。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Color`
> - 目的: 用 `Color from Curve` 按粒子生命周期改变粒子颜色和透明度。
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Color.Color` | `Color from Curve` | dynamic input | Selection | 使用曲线驱动颜色 |
> | `Color.ColorCurve` | `Curve for Colors` | color curve | Selection | 颜色渐变资源/曲线 |
> | `Color.CurveIndex` | `Particles.NormalizedAge` | Niagara attribute | Selection | 按粒子归一化生命周期采样 |
>
> 曲线可读状态:
> - 渐变条显示从浅蓝色向透明棋盘背景过渡。
> - 上方为颜色控制点，下方为透明度控制点；图中可见当前曲线正在 `Gradient` 视图中编辑。
>
> 效果/预览: 左侧预览粒子由白色转为浅蓝/发光色，说明 `Color` 模块已在 `Particle Update` 中持续更新粒子颜色。
> 图表辅助转写（UE-GTXT v4，保留原图）
> - 类型: Niagara 最终效果预览
> - 组成部分: 关卡视口效果图、Content Browser 资产状态、Place Actors 面板。
> - 所属: `NiagaraBasic / 05-GPUSprites / NS_GPUSprites`
> - 保留原因: 该图用于确认 GPU Sprites 当前综合色彩、亮度和粒子团形态；粒子密度、发光范围和蓝黄混合外观属于本节效果判断的一部分，需看原图复核。
> - 可文字化内容: Content Browser 选中 `NS_GPUSprites`，路径为 `Content > Niagara > NiagaraBasic > 05-GPUSprites`；视口显示 `GPU Sprites` 标题板前方有蓝白核心、黄色散点和向外漂散的粒子团。
> - 观察点: 重点看粒子是否从单个白色 Sprite 发展为大量 GPU 粒子组成的发光束状效果，并确认颜色曲线已经影响最终可见颜色。

### 00:11:00-00:12:59 Niagara、GPU、粒子

- 本段定位：Niagara、GPU、粒子。
- 知识点：现在需要增加一点亮度 这样做非常简单 使用这个渐变编辑器 我们只需双击打开对应资源颜色选择器 到V字的位置 这里V表示数值 不是1 需要把它改为5。
- 知识点：现在可以看蓝色的亮度显着增加 我也将对绿色做同样的事情 所以不是1 可能是 3 对黄色 需要把它改为2 对于红色 可能是3 我只是随机选择数值。
- 知识点：随意尝试你自己的数值 现在我觉得这看起来更华丽了 比我之前的更好 所以在使用了GPU精灵盒 结合了多种粒之后 这是我们能想到的 现在如果你进入这个Niagara系统。
- 知识点：这个新系统从选择发射器开始 如果你再次查看所有这些模板 这些只是一些预 构建的发射器包含一些预设模块。
- 知识点：以这个喷泉发射器为例 为了让所有粒子像喷泉一样移动 它可能需要一个非常具体的形状位置 它需要一些非常特定的粒模块 这个悬挂的粒子也是一样。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Niagara`、`GPU`、`粒子`、`发射器`、`系统`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Color Picker + Niagara Stack + Preview
> - 组成部分: `Color` 模块 Selection、颜色选择器、渐变条、Preview。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Color.ColorCurve`
> - 目的: 调整颜色选择器中的 `V`/Value 来提高粒子颜色亮度。
>
> 可读设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Color.Color` | `Color from Curve` | dynamic input | Selection | 曲线驱动粒子颜色 |
> | `Color.ColorCurve` | `Curve for Colors` | color curve | Selection | 当前正在编辑的颜色曲线 |
> | `ColorPicker.sRGB Preview` | checked | bool | Color Picker | 以 sRGB 预览颜色 |
> | `ColorPicker.H` | `225.881424` | float | Color Picker | 当前颜色色相 |
> | `ColorPicker.S` | `0.957654` | float | Color Picker | 当前颜色饱和度 |
> | `ColorPicker.V` | `1.0` | float | Color Picker | 当前颜色亮度值，课程提示后续调高 |
> | `ColorPicker.Hex sRGB` | `3A8DFFFF` | color | Color Picker | 当前新颜色十六进制值 |
>
> 联动关系: 颜色选择器正在编辑 `ColorCurve` 上的蓝色控制点；提高 `V` 会增加该控制点对应生命周期段的发光亮度，左侧 Preview 用于确认粒子颜色变亮。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System 创建向导 + 关卡效果背景
> - 组成部分: `Pick a starting point for your system` 对话框、模板列表、Content Browser、背景 GPU Sprites 效果。
> - 所属: 新建 Niagara System 的模板选择界面。
> - 目的: 说明 Niagara 新系统可以从预制 Emitter 模板开始，而这些模板只是预设模块组合。
>
> 对话框状态:
> | 区域 | 可读项 | 状态/值 | 作用 |
> |---|---|---|---|
> | Source Filtering | `Show all`, `Niagara`, `Game`, `Plugins`, `Developer` | 可见 | 控制来源过滤 |
> | Library Filter | `Library Only` | checked | 只显示库内模板 |
> | Asset Type Filtering | `Templates`, `Parent Emitters`, `Behavior Examples` | `Templates` 选中 | 当前浏览模板 |
> | 模板列表 | `Dynamic Beam`, `Empty`, `Fountain`, `Hanging Particulates`, `Omnidirectional Burst` | 可见 | 可作为系统起点 |
> | 底部 | `Emitters to Add`, `Back`, `Finish`, `Cancel` | `Finish` 灰置 | 未添加 Emitter 前不能完成 |
>
> 背景状态: Content Browser 仍选中 `NS_GPUSprites`，视口中保留上一节 GPU Sprites 发光粒子效果，作为模板讨论前的结果参照。
> 图表辅助转写（UE-GTXT v4，保留原图）
> - 类型: Reflection Task 任务页 + 效果参照图
> - 组成部分: 标题、任务屏幕、GPU Sprites 效果参照、字幕问题。
> - 所属: GPU Sprites 课后复盘任务。
> - 保留原因: 该图要求读者根据最终粒子外观反推需要使用的力模块；粒子束的方向感、散点密度、亮度核心和拖散形态是任务判断依据，需保留原图辅助复核。
> - 可读文字: 标题 `Reflection Task`；屏幕标题 `GPU Sprites`；任务项 `When to use GPU Sprite:` 与 `Forces used here:`；字幕问题为“你用什么力量来实现这个效果”。
> - 可文字化结论: 任务要求填写 GPU Sprite 的适用场景，并根据图中的最终粒子形态回忆本节使用的 `Curl Noise Force`、`Point Attraction Force`、`Drag` 与 `Solve Forces and Velocity` 组合。
> - 观察点: 原图用于确认最终效果不是静态点云，而是高亮核心、黄色散点和外扩粒子共同形成的受力运动效果。

## 补充视觉证据

### S01 00:03:20

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Emitter Properties 属性图 + Stack + Preview
> - 组成部分: `Emitter Properties` Selection、Fixed Bounds 设置、Emitter Stack、Preview。
> - 所属: `NS_GPUSprites / SimpleSpriteBurst / Emitter Properties`
> - 目的: 记录启用 GPU Sprites 时必须修改的 `Sim Target` 和 Bounds 模式。
>
> 属性:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Emitter.Local Space` | unchecked | bool | Selection | 未启用本地空间 |
> | `Emitter.Determinism` | unchecked | bool | Selection | 未启用确定性随机 |
> | `Emitter.Interpolated Spawning` | checked | bool | Selection | 启用插值生成 |
> | `Emitter.Sim Target` | `GPUCompute Sim` | enum | Selection | 将粒子模拟切换到 GPU |
> | `Emitter.Calculate Bounds Mode` | `Fixed` | enum | Selection | 使用固定 Bounds，满足 GPU 模拟可见性要求 |
> | `Emitter.Fixed Bounds.Min` | `-100.0, -100.0, -100.0` | vector | Selection | 固定包围盒最小值 |
> | `Emitter.Fixed Bounds.Max` | `100.0, 100.0, 100.0` | vector | Selection | 固定包围盒最大值 |
> | `Emitter.Requires Persistent IDs` | unchecked | bool | Selection | 未要求持久 ID |
> | `Emitter.Combine Event Spawn` | unchecked | bool | Selection | 未合并 Event Spawn |
> | `Script.Category` | `Engine Provided` | enum | Selection | 使用引擎提供脚本分类 |
>
> 模块联动:
> - `Sim Target=GPUCompute Sim` 对应本节从 CPU Sprites 切换到 GPU Sprites。
> - `Calculate Bounds Mode=Fixed` 与 `Fixed Bounds` 数值用于避免 GPU 模拟因动态 Bounds 不可用而产生警告或可见性问题。
> - Stack 中 `SimpleSpriteBurst` 带有 `GPU` 标识，确认当前 Emitter 已处于 GPU 计算语境。
>
> 空间/坐标说明: 图中只给出 Bounds 数值和 GPU 模拟设置；未显示坐标转换节点，不额外断言坐标系。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


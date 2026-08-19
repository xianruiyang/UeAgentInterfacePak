# 10-1-Houdini烟雾模拟设置

# 10-1-Houdini烟雾模拟设置

## 关键术语

- `GPU`、`UV`、`Houdini`、`粒子`、`速度`、`纹理`、`扰动`、`破碎`、`烟雾`、`火焰`、`缓存`、`Niagara`、`Material`、`Niagara System`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`

## 分段知识

### 00:00:05-00:02:59 速度、纹理、烟雾

- 本段定位：速度、纹理、烟雾。
- 知识点：你好,在第十课里向你问好 那这次的话我们就来做第二个例子的模拟资源 大概会做两张纹理加上运动十张纹理一共要做四张纹理。
- 知识点：可以看作是烟雾的最基本构成 我们就开始吧 先做个几何体再加个预设 然后用BellowWinstWarp这个应用 在这里适当改一下数值应该没问题。
- 知识点：基本上可以看作是最基础的配置 一起看看各种字段和选项的作用 先从这里的环形图圆码开始用 作为圆码对象使用 上次我们用表面散射器作为光源。
- 知识点：现在制作了火源 这里用体积散射器可观察到空间里充满了电 所以现在创建了密度场模板和温度 进行了新的处理 所以两个值都暂时有笔记数字 然后呢。
- 知识点：用调整矢量作为速度场 像48125度降雨量作用调整矢量报告 任何时候感觉不一样 这个工程是单一感到速度是感病好。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`速度`、`烟雾`。

**关键画面：**

这张图是 `p15` 新案例的起始帧，当前软件已经切换到 Houdini，并且还没有开始搭建任何模拟节点。中间网络视图明确显示 `Indie Edition / Objects / Empty Network / Press Tab to Add Nodes`，左侧视口是默认透视网格地面，说明作者此刻还停留在 `/obj` 顶层，准备从最基础的对象和预设开始构建“速度、纹理、烟雾”所需的模拟资源。

`界面/结构`

- 当前软件：`Houdini Indie Limited-Commercial 20.5.445 - Py3.11`
- 当前网络上下文：`/obj`
- 中央网络区状态：`Empty Network`
- 左侧视口为默认 `Perspective` 视图，右上角显示 `No cam`
- 右侧参数区当前无对象被选中，底部提示 `No Operator Selected`
- 时间轴当前停在第 `1` 帧

`可见工具与工作区锚点`

- 顶部对象创建工具栏可见基础对象入口：
- `Box`
- `Sphere`
- `Tube`
- `Torus`
- `Grid`
- `Null`
- `Light`
- 视口左侧是 Houdini 常规交互工具列
- 底部包含 `Render Scheduler / Geometry Spreadsheet / Tree View` 等面板标签

`当前可确认含义`

- 教程还没有进入具体烟雾节点图，因此当前不能写出任何模拟网络连接、Pyro 参数或速度场设置。
- 这一帧的作用是确认新案例将从一个干净的 Houdini `obj` 场景起步，而不是在已有网络上直接修改。
- 结合正文“这次我们就来做第二个例子的模拟资源”“先做个几何体再加个预设”，这一帧就是正式建模/建模拟前的初始状态锚点。

`结果理解`

- 这张图对应的是“开始建立烟雾模拟资源工程”的起点，而不是具体实现步骤。
- 对复现者来说，最重要的信息是：教程从 Houdini 顶层空网络开始，因此后续出现的几何体、Pyro 预设、体积场和速度场都应理解为本案例中新建内容。
- 这张图的核心意义，是给后续每一个 Houdini 节点操作建立一个明确起点：当前工程还没有任何对象或网络，所有模拟构成都会从这里逐步添加。
这张图从空白 `obj` 场景推进到了一个可运行的 Houdini 烟雾模拟基础链。当前已经进入 `geo1` 几何体网络，并建立了从火源几何到 Pyro Solver 再到 Bake/Render 输出的完整主干。右侧参数页明确显示 `pyrosource1` 正在把火源几何散射成体积属性，模式切到 `Volume Scatter`，并生成 `Density` 与 `Temperature` 两个基础字段。字幕“现在制作了火源，这里用体积散射器可看到空间里充满了点”与当前视口中的点云形态完全一致。

`节点定义集`

- `smoke_base`
  - 节点类型：`Torus`
  - 作用：作为初始火源/烟源几何基础
- `pyrosource1`
  - 节点类型：`Pyro Source`
  - 作用：把源几何转换为可供 Pyro 使用的体积/属性输入
- `attribadjustvector_velocity`
  - 节点类型：`Attrib Adjust Vector`
  - 作用：后续用于调整速度向量字段
- `volumerasterizeattributes`
  - 节点类型：`Volume Rasterize Attributes`
  - 作用：把属性栅格化为体积字段
- `pyrosolver_billowy_smoke`
  - 节点类型：`Pyro Solver Billowy Smoke`
  - 作用：执行蓬松烟雾模拟
- `pyrolook_billowy_smoke`
  - 节点类型：`Pyro Bake Volume`
  - 作用：为最终体积外观/渲染做准备
- `RENDER_Billowy_Smoke`
  - 节点类型：`Null`
  - 作用：作为当前链路的输出/渲染锚点

`连线集`

- `smoke_base -> pyrosource1`
- `pyrosource1 -> attribadjustvector_velocity`
- `attribadjustvector_velocity -> volumerasterizeattributes`
- `volumerasterizeattributes -> pyrosolver_billowy_smoke`
- `pyrosolver_billowy_smoke -> pyrolook_billowy_smoke`
- `pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`

`设置/参数`

- 当前网络路径：`/obj/geo1`
- 当前选中节点：`pyrosource1`
- `Group Type = Guess from Group`
- `Initialize = 4`
- `Mode = Volume Scatter`
- 下拉选项中可见候选模式：
- `Surface Scatter`
- `Keep Input`
- `Volume Scatter`
- `Attributes = 2`
- 第 1 个属性：
- `Attribute = Density`
- `Default Value = 1`
- `Scale = 1`
- 第 2 个属性：
- `Attribute = Temperature`
- `Default Value = 1`
- `Scale = 1`

`输出/预览`

- 左侧视口中，`Torus` 形状已经被离散为一个中空环状点云，说明 `Volume Scatter` 正在把源几何内部/体积区域采样成大量点。
- 这种点云不是最终烟雾，而是为后续体积栅格化和 Pyro 求解准备的源分布。
- 当前视图已能直接说明：源并不是一个简单平面或球，而是一个环状火源基底。

`结果理解`

- 这张图把新案例从“空工程”推进到“已建立基础模拟链”的阶段，最重要的信息是整个 Houdini 链路已经成型。
- `Volume Scatter + Density/Temperature` 说明作者首先关心的是构建最基础的烟雾/热量源，而不是一开始就追求复杂速度扰动。
- 这张图的核心意义，是确认本案例的最初模拟输入来自一个 `Torus` 基底，并通过 `pyrosource1` 生成 `Density` 与 `Temperature` 两个关键场，为后续速度场、栅格化和 Pyro 解算做准备。
这张图把当前案例从“只有密度和温度源”推进到了“开始写入速度场”的阶段。选中的节点已经从 `pyrosource1` 切换到 `attribadjustvector_velocity`，右侧参数页明确显示作者正在修改向量属性 `v`。这说明教程开始把前面散射出来的点源进一步加工成带运动方向和噪声扰动的速度输入，从而为后续烟雾的膨胀、上升和翻卷打基础。

`节点定义集`

- `smoke_base`
  - 节点类型：`Torus`
- `pyrosource1`
  - 节点类型：`Pyro Source`
- `attribadjustvector_velocity`
  - 节点类型：`Attrib Adjust Vector`
  - 当前选中节点，用于修改速度向量属性
- `volumerasterizeattributes`
  - 节点类型：`Volume Rasterize Attributes`
- `pyrosolver_billowy_smoke`
  - 节点类型：`Pyro Solver Billowy Smoke`
- `pyrolook_billowy_smoke`
  - 节点类型：`Pyro Bake Volume`
- `RENDER_Billowy_Smoke`
  - 节点类型：`Null`

`连线集`

- `smoke_base -> pyrosource1`
- `pyrosource1 -> attribadjustvector_velocity`
- `attribadjustvector_velocity -> volumerasterizeattributes`
- `volumerasterizeattributes -> pyrosolver_billowy_smoke`
- `pyrosolver_billowy_smoke -> pyrolook_billowy_smoke`
- `pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`

`设置/参数`

- 当前网络路径：`/obj/geo1`
- 当前选中节点：`attribadjustvector_velocity`
- `Attribute Name = v`
- `Attribute Class = Point`
- `Component Scope = X / Y / Z`

`Pre-Process`

- `Enable Pre-Process` 已启用
- `Overwrite Initial Value` 已启用
- `Initial Value From = Constant Value`
- `Initial Vector = (0, 1, 0)`
- `Reverse Direction` 当前未启用
- `Make Vector Unit Length` 当前未启用

`Adjustment Value`

- `Adjust Value` 已启用
- `Adjustment to = Direction & Length`
- `Operation = Add`
- `Adjust with = Noise`
- `Range Values = Zero Centered`
- `Amplitude = 2`

`Noise Pattern`

- `Noise Type = Simplex`
- `Location Attribute = P`
- `Element Size = 2`
- `Offset = 0`
- `Use VEXpression` 当前未启用

`输出/预览`

- 左侧视口中，原本规则的环状点云已经变成一团被拉扯、撕裂的黄色向量显示形态，说明 `v` 属性已经不再是均匀静止值，而是带方向和噪声起伏的速度场。
- 左下 `Geometry Spreadsheet` 可见点级属性表，列中能看到 `density`、`pscale`、`temperature` 等字段，说明这一阶段处理的确实是源点属性而不是最终体积。

`结果理解`

- `Initial Vector = (0, 1, 0)` 表明速度场的基础方向先被设定为单一轴向的推进向量，然后再用噪声去打破它的整齐感。
- `Adjust with = Noise`、`Amplitude = 2`、`Element Size = 2` 说明作者要的不是完全平滑的统一流向，而是带有明显起伏和扰动的速度场，这与正文“用调整矢量作为速度场”的描述一致。
- 这张图的核心意义，是确认本案例真正开始建立烟雾的运动基础：前一张只解决“哪里有烟、哪里有温度”，而这一张开始解决“烟往哪里动、动得有多乱”。

### 00:03:03-00:05:48 UV、速度、烟雾

- 本段定位：UV、速度、烟雾。
- 知识点：现在在体积重构节点里 密度温度速度 全部用体积转换成体积对象来作为圆使用 现在试试看 可观察到这样转换后的样子 在球械器中也看看圆 比如说密度温度和速度。
- 知识点：这些是最基本的构成 这里如果加热火焰的话 就会多出一个叫火焰的场 如果不是的话 像爆炸的话就会多出几个场 比如分起之类的 可以理解为这样构成的。
- 知识点：最基本的场密度场温度场速度场的作用 然后密度 字面意思可以理解为烟雾的密度 空气中现在组成的烟 浓密度会组成多厚多浓 密度值低的话烟就会有点弱淡。
- 知识点：所以这个是持续添加的方式 就这样看就行 温度 是 温度场所以这烟要上升温度就得高 像烟是烧什么的时候会出烟 因此基本上需要温度场 基于温度场。
- 知识点：烟声高后就会降低 然后基于死烟的运动 扩散或膨胀的感觉 就会产生这种 可以看作是气体运动的基本场 而速度场是可以直接调节。
- 核对对象：`速度`、`烟雾`、`火焰`。

**关键画面：**

这一帧把处理链推进到 `volumerasterizeattributes`，也就是把前面点级几何上准备好的 `density`、`temperature`、`v` 等属性转换成体积求解器可读取的体素字段。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`volumerasterizeattributes`
- 节点作用：把点属性栅格化为体积属性，供后续 `pyrosolver_billowy_smoke` 读取。

`General`

- `Attributes = density temperature v`
- `Source Attribute` 输入框存在，但图中未能可靠辨认其具体文本
- `Visible Volumes` 输入框处于空白状态

`Filter`

- `Filter = Gaussian`
- `Voxel Size = 0.075`
- `Particle Scale = 1`
- `Minimum Filter Size = 0.75`

`Coverage`

- `Normalize by Clamped Coverage` 已启用
- `Attribute Rules` 列表当前有 `1` 条规则
- 该规则的 `Attributes = v`
- `Method = Weighted Average`

`输出/预览`

- 左侧视口中可以看到一团亮黄色体积/速度可视化结果，说明点属性已经开始被转换为可供烟雾求解使用的体积数据，而不是停留在纯点云阶段。
- 中间网络里，`volumerasterizeattributes` 位于速度调整节点和 `pyrosolver_billowy_smoke` 之间，明确表明本步骤是“属性入解算器前的体积重构”。
- 底部 `Geometry Spreadsheet` 当前显示基础位置列 `P[x] / P[y] / P[z]`，说明视图仍在几何上下文中检查数据来源。

`结果理解`

- 结合正文“现在在体积重构节点里，密度、温度、速度”，这张图确认作者此时不是继续增加新的源属性，而是把已有的 `density`、`temperature`、`v` 三个关键场正式写入体积。
- `v` 在覆盖规则里被单独指定为 `Weighted Average`，说明速度场在体积化时需要按邻域加权汇总，避免直接写入造成过于粗糙或跳变的体素速度结果。
- `Voxel Size = 0.075` 表明这一阶段已经开始控制烟雾体积分辨率；体素越小，体积细节越多，但后续解算成本也会更高。
这一帧进入 `pyrosolver_billowy_smoke` 的源场接入设置，重点是把前一步体积重构得到的 `density`、`temperature`、`vel` 映射到求解器内部对应字段，决定烟雾的密度累积、温度驱动和速度推进方式。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前面板页签：`Sourcing`
- `Source Type = Individual Volumes`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- 数据类型为 `Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 1`
- `Use Timestep` 已启用

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- 数据类型为 `Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Use Timestep` 已启用
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口依旧显示一团黄色烟雾体积，说明当前不是重新建源形状，而是在确认这些体积字段如何被解算器消费。
- 中间网络中，`pyrosolver_billowy_smoke` 位于 `volumerasterizeattributes` 之后，表示前一步产出的体积字段已经作为求解输入送入烟雾模拟。
- 底部 `Geometry Spreadsheet` 仍显示位置列，表明当前截图主要目的是检查求解器参数，而不是查看最终渲染材质。

`结果理解`

- `density -> density` 且使用 `Add`，说明密度场会被持续累加到烟雾主字段中，用于决定烟的“有多少、能看到多少”。
- `temperature -> temperature` 使用 `Pull`，并设置 `Acceleration Strength = 50`、`Deceleration Strength = 0`，说明温度场被用来强力驱动上升或流动趋势，而不是简单做线性叠加。
- `v -> vel` 使用 `Add`，说明前面构造的噪声速度场会直接注入求解器速度字段，成为烟雾扩散、拉扯和翻卷运动的初始推动来源。
这一帧继续展示 `pyrosolver_billowy_smoke` 的 `Sourcing` 配置，但画面重心更明确地落在第 3 个源 `vel` 上，用来确认前面构建的点/体积速度字段会如何注入烟雾求解器。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前面板页签：`Sourcing`
- `Source Type = Individual Volumes`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- `Source Volume = density`
- `Target Field = density`

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口中的黄色烟雾体积依然保持较矮、向上卷起的形态，说明当前截图重点仍是求解前的驱动设置，而不是新的造型节点。
- 右侧参数面板底部已经滚动到 `Source 3: vel` 区域，能直接看到 `v -> vel` 的映射关系，这是这张图相对前一张最关键的确认点。
- 中间网络关系未变化，`pyrosolver_billowy_smoke` 继续承接 `volumerasterizeattributes` 输出，说明这里配置的是体积源进入解算器后的字段绑定。

`结果理解`

- 这张图单独把 `v` 写入 `vel` 的关系钉死，意味着前面 `attribadjustvector_velocity` 里做出的噪声矢量，不会停留在几何属性层，而是会直接成为烟雾模拟使用的速度场。
- `Operation = Add` 说明该速度源是往现有速度字段里累加驱动力，而不是完全覆盖已有流动状态，因此更适合做持续喷发、扰动和卷动效果。
- 结合本小节“UV、速度、烟雾”的主题，这一帧实际上完成了从“生成速度属性”到“把速度属性接入烟雾求解器”的闭环确认。

### 00:06:03-00:09:00 GPU、UV、烟雾

- 本段定位：GPU、UV、烟雾。
- 知识点：看起来会舒服点 从Pyrrolo开始调整应该没问题 我们打算把烟雾做的基础点 现在这里的Gradation用的是Use Lamp 所以用Gradation。
- 知识点：Lamp来表现 基本的Skylight也先加一个 相机稍后再弄 这样命名为Sap51 东方选项 就调个100帧左右 基本上然后烟是这样产生的。
- 知识点：现在用GPU计算 所以非常快 可观察到播放GPU的缺点是 波动时没有烘焙 所以在这个帧上确认 具体形状有点模糊 可以看作缺点 基本上模拟是基于最大尺寸。
- 知识点：进行的这个 基本最大尺寸最初 你听到就在这里 Algin 这个Mephile可能是Devo的 然后 讯号 100框架 IMS 密度提高一点 提高到10左右会有什么感觉。
- 知识点：就是变化 UVB 烟雾生成的非常浓密 可观察到变化 简单来说就是烟雾密度本身变厚了 就是随着Density数值的升高 加完换成0.1实时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`烟雾`。

**关键画面：**

这一帧把调整重点从求解器本身切到 `pyrolook_billowy_smoke`，也就是开始直接修改烟雾显示外观。结合字幕“从 Pyro Look 开始调整应该没问题”，这里展示的是先从烟雾材质/外观节点入手，把整体密度和色带观感拉到教程需要的浓度。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrolook_billowy_smoke`
- 节点类别标题显示为 `Pyro Bake Volume`
- 顶部 `Assign Material` 已启用
- 材质路径为 `matnet/Pyro_Shader`

`当前页签`

- 当前位于 `Smoke` 页签

`Smoke`

- `Density Scale = 5`
- `Smoke Color` 颜色块可见，旁边三个数值框分别为 `0.5`、`0.4`、`0.3`
- `Use Ramp` 按钮可见
- `Density Range` 左右端为 `0` 到 `1`
- `Compute Range` 按钮可见

`Smoke Color Ramp`

- 渐变条已启用，整体从偏灰褐到偏暖浅褐
- 左右两端各有一个可见控制点

`阴影相关`

- `Shadow Color` 颜色块右侧三个数值框均为 `1`
- `Shadow Density = 1`
- `Ambient Shadow Scale = 0.5`

`输出/预览`

- 左侧视口中的烟雾已经不再是前面那种亮黄色体积调试效果，而是更接近真实渲染的浅褐色低矮烟团，说明这里主要控制的是外观与可视密度。
- 中间网络里选中节点已经从求解器下移到 `pyrolook_billowy_smoke`，表明作者开始在模拟之后、渲染之前调整烟雾观感。
- 视口内可见红色边界框，说明当前同时在关注体积显示范围与最终视觉厚度。

`结果理解`

- `Density Scale = 5` 直接说明作者先把烟雾显示密度大幅抬高，以便让原本较薄的结果更快变得“浓”和“实”。
- `Smoke Color` 与 `Smoke Color Ramp` 都偏向灰褐暖色，意味着这一段不是做高亮火焰，而是在把烟雾观感校到更厚重、更接近尘烟/爆炸烟的色调。
- 这张图是本小节里从“模拟参数”转向“渲染观感”的第一步，后续同组画面大概率会继续围绕 Pyro Look 的密度、颜色或细节外观展开。
这一帧把注意力转到 `pyrosolver_billowy_smoke` 的 GPU/OpenCL 解算设置，用来解释为什么播放时会看到烟雾表现存在限制。结合字幕“GPU 的缺点是拖动时没有烘焙”，这张图强调的是 GPU 烟雾在实时预览与缓存行为上的差异，而不是继续调颜色。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Setup`

`General`

- `Voxel Size = 0.1`
- `Time Scale = 1`

`Simulation`

- `Simulation Type = Minimal OpenCL`
- `Global Substeps` 条目可见，但当前值未能从图中可靠辨认
- `Min Substeps` 条目可见，但当前值未能从图中可靠辨认
- `Max Substeps = 1`
- `CFL Condition` 条目可见，但当前值未能从图中可靠辨认
- `Advection-Reflection = Disabled`
- `Cache Memory (MB)` 条目存在，但数值未能可靠辨认

`输出/预览`

- 左侧视口显示一个较小、偏灰的烟团，并被红色边界框包围，说明当前重点在于解算边界和实时播放状态，而不是最终渲染外观。
- 时间轴位于较前帧段，左下播放控制处于运行状态，呼应字幕里“可以看到播放”的说明，表明作者正在用实时播放来观察 GPU 模式下的行为。
- 中间网络中虽然 `pyrolook_billowy_smoke` 仍可见，但当前真正被选中的是 `pyrosolver_billowy_smoke`，说明这一帧讨论的是求解器层面的 GPU 限制。

`结果理解`

- `Simulation Type = Minimal OpenCL` 明确说明这里已经切到 GPU/OpenCL 路径，因此这段经验是在讨论 GPU 烟雾求解，不是 CPU 版 Pyro Solver。
- `Voxel Size = 0.1` 比前面体积重构阶段看到的更偏向解算器整体尺度控制，意味着作者此时同时在平衡分辨率、实时性和可视厚度。
- 字幕提到“GPU 的缺点是拖动时没有烘焙”，结合当前播放状态，可以理解为作者在提醒：GPU 模式适合快速预览，但在时间轴拖动和缓存反馈上不如预烘焙流程稳定直观。
这一帧继续停留在 `pyrosolver_billowy_smoke` 的 `Sourcing` 页，但已经把源场的启用范围和缩放系数与实际烟雾结果放在同一画面里，方便对照“哪些输入正在驱动当前这股烟”。相较前一张侧重 GPU 模式说明，这一张更像是对 source 注入时长和各字段权重的复核。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`

`Limit Source Range`

- 已启用
- `Range Type = Frame Range`
- `Frame Range = 1` 到 `12`
- `Cycle Length = 12`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- 数据类型为 `Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 0.1`
- `Use Timestep` 已启用

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- 数据类型为 `Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Use Timestep` 已启用
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口中已经能看到一股明显向上翻卷、带分叉形态的灰色烟柱，说明此时源场接入、解算和外观调节已经组合出较完整的烟雾结果。
- 红色边界框仍包住整个模拟范围，便于观察烟雾是否在预定体积内生成和上升。
- 时间轴当前停在较后面的帧位，说明画面是在观察源场持续输入一段时间后的累积形态，而不是刚生成的初始帧。

`结果理解`

- `Limit Source Range` 被限制在 `1-12` 帧，说明作者不是让源场无限持续喷发，而是只在前 12 帧内注入一次源，再依赖后续求解让烟继续翻卷扩散。
- `density` 的 `Source Scale = 0.1` 明显低于 `temperature` 和 `vel` 的 `1`，说明这里有意压低密度注入量，避免烟团过早变成死黑一坨，同时保留温度和速度对上升、拉伸的主导作用。
- 这张图把“GPU 烟雾可实时播放”从抽象说明变成了具体结果：通过限定源范围并调节三个 source 的比例，可以在较短发射期内得到一股持续上升、形态自然的烟柱。

### 00:09:04-00:13:39 速度、破碎、烟雾

- 本段定位：速度、破碎、烟雾。
- 知识点：可以适当提高密度数值 然后在螺旋部分还可以进一步调整 可以膨胀或降低 所以这部分是后续可以控制的 不需要在源头上控制 那么现在我们来提高一下。
- 知识点：温度的这个尺度 明显温度升高 烟雾上升的力量也更强了 是的 代替现在 形状本身似乎就变得稳定了 嗯 感觉打破了稳定的块状感 因为上升的力量就变大了。
- 知识点：现在温度与这里的通缩数值有一定关联 正在显示出来 这个数值调大点试试 把边界框也扩大一点 边界框变大后 计算量增加了 速度有点变慢了。
- 知识点：现在为了展示和这个温度的关系 现在这个图形本身 如果这里是温度1的话 这里可以看作是温度0 所以从烟雾几乎冷却的时候就开始 这个数值就可以正确应用了。
- 知识点：到最后的针那边去 烟雾上升到一定程度后 可以感觉到有点强烈的消散 现在反过来试试看吧 反过来给的话 因为这里下面的部分温度最高 下面部分已经有烟雾消散。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`、`烟雾`。

**关键画面：**

这一帧重新把焦点切回 `pyrolook_billowy_smoke` 的 `Smoke` 页签，用来直接调节烟雾的可见厚度。结合字幕“可以膨胀或降低，所以这部分是后续可以控制的”，这里强调的是烟雾外观密度可以在后处理阶段继续放大或压低，不需要回头改求解器源场。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrolook_billowy_smoke`
- 节点类别标题显示为 `Pyro Bake Volume`
- 顶部 `Assign Material` 已启用
- 材质路径为 `matnet/Pyro_Shader`

`当前页签`

- 当前位于 `Smoke` 页签

`Smoke`

- `Density Scale = 50`
- `Smoke Color` 右侧三个数值框均为 `0.5`
- `Smoke Color` 模式显示为 `Constant`
- `Shadow Color` 右侧三个数值框为 `0.9`、`0.9`、`1`
- `Shadow Density = 1`
- `Ambient Shadow Scale = 0.5`

`输出/预览`

- 左侧视口中的烟柱已经明显更厚、更实，体积团块感更强，并且在向上翻卷时保持较完整的蘑菇状堆叠，说明当前改动主要强化的是显示密度而不是流动方向。
- 红色边界框仍包围整个模拟区域，便于对照提升密度后烟雾是否仍在预定边界内表现正常。
- 中间网络中选中节点位于 `pyrosolver_billowy_smoke` 之后，明确说明这是模拟结果出来后的外观强化，而不是再次修改求解输入。

`结果理解`

- `Density Scale` 从前面画面中的较低值直接提高到 `50`，说明作者在这里把烟雾“看起来有多厚”当作可单独控制的显示参数，而不是依赖重新增加 source 密度来达成。
- `Smoke Color = 0.5 / 0.5 / 0.5` 且为 `Constant`，说明这一步并没有继续做复杂颜色渐变，而是先用较中性的灰色把浓度变化看清楚。
- 这张图对应的关键经验是：当模拟走势已经基本正确后，可以在 `Pyro Look` 阶段单独调整膨胀感和厚重感，用更低成本去逼近目标视觉。
这一帧把调节位置从 `Pyro Look` 再次切回 `pyrosolver_billowy_smoke`，但不再是 source 注入，而是进入字段演化控制，重点调 `Density` 的耗散方式。结合画面和参数区，这里是在用 `temperature` 场去控制烟雾密度随时间的衰减，让烟不会一开始就快速散掉。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Fields`

`Density`

- `Field Guides = No Guide`
- `Dissipation` 分组已启用
- `Dissipation = 0.2`
- `Clamp Below = 0.005`
- `Use Control Field` 已启用
- `Control Field = temperature`
- `Control Range = 0` 到 `1`
- `Compute Range` 按钮可见
- `Remap Control Field` 已启用
- `Control Ramp` 为一条从左高到右低的下降曲线

`Temperature`

- `Diffusion = 0`
- `Cooling Rate = 0.5`

`其他可见分组`

- `Emit From Flame`
- `Flame`
- `Color`
- `Speed`

`输出/预览`

- 左侧视口中的烟柱变成更细长、更向上拉伸的形态，上部保留团块，下部逐渐变细，说明当前调整确实会影响烟雾保留与消散节奏。
- 红色边界框仍可见，便于观察字段调整后烟雾是否在模拟空间内稳定存在。
- 时间轴停在中段帧位，表示作者在查看一段发展过程中的密度衰减效果，而不是只看初始喷发瞬间。

`结果理解`

- `Dissipation = 0.2` 与 `Clamp Below = 0.005` 说明烟雾密度会持续衰减，但低于阈值的弱密度会被更积极地清理掉，避免画面残留过多脏雾。
- `Use Control Field = temperature` 且曲线从高到低递减，说明烟雾的耗散不是一刀切，而是会根据温度场值不同而变化；可以理解为更热的区域和更冷的区域拥有不同的散去速度。
- `Cooling Rate = 0.5` 进一步说明温度场本身也在随时间衰减，因此这一组设置本质上是在联动控制“热量还剩多少”和“烟还能保留多久”。
这一帧继续停留在 `pyrosolver_billowy_smoke` 的 `Fields` 页，仍然是在调 `Density` 的耗散，但和前一张相比，关键变化是把耗散强度进一步压低。结合字幕“所以这些数值是模拟数值”，这张图强调的是：这些数值直接决定模拟里烟保留多久、散得多快，而不是纯显示参数。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Fields`

`Density`

- `Field Guides = No Guide`
- `Dissipation` 分组已启用
- `Dissipation = 0.05`
- `Clamp Below = 0.005`
- `Use Control Field` 已启用
- `Control Field = temperature`
- `Control Range = 0` 到 `1`
- `Compute Range` 按钮可见
- `Remap Control Field` 已启用
- `Control Ramp` 仍为从左高到右低的下降曲线

`Temperature`

- `Diffusion = 0`
- `Cooling Rate = 0.5`

`其他可见分组`

- `Emit From Flame`
- `Flame`
- `Color`
- `Speed`

`输出/预览`

- 左侧视口中的烟雾明显更贴地、更厚实，整体团块保留得更多，没有像前一张那样被较快拉细并向上散开，说明降低耗散后密度保存时间变长。
- 红色边界框依旧可见，表明这是在相同模拟空间里比较不同耗散数值带来的结果差异，而不是换了另一套场景。
- 时间轴当前位于更早的帧位，配合更低的耗散数值，可以更清楚地观察烟雾在初期阶段如何堆积和保形。

`结果理解`

- `Dissipation` 从前一张的 `0.2` 降到 `0.05`，直接说明作者在测试“让烟少散一点”的方案；数值越低，烟雾密度通常保留越久，画面就越厚重。
- `Clamp Below = 0.005`、`temperature` 控制场和同一条 remap 曲线都没变，说明这一组对比的变量核心就是耗散强度本身，而不是换了整套控制逻辑。
- 这张图和前一张合起来，构成了本小节里很关键的经验对照：`Pyro Look` 负责视觉厚薄，`Fields -> Density -> Dissipation` 负责模拟层面的“散得快不快”，两者不能混为一谈。

### 00:13:48-00:16:30 速度、扰动、烟雾

- 本段定位：速度、扰动、烟雾。
- 知识点：控制的时候 那是我正在移动的数值 一定要确认是否真的正确应用 理解会更快一些 这里初始相量为X轴的3左右 然后 这样就有了这种相量 这样因为这个速度的方向。
- 知识点：最初是朝这个方向设置的 然后 虽然现在用速度也给了这种噪音音样的模式 但在这里的形状中也已经用团流 我们再次制作并利用了噪音 干扰也在某种程度上遵循了那个模式。
- 知识点：因为又在做双重的形状 所以在这方面 也在做复杂的图案 然后现在这些复杂的噪音图案叠加在一起 像团流或干扰这种情况 速度和速度场有点不同。
- 知识点：速度可以看作是烟雾生成时的初始速度 团流可以看作是空气中已经流动的风的方向 像是乱流的感觉 而扰动是人为的 烟雾在外部边缘人为添加的细节。
- 知识点：可以这样理解 这样想 不要再现在太简单了 现在我们要做的就是 我们要做的就是 我们要做的就是 不要再现在太简单了 数值之关可见 就不用多说了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`、`烟雾`。

**关键画面：**

这一帧回到 `pyrosolver_billowy_smoke` 的 `Sourcing` 页，重点是重新检查三个 source 的注入比例是否真的生效。结合字幕“要确认是否真正正确应用”，这里不是新增节点，而是在验证放大后的 source scale 是否把烟柱推到了更高、更厚、更有分团感的状态。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`

`Limit Source Range`

- 已启用
- `Range Type = Frame Range`
- `Frame Range = 1` 到 `12`
- `Cycle Length = 12`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- 数据类型为 `Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 1`
- `Use Timestep` 已启用

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- 数据类型为 `Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Use Timestep` 已启用
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 10`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口里已经出现一股更高、更厚、更分团的烟柱，顶部形成多个膨胀团块，说明 source 比例放大后，烟的抬升与堆积都更明显。
- 红色边界框仍覆盖同一模拟区域，便于在不改场景尺寸的前提下直接比较 source scale 变化造成的结果差异。
- 时间轴停在后段帧位，说明当前是在观察一段持续解算后，放大 source scale 是否真的把整体烟柱做“做实了”。

`结果理解`

- `density` 的 `Source Scale` 从前面小节里更保守的值抬到 `1`，说明这里不再压着密度输入，而是允许烟体更快建立起可见体积。
- `vel` 的 `Source Scale = 10` 是这张图最关键的变化，意味着速度输入被显著放大，烟柱上升、倾斜和分叉的趋势会比前面更强。
- 这张图对应正文里关于“0.1 和 0.05 轻重不同、要确认是否正确应用”的经验点：当烟看起来太轻、太软时，优先复核 source scale 是否真的按预期写进求解器，而不是立即怀疑后面的渲染外观节点。
这一帧把调节位置切到 `pyrosolver_billowy_smoke` 的 `Shape` 页，开始直接处理烟柱的形态扰动。结合字幕“像湍流或干扰这样的情况现在”，这里主要是在建立基础上升、轻微侧偏，以及块状扰动和细碎涡流，让烟从单纯上飘变成更自然的翻卷形态。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`基础形态`

- `Shape Guides = No Guide`
- `Buoyancy = 0.1`

`Wind`

- 分组已启用
- `Wind Speed = 2`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 15`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 0.25`
- `Swirl Size = 2`
- `Roughness = 0.5`
- `Pulse Length` 条目可见，但数值被悬浮提示遮挡，无法可靠确认
- `Threshold Field = temperature`
- `Threshold Range = 0.1` 到 `0`
- `Use Control Field` 已启用

`输出/预览`

- 左侧视口中的烟团此刻仍较贴地、较紧实，说明当前截图主要目的不是展示最终形状，而是先把形态控制参数设好，再逐步观察烟柱如何被推散和卷起。
- 中间网络没有变化，仍在同一条烟雾链上调节，说明 `Shape` 页参数是直接作用于现有求解器结果，而不是通过新增节点实现。
- 时间轴停在靠前帧位，符合“先设基础风向和扰动，再看烟如何长起来”的调试方式。

`结果理解`

- `Buoyancy = 0.1` 配合 `Wind Direction = (1, 0, 0)` 和 `Wind Speed = 2`，说明作者要的不是强烈横吹，而是让烟在基础上升之外只带一点侧向偏移。
- `Disturbance = 15` 且为 `Block-Based`，说明这里先用较强的块状干扰去打破过于光滑的体积边界，让烟团出现更明显的翻卷和撕裂趋势。
- `Turbulence` 使用 `Analytic Fast Simplex Noise`，并以 `temperature` 作为阈值控制字段，说明细节涡流不会平均施加到所有区域，而是更倾向在有温度支撑的有效烟区内工作。
这一帧继续停留在 `pyrosolver_billowy_smoke` 的 `Shape` 页，但重点从“加入侧向风和扰动”变成“确认烟只向上长，不再横向飘移”。结合字幕“只向上生成而不向旁边移动”，这张图是在把横向风影响关掉，同时保留浮力、重力和扰动来维持自然翻卷。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Buoyancy`

- 分组已启用
- `Buoyancy Scale = 0.1`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 3000`

`Gravity`

- 分组已启用
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Density Influences Gravity` 当前未启用

`Wind`

- 分组已启用
- `Wind Speed = 0`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 15`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Compute Range` 按钮可见

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 0.25`

`输出/预览`

- 左侧视口中的烟柱明显更垂直地向上堆叠，虽然仍有翻卷和团块，但整体不再像前一张那样带侧向偏移趋势。
- 烟体底部仍然较厚，顶部逐渐分团上升，说明关掉横向风以后，浮力和扰动依然足以维持自然形态变化。
- 红色边界框保持不变，说明这里比较的是运动方向控制，而不是模拟空间或发射位置变化。

`结果理解`

- `Wind Speed = 0` 是这张图最关键的变化，它直接把此前的侧向风影响拿掉，从而实现“只向上生成”的基础趋势。
- `Buoyancy Scale = 0.1`、`Ambient Temp = 300K`、`Reference Temp = 3000K` 说明上升行为仍然主要由温度浮力驱动，而不是靠额外风场把烟推起来。
- 这张图对应的经验点很明确：当烟柱方向看起来“歪了”时，先检查 `Shape -> Wind` 是否还在施加横向速度，而不是盲目去改 `velocity source` 或 `Pyro Look`。

### 00:16:32-00:19:32 GPU、UV、烟雾

- 本段定位：GPU、UV、烟雾。
- 知识点：会做点基础 可以看作是这种基础的一团团生起的烟柱 然后现在复制了尺寸 有时候0.1轻 有时候0.05也轻 这是因为这个比例的复制尺寸 这个区域多大情况下复制的尺寸是0.1。
- 知识点：小情况下的0.1认知 这部分有点差异 风不要太过 适当倾斜一点就好 一左右就行 然后 接下来 这种感觉 烟雾适当往上飘的样子 应该不错 感觉要再上升一点。
- 知识点：方向好像设的太低了 所以就这样加个点 然后 慢慢调整这种形状吧 然后 圆的话就没办法了 现在用GPU 所以估计不能动这个 然后 这个等会需要关掉一下。
- 知识点：形状那边我就会把表格再关掉一点 然后 形状那边我就会把表格再关掉一点 然后这部分我们适当看看差异吧 UV-Ryne是怎么应用的 把这个数值调强一点。
- 知识点：这个噪音图案的突袭程度 这样就能看出来了 低的时候可观察到更密集的块状感。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`烟雾`。

**关键画面：**

这一帧重新回到 `pyrosolver_billowy_smoke` 的 `Sourcing` 页，重点是把三个 source 的输入比例收回到更基础、更均衡的状态。结合本段关于“复制尺寸”“0.1 有时轻、0.05 也轻”的讲解，这里是在重新校准源场输入，不让速度注入过重导致烟柱表现失真。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`

`Limit Source Range`

- 已启用
- `Range Type = Frame Range`
- `Frame Range = 1` 到 `12`
- `Cycle Length = 12`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- 数据类型为 `Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 1`
- `Use Timestep` 已启用

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- 数据类型为 `Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Use Timestep` 已启用
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口中的烟柱比前面 `vel = 10` 的状态更紧凑、更短一些，顶部团块保留，但整体不再被强速度场明显拉高或推散。
- 红色边界框和同一节点链都未变化，说明这是在同一套模拟结构里单独比较 source scale 的影响。
- 时间轴位于中段帧位，足以观察在统一发射区间下，基础值 `1` 的速度注入会产生怎样的烟柱厚度与上升幅度。

`结果理解`

- `vel` 的 `Source Scale` 从前面大幅强化的 `10` 回落到 `1`，是这张图最关键的变化；这意味着速度场回到基础强度，不再主导烟柱的大幅拉伸和偏移。
- `density`、`temperature`、`vel` 三项都保持在更均衡的基础级别，说明作者此时是在找一个“先成立、再微调”的稳定起点，而不是继续把某一项推到极端。
- 这张图对应的经验点是：当烟柱因为速度输入显得过轻、过散或走势太夸张时，优先先把 `vel source scale` 收回到基础值，再判断是否真的需要额外的风、扰动或外观补偿。
这一帧把重点重新切回 `pyrosolver_billowy_smoke` 的 `Shape` 页，用来把烟柱从“过于贴地、过于稳”重新拉回到更容易上升且略带方向性的状态。相较前面 `Wind Speed = 0`、`Buoyancy = 0.1` 的基准，这里明显是在恢复一点风和更强的浮力。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Buoyancy`

- 分组已启用
- `Buoyancy Scale = 0.3`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 3000`

`Gravity`

- 分组已启用
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Density Influences Gravity` 当前未启用

`Wind`

- 分组已启用
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 15`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 0.25`
- `Swirl Size = 2`

`输出/预览`

- 左侧视口中的烟体仍处于较早帧，但已经比纯垂直上升状态更有“抬头感”和轻微偏移趋势，说明恢复少量风和更高浮力后，烟会更快脱离地面。
- 烟团底部仍然较厚，没有被直接吹散，说明当前风量只是辅助方向修正，而不是主导运动。
- 同一边界框和同一节点链保持不变，因此这一张主要是在对比 `Shape` 页中浮力与风参数的重新平衡。

`结果理解`

- `Buoyancy Scale = 0.3` 相比之前的 `0.1` 明显更高，说明作者此时希望烟更主动地往上爬，而不是只靠基础温差慢慢抬升。
- `Wind Speed = 1` 表明横向风重新被少量启用，但仍比更激进的方案弱很多，符合正文里“适当倾斜一点就好”的调法。
- 这张图对应的经验点是：当烟柱显得太趴、太闷时，可以先小幅提高 `Buoyancy`，再给一点点 `Wind`，这样通常比直接猛加 `velocity source` 更容易得到自然的上升趋势。
这一帧继续停留在 `pyrosolver_billowy_smoke` 的 `Shape` 页，但重点已经明确切到 `Turbulence` 的噪声颗粒度控制。结合字幕“这个噪音图案的粗细程度”，这里是在通过更强的湍流幅度和更具体的噪声层级，重新定义烟内部翻卷的粗细感。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Wind`

- 分组已启用
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 15`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 10`
- `Swirl Size = 2`
- `Roughness = 0.5`
- `Pulse Length = 0.5`
- `Max Octaves = 2`
- `Seed = 0`
- `Threshold Field = temperature`
- `Threshold Range = 0.1` 到 `0`
- `Use Control Field` 已启用
- `Control Field = density`
- `Control Range = 0` 到 `1`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`其他可见分组`

- `Shredding`
- `Flame Expansion`
- `Viscosity`

`输出/预览`

- 左侧视口中的烟团已经不再是单一烟柱，而是变成充满碎块、卷边和内部空隙的团状体，说明湍流细节被显著加强后，烟的内部结构变化明显增多。
- 红色边界框仍包住同一模拟区域，说明这种“粗细变化”来自噪声参数本身，而不是边界或发射器位置变化。
- 时间轴停在较后帧位，适合观察高强度噪声在累积一段时间后会怎样重塑烟的轮廓和内部纹理。

`结果理解`

- `Turbulence = 10` 相比前面更温和的设置是一次明显增强，说明作者在主动测试更强的团流/湍流是否会把烟的形状打得更活、更碎。
- `Pulse Length = 0.5`、`Max Octaves = 2` 表明这里不仅在调强度，也在调噪声演化速度和层级复杂度，从而控制“粗大翻卷”还是“细碎抖动”的观感。
- `Threshold Field = temperature` 且 `Control Field = density` 说明湍流不会盲目施加到整块体积，而是会优先在有效烟区和有热量支持的区域内工作；这正对应正文里“粗细程度变化会完全改变食烟变化和整体工作效果”的经验点。

### 00:19:35-00:22:34 扰动、烟雾

- 本段定位：扰动、烟雾。
- 知识点：完全 0.5放进去的话 这样也会出来 所以这种块状感本身有时候也可以用这种团流来表达 通常我们现在用团流 不是把这块切得很碎 而是在整体烟雾流动中。
- 知识点：适当加入一点扭曲的感觉 比起直线产生的烟雾 这里可以加点波浪感 所以不是那种强烈的感觉 而是更坚向于辅助的模式 控制一下 要不要加大干扰。
- 知识点：加大后可观察到它被吸粉成这样 现在Block size有点密密麻麻的 看到数值变化食烟的变化 完全改变了 这样工作就有影响了 可以看出来。
- 知识点：干扰不会太强 需要这样安排 但如果太弱的话 整体感又会显得有点单调 好像有这种趋势 我们双击这里进去看看里面 可以再加个吸附场 可以再加个气体的团流。
- 知识点：或者再加个扰动 这样又可以配置 好像还能加个约束 包含 建议 包含一个。
- 核对对象：`烟雾`。

**关键画面：**

这一帧继续停留在 `pyrosolver_billowy_smoke` 的 `Shape` 页，重点是把“块状感”更多地交给团流/湍流来表达，而不是单纯依靠基础扰动把体积切碎。结合字幕“块状感本身有时候也可以用这种湍流来表达”，这里展示的是在保留现有 `Disturbance` 结构的同时，进一步强化 `Turbulence` 对烟柱内部翻卷和块感的塑造。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Wind`

- 分组已启用
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 15`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 10`
- `Swirl Size = 0.5`
- `Roughness = 0.5`
- `Pulse Length = 0.5`
- `Max Octaves = 2`
- `Seed = 0`
- `Threshold Field = temperature`
- `Threshold Range = 0.1` 到 `0`
- `Use Control Field` 已启用
- `Control Field = density`
- `Control Range = 0` 到 `1`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`其他可见分组`

- `Shredding`
- `Flame Expansion`
- `Viscosity`

`输出/预览`

- 左侧视口中的烟柱已经明显拉高并带有连续卷曲的团块结构，顶部和中段都能看到被扭出的分层团流，而不是单纯被切成细碎噪点。
- 红色边界框保持同一范围，说明当前观察重点是烟内部块感和卷曲方式如何变化，而不是发射区或模拟范围改变。
- 时间轴处于较后帧位，适合观察增强后的湍流在累计一段时间后，怎样把烟从“柱状上升”推成“翻卷块状体”。

`结果理解`

- `Turbulence = 10` 配合更小的 `Swirl Size = 0.5`，说明作者在让团流既更强又更细密一些，从而把块状感做进整体流动里，而不是单靠大块切割。
- `Disturbance` 仍保留 `Block-Based` 结构，说明这一步不是推翻前面的块状基础，而是在其上叠加更多旋转与卷吸感，让烟看起来更“活”。
- 这张图对应正文里的关键经验点是：烟的块状感不一定非得靠把体积打得很碎，也可以通过合适的湍流强度、旋涡尺寸和控制场，让整体流动自然长出更丰富的团块层次。
这一帧继续在 `pyrosolver_billowy_smoke` 的 `Shape` 页里微调烟的破碎方式，但和前一张相比，主角已经从高强度 `Turbulence` 切回到更高的 `Disturbance`。结合正文“转得有点快，因为 disturbance 产生了那些细节”，这里是在测试：如果块状扰动太强，烟会不会被切得过快、过碎。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Buoyancy`

- 分组已启用
- `Buoyancy Scale = 0.3`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 3000`

`Gravity`

- 分组已启用
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Density Influences Gravity` 当前未启用

`Wind`

- 分组已启用
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 50`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 0.2`

`输出/预览`

- 左侧视口中的烟柱仍保持整体上升形态，但中上部出现更明显的体积分裂与边缘碎裂感，说明高 `Disturbance` 已经开始主导烟的“破开速度”。
- 烟体底部相对还连在一起，上部却更容易出现被切开的层次，符合“块状干扰先从体积结构里打出细节”的表现。
- 同一模拟边界和同一发射位置保持不变，因此这一帧观察的是扰动强度本身带来的变化，而不是整体布局变化。

`结果理解`

- `Disturbance = 50` 是这张图最关键的变化，相比前面更常规的值，它会更快把烟体打出破碎细节，也更容易让旋转和分裂感显得过强。
- 同时 `Turbulence` 被压回到 `0.2`，说明这里作者在有意识地区分“块状破碎”与“团流卷吸”两种来源，避免两者一起推得太猛后难以判断问题来自哪里。
- 这张图对应的经验点是：如果烟的细节变化太快、转动太急，优先先看 `Disturbance` 是否过强，因为它会直接决定体积被打碎和分层的速度。
这一帧已经从外层参数面板钻进 `pyrosolver_billowy_smoke` 的内部动态网络，当前位于 `dopnet1/FORCES` 视图，并准备在这里额外插入一个力场或相关微求解器来继续调烟雾的卷曲/扰动行为。

已确认信息：

- 当前网络路径能看出位于 `pyrosolver_billowy_smoke / dopnet1 / FORCES`。
- 中间网络区域可见三个上游入口：`Input 1`、`Input 2`、`Input 3`。
- 底部已有一个输出节点，标签能辨认出是 `force_output`，右侧参数面板也显示当前选中节点为 `force_output`。
- `force_output` 参数面板里当前可见参数为 `Output Index = 0`。
- 画面中央打开了 Tab 菜单，说明作者正准备在 `FORCES` 子网络中新增节点，而不是继续只改外层滑杆参数。
- 左侧视口里此时烟体很小且贴地，说明这一帧重点不是展示最终外观，而是进入求解内部结构继续加力场。

可据此理解的步骤：

- 作者此时不满足于只在外层 `Shape` 页调 `Disturbance`、`Turbulence`，而是开始进入求解器内部 `FORCES` 层做更细的力场扩展。
### 00:22:37-00:25:41 速度、破碎、烟雾

- 本段定位：速度、破碎、烟雾。
- 知识点：这个8左右这个数值 比刚才计算更多 这个烟就这样卷着 然后这个烟就这样转的感觉 更多 规模更强 可以认为是一个给的场 加上这个场比刚才那个细节更多了。
- 知识点：转的感觉有点快 因为disturbance产生了那些细节 现在因为compartment fill 适当更满足 弥补了一些不足的地方 不管怎样。
- 知识点：回去的速度或烟雾流动的速度都更快了 烟雾破碎的体积被分割分裂 细节也进行得更快一些 而且现在要一次烘焙缓存 请这样处理斯帕尔斯 为了增强收缩力改为单项目。
- 知识点：另外 先确定这个动作的形状 还有场地 0.05可以直接用 火焰其实不太需要 速度现在这里在用。
- 知识点：放不就行 我现在这些字段 但给这些形状的值太极端的话 烟雾的形状不自然 有点不自然地极端变化 这些数值似乎也有一定控制的信息 而且这个稀疏的程度似乎已经确定。
- 核对对象：`速度`、`烟雾`、`火焰`。

**关键画面：**

这一帧继续在 `pyrosolver_billowy_smoke` 的 `Shape` 页里调整烟的破碎与卷吸节奏，但这次明显是在把前面偏激的数值收回来，避免烟形变得过于极端。结合正文“这些形状的值太极端的话，烟雾的形状不自然”，这里展示的是把 `Disturbance` 拉回更温和的区间，让烟先保持一个自然、可控的基础形状。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Shape`

`Buoyancy`

- 分组已启用
- `Buoyancy Scale = 0.3`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 3000`

`Gravity`

- 分组已启用
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Density Influences Gravity` 当前未启用

`Wind`

- 分组已启用
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`

`Disturbance`

- 分组已启用
- `Disturbance = 5`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05` 到 `0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0` 到 `5`
- `Compute Range` 按钮可见
- `Remap Control Field` 当前未启用

`Turbulence`

- 分组已启用
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 0.2`

`输出/预览`

- 左侧视口中的烟团此时重新变得较完整、较厚实，边缘不再像高 `Disturbance` 时那样快速碎裂，说明体积结构被保留得更多。
- 烟体仍带有一定上升和卷曲趋势，但整体更接近“基础形”，适合作为后续继续微调的稳定起点。
- 同一边界框和同一网络链条都未变化，说明这里比较的就是 `Disturbance` 强度降低后，烟柱自然度如何回升。

`结果理解`

- `Disturbance = 5` 相比上一张的 `50` 是一次明显回退，说明作者在确认“过强破碎会让烟形不自然”之后，主动把体积打散强度降回更保守的值。
- `Turbulence` 继续维持在 `0.2`，表明这一步并不是重新增强卷吸，而是先把影响最大的破碎参数稳住，再看整体是否还需要别的补偿。
- 这张图对应的经验点是：当烟的形变开始显得极端、假、难控时，优先先把 `Disturbance` 降回低值，让整体轮廓成立，再逐步叠加细节，而不是继续堆更高的扰动。
这一帧把调节位置切回 `pyrosolver_billowy_smoke` 的 `Setup` 页，重点不再是形态扰动，而是求解模式、反射收缩和缓存资源。结合字幕“为了增强收缩力，改为单项目”，这里展示的是通过 `Advection-Reflection` 的模式与强度来加强烟体回卷/收缩感。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Setup`

`General`

- `Voxel Size = 0.1`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1`

`Simulation`

- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 1`
- `Max Substeps = 1`
- `CFL Condition = 4`
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 15000`

`输出/预览`

- 左侧视口中的烟体当前还处于很早期、较贴地的状态，说明这一帧重点是切换求解设置而不是展示最终长成后的烟柱形状。
- 中间网络链没有变化，说明收缩感增强并不是通过新增节点完成，而是通过求解器自身的全局设置切换获得。
- 左侧线框盒子比之前红色边界框更简化，画面更像是在为一次重新缓存/重新解算做准备。

`结果理解`

- `Simulation Type = Sparse` 说明这里已经切到稀疏求解模式，这与正文里提到的“稀疏程度似乎已经确定”“一次烘焙缓存”是对应的。
- `Advection-Reflection = Single-Project` 配合 `Reflection Amount = 0.95`，直接说明作者在增强体积流动中的回卷/回弹感，让烟更容易产生向内收拢、翻卷的趋势。
- `Cache Memory = 15000MB` 说明这一阶段已经开始明确考虑缓存与求解资源上限，而不是只盯着视觉参数；这也符合正文“要一次烘焙缓存”的工作方式。
这一帧把视图切回 `pyrosolver_billowy_smoke` 的 `Sourcing` 页，作用更像是缓存前的最终复核：确认 `density`、`temperature`、`vel` 三个输入场都在稳定的基础比例上，再去执行文件缓存。结合字幕“所以加了文件缓存”，这里强调的是在缓存前先把 source 配置锁定。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`

`Limit Source Range`

- 当前分组可见，但处于收起/弱化显示状态
- `Range Type = Frame Range`
- `Frame Range = 1` 到 `12`
- `Cycle Length = 12`

`Source Volumes`

- `Number of Sources = 3`

`Source 1: density`

- 已启用
- `Operation = Add`
- 数据类型为 `Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 1`
- `Use Timestep` 已启用

`Source 2: temperature`

- 已启用
- `Operation = Pull`
- 数据类型为 `Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Use Timestep` 已启用
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`

`Source 3: vel`

- 已启用
- `Operation = Add`
- 数据类型为 `Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口中的烟体又回到很早期、较贴地的状态，说明此时重点不是观察成熟烟柱外观，而是回到初始条件去确认缓存前的输入场设置。
- 线框盒子和简化视图都延续了上一张“准备缓存/重算”的工作氛围，说明当前参数检查与缓存流程是连续动作。
- 中间网络链没有变化，表明缓存前并没有再新增求解节点，而是以当前 source 组合作为稳定输入基础。

`结果理解`

- 三个 source 的 `Scale` 都维持在 `1`，说明作者此时已经放弃极端输入方案，转而采用更均衡、可预测的基础场配置作为缓存版本。
- `temperature` 仍使用 `Pull + Acceleration Strength 50`，而 `vel` 只保留基础 `Add`，说明上升驱动力和速度场都已回到可控状态，适合进入烘焙阶段。
- 这张图对应正文里“先缓存一次”的工作逻辑：在真正写缓存前，先确认 source 输入没有再被临时实验参数污染，否则后面的缓存结果会把问题一并固化进去。

### 00:25:43-00:28:39 粒子、纹理、火焰

- 本段定位：粒子、纹理、火焰。
- 知识点：如果在这里之后烘焙 就无法调整阴影 所以总是先烘焙一次 现在是 现在这个数字 现在这个数值 通过改变的色素值来观察并决定 数值会那样给 输出时也不需要火焰场。
- 知识点：优化也做了一些 先缓存一次 这样 计划一起复制 过道 只做的Lowest UbEbrake 马上做 UbEbrake 30秒左右就能搞定 UbEbrake。
- 知识点：30秒左右就能搞定 Rheumatism Transstation的时候 基本上 从环保角度考虑 尽量不做的太重 这里是这样构成的 第一个纹理我们打算一直循环使用。
- 知识点：自然地向上延伸像柱子一样立起来 然后第二个纹理是从这个中间点开始 到消失为止的纹理再做一个。
- 知识点：先来用粒子 把这两个适当混合一下使用 摸住程度上 形状感觉要完成了 现在把分度再调低一点 重新选换存 打算用版本二来适当比较一下 大概花了4分钟。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`、`火焰`。

**关键画面：**

这一帧把流程正式推进到缓存与外观阶段：在 `pyrosolver_billowy_smoke` 之后插入了 `filecache1`，再把缓存结果送入 `pyrolook_billowy_smoke`。结合正文“烟柱已经形成了”“接下来要渲染一次”“做到 80 帧”，这里不是继续调模拟，而是在锁定当前烟柱框架后，准备先缓存再进入后续渲染与纹理流程。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrolook_billowy_smoke`
- 节点类别标题显示为 `Pyro Bake Volume`
- 顶部 `Assign Material` 已启用
- 材质路径为 `matnet/Pyro_Shader`

`新增缓存环节`

- `filecache1` 已插入在求解器与外观节点之间
- 缓存文件名可见为：`$HIPNAME.$OS_v1.$F4.bgeo.sc`
- 这一位置说明缓存的是求解后的体积结果，再交给 `pyrolook_billowy_smoke` 做显示与渲染外观调整

`当前页签`

- 当前位于 `Smoke` 页签

`Smoke`

- `Density Scale = 5`
- `Smoke Color` 右侧三个数值框为 `0.5`、`0.5`、`0.5`
- `Smoke Color` 模式显示为 `Constant`
- `Shadow Color` 右侧三个数值框为 `0.9`、`0.9`、`1`
- `Shadow Density = 1`
- `Ambient Shadow Scale = 0.5`

`输出/预览`

- 左侧视口里的烟体仍停留在早期、低矮的初始状态，说明这一帧重点不是看完整烟柱，而是在建立“模拟结果 -> 缓存 -> 外观”这条后续产出链。
- 中间网络中 `filecache1` 的加入非常关键，它把此前纯实时求解的流程转为可烘焙、可复用的缓存流程。
- `pyrolook_billowy_smoke` 仍然保留在缓存之后，说明缓存并不替代外观调节，而是把模拟阶段固定下来后再继续调材质观感。

`结果理解`

- `filecache1` 的位置证明作者此时已经认为烟柱主体形态基本成立，不再每次都依赖实时重算，而是准备把当前体积阶段结果落盘复用。
- 缓存文件模式使用 `$HIPNAME`、`$OS`、`$F4` 和 `.bgeo.sc`，说明这是按工程名、节点名和帧号输出压缩几何缓存的标准做法，适合后续按帧读取和渲染。
- 这张图对应正文里的关键工作节奏是：先把烟柱框架定住，再做一次 80 帧左右的缓存，然后才进入相机、光照和纹理/渲染相关调整。
这一帧把关注点完全落到 `filecache1` 节点本身，开始设置缓存文件名、落盘目录和缓存帧范围。结合正文里“从 15 帧开始到 80 帧烘焙纹理”“先缓存一次”的语义，这张图展示的是缓存流程的实际操作界面，而不再是烟雾参数本身。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`filecache1`
- 节点类型标题显示为 `File Cache`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用

`缓存路径与命名`

- `File Path` 模式为 `Constructed`
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- 文件扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 1`

`缓存操作`

- `Save to Disk` 按钮可见
- `Save to Disk in Background` 按钮可见
- `Cancel Cook` 按钮可见

`Sequence`

- `Evaluate As = Frame Range`
- 右侧模式为 `Simulation`
- `Start/End/Inc = 1 / 100 / 1`
- `Substeps = 1`

`Load`

- `Load = All Geometry`

`输出/预览`

- 左侧视口中的烟体仍停留在一个很早期的小体积状态，说明当前图不是在检查成熟烟柱效果，而是在确认缓存区间和文件输出参数。
- 中间网络中 `filecache1` 被明显选中并位于 `pyrosolver_billowy_smoke` 与 `pyrolook_billowy_smoke` 之间，表明缓存节点是当前流程的核心中转点。
- 节点下方还能直接看到缓存文件名预览，说明作者已经把缓存命名规则配置到可直接写盘的状态。

`结果理解`

- `Base Folder = $HIP/geo` 且扩展名为 `bgeo.sc`，说明作者使用的是 Houdini 常见的压缩几何缓存流程，便于之后按帧回放和渲染。
- `Start/End/Inc = 1/100/1` 说明当前缓存准备至少覆盖前 100 帧的模拟结果，这比正文口述的局部工作区间更像一个完整的输出范围设置。
- 这张图对应的关键工作逻辑是：在烟柱框架确定后，先把求解结果稳定地缓存成独立文件，再回到材质、相机或纹理流程中继续做后续渲染相关调整。
这一帧继续停留在 `filecache1` 的缓存阶段，但与前一张相比，重点已经变成“在更细的求解尺度下再执行缓存”。结合正文里关于“现在这个数值”“先定好框架再烘焙”的语义，这里是在确认体素尺度缩小之后，缓存链仍然保持一致。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`filecache1`
- 节点类型标题显示为 `File Cache`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用

`缓存路径与命名`

- `File Path` 模式为 `Constructed`
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- 文件扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 1`

`缓存操作`

- `Save to Disk` 按钮可见
- `Save to Disk in Background` 按钮可见
- `Cancel Cook` 按钮可见

`Sequence`

- `Evaluate As = Frame Range`
- 右侧模式为 `Simulation`
- `Start/End/Inc = 1 / 100 / 1`
- `Substeps = 1`

`Load`

- `Load = All Geometry`

`关联状态`

- 网络中 `pyrosolver_billowy_smoke` 节点下方可见数值 `0.05`
- 该数值可作为当前求解尺度已细化的直接证据，说明缓存节点此时承接的是更细体素结果，而不是上一阶段较粗的版本

`输出/预览`

- 左侧视口中的烟体依旧很小、很早期，说明此时主要是在锁定缓存输入条件，而不是展示最终成熟烟柱。
- 中间网络里 `filecache1` 仍稳定位于求解器和 `pyrolook_billowy_smoke` 之间，表明即便求解尺度调整了，整体流程顺序并未变化。
- 节点下方文件名预览继续可见，说明这一步已经具备直接落盘条件，只差正式执行缓存。

`结果理解`

- `pyrosolver_billowy_smoke` 下方的 `0.05` 说明作者已经把求解尺度进一步压细，这通常意味着会换来更高的烟雾细节，但也会增加缓存与解算成本。
- 缓存节点参数本身没有跟着大改，说明这里的核心不是换缓存策略，而是把“更细分辨率的模拟结果”接入原有缓存流程。
- 这张图对应的关键工作逻辑是：当烟柱框架确认后，可以先把求解尺度调整到目标精度，再用同一套 `filecache1` 设置烘焙出最终可用于后续纹理和渲染的版本。

### 00:28:44-00:30:31 纹理

- 本段定位：纹理。
- 知识点：现在这样 烟柱已经形成了 是的烟柱已经形成了 这个我们现在先定好框架 因为接下来要渲染一次 所以打算做到80帧 加个摄像头 好 UbEbrake。
- 知识点：UbEbrake UbEbrake UbEbrake UbEbrake 对准中心 从15帧开始到80帧烘焙纹理。
- 知识点：用三脉解除键之后 适当调整一下光的方向 提供字幕及包含广告。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这一帧继续以 `filecache1` 为中心，但已经不再只是配置缓存参数，而是直接在视口里验证“烟柱是否已经成形，是否值得进入渲染阶段”。结合正文“烟柱已经形成了”“先定好框架”，这里表达的是：缓存链和更细体素版本已经能够产出可用的完整烟柱形态。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`filecache1`
- 节点类型标题显示为 `File Cache`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用

`缓存路径与命名`

- `File Path` 模式为 `Constructed`
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- 文件扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 1`

`Sequence`

- `Evaluate As = Frame Range`
- 右侧模式为 `Simulation`
- `Start/End/Inc = 1 / 100 / 1`
- `Substeps = 1`

`关联状态`

- 网络中 `pyrosolver_billowy_smoke` 节点下方仍可见 `0.05`
- 说明当前视口里看到的烟柱，是建立在更细求解尺度下的缓存版本

`输出/预览`

- 左侧视口中的烟柱已经明显长高，并形成完整的上升主体、翻卷中段和顶部膨胀团块，说明这不再是测试小样，而是接近可交付的主烟柱框架。
- 烟柱整体仍处于线框盒子限制范围内，说明缓存后的结果既有足够高度，也没有明显超出预期体积边界。
- `filecache1` 位于求解器和 `pyrolook_billowy_smoke` 之间且保持选中，说明作者是在确认“缓存结果本身是否满意”，而不是继续回头改模拟节点。

`结果理解`

- 视口里烟柱已经成形，说明前面的求解、扰动、缓存区间和分辨率设置至少达到了可以进入渲染准备阶段的标准。
- `0.05` 的细求解尺度在这张图里直接体现为更连续的烟柱轮廓和更丰富的中段细节，这就是作者愿意在缓存前把分辨率压细的原因。
- 这张图对应的关键工作逻辑是：先用缓存链把最终烟柱框架固定下来，确认烟柱高度、主形和边界都成立后，再去接相机、灯光和纹理/渲染相关的后续步骤。
这一帧从体积缓存切换到 `/obj` 级别的镜头与灯光布置，目标是把已经成形的烟柱放进正式烘焙视角里。结合正文“加个摄像头”“对准中心”“从 15 帧开始到 80 帧烘焙纹理”“适当调整一下光的方向”，这里记录的是：主烟柱已经足够稳定，接下来要确定相机取景和基础打光，而不是继续修改模拟参数。

`对象层级`

- 当前网络位于 `/obj`
- 可见对象节点包括：
  - `geo1`
  - `sunlight1`
  - `skylight1`
  - `cam1`

`当前对象`

- 右侧参数面板显示当前选中对象为 `Geometry geo1`
- 当前停留在 `Transform` 页签
- `Translate = 0, 0, 0`
- `Rotate = 0, 0, 0`
- `Scale = 1, 1, 1`
- `Uniform Scale = 1`

`视角与取景`

- 左侧视口当前使用 `cam1` 观察烟柱
- 烟柱主体已经完整进入镜头，画面里能看到底部细长烟干、中段翻卷和顶部鼓起的主体轮廓
- 相机取景明显以烟柱中心为主，符合正文里“对准中心”的操作目标

`灯光`

- 对象层里已经放置了 `sunlight1`
- 同时存在环境光对象 `skylight1`
- 这说明作者不是只加一个相机就开始烘焙，而是先建立“主方向光 + 环境补光”的基础照明框架，再去微调光照方向

`输出/预览`

- 视口中烟柱外轮廓被高亮选中，说明当前检查重点是整体体积在镜头中的构图和边界，而不是材质细节
- 时间轴停在 `80` 帧，和正文里“做到 80 帧”“从 15 帧开始到 80 帧烘焙纹理”能够互相印证
- 右侧 `geo1` 变换值仍为默认值，说明这一帧没有通过平移或缩放几何体来修正画面，主要是通过相机与灯光完成烘焙前准备

`结果理解`

- 当前流程已经从“模拟是否成立”进入“如何把模拟结果拍下来并烘焙成纹理”，因此对象层中出现 `cam1`、`sunlight1`、`skylight1` 是这一阶段最关键的变化
- `geo1` 保持默认变换而烟柱仍能居中入镜，说明前面缓存出的主烟柱位置本身已经可用，不需要额外摆放模型
- 这张图对应的关键工作逻辑是：锁定主烟柱后，在对象层添加并对准相机，再配合方向光和环境光确定烘焙用视角，为后面的纹理输出做准备
这一帧继续停留在 `/obj` 层，但重点已经从“相机是否对准烟柱”进一步推进到“主方向光如何摆放”。结合正文“适当调整一下光的方向”，这里可以确认作者正在以 `cam1` 视角观察烟柱，同时直接选中并修改 `sunlight1` 的变换值，为 15 到 80 帧的烘焙纹理准备更合适的受光方向。

`对象层级`

- 当前网络位于 `/obj`
- 画面中可见对象包括：
  - `Geometry Smoke_01`
  - `Light sunlight1`
  - `Environment Light skylight1`
  - `cam1`

`当前对象`

- 右侧参数面板显示当前选中对象为 `Light sunlight1`
- 当前停留在 `Transform` 页签
- `Translate` 可见数值约为：
  - `X = -8.65956e-16`
  - `Y = 7.07107`
  - `Z = 7.07107`
- `Rotate` 可见数值约为：
  - `X = -45`
  - `Y = -7.01671e-15`
  - `Z = 0`

`视角与取景`

- 左侧视口仍使用 `cam1` 观察烟柱
- 烟柱主体已经完整占据镜头中心区域，顶部团块和中段翻卷结构都清晰可见
- 当前作者是在最终烘焙视角里边看边调灯，而不是切到自由视角单独摆灯

`灯光`

- `sunlight1` 已被明确选中，说明这一帧的主操作对象是方向光
- `skylight1` 仍保留在场景中，说明基础照明仍然是“主方向光 + 环境光”组合
- `sunlight1` 的 `Y/Z` 平移和 `X` 轴 `-45` 旋转已不是默认值，说明作者确实在按烟柱形态调整光的入射方向

`输出/预览`

- 视口中的烟柱已经比前一张更完整地被柔和照亮，顶部体积和中段灰阶层次更容易区分，符合“调光后再做烘焙”的目的
- 时间轴仍停在 `80` 帧，继续对应正文中本段以 80 帧为阶段性烘焙终点的描述
- 左侧网络视图弹出了 `New Pane Tab Type` 菜单，说明作者在调整对象层布局时也在整理界面面板，但这不是本帧的核心生产内容

`结果理解`

- 这张图证明作者没有停留在“已经有相机和灯”这一层面，而是继续细调 `sunlight1` 的实际方向，让烟柱在最终拍摄角度下获得更合适的明暗关系
- `sunlight1` 被单独选中并显示具体变换值，说明这一阶段最重要的不是再改模拟或几何位置，而是控制方向光角度来塑造烟柱体积感
- 这张图对应的关键工作逻辑是：在 `cam1` 已经对准烟柱后，继续旋转并摆放 `sunlight1`，确认最终烘焙前的受光方向和体积层次

## 补充视觉证据

### S01 00:00:25

这张补充截图可确认的是教程开场阶段的工作目标说明，而不是可直接复建的材质网络。当前画面显示的是一个新建或清空后的 Houdini 场景：对象层网络为空，右侧参数面板没有选中任何节点，左侧视口处于默认透视视图。

`已确认信息`

- 当前层级位于 `/obj`
- 中央网络视图显示 `Empty Network`，提示 `Press Tab to Add Nodes`
- 右侧参数区显示 `No Operator Selected`
- 左侧视口为默认透视视图，顶部显示 `Persp` 与 `No cam`
- 时间轴范围可见为 `1-240`
- 画面底部字幕可读为：大概会做两张纹理，加上运动矢量纹理，一共要做四张纹理

- 虽然文件名标注为 `material`，但当前截图中没有可见的材质节点、材质面板、贴图资源或参数设置
- 无法仅凭这一张图确认“四张纹理”各自的具体类型、命名方式、生成顺序或输出分工
`可用于正文替换的安全表述`

- 本段补充图只说明作者在开场阶段先明确了纹理产出目标：计划制作两张基础纹理，并额外制作运动矢量相关纹理，总计四张纹理。
- 截图本身未提供任何可直接复建的材质网络或参数，因此后续纹理类型、节点结构与烘焙流程仍需结合后面的实际材质图和节点图判断。
### S02 00:05:32

这张补充图展示的是烟柱流程早期的 Houdini 网络与 `pyrosolver_billowy_smoke` 的 `Sourcing` 设置，用来补足“烟雾体积从哪些字段喂给求解器”的证据。当前画面不是材质编辑器，而是 `geo1` 内部的体积求解链，因此可直接复建的是源体积、速度场和 Pyro Solver 的输入关系。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`节点作用`

- `smoke_base`
  - 上游基础几何，节点标签显示为 `Torus`
  - 说明最初的烟雾发射体来自一个环形基础体
- `pyrosource1`
  - 把基础体转换为 Pyro 可用的源体积
- `attribadjustvector_velocity`
  - 在进入体积栅格化前调整速度向量属性
- `volumerasterizeattributes`
  - 把属性转换为体积字段，供后面的 Pyro Solver 使用
- `pyrosolver_billowy_smoke`
  - 当前选中节点，负责烟雾求解
- `pyrolook_billowy_smoke`
  - 作为 `Pyro Bake Volume` 进行外观处理
- `RENDER_Billowy_Smoke`
  - 最终渲染输出前的 `Null`

`Sourcing 参数`

- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`
- `Number of Sources = 3`

`Source 1`

- 名称：`density`
- `Operation = Add`
- 数据类型：`Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 1`
- `Use Timestep` 已启用

`Source 2`

- 名称：`temperature`
- `Operation = Pull`
- 数据类型：`Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`
- `Use Timestep` 已启用

`Source 3`

- 名称：`vel`
- `Operation = Add`
- 数据类型：`Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口显示的是一团贴地、体量较小的早期黄色预览烟雾，说明这还是主烟柱尚未拉高之前的初始求解阶段
- 时间轴停在第 `1` 帧，因此这张图更像是网络搭建与字段映射确认，而不是中后期效果检查
- `pyrosolver_billowy_smoke` 节点下方可见 `0.1`，说明此时求解尺度还处在较粗的早期版本，不是后面细化到 `0.05` 的阶段

`结果理解`

- 这张图给出的关键证据是：求解器并不是只吃一个密度场，而是同时接收 `density`、`temperature` 和 `vel` 三类输入字段
- `temperature` 被设置为 `Pull` 且 `Acceleration Strength = 50`，说明它在当前流程里承担了明显的上升驱动作用，而不是单纯存档字段
- 这张图对应的安全结论是：教程前期先用 `Torus` 基础体生成 `density / temperature / vel` 三类源数据，再交给 `pyrosolver_billowy_smoke` 开始烟柱求解，材质部分并未在本图中出现

### S03 00:08:28

这张补充图继续展示 `pyrosolver_billowy_smoke` 的 `Sourcing` 设置，但重点已经从“有哪些输入字段”收窄到“发射时段限制”和“密度强度加大后的效果”。结合底部字幕“密度提高一点？提高到 10 左右会有什么感觉变化”，这里能确认作者在早期烟柱阶段直接把 `density` 的源强度拉高，并把源输入限制在前 `12` 帧内。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 选中节点：`pyrosolver_billowy_smoke`
- 当前页签：`Sourcing`
- `Source Type = Individual Volumes`
- `Number of Sources = 3`

`Limit Source Range`

- `Limit Source Range` 已启用
- `Range Type = Frame Range`
- `Frame Range = 1 -> 12`
- `Cycle Length = 12`

`Source 1`

- 名称：`density`
- `Operation = Add`
- 数据类型：`Scalar`
- `Source Volume = density`
- `Target Field = density`
- `Source Scale = 10`
- `Use Timestep` 已启用

`Source 2`

- 名称：`temperature`
- `Operation = Pull`
- 数据类型：`Scalar`
- `Source Volume = temperature`
- `Target Field = temperature`
- `Source Scale = 1`
- `Acceleration Strength = 50`
- `Deceleration Strength = 0`
- `Use Timestep` 已启用

`Source 3`

- 名称：`vel`
- `Operation = Add`
- 数据类型：`Vector`
- `Source Volume = v`
- `Target Field = vel`
- `Source Scale = 1`
- `Use Timestep` 已启用

`输出/预览`

- 左侧视口仍是非常早期的测试状态，只能看到地面附近的小体积发射物和求解边界框
- 时间轴停在第 `1` 帧，说明这里还是在看初始源设置而非中后期成形效果
- 网络中 `pyrosolver_billowy_smoke` 下方仍显示 `0.1`，说明这一步仍属于较粗体素的前期摸索阶段
- 底部字幕明确提到把密度提高到 `10` 左右，和 `Source 1` 的 `Source Scale = 10` 相互印证

`结果理解`

- 与上一张相比，这里新增的关键证据是：源发射不是无限持续，而是被限制在 `1-12` 帧的短时间窗口内
- `density` 被直接放大到 `10`，说明作者在测试更强的初始烟量对烟柱起势和体积感的影响
- 这张图对应的安全结论是：教程前期通过 `Limit Source Range` 限制发射帧段，同时把 `density` 源强度提高到 `10`，以便快速观察烟柱起始阶段的形态变化；本图依然没有出现材质网络本体

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


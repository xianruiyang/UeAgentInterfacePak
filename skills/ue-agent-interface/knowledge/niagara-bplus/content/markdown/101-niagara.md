# 101 - 使用Niagara采样纹理

# 101 - 使用Niagara采样纹理

## 关键术语

- `Spawn`、`Initialize Particle`、`Color`、`Alpha`、`GPU`、`UV`、`Texture`、`粒子`、`发射器`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Particle Spawn`、`Particle Update`、`Lifetime`、`Niagara System`、`Normalized Age`

## 分段知识

### 00:00:04-00:05:01 Niagara、Spawn、Initialize Particle

- 本段定位：Niagara、Spawn、Initialize Particle。
- 知识点：欢迎回来,到目前为止,我们已经用Niagara创建了 许多不同类型的效果,而且还有很多可以用它做的事情 例如,可以用Niagara来采样不同的对象。
- 知识点：,在这讲我们看看如何采样一个纹理 使用Niagara,首先需要为它创建一个房间 所以需要点击这个演示房间并进入 点击这个应用按钮,添加一个新房间。
- 知识点：对于这个第三个房间,需要叫它采样对象 然后,需要把它的高度降到7 需要再拖入材质或模块输入一个演示显示器 去我的第一个房间,需要复制这个演示显示器。
- 知识点：并把它拖到我的第三个房间 首先,需要把这个名字改成样本纹理 然后,需要创建另一个用于我需要的Niagara系统的文件夹。
- 知识点：本段围绕 `Niagara`、`系统` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：texture 双击打开它 所以,我们需要的第一个采样纹理模块 实际上叫做Sample Texture。
- 知识点：可以在这里看到 可以指定我们要采样的纹理 所以,需要回到我的内容浏览器 然后,去我的文件夹 进入InfinityVFX文件夹,并在Demage文件夹下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`Particle`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`、`Alpha`、`Opacity`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: UE Level + Content Browser Setup
> - 目标主题: Niagara 采样纹理
>
> 可见状态:
> - Viewport 中仍显示上一节瀑布效果，作为进入新主题前的场景状态。
> - World Outliner 可见 `BP_DemoDisplay`、`BP_DemoDisplay2`、`BP_DemoDisplay3` 等演示展示对象。
> - Content Browser 当前路径为 `Content / Niagara / CustomNiagaraModule`。
> - 当前目录下可见文件夹: `FollowTheLeader`、`RainFX`、`SimpleCustomModule`、`Waterfall`。
> - 底部状态显示 `All Saved`。
>
> 操作语境:
> - 本节准备为 Sample Texture 主题创建新的房间/展示对象和 Niagara 资源目录。
>
> 验证方式:
> - 新建 Sample Texture 示例前，确认仍位于 `CustomNiagaraModule` 分类下，并以新的独立目录承载后续 Niagara 系统。
> - 空间证据边界: 此图只记录场景与内容浏览器状态；不从瀑布预览或展示房间推断对象 transform、房间尺寸或相机位置。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System Overview
> - Niagara System: `NS_SampleTexture`
> - Emitter: `SimpleSpriteBurst`
>
> 可见状态:
> - `SimpleSpriteBurst` 发射器被选中，标注 `GPU`。
> - 右侧详情面板选中 `Emitter State`。
> - 日志区域显示 `System successfully compiled.`。
>
> 可见模块结构:
> - `Emitter Update`: `Emitter State`，标注 `Self`、`Infinite`。
> - `Particle Spawn`: `Sample Texture`、`Initialize Particle`。
> - `Particle Update`: `Particle State`、`Scale Color`、`Solve Forces and Velocity`。
> - `Render`: `Sprite Renderer`。
>
> Emitter State 参数:
> - `Life Cycle Mode = Self`。
> - `Inactive Response = Complete (Let Particles Finish then...)`。
> - `Loop Behavior = Infinite`。
> - `Loop Duration = 2.0`。
> - `Scalability Mode = System`。
>
> 验证方式:
> - 初始 Sample Texture 系统应以 GPU Sprite 发射器运行，并在 Particle Spawn 阶段加入 `Sample Texture`。
> - 空间证据边界: 预览窗口显示环境画面，不作为粒子位置、发射区域或相机空间证据。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Sample Texture UV Setup
> - Niagara System: `NS_SampleTexture`
> - Emitter: `SimpleSpriteBurst`
> - Module: `Sample Texture`
>
> 可见状态:
> - `Sample Texture` 模块被选中，位于 `Particle Spawn`。
> - Stack 中可见 `Spawn Particles in Grid`，并且 `Particle Spawn` 下已有 `Grid Location`、`Sample Texture`、`Initialize Particle`。
>
> Texture 输入:
> - `Texture` 输入类型为 `Texture Sample`。
> - `Texture = T_cracksFirey_01`。
> - `Texture User Parameter = None`。
>
> UV 输入:
> - `UV` 使用 `Make Vector 2D`。
> - `X` 使用 `Make Float from Vector`。
> - `Vector = Output.GridLocation.Normalized Array Location`。
> - `Channel = X`。
> - `Y` 当前可见值为 `0.0`。
> - 下拉菜单中正在搜索 `mak`，可见 Dynamic Inputs 包含 `Make Float from Vector`、`Make Float from Vector 2d` 等选项。
>
> 验证方式:
> - 采样纹理的 UV 至少应把 Grid Location 的归一化数组位置拆分为 2D UV 输入的一部分；截图明确显示 X 通道来源。
> - 空间证据边界: `GridLocation.Normalized Array Location` 是 Niagara 模块输出字段；不解释为世界坐标、屏幕坐标或关卡网格坐标。

### 00:05:01-00:09:50 Niagara、Color、UV

- 本段定位：Niagara、Color、UV。
- 知识点：就是这样 这是UV的设置 而我们仍然看不到我们的纹理 那是因为我们需要设置几个更多的属性 所以,向下倒出实话例子 对于这里的颜色。
- 知识点：叫做Sample Color 所以,这是我们纹理中的颜色 需要去这个输实话例子 并把它改为 采样颜色。
- 知识点：现在可观察到 在深入提取颜色信息 从纹理中 但我们仍然看不到我们想要的纹理 原因是这里的定位模式 所以,在这里做的任何事情都在隔中的生成例子。
- 知识点：最后,需要降低 这个小的精灵大小 所以将它降低到1 这样,我们就有了我们的纹理 好了,需要把这个Niagara系统拖到我的关卡中。
- 知识点：好了,再抬高一点 这样就好了 我们正在使用Niagara系统来采样一个纹理 我们有的 并为一个挑战而设计 所以挑战允许你使用网格位置和采样。
- 知识点：我们使用一个模块通过Niagara来采用纹理 这些是我使用的模块 在网格中生成粒子 并使用网格位置内的参数。
- 知识点：作为这个模块采用纹理的UV 为了看到纹理 我们还需要使用参数 这个模块正在写入采用纹理 采样颜色作为粒子的颜色。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Niagara`、`Color`、`Texture`、`纹理`、`粒子`、`系统`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Initialize Particle
> - Niagara System: `NS_SampleTexture`
> - Emitter: `SimpleSpriteBurst`
>
> 可见状态:
> - `Initialize Particle` 模块被选中。
> - 右上显示约 `65,536 Particles`。
> - Stack 中 `Particle Spawn` 阶段包含 `Grid Location`、`Sample Texture`、`Initialize Particle`。
>
> 关键参数:
> - `Lifetime Mode = Direct Set`。
> - `Lifetime = 2.0`。
> - `Color Mode = Direct Set`。
> - `Color` 字段可见 `R = 1.0`、`G = 1.0`、`B = 1.0`、`A = 1.0`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 未启用，灰显字段为 `X = 0.0`、`Y = 0.0`、`Z = 0.0`。
> - `Mass Mode = Unset / (Mass of 1)`。
> - `Sprite Size Mode = Uniform`，`Uniform Sprite Size = 50.0`。
> - `Sprite Rotation Mode = Unset`。
> - `Sprite UV Mode = Unset`。
>
> 验证方式:
> - 此状态下粒子尺寸仍为 `50.0`，预览尚未表现为清晰纹理图案；后续需要通过颜色采样和尺寸缩小继续调整。
> - 空间证据边界: `Position Offset` 字段灰显且未启用；不从灰显 `0.0` 推导实际发射空间。
> 图表转写（UE-GTXT v4）
> - 类型: Challenge Slide + Emitter Module Checklist
> - Emitter: `SimpleSpriteBurst`
>
> 画面文字:
> - 标题: `CHALLENGE`。
> - 要求 1: `Use GridLocation and SampleTexture to sample texture through niagara`。
> - 要求 2: `Add forces that you see fit to the particles`。
>
> 左侧模块结构:
> - `Emitter Update`: `Emitter State`、`Spawn Particles in Grid`。
> - `Particle Spawn`: `Grid Location`、`Sample Texture`、`Initialize Particle`。
> - `Particle Update`: `Particle State`、`Scale Color`、`Solve Forces and Velocity`。
> - `Render`: `Sprite Renderer`。
>
> 验证方式:
> - 挑战目标是用 `GridLocation` 提供采样位置，用 `SampleTexture` 采样贴图，并可按需要添加力模块。
> - 空间证据边界: 幻灯片只给模块与任务要求；不定义网格的场景坐标、采样平面朝向或粒子运动方向。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System Actor Instance Parameters
> - Niagara System: `NS_SampleTexture`
>
> 可见状态:
> - 关卡中的展示墙标题为 `Sample Texture`。
> - Content Browser 中选中 `NS_SampleTexture` 资源。
> - 资源 Tooltip 显示路径 `/Game/Niagara/CustomNiagaraModule/SampleTexture`。
> - World Outliner 中可见并选中 `NS_SampleTexture`，类型为 `NiagaraActor`。
> - Details 面板显示 `NS_SampleTexture (Instance)` 与 `NiagaraComponent (NiagaraComponent0)`。
>
> Tooltip 统计:
> - `Texture: 1`。
> - `Curve Base: 1`。
> - `Epic Emitters: 1`。
> - `Active Emitters: 1`。
> - `Active Renderers: 1`。
> - `Sprite Renderer: 1`。
> - `Has GPUEmitter: True`。
>
> 验证方式:
> - Niagara 系统已作为 Actor 放入 Sample Texture 展示区域，并保持单发射器、单 Sprite Renderer 的资源结构。
> - 空间证据边界: 该图证明 Actor 存在于关卡中；不从屏幕位置或展示墙画面推断 Actor transform。

### 00:09:52-00:12:54 Niagara、Alpha、粒子

- 本段定位：Niagara、Alpha、粒子。
- 知识点：回到我的关卡 点击这个Niagara系统并向上滚动 可观察到在下拉菜单下使用这里的参数。
- 知识点：可以指定我们想要的纹理 好了,需要在这里尝试不同的纹理 所以需要回到这个InfinityVFX纹理。
- 知识点：相对于火焰链纹理不太理想 也许这个火环,需要把它放进去 好啦,看起来好多了 或者这个梯和骷髅火焰痕迹 可观察到这是我的效果 所以我认为这些火焰链纹在这里看起来最好。
- 知识点：而且,可以试个来尝试不同的纹理 如果你喜欢,好啊,还有一件事需要给你看 所以需要回到我的Niagara系统。
- 知识点：在这里采样的纹理 它有一个Alpha通道 可以用它来消除某些粒子 我们不需要的 我是什么意思呢? 首先,在粒子生成阶段。
- 知识点：需要调出消除粒子模块 我相信你已经对这个模块非常熟悉了 通过使用这里的布尔值 后续会消除所有的粒子。
- 知识点：因为在这里采样的纹理 它有一个Alpha通道 需要消除那些粒子 那些采样透明背景的粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`Alpha`、`纹理`、`粒子`、`发射器`、`系统`、`颜色`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Actor User Parameter
> - Niagara System: `NS_SampleTexture`
>
> 可见效果:
> - Sample Texture 展示墙上可见橙红色裂纹状粒子图案。
> - World Outliner 中 `NS_SampleTexture` 被选中。
>
> Details 面板:
> - `User Parameters` 下有 `Texture` 参数。
> - 参数类型显示 `Niagara Data Interface Texture`。
> - `Texture = T_cracksFirey_01`。
> - `Texture User Parameter = None`。
> - `Activation / Auto Activate` 已勾选。
>
> 操作语境:
> - 这里开始通过 Actor 实例的 User Parameter 尝试替换不同纹理，观察采样结果。
>
> 验证方式:
> - 替换采样纹理时，应在 `NS_SampleTexture` 实例的 `User Parameters / Texture` 中选择纹理资源，并观察展示墙粒子图案变化。
> - 空间证据边界: 橙红图案只作为采样效果预览；不从图案在墙面上的位置换算粒子网格尺寸或发射平面坐标。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Kill Particles Module
> - Niagara System: `NS_SampleTexture`
> - Emitter: `SimpleSpriteBurst`
>
> 可见状态:
> - 右上显示约 `65,536 Particles`。
> - `Kill Particles` 模块被选中，位于 `Particle Spawn`。
> - 预览窗口显示裂纹纹理采样图案，透明背景对应区域仍可见较多粒子。
>
> 可见模块结构:
> - `Emitter Update`: `Emitter State`、`Spawn Particles in Grid`。
> - `Particle Spawn`: `Grid Location`、`Sample Texture`、`Initialize Particle`、`Kill Particles`。
> - `Particle Update`: `Particle State`、`Scale Sprite Size`、`Scale Color`、`Acceleration Force`、`Curl Noise Force`、`Solve Forces and Velocity`。
> - `Render`: `Sprite Renderer`。
>
> Kill 参数:
> - `Kill Particles` 输入存在，但当前可见为未展开/未设置的布尔输入状态。
>
> 验证方式:
> - `Kill Particles` 已插入 Particle Spawn，后续需将其布尔输入接入纹理 Alpha 或比较结果，以剔除透明背景采样粒子。
> - 空间证据边界: 裂纹预览只说明采样图案可见；不从粒子图形估算采样平面尺寸或场景坐标。
> 图表转写（UE-GTXT v4）
> - 类型: Final Sample Texture Actor Preview
> - Niagara System: `NS_SampleTexture`
>
> 可见状态:
> - Sample Texture 展示墙上只隐约保留橙红色采样纹理粒子，背景区域粒子明显减少。
> - World Outliner 中 `NS_SampleTexture` 仍被选中。
> - Details 面板的 `User Parameters / Texture` 仍显示 `Texture = T_cracksFirey_01`。
> - `Texture User Parameter = None`。
> - `Activation / Auto Activate` 已勾选。
>
> 验证方式:
> - 此图用于确认透明背景粒子剔除后的最终视觉状态: 采样纹理区域保留，背景区域的粒子数量降低。
> - 空间证据边界: 最终画面只作为可见性验收；不从墙面图案位置推断粒子网格坐标、UV 尺寸或 Actor transform。

## 补充视觉证据

### S03 00:11:40

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Kill Particles Parameter Supplement
> - Niagara System: `NS_SampleTexture`
> - Emitter: `SimpleSpriteBurst`
>
> 可见状态:
> - `Kill Particles` 模块被选中，位于 `Particle Spawn`。
> - `Kill Particles` 输入已配置为动态布尔表达式。
>
> Kill 条件:
> - 输入方式: `Set Bool by Float Comparison`。
> - `A = 1.0`。
> - `B = 0.0`。
> - `Comparison Type = A Greater Than B`。
>
> 模块语境:
> - `Particle Spawn` 阶段包含 `Grid Location`、`Sample Texture`、`Initialize Particle`、`Kill Particles`。
> - `Particle Update` 阶段包含 `Particle State`、`Scale Sprite Size`、`Scale Color`、`Acceleration Force`、`Curl Noise Force`、`Solve Forces and Velocity`。
>
> 验证方式:
> - Kill 条件应返回布尔值以控制粒子是否被剔除；截图未展开 A 的上游来源，因此只记录当前可读比较表达式。
> - 空间证据边界: 该参数面板不包含空间写入；不从预览网格或粒子分布推导坐标。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


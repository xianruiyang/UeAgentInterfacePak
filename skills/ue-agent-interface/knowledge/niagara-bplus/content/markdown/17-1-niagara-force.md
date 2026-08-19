# 17-1-利用-Niagara-Force-高级模块

# 17-1-利用-Niagara-Force-高级模块

## 关键术语

- `Emitter`、`Color`、`Alpha`、`Material`、`Multiply`、`粒子`、`发射器`、`网格`、`光束`、`速度`、`Niagara`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`材质`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:05-00:04:48 粒子、这次我们要一起看看剩下的模块

- 本段定位：粒子、这次我们要一起看看剩下的模块。
- 知识点：你好在第17课问候你 这次我们要一起看看剩下的模块 大约有七八个模块 那么就不会太深入地看一下选项 可以一起看看概念性的部分 需要做一个用于测试的。
- 知识点：我们边做一个模块边进行 首先把大小做的小一点 生成了大约100个 我们之前总是用过kill particle几次。
- 知识点：现在这个kill particle的体积我从来没有用过 我来看看这个 用shape location大约做了200 那么在200的球体大小里现在生成了100个粒子。
- 知识点：的kill particle体积设置为100的球体 并且是启用状态 还有启用数据 这意味着符合这个条件的粒子正在被杀死。
- 知识点：现在看这里的particle 应该显示所有的数量 但是这里显示了不到100个 那个话题是现在在200这个大小里 现在看不见的体积存在着。
- 知识点：进入这个形状的粒子是 现在可以被消灭的状态 这现在看不出区别是因为 在大约100的这个形状大小里 这有点立体 现在这里的空隙看不太清楚。
- 知识点：因为反转了 不属于这里的其余部分在外面 不属于这里的其余部分在外面 外面其余的粒子正在被删除。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Particle`、`粒子`。

**关键画面：**

这张图是第 17 课 `利用 Niagara Force 高级模块` 的开场定位图，用来说明课程仍然在同一个测试关卡中展开，但本课会从 `Course_03` 资源目录继续向下做新的 Force 模块实验。

当前画面可直接确认的信息如下：

- 当前关卡标签为 `Ex_01_SpriteExp*`
- Outliner 中当前可见对象包括：
  - `Lighting`
  - `DirectionalLight`
  - `SkyLight`
  - `SM_SkySphere`
  - `Ex_01_SpriteExp`
  - `Floor`
  - `PlayerStart`
  - `PostProcessVolume`
- 视口中当前没有可见角色或粒子系统实例，只显示空场地和编辑器图标

左下内容浏览器当前位于：

- `Content/Signature/Course_03`

该目录下能直接看到 6 个子文件夹：

- `Level`
- `Material`
- `Mesh`
- `Particles`
- `Sequencer`
- `Texture`

这张图的意义是为后续 Force 模块实验建立起点：

- 课程场景已回到空测试关卡
- 资源工作目录仍然是 `Course_03`
- 本课接下来要在这个目录内继续创建新的 Niagara 测试系统

当前截图不包含 Niagara Stack、Emitter 或材质节点，因此它只承担“环境与目录定位”的作用。
这张图展示本课的第一个高级模块示例：在简单球形粒子发射基础上加入 `Kill Particles in Volume`，用一个不可见的体积区域直接剔除落入其中的粒子。

当前画面可直接确认的系统结构如下：

- 系统名：`NewNiagaraSystem13`
- 系统面板可见：
  - `Properties`
  - `User Parameters`
  - `System Spawn`
  - `System Update`
  - `System State`

当前唯一发射器为 `Empty`，可直接确认的模块结构如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `89 Current, 190 Max (est.) - [Empty] [Active]`
- 预览里只剩不到一百个白色粒子，且分布在一个球状区域外围，看起来像中间被掏空了一部分

右侧 `Kill Particles in Volume` 详情面板可直接确认的参数如下：

- `Kill Shape = Sphere`
- `Sphere Radius = 100.0`
- `Kill Volume Enabled` 已开启
- `Invert Volume` 关闭
- `Volume Origin = Simulation Position`
- `Origin Offset = (0.0, 0.0, 0.0)`

根据当前图可以直接还原本步骤的核心逻辑：

- 先用 `Shape Location` 生成一个球形分布的粒子群
- 再在同一空间中叠加一个半径为 `100` 的球形“击杀体积”
- 所有落入这个球形体积的粒子会被直接删除

因为 `Invert Volume` 当前关闭，所以这里应理解为“球内粒子被杀死，球外粒子保留”。这也解释了为什么左侧只看到外围残留的粒子，而中间体积区域像被挖空一样。
这张图继续使用同一个 `Kill Particles in Volume` 示例，但相比上一张，粒子总数已经明显提高，剔除后的结果也更容易看出“中间被挖空、外层保留”的立体球壳结构。

当前画面可直接确认的系统与发射器结构如下：

- 系统：`NewNiagaraSystem13`
- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `889 Current, 1888 Max (est.) - [Empty] [Active]`
- 预览中可以直观看到一个空心球壳式的粒子分布：
  - 外圈和边缘留有大量粒子
  - 中心区域相对稀疏甚至接近空洞
  - 整体比上一张的 `89` 粒子版本更容易观察体积剔除效果

右侧 `Kill Particles in Volume` 参数当前仍与上一张一致，可直接确认：

- `Kill Shape = Sphere`
- `Sphere Radius = 100.0`
- `Kill Volume Enabled` 已开启
- `Invert Volume` 关闭
- `Volume Origin = Simulation Position`
- `Origin Offset = (0.0, 0.0, 0.0)`

因此，这张图的价值不在于新增参数，而在于展示同样的球形剔除逻辑在更高粒子量下的可视化效果：

- 球形击杀体积本身不可见
- 但被删掉的内部粒子会让剩余粒子自然形成一个“外层壳”
- 粒子数增多后，这种空腔结构会比低粒子量时更清楚

### 00:04:49-00:09:41 粒子

- 本段定位：粒子。
- 知识点：如果放入200的话 现在因为是反转状态 使得粒子都被消灭了 大约150 试试190吧 那么无论如何 现在几乎都是 都在于surface里生成的粒子。
- 知识点：可以认为他们会存活 这种方式可以利用的模块 这个很简单 是Qparticle in volume 然后这种方式可以再进行分组 可以用的模块叫Mask搜索一下。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：是Ranger Mask in volume和项构成 就是A,B,R,T 这里是一样的 根据这个shape 可以决定半径也是对的 所以这种Mask。
- 知识点：你的regent mask带有名字的面板 伏点数和内部研码都有 一个是布尔选项,一个参数 一个是伏点参数。
- 知识点：都被打勾为真 那个不是的粒子会显示为假 是的 所以这里已经成为粒子参数 因为是火 如果在这里放入内部面具或选项 中间就会消失 这里也有反转区域。
- 知识点：如果反转 是的,就像这样 刚才是有真的粒子的中间 现在反而存活下来 因为在杀死粒子时 有真的粒子的会被杀。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Particle`、`粒子`。

**关键画面：**

这张图展示把 `Kill Particles in Volume` 的球形半径调大到 `200` 后的极端情况。当击杀体积完全覆盖住原本的球形生成区域时，当前粒子会被全部删除，因此预览窗口中不再有任何存活粒子。

当前画面可直接确认的系统与发射器结构如下：

- 系统：`NewNiagaraSystem13`
- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `0 Current, 1000 Max (est.) - [Empty] [Active]`
- 预览窗口为空，没有任何可见粒子

右侧 `Kill Particles in Volume` 当前可直接确认的参数如下：

- `Kill Shape = Sphere`
- `Sphere Radius = 200.0`
- `Kill Volume Enabled` 已开启
- `Invert Volume` 关闭
- `Volume Origin = Simulation Position`
- `Origin Offset = (0.0, 0.0, 0.0)`

这张图证明：当 `Kill Volume` 的球半径大于或等于粒子初始分布范围时，所有粒子都会直接被删除。因此如果示例里什么都看不见，应优先检查这一半径是否过大。
这张图继续使用同一个 `Kill Particles in Volume` 示例，但把粒子数量恢复到更高水平后，可以更清楚地看到“球内被删、球外保留”形成的空心球壳结构。

当前画面可直接确认的系统与发射器结构仍然是：

- 系统：`NewNiagaraSystem13`
- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `889 Current, 1888 Max (est.) - [Empty] [Active]`
- 预览中可以看到一个较清晰的空心球壳：
  - 外层粒子大量保留
  - 中心区域接近空洞

右侧 `Kill Particles in Volume` 当前可直接确认的参数如下：

- `Kill Shape = Sphere`
- `Sphere Radius = 100.0`
- `Kill Volume Enabled` 已开启
- `Invert Volume` 关闭
- `Volume Origin = Simulation Position`
- `Origin Offset = (0.0, 0.0, 0.0)`

这张图的意义是效果验证：不可见的球形击杀体积正在把内部粒子删除，留下外围粒子形成可读性很强的空腔外壳。
这张图展示本段后半已经从单纯的 `Kill Particles in Volume`，推进到“`Shape Location` + `Region Mask` + `Kill Particles`”的组合方案。教程开始把区域判断结果写入粒子参数，再用后续剔除模块控制哪些粒子存活。

当前画面可直接确认的系统与发射器结构如下：

- 系统：`NewNiagaraSystem13`
- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `1000 Current, 2000 Max (est.) - [Empty] [Active]`
- 预览中重新出现完整球状粒子群

左下粒子属性列表中，当前能直接看到 `Region Mask` 已经写入粒子参数：

- `PARTICLES REGION MASK Float`
- `PARTICLES REGION MASK IsInsideMask`

同时还能看到 `Shape Location` 输出属性：

- `ShapeBitangent`
- `ShapeNormal`
- `ShapePosition`
- `ShapeTangent`
- `ShapeVector`

右侧当前选中的是 `Shape Location`，可直接确认的参数如下：

- `Shape Primitive = Sphere`
- `Sphere Radius = 200.0`

`Distribution` 分组：

- `Sphere Distribution` 页签包含 `Random`、`Direct`、`Uniform`
- `Sphere Surface Distri... = 0.0`
- `Hemisphere Distributi... = (1.0, 1.0)`

`Transform` 分组：

- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`

这张图的重要变化在于流程设计：

- 不再只靠 `Kill Particles in Volume` 直接删粒子
- 而是先通过 `Region Mask` 生成“是否位于遮罩内”的粒子参数
- 后续再交给 `Kill Particles` 根据这个参数决定谁该被删除

这种做法比单纯使用体积剔除更灵活，因为区域判断结果已经被保存在粒子属性里，后面可以继续拿去做反转、分组或其他条件控制。

### 00:09:41-00:14:20 Color、Alpha、Material

- 本段定位：Color、Alpha、Material。
- 知识点：这次就用这个辅点值 这个color值我先验证效果 转换成flow 这里用一下low to向量 线性差值向量 在material中常用。
- 知识点：这里alpha值 region mask数值需要放这里 这样看 这里是归一化的0到1值 这个值作为线性差值的这个alpha值 就用上了。
- 知识点：对应0的这个粒子们 红色频道呈现红色 如果变得接近1值的话 就会变成绿色频道 反转值好像有点反了 所以红色 这里a值是1,d值是0 现在感觉这样没错。
- 知识点：如果反过来处理区域的话 颜色就会反过来表现 所以这种话 如果想要根据特定条件进行分组的话 可以这样使用 这是可以使用的模块 遮罩条件距。
- 知识点：还有衰减的部分 是减量的意思 多少线性的 0.5就是一半 可以看作线性的值 然后根据值 现在a的值的比重有多少 b的值的比重有多少 就可以决定这个程度。
- 知识点：可以看作是falloff选项的值 而且现在根据这个outvalue 现在从0到1了 正在归一化的意思 还有offset rotation。
- 知识点：可以简单理解为变换 现在我们做这个模型是因为mouse功能 在简单工作中用处不大 这种情况是现在 以后做交互相关的效果是 因为交互这种功能的表达。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Material`、`粒子`、`速度`、`颜色`。

**关键画面：**

这张图展示 `Region Mask` 模块写入粒子属性后的实际数据结果。教程此处通过右侧 `Attribute Spreadsheet` 直接核对每个粒子的遮罩浮点值与布尔判定值，验证该模块确实已经把“是否位于遮罩内”的信息写到了粒子实例上。

当前画面可直接确认的系统与发射器结构如下：

- 系统：`NewNiagaraSystem13`
- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `1000 Current, 2000 Max (est.) - [Empty] [Active]`
- 预览中仍是一团球状粒子分布

左下粒子属性列表中，当前能直接看到：

- `PARTICLES REGION MASK Float`
- `PARTICLES REGION MASK IsInsideMask`

右侧 `Attribute Spreadsheet` 当前以实例表格形式展示了两列关键属性：

- `RegionMask.Float`
- `RegionMask.IsInsideMask`

从表中可直接确认的样例数据包括：

- 有些实例的 `RegionMask.Float = 1`，对应 `IsInsideMask = True`
- 也有实例显示中间值，例如：
  - `0.556 -> False`
  - `0.391 -> False`
  - `0.884 -> False`
  - `0.616 -> False`
  - `0.911 -> False`
  - `0.713 -> False`
  - `0.926 -> False`
- 还有若干实例 `RegionMask.Float = 0`，对应 `IsInsideMask = False`

从这张图可以直接得出两个关键结论：

- `Region Mask` 并不只输出一个简单的二元结果，还会给出一个 `0~1` 范围内的归一化浮点值
- 同时它也会额外输出一个布尔值 `IsInsideMask`，便于后续 `Kill Particles` 或其他模块直接做条件判断

因此，复现时如果想按区域做颜色、透明度或分组控制，可以优先使用 `RegionMask.Float`；如果只想做“在/不在区域内”的开关判断，则可以直接使用 `RegionMask.IsInsideMask`。
这张图展示 `Region Mask` 的实际参数设置，以及如何把它输出的线性值直接拿来做颜色可视化。预览里红、黄、绿三种颜色分层分布，正是在验证 `Region Mask` 从中心到外圈的 `0~1` 归一化渐变结果。

当前画面可直接确认的发射器结构如下：

- 发射器：`Empty`
- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
- `Render`
  - `Sprite Renderer`

左侧预览与统计信息：

- 当前统计为 `1000 Current, 2000 Max (est.) - [Empty] [Active]`
- 预览中粒子被明显分成不同颜色层：
  - 中心附近偏红
  - 中间过渡为黄
  - 外圈偏绿

右侧 `Region Mask` 当前停留在 `All` 页签，可直接确认的参数如下：

- 页签包含：
  - `Region`
  - `Transform`
  - `Output`
  - `All`

`Region` 分组：

- `Region Type = Sphere`
- `Region Origin = Simulation Position`
- `Region Radius = 200.0`
- `Region Falloff = 0.5`
- `Invert Region` 已开启

`Transform` 分组：

- `Offset Space = Simulation`
- `Transform Order = Offset-Rotation`
- `Offset = (0.0, 0.0, 0.0)`
- `Rotation = (0.0, 0.0, 0.0)`

`Output` 分组：

- `Value Type = Float`
- `Inner Float = 1.0`
- `Outer Float = 0.0`

这张图能直接说明 `Region Mask` 的工作方式：

- 先定义一个球形区域
- 通过 `Region Falloff = 0.5` 让区域边界出现线性过渡，而不是硬切换
- `Inner Float` 和 `Outer Float` 定义区域内外两端的数值
- 开启 `Invert Region` 后，内外语义会被翻转

结合颜色预览，可以把这一步理解为：把 `RegionMask.Float` 作为线性插值权重，映射到不同颜色通道上，从而直观看到遮罩值从 0 到 1 的渐变过程。
这张图展示教程在进入 `WaveForms` 发射器后的初始搭建结果：通过一个自定义 `Waveform` 生成模块，在粒子生成时按 `Emitter Age` 驱动波形值，再把该波形用于偏移生成位置，因此左侧预览里会出现沿水平方向展开的多条彩色波形线。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- 旧发射器 `Empty` 已禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `150 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览可见白色、青色、紫色的波形线条
- 底部时间轴区域可见 `240 fps`

当前 `WaveForms` 发射器的结构如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧当前打开的是 `Waveform` 模块参数面板，标题说明可直接读到：这是一个“使用波形来偏移生成位置”的模块。界面可见页签为：

- `Setup`
- `Waveform [1]`
- `All`

`Setup` 分组当前参数：

- `Waveform Count = [1] One`
- `Global Input Position = 0.0`
- `Global Phase = EMITTER Age`
- `Global Amplitude Scale = 1.0`
- `Global Clamp Min = 0.0`
- `Global Clamp Max = 1.0`

`Waveform [1]` 分组当前参数：

- `Waveform [1] = Compound Sin/Cos`
- `[1] Input Position = 0.0`
- `[1] Phase = EMITTER Age`
- `[1] Phase Scale = 1.0`
- `[1] Compound Freq = 2.0`
- `[1] Frequency = 1.0`
- `[1] Amplitude Min/Max = 0.0 / 1.0`
- `[1] Scale = 1.0`
- `[1] Bias = 0.0`
- `[1] Exponent = 1.0`

按这张图复建时，可以先把它理解成两层结构：

- `Emitter Update` 里的 `Waveform 001` 负责基于发射器年龄持续生成波形值
- `Particle Spawn` 里的 `Waveform` 模块在粒子出生瞬间读取该波形结果，并把它转成生成位置偏移

因此，这一步的核心不是改粒子颜色或速度，而是先建立一套“随时间变化的生成位置分布函数”。当 `Phase` 绑定到 `EMITTER Age`，且波形类型为 `Compound Sin/Cos` 时，粒子会沿波形轨迹持续刷新出生位置，最终在视口中形成当前这种流动的多段波浪线外观。

### 00:14:20-00:18:56 Color

- 本段定位：Color。
- 知识点：三cossine 买充三角 随机这些 浮动数值只是高低来会变化的 所以呈现出这种图形 waveform就是这么命名的模块 最多可以制作三个。
- 知识点：我们之前展示过sine和cossine的图 所以这里 这个是方形的 基本上这种固定模式的图 使用性大致相似 sine cossine 买充。
- 知识点：复合sine 缩sine 这个可以看作是两个有点合并的东西 正方形是方形吧 正方形是无限的天使 贝拉被召唤 所以正方形使用性不是很好 卖充的间隔也有点太大。
- 知识点：几乎可能是最常用的sine cossine 在这个波形情况下 或者就是用随机的 所以这只是这样模块参数。
- 知识点：生成这种波形的属性 然后现在这个动画图形 浮动值作为属性就出来了 现在这种行动出现的原因是 这里也在用nurb color 所以有的变成紫色。
- 知识点：有的变成绿色 这在0到1之间不断变化 现在用sine来做 sine图形周期是这个样子的 然后coss也是一样 所以您可以认为 那是我展示的图形是一样的。
- 知识点：它在不断来回 而这两个角 就是这样被表示的 这里的位置偏移直 里也有Z直 波形也是在里面 现在可以认为是在-20和20之间来会移动 这里也是用multiplot。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`Color`。

**关键画面：**

这张图展示 `WaveForms` 发射器中 `Waveform` 生成模块的波形类型选择界面。教程此处是在说明该模块并不只支持一种曲线，而是可以切换多种预设波形，再用这些波形去驱动粒子生成位置的偏移，所以左侧预览里已经能看到一条随时间变化的彩色波浪轨迹。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- 旧发射器 `Empty` 保持禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `85 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览可见一条由白、青、紫混合而成的波浪状粒子轨迹
- 底部时间轴当前时间约为 `4.43`
- 底部面板可见 `240 fps`

当前 `WaveForms` 发射器结构：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧当前打开的是 `Waveform` 模块，顶部说明文字表明该模块用途是“使用波形来偏移生成位置”。当前界面停留在 `All` 页签，并且已经展开 `Waveform [1]` 的波形类型下拉框。

`Setup` 分组当前能直接确认的参数：

- `Waveform Count = [1] One`
- `Global Input Position = 0.0`
- `Global Phase = EMITTER Age`
- `Global Amplitude Scale = 1.0`
- `Global Clamp Min = 0.0`
- `Global Clamp Max = 1.0`

`Waveform [1]` 分组中，当前已选波形为：

- `Waveform [1] = Compound Sin/Cos`

下拉列表中可直接看到该模块支持的波形类型包括：

- `Sine`
- `Cosine`
- `Compound Sin/Cos`
- `Pendulum`
- `Square`
- `Pulse`
- `Triangle`
- `Sawtooth`
- `Random`
- `Random Blend`
- `Random Spline`
- `Random Spline Smooth`
- `Random Spline Segmented`

这张图的关键含义是：`Waveform` 模块本质上是一个“波形函数选择器 + 参数化偏移器”。教程此处强调，除了最常见的 `Sine`、`Cosine` 之外，还可以切到脉冲、三角波、随机样条等模式，因此生成位置的时间变化轨迹不局限于平滑正弦线，而可以扩展成阶梯、脉冲或随机抖动式分布。
这张图展示把 `Waveform [1]` 的波形类型切换为 `Sine` 之后的结果。教程此处是在用最基础的正弦波来解释这个模块如何影响粒子出生位置，因此左侧预览变成了周期均匀、峰谷平滑的连续弧线。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- `Empty` 发射器保持禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `150 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览中可见数段连续的正弦形粒子轨迹，颜色以白色到紫色渐变为主
- 底部时间轴当前时间约为 `3.99`
- 底部面板可见 `240 fps`

当前 `WaveForms` 发射器结构仍为：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Waveform` 模块当前停留在 `All` 页签，可直接确认的参数如下：

`Setup` 分组：

- `Waveform Count = [1] One`
- `Global Input Position = 0.0`
- `Global Phase = EMITTER Age`
- `Global Amplitude Scale = 1.0`
- `Global Clamp Min = 0.0`
- `Global Clamp Max = 1.0`

`Waveform [1]` 分组：

- `Waveform [1] = Sine`
- `[1] Input Position = 0.0`
- `[1] Phase = EMITTER Age`
- `[1] Phase Scale = 1.0`
- `[1] Frequency = 1.0`
- `[1] Amplitude Min/Max = 0.0 / 1.0`
- `[1] Scale = 1.0`
- `[1] Bias = 0.0`
- `[1] Exponent = 1.0`

从这张图可以直接看出，`Sine` 模式下的位置偏移是标准周期波：

- 峰值和谷值之间过渡平滑
- 相邻波峰间距规则，说明频率当前保持默认节奏
- `Phase` 绑定到 `EMITTER Age` 后，整条生成轨迹会持续随发射器时间推进

因此，复建时如果想先获得最稳定、最容易观察的波形效果，应优先从 `Sine` 起步，再在此基础上修改 `Frequency`、`Scale`、`Bias` 或改用其他波形类型。
这张图展示 `Initialize Particle` 如何直接读取前面 `Waveform` 模块输出的波形值，并把它应用到粒子的颜色、Z 方向位置偏移和精灵尺寸上。教程此处的重点已经不是“波形长什么样”，而是“如何把波形值接到粒子属性上”，所以右侧面板切换到了 `Initialize Particle`。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- `Empty` 发射器保持禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `150 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览仍显示多段平滑的波浪状粒子轨迹，颜色以白到紫的渐变为主

当前 `WaveForms` 发射器结构仍为：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Initialize Particle` 当前停留在 `All` 页签，可直接确认的设置如下：

`Point Attributes`：

- `Lifetime Mode = Direct Set`
- `Lifetime = 3.0`
- `Color Mode = Direct Set`
- `Color = Lerp Linear Colors`
  - `StartColor` 为亮绿色
  - `EndColor` 为紫色
  - `LerpFactor = PARTICLES.WAVEFORM Waveform`
- `Position Mode = Simulation Position`
- `Position Offset = Make Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = Lerp Float`
    - `A = -20.0`
    - `B = 20.0`
    - `Alpha = PARTICLES.WAVEFORM Waveform`
- `Position Offset Coordinate Space = Simulation`
- `Mass Mode = Unset (/ Mass of 1)`

`Sprite Attributes`：

- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = Multiply Float`
  - `A = 5.0`
  - `B = PARTICLES.WAVEFORM Waveform`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

左下 `Active Overview` 里还能直接看到该发射器当前已经存在 `PARTICLES.WAVEFORM Waveform` 输出项，这说明前一个 `Waveform` 模块已经把结果写成粒子属性，供 `Initialize Particle` 在同一生成阶段继续使用。

按这张图复建时，可以把连接关系理解成三条并行映射：

- 颜色：用 `Waveform` 作为 `LerpFactor`，在绿色和紫色之间插值
- 位置：用同一个 `Waveform` 作为 `Lerp Float` 的 `Alpha`，把 `Z` 偏移控制在 `-20` 到 `20` 之间
- 尺寸：用 `Multiply Float` 把基础尺寸 `5.0` 按 `Waveform` 再做一次缩放

因此，这一步的核心是把一个统一的波形驱动值同时分发给颜色、空间位置和尺寸三个属性，让粒子轨迹不仅沿波形起伏，还会伴随颜色和体量的同步变化。

### 00:18:56-00:23:44 Emitter、Multiply、粒子

- 本段定位：Emitter、Multiply、粒子。
- 知识点：可以理解为更强的增益 我总是说造成了三个要素时 我们制作相机抖动时 曾经出现过的问题 周期放大和偏移是做不了移动 所以这些部分也是这样给信号。
- 知识点：感觉也是在走造生的方向 所以这些部分我的想法是 制作的模式也是一样 使用这种随机模式时总是 这三个可以说总是像套装一样一起到来 所以如果改变周期的数字。
- 知识点：重复度就会更多 同样的以这种方式出现 这里同样 因为是那个阶段缩放 所以会重复更多 有幅度最小最大值 还有缩放 翻译结果又会更大了 所以这个可以分成这两种。
- 知识点：因为可以通过眼睛直观地确认 所以我觉得可以充分利用 还有这里阶段的标准值 现在设定为年龄 年龄没有归一化 所以持续保持一定速度。
- 知识点：保持放大值 如果这样归一化的话 可以认为这里以2为基准 会形成一个2秒的周期 这样利用也可以 直接用A值也可以 或者这里用Multiply。
- 知识点：Float 加成A值加快二倍 这种话 也可以调整这种速度 所以像这种Waveform模块 肯定会有用的元素 在这里用Emitter复制。
- 知识点：在Emitter上可以提前做好这种模式 也可以用得上 那么下一个模块看看吧 下一个这个导入使用看看 网格旋转力 说到力的话 通常是粒子的位移。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Emitter`、`Multiply`、`粒子`、`速度`。

**关键画面：**

这张图展示在 `Waveform` 模块中直接提高全局振幅缩放后的效果。教程此处是在说明波形控制常见的三个维度之一是“振幅”，也就是让同一种波形在不改变周期的前提下，整体上下起伏更大，因此左侧预览里的正弦曲线明显比前一组截图更高、更饱满。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- `Empty` 发射器保持禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `150 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览中可见多段更高振幅的紫色正弦波轨迹

当前 `WaveForms` 发射器结构仍为：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧当前仍是 `Waveform` 模块的 `All` 页签，可直接确认的关键参数如下：

`Setup` 分组：

- `Waveform Count = [1] One`
- `Global Input Position = 0.0`
- `Global Phase = EMITTER Age`
- `Global Amplitude Scale = 2.0`
- `Global Clamp Min = 0.0`
- `Global Clamp Max = 1.0`

`Waveform [1]` 分组当前仍为：

- `Waveform [1] = Sine`
- `[1] Input Position = 0.0`
- `[1] Phase = EMITTER Age`
- `[1] Phase Scale = 1.0`
- `[1] Frequency = 1.0`
- `[1] Amplitude Min/Max = 0.0 / 1.0`
- `[1] Scale = 1.0`
- `[1] Bias = 0.0`
- `[1] Exponent = 1.0`

左下 `Active Overview` 中仍能看到 `PARTICLES.WAVEFORM Waveform` 输出项，说明当前调整的是波形模块本身的整体输出幅度，而不是后面单独在颜色、尺寸或位置上再做乘法。

这张图的核心含义是：

- `Global Amplitude Scale` 会整体放大所有波形输出的起伏量
- 当其他局部参数不变时，只提高这个值，就能让同一条 `Sine` 曲线产生更夸张的上下摆动
- 由于后续 `Initialize Particle` 会把这个波形值映射到位置、颜色和尺寸，因此这里的振幅放大会同步增强这些视觉变化
这张图展示教程对 `Phase` 参数的解释：波形之所以会持续向前推进，是因为它的相位输入直接绑定到了 `EMITTER Age`。也就是说，这里控制的不是波形高度，而是“波形在时间轴上以什么速度前进”，因此教程强调它会保持一个持续、均匀的推进速度。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`WaveForms`
- `Empty` 发射器保持禁用
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `150 Current, 152 Max (est.) - [WaveForms] [Active]`
- 左侧预览依然是放大后的紫色正弦波轨迹

当前 `WaveForms` 发射器结构仍为：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Rate`
  - `Waveform 001`
- `Particle Spawn`
  - `Waveform`
  - `Initialize Particle`
  - `Add Velocity = Linear`
- `Particle Update`
  - `Particle State`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Waveform` 模块当前仍在 `All` 页签，并且高亮选中了 `Phase` 相关设置。当前可直接确认的参数如下：

`Setup` 分组：

- `Waveform Count = [1] One`
- `Global Input Position = 0.0`
- `Global Phase = EMITTER Age`
- `Global Amplitude Scale = 2.0`
- `Global Clamp Min = 0.0`
- `Global Clamp Max = 1.0`

`Waveform [1]` 分组：

- `Waveform [1] = Sine`
- `[1] Input Position = 0.0`
- `[1] Phase = EMITTER Age`
- `[1] Phase Scale = 1.0`
- `[1] Frequency = 1.0`
- `[1] Amplitude Min/Max = 0.0 / 1.0`
- `[1] Scale = 1.0`
- `[1] Bias = 0.0`
- `[1] Exponent = 1.0`

当前鼠标提示还能直接读到 `Phase` 的含义：它是“用于随时间推进波形输入位置的数值”。结合当前绑定项 `EMITTER Age`，可以把这一步理解为：

- 发射器年龄每持续增长一帧，波形输入位置也同步前进
- 因为这里没有使用归一化年龄，而是直接使用 `Emitter Age`，所以推进速度会保持恒定
- 如果后续再用乘法或其他数值去放大这个相位输入，就能得到更快的波形滚动速度

因此，这张图的重点不是新增某个视觉模块，而是明确 `Phase` 决定的是波形随时间的推进速率，它是控制“动画节奏”的关键入口。
这张图展示教程已经从前面的 `WaveForms` 例子切换到一个新的网格旋转力示例发射器 `MeshRotationForce`。当前画面的目的不是继续讲波形，而是开始演示网格粒子如何设置初始朝向、旋转力、初始受力和旋转速度，因此左侧预览不再是波浪线，而只剩一个带坐标轴的单个网格实例。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- `WaveForms` 发射器已禁用
- 当前活跃发射器：`MeshRotationForce`
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `1 Current, 2 Max (est.) - [MeshRotationForce] [Active]`
- 左侧预览只显示一个单独的网格对象及其本地坐标轴：
  - 红轴向右
  - 蓝轴向上
  - 绿轴向下方延伸

当前 `MeshRotationForce` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation = Random`
  - `Mesh Rotation Force`
  - `Apply Initial Forces`
  - `Add Rotational Velocity`
- `Particle Update`
  - `Particle State`
  - `Drag`
  - `Scale Mesh Size`
  - `Solve Forces and Velocity`
- `Render`
  - `Mesh Renderer`

右侧当前打开的是 `Initial Mesh Orientation` 模块面板，界面停留在 `Orientation` 分组，可直接确认的设置如下：

- `Mesh Orientation Mode = Random`
- `Rotation = (0.0, 0.0, 0.0)`
- `Rotation Coordinate = Mesh`

左下 `Active Overview` 当前可见的基础属性包括：

- `SYSTEM LoopedAge`
- `SYSTEM NormalizedLoopAge`
- `PARTICLES Age`
- `PARTICLES Color`
- `PARTICLES DistanceTraveled`
- `PARTICLES INITIAL Scale`
- `PARTICLES Lifetime`
- `PARTICLES Mass`

按这张图复建时，可以把它理解为一个新的起点模板：

- 先用 `Spawn Burst Instantaneous` 只生成极少量网格粒子，便于观察旋转行为
- 用 `Initial Mesh Orientation` 给网格一个随机初始朝向
- 再通过后面的 `Mesh Rotation Force`、`Add Rotational Velocity` 和 `Drag` 逐步构建“被旋转驱动后再逐渐减速”的效果

因此，这张图的作用是建立后续“网格旋转力”章节的发射器骨架和初始朝向设置，而不是继续修改前一段的波形参数。

### 00:23:44-00:26:59 粒子、网格、速度

- 本段定位：粒子、网格、速度。
- 知识点：真的转得非常多 刚才如果输入15左右的值 转得就非常少 所以使用网格旋转力的话 即使有相同的旋转值 根据重量和质量 旋转的强度会变低 现实中重的石头。
- 知识点：旋转值会非常小 而轻的小石头 旋转值会很多 后来可以反映这种现实 所以为了这种反应 可以使用这种网格旋转力 适当看一下 总是要用apply。
- 知识点：initial force一起写 match rotation force是 这样慢慢转动速度。
- 知识点：在慢慢停下 因为这个rotational drag的力 所以最后有空气阻力的意思就是 就这样 所以我们一直指在粒子上。
- 知识点：使用拖拽 这种方式自然的旋转值 停止感觉的表达 也可以利用旋转拖拽 也可以利用旋转拖拽 这是一个方法 还有这里添加旋转速度的情况。
- 核对对象：`Drag`、`粒子`、`速度`。

**关键画面：**

这张图展示 `MeshRotationForce` 发射器里 `Initialize Particle` 的基础初始化设置。教程此处是在为后续“同样旋转力下，不同质量会表现出不同旋转强度”做准备，因此右侧面板重点放在粒子寿命、质量和网格缩放上，左侧预览仍只显示一个单独的网格轴向体，便于观察受力后的转动效果。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- `Empty` 发射器禁用
- `WaveForms` 发射器禁用
- 当前活跃发射器：`MeshRotationForce`
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `1 Current, 2 Max (est.) - [MeshRotationForce] [Active]`
- 左侧预览中是一个单独的三轴网格示意体：
  - 蓝轴朝上
  - 红轴朝左下方向延伸
  - 绿轴朝左上方向延伸

当前 `MeshRotationForce` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation = Random`
  - `Mesh Rotation Force`
  - `Apply Initial Forces`
  - `Add Rotational Velocity`
- `Particle Update`
  - `Particle State`
  - `Drag`
  - `Scale Mesh Size`
  - `Solve Forces and Velocity`
- `Render`
  - `Mesh Renderer`

右侧 `Initialize Particle` 当前在 `All` 页签，可直接确认的设置如下：

`Point Attributes`：

- `Lifetime Mode = Direct Set`
- `Lifetime = 3.0`
- `Color Mode = Direct Set`
- `Color` 为白色
- `Position Mode = Simulation Position`
- `Mass Mode = Random`
- `Mass Min = 0.1`
- `Mass Max = 0.1`

`Sprite Attributes`：

- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

`Mesh Attributes`：

- `Mesh Scale Mode = Random Uniform`
- `Mesh Uniform Scale Min = 4.0`
- `Mesh Uniform Scale Max = 5.0`
- `Mesh Render Array Visibility Mode = Unset`

`Ribbon Attributes`：

- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

左下 `Active Overview` 当前可见的关键粒子属性包括：

- `PARTICLES Age`
- `PARTICLES Color`
- `PARTICLES DistanceTraveled`
- `PARTICLES INITIAL Scale`
- `PARTICLES Lifetime`
- `PARTICLES Mass`

这张图的核心作用是先把“网格粒子本体”的基础物理属性定下来：

- 用固定寿命 `3.0` 控制观察窗口
- 用 `Mass = 0.1` 作为一个很轻的质量基准
- 用 `Mesh Uniform Scale 4.0~5.0` 保持网格尺寸稳定可见

这样后面再加入 `Mesh Rotation Force`、`Add Rotational Velocity` 和 `Drag` 时，就能更清楚地比较不同受力和阻尼对旋转表现的影响。
这张图展示 `MeshRotationForce` 发射器在 `Particle Update` 阶段对 `Drag` 模块的设置，教程此处强调的是不仅可以给平移速度加阻力，也可以给旋转速度加阻力，从而让物体像受空气阻尼一样逐渐减速停下。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- `Empty` 发射器禁用
- `WaveForms` 发射器禁用
- 当前活跃发射器：`MeshRotationForce`
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `1 Current, 2 Max (est.) - [MeshRotationForce] [Active]`

当前 `MeshRotationForce` 发射器结构与上一张一致：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation = Random`
  - `Mesh Rotation Force`
  - `Apply Initial Forces`
  - `Add Rotational Velocity`
- `Particle Update`
  - `Particle State`
  - `Drag`
  - `Scale Mesh Size`
  - `Solve Forces and Velocity`
- `Render`
  - `Mesh Renderer`

右侧当前打开的是 `Drag` 模块，标题说明为 `Rotational Drag`。面板中可直接确认的参数如下：

- `Drag = 1.0`
- `Rotational Drag = 4.5`

这两个参数分别对应两类阻尼：

- `Drag`：抑制粒子的线速度
- `Rotational Drag`：抑制粒子的角速度

教程此处的核心意思是：如果前面已经通过 `Mesh Rotation Force` 或 `Add Rotational Velocity` 让网格开始旋转，那么在 `Particle Update` 里加入 `Rotational Drag`，就能让旋转不是一直匀速持续，而是随着时间逐渐衰减，形成更自然的“越转越慢”的停转感。

按这张图复建时，可以把这一节理解为一个阻尼层：

- `Particle Spawn` 负责给初始旋转与受力
- `Particle Update` 里的 `Drag` 负责每帧持续削减这些速度
- `Rotational Drag = 4.5` 明显高于普通 `Drag = 1.0`，说明教程这里更强调旋转衰减，而不是线速度衰减
这张图展示教程在 `MeshRotationForce` 发射器里继续切回 `Particle Spawn` 区域，准备讲解 `Mesh Rotation Force` 模块本身的位置。画面中堆栈高亮已经落在 `Mesh Rotation Force` 这一行，但右侧当前可见的详情面板仍然是上一个 `Initial Mesh Orientation` 模块的参数，因此这张图主要用于定位发射器结构，而不是展示 `Mesh Rotation Force` 的具体数值。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- `WaveForms` 发射器禁用
- 当前活跃发射器：`MeshRotationForce`
- 左侧统计：
  - `0 Current, 2000 Max (est.) - [Empty] [Disabled]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `1 Current, 2 Max (est.) - [MeshRotationForce] [Active]`
- 左侧预览仍是单个三轴网格示意体：
  - 蓝轴朝上
  - 绿轴朝左
  - 红轴朝下

当前 `MeshRotationForce` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation = Random`
  - `Mesh Rotation Force`
  - `Apply Initial Forces`
  - `Add Rotational Velocity`
- `Particle Update`
  - `Particle State`
  - `Drag`
  - `Scale Mesh Size`
  - `Solve Forces and Velocity`
- `Render`
  - `Mesh Renderer`

当前高亮焦点与右侧面板可见信息：

- 中央堆栈中当前被选中的是 `Mesh Rotation Force`
- 右侧详情面板标题仍显示 `Initial Mesh Orientation`
- 右侧面板可见参数仍为：
  - `Mesh Orientation Mode = Random`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Rotation Coordinate = Mesh`

因此，这张图可以确认两点：

- `Mesh Rotation Force` 位于 `Particle Spawn` 阶段，并且排在 `Initial Mesh Orientation` 之后、`Apply Initial Forces` 之前
- 当前截图还没有给出 `Mesh Rotation Force` 的可读参数面板，所以不能从这张图直接推断其力值、方向或分布设置

复建时应先按这张图还原模块顺序；若需要具体受力数值，则必须依赖后续真正显示 `Mesh Rotation Force` 详情的截图，而不能根据本图猜测。

### 00:27:08-00:29:32 粒子、发射器、光束

- 本段定位：粒子、发射器、光束。
- 知识点：有限吸引力 这里需要制作Zero 因为这种情况 起点和终点可以设置 这个起点和终点是 我们的bin向下制作时 起始位置和结束位置 是一样的意思。
- 知识点：起始位置这个点值是 现在在100左右的位置 在X轴上 这里就是那个点 然后结束时 负100 这边是对面吧 所以这条线的起始和结束的 线生成的线的方向上。
- 知识点：粒子现在在聚集这样看吗 所以是某个特定点汇聚的 信誉之一 因为它是线形的 可以像用光束一样 使得光束的某个位置值相同 这样粒子们就会。
- 知识点：朝光束方向不断聚集 如果不是这样匹配某个汇聚点 可能用处会比较少 这就是 所以有这种粒 还有 类似的粒中还有一个 叫做点引力 现在这样看 引力强度是。
- 知识点：现在半径大约是100 在100左右的形状内的 对应的粒子们 现在这个吸引的位置 现在是在粒子位置上。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`发射器`、`光束`。

**关键画面：**

这张图展示教程切回 `Empty` 发射器，并在 `Particle Update` 阶段使用 `Line Attraction Force`。教程此处的目标是让粒子朝一条给定线段聚拢，因此右侧面板直接给出了吸引强度以及线段起点、终点坐标。

当前系统状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 左侧预览当前处于编译中，画面显示：
  - `Compiling Emitter - Empty`
  - `Compiling Emitter - WaveForms`
  - `Compiling Emitter - MeshRotationForce`
  - 中央提示 `Compiling...`
- 因为预览仍在编译，本图不能用于确认最终粒子形状或数量

中央可见的发射器状态如下：

- 当前聚焦发射器：`Empty`
- `WaveForms` 发射器处于禁用状态

`Empty` 发射器当前可直接确认的结构：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧当前打开的是 `Line Attraction Force` 模块，可直接确认的参数如下：

- `Attraction Strength = 20.0`
- `Line Start = (100.0, 0.0, 0.0)`
- `Line End = (-100.0, 0.0, 0.0)`

按这张图复建时，可以把这组空间设置理解为一个 `space_contract`：

- `subject`：`Empty` 发射器中的粒子
- `dimension`：三维
- `Fsemantic`：以 Niagara 预览场景中的线段方向理解“从正 X 到负 X 的一条水平吸引线”
- `Fwrite`：`Line Attraction Force` 模块参数空间
- `Fread`：当前右侧参数面板读到的模块数值
- `Fverify`：编译完成后的 Niagara 预览结果
- `conversion_chain`：当前图中未见额外坐标转换，直接以模块面板数值作为验证输入

因此，这一步的核心不是生成一条可见光束，而是先定义一条位于 `X=100` 到 `X=-100` 之间的吸引线，再以 `Attraction Strength = 20.0` 让粒子朝这条线持续聚拢。由于画面仍在编译中，本图只可靠地确认参数本身，不能提前断言最终聚拢形态。
这张图展示 `Line Attraction Force` 编译完成后的实际效果。教程此处是在说明：当粒子受到线吸引力时，它们不会只朝某一个点收缩，而是朝一整条线段的最近位置持续靠拢，因此预览里会形成一条带状、沿线分布的聚集结果。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`Empty`
- `WaveForms` 发射器禁用
- `MeshRotationForce` 发射器禁用
- 左侧统计：
  - `1000 Current, 2000 Max (est.) - [Empty] [Active]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `0 Current, 2 Max (est.) - [MeshRotationForce] [Disabled]`

左侧预览结果可直接观察到：

- 粒子总体仍保留球形分布外轮廓
- 但中部已经出现明显的线状聚拢趋势
- 红色粒子更多集中在中线附近
- 绿色与黄色粒子分布在外围，向中线逐步过渡

当前 `Empty` 发射器结构与上一张一致：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Line Attraction Force` 当前参数仍可直接确认如下：

- `Attraction Strength = 20.0`
- `Line Start = (100.0, 0.0, 0.0)`
- `Line End = (-100.0, 0.0, 0.0)`

按这张图的 `space_contract` 来理解：

- `subject`：球形发射出来的 1000 个粒子
- `dimension`：三维
- `Fsemantic`：一条沿 X 轴从 `+100` 到 `-100` 的水平吸引线
- `Fread`：Niagara 预览窗口中的最终粒子分布
- `Fverify`：通过观察粒子是否沿该线形成带状聚集来验收

从这张图可验证的结果是：

- 线吸引力没有把所有粒子压成单点
- 它让粒子朝线段方向收束，因而形成“线形聚集”
- 这与后续的点吸引力效果不同，后者会更偏向朝单个中心点收缩
这张图展示教程把 `Empty` 发射器中的吸引模块从 `Line Attraction Force` 进一步切换到了 `Point Attraction Force`。与前一张“朝整条线聚拢”不同，这一步开始改成“朝某一个位置点吸引”，所以右侧参数面板的重点变成吸引半径、衰减指数和目标位置来源。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`Empty`
- `WaveForms` 发射器禁用
- `MeshRotationForce` 发射器禁用
- 左侧统计：
  - `1000 Current, 2000 Max (est.) - [Empty] [Active]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `0 Current, 2 Max (est.) - [MeshRotationForce] [Disabled]`

左侧预览当前可见的结果：

- 粒子整体仍保持球状体积
- 中心区域红色粒子更密集，说明吸引中心已开始形成
- 外围绿色大粒子和黄色小粒子仍分布在壳层附近，表现为从外向内的收束趋势

当前 `Empty` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Point Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧当前打开的是 `Point Attraction Force` 模块，可直接确认的参数如下：

- `Attraction Strength = 10.0`
- `Attraction Radius = 100.0`
- `Falloff Exponent = 0.5`
- `Attractor Position Offset = (0.0, 0.0, 0.0)`
- `Kill Radius = 4.0`
- `Position To Attract = PARTICLES Position`
- `Attractor Position = SimulationPosition`

当前鼠标提示还能确认：

- `Position To Attract` 的名称就是 `Position To Attract`
- 类型为 `Position`

按这张图的 `space_contract` 来理解：

- `subject`：`Empty` 发射器中的球形粒子群
- `dimension`：三维
- `Fsemantic`：以某一个目标位置为中心的点吸引，而不是一条线吸引
- `Fwrite`：`Point Attraction Force` 模块参数
- `Fread`：当前右侧面板参数与左侧预览分布
- `Fverify`：观察粒子是否朝单个中心区聚拢
- `conversion_chain`：当前图中未见额外坐标转换，直接按模块参数解释

从这张图可直接得出的结论是：教程已经把吸引目标从“线段上的最近点”切换为“单个吸引位置”，并且只在 `Radius = 100.0` 的范围内对粒子产生更明显的汇聚影响，因此画面开始呈现出比线吸引更中心化的聚拢趋势。

### 00:29:42-00:30:29 关键流程 08

- 本段定位：关键流程 08。
- 知识点：拿出来看看吧 所以看到这个眼缘的点 可观察到现在汇聚到中心点 所以刚才这个线吸引力 非常相似的部分 这个是线的形态聚集的 这个是定点聚集的。
- 知识点：可以给这里的偏移值 现在是500 太强了 因为是500 因为是500 因为是500 字幕提供机 字幕提供机广告包含。

**关键画面：**

这张图展示 `Point Attraction Force` 在实际关卡视口中的验证方式。教程此处把 Niagara 系统放回主编辑器世界中观察，并结合 Outliner 里选中的 `NewNiagaraSystem13`，说明点吸引目标可以直接理解为某个场景对象所在的位置，因此粒子会朝该 Actor 的位置聚拢。

当前画面分成上下两部分：

- 上半部分是 Unreal 关卡主视口
- 下半部分是 `NewNiagaraSystem13` 的 Niagara 编辑器与预览窗口

上半部分主视口可直接确认的信息：

- 当前处于 `Selection Mode`
- 视口为 `Perspective`
- Outliner 中当前选中对象为 `NewNiagaraSystem13`
- 场景中可见：
  - `DirectionalLight`
  - `SkyLight`
  - `SM_SkySphere`
  - `Ex_01_SpriteExp`
  - `Floor`
  - `PlayerStart`
  - `PostProcessVolume`
- `NewNiagaraSystem13` 在场景中显示为一团粒子，围绕选中 gizmo 分布

下半部分 Niagara 预览与发射器状态可直接确认如下：

- 当前活跃发射器：`Empty`
- 左侧统计：
  - `1000 Current, 2000 Max (est.) - [Empty] [Active]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `0 Current, 2 Max (est.) - [MeshRotationForce] [Disabled]`
- 左下预览中粒子呈现“外围绿黄、中心偏红”的中心收束效果

当前 `Empty` 发射器结构仍为：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Point Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Point Attraction Force` 当前可直接确认的参数如下：

- `Attraction Strength = 10.0`
- `Attraction Radius = 100.0`
- `Falloff Exponent = 0.5`
- `Attraction Position Offset = (0.0, 0.0, 0.0)`
- `Kill Radius = 4.0`
- `Position To Attract = PARTICLES Position`
- `Attractor Position = ENGINE.EMITTER SimulationPosition`

按这张图的 `space_contract` 来理解：

- `subject`：`Empty` 发射器生成的粒子群
- `dimension`：三维
- `Fsemantic`：粒子朝场景中 `NewNiagaraSystem13` 当前所在位置聚拢
- `Fwrite`：`Point Attraction Force` 模块参数，其中吸引目标取自 `ENGINE.EMITTER SimulationPosition`
- `Fread`：主视口中 Actor 位置与 Niagara 预览中的粒子分布
- `Fverify`：粒子中心是否与场景中选中系统的位置对齐
- `conversion_chain`：Actor 位置语义 -> 发射器 `SimulationPosition` -> `Point Attraction Force` 吸引目标

因此，这张图的关键结论是：教程把点吸引目标明确绑定到了发射器/系统的仿真位置上，而不是一个手工输入的固定世界点，读者可以直接通过场景里选中的 Niagara Actor 来理解粒子最终聚拢的中心位置。
这张图展示教程在 `Empty` 发射器的 `Particle Update` 区域里，把 `Line Attraction Force` 和 `Point Attraction Force` 放在一起对照说明。画面的重点不在新增参数，而在于明确语义差异：上一个模块让粒子向一条线聚集，这一个模块让粒子向某一个固定位置点聚集。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`Empty`
- `WaveForms` 发射器禁用
- `MeshRotationForce` 发射器禁用
- 左侧统计：
  - `1000 Current, 2000 Max (est.) - [Empty] [Active]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `0 Current, 2 Max (est.) - [MeshRotationForce] [Disabled]`

左侧预览结果可直接观察到：

- 粒子中心区域形成明显的高密度红色聚集核
- 外围仍有绿色和黄色粒子沿球壳散布
- 整体视觉比线吸引时更偏向“向中心一点汇聚”，而不是沿线拉成长带

当前 `Empty` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Point Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

当前堆栈与右侧面板可直接确认：

- 中央高亮选中的是 `Line Attraction Force`
- 其右侧面板参数仍为：
  - `Attraction Strength = 20.0`
  - `Line Start = (100.0, 0.0, 0.0)`
  - `Line End = (-100.0, 0.0, 0.0)`
- 同时在同一堆栈下方还能看到 `Point Attraction Force` 模块已存在并启用

因此，这张图的主要作用是建立一个并列对照关系：

- `Line Attraction Force`：目标是线段上的最近位置，结果更接近沿线带状聚集
- `Point Attraction Force`：目标是单个位置点，结果更接近中心收束

从当前预览来看，教程此处已经把视觉重点转向“定点聚集”的观察方式，帮助读者区分两种吸引模块在空间目标定义上的本质差别。
这张图展示教程继续使用 `Point Attraction Force`，并把吸引目标位置的偏移量直接抬高到了 `Z = 500.0`。教程此处是在说明：点吸引的目标点并不一定非要停留在发射器原点，也可以在此基础上再叠加一个较大的位置偏移，从而把粒子牵引到更高的空间位置。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem13`
- 当前活跃发射器：`Empty`
- `WaveForms` 发射器禁用
- `MeshRotationForce` 发射器禁用
- 左侧统计：
  - `1000 Current, 1000 Max (est.) - [Empty] [Active]`
  - `0 Current, 0 Max (est.) - [WaveForms] [Disabled]`
  - `0 Current, 2 Max (est.) - [MeshRotationForce] [Disabled]`

左侧预览当前可见结果：

- 粒子总体仍是一团球形分布
- 中心区域依旧有红色高密度聚集
- 外围绿色粒子分布较散
- 由于这是单帧截图，当前只能确认吸引目标参数已被大幅抬高，不能仅凭这张图精确判断粒子整体已经上移了多少距离

当前 `Empty` 发射器结构可直接确认如下：

- `Properties = CPU`
- `Emitter Update`
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location = Sphere`
  - `Kill Particles in Volume = Sphere`
  - `Region Mask`
  - `Kill Particles`
  - `Color`
- `Particle Update`
  - `Particle State`
  - `Line Attraction Force`
  - `Point Attraction Force`
  - `Solve Forces and Velocity`
- `Render`
  - `Sprite Renderer`

右侧 `Point Attraction Force` 当前可直接确认的参数如下：

- `Attraction Strength = 10.0`
- `Attraction Radius = 100.0`
- `Falloff Exponent = 0.5`
- `Attractor Position Offset = (0.0, 0.0, 500.0)`
- `Kill Radius = 4.0`
- `Position To Attract = PARTICLES Position`
- `Attractor Position = ENGINE.EMITTER SimulationPosition`

按这张图的 `space_contract` 来理解：

- `subject`：`Empty` 发射器中的粒子群
- `dimension`：三维
- `Fsemantic`：粒子朝“发射器位置上方 500 单位”的目标点聚拢
- `Fwrite`：`Point Attraction Force` 参数空间
- `Fread`：右侧参数面板中的 `Attractor Position Offset`
- `Fverify`：预览里粒子应相对于原中心向更高位置的目标点收束
- `conversion_chain`：`ENGINE.EMITTER SimulationPosition` -> 叠加 `(0,0,500)` 偏移 -> 成为最终吸引目标点

因此，这一步的核心是把点吸引目标从“发射器当前位置”改成“发射器当前位置上方 500 单位”的空间点。教程也明确提示 `500` 这个偏移量已经比较强，意味着它会显著改变粒子的汇聚位置。

## 补充视觉证据

### S01 00:01:44

这张图是对 `S01 00:01:44` 的补充参数截图，用来补证教程开场阶段 `Kill Particles in Volume` 的具体设置。它对应正文最前面“在约 `200` 的球体里生成粒子，再用约 `100` 的球形体积杀掉一部分粒子”的讲解，因此重点是把 `Kill Particles in Volume` 的参数直接读清。

当前系统与发射器状态可直接确认如下：

- 系统：`NewNiagaraSystem1`
- 当前活跃发射器：`Empty`
- 左侧统计：
  - `179 Current, 193 Max (est.) - [Empty] [Active]`
- 左侧预览可见一团稀疏的白色粒子分布，中心有明显空洞感

当前系统与发射器结构可直接确认如下：

- `NewNiagaraSystem1`
  - `Properties`
  - `User Parameters`
  - `System Spawn`
  - `System Update`
    - `System State`
- `Empty`
  - `Properties = CPU`
  - `Emitter Update`
    - `Emitter State = Self / Infinite`
    - `Spawn Burst Instantaneous`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Shape Location = Sphere`
    - `Kill Particles in Volume = Sphere`
  - `Particle Update`
    - `Particle State`
  - `Render`
    - `Sprite Renderer`

右侧当前打开的是 `Kill Particles in Volume` 模块，可直接确认的参数如下：

- `Kill Shape = Sphere`
- `Sphere Radius = 100.0`
- `Kill Volume Enabled` 已开启
- `Invert Volume` 未开启
- `Volume Origin = Simulation Position`
- `Origin Offset = (0.0, 0.0, 0.0)`

左下 `Active Overview` 当前还能直接看到若干系统属性，包括：

- `SYSTEM Age`
- `SYSTEM bCompleteOnInactive`
- `SYSTEM CurrentLoopDuration`
- `SYSTEM ExecutionState`
- `SYSTEM ExecutionStateSource`
- `SYSTEM LoopCount`
- `SYSTEM LoopedAge`
- `SYSTEM NormalizedLoopAge`

结合本页开头 `00:00:05-00:04:48` 的正文上下文，这张补图能补强的关键结论是：

- 粒子先通过 `Shape Location = Sphere` 在更大的球形范围里生成
- 再通过 `Kill Particles in Volume` 定义一个半径 `100.0` 的球形杀伤体积
- 该体积以 `Simulation Position` 为原点，且未做偏移
- 因为 `Kill Volume Enabled` 开启且 `Invert Volume` 关闭，所以命中这个球形体积条件的粒子会被直接剔除

因此，这张补充图的价值在于把最早一段口述中的关键数值正式落地：教程不是泛泛地说“用一个球体删粒子”，而是明确使用了以仿真原点为中心、半径 `100` 的球形 `Kill Particles in Volume` 设置。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


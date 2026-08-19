# 10-2-创建虚幻Niagara精灵技能效果

# 10-2-创建虚幻Niagara精灵技能效果

## 关键术语

- `Alpha`、`UV`、`Opacity`、`Substance`、`材质`、`粒子`、`精灵`、`生命周期`、`透明度`、`纹理`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Particle`

## 分段知识

### 00:00:07-00:03:05 UV、粒子、精灵

- 本段定位：UV、粒子、精灵。
- 知识点：首先这个元素需要用一个相同的粒子,一个固定在地面上,然后呢, 往这些轴上固定,然后给人一种扑开的感觉,就是那种, 另一个就是用精灵模式,然后放在那个角色前面。
- 知识点：这样总共会用两个,然后, 然后这个核心元素就会给人快速扩散的那种感觉。
- 知识点：首先我们来做一下要放在地面的部分。
- 知识点：关掉偏移,用朝向来制造地面的感觉。
- 知识点：呢,为了不转动打开对齐,当有自定义向量或对齐向量时, 不确定你的自定义是否正常工作。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`颜色`。

**关键画面：**

这张图展示 Niagara System `Ex_01_SpriteExp` 的起始搭建状态，重点是在 `Empty001` 发射器里为“贴地扩散”的精灵效果配置动态材质参数曲线。

- 系统概览中当前可见 3 个发射器：
  - `Empty`
  - `Empty001`，当前激活并被选中
  - `Empty002`
  结合正文“总共会用两个”，可以判断作者正在先处理其中一个贴地用的核心发射器。
- `Empty001` 的模块栈可见顺序包括：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
  - `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Dynamic Material Parameters`
  - `Scale Color`
  - `Render`
  这说明当前效果还是以标准 Sprite 发射器为基础，再叠加材质参数与颜色变化。
- 右侧详情面板正在编辑 `Dynamic Material Parameters`，并且切到了 `All` 视图。当前至少能确认两条动态参数曲线：
  - `Opacity_VPan`：类型为 `Float from Curve`，曲线几乎保持高位平直，说明生命周期内用于控制材质里垂直平移或透明相关参数的值比较稳定。
  - `Distortion`：同样是 `Float from Curve`，曲线从较低值逐渐上升，说明随粒子年龄增长，扭曲量会持续增强。
- 这两条曲线都以 `PARTICLES.NormalizedAge` 为横轴驱动，因此它们会在粒子生命周期 0 到 1 的范围内自动变化。
- 预览窗口左侧能隐约看到一组紫色小片状效果，说明当前系统已经绑定了材质实例 `M_RadialUV_01_Ins_02`，并能实时反馈动态材质参数的结果。

结合本段语义“先做放在地面的部分”“关掉偏移，用朝向来制造地面的感觉”，这张图的核心不是空间朝向参数本身，而是先把贴地精灵所依赖的材质驱动准备好：通过 `Dynamic Material Parameters` 让 UV 平移和扭曲在生命周期内自动变化，为后面的地面扩散感打基础。
这张图切到 `Empty001` 的 `Sprite Renderer` 详情，重点是检查当前精灵渲染器的材质和朝向相关默认状态，为后面做“贴地但不乱转”的效果做准备。

- 右侧详情面板当前选中的是 `Sprite Renderer`，主要可读参数为：
  - `Material = M_RadialUV_01_Ins_02`
  - `Source Mode = Particles`
  - `Alignment = Automatic`
  - `Facing Mode = Automatic`
  - `Macro UVRadius = 0.0`
  - `Default Pivot in UV = 0.5 , 0.5`
  - `Pixel Coverage Blend = 1.0`
  - `Sort Mode = None`
- 这说明此时精灵仍处于 Unreal 的自动对齐/自动朝向状态，还没有切成明确的自定义对齐向量或特定平面朝向。
- 正文里说“关掉偏移，用朝向来制造地面的感觉”“为了不转动打开对齐”，与当前 `Automatic` 状态形成对照，可判断这张图记录的是修改前或过渡中的基础状态，作者接下来会围绕 `Alignment` / `Facing Mode` 做进一步调整。
- 中间模块栈中还能清楚看到：
  - `Sprite Facing and Alignment`
  - `Sprite Renderer`
  说明朝向控制并不只依赖渲染器本身，还会配合上面的粒子更新模块一起工作。
- 左侧预览里已经能看到几片紫色精灵分布在场景中，说明哪怕 هنوز是自动朝向，效果已经在运行，只是当前还没有形成明确的“压在地面上扩散”的视觉。

按这张图可复建的当前状态，是先用 `M_RadialUV_01_Ins_02` 作为 Sprite 材质跑通效果，再检查 `Sprite Renderer` 的 `Alignment`、`Facing Mode` 和 `Pivot` 是否处于适合后续贴地控制的基础配置。下一步的关键会是从自动状态改成更稳定的朝向/对齐方式，避免精灵自由旋转破坏地面扩散感。
这张图继续编辑 `Empty001` 的 `Dynamic Material Parameters`，重点是在 `Opacity_VPan` 曲线上追加关键点，让材质中的平移参数在生命周期后段逐渐收束。

- 当前仍位于 `Dynamic Material Parameters` 模块，右侧显示两条主要曲线：
  - `Opacity_VPan`
  - `Distortion`
- `Opacity_VPan` 的曲线上当前悬停提示可见：
  - `Time = 1.3`
  - `Value = 0.5`
  同时字幕提到“再加一个点，1 的值设为 0，让平移能进行”，说明作者正在围绕末端关键点调整曲线尾部趋势。
- 从曲线形态看，`Opacity_VPan` 并不是简单一条完全静止的水平线，而是在末端增加了控制点，目的是让垂直平移参数在后半段不要一直保持同一速度，而是能够停下或回落。
- 下方 `Distortion` 曲线仍保持从低到高的上升趋势，说明扭曲量会随生命周期增强，而 `Opacity_VPan` 更像是控制纹理平移/滚动节奏。
- 由于这两条参数都绑定在 `PARTICLES.NormalizedAge` 上，所以这种“多加一个点”的做法本质上是在粒子生命周期曲线上定义材质运动节奏：
  - 前段可能保持或推进；
  - 后段逐渐收敛到更小的平移值；
  - 从而避免贴地图案一直匀速滚动。
- 左侧预览里能看到几片紫色精灵围绕中心分布，说明这类曲线调整会立刻影响实际扩散观感，而不是停留在参数层。

按这张图可复建的关键做法，是在 `Dynamic Material Parameters > Opacity_VPan > Float from Curve` 中新增末端关键点，用 `NormalizedAge` 驱动它随时间变化。这样材质里的平移参数就能在粒子后段减弱或归零，更适合做先扩散、后停住或后消散的地面技能效果。

### 00:03:08-00:05:52 颜色、透明度、纹理

- 本段定位：颜色、透明度、纹理。
- 知识点：让张力完全扩散,就是前期快速扩散一下张力。
- 知识点：这种爆炸般的张力是绝对不要用线性,线性表达得太无聊了。
- 知识点：想要强烈的冲击就得这样。
- 知识点：一种动作比如,颜色变化或透明度消失,线性不明显。
- 知识点：这种纹理的平移或聚集,一定不要用线性,就是直线图。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`、`透明度`。

**关键画面：**

这张图展示 `Empty001` 发射器在“颜色、透明度、纹理”阶段的核心调法：通过非线性曲线驱动材质平移与扭曲，让地面环形特效在前期快速扩散，而不是匀速线性变化。

- 左侧预览窗口中，当前效果已经形成一个紫白色的环形爆发图样：
  - 中心空出一个明显孔洞；
  - 外圈边缘不规则起伏；
  - 整体像先快速外扩、再逐渐稳定的能量环。
  这和正文“前期快速扩散一下张力”“爆炸般的张力不要用线性”完全对应。
- 右侧 `Dynamic Material Parameters` 中，`Opacity_VPan` 曲线现在已经不是水平线，而是：
  - 起点较高，约在 `0.5` 附近；
  - 中段快速下降到较低值；
  - 后段趋于平缓
  这表示纹理垂直平移或同类材质参数在粒子初期变化更激烈，后期逐渐减弱。
- 这条曲线仍由 `PARTICLES.NormalizedAge` 驱动，因此 0 到 1 的生命周期内会经历“快变化 -> 慢变化”的节奏，而不是恒定速度。
- 下方 `Distortion` 曲线依旧保持上升趋势，说明与此同时扭曲量还会继续累积或增强，进一步放大前期冲击感。
- 中央 `Empty001` 的模块栈未改，说明这一段主要依赖动态材质曲线塑造观感，而不是新增复杂 Niagara 模块。

按这张图可复建的关键原则，是避免用线性曲线驱动扩散、透明或纹理聚集。更有效的做法是让材质参数在前段快速变化、后段放缓，这样环形冲击会更有爆发感，也更符合教程强调的“张力先猛地释放”的视觉节奏。
这张图把 `Opacity_VPan` 的曲线编辑器单独展开出来，明确说明作者想要的是“初期迅速变化，后期几乎归零”的冲击型节奏，而不是线性匀速。

- 左下曲线编辑区当前选中的是：
  - `Empty001 Emitter`
  - `Dynamic Material Parameters`
  - `Index 0 Param 1`
  从右侧详情可对应到 `Opacity_VPan`。
- 曲线形状可以直接读出几个特征：
  - 起点在较高值，约 `0.5`
  - 很快快速下滑
  - 中后段贴近 `0`
  - 尾端还有极轻微回弹后归零
  这是一条明显的缓出/快速衰减曲线，而不是直线插值。
- 左侧预览里的紫色环形效果也更能说明这种曲线的视觉用途：形状先被迅速推开，随后扩散速度很快降低，让冲击感集中在前几帧。
- 右侧详情区仍同时显示：
  - `Opacity_VPan` 当前曲线
  - `Distortion` 仍在向上抬升
  因此这个阶段的效果节奏是“平移快速衰减 + 扭曲持续增强”共同叠加出来的。
- 正文里反复强调“不要用线性”，这张图就是最直接的执行证据：曲线不是均匀下降，而是前陡后缓，符合爆炸类技能在早期释放最大张力、后期快速收住的表达方式。

按这张图可复建的重点，不只是把值从 `0.5` 拉到 `0`，而是把下降过程做成非线性的强烈衰减曲线。这样材质中的平移或聚集不会显得机械，而会更像一次有冲击力的瞬时爆发。
这张图回到关卡视图，从更远的镜头检查角色与技能特效的落点关系，目的是确认前面做的贴地精灵在真实场景中是否有合适的覆盖范围和冲击尺度。

- 画面中央是一个角色站在棋盘格地面上，右侧 Outliner 中能看到与当前场景相关的对象：
  - `Cine Camera Actor`
  - 两个 `Ex 01 Sprite Exp` Niagara Actor
  - `Floor`
  - `Phase GDC`
  等。
  这说明当前已经不只是单独在 Niagara 编辑器里看预览，而是把效果放回实际关卡环境里观察。
- 镜头处于较高俯视角，能清楚看出角色与地面方格比例。结合字幕“大概 800 左右再宽一点”，可判断作者正在根据场景尺度评估地面精灵的视觉半径或扩散宽度。
- 这张图本身没有展示具体粒子模块参数，但它承担了一个重要验收作用：
  - 检查贴地效果是否真的贴着角色脚下展开；
  - 检查范围是否足够“大”，能形成技能冲击而不是局促的小亮点；
  - 检查从摄像机视角看，地面扩散是否容易读出来。
- 结合前两张图里对非线性曲线的强调，这里可以推断作者已经开始把“参数节奏”与“场景实际观感”对照起来看，而不是只在编辑器里调数值。

按这张图可复建的验证步骤，是在 Niagara 或材质调完后，回到关卡里用角色和地面网格作为尺度参照，确认扩散精灵的尺寸、落点和镜头可读性。对于这种技能效果，单看曲线和预览不够，必须在真实场景中检查冲击范围是否合理。

### 00:06:15-00:09:13 关键流程 03

- 本段定位：关键流程 03。
- 知识点：相机随时可以更换。
- 知识点：那这部分我也会改成夹具。
- 知识点：的Block也做了很多,然后特别标题掩盖。
- 知识点：为了让这种形式适当变大就像是错觉一样。
- 知识点：适当缩小了尺寸,总是从中间爆炸。

**关键画面：**

这张图进入“关键流程 03”的整理阶段，重点不再是新增材质逻辑，而是把 `Empty001` 的渲染器、尺寸节奏和视图组织成更可复用的工作流。

- 中央仍是 `Ex_01_SpriteExp` 的 `System Overview`，可见：
  - `Empty001` 作为当前主要发射器
  - `Empty` 与 `Empty002` 作为旁路或后续补充
- 右侧详情面板再次停在 `Sprite Renderer`，当前关键可见项与前面一致：
  - `Material = M_RadialUV_01_Ins_02`
  - `Alignment = Automatic`
  - `Facing Mode = Automatic`
  - `Default Pivot in UV = 0.5 , 0.5`
  说明这一步不是换材质，而是在已选好的渲染基础上继续整理流程。
- 左下曲线编辑区仍打开 `Dynamic Material Parameters > Index 0 Param 1` 的曲线，且形状保持前高后低的快速衰减趋势。由此可见，这条非线性节奏已经被视为当前关键流程的一部分，而不是临时试验值。
- 预览窗口当前基本为空，说明作者此刻更关注参数和流程排布，而不是实时看最终画面。
- 结合正文“相机随时可以更换”“这部分我也会改成夹具”“适当缩小了尺寸，总是从中间爆炸”，可以判断这一步的意图是：
  - 让当前 Sprite 爆发元素能更容易适配不同镜头；
  - 把当前做法整理成一套可搬到其他技能里的标准模板；
  - 同时通过尺寸控制保持“从中心爆开”的核心视觉。

按这张图可复建的工作重点，是在 Niagara 中固定一套基础流程：保留合适的 Sprite 渲染器设置、保留非线性材质驱动曲线，并把模块栈组织成后续可复制的模板。这样后面换镜头、换角色或叠加第二个子元素时，不需要重做整套节奏逻辑。
这张图回到关卡实景中检查“贴地爆发”在角色脚下的最终观感，重点是验证尺寸缩放后是否仍然保持从中心爆开的视觉焦点。

- 画面中央角色脚下已经出现一圈明显的紫白色能量环：
  - 外圈较亮、较厚；
  - 内圈保持空洞；
  - 整体围绕角色足下展开。
  这正符合前文“固定在地面上”“给人快速扩散的感觉”的目标。
- 环形效果覆盖范围相对于角色身体明显扩大，但又没有铺满整个屏幕，说明作者此时正在调一个“看起来更自然、更有冲击，但不过分夸张”的地面半径。
- 结合正文“适当变大就像是错觉一样”“适当缩小了尺寸，总是从中间爆炸”，可判断这张图记录的是一种折中状态：
  - 够大，能形成技能释放感；
  - 但仍保留中心向外炸开的聚焦感，不会因为太大而稀释能量中心。
- 右下角还能看到当前选中的是 `Empty003`，这说明作者此时可能已经开始叠加或切换另一个辅助发射器来比较组合效果，而不只是看 `Empty001` 单独结果。
- 右侧 Outliner 里有多个 `Ex 01 Sprite Exp` 相关 Niagara Actor，进一步说明这是在实际关卡里对最终组合效果做检查，不是单个模块的孤立预览。

按这张图可复建的验收重点，是必须把 Niagara 效果放回角色和地面网格环境里确认：既要保证外圈扩散足够大、足够显眼，又要让爆发中心保持清晰。对于这种技能效果，单看模块参数还不够，最终还得以角色脚下的整体读感作为主要判断标准。
这张图展示第二个激活的发射器 `Empty003` 已经加入系统，并且当前正在通过 `Initialize Particle` 直接控制它的尺寸、位置偏移和旋转，让中心爆发元素更自然地叠在主环形效果里。

- 左侧预览统计现在变为：
  - `Empty001 [Active]`
  - `Empty003 [Active]`
  - 其余发射器禁用
  说明此时系统已经从“单一贴地环”推进到“主环 + 辅助中心元素”的组合阶段。
- 右侧详情面板当前选中 `Empty003 > Initialize Particle`，关键参数可明确读取为：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 0.8`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 5.0)`
  - `Sprite Size Mode = Uniform`
  - `Uniform Sprite Size = 750.0`
  - `Sprite Rotation Mode = Direct Normalized Angle (0-1)`
  - `Sprite Rotation Angle = -0.25`
- 这些参数的组合含义比较明确：
  - `Lifetime = 0.8`：中心爆发持续时间较短，更像瞬时释放；
  - `Z` 方向偏移 `5.0`：让它略微离开地面，避免完全嵌进地板；
  - `Uniform Sprite Size = 750.0`：保证中心元素尺寸足够形成视觉主体；
  - `Rotation Angle = -0.25`：给贴图一个固定角度，避免所有中心纹理都正着出现而显得死板。
- 左侧预览里已经能看到中心更浓、更亮的形态叠在大环内部，说明 `Empty003` 的职责不是再做一圈外围扩散，而是补中心爆发和层次。
- 结合正文“适当缩小了尺寸，总是从中间爆炸”，可以推断作者正是在用这个第二发射器控制中心冲击核，而把更大的外扩部分留给 `Empty001`。

按这张图可复建的关键流程，是给第二个 Sprite 发射器单独设置一套更短寿命、更小范围、更靠中心的初始化参数，并略微抬高 `Z` 偏移与旋转角。这样最终组合出来的效果会同时拥有“中心爆发”和“外圈扩散”两层，不会只剩一张空心地面环。

### 00:09:24-00:12:20 Alpha、Opacity、材质

- 本段定位：Alpha、Opacity、材质。
- 知识点：把这两个导入使用。
- 知识点：那一份是没有运动模糊的。
- 知识点：这个是简单的水材质。
- 知识点：我就这样给你看一下。
- 知识点：这样构成一下就行了。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`材质`。

**关键画面：**

这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前用于对比多个发射器版本。左侧预览里显示一个紫白色环状水流精灵效果；左上角计数表明 `Empty001` 与 `Empty003` 处于 `Active`，`Empty` 与 `Empty002` 处于 `Disabled`。

当前选中的是 `Empty003` 发射器，右侧 `Initialize Particle` 面板里能确认的参数如下：

- `Point Attributes`
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.8`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 5.0)`
- `Position Offset Coordinate Space = Simulation`
- `Sprite Attributes`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 750.0`
- `Sprite Rotation Mode = Direct Normalized Angle (0-1)`
- `Sprite Rotation Angle = -0.25`
- `Sprite UV Mode = Unset`

系统总览中央可见 4 个发射器卡片，`Empty001` 与 `Empty003` 卡片高亮，说明当前主要在比较不同版本的 Sprite 发射器初始化参数。下方曲线编辑器显示一条名为 `FloatCurve` 的红色曲线：起点约为 `0.5`，随后快速衰减到接近 `0`，末端略有回升。这张图传达的重点是：在 Alpha/Opacity 调整阶段，先通过发射器开关和 `Initialize Particle` 的寿命、尺寸、旋转、偏移等基础参数，把水环精灵的整体形态稳定下来，再配合曲线做非线性衰减。
这是材质 `M_Additive_01` 的 Material Graph，左侧预览显示中心高亮、四向拉开的十字星芒效果。该图的重点是把纹理亮度整理后分别送到 `Emissive Color` 和 `Opacity`，并预留 Fade 开关。

节点定义集：

- `Texture Sample`：取一张光斑/星芒纹理，使用其 `RGB` 输出作为主亮度输入。
- `Desaturation`：接收纹理 `RGB`；`Fraction` 由左下方一个参数节点驱动，用来控制去色程度。
- `Pow`（参数，默认值可见为 `1.0`）：连接到 `Power.Exp`，用于控制亮度曲线的指数。
- `Power`：`Base` 接 `Desaturation` 输出，按 `Pow` 参数重映射亮度。
- `Str`（参数，默认值可见为 `1.0`）：作为整体强度系数。
- `Multiply`（中部）：把 `Power` 结果与 `Str` 参数相乘，形成主强度。
- `Particle Color`：使用粒子颜色的 `RGB` 和 `A` 两路输出参与最终结果。
- `Multiply`（上方右侧）：把主强度与 `Particle Color.RGB` 相乘。
- `Multiply`（下方右侧）：把透明度相关输入再做一次乘法后送出。
- `Use_Fa`（Switch Param / False，图中默认值未勾选）：用于控制 Fade 相关分支是否启用。
- `Material Output`：可见连接口为 `Emissive Color` 和 `Opacity`。

连线集：

- `Texture Sample.RGB -> Desaturation`
- `Desaturation -> Power.Base`
- `Pow -> Power.Exp`
- `Power -> 中部 Multiply.A`
- `Str -> 中部 Multiply.B`
- `中部 Multiply -> 上方右侧 Multiply.A`
- `Particle Color.RGB -> 上方右侧 Multiply.B`
- `上方右侧 Multiply -> Material Output.Emissive Color`
- `Particle Color.A` 参与下方右侧 `Multiply`
- 下方右侧 `Multiply -> Material Output.Opacity`
- `Use_Fa` 位于透明度乘法附近，用于切换是否附加 Fade；但图中分支细节未完整展开，能确认的是它参与透明度链路，而不是发光链路。

设置/参数：

- `Pow = 1.0`
- `Str = 1.0`
- `Use_Fa` 默认未勾选
- 当前图开启了 `Stats` 面板，说明作者在同时关注材质效果和指令开销。

输出/预览：

- `Emissive Color` 输出来自“主强度 × 粒子颜色 RGB”，因此亮部会随粒子颜色着色。
- `Opacity` 输出来自单独的透明度乘法链路，并预留 Fade 控制。
- 预览结果是一个高亮中心、边缘带柔和衰减的加法型星芒贴图，适合作为精灵发光主体。
这是材质 `M_Additive_NOMB_01` 的 Material Graph。左侧球体预览显示一张柔和的亮面材质，没有法线起伏，说明这是一个去掉 Motion Blur 或法线扰动版本、偏基础的加法精灵材质。图中最关键的变化是：透明度链路明确接入了 `Depth Fade`。

节点定义集：

- `Desaturation`：把输入纹理先做去色处理。
- `Pow`（参数，默认值 `1.0`）：连接到 `Power.Exp`，用于调节亮度曲线。
- `Power`：接收去色结果作为 `Base`。
- `Str`（参数，默认值 `1.0`）：作为主强度系数。
- `Multiply`（中部）：把 `Power` 输出与 `Str` 相乘。
- `Particle Color`：使用其 `RGB` 着色发光，`A` 参与透明度。
- `Multiply`（右上）：把主强度和 `Particle Color.RGB` 相乘后送往材质输出。
- `Multiply`（右下）：把透明度输入进一步相乘后接到 `Depth Fade`。
- `Depth Fade`：图中 `FadeDistance = 0.0`，用于在透明度端加入与场景深度相关的淡化。

连线集：

- `Desaturation -> Power.Base`
- `Pow -> Power.Exp`
- `Power -> 中部 Multiply.A`
- `Str -> 中部 Multiply.B`
- `中部 Multiply -> 右上 Multiply.A`
- `Particle Color.RGB -> 右上 Multiply.B`
- `Particle Color.A` 参与右下 `Multiply`
- `右下 Multiply -> Depth Fade.Opacity`
- `Depth Fade` 输出接到材质最终透明度链路

设置/参数：

- `Material Domain = Surface`
- `Blend Mode = Additive`
- `Shading Model = Unlit`
- `Pow = 1.0`
- `Str = 1.0`
- `Depth Fade.FadeDistance = 0.0`

输出/预览：

- 发光链路仍然是“亮度整形后乘粒子颜色 RGB”，用于控制主视觉颜色。
- 透明度链路改为“粒子 Alpha -> Multiply -> Depth Fade -> Opacity”，因此材质在接近几何体表面时可以使用深度衰减处理边缘穿插问题。
- 预览球体表现为平滑的亮色渐变，没有明显法线细节，符合基础加法 Sprite 材质的用途。

### 00:12:24-00:15:38 材质、粒子、生命周期

- 本段定位：材质、粒子、生命周期。
- 知识点：如果这里不破坏就可以保持不变。
- 知识点：可能这是我个人的事情。
- 知识点：因为我需要提供已完成的Leed资产。
- 知识点：路径没坏,现在是这么处理的。
- 知识点：运动模糊不适用的目标处理流。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`粒子`、`生命周期`、`颜色`。

**关键画面：**

这是材质 `M_Additive_01` 的 Material Graph，画面重点在说明主贴图资源来自哪个纹理。左侧材质预览仍是中心高亮、四向拉伸的星芒；中央图中选中的是一个 `Texture Sample Parameter2D` 节点，参数名为 `Diff`，其缩略图和下方 Details 面板都表明当前绑定纹理是 `Flare_01`。

节点定义集：

- `Diff`（`Param2D`）：材质的主纹理参数，当前资源为 `Flare_01`。
- `Desaturation`：接在 `Diff.RGB` 后，对主纹理先做去色。
- `Power`：继续处理亮度曲线。
- `Pow`（参数，默认值 `1.0`）：连接到 `Power.Exp`。
- `Str`（参数，默认值 `1.0`）：作为后续强度倍增值。
- 后续仍接到 `Multiply` 和材质输出链路，但本图右侧没有完整展示最终输出端口。

连线集：

- `Diff.RGB -> Desaturation`
- `Desaturation -> Power.Base`
- `Pow -> Power.Exp`
- `Power -> Multiply`
- `Str -> Multiply`

设置/参数：

- 当前选中的 `Diff` 节点在 Details 面板里显示：
- `MipValueMode = None (use computed mip level)`
- `Sampler Source = From texture asset`
- `Automatic View Mip Bias` 已勾选
- `Const Coordinate = 0`
- 资源槽 `Diff = Flare_01`

输出/预览：

- Content Browser 打开在 `Signature/Course_02/Material`，其中高亮的是纹理资源 `Flare_01`，旁边能看到 `M_Additive_01` 及多个材质实例，说明作者此时是在确认教程示例所用的贴图资产来源。
- 这张图传达的操作重点是：先把星芒纹理 `Flare_01` 作为 `Diff` 参数接入材质，再继续做去色、亮度曲线和强度控制。
这是材质 `M_Additive_NOMB_01` 的 Material Graph。左侧预览显示一个白粉色发光圆斑，边缘带少量深色缺口；右侧图中可以完整看出发光链路和透明度链路分别如何接到 `Emissive Color` 与 `Opacity`。

节点定义集：

- 左侧 `Texture Sample`：主纹理输入，图中只看得到其 `RGB/A` 输出，节点名称未完整显示。
- `Desaturation`：接收纹理颜色，左下有一个同名参数节点控制 `Fraction`，图中默认值可见为 `0.5`。
- `Power`：对去色后的亮度做指数重映射。
- `Pow`（参数，默认值 `1.0`）：连接到 `Power.Exp`。
- `Str`（参数，默认值 `1.0`）：作为强度系数。
- `Multiply`（中部）：将 `Power` 结果与 `Str` 相乘。
- `Particle Color`：`RGB` 参与发光着色，`A` 参与透明度。
- `Multiply`（右上）：将主强度与 `Particle Color.RGB` 相乘后输出到 `Emissive Color`。
- `Multiply`（右下）：将透明度输入相乘后送入 `Depth Fade`。
- `Depth Fade`：图中 `FadeDistance = 0.0`，其输出接到 `Opacity`。
- `Material Output`：可见使用 `Emissive Color` 与 `Opacity` 两个输出口。

连线集：

- `Texture Sample.RGB -> Desaturation`
- `Desaturation -> Power.Base`
- `Pow -> Power.Exp`
- `Power -> 中部 Multiply.A`
- `Str -> 中部 Multiply.B`
- `中部 Multiply -> 右上 Multiply.A`
- `Particle Color.RGB -> 右上 Multiply.B`
- `右上 Multiply -> Material Output.Emissive Color`
- `Particle Color.A` 分出一路进入右下 `Multiply`
- `右下 Multiply -> Depth Fade.Opacity`
- `Depth Fade -> Material Output.Opacity`

设置/参数：

- `Desaturation` 控制参数默认值 `0.5`
- `Pow = 1.0`
- `Str = 1.0`
- `Depth Fade.FadeDistance = 0.0`
- 左下 Details 面板可确认：
- `Directional Lighting Intensity = 1.0`
- `Apply Fogging` 已勾选
- `Translucency Pass = After Motion Blur`
- `Allow Front Layer Translucency` 已勾选

输出/预览：

- 发光部分由“去色后的主纹理亮度 × 强度 × 粒子颜色 RGB”构成。
- 透明度部分由“粒子 Alpha × 额外乘法 -> Depth Fade -> Opacity”构成，用于处理与场景深度接触时的淡出。
- 预览结果是一个柔和的加法型发光斑点，适合作为无运动模糊版本的基础精灵材质。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前选中发射器是 `Empty`。左侧预览里仍能看到一个较暗的紫色环状 Sprite 效果；左上角粒子计数显示 `Empty`、`Empty001`、`Empty003` 为 `Active`，`Empty002` 为 `Disabled`，说明作者正在多版本对比中回调基础发射器的生命周期和颜色衰减。

发射器结构：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

当前选中的模块是 `Scale Color`，右侧 Details 面板可确认参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB` 已启用，数值为 `(0.0, 0.0, 0.0)`
- `Scale Alpha` 已启用，数值为 `1.0`

下方曲线编辑器显示一条名为 `FloatCurve` 的红色曲线：在生命周期起点约为 `0.5`，随后快速下滑到接近 `0`，末端略微回升到 0 附近。这说明当前并不是线性保持亮度，而是通过曲线在粒子存活期间快速衰减可见度，再用 `Scale Color` 模块把这种变化施加到颜色或 Alpha 通道上。结合本段“材质、粒子、生命周期”的上下文，这张图表达的是：材质准备好后，还需要在 Niagara 里继续校正粒子的生命周期曲线和颜色缩放，让水环效果在生成后尽快淡出，而不是长时间保持同样亮度。

### 00:15:43-00:18:42 Alpha、材质、颜色

- 本段定位：Alpha、材质、颜色。
- 知识点：大小的话大小设为大概。
- 知识点：动画要做的更大一些。
- 知识点：还有这里也是将面朝向固定在Z轴。
- 知识点：和颜色值上就是刚才颜色值设为0。
- 知识点：Alpha设为0。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`颜色`、`透明度`、`曲线`。

**关键画面：**

这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前选中发射器是 `Empty`，选中模块为 `Initialize Particle`。左侧预览显示一个较完整的紫色环状水流 Sprite；左上角粒子计数表明 `Empty`、`Empty001`、`Empty003` 处于 `Active`，`Empty002` 处于 `Disabled`。

当前图可确认的 `Initialize Particle` 参数如下：

- `Point Attributes`
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.7`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Attributes`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 500.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

发射器主结构可见为：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

下方曲线编辑器继续显示一条名为 `FloatCurve` 的红色曲线：起点约 `0.5`，随后快速衰减到接近 `0`，结尾略有回升。这张图表达的重点是：在 `Alpha、材质、颜色` 这一段里，作者先把基础 Sprite 粒子的寿命压到 `0.7` 秒、统一尺寸设到 `500`，再配合后续曲线和颜色缩放控制透明度衰减与画面强度。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前仍选中发射器 `Empty`，模块切换到 `Scale Color`。左侧预览里水环已经明显变暗，说明当前操作集中在 Alpha 衰减而不是几何形态。

发射器当前可见结构：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

右侧 `Scale Color` 面板可确认的设置如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (0.0, 0.0, 0.0)`
- `Scale Alpha` 已启用，模式为 `Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 曲线输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 0.7`

图中右上曲线窗口显示 Alpha 曲线在生命周期前段基本保持接近 `1`，后段快速下降到接近 `0`；下方曲线编辑器里的红线也表现为前高后低的快速衰减。结合字幕“把 Scale 稍微缩小到 0.7 左右”，可以确认这里是在把整体 Alpha 缩放值压到 `0.7`，同时保留一个随 `NormalizedAge` 递减的透明度曲线。这样粒子生成后会先维持短暂可见，再在后半程迅速淡出，避免水环长时间停留在高亮状态。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前选中的是新发射器 `Empty004`，模块为 `Sprite Renderer`。左侧预览几乎不可见，只剩非常暗的结果；左上角粒子计数显示 `Empty004` 已处于 `Active`，说明作者正在为一个新的 Sprite 版本切换渲染材质并测试透明度表现。

系统中当前可见两个发射器卡片：左侧为 `Empty`，右侧为 `Empty004`。右侧 Details 面板可确认的 `Sprite Renderer` 设置如下：

- `Material = M_Translucent_01_Ins_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Remove HMD Roll` 未勾选
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Cast Shadows` 已勾选
- `Sort Order Hint = 0`
- `Motion Vector Setting = Auto Detect`

下方曲线编辑器仍显示同一条快速衰减的 `FloatCurve`，但当前图的关键变化不是曲线本身，而是渲染器材质已经切换为半透明实例 `M_Translucent_01_Ins_01`。结合本段关于 `Alpha`、`材质`、`颜色` 的上下文，这一步是在对新的 Sprite 发射器版本测试“半透明材质 + 当前 Alpha 衰减”的组合效果，并通过 `Sprite Renderer` 侧的材质与朝向设置确认最终可见形态。

### 00:18:45-00:21:45 Substance、颜色、透明度

- 本段定位：Substance、颜色、透明度。
- 知识点：是加入了渐变功能的状态。
- 知识点：加入了渐变功能的这个状态。
- 知识点：这边的效果就会适当减弱。
- 知识点：这个感觉就像是刚才上面做的核心元素现在被剪掉了。
- 知识点：作为副元素现在可以用的第二个材料。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`、`透明度`。

**关键画面：**

这是半透明材质实例 `M_Translucent_01_Ins_01` 的参数面板。左侧预览显示一个边缘柔和、中心纯白的圆形衰减贴图，说明当前副元素材质已经不再使用前面的星芒纹理，而是换成了更适合做底层辅元素的圆形 falloff 纹理。

设置/参数：

- `Global Scalar Parameter Values`
- `Desaturation = 0.0`
- `Fade_Dist = 50.0`
- `Pow = 1.0`
- `Str = 1.0`
- `Global Static Switch Parameter Values`
- `Use_Fade = True`（已启用）
- `Global Texture Parameter Values`
- `Diff = falloff_circle`

常规信息：

- `Parent = M_Translucent_01`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`

输出/预览：

- 预览结果是一个标准的软边白色圆盘，没有明显颜色变化，说明这一步主要在建立“带 Fade 功能的副元素基础材质实例”。
- 结合本段关于“第二个材料”“加入了渐变功能”的上下文，可确认这里的核心操作是：在半透明父材质基础上，启用 `Use_Fade`，并把主纹理切换为 `falloff_circle`，为后续副元素的透明度和颜色控制准备更干净的基础纹理。
这是材质实例 `M_RadialUV_01_Ins_03` 的参数面板。左侧预览里只能隐约看到一个非常暗的环形轮廓，说明作者正在调一个作为副元素或底层辅助效果的低亮度材质；右侧参数区则给出了这套材质实例的主要颜色、法线、折射和透明度控制。

设置/参数：

- `Color`
- `Center_Color = (R 1.0, G 0.0, B 0.2, A 1.0)`，颜色显示为高饱和洋红
- `Color_Bias = 1.0`
- `Color_Str = 1.0`
- `Color_Tex = T_Color_01`
- `Color_Tile_U = 1.0`
- `Color_Tile_V = 0.5`
- `Desaturation = 0.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.0`
- `Edge_Str = 1.0`
- `Global Scalar Parameter Values`
- `Refraction_Str = 1.03`
- `Global Static Switch Parameter Values`
- `Use_Refraction = True`
- `Normal`
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 4.0`
- `Normal_Tile_V = 0.5`
- `Opacity`
- `Fade_Dist = 1.0`
- `Mask_Str = 5.0`
- `Mask_Tex = T_CircleGra_01`

输出/预览：

- 这套参数表明材质不是单纯的白色软圆，而是使用 `T_Color_01` 做中心颜色纹理、`Normal_06` 做法线扰动、`T_CircleGra_01` 做透明度遮罩，再叠加轻微折射。
- 预览结果之所以仍然很暗，说明当前副元素材质被设计为只在画面中提供轻微边缘轮廓和折射层，不承担主发光主体。
这是同一个材质实例 `M_RadialUV_01_Ins_03` 的继续调参画面。左侧预览中已经能看到一圈非常暗、带断续高亮碎片的圆环轮廓，说明当前修改重点从基础颜色配置转向法线与透明度纹理的细节分布。

当前图可确认的设置/参数如下：

- `Refraction_Str = 1.03`
- `Use_Refraction = True`
- `Normal`
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 2.0`
- `Normal_Tile_V = 0.3`
- `Opacity`
- `Fade_Dist = 1.0`
- `Mask_Str = 5.0`
- `Mask_Tex = T_CircleGra_01`
- `Opacity_Pow = 1.25`
- `Opacity_Str = 30.0`
- `Opacity_Tex = T_AuraV_02`
- `Opacity_Tile_U = 3.0`
- `Opacity_Tile_V = 0.5`

常规信息：

- `Parent = M_RadialUV_01`
- `Refraction Depth Bias = 0.0`
- `Blend Mode = Additive`

输出/预览：

- 与上一张相比，这里最明显的变化是把透明度纹理链单独强化了：`Opacity_Tex` 使用 `T_AuraV_02`，并通过 `Opacity_Str = 30.0`、`Opacity_Pow = 1.25` 把局部亮条压出更清晰的断续轮廓。
- 法线平铺也从更密的值收敛到 `U=2.0`、`V=0.3`，因此预览中的环边噪波更拉长、更稀疏。
- 这张图表达的是副元素材质的“轮廓感”构建方式：圆形遮罩负责整体范围，`T_AuraV_02` 决定可见断续条纹，法线与折射提供轻微扰动，最终得到一个非常暗但有结构的辅助环形层。

### 00:21:47-00:24:47 颜色、纹理、动态参数

- 本段定位：颜色、纹理、动态参数。
- 知识点：把这个铺砖呢适当提高了一些。
- 知识点：强度适当调高一些。
- 知识点：看一下力量和强度。
- 知识点：再强烈一点,让音调更加明显。
- 知识点：这样感觉来进行吧。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`纹理`、`颜色`、`动态参数`。

**关键画面：**

这是材质实例 `M_RadialUV_01_Ins_03` 的继续调参画面。左侧预览里原本很暗的辅助环现在已经能清楚看到一圈断续的亮边和向内拉伸的条状纹理，说明作者开始提高纹理显著度与透明度强度。

当前图可确认的设置/参数如下：

- `Refraction_Str = 1.03`
- `Use_Refraction = True`
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 2.0`
- `Normal_Tile_V = 0.3`
- `Fade_Dist = 1.0`
- `Mask_Str = 10.0`
- `Mask_Tex = T_CircleGra_01`
- `Opacity_Pow = 1.25`
- `Opacity_Str = 30.0`
- `Opacity_Tex = T_AuraV_02`
- `Opacity_Tile_U = 3.0`
- `Opacity_Tile_V = 0.8`
- `Parent = M_RadialUV_01`
- `Refraction Depth Bias = 0.0`
- `Blend Mode = Additive`

输出/预览：

- 与上一批同一材质实例相比，这里最直接的变化是 `Mask_Str` 从较低值进一步提高到 `10.0`，而 `Opacity_Tile_V` 调到 `0.8`，使遮罩与透明度纹理在环形轮廓上形成更明显的断续亮段。
- 预览中的圆环已经从“几乎不可见的暗轮廓”变成“可辨认的副层发光边缘”，说明这一步是在测试纹理强度与纵向平铺对整体视觉密度的影响。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图。当前选中发射器为 `Empty005`，右侧 Details 面板显示选中模块是 `Camera Offset`。左侧预览已经能看到一个多层结构：外圈是原有的紫白色水环，内侧叠加了一层带辐射纹理的圆盘状副元素。

当前图可确认的系统状态：

- 左上粒子计数显示 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005` 处于 `Active`
- `Empty002` 处于 `Disabled`
- 系统中可见多个发射器卡片，当前高亮的是 `Empty005`

`Empty005` 当前选中模块的参数：

- `Camera Offset`
- `Camera Offset Amount = 50.0`

图中悬浮提示写明该模块作用为“沿粒子与相机之间的向量偏移粒子”。结合预览结果，可以确认这里是在把新增的副元素层沿视线方向往前或往后推开，避免它与主水环完全重合。这样做的直接效果是：内部那层带纹理的圆盘不会和外层主环挤在同一深度上，画面层次会更清楚，也更方便后续通过动态参数分别调颜色和强度。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前选中发射器仍为 `Empty005`，但右侧模块切换到 `Dynamic Material Parameters`。左侧预览显示外层主水环与内层辐射纹理圆盘已经共同构成一个双层结构，说明这一步是在把 Niagara 生命周期数据继续传给材质，驱动内部副层的滚动或扭曲效果。

发射器上下文：

- 当前激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`
- 选中的 `Empty005` 发射器在 `Particle Update` 区域包含 `Dynamic Material Parameters`

`Dynamic Material Parameters` 当前图可确认的内容：

- 处于 `All` 视图，显示多个动态参数槽
- `Opacity_VPan`
- 模式为 `Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- 当前 `Scale Curve = 1.0`
- 曲线形态从生命周期起点约 `0.8` 左右逐渐下降，到末端接近 `0.0`
- `Distortion`
- 模式为 `Float from Curve`
- 同样使用 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- 当前 `Scale Curve = 1.0`
- 曲线形态从接近 `0.0` 开始，随生命周期逐步上升到约 `0.05`
- `ColorPow = 0.0`
- `Param3-0 = 0.0`

输出/预览：

- `Opacity_VPan` 这条下降曲线表示材质里与透明度或纵向纹理位移相关的参数，会在粒子老化过程中逐步减弱。
- `Distortion` 这条上升曲线表示扭曲/折射强度会随着 `NormalizedAge` 增长而增强。
- 这正是本段“颜色、纹理、动态参数”的关键做法：不是只在材质实例里写死数值，而是通过 Niagara 的 `Dynamic Material Parameters` 把生命周期曲线传进材质，让内层副元素随粒子年龄动态变化透明度滚动和扭曲效果。

### 00:24:52-00:27:48 粒子、颜色、纹理

- 本段定位：粒子、颜色、纹理。
- 知识点：最亮的部分在这里结束。
- 知识点：我们给这部分加了纹理。
- 知识点：这种部分有点接触时张力就会更搭配这种。
- 知识点：时针部分这样加进去应该也可以。
- 知识点：我们现在有一个关系。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`纹理`、`粒子`、`颜色`、`动态参数`。

**关键画面：**

这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前仍选中发射器 `Empty005` 的 `Dynamic Material Parameters` 模块。左侧预览中，外层主水环与内层辐射副层已经组合成较稳定的双层结构；左下参数树也被展开，能看到当前曲线编辑的是 `Dynamic Material Parameters` 下的 `Index 0 Param 1`。

当前图可确认的发射器上下文：

- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`
- 左下层级中，`Empty005` 下可见：
- `Scale Sprite Size`
- `Dynamic Material Parameters`
- `Index 0 Param 1`
- `Index 0 Param 2`
- `Scale Color`

右侧 `Dynamic Material Parameters` 当前可确认的内容：

- 处于 `All` 视图
- `Opacity_VPan`
- 模式为 `Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从生命周期前段较高值逐步衰减，到末端接近 `0`
- `Distortion`
- 模式为 `Float from Curve`
- 同样使用 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从低值起步并随生命周期上升到约 `0.05`
- `ColorPow = 0.0`
- `Param3-0 = 0.0`

输出/预览：

- 这张图比上一批更明确地表明：`Index 0 Param 1` 和 `Index 0 Param 2` 这两个动态参数槽分别被用来驱动材质中的纵向透明度变化和扭曲强度。
- `Opacity_VPan` 随年龄下降，`Distortion` 随年龄上升，因此内层副元素会在存在后期逐渐减弱位移/透明表现，同时增强扭曲感，形成更活的纹理层变化。
这是父材质 `M_RadialUV_01` 的 Material Graph。左侧预览只显示一条很窄的红色发光切片，说明当前图重点不在最终外观，而在材质内部如何接收 Niagara 动态参数。中央清晰可见一个 `Dynamic Parameter` 节点，参数名已经与 Niagara 侧一致。

节点定义集：

- `Color_Tile_U`（参数，默认值 `1.0`）
- `Color_Tile_V`（参数，默认值 `1.0`）
- `Dynamic Parameter`（`Input Data`，`Parameter Index = 0`）
- 该节点暴露的通道命名为：
- `Opacity_VPan`
- `Distortion`
- `ColorPow`
- `Param4`
- `Normal_Tex`（`Param2D`）
- `Mask (R G)`：从纹理里取 `RG` 通道
- 多个 `Multiply`
- 一个 `Append`

连线集：

- `Color_Tile_U` 与 `Color_Tile_V` 分别进入一个 `Multiply`，用于构造颜色纹理的平铺控制
- `Dynamic Parameter.Opacity_VPan` 输出接入右侧乘法链路，参与材质中的纵向位移/透明度相关计算
- `Dynamic Parameter.Distortion` 输出接入另一条乘法链路，参与法线或扭曲强度控制
- `Dynamic Parameter` 还向下连到透明度/遮罩相关分支
- `Normal_Tex -> Mask(R G)`，再进入右侧 `Multiply`
- 左下两个 `Multiply` 输出进入 `Append`，然后送到 `Normal_Tex.UVs`

设置/参数：

- 左下 Details 面板可确认：
- `Material Domain = Surface`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`

输出/预览：

- 这张图给出了关键证据：Niagara 侧写入的 `Opacity_VPan`、`Distortion` 不是任意命名，而是父材质 `M_RadialUV_01` 中 `Dynamic Parameter` 节点的正式通道名。
- 因此前一张 Niagara 图里的生命周期曲线会直接影响材质里的 UV 位移和扭曲分支，实现“粒子年龄驱动纹理流动/折射变化”的动态联动。
这是 `Ex_01_SpriteExp` 中 `Empty005` 发射器的 `Dynamic Material Parameters` 调整画面。左侧预览里，内层辐射纹理环已经明显嵌进主水环中心，整体亮度和层次都比前两张更强；右侧参数面板仍显示 `Opacity_VPan` 与 `Distortion` 两条曲线，同时新增了对 `ColorPow` 的直接数值调整。

当前图可确认的内容：

- 发射器 `Empty005` 处于激活状态
- 左下曲线树仍展开到：
- `Dynamic Material Parameters`
- `Index 0 Param 1`
- `Index 0 Param 2`
- 右侧 `Dynamic Material Parameters` 中：
- `Opacity_VPan = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从较高值递减到接近 `0`
- `Distortion = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从接近 `0` 递增到约 `0.05`
- `ColorPow = 1.0`
- `Param3-0 = 0.0`

输出/预览：

- 这一步的关键变化是把 `ColorPow` 从先前的 `0.0` 提高到 `1.0`。结合字幕“我会加大一点，大约 0.1”，可以确认作者正在额外提升材质内部颜色/亮度幂次相关控制，让内层纹理条纹更加可见。
- 预览上，内层副环的暗紫色纹理已经更集中、更有存在感，说明动态材质参数此时不只是做位移和扭曲，还开始直接参与颜色强度塑形。

### 00:27:54-00:30:36 纹理

- 本段定位：纹理。
- 知识点：我现在只用一个显示器在看。
- 知识点：首先气氛这些部分表现的不错。
- 知识点：中间现在放进去的元素是。
- 知识点：更有气氛的气氛这个。
- 知识点：最后的余韵也一起负责的部分。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这是 Unreal 关卡视口，而不是 Niagara 或材质编辑器局部面板。画面中间是一名站在棋盘测试地面上的角色模型，右侧 `Outliner` 显示当前场景 `Ex_01_SpriteExp` 下挂有灯光、天空光、静态网格球、电影相机、多个 Niagara Actor，以及一个名为 `Phase GDC` 的骨骼网格对象。

当前图可确认的场景结构：

- 场景根对象：`Ex_01_SpriteExp`
- `Lighting`
- `DirectionalLight`
- `SkyLight`
- `SM_SkySphere`
- `Cine Camera Actor`
- 多个 `Ex 01 Sprite Exp` Niagara Actor
- `Ex_01_SpriteExp` 关卡对象
- `Floor`
- `Phase GDC`

这张图传达的重点是：作者已经把特效放回实际场景视口中检查，而不是只在材质球或 Niagara 预览窗里看单独纹理。由于本段主题是“纹理”，这里的作用是确认这些副层纹理在角色、地面和真实摄像机视角下是否仍然有合适的气氛感和余韵层次。当前截图里特效本体未清晰显示，能可靠确认的是场景验证环境、摄像机与测试角色都已经就位。
这是材质实例 `M_RadialUV_01_Ins_04` 的参数面板与纹理资源浏览画面。左侧预览里能看到一条发光环边缘，中央打开的 `Content Browser` 指向 `Signature/Course_03/Texture`，说明作者正在直接比对可用纹理资源，并确认当前实例所用的遮罩、噪波和透明度纹理。

当前图可确认的资源与参数：

- 当前材质实例标签：`M_RadialUV_01_Ins_04`
- `Color_Tex = T_Color_01`
- `Color_Tile_U = 1.0`
- `Color_Tile_V = 0.5`
- `Desaturation = -1.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.0`
- `Edge_Str = 1.0`
- `Use_Refraction` 未勾选
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 2.0`
- `Normal_Tile_V = 0.3`
- `Fade_Dist = 1.0`
- `Mask_Str = 10.0`
- `Mask_Tex = T_CircleGra_01`
- `Opacity_Pow = 0.5`
- `Opacity_Str = 30.0`
- `Opacity_Tex = T_AuraV_02`
- `Opacity_Tile_U = 3.0`
- `Opacity_Tile_V = 0.8`

`Content Browser` 中可直接看到的候选纹理包括：

- `T_AuraV_01`
- `T_AuraV_02`
- `T_AuraV_03`
- `T_CircleGra_01`
- `T_Color_01`
- `T_MagicCircle_01`
- `T_Ribbon_04`
- `T_Ribbon_05`

输出/预览：

- 这张图的关键信息不是新增节点，而是纹理资产选择关系已经被明确钉住：圆形遮罩使用 `T_CircleGra_01`，条带/余韵透明度使用 `T_AuraV_02`，颜色噪波使用 `T_Color_01`。
- 同时 `Use_Refraction` 被关闭，说明这一版更关注纹理本身的层次和拖尾感，而不是折射效果。
这是材质实例 `M_RadialUV_01_Ins_04` 的进一步纹理替换结果。左侧预览已经不再是简单的环形副层，而是一个完整、清晰的魔法阵样式圆盘，包含外圈符文、内圈三角结构和中心空洞；这说明作者在本段最后把遮罩纹理从普通圆形渐变切换到了更复杂的图案纹理。

当前图可确认的参数如下：

- `Center_Color = (R 1.0, G 0.0, B 0.2, A 1.0)`
- `Color_Bias = 1.0`
- `Color_Str = 1.0`
- `Color_Tex = T_Color_01`
- `Color_Tile_U = 1.0`
- `Color_Tile_V = 0.5`
- `Desaturation = -1.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.5`
- `Edge_Str = 500.0`
- `Use_Refraction` 未勾选
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 2.0`
- `Normal_Tile_V = 0.3`
- `Fade_Dist = 1.0`
- `Mask_Str = 10.0`
- `Mask_Tex = T_MagicCircle_01`
- `Opacity_Pow = 0.5`
- `Opacity_Str = 30.0`

输出/预览：

- 与上一张相比，最关键的变化是 `Mask_Tex` 已经从 `T_CircleGra_01` 换成 `T_MagicCircle_01`，因此预览从软边圆形遮罩直接变成了带符号和几何图样的完整魔法阵。
- `Edge_Pow = 1.5` 与 `Edge_Str = 500.0` 也显著提高了边缘亮度和锐利度，所以这版画面更“清爽”、更图形化，正对应字幕里“更清爽一些”的调整目标。

## 补充视觉证据

### S07 00:20:50

这是 `补充视觉证据` 中的参数截图，对应材质实例 `M_RadialUV_01_Ins_03`。左侧预览里只剩一圈很暗的断续环形轮廓，说明这是一版偏弱、偏辅助层的副元素材质；右侧参数面板则给出了这版在 `S07 00:20:50` 时的基准配置。

当前图可确认的参数如下：

- `Color`
- `Center_Color = (R 1.0, G 0.0, B 0.2, A 1.0)`
- `Color_Bias = 1.0`
- `Color_Str = 1.0`
- `Color_Tex = T_Color_01`
- `Color_Tile_U = 1.0`
- `Color_Tile_V = 0.5`
- `Desaturation = 0.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.0`
- `Edge_Str = 1.0`
- `Global Scalar Parameter Values`
- `Refraction_Str = 1.03`
- `Global Static Switch Parameter Values`
- `Use_Refraction = True`
- `Normal`
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 4.0`
- `Normal_Tile_V = 0.5`
- `Opacity`
- `Fade_Dist = 1.0`
- `Mask_Str = 5.0`
- `Mask_Tex = T_CircleGra_01`

输出/预览：

- 这张补充图的价值在于固定了 `S07` 阶段较早版本的副层材质参数：此时仍启用折射，法线平铺更密，遮罩强度也只有 `5.0`。
- 与后续批次里更亮、更复杂的版本相比，这一版的环形轮廓更弱，说明后面所有增强都是在这个基础组合上逐步加出来的。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


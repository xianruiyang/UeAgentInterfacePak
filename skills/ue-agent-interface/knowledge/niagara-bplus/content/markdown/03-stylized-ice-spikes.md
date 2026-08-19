# 03 Stylized Ice Spikes

# 03 Stylized Ice Spikes

## 关键术语

- `Spawn`、`PS`、`粒子`、`速度`、`透明度`、`所以，我们像这样添加它。现在它是空的`、`但总的来说，加入细节会让它看起来相当不错`、`Niagara`、`系统`、`生命周期`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Initialize Particle`、`Lifetime`、`Color`

## 分段知识

### 00:00:05-00:03:08 颜色

- 本段定位：颜色。
- 知识点：好,现在可以开始了 是的,我们已经设置了我们的组织 我们只需要再加一层层次,这样就会更容易调整 所以我们把它加成这样,它已经空了。
- 知识点：这就是它了,这里没有其他东西 现在可以转移它 我们先制作摄像机 我们先制作一个简单的摄像机 我们把它放在这里,现在我们有摄像机 我们也可以加一个效果,这样我们可观察到。
- 知识点：可以通过这个时光,把它控制住 然后我们把它放在这里 这样可以控制它 我们也可以这样设置摄像机,这样 可以从这个角度看到。
- 知识点：可以调整这个场景 通常需要把它放在这个角度,在最后 我认为需要在最后调整一些东西 现在我们只需要整个看起来,可以把所有东西都拔掉。
- 知识点：如果不需要,我还以为可以删除这个选项 这个气氛 像这样 可以设置摄像机 可以从这里取出摄像机的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是 `p68` 新页开头的工程组织步骤，重点从上一页的材质/动态参数调试切到序列资源和关卡管理。作者正在内容浏览器里定位冰刺演出要用的 `Level Sequence`

界面锚点：
- 当前场景仍是 `Stylized_IceSpikes`
- `Outliner` 中选中对象为 `NS_IceSpikes`
- 右侧 `Details` 显示 `NS_IceSpikes` 的 `NiagaraComponent`

下方 `Content Browser` 当前路径：
- `Content / VFX_Library / Sequences / IceSpikes`

当前选中的资源：
- `LS_IceSpikes`
- 资源类型：`Level Sequence`

上方添加搜索框中输入了 `level`，展开结果中可见多类与关卡相关的 Actor / Volume / Sequence 项，例如：
- `Level Sequence Actor`
- `Level Streaming Volume`
- `Level Bounds`
- `Level Instance`

字幕 “So, we add it like this. It's empty for now.” 结合当前画面，可以理解为作者在说明：
- 先把 `LS_IceSpikes` 这类序列资源加入场景或工作流
- 该序列此时还是空的，后面再往里填角色、特效或控制轨道

这一步的作用是为后续“颜色/粒子效果如何在时间线上演出”做准备。与前页只在 Niagara 里看循环预览不同，`Level Sequence` 会把 `NS_IceSpikes`、角色和镜头行为组织成一个正式的场景演出资产
这张图说明 `LS_IceSpikes` 已经不再是空序列，作者开始在 Sequencer 里布置镜头和特效播放轨道，让冰刺效果进入正式的时间轴演出

Sequencer 结构可见：
- 当前打开的序列为 `LS_IceSpikes`
- 顶部视口显示 `Pilot Actor: CameraActor`
- 时间轴帧率为 `30 fps`
- 当前播放头位置约在 `0.70s`

左侧轨道树可见对象：
- `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
  - `Transform`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`

时间轴内容：
- `Camera Cuts` 轨道已经有镜头片段
- `CameraActor` 轨道存在连续的镜头段
- `NS_IceSpikes` 下方有 `Life Cycle` 红色条带，表示特效系统的生命周期区间已经被放上时间轴

右侧 `Outliner` 中也能看到：
- `CameraActor`
- `LevelSequenceActor`
- `NS_IceSpikes`

视口画面里，一排冰刺正处于镜头中央，说明作者已经在用 Sequencer 驱动一个固定镜头去观看 `NS_IceSpikes` 的展开，而不是只在编辑器里手动移动视角

这一步的核心作用是把 Niagara 系统正式接到 `Level Sequence` 上：
- `CameraActor` 负责构图和镜头切换
- `NS_IceSpikes -> System Life Cycle` 负责特效在时间轴上的触发与持续时段

这样后续就能用序列精确控制冰刺何时开始、何时结束，以及镜头在演出过程中的观看方式
这张图继续停留在 `LS_IceSpikes` 的序列场景里，但重点已经从“把系统放上时间轴”转向“让镜头里的发光效果更好看”。作者当前选中的是 `PostProcessVolume`，直接通过后处理里的 Bloom 放大冰刺的亮部扩散

场景与序列锚点：
- 顶部视口仍为 `Pilot Actor: CameraActor`
- 当前序列仍是 `LS_IceSpikes`
- 时间轴帧率为 `30 fps`
- 当前播放头约在 `0.42s`

右侧 `Outliner` 当前选中对象：
- `PostProcessVolume`

右侧 `Details` 当前可见设置：
- `PostProcessVolume (Instance)`
- `Bloom`
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`
- 上方还可见 `Mobile Depth Of Field`

视口结果：
- 冰刺本体依旧位于画面左下区域
- 外围出现非常强的蓝色光晕扩散
- 最大那根冰刺已经有接近白核 + 大范围蓝色 Bloom 的表现

这一步说明作者不仅在 Sequencer 中安排了镜头和 Niagara 生命周期，还开始通过场景后处理塑造最终成片观感。`Bloom Intensity = 15.0` 且 `Threshold = -1.0` 会让冰刺的高亮区域更容易产生强烈泛光，因此同样的材质和特效，在序列镜头里会显得更有能量感和戏剧性

### 00:03:17-00:07:59 PS、粒子、颜色

- 本段定位：PS、粒子、颜色。
- 知识点：可以把它调整到60fps这样 它完全调整了,我们把它调整到最开始 好,这就更好 这里有一个很有趣的反光 我们再来调整一下,需要调整到最开始。
- 知识点：把它调整到这样,没有反光 这是这种 很蠢,但这个比较好 15-25,这就好了 10,好,我们把它调整到这样 是的,现在我们把它调整到这样。
- 知识点：像这样 好,现在我们把细节调整到这个角度 这是我们的调整 需要加一个颜色像这个角度 有点硬 它会在我们的3D模特上加上一些重量 它会造成一个调整的样子,它会变得更明显。
- 知识点：我们需要加一些细节 调整到它变得好 我们现在把它设置好 首先,我们先把質料设置成这樣 很好,可以搜尋一些东西 我们需要一些很鮮明的东西。
- 知识点：像这个 可以设置一个很鮮明的質料 一个很鮮明的圆形 但可以用这个方法 来使用它 我们先选择这个選項 这个很不錯 首先我们把加點改变。
- 知识点：它会像一个背景光 下一个 这是非常重要的 需要它消失 需要把它做成这樣 把它伸直 非常好 在高度 需要它慢慢消失 從上面或下面上 用溶解器 所以。
- 知识点：需要把溶解器变成一种光线 这种光线 用简单的转换 我们也会设置順滑 让它变成这樣 这是一个 加點改变 基本上我们没有觸碰任何东西 把它放在这里。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`系统`、`颜色`。

**关键画面：**

这张图继续在 `LS_IceSpikes` 序列里检查冰刺演出，但当前关注点从“把轨道搭起来”转到“播放时特效本体的外观和时间位置是否合适”

场景与序列锚点：
- 顶部视口仍是 `Pilot Actor: CameraActor`
- 当前序列仍为 `LS_IceSpikes`
- 时间轴左下角可见当前帧率已切到 `60 fps`
- 当前播放头位置约为 `0.38s`

时间轴结构可见：
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`
- 红色 `Life Cycle` 条带仍横跨主要播放区间

右侧 `Outliner` 当前选中对象：
- `NS_IceSpikes`
- 同一行 `Sequencer` 列也显示它属于 `LS_IceSpikes`

右侧 `Details` 当前可见：
- `Niagara System Asset = NS_IceSpikes`
- `Niagara Tick Behavior = Use Prereqs`
- `Auto Activate` 已启用
- `Niagara Utilities` 下可见 `Debug`、`Reset`、`Capture`

视口结果：
- 冰刺位于镜头左下偏中的位置
- 主体外层有很强的蓝色光晕，最大冰刺接近白核
- 说明当前序列镜头、Niagara 生命周期和上一段设置过的 Bloom/颜色处理正在共同生效

这一步的意义是：作者把镜头时间精确拖到特效播放中的某一帧，直接观察 `NS_IceSpikes` 在序列里的视觉状态，并开始按镜头效果来判断亮度、反光和颜色是否合适，而不再只看静态工程设置
这张图说明作者在继续看序列镜头效果的同时，开始为冰刺演出寻找更合适的 2D 形状纹理资源，用来补充粒子或投影细节

场景与后处理状态：
- 视口中冰刺仍以蓝白色高亮状态显示
- 当前选中对象是 `PostProcessVolume`
- 右侧 `Details` 可见 `Bloom`：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

下方 `Content Browser` 当前路径：
- `Content / VFX_Library / Textures / Shapes`

当前可见纹理资源类型：
- 一系列形状/冲击/法阵类贴图，例如：
  - 多个 `T_Impact...`
  - 多个 `T_InvokeArea...`
  - `T_Leaf...`
  - `T_Magic...`

可见形状特征：
- 星形爆发
- 尖角裂片
- 圆环法阵
- 叶片
- 烟雾/雾状白斑

字幕提到 “A sharp triangle”，结合当前贴图库可以确定，作者正在找一种更尖锐、更适合冰刺方向性的形状，而不是圆润的通用光斑

这一步的作用是为 `PS、粒子、颜色` 这一段补足 2D 细节资源：冰刺本体还是由 `NS_IceSpikes` 和材质决定，但额外的粒子/贴片/闪光形状可以用这些 `Textures / Shapes` 里的纹理来塑造更锋利的轮廓和更有重量感的发光细节
这张图已经正式进入 Niagara 系统结构调整阶段。作者在 `NS_IceSpikes` 中加入了一个新的 `Empty` 发射器，并开始用它控制一个额外粒子层的位置分布，而不是继续只改现有冰刺网格发射器

系统结构可见：
- 当前系统为 `NS_IceSpikes`
- 左侧已有 `Spikes_Sides`
- 新增一个发射器 `Empty`
- 时间轴列表底部还能看到：
  - `Spikes_Center`
  - `Spikes_Sides`

`Empty` 发射器的当前模块结构：
- `Emitter Summary`
- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
- `Spawn Rate`
- `Particle Spawn`
- `Initialize Particle`
- `System Location`
- `Particle Update`
- `Particle State`
- `Render`
- `Sprite Renderer`

右侧 `Details` 当前显示的是 `Empty` 发射器里的 `System Location`

可见设置/参数：
- `Offset` 使用 `Make Vector`
- `X` 通道使用 `Float from Curve`
- 曲线索引器为 `EMITTER.NormalizedLoopAge`
- `Scale Curve = 1.0`
- `Y = 0.0`
- `Z` 使用 `Random Range Float`
  - `Minimum = -25.0`
  - `Maximum = 25.0`
- `Offset Coordinate Space = Local`

输出/预览：
- 左侧预览窗口中暂时几乎看不到结果，说明这个新层当前还处于基础位置分布搭建阶段
- 字幕提到 “different height” 与 “remove the randomization”，结合当前 `Z` 随机范围可知，作者正在检查这些随机高度是否过大，准备让分布更可控

这一步的意义是给冰刺主效果加一个独立的辅助粒子发射器。`Empty` 更像是用来承载额外的贴片、光片或装饰粒子，它通过 `System Location.Offset` 的曲线和随机高度决定粒子沿系统路径如何分布。后续如果要让细节从左到右有节奏地出现，或让高度变化更规整，就会继续在这组偏移与随机参数上收紧范围

### 00:08:00-00:13:00 关键流程 03

- 本段定位：关键流程 03。
- 知识点：像这个 我们现在要管理它的大小 我们把它们这樣移动 这里只会有一个影响的循環 所以我们把它们这樣移动 这里会有一个循環 像这个 现在需要设置这个循環。
- 知识点：这就是我们的價值 最初它们会是0 就在开始的时候 然后慢慢地它们会变成这个样子 并会快速地增长 这会是在我们有的循環时 很相似的东西。
- 知识点：这会是很相似的东西 我们甚至可以從这里拿到什么 差不多一樣 这里我只想要把它们推動一点 让我把它们剪輯 剪輯 把它们剪輯在这里 这就是我们從Z拿的。
- 知识点：需要把它们放進去 这里 所以我们就这樣做 很相似的 只有一个东西 我们想要在循環上 它们很小 我们要把它们很大 所以放進去 就这樣 让我把它们都放進去。
- 知识点：有些东西出现 它们还是很小 因为我们要最終延长 为什么我们要把循環分成一些價值 所以需要分成X和Y 需要它们要3.5倍大 可能是 我们需要看到結果。
- 知识点：特别是向着鏡頭 它们会看起来很奇怪 我们需要它们一直向着鏡頭看 所以我们现在来處理循環 设置定位 你 是的 这里有所有东西 定位 设置控制器 使用循環面对。
- 知识点：循環 我们不需要循環面对 我们只需要循環 所以它会看起来 我们设置了 Z会 它会一直看着鏡頭 不管我们如何轉動 基本上它会一直向着鏡頭看 这里。

**关键画面：**

这张图进入 `关键流程 03` 的具体实现阶段。作者不再停留在系统位置分布，而是开始调整新增发射器 `Empty` 的 `Initialize Particle`，为后续的辅助 Sprite 粒子设置基础寿命和初始属性

系统结构：
- 当前系统为 `NS_IceSpikes`
- 左侧已有 `Spikes_Sides`
- 中间选中发射器为 `Empty`

`Empty` 发射器中当前聚焦模块：
- `Initialize Particle`

当前可见设置/参数：
- 顶部分类标签可见：
  - `Point`
  - `Sprite`
  - `Mesh`
  - `Ribbon`
  - `All`
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.3`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`

在 `Sprite Attributes` 中可见：
- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

在 `Mesh Attributes` 中可见：
- `Mesh Scale Mode = Unset`
- `Mesh Renderer Array Visibility Mode = Unset`

在 `Ribbon Attributes` 中可见：
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

输出/预览：
- 左侧预览窗口中只看到很小的白色粒子点，说明 `Empty` 目前还是非常基础的 Sprite 层，还没有被放大成明显形状

这一步的作用是先把辅助粒子的“生命长度”和初始类别定稳。`Lifetime = 0.3` 表示这层细节粒子存在时间很短，更像是冰刺生长时的瞬时闪片或预备细节，而不是持续存在的主网格效果
这张图继续针对 `Empty` 发射器，但现在聚焦的是 `Sprite Renderer`。作者已经给这层辅助粒子指定了专用材质，并开始调整 Sprite 的对齐与枢轴，让它更适合作为贴在冰刺上的细节片

系统结构：
- 当前系统仍为 `NS_IceSpikes`
- 当前选中发射器为 `Empty`
- 当前聚焦模块为 `Sprite Renderer`

`Sprite Renderer` 当前可见设置：
- `Material = MI_SpikesTexture_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Remove HMD Roll` 未启用
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`

其它可见分组：
- `Sorting`
  - `Sort Mode = None`
- `Visibility`
  - `Enable Camera Distance Culling` 未启用
  - `Renderer Visibility = 0`

输出/预览：
- 左侧预览中，冰刺主体已经可见，说明这层 `Empty` 发射器所使用的 Sprite 细节开始叠加到主效果附近
- 字幕明确提到 “we need to change the pivots”，而当前 `Default Pivot in UV Space = (0.5, 0.5)` 说明作者此时正在围绕 Sprite 的中心枢轴做下一步调整

这一步的意义是：辅助粒子的可见材质已经确定为 `MI_SpikesTexture_01`，接下来关键不只是大小或寿命，而是 Sprite 的支点位置和朝向。对这种尖锐、贴附在冰刺表面的形状来说，错误的 pivot 会让纹理看起来像是漂浮在表面之外，或者朝向相机时显得不自然
这张图继续处理 `Empty` 发射器的辅助 Sprite，但当前模块已经从渲染器切到尺寸控制。作者通过一条按粒子年龄驱动的曲线，让这些小贴片在极短时间内迅速长大

系统结构：
- 当前系统仍为 `NS_IceSpikes`
- 当前选中发射器为 `Empty`

当前模块：
- `Scale Sprite Size`

可见设置/参数：
- `Scale Sprite Size Mode = Uniform Curve`
- 曲线资源显示为 `Curve for Floats`
- `Uniform Curve Index = PARTICLES.NormalizedAge`
- `Uniform Curve Scale = 1.0`

曲线形态：
- 初始值接近 `0`
- 随着 `NormalizedAge` 增长稳定上升
- 后段逼近 `1.0`

左侧预览结果：
- 一排附着在冰刺链上的小蓝色细节片已经出现
- 前端较小，后段逐渐更明显，说明这层 Sprite 与主冰刺一起形成了从小到大的节奏感

结合字幕 “Grew quickly”，这一步的作用很直接：不要让这些辅助粒子一开始就以完整尺寸出现，而是让它们在生命周期内快速放大。这样冰刺表面的附加高光/装饰片会更像是跟随生长爆发出来的细节，而不是静止贴在模型上的固定纹理

### 00:13:00-00:17:49 粒子

- 本段定位：粒子。
- 知识点：就像我說的 适合的颜色 Initial 我们来做點什么 像这樣 改变它的塑膠 一点點 然后 变成5000 我们說 让它看起来更藍 看起来很好 然后 就像我說的。
- 知识点：我们需要它消失 现在 它消失了很奇怪 我们没有控制透明性 或什么的 需要控制它 用我们的解決方式 就像我說的 拿出它的曲線 然后这里 把它剪輯出来。
- 知识点：像这樣 现在让我来示範 这是它看起来的样子 我们把它剪輯出来 这就是它的技巧 因为我们剪輯下部 它的质感不太好 但我们把它剪輯出来 可以这樣做。
- 知识点：如果它不显示 那没關係 我们只看到它剪輯出来的部分 它适合的 所以 如果你想 可以剪輯自己的质感 而不是把它遮蓋出来 为什么我聽到我移动了曲線。
- 知识点：我拿出来 这里我控制曲線 因为我遮蓋下部 因为我移动了曲線 所以我设置了这个定義 也剪輯了曲線 需要它会这樣 我看到它移到旁邊 它会变成这樣。
- 知识点：让这些價值是 当它慢慢移动 我们的解決方式 会让它消失 從底到上 这里有这些曲線 它会慢慢地消失 因为解決方式 好 让我们移动 看看整体看起来。
- 知识点：对 它们很難看 为什么 因为我们需要加強鏡頭 来把它们移动 我们把它们移近鏡頭 这会是一个一定的曲線 设置它 它们会出现 一个價值 它们会慢慢地增长。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`生命周期`、`颜色`。

**关键画面：**

这张图继续调整 `Empty` 发射器的辅助 Sprite 粒子，但当前重点从尺寸/朝向转到颜色初始化。作者直接在 `Initialize Particle` 里打开颜色选择器，为这层细节粒子设置更偏蓝青的初始色

系统结构：
- 当前系统为 `NS_IceSpikes`
- 当前选中发射器为 `Empty`
- 左侧仍可见 `Spikes_Sides`

当前聚焦模块：
- `Initialize Particle`

可见设置：
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.3`
- `Color Mode = Direct Set`

当前颜色选择器可见数值：
- `R = 0.135438`
- `G = 0.537014`
- `B = 1.0`
- `A = 1.0`
- `H = 212.730859`
- `S = 0.864562`
- `V = 1.0`
- `Hex Linear = 2389FFFF`
- `Hex sRGB = 67C2FFFF`

旧/新颜色对比：
- `Old` 为接近白色
- `New` 为更明显的浅蓝青色

左侧预览结果：
- 冰刺主链已经呈现由深蓝到底部、再到亮蓝高光的层次
- 说明这层辅助粒子的颜色正在被调到与主冰刺材质更一致，而不是继续使用纯白细节

这一步的作用是让附加 Sprite 粒子不再像中性白色高光，而是带上更贴近冰效果的冷色调。这样当这些粒子叠加在冰刺表面或周围时，会更像冰晶细节本身，而不是脱离主体色相的独立光斑
这张图表明作者发现这些辅助 Sprite 看起来还不够理想，于是准备给 `Empty` 发射器再加一个与相机相关的控制模块，让粒子在镜头中更靠近相机或更适合镜头观看

系统结构：
- 当前选中发射器仍为 `Empty`
- 当前操作位置在 `Particle Spawn` 组旁边的新增模块按钮

“Add new Module” 面板中可见：
- 搜索关键字为 `camera`
- `Source Filtering` 里启用了：
  - `Niagara`
  - `Game`
  - `Library Only`

搜索结果可见模块：
- `Camera Offset`
- `Maintain in Camera Particle Scale`
- `Recreate Camera Projection`

其中 `Suggested` 区域把 `Camera Offset` 放在最上方，说明它是当前上下文下最直接匹配的模块

左侧预览结果：
- 当前只看到几片细长的浅蓝色 Sprite 细节
- 这些片状细节独立悬在视口中，确实容易因为距离或透视关系显得离主体太远

字幕明确说 “We move them closer to the camera”，结合模块搜索结果，可以推断作者接下来要做的是在 `Empty` 发射器里加入 `Camera Offset` 一类模块，通过相机方向上的偏移，把这些 Sprite 细节往镜头侧推近，减少它们在三维空间里“贴不住”或显得太薄的感觉
这张图回到 `LS_IceSpikes` 的序列镜头，用成片视角检查前面那层辅助 Sprite 粒子、相机偏移思路以及后处理 Bloom 叠加后的最终观感

场景与序列锚点：
- 当前仍为 `Pilot Actor: CameraActor`
- 序列为 `LS_IceSpikes`
- 时间轴帧率为 `60 fps`
- 当前播放头位置约在 `0.37s`

时间轴可见结构：
- `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
  - `Transform`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`
- 红色 `Life Cycle` 条带仍覆盖主要播放区间

右侧当前选中对象：
- `PostProcessVolume`

右侧 `Details` 当前仍可见后处理设置：
- `Bloom`
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 冰刺主链仍位于画面左下区域
- 最大几根冰刺保持强烈的白核和蓝色光晕
- 说明新增的辅助 Sprite 层并没有破坏主轮廓，反而与后处理 Bloom 一起把冰刺的能量感进一步放大

这一步的意义是：在把辅助粒子往相机方向调整之后，作者回到最终镜头里确认整体效果是否更自然。只有在序列视角下验证，才能判断这些 Sprite 细节是否真正贴近镜头、有没有改善“难看”“太薄”或“离主体太远”的问题

### 00:17:49-00:22:28 Spawn

- 本段定位：Spawn。
- 知识点：一樣的角度 它会增加和減少 也許 我们試試看 来編写 这个曲線 来玩 我知道 我編写了一点 需要把这些價值都剪輯给其他人 这里有一个曲線 像这个 需要把它加上。
- 知识点：而且很重要的是 可能也值得玩SpawnRate2 这里像 嗯 看看最好是怎樣 像这个 把它剪輯给其他人 看看曲線 让我把它剪輯给其他人 这里基本上。
- 知识点：都很好 我们就把它放在这里 我没有做什么奇怪的 我没有做什么 这里都很好 这里 不太好 我可能把曲線放錯了 我明白了 XYZ 我做錯了什么 基本上。
- 知识点：如果我看到有些問題 可能就 所以 不要亂来 我们都一樣 在这个 在这个 我们基本上都一樣 在構造和所有东西 所以需要把它剪輯成这樣 就这樣 我们看看同一个曲線。
- 知识点：都很好 很好 我们就 基本上这个曲線可以用 我们可能会玩玩 用分數来編写 我们就把它设置为 非常重要的东西 这是一个非常重要的物体 我们就把它设置为1000。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Spawn`。

**关键画面：**

这张图进入 `Spawn` 段后，把注意力放回主冰刺发射器 `Spikes_Center`。作者正在 `Initialize Particle` 中用非均匀网格缩放曲线控制冰刺在循环内的尺寸增长节奏

系统结构：
- 当前系统为 `NS_IceSpikes`
- 可见发射器：
  - `Spikes_Center`
  - `Spikes_Sides`
  - `Empty`

当前选中对象：
- 右侧 `Details` 标题显示为 `Spikes_Center`
- 当前预览里有 `10 Particles`

当前聚焦模块：
- `Initialize Particle`

可见基础设置：
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`

当前关键配置在 `Mesh Attributes`：
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale` 使用 `Make Vector`
- `X` 通道使用 `Float from Curve`
  - 曲线索引器为 `EMITTER.NormalizedLoopAge`
  - `Scale Curve = 55.0`
- `Y` 通道也使用 `Float from Curve`
  - 曲线索引器同样为 `EMITTER.NormalizedLoopAge`
  - `Scale Curve = 55.0`
- 右侧还可见 `Z` 分量也在继续往下配置，但当前截图里没有露出完整参数区，因此不能补写其具体值

曲线形态：
- 初始接近 `0`
- 随循环年龄持续上升
- 后段到达高值平台

输出/预览：
- 左侧预览里冰刺链从小到大沿一侧展开
- 最大几根冰刺已经明显长高，说明缩放曲线确实在驱动生成过程中的尺寸递增

这一步的作用是把主冰刺的“Spawn 时长大过程”做成一条按 `EMITTER.NormalizedLoopAge` 演进的尺寸曲线，而不是固定大小直接出现。这样在循环播放时，冰刺会呈现由小到大的生长感，更符合教程里要的推进和爆发节奏
这张图把 `Spawn` 段的核心切到 `Spikes_Sides` 发射器。作者不再调尺寸，而是在 `Emitter State` 和 `Spawn Rate` 上写循环节奏，控制侧向冰刺的生成密度和循环时长

系统结构：
- 当前系统为 `NS_IceSpikes`
- 当前选中发射器为 `Spikes_Sides`
- 左侧还可见：
  - `Spikes_Center`
  - `Empty`

右侧 `Emitter Properties` 可见：
- `Local Space` 已启用
- `Determinism` 已启用
- `Random Seed = 5`
- `Interpolated Spawning` 已启用
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Requires Persistent IDs` 未启用

`Emitter State` 中当前可见设置：
- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 0.5`
- `Loop Delay = 0.0`

`Spawn Rate` 当前配置：
- 使用 `Float from Curve`
- 曲线资源为 `Curve for Floats`
- 曲线形态表现为：
  - 初段接近 `1.0`
  - 中段下降到较低平台
  - 末段再次小幅抬升

输出/预览：
- 左侧预览中侧向冰刺已经稳定贴在主链一侧
- 时间轴当前播放头约在 `0.66s`
- 当前预览里可见 `14 Particles`

这一步的核心作用是把 `Spikes_Sides` 的生成节奏做成一个短循环：发射器只跑一次、总长 `0.5s`，并通过 `Spawn Rate` 曲线让生成速率在循环内先高后低，再在末尾略有变化。这样侧向细冰刺不会全程匀速出现，而会更像一次有起伏的爆发生长
这张图说明作者在 `Spawn` 段末尾又拆出了一层专门的 Sprite 发射器，并准备通过瞬时爆发模块把它只打在“最后一根尖刺”附近，而不是让所有位置都重复同样的生成逻辑

系统结构变化：
- 时间轴列表中除了原来的：
  - `Spikes_Center`
  - `Spikes_Sides`
- 还新增了：
  - `Spikes_Sprite`
  - `Spikes_Sprite001`

当前选中对象：
- 右侧系统图中高亮的是 `Spikes_Sprite001`

当前操作：
- 在 `Emitter Spawn` 组的新增模块按钮上打开 “Add new Module” 面板
- 搜索关键字为 `bur`

搜索结果：
- `Suggested` 区域给出 `Spawn Burst Instantaneous`
- `General -> Spawning` 下也可见同名模块 `Spawn Burst Instantaneous`

其它可见状态：
- 左侧预览窗口显示 `Compiling...`
- 说明这一步处于修改发射器结构后的重新编译阶段

结合字幕 “to our last spike. We leave everything else...” 可以确认，这层新 Sprite 发射器不是要全局铺开，而是打算针对最后一根或最后一组尖刺单独触发一个瞬时爆发。使用 `Spawn Burst Instantaneous` 的好处是：
- 只在某个时刻一次性生成
- 不需要像 `Spawn Rate` 那样持续出粒子
- 更适合做末端尖刺上的闪光、爆裂碎片或最后一下强化细节

这一步的意义是把“全程持续生成”的逻辑和“结尾瞬时爆发”的逻辑拆开。前者仍由已有发射器负责，后者则交给新的 `Spikes_Sprite001`，这样最后一根尖刺可以得到单独强化，而不会把整个效果都弄得过于密集

### 00:22:28-00:27:18 关键流程 06

- 本段定位：关键流程 06。
- 知识点：我们把安全位置提升掉 把所有东西都提升掉 这里我们就把所有的位置都设置了 大約1500 把其他东西都放掉 我们看看它会不会出现 啊 我们需要提升它。
- 知识点：这里我们需要提升它 差不多到最後 这里 它会在最後这樣出现 只要它会出现 我们把它调整到 已经设置在手動模式 所以我们把所有东西都设置了。
- 知识点：设置價值 因为它只是一个光线 它会在最後一刻出现 啊 我们把它调整到最後 我们需要更大的一次曲線 我们需要调整它 看看它现在如何 哦 從这里我们可观察到。
- 知识点：一点點後面 一点點再後面 非常好 Bang 全部完成 我们看到了 最後一个是它 它在最後的这个光线上 就在最後 哦 它们都很美丽 可以把它更大。
- 知识点：我看到它可能太小了 因为基本上OK 我们把它更大 我把它放在这里 四个半 然后在这里我可能会再调整 轉動 哦 非常好 调整價值 看看,这里你来看。
- 知识点：Bang,它变成这樣 这是我们加了光线的方式 我们可能先把这个光线 给它更好的壓力 这樣它会看起来更好 哦 它 看起来更好 轉動是更好的 因为我们把壓力的形状改变了。
- 知识点：ABC7 我覺得很棒 首先,这里有光线從光线上 它们慢慢消失 而我们3D的光线就不見了 这是光线 非常好 我们继续 这是我们的 光线爆炸 和創作。

**关键画面：**

这张图进入 `关键流程 06` 的实现细节，作者正在专门调整新加的末端爆发发射器 `Spikes_Sprite001`。这层效果已经不是持续铺开的侧向细节，而是为了最后那一下尖刺光爆而准备的独立 Sprite 层

系统结构可见：
- 当前系统为 `NS_IceSpikes`
- 可见发射器：
  - `Spikes_Center`
  - `Spikes_Sides`
  - `Spikes_Sprite`
  - `Spikes_Sprite001`
- 当前时间轴中选中的是 `Spikes_Sprite001`

`Spikes_Sprite001` 当前模块结构：
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Camera Offset`
- `Particle State`
- `Scale Sprite Size`
- `Dynamic Material Parameters`
- `Sprite Renderer`

右侧当前聚焦模块：
- `Initialize Particle`

可见设置/参数：
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.3`
- `Color Mode = Direct Set`
- `Position Mode = Simulation Position`
- `Position Offset` 已启用，其中：
  - `X = 1500.0`
  - `Y = 0.0`
  - `Z = 0.0`
- `Position Offset Coordinate Space = Simulation`
- `Mass Mode = Unset / (Mass of 1)`

`Sprite Attributes` 中可见：
- `Sprite Size Mode = Non-Uniform`
- `Sprite Size` 使用 `Multiply Vector 2D`
- 其中一条 `Float from Curve` 使用：
  - `CurveIndex = EMITTER.NormalizedLoopAge`
  - `Scale Curve = 2000.0`
- 另一分量可见值为：
  - `0.75`
  - `3.5`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

输出/预览：
- 左侧预览中，主冰刺链仍然稳定存在
- 字幕明确提到 “Around 1500. Leave everything else as it is.”

这一步的意义是把末端爆发 Sprite 明确推到系统路径更后方的位置，并让它的尺寸按循环年龄快速增长。`Position Offset.X = 1500` 基本就是在把这个末端闪片送到最后一根尖刺附近，而不是留在主链前半段；这样当瞬时爆发发生时，视觉焦点会更自然地落在冰刺尾端
这张图回到 `LS_IceSpikes` 的序列镜头，用成片视角验证 `Spikes_Sprite001` 这层末端爆发 Sprite 是否真的增强了最后一根尖刺的亮度和视觉重心

场景与序列锚点：
- 当前仍为 `Pilot Actor: CameraActor`
- 序列仍为 `LS_IceSpikes`
- 时间轴帧率为 `60 fps`
- 当前播放头位置约为 `0.62s`

时间轴结构可见：
- `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
  - `Transform`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`
- 红色 `Life Cycle` 条带仍覆盖主要播放区间

右侧当前选中对象：
- `PostProcessVolume`

右侧 `Details` 当前可见设置：
- `Bloom`
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 冰刺链前段保持较低、较细的冰刺
- 尾端两根最大冰刺明显比前段更亮、更大
- 最后尖端区域的蓝白辉光被显著放大，形成非常明确的“结尾爆点”

这张图说明：把 `Spikes_Sprite001` 独立出来并推到末端之后，序列视角中的最终大尖刺已经不只是主网格本身在发光，而是叠加了一层专门的末端强化效果。这样最后一下 “Bang” 更集中，视觉上也更容易读成爆发终点，而不是整条链平均发亮
这张图显示 `关键流程 06` 又向前推进了一步：作者把末端强化不再只做成一层，而是拆成了两个独立的 Sprite 发射器，一个负责爆发，一个负责辉光

系统结构变化：
- 当前时间轴列表里可见：
  - `Spikes_Center`
  - `Spikes_Sides`
  - `Spikes_Sprite`
  - `Spikes_Sprite_Burst`
  - `Spikes_SpriteGlow`

中间 `System Overview` 当前可见两个新发射器：
- `Spikes_Sprite_Burst`
- `Spikes_SpriteGlow`

当前选中对象：
- 右侧 `Details` 标题为 `Spikes_SpriteGlow`

右侧 `Emitter Properties` 可见：
- `Local Space` 已启用
- `Determinism` 已启用
- `Random Seed = 0`
- `Interpolated Spawning` 已启用
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Requires Persistent IDs` 未启用

`Emitter State` 中当前可见设置：
- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 0.5`
- `Loop Delay = 0.0`

`Spawn Rate` 当前可见数值：
- `SpawnRate = 25.0`
- `Spawn Probability = 1.0`

`Initialize Particle` 当前可见部分：
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.25`

左侧预览结果：
- 冰刺尾端仍保持更强的白蓝高亮
- 字幕里明确提到 `sprite` 与 “how it looks”，说明作者正在比较这层新辉光 Sprite 的观感

这一步的核心含义是：末端特效被拆成两种职责
- `Spikes_Sprite_Burst` 负责更瞬时、更尖锐的爆发感
- `Spikes_SpriteGlow` 负责更稳定的发光包裹和余辉

这样作者就可以单独控制“最后一击的光爆”和“其后的光晕残留”，而不必用同一个发射器同时兼顾两种节奏

### 00:27:18-00:32:13 关键流程 07

- 本段定位：关键流程 07。
- 知识点：这是光线的样子 我只想它们要降低光线 我们来重新设置 只有 我们来看看它们的样子 像这樣 它不見了 它加了一点光线 我基本上重新设置了这些價值。
- 知识点：可能现在需要把它们的價值升高 哦 我把它升高了 像这樣 加了一点深度 效果 这是一个更多的細節 我把它關掉 当然,我们光线会跟着 这些都是更多的細節。
- 知识点：可以做更多的嗎 例如,可以把光线的重量 把同一个光线 它不会光得太多 所以我们不要把它升高 是的,我们把它升高 它太多了 也許它也太多了。
- 知识点：我们把它升高 它升高到5 它只是有一点點 它加了一些細節在邊緣 大概55 所以这都是你的決定 我们把它弄得不太顯眼 像这樣 可以改变它的质感。
- 知识点：这不是問題 再加一个光线 可以用 像这樣 可能会很不錯 好的 我明白这里有一个特定的功能 我们需要调整它的廣度 我们来做 像这樣 我把重量和價值适当改变了。

**关键画面：**

这张图进入 `关键流程 07`，作者开始微调末端辉光发射器 `Spikes_SpriteGlo/Glow` 的渲染方式，不再只是看整体亮度，而是直接检查这层 Sprite 发光片本身的材质与朝向

场景与序列锚点：
- 当前仍在 `LS_IceSpikes` 序列视图
- 时间轴帧率为 `60 fps`
- 当前播放头位置约为 `0.18s`
- `NS_IceSpikes -> NiagaraComponent0 -> System Life Cycle` 轨道仍在时间轴中可见

右侧外层当前选中对象：
- `PostProcessVolume`
- `Bloom` 仍保持：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

前景弹出的 Niagara 窗口中：
- 当前选中发射器为 `Spikes_SpriteGlo`
- 可见 `Spikes_Sprite_Burst` 发射器位于左侧
- 当前聚焦模块是 `Sprite Renderer`

`Sprite Renderer` 当前可见设置：
- `Material` 已设置为一张发光类材质实例，名称显示为 `MI_Spi...`
- 第二个材质槽为 `None`
- `Source Mode = Particles`
- `Alignment = Custom Alignment`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`

输出/预览：
- 弹出窗口左侧预览中只看到一片很小的蓝白发光片
- 主视口中序列画面里末端辉光很弱，只剩几道细小的亮片，说明作者此时正在有意压低这层 Glow，让它只补一点边缘光而不是抢走主爆发层的注意力

这一步的意义是把 `Spikes_SpriteGlow` 定位成“补一点深度和边缘光”的层，而不是再次做一个大爆闪。通过单独调它的 `Sprite Renderer` 材质和对齐方式，作者可以控制这层光片既跟随镜头看起来正确，又不会把尾端亮度堆得过头
这张图继续微调 `Spikes_SpriteGlow`，但关注点已经从材质有没有挂上，转到这层 Sprite 在镜头里为什么“看起来很奇怪”，以及如何通过 pivot、排序和渲染细节去修正它

场景与序列锚点：
- 当前仍在 `LS_IceSpikes` 的 Sequencer 视图
- 时间轴帧率为 `60 fps`
- 当前播放头约在 `0.32s`
- 主视口中尾端冰刺已经非常明亮，Glow 层正叠加在最后几根尖刺周围

前景弹出的 Niagara 窗口中：
- 当前选中发射器仍为 `Spikes_SpriteGlow`
- 当前聚焦模块仍是 `Sprite Renderer`

`Sprite Renderer` 当前可见设置：
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Custom Alignment`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space` 当前可见值约为：
  - `X = 0.527762`
  - `Y = 0.6`
- `Remove HMD Roll` 未启用
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`

`Sorting / Visibility / Rendering` 中可见：
- `Sort Mode = None`
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 1000`

右侧外层 `PostProcessVolume` 里仍可见：
- `Bloom Intensity = 15.0`
- `Threshold = -1.0`

输出/预览：
- 弹窗左侧预览里，辉光层贴在冰刺尾端上
- 主视口中尾端蓝白高亮非常强，字幕明确说这里“看起来相当奇怪”

这一步说明作者正在处理 Glow Sprite 的成像位置问题。当前 `Default Pivot in UV Space` 已经不再是居中的 `(0.5, 0.5)`，而是向上略偏，这说明他在尝试把发光片的重心从中心挪开，让它更贴近尖刺轮廓，而不是像一张正中铺开的卡片那样显得别扭
这张图表明 `关键流程 07` 继续把尾端 Glow 细化拆分。作者又单独拿出一个 `Spikes_SpriteGlow001` 发射器，并直接用 `Spawn Burst Instantaneous` 让它只在某个时刻打一小下，而不是持续存在

系统结构变化：
- 前景 Niagara 窗口中当前选中发射器为 `Spikes_SpriteGlow001`
- 中间系统图里可见名称为 `Spikes_SpriteGlow00...` 的 Glow 类发射器
- 该发射器结构仍包含：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Sprite Facing and Alignment`
  - `Camera Offset`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sprite Renderer`

当前聚焦模块：
- `Spawn Burst Instantaneous`

可见设置/参数：
- `Spawn Count = 1`
- `Spawn Time = 0.0`
- `Spawn Probability = 1.0`
- `Loop Count Limit = 1`

序列与时间锚点：
- 外层仍是 `LS_IceSpikes` 的 Sequencer 视图
- 帧率为 `60 fps`
- 当前播放头位置约在 `0.14s`

输出/预览：
- 弹窗左侧预览里此刻几乎没有可见结果
- 这与当前 `Spawn Time = 0.0` 和单次爆发逻辑一致，说明它更像是一个瞬时触发的补光片，而不是一直悬在冰刺上的 Glow 层

这一步的意义是把辉光也拆成了“持续层”和“瞬时层”。前者负责常驻的边缘发光，后者只在特定时刻 burst 一次，给镜头里某个瞬间再补一击亮点。这样既能保留整体发光轮廓，又能避免所有 Glow 都同时常亮而显得平淡或过曝

### 00:32:13-00:36:54 PS、速度

- 本段定位：PS、速度。
- 知识点：我们来继续 如果有什么問題 需要再檢查和修理 基本上它正在出现 需要它像雪一樣 有些小雕塑在飛 出来 我们来做这个 需要加一顆发射器。
- 知识点：我们来制作一种材料 它会像光 需要拿走它 它会是 一个添加光 是的 需要把数量 让它的质感更亮 像这樣 好 我们把它儲存 把它轉移到这里 它会很快地出现。
- 知识点：需要更快 比普通的爆炸更快 爆炸会在一半秒 这东西会在这一个詞語上出现 有了爆炸 需要把它修理 我们也需要系统位置 它们有了大爆炸 只是为示範。
- 知识点：来示範我们有的 它们来了 这里 爆炸 我们要確保它们会很順利 需要加一个形状位置 約200 它们会像这樣出现 它们也会很快地消失 它们的生命会很短。
- 知识点：可能更快 我不知道 我们說好 需要設置一些蓋子 像这樣 我们来做 不太大 5-10 好 这里的东西都很棒 我们需要给它们一点速度。
- 知识点：它们现在正在出现 但没有發生 它们来了 就这樣 它们需要飛上去 想像这里的雪花在出现 我们的爆炸会在上升 它们会像很快的雪花一樣 是的 好 我们需要给它们一点速度。
- 知识点：我们需要 在这一个詞語上加速 需要设置一个形状位置 在这里加速 主要是 因为有些是小的 有些是大的 需要控制速度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`发射器`、`系统`、`生命周期`、`速度`。

**关键画面：**

这张图是 `PS、速度` 段的视觉目标说明画面。作者已经不满足于当前只有尾端光爆和大尖刺的效果，开始明确提出希望再加一层像雪花或小碎片一样的飞散细节

场景与序列锚点：
- 当前仍为 `LS_IceSpikes` 的 Sequencer 视图
- 帧率为 `60 fps`
- 当前播放头位置约在 `0.57s`

时间轴结构可见：
- `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
  - `Transform`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`

右侧当前选中对象：
- `PostProcessVolume`
- `Bloom` 仍保持：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 镜头非常靠近冰刺尾端
- 亮度和辉光已经很强，最后一根大尖刺几乎占满画面上部
- 但前景中还没有明显看见大量独立飞散的小粒子

字幕明确说 “I would like it to look like snow. Some small...”，这说明当前画面仍偏向“光爆 + 冰刺主体”，而缺少更像雪片、碎冰或轻质飞散物的次级运动层

这一步的作用是给后续新发射器或粒子层设定视觉目标：不是再加更大的光，而是补一层更细小、更快、更像雪花一样被抛出的粒子，从而让尾端爆发的读感更丰富
这张图展示了 `PS、速度` 段中间的阶段性结果：尾端不再只有一整团强光和大尖刺，而是已经开始从尖刺末端抛出细小的亮点碎片，视觉方向正向“雪花式飞散”靠近

场景与序列锚点：
- 当前仍为 `LS_IceSpikes` 的 Sequencer 视图
- 帧率为 `60 fps`
- 当前播放头位置约在 `0.33s`

时间轴结构仍可见：
- `Camera Cuts`
- `CameraActor`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`

右侧细节面板锚点：
- 当前仍选中 `PostProcessVolume`
- `Bloom` 设置保持不变：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 冰刺尾端主体相比前一张更收敛一些，不再只有一根占满画面的巨大亮刺
- 尾端右侧已经能看到零散的小亮点和小碎片，说明新的次级粒子已经开始出现
- 这些细粒子读起来更像被爆发抛出的雪粒或碎冰，而不是单纯的辉光贴图

资源变化锚点：
- 顶部资源标签里出现了 `MI_GlowAdd_01`
- 这至少说明作者在同步准备或调试一份偏 `Additive / Glow` 方向的材质资源，用来支撑这些更亮、更轻的小粒子表现

字幕 “appearing. Our spikes are throwing something” 对应的正是当前这个变化：尖刺已经不是静止地发光，而是在尾端持续抛出小型飞散物。换句话说，这一步的重点是让爆发尾流具备“喷射出细碎雪点”的动势，而不是只提升整体亮度
这张图给出了作者为“雪花式飞散碎片”单独搭建的新发射器结构，重点不是大冰刺主体，而是一个额外的 `Sprite` 粒子层，用来在爆发后快速抛出许多短寿命的小亮片

系统与视图锚点：
- 当前打开的是 `NS_IceSpikes`
- 视图位于 `System Overview`
- 时间轴帧率为 `60 fps`
- 当前播放头约在 `0.48s`
- 预览窗口里能看到左侧主冰刺，以及围绕尾端飞出的细小白色亮片

系统内可见的两个发射器：
- 左侧发射器：`Spikes_SpriteGlow00`
  - 这是已存在的冰刺发光层
  - 可见模块包括：
    - `Emitter State`
    - `Spawn Burst Instantaneous`
    - `Initialize Particle`
    - `Sprite Facing and Alignment`
    - `Camera Offset`
    - `Particle State`
    - `Scale Sprite Size`
    - `Scale Color`
    - `Sprite Renderer`
- 右侧发射器：`Empty`
  - 这是当前新加出来、专门负责小碎片/雪点的发射器
  - 可见模块顺序为：
    - `Emitter State`
    - `Spawn Rate`
    - `Initialize Particle`
    - `System Location`
    - `Shape Location`
    - `Add Velocity`
    - `Drag`
    - `Solve Forces and Velocity`
    - `Particle State`
    - `Scale Sprite Size`
    - `Sprite Renderer`

这个新发射器反映的搭建逻辑：
- `Spawn Rate`：持续生成小粒子，而不是只做一次性的巨大爆点
- `Initialize Particle`：为这些小粒子设置基础寿命、尺寸和初始外观
- `System Location`：让新粒子跟随当前 Niagara 系统的位置生成
- `Shape Location`：在一个体积范围内把粒子散开，避免所有雪点从同一条线挤出来
- `Add Velocity`：给这些粒子一个明确的初速度，使它们看起来像被尖刺爆发带出来
- `Drag` + `Solve Forces and Velocity`：让飞出的碎片在短时间内减速，形成更轻、更自然的雪花运动
- `Scale Sprite Size`：再用曲线控制粒子在生命周期中的尺寸变化，避免所有点从头到尾一样大

右侧当前展开的是 `Scale Sprite Size`，能确认的参数锚点有：
- `Scale Sprite Size Mode = Uniform Curve`
- 使用的是 `Curve for Floats`
- `Key Data` 读取 `PARTICLES.NormalizedAge`
- `Uniform Curve Scale = 1.0`

这些参数说明当前这一步正在做“尺寸控制”：让雪点类粒子随着生命周期推进而变化，而不是固定大小不动。字幕里也明确说的是 “some size control. So let's do it.”，因此这张图的核心不是速度本身，而是在已有位置与速度基础上，继续把小粒子的尺寸节奏调顺，使它们更像短寿命、快速掠过的雪花碎片

### 00:36:54-00:41:36 速度、透明度

- 本段定位：速度、透明度。
- 知识点：有些彎曲的部分 也許颜色会慢慢地变色 更加確切的是透明度 然后 基本上 目标是它们能控制它的重量 所以 在开始时它们有少許 在最後它们有更多。
- 知识点：我们设置一个彎曲 设置它们的大小 让它们像这樣 在这里 然后 最後它们会很快地 变成同一條 也会适当调整它们的彎曲 然后我们需要多少 5,000。
- 知识点：太多了 500 这里我们看到 我们把它做成这樣 所以可观察到 在开始时 它们有少許 它们有少許 它的速度不太好。
- 知识点：在时间內 它们有更多 然后它们的速度增加 然后 我们需要设置地點 因为它们在那邊 这里是地點 来做好所有的调整 我们来看結果 它们在这个角度上飛。
- 知识点：也許会调整角度 它们太大了 好 像这樣 很棒 可观察到它们的頭 但基本上还好 这里 你不会看到太多的動作 需要 可以加一个 随机转换 然后 我真的喜欢这个。
- 知识点：很多的選項 可能我们应该 增加它们的彎曲 所以它们 飛出像这樣 在最後 我们看到它们在升起 我覺得可以 在最後还可以让它们升起 像是增加这个彎曲。
- 知识点：到3 然后在最後 它们升得很高 整体来說很酷 甚至是系统位置 雖然 让它是这樣的 好 接下来需要加什么 在它们的彎曲上 因为它们是彎曲 它们会在这里。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`系统`、`速度`、`颜色`、`透明度`。

**关键画面：**

这张图展示的是 `速度、透明度` 段开头的系统结构状态。作者继续沿用前一段新加出来的 `Empty` 小碎片发射器，但现在的调节重点已经从尺寸控制转向颜色与透明度衰减，用来让飞散雪点更轻、更薄，不会一直保持同样的发光强度

系统与视图锚点：
- 当前打开的是 `NS_IceSpikes`
- 视图位于 `System Overview`
- 时间轴帧率为 `60 fps`
- 当前播放头约在 `0.48s`
- 左侧预览里仍能看到冰刺主体和少量从尾端飞出的细小白色雪点

系统内可见发射器结构：
- 左侧 `Spikes_SpriteGlow00`
  - 仍是原有的大冰刺发光层
  - 可见更新模块包括 `Particle State`、`Scale Sprite Size`、`Scale Color`
- 右侧 `Empty`
  - 仍是负责细小雪点/碎片的附加发射器
  - 当前可见模块顺序为：
    - `Emitter State`
    - `Spawn Rate`
    - `Initialize Particle`
    - `System Location`
    - `Shape Location`
    - `Add Velocity`
    - `Drag`
    - `Solve Forces and Velocity`
    - `Particle State`
    - `Scale Sprite Size`
    - `Scale Color`
    - `Sprite Renderer`

当前右侧详情面板选中的是 `Scale Color`，可确认的参数锚点有：
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = 1.0, 1.0, 1.0`
- `Scale Alpha = 1.0`

这说明作者已经把颜色和透明度控制插入到小碎片发射器里，并且准备分别控制亮度与 Alpha，而不是把所有变化都压在尺寸上。结合本段标题 `速度、透明度` 和相邻正文“颜色会慢慢地变色，更加确切的是透明度”，这一步的作用是让这些雪点在生命周期中逐渐变淡，避免它们像硬质白点一样一直悬在画面里
这张图是 `速度、透明度` 段中的结果检查画面，用来观察新加的雪点/碎片粒子在调完速度、透明度和弯曲后，是否能从爆发尾端持续抬升，并形成更高、更轻的尾流层

场景与序列锚点：
- 当前回到 `LS_IceSpikes` 的 Sequencer 预览视图
- 帧率为 `60 fps`
- 当前播放头位置约在 `0.58s`

时间轴与场景锚点：
- 时间轴中仍能看到 `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`

右侧面板锚点：
- 当前选中对象是 `PostProcessVolume`
- `Bloom` 保持：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 镜头贴近冰刺爆发尾端，主体大冰刺依旧占据画面中央
- 在强烈 Bloom 之上，尾端已经不只是单纯的白色爆点，而是出现了向上扬起的细碎亮屑层
- 这些细碎粒子的运动方向明显比前一段更高、更往上抬，读感接近被爆发气流带起的雪花或碎冰雾

字幕里明确说的是 “they rise really really high. Overall”，对应的正是当前这个检查重点：作者在验证这些小粒子是否已经能明显上升，而不是只在尾端附近短距离散开。因此这一步的目标是把次级粒子的整体运动趋势调整为“向上卷起并拉高”，让爆发后沿更有层次，而不是只停留在一团贴地的发光碎片
这张图切到了 Blender 建模界面，说明这一段除了在 Niagara 里调速度与透明度外，也在同步整理雪点/碎片所用的基础网格形体。当前画面不是材质或节点图，而是直接在编辑模式下修改一个简单圆柱体的顶部和底部轮廓

界面与对象锚点：
- 软件为 `Blender`
- 当前处于 `Edit Mode`
- 当前对象名为 `Cylinder`
- 右上角 `Scene Collection` 中只显示一个 `Cylinder`
- 右侧 `Transform` 面板里位置、旋转均为默认值，缩放为：
  - `Scale X = 1.000`
  - `Scale Y = 1.000`
  - `Scale Z = 1.000`

当前几何状态：
- 这是一个低面数圆柱体
- 视图中能看到圆柱顶部边环和底部收拢的面
- 底部中心点被选中，顶部一圈顶点也处于编辑状态
- 左下角操作提示显示当前正在执行 `Resize`
  - `Scale X = 0.000`
  - `Scale Y = 0.000`
  - `Scale Z = 0.000`
  - `Orientation = Global`

这说明作者正在把选中的顶部或底部顶点环向中心缩放，目的是把原本普通的圆柱体改成更尖、更收束的形体。字幕里也提到 “And the top. I adjust it too.”，因此这一步的重点是同时整理尖端和顶部轮廓，让这个基础网格更接近冰刺、碎片或雪点拉伸后的体块形状，便于后续作为粒子或特定网格元素使用

### 00:41:36-00:46:25 关键流程 10

- 本段定位：关键流程 10。
- 知识点：并且我再加一个切片 在中间我加了一塊 我把它延长了一点 现在我们来做一些 操作 我们說 我本来想 可能要減少这兩塊 或者縮小 整体上 所以我们把它縮小。
- 知识点：像这樣 不,我们不想 OK 縮小上面的部分 可能加幾塊 幾塊 幾塊 幾塊 我覺得这塊石頭的目的 可能太多了 一塊,一塊 就这樣 我把这个东西 把它剪輯一下。
- 知识点：给它某个石頭的形状 切掉 所以我们 拿一塊石頭 然后把它切成这樣 我们把它切掉 我们再加一塊 哦,而且首先 切掉的时候 我们要檢查它的位置 这很重要。
- 知识点：因为我们调整了整个工具 所以它们可能会 适当改变 它们的位置 好,我们把文化放進去 来檢查它们的样子 把它放進去 回到剪輯模式 哦,看 基本上。
- 知识点：基本上,不差 我看到这塊石頭 延伸了很多 所以我们看到 这就是它 我们需要什么 我们把这个 我们把它切掉 我们把这个部分 切掉 把它调整成这樣 这里。
- 知识点：下面的部分也 需要调整 所以,基本上 你只需要 做成同樣的调整 其實,它不会很显示 我看到这里有些地方延伸 我应该有一点點 好,好 我们的石頭。
- 知识点：它会这樣 它的大小 很難看 全部 所以 我们快點把它做好 我们怎麼做 我们用刀来选择 现在我们要切 切掉这个,这个,这个 这里 像这樣 可能会很奇怪。

**关键画面：**

这张图切回 Unreal Engine 的静态网格查看器，用来检查刚才在 Blender 里整理过的碎片模型是否已经导入，并确认底部轮廓是否还需要继续缩小或修形

资源与界面锚点：
- 当前打开的资源标签是 `SM_IcePiece_01`
- 视图处于静态网格编辑器而不是 Niagara System
- 视口里是该网格的超近景，镜头贴到模型底部
- 右侧 `Details` 面板当前停在静态网格设置上

当前可见网格特征：
- 这是一个低面数碎片/石块形体
- 画面中心能看到明显的多边形切面，不是平滑球体
- 底部被收拢成一个较尖但仍偏圆钝的末端
- 轮廓还带有若干不规则折面，说明作者正在观察它是否已经足够像冰碎块，而不是标准几何体

界面中可确认的网格信息：
- `LOD 0`
- `Triangles: 234`
- `Vertices: 147`
- `UV Channels: 2`
- `Approx Size: 196x216x262`

右侧还能确认：
- `Material Slots = 1`
- 当前材质槽使用的是 `WorldGridMaterial`

结合本段正文“想先把两个部分或者整体缩小”“缩小上面的部分”，这张图的作用是对导入后的碎片模型做近距离外形复核，尤其看底部和整体收束是否合适。如果底部还显得太鼓、太圆，后续就要继续回 Blender 或继续修这块形体，让它更接近不规则冰石而不是通用圆柱变体
这张图回到 Blender，并且已经进入 `UV Editing` 工作区。作者此时不只是修外轮廓，而是在检查这块碎片模型的 UV 展开和贴图分布，确保后续贴上冰面或噪声纹理时不会出现明显拉伸

界面锚点：
- 软件为 `Blender`
- 当前工作区是 `UV Editing`
- 当前对象名为 `Cylinder`
- 当前处于 `Edit Mode`

左侧 UV 视图：
- 打开了一张检查纹理 `checker.png`
- UV 岛被展开成规则的矩形条带
- 每一列基本对应模型侧面的一圈面
- 最底部一整条边环被选中并高亮为橙色
- 格子中的彩色十字分布较均匀，说明作者正利用检查纹理观察是否有明显拉伸或扭曲

右侧 3D 视图：
- 模型底部朝向镜头
- 侧面已经贴上 `checker.png` 检查纹理
- 能看到底面从中心向外放射的三角面分布
- 侧面多边形上彩色十字大小整体接近，说明当前侧面 UV 密度比较一致

右侧材质面板可确认：
- 材质名为 `Material`
- 使用 `Use Nodes`
- `Surface = Principled BSDF`
- `Base Color` 当前接入 `checker.png`

这一步的作用是检查“石块/冰块碎片”在完成几何修形后，贴图是否仍然合理。若彩色格子在某些面上被明显拉长、压扁或旋转异常，就需要继续调整 UV 或局部拓扑。当前画面说明作者至少已经把这块碎片放进检查纹理流程里，开始核对侧面与底部的映射质量
这张图是 `关键流程 10` 段末尾的 Blender 结果检查画面。作者已经把碎片模型整体缩小并压成更扁、更收束的不规则石片形状，用来结束这一轮基础冰块/碎片网格的修形

界面锚点：
- 软件为 `Blender`
- 当前对象名为 `Cylinder`
- 当前处于 `Edit Mode`
- 模型表面仍挂着检查纹理，因此能继续观察各个面的缩放是否一致

当前几何结果：
- 模型已经不再接近原始圆柱，而是变成一块扁平的不规则碎片
- 整体高度被明显压低，左右宽度相对保留
- 上沿和下沿都被收成折线式轮廓，不再是完整圆环
- 侧面存在多处不均匀凸起和凹陷，读感更接近天然破碎石块或冰块
- 贴图格子在主要可见面上仍能辨认，没有因为整体缩放而完全挤成极端细条

从字幕 “shrink it. Something like that.” 可以直接对应出这一步的目标：不是继续增加新切面，而是把当前形体缩到一个更合适的体量，并快速确定一个可用的碎片基础款。也就是说，这张图表达的是“先收敛出一块可接受的石块/冰块网格”，后续若要做更多变体，可以再在这块基础上继续切削或复制派生

### 00:46:25-00:47:11 关键流程 11

- 本段定位：关键流程 11。
- 知识点：像这樣 我们就变成了 一塊小石頭 让我把它拆掉 需要保留它 需要用兩个不同的方式 全部都很简单 我们就把它拿起来 然后把它拆掉 拆掉所有东西。
- 知识点：把它输入游戏機 这拆掉了 我们剛才创建了 兩种不同的石頭 或者在我们的情况下 可能是石頭或是 石頭 这就是它 这段影片就要結束了 謝謝觀看 我们下次見 再見。

**关键画面：**

这张图是 `关键流程 11` 段开头的 Blender 收尾画面。作者已经把第一块碎片模型定下来，并准备把它保留下来，作为后续做两个变体时的基础款之一

界面锚点：
- 软件为 `Blender`
- 当前对象名为 `Cylinder`
- 当前对象处于选中状态，轮廓线为橙色
- 模型表面仍挂着检查纹理，方便继续观察体型和 UV 是否可接受

当前模型状态：
- 这是一块细长、略带收腰的不规则碎片
- 顶部被压成较平的多边形面，不是尖顶
- 底部向下略收，整体读感像一块可用于冰刺爆发碎屑的低模石片
- 检查纹理在主体侧面分布较均匀，没有出现极端拉伸到不可用的情况

当前操作锚点：
- 左上角打开了 `File -> Import` 菜单
- 展开的导入格式列表里能看到 `FBX (.fbx)`、`glTF 2.0`、`Wavefront (.obj)` 等选项

结合字幕 “save it too. We'll keep it. We'll use two variations.”，这张图表达的重点不是继续修模，而是确认第一块碎片已经达到可保存、可复用的状态。接下来会基于它再做另一种形体变化，让 Niagara 或场景里不要只有单一一种碎片轮廓
这张图回到 Unreal Engine 的主编辑器，说明刚才在 Blender 里保留下来的碎片模型已经重新进入 UE 资源库，并且作者正在确认“导入的这一块”和“第二种变体”都已经具备可用资源形态

场景与界面锚点：
- 当前仍在 `LS_IceSpikes` 场景视图中
- 视口里能看到完整的冰刺效果，从左到右逐渐长出多根尖刺
- 右侧当前选中的是 `PostProcessVolume`
- `Bloom` 仍保持：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

底部 `Content Browser` 当前定位：
- 路径为 `Content > VFX_Library > Meshes`
- 资源列表中能看到多种基础网格
- 与本段最相关的是：
  - `SM_IcePiece_01`
  - `SM_IcePiece_02`

这个资源列表直接对应本段字幕 “This imported one and the second variation”，说明作者已经不再停留在 Blender 单体建模阶段，而是把两种碎片形体都放回 UE 的 `Meshes` 目录，作为 Niagara 冰刺效果可以调用的两套静态网格变体

这一步的实际意义是提高碎片层的形状多样性：之后无论是手工摆放还是作为粒子网格发射，系统都不必重复使用同一块碎片，从而减少视觉重复感
这张图打开了第二个碎片变体 `SM_IcePiece_02` 的静态网格查看器，用来确认第二种形体已经成功导入，并且与第一块碎片形成可区分的备用轮廓

资源与界面锚点：
- 当前资源标签为 `SM_IcePiece_02`
- 视图处于 Unreal Engine 的静态网格编辑器
- 右侧 `Details` 面板当前显示的是该静态网格的属性

当前网格形体特征：
- 整体仍是低模碎片/石块风格
- 轮廓比前一个变体更厚、更鼓，顶部不是平切面，而是更圆钝地向上收拢
- 底部仍然收成尖角，但侧面鼓起更明显，因此整体更像块状碎石，而不是细长石片
- 这说明它确实不是 `SM_IcePiece_01` 的完全重复，而是另一种体块比例的变体

界面中可确认的网格信息：
- `LOD 0`
- `Triangles: 612`
- `Vertices: 443`
- `UV Channels: 2`
- `Approx Size: 117x111x164`

右侧还能确认：
- `Material Slots = 1`
- 当前材质槽使用的是 `WorldGridMaterial`

这张图对应了本段最后的交付状态：两种碎片网格都已经落回 UE，其中 `SM_IcePiece_02` 作为第二种轮廓，补足了第一块碎片过于单一的问题。这样在后续冰刺、碎屑或网格粒子效果里，就可以混用两种不同外形，提高随机感和真实度

## 补充视觉证据

### S02 00:04:56

这张补充图虽然标题标成 `parameter`，但画面本身展示的是 `LS_IceSpikes` 在 Sequencer 中的整体效果回看，用来补充说明前文早期阶段的冰刺生成结果，而不是某个具体参数面板的近景

场景与序列锚点：
- 当前处于 `LS_IceSpikes` 的 Sequencer 视图
- 视口左上角显示正在 `Pilot Actor: CameraActor`
- 帧率为 `60 fps`
- 当前播放头位置约在 `0.78s`

时间轴结构可见：
- `Camera Cuts`
- `CameraActor`
  - `CameraComponent`
  - `Field Of View = 90.0`
- `NS_IceSpikes`
  - `NiagaraComponent0`
  - `System Life Cycle`

右侧面板锚点：
- 当前选中对象是 `PostProcessVolume`
- `Bloom` 保持：
  - `Method = Convolution`
  - `Intensity = 15.0`
  - `Threshold = -1.0`

视口结果：
- 整体冰刺从左下向右上展开，形成一条逐渐抬升的斜向冰脊
- 最右侧主尖刺最长、最亮，前面依次跟着多根较短的次级尖刺
- 冰刺主体已经具备明显的分层体块，不再只是简单的单尖刺或平面发光片
- 外缘被强烈蓝色 Bloom 包裹，说明此时视觉重点是整体轮廓和能量感，而不是单个碎片细节

这张补充图的价值在于给前文参数和模块调整提供一个整体结果锚点：读者可以直接看到，前期的系统搭建最终需要落到这种“主尖刺领头、后方多根次级冰刺递进跟随”的构图效果上。它更像一张阶段成果图，而不是参数逐项说明图

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


# 04 Water Wisp

# 04 Water Wisp

## 关键术语

- `Spawn`、`Alpha`、`Water`、`粒子`、`速度`、`火焰`、`+Add`、`Niagara`、`Add`、`系统`、`生命周期`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Initialize Particle`、`Lifetime`

## 分段知识

### 00:00:05-00:02:41 关键流程 01

- 本段定位：关键流程 01。
- 知识点：歡迎收看,这次的影片,需要用水的元素来设计一塊穴 是的,我们来分析一下,我们该用的水是什么样子 应该是水流,对吧? 首先,我们需要一些下降,也要一些泡沫。
- 知识点：当然,这会比光线更慢,也就是 会很慢,会流動,泡沫会有不太柔軟的形状 通常,这种藍色的颜色,如果是风格,就能选择这种藍色的颜色,对吧?。
- 知识点：我们来开始吧,基本上 我只想要的就是,这里我看到了光线,对吧? 就是,我们快點开始吧,我不喜欢这个尺寸 大小? 他有一点,首先,很大,是120,140。
- 知识点：可能还是一樣的 要正確? 是的,基本上,他很有表现 所有东西,是的,都快速和简单地發送了 是的,我覺得会更好,是的,他們追趕了,我们开始。
- 知识点：我们把我们的火力發送成一个基礎,把它拼上去 然后我们把它叫做Whisp Yocht 是的,我们开始吧,Nigaro 有了 好,所有东西都準備好了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是新章节 `04 Water Wisp` 的起始场景，用来说明作者准备从已有的两套精灵球效果出发，继续做一个水元素版本。场景中央摆放了两个 Niagara Actor：

- 左侧是橙红色的 `NS_Wisp_Fire`
- 右侧是蓝色的 `NS_Wisp_Lightning`

当前选中的对象是 `NS_Wisp_Fire`。从右侧 `Details` 面板可以直接确认：

- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prerqs`
- `Allow Scalability = 开启`

下方 `Transform` 区域还能看到该实例当前的摆放值：

- `Location = (-140.0, 350.0, 200.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

结合本段正文，这一步的作用不是修改参数，而是先对照现有火焰版和闪电版的视觉基底，确定水系版本需要的主要特征：主体要更慢、更流动，并额外包含水滴和泡沫感。
这张图继续停留在章节开场的对比场景，但这次把资源浏览位置展示得更明确。下方 `Content Browser` 已经进入 `Content / VFX_Library / Niagara / Wisps`，其中可以直接看到两个系统资源：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`

画面中这两个资源同时作为场景里的参照物存在：左侧是火焰版球体，右侧是闪电版球体。当前世界大纲里仍然选中的是 `NS_Wisp_Fire` Actor，而资源浏览器中高亮的是 `NS_Wisp_Lightning` 资源，这说明作者正在以“保留一套已有结构、快速派生新版本”的方式准备进入水元素改造流程。

结合正文“快速简单地发送了”“把火力效果作为基础”的语义，这一帧的可复建信息是：先保留已有的两个 `Wisp` 系统资源作为对照样本，再在同一资源目录下开始制作新的 `Water Wisp` 版本，而不是从空白 Niagara System 重新搭建。
这张图把起始资源进一步收束到材质层。下方 `Content Browser` 已切换到 `Content / VFX_Library / Materials / MM`，当前可直接辨认出：

- 一个父材质 `M_UberMaterial`
- 一个基于它派生的材质实例（名称在当前截图里不够清晰，无法可靠辨认）

字幕同时说明“取一个实例材质，这是 glow”，因此这一步的明确操作意图是：不重新新建父材质，而是直接挑选现成的 `M_UberMaterial` 材质实例，作为后续 `Water Wisp` 发光层的材质起点。

本图仍然没有展示实例内部参数，也没有显示该材质实例已经绑定到哪个 Niagara Renderer，所以当前能稳定复建的信息只有两点：

- 水系版本的基础发光材质来自现成材质实例
- 这个实例的来源父材质是 `M_UberMaterial`

### 00:03:27-00:06:20 Alpha

- 本段定位：Alpha。
- 知识点：我们选择了它,然后把它分開,然后需要把它更新 生命也应该改变,雖然日子可以变成随机泡沫 好,我们確定要改变35,35泡沫的尺寸。
- 知识点：無論如何,我们要把它增加到我们需要加一张光线 基本上,需要把轉圈泡沫和石色也留下 以致我们能看到泡沫是相似的 我们也要看看水平,我们把所有的位置都写上来。
- 知识点：可以把它放在这里,把它移到旁邊 是的,这些是泡沫,我認为它们太亮了 我需要把它改变它们的alpha,023 这可能,是中心,它会是泡沫的中心。
- 知识点：这些是泡沫,可以改变尺寸 最大是50,是的,把它放在这里,它们很大 然后这些是泡沫,我们需要一樣的光线 需要把它從这里取出来,同樣的材料。
- 知识点：點選主題,然后把它放在这里 我们可观察到它们的泡沫,我認为它们很亮 它值得改变它们的生命,可以让它长久一点。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`。

**关键画面：**

这是 `NS_Wisp_Water` 的系统总览截图。当前选中的发射器是 `Center_Fires`，右侧 `Details` 面板展开的是它的 `Sprite Renderer`，说明作者先从中心层的显示材质入手，把旧的火焰中心层替换成水系发光表现。

当前可直接确认的 `Sprite Renderer` 参数如下：

- `Material = MI_Glow_Water_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Sub Image Size = (2.0, 2.0)`
- `Cast Shadows = 开启`
- `Sort Order Hint = 14`
- `Motion Vector Setting = Auto Detect`

结合左侧预览，可以看到中心已经变成偏青蓝色、较柔和的水系发光团，而不是原先更炽热的火焰核心。也就是说，这一步的可复建动作是：保留 `Center_Fires` 这一层的结构，但把其精灵渲染材质切换为 `MI_Glow_Water_01`，并维持 `2x2` 的子图设置与较高的前景渲染顺序。
这张图回到关卡视图，目的是单独观察 `NS_Wisp_Water` 的泡沫形态。世界大纲里同时保留了三个对照对象：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`
- `NS_Wisp_Water`

当前选中的是 `NS_Wisp_Water`。从 `Details > Transform` 面板可直接确认这个实例的世界变换值：

- `Location = (147.3611, 231.2264, 0.00001)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

按当前关卡世界空间观察，火焰与闪电两个参照球仍摆在角色左前方，而 `NS_Wisp_Water` 被单独放到其右下侧位置，方便把水版本从主对照组里拉开，直接检查其中较亮的小圆点和外层淡蓝环是否已经更接近“气泡/泡沫”的观感。

结合字幕“这些是气泡”，这一步的作用是先在场景里确认水版本已经具备泡沫感，再决定后续要继续压低亮度、调整 Alpha 和寿命，而不是继续沿用火焰版那种更强、更实心的中心亮团。
这张图继续在 `NS_Wisp_Water` 的系统总览里处理外层主辉光。当前选中的发射器是 `Glow_Main`，右侧 `Details` 面板同样展开了它的 `Sprite Renderer`。可直接确认的参数如下：

- `Material = MI_Glow_Water_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Cast Shadows = 开启`
- `Sort Order Hint = 0`
- `Motion Vector Setting = Auto Detect`

左侧预览中的结果是一个更大、更柔和、Alpha 较低的淡蓝色光团。与前一张 `Center_Fires` 的设置相比，这里虽然仍然复用了 `MI_Glow_Water_01`，但通过把 `Sort Order Hint` 降到 `0`，让 `Glow_Main` 作为底层大面积辉光存在，而不去盖住中心气泡和核心高亮层。

因此，本图对应的可复建动作是：为 `Glow_Main` 指定同一套水系 glow 材质，并把它保留在默认排序层，用来做水团的外层雾化亮度，而不是前景泡沫细节。

### 00:06:31-00:09:04 Alpha、速度

- 本段定位：Alpha、速度。
- 知识点：或者可以把它变成雙層,这樣就可以简单了 我们把它做到这里,它会显示它们很亮 好的,它们都很亮 然后我们需要中心,中心,我们只需要一樣的材料。
- 知识点：这都是一般的泡沫,中心在这里和那里 然后可以适当增加第一次泡沫 第二,需要可以改变尺寸 我们来看看它是50,可以把它变成这麼大。
- 知识点：但重點是,只要改变颜色,把它变成这樣 这里,对,这里的愛心中心是没有任何分別的 需要把它变得不太表達,柔軟 但它会变得柔軟,或許是50,70,米海。
- 知识点：而且它也会是一种鐵合合氫水 它是颜色的調校,像是50,70,一樣 我们来给它一个更大的,Alpha05 这里我覺得可以改变它们的速度。
- 知识点：或許是一半的生命周期 我相信它是一种鐵合合氫水 Raid,在本質上,还可以 只是我認为它们忘記了250个數據 需要继续做 需要来到圆形。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`生命周期`、`速度`、`颜色`。

**关键画面：**

这张图展示的是 `NS_Wisp_Water` 中 `Glow_Main` 发射器的 `Initialize Particle` 设置，目标是把外层主辉光调得更柔和、更大，以支撑水团外围的轻雾感。当前可直接确认的参数如下：

- `Lifetime Mode = Direct Set`
- `Lifetime = 1.0`
- `Color Mode = Direct Set`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 200.0`
- `Uniform Sprite Size Max = 300.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

截图里 `Color` 字段只显示了颜色条和折叠箭头，没有可靠显示数值，因此不能编造具体 RGBA。左侧预览可以确认结果已经是一个大尺寸、边缘很软的青蓝色光团，亮度明显比前面的火焰版更散、更淡。

结合本段正文，这一步的可复建动作是：先把 `Glow_Main` 的寿命固定到 `1.0`，再把外层主光斑尺寸放大到 `200-300` 的随机区间，用较柔的青蓝色直设颜色去形成大面积水雾感，而不是紧凑、炽热的火焰中心。
这张图展示的是 `Glow_Center` 发射器的 `Initialize Particle` 设置，用于给水团中心再加一层更小、更轻的柔光芯。当前可直接确认的参数如下：

- `Lifetime Mode = Random`
- `Lifetime Min = 1.0`
- `Lifetime Max = 2.0`
- `Color Mode = Direct Set`
- `Color = (1.0, 1.0, 1.0, 0.1)`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 50.0`
- `Uniform Sprite Size Max = 70.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

和前一张 `Glow_Main` 相比，这里中心层的关键变化有两点：

- 寿命改成 `1.0-2.0` 的随机区间，让中心柔光持续时间更自然
- 颜色保持纯白，但把 `Alpha` 压到 `0.1`，避免中心太实、太亮

结合左侧预览和正文“中心需要一样的材料、但要更柔软”，这一步的可复建动作是：保留同类 glow 结构，但把中心层做成小尺寸、低 Alpha、白色的柔和光芯，让水系效果既有中心聚焦，又不会重新变回火焰那种高密度亮核。
这张图继续停留在 `Glow_Center` 发射器上，但视角从单个初始化参数扩展到整层发射器复核。右侧 `Details` 面板可直接确认以下发射器级设置：

- `Local Space = 开启`
- `Determinism = 关闭`
- `Interpolated Spawning = 开启`
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Requires Persistent IDs = 关闭`

`Emitter State` 区域可确认：

- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`

`Spawn Rate` 模块可确认：

- `SpawnRate = 3.0`
- `Spawn Probability = 1.0`

下方再次能看到 `Initialize Particle` 仍使用随机寿命：

- `Lifetime Mode = Random`
- `Lifetime Min = 1.0`
- `Lifetime Max = 2.0`

结合左侧预览，这一层是一个持续存在但密度不高的中心柔光层。可复建要点是：`Glow_Center` 不需要高生成量，只以 `SpawnRate = 3.0` 的低频率在本地空间里稳定生成，并配合 `1-2` 秒随机寿命维持柔和的中心呼吸感，让水球核心保持轻亮而不过曝。

### 00:09:30-00:14:10 关键流程 04

- 本段定位：关键流程 04。
- 知识点：可能是,可能,并非真的 它们不太柔軟 我真的不喜欢这个 首先,颜色必须是B 回到原本,物品必须在原本的位置设置 在这里,我们有一个特别的機会。
- 知识点：再次尝试它们 是的,有东西 是,它不太适合我们 我们需要另外一个Hero2 不,不太OK 我们去到物品设计師 在2048年制作一个新的物品。
- 知识点：2048年,所有东西都很標準 我们需要一些圆形 然后需要製造一个格式的圆形 由Uss,Uss,Uss,Uss 可以把圆形的圆形。
- 知识点：这樣做,但只可以製造一个格式 我们得到 圆形的圆形,它自然的量度減少 并且,圆形的圆形都变成0 这会很棒地控制 我现在想展示一个这樣的圆形。
- 知识点：可以在这里控制颜色 用圆形的幫助 让Hissig的圆形有一点點減少 如果我加上中间和頂部 这里是这个,在NotPoolRegistererst。
- 知识点：我们把它做成这樣 这里我也製造了这个側邊和这个側邊 我按下,对,它是显示的 这里是,你也可以做一些很有趣的事 你看,我正在編輯 或是,如果它是近一点。
- 知识点：是近一点,这里是伸延 可以,可以管理这个圆形 对,可以管理 可以保留这个圆形的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图展示的是 `NS_Wisp_Water` 中环形层 `FireRing_Main` 的 `Sprite Renderer` 复核画面。作者此时开始回头处理外圈环形图案，先检查它当前沿用的旧材质与渲染顺序，而不是直接改粒子初始化参数。

右侧 `Details` 面板当前可直接确认的 `Sprite Renderer` 参数如下：

- `Material = MI_FireRingSoft_Red_Add_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Cast Shadows = 开启`
- `Sort Order Hint = 16`
- `Motion Vector Setting = Auto Detect`

这说明 `FireRing_Main` 仍然挂着旧的红色加亮火焰环材质 `MI_FireRingSoft_Red_Add_01`，并且排在较前的渲染顺序 `16`。结合正文“颜色必须回到原本、材质必须重新设置”，这一步的作用就是先明确问题来源：当前水系版本的环形层仍继承了火焰版的材质表现，因此后续必须替换为新的圆形水环纹理或材质实例。
这张图是在 Substance 3D Designer 里制作新的环形灰度贴图，用来替代火焰版旧环材质所依赖的纹理。当前截图中只能稳定确认 `Curve` 节点及其输入输出预览，因此按可见信息记录如下。

节点定义集：

- `Curve`
  - 作用：把输入的灰度圆形重新映射为更窄、更可控的亮环
  - 分辨率标记：`2048x2048 - L16`

连线集：

- 一个前级灰度节点的输出接入 `Curve` 输入
- `Curve` 的输出生成当前预览中的白色环形灰度图

设置/参数：

- 右侧 `Curve - PROPERTIES` 显示当前节点输出尺寸为 `2048 x 2048`
- `Curve Addressing = Clamp`
- 曲线编辑器当前是一个尖顶三角形分布：左低、中高、右低
  - 这会把中间一段灰度值抬高成亮白环
  - 环内和环外则被压回较暗值

输出/预览：

- `2D View` 预览结果是中心发黑、内外两侧渐暗、环带最亮的单个圆环灰度图
- 下方 3D 预览仍是默认材质球/立方体查看器，没有展示该纹理已经接到具体材质网络

当前截图没有完整显示前级节点名称，也没有显示更多下游节点、导出节点或资源命名，所以不能可靠补写完整 Substance 图。能确定的核心步骤是：作者在 `2048` 分辨率下，用 `Curve` 节点把一个基础圆形灰度输入压成更可控的亮环遮罩，作为水系外圈环纹理的来源。
这张图继续在 Substance 3D Designer 里处理圆环纹理的柔化阶段。当前截图能稳定确认一段两节点链路：`Warp` 输出接到 `Blur HQ Grayscale`，用来把前面做出的硬边环进一步处理成更柔的发光圈。

节点定义集：

- `Warp`
  - 输出：一个已经带轻微形变的环形灰度图
  - 分辨率标记：`2048x2048 - L16`

- `Blur HQ Grayscale`
  - 作用：对环形灰度图做高质量模糊
  - 分辨率标记：`2048x2048 - L16`

连线集：

- `Warp` 输出 -> `Blur HQ Grayscale` 输入

设置/参数：

- 当前选中节点是 `Blur HQ Grayscale`
- `Graph Instance = pkg:///blur_hq_grayscale?...`
- `Description = Uniform high quality blur grayscale version`
- `Category = Filter`
- `Author = Adobe`
- `Instance Parameters`
- `Intensity = 16`
- `Quality = 1`

输出/预览：

- 左上 `2D View` 结果是一个边缘明显更软、亮带更宽的白色圆环灰度图
- 黑色中心和黑色背景仍然保留，说明当前输出仍是单通道遮罩/亮度纹理，而不是彩色贴图
- 下方 3D 预览仍未显示该纹理接入具体材质，仅作为节点结果检查

因此，这一步的可复建动作是：在前面得到的环形灰度基础上加入 `Blur HQ Grayscale`，并以 `Intensity = 16`、`Quality = 1` 把圆环边缘打散成柔和过渡，用于后续水系环形 glow 或泡沫外圈材质。

### 00:14:10-00:18:50 关键流程 05

- 本段定位：关键流程 05。
- 知识点：做的 让我们減少它的聲音 让它從Taco的位置变成Polar的位置 对,是 这就是我们做的 記得,我们有一个圆形的邊緣 让我把它壓成这樣。
- 知识点：这是一些很相似的东西 现在在本質上 需要用一个轉变器 来延伸主要的聲音 来改变背景 这是要开始的 我需要延伸得更延伸 我们不太会擋,但这不重要。
- 知识点：这就是主要的 只是形状是... 对,所有东西都很棒 我们得到这樣的結果 为什么? 因为需要弄得更小 然后把这个聲音減少 需要減少所有的聲音。
- 知识点：我们按下 在其他地方,主要的东西 是從这个位置变成旋律 现在可以控制 我们想減少的聲音 这里我看到 已经有太多的細節 需要減少它们 让我们看看,这就是它。
- 知识点：白色是更多的,而且形状很有趣 我们看到更多 然后我搜尋 可以試着把它放在隙縫 这是反向的 HQ 这很酷 樣本会增加 这是相反的減少 这是形状。
- 知识点：需要把这个形状分成混合 这里的單位也是重要的 需要加一点到0.2 全都加到20% 需要加这个,再加这个 基本上就是这樣 这对我们来說很有趣。
- 知识点：總括来說,可以試着把它改变 这里是 不,我不喜欢这个方式 这就行了 可以在这里再大一点的隙縫 減少 这里有更多的減少 可以用它来減少。

**关键画面：**

这张图是在 Substance 3D Designer 里为水系圆环加入破碎细节的起点。作者当前选中的是 `Cells 4` 节点，并打开搜索框准备插入极坐标转换节点，把这类平铺噪声沿圆周方向卷成一整圈细节。

节点定义集：

- `Cells 4`
  - 类型：程序化噪声/分块生成器
  - 分辨率标记：`2048x2048 - L16`
  - 当前 `2D View` 预览为黑白灰不规则碎片块

- 候选后续节点
  - `Polar to Cartesian Grayscale`
  - `Cartesian To Polar Grayscale`

连线集：

- 当前正在从 `Cells 4` 的输出端拖出连线
- 连线目标还未真正放下，只能确认作者准备把 `Cells 4` 接到某个极坐标转换节点

设置/参数：

- `Cells 4` 右侧属性面板可确认：
- `Category = Generator`
- `Author = Adobe`
- `Tags = Noise`
- `Scale = 14`
- `Disorder = 0`
- `Color Source = Random`
- `Non Square Expansion = True`

输出/预览：

- `2D View` 当前只显示 `Cells 4` 的原始灰度噪声，还没有看到极坐标转换后的环形结果
- 字幕“将尖端转动 360 度”与节点搜索候选共同说明，这一步是在为后续环形贴图准备可沿圆周展开的噪声源

因此，本图可复建的动作是：先用 `Cells 4` 生成碎片化灰度噪声，再准备通过 `Cartesian To Polar Grayscale` 一类节点把线性噪声转为环形分布，用于打破前面过于平滑的水环边缘。
这张图展示的是环形细节贴图在 Substance 3D Designer 里的进一步整理结果。当前截图已经能明确看到一段用于打散圆环边缘的小网络。

节点定义集：

- `Blend`
  - 输出一个已经带初步破碎感的环形灰度图
  - 分辨率标记：`2048x2048 - L16`

- `Invert Grayscale`
  - 对环形灰度做反相
  - 分辨率标记：`2048x2048 - L16`

- `Blur HQ Grayscale`
  - 对反相结果进一步模糊，形成更适合做方向驱动的软边图
  - 分辨率标记：`2048x2048 - L16`

- `Slope Blur Grayscale`
  - 作用：用一张效果图驱动方向性模糊，让圆环边缘产生不均匀起伏
  - 分辨率标记：`2048x2048 - L16`

- 右上还有一个后续 `Blend`
  - 用于把 `Slope Blur Grayscale` 的结果再合回主输出

连线集：

- 左侧 `Blend` 输出 -> `Slope Blur Grayscale` 主输入
- 左侧 `Blend` 输出 -> `Invert Grayscale`
- `Invert Grayscale` 输出 -> `Blur HQ Grayscale`
- `Blur HQ Grayscale` 输出 -> `Slope Blur Grayscale` 的效果输入
- `Slope Blur Grayscale` 输出 -> 右上后续 `Blend`
- 左侧 `Blend` 输出也同时接入右上后续 `Blend`

设置/参数：

- 当前选中节点是 `Slope Blur Grayscale`
- `Category = Filter`
- `Author = Adobe`
- `Samples = 12`
- `Intensity = 1.99`
- `Mode = Blur`

输出/预览：

- 左上 `2D View` 的 `Blend` 预览已经显示出一圈发亮但边缘凹凸不均的白色环
- 这种效果说明环形不再是均匀圆边，而是出现了类似泡沫、水流冲刷后的破边细节

因此，这一步的可复建动作是：把基础环形结果与其反相模糊版本一起送入 `Slope Blur Grayscale`，用 `Samples = 12`、`Intensity = 1.99` 做方向性打散，再把处理结果与原环继续混合，得到更自然的水环边缘。
这张图展示的是环形细节贴图的进一步减法清理阶段。当前图中可稳定确认：作者把已有的环形结果与一张 `Perlin Noise` 再做一次 `Blend`，通过减法去掉过多细节，随后再接一层 `Blur HQ Grayscale` 收尾。

节点定义集：

- 左侧 `Blend`
  - 输出：上一阶段已经成形的破边环
  - 分辨率标记：`2048x2048 - L16`

- 中间 `Blend`
  - 作用：把 `Perlin Noise` 混入环形结果，进行减法细节裁剪
  - 分辨率标记：`2048x2048 - L16`

- `Perlin Noise`
  - 作为附加细噪声输入
  - 分辨率标记：`2048x2048 - L16`

- 右侧 `Blur HQ Grayscale`
  - 对新环形结果再柔化一次
  - 分辨率标记：`2048x2048 - L16`

连线集：

- 左侧 `Blend` 输出 -> 中间 `Blend` 主输入
- `Perlin Noise` 输出 -> 中间 `Blend` 的另一输入
- 中间 `Blend` 输出 -> 右侧 `Blur HQ Grayscale`

设置/参数：

- 当前选中节点是中间 `Blend`
- `Opacity = 0.31`
- `Blending Mode = Subtract`
- `Cropping Area = Left 0 / Right 1 / Top 0 / Bottom 1`

输出/预览：

- 左上 `2D View` 显示的是一圈仍然不规则、但局部亮块被压下去后的白色环
- 结果比上一张更克制，边缘细节减少，整体轮廓更集中

因此，这一步的可复建动作是：在已打散的环形灰度图上再减入一层 `Perlin Noise`，并用 `Subtract`、`Opacity = 0.31` 把过密的亮块削掉，最后交给 `Blur HQ Grayscale` 做统一柔化，让最终水环既保留破边感，又不过于噪杂。

### 00:18:50-00:23:39 粒子

- 本段定位：粒子。
- 知识点：但这就行了 一切都很好 可以看看自動测试 让我们減少它 放進圖表 格局,让我们有8个节奏 記得從Gray Scale到RGB 從16个节奏到8个节奏。
- 知识点：把这里和这里的全部都放進去 把出口放進去 对,出口,这里的全部都放進去 这就带我们到桌上 我只选择RGB Export Export 对,我们回到这里。
- 知识点：Rishi,我会找到它给我減少的地方 需要给它正確的名字 质感,水 它不会像那种水晶的质感 我只会放進去 让我放進去 这里,很軟 基本上,它已经像水一樣。
- 知识点：像这麼小的水晶 在一般来說,它很酷 可能我只要增加它 就能確定它是这麼小 和分開的分開 更多,135 对,看起来很好 现在我们来看看 可以在这个粒子系统里改变。
- 知识点：需要先,好,我们先把全部都放進去 唯一的問題是 我应该要增加分開的大小 然后 大概 这就是我们 会有 更多的时间去留下 不差 这里是需要減少的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`系统`、`颜色`。

**关键画面：**

这张图展示的是水环灰度贴图在 Substance 3D Designer 中的最终输出整理阶段。当前截图已经能稳定确认一段导出前链路：`Blend` 的环形结果先经过 `Blur HQ Grayscale` 柔化，再进入 `Auto Levels` 拉对比，最后接到 `Output`。

节点定义集：

- `Blend`
  - 输出：上一阶段已经整理过细节的环形灰度图
  - 分辨率标记：`2048x2048 - L16`

- `Blur HQ Grayscale`
  - 作用：在最终导出前再次统一柔化环边
  - 分辨率标记：`2048x2048 - L16`

- `Auto Levels`
  - 作用：自动重映射黑白范围，让导出遮罩的亮暗区间更干净
  - 分辨率标记：`2048x2048 - L16`

- `Output`
  - 作为当前灰度环纹理的最终输出端

连线集：

- `Blend` 输出 -> `Blur HQ Grayscale`
- `Blur HQ Grayscale` 输出 -> `Auto Levels`
- `Auto Levels` 输出 -> `Output`

设置/参数：

- 当前选中节点是 `Blur HQ Grayscale`
- `Category = Filter`
- `Author = Adobe`
- `Intensity = 5.49`
- `Quality` 字段可见，但当前截图未稳定显示具体数值

输出/预览：

- 左上 `2D View` 预览的是 `Auto Levels` 结果：一圈亮部集中、边缘较软、内部中空的白色环
- 输出仍是 `2048x2048` 的 `L16` 灰度图，不是 RGB 贴图

因此，这一步的可复建动作是：把已经成形的水环灰度图在导出前再做一次高质量模糊，并通过 `Auto Levels` 收紧亮暗范围，使最终输出的粒子遮罩既柔和又层次清楚。
这张图回到 `NS_Wisp_Water` 的系统总览，说明新做好的水环贴图已经开始落回 Niagara 使用。当前选中的发射器是 `WaterRing_Main`，说明原先的火焰环主层已经被改成水环主层。

右侧 `Details` 面板当前只展开了 `Spawn Rate`，可直接确认参数如下：

- `SpawnRate = 4.0`
- `Spawn Probability = 1.0`

左侧预览里已经能看到一圈较柔和的水蓝色环形亮边，不再是火焰教程中偏红偏硬的外环。结合字幕“我可能应该增加大小，sprite size”，这张图对应的阶段是：先确认新水环层已经能稳定生成，再继续考虑下一步是否要把这层粒子的 `Sprite Size` 再放大。

因此，本图可复建的动作是：在 `WaterRing_Main` 上启用新的水环粒子层，并先把生成频率固定到 `4.0`，让场景中持续出现少量主环粒子，之后再继续调尺寸和显示强度。
这张图展示的是 `WaterRing_Scale` 发射器的 `Initialize Particle` 设置。作者在这一步开始细调水环粒子的单粒子外观，包括寿命、颜色随机范围和精灵尺寸，让环边看起来更像轻薄的水雾片段。

当前可直接确认的参数如下：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.75`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 125.0`
- `Uniform Sprite Size Max = 135.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`

截图中颜色选择器已打开，说明作者正在调 `Color Minimum` 或 `Color Maximum` 之一，但当前画面没有同时稳定展示两端颜色值和对应字段，因此不能可靠补写完整的最小/最大 RGBA 组合。能确认的是：这一层使用的是暖偏橙的颜色取值，而不是前面中心 glow 常见的青蓝色直设值。

左侧预览能看到外环上出现一圈更淡、更散的环形粒子片段。结合正文“应该增加大小，sprite size”，这一步的可复建动作是：给 `WaterRing_Scale` 使用 `0.75-1.0` 秒的随机寿命、`125-135` 的随机精灵尺寸和随机旋转，再配合一组随机颜色范围，让水环边缘由单一圆环扩展成更有层次的粒子带。

### 00:23:39-00:28:32 Spawn

- 本段定位：Spawn。
- 知识点：噗,是,水 是,材料 材料也会变 只要它们都一樣 它们都需要 從1到2 首先 第二,基本上,水的搖滾度是OK的 轉圈度是OK的 只有它们都一樣。
- 知识点：可能是,你必须看看这里 SpawnRide 3 这种水,基本上,你也可以看看它的大小 它们是135,150 这里是150,200 唯一的問題是。
- 知识点：我应该会用0.3,0.7 来減少颜色 是,是,不差 我们继续 我们有什么? 也有烟 基本上,我们只能把烟放在 是,让它们清楚地看見 是,我们必须減少颜色。
- 知识点：是,在这个情况下 我们必须用这个 是,像这樣 它们只需要明顯地 变得更亮 我们不需要这麼黑的 是,因为在SpawnRide。
- 知识点：基本上,它们必须減少它 唯一的問題是 颜色上,是,可能 我们必须減少它 是,在这里 你也可以测试看 我们需要更黑的颜色。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Spawn`、`颜色`。

**关键画面：**

这张图是 `Spawn` 段里的场景级对比检查。作者把 `NS_Wisp_Water` 放回关卡，与左侧旧的火焰/闪电系球体效果并排观察，用肉眼确认新水环和中心 glow 的整体密度是否合适。

当前可直接确认的对象与资源锚点如下：

- 当前选中 Actor：`NS_Wisp_Water`
- `Niagara System Asset = NS_Wisp_Water`
- 下方材质实例目录：`Content / VFX_Library / Materials / Instances / Wisps / Water`
- 当前可见两个关键材质实例：
  - `MI_Glow_Water_01`
  - `MI_WaterRingSoft_01`

右侧 `Transform` 面板还能确认当前关卡实例位置：

- `Location = (84.0020, 350.0, 200.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

按当前关卡世界空间观察，左侧是旧版本的蓝色闪电球，右侧是新的水球版本。水球的外环已经变成更浑浊、更雾化的青绿色半透明圈，中心仍保留亮核。结合本段正文，这一步不是继续做贴图，而是先确认新材质实例和粒子层组合回系统后，整体观感是否已经接近“水”而不是“电”或“火”。
这张图继续停留在关卡对比视图，但作者已经打开 `Color Picker`，直接给 `NS_Wisp_Water` 试颜色。画面里同时保留三种版本作为参照：左侧火焰、中央闪电、右侧水球。当前可直接确认的颜色选择器参数如下：

- `R = 0.111911`
- `G = 0.520263`
- `B = 0.539435`
- `A = 0.3`
- `H = 182.690536`
- `S = 0.79254`
- `V = 0.539435`
- `Hex Linear = 1D858A4D`
- `Hex sRGB = 5EBFC24D`

从 `Old / New` 预览块可以看出，作者把颜色从更亮、更偏白的旧值压到了更深一点的青绿色新值。结合本段正文里“用 0.3、0.7 去减少颜色”“需要更黑的颜色”的意思，这一步的可复建动作是：把水球整体色调从亮蓝白进一步压暗，改成饱和度较高但明度更低的青绿色，并保留 `Alpha = 0.3` 的半透明度，让水球外圈更像浑浊水雾，而不是高能发光球。
这张图展示的是 `Smoke_Top` 发射器的复核画面。当前发射器标题下直接显示 `Emitter is not enabled. Excluded from code.`，说明这层顶部烟雾在当前水球版本里被关闭，不参与实际运行结果。

右侧 `Details` 面板仍可直接确认的发射器级设置如下：

- `Local Space = 开启`
- `Determinism = 关闭`
- `Interpolated Spawning = 开启`
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Requires Persistent IDs = 关闭`

`Emitter State` 区域可确认：

- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`

`Spawn Rate` 模块可确认：

- `SpawnRate = 40.0`
- `Spawn Probability = 1.0`

下方 `Initialize Particle` 当前还能看到部分寿命设置：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`

左侧预览里这层对应的可见贡献极弱，几乎只剩一个很小的淡色点。结合本段正文“也有烟……必须减少颜色”，这一步的可复建动作是：保留 `Smoke_Top` 作为可选辅助层，但在当前水球方案里先将其禁用，避免顶部烟雾把水体读感重新带回火焰/能量球那种脏雾效果。

### 00:28:32-00:33:09 速度

- 本段定位：速度。
- 知识点：可以用这个来取得泡泡 这也是一个空氣池 我们把它換成25 我们把材料安排好 圆形是显示的,所有东西都OK 我们把材料安排好 这里有下降。
- 知识点：让它下降 我们把它这樣做,需要自己修理 啊! 它开始下降,当然很快 100 这是第一 是,它是很明顯的,它是需要修理的 我認为这是必须的 是的,從5到10,基本上,都OK。
- 知识点：,它是一秒半的生命周期 也許,打开的資料还没被接受 是的,是随机的 直到现在 现在需要看 可能是 这里我们有一个藍色的 好,OK 下一个圆形的位置。
- 知识点：就是,我们需要它下降,对吧? 这里是怎樣的? 我们把它轉为25的位置 好,我们来想想 它们会轉这个方向 这对我们来說,很棒的 如果我们把它加進去。
- 知识点：因为它们还在加速,对嗎? 從这里开始 它们会被整个地方都擺在一起 例如,它们开始了動作 加速 我们把它像这樣,随机的 随机的随机,從25到20。
- 知识点：,看起来很奇怪 这就是为什么我们改变了 你記得,对吧? 它们的方向,我们需要设置 速度的调整。
- 知识点：好 现在,这是一个完全不同的問題 我们改变了A,我们也改变了 让它是 0.1,0.2 所以,它们可以做什么? 它们不能延长,就是減速 快速。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`。

**关键画面：**

这张图展示的是新水环贴图在 Unreal 里的导入检查画面。当前打开的资源标签是 `T_SoftRing_01`，左侧预览能看到一张黑底白环、边缘带破碎亮块的灰度纹理，说明前面在 Substance 中做出的水环遮罩已经成功导入项目。

右侧 `Details` 面板当前可直接确认的纹理信息如下：

- `Imported = 2048x2048`
- `Displayed = 2048x2048`
- `Max In-Game = 2048x2048`
- `Resource Size = 2731 KB`
- `Has Alpha Channel = False`
- `Source Alpha Detected = False`
- `Format = DXT1`
- `Combined LOD Bias = 0`
- `Number of Mips = 12`
- `Encode Speed = Fast`

`Level Of Detail` 区域可确认：

- `Mip Gen Settings = FromTextureGroup`
- `LOD Bias = 0`
- `Texture Group = World`

`Compression Settings` 可确认：

- `Compression Settings = Default (DXT1/5, BC1/3 on DX11)`

结合左侧预览，这一步的可复建动作是：将做好的单通道水环纹理以无 Alpha 的 `DXT1` 方式导入 UE，并保持 `2048x2048` 分辨率与默认世界纹理分组，用作后续 `MI_WaterRingSoft_01` 或相关水环材质的主贴图输入。
这张图展示的是 `NS_Wisp_Water` 中 `Empty` 发射器的速度设置。当前右侧 `Details` 面板展开的是 `Add Velocity` 模块，用来给这一层粒子加入上下浮动或下落感，而不是让它们静止悬在球体表面。

当前可直接确认的参数如下：

- `Velocity Mode = Linear`
- `Velocity = Vector from Float`
- `Value = Random Range Float`
- `Minimum = -25.0`
- `Maximum = 25.0`
- `Velocity Speed Scale = 1.0`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`

左侧预览里已经能看到一些细长水滴状粒子从球体附近向下拉开，说明这层速度并不是只往一个固定方向，而是在局部空间内给粒子一个带随机范围的线性速度。结合本段正文“把它换成 25”“让它下降”，这一步的可复建动作是：在 `Empty` 发射器上添加 `Add Velocity`，使用 `-25` 到 `25` 的随机速度区间，让粒子产生轻微的漂移和下坠变化，避免整层水滴完全静止。
这张图继续在 `Empty` 发射器上做速度相关调节，但焦点已经切到 `Scale Sprite Size by Speed` 模块。这个模块的作用是让粒子尺寸跟随速度变化，避免下落粒子全部保持同一大小而显得僵硬。

当前可直接确认的参数如下：

- `Min Scale Factor = (0.5, 1.0)`
- `Max Scale Factor = (1.0, 2.0)`
- `Velocity Threshold = 1000.0`
- `Sample Scale Factor By Curve = 关闭`

从左侧预览可以看到，这一层的细长水滴已经出现不同长度和轻微拉伸感，而不是等尺寸小点。结合前一张的 `Add Velocity` 和本段正文“它们还在加速”“速度的调整”，这一步的可复建动作是：在 `Empty` 粒子层上追加 `Scale Sprite Size by Speed`，让速度较高的粒子获得更大的拉伸比例，速度较低的粒子保持更小、更短的外形，从而让下落水滴读起来更自然。

### 00:33:09-00:38:02 Alpha

- 本段定位：Alpha。
- 知识点：我们有什么錯?下降 水 下降 每一件都很棒,是的 接下来我们需要一些氣泡 好的,我们把下降的水来删除 它会改变,这就是它会影响我们。
- 知识点：-水 氣泡 人們,是的 现在我们需要找到这个氣泡 所以它在这里 在原則上 我们可观察到在这里用同一个颜色的氣泡。
- 知识点：这很棒 所有东西都被保留了 泡泡 高光 然后我们把它丟進去 它们不会下降,我们的博物館 可以理解,相反地 上升,我们把平衡、平衡、平衡。
- 知识点：把平衡、平衡、平衡,让它们不平衡 根據这个 我们可观察到它们还可以给它们一个轉圈的回復率 让它们喝醉了 轉圈回復率 也很快,是的,從-500到50。
- 知识点：在那里 是泡泡的大小 泡泡的大小在那里 但某些原因,没有高光 而在这里,其實没有高光 可以從那里去看 让它们仍然是高光 而它们仍然是高光。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`颜色`。

**关键画面：**

这张图展示的是 `Water_Drops` 发射器的发射器级与基础粒子设置。结合本段正文“把下降的水删除，接下来需要一些气泡”，这一层已经不是单纯的下落水滴，而是在改造成更偏气泡感的补充粒子层。

当前右侧 `Details` 面板可直接确认的参数如下：

- `Local Space = 关闭`
- `Determinism = 关闭`
- `Interpolated Spawning = 开启`
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Requires Persistent IDs = 关闭`

`Emitter State` 区域可确认：

- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`

`Spawn Rate` 模块可确认：

- `SpawnRate = 25.0`
- `Spawn Probability = 1.0`

`Initialize Particle` 当前还能直接读到：

- `Lifetime Mode = Random`
- `Lifetime Min = 1.0`
- `Lifetime Max = 1.5`

这一步的可复建动作是：建立一个独立于主体光球的 `Water_Drops` 层，以 `SpawnRate = 25` 的中高频率持续生成，并把单粒子寿命控制在 `1.0-1.5` 秒，让后续的气泡或小水滴可以保持更轻、更散的屏幕密度。
这张图展示的是 `Water_Drops001` 发射器的 `Scale Sprite Size` 曲线设置。作者在这一层通过尺寸曲线去塑造气泡/水滴的生命过程，而不是只给固定大小。右侧 `Details` 面板可直接确认：

- `Scale Sprite Size Mode = Uniform Curve`
- `Uniform Curve Index = PARTICLES.NormalizedAge`
- `Uniform Curve Scale = 1.0`

曲线图当前可见的形状特征如下：

- 起点在 `NormalizedAge = 0` 时，缩放值接近 `0`
- 随后很快上升到接近 `0.9-1.0` 的峰值
- 之后持续向右下降
- 到生命周期末端时再次接近 `0`

也就是说，这条曲线对应的是“粒子生成后先迅速膨胀，再逐步缩回”的尺寸变化。结合字幕“sprite size 在那里，但没有 scale color”，这一步的可复建动作是：先只用 `Scale Sprite Size` 曲线控制气泡大小变化，不依赖 `Scale Color` 来做同样的衰减，让气泡粒子在生命周期里先显现出来，再慢慢缩小消失。
这张图展示的是 `Center_Bubbles` 发射器的 `Initialize Particle` 设置，重点在气泡中心层的 `Alpha` 与尺寸控制。右侧面板当前可直接确认的参数如下：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`
- `Color Minimum = (1.0, 1.0, 1.0, 0.2)`
- `Color Maximum = (1.0, 1.0, 1.0, 0.3)`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 25.0`
- `Uniform Sprite Size Max = 35.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`

这说明 `Center_Bubbles` 并没有改颜色色相，而是把颜色固定在白色区间，通过 `Alpha 0.2-0.3` 的随机范围来控制透明度。结合字幕“增加 target alpha”与正文“同一个颜色的气泡、仍然是高光”，这一步的可复建动作是：让中心气泡层保持白色高光读感，同时把透明度控制在 `0.2-0.3` 的轻范围内，再用 `25-35` 的小尺寸随机区间去生成更像高光气泡的小颗粒，而不是大块实心斑点。

### 00:38:02-00:43:02 速度

- 本段定位：速度。
- 知识点：哦,ok,它们在这里 我看到了,0.5 可能是25 还是15 唯一的問題是烟 我不喜欢它们,所以是小塊 我覺得小塊不需要水 这里有泡泡,所以決定了。
- 知识点：有泡泡 这里有泡泡 可以在这里添加泡泡 雖然它们已经被河水影响 这里是大樹 它们现在在这里 它们在動得很狡猾 是的,我只能說 这里需要放35。
- 知识点：让它们这樣倒下 很激烈 也有可能会有泡泡 让它们有时间活動 好,那至少15吧 是的,泡泡太多了 它们太鹹了 这就这樣 它们也有點像水 我可以做到三个部分。
- 知识点：測量 雖然很棒 但我还是不太会 我感覺到 它们会比較慢 可能需要減低了 这里中心还比較亮 中心是0.575 所以这里会变成 0.1-0.75。
- 知识点：我们有三个成果 水,烟,火 我明白了 我明白了,是的 这里的意思是正確的 我们可观察到这里的很简单的成果 是的 基本上,它们立刻都能看見。
- 核对对象：`速度`。

**关键画面：**

这张图展示的是 `Center_Bubbles` 发射器 `Initialize Particle` 里的颜色与透明度继续调亮后的状态。当前右侧面板可直接确认的参数如下：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 25.0`
- `Uniform Sprite Size Max = 35.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`

当前图中最关键的变化是 `Color Maximum` 的白色高光透明度已被提升，界面上悬浮提示可确认：

- `Color Maximum Alpha = 1.0`

同时仍能看到 `Color Minimum` 保持白色较低透明度区间，用于在随机范围里保留更淡的气泡颗粒。结合本段正文“这里中心还比较亮……0.1-0.75”以及字幕里继续提亮的语义，这一步的可复建动作是：保留中心气泡层的白色高光方向，但把随机上限进一步抬高到完全不透明，使少量粒子能读成更清晰的亮点，同时让其他粒子仍保持较轻的半透明区间。
这张图回到关卡对比视图，用来检查新的泡泡材质是否已经正确并入 `NS_Wisp_Water`。场景里仍然保留三种版本对照：

- 左侧：火焰版球体
- 中间：闪电版球体
- 右侧：当前的水球版 `NS_Wisp_Water`

当前下方 `Content Browser` 位于 `Content / VFX_Library / Materials / Instances / Wisps / Water`，可直接看到 4 个关键材质实例：

- `MI_Glow_Water_01`
- `MI_WaterBubble_01`
- `MI_WaterDropsSoft_01`
- `MI_WaterRingSoft_01`

其中当前高亮的是 `MI_WaterBubble_01`。这说明教程在这一阶段已经明确把“泡泡”单独拆成一张材质实例，而不是继续复用单一的 glow 或 ring 材质。

从场景结果看，右侧水球现在由三类视觉要素共同构成：

- 中心白亮核
- 外层雾化环
- 球体内部和边缘的泡泡/亮点细节

因此，这一步的可复建动作是：把 `MI_WaterBubble_01` 纳入水球材质集合，与 `MI_Glow_Water_01`、`MI_WaterDropsSoft_01`、`MI_WaterRingSoft_01` 一起分工，分别承担中心 glow、泡泡高光、水滴片段和外环轮廓，从而让水球效果不再只靠单一贴图支撑。
这张图展示的是烟雾材质实例的复核画面。当前打开的标签包括 `MI_SmokeSoft_Alpha_01` 和 `MI_SmokeSoft_Add_01`，右侧 `Details` 面板显示的实例参数仍然是明显偏火焰/烟雾方向的配置，这也是本段正文里“烟我不喜欢”的直接原因。

当前可直接确认的材质实例参数如下：

- `Global Scalar Parameter Values`
- `Premultiply Color? = 1.0`
- `Use Colormap? = 0.0`

- `Global Texture Parameter Values`
- `Colormap = VFX_T_ColorMap_Red_02`
- `T_Main = T_Smoke8_2x2`

- `General`
- `Parent = M_UberMaterial`

- `Material Property Overrides`
- `Opacity Mask Clip Value = 0.3333`
- `Blend Mode = Additive`

从材质实例名、贴图选择和红色 `Colormap` 可以直接看出，这套实例仍然沿用的是偏红、偏烟雾的素材基础，而不是水球所需的青蓝/白色泡泡语言。左侧预览也几乎看不到适合水球的清澈细节。

因此，这一步的可复建动作是：复核烟雾材质链后确认它仍然更适合火焰/烟雾读感，不适合作为水球的主体层；后续应继续弱化、替换或移除这一路，而把表现重点放在 `WaterBubble`、`WaterDropsSoft` 与 `WaterRingSoft` 这些更贴近水体的材质实例上。

### 00:43:02-00:46:06 火焰

- 本段定位：火焰。
- 知识点：很酷,但太亮了 这里还是很亮 而且很清晰 可以把兩者混合起来 例如,这个比較小 这里有烟柔柔的 我们把它变成1-1 这里是烟柔柔的 另一邊会亮。
- 知识点：是0的 这里会变大,但会变小 60和70 需要交換烟柔柔 是的,它是 在火車上 需要用这个,它会变暗 所以这里是 我们看到,在这樣之下的組合。
- 知识点：可以減少烟柔柔 这也可能 需要把它变成 它不会被拉低,但会变大 这里可以想像 怎麼做得更好 或者可以把它拿走 可能会变成这樣,看起来更有趣。
- 知识点：你必须测试看 也可能会变成α 例如,它会变得更暗 这里,这里,这里 可能会有一点點感覺 可能没有 是的,现在需要把它取消 需要把α变成0,6。
- 知识点：让它变成这樣 这就是我们有三个这樣的元素 风格,很简单 在下一个影片,需要展示如何製造一个现實的元素 我们有这樣的元素 在氣球上,有这樣的元素。
- 核对对象：`火焰`。

**关键画面：**

这张图展示的是 `Smoke_Main` 发射器的 `Sprite Renderer` 复核画面。教程在最后一段重新审视“火焰/烟雾感”是否还要保留，并把这一层压得更弱，避免它继续把水球读感往火焰方向拉。

右侧 `Details` 面板当前可直接确认的参数如下：

- `Material = MI_SmokeSoft_Add_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Sub Image Size = (2.0, 2.0)`
- `Cast Shadows = 开启`
- `Sort Order Hint = 1`
- `Motion Vector Setting = Auto Detect`

结合左侧预览，这一层在最终结果里只剩很弱的一团雾化补充，远低于中心 glow、泡泡和水环的存在感。可复建要点是：`Smoke_Main` 仍保留在系统中，但通过较低的排序和很弱的 additive 烟雾材质，只作为轻微背景柔化层使用，而不再承担主视觉。
这张图展示的是 `NS_Wisp_Water` 在教程结尾阶段的系统层级整理结果。虽然右侧 `Details` 面板没有展开具体参数，但系统总览里已经能明确看到作者把最终效果拆成多条语义清晰的发射器层。

当前图中能直接辨认出的关键发射器包括：

- `Center_Bubbles`
- `Glow_Center`
- `Glow_Main`
- `Smoke_Main_Bright`
- `Smoke_Main_Dark`
- `Water_Bubbles`
- `Water_Drops`
- `WaterRing_Main`

这说明教程已经不再使用早期那种单一的 `Smoke_Main` 或模糊命名，而是把烟雾层进一步拆成亮烟与暗烟两组，再与泡泡层、水滴层和主水环层并列管理。

结合左侧预览，最终水球此时已经形成三个主要视觉簇：

- 中心亮核与中心泡泡
- 中段雾化/烟化柔层
- 外圈水环与散落水滴

因此，这一步的可复建动作是：在系统末尾按职责重新整理发射器层级，把亮烟、暗烟、泡泡、水滴和水环拆开管理，便于分别压亮度、减烟感、增泡泡感，最终把效果稳定在“水球”而不是“火焰球”的方向上。
这张图是 `04 Water Wisp` 章节的最终成品对比画面。关卡里同时摆放了三种同类风格球体效果，用来直观比较不同元素语义是否成立：

- 左侧：火焰版球体
- 中间：闪电版球体
- 右侧：当前完成的水球版 `NS_Wisp_Water`

当前选中的仍是 `NS_Wisp_Water`。右侧 `Details` 面板可直接确认：

- `Location = (84.0020, 350.0, 200.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Water`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability = 开启`

从最终画面可总结出水球版的成品特征：

- 中心有一颗明亮的白青色亮核
- 球体外侧包着一层较软、较浑浊的青绿色雾环
- 环边和球体内部出现零散的泡泡/亮点高光
- 整体亮度明显低于火焰和闪电版本，读感更柔、更湿、更朦

结合字幕“就这样吧”，这一步对应的可复建结论是：教程最终接受了一个偏 stylized 的水元素球体方案，它不是写实水柱或水花，而是通过 glow、bubble、water ring、少量 drops 和弱烟层的组合，形成与火焰球、闪电球并列的第三种元素变体。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


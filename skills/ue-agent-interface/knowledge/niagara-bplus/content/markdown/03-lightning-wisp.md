# 03 Lightning Wisp

# 03 Lightning Wisp

## 关键术语

- `Spawn`、`UV`、`系统`、`速度`、`NS_Wisp_Fire`、`如果中间有一个闪电，或许还有某种背光效果，那会很酷`、`Niagara`、`颜色`、`闪电`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Initialize Particle`、`Lifetime`、`Color`、`Alpha`、`Opacity`

## 分段知识

### 00:00:05-00:04:53 UV、系统、颜色

- 本段定位：UV、系统、颜色。
- 知识点：开始吧! 如何变化? 在中间的灯光板上,可能是一些黑光,需要改变色彩。
- 知识点：后续会有更多的蓝色,或许是小的灯光板, 在这一层的能量中,我们也将改变了圆形的颜色, 并且改变了其他影响的细节。
- 知识点：我们就要去编辑材料,编辑一点点这个环境的系统。
- 知识点：环境可以一样,或许甚至会有些细节。
- 知识点：既然后续会有许多的变化, 那我们就要制作一个盘子。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`系统`、`颜色`。

**关键画面：**

这一帧是 `03 Lightning Wisp` 章节的起始目标图，先在关卡 `Stylized_Wisps` 中查看上一章留下的 `NS_Wisp_Fire` 实例，并提出“把中心做成闪电、再加某种背光”的改造方向。字幕直接说明：`如果中间有一个闪电，或许还有某种背光效果，那会很酷。`

右侧 `Details` 面板当前对象是 `NS_Wisp_Fire (Instance)`，可确认：

- `Location = (-141.219, 343.544, 190.550)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

场景中当前仍是上一章的火焰版 wisp：中心亮黄白火核、外侧红橙火环、内部带一些暖色碎片和烟雾层。也就是说，本章不是从零开始，而是在现有 `NS_Wisp_Fire` 基础上，把整体视觉从“火焰”转向“闪电/蓝色能量”。

下方内容浏览器停留在 `VFX_Library/Materials/Instances/Wisps`，当前可见的一组实例包括：

- `MI_FireRingSoft_Add_01`
- `MI_FireSoft_Add_01`
- `MI_Glow_Red_Add_01`
- `MI_Pieces_Alpha_01`
- `MI_SmokeSoft_Alpha_01`

这些资源都是暖色火焰体系，正好说明本章后续要优先改材质和颜色，而不是先大改系统骨架。
这一帧说明 lightning 版本不会直接覆盖旧系统，而是新建一个独立系统 `NS_Wisp_Lightning`，并从材质实例开始搭建新分支。顶部标签已经能看到：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`

右侧 `Details` 面板当前仍显示场景中的 `NS_Wisp_Fire (Instance)`，其实例参数保持：

- `Location = (-141.219, 343.544, 190.550)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

这说明当前主要是在做资源准备，而不是已经把场景实例切换成 lightning 版本。

下方内容浏览器当前切到 `VFX_Library/Materials/MM`，并且只可见两个资源：

- `M_UberMaterial`
- 一个新建的材质实例，名称可见为以 `Lightning` 开头的实例

左侧目录树还能看到已经建立了分组路径：

- `Materials/Instances/Wisps/Fire`
- `Materials/Instances/Wisps/Lightning`
- `Materials/MM`

结合字幕“进入材料界面。我们创建一个实例。给它命名。我们把它放在……”可以确认这一帧的操作目标是：从通用母材质 `M_UberMaterial` 派生一个 lightning 专用材质实例，并把它归档到闪电分支，而不是继续沿用火焰章节里的 `Fire` 实例。
这一帧已经进入新系统 `NS_Wisp_Lightning`，教程开始把“中心火焰”改造成“中心闪电”。左侧预览窗口可见一条亮蓝色折线闪电，说明当前中心层已经不再使用火焰贴片，而是换成了闪电形状贴图。

当前系统中可见并启用的中心发射器是 `Center_Lightnings`。同时还能看到旧火焰系统里的多个发射器仍然保留在场景中作为参考或待替换对象，例如：

- `FireRing_Main`
- `FireRing_Scale`
- `FireRing_ScaleBig`
- `Glow_Center`
- `Glow_Main`
- `Smoke_Main`
- `Smoke_Top`
- `Pieces_Top_Glow`
- `Pieces_Top_Dark`

但其中部分发射器当前处于禁用状态，因此本帧的核心工作明显集中在 `Center_Lightnings`。

`Center_Lightnings` 当前展开的堆栈可确认包括：

- `Emitter State`
- `Spawn Rate`
- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Solve Forces and Velocity`
- `Particle State`
- `Scale Sprite Size`
- `Sprite Rotation Rate`
- `Sprite Renderer`

右侧当前展开的是 `Sprite Rotation Rate`，其 `Rotation Rate` 使用 `Random Range Float`：

- `Minimum = -50.0`
- `Maximum = 50.0`
- `Evaluation Type = Spawn Only`
- `Delta Time = ENGINE.DeltaTime`

顶部标签还能看到当前使用的材质实例与纹理资源：

- `MI_Lightnings_Blue_01`
- `T_LightingShape_2x2`

结合字幕 “Rotation and scaling. I will leave forces.”，可确认这一段的复现要点是：把中心效果转移到闪电贴图后，继续保留粒子受力逻辑，同时通过随机旋转和尺寸缩放，让每次生成的闪电片段方向和姿态都略有不同，避免中心电弧完全重复。

### 00:04:53-00:07:48 UV、颜色

- 本段定位：UV、颜色。
- 知识点：把它们在同一个软件上。
- 知识点：可以选择选择选择的位置。
- 知识点：你还是可以这样做。
- 知识点：现在我们放在这里。
- 知识点：它会是什么? 需要把它当作一张图像。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧是在关卡 `Stylized_Wisps` 中把新系统 `NS_Wisp_Lightning` 和旧系统 `NS_Wisp_Fire` 放到同一场景里做空间对齐。当前画面中，右侧 `Outliner` 同时可见两个 Niagara Actor：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`

当前右侧 `Details` 面板仍显示 `NS_Wisp_Fire (Instance)`，可确认其世界空间变换为：

- `Location = (-140.0, 544.827, 190.550)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

当前空间合同可压缩表达为：

- `subject`：`NS_Wisp_Lightning` 与 `NS_Wisp_Fire` 两个 Niagara Actor 的场景对齐关系
- `dimension`：三维世界空间
- `Fsemantic`：以关卡地面和平视视角为依据的“同一平面、相近位置”语义
- `Fread/Fverify`：Unreal 关卡世界空间与当前视口可见结果
- `conversion_chain`：用户语义“对齐到同一平面” -> 关卡 Actor 世界坐标写入/复制 -> 视口与 Details 面板读回确认

左侧视口中，旧火焰 wisp 和新蓝色闪电片段已经被摆到同一地面高度附近，字幕也明确说明：`对齐它们，复制这个位置，粘贴到这里，以便它们在同一平面上。` 因此本帧的关键不是调材质参数，而是先把 lightning 版本移动到与 fire 版本可直接比较的位置，再继续调颜色和形状。

下方内容浏览器位于 `VFX_Library/Niagara/Wisps`，当前可见并高亮的两个系统资源是：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`

这说明教程此时已经完成系统复制，并开始用场景级对齐来做新旧版本对照。
这一帧开始为 `NS_Wisp_Lightning` 选择更适合闪电/能量束的纹理形状。右侧 `Outliner` 当前选中的是 `NS_Wisp_Lightning`，`Details` 面板可确认当前 lightning 实例的世界空间变换为：

- `Location = (-17.718, 350.0, 200.000)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Lightning`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

画面左侧能同时看到两个对照对象：

- 左边：旧的火焰 wisp，仍然是暖色火核加火环
- 右边：新的 `NS_Wisp_Lightning`，目前中心只有一小段蓝色电弧

下方内容浏览器切到 `VFX_Library/Textures/Shapes`，当前在大量 `Muzzle`、`Projectile`、线状能量纹理中选形。可确认当前高亮资源名为：

- `T_Projectile12`

字幕也明确说：`我们会把它当作一个弹丸……类似于这条线。` 这说明本段的实际思路不是继续用圆形火焰贴图染成蓝色，而是改用更细长、更方向性的线状/弹体纹理来表现闪电主体。

从当前画面可得出的复现要点是：

- `Fsemantic`：让 lightning 版本在与旧火焰同场比较时，看起来像细长电弧，而不是球状火团
- `Fwrite`：通过更换 `Textures/Shapes` 下的线状纹理来改变中心粒子的外轮廓
- `Fverify`：在同一关卡平面上肉眼比较火焰版与闪电版轮廓差异

当前截图只确认了正在挑选 `T_Projectile12` 这一类线状贴图，还不能确认它最终挂接到哪个材质参数或 Niagara 渲染器属性，因为这一帧未显示材质/渲染器细节。
这一帧回到 `NS_Wisp_Lightning` 系统，并在中心电弧基础上新增高亮闪光层 `Center_Flashes`。左侧预览里已经能看到多条蓝白色电弧叠加一组更尖锐的中心闪光片，说明 lightning 版本开始形成“电弧 + 中心爆闪”的双层结构。

当前系统中可见并启用的核心发射器包括：

- `Center_Flashes`
- `Center_Lightnings`

旧火焰系统遗留的 `FireRing_Main`、`FireRing_Scale` 等发射器仍可见，但当前不是本帧操作重点。

右侧当前选中的是 `Center_Flashes`，展开 `Initialize Particle` 可确认：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.2`
- `Lifetime Max = 0.3`
- `Color Mode = Direct Set`
- `Color = 白色`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 35.0`
- `Uniform Sprite Size Max = 45.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

`Center_Flashes` 的可见模块顺序还能确认：

- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Particle State`
- `Scale Sprite Size`
- `Sprite Rotation Rate`
- `Solve Forces and Velocity`
- `Sprite Renderer`

顶部标签显示当前中心闪光层使用的材质实例是 `MI_Flash_Blue_01`。字幕提到“看起来很酷，但我可能会换成另一种颜色图”，说明这一层已经达成基本亮度目标，后续仍可能继续调整蓝色映射或色带随机性，但本帧可确定的核心是：用短寿命、白色、`35-45` 尺寸的闪光精灵叠在电弧中心，制造瞬时背光和爆闪感。

### 00:07:58-00:12:35 Spawn

- 本段定位：Spawn。
- 知识点：现在我们需要光亮。
- 知识点：我们把这个拼出来 然后把它叫成这样。
- 知识点：需要把它当成一张图像。
- 知识点：一张图像是适合我们的。
- 知识点：因为它是光亮 它应该会比较常常在 pulsate。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Spawn`。

**关键画面：**

这一帧是在关卡中直接观察 `NS_Wisp_Lightning` 的当前中心闪电表现，并同时检查 lightning 材质实例的资源组织。右侧当前选中的是 `NS_Wisp_Lightning (Instance)`，其世界空间变换可确认：

- `Location = (-17.718, 350.0, 200.000)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Lightning`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

左侧视口中，lightning 版本已经表现为一组细长、分叉的蓝白色电弧，明显不同于火焰版的圆形火核。画面左边缘还露出一小段红橙火环，说明旧火焰实例仍在场景中作为对照。

下方内容浏览器位于 `VFX_Library/Materials/Instances/Wisps/Lightning`，当前只可见两张关键材质实例：

- `MI_Flash_Blue_01`
- `MI_Lightnings_Blue_01`

这说明本段的 `Spawn` 调整建立在两层中心资源已经就位的前提上：

- `MI_Lightnings_Blue_01` 负责电弧主体
- `MI_Flash_Blue_01` 负责中心爆闪或背光

字幕提到“看起来很酷，但我可能会换成另一种颜色图。随机的。” 因此当前画面可以确认：基本蓝色闪电形状已经成立，但颜色图/随机色带仍可能继续微调。
这一帧继续在 `NS_Wisp_Lightning` 中调中心闪光层 `Center_Flashes`，当前重点是确认 `Sprite Renderer` 使用的蓝色闪光材质和渲染器行为。时间轴约为 `8.63s`，左侧预览中中心只剩一小团偏蓝白的闪点，说明本帧更多是在看单层渲染器，而不是完整组合效果。

当前可见并启用的主要发射器包括：

- `Center_Flashes`
- `Center_Lightnings`
- `Glow_Main`

右侧当前选中的是 `Center_Flashes` 的 `Sprite Renderer`。可确认的渲染器设置如下：

- `Material = MI_Flash_Blue_01`
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
- `Sort Mode = None`
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Sub UV Blending Enabled` 未启用
- `Sub Image Size = (1.0, 1.0)`
- `Cast Shadows` 已启用
- `Sort Order Hint = 14`
- `Motion Vector Setting = Auto Detect`

结合字幕“因为它是闪电。如果有色彩图，那么一切都没问题。我们保留它”，可以确认 `MI_Flash_Blue_01` 在这一层已经被接受为中心闪光材质，不打算再换回暖色或无色版本。对复现而言，这一帧的关键是：`Center_Flashes` 用单张蓝色闪光材质、普通粒子朝向和较高的 `Sort Order Hint = 14`，保证中心爆闪能稳定叠在其他电弧和光晕层之上。
这一帧把旧火焰版和新 lightning 版并排放在同一场景里做强对比，同时继续在纹理库里寻找更适合 lightning 环形背光的形状。画面中可直接看到：

- 左侧：旧 `NS_Wisp_Fire`，仍是暖色火核加红橙火环
- 右侧：`NS_Wisp_Lightning`，中心变成蓝白色高亮闪光，外围开始出现一圈偏蓝紫的能量环

右侧 `Details` 面板当前对象是 `NS_Wisp_Lightning (Instance)`，其实例变换保持为：

- `Location = (-17.718, 350.0, 200.000)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Lightning`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

顶部标签表明 lightning 版本当前已经准备了至少 4 个材质实例：

- `MI_Flash_Blue_01`
- `MI_Glow_Blue_01`
- `MI_Lightnings_Blue_01`
- `MI_LightningRing_01`

这说明到本帧为止，lightning wisp 的分层已经从单个电弧扩展到：

- 中心电弧主体
- 中心闪光/背光
- 外围环形能量层

下方内容浏览器仍位于 `VFX_Library/Textures/Shapes`，但当前筛到的是一批 `T_Burst...` 资源，包含多种环形、放射状、花瓣状和爆闪纹理。字幕提到“我们再看看，也许会找到别的”，因此这一帧的关键是：为 `MI_LightningRing_01` 或其他 glow/ring 材质继续挑选更适合蓝色能量环的贴图，而不是停留在最初的火焰圆环资源上。

对复现而言，可用这一帧作为验收参照：如果章节方向正确，lightning 版本应当明显从暖色火球转成冷色能量体，并且至少要同时出现蓝白中心高光和偏蓝紫外圈，而不仅仅是把原火环改成蓝色。

### 00:12:35-00:17:34 速度、颜色

- 本段定位：速度、颜色。
- 知识点：但通常在工作上 可以有自己的准备 准备的颜色 和其他东西。
- 知识点：如果不是可能的 或没有这种颜色 那你就要自行创造。
- 知识点：如果我们有颜色, 我们就只需要 一个频道。
- 知识点：如果我们不需要颜色, 可以用RGB。
- 知识点：如果我们不想要颜色, 可以用颜色的颜色。
- 知识点：在这里, 他们追求我们 保留颜色。
- 知识点：如果我们现在 把颜色的颜色刷掉, 首先, 需要有这种一个屏幕。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这一帧继续在场景中对比旧火焰版和新 lightning 版，同时在 `Textures/Shapes` 里试不同的 `Burst`/环形纹理给 lightning 外圈使用。右侧当前对象仍是 `NS_Wisp_Lightning (Instance)`，可确认：

- `Location = (-17.718, 350.0, 200.000)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Lightning`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

左侧场景对照关系仍然明确：

- 左边是暖色的 `NS_Wisp_Fire`
- 右边是冷色的 `NS_Wisp_Lightning`

lightning 版本当前已经具备蓝白中心高光与偏蓝紫外圈，但教程仍在继续找更合适的环形形状，以避免外圈看起来还像火焰章节的圆环。

下方内容浏览器位于 `VFX_Library/Textures/Shapes`，当前筛到一组 `T_Burst...` 与若干 `T_Circle...` 资源。当前高亮选中并且顶部已打开的纹理是：

- `T_Burst048`

从缩略图可以看出，`T_Burst048` 是带有放射式亮点的环形/花瓣状贴图，比纯圆环多一些能量破碎感。结合字幕“我们再看看，也许会找到别的”，本帧的要点是：通过替换 `Burst` 类纹理，尝试让 lightning 外圈从平滑火环过渡到更像电能脉冲或爆闪花纹的轮廓。
这一帧打开 `MI_LightningRing_01` 材质实例，直接验证外圈能量环材质对 `T_Burst048` 的响应。左侧预览可以看到一个由白色亮片组成的断裂圆环，说明该材质已经不再是连续软边火环，而是更偏“电能脉冲碎环”的表现。

右侧 `Details` 面板当前可确认的实例参数如下。

全局标量参数：

- `Premultiply Color? = 0.0`
- `Use Colormap? = 0.0`

全局纹理参数：

- `Colormap = VFX_T_ColorMap_Blue_01`
- `T_Main = T_Burst048`

通用与材质覆盖设置：

- `Parent = M_UberMaterial`
- `Blend Mode = Additive`
- `Shading Model = Unlit`
- `Two Sided` 未启用
- `Dithered LODTransition` 未启用
- `Output Translucent Velocity` 未启用
- `Has Pixel Animation` 未启用
- `Enable Tessellation` 未启用
- `Preview Mesh = None`

字幕说明“去掉 premultiply，然后它不考虑颜色，她只考虑白色”，与当前参数能互相印证：`Premultiply Color? = 0.0` 后，这个 ring 材质更偏向直接利用贴图本身的白色亮度结构，再通过加色混合把它叠到场景里，而不是让预乘颜色主导外圈发色。

对复现而言，这一帧给出的关键设置是：

- 外圈材质实例使用 `T_Burst048` 作为主形状
- 颜色图保留蓝色版本 `VFX_T_ColorMap_Blue_01`
- 材质混合方式改为 `Additive`
- `Premultiply Color?` 关闭

这样得到的外圈会更像断裂电环，而不是完整柔光圆盘。
这一帧回到 `NS_Wisp_Lightning` 系统，开始把新的环形材质实际挂到“额外一层”外环发射器上。当前可见的主要外环发射器包括：

- `LightningRing_Main`
- `LightningRing_Main_Additional`

旧火焰系统里的 `FireRing_Scale` 仍然留在右侧，但当前处于禁用状态，说明教程已经不再依赖火焰章节的外环层，而是用独立的 lightning ring 发射器来重建外围轮廓。

右侧当前选中的是 `LightningRing_Main_Additional` 的 `Sprite Renderer`。可确认的渲染器设置如下：

- `Material = MI_LightningRing_02`
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
- `Sort Mode = None`
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 16`
- `Motion Vector Setting = Auto Detect`

左侧预览中能看到外圈只剩淡蓝色断裂光痕，说明这一额外环层的职责不是做主视觉中心，而是给 lightning wisp 增加第二层更轻、更散的外围电能痕迹。

字幕提到“这里我们替换。这个将是额外的”，与当前发射器命名和材质切换完全一致。对复现而言，本帧的关键是：主环之外再加一层 `Additional` 外环，并把其 `Sprite Renderer` 指向新的 `MI_LightningRing_02`，用更高的 `Sort Order Hint = 16` 把这层额外能量边缘稳定叠在合适位置。

### 00:17:34-00:19:31 颜色

- 本段定位：颜色。
- 知识点：但是你先要 改变α。
- 知识点：这就变得比较有趣。
- 知识点：可以做到 一个随机的圆形。
- 知识点：我们来看看这个颜色。
- 知识点：我们来看看这个材料。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧开始细调额外外环发射器 `LightningRing_Main_Additional` 的粒子初始化参数，不再只停留在材质替换层。左侧预览里可以看到一组淡蓝色断裂电弧片已经形成，但尺寸还偏大，字幕也直接说明要“先改大小”。

当前选中的是 `LightningRing_Main_Additional`，右侧 `Initialize Particle` 可确认：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.3`
- `Lifetime Max = 0.5`
- `Color Mode = Direct Set`
- `Color = 白色`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 100.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

当前系统中与外环相关的主要发射器可见为：

- `LightningRing_Main`
- `LightningRing_Main_Additional`

旧火焰层 `FireRing_Scale` 仍在旁边但保持禁用，说明教程此时是在 lightning 专用环层内部继续细调。

对复现而言，这一帧的关键信息是：额外环层先使用 `0.3-0.5` 的短寿命、白色直设颜色与单一统一尺寸起步，再根据预览决定把尺寸从过大的默认值往更合适的数值压缩。
这一帧从单个参数面板退回到系统结构视图，说明 lightning 外环层已经从单纯“附加一环”扩展成主环与缩放环两层组合。当前可见并启用的 lightning 相关发射器包括：

- `LightningRing_Main_...`（左侧，标题被截断）
- `LightningRing_Scale`

右侧还能看到旧火焰章节遗留的 `FireRing_ScaleBig`，但它被置灰禁用，说明 lightning 版本已经开始用自己的 `LightningRing_Scale` 取代旧火环的缩放层逻辑。

当前能从堆栈结构可靠确认：

- 左侧主 lightning ring 发射器包含 `Spawn Rate`、`Initialize Particle`、`Particle State`、`Sprite Rotation Rate`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer`
- 中间 `LightningRing_Scale` 发射器也包含类似的 `Initialize Particle`、`Particle State`、`Sprite Rotation Rate`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer`

时间轴播放头约在 `0.46s`，字幕提到：`Lightning ring. And there is also a lightning ring. Something else is pulsing.` 这与当前双环结构一致，说明教程正在把外圈分成至少两类行为：

- 一层负责主电环轮廓
- 另一层负责缩放/脉冲变化

本帧没有展开具体参数面板，因此不能可靠写出 `LightningRing_Scale` 的数值；但可以确认教程的结构方向已经从“单环替换”变成“多环叠加并带脉冲变化”。
这一帧继续细调 `LightningRing_Scale` 发射器的 `Initialize Particle`，目标是把脉冲外环做成更亮、更大、但仍有随机变化的能量层。当前系统中可见三层相关外环发射器：

- 左侧：`LightningRing_Main_...`（标题被截断）
- 中间：`LightningRing_Scale`
- 右侧：`LightningRing_ScaleB`

这说明 lightning 外圈已经被拆成主环、缩放环和另一层缩放变体，而不是单一的一个环。

右侧当前选中的 `LightningRing_Scale`，其 `Initialize Particle` 参数可确认如下：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.75`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Minimum`
  - `Red = 1.0`
  - `Green = 1.0`
  - `Blue = 1.0`
  - `Alpha = 0.1`
- `Color Maximum`
  - `Red = 1.0`
  - `Green = 1.0`
  - `Blue = 1.0`
  - `Alpha = 0.2`
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 125.0`
- `Uniform Sprite Size Max = 135.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

字幕提到“随机范围。改变颜色。增加透明度。也许太多了。” 结合当前参数，可以明确读出这里实际上是在调白色外环的透明度随机范围，而不是调色相本身，因为 RGB 两端都固定为 `1.0`，真正变化的是 Alpha 从 `0.1` 到 `0.2`。同时尺寸已经被放大到 `125-135`，说明这一层就是为了形成更大、更柔的脉冲外圈。

### 00:21:26-00:24:17 关键流程 06

- 本段定位：关键流程 06。
- 知识点：它们不会往上挤,在边缘上,可能会掉落 不错 我们有针针,很棒的加针针 我们叫它中心链 链子链的光影 它们会随机地出现 它们会更小 我还会调整亮度。
- 知识点：随机地出现 α0.1 0.3 位置链需要叫做链子链 可能需要做更多 出现的数量是40或50 我们看看结果。

**关键画面：**

这一帧切回 `Smoke_Main` 发射器，但它现在服务于 `NS_Wisp_Lightning`，不再是暖色火焰烟雾，而是作为蓝色/深色能量残影层存在。左侧预览可见中心是蓝白色闪电核心，外侧有一圈更暗、更淡的蓝色能量雾带。

当前选中的是 `Smoke_Main` 的 `Initialize Particle`，可确认其可见模块结构包括：

- `Spawn Rate`
- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Add Velocity`，模式可见为 `Linear`
- `Scale Velocity`
- `Solve Forces and Velocity`
- `Particle State`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Renderer`

`Initialize Particle` 当前可确认参数：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`

当前打开的是颜色选择器，正在编辑较深的蓝色端。颜色选择器可确认的新颜色值为：

- `R = 0.039021`
- `G = 0.06662`
- `B = 0.884673`
- `A = 0.5`
- `Hex Linear = 0A11E280`
- `Hex sRGB = 3849F280`

字幕提到“这里会变黑。然后它会掉下来。速度。加上重力。” 这说明本段意图是把这一层做成更暗、更重、会下落的能量烟雾，而不是继续向上飘散的火焰烟。当前截图能直接证明的部分是：`Smoke_Main` 颜色已开始向深蓝色迁移，并且这一层仍保留 `Add Velocity` 与 `Scale Velocity`，为后续加入下落运动做准备。
这一帧切到 `Pieces_Top_Glow`，教程暂时保留这层顶部亮碎片，并通过分布与动画设置让它继续向上飞散，作为闪电核心周围的附加能量粒子。时间轴约为 `2.43s`，左侧预览中中心蓝白亮点上方仍可见一些向上散开的细小能量痕迹。

`Pieces_Top_Glow` 当前可见模块结构包括：

- `Spawn Rate`
- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Shape Location`，模式可见为 `Sphere`
- `Add Velocity`，模式可见为 `Linear`
- `Gravity Force`
- `Drag`
- `Solve Forces and Velocity`
- `Particle State`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Renderer`

右侧当前展开了两块设置：

`Sub UVAnimation`
- `SubUV Animation Mode = Random`
- `Start Frame Range Override = 0`
- `End Frame Range Override = 3`
- `Renderer Type = Sprite`
- `Animation Evaluation Type = Every Frame`

`Shape Location`
- `Shape Primitive = Sphere`
- `Sphere Radius = 25.0`
- `Sphere Distribution = Random`
- `Sphere Surface Distribution = 0.0`
- `Hemisphere Distribution = (1.0, 1.0)`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`
- `Offset Mode = None`

字幕明确说“它们飞了起来。你可以留下这个”，这与当前 `Shape Location + Add Velocity + Gravity Force + Drag` 的组合相符：教程决定保留顶部亮碎片作为向上飞散的变化层，而不是把所有附加粒子都改成下坠或变暗。
这一帧新增并选中发射器 `Sphere_Lightnings`，它看起来是用来在中心附近再补一层球形分布的闪电片段或能量碎片。时间轴约为 `0.07s`，当前系统里可见并启用的核心发射器包括：

- `Center_Flashes`
- `Center_Lightnings`
- `Glow_Center`
- `Glow_Main`
- `LightningRing_Main`
- `LightningRing_Main_Additional`
- `LightningRing_Scale`
- `LightningRing_ScaleB`
- `Sphere_Lightnings`

右侧当前展开的是 `Sphere_Lightnings` 的 `Shape Location`。可确认的分布参数如下：

- `Shape Primitive = Sphere`
- `Sphere Radius = 25.0`
- `Sphere Distribution = Random`
- `Sphere Surface Distribution = 0.0`
- `Hemisphere Distribution = (1.0, 1.0)`

变换相关设置：

- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`

从堆栈可见 `Sphere_Lightnings` 还包含：

- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Particle State`
- `Scale Sprite Size`
- `Sprite Rotation Rate`
- `Solve Forces and Velocity`
- `Sprite Renderer`

这说明这一层不是外围电环，而是围绕中心位置在半径 `25` 的球形范围内随机分布闪电元素，用来增加中心区的体积感和随机性。与前面的线状中心电弧相比，`Sphere_Lightnings` 更像是把电光碎片散布到一个小球体空间里，避免中心只剩单平面轮廓。

### 00:24:31-00:29:18 速度、颜色

- 本段定位：速度、颜色。
- 知识点：链子链的变化 可能可以让烧焰更暗 让它们在开始时调整速度 所以它们不会往下飞 你也可以在这里增加 让它亮面 力量 可能需要加速度。
- 知识点：随机地出现 需要设置数字 它会往下降 需要把数字改变 看起来很棒 可能需要改变原型 让它更大 问题是它太快 可能需要调整形状 我认为它太暗 需要改变颜色。
- 知识点：需要加一点反光 我真的不喜欢中间 链子链 可以让链子链更亮 你要跟细节一起玩 它很大 我可以在这里 不 这里是最高的 不 150 170 我正在看它是如何看起来。
- 知识点：问题是我看到链子链 我们需要在链子链的 出现预计比烧焰更大 在这种情况下 烧焰是双重的 它应该是更有火力 但更有灯光 可以增加到 170 200。
- 知识点：这是我们的问题 因为是有灯光 需要在它中加一盘反光 可以加暗光 但需要改变模具 需要改变一些调整 反光转折和重量力 在轻形位置上拼了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这一帧开始细调 `Sphere_Lightnings` 的生成密度，让中心球形电弧层更亮、更稳定。左侧预览可见中心仍是一组蓝白色电弧片，外围保留淡蓝能量雾与电环；右侧当前选中的是 `Sphere_Lightnings` 的 `Spawn Rate`。

可确认的发射率参数：

- `SpawnRate = 150.0`
- `Spawn Probability = 1.0`

当前系统中同时可见的相关发射器包括：

- `Center_Flashes`
- `Center_Lightnings`
- `Glow_Center`
- `Glow_Main`
- `Smoke_Main`
- `Pieces_Top_Glow`
- `Sphere_Lightnings`

字幕说明“这样它就不会尝试飞下来。你也可以在这里增加它，这样它就会亮。” 与当前 `SpawnRate = 150.0` 一致，说明这一层不是单靠颜色变亮，而是通过增加生成量让球形中心电弧更密、更亮，从而增强 lightning 核心的可读性。
这一帧把重点切到 `Glow_Main`，开始直接调中心大面积发光盘的尺寸与亮度。左侧预览中，蓝白色中心高光明显比前几帧更大，外围仍保留淡蓝环形脉冲和少量电弧碎片。

当前选中的是 `Glow_Main` 的 `Initialize Particle`。可确认参数如下：

- `Lifetime Mode = Direct Set`
- `Lifetime = 0.5`
- `Color Mode = Direct Set`
- `Color = (R 1.0, G 1.0, B 1.0, A 1.0)`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 150.0`
- `Uniform Sprite Size Max = 200.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

字幕提到“这里非常大。不，150，170。我在看他长什么样”，说明这一层的主要调节就是观察不同大尺寸发光盘对中心亮度和体量的影响。当前面板已经显示到 `150-200` 的区间，说明教程在把 `Glow_Main` 做成一个足够大的纯白背光盘，再依赖材质和后续颜色映射把它读成冷色闪电能量核，而不是直接用彩色值去堆亮度。
这一帧是在 `NS_Wisp_Lightning` 系统中做一次整体层级复核，确认中心闪电、双环、发光盘与顶部碎片已经能共同工作。左侧预览可见：

- 中心有强烈的蓝白闪光核
- 核心周围仍保留数条细长电弧
- 外侧有淡蓝色大范围光晕与更暗的外围电环

当前画面中可见并启用的主要发射器包括：

- `Center_Flashes`
- `Center_Lightnings`
- `Glow_Center`
- `Glow_Main`
- `LightningRing_Main`
- `LightningRing_Main_...`（第二个主环标题被截断）
- `LightningRing_Scale`
- `Pieces_Top_Glow`
- `Pieces_Top_Dark`

右侧当前选中的是 `Pieces_Top_Dark`，其 `Spawn Rate` 参数可确认：

- `SpawnRate = 10.0`
- `Spawn Probability = 1.0`

这说明顶部暗色碎片层在 lightning 章节里被保留为非常弱的一层，只负责增加少量深色细节，不再像火焰章节那样占据较大视觉比重。

字幕提到“中间的闪电在那里。一切都很酷。” 与当前总览吻合，因此本帧可以作为中间验收标准：如果复现正确，`NS_Wisp_Lightning` 应该已经同时具备中心闪电、中心闪光、大范围蓝色 glow、主外环/脉冲环，以及被压到较低密度的顶部碎片层；其中 `Pieces_Top_Dark` 这类深色附层不应抢过中心闪电的视觉焦点。

### 00:29:18-00:31:48 关键流程 08

- 本段定位：关键流程 08。
- 知识点：可能是50和25 再加到75 我可能会增加 这个是编号 是的 这个灯光是主要的 我不知道如果我给它27 或者 不 或者14 这些加的 大概21 因为我。
- 知识点：只是记不起多少 这里有16 这里有15 这里有14 让它 可以甚至把灯光 灯光扣在这里 甚至有些灯光 再加上其他东西 所以是褐色的 如果当然会有效果。
- 知识点：你就可以玩了 可以把它放在这里 一点点 或者 可以用 编号 色彩 编号 色彩 用线色的编号 是的 让我们一样放在一起 是的 这样它不会在背面 有什么影响。
- 知识点：是灯光 一切 只有色彩 是的 最开始是褐色 所以是直的 是的 25 最后它回到 正常的价值 嘣 也就是 可以用这些 需要把它放在这里 这就交给你了。
- 知识点：所有 我们是这样 制造了灯光的编号 我们是这样用SAPIVI 是的 特别是灯光编号 这种东西 非常地酷 用SAPIVI的帮助 在这里 这就是所有 在下一个视频里 再见。

**关键画面：**

这是 `NS_Wisp_Lightning` 的系统总览调参画面，当前选中发射器为 `Sphere_Lightnings`。右侧 `Details` 面板打开的是该发射器 `Emitter Update` 下的 `Spawn Rate` 模块，当前可确认参数如下：

- `SpawnRate = 75.0`
- `Spawn Probability = 1.0`

画面左侧预览中，中心蓝白色闪电核已经形成，外围还有较淡的蓝色环形辉光。结合本段上下文，这一步是在继续增加中心球形闪电层的生成量，让中心亮部更密、更亮。字幕还提到“可能还会增加它的排序顺序”，但当前截图没有显示 `Sort Order Hint` 或其他排序字段的具体位置与数值，因此本条只能确认生成率已提升到 `75`，排序相关设置需以后续画面为准。
这张图展示的是成品实例在场景中的颜色微调，而不是 Niagara 模块编辑。场景里同时摆放了两个效果实例：左侧是偏橙红色的火焰版，右侧是偏蓝白色的闪电版；当前选中的对象是 `NS_Wisp_Lightning`，屏幕中央打开了 Unreal 的 `Color Picker` 用来继续调整颜色。

当前颜色选择器中能直接确认的参数为：

- `R = 11.181175`
- `G = 0.0`
- `B = 25.0`
- `A = 0.3`
- `H = 266.834808`
- `S = 1.0`
- `V = 25.0`
- `Hex Linear = FF00FF4D`
- `Hex sRGB = FF00FF4D`

从色轮与预览条可见，这一步是在把颜色保持在高饱和的紫蓝区，用于给闪电版本继续试不同的发光色结果。截图没有显示该颜色具体写入的是哪一个材质参数名，也没有展示保存后的最终命名，因此这里能可靠确认的是：作者正在通过颜色选择器直接试配 `NS_Wisp_Lightning` 的整体发光色，并与左侧火焰版成品进行肉眼对比。
这张图展示的是材质实例 `MI_Glow_Blue_01` 的参数面板，用来确认闪电中心蓝色 glow 所依赖的贴图和材质混合属性。当前在 `Details` 面板中可以直接读取到以下内容：

- `Global Scalar Parameter Values`
- `Use Colormap? = 1.0`

- `Global Texture Parameter Values`
- `Colormap = VFX_T_ColorMap_Blue_01`
- `T_Main = T_Glow3`

- `General`
- `Parent = M_UberMaterial`

- `Material Property Overrides`
- `Opacity Mask Clip Value = 0.3333`
- `Blend Mode = Additive`

结合画面中央的场景预览，这个材质实例表现为一个柔和的蓝色发光团，用于支撑闪电效果的中心辉光层。截图中没有展开更多高级参数，也没有显示具体把它挂到哪一个 Niagara 发射器或哪一个材质槽位上，因此本图可可靠复建的信息是：蓝色 glow 材质通过 `T_Glow3` 作为主纹理、`VFX_T_ColorMap_Blue_01` 作为色图，并以 `Additive` 方式叠加到最终画面中。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


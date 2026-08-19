# 01 Explosion Vfx Breakdown

# 01 Explosion Vfx Breakdown

## 关键术语

- `Emitter`、`Spawn`、`Update`、`Emitter Update`、`Lifetime`、`Color`、`Alpha`、`Dynamic Parameter`、`Material`、`UV`、`Add`、`Niagara`、`Texture`、`Blueprint`、`Niagara System`、`Particle`、`Spawn Rate`、`Initialize Particle`

## 分段知识

### 00:00:05-00:04:54 Add

- 本段定位：Add。
- 知识点：蓝图 Actor 用于封装 Niagara 生成、位置、参数传入和生命周期控制。
- 知识点：火焰或爆炸需要拆分亮核、烟雾、余烬和冲击层，再用颜色与透明度曲线统一节奏。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。；火焰或爆炸需要拆分亮核、烟雾、余烬和冲击层，再用颜色与透明度曲线统一节奏。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Lifetime`、`Blueprint`、`Add`、`材质`、`蓝图`、`生命周期`、`颜色`。

**关键画面：**

这一帧切到外部体积特效工具的节点界面，用来制作并导出爆炸/烟火用的 flipbook 资源。左侧是体积爆炸预览，右侧是从噪声、颜色、光照到相机和导出节点的完整渲染链，最终导出到 `Export Flipbooks and L...` 节点

- 当前预览结果
  左侧视口中可见一团由多个鼓起烟团构成的体积爆炸
  爆炸内部有明显橙红色发光裂缝，外壳偏暗，说明这是为 stylized 爆炸准备的体积火焰/烟雾素材
- 当前工程与渲染概况
  顶部标题可见工程名 `StylizedExplosion.ember`
  左侧统计里可见
  `Bounds = 512x256x512`
  `Voxels = 67.1 Mvox`
  `Resolution = 1430x1080`
  `Render Time = 40.4 ms`
  `Particles = 0`
- 节点定义集
  多个 `Force: Noise`
  多个 `Color: Gradient`
  `Light: Directional`
  `Simulation`
  `Volume Processing`
  `Shading`
  `Camera`
  `Scene`
  `Export Flipbooks and L...`
- 连线集
  多个 `Force: Noise` 先汇入一个用于细节遮罩的分组
  颜色相关梯度节点汇入 `Shading`
  `Light: Directional` 连接到 `Shading.Lights`
  `Simulation` 的体积结果连接到 `Volume Processing`
  `Volume Processing`、`Shading` 与 `Scene` 一起连接到 `Camera`
  `Camera` 输出再连接到最终的 `Export Flipbooks and L...` 导出节点
- 导出/渲染设置
  下方面板位于 `Render > Render Passes`
  可见多组输出映射
  `Render All`
  `Alpha`
  `Smoke`
  目标通道包含 `RGBA` 与分离的 `R/G/B/A`
  说明作者不是只截图预览，而是在准备把体积效果拆分为可用于后续 VFX 的贴图/flipbook 通道
- 这张图对复建的意义
  本篇从这里开始不再只在 Unreal 内调 Niagara，而是转向外部资产制作
  关键思路是先在外部工具里把爆炸体积、颜色和光照烘成可导出的 flipbook，再回到引擎里作为材质或粒子资源使用
这一帧继续在外部体积特效工具中调 stylized 爆炸的渲染风格。作者打开 `Scene > Style` 页，对描边、量化和抖动参数做风格化处理，让爆炸体积既保留烟团轮廓，又具有更明显的插画/卡通化层次

- 当前预览结果
  左侧仍显示多团烟球组成的体积爆炸
  内部橙红裂缝更清晰，外壳边界更偏硬朗，说明风格化参数已经影响到视觉轮廓
- 当前 `Scene > Style` 可见参数
  `Rendering style = Colored Thin Strokes`
  `Flow smoothness = 0.500`
  `Strokes length = 15.000`
  `RGB quantization = 45`
  `Hue quantization = 64`
  `Value quantization = 64`
  `Saturation quantization = 64`
  `Quantization dither = 0.150`
  `Dithering mode = Bayer 2x2`
  `Translucency limit = 0.500`
  底部还能看到 `Remapping style = None`
- 当前工程与时间线
  工程标题仍为 `StylizedExplosion.ember`
  时间线停在约 `0.750 / 45`
  左下可见模拟参数
  `Velocity dissipation = 95.000 u/s`
  `Smoke dissipation = 10.10 units/s`
  `Flames dissipation = 0.298 units/s`
  `Shading > Density reference = 0.459`
- 字幕可确认的讲解意图
  英文字幕为 `That's it. I added a lot of details here. If you don't like it, you can delete it. I like this.`
  可确认这些风格参数属于“细节强化层”，不是绝对必要骨架，可以按风格偏好增减
- 这张图对复建的意义
  外部爆炸资产并不是只看物理模拟结果，还会通过 style 参数做风格化后处理
  如果想得到更贴近教程的 stylized 外观，需要同时控制
  描边风格
  颜色量化
  抖动模式
  半透明限制
这一帧切到外部体积特效工具的预设库主页，说明作者并不是从空白场景硬搭所有体积效果，而是会先从预设库里挑选接近目标风格的火焰、烟雾或爆炸资源，再进入节点与渲染页继续修改

- 当前页面结构
  左侧导航包含
  `Home`
  `Learn`
  `Presets`
  `My Projects`
  顶部有 `New Project`、`Open Project`
- 当前预设筛选
  顶部分类可见
  `All`
  `Fire & Smoke`
  `Fire`
  `Smoke`
  `Explosion`
  `Magic`
  `Particles`
  以及显存筛选 `8 GB`、`24 GB`
- 当前可见预设示例
  `73 Nebula`
  `73 Nebula 02`
  `73 Nebula 03`
  `Aerial Explosion 1`
  `Aerial Explosion 2`
  `Aerial Explosion 3`
  `Aerial Explosion 4`
  `Aerial Explosion 5 Massive`
  `Artillery Explosion 1`
  `Artillery Explosion 2`
  `Battle Ship Muzzle Flash`
  `Battle Ship Muzzle Flash 2`
  `Blendergen Donut`
  `Bubbling Swamp`
  `Bubbling Water`
  `Bullet Impact Concrete`
  `Candle Flame`
  `Cannon Explosion`
  `Cannon Explosion 2`
  `Cannon Explosion 3`
- 这张图对复建的意义
  外部资产制作流程的起点往往是“选一个足够接近的 preset”
  对教程这种 stylized 爆炸而言，`Explosion` 类预设明显是主要参考来源
  后续再通过节点、风格面板和导出设置，把预设改造成最终可用于 Niagara 的 flipbook 资源

这张图的核心信息，是把“外部资产制作与导入”拆成了一个更现实的工作流：先选预设，再定制，而不是完全从零开始做体积爆炸

### 00:04:54-00:09:45 Color、Material、Normal

- 本段定位：Color、Material、Normal。
- 知识点：火焰或爆炸需要拆分亮核、烟雾、余烬和冲击层，再用颜色与透明度曲线统一节奏。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：蓝图 Actor 用于封装 Niagara 生成、位置、参数传入和生命周期控制。
- 知识点：参考素材应按效果类型、颜色、运动方式和用途打标签，便于后续复现 VFX 风格。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Decal` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`Blueprint`。

**关键画面：**

这一帧继续在外部体积特效工具中微调 stylized 爆炸。作者说明自己关掉了一些内容、修改了一些数值，用来重塑爆炸的色彩、材质质感和明暗结构

- 当前预览结果
  左侧仍是由多个烟团组成的球状爆炸
  与前面相比，暗部更重，橙红裂缝更集中，烟团边界更厚，说明作者正在收紧亮部、强化体积块面感
- 当前节点链可见部分
  `Force: Noise`
  `Emitter: Volume`
  `Color: Gradient`
  `Light: Directional`
  `Simulation`
  `Volume Processing`
  `Shading`
  `Camera`
  `Scene`
  `Export Flipbooks and...`
  说明这一步仍在围绕外部体积节点链调节，而不是回到 Unreal 材质
- 当前时间线与关键参数
  时间线播放头位于约 `1.226 / 74`
  左下可见的模拟参数包括
  `Velocity dissipation = 95.000 u/s`
  `Smoke dissipation = 2.000 units/s`
  `Flames dissipation = 1.000 units/s`
  `Shading > Density reference = 0.487`
  时间线上存在多组菱形关键帧，说明这些 dissipiation / shading 类参数随时间有动画调节
- 节点说明区可见文本
  节点说明文字提到通过粒子注入额外燃料，并在体积发射器中点燃，以形成热点、压力点和烟尾
  这说明当前 explosion 资源不只是静态体积，而是依赖粒子注入与点燃机制形成内部细节
- 字幕可确认的讲解意图
  英文字幕为 `I edited, turned something off... I disabled edited some values.`
  可确认这一段主要是在做删减和数值取舍，而不是新增全新模块

这张图对复建的意义，是提醒读者：外部体积爆炸的最终外观来自持续的“开关取舍 + 数值收紧”，尤其是耗散和密度参考类参数会显著影响烟团的厚度、裂缝亮度和整体材质感
这一帧回到 Unreal 里检查地面裂缝材质。作者明确指出之前少了视差效果，于是重新编辑材质，把“视差感”和 decal 贴花结合起来，让地面裂缝不再只是平面白斑，而是具有更强的体积错觉

- 当前场景与资源
  顶部标签可见
  `Blueprint_Explosion_ST...`
  `NS_StylizedExplosion`
  `MI_GroundCrack_01`
  `M_GroundCrack`
  Outliner 中可见 `NS_Stylized...` 与被选中的 `Sphere`
  `Content Browser` 当前路径在 `VFX_Library > Niagara > Explosion_Stylized`
  目录内可见
  `NS_Missile`
  `NS_Placeholder`
  `NS_SmokeTrail`
  `NS_StylizedExplosion`
- 当前被选中对象
  右侧 `Details` 为 `Sphere (Instance)`
  `Location = (150.0, -415.0, -188.0)`
  `Scale = (5.0, 5.0, 5.0)`
  这是一个辅助球体/测试体，用来观察 decal 和视差材质在表面上的表现
- 当前可见结果
  视口中央能看到一块非常亮的白色椭圆形贴花投射在地面/表面上
  画面上还可见一个大圆形作用范围轮廓，说明作者在近距离检查贴花覆盖区域
- 字幕可确认的讲解意图
  英文字幕为 `I edited the materials a little... We didn't have parallax, now it will be volumetric. This crack is voluminous... it's a decal. I combined parallax and decal.`
  可确认这一步的核心不是改 Niagara 生成，而是改地面裂缝材质
  将 `parallax` 与 `decal` 结合，给裂缝增加体积感
- 这张图对复建的意义
  地面裂缝层不应只依赖平面颜色/遮罩
  如果想更接近教程效果，需要在 decal 材质里加入视差类深度错觉，让裂缝边缘和内部层次更像“陷进去”或“撑开”的体积结构
这一帧打开了裂缝贴图 `T_Crack_RGB` 的纹理查看器，并直接说明多通道打包的用途。作者把不同功能拆到 `R/G/B/A` 通道中，用一张纹理同时承载裂缝形状、透明度/颜色和照明相关信息

- 当前纹理资源
  顶部标签显示当前打开对象为 `T_Crack_RGB`
  右侧 `Details` 可见
  `Imported = 2048x2048`
  `Displayed = 2048x2048`
  `Max In-Game = 2048x2048`
  `Has Alpha Channel = True`
  `Format = BC7`
  `Texture Group = World`
  `Compression Settings = BC7 (DX11, optional A)`
  `sRGB` 已启用
- 当前查看通道
  顶部通道按钮 `R G B A` 中，`G` 当前被高亮
  画面中央显示一张放射状裂缝图案，中心极亮，裂缝向外分叉扩散
- 字幕可确认的通道分工
  英文字幕为 `This is the first R channel used. G is used for transparency and color. Here is the second channel. And the last channel is used for lighting.`
  可确认
  `R` 通道单独承担第一类功能
  `G` 通道用于 `transparency and color`
  最后一个通道用于 `lighting`
  结合常见 RGB 打包方式，可以判断这张纹理是专门为裂缝 decal/材质打包的多用途贴图
- 这张图对复建的意义
  裂缝贴图不是简单的单灰度遮罩
  教程通过通道打包把多个材质控制信号压进一张 `T_Crack_RGB`
  在材质里复建时，应按通道分别解包，再接到透明度、颜色和照明相关输入，而不是把整张图只当作单一 alpha 使用

### 00:09:45-00:14:43 Spawn、Color、Alpha

- 本段定位：Spawn、Color、Alpha。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Spawn`、`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`Dynamic Parameter`、`User Parameter`。

**关键画面：**

这一帧打开的是地面裂缝材质 `M_GroundCrack` 的总览图。作者把材质拆成多个清晰分组，其中可直接看见 `Parallax UV`、`Decal Texture` 和 `Opacity` 三个关键模块，并把 `T_Crack_RGB` 作为 `DecalTexture` 参数接入

- 当前材质与参数
  顶部标题显示为 `M_GroundCrack > Material Graph`
  左侧 `Details` 当前选中的是纹理参数节点
  `Parameter Name = DecalTexture`
  `Group = Decal`
  `Sort Priority = 32`
  `Texture = T_Crack_RGB`
  `Sampler Type = Color`
- 材质图分组
  画面中能清楚看到多个独立框选区域
  `Parallax UV`
  `Decal Texture`
  `Opacity`
  左下还有一组负责主色和附加颜色计算的节点区
- 可确认的材质结构
  `Decal Texture` 分组中以红色裂缝纹理节点为核心，并向右连接多组颜色和贴花相关节点
  `Parallax UV` 分组是单独的 UV/视差处理区，说明教程把视差错觉从贴图采样链中拆出来单独管理
  `Opacity` 分组独立存在，说明透明度不是直接写死在颜色链里，而是有专门的遮罩或溶解控制
- 左侧预览结果
  左侧预览显示一个发白的放射状裂缝高亮图案，中心更亮，边缘向外裂开
  说明当前材质已经把裂缝形状和高光轮廓组合在同一张 decal 里
- 字幕可确认的讲解意图
  英文字幕为 `Let's quickly look at the material. This is where dissolve comes in... This is a card that we can apply on top to give an additional color.`
  可确认教程此处在检查 dissolve 所在位置，并额外叠加一张 card 来补颜色层

复建这张材质时，重点是把 `T_Crack_RGB` 作为核心 decal 纹理，再将视差 UV、贴图采样和透明度控制拆成独立模块，而不是把所有逻辑混在一条线里
这一帧放大了 `M_GroundCrack` 的 `Parallax UV` 分组，展示了如何从 `T_Crack_RGB` 里选主高度通道，并通过 `MF_DecalParallaxOcclusionMapping` 生成 decal 的视差 UV

- 节点定义集
  `DecalTexture` 纹理参数节点
  一个名为 `Decal Texture` 的输出或中转节点
  `HeightRatio` 标量参数
  常量 `64`
  常量 `128`
  `Ref Plane` 标量参数
  `HeightmapChannel` 向量参数
  `Append`
  `MF_DecalParallaxOcclusionMapping`
  一个名为 `Parallax UV` 的输出或中转节点
- 连线集
  `DecalTexture` 的纹理对象输出连接到 `MF_DecalParallaxOcclusionMapping.Heightmap Texture (T2d)`
  `HeightRatio` 连接到 `Height Ratio (S)`
  常量 `64` 连接到 `Min Steps (S)`
  常量 `128` 连接到 `Max Steps (S)`
  `Ref Plane` 连接到 `Reference Plane (S)`
  `HeightmapChannel` 的分量经 `Append` 组合后连接到 `Heightmap Channel (V4)`
  材质函数输出的 `Parallax UVs` 连接到右侧 `Parallax UV` 节点
- 可确认参数
  `HeightRatio.Default Value = 0.08`
  `Ref Plane.Default Value = 1.0`
  `HeightmapChannel.Default Value = (R=1.0, G=0.0, B=0.0, A=0.0)`
  说明当前默认把 `R` 通道作为高度主通道
- 材质函数可见输出
  `Parallax UVs`
  `Offset Only`
  `Shadow`
  `Pixel Depth Offset`
  `World Position Offset`
  `Tangent Light Vector`
  `Material Complexity - Steps Debug`
- 字幕可确认的讲解意图
  英文字幕为 `Here RGB, combined RGB and alpha... choose which channel will be our main one... Now I will show how I pass UV parallax coordinates.`
  可确认这一步的关键是从 `RGBA` 多通道贴图中挑选主高度通道，再把生成出的视差 UV 坐标传递到后续贴图采样链

复建这一段时，先把 `T_Crack_RGB` 作为高度图源，再通过 `HeightRatio`、`Min Steps`、`Max Steps`、`Ref Plane`、`HeightmapChannel` 驱动 `MF_DecalParallaxOcclusionMapping`，最后把 `Parallax UVs` 单独输出给后续 decal 采样使用
这一帧回到关卡中检查 `NS_StylizedExplosion` 的地面裂缝结果。可以直接看到视差 decal 已经不是纯平面贴花，而是带有明显内发光、边缘抬起错觉和深浅层次的体积裂缝

- 当前对象
  Outliner 中选中对象为 `NS_StylizedExplosion`
  右侧 `Details` 显示 `NS_StylizedExplosion (Instance)` 与 `NiagaraComponent0`
  `Niagara System Asset = NS_StylizedExpl...`
- 当前可见效果
  地面中央是一个橙色高亮的爆心
  多条裂缝从中心向外放射，边缘存在明显明暗过渡
  裂缝两侧不是平涂，而是形成了向内陷或向上翘的视觉错觉
  画面边缘还能看到零散的小裂口和高亮点，说明 decal 并不只是一块中心圆斑
- 当前资源上下文
  `Content Browser` 路径位于 `VFX_Library > Materials > Functions`
  当前高亮的是 `MF_Decal Parallax`
  同目录还能看到 `MF_Chromatic Aberration`、`MF_SceneBlur`、`MF_Smooth Dissolve`、`MF_Texture Crop`
  说明裂缝材质所用的视差逻辑已经被整理成可复用的材质函数
- 这张图对复建的意义
  前面 `M_GroundCrack` 中加入的 parallax 不是抽象理论，而是直接让地面裂缝获得了更厚的边缘和更深的中心层次
  如果复建后画面仍像普通贴图贴在地面上，就说明 `MF_Decal Parallax` 链或裂缝通道连接仍不到位

这张图可以作为当前阶段的结果验收图：理想状态下，裂缝应同时具备放射形状、橙色内部发光和明显的视差体积感

### 00:14:43-00:19:42 Emitter、Spawn、Update

- 本段定位：Emitter、Spawn、Update。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter`、`Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Decal` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter`、`Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Opacity`、`Decal`、`Emissive` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Emitter`、`Spawn`、`Emitter Update`、`Color`、`Alpha`、`Opacity`、`Material`、`Texture`。

**关键画面：**

这一帧仍在 `M_GroundCrack` 材质图里，但视角已经切到控制裂缝生成、散布和发射器更新背光分布的位置。字幕明确说明，这一组参数负责 `spawn`、`scattering` 和 `emitter update` 阶段的 backlight 散布

- 节点定义集
  `DP_Show` 标量参数
  `Decal Show Gradient` 标量参数
  一个 `1-x` 反相节点
  `ShowBorderWidth` 标量参数
  `MF_SmoothDissolve`
  左侧还可见一个名为 `EmissiveVanish` 的紫色参数节点，但当前截图未显示其完整连接链
- 连线集
  `DP_Show` 先经过 `1-x` 反相，再与 `Decal Show Gradient` 一起接入 `MF_SmoothDissolve`
  `ShowBorderWidth` 也连接到 `MF_SmoothDissolve`
  `MF_SmoothDissolve` 右侧输出 `Edge` 与 `Mask`
  右侧导出端未完整显示，当前截图只能确认这两个输出继续参与后续材质计算
- 设置或参数
  左侧 `Details` 当前选中 `DP_Show`
  `Default Value = 0.676572`
  `Sort Priority = 32`
  `Group = None`
  右上角还能看到
  `OpacityPower`
  `OpacityMaxBright`
  `Default Value = 1.0`
  说明这一块与透明度强度和高亮上限联动
- 输出或预览
  左侧预览窗口标题为 `Previewing MaterialExpressionAdd_0`
  预览结果是一个几乎铺满视窗的白色圆形软边遮罩
  说明当前被观察的是一张用来控制显隐和边缘过渡的中间遮罩，而不是最终着色结果
- 字幕可确认的讲解意图
  英文字幕为 `This is where I can control the values for spawn, scattering and for scattering our backlight in the emitter update.`
  可确认这一步重点是把裂缝 show 或 dissolve 的材质参数，与 Niagara 的发射和更新阶段对应起来

复建这一段时，应把裂缝显隐、边缘宽度和背光散布拆成独立参数，并通过平滑溶解函数生成可被 Spawn 和 Emitter Update 共同驱动的遮罩
这一帧展示的是 Substance Designer 里的裂缝贴图节点图。作者在这里调整裂缝参数，反转中心形状，并用圆形过渡去塑造裂缝中心区域

- 节点定义集
  `Cracks Generator` 节点两处
  `Shape` 节点两处
  `Invert Grayscale`
  `Blend` 节点三处
- 连线集
  上方两个 `Cracks Generator` 各自输出裂缝图
  下方 `Shape` 输出到 `Invert Grayscale`
  `Invert Grayscale` 输出先接入下方 `Blend`
  第二个 `Cracks Generator` 也接入下方 `Blend`
  下方 `Blend` 的输出向上接入中间 `Blend`
  第一个 `Cracks Generator` 直接接入中间 `Blend`
  中间 `Blend` 的输出接入右上最终 `Blend`
  右下 `Shape` 也接入右上最终 `Blend`
  最终 `Blend` 输出到右侧当前查看的结果节点
- 设置或参数
  右侧属性面板当前选中 `Shape`
  `Pattern = Paraboloid`
  `Scale = 0.6`
  `Size X = 1`
  `Size Y = 1`
  顶部可见图尺寸为 `2048`
  多个裂缝节点和形状节点缩略图均标记 `2048x2048 - L16`
- 输出或预览
  左侧 `2D VIEW` 预览是一张中心亮、边缘黑的圆形渐变遮罩
  下方 3D 预览是简单立方体，不承载额外结构信息
  这说明当前作者正在单独检查中心过渡遮罩，而不是最终材质贴图的全部通道
- 字幕可确认的讲解意图
  英文字幕为 `I changed the parameters for the cracks. Inverted the shape to make a transition in the center.`
  可确认这一步的核心是调裂缝生成器参数，并通过反相形状生成中心过渡

复建这张图时，可把两路 `Cracks Generator` 结果先逐步混合，再用反相的圆形 `Shape` 作为中心过渡遮罩，在最终 `Blend` 里把裂缝结构和中心亮部结合起来
这一帧展示的是 Substance Designer 中裂缝贴图 `output_1` 的最终组装图。左侧 `2D VIEW` 已经显示出彩色裂缝纹理，中心是绿色高亮区，裂缝边缘混有蓝紫和黄色信息，背景为纯红色

- 节点定义集
  多个红头的中间处理节点，具体节点名在当前缩放下不可辨认
  至少一个白色圆形渐变输入节点
  右侧一个被选中的输出节点 `output_1`
  其后还有一个最终缩略图输出节点
- 连线集
  图谱从左向右分成上、中、下三路分支
  上中下三路分别经过多级中间节点处理后，在右侧汇合到 `output_1`
  下方白色圆形渐变节点也单独连入最终汇合区
  `output_1` 再连接到最右侧最终缩略图输出
  由于当前缩放较远，无法可靠辨认每个中间节点的精确类型和端口名称
- 设置或参数
  右侧属性面板当前选中 `output_1`
  `Identifier = output_1`
  `Format = Default Format`
  `Mipmaps = Full pyramid`
  左侧信息栏显示当前预览为 `2048 x 2048 (RGBA, 8bpc)`
- 输出或预览
  左侧 `2D VIEW` 预览图可确认这是一张 RGBA 彩色贴图，而不是单通道遮罩
  颜色分布表现为
  红色背景
  中心绿色高亮
  向外放射的裂缝带有蓝紫和黄色区域
  这与前面教程说明的多通道打包思路一致，说明裂缝形状、中心区域和附加控制信息被组合进同一张输出纹理
- 待确认边界
  当前截图无法可靠辨认各中间节点名称，也无法逐一确认每一路到底对应 `R/G/B/A` 哪个具体语义
  因此这里只能确认它是多路分支汇合生成最终彩色裂缝贴图，不能编造更细的通道归属

复建这一段时，应把裂缝主形、中心渐变和其他辅助遮罩分路处理后再汇合到最终 RGBA 输出，并以左侧预览那种“红底 + 中心亮色 + 放射裂缝”的结果作为核对目标

### 00:19:42-00:23:16 Emitter、Lifetime、Color

- 本段定位：Emitter、Lifetime、Color。
- 知识点：本段围绕 `Emissive` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。；User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Color`、`Emissive` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。；User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Particle`、`Decal` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Emitter`、`Particle`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Texture`。

**关键画面：**

这一帧回到 Unreal 关卡里，作者打开了材质实例 `MI_GroundCrack_01` 来调节裂缝 decal 的实例参数，同时在场景中实时观察地面裂缝结果

- 当前对象与资源
  顶部打开的标签包括 `NS_StylizedExplosion`、`M_GroundCrack`、`T_Crack_RGB`
  浮动窗口标题为 `MI_GroundCrack_01*`
  Outliner 中当前选中对象是 `NS_StylizedExplosion`
  右侧 `Details` 显示 `Niagara System Asset = NS_StylizedExpl...`
- 材质实例中可确认的参数组
  `Parameter Groups` 下能看见 `Decal` 与 `Diffuse`
  `Decal` 组包含
  `DecalTexture = T_Crack_RGB`
  `HeightmapChannel`
  `HeightRatio = 0.294857`
  `Ref Plane = 1.0`
  `Diffuse` 组包含
  `AlbedoTexture = Black`
  `AlbedoTint`
- 输出或预览
  实例窗口左侧预览是一张接近纯白的裂缝 decal，能看到几条细长向上的亮裂痕
  主视口里地面中央也能看到橙色裂缝残留，说明作者正在一边改实例参数，一边检查实际落地效果
- 字幕可确认的讲解意图
  英文字幕为 `Can be moved. Do not set the values too high.`
  可确认这一步是在提醒相关参数可调，但数值不要推得过高，否则视差或裂缝表现会失真

复建时，应把 `HeightRatio`、`HeightmapChannel` 和 `Ref Plane` 作为材质实例中的可调项暴露出来，并在关卡里同步观察 decal 形体，避免把视差强度调得过大
这一帧回到关卡视口，作者直接检查 `NS_StylizedExplosion` 地面裂缝 decal 的实际显示结果。当前画面说明裂缝已经从中心向外分叉展开，且中心热区与外围裂纹的亮度层次比较清楚

- 当前对象
  Outliner 中选中对象为 `NS_StylizedExplosion`
  右侧 `Details` 显示 `NS_StylizedExplosion (Instance)` 与 `NiagaraComponent0`
  顶部标签仍保留 `MI_GroundCrack_01`、`M_GroundCrack`、`T_Crack_RGB`
- 当前可见效果
  中心区域是一团橙色发光热核
  多条较粗的裂缝从中心向外伸出，主要分布在上方和左右两侧
  外围还有若干较细的小裂口，说明 decal 不只是单一主裂纹，而是带有次级碎裂分支
  整体亮部主要集中在裂缝内部和边缘，地表底色仍保持较暗
- 当前资源上下文
  `Content Browser` 路径位于 `VFX_Library > Materials > Functions`
  当前高亮的是 `MF_Decal Parallax`
  同排还能看到 `MF_Chromatic Aberration`、`MF_SceneBlur`、`MF_Smooth Dissolve`、`MF_Texture Crop`
  说明当前关卡验收的是建立在材质函数体系上的最终 decal 效果
- 这张图对复建的意义
  如果复建后的裂缝只剩一个均匀亮斑，或没有明显主裂纹与次级分支，就说明实例参数、贴图通道或 parallax 关系仍未调到教程状态

这张图可以作为当前小节的结果验收图：理想状态下，裂缝应具有中心热核、向外放射的主裂纹，以及若干较弱的外围碎裂分支
> 图表转写（UE-GTXT v4）
> - 类型: 关卡视口效果
> - 所属: `NS_StylizedExplosion`
> - 目的: 观察爆炸后期残留层从清晰裂缝过渡到柔和扩散的状态
>
> 当前状态:
> - Outliner 选中 `NS_StylizedExplosion`，Details 显示其 `NiagaraComponent0`
> - Content Browser 位于 `VFX_Library > Materials > Functions`，高亮 `MF_Decal Parallax`
>
> 预览结果:
> - 视口主要剩余一片大范围蓝色柔光圆盘或雾状扩散，中央是所选 Niagara 对象的变换控件
> - 前一阶段明显的橙色地面裂缝在此帧已基本不可见，说明镜头处于效果衰减后的残留阶段
> - 本帧用于记录阶段变化，不把该变化单独归因于某个未显示的 `Lifetime`、`Color` 或材质参数

### 00:23:16-00:26:00 Texture

- 本段定位：Texture。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：蓝图 Actor 用于封装 Niagara 生成、位置、参数传入和生命周期控制。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Lifetime`、`Alpha`、`Opacity`、`Texture`、`Blueprint`、`Panner`、`Emissive`。

**关键画面：**

这一帧开始进入 `Texture` 小节，但画面先回到内容浏览器与 Niagara 系统层级。作者切换到一个名为 `NS_SmokeTrail` 的系统，并说明它是“一个非常基础的火箭烟雾效果”

- 当前资源与路径
  `Content Browser` 当前路径为 `VFX_Library > Niagara > Explosion_Stylized`
  同目录可见
  `NS_Missile`
  `NS_Placeholder`
  `NS_SmokeTrail`
  `NS_StylizedExplosion`
  其中 `NS_SmokeTrail` 当前被选中
- 当前打开窗口
  右侧有一个单独的 `NS_SmokeTrail` 编辑窗口
  其预览视口中可见一条向上倾斜的浅色烟迹
  主视口中央只有变换 gizmo，没有明显爆炸 decal，说明教程已经从地面裂缝切换到烟雾系统示例
- 字幕可确认的讲解意图
  英文字幕为 `Very basic smoke for a rocket.`
  可确认这一段的目标是拿一个简单烟雾系统作为后续纹理或材质讲解的基础示例，而不是继续调前面的爆炸裂缝

复建这一段时，先在 `Explosion_Stylized` 目录中准备一个基础 `NS_SmokeTrail` 系统，并确保预览里能看到简单的细长烟迹，作为后续纹理和材质调整的起点
这一帧打开的是 Niagara 系统 `NS_MissileMarker` 的 `System Overview`。系统由三个发射器组成：`Area_01`、`Area_02` 和 `Center_Glow`，当前选中的是 `Area_01`，右侧正在查看其 `Sprite Rotation Rate` 模块参数

- 系统结构
  系统根节点为 `NS_MissileMarker`
  下方挂接三个 emitter
  `Area_01`
  `Area_02`
  `Center_Glow`
- `Area_01` 当前可见栈结构
  `Emitter Summary`
  `Emitter Spawn`
  `Emitter Update`
  其中可见
  `Emitter State`
  `Spawn Burst Instantaneous`
  `Particle Spawn`
  `Initialize Particle`
  `Sprite Facing and Alignment`
  `Particle Update`
  `Particle State`
  `Sprite Rotation Rate`
  `Scale Color`
  `Render`
  `Sprite Renderer`
- 右侧当前参数
  右侧 `Details` 当前选中 `Area_01`
  模块为 `Sprite Rotation Rate`
  `Rotation Rate = 15.0`
  `Delta Time = ENGINE DeltaTime`
- 预览与时间线
  左侧预览只显示一片淡白色圆形雾斑，没有复杂细节
  下方时间线同时列出 `Area_01`、`Area_02`、`Center_Glow`
  当前时间游标在约 `3.6431`
  三条绿色条带都从接近 `0` 的位置开始并延续到当前时间附近

这张图说明该烟雾或标记类效果不是单一 emitter，而是由两个区域层和一个中心发光层叠加而成；复建时应先把多 emitter 结构搭出来，再分别调旋转、颜色和渲染模块
这一帧回到关卡主视口与 `Explosion_Stylized` 目录列表，当前选中的是 `NS_Placeholder`。字幕说明“下一个视频里会更详细地讲解蓝图”，说明这一段教程已经接近收尾，并把后续更深入的蓝图内容留到下一节

- 当前资源与路径
  `Content Browser` 路径仍为 `VFX_Library > Niagara > Explosion_Stylized`
  当前可见并排的系统资源有
  `NS_MissileMarker`
  `NS_Placeholder`
  `NS_SmokeTrail`
  `NS_StylizedExplosion`
  其中 `NS_Placeholder` 当前被选中
- 当前场景状态
  主视口中没有明显的爆炸或烟雾特效，只剩地面和中央一个白色十字准星
  Outliner 右侧当前没有选中具体对象
  `Details` 面板提示 `Select an object to view details.`
  说明此时作者主要是在做资源级切换和教程收束，而不是继续展示某个运行中的效果
- 字幕可确认的讲解意图
  英文字幕为 `In the next video we will talk in more detail about the blueprint.`
  可确认本段是过渡结尾，下一部分会转向蓝图层面的更细讲解

这张图可以作为本批最后一条的收尾说明：到这里教程从当前烟雾与系统示例退出，并把进一步的蓝图展开留到后续内容

## 补充视觉证据

### S01 00:02:47

这张补充图展示的是外部体积特效工具里 `StylizedExplosion.ember` 的完整节点图与 `Style` 参数页。左侧是当前体积爆炸预览，右侧是从 `Force Noise / Shape Primitive / Simulation / Volume Processing / Shading / Camera / Render` 串起来的主图，底部则打开了风格化渲染参数

- 节点定义集
  多个 `Force Noise` 节点
  多个 `Color Gradient` 节点
  `Fire Gradient`
  `Light Direction`
  `Shading`
  `Simulation`
  `Volume Processing`
  `Camera`
  `Render`
  `Export Flipbooks and...`
  `Shape Primitive`
  `Emitter Volume`
  `Force Volume`
  `Shape Position`
  `Shape Profile`
- 连线集
  左上多组 `Force Noise` 输出分别接到多组 `Color Gradient`，再汇入 `Shading`
  `Fire Gradient` 与 `Light Direction` 也接入 `Shading`
  `Simulation` 输出 `Fire`、`Volume`、`Velocity`、`ColorMap` 等结果，传给 `Volume Processing`
  `Volume Processing` 的处理结果继续汇入 `Shading`
  `Shading` 再把 `Camera`、`Rotation` 等结果送入 `Render`
  `Render` 最终连接到 `Camera` 与 `Export Flipbooks and...`
  中部 `Shape Primitive -> Emitter Volume` 构成压力与温度注入链
  下部多组 `Force Noise / Shape Position / Shape Profile / Force Volume / Emitter Volume` 共同作为额外体积和噪声来源接入模拟链
- 设置或参数
  当前底部选中页签为 `Style`
  `Rendering style = Colored Thin Strokes`
  `Flow smoothness = 0.500`
  `Strokes length = 15.000`
  `RGB quantization = 64`
  `Hue quantization = 64`
  `Value quantization = 64`
  `Saturation quantization = 64`
  `Quantization dither = 0.150`
  `Dithering mode = Bayer 2x2`
  `Translucency limit = 0.500`
  左下时间线和模拟参数还能确认
  `Velocity dissipation = 95.000 u/s`
  `Smoke dissipation = 0.110 units/s`
  `Flames dissipation = 0.298 units/s`
  `Density reference = 0.459`
- 输出或预览
  左侧预览显示一个由多个团块组成的体积爆炸，表面是灰褐色烟块，内部缝隙透出橙红色发光裂隙
  时间线存在多组关键帧，说明这组噪声、耗散和风格参数带有动画变化
- 字幕可确认的讲解意图
  英文字幕为 `option with a bigger blur, but let me leave it as I have already done the render.`
  可确认作者在比较更强模糊选项，但决定保持当前渲染结果不再改动

这张补充图的核心意义，是把外部体积爆炸的完整 authoring 结构和风格化参数一次性展开给读者看。复建时可先按 `Simulation -> Volume Processing -> Shading -> Camera -> Render` 的主链搭好，再用 `Colored Thin Strokes`、量化和抖动参数把结果推向教程里的风格化体积外观

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。



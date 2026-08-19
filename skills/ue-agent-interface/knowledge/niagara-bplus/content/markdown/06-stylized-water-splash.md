# 06 Stylized Water Splash

# 06 Stylized Water Splash

## 关键术语

- `Emitter`、`System`、`Spawn`、`Spawn Rate`、`Lifetime`、`Color`、`Alpha`、`Scale Color`、`Scale Sprite Size`、`Material`、`UV`、`Add`、`Niagara`、`Normalized Age`、`Texture`、`Curve`、`Niagara System`、`Particle`

## 分段知识

### 00:00:05-00:05:04 Emitter、Spawn、Spawn Rate

- 本段定位：Emitter、Spawn、Spawn Rate。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Emitter` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter`、`Particle`、`Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Particle`、`Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Opacity`。

**关键画面：**

这是关卡编辑器中的 Sequencer 总览图，用来说明 `NS_StylizedWaterSplash` 这次不再是孤立资产预览，而是与角色和镜头一起在场景里配合演示

已确认界面状态：

- 当前处于关卡编辑器
- 下方打开了 `LQ_StylizedWaterSplash` 的 Sequencer
- 可见轨道包括
  - `Camera Cuts`
  - `CameraActor`
  - `NS_StylizedWaterSplash`
- 播放头停在约 `0.98` 秒
- Outliner 中当前选中角色 `Gideon_Inquisitor`

场景表现：

- 角色站在地面中央
- 角色上方悬浮一个蓝色发光球体
- 主球周围可见一些细小环绕粒子
- 画面说明本节的效果是围绕角色上方空间展开，而不是单独悬浮在空场景中

可确认含义：

- 本页教程从一开始就把特效、角色和镜头放在同一个关卡上下文里验证
- `NS_StylizedWaterSplash` 已经被放进 Sequencer，用于控制出场时机
- 角色主体与主球之间的相对位置已经成为复现时必须对齐的空间关系

这张图可替换为：在关卡中放置角色 `Gideon_Inquisitor`，并把 `NS_StylizedWaterSplash` 与 `CameraActor` 一起加入 `LQ_StylizedWaterSplash` 的 Sequencer。在约 `0.98` 秒处，角色上方已经出现一个蓝色发光主球及其周围的细小环绕粒子，说明这一节的特效搭建目标是“角色头顶/上方悬浮的风格化水球”，后续所有 Spawn、Lifetime 和材质参数都应围绕这个空间关系来验证
这是在 `NS_StylizedWaterSplash` 中新增一个临时发射器 `Empty` 的配置图。教程开始为新的 Sprite 层设置朝向和对齐规则，以便后续生成的面片粒子始终朝指定方向摆放

系统层结构：

- 当前时间轴中已存在多个发射器
  - `Bubbles_AroundSphere`
  - `Dots_AroundSphere`
  - `DotsDark_AroundSphere`
  - `Empty`
  - `WaterDrips`
  - `WaterSphereGlow`
  - `WaterSphereMesh`
- 当前选中的是 `Empty`

`Empty` 当前可确认的模块结构：

- `Emitter State`
  - 当前标签可见 `Self / Infinite`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
  - 新增 `Sprite Facing and Alignment`
- `Particle State`
- `Sprite Renderer`

`Sprite Facing and Alignment` 已确认参数：

- `Sprite Facing = (1.0, 0.0, 0.0)`
- `Facing Coordinate Space = Simulation`
- `Sprite Alignment = (0.0, 1.0, 0.0)`
- `Alignment Coordinate Space = Simulation`

可确认含义：

- 该层不是简单依赖默认面向摄像机
- 教程明确指定了 Sprite 的朝向向量和对齐向量
- 这通常用于让片状粒子稳定地朝某个模拟空间方向排列，便于后续做更像切片、水帘或薄片的视觉

这张图可替换为：在 `NS_StylizedWaterSplash` 中新增一个临时发射器 `Empty`，保留 `Spawn Burst Instantaneous`、`Particle State` 和 `Sprite Renderer` 的基础结构，并在 `Initialize Particle` 中加入 `Sprite Facing and Alignment` 模块。将 `Sprite Facing` 设为 `(1,0,0)`、`Sprite Alignment` 设为 `(0,1,0)`，两者的坐标空间都设为 `Simulation`。这样该层的 Sprite 粒子就不会只按默认屏幕朝向显示，而是会稳定地按模拟空间中的固定方向摆放，为后续更明确的片状水体或附加层效果打基础
这是 `Empty` 发射器继续补充颜色衰减逻辑的界面图。教程在 `Particle Update` 中加入 `Scale Color`，让这个单粒子 Sprite 层能够随生命周期逐步调亮或淡出

当前发射器：`Empty`

左侧可确认的模块结构：

- `Emitter State`
  - 当前显示 `Self / Infinite`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
  - `Sprite Facing and Alignment`
- `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
- `Sprite Renderer`

`Scale Color` 已确认参数：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`
- `Scale Alpha`
  - 类型为 `Float from Curve`
  - 曲线资源为 `Curve for Floats`
  - `CurveIndex = Particles.NormalizedAge`
  - `Scale Curve = 1.0`

可确认含义：

- RGB 没有被额外乘暗或染色
  - 即这一层的颜色主要保持原始材质/粒子颜色
- Alpha 则由 `Particles.NormalizedAge` 驱动
  - 表示透明度会随粒子寿命阶段变化
- 这类设置通常用于让单个 Sprite 在出现后渐隐，而不必同时改变色相

这张图可替换为：在 `Empty` 发射器的 `Particle Update` 中加入 `Scale Color` 模块，并将其模式设为 `RGB and Alpha Separately`。保持 `Scale RGB = (1,1,1)` 不变，只把 `Scale Alpha` 接到一条 `Float from Curve`，其输入索引使用 `Particles.NormalizedAge`，`Scale Curve = 1.0`。这样该单粒子层的颜色不会被额外改色，但透明度会按生命周期曲线逐步变化，便于后续做柔和出现或淡出的片状附加层

### 00:05:04-00:09:48 Material、UV、Add

- 本段定位：Material、UV、Add。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Alpha`、`Opacity`、`Material`、`Texture`、`Noise`、`Add`、`Panner`。

**关键画面：**

这是回到关卡编辑器后的效果验证图，用来确认前面为 `Empty` 发射器和水滴层加入的 Sprite 朝向、颜色衰减与生成位置逻辑，已经在真实镜头中形成一个更完整的纵向水体构图

已确认界面状态：

- 当前处于关卡编辑器
- 下方是 `LQ_StylizedWaterSplash` 的 Sequencer
- 轨道仍包括
  - `Camera Cuts`
  - `CameraActor`
  - `NS_StylizedWaterSplash`
- 播放头停在约 `2.33` 秒
- Outliner 中当前选中 `NS_StylizedWaterSplash`

场景表现：

- 画面上方出现一个竖向、偏椭圆的蓝色发光片状主体
- 主体下方有一串向下延伸的细小滴点
- 更下方地面附近还可见一块单独的蓝色辉光落点

可确认含义：

- 这一节新增的 Sprite 层已经不只是围绕主球旋转，而是形成了更像“上方水片/水柱核心 + 中段滴落 + 底部光斑”的纵向结构
- 说明 `Sprite Facing and Alignment`、`Scale Color` 以及 `WaterDrips` 的位置和生命周期设置已经共同改变了整体外观

这张图可替换为：在关卡的 Sequencer 里播放 `NS_StylizedWaterSplash` 到约 `2.33` 秒，检查新增 Sprite 层和滴落层的组合结果。此时画面已不再只是一个球形主核，而是形成了“上方竖向蓝色发光片体、中间下落滴点、下方地面辉光”的三段式结构。这个结果说明新加入的 `Empty` 发射器所产生的片状 Sprite，已经开始承担主要的纵向视觉主体，而 `WaterDrips` 则负责把上层主体与下方落点连接起来
这是回到关卡编辑器与内容浏览器后的资产核对图，用来确认本段新增的纵向水片层、水滴层和地面落点层，已经各自对应到不同的材质实例

已确认界面状态：

- 当前仍在关卡编辑器中查看 `NS_StylizedWaterSplash` 的实际画面
- 内容浏览器定位到
  - `Content > VFX_Library > Materials > Instances > StylizedWaterSplash`
- 当前目录下可见 6 个实例资产
  - `MI_Bubble_01`
  - `MI_GlowAlpha_01`
  - `MI_GlowWater_01`
  - `MI_WaterBubble_01`
  - `MI_WaterDrips_01`
  - 一个名称被裁切、以 `vWater..._01` 开头的白色发光类实例
    - 完整名称在截图中不可完全确认

场景表现：

- 画面上方保持竖向蓝色发光片体
- 中间有一串细小滴点
- 地面位置出现一个明显的白色圆形亮斑

可确认含义：

- 相比上一张，这里更明确地区分了“蓝色主体/滴落”和“地面白色落点”这两类材质表现
- `MI_WaterDrips_01` 的出现说明滴落层已经单独拥有自己的实例参数
- 另一枚白色发光实例很可能用于地面接触或落点高亮，但完整命名在本图中不能臆写

这张图可替换为：在 `VFX_Library/Materials/Instances/StylizedWaterSplash` 目录中，为本节新增的效果层准备独立实例资产，至少可以确认新增了 `MI_WaterDrips_01`，并且还存在一个用于白色发光/落点表现的额外实例。关卡画面中，上方蓝色竖向主体、中段滴落链和下方白色圆形落点已经同时成立，说明教程此时把“空中主体”和“地面接触光斑”拆分为不同材质层分别控制，而不是继续复用同一套发光实例
这是材质实例 `MI_WaterGroundWave_...` 的参数面板截图，教程在这一段开始单独调整地面波纹/地面水幕层的材质，让落点附近出现更宽、更透明的平面型效果

参数分组与已确认设置：

- 当前实例标签显示为 `MI_WaterGroundWave_...`
  - 名称末尾被标签截断，完整命名在本图中不可完全确认
- 父材质：`M_UberMaterial`
- `Base Texture`
  - `Colormap`
    - 已启用
    - 资源为 `VFX_T_ColorMap_Blue_06`
  - `Main (Scale/Scroll)`
    - 已启用
    - 通道值可见
      - `R = 1.0`
      - `G = 1.0`
      - `B = 0.1`
      - `A = 0.7`
  - `Premultiply Color? = 0.0`
  - `T_Main`
    - 已启用
    - 资源为 `T_Noise115`
  - `T_Mask`
    - 已启用
    - 当前槽位还是 `WhiteSquareTexture`
    - 右侧资源选择面板正在搜索 `gradient`
    - 候选里可见 `T_Gradient13`、`T_Gradient14`、`T_Gradient15`
  - `Use Colormap? = 0.0`
- `Dissolve`
  - `T_Dissolve`
    - 已启用
    - 资源为 `T_Noise_2`
  - `Smoothness = 0.1`
- `Distortion`
  - `Distortion Influence = 0.0`
  - `T_Distortion`
    - 未启用
    - 槽位里显示类似 `T_Voronoise002`
- `Global Scalar Parameter Values`
  - `Depth Fade = 0.0`

输出/预览：

- 左侧预览是一个大面积半透明平面
- 平面上能看到较柔和的白色噪声状纹理分布
- 这明显不同于前面的竖向主片体，说明当前材质是给地面波纹或接触面使用的

可确认含义：

- `T_Main = T_Noise115` 提供主体噪声形状
- `T_Dissolve = T_Noise_2` 继续参与破碎/过渡控制
- 教程准备把 `T_Mask` 从默认白图替换成渐变类纹理，以便让地面平面拥有更自然的边缘衰减
- `Depth Fade = 0.0` 也说明此时并不依赖深度衰减去软化边缘，而更偏向直接用贴图与渐变控制透明形状

这张图可替换为：为地面波纹层单独调整一个 `MI_WaterGroundWave` 类材质实例，父材质仍用 `M_UberMaterial`。在 `Base Texture` 中启用蓝色渐变 `VFX_T_ColorMap_Blue_06`，设置 `Main (Scale/Scroll)` 为 `R=1, G=1, B=0.1, A=0.7`，并把主纹理设为 `T_Noise115`；同时启用 `T_Dissolve = T_Noise_2`，将 `Premultiply Color?` 和 `Use Colormap?` 都保持为 `0.0`，`Depth Fade` 设为 `0.0`。此时教程正在为 `T_Mask` 搜索 `gradient` 纹理，准备把默认白遮罩替换为渐变贴图，以便让地面平面效果获得更柔和的外轮廓和透明过渡

### 00:09:48-00:14:04 Spawn、Color、Multiply

- 本段定位：Spawn、Color、Multiply。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn`、`Color`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Spawn`、`Color`、`Alpha`、`Opacity`、`Texture`、`Multiply`、`Add`。

**关键画面：**

这是地面波纹材质实例 `MI_WaterGroundWave...` 的继续设置画面，父材质仍为 `M_UberMaterial`

- `Base Texture`
  - `Colormap` 启用，资源为 `VFX_T_ColorMap_Blue_06`
  - `Main (Scale/Scroll)` 启用，值仍为 `R=1.0`、`G=1.0`、`B=0.1`、`A=0.7`
  - `Premultiply Color? = 0.0`
  - `T_Main = T_Noise115`
  - `T_Mask` 已替换为渐变纹理 `T_Gradient21`
  - `Use Colormap? = 0.0`
- `Dissolve`
  - `T_Dissolve = T_Noise_2`
  - `Smoothness = 0.1`
- `Distortion`
  - `Distortion Influence = 0.0`
  - `T_Distortion` 槽位仍是类似 `T_Voronoise002` 的噪声
- `Global Scalar Parameter Values`
  - `Depth Fade = 0.0`

左侧预览能看到一个贴在圆形地面网格上的灰白色矩形波纹区域，说明本步骤的重点是给地面水波层指定纵向渐变遮罩，让噪声只在局部区域显现，而不是整张白图满铺
这是 `NS_StylizedWaterSplash` 内部对地面暗色水洼层的搭建画面。系统里可见 `Dark_Puddle` 与 `Empty` 两个相关发射器，其中当前选中的是 `Empty`

- `Empty` 发射器结构
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Particle State`
  - `Mesh Renderer`
- `Initialize Particle`
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 5.0`
  - `Color Mode = Direct Set`
  - `Color = (R=0.0, G=0.174935, B=0.292411, A=0.638175)`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 1.0)`
  - `Position Offset Coordinate Space = Simulation`
- `Mesh Attributes`
  - `Mesh Scale Mode = Uniform`
  - `Mesh Uniform Scale = 1.0`

左侧预览显示一个浅灰白背景上的圆形暗环与下方椭圆水洼，说明这一层不是竖向水柱，而是贴地的 puddle 形状。时间线上 `Empty` 与 `WaterDrips`、`WaterSphereGlow` 等层并行工作，用来在地面补出暗色主体和落点下方的积水感
这一张继续编辑 `NS_StylizedWaterSplash` 中的 `Empty` 发射器，重点是把地面水洼层的颜色和网格尺寸再压低一些

- `Empty` 发射器可见结构
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Initial Mesh Orientation = None`
  - `Particle State`
  - `Mesh Renderer`
- `Initialize Particle`
  - `Lifetime = 5.0`
  - `Color Mode = Direct Set`
  - `Color` 当前可确认被改为更亮一点的青灰色，截图里可见：
    - `Red = 0.1`
    - `Green = 0.25`
    - `Blue` 仍约为 `0.2924`
    - `Alpha = 0.638175`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 1.0)`
- `Mesh Attributes`
  - `Mesh Scale Mode = Uniform`
  - `Mesh Uniform Scale = 0.8`

左侧预览中圆环和下方椭圆水洼都比上一张更集中，说明这里是在把地面暗色积水层缩小并微调色相，让它更贴合落点中心，而不是铺得过大

### 00:14:04-00:17:06 Color、Scale Color、Texture

- 本段定位：Color、Scale Color、Texture。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Scale Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Color`、`Alpha`、`Opacity`、`Scale Color`、`Texture`、`Curve`、`Panner`。

**关键画面：**

这一张继续在 `NS_StylizedWaterSplash` 中编辑 `Empty` 发射器，但焦点从 `Initialize Particle` 切到 `Mesh Renderer`，用于给地面环形水波指定实际网格和材质

- `Empty` 发射器当前可见模块
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Initial Mesh Orientation = None`
  - `Particle State`
  - `Mesh Renderer`
- `Mesh Renderer`
  - `Meshes` 里有 1 个数组元素
  - `Index [0] = SM_Circle_01`
  - `Enable Material Overrides` 已启用
  - `Override Materials` 里有 1 个数组元素
  - `Index [0]` 的 `Explicit Mat` 指向一个地面波纹材质实例，名称可辨认为 `MI_WaterGroundWave..._01`
  - `Source Mode = Particles`
  - `Sort Mode = None`
  - `Cast Shadows` 已启用
  - `Sort Order Hint = 1`

左侧预览能看到同心环形波纹落在圆形平面上，说明这里的做法是用 `SM_Circle_01` 作为承载网格，再用专门的地面波纹材质实例绘出暗色水波，而不是继续用 Sprite 做地面层
这一张重新打开地面波纹材质实例，对 `MI_WaterGroundWave...` 的贴图、溶解和扭曲做进一步增强，让纹理更集中地向内部收缩

- `Base Texture`
  - `Colormap = VFX_T_ColorMap_Blue_06`
  - `Main (Scale/Scroll)` 启用，当前值可确认为：
    - `R = 1.0`
    - `G = 3.0`
    - `B = 0.1`
    - `A = 0.7`
  - `Premultiply Color? = 1.0`
  - `T_Main = T_Noise115`
  - `T_Mask = T_Gradient21`
  - `Use Colormap? = 0.0`
- `Dissolve`
  - `T_Dissolve = T_Noise_2`
  - `Smoothness = 0.2`
- `Distortion`
  - `Distortion Influence = 0.05`
  - `T_Distortion = T_Voronoise005`
- `Global Scalar Parameter Values`
  - `Depth Fade = 0.0`

左侧预览中的暗色圆盘中央出现更细的亮线和内部噪声，说明本步是在把主噪声沿一个方向拉伸得更明显，并用渐变遮罩和轻微扭曲让地面水波更像被吸向中心的流动形态
这是地面波纹材质实例的结果确认画面。当前可见参数与上一张保持一致，没有出现新的明确数值改动，因此本张重点是验证前一步设置后的视觉效果

- `Base Texture`
  - `Colormap = VFX_T_ColorMap_Blue_06`
  - `Main (Scale/Scroll) = (R=1.0, G=3.0, B=0.1, A=0.7)`
  - `Premultiply Color? = 1.0`
  - `T_Main = T_Noise115`
  - `T_Mask = T_Gradient21`
  - `Use Colormap? = 0.0`
- `Dissolve`
  - `T_Dissolve = T_Noise_2`
  - `Smoothness = 0.2`
- `Distortion`
  - `Distortion Influence = 0.05`
  - `T_Distortion = T_Voronoise005`
- `Global Scalar Parameter Values`
  - `Depth Fade = 0.0`

左侧预览里的地面波纹比前面的明环更隐约，中心只保留一层淡淡的内收噪声，说明这一段的材质调整目标是把落点地面层压暗、压平，并让纹理细节更多集中在内部而不是外圈

### 00:17:06-00:21:58 UV、Add、WPO

- 本段定位：UV、Add、WPO。
- 知识点：本段围绕 `Blender` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`、`Blender`、`材质`。

**关键画面：**

这是 `LQ_StylizedWaterSplash` Sequencer 中对当前水球效果的结果核对画面，时间线停在约 `1.05s`

- 关卡可见效果
  - 空中有一个亮蓝色主球体
  - 主球左侧有少量细小飞溅粒子
  - 主球正下方有一条很细的垂直下落痕迹
  - 地面中央只剩一块较弱的蓝色辉光/水洼，不再是前面更明显的亮环
- Sequencer
  - 轨道中仍有 `CameraActor`
  - `NS_StylizedWaterSplash` 作为一条独立轨道持续存在
  - 当前镜头继续使用近景俯拍方式观察空中主球和地面落点的对应关系
- 右侧对象信息
  - 选中对象是 `NS_StylizedWaterSplash` 实例
  - `Rendering > Visible` 为启用状态

这张图的作用是确认前一段地面材质调整后的最终观感：焦点重新回到“空中主球 + 下落痕迹 + 地面暗弱落点”的整体层次，为下一步准备 3D 网格对象做对照基线
这是在 Blender 中为该特效准备 3D 承载物体的画面。当前场景里只有一个选中的 `Cylinder`，已经被改成低矮圆台形，并通过平滑和细分让轮廓更圆润

- 场景对象
  - `Scene Collection` 中只有 1 个对象：`Cylinder`
  - 当前处于 `Object Mode`
- 模型状态
  - 物体整体是一个顶部较平、侧壁外倾的低矮圆台
  - 左下角弹窗显示已执行 `Shade Smooth`
  - `Auto Smooth` 未勾选
  - `Angle = 30°`
- 修改器
  - 当前添加了 `Subdivision` 修改器
  - 细分类型为 `Catmull-Clark`
  - `Levels Viewport = 3`
  - `Render = 2`
  - `Optimal Display` 已启用
- 几何统计
  - `Vertices = 1496`
  - `Edges = 2904`
  - `Faces = 1408`
  - `Triangles = 2816`

这一步的目的不是做复杂模型，而是先得到一个边缘圆滑、顶部平整的基础网格，后续可作为 Niagara 中某个水波/能量层的 3D 形体载体
这张图继续展示同一个 Blender 网格，重点从外形转到 UV 和顶部开口结构的确认

- 视图布局
  - 左侧切到 `UV Editing` 工作区的 UV 视图
  - UV 视图里能看到一个铺满方形画布的展开结果，由大量细长矩形岛组成
  - 右侧仍是 3D 透视视图
- 3D 网格外形
  - 物体仍为低矮外扩的圆台
  - 顶部中心被挖出一个圆形开口，整体更像浅碗/环状罩体，而不是封闭圆柱
  - 表面显示棋盘格检查纹理，并叠加彩色十字标记，用于观察 UV 拉伸和方向
- 修改器
  - `Subdivision` 修改器仍然启用
  - `Catmull-Clark`
  - `Levels Viewport = 3`
  - `Render = 2`

这一步说明作者已经把 3D 对象从单纯的基础体块推进到“可贴材质检查”的阶段：一方面通过顶部开口让形体更适合包裹能量/水波中心，另一方面用棋盘格确认 UV 分布是否均匀，便于后续导入 Unreal 后承载流动材质

### 00:21:58-00:25:28 Material、UV、Add

- 本段定位：Material、UV、Add。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Sequencer`、`Add`、`Panner`、`Emissive`、`材质`。

**关键画面：**

这是 Blender 中继续处理同一个 `Cylinder` 网格的画面，当前重点是确认细分修改器已经应用到实际模型上，并保留 UV 检查视图

- 视图布局
  - 左侧仍为 UV 视图，展开结果铺在方形画布内
  - 右侧为 3D 透视视图
- 网格状态
  - 物体已经从前一段的低矮圆台进一步变成向内收拢的碗状体
  - 顶部中央保留一个圆形凹口/开口
  - 表面继续使用棋盘格检查纹理查看 UV 拉伸
  - 底部边缘圆滑、整体轮廓对称
- 修改器信息
  - 右下字幕明确说明 `modifiers are applied`
  - 右侧属性区仍显示 `Subdivision`
  - `Catmull-Clark`
  - `Levels Viewport = 3`
  - `Render = 2`

这一步的意义是把之前仅用于预览的平滑细分形状固化为正式网格，确保后续导出到 Unreal 时得到的是已经成型的 3D 体，而不是依赖 Blender 运行时修改器的临时外观
这张图切到 Blender 的建模阶段，新建了一个独立的 `Torus` 物体，作为后续特效的环状 3D 元素

- 对象
  - 当前选中对象为 `Torus`
  - `Scene Collection` 中当前只显示这一项
- 形体
  - 外形是一个压扁的厚环，中心有完整圆孔
  - 整体高度较低，适合做地面或围绕能量球的环状层
- `Add Torus` 参数
  - `Major Segments = 48`
  - `Minor Segments = 12`
  - `Dimensions Mode = Major/Minor`
  - `Major Radius = 1 m`
  - `Minor Radius = 0.25 m`
  - `Generate UVs` 已启用
  - `Align = World`
  - 位置为 `X=0 m`、`Y=0 m`、`Z=0 m`
  - 旋转为 `X=0°`、`Y=0°`、`Z=0°`

这一步说明作者除了前面的碗状网格外，又额外准备了一个标准环形体，方便在 Unreal 里为水波、能量圈或外围装饰层提供更直接的 3D 轮廓
这是 Unreal 编辑器中的资源导入确认画面，说明刚才在 Blender 准备的环形网格已经进入项目内容库

- 当前关卡预览
  - 画面中心仍是蓝色主球、下落痕迹和地面淡蓝落点
  - 说明资源导入后，作者仍在同一个 `StylizedWaterSplash` 效果工程里继续工作
- 内容浏览器位置
  - 路径为 `Content > VFX_Library > Meshes`
  - 当前目录下可见 5 个静态网格资源：
    - `SM_Circle_01`
    - `SM_Cone_01`
    - `SM_Cylinder_01`
    - `SM_Cylinder_High...`（名称被截断，能确认是高模圆柱类资源）
    - `SM_TorusHighPoly_01`
  - 当前选中资源是 `SM_TorusHighPoly_01`
- 右侧对象信息
  - 场景中选中的是 `NS_StylizedWaterSplash` 实例
  - 其 `Transform` 显示 `Location=(0,0,0)`、`Rotation=(0,0,0)`、`Scale=(1,1,1)`

这一步的核心是把 Blender 里制作的环形网格正式作为 `Static Mesh` 导入 Unreal，命名为 `SM_TorusHighPoly_01`，供后续 Niagara 的 Mesh Renderer 或材质展示层直接使用

### 00:25:28-00:28:48 Color、Material、UV

- 本段定位：Color、Material、UV。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Translucent` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle`、`Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`Multiply`、`Add`。

**关键画面：**

这是 Unreal 编辑器中为后续 3D 水体层查找材质资源的画面。作者在内容浏览器里定位到一个专门用于水面顶点位移的材质

- 当前效果预览
  - 视口里仍然能看到空中的蓝色主球、垂直下落痕迹和地面淡蓝落点
  - 说明此时仍在同一个 `NS_StylizedWaterSplash` 工程环境内继续补充资源
- 内容浏览器路径
  - `Content > VFX_Library > Materials > MM > _Special > WaterSplash`
  - 当前目录下可见 1 个材质资源，名称可确认为 `M_WaterBubble...`
- 教程语义
  - 字幕明确提到这是 `material water vertex move`
  - 结合路径和命名，可以确认本步是在寻找一个带顶点位移能力的水体材质，用于驱动新导入的 3D 网格产生起伏或流动感

这张图的关键不是参数，而是资源选择：后面涉及 `Multiply`、`Add`、`Normal` 的设置之前，先把能做水体顶点移动的材质定位出来，作为环形或碗状网格的候选主材质
这是材质 `M_WaterVertexMove` 的 `Material Graph`。当前截图显示的是发光颜色部分的基础连接，重点在用颜色参数参与乘法后输出到材质主节点

- 材质主节点
  - 材质名为 `M_WaterVertexMove`
  - 当前可见输入口包括 `Base Color`、`Metallic`、`Specular`、`Roughness`、`Normal`、`Tangent`、`World Position Offset` 等
  - `Opacity = 1.0`
  - `World Position Offset` 当前显示为 `X=0.0, Y=0.0, Z=0.0`
- 可见节点结构
  - 一个 `Main Color` 参数节点接入 `Multiply`
  - 上方还有一个纹理采样/颜色来源节点，其输出也接入同一个 `Multiply`
  - `Multiply` 的输出连接到材质主节点的 `Emissive Color`
- 预览
  - 左侧材质预览是一个纯亮蓝色球体
  - 说明当前可见图段主要在控制整体发光色调，而不是显示复杂贴图细节
- 性能统计
  - `Base pass shader without light map = 102 instructions`
  - `Base pass vertex shader = 137 instructions`
  - `Texture samplers = 2/16`

按当前可见信息，这一步先搭好了“纹理/颜色源 × 主颜色参数 -> Emissive Color”的基础发光链路。虽然教程标题提到顶点移动，但本张截图里还没有展示实际接到 `World Position Offset` 的连线
这是 Unreal 编辑器里继续整理材质资源的画面。作者回到 `MM` 目录层级，准备把刚制作的 3D 网格送进材质预览窗口中检查显示效果

- 当前效果预览
  - 视口里仍是相同的水球结果预览：空中蓝色主球、细下落痕迹、地面淡蓝落点
- 内容浏览器路径
  - `Content > VFX_Library > Materials > MM`
  - 当前目录里可见：
    - 文件夹 `_Special`
    - 材质 `M_UberMaterial`
- 教程语义
  - 字幕说明 `We can take this 3D object and pass it here to the preview to see it`
  - 结合前两张图，可确认本步目标是把新建的 3D 网格指定为材质的预览网格，用来直观看材质贴在环形或碗状静态网格上的效果，而不是只看默认球体预览

这张图本身没有展示新的节点或参数修改，但它明确了接下来的工作方向：从资源浏览转到“材质 + 自定义 3D 预览网格”的联调流程，为后续 `Multiply`、`Add`、`Normal` 相关调节提供真实载体

### 00:28:48-00:31:40 Multiply、Add、Normal

- 本段定位：Multiply、Add、Normal。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 核对对象：`Particle`、`Multiply`、`Add`。

**关键画面：**

这是 `M_WaterVertexMove` 材质图中真正把纹理驱动接入顶点位移的关键节点段。当前画面可确认作者正在先添加一个“偏移高度”控制

- 节点定义集
  - `Append`
    - 上游来自两个标量分量，合成为一组 UV 速度/方向数据
  - `Panner`
    - `Coordinate` 由左侧节点提供
    - `Time` 使用默认时间输入
    - `Speed` 接收 `Append` 输出
  - 纹理采样节点 `T_VertexOffset`
    - `UVs` 接 `Panner` 输出
    - 用一张噪声纹理生成动态位移蒙版
  - 标量参数 `Vertex offset intensity`
    - `Default Value = 15.0`
  - `VertexNormalWS`
    - 提供顶点法线方向
  - 两个 `Multiply`
    - 第一个把纹理值与 `Vertex offset intensity` 相乘
    - 第二个再把结果与 `VertexNormalWS` 相乘
  - 输出节点 `Vertex Offset`
- 连线集
  - `Append -> Panner.Speed`
  - `Panner -> T_VertexOffset.UVs`
  - `T_VertexOffset` 输出 -> 第一个 `Multiply.A`
  - `Vertex offset intensity` -> 第一个 `Multiply.B`
  - 第一个 `Multiply` 输出 -> 第二个 `Multiply.A`
  - `VertexNormalWS` -> 第二个 `Multiply.B`
  - 第二个 `Multiply` 输出 -> `Vertex Offset`
- 输出/预览
  - 左侧预览网格呈现浅蓝色半透明水面形体，中央有轻微起伏
  - 字幕说明当前步骤是“先添加偏移高度”

这组节点的语义很明确：先让噪声纹理通过 `Panner` 滚动，再用 `Vertex offset intensity` 放大位移强度，最后沿 `VertexNormalWS` 方向推顶点，从而得到会流动起伏的 3D 水面
这张图继续编辑 `M_WaterVertexMove` 的顶点位移部分，新增了 `ObjectScale` 相关处理，用来把位移结果和预览网格的缩放关联起来

- 节点定义集
  - `VertexNormalWS`
    - 继续作为顶点位移方向输入
  - `ObjectScale`
    - 可见输出为 `Scale XYZ`
    - `Scale X/Y/Z` 单独输出口未使用
  - 3 个 `Multiply`
    - 上方 `Multiply` 的输出继续接到右侧 `Vertex Offset`
    - 下方新增一个 `Multiply`，其一侧接 `ObjectScale.Scale XYZ`
    - 另一侧来自左侧已有链路，但具体源节点在截图外不可完整确认
  - 输出节点 `Vertex Offset`
- 连线集
  - 左侧已有结果 -> 上方 `Multiply`
  - `VertexNormalWS` -> 中间/右侧位移乘法链
  - `ObjectScale.Scale XYZ` -> 下方新增 `Multiply`
  - 下方 `Multiply` 的结果继续回送到位移链路中，用于影响最终 `Vertex Offset`
- 输出/预览
  - 左侧预览网格的外轮廓起伏比上一张更明显，表面已经形成更不规则的鼓包和中心凹陷
  - 说明加入缩放补偿后，位移效果开始更适配当前这类扁平 3D 水体网格

基于当前截图，可以确认作者在原有 `纹理 × 强度 × 法线` 的位移链上又引入了 `ObjectScale`，避免网格大小变化时顶点偏移看起来过强或过弱
这张图继续完善 `M_WaterVertexMove` 的顶点位移控制，当前重点是给“是否按缩放修正顶点乘法”增加一个 0 到 1 的开关参数

- 节点定义集
  - `T_VertexOffset`
    - 继续作为顶点位移噪声来源
  - 标量参数 `Vertex Offset Height`
    - `Default Value = 15.0`
  - `VertexNormalWS`
    - 继续提供位移方向
  - `ObjectScale`
    - 使用 `Scale XYZ`
  - `Lerp`
    - 节点标题可辨认为 `Lerp(1,0.5)`
    - `A = 1.0`
    - `Alpha = 0.5`
    - `B` 端当前不可清晰确认具体输入值
  - 标量参数 `Use Vertex Mult By Scale`
    - `Default Value = 0.0`
    - 教程字幕说明这个参数按 `0` 到 `1` 调用
  - `DebugFloat3Values`
    - 暂时接入链路中查看向量/标量结果
  - 多个 `Multiply`
    - 上游仍维持 `纹理 × 高度 × 法线` 的位移主链
    - 中下部 `Multiply` 与 `ObjectScale`、`Lerp`、开关参数共同参与缩放修正分支
  - 输出 `Vertex Offset`
- 连线集
  - `T_VertexOffset` 输出 -> 位移乘法链
  - `Vertex Offset Height` -> 位移强度乘法
  - `VertexNormalWS` -> 位移方向乘法
  - `ObjectScale.Scale XYZ` -> 缩放修正分支
  - `Use Vertex Mult By Scale` 参数 -> `Lerp`/控制分支，用于在关闭和开启缩放补偿之间插值
  - `DebugFloat3Values` 暂时用于预览/调试当前数值结果
- 输出/预览
  - 左侧预览窗口显示的是黑色底上的彩色数字和环状标记，说明当前不再直接看水面外形，而是在预览一个调试表达式结果
  - 字幕明确说明“如果不想使用，就从 0 到 1 调用它”，可确认这是一个可开关的控制项

这一张的核心不是新增视觉效果，而是把“按物体缩放修正顶点位移”做成可调参数。这样同一材质既能在需要时启用缩放补偿，也能在不需要时通过 `0~1` 的参数值逐步关闭该影响

### 00:31:40-00:36:08 UV、Multiply、Add

- 本段定位：UV、Multiply、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`Multiply`、`Add`、`Panner`、`Emissive`、`材质`。

**关键画面：**

这是 `M_WaterVertexMove` 中“按缩放修正顶点位移”分支的启用状态示例。当前截图把该开关参数设为 `1.0`

- 节点定义集
  - `ObjectScale`
    - 使用 `Scale XYZ`
  - 标量参数 `Use Vertex Mult By Scale?`
    - `Default Value = 1.0`
  - `Lerp`
    - 用于在不同缩放修正模式之间切换
    - 当前字幕说明“这里是 1”，即示范启用态
  - `VertexNormalWS`
  - 多个 `Multiply`
  - `DebugFloat3Values`
  - 输出 `Vertex Offset`
- 连线集
  - `ObjectScale.Scale XYZ` -> `Lerp`/缩放修正分支
  - `Use Vertex Mult By Scale?` -> `Lerp` 控制端
  - `Lerp` 输出 -> `DebugFloat3Values`
  - 上游 `Multiply` 链继续汇入右上侧 `Vertex Offset`
- 材质设置
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Cast Ray Traced Shadows` 启用
- 输出/预览
  - 左侧预览网格是一个带中心开口的灰蓝色碗状体
  - 表面棋盘格仍可见，便于观察形体变形是否均匀

这张图的核心是验证缩放补偿开关在 `1.0` 时的工作方式：顶点位移会按物体缩放参与计算，适合直接把材质应用到不同尺寸的 3D 水体网格上
这是 `M_WaterVertexMove` 的综合预览检查图。作者在保持发光颜色链路的同时，继续完善 `Vertex Offset` 分支，并直接观察 3D 水体网格最终会长成什么样

- 节点定义集
  - `Particle Color`
  - `Main Color`
  - `Multiply`
    - `Particle Color` 与 `Main Color` 相乘后继续参与上方颜色链路
  - `Vertex Offset` 命名重路由节点
  - 标量/向量参数 `Vertex Offset Direction`
    - `Default Value` 为蓝色向量，表示一个偏蓝的方向向量值
  - 纹理采样 `T_VertexOffset`
  - 多个 `Multiply`
    - 下方位移链仍由噪声纹理和方向参数共同驱动
- 连线集
  - `Particle Color -> Multiply`
  - `Main Color -> Multiply`
  - 下方 `T_VertexOffset` 输出 -> `Multiply`
  - `Vertex Offset Direction` -> 下方另一组 `Multiply`
  - 最终结果汇入紫色命名节点 `Vertex Offset`
- 输出/预览
  - 左侧预览中的 3D 网格不再只是平滑碗状，而是被顶起成不规则花瓣状/冠状水体
  - 中心仍保留凹陷区域，外圈形成一圈向上翻起的尖瓣
  - 字幕说明当前目的是直接看“它看起来像什么样”
- 性能统计
  - `Base pass vertex shader = 209 instructions`
  - `Texture samplers = 2/16`

本张图说明材质已经从“单纯波动表面”推进到“可塑形的 3D 水冠”阶段。`Vertex Offset Direction` 让位移不仅沿统一法线起伏，还能往指定方向偏转，从而把网格推成更夸张的冠状外轮廓
这张图展示了 `M_WaterVertexMove` 中一个用于整理 UV 数值范围的小节点段。教程说明它的作用是把负值转换为正值

- 节点定义集
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Mask (G)`
    - 只取纹理坐标的 `G` 通道
  - `Add(-0.5)`
    - `B = -0.5`
  - `Multiply(2)`
    - `B = 2.0`
  - 右侧仍可见但未接入本段的 `Particle Color` 与 `Main Color`
- 连线集
  - `TexCoord[0] -> Mask (G)`
  - `Mask (G) -> Add(-0.5)`
  - `Add(-0.5) -> Multiply(2)`
- 输出/预览
  - 左侧预览窗口当前是在预览 `Multiply` 节点结果
  - 预览球体上半部大面积为黑色，边缘与特定区域出现白色和黄色标记，说明这个表达式在观察某一轴向/某一区间的 UV 映射变化
  - 字幕明确说明“它将所有负值转换为正值”

按当前可见节点，这段运算等价于先取 `V` 坐标，再减去 `0.5` 让中心变为零点，随后乘以 `2` 扩展范围。结合教程解释，可以确认作者正在为后续材质效果准备一个对称且便于处理的 UV 纵向梯度，避免负区间直接参与后续计算

### 00:36:08-00:39:25 Material、Multiply、Power

- 本段定位：Material、Multiply、Power。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Multiply`、`Panner`、`Emissive`、`材质`、`纹理`。

**关键画面：**

这是 `M_WaterVertexMove` 里继续构建纵向遮罩的步骤。作者在上一段 `TexCoord -> Mask(G) -> Add(-0.5) -> Multiply(2)` 的基础上，再接入 `Abs`，把中心两侧的负值与正值折返成对称蒙版

- 节点定义集
  - `Mask (G)`
  - `Add(-0.5)`
    - `B = -0.5`
  - `Multiply(2)`
    - `B = 2.0`
  - `Abs`
  - 右侧仍可见但未接入本段的：
    - `Particle Color`
    - `Main Color`
    - 颜色用 `Multiply`
    - `Vertex Offset`
- 连线集
  - `Mask(G) -> Add(-0.5)`
  - `Add(-0.5) -> Multiply(2)`
  - `Multiply(2) -> Abs`
- 输出/预览
  - 左侧当前在预览 `Multiply(2)` 节点
  - 预览球体显示中心黑、外圈白的环状梯度
  - 字幕明确说明结果是“从 1 到 0，再从 0 到 1”，即形成一条关于中心线对称的遮罩

这一步的作用是把原本单向的 `V` 轴梯度改造成以中线为谷底、两边向外递增的双侧蒙版，后续可用于控制水体顶部/边缘的透明度、发光或位移权重
这是在刚才的对称蒙版基础上继续压缩和反相的步骤，用来得到一个更适合控制顶点影响范围的遮罩

- 节点定义集
  - `Power(X, 5)`
    - `Exp = 5.0`
  - `1-x`
    - 即 `OneMinus`
  - 命名重路由节点 `Vertex Maskd`
  - 下方仍可见但不属于本段主焦点的：
    - 位移用 `Multiply`
    - `Vertex Offset`
    - `Vertex Offset Direction`
- 连线集
  - 上游遮罩结果 -> `Power(X,5).Base`
  - `Power(X,5)` -> `1-x`
  - `1-x` -> 命名节点 `Vertex Maskd`
- 输出/预览
  - 左侧当前在预览 `1-x`
  - 预览球体几乎整体为白色，只有中心小圆区域颜色更深
  - 字幕说明“在 0 的地方，它的影响会更小”，可确认这个蒙版被设计为让某些核心区域影响减弱

这一步的语义是：先用 `Power` 把梯度曲线变得更陡，再通过 `OneMinus` 反相，让大部分区域保持高值，仅在指定中心/凹陷位置保留较低值。命名为 `Vertex Maskd` 后，可直接拿去乘顶点位移、颜色或透明度影响
这是回到 Unreal 关卡中的资源准备画面。作者已经选中一个高模圆柱/碗状静态网格，并准备基于前面调好的材质去创建材质实例

- 关卡视图
  - 空中仍是蓝色主球，正下方保留细小下落痕迹
  - 地面中央新增一个被选中的白色圆盘/浅碗状网格，周围有变换 gizmo
- 内容浏览器
  - 路径为 `Content > VFX_Library > Meshes`
  - 当前可见静态网格：
    - `SM_Circle_01`
    - `SM_Cone_01`
    - `SM_Cylinder_01`
    - `SM_CylinderHeightHighPoly_01`
    - `SM_TorusHighPoly_01`
  - 当前选中的是 `SM_CylinderHeightHighPoly_01`
- 右侧细节面板
  - 选中对象为 `SM_CylinderHeightHighPoly_01 (Instance)`
  - `Transform` 当前是 `Location=(0,0,0)`、`Rotation=(0,0,0)`、`Scale=(1,1,1)`
  - `Static Mesh` 指向 `SM_Cylinder...`
  - `Materials > Element 0` 当前还是默认网格材质预览球，尚未替换成新的水体实例
- 教程语义
  - 字幕明确说明“拿这份材料创建一个实例”

这张图标记了一个阶段切换：前面已经把 `M_WaterVertexMove` 的蒙版、位移和颜色逻辑准备好，接下来不再继续改主材质，而是要创建材质实例并把它挂到 `SM_CylinderHeightHighPoly_01` 这类 3D 网格上做场景测试

### 00:39:25-00:44:20 System、Spawn、Color

- 本段定位：System、Spawn、Color。
- 知识点：本段围绕 `Depth Fade`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle`、`Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Color`、`Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Spawn`、`Color`、`Alpha`、`Opacity`、`Material`、`Noise`、`Depth Fade`。

**关键画面：**

这是把 `M_WaterVertexMove` 做成材质实例后放回关卡测试的画面。当前已经能在主球下方看到一层发光的冠状 3D 水体，但边缘与地面的过渡还比较生硬

- 关卡结果
  - 空中仍是蓝色主球
  - 主球正下方是一条细下落痕迹
  - 地面位置出现一个亮青蓝色的冠状/碗状 3D 网格
  - 冠状网格顶部边缘参差起伏，中央留有开口或凹陷
- 内容浏览器路径
  - `Content > VFX_Library > Materials > MM > _Special > WaterSplash`
  - 当前可见资源包括：
    - `M_WaterBubble...`
    - `M_WaterVertexMove`
    - 一个蓝色缩略图的材质实例，名称被截断为 `...Move_Inst`
- 教程语义
  - 字幕明确说明“需要添加一个深度渐变，以便有柔和的过渡”

这张图说明材质实例化已经完成，并且 3D 网格在场景里的整体轮廓已基本成立。当前暴露的问题是网格与地面接触边缘过硬，因此下一步会在材质里加入 `Depth Fade` 来软化底部融合
这是材质实例 `MI_WaterVertexMove...` 的参数调节画面。作者一边查看冠状水体预览，一边在实例面板中细调软融合和顶点偏移参数

- 实例归属
  - 父材质为 `M_WaterVertexMove`
  - 当前打开的是该父材质对应的材质实例
- `Global Scalar Parameter Values`
  - `Depth Fade = 200.0`
  - `Use Vertex Mult By Scale? = 1.0`
- `Global Vector Parameter Values`
  - `Vertex Offset Direction` 已启用，当前是蓝色方向向量
- `Main Color`
  - `T_Main = T_NoiseSol_01`
  - `Colormap = VFX_T_ColorMap_Blue_01`
  - `Main (Scale/Scroll)` 已启用，但具体 `R/G/B/A` 数值在当前截图中不可完整辨认
- `Vertex Offset`
  - `T_VertexOffset = T_Inky_Smoke_Tile`
  - `Vertex Offset Height = 151.739075`
- `Material Property Overrides`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Two Sided` 启用
- 预览结果
  - 右侧预览窗口里，冠状水体底部与地面平面之间的过渡比前一张更柔和
  - 左侧父材质视图仍显示相同的冠状水体形态，便于对照实例参数的影响

这张图给出了本段最关键的实例参数：通过较大的 `Depth Fade` 值让底部边缘融入地面，同时用 `T_Inky_Smoke_Tile` 和较高的 `Vertex Offset Height` 维持冠状顶部的起伏强度
这是同一个 `M_WaterVertexMove` 材质实例的继续细调画面。当前重点是把速度和滚动相关参数显式暴露出来，并重新平衡冠状水体的形态强度

- `Global Scalar Parameter Values`
  - `Depth Fade = 200.0`
  - `Mask Exp = 15.0`
  - `Use Vertex Mult By Scale? = 1.0`
- `Global Vector Parameter Values`
  - `Vertex Offset Direction` 为蓝色方向向量
- `Main Color`
  - `T_Main = T_Noise17`
  - `Colormap = VFX_T_ColorMap_Blue_01`
  - `Main (Scale/Scroll)` 已启用，数值可确认为：
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = -0.2`
- `Vertex Offset (Scale/Scroll)`
  - 已启用
  - `R = 1.0`
  - `G = 1.0`
  - `B = 0.0`
  - `A = -0.1`
- `Vertex Offset`
  - `T_VertexOffset = T_Inky_Smoke_Tile`
  - `Vertex Offset Height = 100.0`
- 输出/预览
  - 右侧实例预览和左侧关卡中的冠状水体都比上一张更收敛，顶部尖峰更清晰，底部更稳定
  - 字幕明确提到“我们可以控制速度”，对应两组 `Scale/Scroll` 参数里的滚动分量

这张图把实例调节从“能显示”推进到“可控节奏”：通过 `Main (Scale/Scroll)` 和 `Vertex Offset (Scale/Scroll)` 的滚动参数控制主纹理与顶点噪声的流动速度，再用 `Mask Exp` 与 `Vertex Offset Height` 约束冠状边缘的锐度和整体振幅

### 00:44:20-00:47:44 Emitter、System、Spawn

- 本段定位：Emitter、System、Spawn。
- 知识点：本段围绕 `Particle`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Drag` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Scale Sprite Size` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Particle`、`Spawn`、`Alpha`、`Opacity`、`Scale Sprite Size`、`Material`、`Curve`。

**关键画面：**

这是 `LQ_StylizedWaterSplash` 关卡时间线中的结果确认画面。当前冠状 3D 水体已经挂到静态网格实例上，并和上方主球形成完整的上下层次

- 关卡结果
  - 上方仍有亮蓝色主球
  - 主球下方细线状下落痕迹连接到地面区域
  - 地面中央是一团亮青蓝色的冠状水体，顶部有多个高低不一的尖峰
  - 底部整体更厚、更发亮，说明材质实例已经生效
- Sequencer
  - 当前时间约为 `2.25s`
  - 轨道中仍有 `CameraActor`
  - `NS_StylizedWaterSplash` 作为持续轨道存在
- 右侧选中对象
  - 当前选中 `SM_CylinderHeightHighPoly_01 (Instance)`
  - `Scale` 可辨认为 `X=1.0`、`Y=1.0`、`Z=2.8076`
  - `Materials > Element 0` 已经替换为一个以 `MI_WaterVe...` 开头的水体实例材质

这张图说明材质实例与高模网格的组合已经能在关卡里直接工作。作者此时是在确认“冠状地面层 + 上方主球 + 下落连接”三者的时序和视觉关系已经成立
这是把关卡预览和 Niagara 编辑界面对照查看的画面。当前可以确认 `Empty` 发射器负责的网格层已经被压成接近地面的环状水涡，而不是前面更高的冠状尖峰

- 关卡结果
  - 上方仍有一串下落滴点
  - 地面主效果已经从高耸水冠变成较扁平的旋涡/环状波面
  - 中心存在一个较深的暗凹口，外圈绕出多层蓝色水纹
- `NS_StylizedWaterSplash > Empty`
  - 发射器结构可见：
    - `Emitter State = Self / Infinite`
    - `Spawn Burst Instantaneous`
    - `Initialize Particle`
    - `Initial Mesh Orientation`
    - `Particle State`
    - `Mesh Renderer`
  - 当前查看模块为 `Initial Mesh Orientation`
  - `Mesh Orientation = None`
  - `Rotation` 启用，值为 `(0.0, 0.0, 0.0)`
  - `Rotation Coordinate Space = Mesh`
- 时间线
  - 当前时间约 `2.31s`
  - `Empty` 轨道仍在参与当前帧

这张图说明作者开始把网格层从“抬起的水冠”重新调整为更贴地的涡旋底座，并通过 `Initial Mesh Orientation` 确保网格朝向与材质流动方向匹配，避免网格姿态导致旋涡方向错误
这一张继续调整 `Empty` 发射器的网格层，但重点已经从网格朝向切到随生命周期变化的缩放曲线

- 关卡结果
  - 地面效果是一个较扁平的蓝色环状水涡
  - 中心竖起一小段尖柱状水体
  - 上方仍有细小下落滴点
- `NS_StylizedWaterSplash > Empty`
  - 当前查看模块为 `Scale Mesh Size`
  - `Scale Factor = Vector from Curve`
  - `Curve for Vector3f`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - `Scale Curve` 当前基础值显示为 `1.0, 1.0, 1.0`
- 曲线关键信息
  - 截图高亮点显示：
    - `Name: Y`
    - `Time = 0.5`
    - `Value = 0.625`
  - 从曲线外观可确认在生命周期中段缩放值较低，随后继续向后段抬升
- 时间线
  - 当前时间约 `2.31s`

这说明 `Empty` 的网格层不是固定尺寸，而是通过 `Scale Mesh Size` 按粒子年龄动态变化。中段压到约 `0.625`，能让涡旋中心在生成后先收缩，再随着后段曲线回升，形成更自然的水涡呼吸感

### 00:47:44-00:52:42 Emitter、Spawn、Color

- 本段定位：Emitter、Spawn、Color。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Scale Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Emitter`、`Spawn`、`Color`、`Scale Color`、`Multiply`、`Add`。

**关键画面：**

这一张继续调 `Empty` 发射器的 `Scale Mesh Size`，但这次的重点从整体缩放转为横向拉伸，让地面水涡在生命周期后段向外铺开

- 关卡结果
  - 地面效果是中心立柱加外圈环状水纹
  - 外圈水涡比前一批更宽，已经表现出向平面扩散的趋势
- `Scale Mesh Size`
  - `Scale Factor = Vector from Curve`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - 当前查看的是 `Curve for Vector3f`
  - 字幕明确说明“现在 X 和 Y 将被拉伸”
- 曲线特征
  - X/Y 方向曲线从前段较低值逐步抬升
  - 在 `NormalizedAge = 0.5` 附近曲线约到 `0.8`
  - 后段继续上升并接近 `1.0`
  - Z 方向未见明显同步抬升，说明当前重点不是增高，而是横向扩张

这表示作者在把网格层的生命周期缩放拆成各轴独立控制：保持高度基本稳定，同时让 X、Y 随年龄增加而变宽，从而把中心尖柱周围的水面拉成更大的旋涡底盘
这一张开始把网格形体的“峰值高度”做成随生命周期衰减的动态材质参数。当前选中的仍是 `Empty` 发射器

- 关卡结果
  - 当前时刻地面网格更像一个较矮的蓝色半透明小柱体
  - 说明峰值已经被压低，不再保持前一阶段更高的尖峰
- `Empty` 发射器结构
  - `Emitter State = Self / Once`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
  - `Mesh Renderer`
- `Dynamic Material Parameters`
  - 当前在 `Index 0`
  - `Write Parameter Index 0` 启用
  - 参数名为 `Vertex Offset Influence`
  - 当前静态值显示 `0.0`
  - 下拉建议里可见 `Float from Curve`
  - `Link Inputs` 中可选：
    - `Emitter.curentLoopDuration`
    - `System.curentLoopDuration`
    - 两者名称均按界面原样显示为 `curentLoopDuration`
- 教程语义
  - 字幕明确说明“我希望在生命的过程中，峰值的高度也能逐渐降低”

按当前可见信息，这一步是在 Niagara 里新增一个动态材质参数通道，把材质里的 `Vertex Offset Influence` 交给粒子生命周期驱动。这样材质实例不再只有固定高度，而能在粒子临近结束时自动把冠状尖峰压低
这是把前面“横向拉伸 + 峰值随生命周期衰减”组合起来后的关卡结果确认图。此时地面层已经不再是持续扩散的涡面，而是一个更接近单次喷溅的竖直 splash

- 关卡结果
  - 地面主形体变成一束较集中的蓝色竖直水花
  - 顶部尖峰数量减少，整体更像一次瞬时向上喷起的 splash
  - 底部仍有柔和的蓝色辉光与地面融合
  - 上方还可见极细的下落痕迹，与地面 splash 形成同一轴线
- Sequencer
  - 当前时间约为 `2.67s`
  - 轨道中仍是 `CameraActor` 和 `NS_StylizedWaterSplash`
- 教程语义
  - 字幕说明“这里有一溅”，明确表示作者把当前层当作一次单独的 splash 事件来看待

这张图证明前面在 `Scale Mesh Size` 与 `Dynamic Material Parameters` 上做的生命周期控制已经起效：网格不再保持宽大的冠状涡旋，而会在当前时间窗内收束成一次更明确、更短促的中心喷溅

### 00:52:42-00:53:41 Material、Add

- 本段定位：Material、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Sequencer`、`Add`、`Panner`、`Emissive`、`材质`。

**关键画面：**

这是 `NS_StylizedWaterSplash` 中 `Empty` 发射器的 `Emitter State` 设置图。当前重点是给这层 splash 加入可配置的循环延迟

- `Empty` 发射器结构
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Spawn Burst Instantaneous 001`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
  - `Mesh Renderer`
- `Emitter State`
  - `Life Cycle Mode = Self`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Once`
  - `Loop Duration Mode = Fixed`
  - `Loop Duration = 1.0`
  - `Loop Delay` 启用，并绑定用户参数 `USER.Delay`
- 用户参数
  - 左下 `User Parameters` 中可见 `Delay = 2.4`
- 时间线
  - 当前播放位置约 `1.30s`
  - `Empty` 轨道单独拉出较长时段，说明它被视为一层可独立节奏控制的 splash

这一步是在把 `Empty` 从单纯“一次性触发”的层，改造成可通过用户参数控制启动间隔的网格 splash。`Delay` 允许同一系统里用不同时间偏移生成另一种 splash 节奏
这一张继续在 `Empty` 发射器的生成阶段做时间编排。作者选中了第二个爆发模块，用它在主 splash 之后再补一次延后出现的网格事件

- 关卡结果
  - 左侧预览里可见一个较平的蓝色旋涡/水圈
  - 这说明当前帧更接近 splash 展开后的平面阶段，而不是尖峰抬起阶段
- `Spawn Burst Instantaneous 001`
  - `Spawn Count = 1`
  - `Spawn Time = 0.1`
  - `Spawn Probability = 1.0`
  - `Loop Count Limit = 1`
- 发射器上下文
  - 当前 `Empty` 同时保留：
    - `Spawn Burst Instantaneous`
    - `Spawn Burst Instantaneous 001`
  - `USER.Delay = 2.4` 仍保留在用户参数中
- 时间线
  - 当前查看位置约 `3.00s`
  - `Empty` 轨道贯穿较长区间，说明这两个 burst 在同一发射器里承担不同阶段的形态变化

这一设置的含义是：`Empty` 先在起始时刻触发一次网格 splash，再在 `0.1s` 追加第二次单发爆发，让水体从初始竖向形态更自然地过渡到后续平面旋涡或回落阶段
这是 `M_WaterVertexMove` 的完整材质总览图，用于确认当前 splash 材质已经由多个功能块拼装完成，可以直接支撑实例化和 Niagara 动态参数驱动

- 材质整体结构
  - 上方一组负责主颜色与贴图流动
  - 中间一组负责 `Mask`/`Vertex Maskd` 一类的遮罩构建
  - 下方大块负责 `Vertex Offset`
  - 右侧汇总到材质主节点
- 可辨认的关键节点
  - `TexCoord`
  - `Panner`
  - 噪声纹理采样
  - `Main Color`
  - `Vertex Offset Direction`
  - `Vertex Offset`
  - `Particle Color`
  - 多个 `Multiply`、`Add`、遮罩整形节点
  - 红色函数节点 `Squeeze Position`
- 材质属性
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Two Sided` 启用
  - `Cast Ray Traced Shadows` 启用
- 输出/预览
  - 左侧预览仍是蓝色冠状 splash 网格
  - 底部统计可见：
    - `Base pass shader without light map = 128 instructions`
    - `Base pass vertex shader = 214 instructions`
    - `Texture samplers = 3/16`

这张图本身没有新增单个参数，而是对本段成果做收束确认：当前 `M_WaterVertexMove` 已同时具备颜色流动、遮罩控制、顶点位移和 Niagara 粒子颜色/动态参数接入能力，足以作为本页 splash 网格层的正式主材质

## 补充视觉证据

### S03 00:11:59

这是对 `S03 00:11:59` 的补充材质/参数证据图，作用是把 `Empty` 发射器在 `Initialize Particle` 里的颜色值精确到颜色选择器级别

- 系统上下文
  - 当前系统仍是 `NS_StylizedWaterSplash`
  - 可见相关发射器 `Dark_Puddle` 与 `Empty`
  - 当前选中 `Empty`
- `Empty` 发射器结构
  - `Emitter State = Self / Infinite`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Particle State`
  - `Mesh Renderer`
- `Initialize Particle`
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 5.0`
  - `Color Mode = Direct Set`
  - `Color` 当前打开了 Color Picker，精确值可确认：
    - `R = 0.0`
    - `G = 0.174935`
    - `B = 0.292411`
    - `A = 0.638175`
  - `Hex Linear = 002D4BA3`
  - `Hex sRGB = 007493A3`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 1.0)`
  - `Position Offset Coordinate Space = Simulation`
- 预览
  - 左侧预览仍显示上方暗环、下方椭圆水洼的双层地面形态

这张补充图把之前 `S03` 主线截图里只能粗读的颜色参数补全为精确数值，证明 `Empty` 地面层使用的是一组偏青蓝、半透明的深色基调，而不是纯蓝或纯灰

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


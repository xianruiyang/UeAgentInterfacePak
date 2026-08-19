# 09 Stylized Water Splash

# 09 Stylized Water Splash

## 关键术语

- `Update`、`Color`、`Scale Color`、`UV`、`Photoshop`、`Water`、`Mesh`、`粒子`、`系统`、`速度`、`Niagara`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`

## 分段知识

### 00:00:05-00:05:03 Photoshop、颜色

- 本段定位：Photoshop、颜色。
- 知识点：嘿!现在后续会在Photoshop里制作一个派出的特色 如果您看,它是非常细节的 而不是非常好画 后续会制作一个简单的形状 主要是为了展示它是如何被动画的。
- 知识点：如果您能做到,您可以制作这种特色 后续会怎么做?需要很简单地做到 我们先拿出蜡笛 制作波浪 然后关闭 太棒了 我们需要什么?后续会把它放入。
- 知识点：后续会它们安排好,以便我们制作细节 我们有10、24张照片 让我们看看,我没有很棒 我们把一些东西刮掉 然后我们完成 我们制作细节的形状。
- 知识点：我们制作了一种辣的配合 后续会制作更软的形状 这里您可以留下一些细节 预测圆形 预测的颜色有细节。
- 知识点：现在需要把预测圆形关掉 需要要把下面的部分刮掉 需要用柔软的刮刀 以提高它的透明性 需要要提高它的转向 需要提高 需要也用上抹黑刀 我没有很丢人的地方。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Photoshop`、`颜色`。

**关键画面：**

这一张是课程开场的水体参考板，用来说明本页要做的并不是写实流体，而是偏游戏化、可读性强的风格化水花

- 版面结构
  - 页面总标题为 `Water`
  - 左列主题为 `Stylized`
  - 右列主题为 `Realistic`
- 左侧 `Stylized` 参考
  - 多张来自游戏或作品集的蓝色/青色水花、护罩和水球效果
  - 重点特征是
    - 轮廓清晰
    - 高亮边缘明显
    - 颜色通常偏青蓝色
    - 形态夸张、便于快速识别
  - 中间还嵌有一张 `Watersplash Explanation` 说明图，展示水花由形状、遮罩和局部细节共同组成
- 右侧 `Realistic` 参考
  - 多张偏真实流体的水旋涡、喷溅、瀑布和液体拍摄/渲染图
  - 还包含白色喷溅素材图集
  - 重点特征是
    - 碎水更细密
    - 高光和折射更复杂
    - 体积和随机性更强
- 可见来源标注
  - 多张图下方保留了 `artstation`、`twitter` 等来源链接文字
  - 右下角有 `MORE VFX ACADEMY` 标识

这张图的作用是建立制作目标：本页教程选择左侧那类风格化水花语言，强调清晰的外轮廓、夸张的喷发形状和偏青蓝的发光质感，而不是追求右侧那种高度碎裂、折射复杂的写实水体
这一张进入 Photoshop 的基础形状绘制阶段，作者先从一张黑白遮罩开始，手工做出顶部不规则起伏的水面轮廓

- 当前软件界面
  - 软件为 `Photoshop`
  - 左侧可见颜色环、滑条、笔刷列表和笔刷设置
  - 顶部当前工具为涂抹/笔刷类工具，`Strength` 约为 `22%`
  - 右侧图层面板显示
    - `Layer 1`
    - `Layer 0`
- 画布内容
  - 画布中心是一张黑底方形图
  - 下半部分被白色实形填满
  - 白色区域的顶部边缘做成连续起伏的波浪状轮廓
  - 顶边包含多个大小不同的圆润凸起和凹口
  - 底边略微弯曲，不是完全水平直线
- 形状语义
  - 这类黑白图更像后续水花纹理/遮罩的底稿
  - 白色区域代表保留形体
  - 黑色区域代表透明或被裁掉的部分
  - 先做大形，再往上叠加小细节，是风格化水体常见流程

这张图对应本段 `Photoshop` 的第一步：作者不是直接画复杂喷溅，而是先建立一块大面积白色主体，再通过顶部的波浪起伏定义水面边缘，为后续继续刮削、提亮、加细丝状水花细节打底
这一张继续处理同一张黑白水面遮罩，作者对边缘做高斯模糊，并专门检查图像在横向拼接时是否还能保持平滑过渡

- 当前软件界面
  - 软件为 `Photoshop`
  - 右侧弹出 `Gaussian Blur` 对话框
  - `Preview` 已启用
  - 当前 `Radius = 9.8 Pixels`
  - 图层面板仍显示
    - `Layer 1`
    - `Layer 0`
- 画布内容
  - 画面放大查看黑白遮罩的上边缘与下边缘
  - 原本较硬的白黑交界已经被明显柔化
  - 顶部波浪起伏边缘保留大形，但过渡变得更软
  - 底部也出现较大范围的模糊羽化
- 操作语义
  - 字幕明确提示当前目标是检查是否保留了 `tiling`
  - 说明这张图不是只给单张使用，而是要考虑横向平铺后是否会出现接缝
  - 高斯模糊的作用是让遮罩边缘更柔顺，避免后续贴到材质里时边缘过硬

这张图对应本段 `Photoshop` 的平铺处理步骤：作者对黑白水面形状做约 `9.8` 像素的模糊，并同时核对拼接连续性，确保这张遮罩后续作为可平铺纹理或可重复的材质条带时，不会在接缝处突然断开

### 00:05:03-00:07:46 关键流程 02

- 本段定位：关键流程 02。
- 知识点：需要修正 我们再用抹黑刀 我们去到模式预测 抹黑刀是 在 Unreal Engine 中 缓缓转转 我们不要忘了8bit 现在可以播放 我播放了。
- 知识点：现在我们快速创造一种材料 把涂涂的涂涂 刷上来 把涂涂的涂涂 把涂涂脱 잤 把涂涂料 去除 位置 只顺着 Worl廋 在拆铛里 让涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂涂。
- 知识点：union 大小 地面 这样 我们刷了这样子 走几个路 盒头 需要大小 我们把兩邊放在这里 如果我们把这个物体拿出来,把它们的尺寸,这里,你也可以改变它的尺寸。
- 知识点：增加数量 现在,我拿了一个类似的物体,或者你也可以拿一个像这个。

**关键画面：**

这一张继续在 Photoshop 里打磨平铺水面遮罩，作者开始针对波峰和接缝附近的形状做局部修整，让起伏更自然

- 当前软件界面
  - 软件为 `Photoshop`
  - 左侧仍显示颜色环、滑条、笔刷列表和笔刷设置
  - 当前工具仍是柔化/涂抹类笔刷
  - `Strength` 约为 `22%`
  - 当前笔刷大小约 `50 px`
  - 图层区仍为 `Layer 1` 与 `Layer 0`
- 画布内容
  - 黑底白形遮罩被进一步放大查看
  - 顶部波浪边缘由多个大中小波峰组成
  - 中央可见一条较浅的竖向接缝/边界参考线
  - 作者当前光标位于一个较高的尖峰附近，说明正在单独修整这个局部峰值
  - 白色主体的下缘也已被大面积模糊羽化
- 可确认语义
  - 这一阶段不是新增大形，而是在已有轮廓基础上微调波峰间距、圆润度和过渡
  - 接缝附近单独放大处理，说明作者在意这张纹理横向平铺时的连续性

这张图对应 `关键流程 02` 的继续细化步骤：作者在保持整体平铺逻辑不变的前提下，逐个修整波峰形状，让水面边缘既有起伏变化，又不会在重复拼贴时出现突兀断点
这一张切到 Unreal Engine 的材质实例编辑，作者把刚做的水花形状快速接进材质里，并开始配置 dissolve、扭曲和边缘淡化参数

- 当前对象
  - 当前打开的是材质实例 `MI_Splash_02`
  - 顶部还可见相关资源标签
    - `SM_CylinderBowl_01`
    - `SM_CylinderHeight_01`
    - `T_SplashTile_01`
- 视口预览
  - 左侧预览是一个半透明白色 splash 壳体
  - 当前主要显示整体体积和材质边缘，而不是最终蓝色上色结果
- 可见参数分组与设置
  - `T_Dissolve = T_Swirly_Noise`
  - `Dissolve (Scale|Scroll)`
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = 0.0`
  - `Smoothness = 0.5`
  - `Distortion`
    - `Distortion (Scale|Scroll)`
      - `R = 1.0`
      - `G = 1.0`
      - `B = 0.1`
      - `A = 0.3`
    - `Distortion Influence = 0.04`
    - `T_Distortion = T_Voronoise002`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 100.0`
  - `Parent = M_UberMaterial`
- 材质属性覆盖
  - `Blend Mode = Additive`
  - `Shading Model = Unlit`
  - 其余若干 override 当前未启用

这张图对应 `关键流程 02` 里“快速创造一种材料”的步骤：作者把 swirl/voronoise 两类噪声分别用于溶解和扭曲，再配合较大的 `Depth Fade` 和 `Additive + Unlit` 的材质模式，先搭出一层适合风格化水花的基础壳体材质
这一张继续调 `MI_Splash_02` 的材质实例，作者在保持 additive 材质框架不变的前提下，进一步拉大边缘淡化范围，并允许双面显示

- 当前对象
  - 当前仍为材质实例 `MI_Splash_02`
- 左侧预览结果
  - 预览中的白色形状更像一条贴地的波浪/水边条带
  - 顶部连续出现多个小波峰
  - 说明当前材质已经从单纯壳体测试，逐渐转向可平铺水边形状的验证
- 当前可见参数
  - `Distortion (Scale|Scroll)`
    - `R = 1.0`
    - `G = 1.0`
    - `B = 0.0`
    - `A = 0.3`
  - `Distortion Influence = 0.04`
  - `T_Distortion = T_Voronoise002`
  - `Depth Fade = 200.0`
  - `Parent = M_UberMaterial`
- 材质属性覆盖
  - `Blend Mode = Additive`
  - `Shading Model = Unlit`
  - `Two Sided` 已启用
  - 其他 override 多数仍未启用
- 可确认语义
  - 把 `Depth Fade` 从前一张的 `100.0` 提到 `200.0`，会让靠近地面或交界处的淡化范围更大
  - `Two Sided` 允许这类薄片/条带从两侧都能被正确看到，更适合用于 splash 边缘或波浪贴片

这张图对应 `关键流程 02` 的材质定型步骤：作者把这张水边形状材质调成更适合贴地使用的条带效果，通过更大的 `Depth Fade` 和 `Two Sided` 显示，减少薄片穿插时的硬边问题，并让它在不同观察角度下都保持可见

### 00:07:57-00:10:50 Color、Water、Mesh

- 本段定位：Color、Water、Mesh。
- 知识点：它像这个样子,只是它的質料是不一樣的,原理上它们都一樣 Mesh Water Splash 可以被剪輯 可以試試这个或这个3D物体,然后看看結果。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Map 这里是另一个选择 这里是这个3D物体,可以試試这个 这里太高了,这里太高了,这里需要改变 例如3或4 我喜欢它更好,再用一个3D物体。
- 知识点：这樣,看起来更好 现在,我们看看它们都如何結合 可以把这个和这个拼起来 我们把这里剪掉 可以把这里的这个选择切掉 需要畫出不同的質料。
- 知识点：这兩个效果的原理是一樣的 如何被动画,如何被完成 哪个3D物体,哪个質料 創作技巧是一樣的,我们只看到颜色,它必须被換掉。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`颜色`。

**关键画面：**

这一张回到 Niagara System 总览，作者把新的材质和网格组合挂到完整水花系统里，先检查 `MeshWaterSplash` 这层主喷发网格的基础初始化参数

- 当前系统结构
  - 上排可见发射器
    - `Water Sphere Mesh`
    - `Water Sphere Glow`
    - `Bubbles Around Sphere`
    - `Dots Around Sphere`
    - `Dots Dark Around Sphere`
    - `Water Drips`
    - `Dark Puddle`
    - `Puddle Waves`
  - 下排可见发射器
    - `Mesh Water Splash`
    - `Ground Glow`
    - `Ground Dark`
    - `Ground Waves`
    - `Water Ring`
    - `Water Splash Sides`
    - `Water Splas... Center`
- 当前选中对象
  - `MeshWaterSplash > Initialize Particle`
- `Initialize Particle` 可见设置
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 2.0`
  - `Color Mode = Unset`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 0.0)`
  - `Mass Mode = Unset / (Mass of 1)`
  - `Sprite Size Mode = Unset`
  - `Sprite Rotation Mode = Unset`
  - `Sprite UV Mode = Unset`
  - `Mesh Scale Mode = Non-Uniform`
  - `Mesh Scale = (2.0, 2.0, 0.5)`
  - `Mesh Renderer Array Visibility Mode = Unset`
- 系统上下文
  - 时间线位置约 `2.64s`
  - `USER.Delay = 2.4`
  - 左侧预览当前是高亮青蓝色的主喷发网格，说明这层 mesh 已经在系统里正常工作

这张图对应本段 `Color`、`Water`、`Mesh` 的组合检查：作者先确认新的水花材质在 `MeshWaterSplash` 上成立，同时保持 `2.0` 秒生命周期和 `(2.0, 2.0, 0.5)` 的非等比缩放，让主喷发层既高耸又有一定压扁感
这一张继续调整主 mesh 水花的体积变化，作者在 `MeshWaterSplash001` 上用曲线控制整个生命周期中的三轴缩放

- 当前可见发射器
  - 左侧可见 `Water_Splashes_Cent`
  - 当前选中为 `MeshWaterSplash001`
- `MeshWaterSplash001` 当前模块结构
  - `Emitter State = Self / Once`
  - `Spawn Burst Instantaneous`
  - `Spawn Burst Instantaneous 001`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 当前选中对象
  - `MeshWaterSplash001 > Scale Mesh Size`
- `Scale Mesh Size` 可见设置
  - `Scale Factor = Vector from Curve`
  - 曲线使用 `Curve for Vector3's`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - 当前三轴 `Scale Curve` 数值为
    - `X = 1.2`
    - `Y = 1.2`
    - `Z = 8.0`
- 曲线趋势
  - `X` 轴曲线整体缓慢上升，前段较小，后段接近 `1`
  - `Y` 轴与 `X` 轴走势接近，同样缓慢增大
  - `Z` 轴前段快速抬升到峰值，随后明显回落到较低值
- 系统上下文
  - 时间线位置约 `2.64s`
  - `USER.Delay = 2.4`
  - 左侧预览可见一条被拉高的青蓝色 mesh 水柱

这张图对应本段 `Water`、`Mesh` 的形体动画步骤：作者让主水花在生命周期前段先沿 `Z` 轴迅速拔高，随后逐渐回缩，同时 `X/Y` 只做较温和的扩张，这样主 mesh 会先形成尖高喷发，再慢慢收回到更窄的体积
这一张回到关卡视口里看当前效果，作者强调此时观众首先读到的是颜色和发光分层，而不是复杂的网格结构

- 当前界面
  - 编辑器停留在关卡视口
  - 底部 `Sequencer` 已打开
  - 可见轨道仍为 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash`
  - 播放头位于约 `2.27s`
- 画面结果
  - 中央偏下位置是一团较弱的蓝色发光斑
  - 上方有一团更亮、更集中的青蓝色高光
  - 两团光之间有明显间隔，说明当前更强调层次关系和阅读顺序，而不是把全部细节堆在同一位置
  - 整体画面仍然相当简化，几何边缘并不明显
- 可确认语义
  - 字幕说明“我们只看到颜色”
  - 说明这一阶段作者更在意色块、亮度和层级分布
  - 也意味着主形体或材质细节还会继续往后完善

这张图对应本段 `Color`、`Water`、`Mesh` 的结果判断：作者用镜头验证当前水花是否已经具备可读的青蓝发光层次，即使暂时还看不清复杂几何，也要先保证观众能读到“亮的主体”和“较暗的底部”这两个核心色层

### 00:11:00-00:15:42 Color、Scale Color

- 本段定位：Color、Scale Color。
- 知识点：还有Color,可以再加上它 这樣会更亮 可以換成Scale Color 要創作,但我们需要更快的減少 可以用这个,但仍然需要再加上。
- 知识点：但需要要展示,如何可以这樣創作 这里太亮了,Scale Color可以換成20,但5 我已经展示给你了,可以做不同的改变,用它们一起玩。
- 知识点：但现在需要要專注在这个物体 我認为它很小 这里需要增加高度和幅度 不是高度,是在X和Y旋律上增加 可以增加其他东西與它有關 例如,同樣的地面波。
- 知识点：可以增加它 3,4,3,4,3,4 可以用它来测试 这里可以加1.5 这里可以增加噴射的大小 250,这里会是450,600 不,太大了,我们把它留下来。
- 知识点：Ctrl Z,轉回来 旁邊的也太大了,让它们有这个大小 上方的也要增加,这里好像是350,450 看起来更好 让我们加更多的細節 一些波浪。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`Scale Color`。

**关键画面：**

这一张开始处理主 mesh 水花的初始颜色，作者在 `MeshWaterSplash001` 的 `Initialize Particle` 中直接开色板，先把基础色设成中性白色

- 当前可见发射器
  - 左侧可见 `Water_Splashes_Cen`
  - 当前选中为 `MeshWaterSplash001`
- 当前选中对象
  - `MeshWaterSplash001 > Initialize Particle`
- `Initialize Particle` 可见设置
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 2.0`
  - `Color Mode = Direct Set`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, 0.0)`
  - `Mass Mode = Unset / (Mass of 1)`
  - `Mesh Scale Mode = Non-Uniform`
  - 当前可见 `Mesh Scale` 两个轴为 `1.0`、`1.0`
- `Color Picker` 当前可见数值
  - `R = 1.0`
  - `G = 1.0`
  - `B = 1.0`
  - `A = 1.0`
  - `H = 0.0`
  - `S = 0.0`
  - `V = 1.0`
- 系统上下文
  - 时间线位置约 `2.64s`
  - `USER.Delay = 2.4`
  - 左侧预览当前主喷发表现为浅青蓝/白色高亮，说明白色基底会叠加到现有材质发光上

这张图对应本段 `Color` 的第一步：作者把主 mesh 水花的粒子基础色先归一到纯白，这样后续无论是 `Scale Color`、材质发光还是系统级颜色叠加，都有一个不带色偏的基准起点
这一张切到关卡视口做结果观察，说明作者已经把主喷发亮度衰减得更快，当前主要剩下一圈贴地的蓝色余辉

- 当前界面
  - 编辑器停留在关卡视口
  - 底部 `Sequencer` 已打开
  - 可见轨道仍为 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash`
  - 播放头位于约 `3.20s`
- 画面结果
  - 中央只剩一圈较低矮的蓝色光环/水环
  - 中心区域有更柔和的蓝色发光斑
  - 主喷发的高耸水舌已经消退
  - 外圈亮边仍然清晰，说明地面层与中心层分离良好
- 可确认语义
  - 这一结果与正文中“需要更快地减少”“这里太亮了”的调参目标一致
  - 当前阶段更关注消退后的残留层次，而不是爆发峰值

这张图对应本段 `Scale Color` 的结果验收：作者让高亮主喷发在中后段更快收掉，只保留一圈贴地的蓝色残光和中心柔光，从而避免整套水花在后半程依然显得过亮、过重
这一张开始回到中心 sprite 层加更多细节，作者在 `Water_Splashes_Center` 的 `Initialize Particle` 中增大尺寸范围，并保持青蓝色与轻微旋转差异

- 当前系统结构
  - 上排与下排发射器总览可见，当前选中 `Water_Splashes_Center`
- 当前选中对象
  - `Water_Splashes_Center > Initialize Particle`
- `Initialize Particle` 可见设置
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.0`
  - `Lifetime Max = 0.5`
  - `Color Mode = Direct Set`
  - `Color` 为青蓝色
  - `Position Mode = Unset`
  - `Mass Mode = Unset / (Mass of 1)`
  - `Sprite Size Mode = Random Non-Uniform`
  - `Sprite Size Min = (150.0, 350.0)`
  - `Sprite Size Max = (250.0, 450.0)`
  - `Sprite Rotation Mode = Direct Angle (Degrees)`
  - `Sprite Rotation Angle = Lerp Float`
    - `A = -5.0`
    - `B = 5.0`
    - `Alpha = Return Normalized Exec Index`
    - `Normalized Index Scale = 1.0`
    - `Normalized Index Includes On` 已启用
  - `Sprite UV Mode = Random X`
  - `Mesh Scale Mode = Unset`
  - `Mesh Renderer Array Visibility Mode = Unset`
- 下方可见后续模块起点
  - `Add Velocity`
    - `Velocity Mode = In Cone`
    - `Velocity Speed = Random Range Float`
    - 当前至少可见 `Minimum = 200.0`
- 系统上下文
  - 时间线位置约 `2.64s`
  - `USER.Delay = 2.4`
  - 左侧预览主喷发旁边已有更多细碎蓝色条状细节
  - 字幕说明这些元素会作为后续生成在上方的泡沫/细节粒子

这张图对应本段“增加更多细节”“旁边和上方也要增加”的调整：作者把中心 splash 的非等比尺寸范围进一步放大到 `150-250` 与 `350-450` 的区间，同时保留微小旋转差异和 `Random X` 取样，让上层细节粒子数量和视觉复杂度一起增加

### 00:15:42-00:20:41 速度

- 本段定位：速度。
- 知识点：我们必须要確保有延迟 这里需要增加爆发的数字 这里会是15 我们适当增加生命的数字 在某种範圍內 颜色是正常的。
- 知识点：我認为大小应该要改变 形状的位置 我们必须要加这个 让它们在圆形里 我们来看看結果 我理解它们还没被移动 我们不需要轉圈 它们在这里爆发 但它们有點難看。
- 知识点：因为我们必须要加速度 让它们升起来 让它们有掩護 因为如果我把它设置为0 它们只会在这塊碼的邊緣上 它们会有掩護 这是可观察到的 它们会升起来。
- 知识点：但它们只会在邊緣上 需要它们会在这塊碼上 所以需要增加它们的数字 我们有了所有的东西 需要加一个随机的範圍 從25到50 它们会增加 我还是想把它们适当動動。
- 知识点：加上了一些有趣的動作 它们会很快地增长 它们会在这里爆发 如果我们看看 它们在哪里 我增长 再增长一点 再增长一点 再增长一点 它们不可能在这里很顯着。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这是 `NS_StylizedWaterSplash` 的系统总览与时间线截图，当前选中发射器 `Bubbles_AroundSphere001` 的 `Spawn Rate`

- 预览窗口显示主体水花外围有少量向上漂浮的蓝色气泡点，底部有一层较亮的圆形水面辉光
- 时间线播放头位于约 `2.64s`
- 左下 `User Parameters` 中可见用户参数 `Delay = 2.4`
- 当前模块为 `Spawn Rate`，`SpawnRate` 的输入方式为 `Float from Curve`
- 曲线编辑器中使用 `Curve for Floats`
- `CurveIndex` 使用 `Multiply Float`
- `A = EMITTER.Age`
- `B = 0.6`
- `Scale Curve = 20.0`
- 曲线形态从时间起点约 `0.8` 逐步下降到末端接近 `0.0`，表示气泡生成频率会随发射器时间推进持续降低
这是 `NS_StylizedWaterSplash` 中 `Bubbles_AroundSphere001` 发射器的 `Scale Color` 设置，用曲线控制粒子透明度随生命周期变化

- 预览窗口中主体水花已经明显减弱，只剩中央少量蓝色细碎反光与底部较淡的圆形辉光
- 时间线播放头位于约 `3.73s`
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`，说明颜色色相不变
- `Scale Alpha` 启用 `Float from Curve`
- 曲线编辑器为 `Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线关键走势为：起点透明度接近 `0.0`，在 `Time = 0.1` 处快速抬升到 `Value = 0.8`，随后沿对角线持续下降，到生命周期末端再次接近 `0.0`
- 该设置的效果是让气泡粒子先快速显现，再在后半段逐步淡出
这是 `NS_StylizedWaterSplash` 在关卡序列器中的结果验收画面，用来检查前面气泡、颜色和速度调节后的整体收尾效果

- 视口处于 `CameraActor` 取景
- 时间线播放头位于约 `3.57s`
- 序列器中可见轨道 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash`
- 主体高喷发与外围大颗粒基本已经消退
- 画面中央只保留一团亮青蓝色核心辉光
- 核心外侧包着较暗的蓝色圆环与更大范围的淡雾状扩散层
- 整体表现更接近水花爆发结束后的残留能量和地面湿润光晕，而不是上升中的喷溅阶段

### 00:20:41-00:25:40 系统、速度、颜色

- 本段定位：系统、速度、颜色。
- 知识点：需要有預期 并会有氛圍 并会有降溫 氣氛会上升 總括来說 这个时间線的时间線 会提升 需要把相機延长 我们看到 氣氛会在7秒 需要加一些氣氛会在这里爆发。
- 知识点：很快 这会是氣氛爆发 会很快爆发 它们会在1-2秒 大小基本上是正常的 需要改变氣氛的位置 然后改变氣氛的位置 去打 它会在这里是0 让它在255个。
- 知识点：particle里面 虽然这很多 我看了一下它应该是什么样的大小 我们再回到Ring 这是我必须改变的地方 这里应该是一个box 我把它放在0。
- 知识点：为什么我把它放在0 因为这是一个 pivot 如果我放在1,box就在最底 0.5在中间 这是box的 pivot 因此我把它在很远的位置重新调整。
- 知识点：但太多个 particle 选项级从15到25 加速从50到100 可能我还会增加形态的位置 再重新调整从5到10 小小的生命 缺乏宣泄 在丰盛时会有泡泡。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`系统`、`速度`、`颜色`。

**关键画面：**

这是 `NS_StylizedWaterSplash` 在关卡序列器中的结果验收画面，用于观察系统在爆发中段的整体体积和亮度

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `2.52s`
- 序列器中可见 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash` 三条轨道
- 画面中央是一团强发光的青白色主喷发，整体呈上窄下宽的竖向簇状
- 主体由多条细长水滴束向上喷出，外围两侧有少量外扩的短条状飞溅
- 底部保留一圈较厚的蓝色圆形基座光晕，说明地面波纹和中心辉光仍在持续
- 背景中还能看到大范围较暗的蓝紫色雾化扩散层，用于托起主喷发的体积感
这是 `NS_StylizedWaterSplash` 中新增气泡发射器的系统视图，当前选中 `Bubbles_SplashBurst` 的 `Shape Location`

- 系统视图里并排可见两个发射器：左侧 `Bubbles_SplashSpawn`，右侧 `Bubbles_SplashBurst`
- 时间线播放头位于约 `3.73s`
- 预览窗口左侧只剩大面积贴地的蓝色柔和圆环，说明当前系统已进入后段收尾状态
- `Bubbles_SplashBurst` 的 `Emitter Update` 下可见 `Spawn Burst Instantaneous`
- `Particle Spawn` 下可见 `Initialize Particle`、`Shape Location`、`Add Velocity Linear`
- `Shape Location` 的 `Shape Primitive = Box / Plane`
- `Box / Plane Mode = Box`
- `Box Size = (100.0, 100.0, 300.0)`
- `Box Midpoint = (0.5, 0.5, 0.0)`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`
- 从这个设置可知，该发射器会在以系统位置为原点的长方体空间内生成一批气泡粒子，高度范围明显大于平面宽度
这是 `NS_StylizedWaterSplash` 的关卡序列器结果图，用于验收系统在后段只保留地面能量残留时的视觉状态

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `3.10s`
- 序列器中可见 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash` 三条轨道
- 主喷发柱体已经完全消失，画面中心只剩一个低矮的蓝色椭圆形能量核
- 能量核外侧能看到两到三圈同心的水波纹样亮环，颜色从中心亮青色向外过渡到较暗的蓝色
- 更外层仍包着一层大范围、低对比度的蓝紫色雾状辉光，用于维持湿润和余波氛围
- 这一帧说明系统尾段主要依赖地面环形贴片、中心柔光和环境雾化层来收束效果

### 00:25:40-00:27:50 粒子、速度

- 本段定位：粒子、速度。
- 知识点：它们不会有阻力 我们加速度 它们会在时间内降低 它们会飞上去 我们加一点减少 这里如果我设定500的价值 这已经太多了 50就足够了 我们也在调整。
- 知识点：构团的速度是0.5 它们也会是0.5 它们太大了 我们调整它们的减少 加速的Droplet还在飞 需要这些Droplet 在影响上 构团的小。
- 知识点：现在需要教你们怎么做 这是我们新的一支 叫做阻力阻力 我们的粒子可以有阻力 这里有很多的设定 我们想阻力发生的 是Rey Traced 这里的设定 可以被视觉的。
- 核对对象：`粒子`、`速度`。

**关键画面：**

这是 `NS_StylizedWaterSplash` 的关卡序列器结果图，用于观察系统在起始阶段尚未爆发时的底层氛围

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `0.52s`
- 序列器中可见 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash` 三条轨道
- 画面中央没有明显可辨认的水花主体、飞溅条带或亮环结构
- 只保留一层很弱的蓝紫色弥散雾光，中心区域亮度略高于四周
- 这一帧可用于确认系统前摇阶段主要依靠低强度环境辉光铺底，而不是立刻出现强喷发
这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `DropsTop` 的 `Curl Noise Force`

- 系统视图中左侧还能看到相邻发射器 `Bubbles_SplashBurst`
- 预览窗口里可见若干细小的蓝白色水滴条带向外散开，背景仍有一层大面积圆形柔光
- 时间线播放头位于约 `3.73s`
- `DropsTop` 的 `Particle Spawn` 下可见 `Initialize Particle`、`Add Velocity In Cone`
- `Particle Update` 下可见 `Particle State`、`Gravity Force`、`Curl Noise Force`、`Solve Forces and Velocity`、`Scale Sprite Size by Speed`、`Scale Color`
- 当前模块 `Curl Noise Force` 的参数为：
- `Noise Strength = 50.0`
- `Noise Frequency = 25.0`
- `Noise Quality / Cost = Baked (Medium)`
- `Pan Noise Field = (1.0, 0.0, 0.0)`
- `Mask Curl Noise` 未启用
- 这组设置表示顶部水滴在受重力下落或抛散时，还会叠加一层沿 X 方向平移的卷曲噪声，让轨迹不至于过直
这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `DropsTop` 的 `Collision`

- 时间线播放头位于约 `3.73s`
- 预览窗口中可见中心蓝色旋涡状地面亮环与少量空中的细小水滴，说明当前碰撞模块用于控制顶部掉落水滴与场景的交互
- `Collision Mode` 区域中可见：
- `CPU Collision Type = Ray Traced`
- `Collision Enabled` 已启用
- `Collision Radius` 区域中可见：
- `Radius Calculation Type = Sprite`
- `Method for Calculating Particle Radius = Bounds`
- `Particle Radius Scale = 1.0`
- `Bounce` 区域中可见：
- `Restitution = 0.6`
- `Restitution Coefficient Blending = Ignore`
- `Control Roll On Collision` 未启用
- `Friction` 区域中可见：
- `Simple Friction` 已启用
- `CPU Friction Blending = Ignore`
- `Friction = 0.25`
- `Friction During a Bounce = 0.0`
- `Rest` 区域中可见：
- `Enable Rest State` 已启用
- `Maximum Penetration Correction Distance = 0.5`
- `Percentage of Penetration Before Rest = 1.0`
- `Rest State Time Range = 0.5`
- `Ray Trace Properties` 区域中可见：
- `CPU Collision Trace Channel = WorldDynamic`
- `CPU Trace Vector Length Multiplier = 5.0`
- `Max CPU Trace Length = 500.0`
- 这组设置说明顶部落滴使用 CPU 射线碰撞检测地面，允许一定反弹与摩擦，并在满足条件后进入静止状态

### 00:28:42-00:33:37 关键流程 08

- 本段定位：关键流程 08。
- 知识点：如果我们不想 阻力阻力 我们把个人带回来 个人有个设定 我们有个人 我们想他在舞台上 但我们不想阻力阻力 所以可以把他们弄掉 可以这样做。
- 知识点：如果我没错 阻力阻力的设定 这里没有阻力 我把这个没有阻力的设定放在这里 这个人好像在这里 但没有遇到他 他在这里不见了 我通常把阻力阻力都关掉。
- 知识点：在之前我们有了一些设定 现在我把他们关掉了 我把这个人再次遮住 看看有没有区别 他们会跳 他们会跳 我们有阻力阻力 他们会跳 这种阻力阻力 会影响他们的阻力。
- 知识点：如果我把他们放在0 他们不会跳 他们不会再跳 阻力阻力是阻力的力量 在阻力后 他们会在地面上挤到 所以如果我们把他们放在0 他们会挤这么多。
- 知识点：如果我们把他们放在1 他们会立刻停止 立刻停止 我认为现在 阻力应该被放在1 我们有阻力阻力 我还希望阻力数量 能够达到1 有时候可能会有 很多阻力阻力。
- 知识点：我们不需要阻力 因为我们现在 会把阻力阻力 和阻力阻力的阻力 放在1 现在需要示范 我们已经学会了 阻力是什么 例如阻力 有些动作发生在我们身上。
- 知识点：我们就会反应到它 在这种情况下 需要发生阻力 阻力死了 或者阻力与某些东西 变成了阻力的位置 在这种情况下 我们需要阻力的事件 这里我们有一个警告。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。

**关键画面：**

这是 `NS_StylizedWaterSplash` 的关卡序列器结果图，用于观察中段画面中独立上抛水滴与地面残留光效的关系

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `2.05s`
- 序列器中可见 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash` 三条轨道
- 画面上半部只有一个亮青蓝色的独立椭圆形发光粒子，位置明显高于地面中心
- 地面中心仅保留一小团较弱的蓝色柔光核，没有明显外扩喷发
- 背景仍覆盖一层大范围、低对比度的蓝紫色雾状辉光
- 这一帧可用于确认系统中某些顶部水滴或独立粒子会在主体爆发之后单独悬停或落下，而地面效果已进入低强度阶段
这是关卡视口与角色实例详情面板截图，当前不是 Niagara 系统面板，而是选中了场景中的 `Gideon_Inquisitor` 实例

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `2.28s`
- Outliner 中当前高亮对象为 `Gideon_Inquisitor`
- 右侧 `Details` 面板顶部可见对象层级：
- `Gideon_Inquisitor (Instance)`
- `SkeletalMeshComponent (SkeletalMeshComponent0)`
- 当前展开的是 `Physics` 分类
- 图中可明确辨认的 `Physics` 参数包括：
- `Simulate Physics` 未启用
- `Linear Damping = 0.01`
- `Angular Damping = 0.0`
- `Enable Gravity` 已启用
- `Physics Transform Update Mode = Simulation Updates Component Transform`
- `Apply Impulse on Damage` 已启用
- `Replicate Physics to Autonomous Proxy` 已启用
- 视口中央仍只有一层较弱的蓝紫色环境辉光，没有明显的喷发主体
这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `Empty` 的 `Initialize Particle`

- 系统视图中可见左侧相邻发射器 `DropsTop`
- `Empty` 发射器的 `Emitter State = Self Infinite`
- `Particle Spawn` 下可见 `Initialize Particle`
- `Particle Update` 下可见 `Particle State`
- 发射器下方挂有 `Event Handler - Source: CollisionEvent`
- 其后还有 `Event Handler Properties`
- 时间线播放头位于约 `3.75s`
- `Initialize Particle` 面板中可辨认的设置包括：
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 10.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`
- `Mesh Renderer Array Visibility Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`
- 左侧预览窗口显示 `Compiling...`，说明此时 Niagara 正在重新编译，预览结果尚未稳定
- 从可见结构判断，这个 `Empty` 发射器更像是用于接收 `CollisionEvent` 后再派生后续效果的轻量事件接收器

### 00:33:37-00:38:22 Update

- 本段定位：Update。
- 知识点：我们有阻力 阻力是块块 它们在中间阻力 因为我们仍然需要 阻力这些块块的位置 可以在 这个阻力的位置 进行一个收集位置活动 在这个收集位置活动。
- 知识点：可以阻力这个物件 现在需要展示给你们 它是什么样的样子 它是站立的 现在我们看到了一些异物 可以如何修复它们 这很容易 当我们阻力了一个块块。
- 知识点：我们不需要 每个块块都阻力 我们只需要 当这个块块阻力了 它们才能够回归 我们有一个阻力的块块 如果有问题 可以重新开始 我们不需要 这就是我们的阻力。
- 知识点：在我们阻力的位置 可以阻力其他块块 这里可以做小小的阻力 例如我们有些材料 而这个东西 会把他们阻力了 在这个情况下 可以把他们阻力了。
- 知识点：没有大问题 可以把25%或15% 的阻力阻力了 可以把25%或15% 阻力了25%或150% 50%太多了 一点点阻力了 这不让我们感到太厉害。

**关键画面：**

这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `Empty` 的 `Initialize Particle`

- 系统视图中左侧相邻发射器为 `DropsTop`
- `Empty` 发射器的 `Emitter State = Self Infinite`
- `Particle Spawn` 下可见 `Initialize Particle`
- `Particle Update` 下可见 `Particle State`
- 发射器下方挂有 `Event Handler - Source: CollisionEvent`
- 时间线播放头位于约 `3.75s`
- `Initialize Particle` 面板中可辨认的设置包括：
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 25.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`
- `Mesh Renderer Array Visibility Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`
- 左侧预览窗口可见地面中心有一圈蓝色柔和光斑，说明该事件接收器当前会生成可见的小型 Sprite 痕迹，而不只是空占位
这是关卡视口中的结果验收画面，当前场景里仍选中了 `Gideon_Inquisitor` 实例，但主要用于观察水花系统在中段的主喷发形态

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `2.60s`
- Outliner 中当前高亮对象为 `Gideon_Inquisitor`
- 右侧 `Details` 面板仍停留在该角色实例的 `Physics` 分类
- 画面中央出现一团高亮青白色主喷发，整体呈竖直上冲的火炬状水柱
- 主体上方有多根细长水滴束向上抛射，两侧有少量短条状飞溅向外散开
- 主喷发底部包着一圈较厚的蓝色圆形基座辉光，外层仍有大范围低对比度的蓝紫色环境雾层
- 这一帧可用于对比前后段的强度变化，确认系统在中段会重新回到较强的中心爆发表现
这是关卡视口配合 Content Browser 的截图，当前在浏览 `StylizedWaterSplash` 相关材质实例，用于给不同水花部件分配颜色或贴图资源

- 视口由 `CameraActor` 取景
- 画面中央只保留一个低矮的蓝色地面能量核，外围包着大范围淡蓝紫色雾层，说明此时系统处于收尾阶段
- Outliner 中当前高亮对象仍是 `Gideon_Inquisitor`
- 右侧 `Details` 面板仍停留在该实例的 `Physics` 分类
- 下方 Content Browser 当前路径位于：
- `Content / VFX_Library / Materials / Instances / StylizedWaterSplash`
- 当前可见的材质实例缩略图包括：
- `MI_Bubble_01`
- `MI_Glow Additive_01`
- `MI_GlowAlpha_01`
- `MI_GlowWater_01`
- `MI_PuddleRing_01`
- `MI_Splash_01`
- `MI_Splash_02`
- `MI_Water Bubble_01`
- `MI_WaterDrops_01`
- `MI_Water GroundWaves...`
- `MI_WaterVertex MoveRing_01`
- `MI_WaterVertex MoveSplash_01`
- 当前高亮选中的是 `MI_PuddleRing_01`
- 顶部标签栏也可见已打开的 `MI_PuddleRing_01`
- 该图说明教程在这一段开始把不同材质实例与地面环、飞溅、水滴等子效果对应起来，以便后续分别调整颜色与明暗

### 00:38:22-00:41:05 颜色

- 本段定位：颜色。
- 知识点：一个颜色 两种颜色 一个是这种 黑的 第二种比较明亮 我们需要改变 阻力 首先我们看看它怎么样 我们需要改变 阻力是这种 我们需要 把它们调整。
- 知识点：可能最初 它会变得快 然后慢慢地减少 这里我们需要 把它们把这个转掉 当它被转掉 就会有问题 所以我们把这个转掉 让可以 在时间上更新它们。
- 知识点：它们在调整 阻力 让它们在两秒钟内活着 接下来我们需要 调整颜色 改变颜色和明亮 我们需要改变得快 我认为 这里可以做一点时间 一些会活得更长。
- 知识点：一些会活得更少 我们有这些降落 和阻力 我们需要改变 它们的阻力 从0.2到0.1 0.2到0.5 太棒了 这里需要改变一点 可能是选项 选项约25-35 阻力会飞走。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `Empty` 的 `Initialize Particle`，重点在颜色随机范围设置

- 系统视图中可见相邻发射器 `DropsTop`
- `Empty` 发射器的 `Emitter State = Self Infinite`
- `Particle Spawn` 下可见 `Initialize Particle`、`Sprite Facing and Alignment`
- `Event Handler - Source: CollisionEvent` 下可见 `Receive Location Event`
- 时间线播放头位于约 `4.49s`
- `Initialize Particle` 中可辨认的设置包括：
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB`
- `Position Mode = Simulation Position`
- `Position Offset` 已启用，值为 `(0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 25.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- 打开的 `Color Picker` 显示当前新颜色为亮青蓝色：
- `R = 0.056942`
- `G = 0.573565`
- `B = 1.0`
- `A = 1.0`
- `H = 207.130997`
- `S = 0.943058`
- `V = 1.0`
- `Hex Linear = 0F92FFFF`
- `Hex sRGB = 43C7FFFF`
- 左上预览窗口可见地面上已有一圈蓝色柔和水环，说明该事件接收器生成的 Sprite 将使用这一类亮青蓝色系
这是 `NS_StylizedWaterSplash` 的系统视图，继续展示发射器 `Empty` 的 `Initialize Particle` 颜色与事件接收结构

- 时间线播放头仍位于约 `4.49s`
- `Empty` 发射器的 `Particle Spawn` 下可见：
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Particle Update` 下可见：
- `Particle State`
- `Scale Sprite Size`
- `Event Handler - Source: CollisionEvent` 下可见：
- `Event Handler Properties`
- `Receive Location Event`
- `Initialize Particle` 中当前可辨认的设置包括：
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Random Range`
- `Color Minimum` 与 `Color Maximum` 都已启用并显示为蓝色系色条
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset` 已启用，值为 `(0.0, 0.0, 0.0)`
- `Position Offset Coordinate Space = Simulation`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 25.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`
- `Mesh Renderer Array Visibility Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`
- 左侧预览窗口依旧显示地面上的蓝色柔光环，说明当前事件接收粒子主要用于落点型地面小痕迹，而不是高空飞溅
这是 `NS_StylizedWaterSplash` 的系统视图，继续调整发射器 `Empty` 的 `Initialize Particle`，这一步把生命周期改成随机范围，并补入后续颜色缩放模块

- 时间线播放头仍位于约 `4.49s`
- `Particle Spawn` 下可见：
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Particle Update` 下可见：
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Event Handler - Source: CollisionEvent` 下可见：
- `Event Handler Properties`
- `Receive Location Event`
- `Initialize Particle` 中当前可辨认的设置包括：
- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.5`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset` 已启用，值为 `(0.0, 0.0, 1.0)`
- `Position Offset Coordinate Space = Simulation`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Uniform`
- `Uniform Sprite Size = 25.0`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Unset`
- `Mesh Renderer Array Visibility Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`
- 左侧预览窗口仍只看到地面蓝色柔和光斑，说明这里的改动主要是在优化接收碰撞事件后的小型落点粒子的存活时长、颜色差异和轻微抬升

### 00:41:08-00:46:06 UV、颜色

- 本段定位：UV、颜色。
- 知识点：我觉得它们太多了 需要改变到35 像这种 我还会把这个 调整成 这样需要有 这些事情 而这里 按照这些条件 我们需要 调整0.2的小 α 让它们变得更少。
- 知识点：我们再重新认为 这是你能看到的 这是我们的活动中 可以把粘土的粘土 从我们的活动中 变化 太棒了 可以加一些 小的噩梦 把这些降落 复制。
- 知识点：把这些材料 让我们做一点 更多的噩梦 让我们做一点规律 我觉得这些 需要做 用阻力 这里可以用 颜色图。
- 知识点：有这种 规律 当它们的颜色 比较轻一点 它们会比较轻一点 可以加一些调色 但需要把它 加进去 或变化 现在我们来看看 它会变得怎么样 让它变得更轻一点。
- 知识点：我们还需要 加一些变化 我们有一个缘障 需要把15到20粒 粘土缘障换成 这里需要变化 让它们变得不同 可能需要 加一个变化的篮板 适当调整。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这是关卡视口中的结果验收画面，用于观察系统收尾阶段的地面颜色与亮度分布

- 视口由 `CameraActor` 取景
- 时间线播放头位于约 `3.50s`
- 序列器中可见 `Camera Cuts`、`CameraActor`、`NS_StylizedWaterSplash` 三条轨道
- Outliner 中当前高亮对象为 `Gideon_Inquisitor`
- 右侧 `Details` 面板仍停留在该实例的 `Physics` 分类
- 画面中央只保留一个低矮的亮青蓝色能量核
- 能量核外侧包着一圈更深的蓝色圆环，再向外过渡到大范围低对比度的蓝紫色雾层
- 没有明显可见的高空飞溅、水柱或条带，说明此时系统已经进入以地面残留与颜色氛围为主的尾段
这是材质实例编辑器中的 `MI_PuddleRing_02`，用于调整地面水环或水花贴片的颜色映射与扭曲表现

- 视口中预览的是若干浅青蓝色的水花贴片碎片，边缘发白，整体较柔和
- 顶部当前打开标签包含 `MI_PuddleRing_02`
- 右侧 `Parameter Groups` 中当前可辨认的设置包括：
- `Base Texture`
- `Colormap = VFX_T_ColorMap_Blue_01`
- `Main (Scale|Scroll) = (R=1.0, G=1.0, B=0.0, A=0.0)`
- `Mask (Scale|Scroll)` 已启用
- `Premultiply Color? = 0.0`
- `T_Main = T_Splash10_2x2`
- `T_Mask = WhiteSquareTexture`
- `Use Colormap? = 1.0`
- `Dissolve`
- `T_Dissolve = T_Swirly_Noise`
- `Dissolve (Scale|Scroll) = (R=1.0, G=1.0, B=0.0, A=0.0)`
- `Smoothness = 0.25`
- `Distortion`
- `Distortion (Scale|Scroll) = (R=1.0, G=1.0, B=0.105143, A=0.233143)`
- `Distortion Influence = 0.03`
- `T_Distortion = T_Voronoise002`
- `Global Scalar Parameter Values`
- `Depth Fade = 0.0`
- 从这些设置看，这个实例主要通过蓝色渐变图、溶解噪声和轻度扭曲，把 `T_Splash10_2x2` 这张形状贴图处理成更柔和的浅蓝色水花片
这是 `NS_StylizedWaterSplash` 的系统视图，当前选中发射器 `DropsSplash` 的 `Shape Location`

- 系统视图中左侧相邻发射器为 `DropsPuddle`
- 时间线播放头位于约 `2.94s`
- 预览窗口左侧可见少量蓝色细点和一层贴地蓝色柔和光斑，说明此阶段主要在观察零散落点与地面残留
- `DropsSplash` 的 `Emitter Update` 下可见：
- `Emitter State = Self Once`
- `Spawn Burst Instantaneous`
- `Particle Spawn` 下可见：
- `Initialize Particle`
- `Add Velocity in Cone`
- `Sub UV Animation Random`
- `Shape Location`
- `Particle Update` 下可见：
- `Collision`
- `Generate Collision Event`
- `Particle State`
- `Gravity Force`
- `Curl Noise Force`
- `Solve Forces and Velocity`
- `Scale Sprite Size by Speed`
- `Scale Color`
- `Shape Location` 当前参数为：
- `Shape Primitive = Cylinder`
- `Cylinder Height = 150.0`
- `Cylinder Radius = 100.0`
- `Cylinder Height Midpoint = 0.5`
- `Cylinder Distribution = Random`
- `Surface Only Band Thickness = 0.0`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`
- 这组设置表示 `DropsSplash` 会在以系统位置为原点的圆柱体体积内随机生成粒子，再配合速度、重力、卷曲噪声和碰撞事件形成下落飞溅

### 00:46:07-00:51:06 速度

- 本段定位：速度。
- 知识点：这个就是 这个加的 这个加的 这个加的 首先,我们不需要發生氣氛的發生 我们不需要这类型的發生 这里有很多 需要由5到10減少 然后需要加上轉圈的速度。
- 知识点：让它们轉動 这些是另外的細節 可能你不需要重量 拉 需要改变重量 -300 目标是它们不会消失 所以我们就这樣做 太快了 消失,目标是它们会掉落。
- 知识点：我们需要加重重量,980 我们不需要快速的減少 我認为这是可能的 因为它们没有相当的速度 但它们会轉動 这里的意思是可以加多一点 我们给它50,100。
- 知识点：你看它们开始轉動 我看它们飛得很低 確定的,它们飛得很低 在这里做什么?800,900 我真的不喜欢它们在哪里飛 我们需要改变中心點。
- 知识点：太快了 我们需要它们飛得更快 但它们仍然需要加重 0.4是可加重的 甚至0.2 需要改变速度 需要把它放在这个範圍 让它们往左邊再延伸 需要加50。
- 核对对象：`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 预览截图
> - 组成部分: Viewport 效果预览 + Sequencer 时间线 + Outliner/Details
> - 所属: `LQ_StylizedWaterSplash` 关卡中的 `NS_StylizedWaterSplash`
> - 目的: 在 `速度` 调整前检查当前飞溅效果，确认粒子上升高度偏低、视觉结果不理想
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | Viewport 效果图 | `NS_StylizedWaterSplash` | 画面中央只有一小团蓝色飞溅粒子，分布紧、抬升高度低，周围大面积为空 | 用于验证当前速度与重力设置下的实际效果 |
> | 下方 | Sequencer 时间线 | `LQ_StylizedWaterSplash` | 当前时间停在约 `3.03s`，轨道中可见 `CameraActor` 与 `NS_StylizedWaterSplash` | 说明正在用镜头时间线观察该 Niagara 效果 |
> | 右侧 | Details 属性图 | `Gideon_Inquisitor (Instance)` | 当前打开 `Physics` 分组，可见 `Enable Gravity` 已勾选，`Linear Damping=0.01`、`Angular Damping=0.0` | 这是当前关卡选中对象的物理属性，不是 Niagara 发射器速度参数 |
>
> 效果观察:
> - 当前可见飞溅只集中在画面中心附近，粒子数量少且离地高度不明显
> - 截图字幕直接给出评价 `Looks bad`，与正文“飞得很低、需要改速度和重力”的结论一致
> - 本图主要作用是记录调速前的失败效果基线，而不是展示具体 Niagara 模块参数
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 预览截图
> - 组成部分: Viewport 效果预览 + Sequencer 时间线 + Outliner/Details
> - 所属: `LQ_StylizedWaterSplash` 关卡中的 `NS_StylizedWaterSplash`
> - 目的: 在调整速度段后复看飞溅主体形态，确认喷溅高度和主体体积已经明显抬高
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | Viewport 效果图 | `NS_StylizedWaterSplash` | 画面中心形成一团高而亮的主水花，底部是发光水滴团，上方有向上拉伸的主喷溅，两侧带少量外甩碎滴 | 用于验证速度、重力和旋转调整后的整体外观 |
> | 下方 | Sequencer 时间线 | `LQ_StylizedWaterSplash` | 当前时间停在约 `2.70s`，仍在 `CameraActor` 与 `NS_StylizedWaterSplash` 的同一镜头段内 | 说明这是同一段镜头中较早的预览帧 |
> | 右侧 | Details 属性图 | `Gideon_Inquisitor (Instance)` | 仍停在 `Physics` 分组，能见到 `Enable Gravity` 已勾选与阻尼值 | 右侧属性仍非 Niagara 参数面板，只是关卡当前选中对象属性 |
>
> 效果观察:
> - 与上一张“飞得很低”的状态相比，这一帧的主喷溅已经向上拉高，中心亮部更集中
> - 两侧开始出现横向飞散的小滴，说明速度变化不仅抬高了主体，也增强了侧向散射
> - 该图仍主要承担结果验证用途，没有给出可直接抄录的 Niagara 模块字段
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 预览截图
> - 组成部分: Viewport 效果预览 + Sequencer 时间线 + Outliner/Details
> - 所属: `LQ_StylizedWaterSplash` 关卡中的 `NS_StylizedWaterSplash`
> - 目的: 继续观察调速后的水花顶点高度与左右扩散，确认主体已经形成更高、更尖的喷发轮廓
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 | Viewport 效果图 | `NS_StylizedWaterSplash` | 中央水花进一步拉高成尖塔状，上部有多根细长喷流，两侧溅射臂更长，底部保持亮蓝色圆形积水 | 用于比对速度段最终更理想的喷发形态 |
> | 下方 | Sequencer 时间线 | `LQ_StylizedWaterSplash` | 当前时间停在约 `2.55s`，仍位于同一镜头片段中 | 说明这是前面同一镜头的另一预览时刻 |
> | 右侧 | Details 属性图 | `Floor (Instance)` | 当前选中对象变为 `Floor`，`Transform` 下可见 `Location=(0,0,0)`、`Rotation=(0,0,0)`，`Scale` 约为 `(5000.0, 5000.0, 4999.0)`；`Static Mesh=Plane` | 右侧显示的是地面实例属性，不是 Niagara 发射器参数 |
>
> 效果观察:
> - 与前两张相比，这一帧的竖直主喷流更高，左右侧向飞溅也更张开
> - 底部仍保持一圈明亮的水面接触区，说明调整后没有丢失落点的积水视觉
> - 本图依旧承担结果验证作用，强调“更有意思”的外观变化，而不是记录具体参数面板

## 补充视觉证据

### S10 00:39:57

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: Preview 预览 + Niagara System Overview + User Parameters + Timeline + Details 属性图
> - 所属: `NS_StylizedWaterSplash`
> - 目的: 记录系统总览中当前选中发射器的模块栈顺序、`User.Delay` 参数，以及 `Scale Color` 模块当前可见设置
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左上 | Preview 效果图 | `NS_StylizedWaterSplash` | 预览窗口中地面中心有一圈浅蓝水花，外围可见少量向上漂浮的小点 | 用于验证当前系统整体外观 |
> | 中央偏左 | Niagara Stack | `DropsTop` | 栈内依次可见 `Initialize Particle`、`Add Velocity in Cone`、`Collision`、`Generate Collision Event`、`Particle State`、`Gravity Force`、`Curl Noise Force`、`Solve Forces and Velocity`、`Scale Sprite Size by Speed`、`Scale Color`、`Sprite Renderer` | 这是当前水花顶部发射器的主要生成与更新链 |
> | 中央偏右 | Niagara Stack | `Empty` | 发射器包含 `Initialize Particle`、`Sprite Facing and Alignment`、`Particle State`、`Scale Sprite Size`、`Scale Color`、`Event Handler - Source: CollisionEvent`、`Sprite Renderer` | 该发射器通过碰撞事件驱动，承担额外飞溅层 |
> | 右侧 | Details 属性图 | `Empty > Scale Color` | `Scale Mode = RGB and Alpha Separately`，`Scale RGB = (1.0, 1.0, 1.0)`，`Scale Alpha = 1.0` | 右侧属性对应当前选中的 `Scale Color` 模块 |
> | 左下 | 参数面板 | `User Parameters` | 可见用户参数 `Delay = 2.4` | 该参数用于控制系统或发射器的延迟时机 |
> | 下方 | 时间线 | `NS_StylizedWaterSplash` | 播放头位于约 `4.49s`，轨道里可见 `Bubbles_AroundSphere`、`Bubbles_SplashBurst`、`Bubbles_SplashSpawn`、`Dark_Puddle`、`Dots_AroundSphere`、`DotsDark_AroundSphere`、`DropsTop`、`Empty` 等条目 | 说明系统由多个发射器分时叠加组成 |
>
> 模块栈:
> | 顺序 | 发射器 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|---|
> | 1 | `DropsTop` | Particle Spawn | `Initialize Particle` | Enabled | 图中未展开 | 初始化顶部飞溅粒子 |
> | 2 | `DropsTop` | Particle Spawn | `Add Velocity in Cone` | Enabled | 图中未展开 | 给顶部飞溅初速度方向 |
> | 3 | `DropsTop` | Particle Update | `Collision` | Enabled | 图中未展开 | 检测碰撞 |
> | 4 | `DropsTop` | Particle Update | `Generate Collision Event` | Enabled | 图中未展开 | 在碰撞时发出事件 |
> | 5 | `DropsTop` | Particle Update | `Particle State` | Enabled | 图中未展开 | 管理粒子生存状态 |
> | 6 | `DropsTop` | Particle Update | `Gravity Force` | Enabled | 图中未展开 | 施加重力 |
> | 7 | `DropsTop` | Particle Update | `Curl Noise Force` | Enabled | 图中未展开 | 增加噪声扰动 |
> | 8 | `DropsTop` | Particle Update | `Solve Forces and Velocity` | Enabled | 图中未展开 | 解算速度与位移 |
> | 9 | `DropsTop` | Particle Update | `Scale Sprite Size by Speed` | Enabled | 图中未展开 | 按速度缩放贴片大小 |
> | 10 | `DropsTop` | Particle Update | `Scale Color` | Enabled | 图中未展开 | 调整颜色或透明度 |
> | 11 | `DropsTop` | Render | `Sprite Renderer` | Enabled | 图中未展开 | 输出顶部飞溅贴片 |
> | 12 | `Empty` | Particle Spawn | `Initialize Particle` | Enabled | 图中未展开 | 初始化事件驱动粒子 |
> | 13 | `Empty` | Particle Spawn | `Sprite Facing and Alignment` | Enabled | 图中未展开 | 设置 Sprite 朝向 |
> | 14 | `Empty` | Particle Update | `Particle State` | Enabled | 图中未展开 | 管理粒子生存状态 |
> | 15 | `Empty` | Particle Update | `Scale Sprite Size` | Enabled | 图中未展开 | 控制事件粒子尺寸 |
> | 16 | `Empty` | Particle Update | `Scale Color` | Enabled | `Scale RGB=(1,1,1)`, `Scale Alpha=1.0` | 当前图右侧正在查看的颜色缩放模块 |
> | 17 | `Empty` | Event Handler | `Event Handler - Source: CollisionEvent` | Enabled | 源为 `CollisionEvent` | 接收碰撞事件生成额外效果 |
> | 18 | `Empty` | Render | `Sprite Renderer` | Enabled | 图中未展开 | 渲染事件粒子 |
>
> 参数:
> | 参数 | 命名空间/类型 | 值或来源 | 作用 |
> |---|---|---|---|
> | `Delay` | User / float | `2.4` | 控制当前系统或关联发射器的延迟时间 |

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


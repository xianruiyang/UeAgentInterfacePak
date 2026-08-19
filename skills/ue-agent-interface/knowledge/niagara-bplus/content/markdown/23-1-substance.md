# 23-1-创建-Substance-纹理资源

# 23-1-创建-Substance-纹理资源

## 关键术语

- `UV`、`Substance`、`Substance Designer`、`纹理`、`曲线`、`噪声`、`Welcome to Substance 3D Designer`、`Decalsbs`、`Niagara`、`Normalized Age`、`Decal`、`生命周期`、`颜色`、`闪电`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`

## 分段知识

### 00:00:05-00:02:55 Substance、Substance Designer、纹理

- 本段定位：Substance、Substance Designer、纹理。
- 知识点：你好,在23讲问好。
- 知识点：这次时间里制作纹理资源。
- 知识点：正在进行substance designer时间,总共会出来大约四张纹理。
- 知识点：几乎大部分是闪电感觉的那种纹理。
- 知识点：只是形状稍有点不同,方式大概可以分成一两种。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Substance Designer`、`纹理`、`闪电`。

**关键画面：**

这张图是第 23 课开始时切入 `Substance 3D Designer` 的起始界面，说明这一课的工作重心已经从 Niagara/Sequencer 切到纹理资源制作。

- 软件：`Adobe Substance 3D Designer (Steam edition)`
- 当前页面：`Home`
- 左侧入口：
  - `New Substance graph...`
  - `Open package...`
  - `New MDL graph...`
  - `Import AxF...`
- 顶部欢迎区标题：`Welcome to Substance 3D Designer`
- 最近工程列表中可见的资源示例：
  - `Mask.sbs`
  - `Reps_Flare.sbs`
  - `Tile.sbs`
  - `Toon.sbs`
  - `Decal.sbs`
  - `Ribbon.sbs`
  - `Aura_V.sbs`
  - `Gradation.sbs`

这张图的意义是建立制作环境：作者后续会在 Substance Designer 中单独做几张偏闪电感的程序纹理，而不是直接在 UE 材质里临时拼贴。复建时可以先准备一个新的 `.sbs` 图，再逐步搭出需要的纹理图谱。
这张图展示了纹理图的起始节点搭建：作者先用一个 `Perlin Noise` 作为输入，再接一个 `Cross Section`，准备从噪声里切出一条横截线形态。

- 节点定义集：
  - `Perlin Noise`
    - 分辨率显示为 `1024x1024 - L16`
    - 作为上游灰度噪声源
  - `Cross Section`
    - 分辨率显示为 `1024x1024 - L8`
    - 作为当前选中节点
    - 节点预览是上黑下白的横向分界
- 连线集：
  - `Perlin Noise.output -> Cross Section.Grayscale`
- `Cross Section` 属性面板当前可见设置：
  - `Cross section coordinate = 0.5`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 1`
  - `Height offset = 0`
  - `Drawing style = Solid`
  - `Smooth / Polygonal = Smooth`
  - `Color` 为白色灰度条
- 预览/输出：
  - 底部 2D 预览显示一条水平分界线
  - 状态栏提示 `No output node defined`，说明此时还只是中间过程，没有正式输出节点

这一步可以理解为“先从基础噪声里切出一条可控的横截形状”，后面再围绕这条线去做闪电、裂缝或能量纹理的主轮廓。
这张图在上一张基础上继续搭建主纹理形状：`Cross Section` 之后又接了一个 `Blend`，并开始搜索后续要补充的调整节点，目标是把横截线进一步加工成更像闪电截面的图案。

- 节点定义集：
  - `Perlin Noise`
    - 分辨率显示为 `1024x512 - L16`
  - `Cross Section`
    - 分辨率显示为 `1024x512 - L16`
    - 预览中可见一条弯曲的细亮线
  - `Blend`
    - 分辨率显示为 `1024x512 - L8`
    - 当前为选中节点
- 连线集：
  - `Perlin Noise.output -> Cross Section.Grayscale`
  - `Cross Section.output -> Blend.Foreground`
- `Blend` 属性面板当前可见设置：
  - `Opacity = 1`
  - `Blending Mode = Copy`
  - `Cropping Area`
    - `Left = 0`
    - `Right = 1`
    - `Top = 0`
    - `Bottom = 1`
- 搜索框当前候选节点可见：
  - `Gradient Map`
  - `Blend`
  - `Blur`
  - `Directional Blur`
  - `Directional Warp`
  - `Sharpen`
  - `Levels`
  - `Curve`
- 预览/输出：
  - 底部 2D 预览显示黑底上一条细白曲线
  - 仍提示 `No output node defined`

这一步说明作者已经把“噪声切线”升级为“可继续叠加、可继续调形”的中间图层。后续大概率会再接 `Levels`、`Curve`、`Gradient Map` 或其他调整节点，把这条线做得更尖锐、更像闪电纹理。

### 00:03:00-00:05:56 UV、噪声

- 本段定位：UV、噪声。
- 知识点：在这里某些部分要亮一些。
- 知识点：某些部分要适当淡一点。
- 知识点：我带来了一种分型噪声。
- 知识点：把多功能炸锅弄好。
- 知识点：现在看看这些亮的和暗的部分。
- 核对对象：`噪声`。

**关键画面：**

这张图给主线条加入了第二条“噪声调制”支路。作者使用 `Voronoi Fractal` 经 `Levels` 处理后接入 `Blend`，准备让线条的亮暗和粗细产生更自然的变化。

- 节点定义集：
  - 主支路：
    - `Perlin Noise`，`1024x512 - L16`
    - `Cross Section`，`1024x512 - L16`
    - `Blend`，`1024x512 - L16`
  - 噪声支路：
    - `Voronoi Fractal`，`1024x512 - L16`
    - `Levels`，`1024x512 - L16`
- 连线集：
  - `Perlin Noise.output -> Cross Section.Grayscale`
  - `Cross Section.output -> Blend.Foreground`
  - `Voronoi Fractal.output -> Levels.input`
  - `Levels.output -> Blend.Background`
- 当前选中节点：`voronoi_fractal`
- `voronoi_fractal` 属性面板当前可见设置：
  - `Invert = False`
  - `Scale = 8`
  - `Size`
    - `X = 1`
    - `Y = 1`
    - `Z = 1`
  - `Offset`
    - `X = 0`
    - `Y = 0`
    - `Z = 0`
  - `Disorder`
    - `X = 1`
    - `Y = 1`
    - `Z = 1`
  - `Distortion Intensity = 0`
  - `Distortion Scale Multiplier = 1`
- 预览/输出：
  - 底部 2D 预览当前仍是黑底上一条细白曲线
  - 状态栏仍提示 `No output node defined`

这一步的作用是给原本太平滑的曲线增加“碎裂、分形、明暗不均”的基础来源。后续如果要做闪电质感，通常就是靠这种分形噪声支路去打破过于干净的线条。
这张图在前面生成的线条基础上加入了 `Directional Warp`，让主曲线开始产生可控的抖动和扭曲，从“平滑截线”进一步变成更像能量裂纹或闪电边缘的形态。

- 节点定义集：
  - `Cross Section`，`1024x512 - L16`
  - `Blend`，`1024x512 - L16`
  - 第二个 `Perlin Noise`，`1024x512 - L16`
    - 作为扭曲强度/方向来源
  - `Directional Warp`，`1024x512 - L16`
    - 当前为选中节点
- 连线集：
  - `Cross Section.output -> Blend.Foreground`
  - `Blend.output -> Directional Warp.Source`
  - `Perlin Noise.output -> Directional Warp.Intensity Input`
- `Directional Warp` 属性面板当前可见设置：
  - `Intensity = 10`
  - `Warp Angle = -0.3776389 Turns`
  - `Degrees = -135.95`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 预览/输出：
  - 底部 2D 预览显示原本平顺的线条已经出现细碎起伏
  - 状态栏仍是 `No output node defined`

这一步可以理解为“用噪声去推拽主线条”。如果目标是做闪电、裂隙或不稳定能量纹理，`Directional Warp` 往往就是把过于规则的轮廓打散成自然抖动边缘的关键节点。
这张图在上一张基础上再加了一层 `Directional Warp`，并把扭曲驱动换成 `Voronoi Fractal`。结果是主线条从轻微起伏进一步变成更明显的“麻点状、断续状、闪电状”边缘。

- 节点定义集：
  - 左侧已有主支路：
    - `Cross Section`
    - `Blend`
    - 第一个 `Directional Warp`
  - 第一条扭曲驱动：
    - `Perlin Noise`
  - 第二条扭曲驱动：
    - `Voronoi Fractal`
  - 当前新增并选中的节点：
    - 第二个 `Directional Warp`，`1024x512 - L16`
- 连线集：
  - `Cross Section.output -> Blend.Foreground`
  - `Voronoi Fractal -> Levels -> Blend.Background`
  - `Blend.output -> Directional Warp(1).Source`
  - `Perlin Noise.output -> Directional Warp(1).Intensity Input`
  - `Directional Warp(1).output -> Directional Warp(2).Source`
  - `Voronoi Fractal.output -> Directional Warp(2).Intensity Input`
- 第二个 `Directional Warp` 属性面板当前可见设置：
  - `Intensity = 100`
  - `Warp Angle = 0.2508333 Turns`
  - `Degrees = 90.3`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 预览/输出：
  - 底部 2D 预览中，细线已经出现更强的颗粒感、转折和局部锯齿
  - 线条不再只是平滑弯曲，而是开始呈现闪电/能量裂缝那种不稳定边缘

这一步的意义是分两层控制扭曲：第一层用 `Perlin Noise` 做整体抖动，第二层用 `Voronoi Fractal` 做更尖锐、更碎的局部破坏。这样组合出来的线条会比单层噪声更接近闪电纹理需要的质感。

### 00:06:02-00:08:36 UV、纹理

- 本段定位：UV、纹理。
- 知识点：大概这里就这样用一下这个模式吧。
- 知识点：大线条里面这种细小的图案。
- 知识点：现在横向的情况就是。
- 知识点：角度可以这样改变。
- 知识点：这种方式上下二D。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这张图把前一阶段的双重扭曲结构整理得更清楚了，当前输出已经形成一条具有粗细变化、局部尖峰和明显起伏的主线，可作为后续闪电纹理的基础轮廓。

- 节点定义集：
  - `Blend`
  - 第一个 `Directional Warp`
  - 第二个 `Directional Warp`
  - `Perlin Noise`
  - `Voronoi Fractal`
- 连线集：
  - `Blend.output -> Directional Warp(1).Source`
  - `Perlin Noise.output -> Directional Warp(1).Intensity Input`
  - `Directional Warp(1).output -> Directional Warp(2).Source`
  - `Voronoi Fractal.output -> Directional Warp(2).Intensity Input`
- 当前选中节点：第二个 `Directional Warp`
- 当前可见关键参数：
  - `Intensity = 100`
  - `Warp Angle = 0.2508333 Turns`
  - `Degrees = 90.3`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 预览/输出：
  - 底部 2D 预览中，线条左侧较密集、中央下沉、右侧重新抬起
  - 局部出现粗细不均和尖锐折点，已经有明显“闪电主干”观感

这一步的价值在于先把“整体走势”做对：先让主线有自然起伏和节奏，再去填充内部细纹或做亮暗变化。若轮廓本身太直、太平，后面再加细节也很难像闪电。
这张图在前面的双扭曲主线上又加了一个新的 `Directional Warp`，并在右侧单独放了一个 `Transformation 2D` 节点作为后续方向/缩放控制的起点。此时图表已经从“做主轮廓”过渡到“准备把线条按横向/纵向需求重整”。

- 节点定义集：
  - 连续三层主线处理：
    - `Directional Warp(1)`
    - `Directional Warp(2)`
    - `Directional Warp(3)`
  - 公共扭曲源：
    - `Voronoi Fractal`
  - 右侧新建节点：
    - `Transformation 2D`，`1024x512 - C8`
- 连线集：
  - `Directional Warp(1).output -> Directional Warp(2).Source`
  - `Voronoi Fractal.output -> Directional Warp(2).Intensity Input`
  - `Directional Warp(2).output -> Directional Warp(3).Source`
  - `Voronoi Fractal.output -> Directional Warp(3).Intensity Input`
  - `Transformation 2D` 当前尚未接入主支路
- 当前选中节点：`Transformation 2D`
- `Transformation 2D` 属性面板当前可见设置：
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = 0`
  - `Mipmap Mode = Automatic`
  - `Matte Color` 为黑色
- 预览/输出：
  - 底部预览当前显示为白色棋盘透明底上的空白图，说明 `Transformation 2D` 还只是一个待接入的变换容器

这一步表明作者已经不满足于只做一条扭曲线，而是开始为“方向调整、横向拉伸、角度控制”预留变换节点。后续如果需要把闪电纹理改成横向流动、纵向下落或倾斜扫过，这个 `Transformation 2D` 就会变得关键。
这张图把前面预留的 `Transformation 2D` 正式接入主支路，并新增了一条“模糊后提亮”的支路，最后和主线重新 `Blend`。这一步让原本只是细线的轮廓开始出现发光边缘和更像闪电的亮度层次。

- 节点定义集：
  - 主支路：
    - 两个连续的 `Directional Warp`
    - `Transformation 2D`
  - 亮度支路：
    - `Blur HQ Grayscale`
    - `Levels`
  - 合成节点：
    - `Blend`
- 连线集：
  - `Directional Warp(2).output -> Transformation 2D.input`
  - `Transformation 2D.output -> Blur HQ Grayscale.input`
  - `Blur HQ Grayscale.output -> Levels.input`
  - `Levels.output -> Blend.Foreground`
  - `Transformation 2D.output -> Blend.Background`
- 当前选中节点：`Levels`
- `Levels` 属性面板当前可见：
  - 使用 `Luminance Channel` 直方图
  - 通过左右阈值和中间灰阶控制亮部压缩/提亮
- 预览/输出：
  - 底部 2D 预览已不再是单纯的细白线
  - 主线周围出现一圈柔和发光包边，中央线条仍保持清晰
  - 黑底上整体更接近“闪电主干 + 轻微辉光”的观感

这一步可以理解为“先模糊出一层亮边，再和原始细线叠回去”。这样既能保留闪电的锐利轮廓，又能获得能量感需要的发光厚度，比只保留一条硬线更适合后续做纹理输出。

### 00:08:40-00:11:27 纹理

- 本段定位：纹理。
- 知识点：用这种形状拿去使用。
- 知识点：现在可以用渐变图输出。
- 知识点：适当闪电纹理无疑。
- 知识点：需要用大一点的分辨率。
- 知识点：边缘和这些部分要尖锐地活着。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`闪电`。

**关键画面：**

这张图显示作者已经把“灰度闪电线条”做得差不多，开始单独准备 `Gradient Map` 作为后续输出着色节点。当前 `Gradient Map` 还未接入主支路，但它的作用已经明确，就是把灰度亮度映射成最终纹理的颜色/明暗分布。

- 现有主支路：
  - `Transformation 2D -> Blur HQ Grayscale -> Levels -> Blend`
  - `Transformation 2D.output` 也直接回接到 `Blend.Background`
- 新建节点：
  - `Gradient Map`，`1024x512 - C8`
  - 当前为选中节点
  - 还未连接到左侧主支路
- `Gradient Map` 属性面板当前可见设置：
  - `Color Mode = Color`
  - `Gradient Addressing = Clamp`
  - `Gradient` 当前为从黑到白的灰度渐变条
- 预览/输出：
  - 底部预览仍为空黑底，说明 `Gradient Map` 目前只是待接入的输出节点

这一步相当于从“做形状”转向“做输出形式”。先把闪电灰度主干准备好，再接 `Gradient Map` 去控制亮部、暗部和边缘过渡，会比一开始就上色更容易稳定整体形状。
这张图展示了更后期的一版 Substance 图表：画布上已经出现多条完整分支，底部预览仍是黑底上的发光闪电线，同时作者正在搜索 `tile` 相关节点，显然准备把当前闪电形状进一步做成可平铺、可采样或可重复使用的纹理结构。由于当前截图缩放较远，多个节点名和具体端口连接无法逐个可靠辨认，因此这里只记录已确认信息。

- 已确认信息：
  - 当前图表已经不止一条主支路，至少包含上下两组较完整的节点链
  - 底部预览仍显示一条带发光包边的闪电灰度线
  - 右侧当前选中节点属性属于 `Directional Warp`
    - `Intensity ≈ 39.87`
    - `Warp Angle ≈ 0.4949722 Turns`
    - `Degrees ≈ 178.19`
    - `Input Filtering Mode = Bilinear`
    - `Intensity Map Offset = 0`
  - 搜索框正在检索 `tile`
  - 可见候选包括：
    - `Tiles 002`
    - `Tiles 008`
    - `Tiles 011`
    - `Tile Generator Grayscale`
    - `Tile Generator Color`
    - `Tile Random Grayscale`
    - `Tile Sampler Grayscale`
    - `Tile Sampler Color`
  - 画布中大多数节点名称与完整连线端口无法在当前缩放下可靠确认
  - 无法仅凭这一帧断定作者最终选择了哪一个 `tile` 节点接入主流程

如需正式写回这一张的完整节点结构，建议更近距离的同一时刻截图或前后帧，确认具体接入的是 `Tile Sampler`、`Tile Generator` 还是其他 `tile` 分支节点。
这张图确认作者最终接入的是 `Tile Sampler Grayscale`。它把前面做好的单条闪电线段复制成多条分布在同一张图上的横向纹理片段，适合拿来做重复出现的电流/能量条纹。

- 节点定义集：
  - 上方支路：
    - `Transformation 2D`
    - `Blend`
    - `Gradient Map`
  - 下方支路：
    - `Blur HQ Grayscale`
    - `Levels`
    - `Transformation 2D`
  - 终端分布节点：
    - `Tile Sampler Grayscale`，`1024x512 - L16`
- 连线集：
  - 至少有两条输入线接入 `Tile Sampler Grayscale`
  - 其中一条来自下方 `Transformation 2D` 输出，作为图案输入来源
  - 另一条来自上方流程，用于控制分布或掩码
- 当前选中节点：`tile_sampler_grayscale`
- `Tile Sampler Grayscale` 属性面板当前可见设置：
  - `X Amount = 1`
  - `Y Amount = 4`
  - `Non Square Expansion = True`
  - `Pattern = Pattern Input`
  - `Pattern Input Number = 4`
  - `Pattern Input Distribution = Random`
  - `Pattern Input Filtering = Bilinear + Mipmaps`
  - `Rotation = 0`
  - `Rotation Random = 0`
  - `Symmetry Random = 0`
- 预览/输出：
  - 底部 2D 预览中，单条闪电线已经被复制成多条横向分布的短线段
  - 每条线长度和位置略有变化，但整体仍保持横向流向

这一步的作用是把单条闪电主干变成“可批量铺开的纹理资源”。如果后续要在 Niagara 或材质里做多条同时闪过的电流、裂纹或能量条，`Tile Sampler` 这种分布方式会比手工复制节点更灵活。

### 00:11:30-00:14:29 噪声

- 本段定位：噪声。
- 知识点：的白色部分是我们的输入图像。
- 知识点：如果这个4等风的方块填满了。
- 知识点：就干净利落地显示1、2、3、4。
- 知识点：还有什么先调整这个尺寸也不错。
- 知识点：只能横向拉伸一张图像。
- 核对对象：`噪声`。

**关键画面：**

这张图开始把 `Tile Sampler` 从“随机平铺闪电线段”切换到更规则的条块分布，用来测试一组横向条纹模板。当前 `Pattern` 已经不是自定义输入，而是标准方块图形，因此预览里出现了整齐的横向白色条块阵列。

- 当前主支路：
  - `Transformation 2D -> Blur HQ Grayscale -> Levels -> Blend -> Gradient Map -> Tile Sampler Grayscale`
  - 另一条来自下方 `Transformation 2D` 的输入也接入 `Tile Sampler`
- 当前选中节点：`tile_sampler`
- `Tile Sampler` 当前可见参数：
  - `X Amount = 1`
  - `Y Amount = 4`
  - `Non Square Expansion = True`
  - `Pattern = Square`
  - `Rotation = 0`
  - `Rotation Random = 0`
  - `Symmetry Random = 0`
  - `Symmetry Random Mode = Horizontal + Vertical`
- 预览/输出：
  - 底部预览显示三列竖向排布、每列 4 行的白色横条
  - 中间列条块更宽，两侧列较窄，说明当前布局在测试横向拉伸后的模板分布

这一步可理解为“先用规则方块验证 Tile Sampler 的排布逻辑”，确认 1x4 的纵向重复和横向宽度关系之后，再把自定义闪电形状重新塞回去，会更容易控制最终纹理的节奏和密度。
这张图把 `Tile Sampler` 从测试方块排布切回到真正的自定义图案输入。当前图表里已经能看到上下两条相似的闪电生成支路，而底部预览也变成了两条横向分布的发光闪电线，说明作者正在把一组可重复的闪电条纹整理成纹理图。

- 图表结构：
  - 画布上存在上下两组近似对称的闪电生成链
  - 每组都包含：
    - `Perlin Noise`
    - `Cross Section`
    - `Blend`
    - 多个 `Directional Warp`
    - `Transformation 2D`
    - `Blur HQ Grayscale`
    - `Levels`
    - `Gradient Map`
  - 右侧 `Tile Sampler` 同时接收来自这些支路的输入
- 当前选中节点：`tile_sampler`
- `Tile Sampler` 当前可见关键参数：
  - `X Amount = 1`
  - `Y Amount = 4`
  - `Non Square Expansion = False`
  - `Pattern = Pattern Input`
  - `Pattern Input Number = 4`
  - `Pattern Input Distribution = Pattern Number`
  - `Pattern Input Filtering = Bilinear + Mipmaps`
  - `Rotation = 0`
  - `Rotation Random = 0`
  - `Symmetry Random = 0`
  - `Symmetry Random Mode = Horizontal + Vertical`
- 预览/输出：
  - 底部 2D 预览中，黑底上出现两条横向延展的发光闪电纹理
  - 两条线的弯折节奏接近，但并不完全相同

这一步说明作者开始把“单条可用线”升级成“多条可平铺的纹理条带”。复建时如果需要一组横向电流纹理，通常会先做若干条基础线，再用 `Tile Sampler` 统一分布，而不是只导出一条孤立线段。
这张图说明作者在平铺测试之后，又把上下两条闪电生成支路分别收束回更完整的单线输出，再统一接到右侧的 `Tile Sampler Grayscale`。底部预览里现在只保留一条更粗、更亮的电流主线，说明这一轮重点转向“把单条成品纹理打磨好”。

- 图表结构：
  - 上下两条支路都包含：
    - `Directional Warp`
    - `Transformation 2D`
    - `Blur HQ Grayscale`
    - `Levels`
    - `Blend`
  - 上方支路额外可见一个 `Gradient Map`
  - 两条支路最终都接向右侧同一个 `Tile Sampler Grayscale`
- 当前右侧节点：
  - `Tile Sampler Grayscale`，`1024x512 - L16`
- 右侧当前可见 `Gradient Map` 设置：
  - `Color Mode = Color`
  - `Gradient Addressing = Clamp`
  - 使用黑到白的灰度渐变条
- 预览/输出：
  - 底部 2D 预览中，仅显示一条较粗的亮白电流线
  - 线条有更明显的外发光厚度和内部亮核
  - 相比前几张，结果更接近可直接导出的主纹理

这一步可理解为“先把一条代表性的闪电线条做成最终品质，再决定是否批量复制或分布”。对于纹理制作来说，先把单条质量打磨到位，再去做平铺和变体，通常比一开始就追求数量更稳妥。

### 00:14:34-00:17:29 颜色、纹理

- 本段定位：颜色、纹理。
- 知识点：这个噪音模式的竖直怎么样。
- 知识点：这么Bolino1分型的竖直怎样啊。
- 知识点：反正只是这种皱皱巴巴的图案。
- 知识点：这种是需要调节的。
- 知识点：毕竟这里可以换个音调。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

这张图进入 `颜色、纹理` 段后，仍以左右两条闪电支路接入同一个 `Tile Sampler Grayscale`，但底部预览回到更清晰的一条成品电流线。说明这一段开始重点观察“纹理形态是否够皱、够碎、够像电”。

- 当前图表结构：
  - 上下两条主纹理支路继续保留
  - 每条支路仍由 `Transformation 2D`、`Blur HQ Grayscale`、`Levels`、`Blend` 组成
  - 两条支路都接向右侧 `Tile Sampler Grayscale`
- 右侧当前选中节点属性来自 `Gradient Map`
  - `Color Mode = Color`
  - `Gradient Addressing = Clamp`
  - 使用黑白灰度渐变条
- 预览/输出：
  - 底部 2D 预览显示一条更厚、更亮的电流线
  - 线条边缘较皱，内部亮核更突出
  - 这更像最终会用于材质的“单条主纹理”而不是纯测试图

这张图对应的判断重点不是新增哪个节点，而是看当前纹理有没有形成“皱巴巴、带噪点、像电流”的观感。若线条过于平滑，就还需要继续加噪声或微调 warp。
这张图把 `Tile Sampler Grayscale` 的结果重新送进一个新的 `Transformation 2D`，并把输出画幅扩展为近似方形 `1024x1024`。底部预览里可以清楚看到四条横向闪电线被整理进一个矩形画幅中，说明作者在为后续统一导出尺寸做准备。

- 节点定义集：
  - 左侧：`Tile Sampler Grayscale`
  - 右侧新建：`Transformation 2D`，`1024x1024 - L16`
- 连线集：
  - `Tile Sampler Grayscale.output -> Transformation 2D.input`
- 当前选中节点：右侧 `Transformation 2D`
- `Transformation 2D` 属性面板当前可见设置：
  - `Output Size`
    - `Width = 10`，对应 `1024 px`
    - `Height = 10`，对应 `1024 px`
    - 模式切到 `Relative to Parent`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Mipmap Mode = Automatic`
  - `Matte Color` 为黑色
- 预览/输出：
  - 底部 2D 预览显示四条横向闪电线整齐落在一个接近正方形的黑底画幅中

这一步可以理解为“先把平铺出来的纹理条带收进标准导出尺寸”。如果后面要进 UE 做贴图，先把输出固定到 `1024x1024` 一类的标准尺寸，会比继续保持长条画幅更好管理。
这张图在上一张基础上继续把输出方向调整为更适合竖直使用的排布。`Tile Sampler Grayscale` 的结果先经过 `Transformation 2D`，随后接入 `Gradient Map`，底部预览已经变成多条纵向电流线。

- 节点定义集：
  - `Tile Sampler Grayscale`
  - 中间 `Transformation 2D`，`1024x1024 - L8`
  - 右侧 `Gradient Map`
- 连线集：
  - `Tile Sampler Grayscale.output -> Transformation 2D.input`
  - `Transformation 2D.output -> Gradient Map.input`
- 当前选中节点：中间 `Transformation 2D`
- `Transformation 2D` 当前可见设置：
  - `Output Size`
    - `Width = 10`，对应 `1024 px`
    - `Height = 10`，对应 `1024 px`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Mipmap Mode = Automatic`
  - `Matte Color` 为黑色
- `Gradient Map` 状态：
  - 已经接到 `Transformation 2D` 输出端，准备对最终图案做颜色映射
- 预览/输出：
  - 底部 2D 预览中，闪电线由横向变成多条竖向分布
  - 每条线都有亮白边缘和较暗的中心过渡，适合做竖向电流/能量纹理

这一步说明作者不仅要做横向条纹，还在准备可竖直使用的同类纹理。通过 `Transformation 2D` 改变排布方向，再接 `Gradient Map` 输出，能更方便地生成不同朝向的闪电变体。

### 00:17:33-00:20:10 UV、纹理、曲线

- 本段定位：UV、纹理、曲线。
- 知识点：这种话又可以制作一张。
- 知识点：这种形式的分解纹理来使用。
- 知识点：现在有点单调的形状。
- 知识点：这次用类似的方式。
- 知识点：再做得更有质量一些。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`曲线`。

**关键画面：**

这张图进入 `S07` 段，开始检查“单调线条”在映射成亮线后的观感。当前可见节点链路是从左到右：

- `Directional Warp -> Transformation 2D -> Blur HQ Grayscale -> Levels -> Blend`
- `Blend` 的一条输出继续接到右侧 `Transformation 2D`
- `Blend` 的另一条输出接到下方 `Gradient Map`

可确认信息：

- 当前选中的是 `Gradient Map` 预览页，底部 2D 视图显示黑底上的 4 条细长白色闪电线。
- 右侧 `Properties` 显示 `Gradient Map` 使用默认黑到白渐变，`Color Mode = Grayscale`，`Gradient Addressing = Repeat`。
- 底部状态栏显示输出画幅为 `1024 x 1024 (RGBA, 8bpc)`。
- 从教程字幕与邻近正文可知，这一步是在观察“现在有点单调的形状”，也就是先确认目前线条太均匀、变化不足，后面还会继续用纹理和曲线把它做得更有层次。

这张图的作用不是新增节点，而是把已有灰度线条送入 `Gradient Map` 做成可读性更高的白线预览，作为后续继续细化纹理与曲线前的基线效果。
这张图回到中段纹理图，用多组噪声和截面结果去重做中间主线的粗细变化。截图能可靠确认的结构如下。

- 节点定义集：
  - `Perlin Noise`（左）
  - `Cross Section`
  - `Perlin Noise`（上方）
  - `Voronoi Fractal`（左下）
  - `Levels`
  - `Blend`（当前选中）
  - `Directional Warp` x3
  - `Voronoi Fractal`（右下）
  - `Transformation 2D`
- 连线集：
  - 左侧 `Perlin Noise -> Cross Section`
  - 左下 `Voronoi Fractal -> Levels`
  - `Cross Section`、上方 `Perlin Noise`、`Levels` 三者都接入当前 `Blend`
  - `Blend` 输出继续串到右侧的多级 `Directional Warp`
  - 最右侧结果再接入 `Transformation 2D`
  - `Blend` 属性面板可见 `Blending Mode = Multiply`
  - `Opacity = 1`
- 输出/预览：
  - 底部预览是 `1024 x 512` 灰度图
  - 结果只剩一条横向细白线，线条中段有轻微起伏，说明这一步是在先做“中间主线”的粗细基线

可确认教程意图是“把中间这条线做得更粗一些，并加入起伏变化”。但 `Blend` 的三个输入端口角色、以及右侧两张 `Voronoi Fractal` 到各级 `Directional Warp` 的精确端口归属在当前截图里不够清晰，若要按端口级完全复建，需人工结合原视频逐帧复核。
这张图延续上一张的纹理主线制作，但这次可以明确看到是在调上方那张用于驱动扭曲的 `Perlin Noise` 实例，让主线的波动更大、更粗一些。

- 当前可见节点链：
  - `Perlin Noise -> Cross Section -> Blend`
  - 左下 `Voronoi Fractal -> Levels -> Blend`
  - 上方 `Perlin Noise` 也接入 `Blend` / `Directional Warp` 链路
  - `Blend` 输出继续进入右侧多级 `Directional Warp`
  - 最右侧再接 `Transformation 2D`
- 当前明确可见的实例参数：
  - 右侧属性面板标题为 `perlin_noise - PROPERTIES`
  - `Scale = 7`
  - `Disorder = 0`
  - `Non Square Expansion = True`
- 预览/输出：
  - 底部预览仍是 `1024 x 512` 灰度图
  - 结果是一条横向亮线，但相较前一张已经出现更明显的上下起伏，线条中段和右段的波形变化更大

结合本段正文“用类似的方式，再做得更有质量一些”可以理解为：作者继续沿用噪声驱动扭曲的办法，通过提高这张 `Perlin Noise` 的尺度，让主线获得更自然的粗细和波形变化，作为后面进入 `S08` 曲线段之前的最终纹理线基底。

### 00:20:19-00:23:17 曲线

- 本段定位：曲线。
- 知识点：这个本身也用Ballon Live Vector这个模式。
- 知识点：适当简单化会更好。
- 知识点：这可以把高度比例适当降低。
- 知识点：这样中心线适当用力一点比较好。
- 知识点：这个最好最后再做。
- 核对对象：`曲线`。

**关键画面：**

这张图进入 `S08` 的曲线细化阶段，核心是在现有单条闪电主线上继续增加更明显的高低起伏。当前截图能确认的节点链仍然延续上一段的纹理主线：

- 节点定义集：
  - `Perlin Noise -> Cross Section`
  - `Voronoi Fractal -> Levels`
  - `Blend`
  - 上方另一张 `Perlin Noise`
  - `Directional Warp` x3
  - 右侧 `Transformation 2D`
  - `Blur HQ Grayscale`
- 连线集：
  - `Cross Section`、`Levels` 与上方 `Perlin Noise` 一起参与 `Blend` / `Directional Warp` 这条主链
  - 中间三张 `Directional Warp` 串联后接入 `Transformation 2D`
  - `Transformation 2D` 结果继续送到右侧 `Blur HQ Grayscale`
  - 右下 `Voronoi Fractal` 继续作为后两级扭曲的驱动输入之一
- 设置/参数：
  - 当前选中节点为中间一张 `Directional Warp`
  - `Intensity = 100`
  - `Warp Angle = 90.3 Degrees`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 底部预览是 `1024 x 512` 灰度图
  - 黑底上只显示一条横向白线，但白线已经出现明显的大幅波峰、波谷和边缘毛刺，整体比 `S07` 末尾更有“曲线被拉扯过”的感觉

结合本段“曲线”定位，可以把这一步理解为：先用较高强度的 `Directional Warp` 把原本过于平直的主线整体打弯，并保留边缘不规则感，作为后续继续简化和调整首尾形态的基础。
这张图没有再增加新的纹理节点，而是把经过三次 `Directional Warp` 处理后的主线送进 `Transformation 2D`，手动把整条线重新摆正，控制成“整体近似水平、局部仍有起伏”的状态。

- 节点定义集：
  - 左侧延续前面的 `Directional Warp` 链
  - `Transformation 2D`
  - 右侧 `Blend`
- 连线集：
  - 最后一张 `Directional Warp.output -> Transformation 2D.input`
  - `Transformation 2D.output -> Blend`
- 设置/参数：
  - 当前选中节点：`Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset Y = -0.0329`
  - 底部 2D 视图里可见变换框，说明这里主要通过平移来校正位置，而不是缩放或旋转
- 输出/预览：
  - 预览为 `1024 x 512` 灰度图
  - 白线仍保留左高右低的波动，但整体已经被拉回接近一条横向中线

结合字幕“拿个水平大概来”，这一步的目的就是先把曲线的整体走势调整回水平基准，方便下一步再处理“开头和结尾”的强弱与连接感，而不是让主线在画幅内倾斜得太厉害。
这张图回到前一段的扭曲链，目的是把中间这部分曲线做得更明显，但同时保持整体走势更平顺，不要出现过强的上下跳动。

- 节点定义集：
  - `Cross Section`
  - `Voronoi Fractal -> Levels`
  - `Blend`
  - 上方 `Perlin Noise`
  - `Directional Warp` x3
  - `Transformation 2D`
- 连线集：
  - `Cross Section` 和 `Levels` 都接入 `Blend`
  - 上方 `Perlin Noise` 接入第一张 `Directional Warp`
  - `Blend.output -> 第一张 Directional Warp.input`
  - 右下 `Voronoi Fractal` 继续作为后两级 `Directional Warp` 的驱动输入之一
  - 三级 `Directional Warp` 串联后接到 `Transformation 2D`
- 设置/参数：
  - 当前选中节点仍为第一张 `Directional Warp`
  - `Intensity` 已被调低到约 `9.82`
  - `Warp Angle = 90.3 Degrees`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 预览依旧为 `1024 x 512` 灰度图
  - 白线相比前两张明显更顺、更浅，仍有轻微弧形起伏，但已经不再出现大幅波峰波谷

结合字幕“这一部分现在需要有更多的曲线”，可以把这一步理解为：作者不是单纯把扭曲强度继续拉高，而是在得到足够曲率之后回调 `Directional Warp` 的强度，让主线中段有弧度但不过度破碎，为下一段“关键流程 09”里继续处理闪电头尾和复线关系留出更稳定的基底。

### 00:23:20-00:26:29 关键流程 09

- 本段定位：关键流程 09。
- 知识点：第二条线就顺畅递结合吧。
- 知识点：这个反正最后就是要。
- 知识点：看这里这样看的时候一条复线。
- 知识点：可以感觉到这样调节开头和结尾。
- 知识点：这种话原本的闪电如果有较粗的线。
- 核对对象：`闪电`。

**关键画面：**

这张图进入 `S09` 的“关键流程 09”，开始把上一段得到的单条曲线进一步整理成更适合做复线和首尾控制的主干。截图中能确认的主链如下。

- 节点定义集：
  - `Cross Section`
  - `Voronoi Fractal -> Levels`
  - `Blend`
  - 上方 `Perlin Noise`
  - `Directional Warp` x3
  - `Transformation 2D`
  - 右侧 `Levels`
- 连线集：
  - `Cross Section`、`Levels` 与上方 `Perlin Noise` 继续参与 `Blend -> Directional Warp` 主链
  - 三张 `Directional Warp` 串联后接 `Transformation 2D`
  - `Transformation 2D.output -> Levels.input`
  - 中间 `Voronoi Fractal` 继续接入后两级 `Directional Warp`，作为扭曲驱动之一
- 设置/参数：
  - 当前选中第一张 `Directional Warp`
  - `Intensity = 100`
  - `Warp Angle = 90.3 Degrees`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 底部预览为 `1024 x 512` 灰度图
  - 线条比上一段更平滑，整体是一条横向流动的白线，中间略抬高、两端回落，边缘毛刺被明显压弱

结合本段“第二条线就顺畅地结合”“调节开头和结尾”的提示，这一步可以理解为：先把主干线整理成更顺的单线轮廓，再通过右侧新增的 `Levels` 为后续控制线头、线尾和复线叠加准备统一的亮度/粗细基底。
这张图把上一条闪电主线复制成上下两条相似分支，再在右侧通过 `Blend` 合并成一张“复线闪电”结果。截图里可确认这是两条结构近似一致的链路同时工作。

- 节点定义集：
  - 上支路：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 下支路：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 汇合节点：
    - 右侧 `Blend`
- 连线集：
  - 上下两条支路各自都从 `Cross Section` 经 `Blend -> Directional Warp x3 -> Transformation 2D -> Levels` 输出
  - 两个 `Levels.output` 最终同时接入右侧同一个 `Blend`
- 设置/参数：
  - 当前选中的是下支路的 `Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = -0.1485`
  - 底部视图可见变换框，说明这一步主要通过垂直位移把第二条线放到第一条线附近
- 输出/预览：
  - 预览为 `1024 x 512` 灰度图
  - 黑底上已能看到两条距离很近的白线：上方主线更亮更粗，下方副线更细，二者在中段局部接近甚至贴合，形成“复线闪电”的雏形

这一步对应本段“第二条线顺畅结合”的目标：不是随机叠第二条线，而是先把第二条分支用 `Transformation 2D` 精确平移到主线附近，再统一送进 `Blend`，让复线关系在开头、结尾和中段都更自然。
这张图继续精修复线闪电中的其中一条分支。当前画面把焦点放在该分支末端的 `Transformation 2D -> Levels`，通过进一步下移分支位置，让两条线既有贴合段，也有分开段和交叉段。

- 节点定义集：
  - `Cross Section`
  - `Voronoi Fractal -> Levels`
  - `Blend`
  - `Perlin Noise`
  - `Directional Warp` x3
  - `Transformation 2D`
  - `Levels`
- 连线集：
  - `Cross Section` 与 `Voronoi Fractal -> Levels` 接入当前这条分支的 `Blend`
  - `Blend -> Directional Warp x3 -> Transformation 2D -> Levels`
  - 该 `Levels` 的输出在后续会与另一条分支一起汇合
- 设置/参数：
  - 当前选中节点：`Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = -0.1791`
- 输出/预览：
  - 预览仍是 `1024 x 512` 灰度图
  - 可以看到两条白线在左侧靠得很近，中段发生一次明显穿插，右侧再逐渐分开；其中一条线更粗更亮，另一条更细更淡

这一步的作用是把副线的位置再往下压一点，做出“同源但不完全重叠”的闪电复线关系。这样后续叠加时，线头、交叉点和末端分叉会更有层次，不会看起来像简单复制后硬贴在一起。

### 00:26:35-00:29:16 纹理

- 本段定位：纹理。
- 知识点：我推荐你找一些适当好看的形状。
- 知识点：我做的模式也会提供给你。
- 知识点：一起比较一下也不错。
- 知识点：就是这种东西设计上布局要怎么安排。
- 知识点：这种方式也能在一章上叠加更多的纹理。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这张图进入 `S10` 的纹理段，焦点不再是复线关系，而是如何用噪声把单条闪电边缘做出更有设计感的纹理切口。截图局部放大了主线中段，可确认结构如下。

- 节点定义集：
  - `Perlin Noise`
  - `Blend`
  - `Directional Warp` x3
  - `Voronoi Fractal`
  - 右侧 `Transformation 2D`
- 连线集：
  - `Perlin Noise` 与左侧 `Blend` 的结果共同送入第一张 `Directional Warp`
  - 第一张 `Directional Warp.output -> 第二张 Directional Warp.input`
  - `Voronoi Fractal.output` 接入第二张和第三张 `Directional Warp` 的驱动输入
  - 第三张 `Directional Warp.output -> Transformation 2D.input`
- 设置/参数：
  - 当前选中中间这张 `Directional Warp`
  - `Intensity = 100`
  - `Warp Angle = 90.3 Degrees`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 底部预览为 `1024 x 512` 灰度图
  - 线条已经不再是单纯平滑弧线，而是在中段形成一个明显下陷后又抬起的尖峰结构，边缘也出现更碎、更像闪电裂口的变化

这一步可以理解为：继续用 `Voronoi Fractal` 作为扭曲贴图去破坏线条轮廓，但这次目标不是做大曲率，而是做“更好看的形状设计”。也就是让闪电主线局部出现更强的凹凸节奏，为后续叠加更多纹理做基础。
这张图回到上下两条闪电支路的完整视图，作者开始检查“多条线放在一起时，整体纹理关系是否协调”。当前两条支路各自经过纹理化扭曲后，再送入右侧 `Blend` 汇合。

- 节点定义集：
  - 上支路：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 下支路：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 汇合节点：
    - 右侧 `Blend`
- 连线集：
  - 上下两条支路都先在各自链路中完成纹理扭曲与位置校正
  - 各自的 `Levels.output` 再同时接入右侧同一个 `Blend`
- 设置/参数：
  - 当前选中节点是下支路的 `Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0.0001`
  - `Offset Y = -0.0931`
- 输出/预览：
  - 预览为 `1024 x 512` 灰度图
  - 画面里已经出现三层可读关系：上方一条更高起伏的主线、中间较亮的交汇主干、下方一条更长更顺的副线
  - 中段存在明显交叉，但字幕也提示“这样三条线似乎联系不大”，说明当前版本虽然层次丰富，却还不够像同一束闪电系统

这一步的重点是检查“布局关系”而不是单独做某条线。作者通过继续平移下支路，观察三条可见线性结构之间的关联度，判断哪些分支应该更靠近、哪些局部需要更自然地共享走势。
这张图把前面做好的多条闪电分支完整摊开，展示了一个“三支路汇合后再统一预览”的结构。它本质上是在评估当前纹理方案是否适合继续沿用，还是只适合较轻量的场景。

- 节点定义集：
  - 三组相似支路，每组都包含：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 右侧有两级汇合 `Blend`
  - 最末端 `Gradient Map`
- 连线集：
  - 上、中、下三条支路各自先生成独立闪电纹理
  - 中、下两条支路先在第一张右侧 `Blend` 汇合
  - 第一张 `Blend` 的输出再与上方支路一起接入第二张 `Blend`
  - 最终 `Blend.output -> Gradient Map.input`
- 设置/参数：
  - 当前选中节点为最末端 `Gradient Map`
  - `Color Mode = Color`
  - `Gradient Addressing = Repeat`
  - 可见渐变仍为默认黑白线性渐变
  - 输出尺寸显示为 `1024 x 512`
- 输出/预览：
  - 底部预览是 `1024 x 512 (RGBA, 16bpc)`
  - 最终结果为三条相互关联但不完全重叠的白色闪电线：左侧更密集，中段有交汇与穿插，右侧延展成更宽的分岔布局

结合字幕“看起来适合轻松使用，而不是高质量场景”，这一步可以理解为作者在做方案评估：当前这种三支路叠加的做法能快速得到可用的闪电纹理，但如果追求更高质量或更强设计控制，后续还需要再补更精细的纹理层与结构关系。

### 00:29:22-00:30:20 关键流程 11

- 本段定位：关键流程 11。
- 知识点：如果适当添加点光辉的话会更好。
- 知识点：就这样,然后你也可以这样使用。
- 知识点：就是这样,提供字幕和包括广告。

**关键画面：**

这张图进入最后的 `S11` 收尾阶段，开始给已经做好的闪电线叠一层柔和发光。当前截图能明确看出，作者从原有闪电结果再分出一条“模糊后增强”的辉光支路，与原线条重新合成。

- 节点定义集：
  - 左侧输入链末端：`Transformation 2D -> Levels`
  - 辉光支路：
    - `Blend`
    - `Blur HQ Grayscale`
    - `Levels`
  - 汇合与输出：
    - 右侧 `Blend`
    - `Gradient Map`
  - 上方还保留一张旧的 `Gradient Map` 结果节点
- 连线集：
  - 左侧 `Levels.output` 先进入中间 `Blend`
  - 中间 `Blend.output -> Blur HQ Grayscale -> Levels`
  - 这条经过模糊和压阶的结果接入右侧 `Blend`
  - 原始线条结果也同时接入右侧 `Blend`
  - 右侧 `Blend.output -> Gradient Map`
- 设置/参数：
  - 当前选中的是右侧汇合用 `Blend`
  - `Blending Mode = Add (Linear Dodge)`
  - `Opacity = 1`
- 输出/预览：
  - 底部预览是 `1024 x 512 (RGBA, 16bpc)`
  - 结果仍是黑底白线，但主线周围已经开始出现更柔的扩散亮边，尤其左侧交汇区域更亮

这一步的作用就是把“硬边闪电线”扩成“线芯 + 外发光”两层结构。作者没有直接把线加粗，而是先把原线拷一份，经过 `Blur HQ Grayscale` 和 `Levels` 处理后，再用 `Add (Linear Dodge)` 叠回去，这样会得到更自然的辉光感。
这张图展示了完整的三支路闪电总图，并确认最终收尾方式：先把三条分支合并，再额外叠一层发光强化，让最终图既保留线性结构，又有比较明显的能量感。

- 节点定义集：
  - 三组闪电支路，每组都包含：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 右侧两级 `Blend` 用来合并三条支路
  - 最终收尾链：
    - `Blur HQ Grayscale`
    - `Levels`
    - `Blend`
- 连线集：
  - 三条支路先在右侧通过两级 `Blend` 汇成一张总闪电图
  - 该总图再分出一条模糊支路，经 `Blur HQ Grayscale -> Levels`
  - 原始总图与模糊支路一起进入最右侧 `Blend` 做最终发光叠加
- 设置/参数：
  - 当前选中的最右侧 `Blend` 仍为：
    - `Blending Mode = Add (Linear Dodge)`
    - `Opacity = 1`
- 输出/预览：
  - 底部预览是灰度黑底图
  - 当前结果中，左侧交叉区域和中段连接处最亮，说明辉光主要强化了线条重叠与主干区域
  - 三条线的关系比 `S10` 更统一，不再只是干线叠加，而是已经有“整体发光的闪电束”效果

这一步可以理解为最终效果确认：只要在总闪电图上额外叠一层受控模糊辉光，就能快速把原本偏“纹理线稿”的结果，提升成更像可直接投到特效中的发光闪电纹理。
这张图是整个 Substance Designer 工程的最终状态确认。作者不再调整具体节点参数，而是回到工程级视图，展示已经完成的闪电纹理图结构及其实时预览。

- 节点定义集：
  - 三条主支路，每条都由：
    - `Perlin Noise -> Cross Section`
    - `Voronoi Fractal -> Levels`
    - `Blend`
    - `Perlin Noise`
    - `Directional Warp` x3
    - `Transformation 2D -> Levels`
  - 右侧通过两级 `Blend` 完成三支路汇合
  - 最终还保留一组“辉光增强”的 `Blend` 收尾链
- 连线集：
  - 三条支路各自生成独立闪电分段
  - 下两条先汇合，再与上方支路汇合
  - 汇总结果再经过最终 `Blend` 做辉光叠加输出
- 设置/参数：
  - 当前右侧属性面板显示的是整个 `Substance_graph`
  - `Package` 可见为 `F:/Substance/Example/Tuto/Part_03/Lightning.sbs`
  - `Exposed in SBSAR = Yes`
- 输出/预览：
  - 底部预览为 `1024 x 512 (Grayscale, 16bpc)`
  - 最终成品是一组三线交织的发光闪电：左侧更密、中心交会最亮、右侧拉成长尾，整体已经具备直接作为特效纹理使用的完成度

这张图的意义是“交付态确认”。从工程命名、SBSAR 暴露状态和最终预览来看，这张闪电纹理已经被整理成可保存、可导出的完整图资产，而不只是教程中途的节点实验结果。

## 补充视觉证据

### S02 00:04:30

这张补充截图对应 `S02 00:04:30`，作用是补足早期主线生成阶段第一张 `Directional Warp` 的实际参数。它比正文主截图更清楚地展示了 `Cross Section + Blend + Perlin Noise` 如何送入首次扭曲。

- 节点定义集：
  - `Cross Section`
  - `Blend`
  - `Perlin Noise`
  - `Directional Warp`
- 连线集：
  - `Cross Section.output -> Blend`
  - `Blend.output -> Directional Warp.input`
  - `Perlin Noise.output -> Directional Warp` 的强度/扭曲驱动输入
- 设置/参数：
  - 当前选中节点：`Directional Warp`
  - `Intensity = 10`
  - `Warp Angle = 66.49 Degrees`
  - `Turns = 0.18469444`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 底部预览是 `1024 x 512 (Grayscale, 16bpc)`
  - 结果为一条整体较平、带轻微起伏和细碎边缘噪声的横向白线，说明这一步只是给基础曲线加入初级扰动

这张补图的重要性在于，它证明 `S02` 初期扭曲并不是高强度大幅摆动，而是用较低 `Intensity` 配合约 `66.5` 度的斜向扭曲，先把线条打出轻微毛边和缓慢起伏，作为后面多次扭曲叠加的起点。

### S03 00:07:19

这张补充截图对应 `S03 00:07:19`，补足了中前段“三次连续扭曲后接 `Transformation 2D`”的真实图结构。它的主要价值是确认 `Voronoi Fractal` 从这里开始同时驱动后两级 `Directional Warp`。

- 节点定义集：
  - 左侧前置链末端（未完整入镜）
  - `Directional Warp` x3
  - `Voronoi Fractal`
  - `Transformation 2D`
- 连线集：
  - 第一张 `Directional Warp.output -> 第二张 Directional Warp.input`
  - 第二张 `Directional Warp.output -> 第三张 Directional Warp.input`
  - `Voronoi Fractal.output` 同时接入第二张与第三张 `Directional Warp` 的驱动输入
  - 第三张 `Directional Warp.output -> Transformation 2D.input`
- 设置/参数：
  - 当前选中节点：`Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = 0`
- 输出/预览：
  - 底部预览为 `1024 x 512 (RGBA, 8bpc)`
  - 当前预览未显示有效线条结果，只能确认此时正在查看 `Transformation 2D` 的空白/默认视图，而不是最终扭曲后的灰度线输出

这张补图主要用于证实结构而不是效果：从这里开始，教程正式形成“前一级线条结果 + Voronoi Fractal 双重驱动后两级扭曲”的模式，并在进入 `Transformation 2D` 之前完成三层连续形变。

### S06 00:16:02

这张补充截图对应 `S06 00:16:02`，补足了“多条闪电线送入 `Tile Sampler Grayscale` 前”的关键接法和输出尺寸设置。它比正文截图更清楚地说明了两条线支路如何一起进入平铺节点。

- 节点定义集：
  - 上支路：
    - `Transformation 2D -> Blur HQ Grayscale -> Levels -> Blend -> Transformation 2D`
  - 下支路：
    - `Transformation 2D -> Blur HQ Grayscale -> Levels -> Blend -> Transformation 2D`
  - 汇合节点：
    - `Tile Sampler Grayscale`
  - 输出后处理：
    - 右侧 `Transformation 2D`
- 连线集：
  - 上下两条支路的 `Transformation 2D.output` 都接入 `Tile Sampler Grayscale`
  - 另外还存在一条附加输入也接入 `Tile Sampler Grayscale`，共同组成平铺模板
  - `Tile Sampler Grayscale.output -> 右侧 Transformation 2D.input`
- 设置/参数：
  - 当前选中右侧 `Transformation 2D`
  - 右侧 `Properties` 已切到 `Output Size = Absolute`
  - `Width = 1024 px`
  - `Height = 1024 px`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
- 输出/预览：
  - 底部预览是 `1024 x 1024 (Grayscale, 16bpc)`
  - 当前可见四条横向白色闪电线，从上到下均匀排布，说明平铺后的结果已经被整理成近似方形画幅

这张补图的关键结论是：`S06` 并不是单纯把一条线复制四次，而是把两条经过不同处理的线支路一起送进 `Tile Sampler Grayscale`，再把输出尺寸切到 `1024x1024`，以便得到适合后续贴图使用的方形闪电纹理版式。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


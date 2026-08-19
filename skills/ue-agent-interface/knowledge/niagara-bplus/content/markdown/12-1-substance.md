# 12-1-创建-Substance-贴花纹理资源

# 12-1-创建-Substance-贴花纹理资源

## 关键术语

- `Material`、`UV`、`Multiply`、`Normal`、`Substance`、`Fluid`、`材质`、`纹理`、`基础颜色`、`Niagara`、`Masked`、`颜色`、`流体`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`

## 分段知识

### 00:00:05-00:02:59 UV、颜色、纹理

- 本段定位：UV、颜色、纹理。
- 知识点：你好,在12课问候你,这次后续会制作用于贴花的。
- 知识点：纹理资源的时间,这次作为设计师制作纹理的进展是,需要用一些除了平常使用的节点,更难一点的节点来尝试,需要创建一个新图形吧。
- 知识点：我们一直用MT来制作,这次会从包含技术粗糙度的路径开始构成,而且我们一直只看平面的2D画面来制作。
- 知识点：现在我看这个画面,现在用在贴花上的纹理,有点希望,对超越有更明显的表达。
- 知识点：我觉得把这里分成两部分来查看会更好。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

这一帧进入 `Adobe Substance 3D Designer` 的起始首页，表示本课从制作贴花纹理资源开始，而不是先在 Unreal 或材质图里改现成贴图。

图中可直接确认的信息：

- 软件：`Adobe Substance 3D Designer (Steam edition)`
- 当前页签：`Home`
- 左侧可用入口：
  - `New Substance graph...`
  - `Open package...`
  - `New MDL graph...`
  - `Import AxF...`
- 最近文件列表中可见资源：
  - `Decal.sbs`
  - `Mask.sbs`
  - `Ribbon.sbs`
  - `Tile.sbs`
  - `Aura_V.sbs`
  - `Gradation.sbs`
  - `cell.sbsar`
  - `Normal.sbs`
  - `Lightning.sbs`
  - `Toon.sbs`

这张图能说明两个关键点：

1. 本课的贴花纹理资源是在 Substance Designer 中新建或继续编辑 `.sbs` 图来完成。
2. 教程作者已经维护了一组可复用的纹理工程文件，其中 `Decal.sbs`、`Mask.sbs` 等很可能会直接参与本课流程。

复建时可先打开 Substance Designer，并准备一个新的或现有的 `Decal` 类 `.sbs` 工程作为工作起点。
这一帧已经进入新建的 Substance 图表编辑界面，当前图名为 `Substance_graph`。画面说明教程先搭一个最小可预览的材质输出骨架，再逐步往里面加入用于贴花的纹理结构。

当前图中可直接确认的结构如下：

- 图表：`Substance_graph`
- `Parent Size = 1024 x 1024`
- 已打开三个主要工作区：
  - `Basecolor - 2D VIEW`
  - `Rounded Cube - OpenGL - 3D VIEW`
  - 右侧属性面板，当前选中输出为 `height`

节点定义集：

- `Uniform Color`（黑）
- `Metallic` 输出
- `Uniform Color`（白）
- `Ambient Occlusion` 输出
- `Uniform Color`（灰）
- `Height` 输出

连线集：

- 黑色 `Uniform Color` 连接到 `Metallic`
- 白色 `Uniform Color` 连接到 `Ambient Occlusion`
- 灰色 `Uniform Color` 连接到 `Height`

设置/参数：

- `Height` 输出在右侧属性里可见：
  - `Identifier = height`
  - `Label = Height`
  - `Group = Material`
  - `Usage = height`
  - `Components = RGBA`
- 左侧 `LIBRARY` 当前定位在 `Texture generators -> Noises`，可见 `3D Perlin Noise` 等噪声资源，说明下一步大概率会从噪声节点开始构造贴花纹理。

输出/预览：

- `Basecolor - 2D VIEW` 当前只是统一灰色底图
- `3D VIEW` 中的圆角立方体也只显示基础灰色材质，没有明显纹理起伏

这张图的作用是确立起始模板：先给常用输出通道挂上最简单的默认值，并同时开启 2D/3D 预览，后续每加一个纹理节点都能即时检查平面结果和三维材质表现。
这一帧开始真正搭建贴花纹理图。当前已放入一个 `Shape` 节点作为基础形状，2D 视图能看到它输出的是中心亮、边缘暗的圆形渐变，右侧属性表明当前使用的是 `Cone` 图案。

节点定义集：

- `Shape`
- 打开的节点搜索/添加面板，当前高亮候选为 `Gradient Map`

当前 `Shape` 节点可确认的属性如下：

- `Output Size = Parent x 1`
- `Pixel Size = 1 x 1`
- `Pixel Ratio = Square`
- `Tiling Mode = H and V Tiling`
- `Random Seed = 0`
- `Pattern = Cone`
- `Tiling = 1`
- `Scale = 1`
- `Size X = 1`
- `Size Y = 1`
- `Angle = 0`
- `Turns = 0`
- `Rotation 45° = False`
- `Non Square Expansion = True`
- `Non Square Tiling = False`

输出/预览：

- `Shape - 2D VIEW` 中是一个白心黑边的柔和圆形锥度图
- 底部状态显示为 `1024 x 1024 (Grayscale, 16bpc)`
- 右下 3D 预览仍是基础灰色材质，说明该形状节点尚未接入最终材质输出链

这张图能说明本课贴花纹理的起点不是复杂噪声，而是一个可控的基础径向形状。复建时可先用 `Shape(Cone)` 得到圆形渐变基底，再继续接 `Gradient Map`、`Levels`、`Blend` 等节点，把它扩展成更明确的贴花颜色和纹理结构。

### 00:03:10-00:06:15 颜色

- 本段定位：颜色。
- 知识点：需要把机器人用作面具,然后在正方形这个状态下,将其制作成40x40。
- 知识点：尺寸要非常小,要有像像素一样的感觉。
- 知识点：只要有点的表现就行,所以会随机混合。
- 知识点：用遮罩提高预值后,只对这里遮罩中的输入区域, 在白色部分,瓷砖采样功能就会启动。
- 知识点：给这里的颜色随机的话,会有暗的也有亮的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Masked`、`颜色`。

**关键画面：**

这一帧把上一段的 `Shape` 基础形状推进为可控遮罩：`Shape` 已经接入 `Histogram Scan`，用阈值扫描把原来的柔和圆形渐变压成更干净的黑白掩码。

节点定义集：

- `Shape`
- `Histogram Scan`

连线集：

- `Shape` 输出连接到 `Histogram Scan` 输入

当前 `Histogram Scan` 可确认的参数：

- `Output Size = Input x 1`
- `Output Format = 16 Bits per Channel`
- `Pixel Ratio = Square`
- `Tiling Mode = H and V Tiling`
- `Random Seed = 0`
- `Position = 0.4`
- `Contrast = 1`
- `Invert Position = False`

输出/预览：

- `Histogram scan - 2D VIEW` 中已经得到一个白色实心圆盘，背景纯黑
- 底部状态显示为 `1024 x 1024 (Grayscale, 16bpc)`
- 3D 预览当前还没有明显可见变化，说明这个遮罩节点此时仍主要用于后续图案构造，而非直接驱动最终材质通道

这一步对应正文里“提高预值后，只对遮罩中的输入区域生效”的前置准备。复建时可以先用 `Histogram Scan` 把 `Shape(Cone)` 压成边界更明确的圆形遮罩，再继续把它送进后续的平铺、随机颜色或碎裂结构。
这一帧把圆形遮罩进一步送进 `Tile Sampler Grayscale`，开始生成“像像素一样”的随机小点分布。结果图已经不再是实心圆，而是在圆形区域内散布大量白色细点。

节点定义集：

- `Shape`
- `Histogram Scan`
- `Tile Sampler Grayscale`

连线集：

- `Shape` 输出连接到 `Histogram Scan`
- `Histogram Scan` 输出连接到 `Tile Sampler Grayscale` 的遮罩相关输入，用于限制小点只出现在圆形区域内

当前 `Tile Sampler Grayscale` 右侧可见参数如下：

- `Mask Map Threshold = 0.24`
- `Mask Map Invert = False`
- `Mask Map Sampling Technique = Pattern Center`
- `Mask Random = 0`
- `Invert Mask = False`
- `Blending Mode = Max`
- `Color = 白色`
- `Color Random = 1`
- `Color Parameterization Mode = Color Input`
- `Color Parameterization Multiplier = 0`
- `Global Opacity = 1`
- `Background Color = 黑色`
- `Reverse Rendering Order = False`

输出/预览：

- `tile sampler - 2D VIEW` 中可见一个圆形范围内由大量零散亮点组成的图案
- 点的大小非常小，整体已经呈现出“像素颗粒”而不是连续面
- 圆形外部仍保持纯黑，说明遮罩限制生效正常

这一步对应正文里“尺寸要非常小、只要有点的表现、随机混合”的要求。复建时可先用圆形遮罩限定区域，再让 `Tile Sampler` 在该区域内打散微小点状图案，而不是直接在全画幅随机撒点。
这一帧在点状分布基础上再加了一层区域控制：左侧已经出现 `Blend` 节点，当前输出不再是填满整个圆盘的点，而是围绕中心形成一圈环状点带，说明教程正在把点状纹理收束到更接近 decal 边缘的位置。

节点定义集：

- `Blend`
- `Tile Sampler Grayscale`
- 左下方还能看到一个竖向白黑输入片段，作为 `Blend` 的另一侧输入来源，但当前帧未完整显示其节点名

连线集：

- `Blend` 输出连接到 `Tile Sampler Grayscale` 的遮罩相关输入
- `Blend` 左侧接入了两路输入：
  - 一路是上方已有的圆形/环形遮罩链
  - 一路是下方额外的白黑图形输入

当前 `Tile Sampler Grayscale` 可确认的参数如下：

- `X Amount = 20`
- `Y Amount = 40`
- `Non Square Expansion = True`
- `Pattern = Square`
- `Rotation = 0`
- `Rotation Random = 0`
- `Symmetry Random = 0`
- `Symmetry Random Mode = Horizontal + Vertical`

输出/预览：

- `tile sampler - 2D VIEW` 中的结果已经从“整块圆形点分布”变成“边缘一圈较密、中心留空的点状环”
- 点仍然非常细小，保持像素颗粒感
- 黑底区域占比变大，说明当前步骤的主要目的不是增加密度，而是限定有效分布区域

这张图能把本段思路说清楚：先用 `Histogram Scan` 做圆形遮罩，再通过 `Blend` 把中心区域压掉，最后交给 `Tile Sampler` 在剩余区域里生成小方块颗粒。复建时如果需要类似贴花边缘颗粒，不要只做满圆点阵，而应把点约束成这种环状带。

### 00:06:22-00:09:42 颜色、破碎

- 本段定位：颜色、破碎。
- 知识点：这次会把这两个合并成一个Max选了量的值。
- 知识点：再做一个shape,这个大概是中间穿孔的区域。
- 知识点：这个直接用圆盘的形状,缩小一下scale。
- 知识点：这种话就这里的碎片就会好好长,就不会破碎了。
- 知识点：会把颜色值相关的全部分开,那么这个不会随机,会有一样的颜色值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一张图展示在 `Adobe Substance 3D Designer` 中把两个灰度结果合并到同一个 `Blend` 节点的做法，对应字幕“这次会把这两个合并成一个”。

`节点定义集`

- 节点 A：左上方一个灰度形状节点，缩略图表现为中空圆盘/圆环，输出标签可见 `1024x1024 - L16`。
- 节点 B：左下方 `Tile Sampler Grayscale`，用于批量生成小方块图案。
- 节点 C：右侧 `Blend`，作为当前合并结果节点，输出标签可见 `1024x1024 - L16`。

`连线集`

- 节点 A 的输出连接到 `Blend` 的一个主输入。
- `Tile Sampler Grayscale` 的输出连接到 `Blend` 左侧下方输入口，可按遮罩/不透明度输入理解。

`设置/参数`

- 当前右侧属性面板打开的是 `tile_sampler - PROPERTIES`，可直接确认的 `Tile Sampler Grayscale` 参数如下：
- `Output Format = 8 Bits per Channel`
- `Pixel Size = Width 1, Height 1`
- `Pixel Ratio = Square`
- `Tiling Mode = H and V Tiling`
- `Random Seed = 0`
- `X Amount = 40`
- `Y Amount = 40`
- `Non Square Expansion = True`
- `Pattern = Square`
- `Rotation = 0`
- `Rotation Random = 0`
- `Symmetry Random = 0`
- `Symmetry Random Mode = Horizontal + Vertical`
- 图中未显示 `Blend` 的混合模式或其余输入含义，因此这里不能进一步确认。

`输出/预览`

- 底部 `Blend - 2D VIEW` 当前显示为黑色结果预览，说明此时合并结果已经被送到 2D 视图。
- 底部同时打开 `Rounded Cube - OpenGL - 3D VIEW`，用于在几何体上检查材质表现，但该视图未展示额外参数调整。
这一张图展示把前一步 `Blend` 的合并结果接入 `Distance` 节点，并额外用一个 `Histogram Scan` 作为遮罩输入。字幕可确认的操作语义是“把这个像素值放到 source 这里面”。

`节点定义集`

- 节点 A：左侧上方 `Blend`，为前一步的合并结果。
- 节点 B：左侧下方第二个 `Blend`，当前被作为主要输出源，节点左侧可见 `Foreground`、`Background`、`Opacity` 三个输入标识。
- 节点 C：上方 `Histogram Scan`，缩略图中可见少量亮点，输出标签为 `1024x1024 - L16`。
- 节点 D：右侧 `Distance`，当前为选中状态，输出标签为 `1024x1024 - L8`。

`连线集`

- 左上 `Blend` 的输出连接到左下 `Blend` 的 `Foreground` 输入。
- 左下 `Blend` 的输出连接到 `Distance` 左侧中部的主输入口，可按 `Source` 输入理解。
- `Histogram Scan` 的输出连接到 `Distance` 左侧上方输入口，节点旁清晰标有 `Mask Input`。

`设置/参数`

- 当前右侧属性面板打开的是 `Distance - PROPERTIES`。
- `Output Format = 8 Bits per Channel`
- `Pixel Size = Width 1, Height 1`
- `Pixel Ratio = Square`
- `Tiling Mode = H and V Tiling`
- `Random Seed = 0`
- `Color Mode = Grayscale`
- `Maximum Distance = 10`
- `Distance Mode = Euclidean distance`
- 面板中还能看到 `Combine Source/Distance` 区域，但当前具体选项状态无法从图中可靠确认。

`输出/预览`

- 底部 `Distance - 2D VIEW` 当前为纯黑预览，说明 `Distance` 节点已被送到 2D 视图中观察结果。
- 底部 `Rounded Cube - OpenGL - 3D VIEW` 仍保持默认几何体预览，没有显示新的材质细节。
这一张图展示在 `Distance` 结果后接一个 `Edge Detect`，把破碎块之间的边界提取出来，底部 2D 视图已经能看到清晰的黑色裂缝线条和白色碎片块面。

`节点定义集`

- 节点 A：左下方 `Blend`，作为前级输入来源之一。
- 节点 B：左上方 `Histogram Scan`，继续作为上方辅助输入。
- 节点 C：中间 `Distance`，缩略图中可见放射状破碎图案，输出标签为 `1024x1024 - L16`。
- 节点 D：右侧 `Edge Detect`，当前被选中，缩略图里已经显示黑白裂缝结果，输出标签为 `1024x1024 - L16`。

`连线集`

- `Blend` 的输出连接到 `Distance` 的主输入。
- `Histogram Scan` 的输出连接到 `Distance` 的上方辅助输入。
- `Distance` 的输出连接到 `Edge Detect` 的输入。

`设置/参数`

- 当前右侧属性面板打开的是 `edge_detect - PROPERTIES`。
- `Output Format = 16 Bits per Channel`
- `Pixel Size = Width 1, Height 1`
- `Pixel Ratio = Square`
- `Tiling Mode = H and V Tiling`
- `Random Seed = 0`
- `Edge Width = 1`
- `Invert = False`
- `Tolerance = 0`
- `Edge Roundness` 参数面板可见，但图中没有足够信息确认其具体数值。

`输出/预览`

- 底部 `Edge detect - 2D VIEW` 显示黑底裂缝线和白色碎块区域，说明当前已经从距离场中提取出破碎边缘。
- 右下角 `Rounded Cube - OpenGL - 3D VIEW` 仍是默认几何体观察窗口，本图重点是 2D 裂缝纹理结果而不是三维材质展示。

### 00:09:45-00:13:09 颜色

- 本段定位：颜色。
- 知识点：可以认为是粗度,比太薄的适当粗一点。
- 知识点：就比太密集的这样石头的片段有或没有的空白,也会让这种感觉更自然。
- 知识点：在这里进行Combine Source时。
- 知识点：只用Only Source的话,这里之前看到的点其实就是。
- 知识点：这是FloorZilla这个节点。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`流体`。

**关键画面：**

这是在 Substance Designer 中继续处理碎片遮罩的节点图，目的是把前一步生成的碎片块状分布进一步转换为可区分中心区域与边缘区域的距离场。

节点定义集：
- `Blend`：左侧已有结果输入节点，输出一张黑底碎片分布图。
- `Histogram Scan`：上游阈值化节点，作为 `Distance` 的另一输入来源之一。
- `Distance`：当前选中的核心节点，输入为前面的碎片图与阈值结果，右侧属性面板显示 `Color Mode = Grayscale`、`Maximum Distance = 256`、`Combine Source/Distance = Combine`、`Distance Mode = Euclidean distance`。
- `Edge Detect` ×2：从 `Distance` 输出分别接出两个边缘检测节点，用于查看不同边界结果。

连线集：
- `Histogram Scan` 输出接入 `Distance`。
- 左侧 `Blend` 输出也接入 `Distance`。
- `Distance` 输出分别连接到上方和右下方两个 `Edge Detect` 节点。

设置/参数：
- `Distance` 节点处于灰度模式。
- 距离计算模式为欧氏距离。
- 源与距离的组合模式使用 `Combine`，不是 `Only Source`。
- 最大距离值为 `256`。

输出/预览：
- `Distance` 的 2D 预览显示为由不规则碎片组成的黑白灰分区图，中心与边缘区域被分开计算。
- 两个 `Edge Detect` 节点分别用于观察距离场边界，其中下方预览能看到大量细碎白色边线。
这一步把前一张图得到的边界检测结果送入 `Flood Fill`，把相互分隔的碎片区域重新识别成独立单元，方便后续分别控制颜色和明暗。

节点定义集：
- `Edge Detect`：左侧输入节点，输出黑白边界图。
- `Flood Fill`：当前选中的核心节点，输入端标注为 `Mask`，右侧额外输出端为 `BBox`。

连线集：
- `Edge Detect` 输出连接到 `Flood Fill` 的 `Mask` 输入。

设置/参数：
- `Flood Fill` 属性面板显示 `Safety/Speed trade-off = Complex or big shapes`。
- `Show Advanced options = False`。
- 其余输入参数在截图中未展开，无法可靠确认更多数值。

输出/预览：
- `Flood Fill` 的 2D 预览是彩色分区图，每个碎片块被赋予不同颜色，中心区域碎片更密，外围块面更大。
- 该结果说明边缘检测后的封闭区域已经被成功识别为可单独处理的碎片单元。
这张图延续上一张的 `Flood Fill` 结果，讲解者在保持碎片分区预览不变的前提下打开节点搜索窗口，准备继续添加颜色映射相关节点。

节点定义集：
- `Edge Detect`：左侧黑白边界输入节点，继续连到后续流程。
- `Flood Fill`：当前仍保留在图中的区域分割节点，输出彩色碎片分区图。
- 节点搜索窗口：搜索框内已输入 `g`，候选列表顶部高亮为 `Gradient Map`。

连线集：
- `Edge Detect` 输出仍连接到 `Flood Fill` 的 `Mask` 输入。
- 当前截图中未出现新的已连接节点。

设置/参数：
- `Flood Fill` 属性面板仍显示 `Safety/Speed trade-off = Complex or big shapes`。
- `Show Advanced options = False`。
- 搜索列表中可见的候选以 `Gradient Map` 为首，说明下一步准备添加渐变映射类节点，但本图尚未放置该节点。

输出/预览：
- 下方 2D 预览继续显示彩色碎片分区，中心碎片最密集，向外逐渐过渡为较大的块面。
- 这一步的可确认操作是保留区域编号结果，并进入颜色处理节点的选择阶段。

### 00:13:21-00:16:19 UV、颜色

- 本段定位：UV、颜色。
- 知识点：在哪里呢? 再加一个形状节点。
- 知识点：把这个作为灰度输入放进去的话,可以作为这个圆的参考。
- 知识点：关于这个形状,颜色直接变成灰度亮度。
- 知识点：在每个片段中不同地表现。
- 知识点：在这个状态下,通过指缝图扫描,指获取特定的中间区域。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一步进入颜色控制流程，把 `Flood Fill` 生成的碎片分区图转换为每个碎片独立的灰度亮度值，便于后续直接把灰度当作颜色明暗使用。

节点定义集：
- `Edge Detect`：左侧已有边界图输入节点。
- `Flood Fill`：中间的区域分割节点，输出彩色碎片分区图。
- `Flood Fill to Grayscale`：右侧新添加的核心节点，把 `Flood Fill` 的区域编号结果转换成灰度图；属性面板可见 `Luminance Adjustment` 与 `Luminance Random` 两项。
- 节点搜索窗口：当前搜索列表顶部是 `Gradient Map`，说明讲解过程中刚从搜索窗口继续添加颜色相关节点。

连线集：
- `Edge Detect` 输出连接到 `Flood Fill` 的 `Mask` 输入。
- `Flood Fill` 的主输出连接到 `Flood Fill to Grayscale` 的输入端。

设置/参数：
- `Flood Fill to Grayscale` 的 `Luminance Adjustment = 0`。
- `Flood Fill to Grayscale` 的 `Luminance Random = 0`。
- 其他参数在截图中未显示，无法可靠确认。

输出/预览：
- 当前 `Flood Fill to Grayscale` 的 2D 预览窗口还是纯黑，说明节点刚接入或结果尚未调出可见亮度层次。
- 这一步的重点是先建立“每个碎片块可被单独赋予灰度值”的转换节点。
这一步开始按教程说明“通过直方图扫描获取特定的中间区域”。做法是在碎片灰度分布的基础上叠加一个中心亮、边缘暗的径向 `Shape`，然后把结果送入 `Histogram Scan`，只截出中心那一圈需要的碎片。

节点定义集：
- `Edge Detect`：左上角边界图输入节点。
- `Flood Fill`：左中区域分割节点。
- `Shape`：左下新增的圆形渐变节点，预览为中心亮、外围暗的柔和圆斑。
- `Flood Fill to Grayscale`：中间核心节点，同时接收 `Flood Fill` 与 `Shape`，预览中可见中心较亮、外围较暗的碎片亮度分布。
- `Histogram Scan`：右侧当前选中的阈值提取节点，用来从灰度结果中截取目标区域。

连线集：
- `Edge Detect` 输出连接到 `Flood Fill`。
- `Flood Fill` 输出连接到 `Flood Fill to Grayscale` 的上方输入。
- `Shape` 输出连接到 `Flood Fill to Grayscale` 的下方输入。
- `Flood Fill to Grayscale` 输出连接到 `Histogram Scan`。

设置/参数：
- `Histogram Scan` 的 `Position = 0.79`。
- `Histogram Scan` 的 `Contrast = 1`。
- `Histogram Scan` 的 `Invert Position = True`。
- 其余参数未在截图中显示。

输出/预览：
- `Flood Fill to Grayscale` 预览显示中心区域更亮、外围更暗的碎片灰度分布。
- `Histogram Scan` 的 2D 预览只保留中间一团白色碎片，外围区域被压成黑色，说明目标中心片段已被成功筛选出来。
这一步把中心区域遮罩继续与碎片边界结果做合成，得到一个“中心黑洞 + 外围碎片裂缝线”的灰度蒙版，供后续继续上颜色或细化纹理。

节点定义集：
- 上方已有碎片边界结果节点：标题在截图中被截断，但输出预览为白底黑线的碎片裂缝图。
- `Distance`：左下节点，输出一个中心为亮、外围为暗的小圆形距离遮罩。
- `Invert Grayscale`：中下节点，把 `Distance` 的黑白关系反转，使中心区域变成黑色洞口遮罩。
- `Blend`：右侧当前选中的合成节点，属性面板显示本步使用乘法混合。
- 节点搜索窗口：右侧搜索列表顶部仍是 `Gradient Map`，说明后续仍准备进入颜色映射节点。

连线集：
- 上方碎片边界结果节点输出连接到 `Blend` 的上方输入。
- `Distance` 输出连接到 `Invert Grayscale`。
- `Invert Grayscale` 输出连接到 `Blend` 的下方输入。

设置/参数：
- `Blend` 的 `Opacity = 1`。
- `Blend` 的 `Blending Mode = Multiply`。
- `Cropping Area` 保持默认：`Left = 0`、`Right = 1`、`Top = 0`、`Bottom = 1`。
- 上方输入节点的具体标题在截图中不可见，无法可靠补出其精确节点名。

输出/预览：
- `Blend` 的 2D 预览显示大面积白底碎片分块线稿，中间被乘出一个实心黑色中心洞，洞口周围碎片更密，向外逐渐过渡为更大的块面。
- 这说明教程正在把“中心选区”与“碎片裂纹结构”组合成最终的颜色/遮罩基础图。

### 00:16:24-00:19:23 UV

- 本段定位：UV。
- 知识点：对于普通或高度的表达。
- 知识点：我觉得可以再往前推进一下。
- 知识点：如果变成普通的话。
- 知识点：根据鞋帘节点这种。
- 知识点：四个面的弯区有些表现出来。

**关键画面：**

这一步继续沿用上一段生成的中心遮罩裂纹图，在其后增加一个 `Auto Levels` 做灰度范围整理，同时打开节点搜索窗口，开始查找 `Normal` 类节点，准备把当前结果转向法线/表面细节表达。

节点定义集：
- 左侧上游节点链：包含前一步的裂纹合成结果，最右侧可见一个输出为白底黑色中心洞的灰度图节点。
- `Auto Levels`：当前选中的新节点，接在上游灰度图之后，右侧属性面板显示为 `auto_levels - PROPERTIES`。
- 节点搜索窗口：搜索词为 `normal`，候选列表包含 `Normal`、`Facing Normal`、`Height Normal Blender`、`Height to Normal World Units`、`Normal Blend`、`Normal Combine` 等。

连线集：
- 上游灰度图输出连接到 `Auto Levels` 输入。
- 当前截图中尚未放置新的 `Normal` 类节点。

设置/参数：
- `Auto Levels` 的具体实例参数未展开，截图中无法确认更多数值。
- 搜索窗口明确表明下一步目标是添加 `Normal` 相关节点。

输出/预览：
- `Auto Levels` 的 2D 预览仍是白底裂纹结构，中间保留一个实心黑色中心洞，周围碎片从密到疏向外扩散。
- 这说明当前仍在整理可作为高度/遮罩基础的灰度图，为后续法线转换做准备。
这一步把前面的灰度结果正式转成法线，再从法线图里提取曲率边缘，最后用 `Histogram Scan` 做一次干净的阈值筛选。

节点定义集：
- 上游灰度结果节点链：从左上继续向下接入当前流程，具体节点标题在截图里没有完整显示。
- `Normal`：中间的法线生成节点，预览为标准蓝紫色法线贴图。
- `Curvature Sobel`：接在 `Normal` 后面的边缘/曲率提取节点，用于从法线变化中计算裂缝或折线边缘。
- `Histogram Scan`：右侧当前选中的阈值节点，用于把 `Curvature Sobel` 的结果进一步压成清晰的黑白边缘。

连线集：
- 上游灰度结果输出连接到 `Normal`。
- `Normal` 输出连接到 `Curvature Sobel`。
- `Curvature Sobel` 输出连接到 `Histogram Scan`。

设置/参数：
- `Histogram Scan` 的 `Position = 0`。
- `Histogram Scan` 的 `Contrast = 1`。
- `Histogram Scan` 的 `Invert Position = False`。
- 其他节点参数在截图中未显示。

输出/预览：
- `Normal` 节点已经生成蓝紫色法线图。
- 当前 `Histogram Scan` 的 2D 预览窗口几乎全黑，说明阈值提取后的边缘结果被压到很窄，可能正处于初始值或等待后续再调阈值。
- 这一步的核心是从高度/灰度表达切换到法线与曲率表达，为后续 UV 或材质细节提供更适合的边界信息。
这一步继续微调从法线曲率中提取出来的裂缝边缘，并把筛出的边界再次送入 `Flood Fill`，重新生成一张按碎片区域编号的分区图。

节点定义集：
- 上游灰度节点链：左上仍可见 `Invert Grayscale -> Blend -> Auto Levels` 的一段，用来提供进入 `Normal` 的基础灰度图。
- `Normal`：法线生成节点。
- `Curvature Sobel`：从法线中提取曲率/折线边缘。
- `Histogram Scan`：当前选中的阈值节点，用来决定哪些曲率边缘被保留下来。
- `Flood Fill`：右下新增节点，接收 `Histogram Scan` 结果后，把闭合区域重新分配成独立色块。

连线集：
- `Auto Levels` 输出连接到 `Normal`。
- `Normal` 输出连接到 `Curvature Sobel`。
- `Curvature Sobel` 输出连接到 `Histogram Scan`。
- `Histogram Scan` 输出连接到 `Flood Fill`。

设置/参数：
- `Histogram Scan` 的 `Position = 0.63`。
- `Histogram Scan` 的 `Contrast = 1`。
- `Histogram Scan` 的 `Invert Position = False`。
- 其他节点参数在截图中未展开。

输出/预览：
- `Flood Fill` 的 2D 预览显示一张彩色分区图：中心是较大的连通区域，外围被裂缝边线切成许多不规则碎片块，不同块被赋予不同颜色。
- 这说明当前阈值已经足够把部分边界干净分离出来，并重新转换成可继续用于 UV、颜色或材质分配的碎片区域图。

### 00:19:26-00:22:17 Material、Normal、材质

- 本段定位：Material、Normal、材质。
- 知识点：这样表达也没问题。
- 知识点：您可以尝试更完美的组合。
- 知识点：此外如果想更细致表达。
- 知识点：可以把这个区域再细分成三个。
- 知识点：或者把数量分成更大的片段。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`材质`。

**关键画面：**

这一步把从法线曲率中筛出的裂缝边界正式送入新的 `Flood Fill`，重新生成一张更干净的彩色区域分配图，为后面细分材质区域做准备。

节点定义集：
- 上游灰度与法线节点链：左侧可见 `Distance -> Invert Grayscale -> Blend -> Auto Levels -> Normal -> Curvature Sobel -> Histogram Scan` 的完整一段。
- `Histogram Scan`：当前选中的阈值节点，用于保留曲率边界。
- `Flood Fill`：右下新增节点，接收 `Histogram Scan` 的黑白边界图并输出彩色区域图。

连线集：
- `Curvature Sobel` 输出连接到 `Histogram Scan`。
- `Histogram Scan` 输出连接到 `Flood Fill`。

设置/参数：
- `Histogram Scan` 的 `Position = 0.63`。
- `Histogram Scan` 的 `Contrast = 1`。
- `Histogram Scan` 的 `Invert Position = False`。
- 其他节点参数在截图中未展开。

输出/预览：
- `Flood Fill` 的 2D 预览显示中心是一块较大的连续区域，外围被黑色裂缝线切分成多圈不规则色块，不同区块被赋予不同颜色。
- 这说明当前裂缝边界已经足够闭合，可以重新生成独立碎片区域，便于继续做材质分层或更细的区域控制。
这一步把重新生成的碎片分区图送入 `Flood Fill to Gradient 2`，给每个碎片面生成按方向变化的内部灰度坡度，用于后续材质高低或更细的法线表现。

节点定义集：
- 左侧上游节点链：可见 `Histogram Scan -> Flood Fill` 的一段，`Flood Fill` 输出彩色区域图。
- `Flood Fill to Gradient 2`：当前选中的核心节点，把区域分区结果转换为每块内部带方向性的灰度渐变图。
- 右侧竖向一列输出节点：截图可见多个小预览节点接在不同结果之后，用来查看中间灰度、法线和分区结果，但具体节点标题在截图中不可可靠辨认。

连线集：
- `Flood Fill` 输出连接到 `Flood Fill to Gradient 2`。
- `Flood Fill to Gradient 2` 的输出继续拉线连接到右侧的预览/后续节点链。

设置/参数：
- `Flood Fill to Gradient 2` 的 `Angle = 0`。
- `Angle Variation = 0`。
- `Multiply by Bounding Box Size = 0`。
- `Angle Image Input Multiplier = 0`。
- `Slope Image Input Multiplier = 0`。
- `Multiply by Slope Intensity = 1`。
- `Flat Slope Color` 为灰色，亮度约 `0.5`。

输出/预览：
- `Flood Fill to Gradient 2` 的 2D 预览显示每个碎片块内部都带有从亮到暗的灰度坡度，中心与外围碎片都保留了黑色裂缝边界。
- 这说明教程此时不再只关心碎片分区，而是进一步为每个碎片面生成可用于材质起伏和法线细节的内部明暗方向。
这一步切到 Substance Designer 的默认 OpenGL 材质属性面板，检查当前图是否已经正确驱动法线、高度和其他材质通道，并直接在 2D/3D 预览里查看碎片裂缝的表面效果。

节点定义集：
- 左下当前可见节点：`Flood Fill to Gradient 2`，其输出继续连到右侧的输出/材质节点链。
- 右侧竖向输出链：可见多组输出结果节点，分别对应灰度、法线、高度等材质相关结果；中间一组明显是蓝紫色法线输出。
- 材质面板：右侧为 `Material "Default" - OpenGL - PROPERTIES`，正在查看默认材质对各通道的映射。

连线集：
- `Flood Fill to Gradient 2` 的结果继续接到右侧输出节点链。
- 材质面板引用这些图作为默认材质各通道输入，其中截图能确认至少包含法线与高度结果。

设置/参数：
- `Roughness` 已启用，来源为 `Graph Node`。
- `Metallic` 已启用，当前为黑色输入。
- `Height` 已启用，来源为灰度 `Graph Node`，`Scale = 1`。
- `Ambient Occlusion` 已启用，来源为 `Graph Node`。
- `Anisotropy Level` 已启用，当前滑条值为 `0`。
- `Anisotropy Angle` 为 `0`。
- `Emissive` 已启用，但 `RO/GO/BO` 数值均为 `0`，`Emissive Intensity = 1`，`sRGB Emission Texture = True`。

输出/预览：
- 左下 `Normal - 2D VIEW` 显示蓝紫色法线贴图，裂缝边缘有明显的法线颜色变化。
- 右下 3D 预览中的立方体表面已经出现中心凹陷、外围裂缝和碎片块高低起伏，说明高度/法线材质效果已经成功作用到模型表面。
- 这一步的核心是确认材质通道挂接与 OpenGL 预览效果，为后续进一步细分区域或继续做 UV/乘法叠加打基础。

### 00:22:24-00:25:17 UV、Multiply

- 本段定位：UV、Multiply。
- 知识点：可以把这个表示倾斜的节点设为洪水场道T度。
- 知识点：用Check这个节点再拿一个渐变。
- 知识点：会作为演用器作用。
- 知识点：可以把这个选项这样转动来控制。
- 知识点：可以把这个选项转动来控制。
- 核对对象：`Multiply`。

**关键画面：**

这一步继续使用 `Flood Fill to Gradient 2` 生成的区域内灰度坡度，讲解其作用是让每个碎片面内部都具有统一方向的明暗变化，从而在材质预览中表现出一致的倾斜面感。

节点定义集：
- 左侧上游节点链：可见从区域/法线流程继续接出的结果链，最终进入当前的渐变节点。
- `Flood Fill to Gradient 2`：当前选中的核心节点，把碎片分区转换成每块内部具有统一方向的灰度坡度。
- 右侧输出节点列：继续接收 `Flood Fill to Gradient 2` 的结果，供后续法线、高度或材质使用。

连线集：
- 上游区域结果连接到 `Flood Fill to Gradient 2`。
- `Flood Fill to Gradient 2` 输出继续连接到右侧输出节点链。

设置/参数：
- `Angle = 0`。
- `Angle Variation = 0`。
- `Multiply by Bounding Box Size = 0`。
- `Angle Image Input Multiplier = 0`。
- `Slope Image Input Multiplier = 0`。
- `Multiply by Slope Intensity = 1`。
- `Flat Slope Color` 为灰色，亮度约 `0.5`。

输出/预览：
- `Flood Fill to Gradient 2` 的 2D 预览显示每个碎片块内部都有统一方向的亮暗渐变，裂缝边界仍然保持清晰。
- 右下 3D 预览中，表面出现成片的倾斜切面效果，说明该灰度渐变已经成功参与高度/法线表现，而不是只停留在平面遮罩阶段。
这一步是在 `Flood Fill to Gradient 2` 上增加额外的方向控制输入，并旋转渐变方向，让碎片裂缝与切面的表现更自然。

节点定义集：
- `Curvature Sobel`：左上来自法线曲率的边缘提取节点。
- `Histogram Scan`：把曲率结果阈值化成干净裂缝边界。
- `Flood Fill`：把裂缝闭合区域重新分配成彩色分区。
- `Shape`：左下新增的圆形渐变节点，作为额外控制输入。
- `Flood Fill to Gradient 2`：当前选中的核心节点，同时接收 `Flood Fill` 与 `Shape`，输出带方向变化的碎片灰度坡度。

连线集：
- `Curvature Sobel` 输出连接到 `Histogram Scan`。
- `Histogram Scan` 输出连接到 `Flood Fill`。
- `Flood Fill` 主输出连接到 `Flood Fill to Gradient 2`。
- `Shape` 输出连接到 `Flood Fill to Gradient 2` 的附加输入。
- `Flood Fill to Gradient 2` 输出继续连接到右侧后续节点链。

设置/参数：
- `Angle = 0.50525 Turns`，即 `181.89 Degrees`。
- `Angle Variation = 0.56`。
- `Multiply by Bounding Box Size = 0`。
- `Angle Image Input Multiplier = 0`。
- `Slope Image Input Multiplier = 0`。
- `Multiply by Slope Intensity = 1`。
- `Flat Slope Color` 为灰色，亮度约 `0.5`。

输出/预览：
- `Flood Fill to Gradient 2` 的 2D 预览显示各碎片面内部灰度方向不再完全整齐一致，而是结合中心圆形控制形成更自然的明暗过渡。
- 右下 3D 预览中，碎片切面和裂缝立体感更丰富，说明这一组方向与变体参数正在直接影响材质表面的细节表现。
这一步保持当前 `Flood Fill + Shape -> Flood Fill to Gradient` 的区域坡度结果不变，同时打开节点搜索窗口，准备继续添加新的 `Flood Fill` 系列节点来扩展 UV/Multiply 阶段的细分控制。

节点定义集：
- `Curvature Sobel`：左上曲率边缘提取节点。
- `Histogram Scan`：把曲率结果阈值化。
- `Flood Fill`：根据裂缝边界重新生成彩色分区。
- `Shape`：下方圆形渐变控制节点。
- `Flood Fill to Gradient`：中间当前保留的区域渐变节点，输出每块碎片内部的灰度坡度图。
- 节点搜索窗口：搜索词为 `flooed`，候选列表里可见 `Flood Fill to Color`、`Flood Fill to Gradient`、`Flood Fill to Grayscale`、`Flood Fill to Position`、`Flood Fill to Random Color`、`Flood Fill to Random Grayscale`、`Flood Fill to Index` 等。

连线集：
- `Histogram Scan` 输出连接到 `Flood Fill`。
- `Flood Fill` 输出连接到 `Flood Fill to Gradient`。
- `Shape` 输出连接到 `Flood Fill to Gradient` 的附加输入。
- 当前截图中未出现新的已连接节点。

设置/参数：
- 右侧打开的是 `Substance_graph - PROPERTIES`，不是单一节点参数面板，因此本图未提供新的数值参数。
- 搜索列表说明后续准备继续使用 `Flood Fill` 家族节点做颜色、灰度、位置或索引类派生结果。

输出/预览：
- `Flood Fill to Gradient` 的 2D 预览继续显示碎片面内部带方向性的灰度坡度，中心与外围裂缝结构保持完整。
- 右下 3D 预览仍能看到表面裂缝与倾斜切面效果，说明当前结果已可稳定驱动材质起伏，下一步是在此基础上继续扩展更多控制图。

### 00:25:23-00:28:18 Fluid、颜色

- 本段定位：Fluid、颜色。
- 知识点：再来一个Distance节点。
- 知识点：现在可以删除边缘部分了。
- 知识点：这样附加的让我们清理。
- 知识点：需要确定的东西虽然有。
- 知识点：会更加明确地有分隔的高度值。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一步在现有 `Flood Fill + Shape -> Flood Fill to Gradient` 的区域坡度流程之外，再从 `Flood Fill` 分出一条支线接入 `Flood Fill to Grayscale`，用于把碎片分区重新转成独立灰度值，方便后续更明确地清理边缘和区分高度层次。

节点定义集：
- `Histogram Scan`：左上从曲率结果中提取裂缝边界的阈值节点。
- `Flood Fill`：把裂缝封闭区域重新编号成彩色碎片分区。
- `Shape`：下方圆形渐变节点，作为区域坡度控制输入。
- `Flood Fill to Gradient`：上方区域坡度节点，继续输出碎片面内部方向渐变。
- `Flood Fill to Grayscale`：右下当前选中的新节点，接收 `Flood Fill` 结果并转换为灰度区域图。

连线集：
- `Histogram Scan` 输出连接到 `Flood Fill`。
- `Flood Fill` 输出连接到 `Flood Fill to Gradient`。
- `Shape` 输出连接到 `Flood Fill to Gradient` 的附加输入。
- `Flood Fill` 另一路输出连接到 `Flood Fill to Grayscale` 的主输入。

设置/参数：
- `Flood Fill to Grayscale` 的 `Luminance Adjustment = 0`。
- `Luminance Random = 0`。
- 其他参数在截图中未显示。

输出/预览：
- 当前 `Flood Fill to Grayscale` 的 2D 预览仍为全黑，说明它刚接入或尚未进一步反相/调节到可见阶段。
- 右下 3D 预览仍保留碎片裂缝和切面高度效果，说明这一步是在现有表面结果基础上新增一张辅助灰度控制图。
这一步继续整理用于颜色/高度分隔的灰度图：先把中心控制图做 `Invert Grayscale`，再与 `Flood Fill to Grayscale` 结合，最后送入新的 `Distance`，得到边界更明确、层次更清晰的灰度高度分区。

节点定义集：
- `Flood Fill to Gradient`：左上保留的区域坡度节点。
- `Invert Grayscale`：左下节点，把中心亮暗关系反转，预览为中心较黑、外围较亮的柔和圆形灰度图。
- `Flood Fill to Grayscale`：中下节点，把碎片分区图转成离散的灰度块。
- `Distance`：右上当前选中的核心节点，用于把灰度分区进一步转换为有分层过渡的距离场结果；属性面板显示为灰度模式。

连线集：
- `Invert Grayscale` 输出连接到 `Flood Fill to Grayscale` 的一侧输入。
- 另一条来自上游分区结果的输入也连接到 `Flood Fill to Grayscale`。
- `Flood Fill to Grayscale` 输出连接到 `Distance`。
- 上方还有一路来自现有流程的输入直接接入 `Distance`。

设置/参数：
- `Distance` 的 `Color Mode = Grayscale`。
- `Maximum Distance = 54.81`。
- `Combine Source/Distance = Only Source`。
- `Distance Mode = Euclidean distance`。

输出/预览：
- `Flood Fill to Grayscale` 预览中，中心与外围碎片已经被分配为不同灰度等级，边界清晰可辨。
- `Distance` 的 2D 预览显示中心黑色区域周围逐步向外过渡为多层灰度碎片块，说明灰度高度值已经被更明确地分隔开。
- 这一步的重点是把碎片区域整理成更适合直接用于颜色或高度控制的离散灰度层。
这一步把两路 `Distance` 处理得到的灰度层结果送入一个 `Blend` 节点进行合并，目的是在保持中心黑色空洞的同时，整理外围碎片区域的灰度高度分区。

节点定义集：
- 上方 `Distance`：输出一张包含中心黑洞与外围碎片灰度层的距离场图。
- 下方 `Distance`：另一条并行的距离场结果，预览同样显示中心黑洞和多层灰度碎片块。
- `Blend`：右侧当前选中的合并节点，用来接收两路 `Distance` 结果并输出统一灰度图。

连线集：
- 上方 `Distance` 输出连接到 `Blend` 的上方输入。
- 下方 `Distance` 输出连接到 `Blend` 的下方输入。

设置/参数：
- `Blend` 的 `Opacity = 1`。
- `Blending Mode = Copy`。
- `Cropping Area` 保持默认：`Left = 0`、`Right = 1`、`Top = 0`、`Bottom = 1`。
- 截图未显示后续是否会切换到其他混合模式，因此本图只能确认当前为 `Copy`。

输出/预览：
- `Blend` 的 2D 预览仍是一张中心纯黑、向外逐层过渡为多圈灰度碎片块的图像。
- 右下 3D 预览可见裂缝和碎片表面高低结构已经比较清晰，说明这些灰度分层结果正在继续服务于表面高度/材质表现。

### 00:28:23-00:30:19 关键流程 10

- 本段定位：关键流程 10。
- 知识点：与这个清晰和清晰的单元格的层层分明的高度值有关。
- 知识点：把这一部分也一起成起来。
- 知识点：关于高度值的阶段。
- 知识点：用自动级别从0到L值。
- 知识点：增加了一个自动级别。

**关键画面：**

这一步把上一批准备好的多路灰度高度结果正式用 `Blend` 的乘法模式叠在一起，强化“碎片切面倾斜感”和“单元格层层分明的高度值”。

节点定义集：
- 左侧上方 `Distance`：输出一张以碎片切面为主的灰度高度图。
- 左侧下方 `Distance`：输出另一张中心黑洞更明显的灰度分层图。
- 上方 `Blend`：中间偏上的已有合并节点，继续提供一张整理后的碎片灰度结果。
- 右侧 `Blend`：当前选中的核心节点，用于接收上方 `Blend` 与下方 `Distance` 的结果进行再次合并。

连线集：
- 左侧上方 `Distance` 输出连接到上方 `Blend`。
- 上方 `Blend` 输出连接到右侧 `Blend` 的上方输入。
- 左侧下方 `Distance` 输出连接到右侧 `Blend` 的下方输入。

设置/参数：
- 右侧 `Blend` 的 `Opacity = 1`。
- `Blending Mode = Multiply`。
- `Cropping Area` 保持默认：`Left = 0`、`Right = 1`、`Top = 0`、`Bottom = 1`。

输出/预览：
- `Blend` 的 2D 预览显示中心为纯黑洞口，外围碎片块面具有更强的明暗层次，单个块面的高低关系比前一批更清楚。
- 右下 3D 预览中，裂缝和碎片切面凸凹感进一步增强，说明乘法叠加后的灰度结果已经直接改善了表面高度表现。
这一步在新的高度分层结果上增加一个 `Histogram Scan`，通过阈值控制只截取中心较大的目标区域，并保留上方一条 `Auto Levels` 支线继续整理整体高度图。

节点定义集：
- `Flood Fill to Grayscale`：左下输入节点，提供离散灰度碎片分区。
- `Distance`：中间主节点，输出中心黑洞与外围灰度层相结合的距离场图。
- 上方 `Blend -> Auto Levels`：一条并行支线，继续保留并整理全局高度结果。
- `Histogram Scan`：右下当前选中的阈值节点，用来从 `Distance` 结果中截取目标区域。

连线集：
- `Flood Fill to Grayscale` 输出连接到 `Distance`。
- `Distance` 输出一条接到上方 `Blend/Auto Levels` 支线。
- `Distance` 另一条输出连接到右下 `Histogram Scan`。

设置/参数：
- `Histogram Scan` 的 `Position = 0.05`。
- `Contrast = 1`。
- `Invert Position = False`。

输出/预览：
- `Histogram Scan` 的 2D 预览显示为白底上的大块黑色中心区域，边缘轮廓已经被独立提取出来。
- 这说明通过降低 `Position`，可以把想要的较宽广中心区域单独拿出来，作为后续颜色或高度控制的专用遮罩。
这一步把前面截取出的中心区域遮罩重新混入整体高度图中，使用 `Blend` 的加亮模式把对应区域的高度/亮度抬起来。

节点定义集：
- `Histogram Scan`：左下节点，输出中心大块区域遮罩。
- 上方两枚灰度结果节点：来自前一步整理后的整体高度图和附加分层图，其中右上小 `Blend` 继续提供一张中间结果。
- 右侧 `Blend`：当前选中的核心节点，用来把中心区域遮罩叠加回整体高度图。

连线集：
- `Histogram Scan` 输出连接到右侧 `Blend` 的下方输入。
- 上方中间结果节点输出连接到右侧 `Blend` 的上方输入。

设置/参数：
- `Blend` 的 `Opacity = 1`。
- `Blending Mode = Add (Linear Dodge)`。
- `Cropping Area` 保持默认：`Left = 0`、`Right = 1`、`Top = 0`、`Bottom = 1`。

输出/预览：
- `Blend` 的 2D 预览显示中心黑洞周围的碎片块亮度被进一步拉开，外围大块碎片形成更明显的高低起伏。
- 右下 3D 预览中，表面层级感继续增强，说明这张中心区域遮罩正在以加亮叠加的方式直接参与最终高度结果。

## 补充视觉证据

### S01 00:01:40

这张补充图展示的是 Substance 图中材质输出端口区域的初始骨架，用来说明当前图已经预留了多个标准材质输出槽位。

节点定义集：
- `Uniform Color -> Metallic`：上方一组，黑色常量直接接到 `Metallic` 输出，表示金属度默认为 0。
- `Uniform Color -> Ambient Occlusion`：中间一组，白色常量接到 `Ambient Occlusion` 输出，表示环境遮蔽默认为 1。
- `Uniform Color -> Height`：下方一组，灰色常量接到 `Height` 输出，作为初始高度占位值。
- 画面上方还可见其他输出槽位的下半部分，但标题在截图中不可完整确认。

连线集：
- 黑色 `Uniform Color` 输出连接到 `Metallic`。
- 白色 `Uniform Color` 输出连接到 `Ambient Occlusion`。
- 灰色 `Uniform Color` 输出连接到 `Height`。

设置/参数：
- 右侧属性面板选中的是 `Height` 输出节点。
- `Identifier = height`，`Label = Height`。
- `Group = Material`。
- `Usage` 明确为 `height`。
- `Format = Default Format`，`Mipmaps = Full pyramid`。

输出/预览：
- 左下 `Basecolor - 2D VIEW` 当前只是均匀灰色画面，说明此补充图的重点不是最终纹理细节，而是材质输出端口的组织方式和默认占位。
- 右下 3D 预览仍显示基础立方体，作为图整体材质输出接线的预览背景。

### S02 00:05:15

这张补充图展示的是一个非常早期的遮罩构建步骤：先得到一张白色圆形区域遮罩，再把它接入 `Blend`，同时打开搜索窗口准备添加 `white` 相关资源或噪声节点。

节点定义集：
- `Histogram Scan`：左下可见节点，预览为黑底上的白色圆形实心区域，用于提供基础圆形遮罩。
- `Blend`：右上当前选中的节点，输入端已经接入上游结果，输出预览目前几乎是纯白。
- 节点搜索窗口：搜索词为 `whit`，候选列表里可见 `studio_white_hard_sunlight`、`studio_white_soft_light`、`studio_white_umbrella_soft_light`、`White Noise Fast`。

连线集：
- `Histogram Scan` 输出连接到 `Blend` 的左侧输入之一。
- 右下还有一条来自 `Blend` 的输出连向画面外后续流程。

设置/参数：
- `Blend` 的 `Opacity = 1`。
- `Blending Mode = Copy`。
- `Alpha Blending = Use Source Alpha`。
- `Cropping Area` 保持默认：`Left = 0`、`Right = 1`、`Top = 0`、`Bottom = 1`。
- 当前截图中尚未放置新的 `white` 相关节点。

输出/预览：
- `Histogram Scan` 已经得到一张干净的圆形白色遮罩。
- `Blend` 的预览几乎为纯白，说明此时主要还在搭建遮罩或占位流程，尚未看到复杂图案叠加结果。

### S03 00:07:58

这张补充图展示了早期碎屑/噪点遮罩的筛选结果：两级 `Blend` 叠加之后，再通过 `Histogram Scan` 提取出稀疏的亮点分布。

节点定义集：
- 左上 `Blend`：第一层合成节点，预览为黑底上散布少量白色亮点。
- 中下 `Blend`：第二层合成节点，继续接收上一层结果与另一条输入，预览同样是黑底上的稀疏白点。
- 右上 `Histogram Scan`：当前选中的筛选节点，用来把前面混合后的灰度信息压成更明确的黑白亮点遮罩。

连线集：
- 左上 `Blend` 输出连接到中下 `Blend` 的输入。
- 中下 `Blend` 输出连接到右上 `Histogram Scan`。
- 中下 `Blend` 还接收一条来自画面外下方的额外输入，但其来源节点在本截图中不可见。

设置/参数：
- `Histogram Scan` 的具体 `Position` 数值在截图中未清晰显示，无法可靠确认。
- `Contrast = 1`。
- `Invert Position = False`。
- 其他参数未显示。

输出/预览：
- `Histogram Scan` 的 2D 预览为黑底上的大量细小白点，中心周围更密，外围较稀疏。
- 这说明该流程正在从前面的噪声/遮罩合成结果中提取离散碎屑点，用作后续细节层或颗粒分布控制。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


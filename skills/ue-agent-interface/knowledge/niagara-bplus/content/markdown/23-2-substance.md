# 23-2-创建-Substance-纹理资源

# 23-2-创建-Substance-纹理资源

## 关键术语

- `Substance`、`网格`、`纹理`、`曲线`、`www.cglgtd.老狗他蓄`、`Niagara`、`Normalized Age`、`生命周期`、`颜色`、`闪电`、`Niagara System`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Alpha`、`Opacity`、`Renderer`

## 分段知识

### 00:00:00-00:02:57 网格、纹理、曲线

- 本段定位：网格、纹理、曲线。
- 知识点：我先保存一次国史学之后 剩下的需要删掉 这里会按正方形比例做 如果在第一部分完成了这个镜的感觉的那种纹理。
- 知识点：这次可以用来铺砖的这个公开感觉的纹理 我也可以再做这个 那么我开始进行吧 这个可能会有点特别 这是一个可以引入多边形的节点 这个曲线值。
- 知识点：我们来进行一下 做一个形状节点 这种磁弹图案 设置大小大约为0.8 这个是名为Splitter的工具 选项是磁针采样挥露节点 感觉有点像。
- 知识点：我们经常使用Splitter circular 现在以圆形排列 可以理解为这种模式的节点 现在和圆形喷件有点不同 这个喷件是这样以网格方式喷洒。
- 知识点：圆形是根据圆形形状排列并 以选软方式进行排列喷洒。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`曲线`。

**关键画面：**

这张图是新一篇教程开头的工程保存画面，表示作者先在 Substance Designer 里为本篇的网格/纹理/曲线练习建立一个新的 `.sbs` 文件。

- 当前界面：
  - Windows 文件保存对话框 `Save Package 'Substance_graph' ?`
  - 保存位置位于 `F:\Substance\Example\Tuto\Part_03`
  - 当前目录下可见已有文件：
    - `Aura_V`
    - `Decal`
  - 文件名输入框内容：`Substance_graph`
  - 文件类型：`Substance 3D Designer files (*.sbs)`
- 右侧 Substance 属性面板：
  - 当前对象为 `Unsaved Package`
  - `Location = Unsaved Package`
- 预览/输出：
  - 底部仍残留上一工程的一张闪电灰度预览，但这不是本篇新图的内容，只能视作软件尚未切换完的旧预览残留

这一步的实际含义是：作者先把本篇教程的工程起点落到 `Part_03` 目录，并以默认 `Substance_graph.sbs` 作为临时文件名开始制作，后续所有节点搭建都会在这个新 package 中进行。
这张图进入 `Lightning_02` 图的实际搭建。当前只放置了一个基础形状节点，用来作为后面网格化/喷洒排列的原始图元。

- 节点定义集：
  - `Polygon 1`
- 连线集：
  - 当前还没有后续节点连接，`Polygon 1` 独立存在
- 设置/参数：
  - 当前选中节点：`polygon_1`
  - `Sides = 3`
  - `Explode = 0`
  - `Triangle Size`
    - `Size X = 1`
    - `Size Y = 1`
  - `Scale = 1`
  - `Auto Scale = True`
  - `Rotation = 0`
  - `Gradient = False`
  - `Gradient Invert = False`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部显示黑底白色等腰三角形，尖端朝左，三角形整体占画幅较大比例

结合本段“做一个形状节点，这次可能会引入多边形节点，大小大约 0.8”的正文，这一步就是先把基础喷洒单元从常见的圆形或简单线段切换成三角形图元，为后续通过 `Splatter Circular` / 网格排列生成更几何化的纹理块做准备。
这张图开始演示 `Splatter` 的“按网格铺撒”模式。当前可见的是一个圆形 `Shape` 输入，被均匀复制成密集的点阵分布，用来说明这类节点和常见环形/圆周排列节点的区别。

- 节点定义集：
  - `Shape`
  - `Splatter Grayscale`
- 连线集：
  - `Shape.output -> Splatter Grayscale.input`
- 设置/参数：
  - 当前选中节点：`splatter`
  - `Pattern Size Width = 100`
  - `Pattern Size Height = 100`
  - `Rotation = 0`
  - `Rotation Variation = 0`
  - `Zoom = 100`
  - `Gain = 1`
  - `Pan X = 0`
  - `Pan Y = 0`
  - `Disorder = 0`
  - `Grid Number` 参数区域已出现，但当前具体值在截图里未完整显示
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 结果是黑底上规则排列的白色圆点阵列，各点大小一致、间距均匀，形成标准网格喷洒效果

这张图的重点不是形状设计，而是说明 `Splatter` 当前工作在“网格方式喷洒”而不是“围绕圆形轨迹分布”。也就是先建立一个规则矩阵分布基线，后面再逐步加入随机尺寸、随机旋转、位移和数量变化。

### 00:03:00-00:05:57 网格

- 本段定位：网格。
- 知识点：给尺寸随机的位置随机 这些部分可以有很多相似之处 因此可以通过这个应用宽度和高度 填充网格的感觉 可能不需要准确的数值 大致可以这样看。
- 知识点：给Rotation Variation到最后 缩放的话可以这样放大 选项并不多 然后把Disorder值设为100 可以增大随机性。
- 知识点：减小Grid Number的话 如果最开始是100 x 100 可以减少Grid的数量 对地调整数量有点难 感觉能调整到磁砖的程度 这个角度也调到最高。
- 知识点：接下来 需要提供大小的变化 下随机 排列 所以 Vivo这个节点导入使用 距离值到某种程度 不要太满的程度 应该可以的 如果生成发现 这种话。
- 知识点：就会产生关于高低的这些边缘值 适当模糊一下用Blur 适当那一下 给一下 然后我们做贴纸时用过的 叫做覆盖器的节点 连接覆盖器后。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。

**关键画面：**

这张图进入 `S02` 的网格微调阶段，开始通过 `Splatter` 的宽高参数改变单个图元的纵横比，让原本的圆点阵列变成更像竖向小砖块/小水滴的形状。

- 节点定义集：
  - `Shape`
  - `Splatter`
- 连线集：
  - `Shape.output -> Splatter.input`
- 设置/参数：
  - 当前选中节点：`splatter`
  - `Pattern Size Width = 67.52`
  - `Pattern Size Height = 100`
  - `Rotation = 0`
  - `Rotation Variation = 0`
  - `Zoom = 100`
  - `Gain = 1`
  - `Pan X = 0`
  - `Pan Y = 0`
  - `Disorder = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 点阵中的每个白色元素都被压窄成竖向椭圆，仍保持规则网格排列，但横向宽度明显小于纵向高度

这一步对应正文里“可以通过宽度和高度来填充网格的感觉”。也就是先不动数量和随机性，只通过 `Pattern Size Width/Height` 把单元形状改成更适合后续做碎片纹理的比例。
这张图继续在同一个 `Splatter` 上增加随机性和稀疏度控制，让原本规则的椭圆点阵变成更像碎砖/碎片堆叠的分布。

- 节点定义集：
  - `Shape`
  - `Splatter`
- 连线集：
  - `Shape.output -> Splatter.input`
- 设置/参数：
  - 当前选中节点：`splatter`
  - `Pattern Size Height = 196.14`
  - `Rotation = 0`
  - `Rotation Variation = 360`
  - `Zoom = 100`
  - `Gain = 1`
  - `Pan X = 0`
  - `Pan Y = 0`
  - `Disorder = 100`
  - `Grid Number = 2`
  - `Disorder Angle = 0`
  - `Disorder Random = False`
  - `Pattern Size = 9`
  - `Size Variation = 0`
  - `Output Level Min = 0`
  - `Output Level Max = 1`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 结果已经不再是细密小点，而是少量大尺寸、彼此重叠的白色椭圆/砖块形状，黑色缝隙在它们之间形成不规则空洞

这一步对应正文中“Rotation Variation 到最后”“Disorder 设为 100”“减小 Grid Number”。也就是通过极高随机旋转、极高位置无序度和很低的网格数量，把规则平铺改造成粗放的碎片式布局，为后面提边缘和做闪电裂纹底图提供更有变化的母形。
这张图把前面生成的碎片布局继续处理成可用的边缘/法线信息。作者没有直接拿 `Splatter` 的黑白图往后用，而是先加斜角，再转法线，再做一次轻度模糊。

- 节点定义集：
  - `Shape`
  - `Splatter`
  - `Bevel`
  - `Normal`
  - `Blur HQ Color`
- 连线集：
  - `Shape.output -> Splatter.input`
  - `Splatter.output -> Bevel.input`
  - `Bevel.output -> Normal.input`
  - `Normal.output -> Blur HQ Color.input`
- 设置/参数：
  - 当前选中节点：`blur_hq`
  - `Intensity = 0.3`
  - `Quality = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (RGBA, 16bpc)`
  - 底部显示一张整体偏蓝紫色的法线贴图视图，说明 `Splatter` 形成的块状轮廓已经被转成表面方向信息，并经过轻度平滑

这一步对应正文中“模糊一下”“做贴纸时用过的那些处理”的思路。实质上是先从黑白碎片生成柔和斜角，再把它变成法线贴图，为后续通过边缘值提取、反相或覆盖混合生成更自然的闪电裂纹/空隙纹理打基础。

### 00:05:59-00:08:57 关键流程 03

- 本段定位：关键流程 03。
- 知识点：图纸适当提高 这样就能得到边缘 得到了这个 只要通过直方图扫描得到边缘 有点像SVR可以吗 是的 它跟不上 这个 这个 斜角角不太合适的。
- 知识点：这部分是这样看的 Vivo也一起换选项 可以看一下 这条线似乎不太合适 形状现在用这个线似乎不行 这里这样更几何一些 伸展出去用的这条线可能更好。
- 知识点：用反向的就会更好 怎么容易上讲这些线这样重叠在一起展示 闪电的感觉可以适当带来一点 反转后这样换成白色的线就可以带过来 是的 那这样换成白色的线就可以带过来。
- 知识点：那这样换成白色线可以带过来 方形变换节点 方形变换节点和方形变换节点 和带一个品牌节点 带一个品牌节点 再加一张图像用的话会更好 现在用一张图像感觉有点简单。
- 知识点：180度转过来写 现在直接180度转过来 现在直接180度转过来写可能会更好 现在用一张图像做衰退 模式种子适当不同。
- 核对对象：`闪电`。

**关键画面：**

这张图进入 `S03` 的关键流程 03，开始把前面做出的碎片法线结构转成可直接用于闪电线稿的边缘图。当前可见链路是在法线模糊之后接一张 `Curvature` 来提轮廓。

- 节点定义集：
  - `Splatter`
  - `Bevel`
  - `Normal`
  - `Blur HQ Color`
  - `Curvature`
- 连线集：
  - `Splatter.output -> Bevel.input`
  - `Bevel.output -> Normal.input`
  - `Normal.output -> Blur HQ Color.input`
  - `Blur HQ Color.output -> Curvature.input`
- 设置/参数：
  - 当前选中节点：`curvature`
  - `Intensity = 6.27`
  - `Normal Format = DirectX`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部结果是一张浅灰底上带细线裂纹的边缘图，原本块状碎片的接缝被提取成细而浅的轮廓

这一步对应正文里“把图适当提高，这样就能得到边缘”。也就是通过 `Curvature` 从平滑法线里抽出接缝和边缘信息，把原本的碎块布局转换成接近闪电裂纹底图的细线结构。
这张图继续沿着上一张的边缘提取链往后走，在 `Curvature` 后面新增了一张 `Histogram Scan`，准备把灰度边缘进一步收紧成更明确的黑白线稿。

- 节点定义集：
  - `Splatter`
  - `Bevel`
  - `Normal`
  - `Blur HQ Color`
  - `Curvature`
  - `Histogram Scan`
- 连线集：
  - `Splatter -> Bevel -> Normal -> Blur HQ Color -> Curvature -> Histogram Scan`
- 设置/参数：
  - 当前选中节点仍是 `curvature`
  - `Intensity = 6.27`
  - `Normal Format = DirectX`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 当前 `Curvature` 结果仍表现为浅灰底上的细微几何接缝；右侧新接入的 `Histogram Scan` 节点预览缩略图已经显示出更深背景上的细线轮廓，说明它在把这些接缝向高对比线稿推进

结合正文“只要通过直方图扫描得到边缘”“这里这样更几何一些”，这一步的目的就是利用 `Histogram Scan` 从 `Curvature` 的柔和边缘里筛出更硬、更几何化的线条，让图案更接近可用的闪电裂纹母线。
这张图把筛出来的几何边缘进一步改造成更像闪电的重叠线网。当前链路是在 `Histogram Scan` 之后先做反相，再复制一份经 `Transformation 2D` 处理后与原图叠加。

- 节点定义集：
  - `Normal`
  - `Blur HQ Color`
  - `Curvature`
  - `Histogram Scan`
  - `Invert Grayscale`
  - `Transformation 2D`
  - `Blend`
- 连线集：
  - `Normal -> Blur HQ Color -> Curvature -> Histogram Scan -> Invert Grayscale`
  - `Invert Grayscale.output` 一路直接接入 `Blend`
  - `Invert Grayscale.output` 另一路先接 `Transformation 2D`，再接入同一个 `Blend`
- 设置/参数：
  - 当前选中节点：`Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部结果是黑底上的细白裂纹网，线条比前一步更清晰，且部分边缘出现叠合、交叉和更复杂的闪电式走向

这一步对应正文“用反向会更好”“这些线这样重叠在一起展示，闪电的感觉可以适当带来一点”。本质上是把提取出的裂缝线先反成白线，再通过复制叠加制造重复、偏移和重合，从纯几何裂纹推进到更接近闪电纹理的线网结构。

### 00:09:00-00:11:53 关键流程 04

- 本段定位：关键流程 04。
- 知识点：再做一个新模式来写 可能会更有质量 现在用简单的方式来做 我来试试看 然后Rodiflash和4DL 白换后看亮的部分和不亮的部分 我也去看一下。
- 知识点：这样拿来用更好 用等级 如果看不清又不行 这样做 用自动等级调一下亮的部分 不亮的部分精确到0-1的等级调 这里现在 方向性扭曲 现在可以试试之前的那种。
- 知识点：各置的扭曲那种感觉 如果能抓到就更好了 我给了大约20的强度 可以给的更强 这方面建议可以改变一下数值 看看效果 需要再改一个角度看看 就这种感觉。
- 知识点：再多做一层 如果太强可能会感觉太闪电了 就这样 不过用这个感觉有点遗憾 有多方向的 是的就是这个。
- 核对对象：`闪电`。

**关键画面：**

这张图进入 `S04`，仍以前一段得到的裂纹白线为基础，但开始尝试“再叠一层”来提升闪电感。当前结构是在 `Invert Grayscale` 之后分两路，一路直接输出，一路经过 `Transformation 2D` 后与原图 `Blend` 叠加。

- 节点定义集：
  - `Normal`
  - `Blur HQ Color`
  - `Curvature`
  - `Histogram Scan`
  - `Invert Grayscale`
  - `Transformation 2D`
  - `Blend`
- 连线集：
  - `Normal -> Blur HQ Color -> Curvature -> Histogram Scan -> Invert Grayscale`
  - `Invert Grayscale.output` 一路直接接入 `Blend`
  - `Invert Grayscale.output` 另一路接 `Transformation 2D`，再接入 `Blend`
- 设置/参数：
  - 当前选中节点：`Transformation 2D`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部结果是黑底白线裂纹图，局部已出现更亮、更粗的重叠线段，说明两份线网已经开始叠加出主次层次

这一步对应正文“再多做一层”“现在用简单的方式来做”。它不是重新生成新的裂纹，而是先复制当前线稿，再通过轻微变换后与原图混合，快速得到更像闪电分叉和复线的视觉效果。
这张图开始把纯几何裂纹线进一步扭曲成更像闪电的走势。当前结构是在已有线稿 `Blend` 的基础上，再引入一张噪声 `Levels` 结果，经过 `Auto Levels` 整理后送进 `Directional Warp`。

- 节点定义集：
  - 上方已有线稿支路 `Blend`
  - 噪声支路：
    - 左侧源节点（未完整入镜）
    - `Levels`
  - 汇合与处理：
    - 中间 `Blend`
    - `Auto Levels`
    - `Directional Warp`
    - 右侧 `output`
- 连线集：
  - 上方线稿 `Blend.output -> 中间 Blend`
  - 下方噪声 `Levels.output -> 中间 Blend`
  - `中间 Blend.output -> Auto Levels.input`
  - `Auto Levels.output -> Directional Warp.input`
  - `Directional Warp.output -> output`
- 设置/参数：
  - 当前选中节点：`Directional Warp`
  - `Intensity = 10`
  - `Warp Angle = 0 Degrees`
  - `Turns = 0`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部结果仍是黑底白裂纹，但线条开始出现轻微偏折、拐点和局部粗细变化，比前一张的规则几何分块更接近闪电纹理

这一步对应正文“用等级”“自动等级调一下”“方向性扭曲可以试试之前那种”。也就是先把噪声与线稿混成一张更有亮暗层次的图，再用较低强度的 `Directional Warp` 去打破过于板正的几何感。
这张图把上一张的单次扭曲继续推进成双层扭曲结构。作者在第一次 `Directional Warp` 后又接了一张新的 `Directional Warp`，并明确用 `Voronoi Fractal` 作为第二层扭曲的驱动图。

- 节点定义集：
  - 上游线稿合成链：
    - 左侧已有 `Blend`
    - `Auto Levels`
  - 扭曲链：
    - 第一张 `Directional Warp`
    - 第二张 `Directional Warp`
  - 驱动图：
    - `Voronoi Fractal`
  - 右侧 `output`
- 连线集：
  - `Blend.output -> Auto Levels.input`
  - `Auto Levels.output -> 第一张 Directional Warp.input`
  - `第一张 Directional Warp.output -> 第二张 Directional Warp.input`
  - `Voronoi Fractal.output -> 第一张 Directional Warp` 的驱动输入
  - `Voronoi Fractal.output -> 第二张 Directional Warp` 的驱动输入
  - 第二张 `Directional Warp.output -> output`
- 设置/参数：
  - 当前选中节点：第二张 `Directional Warp`
  - `Intensity = 20`
  - `Warp Angle = -94.9 Degrees`
  - `Turns = -0.26361111`
  - `Input Filtering Mode = Bilinear`
  - `Intensity Map Offset = 0`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部结果中的白线裂纹比上一张更弯、更碎，局部出现更明显的闪电式折线和分叉，几何板块感被进一步削弱

这一步对应正文里“我给了大约 20 的强度”“再改一个角度看看”“再多做一层”。本质上是通过第二次、且角度更陡的 `Directional Warp`，把原始裂纹线从规则裂缝拉向更自然、更像闪电通道的弯折形态。

### 00:12:06-00:14:57 纹理

- 本段定位：纹理。
- 知识点：这种话在这些空隙里 是个这种方式 这样就好了 这里可以看作是增加了一些辅助线 这里可以看作是增加一些辅助线 通过土地计算到这里的 把辅助上产生了多条线合在一起用。
- 知识点：能找到更自然的感觉 它会看到更自然的线条 宋宝华艺商说 制作列文纹理的方法 可能也有点相似 这种模式的制作其实 总是有一些关联性 也有相似性。
- 知识点：用这种方法也不错 然后 适当调整一下色调也可以 最后要点就是现在 创造这种模式 最终是利用这个空白 把空白的模式提取出来覆盖 感觉是把这个边缘保留下来。
- 知识点：到这里的圆端 在这个圆端 尝试换个形状 或者创造与这个模式相似的模式 再试着代入其他东西 那么你也可能发现 更好的制作自己酱料的方法 需要找到更好的形状 在一起提供给你。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这张图进入 `S05` 纹理段，在线稿已经经过两次 `Directional Warp` 的基础上，再叠加一张 `Multi Directional Warp Grayscale`，目的是把过于单一方向的扭曲改成更自然的多方向扰动。

- 节点定义集：
  - 上游线稿链：
    - `Blend`
    - `Auto Levels`
    - `Directional Warp` x2
  - 驱动图：
    - `Voronoi Fractal` x2
  - 新增节点：
    - `Multi Directional Warp Grayscale`
  - 右侧 `output`
- 连线集：
  - `Blend.output -> Auto Levels -> Directional Warp -> Directional Warp`
  - 第二张 `Directional Warp.output -> Multi Directional Warp Grayscale.input`
  - 两张 `Voronoi Fractal.output` 都接入 `Multi Directional Warp Grayscale` 的驱动输入
- 设置/参数：
  - 当前选中节点：`multi_directional_warp_grayscale`
  - `Intensity = 20`
  - `Warp Angle = 0`
  - `Mode = Average`
  - `Directions = 4`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 黑底上的白线裂纹被进一步揉散，边缘更柔、更有抖动感，局部线段不再只沿单一方向折转

这一步对应正文“如果能抓到那种扭曲感觉就更好了”“不过用这个感觉有点遗憾，有多方向的”。核心就是从单轴方向扭曲升级到多方向平均扭曲，让裂纹线更像自然纹理而不是机械变形后的几何裂缝。
这张图继续整理 `S05` 的纹理链。当前可见是在第二次 `Directional Warp` 与 `Multi Directional Warp Grayscale` 之后，再通过一张 `Blend` 把结果汇合，准备送进 `Levels` 做最终亮暗收缩。

- 节点定义集：
  - `Directional Warp` x2
  - `Multi Directional Warp Grayscale`
  - `Voronoi Fractal`
  - `Blend`
  - `Levels`
  - 右侧 `output`
- 连线集：
  - 第二张 `Directional Warp.output -> Blend`
  - `Multi Directional Warp Grayscale.output -> Blend`
  - `Voronoi Fractal.output -> Multi Directional Warp Grayscale` 的驱动输入
  - `Blend.output -> Levels.input`
  - `Levels.output -> output`
- 设置/参数：
  - 当前选中节点：`Levels`
  - 右侧属性面板处于 `Levels Histogram` 调整界面，当前截图未显示具体数值
- 输出/预览：
  - 预览为 `1024 x 1024 (RGBA, 8bpc)`
  - 底部当前显示为纯黑，说明此刻还处在 `Levels` 调整前或参数尚未拉开可见范围，尚不能从这一帧确认最终线条结果

这一步的关键信息不是结果画面，而是结构：作者已经把“单向扭曲结果”和“多方向扭曲结果”汇合到同一张 `Blend`，随后用 `Levels` 去重新定义亮部与暗部范围，以便从复杂纹理里筛出更可控的闪电线条。
这张图把 `S05` 的整条纹理生成链完整摊开，说明作者此时已经把“原始碎片生成”到“多层扭曲后再压亮暗”的全过程串起来，并把它作为一套可替换形状、可继续调参的方法来使用。

- 节点定义集：
  - 前段碎片生成链：
    - `Splatter`
    - `Voronoi Fractal -> Levels`
  - 中段汇合与线稿处理：
    - `Blend`
    - `Auto Levels`
    - `Directional Warp` x2
  - 后段自然化处理：
    - `Multi Directional Warp Grayscale`
    - `Blend`
    - `Levels`
  - 驱动图：
    - `Voronoi Fractal` x2
- 连线集：
  - 左侧基础碎片/线稿结果先与一张 `Voronoi Fractal -> Levels` 支路通过 `Blend` 汇合
  - 汇合结果经 `Auto Levels -> Directional Warp -> Directional Warp`
  - 第二次 `Directional Warp` 输出进入 `Multi Directional Warp Grayscale`
  - 下方另一张 `Voronoi Fractal` 继续作为多方向扭曲驱动
  - 多方向扭曲结果再进入 `Blend -> Levels` 完成收尾
- 设置/参数：
  - 右侧当前显示的是早期 `splatter` 节点属性，并非当前末端节点参数
  - 从截图可确认该 `splatter` 仍保持：
    - `Pattern Size Width = 80.39`
    - `Pattern Size Height = 196.14`
    - `Rotation = 0`
    - `Rotation Variation = 360`
    - `Zoom = 100`
    - `Gain = 1`
    - `Pan X = 0`
    - `Pan Y = 0`
    - `Disorder = 100`
- 输出/预览：
  - 底部当前预览显示的是 `Splatter` 产生的大块白色碎片布局，而不是链末最终线稿
  - 因此这一帧更适合作为“流程总览”而不是最终结果截图

这张图的核心信息是方法论：作者把“形状喷洒 -> 法线/边缘提取 -> 复制叠层 -> 单向扭曲 -> 多向扭曲 -> Levels 收尾”组织成了一条完整流程，并明确指出后续可以替换更好的基础形状，从而做出不同但同类的闪电纹理。

### 00:15:13-00:16:53 纹理

- 本段定位：纹理。
- 知识点：首先面已经来了 不会特别麻烦 所有的伤害都挺家庭化的 真是个傻瓜 然后 适当多带一点也没问题 我试着完成了这种合成 图案可能会稍有不同 我觉得制作的纹理就是这样。
- 知识点：需要给你更好的形状 现在只是告诉你制作这种图案的方法 只要知道这种方式 关于温度和纹理 差不多这种形状都能做出来 那么这次就这样 下次例子见。
- 知识点：在下一个例子中制作了纹理资源 下次将讨论和专利中的物理模拟 会做一个额外的语言 还要一起配置向量场来进行 那么这次就到这里 谢谢。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这张图进入 `S06` 的最后收尾阶段，开始把已经做好的裂纹线纹理再处理成更适合覆盖与留边的版本。当前链路是在前面的扭曲线稿之后，再走一条 `Blur HQ Grayscale -> Levels -> Blend` 的后处理支路。

- 节点定义集：
  - 上游线稿链末端：
    - `Directional Warp`
    - `Multi Directional Warp Grayscale`
    - `Blend`
    - `Levels`
  - 新增后处理链：
    - `Blur HQ Grayscale`
    - `Levels`
    - `Blend`
- 连线集：
  - 前一段的 `Levels.output -> Blur HQ Grayscale.input`
  - `Blur HQ Grayscale.output -> Levels.input`
  - 新 `Levels.output -> 右侧 Blend.input`
  - 同时原始线稿也保留一路接入右侧 `Blend`
- 设置/参数：
  - 当前选中节点：最右侧 `Blend`
  - `Blending Mode = Copy`
  - `Opacity = 1`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 底部当前为纯黑，说明此刻还处在后处理搭线或参数试探阶段，尚未拉出最终可见结果

这一步对应正文“利用这个空白，把空白模式提取出来覆盖，感觉是把边缘保留下来”。可以理解为：作者先从当前纹理里做一份模糊/压阶版本，再通过新的 `Blend` 去控制哪些线边被保留、哪些内部区域被覆盖，从而把纹理组织得更适合后续使用。
这张图展示了 `S06` 的成品收尾状态。前面经过模糊、压阶和混合后的纹理结果已经同时送到 `output` 与 `Gradient Map`，用于直接观察最终的黑白裂纹纹理。

- 节点定义集：
  - 左侧原始结果：
    - `Blend`
    - `Levels`
  - 后处理支路：
    - `Blur HQ Grayscale`
    - `Levels`
    - `Blend`
  - 输出：
    - `output`
    - `Gradient Map`
- 连线集：
  - 左侧 `Levels.output` 一路直接进入最终 `Blend`
  - 同时该输出再进入 `Blur HQ Grayscale -> Levels`，其结果也接入最终 `Blend`
  - 最终 `Blend.output` 同时送入上方 `output` 与下方 `Gradient Map`
- 设置/参数：
  - 当前选中节点：`Gradient Map`
  - `Color Mode = Color`
  - `Gradient Addressing = Repeat`
  - 可见渐变仍为默认黑白线性渐变
  - `Output Size = 512 px x 512 px`
- 输出/预览：
  - 预览为 `512 x 512 (RGBA, 16bpc)`
  - 成品是黑底上分布均匀的白色裂纹/闪电纹理，线条边缘柔和、亮部集中在裂缝主干，整体已经是一张可直接使用的平铺纹理样式

这一步说明作者已经把前面的复杂节点链收敛成最终可用纹理：通过“原始线稿 + 模糊后增强版”两路合成，再交给 `Gradient Map` 做最终观察，得到一张分辨率为 `512x512` 的完整黑白裂纹贴图。
这张图是 `p36` 这一整套纹理制作流程的最终工程总览。它把从 `Auto Levels`、双层 `Directional Warp`、`Multi Directional Warp Grayscale` 到后面的 `Blur HQ Grayscale -> Levels -> Blend -> Gradient Map` 全部串联在同一张 `Lightning_02` 图中，并给出最终成品预览。

- 节点定义集：
  - 前段：
    - `Auto Levels`
    - `Directional Warp` x2
    - `Voronoi Fractal` x2
    - `Multi Directional Warp Grayscale`
  - 中段：
    - `Blend`
    - `Levels`
  - 后段：
    - `Blur HQ Grayscale`
    - `Levels`
    - `Blend`
    - `output`
    - `Gradient Map`
- 连线集：
  - 前段线稿先经过双层单向扭曲，再经过多方向扭曲
  - 扭曲结果经 `Blend -> Levels` 形成主纹理
  - 主纹理一方面直接进入最终 `Blend`
  - 另一方面走 `Blur HQ Grayscale -> Levels` 支路后再回到最终 `Blend`
  - 最终 `Blend.output` 同时送入 `output` 与 `Gradient Map`
- 设置/参数：
  - 当前右侧属性面板显示的是整个 `Lightning_02`
  - `Identifier = Lightning_02`
  - `Package = F:/Substance/Example/Tuto/Part_03/Lightning.sbs`
  - `Exposed in SBSAR = Yes`
- 输出/预览：
  - 底部预览为 `512 x 512 (RGBA, 16bpc)`
  - 最终结果是一张黑底白色裂纹闪电纹理：线条边缘柔和、主干亮度更强、空白区域被压得更干净，已经达到可作为成品资源使用的状态

这张图的意义是交付态确认。它证明本篇 `Lightning_02` 不只是单个节点实验，而是已经整理成完整的 Substance 图资产，并以 `512x512` 的最终裂纹贴图作为输出结果暴露到工程中。

## 补充视觉证据

### S01 00:02:22

这张补充截图对应 `S01 00:02:22`，补足了 `Splatter` 处在最初网格喷洒状态时的基础参数。它和正文主图相比，更清楚地确认了这一阶段几乎还没有任何随机扰动。

- 节点定义集：
  - `Shape`
  - `Splatter`
- 连线集：
  - `Shape.output -> Splatter.input`
- 设置/参数：
  - 当前选中节点：`splatter`
  - `Pattern Size Width = 100`
  - `Pattern Size Height = 100`
  - `Rotation = 0`
  - `Rotation Variation = 0`
  - `Zoom = 100`
  - `Gain = 1`
  - `Pan X = 0`
  - `Pan Y = 0`
  - `Disorder = 0`
  - `Grid Number` 参数区域已出现，但数值在当前截图中未完整显示
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 结果是黑底上的规则白色圆点阵列，横纵间距一致，没有旋转、错位或大小变化

这张补图的价值在于把 `S01` 的起始状态钉死：作者确实是从完全规则的网格喷洒开始，而不是一开始就带随机旋转和随机位移。后续所有“更像瓷砖/碎块”的变化，都是在这个基线之上逐步叠加出来的。

### S02 00:04:59

这张补充截图对应 `S02 00:04:59`，补足了作者准备把 `Splatter` 结果送入 `Bevel` 前的完整参数状态。它比正文截图更明确地记录了随机旋转、无序度、网格数量和尺寸变化。

- 节点定义集：
  - `Shape`
  - `Splatter`
  - 正在搜索的下一节点：`Bevel`
- 连线集：
  - `Shape.output -> Splatter.input`
  - 下一步准备从 `Splatter` 输出接到 `Bevel`
- 设置/参数：
  - 当前选中节点：`splatter`
  - `Rotation Variation = 360`
  - `Zoom = 100`
  - `Gain = 1`
  - `Pan X = 0`
  - `Pan Y = 0`
  - `Disorder = 100`
  - `Grid Number = 2`
  - `Disorder Angle = 360`
  - `Disorder Random = False`
  - `Pattern Size = 9`
  - `Size Variation = 28.94`
  - `Image Input Filtering = Bilinear + Mipmaps`
  - `Output Level Min = 0`
  - `Output Level Max = 1`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 当前结果是少量大块、强随机旋转且彼此重叠的白色碎片布局，已经完全脱离规则点阵

这张补图的重要性在于，它证明 `S02` 后期除了高旋转和高无序度，还加入了明显的 `Size Variation`。也就是说，这些碎片并不是同尺寸复制，而是通过随机尺寸变化进一步打破机械感，然后才接 `Bevel` 去做边缘与法线处理。

### S03 00:08:08

这张补充截图对应 `S03 00:08:08`，补足了 `Invert Grayscale` 这一步的实际参数和接法，并且能看到作者正准备继续添加 `Transformation 2D`。

- 节点定义集：
  - `Normal`
  - `Blur HQ Color`
  - `Curvature`
  - `Histogram Scan`
  - `Invert Grayscale`
  - 正在搜索的下一节点：`Transformation 2D`
- 连线集：
  - `Normal -> Blur HQ Color -> Curvature -> Histogram Scan -> Invert Grayscale`
  - 下一步准备从 `Invert Grayscale.output` 接到 `Transformation 2D`
- 设置/参数：
  - 当前选中节点：`invert_grayscale`
  - `Invert = True`
- 输出/预览：
  - 预览为 `1024 x 1024 (Grayscale, 16bpc)`
  - 当前结果已经是黑底白线裂纹图，说明前一步的灰底暗线在这里被正式反成了可直接拿来做闪电的白色线网

这张补图把正文里“反转后换成白色的线就可以带过来”直接坐实了：真正起作用的就是这一张 `Invert Grayscale`，它把 `Histogram Scan` 输出的边缘关系反相成黑底白线，然后再往后复制、变换和叠加出更复杂的闪电感。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


# 08 Substance Designer For VFX Pt2

# 08 Substance Designer For VFX Pt2

## 关键术语

- `Multiply`、`Substance`、`Substance Designer`、`Curve`、`尝试一下。现在我们将尝试创建拖尾示例。我们按F2键，然后可以调用`、`保留2048，2048。我们有一个普通的拖尾，这些是所有的参数。它们可以`、`Perlin Noise`、`Niagara`、`Normalized Age`、`Noise`、`生命周期`、`颜色`、`曲线`、`拖尾`、`Niagara System`、`Emitter`、`Particle`、`Spawn`

## 分段知识

### 00:00:06-00:04:58 关键流程 01

- 本段定位：关键流程 01。
- 知识点：我们完成了创建Flare,你自己可以改变它, 改变它,實驗它。
- 知识点：现在需要尝试创建Trail例子,我们按F2, 然后可以叫Flare。
- 知识点：还有 Extra Less,可以叫你創作的。
- 知识点：我们叫它在这个瓶子里,需要创建另一个, 我们叫它Trail01。
- 知识点：我们去Explorer,然后这里我们有Flare和Trail。
- 知识点：如果你想把它当作一个圖像,你按下这一个, 然后这里有剩下的剩下的, 你把它叫成了什么,然后它是剩下的。
- 知识点：也有一个出口,为什么需要它? 如果你想要減少最後的大小, 现在是2048x2048, 可以按Transform前的Output, 这基本上是没有用的。

**关键画面：**

这张图展示教程从上一节的星体 flare 图继续出发，准备改造成 trail 示例。当前选中的是右侧一个 `Blend` 节点，它把上下两条经过 `Switch Grayscale` 的旋涡亮纹分支，与左侧主星芒分支合成为更复杂的发光核心。

节点定义集：
- 左侧两个 `Blend`
  - 第一层 `Blend` 先把基础星芒与下方 `Shape` 的圆形亮斑叠加。
  - 第二层 `Blend` 在此基础上继续生成中间主分支结果。
- 下方 `Shape`
  - 预览为柔和白色圆点。
  - 作用是给中心区域补充实体亮度。
- 上方亮斑分支
  - 一个高亮圆形/环形结果进入上方 `Switch Grayscale`。
- 下方旋涡分支
  - `Swirl Grayscale` 结果进入下方 `Switch Grayscale`。
- 上下两个 `Switch Grayscale`
  - 都输出旋涡状亮纹或圆环亮斑的可切换结果。
- 当前选中 `Blend`
  - 接收左侧主分支、上方 `Switch Grayscale` 输出和下方 `Switch Grayscale` 输出。
  - 预览是一枚中心极亮、外围包裹多圈旋涡亮线的发光核心。

连线集：
- 基础星芒分支 -> 左侧第一个 `Blend`
- `Shape` -> 左侧第一个 `Blend`
- 左侧第一个 `Blend` -> 左侧第二个 `Blend`
- 左侧第二个 `Blend` 输出一分为三：
  - 一路直接进入当前选中 `Blend`
  - 一路进入上方亮斑分支，再送到上方 `Switch Grayscale`
  - 一路进入下方 `Swirl Grayscale`，再送到下方 `Switch Grayscale`
- 上方 `Switch Grayscale` -> 当前选中 `Blend`
- 下方 `Switch Grayscale` -> 当前选中 `Blend`

设置/参数：
- 右侧属性面板为 `Blend - PROPERTIES`。
- 可可靠辨认：
  - `Opacity = 1`
  - `Blending Mode = Max (Lighten)`
  - `Alpha Blending = Use Source Alpha`
  - `Cropping Area.Left = 0`
  - `Cropping Area.Right = 1`
  - `Cropping Area.Top = 0`
  - `Cropping Area.Bottom = 1`

输出/预览：
- 左侧 `Blend - 2D VIEW` 预览是一枚中心高亮近乎纯白、外围缠绕多圈细亮线的发光核心。
- 这一步的意义是保留既有 flare 纹理结构，同时把更多旋涡层叠加进去，为后续改造成拖尾纹理做准备。
这张图展示 flare 图的最终输出端。左侧最后一个 `Blend` 节点直接连接到右侧 `output` 节点，说明当前这张 Substance 图已经形成一张可直接导出的基础拖尾/flare 纹理，并保持 `2048x2048` 分辨率输出。

节点定义集：
- 最终 `Blend`
  - 预览是一枚中心极亮、外围有旋涡缠绕线条的发光纹理。
  - 作用是汇总当前所有亮斑与旋涡分支的最终结果。
- `output`
  - 当前图表的输出节点。
  - 节点缩略图与最终 `Blend` 结果一致，表示输出端直接继承该纹理。

连线集：
- 最终 `Blend` 的输出直接连接到 `output` 节点。
- 左侧另有上、下两路输入继续汇入最终 `Blend`，但源节点未在当前截图完整显示。

设置/参数：
- 当前右侧属性面板为 `output - PROPERTIES`。
- 可可靠辨认：
  - `Identifier = Flare`
  - `Integration Attributes.Format = Default Format`
  - `Mipmaps = Full pyramid`
- 其余 Usage/Metadata 项在截图中未显示具体填写内容。

输出/预览：
- 左侧 `Output - 2D VIEW` 显示最终纹理：中心白亮饱和，外围叠有多层细线圆弧与少量尖刺辉光。
- 这一步说明教程先保留现有 flare 纹理作为完整输出，再在后续步骤基础上继续复制或改造成 trail 版本。
这张图展示新建的 `Trail_01` 图里，用 `Perlin Noise` 生成拖尾边缘轮廓的起始步骤。当前选中的是 `Cross Section`，它把一张灰度噪声图切成沿单轴读取的截面曲线，得到上下起伏不规则的白色轮廓。

节点定义集：
- `Perlin Noise`
  - 预览为灰度噪声块。
  - 作用是提供随机起伏的基础噪声。
- `Cross Section`
  - 当前选中节点。
  - 作用是从输入图像中按指定轴抽取一条截面曲线，并把曲线上方/下方填充成可继续使用的遮罩形状。
  - 预览是一条顶部凹凸不平、底部填满为白色的轮廓图。

连线集：
- `Perlin Noise` 的输出直接连接到 `Cross Section` 的输入。

设置/参数：
- 右侧属性面板为 `cross_section - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Cross section coordinate = 0.5`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 1`
  - `Height offset = 0`
  - `Drawing Style = Solid`
  - `Smooth / Polygonal = Smooth`
- 下方还能看到前景色为白、背景色为黑的颜色设置区域，但具体色值除黑白外不需要额外推断。

输出/预览：
- 左侧 `Cross_section - 2D VIEW` 显示一块黑底白形遮罩，顶部轮廓随噪声高低起伏，形成不规则边缘。
- 这一步的意义是把二维噪声转换成适合拖尾截面的单向轮廓，为后续拉伸、曲线和颜色控制做准备。

### 00:04:58-00:09:39 关键流程 02

- 本段定位：关键流程 02。
- 知识点：那它是什么意思? 它在哪里使用? 我们按0.5。
- 知识点：可以在这里控制高度, 我们把它放在1。
- 知识点：可以移动它的Offset, 可以使用Smooth来滑動它, 可以把它变成这樣。
- 知识点：再加多个部分, 越多它变成, 越順滑。
- 知识点：可以控制它的颜色, 以及它的背景颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图继续讲解 `Cross Section` 的工作方式。当前仍是 `Perlin Noise` 输入 `Cross Section`，但这次开启了辅助显示，左侧预览能同时看到原始噪声与截线位置，右侧结果里也能看到被切出的轮廓及右下角的小型 helper 预览。

节点定义集：
- `Perlin Noise`
  - 提供灰度噪声输入。
- `Cross Section`
  - 当前选中节点。
  - 根据一条横向截线从输入图中读取轮廓，并生成顶部起伏、底部填充的白色截面遮罩。
  - 节点预览右下角显示了一个小型噪声/截线辅助图，表明 helper 已启用。

连线集：
- `Perlin Noise` -> `Cross Section`

设置/参数：
- 右侧属性面板为 `cross_section - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Cross section coordinate = 0.54`
  - `Section axis = X`
  - `Show Helper = True`
  - `Height scale = 1`
  - `Height offset = 0`
  - `Drawing Style = Solid`
  - `Smooth / Polygonal = Smooth`
- 颜色设置仍为白色前景、黑色背景。

输出/预览：
- 左侧 `Cross_section - 2D VIEW` 上半部是原始噪声，下半部是沿当前截线位置得到的截面结果，中间有一条水平辅助线。
- 右侧节点预览显示不规则白色山峰状轮廓，说明教程正在用 helper 解释“截线位置如何影响拖尾轮廓”。
这张图展示 `Cross Section` 从“填充面”切换到“线条轮廓”绘制模式后的结果。`Perlin Noise` 仍然作为输入，但输出不再是实心白块，而是一条平滑发光的波形线，用来构成拖尾边缘路径。

节点定义集：
- `Perlin Noise`
  - 提供灰度噪声输入。
- `Cross Section`
  - 当前选中节点。
  - 输出改为一条沿噪声截面生成的连续亮线，而不是上下填充遮罩。

连线集：
- `Perlin Noise` -> `Cross Section`

设置/参数：
- 右侧属性面板为 `cross_section - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Cross section coordinate = 0.5`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 1`
  - `Height offset = 0`
  - `Drawing style = Line`
  - `Segment amount = 101`
  - `Line thickness = 0.1`
  - `Line style = Smooth`
- 其余下方参数未在截图中完整显示。

输出/预览：
- 左侧 `Cross_section - 2D VIEW` 现在是一条白色发光曲线，沿横向上下起伏，边缘柔和发亮。
- 这一步说明教程不再只要实心截面，而是要一条可作为拖尾轮廓骨架的平滑噪声曲线。
这张图展示把 `Cross Section` 生成的亮线轮廓送入 `Histogram Scan` 进行二次提取。当前选中 `Histogram Scan`，它把原本较宽的发光曲线收缩成更窄、更清晰的亮弧，用于后续形成更利落的拖尾边界。

节点定义集：
- `Cross Section`
  - 左下节点。
  - 预览是一条较宽的白色发光波形带。
- `Histogram Scan`
  - 当前选中节点。
  - 作用是根据位置/对比度从输入灰度图中提取更精确的亮度区间，得到更窄的轮廓线。
  - 节点缩略图显示一条更细的白色波线。
- 上方后续节点
  - 接收 `Histogram Scan` 输出后继续处理，缩略图中可见更柔和的弯曲亮线。

连线集：
- `Cross Section` -> `Histogram Scan`
- `Histogram Scan` 输出一分为二：
  - 一路向上连接到上方后续节点
  - 一路向右连接到另一条后续处理链

设置/参数：
- 右侧属性面板为 `histogram_scan - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Position = 0.01`
  - `Invert Position = False`
- `Contrast` 参数项可见，但截图中未清晰显示具体数值。

输出/预览：
- 左侧 `Histogram_scan - 2D VIEW` 预览是一条宽度更均匀、边缘更利落的白色发光弧线。
- 这一步的意义是从 `Cross Section` 的宽亮带中筛出更合适的亮度范围，得到更适合作为拖尾主轮廓的窄线结果。

### 00:09:39-00:14:29 关键流程 03

- 本段定位：关键流程 03。
- 知识点：轉过来, 然后它会改变我们的圖像。
- 知识点：这是什么原因? 我现在再次把它轉过来, 然后再次复制这些圖像。
- 知识点：如果我们想, 例如說, 我们想要创建一些不同的变化, 可以直接转换在交叉部分。
- 知识点：需要把它轉过来, 让它混合得比較好。
- 知识点：现在可以做什么? 如何可以得到很有趣的價值? 請記得, 我们想要轉向X和Y, 但我们想要轉向XC。

**关键画面：**

这张图展示拖尾轮廓链已经被复制成两条记录，并把其中一条继续做细化处理。当前左侧预览是 `Cross Section` 的宽亮带结果；主图中上方链从 `Perlin Noise` 经 `Cross Section`、`Histogram Scan`、`Blur HQ Grayscale`、`Auto Levels` 后送入右侧 `Blend`，下方则保留另一条 `Perlin Noise -> Cross Section` 记录作为并行分支。

节点定义集：
- 上方 `Perlin Noise`
  - 提供上方主链的噪声输入。
- 上方 `Cross Section`
  - 预览是较宽的白色波形亮带。
- `Histogram Scan`
  - 把宽亮带进一步抽取成更清晰的波线。
- `Blur HQ Grayscale`
  - 对线条做高质量模糊，得到更柔和的轮廓。
- `Auto Levels`
  - 拉伸对比度，让模糊后的波线重新变得更清晰。
- 右侧 `Blend`
  - 接收上方处理链结果以及另一条并行输入，用于后续叠加。
- 下方 `Perlin Noise -> Cross Section`
  - 复制出来的第二条记录，当前停在 `Cross Section` 结果处，右侧可见一个 `output` 标记。

连线集：
- 上方 `Perlin Noise` -> 上方 `Cross Section`
- 上方 `Cross Section` -> `Histogram Scan`
- `Histogram Scan` -> `Blur HQ Grayscale`
- `Blur HQ Grayscale` -> `Auto Levels`
- `Auto Levels` -> 右侧 `Blend`
- `Histogram Scan` 输出还直接分一路连接到同一个 `Blend`
- 下方 `Perlin Noise` -> 下方 `Cross Section`

设置/参数：
- 当前右侧属性面板为 `cross_section - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Cross section coordinate = 0.5`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 1`
  - `Height offset = 0`

输出/预览：
- 左侧 `Cross_section - 2D VIEW` 是一条较宽的白色发光波带，整体呈左右起伏的 M 形轮廓。
- 这一步的意义是保留一条原始截面记录，同时把另一条分支继续做扫描、模糊和电平调整，为后续混合得到更自然的拖尾轮廓。
这张图展示教程在两条拖尾轮廓链之间加入 `Transformation 2D`，用来单独移动或变换其中一张噪声贴图，再与另一条链混合。当前选中 `Transformation 2D`，左侧预览显示的是被变换后的灰度噪声图。

节点定义集：
- 上方链起点
  - `Perlin Noise` 输出先分一路送入 `Transformation 2D`，另一路继续进入 `Cross Section`。
- `Transformation 2D`
  - 当前选中节点。
  - 作用是对噪声图做二维变换，使后续 `Cross Section` / 拖尾轮廓可以只沿特定方向偏移或重排。
- 上方主链后段
  - `Cross Section` -> `Histogram Scan` -> `Blur HQ Grayscale` -> `Auto Levels` -> `Blend`
- 下方主链
  - 另一条 `Perlin Noise` -> `Cross Section` -> `Histogram Scan` -> `Blur HQ Grayscale` -> `Auto Levels` -> `Blend`
- 最右侧汇合 `Blend`
  - 接收上下两条处理后的波形轮廓，做最终合并。

连线集：
- 上方 `Perlin Noise` -> `Transformation 2D`
- 上方原始链继续经过 `Cross Section`、`Histogram Scan`、`Blur HQ Grayscale`、`Auto Levels`，再进入一个 `Blend`
- 下方链同样经过 `Cross Section`、`Histogram Scan`、`Blur HQ Grayscale`、`Auto Levels`，再进入另一个 `Blend`
- 上下两个局部 `Blend` 的输出最终汇入最右侧总 `Blend`

设置/参数：
- 右侧属性面板为 `Transformation 2D - PROPERTIES`。
- 可可靠辨认：
  - `Rotation.Angle = 0.00`
  - `Stretch.Width = 100.00%`
  - `Stretch.Height = 100.00%`
  - `Offset.X = 0`
  - `Offset.Y = 0`
  - `Mipmap Mode = Automatic`
  - `Filtering = Bilinear`

输出/预览：
- 左侧 `Transformation 2D - 2D VIEW` 显示一张柔和的灰度噪声贴图，当前未旋转也未偏移。
- 这一步的意义是先把噪声变换节点独立插入流程，后续只需要调这个节点就能让某条拖尾轮廓沿指定方向移动，而不必重做整条链。
这张图展示 `Transformation 2D` 的 `Offset` 输入函数内部如何由单个动画值组装出二维偏移向量。教程把 `Animation` 参数一路直接送给 `Vector Float2` 的一个分量，同时再乘以 `-1` 后送给另一个分量，从而得到方向相反的二维偏移。

节点定义集：
- `Get Float`
  - 参数名：`Animation`
  - 作用：读取一个用于驱动偏移的单浮点动画值。
- `Float`
  - 常量值：`-1`
  - 作用：提供反向系数。
- `Multiplication`
  - 输入一端接 `Animation`，另一端接 `-1`。
  - 作用：生成 `Animation * -1` 的结果。
- `Vector Float2`
  - 用两个浮点输入组装一个二维向量。
  - 作用：把正向和反向两个值合成为 `Offset` 所需的 `Float2`。

连线集：
- `Get Float(Animation)` -> `Multiplication`
- `Float(-1)` -> `Multiplication`
- `Multiplication` 输出 -> `Vector Float2` 的一个输入分量
- `Get Float(Animation)` 还直接连接到 `Vector Float2` 的另一个输入分量

设置/参数：
- 当前编辑位置为 `Offset(Transformation 2D)`，说明这是 `Transformation 2D` 的偏移输入函数，而不是主图表主链节点。
- 右侧属性面板为 `Float - PROPERTIES`，可确认当前选中常量值为 `-1`。

输出/预览：
- 左侧仍保留 `Transformation 2D - 2D VIEW` 的噪声预览，说明这个偏移函数将直接影响噪声图在 `Transformation 2D` 中的移动方式。
- 该图说明教程希望用一个动画参数同时驱动两个轴的相反位移，使噪声在二维空间中形成更有变化的漂移效果。

### 00:14:29-00:19:03 关键流程 04

- 本段定位：关键流程 04。
- 知识点：我现在移动动画, 它会影响我们的轉变, 我们的聲音。
- 知识点：当然, 它会影响了距離的部分, 它会影响了進入的聲音, 等等。
- 知识点：现在, 这兩种聲音混合起来。
- 知识点：它也会变成不同的效果。
- 知识点：記得我告訴过你, 你用了一个Histogram, 可以用一个線, 或是, 你用一个線来做成一个硬線。

**关键画面：**

这张图展示两条拖尾噪声轮廓链已经各自生成局部结果，并继续汇入右侧总 `Blend` 做最终混合。左侧预览是其中一条局部 `Blend` 的输出，一条柔和发光的波形亮线；右侧图级参数中还能看到 `Animation` 当前值，用于驱动之前 `Transformation 2D` 的偏移函数。

节点定义集：
- 上方链
  - `Cross Section` -> `Transformation 2D` -> `Histogram Scan`
  - `Histogram Scan` 输出一分为二：
    - 一路直接进入上方局部 `Blend`
    - 一路进入 `Blur HQ Grayscale` -> `Auto Levels` 后再进入同一个局部 `Blend`
- 下方链
  - 可见另一条与上方相似的 `Histogram Scan` -> `Blur HQ Grayscale` -> `Auto Levels` -> 局部 `Blend` 结构。
- 右侧总 `Blend`
  - 接收上、下两条局部 `Blend` 的输出，生成最终混合结果。

连线集：
- 上方 `Cross Section` -> `Transformation 2D` -> `Histogram Scan`
- 上方 `Histogram Scan` -> 上方局部 `Blend`
- 上方 `Histogram Scan` -> `Blur HQ Grayscale` -> `Auto Levels` -> 上方局部 `Blend`
- 下方处理链 -> 下方局部 `Blend`
- 上方局部 `Blend` -> 右侧总 `Blend`
- 下方局部 `Blend` -> 右侧总 `Blend`

设置/参数：
- 当前右侧是 `Trail_01 - PROPERTIES` 图级属性面板。
- `INPUT PARAMETERS` 中可可靠辨认：
  - `Animation = 0.74`

输出/预览：
- 左侧 `Blend - 2D VIEW` 显示一条边缘柔和、中心更亮的白色波形拖尾。
- 这一步的意义是把两种噪声轮廓以局部混合后再总混合的方式结合起来，让拖尾边缘既有主轮廓又有次级变化，而且结果保持可平铺。
这张图展示上方拖尾链被进一步拆成多条细化支路：`Transformation 2D` 之后的结果先进入一组模糊/电平/斜向模糊处理，再汇入右侧局部 `Blend`，最后与下方链继续合并。当前左侧 `Blend - 2D VIEW` 几乎全黑，说明当前被查看的局部混合结果亮度很低或阈值很窄。

节点定义集：
- 左侧上方链起点
  - `Cross Section` -> `Transformation 2D`
- 上方主支路
  - `Transformation 2D` -> `Blur HQ Grayscale`
  - 其中一路继续到 `Auto Levels`，再送往右侧局部 `Blend`
- 上方补充分支
  - 从 `Blur HQ Grayscale` 附近分出到 `Levels Grayscale` / `Blur HQ Grayscale` 一类的辅助处理，再进入 `Slope Blur Grayscale`
  - `Slope Blur Grayscale` 输出再汇入右侧局部 `Blend`
- 下方链
  - 仍可见 `Cross Section` -> `Histogram Scan` -> `Blur HQ Grayscale` -> `Auto Levels` -> 局部 `Blend`
- 右侧总 `Blend`
  - 接收上方局部 `Blend` 与下方局部 `Blend` 的输出

连线集：
- 上方 `Cross Section` -> `Transformation 2D`
- `Transformation 2D` -> `Blur HQ Grayscale`
- `Blur HQ Grayscale` -> `Auto Levels` -> 上方局部 `Blend`
- `Blur HQ Grayscale` 还分一路进入下方辅助支路，最终经 `Slope Blur Grayscale` -> 上方局部 `Blend`
- 下方链局部 `Blend` -> 右侧总 `Blend`
- 上方链局部 `Blend` -> 右侧总 `Blend`

设置/参数：
- 当前右侧属性面板为 `Transformation 2D - PROPERTIES`。
- 可可靠辨认：
  - `Rotation.Angle = 0.00`
  - `Stretch.Width = 100.00%`
  - `Stretch.Height = 100.00%`
  - `Offset.X = 0`
  - `Offset.Y = 0`
  - `Mipmap Mode = Automatic`
  - `Filtering = Bilinear`

输出/预览：
- 左侧 `Blend - 2D VIEW` 当前几乎全黑，仅中心留有很弱的暗色圆点，说明这一时刻被查看的局部混合输出非常弱。
- 该图说明教程正在把上方链拆成“主轮廓 + 斜向模糊补充轮廓”的多支路结构，再与下方链继续叠加，以获得更丰富的拖尾边缘变化。
这张图展示两条拖尾链已经都扩展为“主轮廓 + 模糊/电平/斜向模糊补充分支”的完整结构，并且教程重新回到 `Cross Section` 节点，直接调整截面高度，让拖尾波形更符合当前混合需求。

节点定义集：
- 上方链
  - `Perlin Noise` -> `Transformation 2D` -> `Cross Section` -> `Transformation 2D` -> `Blur HQ Grayscale` -> `Auto Levels`
  - 从 `Auto Levels` 分出两路：
    - 一路继续 `Blur HQ Grayscale` -> `Auto Levels`
    - 另一路走 `Levels Grayscale` / `Blur HQ Grayscale` -> `Slope Blur Grayscale`
  - 两路最终汇入右侧上方 `Blend`
- 下方链
  - 结构与上方链相似，也由 `Perlin Noise`、`Transformation 2D`、`Cross Section`、模糊、电平、斜向模糊等节点组成
  - 两路结果最终汇入右侧下方 `Blend`
- 当前选中 `Cross Section`
  - 位于下方链左中部。
  - 左侧 2D 预览显示一条白色波线，形态较平滑、只有一次明显下探后再回升。

连线集：
- 上、下两条链都从各自的 `Perlin Noise` 出发，经 `Transformation 2D` 与 `Cross Section` 后继续展开。
- 每条链在 `Auto Levels` 后分叉为两路：
  - 主模糊/电平路
  - 经 `Levels Grayscale` / `Blur HQ Grayscale` 再到 `Slope Blur Grayscale` 的补充路
- 各自两路汇入本链末端 `Blend`
- 上、下两条链在更右侧继续作为两个独立局部结果存在，准备进入后续更高层混合。

设置/参数：
- 右侧属性面板为 `cross_section - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Cross section coordinate = 0.5`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 0.75`
  - `Height offset = 0.06`
  - `Drawing style = Line`
  - `Segment amount = 146`

输出/预览：
- 左侧 `Cross_section - 2D VIEW` 是一条较细的白色波线，整体更贴近单条拖尾主骨架。
- 这一步的意义是直接从截面层面微调波形的高度与偏移，让两条拖尾链在后续混合前拥有更合适的基础轮廓。

### 00:19:03-00:23:35 关键流程 05

- 本段定位：关键流程 05。
- 知识点：因为我们已经用了不同的模式。
- 知识点：我们把这个距離分開, 然后把它自動调整, 以让它变成黑色的價值, 让它滑掉了。
- 知识点：我把自動调整關掉, 我控制了重量。
- 知识点：在这个距離分開上的另一个例子, 就是管理高度。
- 知识点：可以把转换方法 和它们变成相同的部分。

**关键画面：**

这张图展示教程从一条已经过 `Blur HQ Grayscale` 和 `Auto Levels` 处理的波形轮廓里，再分出一条反相支路做辅助形变。当前选中的是 `Invert Grayscale`，左侧预览显示白底黑线的反相结果。

节点定义集：
- 左侧已有主链
  - `Blur HQ Grayscale` -> `Auto Levels`
  - 该链产出一条白色亮线轮廓。
- 上方主支路
  - 从 `Auto Levels` 分出后继续走 `Blur HQ Grayscale` -> `Auto Levels`
  - 作用：保留一条更平滑的亮线轮廓。
- 中间支路
  - 从 `Auto Levels` 直接进入 `Slope Blur Grayscale`
  - 作用：生成更具破碎感或扭曲感的轮廓。
- 下方反相支路
  - `Auto Levels` -> `Invert Grayscale` -> `Blur HQ Grayscale`
  - 作用：先把亮暗关系反转，再模糊出一条黑色轮廓辅助图。
- `Invert Grayscale`
  - 当前选中节点。
  - 预览是一条黑色波线，背景为白色。

连线集：
- 左侧 `Blur HQ Grayscale` -> `Auto Levels`
- `Auto Levels` -> 上方 `Blur HQ Grayscale` -> 上方 `Auto Levels`
- `Auto Levels` -> 中间 `Slope Blur Grayscale`
- `Auto Levels` -> `Invert Grayscale` -> 下方 `Blur HQ Grayscale`

设置/参数：
- 右侧属性面板为 `invert_grayscale - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Invert = True`

输出/预览：
- 左侧 `Invert_grayscale - 2D VIEW` 显示白底黑色波形线，线条边缘有轻微柔化。
- 这一步的意义是得到一张与原亮线相反的暗线轮廓，后续可与正向亮线、斜向模糊结果一起混合，形成更复杂的拖尾边缘结构。
这张图展示 `Trail_01` 图已经收敛到最终输出阶段：左侧一个最终 `Blend` 结果先经过 `Transformation 2D`，再直接送入 `output` 节点。当前输出纹理是一组两两交叉的白色发光曲线，可直接作为拖尾贴图。

节点定义集：
- 最终 `Blend`
  - 左侧节点。
  - 输出是一组已经混合完成的多条亮线拖尾。
- `Transformation 2D`
  - 位于最终 `Blend` 与 `output` 之间。
  - 作用是对最终拖尾纹理做最后的二维变换或定位修正。
- `output`
  - 当前图表输出节点。
  - 直接接收 `Transformation 2D` 的结果。

连线集：
- 最终 `Blend` -> `Transformation 2D`
- `Transformation 2D` -> `output`

设置/参数：
- 当前右侧为 `Trail_01 - PROPERTIES` 图级属性面板。
- `INPUT PARAMETERS` 中可可靠辨认：
  - `Animation = 1.85`
- 其余图级参数在本图中未展开显示。

输出/预览：
- 左侧 `Output - 2D VIEW` 显示黑底上两条左右延展、相互交叉的白色发光拖尾曲线，中心交汇处最亮，边缘柔和衰减。
- 这一步说明教程已经把多条噪声链整合成一张可用的 trail 纹理，并只保留一个最终 `Transformation 2D` 作为输出前的最后修正。
这张图展示教程开始引入新的外部噪声素材组合。当前选中的是一个 `Blend` 节点，它把 `Perlin Noise` 和 `Voronoi Fractal` 两张灰度噪声混合成一张气泡状、颗粒感更强的噪声图，再将该结果送往右侧已有的波线处理链。

节点定义集：
- `Perlin Noise`
  - 预览为柔和的大块灰度噪声。
- `Voronoi Fractal`
  - 预览为由许多圆形/细胞状亮斑组成的分形噪声。
- 当前选中 `Blend`
  - 把 `Perlin Noise` 与 `Voronoi Fractal` 混成一张新的复合噪声图。
  - 左侧 `2D VIEW` 预览显示的就是混合结果：柔和云雾中混入大量圆点/气泡结构。
- 右侧后续链
  - 混合噪声继续连接到一条已有的波线节点链，图中可见后续 `Auto Levels` 前的亮线结果。

连线集：
- `Perlin Noise` -> 当前 `Blend`
- `Voronoi Fractal` -> 当前 `Blend`
- 当前 `Blend` 输出 -> 右侧后续亮线处理链

设置/参数：
- 右侧属性面板为 `Blend - PROPERTIES`。
- 可可靠辨认：
  - `Opacity = 1`
  - `Blending Mode = Add Sub`
- 其余模式列表只是下拉候选项，不能据此推断未选中的参数。

输出/预览：
- 左侧 `Blend - 2D VIEW` 预览是一张由灰色云团和大量亮圆斑组成的复合噪声。
- 这一步的意义是把更丰富的外部噪声形态引入拖尾流程，为后续生成与前面纯 Perlin 噪声不同的边缘细节和内部纹理变化。

### 00:23:35-00:28:14 外部资产制作与导入

- 本段定位：外部资产制作与导入。
- 知识点：让你明白 如何可以去体驗 和做一些很驚人的事情。
- 知识点：我非常喜欢 Substance Designer。
- 知识点：我还会下載 很多我不同的 Substance Designer的设计。
- 知识点：我们增加重量 以, 例如, 15。
- 知识点：需要用一种 叫做Curve Smooth。
- 核对对象：`Curve`、`Multiply`、`Substance Designer`。

**关键画面：**

这张图展示教程把两条已完成的亮线拖尾送入 `Multi Dir. Warp Grayscale` 做多方向扭曲，并同时引入一张由 `Perlin Noise` 与 `Voronoi Fractal` 混出的复合噪声作为辅助输入。左侧预览是当前 `Multi_directional_warp_grayscale` 的输出，拖尾边缘已经出现明显的多方向拉扯和闪电状抖动。

节点定义集：
- 上方已有亮线拖尾结果
  - 预览为两条交叉的白色发光曲线。
  - 作为主图像输入继续送入后续扭曲节点。
- `Perlin Noise`
  - 提供柔和的大块灰度噪声。
- `Voronoi Fractal`
  - 提供细胞状、圆斑型分形噪声。
- 中间 `Blend`
  - 把 `Perlin Noise` 与 `Voronoi Fractal` 混成一张复合噪声。
- `Multi Dir. Warp Grayscale`
  - 接收上方亮线拖尾和下方复合噪声。
  - 作用是让发光拖尾在多个方向上产生局部扭曲和破碎感。
- 右侧当前选中 `Blend`
  - 接收 `Multi Dir. Warp Grayscale` 的输出，准备继续与后续链混合。

连线集：
- 上方亮线拖尾结果 -> `Multi Dir. Warp Grayscale`
- `Perlin Noise` -> 中间 `Blend`
- `Voronoi Fractal` -> 中间 `Blend`
- 中间 `Blend` 输出 -> `Multi Dir. Warp Grayscale`
- `Multi Dir. Warp Grayscale` 输出 -> 右侧 `Blend`

设置/参数：
- 当前右侧属性面板为 `Blend - PROPERTIES`。
- 可可靠辨认：
  - `Opacity = 0.92`
  - `Blending Mode = Screen`
  - `Alpha Blending = Use Source Alpha`
  - `Cropping Area.Left = 0`
  - `Cropping Area.Right = 1`
  - `Cropping Area.Top = 0`
  - `Cropping Area.Bottom = 1`

输出/预览：
- 左侧 `Multi_directional_warp_grayscale - 2D VIEW` 显示两条交叉拖尾被扭成更不规则的亮线，边缘带有碎裂感和细小尖刺。
- 这一步的意义是把前面过于平滑的 trail 轮廓打散，利用复合噪声制造更自然、更有能量感的拖尾边缘。
这张图展示教程继续对扭曲后的拖尾亮线做平滑与方向模糊，并通过两级 `Blend` 重新叠回主结果。左侧预览显示的是当前 `Blend` 输出：交叉拖尾依然保持高亮，但边缘被整理得更顺、更统一。

节点定义集：
- 左侧输入结果
  - 来自上一阶段的多方向扭曲亮线结果。
- `Curvature Smooth`
  - 接在一条分支上。
  - 作用：平滑局部弯曲，减轻过于尖锐的折线感。
- 第一个 `Blend`
  - 把主输入与 `Curvature Smooth` 结果合并。
- `Directional Blur`
  - 接在第一个 `Blend` 之后的支路上。
  - 作用：沿特定方向拉伸亮线，制造更顺滑的拖尾涂抹感。
- 右侧第二个 `Blend`
  - 把 `Directional Blur` 的结果再次叠回第一个 `Blend` 的基础图上，形成最终显示结果。

连线集：
- 左侧主输入 -> 第一个 `Blend`
- `Curvature Smooth` -> 第一个 `Blend`
- 第一个 `Blend` 输出一分为二：
  - 一路直接进入第二个 `Blend`
  - 一路进入 `Directional Blur`，再送到第二个 `Blend`

设置/参数：
- 当前右侧属性面板为 `Blend - PROPERTIES`。
- 可可靠辨认：
  - `Opacity = 0.38`
  - `Blending Mode = Screen`
  - `Alpha Blending = Use Source Alpha`
  - `Cropping Area.Left = 0`
  - `Cropping Area.Right = 1`
  - `Cropping Area.Top = 0`
  - `Cropping Area.Bottom = 1`

输出/预览：
- 左侧 `Blend - 2D VIEW` 显示两条交叉的高亮拖尾，边缘带有较细的闪电状裂纹，但整体比前一阶段更柔和、连续。
- 这一步的意义是用平滑和方向模糊把过于粗糙的扭曲边缘整理回可用状态，同时保留一定的能量细节。
这张图展示教程开始创建新的图表 `Trail_Lightning_01`。主图画布此时还是空白，但左侧预览已经显示一张交叉的闪电拖尾纹理，结合字幕“从上一张图取前几个节点复制过来”，可以确认教程准备把前一个 trail 图中的一部分结构复制到这个新图里继续加工。

节点定义集：
- 当前图表：`Trail_Lightning_01`
  - 主画布为空，尚未在截图中看到已粘贴完成的节点。
  - 说明此时主要是在建立新图与预览上下文。
- 左侧预览 `Trail_Glow - 2D VIEW`
  - 显示黑底上两条交叉的白色闪电状拖尾，边缘带有细小裂纹和辉光。
  - 这是即将被复用到新图中的已有结果外观。

连线集：
- 当前截图的主画布没有可见节点，因此没有可可靠确认的节点连线。
- 只能确认教程接下来要从上一张图复制“前几个节点”到本图。

设置/参数：
- 右侧属性面板为 `Trail_Lightning_01 - PROPERTIES`。
- 可可靠辨认：
  - `Identifier = Trail_Lightning_01`
  - `Package = C:/Users/Stand1k/Desktop/Flare.sbs`
  - `Exposed in SBSAR = Yes`
  - `Show In Library = Yes`

输出/预览：
- 左侧预览是一张交叉的闪电拖尾贴图，亮度集中在线条中心，边缘有柔和辉光和局部破碎感。
- 这张图的作用是说明教程开始基于现有 trail 成果新建一个 lightning 变体图表，而不是从零重新搭建。

### 00:28:14-00:32:47 关键流程 07

- 本段定位：关键流程 07。
- 知识点：对了, 这里可能会被剪掉。
- 知识点：如果可以 把一些东西 剪掉。
- 知识点：需要用 我们之前的圖案。
- 知识点：我们现在需要 一條路。
- 知识点：我们需要 一條路叫Cells。

**关键画面：**

这张图展示新图 `Trail_Lightning_01` 中，教程先检查从上一张图复制过来的基础节点是否仍然正确连接。当前主链只有三个可见节点：`Perlin Noise -> Transformation 2D -> Cross Section`，左侧预览显示的是 `Transformation 2D` 处理后的噪声图。

节点定义集：
- `Perlin Noise`
  - 作为新图里最基础的灰度噪声来源。
- `Transformation 2D`
  - 当前选中节点。
  - 作用是对噪声图做平移、旋转或缩放等二维变换，避免复制后绑定关系出错。
- `Cross Section`
  - 接在 `Transformation 2D` 后，用于把噪声变成可控制的截面轮廓。

连线集：
- `Perlin Noise` -> `Transformation 2D`
- `Transformation 2D` -> `Cross Section`

设置/参数：
- 当前右侧属性面板为 `Trail_Lightning_01 - PROPERTIES`。
- `INPUT PARAMETERS` 中可见：
  - `Animation = 1`
- 这说明复制后的图级动画参数仍然存在，可继续驱动偏移相关节点。

输出/预览：
- 左侧 `Transformation 2D - 2D VIEW` 显示一张柔和灰度噪声图，中央有较暗斑块，四周为较亮云雾。
- 这一步的意义是先验证复制过来的基础噪声与变换链没有断开，再继续往 `Trail_Lightning_01` 中补后续 lightning 处理节点。
这张图展示 `Trail_Lightning_01` 已经恢复出上下两条基础轮廓链，并把它们汇入一个 `Blur HQ Grayscale` 做统一模糊。左侧预览正是这个 `Blur_hq_grayscale` 的输出，一张以交叉亮斑为中心、四周渐隐的柔和灰度图。

节点定义集：
- 上方链
  - `Perlin Noise` -> `Transformation 2D` -> `Cross Section` -> `Histogram Scan`
- 下方链
  - `Cells 1` -> `Transformation 2D` -> `Cross Section`
  - 末端还有一个当前选中的小节点，标注近似 `stitches`，再接入统一模糊节点。
- `Blur HQ Grayscale`
  - 当前选中节点。
  - 接收上、下两条链的结果并做高质量模糊，生成更柔和的 lightning 亮度底图。

连线集：
- 上方链末端 `Histogram Scan` -> `Blur HQ Grayscale`
- 下方链末端小节点 -> `Blur HQ Grayscale`
- 上、下两条链各自都从一个源图经 `Transformation 2D` 与 `Cross Section` 展开。

设置/参数：
- 右侧属性面板为 `blur_hq_grayscale - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Intensity = 2.78`
- `Quality` 参数项可见，但具体值在截图中未清晰显示。

输出/预览：
- 左侧 `Blur_hq_grayscale - 2D VIEW` 显示一张以中部交汇区最亮、四周大面积柔和过渡的模糊灰度图。
- 这一步的意义是先把多条基础 lightning 轮廓统一模糊成一张连续亮度底图，为后续再做提亮、阈值或细化提供基础。
这张图展示 `Trail_Lightning_01` 开始把两条基础链合入 `Warp`：上方链生成一条细亮线作为主输入，下方 `Cells 1` 分支经过变换和模糊后，作为 `Warp` 的扭曲梯度输入。左侧预览显示的最终局部结果是两条交叉的细白线，说明闪电骨架已经成形。

节点定义集：
- 上方主链
  - `Perlin Noise` -> `Transformation 2D` -> `Cross Section` -> `Histogram Scan`
  - 生成一条细亮线结果，送入 `Warp`。
- 下方梯度链
  - `Cells 1` -> `Transformation 2D` -> `Blur HQ Grayscale`
  - 生成一张柔和的细胞噪声，用作扭曲梯度。
- `Warp`
  - 接收上方细亮线与下方模糊噪声。
  - 作用：把细亮线按细胞噪声轻微扭曲，形成更自然的 lightning 折线感。
- 上方 `Transformation 2D`
  - 当前右侧属性面板对应的节点，控制主链噪声图的拉伸形态。

连线集：
- 上方 `Perlin Noise` -> 上方 `Transformation 2D` -> `Cross Section` -> `Histogram Scan` -> `Warp`
- 下方 `Cells 1` -> 下方 `Transformation 2D` -> `Blur HQ Grayscale` -> `Warp`

设置/参数：
- 当前右侧属性面板为 `Transformation 2D - PROPERTIES`。
- 可可靠辨认：
  - `Rotation.Angle = 0.00`
  - `Stretch.Width = 50.00%`
  - `Stretch.Height = 100.00%`
  - `Offset.X = 0`
  - `Offset.Y = 0`
  - `Mipmap Mode = Automatic`
  - `Filtering = Bilinear`

输出/预览：
- 左侧 `Blend - 2D VIEW` 预览是一组交叉的细白线，整体比前面 trail 更细、更像闪电主骨架。
- 这一步的意义是用 `Cells` 噪声驱动 `Warp`，在保留线条连续性的同时引入更自然的闪电抖动感。

### 00:32:47-00:37:45 关键流程 08

- 本段定位：关键流程 08。
- 知识点：把它全部雙倍 例如这里 为了廣闊这个聲音 需要把它剪輯到这里 我喜欢这个 需要把它轉变 让它变得不同 需要把它提升 需要再加一个光线 我不喜欢。
- 知识点：这是需要改变的 例如 这里的和弧形可以改变 需要加一个光线 这里需要改变它的位置 让它变得更厚 需要把它改变到这个位置 需要把它弄得更厚。
- 知识点：需要加一个光线 这樣就好了 现在它们都变得很順滑 記得每个轉变 都会有一个动画 现在可观察到 最後的魔法 或者我现在给你们看 它们都会轉变。
- 知识点：很酷吧 可以做什么 需要把这个轉变变成直線 需要把它留下来 需要用blend 需要加一个光线 需要用blend 需要用自動调整 需要用blur 需要把它更厚。

**关键画面：**

这张图展示 `Trail_Lightning_01` 中，教程把一条由 `Histogram Scan` 得到的细亮线送入 `Warp`，并同时接入两条来自 `Cells 1 -> Transformation 2D -> Blur HQ Grayscale` 的细胞噪声分支作为扭曲来源。左侧预览是当前 `Warp` 的输出，一条不规则上下起伏的闪电曲线。

节点定义集：
- 上方噪声分支
  - `Cells 1` -> `Transformation 2D` -> `Blur HQ Grayscale`
  - 生成一张细胞状模糊噪声。
- 中间主线分支
  - `Transformation 2D` -> `Cross Section` -> `Histogram Scan`
  - 产出一条细亮线，作为 `Warp` 的主输入。
- 下方噪声分支
  - 另一条 `Cells 1` -> `Transformation 2D` -> `Blur HQ Grayscale`
  - 作为额外的扭曲辅助图。
- `Warp`
  - 当前选中节点。
  - 把中间细线按上下两路细胞噪声进行扭曲，生成更有闪电感的折线轮廓。

连线集：
- 中间主线分支末端 `Histogram Scan` -> `Warp`
- 上方 `Blur HQ Grayscale` -> `Warp`
- 下方 `Blur HQ Grayscale` -> `Warp`

设置/参数：
- 右侧属性面板为 `Warp - PROPERTIES`。
- `SPECIFIC PARAMETERS` 中可可靠辨认：
  - `Intensity = 1.49`
  - `Input Filtering Mode = Bilinear`

输出/预览：
- 左侧 `Warp - 2D VIEW` 显示一条细白闪电线，线身在几个位置明显起伏、下垂再回升。
- 这一步的意义是用两路细胞噪声去打散和扭曲基础直线，使闪电主骨架摆脱过于机械的规律性。
这张图展示 `Trail_Lightning_01` 已经扩展成多条独立 lightning 支路，并通过多级 `Blend` 汇合成最终结果。左侧预览显示的是当前 `Blend` 输出：画面里同时存在多条粗细不同、相互交叉的白色闪电线。

节点定义集：
- 多条左侧生成链
  - 可见多组 `Perlin Noise / Cells 1`、`Transformation 2D`、`Cross Section`、`Histogram Scan` / `Warp` 组合。
  - 每组链路都生成一条或一组独立的 lightning 线段。
- 中间多个局部 `Blend`
  - 负责先把若干支路两两或逐组并起来。
- 最右侧当前选中 `Blend`
  - 把上方局部 `Blend`、中间局部 `Blend`、下方另一条亮线支路一起汇成最终 composite。

连线集：
- 左侧多条 lightning 生成链分别汇入若干中间 `Blend`
- 中间 `Blend` 的结果继续送入更右侧的汇总 `Blend`
- 当前右侧 `Blend` 至少接收三路输入：
  - 上方局部 `Blend`
  - 中间局部 `Blend`
  - 下方一条独立亮线支路

设置/参数：
- 当前右侧属性面板为 `Blend - PROPERTIES`。
- 可可靠辨认：
  - `Opacity = 1`
  - `Blending Mode = Max (Lighten)`
  - `Alpha Blending = Use Source Alpha`
  - `Cropping Area.Left = 0`
  - `Cropping Area.Right = 1`
  - `Cropping Area.Top = 0`
  - `Cropping Area.Bottom = 1`

输出/预览：
- 左侧 `Blend - 2D VIEW` 中有多条交叉闪电线：有的更粗更亮，有的更细更平直，整体构成一张更复杂的闪电拖尾贴图。
- 这一步的意义是通过复制和混合多条 lightning 骨架，让单一闪电线扩展成更丰富的电弧群，同时用 `Max (Lighten)` 保持整体亮度主导而不过度变灰。
这张图展示教程继续通过模糊、电平和混合节点去加厚并提亮闪电群。多条 lightning 线已经被分成若干局部结果，先在中间 `Blend` 汇合，再和右下方另一张 `Blur HQ Grayscale` 结果一起送入最右侧 `Blend`。

节点定义集：
- 左上 `Blur HQ Grayscale`
  - 当前左侧预览对应的节点。
  - 输出是一组较细的多条闪电线。
- 顶部中间节点
  - 来自上一阶段的一张较暗、较宽的闪电线图。
- 中间 `Blend`
  - 接收顶部较暗闪电线图与中间 `Auto Levels` 的结果，生成更亮的组合版本。
- 中间 `Auto Levels`
  - 对一组模糊闪电线做亮度拉伸。
- 右下 `Blur HQ Grayscale`
  - 接收一张灰度闪电图并再次模糊，作为另一层补充亮线。
- 最右侧 `Blend`
  - 当前还未选中。
  - 接收中间 `Blend` 与右下 `Blur HQ Grayscale` 两路输入，继续做最终复合。

连线集：
- 顶部较暗闪电线图 -> 中间 `Blend`
- 中间 `Auto Levels` -> 中间 `Blend`
- 中间 `Blend` 输出 -> 最右侧 `Blend` 的 `Foreground`
- 右下 `Blur HQ Grayscale` 输出 -> 最右侧 `Blend` 的 `Background`

设置/参数：
- 当前右侧属性面板为 `blur_hq_grayscale - PROPERTIES`。
- `INSTANCE PARAMETERS` 中可可靠辨认：
  - `Intensity = 2.17`
- `Quality` 参数项可见，但具体值未清晰显示。

输出/预览：
- 左侧 `Blur_hq_grayscale - 2D VIEW` 显示多条交叉的闪电线，中心区域更密集，线身已较前面更厚、更亮。
- 这一步的意义是通过再次模糊和电平拉伸，让闪电群既保留主骨架，也拥有更明显的发光包边和厚度层次。

### 00:37:45-00:42:20 关键流程 09

- 本段定位：关键流程 09。
- 知识点：需要把它轉变 但可以把它留下来 但需要把它翻过来 让它变成直線 可以把它轉变成2048 也能把它放在这里 主要是它应该是2的力量。
- 知识点：需要加一个光线 来增添颜色 可以加一个光线 可以加一个光线 来增添颜色 可以看看它会如何 可以把它拿起来 需要把它加一点 让它有一点動作。
- 知识点：可以现在試試看 用不同的模式 你看到它很漂亮地重複了 可以把它翻过来 把它变成直線 但它必须要改变 需要把它重複 通常需要把它黑和白 这是示範。
- 知识点：我加了颜色 这里點擊和拾 让我们不要忘記我们的動作 它动画我们的光 它动画我们的轉变 这是你能做的 一層一層的動作 你看到它是如何的 我现在在用一种叫做。
- 知识点：需要给你看看 我打開了 这里可以把它延长 延长 我已经给你看过这例子 这里没有任何的功能 但如果我们去这个轉变 每个都会有一个叫做时间 它会自動地创建在每个動作里 它在做什么。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图展示 `Trail_Lightning_01` 的最终闪电贴图在输出前又经过一个 `Transformation 2D`。左侧预览中能看到交叉闪电线被平铺重复显示，字幕说明这里准备用拉伸方式把它做成更适合竖向使用的闪电纹理。

节点定义集：
- 左侧 `Blend`
  - 当前已经汇总好的闪电线结果。
  - 节点缩略图中可见多条交叉的白色闪电线。
- `Transformation 2D`
  - 当前选中节点。
  - 作用是在最终输出前对整张闪电贴图做几何变换，例如拉伸或翻转。

连线集：
- 左侧 `Blend` -> `Transformation 2D`

设置/参数：
- 右侧属性面板为 `Transformation 2D - PROPERTIES`。
- 可可靠辨认：
  - `Rotation.Angle = 0.00`
  - `Stretch.Width = 100.00%`
  - `Stretch.Height = 100.00%`
  - `Offset.X = 0`
  - `Offset.Y = 0`
  - `Mipmap Mode = Automatic`
  - `Filtering = Bilinear`

输出/预览：
- 左侧 `Transformation 2D - 2D VIEW` 显示黑底上多条交叉闪电线被平铺重复，单元之间无明显断缝。
- 这一步的意义是先在最终阶段用 `Transformation 2D` 检查和准备贴图的可平铺性与纵横比例，便于把 lightning 纹理改造成竖向拉链式使用。
这张图展示在 lightning 主结果外再叠加一层 `Blur HQ Grayscale`，为闪电增加更宽的 glow 包边。左侧 `Glow - 2D VIEW` 已经能看到黑底上的蓝色发光闪电重复平铺，说明教程正在把原本的灰度闪电骨架推进到带颜色和发光感的最终观感。

节点定义集：
- 左上 `Blend`
  - 已有的多条闪电线主结果。
  - 节点缩略图中可见细亮线结构。
- `Blur HQ Grayscale`
  - 当前选中节点。
  - 对闪电线结果做额外模糊，生成更宽的亮度扩散层。
- 右侧 `Blend`
  - 把主闪电线与模糊 glow 层重新合成。

连线集：
- 左上 `Blend` -> 右侧 `Blend`
- `Blur HQ Grayscale` -> 右侧 `Blend`

设置/参数：
- 右侧属性面板为 `blur_hq_grayscale - PROPERTIES`。
- 可可靠辨认：
  - `Intensity = 1.42`
- `Quality` 参数项可见，但具体数值在当前截图中无法可靠辨认。

输出/预览：
- 左侧 `Glow - 2D VIEW` 显示蓝色发光闪电在黑底上按竖向重复平铺。
- 这一步的作用是给主闪电线外侧叠加一层更宽的模糊亮度，从而形成最终更明显的蓝色 glow 观感。
这张图展示 `Lightning02` 的 Substance Designer 总图视图。左侧 `Lightning02 - 2D VIEW` 已经能看到一条细长的蓝色闪电纹理，说明教程把前面多条灰度分支组合成了最终的纵向 lightning 结果。由于右侧部分节点名称被遮挡或超出截图，仅能可靠转写当前可见分支。

节点定义集：
- 上方分支中的 `Transformation 2D`
  - 输入来自左侧一个未完整显示名称的源节点。
  - 之后接一组轮廓整形节点。
- 上方分支中的 `Cross Section`
  - 用于把上游形状整理成更明确的截面轮廓。
- 上方分支中的 `Histogram Scan`
  - 继续压缩或强化亮度分布，输出到右侧一个名称不可见的黑色节点。
- 中间分支中的 `Cells 1`
  - 作为一组辅助纹理源。
- 中间分支中的 `Transformation 2D`
  - 当前选中节点。
  - 对 `Cells 1` 的形状做二维变换。
- 中间分支中的 `Blur HQ Grayscale`
  - 对中间分支结果做模糊，输出到右侧一个名称不可见的黑色节点。
- 下方分支中的 `Transformation 2D`
  - 输入来自左侧一个未完整显示名称的源节点。
- 下方分支中的 `Cross Section`
- 下方分支中的 `Histogram Scan`
  - 这一组与上方分支相同，也是先变换再重塑轮廓，最后输出到右侧另一处名称不可见的黑色节点。

连线集：
- 上方未完整显示源节点 -> 上方 `Transformation 2D` -> 上方 `Cross Section` -> 上方 `Histogram Scan` -> 右侧名称不可见节点
- `Cells 1` -> 中间 `Transformation 2D` -> `Blur HQ Grayscale` -> 右侧名称不可见节点
- 下方未完整显示源节点 -> 下方 `Transformation 2D` -> 下方 `Cross Section` -> 下方 `Histogram Scan` -> 右侧名称不可见节点

设置/参数：
- 当前右侧属性面板为中间分支 `Transformation 2D - PROPERTIES`。
- 可可靠辨认：
  - `Rotation.Angle = 0.00`
  - `Stretch.Width = 100.00%`
  - `Stretch.Height = 100.00%`
  - `Mipmap Mode = Automatic`
  - `Filtering = Bilinear`
- `Offset` 区域可见，但具体数值在当前截图中不够清晰。

输出/预览：
- 左侧预览是一条竖向、细长、带蓝色 glow 的闪电纹理，画面尺寸栏显示为 `512 x 2048 (RGBA, 16bpc)`。
- 当前截图能确认的重点是：教程把多个分支分别经过 `Transformation 2D`、轮廓重塑和亮度扫描后，再送往右侧汇总节点，逐步构成最终的纵向 lightning 贴图。
- 右侧汇总节点的准确名称和更下游连接关系未完整显示，需人工结合原工程图继续核对。

### 00:42:20-00:47:11 关键流程 10

- 本段定位：关键流程 10。
- 知识点：这就是一个程式叫做 物理游戏 你必须要的东西是 不要忘記你必须要有出口 可以有很多的出口 我再加 对,第二个会是黑和白 这是我以前做的另一个例子。
- 知识点：我们现在把这个给物理游戏 按下拇指 选择你喜欢的地方 我把它放在桌上 需要打開 我打開物理游戏 找到这张檔案的地方 然后我把它拉開 这就是它了。
- 知识点：我打開物理游戏 我把它拉開了 我按下關掉 这里有一个时间線 可以按下动画 这是我们时间的控制 这里有卡 多少秒都过去了 可以提升或提低 这里可以控制。
- 知识点：画面的大小 1024、2048的畫質 这里是黑和白的 光线 我做的兩张出口 这里有更多的圖像 25%減少 我按下这里 动画开始 我按下这里 让它消失。
- 知识点：你来看这张例子 这里是我们的光线02 这个时间線 只是控制我们的时间 酷 可以立刻輸出 这里有很多设置 数字、动画时间、选择模式 需要做一个名字。

**关键画面：**

这张图切换到了 `Substance Player` 界面，左侧是 `2D VIEW`，右侧是 `PARAMETERS`，底部有 `TIMELINE`。字幕明确提示“点击这个容器，不要忘记这里需要有输出”，说明此时教程在讲把做好的 lightning 图导入播放器后，需要先选中承载资源的容器，并确认该图存在可输出的结果通道。

当前可确认信息：
- 软件界面为 `Substance Player`，而不是前面的 Designer 图表视图。
- 左侧 `2D VIEW` 中只隐约可见一条横向细线，当前截图没有清楚显示具体纹理内容。
- 右侧 `PARAMETERS` 面板在当前帧中基本为空，没有可可靠辨认的参数项。
- 底部存在时间轴区域，说明后续会在播放器里预览动画或时间变化。

不确定点：
- 当前被点击的“容器”在界面中的准确名称与层级没有显示清楚。
- “输出”对应的是单一输出槽、多个输出列表，还是某个具体导出按钮，当前截图无法可靠判断。
- 左侧预览中的实际纹理细节不可辨认，无法据此补写更具体的输出类型。
这张图展示在 `Substance Player` 中调整 lightning 输出图的分辨率。左侧 `2D VIEW` 已经显示一条纵向蓝色闪电，右侧 `PARAMETERS` 面板展开了 `Lightning01` 参数组，并打开 `Output Size` 的下拉列表，字幕明确说明这里可以控制图像尺寸，当前示例使用 `1024 x 2048`。

当前可确认信息：
- 当前资源文件标题栏为 `LightningAnim.sbsar`。
- 左侧 `Graphs` 选择为 `pkg:///Lightning02`。
- `Outputs` 区域可见两个输出页签：
  - `Lightning02`
  - `Lightning_Grayscale`
- 右侧 `PARAMETERS` 面板顶部可见：
  - `Time`，并标注 `Driven by the timeline`
  - 当前时间值为 `0.000`
- `Lightning01` 参数组已展开，`Lightning02` 参数组处于折叠状态。
- `Output Size` 使用锁定长宽比的双输入框，当前左右两个尺寸值都设置为 `1024`，对应下方字幕给出的目标分辨率说明为 `1024 x 2048`。
- 下拉列表可选尺寸包含 `1、2、4、8、16、32、64、128、256、512、1024、2048、4096`。
- `Random Seed` 参数行可见，右侧带有 `Randomize` 按钮。

输出/预览：
- 左侧预览显示黑底上的发光蓝色闪电，纵向细长，适合作为竖向 lightning 贴图使用。
- 这一步的意义是进入 Player 后，为已生成的 lightning 纹理设置可导出的输出尺寸，并保留时间轴驱动以便继续预览动画。
这张图展示在 `Substance Player` 中把 lightning 动画导出为位图序列。界面中央弹出 `Render animation as Bitmap(s)` 对话框，正在逐帧写出 PNG 文件；字幕说明这是“定格动画”，对应把时间轴上的变化离散导出成一串图片帧。

当前可确认信息：
- 当前资源仍为 `LightningAnim.sbsar`，`Graphs` 选择为 `pkg:///Lightning02`。
- `Outputs` 页签仍可见：
  - `Lightning02`
  - `Lightning_Grayscale`
- 左侧 `2D VIEW` 显示一条纵向蓝色闪电。
- 时间轴当前时间为 `0.533 s`，帧显示为 `16 f`。
- 右侧 `PARAMETERS` 面板中：
  - `Time` 由时间轴驱动，值为 `0.533`
  - `Lightning01.Output Size = 2048 x 2048`
  - `Lightning01.Random Seed = 0`
  - `Lightning02.Output Size = 512 x 512`
  - `Lightning02.Random Seed = 0`

导出/输出：
- 弹窗标题为 `Render animation as Bitmap(s)`。
- 当前状态显示 `Rendering frame 18/31...`。
- 输出文件路径列表可见，命名模式为：
  - `C:/Users/Stand1k/Desktop/player/Lightning02_Lightning02_0000.png`
  - `..._0001.png`
  - 按序递增直到当前正在写出的帧
- 进度条已推进到中段，说明动画位图序列正在批量导出中。

结果含义：
- 这一步不是继续编辑节点，而是把在 Player 中预览的 lightning 动画烘焙成连续 PNG 帧。
- 导出后的序列可再用于后续的 flipbook、逐帧贴图或其他动画纹理流程。

### 00:47:11-00:48:19 关键流程 11

- 本段定位：关键流程 11。
- 知识点：我打開它 需要把它換掉 这是一个停動动画 这里有特别的程式 可以全部刷掉 需要找到 这里有很多画面 这是一个每个画面的动画 像是一个画面 需要在这里學習。
- 知识点：可以在这里學習 就像是做停動动画 这就是如何有趣的 在跟一个物理设计師合作 謝謝觀看 每个人祝大家一过一日 再見。

**关键画面：**

这张图展示导出的 lightning 动画已经变成一组 PNG 序列，并在 Windows 照片查看器里打开其中一帧进行检查。教程此时是在确认前面从 `Substance Player` 烘焙出来的 stop motion 结果是否可用。

当前可确认信息：
- 背景仍能看到 `Substance Player - LightningAnim.sbsar`，左侧 `2D VIEW` 中是纵向蓝色闪电。
- 前景打开了两个 Windows 窗口：
  - 一个资源管理器窗口，路径栏显示位于 `Desktop > player`
  - 一个照片查看窗口，正在预览单张 lightning 图片
- 资源管理器中可见一组按序编号的 PNG 文件，文件名前缀为 `Lightning02_Lightning02_`。
- 缩略图列表可辨认的文件编号包括：
  - `0006` 到 `0012`
  - `0019` 到 `0025`
  - `0026` 到 `0030`
- 底部状态栏显示当前文件夹共有 `31 items`，且已选中 `1 item`。
- 照片查看器中打开的是一张纵向细长的蓝色闪电单帧图，黑底、白芯、外侧有蓝色 glow。

输出/预览：
- 这一帧检查说明导出结果已经成功落地为可逐帧浏览的位图序列。
- 结合前一张图的导出进度和当前 `31 items`，可确认教程导出了约 31 帧的 lightning 动画图片，用于后续逐帧播放或纹理动画流程。
这张图继续展示导出的 PNG 序列文件夹，并在照片查看器中查看另一张 lightning 单帧。字幕提到“这里就是所有这些图像”，说明教程是在确认整套 stop motion 帧已经全部生成，可供后续打包或使用。

当前可确认信息：
- 背景仍为 `Substance Player - LightningAnim.sbsar`，左侧预览保持纵向蓝色闪电，时间轴停在 `1.000 s / 30 f`。
- 资源管理器窗口仍位于 `Desktop > player`，文件夹内显示一整组 `Lightning02_Lightning02_*.png` 缩略图。
- 底部状态栏仍显示 `31 items | 1 item selected | 136 KB`。
- 中央照片查看器打开的是另一张单帧图，能看到蓝色闪电主干与几条更细的分支线，黑底、白色高亮核心、蓝色外发光结构都清晰可见。
- 缩略图区仍能可靠辨认多张连续编号文件，例如 `0006-0012`、`0019-0025`、`0026-0030`。

输出/预览：
- 当前截图强调的不是参数调节，而是导出的所有帧图已经在文件系统中可见并可逐张预览。
- 通过切换单帧查看，可以确认动画序列中的闪电形态会随帧变化，为后续做逐帧动画或 flipbook 提供基础素材。
这张图是教程结束前的 `Substance Player` 最终界面状态。外部文件预览窗口已经关闭，画面回到主播放器，左侧保留 lightning 的最终预览，右侧保留两组输出参数，说明导出与检查流程已经完成。

当前可确认信息：
- 当前资源为 `LightningAnim.sbsar`，`Graphs` 选择 `pkg:///Lightning02`。
- `Outputs` 页签可见：
  - `Lightning02`
  - `Lightning_Grayscale`
- 左侧 `2D VIEW` 中显示纵向蓝色闪电成品，黑底、白色高亮芯线、外层蓝色 glow 清晰可见。
- 时间轴停在结尾：
  - 时间 `1.000 s`
  - 帧 `30 f`
- 右侧 `PARAMETERS` 面板中：
  - `Time` 由时间轴驱动，值为 `1.000`
  - `Lightning01.Output Size = 2048 x 2048`
  - `Lightning01.Random Seed = 0`
  - `Lightning02.Output Size = 512 x 512`
  - `Lightning02.Random Seed = 0`

输出/预览：
- 这一帧可作为最终检查画面：主输出已经能稳定显示一条完整的纵向 lightning 贴图，参数也停留在最终导出配置上。
- 结合前两张图可知，本段流程已经完成从 Player 参数设置、序列导出到逐帧检查的完整闭环。

## 补充视觉证据

### S01 00:03:29

这张补充图是 `Adobe Substance 3D Designer` 中 `Trail_01 - GRAPH` 的空图表视图。右侧选中的并不是某个功能节点，而是图表根对象 `Trail_01` 的属性面板；左侧 `2D VIEW` 显示一个中心高亮、带少量尖刺的白色发光斑点预览。由于画面中央没有实际节点连线，而字幕却在讲“创建一个名为 `cross section` 的节点”，图像内容与讲解步骤没有完全对齐，因此只能记录当前截图里可确认的信息。

当前可确认信息：
- 图表标题为 `Trail_01 - GRAPH`。
- 右侧属性面板标题为 `Trail_01 - PROPERTIES`。
- `ATTRIBUTES` 区域可辨认：
  - `Identifier = Trail_01`
  - `Type = Unspecified`
- `BASE PARAMETERS` 中可见但未改动的项目包括：
  - `Output Size`
  - `Output Format`
  - `Pixel Size`
  - `Pixel Ratio`
  - `Tiling Mode`
  - `Random Seed`
- 下方面板还能看到：
  - `Physical size (cm)`
  - `Icon`
  - `Package = C:/Users/Stand1k/Desktop/Flare.sbs`
  - `Exposed in SBSAR = Yes`
  - `Show In Library = Yes`
- 左侧 `2D VIEW` 预览的是黑底上的白色发光形状，主体接近圆形光斑，左、右下方向各有一条较细的射线。
- 底部状态栏明确显示 `No output node defined`。

不确定点：
- 当前截图中没有显示 `Cross Section` 节点本体，也没有任何节点连线，无法据此转写该节点的结构或参数。
- 该白色发光预览是默认图表输出、临时缓存，还是某个未显示节点的结果，当前画面无法可靠确认。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


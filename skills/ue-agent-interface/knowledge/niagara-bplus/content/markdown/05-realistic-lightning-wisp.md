# 05 Realistic Lightning Wisp

# 05 Realistic Lightning Wisp

## 关键术语

- `Spawn`、`Alpha`、`Texture`、`Photoshop`、`Mesh`、`速度`、`Niagara`、`生命周期`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Initialize Particle`、`Lifetime`、`Color`、`Opacity`、`Renderer`

## 分段知识

### 00:00:05-00:02:36 颜色

- 本段定位：颜色。
- 知识点：大家好,在这次视频中,在一个造成了灯光的颜色,但不是在一个造成了风格的颜色,而是在一个实际的颜色。
- 知识点：首先,我们先开始设计,我们先去看我已经展示的展示。
- 知识点：我们需要什么?我们需要更细腻的颜色,像是真正的世界灯光,和我们之前所用的更加铺的颜色。
- 知识点：我们可观察到我们之前所用的颜色。
- 知识点：我们可观察到我们以前所用的灯光,用激烈的颜色,用色彩的颜色,然后现在我们需要一些更为现实的东西。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是 `05 Realistic Lightning Wisp` 章节的开场对比画面。作者先把此前做过的三种球体元素效果同时摆在场景里，作为“风格化版本”的参照，再转入这次要做的“更真实的闪电颜色”。

当前画面中可直接辨认的对象有：

- 左侧：火焰版球体
- 中间：闪电版球体
- 右侧：水球版球体

当前选中的对象仍是 `NS_Wisp_Water`。右侧 `Details` 面板可直接确认：

- `Location = (108.337, 350.0, 200.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Water`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability = 开启`

结合正文“不是风格化颜色，而是真实颜色”，这张图的作用不是讲参数，而是建立视觉基线：作者先把旧的 stylized 火焰、stylized 闪电和水元素版本摆出来，说明接下来要做的 realistic lightning 并不是重做结构，而是优先改造原有闪电版本的颜色语言，让它从高饱和、游戏化蓝色转向更贴近真实世界的电光配色。
这张图继续停留在关卡对比场景，但这次作者已经把目标明确切到闪电版本本身。当前选中对象是 `NS_Wisp_Lightning`，下方 `Content Browser` 位于 `Content / VFX_Library / Niagara / Wisps`，其中 4 个系统资源同时可见：

- `NS_Wisp_Fire`
- `NS_Wisp_Lightning`
- `NS_Wisp_Water`
- `NS_Wisp_...`（右侧还有一张同类 `Wisp` 资源卡片，但当前标签显示不完整）

其中被高亮选中的资源是 `NS_Wisp_Lightning`。右侧 `Details` 面板也能直接确认：

- `Niagara System Asset = NS_Wisp_Lightning`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability = 开启`
- `Location = (-17.718, 350.0, 200.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`

画面中间还叠加了从左向右的绿色箭头，强调作者是在用已有样例进行横向比较，而不是只孤立观察一个成品。结合字幕里“我们这里有 stylized zappers”的意思，这一步的可复建动作是：明确把 `NS_Wisp_Lightning` 作为 realistic lightning 的直接母体，先观察它与火焰、水球等 stylized 版本的差异，再在此基础上只改颜色和读感，而不是替换整个 Niagara 结构。
这张图展示的是作者在浏览器里查找真实闪电照片参考的过程。画面中打开了关键词为 `LIGHTNING` 的图片搜索结果页，右侧预览选中的是一张真实闪电照片：主体是一道高亮主电弧，从云层垂直劈向地面，沿途带有多条较细的分叉支路。

从当前截图可直接确认的参考特征有：

- 主电弧主体接近白色，而不是饱和蓝色或紫色
- 周围环境是偏灰蓝的阴天天空
- 分叉线条细、随机、长短不一
- 真实闪电的亮度集中在主干，外围分支明显更细、更弱

右侧大图预览下方还能看出作者是在多张照片里挑选“形状不错”的那一张作为参考，而不是只泛泛搜索一个“闪电”关键词就结束。结合字幕“你可以选你喜欢的那个，但我喜欢这个，形状不错”，这一步的可复建动作是：先收集一张真实闪电照片，提炼出白色主干、冷灰天空、细分叉和强弱分层这些视觉依据，作为后面把 stylized lightning 调整为 realistic lightning 的参考标准。

### 00:03:51-00:08:40 颜色

- 本段定位：颜色。
- 知识点：非常好,现在我们需要把它转成黑和白 让我们来到这里,调整成黑和白 它转成黑和白 我们先删掉这部分 这部分和这部分我们也不需要 现在需要提示我们需要的部分。
- 知识点：用颜色的线索,可以选择暗影 或者中途线索 提示,这里可以控制线线 我们按下按键,然后我们删掉 可以把Ctrl X 切掉 可以关掉它,然后放入。
- 知识点：Ctrl 5 我们删掉它,我们不需要这部分 我们把它切掉 现在需要把它删掉 需要删掉这些更多的细节 现在需要展示一些不明显的垃圾 如何让它看起来更好。
- 知识点：需要用线索,让我们这样做 到最高能看到所有细节 让我们用删掉 这些是这种线索 我们删掉它 这些可以被删掉 这里也 可以把黑和白删掉。
- 知识点：不太能看到 我们把它删掉 Ctrl Z 我删掉了 这些细节看起来很正常 现在我们看看它有没有线索 这些细节会否再次重新变化 我们需要去到View。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图展示的是作者把真实闪电照片导入 Photoshop 后的第一步整理。当前画面中，参考闪电照片已放入一个新文档，作为 `Layer 1` 覆盖在黑色 `Background` 之上，作者正通过自由变换把它缩小并调整到更适合后续处理的构图范围。

当前可直接确认的图层与界面信息如下：

- 图层面板包含：
  - `Layer 1`：闪电照片
  - `Background`：黑色底
- 当前选中的是 `Layer 1`
- 右侧 `Properties > Transform` 可见当前图层正在进行位置/尺寸变换

从画面与字幕可确认这一步的目的不是做最终颜色，而是先把参考图裁到只保留有用的闪电主干与分叉区域，减少无关天空面积。字幕同时说明“现在我们需要将其转换为黑白色调”，所以本图的可复建动作是：

- 新建一个黑底画布
- 将选中的真实闪电照片粘贴为独立图层
- 通过缩放/摆位把主体闪电放到画布中央
- 为下一步黑白化和细节清理准备更紧凑的参考构图
这张图展示的是参考闪电图完成第一次高对比提取后的中间状态。作者已经把原始照片压成接近纯黑背景，并保留亮白的主电弧与少量次级分叉。当前选中的是 `Levels 1` 调整层，右侧打开 `Levels` 面板，说明这一步的重点是通过色阶拉开亮暗差异，让闪电主体从原图中分离出来。

从截图中可以可靠确认的信息如下：

- 图层面板至少包含 `Levels 1`、`Layer 2`、`Background`
- 当前选中 `Levels 1`
- 主体结果是黑底上的白色闪电轮廓，而不是原始天空照片
- 主干电弧从画面上方向下延伸，保留了几条与主干相连的有效分叉

结合画面与字幕，这一步的可复建动作可以整理为：

- 使用 `Levels` 提升亮部并压暗背景，让闪电主干与可用分叉尽量接近纯白。
- 去掉云层纹理、背景杂色和无关亮点，避免后续贴图出现脏边。
- 用橡皮擦或手工清理方式删除不需要的细碎电弧，只保留形状明确、方向清晰的闪电轮廓。

截图里看不清 `Levels` 的具体数值，也无法可靠确认 `Layer 2` 的精确内容和混合方式，因此这里只能确认它是一次“色阶增强 + 手工清理轮廓”的处理中间结果，不能进一步写出具体参数。
这张图展示的是在黑白提取之后，对闪电主体做手工加固的阶段。画面中央已经不是原始照片，而是一条黑底上的高亮白色闪电贴图雏形：主干被明显加粗，下半段亮度更强，边缘还保留少量细分叉。当前图层面板中选中的是 `Layer 2`，`Background` 为黑色底，说明作者正在直接处理已经提取出来的闪电形状，而不是继续调整原始参考图。

从截图中可可靠确认的结果与操作意图如下：

- 主闪电干线已经被处理成一条更连续、更实心的白色形状。
- 中下段增加了更亮、更粗的核心发光区，用来强化主能量通道。
- 仍保留少量贴着主干延伸的细分叉，使轮廓不会过于僵硬。
- 当前有一个较大的圆形笔刷范围停在主干右侧，结合字幕“让它变得更坚实”“再次做偏移”，可确认作者正在手工补强主体，并继续调整闪电边缘与亮部结构。

按这一步可复建的处理目标，应当是：

- 在黑底上把已经提取出的主电弧继续修整为更完整的白色主体。
- 手工增强主干粗细与局部亮斑，让最终贴图既有中心能量感，又保留自然闪电的细小分支。
- 通过再次偏移、修边或局部重绘，避免主干出现断裂、空洞或亮度不均。

截图无法可靠辨认当前具体使用的是哪一种绘制/涂抹工具，也看不清详细笔刷参数，因此这里只记录可确认的视觉结果和编辑意图，不补写不确定的工具名称或数值。

### 00:08:40-00:13:31 颜色

- 本段定位：颜色。
- 知识点：需要把它硬化 我再次删掉 它可能会在-2024的同一位置 把它重新删掉 在本体上没有区别 我们再看看 现在这些细节很正常 很棒,我非常喜欢。
- 知识点：按下Pattern Preview 可能再按下背景亮度 按下层面键 然后按下外光 我们再按下灯光 大小让传染器更小 传染器很低 可以把传染器转掉。
- 知识点：再加更多的传染器 非常好 虽然Ctrl Z会回归 但需要传染器的大小会更小 我可能会把传染器调低 它太亮了 52 非常好 我们把它放在这里 可以保留这个部分。
- 知识点：我们做个阻碍 现在我们把它放在这里 在在珍珠前 我们需要把它转成8bit 并不是16bit 而是8bit 只是它在16bit上更好 在8bit上更好。
- 知识点：我们再按下Export 按下Export 选择一个方案 让它更方便 给它一个名字 然后按下拨 现在我们去到测试设计 我们把我们做的颜色转移。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图展示的是作者把已经提取好的闪电黑白贴图做无缝重复准备的步骤。当前在 Photoshop 中选中 `Layer 2`，画面里同一条闪电已经在横向与纵向重复出现，顶部菜单打开到 `Filter > Other > Offset`，说明作者准备通过偏移滤镜把图像内容移动到新位置，再处理拼接缝。

从截图中可以可靠确认的信息如下：

- 图层面板只保留 `Layer 2` 与黑色 `Background`
- 当前操作对象是白色闪电贴图，不再是原始照片
- 画布中出现规则重复的多份闪电，说明作者正在检查平铺后的边界连接效果
- 中央有一个竖向矩形选区，用来观察或限定当前需要处理的主区域
- 菜单明确停留在 `Filter > Other > Offset`

按这一步可复建的处理目标，应当是：

- 对已经清理完成的闪电贴图应用 `Offset`，把原本在边缘的内容移动到画布中央。
- 观察偏移后产生的接缝、断裂和重复痕迹，为后续手工修边做准备。
- 保持黑底白电弧的基本形状不变，只调整内容在画布中的分布，使其更适合做可重复纹理。

截图中看不到 `Offset` 对话框里的具体位移数值，因此不能可靠补写精确偏移量；这里只记录可以直接确认的菜单路径、图层状态和处理目的。
这张图展示的是闪电贴图在完成偏移与修边后的定稿检查状态。画面中央只保留一条竖向闪电，黑底干净，主干与分叉关系已经稳定。图层面板显示当前选中的是 `Layer 2`，其下已经挂有 `Effects > Outer Glow`，说明作者在黑白主体之外又叠加了一层外发光来强化边缘能量感。

从截图中可以可靠确认的信息如下：

- 图层结构为 `Layer 2` + `Background`
- `Layer 2` 已添加 `Outer Glow`
- 当前可见结果是一条单独的白色闪电贴图，而不是重复平铺预览
- 主干从画面上边缘延伸到底部，右侧分叉比左侧更明显

结合画面与字幕“先保留这一部分，然后做栅格化”，这一步可以整理为：

- 在确认闪电主体与发光效果达到可接受状态后，先保留当前版本。
- 给闪电层添加 `Outer Glow`，让白色主干周围出现更柔和的亮边。
- 在继续输出或导出前，准备把带图层样式的结果执行栅格化，转换成可直接保存的最终位图内容。

截图中无法可靠辨认 `Outer Glow` 的颜色、尺寸、扩展值或混合模式，因此这里只记录“已添加外发光并准备栅格化”的确定信息，不补写具体参数。
这张图展示的是把 Photoshop 中整理好的闪电贴图导入 Substance 3D Designer，并通过 `Shape Mapper` 节点把单条闪电分布到圆形边界上的阶段。当前 `2D View` 里可以看到一个由闪电轮廓围成的大致圆环，说明作者正在把线状纹理映射成围绕中心展开的形状。

节点定义集：

- `Bitmap`
  - 作用：导入外部闪电贴图，作为后续映射的输入源。
  - 缩略图可见内容：黑底上的单条竖向白色闪电。
  - 节点分辨率标注：`1024x2048 - L8`。
- `Transformation 2D`
  - 作用：对导入的闪电贴图做二维变换后再送入映射节点。
  - 缩略图可见内容：闪电已被重新摆放到更适合横向铺开的状态。
  - 节点分辨率标注：`2048x2048 - L8`。
- `Shape Mapper`
  - 作用：把输入图案按指定形状重复分布。
  - 当前选中节点名称：`shape_mapper`。
  - 节点分辨率标注：`2048x2048 - L16`。
  - `2D View` 结果显示闪电被排布成一个近似圆形边界。

连线集：

- `Bitmap` 输出连接到 `Transformation 2D` 输入。
- `Transformation 2D` 输出连接到 `Shape Mapper` 输入。

设置/参数：

- 当前右侧属性面板显示的是 `shape_mapper` 节点。
- `Tiling Mode`：`H and V Tiling`。
- `Random Seed`：`0`。
- `Category`：`Generator`。
- `Author`：`Adobe`。
- `Package` 路径可见为 Adobe Substance 3D Designer 自带的 `shape_mapper.sbs` 资源包。
- `Instance Parameters` 中可辨认到以下字段：
  - `Shape = Circle`
  - `Pattern Amount = 6`
  - `Radius = 0.25`
  - `Width = 1`
  - `Rotation = 0`
  - `Flip one on two = True`

输出/预览：

- 左上 `2D View` 预览显示，闪电纹理被复制并排布成围绕中心的一圈轮廓，中央留黑。
- 下方 `3D View` 仍是默认立方体预览，当前主要关注的是 2D 纹理分布结果，而不是材质球或模型表现。
- 这一阶段的目标是把单条闪电转成可围绕圆周重复的纹理图案，为后续制作环状闪电或能量边缘做准备。

### 00:13:31-00:15:46 关键流程 04

- 本段定位：关键流程 04。
- 知识点：就是它非常曲 因此 它并不是很正确的形状 需要要它是圆形 所以我们先修理一下 开始的时候 可以加上异形 可以加上形状 不,不是异形 需要形状。
- 知识点：这种一种平衡 转变 可以直接减少它 我们也可以把它做成一种 这样它不会浮动 可以加上异形 没有异形 然后我们加上异形 这里 现在可以做到。
- 知识点：所有的事情都很好 或者不是这样 可以加上异形 有的,有的 可以加上异形 我们看看这里 已经看起来很棒了 这里有几个详细 可能这个部分。
- 知识点：甚至可以减少一点 这就是这里的一件事 我们做的就是这件事 只要我们把它编辑一点 需要有另一个异形 这里的形状会更小 转变 我们只需要 改变方向。
- 知识点：现在它会减少了一条线 所以当然 这里没有做很好的事情 可以做 这种一件事。

**关键画面：**

这张图展示的是作者在 Substance 3D Designer 中检查闪电环形分布结果，并定位“形状过弯、不够圆”的问题。当前选中的是 `Transformation 2D` 节点，左上 `2D View` 里能看到由闪电围出的轮廓偏向不规则多边形，说明作者正在通过前置变换节点修正进入 `Shape Mapper` 之前的纹理方向与比例。

节点定义集：

- `Bitmap`
  - 作用：输入单条闪电贴图。
  - 分辨率标注：`1024x2048 - L8`。
- `Transformation 2D`
  - 作用：在进入 `Shape Mapper` 之前调整纹理的旋转、拉伸、镜像和偏移。
  - 当前选中节点：`Transformation 2D`。
  - 分辨率标注：`2048x2048 - L8`。
- `Shape Mapper`
  - 作用：把输入纹理排布成圆周形边界。
  - 分辨率标注：`2048x2048 - L16`。

连线集：

- `Bitmap` 输出连接到 `Transformation 2D` 输入。
- `Transformation 2D` 输出连接到 `Shape Mapper` 输入。

设置/参数：

- 当前右侧属性面板显示 `Transformation 2D - PROPERTIES`。
- 可可靠辨认的参数状态：
  - `Output Size`：`Width = 1`、`Height = 0 (Input x 1)`
  - `Pixel Size`：`Width = 1`、`Height = 1`
  - `Tiling Mode = H and V Tiling`
  - `Random Seed = 0`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
  - `Offset X = 0`
  - `Offset Y = 0`

输出/预览：

- `2D View` 结果显示闪电边界已经形成闭环，但整体轮廓偏弯、偏瘪，不是理想的圆形。
- 这一帧的重点不是最终效果，而是确认问题来源：当前前置变换仍让输入纹理以不合适的形态进入 `Shape Mapper`，所以作者接下来需要继续修正形状参数。
这张图展示的是作者为了解决环形轮廓不够圆的问题，在原有 `Bitmap -> Transformation 2D -> Shape Mapper` 主链之外，增加一组基于圆形遮罩的变形分支，并改为使用 `Directional Warp` 去推动闪电纹理。左上 `2D View` 当前显示的是 `Directional Warp` 的结果预览，能看到一条被横向拉直、局部起伏的闪电线，说明作者正在先把单条纹理修整成更适合映射到环形边界的基础形态。

节点定义集：

- `Bitmap`
  - 作用：输入原始闪电贴图。
  - 分辨率标注：`1024x2048 - L8`。
- 上方 `Transformation 2D`
  - 作用：作为主纹理输入的前置二维变换节点。
  - 分辨率标注：`2048x2048 - L8`。
- `Shape Mapper`
  - 作用：保留原有的环形分布结果，作为对照或后续连接节点。
  - 分辨率标注：`2048x2048 - L16`。
- `Shape`
  - 作用：生成圆形/径向遮罩，用来为变形提供强度图。
  - 缩略图显示为中心亮、边缘暗的圆形渐变。
  - 分辨率标注：`2048x2048 - L16`。
- 下方 `Transformation 2D`
  - 作用：调整 `Shape` 生成的圆形遮罩位置或比例后，送入变形节点。
  - 分辨率标注：`2048x2048 - L16`。
- `Directional Warp`
  - 作用：利用一张驱动图去推拉上方闪电纹理，使其得到新的走向和弯曲方式。
  - 当前选中节点：`Directional Warp`。
  - 分辨率标注：`2048x2048 - L8`。

连线集：

- `Bitmap` 输出连接到上方 `Transformation 2D` 输入。
- 上方 `Transformation 2D` 一路连接到 `Shape Mapper` 输入。
- `Shape` 输出连接到下方 `Transformation 2D` 输入。
- 上方 `Transformation 2D` 输出连接到 `Directional Warp` 的主输入。
- 下方 `Transformation 2D` 输出连接到 `Directional Warp` 的强度/驱动输入。

设置/参数：

- 当前右侧属性面板标题为 `Warp - PROPERTIES`，但具体数值在截图中不可辨认。
- 可以可靠确认作者当前正在调的是 `Directional Warp` 节点，而不是 `Shape Mapper`。
- 下方新增分支的核心目的，是用圆形形状场去影响闪电纹理的弯曲与分布，而不是仅靠 `Shape Mapper` 的图案排布参数。

输出/预览：

- `2D View` 中的 `Directional Warp` 结果是一条更横向、更稳定的闪电线段，说明当前变形已经把原先过弯的输入纹理重新整理。
- 这一步的目标是先把单条闪电修到更适合做圆周映射的状态，再继续回到环形结果里检查整体外轮廓。
这张图展示的是作者在第一层 `Directional Warp` 之后，再叠加第二层变形，并把驱动用的圆形遮罩缩小、偏移，以进一步修正闪电线条的弯曲方式。左上 `2D View` 仍显示一条横向闪电线，但画面里已经出现一个矩形编辑框，说明当前正通过 `Transformation 2D` 直接在 2D 视图里调整驱动形状的位置与范围。

节点定义集：

- 第一组主链：
  - 上游 `Transformation 2D` 输出接入第一个 `Directional Warp`，用于生成第一版被推拉后的闪电线。
- 第二组驱动链：
  - `Shape`
    - 作用：提供圆形渐变遮罩。
    - 分辨率标注：`2048x2048 - L16`。
  - 下方 `Transformation 2D`
    - 作用：把圆形遮罩进一步缩小、平移，作为第二层变形的驱动图。
    - 当前选中节点：下方 `Transformation 2D`。
    - 分辨率标注：`2048x2048 - L16`。
- 第二个 `Directional Warp`
  - 作用：接收上一层闪电结果，并用缩小后的圆形驱动继续做二次推拉修正。
  - 分辨率标注：`2048x2048 - L8`。

连线集：

- 第一层 `Directional Warp` 的输出连接到第二个 `Directional Warp` 的主输入。
- `Shape` 输出连接到下方 `Transformation 2D` 输入。
- 下方 `Transformation 2D` 输出连接到第二个 `Directional Warp` 的驱动输入。
- 第二个 `Directional Warp` 的输出继续送往右上方的后续结果节点。

设置/参数：

- 当前右侧属性面板显示的是下方 `Transformation 2D - PROPERTIES`。
- 可可靠辨认的参数状态：
  - `Output Size`：`Width = 0 (Input x 1)`、`Height = 0 (Input x 1)`
  - `Pixel Size`：`Width = 1`、`Height = 1`
  - `Tiling Mode = No Tiling`
  - `Random Seed = 0`
  - `Rotation Angle = 0.00`
  - `Stretch Width = 100.00%`
  - `Stretch Height = 100.00%`
- 右侧偏移参数可见已不是零值，说明作者确实把驱动圆形从默认中心位置挪开；但具体小数值在截图中不够稳定，不适合当作精确参数抄写。

输出/预览：

- `2D View` 中的横向闪电线保持主干连续，同时局部弯折与分叉位置正在通过第二层变形细调。
- 这一阶段的核心目标是通过“更小的驱动形状 + 额外一层 warp”来控制闪电局部区域的受力方向，让最终环形轮廓更自然、更接近目标圆形。

### 00:16:40-00:19:56 关键流程 05

- 本段定位：关键流程 05。
- 知识点：可以把它 编辑成编辑 可以做这种一件事 可能是一条线 可以把这个异形 编辑成8 这样它会在边缘更暗 但我真的不喜欢 我喜欢编辑。
- 知识点：需要编辑成这样 看看这个结果 这个现象 基本上并不是很大 我已经看到了 这里会有一点点 现在我们只需要 把这个变化 在这里的方向 进行编辑 这是这种。
- 知识点：这是发生的 他们编辑了一点点 他们编辑了一点点 把编辑的详细部分 从边缘编辑起来 这样它就不会变得更少了 这是我们的形状 现在你们可观察到。
- 知识点：它是怎样的 把编辑放在编辑中 把编辑放在编辑中 把这个蓝色的编辑放在这里 把这个蓝色的编辑放在这里 就这样 这样 这就是 蓝色的编辑 蓝色的编辑。
- 知识点：蓝色的编辑 蓝色的编辑 现在可以 把这个编辑 放在一个像灯光的样子 完全的样子 我们还是需要 可能更可恶 这就是所有的 调节并增加了编辑 调节并增加了编辑。

**关键画面：**

这张图展示的是作者在 Substance 3D Designer 中，开始给已经整理好的横向闪电线添加梯度控制，以便让边缘逐渐变暗或收窄。当前选中的是一个 `Blend` 节点，右侧属性面板标题为 `Blend - PROPERTIES`；中间搜索框里输入了 `grad`，并弹出了多个梯度节点候选，说明作者正准备插入一张梯度图，再把它与闪电结果相乘或混合。

节点定义集：

- `Bitmap`
  - 作用：输入原始闪电贴图。
  - 分辨率标注：`1024x2048 - L8`。
- `Transformation 2D`
  - 作用：把输入闪电调整成横向分布的基础形态。
  - 分辨率标注：`2048x2048 - L8`。
- `Blend`
  - 作用：把上游闪电结果与一张新加入的梯度图混合，用于控制亮度或遮罩强度。
  - 当前选中节点：`Blend`。
  - 分辨率标注：`2048x2048 - L8`。
- `Directional Warp`
  - 作用：接收 `Blend` 处理后的结果继续做后续变形。
  - 分辨率标注：`2048x2048 - L8`。
- 下方 `Transformation 2D`
  - 作用：保留此前用于驱动形状的圆形遮罩变换分支。
  - 分辨率标注：`2048x2048 - L16`。

连线集：

- `Bitmap` 输出连接到上方 `Transformation 2D` 输入。
- 上方 `Transformation 2D` 输出连接到 `Blend` 的一个主输入。
- `Blend` 输出连接到右侧 `Directional Warp` 的主输入。
- 下方 `Transformation 2D` 输出继续连接到 `Directional Warp` 的驱动输入。
- 当前正在为 `Blend` 的另一输入补一张梯度节点。

设置/参数：

- 当前右侧可可靠辨认的 `Blend` 参数：
  - `Opacity = 1`
  - `Blending Mode = Copy`
- 搜索候选列表中可见：
  - `Gradient Map`
  - `Gradient (Dynamic)`
  - `Gradient Axial`
  - `Gradient Axial Reflected`
  - `Gradient Circular`
  - `Gradient Linear 1`
  - `Gradient Linear 2`
  - `Gradient Linear 3`
  - `Gradient Radial`
- 结合字幕“把它乘以梯度”，当前步骤的核心不是最终参数，而是确定将通过梯度图来衰减闪电某些边缘区域。

输出/预览：

- 左侧 `2D View` 当前几乎是全黑，说明 `Blend` 还处在接线/选节点阶段，最终可见结果尚未形成。
- 这一步的目标是为闪电线增加一张可控的梯度遮罩，使其后续在边缘能够自然变暗，而不是整条线亮度完全一致。
这张图展示的是作者把闪电环形结果接到 `Gradient Map`，并在渐变编辑器里为闪电选择蓝白色系配色。左上 `2D View` 已经显示出一圈带冷蓝边缘和亮白高光的闪电环，说明这一步不再只是做明暗衰减，而是开始确定最终电流颜色。

节点定义集：

- `Shape Mapper`
  - 作用：输出环形排布后的闪电轮廓。
  - 左侧图中可见该节点缩略图为闭环闪电形状。
- `Gradient Map`
  - 作用：把输入的灰度闪电结果重新映射成带颜色的电弧。
  - 当前选中节点：`Gradient Map`。

连线集：

- 上游环形闪电结果输出连接到 `Gradient Map` 输入。
- `Gradient Map` 输出直接驱动左上 `2D View` 中的蓝白闪电环预览。

设置/参数：

- 当前右侧属性面板标题为 `Gradient Map - PROPERTIES`。
- 可可靠确认的属性状态：
  - `Color Mode = Color`
  - `Gradient Addressing = Clamp`
- 当前打开了 `Gradient Editor`，其中的渐变条从左到右可见：
  - 黑色起点
  - 深蓝到亮蓝的中间过渡
  - 接近白色的高亮终点
- 正在编辑的一个颜色键可辨认到：
  - `Position = 0.590`
  - 颜色十六进制值约为 `#0094ff`
  - 通道读数可见 `R = 0`、`G = 148`、`B = 255`

输出/预览：

- `2D View` 结果显示，环形闪电外轮廓已经具备典型冷色闪电效果：主体以浅蓝和白色为主，边缘仍保留黑底。
- 这一步的目标是把此前的黑白电弧转成偏蓝的能量环，为后续叠加更强的发光或颜色层次做准备。
这张图展示的是作者在蓝白配色完成后，再接一个 `Glow` 节点增强外发光，使闪电环看起来更像真实能量体。左上 `2D View` 已经能看到一圈带柔和蓝色辉光的闪电环：中心仍为空洞，外侧有明显的蓝色晕光扩散。

节点定义集：

- `Shape Mapper`
  - 作用：提供最基础的环形闪电轮廓。
  - 分辨率标注：`2048x2048 - L16`。
- `Gradient Map`
  - 作用：把灰度轮廓映射成蓝白色闪电。
  - 分辨率标注：`2048x2048 - C16`。
- `Glow`
  - 作用：在已有颜色基础上添加柔和的外发光与能量晕染。
  - 当前选中节点：`Glow`。
  - 分辨率标注：`2048x2048 - C16`。

连线集：

- `Shape Mapper` 输出连接到 `Gradient Map` 输入。
- `Gradient Map` 输出连接到 `Glow` 输入。

设置/参数：

- 当前右侧属性面板标题为 `glow - PROPERTIES`。
- 可可靠确认的属性信息：
  - `Category = Filter`
  - `Author = Adobe`
  - `Package` 来自 Adobe Substance 3D Designer 自带的 `glow.sbs`
- `Instance Parameters` 中可辨认到：
  - `Glow Amount = 1`
  - `Clear Amount = 0.08`
  - `Glow Size = 11.26`
- 下方还有颜色控制条，当前发光颜色与结果一致，偏冷蓝色。

输出/预览：

- `2D View` 结果显示闪电环不再只是硬边蓝白线条，而是在线条外侧叠加了一圈柔和蓝辉光。
- 字幕同时提到“直接导出”“做成 8-bit”，说明这一帧已经接近贴图制作收尾阶段：先用 `Glow` 做出最终观感，再准备导出为可用于后续流程的位图资源。

### 00:20:06-00:24:54 Texture、Photoshop、颜色

- 本段定位：Texture、Photoshop、颜色。
- 知识点：SRGB 他们急着编辑 它把所有东西 都编辑给我们 我们把它叫成 我认为是 Texture Lightning Ring 这个名字很不错 现在我们把它。
- 知识点：放在Unreal Engine上 是的,我们去到Unreal Engine 我们把这个模式 放在这里 我们得到了 这样一个美丽的颜色。
- 知识点：可能你还是 可以把光线放在这里 需要想 这不是问题 光线可以把 黑和白的颜色都放在这里 光线的灰色 明显的 光线的尺寸 比较小 这就是这种办法。
- 知识点：我认为 这方法一定会 更好 再重新购买 是的,这里我已经 重新编辑了 可观察到 这些链子上 有更多的亮面 在这里 也就是这些线条 在这里 在这里 在这里。
- 知识点：在这里 在这里 在这里 在这里 在这里 在这里 在这里 可以去Photoshop 并调整这些线条 一点点 我喜欢它 是一个这种亮面 我们需要做什么。
- 知识点：这是 这里的详细 需要从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方 从上方。
- 知识点：从上方 从上方 从上方 在 在 在 在 在 在 在 在 在 在 在 在 在 在 在 在 在 在。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Texture`、`Photoshop`、`颜色`。

**关键画面：**

这张图展示的是作者在 Substance 3D Designer 中整理最终输出节点，并把纹理图准备为可导出的 8-bit 结果。左上 `Output - 2D View` 里显示的是黑底白色闪电环，说明当前选中的输出结果不再是中间节点，而是准备用于导出的最终贴图版本。

节点定义集：

- 上方 `Gradient Map`
  - 作用：一条上游颜色处理分支，当前仍连接到 `Glow`，但未直接接到最终输出。
- `Glow`
  - 作用：上游发光增强节点，保留在图中作为另一种输出候选。
- 下方 `Gradient Map`
  - 作用：生成当前直接送往最终导出节点的闪电环结果。
  - 节点分辨率标注：`2048x2048 - C8`。
- `output`
  - 作用：最终输出节点。
  - 当前接收的是下方 `Gradient Map` 的结果。
  - 节点分辨率标注：`2048x2048 - C8`。

连线集：

- 下方 `Gradient Map` 输出连接到 `output` 输入。
- 上方 `Gradient Map` 输出连接到 `Glow` 输入。
- `Glow` 当前未直接接入最终 `output`。

设置/参数：

- 当前右侧属性面板显示的是 `Substance_graph - PROPERTIES`。
- 可可靠辨认的全局图参数：
  - `Output Format = 8 Bits per Channel`
  - `Pixel Size`：`Width = 1`、`Height = 1`
  - `Tiling Mode = H and V Tiling`
  - `Random Seed = 0`
- 左下资源区可见已导入资源名 `Lightning1`。

输出/预览：

- `2D View` 中的最终输出是黑底白色闪电环，而不是蓝色发光版，说明作者正在为不同用途整理独立输出，当前这一张更像基础贴图或速度图。
- 字幕明确提到“现在我们导出它”“速度贴图”，可确认这一帧的重点是把图整理成合适的导出格式，而不是继续调形状。
这张图展示的是作者把导出的闪电贴图重新放回 Photoshop 进行检查或二次整理。当前画面中央是一张黑底白色单条闪电贴图，文档标签显示为 `RGB/8`，右侧图层面板只有一个 `Layer 0`，说明这已经不是带多层效果的工作稿，而是导出的扁平结果图。

从截图中可以可靠确认的信息如下：

- 当前文档处于 `RGB/8` 模式。
- 画布中央只有一张竖向黑底闪电图，尺寸比例明显高于宽度。
- 图层面板仅保留 `Layer 0`，没有额外调整层、混合层或样式层。
- 右侧 `Properties > Transform` 可见图层基础变换信息，但没有正在进行的复杂编辑。

按这一步可复建的处理目标，应当是：

- 将在 Substance Designer 中导出的闪电基础贴图重新导入 Photoshop。
- 以单层扁平图方式检查整体亮部结构、分叉密度和黑底干净程度。
- 为后续手工微调线条、补亮面或整合到 UE 贴图资产做准备。

当前这一帧没有显示明确的笔刷动作或图层操作，因此只能确认它是“导出后回到 Photoshop 检查基础闪电贴图”的阶段，不能补写不存在的具体修改步骤。
这张图展示的是把新闪电贴图接回 Unreal Engine 的 Niagara 系统后进行实时检查。当前打开的系统是 `NS_Wisp_Lightning_Realistic`，左侧预览窗口里能看到一条蓝白色闪电精灵已经出现在场景中，但字幕说明“它们生成后相对于中心发生了旋转”，说明作者此时在排查贴图朝向或精灵旋转的问题。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前可见的发射器包括：
  - `Center_Lightnings`
  - `Center_Flash...`（标题右上区域可见，完整名被截断）
  - `Smoke_Main`
  - `Sphere_Lightning`
- 时间轴轨道中还能看到：
  - `Center_Flashes`
  - `Center_Lightnings`
  - `Glow_Center`
  - `Glow_Main`
  - `Lightning...`（后续若干轨道名被截断）

当前重点发射器 `Center_Lightnings` 的可见模块：

- `Emitter State`
- `Spawn Rate`
- `Initialize Particle`
- `Particle State`
- `Scale Sprite Size`
- `Sprite Rotation Rate`
- `Solve Forces and Velocity`
- `Sub UV Animation 001`
- `Sprite Renderer`

可确认的问题与定位：

- 左侧预览中的闪电并非围绕中心形成正确的目标姿态，而是以单条竖向精灵形式出现。
- 字幕明确指出问题与“生成后发生旋转”有关，因此当前排查重点落在精灵朝向、初始旋转或旋转更新模块，而不是贴图内容本身。
- 结合堆栈中可见模块，最优先需要核对的是：
  - `Initialize Particle` 中的初始旋转/朝向相关设置
  - `Sprite Rotation Rate`
  - `Sprite Renderer` 的对齐方式与材质绑定

预览结果：

- 新贴图已经成功接入 Niagara 并能正常显示亮度与颜色。
- 当前剩余问题是发射出来后的方向/旋转不符合预期，因此下一步应继续在发射器模块里修正朝向逻辑，而不是回头重做纹理。

### 00:24:54-00:27:58 关键流程 07

- 本段定位：关键流程 07。
- 知识点：需要把它半點改变,那就是 现在它在中间的位置 需要把它移到旁邊 现在我们看到它從中间变成了 这就是有趣的,在基本上,它是在这點 但只要再给它一点时间,0.2,0.3。
- 知识点：让它活着 分析在 基本上,好嗎? 可能需要变得现實化 可能需要把它在中间变得更亮 这樣它会变得更亮 我们立刻把它放在一个模式的层面上 这些是它们会站出来的。
- 知识点：只要把它变得獨特,需要随机地把XY鏡頭鏡頭 这里 这就是它的配合会随机地回復 这会很棒 它仍然有些随机 例如可以把它移动一点 我看到它是这个样子,0.9相關的。
- 知识点：好棒,好棒 是的,它会重新重新重新回復 在基本上,需要把它離開 確保,甚至是抄襲 是的,需要回復 需要把这个时刻剪輯出来 我只会增加的地方是这里的重量。
- 知识点：这是第一点 雖然有更多的,但可以把它做成这樣 这是光线中心 需要把它放在中间,对嗎? 0.0相關的 这是它们会被生存的情况 让它在中间,因为需要有这樣的效果。

**关键画面：**

这张图展示的是作者在 Niagara 的 `Center_Lightnings` 发射器中，检查 `Sprite Renderer` 参数，试图把闪电的视觉起点从中心移向一侧。左侧预览里闪电仍然像是从中间竖直长出；字幕明确提到“沿着 Y 把它移到旁边”，说明当前排查重点是精灵的对齐和枢轴，而不是贴图内容。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Center_Lightnings`
- 当前展开并选中的渲染模块：`Sprite Renderer`
- 该发射器可见模块仍包括：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Solve Forces and Velocity`
  - `Sub UV Animation 001`
  - `Sprite Renderer`

`Sprite Renderer` 可确认参数：

- `Material = MI_Lightning_Blue_01`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 1.0)`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Sub Image Size = (1.0, 1.0)`
- `Cast Shadows = 开启`
- `Sort Order Hint = 14`

当前问题与定位：

- 预览中的单条闪电仍以中心区域为主要出发点，不符合“偏向一侧生成”的目标。
- 当前最直接可调的证据是 `Default Pivot in UV Space = (0.5, 1.0)`，其中 X 仍居中；若要让视觉起点偏向一侧，优先需要继续调整枢轴或配合粒子位置偏移。
- 因为 `Alignment` 和 `Facing Mode` 都仍是 `Automatic`，若后续朝向异常持续，也需要结合这两个自动模式一起核对。
这张图展示的是作者在 `Center_Lightnings` 发射器层面调整整体发射节奏，以保留当前较满意的一帧形态，并通过提高生成密度让中心闪电更饱满。左侧预览里已经不再是单条闪电，而是多条蓝白电弧从中心区域向四周拉开，说明此时已经从单精灵排查转向整体构图调密度。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Center_Lightnings`
- 当前右侧显示的是发射器级参数，而不是单个渲染器参数

`Center_Lightnings` 可确认参数：

- `Local Space = 开启`
- `Interpolated Spawning = 开启`
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Life Cycle Mode = System`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`
- `Scalability Mode = System`
- `Spawn Rate = 25.0`
- `Spawn Probability = 1.0`

当前调整意图：

- 字幕明确说明“我会复制这个时刻，唯一会增加的是这里的生成率”，可确认作者对当前闪电分布基本满意，主要想保留这一瞬间的视觉结构。
- 提高 `Spawn Rate` 的目标是让中心区域闪电数量更多、亮面更丰富，而不是改变单条闪电的贴图或颜色。
- 由于 `Local Space` 已开启，发射器中的闪电会相对本地中心组织，这也符合“让中心区域更满”的处理方向。

预览结果：

- 当前预览已呈现一个更接近成型的中心爆裂状闪电簇，多条线从中心向左右和下方散开。
- 下一步如果继续增强密度，需要同步观察中心是否过曝，以及单条闪电之间是否出现过多重叠。
这张图展示的是作者开始单独配置新的辉光/闪电环发射器层，用来补足主闪电之外的环状能量感。当前选中的是 `Glow_Main` 发射器，左侧预览正在 `Compiling...`，说明这一步刚做完调整并触发了重新编译，暂时还没有稳定的可视化结果。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Glow_Main`
- 同时可见的相关发射器包括：
  - `Glow_Center`
  - `LightningRing_Main`
  - 时间轴中还可见 `Center_Lightnings`、`Center_Lightnings001`

`Glow_Main` 可确认参数：

- `Local Space = 开启`
- `Interpolated Spawning = 开启`
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Life Cycle Mode = System`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`
- `Scalability Mode = System`
- `Spawn Rate = 4.0`
- `Spawn Probability = 1.0`
- `Lifetime = 0.5`
- `Color Mode = Direct Set`

当前调整意图：

- 字幕明确提到“也会有闪电，闪电环。现在我们设置一个新的闪电环”，可确认作者正在补一层新的环状闪电/辉光效果，而不是继续改 `Center_Lightnings`。
- 选中 `Glow_Main` 而不是 `LightningRing_Main`，说明这一层更偏向发光主体或外晕支撑层，随后可能再和独立的闪电环发射器配合。
- 当前 `Spawn Rate` 明显低于前一张 `Center_Lightnings` 的密度，符合“作为补光/补层次的次级发射器”定位。

预览结果：

- 因为系统正在编译，这一帧不能可靠判断最终环状闪电的形态。
- 但从发射器命名、时间轴结构和字幕目的可以确认：这一阶段是在为主闪电之外新增 `Glow_Main` / `Glow_Center` / `LightningRing_Main` 这类辅助层，构建更完整的中心闪电环效果。

### 00:28:01-00:32:38 Alpha、速度

- 本段定位：Alpha、速度。
- 知识点：我们创建的,是的 在基本上,它会很合適 需要把这里和这里換成 是的,我看到这里有兩顆 需要有兩顆球 现在需要展示它能做得到 这些是我们把所有的光线圈。
- 知识点：都換成了 我们先去看結果 是比較好,是的 但我们先去看 首先,这顆会是主要的 首先,它不太堅強,是的 我还是想让它的alpha更漂亮 这是第一。
- 知识点：第二,它很快就轉動了 150,150,很多更多的都出生了 它们的时间变得更少了 0.1,0.2 这是一个完全不同的問題 而且是它的大小。
- 知识点：,它明顯需要 变得更大一点,才能做到110 是的,它们有了 其實我剛才發现 我到錯了一步 是的,需要快速地过 在需要的一顆 现在需要比較它们。
- 知识点：让我把它们換成这樣 这顆会在这里,这顆在这里 让它们更接近 看 Bisokimi,好 现在我们需要一点 这里的角度 是的,它有了大小 我们还是需要调整它到90。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`速度`。

**关键画面：**

这张图展示的是作者开始配置 `LightningRing_Main` 发射器，用新的环形闪电材质替换原有层，并准备让场景里同时出现两个环。字幕明确提到“这里和这里替换”“我实际上看到了两个它们”，说明当前目标是把两个相关发射器都切换到环形闪电贴图，而不是只保留一个。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`LightningRing_Main`
- 画面中同时可见两个同名/相近的环形相关发射器卡片：
  - `LightningRing_Main`
  - `LightningRing_Main_`（名称尾部被截断，只能确认是另一份近似同名环形发射器）
- 右侧展开并选中的模块：`Sprite Renderer`

`Sprite Renderer` 可确认参数：

- `Material = MI_Lightning_Ring_02`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Cast Shadows = 开启`
- `Sort Order Hint = 16`

当前调整意图：

- 将环形发射器的材质明确切换为 `MI_Lightning_Ring_02`。
- 保持环形精灵的枢轴在中心 `0.5, 0.5`，便于围绕中心点做旋转或缩放。
- 因为字幕提到会有两个，所以这一帧的重点是把两个相关发射器都替换到统一的环形材质方案。

预览结果：

- 左侧预览仍在 `Compiling...`，当前帧还不能可靠判断两个环叠加后的实际形态。
- 但从命名、材质切换和字幕目的可以确认：这是“把主环层替换成新的闪电环材质，并准备双环叠加”的配置步骤。
这张图展示的是作者回到 `Center_Lightnings` 发射器的 `Initialize Particle` 模块，直接调粒子的寿命、尺寸、旋转与随机 UV，用来修正本段提到的 alpha 观感和转动过快问题。右侧参数已经展开到粒子初始化级别，能看到一组较短寿命和中等尺寸的随机设置。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Center_Lightnings`
- 旁边可见一个对照/变体发射器：`Center_Lightnings_02`
- 当前选中模块：`Initialize Particle`

`Initialize Particle` 可确认参数：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.2`
- `Lifetime Max = 0.3`
- `Color Mode = Direct Set`
- `Position Mode = Simulation Position`
- `Ribbon Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 25.0`
- `Uniform Sprite Size Max = 35`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Random X / Y`
- `Mesh Scale Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

当前调整意图：

- 通过把寿命压到 `0.2-0.3` 秒，让闪电更短促，避免停留太久。
- 用 `25-35` 的随机统一尺寸控制单条闪电的视觉大小，使中心闪电既不会太细，也不会过分撑满画面。
- 使用随机旋转和随机 UV，打散重复感，减少同一贴图反复出现时的机械感。

与本段主题的对应关系：

- 字幕里提到 alpha 需要更好看、旋转太快、寿命变少、尺寸需要更大，这些都与当前 `Initialize Particle` 面板中可见的寿命、尺寸、旋转设置直接对应。
- 当前帧没有展开材质图，所以 alpha 本身更可能通过材质或颜色/尺寸共同感知；而这里主要是在粒子侧先把节奏和形体控制住。
这张图展示的是作者专门回到环形发射器的旋转更新模块，直接处理“转得太快”的问题。当前选中的是 `LightningRing_Scale` 发射器里的 `Sprite Rotation Rate` 模块，右侧只有一个明确的旋转速率参数，说明这一步是在非常直接地控制环形精灵的旋转速度。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`LightningRing_Scale`
- 同时可见的相关发射器包括：
  - `LightningRing_Main_`
  - `LightningRing_ScaleB`
- 当前选中模块：`Sprite Rotation Rate`

`Sprite Rotation Rate` 可确认参数：

- `Rotation Rate = 500.0`
- `Delta Time = ENGINE.DeltaTime`

当前调整意图：

- 本段主题之一是“速度”，而这一帧直接把速度定位到环形闪电层的旋转更新模块。
- `Rotation Rate = 500.0` 说明当前环形层会以较高速度持续转动；结合上一张和字幕里“它很快就转动了 150,150...”等描述，这一帧的核心就是对旋转速度进行比较、校正或继续试错。
- 由于这里只展开了旋转模块，没有展开尺寸或 alpha 参数，因此当前操作应理解为“先单独处理转速，再回头平衡其他观感”。

预览结果：

- 左侧预览窗口这一帧没有清晰显示环形结果，因此无法仅凭画面断言 `500` 是否已经是最终值。
- 但可以可靠确认：`LightningRing_Scale` 是用来控制环状层动态变化的一支发射器，而当前作者正通过 `Sprite Rotation Rate` 直接调它的旋转节奏。

### 00:32:38-00:37:30 Photoshop

- 本段定位：Photoshop。
- 知识点：需要改变它的價值,到90,100 超級 我还是想加一个背景光线圈 需要加倍的 名字它 颜色圖案不需要。
- 知识点：需要把它轉为光线圈 因为需要用光线圈 让我们把它们都剪輯出来 名字它是光线圈 它会在後面 现在需要示範 它还是需要改变它 让它变暗 光线圈的数量太少了。
- 知识点：可以甚至改变它为4 超过限制 我認为是最好选择1 然后改变它们的220 可以加點烟 可能我们不需要光线圈 加速 如果有更多的可以做 但需要增加它。
- 知识点：150,150 会是重要的一刻 把光线圈轉为光线圈 我们把它们都设计好 它会变得很奇怪 需要把它做成现實 现在需要轉到Photoshop。
- 知识点：我们来制作一个新的檔案 这很适合做这个 现在我们把画面分成兩部分 怎麼做 这可以做成这个样子 新的圖案 我们需要兩个檔案 兩倍 这里我们把全部都设置为0。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Photoshop`、`颜色`。

**关键画面：**

这张图展示的是作者回到 Unreal Engine 关卡视图中，对 `NS_Wisp_Lightning_Realistic` 的整体效果做实景检查。画面中间是新做的 realistic lightning wisp：一个明显更大的蓝色闪电环包裹着中心亮核和向外放射的电弧；左侧还能看到原有较小的 lightning 示例，用来做直接对比。

场景与资产信息：

- 当前选中关卡内的 Niagara Actor：`NS_Wisp_Lightning_Realistic`
- 右侧 `Details` 中可确认：
  - `Location = (110.953, 350.0, 200.000)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Niagara System Asset = NS_Wisp_Lightning`
  - `Niagara Tick Behavior = Use Prereqs`
  - `Allow Scalability = 开启`
- 内容浏览器当前定位在：
  - `Content / VFX_Library / Niagara / Wisps`
- 可见系统资产：
  - `NS_Wisp_Fire`
  - `NS_Wisp_Lightning`
  - `NS_Wisp_Lightning_Realistic`
  - `NS_Wisp_Water`

画面结果可确认的信息：

- `NS_Wisp_Lightning_Realistic` 相比左侧旧 lightning 版本，环半径更大、外圈闪电更完整。
- 中央亮核更强，向外连接的电弧也更密集，整体更接近“真实电流包裹核心能量球”的效果。
- 左侧旧版本仍保留较小球体和较弱环线，可作为新旧方案对照。

这一帧的重点不是再改节点，而是验证新版本在实际关卡中的体量、亮度和轮廓是否比旧版更合理。
这张图展示的是作者单独检查 `Sphere_Lightnings` 发射器，用来确认围绕中心球体的闪电支路材质和显示方式。左侧预览中，中心亮核周围已经能看到向内外放射的多条电弧，外圈闪电环也仍然存在，说明这一层负责的是球面附近的附加电流，而不是外圈主环本身。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Sphere_Lightnings`
- 旁边可见的相关发射器包括：
  - `Smoke_Main`
  - `Pieces_Top_Glow`
- `Sphere_Lightnings` 可见模块：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Sub UVAnimation`（标题中显示 `Random`）
  - `Shape Location`（标题中显示 `Sphere`）
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`

`Sprite Renderer` 可确认参数：

- `Material = MI_Lightnings_Blue_01`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Sub Image Size = (2.0, 2.0)`
- `Cast Shadows = 开启`
- `Sort Order Hint = 21`

当前结果与用途：

- 预览中中心亮球周围的闪电支路已经比单纯的外圈环更丰富，形成了“中心爆点 + 外环包裹”的结构。
- `Shape Location = Sphere` 说明这一层并不是简单平面贴图，而是基于球形区域分布粒子，使电弧更贴近核心能量球周围。
- 字幕紧接着说“现在我们转到 Photoshop，创建一个新文件”，说明 Niagara 侧这一层的材质和布局已经基本确认，下一步会去制作新的辅助纹理。
这张图展示的是作者切回 Photoshop，开始为下一阶段制作新的闪电纹理片段。画面中央是一张黑底白色单条闪电图，视图被放大到主干与右侧分叉区域，字幕明确说“插入、缩放、移动……可以合并图层”，说明当前操作重点是把多个闪电片段摆到合适位置后合并成新素材。

从截图中可以可靠确认的信息如下：

- 当前文档处于 Photoshop 中，右侧图层面板仅可见一个当前结果层 `Layer 0`。
- 画面显示的是黑底白色闪电贴图的局部放大区域，主干在中间偏左，右侧有一条较长分叉。
- 当前工具栏状态与字幕一致，说明作者正在进行选择/移动类操作，而不是色阶或画笔绘制。
- 右侧 `Properties > Transform` 打开，说明插入后的片段正在通过位置/尺寸方式被重新摆放。

按这一步可复建的处理目标，应当是：

- 新建或打开一个用于拼接的闪电纹理文档。
- 插入一段额外闪电素材。
- 通过缩放、移动，把新增分叉摆到主干附近的目标位置。
- 检查摆放后若片段位置合适，就执行图层合并，得到一个新的整合版闪电纹理。

这一帧没有显示完整图层列表，无法可靠确认当前到底包含几层被拼接的源片段，因此这里只记录“插入、缩放、移动、合并图层”的确定流程，不补写不确定的图层数量或具体图层名。

### 00:37:56-00:42:54 Spawn、Mesh

- 本段定位：Spawn、Mesh。
- 知识点：可以組合 混合层面 光线圈 这里有光线問題 我们做的不一樣 Ctrl J 按鍵 點擊 需要做什么? 濾光 光线 需要做線圈 这里有层面 混合层面 因为我從这里創作。
- 知识点：需要修改 光线延伸 我们很快修改 这是一个很快的选择 輸出和掉落 我把它轉到 Unreal Engine 这是它的样子 加一个2x2 字体 以確認我们有2x2的质感。
- 知识点：2x2的寬度和寬度 4x4的质感 我们把它創作 我们已经有光线 可以把2x2的光线放進去 我没有再加上这名字 但它是值得加的 把它放進去。
- 知识点：可以有更多的实际选择 现在把它換掉 加一个大光线 加兩个改变 再加一个紫色 我可能会改变 轉圈率的100 这里我们放25 超! 可能这里太过熟了。
- 知识点：它需要改变 不需要太过熟 超! 它和所有的质感 都更加实际 但这个东西看起来很奇怪 需要減少轉圈率 这是一张 它可以被取走 我不喜欢它 完美的 我们不需要它。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Spawn`。

**关键画面：**

这张图展示的是作者在 Photoshop 中把闪电素材拆成一个 2x2 片段集，用于后续在 Unreal/Niagara 中作为多帧或多块纹理使用。画面中央能看到四个黑底白色闪电小块，排列成标准四宫格；右侧打开的是 `Layer Style` 面板，说明作者正准备给其中一个片段补充描边/发光等图层样式。

从截图中可以可靠确认的信息如下：

- 当前文档被切分成 2x2 网格，每个格子里放一段单独的闪电片段。
- 四个片段方向各不相同，说明目标不是复制同一块，而是准备出一组可随机取样的闪电小图。
- 右侧 `Layer Style` 窗口已打开，当前选中的图层名是 `Layer 4`。
- `Layer Style` 列表中可见但未可靠判断启用状态的样式项包括：
  - `Stroke`
  - `Inner Glow`
  - `Satin`
  - `Color Overlay`
  - `Gradient Overlay`
  - `Pattern Overlay`
  - `Outer Glow`
  - `Drop Shadow`
- 当前 `Blending Options` 面板可见：
  - `Blend Mode = Normal`
  - `Opacity = 100`
  - `Fill Opacity = 100`
  - `Blend Clipped Layers as Group = 开启`

按这一步可复建的处理目标，应当是：

- 把一张原始闪电纹理拆分或整理为四块独立闪电片段。
- 统一放在一个 2x2 纹理文档中，供后续作为 `SubUV` 或类似多帧纹理使用。
- 对每块片段视需要添加图层样式，增强边缘发光或轮廓可读性。

这一帧没有显示完整图层列表和具体样式参数数值，因此只能确认“已做 2x2 分块并在编辑图层样式”，不能进一步补写具体发光半径或描边尺寸。
这张图展示的是作者把刚制作好的 2x2 闪电纹理材质接回 `Sphere_Lightnings` 发射器，并在 Niagara 预览里检查中心球体周围的新电弧效果。左侧预览中，围绕亮核的闪电支路明显比前一版更丰富，说明 2x2 分块纹理已经开始提供更多变化。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Sphere_Lightnings`
- 旁边仍可见：
  - `Smoke_Main`
  - `Pieces_Top_Glow`
- 当前右侧展开模块：`Sprite Renderer`

`Sprite Renderer` 可确认参数：

- `Material = MI_Lightnings_2x2_Blue_02`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Dist. = 0.0`
- `Max Facing Camera Blend Dist. = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Sub Image Size = (2.0, 2.0)`
- `Cast Shadows = 开启`
- `Sort Order Hint = 25`

当前结果与意义：

- 材质名已经从单帧蓝色闪电材质切换为 `MI_Lightnings_2x2_Blue_02`，说明当前这一层确实改用了新的 2x2 纹理集。
- `Sub Image Size = (2.0, 2.0)` 与上一张 Photoshop 四宫格纹理完全对应，证明 Niagara 已按 2x2 子图方式读取该贴图。
- 预览里中心球面闪电呈现出更多不同走向和长度的分支，说明多子图随机取样有效减少了重复感。
这张图展示的是作者把 `LightningRing_Main001` 发射器从 `Sprite Renderer` 方案切到 `Mesh Renderer` 路线，并准备给它指定一个球体静态网格。左侧预览里仍能看到完整的蓝色闪电球效果，右侧则打开了网格资源搜索下拉框，关键字是 `sphere`，说明作者想让这一层基于球体网格来承载材质或附加效果。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`LightningRing_Main001`
- 画面中同时可见的相关发射器包括：
  - `LightningRing_Main`
  - `LightningRing_Scale`
- 当前选中模块：`Mesh Renderer`

`Mesh Renderer` 可确认参数：

- `Meshes` 数组当前有 `1 Array element`
- `Index [0]` 当前显示的网格名为 `S_Gnomon`
- 已打开资源浏览/搜索下拉框，并用 `sphere` 作为关键词过滤候选网格
- 候选列表里可见多种球体相关静态网格，包括：
  - `MaterialSphere`
  - `S_I_UnitSphere`
- `Enable Material Overrides = 关闭`
- `Source Mode = Particles`
- `Locked Axis Enable = 关闭`
- `Facing Mode = Default`
- `Sort Mode = None`
- `Renderer Visibility = 0`

当前调整意图：

- 先前的环形层主要依赖精灵贴图与环形材质；这一帧开始尝试用网格渲染器承载球体表现，以获得更稳定或更立体的中心球层。
- 当前默认网格 `S_Gnomon` 明显不是最终目标，所以作者立即搜索 `sphere`，准备换成编辑器球体或材质球相关网格。
- 字幕明确提到“Edit sphere”“Material”，可确认目标是找一个合适的球形静态网格来配合材质，而不是继续沿用调试用占位网格。

预览结果：

- 左侧效果球已经具备完整的外环、中心亮核和内部闪电支路，说明系统整体仍正常工作。
- 当前这一步更偏向替换承载几何体，目的是让某一层的网格基础更合理，而不是立即改变整个球体外观。

### 00:42:54-00:45:56 Spawn、Alpha、Mesh

- 本段定位：Spawn、Alpha、Mesh。
- 知识点：我们不需要它了 让我们把它变成隨意的模式 Scale Mesh Size 为了某些原因 它不想要工作 我们应该從最初开始做 需要找到这个範圍。
- 知识点：是 Sphere 和 Unreal Engine 的標準模式 我们要用我们的材料 这里是我们的範圍 Self Spawn。
- 知识点：加Scale Mesh Size 转换光线 让它是同樣的 在所有的角落 并且加一个彎圈 来控制它的尺寸 需要快速地加尺寸 我们把標準的尺寸放在这里。
- 知识点：你还需要加个色彩 这樣的話 Alpha 会在最初消失 也需要減少生命周期 需要試0.5 可能需要放太多了 隨意的尺寸 0.7和0.8 或者改变它的尺寸。
- 知识点：最大尺寸是 Doral Set Fade 这範圍变得这麼有趣 看起来完全不一樣 需要重新改名 也看起来很有趣 我们实际上切割了 已经有很多細節。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Alpha`、`生命周期`。

**关键画面：**

这张图展示的是作者在 `LightningRing_Main001` 发射器上用 `Scale Color` 模块直接控制 alpha 曲线，以便让这一层在生命周期开始时快速显现、随后逐步淡出。字幕里同时提到 `Scale Mesh Size` 因某些原因不工作，所以作者转而先从颜色/透明度衰减入手处理。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`LightningRing_Main001`
- 左侧还可见一个相关发射器：`LightningRing_Scale`
- 当前选中模块：`Scale Color`

`Scale Color` 可确认参数：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`
- `Scale Alpha = Float from Curve`
- 曲线输入维度：`PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`

曲线形态可确认的信息：

- 曲线在生命周期开始时从接近 `0` 的 alpha 迅速上升。
- 早期很快到达接近 `1.0` 的峰值。
- 之后沿生命周期持续下降，到结束时回到接近 `0`。

当前调整意图：

- 用 alpha 曲线控制这一层“先亮起、后衰减”的可见性节奏。
- 因为 `Scale Mesh Size` 当前没有达到预期，作者先把透明度节奏稳定下来，再继续处理尺寸问题。
- 这一帧与本段的 `Alpha`、`生命周期` 主题直接对应，重点是让环形网格层不会全程保持同一强度。
这张图展示的是作者新建或启用一个名为 `Empty` 的 mesh 发射器，直接在 `Initialize Particle` 中设置统一网格尺寸，用它替代前面在 `LightningRing_Main001` 上不稳定的 mesh 缩放方案。左侧预览里可以看到一个由多层蓝色半透明切片构成的球状体，说明这个新发射器已经成功驱动出基于网格的电球壳层。

Niagara / Stack 结构：

- 系统：`NS_Wisp_Lightning_Realistic`
- 当前选中发射器：`Empty`
- 左侧并列可见的相关发射器：`LightningRing_Scale`
- 当前选中模块：`Initialize Particle`

`Initialize Particle` 可确认参数：

- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Color Mode = Unset`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`
- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`
- `Mesh Scale Mode = Uniform`
- `Mesh Uniform Scale = 5`
- `Mesh Renderer Array Visibility Mode = Unset`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

当前调整意图：

- 直接在新的 mesh 发射器中用 `Mesh Uniform Scale = 5` 给球体一个明确的基础尺寸，避免旧方案里缩放逻辑不稳定。
- 保持 `Lifetime = 5.0`，让这一层作为较持久的球形壳层存在，再配合 alpha 曲线做可见性控制。
- 字幕说明“加 `scale color` 让 alpha 在开始时消失，也需要减少”，说明尺寸方案已经先固定，下一步会继续调这个新发射器的透明度节奏。

预览结果：

- 预览中的球体不再只是闪电外环，而是出现了由多层发光切片组成的更实体化球壳。
- 这说明 mesh 路线已经开始替代纯 sprite 的部分层次，用来增加球体结构感。
这张图展示的是作者回到关卡视图，对最新版本的 realistic lightning wisp 做最终外观对比和材质资产整理。右侧主效果球已经呈现出比左侧旧球更复杂的结构：除了外围闪电环和中心亮核之外，内部还出现了半透明球壳纹理和更明显的体积感。

场景与资产信息：

- 当前关卡中同时可见左侧旧版 lightning 球和右侧 `NS_Wisp_Lightning_Realistic` 新版球。
- 内容浏览器当前定位在：
  - `Content / VFX_Library / Materials / Instances / Wisps / Lightning_Realistic`
- 可见的关键材质实例包括：
  - `MI_ElectricSphere_01`
  - `MI_Glow_Alpha_01`
  - `MI_Lightning_Blue_01`
  - `MI_Lightning_Ring_02`
  - `MI_Lightnings_2x2_Blue_02`

画面结果可确认的信息：

- 右侧新版球比左侧旧版球明显更厚、更有层次，不再只是一个简单的发光圆环。
- 新版内部能看到球壳纹理、中心亮核和多层闪电支路共同叠加，体积感更强。
- 左侧旧版球仍保留较简洁的环和核心结构，可作为新旧差异对照。

这一帧的重点不是继续调参数，而是确认新增加的 `ElectricSphere`、`Glow Alpha`、`Lightning Ring`、`Lightnings 2x2` 等材质实例组合后，成品已经形成与旧版明显不同、更加“realistic”的最终观感。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


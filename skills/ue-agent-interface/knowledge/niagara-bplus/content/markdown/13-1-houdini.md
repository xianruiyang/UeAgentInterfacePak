# 13-1创建Houdini资源

# 13-1创建Houdini资源

## 关键术语

- `UV`、`Houdini`、`RBD`、`Substance`、`Substance Designer`、`Noise`、`网格`、`碰撞`、`速度`、`Niagara`、`序列`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`

## 分段知识

### 00:00:05-00:02:45 网格、只带来了那些部分、在游戏中有这样的物理模拟素材都是很少见的

- 本段定位：网格、只带来了那些部分、在游戏中有这样的物理模拟素材都是很少见的。
- 知识点：您好,第13课,选您们好。
- 知识点：这次我们利用后丁丁制作跳跃的技能演出吧。
- 知识点：后续会表现出实际的网格列文部分。
- 知识点：需要根据那个动作制作物理动画仿真。
- 知识点：这次进行的部分就是, 尽量使用肌肤控制, 然后准备了比较简单易用的方法。

**关键画面：**

这张图是 `00:00:05-00:02:45 网格、只带来了那些部分、在游戏中有这样的物理模拟素材都是很少见的` 段落的开场画面，用来说明本节将在 Houdini 中从空工程开始制作“跳跃技能”的物理网格素材。

已确认信息：
- 软件为 `Houdini Indie Limited-Commercial 20.5.332 - Py3.11`。
- 当前位于 `/obj` 对象层级，网络视图为空，中央提示为 `Empty Network / Press Tab to Add Nodes`。
- 左侧是空的透视视口，只有默认地面网格，没有任何导入模型或模拟对象。
- 右侧参数面板当前没有选中任何算子，底部状态显示 `No Operator Selected`。
- 时间轴位于起始帧，说明教程正在从零开始准备场景。

画面用途：
- 这一步不是展示具体节点或参数，而是交代后续会在 Houdini 里为技能演出制作实际的网格裂解与物理动画仿真素材。
这张图仍位于 `00:00:05-00:02:45` 首段，但对应讲解重点已经切到“只带来了那些部分”，即后续制作不会把所有细节都做成完整物理模拟素材，而是只抽取技能表现真正需要的网格部分。

已确认信息：
- 画面仍然是 `Houdini Indie 20.5.332` 的 `/obj` 空对象层，网络视图没有新增节点。
- 左侧透视视口只有默认地面网格，说明当前还处在方案说明阶段，没有开始导入模型或搭建求解网络。
- 右侧参数面板依旧没有选中算子，底部仍是 `No Operator Selected`。
- 时间轴仍停在起始位置，表示教程还没有进入具体操作帧段。

画面用途：
- 这张图延续开场空场景，用来强调制作范围控制：后续只保留与“跳跃技能地面破裂/网格演出”直接相关的部分，而不是为整套复杂物理效果建立完整高成本资产。
这张图是 `00:00:05-00:02:45` 首段进入实际搭建的起点：教程在 `/obj` 下新建了 `geo1`，并在其中放入一个 `box1` 作为后续地面破裂/物理网格的基础几何体。

已确认信息：
- 顶部路径已从 `/obj` 进入 `/obj/geo1`。
- 网络视图中央只有一个节点 `box1`，当前被选中。
- 左侧视口显示一个立方体/长方体块体，放置在默认地面网格上，说明此时正在用最简单的基础网格做起始形体。
- 右侧参数面板显示当前算子为 `Box box1`。
- 关键参数可见：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Consolidate Corner Points` 已勾选
  - `Size = (1, 1, 1)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (2, 2, 2)`

画面用途：
- 这一步先用规则 `Box` 建立一个可控、低复杂度的基础几何体，符合本段“游戏里很少直接使用复杂物理模拟素材、需要先从简单网格开始控制成本”的讲解语义。

### 00:02:49-00:05:45 UV、网格

- 本段定位：UV、网格。
- 知识点：如果包含这些细节, 就是带入网格的细节的话, 其实其实会变得太重。
- 知识点：这个游戏里就难以使用了。
- 知识点：如果切割太多的话, 性能上也会变得很重。
- 知识点：,所以会尽量在可用范围内进行切割。
- 知识点：那么这样就会出现平坦的板子。

**关键画面：**

这张图对应 `00:02:49-00:05:45 UV、网格` 段开头，用当前的基础 `box1` 说明一个约束：不要把太多高频细节直接做进模拟网格，否则资产会过重，不适合游戏内使用。

已确认信息：
- 当前仍在 `/obj/geo1`，网络视图中只有一个被选中的 `box1`。
- 左侧视口显示一个简单、未细分的块体，没有任何裂缝、切片或额外表面细节。
- 右侧参数面板依然是 `Box box1` 的基础参数页，说明此时还停留在原始基础网格阶段。
- 可见参数保持为：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Size = (1, 1, 1)`
  - `Axis Divisions = (2, 2, 2)`

画面用途：
- 用最简单的 `Box` 作为对照，强调后续网格切割必须控制在“可用范围”内，而不是一开始就把复杂破碎细节直接烘进模拟体。
这张图展示了同一段 `UV、网格` 里的具体轻量化做法：仍然使用 `box1`，但把它改成一块很薄的板，并只保留有限数量的分段，满足“游戏里可用”的网格密度。

已确认信息：
- 当前仍在 `/obj/geo1`，网络视图中只有选中的 `box1`。
- 左侧视口中的几何体已不再是厚立方体，而是一块近乎平面的矩形板，顶面可见规则网格切线。
- 右侧 `Box box1` 参数面板显示：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Size = (8, 0.05, 8)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (5, 2, 5)`
- 从这些参数可以确认作者把厚度压到 `0.05`，同时只在长宽方向保留 `5x5` 级别的有限划分，避免产生过密拓扑。

画面用途：
- 这一步把原始方盒明确调整为“平坦的板子”，对应正文里“尽量在可用范围内进行切割”“这样就会出现平坦的板子”的说明。
这张图仍在 `00:02:49-00:05:45 UV、网格` 段，继续微调同一块薄板网格的位置，让它更像地面用的平面基底，而不是以原点为中心悬空分布的厚盒体。

已确认信息：
- 当前节点依旧是 `/obj/geo1/box1`，网络结构没有变化。
- 左侧视口仍显示一块带有限切线的矩形薄板。
- 右侧 `Box box1` 参数与上一张相比，大部分保持不变：
  - `Size = (8, 0.05, 8)`
  - `Axis Divisions = (5, 2, 5)`
- 本图新增的可确认变化是 `Center` 的第二个分量改为 `-0.025`，即：
  - `Center = (0, -0.025, 0)`
- 由于厚度是 `0.05`，把中心下移 `0.025` 等于向下移动半个厚度，可使板体上表面更贴近世界基准面。

画面用途：
- 这一步是在保持低成本网格密度的前提下，顺手把基础板的位置摆正，为后续 UV 和破碎处理提供更合理的初始平面。

### 00:05:49-00:08:46 UV、Noise

- 本段定位：UV、Noise。
- 知识点：即使面破了, 这个UV还是能保留。
- 知识点：我先升上了UV, 然后用脸的原因是现在在用盒子。
- 知识点：叫做Brony Fracture, 然后。
- 知识点：Brony Noise Pattern的作用是把它分成小块。
- 知识点：现在有错误, 然后这个部分要进来。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Noise`。

**关键画面：**

这张图对应 `00:05:49-00:08:46 UV、Noise` 段开头，说明在做破碎前先给基础薄板布好 UV，这样后面即使网格被打碎，纹理坐标也还能保留下来。

已确认信息：
- 当前网络从 `box1` 向下新增了一个 `uvtexture1` 节点，且 `uvtexture1` 被选中。
- 右侧参数面板显示当前算子为 `UV Texture uvtexture1`。
- 可见参数为：
  - `UV Attribute = uv`
  - `Texture Type = Face`
  - `Attribute Class = Vertex`
  - `Scale = (1, 1, 1)`
  - `Offset = (0, 0, 0)`
  - `Fix Boundary Seams` 未勾选
- 左侧视口中几何表面出现了规则棋盘/网格状纹理预览，说明 UV 已经成功写到当前薄板表面。

画面用途：
- 这一步先在规则板面上建立基础 `uv` 属性，为后续 Voronoi 破碎和 Noise 细分保留稳定的贴图坐标。
这张图延续同一段 `UV、Noise` 流程，在 `uvtexture1` 后加入 `uvedit1` 来整理 UV 的缩放与偏移，让板面上的棋盘贴图分布更适合作为后续破碎参考。

已确认信息：
- 当前网络链路变为 `box1 -> uvtexture1 -> uvedit1`，`uvedit1` 被选中。
- 右侧参数面板显示当前算子为 `UV Edit uvedit1`。
- 可见参数包括：
  - `Group = 0-47`
  - `Group Type = Primitives`
  - `UV Attribute = uv`
  - `Transform Order = Scale Rot Trans`
  - `Translate = (0.503717, 0.498225, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (0.124614, 0.124614, 1)`
  - `Shear = (0, 0, 0)`
  - `Pivot = (-2.38419e-07, 0, 2)`
  - `Soft Radius = 0`
- 左侧视口中的棋盘 UV 贴图比上一张更密，而且能看到每个格子带编号，说明 UV 被整体缩小后塞入较小的 UV 空间区域。

画面用途：
- 通过 `uvedit1` 控制 UV 的尺度和位置，使后续即便发生破碎，碎片仍能引用一套统一、紧凑的纹理坐标布局。
这张图是 `UV、Noise` 段里真正开始破碎的关键画面：在 UV 处理后的板面上先散点，再用 Voronoi 破碎，因此碎片生成后仍能保留前面准备好的 UV 分布。

已确认信息：
- 当前节点链可见为：
  - `box1 -> uvtexture1 -> uvedit1 -> voronoifracture1`
  - `uvedit1 -> scatter1 -> voronoifracture1`
- `scatter1` 当前被选中，作为 `voronoifracture1` 的散点输入。
- 右侧 `Scatter scatter1` 参数面板中可确认：
  - `Generate = By Density`
  - `Force Total Count` 已勾选，值为 `1000`
  - `Max Point Limit` 已勾选，值为 `1000000`
  - `Randomize Point Order` 已勾选
  - `Relax Iterations = 10`
  - `Scale Radii By = 1`
  - `Max Relax Radius = 1.0`
- 左侧视口预览已经从规则棋盘板面变成大量不规则多边形碎片，每块碎片上仍然带着编号/字母纹理，说明 Voronoi 破碎后 UV 仍被保留下来。

画面用途：
- 这一步通过 `scatter1` 控制散点数量，再交给 `voronoifracture1` 切分薄板，验证正文所说“即使面破了，这个 UV 还是能保留”。

### 00:08:50-00:11:47 RBD、Substance、Substance Designer

- 本段定位：RBD、Substance、Substance Designer。
- 知识点：不是用什么困难的表达。
- 知识点：只要跟着这些节点接口就可以。
- 知识点：你根本不会觉得很难。
- 知识点：在一定程度上可以单独控制并应用。
- 知识点：但是这个Brony Fracture的话就有点简单。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Substance Designer`、`颜色`。

**关键画面：**

这张图对应 `00:08:50-00:11:47 RBD、Substance、Substance Designer` 段开头，用一个更简化的 Voronoi 破碎结果说明：不需要复杂做法，只要按这些节点接口连接起来，就能先得到可控的基础碎块。

已确认信息：
- 当前链路仍为：
  - `box1 -> uvtexture1 -> uvedit1 -> voronoifracture1`
  - `uvedit1 -> scatter1 -> voronoifracture1`
- `scatter1` 被选中，右侧参数面板显示当前关键设置与上一批不同：
  - `Generate = By Density`
  - `Force Total Count` 已勾选，值为 `100`
  - `Max Point Limit` 已勾选，值为 `1000000`
  - `Randomize Point Order` 已勾选
  - `Relax Iterations = 10`
  - `Scale Radii By = 1`
  - `Max Relax Radius = 1.0`
- 左侧视口中，棋盘编号纹理仍被保留在碎片上，但碎片块数明显更少、块面更大，说明当前是更粗粒度的 Voronoi 切分。

画面用途：
- 通过把 `scatter1` 的总点数降到 `100`，先得到更简单、易理解的基础碎块分布，为后面再叠加更复杂的局部控制和贴图流程打底。
这张图在同一段 `RBD、Substance、Substance Designer` 中进一步说明 `voronoifracture1` 本身的基础设置已经足够使用，不需要额外堆太复杂的破碎表达。

已确认信息：
- 当前节点链仍为：
  - `box1 -> uvtexture1 -> uvedit1 -> voronoifracture1`
  - `uvedit1 -> scatter1 -> voronoifracture1`
- 当前选中节点改为 `Voronoi Fracture voronoifracture1`。
- 右侧参数面板可确认的设置包括：
  - `Create Interior Surfaces` 已勾选
  - `Name Attribute = Overwrite`
  - `Piece Prefix = piece`
  - `Compute Interior Normals` 已勾选
  - `Interior Cusp Angle = 15`
  - `Exterior Normals = Preserve Existing Normals`
  - `Exterior Cusp Angle = 60`
  - `Interior Group = inside`
  - `Exterior Group = outside`
  - `Merge with Existing Groups` 已勾选
  - `Triangulation = Auto Detect`
  - `Connectivity Partition = Overwrite Piece Numbering`
  - `Cut Plane Offset = 0`
- 左侧视口里，碎片仍然保留棋盘编号纹理，说明当前改动主要是破碎结果的拓扑/分组属性整理，而不是重新生成不同的 UV。

画面用途：
- 这一帧强调 Voronoi 破碎节点本身已经提供了碎片命名、内外表面分组和法线整理等基础能力，足以支撑后续 RBD 或贴图流程。
这张图在同一段 `RBD、Substance、Substance Designer` 里把基础 Voronoi 流程再往前推进一步：先在 UV 板面上写入颜色属性，再把这份属性提供给 `scatter1`，以便后续按区域控制散点和碎块大小。

已确认信息：
- 可见链路关系为：
  - `box1 -> uvtexture1 -> uvedit1 -> voronoifracture1`
  - `uvedit1 -> scatter1 -> voronoifracture1`
  - `uvedit1 -> attribadjustcolor1 -> scatter1`
- 当前选中节点为 `Attribute Adjust Color attribadjustcolor1`。
- 右侧参数面板可确认：
  - `Attribute Name = Cd`
  - `Attribute Class = Point`
  - 通道模式为 `RGB`
  - `Enable Pre-Process` 已勾选
  - `Adjust Value` 已勾选
  - `Operation = Set Always`
  - `Pattern Type = Constant`
  - `Constant Color` 为白色 `(1, 1, 1)`
  - `Enable Color Correction` 已勾选
  - `Enable Post-Process` 已勾选
- 左侧视口仍显示带棋盘编号的破碎平面，说明当前重点不在直接改变几何外观，而是在为后续散点/区域控制补充 `Cd` 属性。

画面用途：
- 这一步先在破碎前的输入表面上准备颜色属性通道，便于后续把不同区域当作散点分布或碎块尺寸控制的遮罩来源，符合字幕里“撒一些点来决定区域大小”的讲解。

### 00:11:54-00:14:52 速度、颜色

- 本段定位：速度、颜色。
- 知识点：颜色怎么上色就这样出来了。
- 知识点：除了颜色模式我们只需要灰度。
- 知识点：这样换成颜色灯后。
- 知识点：需要拉出一个叫Remap的这个节点。
- 知识点：生成了一个叫CD的属性。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这张图对应 `00:11:54-00:14:52 速度、颜色` 段开头，展示如何在薄板表面生成一张彩色 `Cd` 区域图，用来直观看每个区域将来如何参与颜色或控制逻辑。

已确认信息：
- 当前链路可见为：
  - `uvtexture1 -> uvedit1 -> voronoifracture1`
  - `uvedit1 -> attribadjustcolor1 -> scatter1 -> voronoifracture1`
- 当前选中节点为 `Attribute Adjust Color attribadjustcolor1`。
- 右侧参数面板显示：
  - `Attribute Name = Cd`
  - `Attribute Class = Point`
  - 通道模式为 `RGB`
  - `Enable Pre-Process` 已勾选
  - `Adjust Value` 已勾选
  - `Operation = Set Always`
  - `Pattern Type = Noise`
  - `Range Values = Color Ramp`
  - 可见一条从紫、青、绿、黄到红的 `Color Ramp`
  - `Noise Type = Simplex`
  - `Location Attribute = P`
  - `Element Size = 1`
  - `Offset = 0`
  - `Enable Color Correction` 已勾选
  - `Enable Post-Process` 已勾选
- 左侧视口中的棋盘板面已经被大块的彩色区域覆盖，说明 `Cd` 正在以噪声图案写入表面点属性。

画面用途：
- 先把区域着色逻辑可视化出来，便于后续把这些 `Cd` 值转成灰度遮罩、颜色控制或碎块分布控制。
这张图延续 `00:11:54-00:14:52 速度、颜色` 段，把前一步生成的彩色 `Cd` 属性接到一个 `Remap` 节点上，开始把颜色区域转换为更适合控制的灰度分布。

已确认信息：
- 当前可见链路增加为：
  - `uvedit1 -> attribadjustcolor1`
  - `attribadjustcolor1 -> attribremap1`
  - 另一支仍保留 `attribadjustcolor1 -> scatter1 -> voronoifracture1`
- 当前选中节点为 `Attribute Remap attribremap1`。
- 右侧参数面板可确认：
  - `Class = Point`
  - `Input Min = 0`
  - `Input Max = 1`
  - `Output Min = 0`
  - `Output Max = 1`
  - `Out of Range Values = Clamp to Edge Value`
  - `Use Ramp` 已勾选
  - `Remap` 曲线当前为从左下到右上的线性斜坡
  - 当前可见采样点参数：
    - `Point No. = 2`
    - `Position = 1`
    - `Value = 1`
    - `Interpolation = Linear`
- 左侧视口中的板面已经不再显示彩色噪声，而是显示为黑到白的灰度斑块，说明这一步正在把 `Cd` 结果压成单通道强度图。

画面用途：
- 这正对应正文里“除了颜色模式我们只需要灰度”“需要拉出一个叫 Remap 的节点”，即先把彩色区域图转成灰度遮罩，再供后续速度、颜色或区域控制复用。
这张图是 `速度、颜色` 段里把灰度控制真正收束为遮罩属性的步骤：在 `attribremap1` 中继续调整曲线，并把原始 `Cd` 输出改名为 `mask`，再把这张灰度遮罩送回后续破碎/散点流程使用。

已确认信息：
- 当前链路关系可见为：
  - `uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1`
  - 画面标签明确显示 `Cd -> mask`
- 当前选中节点仍为 `Attribute Remap attribremap1`。
- 右侧参数面板显示：
  - `Class = Point`
  - `Original Name = Cd`
  - `New Name = mask`
  - `Input Min = 0`
  - `Input Max = 1`
  - `Output Min = 0`
  - `Output Max = 1`
  - `Out of Range Values = Clamp to Edge Value`
  - `Use Ramp` 已勾选
  - `Remap` 曲线不再是简单直线，而是中段压低、后段快速抬升的 S 形/折线趋势
  - 当前选中的曲线点参数可见为：
    - `Point No. = 2`
    - `Position = 0.432692`
    - `Value = 0.0909091`
    - `Interpolation = Linear`
- 左侧视口中的灰度区域比上一张更集中，暗部面积更大、亮部区域更被压缩，符合在用曲线筛出更明确遮罩范围的效果。

画面用途：
- 这一步把彩色 `Cd` 彻底整理成单独的 `mask` 属性，便于后续只按灰度强弱来驱动散点区域、碎块尺度、速度或颜色分布。

### 00:14:56-00:17:52 关键流程 06

- 本段定位：关键流程 06。
- 知识点：这样一来里面的碎片就变得很多小碎片。
- 知识点：如果这里移动一下这个点是实时分散的那个样子。
- 知识点：我这样打碎并不是说一定要这样打碎。
- 知识点：可以自由地尝试你想要的形状看看效果如何。
- 知识点：我们简单看看如何利用波尔诺伊断裂。

**关键画面：**

这张图对应 `00:14:56-00:17:52 关键流程 06` 段开头，开始把上一段做出来的 `mask` 真正用于散点分布控制，而不是只停留在灰度预览。

已确认信息：
- 当前链路可见为：
  - `uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1`
  - `attribremap1` 的标签仍显示 `Cd -> mask`
- 当前选中节点为 `Scatter scatter1`。
- 右侧参数面板显示：
  - `Generate = By Density`
  - `Force Total Count` 已勾选，值为 `100`
  - `Density Attribute = density`
  - `Max Point Limit` 已勾选，值为 `1000000`
  - `Randomize Point Order` 已勾选
  - `Relax Iterations = 10`
  - `Scale Radii By = 1`
  - `Max Relax Radius = 1.0`
- 左侧视口当前只显示稀疏散点，说明画面重点已经切到“点是怎么分布的”，而不是显示最终碎片。
- 结合中间链路标签可确认：本步意图是把刚制作好的遮罩属性作为散点控制来源，让不同区域生成不同密度的切割点。

画面用途：
- 这一帧建立了从 `mask` 到散点分布的实际联系，为后续“内部变成很多小碎片、移动点可实时改变分散形态”做准备。
这张图在同一段 `关键流程 06` 中切回 `voronoifracture1` 结果查看，用来验证 `mask` 驱动散点之后，碎块已经开始按区域产生明显的尺寸差异。

已确认信息：
- 当前可见链路为：
  - `uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1`
  - 另一条 `uvedit1 -> voronoifracture1` 仍保留原始被切几何输入
- 当前选中节点为 `Voronoi Fracture voronoifracture1`。
- 右侧参数页仍显示 Voronoi 的基础设置，如：
  - `Create Interior Surfaces` 已勾选
  - `Piece Prefix = piece`
  - `Compute Interior Normals` 已勾选
  - `Interior Group = inside`
  - `Exterior Group = outside`
  - `Triangulation = Auto Detect`
- 左侧视口中的棋盘平面已出现明显“中心更细、外围更粗”的碎块层级：中心区域聚集了大量小碎片，边缘仍保留较大的 Voronoi 块。
- 这说明前面 remap 出来的 `mask` 已经不只是显示用途，而是在真实影响 Voronoi 的切割点分布。

画面用途：
- 用最终碎裂结果回看 `mask` 控制是否生效，确认内部区域已经按预期变成更多小碎片。
这张图仍属于 `关键流程 06`，但已经切到另一种试验分支：不再直接看平面碎裂，而是查看一个 `isooffset1` 体素化节点，说明作者正在尝试别的形状或体积分辨率配置，而不是把 Voronoi 破碎限定死在前面的单一方案里。

已确认信息：
- 网络右侧当前选中节点为 `isooffset1`，其上方还能看到一个 `sphere1`，下方可见 `scatter2`、`voronoifracture2` 的命名，说明这里是另一条与前面平板分支并行的实验链。
- 右侧 `IsoOffset isooffset1` 参数面板显示：
  - `Output Type = Fog Volume`
  - `Mode = Ray Intersect`
  - `Offset = 0`
  - `Uniform Sampling = Max Axis`
  - `Uniform Sampling Divs = 100`
- 中间弹出的节点信息窗口进一步确认：
  - 节点为 `IsoOffset Sop (isooffset)`
  - 结果包含 `1 Native Volume`
  - 分辨率为 `100 x 100 x 100 (1,000,000 voxels)`
  - `Voxel size = 0.0104`
- 左侧视口显示一个近似球形的白色体积预览，而不是前面那张棋盘薄板。

画面用途：
- 这一步强调当前破碎流程并不是只能照搬一种平面做法，也可以换成别的输入形状，并通过 `IsoOffset` 的体素分辨率来控制后续试验精度。

### 00:17:57-00:20:49 破碎

- 本段定位：破碎。
- 知识点：现在在多边形表面这种情况里面并不完全填充。
- 知识点：只是这样像壳子一样制作而已。
- 知识点：就是这样像壳子一样制作而已。
- 知识点：但如果通过ISOFSAT转换成物体的话, 里面就会有体速存在。
- 知识点：从这个来看的话有ISO和没有的区别。

**关键画面：**

这张图对应 `00:17:57-00:20:49 破碎` 段的对照实验开头，用一条新的球体分支说明“没有 IsoOffset 时只是一个外壳表面”，并把后续会用到的两种破碎路径同时摆出来。

已确认信息：
- 画面中并行存在两套网络：
  - 左侧旧链：`box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1`
  - 右侧新链：`sphere1 -> voronoifracture2`
  - 右侧新链的另一支：`sphere1 -> isooffset1 -> scatter2 -> voronoifracture2`
- 当前选中节点为 `Sphere sphere1`。
- 右侧参数面板可确认：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Radius = (0.5, 0.5, 0.5)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Orientation = Y Axis`
  - `Rows = 13`
  - `Columns = 24`
  - `Unique Points per Pole` 已勾选
  - `Accurate Bounds` 已勾选
  - `Triangular Poles` 已勾选
- 左侧视口只看到一个浅灰色球面局部，没有内部体积结构，符合正文“只是像壳子一样制作而已”的描述。

画面用途：
- 先把“直接对表面做”和“先转成 IsoOffset 体积再做”的两种路径并排摆出来，为后面解释两者在内部填充和碎裂效果上的差异做铺垫。
这张图继续解释 `破碎` 段中的对照结果：当球体先经过 `IsoOffset` 体积化，再送进 `scatter2` 和 `voronoifracture2`，最后通过 `explodedview1` 拉开时，碎片会呈现真正有厚度的放射状爆开，而不是只有表面壳层。

已确认信息：
- 当前右侧实验链清晰可见为：
  - `sphere1 -> isooffset1 -> scatter2 -> voronoifracture2 -> explodedview1`
  - 同时还保留一条 `sphere1 -> voronoifracture2` 的直接输入对照
- 网络中 `explodedview1` 已经出现，说明当前画面是在用爆炸视图把破碎块体拉开便于观察。
- 右侧面板仍停留在 `IsoOffset isooffset1`，可见其关键参数保持：
  - `Output Type = Fog Volume`
  - `Mode = Ray Intersect`
  - `Uniform Sampling = Max Axis`
  - `Uniform Sampling Divs = 100`
- 左侧视口中可以看到大块碎片被从中心向外拉开，碎块之间存在明显内部厚度和黑色空隙，不再是贴着单层表面的薄片。
- 中间仍能看见左侧旧平板链与右侧球体链并排存在，强调这是在做“有 IsoOffset”和“无 IsoOffset”的效果比较。

画面用途：
- 用 `explodedview1` 把 `IsoOffset` 分支的破碎结果拆开展示，直观证明体积化之后内部确实参与了切割，碎块不再只是壳面。
这张图是 `破碎` 段的落点画面，切回平板主链并用 `explodedview1` 拉开 `voronoifracture1` 的碎块，说明即使是这条主链，破碎后也会生成新的内侧面，而不只是外表面被切开。

已确认信息：
- 当前主链清晰可见为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> explodedview1`
- 右侧实验链仍保留在同一网络里：
  - `sphere1 -> isooffset1 -> scatter2 -> voronoifracture2`
- 当前右侧参数面板仍停在 `Voronoi Fracture voronoifracture1`，可见：
  - `Create Interior Surfaces` 已勾选
  - `Piece Prefix = piece`
  - `Compute Interior Normals` 已勾选
  - `Interior Group = inside`
  - `Exterior Group = outside`
- 左侧视口显示大量被拉开的薄板碎片，每块碎片之间留有空隙，可以看到侧边和断面，说明破碎后存在新的内部表面而不是只有顶面贴片。
- 画面中碎片表面仍保留棋盘编号纹理，说明外表面 UV 信息仍在；但现在观察重点是断裂后新增的内侧面结构。

画面用途：
- 用爆炸视图证明 Voronoi 破碎会生成 `inside` 内表面，这也是后续区分外侧组和内侧新生面、做删选或单独处理的基础。

### 00:20:57-00:24:05 UV、RBD、网格

- 本段定位：UV、RBD、网格。
- 知识点：而我们原来的表面, 这个盒子表面可以看作外侧组。
- 知识点：删除为选择的意思是除选择组以外的所有。
- 知识点：删除为选择的意思是 除去选中的组以外的所有。
- 知识点：可以把这看作是自动创建分组的节点。
- 知识点：在钢体变形模拟和破坏模拟方面, 将使用亚务博士那边的schizophrenia进行传输。

**关键画面：**

这张图对应 `00:20:57-00:24:05 UV、RBD、网格` 段开头，开始利用 Voronoi 自动生成的 `inside/outside` 分组来筛选碎片表面，为后续 RBD 传输准备干净的网格集合。

已确认信息：
- 当前主链已经延伸为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> explodedview1 -> delete1`
- 当前选中节点为 `Delete delete1`。
- 右侧参数面板可确认：
  - `Group = inside`
  - `Operation = Delete Selected`
  - `Entity = Primitives`
  - `Geometry Type = All Types`
  - `Enable` 已勾选
  - `Operation`（过滤方式）为 `Delete by Pattern`
  - `Pattern = *`
  - `Delete Unused Groups` 已勾选
  - `Keep Points` 未勾选
- 左侧视口中，拉开的碎片主要显示为带编号纹理的外表面薄片，符合“删除 inside 组后，只保留原始盒子表面可视为 outside 组”的语义。

画面用途：
- 通过删除 `inside` 组，先把破碎结果中的外表面壳层单独提出来，便于后续按组输送到 RBD 或做单独网格处理。
这张图延续 `UV、RBD、网格` 段，在 `voronoifracture1` 的结果后新增 `assemble1`，开始把碎片整理成更适合后续 RBD 处理的对象集合。

已确认信息：
- 当前主链可见为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1`
  - `voronoifracture1 -> explodedview1 -> delete1`
  - `voronoifracture1 -> assemble1`
- 网络中 `assemble1` 已经出现并被高亮，说明教程此时开始进入碎片整理/装配步骤。
- 右侧参数面板仍停留在 `Voronoi Fracture voronoifracture1`，因此本图无法可靠读取 `assemble1` 的具体参数，只能确认它已直接接在主破碎结果后。
- 左侧视口里，棋盘平面仍保持中心更细、外围更粗的破碎层级，说明 `assemble1` 这一步是在整理现有碎片，而不是重新改变切割分布。

画面用途：
- 在把 `inside/outside` 分组说明清楚之后，继续把碎片组织成后续可送往 RBD 模拟或导出的网格单元，这是从“破碎结果”走向“可用模拟资产”的过渡步骤。
这张图把 `assemble1` 的关键参数完整展开，明确展示它如何基于破碎结果生成 `piece` 级别的打包碎片，为后续 RBD 求解器或导出流程提供标准化碎片对象。

已确认信息：
- 当前选中节点为 `Assembly assemble1`，位置接在 `voronoifracture1` 后。
- 主链关系为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1`
  - 旁路仍保留 `voronoifracture1 -> explodedview1 -> delete1`
- 右侧参数面板可确认：
  - `Inside Group = inside`
  - `Output Prefix = piece`
  - `Create Groups` 已勾选
  - `Create Name Attribute` 已勾选
  - `Connect Inside Edges` 已勾选
  - `Cusp Edges` 未勾选
  - `Create Packed Primitives` 已勾选
  - `Path Attribute = op:\`opfullpath(\".\")\``
  - `Create Packed Fragments` 已勾选
  - `Pivot Location = Centroid`
  - `Display As = Full Geometry`
- 左侧视口中的几何显示为一整块平板外观，说明当前重点不在爆炸预览，而是在把碎片封装成后续求解可直接识别的 packed/fragment 结构。

画面用途：
- 这一步把破碎网格正式整理成带 `piece` 命名、可打包的碎片对象，是连接 `UV/网格` 阶段与后续 `RBD` 模拟阶段的关键桥接。

### 00:24:08-00:27:05 UV、RBD

- 本段定位：UV、RBD。
- 知识点：大部分的求解器, 比如Pirate求解器, 比如说还有Ballem求解器以及RBD求解器。
- 知识点：以前的版本中, 这些求解器大多存在于动态网络中。
- 知识点：是可以控制模拟的网络, 原本只在这里可以控制。
- 知识点：从那时起, 在OBJ网络里面就是UV-BRIGHT, 已经这样设置好重新回来后, 简化地做了这样方便的模拟。
- 知识点：可以认为这是为了小节点的便利性而制作的节点。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。

**关键画面：**

这张图对应 `00:24:08-00:27:05 UV、RBD` 段开头，说明在完成 `assemble1` 之后，可以直接通过新版 SOP 节点搜索 RBD 相关节点，而不必像旧版那样先进入单独的 Dynamics 网络。

已确认信息：
- 当前主链停在 `assemble1`，其上游仍是：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1`
- `assemble1` 仍被选中，右侧参数面板保持：
  - `Inside Group = inside`
  - `Output Prefix = piece`
  - `Create Packed Primitives` 已勾选
  - `Create Packed Fragments` 已勾选
- 中央网络视图已打开 Tab 菜单，并展开一列 `RBD` 相关节点，可见包括：
  - `RBD Cluster`
  - `RBD Configure`
  - `RBD Pack`
  - `RBD Paint`
  - `RBD Transform`
  - `RBD Unpack`
  - `RBD Bullet Solver`
  - `RBD Exploded View`
  - 以及多种 `RBD Constraint` / `RBD Material Fracture` / `RBD I/O` 等节点
- 这说明教程正在从“破碎网格准备”切换到“如何用更便捷的 RBD SOP 节点组织模拟”。

画面用途：
- 用节点搜索列表说明新版工作流的重点是直接在 OBJ/SOP 上串接 RBD 节点，而不是回到旧式独立动态网络里手工搭整套求解环境。
这张图继续 `UV、RBD` 段的实际接线：把 `assemble1` 直接输入到 `rbdbulletsolver1`，用 SOP 级的 Bullet 求解节点快速得到不需要大定制的基础破碎模拟。

已确认信息：
- 当前网络主链已经延伸为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1 -> rbdbulletsolver1`
- 旁边还能看到一个绿色的 `dopnet1` 节点，但当前实际使用的是 `rbdbulletsolver1` 这条更便捷的 SOP 求解器链。
- 当前选中节点为 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧参数面板可确认：
  - `Start Frame = 1`
  - `Time Scale = 1`
  - `Global Substeps = 1`
  - `Bullet Substeps = 10`
  - `Constraint Iterations = 10`
  - `Cache Memory (MB)` 已勾选，值为 `5000`
- 面板底部 `Input Operators` 显示当前输入源为 `assemble1`。

画面用途：
- 说明对于“不需要太定制的简单模拟”，直接把打包好的碎片喂给 `RBD Bullet Solver` 就足够得到可用结果，不必手工搭整套复杂动态网络。
这张图仍在 `UV、RBD` 段，继续展示 `rbdbulletsolver1` 的较高层配置页，强调即使暂时不完全理解底层求解细节，也可以先沿用预设完成一套可工作的模拟设置。

已确认信息：
- 当前主链仍为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1 -> rbdbulletsolver1`
- `rbdbulletsolver1` 仍被选中，右侧参数面板切换到了约束/引导相关分页。
- 当前可见页签区域包括：
  - `Setup`
  - `Prop...`
  - `Colli...`
  - `Forces`
  - `Const...`
  - `Guide`
  - `Visu...`
  - `Adva...`
  - `Output`
- 在当前页可确认的项目有：
  - `Constraint Solver = Graph Coloring`
  - `Overwrite with SOP` 选项存在
  - 约束类别分组包含 `Glue`、`Soft`、`Hard`、`ConeTwist`、`Slider`
  - `Guide` 区中 `Use Pre-Configured Setup` 已勾选
  - `Guided Neighbors` 选项存在
- 底部 `Input Operators` 仍显示输入为 `assemble1`。

画面用途：
- 这一步强调新版 `RBD Bullet Solver` 已经把许多原本分散在动态网络中的配置整合成可直接勾选的高层参数，先用预设快速跑通，再逐步深入即可。

### 00:27:11-00:30:08 Niagara、网格、碰撞

- 本段定位：Niagara、网格、碰撞。
- 知识点：我们这里要看的内容是, 与属性相关的内容, 以及与冲突相关的部分, 还有这里的力。
- 知识点：力是非常简单的, 这里会应用重力值。
- 知识点：而且这里的拖拽可以看作, 和在尼亚加拉中使用的拖拽类似的概念。
- 知识点：其实然后这里现在要用一个碰撞网格, 原本这里是地面。
- 知识点：在虚幻中制作的序列播放, 比如说在这里跳跃, 然后角色在这里着陆的时钟。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Niagara`、`序列`、`碰撞`。

**关键画面：**

这张图对应 `00:27:11-00:30:08 Niagara、网格、碰撞` 段开头，回到 `rbdbulletsolver1` 的碎片物理参数页，开始说明与属性、碰撞和受力相关的基础控制。

已确认信息：
- 当前主链仍为：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1 -> rbdbulletsolver1`
- 当前选中节点是 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧参数面板当前页可确认：
  - `Collision Padding = 0.02`
  - `Density = 1000`
  - `Rotational Stiffness = 1`
  - `Bounce = 0.25`
  - `Friction = 1`
  - `Override Attributes` 区域已启用，可见属性名列表包含 `active`、`animated`、`deforming` 等
  - `Sleeping`：
    - `Linear Threshold = 0.8`
    - `Angular Threshold = 1`
- 底部 `Input Operators` 仍显示输入来自 `assemble1`。

画面用途：
- 这一步把碎片刚体的基本物理属性集中在一个求解节点里调整，对应教程所说“属性相关的内容、碰撞部分、还有这里的力”。
这张图继续 `Niagara、网格、碰撞` 段，单独放入一个 `sphere2` 节点作为碰撞体来源，说明当前模拟不是只靠地面，而是会用额外几何体去驱动碎片碰撞。

已确认信息：
- 当前网络除了主模拟链：
  - `box1 -> uvtexture1 -> uvedit1 -> attribadjustcolor1 -> attribremap1 -> scatter1 -> voronoifracture1 -> assemble1 -> rbdbulletsolver1`
  之外，还新增了一个独立的 `sphere2` 节点。
- 当前选中节点为 `Sphere sphere2`。
- 右侧参数面板可确认：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Radius = (0.5, 0.5, 0.5)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Orientation = Y Axis`
  - `Rows = 13`
  - `Columns = 24`
  - `Unique Points per Pole` 已勾选
  - `Accurate Bounds` 已勾选
  - `Triangular Poles` 已勾选
- 左侧视口只显示一整块平板地面，说明碰撞球当前还未进入结果预览，画面重点是在先准备碰撞几何本身。

画面用途：
- 这一步为后续碎片模拟准备一个可移动、可作为着陆/撞击触发器的碰撞网格，对应正文里“原本这里是地面”“会用一个碰撞网格”的说明。
这张图是 `Niagara、网格、碰撞` 段把碰撞链真正接到求解器上的结果：`sphere2` 已被接入 `rbdbulletsolver1` 作为碰撞几何，同时还保留地面碰撞设置。

已确认信息：
- 当前网络可见关系为：
  - `assemble1 -> rbdbulletsolver1`
  - `sphere2 -> rbdbulletsolver1`
  - 旁边仍保留 `dopnet1`
- 当前选中节点仍为 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧参数面板当前在碰撞相关页，可确认：
  - `Collision Geometry` 已启用
  - `Collision Type = Animated`
  - `Collision Shape = Convex Hull`
  - `Collision Padding = 0.02`
  - 该碰撞体的 `Bounce = 0.5`
  - 该碰撞体的 `Friction = 1`
  - `Ground Collision` 已启用
  - `Ground Type = Ground Plane`
  - `Position = (0, 0, 0)`
  - `Rotation = (0, 0, 0)`
  - 地面物理参数：
    - `Bounce = 0.5`
    - `Friction = 1`
    - `Dynamic Friction Scale = 1`
- 底部 `Input Operators` 当前列出了至少三项输入：`assemble1`、地面/碰撞相关项，以及 `sphere2`。
- 左侧视口能看到一块平面地面和一个蓝色半球/球体碰撞物，说明当前正在预备一个角色落地或击中地面的碰撞触发情境。

画面用途：
- 这一步把碎片刚体、地面和平移/动画碰撞体真正汇总到同一个 Bullet 求解器里，为后续在 Unreal/Niagara 中复现角色落地击碎地面的时间点和碰撞行为做准备。

### 00:30:19-00:30:31 碰撞

- 本段定位：碰撞。
- 知识点：中心值设为-0.1, 还有这里有碰撞类型, 可以使用静态对象, 可以使用静态对象, 包含字幕和广告。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这张图对应 `00:30:19-00:30:31 碰撞` 段的第一帧，是对碰撞设置的近景补充，重点展示 `sphere2` 已经作为动画碰撞体接入 Bullet 求解器，并与地面平面共同构成碰撞环境。

已确认信息：
- 当前可见网络关系为：
  - `assemble1 -> rbdbulletsolver1`
  - `sphere2 -> rbdbulletsolver1`
- 当前选中节点仍为 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧碰撞相关参数可确认：
  - `Collision Geometry` 已启用
  - `Collision Type = Animated`
  - `Collision Shape = Convex Hull`
  - `Collision Padding = 0.02`
  - 碰撞体 `Bounce = 0.5`
  - 碰撞体 `Friction = 1`
  - `Ground Collision` 已启用
  - `Ground Type = Ground Plane`
  - `Position = (0, 0, 0)`
  - `Rotation = (0, 0, 0)`
  - 地面 `Bounce = 0.5`
  - 地面 `Friction = 1`
  - `Dynamic Friction Scale = 1`
- 左侧视口能看到蓝色半球状碰撞体已经落在平板地面上方/表面附近，说明当前画面是在核对实际碰撞布置位置。

画面用途：
- 这一帧用于集中确认碰撞求解所依赖的几何类型、碰撞形状和地面参数，保证后续落地/撞击时序能够稳定触发。
这张图继续 `碰撞` 段，对 `rbdbulletsolver1` 的 `Collision Type` 下拉菜单做了放大说明，强调碰撞体可以根据是否运动或变形切换不同模式。

已确认信息：
- 当前仍是 `sphere2 -> rbdbulletsolver1` 的碰撞设置画面，左侧视口中的蓝色半球碰撞体位置未变。
- 当前选中节点仍为 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧 `Collision Geometry` 区域中 `Collision Type` 下拉菜单已经展开，可见三个可选项：
  - `Static`
  - `Animated`
  - `Deforming`
- `Collision Shape` 仍显示为 `Convex Hull`。
- 其余当前可见碰撞参数保持与上一张一致：
  - `Collision Padding = 0.02`
  - 碰撞体 `Bounce = 0.5`
  - 碰撞体 `Friction = 1`
  - `Ground Type = Ground Plane`

画面用途：
- 这一帧用于明确碰撞网格不是固定只有一种输入方式：静态对象可用 `Static`，带动画位移的物体可用 `Animated`，发生形变的碰撞体则可切到 `Deforming`。
这张图是 `碰撞` 段最后一帧，对上一张的碰撞类型说明做了落点确认：如果碰撞对象本身不运动，就可以直接把 `Collision Type` 设为 `Static`。

已确认信息：
- 当前网络与上一张一致，`sphere2` 仍作为碰撞输入接到 `rbdbulletsolver1`。
- 当前选中节点仍为 `RBD Bullet Solver rbdbulletsolver1`。
- 右侧 `Collision Geometry` 区域中，`Collision Type` 下拉菜单依旧展开，当前高亮项为：
  - `Static`
- 菜单中仍能看到其余可选项：
  - `Animated`
  - `Deforming`
- 其他当前可见碰撞设置保持不变：
  - `Collision Shape = Convex Hull`
  - `Collision Padding = 0.02`
  - `Ground Type = Ground Plane`
  - 地面与碰撞体的 `Bounce/Friction` 设置仍在右侧面板中保留
- 左侧视口中蓝色半球碰撞体和地面位置未变，说明这里的重点不是调整几何，而是确认“静态碰撞体应该选哪种模式”。

画面用途：
- 用最短示例把碰撞类型选择规则落地：静止物体用 `Static`，这样在后续 Unreal/Niagara 联动或求解预览时更容易保持稳定和低开销。

## 补充视觉证据

### S01 00:02:06

这是对 `p16.md` 首段 `00:00:05-00:02:45 网格、只带来了那些部分、在游戏中有这样的物理模拟素材都是很少见的` 的补充截图，进一步确认教程最开始确实只是用一个最基础的 `box1` 作为起点，而不是复杂导入模型。

已确认信息：
- 当前位于 `/obj/geo1`。
- 网络视图中只有一个被选中的 `box1` 节点。
- 左侧视口里只看到一个简单块体的局部，没有裂纹、布线、散点或其他处理节点。
- 右侧 `Box box1` 参数面板可见：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Consolidate Corner Points` 已勾选
  - `Size = (1, 1, 1)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (2, 2, 2)`

画面用途：
- 这张补图强化了本课的起点假设：先从最低复杂度、最可控的基础几何体出发，再逐步叠加 UV、破碎、RBD 和碰撞流程。

### S02 00:04:24

这是对 `00:02:49-00:05:45 UV、网格` 段的补充参数截图，明确展示了把原始盒体压成薄板并下移半个厚度的具体数值。

已确认信息：
- 当前仍位于 `/obj/geo1`，网络中只有 `box1`。
- 左侧视口显示的是规则分格的矩形薄板。
- 右侧 `Box box1` 参数面板可确认：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Consolidate Corner Points` 已勾选
  - `Size = (8, 0.05, 8)`
  - `Center = (0, -0.025, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (5, 2, 5)`
- 其中 `Center.y = -0.025` 正好等于厚度 `0.05` 的一半，说明作者把板体向下移动半个厚度，使上表面贴近基准高度。

画面用途：
- 这张补图把“薄板化”和“位置校正”两步的参数一次钉死，便于后续复建时得到一致的初始地面板。

### S03 00:07:18

这是对 `00:05:49-00:08:46 UV、Noise` 段的补充截图，明确展示在 `uvtexture1` 之后用 `uvedit1` 对整张 UV 进行缩放和平移整理的数值。

已确认信息：
- 当前链路为：
  - `box1 -> uvtexture1 -> uvedit1`
- 当前选中节点为 `UV Edit uvedit1`。
- 右侧参数面板可确认：
  - `Group = 0-47`
  - `Group Type = Primitives`
  - `UV Attribute = uv`
  - `Transform Order = Scale Rot Trans`
  - `Translate = (0.503717, 0.498225, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (0.124614, 0.124614, 1)`
  - `Shear = (0, 0, 0)`
  - `Pivot = (-2.38419e-07, 0, 2)`
  - `Soft Radius = 0`
- 左侧视口中棋盘编号贴图已经被均匀缩小并塞入整块板面，说明 `uvedit1` 正在把后续破碎所需的 UV 布局压缩到统一尺度。
- 中央还打开了 Tab 菜单，说明作者接下来就要从这一步继续往下添加新的节点分支。

画面用途：
- 这张补图把 UV 变换的核心参数一次确认完整，方便后续按同样的 UV 密度继续做散点、Voronoi 和遮罩控制。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


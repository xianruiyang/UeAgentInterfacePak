# 13 - 9-1HoodiniMessi资源生产01

# 13 - 9-1HoodiniMessi资源生产01

## 关键术语

- `UV`、`Blender`、`SD`、`材质`、`精灵`、`网格`、`贴图`、`纹理`、`曲线`、`Niagara`、`Normalized Age`、`生命周期`、`颜色`、`火焰`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`

## 分段知识

### 00:00:00-00:02:40 SD、网格、颜色

- 本段定位：SD、网格、颜色。
- 知识点：,呃,这次后续会正式开始制作非常简单的网格。
- 知识点：,制作这个词可能不太合适,因为形状非常简单。
- 知识点：呢,我们还会看看如何在试口中修改这些多边形选择操作的方法。
- 知识点：首先我们需要创建一个二面体,就是制作一个容器。
- 知识点：需要先放出一个可以测试的球形网格,按下SD键,这个试图就会对焦。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图是新章节 `9-1 Houdini 资源生产 01` 的起始画面，用来说明本节将从空场景开始，正式进入一个非常简单的网格制作流程。

- 当前软件仍是 `Houdini Indie Limited-Commercial 20.5.332 - Py3.11`。
- 顶部路径栏处于 `obj` 层。
- 界面分成 3 个主要区域：
  - 左侧 `Scene View`：空白透视视口，顶部显示 `Persp` 与 `No cam`
  - 中央 `Objects` 网络区：当前没有任何对象节点，画面中央能看到 `Empty Network` 与 `Press Tab to Add Nodes`
  - 右侧 `Parameters` 面板：当前没有选中任何操作器，显示 `No Operator Selected`
- 左下还保留 `Render Scheduler`、`Geometry Spreadsheet`、`Tree View` 等辅助面板，说明作者仍使用标准的多窗格布局。
- 结合本段正文“正式开始制作非常简单的网格”“先制作一个容器”，这张图的意义是把环境重置到最原始状态：从 `obj` 空网络开始，准备创建新的几何对象，而不是在既有示例文件上继续修改。
这张图已经进入 `geo1` 容器并放出了一个测试球体，用来作为后续多边形选择、形状修改和颜色调整的基础几何。

- 当前顶部路径栏位于 `obj > geo1`。
- 中央 `Geometry` 网络区只放了一个节点：`sphere1`。
- 左侧视口中已显示球体网格，说明该节点当前正作为可见输出。
- 右侧 `Sphere sphere1` 参数面板中可确认：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Radius = (0.5, 0.5, 0.5)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Orientation = Y Axis`
  - `Frequency = 1`
  - `Rows = 13`
  - `Columns = 24`
- 可见开关状态：
  - `Imperfect = 开启`
  - `Unique Points per Pole = 关闭`
  - `Accurate Bounds = 开启`
  - `Triangular Poles = 开启`
- 画面右下角还弹出了一个形状/预设选择面板，里面能看到多种基础形体缩略图，当前高亮的是左上角的球形选项。这说明作者在示范：除了球体，还可以从同一类基础图元里切换到其他简单形状。
- 结合正文“先放出一个可以测试的球形网格，按下 SD 键，视图就会对焦”，这张图的重点是先建立一个简单、易观察的测试几何，为后续网格编辑和颜色测试提供统一基础。
这张图在测试球体后面接入了一个 `transform1` 节点，开始把“放出基础网格”推进到“对基础网格做最简单的修改链”。

- 当前路径仍在 `obj > geo1`。
- 中央 `Geometry` 网络区中，节点链已经变成：
  - `sphere1`
  - `transform1`
- 左侧视口继续显示球体，说明当前链条仍然以这个球体为可见输出。
- 当前选中的是 `transform1`，右侧 `Transform transform1` 参数面板可确认：
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1, 1)`
  - `Shear = (0, 0, 0)`
  - `Uniform Scale = 1`
- `Attributes` 分组中可见：
  - `Recompute Point Normals = 开启`
  - `Recompute Affected Normals = 开启`
  - `Preserve Normal Length = 开启`
  - `Invert Transformation = 关闭`
- 右下角仍能看到基础形体缩略图列表，说明作者还在用最基础的图元与变换节点做入门示范，而不是切到复杂建模。
- 结合本段正文“我们还会看看如何在视口中修改这些多边形选择操作的方法”，这张图的作用是先搭好一个最小可编辑链条：基础网格 `sphere1` 负责提供形体，`transform1` 负责施加位置/旋转/缩放等后续调整，为接下来更具体的视口控制和选择编辑做准备。

### 00:02:44-00:07:26 UV

- 本段定位：UV。
- 知识点：因为我有很多要说的,那么我们来谈谈如何在这个试口中进行控制。
- 知识点：首先最重要的是,这里现在是可以进行移动试口的控制状态。
- 知识点：,关于这个消息集合体的部分,您可以理解为处于无法点击的状态。
- 知识点：当它处于开启状态时,在这里点击鼠标按钮,就可以转换为选择模式。
- 知识点：,在选择模式中,最重要的是点点表面。
- 知识点：您可观察到这三种,实际上只用这三种也不会有什么太大问题。
- 知识点：选择点是可以通过拖拽的方式,只选择想要的部分。

**关键画面：**

这张图开始进入视口操作说明。作者仍然使用 `sphere1 -> transform1` 的最小链条，但此时的重点已经不是节点本身，而是解释当前视口处于“只移动观察”的控制状态，还没有切换到多边形元素选择。

- 当前路径仍在 `obj > geo1`。
- 中央网络区可见：
  - `sphere1`
  - `transform1`
- 当前选中节点是 `transform1`，但右侧参数面板当前仍显示的是 `Sphere sphere1` 的参数：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Radius = (0.5, 0.5, 0.5)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Orientation = Y Axis`
  - `Frequency = 1`
  - `Rows = 13`
  - `Columns = 24`
- 左侧视口中显示测试球体，当前没有任何点、边或面被高亮选中。
- 右下仍可见基础形体缩略图列表，说明作者还停留在基础图元演示阶段。
- 结合正文“现在是可以仅移动视口的控制状态”“集合体部分可以理解为处于无法点击的状态”，这张图表达的是：
  - 当前主要是观察/导航模式；
  - 此时用户可以旋转、平移、缩放视口来看模型；
  - 但还没有进入直接点选几何元素的编辑选择模式。
这张图已经切换到几何元素选择与编辑状态，作者开始示范如何在球体上选中一圈顶部点，并通过 `Edit` 节点直接在视口里缩放所选区域。

- 当前网络链已经扩展为：
  - `sphere1`
  - `transform1`
  - `edit1`
- 当前选中节点：`edit1`
- 左侧视口左上角当前工具模式明确显示为 `Scale`，说明正在使用缩放操作器编辑已选中的点。
- 球体顶部有一圈点以黄色高亮显示，表示这些点已经被选中，正在作为本次编辑的作用对象。
- 视口下方提示文字为 `Transform selected geometry.`，进一步确认当前操作是在直接变换被选中的几何元素。
- 右侧 `Edit edit1` 面板中可确认：
  - `Group = 0 2-36 48-58`
  - `Group Type = Points`
  - 当前处于 `Edit` 页而非 `Sculpt` 页
- `Transform` 分组中可见：
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1, 1)`
  - `Shear = (0, 0, 0)`
- 下方 `Transform Space Settings` 与 `Soft Settings` 中能确认：
  - `Transform Space = Global`
  - `Local Frame = Component`
  - `Slide on Surface = 关闭`
  - `Soft Radius = 0`
  - `Soft Type = Cubic`
- 这张图对应正文“在选择模式中，最重要的是点、边、面”“选择点可以通过拖拽方式只选想要的部分”的说明，核心流程是：
  - 先进入选择模式；
  - 把需要编辑的一圈点作为 `Group` 选中；
  - 再通过 `edit1` 的视口变换工具直接缩放或移动这些点。
这张图继续使用 `edit1` 在球体上做点级编辑，但相比上一张，作者已经切换到另一组点，并开始沿单一方向缩放，从而让球体局部出现更明确的形变。

- 当前网络链仍为：
  - `sphere1`
  - `transform1`
  - `edit1`
- 当前选中节点：`edit1`
- 左侧视口左上角工具模式仍显示 `Scale`，并能看到缩放手柄与轴向标识，说明当前操作是直接拖动单轴缩放控制器。
- 球体中上部有一圈点被选中，高亮颜色比周围网格更明显，且局部已经呈现轻微收缩/鼓起的轮廓变化。
- 视口底部提示仍为 `Transform selected geometry.`，左下还能看到用于调整软选择影响范围的 `rad` 滑条，当前值为 `0`。
- 右侧 `Edit edit1` 参数面板中当前能确认：
  - `Group = 74-97`
  - `Group Type = Points`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (0.947079, 1, 1)`
  - `Shear = (0, 0, 0)`
- 下方设置保持：
  - `Transform Space = Global`
  - `Local Frame = Component`
  - `Slide on Surface = 关闭`
  - `Soft Radius = 0`
  - `Soft Type = Cubic`
- 这张图对应正文“控制这些点时，如果只拖动 x 轴”的说明，核心意思是：
  - 进入点选择模式后，可以把某一圈点单独作为组；
  - 通过单轴缩放只改变一个方向上的尺寸；
  - 这样能在保持整体球体基础结构的前提下，快速塑造局部不对称或功能性轮廓。

### 00:07:32-00:12:08 关键流程 03

- 本段定位：关键流程 03。
- 知识点：如果这样更方便的话,这样做就更直观。
- 知识点：比如说可以输入竖直,然后, 就可以这样制作出这个形状了。
- 知识点：这样直接移动点,来制作形状的方式。
- 知识点：比如说,有时候,如果某个部分希望更加流畅的话, 可以直接选择这个部分。
- 知识点：,是的,您可以这样来创建这个形状。
- 知识点：在这里的延长线情况下,可以再切换回选择模式。
- 知识点：比如说,您可以在这里的延长线情况下, 可以再切换回选择模式。

**关键画面：**

这张图把上一段的点选择编辑推进成一个更明确的造型结果：通过 `edit1` 直接输入缩放数值，把球体顶部一圈点扩成明显的平台/帽檐形状。

- 当前网络链保持为：
  - `sphere1`
  - `transform1`
  - `edit1`
- 当前选中节点：`edit1`
- 左侧视口中，球体上半部已经出现一个向外扩张的平顶轮廓，顶部中间仍保留半球状凸起，说明当前编辑只影响了中上部的一圈点，而不是整个球体。
- 右侧 `Edit edit1` 参数面板可确认：
  - `Group = 74-97`
  - `Group Type = Points`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (2, 1, 2)`
  - `Shear = (0, 0, 0)`
- 其他可见设置保持：
  - `Transform Space = Global`
  - `Local Frame = Component`
  - `Slide on Surface = 关闭`
  - `Soft Radius = 0`
  - `Soft Type = Cubic`
- 这张图对应正文“如果这样更方便的话，这样做更直观。可以输入数值”的说明，核心意思是：
  - 不一定每次都要纯手拖视口句柄；
  - 对于规则造型，直接在 `Scale` 中输入精确数值更清楚；
  - 这里通过把 X/Z 缩放设为 `2`，快速把一圈点横向撑开，得到更明确的基础外轮廓。
这张图把编辑对象从“点组”切换成了“面片组”，并通过缩放工具把一整圈 primitive 直接拉成更宽、更高的平台结构。

- 当前网络链仍是：
  - `sphere1`
  - `transform1`
  - `edit1`
- 当前选中节点仍为 `edit1`。
- 左侧视口中可见：
  - 球体中上部有一大片橙色高亮区域，表示当前选中的不再是离散点，而是一圈连续的面片/primitive。
  - 顶部存在纵向缩放手柄，说明作者正在沿竖直方向配合缩放模式调整这部分几何。
  - 选中的平台区域已经被明显向外扩展，并与下方球体主体形成清晰的层级分离。
- 右侧 `Edit edit1` 参数面板中可确认：
  - `Group = 72-95`
  - `Group Type = Primitives`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1.40343, 1)`
  - `Shear = (0, 0, 0)`
- 其他可见设置保持：
  - `Transform Space = Global`
  - `Local Frame = Component`
  - `Slide on Surface = 关闭`
- 这张图对应正文“可以输入竖直，然后就可以这样制作出这个形状了”的说明，关键点是：
  - 选择模式可以不只选点，也可以直接选面；
  - 选中一圈 primitive 后，只在竖直方向缩放或拉伸，就能更直观地把局部轮廓做成台面/帽檐；
  - 这种方式比逐点微调更适合快速得到规则的大轮廓。
这张图延续 `edit1` 的 primitive 编辑，但已经把局部平台进一步放大成更完整的“帽檐”造型，并切回 `Select` 模式，准备继续按需要重新选择局部做微调。

- 当前网络链保持为：
  - `sphere1`
  - `transform1`
  - `edit1`
- 当前选中节点仍为 `edit1`。
- 左侧视口左上角模式已经从 `Scale` 变成 `Select`，说明这一轮缩放操作已结束，作者正在回到选择状态准备继续编辑。
- 球体上半部已形成一个明显向外展开的盘状帽檐，顶部中间保持圆滑隆起，下半部仍保留球体主体，因此整体更接近一个带帽檐的蘑菇/火焰基底轮廓。
- 右侧 `Edit edit1` 参数面板中可确认：
  - `Group = 72-95`
  - `Group Type = Primitives`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1.54694, 1)`
  - `Shear = (0, 0, 0)`
- 视口底部提示为：
  - `Select the geometry, then choose an operation to perform.`
  - 并附带 `Hold A ... loops`、`Hold H ... flood fill` 一类选择辅助提示。
- 这张图对应正文“如果某个部分希望更加流畅的话，可以直接选择这个部分”“可以再切换回选择模式”的说明，核心意思是：
  - 一次缩放得到大致轮廓后，不必停在变换工具里；
  - 可以切回选择模式，重新圈定别的区域；
  - 再继续局部优化，让整体轮廓逐步变得更顺、更接近目标造型。

### 00:12:09-00:15:00 精灵、网格、火焰

- 本段定位：精灵、网格、火焰。
- 知识点：我在思考,不过我还是强烈推荐您尝验证效果,根据自己的风格进行更多的自定义。
- 知识点：而且,我和我一起制作的形状一旦创建后,就会更容易再次进行控制。
- 知识点：我认为在这两个小时内,制作的形状大致可以实现所有效果。
- 知识点：点击这里的名称,部分就可以自由命名。
- 知识点：我们现在最基本的形状就是这个计划。
- 核对对象：`火焰`。

**关键画面：**

这张图从更正的正视角度复核当前的基础造型，强调这不是一次性随手变形，而是要整理出一个之后能同时服务于精灵、网格和火焰表现的“母形”。

- 当前网络链仍停留在：
  - `transform1`
  - `edit1`
  截图中上游 `sphere1` 节点已超出可视区域顶部，但从链条连续性可判断仍在其上方。
- 当前选中节点：`edit1`
- 左侧视口左上角模式显示为 `Select`，说明当前处于选择检查状态，而不是继续拖动变换句柄。
- 视口中的模型已形成明确的两段式轮廓：
  - 下半部分保留球体主体；
  - 中上部形成一圈向外伸出的帽檐/盘状结构；
  - 顶部中央仍保持圆滑隆起。
- 视口里帽檐下方的一圈边线呈高亮黄色，表明当前仍然在检查与选择这部分外扩结构对应的 primitive 区域。
- 右侧 `Edit edit1` 参数面板可确认：
  - `Group = 72-95`
  - `Group Type = Primitives`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序为 `Rx Ry Rz`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1.54694, 1)`
  - `Shear = (0, 0, 0)`
- 这张图与本段“精灵、网格、火焰”标题对应的含义是：
  - 作者先定义一个基础几何母形；
  - 后续无论是做 mesh、sprite 参考还是火焰轮廓控制，都可以围绕这个母形继续微调；
  - 因此这一步的重点不只是把形状做出来，而是把它整理成后续容易再控制的基础版本。
这张图把示例对象从球体/帽檐母形切换成一个平面网格，说明作者开始为后续精灵、火焰或贴片式表现准备更适合 2D 展开的基础几何。

- 当前顶部路径栏位于 `obj > Plane`。
- 中央 `Geometry` 网络区只包含一个节点：`grid1`
- 左侧视口显示的是一个规则平面网格，中央有一个高亮选中的面片，说明作者此时在演示平面上的选择方式。
- 左上角工具模式为 `Select`，视口底部提示：
  - `Select the geometry, then choose an operation to perform.`
  - 并附带 `Hold A ... loops`、`Hold H ... flood fill` 等选择辅助说明。
- 右侧 `Grid grid1` 参数面板中可确认：
  - `Primitive Type = Polygon`
  - `Connectivity = Quadrilaterals`
  - `Orientation = ZX Plane`
  - `Size = (10, 10)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Rows = 10`
  - `Columns = 10`
- 可见开关状态：
  - `End-point interpolate in U = 开启`
  - `End-point interpolate in V = 开启`
- 这张图对应正文“我们现在最基本的形状就是这个平面”“点击名称部分就可以自由命名”的说明，核心意思是：
  - 除了球体这类体块母形，作者还会建立一个规则平面作为另一类基础网格；
  - 对于精灵、火焰、贴图承载面等效果，平面网格往往比球体更直接；
  - 后续 UV、纹理与火焰图样的控制，也会更容易围绕这种规则平面展开。
这张图继续使用 `grid1`，把基础平面调整成更长的长方形比例，作为后续 UV、纹理和火焰贴片的更直接承载面。

- 当前路径仍在 `obj > Plane`。
- 中央 `Geometry` 网络区中只有一个节点：`grid1`
- 左侧视口中的平面已经不再接近正方形，而是被拉成长矩形，说明作者正在用 `Grid` 的尺寸参数快速定义贴片比例。
- 右侧 `Grid grid1` 参数面板中可确认：
  - `Primitive Type = Polygon`
  - `Connectivity = Quadrilaterals`
  - `Orientation = ZX Plane`
  - `Size = (20, 10)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Rows = 10`
  - `Columns = 10`
- 可见开关状态保持：
  - `End-point interpolate in U = 开启`
  - `End-point interpolate in V = 开启`
- 这张图对应正文“所以我先给您展示一下基本平面”的说明，关键点是：
  - 作者不只是创建任意一个平面，而是在主动定义一个更适合后续贴图展开和火焰形状控制的基础长宽比；
  - 通过直接改 `Size`，可以非常快地得到想要的贴片底板；
  - 这一步为紧接着的 `UV、纹理` 段建立了最直接的几何基础。

### 00:15:04-00:17:45 UV、纹理

- 本段定位：UV、纹理。
- 知识点：而且在这里的方向中,可以选择方向性。
- 知识点：比如说,那我们就设定为XY来看看吧。
- 知识点：但是通常情况下,如果分割得太细的话, 这个纹理可能就不会很详细。
- 知识点：那大多数情况下,UV会使用一些自动UV功能。
- 知识点：专业的详细处理UV的方式,通常需要使用全新的工具。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

当前仍在 `obj > Plane`，节点图只有 `grid1`，左侧透视视口显示一张白色平面，右侧参数面板正在说明这个 `Grid` 的朝向可切换，用于后续 UV/纹理方向控制。

`Grid grid1` 当前可确认的设置：
- `Primitive Type = Polygon`
- `Connectivity = Quadrilaterals`
- `Orientation` 字段当前显示为 `ZX Plane`
- `Orientation` 下拉菜单已展开，可见候选项至少包括 `XY Plane`、`YZ Plane`、`ZX Plane`
- `Rows = 2`
- `Columns = 2`
- `End-point interpolate in U` = 开启
- `End-point interpolate in V` = 开启

这一步的作用是先在 `grid1` 上检查并准备切换平面的朝向选项。结合正文“可以选择方向性、例如设为 XY”可知，这里强调的是 UV/纹理投射方向需要先通过 `Orientation` 决定；本图本身只展示到下拉菜单被打开，尚未看到新的朝向已经被正式选定。
在 `grid1` 后面新增了 `UV Texture uvtexture1` 节点，并把它接在 `grid1` 的输出之后。左侧视口切到 `uv` 相关预览，当前展开了视口菜单，说明作者正在检查 UV 显示是否正确。

节点连接：
- `grid1 -> uvtexture1`

`UV Texture uvtexture1` 当前可确认的参数：
- `UV Attribute = uv`
- `Group` 未见填写
- `Texture Type = Orthographic`
- `Projection Axis = Y Axis`
- `Attribute Class = Vertex`
- `Scale = (1, 1, 1)`
- `Offset = (0, 0, 0)`
- `Angle = 0`
- `Fix Boundary Seams` 未开启

左侧 UV 预览没有形成正常铺开的平面 UV，而是显示异常。结合画面字幕“因为现在是 Y 轴，所以 UV 似乎没有正确显示”可知，这一步是在证明：如果投射轴保持为 `Y Axis`，当前平面的 UV/纹理投射方向不对，需要继续调整轴向或观察方式。
这一步回到 `grid1` 节点本身调整平面方向和分段。左侧透视视口已经能看到一张竖直立起、表面带棋盘编号纹理的平面，说明当前朝向与 UV 投射已对齐，纹理显示恢复正常。

节点关系仍为：
- `grid1 -> uvtexture1`

`Grid grid1` 当前可确认的参数：
- `Primitive Type = Polygon`
- `Connectivity = Quadrilaterals`
- `Orientation = XY Plane`
- `Size = (10, 10)`
- `Center = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Rows = 4`
- `Columns = 15`
- `End-point interpolate in U` = 开启
- `End-point interpolate in V` = 开启

从画面和字幕“这里的长柱可以左右切割，尺寸可以根据刚才提到的进行调整”可以确认，这一步是在把原始平面改成更适合长条纹理/贴片的分割方式：通过将朝向切到 `XY Plane`，再把 `Columns` 提高到 `15`、`Rows` 保持较低值 `4`，让平面在宽度方向形成更多切片，便于后续沿长边布置纹理或火焰贴片。

### 00:17:52-00:21:47 UV、网格、曲线

- 本段定位：UV、网格、曲线。
- 知识点：使用变换节点,也可以给出这种旋转值。
- 知识点：可以将其围绕外轴旋转大约90度来看。
- 知识点：因为UV已经生成,所以即使变形网格UV设置也会保持不变。
- 知识点：合并后呢,会形成这种十字网格形状。
- 知识点：像这种十字网格,由于我们的网格固定在轴上, 可以让SPEC一直朝向相机。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`曲线`。

**关键画面：**

当前节点链已经从平面与 UV 生成继续延伸，在 `uvtexture1` 后面新接入一个 `Transform transform1`，用于直接对已经带 UV 的网格做变换。左侧透视视口仍显示一张带棋盘编号纹理的竖直平面，说明此时只是插入变换节点，几何外形还没有发生明显改变。

节点连接：
- `grid1 -> uvtexture1 -> transform1`

`Transform transform1` 当前可确认的设置：
- `Group` 未填写
- `Group Type = Guess from Group`
- `Transform Order = Scale Rot Trans`
- 旋转顺序显示为 `Rx Ry Rz`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Uniform Scale = 1`
- `Recompute Point Normals` = 开启
- `Recompute Affected Normals` = 开启
- `Preserve Normal Length` = 开启

这一步的重点是把后续形变控制转交给 `transform1`。结合字幕“直接使用变换节点”可知，作者没有再插入额外造型节点，而是准备在已有 UV 不丢失的前提下，通过 `transform1` 直接给网格施加旋转或缩放。
这一帧在原始平面和变换副本之后又加入了一个 `merge1`，把未旋转的平面与 `transform1` 输出的副本合并。左侧视口显示的是两张带相同棋盘纹理的平面在中线相接，形成一个夹角结构，说明副本已经围绕边轴被翻转到侧面。

节点连接：
- `grid1 -> uvtexture1`
- `uvtexture1 -> merge1`
- `uvtexture1 -> transform1 -> merge1`

当前图中能直接确认的设置：
- `grid1` 仍为 `Orientation = XY Plane`
- `grid1` 当前可见分段为 `Rows = 4`、`Columns = 4`
- `transform1` 已经生效，用于把同一份带 UV 的平面复制后旋转到侧面
- `merge1` 用于把原平面和旋转后的副本合并成一个整体

结合正文“可以将其围绕外轴旋转大约 90 度来看”“因为 UV 已经生成，所以即使变形网格 UV 设置也会保持不变”可知，这一步的目标是：先保留原始贴图平面，再复制一份并通过 `transform1` 围绕外侧边轴大约旋转 `90` 度，最后用 `merge1` 合并。这样即使网格折成夹角形，两个面仍沿用前面已经生成的 UV。当前截图没有显示 `transform1` 的精确旋转分量，因此只能确认“大约 90 度侧向翻折”，不能从图上直接读出具体轴向数值。
在前一步的夹角双面网格之后，又新增了一个 `Transform transform2` 接在 `merge1` 后面，用来整体放大已经合并好的网格。左侧视口能看到两张互相垂直的贴图平面已经形成“十字/十字夹角”式固定轴网格，纹理仍然保持在两个面上，没有因为变换而丢失。

节点连接：
- `grid1 -> uvtexture1`
- `uvtexture1 -> transform1 -> merge1`
- `uvtexture1 -> merge1`
- `merge1 -> transform2`

`Transform transform2` 当前可确认的设置：
- `Group` 未填写
- `Group Type = Guess from Group`
- `Transform Order = Scale Rot Trans`
- 旋转顺序显示为 `Rx Ry Rz`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Uniform Scale = 4.12`
- `Recompute Point Normals` = 开启
- `Recompute Affected Normals` = 开启
- `Preserve Normal Length` = 开启

结合正文“合并后会形成十字网格形状”“这种十字网格由于固定在轴上，可以让 Spec 一直朝向相机”可知，这一步的目标是把已经由 `merge1` 合出的双面网格作为一个整体继续放大，得到更适合做面片特效的固定轴十字网格。画面右侧没有展开 `Pivot Transform`，因此无法仅凭本图确认是否在缩放前额外调整了枢轴点；能确认的是作者已经通过 `transform2` 对整个合并结果执行统一放大。

### 00:21:50-00:24:45 网格、纹理

- 本段定位：网格、纹理。
- 知识点：请始终考虑您想要表达的轴心,进行设置并带走。
- 知识点：如果将其指点对准中心的话,就是这样带走的话, 就会围绕这里扩展。
- 知识点：始终要考虑这一部分的轴心, 如果方向性与您想的不符, 那只需重新修改后,再进行重头设即可。
- 知识点：您可以带走测验证效果,这样就能明白为什么要考虑轴心。
- 知识点：关于合并节点,我之前没有解释, 但可以理解为只是将多个网格简单地合并在一起的功能。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

当前画面展示的是前一段已经完成的十字网格基础形态，节点链仍保持为一份原始带 UV 的平面、一个旋转副本、一个合并节点和一个整体变换节点。左侧透视视口能看到两张互相垂直的贴图平面沿中心线相交，构成固定轴十字网格。

节点连接：
- `grid1 -> uvtexture1`
- `uvtexture1 -> transform1 -> merge1`
- `uvtexture1 -> merge1`
- `merge1 -> transform2`

当前图中直接可见的基础设置：
- `grid1` 被选中
- `grid1`：`Orientation = XY Plane`
- `grid1`：`Size = (10, 10)`
- `grid1`：`Rows = 4`
- `grid1`：`Columns = 4`
- `End-point interpolate in U` = 开启
- `End-point interpolate in V` = 开启

这一步的作用是把“十字网格已经建立完成”的基线状态固定下来，然后开始讲轴心思路。结合正文“请始终考虑您想要表达的轴心，进行设置并带走”可知，后续调整的重点不是重新生成网格，而是围绕同一套网格去验证不同枢轴/轴向设定对扩展方向和视觉结果的影响。
这一帧切到 `transform2` 节点上检查最终成品。左侧透视视口从更正面的角度观察十字网格，可以清楚看到两组互相垂直的平面都围绕中心交点向四个方向展开，说明当前整体扩展是以中心为基准完成的。

节点连接仍为：
- `grid1 -> uvtexture1`
- `uvtexture1 -> transform1 -> merge1`
- `uvtexture1 -> merge1`
- `merge1 -> transform2`

`Transform transform2` 当前图中可确认的设置：
- `Group Type = Guess from Group`
- `Transform Order = Scale Rot Trans`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Uniform Scale = 4.12`
- `Recompute Point Normals` = 开启
- `Recompute Affected Normals` = 开启
- `Preserve Normal Length` = 开启

结合正文“如果将其指点对准中心……就会围绕这里扩展”“动一动就能很快明白”可知，这一步是在通过实际观察验证中心轴心方案的结果：当整体枢轴理解为中心位置时，十字网格会以交点为基准向四周均匀放大。当前图没有展开 `Pivot Transform` 细项，因此无法仅凭画面确认作者是否在此前改过具体枢轴坐标；能确认的是，此时他认可并保留了这个以中心为扩展基准的结果。
画面已经从 Houdini 切回 Unreal Editor，开始查看教程工程中的材质资源目录。左侧 `Content Browser` 当前定位在：

`Content/Signature/Course_02/Material`

当前能直接识别的资源与目录结构：
- 左侧目录树包含 `Course_02` 下的 `Level`、`Material`、`Mesh`、`Particle`、`Texture`
- 当前打开的是 `Material` 文件夹
- 可见多个材质资产，命名以 `M_Additive_*`、`M_Ribbon_*`、`PP_*` 为主
- 有一个名为 `UVTest` 的材质资源被选中

右侧主视口是 UE 默认场景，说明此时作者还没有进入具体材质编辑器，而是在素材目录中先确认后续要用的材质或测试材质所在位置。结合字幕“我会去原料那里看一下，我已经提前创建了一个名为……的文件夹”可知，这一步的用途是为后续网格/纹理效果落地到 UE 材质侧做资源准备与目录定位。

### 00:24:49-00:27:44 UV、材质、贴图

- 本段定位：UV、材质、贴图。
- 知识点：当你这样拖动的时候, 有这些选项,实际上可以不去碰他们, 直接导入。
- 知识点：这里的选项,无论如何, 在导入之后, 可以忽略日制窗口。
- 知识点：因为在这里导入后, 你也可以稍后调整选项。
- 知识点：但是现在这个消息看不见的原因是, 因为是看到背面, 所以在这个贴图消息窗口中, 背面现在的材质就没有设置为双面。
- 知识点：只有标有复选框的前面会被绘制出来。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`贴图`。

**关键画面：**

当前画面回到 Houdini 的对象层级 `obj`，作者在多个几何对象中选中了 `Plane`，左侧透视视口显示的是未贴纹理的灰色十字网格。这个视图用于先检查网格本身的展开与正反面可见性，而不是直接查看材质节点。

对象层可见结构：
- `geo1`
- `Plane`（当前选中）
- `Sphere`
- `Cylinder`
- `Disc`

`Plane` 物体当前右侧 `Transform` 面板中可确认的设置：
- `Transform Order = Scale Rot Trans`
- 旋转顺序显示为 `Rx Ry Rz`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Pivot Translate = (0, 0, 0)`
- `Pivot Rotate = (0, 0, 0)`
- `Uniform Scale = 1`

左侧十字网格只显示当前朝向摄像机的面，背向的一侧没有被绘制出来。结合正文“现在这个消息看不见的原因是，因为是看到背面”“背面现在的材质没有设置为双面”可知，这一步是在用 Houdini 视口先验证一个现象：如果后续材质仍保持单面渲染，那么从背面观察十字网格时会出现不可见或缺面的效果。
这一帧已经切到 Unreal Engine 的静态网格编辑器，当前打开的资源标签是 `Exp_Test_11`。左侧预览窗口中显示导入后的十字网格，右侧 `Details` 面板正在查看该网格的材质槽与导入信息，用测试材质先检查导入是否正常。

当前图中可确认的静态网格信息：
- 资源名：`Exp_Test_11`
- 预览模式：`Perspective` + `Lit`
- `Material Slots = 1`
- `Element 0` 当前材质为 `WorldGridMaterial`
- `Triangles = 36`
- `Vertices = 32`
- `UV Channels = 2`
- `Approx Size = 1000 x 1000 x 1000`
- `Num Collision Primitives = 1`

从画面可见，十字网格已经成功导入 UE，并且先套用了 `WorldGridMaterial` 作为测试材质来检查 UV 和面朝向是否正常。结合正文“拖动时这些选项可以不去碰，直接导入”“导入之后也可以稍后调整选项”可知，这一步强调的是：导入弹窗的细节不用过度纠结，先把网格导进来，再在静态网格编辑器里用测试材质验证几何、UV 和显示结果。
这一帧回到 Houdini 的节点级视图，继续在已经完成的十字网格基础上做整体尺寸验证。左侧透视视口仍是带棋盘测试纹理的十字网格，右侧选中的是最终整体变换节点 `transform2`。

节点连接：
- `grid1 -> uvtexture1`
- `uvtexture1 -> transform1 -> merge1`
- `uvtexture1 -> merge1`
- `merge1 -> transform2`

`Transform transform2` 当前可确认的设置：
- `Group Type = Guess from Group`
- `Transform Order = Scale Rot Trans`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Uniform Scale = 100`
- `Recompute Point Normals` = 开启
- `Recompute Affected Normals` = 开启
- `Preserve Normal Length` = 开启

这一步的作用是把最终十字网格整体放大到更接近导出/引擎测试所需的尺寸，再观察贴图和面显示是否还能正常工作。结合正文“通过其他程序处理一下后是可以使用的”可知，作者的判断是：当前网格即使在材质背面显示和尺寸换算上有些麻烦，但经过外部程序或后续引擎侧处理后仍然可用。本图没有直接展示双面材质勾选界面，因此这里只能确认作者在用放大后的最终网格继续做可用性验证。

### 00:27:49-00:30:00 Blender、网格

- 本段定位：Blender、网格。
- 知识点：这个导出需要使用OBGA扩展鸣, 而不是FBVX。
- 知识点：先用OBGA导出一次, 然后再覆盖这个, 然后可以通过其他程序导入。
- 知识点：我推荐使用这个Blender这个程序。
- 知识点：启动Blender后, 会出现这种界面。
- 知识点：把默认的立方体删除, 然后直接在这里导入OBGA文件, 然后选择我们保存的文件夹。
- 核对对象：`Blender`。

**关键画面：**

当前仍在 Houdini 中处理最终十字网格的导出。左侧视口显示的是带棋盘测试纹理的十字网格，节点链停在最终输出节点 `transform2`；前景弹出了一个文件覆盖确认窗口，说明作者正在把导出结果写到已经存在的同名文件上。

当前可确认的节点关系与导出前状态：
- `grid1 -> uvtexture1`
- `uvtexture1 -> transform1 -> merge1`
- `uvtexture1 -> merge1`
- `merge1 -> transform2`
- `transform2` 当前 `Uniform Scale = 100`

弹窗内容可确认：
- 目标文件：`F:/Houdini/Coloso_Resource/Part_02/tutorial/Exp_Test_01.obj`
- 状态：该文件已存在，Houdini 询问是否覆盖
- 可选操作：`OK` / `Cancel`

这一步的关键不是继续改网格，而是确认导出流程：先把当前网格导出为 `OBJ`，如果目标文件已经存在就直接覆盖。结合正文“先用 obj 导出一次，然后再覆盖这个，然后可以通过其他程序导入，再重新导出为 fbx”可知，作者在强调一个中转流程：先从 Houdini 导出中间网格文件，再交给其他程序处理，而不是直接在这里结束为最终引擎格式。
这一帧已经进入 Blender 4.2.1 LTS，并且十字网格对象已经成功导入。当前选中对象名为 `Exp_Test_01`，视口中可以看到两张互相垂直的平面在原点交叉，说明从 Houdini 导出的中间网格已经被 Blender 正确读入。

当前图中可确认的 Blender 场景状态：
- 顶部工作区停留在 `Layout`
- 视口模式：`Object Mode`
- 视图：`User Perspective`
- `Scene Collection` 中可见 `Camera`、`Exp_Test_01`、`Light`
- 当前选中对象：`Exp_Test_01`

右侧 `Transform` 面板中可确认的对象变换：
- `Location = (0 m, 0 m, 0 m)`
- `Rotation X = 90°`
- `Rotation Y = 0°`
- `Rotation Z = 0°`
- `Mode = XYZ Euler`
- `Scale X = 0.1`
- `Scale Y = 1.000`
- `Scale Z = 1.000`

结合字幕“如果太大，可以在这里调整比例”和正文“启动 Blender 后会出现这种界面……导入 obj 文件”可知，这一步的重点是：导入后先在 Blender 中校正方向与尺寸。当前图明确展示了作者用 `Rotation X = 90°` 和 `Scale X = 0.1` 对导入网格做初步姿态/比例修正，以便后续再从 Blender 转出为引擎更容易接受的格式。
当前画面已经回到 Unreal Engine 的静态网格编辑器，活动标签是 `Exp_Test_12*`。左侧视口处于 `Perspective` + `Wireframe` 模式，但画面整体较暗，网格轮廓无法被可靠完整辨认，因此本图仅记录可以直接确认的界面信息。

当前图中可确认的信息：
- 活动资源标签：`Exp_Test_12*`
- 顶部另有打开标签：`Exp_Test_11`、`UVTest`
- 视口模式：`Perspective`
- 着色/显示模式：`Wireframe`
- 右侧 `Material Slots = 1`
- `Element 0` 当前仍显示为 `WorldGridMaterial`
- 左上统计信息可见：
  - `Triangles = 36`
  - `Vertices = 32`
  - `UV Channels = 2`
  - `Approx Size = 10,000 x 10,000 x 10,000`
  - `Num Collision Primitives = 1`

可确认的语义是：作者已经把经过 Blender 处理后的网格重新带回 UE 继续检查，并且这次资源尺寸比前一张 `Exp_Test_11` 更大。由于本图视口中的模型细节过暗，无法仅凭画面可靠确认十字网格在该资源中的具体可见形态、材质背面效果或是否已经完成最终导入设置，这些部分需要。
## 补充视觉证据

### S02 00:07:03

这是一张对 `S02 00:07:03` 的参数补充截图。当前在 Houdini 的 `geo1` 内部，节点链为 `sphere1 -> transform1 -> edit1`，并且 `edit1` 被选中。左侧透视视口显示一个球体，处于点编辑/软选择状态，球面上可见蓝色与黄色点，用来说明这一阶段是按点组挑选后直接做局部变形。

节点关系：
- `sphere1 -> transform1 -> edit1`

`Edit edit1` 当前可确认的设置：
- `Group = 0 2-36 48-58`
- `Group Type = Points`

`edit1` 内 `Transform` 区域当前可确认的参数：
- `Transform Order = Scale Rot`
- 旋转顺序显示为 `Rx Ry Rz`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`

`Transform Space Settings` 当前可确认的参数：
- `Transform Space = Global`
- `Local Frame = Component`
- `Slide on Surface` = 未开启

`Soft Settings` 当前可确认的参数：
- `Distance Metric = Surface`
- `Soft Radius = 0`
- `Soft Type = Cubic`
- `Tangent Angles = (0, 0)`
- `Kernel Function = Wyvill model`
- `Visualize Falloff = When Viewport Tool Is Active`
- `Use Orient Attribute` = 未开启
- `Use Mirror` = 未开启

这张补充图的作用是把早前球体局部编辑阶段的关键参数补齐。可直接确认的建模语义是：作者先在 `edit1` 里按点组 `0 2-36 48-58` 选出球面上一圈点，再通过 `Edit` 节点的局部变换能力进行移动或缩放；当前截图本身还没有显示新的平移/旋转/缩放数值已经被写入，因此这里只能确认“选点组并准备/执行局部编辑”的参数基础，不能从图上直接读出最终形变量。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


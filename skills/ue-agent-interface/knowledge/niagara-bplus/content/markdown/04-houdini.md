# 04.Houdini中对模拟的理解

# 04.Houdini中对模拟的理解

## 关键术语

- `Houdini`、`Noise`、`粒子`、`系统`、`网格`、`碰撞`、`生命周期`、`速度`、`噪声`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Particle Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:06-00:04:45 Niagara、粒子、系统

- 本段定位：Niagara、粒子、系统。
- 知识点：围绕当前效果继续调整 Niagara 系统，需结合关键画面确认实际节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Niagara`、`Drag`、`粒子`、`系统`、`速度`。

**关键画面：**

这一张是 `Houdini Indie 20.5.613` 的起始工作界面，作用是把本页讲解正式切回 Houdini，并从一个空的 `/obj` 场景开始说明后续模拟思路。当前画面还没有具体节点，重点是确认工作上下文、视图区和对象网络都处于初始状态。

- 软件窗口标题可读为：
  - `untitled.hip - Houdini Indie Limited-Commercial 20.5.613 - Py3.11`
- 左侧是 3D `View` 视口：
  - 当前为空场景
  - 只显示默认地面网格和天空背景
  - 视角标识为 `Persp`
- 中间是对象级网络编辑区：
  - 当前路径位于 `/obj`
  - 画面提示 `Objects`
  - 中央可见 `Empty Network` 与 `Press Tab to Add Nodes`
  - 说明此时还没有创建任何对象节点
- 右侧参数面板当前显示：
  - `No Operator Selected`
  - 表明还没有选中任何节点或对象
- 底部是时间轴与播放控制区：
  - 当前时间停在起始帧
  - 时间范围显示到 `240`
- 这一步的作用：
  - 从空的 Houdini 对象层开始进入新一页内容
  - 为后面逐步创建粒子系统、网格或模拟节点提供明确起点
这一张已经进入 `geo1` 几何对象内部，并开始搭建基础粒子模拟结构。当前网络里只有一个地面网格 `grid1` 和一个 `DOP Network` 类型的 `popnet`，说明作者先用最简结构建立粒子系统骨架，再从 `popnet` 的模拟参数入手讲解。

- 顶部路径栏可见当前层级位于：
  - `/obj/geo1`
- 中央网络编辑区当前只显示两个节点：
  - `grid1`
  - `popnet`（节点标签显示 `DOP Network`）
- 左侧 3D 视口中能看到一个平面网格：
  - 对应 `grid1`
  - 作为场景中的基础参考面或后续碰撞/发射基面
- 右侧参数面板当前选中的是 `popnet`，并打开：
  - `Simulation` 选项卡
- 当前可读的 `popnet` 模拟参数包括：
  - `Timestep = 0.0416667`
  - `Substeps = 1`
  - `Offset Time = 0`
  - `Start Frame = 1`
  - `Scale Time = 1`
  - `Max Feedback Loops = 2`
- 面板下方当前启用的选项包括：
  - `Enable Automatic Resimulation`
  - `Provide Data Hints`
  - `Interpolate Display Data`
- 这一步的作用：
  - 说明 Houdini 这边的粒子系统也是先建一个承载模拟的网络容器
  - 与前面 Unreal 侧 Niagara 的思路相呼应，先把系统骨架和模拟步进参数定下来，再继续往内部补发射、速度和碰撞逻辑
这一张正式进入 `popnet` 内部，展示了最基础的 POP 粒子解算网络。左侧视口里能看到网格面上已经生成了稀疏粒子点，中央网络图则说明这些点来自一个 `POP Source`，经过 `POP Solver` 解算后输出。

- 当前路径位于：
  - `/obj/geo1/popnet`

- 节点定义集：
  - `source_first_input`
    - 类型：`POP Source`
    - 位置：网络上方
    - 作用：从第一输入对象发射粒子
  - `wire_pops_into_here`
    - 类型：`Merge`
    - 位置：`source_first_input` 下方
    - 作用：作为 POP 力量或发射器汇入 `popsolver` 的汇合点
  - `popobject`
    - 类型：POP 对象容器
    - 位置：网络左侧
    - 作用：承载粒子模拟对象数据
  - `popsolver`
    - 类型：`POP Solver`
    - 位置：网络中央偏下
    - 作用：执行粒子时间步进与行为更新
  - `output`
    - 类型：输出节点
    - 位置：网络底部
    - 作用：导出当前 DOP 网络结果

- 连线集：
  - `source_first_input` 向下连接到 `wire_pops_into_here`
  - `wire_pops_into_here` 连接到 `popsolver` 的输入
  - `popobject` 连接到 `popsolver`
  - `popsolver` 向下连接到 `output`

- 设置/参数：
  - 右侧参数面板当前选中的是 `popsolver`
  - 当前打开的是 `Substeps` 选项卡
  - 可见参数包括：
    - `Time Scale = 1`
    - `Min Substeps = 1`
    - `Max Substeps = 1`
    - `CFL Condition = 1`
    - `Quantize to Max Substeps` 当前未勾选

- 输出/预览：
  - 左侧视口中，平面网格上已经分布了一批黑色小点
  - 这些点就是当前 POP 系统生成出来的粒子预览
  - 画面说明系统已经从“只有容器”进入到了“有实际粒子结果”的阶段

### 00:04:45-00:09:34 粒子、系统、网格

- 本段定位：粒子、系统、网格。
- 知识点：围绕当前效果继续调整 Niagara 系统，需结合关键画面确认实际节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`系统`、`速度`、`碰撞`。

**关键画面：**

这一张继续停留在同一个 `popnet` 网络里，但当前选中的是 `popobject`。重点从“粒子怎么解算”转成“粒子对象本身如何定义和初始化”，也就是告诉读者 POP 模拟里还有一个独立的粒子对象容器负责承接这些点数据。

- 当前网络仍位于：
  - `/obj/geo1/popnet`

- 当前可见节点关系没有变化：
  - `source_first_input`
  - `wire_pops_into_here`
  - `popobject`
  - `popsolver`
  - `output`

- 当前选中的节点是：
  - `popobject`

- 右侧参数面板当前显示的是 `POP Object` 参数，可见字段包括：
  - `Creation Frame = 1`
  - `Object Name = $OS`
  - `Solve on Creation Frame` 复选项
  - `Initial Geometry` 输入槽
  - `Use Object Transform` 复选项

- 当前打开的参数分组还显示了：
  - `Guides`
  - `Collisions`
  - `Physical`

- 在 `Guides` 分组里当前可见：
  - `Instance Guides` 已启用
  - 后面带有颜色槽与数值输入框

- 输出/预览：
  - 左侧视口中，平面网格上依旧能看到已经生成的粒子点分布
  - 说明此时粒子对象已经正常承接并显示模拟结果

- 这一步的作用：
  - 让读者知道 POP 网络不仅有发射器和求解器，还存在一个专门的粒子对象节点
  - 后面如果需要改粒子的创建时机、初始几何来源或对象级碰撞/物理选项，就会从 `popobject` 这类参数入口入手
这一张退回到了 `geo1` 几何层，强调当前这个效果其实只依赖一个非常简单的对象结构：一个平面 `grid1` 加一个 `popnet`。左侧视口中能看到粒子点正分布在平面范围内，说明这个网格既是几何参考，也是当前发射区域的来源。

- 当前层级位于：
  - `/obj/geo1`

- 当前网络里只显示两个对象级节点：
  - `grid1`
  - `popnet`（`DOP Network`）

- 连接关系：
  - `grid1` 的输出连到 `popnet`
  - 说明 `popnet` 正在使用前面的网格作为第一输入来源

- 右侧参数面板当前选中的是 `grid1`，可见设置包括：
  - `Primitive Type = Polygon`
  - `Connectivity = Quadrilaterals`
  - `Orientation = ZX Plane`
  - `Size = 10 / 10`
  - `Center = 0 / 0 / 0`
  - `Rotate = 0 / 0 / 0`
  - `Rows = 10`
  - `Columns = 10`
  - `End-point interpolate in U` 已勾选
  - `End-point interpolate in V` 已勾选

- 输出/预览：
  - 左侧视口里，黑色粒子点均匀散布在一个接近正方形的平面区域内
  - 这和 `10 x 10`、`10 x 10` 分段的网格参数相对应

- 这一步的作用：
  - 说明这里的粒子发射基础并不复杂，只要一个简单网格就能给 `popnet` 提供稳定的发射区域
  - 对应字幕里的意思：很多子系统效果只需要先把粒子简单生成出来，就能搭出常见的基础结构
这一张再次回到 `popnet` 内部，但这次选中的是 `source_first_input`。它把“粒子为什么会铺满整块平面”这件事说清楚了：当前 `POP Source` 正在从第一上下文几何体表面散布发射粒子，而且发射类型明确设成了在表面散点。

- 当前路径仍位于：
  - `/obj/geo1/popnet`

- 当前网络结构仍包括：
  - `source_first_input`
  - `wire_pops_into_here`
  - `popobject`
  - `popsolver`
  - `output`

- 当前选中的节点是：
  - `source_first_input`
  - 节点类型显示为 `POP Source`

- 右侧参数面板当前打开 `Source` 选项卡，可见关键设置包括：
  - `Emission Type = Scatter onto Surfaces`
  - `Geometry Source = Use First Context Geometry`
  - `SOP` 路径输入框当前为空
  - `Use Object Transform` 选项可见
  - `Group Type = Guess from Group`
  - `Emission Attribute` 输入框可见
  - `Scale Point Count by Area` 复选项可见
  - `Remove Overlapping = None`

- 输出/预览：
  - 左侧视口中，整个平面网格表面都被密集黑点覆盖
  - 这与 `Scatter onto Surfaces` 的发射方式直接对应，说明粒子不是只从单个点或边缘发出，而是按表面分布散射生成

- 这一步的作用：
  - 把发射来源明确到“第一输入几何表面”
  - 也说明想得到类似均匀铺面的粒子初始分布时，最直接的方法就是让 `POP Source` 对表面做散点发射

### 00:09:34-00:14:32 Niagara、Houdini、粒子

- 本段定位：Niagara、Houdini、粒子。
- 知识点：围绕当前效果继续调整 Niagara 系统，需结合关键画面确认实际节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Niagara`、`Houdini`、`粒子`、`系统`。

**关键画面：**

这一张延续前一段的 `POP Source` 设置，但当前画面的重点更偏向结果观察：只靠一个简单平面和表面散点发射，就能得到非常自然、不死板的粒子初始分布。这也是作者把 Houdini 与 Niagara 并列讨论时想强调的优势之一。

- 当前层级仍位于：
  - `/obj/geo1/popnet`

- 当前选中的节点是：
  - `source_first_input`
  - 节点类型为 `POP Source`

- 网络中当前可见的节点关系仍为：
  - `source_first_input -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 右侧参数面板当前仍打开 `Source` 选项卡，可见关键设置包括：
  - `Emission Type = Scatter onto Surfaces`
  - `Geometry Source = Use First Context Geometry`
  - `Group Type = Guess from Group`
  - `Scale Point Count by Area` 选项可见
  - `Remove Overlapping = None`

- 输出/预览：
  - 左侧视口中，黑色粒子点并非规则排布，而是自然散布在网格表面
  - 蓝色网格线仍清楚可见，说明当前看到的是“基面 + 散点”的起始状态
  - 这种分布方式更接近真实环境中随机出现的粒子出生位置

- 这一步的作用：
  - 说明 Houdini 在“先做自然的粒子出生分布”这件事上非常直接
  - 只要通过表面散点发射，就能快速建立一个后续可继续加速度、生命周期和力场的基础粒子系统
这一张仍然选中 `source_first_input`，但发射模式已经从前面的“只在表面散点”切换成“整几何体都参与发射”。这也是当前左侧预览看起来像一整块被密集粒子填满的主要原因。

- 当前层级仍位于：
  - `/obj/geo1/popnet`

- 当前选中的节点是：
  - `source_first_input`
  - 节点类型：`POP Source`

- 右侧参数面板当前打开 `Source` 选项卡，可见关键设置包括：
  - `Emission Type = All Geometry`
  - `Geometry Source = Use First Context Geometry`
  - `Group Type = Guess from Group`
  - `Remove Overlapping = None`

- 与上一张图相比，当前最重要的变化是：
  - 发射不再局限于表面散点
  - 而是改成把整个输入几何都当成可发射区域

- 输出/预览：
  - 左侧视口是侧视角，能看到一整块厚实、层层堆叠的粒子分布
  - 顶部边缘有更深的蓝色轮廓，说明当前预览仍以输入几何边界为参考
  - 这类结果明显比“只在表面散布点”更密、更像一整团被填充过的粒子区域

- 这一步的作用：
  - 展示 `POP Source` 发射模式改变后，粒子出生形态会发生非常直接的结构变化
  - 当需要更厚、更满的初始粒子体时，使用 `All Geometry` 会比单纯表面散点更合适
这一张仍然选中 `source_first_input`，但当前重点已经从发射区域切到“出生规则”。右侧打开的是 `Birth` 选项卡，能明确看到粒子的激活方式、每帧上限、持续出生速率和生命周期参数。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前选中的节点是：
  - `source_first_input`
  - 类型：`POP Source`

- 当前打开的选项卡：
  - `Birth`

- `Birth` 里当前可见的关键参数包括：
  - `Impulse Activation = 1`
  - `Impulse Count = 10`
  - `Const. Activation = 0`
  - `Const. Birth Rate = 5000`
  - `Max Sim Points` 字段可见但当前画面中数值不清晰
  - `Max Points per Frame = 100000`
  - `Probabilistic Emission` 当前未勾选
  - `Just Born Group` 输入框可见
  - `Seed = 0`
  - `Life Expectancy = 100`
  - `Life Variance = 0`
  - `Jitter Birth Time = Positive`
  - `Interpolate Source = None`

- 输出/预览：
  - 左侧视口又回到了较稀疏的表面点分布状态
  - 说明当前这张图主要不是在展示“填满整块区域”的结果，而是在说明粒子何时出生、每秒/每帧能出生多少、以及能活多久

- 这一步的作用：
  - 把 Niagara 里常见的 `Spawn Rate / Lifetime` 逻辑对应到 Houdini 的 `Birth` 参数上
  - 后续想控制整体屏幕密度时，核心就是围绕 `Const. Birth Rate`、`Max Points per Frame` 和 `Life Expectancy` 这类值做调节

### 00:14:32-00:19:18 粒子、生命周期、速度

- 本段定位：粒子、生命周期、速度。
- 知识点：现在一秒是24帧,改成30帧后,30帧即对应一秒 产生的粒子大概有五千零四个,约五千零四个。
- 知识点：不是精确值,只是大致接近这个数量此外,Max Point即最大粒子数 限制最大粒子生成数量,生成粒子后必然存在一个消亡时间,也就是生命周期 这是我们常调节的部分。
- 知识点：标有生命周期的参数,可理解为生命周期 设为2s,生命周期的波动值设为随机,因此部分粒子可能只有1.5秒,最长可达2.5秒 因此,0.5的波动值决定了最小最大值。
- 知识点：以2s为基准,生命周期可在非0.5秒范围内随机浮动 可理解为生命周期在非0.5秒范围内随机浮动,按此规律生成 了解这些就够了,至少在流体标签页里,知道这些就差不多了,种子值可以随意调整 这部分可以随意调整。
- 知识点：另一个关键点是属性设置,默认使用内部速度,还有 有速度缩放这个参数,当从圆中获取速度值时,它决定了速度的影响强度 这个选项就是用来控制速度值,影响强弱的。
- 知识点：在粒子中,速度是个极其关键的参数 所以先简单生成一个法线,再把法线值直接连到速度上试试。
- 知识点：这样点法线就生成了 方向朝上,直接把法线连到速度上,就是说方向一 这样就可观察到粒子向上发射了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`生命周期`、`速度`、`流体`。

**关键画面：**

这一张进入“粒子、生命周期、速度”小节后，先把时间基准讲清楚。画面左下角弹出了 `Global Animation Options`，可以明确看到当前场景帧率被设置成 `30 FPS`；右侧仍保留 `POP Source` 的 `Birth` 参数，用来对应“每秒产生多少粒子”这件事。

- 左下角弹出的全局时间设置窗口标题为：
  - `Global Animation Options`

- 其中当前能明确读到的关键时间设置包括：
  - `FPS = 30`
  - `Start = 1`
  - `End = 240`
  - `Restrict playback range` 已勾选
  - `Integer Frame Values` 已勾选
  - `Realtime Playback` 已勾选

- 这与本段口播中的关键判断直接对应：
  - 原本按 24 帧理解的“一秒”，在这里被改成了 30 帧
  - 因而后面所有按“每秒”理解的出生数量，都要按 30 FPS 重新换算

- 右侧当前仍选中 `source_first_input` 的 `Birth` 选项卡，可见的关键出生参数包括：
  - `Impulse Activation = 0`
  - `Impulse Count = 10`
  - `Const. Birth Rate = 5000`
  - `Max Points per Frame = 100000`
  - `Life Expectancy = 100`
  - `Life Variance = 0`
  - `Jitter Birth Time = Positive`
  - `Interpolate Source = None`

- 输出/预览：
  - 左侧视口中，粒子仍散布在平面网格上
  - 当前画面主要不是看形状变化，而是在建立“帧率会直接影响粒子生成统计”的理解基准

- 这一步的作用：
  - 先把模拟时间单位从 24 FPS 切到 30 FPS
  - 后续无论是估算一秒内累计生成多少粒子，还是判断生命周期跨越多少帧，都必须以这个 30 FPS 为准
这一张从 `popnet` 内部退回到了 `geo1` 的几何层，并新增了一个 `Attribute VOP` 节点 `pointvop1`。结合本段“生命周期、速度”讲解，这一步的意义是开始在 SOP/点属性层面准备进一步控制粒子属性，而不再只停留在 POP Source 的出生设置。

- 当前层级位于：
  - `/obj/geo1`

- 当前网络中可见的节点包括：
  - `grid1`
  - `popnet`（`DOP Network`）
  - `pointvop1`（`Attribute VOP`）

- 画面中能明确看到：
  - `grid1` 仍然向下连接到 `popnet`
  - `pointvop1` 被单独放在 `popnet` 右侧
  - 当前截图里没有显示 `pointvop1` 与其它节点的连线

- 右侧参数面板当前选中的是：
  - `Attribute VOP pointvop1`

- 当前可见的 `pointvop1` 外层参数包括：
  - `Group`
  - `Group Type = Guess from Group`
  - `Run Over = Points`
  - `Vex Source = Myself`
  - `Compiler` 命令行字段可见
  - `Evaluation Node Path`
  - `Export Parameters`
  - `Enable Multithreading` 已勾选

- 输出/预览：
  - 左侧视口里仍能看到平面上的稀疏粒子点
  - 说明此时基础粒子分布仍保留，但作者已经开始准备对点属性做进一步处理

- 这一步的作用：
  - 引入一个按 `Points` 运行的属性处理节点
  - 为后面把法线、速度或其它粒子属性直接写入点级数据做准备
这一张又回到了 `source_first_input`，但这次右侧切到 `Attributes` 选项卡，开始直接设置粒子出生时继承和附加的速度属性。结合字幕，这一页对应的就是“速度可以先继承，再叠加一个单独设置的初始速度值”。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前选中的节点是：
  - `source_first_input`
  - 类型：`POP Source`

- 当前打开的选项卡：
  - `Attributes`

- 当前可见的关键属性设置包括：
  - `Initial State = Free Flying`
  - `Inherit Attributes` 区域可见
  - `Initial Velocity = Add to inherited velocity`
  - `Inherit Velocity = 1`
  - `Velocity = (1, 0, 0)`
  - `Variance = (1, 0, 0)`
  - `Add ID Attributes` 已勾选

- 这组参数表达的含义是：
  - 粒子默认处于自由飞行状态
  - 会先继承来源几何或已有数据中的速度
  - 然后再额外叠加一个沿 X 方向的初始速度
  - 同时在 X 方向再加入一个速度波动范围

- 输出/预览：
  - 左侧视口中，粒子仍然贴近平面分布，但已经不是完全静止的“出生点集合”语境
  - 这一页更重要的是确认出生速度是如何被定义的，而不是看最终飞散结果

- 这一步的作用：
  - 把“速度”从抽象概念落实到 `POP Source` 的属性写入方式
  - 也为后面用法线方向、额外偏移或噪声继续驱动粒子运动打下基础

### 00:19:18-00:23:35 Noise、粒子、碰撞

- 本段定位：Noise、粒子、碰撞。
- 知识点：该指用于,这部分的作用和之前说的variance一样,XYZ轴可以分别单独设置。
- 知识点：可以理解为每个轴都能单独设置,特别简单哦 是的,我们对Niagara里的粒子操作很熟,这部分应该很容易上手,这部分你们应该能很快掌握 接下来我们还会经常用到一些类似气泡的效果,大概就这些了。
- 知识点：简单来说,Call Noise就是用来混入噪声运动的 进到Niagara里之后,所以可以把Inflow值这样加到缩放里用。
- 知识点：Swirl Size可以理解为噪声值的重复铺满程度 数值越大,形状就越简单。
- 知识点：更简单的噪声值能呈现出这种规律性图案 我们试着调高流入值,就会发现噪声的强度明显增强。
- 知识点：强度会明显增强同时,还能在此基础上添加脉冲值,验证效果这个幅度 还能叠加一个延推力方向向上的速度效果。
- 知识点：只要了解弹孔节点的基本用法,就能轻松实现这类真实的粒子动态 这类带噪声感的运动在实际项目中很常见。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Niagara`、`Noise`、`粒子`、`速度`、`噪声`、`碰撞`。

**关键画面：**

这一张继续停留在 `source_first_input` 的 `Attributes` 选项卡，但和前一批不同的是，当前 `Initial Velocity` 模式已经切成“直接设置初始速度”，而不是“叠加到继承速度上”。字幕强调的重点也是：XYZ 三个轴都可以各自单独控制，非常直观。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前选中的节点：
  - `source_first_input`
  - 类型：`POP Source`

- 当前打开的选项卡：
  - `Attributes`

- 当前可见的关键属性设置包括：
  - `Initial State = Free Flying`
  - `Initial Velocity = Set initial velocity`
  - `Inherit Velocity` 字段可见但当前未作为主要模式使用
  - `Velocity = (1, 0, 0)`
  - `Variance = (1, 0, 0)`
  - `Add ID Attributes` 已勾选

- 这组设置表达的直接含义是：
  - 粒子出生时直接赋予一个初始速度
  - 当前初始速度主要沿 X 方向
  - 速度波动范围也主要加在 X 方向
  - Y、Z 轴目前保持为 0，因此没有额外侧向或向上的偏移

- 输出/预览：
  - 左侧视口中，粒子仍贴近平面分布
  - 当前画面重心不在最终飞行轨迹，而是在说明初始速度和方差可以按轴拆分设置

- 这一步的作用：
  - 把“速度控制”进一步细化到单轴可调
  - 为后面继续调整方向、随机性和生命周期配合打基础
这一张开始把“出生”过渡到“运动过程”。`popnet` 内部不再只有 `POP Source`，而是新增了 `popforce1` 和 `popdrag1` 两个过程节点，让粒子从平面上被推起并在空气阻力影响下形成更像喷发/扬起的动态。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 节点定义集：
  - `source_first_input`
    - 类型：`POP Source`
  - `popforce1`
    - 类型：`POP Force`
    - 位置：`source_first_input` 下方
    - 作用：给粒子施加持续外力
  - `popdrag1`
    - 类型：`POP Drag`
    - 位置：`popforce1` 下方
    - 作用：给粒子加入空气阻力/阻尼
  - `wire_pops_into_here`
    - 类型：`Merge`
  - `popobject`
    - 类型：POP 对象
  - `popsolver`
    - 类型：`POP Solver`
  - `output`
    - 类型：输出节点

- 连线集：
  - `source_first_input -> popforce1 -> popdrag1 -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 当前右侧参数面板选中的是：
  - `POP Drag popdrag1`

- 当前可见的 `POP Drag` 参数包括：
  - `Activation = 1`
  - `Wind Velocity = (0, 0, 0)`
  - `Air Resistance = 1`
  - `Ignore Mass` 已勾选
  - `Use VEXpressions` 选项可见但未勾选

- 输出/预览：
  - 左侧视口里，大量粒子已从平面上方被抬起
  - 形态上像一团被向上吹散的黑色粒子云
  - 底部仍能看到起始平面区域，说明这些粒子正从该区域持续出生并被力场带走

- 这一步的作用：
  - 通过 `POP Force` 提供推动粒子运动的主要外力
  - 再通过 `POP Drag` 限制粒子过快飞散，使运动更像真实空气中的受阻喷发
这一张退回到 `geo1` 的 SOP 层，数据流已经从单纯的 `grid1 -> popnet` 扩展成 `grid1 -> normal1 -> pointvop1 -> popnet`。这和本段口播里“先生成法线，再把法线连到速度上”是直接对应的，说明作者开始在进入 DOP/POP 之前，先在几何层生成可用的方向信息。

- 当前层级位于：
  - `/obj/geo1`

- 当前网络中的节点顺序可直接确认：
  - `grid1`
  - `normal1`
  - `pointvop1`
  - `popnet`

- 连线集：
  - `grid1 -> normal1`
  - `normal1 -> pointvop1`
  - `pointvop1 -> popnet`

- 右侧参数面板当前选中的是：
  - `grid1`

- 当前可见的 `grid1` 基础参数仍包括：
  - `Primitive Type = Polygon`
  - `Connectivity = Quadrilaterals`
  - `Orientation = ZX Plane`
  - `Size = 10 / 10`
  - `Rows = 10`
  - `Columns = 10`

- 输出/预览：
  - 左侧视口里，粒子已经从地面上方形成一片被吹起的层状团块
  - 说明这时不再只是“静态出生点”，而是经过法线/属性处理后进入了可运动的系统状态

- 这一步的作用：
  - 明确把 `normal1` 作为生成方向向量的前置步骤插入数据流
  - 为 `pointvop1` 后续读取法线并转写成速度，提供稳定的输入属性来源

### 00:23:35-00:26:37 粒子、系统、生命周期

- 本段定位：粒子、系统、生命周期。
- 知识点：同样支持粒子对象的创建。
- 知识点：此外,降低摩擦值,滑动效果显着加剧,由此可见,这类物理参数的表现方式与其他模拟几乎一致。
- 知识点：粒子系统的物理行为几乎与其他模拟中的设置完全一致,控制起来毫无障碍。
- 知识点：同样,当生命周期较短时,粒子有时会完全像被粘住一样。
- 知识点：因为生命周期短,看起来就像被击中后瞬间消失一样。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`系统`、`生命周期`、`速度`。

**关键画面：**

这一张进入“粒子、系统、生命周期”小节后，`popnet` 已经扩展成一个更完整的物理模拟网络：除了发射、力和阻力，还加入了重力节点，以及由地面平面和静态求解器组成的碰撞分支。字幕里提到把反弹值调成 `0`，而右侧当前参数也正好停在 `popobject` 的物理设置页。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 节点定义集：
  - `source_first_input`：`POP Source`
  - `popforce1`：`POP Force`
  - `popdrag1`：`POP Drag`
  - `wire_pops_into_here`：`Merge`
  - `popobject`：POP 对象
  - `popsolver`：`POP Solver`
  - `gravity1`：重力节点
  - `groundplane1`：地面碰撞对象
  - `merge2`：碰撞分支合并
  - `staticsolver1`：静态碰撞求解器
  - `merge1`：总输出前的最终合并
  - `output`：输出节点

- 连线关系中当前能明确看出的主干包括：
  - `source_first_input -> popforce1 -> popdrag1 -> wire_pops_into_here -> popsolver`
  - `popobject -> popsolver`
  - `popsolver -> gravity1 -> merge1 -> output`
  - `groundplane1 -> merge2 -> staticsolver1 -> merge1`

- 右侧参数面板当前选中的是：
  - `POP Object popobject`
  - 当前打开 `Physical` 选项卡

- 当前可见的 `Physical` 参数包括：
  - `Bounce = 0`
  - `Bounce Forward = 1`
  - `Friction = 1`
  - `Dynamic Friction Scale = 1`
  - `Temperature = 0`

- 输出/预览：
  - 左侧视口中，粒子形成一片贴近地面的低矮团层
  - 字幕说明把 `Bounce` 设为 0 后，反弹高度明显下降
  - 这与当前结果相符：粒子更容易贴地聚集，而不是继续高高弹起

- 这一步的作用：
  - 把 POP 粒子从“只会飞散”推进到“会受重力和地面碰撞控制”
  - 同时说明生命周期之外，`Bounce`、`Friction` 这类物理参数也会显著改变粒子的落地表现
这一张保持完整的碰撞/重力网络不变，但当前再次选中了 `source_first_input` 的 `Attributes` 页，重点转回出生速度的精细控制。和前面相比，这里把 X 方向的速度波动明显收窄到了 `0.2`，说明作者在把粒子运动从“很散”收回到“更可控”的状态。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前网络中仍能确认的主要节点包括：
  - `source_first_input`
  - `popforce1`
  - `popdrag1`
  - `popobject`
  - `popsolver`
  - `gravity1`
  - `groundplane1`
  - `staticsolver1`
  - `merge1`
  - `output`

- 当前选中的节点是：
  - `source_first_input`
  - 类型：`POP Source`

- 当前打开的 `Attributes` 参数中，可见关键设置包括：
  - `Initial State = Free Flying`
  - `Initial Velocity = Set initial velocity`
  - `Velocity = (1, 0, 0)`
  - `Variance = (0.2, 0, 0)`
  - `Add ID Attributes` 已勾选

- 这组参数意味着：
  - 粒子仍然沿 X 方向给定基础初速度
  - 但 X 方向的随机偏差只保留 `0.2`
  - 因此粒子整体走势会比 `Variance = 1` 时更集中、更稳定

- 输出/预览：
  - 左侧视口里，粒子大体形成一块抬起的薄层，而不是大范围炸开
  - 这和较小的速度波动相符，说明系统已经更偏向“可控定向运动”而不是“强随机喷散”

- 这一步的作用：
  - 说明理解粒子核心参数后，调控方式会非常直接
  - 只改一个轴向的 `Variance`，就能明显改变粒子的离散程度和整体可控性
这一张是 `p04.md` 正文部分的最终收束图。当前画面把前面讲过的核心模块都保留在同一套网络里：出生、外力、阻力、碰撞、重力以及速度控制参数都已经到位。左侧视口中的粒子层结果也对应出一种更稳定、更容易继续拓展的基础喷发系统。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前网络中可见的主要节点包括：
  - `source_first_input`
  - `popforce1`
  - `popdrag1`
  - `wire_pops_into_here`
  - `popobject`
  - `popsolver`
  - `gravity1`
  - `groundplane1`
  - `merge2`
  - `staticsolver1`
  - `merge1`
  - `output`

- 当前选中的节点仍是：
  - `source_first_input`
  - 当前打开 `Attributes` 选项卡

- 右侧当前仍能确认的关键速度设置包括：
  - `Initial State = Free Flying`
  - `Initial Velocity = Set initial velocity`
  - `Velocity = (1, 0, 0)`
  - `Variance = (0.2, 0, 0)`
  - `Add ID Attributes` 已勾选

- 输出/预览：
  - 左侧视口中，粒子形成一块抬起且较整齐的薄层
  - 与前面更强随机或更强反弹的状态相比，当前结果明显更克制、更平稳
  - 这说明基础速度、阻力、重力和碰撞已经进入一个比较可控的平衡状态

- 这一步的作用：
  - 把本页关于 Houdini 粒子基础的讲解收束成一套最小可用工作流
  - 读者此时已经能对应出：发射区域、出生速率、生命周期、速度、阻力、重力、碰撞，分别该从哪里调、会影响什么结果

## 补充视觉证据

### S01 00:04:06

这张补充图对应 `S01 00:04:06`，作用是把 `p04.md` 前半段的基础 POP 网络用更清晰的静态画面固定下来。它明确展示了最初只有发射、求解和输出的简化结构，同时能清楚读到 `POP Source` 的发射模式设置。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 节点定义集：
  - `source_first_input`
    - 类型：`POP Source`
    - 作用：从第一输入几何发射粒子
  - `wire_pops_into_here`
    - 类型：`Merge`
    - 作用：把 POP 行为节点汇入求解器
  - `popobject`
    - 类型：POP 对象
    - 作用：承载粒子模拟数据
  - `popsolver`
    - 类型：`POP Solver`
    - 作用：执行粒子时间步进
  - `output`
    - 类型：输出节点

- 连线集：
  - `source_first_input -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 右侧当前选中的是 `source_first_input` 的 `Source` 选项卡，可见关键设置包括：
  - `Emission Type = Scatter onto Surfaces`
  - `Geometry Source = Use First Context Geometry`
  - `Group Type = Guess from Group`
  - `Scale Point Count by Area` 选项可见
  - `Remove Overlapping = None`

- 输出/预览：
  - 左侧视口里，平面网格表面分布着一批稀疏且自然散开的粒子点
  - 这正对应“从表面散点发射”的结果，而不是整块体积填充

- 这张补充图的作用：
  - 作为 `S01` 阶段的清晰证据，确认最初的网络结构和发射模式
  - 让读者能在不依赖视频播放时，直接复建最小 POP 粒子系统的起始状态

### S02 00:08:19

这张补充图对应 `S02 00:08:19`，重点不在网络拓扑变化，而在于把 `POP Source` 的 `Geometry Source` 下拉菜单完整展开了。这样读者可以直接看到：这个发射器并不只会用“第一输入几何”，它还能按上下文顺序切换到第二、第三或第四输入。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前可见的基础网络结构仍为：
  - `source_first_input`
  - `wire_pops_into_here`
  - `popobject`
  - `popsolver`
  - `output`

- 当前右侧选中的是 `source_first_input` 的 `Source` 选项卡。

- 当前已能确认的关键设置包括：
  - `Emission Type = Scatter onto Surfaces`
  - `Geometry Source` 当前值为：
    - `Use First Context Geometry`

- `Geometry Source` 下拉菜单当前展开后，可见的选项包括：
  - `Use Parameter Values`
  - `Use DOP Objects`
  - `Use First Context Geometry`
  - `Use Second Context Geometry`
  - `Use Third Context Geometry`
  - `Use Fourth Context Geometry`

- 这说明 `POP Source` 的几何输入来源有多种模式：
  - 可以直接用参数指定
  - 可以引用 DOP 对象
  - 也可以按上下文输入顺序选第 1 到第 4 个几何输入

- 输出/预览：
  - 左侧视口仍然是平面网格上的稀疏散点
  - 说明此时展示的重点是“输入来源如何选择”，而不是改变最终粒子形态

- 这张补充图的作用：
  - 把正文里一句“Use First Context Geometry”的含义具体化
  - 让读者明确知道，如果后续网络接入多个几何输入，`POP Source` 可以按顺序切换发射来源

### S03 00:13:23

这张补充图对应 `S03 00:13:23`，是 `POP Source` 的 `Birth` 选项卡清晰版。它把正文阶段讲到的“Impulse / Birth Rate / Lifetime”三组关键控制项固定成可直接抄写的参数证据，适合和 Niagara 里的 `Spawn + Lifetime` 概念对照理解。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前可见的基础网络结构仍为：
  - `source_first_input`
  - `wire_pops_into_here`
  - `popobject`
  - `popsolver`
  - `output`

- 当前右侧选中的是：
  - `source_first_input`
  - 当前打开 `Birth` 选项卡

- 当前能清晰读到的 `Birth` 参数包括：
  - `Impulse Activation = 1`
  - `Impulse Count = 0`
  - `Const. Activation = 1`
  - `Const. Birth Rate = 5000`
  - `Max Sim Points` 字段可见但当前数值不清晰
  - `Max Points per Frame = 100000`
  - `Probabilistic Emission` 当前未勾选
  - `Just Born Group` 输入框可见
  - `Seed = 0`
  - `Life Expectancy = 100`
  - `Life Variance = 0`
  - `Jitter Birth Time = Positive`
  - `Interpolate Source = None`

- 这组设置表达的含义是：
  - 当前主要采用连续出生，而不是一次性脉冲爆发
  - 持续出生速率固定为 `5000`
  - 每帧允许生成的最大点数上限是 `100000`
  - 生命周期当前没有随机波动

- 输出/预览：
  - 左侧视口中，粒子仍然以较稀疏的表面分布形式显示在网格上
  - 说明这一页的重点不是形态变化，而是把出生节奏和生命周期参数读清楚

- 这张补充图的作用：
  - 为正文里关于帧率、出生速率和生命周期的讨论提供精确参数依据
  - 让读者可以直接按图复建 `POP Source` 的基础出生配置

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


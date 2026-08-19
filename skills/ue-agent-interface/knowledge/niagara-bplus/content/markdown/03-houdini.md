# 03.Houdini刚体解析

# 03.Houdini刚体解析

## 关键术语

- `Houdini`、`RBD`、`系统`、`网格`、`碰撞`、`速度`、`刚体`、`破碎`、`液体`、`烟雾`、`Niagara`、`Material`、`材质`、`蓝图`、`用户参数`、`Niagara System`、`Emitter`、`Spawn Rate`

## 分段知识

### 00:00:05-00:04:53 RBD、碰撞、刚体

- 本段定位：RBD、碰撞、刚体。
- 知识点：有哪些区别?一边看,让继续弄明白,然后继续往下走 可以跟着操作看,不跟也没关系,随意就好 先建个几何题,把要用来做简单模拟的物理动画对象。
- 知识点：准备位好接下来进入钢体 钢体自动生成工具里,rbd,选好物体后再指定要使用的对象 按回车键后就能看到自动完成的基础设置 效果一目了然,进入动力学网络后结构就变成这样了。
- 知识点：得特别留意,这是一处关键点,稍后再讲 后面再细说,这里同样会生成DOP import 它会被接入DOP网络算是最基础的设置 可以看做,就差不多了。
- 知识点：这是rbd设置的基础加merge节点的原因是 这些打包的物体要合并到多个 合并后进入模拟,必须配置,可能出现这种情况,所以这样设置。
- 知识点：就按这个理解就行,下方设有一个重力值左右的参数 至于rbd打包对象,就像我们之前用Pyro或Flip对象 做液体模拟那样,做的液体模拟也类似。
- 知识点：这类模拟的基本结构其实都很相似 刚体球解气有个不同点在于文件处理 球解气这类,学Flip球解气时靠内部参数设定来做出想要的。
- 知识点：做形状使参数调得特别费劲 这些参数一改,形态就变了 参数一改形状就大变而刚体球解气其实能调的参数少得多。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`、`烟雾`。

**关键画面：**

这张图是 `03.Houdini刚体解析` 的起始操作界面，显示的是一个刚打开的 Houdini 工程空场景。左侧视口是默认网格地面，中央网络区停留在 `/obj` 层级，界面中央可见 `Empty Network / Press Tab to Add Nodes` 提示；上方工具栏已经切到刚体相关的工作集，能看到 `Rigid Bodies` 相关工具页签以及 `Static Object`、`Deforming Object`、`Ground Plane` 等常用对象按钮。结合正文“先建个几何体，把要用来做简单模拟的对象准备好”，这张图的作用是说明本节从最基础的 Houdini 场景搭建开始：先在 `/obj` 层级准备几何对象，再进入刚体自动生成工具或 DOP 网络，而不是直接从已有复杂工程改起。
这张图展示了 Houdini 自动生成后的 `AutoDopNetwork` 动力学网络结构，当前位于 `Dynamics` 视图。中间主链路从左到右依次为：

- `RBD Packed Object geo1`
- `merge2`
- `rigidbodysolver1`
- `merge1`
- `gravity1`
- `output`

从节点连接关系可以看出，这一套最小刚体求解链路的含义是：先把来自 `geo1` 的打包刚体对象送入求解，再与重力节点一起并入最终输出，因此这里的重点是先确认刚体对象如何从 SOP 几何进入 DOP 仿真。

右侧参数面板当前选中的是 `RBD Packed Object geo1`。图中能确认的关键参数如下：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Initial Object Type = Create Active Objects`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`

在 `Initial State` 区域里，`Position`、`Rotation`、`Velocity`、`Angular Velocity` 当前都保持为 `0`，表示该刚体对象没有额外初速度或初始偏移，直接以 SOP 几何当前位置进入模拟。

左侧视口中能看到一个悬空在地面网格上方的黑色球形物体，这与 `SOP Path` 指向的几何输入形成对应关系，说明此时教程已经把待模拟物体打包并送入 DOP 网络，下一步通常就是通过重力和求解器观察其下落碰撞效果。
这张图仍然位于 `AutoDopNetwork` 的 `Dynamics` 网络中，中央可见的求解链保持为：

- `RBD Packed Object geo1`
- `merge2`
- `rigidbodysolver1`
- `merge1`
- `gravity1`
- `output`

与上一张不同的是，这里右侧参数面板已经切换到 `Rigid Body Solver` 节点 `rigidbodysolver1`，并且当前显示的是 `Bullet` 求解页。结合画面底部字幕“求解器主要分为 Blitz 和 RBD 两种引擎”，这张图的作用是指出刚体模拟并不只依赖对象输入，还要通过专门的求解器节点来负责分离动画与碰撞计算。

图中能够可靠辨认的 `Bullet` 求解参数包括：

- `Time Scale = 1`
- `Number of Substeps = 10`
- `Sleeping Time = 2`
- `Contact Breaking Threshold = 0.02`
- `Use Implicit Drag` 已勾选

在下方 `Constraint Solver` 区域中还能确认：

- `Constraint Solver = Parallel Gauss-Seidel (Graph Coloring)`
- `Constraint Iterations = 10`
- `Randomize Constraint Order` 已勾选
- `Ensure Islands are Independent` 已勾选
- `Solve Tolerance = 0.0001`
- `Constraint Force Mixing = 0`
- `Error Reduction Parameter = 0.2`
- `Split Impulse` 已勾选
- `Penetration Threshold = -0.02`
- `Split Impulse ERP = 0.8`

更下方的碰撞/约束附加选项里，还能看到：

- `Use Internal Constraint Networks` 已勾选
- `Make Objects Mutual Affectors` 已勾选
- `Group = *`
- `Data Name = Solver`

因此，这张图传达的重点不是新增网络节点，而是说明 `rigidbodysolver1` 才是真正控制刚体求解品质、子步进、约束迭代与碰撞稳定性的核心节点；当后续模拟结果不稳定、穿插或反应过慢时，通常需要优先回到这里调整求解器参数，而不是只改 `RBD Packed Object`。
### 00:04:53-00:09:41 RBD、系统、碰撞

- 本段定位：RBD、系统、碰撞。
- 知识点：RBD可视为一种较为传统的引擎 基本如此,因此通常都会优先选用Blitz 基本的模拟结构就是这样搭建的 可以清楚看到 可观察到具体用法,比如在当前的Self。
- 知识点：Tab里就能看到 我们用RBD对象构建了这类模拟 还有一种叫Hero Object的特殊对象 Hero这个对象和RBD对象差不多都是钢体模拟的基础。
- 知识点：需要更高精度计算时,才用它可以说是个更精准的选择 用起来更准确,所以其实只用RBD对象基本就够用了 在游戏制作中根本没必要用英雄对象。
- 知识点：完全没必要,直接用RBD对象就够了 在碰撞设置里静态物体或者地面平面也都能通用 这种概念在各种模拟中都通用 比如地面平面,在Pyro或Flip模拟中也都一样能用。
- 知识点：我们常用来,这其实是个我们常用来的概念 所以这里系统会自动,设好了 打包一起设好了,所以这样设置就行 现在再跑一遍模拟就能看到简单的动作出现了。
- 知识点：就能看到了,现在就一个物体很轻 这里的静态物体或变形物体也都能在这里选 能看到的,这个差异稍后我来实际演示一下 在此之前得先讲讲装配节点的作用。
- 知识点：得先说明一下它的作用 是必须的,进行刚体动力学模拟时 必须先将物体打包为RBD对象,才能进入动态网络 这是基本规则,所以这里也必须是RBD打包。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`系统`、`碰撞`。

**关键画面：**

这张图仍然展示 `AutoDopNetwork` 的基础刚体求解网络，中央节点顺序保持为：

- `RBD Packed Object geo1`
- `merge2`
- `rigidbodysolver1`
- `merge1`
- `gravity1`
- `output`

右侧参数面板继续选中 `Rigid Body Solver` 节点，当前页仍是 `Bullet`。图中还能辨认出上一张已经出现过的关键求解设置，例如：

- `Time Scale = 1`
- `Number of Substeps = 10`
- `Sleeping Time = 2`
- `Contact Breaking Threshold = 0.02`
- `Constraint Solver = Parallel Gauss-Seidel (Graph Coloring)`
- `Constraint Iterations = 10`
- `Split Impulse` 已勾选
- `Use Internal Constraint Networks` 已勾选

左侧视口里，黑色球体已经处于半空中的下落过程，说明这一刻主要是在观察最基础的 RBD 物体受重力驱动后的仿真状态，而不是展示新的节点搭建步骤。

结合本段正文“RBD 可视为较传统、最常用的刚体对象方案”，这张图的实际作用是再次固定读者对标准 RBD 基础网络的认知：默认工作流就是把几何打包为 `RBD Packed Object`，接入 `rigidbodysolver1` 与 `gravity1`，先用这一套最常规的结构完成基础碰撞模拟，后面再去比较其他对象类型或更高精度方案。
这张图切回到了几何对象 `geo1` 的内部网络，说明教程开始解释“为什么刚体对象进入 DOP 之前要先做打包”。中间可见的节点链自上而下为：

- `sphere1`
- `rest1`
- `Assemble setup_packed_prims`
- `Null TO_DOPS`

右侧还单独放着一个 `dopimport` 节点，但从当前画面看不出它是否已经连接到其它显示链路，因此这里只能确认它被放在 `geo1` 网络中，用于后续把 DOP 模拟结果导回 SOP。

本图最关键的节点是 `Assemble setup_packed_prims`。结合本段正文“物体以独立单元进入前，需要通过装配节点创建打包几何体”，这里表达的流程是：

1. 先用 `sphere1` 生成基础球体几何。
2. 通过 `rest1` 保留或准备静态参考属性。
3. 使用 `Assemble` 把几何转换为 packed primitive，使其能作为独立刚体单元进入 DOP。
4. 再把结果送到 `Null TO_DOPS`，作为 `RBD Packed Object` 的 SOP 输入出口。

右侧参数面板当前显示的是对象级 `Geometry geo1` 的 `Transform` 页面，能看到默认值保持为：

- `Translate = 0, 0, 0`
- `Rotate = 0, 0, 0`
- `Scale = 1, 1, 1`
- `Pivot Translate = 0, 0, 0`
- `Pivot Rotate = 0, 0, 0`
- `Uniform Scale = 1`

这说明此处教程的重点不是对象级变换，而是强调 RBD 模拟前必须先完成“装配并打包”的预处理；如果没有 `setup_packed_prims` 这一步，普通 SOP 几何不能直接作为规范的刚体对象送进 `TO_DOPS`。
这张图继续停留在 `geo1` 的 SOP 网络中，节点链仍然是：

- `sphere1`
- `rest1`
- `Assemble setup_packed_prims`
- `Null TO_DOPS`

右侧参数面板这次明确选中了 `Assemble setup_packed_prims`，因此可以直接读出该装配节点的关键设置。图中能可靠确认的参数包括：

- `Inside Group = inside`
- `Output Prefix = piece`
- `Create Name Attribute` 已勾选
- `Connect Inside Edges` 已勾选
- `Create Packed Primitives` 已勾选
- `Create Packed Fragments` 已勾选
- `Pivot Location = Centroid`
- `Display As = Full Geometry`

左侧视口中的球体表面已经显示出由许多三角面组成的离散结构，这与 `Assemble` 节点的“把几何整理成可打包、可分片的独立单元”相互对应。也就是说，这一步不是单纯保留原始球体，而是在为后续刚体模拟准备合适的 packed primitive 数据形式。

结合正文“接下来通过装配节点”“以后做示例时也会用到这部分”，可以把这一张理解为对 `setup_packed_prims` 的具体落地说明：当普通几何准备送入 `TO_DOPS` 时，需要至少生成用于区分分片的名称属性，并启用 packed primitive 创建；这样 `RBD Packed Object` 在 DOP 侧才会把它识别成标准刚体对象，而不是把整段几何当成普通未打包网格处理。

### 00:09:48-00:14:42 RBD、碰撞、速度

- 本段定位：RBD、碰撞、速度。
- 知识点：大致如此,接下来 这里我们来看看RBD打包对象中可调节的选项 初始状态就是可以调节位置 旋转和速度等参数的。
- 知识点：地方,差不多就是这样 所以把速度设为3左右方向沿外轴 换称S轴是使就能看到物体 朝这边移动初始速度。
- 知识点：设置也支持还有角速度 速度可以理解为旋转速度 可以这样设置 在物理参数里能看到密度 旋转、刚度、反弹和摩擦这些选项 现在反弹不太明显 跳高反弹值后就能明显看到它跳跳的更高了。
- 知识点：还能看到这个效果这类物理参数在碰撞体上也同样存在 这里也把反弹值调高就能明显看到弹跳更厉害了 所以两边的物理参数会协同计算。
- 知识点：因为两边参数共同参与计算所以才会有这种设定 比如反弹值或旋转刚度 虽然现在用的是球体对象来表示 但若出现明显的旋转抖动 这些参数就能有效抑制这种抖动。
- 知识点：可以理解为可设置的选项 大概就是这样以后用到时再看也行 用上时到时候看一眼就够了 大致就是这样 还有显示引导几何体 这个选项关掉显示几何体后就会变成这样。
- 知识点：能看到蓝色显示这是用来查看碰撞体实际形状的模式 因为容易重叠看不清所以关掉显示几何体 只用碰撞模式来检查 另外还有一些视觉效果的选项。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`速度`、`碰撞`。

**关键画面：**

这张图回到 `AutoDopNetwork` 的 `Dynamics` 网络，但结构比前一段更完整，已经加入了静态碰撞支路。当前能确认的网络结构分为两路并在 `merge1` 汇合：

- 动态刚体支路：`RBD Packed Object geo1 -> merge2 -> rigidbodysolver1`
- 静态碰撞支路：`groundplane1 -> merge3 -> staticsolver1`
- 汇合与输出：`rigidbodysolver1` 和 `staticsolver1` 一起接入 `merge1`，再进入 `gravity1 -> output`

这说明教程已经从“只有一个下落刚体”推进到“刚体加地面碰撞体”的基础求解结构。左侧视口虽然暂时没有清晰显示球体，但网络里新增 `groundplane1` 与 `staticsolver1` 已足以说明这里正在建立静态地面参与碰撞的条件。

右侧参数面板当前选中的是 `RBD Packed Object geo1`，能可靠辨认出的关键参数包括：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Initial Object Type = Create Active Objects`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`

在 `Initial State` 区域里，当前图上可确认：

- `Position = (0, 1, 0)`
- `Rotation = (0, 0, 0)`
结合本段正文“初始状态可以调位置、旋转和速度等参数”，这张图的重点是说明：当刚体对象送入包含地面碰撞的 DOP 网络后，可以直接在 `RBD Packed Object` 的 `Initial State` 中指定初始位置、朝向和速度，用来控制物体进入模拟瞬间的运动状态；其中这里已经把 `Position` 的中间分量调为 `1`，表示球体初始高度被抬离地面。
这张图仍然是包含地面碰撞支路的 `AutoDopNetwork`。中央网络结构没有变化，仍然由以下两路组成并在 `merge1` 汇合：

- 动态刚体支路：`RBD Packed Object geo1 -> merge2 -> rigidbodysolver1`
- 静态碰撞支路：`groundplane1 -> merge3 -> staticsolver1`
- 汇合输出：`merge1 -> gravity1 -> output`

右侧参数面板继续选中 `RBD Packed Object geo1`，但当前页已切到 `Bullet Data`。这张图可以可靠确认的设置包括：

- `Show Guide Geometry` 已勾选
- `Color = (0, 0, 1)`
- `Deactivated Color = (1, 0, 0)`
- `Geometry Representation = Convex Hull`
- `Auto Fit Primitive Boxes, Capsules, Cylinders, Spheres, or Plane` 已勾选
- `Collision Padding = 0.02`
- `Shrink Collision Geometry` 已勾选
- `Shrink Amount = 0.02`
- `Allow Initial Overlap` 已勾选
- `Add Impact Data` 已勾选
- `Enable Sleeping` 已勾选
- `Linear Threshold = 0.8`
- `Angular Threshold = 1`

左侧视口中的球体表面可以看到明显的三角化线框感，这与 `Convex Hull` 作为碰撞表示方式相对应，说明当前不是单纯查看渲染外观，而是在检查 Bullet 侧如何近似这个刚体的碰撞形体。

结合正文“还有不少选项，后面示例制作时会用到”，这张图的核心意义是：`RBD Packed Object` 除了初始位置和速度外，还能进一步决定 Bullet 求解时如何生成碰撞壳、是否允许初始重叠、是否输出碰撞数据以及何时进入休眠；这些参数直接影响刚体碰撞稳定性和调试可视化效果。
这张图从 `AutoDopNetwork` 切回了 `geo1` 的 SOP 网络，重点变成“如何把多个 DOP 对象结果重新导回几何层”。中央和上方可见两套并列的打包出口：

- 左侧一套：`Assemble setup_packed_prims -> Null TO_DOPS`
- 右侧一套：`Assemble setup_packed_prims1 -> Null TO_DOPS1`

下方则能看到一个求解相关节点 `rbdbulletsolver1`，以及两个回读节点：

- `dopimport1`
- `dopimport2`

右侧参数面板当前选中的是 `DOP Import dopimport2`。图中能可靠辨认出的关键设置包括：

- `DOP Network = /obj/AutoDopNetwork`
- `Object = dopobjcreatedby("/obj/AutoDopNetwork/geo2")`
左侧视口中能看到一个棱角更明显的多面体球体，说明当前并不是只回读一个平滑球，而是在尝试把不同几何对象或不同 DOP 对象分别导入、分别观察。

结合正文“同时将多个对象一并导入”的语义，这张图的作用是说明：当场景里存在多套 `TO_DOPS` 输入或多个 DOP 对象时，需要在 SOP 侧为它们分别放置 `dopimport` 节点，并通过 `Object` 字段精确指定要抓取的 DOP 对象来源；这样才能把不同刚体对象的模拟结果单独回读出来，而不是混成一份结果。
### 00:14:48-00:19:31 系统、碰撞

- 本段定位：系统、碰撞。
- 知识点：两个一起可观察到它们共同参与模拟的过程 接下来我们来详细看看这里的初始物体类型 第一个是球体 第二个则更带棱角 可以把它看作球体 把这个地方我们改成静态物体来看看效果。
- 知识点：这时可观察到棒状物体以变为静态物体 可以明显看出 我们建一个立方体把它设为Static Object 试试 它就在这 在碰撞设置中选为Static。
- 知识点：Object后就应用了 这里还会自动生成一个专用的碰撞体积 可以看出它被当作静态物体处理 碰撞作用差不多 所以身要只当碰撞用十样设置更合适。
- 知识点：不过就算把这些物体打包成一个整体随便混在一起 钢体模拟里碰撞照样能正常生效 这样看这里就够了 差不多了 这个先放一边 其实很少会一个一个的去建静态物体。
- 知识点：那换个别的试试 默认就是活动物体 有动画静态物体和变形静态物体 想看出差别的分开看才行 这一步加了套件值就当是动画物体 变形的区别是在几何体内部设置的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`系统`、`碰撞`。

**关键画面：**

这张图再次回到 `AutoDopNetwork`，但当前网络已经从单个刚体对象扩展为“双 RBD 对象 + 静态地面”的结构。画面中能确认的连接关系为：

- `RBD Packed Object geo1` 与 `RBD Packed Object geo2` 同时接入 `merge2`
- `merge2 -> rigidbodysolver1`
- `groundplane1 -> merge3 -> staticsolver1`
- `rigidbodysolver1` 与 `staticsolver1` 一起汇入 `merge1`
这表明教程已经不是只让一个球体与地面碰撞，而是把两个独立刚体对象一起送进同一个 Bullet 刚体求解流程，让它们共同参与碰撞计算。

右侧参数面板当前选中的是 `RBD Packed Object geo2`，图中可确认的设置包括：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Initial Object Type = Create Active Objects`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS1`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`
- `Position = (0, 0, 0)`
- `Rotation = (0, 0, 0)`
- `Velocity = (0, 0, 0)`
- `Angular Velocity = (0, 0, 0)`

因此，这张图的重点是说明：如果想让多个几何体在同一场刚体模拟中一起参与碰撞，不必分别建完全独立的 DOP 网络，而是可以为每个几何准备各自的 `RBD Packed Object` 输入，然后统一并入 `merge2`，交给同一个 `rigidbodysolver1` 求解。
这张图继续位于 `AutoDopNetwork`，但网络已经进一步扩展出“专门的静态对象”输入。当前可确认的结构如下：

- 动态支路：`RBD Packed Object geo1` 与 `RBD Packed Object geo2` 接入 `merge2 -> rigidbodysolver1`
- 静态支路：`groundplane1` 与 `Static Object geo3` 一起接入 `merge3 -> staticsolver1`
- 汇合输出：`rigidbodysolver1` 和 `staticsolver1` 进入 `merge1`，再继续向下连接到 `gravity1`

与上一张相比，最关键的变化是左侧 `merge3` 现在不再只接地面，而是额外接入了一个 `Static Object geo3`。这说明教程开始演示：除了默认地面平面之外，还可以手动指定其它几何作为静态碰撞体加入模拟。

右侧参数面板当前显示的是名为 `geo1` 的对象参数，图中能确认的关键字段包括：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Initial Object Type = Create Static Objects`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`

在 `Bullet Data` 页还能看到：

- `Show Guide Geometry` 已勾选
- `Geometry Representation = Convex Hull`
- `Collision Padding = 0.02`
- `Shrink Collision Geometry` 已勾选
- `Shrink Amount = 0.02`
- `Allow Initial Overlap` 已勾选
- `Add Impact Data` 已勾选
- `Enable Sleeping` 已勾选
- `Linear Threshold = 0.8`
- `Angular Threshold = 1`

左侧视口里球体落在地面上方，说明场景中已经同时存在活动物体和静态碰撞对象。结合本段正文“把它改成静态物体看看效果”，这张图的核心是在说明：任意一个原本可作为 RBD 输入的几何，也可以把 `Initial Object Type` 改为 `Create Static Objects`，让它不参与主动运动、只承担碰撞阻挡作用；这种方式适合把某些辅助几何或障碍物加入刚体场景。
这张图仍然展示同一套多对象刚体网络。可确认的结构与上一张保持一致：

- 动态支路：`RBD Packed Object geo1`、`RBD Packed Object geo2` 接入 `merge2 -> rigidbodysolver1`
- 静态支路：`groundplane1` 与 `Static Object geo3` 接入 `merge3 -> staticsolver1`
- 最终汇合：`merge1 -> gravity1`

但右侧参数面板显示，当前选中的 `RBD Packed Object geo1` 已经把对象类型切换成了：

- `Initial Object Type = Create Deforming Active Objects`

其余当前图中仍能确认的字段包括：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`
- `Position = (0, 0, 0)`
- `Rotation = (0, 0, 0)`
- `Velocity = (0, 0, 0)`
- `Angular Velocity = (0, 0, 0)`

左侧视口里可以看到上下接触的两个球体，其中上方球体表面已有明显变形，不再保持完全规则的球形。这与“Deforming Active Objects”模式相对应，说明这里演示的不是单纯的刚性球体碰撞，而是允许对象在模拟过程中按照输入几何变化或变形状态参与碰撞。

结合本段正文“默认活动物体、动画静态物体、变形物体要分开看差别”，这张图的核心作用是给出第三种对象类型的对比结果：当 `RBD Packed Object` 切到 `Create Deforming Active Objects` 时，对象仍会作为活动碰撞体参与求解，但它的碰撞几何不再被视为恒定不变的刚体外形，而是会跟随几何变形状态参与模拟。

### 00:19:31-00:24:09 RBD、网格、碰撞

- 本段定位：RBD、网格、碰撞。
- 知识点：运动就会变得奇怪 本来往这边走却被弹性的反作用力拉了回去 能看到它往这边弯的加个负值太快了 加了重力想让它撞上 了解下不同物体类型的差别以后用起来会更顺手。
- 知识点：这么建个动态网络 单独建好再放这里 现在就这么设 然后拿去跑模拟 跑完再 导入进来的结构这招 以后说不定还会用到所以 这类基础结构得先弄明白。
- 知识点：只要先搞懂这些后面用RBD分离求解器做操作时就不会觉得别扭 两种都能根据情况灵活用上 以后肯定会有用得上的时候 这个分离求解器基本上把模拟里常用的参数都给安排上了。
- 知识点：该有的都齐了 常用参数都能调用起来也顺手 差不多都给你配好了 说到碰撞这块 这写的是碰撞几何体 这里碰撞体一输入数值 一输入数值就能启用这部分功能。
- 知识点：粉红色区域是约束用来把破碎网格牢牢连在一起 让它们牢牢连在一起 就相当于这样 可以理解为连接作用 可以看出模拟结构正是这样搭建的 这里改成静态物体再通过。
- 知识点：用立方体 改成网格再适当多分几块 用复制点 物体放几个物体 当前数值设为0 就这样设为0后放进去 像这样一起用上这几个 就能看到打包几何体已经变成26个了。
- 知识点：能看到已经变成26个 把每个独立的多边形碎片数一数就知道了 这样打包几何体就玩完了 看现况的话 这里的点也显示为26个 每个物体的中心点都会自动出现。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这张图继续展示多对象的 `AutoDopNetwork`。当前网络结构仍然保持为：

- 动态支路：`RBD Packed Object geo1`、`RBD Packed Object geo2` 接入 `merge2 -> rigidbodysolver1`
- 静态支路：`groundplane1` 与 `Static Object geo3` 接入 `merge3 -> staticsolver1`
- 汇合输出：`merge1 -> gravity1`

右侧参数面板当前选中的是 `RBD Packed Object geo1`，对象类型仍为：

- `Initial Object Type = Create Deforming Active Objects`

图中还能可靠确认的参数包括：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`
- `Position = (0, 0, 0)`
- `Rotation = (0, 0, 0)`
- `Velocity = (0, 0, 5)`
- `Angular Velocity = (0, 0, 0)`

左侧视口中可以看到一个规则球体和一个已经发生形变的多面体球体同时存在，说明这时不只是对物体类型做静态说明，而是在给变形活动对象施加明确的初始运动方向。

结合正文“本来往这边走却被弹性的反作用力拉了回去”，这张图的核心意义是：当 `geo1` 设为 `Create Deforming Active Objects` 后，仍然可以像普通活动刚体一样通过 `Velocity` 指定初始线速度；这里把第三个速度分量设为 `5`，用于演示变形物体在碰撞与反弹作用下的运动偏转效果。
这张图切回到 `geo1` 的 SOP 网络，重点不再是 DOP 求解，而是说明要如何在进入刚体网络之前准备多个源几何。当前画面中能确认出两套并列的打包输入链：

- 左侧已有一套：`sphere1 -> rest1 -> Assemble setup_packed_prims -> Null TO_DOPS`
- 右侧正在建立第二套：`sphere2` 位于上方，下面已经能看到 `rest...`、`Assemble setup_packed_prims1` 和 `Null TO_DOPS1`，但部分节点名被菜单遮挡，无法逐项完整确认

中央还弹出了 `Tab Menu`，当前高亮的是 `Cube`，说明教程正在演示：除了现有球体外，还可以继续在这个几何网络中添加新的基础形体，作为后续刚体对象或碰撞对象的来源。

右侧参数面板当前选中的是 `Sphere sphere2`。图中能可靠辨认的参数包括：

- `Primitive Type = Polygon`
- `Radius = (0.5, 0.5, 0.5)`
- `Center = (0, 5, 0)`
- `Rotate = (0, 0, 0)`
- `Uniform Scale = 1`
- `Orientation = Y Axis`
- `Frequency = 1`

下方还能看到球体分段相关的参数区，但除了 `Rows` 和 `Columns` 字段存在以外，具体值在当前画面中不宜强行确认，因此这里只保留可稳定辨认的信息。

左侧视口中能看到两个上下分离的球体，这与 `sphere2` 的 `Center` 第二分量设为 `5` 相对应，说明新增球体被放到了更高的位置，用来制造后续多物体同时落下、碰撞或互相挤压的模拟条件。
这张图继续停留在 `geo1` 的 SOP 网络里，但重点已经从“单个球体的位置”转到“如何批量生成多个独立 packed 对象”。图中能可靠确认的节点链为：

- `sphere2`
- `box1`
- `copytopoints1`
- `rest2`
- `Assemble setup_packed_prims1`
- `Null TO_DOPS1`

从连接关系可以看出，`sphere2` 与 `box1` 一起作为 `copytopoints1` 的输入，随后结果再经过 `rest2`、`setup_packed_prims1` 和 `TO_DOPS1` 输出。这说明教程此时不再只处理单个物体，而是在用“点复制”的方式批量生成多份几何，然后将这些副本整体整理为可送入 DOP 的 packed 集合。

右侧参数面板当前选中的是 `Assemble setup_packed_prims1`。能确认的关键设置包括：

- `Inside Group = inside`
- `Output Prefix = piece`
- `Create Name Attribute` 已勾选
- `Connect Inside Edges` 已勾选
- `Create Packed Primitives` 已勾选
- `Create Packed Fragments` 已勾选
- `Pivot Location = Centroid`
- `Display As = Full Geometry`

左侧视口和中央弹出的节点信息窗口提供了这套打包结果的直接统计：

- `Points = 26`
- `Primitives = 26`
- `Vertices = 26`
- `Packed Fragments = 26`

画面中能看到 26 个分散排布的线框多面体，这与正文“打包几何体已经变成 26 个，每个物体中心点都会自动出现”完全对应。因此，这张图的关键结论是：通过 `copytopoints1` 批量复制后的几何，在经过 `setup_packed_prims1` 后会被拆分为多个独立的 packed 单元，每一个单元都可在后续刚体模拟里作为独立碰撞对象参与计算。

### 00:24:09-00:27:54 网格、碰撞

- 本段定位：网格、碰撞。
- 知识点：这种差异 效率上的优势也值得留意 明白了吗? 接下来 这里设置了关键帧 之前设为静态物体 现在换成变形物体展示一下 全都这样 碰撞顺畅模拟也能正常运行。
- 知识点：能看到 刚才模拟 没能运行可能是这里一直开着显示造成的 大概如此 因为有些地方直接用了这个路径值 所以能这样配置 也行 钢体模拟长 直接用网格本身套用真实物理参数。
- 知识点：来驱动运动 因此 这类设置要重点考虑各个部件的配置方式 以及约束关系如何建立 碰撞体又该如何设定 这些环节都需要重点配置 这就是关键所在。
- 知识点：简单演示一下这个模拟过程 这里目前仍处于打包集合体状态 但后续也可能需要解包 若需解包可按此操作 解包之后这些多边形就会重新显现 重新出现的。
- 知识点：就能看到 能看到这里选项里能回到原始的 点位还原到最初的状态 还能看到不过动画会保持原样保留 以保留状态导入 也可将打包集合解包使用 这样解包使用时。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这张图又回到 `AutoDopNetwork` 的整体求解结构。当前网络仍然保持为：

- 动态支路：`RBD Packed Object geo1`、`RBD Packed Object geo2` 接入 `merge2 -> rigidbodysolver1`
- 静态支路：`groundplane1` 与 `Static Object geo3` 接入 `merge3 -> staticsolver1`
- 汇合输出：`merge1 -> gravity1 -> output`

右侧参数面板当前选中的是 `RBD Packed Object geo1`，图中可以明确确认：

- `Creation Frame = 1`
- `Object Name = $OS`
- `Initial Object Type = Create Static Objects`
- `Geometry Source = SOP`
- `SOP Path = /obj/geo1/TO_DOPS`
- `Use Object Transform` 已勾选
- `Display Geometry = Simulation Geometry`
- `Position = (0, 0, 0)`
- `Rotation = (0, 0, 0)`
- `Velocity = (0, 0, -1)`
- `Angular Velocity = (0, 0, 0)`

左侧视口里能看到一组已经散落堆叠的立方体，以及前景中的球体。这说明教程此时不是在做单个球体测试，而是在观察批量几何体进入碰撞求解后的群体表现。

结合本段正文“之前设为静态物体，现在换成变形物体展示一下”“有些地方直接用了这个路径值”，这张图的作用是说明：同一套送入 `TO_DOPS` 的对象可以反复切换对象类型与初始速度做对比测试；这里先把 `geo1` 作为 `Create Static Objects` 使用，并给出 `-1` 的第三轴速度分量，用来观察在复杂多物体场景里静态/动态设定差异对模拟结果的影响。
这张图切回 `geo1` 的 SOP 网络，重点从“如何送入 DOP”转成“如何把 DOP 结果导回后再还原为普通几何”。当前能确认的网络元素包括：

- 上方仍保留两套打包出口：`Assemble setup_packed_prims -> Null TO_DOPS` 与 `setup_packed_prims1 -> Null TO_DOPS1`
- 中部存在 `dopimport1`
- 下方能看到 `rbdbulletsolver1`
- 当前正在为右侧回读支路添加一个新节点，画面中弹出了 `Tab Menu`

`Tab Menu` 的搜索词是 `unpack`，当前高亮的就是 `Unpack` 节点。这与正文“目前仍处于打包集合体状态，但后续也可能需要解包”直接对应，说明教程此时在演示：从 DOP 回读的 packed 结果，如果需要恢复成普通多边形几何，可以在后面追加 `Unpack`。

右侧参数面板当前选中的是 `DOP Import dopimport2`，图中能可靠确认的设置包括：

- `DOP Network = /obj/AutoDopNetwork`
- `Objects = dopobjcreatedby("/obj/AutoDopNetwork/geo2")`
- `Import Style = Fetch Geometry from D...`，后半段在当前画面中被截断
- `Add DOP Object Path Attribute` 已勾选
- `Transform Geometry With Position Data` 已勾选
- `Transform Geometry With Geometry Data` 已勾选
- `Preserve World Space Positions` 已勾选
- `Point Velocities = Instantaneous Point Velocities`
- `Add to Existing Velocity Attributes` 已勾选

左侧视口中的物体仍然保持成整块 packed 的外观，这也说明在当前节点位置之前，回读结果还没有被真正拆开。因此，这张图的关键结论是：`dopimport2` 负责把 DOP 对象结果取回 SOP，而如果想重新看到每个多边形片段或把 packed 结果转换回常规几何，就需要在回读支路后面继续接一个 `Unpack` 节点。
这张图继续位于 `geo1` 的 SOP 网络中，但回读与再处理链路比上一张更完整。当前画面能确认的结构包括：

- 左侧第一套输入链：`sphere1 -> rest1 -> setup_packed_prims -> TO_DOPS`
- 右侧第二套输入链：`copytopoints1 -> rest2 -> setup_packed_prims1 -> TO_DOPS1`
- 回读/后处理区域：`dopimport1`、`dopimport2`、`rbdbulletsolver1`、`unpack1`

从画面下方可见，`dopimport2` 已经与 `unpack1` 形成了后续处理链，说明教程此时已经不只是“准备加 Unpack”，而是在把回读的 packed 结果真正接到解包节点后面，用来恢复原始多边形显示。

右侧参数面板当前选中的是 `RBD Bullet Solver rbdbulletsolver1`。图中能可靠确认的设置包括：

- `Start Frame = 1`
- `Time Scale = 1`
- `Global Substeps = 1`
- `Bullet Substeps = 10`
- `Constraint Iterations = 10`
- `Cache Memory (MB) = 5000`

中部标签栏还能确认这是 `Setup` 页，且该节点还带有 `Properties`、`Collision`、`Forces`、`Constraints`、`Guide`、`Visualization`、`Advanced`、`Output` 等分页，说明它是一个在 SOP 层直接封装了刚体求解流程的节点，而不是单纯的 DOP 回读工具。

左侧视口里能看到一整组规则排布的多面体球体，以及地面上的单独球体。结合正文“以保留状态导入，也可将打包集合解包使用”，这张图的核心作用是说明：在 SOP 工作流里，不仅可以通过 `dopimport2` 回收模拟结果，还可以继续用 `unpack1` 把 packed 集合还原为普通几何，并配合 `rbdbulletsolver1` 这种 SOP 级封装求解节点，形成更直接的刚体搭建与回读流程。

## 补充视觉证据

### DOC 00:13:39

这张补充图展示的是 `geo1` 的 SOP 网络基础形态，用来补充说明单个几何对象在送入刚体流程前的准备结构。当前画面中，中央主链路自上而下为：

- `sphere1`
- `rest1`
- `Assemble setup_packed_prims`
- `Null TO_DOPS`

右侧还可以看到一个未接入主链的 `sphere2`，右下方有 `dopimport1`，下方则单独放着 `rbdbulletsolver1`。从当前图的连接状态看，真正已经形成完整输入链的只有左侧这条 `sphere1 -> TO_DOPS` 支路；`sphere2` 只是被选中并显示其参数，还没有在这张图里看到它与其他节点的连线关系。

右侧参数面板当前选中的是 `Sphere sphere2`。图中能可靠辨认的设置包括：

- `Primitive Type = Polygon`
- `Radius = (0.5, 0.5, 0.5)`
- `Center = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Uniform Scale = 1`
- `Orientation = Y Axis`
- `Frequency = 2`

`Rows`、`Columns` 等球体细分字段虽然可见，但当前截图中具体数值无法稳定辨清，因此不在此条中强行补写。

左侧视口里能看到一个由多边形面构成的球体，和字幕“把这个物体设为多边形模式”相互对应。这说明这张补充图的作用是强调：在进入 `Assemble` 与 `TO_DOPS` 之前，源球体本身就是以 `Polygon` 模式创建的，而不是使用更平滑但不利于后续离散观察的显示形式。

### S01 00:04:09

这张补充图回到 `AutoDopNetwork` 的最基础单刚体求解链。按画面中部自上而下的节点顺序，可确认的结构为：

- `RBD Packed Object geo1`
- `merge2`
- `rigidbodysolver1`
- `merge1`
- `gravity1`
- `output`

左侧视口中能看到一个悬空在地面网格上方的球体，说明这里仍是在最小场景中讲解求解器本身，而不是多对象或复杂碰撞体场景。

右侧参数面板当前选中的是 `Rigid Body Solver rigidbodysolver1`，页面位于 `Bullet`。图中能可靠辨认的设置包括：

- `Time Scale = 1`
- `Number of Substeps = 10`
- `Sleeping Time = 2`
- `Contact Breaking Threshold = 0.02`
- `Use Implicit Drag` 已勾选
- `Constraint Solver = Parallel Gauss-Seidel (Graph Coloring)`
- `Constraint Iterations = 10`
- `Randomize Constraint Order` 已勾选
- `Ensure Islands are Independent` 已勾选
- `Solve Tolerance = 0.0001`
- `Constraint Force Mixing = 0`
- `Error Reduction Parameter = 0.2`
- `Split Impulse` 已勾选
- `Penetration Threshold = -0.02`
- `Split Impulse ERP = 0.8`
- `Use Internal Constraint Networks` 已勾选
- `Make Objects Mutual Affectors` 已勾选
- `Group = *`
- `Data Name = Solver`

这张图的补充价值在于把求解器参数区和节点主链同时放进一个画面里，便于对应理解：中部的 `rigidbodysolver1` 是整个刚体求解的核心节点，而右侧这些 `Substeps`、`Constraint Iterations`、`Split Impulse` 与 `Penetration Threshold` 等参数，就是用来控制碰撞精度、穿插修正与约束稳定性的关键调节项。
### S01 00:01:47

这张补充图展示的是 `geo1` 中最基础的单对象输入链，以及与回读节点并列摆放时的关系。中央主链自上而下为：

- `sphere1`
- `rest1`
- `Assemble setup_packed_prims`
- `Null TO_DOPS`

右侧单独放着一个 `dopimport1`，但从当前图的连线情况看，它没有接入这条主链，而是作为后续回读 DOP 结果使用的独立节点存在。也就是说，这张图强调的是“送入 DOP 之前的准备链”和“回读节点的位置”是并列概念，而不是同一条直连流水线。

右侧参数面板当前选中的是 `Assemble setup_packed_prims`。图中能可靠辨认的关键设置包括：

- `Inside Group = inside`
- `Output Prefix = piece`
- `Create Name Attribute` 已勾选
- `Connect Inside Edges` 已勾选
- `Create Packed Primitives` 已勾选
- `Create Packed Fragments` 已勾选
- `Pivot Location = Centroid`
- `Display As = Full Geometry`

左侧视口中能看到一个悬空在网格上的球体，而中间网络区的节点链又明确指向 `TO_DOPS`。结合字幕“这是一处关键点，稍后再讲”，这张图的补充价值在于把关键接口节点明确下来：`setup_packed_prims` 负责把源几何整理为带 `piece` 命名的 packed primitive，`TO_DOPS` 是送入 `RBD Packed Object` 的出口，而 `dopimport1` 则是后续把 DOP 结果取回 SOP 时对应的入口节点。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


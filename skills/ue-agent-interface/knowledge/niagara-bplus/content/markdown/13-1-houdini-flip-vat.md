# 13-1.Houdini FLIP模拟VAT制作

# 13-1.Houdini FLIP模拟VAT制作

## 关键术语

- `Velocity`、`Collision`、`Houdini`、`VAT`、`Water`、`粒子`、`系统`、`网格`、`碰撞`、`速度`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`材质`、`Niagara System`、`Alpha`

## 分段知识

### 00:00:06-00:04:51 Water、粒子、系统

- 本段定位：Water、粒子、系统。
- 知识点：大家好,第13课,大家好 这节课我们用胡迪尼流体模拟,结合White资源 和Whitewater模拟,完成两个粒子系统的搭建。
- 知识点：首先,选中之前导出的InputFBX文件导入即可 只关掉灯光和相机,然后导入 因为我们是从序列中直接导入了已摆放好的角色 所以这个角色位于这里,最上方有一个名为Null的对象。
- 知识点：它的位置值就是这里设置的 On点里设置的位置值会直接继承过来 而网格现在没有对齐中心,就那样漂浮在空中,位置也不清楚 接下来建一个JLT,先拿来用作Object。
- 知识点：Merge 跟平时一样,在Subnetwork里找那个标着谷歌匹配组件的节点 用来接收这些输入 可观察到,现在位置不明,得先用变换移到中心再缩放。
- 知识点：把尺寸缩小100倍,就能看到它,正居中 再用匹配尺寸,只把歪轴调到紧贴地面的位置 其余都设为无,接下来导入了在中心播放动画的网格。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`系统`、`序列`、`碰撞`、`流体`。

**关键画面：**

这一帧是本节在 Houdini 里开始搭建工程的起始状态。当前界面已经切到 `obj` 层级，右上打开了 `Ex_03_Kwang_01_FBX` 相关标签，但对象网络仍是空的，说明此时还处于“准备导入上一节导出的 FBX 输入”的阶段。

- 当前软件与上下文：
  - 软件为 `Houdini Indie Limited-Commercial 20.5.613`
  - 当前网络层级：`/obj`
  - 中央网络视图显示 `Empty Network`
- 当前界面状态：
  - 左侧是空场景视口和默认地面网格
  - 中央对象网络还没有任何节点
  - 右侧参数面板显示 `No Operator Selected`
  - 底部时间范围可见到 `150` 帧
- 当前可见资源标签：
  - `Ex_03_Kwang_01_FBX`
- 当前画面结论：
  - 这一帧不是在调整已有流体节点，而是在确认新课的 Houdini 工程已打开，准备把上一环节导出的角色输入资产接进来
  - 这与正文里“首先，选中之前导出的 InputFBX 文件导入即可”一致
- 结果含义：
  - 后续所有对象、`Null`、`Merge` 以及缩放和居中处理，都是从这个空的 `/obj` 起点开始逐步建立的。
这一帧显示导入后的 `/obj` 层级已经建立出两个关键对象：一个是承载导入内容的 `Ex_03_Kwang_01_FBX` 子网络，另一个是单独准备处理角色网格的 `Character` 几何对象。视口里角色只出现了下半身，而且明显悬在默认地面网格上方，说明当前位置和尺度还没有整理好。

- 当前网络层级：
  - `/obj`
- 当前可见对象节点：
  - `Ex_03_Kwang_01_FBX`
    - 类型：`Subnetwork`
  - `Character`
    - 类型：`Geometry`
- 当前参数面板状态：
  - 选中对象为 `Character`
  - `Translate = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (1, 1, 1)`
  - `Uniform Scale = 1`
- 当前视口状态：
  - 角色网格只局部进入镜头，显示为灰模状态
  - 角色脚底没有贴合原点地面，整体位置偏高
- 当前画面结论：
  - 这一步说明 FBX 已经被成功导入并拆出可操作的角色对象，但还没完成“移到中心、缩放、贴地”这些整理动作
  - 这与正文里“这个角色位于这里”“网格现在没有对齐中心，就那样漂浮在空中，位置也不清楚”一致
- 结果含义：
  - 后续会围绕 `Character` 和导入子网络继续加 `Null`、`Merge` 或匹配节点，把角色从“导进来但姿态和位置未整理”的状态，推进到可用于流体模拟的标准摆位。
这一帧已经进入 `fliptank_initial` 几何网络，开始把角色碰撞与初始水体整合到 FLIP 预备阶段。视口中能看到角色站在一块大面积的粒子平面上，中央网络则明确给出了“合并碰撞 -> 生成水体 -> 拆出初始粒子/表面输出”的节点结构。

- 当前网络位置：
  - `/obj/fliptank_initial`
- 当前可见节点链路：
  - `mergecollisions`
    - 类型：`Object Merge`
  - `collisions`
    - 类型：`Merge`
  - `wavetank`
    - 类型：`Ocean Source`
  - `OUT_INITIAL`
    - 类型：`Null`
  - `initial_particles`
    - 类型：`Blast`
    - 过滤条件：`not: particles`
  - `OUT_INITIAL_PARTICLES`
    - 类型：`Null`
  - `initial_surface`
    - 类型：`Blast`
    - 过滤条件：`not: @name=surface`
  - `OUT_INITIAL_SURFACE`
    - 类型：`Null`
- 当前选中节点：
  - `wavetank`
- 当前可见 `wavetank` 关键参数：
  - 预设：`Wave Tank`
  - `Particle Separation = 0.03`
  - `Oversampling = 1.5`
  - `Grid Scale = 2`
  - `Size = (5, 5, 5)`
  - `Center = (0, 0, 0)`
  - `Create Particles` 已开启
  - `Water Level = 0.3`
  - `Fill Volume` 已开启
  - `Narrow Band Particles` 已开启
  - `Layer Size = 0.18`
  - `Jitter Seed = 0`
  - `Jitter Scale = 1`
  - `Kill Inside Collision` 已开启
- 当前视口状态：
  - 大面积点状水体初始区域已经生成
  - 角色模型已经放进水体区域内，作为后续碰撞参考
- 当前画面结论：
  - 这一帧不是只做“把网格移到中心”的机械操作，而是已经完成基础水池搭建，并把角色碰撞并入初始 FLIP 设置
  - 这与正文里“接下来建一个 FLIP Tank 先拿来用作 Object”“导入在中心播放动画的网格”相吻合
- 结果含义：
  - 到这一步，课程已经从资产导入阶段进入可模拟的初始场景搭建阶段，后续可以继续细化碰撞体、缓存和更精确的流体行为。

### 00:04:51-00:09:06 碰撞、缓存

- 本段定位：碰撞、缓存。
- 知识点：这样改一次尺寸,外形可能没法正常重置 现在还没开启碰撞,当然画面也不会有变化帧数设为150 帧数设好后,接下来教你怎么加碰撞 打开碰撞标签,选中包含角色的模型。
- 知识点：选中变形体,再选中要作为碰撞体的对象,按回车 节点设置就自动完成 这里动态部分的设置也已完成,能直接看到 还有一个要注意的地方,每次创建碰撞时,资源的变化很难看出来。
- 知识点：打开文件缓存,进到下一节点后 就能看出碰撞是以什么大致形状进来的 这样进来的就是一个很简的模型 现在是体积形态会生成一个叫碰撞的VDB体积,用它来做碰撞。
- 知识点：在动态内部实现,所以要更精确的碰撞 最好把复制尺寸键调低到0.01左右 别一上来就设太低,那样计算会很慢,建议一点一点往下调 一点点往下调这事,设成0.0还是有点不准。
- 知识点：最后再补一点,差点忘了点东西 至少得留这么点碰撞才准 另外,显让效果更真实又省事 现在这状态得用拔剑下落的动作不过 要是没有拔剑动作,只有走或跑的话。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这一帧从初始水体网络切回 `/obj` 总览，开始搭建真正承载流体求解的 DOP 外层结构。当前已经能看到 `AutoDopNetwork` 与两个 `fliptank_...` 几何对象并列出现，右侧参数面板停在 DOP Network 的模拟时间设置上，说明此时重点是先把模拟容器建立好，而不是立刻细调碰撞细节。

- 当前网络层级：
  - `/obj`
- 当前可见对象节点：
  - `AutoDopNetwork`
    - 类型：`DOP Network`
  - `fliptank_fluid`
    - 类型：`Geometry`
  - `fliptank_fluidinte...`
    - 类型：`Geometry`
- 当前选中对象：
  - `AutoDopNetwork`
- 当前可见 `AutoDopNetwork` 关键参数：
  - `Initial State` 字段可见
  - `Timestep = 0.0333333`
  - `Substeps = 1`
  - `Offset Time = 0`
  - `Start Frame = 1`
  - `Scale Time = 1`
  - `Max Feedback Loops = 2`
  - `Enable Automatic Resimulation` 已开启
  - `Provide Data Hints` 已开启
  - `Interpolate Display Data` 已开启
- 当前视口状态：
  - 角色已站在原点附近的默认网格地面上
  - 视口里暂时看不到水体显示，重点放在对象层级组织
- 当前画面结论：
  - 这一帧是在把 FLIP 初始场景推进到正式模拟网络阶段，先建立 DOP 框架和相关几何对象的外层关系
  - 这与正文里“帧数设为 150 帧数设好后，接下来教你怎么加碰撞”一致
- 结果含义：
  - 后续关于碰撞对象、缓存和体积碰撞精度的设置，都将在这个 `AutoDopNetwork` 基础上继续展开。
这一帧进入角色碰撞处理网络，重点是把角色网格转换成供流体使用的体积碰撞数据。当前节点链已经清楚地从角色变换、尺寸匹配，走到 `Collision Source`、缓存，再输出 VDB 结果；视口里角色外侧的框体也表明当前正在检查碰撞体积包围范围。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `transform1`
  - `matchsize1`
  - `collisionsource1`
  - `filecache`
  - `VDB`
- 当前选中节点：
  - `collisionsource1`
- 当前碰撞来源与对象路径：
  - 输入对象来自 `Ex_03_Kwang_01_FBX` 下的 `SkeletalMeshComponent0`
- 当前 `collisionsource1` 可见参数：
  - `Volume Name = collision`
  - `Voxel Size = 0.01`
  - `Bandwidth = 4`
  - `Fill Interior` 未开启
- 当前缓存与输出状态：
  - `filecache` 输出文件模式为 `.bgeo.sc`
  - 下游 `Null` 命名为 `VDB`
- 当前视口状态：
  - 角色灰模站立于地面网格上
  - 外侧包围框可见，用于辅助判断碰撞体积覆盖范围
- 当前画面结论：
  - 这一步已经把“角色作为碰撞体”的处理从普通网格阶段推进到体积碰撞阶段，并且开始通过 `Voxel Size` 控制精度
  - 这与正文里“会生成一个叫碰撞的 VDB 体积，用它来做碰撞”“最好把体素尺寸调低到 0.01 左右”一致
- 结果含义：
  - 后续流体求解时使用的并不是原始角色网格本身，而是这里缓存出来的 `collision` 体积数据；精度是否足够，关键就取决于 `Voxel Size` 等体积化参数。
这一帧进入碰撞缓存写盘阶段，重点不再是继续改 `Voxel Size`，而是把已经生成好的碰撞体积序列正式缓存成 `.bgeo.sc` 文件。画面中央停在 `filecache` 节点，右侧参数和弹出的进度窗都能确认当前正在逐帧烘焙碰撞数据。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `object_merge1`
  - `transform1`
  - `matchsize1`
  - `collisionsource1`
  - `filecache`
  - `VDB`
- 当前选中节点：
  - `filecache`
- 当前 `filecache` 可见缓存设置：
  - `Base Name = $HIPNAME.$OS`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - 输出文件模式：`$HIPNAME.$OS_v1.$F4.bgeo.sc`
  - `Evaluate As = Frame Range`
  - `Start/End/Inc = 1 / 100 / 1`
  - `Substeps = 1`
- 当前执行状态：
  - 已弹出 `Interrupt` 进度窗
  - 正在处理 `render frame 62 (62 of 100)`
  - 进度窗底部计时约 `0:09`
- 当前视口状态：
  - 角色和碰撞包围框仍可见，说明缓存对应的就是当前这套角色碰撞体
- 当前画面结论：
  - 这一帧说明碰撞数据已经从“网络中实时生成”进入“可复用缓存文件”的阶段
  - 这与正文里“打开文件缓存，进到下一节点后就能看出碰撞是以什么大致形状进来的”一致
- 结果含义：
  - 后续 FLIP 模拟读取的将是这里烘焙出的碰撞 VDB 序列，而不是每次重新现场计算；这样既方便检查碰撞是否正确，也便于之后继续调求解精度。

### 00:09:20-00:13:53 Niagara、网格、碰撞

- 本段定位：Niagara、网格、碰撞。
- 知识点：首先,在碰撞区域探到变形几何体等选项,已自动配置好 因此,一定要搞清楚模拟网络里,碰撞几何体实际用的是什么网格结构 这点也很关键,所以先关闭显示几何体,再把角色也关掉。
- 知识点：现在应该什么都看不见了吧 打开碰撞引导后,就能实时预览你的几何体,是以什么状态进入的 所以务必做到这一步的确认,不然一上来就直接跑模拟。
- 知识点：结果发现,哎,怎么碰撞不生效?怎么碰撞就是不灵啊?这种情况肯定常会遇到 所以一定要看清几何体到底是以什么形式进来的 在建立碰撞几何体实际模拟时,引导可以关掉。
- 知识点：模拟运行时,引导可以关掉,用网格检查也没问题,保持当前状态就行 现在显示的是6.03左右 我来验证效果6.02的设置,最好尽量用体积采样状态,创建体积形式的碰撞几何体。
- 知识点：这样计算更精准 其余路径之类的都已自动设置好,完全不用操心 先看看效果,不够的话再调低细分尺寸试试 比如把细分尺寸调低一点,都可以试一试。
- 知识点：这里能看到碰撞已初步生效 动作不复杂,看起来像静止的波纹 而且细分尺寸现在设得比较粗 细分尺寸设得太粗,计算精度也会受影响 想要更高质量的效果,还得调一下参数。
- 知识点：想要更好效果,还得微调几个选项,流体模拟也一样 说到底,结构都没变,就换了求解器而已 用碰撞时,不管是做破坏物理模拟,还是流体模拟,都这么建就行。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Niagara`、`碰撞`、`烟雾`、`流体`。

**关键画面：**

这一帧进入 `AutoDopNetwork` 内部，开始把角色碰撞正式接入 FLIP 求解链。画面左侧已经能同时看到角色灰模和蓝色初始水面，中央网络则显示 `Character` 作为 `Static Object` 通过 `staticsolver1` 并入整套求解流程；右侧参数面板进一步说明碰撞并不是直接拿角色网格，而是用 `/obj/Character/VDB` 这份体积代理。

- 当前网络位置：
  - `/obj/AutoDopNetwork`
- 当前可见 DOP 节点结构：
  - `Character`
    - 类型：`Static Object`
  - `merge2`
  - `staticsolver1`
  - `fliptank`
    - 类型：`FLIP Object`
  - `flipsolver1`
  - `merge1`
  - `gravity1`
  - `output`
- 当前选中节点：
  - `Character`
- 当前 `Static Object` 可见关键参数：
  - `Object Name = $OS`
  - `SOP Path = opinputpath("/obj/Character/attrib...")`
  - `OBJ Path = /obj/Character`
  - `Use Deforming Geometry` 已开启
  - `Re-evaluate SOPs to Interpolate Geometry` 已开启
  - `Display Geometry` 已开启
- 当前碰撞体积设置：
  - `Mode = Volume Sample`
  - `Division Method = By Size`
  - `Division Size = 0.0414182`
  - `Proxy Volume = /obj/Character/VDB`
  - `Fix Signs` 已开启
  - `Force Bounds` 已开启
  - `Invert Sign` 已开启
  - `Sign Sweep Threshold = 2`
  - `Max Sign Sweep Count = 3`
  - `Offset Surface = 0`
  - `Tolerance = 0.001`
- 当前视口状态：
  - 角色站在蓝色点状/粒状初始水面上方
  - 角色外包围框仍可见，便于检查碰撞范围是否正确进入模拟
- 当前画面结论：
  - 这一帧能确认碰撞已经真正并入 FLIP 动力学网络，而且是以 VDB 代理体积而不是原始骨骼网格形式参与求解
  - 这与正文里“最好尽量用体积采样状态，创建体积形式的碰撞几何体”一致
- 结果含义：
  - 后续再出现“碰撞不生效”之类问题时，首先就要回到这里检查 `Static Object` 实际引用的 `Proxy Volume` 和体积采样参数是否正确。
这一帧继续停留在 `AutoDopNetwork` 内部，但重点从“参数接对没有”转成“碰撞引导显示出来的实际体积形态是否正确”。左侧视口里角色以半透明引导状态压在蓝色粒子水面上，说明当前正在用显示几何体和碰撞可视化去检查角色碰撞到底是怎样进入模拟的。

- 当前网络位置：
  - `/obj/AutoDopNetwork`
- 当前可见 DOP 节点结构仍包括：
  - `Character`
  - `merge2`
  - `staticsolver1`
  - `fliptank`
  - `flipsolver1`
  - `merge1`
  - `gravity1`
  - `output`
- 当前选中节点：
  - `Character`
- 当前 `Static Object` 仍可见的关键设置：
  - `OBJ Path = /obj/Character`
  - `Mode = Volume Sample`
  - `Division Method = By Size`
  - `Division Size = 0.0414182`
  - `Proxy Volume = /obj/Character/VDB`
  - `Display Geometry` 已开启
- 当前视口状态：
  - 角色以半透明/引导显示状态覆盖在蓝色水面上
  - 角色下肢已经压进水面区域，便于判断碰撞接触位置
  - 底部时间轴当前在第 `23` 帧附近
  - 状态栏显示正在 `DOP Cook`
- 当前画面结论：
  - 这一帧不是为了继续改新参数，而是在确认“你看到的碰撞几何体”和“真正参与模拟的体积代理”是否一致
  - 这与正文里“打开碰撞引导后，就能实时预览你的几何体，是以什么状态进来的”“务必做到这一步确认”一致
- 结果含义：
  - 如果此时角色引导体与水面的接触范围不对，后面出现碰撞不生效、只有静止波纹或交互偏移，根源通常就在这里，而不是先去怀疑求解器本身。
这一帧回到 `Character` 几何网络，目的不是再跑流体，而是回查碰撞源上游的网格摆位和体积范围是否合理。左侧视口只显示角色和蓝色包围框，中央网络则停在 `object_merge1 -> transform1 -> matchsize1` 这一段，右侧参数面板显示当前查看的是 `VDB` 输出 `Null`，说明此时是在核对最终要送去做碰撞代理的结果范围。

- 当前网络位置：
  - `/obj/Character`
- 当前可见上游节点链：
  - `object_merge1`
    - 源对象来自 `Ex_03_Kwang_01_FBX/SkeletalMeshComponent0`
  - `transform1`
  - `matchsize1`
- 当前可见下游节点：
  - `attribcreate...`
    - 节点名未完整显示
- 当前右侧选中节点：
  - `VDB`
    - 类型：`Null`
- 当前 `VDB` 可见状态：
  - `Copy Input` 已开启
  - `Cache Input` 未开启
- 当前视口状态：
  - 角色灰模站立在默认地面网格上
  - 蓝色包围框包住角色下半身到整体躯干范围
  - 视口中没有显示流体面，重点转回碰撞源本身
- 当前画面结论：
  - 这一帧强调的是：在怀疑碰撞不准之前，先回到角色碰撞源网络确认 `object_merge`、`transform`、`matchsize` 之后的空间范围是否合理
  - 这与正文里“所以一定要看清几何体到底是以什么形式进来的”“其余路径之类的都已自动设置好，完全不用操心”相对应
- 结果含义：
  - 只要这里的角色范围、摆位或输出代理不对，后面的 DOP 里即便参数正确，也会表现成碰撞接触不自然、波纹过弱或碰撞位置偏移。

### 00:13:53-00:18:32 Collision、粒子、网格

- 本段定位：Collision、粒子、网格。
- 知识点：盒子已生成,适当抬高一点即可 接下来找到 Flip 容器,将这部分拖入材质或模块输入 就能直接用盒子的尺寸创建容器和 Flip 官体 可以调节粒子分离参数,其他如重力等基础数值也可自由调整。
- 知识点：还有粘度设置,如果需要,此时调整也行,我们这边 主要调一下粒子分离度,先设成 0.02 左右 用 Collide 把这三部分连起来,像之前。
- 知识点：Flip 模拟那样 这里已设置好 Collision,所以要连接 Collision Geometry 这里能直观看到碰撞如何形成 可以用。
- 知识点：Now 节点提取,更清楚地查看生成的网格 这样能更清楚地看到生成的网格形状,但刚才在 VDB 里设定的分辨率选项这里没有 所以,那该怎么办呢?这里有个小麻烦,粒子分离度会影响下方的数值。
- 知识点：要追求极致精度时,还得调低一点,大概设为 0.005 才能接近之前的形状 大概能达成相似效果,如果只是追求简单效果,做轻量级模拟,这种结构就很合适。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Collision`、`材质`、`粒子`、`碰撞`。

**关键画面：**

这一帧开始在 `Character` 网络里单独建立一个盒体，作为后续 FLIP 容器与碰撞区域的尺寸基准。视口中角色站在一个线框盒子内部，中央网络里新增了 `box1`，说明此时是在先用简单几何把模拟范围框出来，而不是直接去改求解器。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点：
  - `object_merge1`
    - 源对象来自 `Ex_03_Kwang_01_FBX/SkeletalMeshComponent0`
  - `transform1`
  - `matchsize1`
  - `box1`
  - `attribcreate...`
    - 节点名未完整显示
- 当前选中节点：
  - `box1`
- 当前 `box1` 可见参数：
  - `Primitive Type = Polygon Mesh`
  - `Connectivity = Quadrilaterals`
  - `Size = (5, 5, 5)`
  - `Center = (0, 0, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (2, 2, 2)`
- 当前视口状态：
  - 角色处在盒体上缘附近
  - 盒体线框还没有完全贴合角色和地面，需要继续调位置
- 当前画面结论：
  - 这一帧说明教程先用一个显式容器框住角色和预期受碰撞的区域，再把它拿去作为后续 FLIP 容器的参考尺寸
  - 这与正文里“盒子已生成，适当抬高一点即可”“就能直接用盒子的尺寸创建容器和 Flip”一致
- 结果含义：
  - 后续的 FLIP 边界、水体范围和碰撞联动，不再靠手感估计，而是围绕这个 `box1` 的尺寸与位置来统一构建。
这一帧已经把盒体正式接入 FLIP 容器节点，开始用统一的容器尺寸生成流体域，并把碰撞接口一起接好。中央网络清楚显示 `box1 -> flipcontainer1 -> flipcollide1 -> null1` 的主链，说明此时重点转为“用盒子尺寸直接生成容器，再把碰撞几何接进来”，而不是继续手动摆盒子。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
- 当前选中节点：
  - `flipcontainer1`
- 当前 `flipcontainer1` 可见参数：
  - `Particle Separation = 0.01`
  - `Grid Scale = 2`
  - `Implicit Bounds` 已开启
  - `Gravity = 9.80665`
  - `Gravity Direction = (0, -1, 0)`
  - `Density` 分组可见但未展开
  - `Surface Tension` 分组可见但未展开
  - `Viscosity` 分组可见但未展开
- 当前视口状态：
  - 角色仍位于盒体线框内，盒体已经成为显式的容器边界参考
  - 角色脚部和盒体底面位置关系便于检查容器是否离地过高或过低
- 当前画面结论：
  - 这一步已经把“盒子尺寸”转成真正驱动 FLIP 域的容器参数，并开始与碰撞节点串联
  - 这与正文里“将这部分拖入材质或模块输入，就能直接用盒子的尺寸创建容器和 Flip”“用 Collide 把这三部分连起来”一致
- 结果含义：
  - 后续如果要在质量和性能之间取舍，优先调的就是这里的 `Particle Separation`，而不是重新改容器构造逻辑；碰撞与容器的关系已经在这一步固定下来。
这一帧继续沿着 `flipcontainer1 -> flipcollide1 -> flipsolver1` 主链向下检查，重点转到求解器层面的流体行为与碰撞结果预览。视口里白色网格化角色叠在蓝色流体面之上，说明当前正在通过显示结果来判断网格/碰撞形成的状态是否足够清楚，而右侧参数则表明此时已进入 `FLIP Solver` 的流体行为设置。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
- 当前选中节点：
  - `flipsolver1`
- 当前 `flipsolver1` 在 `Fluid Behavior` 页签下可见参数：
  - `Velocity Transfer = FLIP (Splashy)`
  - `Velocity Smoothing = 0.1`
  - 折叠分组可见：
    - `Air Incompressibility`
    - `Enforce Particle Separation`
    - `Detect Droplets`
    - `Reseeding`
- 当前视口状态：
  - 蓝色粒状流体面已完整铺开
  - 白色网格化角色覆盖在流体面上方，用于直接观察碰撞和网格关系
  - 盒体边界的部分线框仍可见，便于对照容器范围
- 当前画面结论：
  - 这一帧说明教程已经从“容器怎么搭”推进到“求解器如何解释这些容器与碰撞”的阶段
  - 这与正文里“这里能直观看到碰撞如何形成”“更清楚地查看生成的网格形状”一致
- 结果含义：
  - 当需要追求更细的碰撞网格或更接近原始 VDB 形状时，除了前面的 `Particle Separation`，这里的求解行为和粒子重采样相关选项也会直接影响最终表现。

### 00:18:32-00:23:04 粒子、碰撞、速度

- 本段定位：粒子、碰撞、速度。
- 知识点：此阶段虽可单独调节粒子分离度,但若不起用该选项 将直接继承上一设置的值,即使设为 0.02,颗粒仍显得异常粗大 接下来是最后的流体设置。
- 知识点：先通过压缩,对模拟数据进行内存优化 再用PiCash烘焙结果 先取 100 帧左右试运行一下 看看效果如何,先另存为单个文件,保存好了,现在开始运行。
- 知识点：我运行到约 60 帧就停了 把这部分改成粒子模式,用 Blast 作为参考来检查效果 效果反应太剧烈了,看来得调一下参数,我就先停了。
- 知识点：现在先把表面碰撞关掉,用这板继续跑 这部分最后再确定下最终分辨率,设置不用动 设置不用改,水面线也弄好了,表面碰撞部分施加点厚度就行。
- 知识点：计算是从离表面多远的地方开始的 先把发射粒子移除掉 现在效果看不清,先把最大速度调到 3 左右 先粗略看看反应情况,要是太夸张,再调整。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`速度`、`碰撞`、`流体`。

**关键画面：**

这一帧进入最终流体检查阶段，教程把 `FLIP Solver` 切到粒子可视化模式，用按速度着色的显示方式先粗看模拟反应是否过于激烈。左侧视口中角色呈纯白叠加体，下面是蓝色粒子水面和盒体范围线框，说明当前是在先看粒子运动趋势，而不是直接盯最终表面网格。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `matchsize1`
  - `transform1`
- 当前选中节点：
  - `flipsolver1`
- 当前 `flipsolver1` 在 `Visualization` 页签下可见设置：
  - `Show Collision` 未开启
  - `Points as Spheres` 已开启
  - `Color by Speed` 已开启
  - `Max Speed = 5`
  - 可见蓝到白的 `Visualization Ramp`
- 当前视口状态：
  - 蓝色粒状流体面已铺开
  - 角色以白色叠加显示在流体面上方
  - 容器线框和内部参考盒体仍可见
- 当前画面结论：
  - 这一帧的目的不是追求最终渲染外观，而是用粒子模式快速判断速度场和碰撞反应是不是“太夸张”
  - 这与正文里“把这部分改成粒子模式，用 Blast 作为参考来检查效果”“效果反应太剧烈了，看来得调一下参数”一致
- 结果含义：
  - 在正式长时间缓存之前，先用这种速度着色粒子预览排查异常反应，可以更快发现参数过冲，而不用等完整表面网格都算完。
这一帧已经把模拟结果往后串到压缩、缓存和粒子表面检查节点，目的是在保存数据后，用粒子输出模式再次核对效果。左侧视口里只剩水面和平面中心的一团高亮粒子反应，角色主体已经不再作为主要显示对象；中央网络则说明当前检查链是 `flipsolver1 -> fluidcompress1 -> filecache1 -> particlefluidsurface1`。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `flipsolver1`
  - `fluidcompress1`
  - `filecache1`
  - `particlefluidsurface1`
- 当前选中节点：
  - `particlefluidsurface1`
- 当前 `particlefluidsurface1` 在 `Surfacing` 页签下可见参数：
  - `Method = Average Position`
  - `Particle Separation = 0.1`
  - `Voxel Scale = 0.75`
  - `Influence Scale = 3`
  - `Droplet Scale = 1`
  - `Union Compressed Fluid Surface` 已开启
  - `Erosion Scale = 0.8`
- 当前输出与可视化设置：
  - `Convert To = Particles`
  - `Visualize = Velocity`
  - `Velocity Range = 0 - 10`
  - 可见蓝到白的 `Velocity Ramp`
- 当前缓存状态：
  - 中间缓存节点文件模式显示为 `Ex_03.filecache1_v1.$F4.bgeo.sc`
- 当前视口状态：
  - 蓝色粒状水面仍铺在盒体范围内
  - 中心区域出现一团亮色粒子，用于观察当前速度反应强弱
- 当前画面结论：
  - 这一帧说明教程已经把求解结果压缩并接入缓存链，然后切到粒子输出视图检查是不是“反应太剧烈”
  - 这与正文里“先通过压缩，对模拟数据进行内存优化，再用 file cache 烘焙结果”“把这部分改成粒子模式……检查效果”一致
- 结果含义：
  - 这里的粒子可视化检查相当于一次快速质量门：如果中心反应过强、速度分布过亮，就要回头压低相关参数，而不是直接进入最终长缓存。
这一帧继续停在 `FLIP Solver` 的粒子速度检查模式，但角色和额外表面干扰显示已经被关掉，只保留盒体范围内的蓝色粒子平面，用更干净的视图判断当前速度阈值下的反应是否仍然过大。右侧参数面板里 `Max Speed` 已经从前面的更高值压到 `3`，正符合“先粗略看看反应情况，太夸张再调整”的阶段。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
- 当前选中节点：
  - `flipsolver1`
- 当前 `flipsolver1` 在 `Visualization` 页签下可见设置：
  - `Show Collision` 未开启
  - `Points as Spheres` 未开启
  - `Color by Speed` 已开启
  - `Max Speed = 3`
  - 可见蓝到白的 `Visualization Ramp`
- 当前视口状态：
  - 只显示盒体范围内的蓝色粒子水面
  - 中央还能看到一个较小的内部参考方框
  - 角色模型已经不再显示，视图更适合专看速度响应
- 当前画面结论：
  - 这一帧说明教程已经开始排除干扰显示，只盯粒子与速度响应本身，验证把阈值改到更保守后，模拟是否比前面更稳定
  - 这与正文里“先把发射粒子移除掉……先把最大速度调到 3 左右，先粗略看看反应情况”一致
- 结果含义：
  - 经过这一步，后续再决定最终分辨率或是否恢复更多表面碰撞显示时，就有一个更干净的速度基线可作参考，不会被角色网格或表面层显示误导。

### 00:23:04-00:26:59 Velocity、粒子、网格

- 本段定位：Velocity、粒子、网格。
- 知识点：明显比之前快多了 感觉运行快多了,缓存已全部烘焙完成 先连接粒子检查一下,现在还拿不准是不是对上了。
- 知识点：有点拿不准,对比角色网格再重新烘焙一次 碰撞效果正常只是有点遗憾的是现在 这水的反应再夸张点就好了 把这个节点的 Velocity Scale。
- 知识点：调到 2 相当于增强碰撞时的速度粘质值 应该能行这样跑一遍结果看看,大概 1-2 分钟就能出效果 这次不用跑满 100 帧,跑个 60-70 帧左右看看效果就行。
- 知识点：对,只烘焙到约 70 帧,相比之前明显有更多区域变得发白 现在 Separation 值设在 60-70 帧左右,看看效果就行 现在 Separation。
- 知识点：值设在 0.02 左右,如果把这值调低一点,响应会更灵敏一些,所以 最关键的是,盒子大小也得根据角色反应适量缩小,尽可能做到最小 所以要从这里开始适当删减点数,尽量压缩点的数量。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Velocity`、`贴图`、`粒子`、`速度`、`碰撞`。

**关键画面：**

这一帧回到缓存链本身，准备在调整过速度相关设置后重新烘焙结果。中央网络显示当前结果从 `flipsolver1` 经 `fluidcompress1` 压缩后进入 `filecache1`，右侧面板则停在缓存节点的写盘配置上，说明此时是重新发起一轮较短区间的结果验证缓存。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `fluidcompress1`
  - `filecache1`
- 当前选中节点：
  - `filecache1`
- 当前 `filecache1` 可见缓存设置：
  - `Load from Disk` 已开启
  - `Base Name = Ex_03.filecache1`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - 输出文件模式：`Ex_03.filecache1_v1.$F4.bgeo.sc`
  - `Evaluate As = Frame Range`
  - `Start/End/Inc = 1 / 100 / 1`
  - `Substeps = 1`
- 当前视口状态：
  - 视口中暂时只剩一块灰色平面，不再显示角色和高亮速度反应
  - 说明当前焦点转回缓存执行本身，而不是继续在视口里对比粒子速度
- 当前画面结论：
  - 这一帧是在把前面调过的速度/分离度设置重新送进缓存链，用新的求解结果覆盖验证
  - 这与正文里“重新烘焙一次”“这次不用跑满 100 帧，跑个 60-70 帧左右看看效果就行”一致
- 结果含义：
  - 后续判断 `Velocity Scale` 或 `Separation` 是否改善了反应强度，要以这一轮重新缓存出来的结果为准，而不是沿用前一轮旧缓存。
这一帧是在重新烘焙后的中段结果上做复查。左侧视口只显示蓝色粒子平面和中心更亮的一块反应区域，中央网络仍保持 `flipcollide1 -> flipsolver1 -> fluidcompress1 -> filecache1 -> particlefluidsurface1` 的检查链，说明当前目标是先看新一轮缓存到 60-70 帧附近时，碰撞反应是否比前一版更明显。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `fluidcompress1`
  - `filecache1`
  - `particlefluidsurface1`
- 当前选中节点：
  - `filecache1`
- 当前 `filecache1` 仍可见的缓存设置：
  - `Base Name = Ex_03.filecache1`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - 输出文件模式：`Ex_03.filecache1_v1.$F4.bgeo.sc`
  - `Evaluate As = Frame Range`
  - `Start/End/Inc = 1 / 100 / 1`
  - `Substeps = 1`
- 当前视口状态：
  - 底部时间轴约在第 `69` 帧
  - 中央反应区域比前一轮更亮、更集中
  - 角色和容器干扰显示已被压到最低，便于只看粒子反应强弱
- 当前画面结论：
  - 这一帧能确认教程正在拿“约 60-70 帧”的中段结果做快速复查，而不是等 100 帧全部算完
  - 结合正文“只烘焙到约 70 帧，相比之前明显有更多区域变得发白”，当前画面正是在验证这一变化是否出现
- 结果含义：
  - 如果这里的亮区和扰动范围已经比上一轮明显增强，就说明前面对速度/响应相关参数的调整方向是有效的，后续只需继续细化精度和容器范围，而不用重做整套结构。
这一帧把优化重点转回容器本身：不是再单纯看速度，而是通过调整 `box1` 的位置和范围，尽量缩小 FLIP 有效区域来减少点数，并让角色反应区占容器更高比例。左侧视口里角色周围的亮区更集中，中央网络仍保持整条模拟链，而右侧参数显示当前选中的正是容器基准盒体。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `fluidcompress1`
  - `filecache1`
  - `matchsize1`
- 当前选中节点：
  - `box1`
- 当前 `box1` 可见参数：
  - `Size = (5, 5, 5)`
  - `Center = (0, 1, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (2, 2, 2)`
- 当前视口状态：
  - 底部时间轴约在第 `69` 帧
  - 蓝色粒子平面中央的亮色扰动区域更靠近角色动作区
  - 角色模型重新显示，用来直接对照“反应区”和角色位置的匹配程度
- 当前画面结论：
  - 这一帧能确认教程在通过上抬/收紧盒体基准，压缩无效模拟空间，从而让同样的点数更集中服务于角色附近的碰撞反应
  - 这与正文里“盒子大小也得根据角色反应适量缩小，尽可能做到最小”“尽量压缩点的数量”一致
- 结果含义：
  - 当 `Separation` 已调到合适范围后，继续提升响应灵敏度和计算效率的关键，就变成容器范围是否足够紧凑；这一步是在用更小的有效域换取更集中的碰撞表现。

### 00:27:11-00:29:45 粒子、碰撞、缓存

- 本段定位：粒子、碰撞、缓存。
- 知识点：往上抬一点,这里设为 4,打开后看看,往这边拉,更合适 用负值往里拉一下,这样处理好,这边也稍减一点,调到这个程度检查一下 然后现在把细分尺寸调低点验证效果,选项不用大改,关键是碰撞精度。
- 知识点：这样应该没问题,检查后发现粒子响应明显更生动了,计算精度提升让效果更加真实 这类细节处的飞舰效果也清晰呈现了,缓存至此完成 接下来用检查流体表面,提取 V 体资源。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`碰撞`、`流体`。

**关键画面：**

这一帧继续围绕容器范围做压缩优化，重点是把 `box1` 再缩小并略微上抬，让有效模拟空间更贴近角色实际落水区域。右侧参数已经不再是之前的标准立方体，而是明确改成了更扁、更窄的尺寸组合，视口里的反应区也因此更集中在角色周围。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `fluidcompress1`
  - `filecache1`
  - `matchsize1`
- 当前选中节点：
  - `box1`
- 当前 `box1` 可见参数：
  - `Size = (5, 3, 4)`
  - `Center = (0, 1.35, 0)`
  - `Rotate = (0, 0, 0)`
  - `Uniform Scale = 1`
  - `Axis Divisions = (2, 2, 2)`
- 当前视口状态：
  - 底部时间轴约在第 `69` 帧
  - 蓝色粒子平面中央的亮色响应区仍围绕角色集中
  - 角色位置与亮区更接近，说明容器范围正在向有效交互区收紧
- 当前画面结论：
  - 这一帧能确认教程在用更小的盒体尺寸配合更高一点的中心位置，进一步减少无效模拟区域
  - 这与正文里“往上抬一点”“往这边拉、更合适”“这样处理好，这边也稍减一点”一致
- 结果含义：
  - 当容器范围收紧到足够贴合角色动作区后，同样的点数会更集中地服务于交互位置，粒子响应会更生动，后续缓存效率也会更高。
这一帧把注意力从盒体尺寸本身切到 `flipcontainer1` 的精度设置上，目标是在容器范围已经收紧的前提下，再用更合适的粒子分离度做一次完整测试。左侧视口里角色和容器线框都还保留着，说明当前是在对照角色位置确认容器仍然覆盖有效动作区，而不是只盯参数数值。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `box1`
  - `flipcontainer1`
  - `flipcollide1`
  - `null1`
  - `flipsolver1`
  - `fluidcompress1`
  - `transform1`
  - `matchsize1`
- 当前选中节点：
  - `flipcontainer1`
- 当前 `flipcontainer1` 可见参数：
  - `Particle Separation = 0.02`
  - `Grid Scale = 2`
  - `Implicit Bounds` 已开启
  - `Gravity = 9.80665`
  - `Gravity Direction = (0, -1, 0)`
- 当前视口状态：
  - 角色位于收紧后的容器线框内部
  - 外层参考框和内层有效容器都仍可见，便于确认有没有裁掉动作范围
- 当前画面结论：
  - 这一帧说明教程已经把测试参数切到更适合复核的一档，用 `Particle Separation = 0.02` 做全帧级别的最终确认
  - 这与正文里“现在 Separation 值设在 0.02 左右”“全帧跑一次测试，最后确认有没有漏掉的地方”相对应
- 结果含义：
  - 当容器范围和粒子分离度同时稳定后，后续再做整段缓存时，就能更有把握地兼顾响应质量和计算成本。
这一帧进入本段收尾检查：把缓存后的流体结果重新读回，并与角色一起放到视口里确认最终反应是否足够生动。左侧视口里角色跪在蓝色流体面上，周围出现更明显的浅蓝/白色响应区；中央网络则说明检查链已经从 `filecache1` 走到 `particlefluidsurface1`，再并到 `merge1` 做综合预览。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `filecache1`
  - `particlefluidsurface1`
  - `merge1`
- 当前选中节点：
  - `filecache1`
- 当前 `filecache1` 可见缓存设置：
  - `Base Name = Ex_03.filecache1`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - `Start/End/Inc = 1 / 150 / 1`
  - `Substeps = 1`
- 当前时间线与执行状态：
  - 底部时间轴约在第 `78` 帧
  - 状态栏显示正在 `Loading geometry`
- 当前视口状态：
  - 角色模型已重新显示
  - 蓝色流体面围绕角色膝部区域出现更丰富的亮色扰动带
  - 结果比前面的单纯粒子速度检查更接近最终表现
- 当前画面结论：
  - 这一帧说明缓存后的流体结果已经能和角色一起做最终效果判断，而不只是孤立看粒子点或速度热区
  - 这与正文里“粒子响应明显更生动了，计算精度提升让效果更加真实”“缓存至此完成”一致
- 结果含义：
  - 到这一步，本段关于容器、精度、碰撞和缓存的调优已经基本闭环，后续可以继续转向流体表面检查和 V 体资源提取，而不是再反复回头改基础模拟链。

## 补充视觉证据

### S03 00:11:37

这张补充截图用于更集中地核对 `S03` 阶段里角色碰撞是如何作为 `Static Object` 进入 `AutoDopNetwork` 的。画面把角色半透明引导体、蓝色粒子水面和 DOP 节点链同时放在一个视图里，比主线图更适合检查“代理体积有没有正确压进水面、求解器是否正在按这一套碰撞配置运行”。

- 当前网络位置：
  - `/obj/AutoDopNetwork`
- 当前可见 DOP 节点结构：
  - `Character`
    - 类型：`Static Object`
  - `merge2`
  - `staticsolver1`
  - `fliptank`
    - 类型：`FLIP Object`
  - `flipsolver1`
  - `merge1`
  - `gravity1`
  - `output`
- 当前选中节点：
  - `Character`
- 当前 `Static Object` 可见关键设置：
  - `Object Name = $OS`
  - `SOP Path = opinputpath("/obj/Character/attrib...")`
  - `OBJ Path = /obj/Character`
  - `Use Deforming Geometry` 已开启
  - `Re-evaluate SOPs to Interpolate Geometry` 已开启
  - `Display Geometry` 已开启
- 当前碰撞体积设置：
  - `Mode = Volume Sample`
  - `Division Method = By Size`
  - `Division Size = 0.0414182`
  - `Proxy Volume = /obj/Character/VDB`
  - `Fix Signs` 已开启
  - `Force Bounds` 已开启
  - `Invert Sign` 已开启
  - `Sign Sweep Threshold = 2`
  - `Max Sign Sweep Count = 3`
  - `Offset Surface = 0`
  - `Tolerance = 0.001`
- 当前视口状态：
  - 角色以半透明引导体覆盖在蓝色粒子水面上
  - 角色下肢已经压进水面区域，便于核对碰撞接触深度
  - 底部时间轴约在第 `23` 帧
  - 状态栏显示正在 `DOP Cook`
- 当前画面结论：
  - 这张补充图进一步证明，教程不是拿原始角色网格直接做碰撞，而是先输出 `/obj/Character/VDB`，再通过 `Static Object` 的体积采样方式进入 FLIP 求解
  - 这与正文里“打开碰撞引导后，就能实时预览你的几何体，是以什么状态进来的”“最好尽量用体积采样状态”完全一致
- 结果含义：
  - 当后续需要排查碰撞不生效、接触区域偏移或波纹过弱时，这张图给出的排查入口最明确：优先回查 `Proxy Volume`、`Division Size` 和当前引导体是否真实压在目标水面交互区。
## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


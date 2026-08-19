# 05.Houdini与Niagara缓存烘焙联动

# 05.Houdini与Niagara缓存烘焙联动

## 关键术语

- `Initialize Particle`、`Houdini`、`Mesh`、`后期处理`、`粒子`、`发射器`、`系统`、`生命周期`、`速度`、`透明度`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`Niagara System`、`Normalized Age`

## 分段知识

### 00:00:06-00:04:14 粒子、速度、噪声

- 本段定位：粒子、速度、噪声。
- 知识点：大家好,我是奥光,大家好 这次我们第一次讲Nigara缓存这部分内容 我们快点开始吧 上回我们看了VDB对象,这次先 做个简单的粒子运动,再弄个带噪点的粒子。
- 知识点：把数据烘焙成缓存再导入Unreal 就到这一步用噪声向量控制粒子运动 我先加个速度场,先把一段简单的烟雾做出来。
- 知识点：让粒子跟着它的运动走现在 加了个速度场,用向量看,能直接看到它怎么生成的现在用标记点做动画。
- 知识点：把动画节奏调到3左右,让动画顺滑 帧率设为30只烘焙前150帧,接着导入 用PyroSource加个简单的喷烟模拟 弄个轻一点的 我来直接加个烟雾,再加个速度场的流动效果。
- 知识点：用体积重置把数据转成体积 只保留密度、温度和速度这三个 接着用飞控求解器加个简单的喷射模拟 在原设置里,向目标这类参数,当前帧率其实不用管。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`速度`、`噪声`、`烟雾`。

**关键画面：**

这一张是 `p05` 新主题“缓存烘焙联动”的起始画面，仍然从 Houdini 的 `/obj` 空场景开始，但这次中央已经弹出 `Tab - Add Operator` 菜单，表示作者准备直接新建对象节点来搭这次的烟雾/缓存前置流程。

- 当前软件仍是：
  - `Houdini Indie Limited-Commercial 20.5.613 - Py3.11`

- 当前层级位于：
  - `/obj`

- 左侧视口状态：
  - 空场景
  - 默认地面网格和天空背景可见
  - 视角为 `Persp`

- 中央网络编辑区当前没有已放置对象节点，但已打开 `Tab Menu`，可见：
  - 顶部搜索框 `type to search`
  - 分类列表包括：
    - `Animation`
    - `Cameras`
    - `Character FX`
    - `Dynamics`
    - `Environments`
    - `Geometry`
    - `Lights`
    - `Render`
    - `Utility`
    - `More`
    - `All`

- 右侧参数面板当前显示：
  - `No Operator Selected`

- 这一步的作用：
  - 明确本页会从零开始新建一套新的 Houdini 对象流程
  - 为后续加入粒子、速度场、PyroSource 与缓存烘焙相关节点提供起点
这一张已经进入 `geo1` 几何层，并快速搭出本页开头的基础烟雾/速度场前置结构。画面左侧能看到一个球体表面与外扩的黄色向量线，说明作者正用噪声向量给球体表面生成速度场；中间网络也明确表现为 `sphere1 -> attribnoisevector1 -> pyrosource1`。

- 当前层级位于：
  - `/obj/geo1`

- 节点定义集：
  - `sphere1`
    - 类型：球体几何
    - 作用：作为初始发射/采样几何
  - `attribnoisevector1`
    - 类型：属性噪声向量节点
    - 作用：给几何附加向量噪声，形成速度方向
  - `pyrosource1`
    - 类型：`Pyro Source`
    - 作用：把几何和属性转换成后续可用于烟雾模拟的源数据

- 连线集：
  - `sphere1 -> attribnoisevector1 -> pyrosource1`

- 左侧视口中的可见结果包括：
  - 一个球体表面上分布着大量黑色采样点
  - 从球体表面向外延伸出大量黄色向量线
  - 向量方向和长度存在明显噪声变化，说明当前重点确实是“用噪声向量控制粒子/烟雾的初始运动”

- 右侧参数面板当前选中的是：
  - `Pyro Source pyrosource1`

- 当前可见的 `Pyro Source` 参数包括：
  - `Group Type = Guess from Group`
  - `Initialize` 选项可见
  - `Mode = Keep Input`
  - `Particle Separation = 0.1`
  - `Particle Scale = 2`

- `Attributes` 区域当前显示共有 `3` 条属性输出，分别是：
  - `Density`
    - `Default Value = 1`
    - `Scale = 1`
  - `Temperature`
    - `Default Value = 1`
    - `Scale = 1`
  - `Velocity`
    - `Vector Attr` 已启用
    - `Default Value = (1, 1, 1)`
    - `Scale = 1`

- 中央还打开了一个 `Tab Menu`，当前高亮到 `Volume Rasterize` 相关工具，可见候选包括：
  - `Volume Rasterize Attributes`
  - `Volume Rasterize Curve`
  - `Volume Rasterize Hair`
  - `Volume Rasterize Lattice`
  - `Volume Rasterize Particles`
  - `Volume Rasterize Points`

- 这一步的作用：
  - 先用球体和噪声向量制作一个简单但有流动方向的源几何
  - 再通过 `Pyro Source` 准备密度、温度、速度三类关键体积属性，为后续体积烟雾和缓存烘焙流程打底
这一张把前一张的几何与属性源正式推进成一个可见的轻量烟雾模拟。网络已经扩展为 `sphere1 -> attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1 -> pyrosolver1`，左侧视口也能直接看到一团白色喷烟结果。

- 当前层级位于：
  - `/obj/geo1`

- 节点定义集：
  - `sphere1`
  - `attribnoisevector1`
  - `pyrosource1`
  - `volumerasterizeattributes1`
    - 类型：`Volume Rasterize Attributes`
    - 作用：把点/属性数据转成体积字段
  - `pyrosolver1`
    - 类型：Pyro 求解器
    - 作用：对密度、温度、速度场做烟雾模拟

- 连线集：
  - `sphere1 -> attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1 -> pyrosolver1`

- 左侧视口中的结果表现为：
  - 一团轻量、偏白色的烟雾从地面附近向前上方扩散
  - 形态比较柔和，没有很强的爆炸感
  - 符合正文里“先做个轻一点的简单喷烟模拟”的目的

- 右侧参数面板当前选中的是：
  - `pyrosolver1`
  - 当前打开的是 `Source` 页

- 当前 `Source` 区域可清晰读到：
  - `Source Type = Individual Volumes`
  - `Limit Source Range` 已勾选
  - `Range Type = Frame Range`
  - `Frame Range = 1 ~ 150`
  - `Number of Sources = 3`

- 三个体积源条目当前分别为：
  - `Source 1: density`
    - `Operation = Add`
    - `Source Volume = density`
    - `Target Field = density`
    - `Source Scale = 1`
  - `Source 2: temperature`
    - `Operation = Pull`
    - `Source Volume = temperature`
    - `Target Field = temperature`
    - `Source Scale = 1`
    - `Acceleration Strength = 50`
    - `Deceleration Strength = 0`
  - `Source 3: vel`
    - `Operation = Add`
    - `Source Volume = v`
    - `Target Field = vel`
    - `Source Scale = 3`

- 这一步的作用：
  - 把前面生成的密度、温度、速度属性真正喂给 `pyrosolver1`
  - 并把烘焙前的模拟帧范围限制在 `1-150`，为后面导出缓存再进 Unreal 做准备

### 00:04:18-00:08:59 后期处理、粒子、生命周期

- 本段定位：后期处理、粒子、生命周期。
- 知识点：当前球体表面默认持续产生5000个粒子 生命周期圆为100秒,信条整为约0.5秒 以完整保留体积的流动方向,为此,需使用通过体积进行对流节点。
- 知识点：该节点名为,通过体积进行对流 通过实量场,通过火焰球接器,直接引入实量场中包含的速度场。
- 知识点：作为当前粒子的速度场来源 因此,我们启用速度场更新功能 每帧都会按时更新速度场 由于标记处于开启状态,关闭后便可看到刚才的效果 这种节点是通过实量场,通过火焰球接器。
- 知识点：直接引入实量场中包含的速度场 作为当前粒子的速度场来源 这种节点能简化烟雾运动原样喷射的模拟过程 因此常被使用,可视为常用工具 尤其在游戏场景中,目前仅生成少量点。
- 知识点：但通常会生成数百万,甚至数千万个点 在画面中大量喷射,将点的尺寸调至极小 再通过模糊等后期处理,增强亮度 使其呈现发光影像效果 因此常用于制作这类视觉效果,让点难以察觉。
- 知识点：从而营造出细腻的序列感 了解这一点就能掌握一个非常实用的技巧 此外,在对流类型中,共有三种选项 粒速度,简单来说,位置速度就是把当前粒子原有的速度。
- 知识点：再叠加一个额外的速度 位置就是持续更新当前粒子的位置 所以这两个数值的结果看起来非常接近 是的,基本一致 但说到粒,它并非精确的速度,只是沿某一方向施加的作用力。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`序列`、`生命周期`、`速度`、`烟雾`、`火焰`。

**关键画面：**

这一张开始从“先做一段轻量烟雾”过渡到“把体积流动继续转成粒子表现”。网络主体仍是 `sphere1 -> attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1 -> pyrosolver1`，但中央已经弹出 `Tab Menu` 并高亮 `POP Network`，说明作者下一步准备引入粒子系统来承接体积速度场。

- 当前层级位于：
  - `/obj/geo1`

- 当前已存在的节点链包括：
  - `sphere1`
  - `attribnoisevector1`
  - `pyrosource1`
  - `volumerasterizeattributes1`
  - `pyrosolver1`

- 左侧视口中的当前预览包括：
  - 一个白色球状烟团位于容器底部附近
  - 外围可见一个浅红色线框盒体，表示当前体积模拟的容器边界
  - 说明此时仍在观察 Pyro 体积阶段的结果

- 中央当前打开 `Tab Menu`，搜索结果区域高亮显示：
  - `POP Network`

- 同时还能看到同类候选里包含：
  - `PolyPatch`
  - `PolyPath`
  - `Pack Points`
  - `Pyro Post-Process`
  - `Vellum Post-Process`
  - `Whitewater Post-Process`

- 右侧当前选中的是一个名为 `VF` 的 `Null` 节点，参数面板里能看到：
  - `Copy Input` 已勾选
  - `Cache Input` 选项可见

- 这一步的作用：
  - 保留当前烟雾体积结果作为速度场/流动参考
  - 然后准备追加一个 `POP Network`，把体积里的流动信息继续用于粒子系统和后续缓存烘焙流程
这一张已经进入新的 `popnet`，并且在 `POP Source` 和 `Merge` 之间插入了 `popadvectbyvolumes1`。这正对应正文里提到的“通过体积进行对流”：把 Pyro 体积中已有的速度场拿来驱动粒子，让粒子沿着烟雾原本的流动方向运动。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 节点定义集：
  - `source_first_input`
    - 类型：`POP Source`
    - 作用：持续产生粒子
  - `popadvectbyvolumes1`
    - 类型：按体积对流的 POP 节点
    - 作用：读取体积中的速度场来更新粒子运动
  - `wire_pops_into_here`
    - 类型：`Merge`
  - `popobject`
    - 类型：POP 对象
  - `popsolver`
    - 类型：`POP Solver`
  - `output`
    - 类型：输出节点

- 连线集：
  - `source_first_input -> popadvectbyvolumes1 -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 左侧视口当前结果包括：
  - 一个蓝色球体作为发射/参考几何仍然可见
  - 大量黑色粒子已经围绕球体被卷成一股股流动的形态
  - 粒子不再只是均匀向外散开，而是沿着体积速度场形成带旋卷感的运动轨迹

- 右侧当前选中的是 `source_first_input` 的 `Birth` 选项卡，可见关键参数包括：
  - `Impulse Activation = 1`
  - `Impulse Count = 0`
  - `Const. Activation = 1`
  - `Const. Birth Rate = 5000`
  - `Max Points per Frame = 100000`
  - `Probabilistic Emission` 未勾选
  - `Seed = 0`
  - `Life Expectancy = 2`
  - `Life Variance = 0.5`
  - `Jitter Birth Time = Positive`
  - `Interpolate Source = None`

- 这组参数表达的含义是：
  - 粒子以持续发射模式生成
  - 每秒出生速率保持在 `5000`
  - 基准生命周期为 `2` 秒
  - 再叠加 `0.5` 的生命周期波动

- 这一步的作用：
  - 建立一个既能持续生成、又能顺着体积速度场被带动的粒子系统
  - 为后续通过减小点尺寸、叠加后期处理来制作“发光序列感”的效果做基础
这一张把 `popadvectbyvolumes1` 的关键设置完全亮出来了，是“通过体积进行对流”这一步最直接的参数证据。它明确说明：粒子当前不是靠自身初速度单独飞散，而是从一个 SOP 路径中读取名为 `vel` 的速度场，每帧更新粒子速度。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前网络仍为：
  - `source_first_input -> popadvectbyvolumes1 -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 当前选中的节点是：
  - `popadvectbyvolumes1`
  - 节点类型：`POP Advect by Volumes`

- 右侧 `Parameters` 页当前可见的关键设置包括：
  - `Activation = 1`
  - `Velocity Source = SOP`
  - `SOP = /obj/geo1/VF`
  - `Field Name = vel`
  - `Velocity Scale = 1`
  - `Advection Type = Update Velocity`
  - `Velocity Blend = 1`
  - `Advection Method = Trace Midpoint`
  - `CFL Condition = 1`
  - `Use VEXpression` 选项可见但未勾选

- 这组参数的含义可以直接理解为：
  - 速度场来自一个 SOP 几何/体积节点，而不是 DOP 内部对象
  - 当前读取的速度字段名是 `vel`
  - 对粒子的处理方式是“更新粒子速度”
  - 速度混合强度当前是完全采用该体积速度场

- 输出/预览：
  - 左侧视口当前只保留一个蓝色球体参考几何，粒子在当前帧并未明显铺开
  - 这说明这张图的目标是读清“体积速度场如何接入”，而不是展示某个特定视觉结果

- 这一步的作用：
  - 把正文里“通过体积进行对流”“引入速度场并逐帧更新”的说法落实到可复建参数
  - 读者如果要复做这一步，核心就是准备好 `/obj/geo1/VF` 这样的速度场来源，并保证字段名为 `vel`

### 00:08:59-00:13:27 Niagara、Houdini、粒子

- 本段定位：Niagara、Houdini、粒子。
- 知识点：先用混合控制,看起来更贴合烟雾运动 而且效果会明显受数值影响 这样通过拖拽调节,防止扩散太开 再加一个叫着色的节点,用来把颜色应用到点上。
- 知识点：可以看作一个颜色复制节点,这里直接连出去也行 需要的话也可以单独控制 先创建一个名为透明度的属性,勾选表达式 试制为随年龄剑影,这样就会根据年龄值生成硅一化的透明度。
- 知识点：这样就能实现根据年龄值自动生成硅一化透明度属性的配置 这样粒子就会逐渐变淡,呈现出剑影效果。
- 知识点：,粒子这部分上次演示时漏掉了,这次补上 以粒子为基础生成时,会默认自带一些关键属性。
- 知识点：主要生成的有年龄、IDDP以及速度等关键属性 它们是使用中最核心的要素 您可以这样理解,我们这次要测试的Nigara缓存节点。
- 知识点：Engine 最关键的优势就是,完全保留 正因为如此,在Houdini中创建的粒子数据,所有属性都能直接复用。
- 知识点：在Unreal Engine中同样可用,这正是它最突出的优势 所以这类能充分利用这些属性的节点,完全可以当作标准流程来使用 在PointBank中,我们试着加入渐变颜色,把年龄除以总生命周期。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Niagara`、`Houdini`、`粒子`、`生命周期`、`速度`、`颜色`、`透明度`、`烟雾`。

**关键画面：**

这一张延续上一批的 `POP Advect by Volumes` 设置，但当前最关键的变化是把 `Velocity Blend` 调成了 `0.5`。这意味着粒子速度不再完全被体积速度场覆盖，而是只混入一半，因此视觉上会比 `Blend = 1` 时更克制，保留更多粒子自身的运动趋势。

- 当前层级位于：
  - `/obj/geo1/popnet`

- 当前网络主干仍为：
  - `source_first_input -> popadvectbyvolumes1 -> wire_pops_into_here -> popsolver -> output`
  - `popobject -> popsolver`

- 当前选中的节点是：
  - `popadvectbyvolumes1`
  - 类型：`POP Advect by Volumes`

- 右侧 `Parameters` 页当前可见的关键设置包括：
  - `Activation = 1`
  - `Velocity Source = SOP`
  - `SOP = /obj/geo1/VF`
  - `Field Name = vel`
  - `Velocity Scale = 1`
  - `Advection Type = Update Velocity`
  - `Velocity Blend = 0.5`
  - `Advection Method = Trace Midpoint`
  - `CFL Condition = 1`

- 输出/预览：
  - 左侧视口中，黑色粒子仍围绕蓝色球体形成卷吸状运动
  - 但整体形态比完全强跟随时更松一些，不是所有粒子都被完全拖着走
  - 这和 `Velocity Blend = 0.5` 的半混合状态相对应

- 这一步的作用：
  - 用一个中间值展示 `Advect by Volumes` 的混合强度如何影响粒子最终轨迹
  - 让读者理解：不是只有“完全跟随”或“完全不跟随”两种结果，中间值往往更适合做自然的烟雾粒子过渡
这一张回到了 `geo1` 的 SOP 层，开始强调一个核心点：Houdini 里生成的粒子属性可以继续在几何层被直接加工，然后完整带到后续缓存和 Unreal 流程里。当前新增并选中的就是 `Attribute VOP pointvop1`，它作为 `popnet` 之后的属性处理节点，说明作者已经在准备颜色、透明度或年龄相关的点属性。

- 当前层级位于：
  - `/obj/geo1`

- 当前网络中可见的主要节点包括：
  - `sphere1`
  - `attribnoisevector1`
  - `pyrosource1`
  - `volumerasterizeattributes1`
  - `pyrosolver1`
  - `popnet`
  - `pointvop1`

- 当前可见的连接关系包括：
  - `sphere1 -> attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1 -> pyrosolver1`
  - `sphere1 -> popnet`
  - `popnet -> pointvop1`

- 这说明：
  - 左侧这条链负责生成体积与速度场
  - `popnet` 则承接粒子模拟
  - `pointvop1` 是粒子模拟输出后的属性二次处理节点

- 左侧视口当前只看到一小团白色点状结果，说明此时更关注的是“数据结构与属性继承”，而不是某个复杂的最终视觉效果。

- 右侧参数面板当前选中的是：
  - `Attribute VOP pointvop1`

- 当前可见的外层参数包括：
  - `Group Type = Guess from Group`
  - `Run Over = Points`
  - `Vex Source = Myself`
  - `Force Compile`
  - `Evaluation Node Path`
  - `Export Parameters = *`
  - `Enable Multithreading` 已勾选

- 这一步的作用：
  - 把粒子模拟结果接到一个按点运行的属性处理节点后面
  - 为后续基于年龄、生命周期、颜色、透明度等属性做二次加工，并最终随缓存一起带入 Unreal 做准备
这一张把“粒子属性处理”正式接到了缓存导出节点上。`pointvop1` 后面新增了一个 `Labs Niagara ROP` 节点 `niagara1`，右侧则直接显示了导出帧范围、输出路径和要保留的属性列表。这是本页从 Houdini 粒子过渡到 Unreal Niagara 缓存联动的关键落点。

- 当前层级位于：
  - `/obj/geo1`

- 当前可见的完整主数据流包括：
  - 体积分支：
    - `sphere1 -> attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1 -> pyrosolver1 -> VF`
  - 粒子/缓存分支：
    - `sphere1 -> popnet -> pointvop1 -> niagara1`

- 新增节点：
  - `niagara1`
    - 类型：`Labs Niagara ROP`
    - 作用：把当前粒子数据导出为 Unreal 可读取的 Niagara 缓存文件

- 左侧视口当前显示的是一小团青色点状结果，说明粒子经过 `pointvop1` 后已经带上了颜色/显示相关属性，而不是单纯黑点。

- 右侧当前选中的 `niagara1` 参数页可见关键设置包括：
  - `Frame Range / Time` 模式为：
    - `Render Frame Range`
  - `Start/End/Inc = 1 / 150 / 1`
  - `Create Intermediate Directories` 已勾选
  - `Output Path = $HIP/$OS.hbjson`

- `Attributes` 区域当前可见设置包括：
  - `Number of Renames = 0`
  - `Overwrite Existing Attributes` 选项可见
  - `Keep Attributes` 字段中能读到：
    - `P id time N v life type Cd Alpha age`
  - `Cast Attributes = 2`
  - 下面还有 2 个属性转换条目槽位，但当前未具体填写
  - `Clamp Attributes That Are Outside Type Range` 已勾选

- 这一步的作用：
  - 把粒子系统里最关键的属性明确地挑出来并准备写入缓存
  - 其中 `P / id / time / v / life / age / Cd / Alpha` 这类字段，正是后续在 Unreal Niagara 中继续复用与再加工的核心数据

### 00:13:27-00:18:11 Houdini、粒子、生命周期

- 本段定位：Houdini、粒子、生命周期。
- 知识点：这和缓存时常见的参数状态是一样的 再看输出路径,文件扩展名是HBJSON,确实有点复杂 这部分保持原样即可,最终会输出为一个文件。
- 知识点：接下来,因为用了OS变量,文件名会直接保留这个名称,就用这个名字 然后,这是测试用的,先保存资源,然后点渲染,文件才会出现在HIP路径里。
- 知识点：默认设置不用动,但若要优化,可以删掉不需要的属性,比如法线这类 像生命周期,时间,位置,ID,这些关键属性,千万别删。
- 知识点：法线可以放心去掉,如果你打算在Unreal里继续加工数据,就留着 只要你想在Unreal里二次处理这些数据,就一定要保留 不过PID。
- 知识点：time这些属性,像生命周期这类属性必须保留,不然烘焙好的数据根本没法播放 刚才说的就这些,接下来先渲染一下 再导入Unreal。
- 知识点：engine现在点数不多,烘焙非常快 不过如果点数多到夸张,这个步骤可能要花上十分钟,文件体积也会大幅增加 这样能方便后续处理数据,用来重新生成各种Niagara粒子。
- 知识点：别把缓存烘焙资源用得太重,点数控制得当就行 把数据带过去,重新利用它来生成各种Niagara粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Niagara`、`Houdini`、`粒子`、`生命周期`。

**关键画面：**

这一张继续停留在 `Labs Niagara ROP niagara1` 的导出页，但讲解重点已经明确转到输出文件本身。字幕直接点出扩展名是 `HBJSON`，当前画面也清楚展示了导出范围、输出路径以及保留属性列表，说明这一页主要是在确认“缓存导出文件怎么命名、会带哪些字段”。

- 当前层级位于：
  - `/obj/geo1`

- 当前缓存导出链条仍为：
  - `sphere1 -> popnet -> pointvop1 -> niagara1`

- 当前选中的节点是：
  - `niagara1`
  - 类型：`Labs Niagara ROP`

- 右侧当前 `General` 页能清晰读到的导出设置包括：
  - `Frame Range / Time = Render Frame Range`
  - `Start/End/Inc = 1 / 150 / 1`
  - `Create Intermediate Directories` 已勾选
  - `Output Path = $HIP/$OS.hbjson`

- 这说明：
  - 输出文件会落在当前 `HIP` 目录下
  - 文件名默认直接使用节点名 `$OS`
  - 输出格式是 `hbjson`

- `Attributes` 区域当前还能确认：
  - `Keep Attributes = P id time N v life type Cd Alpha age`
  - `Cast Attributes = 2`
  - `Clamp Attributes That Are Outside Type Range` 已勾选

- 输出/预览：
  - 左侧视口中仍是一小团青色点状粒子
  - 当前画面不是在调整视觉效果，而是在确认缓存文件该如何正确导出

- 这一步的作用：
  - 固定缓存文件的输出路径和扩展名规则
  - 同时提醒读者：导出时必须把位置、ID、时间、速度、生命周期、颜色和透明度这类关键属性一并保留下来
这一张是 `Labs Niagara ROP` 导出前的更清晰检查页。和前一张相比，最明显的变化是导出节点名称已经明确成 `Niagara_Test_01`，而且左下角打开了表格视图，可以直接看到当前点属性表中到底有哪些字段。这张图非常适合用来核对“哪些属性确实存在、哪些属性最终打算保留”。

- 当前层级位于：
  - `/obj/geo1`

- 当前粒子缓存导出链为：
  - `sphere1 -> popnet -> pointvop1 -> Niagara_Test_01`

- 当前选中的节点是：
  - `Niagara_Test_01`
  - 类型：`Labs Niagara ROP`

- 右侧当前导出设置仍能确认：
  - `Frame Range / Time = Render Frame Range`
  - `Start/End/Inc = 1 / 150 / 1`
  - `Create Intermediate Directories` 已勾选
  - `Output Path = $HIP/$OS.hbjson`

- `Keep Attributes` 字段当前清晰可见的内容为：
  - `P id time v life type Cd Alpha age`

- 这里与前一张相比最值得注意的是：
  - 当前列表中没有出现 `N`
  - 说明法线之类非必要字段是可以被剔除的
  - 但 `P / id / time / v / life / age / Cd / Alpha` 这些与播放和外观直接相关的属性仍被保留

- 左下角表格视图当前能直接读到的列名包括：
  - `P[x]`
  - `P[y]`
  - `P[z]`
  - `age`
  - `Alpha`
  - `Cd[r]`
  - 右侧还有更多颜色列，但当前截图中仅部分可见

- 表格中的数据也印证了这些属性已经真实存在于点数据中，而不只是计划导出字段。

- 这一步的作用：
  - 在真正执行渲染导出前，先确认点属性表和 `Keep Attributes` 列表是对齐的
  - 避免把关键播放属性删掉，同时也提醒读者像法线这类字段可以按需要精简掉
这一张已经切到 Unreal Editor，作用是确认 Houdini 缓存导入所需的插件环境是否就绪。当前打开的是 `Plugins` 窗口，搜索词为 `houdini`，结果页里能直接看到 `Houdini Niagara` 和 `SideFX Labs` 两个插件，而且左侧复选框都处于勾选状态。

- 当前界面是 Unreal Editor 的 `Plugins` 面板。
- 顶部搜索栏当前输入关键词：
  - `houdini`

- 搜索结果区域当前可见两个关键插件：
  - `Houdini Niagara`
    - 描述大意：把 Houdini 点云数据导入 UE5，用于驱动 Niagara 粒子系统
    - 版本：`2.6.0`
    - 提供按钮/入口：
      - `Edit`
      - `Package`
      - `Documentation`
      - `Support`
  - `SideFX Labs`
    - 描述大意：提供材质、蓝图及其他依赖，用于增强 Houdini 与 Unreal 之间的工作流
    - 版本：`2.0`
    - 提供按钮/入口：
      - `Edit`
      - `Package`
      - `Documentation`
      - `Support`

- 这两个插件左侧当前都能看到已勾选的启用复选框，说明当前项目环境已经把它们打开了。

- 左侧插件分类栏中还能看到：
  - `ALL PLUGINS = 633`
  - `PROJECT`
  - `INSTALLED`
  - `BUILT-IN`
  - 说明当前是标准插件管理视图，而不是某个临时弹窗

- 这一步的作用：
  - 在真正把 `hbjson` 缓存拖进 Unreal 之前，先确认 `Houdini Niagara` 插件已安装并启用
  - 同时确认 `SideFX Labs` 相关依赖也存在，避免导入后看不到内容或缺少配套资源

### 00:18:11-00:22:55 Houdini、粒子、发射器

- 本段定位：Houdini、粒子、发射器。
- 知识点：我已直接下载并发送了文件 如果需要其他版本,需要带大家去看官网 在软件输入GitHub上的SiteX Houdini Niagara地址,就能找到Niagara插件。
- 知识点：就能看到我发的那个插件的下载页面 选好版本后,想用哪个,就选哪个,点下载就行 之前我已经把下载的文件更新到课程资料里了,您直接下载后手动安装也没问题。
- 知识点：接下来先做个测试 得先把烘焙好的缓存文件导入使用 我没设单独路径,所以文件就直接放在场景文件同级目录里了 测试时,直接拖进去导入一下就行了。
- 知识点：现在通过Array参数,看到数据一条条整齐地排列着 上面能看到属性数量,点的数量,还有总帧数,起始帧和结束帧 总时长4.9667秒,只要确认播放时间对得上就行。
- 知识点：这只是一个用来看看这类数据是怎么生成的参考素材 每生成5000个,数据量大约有63M字节 虽然点数不算少,但光是文件体积就已不小。
- 知识点：用起来难免吃力,如果只是用于创意参考,倒也无妨 从公司角度来说,还是应针对这种制作方式重新搭建专属工作流 接下来我们看看如何将它应用到Niagara粒子系统。
- 知识点：如果在插件文件夹里看不到内容,只需在设置中勾选显示插件内容即可 勾选后就能看到里面有个Houdini Niagara内容。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Niagara`、`Particle`、`Houdini`、`粒子`、`发射器`、`系统`。

**关键画面：**

这一张已经进入 Unreal 场景测试阶段。画面里不是插件设置页，而是把导入后的 Niagara 粒子实例直接放进场景里观察效果，说明缓存文件已经能在真实环境中参与展示。当前可见的是一串白色点状粒子沿峭壁一侧分布，用来做第一轮导入验证。

- 当前界面是 Unreal Editor 主视口，地图标签显示为：
  - `DarkRuinsMegascansSampleT`

- 左侧 `Content Browser` 当前可见课程资源目录：
  - `Course_06`
  - `Course_07`
  - `Course_08`

- 右侧 `Outliner` 显示当前场景位于：
  - `Main (Editor)`
  - `Beach`
  - `Beach_Assemblies`
  - 下方是一批 `StaticMeshActor`

- 场景统计栏当前可见：
  - `9,082 actors (9,082 loaded)`

- 视口中当前能明确看到的效果包括：
  - 沿左侧峭壁区域分布着一串白色小点/小片状粒子
  - 粒子大致沿垂直方向稀疏排布
  - 背景仍是带雾的海岸悬崖环境，说明这不是单独预览窗口，而是直接在真实关卡里查看

- 当前画面里还看不到材质、模块栈或参数面板，说明此刻主要目的只是：
  - 确认缓存导入后能正常出现在 UE 场景中
  - 粒子位置与大致运动形态已可被实际摆放和观察

- 这一步的作用：
  - 把 Houdini 导出的 Niagara 缓存第一次落到 Unreal 真实关卡中验证
  - 为后续继续查看数组数据、属性数量和 Niagara 模块使用方式做铺垫
这一张打开了导入到 Unreal 里的缓存资源详情页，资源标签名为 `Niagara_Test_01*`，右上角明确标注 `Asset Type: HoudiniPointCache`。这页的重点不是看视觉效果，而是核对缓存文件里到底导入了多少属性、覆盖多少帧、总时长是多少，以及原始数据体量有多大。

- 当前资源标签名：
  - `Niagara_Test_01*`

- 右上角资源类型：
  - `Asset Type: HoudiniPointCache`

- `Details` 面板中当前可清晰读到的基础时间信息包括：
  - `First Frame = 1.0`
  - `Last Frame = 150.0`
  - `Min Sample Time = 0.0`
  - `Max Sample Time = 4.966667`

- `Attribute Array` 当前显示：
  - `14 Array Elements`

- 当前可见的属性数组内容依次包括：
  - `id`
  - `Alpha`
  - `v.x`
  - `v.y`
  - `v.z`
  - `Cd.r`
  - `Cd.g`
  - `Cd.b`
  - `life`
  - `P.x`
  - `P.y`
  - `P.z`
  - `age`
  - `time`

- 这组信息说明：
  - 位置、速度、颜色、透明度、生命周期、年龄和时间字段都已成功导入
  - 与 Houdini 侧保留属性的设计基本对齐

- 面板下部当前还能读到：
  - 数据格式：`HBJSON`
  - `Raw Data Uncompressed Size = 64696176`
  - `Raw Data Compression Method = Oodle`

- 这一步的作用：
  - 在 Unreal 里直接验证缓存文件的结构完整性
  - 同时给出一个现实参考：即便点数不算夸张，这类缓存的原始数据量也已经不小，因此后续工作流仍需要控制点数和属性规模
这一张切到了 Unreal 的 Niagara 发射器编辑器，核心是在说明：与其手动从零拼装整套 Houdini 点缓存读取模块，不如复制一份已经验证可用的预设发射器再做调整更稳定。当前画面中作者就在 `HoudiniInterpolate_02` 发射器里检查循环时长，并把持续时间设成了 `4` 秒。

- 当前窗口标签可见：
  - `HoudiniInterpolate_02`
  - `interp_word_02`

- 左侧预览面板当前显示：
  - 少量白色点粒子
  - 状态文本：`7 Current, 13 Max (est.) - [HoudiniInterpolate_02] [Active]`

- 中央 `HoudiniInterpolate_02` 发射器堆栈当前可见模块结构为：
  - `Emitter Spawn`
    - `Init Houdini Point Cache`
  - `Emitter Update`
    - `Emitter State`
    - `Spawn Particles from Houdini Point Cache`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`
  - `Particle Update`
    - `Particle State`
    - `Sample Houdini Point Cache`
    - `Set: PARTICLES Position`
    - `Solve Forces and Velocity`
  - `Render`
    - `Sprite Renderer`

- 右侧当前打开的是 `Emitter State` 详情，能确认的参数包括：
  - `Life Cycle Mode` 在 `System / Self` 之间切换，当前 `Self` 高亮
  - `Inactive Response = Complete (Let Particles Finish then Kill)`
  - `Loop Behavior` 提供 `Infinite / Once / Multiple` 三项，当前 `Infinite` 高亮
  - `Loop Duration = 4.0`
  - `Loop Delay = 0.0`
  - 下方还能看到 `Scalability Mode = System / Self`

- 这一步的作用：
  - 说明 Houdini 点缓存发射器更适合从可用模板复制复用，而不是每次手工重搭
  - 同时把发射器循环时长明确设置为 `4` 秒，让 Niagara 播放周期更贴合导入缓存的时间段

### 00:22:55-00:27:34 Niagara、Initialize Particle、Houdini

- 本段定位：Niagara、Initialize Particle、Houdini。
- 知识点：我自己手动搭建过类似模块,但容易出错 手动搭建时偶尔出错,喊出警告 可能是因为用了旧版的初始化粒子模块。
- 知识点：停用旧模块,改用新创建的初始化粒子模块 现在一共用了4个模块 一个用于初始化Houdini点缓存的模块 一个从点缓存读取数据的模块。
- 知识点：还有一个决定如何生成粒子的模块 一个根据录取数据决定生成方式的模块 最后是一个决定更新方式的模块 总共要用4个模块 其中一个是决定生成方式的模块。
- 知识点：还有这里的位置池来自Houdini的属性位置数据 以作为粒子属性注册到Niagara中。
- 知识点：我们平时在Niagara中还是这么操作的 导入的属性值可直接使用 这是个显着优势 此外 这里的Initialize Particle模块。
- 知识点：也不受生命周期参数影响 就算改成一秒 也不会一秒就消失 因为以直接使用Houdini导入的生命周期数据。
- 知识点：Niagara中的对应参数就不会起作用 有些参数会生效 有些不会 所以我们过去常用的从曲线生成这类方法也要注意这一点 索引值设为归一化年龄时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Niagara`、`Particle`、`Initialize Particle`、`Houdini`、`粒子`、`发射器`、`系统`、`生命周期`。

**关键画面：**

这一张继续停留在 `HoudiniInterpolate_02` 发射器，但讲解焦点已经从循环时长转到“究竟由哪个模块负责按缓存生成粒子”。当前高亮的是 `Spawn Particles from Houdini Point Cache`，右侧参数也直接绑定到一个 Houdini 点缓存资源，说明这一步是在把生成节奏改为由缓存数据驱动，而不是传统的 `Spawn Rate` 或 `Burst`。

- 当前窗口标签仍为：
  - `HoudiniInterpolate_02`
  - `interp_word_02`

- 左侧预览面板当前显示：
  - `7 Current, 13 Max (est.) - [HoudiniInterpolate_02] [Active]`
  - 预览中只有少量白色点粒子，说明当前画面重点仍是模块结构而不是最终表现

- 中央发射器堆栈可确认的模块主干包括：
  - `Emitter Spawn`
    - `Init Houdini Point Cache`
  - `Emitter Update`
    - `Emitter State`
    - `Spawn Particles from Houdini Point Cache`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`
  - `Particle Update`
    - `Particle State`
    - `Sample Houdini Point Cache`
    - `Set: PARTICLES Position`
    - `Solve Forces and Velocity`
  - `Render`
    - `Sprite Renderer`

- 当前选中的模块是：
  - `Spawn Particles from Houdini Point Cache`

- 右侧 `Details` 面板当前能确认的参数包括：
  - `Houdini Point Cache` 已绑定到资源：`interp_word_02`
  - 下方可见 `SpawnGroup = 0`

- 结合本段上下文，这一步强调的是：
  - 粒子生成数量与节奏并不一定继续依赖常规 `Spawn Rate / Burst`
  - 当使用 Houdini 点缓存工作流时，可以直接让缓存中的采样结果决定何时生成粒子

- 这一步的作用：
  - 明确 Houdini 导入方案里“生成粒子”的专用模块位置
  - 为后面继续解释 `Initialize Particle` 为什么不再完全受 Niagara 自带生命周期参数控制做准备
这一张把注意力放到 `Particle Spawn` 阶段的新 `Initialize Particle 001` 模块。口播强调作者以前手动搭建类似模块时容易出错，所以这里改用新的初始化粒子模块；同时也特别提醒，导入 Houdini 缓存后，`Initialize Particle` 面板里能改的参数并不一定都会真正控制结果，因为一部分值会被缓存中的属性覆盖。

- 当前窗口仍为：
  - `HoudiniInterpolate_02`
  - `interp_word_02`

- 左侧预览可见：
  - `7 Current, 13 Max (est.) - [HoudiniInterpolate_02] [Active]`
  - 白色点粒子尺寸比上一张更大，便于观察粒子基础外观

- 中央堆栈当前在 `Particle Spawn` 段能确认：
  - 旧模块仍在，但显示为：
    - `Deprecated Original Initialize Particle`
  - 新模块当前高亮为：
    - `Initialize Particle 001`
  - 其后仍接着：
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`

- 右侧 `Initialize Particle 001` 面板当前可见的参数包括：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 1.0`
  - `Color Mode = Direct Set`
  - `Position Mode = Simulation Position`
  - `Position Offset = 0.0, 0.0, 0.0`
  - `Mass Mode = Unset / (Mass of 1)`
  - `Sprite Size Mode = Unset`
  - `Sprite Rotation Mode = Unset`
  - `Sprite UV Mode = Unset`
  - `Mesh Scale Mode = Unset`
  - `Mesh Renderer Array = Unset`
  - `Ribbon Width Mode = Unset`
  - `Ribbon Facing Mode = Unset`
  - `Ribbon Twist Mode = Unset`

- 左下 `Active Overview` 当前还能看到一批与 Houdini 导入相关的粒子属性，至少包括：
  - `PARTICLES Color`
  - `PARTICLES DistanceTraveled`
  - `PARTICLES [HOUDINI] Alpha`
  - `PARTICLES [HOUDINI] Color`
  - `PARTICLES [HOUDINI] PSIndex`
  - `PARTICLES [HOUDINI] Force`
  - `PARTICLES [HOUDINI] ImpulseX`
  - `PARTICLES [HOUDINI] NID`

- 结合本段讲解，这一步要表达的是：
  - `Initialize Particle` 仍然是 Niagara 中设置寿命、颜色、位置等基础属性的位置
  - 但当这些属性随后被 `Sample Spawned Houdini Point Cache` 或导入属性驱动时，面板里的默认值不一定最终生效
  - 尤其 `Lifetime = 1.0` 这样的本地设置，并不代表粒子一定会在 1 秒后消失

- 这一步的作用：
  - 用新初始化模块替代旧模块，降低手工搭建时的报错风险
  - 同时提醒读者区分“Niagara 默认初始化值”和“Houdini 缓存实际写入值”两套控制来源
这一张把前面的 Houdini 点缓存发射器放进一个更完整的 Niagara System 示例里。当前系统标签是 `HoudiniEventsSimple*`，可见两个并列发射器：左边的 `EmitLocationEvents` 负责产生位置事件，右边的 `SpawnFromHoudiniLocationEvent` 再根据这些事件生成另一组粒子。它对应本段口播里“有些 Niagara 传统做法依然可行，但要注意哪些值来自 Houdini、哪些值来自系统自身”的说明。

- 当前打开的标签包括：
  - `Niagara_Test_01`
  - `HoudiniEventsSimple*`

- 左侧资源缩略图可见当前选中的是：
  - `HoudiniEventsSimple`
  - 类型：`Niagara System`

- 预览窗口当前显示两组粒子计数：
  - `8 Current, 126 Max (est.) - [SpawnFromHoudiniLocationEvent] [Active]`
  - `4 Current, 53 Max (est.) - [EmitLocationEvents] [Active]`

- 视口中当前能看到：
  - 下方一团较亮的白色粒子
  - 上方一小组偏粉色粒子
  - 说明系统里至少存在两组不同来源或不同阶段的粒子表现

- 中央 `System Overview` 当前可见的系统结构为：
  - 左侧系统节点：`HoudiniEventsSimpl...`
  - 中间发射器：`EmitLocationEvents`
  - 右侧发射器：`SpawnFromHoudini...`

- 其中 `EmitLocationEvents` 发射器堆栈当前能确认：
  - `Emitter Spawn`
    - `Init Houdini Point Cache`
  - `Emitter Update`
    - `Emitter State`，当前显示 `Self` 与 `Infinite`
    - `Spawn Particles from Houdini Point Cache`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`
  - `Particle Update`
    - `Particle State`
    - `Sample Houdini Point Cache`
    - `Set: PARTICLES Position`
    - `Solve Forces and Velocity`
    - `Generate Location Event`
  - `Render`
    - `Sprite Renderer`

- 右侧 `SpawnFromHoudiniLocationEvent` 发射器堆栈当前能确认：
  - `Emitter Update`
    - `Emitter Life Cycle`，当前显示 `Self` 与 `Once`
  - `Particle Spawn`
    - `Initialize Particle`
  - `Particle Update`
    - `Update Age`
    - `Event Handler - Source: LocationEvent`
    - `Receive Location Event`
    - `Set: PARTICLES Position`
  - `Render`
    - `Sprite Renderer`

- 底部时间轴当前可见两条轨道：
  - `EmitLocationEvents`
  - `SpawnFromHoudiniLocationEvent`
  - 播放头位于约 `0.27` 秒附近

- 这一步的作用：
  - 展示 Houdini 点缓存不仅能直接驱动单个发射器，还能作为上游位置事件来源继续喂给其他 Niagara 发射器
  - 同时提醒读者：当系统里混入事件链和二次生成逻辑后，生命周期、位置与外观的控制来源会更加分散，必须分清是缓存属性、事件输入还是 Niagara 自身模块在起作用

### 00:27:34-00:30:53 Houdini、粒子、生命周期

- 本段定位：Houdini、粒子、生命周期。
- 知识点：后面的是通过Generate Location Neonet 生成点的纯Diagra粒子 所以这里做个示例 就是想说明这种用法也是可行的。
- 知识点：我们单独注册了用户参数 这里所有参数都是用户参数 第二个先关掉 设为5S 我们来试试把烘焙的头发值加进去 先放着,播放一下看看效果 头发值可以直接用。
- 知识点：生命周期数值虽然不生效 但这个值本身能正常起作用 所以从5D粒里取到P4K值 再在这里相乘也可以 也可以这么灵活用 我们还拿到了颜色值。
- 知识点：来对比一下 搜一下Houdini 把它的透明度值验证效果 确实能清楚看到透明度是慢慢浮现出来的 来试试把这个颜色值加进去。
- 知识点：之前设置的渐变颜色现在也原样导入了 这类资源可以这么理解 跟着这个流程操作一遍 看着都好 所以这类Niagara缓存的优势。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Niagara`、`Houdini`、`粒子`、`生命周期`、`颜色`、`透明度`、`用户参数`。

**关键画面：**

这一张继续展示 `HoudiniEventsSimple` 系统，但焦点已经落到上游发射器 `EmitLocationEvents` 的 `Generate Location Event` 模块。作者在这里不是单纯让每个粒子无条件抛事件，而是给事件生成加了一层按粒子年龄筛选的条件，用来控制哪些粒子会被下游的 `SpawnFromHoudiniLocationEvent` 接收并再次生成。

- 当前系统标签为：
  - `HoudiniEventsSimple*`

- 左侧预览窗口当前显示两组粒子计数：
  - `15 Current, 126 Max (est.) - [SpawnFromHoudiniLocationEvent] [Active]`
  - `7 Current, 53 Max (est.) - [EmitLocationEvents] [Active]`

- 画面中当前能看到：
  - 下方是一组较大的白色粒子
  - 上方是一组偏粉色的小粒子
  - 说明当前系统正在同时展示事件源粒子与事件生成后的另一组粒子

- 中央 `System Overview` 可确认的两个发射器仍为：
  - `EmitLocationEvents`
  - `SpawnFromHoudiniLo...`

- 当前选中的上游发射器 `EmitLocationEvents` 模块主干可见：
  - `Emitter Spawn`
    - `Init Houdini Point Cache`
  - `Emitter Update`
    - `Emitter State`，当前显示 `Self` 与 `Infinite`
    - `Spawn Particles from Houdini Point Cache`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`
  - `Particle Update`
    - `Particle State`
    - `Sample Houdini Point Cache`
    - `Set: PARTICLES Position`
    - `Solve Forces and Velocity`
    - `Generate Location Event`
  - `Render`
    - `Sprite Renderer`

- 右侧 `Generate Location Event` 详情当前能确认的参数包括：
  - `Event Type = Every Frame`
  - `Event Generation Enabled = Set Bool by Float Comparison`
  - `A = 0.02`
  - `B = PARTICLES NormalizedAge`
  - `Comparison Type = A Greater Than B`
  - 下方还能看到：
    - `Event Probability = 0.5`
    - `Delay Before S... = 0.5`

- 这一步的作用：
  - 不是让缓存粒子一律转成事件，而是先按 `NormalizedAge` 做一次条件筛选
  - 这样下游接收事件的粒子生成时机与数量就能被更细致地控制，而不只是机械地复制一份 Houdini 粒子
这一张仍在 `HoudiniEventsSimple` 系统里，但当前选中的模块已经变成 `EmitLocationEvents` 发射器中的 `Scale Color`。这一步的关键不是调 RGB 颜色，而是把 Houdini 缓存里带进来的 `Alpha` 属性直接接到 Niagara 粒子的透明度缩放上，验证导入属性值可以被系统内模块继续复用。

- 当前系统标签仍为：
  - `HoudiniEventsSimple*`

- 预览窗口当前处于：
  - `Compiling...`
  - 说明作者刚改完模块参数，系统正在重新编译，因此这一帧没有稳定的粒子预览结果

- 中央 `EmitLocationEvents` 发射器堆栈当前可见：
  - `Emitter Spawn`
    - `Init Houdini Point Cache`
  - `Emitter Update`
    - `Emitter State`
    - `Spawn Particles from Houdini Point Cache`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Sample Spawned Houdini Point Cache`
    - `Set: PARTICLES Position`
  - `Particle Update`
    - `Particle State`
    - `Sample Houdini Point Cache`
    - `Set: PARTICLES Position`
    - `Solve Forces and Velocity`
    - `Generate Location Event`
    - `Scale Color`
  - `Render`
    - `Sprite Renderer`

- 右侧 `Scale Color` 详情当前能确认的参数包括：
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = 1.0, 1.0, 1.0`
  - `Scale Alpha = PARTICLES [HOUDINI] Alpha`

- 右侧同时还能看到：
  - 当前选中的对象标头为 `EmitLocationEvents`
  - 下方副标题为 `SingleFrameEvent`

- 结合本段上下文，这一步要表达的是：
  - 粒子的颜色/透明度不必完全依赖 Niagara 内部手工曲线
  - Houdini 导入的 `Alpha` 值可以直接拿来驱动 UE 侧粒子的透明度缩放
  - 因而即使生命周期参数本身未必按传统方式生效，缓存里的属性值仍然可以继续参与材质或外观控制

- 这一步的作用：
  - 验证 Houdini 传入的透明度字段在 Niagara 中可被直接重用
  - 给后续把导入属性继续传到材质、用户参数或其他外观模块提供一个明确示例
这一张仍然选中 `EmitLocationEvents` 发射器的 `Scale Color`，但已经能看到完整预览结果：Houdini 导入的颜色和透明度同时接到 Niagara 粒子上后，粒子云恢复成明显的青蓝到紫色渐变，而不是前面只看参数、不看结果的编译状态。它对应口播里“生命周期数值本身未必按老方法起作用，但拿到的颜色值、Alpha 值仍然可以灵活复用”的结论。

- 当前系统仍为：
  - `HoudiniEventsSimple*`

- 左侧预览窗口当前粒子统计明确显示：
  - `0 Current, 126 Max (est.) - [SpawnFromHoudiniLocationEvent] [Disabled]`
  - `9952 Current, 10201 Max (est.) - [EmitLocationEvents] [Active]`

- 这说明当前画面中：
  - 下游事件生成发射器被禁用
  - 只保留上游 `EmitLocationEvents` 发射器本身在工作
  - 因此预览中的大体量点云可以直接拿来观察颜色与透明度映射结果

- 预览中当前能看到的效果包括：
  - 大量细小点粒子形成一条拉长的流线状云团
  - 上部主要是偏亮的青蓝色
  - 下部和尾部过渡到紫色/暗紫色
  - 整体透明度并不一致，说明 `Alpha` 也参与了显示控制

- 中央 `EmitLocationEvents` 发射器堆栈当前仍可见：
  - `Generate Location Event`
  - `Scale Color`
  - `Sprite Renderer`

- 右侧 `Scale Color` 参数当前能确认：
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = PARTICLES [HOUDINI] Color`
  - `Scale Alpha = PARTICLES [HOUDINI] Alpha`

- 底部时间轴当前播放头位于：
  - 约 `5.03` 秒

- 这一步的作用：
  - 直接验证 Houdini 缓存里的 `Color` 与 `Alpha` 两类外观属性都可以在 Niagara 中被原样复用
  - 也说明即使不依赖 Niagara 传统曲线去重新配色，导入缓存自带的颜色数据依然足以形成最终可见的层次变化

## 补充视觉证据

### S01 00:02:30

这张补充图回到 Houdini 前段的体积准备流程，作用是把“先做简单粒子运动，再转成体积并交给后续求解”的节点链补充得更明确。当前选中的是 `volumerasterizeattributes1`，右侧参数也直接展示了它把哪些属性写进体积网格，因此这张图可以作为 `S01` 段里“把数据转成体积，只保留密度、温度和速度，再进入后续喷烟模拟”的直观证据。

- 当前层级位于：
  - `/obj/geo1`

- 中央网络当前可见的节点链为：
  - `attribnoisevector1`
  - `pyrosource1`
  - `volumerasterizeattributes1`

- 当前可确认的连线关系为：
  - `attribnoisevector1 -> pyrosource1 -> volumerasterizeattributes1`

- 节点含义可按当前画面理解为：
  - `attribnoisevector1`
    - 上游为粒子或源数据提供噪声向量/速度扰动
  - `pyrosource1`
    - 把上游结果整理成适合火焰/烟雾求解使用的源数据
  - `volumerasterizeattributes1`
    - 把点或粒子属性栅格化写入体积字段，供后续体积求解器读取

- 左侧视口当前显示：
  - 一个包围盒中的淡白色烟雾体积
  - 说明当前节点输出已经不只是离散点，而是可用于体积模拟的雾状字段结果

- 右侧 `volumerasterizeattributes1` 参数面板当前能确认的设置包括：
  - `Attributes = density temperature v`
  - `Visible Volumes = *`
  - `Filter = Gaussian`
  - `Voxel Size = 0.1`
  - `Particle Scale = 1`
  - `Minimum Filter Size = 0.75`
  - `Coverage Attribute = density`
  - `Coverage Scale = 1`
  - `Normalize by Clamped Coverage` 已勾选
  - `Attribute Rules = 0`

- 这一步的作用：
  - 明确后续体积模拟并不是直接吃原始粒子，而是先把关键属性栅格化为体积字段
  - 其中当前明确保留的核心字段就是：
    - `density`
    - `temperature`
    - `v`
  - 这也和本页最前面关于“先做简单烟雾和速度场，再准备烘焙缓存”的讲解相互对应

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


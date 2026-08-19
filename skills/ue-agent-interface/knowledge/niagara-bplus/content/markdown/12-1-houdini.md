# 12-1-Houdini爆炸模拟设置

# 12-1-Houdini爆炸模拟设置

## 关键术语

- `Emitter`、`GPU`、`CPU`、`UV`、`Houdini`、`渲染器`、`碰撞`、`生命周期`、`速度`、`烟雾`、`缓存`、`Niagara`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Particle`

## 分段知识

### 00:00:05-00:02:56 CPU、火焰、缓存

- 本段定位：CPU、火焰、缓存。
- 知识点：你好,这里是第12讲,这次我们来看看先制作第三个视力的模拟资源。
- 知识点：这次会和之前视力有些不同,然后模拟场和形状等选项会有点不一样。
- 知识点：我们就用预先做好的预设中的火球,适当修改一下再做。
- 知识点：这里用的火球源也,我回来一次,一起看看这个选项。
- 知识点：用CPU看看是什么形式的预设。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`CPU`、`火焰`。

**关键画面：**

本图是本页教程在 Houdini 中的起始环境。画面顶部标题栏显示当前文件为 `untitled.hip`，软件版本为 `Houdini Indie Limited-Commercial 20.5.445 - Py3.11`。当前工作空间位于 `/obj` 层级，中间网络视图为空白，提示 `Empty Network, Press Tab to Add Nodes`，右侧参数面板也显示未选中任何操作器。

左侧是透视视口的默认网格场景，底部时间轴范围约为 `1-240` 帧。结合正文“先制作第三个示例的模拟资源”“用 CPU 看看是什么形式的预设”，这一帧的作用是确认教程从一个空的 Houdini `obj` 网络开始，准备导入或搭建新的爆炸/火球模拟资源，而不是在已有复杂网络上直接修改。
本图展示教程采用的 Houdini 火球模拟预设链，当前位于 `/obj/geo1`。中间网络视图从上到下依次为：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `pyrolook_fireball`
- `RENDER_Simple_Fireball`

当前显示输出的是 `pyrolook_fireball`，节点下方标记为 `Viewing Output 1`，左侧透视视口中能看到一个已经成形的火球体积。右侧参数面板当前选中的是 `Pyro Solver pyrosolver_fireball`，可确认的关键参数包括：
- `Voxel Size = 0.15`
- `Time Scale = 1`
- `Simulation Type = Minimal OpenCL`
- `Max Substeps = 2`

这条链的用途可以按顺序理解为：`pyroburstsource` 生成爆发源，`volumerasterizeattributes1` 将属性体积化，`pyrosolver_fireball` 负责火焰/烟雾的体积模拟，`pyrolook_fireball` 负责最终 Pyro Bake Volume 的外观调整，最后通过 `RENDER_Simple_Fireball` 作为输出终点。教程在这里强调的是“先从现成火球预设出发”，便于后续逐步删减或修改其中与目标效果不符的部分。
本图聚焦在火球预设链的源头节点 `pyroburstsource`。当前网络结构为：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `RENDER_Simple_Fireball`

右侧参数面板打开的是 `Pyro Burst Source pyroburstsource`，当前位于 `Burst Shape` 页签。可确认的参数如下：
- `Burst Type = Explosion`
- `Shape Offset = 0`
- `Initial Size = 1`
- `Direction = (0, 1, 0)`
- `Spread Angle = 90`
- `Roundness = 0.5`
- `Number of Trailings = 250`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.25`

这一组参数说明该预设不是单纯的球形火球，而是带有朝指定方向扩散、并附带大量 trailing 细节的爆发源。正文提到“可以控制的选项有形状、源的形状、源的动画”，对应的就是这里：先在 `pyroburstsource` 中定义爆发的基本朝向、扩散角、圆润度与拖尾数量，再让后续体积化与求解器去生成真正的火焰/烟雾体积。

### 00:03:02-00:05:47 速度

- 本段定位：速度。
- 知识点：这个属性要怎么去掉,速度也要一起去掉。
- 知识点：可能最常看的选项是这里的shape部分。
- 知识点：我们从这个预设开始的原因,是为了以最容易查看的方式展示如何使用这些资源。
- 知识点：并且准确指导这些字段使用和这些部分。
- 知识点：从这里基本开始制作想要的shape,一点点地改变这些选项,观察变化值的差异。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`。

**关键画面：**

本图继续查看 `pyroburstsource`，但右侧已经切换到 `Burst Animation` 页签，用来控制爆发源随时间展开的方式。当前可确认的时间与动画参数为：
- `Start Frame = 3`
- `Frame Duration = 10`
- `Overall Expansion = 3`
- `Directional Translation = 0`

这说明该爆发源会在第 `3` 帧启动，并在大约 `10` 帧的时间跨度内完成主要的扩张动画；`Overall Expansion = 3` 表示整体会有较明显的放大/扩散过程，而 `Directional Translation = 0` 则说明此阶段不额外做沿某一方向的整体平移推进。结合正文“这些部分也可以看作是可控的部分”“速度也要一起去掉”，这一页的重点是在预设级别先把源的时序和扩散过程调顺，再决定后面是否删减或弱化速度相关效果。
本图仍在 `pyroburstsource` 的 `Burst Animation` 页签，参数保持为 `Start Frame = 3`、`Frame Duration = 10`、`Overall Expansion = 3`、`Directional Translation = 0`。与上一张不同的是，底部时间轴当前停在第 `15` 帧附近，而左侧透视视口已经几乎看不到源体积，只剩默认网格场景。

这一现象说明该爆发源的动画构成是一个时长较短的“出现后迅速扩张，再逐渐消退”的事件，而不是持续不断发射的稳定源。结合字幕“可以看作是逐渐消失的构成”，可以把这张图理解为对 `Burst Animation` 的结果验证：当开始帧和持续帧数确定后，超过主要扩张阶段的后续帧里，源形状应自然淡出，为后面的烟雾与火焰体积留出衰减空间。
本图把 `pyroburstsource` 的爆发源分布直接显示在视口里。左侧透视窗口中能看到大量蓝黄两色的点向外喷散，整体形成一个带明显方向性的放射状体积；这与右侧 `Burst Shape` 页签中的参数相对应：`Burst Type = Explosion`、`Direction = (0, 1, 0)`、`Spread Angle = 90`、`Roundness = 0.5`，并且还启用了较多的 trailing（`Number of Trailings = 250`、`Trailing Separation = 0.1`、`Trailing Length = 1`、`Trailing Thickness = 0.25`）。

时间轴当前在第 `6` 帧附近，正处于爆发源已经展开、但尚未完全消失的阶段，因此最容易直接判断“速度感”和“形状感”是否合适。结合正文“从这里基本开始制作想要的 shape，一点点改变这些选项，观察变化值的差异”，这一帧的用途就是让操作者先通过点云分布直观看懂源的扩散角、拖尾密度和整体朝向，再决定后续是否删除不需要的速度成分或继续调整源的形态。

### 00:05:50-00:10:28 烟雾

- 本段定位：烟雾。
- 知识点：直接是最大尺寸,可以看作是倍数。
- 知识点：这个我调到1.5左右。
- 知识点：方向按始量方向来。
- 知识点：爆炸的方向会改变。
- 知识点：扩散角度是保持一定角度。
- 知识点：还有所谓的Trialing Number。
- 知识点：可能是因为现在有厚度感,只是现在分布。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`烟雾`、`冲击波`。

**关键画面：**

本图继续在 `pyroburstsource` 的 `Burst Shape` 页签上调整烟雾源形态。与前一批不同，这里把 `Initial Size` 明确调大到了 `1.5`；其余当前可见参数仍为：
- `Burst Type = Explosion`
- `Shape Offset = 0`
- `Direction = (0, 1, 0)`
- `Spread Angle = 90`
- `Roundness = 0.5`
- `Number of Trailings = 250`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.25`

左侧透视视口中可见的蓝黄点云分布因此变得更宽、更厚，整体爆发体积比前面明显放大。结合字幕“这个我调到 1.5 左右”，这一帧的核心意思是：为了让后续烟雾模拟更有厚度感，先在爆发源级别把初始尺寸增大，而不是只依赖后面的求解器去把体积膨胀出来。
本图继续在 `pyroburstsource` 的 `Burst Shape` 中细化烟雾源分布。当前可确认的关键参数已经变为：
- `Initial Size = 1.5`
- `Direction = (0, 1, 0)`
- `Spread Angle = 65`
- `Roundness = 0.5`
- `Number of Trailings = 35`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.108`

与上一张相比，这里明显缩小了扩散角，并把 trailing 数量从很高的值大幅减少到 `35`，同时把 `Trailing Thickness` 压细到约 `0.108`。左侧点云因此从厚重团块变成了更稀疏、更有方向感的尖刺状放射结构。结合字幕“Thickness 可以理解为粗细”，这一帧表达的是：为了让烟雾源不要过分臃肿，作者开始同时控制扩散角度、拖尾数量和拖尾粗细，让源分布更接近可控的冲击形态。
本图切换到了单独的轨迹节点 `pyrotrailpath1`，节点下方显示当前查看的是 `Viewing Output -1: Animation_Guide`。左侧视口里可见一组从地面喷出后沿抛物线向外展开的黄红色轨迹线，说明这里展示的不是最终体积烟雾，而是用于指导爆发路径和速度感的动画引导线。

右侧参数面板当前位于 `Source` 页签，可确认的参数包括：
- `Velocity Scale = 33`
- `Drag = 1`
- `Mass = 1`
- `Gravity = (0, -9.80665, 0)`
- `FPS = 24`
- `Substeps = 1`
- `Start Frame = 1`
- `Trail Duration = 72`
- `Speed Scale = 1`

这套设置表示轨迹会在标准重力下从第 `1` 帧开始抛射，并在约 `72` 帧的持续时间内保留完整路径。结合正文“方向按始量方向来”“爆炸的方向会改变”，可以把这张图理解为：先用 `pyrotrailpath1` 生成一组可视化轨迹，快速判断爆发的主方向、弧线长度和速度感，再决定这些轨迹是否值得继续参与后续火焰或烟雾源的构建。

### 00:10:28-00:15:13 火焰

- 本段定位：火焰。
- 知识点：这可以看作是一套轨迹。
- 知识点：不过这个我们可能用不太到。
- 知识点：看起来不太适合在虚幻引擎中。
- 知识点：使用的原文件类型。
- 知识点：还有像冲击波这种情况。
- 知识点：这样以原型爆发的原文件。
- 知识点：本身作为一个模拟宏背后使用。
- 核对对象：`火焰`、`冲击波`。

**关键画面：**

本图展示把轨迹引导线转成实际源形状的节点 `pyrotrailsource1`。当前网络中 `pyrotrailpath1` 位于其上游，并标注 `Viewing Output -1: Animation_Guide`；`pyrotrailsource1` 被选中后，左侧视口里只剩少量细小白色段，说明这里展示的是由轨迹生成出的源体片段，而不是完整的彩色引导线。

右侧参数面板当前位于 `Trail Shape` 页签，可确认的参数为：
- `Point Separation = 0.1`
- `Length = 1`
- `Radius = 0.1`
- `Radius Along Trailing` 使用一条从左高到右低的线性衰减曲线，表示沿轨迹向后逐渐收尖
- `Enable Trailing Noise` 未启用

这说明 `pyrotrailsource1` 的作用是把上一张的动画轨迹“实体化”为一套沿路径延展、尾端逐渐变细的火焰/烟雾源。结合字幕“这可以看作是一套轨迹”，可将此节点理解为：先用 `pyrotrailpath1` 决定运动路线，再用 `pyrotrailsource1` 指定每条轨迹沿线的厚度、长度和采样密度，为后续体积模拟提供可控的细长源体。
本图再次回到 `pyroburstsource` 的 `Burst Shape` 页面，用来对比不同源设置在实际时间点上的可见结果。当前可见参数为：
- `Initial Size = 1.5`
- `Direction = (0, 1, 0)`
- `Spread Angle = 65`
- `Roundness = 0.5`
- `Number of Trailings = 35`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.25`

左侧透视视口在当前第 `5` 帧附近几乎看不到有效体积，只剩默认网格背景。和前面显示密集点云或轨迹线的帧相比，这一画面强调的是：即使源形状参数本身成立，某些轨迹式或冲击波式源在特定时间点也可能难以直接转成虚幻里好用的爆发素材。结合正文“不过这个我们可能用不太到”“看起来不太适合在虚幻引擎中”，这一帧可作为判断依据：如果源在关键时刻的可读性不足，就不应把这套轨迹型构成当作主要的 UE 爆炸火焰方案。
本图切换到 `Pyro Solver pyrosolver_fireball` 的 `Setup` 页面，用来说明原始模拟文件是如何把上游体积字段映射进求解器的。右侧 `Source Volumes` 面板可确认 `Number of Sources = 5`，并且至少能完整读到前四项：
- `Source 1: density`
  - `Operation = Maximum`
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
- `Source 3: flame`
  - `Operation = Maximum`
  - `Source Volume = burn`
  - `Target Field = flame`
  - `Source Scale = 1`
- `Source 4: divergence`
  - `Operation = Add`
  - `Source Volume = burn`
  - `Target Field = divergence`
  - `Source Scale = 10`

下方还能确认存在 `Source 5: vel`，但其详细参数在截图下沿之外，没有完整露出。这一页的关键意思是：原始火球预设并不是单一把一个体积字段塞进求解器，而是同时把 `density`、`temperature`、`burn/flame`、`divergence`、`vel` 等多个字段按不同操作模式映射进去。结合字幕“源文件是以这种方式配置的”，这张图可以作为后续精简预设的重要参照，用来判断哪些字段在迁移到 UE 使用的资源时值得保留，哪些轨迹/冲击波相关配置可以删减。

### 00:15:13-00:20:09 烟雾、火焰、缓存

- 本段定位：烟雾、火焰、缓存。
- 知识点：Framer做火焰时用过。
- 知识点：但Divergence是第一次建的那个字段。
- 知识点：这两个选项值的区别。
- 知识点：用眼睛一起看一次应该也不错。
- 知识点：从保存开始做一次。
- 知识点：我给它起名叫Explosion。
- 知识点：0.15看起来有点大。
- 核对对象：`烟雾`、`火焰`。

**关键画面：**

本图继续查看 `Pyro Solver pyrosolver_fireball` 的 `Source Volumes` 配置，并把上一批未完全显示的 `Source 5: vel` 补全了。当前 `Number of Sources = 5`，五个源字段的映射关系为：
- `Source 1: density`
  - `Operation = Maximum`
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
- `Source 3: flame`
  - `Operation = Maximum`
  - `Source Volume = burn`
  - `Target Field = flame`
  - `Source Scale = 1`
- `Source 4: divergence`
  - `Operation = Add`
  - `Source Volume = burn`
  - `Target Field = divergence`
  - `Source Scale = 10`
- `Source 5: vel`
  - `Operation = Pull`
  - `Source Volume = v`
  - `Target Field = vel`
  - `Source Scale = 5`
  - `Acceleration Strength = 1`
  - `Deceleration Strength = 1`

这一页把原始预设的“烟雾、火焰、速度”三类核心输入关系讲清楚了：`density` 负责质量，`temperature` 和 `flame` 负责热量与燃烧表现，`divergence` 决定膨胀趋势，`vel` 决定速度场如何被带入求解器。结合字幕里对 `divergence` 的强调，这张图可作为后续调整爆炸素材时的字段基准，用来判断 UE 侧真正需要继承哪些体积信息。
本图展示缓存后的爆炸结果外观，当前选中的是 `Pyro Bake Volume pyrolook_fireball`，并且正在查看 `Smoke` 页签。中间网络可见当前缓存文件名为 `Ex_03_Explosion_01.filecache1_v1.$F4.bgeo.sc`，说明作者已经把这一版模拟以 `Explosion` 命名并进入缓存/外观调整阶段。

右侧 `Smoke` 页中当前可见参数为：
- `Assign Material = matnet/Pyro_Shader`
- `Density Scale = 75`
- `Smoke Color = (0.5, 0.4, 0.3)`，模式为 `Constant`
- `Shadow Color = (1, 1, 1)`
- `Shadow Density = 1`
- `Ambient Shadow Scale = 0.5`

左侧视口里，爆炸体积已经呈现出带暖棕色调的厚烟团块，内部夹杂较亮的热区，字幕也明确说“这种爆炸感被制造出来了”。因此这一帧的作用是说明：在源字段和缓存完成后，`pyrolook_fireball` 会通过烟雾密度、烟色与阴影参数把体积结果收敛成更接近最终资源的外观，而不是继续改动求解器本身。
本图切换到 `File Cache filecache1`，用于正式保存这一版爆炸模拟。右侧参数面板可确认：
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用
- `Base Name = Ex_03_Explosion_01.filecache1`
- 输出扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用
- `Start/End = 1 到 70`
- `Substeps = 1`

中间网络视图下方同样显示缓存结果名为 `Ex_03_Explosion_01.filecache1_v2.$F4.bgeo.sc`。这说明作者在比较不同烟雾膨胀状态后，决定把当前版本另存为第二版缓存，并且只保留 `1-70` 帧的有效模拟区间。结合字幕“烟雾的膨胀也和刚才不同”，这一帧的意义在于：爆炸资源的版本管理不只是重命名文件，还包括按合适帧长截取有效模拟段，避免把过长、无用的尾段一并带入后续流程。

### 00:20:09-00:25:07 Emitter、GPU、CPU

- 本段定位：Emitter、GPU、CPU。
- 知识点：密度和速度的作用。
- 知识点：这次为了让这个框架的生命周期值。
- 知识点：生命周期值延长一些。
- 知识点：以及额外产生更强Temperator温度的部分。
- 知识点：因为首先要在64帧内调整资源形态。
- 知识点：刚才已经缩短了生命周期。
- 知识点：火焰的速度现在消失的更快了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Emitter`、`GPU`、`CPU`、`生命周期`、`速度`、`烟雾`、`火焰`。

**关键画面：**

本图再次停留在 `Pyro Solver pyrosolver_fireball` 的 `Source Volumes` 页面，但这次左侧视口已经显示出一个较完整的中段烟团结果。当前时间轴位于第 `43` 帧附近，体积看起来是一团偏灰棕色、下垂感较明显的烟云，说明此时正在用中后段帧检查字段配置是否真的支撑了可用的爆炸外观。

右侧仍然能看到完整的五组源映射：`density -> density`、`temperature -> temperature`、`burn -> flame`、`burn -> divergence`、`v -> vel`。其中 `flame` 与 `temperature` 段仍然保持启用，字幕也明确指出“火焰是必不可少的领域”。因此这一帧的重点不是新增参数，而是验证结构判断：即便最终外观以烟雾为主，`flame` 与热量相关字段依旧是支撑爆炸内部能量感、推动早期膨胀与消散节奏的重要输入，不能简单从源映射里删掉。
本图回到 `File Cache filecache1` 的缓存结果对比，当前显示的是 `Ex_03_Explosion_01.filecache1_v1.$F4.bgeo.sc`。右侧参数仍然表明它是一个时间依赖缓存，保存在 `$HIP/geo`，`Evaluate As = Frame Range`，范围是 `1-70` 帧；当前时间轴停在第 `62` 帧附近。

左侧视口中的 `v1` 版本爆炸在这个时间点呈现出更明显的横向摊散和下垂烟尾：顶部团块很大，边缘更开，底部垂下的烟柱也更长。字幕同样指出“1号版本本烟散得比以前明显多了”。因此这张图的核心意义是版本对比验收：即使缓存范围和基础流程一致，不同版本的源场或字段权重会直接改变晚期烟雾的扩散程度；如果目标是更收敛、更利于 UE 资源使用的爆炸形态，就不能只看早期火焰感，还要在后段帧比较烟雾是否散得过头。
本图继续查看 `filecache1` 的 `v2` 版本缓存过程。右侧参数仍显示：
- `Base Name = Ex_03_Explosion_01.filecache1`
- `Version = 2`
- `Base Folder = $HIP/geo`
- `Evaluate As = Frame Range`
- `Start/End = 1 到 70`
- `Simulation` 启用

与上一张不同的是，画面中央弹出了 Houdini 的运行进度窗口，内容显示正在执行 `render frame 13 (13 of 70)`，底部状态为 `Solving: GAS_AdvectField2`。左下状态栏也能看到当前是在 `DOP Cook` 过程中按子步推进模拟。字幕明确提到“缓存本身现在并没有利用 GPU”，因此这一帧的重点是运行方式核对：即便前面某些求解器设置里出现 OpenCL 选项，当前这次缓存/求解过程仍表现为常规的逐帧求解与缓存写出，需要按 CPU 风格的耗时和迭代节奏来评估制作成本。

左侧视口中的 `v2` 结果在当前帧呈现为几团分离得更明显的烟柱与尾迹，说明作者此时不仅在对比外观版本，也在观察缓存阶段的实际求解行为是否能稳定产出目标形态。对复现而言，这一帧可以作为流程验收点：确认缓存版本、帧范围和运行方式之后，再决定是否继续回头调整生命周期、温度或速度字段。

### 00:25:07-00:30:00 GPU、CPU、渲染器

- 本段定位：GPU、CPU、渲染器。
- 知识点：可以认为它的作用很大。
- 知识点：最近开始用Karma渲染器代替咒语。
- 知识点：现在这个趋势是更多的利用Karma这个渲染器。
- 知识点：其中有个Karma选项叫XU渲染器。
- 知识点：可以借用一点GPU的力量。
- 知识点：和CPU一起同时进行渲染。
- 知识点：似乎有些变化的趋势。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`CPU`、`渲染器`、`速度`、`碰撞`、`火焰`。

**关键画面：**

本图继续显示 `filecache1` 的 `v2` 缓存过程。右侧参数面板仍保持：
- `Base Name = Ex_03_Explosion_01.filecache1`
- `Version = 2`
- `Base Folder = $HIP/geo`
- `Evaluate As = Frame Range`
- `Start/End = 1 到 70`
- `Simulation` 启用

中央的 `Interrupt` 进度窗口显示当前正在执行 `render frame 31 (31 of 70)`，状态为 `Solving: GAS_FieldVex`。底部状态栏还能看到这是 `DOP Cook` 过程中的逐帧求解。左侧视口中，爆炸体积仍处于中后期分散状态，说明这一步不是离线最终渲染，而是在缓存阶段持续求解烟雾/火焰场。

结合字幕“现在趋势是更多地利用 Karma 渲染器”，这一帧的作用是做一个流程分界说明：当前看到的仍是模拟缓存本身的 CPU 风格求解过程，而不是 Karma 或 GPU 加速渲染的结果。也就是说，教程在这里先确认模拟端的耗时与表现，再转向讨论后续在渲染端如何借助新的渲染器工作流。
本图切回 `Pyro Solver pyrosolver_fireball` 的参数细调页面，当前右侧能看到多个与火焰寿命、消散和发射相关的模块，同时左侧视口展示的是一个强烈发光、横向拉开的火焰团。说明这里讨论的重点是：在保留爆炸整体能量感的前提下，再微调模拟内部字段，让火焰消失得更快、结构更适合后续资源使用。

当前可确认的参数块如下：
- `Dissipation`
  - `Dissipation = 0.25`
  - `Clamp Below = 0.005`
  - `Use Control Field` 启用，`Control Field = temperature`
  - `Control Range = 0 到 1`
  - `Remap Control Field` 启用，控制曲线为从高到低的线性衰减
- `Emit From Flame`
  - 第一组：`Operation = Maximum`，`Emission Scale = 1`，`Flame Range = 0.1 到 0.75`，`Remap Flame Range` 启用，曲线为中段抬高的钟形分布
- `Temperature`
  - `Diffusion = 0`
  - `Cooling Rate = 0.5`
- 第二组 `Emit From Flame`
  - `Operation = Add`
  - `Emission Scale = 0.1`
  - `Flame Range = 0.6 到 1`
- `Flame`
  - `Flame Lifespan = 2`

这组设置表明作者正在通过 `temperature` 控制 dissipation，并分别用两段 `Emit From Flame` 区间去塑造不同强度的火焰发射贡献。结合正文“生命周期值延长一些”“火焰的速度现在消失得更快了”，可把这张图理解为：不是简单统一拉长或缩短火焰，而是把不同 flame 区间的发射强度、温度冷却和消散速率拆开微调，以在限定帧数内获得更利于缓存和后续渲染的爆炸形态。
本图仍然处于 `filecache1` 的 `v2` 缓存求解过程中。右侧参数没有变化，仍是 `Version = 2`、`Frame Range = 1-70` 的时间依赖缓存；中央 `Interrupt` 窗口显示当前正在执行 `render frame 16 (16 of 70)`，状态为 `Solving: GAS_AdvectField2`。左下状态栏同样可见 `DOP Cook` 与子步推进信息，说明这一步依旧是模拟求解而不是最终离线渲染。

与前一张不同的是，左侧视口中的火焰体积异常明亮，几乎整团爆炸都被高亮白色覆盖，只在尾部保留少量结构细节。字幕也明确指出“模拟的数值有点不正常”。因此这张图应该被理解为异常告警帧：当缓存过程中的温度、火焰或相关发射参数调得过强时，体积会失去正常层次，出现过曝式的亮团结果。对复现而言，这意味着在讨论 GPU/CPU 或渲染器之前，先要确保模拟数值本身处于合理区间，否则后续任何渲染器切换都只是在放大错误的源结果。

### 00:30:00-00:30:13 关键流程 08

- 本段定位：关键流程 08。
- 知识点：再试试加换成的方向。
- 知识点：我强烈建议你这么做。
- 知识点：包含字幕提供及广告。

**关键画面：**

本图回到 `Pyro Solver pyrosolver_fireball` 的高级火焰细节参数页。左侧视口里可见一个高亮、横向拉开的火焰团，说明这组参数直接影响火焰层的细碎程度、卷曲扰动与膨胀速度；右侧参数面板则依次展开了 `Disturbance`、`Turbulence` 和 `Flame Expansion` 模块。

当前可确认的参数如下：
- `Disturbance`
  - `Disturbance = 15`
  - `Mode = Block-Based`
  - `Base Block Size = 0.2`
  - `Roughness = 0.75`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.01 到 0`
  - `Use Control Field` 启用，`Control Field = speed`
  - `Control Range = 1 到 2`
- `Turbulence`
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 0.05`
  - `Swirl Size = 10`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 3`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1 到 0`
  - `Use Control Field` 启用，`Control Field = density`
  - `Control Range = 0 到 1`
- `Flame Expansion`
  - `Expansion Rate = 10`
  - `Flame Range = 0.35 到 1`

字幕里提到“停下来把选项调弱点看看数值”，对应的就是这里：通过降低或细化扰动、湍流和火焰膨胀参数，避免火焰结果过亮、过碎或过度膨胀。这一帧的核心是为后续渲染或 GPU/CPU 负担评估提供基础，因为这类高频细节模块往往既影响外观，也显著影响求解成本。
本图仍位于 `pyrosolver_fireball` 的同一组高级参数页，但已经进入“把数值压弱后重新观察”的对照状态。右侧当前仍能看到 `Disturbance`、`Turbulence` 和 `Flame Expansion` 模块，不过其中至少两项已经明显下降：
- `Turbulence = 5`
- `Flame Expansion` 的 `Expansion Rate = 2`
- `Flame Range` 仍显示为 `0.35 到 1`

与上一张火焰团强烈发光、占据整个盒体不同，左侧视口在当前帧几乎只剩包围盒与少量微弱痕迹，表明当这些控制火焰细节和膨胀的参数被明显压低后，模拟结果会迅速失去原本的可见爆炸形态。字幕提示“再试试加缓存的方向”，对应的就是这种对照试验：先把数值降下来确认影响方向，再决定哪些参数需要回拉，哪些参数可以继续保持较低，以在性能、稳定性和可见性之间找到平衡。
本图把教程收束到最终的缓存保存动作。当前选中的是 `filecache1`，右侧仍保留 `Version = 2`、`Frame Range = 1-70`、`Simulation` 启用等设置；鼠标停在 `Save to Disk` 按钮上方，弹出的提示说明该操作会“使用最后一次控制设置把几何写入磁盘”。这表明作者的建议不是继续无休止地微调，而是在确认方向正确后，尽快把当前版本固化为可复用缓存。

左侧视口此时几乎为空，只剩包围盒和极少量残留痕迹，对应前一张已经把部分火焰/膨胀参数压低后的结果。结合正文“我强烈建议你这么做”，这一帧可以理解为 `p19.md` 的最终流程建议：当你已经通过对照测试确认哪些参数影响最大后，就应把当前较合理的版本立即缓存保存，避免在未落盘的状态下继续反复试值而丢失可用结果。

## 补充视觉证据

### S01 00:02:22

这是补充视觉证据中的 `pyroburstsource` 参数快照，属于本页最早期的火球源设置。右侧当前位于 `Burst Shape` 页签，可确认的参数为：
- `Burst Type = Explosion`
- `Shape Offset = 0`
- `Initial Size = 1`
- `Direction = (0, 1, 0)`
- `Spread Angle = 90`
- `Roundness = 0.5`
- `Number of Trailings = 250`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.25`

中间网络结构为：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `RENDER_Simple_Fireball`

左侧视口此时还是空场景，说明这张补充图的目的主要是把“最开始的源参数状态”固定下来，而不是展示结果外观。它与后续把 `Initial Size` 调到 `1.5`、缩小 `Spread Angle`、减少 `Trailings` 的主线截图形成对照，可作为回溯基线：若后面调乱了源形态，可以用这张图恢复到最初的爆发源配置再重新迭代。

### S02 00:05:38

这是 `pyroburstsource` 的补充参数快照，当前仍位于 `Burst Shape` 页签，并且左侧视口同步展示了蓝黄点云爆发分布。可确认的参数为：
- `Burst Type = Explosion`
- `Shape Offset = 0`
- `Initial Size = 1`
- `Direction = (0, 1, 0)`
- `Spread Angle = 90`
- `Roundness = 0.5`
- `Number of Trailings = 250`
- `Trailing Separation = 0.1`
- `Trailing Length = 1`
- `Trailing Thickness = 0.25`

中间网络仍是：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `RENDER_Simple_Fireball`

这张图的重要性在于它把“最初参数”和“最初点云分布结果”放在了同一帧里。左侧结果显示一个高密度、宽扩散、拖尾很多的爆发源，因此可直接作为后续所有调整的对照基线：如果你把 `Initial Size`、`Spread Angle` 或 `Trailings` 改动后失去原本的爆发感，可以先回到这组初始参数，再重新逐项收缩。

### S03 00:09:51

这是 `pyrotrailpath1` 的补充参数快照，当前查看的是 `Viewing Output -1: Animation_Guide`。左侧视口展示一组黄色到红色的抛物线轨迹，从地面中心向外成扇区散开；右侧参数面板当前位于 `Trail Generation` 页签，主要是控制轨迹数量与角度分布。

当前可确认的参数为：
- `Shape = Sphere`
- `Initial Size = 1`
- `Direction = (0, 1, 0)`
- `Shape Offset = 0`
- `Number of Trails = 24`
- `Spread Start Angle = 5`
- `Spread Angle = 35`
- `Azimuth Start Angle = 0`
- `Azimuth Angle = 360`
- `Prune by Noise` 未启用

这张图补足了主线截图里没有完整展示的“轨迹扇区分布”控制方式。含义是：`pyrotrailpath1` 不只是决定速度和重力，还能先从一个球形源中，以固定朝向、限定极角扇区和全周方位分布生成若干条轨迹。这样就可以直接把爆炸分成更可控的扇形喷发模式，而不是完全随机地向四周抛射。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


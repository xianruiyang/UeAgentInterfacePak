# 15-Houdini火焰技能模拟设置

# 15-Houdini火焰技能模拟设置

## 关键术语

- `Velocity`、`Color`、`UV`、`Houdini`、`Fire`、`蓝图`、`精灵`、`生命周期`、`速度`、`纹理`、`缓存`、`Niagara`、`Normalized Age`、`Blueprint`、`颜色`、`曲线`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:02:56 Fire、蓝图、烟雾

- 本段定位：Fire、蓝图、烟雾。
- 知识点：上次我们简单完成了蓝图设置, 然后这次需要制作并带来两种视觉效果所需的模拟资源。
- 知识点：总共会进行两张模拟,并带来后续会使用我们最初制作的模拟文件, 将这些使用器结构打开之前保存为Campfire的文件。
- 知识点：我们当时在这里设置名称属性时,是作为原始设置的。
- 知识点：设置好的这些字段在模拟中没有准确使用。
- 知识点：建议您一定要把这点作为重点来使用。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`蓝图`、`烟雾`。

**关键画面：**

本图位于 `### 00:00:05-00:02:56 Fire、蓝图、烟雾` 段的开头，当前画面已经切到 Houdini，而不是 Unreal。可直接确认：

- 软件标题栏：`untitled.hip - Houdini Indie Limited-Commercial 20.5.445 - Py3.11`
- 当前网络路径位于：`/obj`
- 中间网络视图是空的，提示：
  - `Empty Network`
  - `Press Tab to Add Nodes`

界面分区可辨认出：
- 左侧是 3D 视口，当前为 `Persp`
- 中间是 `/obj` 对象网络
- 右侧参数面板当前显示：
  - `No Operator Selected`
- 底部是时间轴与 `Render Scheduler`

顶部菜单和工具栏当前还能确认：
- 常规菜单：`File / Edit / Render / Assets / Windows / Labs / Help`
- 上方标签包含 `Scene View`、`Animation Editor`、`Render View`、`Compositing View`
- 货架中可见 `Pyro FX`、`Particle Fluids`、`Viscous Fluids` 等与流体/烟火有关的工具分类

这张图的作用是把本节工作的起点钉住：作者不是直接在 Unreal 里调 Niagara，而是回到 Houdini 的 `/obj` 级对象网络，准备重新搭建或导入两套后续要用到的模拟资源。结合正文“这次需要制作并带来两种视觉效果所需的模拟资源”，可复现为：先在一个新的 `.hip` 场景里进入空的 `/obj` 网络，再逐步搭建火焰/烟雾模拟节点结构。
本图已经打开一个现成的 Houdini 工程，标题栏可直接确认：

- `F:/Houdini/Coloso_Resource/Part_05/Tutorial/Ex_01_CampFire_01.hiplc`

当前网络位置在：
- `/obj/Fire`

中间可见的是一套完整的火焰/烟雾模拟节点链。按当前截图能可靠读出的结构如下：

主链：
- `circle1`
- `pyrosource1`
- 分成左右两支
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- 输出到两个渲染分支：
  - `Render_Smoke`
  - `Render_Fire`

左支：
- `attribadjustvector1`
  - 属性标签可见为 `v`
- `attribnoise1`
  - 属性标签可见为 `burn`
- `name1`

右支：
- `attribadjustfloat1`
  - 属性标签可见为 `pscale`
- `attribnoise2`
  - 属性标签可见为 `temperature`
- `pointjitter1`
- `name2`

连线关系：
- `circle1 -> pyrosource1`
- `pyrosource1` 同时分出左右两支
- 左支末端 `name1` 与右支末端 `name2` 一起并入 `merge1`
- `merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1`
- `filecache1` 再供给 `Render_Smoke` 与 `Render_Fire`

右侧参数面板当前选中的是 `name2`，可直接确认：

- `Attribute = source_name`
- `Class = Point`
- `Number of Namings = 1`
- `Name = temperature`
- `Number of Renames = 0`

底部状态栏还显示：
- `Successfully loaded Ex_01_CampFire_01.hiplc`

这张图把本段“将这些使用器结构打开之前保存为 Campfire 的文件”“设置名称属性时作为原始设置”的说法具体化了。当前网络不是从零开始搭，而是打开已有的 `CampFire` 模拟工程，并用两条属性分支分别准备不同的源数据后再合并进体积栅格化与 Pyro 求解。特别是 `name1 / name2` 的 `source_name` 命名步骤很关键，它决定后续 `volumerasterizeattributes` 和 Pyro 流程如何识别不同来源的模拟属性。
本图继续在同一套 Houdini 网络中工作，但当前把最上游源几何 `circle1` 选中了，右侧参数面板完整展示了它的基础形状设置。当前网络主链仍保持为：

- `circle1`
- `pyrosource1`
- 左右两条属性支线
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`

右侧 `circle1` 参数可直接读取：

`Circle`
- `Primitive Type = Polygon`
- `Orientation = ZX Plane`
- `Radius = 1.25, 0.1`
- `Center = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Uniform Scale = 1`
- `Divisions = 48`
- `Arc Type = Closed`
- `Arc Angles = 0, 360`

当前没有看到额外动画或表达式接入这些字段。

结合字幕“先把尺寸缩小一点”，这张图说明作者没有直接从噪声或 Pyro 求解器下手，而是优先从最源头的发射几何控制模拟范围。对复现而言，这一步的含义很明确：火焰/烟雾模拟的整体体量首先由 `circle1` 这类源几何决定；若要让后续两套模拟资源更紧凑，应先收小 `Radius`，再观察 `pyrosource1`、噪声和栅格化后的结果，而不是一开始就只调后面的体积参数。

### 00:03:02-00:05:52 速度、缓存

- 本段定位：速度、缓存。
- 知识点：接下来的话,其他部分在这里,关于噪音的缩放大小元素。
- 知识点：大小程度改变的话。
- 知识点：适当更详细的形状出来。
- 知识点：这部分现在也没什么要改的。
- 知识点：现在同样的结构里我们只适当改变一下形状,做做模拟。
- 核对对象：`速度`。

**关键画面：**

本图进入 `### 00:03:02-00:05:52 速度、缓存` 段，当前选中的是左支上的：

- `attribnoise1`

从中间网络可确认当前仍在同一条火焰模拟链上：
- `circle1 -> pyrosource1`
- 左支：`attribadjustvector1 (v) -> attribnoise1 (burn) -> name1`
- 右支：`attribadjustfloat1 (pscale) -> attribnoise2 (temperature) -> pointjitter1 -> name2`
- 然后合并进：
  - `merge1`
  - `volumerasterizeattributes1`
  - `pyrosolver1`
  - `filecache1`
  - `Render_Fire`

右侧 `Attribute Noise attribnoise1` 面板可直接读取：

`General`
- `Attribute Names` 类型为 `Float`
- 属性名：`burn`
- `Attribute Class = Point`

`Noise Value`
- `Operation = Multiply`
- `Range Values = Min/Max`
- `Min Value = 0.75`
- `Max Value = 1.35`

`Noise Pattern`
- `Noise Type = Simplex`
- `Location Attribute = P`
- `Element Size = 0.5`
- `Offset` 当前未填写明确数值

`Animation`
- `Pulse Duration = 1`
- 分形模式可见为 `Standard (fBm)`

左侧视口同时能看到一条非常扁的椭圆状源面，说明当前还在源几何层面做预处理。

这张图说明本段所谓“大小程度改变的话，适当更详细的形状出来”并不是改缓存输出逻辑，而是在进入体积求解前，先用 `attribnoise1` 对 `burn` 这个标量属性做乘法噪声调制。具体效果是：把 `burn` 在 `0.75` 到 `1.35` 的范围内打散，使后续模拟的燃烧区域边界和细节不那么均匀。对复现而言，这一步应保持“只适度改形状”的原则，噪声范围不宜过大，否则基础源会被打得过碎，后面的缓存和火焰形状都容易失控。
本图仍在 `速度、缓存` 段，但当前关注点已经从属性噪声切到模拟主链与缓存重建。当前网络中可直接确认：

- 上游结构仍是：
  - `pyrosource1`
  - 左支 `attribadjustvector1 -> attribnoise1 -> name1`
  - 右支 `attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
  - `merge1`
  - `volumerasterizeattributes1`
  - `pyrosolver1`
- 当前下游直接接到了：
  - `Render_Fire`

与上一张相比，一个关键变化是：
- 当前截图里看不到 `filecache1`

右侧参数面板当前又回到了 `circle1`，可读参数为：
- `Primitive Type = Polygon`
- `Orientation = ZX Plane`
- `Radius = 1, 0.1`
- `Center = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Uniform Scale = 1`
- `Divisions = 48`
- `Arc Type = Closed`
- `Arc Angles = 0, 360`

左侧视口仍显示一条扁平椭圆源面。

字幕“还有文件缓存也清除掉重新创建”与当前网络状态结合起来，能可靠得出这一点：作者在调整源尺寸与形状之后，不打算继续沿用旧缓存，而是准备重新走一遍求解和缓存流程。对复现而言，关键原则是：当上游源几何、噪声或源属性结构发生变化后，旧的 `filecache` 结果不再可信，应清掉缓存并重新生成；否则后续 `Render_Fire` 看到的仍可能是之前那套模拟，不会真实反映当前参数改动。
本图仍在 `速度、缓存` 段，当前选中的是主求解节点：

- `pyrosolver1`

中间网络当前可直接确认完整主链为：
- `circle1`
- `pyrosource1`
- 左支：`attribadjustvector1 -> attribnoise1 -> name1`
- 右支：`attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

与上一张不同的是，`filecache1` 已重新回到链路中，当前缓存文件名可辨认出以：
- `$HIPNAME...SF4.bgeo.sc`
结尾，说明作者确实在重新走缓存输出。

右侧 `Pyro Solver pyrosolver1` 参数面板当前可直接读取：

`General`
- `Voxel Size = 0.02`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1.5`

`Simulation`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `CFL Condition` 滑条可见，但当前未显示明确数值
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

左下状态栏还能看到：
- `Successfully saved Ex_01_Skill_04.hiplc`

这张图把本段“其他部分在这里没什么要改”“现在同样的结构里只适当改变一下形状，做做模拟”的说法落到了求解器层面：主求解参数整体保持稳定，只在当前结构基础上做适度源形状修改后重新缓存。对复现而言，关键是不要把求解器也大幅推翻。当前可据图直接复用的稳定求解基线为：

- `Voxel Size = 0.02`
- `Time Scale = 1.5`
- `Sparse` 求解
- `Substeps = 1 / 2 / 3`
- `Reflection Amount = 0.95`

这样做的目的，是让“形状变化”主要来自前面源和属性支线，而不是让求解器参数本身引入过多额外变量。

### 00:05:57-00:08:56 速度、缓存

- 本段定位：速度、缓存。
- 知识点：空间适当提升,保持原样。
- 知识点：这几个部阻式就在做。
- 知识点：只在形状上适当降低一点。
- 知识点：适当降低一点看也可以。
- 知识点：就是,而且这次不会使用Turbulence的。
- 核对对象：`速度`。

**关键画面：**

本图进入 `### 00:05:57-00:08:56 速度、缓存` 段，当前再次选中了主求解节点：

- `pyrosolver1`

中间网络主链保持为：
- `circle1`
- `pyrosource1`
- 左支：`attribadjustvector1 -> attribnoise1 -> name1`
- 右支：`attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

右侧 `Pyro Solver pyrosolver1` 当前页签仍在求解设置区域，截图中可直接读到：

`Dissipation`
- `Dissipation = 0.05`
- `Clamp Below = 0.005`
- `Use Control Field` 已启用
- `Control Field = temperature`
- `Control Range = 0 -> 1`
- `Remap Control Field` 已启用
- 下方控制曲线从左高右低，表示随控制字段增大而逐渐减弱耗散

`Temperature`
- `Diffusion = 0.15`
- `Cooling Rate = 0.5`

`Flame`
- `Create Flame Field` 已启用
- `Flame Lifespan = 2`

左侧视口仍只显示一条低矮扁平的源形体。

结合正文“空间适当提升，保持原样”“这次不会使用 Turbulence 的”以及字幕“保持原样”，这张图说明这段的策略不是继续大改求解器结构，而是维持主火焰求解框架基本不变，仅通过温度控制的耗散曲线、温度扩散和火焰寿命这些核心字段维持稳定的火焰衰减行为。对复现而言，关键是不要额外引入新的湍流类干扰，而应以当前 `temperature` 驱动的 `Dissipation` 控制为基础，保住原有燃烧消散节奏。
本图仍在 `速度、缓存` 段，但当前选中的是缓存节点：

- `filecache1`

当前网络主链可直接确认：
- `pyrosource1`
- 左支 `attribadjustvector1 -> attribnoise1 -> name1`
- 右支 `attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

右侧 `File Cache filecache1` 面板当前可直接读取：

顶部
- `Load from Disk` 已启用
- `File Path = Constructed`
- `Time Dependent Cache` 已启用

基础路径
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 1`

缓存操作区
- `Save to Disk`
- `Save to Disk in Background`

`Sequence`
- `Evaluate As = Frame Range`
- `Simulation` 已启用
- `Start/End/Inc = 1 / 80 / 1`
- `Substeps` 滑条可见

`Load`
- `Load = All Geometry`

中间节点标签处还能看到缓存输出文件名：
- `Ex_01_Skill_04.filecache1_v1.$F4.bgeo.sc`

底部时间轴当前停在：
- `64` 帧附近

左侧视口中可见一圈方框状火焰/体积边界残影，而字幕明确说“在 64 帧左右消失得很好”。这说明作者正在用缓存回放验证火焰在中后段的消散时机，而不仅仅是看单帧静态形状。对复现而言，关键结论是：当前这套模拟被缓存为 `1-80` 帧，但实际可用火焰主体大约在 `64` 帧附近已经衰减到比较合适的程度，因此后续导入 Unreal 使用时，可以围绕这个有效时长去估算技能表现的可见持续时间，而不必机械使用整段 80 帧。
本图仍在 `速度、缓存` 段，当前再次选中 `pyrosolver1`，但这次左侧视口已经直接显示出竖向火焰预览，因此能同时核对求解参数与可见结果。

中间网络仍保持：
- `circle1`
- `pyrosource1`
- 左支 `attribadjustvector1 -> attribnoise1 -> name1`
- 右支 `attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

右侧 `Pyro Solver pyrosolver1` 当前可直接读取：

`General`
- `Voxel Size = 0.03`
- `Velocity Voxel Scale = 1`
- `Time Scale = 2`

`Simulation`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

左下时间轴当前停在：
- `40` 帧附近

左侧视口当前可见结果：
- 一团细长竖向火焰被包在明显的长方体求解边界内
- 火焰主体从底部向上拉升，顶部有较细的卷曲火舌
- 整体比前面营火式源更像快速技能火焰柱

结合字幕“这样模拟速度会更快”，这张图说明作者为了技能用途，正在把求解速度和整体节奏往更快方向推：`Time Scale` 直接提高到 `2`，同时 `Voxel Size` 放宽到 `0.03`，以换取更快的模拟推进和更轻的计算量。对复现而言，这一步的设计意图很明确：如果目标是技能火焰，而不是缓慢燃烧的营火，就应该允许更快的时间推进和稍粗一些的体素分辨率，让火焰在有限帧数内更快升腾、消失并完成缓存。

### 00:09:01-00:11:37 火焰、缓存

- 本段定位：火焰、缓存。
- 知识点：现在可观察到火在差不多55帧内完全消失。
- 知识点：现在这个圆的范围帧数也得一起提高使用才对。
- 知识点：1.5秒或虚幻钟2秒左右使用时。
- 知识点：这样收取费用也可以。
- 知识点：现在我技能中使用的火。
- 核对对象：`火焰`。

**关键画面：**

本图进入 `### 00:09:01-00:11:37 火焰、缓存` 段，当前仍选中 `pyrosolver1`，但讨论重点已经从“模拟得更快”转到“这团火焰能否支撑技能使用时长”。

当前主链仍保持：
- `circle1`
- `pyrosource1`
- 左右属性支线
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

右侧 `pyrosolver1` 当前可直接读取的主设置仍为：
- `Voxel Size = 0.03`
- `Velocity Voxel Scale = 1`
- `Time Scale = 2`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

左侧视口当前显示：
- 一团较完整的竖向火焰
- 火焰被包在长方体求解边界内
- 顶部与中段有清晰卷曲火舌，底部仍保持较饱满火焰量

底部时间轴当前位置在：
- `46` 帧附近

结合正文“现在可观察到火在差不多 55 帧内完全消失”“1.5 秒或虚幻中 2 秒左右使用时”，以及字幕“如果要这样提高时间尺度使用的话”，这张图说明作者正在权衡一个关键问题：虽然 `Time Scale = 2` 让模拟更快，但也会让火焰更快走完生命周期，因此要反过来结合可用帧段判断技能是否还够长。对复现而言，这一帧可作为中段火焰强度的参考点：在大约 46 帧时，火焰主体仍需保持足够体量，才能支撑后续在 Unreal 中作为 1.5 到 2 秒技能表现的一部分使用。
本图继续是 `火焰、缓存` 段，当前仍选中 `pyrosolver1`，但这一帧给出了本段最关键的单项调整：直接拉长火焰寿命。

右侧 `pyrosolver1` 当前可直接读取：

`Dissipation`
- `Dissipation = 0.05`
- `Clamp Below = 0.005`
- `Use Control Field` 已启用
- `Control Field = temperature`
- `Control Range = 0 -> 1`
- `Remap Control Field` 已启用

`Temperature`
- `Diffusion = 0.15`
- `Cooling Rate = 0.5`

`Flame`
- `Create Flame Field` 已启用
- `Flame Lifespan = 4`

中间网络主链保持不变：
- `circle1`
- `pyrosource1`
- 左右属性支线
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

左侧视口当前几乎只剩贴地的一小段火焰残留，正好说明这是在观察火焰消散后的收尾阶段。

结合字幕“把寿命提高到 4 左右”以及正文“现在这个圆的范围帧数也得一起提高使用才对”，这张图说明作者为了解决“55 帧左右就完全消失”的问题，没有先去继续堆缓存长度，而是先从 `Flame Lifespan` 这个最直接的火焰存续字段入手，把寿命从前一阶段的较短值拉高到 `4`。对复现而言，这一步的意图很明确：当技能要在 Unreal 中维持更长的火焰可见时间时，应先延长火焰场本身的寿命，再观察缓存结果是否足够覆盖目标时长。
本图仍属于 `火焰、缓存` 段，当前依旧选中 `pyrosolver1`，但它展示的是另一组当前实际保存下来的求解状态。中间网络主链仍为：

- `circle1`
- `pyrosource1`
- 左右属性支线
- `merge1`
- `volumerasterizeattributes1`
- `pyrosolver1`
- `filecache1`
- `Render_Fire`

右侧 `pyrosolver1` 当前可直接读取：

`Dissipation`
- `Dissipation = 0.05`
- `Clamp Below = 0.005`
- `Use Control Field` 已启用
- `Control Field = temperature`
- `Control Range = 0 -> 1`
- `Remap Control Field` 已启用

`Temperature`
- `Diffusion = 0.15`
- `Cooling Rate = 0.5`

`Flame`
- `Create Flame Field` 已启用
- `Flame Lifespan = 2`

与上一张不同的另一个可见事实是，当前 `filecache1` 的缓存文件名已经变成：
- `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`

左侧视口当前仍只看到贴地的一段细小火焰残留。

这张图说明作者并不是机械地把寿命调高后就固定不动，而是在不同缓存版本之间继续比较表达效果。当前截图里真正可证实的是：在 `v2` 这一版缓存对应的求解配置中，`Flame Lifespan` 回到了 `2`，并保留了前面那套 `temperature` 驱动的耗散与温度扩散逻辑。结合字幕“这样也刚好能表达”，可复现为：围绕火焰寿命做几轮小范围试探后，选择当前最能满足技能表达的那一组参数并重新缓存成新版本，而不是只追求更长寿命本身。

### 00:12:08-00:14:42 Velocity、纹理、火焰

- 本段定位：Velocity、纹理、火焰。
- 知识点：预备约会越来越多消失。
- 知识点：部分有点过度变质的担心,有点有吧。
- 知识点：迪斯科城的多加点量。
- 知识点：认为把了Paris温度调高这个点。
- 知识点：这部分如果Division尺寸再小点。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Velocity`、`Add`、`纹理`、`粒子`、`速度`、`火焰`。

**关键画面：**

当前仍在 `/obj/Fire` 的火焰模拟网络中，对比的是缓存回放后的火焰整体形态。主链保持 `pyrosource1 -> attribadjustvector1 -> attribnoise1 -> name1` 与 `pyrosource1 -> attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2` 两支汇入 `merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1 -> Render_Fire`。

这张图的关键变化在 `filecache1` 参数面板：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点视图里 `filecache1` 的文件名预览显示为 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`，说明当前是在回放第 2 版缓存结果。左侧视口时间轴约在第 65 帧，火焰呈细长上冲形态，用于观察这一版速度与火焰消散后的整体观感。
当前选中的是 `pyrosolver1`，画面展示的是把体素精度调回更细之后重新出缓存。右侧 `Setup` 面板可确认的参数为：

- `Voxel Size = 0.02`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1.5`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

节点图下方的 `filecache1` 仍显示第 2 版缓存文件 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`。字幕明确说明“改成了 `0.02`，缓存重新烘烤了”，因此这一步的操作重点是把模拟分辨率从前一版的 `0.03` 调回 `0.02`，再重新生成缓存，以观察更细体素下的火焰形态。
这张图继续在 `pyrosolver1` 上细调火焰运动相关参数。节点网络没有变化，仍是 `merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1 -> Render_Fire`，当前重点在右侧参数面板中可见的物理控制项：

- `Buoyancy` 已启用。
- `Buoyancy Scale = 0.25`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 2500`
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Viscosity` 已启用。
- `Viscosity = 0.1`

同时，`Density Influences Gravity`、`Wind`、`Disturbance`、`Turbulence`、`Shredding`、`Flame Expansion` 这些折叠项虽然可见，但截图中看不出是否做了进一步修改，不应额外推断。结合本段“Velocity、纹理、火焰”的主题，这一步可确定是在通过浮力、重力方向和黏性，继续调整火焰上升速度与形体稳定性。

### 00:14:46-00:17:32 缓存

- 本段定位：缓存。
- 知识点：因为会以类似的形式使用。
- 知识点：初期数值上不会偏离太多。
- 知识点：这样走着看,如果没问题的话。
- 知识点：就可以按这种感觉输出像素。
- 知识点：看缓存的话,初期动作的形态还不错。

**关键画面：**

这一张进入“缓存”小节，选中节点切回 `filecache1`，用于直接回放并检查当前缓存的火焰轮廓。网络链路完整显示为 `circle1 -> pyrosource1 -> ... -> pyrosolver1 -> filecache1 -> Render_Fire`，说明此时已经不再调节点结构，而是在核对缓存输出。

`filecache1` 面板中可确认的设置为：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签仍显示 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`，表示回放的是第 2 版缓存。时间轴停在第 `57` 帧，左侧视口中的火焰上部展开成拱形、下部形成三股向下拖曳的亮带，用来判断这版缓存的中段形态是否仍在可接受范围内。
这张图重新选中 `pyrosolver1`，继续比较缓存版本与火焰升腾参数之间的关系。主链结构未变，但节点标签能确认一个明显变化：`filecache1` 下方显示的缓存文件变成了 `Ex_01_Skill_04.filecache1_v1.$F4.bgeo.sc`，说明当前对比视图切回了第 1 版缓存。

右侧参数面板中，本张图可确认的 `pyrosolver1` 参数为：

- `Buoyancy Scale = 0.25`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 2000`
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Viscosity = 0.1`

与上一张相比，唯一能明确确认的参数变化是 `Reference Temp` 调整到了 `2000`。这说明教程此处不仅在回看缓存结果，还在对照不同缓存版本与浮力温度基准的组合，判断初段火焰动作是否更合适。
这张图切到 `pyrosolver1` 的 `Fields` 面板，明确展示了火焰模拟实际向解算器写入的三个体积字段，以及它们的生效时间范围。

- `Limit Source Range` 已启用。
- `Range Type = Frame Range`
- `Frame Range = 1 - 40`

`Source Volumes` 中一共配置了 3 个来源：

1. `Source 1: temperature`
   - `Operation = Pull`
   - 数据类型为 `Scalar`
   - `Source Volume = temperature`
   - `Target Field = temperature`
   - `Source Scale = 1`
   - `Use Timestep` 已启用。
   - `Acceleration Strength = 50`
   - `Deceleration Strength = 0`

2. `Source 2: flame`
   - `Operation = Maximum`
   - 数据类型为 `Scalar`
   - `Source Volume = burn`
   - `Target Field = flame`
   - `Source Scale = 1`
   - `Use Timestep` 已启用。

3. `Source 3: vel`
   - `Operation = Add`
   - 数据类型为 `Vector`
   - `Source Volume = v`
   - `Target Field = vel`
   - `Source Scale = 1`
   - `Use Timestep` 已启用。

节点图里的 `filecache1` 标签重新显示为 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`，说明当前又切回第 2 版缓存。字幕提到“这部分放慢到 45 或 50 帧看也行”，但截图中面板实际可见的限制范围是 `1-40`，因此这里只能可靠记录当前画面已显示的字段配置和帧范围。

### 00:17:37-00:20:35 Color、速度、纹理

- 本段定位：Color、速度、纹理。
- 知识点：现在该好好调整一下相机了。
- 知识点：这样在64帧下应该差不多了。
- 知识点：即使是在这个程度。
- 知识点：现在速度也很快了。
- 知识点：0.01也可以试试看。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`纹理`、`速度`。

**关键画面：**

这一张进入“Color、速度、纹理”小节，但当前画面仍在 Houdini 中直接回看火焰缓存的整体轮廓，尚未切到材质或 Niagara 粒子设置。主链保持 `circle1 -> pyrosource1 -> ... -> pyrosolver1 -> filecache1 -> Render_Fire`，没有新的节点结构变化。

`filecache1` 参数面板可确认：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签显示当前回放文件为 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`。时间轴位于第 `37` 帧，左侧视口中的火焰顶部形成左右翻卷的大块亮部，中下段收成较宽的主体火舌，用于判断这一版缓存在中前段的体块和运动感觉是否合适。
这张图切到 `/out` 网络，当前选中的是 `Labs Flipbook Textures` 节点 `Render_Fire`，说明教程开始从模拟缓存转向火焰贴图烘焙输出设置。节点图中同级还能看到另一个输出节点 `Render_Smoke`，但当前只在检查火焰输出。

`Render_Fire` 的 `Render` 面板中可确认的设置为：

- `Start/End/Inc = 1 / 80 / 1`
- `Camera = /obj/cam_Fire_01`
- `Pyro Bake Volume Path = /obj/Fire/Render_Fire`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 x 8`
- `Total Resolution = 4096 x 4096`
- `Intermediate Directory = $HIP/render/${HIPNAME}_${OS}/intermediate`
- `Color Space = ACES sRGB (Best for Pyro)`

`Render Pass Control` 区域里可以看到输出通道列表，包括 `Render Final Color`、`Render Non-emissive Color`、`Render MDC / MDC Normal`、`Render Surface Normal`、`Render Motion Vector`、`Render Depth`。这一步的重点是确认火焰 flipbook 的相机、输出来源与图集分块分辨率，为后续在 Niagara 或材质中使用贴图做准备。
这张图仍在 `/out` 网络，但火焰输出节点已经分成两套：`Render_Fire_01` 和 `Render_Fire_02`。当前选中的是 `Render_Fire_01`，说明教程开始为不同版本或不同动作节奏分别准备火焰 flipbook。

`Render_Fire_01` 的 `Render` 面板中可确认：

- `Start/End/Inc = 1 / 64 / 1`
- `Camera = /obj/cam_Fire_01`
- `Pyro Bake Volume Path = /obj/Fire/Render_Fire`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 x 8`
- `Total Resolution = 4096 x 4096`
- `Intermediate Directory = $HIP/render/${HIPNAME}_${OS}/intermediate/`
- `Color Space = ACES sRGB (Best for Pyro)`

与上一张相比，关键变化是输出帧范围从 `1-80` 缩短到 `1-64`。结合本段“这样在 64 帧下应该差不多了”的语义，这一步是在把火焰 flipbook 的时长压缩到更适合技能节奏的长度，同时保留原有相机和图集规格。

### 00:20:41-00:23:31 Color、颜色、烟雾

- 本段定位：Color、颜色、烟雾。
- 知识点：现在看1号和2号版本的区别就是。
- 知识点：density2号版本是我们原本想渲染的版本。
- 知识点：1号版本是我随便拿了个能渲染的贝克做例子。
- 知识点：现在density的复线不存在。
- 知识点：这是因为我们之前在sauce里删了density。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`颜色`、`烟雾`、`火焰`。

**关键画面：**

这一张仍在 `/out` 网络，选中节点是 `Labs Flipbook Textures` 的 `Render_Fire_01`。和上一张相比，核心变化不是输出规格，而是右侧参数面板正在打开路径选择器，说明作者此时在重新指定某个对象引用路径。

从截图能可靠确认的界面信息：

- 当前节点仍是 `Render_Fire_01`。
- `Render` 面板可见，包含 `Camera` 与 `Pyro Bake Volume Path` 这两个对象路径字段。
- 弹出的 `Choose Operator` 对话框位于路径输入框旁，当前浏览的是 `/obj` 下的对象列表。
- 列表中明确可见的候选有 `Fire`、`cam_Fire_01`、`cam_Fire_02`、`out`。

由于弹窗遮挡了具体正在编辑的是 `Camera` 还是 `Pyro Bake Volume Path`，这一步不能武断写成已经切换到某个相机或某个体积节点。唯一能确定的是：作者正在为 `Render_Fire_01` 重新核对输出所引用的对象路径，以便比较不同版本的火焰/烟雾输出。
这一张回到 `pyrosolver1` 的 `Fields` 面板，重点是把烟雾所需的 `density` 字段重新加入解算器输入。当前 `Source Type = Individual Volumes`，并且限制了写入时间范围：

- `Limit Source Range` 已启用。
- `Range Type = Frame Range`
- `Frame Range = 1 - 45`

`Source Volumes` 数量已经是 `4`，截图中能确认的条目如下：

1. `Source 1: temperature`
   - `Operation = Pull`
   - 类型 `Scalar`
   - `Source Volume = temperature`
   - `Target Field = temperature`
   - `Source Scale = 1`
   - `Acceleration Strength = 50`
   - `Deceleration Strength = 0`
   - `Use Timestep` 已启用。

2. `Source 2: flame`
   - `Operation = Maximum`
   - 类型 `Scalar`
   - `Source Volume = burn`
   - `Target Field = flame`
   - `Source Scale = 1`
   - `Use Timestep` 已启用。

3. `Source 3: vel`
   - `Operation = Add`
   - 类型 `Vector`
   - `Source Volume = v`
   - `Target Field = vel`
   - `Source Scale = 3`
   - `Use Timestep` 已启用。

4. `Source 4: density`
   - `Operation = Add`
   - 类型 `Scalar`
   - `Source Volume = burn`
   - `Target Field = density`

节点标签仍显示当前缓存是 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`。结合字幕“只需要重新添加源字段”，这一步的核心就是恢复 `density` 输入，让后续烟雾渲染重新具备密度场。
这张图再次回到 `/out` 网络中的 `Render_Fire_01`，用于确认火焰 flipbook 输出节点的最终引用路径和图集规格。与 `S08_1` 里还停留在路径选择弹窗不同，这里路径已经落实到面板字段中。

当前可确认的 `Render_Fire_01` 设置为：

- `Start/End/Inc = 1 / 64 / 1`
- `Camera = /obj/cam_Fire_01`
- `Pyro Bake Volume Path = /obj/Fire/Render_Fire`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 x 8`
- `Total Resolution = 4096 x 4096`
- `Intermediate Directory = $HIP/render/${HIPNAME}_${OS}/intermediate`
- `Color Space = ACES sRGB (Best for Pyro)`

节点图中仍保留两套输出节点 `Render_Fire_01` 与 `Render_Fire_02`，说明教程此时在并行维护两个火焰输出版本。左侧视口顶部标签也显示当前已切到 `cam_Fire_01` 视角，因此这一步的重点是确认 `Render_Fire_01` 已经绑定到正确相机和体积来源，便于后续继续输出或比对火焰版本。

### 00:24:37-00:27:32 精灵、速度、纹理

- 本段定位：精灵、速度、纹理。
- 知识点：下次需要把我测试过的纹理一起。
- 知识点：需要把我选的纹理也传给你。
- 知识点：一起比较看看应该。
- 知识点：第二个设置也需要适当调整一下数值。
- 知识点：毕竟第二个资源需要展示完全不同的动作。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`速度`。

**关键画面：**

这张图进入火焰 flipbook 的成片预览界面，窗口标题为 `MPlay - ip-14:10?`，说明当前不是在调节点，而是在检查已经输出好的火焰图集纹理。

从预览信息中可确认：

- 当前资源名显示为 `ip-14:10:29`
- 图集分辨率为 `4096 x 4096`
- 当前播放帧为 `fr:9`
- 图集内容按 `8 x 8` 的小格排布，总共 64 帧

图集中每一格都展示同一束火焰在不同时间点的形态：上方几行是刚起火时的小体块，中段逐步发展成主体火舌，底部几行则是后段的翻卷和收尾。当前时间轴停在第 `9` 帧，用于直接观察这张火焰贴图在整套 flipbook 中的节奏与形变质量，便于后续把这张纹理交给 Niagara 或材质侧做比较。
这一张切到 `/obj/Fire02`，表明教程开始为第二套火焰资源单独调整网络。主链结构仍与前面的 `Fire` 基本一致：

- `circle1 -> pyrosource1`
- 左支：`attribadjustvector1 -> attribnoise1 -> name1`
- 右支：`attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- 汇合后：`merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1 -> Render_Fire`

右侧当前选中的是 `filecache1`，从参数面板可确认：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签也显示当前回放文件是 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`。因此这一步还不是在细调第二套资源的火焰参数，而是先在 `Fire02` 分支中把原有第 2 版缓存链路搭起来，作为后续修改横向尺寸、速度和纹理节奏的起点。
这张图继续停留在 `/obj/Fire02`，当前选中的是 `pyrosolver1` 的 `Fields` 面板。第二套火焰资源的字段组织与前一套一致，但速度场注入已经被明显加强。

当前可确认的设置为：

- `Limit Source Range` 已启用。
- `Range Type = Frame Range`
- `Frame Range = 1 - 45`
- `Number of Sources = 4`

`Source Volumes` 中可见的 4 项分别是：

1. `temperature`
   - `Operation = Pull`
   - `Source Volume = temperature`
   - `Target Field = temperature`
   - `Source Scale = 1`
   - `Acceleration Strength = 50`
   - `Deceleration Strength = 0`

2. `flame`
   - `Operation = Maximum`
   - `Source Volume = burn`
   - `Target Field = flame`
   - `Source Scale = 1`

3. `vel`
   - `Operation = Add`
   - `Source Volume = v`
   - `Target Field = vel`
   - `Source Scale = 5`

4. `density`
   - `Operation = Add`
   - `Source Volume = burn`
   - `Target Field = density`
   - `Source Scale = 1`

节点图中 `pyrosolver1` 标签下方同时可见 `0.03`，说明这套 `Fire02` 当前以 `Voxel Size = 0.03` 运行。结合本段“第二个资源需要展示完全不同的动作”，这一步的核心是把 `vel` 注入力度提高到 `5`，让第二套火焰的速度感明显 stronger，而不是沿用第一套较平缓的运动。

### 00:27:35-00:30:33 Velocity、火焰

- 本段定位：Velocity、火焰。
- 知识点：我们现在主要依赖火焰场。
- 知识点：这个数字不变也没关系。
- 知识点：在目前这种情况下。
- 知识点：把原值增加大约50。
- 知识点：我把扩散值调低一点看看。
- 核对对象：`Velocity`、`火焰`。

**关键画面：**

这一张仍在 `/obj/Fire02`，但选中的节点已经切到 `Pyro Bake Volume` 的 `Render_Fire`，说明当前讨论重点从解算器字段输入转到最终火焰贴图的渲染来源。节点主链保持 `pyrosolver1 -> filecache1 -> Render_Fire`，没有新增分支。

右侧 `Render_Fire` 面板中可确认：

- `Assign Material` 已启用。
- 材质路径为 `matnet/Pyro_Shader`
- 当前打开的是 `Smoke` 页签。

`Smoke` 页签里能看到的控制项包括：

- `Density Scale`
- `Smoke Color`
- `Shadow Color`
- `Shadow Density`
- `Ambient Shadow Scale`

但截图里这些值都没有清晰的数值展示，不应编造具体参数。结合字幕“我们现在主要依赖火焰场”，这一步能可靠得出的结论是：第二套资源的输出端正在以火焰为主进行渲染检查，烟雾相关通道即使保留了面板，也不是当前这段的主要依赖对象。
这一张重新选中 `/obj/Fire02` 的 `pyrosolver1`，当前在运动控制参数区微调第二套火焰的上升方向。网络结构没有变化，但右侧面板中可以清晰确认以下参数：

- `Buoyancy` 已启用。
- `Buoyancy Scale = 0.25`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 2000`
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Wind` 已启用。
- `Wind Speed = 3`
- `Wind Direction = (1, 0, 0)`
- `Viscosity` 已启用。
- `Viscosity = 0.1`

同时，`pyrosolver1` 标签下仍显示 `0.03`，表示本套资源仍以 `Voxel Size = 0.03` 运行。与前面主要通过 `vel` 注入增强速度不同，这一步是直接增加一个朝 `+X` 方向的侧向风，让火焰在上升时带有横向偏移，从而形成“斜着往上”的运动感觉。
这一张回到 `Render_Fire` 的渲染参数面板，但当前焦点已经切到 `Fire` 页签，用于直接控制火焰贴图的亮度与配色映射。左侧视口里也能看到一束明显向右上翻卷的火焰，说明这是在观察渲染结果而不是只看缓存框线。

当前可确认的 `Render_Fire -> Fire` 设置为：

- `Fire` 已启用。
- `Intensity Scale = 75`
- `Source Range = 0 -> 1`
- `Color Mode = Color Ramp`
- `Fire Intensity Ramp` 为从左低到右高的线性斜坡
- `Fire Color Ramp` 使用由亮橙到深棕/近黑的渐变
- 下方 `Masking` 分组已存在，但当前未展开

节点图中 `filecache1` 的文件名预览已变成 `Ex_01_Skill_04.filecache1_v3.$F4.bgeo.sc`，表示这一轮观察使用的是第 3 版缓存结果。结合本段前面围绕速度场和火焰方向的修改，这一步的作用是通过提高火焰强度、设置强度 ramp 和颜色 ramp，确认第二套火焰在最终烘焙渲染中的亮部层次与尾部熄灭过渡。

### 00:30:45-00:33:07 火焰、缓存

- 本段定位：火焰、缓存。
- 知识点：先把这个部分调到3000左右。
- 知识点：这些间隙比火焰的感觉。
- 知识点：就和之前那个版本比。
- 知识点：就明显有点感觉加了点乱糟糟的图案。
- 知识点：有着参考温度上升。
- 核对对象：`火焰`。

**关键画面：**

这一张继续停留在 `/obj/Fire02` 的缓存回放链路上，当前选中的是 `filecache1`。主链仍然是 `merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1 -> Render_Fire`，没有新的节点结构变化。

右侧 `filecache1` 面板中可确认：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 3`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签下方的文件名预览也显示当前回放的是 `Ex_01_Skill_04.filecache1_v3.$F4.bgeo.sc`。左侧视口时间轴停在前段帧位，画面底部只能看到刚起始的几小段亮部火焰，说明这一版缓存正在被用作新的比较基线，后续围绕火焰场和参考温度的调整都会以 `v3` 为准继续观察。
这一张仍在 `/obj/Fire02` 的 `filecache1` 回放界面，但当前缓存版本已经继续推进。主链结构未变，仍然是 `pyrosolver1 -> filecache1 -> Render_Fire`，当前重点在对比新版缓存和上一版的火焰轮廓差异。

`filecache1` 面板可确认：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 4`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签下方的文件名预览已变为 `Ex_01_Skill_04.filecache1_v4.$F4.bgeo.sc`。时间轴位于第 `43` 帧，左侧视口中的火焰主体明显比前一版更饱满，顶部和尾部出现更多卷曲、断裂和细碎的亮部边缘。结合本段“缓存都烘好了”“比之前那个版本更乱一些”的语义，这一步是在用第 4 版缓存直接检查火焰形体是否已经具备更丰富、更杂乱的细节感。
这张图仍在 `/obj/Fire02` 的 `filecache1` 回放界面，缓存版本没有变化，继续使用第 4 版结果做观察。主链和参数面板与上一张保持一致：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 4`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签预览仍显示 `Ex_01_Skill_04.filecache1_v4.$F4.bgeo.sc`。与上一张的中段火焰对比不同，这里时间轴已经回到起始段附近，左侧视口只剩底部刚点燃的几小块亮部，用来单独检查第 4 版缓存在起火初段的出现节奏和空隙分布，而不是继续看中后段的大体块形态。

### 00:33:25-00:35:50 生命周期、速度、缓存

- 本段定位：生命周期、速度、缓存。
- 知识点：之前先检查一下这个飘动感觉的速度吧。
- 知识点：这个不能太快出来。
- 知识点：这个现在在短生命周期里已经用了。
- 知识点：而且需要适当点亮的部分。
- 知识点：这个部分请留意一下看。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`。

**关键画面：**

这一张切回 `/obj/Fire02` 的 `pyrosolver1`，当前在 `Setup` 面板检查第二套火焰资源的基础模拟速度。节点网络没有变化，仍然是 `pyrosource1 -> ... -> pyrosolver1 -> filecache1 -> Render_Fire`。

右侧可确认的 `pyrosolver1` 参数为：

- `Voxel Size = 0.03`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1.5`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `CFL Condition` 已启用
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

节点标签下仍可见当前缓存文件是 `Ex_01_Skill_04.filecache1_v4.$F4.bgeo.sc`。结合字幕“这个不能太快出来”，这一步是在确认第二套火焰即使已经增强了速度场和横向风，整体 `Time Scale` 仍先保持在 `1.5`，避免起火和飘动节奏过快。
这张图继续在 `/obj/Fire02` 的 `pyrosolver1` 上微调整体动作速度，网络结构与上一张一致，但 `Setup` 面板里的时间缩放已经被下调。

当前可确认的参数为：

- `Voxel Size = 0.03`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 2`
- `Max Substeps = 3`
- `CFL Condition` 已启用
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

节点标签预览仍是 `Ex_01_Skill_04.filecache1_v4.$F4.bgeo.sc`。时间轴停在第 `40` 帧，左侧视口里的火焰主体已经发展出较完整的卷曲上升形态。与上一张相比，最关键的变化是把 `Time Scale` 从 `1.5` 降到 `1`，以减慢整体飘动与抬升速度，让第二套火焰的生命周期表现不要显得过急。
这张图继续回看 `/obj/Fire02` 的第 4 版缓存结果，节点链和 `filecache1` 设置没有新的可见变化，仍然是：

- `Version = 4`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`
- 当前缓存文件为 `Ex_01_Skill_04.filecache1_v4.$F4.bgeo.sc`

这一步的重点不是新增参数，而是直接检查长生命周期后段的视觉状态。时间轴已经来到第 `71` 帧，左侧视口中的火焰主体不再是前段的连续大体块，而是分裂成数团向上漂浮的亮部碎片和较薄的尾迹。结合本段“需要适当点亮的部分”和“短生命周期里已经用了”的语义，这张图用于确认在放慢整体动作之后，后段火焰是否还能保留足够的亮部残影，而不会太早完全熄灭。

### 00:36:03-00:38:59 UV、Fire、颜色

- 本段定位：UV、Fire、颜色。
- 知识点：再放大一点可以吗。
- 知识点：FIRE2号的渲染火焰。
- 知识点：UVBREAK 最终颜色。
- 知识点：现在差不多就完成了。
- 知识点：我们现在要用的资源。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`、`火焰`。

**关键画面：**

这一张回到 `/obj` 顶层对象视图，用来整理第二套火焰资源在场景中的最终摆放关系。中间网络面板中可见 4 个顶层对象：

- `Fire01`
- `cam_Fire_01`
- `Fire02`
- `cam_Fire_02`

当前选中的是 `Geometry` 对象 `Fire02`。右侧打开的是对象级 `Transform` 面板，可确认的值为：

- `Transform Order = Scale Rot Trans`
- 旋转顺序为 `Rx Ry Rz`
- `Translate = (0, 0, 0)`
- `Rotate = (0, 0, 0)`
- `Scale = (1, 1, 1)`
- `Pivot Translate = (0, 0, 0)`
- `Pivot Rotate = (0, 0, 0)`
- `Uniform Scale = 1`

左侧视口当前由 `cam_Fire_02` 观察，只能看到黑底上的几块小火焰亮斑，说明第二套火焰在这个镜头下已经接近最终取用状态。结合本段“再放大一点可以吗”“现在要用的资源”，这一步是在对象层面核对 `Fire02` 与 `cam_Fire_02` 的对应关系，并确认对象本身没有额外位移、旋转或缩放补偿。
这一张切到 `/out` 输出网络，当前选中的是 `Labs Flipbook Textures` 节点 `Render_Fire_02`。同级还能看到 `Render_Fire_01`，但这一步明确是在检查第二套火焰资源的最终输出设置。

`Render_Fire_02` 的 `Render` 面板中可确认：

- `Start/End/Inc = 1 / 80 / 1`
- `Camera = /obj/cam_Fire_02`
- `Pyro Bake Volume Path = /obj/Fire02/Render_Fire`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 x 8`
- `Total Resolution = 4096 x 4096`
- `Intermediate Directory = $HIP/render/${HIPNAME}_${OS}/intermediate`
- `Color Space = ACES sRGB (Best for Pyro)`

`Render Pass Control` 中仍保留多通道输出列表，包括 `Render Final Color`、`Render Non-emissive Color`、`Render MDC / MDC Normal`、`Render Surface Normal`、`Render Motion Vector`、`Render Depth`。这一步的关键是把第二套火焰输出节点正式绑定到 `cam_Fire_02` 与 `/obj/Fire02/Render_Fire`，形成可直接导出给 Niagara 使用的最终 flipbook 配置。
这一张进入最终火焰图集的预览与导出界面。主窗口是 `MPlay`，正在查看第二套火焰的整张 flipbook；右侧弹出了 `Save As` 对话框，说明这一步已经到了把资源正式导出的阶段。

从预览窗口可确认：

- 当前资源名显示为 `ip-14:10:29`
- 图集分辨率为 `4096 x 4096`
- 当前帧为 `fr:9`
- 整张纹理仍按 `8 x 8` 的 64 帧网格排列

从 `Save As` 对话框可确认：

- 当前操作是 `Save Frame 10 Of Flipbook Images`
- 默认文件名为 `$HIP/untitled$F4.tga`
- `Format = Targa`
- `Image Is = Unpremultiplied`
- `Resolution = Natural`
- `Color Space = Bake to OpenColorIO Display/View`
- `OCIO Display = sRGB - Display`
- `OCIO View = ACES 1.0 - SDR Video`

图集内容已经呈现完整的起火、抬升、卷曲和收尾过程，说明 `Render_Fire_02` 的最终颜色和火焰节奏已经基本定稿。结合本段“现在差不多就完成了”“我们现在要用的资源”，这一步可视为第二套火焰 flipbook 的最终确认与导出准备。

## 补充视觉证据

### S01 00:00:12

这是一张补充开场证据图，用于补足教程最前段的 Houdini 初始界面状态。当前位于 `/obj` 顶层对象视图，中间网络面板没有任何节点，界面中央显示 `Empty Network / Press Tab to Add Nodes`，右侧参数栏也提示 `No Operator Selected`。

可确认的状态只有：

- 当前路径为 `/obj`
- 未选中任何对象或节点
- 左侧视口为默认场景网格，没有启用相机视图
- 时间轴停在第 `1` 帧，总长度显示到 `240`

因此，这张补图的作用是说明教程开始时确实是从一个空的 `/obj` 网络起步，尚未创建 `Fire`、相机或任何 pyro 相关节点；它不是某个具体节点图或参数设置的补充细化。

### S06 00:15:00

这是一张针对 `S06` 段的补充参数证据图。当前位于 `/obj/Fire` 网络，主链完整可见为：

- `circle1 -> pyrosource1`
- 左支：`attribadjustvector1 -> attribnoise1 -> name1`
- 右支：`attribadjustfloat1 -> attribnoise2 -> pointjitter1 -> name2`
- 汇合后：`merge1 -> volumerasterizeattributes1 -> pyrosolver1 -> filecache1 -> Render_Fire`

右侧选中的是 `filecache1`，可确认的参数为：

- `Load from Disk` 已启用。
- `Base Name = Ex_01_Skill_04.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Simulation` 已启用。
- `Start/End/Inc = 1 / 80 / 1`

节点标签预览显示当前回放文件是 `Ex_01_Skill_04.filecache1_v2.$F4.bgeo.sc`。时间轴停在第 `57` 帧，左侧视口里的火焰上部形成较宽的拱顶，中下部有多股垂下的亮带。这张补图的价值在于更清楚地证明：教程中期比较的缓存版本确实是 `v2`，而且是在回放第 `57` 帧附近的中段形态，而不是重新模拟或调整别的节点。

### S07 00:19:20

这是一张针对 `S07` 段的输出网络补充证据图。当前位于 `/out`，中间网络面板中可以同时看到两套火焰输出节点：

- `Render_Fire_01`
- `Render_Fire_02`

当前选中的是 `Labs Flipbook Textures` 节点 `Render_Fire_01`。右侧 `Render` 面板可确认：

- `Start/End/Inc = 1 / 80 / 1`
- `Camera = /obj/cam_Fire_01`
- `Pyro Bake Volume Path = /obj/Fire/Render_Fire`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 x 8`
- `Total Resolution = 4096 x 4096`
- `Intermediate Directory = $HIP/render/${HIPNAME}_${OS}/intermediate`
- `Color Space = ACES sRGB (Best for Pyro)`

左侧视口中仍是 `cam_Fire_01` 视角下的黑底预览，底部只出现很小的起火亮带。这张补图的重要信息不是新的参数，而是把两个输出节点同时摆在同一画面里，明确证明教程后段已经并行维护 `Render_Fire_01` 与 `Render_Fire_02` 两套 flipbook 输出，而当前这张参数面板对应的是第一套火焰资源。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


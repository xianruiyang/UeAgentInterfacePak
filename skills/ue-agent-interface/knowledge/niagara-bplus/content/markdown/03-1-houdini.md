# 03-1-Houdini火焰求解器模拟

# 03-1-Houdini火焰求解器模拟

## 关键术语

- `Collision`、`GPU`、`Add`、`Houdini`、`PS`、`SD`、`Smoke`、`Water`、`精灵`、`碰撞`、`速度`、`Niagara`、`Normalized Age`、`Material`、`生命周期`、`颜色`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:04-00:04:58 PS、Smoke、缓存

- 本段定位：PS、Smoke、缓存。
- 知识点：你好,我是陈和 这次我们来正式看看Pyro服务器的选项是如何运作的 然后上次我们简单了解了Pyro模拟的基本结构和体积概念 就是这次我们更详细地看看有哪些具体选项以及如何控制它们。
- 知识点：看看吧,以例子打开PyroConf 我也build light smoke 做一个,现在看看数值 一起看看 这里有很多标签,就是我们要重点看的部分是。
- 知识点：原部分字段和形状,这部分好像最重要 选项也最多,像形状这种部分 但是选项太多,也不用太害怕 StairSight 从一开始的话,就关于统一设置看一下的话。
- 知识点：在那之前,现在学习说是的部分是,平直觉想就行 我家框架怎么用,整体用户名是MainChange 当然我们得用一帧 做视频的人每场戏帧数都不同。
- 知识点：有理由改,但我们是做短片素材的 那部分应该很少需要修改 而且在全局动画选项中,我们一般会把FPS改成30帧 这样应该嘛 然后现在在这里下面,设定帧范围。
- 知识点：设定开始和结束帧范围后,点击应用就能看到变化 现在这样打开显示,然后求解器那边 这样移动帧的话,会断断续续地断开 因为它在计算,所以会这样断开。
- 知识点：快速按下ESC键的话,虽然会这样出错 但重新回退的话,真回退的话,就会重新计算 所以看到回到原来的状态就是还Reset Simulation这种情况。

**关键画面：**

这张图是本节 “Houdini 火焰求解器模拟” 的起始界面，用来说明教程从一个空的 Houdini 对象层级开始，随后会逐步讲解 Pyro Solver 的各项选项，而不是直接从已经搭好的节点网络切入。

左侧视口显示默认地面网格，没有任何几何体、体积边界或烟火效果；时间轴停在第 1 帧。中间网络面板当前为空，画面中央明确显示 `Empty Network` 与 `Press Tab to Add Nodes`，说明当前 `/obj` 层级里还没有创建对象节点。

从界面状态可以确认：

- 当前工作上下文是 `obj`
- 场景还处于初始状态
- 右侧参数面板没有选中任何操作器，因此不显示具体参数

这张图的作用是交代后续讲解的起点：教程接下来会以一个空场景为基础，通过示例工程或预设逐步引入 `Pyro Solver`、体积源和缓存相关设置，让读者把注意力放在“选项如何运作”而不是现成效果本身。
这张图说明教程是用一个 `billowy smoke` 预设链作为示例，同时强调在观察 Pyro Solver 选项前，先把全局动画的播放帧率与起止帧范围设好，否则拖动时间轴时会因为重新计算而频繁中断。

左侧视口中已经能看到一团大范围扩散的浅棕色烟雾。左下角弹出了 `Global Animation Options` 面板，可确认的动画设置为：

- `FPS`：`30`
- `Start`：`1`
- `End`：`100`
- 勾选 `Restrict playback range`
- `CHOP Motion Samples`：`10`
- 下方显示项中，`Show Range Slider`、`Show Audio`、`Show Simulation Cache`、`Show Animation Toolbar`、`Show Ticks`、`Show Keys`、`Show Bookmarks` 处于可见/勾选状态
- 播放模式区域选择的是按帧逐帧播放的实时模式，说明这里主要用于检查模拟过程而不是离线渲染

中间网络展示了一条完整的 billowy smoke 链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中的是 `pyrosolver_billowy_smoke`，位于 `Setup` 页签，可确认的参数为：

- `Voxel Size`：`0.1`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`

`Simulation` 区域可确认：

- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Disabled`
- 勾选 `Cache Memory (MB)`，数值为 `5000`

这张图的核心含义是：在讲 Pyro Solver 选项前，教程先把“项目时间基准”和“求解器默认分辨率/步进方式”固定下来。`30 FPS` 与 `1-100` 的帧范围决定了后续缓存和回放的时间窗口，而 `Voxel Size`、`Substeps`、`Simulation Type` 则决定了示例烟雾在这个时间窗口中的基础计算精度与速度。
这张图是在同一条 `billowy smoke` 示例链上，单独把注意力集中到 `Pyro Solver` 的 `Voxel Size` 参数，用来说明教程口中的“分区大小 / 粉碎大小”本质上就是体积求解的体素尺寸。

左侧视口里只显示一个较小的棕色环状烟团，包在体积边界框内，时间轴停在第 1 帧。相比上一张的大范围烟雾，这里更像是在起始阶段观察低分辨率下的源体积形状。

中间网络仍然是同一条主链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，仍在 `Setup` 页签。截图可确认的关键参数为：

- `Voxel Size`：`0.1`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`
- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Disabled`
- `Cache Memory (MB)`：`5000`

结合本段上下文，这张图重点传达的是：

- `Voxel Size` 越大，体积网格越粗，预览和调参更快
- `Voxel Size` 越小，体积细节越多，但计算与缓存成本会上升
- 教程建议先用较大的体素尺寸快速观察形状，满意后再逐步减小，以避免一开始就在高精度下反复等待重算

因此，这张图不是在引入新的节点结构，而是在把 `Pyro Solver` 里最基础、也最影响工作速度的分辨率参数单独拎出来解释。

### 00:04:58-00:09:39 GPU、速度

- 本段定位：GPU、速度。
- 知识点：这是个要小心处理的选项 因此强烈建议一点点慢慢降低 还有我们为了确认某些数值的变化 请不要以低粉碎尺寸的状态来看 请不要以低粉碎尺寸的状态来看。
- 知识点：在测试某些数值时 请以稍快速度的粉碎尺寸来进行确认 觉得速度有点快的时候 先确立一下这个粉碎尺寸 然后觉得形状满意了 就降低粉碎尺寸最后。
- 知识点：确认一下 觉得满意了 就是就可以进行渲染了 在低状态下确认 虽然会更准确 但等待时间会很长 我们不能忽视速度的效率。
- 知识点：为了高效的工作速度 这样 负印尺寸 大的负印尺寸吧 低分辨率可能 清环境下一定要测试看看 最后调整式 建议适当降低粉碎大小来看 而且当负质尺寸变小时。
- 知识点：细节会更明显的问题 也有 这种体积的分割 细节都很好地表现出来 所以在这里的形状上 为了突出某种细节 为了保留体积的细节 数值给得比较强 降低负荷尺寸。
- 知识点：那可能会更突出 所以这不一定是 在表达上 大好的表达上唯一好的 所以适当的值 数字感 很重要 还有时间尺度相关的选项 就是模拟速度。
- 知识点：当然放大用的 做到这种程度时 可观察到进展更快 但做到这种程度时 所有领域都 现在关于这种衰减量的 字段或 本面计划 时针团流这些字段 现在都以二倍速度进行。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`速度`。

**关键画面：**

这张图继续围绕 `GPU、速度` 小节讲“先用合适分辨率测试，再逐步细化”的原则。与上一批相比，这里把 `pyrosolver_billowy_smoke` 的体素尺寸从 `0.1` 降到了 `0.05`，用来展示更细网格下的预览状态。

左侧视口仍是包围盒内的小型环状烟源，时间轴停在第 1 帧。因为还处于初始帧，所以烟雾形状本身变化不大，重点在右侧求解器参数。

中间网络仍是同一条 billowy smoke 链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，在 `Setup` 页签下可确认：

- `Voxel Size`：`0.05`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`
- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Disabled`
- `Cache Memory (MB)`：`5000`

这张图的意义在于明确“测试数值变化时，不要一开始就把分区做到很细”。虽然这里已经把 `Voxel Size` 降到 `0.05`，但依然是为了在可接受的速度下观察更细的形态趋势，而不是直接切到最高精度。教程想强调的是：分辨率越细，等待和缓存压力越大，因此应该在速度和细节之间逐步收敛。
这张图把“速度”这个主题明确落到 `Pyro Solver` 的 `Time Scale` 参数上。教程在这里说明，除了分辨率影响工作效率外，模拟本身的时间缩放也会直接改变烟雾演化速度。

左侧视口依然是包围盒内的环状烟源，时间轴当前在第 3 帧，说明这里开始通过播放前几帧来观察时间参数变化对模拟推进速度的影响。

中间网络没有变化，仍是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，在 `Setup` 页签下可确认：

- `Voxel Size`：`0.1`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`
- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Disabled`
- `Cache Memory (MB)`：`5000`

这张图的重点不是新的数值结果，而是概念说明：`Time Scale` 控制的是整个模拟推进速度。保持 `1` 时，体积字段按正常时间流逝更新；如果后续提高这个值，温度、速度、衰减和体积移动都会整体加快；降低则会让烟雾演化变慢。因此它不是单个外观参数，而是影响所有相关场动态节奏的全局时间倍率。
这张图展示的是同一 billowy smoke 示例在 GPU/OpenCL 模式下的求解器设置，用来对比 CPU 稀疏模式与 GPU 模式的工作方式差异。

左侧视口中的烟团已经推进到后续帧，时间轴位于第 33 帧，画面里能看到烟团贴近地面一侧的卷动形状。包围盒仍在，但求解已经进入中段，不再只是初始环状源。

中间网络仍未改变，依然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前仍选中 `pyrosolver_billowy_smoke`，在 `Setup` 页签下可确认：

- `Voxel Size`：`0.1`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`

`Simulation` 区域的关键变化为：

- `Simulation Type`：`Minimal OpenCL`
- `Global Substeps`：该项在当前模式下变灰，不再可调
- `Min Substeps`：该项在当前模式下变灰，不再可调
- `Max Substeps`：`1`
- `CFL Condition`：该项变灰
- `Advection-Reflection`：`Disabled`
- `Cache Memory (MB)`：该项可见但在当前模式下表现为不可调/弱化状态

这张图的关键结论是：切到 GPU/OpenCL 模式后，并不是所有 CPU 稀疏模式下的选项都还能自由使用。部分子步进和 CFL 相关控制会被简化或禁用，换来的则是潜在的更高计算速度。因此教程在这里提醒，GPU 模式更适合追求速度的试验场景，但可控性、稳定性和显存/缓存限制都需要单独评估，不能默认它比 CPU 模式更适合所有效果。

### 00:09:39-00:14:20 GPU、速度、烟雾

- 本段定位：GPU、速度、烟雾。
- 知识点：如果内存分配有点负担的话 就重新加载了 所以这个GPU模式 不太推荐 在太高性能的模式 现在我和录制程序一起运行 好像有点崩溃了 所以小心使用应该。
- 知识点：如果真不进行 动画不进行 那可能是超过了缓存内存 GPU内存的这个限度 在工作 所以还是保守一点 看比较好 基本上采用了西服模式 这是新出的模拟火箭求解器。
- 知识点：新版本 还有密集模式 我们可观察到 在边界框上 我们可观察到 在边界框内生成体积 西服模式是在这个边界框内 只在这个边界框区域内 真正需要计算的部分进行计算。
- 知识点：让空的部分就不计算了 速度效率更快 可以看作是这种模式 而这种密集模式 则是整个区域都计算 所以选择密集模式工作的情况 几乎不会有 我们只用西服模式就足够了。
- 知识点：虽然视频那边可以用密集模式 但总的来说 算是更重的模式 算是能表现更多细节的模式 平流 然后反射 这样情况现在作为单项目来处理的话 现在单项目大概是这种。
- 知识点：在模拟中烟雾这样卷进去的 动作更加强化的选项 这个灰炭反射值要不要重复一次 如果是双倍的话就要来回两次 双倍的话性能当然会提升 然后负担也会增加。
- 知识点：建议在使用这个模式时 用单项目 然后根据这里的步数 感觉存储值会有所不同 在速度非常快的情况下需要模拟。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`速度`、`烟雾`。

**关键画面：**

这张图是在讨论 GPU 模式负担后，重新回到更保守的稀疏模式示例界面。教程想表达的是：当 GPU/OpenCL 模式带来重载、重算或稳定性问题时，`Sparse` 模式通常是更稳妥的默认选择。

左侧视口中是包围盒内的环状烟源起始形态，时间轴停在第 1 帧。说明这里重新回到最基础的 billowy smoke 初始状态，以便说明求解模式本身，而不是继续展示中段模拟结果。

中间网络仍然是同一条 billowy smoke 主链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Setup` 页签，可确认参数为：

- `Voxel Size`：`0.1`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`
- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Disabled`
- `Cache Memory (MB)`：`5000`

这张图的重点不是新参数，而是模式选择结论：对这类普通烟雾案例，`Sparse` 只在边界框内真正有体积活动的区域做计算，空区域不参与求解，因此通常已经足够快，也更稳定。结合本段旁白，它是对“GPU 模式不一定值得默认开启”的直接佐证。
这张图把讨论重点转到 `Advection-Reflection`，也就是教程所说会增强烟雾回卷、卷吸感的反射/投影式平流选项。

左侧视口里烟雾已经发展成更明显的卷曲柱状体，时间轴位于第 51 帧，说明这是用来观察中段烟雾形态受平流设置影响的对比画面，而不是初始源形。

中间网络依然保持同一条主链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Setup` 页签，当前能确认：

- `Simulation Type`：`Sparse`
- `Voxel Size`：`0.1`
- `Time Scale`：`1`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`1`
- `CFL Condition`：`1`

`Advection-Reflection` 下拉菜单已展开，截图中可见三个可选值：

- `Disabled`
- `Single-Project`
- `Double-Project`

当前被高亮/选中的值是 `Disabled`，但教程此处显然在讲解如果切到 `Single-Project` 或 `Double-Project` 会如何影响卷吸感。

这张图的核心含义是：`Advection-Reflection` 不是分辨率或速度参数，而是影响烟雾内部回卷结构的求解选项。`Single-Project` 可以在性能和形态之间取得较平衡的强化效果；`Double-Project` 会更重，但会进一步增强烟雾来回卷动、吸附与反冲的感觉。教程因此建议默认优先考虑 `Single-Project`，只有在确实需要更强卷动细节时才提高到更重的模式。
这张图把重点从求解方式切到边界盒本身的空间控制，当前打开的是 `Bounds` 页签，用来说明 Pyro 边界框的中心与尺寸如何围住烟雾主体，以及为什么稀疏模式依赖合理的边界空间。

左侧视口中烟雾已经卷成较紧凑的团块，位于边界盒左下区域，时间轴在第 36 帧。可以直接看出烟雾主体并不位于盒子正中心，因此右侧正在调整的 `Center` 参数就是为了让边界空间更贴合模拟主体。

中间网络仍然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Bounds` 页签。截图中可确认：

- `Size` 区域存在 `Limit Maximum Size`
- 当前三轴尺寸数值可读为：
  - `13.5`
  - `8.7`
  - `12`
- `Center`：
  - `X = 4`
  - `Y = 7.5`
  - `Z = -1`
- `Resizing`：`1`

这张图的重点是：在稀疏模式下，求解器不会无条件计算整个大空间，而是围绕这个边界盒及其动态重整区域工作。因此：

- `Size` 决定了初始可计算体积的覆盖范围
- `Center` 决定这个体积框在世界/对象空间中的落点
- `Resizing` 控制边界是否按烟雾运动自动扩张或调整

结合画面左侧烟雾明显偏向盒体一侧的状态，教程这里实际上是在提醒：边界中心若放得不对，烟雾很容易顶到盒体边缘，影响形态甚至引发不必要的重整与性能损耗；所以需要根据烟雾主运动区域主动检查并校正中心位置。

### 00:14:20-00:19:09 Collision、SD、碰撞

- 本段定位：Collision、SD、碰撞。
- 知识点：填充值是指现在烟雾和边界框边缘之间的空间值 所以如果填充值低的话 那个盒子紧贴着可观察到那个烟雾重新生成 这样刚好碰到的时候 可以看作是留白的厚度感。
- 知识点：调整大小时 通常一左右不需要太大改动 在这次讲座中我们好像要韩国 因为不会使用科文手 所以不需要详细了解 像这里的Ground Plates。
- 知识点：地面虽然看不见 可以看作是虚拟创建地面碰撞体的选项 所以如果在这里选择Close Below 这里就可以看作是生成的地面 以Y轴为基准。
- 知识点：测试一次的话 以X轴为基准进行Close的话 就可观察到这里被切断了 转过来切的话 这里会碰撞 像被推开一样 然后烟会这样移动 这种时候也会需要的。
- 知识点：碰撞效果可用不可见碰撞体或场景几何验证，重点检查碰撞响应和粒子消亡逻辑。
- 知识点：Volume 这样做好输入就行 然后在这个碰撞类型中如何碰撞 如果用几何体的话 可以理解为基于表面发现进行 碰撞的这种方式 Sighted。
- 知识点：Area体积是上次我们提到的 一种体积 Sighted Area调缘距离场方式的体积 所以这个是找到边界值的一种体积 现在做好输入 用这个模型。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Collision`、`粒子`、`碰撞`、`烟雾`。

**关键画面：**

这张图讲的是稀疏边界盒在模拟过程中如何自动扩张，以及 `Padding` 留白对烟雾碰到边界前缓冲空间的影响。结合本段旁白，教程在这里强调：边界盒不要刚好贴住烟雾主体，否则会导致重整、截切或形态异常。

左侧视口中的烟雾已经发展为一团向右上翻卷的柱状体，时间轴在第 75 帧。可以看到烟团已经接近边界盒左侧和上侧区域，这正是需要检查边界留白的典型场景。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Bounds` 页签。截图中可确认：

- `Size`
  - `13.5`
  - `8.7`
  - `12`
- `Center`
  - `X = 4`
  - `Y = 7.5`
  - `Z = -1`

`Resizing` 区域可确认：

- `Padding`：`1`
- `Reference Fields`：`density flame`
- `Extra Fields`：空
- 勾选 `Resize in Full Tiles`
- 未勾选 `Extrapolate Velocity into New Tiles`
- 未勾选 `Expand by Velocity`

这张图的关键含义是：

- `Padding` 决定烟雾与边界盒边缘之间预留多少安全空间
- `Reference Fields` 指定用哪些体积场来判断“哪里需要扩张边界”
- `Resize in Full Tiles` 会让边界按完整 tile 扩展，而不是每次做很碎的小范围变化

也就是说，教程这里是在解释边界盒为什么不会紧贴烟雾表面：需要给 `density`、`flame` 这些真实有效体积留出足够余量，避免烟雾刚碰到边界就触发频繁重整或被切掉。
这张图进入 `Collision` 页签，开始说明 Pyro Solver 如何读取碰撞体，以及如何不用可见几何也能快速构建地面碰撞平面。

左侧视口里只有一个较小的环状烟源和缩小后的边界盒，时间轴停在第 1 帧，说明这里在讲碰撞配置本身，而不是展示碰撞后的动态结果。

中间网络仍然没有新增独立碰撞节点，说明此处的碰撞设置是直接在 `pyrosolver_billowy_smoke` 内部完成的：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Collision` 页签。截图中可确认：

- `Activation`：`1`
- `Collision Type`：`Collision Geometry`
- `Collision Voxel Size`：`0.1`
- `Collision Offset`：`0`
- `Velocity Scale`：`1`
- 勾选 `Use Deforming Geometry`

`Ground Planes` 区域可确认：

- `X Ground Plane`：`Open`
- `Y Ground Plane`：`Open`
- `Z Ground Plane`：`Open`

下方还能看到 `Height Field` 相关区域，但当前未启用。

这张图的重点是：Pyro 的碰撞不一定非要依赖场景里真正摆出的模型，也可以通过求解器内部的 `Ground Plane` 快速指定某个坐标轴方向上的“封闭面/地面”。当需要与真实模型碰撞时，`Collision Type` 可以使用 `Collision Geometry`；而如果只需要一个简单的地面阻挡，则直接在这里把对应轴向从 `Open` 改成封闭模式即可。
这张图虽然位于“碰撞”小节末尾，但右侧实际上切到了 `Sourcing` 页签，重点是源体积的生效帧范围与循环长度设置，解释为什么烟源会持续存在、重复发射，或者在指定帧后停止。

左侧视口里只有边界盒和一小团初始烟源，时间轴停在第 7 帧，说明当前仍处于源输入早期阶段，适合检查源是否按设定周期持续供给。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Sourcing` 页签。截图中可确认：

- `Source Type`：`Individual Volumes`
- 勾选 `Limit Source Range`
- `Range Type`：`Frame Range`
- `Frame Range`：`1` 到 `12`
- 勾选 `Cycle Length`
- `Cycle Length`：`12`

`Source Volumes` 区域可确认共有 `3` 组输入：

- `Source 1: density`
  - `Operation`：`Add`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`
- `Source 3: vel`
  - `Operation`：`Add`
  - `Source Volume`：`v`
  - `Target Field`：`vel`
  - `Source Scale`：`1`

这张图的关键含义是：烟源不是无限时长地持续写入求解器，而是可以通过 `Frame Range` 限定只在 `1-12` 帧之间生效，再用 `Cycle Length = 12` 把这段输入循环复用。这样既能制造规律性重复发射，又能避免源在不该持续存在的时候一直往解算里灌入 `density/temperature/velocity`，从而影响碰撞与体积衰减判断。

### 00:19:09-00:23:57 Add、Houdini、Water

- 本段定位：Add、Houdini、Water。
- 知识点：或者检查100也行 循环长度这种情况 现在从1到12帧的缘会一直重复 所以可能会有那样的差异 造生模式的重复 像这样发生的情况也能看到。
- 知识点：但现在的话 无论如何其实缘中最重要的是 怎么拿到这些字段最重要 我们现在基本上只用密度、温度、灰尘 这三个字段组成体积 现在在这里放进去。
- 知识点：基本上Density这种情况 在Add-Op-Place模式中 大部分会使用IAD 现在适当有多种模式 但我们最常了解的部分是 ID和什么草制造。
- 知识点：什么最大精灵这种程度应该会有吧 那样很多使用的应该没有吧 适当特别事项之外 这种情况是现在当前的原音量 加上定期继续注入给看就行 然后Bansteig值继续加上的。
- 知识点：基本上就是简单持续地让针不断增长 可以看作是不断添加燃料 这样理解应该 不过刚才把这个针区间设为12时 这些值会提供 但从13针开始就不提供了。
- 知识点：毕竟这是基于气体进行的气体模拟 可以看作是运行模拟的燃料之类的材料 原始然后这个温度现在是满的方式 ID和满的区别是 ID只是简单地继续增加。
- 知识点：满的情况是虽然增加但增加的速度 现在不是一下子突然改变 而是逐渐增加的方式 就是所以像温度这种 大部分情况下 现在不是一下子突然改变。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Add`、`Houdini`、`速度`、`颜色`、`烟雾`。

**关键画面：**

这张图继续讲 `Sourcing` 页签里的源持续时间控制，不过这次把生效帧范围扩展到了更长区间，用来说明“持续注入”和“短周期循环”在表现上的区别。

左侧视口里仍然是包围盒内的一小团初始烟源，时间轴停在第 1 帧，因此当前重点仍在右侧源设置，而不是烟雾动态结果。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Sourcing` 页签。截图中可确认：

- `Source Type`：`Individual Volumes`
- 勾选 `Limit Source Range`
- `Range Type`：`Frame Range`
- `Frame Range`：`1` 到 `100`
- `Cycle Length` 当前显示为 `12`，但该项在画面中是弱化/未激活状态

`Source Volumes` 区域仍是三组输入：

- `Source 1: density`
  - `Operation`：`Add`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`
- `Source 3: vel`
  - `Operation`：`Add`
  - `Source Volume`：`v`
  - `Target Field`：`vel`
  - `Source Scale`：`1`

这张图的核心含义是：如果把 `Frame Range` 拉长到 `1-100`，源会在更长时间内持续向求解器注入 `density`、`temperature` 和 `velocity`，效果上更接近“持续加燃料/持续供烟”；而不是只在 `1-12` 帧发射后立即停止。教程借这个对比说明，控制源是否不断补给，比单纯调外观参数更直接地决定烟量、热量和整体演化节奏。
这张图把注意力从“发射多久”转回“具体往求解器里注入什么”。教程在这里解释，Pyro 最核心的是拿到正确的场字段，尤其是 `density`、`temperature`、`velocity` 这三类基础体积输入。

左侧视口中的烟雾已经发展为一团较低矮的烟团，时间轴在第 25 帧，说明当前正处于源持续注入后的中早期阶段，适合观察这些字段共同作用后的形态。

中间网络没有变化，依然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Sourcing` 页签。截图中可确认：

- `Range Type`：`Frame Range`
- `Frame Range`：`1` 到 `12`
- `Cycle Length`：`12`

`Source Volumes` 区域共有 `3` 组输入，且每组运算方式都能直接读到：

- `Source 1: density`
  - `Operation`：`Add`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`
- `Source 3: vel`
  - `Operation`：`Add`
  - `Source Volume`：`v`
  - `Target Field`：`vel`
  - `Source Scale`：`1`

这张图的重点是说明这三类字段在气体模拟里的角色：

- `density` 像持续加入的“烟量/物质”
- `temperature` 像驱动浮升和热运动的“热量/燃料”
- `vel` 提供初始运动方向与速度

教程借此强调，很多外观看上去像“水、烟或加法发光差异”的效果，本质上先取决于这些底层字段的写入方式；如果底层字段给错了，后面再怎么调材质和渲染也很难得到正确体积行为。
这张图把话题从“往里注入什么字段”切到了“这些字段进入求解器后如何衰减、冷却和存活”。当前打开的是 `Fields` 页签，重点是 `Density`、`Temperature` 和 `Flame` 三类场的内部演化参数。

左侧视口中的烟雾处于第 23 帧，已经形成一团较稳定的低矮烟团，说明此时正适合观察场级参数对“持续存在”还是“逐渐消散”的影响。

中间网络依然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Fields` 页签。截图中能确认的设置包括：

- `Field Guides`：`No Guide`

`Density` 区域：

- `Dissipation`：`0.05`
- `Emit From Flame`：`1`

`Temperature` 区域：

- `Diffusion`：`0`
- `Cooling Rate`：`0.5`
- `Emit From Flame`：`1`

`Flame` 区域：

- `Flame Lifespan`：`2`

下方还可见 `Color` 与 `Speed` 分组，但当前截图里未展开具体参数。

这张图的关键含义是：

- `Dissipation` 控制烟雾密度随时间消散的速度
- `Cooling Rate` 控制温度衰减快慢，直接影响浮升与热驱动持续多久
- `Flame Lifespan` 决定火焰场在模拟里保留多长时间
- `Emit From Flame` 表示密度或温度可以继续从火焰场派生出来

教程在这里实际是在说明，体积“不会突然消失”或“能维持多久”，并不只由源发射帧数决定，还强烈依赖这些字段自身的衰减规则。也就是说，前面源输入像是在加材料，这一页则是在定义材料进入系统后如何被消耗、冷却和延续。

### 00:23:57-00:28:39 生命周期、速度、颜色

- 本段定位：生命周期、速度、颜色。
- 知识点：选择想看的字段时 比如Volosity 旁边可观察到新生成的这个东西 视觉上可观察到我选的字段是怎么运作的 可以看作是Visualization选项。
- 知识点：原来以前现在选模一时 在这里网络里 进去看的话 烟雾对象里 这里可视化选项这么详细来着 但这部分适当简化了一下放在这边 所以需要确认一下温度吧。
- 知识点：因为Bright 所以可以看作是从0到1 可观察到温度下降时颜色会变成这样 是的这样确认 我们拿到的视觉效果比想象中要简单的多。
- 知识点：毕竟我们是把表演的一部分烘焙后带走的 所以现在的视觉效果在某些方面 也可以作为有用的资源来使用 不过做视频的人可能会想 这能用在哪呢。
- 知识点：因为这是非常粗糙的烟雾效果 从现在的状态来看 做视频的人看的话在那个标准下 但是在游戏这边 适当地混合使用这些东西的话 肯定会有看起来不错的时候。
- 知识点：眼睛的指南那个部分 是 所以这部分可以这样看 现在最重要的选项之一是分散 这部分应该是 现在我详细地讲一下这个是什么的 看这里的话可以看作是分为。
- 知识点：密度、温度、火焰、速度 现在先看看密度部分 分散强固现在是0.05 这个直观来说就是烟雾消失的速度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`、`颜色`、`烟雾`、`火焰`。

**关键画面：**

这张图开始讲 `Field Guides` 可视化，也就是把求解器内部的某个字段单独显示出来，帮助判断温度、密度、火焰或速度到底是如何在体积里分布和变化的。

左侧视口中同时出现了两组内容：

- 左侧是正常着色后的灰褐色烟团
- 右侧是一个彩色的字段可视化团块，颜色从蓝紫、青绿到黄色渐变

这说明当前不是单纯看最终烟雾外观，而是在拿字段引导结果与实际烟雾形态做对照。时间轴位于第 20 帧。

中间网络仍然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Fields` 页签。`Field Guides` 区域的下拉菜单已展开，能可靠读到可选项包括：

- `No Guide`
- `Density`
- `Temperature`
- `Flame`
- `Velocity`
- `Speed`
- `Divergence`
- `Pressure`
- `Collision`
- `Voxel Size`
- `Bounding Box`
- `Active Region`

当前上方显示的字段类型是 `Temperature`，并且右侧模式为 `3D`。同一区域还能确认：

- `Guide Range`：`1`
- 右侧有 `Compute Range`
- `Color Mappings` 使用了多段渐变色带

下方还能看到 `Density`、`Temperature`、`Flame`、`Color`、`Speed` 等分组，但当前重点是字段可视化本身。

这张图的核心作用是说明：当教程说“看速度、看温度、看颜色变化”时，并不是靠猜测最终烟雾外观，而是直接把对应字段可视化出来。这样就能明确判断：

- 温度高的区域在哪里
- 某个速度场是否真的朝预期方向推进
- 火焰或密度是否只集中在局部

这也是后面做生命周期、速度和颜色判断时最可靠的检查方式。
这张图是在 `Temperature` 字段引导模式下，继续观察烟雾进入中后段时的热量分布。相比上一张，这一帧更能看出哪些区域仍保持较高温度，哪些区域已经冷却成普通烟雾。

左侧视口中烟雾已经抬升并向右上扩散，时间轴位于第 94 帧。整个团块颜色比较淡，但仍能通过引导色带判断热区正在减弱，说明温度随时间逐步衰减。

中间网络仍为：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

画面右侧还额外出现一个 `dopnet1` 作为对照节点，但当前参数面板仍然属于 `pyrosolver_billowy_smoke`。

右侧 `Fields` 页签可确认：

- `Field Guide`：`Temperature`
- `3D` 显示模式
- `Guide Range`：`0` 到 `1`
- `Color Mappings` 使用从紫、青、绿到黄红的渐变色带

同页下还能确认的场参数包括：

- `Density -> Dissipation`：`0.05`
- `Temperature -> Diffusion`：`0`
- `Temperature -> Cooling Rate`：`0.5`
- `Flame -> Flame Lifespan`：`2`

这张图的意义在于说明：温度字段可视化不是只为了“好看”，而是能直接验证 `Cooling Rate` 是否让热量按预期衰减。到了较晚帧，如果高温颜色还停留在不该存在的区域，就意味着温度保持过久；反过来如果热区太快消失，烟雾会失去上升动力。教程因此把字段可视化作为调生命周期、速度、颜色前的基础诊断工具。
这张图从字段显示切换到了 `Shape` 页签，开始讲真正驱动烟雾形态变化的运动项，包括浮升、风、扰动和湍流。它承接前面的“看字段”，进入“如何改变形状”的具体参数层面。

左侧视口中的烟雾已经卷成连续上升的柱状团块，时间轴位于第 66 帧。这个阶段的烟雾形态更适合观察扰动、风向和浮升对轮廓的影响，因为烟柱已经形成明显的分层卷积。

中间网络依然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。截图中能可靠确认：

- `Shape Guides`：`No Guide`
- `Buoyancy`：`0.1`
- `Wind`：`2`

`Disturbance` 区域：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Roughness`：`0.5`
- `Pulse Length`：`0.2`
- `Max Octaves`：`3`
- `Lacunarity`：`2.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- 勾选 `Use Control Field`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`
- 右侧有 `Compute Range`
- 可见 `Remap Control Field` 选项

下方还能确认：

- `Turbulence`：`0.25`
- `Shredding`、`Flame Expansion`、`Viscosity` 分组存在，但当前未展开完整参数

这张图的关键含义是：前面的生命周期、温度和密度决定“材料是否存在”，而这里的 `Shape` 参数决定“它怎么动、怎么卷、怎么碎”。其中：

- `Buoyancy` 决定整体上升趋势
- `Wind` 提供整体定向推动
- `Disturbance` 在局部制造细碎卷积
- `Turbulence` 进一步打破平滑流场

尤其是当前把 `speed` 作为 `Control Field`，说明扰动强度不是在所有区域平均施加，而是会根据速度场分布被调制。这正是教程提到“现在用的控制字段不一样了”的具体体现。

### 00:28:39-00:30:20 速度、扰动

- 本段定位：速度、扰动。
- 知识点：我不小心按到了 这时候按ES 再重新做一下就行了 控制字段里有不同的字段 字段的进行和联想作用 这个数值的强度会不同 比如turbureance现在有density。
- 知识点：density密度高的地方 turbureance强度更大 密度低的部分会应用团流 密度低的部分会应用团流 密度低的部分团流的力量就会适当小一些。
- 知识点：这样想 应用于扰动的这个速度长也是一样 为了热量性的这个速度尝试 如果不勾选这个的话 速度字段就不会生成。
- 知识点：这个没有单独的选项 只要在这里勾选表示要新建速度字段 就可以使用了 使用这个字段实例不会生成速度这个字段。
- 知识点：可以认为在这里勾选字段是为了写入使用 所以在速度快的部分 现在这个distance的强度会强一些 在速度慢的部分。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`。

**关键画面：**

这张图是在“速度、扰动”段里继续讲“控制字段”概念：某个参数的强度可以不再是常量，而是由另一个字段来调制。当前展示的是 `Density -> Dissipation` 被 `temperature` 字段控制的情况。

左侧视口当前没有显示烟雾结果，时间轴位于第 66 帧。说明这里更像是在调参或查看字段关系，而不是观察最终体积外观。画面左下还出现了一个红色三角警告图标，但截图未显示其具体错误文本，因此这里只能确认有警告状态存在，不能进一步推断原因。

中间网络仍然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

画面右侧还保留一个 `dopnet1` 作为对照节点，但当前参数面板仍属于 `pyrosolver_billowy_smoke`。

右侧 `Fields` 页签中，当前展开的是 `Density` 区域，可确认：

- `Dissipation`：`0.05`
- `Clamp Below`：`0.005`
- 勾选 `Use Control Field`
- `Control Field`：`temperature`
- `Control Range`：`0` 到 `1`
- 右侧有 `Compute Range`
- 勾选 `Remap Control Field`
- 下方显示了一条从高到低逐渐衰减的 `Control Ramp`

同页中还能看到但未展开的分组：

- `Emit From Flame`
- `Temperature`
- `Flame`
- `Color`
- `Speed`

这张图的关键含义是：`Dissipation` 并不一定在所有烟雾区域都按同样速率生效。把 `temperature` 当作控制字段后，热区和冷区可以拥有不同的密度消散强度。也就是说，烟雾会不会“散得快”、是否只在冷却后快速消失，可以通过其他字段来间接驱动，而不是只能靠一个固定数值。
这张图回到 `Shape` 页签，继续解释“控制字段”如何作用到扰动与湍流，而不只是作用于消散。教程在这里强调，速度快、密度高或温度高的地方，可以通过控制字段获得更强的形态噪声。

左侧视口中烟柱已经形成明显的分段卷曲，时间轴位于第 33 帧。这个阶段的形态变化足够明显，适合拿来判断扰动是否只在该强的地方增强。

中间网络仍是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。截图中可确认：

- `Buoyancy`：`0.1`
- `Wind`：`2`

`Disturbance` 区域：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Roughness`：`0.5`
- `Pulse Length`：`0.2`
- `Max Octaves`：`3`
- `Lacunarity`：`2.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- 勾选 `Use Control Field`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

`Turbulence` 区域能确认：

- `Noise Type`：`Analytic Fast Simplex Noise`
- `Turbulence`：`0.25`
- `Swirl Size`：`2`
- `Roughness`：`0.5`
- `Pulse Length`：`0.5`
- `Max Octaves`：`2`
- `Seed`：`6`
- `Threshold Field`：`temperature`
- `Threshold Range`：`0.1` 到 `0`
- 勾选 `Use Control Field`
- `Control Field`：`density`
- `Control Range`：`0` 到 `1`

这张图的关键结论是：教程并不是简单地把噪声平均撒到整个烟体里，而是通过两层筛选来控制噪声分布：

- 先用 `Threshold Field` 决定哪些区域有资格受到作用
- 再用 `Control Field` 按场强度调制最终效果强弱

因此，高速区域可以获得更强的 `Disturbance`，高密度或高温区域也可以单独增强 `Turbulence`。这正是本段“速度、扰动”真正想表达的核心。
这张图继续停留在 `Shape` 页签，但把时间轴拉回到第 1 帧，目的是在最简单的初始烟团状态下单独检查控制字段、控制范围和阈值设置，而不让后续模拟形态干扰判断。

左侧视口只显示边界盒里的一小团初始烟源，时间轴为第 1 帧。由于形态非常简单，这一帧适合验证“参数逻辑是否合理”，而不是看最终艺术效果。

中间网络仍然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板仍属于 `pyrosolver_billowy_smoke` 的 `Shape` 页签，可确认：

- `Buoyancy`：`0.1`
- `Wind`：`2`

`Disturbance` 区域：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Roughness`：`0.5`
- `Pulse Length`：`0.2`
- `Max Octaves`：`3`
- `Lacunarity`：`2.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- 勾选 `Use Control Field`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

`Turbulence` 区域：

- `Noise Type`：`Analytic Fast Simplex Noise`
- `Turbulence`：`0.25`
- `Swirl Size`：`2`
- `Roughness`：`0.5`
- `Pulse Length`：`0.5`
- `Max Octaves`：`2`
- `Seed`：`6`
- `Threshold Field`：`temperature`
- `Threshold Range`：`0.1` 到 `0`
- 勾选 `Use Control Field`
- `Control Field`：`density`
- `Control Range`：`0` 到 `1`

这张图的重点是把本段逻辑收束成一个明确原则：控制字段系统允许把“哪里有资格受影响”和“受影响强度有多大”拆开处理。初始帧虽然看不到完整卷曲结果，但最容易检查这些阈值与范围是否设置得过大或过小，因此教程在这一帧回头确认，是为了避免后面把形态问题误判成渲染问题。

## 补充视觉证据

### DOC 00:23:16

这张补充图是对 `pyrosolver_billowy_smoke` 的 `Fields` 页签做的静态补证，重点不是新增流程，而是把前文提到的密度、温度和火焰场参数在一个更干净的界面里固定下来，便于后续复查。

左侧视口中的烟雾处于较早阶段，时间轴位于第 23 帧，显示的是一团低矮的烟团。由于没有字段引导色和额外展开菜单干扰，这张补图更适合直接读取右侧参数。

中间网络仍然保持同一条 billowy smoke 主链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Fields` 页签。截图中可确认：

- `Field Guides`：`No Guide`

`Density` 区域：

- `Dissipation`：`0.05`
- `Emit From Flame`：`1`

`Temperature` 区域：

- `Diffusion`：`0`
- `Cooling Rate`：`0.5`
- `Emit From Flame`：`1`

`Flame` 区域：

- `Flame Lifespan`：`2`

下方还能看到 `Color` 与 `Speed` 分组处于折叠状态，但当前图没有展开它们的内部参数。

这张图的价值在于把本段最基础、最常需要复查的三个字段参数集中定格下来：

- `Dissipation` 决定烟雾密度消散速度
- `Cooling Rate` 决定温度衰减速度
- `Flame Lifespan` 决定火焰场保留时间

它和前面的主图一起说明，生命周期、颜色和速度相关的视觉差异，本质上仍然是由这些底层场参数共同决定的，而不是单独靠渲染节点去“补”出来。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


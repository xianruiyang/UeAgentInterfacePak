# 03-2-Houdini火焰求解器模拟

# 03-2-Houdini火焰求解器模拟

## 关键术语

- `Velocity`、`UV`、`Houdini`、`Smoke`、`Noise`、`粒子`、`系统`、`精灵`、`碰撞`、`速度`、`Niagara`、`Normalized Age`、`Material`、`纹理`、`生命周期`、`颜色`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:02:58 速度

- 本段定位：速度。
- 知识点：使用这个字段是为了在这里进行写入 所以这个字段其实已经勾选好了 所以在速度快的部分干扰器的强度就会更强。
- 知识点：在速度较慢的部分强度就会较低 相反这里的温度调节器也是一样 可以看作是引起连锁反应的部分 现在这里写着 Amidst from Plane。
- 知识点：的部分 就是这里也有 这里也有 这不现在 所以是指火元素 所以那种火或爆炸 火的热量 现在因为火 因为火焰要生成额外的密度吗 嗯 是否要创建这种温度字段。
- 知识点：可以看作是那样的选项 是二次生产 由于火灾的发生 是否要在那里额外生成烟雾 可以看作是那样的选项 这里的火焰选项非常简单 只有生命值。
- 知识点：这部分变长的话火的持续时间会更久 如果短的话火会很快出现 然后消失 然后生命值高的话 嗯 就是火的维持时间会更长 速度刚才说过生成领域。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`、`烟雾`、`火焰`。

**关键画面：**

这张图承接上一页的“速度、扰动”主题，继续说明为什么把 `speed` 作为控制字段后，速度快的区域会获得更强的扰动强度。

左侧视口只显示一个初始小烟团与边界盒，时间轴停在第 1 帧。教程在这里故意回到最简单的起始状态，是为了单独说明参数逻辑，而不是被后续复杂形态干扰。

中间网络仍然是同一条 billowy smoke 链：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签，可确认：

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

`Turbulence` 区域可见的关键项：

- `Noise Type`：`Analytic Fast Simplex Noise`
- `Turbulence`：`0.25`
- `Swirl Size`：`2`
- `Roughness`：`0.5`
- `Pulse Length`：`0.5`
- `Max Octaves`：`2`
- `Seed`：`6`
- `Threshold Field`：`temperature`
- 勾选 `Use Control Field`
- `Control Field`：`density`
- `Control Range`：`0` 到 `1`

这张图的核心信息是：`speed` 控制字段并不是创造速度，而是决定已有速度场会如何放大或缩小 `Disturbance` 的作用。换句话说，烟雾移动越快的地方，局部扰动可以被加强；慢速区域则会得到更弱的破碎和翻卷。这让形态变化更贴近流场本身，而不是均匀撒噪声。
这张图切回 `Fields` 页签，重点是 `Flame Lifespan`。教程在这里解释：火焰场并不是永久存在，它的寿命长短会直接影响火焰持续时间，以及后续是否还能持续派生温度和烟雾。

左侧视口中仍是边界盒内的小烟团，时间轴位于第 1 帧，因此这是典型的参数说明画面，而不是结果对比画面。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Fields` 页签，可确认：

- `Density -> Dissipation`：`0.05`
- `Density -> Clamp Below`：`0.005`
- `Density` 勾选 `Use Control Field`
- `Density -> Control Field`：`temperature`
- `Density -> Control Range`：`0` 到 `1`
- 勾选 `Remap Control Field`
- `Temperature -> Diffusion`：`0`
- `Temperature -> Cooling Rate`：`0.5`
- `Flame -> Flame Lifespan`：`2`

下方还能看到 `Color` 与 `Speed` 分组处于折叠状态。

这张图的关键含义是：`Flame Lifespan` 控制火焰场本身在模拟里保留多久。数值更大时，火焰会更持久，相关热量和二次派生也会维持更久；数值更小时，火焰会更快出现后消失。教程把它单独拎出来，是为了说明“火焰持续时间”并不是简单依赖发射器时间，而是求解器内火焰字段自身的生命周期设定。
这张图把话题从火焰寿命切回整体运动趋势，当前是 `Shape` 页签里和上升、环境温度、重力、风向有关的一组基础运动参数。

左侧视口中仍是边界盒内的初始烟团，时间轴位于第 1 帧，因此这张图的重点完全在右侧参数，而不是形态结果。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。截图中可确认：

`Buoyancy` 区域：

- `Buoyancy Scale`：`0.1`
- `Ambient Temp (K)`：`300`
- `Reference Temp (K)`：`3000`

`Gravity` 区域：

- `Gravity Acceleration`：`9.8`
- `Gravity Direction`：`0, -1, 0`
- 可见 `Density Influences Gravity` 选项

`Wind` 区域：

- `Wind Speed`：`2`
- `Wind Direction`：`1, 0, 0`

下方还能看到 `Disturbance` 和 `Turbulence` 分组继续存在，且 `Disturbance` 仍保持：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

这张图的关键含义是：烟雾“往上飘多少、往哪边飘、重力如何参与”并不是一个模糊概念，而是由 `Buoyancy Scale`、环境温度与参考温度差、重力方向以及风向共同决定。教程在这里把这些基础运动项集中展示，是为了让读者理解：后面的形态变化并不全是噪声造成的，整体上升与侧向偏移首先由这些基础力场决定。

### 00:03:05-00:06:05 速度

- 本段定位：速度。
- 知识点：向上的力量变强了 可观察到蘑菇云的形状适当简单了一些 这个模拟这些选项一开始 这些选项一开始 感觉非常困难的一点是 我动了这些选项改了数值。
- 知识点：但很多时候感觉不到变化值是怎么变的 它里面似乎复杂 递交值的各种领域 反馈也在连锁反应 彼此都不同地纠缠着 我们 REST App 这路径中使用了。
- 知识点：随着工材很多 还是然后那个 Pinger 然后又高高 因为有基地具有动作 所以移动一个数值时 有时也不会有反应 或是门的强度就是 因为其他数值而被忽略。
- 知识点：虽然不是忽略 但表达可能有点微弱 或者看起来就是那样 所以这时候与其打开所有数值 查看不如关掉一个 只想查看团流时 就只移动团流数值查看。
- 知识点：这样一个个逐步打开查看 理解起来会更快一些 这些直观选项可以随时快速查看 还有这里的环境温度和 参考温度是有的 然后环境温度现在就是室温。
- 核对对象：`速度`。

**关键画面：**

这张图是在第二个“速度”小节里，专门用来说明把上升力调强之后，烟柱会更明显地向上冲，并更容易形成简化的蘑菇云轮廓。

左侧视口中的烟雾已经发展成高耸上升的柱状体，顶部明显外扩，时间轴位于第 83 帧。画面形态相较前面的低矮烟团，更直接体现出强浮升带来的垂直拉伸和顶部堆积。

中间网络仍然没有变化：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。截图中可确认：

`Buoyancy` 区域：

- `Buoyancy Scale`：`0.5`
- `Ambient Temp (K)`：`300`
- `Reference Temp (K)`：`3000`

`Gravity` 区域：

- `Gravity Acceleration`：`9.8`
- `Gravity Direction`：`0, -1, 0`

`Wind` 区域：

- `Wind Speed`：`2`
- `Wind Direction`：`1, 0, 0`

`Disturbance` 区域可见仍保持：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Roughness`：`0.5`
- `Pulse Length`：`0.2`
- `Max Octaves`：`3`
- `Lacunarity`：`2.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

这张图的关键含义是：当 `Buoyancy Scale` 从较低值提高到 `0.5` 后，热气体上升趋势会显著增强，烟雾顶部更容易堆成团并形成更典型的蘑菇云形状。教程借这个例子说明，有些变化之所以“看不出来”，往往是因为其他参数同时在作用，所以需要像这样抓住单一主效应参数单独看结果。
这张图和上一张使用同一组 `Shape` 参数，但把时间轴拉回到第 1 帧，用来强调教程提到的排查方法：不要一次同时看所有结果，而是把某一项参数单独拎出来，在最简单状态下理解它的作用。

左侧视口中只有边界盒里的初始烟团，时间轴为第 1 帧。由于结果形态被简化到最少，这一帧特别适合判断“参数设定本身”而不是后续连锁反馈。

中间网络仍然是：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。可确认的关键项为：

- `Buoyancy Scale`：`0.5`
- `Ambient Temp (K)`：`300`
- `Reference Temp (K)`：`3000`
- `Gravity Acceleration`：`9.8`
- `Gravity Direction`：`0, -1, 0`
- `Wind Speed`：`2`
- `Wind Direction`：`1, 0, 0`

`Disturbance` 维持：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Roughness`：`0.5`
- `Pulse Length`：`0.2`
- `Max Octaves`：`3`
- `Lacunarity`：`2.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

`Turbulence` 可见保持：

- `Noise Type`：`Analytic Fast Simplex Noise`
- `Turbulence`：`0.25`
- `Swirl Size`：`2`

这张图的重点不是展示新效果，而是说明一种调参策略：当多个领域和反馈互相缠绕时，应先把画面退回到最简单状态，再逐项打开和观察。这样才能判断究竟是 `Buoyancy`、`Wind`、`Disturbance`，还是别的场在产生变化，而不会被后续连锁反应淹没。
这张图继续停留在 `Shape` 页签，但这次重点落在温度基准本身：教程用它说明有些数值即使改了，也不一定会立刻在外观上表现得很明显，因为它们会与其他场联动。

左侧视口中的烟团仍处于第 1 帧的初始状态，说明这里依然是在做参数静态对照，而不是观察复杂模拟后的最终形态。

中间网络保持不变：

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中 `pyrosolver_billowy_smoke`，位于 `Shape` 页签。与前两张相比，最显著的变化是：

`Buoyancy` 区域：

- `Buoyancy Scale`：`0.5`
- `Ambient Temp (K)`：`300`
- `Reference Temp (K)`：`2000`

其余相关项仍可确认：

- `Gravity Acceleration`：`9.8`
- `Gravity Direction`：`0, -1, 0`
- `Wind Speed`：`2`
- `Wind Direction`：`1, 0, 0`

`Disturbance` 区域保持：

- `Disturbance`：`15`
- `Mode`：`Block-Based`
- `Base Block Size`：`0.1`
- `Threshold Field`：`density`
- `Threshold Range`：`0.05` 到 `0`
- `Control Field`：`speed`
- `Control Range`：`0` 到 `5`

`Turbulence` 区域顶部仍可见：

- `Noise Type`：`Analytic Fast Simplex Noise`
- `Turbulence`：`0.25`

这张图的关键含义是：`Reference Temp` 改变的是热浮升比较所依据的温度基准，它会影响温度差如何转化成上升力，但这种影响常常会被 `Buoyancy`、`Wind`、扰动和源输入共同掩盖。所以教程才强调，与其一次看所有选项，不如单独改一个值并逐项观察，否则很容易误以为“参数没起作用”。

### 00:06:11-00:09:00 颜色

- 本段定位：颜色。
- 知识点：而且上升的方向其实 可以看作是重力值的反方向 所以总是那样 而且我们认为它会朝着 我们刚才说到飞机款的方向进行 在厂商漏掉了一个 温度方面没解释。
- 知识点：温度选项这里只看两个选项就行 冷却速率是指这个烟雾温度会多快降温 或者温度会多慢降温 可以看作是这个烟雾的数值 现在0.5的时候和0.9左右。
- 知识点：数值越高温度会降得越快 我来用这个指南字段确认一下 这样如果烟雾快速冷却 和0.1的时候比较一下 字段的颜色变化也明显不同。
- 知识点：而且可观察到这个区域的颜色变化有点不同 而且可观察到烟雾消失的那种感觉 有点不同 然后直接的关联值就可以通过消散来调整 然后这里虽然差别不大。
- 知识点：但冷却的热量似乎可以适当多降一点 基本上热量上升时 烟雾会适当更多地受到向上的力 然后这种作用也有影响的差异 还有扩散选项的情况 可以看作是温度的扩散差异。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`烟雾`。

**关键画面：**

这张图展示的是 Houdini 烟雾求解节点 `pyrosolver_billowy_smoke` 的 `Fields` 参数页，用来说明温度相关力场如何影响烟雾朝上漂浮与横向扰动。

- 当前查看节点链为 `pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- 右侧打开的是 `pyrosolver_billowy_smoke` 的 `Fields` 选项卡。
- `Buoyancy` 已启用，`Buoyancy Scale = 0.5`，`Ambient Temp (K) = 300`，`Reference Temp (K) = 3000`。这一组参数用于控制温度产生的浮力强度。
- `Gravity` 已启用，`Gravity Acceleration = 9.8`，`Gravity Direction = (0, -1, 0)`，表示重力沿负 Y 方向作用，因此温度浮力可理解为与重力相反的上升趋势。
- `Wind` 已启用，`Wind Speed = 2`，`Wind Direction = (1, 0, 0)`，说明烟雾还会受到沿 X 方向的轻微侧向推动。
- `Disturbance` 已启用，`Disturbance = 15`，模式为 `Block-Based`，可见参数包括 `Base Block Size = 0.1`、`Roughness = 0.5`、`Pulse Length = 0.2`、`Max Octaves = 3`、`Lacunarity = 2.1`。
- `Threshold Field = density`，`Threshold Range = 0.05`，并启用了 `Use Control Field`，其 `Control Field = speed`，`Control Range = 0 -> 5`。这表示扰动强度会参考速度场进行分布控制。
- 视口左侧能看到一个低矮的烟团位于包围盒底部，说明这是调节浮力与温度扩散前后的实时烟雾观察状态。
这张图继续展示 `pyrosolver_billowy_smoke` 的 `Fields` 页面，重点切换到温度与耗散控制，用来说明烟雾“降温速度”会怎样影响颜色场和烟形变化。

- 右侧仍是 `pyrosolver_billowy_smoke` 节点，当前可见 `Dissipation`、`Temperature`、`Flame`、`Color`、`Speed` 等分组。
- `Field Guides` 下拉项切到了 `Temperature`，因此左侧视口中额外显示了一团彩色温度场预览：底部偏红黄，高处转为绿蓝，表示温度随空间位置衰减。
- `Dissipation` 已启用，`Dissipation = 0.05`，`Clamp Below = 0.005`。
- 启用了 `Use Control Field`，其 `Control Field = temperature`，`Control Range = 0 -> 1`，并勾选 `Remap Control Field`。下方控制曲线从左高右低，表示随着温度变化，耗散强度会按曲线重新映射。
- `Temperature` 分组中可见 `Diffusion = 0`，`Cooling Rate = 0.9`。这正对应教程里“把数值调高，温度会降得更快”的示范。
- `Flame` 分组已启用，当前可见 `Flame Lifespan = 2`。
- 左侧烟雾在包围盒内形成向左上方抬升的长条体积，而旁边的温度场颜色导引用于直观看到温度衰减过程，从而对比高冷却速率下的颜色变化。
这张图是同一温度控制界面的对照参数，用来和上一张 `Cooling Rate = 0.9` 的情况比较，说明冷却变慢后温度场与烟雾表现会更平缓。

- 节点仍为 `pyrosolver_billowy_smoke`，界面仍位于 `Fields` 选项卡，`Field Guides` 保持为 `Temperature`，因此视口继续显示温度场导引。
- `Dissipation` 组未改动，仍为 `Dissipation = 0.05`、`Clamp Below = 0.005`，并继续启用 `Use Control Field`，`Control Field = temperature`，`Control Range = 0 -> 1`，`Remap Control Field` 保持开启。
- 本图的关键变化在 `Temperature` 组：`Diffusion = 0`，`Cooling Rate = 0.5`。这比上一张图的 `0.9` 更低，表示温度衰减更慢。
- `Flame` 分组仍可见 `Flame Lifespan = 2`，说明本次对比主要只改温度冷却速率。
- 左侧视口中的烟团比上一张更低、更紧凑，旁边的温度导引也主要保留在黄绿色区域，没有出现上一张那种更明显的多色延展。这对应教程里用字段颜色去观察“0.9 和 0.1/较低数值相比，冷却速度不同会带来明显颜色变化”的讲解方向。

### 00:09:10-00:12:06 Velocity

- 本段定位：Velocity。
- 知识点：当字段本身适当接近移植时 由于烟雾这样扩散的温度这样扩散 可观察到热量模糊的感觉 可观察到热量模糊的感觉 由于烟雾这样扩散的感觉 数值低的话。
- 知识点：那种扩散会减弱 所以细节 节的移动会更细致 节的移动会更细致 动作的细节看起来更明显了 所以与其在表演上感受到差异 不如说在表现火焰时。
- 知识点：火焰的形状 可以用扩散来适当不同地表现 用扩散可以适当不同地表达 所以这部分可以直观地确认 不过随着视力进行也会看到 不过随着视力进行也会看到。
- 知识点：那时候确认一下 然后看Shop后面的Wind 其实真的很简单 就是风吹的方向 请考虑一下 然后风的方向现在是X轴 所以值已经输入了。
- 知识点：可观察到烟雾像右流动的样子 如果射成0的话 就是那种往上飘的那种烟的感觉 这样就能做出想要的形状了 温度 如果不是特殊情况用多不多 可以当做额外的velocity。
- 核对对象：`Velocity`、`烟雾`、`火焰`。

**关键画面：**

这张图继续展示 Houdini 的 `pyrosolver_billowy_smoke` 节点，仍位于 `Fields` 选项卡，重点改为说明温度扩散 `Diffusion` 会怎样影响烟雾和火焰细节。

- 当前节点链仍为 `pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- 右侧界面保持在 `pyrosolver_billowy_smoke` 的 `Fields` 页，`Field Guides` 下拉项是 `Temperature`，因此左侧视口同时显示灰色烟雾体积和一条彩色温度场导引。
- `Dissipation` 分组保持开启，参数仍为 `Dissipation = 0.05`、`Clamp Below = 0.005`，并继续启用 `Use Control Field`，`Control Field = temperature`，`Control Range = 0 -> 1`，`Remap Control Field` 也仍然开启。
- `Temperature` 分组的关键参数变为 `Diffusion = 1`、`Cooling Rate = 0.5`。这表示温度在体积内有更明显的扩散传播，不只是局部快速衰减。
- `Flame` 分组仍可见 `Flame Lifespan = 2`，表明当前对比的主变量是温度扩散，而不是火焰寿命。
- 左侧视口中烟柱已经明显向左上方拉长、边缘更软，旁边的温度导引也从底部红黄逐步过渡到顶部蓝紫，说明温度被扩散得更开，细节会被一定程度抹平。
这张图展示的是同一 `pyrosolver_billowy_smoke` 节点在 `Fields` 页面里的风场设置，用来说明烟雾如何被额外速度方向推动。

- 右侧当前可见的分组包括 `Buoyancy`、`Gravity`、`Wind`、`Disturbance`、`Turbulence`。
- `Buoyancy` 已启用，当前 `Buoyancy Scale = 0.2`，`Ambient Temp (K) = 300`，`Reference Temp (K) = 3000`。
- `Gravity` 已启用，`Gravity Acceleration = 9.8`，`Gravity Direction = (0, -1, 0)`，保持基础下落方向不变。
- `Wind` 已启用，`Wind Speed = 2`，`Wind Direction = (1, 0, 0)`。这说明风力沿正 X 轴推动体积，正对应教程里“现在风的方向是 X 轴，所以值已经输入”的讲解。
- `Disturbance` 仍为 `Disturbance = 15`，模式 `Block-Based`，可见 `Base Block Size = 0.1`、`Roughness = 0.5`、`Pulse Length = 0.2`、`Max Octaves = 3`、`Lacunarity = 2.1`；并继续使用 `Threshold Field = density`、`Threshold Range = 0.05`、`Control Field = speed`、`Control Range = 0 -> 5`。
- `Turbulence` 已启用，画面可见 `Noise Type = Analytic Fast Simplex Noise`，`Turbulence = 0.25`，以及 `Swirl Size = 2`、`Roughness = 0.5`、`Pulse Length = 0.5`、`Max Octaves = 2`、`Seed = 0`。
- 左侧视口里烟团和温度导引都偏向包围盒右侧延展，说明除了浮力向上之外，还叠加了沿 X 方向的风场偏移。
这张图仍然位于 `pyrosolver_billowy_smoke` 的 `Fields` 参数页，但视线已经集中到扰动噪声的形状控制，说明烟体细节不只受风向影响，也受块状扰动和湍流参数影响。

- `Buoyancy` 与 `Gravity` 参数区域仍可见，数值保持为 `Buoyancy Scale = 0.2`、`Gravity Acceleration = 9.8`、`Gravity Direction = (0, -1, 0)`。
- `Wind` 分组被折叠但仍保持启用状态，说明本图不是重新解释风，而是继续在已有风场基础上调整细节噪声。
- `Disturbance` 分组处于主要观察位置，当前参数包括 `Disturbance = 15`、模式 `Block-Based`、`Base Block Size = 0.1`、`Roughness = 0.5`、`Pulse Length = 0.2`、`Max Octaves = 3`、`Lacunarity = 2.1`。
- `Threshold Field = density`，`Threshold Range = 0.05`，并且仍启用 `Use Control Field`，`Control Field = speed`，`Control Range = 0 -> 5`。这表示扰动主要施加在有密度的烟体区域，并可被速度场调制。
- `Turbulence` 同时启用，能看到 `Noise Type = Analytic Fast Simplex Noise`、`Turbulence = 0.25`、`Swirl Size = 2`、`Roughness = 0.5`、`Pulse Length = 0.5`、`Max Octaves = 2`、`Seed = 0`。
- 左侧视口中的烟柱已经形成较完整的蘑菇状团块，边缘卷曲比前面几张更明显；结合字幕可知，这一段是在强调 `Base Block Size` 之类的块状噪声尺度会直接影响图案和烟雾形体的粗细程度。

### 00:12:09-00:15:03 UV、噪声、粗糙度

- 本段定位：UV、噪声、粗糙度。
- 知识点：3可以看作是三层噪声叠加在一起 根据拉克努利特之0.1乘以2.1 再乘这样三层 噪音就会产生 就是可以这么理解 没有盖老师看看区别吧 UV。
- 知识点：break 变得非常简单和平淡了 对吧 UV break 是的 这些边缘线 可以理解为增加了额外的细节 disturbance uv break。
- 知识点：反过来说 50左右来画怎么样 UV break 会制造出非常细密的边缘 这个有点破碎的感觉 UV break是可以表现出一些破碎的烟雾效果。
- 知识点：有时候也需要这种感觉的烟雾 所以可以看作是制作这种形状细节的部分 当block size设为一时 就会形成比之前更粗的灰色 可观察到图案混合在一起。
- 知识点：这种差异 怎么看这个可能和Falter field也有点像 页面 可能会感觉有点不同 配件 选项值再多 但我们经常碰到选项是固定的 那部分我最后再说一次。
- 核对对象：`噪声`、`烟雾`。

**关键画面：**

这张图展示的是 `pyrosolver_billowy_smoke` 在 `Fields` 页中的扰动噪声参数基线，用来解释块状噪声是如何按多层频率叠加生成烟雾表面细节的。

- 当前节点仍是 `pyrosolver_billowy_smoke`，右侧可见 `Buoyancy`、`Gravity`、`Wind`、`Disturbance`、`Turbulence` 分组。
- `Buoyancy`、`Gravity` 保持与前一段一致，当前主要观察的是 `Disturbance` 分组。
- `Disturbance` 已启用，参数为 `Disturbance = 15`，模式 `Block-Based`。
- 与字幕内容直接对应的参数为：
  - `Base Block Size = 0.1`
  - `Lacunarity = 2.1`
  - `Max Octaves = 3`
  这表示噪声会从 0.1 的基础块尺度出发，按 2.1 的频率倍率逐层叠加，共叠加 3 层细节。
- 同组还能看到 `Roughness = 0.5`、`Pulse Length = 0.2`、`Threshold Field = density`、`Threshold Range = 0.05`。
- `Use Control Field` 仍启用，`Control Field = speed`，`Control Range = 0 -> 5`，`Remap Control Field` 关闭状态可见，说明扰动强度主要随速度场分布，但这里强调的不是重映射曲线，而是噪声层级本身。
- `Turbulence` 分组也处于启用状态，可见 `Noise Type = Analytic Fast Simplex Noise`、`Turbulence = 0.25`、`Swirl Size = 2`、`Roughness = 0.5`、`Pulse Length = 0.5`、`Max Octaves = 2`、`Seed = 0`。
- 左侧视口里烟柱呈现比较完整的卷曲蘑菇形，边缘已经带有细碎褶皱；这就是多层 disturbance 噪声叠加后形成的基础细节效果。
这张图是同一 `Disturbance` 参数页的强对照版本，重点说明当块尺度变大、扰动强度提高后，烟雾表面的破碎纹理会变粗，细节会从细碎边缘转成更大块的形状。

- 当前仍在 `pyrosolver_billowy_smoke` 的 `Fields` 页，观察中心是 `Disturbance` 分组。
- 本图里 `Disturbance` 的关键参数变为：
  - `Disturbance = 50`
  - `Base Block Size = 1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
- `Threshold Field = density`、`Threshold Range = 0.05` 仍保持不变，`Use Control Field` 仍启用，`Control Field = speed`，`Control Range = 0 -> 5`。
- `Turbulence` 组仍可见 `Turbulence = 0.25`、`Swirl Size = 2`、`Roughness = 0.5`、`Pulse Length = 0.5`、`Max Octaves = 2`、`Seed = 0`，说明当前主要差异来自 disturbance 的块尺寸与强度，而不是湍流部分。
- 左侧视口中的烟团已经从前一张的细碎卷边，变成更大块、更厚重的团状体；边缘花纹不再密密麻麻，而是呈现较粗的分块感。
- 这与字幕“当 block size 设为 1 时，会形成比之前更粗的灰色”完全对应，说明 `Base Block Size` 提高后，噪声尺度整体变大，适合做较粗犷的烟雾纹理。
这张图把观察重点从 `Disturbance` 延伸到下方的 `Turbulence`，用于说明 turbulence 可以理解为场内部持续生成的局部乱流和涡流。

- 节点链仍是 `smoke_base -> pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- `Disturbance` 分组在上方仍保持可见，参数为 `Disturbance = 50`、模式 `Block-Based`、`Base Block Size = 0.1`、`Roughness = 0.5`、`Pulse Length = 0.2`、`Max Octaves = 3`、`Lacunarity = 2.1`，同时继续使用 `Threshold Field = density` 和 `Control Field = speed`。
- 本图的核心是 `Turbulence` 分组：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 0.25`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 0`
- `Turbulence` 自己还带有独立的作用范围控制：
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - 启用 `Use Control Field`
  - `Control Field = density`
  - `Control Range = 0 -> 1`
  - `Remap Control Field` 关闭
- 左侧视口中的烟团此时很弱，只剩包围盒里一小团灰色体积和旁边一块黄色引导区域，说明这里更强调参数意义本身，而不是完整烟型展示。
- 结合字幕“`Turbulence` 是场内部产生的乱流、涡流”，可以把这一组参数理解为给烟雾体积叠加细小旋涡运动，使边缘和内部流动更自然，而不是单纯放大块状噪声。

### 00:15:09-00:18:12 Niagara、速度、纹理

- 本段定位：Niagara、速度、纹理。
- 知识点：刚才只是普通往上冲的 这种乱流力量变强了 像四周扩散的场力变强了 往上冲的力被干扰了 力量和原速度的。
- 知识点：这种比例值可能被忽略 就是所以团流不要太强 看起来会更好 上升是适当突出一点或者 刚才在造生之团流之强的情况下看形状 就是在虚幻中看尼亚加拉那边。
- 知识点：色彩可观察到像色彩一样这样 按照造生模式这个方向 这样例子呢 移动着形成模式内 受到团流影响 可以认为在这个空间里 按照那个模式方向散开。
- 知识点：某种程度上用来打破这种统一化的形式 用这个就行 针扩展现在这里不用 爆炸之后才用了这个选项 或引起的膨胀程度 再往外加一点就行 在烟里可能不太明显。
- 知识点：但确实表现出来了现在0.5的话是很大的值 是0.5值 这个扩散烟的扩散很厉害 所以烟的粘性很强 就是现在散开或那样的情况已经弱了很多。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`纹理`、`速度`、`火焰`。

**关键画面：**

这张图展示的是 `pyrosolver_billowy_smoke` 在 Unreal 对接前的烟型测试画面，重点是把 turbulence 提强后，烟雾不再只是向上冲，而会被更强的乱流打散到四周。

- 当前节点链为 `smoke_base -> pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- 右侧界面中，`Disturbance` 和 `Turbulence` 两组同时可见。
- `Disturbance` 参数为：
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - 启用 `Use Control Field`，`Control Field = speed`，`Control Range = 0 -> 5`
- `Turbulence` 参数为：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 5`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - 启用 `Use Control Field`，`Control Field = density`，`Control Range = 0 -> 1`
- 左侧视口中的烟团已经形成横向大幅铺开的厚云，说明乱流强度足够大时，原本偏向上升的速度会被四周扩散的场力明显干扰。
- 这正对应正文里“刚才只是普通往上冲的，这种乱流力量变强了，像四周扩散的场力变强了，往上冲的力被干扰了”的说明。
这张图是上一张强乱流效果的对照版本，核心变化是把 `Turbulence` 降低，让烟雾重新保留更明显的上升轮廓，而不是被完全打散。

- 当前节点和页面位置不变，仍是 `pyrosolver_billowy_smoke` 的 `Disturbance` / `Turbulence` 参数区。
- `Disturbance` 参数保持：
  - `Disturbance = 5`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Control Field = speed`
- 关键变化出现在 `Turbulence`：
  - `Turbulence = 0.5`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - `Control Field = density`
  - `Control Range = 0 -> 1`
- 左侧视口中的烟团变成较集中的双团块结构，主体仍然向上抬升，只在边缘和内部保留适度翻卷；旁边的彩色引导体积也不再像上一张那样过度扩散。
- 这与正文“某种比例值可能被忽略，所以团流不要太强，看起来会更好”相符，说明更低的 turbulence 更适合保留烟柱主形，同时只用来打破过于统一的形态。
这张图继续沿用上一张较温和的 turbulence 设定，但把参数面板再向下展开到 `Viscosity` 一带，用来衔接“烟的扩散很厉害时，粘性会影响散开程度；表现火焰时则要考虑纹理是否足够突出”的说明。

- 右侧仍可见 `Disturbance` 和 `Turbulence` 分组，参数保持为：
  - `Disturbance = 5`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Turbulence = 0.5`
  - `Swirl Size = 2`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Threshold Field = temperature`
  - `Control Field = density`
- `Shredding`、`Flame Expansion` 两组已折叠但可见，说明教程正在过渡到更下游的形状修饰参数。
- 最下方当前能直接读到 `Viscosity = 0`。这表示此时没有额外增加体积粘滞感，烟雾更容易保持已有的扩散趋势，而不会被粘性进一步拉住。
- 左侧视口中的烟柱仍然是较高的蘑菇状主形，顶部团块饱满、下部拖尾较细，说明在较低 turbulence 下，主形已经比较稳定，适合作为后续在 Niagara 或材质侧观察火焰纹理方向的参考形态。
- 结合正文“0.5 的值已经很大，烟的扩散很厉害，所以烟的粘性很强时，散开会弱很多；为了表现火焰，要把火焰纹理突出一点”，这一张可理解为从流体扰动参数过渡到后续引擎侧外观控制的承上启下画面。

### 00:18:22-00:21:38 Smoke、碰撞、生命周期

- 本段定位：Smoke、碰撞、生命周期。
- 知识点：在我们开始模拟工作之前 现在这里 适当解释一下这些选项的用途 以后这种选项的数值导致这种形态出现 就适当能帮上这个忙 而且现在说了很多选项。
- 知识点：最重要的选项 挑几个收体素大小很重要 还有边界框框更大一点 和哪些选项能用可以再了解一下 这个默认值我们基本不用动 对原的控制 这个根据是使用爆发还是循环来调整使用。
- 知识点：日常的分散减速和直观控制会很多 对火焰的生命周期 还有这种扰动的数值和宽大小值 还有团流值 就是那个漩涡大小值真性值 只要控制到这种程度。
- 知识点：大部分类型的资源应该都能做很多工作 然后接下来 剩下的类别在高级设置中 需要更细致的调整时 比如模拟方式或算法 碰撞处理方式等细节可以调整的选项。
- 知识点：我们一般不会有什么特别的情况 输出 这样模拟的结果值 然后可以决定序列哪些字段 然后也可以进行更改 所以有标记为smoke 也有标记为invisible的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`序列`、`生命周期`、`碰撞`、`火焰`。

**关键画面：**

这张图是 `Smoke、碰撞、生命周期` 段的开场说明画面，重点不是展示某个极端效果，而是回到 `pyrosolver_billowy_smoke` 的常用参数上，解释这些选项各自负责什么。

- 当前节点链仍为 `smoke_base -> pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- 右侧界面位于 `Fields` 选项卡，可见 `Buoyancy`、`Gravity`、`Wind`、`Disturbance`、`Turbulence` 分组。
- `Buoyancy` 和 `Gravity` 仍保持基础设置：
  - `Buoyancy Scale = 0.2`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
- `Disturbance` 当前参数为：
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Control Field = speed`
- 鼠标此时悬停在 `Lacunarity` 上，弹出的提示说明其含义是“连续噪声层之间的块大小比例”，也就是每一层 octave 相对于前一层的尺度倍率。
- `Turbulence` 分组仍保持启用，当前可见 `Noise Type = Analytic Fast Simplex Noise`，`Turbulence = 0.5`。
- 左侧视口中的烟团很弱，只剩一小团灰色体积和一个红色引导区，说明这张图主要用于参数用途讲解，而不是展示最终烟型。
这张图延续上一张的“常用参数用途说明”，但视线更明显地落在 `pyrosolver_billowy_smoke` 与右侧 `dopnet1` 的关系上，用来说明这些烟雾参数都服务于同一个仿真网络，而不是彼此孤立的局部开关。

- 中央网络中可见主链：
  - `smoke_base`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke`
  - `RENDER_Billowy_Smoke`
- 右侧有一个单独的 `dopnet1` 节点，并有虚线高亮连接指向当前选中的 `pyrosolver_billowy_smoke`，说明当前讲解的这些字段参数属于求解器/仿真阶段。
- 右侧参数仍位于 `Fields` 页，当前可见值与上一张一致：
  - `Buoyancy Scale = 0.2`
  - `Gravity Acceleration = 9.8`
  - `Disturbance = 5`
  - `Base Block Size = 0.1`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Control Field = speed`
  - `Turbulence = 0.5`
- 左侧视口依旧只有很小的烟团和红色场引导，说明教程在这一段并不追求把每个参数都调到强效果，而是先建立“哪些参数最常用、哪些默认值通常不用动、哪些要按爆发或循环方式调整”的整体认知。
- 结合正文，这张图可理解为对日常最常改的几类选项做归类：体素/边界、生命周期、扰动强度、块大小、漩涡大小和粘性等参数都在同一仿真逻辑里配合工作。
这张图把参数页从 `Fields` 切到了 `Look`，说明在讲完仿真阶段的常用控制后，教程开始区分“决定形态的参数”和“只用于视觉确认的显示/着色参数”。

- 当前选中的仍是 `pyrosolver_billowy_smoke`，但右侧标签已经切换到 `Look`。
- `Smoke` 分组展开，可直接读到：
  - `Density Scale = 5`
  - `Smoke Color = (0.5, 0.4, 0.3)`，类型为 `Constant`
  - `Shadow Color = (1, 1, 1)`
  - `Shadow Density = 1`
  - `Ambient Shadow Scale = 0.5`
- `Fire` 分组也展开，但大部分值被灰化。仍能看到：
  - `Intensity Scale = 25`
  - `Source Range = 0 -> 1`
  - 一个从左低到右高的 `Fire Intensity Ramp`
  - `Color Mode = Color Ramp`
  - 下方有一条浅棕到浅米色的 `Fire Color Ramp`
- 底部还能看到折叠的 `Assign Material` 和 `Bindings` 分组，说明这里更偏向渲染外观与材质挂接，而不是流体运动求解。
- 左侧视口中的烟柱已经是较稳定的蘑菇状主形，表示这一页主要用来做“看起来像不像”的视觉确认，而不是再去决定烟雾的基本运动逻辑。
- 这与字幕“这里的数值没什么意义，所以不用太在意，`look` 的话真的只是视觉上想确认的时候才看”一致。也就是说，日常复现时优先调前面的仿真参数，`Look` 页更多是做显示与检查。

### 00:21:46-00:24:34 Velocity、UV、速度

- 本段定位：Velocity、UV、速度。
- 知识点：Ctrl选项和PyroBank volume的节点 我们下次再继续解释吧 可能还有些人不太理解 这很正常 因为现在还没体验过 就是 我还没解释过这些领域。
- 知识点：用途什么的也不太清楚 关于这些领域的用途和角色 更多的 内容需要在实例中进行详细说明 这样进行应该 现在只能聚焦于这些选项的作用。
- 知识点：理解用途 这些方面 所以我觉得现在就是聚焦于这个选项 您看看 那么最后 与其直接结束 不如把直接复制一下 现在DAC的帧区间在60帧。
- 知识点：一直在进行某种模拟 然后复制起来就好像花了很长时间 这时候按捏自己中断一下 要不要做个简单的演示呢 UV Break 与其说是做 不如说是看看怎么调整数值。
- 知识点：来匹配这个形状的过程 简单看一下吧 用更简单的球体替换了原本件 这里没什么要改的 现在在属性调整 向量中生成速度值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Velocity`、`速度`。

**关键画面：**

这张图把选中节点从 `pyrosolver_billowy_smoke` 切到了 `pyrolook_billowy_smoke`，说明教程开始转入 `Pyro Bake Volume` 的显示和材质侧设置，而不再只看烟雾求解器本身。

- 当前节点链仍为 `smoke_base -> pyrosource1 -> attribadjustvector_velocity -> volumerasterizeattributes -> pyrosolver_billowy_smoke -> pyrolook_billowy_smoke -> RENDER_Billowy_Smoke`。
- 当前高亮选中的是 `pyrolook_billowy_smoke`，右侧标题栏显示 `Pyro Bake Volume | pyrolook_billowy_smoke`。
- `General` 区域可见：
  - 已启用 `Assign Material`
  - 材质路径为 `matnet/Pyro_Shader`
- 当前打开的是 `Smoke` 页签，可见参数包括：
  - `Density Scale = 5`
  - `Smoke Color` 使用 `Ramp`
  - `Density Range = 0 -> 1`
  - 一条浅灰到浅棕色的 `Smoke Color Ramp`
  - `Shadow Color = (1, 1, 1)`
  - `Shadow Density = 1`
  - `Ambient Shadow Scale = 0.5`
- 左侧视口中的烟柱已经是稳定的蘑菇状烟型，说明此节点更偏向“把仿真结果如何显示出来”，而不是重新生成运动。
- 结合正文“Ctrl 选项和 Pyro Bake Volume 的节点下次再继续解释”“现在先聚焦于这些选项的作用”，这一张可以理解为对 `pyrolook_billowy_smoke` 入口页的定位说明：它负责材质绑定、烟雾显示范围和颜色映射。
这张图把焦点前移到 `pyrosource1`，用来说明在更简单的几何体或源形状上，烟雾字段最初是怎样被散布和写入属性的。

- 中央网络仍是同一条烟雾制作链，但当前高亮的上游节点包括：
  - `smoke_base`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
- 右侧参数面板标题为 `pyrosource1`，当前处于初始化/散布设置。
- `Group` 区域可见：
  - `Mode = Volume Scatter`
  - `Particle Separation = 0.05`
  - `Particle Scale = 2`
  这表示源节点会在体积内部按固定间距散布粒子。
- 下方 `Attributes` 数量为 `2`，当前明确列出了两个要写入的标量属性：
  - `Attribute = Density`
    - `Default Value = 1`
    - `Scale` 可调
  - `Attribute = Temperature`
    - `Default Value = 1`
    - `Scale` 可调
- 左侧视口里的烟型仍显示为之前的蘑菇状结果，但教程当前讲的是上游准备阶段：先用简单源形状产生 `Density` 和 `Temperature`，再交给后面的速度调整和体积栅格化节点。
- 结合正文“用更简单的球体替换了原本件”“现在在属性调整向量中生成速度值”，这张可以理解为：先从简单发射体出发建立基础字段，再通过下一个 `attribadjustvector_velocity` 节点补上速度方向和强度。
这张图展示的是一个简化示例链，用球体源配合 `Attribute Adjust Vector` 来生成速度属性 `v`，用于说明“如何通过更简单的形状去匹配想要的流动方向”。

- 当前可见的简化节点链为：
  - `sphere1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke1`
  - `pyrolook_billowy_smoke1`
- 左侧视口不再显示烟雾，而是显示一个由点构成的球体散布结果，说明此时教程在查看源粒子/点级别速度，而不是最终体积外观。
- 右侧当前选中节点为 `Attribute Adjust Vector | attribadjustvector_velocity1`，其顶部基础设置为：
  - `Attribute Name = v`
  - `Attribute Class = Point`
  - `Component Scope = X / Y / Z`
- `Pre-Process` 区域可见：
  - 启用 `Enable Pre-Process`
  - 启用 `Overwrite Initial Value`
  - `Initial Value From = Constant Value`
  - `Initial Vector = (0, 1, 0)`
  - `Reverse Direction` 未启用
  - `Make Vectors Unit Length` 未启用
- `Adjustment Value` 区域可见：
  - 启用 `Adjust Value`
  - `Adjustment for = Direction & Length`
  - `Operation = Add`
  - `Adjust with = Noise`
  - `Range Values = Zero Centered`
  - `Amplitude = 2`
- `Noise Pattern` 区域可见：
  - `Noise Type = Simplex`
  - `Location Attribute = P`
  - `Element Size = 2`
  - `Offset = 0`
  - `Use VExpression` 未启用
- 下方 `Animation` 和 `Fractal` 还显示出：
  - 启用 `Animate Noise`
  - `Pulse Duration = 1`
  - `Fractal Type = Standard (fBm)`
  - `Max Octaves = 3`
  - `Lacunarity = 2.01234`
- 这说明该示例的做法是：先给所有点一个统一的向上基向量 `(0,1,0)`，再叠加以位置 `P` 为输入的 Simplex 噪声，从而把原本单一的上升速度打散成更自然的速度场。

### 00:24:39-00:27:32 Velocity、Noise、系统

- 本段定位：Velocity、Noise、系统。
- 知识点：而且动画现在有勾选 所以可以认为图案是偏移平移的 然后 用眼睛确认一下这个 标记板现在可以确认这部分 现在可以确认这部分 虽然这里可观察到Velocity的值。
- 知识点：但用眼睛看有点短 就是 颜色有点 然后需要做一个新的标记 可以确认Velocity的 好用Width表示的话 现在用黄色Width表示速度值。
- 知识点：有视觉上 点击的话可观察到这种选项 可以这样开关选项 然后 在这个状态下可观察到这个 Noise Field就是速度值。
- 知识点：就这样变化 就是说 烟雾最初生成时 是朝这个方向 随着速度的产生 以一左右的圆尺度生成 意味着 烟雾最初就是沿着这个方向 伸展的力量 可以这样调整。
- 知识点：高噪声模式的大小 然后 或者用振幅调整复数值 所以应用这个站点 然后检查这个系统 然后节点做的是把这个速度属性的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Velocity`、`Noise`、`系统`、`速度`、`颜色`、`噪声`、`烟雾`。

**关键画面：**

这张图继续使用球体点云示例来讲 `Velocity、Noise、系统`，重点是把速度噪声系统的几个关键分组完整展开，方便直接观察速度是怎样被噪声调制的。

- 当前节点链保持为：
  - `sphere1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke1`
  - `pyrolook_billowy_smoke1`
- 左侧视口仍然显示球体点云，而不是最终烟雾，说明当前是在检查点级速度属性。
- 右侧当前选中 `Attribute Adjust Vector | attribadjustvector_velocity1`，并可见以下设置：
  - `Enable Pre-Process` 开启
  - `Overwrite Initial Value` 开启
  - `Initial Value From = Constant Value`
  - `Initial Vector = (0, 1, 0)`
- `Adjustment Value` 区域：
  - `Adjust Value` 开启
  - `Adjustment for = Direction & Length`
  - `Operation = Add`
  - `Adjust with = Noise`
  - `Range Values = Zero Centered`
  - `Amplitude = 2`
- `Noise Pattern` 区域：
  - `Noise Type = Simplex`
  - `Location Attribute = P`
  - `Element Size = 2`
  - `Offset = 0`
  - `Use VExpression` 关闭
- `Animation` 区域：
  - `Animate Noise` 开启
  - `Pulse Duration = 1`
- `Fractal` 区域：
  - `Fractal Type = Standard (fBm)`
  - `Max Octaves = 3`
  - `Lacunarity = 2.01234`
  - `Roughness = 0.5`
- `Warping` 区域也已展开，可见：
  - `Lattice Warp = 0`
  - `Lattice Warp Size = 1`
  - `Gradient Warp = 0`
  - `Accumulate Lattice Warp` 关闭
  - `Accumulate Gradient Warp` 关闭
- 这说明当前速度场的主体逻辑仍然是“向上初速度 + 位置驱动的分形噪声”，而不是依赖额外 warp 形变；warp 参数此时只是可切换但未启用的高级修饰项。
这张图在同一个 `attribadjustvector_velocity1` 节点上开启了速度向量可视化，用黄色线束直接显示每个点的 `v`，用于肉眼确认噪声场到底怎样影响了速度方向和长度。

- 中央节点链和右侧参数与上一张保持一致，当前仍是：
  - `Initial Vector = (0, 1, 0)`
  - `Adjust with = Noise`
  - `Amplitude = 2`
  - `Noise Type = Simplex`
  - `Element Size = 2`
  - `Animate Noise` 开启
  - `Max Octaves = 3`
  - `Lacunarity = 2.01234`
- 左侧视口的显示模式发生了关键变化：
  - 球体点云仍在底部可见
  - 从每个点向外伸出大量黄色线段/箭杆，形成一个整体偏向左上方扩展的扇形束
- 这些黄色线束可以直接理解为点属性 `v` 的可视化结果：
  - 统一的上升基向量让整体走势先朝上
  - 噪声叠加后，不同点的方向和长度产生偏差，因此线束边缘变得参差、有弯曲和分叉感
- 字幕提到“现在用黄色 Width 表示速度值”“可观察到这个 Noise Field 就是速度值”，与画面完全一致：这里不是在看密度或温度，而是在看速度向量场本身。
- 这类可视化能帮助判断 `Element Size`、`Amplitude`、`Lacunarity` 等值是否把初始流向改得过强或过弱，再决定后续是否要继续调噪声系统。
这张图继续在 `attribadjustvector_velocity1` 中查看速度向量场，但进一步展示了动画节奏和后处理区域，说明这一套速度噪声系统不仅决定方向，也决定噪声随时间变化的方式。

- 左侧视口仍然是黄色速度线束可视化，整体从球体底部向左上方大面积展开，说明速度场主方向没有变，仍是“向上基向量 + 噪声扰动”的结果。
- 右侧当前仍能确认这些核心设置：
  - `Adjust with = Noise`
  - `Range Values = Zero Centered`
  - `Amplitude = 2`
  - `Noise Type = Simplex`
  - `Location Attribute = P`
  - `Element Size = 2`
  - `Fractal Type = Standard (fBm)`
  - `Max Octaves = 3`
  - `Lacunarity = 2.01234`
  - `Roughness = 0.5`
  - `Lattice Warp = 0`
  - `Gradient Warp = 0`
- 当前图里最明确的可见变化在 `Animation`：
  - `Animate Noise` 仍开启
  - `Pulse Duration = 2`
  这表示噪声动画循环/脉冲节奏比上一张更长。
- 界面继续向下滚动，已经能看到 `Post-Process` 区域，并显示 `Enable Post-Process` 处于关闭状态；下方还能看到被灰化的 `Output Attributes` 和 `Attribute Properties` 开头。
- 这说明当前示例主要依赖前面的预处理、噪声和分形参数来生成速度，而没有再叠加后处理修正。
- 结合正文“可以这样调整高噪声模式的大小，或者用振幅调整复数值，然后检查这个系统，节点做的是把这个速度属性……”，这一张可以理解为对整个 `v` 生成系统的收尾确认：先看向量显示，再看动画节奏和是否需要额外后处理。

### 00:27:40-00:30:27 Velocity、速度

- 本段定位：Velocity、速度。
- 知识点：这样来确认一下吧 现在向上的利益 Nitro Velocity也直接设为0 这个噪音模式的变化值 现在这个对角线方向 烟雾在扩散 这个方向现在限量形成了。
- 知识点：因为现在限量形成了 所以烟雾的移动会继续这样下去 为了看得更清楚 把这个速度的影响放大一点。
- 知识点：这样 更用力 推着能看到了 一直直往这个方向走 因为现在这个周期长度 所以没能这样表达出来呢 这个噪音模式改变了 这边方向也是 现在纯粹地 只受速度影响。
- 知识点：可观察到烟雾在流动 是做西装 中间的一开始有块撞感 然后自然分散成噪音图案 就像消失了一样 作为这种图案应该不错 反过来速度值设为0.1 这次只用Turbine值 这样看。
- 核对对象：`Velocity`、`速度`、`烟雾`。

**关键画面：**

这张图把视角从速度向量可视化切回到体积结果，直接观察“只由当前速度场推动时，烟雾会沿什么方向扩散”。

- 当前简化节点链为：
  - `sphere1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke1`
  - `pyrolook_billowy_smoke1`
- 当前高亮选中的是 `pyrosolver_billowy_smoke1`，右侧处于 `Fields` 页签。
- `Field Guides` 下拉项为 `Temperature`。
- 右侧可见的核心参数包括：
  - `Dissipation = 0.05`
  - `Clamp Below = 0.005`
  - 启用 `Use Control Field`
  - `Control Field = temperature`
  - `Control Range = 0 -> 1`
  - 启用 `Remap Control Field`
  - 一条从左高到右低的控制曲线
  - `Diffusion = 0`
  - `Cooling Rate = 0.5`
  - `Flame Lifespan = 2`
- 左侧视口中的烟团从一个较集中的源体积，被明显拉成沿单一方向外推的双团块形状：右侧主团更大，左侧残留较小，说明当前速度方向已经主导了初始扩散。
- 这与正文“现在纯粹地只受速度影响”“对角线方向烟雾在扩散”一致。当前画面的重点不是湍流或风，而是确认基础速度场本身已经足以把烟雾推向特定方向。
这张图把右侧标签切到了 `Sourcing`，直接展示 `density`、`temperature` 和 `vel` 这三类源字段是怎样送进 `pyrosolver_billowy_smoke1` 的，因此它是这一段里“速度为什么会成为主导影响”的结构性说明图。

- 当前选中节点仍是 `pyrosolver_billowy_smoke1`，右侧位于 `Sourcing` 页签。
- `Source Type = Individual Volumes`。
- 启用了 `Limit Source Range`，其设置为：
  - `Range Type = Frame Range`
  - `Frame Range = 1 -> 100`
- `Source Volumes` 的 `Number of Sources = 3`，分别为：
  - `Source 1: density`
    - `Operation = Add`
    - 类型为 `Scalar`
    - `Source Volume = density`
    - `Target Field = density`
    - `Source Scale = 1`
    - `Use Timestep` 开启
  - `Source 2: temperature`
    - `Operation = Pull`
    - 类型为 `Scalar`
    - `Source Volume = temperature`
    - `Target Field = temperature`
    - `Source Scale = 1`
    - `Use Timestep` 开启
    - `Acceleration Strength = 50`
    - `Deceleration Strength = 10`
  - `Source 3: vel`
    - `Operation = Add`
    - 类型为 `Vector`
    - `Source Volume = v`
    - `Target Field = vel`
    - `Source Scale = 5`
    - `Use Timestep` 开启
- 左侧视口仍在显示黄色速度向量束，整体向右侧集中外推，说明当前 `vel` 字段确实在主导初始运动方向。
- 这张图的核心意义是：求解器并不是凭空生成速度，而是从上游 `v` 体积显式灌入 `vel` 字段，并且这里的 `Source Scale = 5` 会把该速度影响放大，因此更容易看清“烟雾会一直往这个方向走”。
这张图回到 `pyrosolver_billowy_smoke1` 的 `Fields` 参数下半段，用较弱的体积结果去对照 `Turbulence` 参与后的影响，便于和前面“主要看速度源”的结果分开理解。

- 当前高亮节点仍是 `pyrosolver_billowy_smoke1`，右侧可见的是 `Disturbance`、`Turbulence` 和更下方的 `Viscosity` 区域。
- `Disturbance` 组当前可见值为：
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - `Use Control Field` 开启，`Control Field = speed`，`Control Range = 0 -> 5`
- `Turbulence` 组当前可见值为：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 1`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - `Use Control Field` 开启，`Control Field = density`，`Control Range = 0 -> 1`
- 最下方还能直接看到 `Viscosity = 0`。
- 左侧视口里只剩两个较淡的团块：包围盒内一个棕灰色烟团，盒外右侧一个黄色引导/结果团，整体比前面速度线束或强速度推动的画面更弱、更干净。
- 这说明在当前对比中，速度源已经不再被极端放大，转而用中等 `Turbulence = 1` 去观察烟体如何自然散开。与正文“这次只用 Turbulence 值这样看”是一致的：用更纯粹的 turbulence 结果来判断图案是否自然。

### 00:30:30-00:33:28 UV、粒子、精灵

- 本段定位：UV、粒子、精灵。
- 知识点：我们不用Burst这种方式 会很多 用Burst这种方式看的话 就是这样生成 然后散开 可观察到要不要改一下CD值呢 想要的形状 就找一个方向。
- 知识点：烟雾散开的流动就出来了 一边改CD值 一边找那个想要的那个形状吧 这个以中心为基准 然后写点什么的话 比起刚才的Shift 会更低一些吧。
- 知识点：那我们来试试 减小Turbine值的尺寸 要不要改改CD值呢 用更细致的噪音 烟雾就会像这样破碎消失吧 我们想在64帧左右 让烟雾消失 然后。
- 知识点：比如说 把背景换成暗色看看 更清楚点 因为烟还很多 把摔跤量调高点 挺好 那就调到64帧左右消失 这样调整复值 做出想要的形状就行 然后 像这样。
- 知识点：现在做的这个形状 看起来好像 可能没什么特别的 然后 这样 对然后 还有什么 比如说 其他造声模式 对然后 这样举个例子 然后相机这样调角度 提取原文件。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`烟雾`。

**关键画面：**

这张图是在 `UV、粒子、精灵` 段里，先用一个非常简化的体积结果去观察“类似 burst 生成后再散开”的基础形态，便于后续围绕粒子消散、CD 变化和精灵外观去调。

- 当前简化节点链仍为：
  - `sphere1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke1`
  - `pyrolook_billowy_smoke1`
- 当前高亮节点是 `pyrosolver_billowy_smoke1`，右侧位于 `Fields` 页。
- 可见的关键参数包括：
  - `Buoyancy Scale = 0`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
  - `Disturbance = 5`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Control Field = speed`
  - `Control Range = 0 -> 5`
  - `Turbulence = 1`
- 左侧视口中包围盒内只有一个较小的棕灰色体积团，盒外右侧则有一个黄色团块，说明当前发射结果更像一次性放出后沿既定方向分离、散开的状态，而不是持续喷发。
- 这与字幕“用 burst 方式看的话，就是这样生成然后散开”一致。当前图的作用是建立一个便于调节消散时机和形状方向的起点。
这张图是在同一 burst 风格案例上，直接通过更高的消散值和更暗的背景去检查烟雾会不会在目标帧数附近自然消失。

- 当前节点仍是 `pyrosolver_billowy_smoke1`，右侧位于 `Fields` 页，`Field Guides = Temperature`。
- 可见参数中最关键的当前变化是：
  - `Dissipation = 0.1`
  - `Clamp Below = 0.005`
  - `Use Control Field` 开启
  - `Control Field = temperature`
  - `Control Range = 0 -> 1`
  - `Remap Control Field` 开启，并保持一条从左高到右低的控制曲线
  - `Diffusion = 0`
  - `Cooling Rate = 0.5`
  - `Flame Lifespan = 2`
- 左侧视口背景已切为黑色，包围盒中的烟体因此更容易看清边缘和残留量。
- 当前烟雾呈现出从左下向右上拖开的多团块形态，已经明显比前一张更分散、更破碎，边缘处也更接近消散状态。
- 这与正文“把背景换成暗色看看，更清楚点”“想在 64 帧左右让烟雾消失”一致。当前图的重点是通过提高 `Dissipation` 去加快烟体消散，再配合黑底背景判断消失是否发生在合适时机。
这张图继续在黑底下观察同一个简化 burst 案例，但把烟雾形态收缩到了更单一的球状残留，用来判断“减小或改细噪声后，烟是否会更干净地破碎消失”。

- 当前仍选中 `pyrosolver_billowy_smoke1`，右侧处于 `Fields` 页。
- 可见的主要参数包括：
  - `Buoyancy Scale = 0`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
  - `Disturbance = 5`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Control Field = speed`
  - `Control Range = 0 -> 5`
  - `Turbulence = 2`
- 左侧视口中，包围盒内几乎只剩一个较完整的亮灰色球状体积，原先那种明显拉开的多团块结构已经不见，说明当前对比结果更集中、更短促。
- 黑色背景仍保留，方便直接看出体积边缘和剩余量。
- 结合正文里“用更细致的噪音，烟雾就会像这样破碎消失吧”“在 64 帧左右让烟雾消失”，这张图可以理解为：在 burst 生成基础上继续试更细的噪声/不同 turbulence 强度后，检查烟是否能更干净地收敛成短时残留，再尽快消失。

### 00:33:37-00:36:01 UV

- 本段定位：UV。
- 知识点：to make you Western UV Break 一一的想想 因为这是你想用的用途 这里已经有点噪音的模式了 嗯 如果频率周期密度变高 可能会出现看起来不太舒服的结果。
- 知识点：这种模拟资源要比你想的更简单点 拿去的用途可能更合适 我觉得这种东西 多做几次原文件 再带到虚幻里看 经验越多这种感觉 好像也能更快找到。
- 知识点：嗯 简单点也行 就把这个烟的流动这样调整一下 会更好 可以更熟悉 看着这些数值调整 看看怎么变化 亲眼确认这些是快速适应的好方法 所以根据这些自断的数值来调整会更好。
- 知识点：试着改变数值 尝试各种变化 现在比起创造某个结果 更重要的是亲身体会数值变化带来的差异 嗯 好的 那么这次就讲到这里 下次再继续 就到这里结束吧 谢谢 谢谢。

**关键画面：**

这张图在教程收尾的 `UV` 段里把参数页切到 `Setup`，开始从更底层的模拟分辨率和步进角度观察烟雾资源，而不是继续只调某个噪声值。

- 当前节点链仍是简化示例：
  - `sphere1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke1`
  - `pyrolook_billowy_smoke1`
- 当前选中节点是 `pyrosolver_billowy_smoke1`，右侧已切到 `Setup` 页。
- `General` 分组可见：
  - `Voxel Size = 0.05`
  - `Velocity Voxel Scale = 1`
  - `Time Scale = 1`
- `Simulation` 分组可见：
  - `Simulation Type = Sparse`
  - `Global Substeps = 1`
  - `Min Substeps = 1`
  - `Max Substeps = 1`
  - `CFL Condition = 1`
  - `Advection-Reflection = Disabled`
  - `Cache Memory (MB) = 5000`
- 左侧视口是黑底显示，包围盒中只剩一片较淡、接近消散末期的烟雾残影，说明当前更适合拿来观察整体分辨率和模拟表现，而不是看颜色或强烈流动。
- 结合这一段正文“比起创造某个结果，更重要的是亲身体会数值变化带来的差异”，这张图强调的是：先通过 `Voxel Size` 和基础模拟步进建立对资源粗细、稳定性和计算密度的直觉，再去做更细的 UV/外观调整。
这张图延续上一张的 `Setup` 参数观察，但把结果推进到了几乎完全消散的状态，用来确认在当前设置下，烟雾是否能在目标时段内干净退场。

- 当前仍选中 `pyrosolver_billowy_smoke1`，右侧仍位于 `Setup` 页。
- 当前图里可见的 `Setup` 参数与上一张一致：
  - `Voxel Size = 0.05`
  - `Velocity Voxel Scale = 1`
  - `Time Scale = 1`
  - `Simulation Type = Sparse`
  - `Global Substeps = 1`
  - `Min Substeps = 1`
  - `Max Substeps = 1`
  - `CFL Condition = 1`
  - `Advection-Reflection = Disabled`
  - `Cache Memory (MB) = 5000`
- 左侧黑底视口内，包围盒中几乎已经看不到明显烟体，只剩极淡的残影，整体比上一张更接近完全消失。
- 这说明当前调法已经把资源推进到“极简、快速退场”的方向，适合作为检查生命周期末端是否干净的对照状态。
- 结合正文“简单点也行，把这个烟的流动这样调整一下会更好”“亲眼确认这些是快速适应的好方法”，这一张的价值在于提醒：不一定每次都要追求复杂形态，先做出一个足够干净的消散基线，再根据需要慢慢加回细节。
这张图是本篇教程的收尾对照，重新回到 `Fields` 下半段，用一个很单纯的球状残留结果去提醒读者：反复改数值、直接观察差异，比一次就追到复杂造型更重要。

- 当前仍选中 `pyrosolver_billowy_smoke1`，右侧可见 `Disturbance`、`Turbulence` 和 `Viscosity` 区域。
- `Disturbance` 组当前可见：
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - `Use Control Field` 开启，`Control Field = speed`，`Control Range = 0 -> 5`
- `Turbulence` 组当前可见：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 2`
  - `Swirl Size = 1.2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 12`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - `Use Control Field` 开启，`Control Field = density`，`Control Range = 0 -> 1`
- 下方还能看到 `Viscosity = 0`。
- 左侧黑底视口中，包围盒里只剩一个较圆、较完整的单球状烟团，几乎没有复杂破碎边缘，说明这是一个非常简单、易对照的结果状态。
- 结合正文“试着改变数值，尝试各种变化，现在比起创造某个结果，更重要的是亲身体会数值变化带来的差异”，这张图的意义是把注意力放回实验方法本身：通过调整 turbulence 的强度、涡旋尺寸和随机种子，快速观察球状烟体怎样变化，从而积累直觉。

## 补充视觉证据

### S02 00:03:59

这张补充证据图回到教程前段的主节点链，用一张完整的 Houdini 界面截图把烟雾求解器前后的关键节点和主要字段参数同时固定下来，适合作为后续所有分段说明的总参照。

- 可见完整节点链为：
  - `smoke_base`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke`
  - `RENDER_Billowy_Smoke`
- 当前选中的是 `pyrosolver_billowy_smoke`，右侧位于 `Fields` 页面。
- 上半部分可见的基础场参数包括：
  - `Buoyancy Scale = 0.5`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
  - `Wind Speed = 2`
  - `Wind Direction = (1, 0, 0)`
- `Disturbance` 组可见：
  - `Disturbance = 15`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - `Use Control Field` 开启，`Control Field = speed`，`Control Range = 0 -> 5`
- 下方还能看到 `Turbulence` 已启用，首项可见 `Turbulence = 0.25`。
- 左侧视口中，烟团位于包围盒底部，呈现较低矮的早期体积状态。这与教程前段用于演示“温度、浮力、风向和扰动如何共同决定初始烟型”的语境相符。

### S05 00:13:08

这张补充证据图固定了教程中段“用较大的 disturbance 表现更粗、更破碎的烟雾纹理”时的实际界面状态，重点是把视口里的烟体结果与右侧噪声参数同时对齐。

- 当前节点链仍为：
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke`
  - `RENDER_Billowy_Smoke`
- 当前选中节点为 `pyrosolver_billowy_smoke`。
- 右侧上半部分可见基础场参数：
  - `Buoyancy Scale = 0.2`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
- `Disturbance` 组当前清晰可见：
  - `Disturbance = 50`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - `Use Control Field` 开启，`Control Field = speed`，`Control Range = 0 -> 5`
- `Turbulence` 组当前可见：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 0.25`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 0`
- 左侧视口中，烟柱已经形成较厚的蘑菇状团块，边缘卷曲但不算特别细碎；旁边的彩色导引体积说明这里仍在借助场引导确认分布。
- 结合字幕“可以表现出一些破碎的烟雾效果”，这张图证明的是：在 `Disturbance = 50` 的条件下，烟体已经获得明显的破碎轮廓，但仍保留整体体积感。

### S06 00:18:02

这张补充证据图固定了教程后段较温和的 turbulence 状态，用来辅助说明：当 `Turbulence` 下降、`Viscosity` 不额外增强时，烟柱主形会更完整，更适合拿来观察火焰/烟体纹理。

- 当前节点链仍为：
  - `smoke_base`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke`
  - `RENDER_Billowy_Smoke`
- 当前选中节点为 `pyrosolver_billowy_smoke`。
- `Disturbance` 组当前可见：
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.1`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.05`
  - `Use Control Field` 开启，`Control Field = speed`，`Control Range = 0 -> 5`
- `Turbulence` 组当前可见：
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 0.5`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 2`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1`
  - `Use Control Field` 开启，`Control Field = density`，`Control Range = 0 -> 1`
- 下方还能看到 `Viscosity = 0`。
- 左侧视口里的烟柱已经恢复为较完整的直立蘑菇状结构，底部拖尾明显、顶部团块饱满，旁边仍有彩色导引体积作为对照。
- 这张图说明在不增加粘性、只保留较温和 turbulence 的条件下，烟体不会被过度打散，更适合作为后续观察火焰纹理、材质显示和整体造型稳定性的基础状态。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


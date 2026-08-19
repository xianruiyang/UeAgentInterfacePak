# 13-4-Unreal导弹爆炸特效制作

# 13-4-Unreal导弹爆炸特效制作

## 关键术语

- `Color`、`Alpha`、`Material`、`Post Process`、`UV`、`Blueprint`、`Camera`、`Water`、`材质`、`后处理`、`Niagara`、`Particle`、`Normalized Age`、`Renderer`、`粒子`、`系统`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:03:01 Color、Material、Post Process

- 本段定位：Color、Material、Post Process。
- 知识点：朝向网格,也AX周对齐,使用网格效果。
- 知识点：我们刚才带来的网格资源放进去应该。
- 知识点：用overwrite把这个material做成instance来添加试试。
- 知识点：在这里呢,instance笔本,这个程度的数值做成。
- 知识点：article里面放material就行。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Material`。

**关键画面：**

本图继续编辑网格发射器 `Fire01009`，当前选中的是：

- `Particle Spawn > Initial Mesh Orientation`

中间 `System Overview` 当前可确认 `Fire01009` 的结构为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`
  - `Light Renderer`

右侧 `Initial Mesh Orientation` 面板可直接读取：

`Orientation`
- `Mesh Orientation Mode = Orient to Vector`
- `Orientation Vector = (1.0, 0.0, 0.0)`
- `Orientation Coordinate Space = Simulation`
- `Mesh Axis To Orient = (1.0, 0.0, 0.0)`

`Rotation`
- `Rotation` 复选框未启用
- 显示值为 `(0.0, 0.0, 0.0)`
- `Rotation Coordinate Space = Mesh`

空间约定：
- `subject`：`Fire01009` 中单个网格粒子的初始朝向
- `dimension`：三维方向
- `Fsemantic`：教程口语里的“按 X 轴对齐”
- `Fwrite`：Niagara `Initial Mesh Orientation` 模块
- `Fread`：当前截图右侧 `Orientation Vector / Mesh Axis To Orient / Coordinate Space`
- `Fverify`：两组向量都写成 `(1,0,0)`，且读取到的坐标空间是 `Simulation`
- `conversion_chain`：本图未出现跨坐标系换算，直接在 `Simulation` 空间内把网格自身待对齐轴也设为 `(1,0,0)`

因此，这一步能可靠确认的是：作者没有做额外旋转补偿，而是直接让网格在 `Simulation` 空间中按 `(1,0,0)` 的方向建立初始朝向，同时把“需要被对齐的网格轴”也指定为 `(1,0,0)`。这与正文“朝向网格”“按 X 轴对齐”的意图一致，作用是确保后续放入 `Mesh Renderer` 的资源不会以错误朝向横躺或竖起。
本图仍在网格发射器 `Fire01009`，当前选中的是：

- `Particle Update > Scale Color`

中间结构此时可确认：

- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`
  - `Light Renderer`
  - `Mesh Renderer`

右侧 `Scale Color` 面板可直接读取：

`Scale Mode`
- `RGB and Alpha Separately`

`Scale RGB`
- 运算方式：`Multiply Vector by Float`
- `Vector = (5.0, 1.0, 0.5)`
- `Float = 200000000.0`

`Scale Alpha`
- 类型：`Float from Curve`
- 曲线资源：`Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`

Alpha 曲线的可见形状为：
- 起始阶段接近 `0.9`
- 中段持续下降
- 末段收敛到接近 `0`

左侧 `Particle Counts` 同时显示：
- `Fire01009`：`0 Current, 1 Max (est.)`，`Complete`

结合本段标题里的 `Color、Material、Post Process`，以及字幕“color 不需要”，这张图说明作者在网格层上保留了标准的 `Scale Color` 模块，但当前更关注的是让网格通过极高亮度值参与后处理和整体泛光，而不是做复杂的颜色渐变。可复现为：用一个固定暖色向量 `(5,1,0.5)` 乘上极大的亮度系数，再配合单独的 Alpha 衰减曲线，让网格在爆炸瞬间足够亮、能吃到后处理 Bloom，但可见度会随生命周期逐步减弱。
本图从 Niagara 编辑器切回关卡视口，目的是直接观察前面网格、材质和高亮度设置叠到实景后的整体效果。画面可直接确认：

- 爆炸主体在场景中央，呈现大块高亮白橙色核心，外围包着红黑烟团
- 地面附近还能看到数个较低位置的附加火团
- 整体已经明显吃到较强的后处理 Bloom，中心高亮区域发白并外溢

右侧 `Outliner` 当前搜索关键字为：

- `light`

可见若干与场景灯光有关的对象，例如：
- `Dungeon_Lights`
- `Global_Lighting`
- `DirectionalLight`
- `SkyLight`
- 多个 `SpotLight`
- `PointLight`

底部内容浏览器当前路径为：

- `Content > Signature > Course_05 > Material`

当前选中的资源可直接辨认是：

- `M_Refraction_01_Ins_01`

同一行里还能看到一组相关材质资源：
- `M_Additive_01`
- `M_Additive_01_Ins_01`
- `M_Additive_01_Ins_02`
- `M_Fire_01`
- `M_Fire_01_Ins_01`
- `M_Fire_01_Ins_02`
- `M_Refraction_01`
- `M_Rock_01`

这张图虽然不展示具体节点或参数，但它把本段“Color、Material、Post Process”的结果验证清楚了：当前爆炸效果已经进入实景评估阶段，作者一边在材质目录里选择/切换实例，一边直接观察亮度、烟火层次和后处理反馈。对复现而言，这意味着不能只在 Niagara 面板里看数值，必须回到关卡视口检查实际 Bloom、烟团层次和场景灯光环境下的成像结果，否则很容易出现编辑器里看着成立、落到场景里却过亮或层次失衡的问题。

### 00:03:17-00:06:09 Alpha、Post Process、Blueprint

- 本段定位：Alpha、Post Process、Blueprint。
- 知识点：这部分很简单,就能让水这个材质参数集合里的数值动起来。
- 知识点：后续会之前在Zombia上使用过的这个water参数集合放在这里。
- 知识点：生成的参数名称将更改为alpha,并添加一个变量,这里也会更改为alpha。
- 知识点：现在就把这部分放到参数集合里。
- 知识点：把galalpha这样连接起来,然后就做出一个简单的bp。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Blueprint`、`材质`、`渲染器`、`生命周期`。

**关键画面：**

本图进入 `### 00:03:17-00:06:09 Alpha、Post Process、Blueprint` 段，当前新建并选中了一个发射器：

- `Fire01010`

中间 `System Overview` 可直接确认其结构为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

右侧 `Mesh Renderer` 面板可直接读取：

`Mesh Rendering`
- `Meshes = 1 Array element`
- `Index [0] = SM_FX_BasePlane`
- `Enable Material Overrides` 已启用

`Override Materials`
- `1 Array element`
- `Index [0]`
  - `Explicit Mat = M_Refraction_01_Ins_01`
  - `User Param Binding = None`

其他可见设置：
- `Source Mode = Particles`
- `Locked Axis Enable` 未启用
- `Enable Mesh Flipbook` 未启用
- `Facing Mode = Camera Plane`
- `Sort Mode = None`
- `Enable Frustum Culling` 未启用
- `Enable Camera Distance...` 未启用
- `Renderer Visibility = 0`

左侧 `Particle Counts` 也能确认：
- `Fire01010`：`0 Current, 1 Max (est.)`，`Complete`

这张图说明作者在 `Fire01010` 里做的不是普通火焰 sprite，而是一张单粒子的平面网格折射层：网格资源使用 `SM_FX_BasePlane`，材质覆盖成 `M_Refraction_01_Ins_01`，并把 `Facing Mode` 设成 `Camera Plane`。结合本段主题 `Alpha、Post Process、Blueprint`，可以把它理解为一个面向镜头的折射/后处理载体，后面会通过动态参数或 Blueprint 去驱动材质实例里的某些值，而不是直接在 Niagara 里把所有动画都烘死。
本图切到 Blueprint 编辑器，当前打开的是：

- `BP_ZoomPP`
- `Parent class: Scene Component`
- 视图位置：`Event Graph`

左侧 `My Blueprint` 区域可见：
- `EventGraph`
- `Event Begin Play`
- `Event Tick`

中间图表中当前实际接线很简单：

- `Event Tick`
  - 执行引脚直接连到
- `Set Scalar Parameter Value`

`Set Scalar Parameter Value` 节点上当前可直接读出的字段：
- `Collection = MPC_ZoomBlu...`（名称被界面截断，只能可靠确认前缀为 `MPC_ZoomBlu`）
- `Parameter Name` 目前为空，正在准备填写
- `Parameter Value = 0.0`

上方还能看到 `Event Begin Play` 节点，但没有接线参与当前逻辑。

结合本段正文“生成的参数名称将更改为 alpha，并添加一个变量，这里也会更改为 alpha”“把这部分放到参数集合里”，这张图说明作者开始把折射/后处理控制从 Niagara 转到 Blueprint：在 `Tick` 中持续向 `Material Parameter Collection` 写一个标量值，后续会把该标量名统一改成 `alpha`，作为材质或后处理实例的外部驱动参数。对复现而言，关键不是只建一个蓝图壳子，而是明确使用 `Set Scalar Parameter Value` 操作 `MPC`，让材质侧能在运行时拿到实时变化的 `alpha`。
本图回到 `Fire01010`，当前查看的是：

- `Particle Spawn > Initialize Particle`

右侧 `Initialize Particle` 面板当前可直接确认：

`Point Attributes`
- `Lifetime Mode = Direct Set`
- `Lifetime = 0.5`
- `Color Mode = Direct Set`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 200.0)`
- `Mass Mode = Unset / (Mass of 1)`

`Sprite Attributes`
- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Unset`
- `Sprite UV Mode = Unset`

`Mesh Attributes`
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale = (1.0, 5.0, 5.0)`
- `Mesh Renderer Array Visibility Mode = Unset`

`Ribbon Attributes`
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

中间 `System Overview` 相比前一张能看到更关键的接线结果：

- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`
  - `BP Zoom PP Renderer`
  - `Component Renderer`

左侧 `Particle Counts` 同时显示：
- `Fire01010`：`0 Current, 1 Max (est.)`，`Complete`

这张图说明 `Fire01010` 不只是一个带折射材质的平面网格层，它还已经把前面做的 Blueprint/组件渲染链路接回了 Niagara。也就是说，这里除了 `Mesh Renderer` 负责可见平面外，还额外挂了 `BP Zoom PP Renderer` 与 `Component Renderer`，用于把 Blueprint 组件实例化进这层效果。结合正文“用这个值定生命周期就行”“做出一个简单的 bp”，可以把这一步理解为：网格折射层的寿命固定为 `0.5` 秒，位置抬到 `Z=200`、尺度为 `(1,5,5)`，同时通过组件渲染把 `BP_ZoomPP` 之类的后处理控制对象跟粒子生命周期绑定，让外部 `alpha` 驱动也跟着这一层一起出现和结束。

### 00:06:19-00:09:15 Alpha、Post Process、材质

- 本段定位：Alpha、Post Process、材质。
- 知识点：要绑定这里,因为没有particle。
- 知识点：alpha这个按钮其实是创建一个particle。
- 知识点：创建一个plot属性命名为alpha。
- 知识点：这里添加了一个set参数。
- 知识点：取回刚才创建的alpha值。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Alpha`、`材质`、`粒子`。

**关键画面：**

本图位于 `### 00:06:19-00:09:15 Alpha、Post Process、材质` 段，当前继续查看 `Fire01010` 的组件渲染器设置，焦点在：

- `Render > BP Zoom PP Renderer`

中间 `System Overview` 当前可见 `Fire01010` 的结构为：

- `Particle Spawn`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Dynamic Material Parameters`
  - `Set Parameters`
- `Render`
  - `Mesh Renderer`
  - `BP Zoom PP Renderer`
  - `Component Renderer`

右侧 `BP Zoom PP Renderer` 面板可直接读取：

`Component Rendering`
- `Component Type = BP_ZoomPP`
- `Component Count Limit = 15`
- `Enabled Binding = PARTICLES.ComponentsEnabled`
- `Renderer Visibility Tag = PARTICLES.VisibilityTag`
- `Renderer Visibility = 0`

`Component Properties`
- `Default > Alpha = 0.0`

下方还能看到多组折叠区域：
- `Transform`
- `Rendering`
- `Physics`
- `Mobility`
- `LOD`
- `ComponentTick`
- `Tags`
- `Replication`
- `Variable`
- `Navigation`
- `Cooking`

`Scalability`
- 可见 `Low / Medium / High / Epic / Cinematic`
- `Allow in Cull Proxies` 已启用

左侧属性浏览面板当前列出了系统属性，但并未展开到具体 `particle.alpha` 字段；不过从字幕“particle.alpha 是创建一个 particle.alpha 属性”以及当前栈里新增 `Set Parameters` 可以确认，作者正在把 Niagara 粒子属性与 `BP_ZoomPP` 组件上的 `Alpha` 字段接起来。对复现而言，这一步的关键是：组件渲染器并不只负责生成 Blueprint 组件实例，还需要给组件暴露一个默认 `Alpha=0.0` 的可绑定属性，然后通过粒子属性去驱动它。
本图继续在 `Fire01010` 内把 `alpha` 接到真正的后处理组件。当前画面能明确确认两件事：

1. 左侧属性浏览已经出现粒子属性：
- `PARTICLES.Alpha`

2. 右侧当前选中的渲染器已经变成：
- `Post Process Component Renderer`

中间 `System Overview` 当前可见 `Fire01010` 的关键结构为：

- `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Dynamic Material Parameters`
  - `Set: PARTICLES Alpha`
- `Render`
  - `Mesh Renderer`
  - `BP Zoom PP Renderer`
  - `Post Process Component Renderer`

右侧 `Post Process Component Renderer` 面板可直接读取：

顶部警告信息说明：
- Post process 组件在 `PostProcessVolume` 中还有独立的 `Enabled` 标志
- 如果想在粒子死亡时禁用该组件，需要额外处理，否则组件会回到组件池中并继续影响场景

`Component Rendering`
- `Component Type = PostProcessComponent`
- `Component Count Limit = 15`
- `Enabled Binding = PARTICLES.ComponentsEnabled`
- `Renderer Visibility Tag = PARTICLES.VisibilityTag`
- `Renderer Visibility = 0`

`PostProcessVolume`
- `Priority = 0.0`
- `Blend Radius = 100.0`
- `Blend Weight = 1.0`
- `Enabled` 已启用
- `Unbound` 已启用

左侧 `Particle Counts` 与属性列表当前还能确认：
- `Fire01010` 已处于 `Active`
- `PARTICLES.Alpha` 已正式成为粒子属性之一

这张图把本段“Alpha、Post Process、材质”的核心做法钉死了：作者不是只在 Blueprint 里单独改一个 MPC，而是直接在 Niagara 里创建 `PARTICLES.Alpha`，再通过 `Set Parameters` 给它赋值，并把该粒子属性交给 `Post Process Component Renderer` 所对应的后处理组件使用。这样后处理体积就能跟随粒子的生命周期出现、叠加、消失，而不是常驻在场景里。
本图从 Niagara 编辑器回到场景视口，当前是在海边岩石场景里直接观察效果载体所在的环境位置。画面里能确认：

- 视口正对一片不平整的岩石地形
- 当前选中了一个静态网格对象，黄色描边框住了大块岩石区域

右侧 `Outliner` 当前层级为：
- `Main (Editor)`
  - `Beach`
  - `Beach_SMs`

当前选中的对象名称可读为：
- `SM_Nordic_Beach_Rock_Forma...`（名称被面板截断，只能可靠确认前缀为 `SM_Nordic_Beach_Rock_Forma`）

右下 `Details` 面板可确认：
- 选中对象类型为 `StaticMeshComponent`
- `Initial Life Span = 0.0`
- `Spawn Collision Handling = Always Spawn, Ignore Collisions`

底部内容浏览器仍位于：
- `Content > Signature > Course_05 > Material`

可见的材质资源包括：
- `M_Smoke_01`
- `M_Smoke_01_Ins_01`
- `M_Smoke_01_Ins_02`
- `M_Smoke_01_Ins_03`
- `M_SmokeMV_01`
- `M_SmokeMV_01_Ins_01`
- `M_SmokeMV_01_Ins_02`
- `M_Translucent_01`
- `M_Translucent_01_Ins_01`
- `M_Translucent_01_Ins_02`

这张图没有显示新的 Niagara 参数，但它说明作者已经回到真实地表环境里检查后处理/折射层与场景岩石的贴合感。结合前面 `Post Process Component Renderer` 和 `particle.alpha` 的设置，这一步的意义是验证：当后处理体积和折射平面叠到实际地形上时，是否会在岩石表面产生合适的空间覆盖和视觉影响，而不是只在空背景或独立预览窗口里看起来成立。

### 00:09:18-00:12:14 UV

- 本段定位：UV。
- 知识点：现在红色字出现在那里。
- 知识点：现在乍一看好像没什么大问题。
- 知识点：得一个个看看再解决。
- 知识点：现在灰尘好像都堆在上面了。
- 知识点：要不要拍另一边? 再平一点的地方。

**关键画面：**

本图进入 `### 00:09:18-00:12:14 UV` 段，当前已经从编辑状态切到场景中的实时视角检查。画面可直接确认：

- 摄像机面向海边岩石与远处海面
- 右下角能看到武器或第一人称持有物的一部分模型
- 场景中央偏远处有一个明显的黄色球体标记

右侧 `Outliner` 仍停留在：
- `Main (Editor)`
  - `Beach`
  - `Beach_SMs`

视口左上角还有一条运行时警告：
- `Video memory has been exhausted ... Expect extremely poor performance.`  
  这说明当前画面是在显存紧张的实时运行/预览状态下截取的。

底部内容浏览器仍位于：
- `Content > Signature > Course_05 > Material`

可见一组与烟雾、透明材质相关的资源：
- `M_Smoke_01`
- `M_Smoke_01_Ins_01`
- `M_Smoke_01_Ins_02`
- `M_Smoke_01_Ins_03`
- `M_SmokeMV_01`
- `M_SmokeMV_01_Ins_01`
- `M_SmokeMV_01_Ins_02`
- `M_Translucent_01`
- `M_Translucent_01_Ins_01`
- `M_Translucent_01_Ins_02`

这张图没有展开具体 UV 参数，但它说明作者在 `UV` 段开始时已经把检查目标切成“场景中实际落地后的表现”，而不是继续只看节点。结合正文“现在红色字出现在那里”“现在灰尘好像都堆在上面了”，这一步的意义是从玩家观察角度确认贴图方向、堆积位置和屏幕上的异常分布，为后续逐项排查 UV 或朝向问题做基准。
本图仍在 `UV` 段的实时视角检查中。与上一张相比，当前已经能直接看到爆炸效果在玩家视角下的实际落点和分层：

- 视野上方中央有一大团高亮红橙色烟火主体
- 左侧远处还有一团较小的次级烟团
- 地面前景分布着多条发亮的火星/碎焰拖线
- 右侧中景有一个明显的地面火点
- 画面底部和近景地面出现零散发红的亮片状点

场景与界面状态可确认：
- 仍是第一人称/持枪视角
- `Outliner` 处于 `Main (Play In Editor)`，说明这是 PIE 运行中的实时观察
- 底部内容浏览器仍停留在 `Content > Signature > Course_05 > Material`

这张图虽然没有直接展示 UV 节点，但它把“问题出现在哪”可视化了：烟团主体明显悬在上方，而地面零散火星与碎点落在下方和近景，这正符合正文里“现在灰尘好像都堆在上面了”“要不要拍另一边，再平一点的地方”的排查语境。对复现或修正而言，这一步不是新增模块，而是用实景结果判断当前贴图朝向、UV 分布或粒子落位是否让某些层过分集中在上半部，进而决定后面应该回到材质或渲染器去修 UV/朝向问题。
本图继续停留在 `UV` 段的同一类玩家视角检查，但当前爆炸主体已经基本退去，画面只保留：

- 远处海面与雾层
- 近景岩石地面
- 右侧中景一处小火点
- 左上区域残留的淡烟/雾气

界面状态仍可确认：
- `Outliner` 为 `Main (Play In Editor)`
- 仍处于第一人称持枪视角
- 左上角继续出现显存不足警告
- 底部内容浏览器仍位于 `Content > Signature > Course_05 > Material`

这张图的价值在于它展示了同一视角下效果衰减后的最终落点：当前画面没有继续保留大片悬空高亮烟团，主要只剩环境雾感和少量地面残火。结合正文“这样感觉比刚才自然多了”的语境，可以把它理解为作者在验证 UV/朝向或分布调整后，效果是否从“上方堆积、显得不自然”回到更贴地、更分散的收尾状态。对复现而言，这一帧可以作为验收目标之一：爆炸过后不应长期悬着大块发亮烟贴，而应逐步退成场景里更自然的雾和少量残余火点。

### 00:12:17-00:13:38 颜色

- 本段定位：颜色。
- 知识点：皮肤值原本在爆炸那边用的那个值直接导入使用了。
- 知识点：这样就会自然地放在下面。
- 知识点：这种话刚才这种值不降应该也没关系。
- 知识点：这样感觉比刚才自然多了。
- 知识点：石头有点太黑了,显得有点突出啊。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

本图进入 `### 00:12:17-00:13:38 颜色` 段，仍在 `Main (Play In Editor)` 的第一人称场景视角里检查结果。画面可直接确认：

- 黄色球形标记位于近景地面偏下区域
- 远处海面和岩石保持雾化背景
- 右侧中景仍有一处地面火点
- 底部可见玩家手持物/武器模型

界面状态：
- `Outliner` 为 `Main (Play In Editor) > Beach > Beach_SMs`
- 左上角继续出现显存不足警告
- 底部内容浏览器仍位于 `Content > Signature > Course_05 > Material`

结合本段正文“这样就会自然地放在下面”“这样感觉比刚才自然多了”，这张图说明作者此时关注的不是新增模块，而是颜色或相关参数调整后，效果落点是否终于贴近地面，而不是漂在上方。黄色球形标记在这里可作为观察基准点：当前要确认的是爆炸相关层在玩家视角下是否更自然地压到地表附近，从而让整体视觉重心回到底部区域。
本图继续是 `颜色` 段的玩家视角结果检查，但当前已经进入爆炸触发瞬间。画面可直接观察到：

- 中央近距离爆炸核心强烈过曝，主体几乎发白
- 周围包着高亮红橙色火焰轮廓
- 画面边缘和火点周围出现明显的红/绿/蓝色散边
- 地面与视野边缘同时出现强烈拉伸和模糊感
- 右下角武器模型也被一起卷入后处理失真

界面状态仍可确认：
- `Outliner` 为 `Main (Play In Editor)`
- 底部内容浏览器仍在 `Content > Signature > Course_05 > Material`
- 左上角继续出现显存不足警告

这张图说明 `颜色` 段的调整并不只是把火焰颜色换一下，而是会直接影响爆炸近景时的最终成像强度。当前成像同时包含：
- 超高亮的爆炸核心
- 显著的后处理色散/像差
- 强烈的镜头拉伸或径向模糊

结合字幕“对石头碎片的火”以及正文“石头有点太黑了，显得有点突出”，可把这一步理解为作者正在检查：当爆炸最亮的时候，火焰颜色、碎片火点和整体后处理叠在一起是否过重，是否会把前景岩石压得太黑、或者让局部高亮过于刺眼。对复现而言，这一帧应作为峰值检查帧，用来判断颜色与后处理强度是否失衡。
本图从场景视角回到 Niagara 系统总览，当前选中的是：

- `Fire01008 > Particle Spawn > Add Velocity`

左侧 `Particle Counts` 可直接确认当前系统里多层发射器同时处于活动状态，包括：
- `Fire01001`
- `Fire01002`
- `Fire01006`
- `Fire01003`
- `Fire01004`
- `Fire01005`
- `Fire01007`
- `Source`
- `Source001`
- `Fire01008`
- `Fire01009`
- `Fire01010`

左下属性浏览区域还能看到粒子属性中已有：
- `PARTICLES.Alpha`
- `PARTICLES.Color`
- `PARTICLES.DistanceTraveled`
- `PARTICLES.DynamicMaterialParameter`
- `PARTICLES.INITIAL.Color`

右侧当前 `Add Velocity` 面板可直接读取：

`Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed = 100.0`
- `Constrain To Radius = 0.0`

`Offset`
- `Velocity Origin = ENGINE / EMITTER / SimulationPosition`
- `Origin Offset = (0.0, 0.0, 0.0)`
- `Origin Offset Coordinate Space = Local`

虽然这张图没有展示新的颜色曲线，但它把一个重要事实钉死了：颜色段的调整不是孤立处理，而是建立在完整爆炸系统所有层一起工作的前提下。字幕“爆炸部分的图像缺失感可以更快地消失”对应的，就是让像 `Fire01008` 这类从中心向外推开的层在整体观感上更快散掉，不要让中心留下过久的空洞感或反差突兀的缺失感。对复现而言，这意味着颜色段的验收要结合整套多发射器同时运行的结果来看，而不能只盯单个材质实例。

### 00:20:17-00:20:37 关键流程 06

- 本段定位：关键流程 06。
- 知识点：时间拖得有点长,辛苦大家就跟上了。

**关键画面：**

本图进入 `### 00:20:17-00:20:37 关键流程 06` 段。当前仍是 `Main (Play In Editor)` 的第一人称结果视角，但成像几乎完全被爆炸峰值吞没。画面可直接确认：

- 画面中央和左侧被极强的白橙色爆炸核心覆盖
- 周围伴随明显的红色泛光、模糊和边缘色散
- 近景地面出现从中心向外放射的亮色拖痕
- 右下角武器模型同样被后处理拖拽和染色

界面状态仍可确认：
- `Outliner` 为 `Main (Play In Editor)`
- 左上角继续出现显存不足警告
- 底部内容浏览器仍停留在 `Content > Signature > Course_05 > Material`

由于这一段正文只有“时间拖得有点长”，而当前图片本身不展示新的 Niagara 参数，所以这张图能可靠确认的是最终结果目标：作者在关键流程回放中重新检查爆炸峰值阶段的持续时间和视觉冲击力。对复现而言，这一帧说明峰值效果已经被做得极强，后续若要“缩短时间”或“让观感退得更快”，就必须从这类几乎淹没整个视野的峰值阶段入手，而不是只调收尾烟层。
本图仍在 `关键流程 06` 的结果回看中，但时间点已经晚于上一张，爆炸主峰明显开始退去。当前画面可直接确认：

- 上方保留大块黑灰烟团，并夹杂暗红色内部亮区
- 中景右侧还有一团独立烟团
- 近景地面散落多条发亮的火星拖线和碎焰点
- 右下角武器模型已不再被极端白化，但仍处于战斗视角中

界面状态保持不变：
- `Outliner` 为 `Main (Play In Editor)`
- 底部内容浏览器仍在 `Content > Signature > Course_05 > Material`

结合字幕“那么这次就到这里吧”，这张图更像关键流程展示的收尾状态。它说明在同一次爆炸播放里，峰值高亮之后会很快转入“上方烟团 + 地面火星 + 少量碎片”的收尾构图，而不会一直维持满屏白光。对复现而言，这一帧可以作为关键流程的中后段验收点：峰值结束后，应迅速显露出烟层体积和地面火星细节，让场景重新可读。
本图仍属于 `关键流程 06`，但时间点已经来到流程尾声。当前画面可直接确认：

- 爆炸主体、烟团和火星都已基本消失
- 场景重新回到海边岩石与远处海面的常态视图
- 右下角武器模型保持可见，说明仍处在玩家运行视角

界面状态：
- `Outliner` 为 `Main (Play In Editor)`
- 底部内容浏览器仍位于 `Content > Signature > Course_05 > Material`

字幕“时间拖得有点长，辛苦大家跟上了”与当前空场景状态结合起来，说明这张图承担的是关键流程播放完毕后的收尾验证作用。它给出的结论很直接：这套爆炸流程最终应该完整退场，不应在环境里长期残留显眼的高亮团块、烟柱或后处理失真。对复现而言，这一帧可作为关键流程的结束验收点，用来确认整套效果在播放末端是否能顺利回归到正常场景可读性。

## 补充视觉证据

### S02 00:04:33

本图是 `## 补充视觉证据` 中对前文 `S02` 段 Blueprint 参数设置的近距离补拍，当前打开的是：

- `BP_ZoomPP`
- `Parent class: Scene Component`
- `Event Graph`

左侧 `My Blueprint` 区域可见：
- `EventGraph`
- `Event Begin Play`
- `Event Tick`

中间图表中当前实际连线为：
- `Event Tick`
  - 执行引脚直接连到
- `Set Scalar Parameter Value`

与前面的普通截图相比，这张补图更清楚地展示了 `Set Scalar Parameter Value` 节点当前的未填写状态：

- `Collection` 仍处于 `Select Asset`
- `Parameter Name` 仍为空
- `Parameter Value = 0.0`

上方 `Event Begin Play` 依旧可见，但没有接入当前逻辑。

这张补图的作用是把 `S02_2` 中“用 Blueprint 每帧写标量参数”的做法补证得更完整：作者此时确实是在 `Tick` 上挂了 `Set Scalar Parameter Value`，并准备把一个 `Material Parameter Collection` 标量接进来，而不是在 Blueprint 里做别的流程控制。结合正文“生成的参数名称将更改为 alpha，并添加一个变量，这里也会更改为 alpha”，可复现为：先搭好 `Tick -> Set Scalar Parameter Value` 的骨架，再给节点填入具体的 `MPC` 资产和 `alpha` 参数名，让运行时材质参数能够持续被外部驱动。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


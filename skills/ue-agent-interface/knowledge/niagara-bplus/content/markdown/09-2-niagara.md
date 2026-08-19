# 09-2 制作Niagara粒子特效

# 09-2 制作Niagara粒子特效

## 关键术语

- `Alpha`、`材质`、`粒子`、`精灵`、`网格`、`碰撞`、`生命周期`、`速度`、`Niagara`、`Normalized Age`、`纹理`、`系统`、`蓝图`、`颜色`、`透明度`、`曲线`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:02:56 精灵、曲线

- 本段定位：精灵、曲线。
- 知识点：这个图我也会降低到5 然后将x、y、z值调整为0.22 然后增加向上的以 那么就会比刚才的 向上得多 并且比散布的灰尘 这个朋友需要更好地显示。
- 知识点：因此将排序顺序调高到10 而且我们现在没有修改大小 感觉有点太长了 延伸到250、400、300和600左右 让它有点动画效果 然后在形状位置上更改种子值。
- 知识点：让这种感觉更明显 还会增加一下精灵大小 x、y变化值可以用非均匀曲线 从0.55开始然后调整到1.25左右 将时机拉到大约0.5 这样可能会产生一些张力。
- 知识点：我们觉得放射状的灰尘散布的太远了 也许应该快点停下来 但留有余韵,缓缓散开。
- 核对对象：`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01001` Scale Velocity 曲线微调
> - 组成部分: Preview + Niagara Stack + Scale Velocity Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Smoke_01001 / Scale Velocity`
> - 目的: 将第二层烟雾速度衰减曲线从高值快速降低，减少过度扩散。
>
> Scale Velocity Details:
> | 字段 | 值 |
> |---|---|
> | Coordinate Space | `Local` |
> | Velocity Scale | `Multiply Vector by Float` |
> | Vector | `1.0, 1.0, 1.0` |
> | Float | `Float from Curve` |
> | FloatCurve | `Curve for Floats` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0` |
>
> 曲线:
> - 右侧曲线从起始约 `5` 下降到生命周期末端 `0`。
> - 悬停提示显示 `FloatCurve` 关键点 Time `0.1`、Value `4.019`。
> - 左下 Curve Editor 中同一红色曲线从高值快速衰减到接近 `0`。
>
> Preview: 左侧可见褐灰色烟雾块围绕中心区域形成较密的烟雾团。
>
> 联动关系: `Add Velocity` 先为烟雾提供从点发散的速度，`Scale Velocity` 再用 `Particles.NormalizedAge` 曲线限制后续扩散速度。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01001` Initialize Particle 尺寸调整
> - 组成部分: Preview + Niagara Stack + Initialize Particle Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Smoke_01001 / Initialize Particle`
> - 目的: 将第二层烟雾的 Sprite 改为随机非均匀尺寸，并使用随机 X 向 SubUV。
>
> Initialize Particle Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Random` |
> | Point Attributes | Lifetime Min | `1.5` |
> | Point Attributes | Lifetime Max | `2.0` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Point Attributes | Position Offset | `0.0, 0.0, 20.0` |
> | Point Attributes | Position Offset Coordinate Space | `Simulation` |
> | Sprite Attributes | Sprite Size Mode | `Random Non-Uniform` |
> | Sprite Attributes | Sprite Size Min | `250.0, 400.0` |
> | Sprite Attributes | Sprite Size Max | `300.0, 600.0` |
> | Sprite Attributes | Sprite Rotation Mode | `Unset` |
> | Sprite Attributes | Sprite UV Mode | `Random X` |
>
> Preview: 烟雾块在中心发光附近出现更高、更长的片状灰尘形态。
>
> 联动关系: 非均匀随机尺寸让每个烟雾 Sprite 在宽高上产生差异，`Random X` 让序列/图块采样变化，配合速度曲线产生更自然的烟尘层。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01` 与 `Smoke_01001` 速度/尺寸曲线对照
> - 组成部分: Preview + Niagara Stack + Scale Velocity Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Smoke_01 / Scale Velocity`
> - 目的: 对照两层烟雾的速度衰减和尺寸变化曲线，使烟雾更快停止扩散但保留尾韵。
>
> Scale Velocity Details:
> | 字段 | 值 |
> |---|---|
> | Coordinate Space | `Local` |
> | Velocity Scale | `Multiply Vector by Float` |
> | Vector | `1.0, 1.0, 1.0` |
> | Float | `Float from Curve` |
> | FloatCurve | `Curve for Floats` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0` |
>
> 曲线信息:
> - 右侧红色速度曲线从约 `6` 降到 `0`，当前 Key Data 显示时间约 `0.7`、值 `0.0`。
> - 左下 Curve Editor 中可见非均匀尺寸曲线：绿色曲线从低值快速升到约 `1.25` 并保持，红色曲线保持约 `1.0`。
>
> Preview: 左侧烟雾与中心发光共同可见，烟雾块不再向远处继续强烈扩散。
>
> 联动关系: `Scale Velocity` 控制扩散衰减，非均匀尺寸曲线控制烟雾 Sprite 的形状张力，两者共同让烟雾从爆发到余韵过渡。

### 00:03:30-00:08:22 Alpha、材质、粒子

- 本段定位：Alpha、材质、粒子。
- 知识点：接下来 颜色适当降低一下亮度 饱和度太高了 适当降低一些饱和度 本身纹理中已经有一定的值了 将其调整到这个值的0.1 这种感觉可能会出现。
- 知识点：Alpha可以保持不变 在这里的视图中 某种C的值可能看起来不太好看 但在我们看到的相机视图中 感觉还不错 然后适当让Alpha更随机一些。
- 知识点：大约在1.75到1.25之间 有深色的朋友也有浅色的朋友 这样放置会更好 适当让Blend更丰富第一填充空间 那么继续,如果有碎片 感觉会更强烈。
- 知识点：需要复制一下碎片放进去 命名为Zerberis工医 这里也需要用不同的材质 纹理会改变 嘴先用一点黑色 黄油感的 这个纹理我觉得不错。
- 知识点：这个纹理没有Alpha通道 所以需要关闭Alpha保持 关闭Alpha保持后 这个似乎也不太需要渐变 然后将色调降低 适当深一些的颜色。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`纹理`、`粒子`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01001` Scale Color 亮度与 Alpha 曲线
> - 组成部分: Preview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Smoke_01001 / Scale Color`
> - 目的: 降低第二层烟雾亮度与饱和度，并用曲线控制 RGB/Alpha 衰减。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `1.2, 1.0, 0.8` |
> | RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Scale Curve | `1.0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `1.0` |
>
> 曲线:
> - RGB 曲线前段接近 `1.0`，随后向约 `0.2` 降低。
> - Alpha 曲线前段接近 `0.9`，随后随 NormalizedAge 降到接近 `0`。
>
> Preview: 烟雾颜色偏灰褐，亮度较上一段更低。
>
> 联动关系: RGB 向量和曲线降低烟雾亮度/饱和度，Alpha 曲线控制烟雾透明度随生命周期衰减。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01001` Emitter 与 Spawn 复查
> - 组成部分: Niagara Stack + Emitter Details + Spawn Burst Details + Timeline
> - 所属: `Exp_01 / Smoke_01001`
> - 目的: 在添加碎片前确认第二层烟雾发射器仍保持一次性生成 7 个粒子。
>
> Emitter Properties:
> | 字段 | 值 |
> |---|---|
> | Local Space | Enabled |
> | Determinism | Disabled |
> | Interpolated Spawning | Enabled |
> | Sim Target | `CPUSim` |
> | Calculate Bounds | `Dynamic` |
> | Requires Persistent IDs | Disabled |
>
> Spawn Burst Instantaneous:
> | 字段 | 值 |
> |---|---|
> | Spawn Count | `7` |
> | Spawn Time | `0.0` |
> | Spawn Probability | `1.0`，字段未启用 |
> | Loop Count Limit | `1`，字段未启用 |
>
> 联动关系: 该图是 `Smoke_01001` 的生成数量复查；后续碎片元素将作为新的 `Debris_01` 发射器添加，而不是修改此烟雾发射器。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` SubUV Animation 设置
> - 组成部分: Preview + Niagara Stack + SubUV Animation Details + Timeline
> - 所属: `Exp_01 / Debris_01 / Sub UV Animation`
> - 目的: 新增碎片发射器，并让碎片从 2x2 图块中随机选择帧。
>
> Sub UV Animation Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Setup | SubUV Animation Mode | `Random` |
> | Setup | Start Frame Range | 未启用，值 `0` |
> | Setup | End Frame Range | Enabled，值 `3` |
> | Setup | Renderer Type | `Sprite` |
> | Sprite Renderer Info | Sprite Renderer | `Sprite Renderer` |
> | Animation | Evaluation Type | `Spawn Only` |
> | Output | Output Alternate Result | 未启用 |
>
> Stack 状态:
> - `Debris_01` 中可见 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Shape Location (Ring / Disc)`、`Add Velocity (From Point)`、`Particle State`、`Scale Sprite Size`、`Sub UVAnimation (Random)`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color` 和 `Sprite Renderer`。
>
> Preview: 中心发光上方可见较小、灰白的碎片/颗粒点，叠加在烟雾层前。
>
> 联动关系: `End Frame Range=3` 对应 2x2 SubUV 中 0-3 的 4 帧随机取样，`Spawn Only` 表示粒子出生时确定帧，而不是逐帧播放动画。

### 00:08:22-00:11:32 精灵、速度

- 本段定位：精灵、速度。
- 知识点：而且这个不会使用速度对齐 还有0.5和舒轴值也会移动到中心 自己全部设置为一次 这里也会设置为一次 然后生成数量大约喷洒15个 寿命就可以保留不变。
- 知识点：为了让那个感觉更远的爆炸 适当从上面而且随机均匀 大小设置为大约150 随机X 旋转可以给随机值 然后形状位置 需要使用圆形 会多给一些随机。
- 知识点：种子值也得有吧 但是这里的涂让不符 随机破裂到一定程度 应该没关系 像灰尘一样填满空间的感觉 不是元素 还有速度会用作起点。
- 知识点：刚才那个位置值大约在50左右 所以向上 会有某种东西掉落的移动 只有这个强度速度 速度是随机的。
- 知识点：大约在100到200之间 这样出去 并增加更强的向上弹性的感觉 随机范围相当大约在200到100之间 因为这里会有重力作用 然后精灵大小。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` Sprite Renderer 设置
> - 组成部分: Preview + Niagara Stack + Sprite Renderer Details + Timeline
> - 所属: `Exp_01 / Debris_01 / Sprite Renderer`
> - 目的: 为碎片发射器绑定材质实例并设置 SubUV 图块与渲染排序。
>
> Sprite Renderer Details:
> | 字段 | 值 |
> |---|---|
> | Material | `M_AdditiveDe_v01_Ins_07` |
> | Material User Param Binding | `None` |
> | Source Mode | `Particles` |
> | Alignment | `Unaligned` |
> | Facing Mode | `Automatic` |
> | Macro UV Radius | `0.0` |
> | Default Pivot in UV Space | `0.5, 0.5` |
> | Sort Mode | `None` |
> | Sub Image Size | `2.0, 2.0` |
> | Sort Order Hint | `10` |
> | Motion Vector Setting | `Auto Detect` |
>
> Preview: 中心发光和烟雾前方可见碎片/颗粒点，字幕说明 pivot/轴值会移动到中心。
>
> 联动关系: `Sub Image Size=2.0,2.0` 与 `Sub UV Animation` 的 0-3 随机帧匹配；`Sort Order Hint=10` 提高碎片渲染排序，使碎片更容易显示在烟雾/发光层上。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` Shape Location 随机半径
> - 组成部分: Niagara Stack + Shape Location Details + Timeline
> - 所属: `Exp_01 / Debris_01 / Shape Location`
> - 目的: 用随机 Ring/Disc 半径把碎片分布到爆炸中心周围。
>
> Shape Location Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Shape | Shape Primitive | `Ring / Disc` |
> | Shape | Ring / Disc Mode | `Circle` |
> | Shape | Ring Radius | `Random Range Float` |
> | Shape | Minimum | `50.0` |
> | Shape | Maximum | `100.0` |
> | Distribution | Ring / Disc Distribution | `Random` |
> | Distribution | Disc Coverage | `0.0` |
> | Distribution | U Distribution | `0.0` |
> | Transform | Transform Order | `Scale / Rotate / Offset` |
> | Transform | Scale Mode | `Default` |
> | Transform | Non Uniform Scale | `1.0, 1.0, 1.0` |
> | Transform | Rotation Mode | `Default` |
> | Transform | Rotation Coordinates | `Local` |
> | Transform | Offset Mode | `None` |
> | Transform | Shape Origin | `STACKCONTEXT Position` |
>
> 联动关系: `Ring Radius` 的 `50.0..100.0` 随机范围让碎片初始分布比单一半径更分散；坐标/方向只按 Niagara 字段记录，不额外断言外部坐标基准。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` 生成数量与重力模块入口
> - 组成部分: Preview + Niagara Stack + Emitter Details + Spawn Burst Details + Add Module 菜单
> - 所属: `Exp_01 / Debris_01`
> - 目的: 设置碎片一次性生成数量，并准备添加 `Gravity Force` 让碎片具有下落重量感。
>
> Emitter State Details:
> | 字段 | 值 |
> |---|---|
> | Life Cycle Mode | `Self` |
> | Inactive Response | `Complete (Let Particles Finish then...)` |
> | Loop Behavior | `Once` |
> | Loop Duration Mode | `Fixed` |
> | Loop Duration | `1.0` |
> | Scalability Mode | `System` |
>
> Spawn Burst Instantaneous:
> | 字段 | 值 |
> |---|---|
> | Spawn Count | `15` |
> | Spawn Time | `0.0` |
>
> Add Module 菜单:
> | 分类 | 项 |
> |---|---|
> | Source Filtering | Niagara / Game / Plugins / Developer，`Library Only` 勾选 |
> | 搜索词 | `gra` |
> | Forces | `Gravity Force` |
>
> Preview: 碎片粒子在烟雾和中心光柱上方可见，呈灰白颗粒状飞散。
>
> 联动关系: `Spawn Count=15` 控制碎片数量；准备添加 `Gravity Force` 是为了让碎片后续受到重力式下落影响。

### 00:11:37-00:16:20 Alpha、材质、粒子

- 本段定位：Alpha、材质、粒子。
- 知识点：就这样掉落 现在缩放颜色有些灰色 这一部分适当黑色 感觉改变一下 亮度适当快一点 而且透明度适当快点 不消失也可以 这是土的材质。
- 知识点：到最后几乎保持完整的透明度 掉到地上后 反正不会在我们眼里可见 这种裂缝部分的颜色 和其他颜色适当搭配一下会更自然吧。
- 知识点：在贴花上使用的影像字 适当快一点就消失了 所以这个图表适当极端一点 序列现在消失了 感觉之前解除了 适当慢一点 消失了 现在适当可见 土的部分也做了。
- 知识点：适当慢一点掉下来 觉得不错 土太快 从眼里消失比适当快 这样觉得 那么适当现在 石头一样的碎片 块状的颗粒感觉的碎片 也就添加看看 这里也将从马特利尔开始更换。
- 知识点：复制后纹理 需要使用这个锁纹理 这个朋友也需要用 Alpha 有Alpha通道分开 这部分只要统一 其他部分将保持原来的直 需要连接到粒子。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Alpha`、`材质`、`纹理`、`粒子`、`序列`、`颜色`、`透明度`、`碰撞`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` Scale Color 曲线调整
> - 组成部分: Preview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01 / Scale Color`
> - 目的: 让泥土/碎片颜色随生命周期变暗并随机化透明度强度。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `1.0, 1.0, 1.0` |
> | RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Scale Curve | `1.0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `Random Range Float` |
> | Alpha Minimum | `0.75` |
> | Alpha Maximum | `1.25` |
> | Alpha Evaluation Type | `Spawn Only` |
>
> 曲线:
> - RGB 曲线从约 `2` 随生命周期下降到接近 `0`。
> - Alpha 曲线随生命周期衰减，整体强度在出生时按 `0.75..1.25` 随机缩放。
>
> Preview: 左侧可见深灰褐色烟尘/碎片团，碎片与烟雾混合在中心爆发区域。
>
> 联动关系: RGB 曲线负责让碎片逐渐暗下去，Alpha 随机范围让不同粒子的消隐强度不完全一致。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01` Scale Color 高亮泥土色调整
> - 组成部分: Preview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01 / Scale Color`；截图右侧 Details 标题显示为 `Decal`，但 System Overview 与 Timeline 当前高亮为 `Debris_01.Scale Color`，因此按可见选择状态记录。
> - 目的: 将碎片颜色改为偏暖的泥土高亮，并让 Alpha 随生命周期消隐。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `10.0, 4.0, 3.0` |
> | RGB Float | `Float from Curve` |
> | RGB Key Data Time | `0.1` |
> | RGB Key Data Value | `1.0` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `1.0` |
>
> 曲线:
> - RGB 曲线前段保持亮度后开始下降。
> - Alpha 曲线从接近 `0.9` 下降到生命周期末端 `0`。
>
> 联动关系: `10.0,4.0,3.0` 的 RGB 向量把碎片推向暖色高亮，Alpha 曲线负责让该高亮随生命周期淡出。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01001` Add Velocity 线性随机速度
> - 组成部分: Preview + Niagara Stack + Add Velocity Details + Timeline
> - 所属: `Exp_01 / Debris_01001 / Add Velocity 001`
> - 目的: 复制出第二层碎片，并给它较慢、带随机分量的线性初速度。
>
> 发射器状态:
> | 项 | 值 |
> |---|---|
> | 发射器 | `Debris_01001` |
> | 粒子数显示 | `20` |
> | Stack 中可见模块 | `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Shape Location`、`Add Velocity 001`、`Particle State`、`Scale Sprite Size`、`Sub UVAnimation`、`Scale Velocity`、`Gravity Force`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` |
>
> Add Velocity 001 Details:
> | 字段 | 值 |
> |---|---|
> | Velocity Mode | `Linear` |
> | Velocity | `Random Range Vector` |
> | Minimum | `0.0, 0.0, 200.0` |
> | Maximum | `1.0, 1.0, 100.0` |
> | Velocity Speed Scale | `1.0` |
> | Rotation Mode | `Default` |
> | Rotation Coordinate | `Local` |
>
> Preview: 左侧烟雾团中叠加较暗的小碎片点，形成泥土/颗粒混合的爆发效果。
>
> 联动关系: 该图只按 Niagara 字段记录向量数值；`Minimum/Maximum` 的三个分量不在此处解释为外部世界轴。`Gravity Force` 已在栈中出现，后续会与速度模块共同形成下落重量感。

### 00:16:20-00:21:04 材质、网格、碰撞

- 本段定位：材质、网格、碰撞。
- 知识点：因为是四针的 这个应该不用改 已经随机地面具形状都不同 需要加入碰撞模块 让我们加入碰撞模块 看一下 碰撞效果很好 但是像太亲的球一样弹跳。
- 知识点：需要用力反 摩擦力这个是 需要提高摩擦值 然后降低这个弹跳高度 那么会更有重量感吧 然后这个重力效果适当恢复到原质 有一种 缓慢下落的重量感。
- 知识点：颜色有点泛黄 适当调整了这种感觉 像是灯光灌入 这样变亮的感觉 总体自然地就表达了 先保存资源 现在碎片和灰尘都进去了 所以最后和光一起。
- 知识点：现在光出来有点无聊 太简单了吧 光伸展出来的感觉 所以这个 再加一个元素扭曲 让它有点燃烧的感觉 进入光泽 但这次我们用了之前第一片 我作为主材质使用的。
- 知识点：网格材质 会直接用 等一下我把它放在这里了 主作者 还有网格一 比如说需要做一个实例 将它移动到第二个文件夹 然后加上语 先调整一下材质。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`材质`、`纹理`、`颜色`、`碰撞`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01001` SubUV Animation 随机帧
> - 组成部分: Preview + Niagara Stack + SubUV Animation Details + Timeline
> - 所属: `Exp_01 / Debris_01001 / Sub UV Animation`
> - 目的: 让第二层碎片在 0-3 帧中随机选择图块，使块状颗粒形状不完全一致。
>
> Sub UV Animation Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Setup | SubUV Animation Mode | `Random` |
> | Setup | Start Frame Range | 未启用，值 `0` |
> | Setup | End Frame Range | Enabled，值 `3` |
> | Setup | Renderer Type | `Sprite` |
> | Sprite Renderer Info | Sprite Renderer | `Sprite Renderer` |
> | Animation | Evaluation Type | `Spawn Only` |
> | Output | Output Alternate Result | 未启用 |
>
> Preview: 中心烟雾和碎片混合，颗粒点在灰褐烟尘中出现。
>
> 联动关系: `End Frame Range=3` 对应 0-3 的随机帧范围；`Spawn Only` 表示粒子出生时确定采样帧，用于制造静态形状差异，而不是逐帧播放。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01001` Scale Color 冷灰碎片调整
> - 组成部分: Preview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01001 / Scale Color`
> - 目的: 将第二层碎片颜色调整为偏冷的灰尘色，并用曲线控制透明度消隐。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `0.8, 0.9, 1.0` |
> | RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Scale Curve | `1.0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `Random Range Float` |
> | Alpha Minimum | `1.0` |
> | Alpha Maximum | `1.25` |
> | Alpha Evaluation Type | `Spawn Only` |
>
> 曲线:
> - RGB 曲线从较高值下降到生命周期末端 `0`。
> - Alpha 曲线同样随生命周期下降，并在出生时使用 `1.0..1.25` 的随机缩放。
>
> Preview: 左侧预览仍以深灰烟尘和碎片为主，碎片亮度低于暖色高亮版本。
>
> 联动关系: `0.8,0.9,1.0` 的 RGB 向量让该层碎片偏冷，随机 Alpha 范围避免所有粒子以同一透明度节奏消失。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_01` 火焰/扭曲材质实例初调
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Mesh_v01_Ins_01`，Parent 为 `M_Mesh_v01`
> - 目的: 创建用于光泽/燃烧元素的网格材质实例，先以绿底红顶检查颜色与纹理通道。
>
> Texture Parameter Values:
> | 参数 | 值 |
> |---|---|
> | Color_Tex | `T_CloudScape_08_Details` |
> | Diff_Tex | `T_Beam_Gradient` |
> | Normal_Tex | `T_CloudScape_08_Details_N` |
> | Opacity_Tex | `T_Beam_Gradient_02` |
>
> Vector Parameter Values:
> | 参数 | R | G | B | A |
> |---|---:|---:|---:|---:|
> | BottomColor | `0.0` | `1.0` | `0.0` | `1.0` |
> | TopColor | `1.0` | `0.0` | `0.0` | `1.0` |
>
> 其他可见项:
> - `Use_Refraction` 静态开关在列表中可见并处于勾选状态。
> - 预览窗口显示矩形火焰/遮罩纹理：底部偏绿，顶部红白高亮，黑色区域形成透明/遮罩感。
>
> 联动关系: `Color_Tex` 与 `Opacity_Tex` 提供火焰/噪声和纵向遮罩基础，`BottomColor` / `TopColor` 用于验证渐变配色，再进入下一帧的正式颜色调整。

### 00:21:04-00:25:57 精灵、生命周期、速度

- 本段定位：精灵、生命周期、速度。
- 知识点：像燃气火焰一样 面具纹理将使用这个纹理 发现纹理是 Brown 是了,将为咋些 Brown是噪声种类的名称 还有不透明度 纹理是这个延伸。
- 知识点：出来的朋友,所以需要 使用之前的发光 这个纹理 还有混合模式,将使用半透明 我来看一下参数数值。
- 知识点：颜色似乎 现在不是很重要 颜色纹理是 偏差底部适当让区域宽一点 慢反射宽度 当然,要是 长度适当长一点,不要太皱 这样保持 发现扭曲拼贴 将适当用简单的感觉来摇晃。
- 知识点：大约0.4,0.25 纹理现在似乎太亮了 你就用感觉看 那么生成一个105 要生成一个 生命周期会适当留下余韵。
- 知识点：再消失 大约0.75这个位置上 升值没有特别的 然后大小调整到 大约300和200 而且首先 似乎是速度对齐。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`纹理`、`生命周期`、`速度`、`颜色`、`透明度`、`噪声`、`动态参数`、`火焰`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_01` 火焰/燃气遮罩正式配色
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Mesh_v01_Ins_01`，Parent 为 `M_Mesh_v01`
> - 目的: 将测试色改为底部蓝紫、顶部高强度暖色，用于燃气火焰/发光扭曲效果。
>
> Texture Parameter Values:
> | 参数 | 值 |
> |---|---|
> | Color_Tex | `T_CloudScape_08_Details` |
> | Diff_Tex | `T_Beam_Gradient` |
> | Normal_Tex | `T_CloudScape_08_Details_N` |
> | Opacity_Tex | `T_Beam_Gradient_02` |
>
> Vector Parameter Values:
> | 参数 | R | G | B | A |
> |---|---:|---:|---:|---:|
> | BottomColor | `0.0` | `0.0` | `0.3` | `1.0` |
> | TopColor | `5.0` | `3.0` | `1.0` | `1.0` |
>
> Preview: 预览窗口中的遮罩纹理底部偏蓝紫，上部为白黄高亮火焰形态，黑色背景保留遮罩边界。
>
> 联动关系: 上下文提到燃气火焰和 Brown/noise 类纹理；这里使用 `T_CloudScape_08_Details` 及其 Normal 提供噪声细节，用 `T_Beam_Gradient_02` 控制不透明度延伸。
> 图表转写（UE-GTXT v4）
> - 类型: `Glow_05` Initialize Particle 基础属性
> - 组成部分: Preview + Niagara Stack + Initialize Particle Details + Timeline
> - 所属: `Exp_01 / Glow_05 / Initialize Particle`
> - 目的: 新增第五层 Glow/火焰元素，设置位置偏移和非均匀 Sprite 尺寸，为后续速度对齐的火焰条带做基础。
>
> Initialize Particle Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Direct Set` |
> | Point Attributes | Lifetime | `0.0`，截图字段可读值接近 `0.` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Point Attributes | Position Offset | `0.0, 0.0, -20.0` |
> | Point Attributes | Position Offset Coordinate Space | `Simulation` |
> | Point Attributes | Mass Mode | `Unset` |
> | Sprite Attributes | Sprite Size Mode | `Non-Uniform` |
> | Sprite Attributes | Sprite Size | `100.0, 350.0` |
> | Sprite Attributes | Sprite Rotation Mode | `Unset` |
> | Sprite Attributes | Sprite UV Mode | `Unset` |
>
> Preview: 左侧仍可见已有烟雾/碎片爆发效果；当前 Details 面板中 `Glow_05.Initialize Particle` 被选中。
>
> 联动关系: `Position Offset` 和 `Sprite Size` 建立火焰条带的初始位置与长条比例，后续 Renderer 的 `Velocity Aligned` 会让该条带按速度方向对齐。
> 图表转写（UE-GTXT v4）
> - 类型: `Glow_05` Sprite Renderer 与尺寸/颜色曲线语境
> - 组成部分: Preview + Niagara Stack + Sprite Renderer Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Glow_05 / Sprite Renderer`
> - 目的: 将第五层火焰/光元素绑定到 `M_Mesh_v01_Ins_01`，并启用速度对齐和较高渲染排序。
>
> Glow_05 Stack:
> | 阶段 | 可见模块 |
> |---|---|
> | Emitter Spawn | `Emitter State`、`Spawn Burst Instantaneous` |
> | Particle Spawn | `Initialize Particle`、`Add Velocity Linear` |
> | Particle Update | `Particle State`、`Scale Sprite Size`、`Scale Color`、`Solve Forces and Velocity` |
> | Render | `Sprite Renderer` |
>
> Sprite Renderer Details:
> | 字段 | 值 |
> |---|---|
> | Material | `M_Mesh_v01_Ins_01` |
> | Material User Param Binding | `None` |
> | Source Mode | `Particles` |
> | Alignment | `Velocity Aligned` |
> | Facing Mode | `Automatic` |
> | Macro UV Radius | `0.0` |
> | Default Pivot in UV Space | `0.5, 0.9` |
> | Pixel Coverage Mode | `Automatic` |
> | Pixel Coverage Blend | `1.0` |
> | Sort Mode | `None` |
> | Sort Order Hint | `30` |
> | Motion Vector Setting | `Auto Detect` |
>
> Curve Editor:
> - 可见红色曲线从 `0` 快速升到约 `1`，随后随生命周期下降到 `0`。
>
> Preview: 左侧爆发中可见烟雾/碎片层，中心附近有较弱的纵向火焰/光痕。
>
> 联动关系: `Velocity Aligned` 让 Sprite 条带按 Niagara 速度语义对齐；`Sort Order Hint=30` 让该 Glow 层在已有烟雾和碎片层中获得更靠后的排序权重。

### 00:25:57-00:30:21 材质、透明度、纹理

- 本段定位：材质、透明度、纹理。
- 知识点：有参数的试针指和 这里的平移,微空到平移 后续会用曲线来把握感觉 先看看平移部分 从大约-0.2开始 最终希望尽早达到0指 并留有余韵 瞬间弹起来移动。
- 知识点：慢慢给随机X 是的,翻转时的表现 是非常重要的 是的,翻转时的表现 然后添加外国元素 在开始当然没有外国 大约0.2,真正不强 给你 和柱子一起上升,消失的感觉。
- 知识点：可以认为是那根柱子 在负责余韵 像什么火的感觉 这样感觉会适当消失 如果有移动同时 消失的元素 就不那么无聊,色彩感也会更好 所以我尝试添加了这种纹理。
- 知识点：适当让透明度快一点 看起来有些不对劲 那么需要复制这个碎片 试着制作一个火花 火花的话我计划分为两种张力制作 然后材质将使用。
- 知识点：势力一中使用的材质 紫幽微快改成1x1 然后需要使用平衡城市再现 接下来使用不使用的材质 需要关掉音频 然后需要使用平衡城市再现 接下来使用不使用的材质 需要关掉音频。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_01` 平铺、透明度和纹理参数
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Mesh_v01_Ins_01`
> - 目的: 调整火焰/扭曲元素的纹理平铺、透明度强度、边缘和法线纹理，形成带余韵的撕裂状火焰纹理。
>
> Scalar Parameter Values:
> | 参数 | 值 |
> |---|---:|
> | Color_Tile_U | `0.5` |
> | Color_Tile_V | `0.5` |
> | ColorBias | `0.5` |
> | Desaturation | `0.0` |
> | Diff_Tile_U | `1.0` |
> | Diff_Tile_V | `0.5` |
> | Edge_Pow | `1.0` |
> | Fade_Dist | `100.0` |
> | Normal_Tile_U | `0.4` |
> | Normal_Tile_V | `0.25` |
> | Opacity_Pow | `1.0` |
> | Opacity_Str | `5.0` |
> | RGB_Offset | `0.0` |
> | Tension | `1.0` |
>
> Static Switch:
> | 参数 | 可见状态 |
> |---|---|
> | Use_Refraction | 列表中可见，处于勾选状态 |
>
> Texture Parameter Values:
> | 参数 | 值 |
> |---|---|
> | Color_Tex | `T_CloudScape_08_Details` |
> | Diff_Tex | `VTrail_02` |
> | Normal_Tex | `T_Voronoi_Cells_02_NRM` |
> | Opacity_Tex | `T_Spline_Gradient` |
>
> Preview: 左侧材质预览为暗背景上的白粉色撕裂状火焰/电弧纹理，局部亮度随透明遮罩形成断续条带。
>
> 联动关系: `Opacity_Tex=T_Spline_Gradient` 与 `Opacity_Str=5.0` 控制条带透明度强度，`Diff_Tex=VTrail_02` 和 `Normal_Tex=T_Voronoi_Cells_02_NRM` 为火焰/扭曲元素提供纹理形态和法线细节。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览与纹理资源选择
> - 组成部分: Level Viewport + Content Browser + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览；Content Browser 当前位于 `Content/Coloso_Second/Texture`
> - 目的: 检查土爆炸效果在关卡中的合成状态，并选择/确认用于透明度或渐变的纹理资源。
>
> Content Browser:
> | 可见资源 | 类型/状态 |
> |---|---|
> | `T_Spline_Gradient` | Texture，当前高亮选中 |
> | `T_Soft_...` 两个缩略图 | 软渐变/轨迹类纹理，位于当前选中项上方 |
> | `T_RockPull`、`T_Shadow`、`T_Slate_N` 等 | 岩石/阴影/法线类纹理资源可见 |
>
> Outliner:
> | 对象 | 类型/状态 |
> |---|---|
> | `01_Swing_Trail` | Level Sequence |
> | `Cine Camera Actor` | Camera Actor |
> | `Exp 01`、`Exp 02`、`Exp 03` | Niagara Actor，均绑定 `02_Earth_Explosion` |
> | `Floor` | StaticMesh |
> | `Greystone` | SkeletalMesh |
>
> Level Viewport:
> - 棋盘地面上可见角色、三段爆炸残留区、黑灰烟尘、裂缝状地面痕迹和散落碎片。
> - 三个爆炸点从左到右分布，右侧区域有较亮的裂缝/发光痕迹，中心区域有较重的黑灰烟尘。
> - 视口顶部处于 `Pilot Actor: Cine Camera Actor` 状态，表示从 Cine Camera Actor 视角检查效果。
>
> 联动关系: `T_Spline_Gradient` 的选中状态对应前后材质实例里的 `Opacity_Tex`；关卡预览用于检查烟尘、碎片、裂缝和火焰/透明度元素叠加后的整体可见性。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Sprite Renderer 火花/碎片材质设置
> - 组成部分: Preview + System Overview + Niagara Stack + Sprite Renderer Details + Timeline
> - 所属: `Exp_01 / Debris_01002 / Sprite Renderer`
> - 目的: 复制出新的火花/碎片发射器，并使用 2x2 SubUV 的 Additive 材质输出火花张力层。
>
> Preview:
> - 左侧 Niagara 预览中可见竖直的白橙色光柱/火焰束，底部叠加灰白烟尘和地面爆发云。
> - 预览显示当前系统已经把光柱、烟尘和地面碎片叠加在同一爆发区域。
>
> Debris_01002 Stack 可见模块:
> | 阶段 | 模块/项 |
> |---|---|
> | Emitter | `Emitter State`、`Spawn Burst Instantaneous` |
> | Particle Spawn | `Initialize Particle`、`Shape Location (Ring / Disc)`、`Add Velocity (From Point)`、`Add Velocity 001 (Linear)` |
> | Particle Update | `Particle State`、`Scale Sprite Size`、`Sub UVAnimation (Random)`、`Scale Velocity`、`Gravity Force`、`Collision`、`Solve Forces and Velocity`、`Scale Color` |
> | Render | `Sprite Renderer` |
>
> Sprite Renderer Details:
> | 字段 | 值 |
> |---|---|
> | Material | `M_AdditiveDe_v01_Ins_01` |
> | Material User Param Binding | `None` |
> | Source Mode | `Particles` |
> | Alignment | `Unaligned` |
> | Facing Mode | `Automatic` |
> | Macro UV Radius | `0.0` |
> | Default Pivot in UV Space | `0.5, 0.5` |
> | Pixel Coverage Mode | `Automatic` |
> | Pixel Coverage Blend | `1.0` |
> | Sort Mode | `None` |
> | Sub Image Size | `2.0, 2.0` |
> | Sort Order Hint | `10` |
> | Motion Vector Setting | `Auto Detect` |
>
> Timeline:
> - `Debris_01002` 轨道被选中，当前播放头在约 `0.12` 秒附近。
>
> 联动关系: `Sub Image Size=2.0,2.0` 与 Stack 中 `Sub UVAnimation (Random)` 对应，用于 2x2 图块随机火花形状；`Material=M_AdditiveDe_v01_Ins_01` 提供 Additive 火花材质，`Sort Order Hint=10` 控制该层在系统中的渲染排序权重。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


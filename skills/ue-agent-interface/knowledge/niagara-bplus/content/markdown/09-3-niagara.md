# 09-3 制作Niagara粒子特效

# 09-3 制作Niagara粒子特效

## 关键术语

- `Lifetime`、`Velocity`、`Color`、`Alpha`、`GPU`、`Multiply`、`Sequencer`、`Mesh`、`材质`、`粒子`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Normalized Age`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:00-00:02:54 Velocity、GPU、材质

- 本段定位：Velocity、GPU、材质。
- 知识点：分成2米 计划制作 材质将使用设立一中的材质 并且自为改为1x1 然后将使用Velocity L 接下来后续会关闭不使用的魔鬼 并且需要改为GPU并设置为Fig。
- 知识点：大约会洒入100个 生命周期大约在0.8到1.5之间 位置值设为30左右 大小设置为Fig均匀1x20 在20和20之间随机生成 Chain。
- 知识点：Location固定为100的球形比较合适 但是现在将有0.5的半球 底部不生成 只有从上面圆形生成 这将随机在模拟默认中更改 不使用随机C。
- 知识点：碎片部分将进行相同的修改 现在虽然很模糊 但正在出现 而且速度可以直接使用这个起始点 然后尺寸 保存一次 保存应该一直生活化 规模精灵大小。
- 知识点：极限5个还不稳定 将使用非均匀组合 只会使用Y轴 X轴不改变值 从大开始 然后快速消失。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Velocity`、`GPU`、`材质`、`生命周期`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Sprite Renderer 材质绑定
> - 组成部分: Content Browser + Preview + Niagara Stack + Sprite Renderer Details + Timeline
> - 所属: `Exp_01 / Debris_01002 / Sprite Renderer`
> - 目的: 将火花/碎片材质切换为示例 1 的 Additive 材质实例，并确认 Renderer 仍按 2x2 SubUV 输出。
>
> Content Browser:
> | 项 | 值 |
> |---|---|
> | 当前目录 | `Content/Coloso_Second/Material/01` |
> | 悬停资源 | `M_AdditiveDe_v01_Ins_01 (Material Instance)` |
> | Tooltip Path | `/Game/Tutorial/Material/01` |
> | Parent | `/Game/Coloso_Second/Material/M_AdditiveDe_v01...` |
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
> | Sort Mode | `None` |
> | Sub Image Size | `2.0, 2.0` |
> | Sort Order Hint | `10` |
> | Motion Vector Setting | `Auto Detect` |
>
> Preview: 左侧预览中可见烟尘云和少量碎片点，`Debris_01002` 轨道在 Timeline 中被选中。
>
> 联动关系: `M_AdditiveDe_v01_Ins_01` 提供火花/碎片的 Additive 材质，`Sub Image Size=2.0,2.0` 对应后续随机 SubUV 取样。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Shape Location 球形生成范围
> - 组成部分: Niagara Stack + Shape Location Details + Timeline
> - 所属: `Exp_01 / Debris_01002 / Shape Location`
> - 目的: 将火花/碎片的初始生成位置改为球形随机分布，并限制半球分布参数。
>
> 发射器状态:
> | 字段 | 值 |
> |---|---|
> | Sim 标记 | `GPU` 徽标可见 |
> | 当前选择 | `Debris_01002 / Shape Location` |
> | Timeline 时间 | 约 `1.94` 秒 |
>
> Shape Location Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Shape | Shape Primitive | `Sphere` |
> | Shape | Sphere Radius | `100.0` |
> | Distribution | Sphere Distribution | `Random` |
> | Distribution | Sphere Surface Distribution | `0.0` |
> | Distribution | Hemisphere Distribution | `1.0, 1.0` |
> | Transform | Transform Order | `Scale / Rotate / Offset` |
> | Transform | Scale Mode | `Default` |
> | Transform | Non Uniform Scale | `1.0, 1.0, 1.0` |
> | Transform | Rotation Mode | `Default` |
> | Transform | Rotation Coordinate | `Local` |
> | Transform | Offset Mode | `None` |
> | Transform | Shape Origin | `STACKCONTEXT Position` |
>
> 联动关系: `Sphere Radius=100.0` 对应上下文中“固定为 100 的球形”；Hemisphere 字段只按面板值记录，不额外推断外部方向。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` 非均匀尺寸曲线
> - 组成部分: Preview + Niagara Stack + Scale Sprite Size Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Scale Sprite Size 001`
> - 目的: 用二维向量曲线控制火花/碎片 Sprite 的非均匀尺寸变化。
>
> Scale Sprite Size 001 Details:
> | 字段 | 值 |
> |---|---|
> | Scale Sprite Size Mode | `Non-Uniform Curve` |
> | Curve Type | `Curve for Vector2D's` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0, 1.0` |
>
> 曲线:
> - 红色 `X` 曲线从较低值逐步上升到约 `1.0`。
> - 绿色 `Y` 曲线从 `0.45` 附近上升到约 `1.0`；悬停提示显示 `Name: Y`、`Time: 0`、`Value: 0.45`。
>
> Preview: 左侧预览中可见淡灰烟尘和少量暗色碎片点，Details 标题显示 `Debris_01002` 当前约 `61 Particles`。
>
> 联动关系: 非均匀曲线通过 `Particles.NormalizedAge` 控制尺寸随生命周期变化，用于让火花/碎片尺寸在出生后产生张力。

### 00:03:02-00:05:44 颜色、透明度

- 本段定位：颜色、透明度。
- 知识点：给人一种瞬间出现和消失的感觉 然后颜色 一开始就是很明亮的感觉 从1直到0.2 这个图形张力从0.2开始 颜色快速消失的感觉 但是亮度是会有点弱 然后我的透明度 也从0.2开始 可以直线减小 希望这个颜色能更亮一些 谢谢。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` 尺寸快速衰减曲线
> - 组成部分: Preview + Niagara Stack + Scale Sprite Size Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Scale Sprite Size 001`
> - 目的: 让火花/碎片在生命周期前段快速缩小，形成瞬间出现后快速消失的张力。
>
> Scale Sprite Size 001 Details:
> | 字段 | 值 |
> |---|---|
> | Scale Sprite Size Mode | `Non-Uniform Curve` |
> | Curve Type | `Curve for Vector2D's` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0, 1.0` |
>
> 曲线:
> - 红色 `X` 曲线保持在约 `1.0`。
> - 绿色 `Y` 曲线从约 `3.0` 快速下降到生命周期末端接近 `0`。
> - Key Data 显示当前点 Time `0.0`、Value `3.0`。
>
> Preview: 左侧烟尘云更明显，Details 标题显示 `Debris_01002` 当前约 `100 Particles`。
>
> 联动关系: 该曲线保留横向尺度稳定，同时让另一个尺寸分量快速收缩，配合上下文中的“瞬间出现和消失”。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Scale Color 亮色火花曲线
> - 组成部分: Preview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Scale Color`
> - 目的: 提高火花颜色亮度，并让 RGB 与 Alpha 分别按生命周期衰减。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `10.0, 7.0, 1.0` |
> | RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Key Data | Time `1.0`，Value `0.2` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `Random Range Float` |
> | Alpha Minimum | `1.0` |
> | Alpha Maximum | `1.25` |
>
> 曲线:
> - RGB 曲线整体保持较亮，末端降到约 `0.2`。
> - Alpha 曲线从高值向 `0` 衰减，并使用 `1.0..1.25` 的随机强度。
>
> Preview: 左侧当前预览粒子较少或接近不可见，Details 标题显示 `0 Particles`。
>
> 联动关系: `10.0,7.0,1.0` 让火花偏暖且高亮；RGB 曲线控制亮度衰减，Alpha 随机范围避免所有火花同一透明度节奏消失。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的 `Exp 03` 火花/爆炸效果
> - 组成部分: Level Viewport + Outliner + Actor Details + Content Browser
> - 所属: `02_Earth_Explosion / Exp 03`
> - 目的: 在关卡中检查第三个爆炸点的烟尘、碎片、裂缝和火花叠加效果。
>
> Actor Details:
> | 字段 | 值 |
> |---|---|
> | Selected Actor | `Exp 03` |
> | Component | `NiagaraComponent (NiagaraComponent0)` |
> | Location | `-30.0, 780.0, 0.0` |
> | Rotation | `0.0, 0.0, 0.0` |
> | Scale | `1.0, 1.0, 1.0` |
> | Niagara System Asset | `Exp_01` |
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor` 状态。
> - 黄色轮廓框显示当前选中 `Exp 03` 的 Actor 范围。
> - 爆炸区域中可见黑灰烟尘、白色裂缝发光、飞散碎片和多点白黄色火花。
>
> Content Browser:
> - 当前目录显示材质实例，`M_AdditiveDe_v01_Ins_01` 缩略图在左上区域可见。
>
> 联动关系: 该图把前两张中的尺寸/颜色曲线放回关卡视角验证；Transform 字段只按 Details 面板记录，不额外解释为语义方向。

### 00:06:10-00:09:05 Multiply、材质、速度

- 本段定位：Multiply、材质、速度。
- 知识点：需要尝试使用这个材质 在这次示例中我给出的材质中有 称为Adative No Bloomer的材质。
- 知识点：这个我现在放进去 在斯帕克的情况下 需要较强的泛光效果 但是在虚幻引经五中 运动模糊本身就略有影响 因此这个泛光值可能会减弱 不过对于斯帕克来说。
- 知识点：没有运动模糊的情况下 泛光效果更好 这个材质设置为 不受运动模糊影响的材质 因此需要使用这个感觉 那么这种速度的张力有点无趣。
- 知识点：需要通过缩放速度 添加张力 先用Multiply Vector by Flow 在曲线中最开始会有些增强 中间部分逐渐减小 最后大约在0.5的时候。
- 知识点：这种张力 然后现在这种随机的感觉 力量加入的话似乎就结束了 频率大约是20 强。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Multiply`、`材质`、`速度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 火花材质资源与关卡效果复查
> - 组成部分: Content Browser + Level Viewport + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览；Content Browser 当前位于 `Material` 目录。
> - 目的: 对比示例材质资源并检查三段地面爆炸的整体火花/烟尘表现。
>
> Content Browser:
> | 可见资源/目录 | 状态 |
> |---|---|
> | `Ex_01_SwordTrail`、`Ex_02_Earth_Explosion`、`Ex_03_Ice_Explosion` 等 | 材质示例目录 |
> | `M_AdditiveDe_v01` | 材质资源可见 |
> | `M_AdditiveDe_v01_01` | 材质资源，高亮选中 |
> | `M_Decal_01` | 材质资源可见 |
>
> Level Viewport:
> - 三个爆炸残留点横向排列在棋盘地面上，含黑灰烟尘、地裂纹理和散落碎片。
> - 中间和右侧爆炸点的白色裂缝发光更明显，周围有灰尘云和碎石。
>
> 联动关系: Content Browser 中的 Additive 材质资源用于火花材质选择；关卡预览用于核对火花材质替换后与烟尘/地裂层的合成效果。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Scale Velocity 动态输入入口
> - 组成部分: Preview + Niagara Stack + Scale Velocity Details + Add Dynamic Input 菜单 + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Scale Velocity 001`
> - 目的: 在速度缩放中准备使用 `Multiply Vector by Float`，为火花速度增加随生命周期变化的张力。
>
> Scale Velocity 001 Details:
> | 字段 | 值 |
> |---|---|
> | Coordinate Space | `Local` |
> | Velocity Scale | `1.0, 1.0, 1.0`，当前准备替换为动态输入 |
>
> Add Dynamic Input 菜单:
> | 分类/项 | 值 |
> |---|---|
> | Source Filtering | `Niagara`、`Game`、`Plugins`、`Developer` 可见，`Library Only` 勾选 |
> | Suggested | `Convert Position to Vector`、`Lerp Vector`、`Multiply Vector`、`Multiply Vector by Float` |
> | 当前高亮 | `Multiply Vector by Float` |
> | Tooltip Path | `/Niagara/DynamicInputs/Multiply/Multiply_VectorByFloat.MultiplyVectorByFloat` |
>
> Preview: 左侧可见烟尘云、亮点火花和飞散碎片；Timeline 中 `Debris_01002` 轨道被选中，播放头约 `4.47` 秒。
>
> 联动关系: 该步骤将固定 `Velocity Scale` 改为向量乘浮点的动态输入，后续可用曲线控制火花速度强弱。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Curl Noise Force
> - 组成部分: Preview + Niagara Stack + Curl Noise Force Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Curl Noise Force`
> - 目的: 给火花/碎片加入噪声力，让运动不只是线性扩散。
>
> Curl Noise Force Details:
> | 字段 | 值 |
> |---|---|
> | Noise Strength | `10.0` |
> | Noise Frequency | `50.0` |
> | Noise Quality | `Coherent / Baked (Medium)` |
> | Pan Noise Field | `0.0, 0.0, 0.0`，字段灰置 |
> | Mask Curl Noise | 未勾选 |
>
> Stack 状态:
> - `Debris_01002` 当前约 `100 Particles`。
> - `Particle Update` 中可见 `Scale Velocity 001`、`Curl Noise Force`、`Solve Forces and Velocity`、`Scale Color`，其中 `Curl Noise Force` 被选中。
>
> Preview: 左侧烟尘云中可见白黄色火花和飞散石块，火花不再只是均匀直线分布。
>
> 联动关系: `Curl Noise Force` 在 `Scale Velocity 001` 之后进入粒子更新链，为已有速度缩放叠加噪声扰动；`Solve Forces and Velocity` 负责后续求解。

### 00:09:08-00:12:01 生命周期、速度

- 本段定位：生命周期、速度。
- 知识点：这个比例现在很多倍放大了 所以不喜欢太扩展的人 可以尝试拖拉一下 这样吸引力会增强 比较克制的感觉 那么这个张力与之相似 但上面花瓣更大。
- 知识点：这样向上 还需要再加一个Sparkle 数量就用的多一些 数量就用的多一些 这个就适当修短生命周期。
- 知识点：价格和大小保持不变 然后Shame Location 会适当调整到中心 然后 添加速度也 放射状低伸展 不是 像 的力量更强大 线性在这里 开从10到250。
- 知识点：左右 那么这会平均 从10到250左右分布 这样感觉进行 看看好像在这个程度停下来了 希望能有更多的东西 像是向上喷涌而出 所以给这条滑标的速度更强一些。
- 知识点：一开始 然后比起向外伸展 向上更跟随上升 由于这个原因。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Curl Noise Force 强化
> - 组成部分: Preview + Niagara Stack + Curl Noise Force Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Curl Noise Force`
> - 目的: 将火花/碎片的噪声力改为出生时随机强度，使火花更有喷发张力。
>
> Curl Noise Force Details:
> | 字段 | 值 |
> |---|---|
> | Noise Strength | `Random Range Float` |
> | Minimum | `2000.0` |
> | Maximum | `3000.0` |
> | Evaluation Type | `Spawn Only` |
> | Noise Frequency | `20.0` |
> | Noise Quality / Cost | `Baked (Medium)` |
> | Pan Noise Field | `0.0, 0.0, 0.0`，字段灰置 |
> | Mask Curl Noise | 未勾选 |
>
> Stack 状态:
> - `Debris_01002` 当前约 `100 Particles`。
> - `Curl Noise Force` 位于 `Scale Velocity 001` 之后，`Solve Forces and Velocity` 之前。
>
> Preview: 左侧烟尘和光柱中可见更密集的白黄色火花向外飞散，底部仍有灰尘云。
>
> 联动关系: `Noise Strength=2000..3000` 在粒子出生时随机确定扰动力强度，配合 `Noise Frequency=20.0` 让火花不只沿原始速度均匀扩散。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01003` Shape Location 半球分布
> - 组成部分: Preview + System Overview + Niagara Stack + Shape Location Details + Timeline
> - 所属: `Exp_01 / Debris_01003 / Shape Location`
> - 目的: 复制出另一层火花/碎片，并调整球形位置的半球分布，让生成范围更集中。
>
> System Overview:
> | 发射器 | 状态 |
> |---|---|
> | `Debris_01002` | GPU 标记可见，模块栈在左侧 |
> | `Debris_01003` | GPU 标记可见，当前选中 |
>
> Shape Location Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Shape | Shape Primitive | `Sphere` |
> | Shape | Sphere Radius | `100.0` |
> | Distribution | Sphere Distribution | `Random` |
> | Distribution | Sphere Surface Distribution | `0.0` |
> | Distribution | Hemisphere Distribution | `1.0, 0.5` |
> | Transform | Transform Order | `Scale / Rotate / Offset` |
> | Transform | Scale Mode | `Default` |
> | Transform | Non Uniform Scale | `1.0, 1.0, 1.0` |
> | Transform | Rotation Mode | `Default` |
> | Transform | Rotation Coordinate | `Local` |
> | Transform | Offset Mode | `None` |
> | Transform | Shape Origin | `STACKCONTEXT Position` |
>
> Preview: 左侧预览较暗，仅可见少量碎片点；Details 标题显示 `Debris_01003` 当前 `0 Particles`。
>
> 联动关系: `Sphere Radius=100.0` 继承球形范围，`Hemisphere Distribution=1.0,0.5` 改变半球分布参数；这些字段只按 Niagara 面板记录，不额外解释为外部方向。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的火花/碎片层对比
> - 组成部分: Content Browser + Level Viewport + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览
> - 目的: 从关卡相机视角检查复制火花层后，地面爆炸残留的整体密度与融合度。
>
> Content Browser:
> | 可见项 | 状态 |
> |---|---|
> | `M_AdditiveDe_v01_01` | 材质资源，高亮选中 |
> | `M_AdditiveDe_v01` | 材质资源可见 |
> | `M_Decal_01` | 材质资源可见 |
> | 多个 `Ex_..` 文件夹 | 示例材质/效果目录可见 |
>
> Level Viewport:
> - 三个爆炸残留点排列在棋盘地面上，含地裂发光、深色烧痕、灰尘云和散落碎片。
> - 火花相对前一阶段更少或更弱，整体效果更偏地面残留与烟尘融合。
> - 视口顶部处于 `Pilot Actor: Cine Camera Actor` 状态。
>
> Outliner:
> - 可见 `01_Swing_Trail`、`Cine Camera Actor`、`Exp 01`、`Exp 02`、`Floor`、`Greystone` 等对象。
>
> 联动关系: 该预览用于对照 `Debris_01002` / `Debris_01003` 调整后的火花密度与土爆炸底层效果；材质选择区域确认仍在 Additive 材质资源语境中。

### 00:12:11-00:15:00 发射器、颜色

- 本段定位：发射器、颜色。
- 知识点：的尺寸可以适当缩小 背后的外圈灰光 感觉适当看不太清楚 好像有些不太融合的感觉 现在似乎好多了 然后这里是 这里的饱和度也适当不那么黄。
- 知识点：这个也调整一下 这里保存资源 现在只需要适当添加一下 铁字部分 模糊和视觉元素几乎都已加入 不过即使没有铁字 这个感觉还是不错的。
- 知识点：先添加光 然后试试看 添加发射器创建一个空的 命名为夜晚 改为一次 首先创建一个 然后关闭Sprite Tender 然后放入这个Light。
- 知识点：Tender 接着加发与亮度连动 半径颜色添加 获取设置参数 在这里与光相关的选项 有半径大小指数 指数体积散射都来试试看。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`发射器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01003` Initialize Particle
> - 组成部分: Preview + System Overview + Niagara Stack + Initialize Particle Details + Timeline
> - 所属: `Exp_01 / Debris_01003 / Initialize Particle`
> - 目的: 缩短第二层火花生命周期，并设置小尺寸随机非均匀 Sprite。
>
> Initialize Particle Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Random` |
> | Point Attributes | Lifetime Min | `0.6` |
> | Point Attributes | Lifetime Max | `1.25` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Point Attributes | Position Offset | `0.0, 0.0, 30.0` |
> | Point Attributes | Position Offset Coordinate Space | `Simulation` |
> | Point Attributes | Mass Mode | `Unset / (Mass of 1)` |
> | Sprite Attributes | Sprite Size Mode | `Random Non-Uniform` |
> | Sprite Attributes | Sprite Size Min | `1.0, 5.0` |
> | Sprite Attributes | Sprite Size Max | `1.0, 8.0` |
> | Sprite Attributes | Sprite Rotation Mode | `Random` |
> | Sprite Attributes | Sprite UV Mode | `Random X` |
>
> Preview: 左侧爆发中心有强白光和烟尘云，Details 标题显示 `Debris_01003` 当前约 `200 Particles`。
>
> 联动关系: `Lifetime=0.6..1.25` 缩短该火花层持续时间，`Random Non-Uniform` 和 `Random X` 让小火花尺寸与纹理采样产生变化。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` Scale Color 颜色饱和度调整
> - 组成部分: Preview + System Overview + Niagara Stack + Scale Color Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Debris_01002 / Scale Color`
> - 目的: 调整第一层火花颜色，降低偏黄感并保持亮度随生命周期衰减。
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float` |
> | Vector | `10.0, 7.0, 3.0` |
> | RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Scale Curve | `50.0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `Random Range Float` |
> | Alpha Minimum | `1.0` |
>
> 曲线:
> - RGB 曲线从接近 `1.0` 缓慢下降到约 `0.2`。
> - Alpha 曲线从接近 `1.0` 线性下降到接近 `0`。
>
> Preview: 左侧可见白橙色光柱、周围火花和灰尘云；System Overview 中多组发射器同时可见。
>
> 联动关系: `10.0,7.0,3.0` 相比前一批提高蓝分量，降低过黄色感；RGB/Alpha 两条曲线分别控制亮度和透明度衰减。
> 图表转写（UE-GTXT v4）
> - 类型: `Light_01` 灯光半径属性写入
> - 组成部分: System Overview + Niagara Stack + Set Parameter Details + Timeline
> - 所属: `Exp_01 / Light_01 / Set (PARTICLES) LightRadius`
> - 目的: 新增灯光发射器，并为 Light Renderer 写入粒子灯光半径。
>
> Light_01 Stack:
> | 阶段 | 可见模块/项 |
> |---|---|
> | Emitter Update | `Emitter State`、`Spawn Burst Instantaneous` |
> | Particle Spawn | `Initialize Particle`、`Set (PARTICLES) LightRadius` |
> | Particle Update | `Particle State` |
> | Render | `Sprite Renderer` 灰置、`Light Renderer` 启用 |
>
> Set Parameter Details:
> | 字段 | 值 |
> |---|---|
> | Target Attribute | `PARTICLES LightRadius` |
> | Value | `100.0` |
>
> Emitter 状态:
> - `Light_01` 当前为 CPU 发射器。
> - `Emitter State` 显示 `Self / Once`。
> - Details 标题显示当前没有运行预览或 `0 Particles`。
>
> 联动关系: `Set (PARTICLES) LightRadius=100.0` 为后续 `Light Renderer` 提供半径属性；Sprite Renderer 被灰置，主要可见输出由 Light Renderer 承担。

### 00:15:18-00:17:58 Alpha、生命周期、颜色

- 本段定位：Alpha、生命周期、颜色。
- 知识点：半径大约50 如果有体积散射 光周围会有点灰光的感觉 现在用缩放颜色 颜色约152有些橙色。
- 知识点：Alpha亮度逐渐自然下降 大约5万 非常强 生命周期是 42秒 5.8秒 位置适当往上 光源在上面 轻柔地向下扩散 还是感觉有些强 感觉太黄了。
- 知识点：现在感觉又太红了 总体上还不错 接下来要添加的是折射 因为这是地面冲击的动作折射 结构使用MathRen 这种选项快速 再加一个Best。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡中 Light_01 灯光效果初查
> - 组成部分: Level Viewport + Content Browser + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览，底部窗口为 `Exp_01 / Light_01`
> - 目的: 查看新增灯光后，角色附近地面是否出现柔和辉光。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor` 状态。
> - 棋盘地面中角色站在左侧区域，附近有一个很小的暗色/发光点，画面整体爆炸效果尚未进入强亮阶段。
> - 字幕提示“光周围会有点辉光的感觉”。
>
> Outliner:
> - 可见 `DirectionalLight`、`01_Swing_Trail`、`Cine Camera Actor`、`Floor`、`Greystone` 等对象。
>
> 底部 Niagara 窗口:
> - Details 标题可见 `Light_01`，显示约 `1 Particles`。
> - 底部当前模块仍与 `LightRadius` 设置相关。
>
> 联动关系: 该图用于把 `Light_01` 的半径设置放回关卡视角检查；可见辉光较弱，因此这里只记录初查状态，不扩写未显示的光照范围数值。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡中灯光、火花和地裂合成预览
> - 组成部分: Level Viewport + Content Browser + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览，底部窗口为 `Exp_01 / Light_01`
> - 目的: 检查灯光加入后，地面冲击、火花、烟尘和中心光柱的整体亮度。
>
> Level Viewport:
> - 中心爆炸区域可见白橙色光柱、密集白黄色火花、黑灰烟尘、地面裂缝和散落碎片。
> - 地面附近出现偏暖的柔和亮部，覆盖爆炸中心周围。
> - 左侧角色被爆炸光和烟尘包围，画面中火花数量明显多于 S06_1。
>
> Content Browser:
> - 当前仍位于 `Material` 目录，`M_AdditiveDe_v01_01` 材质资源高亮可见。
>
> 底部 Niagara 窗口:
> - Details 标题可见 `Light_01`，显示 `0 Particles`。
>
> 联动关系: 该关卡预览把 Light Renderer 与已有火花/烟尘层叠加后检查，重点是光柱和地裂周围的暖色辉光是否与爆炸层融合。
> 图表转写（UE-GTXT v4）
> - 类型: 折射用新发射器初始属性
> - 组成部分: System Overview + Niagara Stack + Emitter Properties Details
> - 所属: `Exp_01 / Refrac...` 新发射器；Details 标题仍显示 `Empty`
> - 目的: 新建折射用发射器，并确认它的基础发射器属性、生命周期语境和 Renderer 状态。
>
> System Overview:
> | 项 | 状态 |
> |---|---|
> | 新发射器名称输入 | `Refrac` 可见 |
> | 当前节点 Tooltip | `Niagara Overview Node` |
> | Renderer | `Sprite Renderer` 灰置、`Mesh Renderer` 启用 |
>
> Emitter Properties:
> | 字段 | 值 |
> |---|---|
> | Local Space | 未勾选 |
> | Determinism | 未勾选 |
> | Interpolated Spawning | 勾选 |
> | Sim Target | `CPUSim` |
> | Calculate Bounds Mode | `Dynamic` |
> | Requires Persistent IDs | 未勾选 |
>
> Emitter State:
> | 字段 | 值 |
> |---|---|
> | Life Cycle Mode | `System` |
> | Scalability Mode | `System` |
>
> Preview: 左侧预览区为空或无明显粒子，Details 标题显示 `Empty` 当前 `0 Particles`。
>
> 联动关系: 该图只是折射发射器的初始结构证据；未显示折射材质网络或 Mesh Renderer 具体网格，因此不补写未出现的折射参数。

### 00:18:17-00:21:11 网格、生命周期

- 本段定位：网格、生命周期。
- 知识点：后续会使用这个材料 网格是使用预先提供的部分 在资源中提供的 有一个叫基础平面的东西 后续会放入这个检查可用材料 并添加后打开 材料将使用这里的MathKey实例的一版本。
- 知识点：现在它将法线方向设置为Z轴的复制 所以请看一下 首先从大小这些方面进行调整 网格缩放 统一设置为4左右 生命周期约为0.85。
- 知识点：适当离地面悬空一些 因为将按Z轴基准 这样摆放 通过这个方向进行旋转 这样将根据Z轴平坦地摆放 这样做后摄像机偏移 摄像机偏移好像没有特别需要。
- 知识点：终于用动态采 在一号上有一个可以调节失真强度的参数 给人一种中间快速消亡的感觉 这样我们来看一下。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Refraction_01` Mesh Renderer 设置
> - 组成部分: Preview + System Overview + Mesh Renderer Details + Timeline
> - 所属: `Exp_01 / Refraction_01 / Mesh Renderer`
> - 目的: 为地面冲击折射层绑定基础平面类网格，并使用 Mesh Renderer 输出。
>
> Mesh Renderer Details:
> | 字段 | 值 |
> |---|---|
> | Meshes | `1 Array element` |
> | Mesh Index[0] | `S_Gnomon` |
> | Enable Material Overrides | 未勾选 |
> | Override Materials | `0 Array element` |
> | Source Mode | `Particles` |
> | Locked Axis Enable | 未勾选 |
> | Enable Mesh Flipbook | 未勾选 |
> | Facing Mode | `Default` |
> | Sort Mode | `None` |
> | Enable Frustum Culling | 未勾选 |
> | Enable Camera Distance Culling | 未勾选 |
> | Renderer Visibility | `0` |
>
> Stack 状态:
> - `Refraction_01` 为 CPU 发射器，Render 中 `Sprite Renderer` 灰置、`Mesh Renderer` 启用。
> - Details 标题显示约 `1 Particles`。
>
> Preview: 左侧预览较暗，只能看到少量碎片/点状残留。
>
> 联动关系: Mesh Renderer 负责输出折射用网格；此图只显示 Renderer 网格选择，未显示材质实例参数。
> 图表转写（UE-GTXT v4）
> - 类型: `Refraction_01` Initialize Particle 网格缩放与生命周期
> - 组成部分: Preview + System Overview + Initialize Particle Details + Timeline
> - 所属: `Exp_01 / Refraction_01 / Initialize Particle`
> - 目的: 为折射网格设置短生命周期和统一 Mesh Scale。
>
> Initialize Particle Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Direct Set` |
> | Point Attributes | Lifetime | `0.85` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Point Attributes | Position Offset | `0.0, 0.0, 0.0` |
> | Point Attributes | Mass Mode | `Unset / (Mass of 1)` |
> | Sprite Attributes | Sprite Size Mode | `Unset` |
> | Sprite Attributes | Sprite Rotation Mode | `Unset` |
> | Sprite Attributes | Sprite UV Mode | `Unset` |
> | Mesh Attributes | Mesh Scale Mode | `Uniform` |
> | Mesh Attributes | Mesh Uniform Scale | `4.0` |
> | Mesh Attributes | Mesh Renderer Array Visibility | `Unset` |
> | Ribbon Attributes | Ribbon Width / Facing / Twist Mode | `Unset` |
>
> Stack 状态:
> - `Refraction_01` Render 中 `Mesh Renderer` 启用，`Sprite Renderer` 灰置。
> - Details 标题显示当前 `0 Particles`。
>
> 联动关系: `Lifetime=0.85` 控制折射网格持续时间，`Mesh Uniform Scale=4.0` 控制折射平面初始尺寸；Position Offset 只按 Simulation 字段记录，不额外断言外部坐标。
> 图表转写（UE-GTXT v4）
> - 类型: `Refraction_01` Dynamic Material Parameters 曲线
> - 组成部分: Preview + Niagara Stack + Dynamic Material Parameters Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Refraction_01 / Dynamic Material Parameters`
> - 目的: 用动态材质参数控制折射强度，使中间阶段快速消亡。
>
> Dynamic Material Parameters:
> | 字段 | 值 |
> |---|---|
> | 当前页签 | `Index 0` / `All` |
> | Write Parameter Index 0 | 勾选 |
> | Param1 | `Float from Curve` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.0` |
> | Param1-0 | `0.0` |
> | Param2-0 | `0.0` |
> | Param3-0 | `0.0` |
>
> 曲线:
> - 曲线从 `0` 快速升到 `1.0` 附近，再向生命周期末端下降到 `0`。
> - 当前 Key Data 显示 Time `0.5`、Value `0.6`。
>
> Stack 状态:
> - `Dynamic Material Parameters` 位于 `Particle Update`，`Mesh Renderer` 仍启用。
> - Details 标题显示 `Refraction_01` 当前 `0 Particles`。
>
> 联动关系: `Param1` 曲线驱动材质实例中可调折射/失真强度；曲线前段快速升高、后段下降，对应“中间快速消亡”的效果控制。

### 00:21:15-00:24:11 Lifetime、Color、Alpha

- 本段定位：Lifetime、Color、Alpha。
- 知识点：这样因为设置为负一的质 下方会有凹陷感的强度产生 很好 如果加强这个 就会更强烈递进入 然后复制一个这个 最后将添加模糊 这里将直接使用sweat。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 知识点：大小大约设置为750 这样使用去掉选项值 也去掉Mesh Scale和Orientation 然后用相机偏移 大约500左右 已经能看到一些进入的感觉了。
- 知识点：Color 值为 这个不应该有Color 需要用零指 然后用Alpha让品牌发展好 是的 只需添加这种感觉 然后需要再添加一个大小 这个只是图表 感觉上这 在动态中。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Lifetime`、`Color`、`Alpha`、`材质`、`粒子`、`速度`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的折射/火花合成效果
> - 组成部分: Level Viewport + Content Browser + Outliner + 底部 Niagara 窗口
> - 所属: `02_Earth_Explosion` 关卡预览；底部窗口为 `Exp_01 / Refraction_01`
> - 目的: 检查折射层加入后，中心光柱、火花、烟尘和地裂的整体观感。
>
> Level Viewport:
> - 爆炸中心有白橙色光柱和密集火花，周围叠加黑灰烟尘、地裂和散落碎片。
> - 角色位于爆炸左侧，周围有灰尘和小火花。
> - 视口处于 `Pilot Actor: Cine Camera Actor` 状态。
>
> Content Browser:
> - `MI_Refraction...` 材质实例缩略图在左下区域高亮可见。
> - `M_Additive...`、`M_Decal_01`、`M_Radial...` 等材质资源可见。
>
> 底部 Niagara 窗口:
> - Details 标题可见 `Refraction_01`，显示 `0 Particles`。
>
> 联动关系: 该图把 `Refraction_01` 的 Mesh Renderer 和动态材质参数放回关卡中检查，重点是折射/模糊层是否与火花、烟尘和地裂融合。
> 图表转写（UE-GTXT v4）
> - 类型: `RadialBlur_01` Scale Sprite Size
> - 组成部分: Preview + System Overview + Scale Sprite Size Details + Curve Editor + Timeline
> - 所属: `Exp_01 / RadialBlur_01 / Scale Sprite Size`
> - 目的: 用统一尺寸曲线让径向模糊层从小逐渐放大。
>
> Scale Sprite Size Details:
> | 字段 | 值 |
> |---|---|
> | Scale Sprite Size Mode | `Uniform Curve` |
> | Uniform Curve Sprite Scale | `Curve for Floats` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Uniform Curve Scale | `1.0` |
>
> 曲线:
> - 曲线从接近 `0` 快速上升，并在后段接近 `1.0`。
> - 悬停提示显示 `Name: Uniform Curve Sprite Scale`、Time `0.1`、Value `0.265`。
>
> System Overview:
> - `RadialBlur_01` 为 CPU 发射器。
> - Stack 中可见 `Initialize Particle`、`Initial Mesh Orientation`、`Camera Offset`、`Dynamic Material Parameters`、`Scale Color`、`Sprite Renderer`。
>
> Preview: 左侧可见淡烟尘和少量碎片，效果较弱。
>
> 联动关系: 该统一曲线控制径向模糊层尺寸随生命周期放大，和上下文中“大小约 750、使用 Camera Offset”的模糊层调整相关。
> 图表转写（UE-GTXT v4）
> - 类型: `RadialBlur_01` Dynamic Material Parameters
> - 组成部分: Preview + System Overview + Dynamic Material Parameters Details + Curve Editor + Timeline
> - 所属: `Exp_01 / RadialBlur_01 / Dynamic Material Parameters`
> - 目的: 用动态材质参数控制径向模糊强度，使模糊前段快速出现后逐渐减弱。
>
> Dynamic Material Parameters:
> | 字段 | 值 |
> |---|---|
> | 当前页签 | `Index 0` / `All` |
> | Write Parameter Index 0 | 勾选 |
> | Param1 | `Float from Curve` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Scale Curve | `1.5` |
> | Param1-0 | `0.0` |
> | Param2-0 | `0.0` |
> | Param3-0 | `0.0` |
>
> 曲线:
> - 曲线从 `0` 快速升到约 `1.0`，之后持续下降到接近 `0`。
> - 悬停提示显示 `FloatCurve` Time `0.2`、Value `0.654`。
>
> Preview: 左侧仅可见淡烟尘、少量碎片和弱点光。
>
> 联动关系: `Param1` 曲线用于控制径向模糊材质参数，`Scale Curve=1.5` 放大该曲线强度；曲线下降段对应减弱模糊效果。

### 00:24:20-00:27:20 粒子

- 本段定位：粒子。
- 知识点：减弱效果会更快 这种感觉怎么样呢 我们来看看 现在已经应用了 不要太强烈淡淡的爆炸冲击就好 这种感觉可能适合 好的 那就 Particle工作已经完成。
- 知识点：现在只需添加Shake并完成 Shake应该同样强度了Shake 对其三个时间 应该使用第二个摇动 这个需要时机 在35帧处生成了粒子。
- 知识点：提前一帧收集会比较好 43再到53 我们看一下云锡团队 如果感觉有些快的话 只一后一正 好的 现在似乎没问题 那么几乎完成 我有一部分漏掉了 应该早点放进这个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Particle`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `RadialBlur_01` Scale Sprite Size 精调
> - 组成部分: Preview + System Overview + Scale Sprite Size Details + Curve Editor + Timeline
> - 所属: `Exp_01 / RadialBlur_01 / Scale Sprite Size`
> - 目的: 缩短径向模糊尺寸变化节奏，让冲击感更快减弱。
>
> Scale Sprite Size Details:
> | 字段 | 值 |
> |---|---|
> | Scale Sprite Size Mode | `Uniform Curve` |
> | Uniform Curve Sprite Scale | `Curve for Floats` |
> | CurveIndex | `PARTICLES NormalizedAge` |
> | Uniform Curve Scale | `1.0` |
>
> 曲线:
> - 曲线从 `0` 快速升高到接近 `1.0`，随后在后段保持高位。
> - 左下 Curve Editor 同步显示曲线前段快速上升。
>
> Timeline:
> - 当前播放头约 `5.32` 秒。
> - `RadialBlur_01` 与多个火花/碎片发射器轨道并列可见。
>
> Preview: 左侧烟尘中只剩较弱亮点和碎片，整体冲击层较淡。
>
> 联动关系: 该图继续调整径向模糊层的尺寸节奏，使爆炸冲击从强烈阶段更快转为淡化状态。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中 `Exp 01/02/03` 粒子触发时机
> - 组成部分: Sequencer Timeline + Camera Cuts + Actor Tracks
> - 所属: `02_Earth_Explosion` Sequencer
> - 目的: 对齐三次地面爆炸粒子的生成时机。
>
> Sequencer 状态:
> | 字段 | 值 |
> |---|---|
> | 当前帧/时间显示 | `0034`，显示 `35 of 121` |
> | 帧率 | `30 fps` |
> | Camera Cuts | 顶部缩略图轨道覆盖爆炸预览 |
> | 当前播放头 | 位于约 `0034` |
>
> 轨道:
> | 轨道 | 可见内容 |
> |---|---|
> | `Cine Camera Actor` | `CameraComponent` 参数轨道，含 Current Aperture `2.8`、Current Focal Length `25.0`、Manual Focus Distance `100000.0` 等 |
> | `Greystone` | `Animation / Ability_R` 动画片段 |
> | `Exp 01` | `Spawned` 和 `Transform` 轨道；播放头处可见关键帧 |
> | `Exp 02` | `Spawned` 和 `Transform` 轨道；关键帧位于稍后时间 |
> | `Exp 03` | `Spawned` 和 `Transform` 轨道；关键帧位于更后时间 |
>
> 联动关系: `Exp 01/02/03` 的 Spawn/Transform 关键帧错开排列，用于把三次爆炸按动作节奏依次触发；此处只按 Sequencer 时间轴记录，不额外推断空间位置。
> 图表转写（UE-GTXT v4）
> - 类型: Cine Camera Actor 与早期 Sequencer 预览
> - 组成部分: Level Viewport + Outliner + Camera Details + Sequencer Timeline
> - 所属: `02_Earth_Explosion / Cine Camera Actor`
> - 目的: 在爆炸触发前检查相机视角和角色初始画面。
>
> Camera Details:
> | 字段 | 值 |
> |---|---|
> | Selected Actor | `Cine Camera Actor` |
> | Component | `CameraComponent` |
> | Transform Location | `0.0, 0.0, 0.0` |
> | Transform Rotation | `0.0, 0.0, 0.0` |
> | Transform Scale | `1.0, 1.0, 1.0` |
> | Filmback | `16:9 Digital Film` |
> | Lens Settings | `Universal Zoom` |
> | Crop Settings | `No Crop` |
> | Current Focal Length | `25.0` |
> | Current Aperture | `2.8` |
>
> Viewport/Sequencer:
> - 视口处于 `Pilot Actor: Cine Camera Actor` 状态。
> - 角色位于棋盘地面左侧，爆炸效果尚未出现。
> - Sequencer 底部播放头位于早期帧，显示约 `0004` / `9 of 121`。
>
> 联动关系: 该图用于确认粒子触发前的相机视角与镜头参数，为后续在 Sequencer 中对齐爆炸和 Shake 时机提供参考。

### 00:27:23-00:30:16 粒子

- 本段定位：粒子。
- 知识点：在爆炸之前 根据动作放简单的摆动轨迹 我是想一起放进去的 但是先制作了爆炸 会在后面添加看看 首先要根据挥石的动作放进去 像第一个粒子中的那样。
- 知识点：在第一个粒子中制作的粒子 几乎将会直接使用 看来能很快制作出来 在这个粒子中 因为这个轨迹不是重要元素 打开动作 需要把这个轨迹应付的时机。
- 知识点：抓住吧 从48帧开始 状态同时 从48帧开始提取定时的 I-GRADE效果 大约到55帧 持续 粒子从一中复制1号过来。
- 知识点：放置 放置后插槽是 SX 这是underbar 就是一个sword 选择sword 顶端 选择下一个 往下适当移动一下 wait 打开对应资源粒子试试看。
- 知识点：调整一下 不过先看看它是怎么出来的 黑色就不放了 只开主面板看 现在不再放了 主面板看 现在不出来的原因是这个太长了 长度太长了 从这个开始调整 是会出来的。
- 核对对象：`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 摆动轨迹加入前的动画与 Sequencer 参照
> - 组成部分: Level Editor + Sequencer + Animation Editor + Content Browser
> - 所属: `02_Earth_Explosion / Greystone / Ability_R`
> - 目的: 在爆炸前查找挥剑动作时机，用于后续添加简单剑轨迹。
>
> Sequencer:
> | 字段 | 值 |
> |---|---|
> | 序列 | `02_Earth_Explosion` |
> | 当前帧显示 | 约 `0074` |
> | 帧范围状态 | `75 of 121` |
> | Camera Shake 片段 | 多段 `ExShake_02_C` |
> | 角色轨道 | `Greystone`，含 `Ability_R` |
> | 粒子轨道 | `Exp 01` 等 Spawn/Transform 轨道可见 |
>
> Animation Editor:
> - 当前资源为 `Ability_R`。
> - 预览视口显示 Greystone 挥剑动作的一帧，角色和剑位于画面下方。
> - 统计信息可见：LOD0、Triangles `87,117`、Vertices `59,362`、UV Channels `2`、Approx Size `305x339x319`、Framerate `60 fps`。
>
> Content Browser:
> - 路径位于 `Characters/Heroes/Greystone/Animations`。
> - `Ability_R` 资源被选中。
>
> 联动关系: 该图用于把 `Ability_R` 动作时机与 `02_Earth_Explosion` Sequencer 中的爆炸轨道对齐，为后续在剑尖 Socket 上放置 `Trail_01` 提供时间参照。
> 图表转写（UE-GTXT v4）
> - 类型: `Trail_01` Niagara System 总览
> - 组成部分: Preview + System Overview + Parameters + Timeline
> - 所属: `Particle/03/Trail_01`
> - 目的: 检查从旧粒子复制来的剑轨系统，确认多个发射器的启用状态和预览粒子数。
>
> System Overview:
> | 发射器 | 状态/说明 |
> |---|---|
> | `Main` | 存在，`Emitter State`、`Spawn Per Frame`、`Particle Spawn`、`Initialize Particle`、`Camera Offset`、`Particle State`、`Dynamic Material Parameters`、`Scale Color`、`Ribbon Renderer` 等模块可见 |
> | `Sub` | 存在，结构与 Main 类似 |
> | `Dark` | 存在，结构与 Main 类似 |
> | `Black` | 存在，Timeline 中可见 |
> | `Empty` | 存在，Timeline 中可见 |
>
> Preview 粒子计数:
> | 发射器 | 计数 |
> |---|---|
> | Main | `0 Current, 7 Max (est)`，`Complete` |
> | Sub | `1 Current, 12 Max (est)`，`Inactive` |
> | Dark | `0 Current, 12 Max (est)`，`Inactive` |
> | Black | `5 Current, 16 Max (est)`，`Inactive` |
> | Empty | `0 Current, 0 Max (est)`，`Complete` |
>
> Parameters:
> - System Attributes 中可见 `Age`、`bCompleteOnInactive`、`CurrentLoopDuration`、`ExecutionState`、`ExecutionStateSource`、`LoopCount`、`LoopedAge`、`NormalizedLoopAge`。
>
> 联动关系: 该图记录复制后的 `Trail_01` 系统结构，后续会在动画通知中绑定该系统，并缩短/调整发射器时长以适配较短的挥剑动作。
> 图表转写（UE-GTXT v4）
> - 类型: `Ability_R` Anim Notify 绑定 `Trail_01`
> - 组成部分: Animation Editor + Anim Notify Details + Asset Browser
> - 所属: `Ability_R / Notify State / Trail_01`
> - 目的: 把剑轨 Niagara System 绑定到剑尖 Socket，并设置位置偏移。
>
> Anim Notify Details:
> | 字段 | 值 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Socket Name | `FX_Sword_T` |
> | Location Offset | `0.0, 0.0, -20.0` |
> | Rotation Offset | `0.0, 0.0, 0.0` |
> | Destroy Immediately | 未勾选 |
> | Notify Color | 淡紫色 |
> | Trigger on Dedicated Server | 勾选 |
> | Trigger on Follower | 未勾选 |
> | Notify Filter Type | `No Filtering` |
>
> Animation Timeline:
> - `Notifies` 轨道上有 `Trail_...` 通知段。
> - 通知段位于挥剑动作中后段，截图中播放头靠近通知段右侧。
>
> Viewport:
> - Greystone 站立挥剑，剑体位于角色前下方。
>
> 联动关系: `FX_Sword_T` 指向剑尖 Socket，`Location Offset` 把轨迹沿通知字段记录的第三个分量偏移 `-20.0`；该偏移只按 UI 字段记录，不推导外部轴语义。

### 00:30:22-00:35:13 生命周期、颜色

- 本段定位：生命周期、颜色。
- 知识点：可能这个动作比较短 所以我们一次就是适当调整一下 生命周期似乎太短 尺寸可能还不错 但是在这个动作中 首先这个得对齐 不是Z轴 而是Y轴对齐。
- 知识点：然后在颜色部分调整到黄色那边 这个我不推 先放在2 然后这个用作自定义测像象量 这样似乎会更合适 这个轴现在调整的差不多了。
- 知识点：-10.6 主部分已经调整好了 看看第二个元素 第二个元素 也就是这个部分是相同的 首先从象量开始排序 然后生命周期似乎可以不更改。
- 知识点：只增大尺寸吗 出来的不错 纹理加载似乎暂时没有完成 有点模糊出来了 然后这个颜色我就会适当改变一下。
- 知识点：似乎可以不更改 稍高饱和度的也没有关系 反而这个被爆炸遮挡 就是所以不太好看 不过既然是学过的功能 使用一次就会比较好 所以把它包含在这里。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Trail_01.Main.Initialize Particle` 生命周期与 Ribbon 基础属性
> - 组成部分: Preview + System Overview + Initialize Particle Details + Timeline
> - 所属: `Trail_01 / Main / Initialize Particle`
> - 目的: 为短挥剑动作缩短主轨迹寿命，并设置 Ribbon 宽度与朝向向量字段。
>
> Preview 粒子计数:
> | 发射器 | 计数/状态 |
> |---|---|
> | Main | `0 Current, 0 Max (est)`，`Active` |
> | Sub | `0 Current, 12 Max (est)`，`Active` |
> | Dark | `0 Current, 12 Max (est)`，`Active` |
> | Black | `0 Current, 16 Max (est)`，`Disabled` |
> | Empty | `0 Current, 4 Max (est)`，`Active` |
>
> Initialize Particle:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Direct Set` |
> | Point Attributes | Lifetime | `0.3` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Point Attributes | Position Offset | `0.0, 0.0, 0.0` |
> | Sprite Attributes | Sprite Size Mode | `Unset` |
> | Mesh Attributes | Mesh Scale Mode | `Unset` |
> | Ribbon Attributes | Ribbon Width Mode | `Direct Set` |
> | Ribbon Attributes | Ribbon Width | `100.0` |
> | Ribbon Attributes | Ribbon Facing Mode | `Direct Set` |
> | Ribbon Attributes | Ribbon Facing Vector | `0.0, 1.0, 0.0` |
> | Ribbon Attributes | Ribbon Twist Mode | `Unset` |
>
> 联动关系: `Lifetime=0.3` 缩短主轨迹可见时间，`Ribbon Width=100.0` 控制拖尾宽度；Facing Vector 仅按 Niagara 字段记录为 `0,1,0`。
> 图表转写（UE-GTXT v4）
> - 类型: `M_SwordTrail_01_Ins_02` 材质实例参数
> - 组成部分: Material Instance Preview + Details / Layer Parameters
> - 所属: `Trail_01` 使用的剑轨材质实例
> - 目的: 调整剑轨颜色、平铺、透明度和折射强度，使轨迹偏黄且与动作匹配。
>
> Global Scalar Parameter Values:
> | 参数 | 值 |
> |---|---|
> | `Color_Bias` | `5.0` |
> | `Color_Tile_U` | `0.5` |
> | `Color_Tile_V` | `0.2` |
> | `Desaturation` | `0.8` |
> | `Edge_Pow` | `1.0` |
> | `Edge_Str` | `0.02` |
> | `Normal_Tile_U` | `1.0` |
> | `Normal_Tile_V` | `0.2` |
> | `Opacity_Pow` | `1.0` |
> | `Opacity_Str` | `1.0` |
> | `Opacity_Tile_U` | `1.0` |
> | `Opacity_Tile_V` | `1.0` |
> | `Refraction_Str` | `1.0` |
>
> Global Texture Parameter Values:
> | 参数 | 资源 |
> |---|---|
> | `Color_Tex` | `T_Cloud_Wisp_Chromatic_Tile...` |
> | `Normal_Tex` | `2ndInfectedMapNormal` |
> | `Opacity_Tex` | `fxPtn_oblique` |
>
> Global Vector Parameter Values:
> - `Head_Color`: 偏浅暖色。
> - `Tail_Color`: 黄色。
>
> Preview:
> - 材质预览区域显示半透明的纵向烟羽/刮痕状纹理，右侧带暖色边缘。
>
> 联动关系: `Tail_Color` 的黄色与上下文中的“颜色调整到黄色”对应；`Desaturation=0.8` 与纹理色彩压低有关，`Refraction_Str=1.0` 保留折射强度。
> 图表转写（UE-GTXT v4）
> - 类型: `Ability_R` 中剑轨 Notify 的位置和资源确认
> - 组成部分: Animation Editor + Anim Notify Details + Asset Browser
> - 所属: `Ability_R / Notify State / Trail_01`
> - 目的: 复核剑轨通知段位置、Socket 绑定和偏移设置。
>
> Anim Notify Details:
> | 字段 | 值 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Socket Name | `FX_Sword_T` |
> | Location Offset | `0.0, 0.0, -20.0` |
> | Rotation Offset | `0.0, 0.0, 0.0` |
> | Destroy Immediately | 未勾选 |
> | Notify Color | 淡紫色 |
> | Trigger on Dedicated Server | 勾选 |
> | Trigger on Follower | 未勾选 |
> | Notify Filter Type | `No Filtering` |
>
> Animation Timeline:
> - `Trail_...` Notify 段位于约第 50 帧后到第 60 帧前后的区间。
> - 播放头显示在时间轴右侧较后位置，右下角可见帧/时间百分比读数。
>
> Asset Browser:
> - `Ability_R` 被选中。
> - 列表中可见 `Ability_E`、`Ability_E_MS`、`Ability_Q`、`Ability_R` 等动画资源。
>
> 联动关系: 该图与 S10_3 形成复核关系，确认在调整生命周期和颜色后，`Trail_01` 仍绑定在 `FX_Sword_T`，且偏移保持 `0,0,-20`。

### 00:35:22-00:38:46 Sequencer

- 本段定位：Sequencer。
- 知识点：好像是需要 一二 调整到05 生成进行的很好 生成进行的很好 我觉得量再多一点也没关系 0.4 效果更好 这样我先在序列器上播放一次 是的现在轨迹略微可见。
- 知识点：如果想让这个轨迹更明显 虽然看不太清楚 也没关系 先调整这个爆炸的优先级 是的这样优先级 轨迹会在前面 简单的轨迹添加已经进行完成了 现在终于所有元素都已经进来了。
- 知识点：效果很好 花了挺多时间 但可能是因为是第一个例子 没有现成的元素直接复制是比较困难 所以花了更多时间 从下一个例子开始会尽量减少时间 需要尝试配合。
- 知识点：第二个例子就是辛苦跟进了 此次课程到此为止 谢谢 谢谢。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Trail_01.Empty.Emitter State` 循环时长调整
> - 组成部分: Preview + System Overview + Emitter State Details + Timeline
> - 所属: `Trail_01 / Empty / Emitter State`
> - 目的: 调整轨迹系统中的 Empty 发射器循环时长和延迟，使生成节奏贴合短动作。
>
> Preview 粒子计数:
> | 发射器 | 计数/状态 |
> |---|---|
> | Main | `0 Current, 0 Max (est)`，`Active` |
> | Sub | `11 Current, 12 Max (est)`，`Active` |
> | Dark | `11 Current, 12 Max (est)`，`Active` |
> | Empty | `0 Current, 0 Max (est)`，`Complete` |
>
> Emitter State Details:
> | 字段 | 值 |
> |---|---|
> | Life Cycle Mode | `Self` |
> | Inactive Response | `Complete (Let Particles Finish then ...)` |
> | Loop Behavior | `Once` |
> | Loop Duration Mode | `Fixed` |
> | Loop Duration | `0.4` |
> | Loop Delay | `0.12`，勾选 |
> | Scalability Mode | `System` |
>
> System Overview:
> - `Empty` 发射器被选中。
> - `Emitter State` 位于 `Emitter Update`，旁边有 `Once` 标记。
> - `Main`、`Sub`、`Dark` 发射器仍在系统中可见。
>
> 联动关系: `Loop Duration=0.4` 与上下文中“0.4 效果更好”对应；`Loop Delay=0.12` 让 Empty 发射器的触发略后于系统开始。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中挥剑轨迹与爆炸轨道叠放
> - 组成部分: Sequencer + Outliner + Actor Details
> - 所属: `02_Earth_Explosion`，新增/可见 `01_Swing_Trail`
> - 目的: 在完整序列中检查剑轨、角色动作、摄像机抖动和爆炸粒子触发的相对时机。
>
> Sequencer:
> | 项目 | 可见内容 |
> |---|---|
> | 序列 | `02_Earth_Explosion` |
> | 帧率 | `30 fps` |
> | 当前帧 | `0004` 附近 |
> | 帧状态 | `5 of 121` |
> | Camera Cuts | 顶部镜头切片贯穿序列 |
> | Cine Camera Actor | `CameraComponent`、`Camera Shake`、`Current Aperture=2.8`、`Current Focal Length=25.0`、`Manual Focus Distance=100000.0`、`Spawned` |
> | Camera Shake | 多段 `ExShake_02_C` 依次错开 |
> | Greystone | `Ability_R` 动画片段可见 |
> | Exp 01/02/03 | `Spawned` 与 `Transform` 轨道可见，触发点错开 |
>
> Outliner:
> - 可见 `01_Swing_Trail`，类型为 `LevelSequence`。
> - `Cine Camera Actor` 属于 `02_Earth_Explosion`。
> - 还可见 `Floor`、`Greystone`、`PlayerStart`、`PostProcessVo...`、`SpotLight`。
>
> Actor Details:
> - 右侧 Details 显示选中 `Floor`，Location 约 `0.0, 0.0, -0.5`，Rotation `0,0,0`，Scale `8.0,8.0,8.0`。
>
> 联动关系: `01_Swing_Trail` 在 Outliner 中作为独立序列对象存在，用于把剑轨与 `02_Earth_Explosion` 的角色动画和爆炸粒子轨道一起检查。
> 图表转写（UE-GTXT v4）
> - 类型: 剑轨加入后的关卡最终预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Sequencer
> - 所属: `02_Earth_Explosion` 关卡预览；资源 `Trail_01`
> - 目的: 查看挥剑轨迹进入完整效果后的画面位置和可见度。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 地面为灰色棋盘格，画面左下偏中位置显示 Greystone 角色。
> - 角色旁边有一小段暗色/红色轨迹残留，轨迹较细、可见度不高。
> - 顶部红字提示 `TEXTURE STREAMING POOL OVER ... MiB BUDGET`。
>
> Content Browser:
> - 路径位于 `Content/Coloso_Tutorial/Particle/03`。
> - `Trail_01` Niagara System 资源被选中，旁边可见 `Exp_01`。
>
> Outliner:
> - `01_Swing_Trail`、`Cine Camera Actor`、`Floor`、`Greystone`、`PlayerStart`、`PostProcessVo...`、`SpotLight` 可见。
>
> Sequencer:
> - 下方 Sequencer 仍为 `02_Earth_Explosion`。
> - 当前帧接近序列开头，显示 `0001`、`2 of 121`。
>
> 联动关系: 该图是把 `Trail_01` 放入 Sequencer 后的整体预览，重点确认轨迹已经进入关卡合成，但在爆炸/角色动作中可见度偏弱。

## 补充视觉证据

### S11 00:32:39

> 图表转写（UE-GTXT v4）
> - 类型: `Ability_R` 动画预览中的剑轨效果补充证据
> - 组成部分: Animation Editor + Anim Notify Details + Viewport Preview
> - 所属: `Ability_R / Notify State / Trail_01`
> - 目的: 用动画编辑器预览确认剑轨颜色、弧形和 Notify 绑定结果。
>
> Viewport:
> - Greystone 处于挥剑动作中，剑从角色右侧扫向画面右上方向。
> - 剑尖后方出现一条橙黄到暗红的弧形 Ribbon 轨迹，头部较亮，尾部逐渐变暗。
> - 轨迹与剑身运动方向一致，形成上扬弧线。
>
> Anim Notify Details:
> | 字段 | 值 |
> |---|---|
> | Niagara System | `Trail_01` |
> | Socket Name | `FX_Sword_T` |
> | Location Offset | `0.0, 0.0, -20.0` |
> | Rotation Offset | `0.0, 0.0, 0.0` |
> | Destroy Immediately | 未勾选 |
> | Notify Color | 淡紫色 |
> | Trigger on Dedicated Server | 勾选 |
> | Trigger on Follower | 未勾选 |
> | Notify Filter Type | `No Filtering` |
>
> Timeline:
> - 播放头位于通知段附近。
> - `Trail_...` 通知段在 `Notifies` 轨道上可见。
>
> 联动关系: 该补充图直接展示 `Trail_01` 经过生命周期、Ribbon Facing 和材质颜色调整后的动画预览效果，与 S11/S12 的参数截图互相校验。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


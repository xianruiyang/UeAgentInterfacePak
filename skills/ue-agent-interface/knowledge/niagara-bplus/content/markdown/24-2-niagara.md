# 24-2 制作角色位置变形Niagara粒子特效

# 24-2 制作角色位置变形Niagara粒子特效

## 关键术语

- `Velocity`、`Color`、`Alpha`、`Ribbon`、`Material`、`Multiply`、`Sequencer`、`Camera`、`RBD`、`SD`、`Mesh`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:00-00:04:51 Velocity、Alpha、Multiply

- 本段定位：Velocity、Alpha、Multiply。
- 知识点：sample location 第二个现在 001的样本 位置值会放入 还有这个alpha值 会控制这个位置值 所以会放入这个alpha值的。
- 知识点：控制曲线 因为要从0变到1 我打算先用1号快捷键 慢慢移动 现在这里没有显示的部分 从技术看来是正常的 这样近看又 排列有点奇怪 因为是设置成scale。
- 知识点：脱离生成 现在显示的是Z轴的部分 暂时把他的排列改成 velocity的line和face camera 不过还是没有什么显示 例子现在是有显示的。
- 知识点：移动也很顺利 需要思考 同时寻找问题 能解决的问题 现在没C出现了 但如果没有出现 这个颜色值现在没有可以添加的。
- 知识点：现在出现了 这个颜色值没有可以添加的 现在这里的比例颜色是必须的 这里是因为multiply 所以似乎没有出现 这里现在的morphing是learn。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Velocity`、`Alpha`、`Multiply`、`粒子`、`生命周期`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Lerp Particle Attributes` 参数截图
> - 组成部分: Preview + Particle Counts + User Parameters + Niagara Stack + Details + Timeline + 字幕
> - 所属: `Morph_01 / Collision`
> - 目的: 确认 `Lerp Particle Attributes` 只对 Position 做插值，并接入来自 Skeletal Mesh 采样的粒子位置输入。
>
> 模块清单:
> | 区域 | 模块/项 | 可读设置 | 作用 |
> |---|---|---|---|
> | Preview | 粒子预览 | `8338 Current, 98338 Max (est.) - [Collision] [Active]`；`Spark_01` 与 `Spark_01001` 为 Disabled | 当前只检查 Collision 发射器 |
> | User Parameters | `Skeletal_B` | 类型为 `Niagara Data Interface Skeletal Mesh`；`Preview Mesh=MurielSepia`；`Source Actor=None` | 第二个骨骼网格输入 |
> | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location`、`Skeletal Mesh Location 001`、`Set PARTICLES Position`、`Sample Texture`、`Dissolve`、`Kill Particles` | 两个 Skeletal Mesh Location 均标注 `Triangles / Random` | 生成阶段采样两组网格位置并设置粒子位置 |
> | Particle Update | `Particle State`、`Lerp Particle Attributes`、`Scale Color`、`Collision`、`Solve Forces and Velocity` | `Lerp Particle Attributes` 被选中 | 更新阶段执行属性插值 |
> | Details | `Lerp Particle Attributes` | `Lerp Position` 勾选；`Position A` 绑定到 `PARTICLES / SKELETAL MESH` 相关输入；`Position B` 可见但端点未完整展开；Sprite Alignment/Facing/Rotation/Size/SubimageIndex 等 Lerp 项未勾选 | 将位置作为本次 Lerp 的主要目标属性 |
> | Timeline | Niagara 时间轴 | 播放头约 `0.23`，读数 `56 of 2` 可见 | 当前调试帧 |
>
> 联动关系: 两个 `Skeletal Mesh Location` 在 Spawn 阶段提供采样位置，`Lerp Particle Attributes` 在 Update 阶段用 Alpha/Lerp 语义处理 Position；截图只证明 Position 插值项已启用，未完整展开的输入端不补写。
> 验证方式: 在 `Morph_01 > Collision > Particle Update` 选中 `Lerp Particle Attributes`，检查 `Lerp Position` 勾选状态与 Position A/B 绑定区域。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Skeletal Mesh Location` 采样参数截图
> - 组成部分: Preview + User Parameters + Niagara Stack + Details + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Skeletal Mesh Location`
> - 目的: 确认第一个骨骼网格采样模块使用 `USER Skeletal_A`，并按三角面随机采样。
>
> 参数表:
> | 模块 | 字段 | 值/状态 | 说明 |
> |---|---|---|---|
> | `Skeletal Mesh Location` | Skeletal Mesh | `USER Skeletal_A` | 第一个 Skeletal Mesh 输入 |
> | `Skeletal Mesh Location` | Mesh Sampling Type | `Surface (Triangles)` | 从网格表面三角形采样 |
> | `Skeletal Mesh Location` | Triangle Sampling Mode | `Random (All Triangles)` | 随机选择全部三角形 |
> | `Skeletal Mesh Location` | Sampled UV Index | `0` | 使用 UV0 |
> | `Skeletal Mesh Location` | Position Sampling | `Apply (Rigid)` | 采样位置应用刚性变换语义 |
> | `Skeletal Mesh Location` | Sampled Position Offset | `0.0 / 0.0 / 0.0` | 无可见偏移 |
> | `Skeletal Mesh Location` | Sampled Position Offset Coord | `Sampled Mesh` | 偏移相对采样网格 |
> | `Skeletal Mesh Location` | Write To Particle Position | 勾选 | 写入粒子位置 |
> | `Skeletal Mesh Location` | Velocity Sampling | `Output` | 输出速度采样 |
> | `Skeletal Mesh Location` | Orientation Sampling | `Apply` | 应用方向采样 |
>
> 预览状态: Preview 中显示一簇灰白粒子轮廓；Particle Counts 可读 `1202 Current, 98338 Max (est.) - [Collision] [Inactive]`；Timeline 播放头约 `3.67`。
> 联动关系: `Skeletal_A` 对应 `Serath` 用户参数；该模块输出的采样位置会进入后续 `Set PARTICLES Position` 与 `Lerp Particle Attributes` 链路。
> 验证方式: 选中 `Particle Spawn > Skeletal Mesh Location`，逐项核对 Skeletal Mesh、Sampling 和 Apply 字段。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Skeletal Mesh Location 001` 采样参数截图
> - 组成部分: Preview + User Parameters + Niagara Stack + Details + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Skeletal Mesh Location 001`
> - 目的: 确认第二个骨骼网格采样模块使用 `USER Skeletal_B`，作为位置变形目标输入。
>
> 参数表:
> | 模块 | 字段 | 值/状态 | 说明 |
> |---|---|---|---|
> | `Skeletal Mesh Location 001` | Skeletal Mesh | `USER Skeletal_B` | 第二个 Skeletal Mesh 输入 |
> | `Skeletal Mesh Location 001` | Mesh Sampling Type | `Surface (Triangles)` | 从三角形表面采样 |
> | `Skeletal Mesh Location 001` | Triangle Sampling Mode | `Random (All Triangles)` | 全三角形随机采样 |
> | `Skeletal Mesh Location 001` | Sampled UV Index | `0` | 使用 UV0 |
> | `Skeletal Mesh Location 001` | Position Sampling | `Apply (Rigid)` | 采样位置应用刚性变换语义 |
> | `Skeletal Mesh Location 001` | Sampled Position Offset | `0.0 / 0.0 / 0.0` | 无可见偏移 |
> | `Skeletal Mesh Location 001` | Sampled Position Offset Coord | `Sampled Mesh` | 偏移相对采样网格 |
> | `Skeletal Mesh Location 001` | Write To Particle Position | 勾选 | 写入粒子位置 |
> | `Skeletal Mesh Location 001` | Velocity Sampling | `Output` | 输出速度采样 |
> | `Skeletal Mesh Location 001` | Orientation Sampling | `Apply` | 应用方向采样 |
>
> 预览状态: Preview 中显示更密集的白色粒子团；Particle Counts 可读 `5476 Current, 98338 Max (est.) - [Collision] [Inactive]`；User Parameters 中 `Skeletal_A.Preview Mesh=Serath` 仍可见。
> 联动关系: `Skeletal_B` 对应目标角色网格，和 `Skeletal_A` 共同为后续 Position Lerp 提供 A/B 两端采样位置。
> 验证方式: 选中 `Particle Spawn > Skeletal Mesh Location 001`，确认 Skeletal Mesh 为 `USER Skeletal_B`，并核对 Sampling 与 Apply 字段。

### 00:04:51-00:09:43 关键流程 02

- 本段定位：关键流程 02。
- 知识点：克拉效 现在噪声强了 这也与生命时间对应 感觉减小强度比较好 设置一个承法浮动 最大值是为5000 然后尝试用曲线调整一下 一开始非常弱底。
- 知识点：0.2时机 变成了工作 一个似乎不能被删除 我在这里走一行 感觉慢一点 颜色化的模式 调整到15左右 然后因为扩散的感觉太强 用拖拽节点找到原来。
- 知识点：角色位置的散 力量没有那么强烈 毕竟这些角色现在还是 硬地移动 所以可能没有完全符合那个位置的感觉 在这里出生时的生成位置 这里出生时的动画针。
- 知识点：因为记住了那个 针的位置 所以仅靠这种感觉有些不足 在自己这里可以把这些点 再加上 可以成为品牌的点 而且时钟值 用这个扣罗特杯制作 只控制亮度就好。
- 知识点：从0.5的时机开始 自然消失的感觉 那么某种东西移动到那个位置 但 感觉有点少了那种 消失的瞬间 在这里就算是与位置不符的 也可以适当 补偿一下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`颜色`、`曲线`、`噪声`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Curl Noise Force` 参数截图
> - 组成部分: Preview + User Parameters + Niagara Stack + Details + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Particle Update`
> - 目的: 记录在粒子位置变形后追加 Curl Noise 扰动的强度、频率和质量设置。
>
> 模块栈:
> | 组 | 模块/项 | 状态 | 关键设置 |
> |---|---|---|---|
> | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location`、`Skeletal Mesh Location 001`、`Set PARTICLES Position`、`Sample Texture`、`Dissolve`、`Kill Particles` | Enabled | 两个 Skeletal Mesh Location 为 `Triangles / Random` |
> | Particle Update | `Particle State`、`Lerp Particle Attributes`、`Curl Noise Force`、`Solve Forces and Velocity`、`Scale Color` | Enabled | 当前选中 `Curl Noise Force` |
> | Render | `Sprite Renderer` | Enabled | Sprite 输出 |
>
> 参数表:
> | 模块 | 字段 | 值/状态 |
> |---|---|---|
> | `Curl Noise Force` | Noise Strength | `10.0` |
> | `Curl Noise Force` | Noise Frequency | `50.0` |
> | `Curl Noise Force` | Noise Quality / Cost | `Baked (Medium)` |
> | `Curl Noise Force` | Pan Noise Field | `0.0 / 0.0 / 0.0`，当前灰显 |
> | `Curl Noise Force` | Mask Curl Noise | 未勾选 |
>
> 预览状态: Preview 中角色轮廓粒子变得分散，Particle Counts 可读 `3860 Current, 98338 Max (est.) - [Collision] [Active]`；Timeline 播放头约 `0.85`。
> 联动关系: `Curl Noise Force` 位于 `Lerp Particle Attributes` 之后、`Solve Forces and Velocity` 之前，用于给位置变形后的粒子加入噪声扰动。
> 验证方式: 在 `Collision > Particle Update` 选中 `Curl Noise Force`，核对 Noise Strength、Frequency 和 Quality。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + 下方 Niagara窗口残留 + 水印
> - 所属: `07_Fire_Explosion / Morphing Camera Actor / Morph 01`
> - 目的: 在关卡相机视角下检查粒子变形效果的远景可见性。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | 顶部视口栏 | `Pilot Actor: Morphing Camera Actor` | 当前通过 Morphing Camera Actor 查看效果 |
> | Level Viewport | 深红色背景中，角色位于画面上方偏中；身体附近有少量红橙亮点 | 预览位置变形粒子在镜头中的可见状态 |
> | Outliner | `07_Fire_Explosion (Editor)` 下可见 `Morph 01`、`Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath` | 场景对象上下文 |
> | Content Browser | 选中 `MurielSepia SkeletalMesh` 缩略图 | 当前角色资源仍在左侧浏览器中 |
> | 下方窗口 | `Morph_01` 与 `M_AdditiveNoBlur_v01` 标签可见 | Niagara/材质编辑窗口仍打开但只露出底部 |
>
> 联动关系: 前几张图中的 `Skeletal_A/Skeletal_B` 采样和 `Curl Noise Force` 参数调整，会在该关卡镜头中表现为角色附近的零散红橙粒子；本图只记录镜头预览结果，不给出 transform 或距离结论。
> 验证方式: 在关卡中切到 `Morphing Camera Actor` pilot 视角，播放到对应片段，检查角色附近是否出现稀疏红橙粒子。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + 下方 Niagara窗口残留 + 水印
> - 所属: `07_Fire_Explosion / Morphing Camera Actor / Morph 01`
> - 目的: 继续检查角色位置变形粒子在镜头中的亮度和密度。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | 顶部视口栏 | `Pilot Actor: Morphing Camera Actor` | 当前仍是相机 pilot 视角 |
> | Level Viewport | 深红色背景中，角色位于画面上方偏中；身体周围红橙亮点比上一张更集中，主要覆盖上身与躯干附近 | 作为参数调整后的效果预览 |
> | Outliner | `Morph 01`、`Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath` 可见 | 场景对象上下文 |
> | Content Browser | `MurielSepia SkeletalMesh` 缩略图仍被选中 | 当前角色资产上下文 |
> | 下方窗口 | `Morph_01`、`M_AdditiveNoBlur_v01` 标签可见 | 编辑器中仍保留 Niagara/材质窗口 |
>
> 联动关系: 该预览用于判断噪声、颜色和位置插值后的粒子是否在角色轮廓附近形成可见散点；截图不展示具体模块参数，因此参数仍以前几张 Niagara Details 为准。
> 验证方式: 在相同相机视角播放到对应时刻，确认角色附近红橙散点能随角色位置出现并逐渐消散。

### 00:09:43-00:14:38 Color、粒子

- 本段定位：Color、粒子。
- 知识点：这个和这个的概念是相同的 再一次在下面 Colorize或Dredd这个值 之后 再计算一次标准值的感觉 物品 需要删除空间的东西 保存一次后。
- 知识点：现在把这个打开 只有粒子出来的话 有点无聊 如果能在这里加入角色的表演 这种感觉就好了 所以我就把它拿来了 这一部分我也会再设置好 这个只需简单。
- 知识点：使用缩放消息位置 这个需要把我们用A的部分 连接到缩放这个消息上 其他部分好像 其实也不需要太多改动 如果有生命时间或大小之类的 要适当调整的。
- 知识点：其实也不需要改动太多 几乎可以直接用 差别不大 毕竟那时候用了红色调 现在也是这样 只要适当调整消失的品牌 这个对我个人来说 停在这里就行了。
- 知识点：但为了更合理的演出 建议尝试调整这些数值 或生成 在这个程度上简单递纸是为了搭配 或者大概把尺寸增大 现在从翅膀那边 也出来了的东西。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Curl Noise Force` 曲线参数截图
> - 组成部分: Preview + Curves + Niagara Stack + Details + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Curl Noise Force`
> - 目的: 把噪声强度从固定值改成乘法浮点与归一化年龄曲线控制。
>
> 模块/参数:
> | 区域 | 字段 | 值/状态 | 说明 |
> |---|---|---|---|
> | Preview | Particle Counts | `7089 Current, 98338 Max (est.) - [Collision] [Inactive]` | 预览中白色粒子形成较大角色轮廓 |
> | Stack | Particle Update | `Lerp Particle Attributes`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Set PARTICLES Position` | 当前选中 `Curl Noise Force` |
> | Details | Noise Strength | `Multiply Float` | 使用乘法组合强度 |
> | Details | A | `5000.0` | 强度基数 |
> | Details | B | `Float from Curve` | 用曲线调制强度 |
> | Details | FloatCurve | 曲线约从 0 起步，快速升到 1.0 附近，随后逐步回落到 0 | 随生命周期控制噪声强弱 |
> | Details | CurveIndex | `PARTICLES NormalizedA...` | 以粒子归一化年龄驱动 |
> | Details | Scale Curve | `1.0` | 曲线缩放 |
> | Details | Noise Frequency | `15.0` | 噪声频率 |
> | Details | Noise Quality / Cost | `Baked (Medium)` | 噪声质量 |
>
> 联动关系: `Curl Noise Force` 位于 `Lerp Particle Attributes` 后，用 `NormalizedAge` 曲线把噪声从强到弱过渡，配合后续颜色/亮度调整形成自然消散。
> 验证方式: 选中 `Curl Noise Force`，核对 Noise Strength 的 `Multiply Float`、A/B 输入、曲线、Frequency 与 Quality。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Spark_01001 / Scale Color` 参数截图
> - 组成部分: Preview + Niagara Stack + Details + User Parameters + Timeline + 字幕
> - 所属: `Morph_01 / Spark_01001 / Scale Color`
> - 目的: 给附加火焰/亮点发射器设置 RGB 与 Alpha 的独立缩放曲线。
>
> 模块栈:
> | 组 | 模块/项 | 可读状态 |
> |---|---|---|
> | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location`、`Camera Offset` | Enabled |
> | Particle Update | `Particle State`、`Scale Sprite Size`、`Scale Color`、`Solve Forces and Velocity`、`Sub UV Animation Linear` | `Scale Color` 被选中 |
> | Render | `Sprite Renderer` | Enabled |
>
> 参数表:
> | 字段 | 值/状态 | 说明 |
> |---|---|---|
> | Scale Mode | `RGB and Alpha Separately` | RGB 与 Alpha 分开控制 |
> | Scale RGB | 勾选，`Multiply Vector by Float` | RGB 先乘向量再乘曲线 |
> | Vector | `10.0 / 2.0 / 1.0` | 偏红橙的颜色增强 |
> | RGB Float | `Float from Curve` | 曲线随年龄衰减 |
> | RGB CurveIndex | `PARTICLES NormalizedAge` | 用粒子年龄驱动 |
> | RGB Scale Curve | `1.0` | 曲线缩放 |
> | Scale Alpha | 勾选，`Float from Curve` | 透明度随年龄衰减 |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` | 同样使用归一化年龄 |
> | Alpha Scale Curve | `1.0` | 曲线缩放 |
>
> 预览状态: Preview 中可见两团橙白火焰形态和白色散点；Particle Counts 显示 `Collision` 与 `Spark_01001` 同时 Active，其中 `Spark_01001` 为 `4 Current, 20 Max (est.)`。
> 联动关系: `Spark_01001` 负责少量高亮火焰/亮点，`Scale Color` 用红橙向量和衰减曲线控制亮度与消失。
> 验证方式: 选中 `Spark_01001 > Particle Update > Scale Color`，核对 Scale Mode、RGB Vector、NormalizedAge 曲线和 Alpha 曲线。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + 下方 Niagara窗口残留 + 字幕
> - 所属: `07_Fire_Explosion / Morphing Camera Actor / Morph 01`
> - 目的: 检查颜色和噪声调整后，角色周围粒子的亮度与消散观感。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | 顶部视口栏 | `Pilot Actor: Morphing Camera Actor` | 当前使用 Morphing Camera Actor 观察 |
> | Level Viewport | 深红色背景中，角色轮廓处出现密集白橙粒子柱，外侧有红色辉光和少量散点 | 验证粒子亮度和消散形态 |
> | Outliner | `Morph 01`、`Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath` 可见 | 场景对象上下文 |
> | 下方窗口 | `Morph_01`、`M_AdditiveNoBlur_v01` 标签可见 | 表示参数编辑窗口仍打开 |
> | 字幕 | “消失的感觉也好像更好了呢” | 对应当前视觉判断 |
>
> 联动关系: 前两张中 `Curl Noise Force` 和 `Scale Color` 的曲线设置，会在该镜头中表现为更亮、更集中的粒子爆发和衰减；本图只记录预览结果，具体数值以前两张参数图为准。
> 验证方式: 在相同相机视角播放到该时刻，检查角色上方/身体附近是否形成亮白橙粒子柱并逐渐衰减。

### 00:14:38-00:19:15 Material、Sequencer、Mesh

- 本段定位：Material、Sequencer、Mesh。
- 知识点：生成的线不显得尴尬 和它们混在一起 希望有更强烈的感觉 做到内部分后 继续进行并完成 这个粒子先保存资源。
- 知识点：本段围绕 `粒子` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：垂直向下 这个也应该向前抓住 这个spot timing会好一点 现在大概到 一针 将产生设定为一针 而且这个需要附加 这里正在使用的material。
- 知识点：作为隐藏 Chest搜索并发送到这里 让我们进行附加设置 似乎没什么特别要做 现在这样设置 particle部分可以调整了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Particle`、`Material`、`Sequencer`、`材质`、`粒子`、`生命周期`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Level Viewport + Content Browser + Outliner + 下方 Niagara窗口残留 + 字幕
> - 所属: `07_Fire_Explosion / Morphing Camera Actor / Morph 01`
> - 目的: 继续检查强化后的粒子效果是否更有冲击力。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Level Viewport | 角色位于画面上方偏中，身体周围出现高亮白橙粒子团，两侧有轻微扩散，红色辉光包围粒子团 | 检查更强烈的视觉表现 |
> | 顶部视口栏 | `Pilot Actor: Morphing Camera Actor` | 仍在相机 pilot 视角 |
> | Content Browser | 左侧仍选中 `MurielSepia SkeletalMesh` | 角色资源上下文 |
> | Outliner | `07_Fire_Explosion (Editor)` 及相关演员列表可见 | 场景上下文 |
> | 字幕 | “希望有更强烈的感觉” | 对应当前调参目标 |
>
> 联动关系: 当前图是 S03 调整后在关卡相机中的持续预览，用于判断亮度、密度和角色轮廓结合是否达到更强效果。
> 验证方式: 使用 Morphing Camera Actor 视角播放，确认高亮粒子集中在角色附近且背景中有红色辉光。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 触发与附着轨道截图
> - 组成部分: Content Browser + Sequencer轨道列表 + 时间轴片段 + 曲线/关键帧
> - 所属: `07_Fire_Explosion / Sequencer`
> - 目的: 记录 `Morph 01` 与 `Body Trail 01` 在角色动画片段中的触发时机和附着目标。
>
> 轨道/片段:
> | 轨道 | 可读信息 | 作用 |
> |---|---|---|
> | Camera Cuts | `Morphing Camera Actor` 片段覆盖前段，后续切到 `Exp Camera Actor` | 镜头切换上下文 |
> | `Ex_07_Morph_Ctrl_01 / Dissolve` | 当前附近值可见 `-0.1` | 控制第一组 Dissolve 参数 |
> | `Ex_07_Morph_Ctrl_02 / Dissolve` | 当前附近值可见 `0.327178` | 控制第二组 Dissolve 参数 |
> | `Serath / Animation` | `Ultimate_Prepare` 片段 | 原角色动画 |
> | `MurielSepia / Animation` | `Ultimate_Start`、后段 `Ultimate_Start` 与 `Ultimate_Land` | 目标角色动画 |
> | `MurielSepia / Transform / Location` | `X=0.0`、`Y=0.0`、`Z=500.0` 可见 | 角色位置轨道状态 |
> | `Morph 01 / NiagaraComponent0 / FX System` | `Activate` 下拉；`Spawned` 勾选；关键帧位于当前片段附近 | 触发 Morph Niagara |
> | `Body Trail 01 / Attach` | 片段标注 `MurielSepia (Chest)` | 将 Body Trail 附着到 MurielSepia 胸部 |
> | `Body Trail 01 / Spawned` | 勾选，当前附近有关键帧 | 触发 Body Trail |
>
> 时间状态: Sequencer 显示 `0111`，读数 `112 of 181`；播放头在前段镜头末尾附近。
> 联动关系: `Morph 01` 负责位置变形粒子，`Body Trail 01` 作为附着在 `MurielSepia (Chest)` 的额外粒子层，与角色动画和 Dissolve 参数同步。
> 验证方式: 在 Sequencer 中检查 `Morph 01` 与 `Body Trail 01` 的 Spawned/Activate 轨道、Attach 目标和关键帧位置。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `BodyTrail_01 / Initialize Particle` 参数截图
> - 组成部分: Preview + User Parameters + Niagara Stack + Details + Timeline
> - 所属: `BodyTrail_01 / Collision / Initialize Particle`
> - 目的: 记录 Body Trail 粒子的基础生命周期、颜色、位置和 Sprite 尺寸。
>
> 模块/参数:
> | 区域 | 字段 | 值/状态 | 说明 |
> |---|---|---|---|
> | Preview | Particle Counts | `20067 Current, 21668 Max (est.) - [Collision] [Active]` | 预览中白色粒子沿角色轮廓/身体方向分布 |
> | User Parameters | `Skeletal_B` | `Preview Mesh=MurielSepia`；`Source Mode=Default`；`Source Actor=None`；`Skinning Mode=Skin on the Fly`；`Whole Mesh LOD=-1` | BodyTrail 使用 MurielSepia 网格上下文 |
> | Stack | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location` | 当前选中 `Initialize Particle` |
> | Stack | Particle Update | `Particle State`、`Lerp Particle Attributes`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Set PARTICLES Position` | 后续更新模块 |
> | Initialize Particle | Lifetime Mode | `Random` | 随机生命周期模式 |
> | Initialize Particle | Lifetime Min / Max | `2.0 / 2.0` | 实际固定为 2 秒 |
> | Initialize Particle | Color Mode | `Direct Set` | 直接设置颜色 |
> | Initialize Particle | Color | `R=1.0, G=1.0, B=1.0, A=1.0` | 白色不透明初始颜色 |
> | Initialize Particle | Position Mode | `Simulation Position` | 使用模拟位置 |
> | Initialize Particle | Mass Mode | `Unset (Mass of 1)` | 默认质量 |
> | Sprite Attributes | Sprite Size Mode | `Random Non-Uniform` | 非均匀随机尺寸 |
> | Sprite Attributes | Sprite Size Min | `1.0 / 1.0` | 最小尺寸 |
> | Sprite Attributes | Sprite Size Max | `1.5 / 1.5` | 最大尺寸 |
> | Sprite Attributes | Sprite Rotation Mode / Sprite UV Mode | `Unset / Unset` | 未设置旋转和 UV |
>
> 联动关系: Sequencer 将 `Body Trail 01` 附着到 `MurielSepia (Chest)`，本图则给出该 Niagara System 中 Collision 发射器的基础粒子初始化参数。
> 验证方式: 打开 `BodyTrail_01`，选中 `Collision > Particle Spawn > Initialize Particle`，核对 Lifetime、Color、Position Mode 和 Sprite Size。

### 00:19:15-00:24:14 SD、粒子、网格

- 本段定位：SD、粒子、网格。
- 知识点：就可以 删除设置 骨骼网格位置就用 基本设置 并且会解除本地使用 然后交替制 改为随机范围缚点 不是成法缚点 大约300 品率大约20 适中就好。
- 知识点：流出并在周围 消失的感觉会比较好 感觉卡的值会太高 所以适当减少 DARMDRIDER SERVICE AS A KICKNUNCH ARFA。
- 知识点：WORKSHOW DARMWORK ANSES WORKSHOW 需要试着感受一下这种感觉 在移动的同时 身体也会自然产生粒子。
- 知识点：DARMWORKSHOW DARMWORKSHOW 中间的针被切割可能会让人觉得更难确认一些 但DATA PEN DATA PEN DATA。
- 知识点：PEN DATA PEN DATA PEN 不过上身的粒子很好出来。
- 核对对象：`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara `BodyTrail_01 / Initialize Particle` 参数调整截图
> - 组成部分: Preview + User Parameters + Niagara Stack + Details + Timeline + 字幕
> - 所属: `BodyTrail_01 / Collision / Initialize Particle`
> - 目的: 将 BodyTrail 粒子的生命周期缩短，并保持白色小尺寸 Sprite 初始化。
>
> 参数表:
> | 区域 | 字段 | 值/状态 | 作用 |
> |---|---|---|---|
> | Preview | Particle Counts | `7665 Current, 32335 Max (est.) - [Collision] [Inactive]` | 预览中白色粒子沿角色身体轮廓分布 |
> | User Parameters | `Skeletal_B` | `Preview Mesh=MurielSepia`；`Source Mode=Default`；`Source Actor=None`；`Skinning Mode=Skin on the Fly`；`Whole Mesh LOD=-1` | 使用 MurielSepia 作为身体采样语境 |
> | Stack | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location` | 当前选中 `Initialize Particle` |
> | Initialize Particle | Lifetime Mode | `Random` | 随机生命周期 |
> | Initialize Particle | Lifetime Min / Max | `0.6 / 1.2` | 粒子寿命范围 |
> | Initialize Particle | Color Mode / Color | `Direct Set`；`R=1.0, G=1.0, B=1.0, A=1.0` | 初始白色不透明 |
> | Initialize Particle | Position Mode | `Simulation Position` | 使用模拟位置 |
> | Initialize Particle | Mass Mode | `Unset (Mass of 1)` | 默认质量 |
> | Sprite Attributes | Sprite Size Mode | `Random Non-Uniform` | 非均匀随机尺寸 |
> | Sprite Attributes | Sprite Size Min / Max | `1.0/1.0` -> `1.5/1.5` | 小尺寸粒子 |
> | Sprite Attributes | Sprite Rotation Mode / Sprite UV Mode | `Unset / Unset` | 未额外设置 |
> | Timeline | 当前帧 | 约 `6.55`，读数 `1572 of 2400` | 当前预览时间 |
>
> 联动关系: `Skeletal Mesh Location` 提供身体表面采样，`Initialize Particle` 将粒子寿命压到 `0.6-1.2` 秒，配合后续 Update 模块让粒子从身体附近生成并较快消散。
> 验证方式: 打开 `BodyTrail_01`，选中 `Collision > Particle Spawn > Initialize Particle`，核对 Lifetime、Color 与 Sprite Size。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机效果预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Sequencer浮窗 + 字幕
> - 所属: `07_Fire_Explosion / Body Trail 01 / Morph 01`
> - 目的: 检查 BodyTrail 与 Morph 粒子叠加后，角色身体附近的粒子亮度和密度。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Level Viewport | 深红背景中角色被竖向白橙粒子包围，身体轮廓形成高亮粒子柱，底部有橙色火焰状亮点，外侧有零散红色粒子 | 验证身体粒子已明显随角色出现 |
> | Outliner | 可见 `Floor`、`Morph 01`、`Morphing Came...`、`MurielSepia`、`Body Trail 01`、`PlayerStart` 等，合计 `13 actors` | 场景对象上下文 |
> | Sequencer | 浮窗显示约 `0127`，读数 `128 of 226`；Camera Cuts 条带可见 | 当前预览时间 |
> | Content Browser | 左侧仍选中 `MurielSepia SkeletalMesh` | 角色资源上下文 |
> | 字幕 | “这种感觉看一下” | 对应当前预览动作 |
>
> 联动关系: 前一张 `BodyTrail_01` 生命周期与身体采样设置，在本图中表现为角色周围的高亮粒子柱；同时仍与 `Morph 01` 的变形粒子叠加。
> 验证方式: 播放 Sequencer 到 128 帧附近，在相机视角确认角色身体周围存在竖向白橙粒子柱和红色散点。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 时间轴截图
> - 组成部分: Content Browser + Sequencer轨道列表 + Camera Cuts + 动画/参数/Spawn轨道 + 字幕
> - 所属: `07_Fire_Explosion / Sequencer`
> - 目的: 确认 BodyTrail 与 Morph 在角色动画后段的持续触发和相机切换时机。
>
> 轨道/片段:
> | 轨道 | 可读信息 | 作用 |
> |---|---|---|
> | Camera Cuts | 前段 `Morphing Camera Actor`，后段 `Exp Camera Actor`；播放头在 `0151`，读数 `152 of 226` | 镜头切换时间 |
> | `Serath / Animation` | `Ultimate_Prepare` 片段 | 原角色动画段 |
> | `MurielSepia / Animation` | `Ultimate_Start`、后段 `Ultimate_Start` 与 `Ultimate_Land` | 目标角色动画段 |
> | `MurielSepia / Transform / Location` | `X=0.0`、`Y=0.0`、`Z=500.0` 可见，右侧有多组 Location 关键帧 | 角色位置轨道状态 |
> | `Ex_07_Morph_Ctrl_01 / Dissolve` | 当前附近值 `-0.1` | 第一组 Dissolve 参数 |
> | `Ex_07_Morph_Ctrl_02 / Dissolve` | 当前附近值 `0.838322` | 第二组 Dissolve 参数 |
> | `Morph 01 / NiagaraComponent0 / FX System` | 下拉为 `Deactivate`；`Spawned` 勾选 | Morph 粒子系统的激活/停用时机 |
> | `Body Trail 01 / Attach` | 片段标注 `MurielSepia (Chest)` | BodyTrail 附着目标 |
> | `Body Trail 01 / Spawned` | 勾选并有轨道条带 | BodyTrail 触发 |
>
> 联动关系: BodyTrail 通过 Sequencer 附着到 `MurielSepia (Chest)` 并随动画段播放；`Morph 01` 的 FX System 在该时间段进入 Deactivate 语境，说明后续会切换到身体轨迹粒子为主的检查。
> 验证方式: 在 Sequencer 中核对 `Body Trail 01` 的 Attach/Spawned 轨道、`Morph 01` 的 FX System 状态和 Camera Cuts 播放头位置。

### 00:24:14-00:28:49 材质、粒子、发射器

- 本段定位：材质、粒子、发射器。
- 知识点：那现在按照身体出来的粒子们 也很好出来了 好像还有一些小粒子也出来了 好像还有一些小粒子也出来了。
- 知识点：我就把这个全部抛掉 再生成再让它附着在身体上 这些点和出来的点 放进这次的轨迹适当更多一点 放进这次的轨迹适当更多一点 还没有让那些粒子可见。
- 知识点：只放一个感觉的东西 这样做完 用添加发射器 状态设为自我 然后改成圆形 大概给4秒 这个是用生成单元来生成的 设为20 然后关掉最大移动。
- 知识点：我现在要制作一个材质 我先设置好的4代轨迹大式材质 创建一个实例 在这里进行记录 我们正在制作的 摩托车文件夹 这里创建7号文件夹 将制作好的4代实例。
- 知识点：移到这里 所以将这个连接在这里 更改所有纹理 然后现在将继续进行粒子 首先从纹理重新设置一下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`粒子`、`发射器`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡远景效果预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Sequencer浮窗 + 字幕
> - 所属: `07_Fire_Explosion / Morph_01 + BodyTrail_01`
> - 目的: 在切换到灰色棋盘地面视角后，确认身体粒子仍能沿角色轮廓出现。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Content Browser | 搜索 `07`；可见并选中 `Morph_01` Niagara System，旁边有 `BodyTrail_01` Niagara System | 当前粒子资源上下文 |
> | Level Viewport | 灰色棋盘地面上，角色位置处出现竖向粉白粒子柱，底部有较密集亮点，整体比前一段更远景 | 检查身体粒子在新镜头/场景背景中的可见性 |
> | Outliner | `Lighting` 文件夹、`DirectionalLight`、`01_Swing_Trail`、`Exp Camera Act...`、`Floor`、`Morph 01`、`Morphing Came...` 可见 | 场景对象上下文 |
> | Sequencer | 浮窗显示约 `0214`，读数 `215 of 226`；Camera Cuts 后段可见 | 后段相机预览时间 |
> | 字幕 | “那现在按照身体出来的粒子们也很好出来了” | 对应视觉结论 |
>
> 联动关系: `BodyTrail_01` 的身体采样和 Sequencer 触发在后段镜头中仍产生竖向粉白粒子柱，说明粒子从身体区域持续发出。
> 验证方式: 播放到 Sequencer 后段 215 帧附近，在 `Exp Camera Actor` 相关视角确认身体粒子在灰色地面背景上可见。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Empty / Sprite Renderer` 参数截图
> - 组成部分: Preview + Curves + Niagara System Overview + Details + Timeline + Content Browser + 字幕
> - 所属: `BodyTrail_01 / Empty / Sprite Renderer`
> - 目的: 新增或检查一个空发射器的 Sprite Renderer 基础设置，用作后续轨迹材质/渲染层。
>
> 模块清单:
> | 区域 | 模块/项 | 可读信息 | 作用 |
> |---|---|---|---|
> | Preview | 粒子预览 | `Collision` 显示 `9309 Current, 39667 Max (est.) [Active]`；`Empty` 为 `0 Current, 0 Max (est.) [Active]` | 当前 Empty 发射器尚未生成粒子 |
> | System Overview | `Collision` | GPU Stage，含 `Initialize Particle`、`Skeletal Mesh Location`、`Particle State`、`Lerp Particle Attributes`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Set PARTICLES Position`、`Sprite Renderer` | 既有身体粒子层 |
> | System Overview | `Empty` | CPU Stage，含 `Emitter State`、`Spawn Rate`、`Initialize Particle`、`Particle State`、`Sprite Renderer` | 新的空发射器层 |
> | Details | `Empty / Sprite Renderer` | `Material=DefaultSpriteMaterial`；`Material User Param=None`；`Source Mode=Particles`；`Alignment=Automatic`；`Facing Mode=Automatic`；`Macro UVRadius=0.0`；`Default Pivot in UV=0.5 / 0.5`；`Remove HMD Roll` 未勾选；`Pixel Coverage Mode=Automatic`；`Pixel Coverage Blend=1.0`；`Min/Max Facing Camera=0.0/0.0`；`Sort Mode=None`；`Renderer Visibility=0` | 定义空发射器的 Sprite 渲染基础 |
> | Curves | `Scale RGB / Float` 曲线 | 曲线从 1 附近逐步降到 0 | 当前仍显示 Collision 的颜色曲线 |
> | Timeline | 发射器轨道 | `Collision` 与 `Empty` 两条轨道可见，播放头约 `2.89` | 当前 Niagara 预览时间 |
>
> 联动关系: `Empty` 发射器已具备基础 Sprite Renderer，但当前粒子数为 0；后续需通过 Spawn/材质设置让该发射器承担轨迹视觉层。
> 验证方式: 在 `BodyTrail_01` 中选中 `Empty > Render > Sprite Renderer`，核对材质、Source Mode、Alignment/Facing 和 Visibility。
> 图表转写（UE-GTXT v4）
> - 类型: 材质实例参数截图
> - 组成部分: Material Instance Preview + Details/Layer Parameters + Content Browser + 字幕
> - 所属: `M_Ribbon_v01_Ins_01`
> - 目的: 创建并调整轨迹用 Ribbon 材质实例的颜色、透明度、扭曲和纹理参数。
>
> 预览/统计:
> | 区域 | 可读信息 | 作用 |
> |---|---|---|
> | Preview | 深灰背景上显示白灰色不规则烟雾/能量轨迹纹理块 | 检查轨迹材质外观 |
> | Shader Stats | `Base pass shader without light map: 196 instructions`；`Base pass vertex shader: 287 instructions`；`Texture Samplers 5/16`；`Texture Lookups (Est.) VS(3), PS(4)`；`Num shaders added: 56` | 材质编译与采样状态 |
>
> 参数表:
> | 参数组 | 参数 | 值/资源 |
> |---|---|---|
> | Global Scalar Parameter Values | `Black_Bias` | `0.5` |
> | Global Scalar Parameter Values | `Color_Tile_U` | `1.0` |
> | Global Scalar Parameter Values | `Color_Tile_V` | `0.5` |
> | Global Scalar Parameter Values | `Desaturation` | `0.5` |
> | Global Scalar Parameter Values | `Diff_Speed` | `0.1` |
> | Global Scalar Parameter Values | `Edge_Pow` | `1.5` |
> | Global Scalar Parameter Values | `Edge_Str` | `30.0` |
> | Global Scalar Parameter Values | `Normal_Tile_U` | `0.8` |
> | Global Scalar Parameter Values | `Normal_Tile_V` | `0.3` |
> | Global Scalar Parameter Values | `Opacity_Pow` | `1.0` |
> | Global Scalar Parameter Values | `Opacity_Str` | `1.0` |
> | Global Scalar Parameter Values | `Opacity_Tile_U` | `1.0` |
> | Global Static Switch Parameter Values | `Use_Refraction` | 未勾选 |
> | Global Texture Parameter Values | `Color_Tex` | `T_Cloud_Wisp_Chromatic_Tile` |
> | Global Texture Parameter Values | `Distort_Tex` | `T_Voronoi_Cells_02_NRM` |
> | Global Texture Parameter Values | `Opacity_Tex` | `T_Soft_Energy_Trail` |
> | General | `Parent` | `M_Ribbon_v01` |
>
> 联动关系: 该材质实例将云雾颜色纹理、法线/扭曲纹理和透明度纹理组合为 Ribbon/轨迹外观，供后续 Niagara 渲染器替换默认 Sprite 材质使用。
> 验证方式: 打开 `M_Ribbon_v01_Ins_01`，核对 scalar/static switch/texture 参数和 Parent 是否为 `M_Ribbon_v01`。

### 00:28:49-00:33:36 粒子、生命周期

- 本段定位：粒子、生命周期。
- 知识点：整出自己的风格也很好 那么我们来看夹法 保存后再回到粒子 适当再看一下 生命周期设为1秒 只做一个set 大小设为150左右 相机偏移设为150左右。
- 知识点：之后取出一个动态参数 轻微地扭曲 设为0.05开始 最后设为0.1 快速更改到后面设为0.5 然后取出一个 这个在初期只用 约2.2 就是这样。
- 知识点：添加缩放颜色 将效量乘以浮点数 约0.2和0.1 让红色调出线 预览中看不见 是因为这里是动单位 这个现在是附加动画在移动 在确保距离值的同时。
- 知识点：进行生成的模块 现在不出现是对的 并且制作浮动曲线 值大约为10 逐渐减小亮度 这种曲线值 我现在在这里 常常使用类似的形态 可以认为这是一种。
- 知识点：基础形态 在制作个人作品时 不必使用固定的图表 我建议您多尝试各种形式 多加练习才能 捕捉到新感觉 也会打开更广阔的视野 R发是 从2开始 用这种纸。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`粒子`、`生命周期`、`颜色`、`曲线`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质实例参数调整截图
> - 组成部分: Material Instance Preview + Details/Layer Parameters + Content Browser + 字幕
> - 所属: `M_Ribbon_v01_Ins_01`
> - 目的: 调整 Ribbon 轨迹材质的透明度、折射和贴图平铺参数。
>
> 参数表:
> | 参数组 | 参数 | 值/资源 |
> |---|---|---|
> | Global Scalar Parameter Values | `Black_Bias` | `0.5` |
> | Global Scalar Parameter Values | `Color_Tile_U` | `1.0` |
> | Global Scalar Parameter Values | `Color_Tile_V` | `0.5` |
> | Global Scalar Parameter Values | `Desaturation` | `0.5` |
> | Global Scalar Parameter Values | `Diff_Speed` | `0.1` |
> | Global Scalar Parameter Values | `Edge_Pow` | `1.5` |
> | Global Scalar Parameter Values | `Edge_Str` | `30.0` |
> | Global Scalar Parameter Values | `Normal_Tile_U` | `0.8` |
> | Global Scalar Parameter Values | `Normal_Tile_V` | `0.3` |
> | Global Scalar Parameter Values | `Opacity_Pow` | `0.5` |
> | Global Scalar Parameter Values | `Opacity_Str` | `5.0` |
> | Global Scalar Parameter Values | `Opacity_Tile_U` | `0.5` |
> | Global Scalar Parameter Values | `Refraction_Str` | `1.01` |
> | Global Static Switch Parameter Values | `Use_Refraction` | 勾选 |
> | Global Texture Parameter Values | `Color_Tex` | `T_Cloud_Wisp_Chromatic_Tile` |
> | Global Texture Parameter Values | `Distort_Tex` | `T_Voronoi_Cells_02_NRM` |
> | Global Texture Parameter Values | `Opacity_Tex` | `T_Soft_Energy_Trail` |
> | General | `Parent` | `M_Ribbon_v01` |
>
> 预览/统计: Preview 中白灰色轨迹纹理更亮、更大；Shader Stats 仍显示 `Texture Samplers 5/16`、`Texture Lookups (Est.) VS(3), PS(4)`；按钮 `Save Sibling`、`Save Child` 可见。
> 联动关系: 该图调整 Ribbon 材质的透明度强度和平铺，并开启 `Use_Refraction`，为后续 Niagara Empty 发射器替换材质和调颜色做准备。
> 验证方式: 打开 `M_Ribbon_v01_Ins_01`，核对 scalar、static switch、texture 参数和 Parent。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Empty / Scale Color` 基础参数截图
> - 组成部分: Preview + Curves + Niagara Stack + Details + Timeline
> - 所属: `BodyTrail_01 / Empty / Scale Color`
> - 目的: 给 Empty 发射器建立基础颜色缩放模块，初始 RGB 与 Alpha 都保持 1。
>
> 模块/参数:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Preview | Particle Counts | `9724 Current, 10461 Max (est.) - [Collision] [Active]`；`Empty` 显示 `No running preview...` |
> | Empty Stack | Emitter Update | `Emitter State`、`Spawn Per Unit` |
> | Empty Stack | Particle Spawn | `Initialize Particle`、`Camera Offset` |
> | Empty Stack | Particle Update | `Particle State`、`Dynamic Material Parameters`、`Scale Ribbon Width`、`Scale Color` |
> | Empty Stack | Render | `Sprite Renderer` |
> | Details | Scale Mode | `RGB and Alpha Separately` |
> | Details | Scale RGB | 勾选；`1.0 / 1.0 / 1.0` |
> | Details | Scale Alpha | 勾选；`1.0` |
> | Timeline | 播放头 | 约 `6.24`，读数 `1499` 可见 |
>
> 联动关系: `Empty` 发射器已有 `Dynamic Material Parameters`、`Scale Ribbon Width` 与 `Scale Color`，但此时颜色缩放仍为默认白色/不透明，后续截图继续改成曲线和偏红向量。
> 验证方式: 选中 `Empty > Particle Update > Scale Color`，核对 Scale Mode、Scale RGB 和 Scale Alpha。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Empty / Scale Color` 曲线参数截图
> - 组成部分: Preview + Curves + Niagara Stack + Details + Timeline + 字幕
> - 所属: `BodyTrail_01 / Empty / Scale Color`
> - 目的: 用红色偏向向量和年龄曲线控制 Empty 发射器的颜色与透明度。
>
> 参数表:
> | 字段 | 值/状态 | 说明 |
> |---|---|---|
> | Scale Mode | `RGB and Alpha Separately` | RGB 与 Alpha 分开控制 |
> | Scale RGB | 勾选，`Multiply Vector by Float` | RGB 乘以向量与曲线 |
> | RGB Vector | `1.0 / 0.2 / 0.1` | 偏红橙色 |
> | RGB Float | `Float from Curve` | 曲线随 `PARTICLES NormalizedAge` 变化，整体从较高值逐步衰减 |
> | RGB CurveIndex | `PARTICLES NormalizedAge` | 粒子归一化年龄 |
> | RGB Scale Curve | `1.0` | 曲线缩放 |
> | Scale Alpha | 勾选，`Float from Curve` | Alpha 曲线先升到 1，再在后段降到 0 |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` | 粒子归一化年龄 |
> | Alpha Scale Curve | `1.0` | 曲线缩放 |
>
> 预览状态: Particle Counts 显示 `3001 Current, 13002 Max (est.) - [Collision] [Active]`，`Empty` 为 `0 Current, 0 Max (est.) [Active]`；Preview 中角色粒子主体仍来自 Collision。
> 联动关系: 本图为 Empty 发射器准备颜色/透明度曲线；即使 Empty 当前没有可见粒子，参数会在该发射器开始生成时控制红色轨迹的出现和消退。
> 验证方式: 在 `Empty > Scale Color` 中核对 RGB Vector、两个 Float Curve、CurveIndex 和 Alpha 曲线。

### 00:33:36-00:37:31 Ribbon、RBD、粒子

- 本段定位：Ribbon、RBD、粒子。
- 知识点：出来是出来 现在大概是因为这个是 Spray 要换成Ribbon Render 这里适当放错了 换成Ribbon Render Distance。
- 知识点：RbDistance 然后Range适当长一点 应该得按这种方式看 现在感觉出来得有点正常 因为瞬间就出现了 中心只是有点偏离的感觉。
- 知识点：这个就可以把 Duration调到55左右看看 基本的东西都已经 差不多进来了 表现很好 然后这里最后留下的 浆东西 Duration来控制。
- 知识点：在下次进入爆炸效果时 反正看不见 没必要太在意 这次就这样利用 角色Particle Scatter模块生成的每个部分 生成的粒子位置值。
- 知识点：移动到其他角色的位置值 并进行变化的感觉 进行尝试 也许要移动的角色的位置 如果不太耀眼 进行动画的话会更好 这种感觉 无论如何 以这个变化为重点。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Particle`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Sequencer浮窗 + 字幕
> - 所属: `07_Fire_Explosion / Body Trail 01 / Morph 01`
> - 目的: 检查轨迹材质接入前后，当前仍偏 Sprite 外观的粒子表现。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Content Browser | 搜索 `Texture`，可见 `T_Soft_Energy...`、`T_Streak_Soft...`、`T_Voronoi...`、`T_Wave...` 等纹理；其中 `T_Voronoi...` 缩略图被选中 | 纹理资源上下文 |
> | Level Viewport | 深红背景中角色上方有白橙粒子团和几块矩形/片状亮斑，整体更像 Sprite 面片叠加；周围有红色散点 | 说明当前渲染外观仍需改为 Ribbon |
> | Outliner | `Lighting`、`01_Swing_Trail`、`Exp Camera Act...`、`Floor`、`Morph 01`、`Morphing Came...` 可见 | 场景对象上下文 |
> | Sequencer | 浮窗显示约 `0161`，读数 `162 of 226` | 当前预览时间 |
> | 字幕 | “现在大概是因为这个是sprite” | 指出当前外观问题 |
>
> 联动关系: 左侧纹理/材质资源准备和 Empty 发射器设置尚未完全转成 Ribbon 表现，因此视口中仍能看到 Sprite 面片感；后续会调整 Renderer/材质以改善。
> 验证方式: 在该时间点预览，确认角色附近有白橙亮斑和片状 Sprite 外观，再对照后续 Ribbon 调整。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡相机预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Sequencer浮窗 + 字幕
> - 所属: `07_Fire_Explosion / M_Ribbon_v01_Ins_01 / Body Trail 01`
> - 目的: 检查 Ribbon 材质实例接入后，粒子轨迹是否形成更连续的角色周围亮带。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Content Browser | 选中 `M_Ribbon_v01...` Material Instance | 当前材质实例已作为工作对象 |
> | Level Viewport | 深红背景中角色周围形成高亮白橙竖向主体，底部有火焰状轨迹，右侧有一团较连续的亮带/云雾形态，周围有红色粒子散点 | 检查 Ribbon/轨迹表现 |
> | Outliner | `Lighting`、`01_Swing_Trail`、`Body Trail 01`、`Exp Camera Act...`、`Floor`、`Morphing Came...` 可见 | 场景对象上下文 |
> | Sequencer | 显示约 `0101`，读数 `102 of 255`；Camera Cuts 片段覆盖当前播放头 | 当前预览时间 |
> | 字幕 | “基本的东西都已经差不多进来了，表现很好” | 对当前效果的课程判断 |
>
> 联动关系: `M_Ribbon_v01_Ins_01` 的纹理/透明度/颜色参数与 Empty 发射器的颜色曲线共同作用，使角色右侧出现更连续的轨迹亮带。
> 验证方式: 选中材质实例并播放到 102 帧附近，检查角色周围是否出现竖向高亮主体、底部火焰轨迹和右侧连续亮带。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡后段远景预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Sequencer浮窗 + 字幕
> - 所属: `07_Fire_Explosion / Body Trail 01 / Exp Camera Actor`
> - 目的: 在后段灰色地面视角确认粒子收尾状态。
>
> 可见内容:
> | 区域 | 可读/可见信息 | 作用 |
> |---|---|---|
> | Content Browser | 仍选中 `M_Ribbon_v01...` Material Instance | 当前材质上下文 |
> | Level Viewport | 灰色棋盘地面上，角色位于画面下中区域，身体附近只剩少量白粉色亮点和弱红色残光 | 检查粒子后段消退 |
> | Outliner | `Lighting`、`01_Swing_Trail`、`Body Trail 01`、`Exp Camera Act...`、`Floor`、`Morphing Came...` 可见 | 场景对象上下文 |
> | Sequencer | 显示约 `0245`，读数 `245 of 255`；后段 Camera Cut 播放头接近片段末尾 | 收尾时间点 |
> | 字幕 | “剩下的部分下次会继续完成。” | 说明本段教程收尾 |
>
> 联动关系: 前面设置的 BodyTrail/Ribbon 粒子到后段只保留少量残光，作为当前特效在爆炸效果前的收尾状态。
> 验证方式: 播放到 245 帧附近，在灰色地面背景中确认角色附近粒子明显减少并接近结束。

## 补充视觉证据

### S06 00:27:47

> 图表转写（UE-GTXT v4）
> - 类型: 补充材质实例参数截图
> - 组成部分: Material Instance Preview + Details/Layer Parameters + Content Browser
> - 所属: `M_Ribbon_v01_Ins_01`
> - 目的: 补充记录另一组 Ribbon 材质实例参数与替换后的贴图资源。
>
> 参数表:
> | 参数组 | 参数 | 值/资源 |
> |---|---|---|
> | Global Scalar Parameter Values | `Black_Bias` | `1.0` |
> | Global Scalar Parameter Values | `Color_Tile_U` | `2.0` |
> | Global Scalar Parameter Values | `Color_Tile_V` | `0.2` |
> | Global Scalar Parameter Values | `Desaturation` | `0.5` |
> | Global Scalar Parameter Values | `Diff_Speed` | `0.0` |
> | Global Scalar Parameter Values | `Edge_Pow` | `1.0` |
> | Global Scalar Parameter Values | `Edge_Str` | `1.0` |
> | Global Scalar Parameter Values | `Normal_Tile_U` | `0.5` |
> | Global Scalar Parameter Values | `Normal_Tile_V` | `0.5` |
> | Global Scalar Parameter Values | `Opacity_Pow` | `1.0` |
> | Global Scalar Parameter Values | `Opacity_Str` | `1.0` |
> | Global Scalar Parameter Values | `Opacity_Tile_U` | `1.0` |
> | Global Static Switch Parameter Values | `Use_Refraction` | 未勾选 |
> | Global Texture Parameter Values | `Color_Tex` | `T_Cloud_Wisp_Chromatic_Tile` |
> | Global Texture Parameter Values | `Distort_Tex` | `2ndInfectedMapNormal` |
> | Global Texture Parameter Values | `Opacity_Tex` | `line_v06` |
> | General | `Phys Material` | `None` |
> | General | `Parent` | `M_Ribbon_v01` |
>
> 预览/资源: Preview 中只剩较暗、稀疏的白灰轨迹纹理；Content Browser 搜索 `Texture`，可见 `T_Cloud_Wisp` 被选中，周围还有 `Space_02`、`T_backspace`、`T_Beam`、`T_Bubble_Arc`、`T_CloudScape`、`T_OneRadial` 等纹理缩略图。
> 联动关系: 该补充图记录了材质实例的另一组最终可见参数，尤其是 `Distort_Tex` 和 `Opacity_Tex` 资源已从前一组设置切换。
> 验证方式: 打开 `M_Ribbon_v01_Ins_01`，核对 scalar/static switch/texture 参数与 Parent；贴图资源以本截图可读字段为准。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


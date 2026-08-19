# 24-1 制作角色位置变形Niagara粒子特效

# 24-1 制作角色位置变形Niagara粒子特效

## 关键术语

- `Velocity`、`Alpha`、`Multiply`、`Texture`、`Sequencer`、`Skeletal Mesh`、`Mesh`、`材质`、`粒子`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:05-00:04:53 Multiply、Sequencer、粒子

- 本段定位：Multiply、Sequencer、粒子。
- 知识点：您好,我在24讲再次问候您 上次我们简单设置了序列器并且进行了原始设置 那么这次后续会首先进行角色消失的溶解设置 接下来根据溶解进行。
- 知识点：粒子效果和球形效果一次进展 将挂上这个下落的预告片 预计会进行到这一部分 需要快速进行一次工作 因为后续会看这里的部分 所以需要把180针的持续时间移动过来。
- 知识点：我们来试试看 我们需要设置沙漠效果中的水材料的溶解设置吧 打算用相同的方式构成 您可以复制当时用的节点开始 这个材料里创建的功能。
- 知识点：需要拿来使用功能 然后纹理也是之前制作的 需要把那个时候使用的颜色纹理拖过来 接下来唯一不同的是 Artorial参数集合。
- 知识点：想用别的东西 把这五复制一下 我们先用7 在7上是Jazz控制 这个用Wolf控制 再用两个 因为角色有两个 先做一个 取过来打开 Dissolve的用法照用。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`Multiply`、`纹理`、`粒子`、`序列`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 基准截图
> - 组成部分: Content Browser + Sequencer时间轴 + Outliner局部 + Details空状态
> - 所属: `07_Fire_Explosion / Camera Cuts / Serath / MurielSepia`
> - 目的: 在第 24 讲开头确认上节课搭好的变身序列结构，作为后续溶解控制的起点。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `ParagonMuriel / ... / Mesh` | 选中 `MurielSepia` Skeletal Mesh | 保持变身后角色资源上下文 |
> | 中央 Sequencer | Timeline/序列设置 | `07_Fire_Explosion` | 帧率 `30 fps`；播放头在 `0004`，读数 `5 of 255`；`Camera Cuts` 前段为 `Morphing Camera Actor`，后段为 `Exp Camera Actor` | 作为本课继续编辑的序列基准 |
> | Sequencer 轨道 | 相机参数轨道 | `Morphing Camera Actor` 与 `Exp Camera Actor` | 两个相机的 `CameraComponent` 下均可见 `Current Aperture=2.8`、`Current Focal Length=30.0`、`Manual Focus Distance=100000.0`、`Spawned` 勾选、`Transform` 轨道 | 与前后两个 Camera Cut 片段对应 |
> | Sequencer 轨道 | 角色动画与参数轨道 | `Serath` 与 `MurielSepia` | `Serath.Animation` 中有 `Ultimate_Prepare`；`MurielSepia.Animation` 中有 `Ultimate_Start` 和 `Ultimate_Land`；`MurielSepia.Weight=1.0`；`MurielSepia.Transform.Location` 展开，`X=0.0`、`Y=0.0`、`Z=500.0`，后段有粉色关键帧 | 后续溶解和粒子效果会叠加到这个变身序列 |
>
> 联动关系: 当前 Sequencer 已具备双相机段、`Serath` 准备动画、`MurielSepia` 起始/落地动画和位置关键帧；本课后续材质溶解与粒子效果以此序列为触发和预览语境。截图只记录 Sequencer 字段，不解释 Transform 所属完整坐标系。
> 验证方式: 打开 `07_Fire_Explosion` Sequencer，检查第 5 帧附近的 Camera Cut、两条相机参数轨、`Serath` / `MurielSepia` 动画轨和 `MurielSepia.Location` 字段。
> 图表转写（UE-GTXT v4）
> - 类型: 材质函数局部节点截图
> - 组成部分: Content Browser + 材质函数预览 + 材质函数节点图 + Details属性图 + 字幕
> - 所属: `MF_CharacterEffects / Material Graph`
> - 目的: 从已有材质函数中复用角色溶解相关节点和纹理输入。
>
> 节点清单:
> | ID | 节点 | 可读 Pin / 字段 | 角色 |
> |---|---|---|---|
> | N01 | `Texture Sample` | 输出 `RGB`、`R`、`G`、`B`、`A`、`RGBA`；输入 `UVs`；预览为灰白噪声纹理 | 提供溶解/遮罩纹理采样 |
> | N02 | `MF_Death_01` | 输入 `Input Mask (S)`、`Input Texture (S)`；输出 `Result` | 封装死亡/溶解函数逻辑 |
> | N03 | `MaterialExpressionFunctionOutput_0` / 函数输出 | 右上可见输出属性列表，含 `EmissiveColor`、`Opacity`、`OpacityMask`、`Normal`、`WorldPositionOffset`、`CustomData`、`PixelDepthOffset`、`ShadingModel`、`Displacement` 等 | 材质函数最终输出端 |
>
> 连线覆盖检查:
> | From | To | 说明 |
> |---|---|---|
> | `Texture Sample` 的可见输出线 | `MF_Death_01` 的输入区域 | 截图能确认纹理采样参与 `MF_Death_01`，但具体接入 `Input Mask` 还是 `Input Texture` 的端点在当前缩放下不完全清晰 |
> | `MF_Death_01.Result` | 后续输出链 | 右侧输出端附近可见节点，但完整端点被画面裁切和缩放影响，需在编辑器中放大复核 |
>
> 设置:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `MF_CharacterEffects.Preview Blend Mode` | `Opaque` | Details | 当前材质函数预览混合模式 |
> | `MF_CharacterEffects.Primitive Type` | `TPT Sphere` | Details | 使用球体预览材质函数输出 |
>
> 联动关系: Content Browser 中的材质/参数资源提供复用来源，`Texture Sample` 与 `MF_Death_01` 是本图可读的溶解函数核心节点；函数输出端显示该函数会输出多项材质属性。本图无法完整读清所有连线端点，复建完整函数时需在 UE 内放大 `MF_CharacterEffects` 图表核对。
> 验证方式: 打开 `MF_CharacterEffects` 材质函数，在 `Material Graph` 中搜索 `MF_Death_01` 和 `Texture Sample`，放大核对 `Input Mask`、`Input Texture` 与输出端的完整连接。
> 图表转写（UE-GTXT v4）
> - 类型: Material Parameter Collection 设置截图
> - 组成部分: Content Browser + 资产编辑器 Details + Outliner/Details背景
> - 所属: `Ex_07_Morph_Ctrl_02`
> - 目的: 为第二个角色准备独立的溶解控制参数集合。
>
> 设置:
> | Owner.Property | 值 | 类型 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Ex_07_Morph_Ctrl_02.Asset Type` | `MaterialParameterCollection` | asset | 顶部标签 | 当前打开的是材质参数集合 |
> | `Scalar Parameters[0].Parameter Name` | `Dissolve` | scalar parameter name | Details | Sequencer/材质读取的溶解控制参数名 |
> | `Scalar Parameters[0].Default Value` | `0.0` | scalar | Details | 溶解参数默认值 |
> | `Vector Parameters` | `0 Array element` | array | Details | 当前集合未添加 Vector 参数 |
>
> 联动关系: `Ex_07_Morph_Ctrl_02` 只包含一个 Scalar 参数 `Dissolve`，与上下文中“角色有两个，先做一个”和后续 Sequencer 参数轨道对应；该集合用于把 Sequencer 关键帧值传给材质函数或材质实例中的溶解逻辑。
> 验证方式: 打开 `Ex_07_Morph_Ctrl_02`，检查 `Scalar Parameters` 中只有 `Dissolve`，默认值为 `0.0`，并确认没有 Vector 参数。

### 00:04:53-00:09:37 颜色

- 本段定位：颜色。
- 知识点：这个现在是 打开AMI的本体 这里也有角色效果控制 同样因此 我们现在看到的这里设置 这个将复制带走 然后这里连接M25颜色。
- 知识点：并连接过度遮障 在这里创建了两个控制 放入2号控制 这个将保存为2号控制 这样就会准备好 在这里因为有点复杂 从这里开始应该先改为盟版。
- 知识点：现在正在应用中 现在正在应用中 但这里参数先加上 首先取来1号 放在Series下面 这个帧是从30帧到1 1帧设置 从30帧开始 然后取来这个纸。
- 知识点：最开始将一直开始 一帧 -0.05 -0.1来做 输入这一部分是 打开标签 这两个部分是 改成迷你 这里也可以更改 也可以不打开 保存一次 正在输了。
- 知识点：现在动画没动 好像有问题 这里的subtract部分没连接 所以这两项都重新保存 这一部分可能会有些噪音 请多多谅解 显卡拿着一次 不过现在这个问题要解决了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质函数亮度调节节点截图
> - 组成部分: 材质函数预览 + 材质函数节点图 + Details属性图 + 角色材质槽背景 + 字幕
> - 所属: `MF_CharacterEffects / Material Graph`
> - 目的: 在角色材质效果函数中增加亮度调节输入，让角色效果可通过标量控制。
>
> 节点清单:
> | ID | 节点 | 可读 Pin / 字段 | 角色 |
> |---|---|---|---|
> | N01 | `Input BrightnessModulation (Scalar)` | 输出标量，预览色块为红色 | 向亮度调节函数提供控制值 |
> | N02 | `MF_BrightnessAdjust` | 输入 `material (MA)`、`BrightnessModulation (S)`；输出 `Result` | 调整材质属性亮度 |
> | N03 | `Output Result` | 输入接收 `MF_BrightnessAdjust.Result`，右侧为函数输出 | 输出调整后的材质函数结果 |
>
> 连线覆盖检查:
> | From | To | 说明 |
> |---|---|---|
> | 上游材质属性线 | `MF_BrightnessAdjust.material (MA)` | 左侧进入 N02 的白色连线提供原始材质属性 |
> | `Input BrightnessModulation (Scalar)` | `MF_BrightnessAdjust.BrightnessModulation (S)` | 亮度标量驱动 N02 调节输入 |
> | `MF_BrightnessAdjust.Result` | `Output Result` 输入 | 调节后的结果写入函数输出 |
>
> 联动关系: `MF_BrightnessAdjust` 位于材质函数输出前，接收上游材质属性和新的 `BrightnessModulation` 标量；右侧背景 Details 中可见 `MurielSepia` 的多个材质槽，说明该函数会服务于角色材质效果控制。字幕“打开 mi 的本体，这里也有角色效果控制”对应从材质实例/本体进入函数编辑。
> 验证方式: 在 `MF_CharacterEffects` 中查找 `Input BrightnessModulation (Scalar)` 与 `MF_BrightnessAdjust`，确认标量输入连接到 `BrightnessModulation (S)`，上游材质属性连接到 `material (MA)`，`Result` 连接到 `Output Result`。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 参数关键帧截图
> - 组成部分: Content Browser + Sequencer时间轴 + Outliner局部 + 字幕
> - 所属: `07_Fire_Explosion / Ex_07_Morph_Ctrl_01`
> - 目的: 在 Sequencer 中给第一个溶解控制集合添加 `Dissolve` 参数轨道和关键帧。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `Coloso_Tutorial / Tutor / Material` | 选中 `Ex_07_...` Material Parameter Collection；旁边可见 `Ex_05_...`、另一个 `Ex_07_...`、`M_Decal_01`、`M_SpiralUV`、`M_Sword...` 等资源 | 当前选择的是第 7 示例的参数集合资源 |
> | 中央 Sequencer | Timeline/序列设置 | `07_Fire_Explosion*` | 帧率 `30 fps`；播放头在 `0111`，读数 `112 of 181`；`Camera Cuts` 前段为 `Morphing Camera Actor`，后段为 `Exp Camera Actor` | 序列时长已显示为 181 帧范围 |
> | Sequencer 参数轨 | `Ex_07_Morph_Ctrl_01 / Dissolve` | `Dissolve` 当前值显示 `1.0`；轨道上可见一个蓝色关键帧点，位置在约 30 帧之后 | 用 Sequencer 驱动材质参数集合的溶解值 |
> | Sequencer 角色轨 | `Serath` 与 `MurielSepia` | `Serath.Animation=Ultimate_Prepare`；`MurielSepia.Animation=Ultimate_Start` 与 `Ultimate_Land`；`MurielSepia.Weight=1.0`；`Location` 展开且 `X=0.0`、`Y=0.0`、`Z=500.0` | 溶解控制与角色动画/位置变化同步 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “负0.05” | 字幕提示正在输入/调试较小负值，但画面轨道当前读数为 `1.0`，以 UI 读数记录当前状态 |
>
> 联动关系: `Ex_07_Morph_Ctrl_01.Dissolve` 作为 Sequencer 参数轨道，与 `Serath` 和 `MurielSepia` 的动画轨并列，承担角色消失/生成溶解值驱动；播放头在 112/181 帧用于检查中段状态。
> 验证方式: 在 `07_Fire_Explosion` Sequencer 中添加/展开 `Ex_07_Morph_Ctrl_01`，核对 `Dissolve` 参数轨道当前值、关键帧位置和与角色动画轨的时间关系。
> 图表转写（UE-GTXT v4）
> - 类型: 材质函数溶解链路截图
> - 组成部分: 材质函数预览 + 材质函数节点图 + Details属性图
> - 所属: `MF_CharacterEffects / Material Graph`
> - 目的: 排查角色溶解函数中 `Dissolve`、纹理采样、`Subtract`、`Multiply` 与亮度调节输入的连接。
>
> 节点清单:
> | ID | 节点 | 可读 Pin / 字段 | 角色 |
> |---|---|---|---|
> | N01 | `Material Attributes` 输入/拆分节点 | 可读属性 Pin 包括 `BaseColor`、`Metallic`、`Specular`、`Roughness`、`EmissiveColor`、`Opacity`、`OpacityMask`、`Normal`、`Tangent`、`WorldPositionOffset`、`SubsurfaceColor`、`ClearCoat`、`CustomData`、`PixelDepthOffset`、`ShadingModel`、`Displacement` 等 | 提供原始材质属性并向输出属性传递 |
> | N02 | `Input BrightnessModulation (Scalar)` | 预览红色；默认值旁可读 `1.25` | 驱动右侧亮度调节链 |
> | N03 | `BrightnessAdjust` / `MF_BrightnessAdjust` | 输入来自 N02，输出继续到右上方链路 | 亮度调节 |
> | N04 | `Dissolve` | 读取 `Ex_07_Morph_Ctrl_...` 的 `Dissolve` 参数，作为标量输入 | Sequencer 参数集合的溶解值来源 |
> | N05 | `Texture Sample` | 灰白噪声纹理采样，输出含 `RGB/R/G/B/A/RGBA` | 溶解遮罩/纹理来源 |
> | N06 | `MF_Death_01` | 输入 `Input Mask (S)`、`Input Texture (S)`；输出 `Result` | 封装死亡/溶解计算 |
> | N07 | `Constant3Vector` | 可读向量近似为 `(30.0, 2.0, 1.0)` | 参与后续数学处理 |
> | N08 | `Subtract` | 输入 `A/B`，输出参与后续链 | 差值处理 |
> | N09 | `Multiply` | 输入 `A/B`，输出向输出属性链路连接 | 乘法处理 |
>
> 连线覆盖检查:
> | From | To | 说明 |
> |---|---|---|
> | N01 多个材质属性输出 | 右侧输出属性节点同名输入 | 大量属性直通或继续传递，能看到多条平行连线 |
> | N02 输出 | N03 亮度调节输入 | 红色标量输入连接到亮度调节节点 |
> | N04 `Dissolve` 与 N05 `Texture Sample` | N06 `MF_Death_01` 输入区 | 两者都参与 `MF_Death_01`，但当前缩放下具体端点需放大复核 |
> | N06 `Result`、N07、N08、N09 | 输出属性链路 | 可见这些节点共同参与溶解/遮罩计算；局部线条重叠，完整端点需在 UE 内核对 |
>
> 联动关系: `Dissolve` 参数集合值与噪声纹理进入 `MF_Death_01`，再通过 `Subtract` / `Multiply` 等节点影响材质输出链；`BrightnessModulation` 作为另一条标量控制链接入亮度调节。此图可确认溶解链路的关键节点集合，但不适合作为完整复建依据，需在编辑器中放大检查所有端点。
> 验证方式: 在 `MF_CharacterEffects` 中分别搜索 `Dissolve`、`MF_Death_01`、`Subtract`、`Multiply`、`BrightnessAdjust`，逐条从输出 Pin 追到输入 Pin，确认 `Opacity` / `OpacityMask` 等最终输出属性的实际来源。

### 00:09:37-00:14:14 关键流程 03

- 本段定位：关键流程 03。
- 知识点：顺序变了 要在更广泛的领域中 去掉这个 需要尝验证效果出金 谢谢 不过还是不行呢 这里写着-1呢 换成1号 是的是的 那现在运作正常了 那么这个问题好像找到了。
- 知识点：两者都调好了 这里输入了 关于现在使用的不会消失的 只需要更改为遮掉 这部分也可能需要一点时间 因为是简单工作 这样做之后 对于不会消失的东西。
- 知识点：可以适当试试 需要快速应用一下 这种NRA的情况下 可以更改 在巨大模式中 这一部分可能残留美 看起来不是很显眼的元素 所以我就不管它了 然后这里。
- 知识点：这个角色也先添加控制器 拖动过来放在底部 接下来这种情况应该是反向的 反过来要有生成的时机 所以这个从60帧开始 从-0.1开始 成为L值。
- 知识点：从-7到-180成为L值 之前关键帧变化的 自动放入这个值 这里似乎发生了变化 你要好好确认这些 现在要把这个变化放在前几个帧。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质函数溶解修正局部截图
> - 组成部分: Content Browser + 材质函数预览 + 材质函数节点图 + Details属性图
> - 所属: `MF_CharacterEffects / Material Graph`
> - 目的: 核对 `MF_Death_01`、`Subtract`、`Multiply` 与 `Add(0.05)` 的溶解链路，修正角色溶解不生效的问题。
>
> 节点清单:
> | ID | 节点 | 可读 Pin / 字段 | 角色 |
> |---|---|---|---|
> | N01 | `MF_Death_01` | 输入 `Input Mask (S)`、`Input Texture (S)`；输出 `Result` | 上方溶解函数实例 |
> | N02 | `Subtract` | 输入 `A/B`，输出连到后续 `Multiply` | 差值处理 |
> | N03 | `Multiply` | 输入 `A/B`，输出继续到右侧输出链 | 强度/遮罩乘法处理 |
> | N04 | `Constant3Vector` | 值为 `X=30.0`、`Y=2.0`、`Z=1.0`，预览为白色 | 作为颜色/强度向量输入 |
> | N05 | `Add(0,0.05)` | 输入 `A` 与常量 `B=0.05`，输出连接到下方函数输入 | 给溶解值增加偏移 |
> | N06 | `MF_Death_01` | 输入 `Input Mask`、`Input Texture`；输出 `Result` | 下方第二个溶解函数实例 |
>
> 连线覆盖检查:
> | From | To | 说明 |
> |---|---|---|
> | N01.`Result` | N02 输入区 | 上方 `MF_Death_01` 输出进入 `Subtract`，端点区域可见 |
> | N02 输出 | N03 输入 | `Subtract` 结果进入 `Multiply` |
> | N04 输出 | N03 输入 | `(30,2,1)` 向量参与 `Multiply` |
> | N05 输出 | N06 输入区 | `Add(0,0.05)` 参与下方 `MF_Death_01` 输入 |
> | N06.`Result` | 右侧输出链 | 下方函数结果连接到右侧，但完整目标端点被画面裁切和水印遮挡，需在 UE 内放大复核 |
>
> 预览结果: 材质球预览中出现红色发光边缘和大块白色遮罩区域，表示当前溶解/遮罩链路正在影响材质函数输出。
> 联动关系: 上下两个 `MF_Death_01` 共同参与溶解遮罩，`Subtract` 与 `Multiply` 对结果做差值和强度处理，`Add(0,0.05)` 为第二条函数输入提供偏移。当前图能确认修正方向，但右侧最终输出端点仍需放大核对。
> 验证方式: 在 `MF_CharacterEffects` 中定位这组节点，逐条检查 `MF_Death_01.Result -> Subtract -> Multiply` 和 `Add(0,0.05) -> MF_Death_01` 的连接，并核对最终是否接入目标材质属性。
> 图表转写（UE-GTXT v4）
> - 类型: 角色材质应用与保存截图
> - 组成部分: Material Editor + 保存进度弹窗 + Level Viewport + Outliner + Details属性图
> - 所属: `M_Serath_Head / Serath`
> - 目的: 将角色材质改为 Masked 并保存，保证 `Serath` 消失材质能应用到角色材质槽。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 Material Editor | 材质图/属性图 | `M_Serath_Head` | 标签为 `M_Serath_Head > Material Graph`；节点图可见 `MF_CharacterEffects` 连接到 `M_Serath_Head.Material Attributes`；弹窗显示 `Saving asset /Game/ParagonSerath/Characters/Heroes/Serath/Materials/M_Serath_Head`，进度 `52%` | 表明正在保存 Serath 头部材质 |
> | 左下 Details | 材质设置图 | `M_Serath_Head` | `Material Domain=Surface`；`Blend Mode=Masked`；`Shading Model=Subsurface Profile` | 对应上下文“将混合模式改为 Mask 模式” |
> | 左侧材质预览 | 材质球预览 | `M_Serath_Head` | 预览球整体偏暗蓝紫 | 用于验证材质设置已在预览中生效 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 当前选中 `Serath`，同列表可见 `Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`SkyAtmosphere`、`SpotLight` | 与右侧 Details 对应 |
> | 右侧 Details | 属性图 | `Serath (Instance)` | `Skeletal Mesh Asset=Serath`；材质槽可见 `M_Serath_HeadShould...`、`M_Serath_ChestThigh`、`M_Serath_Head...`、`M_Serath_RP1_Holy_F...` 等 | 说明正在为 Serath 多个材质槽应用/保存相关材质 |
>
> 联动关系: `MF_CharacterEffects` 函数输出连接到 `M_Serath_Head.Material Attributes`，材质设置改为 `Blend Mode=Masked` 后保存到 `Serath` 资源路径；右侧 `Serath` 实例材质槽用于确认该材质属于当前角色。截图只记录材质设置和保存状态，不推断隐藏材质节点。
> 验证方式: 打开 `M_Serath_Head`，检查 `Blend Mode=Masked`、`Shading Model=Subsurface Profile`，确认 `MF_CharacterEffects.Result` 连接到材质主输出，并保存资产后在 `Serath` 实例材质槽中核对应用情况。
> 图表转写（UE-GTXT v4）
> - 类型: 双 Dissolve Sequencer 参数截图
> - 组成部分: Content Browser + Sequencer时间轴 + 字幕
> - 所属: `07_Fire_Explosion / Ex_07_Morph_Ctrl_01 / Ex_07_Morph_Ctrl_02`
> - 目的: 在 Sequencer 中同时检查两个角色的溶解控制参数，确认关键帧和值的变化。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 中央 Sequencer | Timeline/序列设置 | `07_Fire_Explosion*` | 帧率 `30 fps`；播放头在 `0128`，读数 `129 of 181`；`Camera Cuts` 前段 `Morphing Camera Actor`，后段 `Exp Camera Actor` | 当前检查发生在 181 帧序列中段 |
> | Sequencer 参数轨 | `Ex_07_Morph_Ctrl_01 / Dissolve` | 当前值 `-0.1`；可见两个绿色关键帧，约在 `0030` 和 `0090` 附近 | 控制第一个角色的消失/遮罩变化 |
> | Sequencer 参数轨 | `Ex_07_Morph_Ctrl_02 / Dissolve` | 当前值约 `0.659948`；可见一个蓝色关键帧约在 `0060` 附近，一个红色关键帧约在 `0180` 附近 | 控制第二个角色的反向生成/溶解变化 |
> | Sequencer 角色轨 | `Serath` 与 `MurielSepia` | `Serath.Animation=Ultimate_Prepare`；`MurielSepia.Animation=Ultimate_Start` 与 `Ultimate_Land`；`MurielSepia.Weight=1.0`；`Location.X=0.0`、`Y=0.0`、`Z=500.0` | 两个 Dissolve 控制轨与角色动画和位置轨同步 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “你要好好确认这些” | 对应检查多个参数关键帧 |
>
> 联动关系: `Ex_07_Morph_Ctrl_01.Dissolve` 与 `Ex_07_Morph_Ctrl_02.Dissolve` 分别驱动两个角色的消失/生成参数，二者与 `Serath`、`MurielSepia` 的动画轨道并列，用于形成变身时一个角色消失、另一个角色出现的时序。
> 验证方式: 在 `07_Fire_Explosion` Sequencer 中展开两个 Material Parameter Collection 轨道，核对 `Dissolve` 当前值、关键帧颜色/位置和角色动画轨的时间关系。

### 00:14:14-00:18:47 材质、发射器

- 本段定位：材质、发射器。
- 知识点：要再换成 踩着应用的 将混合模式改为Mask模式 这里消失的就是这里 这里打开的窗口 就是现在您看到的 和适当不同 中间我那个引擎一丝崩溃了。
- 知识点：再次启动了 大概就这样吧 这件事您不必担心 Series直到今次的黄油饮料都关闭 您只需查看这一部分 不消失的人们 Mii做的 所以还是挺容易适用的。
- 知识点：而且似乎没有很多 Salas是非常种类使用的 材料很多 材料的这已经做到了 直到头盔 现在完全好像应用好了 消失的反面就是 现在这个木里尔这个角色。
- 知识点：是生成的感觉 角色消除相关的设置似乎都完成了 最后有点短 看起来像动画的感觉 这些材料可以全都关掉了 现在优先要做的是 现在要放入Particle。
- 知识点：我们把第五个的Dust复制过来 然后书写使用 将放入第七个 在七个里单贴放入 内名为Wolf 打开对应资源关掉 这样出现的 还有 第二个和第三个发射器。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`材质`、`发射器`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 角色消失/生成预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details属性图 + Sequencer时间轴
> - 所属: `07_Fire_Explosion / MurielSepia`
> - 目的: 预览角色溶解和变身生成效果，并检查 `MurielSepia` 材质槽。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `Coloso_Tutorial / Tutor / Material` | 选中一个 `Ex_07_...` Material Parameter Collection；下方可见 `M_Decal_01`、`M_SpiralUV`、`M_SwordTrail_...` 等材质资源 | 表明当前仍在材质/参数资源上下文 |
> | 中央 Viewport | 效果/场景状态图 | `MurielSepia` 与 `Serath` | 上方黑金角色被选中并有黄色轮廓；下方白色角色出现红色发光/溶解边缘；相机、灯光图标和暗色背景可见 | 用于检查一个角色消失、另一个角色生成的视觉状态 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 当前选中 `MurielSepia`，同列表可见 `Morphing Came...`、`PlayerStart`、`PostProcessVo...`、`Serath`、`SkyAtmosphere`、`SpotLight` | 与 Details 的 `MurielSepia` 实例对应 |
> | 右侧 Details | 属性图 | `MurielSepia (Instance)` | `Skeletal Mesh Asset=MurielSepia`；材质槽可见 `MI_Muriel_UpperBody`、`MI_Muriel_Wings`、`MI_Muriel_ArmsLegs`、`MI_Muriel_Eye_Coppe...`、`MI_Muriel_Eye_Occ...`、`MI_Muriel_Mouth...` 等 | 确认生成角色使用多组材质实例 |
> | 底部 Sequencer | Timeline/序列上下文 | `07_Fire_Explosion*` | 播放头在 `0076`，读数 `77 of 181`；`Camera Cuts` 前段 `Morphing Camera Actor`，后段 `Exp Camera Actor` | 预览发生在变身前段 |
>
> 联动关系: Sequencer 播放头在第 77 帧，Viewport 同时显示被选中的 `MurielSepia` 和正在带红色溶解边缘的另一角色，右侧材质槽确认该预览与 `MurielSepia` 的材质实例应用有关。本文只记录可见角色状态和材质槽，不用截图推断材质内部参数。
> 验证方式: 播放 `07_Fire_Explosion` 到第 77 帧附近，选中 `MurielSepia`，检查 Viewport 中两角色的消失/生成状态，并核对 Details 的 Skeletal Mesh 与材质槽列表。
> 图表转写（UE-GTXT v4）
> - 类型: 角色材质完成状态截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details属性图 + Sequencer时间轴 + 字幕
> - 所属: `07_Fire_Explosion / MurielSepia`
> - 目的: 确认角色消除相关材质设置已基本完成，并检查 `MurielSepia` 后续材质槽。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `Coloso_Tutorial / Tutor / Material` | 选中 `Ex_07_Morph_...` Material Parameter Collection；可见 `M_Decal_01`、`M_SpiralUV`、`M_SwordTrail...` | 仍在第 7 示例材质/参数集合资源下 |
> | 中央 Viewport | 效果/场景状态图 | `MurielSepia` | 黑金角色被选中并有黄色轮廓，位于暗色背景中；相机/灯光图标可见 | 用于查看 `MurielSepia` 材质应用后的角色状态 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 当前选中 `MurielSepia`，同列表可见 `Morphing Came...`、`PlayerStart`、`PostProcessVo...`、`Serath`、`SkyAtmosphere` | 对应 Details 中材质槽 |
> | 右侧 Details | 属性图 | `MurielSepia (Instance)` | 材质槽下半部可见 `Element 4` 到 `Element 9`：`MI_Muriel_Mouth`、`MI_Muriel_Face_Copp...`、`MI_Muriel_Helmet_Co...`、`MI_Muriel_TearLine...`、`MI_Muriel_Eyelashes` 等；下方 `Simulate Physics` 未勾选，X 字段可见 `0.01` | 说明多个 Muriel 材质实例已配置到角色上 |
> | 底部 Sequencer | Timeline/序列上下文 | `07_Fire_Explosion*` | 播放头在 `0169`，读数 `170 of 181`；`Camera Cuts` 前段和后段缩略图可见 | 在序列后段检查材质完成状态 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “角色消除相关的设置似乎都完成了。” | 对应本图的阶段性检查 |
>
> 联动关系: `MurielSepia` 的多组材质槽已经填入角色材质实例，Viewport 用于确认角色在序列后段的可见状态；字幕说明角色消除相关设置完成，下一步转入 Particle/Emitter 准备。
> 验证方式: 选中 `MurielSepia`，检查 Details 中 `Element 4-9` 的材质实例名称，并播放到第 170 帧附近确认角色显示状态。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System 发射器与 Scale Color 截图
> - 组成部分: Content Browser + Niagara Preview + Niagara System Overview + Details属性图 + Timeline + 字幕
> - 所属: `Morph_01 / Collision`
> - 目的: 从复制来的 Dust/粒子系统开始，检查 `Collision` 发射器和常用 Spark 感的 `Scale Color` 参数。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `Coloso_Tutorial / Tutor / Particle / 07` | 选中 `Morph_01` Niagara System | 当前打开第 7 示例粒子系统 |
> | 左侧 Preview | Niagara 预览 | `Morph_01` | 暗色预览中有角色轮廓状的粉白粒子点，形成上半身、手臂和下半身碎点 | 用于预览角色形状粒子外观 |
> | 中央 System Overview | Niagara Stack | `Morph_01 / Collision` | `Collision` 发射器启用；GPU 标记可见；组包含 `Properties`、`Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Particle Spawn`、`Particle Update`、`Render`；可读模块有 `Emitter State (Self Once)`、`Spawn Rate`、`Initialize Particle`、`Skeletal Mesh Location`、`Sample Texture`、`Dissolve`、`Kill Particles`、`Particle State`、`Scale Color`、`Gravity Force`、`Collision`、`Solve Forces and Velocity`、`Sprite Renderer` | 当前选中 `Scale Color`，右侧 Details 显示其参数 |
> | 中央 System Overview | Niagara Stack | `Morph_01 / Spark_01` | 右侧另一个发射器 `Spark_01` 半透明可见，结构与 `Collision` 类似 | 表明系统中还有第二个 Spark 风格发射器 |
> | 右侧 Details | 属性图 | `Collision.Scale Color` | `Scale Mode=RGB and Alpha Separately`；`Scale RGB` 勾选，模式 `Multiply Vector by Float`；`Vector=(10.0, 2.0, 1.0)`；`Float=1.0`；`Scale Alpha` 勾选，值 `2.0` | 控制粒子颜色和 Alpha 强度 |
> | 底部 Timeline | Timeline | `Collision` | 时间轴播放头约 `3.94`，帧率显示 `240 fps`；`Collision` 片段为蓝色，后方还有绿色片段 | 用于预览粒子生命周期段 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “然后材质是我们常用的Spark感觉” | 对应使用 Spark 风格粒子材质/色彩 |
>
> 联动关系: `Morph_01` 系统使用 `Collision` 发射器生成角色轮廓粒子，`Skeletal Mesh Location` 和 `Sample Texture` 表示粒子来源与角色网格/纹理采样有关；当前选中的 `Scale Color` 用 `(10,2,1)` RGB 倍增和 `Alpha=2.0` 增强粉白 Spark 感，Preview 用于验证粒子形状和亮度。
> 验证方式: 打开 `Morph_01` Niagara System，选中 `Collision` 发射器的 `Scale Color`，核对 Stack 模块顺序、`Scale Mode`、RGB Vector/Float 和 Alpha 数值，并观察 Preview 中角色轮廓粒子是否随颜色/Alpha 调整变化。

### 00:18:47-00:23:13 Sequencer、粒子、网格

- 本段定位：Sequencer、粒子、网格。
- 知识点：执行A Tape Numer 将这个Particle现在设置在 在序列器中看会更方便 与其他的相同 这个是现在 拖过来 相机就先放 双击相机在30帧上进行。
- 知识点：变为30帧 在后半部分大约180 150帧 不再深入 在三个组件上添加FX切换轨道 在150帧之后 去做 Molf大概只需要这个设置。
- 知识点：播放时 现在需要检查 粒子设置是否正确 在这个样本纹理中 就像是溶解消失的感觉 应该可以照常利用 该做 因此 可以进行用户参数中。
- 知识点：缩放磁砖 网格参数 大约两个 会带过去 通过猪命名第一项 只是缩放磁砖 网格 跟着那个设置 再制作一个代为B 所以在这里将连接 Synet 那么就来调整粒子设置吧。
- 知识点：从现在开始 选择设置为大约2秒 速率暂时设为50 生命周期也同样设为2秒 大小设置为 非均匀暂定为1.5 接下来将连接使用的谷歌网 不翻 这样连接。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Particle`、`Sequencer`、`纹理`、`粒子`、`序列`、`生命周期`、`用户参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Sprite Renderer 设置截图
> - 组成部分: Content Browser + Niagara Preview + Niagara System Overview + Renderer属性图 + Timeline
> - 所属: `Morph_01 / Collision / Sprite Renderer`
> - 目的: 检查 `Collision` 发射器的 Sprite 渲染材质和渲染基础设置。
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | System | `Morph_01` | Enabled | `User Parameters`、`System Spawn`、`System Update` 可见 | 系统级入口 |
> | 2 | Emitter | `Collision` | Enabled / GPU | `Emitter State=Self Once`、`Spawn Rate` Enabled | 主发射器 |
> | 3 | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location`、`Sample Texture`、`Dissolve`、`Kill Particles` | Enabled | Stack 中均可见 | 初始化、网格采样、纹理采样与剔除 |
> | 4 | Particle Update | `Particle State`、`Scale Color`、`Gravity Force`、`Collision`、`Solve Forces and Velocity` | Enabled | 处理颜色、重力、碰撞和速度求解 | 更新粒子运动与颜色 |
> | 5 | Render | `Sprite Renderer` | Enabled / selected | 右侧 Details 展开 Sprite Rendering | 输出 Sprite 粒子 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Collision.SpriteRenderer.Material` | `M_AdditiveNoBlur_v01` | Material | Details | 指定粒子 Sprite 材质 |
> | `Collision.SpriteRenderer.Material User Param Binding` | `None` | binding | Details | 不通过 User 参数覆盖材质 |
> | `Collision.SpriteRenderer.Source Mode` | `Particles` | enum | Details | 从粒子属性读取渲染数据 |
> | `Collision.SpriteRenderer.Alignment` | `Automatic` | enum | Details | 自动对齐 |
> | `Collision.SpriteRenderer.Facing Mode` | `Automatic` | enum | Details | 自动面向 |
> | `Collision.SpriteRenderer.Macro UV Radius` | `0.0` | float | Details | 未设置宏 UV 半径 |
> | `Collision.SpriteRenderer.Default Pivot in UV Space` | `(0.5, 0.5)` | vector2 | Details | Sprite pivot 居中 |
> | `Collision.SpriteRenderer.Sort Mode` | `None` | enum | Details | 不启用排序模式 |
> | `Collision.Renderer Visibility` | `0` | int/visibility tag | Details | 渲染可见性字段当前为 0 |
>
> 联动关系: `Collision` 发射器通过 `Sprite Renderer` 使用 `M_AdditiveNoBlur_v01` 输出 Spark 风格粒子；Timeline 中 `Collision`、`Spark_01`、`Spark_01001` 三条轨道可见，说明该系统由多个发射器组成。
> 验证方式: 打开 `Morph_01`，选中 `Collision.Sprite Renderer`，核对材质、Source Mode、Alignment/Facing、Pivot、Sort Mode 与 Renderer Visibility。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Sample Texture 与 User Skeletal Mesh 参数截图
> - 组成部分: Content Browser + Niagara System Overview + User Parameters + Sample Texture属性图 + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Sample Texture`
> - 目的: 让粒子从网格采样 UV 读取遮罩纹理，形成溶解/散点过滤效果。
>
> 参数:
> | 参数 | 命名空间/类型 | 值或来源 | 作用 |
> |---|---|---|---|
> | `User.Skeletal Mesh` | Niagara Data Interface Skeletal Mesh | 当前显示 `No mesh assigned warning`；`Source Mode=Default`、`Preview Mesh=None`、`Source Actor=None`、`Component Tags=0 Array element`、`Mesh User Parameter=None`、`Skinning Mode=Skin on the Fly`、`Sampling Regions=0 Array element`、`Whole Mesh LOD=-1` | 作为 Skeletal Mesh 采样输入，但此刻尚未指定 Mesh |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Collision.SampleTexture.Texture` | `CloudFilter_Tex00_mask` | Texture | Details | 粒子采样的灰白遮罩纹理 |
> | `Collision.SampleTexture.Texture Use` | `None` | enum | Details | 未指定额外 Texture Use |
> | `Collision.SampleTexture.Mip Level` | `0.0` | float | Details | 使用 0 级 Mip |
> | `Collision.SampleTexture.Apply Sampled RGB` | 未勾选 | bool | Details | 不直接应用采样 RGB |
> | `Collision.SampleTexture.UV` | `PARTICLES` / `SKELETAL MESH LOCATION` | binding | Details | 使用来自粒子与 Skeletal Mesh Location 的 UV |
> | `Collision.SampleTexture.Generate UV Using` | 未勾选 | bool | Details | 不在此处生成 UV |
> | `Collision.SampleTexture.Enable Sample Rejection` | 未勾选 | bool | Details | 不启用采样拒绝 |
>
> 联动关系: `Sample Texture` 模块读取 `CloudFilter_Tex00_mask`，UV 来源绑定到 `PARTICLES / SKELETAL MESH LOCATION`，因此依赖前面的 `Skeletal Mesh Location` 模块写入采样 UV；左侧 `User.Skeletal Mesh` 此时未指定，解释了需要继续设置网格参数。
> 验证方式: 在 `Morph_01 / Collision` 中选中 `Sample Texture`，核对纹理、Mip、UV 绑定和 User Parameters 中 Skeletal Mesh 是否已指定。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Skeletal Mesh Location 设置截图
> - 组成部分: Content Browser + Niagara Preview + User Parameters + Niagara Stack + Skeletal Mesh Location属性图 + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Skeletal Mesh Location`
> - 目的: 用 Skeletal Mesh 表面三角形随机采样生成角色轮廓粒子，并把采样位置写入粒子。
>
> 参数:
> | 参数 | 命名空间/类型 | 值或来源 | 作用 |
> |---|---|---|---|
> | `User.Skeletal_B` | Niagara Data Interface Skeletal Mesh | `Preview Mesh=Serath`；`Source Actor=None`；`Component Tags=0 Array element`；`Mesh User Parameter=None`；`Skinning Mode=Skin on the Fly`；`Sampling Regions=0 Array element`；`Whole Mesh LOD=-1` | 当前左侧 User 参数中显示的 Skeletal Mesh 数据接口 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Collision.SkeletalMeshLocation.Skeletal Mesh` | `USER Skeletal_A` | User parameter binding | Details | 采样来源绑定到 `Skeletal_A` |
> | `Mesh Sampling Type` | `Surface (Triangles)` | enum | Details | 从网格表面三角形采样 |
> | `Triangle Sampling` | `Random (All Triangles)` | enum | Details | 在所有三角形中随机采样 |
> | `Sampled UV Index` | `0` | int | Details | 使用 UV 0 |
> | `Position Sampling` | `Apply (Rigid)` | enum | Details | 应用采样位置 |
> | `Sampled Position Offset` | `(0.0, 0.0, 0.0)` | vector | Details | 无位置偏移 |
> | `Sampled Position` | `Sampled Mesh` | enum | Details | 位置来自采样网格 |
> | `Write To Particle` | 勾选 | bool | Details | 将采样位置写入粒子 |
> | `Velocity Sampling` | `Output` | enum | Details | 输出采样速度 |
> | `Orientation Sampling` | `Apply` | enum | Details | 应用采样朝向 |
> | `Use Sampled Mesh` | 勾选 | bool | Details | 使用采样网格数据 |
>
> 预览结果: Niagara Preview 中形成白色角色轮廓粒子，周围有少量散点，表示 Skeletal Mesh 表面采样已驱动粒子分布。
> 联动关系: `Skeletal Mesh Location` 使用 `USER Skeletal_A` 和三角形随机采样写入粒子位置；后续 `Sample Texture` 可用该模块生成的采样数据读取纹理，形成角色溶解粒子。
> 验证方式: 选中 `Collision.Skeletal Mesh Location`，核对 `USER Skeletal_A`、三角形随机采样、UV Index、Write To Particle 和 Use Sampled Mesh，并观察 Preview 中角色轮廓粒子。

### 00:23:13-00:27:18 Texture、粒子

- 本段定位：Texture、粒子。
- 知识点：B设置为5里 复制Skytomancy再制作一个 这里是连接 SkytomancyB 接下来在这里建立一个Site 然后放在下面 需要获取一个粒子位置。
- 知识点：这样在样本位置中 有一个Skytler 这个消息位置 Skytler消息位置001 现在我们正在使用两个 所以这里也出现了两个 需要把这个。
- 知识点：放入第一个样本位置 这可以被视为 再计算一次更加确定的概念 即使不放这个也无关紧要 为了保证 每个粒子的计算更加准确。
- 知识点：不让他们脱离 这样固定一下 像相通Texture中可以直接使用这个Texture 在做的开销 现在是这种 毕竟当前的溶解值是正在。
- 知识点：动画的 可以对照这个来看 我设置为一会儿占用前面的多余帧 所以我改为0.8 在0.80-0.1 这里也在0.80-0.1 关闭了 然后这样溶解。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Texture`、`粒子`、`用户参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Initialize Particle 与 Skeletal_B 参数截图
> - 组成部分: Niagara Preview + User Parameters + Niagara Stack + Initialize Particle属性图 + Timeline + 字幕
> - 所属: `Morph_01 / Collision / Initialize Particle`
> - 目的: 设置粒子生命周期和非均匀 Sprite 尺寸，并准备第二个 Skeletal Mesh 采样输入。
>
> 参数:
> | 参数 | 命名空间/类型 | 值或来源 | 作用 |
> |---|---|---|---|
> | `User.Skeletal_B` | Niagara Data Interface Skeletal Mesh | `Preview Mesh=MurielSepia`；`Source Actor=None`；`Mesh User Parameter=None`；`Skinning Mode=Skin on the Fly` | 第二个角色网格采样输入 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Collision.InitializeParticle.Lifetime Mode` | `Random` | enum | Details | 寿命使用随机模式 |
> | `Lifetime Min` | `2.0` | seconds/float | Details | 最小寿命 |
> | `Lifetime Max` | `2.0` | seconds/float | Details | 最大寿命，实际固定为 2 秒 |
> | `Color Mode` | `Unset` | enum | Details | 不在此模块设置颜色 |
> | `Position Mode` | `Simulation Position` | enum | Details | 使用模拟位置初始化 |
> | `Sprite Size Mode` | `Random Non-Uniform` | enum | Details | 非均匀随机尺寸 |
> | `Sprite Size Min` | `(1.0, 1.0)` | vector2 | Details | 最小 Sprite 尺寸 |
> | `Sprite Size Max` | `(1.5, 1.5)` | vector2 | Details | 最大 Sprite 尺寸 |
> | `Sprite Rotation Mode` | `Unset` | enum | Details | 不在此模块设置旋转 |
> | `Sprite UV Mode` | `Unset` | enum | Details | 不在此模块设置 UV |
>
> 预览结果: 左侧 Preview 中角色轮廓粒子为白色点状分布，周围仍有少量散点。
> 联动关系: `Initialize Particle` 负责 2 秒寿命和 1.0-1.5 的非均匀 Sprite 尺寸；`User.Skeletal_B=MurielSepia` 为后续第二个网格采样/纹理采样准备输入。
> 验证方式: 在 `Morph_01 / Collision` 选中 `Initialize Particle`，核对 Lifetime、Position Mode、Sprite Size，并检查 `User.Skeletal_B` 的 Preview Mesh。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡中 Morph 粒子播放检查截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Niagara Details + Niagara Editor局部 + 字幕
> - 所属: `07_Fire_Explosion / Morph 01`
> - 目的: 在关卡中检查 `Morph 01` NiagaraActor 的粒子播放，并确认当前 Dissolve 值处于动画变化中。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `ParagonMuriel / ... / Mesh` | 选中 `MurielSepia` Skeletal Mesh | 当前预览仍围绕变身角色 |
> | 中央 Viewport | 效果/场景状态图 | `Morph 01` 与角色 | 上方可见黑色/红色角色，下方可见橙黄粒子团和散点，粒子围绕角色下方区域聚集 | 用于检查溶解粒子在关卡内的播放效果 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 当前选中 `Morph 01`，类型为 NiagaraActor；同列表可见 `Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath` | 与 Details 的 NiagaraComponent 对应 |
> | 右侧 Details | 属性图 | `Morph 01 (Instance) / NiagaraComponent` | 可见 `Sampling Regions=0 Array element`、`Whole Mesh LOD=-1`、`Filtered Bones=0 Array element`、`Filtered Sockets=0 Array element`、`UV Set Index=0`、`Require Current Frame` 勾选；下方展开 `Skeletal_B` Data Interface | 记录 NiagaraActor 的采样相关字段 |
> | 底部 Niagara Editor局部 | Niagara Stack/Details | `Morph_01 / Collision / Dissolve` | 下方可见 `Collision` 发射器和 `Dissolve` 模块标题；粒子数约 `4,785 Particles` | 与字幕中的 Dissolve 动画值对应 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “毕竟当前的溶解值是正在动画的。” | 说明此时播放检查依赖 Sequencer/参数动画 |
>
> 联动关系: 关卡中选中 `Morph 01` NiagaraActor，Viewport 显示橙黄粒子聚集并跟随当前溶解动画值变化；Details 的采样字段和 Niagara Editor 的 `Dissolve` 模块共同确认该预览来自 Morph 粒子系统。
> 验证方式: 在关卡中选中 `Morph 01`，播放 Sequencer 或预览当前帧，检查粒子是否随 Dissolve 参数变化，同时核对 NiagaraComponent 的采样字段。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡最终溶解预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details空状态 + Sequencer/Niagara窗口局部
> - 所属: `07_Fire_Explosion / Morph 01 / MurielSepia`
> - 目的: 检查当前溶解粒子配置后，角色在关卡中的剩余显示状态。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `ParagonMuriel / ... / Mesh` | 选中 `MurielSepia` Skeletal Mesh | 当前预览对象仍为变身角色 |
> | 中央 Viewport | 效果/场景状态图 | `MurielSepia` / `Morph 01` | 画面中白色装甲角色站在暗色背景中，手部附近有红橙色发光/粒子残留；上方有相机/灯光图标 | 用于确认溶解粒子和角色显示的阶段性结果 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 可见 `Morph 01`、`Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath`；场景对象数为 12 | 确认 Morph 粒子和角色同处当前关卡 |
> | 右侧 Details | 属性图 | 未选中可读对象 | 文本为 `Select an object to view details.` | 此图主要读 Viewport 和 Outliner |
> | 底部窗口局部 | Sequencer/Niagara 编辑上下文 | `07_Fire_Explosion` 与 `Morph_01` | 底部可见 Sequencer 和 `Morph_01` Niagara 编辑器标题、Compile 按钮等 | 表示仍在序列和粒子系统联调 |
>
> 联动关系: Outliner 证明 `Morph 01`、`MurielSepia` 和 `Serath` 同时在场景中，Viewport 显示当前配置下角色手部/身体附近的红橙粒子残留；这是对前面 Skeletal Mesh/Texture/Dissolve 设置的关卡级预览。
> 验证方式: 在 `07_Fire_Explosion` 中保留 `Morph 01` 和 `MurielSepia`，播放或定位到相同阶段，确认 Viewport 中角色和红橙粒子残留状态。

### 00:27:26-00:30:11 Velocity、Alpha、Skeletal Mesh

- 本段定位：Velocity、Alpha、Skeletal Mesh。
- 知识点：可以将球形粒子的这个项目连接起来 这里现在 Siren这个角色 已经在里面 上面的放入 使用谷歌网格就是这样 为了在原角色中进行设置 我就提前在观察上。
- 知识点：放好了 选择SE拉斯作为原 然后B是木梨奥 设置为 基尔托应该可以 这个在指定之前是没有出来的 角色匹配时 能确认测量的事情 生成的粒子将添加到这里。
- 知识点：到此为止已完成 这里更新部分 有Learn粒子属性 这里有Alpha部分 我们要使用的是 这里的位置塔 但除此之外在这里可观察到 还有动态参数。
- 知识点：还有颜色部分 还有相机片移 有非常多的选项值 有Foundational 和Velocity 这个实用性非常大 后续会开启Position来使用。
- 知识点：在这里搜索样本 有Skeletal A和B A已经放入第一个Skeletal Mesh 的样本位置 第二个将放入001的样本位置值 然后用这个Alpha值来控制位置值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Velocity`、`Alpha`、`粒子`、`颜色`、`曲线`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡中 Morph_01 User Parameters 截图
> - 组成部分: Content Browser + Level Viewport + Outliner + NiagaraActor Details + Sequencer时间轴 + 字幕
> - 所属: `07_Fire_Explosion / Morph 01 / Skeletal_A`
> - 目的: 在关卡实例上确认 `Morph 01` 的 Niagara System、Tick 行为和 `Skeletal_A` 输入网格。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | 资源面板 | `ParagonMuriel / ... / Mesh` | 选中 `MurielSepia` Skeletal Mesh | 当前仍在角色网格资源上下文 |
> | 中央 Viewport | 效果/场景状态图 | `Morph 01` 与角色 | 白色角色身上和手部附近有红橙色粒子/溶解亮点；相机和灯光图标可见 | 用于检查 Morph 粒子在关卡内的播放状态 |
> | 右侧 Outliner | 场景对象列表 | `07_Fire_Explosion` | 当前选中 `Morph 01`，类型为 NiagaraActor；同列表可见 `Morphing Came...`、`MurielSepia`、`PlayerStart`、`PostProcessVo...`、`Serath` | 与 Details 的 `Morph 01 (Instance)` 对应 |
> | 右侧 Details | 属性图 | `Morph 01 (Instance) / NiagaraComponent` | `Niagara System Asset=Morph_01`；`Niagara Tick Behavior=Use Prereqs`；`Allow Scalability` 勾选；`User Parameters > Skeletal_A` 展开，`Source Mode=Default`、`Preview Mesh=Serath`、`Source Actor=None`、`Component Tags=0 Array element`、`Mesh User Parameter=None`、`Skinning Mode=Skin on the Fly` | 把 `Serath` 指定为第一个 Skeletal Mesh 输入 |
> | 底部 Sequencer | Timeline/序列上下文 | `07_Fire_Explosion*` | 播放头在 `0055`，读数 `56 of 181`；Camera Cut 当前在 `Morphing Camera Actor` 前段 | 在第 56 帧附近检查粒子效果 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “这里现在” | 指向当前设置位置 |
>
> 联动关系: `Morph 01` 关卡实例使用 `Morph_01` System，并把 `Skeletal_A.Preview Mesh` 指向 `Serath`；Viewport 中红橙粒子预览用于确认该参数进入关卡播放状态。截图只记录 Details 字段和相机预览，不解释视口中的三维坐标。
> 验证方式: 在关卡中选中 `Morph 01`，检查 Niagara System Asset、Tick Behavior、Allow Scalability 和 `Skeletal_A` 的 Preview Mesh 是否为 `Serath`。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara 新增模块菜单与 Scale Color 截图
> - 组成部分: Niagara Preview + User Parameters + Niagara Stack + Add Module菜单 + Scale Color属性图 + Timeline
> - 所属: `Morph_01 / Collision`
> - 目的: 在 `Particle Update` 中准备新增可用于位置/属性插值的模块，同时保留当前 `Scale Color` 设置。
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Particle Spawn | `Initialize Particle`、`Skeletal Mesh Location`、`Skeletal Mesh Location 001`、`Set PARTICLES Position`、`Sample Texture`、`Dissolve`、`Kill Particles` | Enabled | 两个 Skeletal Mesh Location 均为 `Triangles / Random` | 从两个网格采样并设置粒子位置 |
> | 2 | Particle Update | `Particle State`、`Scale Color`、`Gravity Force`、`Collision`、`Solve Forces and Velocity` | Enabled | 当前在组内打开 Add Module 菜单 | 准备添加后续属性插值模块 |
> | 3 | Render | `Sprite Renderer` | Enabled | 作为 Sprite 输出 | 渲染粒子 |
>
> 菜单/建议项:
> | 区域 | 可读项 | 作用 |
> |---|---|---|
> | Add Module 搜索菜单 | `Suggested` 下可见 `Camera Offset`、`New Scratch Pad Module`、`Scale Color`、`Set new or existing parameter directly`、`Shape Location`、`Skeletal Mesh Location`、`Update Mesh Orientation` | 提供可添加到当前组的 Niagara 模块 |
> | Source Filtering | `Niagara`、`Game`、`Plugins`、`Developer`、`Library Only` 勾选 | 控制模块库过滤 |
>
> 设置:
> | Owner.Property | 值 | 来源 | 作用 |
> |---|---|---|---|
> | `Collision.Scale Color.Scale Mode` | `RGB and Alpha Separately` | Details | 分离控制 RGB 与 Alpha |
> | `Scale RGB` | 勾选，`Multiply Vector by Float` | Details | 使用向量乘 Float |
> | `Vector` | `(10.0, 2.0, 1.0)` | Details | 粉橙色强度 |
> | `Float` | `1.0` | Details | RGB 倍增系数 |
> | `Scale Alpha` | 勾选，值 `2.0` | Details | Alpha 强度 |
>
> 预览结果: Preview 左上显示粒子计数 `3516 Current`，`Collision` Active；`Spark_01` 与 `Spark_01001` 为 Disabled，预览中是白色角色轮廓粒子。
> 联动关系: Stack 中已有两个 `Skeletal Mesh Location` 和 `Set PARTICLES Position`，Add Module 菜单用于继续添加位置/属性插值相关模块；右侧 `Scale Color` 仍控制当前粒子颜色和 Alpha。
> 验证方式: 在 `Morph_01 / Collision` 的 `Particle Update` 点击添加模块，核对 Suggested 列表；同时检查 `Scale Color` 的 Vector/Float/Alpha 参数。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Lerp Particle Attributes 设置截图
> - 组成部分: Niagara Preview + User Parameters + Niagara Stack + Lerp属性图 + Timeline
> - 所属: `Morph_01 / Collision / Lerp Particle Attributes`
> - 目的: 用 Alpha 控制粒子位置在两个 Skeletal Mesh 采样结果之间插值。
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Particle Spawn | `Skeletal Mesh Location` | Enabled | `Triangles / Random` | 第一个网格采样 |
> | 2 | Particle Spawn | `Skeletal Mesh Location 001` | Enabled | `Triangles / Random` | 第二个网格采样 |
> | 3 | Particle Spawn | `Set PARTICLES Position` | Enabled | 位于两个采样模块之后 | 写入粒子位置 |
> | 4 | Particle Update | `Lerp Particle Attributes` | Enabled / selected | `Lerp Alpha=0.0` | 插值粒子属性 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `LerpParticleAttributes.Lerp Alpha` | `0.0` | float | Details | 插值权重当前为 0 |
> | `Lerp Camera Offset` | 未勾选 | bool | Details | 不插值 Camera Offset |
> | `Lerp Color` | 未勾选 | bool | Details | 不插值 Color |
> | `Lerp Dynamic Material Parameter 0-3` | 未勾选 | bool | Details | 不插值动态材质参数 |
> | `Lerp Material Random` | 未勾选 | bool | Details | 不插值 Material Random |
> | `Lerp Position` | 勾选 | bool | Details | 启用位置插值 |
> | `Position A` | `PARTICLES / SKELETAL MESH ...` | binding | Details | 位置插值起点来源 |
> | `Position B` | `PARTICLES / SKELETAL MESH ...` | binding | Details | 位置插值终点来源 |
> | `Lerp Sprite Alignment/Facing/Rotation` | 未勾选 | bool | Details | 不插值这些 Sprite 属性 |
>
> 预览结果: Particle Counts 显示 `4140 Current`，`Collision` Active；`Spark_01` 和 `Spark_01001` Disabled；Preview 中粒子显示较暗/稀疏。
> 联动关系: 两个 `Skeletal Mesh Location` 产生两个位置来源，`Lerp Particle Attributes` 只启用 `Position` 插值，并用 `Lerp Alpha` 控制从 A 到 B 的混合；这对应上下文“用 Alpha 值控制位置值”。
> 验证方式: 在 `Morph_01 / Collision` 选中 `Lerp Particle Attributes`，核对 `Lerp Alpha`、`Lerp Position` 和 Position A/B 绑定，确认其他属性插值未启用。

## 补充视觉证据

### S01 00:02:06

> 图表转写（UE-GTXT v4）
> - 类型: 材质函数纹理来源补充截图
> - 组成部分: Content Browser Texture资源 + 材质函数预览 + 材质函数节点图 + Sequencer局部 + 字幕
> - 所属: `MF_CharacterEffects / MF_Death_01`
> - 目的: 补充说明从 Texture 资源中拖入颜色/遮罩纹理，并接入角色效果材质函数。
>
> 模块清单:
> | 区域 | 模块类型 | Owner | 可读信息 | 与其他模块关系 |
> |---|---|---|---|---|
> | 左侧 Content Browser | Texture资源面板 | `Coloso_Tutorial / Texture` | 可见 `CloudFilter`、`C_BG_Ring`、`dust_thick`、`falloff_...`、`fx_liquid_...`、`D_Ocean...` 等 Texture 缩略图 | 为材质函数拖入遮罩/颜色纹理提供来源 |
> | 中央 Preview | 材质函数预览 | `MF_CharacterEffects` | 预览球为深色材质球，顶部显示 `Previewing: MaterialExpressionFunctionOutput_0` | 用于检查函数输出 |
> | 右侧 Material Graph | 材质函数节点图 | `MF_CharacterEffects` | 可见 `MF_Death_01` 节点，输入 `Input Mask (S)`、`Input Texture (S)`，输出 `Result`；上方可见材质属性输出列表，包含 `AmbientOcclusion`、`Refraction`、`CustomizedUVs_0-7`、`PixelDepthOffset`、`ShadingModel`、`Displacement` 等 | `MF_Death_01` 是溶解/死亡效果函数入口 |
> | 底部 Sequencer局部 | Timeline | `07_Fire_Explosion*` | 播放头约在 `0064`，Camera Cut 前段可见 | 表明截图发生在当前序列编辑过程中 |
> | 底部字幕 | 字幕/标注 | 当前课程语音 | “我会把那个时候使用的颜色纹理拖过来” | 对应从 Texture 面板拖入旧纹理复用 |
>
> 联动关系: 左侧 Texture 资源面板提供 `CloudFilter` 等纹理来源，右侧 `MF_Death_01` 需要 `Input Mask` 和 `Input Texture`，用于把旧颜色/遮罩纹理接入 `MF_CharacterEffects` 溶解函数。当前截图只显示节点和资源候选，未显示完整拖拽后的连线端点。
> 验证方式: 在 `MF_CharacterEffects` 中检查 `MF_Death_01` 的 `Input Mask`、`Input Texture` 是否接入从 Texture 资源面板拖入的目标纹理采样节点。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


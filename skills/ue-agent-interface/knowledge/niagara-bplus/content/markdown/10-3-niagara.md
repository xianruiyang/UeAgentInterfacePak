# 10-3-创建虚幻Niagara精灵技能效果

# 10-3-创建虚幻Niagara精灵技能效果

## 关键术语

- `Velocity`、`Alpha`、`UV`、`Multiply`、`Normal`、`PS`、`材质`、`粒子`、`发射器`、`速度`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Normalized Age`、`Niagara System`、`Particle`

## 分段知识

### 00:00:00-00:02:55 纹理

- 本段定位：纹理。
- 知识点：要这个用 数值几乎都差不多 但只看变动的数值 是的 平常也可以考虑 然后 这个呢为了加强边缘 然后 会巧亮一点 嗯 正常值需要适当改一下 光的平步设为4。
- 知识点：大约1.5 是的 试着换一下这个纹理 然后 对了 剩下的 把口罩价格适当降低一下 然后这部分的话 这样差不多 调整数字 正在保存着 是的 要放在这里吧。
- 知识点：现在显示是这样 然后它这个是排序 现在 比之前做的适当透明一点 是的 适当要小一点 中间的元素没太大关系 但 还是适当调整一下的话 就是 是的。
- 知识点：应该比这两个元素小一点 先试着调整一下大小 大小大概是800这样考虑 然后 现在面对的也会照样使用 这个先加入移动噪音 这个会适当调整饱和度 然后 让它不要太强烈。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这是材质实例 `M_RadialUV_01_Ins_04` 的参数面板。左侧预览显示一张较暗的魔法阵样式圆盘，包含外圈符号和内层几何结构，但整体亮度被压得很低，说明这一阶段还在先看纹理造型本身，再逐步调亮边缘与透明度。

当前图可确认的参数如下：

- `Center_Color = (R 1.0, G 0.0, B 0.2, A 1.0)`
- `Color_Bias = 1.0`
- `Color_Str = 1.0`
- `Color_Tex = T_Color_01`
- `Color_Tile_U = 1.0`
- `Color_Tile_V = 0.5`
- `Desaturation = -1.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.0`
- `Edge_Str = 1.0`
- `Use_Refraction` 未勾选
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 2.0`
- `Normal_Tile_V = 0.3`
- `Fade_Dist = 1.0`
- `Mask_Str = 10.0`
- `Mask_Tex = T_MagicCircle_01`
- `Opacity_Pow = 0.5`
- `Opacity_Str = 30.0`

输出/预览：

- 这张图说明 `p12` 开头仍沿用上一页末尾建立出来的“魔法阵遮罩”方案，但先以较低边缘强度观察纹理读形是否合适。
- 当前可见重点是图案结构已经成立，后续调参会主要围绕“让边缘更亮、让整体更透明或更轻一些”展开。
这是同一材质实例 `M_RadialUV_01_Ins_04` 的后续调参画面。左侧预览里的魔法阵已经收得更小，边缘呈现出更碎、更破裂的亮斑，中心遮挡区域也更不规则，说明作者在这一张开始重点替换透明度纹理并重调边缘锐度。

当前图可确认的参数如下：

- `Desaturation = -1.0`
- `Edge_Color` 为浅紫偏白
- `Edge_Pow = 1.5`
- `Edge_Str = 500.0`
- `Refraction_Str = 1.03`
- `Use_Refraction = True`
- `Normal_Tex = Normal_06`
- `Normal_Tile_U = 3.0`
- `Normal_Tile_V = 0.5`
- `Fade_Dist = 10.0`
- `Mask_Str = 5.0`
- `Mask_Tex = T_MagicCircle_01`
- `Opacity_Pow = 1.0`
- `Opacity_Str = 30.0`
- `Opacity_Tex = T_Ribbon_05`
- `Opacity_Tile_U = 4.0`
- `Opacity_Tile_V = 1.5`
- `Parent = M_RadialUV_01`

输出/预览：

- 与上一张相比，最关键的变化是 `Opacity_Tex` 已切换为 `T_Ribbon_05`，并把 `Opacity_Tile_U/V` 提高到 `4.0 / 1.5`，因此透明度分布从均匀圆形层变成了带切割感和破碎边缘的图形。
- 同时 `Fade_Dist` 被拉高到 `10.0`，`Mask_Str` 降到 `5.0`，配合 `Edge_Pow = 1.5`、`Edge_Str = 500.0`，让魔法阵整体更轻、更透明，但边缘亮线更锋利。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图。当前新增并选中的是发射器 `Empty006`，右侧模块为 `Scale Color`。左侧预览中，外层紫色主环内部已经叠加了深紫色、带破碎噪点的纹理层；字幕也提到“先加入移动噪音”，说明此时作者开始把新纹理层接回 Niagara 并通过颜色缩放控制它的寿命衰减。

当前图可确认的系统状态：

- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`
- `Empty002` 处于 `Disabled`
- 当前高亮的是 `Empty006`

`Empty006 -> Scale Color` 当前可确认的参数：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Multiply Vector by Float`
- `Vector = (2.0, 2.0, 3.0)`
- `Float = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从前段接近 `1.0` 持续下降，到末端接近 `0.0`
- `Scale Alpha = Float from Curve`
- 同样使用 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- Alpha 曲线前段保持高值，后段快速掉到接近 `0.0`

输出/预览：

- 这张图表达的重点是：新发射器 `Empty006` 不是只套一个静态纹理，而是用 `Scale Color` 先把 RGB 和 Alpha 都绑定到生命周期曲线上。
- `RGB` 侧再乘上 `(2, 2, 3)` 的颜色向量，意味着蓝紫通道被额外强化；`Alpha` 则在后半程快速消失，因此这层破碎纹理会先显现，再很快淡出，为后续“移动噪音”提供一个可控的基础显示层。

### 00:02:59-00:05:53 Alpha、颜色、贴图

- 本段定位：Alpha、颜色、贴图。
- 知识点：错误地是4球 剩下的Pasta部分也省略了 就是三球模具 想要突着这假的一个和黑色的 然后其他的的话 就会被省略长度请注意 然后就降低了。
- 知识点：是否 就如果你考虑过这个视频 通过界面 顶开始是颜色迅速消失 就那种感觉今天快点消失 完全现在比起颜色消失。
- 知识点：适当调一点色调 这个紧张度应该可以 这样会调整亮度 然后给Alpha0-0 0.1-L这样 0.1-L这样 然后这个从0.5开始快速消失。
- 知识点：这种感觉尝验证效果 有点淡淡的 适当有点暗的色调 感觉到 得匹配动态 这是给V1贴图的OPA部分1.5值 其实这都不一样 然后再更远伸展 因为贴图本身变大了。
- 知识点：就看吧 在中心处 非常快地传播出去 就可观察到这个 中间元素和传播的时机 差不多匹配出来的话会比较好 这样太快了 或者 不过适当调整一下这个图表。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`贴图`、`颜色`。

**关键画面：**

这是 `Ex_01_SpriteExp` 中发射器 `Empty006` 的 `Scale Color` 调整画面。左侧预览里，外层主水环内部的破碎纹理层已经比较明显，但整体仍偏暗；右侧显示作者正在继续压低这层纹理的 RGB 强度，使它不要抢过主环。

当前图可确认的系统状态：

- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`
- `Empty002` 仍为 `Disabled`
- 当前选中发射器：`Empty006`
- 当前模块：`Scale Color`

`Scale Color` 可确认的参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Multiply Vector by Float`
- `Vector = (1.5, 1.5, 2.0)`
- `Float = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- RGB 曲线从前段高值逐步下降，到末端接近 `0`
- `Scale Alpha = Float from Curve`
- Alpha 同样基于 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- Alpha 曲线前段较高，后段快速掉到接近 `0`

输出/预览：

- 与上一批的 `Empty006` 相比，RGB 向量已从更亮的设置收敛到 `(1.5, 1.5, 2.0)`，蓝色通道仍略高于红绿，但整体更克制。
- 这正对应本段“适当有点暗的色调、匹配动态”的要求：纹理层依然能读出破碎扩散感，但不再过度发亮。
这是 `Empty006` 发射器的 `Scale Color` 继续微调画面。左侧预览区当前没有清晰显示粒子结果，重点已经转到左下曲线编辑器和右侧参数面板，作者显然在专门调颜色与 Alpha 的生命周期曲线形状。

当前图可确认的结构：

- 左下层级树展开为：
- `Empty006 Emitter`
- `Scale Sprite Size`
- `Dynamic Material Parameters`
- `Scale Color`
- `Scale RGB`
- `Float`
- `Scale Alpha`

右侧 `Scale Color` 参数可确认如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Multiply Vector by Float`
- `Vector = (1.5, 1.5, 2.0)`
- `Float = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 3.0`
- RGB 曲线前段维持高值，随后快速下降，尾段保持较低值
- `Scale Alpha = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 10.0`
- Alpha 曲线前段快速拉升到接近 `1.0`，中段保持，再在后段下降到较低值

左下大曲线窗口当前显示的是一条从约 `1.0` 快速衰减到约 `0.3`、末端略微回升的红线，说明作者在尝试让这层纹理不是简单线性消失，而是在尾段保留一点残留亮度。

输出/预览：

- 这张图的关键变化是把 RGB 曲线整体系数提高到 `3.0`，同时把 Alpha 曲线整体系数提高到 `10.0`，但通过曲线形状控制可见时间窗。
- 结果导向是：纹理层可以在出现早期更快达到可见状态，中段维持存在感，末端再衰减，而不是一开始就太弱或全程同亮度。
这是 `Empty006` 发射器切回 `Dynamic Material Parameters` 的画面。左侧预览中，这层纹理已经不再是大范围环形扩散，而是收成一个更小、更亮、偏紫红色的中心花瓣状图形，说明作者已经开始同步调动态材质参数，让贴图在生命周期里更快向中心收敛并改变颜色/扭曲表现。

当前图可确认的系统状态：

- 当前选中发射器：`Empty006`
- 左下层级树可见：
- `Scale Sprite Size`
- `Dynamic Material Parameters`
- `Scale Color`
- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`

`Dynamic Material Parameters` 当前图可确认的参数：

- 当前处于 `All` 视图
- `Opacity_VPan = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从接近 `0.0` 起始，随后持续下降到约 `-1.0` 附近
- `Distortion = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从接近 `0.0` 逐步上升到约 `0.1`
- `ColorPow = 1.0`
- `Param3-0 = 0.0`

输出/预览：

- `Opacity_VPan` 已经变成带负值的位移曲线，这说明材质中的透明度/纹理滚动不只是衰减，而是会沿相反方向推动纹理。
- `Distortion` 则在生命周期中持续增强，因此这层中心纹理会随着时间更扭曲、更集中。
- 结果就是预览中出现了一个更紧凑的紫色中心花状核心，和前一张偏大、偏暗的环形纹理形成明显对比。

### 00:05:59-00:08:33 发射器、生命周期

- 本段定位：发射器、生命周期。
- 知识点：这样感觉可以走下去 扭曲适当减少一下怎么样 因为 几乎是核心的元素 重要的元素 四个发射器会成为这样。
- 知识点：现在从次要的镜头光晕和颗粒 光线什么的来调整一下 先试试镜头光晕 因为 需要复制之前用的发射器过来。
- 知识点：从水扬中 创建一个添加实力 这里的话只适当降低一下功率值吗 U-Ring Break 这个要去掉节奏吧 U-Ring Break 可能需要一些偏移值。
- 知识点：生命周期很短 因为这个要从实体中间出来 我觉得相机偏移值大约50就行 长一点用延长的尺寸 做成500大约350 尺寸从0开始 在0.20变成这个大小。
- 知识点：在1时再缩小到0 这里是线性的放在4号 是的那就有对照 是的那就有对照。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`发射器`、`生命周期`。

**关键画面：**

这是 `Ex_01_SpriteExp` 中发射器 `Empty006` 的 `Dynamic Material Parameters` 调整画面。左侧预览里的纹理层已经缩成一个小型紫色核心花状图形；右侧和左下曲线窗口则说明作者正在继续通过动态参数控制这层纹理的位移和扭曲时序。

当前图可确认的系统状态：

- 当前选中发射器：`Empty006`
- 当前模块：`Dynamic Material Parameters`
- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`

左下层级树当前展开到：

- `Dynamic Material Parameters`
- `Index 0 Param 1`
- `Index 0 Param 2`
- `Scale Color`
- `Scale RGB`
- `Float`
- `Scale Alpha`

右侧 `Dynamic Material Parameters` 可确认的参数如下：

- `Opacity_VPan = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从接近 `0.0` 开始，持续下降到约 `-1.25` 附近
- `Distortion = Float from Curve`
- 输入轴为 `PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- 曲线从 `0.0` 线性增长到约 `0.05`
- `ColorPow = 1.0`
- `Param3-0 = 0.0`

左下大曲线窗口当前清楚显示一条从约 `0.5` 快速下滑、一路进入负值区并在末端达到约 `-1.25` 的红色曲线，这与 `Opacity_VPan` 的行为一致。

输出/预览：

- 这一步的重点是把 `Opacity_VPan` 明确推到负值区，使材质内部纹理在生命周期里向相反方向滑动得更远。
- 同时 `Distortion` 只保持小幅增长，因此最终效果更像“中心向外快速扩散并留下较短纹理拖影”，而不是夸张扭曲。
这是 `Ex_01_SpriteExp` 的 Niagara System 视图，当前新增并选中的是发射器 `Empty007`。作者此时不再调材质参数，而是在发射器级别配置 Sprite 的朝向与对齐方式。左侧预览里中心花状纹理层仍然可见，说明 `Empty007` 是在已有层次基础上继续补一个新的面片发射器。

当前图可确认的系统状态：

- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`、`Empty007`
- 当前选中发射器：`Empty007`
- 当前模块：`Sprite Facing and Alignment`

`Sprite Facing and Alignment` 面板可确认的参数如下：

- `Sprite Facing = (0.0, 0.0, 1.0)`
- `Facing Coordinate Space = Simulation`
- `Sprite Alignment = (0.0, 1.0, 0.0)`

发射器结构可见为：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

输出/预览：

- 这一步的意义是把 `Empty007` 的 Sprite 朝向固定到模拟空间的 Z 轴正方向，并给定一个明确的对齐向量。
- 对于这种中心扩散型纹理层，这样做可以保证面片不会随相机自由翻转，而是更稳定地贴在期望平面上，便于和前面几个核心发射器做层次对照。
这是 `Empty007` 发射器的 `Scale Sprite Size` 设置画面。左侧预览里，主环外侧已经能看到一圈更长、更贴边的纹理条带；右侧曲线窗口则给出这层贴图尺寸随生命周期变化的明确规则。

当前图可确认的系统状态：

- 当前选中发射器：`Empty007`
- 当前模块：`Scale Sprite Size`
- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`、`Empty007`

`Scale Sprite Size` 可确认的参数如下：

- `Scale Sprite Size Mode = Uniform Curve`
- `Uniform Curve Sprite = Curve for Floats`
- `Uniform Curve Index = PARTICLES.NormalizedAge`
- `Uniform Curve Scale = 1.0`

曲线形状：

- 生命周期起点附近尺寸接近 `0`
- 在 `NormalizedAge ≈ 0.2` 左右迅速上升到约 `2.0`
- 之后持续下降
- 到生命周期末端接近 `0`

发射器结构当前可见：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Camera Offset`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

输出/预览：

- 这张图与正文“尺寸从 0 开始，在 0.20 变成这个大小，在 1 时再缩小到 0”完全对应。
- 作用是让 `Empty007` 这层条带纹理先快速长开，形成一个外扩的次级轮廓，然后在生命周期后段收回并消失，从而和主环的扩散节奏形成对照。

### 00:09:02-00:11:58 Alpha、颜色、纹理

- 本段定位：Alpha、颜色、纹理。
- 知识点：现在是编辑的 但因为去掉了颜色 所以就没出现 颜色原本在纹理里就有红色调 我觉得调整成有点紫色的感觉比较好 反正这里的光辉也会有类似的色调。
- 知识点：光辉里本来就会有接近白色的色调 这样混合后颜色会更自然 所以应该会更自然一些 0.1左右的Alpha变成 当值为0时变为0 都是线性的。
- 知识点：反正就是很短的时间 然后复制那个0.1左右的Alpha 是的增加一个instance 让它使用circleR的纹理。
- 知识点：数值不必对齐 这里适当有点时间 这里大约设置为600 尺寸可以一样写 才是没有变的 是的 是的 这样进去的 中间感觉适当提高饱和度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`纹理`、`颜色`。

**关键画面：**

这是 `Ex_01_SpriteExp` 中 `Empty007` 发射器的 `Scale Color` 调整画面。左侧预览里，中心紫色纹理花状层已经叠加进主环，并伴随一条横向亮带；右侧当前重点是降低这层 Sprite 的 Alpha 强度，同时把 RGB 颜色倍率恢复为中性值。

当前图可确认的系统状态：

- 当前选中发射器：`Empty007`
- 当前模块：`Scale Color`
- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`、`Empty007`

`Scale Color` 可确认的参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`
- `Scale Alpha = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- Alpha 曲线从前段接近 `1.0` 开始，后段逐步衰减到接近 `0.0`
- `Scale Curve = 0.7`

左下当前显示的曲线仍是 `Uniform Curve Sprite Scale`：起始为 `0`，在早期迅速升到约 `2.0`，随后回落到 `0`，说明这层 Sprite 的尺寸时序还保持上一批的扩张-收缩逻辑。

输出/预览：

- 这一步的关键是把 `Scale Alpha` 总体压到 `0.7`，也就是让这层中心纹理更透明一点。
- 同时 RGB 不再额外偏色放大，说明作者想先把显示强度压稳，再继续调颜色和饱和度，使整体混入主环后不会显得过重。
这是一个加法材质实例参数面板，父材质为 `M_Additive_01`。左侧预览显示一个中心最亮、边缘柔和衰减的白色圆形光斑；字幕也明确说“让它使用 Circle2 的纹理”，因此这张图的重点是为新的光斑元素切换基础贴图。

当前图可确认的参数如下：

- `Global Scalar Parameter Values`
- `Desaturation = 0.0`
- `Pow = 0.7`
- `Str = 1.0`
- `Global Static Switch Parameter Values`
- `Use_Fade` 未启用
- `Global Texture Parameter Values`
- `Diff = Circle_02`

常规与材质属性：

- `Parent = M_Additive_01`
- `Blend Mode = Additive`
- `Shading Model = Unlit`

输出/预览：

- 这张图表明作者为后续新元素单独准备了一张更简单的圆形光斑材质，而不是继续使用复杂的魔法阵或破碎条带纹理。
- `Pow = 0.7` 配合 `Circle_02` 会让中心亮部保留，但边缘更快衰减，因此它适合作为轻量级的次级光斑或补充高光层。
这是 Unreal 关卡视口中的实际效果验证画面。镜头俯视角色模型，地面上能看到一个淡紫色发光底光；角色周围则分布着几段竖向和弧形的紫色能量条带，说明作者已经把前面新建的 Alpha/纹理层重新放回真实场景里观察。

当前图可确认的场景结构：

- 场景根对象：`Ex_01_SpriteExp`
- `Lighting`
- `DirectionalLight`
- `SkyLight`
- `SM_SkySphere`
- `Cine Camera Actor`
- 多个 `Ex 01 Sprite Exp` Niagara Actor
- `Floor`
- `Phase GDC`
- `PlayerStart`

输出/预览：

- 和前一张只看材质球预览不同，这张图展示的是这些圆形和条带纹理在角色脚下与周身空间中的真实布局。
- 当前效果呈现为“脚下有一层柔和圆形底光，周围有较少量、较透明的能量碎条”，说明这轮调整后新增元素并没有盖住主体，而是作为次级点缀进入场景。
- 这也验证了本段关于 Alpha、颜色、贴图的目标：把新增元素做得更轻、更短、更贴合主效果，而不是单独看起来很强。

### 00:12:02-00:14:57 Alpha、UV、PS

- 本段定位：Alpha、UV、PS。
- 知识点：抓了也是更 多了也好像提高了点饱和度 那么剩下的元素们快点加一下 我再保存一次 影前要停了有点害怕 是的保存好了 那么现在还剩几个要添加的元素。
- 知识点：就两样了 可以再加上看看 先加光源 UV break 光源反正简单就可以用 只需换个颜色就行 这里用的不要太饱和 鼠标好像不太灵敏 再TRAlpha适当改一下。
- 知识点：现在大概是这个样子 会改甚人问题吧 这部UV break 不过有点急UV break 我先说Temps Yetify似乎有些奇怪UV break。
- 知识点：这感觉就是现在的生命周期好像有点短 大概要一秒左右 先这样弄 然后最后加上元素再说 现在有什么色调亮度模糊这些都混合进去 有需要的地方再调节一下。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`生命周期`、`颜色`。

**关键画面：**

这是 `Ex_01_SpriteExp` 中新增发射器 `Empty008` 的 `Scale Color` 设置画面。左侧预览只剩一圈较弱的外环纹理，说明这层不是主体，而是更靠外围的补充层。当前图的核心是在 `Scale Color` 里同时调 RGB 颜色向量和 Alpha 曲线。

当前图可确认的系统状态：

- 激活发射器包括 `Empty`、`Empty001`、`Empty003`、`Empty004`、`Empty005`、`Empty006`、`Empty007`、`Empty008`
- `Empty002` 仍为 `Disabled`
- 当前选中发射器：`Empty008`
- 当前模块：`Scale Color`

`Scale Color` 可确认的参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 0.5, 5.0)`
- `Scale Alpha = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- 曲线在 very early 阶段从 `0` 快速升到接近 `1.0`
- 随后持续下降，到生命周期末端回到接近 `0`
- `Scale Curve = 0.5`

发射器结构当前可见：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Camera Offset`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

输出/预览：

- 这一层的 RGB 向量明显偏蓝紫，尤其第三通道被放大到 `5.0`，说明作者是在给外围层加入更冷、更亮的紫蓝色调。
- 但 `Scale Curve` 只有 `0.5`，所以虽然颜色偏亮，整体透明度依然被控制得比较弱，符合“外围补充层”的角色。
这是 `Ex_01_SpriteExp` 中发射器 `Empty002` 的 `Scale Color` 调整画面，同时左下打开了 `Signature/Course_03/Material` 目录的 `Content Browser`。从截图可见，`Empty002` 已经从此前的 `Disabled` 状态恢复为 `Active`，而且这个发射器同时包含 `Sprite Renderer` 和 `Light Renderer`，说明它被用来承载一个更简单的光斑或灯光补充层。

当前图可确认的系统状态：

- 粒子计数中 `Empty002` 已变为 `Active`
- 当前选中发射器：`Empty002`
- 当前模块：`Scale Color`
- `Render` 区域下可见：
- `Sprite Renderer`
- `Light Renderer`

`Scale Color` 可确认的参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Multiply Vector by Float`
- `Vector = (1.25, 0.5, 2.0)`
- `Float = 10000.0`
- `Scale Alpha = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- Alpha 曲线从接近 `0` 起步，随后持续上升，到末端接近 `1.0`
- `Scale Curve = 1.0`

`Content Browser` 中当前能确认的材质资源包括：

- `M_Additive_01`
- `M_Additive_01_Ins_01`
- `M_Additive_01_Ins_02`
- `M_Additive_NOMB_01`
- `M_RadialUV_01`
- `M_RadialUV_01_Ins_01`
- `M_RadialUV_01_Ins_02`
- `M_RadialUV_01_Ins_03`

输出/预览：

- 这张图说明作者在把一个旧发射器重新启用，并让它承担“简单加法光斑/灯光层”的职责。
- RGB 向量 `(1.25, 0.5, 2.0)` 依旧偏蓝紫，但 Alpha 曲线改成后段逐渐抬升，意味着这个元素不是一出生最亮，而是会在生命周期后半程更明显地出现。
这是 Unreal 关卡视口中的实际效果验证画面。镜头俯视角色，角色脚下有一枚紫色中心亮点，周围则是一圈大范围、半透明的蓝紫色能量外环；外环边缘能看到若干更亮的破口和高光节点，说明本批新增的 Alpha/纹理层已经被叠加回主效果。

当前图可确认的场景结构：

- 场景根对象：`Ex_01_SpriteExp`
- `Lighting`
- `DirectionalLight`
- `SkyLight`
- `SM_SkySphere`
- `Cine Camera Actor`
- 多个 `Ex 01 Sprite Exp` Niagara Actor
- `Floor`
- `Phase GDC`

输出/预览：

- 这张图表明当前阶段的效果重心已经从中心小花状纹理，转向“更大、更轻、更透明的外层环形扩散”。
- 角色脚下的紫色亮点和外围大环没有完全抢占同一视觉层级，说明本批对 Alpha、颜色和贴图的调节目标是成立的：让外围层更有范围感，但仍然保持次要、氛围化的角色。
- 字幕“先这样弄，最后加上元素再说”也与画面一致：当前是一个已经可用的中间版本，后面还会继续往里面叠加其他元素。

### 00:15:02-00:18:00 Multiply、Normal、粒子

- 本段定位：Multiply、Normal、粒子。
- 知识点：再做一个MTA 会制作类似于火花扩散的粒子 需要使用之前没有运动模糊的材料 也会做成原始的形式 这个MTA需要使用GPA 设置为固定的。
- 知识点：比起第一个我们试试用速率来工作 大约做1500个这个大小是随机均匀的 在25的大约13的这个非常小的大小就带来了 基本上会在球体上生成的位移。
- 知识点：向下行驶后适当往上升的感觉 在魔法阵中 粒子们燃烧并散开 会这样制作一次 像半径这些现在有100的大小 不把一次设定为一秒 因为设定为非常短的时间间隔。
- 知识点：来生成这个大约生成0.25秒 在位移上不使用钢扣曲线 如果用multiply这个图的话 原本大小就想设为100 所以在这里会进行multiply曲线处理。
- 知识点：如果用Normalize Loop Place的话 0到1是0.25秒的时长 这和上面是有点关联的 0.25秒是从0到1的标准化数值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Multiply`、`粒子`、`曲线`。

**关键画面：**

这是 `Ex_01_SpriteExp` 中新发射器 `Empty009` 的 `Sprite Renderer` 配置画面。中央 `Content Browser` 打开在 `Signature/Course_03/Material`，字幕说明“我们会使用之前没有运动模糊的材料”，因此这张图的核心是为新的 Multiply/粒子层挑选材质实例。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前模块：`Sprite Renderer`
- 粒子计数区域显示此前多个发射器已经跑完并处于 `Complete`

`Sprite Renderer` 面板当前可确认的参数如下：

- `Material = DefaultSpriteMaterial`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`

发射器结构可见为：

- `Emitter Update`
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Particle Spawn`
- `Initialize Particle`
- `Sprite Facing and Alignment`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Render`
- `Sprite Renderer`

`Content Browser` 当前可见的候选材质包括：

- `M_Additive_01`
- `M_Additive_01_Ins_01`
- `M_Additive_01_Ins_02`
- `M_Additive_NOMB_01`
- `M_RadialUV_01`
- `M_RadialUV_01_Ins_01`
- `M_RadialUV_01_Ins_02`
- `M_RadialUV_01_Ins_03`

输出/预览：

- 这张图说明 `Empty009` 还处于材质选择阶段，尚未把目标材质真正切进去。
- 结合字幕可确认后续方向是：优先选用先前“无运动模糊”的那套材质，而不是当前默认的 Sprite 材质。
这是 `Empty009` 发射器的 `Shape Location` 配置画面。左侧预览能看到一团密集的小粒子球体，粒子计数显示这一层当前约有 `1450` 个粒子，和正文里“试试用速率来工作，大约做 1500 个”基本一致。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前模块：`Shape Location`
- 粒子计数显示：`1450 Current, 1486 Max (est.) - [Empty009] [Inactive]`

发射器结构当前可见：

- `Emitter Update`
- `Emitter State`
- `Spawn Rate`
- `Particle Spawn`
- `Initialize Particle`
- `Shape Location`
- `Particle Update`
- `Particle State`
- `Render`
- `Sprite Renderer`

`Shape Location` 面板可确认的参数如下：

- `Shape Primitive = Sphere`
- `Sphere Radius = 100.0`
- `Sphere Distribution = Random`
- `Sphere Surface Distribution = 0.0`
- `Hemisphere Distribution = (1.0, 1.0)`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`

输出/预览：

- 这张图说明 `Empty009` 不是做少量大面片，而是做大量小粒子，均匀地在一个半径约 `100` 的球体范围内生成。
- 结合正文关于“非常小的大小、在球体上生成的位移”的说明，可确认这层的目标是做类似火花/碎屑扩散的基础粒子群，而不是主环本身。
这是 `Empty009` 发射器继续调整 `Shape Location` 的画面。与上一张固定 `Sphere Radius = 100` 不同，这里球形半径已经被改成“基准值乘曲线”的动态形式。左侧预览里粒子团缩成更小的中心簇；粒子计数也从前一张的一千多颗降到约 `350` 颗，说明这一层被进一步压短、压小，用于做更短命的中心扩散火花。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前模块：`Shape Location`
- 粒子计数显示：`350 Current, 369 Max (est.) - [Empty009] [Inactive]`

`Shape Location` 面板可确认的参数如下：

- `Shape Primitive = Sphere`
- `Sphere Radius = Multiply Float`
- `A = 100.0`
- `B = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 曲线前段从约 `0.2` 快速上升，到后段趋近 `1.0`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 1.0`
- `Sphere Distribution = Random`
- `Sphere Surface Distribution = 0.0`
- `Hemisphere Distribution = (1.0, 1.0)`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate = Local`
- `Offset Mode = None`
- `Shape Origin = STACKCONTEXT Position`

输出/预览：

- 这张图给出了关键实现方式：球半径不再是固定 `100`，而是 `100 × 曲线值`，并且曲线输入用的是 `EMITTER.NormalizedLoopAge`，也就是把一个很短的发射器循环时间标准化到 `0..1`。
- 这样做后，粒子的生成半径会在短时间内快速扩张，和正文里“0.25 秒非常短、0 到 1 是这段时长的标准化数值”完全一致，适合做瞬时向外炸开的火花粒子层。

### 00:18:03-00:20:50 Velocity、粒子、速度

- 本段定位：Velocity、粒子、速度。
- 知识点：通过 Add Velocity 或速度范围控制粒子运动方向和力度，必要时给最小/最大值增加随机性。
- 知识点：通过From Point 那么如果这一轴的比例增大 这个向上的速度会变强 所以缩小了这个比例 然后减少了Adapth Velocity 将速度加到2.0左右。
- 知识点：现在这里的纹理平复速度和 粒子速度匹配也很重要 在此之前这个会改成速度对齐 从锤至右边开始 适当调整一下 均匀曲线改成非均匀曲线 L值从0.5的时间开始变化。
- 知识点：X Channel只有在0时大小变小 做好就行了 然后是颜色 拿来缩放颜色 一直用了转微浮电 会有3的亮度 颜色这里再做一个图。
- 知识点：换成初始颜色 平凡的派对式强度经控制来处理 这次要调节亮度 给100左右的强度 从0.5的时机开始 这样就能让亮度渐渐下降 透明度可以让杯子这边完全消失。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Velocity`、`Add`、`纹理`、`粒子`、`速度`、`颜色`、`透明度`、`曲线`。

**关键画面：**

这是 `Empty009` 发射器继续调整 `Shape Location` 的画面。左侧预览中，小粒子不再填满整个球体，而是更集中地出现在一侧表面区域；右侧参数也显示生成方式已经从单纯球内随机，改成了更偏表面、带半球倾向的分布。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前模块：`Shape Location`
- 粒子计数显示：`350 Current, 371 Max (est.) - [Empty009] [Inactive]`

`Shape Location` 可确认的参数如下：

- `Shape Primitive = Sphere`
- `Sphere Radius = Multiply Float`
- `A = 100.0`
- `B = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 1.0`
- `Sphere Distribution = Random`
- `Sphere Surface Distribution = 1.0`
- `Hemisphere Distribution = (1.0, 0.5)`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Shape Origin = STACKCONTEXT Position`

输出/预览：

- 与上一张相比，最关键的变化是 `Sphere Surface Distribution` 被拉到 `1.0`，这意味着粒子会更多落在球壳表面，而不是填充球体内部。
- 同时 `Hemisphere Distribution` 的第二个值调到 `0.5`，说明分布被刻意压向某一侧半球，方便形成更有方向性的喷散或环形破裂感。
这是 `Empty009` 发射器在 `Particle Update` 阶段继续加模块的画面。当前弹出的 `Add new Module` 面板搜索关键字是 `spri`，作者正在从 Niagara 模块库里筛选和 Sprite 行为、速度关联的模块。结合本段主题 `Velocity、Add、速度`，这张图说明接下来要补的是粒子运动/朝向相关控制，而不是材质或生成位置。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前位于 `Particle Update` 分组
- 发射器当前结构可见：
- `Emitter Update`
- `Emitter State`
- `Spawn Rate`
- `Particle Spawn`
- `Initialize Particle`
- `Shape Location`
- `Add Velocity From Point`
- `Apply Initial Forces`
- `Particle Update`
- `Particle State`
- `Solve Forces and Velocity`
- `Scale Color`
- `Render`
- `Sprite Renderer`

右侧当前选中的模块信息：

- `Particle State`
- `Kill Particles When Lifetime Has Elapsed` 已启用

模块搜索面板中当前可见的候选项包括：

- `Sprite Based Line`
- `Spring Force`
- `Solve Float Spring Constraint`
- `Update Mesh Reproduction Sprite`
- `Align Sprite to Mesh Orientation`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Sprite Size by Speed`
- `Sprite Facing and Alignment`

输出/预览：

- 这张图能确认作者已经在 `Particle Spawn` 里放入了 `Add Velocity From Point`，并在 `Particle Update` 里保留 `Solve Forces and Velocity`，说明这一层粒子已经开始走“从点向外加速度”的扩散逻辑。
- 当前搜索结果则表明，下一步会继续补 Sprite 方向、尺寸或速度相关模块，用来让这批小粒子在飞散时的显示更合理。
这是 `Empty009` 发射器的 `Scale Color` 最终衰减设置画面。左侧预览里只能看到一些很弱的小亮点，说明这一层粒子已经被压成低可见度的火花/亮屑；右侧当前就在控制这些点随生命周期逐步变暗。

当前图可确认的系统状态：

- 当前选中发射器：`Empty009`
- 当前模块：`Scale Color`
- 粒子计数显示：`350 Current, 362 Max (est.) - [Empty009] [Inactive]`

发射器结构当前可见：

- `Emitter Update`
- `Emitter State`
- `Spawn Rate`
- `Particle Spawn`
- `Initialize Particle`
- `Shape Location`
- `Add Velocity From Point`
- `Apply Initial Forces`
- `Particle Update`
- `Particle State`
- `Scale Sprite Size`
- `Solve Forces and Velocity`
- `Scale Color`
- `Render`
- `Sprite Renderer`

`Scale Color` 可确认的参数如下：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Multiply Vector by Float`
- `Vector = (3.0, 3.0, 3.0)`
- `Float = Float from Curve`
- 曲线数据源为 `Curve for Floats`
- 输入轴为 `PARTICLES.NormalizedAge`
- 曲线从前段接近 `1.0` 开始线性下降，到末端接近 `0.0`
- `Scale Curve = 100.0`
- `Scale Alpha = 1.0`

输出/预览：

- 这一步没有再做复杂颜色偏移，而是把 RGB 三个通道统一为 `(3, 3, 3)`，再用一条递减曲线去控制整体亮度。
- 字幕“这样就能让亮度渐渐下降”与设置完全一致：这批小粒子出生时足够亮，随后持续衰减，但 Alpha 不单独衰减，因此主要是“发光强度变弱”，而不是粒子突然消失。

### 00:21:07-00:23:52 Alpha、速度、颜色

- 本段定位：Alpha、速度、颜色。
- 知识点：这里就直接做一个颜色 用限量4以外的方式 像规模颜色一样做结构来用 这里只需用限量曲线控制即可 这里也可以用年龄化循环来写 Alpha似乎不用单独处理。
- 知识点：的蓝色通道大约设为5 整体时机设为0.5 开始大约是0.5 其实数指用这个颜色 最后蓝色指为1 绿色通道是0.1 零值会完全失去饱和度。
- 知识点：0.1的红色大约为0.3 有一点混合紫色的感觉 让颜色适当混合一下 那么在0.25秒快结束时出现的那些 就会带着这种颜色出生。
- 知识点：前半段0.5时机大约是0.125秒 那么到那个时机生成的东西 是的 这里会有那个时机带着这种颜色生成。
- 知识点：现在要调整张力 用比例平衡速度规模速度 规模速度规模速度 为了单独控制Z轴 这里现在是做成Make for Mector 在做Make vector之前。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`速度`、`颜色`、`曲线`。

**关键画面：**

这一帧展示 `Ex_01_SpriteExp` 的发射器 `Empty009` 正在补颜色控制模块。当前操作是在 `Particle Update` 分组点击加号，搜索 `col`，从结果里选择 Niagara 模块 `Color`，用于给后续颜色/透明度随生命周期变化提供单独控制入口。

右侧细节面板同时展示了现有 `Scale Color` 模块的关键设置，可作为本段参数参考：

- `Color` 使用 `Multiply Vector by Float`，三个通道当前都为 `3.0`，表示整体亮度被同步放大。
- `Alpha` 使用 `Float from Curve`。
- 上方曲线的索引是 `Particles.NormalizedAge`，`Curve` 数值显示为 `100.0`，曲线形态为前段迅速抬高、随后持续衰减到接近 0。
- 下方另一条曲线同样以 `Particles.NormalizedAge` 为索引，`Scale Curve` 显示为 `1.0`，Alpha 曲线从约 `0.8` 起步并逐步下降到接近 `0`。

复建时可先在 `Particle Update` 中补上 `Color`/颜色缩放相关模块，再按图中两条生命周期曲线分别控制亮度衰减和透明度衰减，使精灵在前期更亮、后期逐渐淡出。
这一帧进入 `Empty009` 的 `Color` 模块参数设置，目标是让粒子颜色随循环时间逐步去饱和并减弱蓝色占比。模块结构如下：

- `Color` = `Make Linear Color from Vector and Float`
- `Vector (RGB)` = `Vector from Curve`
- `VectorCurve` = `Curve for Vector3's`
- `Float (Alpha)` = `1.0`

图中可确认的曲线设置如下：

- `CurveIndex` 使用 `[Emitter] NormalizedLoopAge`，说明颜色变化按发射器循环时间推进，而不是按单粒子年龄推进。
- `X`（红色）曲线基本保持常量，末段仍维持在约 `1.0`。
- `Y`（绿色）曲线前半段保持在约 `1.0`，后半段下滑到 `0`，用于逐步去掉绿色分量。
- `Z`（蓝色）曲线前半段保持在较高值，左下曲线视图显示起点大约在 `5`，后半段下降到约 `1` 左右，使前期蓝紫光更亮、后期蓝光减弱。

预览窗口里粒子呈蓝紫色圆环，与这组曲线一致：前段保留较强蓝色和一定绿色，后段绿色先被压掉，整体更接近偏蓝紫并逐渐失去饱和度。复建时按该思路设置三通道曲线即可。
这一帧展示在 `Empty009` 的 `Particle Update` 中继续加入 `Scale Velocity`，用于限制粒子后续运动方向和衰减方式。当前图可确认的模块设置如下：

- 模块名：`Scale Velocity`
- `Coordinate Space`：`Local`
- `Velocity Scale`：`Multiply Vector by Float`
- 其中 `Vector` 输入来自 `Make Vector`
- `Make Vector` 当前数值为 `X = 1.0`、`Y = 1.0`、`Z = 0.0`

这组参数的直接含义是：保留本地空间内的 X/Y 平面速度缩放，Z 方向不再额外放大，避免粒子在这一阶段继续获得向上的速度增益。右侧已打开动态输入选择面板，说明教程此时正在准备给 `Scale Velocity` 的某个输入补一个 Niagara 动态值，但从当前帧只能可靠确认到模块结构和 `Make Vector(1,1,0)` 这一层。

复建时可先在 `Particle Update` 中插入 `Scale Velocity`，把坐标空间切到 `Local`，再把方向向量设为 `(1, 1, 0)`，让速度缩放主要作用在平面扩散上。

### 00:24:07-00:27:02 UV、速度、曲线

- 本段定位：UV、速度、曲线。
- 知识点：其实值大约有5的速度 适当一点 适当一点 只适当一点 没改过生涯时间吧 UV Brake没改过生涯时间吧 UV Brake没改过生涯时间吧 LV。
- 知识点：Brake生涯时间随意找找 在0.8到1.3之间 然后现在随着时间推移 向外扩散并往上升 但调整Z轴曲线 UV Brake Z轴曲线也得调。
- 知识点：3轴曲线也得调 UV Brake从L值开始 最后到5左右 然后往后面走 然后上升的值要大一些 那就会有点这种动感 UV Brake 那就会有点这种动感。
- 知识点：UV Brake 然后这里就会加上卷曲噪声 嗯 看到了吗 现在尺度变大了 适当用力一点 这里也加上Dribe 防止太扩散 防止太扩散 这里适当用力一点。
- 知识点：让它分散 例子 这种感觉 我来做 存在奇怪的事 这里放的 这个扭曲效果现在没有显示出来呢 UV Brake 我们来确认一下这个部分 我们来确认一下这个部分。
- 核对对象：`速度`、`曲线`、`噪声`。

**关键画面：**

这一帧回到 `Empty009` 的 `Initialize Particle`，主要是在核对基础生命周期与精灵尺寸，供后面的速度和噪声调节建立统一初始条件。当前图里可确认的设置如下：

- 模块：`Initialize Particle`
- `Lifetime Mode`：`Direct Set`
- `Lifetime`：`5.0`
- `Color Mode`：`Unset`
- `Position Mode`：`Simulation Position`
- `Sprite Size Mode`：`Random Non-Uniform`
- `Sprite Size Min`：`X = 2.0`，`Y = 5.0`
- `Sprite Size Max`：`X = 1.0`，`Y = 3.0`
- `Sprite Rotation Mode`：`Unset`
- `Sprite UV Mode`：`Unset`

左下角曲线编辑区显示一条名为 `FloatCurve` 的单通道曲线：前半段保持在约 `5`，随后持续下降并在末端落到 `0`。从画面能确认教程此时在对照“生命周期是否仍为 5 秒”这一基准值，并检查某个浮点参数是否按时间从高值衰减到 0；但当前帧没有明确显示该曲线绑定到哪个具体模块输入，因此复建时应先保证 `Initialize Particle` 的 `Lifetime = 5.0` 和随机非均匀尺寸范围与图中一致。
这一帧开始给 `Particle Update` 增加卷曲噪声扰动，当前选中的模块是 `Curl Noise Force`。图中可以直接确认的参数如下：

- 模块：`Curl Noise Force`
- `Noise Strength`：`10.0`
- `Noise Frequency`：`50.0`
- `Noise Quality / Cost`：`Baked (Medium)`
- `Pan Noise Field`：`0.0, 0.0, 0.0`
- `Mask Curl Noise`：未勾选

左下曲线编辑区显示一条 `FloatCurve`，形状是从起点约 `1.0` 持续上升，在末端抬到约 `5.0`。结合本段“尺度变大、加上卷曲噪声、防止太扩散”的语义，可把它理解为教程正在核对某个随时间增强的浮点控制量，但当前帧没有显示该曲线具体挂接到 `Curl Noise Force` 的哪个输入口，因此这里只能可靠记录为“存在一条从 1 到 5 的上升曲线参考”。

复建时可先在 `Particle Update` 中插入 `Curl Noise Force`，按图中数值设置噪声强度和频率，再根据后续帧决定这条上升曲线是否接到噪声强度、速度缩放或其他动态输入。
这一帧已经打开材质实例参数面板，当前可见的是一个以 `M_RadialUV_01` 为父材质的实例，用于调整法线、折射和透明度相关贴图参数。图中可确认的设置如下：

- 父材质：`M_RadialUV_01`
- 顶部标量参数：
  - `A = 1.0`
  - `Edge_Pow = 1.0`
  - `Edge_Str = 1.0`
- `Global Scalar Parameter Values`
  - `Refraction_Str = 2.0`
- `Global Static Switch Parameter Values`
  - `Use_Refraction`：启用
- `Normal`
  - `Normal_Tex = Normal_06`
  - `Normal_Tile_U = 4.0`
  - `Normal_Tile_V = 0.5`
- `Opacity`
  - `Fade_Dist = 1.0`
  - `Mask_Str = 5.0`
  - `Mask_Tex = T_CircleGra_01`
  - `Opacity_Pow = 1.25`
  - `Opacity_Str = 30.0`
  - `Opacity_Tex = T_Ribbon_04`
  - `Opacity_Tile_U = 3.0`
  - `Opacity_Tile_V = 0.5`

左侧视口几乎没有明显预览结果，只能看到材质编译统计信息，说明当前主要是在通过实例参数微调视觉表现，而不是展示节点图连接。复建时可先按以上数值配置同名或等价的材质实例，再在后续材质段继续核对更细的纹理和混合关系。

### 00:27:13-00:30:13 材质、纹理

- 本段定位：材质、纹理。
- 知识点：现在下面的是可以显示的呢 因为使用相同的材质 两者都应该出现的情况 等一下 看看这现在不出现的原因 我们制作材质时。
- 知识点：反射总是需要那个折射方向 这个要和正在使用的发现纹理连接 需要这样就能出现 所以在主材质中修改这部分。
- 知识点：应该就能出现 那么刚才修改的数值改为1.3 然后再次 也去掉side 所以刚才下面那个结果是 这个facing和这里一轴固定出来的结果吧。
- 知识点：去掉facing的话就没出现这种情况了 适当有点进去 可以适当再用力一些 这个可以按个人喜好调整 只要感觉不太过就没关系 然后现在也这样结束。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`。

**关键画面：**

这一帧在 Niagara 里选中了发射器 `Empty001` 的 `Sprite Renderer`，重点是在确认该发射器与前面效果共用同一套材质实例。图中可直接确认的渲染器设置如下：

- 发射器：`Empty001`
- 模块：`Sprite Renderer`
- `Material = M_RadialUV_01_Ins_02`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UV Radius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`
- `Cast Shadows`：已启用
- `Sort Order Hint = 10`
- `Motion Vector Setting = Auto Detect`

左侧预览窗口显示该材质已形成紫色能量花状纹理；左下曲线编辑区仍可见一条 `FloatCurve`，形状从约 `1` 逐渐抬升到约 `5`，但当前帧没有显示它绑定到哪个具体输入，因此这里只把它视作本段仍在沿用的时间曲线参考，不把它强行归到 `Sprite Renderer` 参数。
这一帧打开的是主材质 `M_RadialUV_01` 的材质图，画面聚焦在折射输出区域。当前帧能可靠确认的节点结构如下：

- 输出材质节点：`M_RadialUV_01`
  - 可见输出口包括 `Emissive Color`、`Opacity`、`Normal`、`World Position Offset`、`Refraction (Index Of Refraction)`。
- 参数/节点：
  - `Fade_Dist`，默认值 `50.0`
  - `Refraction_Str`，默认值 `1.05`
  - `Use_Refraction`，`Switch Param (False)`
  - 一个 `Lerp`
  - 多个 `Multiply`
  - 一个常量 `1.0`
  - 一个常量 `3.0`
  - `Particle Color`

当前帧中可确认的连接关系：

- 上方一条白线经过 `Multiply` 后接入材质输出的 `Emissive Color`。
- `Particle Color` 的一条输出线也参与了通向 `Emissive Color` 的乘法混合。
- 下方一条链路通过 `Multiply` 与 `Fade_Dist`、常量 `3.0`、常量 `1.0`、`Refraction_Str`、`Lerp` 和 `Use_Refraction` 组合，最终接到材质输出的 `Refraction (Index Of Refraction)`。
- `Use_Refraction` 的 `True/False` 选择结果直接送入 `Refraction` 输出，说明主材质可以通过静态开关决定是否启用折射。

左侧 `Details` 面板搜索了 `ref`，可见当前材质设置为：

- `Refraction Method = Index Of Refraction`
- `Refraction Coverage Mode = Coverage Accounted For`
- `Refraction Depth Bias = 0.0`

复建时应把折射链路理解为“先生成一条受 `Fade_Dist` 和 `Refraction_Str` 控制的标量，再通过 `Use_Refraction` 静态开关决定是否把该结果写入 `Refraction` 输出”。当前帧不足以可靠确认每一根输入线的精确来源，因此不继续猜测未完整露出的上游节点。
这一帧是材质与纹理调整后的场景验证结果。画面中角色站在效果中心，周围已经形成一圈向上包裹的半球形能量护罩，顶部和两侧分布不连续的紫蓝色电弧纹理，证明前面调整的材质实例、折射与透明度贴图已经开始共同起效。

从结果图可直接确认的视觉特征：

- 护罩整体不是完整实心球壳，而是由半透明弧面加局部高亮电弧组成。
- 电弧主要集中在护罩上半圈和左右两侧，边缘呈锯齿状、闪电状扭曲。
- 护罩内部和角色脚下有明显的紫色辉光，地面上还能看到与护罩边界对应的淡紫色投影/折射痕迹。
- 整体颜色以冷紫、蓝紫为主，亮度集中在电弧边缘，说明材质的 `Emissive` 和折射并没有被压得过弱。

这张图的作用是做最终观感验收：如果复建后的结果也能在角色周围出现这种“半透明弧面 + 局部电弧 + 地面紫色辉光”的护罩效果，并且强度不过分刺眼，就说明本段材质与纹理调整方向基本正确。

### 00:30:16-00:33:11 UV、粒子、颜色

- 本段定位：UV、粒子、颜色。
- 知识点：传播的有点跟着出来了 那么这里我们提前设置好的帖子 开启一下吧 UV break 在检查音乐会上把相机摇晃的部分静音关掉 然后这个部分也静音了。
- 知识点：就这程度 是的 这样看一下UV break 调整好 整体构成看来都挺匹配的 如果这里有想更强调的部分 可以更强调那部分 要不要适当整理一下仪器呢。
- 知识点：可以现在对相机进行固定了 在训列器中叫我 需要再加点力 把灯光的颜色饱和度降低一些 粒子亮度也可以再加大一些。
- 知识点：还有这里外扩的部分 颜色亮度可以再快一点扩散 还有现在这个部分可以亮一点 这样做的话。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`颜色`。

**关键画面：**

这一帧是 `UV、粒子、颜色` 段开头的场景结果检查图。画面中前一段的半球护罩已经不再显示，只剩角色周围大范围分布的稀疏白色小亮点粒子，用来观察外扩粒子的密度、覆盖范围和亮度是否合适。

从当前帧可直接确认的结果特征：

- 角色位于画面中央，地面是大面积棋盘格测试场景。
- 粒子以极小的白色发光点形式分散在角色四周，分布范围远大于角色本体，占据了左右两侧和远处背景。
- 粒子整体非常稀疏，没有形成连片体积，也没有明显的拖尾或护罩轮廓。
- 当前亮度较低，画面主体仍是角色和地面阴影，符合“还需要再加点力、粒子亮度可以再加大一些”的语义。

这张图的用途是校验外扩散点层是否已经建立，以及它当前是否过暗、过散。复建时如果得到的也是这种“角色周围零散分布的小亮点粒子”而不是成片面状特效，就说明本段的粒子层级方向基本对了，后续再通过颜色和亮度把重点部分提出来。
这一帧是从上方俯视的近景结果图，用来检查各层粒子和材质已经叠加后的整体构成。当前画面可以直接分出三层主要视觉元素：

- 最外层是一个不规则的圆形/花瓣状护罩边缘，主色为蓝紫，外沿带一圈偏橙粉的高亮描边，边缘起伏明显，像被噪声扭曲过的电浆膜。
- 中间层是围绕角色分布的一圈高密度紫白色亮点粒子，形成接近圆环的散点带。
- 最内层是角色脚下与身体中心附近的高亮紫色核心区域，并伴随向外发散的细长亮线。

从结果上能确认的观感要点：

- 外圈护罩已经比上一段更亮、更饱和，边缘轮廓被明显强调出来。
- 内圈散点粒子不再是大范围稀疏散布，而是收束成围绕角色的一圈高亮粒子带。
- 中心亮斑、放射线和外圈护罩之间没有完全断开，说明颜色与亮度节奏已经开始统一。

这张图适合作为“整体构成都挺匹配”的验收参考：复建结果应同时出现外圈半透明高亮壳层、内圈密集亮点粒子，以及中心紫色能量核。如果只出现其中一层，说明粒子或颜色层级还没叠完整。
这一帧选中的是发射器 `Empty010` 的 `Scale Color` 模块，目标是把“这个部分再亮一点”。当前图可确认的模块结构与参数如下：

- 发射器：`Empty010`
- 模块：`Scale Color`
- `Scale Mode = RGB and Alpha Separately`

`Scale RGB` 分支：

- 表达式：`Multiply Vector by Float`
- `Vector = (2.0, 2.0, 3.0)`，说明蓝通道额外更强
- `Float = Float from Curve`
- 曲线类型：`Curve for Floats`
- `CurveIndex = [Particles] NormalizedAge`
- `Scale Curve = 3.0`
- 曲线形态：起点接近 `0.8`，随后持续下降，到生命周期末端接近 `0.1`

`Scale Alpha` 分支：

- 表达式：`Float from Curve`
- 曲线类型：`Curve for Floats`
- `CurveIndex = [Particles] NormalizedAge`
- `Scale Curve = 10.0`
- 曲线形态：前段基本保持在接近 `1.0`，随后快速下滑，末端降到 `0`

左下曲线编辑区还显示一条从约 `1` 上升到 `5` 的 `FloatCurve` 参考，但当前帧主面板没有把它直接绑定到 `Scale Color` 的可见输入，因此不把这条曲线并入本模块参数结论。

复建时可按这张图把 `Empty010` 的颜色控制做成“蓝色稍强、亮度前高后低、透明度末端快速归零”的节奏。这样能把局部粒子在生命周期前半段提亮，并在后半段干净地消失。

### 00:33:18-00:36:11 UV、速度、颜色

- 本段定位：UV、速度、颜色。
- 知识点：这个程度 UV break 给300左右看看吧 UV break 给300左右看看吧 给300左右看看吧 UV break 纹理加载的不太好吧。
- 知识点：纹理加载的不太好吧 颜色300有点强 颜色有点强 纹理加载 有点太好笑 纹理加载的不太好像 然后这一部分现在 纹理好像加载不太顺利。
- 知识点：纹理好像加载不太顺利 还有正常力度 给的再强一点可能会更好 感觉更强的话会更明显 起伏走了 推的山与运动 正常扭曲的力量更强了 感觉扩散速度也快了点。
- 知识点：光线颜色的饱和度掉的太多了 适当慢慢地涂一下面板 在这个状态下刚才减少了颜色 这里用力一些怎么样 然后。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`速度`、`颜色`。

**关键画面：**

这一帧选中的是发射器 `Empty009` 的 `Color` 模块，当前正在细调护罩主层的颜色节奏。图中可确认的结构和参数如下：

- 发射器：`Empty009`
- 模块：`Color`
- `Color = Make Linear Color from Vector and Float`
- `Vector (RGB) = Vector from Curve`
- `VectorCurve = Curve for Vector3's`
- `Float (Alpha) = 1.0`

RGB 曲线设置：

- `CurveIndex = [Emitter] NormalizedLoopAge`
- `Scale Curve = (1.0, 1.0, 1.0)`
- `X`（红色）曲线全程接近低值，前后变化很小。
- `Y`（绿色）曲线同样接近低值，并在后半段略微下降。
- `Z`（蓝色）曲线起点约在 `5` 左右，随后持续下降，到末端接近 `1`，是三通道里变化最明显的一条。

从左侧预览可见，护罩主体仍保持蓝紫色外观，说明这一组曲线的主要作用是随着循环推进逐步削弱蓝色强度，让颜色从高亮蓝紫过渡到更暗、更接近中性紫色，而不是重新改写整体色相。

左下角还显示一条从约 `1` 抬升到 `5` 的 `FloatCurve` 参考，但当前右侧面板没有把它显示为 `Color` 模块的直接输入，因此不把它并入当前结论。
这一帧选中的是发射器 `Empty001` 的 `Dynamic Material Parameters`，正在调护罩材质的纹理滚动透明度和扭曲强度。当前图里可确认的参数如下：

- 发射器：`Empty001`
- 模块：`Dynamic Material Parameters`
- 页签：`All`
- `Write Parameter Index`：已启用

可见的动态参数：

- `Opacity_VPan = Float from Curve`
  - 曲线类型：`Curve for Floats`
  - `CurveIndex = [Particles] NormalizedAge`
  - `Scale Curve = 1.0`
  - 曲线形态：起点约 `0.5`，随后持续下降，到末端接近 `0`
- `Distortion = Float from Curve`
  - 曲线类型：`Curve for Floats`
  - `CurveIndex = [Particles] NormalizedAge`
  - `Scale Curve = 1.0`
  - 曲线形态：从接近 `0` 持续上升，到末端约 `0.05`
- `ColorPow = 1.0`
- `Param3-0` 当前值 `0.0`

这组参数表达的节奏很明确：

- `Opacity_VPan` 随粒子年龄递减，说明透明度贴图的纵向滚动/影响强度会逐渐减弱。
- `Distortion` 随粒子年龄递增，说明后半段的扭曲感会更明显。

左侧预览中的护罩边缘仍在翻卷，和这组“透明滚动减弱、扭曲逐步增强”的曲线变化一致。复建时可以先把这两个动态参数按图中曲线接好，再根据实际观感微调起点和终点强度。
这一帧是本段 `纹理`、`速度`、`颜色` 调整后的场景结果图。与前面的验证帧相比，当前画面的亮度和边缘强调都进一步增强，说明教程此时正在确认“颜色减少后，局部再用力一些”是否成立。

从结果图可直接确认的视觉变化：

- 外层护罩壳体的蓝紫主体更亮，顶部和底部的半透明弧面更容易读出来。
- 护罩外沿的橙粉色高亮描边更明显，形成清楚的冷热对比边界。
- 中心区域的紫白色散点粒子密度和亮度都偏高，构成一个更明显的内圈光核。
- 从中心向外的辐射状亮纹更清晰，说明速度/纹理推进带来的拉伸感被强化了。
- 角色仍站在中心，但整体视觉重心已经从人物本体转移到护罩和能量核本身。

这张图可作为这一段的验收参考：如果复建后的效果也表现为“外圈高亮护罩更厚、更亮，中心粒子核更明显，边缘带橙粉描边”，就说明颜色和纹理强度调整方向基本正确；如果画面仍显得发灰、轮廓不清，通常意味着颜色增益或扭曲/滚动强度还不够。

### 00:36:24-00:38:28 Niagara、速度、纹理

- 本段定位：Niagara、速度、纹理。
- 知识点：这可能是个人喜好的问题 更细致的部分最好自己调整一下 另外就是太鲜明了 是的 所以在 视觉上或者说设计上某个部分 不能突出 整体看起来像一个东西。
- 知识点：是最重要的 然后 在设计方面 所以我现在看到的这个 就是我在录制的时候 因为现在实时出来了 所以有点真驱动 然后 打开尼亚结发中口时 真驱动会更严重。
- 知识点：需要对此部分考虑很多 这一部分性可谓一直编一会不放 考虑这些部分 关掉尼亚加拉后这个速度会显示为。
- 知识点：原本剧快的 所以考虑这些部分 个人觉得可以做得更完整一些 嗯 是 所以在这个例子中现在用另一个感觉 应用它非常重要 就是我每次 就是都说 还有怎么说这条线本身现在是。
- 知识点：作为副本使用的这个 纹理有一点主打的感觉 不管怎样这条线的部分 和这个副本带入那种 波长的感觉 就是真的是 然后如果能很好一起合的话 然后那么目标是大家能一起看一下。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`纹理`、`速度`。

**关键画面：**

这一帧是 `Niagara、纹理、速度` 段末尾的整体结果检查图。画面中的护罩已经不再是高耸的半球，而是压低成贴近地面的低矮弧面壳层，同时叠加大量上浮的亮点粒子，用来检查各层纹理和速度是否已经协调。

从当前帧可直接确认的视觉结果：

- 角色位于中心，脚下有一团紫色地面辉光。
- 护罩主体呈扁平化的环形/花瓣状弧面，整体高度较低，更贴近地面展开。
- 壳层表面仍能看到浅蓝紫色的翻卷纹理和局部亮边，但比前几帧更轻、更透明。
- 大量白紫色亮点粒子分布在壳层边缘和上方空间，形成“外圈环绕 + 局部上浮”的节奏。
- 粒子与壳层没有完全分裂成两套效果，而是共同构成一个整体轮廓，符合“整体看起来像一个东西”的语义。

这张图适合作为整体协调性的验收参考：复建结果应表现为低矮的环形护罩加零散上浮亮点，而不是单独只剩壳层或只剩粒子。若某一层过于突出，通常就会破坏这里强调的统一感。
这一帧把护罩主体基本拿掉，只留下副层亮点粒子，作用是单独观察这组粒子的速度感和分布完整性。当前画面可直接确认的结果如下：

- 角色站在中心，周围只剩少量蓝白色小亮点。
- 粒子分布不是均匀圆环，而是偏稀疏、带有局部聚集和空隙，整体更像自然散开的碎光。
- 有些粒子位于角色周围近处，有些已经漂到更远的位置，说明它们存在明显的向外扩散和上浮趋势。
- 失去护罩和大面状材质后，这一层看起来更容易暴露“速度过快或过慢”的问题，这和正文里提到的需要考虑速度显示是否合理一致。

这张图适合做单层粒子验收：如果复建时关闭主体壳层后，也能看到这种围绕角色散开的零星小亮点，并且分布看上去既不是完全静止也不是瞬间飞散失控，就说明这层粒子的基础速度节奏大体正确。
这一帧是本段收尾时的最终结果检查图。主体壳层已经完全隐藏，只留下围绕角色展开的一圈大范围亮点粒子，重点是在确认“副层线条/波长感”是否足以单独成立，并且能作为完整例子的结尾效果。

从当前帧可直接确认的结果：

- 粒子整体分布成一个很大的环状范围，远大于角色本体。
- 环的边缘由许多蓝白色小亮点构成，局部更密、局部更疏，不是机械均匀圆周。
- 仍有一部分粒子漂浮在环的内部和上方，说明这层不只是平面圆环，还保留了空间高度变化。
- 角色脚下保留一小块紫色中心辉光，但视觉主角已经变成外围的亮点结构。

这张图可视为“第一个例子完成前的最终单层验收”：

- 如果复建后的外围粒子能形成这种大尺度、近似环形但不绝对规整的分布，就说明速度、纹理节奏和副层粒子密度已经比较接近成片效果。
- 如果结果只剩零散点、看不出环状组织，通常意味着副层粒子的空间分布或速度方向还没有整合好。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


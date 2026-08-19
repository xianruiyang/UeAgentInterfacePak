# 15-2 制作Niagara粒子

# 15-2 制作Niagara粒子

## 关键术语

- `Emitter`、`Velocity`、`Color`、`Alpha`、`CPU`、`Material`、`UV`、`Curve`、`材质`、`Niagara`、`Particle`、`Normalized Age`、`纹理`、`贴图`、`粒子`、`系统`、`Niagara System`、`Spawn Rate`

## 分段知识

### 00:00:00-00:04:36 速度、颜色

- 本段定位：速度、颜色。
- 知识点：部分会适当放大亮度 亮度放大到这个程度 还有这里闪电的爆炸部分 颜色值适当调高一点 好像感觉不到力道 谢谢 再多一点 不过相比刚才的话 昨天也确实进展不错。
- 知识点：大小再大一点试试看 不能太大 这样先做一下 然后再适当添加其他颜色 试着调整一下 把光线适当调强一点也不错 这里也试着 先添加烟雾 现在烟雾适当扩散得有点窄。
- 知识点：这个适当扩散得宽一些 音调也适当调整成 合适的音调 圆圈的大小适当放大一点 然后数量也需要 适当增加一下 增加到大约35个 然后速度保持不变 而是需要适当提高 缩放值。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`、`烟雾`、`闪电`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: p22 开头关卡预览与亮度调整提示
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara Editor overlay + 字幕
> - 所属: `04_Thunder_Explosion` 关卡与 `Exp_01 / Black_01002`。
> - 目的: 记录 p22 开始时对爆炸亮度和双手光效进行进一步加强前的关卡状态。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色位于棋盘格地面中央，身体前倾。
> - 一侧手部附近有明显蓝白光点，身体和地面附近有少量蓝白粒子散点。
> - 地面可见角色阴影和较弱蓝色光照。
>
> Content Browser / Outliner:
> - Content Browser 位于 `Mesh` 目录，`SM_1` Static Mesh 被选中。
> - 同目录可见 `Circle_03`、`Half_...`、`SM_FX_...`、`SM_Ice` 等 Static Mesh。
> - Outliner 中可见 `04_Thunder_Explosion (Editor)`、`DirectionalLig...`、`01_Swing_Trail`、`Cine Camera Ac...`、`Exp 01`、`Floor`、`PlayerStart`。
>
> Niagara Editor overlay:
> - 底部覆盖窗口为 `Exp_01`。
> - Details Owner 显示为 `Black_01002`。
> - System Overview 与参数区域被窗口裁切，具体字段不补写。
>
> 字幕:
> - 字幕为“亮度放大到这个程度”。
>
> 画面含义: 该帧记录 p22 继续在 p21 爆炸效果基础上调整亮度，当前关卡预览以双手光点、身体粒子散点和地面蓝光为主要可见结果。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的加强后圆顶闪电爆炸
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara Editor overlay
> - 所属: `04_Thunder_Explosion` 关卡与 `Exp_01 / Black_01001`。
> - 目的: 复核亮度/颜色加强后，角色周围圆顶闪电爆炸的可见效果。
>
> Level Viewport:
> - 角色位于圆顶状半透明爆炸中心。
> - 圆顶范围内可见大量白色闪电裂纹和蓝白发光。
> - 双手附近各有强烈蓝白光球。
> - 角色身体和地面附近有蓝色光照，周围有少量小粒子。
>
> Content Browser / Outliner:
> - Content Browser 仍在 `Mesh` 目录，`SM_1` Static Mesh 被选中。
> - Outliner 中 `Exp 01` 仍在 `04_Thunder_Explosion` 关卡下。
>
> Niagara Editor overlay:
> - 底部覆盖窗口为 `Exp_01`。
> - Details Owner 显示为 `Black_01001`。
> - Preview 计数和 Overview 区域仅部分可见，不补写被遮挡字段。
>
> 画面含义: 该帧记录亮度/颜色调高后的强表现阶段，主要可见圆顶闪电壳体、双手光球和角色周围蓝白光照。
> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Add Velocity` 烟雾扩散参数
> - 组成部分: Niagara Preview + System Overview + Add Velocity Details + Curves + Timeline + 字幕
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 为烟雾 emitter 增加从点向外的速度，并用偏移控制烟雾扩散起点。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见白色环状/圆盘亮部，左右两侧有浅灰烟雾团。
> - `Smoke_01` 显示 `35 Current, 35 Max (est.)`，状态 Active。
> - `Glow_01`、`Light_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Active。
> - `Debris_01002`、`Debris_01003`、`RadialBlur_01` 显示 Disabled。
>
> System Overview / Stack:
> - 系统为 `Exp_01`。
> - `Smoke_01.Add Velocity` 被选中。
> - `Smoke_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Shape Location Ring / Disc`、`Add Velocity`、`Particle State`、`Sub UVAnimation`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
>
> Details:
> - Owner: `Smoke_01.Add Velocity`。
> - `Velocity Mode = From Point`。
> - `Velocity Speed = 100.0`。
> - `Constrain To Radius = 0.0`。
> - `Velocity Origin` 显示命名空间按钮 `ENGINE`、`EMITTER`，右侧为 `Simulation`。
> - `Origin Offset = 0.0, 0.0, 20.0`。
> - `Origin Offset Coordinate = Local`。
>
> Curves / Timeline:
> - 左下曲线面板可见一条红色上升曲线，从约 `0.5` 上升到约 `1.5`。
> - Timeline 当前时间约 `1.44` 秒，显示 `347 of 2400`。
>
> 字幕:
> - 字幕为“而是我会稍微提高缩放值”。
>
> 画面含义: 该帧记录 `Smoke_01` 使用 `From Point` 速度和 `Origin Offset=(0,0,20)` 让烟雾向外扩散；截图仅记录 Details 中的 Local 字段，不额外断言效果所处坐标系。

### 00:04:36-00:09:27 关键流程 02

- 本段定位：关键流程 02。
- 知识点：需要调整这个冲击波 如果能传播出去就好了 色调为0.1 0.9 1.2 适当有点灰的感觉 改成随机雨的喷流适当减小α 因为出了一些太黑的 容器这个先去掉。
- 知识点：我觉得这种烟雾会更好 谢谢 这个色调原来是1的值 需要提高α值 感觉有点无力 而且前面似乎看不到很多灰尘 需要适当提高一些设置 现在大致整理好了。
- 知识点：在这里可以开启host 一起试试 host只需适当修改一下大小即可 我也会适当增加偏移值来使用 不过黑色调似乎有点深 需要适当减小黑色调。
- 知识点：这个消息降落在 角色前面 道明泰的外国汇况 适当角色更清晰的 适当转一下 通过演示 我适当转一下 通过演示 前面皱皱的部分是适当少一些的部分。
- 核对对象：`烟雾`、`冲击波`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Smoke_01.Scale Velocity` 速度衰减曲线
> - 组成部分: Niagara Preview + System Overview + Scale Velocity Details + Curves + Timeline + 字幕
> - 所属: `Exp_01 / Smoke_01`。
> - 目的: 让烟雾/冲击波初期向外传播后逐渐减速。
>
> Niagara Preview / Particle Counts:
> - Preview 当前大部分为空，仅有较暗的灰蓝烟雾残影。
> - `Smoke_01` 显示 `35 Current, 35 Max (est.)`，状态 Inactive。
> - `Glow_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002` 显示 Complete。
> - `Light_01` 与 `Mesh_01` 显示 Inactive。
> - `Debris_01002`、`Debris_01003`、`RadialBlur_01` 显示 Disabled。
>
> System Overview / Stack:
> - `Smoke_01.Scale Velocity` 被选中。
> - `Smoke_01` Stack 中 `Add Velocity` 位于 Particle Spawn，`Scale Velocity` 位于 Particle Update。
> - `Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` 均可见并启用。
>
> Details:
> - Owner: `Smoke_01.Scale Velocity`。
> - `Coordinate Space = Local`。
> - `Velocity Scale` 模式为 `Multiply Vector by Float`。
> - Vector 值为 `1.0, 1.0, 1.0`。
> - Float 使用 `Float from Curve`。
> - Curve for Floats 使用 `PARTICLES NormalizedAge`。
> - 曲线从约 `10` 快速下降，末端接近 `0`。
> - `Scale Curve = 1.0`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示同一条从 `10` 下降到接近 `0` 的红色曲线。
> - Timeline 当前时间约 `1.33` 秒，显示 `319 of 2400`。
>
> 字幕:
> - 字幕为“如果能传播出去就好了”。
>
> 画面含义: 该帧记录 `Smoke_01` 通过 `Particles.NormalizedAge` 曲线把速度从较高值快速衰减，用于形成短暂向外传播的烟雾/冲击波。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的烟雾整理后状态
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara Editor overlay
> - 所属: `04_Thunder_Explosion` 关卡与 `Exp_01 / Mesh_01`。
> - 目的: 在关卡视角复核烟雾和闪电爆炸整理后的整体清晰度。
>
> Level Viewport:
> - 角色位于棋盘格地面中央，身体前倾。
> - 身体周围可见少量蓝白粒子散点。
> - 强圆顶和双手光球基本消退，地面仍有轻微蓝色光照。
> - 角色阴影清晰可见。
>
> Content Browser / Outliner:
> - Content Browser 位于 `Mesh` 目录，`SM_1` Static Mesh 被选中。
> - Outliner 可见 `04_Thunder_Explosion (Editor)`、`DirectionalLig...`、`01_Swing_Trail`、`Cine Camera Ac...`、`Exp 01`、`Floor`、`PlayerStart`。
>
> Niagara Editor overlay:
> - 底部覆盖窗口为 `Exp_01`。
> - Particle Counts 可见 `Smoke_01` 为 `35 Current, 35 Max (est.)`，状态 Active。
> - Details Owner 显示为 `Mesh_01`，右侧可见 `Scale Color` 分类标题。
> - 其余参数被窗口裁切，不补写。
>
> 画面含义: 该帧记录烟雾和黑色调整理后的较弱阶段，角色本体比强爆炸帧更清楚，周围仅保留少量粒子和低强度蓝色光照。
> 图表转写（UE-GTXT v4）
> - 类型: `Mesh_01.Initial Mesh Orientation` 初始网格朝向设置
> - 组成部分: Niagara Preview + System Overview + Initial Mesh Orientation Details + Curves + Timeline
> - 所属: `Exp_01 / Mesh_01`。
> - 目的: 记录圆顶 Mesh 层在整理阶段加入初始朝向设置，用于调整网格效果显示。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见灰色烟雾区域，亮色爆炸基本消退。
> - `Smoke_01` 显示 `35 Current, 35 Max (est.)`，状态 Inactive。
> - `Mesh_01` 显示 `1 Current, 1 Max (est.)`，状态 Inactive。
> - `Glow_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002` 显示 Complete。
> - `Light_01` 显示 Inactive；`Debris_01002`、`Debris_01003`、`RadialBlur_01` 显示 Disabled。
>
> System Overview / Stack:
> - `Mesh_01.Initial Mesh Orientation` 被选中。
> - `Mesh_01` Stack 包含 `Initialize Particle`、`Initial Mesh Orientation`、`Particle State`、`Scale Mesh Size`、`Dynamic Material Parameters`、`Scale Color`、`Mesh Renderer`。
>
> Details:
> - Owner: `Mesh_01.Initial Mesh Orientation`。
> - `Mesh Orientation Mode = None`。
> - `Rotation` 勾选，三个字段可见为 `0.0, 0.0, 0.0`。
> - `Rotation Coordinate = Mesh`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示 `Smoke_01 > Scale Velocity > Velocity Scale > Float` 曲线，红色曲线从高值下降到接近 `0`。
> - Timeline 当前时间约 `1.34` 秒，显示 `321 of 2400`。
>
> 画面含义: 该帧记录 `Mesh_01` 已加入 `Initial Mesh Orientation`，当前 Rotation 三项为 0，Rotation Coordinate 字段显示为 Mesh；该字段只作为 UI 读数记录，不额外推断最终网格空间方向。

### 00:09:27-00:14:00 Emitter、Material、UV

- 本段定位：Emitter、Material、UV。
- 知识点：适当转了一下 几乎元素大部分就是有点 很多就放进去了 某种东西在这里 角色周围 感觉上面有一点无聊的感觉 在添加一个元素之前 适当调整那部分。
- 知识点：适当减少速度 需要让你出去 好像太那样了 这个感觉好像不错 那么需要在角色周围添加一个元素 那个是我给了大师材料的东西来使用 这里使用 Radio。
- 知识点：UV这个主材料 这里右键点击并创建为 Creative Motor Realism 这个需要移到这里 4号自动真实中使用 这个是用 Atee。
- 知识点：Emitter做一个开始 要大师奥特里尔 也在第一篇中我曾讨论过 应用名为 Radio UV的主控真实 使用的东西 我觉得可以想 所以Material从这里连接。
- 知识点：打开材料 参数数值先调整 再看看 Textural需要尝试先更换纹理 电的感觉要适当有点强烈 正常纹理将使用这个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Material`、`材质`、`纹理`、`贴图`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的圆顶核心与烟雾叠加
> - 组成部分: Level Viewport + Content Browser + Outliner + Niagara Editor overlay + 字幕
> - 所属: `04_Thunder_Explosion` 关卡与 `Exp_01 / Mesh_01`。
> - 目的: 在新增角色周围元素前，复核当前圆顶爆炸核心、烟雾和闪电元素的叠加状态。
>
> Level Viewport:
> - 角色位于半透明圆顶爆炸内部。
> - 圆顶下半部有蓝黑色暗部和蓝白发光环。
> - 圆顶内部可见少量白色闪电裂纹。
> - 圆顶左右两侧有灰白烟雾团，顶部附近有较亮白色光。
>
> Content Browser / Outliner:
> - Content Browser 位于 `Mesh` 目录，`SM_1` Static Mesh 被选中。
> - Outliner 可见 `04_Thunder_Explosion (Editor)`、`DirectionalLig...`、`01_Swing_Trail`、`Cine Camera Ac...`、`Exp 01`、`Floor`、`PlayerStart`。
>
> Niagara Editor overlay:
> - 底部覆盖窗口为 `Exp_01`。
> - Details Owner 显示为 `Mesh_01`。
> - 左侧 Particle Counts 只露出上部，具体完整计数被裁切。
>
> 字幕:
> - 字幕为“几乎元素大部分有点很多放进去了”。
>
> 画面含义: 该帧记录现有爆炸元素已经叠加较多，后续将在此基础上继续给角色周围添加新元素。
> 图表转写（UE-GTXT v4）
> - 类型: `Core_01.Sprite Renderer` 使用 RadialUV 材质
> - 组成部分: Content Browser + Niagara Preview + System Overview + Sprite Renderer Details + Curves + Timeline
> - 所属: `Exp_01 / Core_01`。
> - 目的: 新增一个使用径向 UV 材质的核心 Sprite 元素，作为角色周围/爆炸中心的补充层。
>
> Content Browser:
> - 当前位于 `Material/04` 附近目录。
> - `M_Radial... Material Ins...` 被选中，缩略图为黑底白色径向/裂纹纹理。
> - 周围可见 `M_Mesh_v01...`、`M_Thunder...` 等材质资源。
>
> Niagara Preview / Particle Counts:
> - Preview 中显示白色环状亮部和外侧灰白烟雾。
> - `Core_01` 显示 `0 Current, 0 Max (est.)`，状态 Active。
> - `Smoke_01` 显示 `35 Current, 35 Max (est.)`，状态 Active。
> - `Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Active。
> - `Debris_01002`、`Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Core_01` 和 `Mesh_01` emitter 同时可见。
> - `Core_01.Sprite Renderer` 被选中。
> - `Core_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Sprite Renderer`。
>
> Details:
> - Owner: `Core_01.Sprite Renderer`。
> - `Material` 字段显示为 `M_RadialUV_v01_Ins_...`，后缀被裁切，不能补写完整名称。
> - `Material User Param... = None`。
> - `Source Mode = Particles`。
> - `Alignment = Automatic`。
> - `Facing Mode = Automatic`。
> - `Macro UVRadius = 0.0`。
> - `Default Pivot in UV Space = 0.5, 0.5`。
> - `Pixel Coverage Mode = Automatic`。
> - `Pixel Coverage Blend = 1.0`。
> - `Min Facing Camera Blend = 0.0`。
> - `Max Facing Camera Blend = 0.0`。
> - `Sort Mode = None`。
> - `Renderer Visibility = 0`。
>
> Curves / Timeline:
> - 左下可见 `Smoke_01.Scale Velocity` 下降曲线。
> - Timeline 当前时间约 `0.13` 秒，`Core...` 轨道被选中。
>
> 画面含义: 该帧记录新建 `Core_01` Sprite emitter，并把 RadialUV 材质实例接入 Sprite Renderer，用作爆炸核心/角色周围的新视觉层。
> 图表转写（UE-GTXT v4）
> - 类型: `M_RadialUV_v01_Ins_01` 材质实例初调
> - 组成部分: Material Instance Preview + Details / Layer Parameters + Content Browser
> - 所属: `M_RadialUV_v01_Ins_01`。
> - 目的: 为 `Core_01` 的径向核心材质设置闪电纹理、法线和不透明纹理，并提升颜色/不透明强度。
>
> Material Preview:
> - 预览区显示圆形范围内大量白色和浅色闪电/裂纹细节。
> - 左上角统计信息可见:
>   - `Base pass shader without light map: 207 instructions`
>   - `Base pass vertex shader: 287 instructions`
>   - `Texture samples: 6/16`
>   - `Texture Lookups (Est.): VS(3), PS(7)`
>
> Details / Global Scalar Parameter Values:
> - `Color_Str = 50.0`。
> - `Color_Tile_U = 3.0`。
> - `Color_Tile_V = 0.5`。
> - `Desaturation = 0.0`。
> - `Diff_Tile_U = 2.5`。
> - `Diff_Tile_V = 0.5`。
> - `Edge_Pow = 0.5`。
> - `Fade_Dist = 50.0`。
> - `Mask_Str = 10.0`。
> - `Normal_Tile_U = 2.0`。
> - `Normal_Tile_V = 0.35`。
> - `Opacity_Pow` 当前输入框被选中，字段显示正在编辑，读数以可见输入为准，未补写确认后的值。
> - `Opacity_Str = 20.0`。
> - `RGB_Offset = 0.0`。
> - `Tension = 1.0`。
>
> Details / Global Texture Parameter Values:
> - `Color_Tex = T_Lightning_B_Tile_Chromatic`。
> - `Diff_Tex = T_Lightning_B_Tile`。
> - `Normal_Tex = T_Voronoi_Cells_02_NRM`。
> - `Opacity_Tex = B_BackColor004_emis`。
>
> Content Browser:
> - 左侧 Texture 目录中可见多种贴图，`T_Lightning... Texture` 被选中。
>
> 画面含义: 该帧记录 RadialUV 材质实例使用闪电色纹理、闪电 Diff、Voronoi 法线和黑底发光不透明纹理，并通过 `Color_Str`、`Mask_Str`、`Opacity_Str` 等参数增强核心纹理。

### 00:14:00-00:18:52 材质、系统、精灵

- 本段定位：材质、系统、精灵。
- 知识点：亮度感觉太强 适当调整一下张力 让我们来看一下 需要改成系统自助 设置为1s 需要进行burst 这进行burst的 角色身体周围需要出染。
- 知识点：因此会适当提高高度值 制服的大小大约会增大到600 制服的大小大约会增大到600 正在出现一些皱皱的东西 从这个片一直出发 让角色前面看起来清晰。
- 知识点：首先附上动态 材质然后抓住形状的东西 前曲线从0.4平移到0 前曲线从0.4平移到0 这种感觉 并且将扭曲也改为前曲线 让0到0.2产生一些扭曲。
- 知识点：让0到0.2产生一些扭曲 如果太严重的话会变成杂乱的扭曲 这个将逐渐增大扭曲值的感觉 这个将逐渐增大扭曲值的感觉 还有边缘添加部分 还有边缘添加部分。
- 知识点：我没有写下第三的参数和第四个参数的名字 我没有写下第三的参数和第四个参数的名字 第三部分在网格使用网格效果时 第三部分在网格使用网格效果时。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`系统`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_RadialUV_v01_Ins_01` 材质实例复调
> - 组成部分: Material Instance Preview + Details / Layer Parameters + Content Browser
> - 所属: `M_RadialUV_v01_Ins_01`。
> - 目的: 降低不透明/张力等数值，整理 RadialUV 核心纹理强度。
>
> Material Preview:
> - 预览区显示暗灰底上的白色细碎闪电/裂纹细节，整体亮度低于上一张材质预览。
> - 左上角统计信息仍显示 `207 instructions`、`287 instructions`、`Texture samples: 6/16`、`Texture Lookups (Est.): VS(3), PS(7)`。
>
> Details / Global Scalar Parameter Values:
> - `Color_Str = 50.0`。
> - `Color_Tile_U = 3.0`。
> - `Color_Tile_V = 0.5`。
> - `Desaturation = 0.0`。
> - `Diff_Tile_U = 2.5`。
> - `Diff_Tile_V = 0.5`。
> - `Edge_Pow = 0.5`。
> - `Fade_Dist = 50.0`。
> - `Mask_Str = 10.0`。
> - `Normal_Tile_U = 2.0`。
> - `Normal_Tile_V = 0.35`。
> - `Opacity_Pow = 1.0`。
> - `Opacity_Str = 5.0`。
> - `RGB_Offset = 0.0`。
> - `Tension = 0.5`。
>
> Details / Global Texture Parameter Values:
> - `Color_Tex = T_Lightning_B_Tile_Chromatic`。
> - `Diff_Tex = T_Lightning_B_Tile`。
> - `Normal_Tex = T_Voronoi_Cells_02_NRM`。
> - `Opacity_Tex = B_BackColor004_emis`。
>
> 画面含义: 该帧记录 RadialUV 材质实例把 `Opacity_Str` 调低到 5、`Tension` 调低到 0.5，并保持闪电纹理/法线/不透明纹理组合，用于避免亮度和纹理强度过高。
> 图表转写（UE-GTXT v4）
> - 类型: `Core_01.Dynamic Material Parameters` 动态材质参数
> - 组成部分: Niagara Preview + System Overview + Dynamic Material Parameters Details + Curves + Timeline + 字幕
> - 所属: `Exp_01 / Core_01`。
> - 目的: 用曲线驱动 RadialUV 材质的 Panning/Opacity、Distortion 和额外参数，使核心纹理随生命周期变化。
>
> Niagara Preview / Particle Counts:
> - Preview 当前较暗，未显示明显亮色核心。
> - `Core_01` 显示 Complete。
> - `Smoke_01` 显示 `21 Current, 35 Max (est.)`，状态 Inactive。
> - `Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Complete。
> - `Debris_01002`、`Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Core_01.Dynamic Material Parameters` 被选中。
> - `Core_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Camera Offset`、`Particle State`、`Dynamic Material Parameters`、`Sprite Renderer`。
> - 旁边可见 `Mesh_01` emitter，包含 `Dynamic Material Parameters`、`Scale Color` 和 `Mesh Renderer`。
>
> Details:
> - Owner: `Core_01.Dynamic Material Parameters`。
> - 顶部可见 Index 选项 `Index 0`、`Index 1`、`Index 2`、`Index 3`、`All`，当前显示 `All`。
> - `Write Parameter Index` 勾选。
> - `Panning_Opacity` 使用 `Float from Curve`，曲线随 `PARTICLES NormalizedAge` 从约 `0.4` 下降到 `0.0`，`Scale Curve = 1.0`。
> - `Distortion` 使用 `Float from Curve`，曲线随 `PARTICLES NormalizedAge` 从约 `0.0` 上升到约 `0.2`，`Scale Curve = 1.0`。
> - `Param3 = 0.0`。
> - `Param4 = 0.0`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示一条从 `0.0` 上升到约 `0.2` 的红色曲线。
> - Timeline 当前时间约 `1.75` 秒，显示 `420 of 2400`，`Core...` 轨道被选中。
>
> 字幕:
> - 字幕为“还有边缘添加部分”。
>
> 画面含义: 该帧记录 `Core_01` 的动态材质参数：Panning/Opacity 随生命周期减弱，Distortion 随生命周期增强，第三和第四参数暂为 0。
> 图表转写（UE-GTXT v4）
> - 类型: `Core_01.Scale Sprite Size` 核心 Sprite 尺寸曲线
> - 组成部分: Niagara Preview + System Overview + Scale Sprite Size Details + Curves + Timeline
> - 所属: `Exp_01 / Core_01`。
> - 目的: 通过 Uniform Curve 控制 `Core_01` 的 Sprite 尺寸，使核心元素在生命周期内从较小值增长到 1。
>
> Niagara Preview / Particle Counts:
> - Preview 当前较暗，核心元素不明显。
> - `Core_01` 显示 Complete。
> - `Smoke_01` 显示 `10 Current, 35 Max (est.)`，状态 Inactive。
> - `Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Complete。
> - `Debris_01002`、`Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Core_01.Scale Sprite Size` 被选中。
> - `Core_01` Stack 包含 `Initialize Particle`、`Camera Offset`、`Particle State`、`Scale Sprite Size`、`Dynamic Material Parameters`、`Sprite Renderer`。
> - `Mesh_01` emitter 同时可见，作为相邻的 Mesh 层。
>
> Details:
> - Owner: `Core_01.Scale Sprite Size`。
> - `Scale Sprite Size Mode = Uniform Curve`。
> - `Uniform Curve Sprite` 使用 `Curve for Floats`。
> - 曲线从约 `0.2` 随 `PARTICLES NormalizedAge` 上升到 `1.0`。
> - `Uniform Curve Index = PARTICLES NormalizedAge`。
> - `Uniform Curve Scale = 1.0`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示同一条 `Uniform Curve Sprite Scale` 上升曲线，tooltip 可见 `Time: 0`、`Value: 0.2`。
> - Timeline 当前时间约 `1.85` 秒，`Core...` 轨道被选中。
>
> 画面含义: 该帧记录 `Core_01` 的 Sprite 尺寸从 0.2 增长到 1.0，使径向核心元素在生命周期中逐步放大。

### 00:18:52-00:21:41 Color、Alpha、Curve

- 本段定位：Color、Alpha、Curve。
- 知识点：颜色部分 然后添加一个color部分 给float 0.515 这里就是用curve 最开始有强烈的颜色。
- 知识点：有这个值 这个是适当平滑的 有这个值 可以做一些变化 然后这里给这个scale curve的值适当大一点 然后alpha会适当慢慢消失 以身价开始。
- 知识点：变成0.1011的值 从0.7到7左右 alpha值慢慢减少 看一下这种 围绕身体的中心 有什么东西在辐射状扩散 这个边缘有点增加了 感觉从这个角色周围。
- 知识点：攀发出来的那种感受更强了 可以说 只是适当增加了复刺的感觉 确实比没有要好很多 适当把这个关掉 先保存资源 不过现在有点遗憾的是 这个身体上增加的电线。
- 知识点：希望能更强烈地表现出来 适当减少一点点加速。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Curve`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Core_01.Scale Color` 基础颜色/Alpha 设置
> - 组成部分: Niagara Preview + System Overview + Scale Color Details + Curves + Timeline
> - 所属: `Exp_01 / Core_01`。
> - 目的: 给 RadialUV 核心元素添加基础颜色和 Alpha 缩放，观察其与圆顶、烟雾叠加后的表现。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见半透明圆顶、蓝白闪电裂纹和左右灰白烟雾。
> - `Core_01`、`Smoke_01`、`Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Active。
> - `Debris_01002`、`Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Core_01.Scale Color` 被选中。
> - `Core_01` Stack 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Camera Offset`、`Particle State`、`Scale Sprite Size`、`Dynamic Material Parameters`、`Scale Color`、`Sprite Renderer`。
> - `Mesh_01` 同时可见，作为相邻 Mesh 层。
>
> Details:
> - Owner: `Core_01.Scale Color`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB` 勾选，值为 `1.0, 1.0, 1.0`。
> - `Scale Alpha` 勾选，值为 `1.0`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示 `Uniform Curve Sprite Scale` 上升曲线，从约 `0.2` 上升到 `1.0`。
> - Timeline 当前时间约 `0.49` 秒，显示 `118 of 2400`，`Core...` 轨道被选中。
>
> 画面含义: 该帧记录 `Core_01` 在未做复杂颜色曲线前使用基础 RGB/Alpha 缩放，核心纹理与烟雾、圆顶 Mesh 同时参与预览。
> 图表转写（UE-GTXT v4）
> - 类型: `Core_01.Scale Color` RGB/Alpha 曲线
> - 组成部分: Niagara Preview + System Overview + Scale Color Details + Curves + Timeline
> - 所属: `Exp_01 / Core_01`。
> - 目的: 通过 RGB 与 Alpha 曲线让核心元素先强后弱，并让角色周围的径向线条更清晰。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见角色周围的暗色圆顶区域、蓝白电纹和外侧烟雾。
> - `Core_01`、`Smoke_01`、`Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01` 显示 Active。
> - `Debris_01002`、`Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Core_01.Scale Color` 被选中。
> - `Core_01` Stack 中 `Scale Color` 位于 `Dynamic Material Parameters` 之后、`Sprite Renderer` 之前。
>
> Details:
> - Owner: `Core_01.Scale Color`。
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB` 勾选，模式为 `Multiply Vector by Float`。
> - Vector 值为 `0.5, 1.0, 5.0`。
> - RGB Float 使用 `Float from Curve`，曲线从约 `1.0` 随 `PARTICLES NormalizedAge` 下降到接近 `0.0`。
> - RGB `Scale Curve = 10.0`。
> - `Scale Alpha` 勾选，使用 `Float from Curve`。
> - Alpha 曲线从接近 `0` 快速上升到约 `1.0`，随后缓慢下降到接近 `0`。
> - Alpha `Scale Curve = 1.0`。
>
> Curves / Timeline:
> - 左下曲线面板显示一条红色曲线，前段高值随后快速下降到 0。
> - Timeline 当前时间约 `0.92` 秒。
>
> 画面含义: 该帧记录 `Core_01` 用偏蓝的 RGB 向量和两个随生命周期变化的曲线控制颜色与透明度，使角色周围的径向电纹从强到弱消退。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡预览中的角色周围径向线条
> - 组成部分: Level Viewport + Content Browser + Outliner + Material Instance overlay + 字幕
> - 所属: `04_Thunder_Explosion` 关卡与 `M_RadialUV_v01_Ins_01`。
> - 目的: 在关卡视角验证新增核心材质后，角色周围是否出现更明确的线条和散点。
>
> Level Viewport:
> - 角色位于棋盘格地面中央。
> - 角色周围可见蓝白小粒子散点。
> - 地面和角色周围有轻微蓝色光照。
> - 强圆顶爆炸已不明显，整体以线条/散点余韵为主。
>
> Content Browser:
> - 左侧位于 Texture 目录，可见 `T_Lightning...`、`T_Radial...`、`T_Glow...` 等贴图资源。
> - `T_Lightning... Texture` 处于选中状态。
>
> Outliner:
> - 可见 `04_Thunder_Explosion (Editor)`、`DirectionalLig...`、`01_Swing_Trail`、`Cine Camera Ac...`、`Exp 01`、`Floor`、`PlayerStart`。
>
> Material Instance overlay:
> - 底部覆盖窗口打开 `M_RadialUV_v01_Ins_01`。
> - 预览统计区可见 `Base pass shader without light map: 207 instructions`、`Base pass vertex shader: 287 instructions`、`Texture samples: 6/16`、`Texture Lookups (Est.): VS(3), PS(7)`。
> - 参数面板只露出标题和上部，不补写未显示字段。
>
> 字幕:
> - 字幕为“看起来比之前更明确的线条了”。
>
> 画面含义: 该帧记录 `Core_01` 调色后，关卡中角色周围线条和粒子散点比之前更清楚。

### 00:22:18-00:25:29 Velocity、Color、粒子

- 本段定位：Velocity、Color、粒子。
- 知识点：看起来比之前更明确的 线条了 那么现在最后加一个火花 再加上抖动的话 某种程度上结束了 然后需要添加火花部分 火花将通过修改这个力度 火花将通过修改这个粒子。
- 知识点：来使用 一个删掉 容量约为500个 空间位置设为180 这是在这个表面球体的形状 表面上 只在表面上成 调整为 添加速度随机值在500-600左右。
- 知识点：高度值 设为50左右 尺寸给358左右 然后没用的模块删掉 现在从0.5到1开始变小 x轴也从0.5开始变小 这个图形适当调整一下 接下来。
- 知识点：Scale Velocity的中间值删掉 这个设置 从1.3开始到0.05 颜色设置不太强烈。
- 知识点：不使用拖拽 接下来 Color值是0.2110左右。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Velocity`、`Color`、`粒子`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002.Initialize Particle` 火花/碎屑粒子初始化
> - 组成部分: Niagara Preview + System Overview + Initialize Particle Details + Curves + Timeline + 弹窗 + 字幕
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 新增火花粒子，设置生命周期、位置偏移和随机非均匀 Sprite 尺寸。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见烟雾、蓝白电纹和大量小火花/碎屑点。
> - `Debris_01002` 显示 `480 Current, 1000 Max (est.)`，状态 Active。
> - `Smoke_01` 显示 `35 Current, 35 Max (est.)`，状态 Active。
> - `Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01`、`Core_01` 显示 Active。
> - `Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Debris_01002.Initialize Particle` 被选中。
> - `Debris_01002` Stack 可见 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Shape Location Sphere`、`Add Velocity From Point`、`Particle State`、`Scale Sprite Size 001`、`Scale Sprite Size`、`Sub UVAnimation`、`Scale Velocity 001`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。
>
> Details:
> - Owner: `Debris_01002.Initialize Particle`。
> - `Lifetime Mode = Random`。
> - `Lifetime Min = 0.8`。
> - `Lifetime Max = 1.5`。
> - `Color Mode = Unset`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 勾选，值为 `0.0, 0.0, 30.0`。
> - `Position Offset Coordinate = Simulation`。
> - `Sprite Size Mode = Random Non-Uniform`。
> - `Sprite Size Min = 1.0, 20.0`。
> - `Sprite Size Max = 2.0, 10.0`。
> - `Sprite Rotation Mode = Random`。
> - `Sprite UV Mode = Random X`。
>
> Timeline / 弹窗 / 字幕:
> - Timeline 当前时间约 `1.01` 秒，显示 `243 of 2400`。
> - 右下角弹窗提示 `7 asset editors were open when the editor quit unexpectedly. Would you like to re-open them?`，按钮为 `Yes`、`No`。
> - 字幕为“高度值设为50左右”，但截图 Details 中可读位置偏移第三项为 `30.0`；本条以 UI 可读字段记录。
>
> 画面含义: 该帧记录新增火花/碎屑粒子 `Debris_01002` 的初始生命周期、位置偏移和随机 Sprite 尺寸设置。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002.Drag` 阻力设置
> - 组成部分: Niagara Preview + System Overview + Drag Details + Curves + Timeline + 弹窗
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 给火花/碎屑粒子增加 Drag，让粒子速度衰减并减少拖拽感。
>
> Niagara Preview / Particle Counts:
> - Preview 当前较暗，未显示明显火花外观。
> - `Debris_01002` 显示 Complete。
> - `Smoke_01`、`Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01`、`Core_01` 均显示 Complete。
> - `Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Debris_01002.Drag` 被选中。
> - `Debris_01002` Stack 中 `Drag` 位于 `Curl Noise Force` 之后、`Solve Forces and Velocity` 之前。
> - `Scale Velocity 001`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` 均可见并启用。
>
> Details:
> - Owner: `Debris_01002.Drag`。
> - `Drag = 10.0`。
> - `Rotational Drag = 1.0`。
>
> Curves / Timeline:
> - 左下 Curves 面板显示红色衰减曲线，从约 `1.3` 降至接近 `0.05`。
> - Timeline 当前时间约 `2.12` 秒，显示 `509 of 2400`。
>
> 弹窗:
> - 右下角仍显示资产编辑器异常退出后的重开提示，按钮为 `Yes`、`No`。
>
> 画面含义: 该帧记录 `Debris_01002` 在粒子更新阶段加入 `Drag=10.0` 与 `Rotational Drag=1.0`，用于让火花粒子运动更快衰减。
> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002` 火花粒子阶段预览
> - 组成部分: Niagara Preview + System Overview + Initialize/Update Stack + Curves + Timeline + 弹窗 + 字幕
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 复核火花粒子在烟雾和电纹叠加中的当前外观，并准备继续调整 Alpha/CPU/材质。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见大面积灰白烟雾、蓝白电纹和多处小火花/碎屑点。
> - `Debris_01002` 显示 Active，计数处于数百粒子量级；具体数值因截图压缩和叠字未在当前帧可确认。
> - `Smoke_01` 显示 Active。
> - `Glow_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01`、`Core_01` 继续参与系统。
>
> System Overview / Stack:
> - `Debris_01002` emitter 处于选中区域，Details 仍显示 `Debris_01002`。
> - 可见 `Initialize Particle`、`Shape Location Sphere`、`Add Velocity From Point`、`Scale Sprite Size`、`Scale Velocity 001`、`Curl Noise Force`、`Drag`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` 等模块。
> - 右侧 Details 大部分被弹窗遮挡，不能补写具体字段。
>
> Curves / Timeline:
> - 左下曲线区域显示火花相关曲线列表，`Scale Sprite Size`、`Scale Velocity` 等项可见。
> - Timeline 当前约在 `1` 秒附近，绿色轨道片段集中在起始区域。
>
> 弹窗 / 字幕:
> - 右下角仍显示资产编辑器异常退出后的重开提示。
> - 字幕为“不使用拖拽 接下来 Color值是0.2110左右。”。
>
> 画面含义: 该帧记录火花/碎屑粒子已经叠加到烟雾和核心电纹中，后续将继续调整颜色和 Alpha；被弹窗遮挡的 Details 字段不补写。

### 00:25:34-00:30:32 Alpha、CPU、材质

- 本段定位：Alpha、CPU、材质。
- 知识点：需要添加 Gravity Full 这种 这种感觉 在到达这里,延伸之前 好像有火花删 这个适当延迟一下 而且如果有更强的爆炸感 会更好。
- 知识点：太强了 如果差距太大就会有点 有点像蓝色的感觉 从表面开始生成 就会生成 那么Particle元素几乎已经全部添加完了。
- 知识点：现在只修改几个 适当遗憾的部分 那个部分好像有CPU错误 好的 现在适当有一些尴尬的部分 几处抓住 增加摇动的工作并结束 我身体上产生的那个。
- 知识点：电气部分 放射状产生的那个电气部分 适当Alpha剑影的时机 适当快一点可能更好 有点太突然消失的感觉 适当有点 还有这里发光的材质部分。
- 知识点：这部分适当强一点 也没关系 有什么适当更白的 这种有点突出的颜色 有些不平衡的感觉 就是适当有点 还有现在使用的这个材质。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Particle`、`Alpha`、`CPU`、`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Debris_01002.Gravity Force` 设置与爆发预览
> - 组成部分: Niagara Preview + Particle Counts + System Overview + Gravity Force Details + 异常恢复弹窗
> - 所属: `Exp_01 / Debris_01002`。
> - 目的: 为表面散出的碎屑/火花补充向下重力，使爆发粒子在烟雾与闪电叠加中有下落趋势。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见蓝白圆顶爆发、左右灰白烟雾、核心闪电裂纹和大量白色点状火花；预览区显示 `Compiling...`。
> - `Debris_01002` 显示 Active，约 `500 Current / 1000 Max`。
> - `Glow_01`、`Smoke_01`、`Light_01`、`RadialBlur_01`、`Glow_01001`、`Black_01`、`Black_01001`、`Black_01002`、`Mesh_01`、`Core_01` 显示 Active。
> - `Debris_01003` 显示 Disabled。
>
> System Overview / Stack:
> - `Debris_01002.Gravity Force` 被选中。
> - Stack 中可见 `Curl Noise Force`、`Gravity Force`、`Solve Forces and Velocity` 等粒子更新相关项；`Gravity Force` 位于 `Curl Noise Force` 之后、`Solve Forces and Velocity` 之前。
>
> Details:
> - Owner: `Debris_01002.Gravity Force`。
> - `Gravity = 0.0, 0.0, -980.0`。
> - 图中只记录字段值，不额外断言该向量所属坐标系。
>
> 弹窗:
> - 右下角显示异常退出恢复提示：`7 asset editors were open when the editor quit unexpectedly. Would you like to re-open them?`，按钮为 `Yes` / `No`。
>
> 画面含义: 该帧记录 `Debris_01002` 在已有噪声力后加入 Gravity Force，并在完整爆发预览里观察碎屑/火花密度。
> 图表转写（UE-GTXT v4）
> - 类型: `Thunder_Left_01` Niagara 预览
> - 组成部分: Niagara Preview + Particle Counts + System Overview + Timeline
> - 所属: `Thunder_Left_01`。
> - 目的: 查看左侧闪电系统的 Source、DynamicBeam 和 Debris 层在短时播放中的粒子数量与外观。
>
> Niagara Preview / Particle Counts:
> - Preview 中可见黑色背景上的蓝白发光源点、短电弧、散点火花和少量碎屑粒子。
> - `Source`: `1 Current / 2 Max`，Active。
> - `DynamicBeam`: `17 Current / 40 Max`，Active。
> - `Source001`: `1 Current / 1 Max`，Active。
> - `DynamicBeam001`: `18 Current / 36 Max`，Active。
> - `DynamicBeam002`: `15 Current / 36 Max`，Active。
> - `Debris_01002`: `34 Current / 40 Max`，Active。
>
> System Overview:
> - 当前 Niagara System 为 `Thunder_Left_01`。
> - 可见 Emitter/组包括 `Source`、`DynamicBeam`、`Source001`、`DynamicBeam001`、`DynamicBeam002`、`Debris_01002`。
> - 右侧 Details 未显示具体选中模块参数。
>
> Timeline:
> - 播放时间约 `3.18` 秒，帧率显示 `240 fps`。
>
> 画面含义: 该帧用于核对左手闪电系统由多个 Source/Beam 层和 Debris 层共同构成，粒子数量低于各自 Max 限制。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡最终效果预览与材质目录
> - 组成部分: Level Viewport + Content Browser + Outliner + 底部资产标签
> - 所属: Level `04_Thunder_Explosion`，相关 Niagara/材质资产包括 `Exp_01`、`Thunder_Left_01` 和 `M_Additive...` 材质实例。
> - 目的: 在关卡视口中查看角色、手部闪电、火花和烟雾的综合效果。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`，关卡为 `04_Thunder_Explosion`。
> - 角色双手各有蓝白发光球，身体和手臂附近可见白色闪电弧与少量火花。
> - 地面周围有淡蓝白烟雾/雾带，效果强度低于前一帧的大圆顶爆发。
>
> Content Browser / Outliner:
> - Content Browser 位于 `Content/Coloso_1/Tutorial/Material/04`，可见多个 `M_Additive...`、`M_Mesh...`、`M_Radial...`、`M_Thunder...` 材质或材质实例缩略图。
> - Outliner 中可见 `04_Thunder_Explosion`、`Exp 01`、`Floor`、`PlayerStart` 等对象。
>
> 底部资产标签:
> - 底部打开了 `Exp_01`、`Thunder_Left_01`、`M_AdditiveDe_v01_Ins_06` 等相关标签。
>
> 画面含义: 该帧记录完成 S07 调整后，角色手部电球、身体电弧、烟雾和火花在关卡镜头下的合成状态。

### 00:30:32-00:32:28 Niagara、粒子

- 本段定位：Niagara、粒子。
- 知识点：保存并最终保存 试着增加一次摇动 摇动是与粒子爆炸的时机相符 多一点可能会更好 大约在时针时发生 所以需要使用两次 现在几乎完成了 角色部分和水质部分。
- 知识点：都希望能有发光定制 但现在这种程度的表现 也不错 好的,那么请跟随第四个粒子 感受闪电属性 尼亚加拉模块的Scratch Pad 也简单地使用了一下。
- 知识点：适当介绍一下 如何进行脚本编写 理解上可能有些困难之处 如果有这种地方请继续观看 多次重复后 我相信可以理解的 那么你们再跟随第四个粒子时辛苦了 这次到此为止 辛苦了,谢谢。
- 核对对象：`Niagara`、`粒子`、`闪电`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中的最终爆发预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner
> - 所属: Level `04_Thunder_Explosion` / Sequence `04_Thunder_Explosion`。
> - 目的: 在最终保存前查看爆发峰值帧，并准备把镜头摇动与爆炸时机对齐。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色中心出现高亮蓝白爆发，外侧有半透明圆顶轮廓、左右烟雾带、大量白色火花和闪电裂纹。
> - 该帧是强亮度峰值状态，角色本体被核心光和烟雾部分遮挡。
>
> Sequencer:
> - 打开 `Sequencer` 面板，资产/序列名显示 `04_Thunder_Explosion`。
> - 当前时间指示约在 `0018`，显示 `19 of 90`，帧率为 `30 fps`。
> - `Camera Cuts` 轨道可见，用于检查镜头内爆发时间点。
>
> Content Browser / Outliner:
> - Content Browser 仍位于 `Material/04` 附近，可见相关材质实例缩略图。
> - Outliner 中可见 `Cine Camera Ac`、`Exp 01`、`Floor` 等关卡对象。
>
> 画面含义: 该帧记录最终序列早期爆发峰值，供后续把相机摇动或镜头节奏与粒子爆炸对齐。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 中段闪电与烟雾预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner + 字幕
> - 所属: Level `04_Thunder_Explosion` / Sequence `04_Thunder_Explosion`。
> - 目的: 查看爆发峰值之后角色、手部闪电、烟雾和火花的保留程度。
>
> Level Viewport:
> - 角色位于镜头中心，双手保持蓝白发光球。
> - 角色周围有淡蓝烟雾带、稀疏白色火花和多段白色电弧；圆顶爆发已减弱。
> - 画面用于比较爆发后段的粒子留存和整体亮度。
>
> Sequencer:
> - 当前时间指示约在 `0043`，显示 `44 of 90`，帧率为 `30 fps`。
> - `Camera Cuts` 轨道可见。
>
> 字幕:
> - 字幕文本为“但现在这种程度的表现也不错。”
>
> 画面含义: 该帧记录最终序列中段状态，说明在强爆发消退后仍保留手部电光、烟雾与少量火花。
> 图表转写（UE-GTXT v4）
> - 类型: Sequencer 爆发峰值复查
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner
> - 所属: Level `04_Thunder_Explosion` / Sequence `04_Thunder_Explosion`。
> - 目的: 复查最终序列前段爆发画面，确认核心亮度、圆顶轮廓、烟雾和火花叠加。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色中心被强蓝白核心光覆盖，外层形成半透明圆顶，周围有白色火花点和蓝白闪电裂纹。
> - 圆顶外侧可见左右烟雾带，地面棋盘格仅作为视口背景参照，不记录为空间坐标结论。
>
> Sequencer:
> - 打开 `Sequencer` 面板，序列名为 `04_Thunder_Explosion`。
> - 当前时间指示约在 `0018`，显示 `19 of 90`，帧率为 `30 fps`。
> - `Camera Cuts` 轨道可见。
>
> Content Browser / Outliner:
> - Content Browser 中可见 `M_Additive...`、`M_Mesh...`、`M_Radial...`、`M_Thunder...` 材质缩略图。
> - Outliner 中可见 `Cine Camera Ac`、`Exp 01`、`Floor` 等对象。
>
> 画面含义: 该帧与最终保存段落对应，用于检查爆发峰值下核心、烟雾、闪电和火花是否同时出现在镜头内。

## 补充视觉证据

### S08 00:31:44

> 图表转写（UE-GTXT v4）
> - 类型: 补充视觉证据，关卡视口与 Sequencer 预览
> - 组成部分: Level Viewport + Sequencer + Content Browser + Outliner + 字幕
> - 所属: Level `04_Thunder_Explosion` / Sequence `04_Thunder_Explosion`。
> - 目的: 作为 S08 的补充截图，记录最终效果中段的角色、烟雾、闪电和 Sequencer 帧位；文件 alt 标注为 `niagara_graph`，但图中未显示可读 Niagara 节点图或 Script Graph 连线。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色位于镜头中心，双手有蓝白发光球，周围有淡蓝烟雾、稀疏白色火花和地面附近的白色电弧。
> - 圆顶爆发已消退，画面强调爆发后段的留存电光和烟雾。
>
> Sequencer:
> - 打开 `Sequencer` 面板，序列名为 `04_Thunder_Explosion`。
> - 当前时间指示约在 `0043`，显示 `44 of 90`，帧率为 `30 fps`。
> - `Camera Cuts` 轨道可见。
>
> 字幕:
> - 字幕文本为“但现在这种程度的表现也不错。”
>
> 读取边界:
> - 图中没有可读 Niagara 节点、Pin 或连线，因此不补写 Niagara Script 节点表。
> - 本条只记录关卡视口、序列帧位和字幕可读信息。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。


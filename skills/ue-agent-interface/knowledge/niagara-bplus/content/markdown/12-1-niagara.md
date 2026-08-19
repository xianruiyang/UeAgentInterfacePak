# 12-1 制作Niagara粒子特效

# 12-1 制作Niagara粒子特效

## 关键术语

- `Color`、`Alpha`、`Power`、`Normal`、`Texture`、`Sequencer`、`Camera`、`SD`、`材质`、`Niagara`、`Particle`、`Normalized Age`、`Renderer`、`纹理`、`贴图`、`粒子`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:04-00:04:56 Sequencer、材质、粒子

- 本段定位：Sequencer、材质、粒子。
- 知识点：你好,在12课中再次问候你 到第11课设置了序列器 制作了冰网材质的材料 那么这次时间里将最后的粒子工作应用到。
- 知识点：现在要用什么感觉来制作呢 正式进行一次试试看 需要从这个序列开始 确认一下之前更新过的内容 这样出来 然后我们来看看那个粒子。
- 知识点：双击打开看看 我们把第2个粒子中用过的粒子导入使用 感觉就像是再利用了一下 暂时放在这里 然后上次我们制作的材料进行了测试 制作后就保存了。
- 知识点：这部分就直接复制一下 这里3号文件夹创建 这里带来并更改名字 MICI需要这样说 这现在是做在PARTICLE上。
- 知识点：我稍后会补充 首先看这个GLOW这个部分 然后再进行添加 颜色程度只要改变 这两个纸是一样的 可以使用材料 颜色和位置纸适当好像可以修改一下。
- 知识点：颜色只改为1.523左右 先把这个开着看看 这样感觉出来 这个位置纸可能是角色现在在跳跃时 特效在出现 所以在那个位置的辉光放置比较好。
- 知识点：在角色跳跃的位置 相比于从地面出来这个角色的反应中 有那种爆炸的感觉 把这个位置抓住会更好 所以提升了大约105 尺寸适当放大一下 再大一点这个区域适当大了一些。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Particle`、`Sequencer`、`材质`、`纹理`、`贴图`、`粒子`、`序列`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 冰爆关卡与基础资源确认
> - 组成部分: Level Viewport + Content Browser + Outliner + Actor Details
> - 所属: `03_Ice_Explosion` 关卡。
> - 目的: 在继续 Niagara 粒子前，确认关卡、网格资源和 Sequencer 基础对象。
>
> Content Browser:
> - 当前路径位于 `Coloso_Second / Mesh`。
> - 可见 Static Mesh：`Circle_03`、`Half...`、`SM_1Meter...`、`SM_FX...`、`SM_Ice...`。
>
> Viewport:
> - 视口模式为 `Perspective / Lit / Show`。
> - 大面积灰色棋盘格地面被选中，外框为黄色。
> - 画面中可见灯光图标和一个小型变换 gizmo。
>
> Outliner / Details:
> - 当前世界为 `03_Ice_Explosion (Editor)`。
> - 可见对象包括 `Lighting`、`DirectionalLight`、`01_Swing_Trail`、`Floor`、`PlayerStart`、`PostProcessVolume`。
> - 当前选中 `Floor`。
> - `Floor.Transform`: Location `0.0, 0.0, -0.5`，Rotation `0.0, 0.0, 0.0`，Scale `8.0, 8.0, 8.0`。
> - `Floor.Static Mesh` 为 `SM_Template_Map...`，材质槽 Element 0 为 `MI_ProcGrid`。
>
> 画面含义: 该帧是第 12 课开始时的关卡基线，说明前一课已设置 Sequencer 并完成冰网材质，当前准备把粒子工作应用到该场景。
> 图表转写（UE-GTXT v4）
> - 类型: 关卡 Sequencer 预览与 `Exp_01` 粒子系统打开状态
> - 组成部分: Level Viewport + Content Browser + Outliner + Sequencer + Niagara Editor
> - 所属: `03_Ice_Explosion` 关卡与 `Exp_01` Niagara System。
> - 目的: 复用第二个粒子例子中的系统，在角色跳跃/爆炸位置附近观察特效放置。
>
> Level Viewport:
> - 顶部显示 `Pilot Actor: Cine Camera Actor`，说明当前视口通过电影相机预览。
> - 棋盘格地面中央有角色，角色附近有淡灰色烟雾/辉光效果。
> - Sequencer 窗口打开，当前帧率显示 `30 fps`。
>
> Content Browser:
> - 当前位于 `Material / 03` 文件夹。
> - 可见并选中 `M_Ice_01` 材质资源。
>
> Outliner:
> - 世界为 `03_Ice_Explosion`。
> - 可见 `01_Swing_Trail`、`Aurora`、`Cine Camera Actor`、`Floor` 等。
>
> Niagara Editor:
> - 下方打开 `Exp_01*`。
> - 可见 `System Overview` 与 `Details` 区域，当前 Details 标题附近显示 `Glow_01`。
>
> 画面含义: 该图用于确认当前粒子系统已放入角色动作附近，并通过 Sequencer/相机视角检查爆炸感，而不是从地面直接出现。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Decal_01_Ins_02` 材质实例初始参数
> - 组成部分: Material Instance Preview + Details 参数面板 + Content Browser
> - 所属: `M_Decal_01_Ins_02`。
> - 目的: 为贴花/裂纹粒子设置材质实例，并检查基础强度、发光、法线、高度和贴图参数。
>
> Preview:
> - 中央预览为灰色背景上的白色裂纹/冲击纹理，中心较亮，向外有细分裂纹。
> - 左上 Stats 显示大致信息：Base pass shader `317 instructions`、Base pass vertex shader `287 instructions`、Texture samplers `7/16`、Texture Lookups 估算 `VS(3), PS(4)`。
>
> Details - Global Scalar Parameter Values:
> - `Base_Pow = 1.0`
> - `Base_Str = 1.0`
> - `Decal_Radius = 0.5`
> - `Emissive_Pow = 2.0`
> - `Emissive_Str = 2.0`
> - `Flatten_Str = 0.0`
> - `Height_Str = 0.05`
> - `Metalic = 0.2`
> - `Roughness = 0.6`
> - `Shadow_Str = 0.5`
> - `Specular = 0.5`
>
> Details - Global Texture Parameter Values:
> - `BaseColor_Tex`、`Emissive_Tex`、`Height_Tex`、`Opacity_Tex` 均启用。
> - 可见 `Opacity_Tex` 使用白色圆形 falloff 贴图；其他纹理为裂纹/波纹类贴图。
>
> Details - Vector/Channel:
> - `Base_Color` 可见。
> - `Channel` 下拉框当前为 `Green`。
>
> 画面含义: 该图记录贴花材质实例的初始参数组，后续会改成更偏青蓝的基础颜色并降低部分高度/法线强度。

### 00:04:56-00:09:55 材质、颜色

- 本段定位：材质、颜色。
- 知识点：这会和高程图一起使用 还有图片图只用那凸起的部分 可能初始画图可以单独关闭 在材质主机里没有把这个。
- 知识点：发现部分提取为纹理参数 我也会把这个改为参数 是的这个好像是我漏掉的部分抱歉 修正过了 这里又出现了 正常部分也因为这个纹理。
- 知识点：和这个纹理的纹理相同 给相同纹理的纹理填入 面具纹理不必改变 这个部分也就这样放着 然后基础颜色。
- 知识点：基本上让它有一点点青蓝色的感觉 淡淡的青蓝色的感觉 这个颜色 基础颜色的力量 在白色部分区域 能多显现改变 所以有一点点可观察到。
- 知识点：已经应用 而且 贴花淡净了也不需要动 图片部分暂时不需要使用 所以先就这样放着 还有扁平法也 比起太突出地 冒出来适当低一点 0.03左右降低。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 贴花材质实例纹理参数检查
> - 组成部分: Material Instance Preview + Details 参数面板 + Texture Browser
> - 所属: `M_Decal_01_Ins_02`。
> - 目的: 核对贴花材质中 BaseColor、Emissive、Height、Opacity 等纹理参数是否已绑定。
>
> Preview:
> - 中央裂纹贴花为白色/灰白色，中心最亮，外缘逐渐变淡。
>
> Details:
> - `Base_Pow = 1.0`
> - `Base_Str = 1.0`
> - `Decal_Radius = 0.5`
> - `Emissive_Pow = 2.0`
> - `Emissive_Str = 2.0`
> - `Flatten_Str = 0.0`
> - `Height_Str = 0.05`
> - `Metalic = 0.2`
> - `Roughness = 0.6`
> - `Shadow_Str = 0.5`
> - `Specular = 0.5`
> - `Global Texture Parameter Values` 中可见 `BaseColor_Tex`、`Emissive_Tex`、`Height_Tex`、`Opacity_Tex`。
>
> Texture Browser:
> - 当前位于 `Texture` 文件夹。
> - 选中 `T_Wave...` 类纹理，附近可见 `T_RockPull...`、`T_Shadow...`、`T_Soft...`、`T_Voronoi...` 等。
>
> 画面含义: 该图对应检查材质里原本未参数化或漏掉的贴图部分，确认贴图输入已经出现在材质实例参数中。
> 图表转写（UE-GTXT v4）
> - 类型: 贴花材质实例青蓝基础色与高度/法线强度调整
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Decal_01_Ins_02`。
> - 目的: 将贴花基础色调到淡青蓝，并降低高度/法线突出程度。
>
> Preview:
> - 裂纹贴花仍为白灰色主形，但中心与外圈形状更大、更块状。
>
> Details - Global Scalar Parameter Values:
> - `Base_Pow = 0.5`
> - `Base_Str = 0.5`
> - `Decal_Radius = 0.5`
> - `Emissive_Pow = 2.0`
> - `Emissive_Str = 2.0`
> - `Flatten_Str = 0.0`
> - `Height_Str = 0.03`
> - `Metalic = 0.0`
> - `Roughness = 0.0`
> - `Shadow_Str = 0.5`
> - `Specular = 1.0`
>
> Details - Texture Parameters:
> - `BaseColor_Tex = T_WaveDisplaced_H...`
> - `Emissive_Tex = T_WaveDisplaced_H2`
> - `Height_Tex = T_WaveDisplaced_H...`
> - `Normal_Tex = T_WaveDisplaced_N`
> - `Opacity_Tex = falloff_circle`
>
> Details - Base Color:
> - `Base_Color` 为淡青蓝色。
> - 可读数值：R `2.0`、G `3.5`、B `5.0`、A `1.0`。
>
> 画面含义: 该图记录把基础颜色改成偏青蓝，并把 `Height_Str` 降到 `0.03`，减少贴花表面的凸起感。
> 图表转写（UE-GTXT v4）
> - 类型: `Decal` emitter 的 `DecalSize` 曲线
> - 组成部分: Niagara System Overview + Emitter Stack + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Decal` emitter。
> - 目的: 用 `Particles.NormalizedAge` 驱动贴花尺寸，让贴花在生命周期内逐渐缩小或淡出。
>
> Preview / Particle Counts:
> - 左侧显示 `Particle Counts`。
> - `Decal` 当前 `1 Current, 1 Max (est)`，状态为 `[Inactive]`。
> - `Glow_01`、`Glow_02` 已完成；多个 Debris/Light/Refraction/RadialBlur emitter 为 Disabled。
>
> System Overview:
> - 当前 Niagara System 为 `Exp_01`。
> - `Decal` emitter 可见，旁边有 `Smoke_01` disabled。
> - Stack 中 `Emitter State` 为 `Self / Once`。
> - `Particle Spawn` 下有 `Initialize Particle`，并设置 `Particles.DecalSize` 与 `Particles.DecalOrientation`。
> - `Particle Update` 下有 `Particle State`、`Scale Color`、`Set(PARTICLES) DecalSize`。
> - `Render` 下为 `Decal Renderer`。
>
> Details:
> - 当前模块为 `Set (PARTICLES) DecalSize`。
> - 表达式为 `Multiply Vector by Float`。
> - Vector 输入为 `PARTICLES INITIAL DecalSize`。
> - Float 输入为 `Float from Curve`。
> - `CurveIndex = PARTICLES NormalizedAge`。
> - 曲线在时间 0 附近值约为 1，后续缓慢下降，末端接近 0。
>
> Timeline:
> - 当前 Sequencer 时间约 `2.82`。
> - `Decal` 轨道在时间轴中高亮。
>
> 画面含义: 该图表示贴花尺寸由初始 `DecalSize` 乘以随 `NormalizedAge` 变化的浮点曲线控制，生命周期后段尺寸逐渐收缩。

### 00:09:55-00:14:44 Color、Texture、SD

- 本段定位：Color、Texture、SD。
- 知识点：是它原本的大小 谢谢 一开始缩小一些 只需抓住这个感觉就可以 快速的生命周期大约3秒 应该可以继续使用 那么消失时 使用这个图形 尽可能保持慢慢出来。
- 知识点：长时间维持后消失 比起过于极端的张力 就这样感觉走一趟 现在这个贴图正在变大 所以感觉非常不自然 这个需要这样更改 先保存一次 在录制过程中。
- 知识点：有时候引擎会关闭 首先先抓住那个贴图的感觉 根据我展开的感觉 如果这时效果也一起出现就好了 所以我觉得可以直接复制这个光韵来用 反正只会输出一个。
- 知识点：这个是之前第二个例子中使用的 使用网格平移的材质来制作 会制作网格渲染器 并进行重新 是的,添加材质。
- 知识点：把材质放到这个部分 需要先选择网格 放入Circle3 如果解除Amol 我们现在可以使用方向键移动 VASD键可以移动 更熟悉的朋友可以解除。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Texture`、`材质`、`纹理`、`贴图`、`渲染器`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `DecalSize` 曲线调整为开头缩小
> - 组成部分: Niagara System Overview + Details 曲线面板 + Sequencer Timeline
> - 所属: `Exp_01 / Decal` emitter。
> - 目的: 调整贴花尺寸曲线，让贴图开头更小，后续维持后再消失。
>
> Details:
> - 当前仍为 `Set (PARTICLES) DecalSize`。
> - Vector: `PARTICLES INITIAL DecalSize`。
> - Float: `Float from Curve`。
> - `CurveIndex = PARTICLES NormalizedAge`。
> - 曲线显示开头较低，随后升到接近 `1.0` 并保持一段时间，末端回到 `0.0`。
> - Key Data 区域可见输入框 `0.0` 与 `1.0`。
>
> System Overview:
> - `Decal` emitter 选中。
> - `Smoke_01` 为 disabled。
> - `Decal` Stack 中 `Emitter State` 为 `Self / Once`，`Spawn Burst Instantaneous` 启用。
> - `Render` 仍为 `Decal Renderer`。
>
> Timeline:
> - Sequencer 时间约 `2.96`。
> - `Decal` 轨道高亮，处于绿色片段范围内。
>
> 画面含义: 该帧把 Decal 的尺寸曲线从“直接大尺寸”改为“先小、再维持、最后消失”，让贴花出现和消失更自然。
> 图表转写（UE-GTXT v4）
> - 类型: 复制 Glow emitter 并改用 Mesh Renderer
> - 组成部分: Niagara System Overview + Emitter Stack + Renderer Details + Curve 面板
> - 所属: `Exp_01 / Glow_02001` emitter。
> - 目的: 复用之前的 Glow 粒子，但改为网格渲染器，为后续使用 `Circle_03` 网格和网格平移材质做准备。
>
> Particle Counts:
> - `Glow_02001` 当前 `0 Current, 1 Max (est)`，状态 `[Complete]`。
> - `Decal`、`Glow_01`、`Glow_02` 也在列表中，多个 Debris/Smoke/Light/Refraction/RadialBlur 为 disabled。
>
> System Overview:
> - 可见 `Glow_02` 与复制出来的 `Glow_02001`。
> - `Glow_02001` Stack:
>   - `Emitter State`: `Self / Once`
>   - `Spawn Burst Instantaneous`
>   - `Initialize Particle`
>   - `Camera Offset`
>   - `Particle State`
>   - `Scale Sprite Size`
>   - `Scale Color`
>   - Render 下为 `Mesh Renderer`
> - 原 `Glow_02` Render 下仍可见 `Sprite Renderer`。
>
> Details - Mesh Renderer:
> - 当前 Owner 为 `Glow_02001`。
> - `Meshes`: `1 Array element`。
> - `Enable Material Override`: 未勾选。
> - `Override Materials`: `0 Array element`。
> - `Source Mode`: `Particles`。
> - `Enable Mesh Flipbook`: 未勾选。
> - `Facing Mode`: `Default`。
> - `Sort Mode`: `None`。
> - `Renderer Visibility`: `0`。
>
> Curve 面板:
> - 左下显示 `Scale Alpha` 曲线，曲线从 0 上升到接近 1，中段保持，再下降到 0。
>
> 画面含义: 该图记录把 Glow 复制体从 Sprite Renderer 改成 Mesh Renderer 的阶段，下一步会指定网格和材质。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_01` 网格材质实例参数
> - 组成部分: Material Instance Preview + Details 参数面板 + Texture Browser
> - 所属: `M_Mesh_v01_Ins_01`。
> - 目的: 为 Mesh Renderer 准备网格平移/云雾形态材质，并检查贴图、透明度、法线和颜色参数。
>
> Preview:
> - 中央预览为灰色背景上的白色/淡蓝云雾状环形片段。
> - 形状由多个不规则白色块状区域组成，边缘柔和。
>
> Details - Scalar 参数:
> - `Diff_Tile_V = 0.5`
> - `Edge_Pow = 1.0`
> - `Fade_Dist = 100.0`
> - `Normal_Tile_U = 0.4`
> - `Normal_Tile_V = 0.25`
> - `Opacity_Pow = 1.0`
> - `Opacity_Str = 5.0`
> - `RGB_Offset = 0.0`
> - `Tension = 1.0`
>
> Details - Texture 参数:
> - `Color_Tex = T_Cloud_Wisp_Chro...`
> - `Diff_Tex = ramp_01`
> - `Normal_Tex = T_CloudScape_08_D...`
> - `Opacity_Tex = T_Spline_Gradient`
>
> Details - Vector 参数:
> - `BottomColor`: R `0.0`、G `0.0`、B `1.0`、A `1.0`，显示为蓝色。
> - `TopColor` 可见，色块为浅蓝白色；下方 R 值可读为 `0.6`，其余数值被截断。
>
> Texture Browser:
> - 当前位于 `Texture` 文件夹。
> - 可见 `Noise_Car...`、`Noise...`、`ramp_01`、`T_Beam...`、`T_Cloud...`、`T_GlowStar...` 等纹理。
>
> 画面含义: 该图是给 Mesh Renderer 使用的材质实例，主要通过云雾颜色纹理、渐变透明贴图和法线贴图形成柔和网格粒子形态。

### 00:14:48-00:19:43 Alpha、Camera、精灵

- 本段定位：Alpha、Camera、精灵。
- 知识点：有塌令需要高一点吧 这样可以更均匀地分布 并且颜色白色区域要广泛 将饱和度设为复制 这些区域更铺出就是颜色感。
- 知识点：不要太长的铺砖 适当短一点 Edge tower适当提高使用 扭曲的砖应该有点高 U部分 V部分适当低一点 适当简单的形状 这样带着去看看 现在没有动态参数节点。
- 知识点：没有动画 慢慢的调整 看看可以 反正particle只生成一个 去掉Camera offset 位置只要在地面上 所以105的直删除 大概调整到10左右。
- 知识点：还有生命周期适当长一点 除了Sprite 用Uniform把Nash Size 调整到0.45 然后颜色一开始适当亮一点。
- 知识点：希望有点慢慢散开的颜色 颜色暂时只简单调整一下 Alpha 就先这样 这样就Bci在添加了 动态参数的状态下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Alpha`、`纹理`、`生命周期`、`颜色`、`曲线`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_01` 材质实例平铺与透明参数
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Mesh_v01_Ins_01`。
> - 目的: 调整网格材质的颜色平铺、透明强度、法线平铺和渐变透明纹理。
>
> Preview:
> - 中央预览为不规则白色/淡蓝雾状环形片段。
> - 片段外缘柔和，内部有深灰空洞。
>
> Scalar 参数:
> - `Color_Tile_U = 2.0`
> - `Color_Tile_V = 0.5`
> - `ColorBias = 0.5`
> - `Desaturation = 0.0`
> - `Diff_Tile_U = 1.0`
> - `Diff_Tile_V = 0.5`
> - `Edge_Pow = 1.0`
> - `Fade_Dist = 100.0`
> - `Normal_Tile_U = 0.4`
> - `Normal_Tile_V = 0.25`
> - `Opacity_Pow = 1.0`
> - `Opacity_Str = 5.0`
> - `RGB_Offset = 0.0`
> - `Tension = 1.0`
>
> Texture 参数:
> - `Color_Tex = T_Cloud_Wisp_Chromatic_Tile`
> - `Diff_Tex = ramp_01`
> - `Normal_Tex = T_CloudScape_08_Details_N`
> - `Opacity_Tex = T_Beam_Gradient_02`
>
> Vector 参数:
> - `BottomColor` 为蓝色，R `0.0`、G `0.0`、B `1.0`。
>
> 画面含义: 该帧记录网格材质用于 Glow/Mesh 粒子的基础贴图与透明控制，尤其是 `Opacity_Tex` 改为横向渐变纹理。
> 图表转写（UE-GTXT v4）
> - 类型: `Glow_02001.Scale Color` 的 RGB/Alpha 曲线
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Glow_02001` emitter。
> - 目的: 调整网格光晕的颜色强度和 Alpha，让颜色从生成时更亮，并逐渐散开。
>
> Preview:
> - 左侧预览显示一团白蓝色放射状光晕，中心亮，外侧有短线状碎片。
> - Particle Counts 显示 `Decal`、`Glow_01`、`Glow_02`、`Glow_02001` 处于 Active。
>
> System Overview:
> - `Glow_02` 与 `Glow_02001` 并列。
> - `Glow_02001` 的 `Scale Color` 模块被选中。
> - `Glow_02001` Stack 包含 `Emitter State(Self / Once)`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Scale Sprite Size`、`Dynamic Material Parameters`、`Scale Color`、`Mesh Renderer`。
>
> Details - Scale Color:
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB` 使用 `Multiply Vector by Float`。
> - Vector 值可读为 `(3.0, 5.0, 10.0)`。
> - Float 值为 `1.0`。
> - `Scale Alpha` 使用 `Float from Curve`。
> - `CurveIndex = PARTICLES NormalizedAge`。
> - Alpha 曲线在开头快速从 0 升到接近 1，中段保持，后段下降到 0。
>
> Timeline:
> - 当前时间约 `0.08`，绿色片段起始附近。
>
> 画面含义: 该图设置 `Glow_02001` 的颜色为强蓝白，并用 Alpha 曲线让光晕从亮起到逐渐消散。
> 图表转写（UE-GTXT v4）
> - 类型: `Glow_02001.Dynamic Material Parameters` 的 Panning/Distortion 曲线
> - 组成部分: Niagara System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Glow_02001` emitter。
> - 目的: 给材质动态参数添加随生命周期变化的透明平移和扭曲控制。
>
> System Overview:
> - `Glow_02001` 中 `Dynamic Material Parameters` 模块被选中。
> - `Camera Offset` 和 `Scale Sprite Size` 在该复制 emitter 中显示为未启用状态，`Particle State`、`Dynamic Material Parameters`、`Scale Color`、`Mesh Renderer` 启用。
>
> Details - Dynamic Material Parameters:
> - 参数页签显示 `Index 0`、`Index 1`、`Index 2`、`Index 3`、`All`。
> - `Dynamic Parameter 1`:
>   - `Write Parameter Index` 勾选。
>   - `Panning_Opacity` 使用 `Float from Curve`。
>   - `CurveIndex = PARTICLES NormalizedAge`。
>   - 曲线从约 `0.8` 逐渐下降到约 `0.2`。
> - 下面可见 `Distortion = 0.0`、`EdgeAdd = 1.0`、`ColorPower = 1.0`。
>
> Curve 面板:
> - 左下同样显示 `Scale Alpha` 曲线。
>
> Timeline:
> - 当前时间约 `2.26`。
>
> 画面含义: 该帧表示材质参数 `Panning_Opacity` 随粒子生命周期逐渐降低，用于让材质平移/透明变化更柔和。

### 00:19:43-00:24:18 颜色

- 本段定位：颜色。
- 知识点：开始是进行时会更强 从0.2的时机开始 冰的贴花部分似乎很合适 那种形状感的感觉 现在再看颜色部分。
- 知识点：看看能否顺利出来 颜色暂时改为成法图 这个向量部分用曲线生成 向量让起始和结束的颜色适当不同。
- 知识点：这样做吧 蓝色从3开始 绿色从2 红色从1 越来越饱和 大约给0.1 然后这里再增加浮动值给曲线 起始值设为逐渐消失的同时 反而变得更亮 目标是那条线更明显。
- 知识点：就这种感觉怎么样 减少一下头二胎 现在的正常平步感觉有点强 增加一种和贴花一起散开的效果 现在已经尝试过了 感觉张力配合得不错 拿贴花散开的感觉。
- 知识点：适当帮助一下 暂时加了一层 但不会只用这一层 因为这一层有点太简单了 我觉得再提到一条会好一些 保存然后复制这个 尝试增加一点 让它以另一种感觉的字概念。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`曲线`、`烟雾`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 光晕预览与 Panning/Distortion 双曲线
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板
> - 所属: `Exp_01 / Glow_02001` emitter。
> - 目的: 同时观察贴花散开形态和材质动态参数对光晕展开的影响。
>
> Preview:
> - 左侧预览为圆形放射状冰蓝光晕。
> - 中央较暗，外圈白蓝色块向外扩散，边缘带深蓝/紫蓝。
> - Particle Counts 显示 `Decal`、`Glow_01`、`Glow_02`、`Glow_02001` 为 Active。
>
> Details - Dynamic Material Parameters:
> - `Panning_Opacity` 使用 `Float from Curve`，曲线从约 `0.8` 下降到约 `0.2`。
> - `Distortion` 使用 `Float from Curve`，曲线从较低值逐渐上升到约 `0.7`。
> - `CurveIndex = PARTICLES NormalizedAge`。
> - `EdgeAdd = 1.0`、`ColorPower = 1.0`。
>
> System Overview:
> - `Glow_02001.Dynamic Material Parameters` 仍被选中。
> - `Glow_02001` 使用 `Mesh Renderer`。
>
> 画面含义: 该图把透明平移逐渐降低和扭曲逐渐增强组合起来，得到向外散开的冰蓝环形光晕。
> 图表转写（UE-GTXT v4）
> - 类型: `Scale RGB` 向量曲线随生命周期变化
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Glow_02001` emitter。
> - 目的: 让粒子颜色在起始与结束阶段不同，使边缘线条更明显。
>
> Preview:
> - 左侧光晕为白蓝色圆形爆散，中心偏暗，边缘较亮。
>
> Details - Scale Color:
> - `Scale Mode = RGB and Alpha Separately`。
> - `Scale RGB` 为 `Multiply Vector by Float`。
> - Vector 来源为 `Vector from Curve`。
> - VectorCurve 以 `PARTICLES NormalizedAge` 为 `CurveIndex`。
> - 曲线显示三条颜色通道：
>   - X/红通道从约 `1` 逐渐降到较低值。
>   - Y/绿通道从约 `2` 降到约 `1`。
>   - Z/蓝通道从约 `3` 降到约 `1.5`。
> - Float 使用 `Float from Curve`，下方曲线在 0 到 1 区间内变化。
>
> Timeline:
> - 当前时间约 `0.27`。
> - `Decal` 等绿色片段位于开始段。
>
> 画面含义: 该图通过 Vector 曲线让 RGB 强度随生命周期变化，形成开始更亮、更偏蓝白，后续降低饱和或亮度的效果。
> 图表转写（UE-GTXT v4）
> - 类型: 复制出的 `M_Mesh_v01_Ins_02` 竖向碎片材质
> - 组成部分: Material Instance Preview + Details 参数面板 + Content Browser
> - 所属: `M_Mesh_v01_Ins_02`。
> - 目的: 新增另一层 Mesh 材质，让形态从圆形光晕变成更柔和展开的竖向碎片。
>
> Preview:
> - 中央显示多组竖向白色/淡蓝碎片，形态像下垂或向下展开的冰纹条。
> - 灰色背景下碎片分布成多列，中间有较亮区域。
>
> Content Browser:
> - 当前位于 `Material / 03`。
> - 可见 `M_Decal...`、`M_Ice_01`、`M_Mesh_v01...`、`M_Mesh_v01_Ins_02`。
> - 当前选中 `M_Mesh_v01_Ins_02`。
>
> Scalar 参数:
> - `Color_Tile_U = 0.5`
> - `Color_Tile_V = 0.5`
> - `ColorBias = 2.0`
> - `Desaturation = -2.0`
> - `Diff_Tile_U = 1.0`
> - `Diff_Tile_V = 0.8`
> - `Edge_Pow = 5.0`
> - `Fade_Dist = 100.0`，该项未启用。
> - `Normal_Tile_U = 3.0`
> - `Normal_Tile_V = 0.2`
> - `Opacity_Pow = 0.5`
> - `Opacity_Str = 3.0`
> - `RGB_Offset = 0.0005`
> - `Tension = 1.0`
>
> Texture 参数:
> - `Color_Tex = T_Cloud_Wisp_Chro...`
> - `Diff_Tex = ramp_01`
> - `Normal_Tex = T_CloudScape_08_D...`
> - `Opacity_Tex = T_Beam_Gradient_0...`
>
> 画面含义: 该帧展示复制材质后的第二层网格材质，重点是更高 `Edge_Pow`、更高 `Normal_Tile_U` 和较低 `Opacity_Pow`，让碎片边缘更强。

### 00:24:18-00:29:16 Power、Normal、材质

- 本段定位：Power、Normal、材质。
- 知识点：给人一种强烈的边缘感 如果说贴花的形状感是适当调整的话 这一部分则让它更柔和地展开 做出一种展开的感觉 我有点找不到 需要使用这个纹理。
- 知识点：并且Normal Map使用波浪 Mask就这样放着吧 保持参数增加饱和度 Tiling设置为3 左右V值大约设为0.15 保持Power值。
- 知识点：Normal部分设为2和0.3 适当提高强度 材质就调整到这个程度看看 生命时间程度适当不同 适当慢一点去试试嘛 大小适当放大一点。
- 知识点：平移的部分 试针的部分要调整好吧 接下来我们检查一下颜色 平移大约从0.7开始 移动到大约-0.2的感觉 然后试针让它慢一点 产生强度也不到太强。
- 知识点：就给人一种扩散的感觉 柔和地展开的感觉 边缘添加也会给出覆盖 从零角开始 亮度适当强一些 在0.5时适当变弱 快速变弱的感觉 这种感觉应该不错。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Mesh_v01_Ins_02` 材质参数细调
> - 组成部分: Material Instance Preview + Details 参数面板
> - 所属: `M_Mesh_v01_Ins_02`。
> - 目的: 让第二层网格材质更柔和地展开，同时保持明显边缘。
>
> Preview:
> - 多列竖向白色/淡蓝冰纹碎片分布在灰色背景上。
> - 中部较密，底部有少量细长碎片。
>
> Details:
> - `Edge_Pow = 5.0`
> - `Normal_Tile_U = 3.0`
> - `Normal_Tile_V = 0.2`
> - `Opacity_Pow = 0.5`
> - `Opacity_Str = 3.0`
> - `RGB_Offset = 0.0005`
> - `Tension = 1.0`
> - `Color_Tex = T_Cloud_Wisp_Chromatic_Tile`
> - `Diff_Tex = ramp_01`
> - `Normal_Tex = T_CloudScape_08_Details_N`
> - `Opacity_Tex = T_Beam_Gradient_02`
> - `BottomColor`: R `0.0`、G `0.0`、B `1.0`、A `1.0`
> - `TopColor`: R `0.6`、G `0.8`、B `1.0`、A `1.0`
>
> 画面含义: 该图确认第二层材质的边缘强度、法线平铺和透明强度已经按扩散感调好，颜色仍保持蓝到浅蓝白。
> 图表转写（UE-GTXT v4）
> - 类型: `Mesh_01001.Initialize Particle` 生命周期、偏移和尺寸
> - 组成部分: Niagara Preview + System Overview + Initialize Particle Details + Timeline
> - 所属: `Exp_01 / Mesh_01001` emitter。
> - 目的: 复制 Mesh emitter 后调整生命时间、位置偏移和 Mesh Uniform Scale。
>
> Preview:
> - 左侧为白蓝色圆形光晕预览。
> - Particle Counts 中 `Mesh_01` 与 `Mesh_01001` 均为 Active。
>
> System Overview:
> - 可见 `Mesh_01` 和复制出的 `Mesh_01001`。
> - `Mesh_01001` Stack 包含 `Emitter State(Self / Once)`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Dynamic Material Parameters`、`Scale Color`、`Mesh Renderer`。
> - 当前选中 `Initialize Particle`。
>
> Details - Initialize Particle:
> - Owner: `Mesh_01001`。
> - `Lifetime Mode = Direct Set`。
> - `Lifetime = 1.35`。
> - `Color Mode = Unset`。
> - `Position Mode = Simulation Position`。
> - `Position Offset` 启用，数值为 `0.0, 0.0, 10.0`。
> - `Position Offset Coordinate Space = Simulation`。
> - `Mass Mode = Unset / (Mass of 1)`。
> - `Mesh Scale Mode = Uniform`。
> - `Mesh Uniform Scale = 0.45`。
> - Sprite/Ribbon 相关属性均为 Unset。
>
> Timeline:
> - 当前时间约 `0.27`，绿色片段位于开始段。
>
> 画面含义: 该图记录第二层 Mesh emitter 的初始化参数：寿命比前层略不同，位置偏移为模拟空间中的 `0,0,10`，网格统一缩放为 `0.45`。
> 图表转写（UE-GTXT v4）
> - 类型: `Mesh_01.Dynamic Material Parameters` 扩散曲线
> - 组成部分: Niagara System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Mesh_01` emitter。
> - 目的: 调整材质平移、扭曲和边缘增强，让网格粒子产生柔和扩散。
>
> Particle Counts:
> - `Decal` 为 Inactive。
> - `Mesh_01` 与 `Mesh_01001` 为 Complete。
> - `Glow_01`、`Glow_02` 为 Complete；多个 Debris/Smoke/Light/Refraction/RadialBlur 为 Disabled。
>
> System Overview:
> - `Mesh_01` 与 `Mesh_01001` 并列。
> - `Mesh_01.Dynamic Material Parameters` 被选中。
> - `Mesh_01` Stack 包含 `Emitter State(Self / Once)`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Dynamic Material Parameters`、`Scale Color`、`Mesh Renderer`。
>
> Details - Dynamic Material Parameters:
> - `Panning_Opacity` 使用 `Float from Curve`。
> - `Panning_Opacity.CurveIndex = PARTICLES NormalizedAge`。
> - Panning 曲线从约 `0.8` 下降到约 `0.2`。
> - `Distortion` 使用 `Float from Curve`。
> - Distortion 曲线从约 `0.0` 上升到约 `0.7`。
> - `EdgeAdd` 使用 `Float from Curve`，曲线区域在下方可见但未完全展开。
>
> Timeline:
> - 当前时间约 `2.37`。
>
> 画面含义: 该帧把网格材质的平移透明度设为随生命周期降低，同时让扭曲强度逐渐增加，用于制造向外扩散且边缘覆盖的感觉。

### 00:29:16-00:30:11 关键流程 07

- 本段定位：关键流程 07。
- 知识点：从50左右到0.5 会移动 扩散时这里轮廓线适当强烈扩散 这里似乎会很 现在展开的感觉似乎好多了 展开的感觉是。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `Mesh_01.Dynamic Material Parameters` 曲线设置
> - 组成部分: Niagara Preview + System Overview + Details 曲线面板 + Timeline
> - 所属: `Exp_01 / Mesh_01` emitter。
> - 目的: 用随 `Particles.NormalizedAge` 变化的曲线控制透明平移、扭曲和边缘追加，让网格冰雾从强轮廓扩散到较弱状态。
>
> Preview:
> - 左侧预览为蓝白色冰雾爆发，中心亮度高，外圈呈环状扩散。
> - `Particle Counts` 中 `Decal`、`Mesh_01`、`Mesh_01001` 等为 Active，部分 Debris/Light/RadialBlur/Refracion 项为 Disabled。
>
> System Overview:
> - 可见 `Mesh_01` 与 `Mesh_01001` 两个 emitter。
> - `Mesh_01` Stack 中 `Dynamic Material Parameters` 被选中。
> - `Mesh_01001` 也包含 `Initialize Particle`、`Dynamic Material Parameters`、`Scale Color` 与 `Mesh Renderer`。
>
> Details 参数:
> - `Panning_Opacity` 启用 `Float from Curve`。
> - `Panning_Opacity.CurveIndex = PARTICLES NormalizedAge`。
> - `Panning_Opacity` 曲线从约 `0.8` 随生命周期下降到约 `0.2`，中段持续缓慢下降。
> - `Distortion` 启用 `Float from Curve`。
> - `Distortion.CurveIndex = PARTICLES NormalizedAge`。
> - `Distortion` 曲线从约 `0.0` 上升到约 `0.7`，后段趋于平缓。
> - `EdgeAdd` 启用 `Float from Curve`，曲线面板在截图下方可见但底部被裁切。
>
> Timeline:
> - 当前时间约 `0.74` 秒，Timeline 中 `Decal` 段仍在前段绿色区间。
>
> 画面含义: 该帧记录 `Mesh_01` 扩散阶段的动态材质驱动方式：透明平移递减，扭曲递增，边缘追加由单独曲线控制。
> 图表转写（UE-GTXT v4）
> - 类型: `03_Ice_Explosion` 关卡最终冰爆预览
> - 组成部分: Level Viewport + Content Browser + Outliner + Floor Details
> - 所属: `03_Ice_Explosion` 关卡中的 `Exp01` Niagara Actor 与 `Floor`。
> - 目的: 检查冰爆粒子叠加到角色位置后的整体视觉效果和地面参考参数。
>
> Level Viewport:
> - 视口处于 `Pilot Actor: Cine Camera Actor`。
> - 角色位于蓝白冰爆中心。
> - 冰爆覆盖成大面积圆形扩散，中心接近白色，外围为浅蓝雾状和碎片状边缘。
> - 外圈在棋盘地面上呈半透明铺开，保留可见地面格线。
>
> Outliner:
> - 当前世界为 `03_Ice_Explosion`。
> - 可见对象包括 `Lighting`、`DirectionalLight`、`01_Swing_Trail`、`Aurora`、`Cine Camera Actor`、`Exp01`。
>
> Floor Details:
> - 选中对象: `Floor` / `Floor (Instance)`。
> - 组件: `StaticMeshComponent`。
> - Transform Location: `0.0, 0.0, -0.5`。
> - Transform Rotation: `0.0, 0.0, 0.0`。
> - Transform Scale: `8.0, 8.0, 8.0`。
> - Static Mesh 字段显示 `SM_Template_M...`。
>
> Content Browser:
> - 当前搜索 `Texture`，可见 `T_Radial...`、`T_Rock...`、`T_Soft...`、`T_Streak...`、`T_Wave...` 等贴图缩略图。
>
> 画面含义: 该帧记录最终组合效果：Decal、Glow/Mesh 粒子和材质参数共同形成以角色为中心的蓝白冰爆铺展。
> 图表转写（UE-GTXT v4）
> - 类型: 冰爆播放结束后的关卡残留状态
> - 组成部分: Level Viewport + Content Browser + Outliner + Floor Details + 下方 Niagara 窗口边缘
> - 所属: `03_Ice_Explosion` 关卡。
> - 目的: 对比爆发结束后视口中粒子消散状态，确认强冰雾只在生命周期内出现。
>
> Level Viewport:
> - 视口仍处于 `Pilot Actor: Cine Camera Actor`。
> - 角色位于棋盘地面中央偏上区域。
> - 大面积蓝白冰爆已经消散，仅角色附近保留很小的淡蓝光迹或残留亮点。
> - 地面格线清晰可见，没有大面积 Decal/雾状覆盖。
>
> Outliner:
> - 世界为 `03_Ice_Explosion`。
> - `Floor` 被选中。
> - 可见对象包括 `Lighting`、`DirectionalLight`、`01_Swing_Trail`、`Aurora`、`Cine Camera Actor`、`Floor`。
>
> Floor Details:
> - 选中对象: `Floor` / `Floor (Instance)`。
> - Transform Location: `0.0, 0.0, -0.5`。
> - Transform Rotation: `0.0, 0.0, 0.0`。
> - Transform Scale: `8.0, 8.0, 8.0`。
> - Material Element 0 为 `MI_ProcGrid`。
>
> 下方 Niagara 窗口:
> - 标签可见 `Exp_01`、`M_Decal_01_Ins_02`、`M_Mesh_v01_Ins_01`、`M_Mesh_v01_Ins_02`，说明当前仍在同一 Niagara/材质调试上下文中。
>
> 画面含义: 该帧记录冰爆生命周期末端或播放后状态，和前一帧的大面积铺展形成对照。

## 补充视觉证据

### S01 00:00:19

> 图表转写（UE-GTXT v4）
> - 类型: `Floor` 静态网格参数补充证据
> - 组成部分: Level Viewport + Content Browser + Outliner + Details
> - 所属: `03_Ice_Explosion (Editor)` 关卡中的 `Floor`。
> - 目的: 补充记录 p15 开始阶段地面网格、材质和 Transform 参数，作为后续冰爆预览的场景基准。
>
> Level Viewport:
> - 视口为 `Perspective / Lit / Show`。
> - 棋盘地面覆盖整个画面，中央选中 `Floor`，可见移动 gizmo。
> - 画面中可见 `DirectionalLight` 图标。
>
> Content Browser:
> - 当前位于 `Content/Coloso_Second/Mesh`。
> - 可见网格资源缩略图：`Circle_03`、`Half_...`、`SM_1Meter...`、`SM_FX_...`、`SM_Ice_...`。
>
> Outliner:
> - 世界为 `03_Ice_Explosion (Editor)`。
> - 可见对象包括 `Lighting`、`DirectionalLight`、`01_Swing_Trail`、`Floor`、`PlayerStart`、`PostProcessVolume`。
> - `Floor` 被选中，类型为 Static Mesh Actor。
>
> Floor Details:
> - 组件: `StaticMeshComponent`。
> - Transform Location: `0.0, 0.0, -0.5`。
> - Transform Rotation: `0.0, 0.0, 0.0`。
> - Transform Scale: `8.0, 8.0, 8.0`。
> - Mobility 行显示 Static / Stationary / Movable 选项，当前高亮在 `Movable`。
> - Static Mesh 字段显示 `SM_Template_Map...`。
> - Material Element 0 为 `MI_ProcGrid`。
>
> 画面含义: 该补充帧锁定冰爆测试场景的地面网格、ProcGrid 材质和基础 Transform，便于解释后续 Decal 与 Niagara 效果铺在同一地面参考上。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。


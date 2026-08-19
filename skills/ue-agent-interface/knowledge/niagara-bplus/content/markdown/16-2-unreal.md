# 16-2-Unreal火焰技能特效制作

# 16-2-Unreal火焰技能特效制作

## 关键术语

- `Emitter`、`Color`、`Alpha`、`UV`、`Multiply`、`Power`、`Curve`、`材质`、`后期处理`、`粒子`、`Niagara`、`Particle`、`Spawn Rate`、`Spawn`、`Particle Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:13-00:04:53 粒子、系统、颜色

- 本段定位：粒子、系统、颜色。
- 知识点：说起来现在从刚才开始啊,这个生成本身现在这个粒子生成本身就不行了。
- 知识点：2M粒子系统可能就得重新做了。
- 知识点：刚才好像真的是个bug,因为我没让玩,所以没看到的问题,好像有,幸好。
- 知识点：我还以为要整个系统都重新做呢,这些部分本地检查也没关系。
- 知识点：现在火焰本身的纹理是这样出来的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`、`系统`、`颜色`、`透明度`、`火焰`。

**关键画面：**

这是 Niagara System `Ex_04_FireSkill` 的系统总览画面。左侧时间轴中当前同时存在 3 个发射器：`Empty`、`Empty001`、`Empty002`；预览窗口左上角的 `Particle Counts` 显示三者当前都是 `0 Current, 1 Max (est.)`，状态均为 `Complete`，说明它们按一次性短时爆发的方式播放完毕后已结束。

画面中央可见前两个发射器的模块堆栈结构，第三个发射器只露出左侧边缘，但可确认三者都属于同一个火焰技能系统。当前选中的是第一个发射器 `Empty`，右侧 Details 面板显示其 `Emitter Properties` 关键设置为：

- `Local Space`：关闭
- `Interpolated Spawning`：开启
- `Sim Target`：`CPUSim`
- `Calculate Bounds Mode`：`Dynamic`
- `Requires Persistent IDs`：关闭

从堆栈顺序可以确认 `Empty` 与 `Empty001` 此时都采用同类的一次性精灵发射结构：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
- `Render`
  - `Sprite Renderer`

这张图的作用是交代系统层面的组成关系：当前火焰技能不是单发射器，而是由三路 sprite emitter 叠加构成，后续各截图会分别展开它们的颜色、尺寸、UV 与材质差异。
这张图选中的是第三个发射器 `Empty002`，时间轴停在约 `0.53s`，左侧预览中可见它已经生成一圈向外翻卷的亮橙色火舌。`Particle Counts` 显示：

- `Empty`：`0 Current, 1 Max (est.) [Active]`
- `Empty001`：`0 Current, 1 Max (est.) [Active]`
- `Empty002`：`13 Current, 13 Max (est.) [Active]`

说明当前可见的主要外圈形状由 `Empty002` 负责，它一次性生成了约 13 个粒子。

中间堆栈可以确认 `Empty002` 的模块顺序为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
  - `Shape Location`
  - `Add Velocity`
- `Particle Update`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sub UVAnimation`
- `Render`
  - `Sprite Renderer`

右侧 `Sprite Renderer` 细节面板当前可确认的渲染设置如下：

- `Material`：`M_Additive_01_Ins_03`
- `Source Mode`：`Particles`
- `Alignment`：`Velocity Aligned`
- `Facing Mode`：`Automatic`
- `Default Pivot in UV Space`：`(0.5, 0.9)`
- `Pixel Coverage Mode`：`Automatic`
- `Pixel Coverage Blend`：`1.0`
- `Sort Mode`：`None`
- `Sub UV Blending Enabled`：关闭
- `Sub Image Size`：`(8.0, 8.0)`
- `Cast Shadows`：开启
- `Sort Order Hint`：`30`

这说明 `Empty002` 这一层使用了 8x8 的 flipbook 火焰贴图，并且通过速度对齐与偏上的 UV Pivot，把每个粒子拉成沿速度方向甩开的火舌形态。
这张图继续选中 `Empty002`，右侧打开的是 `Particle Update` 阶段的 `Scale Color` 模块。当前时间约 `0.16s`，左侧预览可以看到中心亮斑和外圈火舌还处于较亮阶段，说明该模块正在控制粒子随生命周期衰减的亮度与透明度。

可确认的设置如下：

- `Scale Mode`：`RGB and Alpha Separately`
- `Scale RGB`：`Multiply Vector by Float`
  - `Vector`：`(10.0, 2.0, 2.0)`
  - `Float`：`Float from Curve`
  - `Curve Index`：`Particles.NormalizedAge`
  - `Scale Curve`：`2.0`
- `Scale Alpha`：`Float from Curve`
  - `Curve Index`：`Particles.NormalizedAge`
  - `Scale Curve`：`1.0`

两条曲线在画面中都表现为“随 `NormalizedAge` 从左到右持续下降”的衰减曲线：

- 上方 RGB 曲线起点接近 `1.0`，到生命周期末端收敛到接近 `0`
- 下方 Alpha 曲线同样从接近 `1.0` 线性衰减到接近 `0`

这意味着 `Empty002` 的外圈火舌在生成初期先乘上较高的亮度系数，随后随着粒子老化逐步降低颜色强度和透明度，避免火舌尾部始终保持硬亮边缘。

### 00:05:33-00:10:05 Emitter、UV、材质

- 本段定位：Emitter、UV、材质。
- 知识点：试着重新做个发射器吧。
- 知识点：干脆整个系统都重做,然后把发射梯复制过去。
- 知识点：还要再复制一个材质。
- 知识点：因为要替换纹理使用,所以这些要放入2号纹理。
- 知识点：这个纹理也是基本的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`材质`、`纹理`、`粒子`、`发射器`、`系统`、`速度`、`颜色`。

**关键画面：**

这张图回到关卡 `Ex_04` 的 PIE 运行画面，用于核对资源准备状态与实际角色挂接效果。场景中央是第三人称角色，角色背部能看到一个紫色发光部件；右侧 Outliner 显示当前仍在 `Ex_04 (Play In Editor)` 中，关卡里已有 `Lighting`、`Playground` 以及 `BP_ThirdPersonGameMode10`、`HUD0` 等运行时对象。

底部 Content Browser 当前定位在 `Content/Signature/Course_05/Material`，文件夹列表已不再只是前几页里出现的少量材质，而是扩展为 8 个资源，画面中可确认的名称包括：

- `M_Additive_01`
- `M_Additive_01_Ins_01`
- `M_Additive_01_Ins_02`
- `M_Additive_01_Ins_03`
- `M_Mesh_...`
- `M_Smoke_...`
- `MPC_Blur`
- `PP_Zoom`

当前高亮选中的是 `M_Additive_01_Ins_03`。这说明作者在重新整理发射器的同时，也同步准备了至少三份 `M_Additive_01` 的材质实例，后续不同发射器可以分别引用不同实例，以便替换纹理或调整颜色、UV、透明度等参数，而不必都共用同一份基础材质。
这张图显示作者在原有 `Empty002` 旁边又新增了一个发射器 `Empty003`。左侧时间轴里现在共有 4 个发射器：`Empty`、`Empty001`、`Empty002`、`Empty003`；其中当前选中的是 `Empty003`，时间轴位置约 `5.79s`。

左上角 `Particle Counts` 表明系统当下状态为：

- `Empty`：`0 Current, 1 Max (est.) [Complete]`
- `Empty001`：`0 Current, 1 Max (est.) [Complete]`
- `Empty002`：`5 Current, 13 Max (est.) [Inactive]`
- `Empty003`：`1 Current, 13 Max (est.) [Inactive]`

画面中央可见 `Empty002` 与 `Empty003` 两个发射器几乎并排同构，说明 `Empty003` 大概率是以 `Empty002` 为基础复制出来，用来额外补充外圈火舌或填充画面空隙。两者此时能确认的共同堆栈结构为：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location`：`Ring / Disc`
  - `Add Velocity`：`From Point`
  - `Add Velocity 001`：`Linear`
- `Particle Update`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sub UVAnimation`
- `Render`
  - `Sprite Renderer`

右侧选中的 `Spawn Burst Instantaneous` 参数当前可读为：

- `Spawn Count`：`1`
- `Spawn Time`：`0.0`
- `Spawn Probability`：`1.0`
- `Loop Count Limit`：`1`

这一张图的重点不是具体材质参数，而是说明作者没有只依赖单个外圈发射器，而是复制出第二个同类发射器，通过相近但可继续分化的 burst + ring/disc + velocity 结构，让外圈火焰的分布更容易填满空白区域。
这张图继续查看新复制出的发射器 `Empty003`，时间轴回到约 `0.07s` 的早期触发阶段。左侧预览里可以看到一条横向拉开的火焰亮带，说明 `Empty003` 这一层已经开始参与技能中心附近的亮带或外圈填充效果。

当前 `Particle Counts` 为：

- `Empty`：`1 Current, 1 Max (est.) [Active]`
- `Empty001`：`1 Current, 1 Max (est.) [Active]`
- `Empty002`：`13 Current, 13 Max (est.) [Active]`
- `Empty003`：`1 Current, 1 Max (est.) [Active]`

这表明在技能播放初段，四个发射器会同时参与叠加，而 `Empty003` 只放出极少量粒子，用来补一层局部结构，而不是承担主体火焰。

从中间堆栈可以确认 `Empty003` 相比上一张图又能明确看到一个额外模块：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location`：`Ring / Disc`
  - `Add Velocity`：`From Point`
  - `Add Velocity 001`：`Linear`
  - `Sprite Facing and Alignment`
- `Particle Update`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sub UVAnimation`
- `Render`
  - `Sprite Renderer`

右侧当前展开的是 `Solve Forces and Velocity`，可确认的限制参数为：

- `Speed Limit`：`1000.0`
- `Acceleration Limit`：`9999.0`
- `Manually Enable Rotation`：关闭

这说明 `Empty003` 除了沿用 ring/disc + velocity 的发射逻辑外，还显式加入了朝向/对齐控制，并通过较高的速度与加速度上限让粒子基本不受过早钳制，从而保留快速甩开的火焰拖拽感。

### 00:10:05-00:14:33 纹理

- 本段定位：纹理。
- 知识点：亮度稍后再控制一下不就好了。
- 知识点：这部分让前面的针适当快点显现。
- 知识点：把曲线的张力提高一点也不错。
- 知识点：感觉尺寸有点变大。
- 知识点：这部分要复制后左右做出来。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`曲线`。

**关键画面：**

这张图选中的是发射器 `Empty003` 的 `Sub UVAnimation` 模块，时间轴约在 `0.32s`。左侧预览里可以看到一条横向铺开的亮橙色火焰带，说明作者正在微调 flipbook 的播放节奏，而不是改动发射位置或材质连接。

右侧面板当前可确认的 `Sub UVAnimation` 设置为：

- `SubUV Animation Mode`：`Curve`
- `Start Frame Range Override`：关闭，数值框显示 `0`
- `End Frame Range Override`：关闭，数值框显示 `63`
- `Renderer Type`：`Sprite`
- `Sprite Renderer`：`Sprite Renderer`
- `Random Start Frame`：关闭
- `Start Frame Offset`：`0`
- `SubUV Curve`：`Curve for Floats`
- `SubUV Curve Index`：`Particles.NormalizedAge`

下方曲线图的走势不是线性匀速，而是“前段更快、后段趋缓”的上升曲线：

- 起点接近 `0`
- 中段在 `NormalizedAge=0.5` 左右已经推进到约 `0.7`
- 末段接近 `1.0`

这表示作者希望 flipbook 前几帧更早显现，粒子一出生就尽快进入火焰已展开的帧段，而不是慢吞吞从第一帧匀速推进。这样可以减少刚生成时的“针状/点状”感，让火焰更快长成完整形态。
这张图回到 `Ex_04 (Play In Editor)` 的运行预览，用来直接观察刚才那组纹理/曲线调整后的实际表现。角色站在画面中央，技能火焰已经在角色前方和左右两侧展开成一个近似环抱的形态：左右两边各有一束向上卷起的高火舌，底部则由一圈更亮、更厚的块状火焰把空间补满。

从画面结果可确认两点：

- 复制出来的左右分布已经生效，火焰不再只集中在单侧，而是形成比较对称的两翼结构
- 前景大块亮面说明 flipbook 前段显现速度被加快后，粒子更快进入“火焰已张开”的帧，减少了刚生成时过细过尖的感觉

底部 Content Browser 仍停在 `Content/Signature/Course_05/Material`，当前高亮资源是 `M_Additive_01_Ins_04`。这说明作者除了前一批已出现的 `Ins_01` 到 `Ins_03` 外，又新增了一份材质实例供这一层火焰使用或继续分配给复制出来的新发射器，以便单独调纹理/颜色而不影响其他层。
这张图处于 `Ex_04 (Play In Editor)` 的运行状态，但主要画面没有呈现清晰的火焰结构。可确认的信息只有：

- 角色站在测试场景中，镜头回到普通第三人称视角
- 底部 Content Browser 仍定位在 `Content/Signature/Course_05/Material`
- 当前高亮资源依然是 `M_Additive_01_Ins_04`
- 右下角出现 `Preparing Shaders (0) 100%` 状态提示
### 00:14:33-00:19:26 Color、Power、Curve

- 本段定位：Color、Power、Curve。
- 知识点：现在把数值适当调一下。
- 知识点：现在把所有选项都这样激活了。
- 知识点：本理就用内置了这个这个。
- 知识点：首先左右两侧的平铺必须变宽。
- 知识点：扩散器纹理的平铺也。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Curve`、`纹理`、`粒子`、`颜色`。

**关键画面：**

这张图处于 `Ex_04 (Play In Editor)` 的普通运行视角，当前技能效果没有正在屏幕中央播放，角色站在测试场地中央偏左位置。右侧 Outliner 仍是测试关卡的标准对象列表，说明作者此时主要是在内容浏览器里切换资源，而不是在 Niagara 图内直接编辑模块。

底部 Content Browser 仍位于 `Content/Signature/Course_05/Material`，资源数量继续增加到 `10 items`。当前高亮选中的是一份 `M_Mesh_..._Ins_01` 类型的网格材质实例；在它左侧还能看到此前的多份 `M_Additive_01_Ins_*`，右侧还能看到 `M_Smoke_...`、`MPC_Blur`、`PP_Zoom` 等资源。

这说明教程在进入 `Color / Power / Curve` 这段时，不只是继续调 sprite 火焰层，也开始准备 mesh 类材质实例，让后续某些粒子或网格层可以单独启用颜色、曲线或纹理平铺相关参数。
这张图打开的是材质实例 `M_Mesh_01_Ins_01`。左侧预览球当前显示为一层偏暗的能量/火焰噪声表面，右侧是完整的实例参数面板，说明这一段正在通过实例参数直接调颜色平铺、扩散纹理、边缘强度、透明度和折射，而不是改基础材质图。

可确认的 `Global Scalar Parameter Values` 如下：

- `Color_Tile_U`：`2.0`
- `Color_Tile_V`：`0.3`
- `Desaturation`：`0.8`
- `Diff_Tile_U`：`2.0`
- `Diff_Tile_V`：`0.7`
- `Edge_Pow`：`2.0`
- `Edge_Str`：`2.0`
- `Fade_Dist`：`5.0`
- `Normal_Tile_U`：`1.5`
- `Normal_Tile_V`：`0.35`
- `Opacity_Pow`：`0.5`
- `Opacity_Str`：`5.0`
- `Refraction_Str`：`1.2`
- `RGB_Offset`：`0.005`

可确认的 `Global Static Switch Parameter Values`：

- `Use_Refraction`：开启

可确认的 `Global Texture Parameter Values`：

- `Color_Tex`：`T_Color_01`
- `Diff_Tex`：`T_Soft_Energy_Trail_01`
- `Normal_Tex`：`T_Voronoi_Cells_02_NRM`
- `Opacity_Tex`：`T_Beam_Gradient_01`

结合参数命名与当前数值，这个实例的主要意图可以直接概括为：

- 把颜色层横向平铺拉宽：`Color_Tile_U=2.0`，纵向压缩：`Color_Tile_V=0.3`
- 扩散纹理同样做横向更宽的铺展：`Diff_Tile_U=2.0`，`Diff_Tile_V=0.7`
- 通过 `Edge_Pow / Edge_Str` 和 `Opacity_Pow / Opacity_Str` 强化边缘与透明度控制
- 打开折射并用法线纹理参与扰动，形成带流动感的能量外壳

这正对应本小节“Color、Power、Curve”的主题：先把所有相关参数激活，再通过材质实例把左右两侧需要的横向拉伸和扩散感做出来。
这张图回到 Niagara System `Ex_04_FireSkill`，系统里已经继续扩展出新的发射器 `Empty004` 和 `Empty005`。左侧时间轴当前共有 6 个发射器：`Empty`、`Empty001`、`Empty002`、`Empty003`、`Empty004`、`Empty005`；其中当前时间约 `0.81s`，`Particle Counts` 显示：

- `Empty`：`0 Current, 1 Max (est.) [Active]`
- `Empty001`：`0 Current, 1 Max (est.) [Active]`
- `Empty002`：`13 Current, 13 Max (est.) [Active]`
- `Empty003`：`1 Current, 1 Max (est.) [Active]`
- `Empty004`：`1 Current, 1 Max (est.) [Active]`
- `Empty005`：`1 Current, 1 Max (est.) [Active]`

左侧预览可见一圈带青紫边缘、橙色火舌顶端的环状效果，说明新加入的 mesh/材质层已经开始叠加到原先的 sprite 火焰外圈上。

中间堆栈中可确认：

- `Empty004` 仍使用 `Sprite Renderer`
- `Empty005` 的渲染器已经改为 `Mesh Renderer`
- `Empty005` 在 `Particle Update` 阶段新增了 `Dynamic Material Parameters`

右侧当前展开的是 `Empty005 -> Dynamic Material Parameters`，其中 `Dynamic Parameter Index 0` 的设置可确认如下：

- `Write Parameter Index 0`：开启
- 参数名：`Panning_Opacity`
- 值类型：`Float from Curve`
- 曲线索引：`Particles.NormalizedAge`
- `Scale Curve`：`1.0`
- 曲线走势：从生命周期前段约 `0.5` 左右逐步下降，到末端接近 `0`
- 同组内其他可见参数：
  - `Distortion`：`0.0`
  - `Param2-0`：`0.0`
  - `ColorPower`：`1.0`

这表示 `Empty005` 这一层不是靠固定材质值工作，而是把粒子年龄实时写回材质参数，用衰减曲线控制 `Panning_Opacity`。这样 mesh 层的流动纹理或透明度可以随生命周期逐步减弱，与前面通过材质实例调出的颜色/折射参数配合，形成更可控的能量边缘和消散过程。

### 00:19:26-00:24:25 Alpha、Multiply、速度

- 本段定位：Alpha、Multiply、速度。
- 知识点：就这种感觉这样放进去。
- 知识点：让火的纹理适当能感觉到。
- 知识点：现在的颜色感觉太生硬了。
- 知识点：先加入multiply by vector。
- 知识点：可以用vector curl适当调整下颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Multiply`、`纹理`、`序列`、`速度`、`颜色`、`火焰`。

**关键画面：**

这张图继续选中 `Empty005`，右侧仍打开 `Particle Update -> Dynamic Material Parameters`，但这次把 `Panning_Opacity` 曲线的中段控制点悬停信息显示出来，用于更细地调整透明度/流动感随生命周期的衰减节奏。

当前可确认的信息如下：

- 当前时间轴位置约 `0.97s`
- `Empty005` 仍使用 `Mesh Renderer`
- `Dynamic Parameter Index 0`
  - `Write Parameter Index 0`：开启
  - 参数名：`Panning_Opacity`
  - 类型：`Float from Curve`
  - `Curve Index`：`Particles.NormalizedAge`
  - `Scale Curve`：`1.0`
- 当前悬停的曲线控制点信息：
  - `Time`：`0.2`
  - `Value`：`0.285`

从整条曲线走势看，`Panning_Opacity` 不是末尾才骤降，而是在生命周期前 20% 左右就已经明显降到约 `0.285`，后面继续缓慢衰减到接近 `0`。这会让 mesh 层的火焰/能量边缘更早开始减弱，不至于整段时间都保持又厚又硬的亮边。

左侧预览中可见围绕中心的一圈青紫色能量边缘和少量橙色火舌，说明这条曲线主要影响的是外围 mesh 层的可见度，而不是中心 sprite 火焰主体。
这张图继续选中 `Empty005`，但右侧已经从动态材质参数切换到 `Particle Update -> Scale Color`，开始直接控制 mesh 层粒子的颜色倍率。左侧预览里的外围能量边缘明显偏红橙色，说明作者正在把之前偏青紫的颜色往火焰色系拉回，减少“颜色太生硬”的问题。

当前可确认的 `Scale Color` 设置为：

- `Scale Mode`：`RGB and Alpha Separately`
- `Scale RGB`：`Multiply Vector by Float`
  - `Vector`：`Vector from Curve`
  - `Vector Curve`：`Curve for Vector3's`
  - `Curve Index`：`Particles.NormalizedAge`
  - `Scale Curve`：`(1.0, 1.0, 1.0)`
  - `Float`：`1.0`
- `Scale Alpha`：`1.0`

右侧 `Vector Curve` 视图能确认：

- `X`（红）通道整体保持在较高正值，几乎是一条平直高线
- `Y`（绿）和 `Z`（蓝）通道在较低位置，且只有轻微变化
- 当前选中的关键点位于 `Key Data 0.5` 附近，表示中段生命周期也保持这种“红强、绿蓝弱”的配色关系

左下额外弹出的曲线编辑窗口显示一条红色 `FloatCurve`，走势是从起点约 `0.5` 持续下降，末端落到接近 `-0.1`。仅从当前画面可确认这是某个与当前调色流程相关的衰减曲线，但无法仅凭这一帧确定它具体绑定到哪个参数，因此不把它强行归属到 `Scale Color` 的某一项。

综合这张图可以确认，本段的“先加入 multiply by vector”就是让 `Empty005` 通过矢量曲线按生命周期控制 RGB 权重，核心目的是把外围 mesh 层的综合色调压向红橙火焰色，同时保留一定的边缘色偏变化。
这张图回到 `Ex_04 (Play In Editor)` 的运行视角，角色正在做动作过渡，但当前帧里几乎看不到清晰的 Niagara 火焰结果。能确认的信息只有：

- 右侧 Outliner 仍显示测试关卡运行时对象
- 底部 Content Browser 定位在 `Content/Signature/Course_05/Material`
- 当前高亮资源是 `M_Mesh_01_Ins_01`
- 角色身体附近只有很弱的发光痕迹，无法据此可靠区分是 mesh 能量层、sprite 火焰层还是角色自带特效

由于这一帧没有提供明确可辨的火焰结构，也看不出 `Alpha / Multiply / 速度` 调整后的具体可视结果，因此只能确认作者当时是在运行态配合 `M_Mesh_01_Ins_01` 做效果观察，具体观察结论需要人工结合相邻视频帧复核。
### 00:24:25-00:29:16 UV、后期处理、发射器

- 本段定位：UV、后期处理、发射器。
- 知识点：参数有点没起作用。
- 知识点：如果想减少这部分。
- 知识点：需要加上去保合度。
- 知识点：或者现在这种感觉。
- 知识点：顺序适当改变一下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`贴图`、`发射器`。

**关键画面：**

这张图继续选中 `Empty005 -> Scale Color`，属于下一小节 `UV、后期处理、发射器` 的开头，但实际仍在细调 mesh 层的颜色倍率曲线。和前一张相比，这次右侧把 `Scale RGB` 里的 `Float from Curve` 部分完整展开了，因此可以更明确看出颜色强度随生命周期的变化规律。

当前可确认的 `Scale Color` 结构为：

- `Scale Mode`：`RGB and Alpha Separately`
- `Scale RGB`：`Multiply Vector by Float`
  - `Vector`：`Vector from Curve`
  - `Vector Curve`：`Curve for Vector3's`
  - `Curve Index`：`Particles.NormalizedAge`
  - `Scale Curve`：`(1.0, 1.0, 1.0)`
  - `Float`：`Float from Curve`
    - `Curve for Floats`
    - `Curve Index`：`Particles.NormalizedAge`
    - `Scale Curve`：`5.0`
- `Scale Alpha`：`Float from Curve`

其中下方浮点曲线可见的关键形态为：

- 起点接近 `1.0`
- 中段缓慢下降
- 后段继续衰减到约 `0.5` 附近
- 当前选中的中部关键点 `Key Data` 为 `0.5`

左下独立弹出的红色 `FloatCurve` 窗口则显示另一条更陡的衰减曲线：从约 `0.5` 快速降到末端接近 `-0.1`。仅从当前图面可确认它属于当前发射器相关的曲线编辑状态，但不能仅凭这一帧断言它与右侧哪一个具体字段一一对应，因此不强行绑定。

结合左侧预览里更暗、更贴边的红色能量轮廓，这张图说明作者正在把 `Empty005` 的颜色输出分成两层控制：

- 用 `Vector from Curve` 决定 RGB 色相比例
- 用额外的 `Float from Curve` 决定整体颜色强度沿生命周期的衰减幅度

这样 mesh 边缘既能保留火焰红橙色，又能通过更高的倍率和后续衰减控制出“先亮后弱”的过渡。
这张图回到 `Ex_04 (Play In Editor)` 的实际效果预览，用来检验前面 `Empty005` 调整后的颜色与强度是否合适。角色站在火焰中心偏后位置，周围已经形成一个较完整的环状火圈：

- 外圈是连续的红橙色流动边缘
- 内圈有更亮、更厚的块状火焰团
- 环形并非完全均匀，前景和左右两侧有明显的火舌堆积与缺口变化，说明它仍由多个 emitter 叠加而成，而不是单张均匀贴图

这张图还能确认当前观察时底部 Content Browser 仍选中 `M_Mesh_01_Ins_01`，说明屏幕中这圈较平铺、较贴地的外围火焰至少有一部分正受这份 mesh 材质实例驱动。

相较前几张偏青紫或边缘过硬的状态，这一帧里的外围颜色已经更接近火焰语义：

- 主体偏橙黄
- 外缘保留红色拖尾
- 明暗过渡更自然，贴地环形轮廓更容易读出

因此这张图可以视为前面 `Multiply by Vector` 与强度曲线调整后的直观结果：mesh 层的颜色被拉回到火焰色系，同时与中心 sprite 火焰融合成一个更完整的地面火环。
这张图再次打开 mesh 材质实例参数页，当前标签看起来仍是 `M_Mesh_01_Ins_01` 系列实例。左侧预览球非常暗，只剩少量亮斑和边缘反射，说明作者正在把材质实例往“更可控、更克制”的方向继续压参数，而不是追求预览球里直接看见很亮的火焰。

这次画面里能可靠读出的 `Global Scalar Parameter Values` 为：

- `Color_Tile_U`：`2.0`
- `Color_Tile_V`：`0.3`
- `Desaturation`：`0.5`
- `Diff_Tile_U`：`2.0`
- `Diff_Tile_V`：`0.5`
- `Edge_Pow`：`2.0`
- `Edge_Str`：`2.0`
- `Fade_Dist`：`5.0`
- `Normal_Tile_U`：`1.0`
- `Normal_Tile_V`：`0.2`
- `Opacity_Pow`：`0.5`
- `Opacity_Str`：`10.0`
- `Refraction_Str`：`1.2`
- `RGB_Offset`：`0.005`

可确认的 `Global Static Switch Parameter Values`：

- `Use_Refraction`：开启

可确认的 `Global Texture Parameter Values` 仍为：

- `Color_Tex`：`T_Color_01`
- `Diff_Tex`：`T_Soft_Energy_Trail_01`
- `Normal_Tex`：`T_Voronoi_Cells_02_NRM`
- `Opacity_Tex`：`T_Beam_Gradient_01`

与前面 `S04_2` 那张材质实例图相比，这一轮明显发生了几处调整：

- `Desaturation` 从 `0.8` 降到 `0.5`
- `Diff_Tile_V` 从 `0.7` 降到 `0.5`
- `Normal_Tile_U` 从 `1.5` 降到 `1.0`
- `Normal_Tile_V` 从 `0.35` 降到 `0.2`
- `Opacity_Str` 从 `5.0` 提高到 `10.0`

这些变化说明作者在进一步压缩纵向平铺与法线扰动，同时大幅提高透明度强度，让 mesh 层更集中地贡献清晰边界和可读轮廓，而不是靠过强的法线噪声或过杂的颜色变化抢主体火焰的视觉中心。

### 00:29:16-00:30:10 关键流程 07

- 本段定位：关键流程 07。
- 知识点：可以这样包在上面走。
- 知识点：这部分就会反过来。
- 知识点：这个应该说明更短点吧。
- 知识点：这个是用来让语音更长的。
- 知识点：这个是一直扩散到最后才消失的。

**关键画面：**

这张图显示 `Ex_04_FireSkill` 又新增了一个发射器 `Empty006`。中间可见 `Empty005` 与 `Empty006` 并排存在，两者都属于 mesh 层相关的发射器结构；左上 `Particle Counts` 也已增加到 `Empty006`，当前状态为：

- `Empty`：`0 Current, 1 Max (est.) [Active]`
- `Empty001`：`0 Current, 1 Max (est.) [Active]`
- `Empty002`：`13 Current, 13 Max (est.) [Active]`
- `Empty003`：`1 Current, 1 Max (est.) [Active]`
- `Empty004`：`1 Current, 1 Max (est.) [Active]`
- `Empty005`：`1 Current, 1 Max (est.) [Active]`
- `Empty006`：`1 Current, 1 Max (est.) [Active]`

当前选中的是 `Empty006 -> Mesh Renderer`。右侧 `Mesh Rendering` 面板可确认：

- `Meshes`
  - `Index [0]`：`Half_Sphere_01`
- `Enable Material Overrides`：开启
- `Override Materials`
  - `Index [0] -> Explicit Mat`：`M_Mesh_01_Ins_02`
- `User Param Binding`：`None`
- `Source Mode`：`Particles`
- `Locked Axis Enable`：关闭
- `Enable Mesh Flipbook`：关闭
- `Facing Mode`：`Default`
- `Sort Mode`：`None`

中间堆栈可以看到 `Empty006` 的结构与 `Empty005` 高度相似，包含：

- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
  - `Dynamic Material Parameters`
  - `Scale Color`
- `Render`
  - `Mesh Renderer`

这说明教程最后一步并不是继续只调现有 mesh 层，而是复制出第二个同类 mesh emitter，并把材质实例切到 `M_Mesh_01_Ins_02`。结合小节文字“这部分就会反过来”，可以把这一步理解为：在保持同类流程的前提下，再增加一个方向或包裹关系相反的 mesh 半球层，用来从另一侧补完整体扩散包裹效果。
这张图继续选中 `Empty006`，右侧打开的是 `Particle Spawn -> Initialize Particle`。左侧预览中此时已经能看到更完整的中心爆发效果，说明 `Empty006` 的基础粒子初始化已经开始参与最终合成。

当前可确认的 `Initialize Particle` 设置如下：

- `Point Attributes`
  - `Lifetime Mode`：`Direct Set`
  - `Lifetime`：`0.75`
  - `Color Mode`：`Unset`
  - `Position Mode`：`Simulation Position`
  - `Position Offset`：未启用，显示 `(0.0, 0.0, 0.0)`
  - `Mass Mode`：`Unset / (Mass of 1)`
- `Sprite Attributes`
  - `Sprite Size Mode`：`Unset`
  - `Sprite Rotation Mode`：`Unset`
  - `Sprite UV Mode`：`Unset`
- `Mesh Attributes`
  - `Mesh Scale Mode`：`Uniform`
  - `Mesh Uniform Scale`：`0.45`
  - `Mesh Renderer Array Visibility`：`Unset`
- `Ribbon Attributes`
  - `Ribbon Width Mode`：`Unset`
  - `Ribbon Facing Mode`：`Unset`
  - `Ribbon Twist Mode`：`Unset`

这说明 `Empty006` 作为 mesh 发射器的初始化方案相当简洁：不依赖 sprite/ribbon 相关属性，只给一个较短的固定生命周期 `0.75s`，并把半球网格统一缩放到 `0.45`。结合上一张已确认的 `Half_Sphere_01 + M_Mesh_01_Ins_02`，可以把它理解为一个短时存在、尺寸较小的附加包裹层，用于在主火环外再叠一层方向相反或覆盖更短的 mesh 外壳。
这张图仍然选中 `Empty006 -> Initialize Particle`，但时间已经走到本页结尾，左上 `Particle Counts` 显示所有发射器都处于 `Complete`：

- `Empty`
- `Empty001`
- `Empty002`
- `Empty003`
- `Empty004`
- `Empty005`
- `Empty006`

全部都是 `0 Current`，说明整套火焰技能已经完整播放结束。这一帧的重点不再是观察播放中的视觉效果，而是继续微调 `Empty006` 的初始化参数。

与上一张相比，当前右侧最明显的变化是 `Mesh Attributes`：

- `Mesh Scale Mode`：`Non-Uniform`
- `Mesh Uniform Scale` 字段仍显示 `0.45`
- `Mesh Renderer Array Visibility`：`Unset`

其余仍能确认的初始化项包括：

- `Lifetime Mode`：`Direct Set`
- `Lifetime`：`0.75`
- `Position Mode`：`Simulation Position`
- `Position Offset`：`(0.0, 0.0, 0.0)`
- `Mass Mode`：`Unset / (Mass of 1)`

从流程上看，这一步说明作者在最后收尾时把 `Empty006` 从“统一缩放的附加半球层”进一步改成“允许按非均匀方式缩放的半球层”。虽然当前截图里还看不到具体 XYZ 分量输入框，但仅凭 `Mesh Scale Mode` 的变化，已经可以确认其目的就是让这层网格不再只能等比放大缩小，而是能按某一方向拉长、压扁或反转包裹范围，用来更精细地控制教程里提到的“包在上面走”“反过来”“一直扩散到最后才消失”的收尾外壳效果。

## 补充视觉证据

### S04 00:18:48

这是一张对 `S04 00:18:48` 的 Niagara 参数补充截图。当前打开的是 Niagara System `Ex_04_FireSkill`，左侧时间轴和系统总览中可见多个发射器，当前选中的是 `Empty005`。右侧 `Details` 面板定位在该发射器的 `Dynamic Material Parameters` 模块，用来控制材质中的动态参数曲线。

当前图中可直接确认的系统/发射器结构：
- Niagara System：`Ex_04_FireSkill`
- 当前选中发射器：`Empty005`
- 左侧发射器列表可见：
  - `Empty`
  - `Empty001`
  - `Empty002`
  - `Empty003`
  - `Empty004`
  - `Empty005`
- 预览窗口当前处于编译中，左侧日志显示：
  - `Compiling Emitter - Empty`
  - `Compiling Emitter - Empty001`
  - `Compiling Emitter - Empty002`
  - `Compiling Emitter - Empty003`
  - `Compiling Emitter - Empty004`
  - `Compiling Emitter - Empty005`

`Empty005` 当前可见的模块结构：
- `Emitter Spawn`
- `Emitter Update`
- `Particle Spawn`
  - `Initialize Particle`
- `Particle Update`
  - `Particle State`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

`Dynamic Material Parameters` 当前可确认的设置：
- 当前查看页签：`Index 0`
- `Dynamic Parameter Index 0`
  - `Write Parameter Index 0` = 开启
  - 参数名：`Panning_Opacity`
  - 参数驱动方式：`Float from Curve`
- `FloatCurve`
  - 曲线类型：`Curve for Floats`
  - `CurveIndex = [PARTICLES] NormalizedAge`
  - `Scale Curve = 1.0`
  - 曲线起点约为 `0.8`
  - 曲线终点约为 `0.1`
- 同页还能看到的附加参数：
  - `Distortion = 0.0`
  - `Param2-0 (...) = 0.0`
  - `ColorPower = 1.0`
- `Dynamic Parameter Index 1/2/3` 的 `Write Parameter Index` 当前未开启

这张补充图的作用是把该发射器材质动态参数的衰减曲线补齐。可直接确认的是：`Empty005` 在粒子更新阶段通过 `Dynamic Material Parameters` 把 `Panning_Opacity` 绑定到 `NormalizedAge` 曲线，并让数值随生命周期大致从 `0.8` 下降到 `0.1`。这意味着后续材质中的平移透明度/强度会随粒子年龄逐步减弱；当前图没有展示材质图内部具体读取该参数的节点，因此这里只能确认 Niagara 侧写入逻辑和曲线形态。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


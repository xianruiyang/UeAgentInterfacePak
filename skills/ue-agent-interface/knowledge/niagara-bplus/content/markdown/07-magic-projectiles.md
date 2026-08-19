# 07 Magic Projectiles

# 07 Magic Projectiles

## 关键术语

- `System`、`Lifetime`、`Velocity`、`Color`、`Scale Color`、`Ribbon`、`Material`、`UV`、`Add`、`Texture`、`Blueprint`、`Camera`、`Niagara`、`Renderer`、`材质`、`Niagara System`、`Emitter`、`Particle`

## 分段知识

### 00:00:05-00:03:07 System、Color、Scale Color

- 本段定位：System、Color、Scale Color。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Scale Color` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Particle`、`Color`、`Scale Color`、`Sequencer`、`Add`。

**关键画面：**

这张图切到 `Blender 3.6.0`，教程开始为后续 Niagara 效果准备一个简单的建模基础体。当前对象模式下，场景里已经新建并选中一个 `Cylinder`，作者字幕说明接下来会“去掉上下部分”，说明这个圆柱只是用于进一步加工成开口或环状网格的起点。

当前可确认的软件与对象状态：
- 软件：`Blender`
- 模式：`Object Mode`
- 视图：`User Perspective`
- 当前选中对象：`Cylinder`
- 右侧 `Transform` 面板显示：
  - `Location X/Y/Z = 0 m`
  - `Rotation X/Y/Z = 0°`
  - 旋转模式：`XYZ Euler`
  - `Scale X/Y/Z = 1.000`

左下角新增圆柱参数面板可见设置：
- `Vertices = 32`
- `Radius = 1 m`
- `Depth = 2 m`
- `Cap Fill Type = N-Gon`
- `Generate UVs` 已勾选
- `Align = World`
- `Location X/Y/Z = 0 m`
- `Rotation X/Y/Z = 0°`

这张图能支持的复现结论是：在 Blender 中先创建一个默认朝向的圆柱体，保持 32 边、半径 1 米、深度 2 米，并保留上下封盖；下一步才会进入编辑阶段删除顶部和底部面，逐步把它改造成适合冲击波/壳体效果的网格。
这张图回到 Unreal 关卡视口，作者一边观察投射物撞击圆柱体的结果，一边在 `Content Browser` 的 `Meshes` 目录里选中新做好的网格资源。它的作用是确认 Blender 中加工过的圆柱体已经导入到 UE 工程，并且可以作为命中特效的测试或替代网格。

关卡预览中可确认的信息：
- 紫粉色投射物从左向右撞向白色圆柱目标
- 命中点正在发亮，地面能看到紫色反射
- 这说明当前仍在测试 `MagicProjectiles` 的命中特效镜头，而不是单独查看静态资源

资源浏览器中可确认的信息：
- 当前目录：`Content > VFX_Library > Meshes`
- 当前选中的资源名称显示为 `T_Cylinder Height`
- 缩略图形状是一个带底座和上端收口的柱状轮廓，不再是普通实心圆柱
- 同目录仍可见 `SM_Circle_01`、`SM_Cone_01`、`SM_Cylinder_01`、`SM_CylinderBowl_01`、`SM_Ring_01` 等资源
- 底部状态栏显示当前列表中有 `13 item (1 selected)`

从这张图可以得到的复现结论是：教程已经把 Blender 里处理过的圆柱相关网格导入 UE，并在 `VFX_Library/Meshes` 中作为新资源保存；随后会用它继续测试投射物/冲击波的颜色与形体效果。
这张图回到 `NS_MagicProjectiles_Impact` 的系统编辑界面，当前选中发射器是 `Shockwave_Multiple`，右侧展开的是它的 `Mesh Renderer`。和前一张对应起来看，教程此时已经把刚导入的柱状网格资源正式接到命中发射器上，用它替代原先更平面的冲击波形体。

发射器栈可见结构：
- 发射器：`Shockwave_Multiple`
- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

右侧 `Mesh Renderer` 当前确认的关键设置：
- `Meshes[0] = T_CylinderHeight`
- `LODMode = LODLevel`
- `LOD Level = 0`
- `Scale = (1.0, 1.0, 1.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Pivot Offset = (0.0, 0.0, 0.0)`
- `Pivot Offset Space = Mesh`
- `Enable Material Overrides` 已启用
- `Override Materials[0] -> Explicit Mat = MI_Shockwave_01`
- `User Param Binding = None`
- `Source Mode = Particles`
- `Facing Mode = Camera Plane`
- `Sort Mode = None`
- `Enable Frustum Culling` 未启用
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 11`
- `Motion Vector Setting = Auto Detect`

从字幕“这应该在冲击时发生，而且不应该朝我们这边”可以确认当前调试目标：让 `Shockwave_Multiple` 在命中时才出现，并且新柱状网格的方向不要朝向镜头平铺。就图中已展示的状态而言，教程已经先完成了两件事：
- 把 `Mesh Renderer` 的网格切到 `T_CylinderHeight`
- 保留 `MI_Shockwave_01` 作为覆盖材质，以便继续配合 `Initial Mesh Orientation` 和动态参数调整最终视觉方向

### 00:03:07-00:06:37 Lifetime、Material、UV

- 本段定位：Lifetime、Material、UV。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Lifetime`、`Alpha`、`Opacity`、`Material`、`Noise`、`Add`、`Panner`。

**关键画面：**

这张图是在 Unreal 关卡视口和 Sequencer 中直接观察命中特效结果。主投射物从左向右打到白色圆柱目标，地面有明显紫色反射，但字幕说明“有些地方我看不见他”，说明当前效果存在局部不可见或被遮挡的问题，因此这张图主要用于验证 `Lifetime`、材质透明度和显示时机是否合适。

画面中可确认的信息：
- 紫粉色主投射物沿地面飞向白色圆柱
- 圆柱左侧附近出现发光命中区域，但并非所有层都稳定可见
- 地面棋盘格上出现较强的紫色反射，说明发光层和材质已经在工作
- 左上视口图标显示当前仍在编辑器实时视口中观察，而不是单独的 Niagara 预览

Sequencer 轨道可见信息：
- 轨道包含 `Camera Cuts`、`CineCameraActor`、`Gideon_Inquisitor`、`NS_Glow_Anticipation`、`NS_MagicProjectiles`、`NS_MagicProjectiles_Impact`
- 当前播放头约在 `2.3667` 秒
- 三条 Niagara 轨道在这段时间内发生重叠，说明作者在检查飞行层和命中层叠加时的可见性

这张图对应的复现要点是：在 `Lifetime、Material、UV` 调整阶段，需要回到最终镜头里核对投射物是否在某些角度或时刻被遮住、裁切或透明度衰减过快；仅从本图可确定的问题现象是“部分效果看不见”，但具体是 `Lifetime`、材质透明度还是 UV/Noise 造成，需要后续面板图进一步确认。
这张图在 `NS_MagicProjectiles_Impact` 中选中了发射器 `Shockwave_Multiple` 的 `Initialize Particle` 模块。它直接对应本段的 `Lifetime` 调整，同时把命中壳体的初始颜色和网格缩放一起设定出来。

发射器栈可见结构：
- 发射器：`Shockwave_Multiple`
- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

`Initialize Particle` 当前可确认的设置如下：
- 当前页签：`All`
- `Lifetime Mode = Direct Set`
- `Lifetime = 1.0`
- `Color Mode = Direct Set`
- `Color =` 浅粉紫色
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`

Sprite 属性区可见：
- `Sprite Size Mode = Unset`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

Mesh 属性区可见：
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale = (3.0, 3.0, 1.0)`
- `Mesh Renderer Array Visibility Mode = Unset`

Ribbon 属性区可见：
- `Ribbon Width Mode = Unset`
- `Ribbon Facing Mode = Unset`
- `Ribbon Twist Mode = Unset`

这张图能直接支持的复现结论是：`Shockwave_Multiple` 这一层命中网格壳体的存活时间被设为 `1.0` 秒，颜色先给成浅粉紫色，同时把网格在平面两个轴向放大到 `3.0`、厚度轴保持 `1.0`，以便形成更宽的冲击波外形。
这张图回到 Sequencer 最终镜头，用来验证调过 `Lifetime`、颜色和网格尺寸后的命中效果是否适合“朝镜头方向击中”的构图。字幕明确说明“这是我们的投射物击中我们的地方，以至于我们有了晃动的摄像头”，因此这张图的重点是命中位置与镜头反馈，而不是新的节点参数。

画面中可确认的信息：
- 角色站在左侧，主投射物从角色方向飞向右侧白色圆柱
- 命中点亮度很高，圆柱左侧形成强白光和紫粉色外溢
- 地面在圆柱前方出现明显紫色反射光斑
- 主投射物流带在接近目标时仍保持连续，没有在命中前消失

Sequencer 轨道与时间信息：
- 当前播放头约在 `2.2333` 秒
- 可见轨道仍包含 `Camera Cuts`、`CineCameraActor`、`Gideon_Inquisitor`、`NS_Glow_Anticipation`、`NS_MagicProjectiles`、`NS_MagicProjectiles_Impact`
- `NS_MagicProjectiles` 与 `NS_MagicProjectiles_Impact` 在当前时间内叠加播放，对应“投射物命中并触发镜头反馈”的时刻

这张图支持的复现结论是：本段调参的目标不是只让冲击波网格本身可见，而是让它在镜头正对命中区域时仍能读得清，并和相机反馈配合成立。就图中结果看，命中爆点、流带和地面反射已经足以支撑“正面命中 + 摄像机晃动”的镜头设计。

### 00:06:37-00:11:25 Color、Ribbon、Material

- 本段定位：Color、Ribbon、Material。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：蓝图 Actor 用于封装 Niagara 生成、位置、参数传入和生命周期控制。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Color`、`Alpha`、`Opacity`、`Material`、`Blueprint`、`Add`、`Panner`。

**关键画面：**

这张图继续在关卡视口里观察主投射物命中圆柱的结果，同时把 `Content Browser` 切到 `VFX_Library > Blueprints`。结合本段主题里的 `Blueprint`，这张图的作用是确认除了 Niagara 和材质本身，教程还通过蓝图类资源组织镜头反馈或投射物生成逻辑。

画面中可确认的信息：
- 角色站在左侧，紫粉色投射物从左向右撞向白色圆柱
- 命中点保持高亮，地面仍有紫色反射
- 当前镜头是正对命中区域的广角观察，用来判断效果是否在蓝图驱动下正确触发

蓝图资源浏览器中可确认的信息：
- 当前目录：`Content > VFX_Library > Blueprints`
- 列表中可见两个蓝图类资源
- 左侧资源名可读为 `BP_CameraShake_Tornado`
- 右侧资源名只可可靠读到前缀 `MagicProjec...`，可确认它是一个 `Blueprint Class`
- 底部状态栏显示 `2 items (1 selected)`

这张图能支持的复现结论是：教程此时已经把与镜头震动或投射物逻辑相关的蓝图资源放在 `VFX_Library/Blueprints` 中，并在最终关卡镜头里联动验证 `MagicProjectiles` 的命中表现；但仅凭此图不能可靠断定右侧蓝图的完整类名和内部实现。
这张图把 Sequencer 的相机轨道展开到了可编辑状态，直接展示命中镜头的 `Camera Shake` 设置。结合前一张中的蓝图资源，这里已经能确认实际被用到的抖动类名和它挂载在 `CineCameraActor` 的时序位置。

Sequencer 中可确认的相机轨道结构：
- 当前选中对象：`CineCameraActor`
- 已展开的相机属性轨道包括：
  - `Current Aperture`
  - `Current Focal Length`
  - `Manual Focus Distance`
  - `Camera Shake`
  - `Transform`
- `Camera Shake` 轨道下可见多条实例条目，名称都显示为 `BP_CameraShake_MagicProjectile_C`

时间与镜头信息：
- 当前播放头约在 `2.3333` 秒
- `BP_CameraShake_MagicProjectile_C` 的条目覆盖命中发生区间，说明镜头震动不是全程开启，而是在投射物击中附近短时触发
- 右侧详情面板显示当前相机的镜头参数，例如：
  - `Current Focal Length = 48.164337`
  - `Current Aperture = 2.8`
  - `Current Focus Distance = 100000.0`

关卡视口中的命中效果仍可见：
- 角色在左，圆柱目标在右
- 投射物流带撞向圆柱侧面
- 地面上有紫色反射光斑

这张图支持的复现结论是：命中镜头的抖动效果通过 Sequencer 中 `CineCameraActor` 的 `Camera Shake` 轨道驱动，实际调用的蓝图类名为 `BP_CameraShake_MagicProjectile_C`，并且它和投射物命中时刻对齐播放。
这张图回到 `NS_MagicProjectiles` 的系统总览，教程开始查看与 Ribbon 相关的发射器结构。系统视图中能直接看到 `Source`、`Ribbon_Glow`、`Ribbon_Magic` 三个发射器，而右侧详情面板显示当前选中的发射器名为 `Shockwave_Start001`。本图的主要价值是确认该类发射器的生命周期、CPU 仿真方式和一次性 Burst 生成参数。

系统视图中可见的发射器与模块概况：
- `Source`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Add Velocity 001`
  - `Particle State`
  - `Scale Velocity`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size`
  - `Sprite Renderer`
- `Ribbon_Glow`
  - 可见其 `Render` 使用 `Ribbon Renderer`
- `Ribbon_Magic`
  - 可见其 `Render` 使用 `Ribbon Renderer`

右侧当前选中发射器 `Shockwave_Start001` 的已确认设置：
- `Local Space` 未启用
- `Determinism` 未启用
- `Interpolated Spawning` 已启用
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`

`Emitter State` 区域可见参数：
- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Once`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`

`Spawn Burst Instantaneous` 区域可见参数：
- `Spawn Count = 1`
- `Spawn Time = 0.0`
- `Spawn Probability = 1.0`
- `Loop Count Limit = 1`

这张图支持的复现结论是：本段除了镜头与材质调试，还在确认 Ribbon/附属发射器的生命周期必须是一次性、短时、CPU 仿真的 Burst 结构，从而保证命中或流带类效果按时触发、播放完后自动结束，而不是无限循环。

### 00:11:25-00:14:30 Velocity、Ribbon、Texture

- 本段定位：Velocity、Ribbon、Texture。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：通过 Add Velocity 或速度范围控制粒子运动方向和力度，必要时给最小/最大值增加随机性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Velocity`、`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`。

**关键画面：**

这张图在 `NS_MagicProjectiles_Impact` 中选中了发射器 `Shockwave_Start` 的 `Dynamic Material Parameters`。它延续前面命中壳体的动态材质控制，但这里已经把折射相关参数的强度进一步拉高，用来配合本段的 `Texture` 与 `Material` 调整。

发射器栈中可确认的模块顺序：
- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
  - `Shape Location Sphere`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

`Dynamic Material Parameters` 当前可见设置：
- 当前页签：`All`
- `Dynamic Parameter Index 0` 已启用
- `Write Parameter Index 0` 已启用

Index 0 内当前可见参数：
- `Offset`
  - 写入方式：`Float from Curve`
  - `Curve for Floats = PARTICLES.NormalizedAge`
  - 曲线从接近 `0.0` 起步，随生命周期上升到接近 `1.0`
  - `Scale Curve = 1.0`
- `Refraction`
  - 写入方式：`Float from Curve`
  - `Curve for Floats = PARTICLES.NormalizedAge`
  - 曲线从高值向低值衰减
  - `Scale Curve = 3.0`
- `Noise Influence = 1.0`
- `Param3-0 = 0.0`

其他索引状态：
- `Dynamic Parameter Index 1` 未启用
- `Dynamic Parameter Index 2` 未启用
- `Dynamic Parameter Index 3` 未启用

这张图支持的复现结论是：`Shockwave_Start` 的命中材质继续通过 `NormalizedAge` 驱动 `Offset` 与 `Refraction` 两条曲线，其中折射强度缩放已提高到 `3.0`，说明教程在强化命中瞬间的屏幕折射和材质形变感。
这张图回到关卡视口观察投射物飞行阶段的结果，同时把 `Content Browser` 切到 `VFX_Library > Materials > Instances > MagicProjectiles`。画面里能量流带尚未击中圆柱，说明作者正在对飞行中的 `Ribbon` 或拖尾材质进行资源级核对，而不是只看命中瞬间。

关卡画面中可确认的信息：
- 角色位于左侧，前方有多道紫粉色流带向右飞行
- 圆柱目标位于右侧，当前尚未被击中
- 地面已有明显紫色光斑，说明飞行中的材质发光本身已经在影响环境反射

当前资源目录与可见材质实例：
- 当前目录：`Content > VFX_Library > Materials > Instances > MagicProjectiles`
- 当前选中资源：`MI_Source`
- 同一目录中还能看到：
  - `MI_ChromaRing_01`
  - `MI_Flare_01`
  - `MI_Flare_02`
  - `MI_Glow_01`
  - `MI_Glow_Alpha_01`
  - `MI_MagicRibbon_01`
  - `MI_MagicRibbon_02`
  - `MI_SceneRadialBlur_01`
  - `MI_Shockwave_01`
  - `MI_Smoke_Alpha_01`
- 底部状态栏显示 `11 items (1 selected)`

这张图支持的复现结论是：`MagicProjectiles` 这一套效果不是单一材质驱动，而是依赖一组专门的材质实例分别处理光环、拖尾、Shockwave、烟雾和源头亮点；当前飞行阶段至少已经在和 `MI_Source`、`MI_MagicRibbon_*` 这一类实例一起对照测试。
这张图继续在最终镜头里观察飞行中的投射物外观变化。和上一张相比，画面焦点更明确地落在两条紫粉色流带前端的高亮“源点”上，说明作者已经对材质实例或动态参数做了修改，并立即回到 Sequencer 里验证变化是否更易读。

画面中可确认的结果：
- 角色位于左侧，右侧白色圆柱仍未被击中
- 两条主流带前端都出现非常亮的白色/粉色核心光点
- 拖尾主体仍保持紫粉色纹理和粒状噪声感
- 地面反射集中在前端亮点附近，比单纯拖尾更显眼

Sequencer 中仍可见的镜头相关信息：
- 当前播放头约在 `1.6775` 秒
- `CineCameraActor` 轨道下仍存在多条 `Camera Shake`
- 抖动条目名称仍可见为 `BP_CameraShake_MagicProjectile_C`
- 说明作者是在完整镜头上下文里观察材质变化，而不是脱离相机效果单独调材质

这张图支持的复现结论是：本段对 `Velocity、Ribbon、Texture` 的调整已经直接改变了飞行阶段的可见轮廓，尤其是前端亮点和拖尾强度；作者通过在 Sequencer 中边播放边观察，确认改动后的投射物源头更清晰、更适合进入后续命中镜头。

### 00:14:34-00:14:50 关键画面

- 本段定位：关键画面。
- 知识点：围绕当前效果继续调整 Niagara 系统，需结合关键画面确认实际节点和参数。

**关键画面：**

这张图是在关卡视口里观察飞行中的三道投射物流带，同时把 `Content Browser` 切到 `VFX_Library > Textures > Shapes`。字幕“Play with shapes”说明本段正在通过替换或筛选形状贴图来改变投射物头部和拖尾的视觉轮廓。

关卡画面中可确认的信息：
- 角色位于左侧，向右发出三道紫粉色投射物流带
- 三个高亮源点位于拖尾前端，形状和亮度已经比较接近统一的尖头/星芒外观
- 右侧白色圆柱目标尚未被击中，当前主要观察飞行阶段而非命中
- 地面有大面积紫色反射，前端亮点对反射贡献最大

纹理资源浏览器中可确认的信息：
- 当前目录：`Content > VFX_Library > Textures > Shapes`
- 能看到大量白底黑底的形状贴图缩略图，包含拖尾、尖刺、星芒、圆斑等轮廓
- 当前列表中可读的资源名称包括：
  - `T_Muzzle10`
  - `T_Muzzle11`
  - `T_Muzzle12`
  - `T_Muzzle13`
  - `T_Prec..._2x2`（名称后半段在图中不完整）
  - `T_Projectile1`
  - `T_Projectile2`
  - `T_Projectile3`
  - `T_Projectile4`
  - `T_Projectile5`
  - `T_Projectile6`
  - `T_Projectile7`
  - `T_Projectile8`
  - `T_Projectile9`
  - `T_Projectile10`
- 底部状态栏显示当前目录共有 `433 items (1 selected)`

这张图支持的复现结论是：`MagicProjectiles` 的飞行头部和拖尾外观并不是固定死的，而是通过 `Textures/Shapes` 中的一组 `Projectile` / `Muzzle` 形状贴图持续试验；本帧显示作者正在用这些形状资源直接对照最终镜头效果。
这张图继续保持飞行阶段的最终镜头预览，同时在 `VFX_Library > Textures > Shapes` 中浏览另一屏形状贴图。和上一张相比，底部缩略图已经切换到更明显的圆斑、心形、星芒、破碎环和放射状 flare 轮廓，说明作者在快速横向比较不同形状对投射物头部亮点的影响。

关卡画面中的稳定结果：
- 三道投射物仍从左向右飞行，前端高亮源点持续可见
- 圆柱目标仍在右侧等待被击中
- 地面反射主要由前端亮点驱动，说明“头部形状”对整体读感影响很大

当前形状贴图浏览状态：
- 当前目录仍是 `Content > VFX_Library > Textures > Shapes`
- 可见的缩略图从上一张的长条/弹头形，切换为更多图标化轮廓，例如：
  - 大小不同的圆斑/高光核
  - 心形轮廓
  - 多瓣星芒
  - 破碎圆环
  - 放射状 flare / 爆点纹样
- 底部状态栏仍显示 `433 items (1 selected)`

这张图支持的复现结论是：教程在这一段并不是只挑一种贴图，而是通过在 `Shapes` 库中快速切换不同的亮点/爆点轮廓，直接观察哪一种更适合作为 `MagicProjectiles` 飞行阶段的前端发光形状。
这张图继续在 `VFX_Library > Textures > Shapes` 中筛选飞行头部的形状贴图，但这次鼠标悬停在某一张资源上，右侧弹出了贴图详情气泡。因此这张图除了说明作者仍在比较形状，也能补充贴图资源的实际导入规格。

关卡画面中的结果状态没有变化：
- 角色仍从左侧发射三道紫粉色投射物
- 前端亮点明显，圆柱仍未被击中
- 当前仍是“飞行阶段头部形状”调试，而不是命中阶段

纹理浏览区可确认的信息：
- 当前目录仍是 `Content > VFX_Library > Textures > Shapes`
- 当前屏幕上的缩略图主要是圆环、花瓣状 flare、放射纹、星芒等高对比形状
- 鼠标悬停的资源名可见为 `T_Burst027`（气泡标题中显示，后缀括号中的类型为 `Texture`）

悬停气泡中可确认的资源元数据：
- 路径位于 `.../VFX_Library/Textures/Shapes`
- `Dimensions = 1024 x 1024`
- `Format = B8G8R8A8`
- `Has Alpha Channel = False`
- `LODBias = 0`
- `Texture Group = World`
- `Never Stream = False`
- `Power Of Two Mode = None`

这张图支持的复现结论是：教程在挑选飞行头部贴图时，不只是看缩略图外观，也会直接查看具体纹理资源的规格；当前被检查的候选之一是 `T_Burst027`，它是 `1024x1024` 的方形形状贴图，适合作为高亮爆点/星芒类轮廓的候选资源。

## 补充视觉证据

### S01 00:02:46

这是 `NS_MagicProjectiles_Impact` 的补充总览图。画面没有展开某个参数面板，而是把 `SceneBlurImpact`、`Shockwave_Start`、`Shockwave_Multiple` 三个命中相关发射器并排展示出来。字幕“我们就在这里关掉它”说明作者此时正在比较这些命中层里哪一个应该被禁用或保留，用于精简最终效果。

系统视图中可直接确认的发射器结构如下：
- `SceneBlurImpact`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
  - `Particle Update`
  - `Render`
- `Shockwave_Start`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Camera Offset`
    - `Shape Location Sphere`
    - `Initial Mesh Orientation`
  - `Particle Update`
    - `Particle State`
    - `Scale Mesh Size`
    - `Scale Color`
    - `Dynamic Material Parameters`
  - `Render`
    - `Mesh Renderer`
- `Shockwave_Multiple`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Camera Offset`
    - `Shape Location Sphere`
    - `Initial Mesh Orientation`
  - `Particle Update`
    - `Particle State`
    - `Scale Mesh Size`
    - `Scale Color`
    - `Dynamic Material Parameters`
  - `Render`
    - `Mesh Renderer`

当前可见的状态信息：
- `Shockwave_Start` 和 `Shockwave_Multiple` 都处于同一系统中，可直接横向比较
- 两者在模块结构上几乎一致，说明区别更可能来自启用状态、参数值或使用场景，而不是发射器框架本身
- 时间轴下方可见本系统同时还包含 `Background_Purple`、`Flare`、`Flare_Multiple`、`Flare_Start`、`GlowCenter_Multiple` 等轨道

这张补充图能支持的复现结论是：在 `MagicProjectiles_Impact` 的最终整理阶段，教程会直接在系统总览里对多个命中发射器进行取舍；至少从图中可以确认，作者正在比较 `Shockwave_Start` 与 `Shockwave_Multiple` 这两层网格冲击波，并准备关闭其中一层或某个相关效果层。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

